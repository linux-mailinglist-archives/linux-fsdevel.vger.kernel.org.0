Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFD113D101E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jul 2021 15:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238509AbhGUNGn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jul 2021 09:06:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40088 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238792AbhGUNGL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jul 2021 09:06:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626875207;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PoKprYNGtQBdlM+LSdI4bPE2v5xsXclxnPzqIdG9rOU=;
        b=EoAHttHX5EtHzyDe9cv++5bmhhth98vlSrITbWEYfcYQTs6ryK6x3RS0o8gliwC6phLvJm
        Bx2ug2RYiD6A6hUNn9mOZ7RjRcAQoDYCfigAkW3HwXeu6IGuEyW+NuO5K/ZltKKWW0f/nU
        NnCD2SUcNufsU0VXiYqdUVjQtZRam/Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-Sw-cwihGMLmVlWaby_ARfw-1; Wed, 21 Jul 2021 09:46:45 -0400
X-MC-Unique: Sw-cwihGMLmVlWaby_ARfw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 47C96107ACF5;
        Wed, 21 Jul 2021 13:46:43 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-62.rdu2.redhat.com [10.10.112.62])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2F6726091B;
        Wed, 21 Jul 2021 13:46:39 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 09/12] netfs: Send write request to multiple destinations
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
Date:   Wed, 21 Jul 2021 14:46:38 +0100
Message-ID: <162687519833.276387.1376700874310007511.stgit@warthog.procyon.org.uk>
In-Reply-To: <162687506932.276387.14456718890524355509.stgit@warthog.procyon.org.uk>
References: <162687506932.276387.14456718890524355509.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Write requests are set up to have a number of "write streams", whereby each
stream writes the entire request to a different destination.  Destination
types include server uploads and cache writes.

Each stream may be segmented into a series of writes that can be issued
consecutively, for example uploading to an AFS server, writing to a cache
or both.

A request has, or will have, a number of phases:

 (1) Preparation.  The data may need to be copied into a buffer and
     compressed or encrypted.  The modified data would then be stored to
     the cache or the server.

 (2) Writing.  Each stream writes the data.

 (3) Completion.  The pages are cleaned or redirtied as appropriate and the
     dirty list is updated to remove the now flushed region.  Waiting write
     requests that are wholly within the range now made available are woken
     up.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/file.c                |    1 
 fs/afs/inode.c               |   13 ++
 fs/afs/internal.h            |    2 
 fs/afs/write.c               |  179 ++++++------------------------
 fs/netfs/internal.h          |    6 +
 fs/netfs/objects.c           |   25 ++++
 fs/netfs/stats.c             |   14 ++
 fs/netfs/write_back.c        |  249 ++++++++++++++++++++++++++++++++++++++++++
 fs/netfs/write_helper.c      |   28 +++--
 fs/netfs/xa_iterator.h       |   31 +++++
 include/linux/netfs.h        |   65 +++++++++++
 include/trace/events/netfs.h |   61 ++++++++++
 12 files changed, 515 insertions(+), 159 deletions(-)

diff --git a/fs/afs/file.c b/fs/afs/file.c
index a6d483fe4e74..22030d5191cd 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -403,6 +403,7 @@ const struct netfs_request_ops afs_req_ops = {
 	.free_dirty_region	= afs_free_dirty_region,
 	.update_i_size		= afs_update_i_size,
 	.init_wreq		= afs_init_wreq,
+	.add_write_streams	= afs_add_write_streams,
 };
 
 int afs_write_inode(struct inode *inode, struct writeback_control *wbc)
diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index 3e9e388245a1..a6ae031461c7 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -449,6 +449,15 @@ static void afs_get_inode_cache(struct afs_vnode *vnode)
 #endif
 }
 
+static void afs_set_netfs_context(struct afs_vnode *vnode)
+{
+	struct netfs_i_context *ctx = netfs_i_context(&vnode->vfs_inode);
+
+	netfs_i_context_init(&vnode->vfs_inode, &afs_req_ops);
+	ctx->n_wstreams = 1;
+	ctx->bsize = PAGE_SIZE;
+}
+
 /*
  * inode retrieval
  */
@@ -479,7 +488,7 @@ struct inode *afs_iget(struct afs_operation *op, struct afs_vnode_param *vp)
 		return inode;
 	}
 
-	netfs_i_context_init(inode, &afs_req_ops);
+	afs_set_netfs_context(vnode);
 	ret = afs_inode_init_from_status(op, vp, vnode);
 	if (ret < 0)
 		goto bad_inode;
@@ -536,10 +545,10 @@ struct inode *afs_root_iget(struct super_block *sb, struct key *key)
 	_debug("GOT ROOT INODE %p { vl=%llx }", inode, as->volume->vid);
 
 	BUG_ON(!(inode->i_state & I_NEW));
-	netfs_i_context_init(inode, &afs_req_ops);
 
 	vnode = AFS_FS_I(inode);
 	vnode->cb_v_break = as->volume->cb_v_break,
