Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 122811C4213
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 May 2020 19:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730016AbgEDRQA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 May 2020 13:16:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24940 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729965AbgEDRQA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 May 2020 13:16:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588612557;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1uo7aZaL1Nnvpj2Q3BRPY7bJoC93+PdutZ3W4SI03Ao=;
        b=AT/65YyoaOKKDUPnitXUmA2Twrv9mZUgYbXt2coyg8JiSiKD1WuxslMO025T9ZqKg9MAqp
        c0d1oDuZIdn7vaxQMZpqfF39/LARMGTvUEznBjrjpwVqkjWwWGUdDZAOJeofz9Ns5KZ1Ue
        AgR38a16ZcQjdFWxUkaavmjHQniy2Pw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-49-qI9DVn1cMJKKuDaZHEUJrg-1; Mon, 04 May 2020 13:15:54 -0400
X-MC-Unique: qI9DVn1cMJKKuDaZHEUJrg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B20D019200C3;
        Mon,  4 May 2020 17:15:52 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-225.rdu2.redhat.com [10.10.118.225])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3212D5C1BD;
        Mon,  4 May 2020 17:15:50 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 55/61] afs: Use new fscache I/O API
From:   David Howells <dhowells@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Jeff Layton <jlayton@redhat.com>
Cc:     dhowells@redhat.com, Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 04 May 2020 18:15:49 +0100
Message-ID: <158861254941.340223.17468281211439283746.stgit@warthog.procyon.org.uk>
In-Reply-To: <158861203563.340223.7585359869938129395.stgit@warthog.procyon.org.uk>
References: <158861203563.340223.7585359869938129395.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.21
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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

 fs/afs/dir.c       |    1 
 fs/afs/file.c      |  409 ++++++++++++++++++++++++++++------------------------
 fs/afs/fsclient.c  |    8 +
 fs/afs/internal.h  |   11 +
 fs/afs/write.c     |   91 +-----------
 fs/afs/yfsclient.c |    8 +
 6 files changed, 255 insertions(+), 273 deletions(-)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 577c975c13b0..d04ab47e505c 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -305,6 +305,7 @@ static struct afs_read *afs_read_dir(struct afs_vnode *dvnode, struct key *key)
 	req->vnode = dvnode;
 	req->cleanup = afs_dir_read_cleanup;
 	req->cache.io_done = afs_dir_read_done;
+	fscache_init_io_request(&req->cache, NULL, NULL);
 
 expand:
 	i_size = i_size_read(&dvnode->vfs_inode);
diff --git a/fs/afs/file.c b/fs/afs/file.c
index b25c5ab1f4e1..945930462492 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -197,60 +197,70 @@ int afs_release(struct inode *inode, struct file *file)
 }
 
 /*
- * Handle completion of a read operation.
+ * Dispose of our locks and refs on the pages if the read failed.
  */
