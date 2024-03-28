Return-Path: <linux-fsdevel+bounces-15576-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C65F4890610
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 17:46:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 350F2B2373E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 16:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A087C1353E1;
	Thu, 28 Mar 2024 16:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LoJul0/z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15BD13D61B
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Mar 2024 16:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711643937; cv=none; b=UiMef2yzHKFszzLuT2IagT95t5OXHDK39TWRe6avHUvg1rXDsxlz281UWw/l5EUps7UfWYJBQNOI81iuVyOufDChcu1m1wpmM6vvzShj7RPm1374oLI4+PnKVjmjZyzy3Z6Qg8weRpiJY9yozl+mYm59gYWOmLc+Dmfw4PZZ4ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711643937; c=relaxed/simple;
	bh=oBqdIFpkxwrOuNbLxgcNFhMQYGFsOeJRncsduN6R74Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AnMvHxo0rmHcWe8kfDXfxQjKAFCkufmUZ9sRbMjLVdyAf5S/oo7ONmIDrfRZ0BuNMovsColnmqu55kxdXfxCMfUX2b6uFI1gMCMGNb10VOUvTmAt7/Gp00aDaA0TIlt2xaV5zXBCQA5kNnQmqqF69TndXY2z46fVvGZVRbR1MgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LoJul0/z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711643933;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yysHDoFsaat25r5KhNHOpBxqldzZWOb6zmBTbLFyQv0=;
	b=LoJul0/zngJ4o28jv0yE9kBLGgdD44+lvs21fA/H91ii8ANiYWzsrzKMybA0m7uW1hVlae
	Py0FBDEPScB3NrYhcrUhb98f9FW7yZw1PvzwuIgJiNQ3ztemRG9MAuwJHFf2L7HbnFP+qS
	Ydki1UsuARzfH1fQyg1nsYuGE4Lforo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-118-i8DZPKYdMQO5bPz1MylG1A-1; Thu, 28 Mar 2024 12:38:50 -0400
X-MC-Unique: i8DZPKYdMQO5bPz1MylG1A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 953F785A58C;
	Thu, 28 Mar 2024 16:38:48 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.146])
	by smtp.corp.redhat.com (Postfix) with ESMTP id AA16F17A9D;
	Thu, 28 Mar 2024 16:38:44 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Jeff Layton <jlayton@kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Dominique Martinet <asmadeus@codewreck.org>
Cc: David Howells <dhowells@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Steve French <smfrench@gmail.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	netfs@lists.linux.dev,
	linux-cachefs@redhat.com,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>
Subject: [PATCH 23/26] netfs: Cut over to using new writeback code
Date: Thu, 28 Mar 2024 16:34:15 +0000
Message-ID: <20240328163424.2781320-24-dhowells@redhat.com>
In-Reply-To: <20240328163424.2781320-1-dhowells@redhat.com>
References: <20240328163424.2781320-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

Cut over to using the new writeback code.  The old code is #ifdef'd out or
otherwise removed from compilation to avoid conflicts and will be removed
in a future patch.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: Eric Van Hensbergen <ericvh@kernel.org>
cc: Latchesar Ionkov <lucho@ionkov.net>
cc: Dominique Martinet <asmadeus@codewreck.org>
cc: Christian Schoenebeck <linux_oss@crudebyte.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: v9fs@lists.linux.dev
cc: linux-afs@lists.infradead.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/9p/vfs_addr.c          |  6 ++---
 fs/afs/file.c             |  3 +--
 fs/afs/internal.h         |  1 -
 fs/afs/write.c            |  2 ++
 fs/netfs/Makefile         |  1 -
 fs/netfs/buffered_write.c | 46 +++++++++++++++++++++------------------
 fs/netfs/direct_write.c   | 26 ++++++++++++----------
 fs/netfs/internal.h       | 21 +++++-------------
 fs/netfs/write_collect.c  |  8 +++----
 fs/netfs/write_issue.c    | 18 +++++++--------
 include/linux/netfs.h     |  9 --------
 11 files changed, 63 insertions(+), 78 deletions(-)

diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
index 07d03efdd594..4845e655bc39 100644
--- a/fs/9p/vfs_addr.c
+++ b/fs/9p/vfs_addr.c
@@ -60,6 +60,7 @@ static void v9fs_issue_write(struct netfs_io_subrequest *subreq)
 	netfs_write_subrequest_terminated(subreq, len ?: err, false);
 }
 
+#if 0 // TODO: Remove
 static void v9fs_upload_to_server(struct netfs_io_subrequest *subreq)
 {
 	struct p9_fid *fid = subreq->rreq->netfs_priv;
@@ -91,6 +92,7 @@ static void v9fs_create_write_requests(struct netfs_io_request *wreq, loff_t sta
 	if (subreq)
 		netfs_queue_write_request(subreq);
 }
+#endif
 
 /**
  * v9fs_issue_read - Issue a read from 9P
@@ -121,18 +123,15 @@ static int v9fs_init_request(struct netfs_io_request *rreq, struct file *file)
 {
 	struct p9_fid *fid;
 	bool writing = (rreq->origin == NETFS_READ_FOR_WRITE ||
-			rreq->origin == NETFS_WRITEBACK ||
 			rreq->origin == NETFS_WRITETHROUGH ||
 			rreq->origin == NETFS_UNBUFFERED_WRITE ||
 			rreq->origin == NETFS_DIO_WRITE);
 
-#if 0 // TODO: Cut over
 	if (rreq->origin == NETFS_WRITEBACK)
 		return 0; /* We don't get the write handle until we find we
 			   * have actually dirty data and not just
 			   * copy-to-cache data.
 			   */
-#endif
 
 	if (file) {
 		fid = file->private_data;
@@ -179,7 +178,6 @@ const struct netfs_request_ops v9fs_req_ops = {
 	.issue_read		= v9fs_issue_read,
 	.begin_writeback	= v9fs_begin_writeback,
 	.issue_write		= v9fs_issue_write,
-	.create_write_requests	= v9fs_create_write_requests,
 };
 
 const struct address_space_operations v9fs_addr_operations = {
diff --git a/fs/afs/file.c b/fs/afs/file.c
index db9ebae84fa2..8f983e3ecae7 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -353,7 +353,7 @@ static int afs_init_request(struct netfs_io_request *rreq, struct file *file)
 	if (file)
 		rreq->netfs_priv = key_get(afs_file_key(file));
 	rreq->rsize = 256 * 1024;
-	rreq->wsize = 256 * 1024;
+	rreq->wsize = 256 * 1024 * 1024;
 	return 0;
 }
 
@@ -399,7 +399,6 @@ const struct netfs_request_ops afs_req_ops = {
 	.issue_read		= afs_issue_read,
 	.update_i_size		= afs_update_i_size,
 	.invalidate_cache	= afs_netfs_invalidate_cache,
-	.create_write_requests	= afs_create_write_requests,
 	.begin_writeback	= afs_begin_writeback,
 	.prepare_write		= afs_prepare_write,
 	.issue_write		= afs_issue_write,
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index dcf0ae0323d3..887245f9336d 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -1605,7 +1605,6 @@ extern int afs_writepages(struct address_space *, struct writeback_control *);
 extern int afs_fsync(struct file *, loff_t, loff_t, int);
 extern vm_fault_t afs_page_mkwrite(struct vm_fault *vmf);
 extern void afs_prune_wb_keys(struct afs_vnode *);
-void afs_create_write_requests(struct netfs_io_request *wreq, loff_t start, size_t len);
 
 /*
  * xattr.c
diff --git a/fs/afs/write.c b/fs/afs/write.c
index 89b073881cac..0ead204c84cb 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -156,6 +156,7 @@ static int afs_store_data(struct afs_vnode *vnode, struct iov_iter *iter, loff_t
 	return afs_put_operation(op);
 }
 
+#if 0 // TODO: Remove
 static void afs_upload_to_server(struct netfs_io_subrequest *subreq)
 {
 	struct afs_vnode *vnode = AFS_FS_I(subreq->rreq->inode);
@@ -193,6 +194,7 @@ void afs_create_write_requests(struct netfs_io_request *wreq, loff_t start, size
 	if (subreq)
 		netfs_queue_write_request(subreq);
 }
+#endif
 
 /*
  * Writeback calls this when it finds a folio that needs uploading.  This isn't
diff --git a/fs/netfs/Makefile b/fs/netfs/Makefile
index 1eb86e34b5a9..8e6781e0b10b 100644
--- a/fs/netfs/Makefile
+++ b/fs/netfs/Makefile
@@ -11,7 +11,6 @@ netfs-y := \
 	main.o \
 	misc.o \
 	objects.o \
-	output.o \
 	write_collect.o \
 	write_issue.o
 
diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
index 621532dacef5..945e646cd2db 100644
--- a/fs/netfs/buffered_write.c
+++ b/fs/netfs/buffered_write.c
@@ -26,8 +26,6 @@ enum netfs_how_to_modify {
 	NETFS_FLUSH_CONTENT,		/* Flush incompatible content. */
 };
 
-static void netfs_cleanup_buffered_write(struct netfs_io_request *wreq);
-
 static void netfs_set_group(struct folio *folio, struct netfs_group *netfs_group)
 {
 	void *priv = folio_get_private(folio);
@@ -180,7 +178,7 @@ ssize_t netfs_perform_write(struct kiocb *iocb, struct iov_iter *iter,
 	};
 	struct netfs_io_request *wreq = NULL;
 	struct netfs_folio *finfo;
-	struct folio *folio;
+	struct folio *folio, *writethrough = NULL;
 	enum netfs_how_to_modify howto;
 	enum netfs_folio_trace trace;
 	unsigned int bdp_flags = (iocb->ki_flags & IOCB_SYNC) ? 0: BDP_ASYNC;
@@ -210,7 +208,6 @@ ssize_t netfs_perform_write(struct kiocb *iocb, struct iov_iter *iter,
 		}
 		if (!is_sync_kiocb(iocb))
 			wreq->iocb = iocb;
-		wreq->cleanup = netfs_cleanup_buffered_write;
 		netfs_stat(&netfs_n_wh_writethrough);
 	} else {
 		netfs_stat(&netfs_n_wh_buffered_write);
@@ -254,6 +251,15 @@ ssize_t netfs_perform_write(struct kiocb *iocb, struct iov_iter *iter,
 		offset = pos & (flen - 1);
 		part = min_t(size_t, flen - offset, part);
 
+		/* Wait for writeback to complete.  The writeback engine owns
+		 * the info in folio->private and may change it until it
+		 * removes the WB mark.
+		 */
+		if (folio_wait_writeback_killable(folio)) {
+			ret = written ? -EINTR : -ERESTARTSYS;
+			goto error_folio_unlock;
+		}
+
 		if (signal_pending(current)) {
 			ret = written ? -EINTR : -ERESTARTSYS;
 			goto error_folio_unlock;
@@ -328,6 +334,7 @@ ssize_t netfs_perform_write(struct kiocb *iocb, struct iov_iter *iter,
 				maybe_trouble = true;
 				iov_iter_revert(iter, copied);
 				copied = 0;
+				folio_unlock(folio);
 				goto retry;
 			}
 			netfs_set_group(folio, netfs_group);
@@ -383,23 +390,16 @@ ssize_t netfs_perform_write(struct kiocb *iocb, struct iov_iter *iter,
 
 		if (likely(!wreq)) {
 			folio_mark_dirty(folio);
+			folio_unlock(folio);
 		} else {
-			if (folio_test_dirty(folio))
-				/* Sigh.  mmap. */
-				folio_clear_dirty_for_io(folio);
-			/* We make multiple writes to the folio... */
-			if (!folio_test_writeback(folio)) {
-				folio_start_writeback(folio);
-				if (wreq->iter.count == 0)
-					trace_netfs_folio(folio, netfs_folio_trace_wthru);
-				else
-					trace_netfs_folio(folio, netfs_folio_trace_wthru_plus);
-			}
-			netfs_advance_writethrough(wreq, copied,
-						   offset + copied == flen);
+			if (pos > wreq->i_size)
+				wreq->i_size = pos;
+			netfs_advance_writethrough(wreq, &wbc, folio, copied,
+						   offset + copied == flen,
+						   &writethrough);
+			/* Folio unlocked */
 		}
 	retry:
-		folio_unlock(folio);
 		folio_put(folio);
 		folio = NULL;
 
@@ -408,7 +408,7 @@ ssize_t netfs_perform_write(struct kiocb *iocb, struct iov_iter *iter,
 
 out:
 	if (unlikely(wreq)) {
-		ret2 = netfs_end_writethrough(wreq, iocb);
+		ret2 = netfs_end_writethrough(wreq, &wbc, writethrough);
 		wbc_detach_inode(&wbc);
 		if (ret2 == -EIOCBQUEUED)
 			return ret2;
@@ -530,11 +530,13 @@ vm_fault_t netfs_page_mkwrite(struct vm_fault *vmf, struct netfs_group *netfs_gr
 
 	sb_start_pagefault(inode->i_sb);
 
-	if (folio_wait_writeback_killable(folio))
+	if (folio_lock_killable(folio) < 0)
 		goto out;
 
-	if (folio_lock_killable(folio) < 0)
+	if (folio_wait_writeback_killable(folio)) {
+		ret = VM_FAULT_LOCKED;
 		goto out;
+	}
 
 	/* Can we see a streaming write here? */
 	if (WARN_ON(!folio_test_uptodate(folio))) {
@@ -574,6 +576,7 @@ vm_fault_t netfs_page_mkwrite(struct vm_fault *vmf, struct netfs_group *netfs_gr
 }
 EXPORT_SYMBOL(netfs_page_mkwrite);
 
+#if 0 // TODO: Remove
 /*
  * Kill all the pages in the given range
  */
@@ -1200,3 +1203,4 @@ int netfs_writepages(struct address_space *mapping,
 	return ret;
 }
 EXPORT_SYMBOL(netfs_writepages);
+#endif
diff --git a/fs/netfs/direct_write.c b/fs/netfs/direct_write.c
index 37c91188107b..330ba7cb3f10 100644
--- a/fs/netfs/direct_write.c
+++ b/fs/netfs/direct_write.c
@@ -34,6 +34,7 @@ static ssize_t netfs_unbuffered_write_iter_locked(struct kiocb *iocb, struct iov
 	unsigned long long start = iocb->ki_pos;
 	unsigned long long end = start + iov_iter_count(iter);
 	ssize_t ret, n;
+	size_t len = iov_iter_count(iter);
 	bool async = !is_sync_kiocb(iocb);
 
 	_enter("");
@@ -46,13 +47,17 @@ static ssize_t netfs_unbuffered_write_iter_locked(struct kiocb *iocb, struct iov
 
 	_debug("uw %llx-%llx", start, end);
 
-	wreq = netfs_alloc_request(iocb->ki_filp->f_mapping, iocb->ki_filp,
-				   start, end - start,
-				   iocb->ki_flags & IOCB_DIRECT ?
-				   NETFS_DIO_WRITE : NETFS_UNBUFFERED_WRITE);
+	wreq = netfs_create_write_req(iocb->ki_filp->f_mapping, iocb->ki_filp, start,
+				      iocb->ki_flags & IOCB_DIRECT ?
+				      NETFS_DIO_WRITE : NETFS_UNBUFFERED_WRITE);
 	if (IS_ERR(wreq))
 		return PTR_ERR(wreq);
 
+	wreq->io_streams[0].avail = true;
+	trace_netfs_write(wreq, (iocb->ki_flags & IOCB_DIRECT ?
+				 netfs_write_trace_dio_write :
+				 netfs_write_trace_unbuffered_write));
+
 	{
 		/* If this is an async op and we're not using a bounce buffer,
 		 * we have to save the source buffer as the iterator is only
@@ -63,7 +68,7 @@ static ssize_t netfs_unbuffered_write_iter_locked(struct kiocb *iocb, struct iov
 		 * request.
 		 */
 		if (async || user_backed_iter(iter)) {
-			n = netfs_extract_user_iter(iter, wreq->len, &wreq->iter, 0);
+			n = netfs_extract_user_iter(iter, len, &wreq->iter, 0);
 			if (n < 0) {
 				ret = n;
 				goto out;
@@ -71,7 +76,6 @@ static ssize_t netfs_unbuffered_write_iter_locked(struct kiocb *iocb, struct iov
 			wreq->direct_bv = (struct bio_vec *)wreq->iter.bvec;
 			wreq->direct_bv_count = n;
 			wreq->direct_bv_unpin = iov_iter_extract_will_pin(iter);
-			wreq->len = iov_iter_count(&wreq->iter);
 		} else {
 			wreq->iter = *iter;
 		}
@@ -79,6 +83,8 @@ static ssize_t netfs_unbuffered_write_iter_locked(struct kiocb *iocb, struct iov
 		wreq->io_iter = wreq->iter;
 	}
 
+	__set_bit(NETFS_RREQ_USE_IO_ITER, &wreq->flags);
+
 	/* Copy the data into the bounce buffer and encrypt it. */
 	// TODO
 
@@ -87,10 +93,7 @@ static ssize_t netfs_unbuffered_write_iter_locked(struct kiocb *iocb, struct iov
 	if (async)
 		wreq->iocb = iocb;
 	wreq->cleanup = netfs_cleanup_dio_write;
-	ret = netfs_begin_write(wreq, is_sync_kiocb(iocb),
-				iocb->ki_flags & IOCB_DIRECT ?
-				netfs_write_trace_dio_write :
-				netfs_write_trace_unbuffered_write);
+	ret = netfs_unbuffered_write(wreq, is_sync_kiocb(iocb), iov_iter_count(&wreq->io_iter));
 	if (ret < 0) {
 		_debug("begin = %zd", ret);
 		goto out;
@@ -100,9 +103,8 @@ static ssize_t netfs_unbuffered_write_iter_locked(struct kiocb *iocb, struct iov
 		trace_netfs_rreq(wreq, netfs_rreq_trace_wait_ip);
 		wait_on_bit(&wreq->flags, NETFS_RREQ_IN_PROGRESS,
 			    TASK_UNINTERRUPTIBLE);
-
+		smp_rmb(); /* Read error/transferred after RIP flag */
 		ret = wreq->error;
-		_debug("waited = %zd", ret);
 		if (ret == 0) {
 			ret = wreq->transferred;
 			iocb->ki_pos += ret;
diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
index 5d3f74a70fa7..95e281a8af78 100644
--- a/fs/netfs/internal.h
+++ b/fs/netfs/internal.h
@@ -92,15 +92,6 @@ static inline void netfs_see_request(struct netfs_io_request *rreq,
 	trace_netfs_rreq_ref(rreq->debug_id, refcount_read(&rreq->ref), what);
 }
 
-/*
- * output.c
- */
-int netfs_begin_write(struct netfs_io_request *wreq, bool may_wait,
-		      enum netfs_write_trace what);
-struct netfs_io_request *netfs_begin_writethrough(struct kiocb *iocb, size_t len);
-int netfs_advance_writethrough(struct netfs_io_request *wreq, size_t copied, bool to_page_end);
-int netfs_end_writethrough(struct netfs_io_request *wreq, struct kiocb *iocb);
-
 /*
  * stats.c
  */
@@ -172,12 +163,12 @@ void netfs_reissue_write(struct netfs_io_stream *stream,
 int netfs_advance_write(struct netfs_io_request *wreq,
 			struct netfs_io_stream *stream,
 			loff_t start, size_t len, bool to_eof);
-struct netfs_io_request *new_netfs_begin_writethrough(struct kiocb *iocb, size_t len);
-int new_netfs_advance_writethrough(struct netfs_io_request *wreq, struct writeback_control *wbc,
-				   struct folio *folio, size_t copied, bool to_page_end,
-				   struct folio **writethrough_cache);
-int new_netfs_end_writethrough(struct netfs_io_request *wreq, struct writeback_control *wbc,
-			       struct folio *writethrough_cache);
+struct netfs_io_request *netfs_begin_writethrough(struct kiocb *iocb, size_t len);
+int netfs_advance_writethrough(struct netfs_io_request *wreq, struct writeback_control *wbc,
+			       struct folio *folio, size_t copied, bool to_page_end,
+			       struct folio **writethrough_cache);
+int netfs_end_writethrough(struct netfs_io_request *wreq, struct writeback_control *wbc,
+			   struct folio *writethrough_cache);
 int netfs_unbuffered_write(struct netfs_io_request *wreq, bool may_wait, size_t len);
 
 /*
diff --git a/fs/netfs/write_collect.c b/fs/netfs/write_collect.c
index 5e2ca8b25af0..bea939ab0830 100644
--- a/fs/netfs/write_collect.c
+++ b/fs/netfs/write_collect.c
@@ -714,7 +714,7 @@ void netfs_wake_write_collector(struct netfs_io_request *wreq, bool was_async)
 }
 
 /**
- * new_netfs_write_subrequest_terminated - Note the termination of a write operation.
+ * netfs_write_subrequest_terminated - Note the termination of a write operation.
  * @_op: The I/O request that has terminated.
  * @transferred_or_error: The amount of data transferred or an error code.
  * @was_async: The termination was asynchronous
@@ -736,8 +736,8 @@ void netfs_wake_write_collector(struct netfs_io_request *wreq, bool was_async)
  * Note that %_op is a void* so that the function can be passed to
  * kiocb::term_func without the need for a casting wrapper.
  */
-void new_netfs_write_subrequest_terminated(void *_op, ssize_t transferred_or_error,
-					   bool was_async)
+void netfs_write_subrequest_terminated(void *_op, ssize_t transferred_or_error,
+				       bool was_async)
 {
 	struct netfs_io_subrequest *subreq = _op;
 	struct netfs_io_request *wreq = subreq->rreq;
@@ -805,4 +805,4 @@ void new_netfs_write_subrequest_terminated(void *_op, ssize_t transferred_or_err
 
 	netfs_put_subrequest(subreq, was_async, netfs_sreq_trace_put_terminated);
 }
-EXPORT_SYMBOL(new_netfs_write_subrequest_terminated);
+EXPORT_SYMBOL(netfs_write_subrequest_terminated);
diff --git a/fs/netfs/write_issue.c b/fs/netfs/write_issue.c
index e0fb472898f5..61e6208de235 100644
--- a/fs/netfs/write_issue.c
+++ b/fs/netfs/write_issue.c
@@ -485,8 +485,8 @@ static int netfs_write_folio(struct netfs_io_request *wreq,
 /*
  * Write some of the pending data back to the server
  */
-int new_netfs_writepages(struct address_space *mapping,
-			 struct writeback_control *wbc)
+int netfs_writepages(struct address_space *mapping,
+		     struct writeback_control *wbc)
 {
 	struct netfs_inode *ictx = netfs_inode(mapping->host);
 	struct netfs_io_request *wreq = NULL;
@@ -547,12 +547,12 @@ int new_netfs_writepages(struct address_space *mapping,
 	_leave(" = %d", error);
 	return error;
 }
-EXPORT_SYMBOL(new_netfs_writepages);
+EXPORT_SYMBOL(netfs_writepages);
 
 /*
  * Begin a write operation for writing through the pagecache.
  */
-struct netfs_io_request *new_netfs_begin_writethrough(struct kiocb *iocb, size_t len)
+struct netfs_io_request *netfs_begin_writethrough(struct kiocb *iocb, size_t len)
 {
 	struct netfs_io_request *wreq = NULL;
 	struct netfs_inode *ictx = netfs_inode(file_inode(iocb->ki_filp));
@@ -575,9 +575,9 @@ struct netfs_io_request *new_netfs_begin_writethrough(struct kiocb *iocb, size_t
  * to the request.  If we've added more than wsize then we need to create a new
  * subrequest.
  */
-int new_netfs_advance_writethrough(struct netfs_io_request *wreq, struct writeback_control *wbc,
-				   struct folio *folio, size_t copied, bool to_page_end,
-				   struct folio **writethrough_cache)
+int netfs_advance_writethrough(struct netfs_io_request *wreq, struct writeback_control *wbc,
+			       struct folio *folio, size_t copied, bool to_page_end,
+			       struct folio **writethrough_cache)
 {
 	_enter("R=%x ic=%zu ws=%u cp=%zu tp=%u",
 	       wreq->debug_id, wreq->iter.count, wreq->wsize, copied, to_page_end);
@@ -607,8 +607,8 @@ int new_netfs_advance_writethrough(struct netfs_io_request *wreq, struct writeba
 /*
  * End a write operation used when writing through the pagecache.
  */
-int new_netfs_end_writethrough(struct netfs_io_request *wreq, struct writeback_control *wbc,
-			       struct folio *writethrough_cache)
+int netfs_end_writethrough(struct netfs_io_request *wreq, struct writeback_control *wbc,
+			   struct folio *writethrough_cache)
 {
 	struct netfs_inode *ictx = netfs_inode(wreq->inode);
 	int ret;
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 42dba05a428b..c2ba364041b0 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -303,8 +303,6 @@ struct netfs_request_ops {
 	void (*update_i_size)(struct inode *inode, loff_t i_size);
 
 	/* Write request handling */
-	void (*create_write_requests)(struct netfs_io_request *wreq,
-				      loff_t start, size_t len);
 	void (*begin_writeback)(struct netfs_io_request *wreq);
 	void (*prepare_write)(struct netfs_io_subrequest *subreq);
 	void (*issue_write)(struct netfs_io_subrequest *subreq);
@@ -409,8 +407,6 @@ int netfs_write_begin(struct netfs_inode *, struct file *,
 		      struct folio **, void **fsdata);
 int netfs_writepages(struct address_space *mapping,
 		     struct writeback_control *wbc);
-int new_netfs_writepages(struct address_space *mapping,
-			struct writeback_control *wbc);
 bool netfs_dirty_folio(struct address_space *mapping, struct folio *folio);
 int netfs_unpin_writeback(struct inode *inode, struct writeback_control *wbc);
 void netfs_clear_inode_writeback(struct inode *inode, const void *aux);
@@ -431,14 +427,9 @@ ssize_t netfs_extract_user_iter(struct iov_iter *orig, size_t orig_len,
 				iov_iter_extraction_t extraction_flags);
 size_t netfs_limit_iter(const struct iov_iter *iter, size_t start_offset,
 			size_t max_size, size_t max_segs);
-struct netfs_io_subrequest *netfs_create_write_request(
-	struct netfs_io_request *wreq, enum netfs_io_source dest,
-	loff_t start, size_t len, work_func_t worker);
 void netfs_prepare_write_failed(struct netfs_io_subrequest *subreq);
 void netfs_write_subrequest_terminated(void *_op, ssize_t transferred_or_error,
 				       bool was_async);
-void new_netfs_write_subrequest_terminated(void *_op, ssize_t transferred_or_error,
-					   bool was_async);
 void netfs_queue_write_request(struct netfs_io_subrequest *subreq);
 
 int netfs_start_io_read(struct inode *inode);


