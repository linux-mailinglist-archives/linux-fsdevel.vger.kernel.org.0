Return-Path: <linux-fsdevel+bounces-5950-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D74CE811772
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 16:39:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD50C2859BB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 15:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D11285353;
	Wed, 13 Dec 2023 15:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BE50Crc/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7767FD47
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Dec 2023 07:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702481220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WXofuzcjAytVfATApIF5KG+Rehuwn0Pqcyfgmz8Uu6Q=;
	b=BE50Crc/uQwRP6FfWdA+40J235hMspU/iyVgcPWRi8b+uk0x7WF5MaeNYGWUDavDzgtihT
	vPUxbiMyv6ud/RkTo4XR+QJo8EB2fsWTgyFovJdVvrDaELxRtwJfxYcR9a3IsE2dYdHtG7
	GtCxk+si/PGTFjS+JiQcdFaRAmopH1U=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-228-8_MjFYBWMP6LtGm0-uBNEQ-1; Wed, 13 Dec 2023 10:26:54 -0500
X-MC-Unique: 8_MjFYBWMP6LtGm0-uBNEQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BE62A185A78E;
	Wed, 13 Dec 2023 15:26:52 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.2])
	by smtp.corp.redhat.com (Postfix) with ESMTP id F1FA351E3;
	Wed, 13 Dec 2023 15:26:48 +0000 (UTC)
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
	linux-kernel@vger.kernel.org,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>
Subject: [PATCH v4 39/39] 9p: Use netfslib read/write_iter
Date: Wed, 13 Dec 2023 15:23:49 +0000
Message-ID: <20231213152350.431591-40-dhowells@redhat.com>
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

Use netfslib's read and write iteration helpers, allowing netfslib to take
over the management of the page cache for 9p files and to manage local disk
caching.  In particular, this eliminates write_begin, write_end, writepage
and all mentions of struct page and struct folio from 9p.

Note that netfslib now offers the possibility of write-through caching if
that is desirable for 9p: just set the NETFS_ICTX_WRITETHROUGH flag in
v9inode->netfs.flags in v9fs_set_netfs_context().

Note also this is untested as I can't get ganesha.nfsd to correctly parse
the config to turn on 9p support.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Eric Van Hensbergen <ericvh@kernel.org>
cc: Latchesar Ionkov <lucho@ionkov.net>
cc: Dominique Martinet <asmadeus@codewreck.org>
cc: Christian Schoenebeck <linux_oss@crudebyte.com>
cc: v9fs@lists.linux.dev
cc: linux-cachefs@redhat.com
cc: linux-fsdevel@vger.kernel.org
---
 fs/9p/vfs_addr.c  | 292 +++++++++++-----------------------------------
 fs/9p/vfs_file.c  |  89 ++------------
 fs/9p/vfs_inode.c |   2 -
 3 files changed, 77 insertions(+), 306 deletions(-)

diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
index 055b672a247d..0c7bcff05da2 100644
--- a/fs/9p/vfs_addr.c
+++ b/fs/9p/vfs_addr.c
@@ -19,12 +19,48 @@
 #include <linux/netfs.h>
 #include <net/9p/9p.h>
 #include <net/9p/client.h>
+#include <trace/events/netfs.h>
 
 #include "v9fs.h"
 #include "v9fs_vfs.h"
 #include "cache.h"
 #include "fid.h"
 
