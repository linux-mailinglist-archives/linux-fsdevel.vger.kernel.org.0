Return-Path: <linux-fsdevel+bounces-321-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B377C8A22
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Oct 2023 18:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 882931C21236
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Oct 2023 16:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8DBB20B0B;
	Fri, 13 Oct 2023 16:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CXCtTP2G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FBF208DA
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Oct 2023 16:10:12 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A80E46B4
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Oct 2023 09:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697213251;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V1ekZfokfT2Ugeza4zvLRbCUR99VZ8ojUeQjipxYgqg=;
	b=CXCtTP2GdP3L+KD3ZrCTng9plgrSo+euEylXC8k90qkltU2/2FY/bVBmjYXupnlJ/XEG/A
	GGmejBz3aHiZ3a+q8Mf870eQYdHXKCGhpV9oQFxIxxqm6AfxqNe2Kc3iZGn+ow8sJ8kjgR
	YOBt0oekUUpagjMs2lUM3QFsxrSxUcI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-93-WFdRDarRNVaGT3xJaXJzAA-1; Fri, 13 Oct 2023 12:07:25 -0400
X-MC-Unique: WFdRDarRNVaGT3xJaXJzAA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 443502810D4A;
	Fri, 13 Oct 2023 16:07:24 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.226])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1B29F40C6CA0;
	Fri, 13 Oct 2023 16:07:21 +0000 (UTC)
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
	Ilya Dryomov <idryomov@gmail.com>,
	Christian Brauner <christian@brauner.io>,
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
	Rohith Surabattula <rohiths.msft@gmail.com>,
	linux-cachefs@redhat.com
Subject: [RFC PATCH 50/53] cifs: Cut over to using netfslib
Date: Fri, 13 Oct 2023 17:04:19 +0100
Message-ID: <20231013160423.2218093-51-dhowells@redhat.com>
In-Reply-To: <20231013160423.2218093-1-dhowells@redhat.com>
References: <20231013160423.2218093-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Make the cifs filesystem use netfslib to handle reading and writing on
behalf of cifs.  The changes include:

 (1) Various read_iter/write_iter type functions are turned into wrappers
     around netfslib API functions or are pointed directly at those
     functions:

	cifs_file_direct{,_nobrl}_ops switch to use
	netfs_unbuffered_read_iter and netfs_unbuffered_write_iter.

Large pieces of code that will be removed are #if'd out and will be removed
in subsequent patches.

[?] Why does cifs mark the page dirty in the destination buffer of a DIO
    read?  Should that happen automatically?  Does netfs need to do that?

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
 fs/netfs/io.c             |   7 +-
 fs/smb/client/cifsfs.c    |   8 +--
 fs/smb/client/cifsfs.h    |   8 +--
 fs/smb/client/cifsglob.h  |   3 +-
 fs/smb/client/cifsproto.h |   4 ++
 fs/smb/client/cifssmb.c   |  45 +++++++-----
 fs/smb/client/file.c      | 130 ++++++++++++++++++----------------
 fs/smb/client/fscache.c   |   2 +
 fs/smb/client/fscache.h   |   4 ++
 fs/smb/client/inode.c     |  19 ++++-
 fs/smb/client/smb2pdu.c   |  98 ++++++++++++++++----------
 fs/smb/client/trace.h     | 144 +++++++++++++++++++++++++++++++++-----
 fs/smb/client/transport.c |   3 +
 13 files changed, 326 insertions(+), 149 deletions(-)

diff --git a/fs/netfs/io.c b/fs/netfs/io.c
index 14a9f3312d3b..112fa0548f22 100644
--- a/fs/netfs/io.c
+++ b/fs/netfs/io.c
@@ -351,8 +351,13 @@ static void netfs_rreq_assess_dio(struct netfs_io_request *rreq)
 	unsigned int i;
 	size_t transferred = 0;
 
