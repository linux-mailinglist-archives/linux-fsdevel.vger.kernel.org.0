Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB873D1009
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jul 2021 15:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238636AbhGUNGa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jul 2021 09:06:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30064 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238773AbhGUNFw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jul 2021 09:05:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626875187;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YIMMVaqdVhebN2c0WSSt5y4n7OTol1pb5VWKxV3dgW0=;
        b=cFaDkSjwBoUpP1t3bd7kV/xlAdKt/uKl5Os6WgvX40k/eppSUaTYNkHuYJanmEha0h84le
        NRyvCuMtnTgL+Pj4+Ri/+70OWF5zvS8w/x4qYzIEzotifq5p96Y/ti7stD8W80Git/cIBQ
        6MpXZQpoGkaD126w6eyBhJGVcs/tWQc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-455-2dRCJwMHMCuYSt_yp_EJGw-1; Wed, 21 Jul 2021 09:46:25 -0400
X-MC-Unique: 2dRCJwMHMCuYSt_yp_EJGw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5FEE993921;
        Wed, 21 Jul 2021 13:46:23 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-62.rdu2.redhat.com [10.10.112.62])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 45A5360583;
        Wed, 21 Jul 2021 13:46:19 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 07/12] netfs: Initiate write request from a dirty region
From:   David Howells <dhowells@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     dhowells@redhat.com, Jeff Layton <jlayton@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Mike Marshall <hubcap@omnibond.com>,
        David Wysochanski <dwysocha@redhat.com>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        devel@lists.orangefs.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 21 Jul 2021 14:46:18 +0100
Message-ID: <162687517832.276387.10765642135364197990.stgit@warthog.procyon.org.uk>
In-Reply-To: <162687506932.276387.14456718890524355509.stgit@warthog.procyon.org.uk>
References: <162687506932.276387.14456718890524355509.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Handle the initiation of writeback of a piece of the dirty list.  The first
region on the flush list is extracted and a write request is set up to
manage it.  The pages in the affected region are flipped from dirty to
writeback-in-progress.

