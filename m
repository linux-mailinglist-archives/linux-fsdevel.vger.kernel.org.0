Return-Path: <linux-fsdevel+bounces-32729-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAA539AE60C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 15:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 438C41F25EAA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 13:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263701E377C;
	Thu, 24 Oct 2024 13:23:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BCC1E3768;
	Thu, 24 Oct 2024 13:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729776185; cv=none; b=orbwXdVttQTzfANWU95Obx3bEp7QQevOA+FBZoWBE4YIJHbTVD7DSWycM/F7oRFpYRSRA5nXnYCtVM7OGLA7RflCDWtZEpvpaMMTwn6Tq/3nW7Vi4SoQkh9f66PNIwKww7FIWWUE/gpTvYlkQKjBd9uE2r01y5EYTYDyBY5F40c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729776185; c=relaxed/simple;
	bh=OFXPLefrKlnfPsFfqTAHG0j/P6Pb2+lUlyP9HeeKvow=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Cmugzu85Smnrd5GJbemmYXKfoo2bibU+/lfIluxoiHBoiwjxoYrbSXOJcs8M3WvN4qFOZZPsgLtMd24jy7sX22v4XjdJQrdHEcnkQ+bKn9nykRybde+0Wfhh8148cmizFsILeqjftD3Q39Ndd9UcZSrqgaHdjwZzqXK7oFUTpuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XZ66F59D5z4f3kp7;
	Thu, 24 Oct 2024 21:22:45 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 16B3C1A0196;
	Thu, 24 Oct 2024 21:22:58 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgCHusYpShpn7tb6Ew--.444S7;
	Thu, 24 Oct 2024 21:22:57 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	Liam.Howlett@oracle.com,
	akpm@linux-foundation.org,
	hughd@google.com,
	willy@infradead.org,
	sashal@kernel.org,
	srinivasan.shanmugam@amd.com,
	chiahsuan.chung@amd.com,
	mingo@kernel.org,
	mgorman@techsingularity.net,
	yukuai3@huawei.com,
	chengming.zhou@linux.dev,
	zhangpeng.00@bytedance.com,
	chuck.lever@oracle.com
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	maple-tree@lists.infradead.org,
	linux-mm@kvack.org,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH 6.6 03/28] maple_tree: introduce interfaces __mt_dup() and mtree_dup()
Date: Thu, 24 Oct 2024 21:19:44 +0800
Message-Id: <20241024132009.2267260-4-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241024132009.2267260-1-yukuai1@huaweicloud.com>
References: <20241024132009.2267260-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCHusYpShpn7tb6Ew--.444S7
X-Coremail-Antispam: 1UD129KBjvAXoW3Zw1xWw13WFW7Gw4xAryUGFg_yoW8GF45Go
	Z2yr45Xw1vkryUuF40kas7GF1a93ykWr18J398ta1jgFyYyr1j93y7u3Z3JasYyFs5CF17
	Zw1xX3yDKFWxt3s8n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUOI7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20EY4v20xva
	j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r1rM28IrcIa0x
	kI8VCY1x0267AKxVW5JVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84AC
	jcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr
	1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1l
	e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI
	8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwAC
	jcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0x
	kIwI1lc7CjxVAaw2AFwI0_Wrv_ZF1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
	AY17CE14v26rWY6r4UJwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
	CI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsG
	vfC2KfnxnUUI43ZEXa7sREfHUDUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Peng Zhang <zhangpeng.00@bytedance.com>

commit fd32e4e9b7646510ee9010e0d5f8b8857d48a6f7 upstream.

Introduce interfaces __mt_dup() and mtree_dup(), which are used to
duplicate a maple tree.  They duplicate a maple tree in Depth-First Search
(DFS) pre-order traversal.  It uses memcopy() to copy nodes in the source
tree and allocate new child nodes in non-leaf nodes.  The new node is
exactly the same as the source node except for all the addresses stored in
it.  It will be faster than traversing all elements in the source tree and
inserting them one by one into the new tree.  The time complexity of these
two functions is O(n).

The difference between __mt_dup() and mtree_dup() is that mtree_dup()
handles locks internally.

Analysis of the average time complexity of this algorithm:

For simplicity, let's assume that the maximum branching factor of all
non-leaf nodes is 16 (in allocation mode, it is 10), and the tree is a
full tree.

Under the given conditions, if there is a maple tree with n elements, the
number of its leaves is n/16.  From bottom to top, the number of nodes in
each level is 1/16 of the number of nodes in the level below.  So the
total number of nodes in the entire tree is given by the sum of n/16 +
n/16^2 + n/16^3 + ...  + 1.  This is a geometric series, and it has log(n)
terms with base 16.  According to the formula for the sum of a geometric
series, the sum of this series can be calculated as (n-1)/15.  Each node
has only one parent node pointer, which can be considered as an edge.  In
total, there are (n-1)/15-1 edges.