-	for (i = 0; i < rreq->direct_bv_count; i++)
+	for (i = 0; i < rreq->direct_bv_count; i++) {
 		flush_dcache_page(rreq->direct_bv[i].bv_page);
+		// TODO: cifs marks pages in the destination buffer
+		// dirty under some circumstances after a read.  Do we
+		// need to do that too?
+		set_page_dirty(rreq->direct_bv[i].bv_page);
+	}
 
 	list_for_each_entry(subreq, &rreq->subrequests, rreq_link) {
 		if (subreq->error || subreq->transferred == 0)
diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
index 0c19b65206f6..26b6ea9eb53e 100644
--- a/fs/smb/client/cifsfs.c
+++ b/fs/smb/client/cifsfs.c
@@ -1352,8 +1352,8 @@ const struct file_operations cifs_file_strict_ops = {
 };
 
 const struct file_operations cifs_file_direct_ops = {
-	.read_iter = cifs_direct_readv,
-	.write_iter = cifs_direct_writev,
+	.read_iter = netfs_unbuffered_read_iter,
+	.write_iter = netfs_file_write_iter,
 	.open = cifs_open,
 	.release = cifs_close,
 	.lock = cifs_lock,
@@ -1408,8 +1408,8 @@ const struct file_operations cifs_file_strict_nobrl_ops = {
 };
 
 const struct file_operations cifs_file_direct_nobrl_ops = {
-	.read_iter = cifs_direct_readv,
-	.write_iter = cifs_direct_writev,
+	.read_iter = netfs_unbuffered_read_iter,
+	.write_iter = netfs_file_write_iter,
 	.open = cifs_open,
 	.release = cifs_close,
 	.fsync = cifs_fsync,
diff --git a/fs/smb/client/cifsfs.h b/fs/smb/client/cifsfs.h
index 24d5bac07f87..6bbb26a462db 100644
--- a/fs/smb/client/cifsfs.h
+++ b/fs/smb/client/cifsfs.h
@@ -85,6 +85,7 @@ extern const struct inode_operations cifs_namespace_inode_operations;
 
 
 /* Functions related to files and directories */
+extern const struct netfs_request_ops cifs_req_ops;
 extern const struct file_operations cifs_file_ops;
 extern const struct file_operations cifs_file_direct_ops; /* if directio mnt */
 extern const struct file_operations cifs_file_strict_ops; /* if strictio mnt */
@@ -94,11 +95,7 @@ extern const struct file_operations cifs_file_strict_nobrl_ops;
 extern int cifs_open(struct inode *inode, struct file *file);
 extern int cifs_close(struct inode *inode, struct file *file);
 extern int cifs_closedir(struct inode *inode, struct file *file);
-extern ssize_t cifs_user_readv(struct kiocb *iocb, struct iov_iter *to);
-extern ssize_t cifs_direct_readv(struct kiocb *iocb, struct iov_iter *to);
 extern ssize_t cifs_strict_readv(struct kiocb *iocb, struct iov_iter *to);
-extern ssize_t cifs_user_writev(struct kiocb *iocb, struct iov_iter *from);
-extern ssize_t cifs_direct_writev(struct kiocb *iocb, struct iov_iter *from);
 extern ssize_t cifs_strict_writev(struct kiocb *iocb, struct iov_iter *from);
 ssize_t cifs_file_write_iter(struct kiocb *iocb, struct iov_iter *from);
 ssize_t cifs_loose_read_iter(struct kiocb *iocb, struct iov_iter *iter);
@@ -112,9 +109,6 @@ extern int cifs_file_strict_mmap(struct file *file, struct vm_area_struct *vma);
 extern const struct file_operations cifs_dir_ops;
 extern int cifs_dir_open(struct inode *inode, struct file *file);
 extern int cifs_readdir(struct file *file, struct dir_context *ctx);
-extern void cifs_pages_written_back(struct inode *inode, loff_t start, unsigned int len);
-extern void cifs_pages_write_failed(struct inode *inode, loff_t start, unsigned int len);
-extern void cifs_pages_write_redirty(struct inode *inode, loff_t start, unsigned int len);
 
 /* Functions related to dir entries */
 extern const struct dentry_operations cifs_dentry_ops;
diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index a215c092725a..a5e114eeeb8b 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -1444,7 +1444,7 @@ struct cifs_io_subrequest {
 #endif
 	struct cifs_credits		credits;
 
-	// TODO: Remove following elements
+#if 0 // TODO: Remove following elements
 	struct list_head		list;
 	struct completion		done;
 	struct work_struct		work;
@@ -1454,6 +1454,7 @@ struct cifs_io_subrequest {
 	enum writeback_sync_modes	sync_mode;
 	bool				uncached;
 	struct bio_vec			*bv;
+#endif
 };
 
 /*
diff --git a/fs/smb/client/cifsproto.h b/fs/smb/client/cifsproto.h
index 735337e8326c..52ff5e889af2 100644
--- a/fs/smb/client/cifsproto.h
+++ b/fs/smb/client/cifsproto.h
@@ -580,17 +580,20 @@ void __cifs_put_smb_ses(struct cifs_ses *ses);
 extern struct cifs_ses *
 cifs_get_smb_ses(struct TCP_Server_Info *server, struct smb3_fs_context *ctx);
 
+#if 0 // TODO Remove
 void cifs_readdata_release(struct cifs_io_subrequest *rdata);
 static inline void cifs_put_readdata(struct cifs_io_subrequest *rdata)
 {
 	if (refcount_dec_and_test(&rdata->subreq.ref))
 		cifs_readdata_release(rdata);
 }
+#endif
 int cifs_async_readv(struct cifs_io_subrequest *rdata);
 int cifs_readv_receive(struct TCP_Server_Info *server, struct mid_q_entry *mid);
 
 int cifs_async_writev(struct cifs_io_subrequest *wdata);
 void cifs_writev_complete(struct work_struct *work);
+#if 0 // TODO Remove
 struct cifs_io_subrequest *cifs_writedata_alloc(work_func_t complete);
 void cifs_writedata_release(struct cifs_io_subrequest *rdata);
 static inline void cifs_get_writedata(struct cifs_io_subrequest *wdata)
@@ -602,6 +605,7 @@ static inline void cifs_put_writedata(struct cifs_io_subrequest *wdata)
 	if (refcount_dec_and_test(&wdata->subreq.ref))
 		cifs_writedata_release(wdata);
 }
+#endif
 int cifs_query_mf_symlink(unsigned int xid, struct cifs_tcon *tcon,
 			  struct cifs_sb_info *cifs_sb,
 			  const unsigned char *path, char *pbuf,
diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
index 112a5a2d95b8..722f1dd884de 100644
--- a/fs/smb/client/cifssmb.c
+++ b/fs/smb/client/cifssmb.c
@@ -1263,7 +1263,7 @@ static void
 cifs_readv_callback(struct mid_q_entry *mid)
 {
 	struct cifs_io_subrequest *rdata = mid->callback_data;
-	struct cifs_tcon *tcon = tlink_tcon(rdata->cfile->tlink);
+	struct cifs_tcon *tcon = tlink_tcon(rdata->req->cfile->tlink);
 	struct TCP_Server_Info *server = tcon->ses->server;
 	struct smb_rqst rqst = { .rq_iov = rdata->iov,
 				 .rq_nvec = 2,
@@ -1304,7 +1304,12 @@ cifs_readv_callback(struct mid_q_entry *mid)
 		rdata->result = -EIO;
 	}
 
-	queue_work(cifsiod_wq, &rdata->work);
+	if (rdata->result == 0 || rdata->result == -EAGAIN)
+		iov_iter_advance(&rdata->subreq.io_iter, rdata->got_bytes);
+	netfs_subreq_terminated(&rdata->subreq,
+				(rdata->result == 0 || rdata->result == -EAGAIN) ?
+				rdata->got_bytes : rdata->result,
+				false);
 	release_mid(mid);
 	add_credits(server, &credits, 0);
 }
@@ -1316,7 +1321,7 @@ cifs_async_readv(struct cifs_io_subrequest *rdata)
 	int rc;
 	READ_REQ *smb = NULL;
 	int wct;
-	struct cifs_tcon *tcon = tlink_tcon(rdata->cfile->tlink);
+	struct cifs_tcon *tcon = tlink_tcon(rdata->req->cfile->tlink);
 	struct smb_rqst rqst = { .rq_iov = rdata->iov,
 				 .rq_nvec = 2 };
 
@@ -1341,7 +1346,7 @@ cifs_async_readv(struct cifs_io_subrequest *rdata)
 	smb->hdr.PidHigh = cpu_to_le16((__u16)(rdata->pid >> 16));
 
 	smb->AndXCommand = 0xFF;	/* none */
-	smb->Fid = rdata->cfile->fid.netfid;
+	smb->Fid = rdata->req->cfile->fid.netfid;
 	smb->OffsetLow = cpu_to_le32(rdata->subreq.start & 0xFFFFFFFF);
 	if (wct == 12)
 		smb->OffsetHigh = cpu_to_le32(rdata->subreq.start >> 32);
@@ -1611,15 +1616,16 @@ static void
 cifs_writev_callback(struct mid_q_entry *mid)
 {
 	struct cifs_io_subrequest *wdata = mid->callback_data;
-	struct cifs_tcon *tcon = tlink_tcon(wdata->cfile->tlink);
-	unsigned int written;
+	struct cifs_tcon *tcon = tlink_tcon(wdata->req->cfile->tlink);
 	WRITE_RSP *smb = (WRITE_RSP *)mid->resp_buf;
 	struct cifs_credits credits = { .value = 1, .instance = 0 };
+	ssize_t result;
+	size_t written;
 
 	switch (mid->mid_state) {
 	case MID_RESPONSE_RECEIVED:
-		wdata->result = cifs_check_receive(mid, tcon->ses->server, 0);
-		if (wdata->result != 0)
+		result = cifs_check_receive(mid, tcon->ses->server, 0);
+		if (result != 0)
 			break;
 
 		written = le16_to_cpu(smb->CountHigh);
@@ -1635,20 +1641,20 @@ cifs_writev_callback(struct mid_q_entry *mid)
 			written &= 0xFFFF;
 
 		if (written < wdata->subreq.len)
-			wdata->result = -ENOSPC;
+			result = -ENOSPC;
 		else
-			wdata->subreq.len = written;
+			result = written;
 		break;
 	case MID_REQUEST_SUBMITTED:
 	case MID_RETRY_NEEDED:
-		wdata->result = -EAGAIN;
+		result = -EAGAIN;
 		break;
 	default:
-		wdata->result = -EIO;
+		result = -EIO;
 		break;
 	}
 
-	queue_work(cifsiod_wq, &wdata->work);
+	netfs_write_subrequest_terminated(&wdata->subreq, result, true);
 	release_mid(mid);
 	add_credits(tcon->ses->server, &credits, 0);
 }
@@ -1660,7 +1666,7 @@ cifs_async_writev(struct cifs_io_subrequest *wdata)
 	int rc = -EACCES;
 	WRITE_REQ *smb = NULL;
 	int wct;
-	struct cifs_tcon *tcon = tlink_tcon(wdata->cfile->tlink);
+	struct cifs_tcon *tcon = tlink_tcon(wdata->req->cfile->tlink);
 	struct kvec iov[2];
 	struct smb_rqst rqst = { };
 
@@ -1670,7 +1676,8 @@ cifs_async_writev(struct cifs_io_subrequest *wdata)
 		wct = 12;
 		if (wdata->subreq.start >> 32 > 0) {
 			/* can not handle big offset for old srv */
-			return -EIO;
+			rc = -EIO;
+			goto out;
 		}
 	}
 
@@ -1682,7 +1689,7 @@ cifs_async_writev(struct cifs_io_subrequest *wdata)
 	smb->hdr.PidHigh = cpu_to_le16((__u16)(wdata->pid >> 16));
 
 	smb->AndXCommand = 0xFF;	/* none */
-	smb->Fid = wdata->cfile->fid.netfid;
+	smb->Fid = wdata->req->cfile->fid.netfid;
 	smb->OffsetLow = cpu_to_le32(wdata->subreq.start & 0xFFFFFFFF);
 	if (wct == 14)
 		smb->OffsetHigh = cpu_to_le32(wdata->subreq.start >> 32);
@@ -1722,17 +1729,17 @@ cifs_async_writev(struct cifs_io_subrequest *wdata)
 		iov[1].iov_len += 4; /* pad bigger by four bytes */
 	}
 
-	cifs_get_writedata(wdata);
 	rc = cifs_call_async(tcon->ses->server, &rqst, NULL,
 			     cifs_writev_callback, NULL, wdata, 0, NULL);
 
 	if (rc == 0)
 		cifs_stats_inc(&tcon->stats.cifs_stats.num_writes);
-	else
-		cifs_put_writedata(wdata);
 
 async_writev_out:
 	cifs_small_buf_release(smb);
+out:
+	if (rc)
+		netfs_write_subrequest_terminated(&wdata->subreq, rc, false);
 	return rc;
 }
 
diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index 3112233c4835..4c9125a98d18 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -22,6 +22,7 @@
 #include <linux/slab.h>
 #include <linux/swap.h>
 #include <linux/mm.h>
+#include <linux/netfs.h>
 #include <asm/div64.h>
 #include "cifsfs.h"
 #include "cifspdu.h"
@@ -410,6 +411,7 @@ const struct netfs_request_ops cifs_req_ops = {
 	.create_write_requests	= cifs_create_write_requests,
 };
 
+#if 0 // TODO remove 397
 /*
  * Remove the dirty flags from a span of pages.
  */
@@ -534,6 +536,7 @@ void cifs_pages_write_redirty(struct inode *inode, loff_t start, unsigned int le
 
 	rcu_read_unlock();
 }
+#endif // end netfslib remove 397
 
 /*
  * Mark as invalid, all open files on tree connections since they
@@ -2494,6 +2497,7 @@ cifs_update_eof(struct cifsInodeInfo *cifsi, loff_t offset,
 		netfs_resize_file(&cifsi->netfs, end_of_write);
 }
 
+#if 0 // TODO remove 2483
 static ssize_t
 cifs_write(struct cifsFileInfo *open_file, __u32 pid, const char *write_data,
 	   size_t write_size, loff_t *offset)
@@ -2577,6 +2581,7 @@ cifs_write(struct cifsFileInfo *open_file, __u32 pid, const char *write_data,
 	free_xid(xid);
 	return total_written;
 }
+#endif // end netfslib remove 2483
 
 struct cifsFileInfo *find_readable_file(struct cifsInodeInfo *cifs_inode,
 					bool fsuid_only)
@@ -2782,6 +2787,7 @@ cifs_get_readable_path(struct cifs_tcon *tcon, const char *name,
 	return -ENOENT;
 }
 
+#if 0 // TODO remove 2773
 void
 cifs_writedata_release(struct cifs_io_subrequest *wdata)
 {
@@ -3474,7 +3480,11 @@ static int cifs_write_end(struct file *file, struct address_space *mapping,
 
 	return rc;
 }
+#endif // End netfs removal 2773
 
+/*
+ * Flush data on a strict file.
+ */
 int cifs_strict_fsync(struct file *file, loff_t start, loff_t end,
 		      int datasync)
 {
@@ -3529,6 +3539,9 @@ int cifs_strict_fsync(struct file *file, loff_t start, loff_t end,
 	return rc;
 }
 
+/*
+ * Flush data on a non-strict data.
+ */
 int cifs_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 {
 	unsigned int xid;
@@ -3595,6 +3608,7 @@ int cifs_flush(struct file *file, fl_owner_t id)
 	return rc;
 }
 
+#if 0 // TODO remove 3594
 static void collect_uncached_write_data(struct cifs_aio_ctx *ctx);
 
 static void
@@ -4056,6 +4070,7 @@ ssize_t cifs_user_writev(struct kiocb *iocb, struct iov_iter *from)
 {
 	return __cifs_writev(iocb, from, false);
 }
+#endif // TODO remove 3594
 
 static ssize_t
 cifs_writev(struct kiocb *iocb, struct iov_iter *from)
@@ -4067,7 +4082,10 @@ cifs_writev(struct kiocb *iocb, struct iov_iter *from)
 	struct TCP_Server_Info *server = tlink_tcon(cfile->tlink)->ses->server;
 	ssize_t rc;
 
-	inode_lock(inode);
+	rc = netfs_start_io_write(inode);
+	if (rc < 0)
+		return rc;
+
 	/*
 	 * We need to hold the sem to be sure nobody modifies lock list
 	 * with a brlock that prevents writing.
@@ -4081,13 +4099,12 @@ cifs_writev(struct kiocb *iocb, struct iov_iter *from)
 	if (!cifs_find_lock_conflict(cfile, iocb->ki_pos, iov_iter_count(from),
 				     server->vals->exclusive_lock_type, 0,
 				     NULL, CIFS_WRITE_OP))
-		rc = __generic_file_write_iter(iocb, from);
+		rc = netfs_buffered_write_iter_locked(iocb, from, NULL);
 	else
 		rc = -EACCES;
 out:
 	up_read(&cinode->lock_sem);
-	inode_unlock(inode);
-
+	netfs_end_io_write(inode);
 	if (rc > 0)
 		rc = generic_write_sync(iocb, rc);
 	return rc;
@@ -4110,9 +4127,9 @@ cifs_strict_writev(struct kiocb *iocb, struct iov_iter *from)
 
 	if (CIFS_CACHE_WRITE(cinode)) {
 		if (cap_unix(tcon->ses) &&
-		(CIFS_UNIX_FCNTL_CAP & le64_to_cpu(tcon->fsUnixInfo.Capability))
-		  && ((cifs_sb->mnt_cifs_flags & CIFS_MOUNT_NOPOSIXBRL) == 0)) {
-			written = generic_file_write_iter(iocb, from);
+		    (CIFS_UNIX_FCNTL_CAP & le64_to_cpu(tcon->fsUnixInfo.Capability)) &&
+		    ((cifs_sb->mnt_cifs_flags & CIFS_MOUNT_NOPOSIXBRL) == 0)) {
+			written = netfs_file_write_iter(iocb, from);
 			goto out;
 		}
 		written = cifs_writev(iocb, from);
@@ -4124,7 +4141,7 @@ cifs_strict_writev(struct kiocb *iocb, struct iov_iter *from)
 	 * affected pages because it may cause a error with mandatory locks on
 	 * these pages but not on the region from pos to ppos+len-1.
 	 */
-	written = cifs_user_writev(iocb, from);
+	written = netfs_file_write_iter(iocb, from);
 	if (CIFS_CACHE_READ(cinode)) {
 		/*
 		 * We have read level caching and we have just sent a write
@@ -4143,6 +4160,7 @@ cifs_strict_writev(struct kiocb *iocb, struct iov_iter *from)
 	return written;
 }
 
+#if 0 // TODO remove 4143
 static struct cifs_io_subrequest *cifs_readdata_alloc(work_func_t complete)
 {
 	struct cifs_io_subrequest *rdata;
@@ -4582,7 +4600,9 @@ ssize_t cifs_direct_readv(struct kiocb *iocb, struct iov_iter *to)
 ssize_t cifs_user_readv(struct kiocb *iocb, struct iov_iter *to)
 {
 	return __cifs_readv(iocb, to, false);
+
 }
+#endif // end netfslib removal 4143
 
 ssize_t cifs_loose_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 {
@@ -4590,13 +4610,13 @@ ssize_t cifs_loose_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 	struct inode *inode = file_inode(iocb->ki_filp);
 
 	if (iocb->ki_flags & IOCB_DIRECT)
-		return cifs_user_readv(iocb, iter);
+		return netfs_unbuffered_read_iter(iocb, iter);
 
 	rc = cifs_revalidate_mapping(inode);
 	if (rc)
 		return rc;
 
-	return generic_file_read_iter(iocb, iter);
+	return netfs_file_read_iter(iocb, iter);
 }
 
 ssize_t cifs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
@@ -4607,7 +4627,7 @@ ssize_t cifs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	int rc;
 
 	if (iocb->ki_filp->f_flags & O_DIRECT) {
-		written = cifs_user_writev(iocb, from);
+		written = netfs_unbuffered_write_iter(iocb, from);
 		if (written > 0 && CIFS_CACHE_READ(cinode)) {
 			cifs_zap_mapping(inode);
 			cifs_dbg(FYI,
@@ -4622,17 +4642,15 @@ ssize_t cifs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	if (written)
 		return written;
 
-	written = generic_file_write_iter(iocb, from);
-
-	if (CIFS_CACHE_WRITE(CIFS_I(inode)))
-		goto out;
+	written = netfs_file_write_iter(iocb, from);
 
-	rc = filemap_fdatawrite(inode->i_mapping);
-	if (rc)
-		cifs_dbg(FYI, "cifs_file_write_iter: %d rc on %p inode\n",
-			 rc, inode);
+	if (!CIFS_CACHE_WRITE(CIFS_I(inode))) {
+		rc = filemap_fdatawrite(inode->i_mapping);
+		if (rc)
+			cifs_dbg(FYI, "cifs_file_write_iter: %d rc on %p inode\n",
+				 rc, inode);
+	}
 
-out:
 	cifs_put_writer(cinode);
 	return written;
 }
@@ -4657,12 +4675,15 @@ cifs_strict_readv(struct kiocb *iocb, struct iov_iter *to)
 	 * pos+len-1.
 	 */
 	if (!CIFS_CACHE_READ(cinode))
-		return cifs_user_readv(iocb, to);
+		return netfs_unbuffered_read_iter(iocb, to);
 
 	if (cap_unix(tcon->ses) &&
 	    (CIFS_UNIX_FCNTL_CAP & le64_to_cpu(tcon->fsUnixInfo.Capability)) &&
-	    ((cifs_sb->mnt_cifs_flags & CIFS_MOUNT_NOPOSIXBRL) == 0))
+	    ((cifs_sb->mnt_cifs_flags & CIFS_MOUNT_NOPOSIXBRL) == 0)) {
+		if (iocb->ki_flags & IOCB_DIRECT)
+			return netfs_unbuffered_read_iter(iocb, to);
 		return generic_file_read_iter(iocb, to);
+	}
 
 	/*
 	 * We need to hold the sem to be sure nobody modifies lock list
@@ -4671,12 +4692,17 @@ cifs_strict_readv(struct kiocb *iocb, struct iov_iter *to)
 	down_read(&cinode->lock_sem);
 	if (!cifs_find_lock_conflict(cfile, iocb->ki_pos, iov_iter_count(to),
 				     tcon->ses->server->vals->shared_lock_type,
-				     0, NULL, CIFS_READ_OP))
-		rc = generic_file_read_iter(iocb, to);
+				     0, NULL, CIFS_READ_OP)) {
+		if (iocb->ki_flags & IOCB_DIRECT)
+			rc = netfs_unbuffered_read_iter(iocb, to);
+		else
+			rc = generic_file_read_iter(iocb, to);
+	}
 	up_read(&cinode->lock_sem);
 	return rc;
 }
 
+#if 0 // TODO remove 4633
 static ssize_t
 cifs_read(struct file *file, char *read_data, size_t read_size, loff_t *offset)
 {
@@ -4768,29 +4794,11 @@ cifs_read(struct file *file, char *read_data, size_t read_size, loff_t *offset)
 	free_xid(xid);
 	return total_read;
 }
+#endif // end netfslib remove 4633
 
-/*
- * If the page is mmap'ed into a process' page tables, then we need to make
- * sure that it doesn't change while being written back.
- */
 static vm_fault_t cifs_page_mkwrite(struct vm_fault *vmf)
 {
-	struct folio *folio = page_folio(vmf->page);
-
-	/* Wait for the folio to be written to the cache before we allow it to
-	 * be modified.  We then assume the entire folio will need writing back.
-	 */
-#ifdef CONFIG_CIFS_FSCACHE
-	if (folio_test_fscache(folio) &&
-	    folio_wait_fscache_killable(folio) < 0)
-		return VM_FAULT_RETRY;
-#endif
-
-	folio_wait_writeback(folio);
-
-	if (folio_lock_killable(folio) < 0)
-		return VM_FAULT_RETRY;
-	return VM_FAULT_LOCKED;
+	return netfs_page_mkwrite(vmf, NULL);
 }
 
 static const struct vm_operations_struct cifs_file_vm_ops = {
@@ -4836,6 +4844,7 @@ int cifs_file_mmap(struct file *file, struct vm_area_struct *vma)
 	return rc;
 }
 
+#if 0 // TODO remove 4794
 /*
  * Unlock a bunch of folios in the pagecache.
  */
@@ -5119,6 +5128,7 @@ static int cifs_read_folio(struct file *file, struct folio *folio)
 	free_xid(xid);
 	return rc;
 }
+#endif // end netfslib remove 4794
 
 static int is_inode_writable(struct cifsInodeInfo *cifs_inode)
 {
@@ -5165,6 +5175,7 @@ bool is_size_safe_to_change(struct cifsInodeInfo *cifsInode, __u64 end_of_file)
 		return true;
 }
 
+#if 0 // TODO remove 5152
 static int cifs_write_begin(struct file *file, struct address_space *mapping,
 			loff_t pos, unsigned len,
 			struct page **pagep, void **fsdata)
@@ -5281,6 +5292,7 @@ static int cifs_launder_folio(struct folio *folio)
 	folio_wait_fscache(folio);
 	return rc;
 }
