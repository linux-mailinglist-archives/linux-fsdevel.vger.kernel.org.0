Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0BBB21DD84
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jul 2020 18:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730758AbgGMQjM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jul 2020 12:39:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22529 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730518AbgGMQjL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jul 2020 12:39:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594658349;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KKadESJQ09lMc3nk+ibKGUSX3dfDS51s+7mWdjFN8QU=;
        b=cTgyWnXPU+8KfHczTa0EYIrucrQCqr7RKD+Z81uxM2gg8ouX6xo2+eP8PlcpwzLFpa/nG7
        ZP7BlNuHMzBG66B47anWaMapLZM1bBTktTIlUYJiPdhpqBL38ZEa/FQtGn23pAxHZK1rcs
        zSU2/VLNBSMkEZhsPsAhFqc9ObBXuac=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-F_Xx8fLIOfuaVJ70wM9uoQ-1; Mon, 13 Jul 2020 12:39:04 -0400
X-MC-Unique: F_Xx8fLIOfuaVJ70wM9uoQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2AFA38018A1;
        Mon, 13 Jul 2020 16:39:02 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-113.rdu2.redhat.com [10.10.112.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 286ED1010404;
        Mon, 13 Jul 2020 16:38:56 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 10/13] afs: Use new fscache I/O API
From:   David Howells <dhowells@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Jeff Layton <jlayton@redhat.com>,
        Dave Wysochanski <dwysocha@redhat.com>, dhowells@redhat.com,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 13 Jul 2020 17:38:55 +0100
Message-ID: <159465833532.1377938.17200329236364493561.stgit@warthog.procyon.org.uk>
In-Reply-To: <159465821598.1377938.2046362270225008168.stgit@warthog.procyon.org.uk>
References: <159465821598.1377938.2046362270225008168.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.22
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Make AFS use the new fscache I/O API to read and write from the cache.

afs_readpage() now calls fscache_read_helper() once to try and create a
block around the page to be read.

afs_readpages() now calls fscache_read_helper() multiple times until its
list is exhausted or an error occurs.

afs_prefetch_for_write() is provided to be called from afs_write_begin() to
load the data that will be overwritten by the write into the cache,
extending the read as necessary.  This guarantees that the page it returns
will be up to date, rendering it unnecessary for afs_write_end() to fill in
the gaps.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/Kconfig    |    1 
 fs/afs/dir.c      |    1 
 fs/afs/file.c     |  368 +++++++++++++++++++++++++----------------------------
 fs/afs/internal.h |    9 +
 fs/afs/write.c    |  105 +--------------
 5 files changed, 192 insertions(+), 292 deletions(-)

diff --git a/fs/afs/Kconfig b/fs/afs/Kconfig
index 1ad211d72b3b..4cbf93a55bf9 100644
--- a/fs/afs/Kconfig
+++ b/fs/afs/Kconfig
@@ -4,6 +4,7 @@ config AFS_FS
 	depends on INET
 	select AF_RXRPC
 	select DNS_RESOLVER
+	select FSCACHE_SUPPORT
 	help
 	  If you say Y here, you will get an experimental Andrew File System
 	  driver. It currently only supports unsecured read-only AFS access.
diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 03ef09330d10..eb51c92ec807 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -303,6 +303,7 @@ static struct afs_read *afs_read_dir(struct afs_vnode *dvnode, struct key *key)
 	req->vnode = dvnode;
 	req->cleanup = afs_dir_read_cleanup;
 	req->cache.io_done = afs_dir_read_done;
+	fscache_init_io_request(&req->cache, NULL, NULL);
 
 expand:
 	i_size = i_size_read(&dvnode->vfs_inode);
diff --git a/fs/afs/file.c b/fs/afs/file.c
index 2f9a7369b77b..5aa7b89e7359 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -196,76 +196,80 @@ int afs_release(struct inode *inode, struct file *file)
 	return ret;
 }
 
