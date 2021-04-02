Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A612352DFA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Apr 2021 19:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235341AbhDBRE3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Apr 2021 13:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbhDBRE2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Apr 2021 13:04:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17986C0613E6;
        Fri,  2 Apr 2021 10:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=z94LUPHpaa51HFoVgsD9v9ZdabEEczYPtm4XpU8VGA4=; b=RdzCldIIhZvEXpC6q0Z/8JLdX4
        jhqufBz/uTaOAF/P1cxK3vQEn8ToUFbdziJtT/pMEMu7QCnQ2XM+HRehMsLqHPhdcLPFwynA2JSzx
        xbSKX4IG/3GFZ6+mYvb04QHHgxdzbvwl+sVyuFHWSHsevEL4hzalzsnwYp9tu97WnegUbUVJC35pv
        d/C80VgT7ffhQkNkJpQQiejCnfbaNoT1dYK7z11PgYk8JjgqNJDz4R3B+eITVLaj7P4nUlvOkBaM8
        1TGfsvdaNyc27k1U0A6eS27eMd4bRNAyBcP5K2EM5nk3RV1BBcbsh6xgA9XSdoARsewTzvkDWmMBD
        AnXSQgNw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lSNDS-007tvI-HC; Fri, 02 Apr 2021 17:04:16 +0000
Date:   Fri, 2 Apr 2021 18:04:14 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: BUG_ON(!mapping_empty(&inode->i_data))
Message-ID: <20210402170414.GQ351017@casper.infradead.org>
References: <alpine.LSU.2.11.2103301654520.2648@eggly.anvils>
 <20210331024913.GS351017@casper.infradead.org>
 <alpine.LSU.2.11.2103311413560.1201@eggly.anvils>
 <20210401170615.GH351017@casper.infradead.org>
 <20210402031305.GK351017@casper.infradead.org>
 <20210402132708.GM351017@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210402132708.GM351017@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

OK, more competent testing, and that previous bug now detected and fixed.
I have a reasonable amount of confidence this will solve your problem.
If you do apply this patch, don't enable CONFIG_TEST_XARRAY as the new
tests assume that attempting to allocate with a GFP flags of 0 will
definitely fail, which is true for my userspace allocator, but not true
inside the kernel.  I'll add some ifdeffery to skip these tests inside
the kernel, as without a way to deterministically fail allocation,
there's no way to test this code properly.

diff --git a/lib/test_xarray.c b/lib/test_xarray.c
index 8b1c318189ce..14cbc12bfeca 100644
--- a/lib/test_xarray.c
+++ b/lib/test_xarray.c
@@ -321,12 +321,10 @@ static noinline void check_xa_mark(struct xarray *xa)
 	check_xa_mark_3(xa);
 }
 
-static noinline void check_xa_shrink(struct xarray *xa)
+static noinline void check_xa_shrink_1(struct xarray *xa)
 {
 	XA_STATE(xas, xa, 1);
 	struct xa_node *node;
-	unsigned int order;
-	unsigned int max_order = IS_ENABLED(CONFIG_XARRAY_MULTI) ? 15 : 1;
 
 	XA_BUG_ON(xa, !xa_empty(xa));
 	XA_BUG_ON(xa, xa_store_index(xa, 0, GFP_KERNEL) != NULL);
@@ -349,6 +347,13 @@ static noinline void check_xa_shrink(struct xarray *xa)
 	XA_BUG_ON(xa, xa_load(xa, 0) != xa_mk_value(0));
 	xa_erase_index(xa, 0);
 	XA_BUG_ON(xa, !xa_empty(xa));
+}
+
+static noinline void check_xa_shrink_2(struct xarray *xa)
+{
+	unsigned int order;
+	unsigned int max_order = IS_ENABLED(CONFIG_XARRAY_MULTI) ? 15 : 1;
+	struct xa_node *node;
 
 	for (order = 0; order < max_order; order++) {
 		unsigned long max = (1UL << order) - 1;
@@ -370,6 +375,34 @@ static noinline void check_xa_shrink(struct xarray *xa)
 	}
 }
 
