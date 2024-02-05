Return-Path: <linux-fsdevel+bounces-10380-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4AA84A9AD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 23:58:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E26261F282B9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 22:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555954B5A7;
	Mon,  5 Feb 2024 22:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ca4QEo+C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F481EF1A
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 Feb 2024 22:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707173864; cv=none; b=fAtHaYvoX6ZWiXlG/rOZwgDHAHxsVxvtMBj+unlsuzs+NFWknj69kgcwrVy141fzLYOLE/gyO7WwfjtUzmuNy4m1E35m5vHR3GXeRKRwmlWabR6I8WkPBX8OGwSn3msVVPUp0Uy9MhCxfHoQF6OPdrXpF/lh4liX209843qQv8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707173864; c=relaxed/simple;
	bh=bXnYZQcrxZmTRPJkqwBciYDzSifGOcq4B8YAPUCoJYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O3uaUyRMAj30yBfhnVF8Uiiq03TXpLrcyFUxUOe8zPV8yINZSiXQzUUbuFOC5mCr/9//HLNYGLjNPmzV1wriGhyoNgGFMuARUVXmtkcZrMGGEEEgqx4utlxASteJmJhF9lQG5lLt6pwgNgMOqfrZmTTI/JPMJWZQQekOZMASM1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ca4QEo+C; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707173861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MytHiOAGt39No+tBkso3SKMj9ST88QNnSyvPj08v1Cw=;
	b=Ca4QEo+CUgx1344oQF19ODTLH4HuduTFBy4+zg/XxayzFDGcSiO81K/8wBj9F5h3dxJyRh
	wf5jgny+8x6iPKOEG8ki4SlBF4D0nT5BJEf23vB7xl+Zj9xJxOMqV8Tt4RgSbemBPe8xNQ
	S6tJqWDHanCvgmvZyilkpjZG38o9nCM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-57-2-np1Cj0P6i9w8-O-xQF_Q-1; Mon,
 05 Feb 2024 17:57:34 -0500
X-MC-Unique: 2-np1Cj0P6i9w8-O-xQF_Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F34A429AC03F;
	Mon,  5 Feb 2024 22:57:33 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.245])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C81273C2E;
	Mon,  5 Feb 2024 22:57:31 +0000 (UTC)
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
Subject: [PATCH v5 01/12] cifs: Replace cifs_readdata with a wrapper around netfs_io_subrequest
Date: Mon,  5 Feb 2024 22:57:13 +0000
Message-ID: <20240205225726.3104808-2-dhowells@redhat.com>
In-Reply-To: <20240205225726.3104808-1-dhowells@redhat.com>
References: <20240205225726.3104808-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

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
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
---
 fs/smb/client/cifsglob.h  | 22 ++++++++++---------
 fs/smb/client/cifsproto.h | 13 +++++++++--
 fs/smb/client/cifssmb.c   | 11 ++++------
 fs/smb/client/file.c      | 46 ++++++++++++++++++---------------------
 fs/smb/client/smb2ops.c   |  2 +-
 fs/smb/client/smb2pdu.c   | 12 +++++-----
 fs/smb/client/smb2proto.h |  2 +-
 fs/smb/client/transport.c |  4 ++--
 8 files changed, 59 insertions(+), 53 deletions(-)

diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index decf80131bbe..1ffd1f3774f7 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -256,7 +256,7 @@ struct dfs_info3_param;
 struct cifs_fattr;
 struct smb3_fs_context;
 struct cifs_fid;
-struct cifs_readdata;
+struct cifs_io_subrequest;
 struct cifs_writedata;
 struct cifs_io_parms;
 struct cifs_search_info;
