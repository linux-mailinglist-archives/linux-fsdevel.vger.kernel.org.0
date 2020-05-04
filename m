Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 038B11C4204
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 May 2020 19:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730680AbgEDRPf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 May 2020 13:15:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30427 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730648AbgEDRPd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 May 2020 13:15:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588612529;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6ZnZnov/Riivl+zMuS+ZECQK5k3VFN8rTYwmpLrFg/g=;
        b=UdkAcqrFybu1qy5NxmqS/7RTb7UjO6DCwV7RmqnOr0+IHZUqFFncfv4ISHFr6lviBdGFJo
        4xP8QxnRSvwweG0qlPM7Yszc0vdIElnP6nFkvH31+npukIuLaNS9AvzAZ6xiI2zD46disM
        YCXn6Sy+AcqHiJQbfDriDnA8J5yQbCo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-234-wctWySXZN4G5wYW4qjVlow-1; Mon, 04 May 2020 13:15:27 -0400
X-MC-Unique: wctWySXZN4G5wYW4qjVlow-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DE2CD800D24;
        Mon,  4 May 2020 17:15:25 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-225.rdu2.redhat.com [10.10.118.225])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0D0E1620AB;
        Mon,  4 May 2020 17:15:22 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 52/61] afs: Interpose struct fscache_io_request into
 struct afs_read
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
Date:   Mon, 04 May 2020 18:15:22 +0100
Message-ID: <158861252215.340223.14192454410930829360.stgit@warthog.procyon.org.uk>
In-Reply-To: <158861203563.340223.7585359869938129395.stgit@warthog.procyon.org.uk>
References: <158861203563.340223.7585359869938129395.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.21
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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
 fs/afs/file.c      |   47 ++++++++++++++++++++++++-----------------------
 fs/afs/fsclient.c  |   28 ++++++++++++++--------------
 fs/afs/internal.h  |   12 ++++--------
 fs/afs/write.c     |    6 +++---
 fs/afs/yfsclient.c |   18 +++++++++---------
 6 files changed, 78 insertions(+), 71 deletions(-)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index a10bcf632e0c..0b3f33269fdd 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -110,13 +110,14 @@ struct afs_lookup_cookie {
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
@@ -133,6 +134,13 @@ static void afs_dir_read_cleanup(struct afs_read *req)
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
@@ -196,15 +204,15 @@ static void afs_dir_dump(struct afs_vnode *dvnode, struct afs_read *req)
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
@@ -231,12 +239,12 @@ static int afs_dir_check(struct afs_vnode *dvnode, struct afs_read *req)
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
@@ -295,7 +303,9 @@ static struct afs_read *afs_read_dir(struct afs_vnode *dvnode, struct key *key)
 
 	refcount_set(&req->usage, 1);
 	req->key = key_get(key);
+	req->vnode = dvnode;
 	req->cleanup = afs_dir_read_cleanup;
+	req->cache.io_done = afs_dir_read_done;
 
 expand:
 	i_size = i_size_read(&dvnode->vfs_inode);
@@ -314,7 +324,7 @@ static struct afs_read *afs_read_dir(struct afs_vnode *dvnode, struct key *key)
 	nr_pages = (i_size + PAGE_SIZE - 1) / PAGE_SIZE;
 
 	req->actual_len = i_size; /* May change */
-	req->len = nr_pages * PAGE_SIZE; /* We can ask for more than there is */
+	req->cache.len = nr_pages * PAGE_SIZE; /* We can ask for more than there is */
 	req->data_version = dvnode->status.data_version; /* May change */
 	iov_iter_mapping(&req->def_iter, READ, dvnode->vfs_inode.i_mapping,
 			 0, i_size);
@@ -324,7 +334,7 @@ static struct afs_read *afs_read_dir(struct afs_vnode *dvnode, struct key *key)
 	 * been at work and pin all the pages.  If there are any gaps, we will
 	 * need to reread the entire directory contents.
 	 */
-	i = req->nr_pages;
+	i = req->cache.nr_pages;
 	while (i < nr_pages) {
 		struct page *pages[8], *page;
 
@@ -353,10 +363,10 @@ static struct afs_read *afs_read_dir(struct afs_vnode *dvnode, struct key *key)
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
@@ -381,9 +391,9 @@ static struct afs_read *afs_read_dir(struct afs_vnode *dvnode, struct key *key)
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
index c8ad638590e7..ea9f6d45d9ff 100644
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
 
@@ -234,19 +235,19 @@ static void afs_file_read_done(struct afs_read *req)
 static void afs_file_read_cleanup(struct afs_read *req)
 {
 	struct page *page;
-	pgoff_t index = req->pos >> PAGE_SHIFT;
-	pgoff_t last = index + req->nr_pages - 1;
+	pgoff_t index = req->cache.pos >> PAGE_SHIFT;
+	pgoff_t last = index + req->cache.nr_pages - 1;
 
 	XA_STATE(xas, &req->iter->mapping->i_pages, index);
 
-	_enter("%lu,%u,%zu", index, req->nr_pages, iov_iter_count(req->iter));
+	_enter("%lu,%u,%zu", index, req->cache.nr_pages, iov_iter_count(req->iter));
 
 	rcu_read_lock();
 	xas_for_each(&xas, page, last) {
 		BUG_ON(xa_is_value(page));
 		BUG_ON(PageCompound(page));
 
-		page_endio(page, false, req->error);
+		page_endio(page, false, req->cache.error);
 		put_page(page);
 	}
 	rcu_read_unlock();
@@ -300,7 +301,7 @@ int afs_fetch_data(struct afs_vnode *vnode, struct afs_read *req)
 		ret = afs_end_vnode_operation(&fc);
 	}
 
-	req->error = ret;
+	req->cache.error = ret;
 	if (ret == 0) {
 		afs_stat_v(vnode, n_fetches);
 		atomic_long_add(req->actual_len,
@@ -337,15 +338,15 @@ static int afs_page_filler(struct key *key, struct page *page)
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
@@ -444,10 +445,10 @@ static int afs_readpages_one(struct file *file, struct address_space *mapping,
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
@@ -467,17 +468,17 @@ static int afs_readpages_one(struct file *file, struct address_space *mapping,
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
index db80c2618778..c9789294fc68 100644
--- a/fs/afs/fsclient.c
+++ b/fs/afs/fsclient.c
@@ -361,7 +361,7 @@ static int afs_deliver_fs_fetch_data(struct afs_call *call)
 
 		call->unmarshall++;
 		call->iter = req->iter;
-		call->iov_len = min(req->actual_len, req->len);
+		call->iov_len = min(req->actual_len, req->cache.len);
 		/* Fall through */
 
 		/* extract the returned data */
@@ -374,17 +374,17 @@ static int afs_deliver_fs_fetch_data(struct afs_call *call)
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
@@ -417,8 +417,8 @@ static int afs_deliver_fs_fetch_data(struct afs_call *call)
 		break;
 	}
 
-	if (req->done)
-		req->done(req);
+	if (req->cache.io_done)
+		req->cache.io_done(&req->cache);
 
 	_leave(" = 0 [done]");
 	return 0;
@@ -478,10 +478,10 @@ static int afs_fs_fetch_data64(struct afs_fs_cursor *fc,
 	bp[1] = htonl(vnode->fid.vid);
 	bp[2] = htonl(vnode->fid.vnode);
 	bp[3] = htonl(vnode->fid.unique);
-	bp[4] = htonl(upper_32_bits(req->pos));
-	bp[5] = htonl(lower_32_bits(req->pos));
+	bp[4] = htonl(upper_32_bits(req->cache.pos));
+	bp[5] = htonl(lower_32_bits(req->cache.pos));
 	bp[6] = 0;
-	bp[7] = htonl(lower_32_bits(req->len));
+	bp[7] = htonl(lower_32_bits(req->cache.len));
 
 	afs_use_fs_server(call, fc->cbi);
 	trace_afs_make_fs_call(call, &vnode->fid);
@@ -505,9 +505,9 @@ int afs_fs_fetch_data(struct afs_fs_cursor *fc,
 	if (test_bit(AFS_SERVER_FL_IS_YFS, &fc->cbi->server->flags))
 		return yfs_fs_fetch_data(fc, scb, req);
 
-	if (upper_32_bits(req->pos) ||
-	    upper_32_bits(req->len) ||
-	    upper_32_bits(req->pos + req->len))
+	if (upper_32_bits(req->cache.pos) ||
+	    upper_32_bits(req->cache.len) ||
+	    upper_32_bits(req->cache.pos + req->cache.len))
 		return afs_fs_fetch_data64(fc, scb, req);
 
 	_enter("");
@@ -528,8 +528,8 @@ int afs_fs_fetch_data(struct afs_fs_cursor *fc,
 	bp[1] = htonl(vnode->fid.vid);
 	bp[2] = htonl(vnode->fid.vnode);
 	bp[3] = htonl(vnode->fid.unique);
-	bp[4] = htonl(lower_32_bits(req->pos));
-	bp[5] = htonl(lower_32_bits(req->len));
+	bp[4] = htonl(lower_32_bits(req->cache.pos));
+	bp[5] = htonl(lower_32_bits(req->cache.len));
 
 	afs_use_fs_server(call, fc->cbi);
 	trace_afs_make_fs_call(call, &vnode->fid);
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 0cd9e998d52c..9f56acdc2ed9 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -218,8 +218,9 @@ static inline struct key *afs_file_key(struct file *file)
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
@@ -227,12 +228,7 @@ struct afs_read {
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
index 44dd4d0bad70..390fee44446c 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -51,9 +51,9 @@ static int afs_fill_page(struct file *file,
 
 	refcount_set(&req->usage, 1);
 	req->key = afs_file_key(file);
-	req->pos = pos;
-	req->len = len;
-	req->nr_pages = 1;
+	req->cache.pos = pos;
+	req->cache.len = len;
+	req->cache.nr_pages = 1;
 	iov_iter_mapping(&req->def_iter, READ, vnode->vfs_inode.i_mapping,
 			 pos, len);
 	req->iter = &req->def_iter;
diff --git a/fs/afs/yfsclient.c b/fs/afs/yfsclient.c
index 0b744a117dde..6ea97233c0d2 100644
--- a/fs/afs/yfsclient.c
+++ b/fs/afs/yfsclient.c
@@ -471,7 +471,7 @@ static int yfs_deliver_fs_fetch_data64(struct afs_call *call)
 
 		call->unmarshall++;
 		call->iter = req->iter;
-		call->iov_len = min(req->actual_len, req->len);
+		call->iov_len = min(req->actual_len, req->cache.len);
 		/* Fall through */
 
 		/* extract the returned data */
@@ -484,17 +484,17 @@ static int yfs_deliver_fs_fetch_data64(struct afs_call *call)
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
@@ -531,8 +531,8 @@ static int yfs_deliver_fs_fetch_data64(struct afs_call *call)
 		break;
 	}
 
-	if (req->done)
-		req->done(req);
+	if (req->cache.io_done)
+		req->cache.io_done(&req->cache);
 
 	_leave(" = 0 [done]");
 	return 0;
@@ -567,7 +567,7 @@ int yfs_fs_fetch_data(struct afs_fs_cursor *fc, struct afs_status_cb *scb,
 
 	_enter(",%x,{%llx:%llu},%llx,%llx",
 	       key_serial(fc->key), vnode->fid.vid, vnode->fid.vnode,
-	       req->pos, req->len);
+	       req->cache.pos, req->cache.len);
 
 	call = afs_alloc_flat_call(net, &yfs_RXYFSFetchData64,
 				   sizeof(__be32) * 2 +
@@ -589,8 +589,8 @@ int yfs_fs_fetch_data(struct afs_fs_cursor *fc, struct afs_status_cb *scb,
 	bp = xdr_encode_u32(bp, YFSFETCHDATA64);
 	bp = xdr_encode_u32(bp, 0); /* RPC flags */
 	bp = xdr_encode_YFSFid(bp, &vnode->fid);
-	bp = xdr_encode_u64(bp, req->pos);
-	bp = xdr_encode_u64(bp, req->len);
+	bp = xdr_encode_u64(bp, req->cache.pos);
+	bp = xdr_encode_u64(bp, req->cache.len);
 	yfs_check_req(call, bp);
 
 	afs_use_fs_server(call, fc->cbi);


