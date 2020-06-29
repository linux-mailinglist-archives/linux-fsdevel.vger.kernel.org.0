Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5202220E366
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jun 2020 00:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388437AbgF2VNn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Jun 2020 17:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730125AbgF2S5n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:57:43 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FA30C030792
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jun 2020 08:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=yLdWBBIn6bf/eqVV3H0W8u25tQ4LuV8norvO9QzfHtM=; b=VPdgSJjf66DqDAzKnHgpZf3d8h
        KJKZys2VDk7QjsX1PNzRu2tvSr61eDYH5XIceNVgYXglYrmppstSjRWTUHd/vf0tzIWje3SQbLILJ
        upI3N1LE/I+eYtAULtVfweBlZEaXNjyaaAFvCGTO9u2o1nxkXozEB6scZeJgo3W6yliazlerrFSuI
        V3sY8P92SyJA7AdGmfZMQJYtlvR5hByJE9ZjWqva596M9l2TyqxsIZDc/6rfJyhOdcjepjA7JKn78
        kF8AlVKkCN4kM391T2fXiOSuBeVgu6P0kovMhbI0BVT0ke04ACbJ2a6UPCifgLz/QQKutXORyPN9j
        Tvzn6fOw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jpvaG-0004Ex-5F; Mon, 29 Jun 2020 15:20:36 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>
Subject: [PATCH 1/2] XArray: Add xas_split
Date:   Mon, 29 Jun 2020 16:20:32 +0100
Message-Id: <20200629152033.16175-2-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200629152033.16175-1-willy@infradead.org>
References: <20200629152033.16175-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In order to use multi-index entries for huge pages in the page cache,
we need to be able to split a multi-index entry (eg if a file is
truncated in the middle of a huge page entry).  This version does not
support splitting more than one level of the tree at a time.  This is an
acceptable limitation for the page cache as we do not expect to support
order-12 pages in the near future.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 Documentation/core-api/xarray.rst |  16 ++--
 include/linux/xarray.h            |   2 +
 lib/test_xarray.c                 |  41 ++++++++
 lib/xarray.c                      | 153 ++++++++++++++++++++++++++++--
 4 files changed, 196 insertions(+), 16 deletions(-)

diff --git a/Documentation/core-api/xarray.rst b/Documentation/core-api/xarray.rst
index 640934b6f7b4..a137a0e6d068 100644
--- a/Documentation/core-api/xarray.rst
+++ b/Documentation/core-api/xarray.rst
@@ -475,13 +475,15 @@ or iterations will move the index to the first index in the range.
 Each entry will only be returned once, no matter how many indices it
 occupies.
 
-Using xas_next() or xas_prev() with a multi-index xa_state
-is not supported.  Using either of these functions on a multi-index entry
-will reveal sibling entries; these should be skipped over by the caller.
-
-Storing ``NULL`` into any index of a multi-index entry will set the entry
-at every index to ``NULL`` and dissolve the tie.  Splitting a multi-index
-entry into entries occupying smaller ranges is not yet supported.
+Using xas_next() or xas_prev() with a multi-index xa_state is not
+supported.  Using either of these functions on a multi-index entry will
+reveal sibling entries; these should be skipped over by the caller.
+
+Storing ``NULL`` into any index of a multi-index entry will set the
+entry at every index to ``NULL`` and dissolve the tie.  A multi-index
+entry can be split into entries occupying smaller ranges by calling
+xas_split_alloc() without the xa_lock held, followed by taking the lock
+and calling xas_split().
 
 Functions and structures
 ========================
diff --git a/include/linux/xarray.h b/include/linux/xarray.h
index b4d70e7568b2..fd4364e17632 100644
--- a/include/linux/xarray.h
+++ b/include/linux/xarray.h
@@ -1491,6 +1491,8 @@ static inline bool xas_retry(struct xa_state *xas, const void *entry)
 
 void *xas_load(struct xa_state *);
 void *xas_store(struct xa_state *, void *entry);
+void xas_split(struct xa_state *, void *entry, unsigned int order);
+void xas_split_alloc(struct xa_state *, void *entry, unsigned int order, gfp_t);
 void *xas_find(struct xa_state *, unsigned long max);
 void *xas_find_conflict(struct xa_state *);
 
diff --git a/lib/test_xarray.c b/lib/test_xarray.c
index acf5ccba58b0..282cce959aba 100644
--- a/lib/test_xarray.c
+++ b/lib/test_xarray.c
@@ -1525,6 +1525,46 @@ static noinline void check_store_range(struct xarray *xa)
 	}
 }
 