+static noinline void check_xa_shrink_3(struct xarray *xa, int nr,
+		unsigned long anchor, unsigned long newbie)
+{
+	XA_STATE(xas, xa, newbie);
+	int i;
+
+	xa_store_index(xa, anchor, GFP_KERNEL);
+
+	for (i = 0; i < nr; i++) {
+		xas_create(&xas, true);
+		xas_nomem(&xas, GFP_KERNEL);
+	}
+	xas_create(&xas, true);
+	xas_nomem(&xas, 0);
+	XA_BUG_ON(xa, xas_error(&xas) == 0);
+
+	xa_erase_index(xa, anchor);
+	XA_BUG_ON(xa, !xa_empty(xa));
+}
+
+static noinline void check_xa_shrink(struct xarray *xa)
+{
+	check_xa_shrink_1(xa);
+	check_xa_shrink_2(xa);
+	check_xa_shrink_3(xa, 8, 0, 1UL << 31);
+	check_xa_shrink_3(xa, 4, 1UL << 31, 0);
+}
+
 static noinline void check_insert(struct xarray *xa)
 {
 	unsigned long i;
@@ -1463,6 +1496,36 @@ static noinline void check_create_range_4(struct xarray *xa,
 	XA_BUG_ON(xa, !xa_empty(xa));
 }
 
+static noinline void check_create_range_5(struct xarray *xa, void *entry,
+		unsigned long index, unsigned order)
+{
+	XA_STATE_ORDER(xas, xa, index, order);
+	int i = 0;
+	gfp_t gfp = GFP_KERNEL;
+
+	XA_BUG_ON(xa, !xa_empty(xa));
+
+	if (entry)
+		xa_store(xa, xa_to_value(entry), entry, GFP_KERNEL);
+
+	do {
+		xas_lock(&xas);
+		xas_create_range(&xas);
+		xas_unlock(&xas);
+		if (++i == 4)
+			gfp = GFP_NOWAIT;
+	} while (xas_nomem(&xas, gfp));
+
+	if (entry)
+		xa_erase(xa, xa_to_value(entry));
+
+	if (!xas_error(&xas))
+		xa_destroy(xa);
+
+	XA_BUG_ON(xa, xas.xa_alloc);
+	XA_BUG_ON(xa, !xa_empty(xa));
+}
+
 static noinline void check_create_range(struct xarray *xa)
 {
 	unsigned int order;
@@ -1490,6 +1553,24 @@ static noinline void check_create_range(struct xarray *xa)
 		check_create_range_4(xa, (3U << order) + 1, order);
 		check_create_range_4(xa, (3U << order) - 1, order);
 		check_create_range_4(xa, (1U << 24) + 1, order);
+
+		check_create_range_5(xa, NULL, 0, order);
+		check_create_range_5(xa, NULL, (1U << order), order);
+		check_create_range_5(xa, NULL, (2U << order), order);
+		check_create_range_5(xa, NULL, (3U << order), order);
+		check_create_range_5(xa, NULL, (1U << (2 * order)), order);
+
+		check_create_range_5(xa, xa_mk_value(0), 0, order);
+		check_create_range_5(xa, xa_mk_value(0), (1U << order), order);
+		check_create_range_5(xa, xa_mk_value(0), (2U << order), order);
+		check_create_range_5(xa, xa_mk_value(0), (3U << order), order);
+		check_create_range_5(xa, xa_mk_value(0), (1U << (2 * order)), order);
+
+		check_create_range_5(xa, xa_mk_value(1U << order), 0, order);
+		check_create_range_5(xa, xa_mk_value(1U << order), (1U << order), order);
+		check_create_range_5(xa, xa_mk_value(1U << order), (2U << order), order);
+		check_create_range_5(xa, xa_mk_value(1U << order), (3U << order), order);
+		check_create_range_5(xa, xa_mk_value(1U << order), (1U << (2 * order)), order);
 	}
 
 	check_create_range_3();
diff --git a/lib/xarray.c b/lib/xarray.c
index f5d8f54907b4..38a08eb99c7f 100644
--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -276,77 +276,6 @@ static void xas_destroy(struct xa_state *xas)
 	}
 }
 