+	afs_set_netfs_context(vnode);
 
 	op = afs_alloc_operation(key, as->volume);
 	if (IS_ERR(op)) {
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 0d01ed2fe8fa..32a36b96cc9b 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -1512,12 +1512,12 @@ extern int afs_check_volume_status(struct afs_volume *, struct afs_operation *);
  */
 extern int afs_set_page_dirty(struct page *);
 extern int afs_writepage(struct page *, struct writeback_control *);
-extern int afs_writepages(struct address_space *, struct writeback_control *);
 extern int afs_fsync(struct file *, loff_t, loff_t, int);
 extern vm_fault_t afs_page_mkwrite(struct vm_fault *vmf);
 extern void afs_prune_wb_keys(struct afs_vnode *);
 extern int afs_launder_page(struct page *);
 extern ssize_t afs_file_direct_write(struct kiocb *, struct iov_iter *);
+extern void afs_add_write_streams(struct netfs_write_request *);
 
 /*
  * xattr.c
diff --git a/fs/afs/write.c b/fs/afs/write.c
index e6e2e924c8ae..0668389f3466 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -13,6 +13,7 @@
 #include <linux/pagevec.h>
 #include <linux/netfs.h>
 #include <linux/fscache.h>
+#include <trace/events/netfs.h>
 #include "internal.h"
 
 static void afs_write_to_cache(struct afs_vnode *vnode, loff_t start, size_t len,
@@ -120,31 +121,9 @@ static void afs_redirty_pages(struct writeback_control *wbc,
  */
 static void afs_pages_written_back(struct afs_vnode *vnode, loff_t start, unsigned int len)
 {
-	struct address_space *mapping = vnode->vfs_inode.i_mapping;
-	struct page *page;
-	pgoff_t end;
-
-	XA_STATE(xas, &mapping->i_pages, start / PAGE_SIZE);
-
 	_enter("{%llx:%llu},{%x @%llx}",
 	       vnode->fid.vid, vnode->fid.vnode, len, start);
 
-	rcu_read_lock();
-
-	end = (start + len - 1) / PAGE_SIZE;
-	xas_for_each(&xas, page, end) {
-		if (!PageWriteback(page)) {
-			kdebug("bad %x @%llx page %lx %lx", len, start, page->index, end);
-			ASSERT(PageWriteback(page));
-		}
-
-		trace_afs_page_dirty(vnode, tracepoint_string("clear"), page);
-		detach_page_private(page);
-		page_endio(page, true, 0);
-	}
-
-	rcu_read_unlock();
-
 	afs_prune_wb_keys(vnode);
 	_leave("");
 }
@@ -281,6 +260,39 @@ static int afs_store_data(struct afs_vnode *vnode, struct iov_iter *iter, loff_t
 	return afs_put_operation(op);
 }
 
+static void afs_upload_to_server(struct netfs_write_stream *stream,
+				 struct netfs_write_request *wreq)
+{
+	struct afs_vnode *vnode = AFS_FS_I(wreq->inode);
+	ssize_t ret;
+
+	kenter("%u", stream->index);
+
+	trace_netfs_wstr(stream, netfs_write_stream_submit);
+	ret = afs_store_data(vnode, &wreq->source, wreq->start, false);
+	netfs_write_stream_completed(stream, ret, false);
+}
+
+static void afs_upload_to_server_worker(struct work_struct *work)
+{
+	struct netfs_write_stream *stream = container_of(work, struct netfs_write_stream, work);
+	struct netfs_write_request *wreq = netfs_stream_to_wreq(stream);
+
+	afs_upload_to_server(stream, wreq);
+	netfs_put_write_request(wreq, false, netfs_wreq_trace_put_stream_work);
+}
+
+/*
+ * Add write streams to a write request.  We need to add a single stream for
+ * the server we're writing to.
+ */
+void afs_add_write_streams(struct netfs_write_request *wreq)
+{
+	kenter("");
+	netfs_set_up_write_stream(wreq, NETFS_UPLOAD_TO_SERVER,
+				  afs_upload_to_server_worker);
+}
+
 /*
  * Extend the region to be written back to include subsequent contiguously
  * dirty pages if possible, but don't sleep while doing so.
@@ -543,129 +555,6 @@ int afs_writepage(struct page *page, struct writeback_control *wbc)
 	return 0;
 }
 
-/*
- * write a region of pages back to the server
- */
-static int afs_writepages_region(struct address_space *mapping,
-				 struct writeback_control *wbc,
-				 loff_t start, loff_t end, loff_t *_next)
-{
-	struct page *page;
-	ssize_t ret;
-	int n;
-
-	_enter("%llx,%llx,", start, end);
-
-	do {
-		pgoff_t index = start / PAGE_SIZE;
-
-		n = find_get_pages_range_tag(mapping, &index, end / PAGE_SIZE,
-					     PAGECACHE_TAG_DIRTY, 1, &page);
-		if (!n)
-			break;
-
-		start = (loff_t)page->index * PAGE_SIZE; /* May regress with THPs */
-
-		_debug("wback %lx", page->index);
-
-		/* At this point we hold neither the i_pages lock nor the
-		 * page lock: the page may be truncated or invalidated
-		 * (changing page->mapping to NULL), or even swizzled
-		 * back from swapper_space to tmpfs file mapping
-		 */
-		if (wbc->sync_mode != WB_SYNC_NONE) {
-			ret = lock_page_killable(page);
-			if (ret < 0) {
-				put_page(page);
-				return ret;
-			}
-		} else {
-			if (!trylock_page(page)) {
-				put_page(page);
-				return 0;
-			}
-		}
-
-		if (page->mapping != mapping || !PageDirty(page)) {
-			start += thp_size(page);
-			unlock_page(page);
-			put_page(page);
-			continue;
-		}
-
-		if (PageWriteback(page) || PageFsCache(page)) {
-			unlock_page(page);
-			if (wbc->sync_mode != WB_SYNC_NONE) {
-				wait_on_page_writeback(page);
-#ifdef CONFIG_AFS_FSCACHE
-				wait_on_page_fscache(page);
-#endif
-			}
-			put_page(page);
-			continue;
-		}
-
-		if (!clear_page_dirty_for_io(page))
-			BUG();
-		ret = afs_write_back_from_locked_page(mapping, wbc, page, start, end);
-		put_page(page);
-		if (ret < 0) {
-			_leave(" = %zd", ret);
-			return ret;
-		}
-
-		start += ret;
-
-		cond_resched();
-	} while (wbc->nr_to_write > 0);
-
-	*_next = start;
-	_leave(" = 0 [%llx]", *_next);
-	return 0;
-}
-
-/*
- * write some of the pending data back to the server
- */
-int afs_writepages(struct address_space *mapping,
-		   struct writeback_control *wbc)
-{
-	struct afs_vnode *vnode = AFS_FS_I(mapping->host);
-	loff_t start, next;
-	int ret;
-
-	_enter("");
-
-	/* We have to be careful as we can end up racing with setattr()
-	 * truncating the pagecache since the caller doesn't take a lock here
-	 * to prevent it.
-	 */
-	if (wbc->sync_mode == WB_SYNC_ALL)
-		down_read(&vnode->validate_lock);
-	else if (!down_read_trylock(&vnode->validate_lock))
-		return 0;
-
-	if (wbc->range_cyclic) {
-		start = mapping->writeback_index * PAGE_SIZE;
-		ret = afs_writepages_region(mapping, wbc, start, LLONG_MAX, &next);
-		if (start > 0 && wbc->nr_to_write > 0 && ret == 0)
-			ret = afs_writepages_region(mapping, wbc, 0, start,
-						    &next);
-		mapping->writeback_index = next / PAGE_SIZE;
-	} else if (wbc->range_start == 0 && wbc->range_end == LLONG_MAX) {
-		ret = afs_writepages_region(mapping, wbc, 0, LLONG_MAX, &next);
-		if (wbc->nr_to_write > 0 && ret == 0)
-			mapping->writeback_index = next;
-	} else {
-		ret = afs_writepages_region(mapping, wbc,
-					    wbc->range_start, wbc->range_end, &next);
-	}
-
-	up_read(&vnode->validate_lock);
-	_leave(" = %d", ret);
-	return ret;
-}
-
 /*
  * flush any dirty pages for this process, and check for write errors.
  * - the return status from this call provides a reliable indication of
diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
index fe85581d8ac0..6fdf9e5663f7 100644
--- a/fs/netfs/internal.h
+++ b/fs/netfs/internal.h
@@ -89,7 +89,13 @@ extern atomic_t netfs_n_rh_write_failed;
 extern atomic_t netfs_n_rh_write_zskip;
 extern atomic_t netfs_n_wh_region;
 extern atomic_t netfs_n_wh_flush_group;
+extern atomic_t netfs_n_wh_upload;
+extern atomic_t netfs_n_wh_upload_done;
+extern atomic_t netfs_n_wh_upload_failed;
 extern atomic_t netfs_n_wh_wreq;
+extern atomic_t netfs_n_wh_write;
+extern atomic_t netfs_n_wh_write_done;
+extern atomic_t netfs_n_wh_write_failed;
 
 
 static inline void netfs_stat(atomic_t *stat)
diff --git a/fs/netfs/objects.c b/fs/netfs/objects.c
index 6e9b2a00076d..8926b4230d91 100644
--- a/fs/netfs/objects.c
+++ b/fs/netfs/objects.c
@@ -119,16 +119,29 @@ struct netfs_write_request *netfs_alloc_write_request(struct address_space *mapp
 	struct inode *inode = mapping->host;
 	struct netfs_i_context *ctx = netfs_i_context(inode);
 	struct netfs_write_request *wreq;
+	unsigned int n_streams = ctx->n_wstreams, i;
+	bool cached;
 
-	wreq = kzalloc(sizeof(struct netfs_write_request), GFP_KERNEL);
+	if (!is_dio && netfs_is_cache_enabled(inode)) {
+		n_streams++;
+		cached = true;
+	}
+
+	wreq = kzalloc(struct_size(wreq, streams, n_streams), GFP_KERNEL);
 	if (wreq) {
 		wreq->mapping	= mapping;
 		wreq->inode	= inode;
 		wreq->netfs_ops	= ctx->ops;
+		wreq->max_streams = n_streams;
 		wreq->debug_id	= atomic_inc_return(&debug_ids);
+		if (cached)
+			__set_bit(NETFS_WREQ_WRITE_TO_CACHE, &wreq->flags);
 		xa_init(&wreq->buffer);
 		INIT_WORK(&wreq->work, netfs_writeback_worker);
+		for (i = 0; i < n_streams; i++)
+			INIT_LIST_HEAD(&wreq->streams[i].subrequests);
 		refcount_set(&wreq->usage, 1);
+		atomic_set(&wreq->outstanding, 1);
 		ctx->ops->init_wreq(wreq);
 		netfs_stat(&netfs_n_wh_wreq);
 		trace_netfs_ref_wreq(wreq->debug_id, 1, netfs_wreq_trace_new);
@@ -170,6 +183,15 @@ void netfs_free_write_request(struct work_struct *work)
 	netfs_stat_d(&netfs_n_wh_wreq);
 }
 
+/**
+ * netfs_put_write_request - Drop a reference on a write request descriptor.
+ * @wreq: The write request to drop
+ * @was_async: True if being called in a non-sleeping context
+ * @what: Reason code, to be displayed in trace line
+ *
+ * Drop a reference on a write request and schedule it for destruction
+ * after the last ref is gone.
+ */
 void netfs_put_write_request(struct netfs_write_request *wreq,
 			     bool was_async, enum netfs_wreq_trace what)
 {
@@ -189,3 +211,4 @@ void netfs_put_write_request(struct netfs_write_request *wreq,
 		}
 	}
 }