+#ifdef CONFIG_XARRAY_MULTI
+static void check_split_1(struct xarray *xa, unsigned long index,
+							unsigned int order)
+{
+	XA_STATE_ORDER(xas, xa, index, order);
+	void *entry;
+	unsigned int i = 0;
+
+	xa_store_order(xa, index, order, xa, GFP_KERNEL);
+
+	xas_split_alloc(&xas, xa, 0, GFP_KERNEL);
+	xas_lock(&xas);
+	xas_split(&xas, xa, 0);
+	xas_unlock(&xas);
+
+	xa_for_each(xa, index, entry) {
+		XA_BUG_ON(xa, entry != xa);
+		i++;
+	}
+	XA_BUG_ON(xa, i != 1 << order);
+
+	xa_destroy(xa);
+}
+
+static noinline void check_split(struct xarray *xa)
+{
+	unsigned int order;
+
+	XA_BUG_ON(xa, !xa_empty(xa));
+
+	for (order = 1; order < 2 * XA_CHUNK_SHIFT; order++) {
+		check_split_1(xa, 0, order);
+		check_split_1(xa, 1UL << order, order);
+		check_split_1(xa, 3UL << order, order);
+	}
+}
+#else
+static void check_split(struct xarray *xa) { }
+#endif
+
 static void check_align_1(struct xarray *xa, char *name)
 {
 	int i;
@@ -1730,6 +1770,7 @@ static int xarray_checks(void)
 	check_store_range(&array);
 	check_store_iter(&array);
 	check_align(&xa0);
+	check_split(&array);
 
 	check_workingset(&array, 0);
 	check_workingset(&array, 64);
diff --git a/lib/xarray.c b/lib/xarray.c
index e9e641d3c0c3..faca1ac95b0e 100644
--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -266,13 +266,15 @@ static void xa_node_free(struct xa_node *node)
  */
 static void xas_destroy(struct xa_state *xas)
 {
-	struct xa_node *node = xas->xa_alloc;
+	struct xa_node *next, *node = xas->xa_alloc;
 
-	if (!node)
-		return;
-	XA_NODE_BUG_ON(node, !list_empty(&node->private_list));
-	kmem_cache_free(radix_tree_node_cachep, node);
-	xas->xa_alloc = NULL;
+	while (node) {
+		XA_NODE_BUG_ON(node, !list_empty(&node->private_list));
+		next = rcu_dereference_raw(node->parent);
+		/* XXX: need to free children */
+		kmem_cache_free(radix_tree_node_cachep, node);
+		xas->xa_alloc = node = next;
+	}
 }
 
 /**
@@ -304,6 +306,7 @@ bool xas_nomem(struct xa_state *xas, gfp_t gfp)
 	xas->xa_alloc = kmem_cache_alloc(radix_tree_node_cachep, gfp);
 	if (!xas->xa_alloc)
 		return false;
+	xas->xa_alloc->parent = NULL;
 	XA_NODE_BUG_ON(xas->xa_alloc, !list_empty(&xas->xa_alloc->private_list));
 	xas->xa_node = XAS_RESTART;
 	return true;
@@ -339,6 +342,7 @@ static bool __xas_nomem(struct xa_state *xas, gfp_t gfp)
 	}
 	if (!xas->xa_alloc)
 		return false;
+	xas->xa_alloc->parent = NULL;
 	XA_NODE_BUG_ON(xas->xa_alloc, !list_empty(&xas->xa_alloc->private_list));
 	xas->xa_node = XAS_RESTART;
 	return true;
@@ -403,7 +407,7 @@ static unsigned long xas_size(const struct xa_state *xas)
 /*
  * Use this to calculate the maximum index that will need to be created
  * in order to add the entry described by @xas.  Because we cannot store a
- * multiple-index entry at index 0, the calculation is a little more complex
+ * multi-index entry at index 0, the calculation is a little more complex
  * than you might expect.
  */
 static unsigned long xas_max(struct xa_state *xas)
@@ -946,6 +950,137 @@ void xas_init_marks(const struct xa_state *xas)
 }
 EXPORT_SYMBOL_GPL(xas_init_marks);
 