@@ -434,7 +434,7 @@ struct smb_version_operations {
 	/* send a flush request to the server */
 	int (*flush)(const unsigned int, struct cifs_tcon *, struct cifs_fid *);
 	/* async read from the server */
-	int (*async_readv)(struct cifs_readdata *);
+	int (*async_readv)(struct cifs_io_subrequest *);
 	/* async write to the server */
 	int (*async_writev)(struct cifs_writedata *,
 			    void (*release)(struct kref *));
@@ -1465,26 +1465,28 @@ struct cifs_aio_ctx {
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
index 770db9026850..adf4a1f523e3 100644
--- a/fs/smb/client/cifsproto.h
+++ b/fs/smb/client/cifsproto.h
@@ -590,8 +590,17 @@ void __cifs_put_smb_ses(struct cifs_ses *ses);
 extern struct cifs_ses *
 cifs_get_smb_ses(struct TCP_Server_Info *server, struct smb3_fs_context *ctx);
 
-void cifs_readdata_release(struct kref *refcount);
-int cifs_async_readv(struct cifs_readdata *rdata);
+void cifs_readdata_release(struct cifs_io_subrequest *rdata);
+static inline void cifs_get_readdata(struct cifs_io_subrequest *rdata)
+{
+	refcount_inc(&rdata->subreq.ref);
+}
+static inline void cifs_put_readdata(struct cifs_io_subrequest *rdata)
+{
+	if (refcount_dec_and_test(&rdata->subreq.ref))
+		cifs_readdata_release(rdata);
+}
+int cifs_async_readv(struct cifs_io_subrequest *rdata);
 int cifs_readv_receive(struct TCP_Server_Info *server, struct mid_q_entry *mid);
 
 int cifs_async_writev(struct cifs_writedata *wdata,
diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
index 01e89070df5a..2d10c07c1295 100644
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
index b75282c204da..dfafc31a7436 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -2951,7 +2951,7 @@ static int cifs_writepages_region(struct address_space *mapping,
 			continue;
 		}
 
-		folio_batch_release(&fbatch);		
+		folio_batch_release(&fbatch);
 		cond_resched();
 	} while (wbc->nr_to_write > 0);
 
@@ -3786,13 +3786,13 @@ cifs_strict_writev(struct kiocb *iocb, struct iov_iter *from)
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
@@ -3802,11 +3802,8 @@ static struct cifs_readdata *cifs_readdata_alloc(work_func_t complete)
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
@@ -3826,16 +3823,16 @@ static void collect_uncached_read_data(struct cifs_aio_ctx *ctx);
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
@@ -3903,7 +3900,7 @@ static int cifs_resend_rdata(struct cifs_readdata *rdata,
 	} while (rc == -EAGAIN);
 
 fail:
-	kref_put(&rdata->refcount, cifs_readdata_release);
+	cifs_put_readdata(rdata);
 	return rc;
 }
 
@@ -3912,7 +3909,7 @@ cifs_send_async_read(loff_t fpos, size_t len, struct cifsFileInfo *open_file,
 		     struct cifs_sb_info *cifs_sb, struct list_head *rdata_list,
 		     struct cifs_aio_ctx *ctx)
 {
-	struct cifs_readdata *rdata;
+	struct cifs_io_subrequest *rdata;
 	unsigned int rsize, nsegs, max_segs = INT_MAX;
 	struct cifs_credits credits_on_stack;
 	struct cifs_credits *credits = &credits_on_stack;
@@ -3994,7 +3991,7 @@ cifs_send_async_read(loff_t fpos, size_t len, struct cifsFileInfo *open_file,
 
 		if (rc) {
 			add_credits_and_wake_if(server, &rdata->credits, 0);
-			kref_put(&rdata->refcount, cifs_readdata_release);
+			cifs_put_readdata(rdata);
 			if (rc == -EAGAIN)
 				continue;
 			break;
@@ -4012,7 +4009,7 @@ cifs_send_async_read(loff_t fpos, size_t len, struct cifsFileInfo *open_file,
 static void
 collect_uncached_read_data(struct cifs_aio_ctx *ctx)
 {
-	struct cifs_readdata *rdata, *tmp;
+	struct cifs_io_subrequest *rdata, *tmp;
 	struct cifs_sb_info *cifs_sb;
 	int rc;
 
@@ -4058,8 +4055,7 @@ collect_uncached_read_data(struct cifs_aio_ctx *ctx)
 						rdata->cfile, cifs_sb,
 						&tmp_list, ctx);
 
-					kref_put(&rdata->refcount,
-						cifs_readdata_release);
+					cifs_put_readdata(rdata);
 				}
 
 				list_splice(&tmp_list, &ctx->list);
@@ -4075,7 +4071,7 @@ collect_uncached_read_data(struct cifs_aio_ctx *ctx)
 			ctx->total_len += rdata->got_bytes;
 		}
 		list_del_init(&rdata->list);
-		kref_put(&rdata->refcount, cifs_readdata_release);
+		cifs_put_readdata(rdata);
 	}
 
 	/* mask nodata case */
@@ -4447,8 +4443,8 @@ static void cifs_unlock_folios(struct address_space *mapping, pgoff_t first, pgo
 
 static void cifs_readahead_complete(struct work_struct *work)
 {
-	struct cifs_readdata *rdata = container_of(work,
-						   struct cifs_readdata, work);
+	struct cifs_io_subrequest *rdata = container_of(work,
+							struct cifs_io_subrequest, work);
 	struct folio *folio;
 	pgoff_t last;
 	bool good = rdata->result == 0 || (rdata->result == -EAGAIN && rdata->got_bytes);
@@ -4474,7 +4470,7 @@ static void cifs_readahead_complete(struct work_struct *work)
 	}
 	rcu_read_unlock();
 
-	kref_put(&rdata->refcount, cifs_readdata_release);
+	cifs_put_readdata(rdata);
 }
 
 static void cifs_readahead(struct readahead_control *ractl)
@@ -4514,7 +4510,7 @@ static void cifs_readahead(struct readahead_control *ractl)
 	 */
 	while ((nr_pages = ra_pages)) {
 		unsigned int i, rsize;
-		struct cifs_readdata *rdata;
+		struct cifs_io_subrequest *rdata;
 		struct cifs_credits credits_on_stack;
 		struct cifs_credits *credits = &credits_on_stack;
 		struct folio *folio;
@@ -4633,11 +4629,11 @@ static void cifs_readahead(struct readahead_control *ractl)
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
index 708973ec750b..9da9ee98ae39 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -4478,7 +4478,7 @@ handle_read_data(struct TCP_Server_Info *server, struct mid_q_entry *mid,
 	unsigned int cur_off;
 	unsigned int cur_page_idx;
 	unsigned int pad_len;
-	struct cifs_readdata *rdata = mid->callback_data;
+	struct cifs_io_subrequest *rdata = mid->callback_data;
 	struct smb2_hdr *shdr = (struct smb2_hdr *)buf;
 	int length;
 	bool use_rdma_mr = false;
diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index cad402b426b7..3301a80a0f7e 100644
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
@@ -4356,7 +4358,7 @@ static inline bool smb3_use_rdma_offload(struct cifs_io_parms *io_parms)
  */
 static int
 smb2_new_read_req(void **buf, unsigned int *total_len,
-	struct cifs_io_parms *io_parms, struct cifs_readdata *rdata,
+	struct cifs_io_parms *io_parms, struct cifs_io_subrequest *rdata,
 	unsigned int remaining_bytes, int request_type)
 {
 	int rc = -EACCES;
@@ -4448,7 +4450,7 @@ smb2_new_read_req(void **buf, unsigned int *total_len,
 static void
 smb2_readv_callback(struct mid_q_entry *mid)
 {
-	struct cifs_readdata *rdata = mid->callback_data;
+	struct cifs_io_subrequest *rdata = mid->callback_data;
 	struct cifs_tcon *tcon = tlink_tcon(rdata->cfile->tlink);
 	struct TCP_Server_Info *server = rdata->server;
 	struct smb2_hdr *shdr =
@@ -4535,7 +4537,7 @@ smb2_readv_callback(struct mid_q_entry *mid)
 
 /* smb2_async_readv - send an async read, and set up mid to handle result */
 int
-smb2_async_readv(struct cifs_readdata *rdata)
+smb2_async_readv(struct cifs_io_subrequest *rdata)
 {
 	int rc, flags = 0;
 	char *buf;
@@ -4593,13 +4595,13 @@ smb2_async_readv(struct cifs_readdata *rdata)
 		flags |= CIFS_HAS_CREDITS;
 	}
 
-	kref_get(&rdata->refcount);
+	cifs_get_readdata(rdata);
 	rc = cifs_call_async(server, &rqst,
 			     cifs_readv_receive, smb2_readv_callback,
 			     smb3_handle_read_data, rdata, flags,
 			     &rdata->credits);
 	if (rc) {
-		kref_put(&rdata->refcount, cifs_readdata_release);
+		cifs_put_readdata(rdata);
 		cifs_stats_fail_inc(io_parms.tcon, SMB2_READ_HE);
 		trace_smb3_read_err(0 /* xid */, io_parms.persistent_fid,
 				    io_parms.tcon->tid,
diff --git a/fs/smb/client/smb2proto.h b/fs/smb/client/smb2proto.h
index d910d38671ee..6df87d294fbd 100644
--- a/fs/smb/client/smb2proto.h
+++ b/fs/smb/client/smb2proto.h
@@ -208,7 +208,7 @@ extern int SMB2_query_acl(const unsigned int xid, struct cifs_tcon *tcon,
 extern int SMB2_get_srv_num(const unsigned int xid, struct cifs_tcon *tcon,
 			    u64 persistent_fid, u64 volatile_fid,
 			    __le64 *uniqueid);
-extern int smb2_async_readv(struct cifs_readdata *rdata);
+extern int smb2_async_readv(struct cifs_io_subrequest *rdata);
 extern int SMB2_read(const unsigned int xid, struct cifs_io_parms *io_parms,
 		     unsigned int *nbytes, char **buf, int *buf_type);
 extern int smb2_async_writev(struct cifs_writedata *wdata,
diff --git a/fs/smb/client/transport.c b/fs/smb/client/transport.c
index 994d70193432..a5bab478e6de 100644
--- a/fs/smb/client/transport.c
+++ b/fs/smb/client/transport.c
@@ -1687,7 +1687,7 @@ __cifs_readv_discard(struct TCP_Server_Info *server, struct mid_q_entry *mid,
 static int
 cifs_readv_discard(struct TCP_Server_Info *server, struct mid_q_entry *mid)
 {
-	struct cifs_readdata *rdata = mid->callback_data;
+	struct cifs_io_subrequest *rdata = mid->callback_data;
 
 	return  __cifs_readv_discard(server, mid, rdata->result);
 }
@@ -1697,7 +1697,7 @@ cifs_readv_receive(struct TCP_Server_Info *server, struct mid_q_entry *mid)
 {
 	int length, len;
 	unsigned int data_offset, data_len;
-	struct cifs_readdata *rdata = mid->callback_data;
+	struct cifs_io_subrequest *rdata = mid->callback_data;
 	char *buf = server->smallbuf;
 	unsigned int buflen = server->pdu_size + HEADER_PREAMBLE_SIZE(server);
 	bool use_rdma_mr = false;