+EXPORT_SYMBOL(netfs_put_write_request);
diff --git a/fs/netfs/stats.c b/fs/netfs/stats.c
index ac2510f8cab0..a02d95bba158 100644
--- a/fs/netfs/stats.c
+++ b/fs/netfs/stats.c
@@ -30,6 +30,12 @@ atomic_t netfs_n_rh_write_zskip;
 atomic_t netfs_n_wh_region;
 atomic_t netfs_n_wh_flush_group;
 atomic_t netfs_n_wh_wreq;
+atomic_t netfs_n_wh_upload;
+atomic_t netfs_n_wh_upload_done;
+atomic_t netfs_n_wh_upload_failed;
+atomic_t netfs_n_wh_write;
+atomic_t netfs_n_wh_write_done;
+atomic_t netfs_n_wh_write_failed;
 
 void netfs_stats_show(struct seq_file *m)
 {
@@ -61,5 +67,13 @@ void netfs_stats_show(struct seq_file *m)
 		   atomic_read(&netfs_n_wh_region),
 		   atomic_read(&netfs_n_wh_flush_group),
 		   atomic_read(&netfs_n_wh_wreq));
+	seq_printf(m, "WrHelp : UL=%u us=%u uf=%u\n",
+		   atomic_read(&netfs_n_wh_upload),
+		   atomic_read(&netfs_n_wh_upload_done),
+		   atomic_read(&netfs_n_wh_upload_failed));
+	seq_printf(m, "WrHelp : WR=%u ws=%u wf=%u\n",
+		   atomic_read(&netfs_n_wh_write),
+		   atomic_read(&netfs_n_wh_write_done),
+		   atomic_read(&netfs_n_wh_write_failed));
 }
 EXPORT_SYMBOL(netfs_stats_show);