-static void afs_file_read_done(struct fscache_io_request *fsreq)
+static void afs_file_read_cleanup(struct afs_read *req)
 {
-	struct afs_read *req = container_of(fsreq, struct afs_read, cache);
 	struct afs_vnode *vnode = req->vnode;
 	struct page *page;
 	pgoff_t index = req->cache.pos >> PAGE_SHIFT;
 	pgoff_t last = index + req->cache.nr_pages - 1;
 
-	XA_STATE(xas, &vnode->vfs_inode.i_mapping->i_pages, index);
+	_enter("%lx,%x,%llx", index, req->cache.nr_pages, req->cache.len);
 
-	if (iov_iter_count(req->iter) > 0) {
-		/* The read was short - clear the excess buffer. */
-		_debug("afterclear %zx %zx %llx/%llx",
-		       req->iter->iov_offset,
-		       iov_iter_count(req->iter),
-		       req->actual_len, req->cache.len);
-		iov_iter_zero(iov_iter_count(req->iter), req->iter);
-	}
+	if (req->cache.nr_pages > 0) {
+		XA_STATE(xas, &vnode->vfs_inode.i_mapping->i_pages, index);
+
+		rcu_read_lock();
+		xas_for_each(&xas, page, last) {
+			BUG_ON(xa_is_value(page));
+			BUG_ON(PageCompound(page));
 
-	rcu_read_lock();
-	xas_for_each(&xas, page, last) {
-		page_endio(page, false, 0);
-		put_page(page);
+			if (req->cache.error)
+				page_endio(page, false, req->cache.error);
+			else
+				unlock_page(page);
+			put_page(page);
+		}
+		rcu_read_unlock();
 	}
-	rcu_read_unlock();
 
-	task_io_account_read(req->cache.len);
-	req->cleanup = NULL;
+	if (test_bit(AFS_READ_IN_PROGRESS, &req->flags)) {
+		clear_bit_unlock(AFS_READ_IN_PROGRESS, &req->flags);
+		wake_up_bit(&req->flags, AFS_READ_IN_PROGRESS);
+	}
 }
 
 /*
- * Dispose of our locks and refs on the pages if the read failed.
+ * Allocate a new read record.
  */
-static void afs_file_read_cleanup(struct afs_read *req)
+struct afs_read *afs_alloc_read(gfp_t gfp)
 {
-	struct page *page;
-	pgoff_t index = req->cache.pos >> PAGE_SHIFT;
-	pgoff_t last = index + req->cache.nr_pages - 1;
+	static atomic_t debug_ids;
+	struct afs_read *req;
 
-	XA_STATE(xas, &req->iter->mapping->i_pages, index);
+	req = kzalloc(sizeof(struct afs_read), gfp);
+	if (req) {
+		refcount_set(&req->usage, 1);
+		req->debug_id = atomic_inc_return(&debug_ids);
+		__set_bit(AFS_READ_IN_PROGRESS, &req->flags);
+	}
 
-	_enter("%lu,%u,%zu", index, req->cache.nr_pages, iov_iter_count(req->iter));
+	return req;
+}
 
-	rcu_read_lock();
-	xas_for_each(&xas, page, last) {
-		BUG_ON(xa_is_value(page));
-		BUG_ON(PageCompound(page));
+/*
+ *
+ */
+static void __afs_put_read(struct work_struct *work)
+{
+	struct afs_read *req = container_of(work, struct afs_read, cache.work);
 
-		page_endio(page, false, req->cache.error);
-		put_page(page);
-	}
-	rcu_read_unlock();
+	if (req->cleanup)
+		req->cleanup(req);
+	fscache_free_io_request(&req->cache);
+	key_put(req->key);
+	kfree(req);
 }
 
 /*
@@ -259,10 +269,13 @@ static void afs_file_read_cleanup(struct afs_read *req)
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
 
@@ -313,190 +326,130 @@ int afs_fetch_data(struct afs_vnode *vnode, struct afs_read *req)
 	return ret;
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
+	req->cleanup = NULL;
+	if (test_bit(AFS_READ_IN_PROGRESS, &req->flags)) {
+		clear_bit_unlock(AFS_READ_IN_PROGRESS, &req->flags);
+		wake_up_bit(&req->flags, AFS_READ_IN_PROGRESS);
 	}
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
 }
 
+void afs_req_put(struct fscache_io_request *fsreq)
+{
+	struct afs_read *req = container_of(fsreq, struct afs_read, cache);
+
+	afs_put_read(req);
+}
+
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
+	struct fscache_extent extent;
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
-
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
+	req->cache.mapping = page->mapping;
 
-		req->cache.nr_pages++;
-	} while (req->cache.nr_pages < n);
+	extent.start = page->index;
+	extent.block_end = page->index + 1;
+	extent.limit = ULONG_MAX;
 
-	if (req->cache.nr_pages == 0) {
-		afs_put_read(req);
-		return 0;
-	}
+	ret = fscache_read_helper(&req->cache, &extent, &page, NULL,
+				  FSCACHE_READ_LOCKED_PAGE, 0);
+	afs_put_read(req);
+	return ret;
 
-	req->cache.len = req->cache.nr_pages * PAGE_SIZE;
-	iov_iter_mapping(&req->def_iter, READ, file->f_mapping,
-			 req->cache.pos, req->cache.len);
-	req->iter = &req->def_iter;
+out_key:
+	key_put(key);
+out:
+	return ret;
+}
 
-	ret = afs_fetch_data(vnode, req);
-	if (ret < 0)
-		goto error;
+/*
+ * Determine the extent of contiguous pages at the front of the list.
+ * Note that the list goes prev-wards rather than next-wards.
+ *
+ * We also determine the last page we can include in a transaction -  we stop
+ * if there's a non-contiguity in the page list, but we include the gap.
+ */
+static void afs_count_contig(struct list_head *pages,
+			     struct fscache_extent *extent)
+{
+	struct list_head *p;
+	struct page *first = lru_to_page(pages), *page;
 
-	afs_put_read(req);
-	return 0;
+	extent->start = first->index;
+	extent->block_end = first->index + 1;
+	extent->limit = ULONG_MAX;
 
-error:
-	if (ret == -ENOENT) {
-		_debug("got NOENT from server - marking file deleted and stale");
-		set_bit(AFS_VNODE_DELETED, &vnode->flags);
-		ret = -ESTALE;
+	for (p = first->lru.prev; p != pages; p = p->prev) {
+		page = list_entry(p, struct page, lru);
+		if (page->index != extent->block_end) {
+			extent->limit = page->index;
+			break;
+		}
+		extent->block_end = page->index + 1;
 	}
 
-	afs_put_read(req);
-	return ret;
+	_leave(" [%lx,%lx,%lx]",
+	       extent->start, extent->block_end, extent->limit);
 }
 
 /*
@@ -505,14 +458,12 @@ static int afs_readpages_one(struct file *file, struct address_space *mapping,
 static int afs_readpages(struct file *file, struct address_space *mapping,
 			 struct list_head *pages, unsigned nr_pages)
 {
-	struct key *key = afs_file_key(file);
+	struct fscache_extent extent;
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
@@ -520,9 +471,26 @@ static int afs_readpages(struct file *file, struct address_space *mapping,
 		return -ESTALE;
 	}
 
-	/* attempt to read as many of the pages as possible */
 	while (!list_empty(pages)) {
-		ret = afs_readpages_one(file, mapping, pages);
+		/* Determine the size of the next contiguous run of pages and
+		 * find out what size of download will be required to pad it
+		 * out to a whole number of cache blocks.
+		 */
+		afs_count_contig(pages, &extent);
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
+		ret = fscache_read_helper(&req->cache, &extent, NULL, pages,
+					  FSCACHE_READ_PAGE_LIST, 0);
+		afs_put_read(req);
 		if (ret < 0)
 			break;
 	}
@@ -531,6 +499,71 @@ static int afs_readpages(struct file *file, struct address_space *mapping,
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
+	struct fscache_extent extent;
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
+	extent.start = index;
+	extent.block_end = index + 1;
+	extent.limit = ULONG_MAX;
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
+	ret = fscache_read_helper(&req->cache, &extent, &page, NULL,
+				  FSCACHE_READ_FOR_WRITE, aop_flags);
+	if (ret == 0)
+		/* Synchronicity required */
+		ret = wait_on_bit(&req->flags, AFS_READ_IN_PROGRESS, TASK_KILLABLE);
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
diff --git a/fs/afs/fsclient.c b/fs/afs/fsclient.c
index 62cc8072874b..0d0fbc594b52 100644
--- a/fs/afs/fsclient.c
+++ b/fs/afs/fsclient.c
@@ -422,8 +422,11 @@ static int afs_deliver_fs_fetch_data(struct afs_call *call)
 	 */
 	req->cache.transferred = min(req->actual_len, req->cache.len);
 	set_bit(FSCACHE_IO_DATA_FROM_SERVER, &req->cache.flags);
-	if (req->cache.io_done)
+	if (req->cache.io_done) {
 		req->cache.io_done(&req->cache);
+		afs_put_read(req);
+		call->read_request = NULL;
+	}
 
 	_leave(" = 0 [done]");
 	return 0;
@@ -433,7 +436,8 @@ static void afs_fetch_data_destructor(struct afs_call *call)
 {
 	struct afs_read *req = call->read_request;
 
-	afs_put_read(req);
+	if (req)
+		afs_put_read(req);
 	afs_flat_call_destructor(call);
 }
 
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 9f56acdc2ed9..70b8437d391f 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -227,7 +227,10 @@ struct afs_read {
 	struct afs_vnode	*vnode;		/* The file being read into. */
 	afs_dataversion_t	data_version;	/* Version number returned by server */
 	refcount_t		usage;
+	unsigned int		debug_id;
 	unsigned int		call_debug_id;
+	unsigned long		flags;
+#define AFS_READ_IN_PROGRESS	0		/* Set whilst a read is in progress */
 	void (*cleanup)(struct afs_read *req);
 };
 
@@ -906,6 +909,7 @@ extern void afs_dynroot_depopulate(struct super_block *);
 /*
  * file.c
  */
+extern const struct fscache_io_request_ops afs_req_ops;
 extern const struct address_space_operations afs_fs_aops;
 extern const struct inode_operations afs_file_inode_operations;
 extern const struct file_operations afs_file_operations;
@@ -915,7 +919,14 @@ extern void afs_put_wb_key(struct afs_wb_key *);
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
index 3632909fcd91..312d8f07533e 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -22,57 +22,6 @@ int afs_set_page_dirty(struct page *page)
 	return __set_page_dirty_nobuffers(page);
 }
 
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
-	req->key = afs_file_key(file);
-	req->cache.pos = pos;
-	req->cache.len = len;
-	req->cache.nr_pages = 1;
-	iov_iter_mapping(&req->def_iter, READ, vnode->vfs_inode.i_mapping,
-			 pos, len);
-	req->iter = &req->def_iter;
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
@@ -96,20 +45,15 @@ int afs_write_begin(struct file *file, struct address_space *mapping,
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
@@ -189,7 +133,6 @@ int afs_write_end(struct file *file, struct address_space *mapping,
 {
 	struct afs_vnode *vnode = AFS_FS_I(file_inode(file));
 	loff_t i_size, maybe_i_size;
-	int ret;
 
 	_enter("{%llx:%llu},{%lx}",
 	       vnode->fid.vid, vnode->fid.vnode, page->index);
@@ -205,29 +148,15 @@ int afs_write_end(struct file *file, struct address_space *mapping,
 		spin_unlock(&vnode->wb_lock);
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
diff --git a/fs/afs/yfsclient.c b/fs/afs/yfsclient.c
index fb3f006be31c..74fce9736796 100644
--- a/fs/afs/yfsclient.c
+++ b/fs/afs/yfsclient.c
@@ -536,8 +536,11 @@ static int yfs_deliver_fs_fetch_data64(struct afs_call *call)
 	 */
 	req->cache.transferred = min(req->actual_len, req->cache.len);
 	set_bit(FSCACHE_IO_DATA_FROM_SERVER, &req->cache.flags);
-	if (req->cache.io_done)
+	if (req->cache.io_done) {
 		req->cache.io_done(&req->cache);
+		afs_put_read(req);
+		call->read_request = NULL;
+	}
 
 	_leave(" = 0 [done]");
 	return 0;
@@ -545,7 +548,8 @@ static int yfs_deliver_fs_fetch_data64(struct afs_call *call)
 
 static void yfs_fetch_data_destructor(struct afs_call *call)
 {
-	afs_put_read(call->read_request);
+	if (call->read_request)
+		afs_put_read(call->read_request);
 	afs_flat_call_destructor(call);
 }
 


