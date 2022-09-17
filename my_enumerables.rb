module Enumerable
  # Your code goes here
end

# You will first have to define my_each
# on the Array class. Methods defined in
# your enumerable module will have access
# to this method
class Array
  # Define my_each here
  def my_each
    if block_given?
      for item in self
        yield item
      end
      return self
    end
  end

  def my_each_with_index
    i = 0
    if block_given?
      for item in self
        yield item, i
        i += 1
      end
      return self
    else 
      return to_enum
    end
  end

  def my_select
    out = []
    if block_given?
      my_each { |item| out << item if yield item}
    end
    p out
  end

  def my_all?
    if block_given?
      my_each { |item| return false unless yield item }
    else 
      for item in self
        return false unless item 
      end
    end
    true
  end

  def my_any?
    if block_given?
      my_each { |item| return true if yield item}
    else 
      for item in self
        return true if item
      end
    end
    false
  end

  def my_none?
    if block_given?
      my_each { |item| return false if yield item }
    else 
      for item in self
        return false if item 
      end
    end
    true
  end

  def my_count
    return size unless block_given?
      counter = 0
      my_each { |item| counter += 1 if yield item }
      counter
  end

  def my_map(a_proc=nil)
    out=[]
    if a_proc
      self.my_each { |item| out.push(a_proc.call(item)) }
      out
    end
    self.my_each { |item| out.push(yield item) }
    out
  end

  def my_inject(counter, &block)
    self.class == Range ? array = self.to_a : array = self
    if block_given?
      if counter.nil?
        counter = self.first
        for i in 0..self.length-2
          counter = block.call(counter, array[i+1])
        end
      elsif counter
        for i in 0..self.length-1
          counter = block.call(counter, array[i])
        end
      end
    end
    counter
  end


end
