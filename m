Return-Path: <linux-fsdevel+bounces-5956-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC768117DE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 16:44:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 678371F21D39
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 15:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F2353B282;
	Wed, 13 Dec 2023 15:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZZ2DMWZ4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D67C131
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Dec 2023 07:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702482120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SMbOgFkbak90MAOfkXqzM0Do3/SwWTslJ0OTgQqv11o=;
	b=ZZ2DMWZ4a5ldOfFwxn7G7olELgXYhssBNMNEd6iQRXZfBRhoVQ7jXhwb7jGGr7rQNmiAOu
	Se1I7R+CF1xgSV7LwUUpq0TT7RZfBeo32HbILGStBzZQf4OtfifPS/SM4QyqN5WdjpPDxj
	eUbRSfygcDKt8OgvF9l59lRpEmu6qME=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-83-tz_VUnIwNZy22dioJmycDA-1; Wed,
 13 Dec 2023 10:41:55 -0500
X-MC-Unique: tz_VUnIwNZy22dioJmycDA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 63F181D6BEF0;
	Wed, 13 Dec 2023 15:41:53 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.2])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6450C51E3;
	Wed, 13 Dec 2023 15:41:50 +0000 (UTC)
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
Subject: [PATCH v4 02/13] cifs: Replace cifs_readdata with a wrapper around netfs_io_subrequest
Date: Wed, 13 Dec 2023 15:41:28 +0000
Message-ID: <20231213154139.432922-3-dhowells@redhat.com>
In-Reply-To: <20231213154139.432922-1-dhowells@redhat.com>
References: <20231213154139.432922-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

Netfslib has a facility whereby the allocation for netfs_io_subrequest can
be increased to so that filesystem-specific data can be tagged on the end.

Prepare to use this by making a struct, cifs_io_subrequest, that wraps
netfs_io_subrequest, and absorb struct cifs_readdata into it.

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
 fs/smb/client/cifsglob.h  | 22 ++++++++++--------
 fs/smb/client/cifsproto.h |  9 ++++++--
 fs/smb/client/cifssmb.c   | 11 ++++-----
 fs/smb/client/file.c      | 48 ++++++++++++++++++---------------------
 fs/smb/client/smb2ops.c   |  2 +-
 fs/smb/client/smb2pdu.c   | 13 ++++++-----
 fs/smb/client/smb2proto.h |  2 +-
 fs/smb/client/transport.c |  4 ++--
 8 files changed, 56 insertions(+), 55 deletions(-)

diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index 7558167f603c..65820f40f7f4 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -243,7 +243,7 @@ struct dfs_info3_param;
 struct cifs_fattr;
 struct smb3_fs_context;
 struct cifs_fid;
-struct cifs_readdata;
+struct cifs_io_subrequest;
 struct cifs_writedata;
 struct cifs_io_parms;
 struct cifs_search_info;
