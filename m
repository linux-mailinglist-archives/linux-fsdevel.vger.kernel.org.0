Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 422172BAE8D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 16:23:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729220AbgKTPRX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 10:17:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53827 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729543AbgKTPRW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 10:17:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605885440;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xpi/zx0WpQeJ21WaLq1opQoFrKYl78TsXTkkyqo5A6w=;
        b=boh/Nv65T2W6/I9M1bw9lzbu99nlO/cXQHlQHGghgKpy6h4WwXa3r/jQomEpLg+BaCisqS
        EnJ8zdQOyxJQxWqV1EltcL/bb4B6lMU9SQa+5m33cqwo7vt1j8CgRfYg9k7YAlWJCD//UV
        YuHzAkuRcIIXAspso9n+7eEHkY+uIzU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-260-os8OFOdINe6j3pR4x3CIFw-1; Fri, 20 Nov 2020 10:17:16 -0500
X-MC-Unique: os8OFOdINe6j3pR4x3CIFw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5BF35803631;
        Fri, 20 Nov 2020 15:17:14 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-246.rdu2.redhat.com [10.10.112.246])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3679E60853;
        Fri, 20 Nov 2020 15:17:08 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 67/76] afs: Use new fscache read helper API
From:   David Howells <dhowells@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>
Cc:     dhowells@redhat.com, Jeff Layton <jlayton@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:17:07 +0000
Message-ID: <160588542733.3465195.7526541422073350302.stgit@warthog.procyon.org.uk>
In-Reply-To: <160588455242.3465195.3214733858273019178.stgit@warthog.procyon.org.uk>
References: <160588455242.3465195.3214733858273019178.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Make AFS use the new fscache read helpers to implement the VM read
operations:

 - afs_readpage() now hands off responsibility to fscache_readpage().

 - afs_readpages() is gone and replaced with afs_readahead().

 - afs_readahead() just hands off responsibility to fscache_readahead().

These make use of the cache if a cookie is supplied, otherwise just call
the ->issue_op() method a sufficient number of times to complete the entire
request.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/file.c     |  326 +++++++++++++----------------------------------------
 fs/afs/fsclient.c |    1 
 fs/afs/internal.h |    2 
 fs/afs/super.c    |   24 ++++
 4 files changed, 108 insertions(+), 245 deletions(-)

diff --git a/fs/afs/file.c b/fs/afs/file.c
index 38dda8990b4c..8772f5e1cbd3 100644
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
@@ -48,7 +48,7 @@ const struct inode_operations afs_file_inode_operations = {
 
 const struct address_space_operations afs_fs_aops = {
 	.readpage	= afs_readpage,
-	.readpages	= afs_readpages,
+	.readahead	= afs_readahead,
 	.set_page_dirty	= afs_set_page_dirty,
 	.launder_page	= afs_launder_page,
 	.releasepage	= afs_releasepage,
@@ -198,61 +198,17 @@ int afs_release(struct inode *inode, struct file *file)
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
@@ -271,14 +227,20 @@ void afs_put_read(struct afs_read *req)
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
+		netfs_subreq_terminated(subreq, error ?: req->actual_len);
+		req->subreq = NULL;
+	} else if (req->done) {
 		req->done(req);
+	}
 }
 
 static void afs_fetch_data_success(struct afs_operation *op)
@@ -332,222 +294,96 @@ int afs_fetch_data(struct afs_vnode *vnode, struct afs_read *req)
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
+	struct afs_vnode *vnode = AFS_FS_I(subreq->rreq->inode);
+	struct afs_read *fsreq;
 	int ret;
 
-	_enter("{%x},{%lu},{%lu}", key_serial(key), inode->i_ino, page->index);
+	fsreq = afs_alloc_read(GFP_NOFS);
+	if (!fsreq) {
+		subreq->error = -ENOMEM;
+		return;
+	}
 
-	BUG_ON(!PageLocked(page));
+	fsreq->subreq	= subreq;
+	fsreq->pos	= subreq->start + subreq->transferred;
+	fsreq->len	= subreq->len   - subreq->transferred;
+	fsreq->key	= subreq->rreq->netfs_priv;
+	fsreq->vnode	= vnode;
+	fsreq->iter	= &fsreq->def_iter;
 
-	ret = -ESTALE;
-	if (test_bit(AFS_VNODE_DELETED, &vnode->flags))
-		goto error;
+	iov_iter_xarray(&fsreq->def_iter, READ,
+			&fsreq->vnode->vfs_inode.i_mapping->i_pages,
+			fsreq->pos, fsreq->len);
 
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
+	ret = afs_fetch_data(fsreq->vnode, fsreq);
 	if (ret < 0)
