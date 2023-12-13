Return-Path: <linux-fsdevel+bounces-5962-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B1181180C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 16:47:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B11D91C20EE3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 15:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D3C59E24;
	Wed, 13 Dec 2023 15:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EWbRq7/m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09AC4185
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Dec 2023 07:42:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702482142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V6gpcKG498zCkLz3S9k9pj/To6fBBxeNZurJXCdyIx0=;
	b=EWbRq7/mO24R3/beynJOEQJpaQVu1EWnOn7KK4aSr0QZw79L9m1qis4F8No/RGbrmeRZwb
	zF9rEVU/KIcrU2kc23zoy7uoJosvOjeqxtcH68BBv4W3wuxw1W27Pad+l4J4dxHqrqezKk
	2VqVmEYK0YeVx81/pUPx6PY3iYfE6BQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-510-9JlAevd7Oz2Mc9aqiCprWQ-1; Wed, 13 Dec 2023 10:42:16 -0500
X-MC-Unique: 9JlAevd7Oz2Mc9aqiCprWQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5589D85A599;
	Wed, 13 Dec 2023 15:42:15 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.2])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 60CCF2026D66;
	Wed, 13 Dec 2023 15:42:12 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Jeff Layton <jlayton@kernel.org>,
	Steve French <smfrench@gmail.com>
Cc: David Howells <dhowells@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
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
	Steve French <sfrench@samba.org>,
	Shyam Prasad N <nspmangalore@gmail.com>,
	Rohith Surabattula <rohiths.msft@gmail.com>
Subject: [PATCH v4 08/13] cifs: Implement netfslib hooks
Date: Wed, 13 Dec 2023 15:41:34 +0000
Message-ID: <20231213154139.432922-9-dhowells@redhat.com>
In-Reply-To: <20231213154139.432922-1-dhowells@redhat.com>
References: <20231213154139.432922-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

Provide implementation of the netfslib hooks that will be used by netfslib
to ask cifs to set up and perform operations.  Of particular note are

 (*) cifs_clamp_length() - This is used to negotiate the size of the next
     subrequest in a read request, taking into account the credit available
     and the rsize.  The credits are attached to the subrequest.

 (*) cifs_req_issue_read() - This is used to issue a subrequest that has
     been set up and clamped.

 (*) cifs_create_write_requests() - This is used to break the given span of
     file positions into suboperations according to cifs's wsize and
     available credits.  As each subop is created, it can be dispatched or
     queued for dispatch.

At this point, cifs is not wired up to actually *use* netfslib; that will
be done in a subsequent patch.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Shyam Prasad N <nspmangalore@gmail.com>
cc: Rohith Surabattula <rohiths.msft@gmail.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cifs@vger.kernel.org
cc: linux-cachefs@redhat.com
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
---
 fs/netfs/buffered_write.c    |   3 +
 fs/smb/client/Kconfig        |   1 +
 fs/smb/client/cifsglob.h     |  26 ++-
 fs/smb/client/file.c         | 357 +++++++++++++++++++++++++++++++++++
 include/linux/netfs.h        |   1 +
 include/trace/events/netfs.h |   1 +
 6 files changed, 381 insertions(+), 8 deletions(-)

diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
index d7ce424b9188..587ed7a9bab2 100644
--- a/fs/netfs/buffered_write.c
+++ b/fs/netfs/buffered_write.c
@@ -377,6 +377,9 @@ ssize_t netfs_perform_write(struct kiocb *iocb, struct iov_iter *iter,
 	} while (iov_iter_count(iter));
 
 out:
