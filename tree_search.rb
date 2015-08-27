class Node

	attr_accessor :parent, :children
	attr_reader :value

	def initialize(value, parent = nil, children = [])
		@value = value
		@parent = parent
		@children = children
	end

end


def build_tree(node_array)
	puts "Input node array= #{node_array}"
	node_array.shuffle!
	puts "Shuffled node array = #{node_array}"
	a = Node.new(node_array.pop)
	puts "a = #{a.value}"

	node_array.each do |node|
		node = Node.new(node)
		puts "node to enter = #{node.value}"
		sort(a, node)
	end
	a
end


def sort(top_node, new_node)
	if new_node.value > top_node.value
		if top_node.children[1].nil?
			top_node.children[1] = new_node
			new_node.parent = top_node
			puts "Entering the relatinship of top node = #{top_node.value}, right side child node = #{new_node.value}"
		else
			return sort(top_node.children[1], new_node)
		end
	else
		if top_node.children[0].nil?
			top_node.children[0] = new_node
			new_node.parent = top_node
			puts "Entering the relationship of top node = #{top_node.value}, left side child node = #{new_node.value}"
		else
			return sort(top_node.children[0], new_node)
		end
	end
end

def breadth_first_search(target, node, queue = [])
	return node.value if target == node.value
	queue << node.children[0] if !node.children[0].nil?
	queue << node.children[1] if !node.children[1].nil?
	return nil if queue.empty?
	return breadth_first_search(target, queue[0], queue[1..-1])
end

def depth_first_search(target, node, queue = [])
	return node.value if target == node.value
	queue.push(node.children[0]) if !node.children[0].nil?
	queue.push(node.children[1]) if !node.children[1].nil?
	return nil if queue.empty?
	return depth_first_search(target, queue[0], queue[1..-1])
end

def dfs_rec(target, node)
	puts "starting node = #{node.value}"
	puts 
	if target == node.value
		return node.value
	else
		left_tree = dfs_rec(target, node.children[0]) if !node.children[0].nil?
		return left_tree if !left_tree.nil? && left_tree == target
		right_tree = dfs_rec(target, node.children[1]) if !node.children[1].nil?
		return right_tree if !right_tree.nil? && right_tree == target
		return nil
	end
end
	





test_data = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]

binary_tree = build_tree(test_data)

puts binary_tree

puts breadth_first_search(324, binary_tree)

puts depth_first_search(324, binary_tree)

puts dfs_rec(324, binary_tree)
puts dfs_rec(325, binary_tree)