+#endif // end netfslib remove 5152
 
 void cifs_oplock_break(struct work_struct *work)
 {
@@ -5371,6 +5383,7 @@ void cifs_oplock_break(struct work_struct *work)
 	cifs_done_oplock_break(cinode);
 }
 
+#if 0 // TODO remove 5333
 /*
  * The presence of cifs_direct_io() in the address space ops vector
  * allowes open() O_DIRECT flags which would have failed otherwise.
@@ -5389,6 +5402,7 @@ cifs_direct_io(struct kiocb *iocb, struct iov_iter *iter)
          */
         return -EINVAL;
 }
+#endif // netfs end remove 5333
 
 static int cifs_swap_activate(struct swap_info_struct *sis,
 			      struct file *swap_file, sector_t *span)
@@ -5465,16 +5479,14 @@ static bool cifs_dirty_folio(struct address_space *mapping, struct folio *folio)
 #endif
 
 const struct address_space_operations cifs_addr_ops = {
-	.read_folio = cifs_read_folio,
-	.readahead = cifs_readahead,
-	.writepages = cifs_writepages,
-	.write_begin = cifs_write_begin,
-	.write_end = cifs_write_end,
+	.read_folio = netfs_read_folio,
+	.readahead = netfs_readahead,
+	.writepages = netfs_writepages,
 	.dirty_folio = cifs_dirty_folio,
-	.release_folio = cifs_release_folio,
-	.direct_IO = cifs_direct_io,
-	.invalidate_folio = cifs_invalidate_folio,
-	.launder_folio = cifs_launder_folio,
+	.release_folio = netfs_release_folio,
+	.direct_IO = noop_direct_IO,
+	.invalidate_folio = netfs_invalidate_folio,
+	.launder_folio = netfs_launder_folio,
 	.migrate_folio = filemap_migrate_folio,
 	/*
 	 * TODO: investigate and if useful we could add an is_dirty_writeback
@@ -5490,13 +5502,11 @@ const struct address_space_operations cifs_addr_ops = {
  * to leave cifs_readahead out of the address space operations.
  */
 const struct address_space_operations cifs_addr_ops_smallbuf = {
-	.read_folio = cifs_read_folio,
-	.writepages = cifs_writepages,
-	.write_begin = cifs_write_begin,
-	.write_end = cifs_write_end,
+	.read_folio = netfs_read_folio,
+	.writepages = netfs_writepages,
 	.dirty_folio = cifs_dirty_folio,
-	.release_folio = cifs_release_folio,
-	.invalidate_folio = cifs_invalidate_folio,
-	.launder_folio = cifs_launder_folio,
+	.release_folio = netfs_release_folio,
+	.invalidate_folio = netfs_invalidate_folio,
+	.launder_folio = netfs_launder_folio,
 	.migrate_folio = filemap_migrate_folio,
 };
diff --git a/fs/smb/client/fscache.c b/fs/smb/client/fscache.c
index e5cad149f5a2..e4cb0938fb15 100644
--- a/fs/smb/client/fscache.c
+++ b/fs/smb/client/fscache.c
@@ -137,6 +137,7 @@ void cifs_fscache_release_inode_cookie(struct inode *inode)
 	}
 }
 