+	if (likely(written) && ctx->ops->post_modify)
+		ctx->ops->post_modify(inode);
+
 	if (unlikely(wreq)) {
 		ret = netfs_end_writethrough(wreq, iocb);
 		wbc_detach_inode(&wbc);
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
diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index a0d348b166c2..7d17e515624f 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -1432,15 +1432,23 @@ struct cifs_aio_ctx {
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
+	bool				have_credits;
 	struct kvec			iov[2];
 	struct TCP_Server_Info		*server;
 #ifdef CONFIG_CIFS_SMB_DIRECT
@@ -1448,14 +1456,16 @@ struct cifs_io_subrequest {
 #endif
 	struct cifs_credits		credits;
 
-	enum writeback_sync_modes	sync_mode;
-	bool				uncached;
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
index b47abeefe628..255d78581e56 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -36,6 +36,363 @@
 #include "fs_context.h"
 #include "cifs_ioctl.h"
 #include "cached_dir.h"
+#include <trace/events/netfs.h>
+
+static int cifs_reopen_file(struct cifsFileInfo *cfile, bool can_flush);
+
+static void cifs_upload_to_server(struct netfs_io_subrequest *subreq)
+{
+	struct cifs_io_subrequest *wdata =
+		container_of(subreq, struct cifs_io_subrequest, subreq);
+	ssize_t rc;
+
+	trace_netfs_sreq(subreq, netfs_sreq_trace_submit);
+
+	if (wdata->req->cfile->invalidHandle)
+		rc = -EAGAIN;
+	else
+		rc = wdata->server->ops->async_writev(wdata);
+	if (rc < 0)
+		add_credits_and_wake_if(wdata->server, &wdata->credits, 0);
+}
+
+static void cifs_upload_to_server_worker(struct work_struct *work)
+{
+	struct netfs_io_subrequest *subreq =
+		container_of(work, struct netfs_io_subrequest, work);
+
+	cifs_upload_to_server(subreq);
+}
+
+/*
+ * Set up write requests for a writeback slice.  We need to add a write request
+ * for each write we want to make.
+ */
+static void cifs_create_write_requests(struct netfs_io_request *wreq,
+				       loff_t start, size_t remain)
+{
+	struct netfs_io_subrequest *subreq;
+	struct cifs_io_subrequest *wdata;
+	struct cifs_io_request *req = container_of(wreq, struct cifs_io_request, rreq);
+	struct TCP_Server_Info *server;
+	struct cifsFileInfo *open_file = req->cfile;
+	struct cifs_sb_info *cifs_sb = CIFS_SB(wreq->inode->i_sb);
+	int rc = 0;
+	size_t offset = 0;
+	pid_t pid;
+	unsigned int xid, max_segs = INT_MAX;
+
+	if (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_RWPIDFORWARD)
+		pid = open_file->pid;
+	else
+		pid = current->tgid;
+
+	server = cifs_pick_channel(tlink_tcon(open_file->tlink)->ses);
+	xid = get_xid();
+
+#ifdef CONFIG_CIFS_SMB_DIRECT
+	if (server->smbd_conn)
+		max_segs = server->smbd_conn->max_frmr_depth;
+#endif
+
+	do {
+		unsigned int nsegs = 0;
+		size_t max_len, part, wsize;
+
+		subreq = netfs_create_write_request(wreq, NETFS_UPLOAD_TO_SERVER,
+						    start, remain,
+						    cifs_upload_to_server_worker);
+		if (!subreq) {
+			wreq->error = -ENOMEM;
+			break;
+		}
+
+		wdata = container_of(subreq, struct cifs_io_subrequest, subreq);
+
+	retry:
+		if (signal_pending(current)) {
+			wreq->error = -EINTR;
+			break;
+		}
+
+		if (open_file->invalidHandle) {
+			rc = cifs_reopen_file(open_file, false);
+			if (rc < 0) {
+				if (rc == -EAGAIN)
+					goto retry;
+				break;
+			}
+		}
+
+		rc = server->ops->wait_mtu_credits(server, wreq->wsize, &wsize,
+						   &wdata->credits);
+		if (rc)
+			break;
+
+		max_len = min(remain, wsize);
+		if (!max_len) {
+			rc = -EAGAIN;
+			goto failed_return_credits;
+		}
+
+		part = netfs_limit_iter(&wreq->io_iter, offset, max_len, max_segs);
+		cifs_dbg(FYI, "create_write_request len=%zx/%zx nsegs=%u/%lu/%u\n",
+			 part, max_len, nsegs, wreq->io_iter.nr_segs, max_segs);
+		if (!part) {
+			rc = -EIO;
+			goto failed_return_credits;
+		}
+
+		if (part < wdata->subreq.len) {
+			wdata->subreq.len = part;
+			iov_iter_truncate(&wdata->subreq.io_iter, part);
+		}
+
+		wdata->server	= server;
+		wdata->pid	= pid;
+
+		rc = adjust_credits(server, &wdata->credits, wdata->subreq.len);
+		if (rc) {
+			add_credits_and_wake_if(server, &wdata->credits, 0);
+			if (rc == -EAGAIN)
+				goto retry;
+			goto failed;
+		}
+
+		cifs_upload_to_server(subreq);
+		//netfs_queue_write_request(subreq);
+		start += part;
+		offset += part;
+		remain -= part;
+	} while (remain > 0);
+
+	free_xid(xid);
+	return;
+
+failed_return_credits:
+	add_credits_and_wake_if(server, &wdata->credits, 0);
+failed:
+	netfs_write_subrequest_terminated(subreq, rc, false);
+	free_xid(xid);
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
+	rdata->have_credits = true;
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
+ * Initialise a request.
+ */
+static int cifs_init_request(struct netfs_io_request *rreq, struct file *file)
+{
+	struct cifs_io_request *req = container_of(rreq, struct cifs_io_request, rreq);
+	struct cifs_sb_info *cifs_sb = CIFS_SB(rreq->inode->i_sb);
+	struct cifsFileInfo *open_file = NULL;
+	int ret;
+
+	rreq->rsize = cifs_sb->ctx->rsize;
+	rreq->wsize = cifs_sb->ctx->wsize;
+
+	if (file) {
+		open_file = file->private_data;
+		rreq->netfs_priv = file->private_data;
+		req->cfile = cifsFileInfo_get(open_file);
+	} else if (rreq->origin == NETFS_WRITEBACK ||
+		   rreq->origin == NETFS_LAUNDER_WRITE) {
+		ret = cifs_get_writable_file(CIFS_I(rreq->inode), FIND_WR_ANY, &req->cfile);
+		if (ret) {
+			cifs_dbg(VFS, "No writable handle in writepages ret=%d\n", ret);
+			return ret;
+		}
+	} else {
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
+	int rc;
+
+	if (rdata->subreq.source == NETFS_DOWNLOAD_FROM_SERVER) {
+#ifdef CONFIG_CIFS_SMB_DIRECT
+		if (rdata->mr) {
+			smbd_deregister_mr(rdata->mr);
+			rdata->mr = NULL;
+		}
+#endif
+
+		if (rdata->have_credits)
+			add_credits_and_wake_if(rdata->server, &rdata->credits, 0);
+		rc = subreq->error;
+		free_xid(rdata->xid);
+	}
+}
+
+const struct netfs_request_ops cifs_req_ops = {
+	.io_request_size	= sizeof(struct cifs_io_request),
+	.io_subrequest_size	= sizeof(struct cifs_io_subrequest),
+	.init_request		= cifs_init_request,
+	.free_request		= cifs_free_request,
+	.free_subrequest	= cifs_free_subrequest,
+	.expand_readahead	= cifs_expand_readahead,
+	.clamp_length		= cifs_clamp_length,
+	.issue_read		= cifs_req_issue_read,
+	.done			= cifs_rreq_done,
+	.post_modify		= cifs_post_modify,
+	.create_write_requests	= cifs_create_write_requests,
+};
 
 /*
  * Remove the dirty flags from a span of pages.
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index c927df141385..7e509ad022bd 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -314,6 +314,7 @@ struct netfs_request_ops {
 
 	/* Modification handling */
 	void (*update_i_size)(struct inode *inode, loff_t i_size);
+	void (*post_modify)(struct inode *inode);
 
 	/* Write request handling */
 	void (*create_write_requests)(struct netfs_io_request *wreq,
diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
index 447a8c21cf57..06567b5be8fa 100644
--- a/include/trace/events/netfs.h
+++ b/include/trace/events/netfs.h
@@ -101,6 +101,7 @@
 #define netfs_sreq_ref_traces					\
 	EM(netfs_sreq_trace_get_copy_to_cache,	"GET COPY2C ")	\
 	EM(netfs_sreq_trace_get_resubmit,	"GET RESUBMIT")	\
+	EM(netfs_sreq_trace_get_submit,		"GET SUBMIT")	\
 	EM(netfs_sreq_trace_get_short_read,	"GET SHORTRD")	\
 	EM(netfs_sreq_trace_new,		"NEW        ")	\
 	EM(netfs_sreq_trace_put_clear,		"PUT CLEAR  ")	\


