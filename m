Return-Path: <linux-fsdevel+bounces-5949-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6261C811766
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 16:39:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BB091F21B3F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 15:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB7283B06;
	Wed, 13 Dec 2023 15:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FokDq/mN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3534C26A9
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Dec 2023 07:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702481212;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6OpDWo92EAz8lnWtd0lrwWk2hVduMlXr4iw80i0tX5o=;
	b=FokDq/mN+J7sDqfEn1V1OmMuf6olbpA3kzf8a6Vbss44lym1zVIJticFS45zPnOu+FJNjd
	dY9+iCT6dV47wUGGaTRoO1X1+vvzTK6juauaMMdoH7LxuuB1CEHIhR7zsJxjZ7TaCjEq1h
	pJ578X+jiMVZmKpuNEAYKJ1XmFxsXDo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-42-WI5voJDsOmKzc7ZEW8vdYQ-1; Wed,
 13 Dec 2023 10:26:49 -0500
X-MC-Unique: WI5voJDsOmKzc7ZEW8vdYQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C1F3729AB400;
	Wed, 13 Dec 2023 15:26:47 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.2])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 34DCE51E3;
	Wed, 13 Dec 2023 15:26:44 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Jeff Layton <jlayton@kernel.org>,
	Steve French <smfrench@gmail.com>
Cc: David Howells <dhowells@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Marc Dionne <marc.dionne@auristor.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	Christian Brauner <christian@brauner.io>,
	linux-cachefs@redhat.com,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 38/39] afs: Use the netfs write helpers
Date: Wed, 13 Dec 2023 15:23:48 +0000
Message-ID: <20231213152350.431591-39-dhowells@redhat.com>
In-Reply-To: <20231213152350.431591-1-dhowells@redhat.com>
References: <20231213152350.431591-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

Make afs use the netfs write helpers.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-afs@lists.infradead.org
cc: linux-cachefs@redhat.com
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
---
 fs/afs/file.c              |  70 +++-
 fs/afs/internal.h          |  10 +-
 fs/afs/write.c             | 705 ++-----------------------------------
 include/trace/events/afs.h |  23 --
 4 files changed, 84 insertions(+), 724 deletions(-)