+static void v9fs_upload_to_server(struct netfs_io_subrequest *subreq)
+{
+	struct inode *inode = subreq->rreq->inode;
+	struct v9fs_inode __maybe_unused *v9inode = V9FS_I(inode);
+	struct p9_fid *fid = subreq->rreq->netfs_priv;
+	int err;
+
+	trace_netfs_sreq(subreq, netfs_sreq_trace_submit);
+	p9_client_write(fid, subreq->start, &subreq->io_iter, &err);
+	netfs_write_subrequest_terminated(subreq, err < 0 ? err : subreq->len,
+					  false);
+}
+
+static void v9fs_upload_to_server_worker(struct work_struct *work)
+{
+	struct netfs_io_subrequest *subreq =
+		container_of(work, struct netfs_io_subrequest, work);
+
+	v9fs_upload_to_server(subreq);
+}
+
+/*
+ * Set up write requests for a writeback slice.  We need to add a write request
+ * for each write we want to make.
+ */
+static void v9fs_create_write_requests(struct netfs_io_request *wreq, loff_t start, size_t len)
+{
+	struct netfs_io_subrequest *subreq;
+
+	subreq = netfs_create_write_request(wreq, NETFS_UPLOAD_TO_SERVER,
+					    start, len, v9fs_upload_to_server_worker);
+	if (subreq)
+		netfs_queue_write_request(subreq);
+}
+
 /**
  * v9fs_issue_read - Issue a read from 9P
  * @subreq: The read to make
@@ -33,14 +69,10 @@ static void v9fs_issue_read(struct netfs_io_subrequest *subreq)
 {
 	struct netfs_io_request *rreq = subreq->rreq;
 	struct p9_fid *fid = rreq->netfs_priv;
-	struct iov_iter to;
-	loff_t pos = subreq->start + subreq->transferred;
-	size_t len = subreq->len   - subreq->transferred;
 	int total, err;
 
-	iov_iter_xarray(&to, ITER_DEST, &rreq->mapping->i_pages, pos, len);
-
-	total = p9_client_read(fid, pos, &to, &err);
+	total = p9_client_read(fid, subreq->start + subreq->transferred,
+			       &subreq->io_iter, &err);
 
 	/* if we just extended the file size, any portion not in
 	 * cache won't be on server and is zeroes */
@@ -50,23 +82,37 @@ static void v9fs_issue_read(struct netfs_io_subrequest *subreq)
 }
 
 /**
- * v9fs_init_request - Initialise a read request
+ * v9fs_init_request - Initialise a request
  * @rreq: The read request
  * @file: The file being read from
  */
 static int v9fs_init_request(struct netfs_io_request *rreq, struct file *file)
 {
-	struct p9_fid *fid = file->private_data;
-
-	BUG_ON(!fid);
+	struct p9_fid *fid;
+	bool writing = (rreq->origin == NETFS_READ_FOR_WRITE ||
+			rreq->origin == NETFS_WRITEBACK ||
+			rreq->origin == NETFS_WRITETHROUGH ||
+			rreq->origin == NETFS_LAUNDER_WRITE ||
+			rreq->origin == NETFS_UNBUFFERED_WRITE ||
+			rreq->origin == NETFS_DIO_WRITE);
+
+	if (file) {
+		fid = file->private_data;
+		BUG_ON(!fid);
+		p9_fid_get(fid);
+	} else {
+		fid = v9fs_fid_find_inode(rreq->inode, writing, INVALID_UID, true);
+		if (!fid) {
+			WARN_ONCE(1, "folio expected an open fid inode->i_private=%p\n",
+				  rreq->inode->i_private);
+			return -EINVAL;
+		}
+	}
 
 	/* we might need to read from a fid that was opened write-only
 	 * for read-modify-write of page cache, use the writeback fid
 	 * for that */
-	WARN_ON(rreq->origin == NETFS_READ_FOR_WRITE &&
-			!(fid->mode & P9_ORDWR));
-
-	p9_fid_get(fid);
+	WARN_ON(writing && !(fid->mode & P9_ORDWR));
 	rreq->netfs_priv = fid;
 	return 0;
 }
@@ -86,217 +132,15 @@ const struct netfs_request_ops v9fs_req_ops = {
 	.init_request		= v9fs_init_request,
 	.free_request		= v9fs_free_request,
 	.issue_read		= v9fs_issue_read,
+	.create_write_requests	= v9fs_create_write_requests,
 };
 