-/**
- * xas_nomem() - Allocate memory if needed.
- * @xas: XArray operation state.
- * @gfp: Memory allocation flags.
- *
- * If we need to add new nodes to the XArray, we try to allocate memory
- * with GFP_NOWAIT while holding the lock, which will usually succeed.
- * If it fails, @xas is flagged as needing memory to continue.  The caller
- * should drop the lock and call xas_nomem().  If xas_nomem() succeeds,
- * the caller should retry the operation.
- *
- * Forward progress is guaranteed as one node is allocated here and
- * stored in the xa_state where it will be found by xas_alloc().  More
- * nodes will likely be found in the slab allocator, but we do not tie
- * them up here.
- *
- * Return: true if memory was needed, and was successfully allocated.
- */
-bool xas_nomem(struct xa_state *xas, gfp_t gfp)
-{
-	if (xas->xa_node != XA_ERROR(-ENOMEM)) {
-		xas_destroy(xas);
-		return false;
-	}
-	if (xas->xa->xa_flags & XA_FLAGS_ACCOUNT)
-		gfp |= __GFP_ACCOUNT;
-	xas->xa_alloc = kmem_cache_alloc(radix_tree_node_cachep, gfp);
-	if (!xas->xa_alloc)
-		return false;
-	xas->xa_alloc->parent = NULL;
-	XA_NODE_BUG_ON(xas->xa_alloc, !list_empty(&xas->xa_alloc->private_list));
-	xas->xa_node = XAS_RESTART;
-	return true;
-}
-EXPORT_SYMBOL_GPL(xas_nomem);
-
-/*
- * __xas_nomem() - Drop locks and allocate memory if needed.
- * @xas: XArray operation state.
- * @gfp: Memory allocation flags.
- *
- * Internal variant of xas_nomem().
- *
- * Return: true if memory was needed, and was successfully allocated.
- */
-static bool __xas_nomem(struct xa_state *xas, gfp_t gfp)
-	__must_hold(xas->xa->xa_lock)
-{
-	unsigned int lock_type = xa_lock_type(xas->xa);
-
-	if (xas->xa_node != XA_ERROR(-ENOMEM)) {
-		xas_destroy(xas);
-		return false;
-	}
-	if (xas->xa->xa_flags & XA_FLAGS_ACCOUNT)
-		gfp |= __GFP_ACCOUNT;
-	if (gfpflags_allow_blocking(gfp)) {
-		xas_unlock_type(xas, lock_type);
-		xas->xa_alloc = kmem_cache_alloc(radix_tree_node_cachep, gfp);
-		xas_lock_type(xas, lock_type);
-	} else {
-		xas->xa_alloc = kmem_cache_alloc(radix_tree_node_cachep, gfp);
-	}
-	if (!xas->xa_alloc)
-		return false;
-	xas->xa_alloc->parent = NULL;
-	XA_NODE_BUG_ON(xas->xa_alloc, !list_empty(&xas->xa_alloc->private_list));
-	xas->xa_node = XAS_RESTART;
-	return true;
-}
-
 static void xas_update(struct xa_state *xas, struct xa_node *node)
 {
 	if (xas->xa_update)
@@ -551,6 +480,120 @@ static void xas_free_nodes(struct xa_state *xas, struct xa_node *top)
 	}
 }
 