-		goto fetch_error;
-
-	afs_put_read(req);
-	_leave(" = 0");
-	return 0;
-
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
+		subreq->error = ret;
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
+	fsreq->pos	= page->index * PAGE_SIZE;
+	fsreq->len	= PAGE_SIZE;
+	fsreq->vnode	= vnode;
+	fsreq->iter	= &fsreq->def_iter;
+	iov_iter_xarray(&fsreq->def_iter, READ, &page->mapping->i_pages,
+			fsreq->pos, fsreq->len);
 
-	req->len = req->nr_pages * PAGE_SIZE;
-	iov_iter_xarray(&req->def_iter, READ, &file->f_mapping->i_pages,
-			req->pos, req->len);
-	req->iter = &req->def_iter;
+	ret = afs_fetch_data(fsreq->vnode, fsreq);
+	page_endio(page, false, ret);
+	return ret;
+}
 
-	ret = afs_fetch_data(vnode, req);
-	if (ret < 0)
-		goto error;
+static void afs_init_rreq(struct netfs_read_request *rreq, struct file *file)
+{
+	struct afs_vnode *vnode = AFS_FS_I(rreq->inode);
 
-	afs_put_read(req);
-	return 0;
+	rreq->netfs_priv = key_get(afs_file_key(file));
+	if (afs_vnode_cache(vnode))
+		rreq->cookie_debug_id = afs_vnode_cache(vnode)->debug_id;
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
+	return fscache_begin_operation(afs_vnode_cache(vnode), &rreq->cache_resources,
+				       FSCACHE_WANT_PARAMS);
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
index e7ec2f4acc4d..1f7caa560c5c 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -207,6 +207,7 @@ struct afs_read {
 	loff_t			file_size;	/* File size returned by server */
 	struct key		*key;		/* The key to use to reissue the read */
 	struct afs_vnode	*vnode;		/* The file being read into. */
+	struct netfs_read_subrequest *subreq;	/* Fscache helper read request this belongs to */
 	afs_dataversion_t	data_version;	/* Version number returned by server */
 	refcount_t		usage;
 	unsigned int		call_debug_id;
@@ -1041,6 +1042,7 @@ extern void afs_put_wb_key(struct afs_wb_key *);
 extern int afs_open(struct inode *, struct file *);
 extern int afs_release(struct inode *, struct file *);
 extern int afs_fetch_data(struct afs_vnode *, struct afs_read *);
+extern struct afs_read *afs_alloc_read(gfp_t);
 extern void afs_put_read(struct afs_read *);
 
 static inline struct afs_read *afs_get_read(struct afs_read *req)
diff --git a/fs/afs/super.c b/fs/afs/super.c
index 6c5900df6aa5..d745e228961a 100644
--- a/fs/afs/super.c
+++ b/fs/afs/super.c
@@ -40,6 +40,12 @@ static int afs_show_options(struct seq_file *m, struct dentry *root);
 static int afs_init_fs_context(struct fs_context *fc);
 static const struct fs_parameter_spec afs_fs_parameters[];
 
+#ifdef CONFIG_AFS_FSCACHE
+static void afs_put_super (struct super_block *sb);
+#else
+#define afs_put_super NULL
+#endif
+
 struct file_system_type afs_fs_type = {
 	.owner			= THIS_MODULE,
 	.name			= "afs",
@@ -61,6 +67,7 @@ static const struct super_operations afs_super_ops = {
 	.evict_inode	= afs_evict_inode,
 	.show_devname	= afs_show_devname,
 	.show_options	= afs_show_options,
+	.put_super	= afs_put_super,
 };
 
 static struct kmem_cache *afs_inode_cachep;
@@ -546,6 +553,23 @@ static void afs_kill_super(struct super_block *sb)
 	afs_destroy_sbi(as);
 }
 
+#ifdef CONFIG_AFS_FSCACHE
+static struct fscache_cookie *afs_put_super_get_cookie(struct inode *inode)
+{
+	return afs_vnode_cache(AFS_FS_I(inode));
+}
+
+static void afs_put_super(struct super_block *sb)
+{
+	struct afs_super_info *as = AFS_FS_S(sb);
+
+	if (as &&
+	    as->volume &&
+	    as->volume->cache)
+		fscache_put_super(sb, afs_put_super_get_cookie);
+}
+#endif
+
 /*
  * Get an AFS superblock and root directory.
  */