diff --git a/fs/netfs/write_back.c b/fs/netfs/write_back.c
index 5c779cb12345..15cc0e1b9acf 100644
--- a/fs/netfs/write_back.c
+++ b/fs/netfs/write_back.c
@@ -11,12 +11,259 @@
 #include <linux/slab.h>
 #include "internal.h"
 
+static int netfs_redirty_iterator(struct xa_state *xas, struct page *page)
+{
+	__set_page_dirty_nobuffers(page);
+	account_page_redirty(page);
+	end_page_writeback(page);
+	return 0;
+}
+
+/*
+ * Redirty all the pages in a given range.
+ */
+static void netfs_redirty_pages(struct netfs_write_request *wreq)
+{
+	_enter("%lx-%lx", wreq->first, wreq->last);
+
+	netfs_iterate_pinned_pages(wreq->mapping, wreq->first, wreq->last,
+				   netfs_redirty_iterator);
+	_leave("");
+}
+
+static int netfs_end_writeback_iterator(struct xa_state *xas, struct page *page)
+{
+	end_page_writeback(page);
+	return 0;
+}
+
+/*
+ * Fix up the dirty list upon completion of write.
+ */
+static void netfs_fix_up_dirty_list(struct netfs_write_request *wreq)
+{
+	struct netfs_dirty_region *region = wreq->region, *r;
+	struct netfs_i_context *ctx = netfs_i_context(wreq->inode);
+	unsigned long long available_to;
+	struct list_head *lower, *upper, *p;
+
+	netfs_iterate_pinned_pages(wreq->mapping, wreq->first, wreq->last,
+				   netfs_end_writeback_iterator);
+
+	spin_lock(&ctx->lock);
+
+	/* Find the bounds of the region we're going to make available. */
+	lower = &ctx->dirty_regions;
+	r = region;
+	list_for_each_entry_continue_reverse(r, &ctx->dirty_regions, dirty_link) {
+		_debug("- back %x", r->debug_id);
+		if (r->state >= NETFS_REGION_IS_DIRTY) {
+			lower = &r->dirty_link;
+			break;
+		}
+	}
+
+	available_to = ULLONG_MAX;
+	upper = &ctx->dirty_regions;
+	r = region;
+	list_for_each_entry_continue(r, &ctx->dirty_regions, dirty_link) {
+		_debug("- forw %x", r->debug_id);
+		if (r->state >= NETFS_REGION_IS_DIRTY) {
+			available_to = r->dirty.start;
+			upper = &r->dirty_link;
+			break;
+		}
+	}
+
+	/* Remove this region and we can start any waiters that are wholly
+	 * inside of the now-available region.
+	 */
+	list_del_init(&region->dirty_link);
+
+	for (p = lower->next; p != upper; p = p->next) {
+		r = list_entry(p, struct netfs_dirty_region, dirty_link);
+		if (r->reserved.end <= available_to) {
+			smp_store_release(&r->state, NETFS_REGION_IS_ACTIVE);
+			trace_netfs_dirty(ctx, r, NULL, netfs_dirty_trace_activate);
+			wake_up_var(&r->state);
+		}
+	}
+
+	spin_unlock(&ctx->lock);
+	netfs_put_dirty_region(ctx, region, netfs_region_trace_put_dirty);
+}
+
+/*
+ * Process a completed write request once all the component streams have been
+ * completed.
+ */
+static void netfs_write_completed(struct netfs_write_request *wreq, bool was_async)
+{
+	struct netfs_i_context *ctx = netfs_i_context(wreq->inode);
+	unsigned int s;
+
+	for (s = 0; s < wreq->n_streams; s++) {
+		struct netfs_write_stream *stream = &wreq->streams[s];
+		if (!stream->error)
+			continue;
+		switch (stream->dest) {
+		case NETFS_UPLOAD_TO_SERVER:
+			/* Depending on the type of failure, this may prevent
+			 * writeback completion unless we're in disconnected
+			 * mode.
+			 */
+			if (!wreq->error)
+				wreq->error = stream->error;
+			break;
+
+		case NETFS_WRITE_TO_CACHE:
+			/* Failure doesn't prevent writeback completion unless
+			 * we're in disconnected mode.
+			 */
+			if (stream->error != -ENOBUFS)
+				ctx->ops->invalidate_cache(wreq);
+			break;
+
+		default:
+			WARN_ON_ONCE(1);
+			if (!wreq->error)
+				wreq->error = -EIO;
+			return;
+		}
+	}
+
+	if (wreq->error)
+		netfs_redirty_pages(wreq);
+	else
+		netfs_fix_up_dirty_list(wreq);
+	netfs_put_write_request(wreq, was_async, netfs_wreq_trace_put_for_outstanding);
+}
+
+/*
+ * Deal with the completion of writing the data to the cache.
+ */
+void netfs_write_stream_completed(void *_stream, ssize_t transferred_or_error,
+				  bool was_async)
+{
+	struct netfs_write_stream *stream = _stream;
+	struct netfs_write_request *wreq = netfs_stream_to_wreq(stream);
+
+	if (IS_ERR_VALUE(transferred_or_error))
+		stream->error = transferred_or_error;
+	switch (stream->dest) {
+	case NETFS_UPLOAD_TO_SERVER:
+		if (stream->error)
+			netfs_stat(&netfs_n_wh_upload_failed);
+		else
+			netfs_stat(&netfs_n_wh_upload_done);
+		break;
+	case NETFS_WRITE_TO_CACHE:
+		if (stream->error)
+			netfs_stat(&netfs_n_wh_write_failed);
+		else
+			netfs_stat(&netfs_n_wh_write_done);
+		break;
+	case NETFS_INVALID_WRITE:
+		break;
+	}
+
+	trace_netfs_wstr(stream, netfs_write_stream_complete);
+	if (atomic_dec_and_test(&wreq->outstanding))
+		netfs_write_completed(wreq, was_async);
+}
+EXPORT_SYMBOL(netfs_write_stream_completed);
+
+static void netfs_write_to_cache_stream(struct netfs_write_stream *stream,
+					struct netfs_write_request *wreq)
+{
+	trace_netfs_wstr(stream, netfs_write_stream_submit);
+	fscache_write_to_cache(netfs_i_cookie(wreq->inode), wreq->mapping,
+			       wreq->start, wreq->len, wreq->region->i_size,
+			       netfs_write_stream_completed, stream);
+}
+
+static void netfs_write_to_cache_stream_worker(struct work_struct *work)
+{
+	struct netfs_write_stream *stream = container_of(work, struct netfs_write_stream, work);
+	struct netfs_write_request *wreq = netfs_stream_to_wreq(stream);
+
+	netfs_write_to_cache_stream(stream, wreq);
+	netfs_put_write_request(wreq, false, netfs_wreq_trace_put_stream_work);
+}
+
+/**
+ * netfs_set_up_write_stream - Allocate, set up and launch a write stream.
+ * @wreq: The write request this is storing from.
+ * @dest: The destination type
+ * @worker: The worker function to handle the write(s)
+ *
+ * Allocate the next write stream from a write request and queue the worker to
+ * make it happen.
+ */
+void netfs_set_up_write_stream(struct netfs_write_request *wreq,
+			       enum netfs_write_dest dest, work_func_t worker)
+{
+	struct netfs_write_stream *stream;
+	unsigned int s = wreq->n_streams++;
+
+	kenter("%u,%u", s, dest);
+
+	stream		= &wreq->streams[s];
+	stream->dest	= dest;
+	stream->index	= s;
+	INIT_WORK(&stream->work, worker);
+	atomic_inc(&wreq->outstanding);
+	trace_netfs_wstr(stream, netfs_write_stream_setup);
+
+	switch (stream->dest) {
+	case NETFS_UPLOAD_TO_SERVER:
+		netfs_stat(&netfs_n_wh_upload);
+		break;
+	case NETFS_WRITE_TO_CACHE:
+		netfs_stat(&netfs_n_wh_write);
+		break;
+	case NETFS_INVALID_WRITE:
+		BUG();
+	}
+
+	netfs_get_write_request(wreq, netfs_wreq_trace_get_stream_work);
+	if (!queue_work(system_unbound_wq, &stream->work))
+		netfs_put_write_request(wreq, false, netfs_wreq_trace_put_discard);
+}
+EXPORT_SYMBOL(netfs_set_up_write_stream);
+
+/*
+ * Set up a stream for writing to the cache.
+ */
+static void netfs_set_up_write_to_cache(struct netfs_write_request *wreq)
+{
+	netfs_set_up_write_stream(wreq, NETFS_WRITE_TO_CACHE,
+				  netfs_write_to_cache_stream_worker);
+}
+
 /*
  * Process a write request.
+ *
+ * All the pages in the bounding box have had a ref taken on them and those
+ * covering the dirty region have been marked as being written back and their
+ * dirty bits provisionally cleared.
  */
 static void netfs_writeback(struct netfs_write_request *wreq)
 {
-	kdebug("--- WRITE ---");
+	struct netfs_i_context *ctx = netfs_i_context(wreq->inode);
+
+	kenter("");
+
+	/* TODO: Encrypt or compress the region as appropriate */
+
+	/* ->outstanding > 0 carries a ref */
+	netfs_get_write_request(wreq, netfs_wreq_trace_get_for_outstanding);
+
+	if (test_bit(NETFS_WREQ_WRITE_TO_CACHE, &wreq->flags))
+		netfs_set_up_write_to_cache(wreq);
+	ctx->ops->add_write_streams(wreq);
+	if (atomic_dec_and_test(&wreq->outstanding))
+		netfs_write_completed(wreq, false);
 }
 
 void netfs_writeback_worker(struct work_struct *work)
