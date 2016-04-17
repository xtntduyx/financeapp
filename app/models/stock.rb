class Stock < ActiveRecord::Base
  def self.find_by_ticker(ticker_symbol)
  	where(ticker: ticker_symbol).first
  end


  def self.new_from_lookup(ticker_symbol)
  	looked_up_stock = StockQuote::Stock.quote(ticker_symbol)
  	return nil unless looked_up_stock.name

  	newstock = new(ticker: looked_up_stock.symbol, name: looked_up_stock.name)
  	newstock.last_price = newstock.price 
  	newstock

  end

  def price
  	closing_price = StockQuote::Stock.quote(ticker).close
  	return "#{closing_price} (Closing)" if  closing_price

  	opening_price = StockQuote::Stock.quote(ticker).open
  	return "#{opening_price} (Opening)" if  opening_price

  	"Unavailabe"

  end




end