+static bool __xas_trim(struct xa_state *xas)
+{
+	unsigned long index = xas->xa_index;
+	unsigned char shift = xas->xa_shift;
+	unsigned char sibs = xas->xa_sibs;
+
+	xas->xa_index |= ((sibs + 1UL) << shift) - 1;
+	xas->xa_shift = 0;
+	xas->xa_sibs = 0;
+	xas->xa_node = XAS_RESTART;
+
+	for (;;) {
+		xas_load(xas);
+		if (!xas_is_node(xas))
+			break;
+		xas_delete_node(xas);
+		if (xas->xa_index <= (index | XA_CHUNK_MASK))
+			break;
+		xas->xa_index -= XA_CHUNK_SIZE;
+	}
+
+	xas->xa_shift = shift;
+	xas->xa_sibs = sibs;
+	xas->xa_index = index;
+	xas->xa_node = XA_ERROR(-ENOMEM);
+	return false;
+}
+
+/*
+ * We failed to allocate memory.  Trim any nodes we created along the
+ * way which are now unused.
+ */
+static bool xas_trim(struct xa_state *xas)
+{
+	unsigned int lock_type = xa_lock_type(xas->xa);
+
+	xas_lock_type(xas, lock_type);
+	__xas_trim(xas);
+	xas_unlock_type(xas, lock_type);
+
+	return false;
+}
+
+/**
+ * xas_nomem() - Allocate memory if needed.
+ * @xas: XArray operation state.
+ * @gfp: Memory allocation flags.
+ *
+ * If we need to add new nodes to the XArray, we try to allocate memory
+ * with GFP_NOWAIT while holding the lock, which will usually succeed.
+ * If it fails, @xas is flagged as needing memory to continue.  The caller
+ * should drop the lock and call xas_nomem().  If xas_nomem() succeeds,
+ * the caller should retry the operation.
+ *
+ * Forward progress is guaranteed as one node is allocated here and
+ * stored in the xa_state where it will be found by xas_alloc().  More
+ * nodes will likely be found in the slab allocator, but we do not tie
+ * them up here.
+ *
+ * Return: true if memory was needed, and was successfully allocated.
+ */
+bool xas_nomem(struct xa_state *xas, gfp_t gfp)
+{
+	if (xas->xa_node != XA_ERROR(-ENOMEM)) {
+		xas_destroy(xas);
+		return false;
+	}
+	if (xas->xa->xa_flags & XA_FLAGS_ACCOUNT)
+		gfp |= __GFP_ACCOUNT;
+	xas->xa_alloc = kmem_cache_alloc(radix_tree_node_cachep, gfp);
+	if (!xas->xa_alloc)
+		return xas_trim(xas);
+	xas->xa_alloc->parent = NULL;
+	XA_NODE_BUG_ON(xas->xa_alloc, !list_empty(&xas->xa_alloc->private_list));
+	xas->xa_node = XAS_RESTART;
+	return true;
+}
+EXPORT_SYMBOL_GPL(xas_nomem);
+
+/*
+ * __xas_nomem() - Drop locks and allocate memory if needed.
+ * @xas: XArray operation state.
+ * @gfp: Memory allocation flags.
+ *
+ * Internal variant of xas_nomem().
+ *
+ * Return: true if memory was needed, and was successfully allocated.
+ */
+static bool __xas_nomem(struct xa_state *xas, gfp_t gfp)
+	__must_hold(xas->xa->xa_lock)
+{
+	unsigned int lock_type = xa_lock_type(xas->xa);
+
+	if (xas->xa_node != XA_ERROR(-ENOMEM)) {
+		xas_destroy(xas);
+		return false;
+	}
+	if (xas->xa->xa_flags & XA_FLAGS_ACCOUNT)
+		gfp |= __GFP_ACCOUNT;
+	if (gfpflags_allow_blocking(gfp)) {
+		xas_unlock_type(xas, lock_type);
+		xas->xa_alloc = kmem_cache_alloc(radix_tree_node_cachep, gfp);
+		xas_lock_type(xas, lock_type);
+	} else {
+		xas->xa_alloc = kmem_cache_alloc(radix_tree_node_cachep, gfp);
+	}
+	if (!xas->xa_alloc)
+		return __xas_trim(xas);
+	xas->xa_alloc->parent = NULL;
+	XA_NODE_BUG_ON(xas->xa_alloc, !list_empty(&xas->xa_alloc->private_list));
+	xas->xa_node = XAS_RESTART;
+	return true;
+}
+
 /*
  * xas_expand adds nodes to the head of the tree until it has reached
  * sufficient height to be able to contain @xas->xa_index