+#if 0 // TODO remove
 /*
  * Fallback page reading interface.
  */
@@ -245,3 +246,4 @@ int __cifs_fscache_query_occupancy(struct inode *inode,
 	fscache_end_operation(&cres);
 	return ret;
 }
+#endif
diff --git a/fs/smb/client/fscache.h b/fs/smb/client/fscache.h
index 84f3b09367d2..7308efeb2d89 100644
--- a/fs/smb/client/fscache.h
+++ b/fs/smb/client/fscache.h
@@ -74,6 +74,7 @@ static inline void cifs_invalidate_cache(struct inode *inode, unsigned int flags
 			   i_size_read(inode), flags);
 }
 
+#if 0 // TODO remove
 extern int __cifs_fscache_query_occupancy(struct inode *inode,
 					  pgoff_t first, unsigned int nr_pages,
 					  pgoff_t *_data_first,
@@ -108,6 +109,7 @@ static inline void cifs_readahead_to_fscache(struct inode *inode,
 	if (cifs_inode_cookie(inode))
 		__cifs_readahead_to_fscache(inode, pos, len);
 }
+#endif
 
 #else /* CONFIG_CIFS_FSCACHE */
 static inline
@@ -125,6 +127,7 @@ static inline void cifs_fscache_unuse_inode_cookie(struct inode *inode, bool upd
 static inline struct fscache_cookie *cifs_inode_cookie(struct inode *inode) { return NULL; }
 static inline void cifs_invalidate_cache(struct inode *inode, unsigned int flags) {}
 
+#if 0 // TODO remove
 static inline int cifs_fscache_query_occupancy(struct inode *inode,
 					       pgoff_t first, unsigned int nr_pages,
 					       pgoff_t *_data_first,
@@ -143,6 +146,7 @@ cifs_readpage_from_fscache(struct inode *inode, struct page *page)
 
 static inline
 void cifs_readahead_to_fscache(struct inode *inode, loff_t pos, size_t len) {}
+#endif
 
 #endif /* CONFIG_CIFS_FSCACHE */
 
diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
index 6815b50ec56c..95c3503bcf80 100644
--- a/fs/smb/client/inode.c
+++ b/fs/smb/client/inode.c
@@ -27,14 +27,29 @@
 #include "cifs_ioctl.h"
 #include "cached_dir.h"
 
+/*
+ * Set parameters for the netfs library
+ */
+static void cifs_set_netfs_context(struct inode *inode)
+{
+	struct cifsInodeInfo *cifs_i = CIFS_I(inode);
+	struct cifs_sb_info *cifs_sb = CIFS_SB(inode->i_sb);
+
+	netfs_inode_init(&cifs_i->netfs, &cifs_req_ops);
+	if (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_STRICT_IO)
+		__set_bit(NETFS_ICTX_WRITETHROUGH, &cifs_i->netfs.flags);
+}
+
 static void cifs_set_ops(struct inode *inode)
 {
 	struct cifs_sb_info *cifs_sb = CIFS_SB(inode->i_sb);
+	struct netfs_inode *ictx = netfs_inode(inode);
 
 	switch (inode->i_mode & S_IFMT) {
 	case S_IFREG:
 		inode->i_op = &cifs_file_inode_ops;
 		if (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_DIRECT_IO) {
+			set_bit(NETFS_ICTX_UNBUFFERED, &ictx->flags);
 			if (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_NO_BRL)
 				inode->i_fop = &cifs_file_direct_nobrl_ops;
 			else
@@ -216,8 +231,10 @@ cifs_fattr_to_inode(struct inode *inode, struct cifs_fattr *fattr)
 
 	if (fattr->cf_flags & CIFS_FATTR_JUNCTION)
 		inode->i_flags |= S_AUTOMOUNT;
-	if (inode->i_state & I_NEW)
+	if (inode->i_state & I_NEW) {
+		cifs_set_netfs_context(inode);
 		cifs_set_ops(inode);
+	}
 	return 0;
 }
 
diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index 4fde3d506c60..b2e13a707d7f 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -4100,10 +4100,12 @@ smb2_new_read_req(void **buf, unsigned int *total_len,
 	req->Length = cpu_to_le32(io_parms->length);
 	req->Offset = cpu_to_le64(io_parms->offset);
 
-	trace_smb3_read_enter(0 /* xid */,
-			io_parms->persistent_fid,
-			io_parms->tcon->tid, io_parms->tcon->ses->Suid,
-			io_parms->offset, io_parms->length);
+	trace_smb3_read_enter(rdata ? rdata->rreq->debug_id : 0,
+			      rdata ? rdata->subreq.debug_index : 0,
+			      rdata ? rdata->xid : 0,
+			      io_parms->persistent_fid,
+			      io_parms->tcon->tid, io_parms->tcon->ses->Suid,
+			      io_parms->offset, io_parms->length);
 #ifdef CONFIG_CIFS_SMB_DIRECT
 	/*
 	 * If we want to do a RDMA write, fill in and append
@@ -4165,7 +4167,7 @@ static void
 smb2_readv_callback(struct mid_q_entry *mid)
 {
 	struct cifs_io_subrequest *rdata = mid->callback_data;
-	struct cifs_tcon *tcon = tlink_tcon(rdata->cfile->tlink);
+	struct cifs_tcon *tcon = tlink_tcon(rdata->req->cfile->tlink);
 	struct TCP_Server_Info *server = rdata->server;
 	struct smb2_hdr *shdr =
 				(struct smb2_hdr *)rdata->iov[0].iov_base;
@@ -4235,17 +4237,33 @@ smb2_readv_callback(struct mid_q_entry *mid)
 #endif
 	if (rdata->result && rdata->result != -ENODATA) {
 		cifs_stats_fail_inc(tcon, SMB2_READ_HE);
-		trace_smb3_read_err(0 /* xid */,
-				    rdata->cfile->fid.persistent_fid,
+		trace_smb3_read_err(rdata->rreq->debug_id,
+				    rdata->subreq.debug_index,
+				    rdata->xid,
+				    rdata->req->cfile->fid.persistent_fid,
 				    tcon->tid, tcon->ses->Suid, rdata->subreq.start,
 				    rdata->subreq.len, rdata->result);
 	} else
-		trace_smb3_read_done(0 /* xid */,
-				     rdata->cfile->fid.persistent_fid,
+		trace_smb3_read_done(rdata->rreq->debug_id,
+				     rdata->subreq.debug_index,
+				     rdata->xid,
+				     rdata->req->cfile->fid.persistent_fid,
 				     tcon->tid, tcon->ses->Suid,
 				     rdata->subreq.start, rdata->got_bytes);
 
-	queue_work(cifsiod_wq, &rdata->work);
+	if (rdata->result == -ENODATA) {
+		/* We may have got an EOF error because fallocate
+		 * failed to enlarge the file.
+		 */
+		if (rdata->subreq.start < rdata->subreq.rreq->i_size)
+			rdata->result = 0;
+	}
+	if (rdata->result == 0 || rdata->result == -EAGAIN)
+		iov_iter_advance(&rdata->subreq.io_iter, rdata->got_bytes);
+	rdata->have_credits = false;
+	netfs_subreq_terminated(&rdata->subreq,
+				(rdata->result == 0 || rdata->result == -EAGAIN) ?
+				rdata->got_bytes : rdata->result, true);
 	release_mid(mid);
 	add_credits(server, &credits, 0);
 }
@@ -4261,7 +4279,7 @@ smb2_async_readv(struct cifs_io_subrequest *rdata)
 	struct smb_rqst rqst = { .rq_iov = rdata->iov,
 				 .rq_nvec = 1 };
 	struct TCP_Server_Info *server;
-	struct cifs_tcon *tcon = tlink_tcon(rdata->cfile->tlink);
+	struct cifs_tcon *tcon = tlink_tcon(rdata->req->cfile->tlink);
 	unsigned int total_len;
 	int credit_request;
 
@@ -4271,12 +4289,12 @@ smb2_async_readv(struct cifs_io_subrequest *rdata)
 	if (!rdata->server)
 		rdata->server = cifs_pick_channel(tcon->ses);
 
-	io_parms.tcon = tlink_tcon(rdata->cfile->tlink);
+	io_parms.tcon = tlink_tcon(rdata->req->cfile->tlink);
 	io_parms.server = server = rdata->server;
 	io_parms.offset = rdata->subreq.start;
 	io_parms.length = rdata->subreq.len;
-	io_parms.persistent_fid = rdata->cfile->fid.persistent_fid;
-	io_parms.volatile_fid = rdata->cfile->fid.volatile_fid;
+	io_parms.persistent_fid = rdata->req->cfile->fid.persistent_fid;
+	io_parms.volatile_fid = rdata->req->cfile->fid.volatile_fid;
 	io_parms.pid = rdata->pid;
 
 	rc = smb2_new_read_req(
@@ -4316,7 +4334,9 @@ smb2_async_readv(struct cifs_io_subrequest *rdata)
 			     &rdata->credits);
 	if (rc) {
 		cifs_stats_fail_inc(io_parms.tcon, SMB2_READ_HE);
-		trace_smb3_read_err(0 /* xid */, io_parms.persistent_fid,
+		trace_smb3_read_err(rdata->rreq->debug_id,
+				    rdata->subreq.debug_index,
+				    rdata->xid, io_parms.persistent_fid,
 				    io_parms.tcon->tid,
 				    io_parms.tcon->ses->Suid,
 				    io_parms.offset, io_parms.length, rc);
@@ -4367,22 +4387,23 @@ SMB2_read(const unsigned int xid, struct cifs_io_parms *io_parms,
 		if (rc != -ENODATA) {
 			cifs_stats_fail_inc(io_parms->tcon, SMB2_READ_HE);
 			cifs_dbg(VFS, "Send error in read = %d\n", rc);
-			trace_smb3_read_err(xid,
+			trace_smb3_read_err(0, 0, xid,
 					    req->PersistentFileId,
 					    io_parms->tcon->tid, ses->Suid,
 					    io_parms->offset, io_parms->length,
 					    rc);
 		} else
-			trace_smb3_read_done(xid, req->PersistentFileId, io_parms->tcon->tid,
+			trace_smb3_read_done(0, 0, xid,
+					     req->PersistentFileId, io_parms->tcon->tid,
 					     ses->Suid, io_parms->offset, 0);
 		free_rsp_buf(resp_buftype, rsp_iov.iov_base);
 		cifs_small_buf_release(req);
 		return rc == -ENODATA ? 0 : rc;
 	} else
-		trace_smb3_read_done(xid,
-				    req->PersistentFileId,
-				    io_parms->tcon->tid, ses->Suid,
-				    io_parms->offset, io_parms->length);
+		trace_smb3_read_done(0, 0, xid,
+				     req->PersistentFileId,
+				     io_parms->tcon->tid, ses->Suid,
+				     io_parms->offset, io_parms->length);
 
 	cifs_small_buf_release(req);
 
@@ -4416,11 +4437,12 @@ static void
 smb2_writev_callback(struct mid_q_entry *mid)
 {
 	struct cifs_io_subrequest *wdata = mid->callback_data;
-	struct cifs_tcon *tcon = tlink_tcon(wdata->cfile->tlink);
+	struct cifs_tcon *tcon = tlink_tcon(wdata->req->cfile->tlink);
 	struct TCP_Server_Info *server = wdata->server;
-	unsigned int written;
 	struct smb2_write_rsp *rsp = (struct smb2_write_rsp *)mid->resp_buf;
 	struct cifs_credits credits = { .value = 0, .instance = 0 };
+	ssize_t result = 0;
+	size_t written;
 
 	WARN_ONCE(wdata->server != mid->server,
 		  "wdata server %p != mid server %p",
@@ -4430,8 +4452,8 @@ smb2_writev_callback(struct mid_q_entry *mid)
 	case MID_RESPONSE_RECEIVED:
 		credits.value = le16_to_cpu(rsp->hdr.CreditRequest);
 		credits.instance = server->reconnect_instance;
-		wdata->result = smb2_check_receive(mid, server, 0);
-		if (wdata->result != 0)
+		result = smb2_check_receive(mid, server, 0);
+		if (result != 0)
 			break;
 
 		written = le32_to_cpu(rsp->DataLength);
@@ -4448,17 +4470,18 @@ smb2_writev_callback(struct mid_q_entry *mid)
 			wdata->result = -ENOSPC;
 		else
 			wdata->subreq.len = written;
+		iov_iter_advance(&wdata->subreq.io_iter, written);
 		break;
 	case MID_REQUEST_SUBMITTED:
 	case MID_RETRY_NEEDED:
-		wdata->result = -EAGAIN;
+		result = -EAGAIN;
 		break;
 	case MID_RESPONSE_MALFORMED:
 		credits.value = le16_to_cpu(rsp->hdr.CreditRequest);
 		credits.instance = server->reconnect_instance;
 		fallthrough;
 	default:
-		wdata->result = -EIO;
+		result = -EIO;
 		break;
 	}
 #ifdef CONFIG_CIFS_SMB_DIRECT
@@ -4474,10 +4497,10 @@ smb2_writev_callback(struct mid_q_entry *mid)
 		wdata->mr = NULL;
 	}
 #endif
-	if (wdata->result) {
+	if (result) {
 		cifs_stats_fail_inc(tcon, SMB2_WRITE_HE);
 		trace_smb3_write_err(0 /* no xid */,
-				     wdata->cfile->fid.persistent_fid,
+				     wdata->req->cfile->fid.persistent_fid,
 				     tcon->tid, tcon->ses->Suid, wdata->subreq.start,
 				     wdata->subreq.len, wdata->result);
 		if (wdata->result == -ENOSPC)
@@ -4485,11 +4508,11 @@ smb2_writev_callback(struct mid_q_entry *mid)
 				     tcon->tree_name);
 	} else
 		trace_smb3_write_done(0 /* no xid */,
-				      wdata->cfile->fid.persistent_fid,
+				      wdata->req->cfile->fid.persistent_fid,
 				      tcon->tid, tcon->ses->Suid,
 				      wdata->subreq.start, wdata->subreq.len);
 
-	queue_work(cifsiod_wq, &wdata->work);
+	netfs_write_subrequest_terminated(&wdata->subreq, result ?: written, true);
 	release_mid(mid);
 	add_credits(server, &credits, 0);
 }
@@ -4501,7 +4524,7 @@ smb2_async_writev(struct cifs_io_subrequest *wdata)
 	int rc = -EACCES, flags = 0;
 	struct smb2_write_req *req = NULL;
 	struct smb2_hdr *shdr;
-	struct cifs_tcon *tcon = tlink_tcon(wdata->cfile->tlink);
+	struct cifs_tcon *tcon = tlink_tcon(wdata->req->cfile->tlink);
 	struct TCP_Server_Info *server = wdata->server;
 	struct kvec iov[1];
 	struct smb_rqst rqst = { };
@@ -4522,8 +4545,8 @@ smb2_async_writev(struct cifs_io_subrequest *wdata)
 		.server = server,
 		.offset = wdata->subreq.start,
 		.length = wdata->subreq.len,
-		.persistent_fid = wdata->cfile->fid.persistent_fid,
-		.volatile_fid = wdata->cfile->fid.volatile_fid,
+		.persistent_fid = wdata->req->cfile->fid.persistent_fid,
+		.volatile_fid = wdata->req->cfile->fid.volatile_fid,
 		.pid = wdata->pid,
 	};
 	io_parms = &_io_parms;
@@ -4531,7 +4554,7 @@ smb2_async_writev(struct cifs_io_subrequest *wdata)
 	rc = smb2_plain_req_init(SMB2_WRITE, tcon, server,
 				 (void **) &req, &total_len);
 	if (rc)
-		return rc;
+		goto out;
 
 	if (smb3_encryption_required(tcon))
 		flags |= CIFS_TRANSFORM_REQ;
@@ -4628,7 +4651,6 @@ smb2_async_writev(struct cifs_io_subrequest *wdata)
 		flags |= CIFS_HAS_CREDITS;
 	}
 
-	cifs_get_writedata(wdata);
 	rc = cifs_call_async(server, &rqst, NULL, smb2_writev_callback, NULL,
 			     wdata, flags, &wdata->credits);
 
@@ -4640,12 +4662,14 @@ smb2_async_writev(struct cifs_io_subrequest *wdata)
 				     io_parms->offset,
 				     io_parms->length,
 				     rc);
-		cifs_put_writedata(wdata);
 		cifs_stats_fail_inc(tcon, SMB2_WRITE_HE);
 	}
 
 async_writev_out:
 	cifs_small_buf_release(req);
+out:
+	if (rc)
+		netfs_write_subrequest_terminated(&wdata->subreq, rc, true);
 	return rc;
 }
 
diff --git a/fs/smb/client/trace.h b/fs/smb/client/trace.h
index de199ec9f726..b24264aeac13 100644
--- a/fs/smb/client/trace.h
+++ b/fs/smb/client/trace.h
@@ -21,6 +21,62 @@
 
 /* For logging errors in read or write */
 DECLARE_EVENT_CLASS(smb3_rw_err_class,
+	TP_PROTO(unsigned int rreq_debug_id,
+		 unsigned int rreq_debug_index,
+		 unsigned int xid,
+		 __u64	fid,
+		 __u32	tid,
+		 __u64	sesid,
+		 __u64	offset,
+		 __u32	len,
+		 int	rc),
+	TP_ARGS(rreq_debug_id, rreq_debug_index,
+		xid, fid, tid, sesid, offset, len, rc),
+	TP_STRUCT__entry(
+		__field(unsigned int, rreq_debug_id)
+		__field(unsigned int, rreq_debug_index)
+		__field(unsigned int, xid)
+		__field(__u64, fid)
+		__field(__u32, tid)
+		__field(__u64, sesid)
+		__field(__u64, offset)
+		__field(__u32, len)
+		__field(int, rc)
+	),
+	TP_fast_assign(
+		__entry->rreq_debug_id = rreq_debug_id;
+		__entry->rreq_debug_index = rreq_debug_index;
+		__entry->xid = xid;
+		__entry->fid = fid;
+		__entry->tid = tid;
+		__entry->sesid = sesid;
+		__entry->offset = offset;
+		__entry->len = len;
+		__entry->rc = rc;
+	),
+	TP_printk("\tR=%08x[%x] xid=%u sid=0x%llx tid=0x%x fid=0x%llx offset=0x%llx len=0x%x rc=%d",
+		  __entry->rreq_debug_id, __entry->rreq_debug_index,
+		  __entry->xid, __entry->sesid, __entry->tid, __entry->fid,
+		  __entry->offset, __entry->len, __entry->rc)
+)
+
+#define DEFINE_SMB3_RW_ERR_EVENT(name)          \
+DEFINE_EVENT(smb3_rw_err_class, smb3_##name,    \
+	TP_PROTO(unsigned int rreq_debug_id,	\
+		 unsigned int rreq_debug_index,		\
+		 unsigned int xid,			\
+		 __u64	fid,				\
+		 __u32	tid,				\
+		 __u64	sesid,				\
+		 __u64	offset,				\
+		 __u32	len,				\
+		 int	rc),				\
+	TP_ARGS(rreq_debug_id, rreq_debug_index, xid, fid, tid, sesid, offset, len, rc))
+
+DEFINE_SMB3_RW_ERR_EVENT(read_err);
+
+/* For logging errors in other file I/O ops */
+DECLARE_EVENT_CLASS(smb3_other_err_class,
 	TP_PROTO(unsigned int xid,
 		__u64	fid,
 		__u32	tid,
@@ -52,8 +108,8 @@ DECLARE_EVENT_CLASS(smb3_rw_err_class,
 		__entry->offset, __entry->len, __entry->rc)
 )
 
-#define DEFINE_SMB3_RW_ERR_EVENT(name)          \
-DEFINE_EVENT(smb3_rw_err_class, smb3_##name,    \
+#define DEFINE_SMB3_OTHER_ERR_EVENT(name)	\
+DEFINE_EVENT(smb3_other_err_class, smb3_##name, \
 	TP_PROTO(unsigned int xid,		\
 		__u64	fid,			\
 		__u32	tid,			\
@@ -63,15 +119,67 @@ DEFINE_EVENT(smb3_rw_err_class, smb3_##name,    \
 		int	rc),			\
 	TP_ARGS(xid, fid, tid, sesid, offset, len, rc))
 
-DEFINE_SMB3_RW_ERR_EVENT(write_err);
-DEFINE_SMB3_RW_ERR_EVENT(read_err);
-DEFINE_SMB3_RW_ERR_EVENT(query_dir_err);
-DEFINE_SMB3_RW_ERR_EVENT(zero_err);
-DEFINE_SMB3_RW_ERR_EVENT(falloc_err);
+DEFINE_SMB3_OTHER_ERR_EVENT(write_err);
+DEFINE_SMB3_OTHER_ERR_EVENT(query_dir_err);
+DEFINE_SMB3_OTHER_ERR_EVENT(zero_err);
+DEFINE_SMB3_OTHER_ERR_EVENT(falloc_err);
 
 
 /* For logging successful read or write */
 DECLARE_EVENT_CLASS(smb3_rw_done_class,
+	TP_PROTO(unsigned int rreq_debug_id,
+		 unsigned int rreq_debug_index,
+		 unsigned int xid,
+		 __u64	fid,
+		 __u32	tid,
+		 __u64	sesid,
+		 __u64	offset,
+		 __u32	len),
+	TP_ARGS(rreq_debug_id, rreq_debug_index,
+		xid, fid, tid, sesid, offset, len),
+	TP_STRUCT__entry(
+		__field(unsigned int, rreq_debug_id)
+		__field(unsigned int, rreq_debug_index)
+		__field(unsigned int, xid)
+		__field(__u64, fid)
+		__field(__u32, tid)
+		__field(__u64, sesid)
+		__field(__u64, offset)
+		__field(__u32, len)
+	),
+	TP_fast_assign(
+		__entry->rreq_debug_id = rreq_debug_id;
+		__entry->rreq_debug_index = rreq_debug_index;
+		__entry->xid = xid;
+		__entry->fid = fid;
+		__entry->tid = tid;
+		__entry->sesid = sesid;
+		__entry->offset = offset;
+		__entry->len = len;
+	),
+	TP_printk("R=%08x[%x] xid=%u sid=0x%llx tid=0x%x fid=0x%llx offset=0x%llx len=0x%x",
+		  __entry->rreq_debug_id, __entry->rreq_debug_index,
+		  __entry->xid, __entry->sesid, __entry->tid, __entry->fid,
+		  __entry->offset, __entry->len)
+)
+
+#define DEFINE_SMB3_RW_DONE_EVENT(name)         \
+DEFINE_EVENT(smb3_rw_done_class, smb3_##name,   \
+	TP_PROTO(unsigned int rreq_debug_id,	\
+		 unsigned int rreq_debug_index,	\
+		 unsigned int xid,		\
+		__u64	fid,			\
+		__u32	tid,			\
+		__u64	sesid,			\
+		__u64	offset,			\
+		__u32	len),			\
+	TP_ARGS(rreq_debug_id, rreq_debug_index, xid, fid, tid, sesid, offset, len))
+
+DEFINE_SMB3_RW_DONE_EVENT(read_enter);
+DEFINE_SMB3_RW_DONE_EVENT(read_done);
+
+/* For logging successful other op */
+DECLARE_EVENT_CLASS(smb3_other_done_class,
 	TP_PROTO(unsigned int xid,
 		__u64	fid,
 		__u32	tid,
@@ -100,8 +208,8 @@ DECLARE_EVENT_CLASS(smb3_rw_done_class,
 		__entry->offset, __entry->len)
 )
 
-#define DEFINE_SMB3_RW_DONE_EVENT(name)         \
-DEFINE_EVENT(smb3_rw_done_class, smb3_##name,   \
+#define DEFINE_SMB3_OTHER_DONE_EVENT(name)         \
+DEFINE_EVENT(smb3_other_done_class, smb3_##name,   \
 	TP_PROTO(unsigned int xid,		\
 		__u64	fid,			\
 		__u32	tid,			\
@@ -110,16 +218,14 @@ DEFINE_EVENT(smb3_rw_done_class, smb3_##name,   \
 		__u32	len),			\
 	TP_ARGS(xid, fid, tid, sesid, offset, len))
 
-DEFINE_SMB3_RW_DONE_EVENT(write_enter);
-DEFINE_SMB3_RW_DONE_EVENT(read_enter);
-DEFINE_SMB3_RW_DONE_EVENT(query_dir_enter);
-DEFINE_SMB3_RW_DONE_EVENT(zero_enter);
-DEFINE_SMB3_RW_DONE_EVENT(falloc_enter);
-DEFINE_SMB3_RW_DONE_EVENT(write_done);
-DEFINE_SMB3_RW_DONE_EVENT(read_done);
-DEFINE_SMB3_RW_DONE_EVENT(query_dir_done);
-DEFINE_SMB3_RW_DONE_EVENT(zero_done);
-DEFINE_SMB3_RW_DONE_EVENT(falloc_done);
+DEFINE_SMB3_OTHER_DONE_EVENT(write_enter);
+DEFINE_SMB3_OTHER_DONE_EVENT(query_dir_enter);
+DEFINE_SMB3_OTHER_DONE_EVENT(zero_enter);
+DEFINE_SMB3_OTHER_DONE_EVENT(falloc_enter);
+DEFINE_SMB3_OTHER_DONE_EVENT(write_done);
+DEFINE_SMB3_OTHER_DONE_EVENT(query_dir_done);
+DEFINE_SMB3_OTHER_DONE_EVENT(zero_done);
+DEFINE_SMB3_OTHER_DONE_EVENT(falloc_done);
 
 /* For logging successful set EOF (truncate) */
 DECLARE_EVENT_CLASS(smb3_eof_class,
diff --git a/fs/smb/client/transport.c b/fs/smb/client/transport.c
index 9d22b1cdfc9f..b77110b11a19 100644
--- a/fs/smb/client/transport.c
+++ b/fs/smb/client/transport.c
@@ -1807,8 +1807,11 @@ cifs_readv_receive(struct TCP_Server_Info *server, struct mid_q_entry *mid)
 		length = data_len; /* An RDMA read is already done. */
 	else
 #endif
+	{
 		length = cifs_read_iter_from_socket(server, &rdata->subreq.io_iter,
 						    data_len);
+		iov_iter_revert(&rdata->subreq.io_iter, data_len);
+	}
 	if (length > 0)
 		rdata->got_bytes += length;
 	server->total_read += length;