-/*
- * Handle completion of a read operation.
- */
-static void afs_file_read_done(struct fscache_io_request *fsreq)
-{
-	struct afs_read *req = container_of(fsreq, struct afs_read, cache);
-	struct afs_vnode *vnode = req->vnode;
-	struct page *page;
-	pgoff_t index = req->cache.pos >> PAGE_SHIFT;
-	pgoff_t last = index + req->cache.nr_pages - 1;
-
-	XA_STATE(xas, &vnode->vfs_inode.i_mapping->i_pages, index);
-
-	if (iov_iter_count(req->iter) > 0) {
-		/* The read was short - clear the excess buffer. */
-		_debug("afterclear %zx %zx %llx/%llx",
-		       req->iter->iov_offset,
-		       iov_iter_count(req->iter),
-		       req->actual_len, req->cache.len);
-		iov_iter_zero(iov_iter_count(req->iter), req->iter);
-	}
-
-	rcu_read_lock();
-	xas_for_each(&xas, page, last) {
-		page_endio(page, false, 0);
-		put_page(page);
-	}
-	rcu_read_unlock();
-
-	task_io_account_read(req->cache.len);
-	req->cleanup = NULL;
-}
-
 /*
  * Dispose of our locks and refs on the pages if the read failed.
  */
 static void afs_file_read_cleanup(struct afs_read *req)
 {
+	struct afs_vnode *vnode = req->vnode;
 	struct page *page;
 	pgoff_t index = req->cache.pos >> PAGE_SHIFT;
 	pgoff_t last = index + req->cache.nr_pages - 1;
 
-	if (req->iter) {
-		XA_STATE(xas, &req->iter->mapping->i_pages, index);
+	_enter("%lx,%x,%llx", index, req->cache.nr_pages, req->cache.len);
 
-		_enter("%lu,%u,%zu",
-		       index, req->cache.nr_pages, iov_iter_count(req->iter));
+	if (req->cache.nr_pages > 0) {
+		XA_STATE(xas, &vnode->vfs_inode.i_mapping->i_pages, index);
 
 		rcu_read_lock();
 		xas_for_each(&xas, page, last) {
 			BUG_ON(xa_is_value(page));
 			BUG_ON(PageCompound(page));
 
-			page_endio(page, false, req->cache.error);
+			if (req->cache.error)
+				page_endio(page, false, req->cache.error);
+			else
+				unlock_page(page);
 			put_page(page);
 		}
 		rcu_read_unlock();
 	}
 }
 
+/*
+ * Allocate a new read record.
+ */
+struct afs_read *afs_alloc_read(gfp_t gfp)
+{
+	static atomic_t debug_ids;
+	struct afs_read *req;
+
+	req = kzalloc(sizeof(struct afs_read), gfp);
+	if (req) {
+		refcount_set(&req->usage, 1);
+		req->debug_id = atomic_inc_return(&debug_ids);
+	}
+
+	return req;
+}
+
+/*
+ *
+ */
+static void __afs_put_read(struct work_struct *work)
+{
+	struct afs_read *req = container_of(work, struct afs_read, cache.work);
+
+	if (req->cleanup)
+		req->cleanup(req);
+	fscache_free_io_request(&req->cache);
+	key_put(req->key);
+	kfree(req);
+}
+
 /*
  * Dispose of a ref to a read record.
  */
 void afs_put_read(struct afs_read *req)
 {
 	if (refcount_dec_and_test(&req->usage)) {
-		if (req->cleanup)
-			req->cleanup(req);
-		key_put(req->key);
-		kfree(req);
+		_debug("dead %u", req->debug_id);
+		if (in_softirq()) {
+			INIT_WORK(&req->cache.work, __afs_put_read);
+			queue_work(afs_wq, &req->cache.work);
+		} else {
+			__afs_put_read(&req->cache.work);
+		}
 	}
 }
 
@@ -318,189 +322,89 @@ int afs_fetch_data(struct afs_vnode *vnode, struct afs_read *req)
 	return afs_do_sync_operation(op);
 }
 
