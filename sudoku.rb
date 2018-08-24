require_relative "board"

# People write terrible method names in real life.
# On the job, it is your job to figure out how the methods work and then name them better.
# Do this now.

class SudokuGame
  def self.from_file(filename)
    board = Board.from_file(filename)
    self.new(board)
  end

  def initialize(board)
    @board = board
  end

  def get_position
    pos = nil
    until pos && is_pos_valid?(pos)
      puts "Please enter a position on the board (e.g., '3,4')"
      print "> "

      begin
        pos = parse_position(gets.chomp)
      rescue
        puts "Invalid position entered (did you use a comma?)"
        puts ""

        pos = nil
      end
    end
    pos
  end

  def get_value
    val = nil
    until val && is_val_valid?(val)
      puts "Please enter a value between 1 and 9 (0 to clear the tile)"
      print "> "
      val = parse_value(gets.chomp)
    end
    val
  end

  def parse_position(pos)
    pos.split(",").map { |coord| Integer(coord) }
  end

  def parse_value(val)
    Integer(val)
  end

  def play_turn
    board.render
    pos = get_position
    val = get_value
    board[pos] = val
  end

  def play
    play_turn until over?
    puts "Congratulations, you win!"
  end

  def over?
    board.won?
  end

  def is_pos_valid?(pos)
    pos.is_a?(Array) &&
      pos.length == 2 &&
      pos.all? { |x| x.between?(0, board.size - 1) }
  end

  def is_val_valid?(val)
    val.is_a?(Integer) &&
      val.between?(0, 9)
  end

  private
  attr_reader :board
end


game = SudokuGame.from_file("puzzles/sudoku1.txt")
game.play