The writeback is then dispatched (which currently just logs a "--- WRITE
---" message to dmesg and then abandons it).

Notes:

 (*) A page may host multiple disjoint dirty regions, each with its own
     netfs_dirty_region, and a region may span multiple pages.  Dirty
     regions are not permitted to overlap, though they may be merged if
     they would otherwise overlap.

 (*) A page may be involved in multiple simultaneous writebacks.  Each one
     is managed by a separate netfs_dirty_region and netfs_write_request.

 (*) Multiple pages may be required to form a write (for crypto/compression
     purposes) and so adjacent non-dirty pages may also get marked for
     writeback.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/file.c                |  128 ++----------------
 fs/netfs/Makefile            |    1 
 fs/netfs/internal.h          |   16 ++
 fs/netfs/objects.c           |   78 +++++++++++
 fs/netfs/read_helper.c       |   34 +++++
 fs/netfs/stats.c             |    6 +
 fs/netfs/write_back.c        |  306 ++++++++++++++++++++++++++++++++++++++++++
 fs/netfs/xa_iterator.h       |   85 ++++++++++++
 include/linux/netfs.h        |   35 +++++
 include/trace/events/netfs.h |   72 ++++++++++
 10 files changed, 642 insertions(+), 119 deletions(-)
 create mode 100644 fs/netfs/write_back.c
 create mode 100644 fs/netfs/xa_iterator.h

diff --git a/fs/afs/file.c b/fs/afs/file.c
index 8400cdf086b6..a6d483fe4e74 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -19,9 +19,6 @@
 
 static int afs_file_mmap(struct file *file, struct vm_area_struct *vma);
 static int afs_symlink_readpage(struct file *file, struct page *page);
-static void afs_invalidatepage(struct page *page, unsigned int offset,
-			       unsigned int length);
-static int afs_releasepage(struct page *page, gfp_t gfp_flags);
 
 static ssize_t afs_direct_IO(struct kiocb *iocb, struct iov_iter *iter);
 
@@ -50,17 +47,17 @@ const struct address_space_operations afs_file_aops = {
 	.readahead	= netfs_readahead,
 	.set_page_dirty	= afs_set_page_dirty,
 	.launder_page	= afs_launder_page,
-	.releasepage	= afs_releasepage,
-	.invalidatepage	= afs_invalidatepage,
+	.releasepage	= netfs_releasepage,
+	.invalidatepage	= netfs_invalidatepage,
 	.direct_IO	= afs_direct_IO,
 	.writepage	= afs_writepage,
-	.writepages	= afs_writepages,
+	.writepages	= netfs_writepages,
 };
 
 const struct address_space_operations afs_symlink_aops = {
 	.readpage	= afs_symlink_readpage,
-	.releasepage	= afs_releasepage,
-	.invalidatepage	= afs_invalidatepage,
+	.releasepage	= netfs_releasepage,
+	.invalidatepage	= netfs_invalidatepage,
 };
 
 static const struct vm_operations_struct afs_vm_ops = {
@@ -378,6 +375,11 @@ static void afs_free_dirty_region(struct netfs_dirty_region *region)
 	key_put(region->netfs_priv);
 }
 
+static void afs_init_wreq(struct netfs_write_request *wreq)
+{
+	//wreq->netfs_priv = key_get(afs_file_key(file));
+}
+
 static void afs_update_i_size(struct file *file, loff_t new_i_size)
 {
 	struct afs_vnode *vnode = AFS_FS_I(file_inode(file));
@@ -400,6 +402,7 @@ const struct netfs_request_ops afs_req_ops = {
 	.init_dirty_region	= afs_init_dirty_region,
 	.free_dirty_region	= afs_free_dirty_region,
 	.update_i_size		= afs_update_i_size,
+	.init_wreq		= afs_init_wreq,
 };
 
 int afs_write_inode(struct inode *inode, struct writeback_control *wbc)
@@ -408,115 +411,6 @@ int afs_write_inode(struct inode *inode, struct writeback_control *wbc)
 	return 0;
 }
 
-/*
- * Adjust the dirty region of the page on truncation or full invalidation,
- * getting rid of the markers altogether if the region is entirely invalidated.
- */
-static void afs_invalidate_dirty(struct page *page, unsigned int offset,
-				 unsigned int length)
-{
-	struct afs_vnode *vnode = AFS_FS_I(page->mapping->host);
-	unsigned long priv;
-	unsigned int f, t, end = offset + length;
-
-	priv = page_private(page);
-
-	/* we clean up only if the entire page is being invalidated */
-	if (offset == 0 && length == thp_size(page))
-		goto full_invalidate;
-
-	 /* If the page was dirtied by page_mkwrite(), the PTE stays writable
-	  * and we don't get another notification to tell us to expand it
-	  * again.
-	  */
-	if (afs_is_page_dirty_mmapped(priv))
-		return;
-
-	/* We may need to shorten the dirty region */
-	f = afs_page_dirty_from(page, priv);
-	t = afs_page_dirty_to(page, priv);
-
-	if (t <= offset || f >= end)
-		return; /* Doesn't overlap */
-
-	if (f < offset && t > end)
-		return; /* Splits the dirty region - just absorb it */
-
-	if (f >= offset && t <= end)
-		goto undirty;
-
-	if (f < offset)
-		t = offset;
-	else
-		f = end;
-	if (f == t)
-		goto undirty;
-
-	priv = afs_page_dirty(page, f, t);
-	set_page_private(page, priv);
-	trace_afs_page_dirty(vnode, tracepoint_string("trunc"), page);
-	return;
-
-undirty:
-	trace_afs_page_dirty(vnode, tracepoint_string("undirty"), page);
-	clear_page_dirty_for_io(page);
-full_invalidate:
-	trace_afs_page_dirty(vnode, tracepoint_string("inval"), page);
-	detach_page_private(page);
-}
-
-/*
- * invalidate part or all of a page
- * - release a page and clean up its private data if offset is 0 (indicating
- *   the entire page)
- */
-static void afs_invalidatepage(struct page *page, unsigned int offset,
-			       unsigned int length)
-{
-	_enter("{%lu},%u,%u", page->index, offset, length);
-
-	BUG_ON(!PageLocked(page));
-
-	if (PagePrivate(page))
-		afs_invalidate_dirty(page, offset, length);
-
-	wait_on_page_fscache(page);
-	_leave("");
-}
-
-/*
- * release a page and clean up its private state if it's not busy
- * - return true if the page can now be released, false if not
- */
-static int afs_releasepage(struct page *page, gfp_t gfp_flags)
-{
-	struct afs_vnode *vnode = AFS_FS_I(page->mapping->host);
-
-	_enter("{{%llx:%llu}[%lu],%lx},%x",
-	       vnode->fid.vid, vnode->fid.vnode, page->index, page->flags,
-	       gfp_flags);
-
-	/* deny if page is being written to the cache and the caller hasn't
-	 * elected to wait */
-#ifdef CONFIG_AFS_FSCACHE
-	if (PageFsCache(page)) {
-		if (!(gfp_flags & __GFP_DIRECT_RECLAIM) || !(gfp_flags & __GFP_FS))
-			return false;
-		wait_on_page_fscache(page);
-		fscache_note_page_release(afs_vnode_cache(vnode));
-	}
-#endif
-
-	if (PagePrivate(page)) {
-		trace_afs_page_dirty(vnode, tracepoint_string("rel"), page);
-		detach_page_private(page);
-	}
-
-	/* indicate that the page can be released */
-	_leave(" = T");
-	return 1;
-}
-
 /*
  * Handle setting up a memory mapping on an AFS file.
  */
diff --git a/fs/netfs/Makefile b/fs/netfs/Makefile
index 3e11453ad2c5..a201fd7b22cf 100644
--- a/fs/netfs/Makefile
+++ b/fs/netfs/Makefile
@@ -3,6 +3,7 @@
 netfs-y := \
 	objects.o \
 	read_helper.o \
+	write_back.o \
 	write_helper.o
 # dio_helper.o
 
diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
index 77ceab694348..fe85581d8ac0 100644
--- a/fs/netfs/internal.h
+++ b/fs/netfs/internal.h
@@ -8,6 +8,7 @@
 #include <linux/netfs.h>
 #include <linux/fscache.h>
 #include <trace/events/netfs.h>
+#include "xa_iterator.h"
 
 #ifdef pr_fmt
 #undef pr_fmt
@@ -34,6 +35,19 @@ void netfs_free_dirty_region(struct netfs_i_context *ctx, struct netfs_dirty_reg
 void netfs_put_dirty_region(struct netfs_i_context *ctx,
 			    struct netfs_dirty_region *region,
 			    enum netfs_region_trace what);
+struct netfs_write_request *netfs_alloc_write_request(struct address_space *mapping,
+						      bool is_dio);
+void netfs_get_write_request(struct netfs_write_request *wreq,
+			     enum netfs_wreq_trace what);
+void netfs_free_write_request(struct work_struct *work);
+void netfs_put_write_request(struct netfs_write_request *wreq,
+			     bool was_async, enum netfs_wreq_trace what);
+
+static inline void netfs_see_write_request(struct netfs_write_request *wreq,
+					   enum netfs_wreq_trace what)
+{
+	trace_netfs_ref_wreq(wreq->debug_id, refcount_read(&wreq->usage), what);
+}
 
 /*
  * read_helper.c
@@ -46,6 +60,7 @@ int netfs_prefetch_for_write(struct file *file, struct page *page, loff_t pos, s
 /*
  * write_helper.c
  */
+void netfs_writeback_worker(struct work_struct *work);
 void netfs_flush_region(struct netfs_i_context *ctx,
 			struct netfs_dirty_region *region,
 			enum netfs_dirty_trace why);
@@ -74,6 +89,7 @@ extern atomic_t netfs_n_rh_write_failed;
 extern atomic_t netfs_n_rh_write_zskip;
 extern atomic_t netfs_n_wh_region;
 extern atomic_t netfs_n_wh_flush_group;
+extern atomic_t netfs_n_wh_wreq;
 
 
 static inline void netfs_stat(atomic_t *stat)
diff --git a/fs/netfs/objects.c b/fs/netfs/objects.c
index ba1e052aa352..6e9b2a00076d 100644
--- a/fs/netfs/objects.c
+++ b/fs/netfs/objects.c
@@ -111,3 +111,81 @@ void netfs_put_dirty_region(struct netfs_i_context *ctx,
 		netfs_free_dirty_region(ctx, region);
 	}
 }
+
+struct netfs_write_request *netfs_alloc_write_request(struct address_space *mapping,
+						      bool is_dio)
+{
+	static atomic_t debug_ids;
+	struct inode *inode = mapping->host;
+	struct netfs_i_context *ctx = netfs_i_context(inode);
+	struct netfs_write_request *wreq;
+
+	wreq = kzalloc(sizeof(struct netfs_write_request), GFP_KERNEL);
+	if (wreq) {
+		wreq->mapping	= mapping;
+		wreq->inode	= inode;
+		wreq->netfs_ops	= ctx->ops;
+		wreq->debug_id	= atomic_inc_return(&debug_ids);
+		xa_init(&wreq->buffer);
+		INIT_WORK(&wreq->work, netfs_writeback_worker);
+		refcount_set(&wreq->usage, 1);
+		ctx->ops->init_wreq(wreq);
+		netfs_stat(&netfs_n_wh_wreq);
+		trace_netfs_ref_wreq(wreq->debug_id, 1, netfs_wreq_trace_new);
+	}
+
+	return wreq;
+}
+
+void netfs_get_write_request(struct netfs_write_request *wreq,
+			     enum netfs_wreq_trace what)
+{
+	int ref;
+
+	__refcount_inc(&wreq->usage, &ref);
+	trace_netfs_ref_wreq(wreq->debug_id, ref + 1, what);
+}
+
+void netfs_free_write_request(struct work_struct *work)
+{
+	struct netfs_write_request *wreq =
+		container_of(work, struct netfs_write_request, work);
+	struct netfs_i_context *ctx = netfs_i_context(wreq->inode);
+	struct page *page;
+	pgoff_t index;
+
+	if (wreq->netfs_priv)
+		wreq->netfs_ops->cleanup(wreq->mapping, wreq->netfs_priv);
+	trace_netfs_ref_wreq(wreq->debug_id, 0, netfs_wreq_trace_free);
+	if (wreq->cache_resources.ops)
+		wreq->cache_resources.ops->end_operation(&wreq->cache_resources);
+	if (wreq->region)
+		netfs_put_dirty_region(ctx, wreq->region,
+				       netfs_region_trace_put_wreq);
+	xa_for_each(&wreq->buffer, index, page) {
+		__free_page(page);
+	}
+	xa_destroy(&wreq->buffer);
+	kfree(wreq);
+	netfs_stat_d(&netfs_n_wh_wreq);
+}
+
+void netfs_put_write_request(struct netfs_write_request *wreq,
+			     bool was_async, enum netfs_wreq_trace what)
+{
+	unsigned int debug_id = wreq->debug_id;
+	bool dead;
+	int ref;
+
+	dead = __refcount_dec_and_test(&wreq->usage, &ref);
+	trace_netfs_ref_wreq(debug_id, ref - 1, what);
+	if (dead) {
+		if (was_async) {
+			wreq->work.func = netfs_free_write_request;
+			if (!queue_work(system_unbound_wq, &wreq->work))
+				BUG();
+		} else {
+			netfs_free_write_request(&wreq->work);
+		}
+	}
+}
diff --git a/fs/netfs/read_helper.c b/fs/netfs/read_helper.c
index bfcdbbd32f4c..0b771f2f5449 100644
--- a/fs/netfs/read_helper.c
+++ b/fs/netfs/read_helper.c
@@ -1415,3 +1415,37 @@ int netfs_prefetch_for_write(struct file *file, struct page *page,
 	_leave(" = %d", ret);
 	return ret;
 }
+
+/*
+ * Invalidate part or all of a page
+ * - release a page and clean up its private data if offset is 0 (indicating
+ *   the entire page)
+ */
+void netfs_invalidatepage(struct page *page, unsigned int offset, unsigned int length)
+{
+	_enter("{%lu},%u,%u", page->index, offset, length);
+
+	wait_on_page_fscache(page);
+}
+EXPORT_SYMBOL(netfs_invalidatepage);
+
+/*
+ * Release a page and clean up its private state if it's not busy
+ * - return true if the page can now be released, false if not
+ */
+int netfs_releasepage(struct page *page, gfp_t gfp_flags)
+{
+	struct netfs_i_context *ctx = netfs_i_context(page->mapping->host);
+
+	kenter("");
+
+	if (PageFsCache(page)) {
+		if (!(gfp_flags & __GFP_DIRECT_RECLAIM) || !(gfp_flags & __GFP_FS))
+			return false;
+		wait_on_page_fscache(page);
+		fscache_note_page_release(ctx->cache);
+	}
+
+	return true;
+}
+EXPORT_SYMBOL(netfs_releasepage);
diff --git a/fs/netfs/stats.c b/fs/netfs/stats.c
index 7c079ca47b5b..ac2510f8cab0 100644
--- a/fs/netfs/stats.c
+++ b/fs/netfs/stats.c
@@ -29,6 +29,7 @@ atomic_t netfs_n_rh_write_failed;
 atomic_t netfs_n_rh_write_zskip;
 atomic_t netfs_n_wh_region;
 atomic_t netfs_n_wh_flush_group;
+atomic_t netfs_n_wh_wreq;
 
 void netfs_stats_show(struct seq_file *m)
 {
@@ -56,8 +57,9 @@ void netfs_stats_show(struct seq_file *m)
 		   atomic_read(&netfs_n_rh_write),
 		   atomic_read(&netfs_n_rh_write_done),
 		   atomic_read(&netfs_n_rh_write_failed));
-	seq_printf(m, "WrHelp : R=%u F=%u\n",
+	seq_printf(m, "WrHelp : R=%u F=%u wr=%u\n",
 		   atomic_read(&netfs_n_wh_region),
-		   atomic_read(&netfs_n_wh_flush_group));
+		   atomic_read(&netfs_n_wh_flush_group),
+		   atomic_read(&netfs_n_wh_wreq));
 }
 EXPORT_SYMBOL(netfs_stats_show);