diff --git a/fs/afs/file.c b/fs/afs/file.c
index aa95b4d6376c..3d33b221d9ca 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -34,7 +34,7 @@ const struct file_operations afs_file_operations = {
 	.release	= afs_release,
 	.llseek		= generic_file_llseek,
 	.read_iter	= afs_file_read_iter,
-	.write_iter	= afs_file_write,
+	.write_iter	= netfs_file_write_iter,
 	.mmap		= afs_file_mmap,
 	.splice_read	= afs_file_splice_read,
 	.splice_write	= iter_file_splice_write,
@@ -50,16 +50,15 @@ const struct inode_operations afs_file_inode_operations = {
 };
 
 const struct address_space_operations afs_file_aops = {
+	.direct_IO	= noop_direct_IO,
 	.read_folio	= netfs_read_folio,
 	.readahead	= netfs_readahead,
 	.dirty_folio	= netfs_dirty_folio,
-	.launder_folio	= afs_launder_folio,
+	.launder_folio	= netfs_launder_folio,
 	.release_folio	= netfs_release_folio,
 	.invalidate_folio = netfs_invalidate_folio,
-	.write_begin	= afs_write_begin,
-	.write_end	= afs_write_end,
-	.writepages	= afs_writepages,
 	.migrate_folio	= filemap_migrate_folio,
+	.writepages	= afs_writepages,
 };
 
 const struct address_space_operations afs_symlink_aops = {
@@ -352,7 +351,10 @@ static int afs_symlink_read_folio(struct file *file, struct folio *folio)
 
 static int afs_init_request(struct netfs_io_request *rreq, struct file *file)
 {
-	rreq->netfs_priv = key_get(afs_file_key(file));
+	if (file)
+		rreq->netfs_priv = key_get(afs_file_key(file));
+	rreq->rsize = 256 * 1024;
+	rreq->wsize = 256 * 1024;
 	return 0;
 }
 
@@ -369,11 +371,36 @@ static void afs_free_request(struct netfs_io_request *rreq)
 	key_put(rreq->netfs_priv);
 }
 
+static void afs_update_i_size(struct inode *inode, loff_t new_i_size)
+{
+	struct afs_vnode *vnode = AFS_FS_I(inode);
+	loff_t i_size;
+
+	write_seqlock(&vnode->cb_lock);
+	i_size = i_size_read(&vnode->netfs.inode);
+	if (new_i_size > i_size) {
+		i_size_write(&vnode->netfs.inode, new_i_size);
+		inode_set_bytes(&vnode->netfs.inode, new_i_size);
+	}
+	write_sequnlock(&vnode->cb_lock);
+	fscache_update_cookie(afs_vnode_cache(vnode), NULL, &new_i_size);
+}
+
+static void afs_netfs_invalidate_cache(struct netfs_io_request *wreq)
+{
+	struct afs_vnode *vnode = AFS_FS_I(wreq->inode);
+
+	afs_invalidate_cache(vnode, 0);
+}
+
 const struct netfs_request_ops afs_req_ops = {
 	.init_request		= afs_init_request,
 	.free_request		= afs_free_request,
 	.check_write_begin	= afs_check_write_begin,
 	.issue_read		= afs_issue_read,
+	.update_i_size		= afs_update_i_size,
+	.invalidate_cache	= afs_netfs_invalidate_cache,
+	.create_write_requests	= afs_create_write_requests,
 };
 
 static void afs_add_open_mmap(struct afs_vnode *vnode)
@@ -441,28 +468,39 @@ static vm_fault_t afs_vm_map_pages(struct vm_fault *vmf, pgoff_t start_pgoff, pg
 
 static ssize_t afs_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 {
-	struct afs_vnode *vnode = AFS_FS_I(file_inode(iocb->ki_filp));
+	struct inode *inode = file_inode(iocb->ki_filp);
+	struct afs_vnode *vnode = AFS_FS_I(inode);
 	struct afs_file *af = iocb->ki_filp->private_data;
-	int ret;
+	ssize_t ret;
 
-	ret = afs_validate(vnode, af->key);
+	if (iocb->ki_flags & IOCB_DIRECT)
+		return netfs_unbuffered_read_iter(iocb, iter);
+
+	ret = netfs_start_io_read(inode);
 	if (ret < 0)
 		return ret;
-
-	return generic_file_read_iter(iocb, iter);
+	ret = afs_validate(vnode, af->key);
+	if (ret == 0)
+		ret = filemap_read(iocb, iter, 0);
+	netfs_end_io_read(inode);
+	return ret;
 }
 
 static ssize_t afs_file_splice_read(struct file *in, loff_t *ppos,
 				    struct pipe_inode_info *pipe,
 				    size_t len, unsigned int flags)
 {
-	struct afs_vnode *vnode = AFS_FS_I(file_inode(in));
+	struct inode *inode = file_inode(in);
+	struct afs_vnode *vnode = AFS_FS_I(inode);
 	struct afs_file *af = in->private_data;
-	int ret;
+	ssize_t ret;
 
-	ret = afs_validate(vnode, af->key);
+	ret = netfs_start_io_read(inode);
 	if (ret < 0)
 		return ret;
-
-	return filemap_splice_read(in, ppos, pipe, len, flags);
+	ret = afs_validate(vnode, af->key);
+	if (ret == 0)
+		ret = filemap_splice_read(in, ppos, pipe, len, flags);
+	netfs_end_io_read(inode);
+	return ret;
 }
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index b638c0f87298..326eba1c89c7 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -1601,19 +1601,11 @@ bool afs_try_get_volume(struct afs_volume *volume, enum afs_volume_trace reason)
 /*
  * write.c
  */
-extern int afs_write_begin(struct file *file, struct address_space *mapping,
-			loff_t pos, unsigned len,
-			struct page **pagep, void **fsdata);
-extern int afs_write_end(struct file *file, struct address_space *mapping,
-			loff_t pos, unsigned len, unsigned copied,
-			struct page *page, void *fsdata);
-extern int afs_writepage(struct page *, struct writeback_control *);
 extern int afs_writepages(struct address_space *, struct writeback_control *);
-extern ssize_t afs_file_write(struct kiocb *, struct iov_iter *);
 extern int afs_fsync(struct file *, loff_t, loff_t, int);
 extern vm_fault_t afs_page_mkwrite(struct vm_fault *vmf);
 extern void afs_prune_wb_keys(struct afs_vnode *);
-int afs_launder_folio(struct folio *);
+void afs_create_write_requests(struct netfs_io_request *wreq, loff_t start, size_t len);
 
 /*
  * xattr.c
diff --git a/fs/afs/write.c b/fs/afs/write.c
index 959dfa8f1af0..74402d95a884 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -12,228 +12,17 @@
 #include <linux/writeback.h>
 #include <linux/pagevec.h>
 #include <linux/netfs.h>
+#include <trace/events/netfs.h>
 #include "internal.h"
 
-static int afs_writepages_region(struct address_space *mapping,
-				 struct writeback_control *wbc,
-				 unsigned long long start,
-				 unsigned long long end, loff_t *_next,
-				 bool max_one_loop);
-
-static void afs_write_to_cache(struct afs_vnode *vnode, loff_t start, size_t len,
-			       loff_t i_size, bool caching);
-
-#ifdef CONFIG_AFS_FSCACHE
-static void afs_folio_start_fscache(bool caching, struct folio *folio)
-{
-	if (caching)
-		folio_start_fscache(folio);
-}
-#else
-static void afs_folio_start_fscache(bool caching, struct folio *folio)
-{
-}
-#endif
-
-/*
- * prepare to perform part of a write to a page
- */
-int afs_write_begin(struct file *file, struct address_space *mapping,
-		    loff_t pos, unsigned len,
-		    struct page **_page, void **fsdata)
-{
-	struct afs_vnode *vnode = AFS_FS_I(file_inode(file));
-	struct folio *folio;
-	int ret;
-
-	_enter("{%llx:%llu},%llx,%x",
-	       vnode->fid.vid, vnode->fid.vnode, pos, len);
-
-	/* Prefetch area to be written into the cache if we're caching this
-	 * file.  We need to do this before we get a lock on the page in case
-	 * there's more than one writer competing for the same cache block.
-	 */
-	ret = netfs_write_begin(&vnode->netfs, file, mapping, pos, len, &folio, fsdata);
-	if (ret < 0)
-		return ret;
-
-try_again:
-	/* See if this page is already partially written in a way that we can
-	 * merge the new write with.
-	 */
-	if (folio_test_writeback(folio)) {
-		trace_afs_folio_dirty(vnode, tracepoint_string("alrdy"), folio);
-		folio_unlock(folio);
-		goto wait_for_writeback;
-	}
-
-	*_page = folio_file_page(folio, pos / PAGE_SIZE);
-	_leave(" = 0");
-	return 0;
-
-wait_for_writeback:
-	ret = folio_wait_writeback_killable(folio);
-	if (ret < 0)
-		goto error;
-
-	ret = folio_lock_killable(folio);
-	if (ret < 0)
-		goto error;
-	goto try_again;
-
-error:
-	folio_put(folio);
-	_leave(" = %d", ret);
-	return ret;
-}
-
-/*
- * finalise part of a write to a page
- */
-int afs_write_end(struct file *file, struct address_space *mapping,
-		  loff_t pos, unsigned len, unsigned copied,
-		  struct page *subpage, void *fsdata)
-{
-	struct folio *folio = page_folio(subpage);
-	struct afs_vnode *vnode = AFS_FS_I(file_inode(file));
-	loff_t i_size, write_end_pos;
-
-	_enter("{%llx:%llu},{%lx}",
-	       vnode->fid.vid, vnode->fid.vnode, folio_index(folio));
-
-	if (!folio_test_uptodate(folio)) {
-		if (copied < len) {
-			copied = 0;
-			goto out;
-		}
-
-		folio_mark_uptodate(folio);
-	}
-
-	if (copied == 0)
-		goto out;
-
-	write_end_pos = pos + copied;
-
-	i_size = i_size_read(&vnode->netfs.inode);
-	if (write_end_pos > i_size) {
-		write_seqlock(&vnode->cb_lock);
-		i_size = i_size_read(&vnode->netfs.inode);
-		if (write_end_pos > i_size)
-			afs_set_i_size(vnode, write_end_pos);
-		write_sequnlock(&vnode->cb_lock);
-		fscache_update_cookie(afs_vnode_cache(vnode), NULL, &write_end_pos);
-	}
-
-	if (folio_mark_dirty(folio))
-		_debug("dirtied %lx", folio_index(folio));
-
-out:
-	folio_unlock(folio);
-	folio_put(folio);
-	return copied;
-}
-
-/*
- * kill all the pages in the given range
- */
-static void afs_kill_pages(struct address_space *mapping,
-			   loff_t start, loff_t len)
-{
-	struct afs_vnode *vnode = AFS_FS_I(mapping->host);
-	struct folio *folio;
-	pgoff_t index = start / PAGE_SIZE;
-	pgoff_t last = (start + len - 1) / PAGE_SIZE, next;
-
-	_enter("{%llx:%llu},%llx @%llx",
-	       vnode->fid.vid, vnode->fid.vnode, len, start);
-
-	do {
-		_debug("kill %lx (to %lx)", index, last);
-
-		folio = filemap_get_folio(mapping, index);
-		if (IS_ERR(folio)) {
-			next = index + 1;
-			continue;
-		}
-
-		next = folio_next_index(folio);
-
-		folio_clear_uptodate(folio);
-		folio_end_writeback(folio);
-		folio_lock(folio);
-		generic_error_remove_folio(mapping, folio);
-		folio_unlock(folio);
-		folio_put(folio);
-
-	} while (index = next, index <= last);
-
-	_leave("");
-}
-
-/*
- * Redirty all the pages in a given range.
- */
-static void afs_redirty_pages(struct writeback_control *wbc,
-			      struct address_space *mapping,
-			      loff_t start, loff_t len)
-{
-	struct afs_vnode *vnode = AFS_FS_I(mapping->host);
-	struct folio *folio;
-	pgoff_t index = start / PAGE_SIZE;
-	pgoff_t last = (start + len - 1) / PAGE_SIZE, next;
-
-	_enter("{%llx:%llu},%llx @%llx",
-	       vnode->fid.vid, vnode->fid.vnode, len, start);
-
-	do {
-		_debug("redirty %llx @%llx", len, start);
-
-		folio = filemap_get_folio(mapping, index);
-		if (IS_ERR(folio)) {
-			next = index + 1;
-			continue;
-		}
-
-		next = index + folio_nr_pages(folio);
-		folio_redirty_for_writepage(wbc, folio);
-		folio_end_writeback(folio);
-		folio_put(folio);
-	} while (index = next, index <= last);
-
-	_leave("");
-}
-
 /*
  * completion of write to server
  */
 static void afs_pages_written_back(struct afs_vnode *vnode, loff_t start, unsigned int len)
 {
-	struct address_space *mapping = vnode->netfs.inode.i_mapping;
-	struct folio *folio;
-	pgoff_t end;
-
-	XA_STATE(xas, &mapping->i_pages, start / PAGE_SIZE);
-
 	_enter("{%llx:%llu},{%x @%llx}",
 	       vnode->fid.vid, vnode->fid.vnode, len, start);
 
-	rcu_read_lock();
-
-	end = (start + len - 1) / PAGE_SIZE;
-	xas_for_each(&xas, folio, end) {
-		if (!folio_test_writeback(folio)) {
-			kdebug("bad %x @%llx page %lx %lx",
-			       len, start, folio_index(folio), end);
-			ASSERT(folio_test_writeback(folio));
-		}
-
-		trace_afs_folio_dirty(vnode, tracepoint_string("clear"), folio);
-		folio_end_writeback(folio);
-	}
-
-	rcu_read_unlock();
-
 	afs_prune_wb_keys(vnode);
 	_leave("");
 }
@@ -370,337 +159,53 @@ static int afs_store_data(struct afs_vnode *vnode, struct iov_iter *iter, loff_t
 	return afs_put_operation(op);
 }
 
-/*
- * Extend the region to be written back to include subsequent contiguously
- * dirty pages if possible, but don't sleep while doing so.
- *
- * If this page holds new content, then we can include filler zeros in the
- * writeback.
- */
-static void afs_extend_writeback(struct address_space *mapping,
-				 struct afs_vnode *vnode,
-				 long *_count,
-				 loff_t start,
-				 loff_t max_len,
-				 bool caching,
-				 size_t *_len)
+static void afs_upload_to_server(struct netfs_io_subrequest *subreq)
 {
-	struct folio_batch fbatch;
-	struct folio *folio;
-	pgoff_t index = (start + *_len) / PAGE_SIZE;
-	bool stop = true;
-	unsigned int i;
-
-	XA_STATE(xas, &mapping->i_pages, index);
-	folio_batch_init(&fbatch);
-
-	do {
-		/* Firstly, we gather up a batch of contiguous dirty pages
-		 * under the RCU read lock - but we can't clear the dirty flags
-		 * there if any of those pages are mapped.
-		 */
-		rcu_read_lock();
-
-		xas_for_each(&xas, folio, ULONG_MAX) {
-			stop = true;
-			if (xas_retry(&xas, folio))
-				continue;
-			if (xa_is_value(folio))
-				break;
-			if (folio_index(folio) != index)
-				break;
-
-			if (!folio_try_get_rcu(folio)) {
-				xas_reset(&xas);
-				continue;
-			}
-
-			/* Has the folio moved or been split? */
-			if (unlikely(folio != xas_reload(&xas))) {
-				folio_put(folio);
-				break;
-			}
-
-			if (!folio_trylock(folio)) {
-				folio_put(folio);
-				break;
-			}
-			if (!folio_test_dirty(folio) ||
-			    folio_test_writeback(folio) ||
-			    folio_test_fscache(folio)) {
-				folio_unlock(folio);
-				folio_put(folio);
-				break;
-			}
-
-			index += folio_nr_pages(folio);
-			*_count -= folio_nr_pages(folio);
-			*_len += folio_size(folio);
-			stop = false;
-			if (*_len >= max_len || *_count <= 0)
-				stop = true;
-
-			if (!folio_batch_add(&fbatch, folio))
-				break;
-			if (stop)
-				break;
-		}
-
-		if (!stop)
-			xas_pause(&xas);
-		rcu_read_unlock();
-
-		/* Now, if we obtained any folios, we can shift them to being
-		 * writable and mark them for caching.
-		 */
-		if (!folio_batch_count(&fbatch))
-			break;
-
-		for (i = 0; i < folio_batch_count(&fbatch); i++) {
-			folio = fbatch.folios[i];
-			trace_afs_folio_dirty(vnode, tracepoint_string("store+"), folio);
+	struct afs_vnode *vnode = AFS_FS_I(subreq->rreq->inode);
+	ssize_t ret;
 
-			if (!folio_clear_dirty_for_io(folio))
-				BUG();
-			folio_start_writeback(folio);
-			afs_folio_start_fscache(caching, folio);
-			folio_unlock(folio);
-		}
+	_enter("%x[%x],%zx",
+	       subreq->rreq->debug_id, subreq->debug_index, subreq->io_iter.count);
 
-		folio_batch_release(&fbatch);
-		cond_resched();
-	} while (!stop);
+	trace_netfs_sreq(subreq, netfs_sreq_trace_submit);
+	ret = afs_store_data(vnode, &subreq->io_iter, subreq->start,
+			     subreq->rreq->origin == NETFS_LAUNDER_WRITE);
+	netfs_write_subrequest_terminated(subreq, ret < 0 ? ret : subreq->len,
+					  false);
 }
 
-/*
- * Synchronously write back the locked page and any subsequent non-locked dirty
- * pages.
- */
-static ssize_t afs_write_back_from_locked_folio(struct address_space *mapping,
-						struct writeback_control *wbc,
-						struct folio *folio,
-						unsigned long long start,
-						unsigned long long end)
+static void afs_upload_to_server_worker(struct work_struct *work)
 {
-	struct afs_vnode *vnode = AFS_FS_I(mapping->host);
-	struct iov_iter iter;
-	unsigned long long i_size = i_size_read(&vnode->netfs.inode);
-	size_t len, max_len;
-	bool caching = fscache_cookie_enabled(afs_vnode_cache(vnode));
-	long count = wbc->nr_to_write;
-	int ret;
-
-	_enter(",%lx,%llx-%llx", folio_index(folio), start, end);
-
-	folio_start_writeback(folio);
-	afs_folio_start_fscache(caching, folio);
-
-	count -= folio_nr_pages(folio);
-
-	/* Find all consecutive lockable dirty pages that have contiguous
-	 * written regions, stopping when we find a page that is not
-	 * immediately lockable, is not dirty or is missing, or we reach the
-	 * end of the range.
-	 */
-	trace_afs_folio_dirty(vnode, tracepoint_string("store"), folio);
-
-	len = folio_size(folio);
-	if (start < i_size) {
-		/* Trim the write to the EOF; the extra data is ignored.  Also
-		 * put an upper limit on the size of a single storedata op.
-		 */
-		max_len = 65536 * 4096;
-		max_len = min_t(unsigned long long, max_len, end - start + 1);
-		max_len = min_t(unsigned long long, max_len, i_size - start);
-
-		if (len < max_len)
-			afs_extend_writeback(mapping, vnode, &count,
-					     start, max_len, caching, &len);
-		len = min_t(unsigned long long, len, i_size - start);
-	}
-
-	/* We now have a contiguous set of dirty pages, each with writeback
-	 * set; the first page is still locked at this point, but all the rest
-	 * have been unlocked.
-	 */
-	folio_unlock(folio);
-
-	if (start < i_size) {
-		_debug("write back %zx @%llx [%llx]", len, start, i_size);
-
-		/* Speculatively write to the cache.  We have to fix this up
-		 * later if the store fails.
-		 */
-		afs_write_to_cache(vnode, start, len, i_size, caching);
-
-		iov_iter_xarray(&iter, ITER_SOURCE, &mapping->i_pages, start, len);
-		ret = afs_store_data(vnode, &iter, start, false);
-	} else {
-		_debug("write discard %zx @%llx [%llx]", len, start, i_size);
-
-		/* The dirty region was entirely beyond the EOF. */
-		fscache_clear_page_bits(mapping, start, len, caching);
-		afs_pages_written_back(vnode, start, len);
-		ret = 0;
-	}
-
-	switch (ret) {
-	case 0:
-		wbc->nr_to_write = count;
-		ret = len;
-		break;
-
-	default:
-		pr_notice("kAFS: Unexpected error from FS.StoreData %d\n", ret);
-		fallthrough;
-	case -EACCES:
-	case -EPERM:
-	case -ENOKEY:
-	case -EKEYEXPIRED:
-	case -EKEYREJECTED:
-	case -EKEYREVOKED:
-	case -ENETRESET:
-		afs_redirty_pages(wbc, mapping, start, len);
-		mapping_set_error(mapping, ret);
-		break;
-
-	case -EDQUOT:
-	case -ENOSPC:
-		afs_redirty_pages(wbc, mapping, start, len);
-		mapping_set_error(mapping, -ENOSPC);
-		break;
-
-	case -EROFS:
-	case -EIO:
-	case -EREMOTEIO:
-	case -EFBIG:
-	case -ENOENT:
-	case -ENOMEDIUM:
-	case -ENXIO:
-		trace_afs_file_error(vnode, ret, afs_file_error_writeback_fail);
-		afs_kill_pages(mapping, start, len);
-		mapping_set_error(mapping, ret);
-		break;
-	}
+	struct netfs_io_subrequest *subreq =
+		container_of(work, struct netfs_io_subrequest, work);
 
-	_leave(" = %d", ret);
-	return ret;
+	afs_upload_to_server(subreq);
 }
 
 /*
- * write a region of pages back to the server
+ * Set up write requests for a writeback slice.  We need to add a write request
+ * for each write we want to make.
  */
-static int afs_writepages_region(struct address_space *mapping,
-				 struct writeback_control *wbc,
-				 unsigned long long start,
-				 unsigned long long end, loff_t *_next,
-				 bool max_one_loop)
+void afs_create_write_requests(struct netfs_io_request *wreq, loff_t start, size_t len)
 {
-	struct folio *folio;
-	struct folio_batch fbatch;
-	ssize_t ret;
-	unsigned int i;
-	int n, skips = 0;
-
-	_enter("%llx,%llx,", start, end);
-	folio_batch_init(&fbatch);
+	struct netfs_io_subrequest *subreq;
 
-	do {
-		pgoff_t index = start / PAGE_SIZE;
+	_enter("%x,%llx-%llx", wreq->debug_id, start, start + len);
 
-		n = filemap_get_folios_tag(mapping, &index, end / PAGE_SIZE,
-					PAGECACHE_TAG_DIRTY, &fbatch);
-
-		if (!n)
-			break;
-		for (i = 0; i < n; i++) {
-			folio = fbatch.folios[i];
-			start = folio_pos(folio); /* May regress with THPs */
-
-			_debug("wback %lx", folio_index(folio));
-
-			/* At this point we hold neither the i_pages lock nor the
-			 * page lock: the page may be truncated or invalidated
-			 * (changing page->mapping to NULL), or even swizzled
-			 * back from swapper_space to tmpfs file mapping
-			 */
-try_again:
-			if (wbc->sync_mode != WB_SYNC_NONE) {
-				ret = folio_lock_killable(folio);
-				if (ret < 0) {
-					folio_batch_release(&fbatch);
-					return ret;
-				}
-			} else {
-				if (!folio_trylock(folio))
-					continue;
-			}
-
-			if (folio->mapping != mapping ||
-			    !folio_test_dirty(folio)) {
-				start += folio_size(folio);
-				folio_unlock(folio);
-				continue;
-			}
-
-			if (folio_test_writeback(folio) ||
-			    folio_test_fscache(folio)) {
-				folio_unlock(folio);
-				if (wbc->sync_mode != WB_SYNC_NONE) {
-					folio_wait_writeback(folio);
-#ifdef CONFIG_AFS_FSCACHE
-					folio_wait_fscache(folio);
-#endif
-					goto try_again;
-				}
-
-				start += folio_size(folio);
-				if (wbc->sync_mode == WB_SYNC_NONE) {
-					if (skips >= 5 || need_resched()) {
-						*_next = start;
-						folio_batch_release(&fbatch);
-						_leave(" = 0 [%llx]", *_next);
-						return 0;
-					}
-					skips++;
-				}
-				continue;
-			}
-
-			if (!folio_clear_dirty_for_io(folio))
-				BUG();
-			ret = afs_write_back_from_locked_folio(mapping, wbc,
-					folio, start, end);
-			if (ret < 0) {
-				_leave(" = %zd", ret);
-				folio_batch_release(&fbatch);
-				return ret;
-			}
-
-			start += ret;
-		}
-
-		folio_batch_release(&fbatch);
-		cond_resched();
-	} while (wbc->nr_to_write > 0);
-
-	*_next = start;
-	_leave(" = 0 [%llx]", *_next);
-	return 0;
+	subreq = netfs_create_write_request(wreq, NETFS_UPLOAD_TO_SERVER,
+					    start, len, afs_upload_to_server_worker);
+	if (subreq)
+		netfs_queue_write_request(subreq);
 }
 
 /*
  * write some of the pending data back to the server
  */
-int afs_writepages(struct address_space *mapping,
-		   struct writeback_control *wbc)
+int afs_writepages(struct address_space *mapping, struct writeback_control *wbc)
 {
 	struct afs_vnode *vnode = AFS_FS_I(mapping->host);
-	loff_t start, next;
 	int ret;
 
-	_enter("");
-
 	/* We have to be careful as we can end up racing with setattr()
 	 * truncating the pagecache since the caller doesn't take a lock here
 	 * to prevent it.
@@ -710,68 +215,11 @@ int afs_writepages(struct address_space *mapping,
 	else if (!down_read_trylock(&vnode->validate_lock))
 		return 0;
 
-	if (wbc->range_cyclic) {
-		start = mapping->writeback_index * PAGE_SIZE;
-		ret = afs_writepages_region(mapping, wbc, start, LLONG_MAX,
-					    &next, false);
-		if (ret == 0) {
-			mapping->writeback_index = next / PAGE_SIZE;
-			if (start > 0 && wbc->nr_to_write > 0) {
-				ret = afs_writepages_region(mapping, wbc, 0,
-							    start, &next, false);
-				if (ret == 0)
-					mapping->writeback_index =
-						next / PAGE_SIZE;
-			}
-		}
-	} else if (wbc->range_start == 0 && wbc->range_end == LLONG_MAX) {
-		ret = afs_writepages_region(mapping, wbc, 0, LLONG_MAX,
-					    &next, false);
-		if (wbc->nr_to_write > 0 && ret == 0)
-			mapping->writeback_index = next / PAGE_SIZE;
-	} else {
-		ret = afs_writepages_region(mapping, wbc,
-					    wbc->range_start, wbc->range_end,
-					    &next, false);
-	}
-
+	ret = netfs_writepages(mapping, wbc);
 	up_read(&vnode->validate_lock);
-	_leave(" = %d", ret);
 	return ret;
 }
 
-/*
- * write to an AFS file
- */
-ssize_t afs_file_write(struct kiocb *iocb, struct iov_iter *from)
-{
-	struct afs_vnode *vnode = AFS_FS_I(file_inode(iocb->ki_filp));
-	struct afs_file *af = iocb->ki_filp->private_data;
-	ssize_t result;
-	size_t count = iov_iter_count(from);
-
-	_enter("{%llx:%llu},{%zu},",
-	       vnode->fid.vid, vnode->fid.vnode, count);
-
-	if (IS_SWAPFILE(&vnode->netfs.inode)) {
-		printk(KERN_INFO
-		       "AFS: Attempt to write to active swap file!\n");
-		return -EBUSY;
-	}
-
-	if (!count)
-		return 0;
-
-	result = afs_validate(vnode, af->key);
-	if (result < 0)
-		return result;
-
-	result = generic_file_write_iter(iocb, from);
-
-	_leave(" = %zd", result);
-	return result;
-}
-
 /*
  * flush any dirty pages for this process, and check for write errors.
  * - the return status from this call provides a reliable indication of
@@ -800,49 +248,11 @@ int afs_fsync(struct file *file, loff_t start, loff_t end, int datasync)
  */
 vm_fault_t afs_page_mkwrite(struct vm_fault *vmf)
 {
-	struct folio *folio = page_folio(vmf->page);
 	struct file *file = vmf->vma->vm_file;
-	struct inode *inode = file_inode(file);
-	struct afs_vnode *vnode = AFS_FS_I(inode);
-	struct afs_file *af = file->private_data;
-	vm_fault_t ret = VM_FAULT_RETRY;
-
-	_enter("{{%llx:%llu}},{%lx}", vnode->fid.vid, vnode->fid.vnode, folio_index(folio));
-
-	afs_validate(vnode, af->key);
-
-	sb_start_pagefault(inode->i_sb);
-
-	/* Wait for the page to be written to the cache before we allow it to
-	 * be modified.  We then assume the entire page will need writing back.
-	 */
-#ifdef CONFIG_AFS_FSCACHE
-	if (folio_test_fscache(folio) &&
-	    folio_wait_fscache_killable(folio) < 0)
-		goto out;
-#endif
-
-	if (folio_wait_writeback_killable(folio))
-		goto out;
-
-	if (folio_lock_killable(folio) < 0)
-		goto out;
-
-	if (folio_wait_writeback_killable(folio) < 0) {
-		folio_unlock(folio);
-		goto out;
-	}
-
-	if (folio_test_dirty(folio))
-		trace_afs_folio_dirty(vnode, tracepoint_string("mkwrite+"), folio);
-	else
-		trace_afs_folio_dirty(vnode, tracepoint_string("mkwrite"), folio);
-	file_update_time(file);
 
-	ret = VM_FAULT_LOCKED;
-out:
-	sb_end_pagefault(inode->i_sb);
-	return ret;
+	if (afs_validate(AFS_FS_I(file_inode(file)), afs_file_key(file)) < 0)
+		return VM_FAULT_SIGBUS;
+	return netfs_page_mkwrite(vmf, NULL);
 }
 
 /*
@@ -872,60 +282,3 @@ void afs_prune_wb_keys(struct afs_vnode *vnode)
 		afs_put_wb_key(wbk);
 	}
 }
-
-/*
- * Clean up a page during invalidation.
- */
-int afs_launder_folio(struct folio *folio)
-{
-	struct afs_vnode *vnode = AFS_FS_I(folio_inode(folio));
-	struct iov_iter iter;
-	struct bio_vec bv;
-	unsigned long long fend, i_size = vnode->netfs.inode.i_size;
-	size_t len;
-	int ret = 0;
-
-	_enter("{%lx}", folio->index);
-
-	if (folio_clear_dirty_for_io(folio) && folio_pos(folio) < i_size) {
-		len = folio_size(folio);
-		fend = folio_pos(folio) + len;
-		if (vnode->netfs.inode.i_size < fend)
-			len = fend - i_size;
-
-		bvec_set_folio(&bv, folio, len, 0);
-		iov_iter_bvec(&iter, WRITE, &bv, 1, len);
-
-		trace_afs_folio_dirty(vnode, tracepoint_string("launder"), folio);
-		ret = afs_store_data(vnode, &iter, folio_pos(folio), true);
-	}
-
-	trace_afs_folio_dirty(vnode, tracepoint_string("laundered"), folio);
-	folio_wait_fscache(folio);
-	return ret;
-}
-
-/*
- * Deal with the completion of writing the data to the cache.
- */
-static void afs_write_to_cache_done(void *priv, ssize_t transferred_or_error,
-				    bool was_async)
-{
-	struct afs_vnode *vnode = priv;
-
-	if (IS_ERR_VALUE(transferred_or_error) &&
-	    transferred_or_error != -ENOBUFS)
-		afs_invalidate_cache(vnode, 0);
-}
-
-/*
- * Save the write to the cache also.
- */
-static void afs_write_to_cache(struct afs_vnode *vnode,
-			       loff_t start, size_t len, loff_t i_size,
-			       bool caching)
-{
-	fscache_write_to_cache(afs_vnode_cache(vnode),
-			       vnode->netfs.inode.i_mapping, start, len, i_size,
-			       afs_write_to_cache_done, vnode, caching);
-}
diff --git a/include/trace/events/afs.h b/include/trace/events/afs.h
index 7780bd716ce0..8d73171cb9f0 100644
--- a/include/trace/events/afs.h
+++ b/include/trace/events/afs.h
@@ -902,29 +902,6 @@ TRACE_EVENT(afs_dir_check_failed,
 		      __entry->vnode, __entry->off, __entry->i_size)
 	    );
 
-TRACE_EVENT(afs_folio_dirty,
-	    TP_PROTO(struct afs_vnode *vnode, const char *where, struct folio *folio),
-
-	    TP_ARGS(vnode, where, folio),
-
-	    TP_STRUCT__entry(
-		    __field(struct afs_vnode *,		vnode)
-		    __field(const char *,		where)
-		    __field(pgoff_t,			index)
-		    __field(size_t,			size)
-			     ),
-
-	    TP_fast_assign(
-		    __entry->vnode = vnode;
-		    __entry->where = where;
-		    __entry->index = folio_index(folio);
-		    __entry->size = folio_size(folio);
-			   ),
-
-	    TP_printk("vn=%p ix=%05lx s=%05lx %s",
-		      __entry->vnode, __entry->index, __entry->size, __entry->where)
-	    );
-
 TRACE_EVENT(afs_call_state,
 	    TP_PROTO(struct afs_call *call,
 		     enum afs_call_state from,


