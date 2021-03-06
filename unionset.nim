type
  WeightedUnionSet*[N: static[int]] = object
    data*: array[N, int]
    size*: array[N, int]
    count: int

proc newWeightedUnionSet*[N: static[int]](): WeightedUnionSet[N] =
  result.count = N
  for i in 0 ..< N:
    result.data[i] = i
    result.size[i] = 1

proc count*(w: WeightedUnionSet): int =
  w.count

proc find*(w: WeightedUnionSet;p: int): int = 
  var p = p
  while w.data[p] != p:
    p = w.data[p]
  return p

proc connected*(w: WeightedUnionSet;p, q: int): bool =
  find(w, p) == find(w, q)

proc union*(w:var WeightedUnionSet;p, q: int) =
  let 
    i = find(w, p)
    j = find(w, q)
  if i == j: return
  if w.size[i] < w.size[j]:
    w.data[i] = j
    w.size[j] += w.size[i]
  else:
    w.data[j] = i
    w.size[i] += w.size[j]
  w.count -= 1

proc `$`(w: WeightedUnionSet): string =
  $w.data


when isMainModule:
  var w = newWeightedUnionSet[8]()
  echo w.count
  w.union(0, 1)
  w.union(2, 3)
  w.union(4, 5)
  w.union(6, 7)
  w.union(0, 2)
  w.union(4, 6)
  w.union(0, 4)
  echo w
  echo w.count
