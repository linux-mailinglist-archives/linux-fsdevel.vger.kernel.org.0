Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC27F358668
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Apr 2021 16:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbhDHOMG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Apr 2021 10:12:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27758 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232278AbhDHOKi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Apr 2021 10:10:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617891026;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7TrqVgiyjYv1VxmQaPtRlLWcObhOXiGP49jtbIuHgM4=;
        b=Z5Cw3UPuOnfJeJK++1LJjYDxZ9MByPRyCxpHnxFG6lf89nkVtT4FNgb1ImxvdSYOfg7FEV
        nlBOWJ+8SzWJ9xsG5qHkk1SjvgNHc4V7GT3cbJPUOZNmEry/LHqtw4I3onviWNFJE7TWgk
        315LVD5Un2qvqdc5gBKkGWVYF/j/7Hw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-448-QUIPFu7mOyCHnbG9l1kSPA-1; Thu, 08 Apr 2021 10:10:24 -0400
X-MC-Unique: QUIPFu7mOyCHnbG9l1kSPA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 33DA78189CE;
        Thu,  8 Apr 2021 14:10:22 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-119-35.rdu2.redhat.com [10.10.119.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8359B19C66;
        Thu,  8 Apr 2021 14:10:13 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v6 29/30] afs: Use new netfs lib read helper API
From:   David Howells <dhowells@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-afs@lists.infradead.org, linux-cachefs@redhat.com,
        dhowells@redhat.com,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Date:   Thu, 08 Apr 2021 15:10:12 +0100
Message-ID: <161789101258.6155.3879271028895121537.stgit@warthog.procyon.org.uk>
In-Reply-To: <161789062190.6155.12711584466338493050.stgit@warthog.procyon.org.uk>
References: <161789062190.6155.12711584466338493050.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Make AFS use the new netfs read helpers to implement the VM read
operations:

 - afs_readpage() now hands off responsibility to netfs_readpage().

 - afs_readpages() is gone and replaced with afs_readahead().

 - afs_readahead() just hands off responsibility to netfs_readahead().

These make use of the cache if a cookie is supplied, otherwise just call
the ->issue_op() method a sufficient number of times to complete the entire
request.

Changes:
v5:
- Use proper wait function for PG_fscache in afs_page_mkwrite()[1].
- Use killable wait for PG_writeback in afs_page_mkwrite()[1].

v4:
- Folded in error handling fixes to afs_req_issue_op().
- Added flag to netfs_subreq_terminated() to indicate that the caller may
  have been running async and stuff that might sleep needs punting to a
  workqueue.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-afs@lists.infradead.org
cc: linux-cachefs@redhat.com
cc: linux-fsdevel@vger.kernel.org
Link: https://lore.kernel.org/r/2499407.1616505440@warthog.procyon.org.uk [1]
Link: https://lore.kernel.org/r/160588542733.3465195.7526541422073350302.stgit@warthog.procyon.org.uk/ # rfc
Link: https://lore.kernel.org/r/161118158436.1232039.3884845981224091996.stgit@warthog.procyon.org.uk/ # rfc
Link: https://lore.kernel.org/r/161161053540.2537118.14904446369309535330.stgit@warthog.procyon.org.uk/ # v2
Link: https://lore.kernel.org/r/161340418739.1303470.5908092911600241280.stgit@warthog.procyon.org.uk/ # v3
Link: https://lore.kernel.org/r/161539561926.286939.5729036262354802339.stgit@warthog.procyon.org.uk/ # v4
Link: https://lore.kernel.org/r/161653817977.2770958.17696456811587237197.stgit@warthog.procyon.org.uk/ # v5
---

 fs/afs/Kconfig    |    1 
 fs/afs/file.c     |  327 +++++++++++++----------------------------------------
 fs/afs/fsclient.c |    1 
 fs/afs/internal.h |    3 
 fs/afs/write.c    |    7 +
 5 files changed, 88 insertions(+), 251 deletions(-)