diff --git a/fs/netfs/write_back.c b/fs/netfs/write_back.c
new file mode 100644
index 000000000000..9fcb2ac50ebb
--- /dev/null
+++ b/fs/netfs/write_back.c
@@ -0,0 +1,306 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Network filesystem high-level write support.
+ *
+ * Copyright (C) 2021 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#include <linux/fs.h>
+#include <linux/mm.h>
+#include <linux/pagemap.h>
+#include <linux/slab.h>
+#include "internal.h"
+
+/*
+ * Process a write request.
+ */
+static void netfs_writeback(struct netfs_write_request *wreq)
+{
+	kdebug("--- WRITE ---");
+}
+
+void netfs_writeback_worker(struct work_struct *work)
+{
+	struct netfs_write_request *wreq =
+		container_of(work, struct netfs_write_request, work);
+
+	netfs_see_write_request(wreq, netfs_wreq_trace_see_work);
+	netfs_writeback(wreq);
+	netfs_put_write_request(wreq, false, netfs_wreq_trace_put_work);
+}
+
+/*
+ * Flush some of the dirty queue.
+ */
+static int netfs_flush_dirty(struct address_space *mapping,
+			     struct writeback_control *wbc,
+			     struct netfs_range *range,
+			     loff_t *next)
+{
+	struct netfs_dirty_region *p, *q;
+	struct netfs_i_context *ctx = netfs_i_context(mapping->host);
+
+	kenter("%llx-%llx", range->start, range->end);
+
+	spin_lock(&ctx->lock);
+
+	/* Scan forwards to find dirty regions containing the suggested start
+	 * point.
+	 */
+	list_for_each_entry_safe(p, q, &ctx->dirty_regions, dirty_link) {
+		_debug("D=%x %llx-%llx", p->debug_id, p->dirty.start, p->dirty.end);
+		if (p->dirty.end <= range->start)
+			continue;
+		if (p->dirty.start >= range->end)
+			break;
+		if (p->state != NETFS_REGION_IS_DIRTY)
+			continue;
+		if (test_bit(NETFS_REGION_FLUSH_Q, &p->flags))
+			continue;
+
+		netfs_flush_region(ctx, p, netfs_dirty_trace_flush_writepages);
+	}
+
+	spin_unlock(&ctx->lock);
+	return 0;
+}
+
+static int netfs_unlock_pages_iterator(struct page *page)
+{
+	unlock_page(page);
+	put_page(page);
+	return 0;
+}
+
+/*
+ * Unlock all the pages in a range.
+ */
+static void netfs_unlock_pages(struct address_space *mapping,
+			       pgoff_t start, pgoff_t end)
+{
+	netfs_iterate_pages(mapping, start, end, netfs_unlock_pages_iterator);
+}
+
+static int netfs_lock_pages_iterator(struct xa_state *xas,
+				     struct page *page,
+				     struct netfs_write_request *wreq,
+				     struct writeback_control *wbc)
+{
+	int ret;
+
+	/* At this point we hold neither the i_pages lock nor the
+	 * page lock: the page may be truncated or invalidated
+	 * (changing page->mapping to NULL), or even swizzled
+	 * back from swapper_space to tmpfs file mapping
+	 */
+	if (wbc->sync_mode != WB_SYNC_NONE) {
+		xas_pause(xas);
+		rcu_read_unlock();
+		ret = lock_page_killable(page);
+		rcu_read_lock();
+	} else {
+		if (!trylock_page(page))
+			ret = -EBUSY;
+	}
+
+	return ret;
+}
+
+/*
+ * Lock all the pages in a range and add them to the write request.
+ */
+static int netfs_lock_pages(struct address_space *mapping,
+			    struct writeback_control *wbc,
+			    struct netfs_write_request *wreq)
+{
+	pgoff_t last = wreq->last;
+	int ret;
+
+	kenter("%lx-%lx", wreq->first, wreq->last);
+	ret = netfs_iterate_get_pages(mapping, wreq->first, wreq->last,
+				      netfs_lock_pages_iterator, wreq, wbc);
+	if (ret < 0)
+		goto failed;
+
+	if (wreq->last < last) {
+		kdebug("Some pages missing %lx < %lx", wreq->last, last);
+		ret = -EIO;
+		goto failed;
+	}
+
+	return 0;
+
+failed:
+	netfs_unlock_pages(mapping, wreq->first, wreq->last);
+	return ret;
+}
+
+static int netfs_set_page_writeback(struct page *page)
+{
+	/* Now we need to clear the dirty flags on any page that's not shared
+	 * with any other dirty region.
+	 */
+	if (!clear_page_dirty_for_io(page))
+		BUG();
+
+	/* We set writeback unconditionally because a page may participate in
+	 * more than one simultaneous writeback.
+	 */
+	set_page_writeback(page);
+	return 0;
+}
+
+/*
+ * Extract a region to write back.
+ */
+static struct netfs_dirty_region *netfs_extract_dirty_region(
+	struct netfs_i_context *ctx,
+	struct netfs_write_request *wreq)
+{
+	struct netfs_dirty_region *region = NULL, *spare;
+
+	spare = netfs_alloc_dirty_region();
+	if (!spare)
+		return NULL;
+
+	spin_lock(&ctx->lock);
+
+	if (list_empty(&ctx->flush_queue))
+		goto out;
+
+	region = list_first_entry(&ctx->flush_queue,
+				  struct netfs_dirty_region, flush_link);
+
+	wreq->region = netfs_get_dirty_region(ctx, region, netfs_region_trace_get_wreq);
+	wreq->start  = region->dirty.start;
+	wreq->len    = region->dirty.end - region->dirty.start;
+	wreq->first  =  region->dirty.start    / PAGE_SIZE;
+	wreq->last   = (region->dirty.end - 1) / PAGE_SIZE;
+
+	/* TODO: Split the region if it's larger than a certain size.  This is
+	 * tricky as we need to observe page, crypto and compression block
+	 * boundaries.  The crypto/comp bounds are defined by ctx->bsize, but
+	 * we don't know where the page boundaries are.
+	 *
+	 * All of these boundaries, however, must be pow-of-2 sized and
+	 * pow-of-2 aligned, so they never partially overlap
+	 */
+
+	smp_store_release(&region->state, NETFS_REGION_IS_FLUSHING);
+	trace_netfs_dirty(ctx, region, NULL, netfs_dirty_trace_flushing);
+	wake_up_var(&region->state);
+	list_del_init(&region->flush_link);
+
+out:
+	spin_unlock(&ctx->lock);
+	netfs_free_dirty_region(ctx, spare);
+	kleave(" = D=%x", region ? region->debug_id : 0);
+	return region;
+}
+
+/*
+ * Schedule a write for the first region on the flush queue.
+ */
+static int netfs_begin_write(struct address_space *mapping,
+			     struct writeback_control *wbc)
+{
+	struct netfs_write_request *wreq;
+	struct netfs_dirty_region *region;
+	struct netfs_i_context *ctx = netfs_i_context(mapping->host);
+	int ret;
+
+	wreq = netfs_alloc_write_request(mapping, false);
+	if (!wreq)
+		return -ENOMEM;
+
+	ret = 0;
+	region = netfs_extract_dirty_region(ctx, wreq);
+	if (!region)
+		goto error;
+
+	ret = netfs_lock_pages(mapping, wbc, wreq);
+	if (ret < 0)
+		goto error;
+
+	trace_netfs_wreq(wreq);
+
+	netfs_iterate_pages(mapping, wreq->first, wreq->last,
+			    netfs_set_page_writeback);
+	netfs_unlock_pages(mapping, wreq->first, wreq->last);
+	iov_iter_xarray(&wreq->source, WRITE, &wreq->mapping->i_pages,
+			wreq->start, wreq->len);
+
+	if (!queue_work(system_unbound_wq, &wreq->work))
+		BUG();
+
+	kleave(" = %lu", wreq->last - wreq->first + 1);
+	return wreq->last - wreq->first + 1;
+
+error:
+	netfs_put_write_request(wreq, wbc->sync_mode != WB_SYNC_NONE,
+				netfs_wreq_trace_put_discard);
+	kleave(" = %d", ret);
+	return ret;
+}
+
+/**
+ * netfs_writepages - Initiate writeback to the server and cache
+ * @mapping: The pagecache to write from
+ * @wbc: Hints from the VM as to what to write
+ *
+ * This is a helper intended to be called directly from a network filesystem's
+ * address space operations table to perform writeback to the server and the
+ * cache.
+ *
+ * We have to be careful as we can end up racing with setattr() truncating the
+ * pagecache since the caller doesn't take a lock here to prevent it.
+ */
+int netfs_writepages(struct address_space *mapping,
+		     struct writeback_control *wbc)
+{
+	struct netfs_range range;
+	loff_t next;
+	int ret;
+
+	kenter("%lx,%llx-%llx,%u,%c%c%c%c,%u,%u",
+	       wbc->nr_to_write,
+	       wbc->range_start, wbc->range_end,
+	       wbc->sync_mode,
+	       wbc->for_kupdate		? 'k' : '-',
+	       wbc->for_background	? 'b' : '-',
+	       wbc->for_reclaim		? 'r' : '-',
+	       wbc->for_sync		? 's' : '-',
+	       wbc->tagged_writepages,
+	       wbc->range_cyclic);
+
+	//dump_stack();
+
+	if (wbc->range_cyclic) {
+		range.start = mapping->writeback_index * PAGE_SIZE;
+		range.end   = ULLONG_MAX;
+		ret = netfs_flush_dirty(mapping, wbc, &range, &next);
+		if (range.start > 0 && wbc->nr_to_write > 0 && ret == 0) {
+			range.start = 0;
+			range.end   = mapping->writeback_index * PAGE_SIZE;
+			ret = netfs_flush_dirty(mapping, wbc, &range, &next);
+		}
+		mapping->writeback_index = next / PAGE_SIZE;
+	} else if (wbc->range_start == 0 && wbc->range_end == LLONG_MAX) {
+		range.start = 0;
+		range.end   = ULLONG_MAX;
+		ret = netfs_flush_dirty(mapping, wbc, &range, &next);
+		if (wbc->nr_to_write > 0 && ret == 0)
+			mapping->writeback_index = next;
+	} else {
+		range.start = wbc->range_start;
+		range.end   = wbc->range_end + 1;
+		ret = netfs_flush_dirty(mapping, wbc, &range, &next);
+	}
+
+	if (ret == 0)
+		ret = netfs_begin_write(mapping, wbc);
+
+	_leave(" = %d", ret);
+	return ret;
+}
+EXPORT_SYMBOL(netfs_writepages);
diff --git a/fs/netfs/xa_iterator.h b/fs/netfs/xa_iterator.h
new file mode 100644
index 000000000000..3f37827f0f99
--- /dev/null
+++ b/fs/netfs/xa_iterator.h
@@ -0,0 +1,85 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* xarray iterator macros for netfslib.
+ *
+ * Copyright (C) 2021 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+/*
+ * Iterate over a range of pages.  xarray locks are not held over the iterator
+ * function, so it can sleep if necessary.  The start and end positions are
+ * updated to indicate the span of pages actually processed.
+ */
+#define netfs_iterate_pages(MAPPING, START, END, ITERATOR, ...)		\
+	({								\
+		unsigned long __it_index;				\
+		struct page *page;					\
+		pgoff_t __it_start = (START);				\
+		pgoff_t __it_end = (END);				\
+		pgoff_t __it_tmp;					\
+		int ret = 0;						\
+									\
+		(END) = __it_start;					\
+		xa_for_each_range(&(MAPPING)->i_pages, __it_index, page, \
+				  __it_start, __it_end) {		\
+			if (xa_is_value(page)) {			\
+				ret = -EIO; /* Not a real page. */	\
+				break;					\
+			}						\
+			if (__it_index < (START))			\
+				(START) = __it_index;			\
+			ret = ITERATOR(page, ##__VA_ARGS__);		\
+			if (ret < 0)					\
+				break;					\
+			__it_tmp = __it_index + thp_nr_pages(page) - 1;	\
+			if (__it_tmp > (END))				\
+				(END) = __it_tmp;			\
+		}							\
+		ret;							\
+	})
+
+/*
+ * Iterate over a set of pages, getting each one before calling the iteration
+ * function.  The iteration function may drop the RCU read lock, but should
+ * call xas_pause() before it does so.  The start and end positions are updated
+ * to indicate the span of pages actually processed.
+ */
+#define netfs_iterate_get_pages(MAPPING, START, END, ITERATOR, ...)	\
+	({								\
+		unsigned long __it_index;				\
+		struct page *page;					\
+		pgoff_t __it_start = (START);				\
+		pgoff_t __it_end = (END);				\
+		pgoff_t __it_tmp;					\
+		int ret = 0;						\
+									\
+		XA_STATE(xas, &(MAPPING)->i_pages, __it_start);		\
+		(END) = __it_start;					\
+		rcu_read_lock();					\
+		for (page = xas_load(&xas); page; page = xas_next_entry(&xas, __it_end)) { \
+			if (xas_retry(&xas, page))			\
+				continue;				\
+			if (xa_is_value(page))				\
+				break;					\
+			if (!page_cache_get_speculative(page)) {	\
+				xas_reset(&xas);			\
+				continue;				\
+			}						\
+			if (unlikely(page != xas_reload(&xas))) {	\
+				put_page(page);				\
+				xas_reset(&xas);			\
+				continue;				\
+			}						\
+			__it_index = page_index(page);			\
+			if (__it_index < (START))			\
+				(START) = __it_index;			\
+			ret = ITERATOR(&xas, page, ##__VA_ARGS__);	\
+			if (ret < 0)					\
+				break;					\
+			__it_tmp = __it_index + thp_nr_pages(page) - 1; \
+			if (__it_tmp > (END))				\
+				(END) = __it_tmp;			\
+		}							\
+		rcu_read_unlock();					\
+		ret;							\
+	})
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index fc91711d3178..9f874e7ed45a 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -242,6 +242,35 @@ struct netfs_dirty_region {
 	refcount_t		ref;
 };
 
+/*
+ * Descriptor for a write request.  This is used to manage the preparation and
+ * storage of a sequence of dirty data - its compression/encryption and its
+ * writing to one or more servers and the cache.
+ *
+ * The prepared data is buffered here.
+ */
+struct netfs_write_request {
+	struct work_struct	work;
+	struct inode		*inode;		/* The file being accessed */
+	struct address_space	*mapping;	/* The mapping being accessed */
+	struct netfs_dirty_region *region;	/* The region we're writing back */
+	struct netfs_cache_resources cache_resources;
+	struct xarray		buffer;		/* Buffer for encrypted/compressed data */
+	struct iov_iter		source;		/* The iterator to be used */
+	struct list_head	write_link;	/* Link in i_context->write_requests */
+	void			*netfs_priv;	/* Private data for the netfs */
+	unsigned int		debug_id;
+	short			error;		/* 0 or error that occurred */
+	loff_t			i_size;		/* Size of the file */
+	loff_t			start;		/* Start position */
+	size_t			len;		/* Length of the request */
+	pgoff_t			first;		/* First page included */
+	pgoff_t			last;		/* Last page included */
+	refcount_t		usage;
+	unsigned long		flags;
+	const struct netfs_request_ops *netfs_ops;
+};
+
 enum netfs_write_compatibility {
 	NETFS_WRITES_COMPATIBLE,	/* Dirty regions can be directly merged */
 	NETFS_WRITES_SUPERSEDE,		/* Second write can supersede the first without first
@@ -275,6 +304,9 @@ struct netfs_request_ops {
 		struct netfs_dirty_region *candidate);
 	bool (*check_compatible_write)(struct netfs_dirty_region *region, struct file *file);
 	void (*update_i_size)(struct file *file, loff_t i_size);
+
+	/* Write request handling */
+	void (*init_wreq)(struct netfs_write_request *wreq);
 };
 
 /*
@@ -324,6 +356,9 @@ extern int netfs_write_begin(struct file *, struct address_space *,
 			     loff_t, unsigned int, unsigned int, struct page **,
 			     void **);
 extern ssize_t netfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from);
+extern int netfs_writepages(struct address_space *mapping, struct writeback_control *wbc);
+extern void netfs_invalidatepage(struct page *page, unsigned int offset, unsigned int length);
+extern int netfs_releasepage(struct page *page, gfp_t gfp_flags);
 
 extern void netfs_subreq_terminated(struct netfs_read_subrequest *, ssize_t, bool);
 extern void netfs_stats_show(struct seq_file *);
diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
index 808433e6ddd3..e70abb5033e6 100644
--- a/include/trace/events/netfs.h
+++ b/include/trace/events/netfs.h
@@ -63,6 +63,8 @@ enum netfs_dirty_trace {
 	netfs_dirty_trace_complete,
 	netfs_dirty_trace_flush_conflict,
 	netfs_dirty_trace_flush_dsync,
+	netfs_dirty_trace_flush_writepages,
+	netfs_dirty_trace_flushing,
 	netfs_dirty_trace_merged_back,
 	netfs_dirty_trace_merged_forw,
 	netfs_dirty_trace_merged_sub,
@@ -82,11 +84,20 @@ enum netfs_region_trace {
 	netfs_region_trace_get_wreq,
 	netfs_region_trace_put_discard,
 	netfs_region_trace_put_merged,
+	netfs_region_trace_put_wreq,
 	netfs_region_trace_put_write_iter,
 	netfs_region_trace_free,
 	netfs_region_trace_new,
 };
 
+enum netfs_wreq_trace {
+	netfs_wreq_trace_free,
+	netfs_wreq_trace_put_discard,
+	netfs_wreq_trace_put_work,
+	netfs_wreq_trace_see_work,
+	netfs_wreq_trace_new,
+};
+
 #endif
 
 #define netfs_read_traces					\
@@ -149,6 +160,8 @@ enum netfs_region_trace {
 	EM(netfs_dirty_trace_complete,		"COMPLETE  ")	\
 	EM(netfs_dirty_trace_flush_conflict,	"FLSH CONFL")	\
 	EM(netfs_dirty_trace_flush_dsync,	"FLSH DSYNC")	\
+	EM(netfs_dirty_trace_flush_writepages,	"WRITEPAGES")	\
+	EM(netfs_dirty_trace_flushing,		"FLUSHING  ")	\
 	EM(netfs_dirty_trace_merged_back,	"MERGE BACK")	\
 	EM(netfs_dirty_trace_merged_forw,	"MERGE FORW")	\
 	EM(netfs_dirty_trace_merged_sub,	"SUBSUMED  ")	\
@@ -167,10 +180,19 @@ enum netfs_region_trace {
 	EM(netfs_region_trace_get_wreq,		"GET WREQ   ")	\
 	EM(netfs_region_trace_put_discard,	"PUT DISCARD")	\
 	EM(netfs_region_trace_put_merged,	"PUT MERGED ")	\
+	EM(netfs_region_trace_put_wreq,		"PUT WREQ   ")	\
 	EM(netfs_region_trace_put_write_iter,	"PUT WRITER ")	\
 	EM(netfs_region_trace_free,		"FREE       ")	\
 	E_(netfs_region_trace_new,		"NEW        ")
 
+#define netfs_wreq_traces					\
+	EM(netfs_wreq_trace_free,		"FREE       ")	\
+	EM(netfs_wreq_trace_put_discard,	"PUT DISCARD")	\
+	EM(netfs_wreq_trace_put_work,		"PUT WORK   ")	\
+	EM(netfs_wreq_trace_see_work,		"SEE WORK   ")	\
+	E_(netfs_wreq_trace_new,		"NEW        ")
+
+
 /*
  * Export enum symbols via userspace.
  */
@@ -187,6 +209,7 @@ netfs_failures;
 netfs_region_types;
 netfs_region_states;
 netfs_dirty_traces;
+netfs_wreq_traces;
 
 /*
  * Now redefine the EM() and E_() macros to map the enums to the strings that
@@ -435,6 +458,55 @@ TRACE_EVENT(netfs_dirty,
 		      )
 	    );
 
+TRACE_EVENT(netfs_wreq,
+	    TP_PROTO(struct netfs_write_request *wreq),
+
+	    TP_ARGS(wreq),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,		wreq		)
+		    __field(unsigned int,		cookie		)
+		    __field(loff_t,			start		)
+		    __field(size_t,			len		)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->wreq	= wreq->debug_id;
+		    __entry->cookie	= wreq->cache_resources.debug_id;
+		    __entry->start	= wreq->start;
+		    __entry->len	= wreq->len;
+			   ),
+
+	    TP_printk("W=%08x c=%08x s=%llx %zx",
+		      __entry->wreq,
+		      __entry->cookie,
+		      __entry->start, __entry->len)
+	    );
+
+TRACE_EVENT(netfs_ref_wreq,
+	    TP_PROTO(unsigned int wreq_debug_id, int ref,
+		     enum netfs_wreq_trace what),
+
+	    TP_ARGS(wreq_debug_id, ref, what),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,		wreq		)
+		    __field(int,			ref		)
+		    __field(enum netfs_wreq_trace,	what		)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->wreq	= wreq_debug_id;
+		    __entry->ref	= ref;
+		    __entry->what	= what;
+			   ),
+
+	    TP_printk("W=%08x %s r=%u",
+		      __entry->wreq,
+		      __print_symbolic(__entry->what, netfs_wreq_traces),
+		      __entry->ref)
+	    );
+
 #endif /* _TRACE_NETFS_H */
 
 /* This part must be outside protection */