This algorithm consists of two operations:

1. Traversing all nodes in DFS order.
2. For each node, making a copy and performing necessary modifications
   to create a new node.

For the first part, DFS traversal will visit each edge twice.  Let
T(ascend) represent the cost of taking one step downwards, and T(descend)
represent the cost of taking one step upwards.  And both of them are
constants (although mas_ascend() may not be, as it contains a loop, but
here we ignore it and treat it as a constant).  So the time spent on the
first part can be represented as ((n-1)/15-1) * (T(ascend) + T(descend)).

For the second part, each node will be copied, and the cost of copying a
node is denoted as T(copy_node).  For each non-leaf node, it is necessary
to reallocate all child nodes, and the cost of this operation is denoted
as T(dup_alloc).  The behavior behind memory allocation is complex and not
specific to the maple tree operation.  Here, we assume that the time
required for a single allocation is constant.  Since the size of a node is
fixed, both of these symbols are also constants.  We can calculate that
the time spent on the second part is ((n-1)/15) * T(copy_node) + ((n-1)/15
- n/16) * T(dup_alloc).

Adding both parts together, the total time spent by the algorithm can be
represented as:

((n-1)/15) * (T(ascend) + T(descend) + T(copy_node) + T(dup_alloc)) -
n/16 * T(dup_alloc) - (T(ascend) + T(descend))

Let C1 = T(ascend) + T(descend) + T(copy_node) + T(dup_alloc)
Let C2 = T(dup_alloc)
Let C3 = T(ascend) + T(descend)

Finally, the expression can be simplified as:
((16 * C1 - 15 * C2) / (15 * 16)) * n - (C1 / 15 + C3).

This is a linear function, so the average time complexity is O(n).

Link: https://lkml.kernel.org/r/20231027033845.90608-4-zhangpeng.00@bytedance.com
Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
Suggested-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Mateusz Guzik <mjguzik@gmail.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Mike Christie <michael.christie@oracle.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 include/linux/maple_tree.h |   3 +
 lib/maple_tree.c           | 274 +++++++++++++++++++++++++++++++++++++
 2 files changed, 277 insertions(+)

diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
index f91dbc7fe091..a452dd8a1e5c 100644
--- a/include/linux/maple_tree.h
+++ b/include/linux/maple_tree.h
@@ -329,6 +329,9 @@ int mtree_store(struct maple_tree *mt, unsigned long index,
 		void *entry, gfp_t gfp);
 void *mtree_erase(struct maple_tree *mt, unsigned long index);
 
+int mtree_dup(struct maple_tree *mt, struct maple_tree *new, gfp_t gfp);
+int __mt_dup(struct maple_tree *mt, struct maple_tree *new, gfp_t gfp);
+
 void mtree_destroy(struct maple_tree *mt);
 void __mt_destroy(struct maple_tree *mt);
 
diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index e7228bb86ef6..6f1addbbc820 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4,6 +4,8 @@
  * Copyright (c) 2018-2022 Oracle Corporation
  * Authors: Liam R. Howlett <Liam.Howlett@oracle.com>
  *	    Matthew Wilcox <willy@infradead.org>