-#ifdef CONFIG_9P_FSCACHE
-static void v9fs_write_to_cache_done(void *priv, ssize_t transferred_or_error,
-				     bool was_async)
-{
-	struct v9fs_inode *v9inode = priv;
-	__le32 version;
-
-	if (IS_ERR_VALUE(transferred_or_error) &&
-	    transferred_or_error != -ENOBUFS) {
-		version = cpu_to_le32(v9inode->qid.version);
-		fscache_invalidate(v9fs_inode_cookie(v9inode), &version,
-				   i_size_read(&v9inode->netfs.inode), 0);
-	}
-}
-#endif
-
-static int v9fs_vfs_write_folio_locked(struct folio *folio)
-{
-	struct inode *inode = folio_inode(folio);
-	loff_t start = folio_pos(folio);
-	loff_t i_size = i_size_read(inode);
-	struct iov_iter from;
-	size_t len = folio_size(folio);
-	struct p9_fid *writeback_fid;
-	int err;
-	struct v9fs_inode __maybe_unused *v9inode = V9FS_I(inode);
-	struct fscache_cookie __maybe_unused *cookie = v9fs_inode_cookie(v9inode);
-
-	if (start >= i_size)
-		return 0; /* Simultaneous truncation occurred */
-
-	len = min_t(loff_t, i_size - start, len);
-
-	iov_iter_xarray(&from, ITER_SOURCE, &folio_mapping(folio)->i_pages, start, len);
-
-	writeback_fid = v9fs_fid_find_inode(inode, true, INVALID_UID, true);
-	if (!writeback_fid) {
-		WARN_ONCE(1, "folio expected an open fid inode->i_private=%p\n",
-			inode->i_private);
-		return -EINVAL;
-	}
-
-	folio_wait_fscache(folio);
-	folio_start_writeback(folio);
-
-	p9_client_write(writeback_fid, start, &from, &err);
-
-#ifdef CONFIG_9P_FSCACHE
-	if (err == 0 &&
-		fscache_cookie_enabled(cookie) &&
-		test_bit(FSCACHE_COOKIE_IS_CACHING, &cookie->flags)) {
-		folio_start_fscache(folio);
-		fscache_write_to_cache(v9fs_inode_cookie(v9inode),
-					folio_mapping(folio), start, len, i_size,
-					v9fs_write_to_cache_done, v9inode,
-					true);
-	}
-#endif
-
-	folio_end_writeback(folio);
-	p9_fid_put(writeback_fid);
-
-	return err;
-}
-
-static int v9fs_vfs_writepage(struct page *page, struct writeback_control *wbc)
-{
-	struct folio *folio = page_folio(page);
-	int retval;
-
-	p9_debug(P9_DEBUG_VFS, "folio %p\n", folio);
-
-	retval = v9fs_vfs_write_folio_locked(folio);
-	if (retval < 0) {
-		if (retval == -EAGAIN) {
-			folio_redirty_for_writepage(wbc, folio);
-			retval = 0;
-		} else {
-			mapping_set_error(folio_mapping(folio), retval);
-		}
-	} else
-		retval = 0;
-
-	folio_unlock(folio);
-	return retval;
-}
-
-static int v9fs_launder_folio(struct folio *folio)
-{
-	int retval;
-
-	if (folio_clear_dirty_for_io(folio)) {
-		retval = v9fs_vfs_write_folio_locked(folio);
-		if (retval)
-			return retval;
-	}
-	folio_wait_fscache(folio);
-	return 0;
-}
-
-/**
- * v9fs_direct_IO - 9P address space operation for direct I/O
- * @iocb: target I/O control block
- * @iter: The data/buffer to use
- *
- * The presence of v9fs_direct_IO() in the address space ops vector
- * allowes open() O_DIRECT flags which would have failed otherwise.
- *
- * In the non-cached mode, we shunt off direct read and write requests before
- * the VFS gets them, so this method should never be called.
- *
- * Direct IO is not 'yet' supported in the cached mode. Hence when
- * this routine is called through generic_file_aio_read(), the read/write fails
- * with an error.
- *
- */
-static ssize_t
-v9fs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
-{
-	struct file *file = iocb->ki_filp;
-	loff_t pos = iocb->ki_pos;
-	ssize_t n;
-	int err = 0;
-
-	if (iov_iter_rw(iter) == WRITE) {
-		n = p9_client_write(file->private_data, pos, iter, &err);
-		if (n) {
-			struct inode *inode = file_inode(file);
-			loff_t i_size = i_size_read(inode);
-
-			if (pos + n > i_size)
-				inode_add_bytes(inode, pos + n - i_size);
-		}
-	} else {
-		n = p9_client_read(file->private_data, pos, iter, &err);
-	}
-	return n ? n : err;
-}
-
-static int v9fs_write_begin(struct file *filp, struct address_space *mapping,
-			    loff_t pos, unsigned int len,
-			    struct page **subpagep, void **fsdata)
-{
-	int retval;
-	struct folio *folio;
-	struct v9fs_inode *v9inode = V9FS_I(mapping->host);
-
-	p9_debug(P9_DEBUG_VFS, "filp %p, mapping %p\n", filp, mapping);
-
-	/* Prefetch area to be written into the cache if we're caching this
-	 * file.  We need to do this before we get a lock on the page in case
-	 * there's more than one writer competing for the same cache block.
-	 */
-	retval = netfs_write_begin(&v9inode->netfs, filp, mapping, pos, len, &folio, fsdata);
-	if (retval < 0)
-		return retval;
-
-	*subpagep = &folio->page;
-	return retval;
-}
-
-static int v9fs_write_end(struct file *filp, struct address_space *mapping,
-			  loff_t pos, unsigned int len, unsigned int copied,
-			  struct page *subpage, void *fsdata)
-{
-	loff_t last_pos = pos + copied;
-	struct folio *folio = page_folio(subpage);
-	struct inode *inode = mapping->host;
-
-	p9_debug(P9_DEBUG_VFS, "filp %p, mapping %p\n", filp, mapping);
-
-	if (!folio_test_uptodate(folio)) {
-		if (unlikely(copied < len)) {
-			copied = 0;
-			goto out;
-		}
-
-		folio_mark_uptodate(folio);
-	}
-
-	/*
-	 * No need to use i_size_read() here, the i_size
-	 * cannot change under us because we hold the i_mutex.
-	 */
-	if (last_pos > inode->i_size) {
-		inode_add_bytes(inode, last_pos - inode->i_size);
-		i_size_write(inode, last_pos);
-#ifdef CONFIG_9P_FSCACHE
-		fscache_update_cookie(v9fs_inode_cookie(V9FS_I(inode)), NULL,
-			&last_pos);
-#endif
-	}
-	folio_mark_dirty(folio);
-out:
-	folio_unlock(folio);
-	folio_put(folio);
-
-	return copied;
-}
-
 const struct address_space_operations v9fs_addr_operations = {
-	.read_folio	= netfs_read_folio,
-	.readahead	= netfs_readahead,
-	.dirty_folio	= netfs_dirty_folio,
-	.writepage	= v9fs_vfs_writepage,
-	.write_begin	= v9fs_write_begin,
-	.write_end	= v9fs_write_end,
-	.release_folio	= netfs_release_folio,
-	.invalidate_folio = netfs_invalidate_folio,
-	.launder_folio	= v9fs_launder_folio,
-	.direct_IO	= v9fs_direct_IO,
+	.read_folio		= netfs_read_folio,
+	.readahead		= netfs_readahead,
+	.dirty_folio		= netfs_dirty_folio,
+	.release_folio		= netfs_release_folio,
+	.invalidate_folio	= netfs_invalidate_folio,
+	.launder_folio		= netfs_launder_folio,
+	.direct_IO		= noop_direct_IO,
 };
diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
index 11cd8d23f6f2..bae330c2f0cf 100644
--- a/fs/9p/vfs_file.c
+++ b/fs/9p/vfs_file.c
@@ -353,25 +353,15 @@ static ssize_t
 v9fs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
 	struct p9_fid *fid = iocb->ki_filp->private_data;
-	int ret, err = 0;
 
 	p9_debug(P9_DEBUG_VFS, "fid %d count %zu offset %lld\n",
 		 fid->fid, iov_iter_count(to), iocb->ki_pos);
 
-	if (!(fid->mode & P9L_DIRECT)) {
-		p9_debug(P9_DEBUG_VFS, "(cached)\n");
-		return generic_file_read_iter(iocb, to);
-	}
-
-	if (iocb->ki_filp->f_flags & O_NONBLOCK)
-		ret = p9_client_read_once(fid, iocb->ki_pos, to, &err);
-	else
-		ret = p9_client_read(fid, iocb->ki_pos, to, &err);
-	if (!ret)
-		return err;
+	if (fid->mode & P9L_DIRECT)
+		return netfs_unbuffered_read_iter(iocb, to);
 
-	iocb->ki_pos += ret;
-	return ret;
+	p9_debug(P9_DEBUG_VFS, "(cached)\n");
+	return netfs_file_read_iter(iocb, to);
 }
 
 /*
@@ -407,46 +397,14 @@ v9fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct file *file = iocb->ki_filp;
 	struct p9_fid *fid = file->private_data;
-	ssize_t retval;
-	loff_t origin;
-	int err = 0;
 
 	p9_debug(P9_DEBUG_VFS, "fid %d\n", fid->fid);
 
-	if (!(fid->mode & (P9L_DIRECT | P9L_NOWRITECACHE))) {
-		p9_debug(P9_DEBUG_CACHE, "(cached)\n");
-		return generic_file_write_iter(iocb, from);
-	}
+	if (fid->mode & (P9L_DIRECT | P9L_NOWRITECACHE))
+		return netfs_unbuffered_write_iter(iocb, from);
 
-	retval = generic_write_checks(iocb, from);
-	if (retval <= 0)
-		return retval;
-
-	origin = iocb->ki_pos;
-	retval = p9_client_write(file->private_data, iocb->ki_pos, from, &err);
-	if (retval > 0) {
-		struct inode *inode = file_inode(file);
-		loff_t i_size;
-		unsigned long pg_start, pg_end;
-
-		pg_start = origin >> PAGE_SHIFT;
-		pg_end = (origin + retval - 1) >> PAGE_SHIFT;
-		if (inode->i_mapping && inode->i_mapping->nrpages)
-			invalidate_inode_pages2_range(inode->i_mapping,
-						      pg_start, pg_end);
-		iocb->ki_pos += retval;
-		i_size = i_size_read(inode);
-		if (iocb->ki_pos > i_size) {
-			inode_add_bytes(inode, iocb->ki_pos - i_size);
-			/*
-			 * Need to serialize against i_size_write() in
-			 * v9fs_stat2inode()
-			 */
-			v9fs_i_size_write(inode, iocb->ki_pos);
-		}
-		return retval;
-	}
-	return err;
+	p9_debug(P9_DEBUG_CACHE, "(cached)\n");
+	return netfs_file_write_iter(iocb, from);
 }
 
 static int v9fs_file_fsync(struct file *filp, loff_t start, loff_t end,
@@ -519,36 +477,7 @@ v9fs_file_mmap(struct file *filp, struct vm_area_struct *vma)
 static vm_fault_t
 v9fs_vm_page_mkwrite(struct vm_fault *vmf)
 {
-	struct folio *folio = page_folio(vmf->page);
-	struct file *filp = vmf->vma->vm_file;
-	struct inode *inode = file_inode(filp);
-
-
-	p9_debug(P9_DEBUG_VFS, "folio %p fid %lx\n",
-		 folio, (unsigned long)filp->private_data);
-
-	/* Wait for the page to be written to the cache before we allow it to
-	 * be modified.  We then assume the entire page will need writing back.
-	 */
-#ifdef CONFIG_9P_FSCACHE
-	if (folio_test_fscache(folio) &&
-	    folio_wait_fscache_killable(folio) < 0)
-		return VM_FAULT_NOPAGE;
-#endif
-
-	/* Update file times before taking page lock */
-	file_update_time(filp);
-
-	if (folio_lock_killable(folio) < 0)
-		return VM_FAULT_RETRY;
-	if (folio_mapping(folio) != inode->i_mapping)
-		goto out_unlock;
-	folio_wait_stable(folio);
-
-	return VM_FAULT_LOCKED;
-out_unlock:
-	folio_unlock(folio);
-	return VM_FAULT_NOPAGE;
+	return netfs_page_mkwrite(vmf, NULL);
 }
 
 static void v9fs_mmap_vm_close(struct vm_area_struct *vma)
diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 74122540e00f..1c3f931914c0 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -374,10 +374,8 @@ void v9fs_evict_inode(struct inode *inode)
 
 	truncate_inode_pages_final(&inode->i_data);
 
-#ifdef CONFIG_9P_FSCACHE
 	version = cpu_to_le32(v9inode->qid.version);
 	netfs_clear_inode_writeback(inode, &version);
-#endif
 
 	clear_inode(inode);
 	filemap_fdatawrite(&inode->i_data);


