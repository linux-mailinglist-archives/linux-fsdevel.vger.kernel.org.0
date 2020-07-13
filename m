Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5532621DD70
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jul 2020 18:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730629AbgGMQii (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jul 2020 12:38:38 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:43214 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730043AbgGMQih (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jul 2020 12:38:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594658314;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aqsuThQyrz5PWdn5FrEmtBoz4GkNq4lYhgOSsa46qsI=;
        b=MEGsB7R5JZoQhezmIKYqDGTNllKziMeKg08fWUGMuf5w9bx9cEpi5Fu/nXs7lup1KgRCQM
        qOsoHRwi5Tm0yY413hU3bduJDf7PZhHXSBgTc7CSe3aJ7Igx0Mc9PJCV0Re0cHKLdeU8V4
        T6U1fPox41xz3Y+uSGg7A4JbeT+4iKo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-74-odU2Z691OkOWWnnbTqZgyw-1; Mon, 13 Jul 2020 12:38:29 -0400
X-MC-Unique: odU2Z691OkOWWnnbTqZgyw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AB46280183C;
        Mon, 13 Jul 2020 16:38:27 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-113.rdu2.redhat.com [10.10.112.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 637785BAD5;
        Mon, 13 Jul 2020 16:38:18 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 07/13] afs: Interpose struct fscache_io_request into struct
 afs_read
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
Date:   Mon, 13 Jul 2020 17:38:17 +0100
Message-ID: <159465829760.1377938.2449766049160139188.stgit@warthog.procyon.org.uk>
In-Reply-To: <159465821598.1377938.2046362270225008168.stgit@warthog.procyon.org.uk>
References: <159465821598.1377938.2046362270225008168.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.22
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Embed an fscache_io_request struct into struct afs_read and remove some of
the redundant members from the latter.

Change all references to those removed members to use the fscache ones
instead.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/dir.c       |   38 ++++++++++++++++++++++++--------------
 fs/afs/file.c      |   48 +++++++++++++++++++++++++-----------------------
 fs/afs/fsclient.c  |   28 ++++++++++++++--------------
 fs/afs/internal.h  |   12 ++++--------
 fs/afs/write.c     |   18 ++++++++++--------
 fs/afs/yfsclient.c |   18 +++++++++---------
 6 files changed, 86 insertions(+), 76 deletions(-)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 56991bb01f62..9d47df15c790 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -108,13 +108,14 @@ struct afs_lookup_cookie {
  */
 static void afs_dir_read_cleanup(struct afs_read *req)
 {
-	struct address_space *mapping = req->iter->mapping;
+	struct afs_vnode *vnode = req->vnode;
+	struct address_space *mapping = vnode->vfs_inode.i_mapping;
 	struct page *page;
-	pgoff_t last = req->nr_pages - 1;
+	pgoff_t last = req->cache.nr_pages - 1;
 
 	XA_STATE(xas, &mapping->i_pages, 0);
 
-	if (unlikely(!req->nr_pages))
+	if (unlikely(!req->cache.nr_pages))
 		return;
 
 	rcu_read_lock();
@@ -131,6 +132,13 @@ static void afs_dir_read_cleanup(struct afs_read *req)
 	rcu_read_unlock();
 }
 
+/*
+ * Do nothing upon completion of the request.
+ */
+static void afs_dir_read_done(struct fscache_io_request *fsreq)
+{
+}
+
 /*
  * check that a directory page is valid
  */
@@ -194,15 +202,15 @@ static void afs_dir_dump(struct afs_vnode *dvnode, struct afs_read *req)
 	struct address_space *mapping = dvnode->vfs_inode.i_mapping;
 	struct page *page;
 	unsigned int i, qty = PAGE_SIZE / sizeof(union afs_xdr_dir_block);
-	pgoff_t last = req->nr_pages - 1;
+	pgoff_t last = req->cache.nr_pages - 1;
 
 	XA_STATE(xas, &mapping->i_pages, 0);
 
 	pr_warn("DIR %llx:%llx f=%llx l=%llx al=%llx\n",
 		dvnode->fid.vid, dvnode->fid.vnode,
-		req->file_size, req->len, req->actual_len);
+		req->file_size, req->cache.len, req->actual_len);
 	pr_warn("DIR %llx %x %zx %zx\n",
-		req->pos, req->nr_pages,
+		req->cache.pos, req->cache.nr_pages,
 		req->iter->iov_offset,  iov_iter_count(req->iter));
 
 	xas_for_each(&xas, page, last) {
@@ -229,12 +237,12 @@ static int afs_dir_check(struct afs_vnode *dvnode, struct afs_read *req)
 {
 	struct address_space *mapping = dvnode->vfs_inode.i_mapping;
 	struct page *page;
-	pgoff_t last = req->nr_pages - 1;
+	pgoff_t last = req->cache.nr_pages - 1;
 	int ret = 0;
 
 	XA_STATE(xas, &mapping->i_pages, 0);
 
-	if (unlikely(!req->nr_pages))
+	if (unlikely(!req->cache.nr_pages))
 		return 0;
 
 	rcu_read_lock();
@@ -293,7 +301,9 @@ static struct afs_read *afs_read_dir(struct afs_vnode *dvnode, struct key *key)
 
 	refcount_set(&req->usage, 1);
 	req->key = key_get(key);
+	req->vnode = dvnode;
 	req->cleanup = afs_dir_read_cleanup;
+	req->cache.io_done = afs_dir_read_done;
 
 expand:
 	i_size = i_size_read(&dvnode->vfs_inode);
@@ -312,7 +322,7 @@ static struct afs_read *afs_read_dir(struct afs_vnode *dvnode, struct key *key)
 	nr_pages = (i_size + PAGE_SIZE - 1) / PAGE_SIZE;
 
 	req->actual_len = i_size; /* May change */
-	req->len = nr_pages * PAGE_SIZE; /* We can ask for more than there is */
+	req->cache.len = nr_pages * PAGE_SIZE; /* We can ask for more than there is */
 	req->data_version = dvnode->status.data_version; /* May change */
 	iov_iter_mapping(&req->def_iter, READ, dvnode->vfs_inode.i_mapping,
 			 0, i_size);
@@ -322,7 +332,7 @@ static struct afs_read *afs_read_dir(struct afs_vnode *dvnode, struct key *key)
 	 * been at work and pin all the pages.  If there are any gaps, we will
 	 * need to reread the entire directory contents.
 	 */
-	i = req->nr_pages;
+	i = req->cache.nr_pages;
 	while (i < nr_pages) {
 		struct page *pages[8], *page;
 
@@ -351,10 +361,10 @@ static struct afs_read *afs_read_dir(struct afs_vnode *dvnode, struct key *key)
 			set_page_private(page, 1);
 			SetPagePrivate(page);
 			unlock_page(page);
-			req->nr_pages++;
+			req->cache.nr_pages++;
 			i++;
 		} else {
-			req->nr_pages += n;
+			req->cache.nr_pages += n;
 			i += n;
 		}
 	}
@@ -379,9 +389,9 @@ static struct afs_read *afs_read_dir(struct afs_vnode *dvnode, struct key *key)
 		if (ret < 0)
 			goto error_unlock;
 
-		task_io_account_read(PAGE_SIZE * req->nr_pages);
+		task_io_account_read(PAGE_SIZE * req->cache.nr_pages);
 
-		if (req->len < req->file_size) {
+		if (req->cache.len < req->file_size) {
 			/* The content has grown, so we need to expand the
 			 * buffer.
 			 */
diff --git a/fs/afs/file.c b/fs/afs/file.c
index 4a429b3a5f2f..8baafe655433 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -199,12 +199,13 @@ int afs_release(struct inode *inode, struct file *file)
 /*
  * Handle completion of a read operation.
  */
-static void afs_file_read_done(struct afs_read *req)
+static void afs_file_read_done(struct fscache_io_request *fsreq)
 {
+	struct afs_read *req = container_of(fsreq, struct afs_read, cache);
 	struct afs_vnode *vnode = req->vnode;
 	struct page *page;
-	pgoff_t index = req->pos >> PAGE_SHIFT;
-	pgoff_t last = index + req->nr_pages - 1;
+	pgoff_t index = req->cache.pos >> PAGE_SHIFT;
+	pgoff_t last = index + req->cache.nr_pages - 1;
 
 	XA_STATE(xas, &vnode->vfs_inode.i_mapping->i_pages, index);
 
@@ -213,7 +214,7 @@ static void afs_file_read_done(struct afs_read *req)
 		_debug("afterclear %zx %zx %llx/%llx",
 		       req->iter->iov_offset,
 		       iov_iter_count(req->iter),
-		       req->actual_len, req->len);
+		       req->actual_len, req->cache.len);
 		iov_iter_zero(iov_iter_count(req->iter), req->iter);
 	}
 
@@ -224,7 +225,7 @@ static void afs_file_read_done(struct afs_read *req)
 	}
 	rcu_read_unlock();
 
-	task_io_account_read(req->len);
+	task_io_account_read(req->cache.len);
 	req->cleanup = NULL;
 }
 
@@ -234,20 +235,21 @@ static void afs_file_read_done(struct afs_read *req)
 static void afs_file_read_cleanup(struct afs_read *req)
 {
 	struct page *page;
-	pgoff_t index = req->pos >> PAGE_SHIFT;
-	pgoff_t last = index + req->nr_pages - 1;
+	pgoff_t index = req->cache.pos >> PAGE_SHIFT;
+	pgoff_t last = index + req->cache.nr_pages - 1;
 
 	if (req->iter) {
 		XA_STATE(xas, &req->iter->mapping->i_pages, index);
 
-		_enter("%lu,%u,%zu", index, req->nr_pages, iov_iter_count(req->iter));
+		_enter("%lu,%u,%zu",
+		       index, req->cache.nr_pages, iov_iter_count(req->iter));
 
 		rcu_read_lock();
 		xas_for_each(&xas, page, last) {
 			BUG_ON(xa_is_value(page));
 			BUG_ON(PageCompound(page));
 
-			page_endio(page, false, req->error);
+			page_endio(page, false, req->cache.error);
 			put_page(page);
 		}
 		rcu_read_unlock();
@@ -279,7 +281,7 @@ static void afs_fetch_data_success(struct afs_operation *op)
 
 static void afs_fetch_data_put(struct afs_operation *op)
 {
-	op->fetch.req->error = op->error;
+	op->fetch.req->cache.error = op->error;
 	afs_put_read(op->fetch.req);
 }
 
@@ -341,15 +343,15 @@ static int afs_page_filler(struct key *key, struct page *page)
 	refcount_set(&req->usage, 1);
 	req->vnode		= vnode;
 	req->key		= key_get(key);
-	req->pos		= (loff_t)page->index << PAGE_SHIFT;
-	req->len		= PAGE_SIZE;
-	req->nr_pages		= 1;
-	req->done		= afs_file_read_done;
+	req->cache.nr_pages	= 1;
+	req->cache.pos		= (loff_t)page->index << PAGE_SHIFT;
+	req->cache.len		= PAGE_SIZE;
+	req->cache.io_done	= afs_file_read_done;
 	req->cleanup		= afs_file_read_cleanup;
 
 	get_page(page);
 	iov_iter_mapping(&req->def_iter, READ, page->mapping,
-			 req->pos, req->len);
+			 req->cache.pos, req->cache.len);
 	req->iter = &req->def_iter;
 
 	ret = afs_fetch_data(vnode, req);
@@ -448,10 +450,10 @@ static int afs_readpages_one(struct file *file, struct address_space *mapping,
 	refcount_set(&req->usage, 1);
 	req->vnode = vnode;
 	req->key = key_get(afs_file_key(file));
-	req->done = afs_file_read_done;
 	req->cleanup = afs_file_read_cleanup;
-	req->pos = first->index;
-	req->pos <<= PAGE_SHIFT;
+	req->cache.io_done = afs_file_read_done;
+	req->cache.pos = first->index;
+	req->cache.pos <<= PAGE_SHIFT;
 
 	/* Add pages to the LRU until it fails.  We keep the pages ref'd and
 	 * locked until the read is complete.
@@ -471,17 +473,17 @@ static int afs_readpages_one(struct file *file, struct address_space *mapping,
 			break;
 		}
 
-		req->nr_pages++;
-	} while (req->nr_pages < n);
+		req->cache.nr_pages++;
+	} while (req->cache.nr_pages < n);
 
-	if (req->nr_pages == 0) {
+	if (req->cache.nr_pages == 0) {
 		afs_put_read(req);
 		return 0;
 	}
 
-	req->len = req->nr_pages * PAGE_SIZE;
+	req->cache.len = req->cache.nr_pages * PAGE_SIZE;
 	iov_iter_mapping(&req->def_iter, READ, file->f_mapping,
-			 req->pos, req->len);
+			 req->cache.pos, req->cache.len);
 	req->iter = &req->def_iter;
 
 	ret = afs_fetch_data(vnode, req);
diff --git a/fs/afs/fsclient.c b/fs/afs/fsclient.c
index c0c91079e76b..d6a8066e666d 100644
--- a/fs/afs/fsclient.c
+++ b/fs/afs/fsclient.c
@@ -339,7 +339,7 @@ static int afs_deliver_fs_fetch_data(struct afs_call *call)
 
 		call->unmarshall++;
 		call->iter = req->iter;
-		call->iov_len = min(req->actual_len, req->len);
+		call->iov_len = min(req->actual_len, req->cache.len);
 		/* Fall through */
 
 		/* extract the returned data */
@@ -352,17 +352,17 @@ static int afs_deliver_fs_fetch_data(struct afs_call *call)
 			return ret;
 
 		call->iter = &call->def_iter;
-		if (req->actual_len <= req->len)
+		if (req->actual_len <= req->cache.len)
 			goto no_more_data;
 
 		/* Discard any excess data the server gave us */
-		afs_extract_discard(call, req->actual_len - req->len);
+		afs_extract_discard(call, req->actual_len - req->cache.len);
 		call->unmarshall = 3;
 		/* Fall through */
 
 	case 3:
 		_debug("extract discard %zu/%llu",
-		       iov_iter_count(call->iter), req->actual_len - req->len);
+		       iov_iter_count(call->iter), req->actual_len - req->cache.len);
 
 		ret = afs_extract_data(call, true);
 		if (ret < 0)
@@ -393,8 +393,8 @@ static int afs_deliver_fs_fetch_data(struct afs_call *call)
 		break;
 	}
 
-	if (req->done)
-		req->done(req);
+	if (req->cache.io_done)
+		req->cache.io_done(&req->cache);
 
 	_leave(" = 0 [done]");
 	return 0;
@@ -439,10 +439,10 @@ static void afs_fs_fetch_data64(struct afs_operation *op)
 	bp[1] = htonl(vp->fid.vid);
 	bp[2] = htonl(vp->fid.vnode);
 	bp[3] = htonl(vp->fid.unique);
-	bp[4] = htonl(upper_32_bits(req->pos));
-	bp[5] = htonl(lower_32_bits(req->pos));
+	bp[4] = htonl(upper_32_bits(req->cache.pos));
+	bp[5] = htonl(lower_32_bits(req->cache.pos));
 	bp[6] = 0;
-	bp[7] = htonl(lower_32_bits(req->len));
+	bp[7] = htonl(lower_32_bits(req->cache.len));
 
 	trace_afs_make_fs_call(call, &vp->fid);
 	afs_make_op_call(op, call, GFP_NOFS);
@@ -458,9 +458,9 @@ void afs_fs_fetch_data(struct afs_operation *op)
 	struct afs_read *req = op->fetch.req;
 	__be32 *bp;
 
-	if (upper_32_bits(req->pos) ||
-	    upper_32_bits(req->len) ||
-	    upper_32_bits(req->pos + req->len))
+	if (upper_32_bits(req->cache.pos) ||
+	    upper_32_bits(req->cache.len) ||
+	    upper_32_bits(req->cache.pos + req->cache.len))
 		return afs_fs_fetch_data64(op);
 
 	_enter("");
@@ -477,8 +477,8 @@ void afs_fs_fetch_data(struct afs_operation *op)
 	bp[1] = htonl(vp->fid.vid);
 	bp[2] = htonl(vp->fid.vnode);
 	bp[3] = htonl(vp->fid.unique);
-	bp[4] = htonl(lower_32_bits(req->pos));
-	bp[5] = htonl(lower_32_bits(req->len));
+	bp[4] = htonl(lower_32_bits(req->cache.pos));
+	bp[5] = htonl(lower_32_bits(req->cache.len));
 
 	trace_afs_make_fs_call(call, &vp->fid);
 	afs_make_op_call(op, call, GFP_NOFS);
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 3d0aa1e46539..d55ea1904a27 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -201,8 +201,9 @@ static inline struct key *afs_file_key(struct file *file)
  * Record of an outstanding read operation on a vnode.
  */
 struct afs_read {
-	loff_t			pos;		/* Where to start reading */
-	loff_t			len;		/* How much we're asking for */
+	struct fscache_io_request cache;
+	struct iov_iter		def_iter;	/* Default iterator */
+	struct iov_iter		*iter;		/* Iterator to use */
 	loff_t			actual_len;	/* How much we're actually getting */
 	loff_t			file_size;	/* File size returned by server */
 	struct key		*key;		/* The key to use to reissue the read */
@@ -210,12 +211,7 @@ struct afs_read {
 	afs_dataversion_t	data_version;	/* Version number returned by server */
 	refcount_t		usage;
 	unsigned int		call_debug_id;
-	unsigned int		nr_pages;
-	int			error;
-	void (*done)(struct afs_read *);
-	void (*cleanup)(struct afs_read *);
-	struct iov_iter		*iter;		/* Iterator representing the buffer */
-	struct iov_iter		def_iter;	/* Default iterator */
+	void (*cleanup)(struct afs_read *req);
 };
 
 /*
diff --git a/fs/afs/write.c b/fs/afs/write.c
index 37c968b9c89b..d9de0dc877ca 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -25,8 +25,10 @@ int afs_set_page_dirty(struct page *page)
 /*
  * Handle completion of a read operation to fill a page.
  */
-static void afs_fill_hole(struct afs_read *req)
+static void afs_fill_hole(struct fscache_io_request *fsreq)
 {
+	struct afs_read *req = container_of(fsreq, struct afs_read, cache);
+
 	if (iov_iter_count(req->iter) > 0)
 		/* The read was short - clear the excess buffer. */
 		iov_iter_zero(iov_iter_count(req->iter), req->iter);
@@ -60,13 +62,13 @@ static int afs_fill_page(struct file *file,
 		return -ENOMEM;
 
 	refcount_set(&req->usage, 1);
-	req->vnode	= vnode;
-	req->done	= afs_fill_hole;
-	req->key	= afs_file_key(file);
-	req->pos	= pos;
-	req->len	= len;
-	req->nr_pages	= 1;
-	req->iter	= &req->def_iter;
+	req->vnode		= vnode;
+	req->key		= afs_file_key(file);
+	req->cache.io_done	= afs_fill_hole;
+	req->cache.pos		= pos;
+	req->cache.len		= len;
+	req->cache.nr_pages	= 1;
+	req->iter		= &req->def_iter;
 	iov_iter_mapping(&req->def_iter, READ, vnode->vfs_inode.i_mapping,
 			 pos, len);
 
diff --git a/fs/afs/yfsclient.c b/fs/afs/yfsclient.c
index ac3541773e7c..30621f4fffc0 100644
--- a/fs/afs/yfsclient.c
+++ b/fs/afs/yfsclient.c
@@ -392,7 +392,7 @@ static int yfs_deliver_fs_fetch_data64(struct afs_call *call)
 
 		call->unmarshall++;
 		call->iter = req->iter;
-		call->iov_len = min(req->actual_len, req->len);
+		call->iov_len = min(req->actual_len, req->cache.len);
 		/* Fall through */
 
 		/* extract the returned data */
@@ -405,17 +405,17 @@ static int yfs_deliver_fs_fetch_data64(struct afs_call *call)
 			return ret;
 
 		call->iter = &call->def_iter;
-		if (req->actual_len <= req->len)
+		if (req->actual_len <= req->cache.len)
 			goto no_more_data;
 
 		/* Discard any excess data the server gave us */
-		afs_extract_discard(call, req->actual_len - req->len);
+		afs_extract_discard(call, req->actual_len - req->cache.len);
 		call->unmarshall = 3;
 		/* Fall through */
 
 	case 3:
 		_debug("extract discard %zu/%llu",
-		       iov_iter_count(call->iter), req->actual_len - req->len);
+		       iov_iter_count(call->iter), req->actual_len - req->cache.len);
 
 		ret = afs_extract_data(call, true);
 		if (ret < 0)
@@ -450,8 +450,8 @@ static int yfs_deliver_fs_fetch_data64(struct afs_call *call)
 		break;
 	}
 
-	if (req->done)
-		req->done(req);
+	if (req->cache.io_done)
+		req->cache.io_done(&req->cache);
 
 	_leave(" = 0 [done]");
 	return 0;
@@ -479,7 +479,7 @@ void yfs_fs_fetch_data(struct afs_operation *op)
 
 	_enter(",%x,{%llx:%llu},%llx,%llx",
 	       key_serial(op->key), vp->fid.vid, vp->fid.vnode,
-	       req->pos, req->len);
+	       req->cache.pos, req->cache.len);
 
 	call = afs_alloc_flat_call(op->net, &yfs_RXYFSFetchData64,
 				   sizeof(__be32) * 2 +
@@ -498,8 +498,8 @@ void yfs_fs_fetch_data(struct afs_operation *op)
 	bp = xdr_encode_u32(bp, YFSFETCHDATA64);
 	bp = xdr_encode_u32(bp, 0); /* RPC flags */
 	bp = xdr_encode_YFSFid(bp, &vp->fid);
-	bp = xdr_encode_u64(bp, req->pos);
-	bp = xdr_encode_u64(bp, req->len);
+	bp = xdr_encode_u64(bp, req->cache.pos);
+	bp = xdr_encode_u64(bp, req->cache.len);
 	yfs_check_req(call, bp);
 
 	trace_afs_make_fs_call(call, &vp->fid);