+ * Copyright (c) 2023 ByteDance
+ * Author: Peng Zhang <zhangpeng.00@bytedance.com>
  */
 
 /*
@@ -6486,6 +6488,278 @@ void *mtree_erase(struct maple_tree *mt, unsigned long index)
 }
 EXPORT_SYMBOL(mtree_erase);
 
+/*
+ * mas_dup_free() - Free an incomplete duplication of a tree.
+ * @mas: The maple state of a incomplete tree.
+ *
+ * The parameter @mas->node passed in indicates that the allocation failed on
+ * this node. This function frees all nodes starting from @mas->node in the
+ * reverse order of mas_dup_build(). There is no need to hold the source tree
+ * lock at this time.
+ */
+static void mas_dup_free(struct ma_state *mas)
+{
+	struct maple_node *node;
+	enum maple_type type;
+	void __rcu **slots;
+	unsigned char count, i;
+
+	/* Maybe the first node allocation failed. */
+	if (mas_is_none(mas))
+		return;
+
+	while (!mte_is_root(mas->node)) {
+		mas_ascend(mas);
+		if (mas->offset) {
+			mas->offset--;
+			do {
+				mas_descend(mas);
+				mas->offset = mas_data_end(mas);
+			} while (!mte_is_leaf(mas->node));
+
+			mas_ascend(mas);
+		}
+
+		node = mte_to_node(mas->node);
+		type = mte_node_type(mas->node);
+		slots = ma_slots(node, type);
+		count = mas_data_end(mas) + 1;
+		for (i = 0; i < count; i++)
+			((unsigned long *)slots)[i] &= ~MAPLE_NODE_MASK;
+		mt_free_bulk(count, slots);
+	}
+
+	node = mte_to_node(mas->node);
+	mt_free_one(node);
+}
+
+/*
+ * mas_copy_node() - Copy a maple node and replace the parent.
+ * @mas: The maple state of source tree.
+ * @new_mas: The maple state of new tree.
+ * @parent: The parent of the new node.
+ *
+ * Copy @mas->node to @new_mas->node, set @parent to be the parent of
+ * @new_mas->node. If memory allocation fails, @mas is set to -ENOMEM.
+ */
+static inline void mas_copy_node(struct ma_state *mas, struct ma_state *new_mas,
+		struct maple_pnode *parent)
+{
+	struct maple_node *node = mte_to_node(mas->node);
+	struct maple_node *new_node = mte_to_node(new_mas->node);
+	unsigned long val;
+
+	/* Copy the node completely. */
+	memcpy(new_node, node, sizeof(struct maple_node));
+	/* Update the parent node pointer. */
+	val = (unsigned long)node->parent & MAPLE_NODE_MASK;
+	new_node->parent = ma_parent_ptr(val | (unsigned long)parent);
+}
+
+/*
+ * mas_dup_alloc() - Allocate child nodes for a maple node.
+ * @mas: The maple state of source tree.
+ * @new_mas: The maple state of new tree.
+ * @gfp: The GFP_FLAGS to use for allocations.
+ *
+ * This function allocates child nodes for @new_mas->node during the duplication
+ * process. If memory allocation fails, @mas is set to -ENOMEM.
+ */
+static inline void mas_dup_alloc(struct ma_state *mas, struct ma_state *new_mas,
+		gfp_t gfp)
+{
+	struct maple_node *node = mte_to_node(mas->node);
+	struct maple_node *new_node = mte_to_node(new_mas->node);
+	enum maple_type type;
+	unsigned char request, count, i;
+	void __rcu **slots;
+	void __rcu **new_slots;
+	unsigned long val;
+
+	/* Allocate memory for child nodes. */
+	type = mte_node_type(mas->node);
+	new_slots = ma_slots(new_node, type);
+	request = mas_data_end(mas) + 1;
+	count = mt_alloc_bulk(gfp, request, (void **)new_slots);
+	if (unlikely(count < request)) {
+		memset(new_slots, 0, request * sizeof(void *));
+		mas_set_err(mas, -ENOMEM);
+		return;
+	}
+
+	/* Restore node type information in slots. */
+	slots = ma_slots(node, type);
+	for (i = 0; i < count; i++) {
+		val = (unsigned long)mt_slot_locked(mas->tree, slots, i);
+		val &= MAPLE_NODE_MASK;
+		((unsigned long *)new_slots)[i] |= val;
+	}
+}
+
+/*
+ * mas_dup_build() - Build a new maple tree from a source tree
+ * @mas: The maple state of source tree, need to be in MAS_START state.
+ * @new_mas: The maple state of new tree, need to be in MAS_START state.
+ * @gfp: The GFP_FLAGS to use for allocations.
+ *
+ * This function builds a new tree in DFS preorder. If the memory allocation
+ * fails, the error code -ENOMEM will be set in @mas, and @new_mas points to the
+ * last node. mas_dup_free() will free the incomplete duplication of a tree.
+ *
+ * Note that the attributes of the two trees need to be exactly the same, and the
+ * new tree needs to be empty, otherwise -EINVAL will be set in @mas.
+ */
+static inline void mas_dup_build(struct ma_state *mas, struct ma_state *new_mas,
+		gfp_t gfp)
+{
+	struct maple_node *node;
+	struct maple_pnode *parent = NULL;
+	struct maple_enode *root;
+	enum maple_type type;
+
+	if (unlikely(mt_attr(mas->tree) != mt_attr(new_mas->tree)) ||
+	    unlikely(!mtree_empty(new_mas->tree))) {
+		mas_set_err(mas, -EINVAL);
+		return;
+	}
+
+	root = mas_start(mas);
+	if (mas_is_ptr(mas) || mas_is_none(mas))
+		goto set_new_tree;
+
+	node = mt_alloc_one(gfp);
+	if (!node) {
+		new_mas->node = MAS_NONE;
+		mas_set_err(mas, -ENOMEM);
+		return;
+	}
+
+	type = mte_node_type(mas->node);
+	root = mt_mk_node(node, type);
+	new_mas->node = root;
+	new_mas->min = 0;
+	new_mas->max = ULONG_MAX;
+	root = mte_mk_root(root);
+	while (1) {
+		mas_copy_node(mas, new_mas, parent);
+		if (!mte_is_leaf(mas->node)) {
+			/* Only allocate child nodes for non-leaf nodes. */
+			mas_dup_alloc(mas, new_mas, gfp);
+			if (unlikely(mas_is_err(mas)))
+				return;
+		} else {
+			/*
+			 * This is the last leaf node and duplication is
+			 * completed.
+			 */
+			if (mas->max == ULONG_MAX)
+				goto done;
+
+			/* This is not the last leaf node and needs to go up. */
+			do {
+				mas_ascend(mas);
+				mas_ascend(new_mas);
+			} while (mas->offset == mas_data_end(mas));
+
+			/* Move to the next subtree. */
+			mas->offset++;
+			new_mas->offset++;
+		}
+
+		mas_descend(mas);
+		parent = ma_parent_ptr(mte_to_node(new_mas->node));
+		mas_descend(new_mas);
+		mas->offset = 0;
+		new_mas->offset = 0;
+	}
+done:
+	/* Specially handle the parent of the root node. */
+	mte_to_node(root)->parent = ma_parent_ptr(mas_tree_parent(new_mas));
+set_new_tree:
+	/* Make them the same height */
+	new_mas->tree->ma_flags = mas->tree->ma_flags;
+	rcu_assign_pointer(new_mas->tree->ma_root, root);
+}
+
+/**
+ * __mt_dup(): Duplicate an entire maple tree
+ * @mt: The source maple tree
+ * @new: The new maple tree
+ * @gfp: The GFP_FLAGS to use for allocations
+ *
+ * This function duplicates a maple tree in Depth-First Search (DFS) pre-order
+ * traversal. It uses memcpy() to copy nodes in the source tree and allocate
+ * new child nodes in non-leaf nodes. The new node is exactly the same as the
+ * source node except for all the addresses stored in it. It will be faster than
+ * traversing all elements in the source tree and inserting them one by one into
+ * the new tree.
+ * The user needs to ensure that the attributes of the source tree and the new
+ * tree are the same, and the new tree needs to be an empty tree, otherwise
+ * -EINVAL will be returned.
+ * Note that the user needs to manually lock the source tree and the new tree.
+ *
+ * Return: 0 on success, -ENOMEM if memory could not be allocated, -EINVAL If
+ * the attributes of the two trees are different or the new tree is not an empty
+ * tree.
+ */
+int __mt_dup(struct maple_tree *mt, struct maple_tree *new, gfp_t gfp)
+{
+	int ret = 0;
+	MA_STATE(mas, mt, 0, 0);
+	MA_STATE(new_mas, new, 0, 0);
+
+	mas_dup_build(&mas, &new_mas, gfp);
+	if (unlikely(mas_is_err(&mas))) {
+		ret = xa_err(mas.node);
+		if (ret == -ENOMEM)
+			mas_dup_free(&new_mas);
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL(__mt_dup);
+
+/**
+ * mtree_dup(): Duplicate an entire maple tree
+ * @mt: The source maple tree
+ * @new: The new maple tree
+ * @gfp: The GFP_FLAGS to use for allocations
+ *
+ * This function duplicates a maple tree in Depth-First Search (DFS) pre-order
+ * traversal. It uses memcpy() to copy nodes in the source tree and allocate
+ * new child nodes in non-leaf nodes. The new node is exactly the same as the
+ * source node except for all the addresses stored in it. It will be faster than
+ * traversing all elements in the source tree and inserting them one by one into
+ * the new tree.
+ * The user needs to ensure that the attributes of the source tree and the new
+ * tree are the same, and the new tree needs to be an empty tree, otherwise
+ * -EINVAL will be returned.
+ *
+ * Return: 0 on success, -ENOMEM if memory could not be allocated, -EINVAL If
+ * the attributes of the two trees are different or the new tree is not an empty
+ * tree.
+ */
+int mtree_dup(struct maple_tree *mt, struct maple_tree *new, gfp_t gfp)
+{
+	int ret = 0;
+	MA_STATE(mas, mt, 0, 0);
+	MA_STATE(new_mas, new, 0, 0);
+
+	mas_lock(&new_mas);
+	mas_lock_nested(&mas, SINGLE_DEPTH_NESTING);
+	mas_dup_build(&mas, &new_mas, gfp);
+	mas_unlock(&mas);
+	if (unlikely(mas_is_err(&mas))) {
+		ret = xa_err(mas.node);
+		if (ret == -ENOMEM)
+			mas_dup_free(&new_mas);
+	}
+
+	mas_unlock(&new_mas);
+	return ret;
+}
+EXPORT_SYMBOL(mtree_dup);
+
 /**
  * __mt_destroy() - Walk and free all nodes of a locked maple tree.
  * @mt: The maple tree
-- 
2.39.2