@@ -416,7 +416,7 @@ struct smb_version_operations {
 	/* send a flush request to the server */
 	int (*flush)(const unsigned int, struct cifs_tcon *, struct cifs_fid *);
 	/* async read from the server */
-	int (*async_readv)(struct cifs_readdata *);
+	int (*async_readv)(struct cifs_io_subrequest *);
 	/* async write to the server */
 	int (*async_writev)(struct cifs_writedata *,
 			    void (*release)(struct kref *));
@@ -1435,26 +1435,28 @@ struct cifs_aio_ctx {
 };
 
 /* asynchronous read support */
-struct cifs_readdata {
-	struct kref			refcount;
-	struct list_head		list;
-	struct completion		done;
+struct cifs_io_subrequest {
+	struct netfs_io_subrequest	subreq;
 	struct cifsFileInfo		*cfile;
 	struct address_space		*mapping;
 	struct cifs_aio_ctx		*ctx;
-	__u64				offset;
 	ssize_t				got_bytes;
-	unsigned int			bytes;
 	pid_t				pid;
 	int				result;
-	struct work_struct		work;
-	struct iov_iter			iter;
 	struct kvec			iov[2];
 	struct TCP_Server_Info		*server;
 #ifdef CONFIG_CIFS_SMB_DIRECT
 	struct smbd_mr			*mr;
 #endif
 	struct cifs_credits		credits;
+
+	// TODO: Remove following elements
+	struct list_head		list;
+	struct completion		done;
+	struct work_struct		work;
+	struct iov_iter			iter;
+	__u64				offset;
+	unsigned int			bytes;
 };
 
 /* asynchronous write support */
diff --git a/fs/smb/client/cifsproto.h b/fs/smb/client/cifsproto.h
index 46feaa0880bd..49ffa657893b 100644
--- a/fs/smb/client/cifsproto.h
+++ b/fs/smb/client/cifsproto.h
@@ -587,8 +587,13 @@ void __cifs_put_smb_ses(struct cifs_ses *ses);
 extern struct cifs_ses *
 cifs_get_smb_ses(struct TCP_Server_Info *server, struct smb3_fs_context *ctx);
 
-void cifs_readdata_release(struct kref *refcount);
-int cifs_async_readv(struct cifs_readdata *rdata);
+void cifs_readdata_release(struct cifs_io_subrequest *rdata);
+static inline void cifs_put_readdata(struct cifs_io_subrequest *rdata)
+{
+	if (refcount_dec_and_test(&rdata->subreq.ref))
+		cifs_readdata_release(rdata);
+}
+int cifs_async_readv(struct cifs_io_subrequest *rdata);
 int cifs_readv_receive(struct TCP_Server_Info *server, struct mid_q_entry *mid);
 
 int cifs_async_writev(struct cifs_writedata *wdata,
diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
index 9ee348e6d106..d8b03eec15c4 100644
--- a/fs/smb/client/cifssmb.c
+++ b/fs/smb/client/cifssmb.c
@@ -24,6 +24,8 @@
 #include <linux/swap.h>
 #include <linux/task_io_accounting_ops.h>
 #include <linux/uaccess.h>
+#include <linux/netfs.h>
+#include <trace/events/netfs.h>
 #include "cifspdu.h"
 #include "cifsfs.h"
 #include "cifsglob.h"
@@ -1262,12 +1264,11 @@ CIFS_open(const unsigned int xid, struct cifs_open_parms *oparms, int *oplock,
 static void
 cifs_readv_callback(struct mid_q_entry *mid)
 {
-	struct cifs_readdata *rdata = mid->callback_data;
+	struct cifs_io_subrequest *rdata = mid->callback_data;
 	struct cifs_tcon *tcon = tlink_tcon(rdata->cfile->tlink);
 	struct TCP_Server_Info *server = tcon->ses->server;
 	struct smb_rqst rqst = { .rq_iov = rdata->iov,
 				 .rq_nvec = 2,
-				 .rq_iter_size = iov_iter_count(&rdata->iter),
 				 .rq_iter = rdata->iter };
 	struct cifs_credits credits = { .value = 1, .instance = 0 };
 
@@ -1312,7 +1313,7 @@ cifs_readv_callback(struct mid_q_entry *mid)
 
 /* cifs_async_readv - send an async write, and set up mid to handle result */
 int
-cifs_async_readv(struct cifs_readdata *rdata)
+cifs_async_readv(struct cifs_io_subrequest *rdata)
 {
 	int rc;
 	READ_REQ *smb = NULL;
@@ -1364,15 +1365,11 @@ cifs_async_readv(struct cifs_readdata *rdata)
 	rdata->iov[1].iov_base = (char *)smb + 4;
 	rdata->iov[1].iov_len = get_rfc1002_length(smb);
 
-	kref_get(&rdata->refcount);
 	rc = cifs_call_async(tcon->ses->server, &rqst, cifs_readv_receive,
 			     cifs_readv_callback, NULL, rdata, 0, NULL);
 
 	if (rc == 0)
 		cifs_stats_inc(&tcon->stats.cifs_stats.num_reads);
-	else
-		kref_put(&rdata->refcount, cifs_readdata_release);
-
 	cifs_small_buf_release(smb);
 	return rc;
 }
diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index b25cace63768..ca697bda4666 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -2949,7 +2949,7 @@ static int cifs_writepages_region(struct address_space *mapping,
 			continue;
 		}
 
-		folio_batch_release(&fbatch);		
+		folio_batch_release(&fbatch);
 		cond_resched();
 	} while (wbc->nr_to_write > 0);
 
@@ -3783,13 +3783,13 @@ cifs_strict_writev(struct kiocb *iocb, struct iov_iter *from)
 	return written;
 }
 
-static struct cifs_readdata *cifs_readdata_alloc(work_func_t complete)
+static struct cifs_io_subrequest *cifs_readdata_alloc(work_func_t complete)
 {
-	struct cifs_readdata *rdata;
+	struct cifs_io_subrequest *rdata;
 
 	rdata = kzalloc(sizeof(*rdata), GFP_KERNEL);
 	if (rdata) {
-		kref_init(&rdata->refcount);
+		refcount_set(&rdata->subreq.ref, 1);
 		INIT_LIST_HEAD(&rdata->list);
 		init_completion(&rdata->done);
 		INIT_WORK(&rdata->work, complete);
@@ -3799,11 +3799,8 @@ static struct cifs_readdata *cifs_readdata_alloc(work_func_t complete)
 }
 
 void
-cifs_readdata_release(struct kref *refcount)
+cifs_readdata_release(struct cifs_io_subrequest *rdata)
 {
-	struct cifs_readdata *rdata = container_of(refcount,
-					struct cifs_readdata, refcount);
-
 	if (rdata->ctx)
 		kref_put(&rdata->ctx->refcount, cifs_aio_ctx_release);
 #ifdef CONFIG_CIFS_SMB_DIRECT
@@ -3823,16 +3820,16 @@ static void collect_uncached_read_data(struct cifs_aio_ctx *ctx);
 static void
 cifs_uncached_readv_complete(struct work_struct *work)
 {
-	struct cifs_readdata *rdata = container_of(work,
-						struct cifs_readdata, work);
+	struct cifs_io_subrequest *rdata =
+		container_of(work, struct cifs_io_subrequest, work);
 
 	complete(&rdata->done);
 	collect_uncached_read_data(rdata->ctx);
 	/* the below call can possibly free the last ref to aio ctx */
-	kref_put(&rdata->refcount, cifs_readdata_release);
+	cifs_put_readdata(rdata);
 }
 
-static int cifs_resend_rdata(struct cifs_readdata *rdata,
+static int cifs_resend_rdata(struct cifs_io_subrequest *rdata,
 			struct list_head *rdata_list,
 			struct cifs_aio_ctx *ctx)
 {
@@ -3900,7 +3897,7 @@ static int cifs_resend_rdata(struct cifs_readdata *rdata,
 	} while (rc == -EAGAIN);
 
 fail:
-	kref_put(&rdata->refcount, cifs_readdata_release);
+	cifs_put_readdata(rdata);
 	return rc;
 }
 
@@ -3909,7 +3906,7 @@ cifs_send_async_read(loff_t fpos, size_t len, struct cifsFileInfo *open_file,
 		     struct cifs_sb_info *cifs_sb, struct list_head *rdata_list,
 		     struct cifs_aio_ctx *ctx)
 {
-	struct cifs_readdata *rdata;
+	struct cifs_io_subrequest *rdata;
 	unsigned int rsize, nsegs, max_segs = INT_MAX;
 	struct cifs_credits credits_on_stack;
 	struct cifs_credits *credits = &credits_on_stack;
@@ -3977,7 +3974,7 @@ cifs_send_async_read(loff_t fpos, size_t len, struct cifsFileInfo *open_file,
 		rdata->ctx	= ctx;
 		kref_get(&ctx->refcount);
 
-		rdata->iter	= ctx->iter;
+		rdata->iter = ctx->iter;
 		iov_iter_truncate(&rdata->iter, cur_len);
 
 		rc = adjust_credits(server, &rdata->credits, rdata->bytes);
@@ -3991,7 +3988,7 @@ cifs_send_async_read(loff_t fpos, size_t len, struct cifsFileInfo *open_file,
 
 		if (rc) {
 			add_credits_and_wake_if(server, &rdata->credits, 0);
-			kref_put(&rdata->refcount, cifs_readdata_release);
+			cifs_put_readdata(rdata);
 			if (rc == -EAGAIN)
 				continue;
 			break;
@@ -4009,7 +4006,7 @@ cifs_send_async_read(loff_t fpos, size_t len, struct cifsFileInfo *open_file,
 static void
 collect_uncached_read_data(struct cifs_aio_ctx *ctx)
 {
-	struct cifs_readdata *rdata, *tmp;
+	struct cifs_io_subrequest *rdata, *tmp;
 	struct cifs_sb_info *cifs_sb;
 	int rc;
 
@@ -4055,8 +4052,7 @@ collect_uncached_read_data(struct cifs_aio_ctx *ctx)
 						rdata->cfile, cifs_sb,
 						&tmp_list, ctx);
 
-					kref_put(&rdata->refcount,
-						cifs_readdata_release);
+					cifs_put_readdata(rdata);
 				}
 
 				list_splice(&tmp_list, &ctx->list);
@@ -4072,7 +4068,7 @@ collect_uncached_read_data(struct cifs_aio_ctx *ctx)
 			ctx->total_len += rdata->got_bytes;
 		}
 		list_del_init(&rdata->list);
-		kref_put(&rdata->refcount, cifs_readdata_release);
+		cifs_put_readdata(rdata);
 	}
 
 	/* mask nodata case */
@@ -4444,8 +4440,8 @@ static void cifs_unlock_folios(struct address_space *mapping, pgoff_t first, pgo
 
 static void cifs_readahead_complete(struct work_struct *work)
 {
-	struct cifs_readdata *rdata = container_of(work,
-						   struct cifs_readdata, work);
+	struct cifs_io_subrequest *rdata = container_of(work,
+						   struct cifs_io_subrequest, work);
 	struct folio *folio;
 	pgoff_t last;
 	bool good = rdata->result == 0 || (rdata->result == -EAGAIN && rdata->got_bytes);
@@ -4471,7 +4467,7 @@ static void cifs_readahead_complete(struct work_struct *work)
 	}
 	rcu_read_unlock();
 
-	kref_put(&rdata->refcount, cifs_readdata_release);
+	cifs_put_readdata(rdata);
 }
 
 static void cifs_readahead(struct readahead_control *ractl)
@@ -4511,7 +4507,7 @@ static void cifs_readahead(struct readahead_control *ractl)
 	 */
 	while ((nr_pages = ra_pages)) {
 		unsigned int i, rsize;
-		struct cifs_readdata *rdata;
+		struct cifs_io_subrequest *rdata;
 		struct cifs_credits credits_on_stack;
 		struct cifs_credits *credits = &credits_on_stack;
 		struct folio *folio;
@@ -4630,11 +4626,11 @@ static void cifs_readahead(struct readahead_control *ractl)
 					   rdata->offset / PAGE_SIZE,
 					   (rdata->offset + rdata->bytes - 1) / PAGE_SIZE);
 			/* Fallback to the readpage in error/reconnect cases */
-			kref_put(&rdata->refcount, cifs_readdata_release);
+			cifs_put_readdata(rdata);
 			break;
 		}
 
-		kref_put(&rdata->refcount, cifs_readdata_release);
+		cifs_put_readdata(rdata);
 	}
 
 	free_xid(xid);
diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 8f6f0a38b886..a441785b4cf1 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -4613,7 +4613,7 @@ handle_read_data(struct TCP_Server_Info *server, struct mid_q_entry *mid,
 	unsigned int cur_off;
 	unsigned int cur_page_idx;
 	unsigned int pad_len;
-	struct cifs_readdata *rdata = mid->callback_data;
+	struct cifs_io_subrequest *rdata = mid->callback_data;
 	struct smb2_hdr *shdr = (struct smb2_hdr *)buf;
 	int length;
 	bool use_rdma_mr = false;
diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index c571760ad39a..3d6292a45c56 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -23,6 +23,8 @@
 #include <linux/uuid.h>
 #include <linux/pagemap.h>
 #include <linux/xattr.h>
+#include <linux/netfs.h>
+#include <trace/events/netfs.h>
 #include "cifsglob.h"
 #include "cifsacl.h"
 #include "cifsproto.h"
@@ -4190,7 +4192,7 @@ static inline bool smb3_use_rdma_offload(struct cifs_io_parms *io_parms)
  */
 static int
 smb2_new_read_req(void **buf, unsigned int *total_len,
-	struct cifs_io_parms *io_parms, struct cifs_readdata *rdata,
+	struct cifs_io_parms *io_parms, struct cifs_io_subrequest *rdata,
 	unsigned int remaining_bytes, int request_type)
 {
 	int rc = -EACCES;
@@ -4282,13 +4284,14 @@ smb2_new_read_req(void **buf, unsigned int *total_len,
 static void
 smb2_readv_callback(struct mid_q_entry *mid)
 {
-	struct cifs_readdata *rdata = mid->callback_data;
+	struct cifs_io_subrequest *rdata = mid->callback_data;
 	struct cifs_tcon *tcon = tlink_tcon(rdata->cfile->tlink);
 	struct TCP_Server_Info *server = rdata->server;
 	struct smb2_hdr *shdr =
 				(struct smb2_hdr *)rdata->iov[0].iov_base;
 	struct cifs_credits credits = { .value = 0, .instance = 0 };
-	struct smb_rqst rqst = { .rq_iov = &rdata->iov[1], .rq_nvec = 1 };
+	struct smb_rqst rqst = { .rq_iov = &rdata->iov[1],
+				 .rq_nvec = 1 };
 
 	if (rdata->got_bytes) {
 		rqst.rq_iter	  = rdata->iter;
@@ -4369,7 +4372,7 @@ smb2_readv_callback(struct mid_q_entry *mid)
 
 /* smb2_async_readv - send an async read, and set up mid to handle result */
 int
-smb2_async_readv(struct cifs_readdata *rdata)
+smb2_async_readv(struct cifs_io_subrequest *rdata)
 {
 	int rc, flags = 0;
 	char *buf;
@@ -4427,13 +4430,11 @@ smb2_async_readv(struct cifs_readdata *rdata)
 		flags |= CIFS_HAS_CREDITS;
 	}
 
-	kref_get(&rdata->refcount);
 	rc = cifs_call_async(server, &rqst,
 			     cifs_readv_receive, smb2_readv_callback,
 			     smb3_handle_read_data, rdata, flags,
 			     &rdata->credits);
 	if (rc) {
-		kref_put(&rdata->refcount, cifs_readdata_release);
 		cifs_stats_fail_inc(io_parms.tcon, SMB2_READ_HE);
 		trace_smb3_read_err(0 /* xid */, io_parms.persistent_fid,
 				    io_parms.tcon->tid,
diff --git a/fs/smb/client/smb2proto.h b/fs/smb/client/smb2proto.h
index 0e371f7e2854..d995b8fc5189 100644
--- a/fs/smb/client/smb2proto.h
+++ b/fs/smb/client/smb2proto.h
@@ -186,7 +186,7 @@ extern int SMB2_query_acl(const unsigned int xid, struct cifs_tcon *tcon,
 extern int SMB2_get_srv_num(const unsigned int xid, struct cifs_tcon *tcon,
 			    u64 persistent_fid, u64 volatile_fid,
 			    __le64 *uniqueid);
-extern int smb2_async_readv(struct cifs_readdata *rdata);
+extern int smb2_async_readv(struct cifs_io_subrequest *rdata);
 extern int SMB2_read(const unsigned int xid, struct cifs_io_parms *io_parms,
 		     unsigned int *nbytes, char **buf, int *buf_type);
 extern int smb2_async_writev(struct cifs_writedata *wdata,
diff --git a/fs/smb/client/transport.c b/fs/smb/client/transport.c
index 4f717ad7c21b..bae758ec621b 100644
--- a/fs/smb/client/transport.c
+++ b/fs/smb/client/transport.c
@@ -1677,7 +1677,7 @@ __cifs_readv_discard(struct TCP_Server_Info *server, struct mid_q_entry *mid,
 static int
 cifs_readv_discard(struct TCP_Server_Info *server, struct mid_q_entry *mid)
 {
-	struct cifs_readdata *rdata = mid->callback_data;
+	struct cifs_io_subrequest *rdata = mid->callback_data;
 
 	return  __cifs_readv_discard(server, mid, rdata->result);
 }
@@ -1687,7 +1687,7 @@ cifs_readv_receive(struct TCP_Server_Info *server, struct mid_q_entry *mid)
 {
 	int length, len;
 	unsigned int data_offset, data_len;
-	struct cifs_readdata *rdata = mid->callback_data;
+	struct cifs_io_subrequest *rdata = mid->callback_data;
 	char *buf = server->smallbuf;
 	unsigned int buflen = server->pdu_size + HEADER_PREAMBLE_SIZE(server);
 	bool use_rdma_mr = false;