diff --git a/fs/afs/Kconfig b/fs/afs/Kconfig
index 1ad211d72b3b..fc8ba9142f2f 100644
--- a/fs/afs/Kconfig
+++ b/fs/afs/Kconfig
@@ -4,6 +4,7 @@ config AFS_FS
 	depends on INET
 	select AF_RXRPC
 	select DNS_RESOLVER
+	select NETFS_SUPPORT
 	help
 	  If you say Y here, you will get an experimental Andrew File System
 	  driver. It currently only supports unsecured read-only AFS access.
diff --git a/fs/afs/file.c b/fs/afs/file.c
index 2db810467d3f..10c6eaaac2cc 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -14,6 +14,7 @@
 #include <linux/gfp.h>
 #include <linux/task_io_accounting_ops.h>
 #include <linux/mm.h>
+#include <linux/netfs.h>
 #include "internal.h"
 
 static int afs_file_mmap(struct file *file, struct vm_area_struct *vma);
@@ -22,8 +23,7 @@ static void afs_invalidatepage(struct page *page, unsigned int offset,
 			       unsigned int length);
 static int afs_releasepage(struct page *page, gfp_t gfp_flags);
 
-static int afs_readpages(struct file *filp, struct address_space *mapping,
-			 struct list_head *pages, unsigned nr_pages);
+static void afs_readahead(struct readahead_control *ractl);
 
 const struct file_operations afs_file_operations = {
 	.open		= afs_open,
@@ -47,7 +47,7 @@ const struct inode_operations afs_file_inode_operations = {
 
 const struct address_space_operations afs_fs_aops = {
 	.readpage	= afs_readpage,
-	.readpages	= afs_readpages,
+	.readahead	= afs_readahead,
 	.set_page_dirty	= afs_set_page_dirty,
 	.launder_page	= afs_launder_page,
 	.releasepage	= afs_releasepage,
@@ -184,61 +184,17 @@ int afs_release(struct inode *inode, struct file *file)
 }
 
 /*
- * Handle completion of a read operation.
+ * Allocate a new read record.
  */
-static void afs_file_read_done(struct afs_read *req)
+struct afs_read *afs_alloc_read(gfp_t gfp)
 {
-	struct afs_vnode *vnode = req->vnode;
-	struct page *page;
-	pgoff_t index = req->pos >> PAGE_SHIFT;
-	pgoff_t last = index + req->nr_pages - 1;
-
-	XA_STATE(xas, &vnode->vfs_inode.i_mapping->i_pages, index);
-
-	if (iov_iter_count(req->iter) > 0) {
-		/* The read was short - clear the excess buffer. */
-		_debug("afterclear %zx %zx %llx/%llx",
-		       req->iter->iov_offset,
-		       iov_iter_count(req->iter),
-		       req->actual_len, req->len);
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
-	task_io_account_read(req->len);
-	req->cleanup = NULL;
-}
-
-/*
- * Dispose of our locks and refs on the pages if the read failed.
- */
-static void afs_file_read_cleanup(struct afs_read *req)
-{
-	struct page *page;
-	pgoff_t index = req->pos >> PAGE_SHIFT;
-	pgoff_t last = index + req->nr_pages - 1;
-
-	if (req->iter) {
-		XA_STATE(xas, &req->vnode->vfs_inode.i_mapping->i_pages, index);
-
-		_enter("%lu,%u,%zu", index, req->nr_pages, iov_iter_count(req->iter));
+	struct afs_read *req;
 
-		rcu_read_lock();
-		xas_for_each(&xas, page, last) {
-			BUG_ON(xa_is_value(page));
-			BUG_ON(PageCompound(page));
+	req = kzalloc(sizeof(struct afs_read), gfp);
+	if (req)
+		refcount_set(&req->usage, 1);
 
-			page_endio(page, false, req->error);
-			put_page(page);
-		}
-		rcu_read_unlock();
-	}
+	return req;
 }
 
 /*
@@ -257,14 +213,20 @@ void afs_put_read(struct afs_read *req)
 static void afs_fetch_data_notify(struct afs_operation *op)
 {
 	struct afs_read *req = op->fetch.req;
+	struct netfs_read_subrequest *subreq = req->subreq;
 	int error = op->error;
 
 	if (error == -ECONNABORTED)
 		error = afs_abort_to_error(op->ac.abort_code);
 	req->error = error;
 
-	if (req->done)
+	if (subreq) {
+		__set_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags);
+		netfs_subreq_terminated(subreq, error ?: req->actual_len, false);
+		req->subreq = NULL;
+	} else if (req->done) {
 		req->done(req);
+	}
 }
 
 static void afs_fetch_data_success(struct afs_operation *op)
@@ -308,8 +270,11 @@ int afs_fetch_data(struct afs_vnode *vnode, struct afs_read *req)
 	       key_serial(req->key));
 
 	op = afs_alloc_operation(req->key, vnode->volume);
-	if (IS_ERR(op))
+	if (IS_ERR(op)) {
+		if (req->subreq)
+			netfs_subreq_terminated(req->subreq, PTR_ERR(op), false);
 		return PTR_ERR(op);
+	}
 
 	afs_op_set_vnode(op, 0, vnode);
 
@@ -318,222 +283,86 @@ int afs_fetch_data(struct afs_vnode *vnode, struct afs_read *req)
 	return afs_do_sync_operation(op);
 }
 
-/*
- * read page from file, directory or symlink, given a key to use
- */
-static int afs_page_filler(struct key *key, struct page *page)
+static void afs_req_issue_op(struct netfs_read_subrequest *subreq)
 {
-	struct inode *inode = page->mapping->host;
-	struct afs_vnode *vnode = AFS_FS_I(inode);
-	struct afs_read *req;
-	int ret;
-
-	_enter("{%x},{%lu},{%lu}", key_serial(key), inode->i_ino, page->index);
+	struct afs_vnode *vnode = AFS_FS_I(subreq->rreq->inode);
+	struct afs_read *fsreq;
 
-	BUG_ON(!PageLocked(page));
-
-	ret = -ESTALE;
-	if (test_bit(AFS_VNODE_DELETED, &vnode->flags))
-		goto error;
+	fsreq = afs_alloc_read(GFP_NOFS);
+	if (!fsreq)
+		return netfs_subreq_terminated(subreq, -ENOMEM, false);
 
-	req = kzalloc(sizeof(struct afs_read), GFP_KERNEL);
-	if (!req)
-		goto enomem;
-
-	refcount_set(&req->usage, 1);
-	req->vnode		= vnode;
-	req->key		= key_get(key);
-	req->pos		= (loff_t)page->index << PAGE_SHIFT;
-	req->len		= thp_size(page);
-	req->nr_pages		= thp_nr_pages(page);
-	req->done		= afs_file_read_done;
-	req->cleanup		= afs_file_read_cleanup;
-
-	get_page(page);
-	iov_iter_xarray(&req->def_iter, READ, &page->mapping->i_pages,
-			req->pos, req->len);
-	req->iter = &req->def_iter;
-
-	ret = afs_fetch_data(vnode, req);
-	if (ret < 0)
-		goto fetch_error;
+	fsreq->subreq	= subreq;
+	fsreq->pos	= subreq->start + subreq->transferred;
+	fsreq->len	= subreq->len   - subreq->transferred;
+	fsreq->key	= subreq->rreq->netfs_priv;
+	fsreq->vnode	= vnode;
+	fsreq->iter	= &fsreq->def_iter;
 
-	afs_put_read(req);
-	_leave(" = 0");
-	return 0;
+	iov_iter_xarray(&fsreq->def_iter, READ,
+			&fsreq->vnode->vfs_inode.i_mapping->i_pages,
+			fsreq->pos, fsreq->len);
 
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
-
-enomem:
-	ret = -ENOMEM;
-error:
-	unlock_page(page);
-	_leave(" = %d", ret);
-	return ret;
+	afs_fetch_data(fsreq->vnode, fsreq);
 }
 
-/*
- * read page from file, directory or symlink, given a file to nominate the key
- * to be used
- */
-static int afs_readpage(struct file *file, struct page *page)
+static int afs_symlink_readpage(struct page *page)
 {
-	struct key *key;
+	struct afs_vnode *vnode = AFS_FS_I(page->mapping->host);
+	struct afs_read *fsreq;
 	int ret;
 
-	if (file) {
-		key = afs_file_key(file);
-		ASSERT(key != NULL);
-		ret = afs_page_filler(key, page);
-	} else {
-		struct inode *inode = page->mapping->host;
-		key = afs_request_key(AFS_FS_S(inode->i_sb)->cell);
-		if (IS_ERR(key)) {
-			ret = PTR_ERR(key);
-		} else {
-			ret = afs_page_filler(key, page);
-			key_put(key);
-		}
-	}
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
-
-	req = kzalloc(sizeof(struct afs_read), GFP_NOFS);
-	if (!req)
+	fsreq = afs_alloc_read(GFP_NOFS);
+	if (!fsreq)
 		return -ENOMEM;
 
-	refcount_set(&req->usage, 1);
-	req->vnode = vnode;
-	req->key = key_get(afs_file_key(file));
-	req->done = afs_file_read_done;
-	req->cleanup = afs_file_read_cleanup;
-	req->pos = first->index;
-	req->pos <<= PAGE_SHIFT;
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
-		req->nr_pages++;
-	} while (req->nr_pages < n);
-
-	if (req->nr_pages == 0) {
-		afs_put_read(req);
-		return 0;
-	}
-
-	req->len = req->nr_pages * PAGE_SIZE;
-	iov_iter_xarray(&req->def_iter, READ, &file->f_mapping->i_pages,
-			req->pos, req->len);
-	req->iter = &req->def_iter;
+	fsreq->pos	= page->index * PAGE_SIZE;
+	fsreq->len	= PAGE_SIZE;
+	fsreq->vnode	= vnode;
+	fsreq->iter	= &fsreq->def_iter;
+	iov_iter_xarray(&fsreq->def_iter, READ, &page->mapping->i_pages,
+			fsreq->pos, fsreq->len);
 
-	ret = afs_fetch_data(vnode, req);
-	if (ret < 0)
-		goto error;
+	ret = afs_fetch_data(fsreq->vnode, fsreq);
+	page_endio(page, false, ret);
+	return ret;
+}
 
-	afs_put_read(req);
-	return 0;
+static void afs_init_rreq(struct netfs_read_request *rreq, struct file *file)
+{
+	rreq->netfs_priv = key_get(afs_file_key(file));
+}
 
-error:
-	if (ret == -ENOENT) {
-		_debug("got NOENT from server - marking file deleted and stale");
-		set_bit(AFS_VNODE_DELETED, &vnode->flags);
-		ret = -ESTALE;
-	}
+static int afs_begin_cache_operation(struct netfs_read_request *rreq)
+{
+	struct afs_vnode *vnode = AFS_FS_I(rreq->inode);
 
-	afs_put_read(req);
-	return ret;
+	return fscache_begin_read_operation(rreq, afs_vnode_cache(vnode));
 }
 
-/*
- * read a set of pages
- */
-static int afs_readpages(struct file *file, struct address_space *mapping,
-			 struct list_head *pages, unsigned nr_pages)
+static void afs_priv_cleanup(struct address_space *mapping, void *netfs_priv)
 {
-	struct key *key = afs_file_key(file);
-	struct afs_vnode *vnode;
-	int ret = 0;
-
-	_enter("{%d},{%lu},,%d",
-	       key_serial(key), mapping->host->i_ino, nr_pages);
+	key_put(netfs_priv);
+}
 
-	ASSERT(key != NULL);
+static const struct netfs_read_request_ops afs_req_ops = {
+	.init_rreq		= afs_init_rreq,
+	.begin_cache_operation	= afs_begin_cache_operation,
+	.issue_op		= afs_req_issue_op,
+	.cleanup		= afs_priv_cleanup,
+};
 
-	vnode = AFS_FS_I(mapping->host);
-	if (test_bit(AFS_VNODE_DELETED, &vnode->flags)) {
-		_leave(" = -ESTALE");
-		return -ESTALE;
-	}
+static int afs_readpage(struct file *file, struct page *page)
+{
+	if (!file)
+		return afs_symlink_readpage(page);
 
-	/* attempt to read as many of the pages as possible */
-	while (!list_empty(pages)) {
-		ret = afs_readpages_one(file, mapping, pages);
-		if (ret < 0)
-			break;
-	}
+	return netfs_readpage(file, page, &afs_req_ops, NULL);
+}
 
-	_leave(" = %d [netting]", ret);
-	return ret;
+static void afs_readahead(struct readahead_control *ractl)
+{
+	netfs_readahead(ractl, &afs_req_ops, NULL);
 }
 
 /*
diff --git a/fs/afs/fsclient.c b/fs/afs/fsclient.c
index 5e34f4dbd385..2f695a260442 100644
--- a/fs/afs/fsclient.c
+++ b/fs/afs/fsclient.c
@@ -10,6 +10,7 @@
 #include <linux/sched.h>
 #include <linux/circ_buf.h>
 #include <linux/iversion.h>
+#include <linux/netfs.h>
 #include "internal.h"
 #include "afs_fs.h"
 #include "xdr_fs.h"
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index ee283e3ebc4d..f9a692fc08f4 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -14,6 +14,7 @@
 #include <linux/key.h>
 #include <linux/workqueue.h>
 #include <linux/sched.h>
+#define FSCACHE_USE_NEW_IO_API
 #include <linux/fscache.h>
 #include <linux/backing-dev.h>
 #include <linux/uuid.h>
@@ -207,6 +208,7 @@ struct afs_read {
 	loff_t			file_size;	/* File size returned by server */
 	struct key		*key;		/* The key to use to reissue the read */
 	struct afs_vnode	*vnode;		/* The file being read into. */
+	struct netfs_read_subrequest *subreq;	/* Fscache helper read request this belongs to */
 	afs_dataversion_t	data_version;	/* Version number returned by server */
 	refcount_t		usage;
 	unsigned int		call_debug_id;
@@ -1049,6 +1051,7 @@ extern void afs_put_wb_key(struct afs_wb_key *);
 extern int afs_open(struct inode *, struct file *);
 extern int afs_release(struct inode *, struct file *);
 extern int afs_fetch_data(struct afs_vnode *, struct afs_read *);
+extern struct afs_read *afs_alloc_read(gfp_t);
 extern void afs_put_read(struct afs_read *);
 
 static inline struct afs_read *afs_get_read(struct afs_read *req)
diff --git a/fs/afs/write.c b/fs/afs/write.c
index 099c7dad09c5..bc84c771b0fd 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -930,7 +930,7 @@ vm_fault_t afs_page_mkwrite(struct vm_fault *vmf)
 	 */
 #ifdef CONFIG_AFS_FSCACHE
 	if (PageFsCache(page) &&
-	    wait_on_page_bit_killable(page, PG_fscache) < 0)
+	    wait_on_page_fscache_killable(page) < 0)
 		return VM_FAULT_RETRY;
 #endif
 
@@ -944,7 +944,10 @@ vm_fault_t afs_page_mkwrite(struct vm_fault *vmf)
 	 * details the portion of the page we need to write back and we might
 	 * need to redirty the page if there's a problem.
 	 */
-	wait_on_page_writeback(page);
+	if (wait_on_page_writeback_killable(page) < 0) {
+		unlock_page(page);
+		return VM_FAULT_RETRY;
+	}
 
 	priv = afs_page_dirty(page, 0, thp_size(page));
 	priv = afs_page_dirty_mmapped(priv);