+#ifdef CONFIG_XARRAY_MULTI
+static unsigned int node_get_marks(struct xa_node *node, unsigned int offset)
+{
+	unsigned int marks = 0;
+	xa_mark_t mark = XA_MARK_0;
+
+	for (;;) {
+		if (node_get_mark(node, offset, mark))
+			marks |= 1 << (__force unsigned int)mark;
+		if (mark == XA_MARK_MAX)
+			break;
+		mark_inc(mark);
+	}
+
+	return marks;
+}
+
+static void node_set_marks(struct xa_node *node, unsigned int offset,
+			struct xa_node *child, unsigned int marks)
+{
+	xa_mark_t mark = XA_MARK_0;
+
+	for (;;) {
+		if (marks & (1 << (__force unsigned int)mark))
+			node_set_mark(node, offset, mark);
+		if (child)
+			node_mark_all(child, mark);
+		if (mark == XA_MARK_MAX)
+			break;
+		mark_inc(mark);
+	}
+}
+
+void xas_split_alloc(struct xa_state *xas, void *entry, unsigned int order,
+		gfp_t gfp)
+{
+	unsigned int sibs = xas->xa_sibs;
+	unsigned int mask = (1 << (order % XA_CHUNK_SHIFT)) - 1;
+
+	/* XXX: no support for splitting really large entries yet */
+	if (WARN_ON(order + XA_CHUNK_SHIFT < xas->xa_shift))
+		goto nomem;
+	if (xas->xa_shift <= order)
+		return;
+
+	do {
+		unsigned int i;
+		void *sibling;
+		struct xa_node *node;
+
+		node = kmem_cache_alloc(radix_tree_node_cachep, gfp);
+		if (!node)
+			goto nomem;
+		node->array = xas->xa;
+		for (i = 0; i < XA_CHUNK_SIZE; i++) {
+			if ((i & mask) == 0) {
+				RCU_INIT_POINTER(node->slots[i], entry);
+				sibling = xa_mk_sibling(0);
+			} else {
+				RCU_INIT_POINTER(node->slots[i], sibling);
+			}
+		}
+		RCU_INIT_POINTER(node->parent, xas->xa_alloc);
+		xas->xa_alloc = node;
+	} while (sibs-- > 0);
+
+	return;
+nomem:
+	xas_destroy(xas);
+	xas_set_err(xas, -ENOMEM);
+}
+
+/**
+ * xas_split() - Split a multi-index entry into smaller entries.
+ * @xas: XArray operation state.
+ * @entry: New entry to store in the array.
+ * @order: New entry order.
+ *
+ * The value in the entry is copied to all the replacement entries.
+ *
+ * Context: Any context.  The caller should hold the xa_lock.
+ */
+void xas_split(struct xa_state *xas, void *entry, unsigned int order)
+{
+	unsigned int offset, marks;
+	struct xa_node *node;
+	void *curr = xas_load(xas);
+	int values = 0;
+
+	node = xas->xa_node;
+	if (xas_top(node))
+		return;
+
+	marks = node_get_marks(node, xas->xa_offset);
+
+	offset = xas->xa_offset + xas->xa_sibs;
+	do {
+		if (order < node->shift) {
+			struct xa_node *child = xas->xa_alloc;
+
+			xas->xa_alloc = rcu_dereference_raw(child->parent);
+			child->shift = node->shift - XA_CHUNK_SHIFT;
+			child->offset = offset;
+			child->count = XA_CHUNK_SIZE;
+			child->nr_values = xa_is_value(entry) ?
+					XA_CHUNK_SIZE : 0;
+			RCU_INIT_POINTER(child->parent, node);
+			node_set_marks(node, offset, child, marks);
+			rcu_assign_pointer(node->slots[offset],
+					xa_mk_node(child));
+			if (xa_is_value(curr))
+				values--;
+		} else {
+			unsigned int canon = offset -
+					(1 << (order % XA_CHUNK_SHIFT)) + 1;
+
+			node_set_marks(node, canon, NULL, marks);
+			rcu_assign_pointer(node->slots[canon], entry);
+			while (offset > canon)
+				rcu_assign_pointer(node->slots[offset--],
+						xa_mk_sibling(canon));
+			values += (xa_is_value(entry) - xa_is_value(curr)) *
+					(1 << (order % XA_CHUNK_SHIFT));
+		}
+	} while (offset-- > xas->xa_offset);
+
+	node->nr_values += values;
+}
+EXPORT_SYMBOL_GPL(xas_split);
+#endif
+
 /**
  * xas_pause() - Pause a walk to drop a lock.
  * @xas: XArray operation state.
@@ -1407,7 +1542,7 @@ EXPORT_SYMBOL(__xa_store);
  * @gfp: Memory allocation flags.
  *
  * After this function returns, loads from this index will return @entry.
- * Storing into an existing multislot entry updates the entry of every index.
+ * Storing into an existing multi-index entry updates the entry of every index.
  * The marks associated with @index are unaffected unless @entry is %NULL.
  *
  * Context: Any context.  Takes and releases the xa_lock.
@@ -1549,7 +1684,7 @@ static void xas_set_range(struct xa_state *xas, unsigned long first,
  *
  * After this function returns, loads from any index between @first and @last,
  * inclusive will return @entry.
- * Storing into an existing multislot entry updates the entry of every index.
+ * Storing into an existing multi-index entry updates the entry of every index.
  * The marks associated with @index are unaffected unless @entry is %NULL.
  *
  * Context: Process context.  Takes and releases the xa_lock.  May sleep
-- 
2.27.0

