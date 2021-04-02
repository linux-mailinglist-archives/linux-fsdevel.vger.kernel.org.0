Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97713352598
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Apr 2021 05:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233901AbhDBDNT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Apr 2021 23:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233665AbhDBDNT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Apr 2021 23:13:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D55C0613E6;
        Thu,  1 Apr 2021 20:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ePkApq+eAbci5ih5uu3fsCIhPqtvRqCGqPeCVh/d5TY=; b=b44SXhjJbU77CePf/FjihR1EdV
        D6RQM0PR6b2PNYbE1D5gmWOEXWQkImvclrbGpKlJCWQFBBxBEDEBxd1KTngIwS5gLASDVmyemjANR
        AFTafoLjxYafVU7uiMxaWWxyiiakdQIkMPog5vPzwrnBzFefR1ZSO5VFA76kbX+V1oPfrCj1eD9Hs
        I5BaskiVAktrLxuIoEazU7nSMcJaAahI0WssyRt06ymaee5I/wzV342/UKvIeZIroO3CbiYcEBH3T
        3ZIuBWePhJhwbpXcYMvx5/Xxl9A31HBZHk+yK0nqAT/QZvk/HF5ZLYDxXjRc80ixi0dzyKSay3MW9
        +sWil21A==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lSAF7-0077dJ-AS; Fri, 02 Apr 2021 03:13:07 +0000
Date:   Fri, 2 Apr 2021 04:13:05 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: BUG_ON(!mapping_empty(&inode->i_data))
Message-ID: <20210402031305.GK351017@casper.infradead.org>
References: <alpine.LSU.2.11.2103301654520.2648@eggly.anvils>
 <20210331024913.GS351017@casper.infradead.org>
 <alpine.LSU.2.11.2103311413560.1201@eggly.anvils>
 <20210401170615.GH351017@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401170615.GH351017@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 01, 2021 at 06:06:15PM +0100, Matthew Wilcox wrote:
> On Wed, Mar 31, 2021 at 02:58:12PM -0700, Hugh Dickins wrote:
> > I suspect there's a bug in the XArray handling in collapse_file(),
> > which sometimes leaves empty nodes behind.
> 
> Urp, yes, that can easily happen.
> 
>         /* This will be less messy when we use multi-index entries */
>         do {
>                 xas_lock_irq(&xas);
>                 xas_create_range(&xas);
>                 if (!xas_error(&xas))
>                         break;
>                 if (!xas_nomem(&xas, GFP_KERNEL)) {
>                         result = SCAN_FAIL;
>                         goto out;
>                 }
> 
> xas_create_range() can absolutely create nodes with zero entries.
> So if we create m/n nodes and then it runs out of memory (or cgroup
> denies it), we can leave nodes in the tree with zero entries.
> 
> There are three options for fixing it ...
>  - Switch to using multi-index entries.  We need to do this anyway, but
>    I don't yet have a handle on the bugs that you found last time I
>    pushed this into linux-next.  At -rc5 seems like a late stage to be
>    trying this solution.
>  - Add an xas_prune_range() that gets called on failure.  Should be
>    straightforward to write, but will be obsolete as soon as we do the
>    above and it's a pain for the callers.
>  - Change how xas_create_range() works to merely preallocate the xa_nodes
>    and not insert them into the tree until we're trying to insert data into
>    them.  I favour this option, and this scenario is amenable to writing
>    a test that will simulate failure halfway through.
> 
> I'm going to start on option 3 now.

option 3 didn't work out terribly well.  So here's option 4; if we fail
to allocate memory when creating a node, prune the tree.  This fixes
(I think) the problem inherited from the radix tree, although the test
case is only for xas_create_range().  I should add a couple of test cases
for xas_create() failing, but I just got this to pass and I wanted to
send it out as soon as possible.

diff --git a/lib/test_xarray.c b/lib/test_xarray.c
index 8b1c318189ce..84c6057932f3 100644
--- a/lib/test_xarray.c
+++ b/lib/test_xarray.c
@@ -1463,6 +1463,30 @@ static noinline void check_create_range_4(struct xarray *xa,
 	XA_BUG_ON(xa, !xa_empty(xa));
 }
 
+static noinline void check_create_range_5(struct xarray *xa,
+		unsigned long index, unsigned order)
+{
+	XA_STATE_ORDER(xas, xa, index, order);
+	int i = 0;
+	gfp_t gfp = GFP_KERNEL;
+
+	XA_BUG_ON(xa, !xa_empty(xa));
+
+	do {
+		xas_lock(&xas);
+		xas_create_range(&xas);
+		xas_unlock(&xas);
+		if (++i == 4)
+			gfp = GFP_NOWAIT;
+	} while (xas_nomem(&xas, gfp));
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
@@ -1490,6 +1514,12 @@ static noinline void check_create_range(struct xarray *xa)
 		check_create_range_4(xa, (3U << order) + 1, order);
 		check_create_range_4(xa, (3U << order) - 1, order);
 		check_create_range_4(xa, (1U << 24) + 1, order);
+
+		check_create_range_5(xa, 0, order);
+		check_create_range_5(xa, (1U << order), order);
+		check_create_range_5(xa, (2U << order), order);
+		check_create_range_5(xa, (3U << order), order);
+		check_create_range_5(xa, (1U << (2 * order)), order);
 	}
 
 	check_create_range_3();
diff --git a/lib/xarray.c b/lib/xarray.c
index f5d8f54907b4..923ccde6379e 100644
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
+		xas->xa_index -= XA_CHUNK_SIZE;
+		if (xas->xa_index < index)
+			break;
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