-/*
- * read page from file, directory or symlink, given a key to use
- */
-static int afs_page_filler(struct key *key, struct page *page)
+void afs_req_issue_op(struct fscache_io_request *fsreq)
 {
-	struct inode *inode = page->mapping->host;
-	struct afs_vnode *vnode = AFS_FS_I(inode);
-	struct afs_read *req;
+	struct afs_read *req = container_of(fsreq, struct afs_read, cache);
 	int ret;
 
-	_enter("{%x},{%lu},{%lu}", key_serial(key), inode->i_ino, page->index);
-
-	BUG_ON(!PageLocked(page));
-
-	ret = -ESTALE;
-	if (test_bit(AFS_VNODE_DELETED, &vnode->flags))
-		goto error;
-
-	req = kzalloc(sizeof(struct afs_read), GFP_KERNEL);
-	if (!req)
-		goto enomem;
-
-	refcount_set(&req->usage, 1);
-	req->vnode		= vnode;
-	req->key		= key_get(key);
-	req->cache.nr_pages	= 1;
-	req->cache.pos		= (loff_t)page->index << PAGE_SHIFT;
-	req->cache.len		= PAGE_SIZE;
-	req->cache.io_done	= afs_file_read_done;
-	req->cleanup		= afs_file_read_cleanup;
-
-	get_page(page);
-	iov_iter_mapping(&req->def_iter, READ, page->mapping,
+	iov_iter_mapping(&req->def_iter, READ, req->cache.mapping,
 			 req->cache.pos, req->cache.len);
 	req->iter = &req->def_iter;
 
-	ret = afs_fetch_data(vnode, req);
+	ret = afs_fetch_data(req->vnode, req);
 	if (ret < 0)
-		goto fetch_error;
+		req->cache.error = ret;
+}
 
-	afs_put_read(req);
-	_leave(" = 0");
-	return 0;
+void afs_req_done(struct fscache_io_request *fsreq)
+{
+	struct afs_read *req = container_of(fsreq, struct afs_read, cache);
 
-fetch_error:
-	switch (ret) {
-	case -EINTR:
-	case -ENOMEM:
-	case -ERESTARTSYS:
-	case -EAGAIN:
-		afs_put_read(req);
-		goto error;
-	case -ENOENT:
-		_debug("got NOENT from server - marking file deleted and stale");
-		set_bit(AFS_VNODE_DELETED, &vnode->flags);
-		ret = -ESTALE;
-		/* Fall through */
-	default:
-		page_endio(page, false, ret);
-		afs_put_read(req);
-		_leave(" = %d", ret);
-		return ret;
-	}
+	req->cleanup = NULL;
+}
 
-enomem:
-	ret = -ENOMEM;
-error:
-	unlock_page(page);
-	_leave(" = %d", ret);
-	return ret;
+void afs_req_get(struct fscache_io_request *fsreq)
+{
+	struct afs_read *req = container_of(fsreq, struct afs_read, cache);
+
+	afs_get_read(req);
+}
+
+void afs_req_put(struct fscache_io_request *fsreq)
+{
+	struct afs_read *req = container_of(fsreq, struct afs_read, cache);
+
+	afs_put_read(req);
 }
 
+const struct fscache_io_request_ops afs_req_ops = {
+	.issue_op	= afs_req_issue_op,
+	.done		= afs_req_done,
+	.get		= afs_req_get,
+	.put		= afs_req_put,
+};
+
 /*
  * read page from file, directory or symlink, given a file to nominate the key
  * to be used
  */
 static int afs_readpage(struct file *file, struct page *page)
 {
+	struct afs_vnode *vnode = AFS_FS_I(page->mapping->host);
+	struct afs_read *req;
 	struct key *key;
-	int ret;
+	int ret = -ENOMEM;
+
+	_enter(",%lx", page->index);
 
 	if (file) {
-		key = afs_file_key(file);
+		key = key_get(afs_file_key(file));
 		ASSERT(key != NULL);
-		ret = afs_page_filler(key, page);
 	} else {
-		struct inode *inode = page->mapping->host;
-		key = afs_request_key(AFS_FS_S(inode->i_sb)->cell);
+		key = afs_request_key(vnode->volume->cell);
 		if (IS_ERR(key)) {
 			ret = PTR_ERR(key);
-		} else {
-			ret = afs_page_filler(key, page);
-			key_put(key);
+			goto out;
 		}
 	}
-	return ret;
-}
-
-/*
- * Read a contiguous set of pages.
- */
-static int afs_readpages_one(struct file *file, struct address_space *mapping,
-			     struct list_head *pages)
-{
-	struct afs_vnode *vnode = AFS_FS_I(mapping->host);
-	struct afs_read *req;
-	struct list_head *p;
-	struct page *first, *page;
-	pgoff_t index;
-	int ret, n;
-
-	/* Count the number of contiguous pages at the front of the list.  Note
-	 * that the list goes prev-wards rather than next-wards.
-	 */
-	first = lru_to_page(pages);
-	index = first->index + 1;
-	n = 1;
-	for (p = first->lru.prev; p != pages; p = p->prev) {
-		page = list_entry(p, struct page, lru);
-		if (page->index != index)
-			break;
-		index++;
-		n++;
-	}
 
-	req = kzalloc(sizeof(struct afs_read), GFP_NOFS);
+	req = afs_alloc_read(GFP_NOFS);
 	if (!req)
-		return -ENOMEM;
+		goto out_key;
 
-	refcount_set(&req->usage, 1);
+	fscache_init_io_request(&req->cache, afs_vnode_cache(vnode), &afs_req_ops);
 	req->vnode = vnode;
-	req->key = key_get(afs_file_key(file));
+	req->key = key;
 	req->cleanup = afs_file_read_cleanup;
-	req->cache.io_done = afs_file_read_done;
-	req->cache.pos = first->index;
-	req->cache.pos <<= PAGE_SHIFT;
-
-	/* Add pages to the LRU until it fails.  We keep the pages ref'd and
-	 * locked until the read is complete.
-	 *
-	 * Note that it's possible for the file size to change whilst we're
-	 * doing this, but we rely on the server returning less than we asked
-	 * for if the file shrank.  We also rely on this to deal with a partial
-	 * page at the end of the file.
-	 */
-	do {
-		page = lru_to_page(pages);
-		list_del(&page->lru);
-		index = page->index;
-		if (add_to_page_cache_lru(page, mapping, index,
-					  readahead_gfp_mask(mapping))) {
-			put_page(page);
-			break;
-		}
-
-		req->cache.nr_pages++;
-	} while (req->cache.nr_pages < n);
-
-	if (req->cache.nr_pages == 0) {
-		afs_put_read(req);
-		return 0;
-	}
-
-	req->cache.len = req->cache.nr_pages * PAGE_SIZE;
-	iov_iter_mapping(&req->def_iter, READ, file->f_mapping,
-			 req->cache.pos, req->cache.len);
-	req->iter = &req->def_iter;
-
-	ret = afs_fetch_data(vnode, req);
-	if (ret < 0)
-		goto error;
+	req->cache.mapping = page->mapping;
 
+	ret = fscache_read_helper_locked_page(&req->cache, page, ULONG_MAX);
 	afs_put_read(req);
-	return 0;
-
-error:
-	if (ret == -ENOENT) {
-		_debug("got NOENT from server - marking file deleted and stale");
-		set_bit(AFS_VNODE_DELETED, &vnode->flags);
-		ret = -ESTALE;
-	}
+	return ret;
 
-	afs_put_read(req);
+out_key:
+	key_put(key);
+out:
 	return ret;
 }
 
@@ -510,14 +414,11 @@ static int afs_readpages_one(struct file *file, struct address_space *mapping,
 static int afs_readpages(struct file *file, struct address_space *mapping,
 			 struct list_head *pages, unsigned nr_pages)
 {
-	struct key *key = afs_file_key(file);
 	struct afs_vnode *vnode;
+	struct afs_read *req;
 	int ret = 0;
 
-	_enter("{%d},{%lu},,%d",
-	       key_serial(key), mapping->host->i_ino, nr_pages);
-
-	ASSERT(key != NULL);
+	_enter(",{%lu},,%x", mapping->host->i_ino, nr_pages);
 
 	vnode = AFS_FS_I(mapping->host);
 	if (test_bit(AFS_VNODE_DELETED, &vnode->flags)) {
@@ -525,9 +426,21 @@ static int afs_readpages(struct file *file, struct address_space *mapping,
 		return -ESTALE;
 	}
 
-	/* attempt to read as many of the pages as possible */
 	while (!list_empty(pages)) {
-		ret = afs_readpages_one(file, mapping, pages);
+		req = afs_alloc_read(GFP_NOFS);
+		if (!req)
+			return -ENOMEM;
+
+		fscache_init_io_request(&req->cache, afs_vnode_cache(vnode),
+					&afs_req_ops);
+		req->vnode	= AFS_FS_I(mapping->host);
+		req->key	= key_get(afs_file_key(file));
+		req->cleanup	= afs_file_read_cleanup;
+		req->cache.mapping = mapping;
+
+		ret = fscache_read_helper_page_list(&req->cache, pages,
+						    ULONG_MAX);
+		afs_put_read(req);
 		if (ret < 0)
 			break;
 	}
@@ -536,6 +449,67 @@ static int afs_readpages(struct file *file, struct address_space *mapping,
 	return ret;
 }
 
+/*
+ * Prefetch data into the cache prior to writing, returning the requested page
+ * to the caller, with the lock held, upon completion of the write.
+ */
+struct page *afs_prefetch_for_write(struct file *file,
+				    struct address_space *mapping,
+				    pgoff_t index,
+				    unsigned int aop_flags)
+{
+	struct afs_vnode *vnode = AFS_FS_I(mapping->host);
+	struct afs_read *req;
+	struct page *page;
+	int ret = 0;
+
+	_enter("{%lu},%lx", mapping->host->i_ino, index);
+
+	if (test_bit(AFS_VNODE_DELETED, &vnode->flags)) {
+		_leave(" = -ESTALE");
+		return ERR_PTR(-ESTALE);
+	}
+
+	page = pagecache_get_page(mapping, index, FGP_WRITE, 0);
+	if (page) {
+		if (PageUptodate(page)) {
+			lock_page(page);
+			if (PageUptodate(page))
+				goto have_page;
+			unlock_page(page);
+		}
+	}
+
+	req = afs_alloc_read(GFP_NOFS);
+	if (!req)
+		return ERR_PTR(-ENOMEM);
+
+	fscache_init_io_request(&req->cache, afs_vnode_cache(vnode), &afs_req_ops);
+	req->vnode	= AFS_FS_I(mapping->host);
+	req->key	= key_get(afs_file_key(file));
+	req->cleanup	= afs_file_read_cleanup;
+	req->cache.mapping = mapping;
+
+	ret = fscache_read_helper_for_write(&req->cache, &page, index,
+					    ULONG_MAX, aop_flags);
+	if (ret == 0)
+		/* Synchronicity required */
+		ret = wait_on_bit(&req->cache.flags, FSCACHE_IO_READ_IN_PROGRESS,
+				  TASK_KILLABLE);
+
+	afs_put_read(req);
+
+	if (ret < 0) {
+		if (page)
+			put_page(page);
+		return ERR_PTR(ret);
+	}
+
+have_page:
+	wait_for_stable_page(page);
+	return page;
+}
+
 /*
  * invalidate part or all of a page
  * - release a page and clean up its private data if offset is 0 (indicating
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index d55ea1904a27..8c9abfa33a91 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -210,6 +210,7 @@ struct afs_read {
 	struct afs_vnode	*vnode;		/* The file being read into. */
 	afs_dataversion_t	data_version;	/* Version number returned by server */
 	refcount_t		usage;
+	unsigned int		debug_id;
 	unsigned int		call_debug_id;
 	void (*cleanup)(struct afs_read *req);
 };
@@ -961,6 +962,7 @@ extern void afs_dynroot_depopulate(struct super_block *);
 /*
  * file.c
  */
+extern const struct fscache_io_request_ops afs_req_ops;
 extern const struct address_space_operations afs_fs_aops;
 extern const struct inode_operations afs_file_inode_operations;
 extern const struct file_operations afs_file_operations;
@@ -970,7 +972,14 @@ extern void afs_put_wb_key(struct afs_wb_key *);
 extern int afs_open(struct inode *, struct file *);
 extern int afs_release(struct inode *, struct file *);
 extern int afs_fetch_data(struct afs_vnode *, struct afs_read *);
+extern struct afs_read *afs_alloc_read(gfp_t);
 extern void afs_put_read(struct afs_read *);
+extern void afs_req_issue_op(struct fscache_io_request *);
+extern void afs_req_done(struct fscache_io_request *);
+extern void afs_req_get(struct fscache_io_request *);
+extern void afs_req_put(struct fscache_io_request *);
+extern struct page *afs_prefetch_for_write(struct file *, struct address_space *,
+					   pgoff_t, unsigned int);
 
 static inline struct afs_read *afs_get_read(struct afs_read *req)
 {
diff --git a/fs/afs/write.c b/fs/afs/write.c
index 73e2f4c93512..cb27027c06bb 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -22,71 +22,6 @@ int afs_set_page_dirty(struct page *page)
 	return __set_page_dirty_nobuffers(page);
 }
 
-/*
- * Handle completion of a read operation to fill a page.
- */
-static void afs_fill_hole(struct fscache_io_request *fsreq)
-{
-	struct afs_read *req = container_of(fsreq, struct afs_read, cache);
-
-	if (iov_iter_count(req->iter) > 0)
-		/* The read was short - clear the excess buffer. */
-		iov_iter_zero(iov_iter_count(req->iter), req->iter);
-}
-
-/*
- * partly or wholly fill a page that's under preparation for writing
- */
-static int afs_fill_page(struct file *file,
-			 loff_t pos, unsigned int len, struct page *page)
-{
-	struct afs_vnode *vnode = AFS_FS_I(file_inode(file));
-	struct afs_read *req;
-	size_t p;
-	void *data;
-	int ret;
-
-	_enter(",,%llu", (unsigned long long)pos);
-
-	if (pos >= vnode->vfs_inode.i_size) {
-		p = pos & ~PAGE_MASK;
-		ASSERTCMP(p + len, <=, PAGE_SIZE);
-		data = kmap(page);
-		memset(data + p, 0, len);
-		kunmap(page);
-		return 0;
-	}
-
-	req = kzalloc(sizeof(struct afs_read), GFP_KERNEL);
-	if (!req)
-		return -ENOMEM;
-
-	refcount_set(&req->usage, 1);
-	req->vnode		= vnode;
-	req->key		= afs_file_key(file);
-	req->cache.io_done	= afs_fill_hole;
-	req->cache.pos		= pos;
-	req->cache.len		= len;
-	req->cache.nr_pages	= 1;
-	req->iter		= &req->def_iter;
-	iov_iter_mapping(&req->def_iter, READ, vnode->vfs_inode.i_mapping,
-			 pos, len);
-
-	ret = afs_fetch_data(vnode, req);
-	afs_put_read(req);
-	if (ret < 0) {
-		if (ret == -ENOENT) {
-			_debug("got NOENT from server"
-			       " - marking file deleted and stale");
-			set_bit(AFS_VNODE_DELETED, &vnode->flags);
-			ret = -ESTALE;
-		}
-	}
-
-	_leave(" = %d", ret);
-	return ret;
-}
-
 /*
  * prepare to perform part of a write to a page
  */
@@ -110,20 +45,15 @@ int afs_write_begin(struct file *file, struct address_space *mapping,
 	 */
 	BUILD_BUG_ON(PAGE_SIZE > 32768 && sizeof(page->private) < 8);
 
-	page = grab_cache_page_write_begin(mapping, index, flags);
-	if (!page)
-		return -ENOMEM;
+	/* Prefetch area to be written into the cache if we're caching this
+	 * file.  We need to do this before we get a lock on the page in case
+	 * there's more than one writer competing for the same cache block.
+	 */
+	page = afs_prefetch_for_write(file, mapping, index, flags);
+	if (IS_ERR(page))
+		return PTR_ERR(page);
 
-	if (!PageUptodate(page) && len != PAGE_SIZE) {
-		ret = afs_fill_page(file, pos & PAGE_MASK, PAGE_SIZE, page);
-		if (ret < 0) {
-			unlock_page(page);
-			put_page(page);
-			_leave(" = %d [prep]", ret);
-			return ret;
-		}
-		SetPageUptodate(page);
-	}
+	ASSERT(PageUptodate(page));
 
 #ifdef CONFIG_AFS_FSCACHE
 	wait_on_page_fscache(page);
@@ -203,7 +133,6 @@ int afs_write_end(struct file *file, struct address_space *mapping,
 {
 	struct afs_vnode *vnode = AFS_FS_I(file_inode(file));
 	loff_t i_size, maybe_i_size;
-	int ret;
 
 	_enter("{%llx:%llu},{%lx}",
 	       vnode->fid.vid, vnode->fid.vnode, page->index);
@@ -219,29 +148,15 @@ int afs_write_end(struct file *file, struct address_space *mapping,
 		write_sequnlock(&vnode->cb_lock);
 	}
 
-	if (!PageUptodate(page)) {
-		if (copied < len) {
-			/* Try and load any missing data from the server.  The
-			 * unmarshalling routine will take care of clearing any
-			 * bits that are beyond the EOF.
-			 */
-			ret = afs_fill_page(file, pos + copied,
-					    len - copied, page);
-			if (ret < 0)
-				goto out;
-		}
-		SetPageUptodate(page);
-	}
+	ASSERT(PageUptodate(page));
 
 	set_page_dirty(page);
 	if (PageDirty(page))
 		_debug("dirtied");
-	ret = copied;
 
-out:
 	unlock_page(page);
 	put_page(page);
-	return ret;
+	return copied;
 }
 
 /*