diff --git a/fs/netfs/write_helper.c b/fs/netfs/write_helper.c
index a8c58eaa84d0..fa048e3882ea 100644
--- a/fs/netfs/write_helper.c
+++ b/fs/netfs/write_helper.c
@@ -139,18 +139,30 @@ static enum netfs_write_compatibility netfs_write_compatibility(
 	struct netfs_dirty_region *old,
 	struct netfs_dirty_region *candidate)
 {
-	if (old->type == NETFS_REGION_DIO ||
-	    old->type == NETFS_REGION_DSYNC ||
-	    old->state >= NETFS_REGION_IS_FLUSHING ||
-	    /* The bounding boxes of DSYNC writes can overlap with those of
-	     * other DSYNC writes and ordinary writes.
-	     */
+	/* Regions being actively flushed can't be merged with */
+	if (old->state >= NETFS_REGION_IS_FLUSHING ||
 	    candidate->group != old->group ||
-	    old->group->flush)
+	    old->group->flush) {
+		kleave(" = INCOM [flush]");
 		return NETFS_WRITES_INCOMPATIBLE;
+	}
+
+	/* The bounding boxes of DSYNC writes can overlap with those of other
+	 * DSYNC writes and ordinary writes.  DIO writes cannot overlap at all.
+	 */
+	if (candidate->type == NETFS_REGION_DIO ||
+	    old->type == NETFS_REGION_DIO ||
+	    old->type == NETFS_REGION_DSYNC) {
+		kleave(" = INCOM [dio/dsy]");
+		return NETFS_WRITES_INCOMPATIBLE;
+	}
+
 	if (!ctx->ops->is_write_compatible) {
-		if (candidate->type == NETFS_REGION_DSYNC)
+		if (candidate->type == NETFS_REGION_DSYNC) {
+			kleave(" = SUPER [dsync]");
 			return NETFS_WRITES_SUPERSEDE;
+		}
+		kleave(" = COMPT");
 		return NETFS_WRITES_COMPATIBLE;
 	}
 	return ctx->ops->is_write_compatible(ctx, old, candidate);
diff --git a/fs/netfs/xa_iterator.h b/fs/netfs/xa_iterator.h
index 3f37827f0f99..67e1daa964ab 100644
--- a/fs/netfs/xa_iterator.h
+++ b/fs/netfs/xa_iterator.h
@@ -5,6 +5,37 @@
  * Written by David Howells (dhowells@redhat.com)
  */
 
+/*
+ * Iterate over a set of pages that we hold pinned with the writeback flag.
+ * The iteration function may drop the RCU read lock, but should call
+ * xas_pause() before it does so.
+ */
+#define netfs_iterate_pinned_pages(MAPPING, START, END, ITERATOR, ...)	\
+	({								\
+		struct page *page;					\
+		pgoff_t __it_start = (START);				\
+		pgoff_t __it_end = (END);				\
+		int ret = 0;						\
+									\
+		XA_STATE(xas, &(MAPPING)->i_pages, __it_start);		\
+		rcu_read_lock();					\
+		for (page = xas_load(&xas); page; page = xas_next_entry(&xas, __it_end)) { \
+			if (xas_retry(&xas, page))			\
+				continue;				\
+			if (xa_is_value(page))				\
+				break;					\
+			if (unlikely(page != xas_reload(&xas))) {	\
+				xas_reset(&xas);			\
+				continue;				\
+			}						\
+			ret = ITERATOR(&xas, page, ##__VA_ARGS__);	\
+			if (ret < 0)					\
+				break;					\
+		}							\
+		rcu_read_unlock();					\
+		ret;							\
+	})
+
 /*
  * Iterate over a range of pages.  xarray locks are not held over the iterator
  * function, so it can sleep if necessary.  The start and end positions are
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 9f874e7ed45a..9d50c2933863 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -19,6 +19,8 @@
 #include <linux/pagemap.h>
 #include <linux/uio.h>
 
+enum netfs_wreq_trace;
+
 /*
  * Overload PG_private_2 to give us PG_fscache - this is used to indicate that
  * a page is currently backed by a local disk cache
@@ -180,6 +182,7 @@ struct netfs_i_context {
 	unsigned int		wsize;		/* Maximum write size */
 	unsigned int		bsize;		/* Min block size for bounding box */
 	unsigned int		inval_counter;	/* Number of invalidations made */
+	unsigned char		n_wstreams;	/* Number of write streams to allocate */
 };
 
 /*
@@ -242,12 +245,53 @@ struct netfs_dirty_region {
 	refcount_t		ref;
 };
 
+enum netfs_write_dest {
+	NETFS_UPLOAD_TO_SERVER,
+	NETFS_WRITE_TO_CACHE,
+	NETFS_INVALID_WRITE,
+} __mode(byte);
+
+/*
+ * Descriptor for a write subrequest.  Each subrequest represents an individual
+ * write to a server or a cache.
+ */
+struct netfs_write_subrequest {
+	struct netfs_write_request *wreq;	/* Supervising write request */
+	struct list_head	stream_link;	/* Link in stream->subrequests */
+	loff_t			start;		/* Where to start the I/O */
+	size_t			len;		/* Size of the I/O */
+	size_t			transferred;	/* Amount of data transferred */
+	refcount_t		usage;
+	short			error;		/* 0 or error that occurred */
+	unsigned short		debug_index;	/* Index in list (for debugging output) */
+	unsigned char		stream_index;	/* Which stream we're part of */
+	enum netfs_write_dest	dest;		/* Where to write to */
+};
+
+/*
+ * Descriptor for a write stream.  Each stream represents a sequence of writes
+ * to a destination, where a stream covers the entirety of the write request.
+ * All of a stream goes to the same destination - and that destination might be
+ * a server, a cache, a journal.
+ *
+ * Each stream may be split up into separate subrequests according to different
+ * rules.
+ */
+struct netfs_write_stream {
+	struct work_struct	work;
+	struct list_head	subrequests;	/* The subrequests comprising this stream */
+	enum netfs_write_dest	dest;		/* Where to write to */
+	unsigned char		index;		/* Index in wreq->streams[] */
+	short			error;		/* 0 or error that occurred */
+};
+
 /*
  * Descriptor for a write request.  This is used to manage the preparation and
  * storage of a sequence of dirty data - its compression/encryption and its
  * writing to one or more servers and the cache.
  *
- * The prepared data is buffered here.
+ * The prepared data is buffered here, and then the streams are used to
+ * distribute the buffer to various destinations (servers, caches, etc.).
  */
 struct netfs_write_request {
 	struct work_struct	work;
@@ -260,15 +304,20 @@ struct netfs_write_request {
 	struct list_head	write_link;	/* Link in i_context->write_requests */
 	void			*netfs_priv;	/* Private data for the netfs */
 	unsigned int		debug_id;
+	unsigned char		max_streams;	/* Number of streams allocated */
+	unsigned char		n_streams;	/* Number of streams in use */
 	short			error;		/* 0 or error that occurred */
 	loff_t			i_size;		/* Size of the file */
 	loff_t			start;		/* Start position */
 	size_t			len;		/* Length of the request */
 	pgoff_t			first;		/* First page included */
 	pgoff_t			last;		/* Last page included */
+	atomic_t		outstanding;	/* Number of outstanding writes */
 	refcount_t		usage;
 	unsigned long		flags;
+#define NETFS_WREQ_WRITE_TO_CACHE	0	/* Need to write to the cache */
 	const struct netfs_request_ops *netfs_ops;
+	struct netfs_write_stream streams[];	/* Individual write streams */
 };
 
 enum netfs_write_compatibility {
@@ -307,6 +356,8 @@ struct netfs_request_ops {
 
 	/* Write request handling */
 	void (*init_wreq)(struct netfs_write_request *wreq);
+	void (*add_write_streams)(struct netfs_write_request *wreq);
+	void (*invalidate_cache)(struct netfs_write_request *wreq);
 };
 
 /*
@@ -363,6 +414,12 @@ extern int netfs_releasepage(struct page *page, gfp_t gfp_flags);
 extern void netfs_subreq_terminated(struct netfs_read_subrequest *, ssize_t, bool);
 extern void netfs_stats_show(struct seq_file *);
 extern struct netfs_flush_group *netfs_new_flush_group(struct inode *, void *);
+extern void netfs_set_up_write_stream(struct netfs_write_request *wreq,
+				      enum netfs_write_dest dest, work_func_t worker);
+extern void netfs_put_write_request(struct netfs_write_request *wreq,
+				    bool was_async, enum netfs_wreq_trace what);
+extern void netfs_write_stream_completed(void *_stream, ssize_t transferred_or_error,
+					 bool was_async);
 
 /**
  * netfs_i_context - Get the netfs inode context from the inode
@@ -407,4 +464,10 @@ static inline struct fscache_cookie *netfs_i_cookie(struct inode *inode)
 #endif
 }
 
+static inline
+struct netfs_write_request *netfs_stream_to_wreq(struct netfs_write_stream *stream)
+{
+	return container_of(stream, struct netfs_write_request, streams[stream->index]);
+}
+
 #endif /* _LINUX_NETFS_H */
diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
index e70abb5033e6..aa002725b209 100644
--- a/include/trace/events/netfs.h
+++ b/include/trace/events/netfs.h
@@ -59,6 +59,7 @@ enum netfs_failure {
 
 enum netfs_dirty_trace {
 	netfs_dirty_trace_active,
+	netfs_dirty_trace_activate,
 	netfs_dirty_trace_commit,
 	netfs_dirty_trace_complete,
 	netfs_dirty_trace_flush_conflict,
@@ -82,6 +83,7 @@ enum netfs_dirty_trace {
 enum netfs_region_trace {
 	netfs_region_trace_get_dirty,
 	netfs_region_trace_get_wreq,
+	netfs_region_trace_put_dirty,
 	netfs_region_trace_put_discard,
 	netfs_region_trace_put_merged,
 	netfs_region_trace_put_wreq,
@@ -92,12 +94,22 @@ enum netfs_region_trace {
 
 enum netfs_wreq_trace {
 	netfs_wreq_trace_free,
+	netfs_wreq_trace_get_for_outstanding,
+	netfs_wreq_trace_get_stream_work,
 	netfs_wreq_trace_put_discard,
+	netfs_wreq_trace_put_for_outstanding,
+	netfs_wreq_trace_put_stream_work,
 	netfs_wreq_trace_put_work,
 	netfs_wreq_trace_see_work,
 	netfs_wreq_trace_new,
 };
 
+enum netfs_write_stream_trace {
+	netfs_write_stream_complete,
+	netfs_write_stream_setup,
+	netfs_write_stream_submit,
+};
+
 #endif
 
 #define netfs_read_traces					\
@@ -156,6 +168,7 @@ enum netfs_wreq_trace {
 
 #define netfs_dirty_traces					\
 	EM(netfs_dirty_trace_active,		"ACTIVE    ")	\
+	EM(netfs_dirty_trace_activate,		"ACTIVATE  ")	\
 	EM(netfs_dirty_trace_commit,		"COMMIT    ")	\
 	EM(netfs_dirty_trace_complete,		"COMPLETE  ")	\
 	EM(netfs_dirty_trace_flush_conflict,	"FLSH CONFL")	\
@@ -178,6 +191,7 @@ enum netfs_wreq_trace {
 #define netfs_region_traces					\
 	EM(netfs_region_trace_get_dirty,	"GET DIRTY  ")	\
 	EM(netfs_region_trace_get_wreq,		"GET WREQ   ")	\
+	EM(netfs_region_trace_put_dirty,	"PUT DIRTY  ")	\
 	EM(netfs_region_trace_put_discard,	"PUT DISCARD")	\
 	EM(netfs_region_trace_put_merged,	"PUT MERGED ")	\
 	EM(netfs_region_trace_put_wreq,		"PUT WREQ   ")	\
@@ -187,11 +201,24 @@ enum netfs_wreq_trace {
 
 #define netfs_wreq_traces					\
 	EM(netfs_wreq_trace_free,		"FREE       ")	\
+	EM(netfs_wreq_trace_get_for_outstanding,"GET OUTSTND")	\
+	EM(netfs_wreq_trace_get_stream_work,	"GET S-WORK ")	\
 	EM(netfs_wreq_trace_put_discard,	"PUT DISCARD")	\
+	EM(netfs_wreq_trace_put_for_outstanding,"PUT OUTSTND")	\
+	EM(netfs_wreq_trace_put_stream_work,	"PUT S-WORK  ")	\
 	EM(netfs_wreq_trace_put_work,		"PUT WORK   ")	\
 	EM(netfs_wreq_trace_see_work,		"SEE WORK   ")	\
 	E_(netfs_wreq_trace_new,		"NEW        ")
 
+#define netfs_write_destinations				\
+	EM(NETFS_UPLOAD_TO_SERVER,		"UPLD")		\
+	EM(NETFS_WRITE_TO_CACHE,		"WRIT")		\
+	E_(NETFS_INVALID_WRITE,			"INVL")
+
+#define netfs_write_stream_traces		\
+	EM(netfs_write_stream_complete,		"DONE ")	\
+	EM(netfs_write_stream_setup,		"SETUP")	\
+	E_(netfs_write_stream_submit,		"SUBMT")
 
 /*
  * Export enum symbols via userspace.
@@ -210,6 +237,8 @@ netfs_region_types;
 netfs_region_states;
 netfs_dirty_traces;
 netfs_wreq_traces;
+netfs_write_destinations;
+netfs_write_stream_traces;
 
 /*
  * Now redefine the EM() and E_() macros to map the enums to the strings that
@@ -507,6 +536,38 @@ TRACE_EVENT(netfs_ref_wreq,
 		      __entry->ref)
 	    );
 
+TRACE_EVENT(netfs_wstr,
+	    TP_PROTO(struct netfs_write_stream *stream,
+		     enum netfs_write_stream_trace what),
+
+	    TP_ARGS(stream, what),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,		wreq		)
+		    __field(unsigned char,		stream		)
+		    __field(short,			error		)
+		    __field(unsigned short,		flags		)
+		    __field(enum netfs_write_dest,	dest		)
+		    __field(enum netfs_write_stream_trace, what		)
+			     ),
+
+	    TP_fast_assign(
+		    struct netfs_write_request *wreq =
+		    container_of(stream, struct netfs_write_request, streams[stream->index]);
+		    __entry->wreq	= wreq->debug_id;
+		    __entry->stream	= stream->index;
+		    __entry->error	= stream->error;
+		    __entry->dest	= stream->dest;
+		    __entry->what	= what;
+			   ),
+
+	    TP_printk("W=%08x[%u] %s %s e=%d",
+		      __entry->wreq, __entry->stream,
+		      __print_symbolic(__entry->what, netfs_write_stream_traces),
+		      __print_symbolic(__entry->dest, netfs_write_destinations),
+		      __entry->error)
+	    );
+
 #endif /* _TRACE_NETFS_H */
 
 /* This part must be outside protection */


