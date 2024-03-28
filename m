Return-Path: <linux-fsdevel+bounces-15592-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4BB88906A0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 18:03:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39D151F22DB5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 17:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 802FF137932;
	Thu, 28 Mar 2024 17:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D3TyZJEJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE73137765
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Mar 2024 17:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711645218; cv=none; b=tP1P2iEa9zDH5PxCAX09ggMq55NI74PakFyO7H2LK0RrfLGl2CPiDPbihWsaKqcxf7QSrH2LyjUWRjMygx4RYS302CHfvwUTQNcFfDbJ3hJMyK/ZYQdFcFKywP9K6cfNIk9ZRNXDr/HJtt6IAZMxMas0mdE8W8EYq0MIqwGsWdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711645218; c=relaxed/simple;
	bh=Q4NYs8avKCbELFNJ69BnmvUy9TV7IxgEZ3hwwqqqCK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rKAd7nVKZUM1CGcmNp18OFSvbrmKIpfJ/EDDodhRQgHDBzWowojkAozhabFJDlCDenOrDuqIhcOUY6dFr0gq6Z3W40gVyhwBvnuZSJKdLr/UyTaV8t+xFCo42lN8zAztgxQjC/dWdccMGn2IXSgpwpprjlMzAlweNn4nTY6Ya6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D3TyZJEJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711645216;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/iu1wjgW6NUFrJdHYjWcVNG2nPTvvseGUk2/qQlW9y8=;
	b=D3TyZJEJLtgWrz7ys/ifrZ5+rIYs9WeFiRGwTy+E9N87jNrgbZ54gFdDJL8cuRVeXa/ryA
	a/t7S/MCBmi0vhFBbAXwkWD2zRVfrV3rWMRHoL/MImOC653xvEoAEC9mdi2E/Yt9FPfgn+
	BVwT0DgSzqD6OxUxuyWJMF/peSyCbCk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-Ra3Ku4JVPhKL6AKlnrMLvw-1; Thu, 28 Mar 2024 13:00:12 -0400
X-MC-Unique: Ra3Ku4JVPhKL6AKlnrMLvw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D4ECC8007A7;
	Thu, 28 Mar 2024 17:00:11 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.146])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D7AE32166B31;
	Thu, 28 Mar 2024 17:00:09 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Steve French <smfrench@gmail.com>
Cc: David Howells <dhowells@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Christian Brauner <christian@brauner.io>,
	netfs@lists.linux.dev,
	linux-cifs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Steve French <sfrench@samba.org>,
	Shyam Prasad N <nspmangalore@gmail.com>,
	Rohith Surabattula <rohiths.msft@gmail.com>
Subject: [PATCH v6 10/15] cifs: Implement netfslib hooks
Date: Thu, 28 Mar 2024 16:58:01 +0000
Message-ID: <20240328165845.2782259-11-dhowells@redhat.com>
In-Reply-To: <20240328165845.2782259-1-dhowells@redhat.com>
References: <20240328165845.2782259-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

Provide implementation of the netfslib hooks that will be used by netfslib
to ask cifs to set up and perform operations.  Of particular note are

 (*) cifs_clamp_length() - This is used to negotiate the size of the next
     subrequest in a read request, taking into account the credit available
     and the rsize.  The credits are attached to the subrequest.

 (*) cifs_req_issue_read() - This is used to issue a subrequest that has
     been set up and clamped.

 (*) cifs_prepare_write() - This prepares to fill a subrequest by picking a
     channel, reopening the file and requesting credits so that we can set
     the maximum size of the subrequest and also sets the maximum number of
     segments if we're doing RDMA.

 (*) cifs_issue_write() - This releases any unneeded credits and issues an
     asynchronous data write for the contiguous slice of file covered by
     the subrequest.  This should possibly be folded in to all
     ->async_writev() ops and that called directly.

 (*) cifs_begin_writeback() - This gets the cached writable handle through
     which we do writeback (this does not affect writethrough, unbuffered
     or direct writes).

At this point, cifs is not wired up to actually *use* netfslib; that will
be done in a subsequent patch.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Shyam Prasad N <nspmangalore@gmail.com>
cc: Rohith Surabattula <rohiths.msft@gmail.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
---
 fs/netfs/buffered_write.c    |   6 +
 fs/smb/client/Kconfig        |   1 +
 fs/smb/client/cifsfs.c       |   2 +-
 fs/smb/client/cifsfs.h       |   1 +
 fs/smb/client/cifsglob.h     |  28 +++-
 fs/smb/client/file.c         | 315 +++++++++++++++++++++++++++++++++++
 include/linux/netfs.h        |   1 +
 include/trace/events/netfs.h |   1 +
 8 files changed, 345 insertions(+), 10 deletions(-)

diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
index 1eff9413eb1b..a3ef053d9789 100644
--- a/fs/netfs/buffered_write.c
+++ b/fs/netfs/buffered_write.c
@@ -407,6 +407,9 @@ ssize_t netfs_perform_write(struct kiocb *iocb, struct iov_iter *iter,
 	} while (iov_iter_count(iter));
 
 out:
+	if (likely(written) && ctx->ops->post_modify)
+		ctx->ops->post_modify(inode);
+
 	if (unlikely(wreq)) {
 		ret2 = netfs_end_writethrough(wreq, &wbc, writethrough);
 		wbc_detach_inode(&wbc);
@@ -523,6 +526,7 @@ vm_fault_t netfs_page_mkwrite(struct vm_fault *vmf, struct netfs_group *netfs_gr
 	struct folio *folio = page_folio(vmf->page);
 	struct file *file = vmf->vma->vm_file;
 	struct inode *inode = file_inode(file);
+	struct netfs_inode *ictx = netfs_inode(inode);
 	vm_fault_t ret = VM_FAULT_RETRY;
 	int err;
 
@@ -569,6 +573,8 @@ vm_fault_t netfs_page_mkwrite(struct vm_fault *vmf, struct netfs_group *netfs_gr
 		trace_netfs_folio(folio, netfs_folio_trace_mkwrite);
 	netfs_set_group(folio, netfs_group);
 	file_update_time(file);
+	if (ictx->ops->post_modify)
+		ictx->ops->post_modify(inode);
 	ret = VM_FAULT_LOCKED;
 out:
 	sb_end_pagefault(inode->i_sb);
diff --git a/fs/smb/client/Kconfig b/fs/smb/client/Kconfig
index 2927bd174a88..2517dc242386 100644
--- a/fs/smb/client/Kconfig
+++ b/fs/smb/client/Kconfig
@@ -2,6 +2,7 @@
 config CIFS
 	tristate "SMB3 and CIFS support (advanced network filesystem)"
 	depends on INET
+	select NETFS_SUPPORT
 	select NLS
 	select NLS_UCS2_UTILS
 	select CRYPTO
diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
index d8c31383752a..90801a0077da 100644
--- a/fs/smb/client/cifsfs.c
+++ b/fs/smb/client/cifsfs.c
@@ -1754,7 +1754,7 @@ static int cifs_init_netfs(void)
 {
 	cifs_io_request_cachep =
 		kmem_cache_create("cifs_io_request",
-				  sizeof(struct netfs_io_request), 0,
+				  sizeof(struct cifs_io_request), 0,
 				  SLAB_HWCACHE_ALIGN, NULL);
 	if (!cifs_io_request_cachep)
 		goto nomem_req;
diff --git a/fs/smb/client/cifsfs.h b/fs/smb/client/cifsfs.h
index 1acf6bfc06de..922c10d7cfdd 100644
--- a/fs/smb/client/cifsfs.h
+++ b/fs/smb/client/cifsfs.h
@@ -84,6 +84,7 @@ extern const struct inode_operations cifs_namespace_inode_operations;
 
 
 /* Functions related to files and directories */
+extern const struct netfs_request_ops cifs_req_ops;
 extern const struct file_operations cifs_file_ops;
 extern const struct file_operations cifs_file_direct_ops; /* if directio mnt */
 extern const struct file_operations cifs_file_strict_ops; /* if strictio mnt */
diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index 704f526a9e81..18a3babbe577 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -1486,15 +1486,24 @@ struct cifs_aio_ctx {
 	bool			direct_io;
 };
 
+struct cifs_io_request {
+	struct netfs_io_request		rreq;
+	struct cifsFileInfo		*cfile;
+};
+
 /* asynchronous read support */
 struct cifs_io_subrequest {
-	struct netfs_io_subrequest	subreq;
-	struct cifsFileInfo		*cfile;
-	struct address_space		*mapping;
-	struct cifs_aio_ctx		*ctx;
+	union {
+		struct netfs_io_subrequest subreq;
+		struct netfs_io_request *rreq;
+		struct cifs_io_request *req;
+	};
 	ssize_t				got_bytes;
 	pid_t				pid;
+	unsigned int			xid;
 	int				result;
+	bool				have_xid;
+	bool				replay;
 	struct kvec			iov[2];
 	struct TCP_Server_Info		*server;
 #ifdef CONFIG_CIFS_SMB_DIRECT
@@ -1502,15 +1511,16 @@ struct cifs_io_subrequest {
 #endif
 	struct cifs_credits		credits;
 
-	enum writeback_sync_modes	sync_mode;
-	bool				uncached;
-	bool				replay;
-	struct bio_vec			*bv;
-
 	// TODO: Remove following elements
 	struct list_head		list;
 	struct completion		done;
 	struct work_struct		work;
+	struct cifsFileInfo		*cfile;
+	struct address_space		*mapping;
+	struct cifs_aio_ctx		*ctx;
+	enum writeback_sync_modes	sync_mode;
+	bool				uncached;
+	struct bio_vec			*bv;
 };
 
 /*
diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index e40ba6de0a28..73573dadf90e 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -36,6 +36,321 @@
 #include "fs_context.h"
 #include "cifs_ioctl.h"
 #include "cached_dir.h"
+#include <trace/events/netfs.h>
+
+static int cifs_reopen_file(struct cifsFileInfo *cfile, bool can_flush);
+
+/*
+ * Prepare a subrequest to upload to the server.  We need to allocate credits
+ * so that we know the maximum amount of data that we can include in it.
+ */
+static void cifs_prepare_write(struct netfs_io_subrequest *subreq)
+{
+	struct cifs_io_subrequest *wdata =
+		container_of(subreq, struct cifs_io_subrequest, subreq);
+	struct cifs_io_request *req = wdata->req;
+	struct TCP_Server_Info *server;
+	struct cifsFileInfo *open_file = req->cfile;
+	size_t wsize = req->rreq.wsize;
+	int rc;
+
+	if (!wdata->have_xid) {
+		wdata->xid = get_xid();
+		wdata->have_xid = true;
+	}
+
+	server = cifs_pick_channel(tlink_tcon(open_file->tlink)->ses);
+	wdata->server = server;
+
+retry:
+	if (open_file->invalidHandle) {
+		rc = cifs_reopen_file(open_file, false);
+		if (rc < 0) {
+			if (rc == -EAGAIN)
+				goto retry;
+			subreq->error = rc;
+			return netfs_prepare_write_failed(subreq);
+		}
+	}
+
+	rc = server->ops->wait_mtu_credits(server, wsize, &wdata->subreq.max_len,
+					   &wdata->credits);
+	if (rc < 0) {
+		subreq->error = rc;
+		return netfs_prepare_write_failed(subreq);
+	}
+
+#ifdef CONFIG_CIFS_SMB_DIRECT
+	if (server->smbd_conn)
+		subreq->max_nr_segs = server->smbd_conn->max_frmr_depth;
+#endif
+}
+
+/*
+ * Issue a subrequest to upload to the server.
+ */
+static void cifs_issue_write(struct netfs_io_subrequest *subreq)
+{
+	struct cifs_io_subrequest *wdata =
+		container_of(subreq, struct cifs_io_subrequest, subreq);
+	struct cifs_sb_info *sbi = CIFS_SB(subreq->rreq->inode->i_sb);
+	int rc;
+
+	if (cifs_forced_shutdown(sbi)) {
+		rc = -EIO;
+		goto fail;
+	}
+
+	rc = adjust_credits(wdata->server, &wdata->credits, wdata->subreq.len);
+	if (rc)
+		goto fail;
+
+	rc = -EAGAIN;
+	if (wdata->req->cfile->invalidHandle)
+		goto fail;
+
+	wdata->server->ops->async_writev(wdata);
+out:
+	return;
+
+fail:
+	if (rc == -EAGAIN)
+		trace_netfs_sreq(subreq, netfs_sreq_trace_retry);
+	else
+		trace_netfs_sreq(subreq, netfs_sreq_trace_fail);
+	add_credits_and_wake_if(wdata->server, &wdata->credits, 0);
+	netfs_write_subrequest_terminated(wdata, rc, false);
+	goto out;
+}
+
+/*
+ * Split the read up according to how many credits we can get for each piece.
+ * It's okay to sleep here if we need to wait for more credit to become
+ * available.
+ *
+ * We also choose the server and allocate an operation ID to be cleaned up
+ * later.
+ */
+static bool cifs_clamp_length(struct netfs_io_subrequest *subreq)
+{
+	struct netfs_io_request *rreq = subreq->rreq;
+	struct TCP_Server_Info *server;
+	struct cifs_io_subrequest *rdata = container_of(subreq, struct cifs_io_subrequest, subreq);
+	struct cifs_io_request *req = container_of(subreq->rreq, struct cifs_io_request, rreq);
+	struct cifs_sb_info *cifs_sb = CIFS_SB(rreq->inode->i_sb);
+	size_t rsize = 0;
+	int rc;
+
+	rdata->xid = get_xid();
+	rdata->have_xid = true;
+
+	server = cifs_pick_channel(tlink_tcon(req->cfile->tlink)->ses);
+	rdata->server = server;
+
+	if (cifs_sb->ctx->rsize == 0)
+		cifs_sb->ctx->rsize =
+			server->ops->negotiate_rsize(tlink_tcon(req->cfile->tlink),
+						     cifs_sb->ctx);
+
+
+	rc = server->ops->wait_mtu_credits(server, cifs_sb->ctx->rsize, &rsize,
+					   &rdata->credits);
+	if (rc) {
+		subreq->error = rc;
+		return false;
+	}
+
+	subreq->len = min_t(size_t, subreq->len, rsize);
+#ifdef CONFIG_CIFS_SMB_DIRECT
+	if (server->smbd_conn)
+		subreq->max_nr_segs = server->smbd_conn->max_frmr_depth;
+#endif
+	return true;
+}
+
+/*
+ * Issue a read operation on behalf of the netfs helper functions.  We're asked
+ * to make a read of a certain size at a point in the file.  We are permitted
+ * to only read a portion of that, but as long as we read something, the netfs
+ * helper will call us again so that we can issue another read.
+ */
+static void cifs_req_issue_read(struct netfs_io_subrequest *subreq)
+{
+	struct netfs_io_request *rreq = subreq->rreq;
+	struct cifs_io_subrequest *rdata = container_of(subreq, struct cifs_io_subrequest, subreq);
+	struct cifs_io_request *req = container_of(subreq->rreq, struct cifs_io_request, rreq);
+	struct cifs_sb_info *cifs_sb = CIFS_SB(rreq->inode->i_sb);
+	pid_t pid;
+	int rc = 0;
+
+	if (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_RWPIDFORWARD)
+		pid = req->cfile->pid;
+	else
+		pid = current->tgid; // Ummm...  This may be a workqueue
+
+	cifs_dbg(FYI, "%s: op=%08x[%x] mapping=%p len=%zu/%zu\n",
+		 __func__, rreq->debug_id, subreq->debug_index, rreq->mapping,
+		 subreq->transferred, subreq->len);
+
+	if (req->cfile->invalidHandle) {
+		do {
+			rc = cifs_reopen_file(req->cfile, true);
+		} while (rc == -EAGAIN);
+		if (rc)
+			goto out;
+	}
+
+	__set_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags);
+	rdata->pid = pid;
+
+	rc = adjust_credits(rdata->server, &rdata->credits, rdata->subreq.len);
+	if (!rc) {
+		if (rdata->req->cfile->invalidHandle)
+			rc = -EAGAIN;
+		else
+			rc = rdata->server->ops->async_readv(rdata);
+	}
+
+out:
+	if (rc)
+		netfs_subreq_terminated(subreq, rc, false);
+}
+
+/*
+ * Writeback calls this when it finds a folio that needs uploading.  This isn't
+ * called if writeback only has copy-to-cache to deal with.
+ */
+static void cifs_begin_writeback(struct netfs_io_request *wreq)
+{
+	struct cifs_io_request *req = container_of(wreq, struct cifs_io_request, rreq);
+	int ret;
+
+	ret = cifs_get_writable_file(CIFS_I(wreq->inode), FIND_WR_ANY, &req->cfile);
+	if (ret) {
+		cifs_dbg(VFS, "No writable handle in writepages ret=%d\n", ret);
+		return;
+	}
+
+	wreq->io_streams[0].avail = true;
+}
+
+/*
+ * Initialise a request.
+ */
+static int cifs_init_request(struct netfs_io_request *rreq, struct file *file)
+{
+	struct cifs_io_request *req = container_of(rreq, struct cifs_io_request, rreq);
+	struct cifs_sb_info *cifs_sb = CIFS_SB(rreq->inode->i_sb);
+	struct cifsFileInfo *open_file = NULL;
+
+	rreq->rsize = cifs_sb->ctx->rsize;
+	rreq->wsize = cifs_sb->ctx->wsize;
+
+	if (file) {
+		open_file = file->private_data;
+		rreq->netfs_priv = file->private_data;
+		req->cfile = cifsFileInfo_get(open_file);
+	} else if (rreq->origin != NETFS_WRITEBACK) {
+		WARN_ON_ONCE(1);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+/*
+ * Expand the size of a readahead to the size of the rsize, if at least as
+ * large as a page, allowing for the possibility that rsize is not pow-2
+ * aligned.
+ */
+static void cifs_expand_readahead(struct netfs_io_request *rreq)
+{
+	unsigned int rsize = rreq->rsize;
+	loff_t misalignment, i_size = i_size_read(rreq->inode);
+
+	if (rsize < PAGE_SIZE)
+		return;
+
+	if (rsize < INT_MAX)
+		rsize = roundup_pow_of_two(rsize);
+	else
+		rsize = ((unsigned int)INT_MAX + 1) / 2;
+
+	misalignment = rreq->start & (rsize - 1);
+	if (misalignment) {
+		rreq->start -= misalignment;
+		rreq->len += misalignment;
+	}
+
+	rreq->len = round_up(rreq->len, rsize);
+	if (rreq->start < i_size && rreq->len > i_size - rreq->start)
+		rreq->len = i_size - rreq->start;
+}
+
+/*
+ * Completion of a request operation.
+ */
+static void cifs_rreq_done(struct netfs_io_request *rreq)
+{
+	struct timespec64 atime, mtime;
+	struct inode *inode = rreq->inode;
+
+	/* we do not want atime to be less than mtime, it broke some apps */
+	atime = inode_set_atime_to_ts(inode, current_time(inode));
+	mtime = inode_get_mtime(inode);
+	if (timespec64_compare(&atime, &mtime))
+		inode_set_atime_to_ts(inode, inode_get_mtime(inode));
+}
+
+static void cifs_post_modify(struct inode *inode)
+{
+	/* Indication to update ctime and mtime as close is deferred */
+	set_bit(CIFS_INO_MODIFIED_ATTR, &CIFS_I(inode)->flags);
+}
+
+static void cifs_free_request(struct netfs_io_request *rreq)
+{
+	struct cifs_io_request *req = container_of(rreq, struct cifs_io_request, rreq);
+
+	if (req->cfile)
+		cifsFileInfo_put(req->cfile);
+}
+
+static void cifs_free_subrequest(struct netfs_io_subrequest *subreq)
+{
+	struct cifs_io_subrequest *rdata =
+		container_of(subreq, struct cifs_io_subrequest, subreq);
+	int rc = subreq->error;
+
+	if (rdata->subreq.source == NETFS_DOWNLOAD_FROM_SERVER) {
+#ifdef CONFIG_CIFS_SMB_DIRECT
+		if (rdata->mr) {
+			smbd_deregister_mr(rdata->mr);
+			rdata->mr = NULL;
+		}
+#endif
+	}
+
+	add_credits_and_wake_if(rdata->server, &rdata->credits, 0);
+	if (rdata->have_xid)
+		free_xid(rdata->xid);
+}
+
+const struct netfs_request_ops cifs_req_ops = {
+	.request_pool		= &cifs_io_request_pool,
+	.subrequest_pool	= &cifs_io_subrequest_pool,
+	.init_request		= cifs_init_request,
+	.free_request		= cifs_free_request,
+	.free_subrequest	= cifs_free_subrequest,
+	.expand_readahead	= cifs_expand_readahead,
+	.clamp_length		= cifs_clamp_length,
+	.issue_read		= cifs_req_issue_read,
+	.done			= cifs_rreq_done,
+	.post_modify		= cifs_post_modify,
+	.begin_writeback	= cifs_begin_writeback,
+	.prepare_write		= cifs_prepare_write,
+	.issue_write		= cifs_issue_write,
+};
 
 /*
  * Remove the dirty flags from a span of pages.
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 298552f5122c..f45d06284f2f 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -302,6 +302,7 @@ struct netfs_request_ops {
 
 	/* Modification handling */
 	void (*update_i_size)(struct inode *inode, loff_t i_size);
+	void (*post_modify)(struct inode *inode);
 
 	/* Write request handling */
 	void (*begin_writeback)(struct netfs_io_request *wreq);
diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
index 4ba553a6d71b..da23484268df 100644
--- a/include/trace/events/netfs.h
+++ b/include/trace/events/netfs.h
@@ -112,6 +112,7 @@
 #define netfs_sreq_ref_traces					\
 	EM(netfs_sreq_trace_get_copy_to_cache,	"GET COPY2C ")	\
 	EM(netfs_sreq_trace_get_resubmit,	"GET RESUBMIT")	\
+	EM(netfs_sreq_trace_get_submit,		"GET SUBMIT")	\
 	EM(netfs_sreq_trace_get_short_read,	"GET SHORTRD")	\
 	EM(netfs_sreq_trace_new,		"NEW        ")	\
 	EM(netfs_sreq_trace_put_cancel,		"PUT CANCEL ")	\


