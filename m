Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 115ED4F6E4E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Apr 2022 01:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237605AbiDFXGc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Apr 2022 19:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237604AbiDFXG3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Apr 2022 19:06:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 938A033E38
        for <linux-fsdevel@vger.kernel.org>; Wed,  6 Apr 2022 16:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649286269;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SiQ+VDScLVIVk/an87N+rHro3ohThxX/PINrx2UjV/s=;
        b=IKHxdMqFlkmFLC2BbQEpUDUyabo4sjwg5haoxpkYhoDxRs0dd85mFXfgxfmw2uoCtRWfBK
        LOwQsDBaYueCDy6qiIhB0sVElZcGTefa2Zekjmb6Ed1KdVHiWCE5O7jFxN5Wkxy3wWhg6r
        V8lJfL166hXRj/ozlC7GqPV/lIWCkZM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-541-3JHMOfKhPFm2VrzTSWYFoQ-1; Wed, 06 Apr 2022 19:04:24 -0400
X-MC-Unique: 3JHMOfKhPFm2VrzTSWYFoQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1FCFE299E770;
        Wed,  6 Apr 2022 23:04:24 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.37.45])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6766A40470FE;
        Wed,  6 Apr 2022 23:04:18 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 08/14] netfs: Allow the netfs to make the io (sub)request
 alloc larger
From:   David Howells <dhowells@redhat.com>
To:     linux-cachefs@redhat.com
Cc:     Steve French <sfrench@samba.org>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        linux-cifs@vger.kernel.org, dhowells@redhat.com,
        Steve French <sfrench@samba.org>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Jeff Layton <jlayton@redhat.com>, linux-cifs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Date:   Thu, 07 Apr 2022 00:04:18 +0100
Message-ID: <164928625799.457102.12830867127049009645.stgit@warthog.procyon.org.uk>
In-Reply-To: <164928615045.457102.10607899252434268982.stgit@warthog.procyon.org.uk>
References: <164928615045.457102.10607899252434268982.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Allow the network filesystem to specify extra space to be allocated on the
end of the io (sub)request.  This allows cifs, for example, to use this
space rather than allocating its own cifs_readdata struct.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Shyam Prasad N <nspmangalore@gmail.com>
cc: Rohith Surabattula <rohiths.msft@gmail.com>
cc: linux-cifs@vger.kernel.org
---

 fs/cifs/cifsglob.h  |   10 +++-----
 fs/cifs/cifsproto.h |    2 +-
 fs/cifs/cifssmb.c   |   22 +++++++-----------
 fs/cifs/file.c      |   63 ++++++++++++++++-----------------------------------
 fs/cifs/smb2ops.c   |    6 ++---
 fs/cifs/smb2pdu.c   |   18 ++++++---------
 fs/cifs/smb2proto.h |    2 +-
 7 files changed, 46 insertions(+), 77 deletions(-)

diff --git a/fs/cifs/cifsglob.h b/fs/cifs/cifsglob.h
index 49eb86ebbdfb..61b40721178a 100644
--- a/fs/cifs/cifsglob.h
+++ b/fs/cifs/cifsglob.h
@@ -212,7 +212,7 @@ struct dfs_info3_param;
 struct cifs_fattr;
 struct smb3_fs_context;
 struct cifs_fid;
-struct cifs_readdata;
+struct cifs_io_subrequest;
 struct cifs_writedata;
 struct cifs_io_parms;
 struct cifs_search_info;
@@ -378,7 +378,7 @@ struct smb_version_operations {
 	/* send a flush request to the server */
 	int (*flush)(const unsigned int, struct cifs_tcon *, struct cifs_fid *);
 	/* async read from the server */
-	int (*async_readv)(struct cifs_readdata *);
+	int (*async_readv)(struct cifs_io_subrequest *);
 	/* async write to the server */
 	int (*async_writev)(struct cifs_writedata *,
 			    void (*release)(struct kref *));
@@ -1314,16 +1314,14 @@ struct cifs_aio_ctx {
 };
 
 /* asynchronous read support */
-struct cifs_readdata {
-	struct netfs_io_subrequest	*subreq;
-	struct kref			refcount;
+struct cifs_io_subrequest {
+	struct netfs_io_subrequest	subreq;
 	struct cifsFileInfo		*cfile;
 	__u64				offset;
 	ssize_t				got_bytes;
 	unsigned int			bytes;
 	pid_t				pid;
 	int				result;
-	struct iov_iter			iter;
 	struct kvec			iov[2];
 	struct TCP_Server_Info		*server;
 #ifdef CONFIG_CIFS_SMB_DIRECT
diff --git a/fs/cifs/cifsproto.h b/fs/cifs/cifsproto.h
index 981b6f779f2e..5090992eaa15 100644
--- a/fs/cifs/cifsproto.h
+++ b/fs/cifs/cifsproto.h
@@ -575,7 +575,7 @@ extern struct cifs_ses *
 cifs_get_smb_ses(struct TCP_Server_Info *server, struct smb3_fs_context *ctx);
 
 void cifs_readdata_release(struct kref *refcount);
-int cifs_async_readv(struct cifs_readdata *rdata);
+int cifs_async_readv(struct cifs_io_subrequest *rdata);
 int cifs_readv_receive(struct TCP_Server_Info *server, struct mid_q_entry *mid);
 
 int cifs_async_writev(struct cifs_writedata *wdata,
diff --git a/fs/cifs/cifssmb.c b/fs/cifs/cifssmb.c
index 5956caaec0e3..f736493746b4 100644
--- a/fs/cifs/cifssmb.c
+++ b/fs/cifs/cifssmb.c
@@ -24,6 +24,7 @@
 #include <linux/task_io_accounting_ops.h>
 #include <linux/uaccess.h>
 #include <linux/netfs.h>
+#include <trace/events/netfs.h>
 #include "cifspdu.h"
 #include "cifsfs.h"
 #include "cifsglob.h"
@@ -1424,7 +1425,7 @@ __cifs_readv_discard(struct TCP_Server_Info *server, struct mid_q_entry *mid,
 static int
 cifs_readv_discard(struct TCP_Server_Info *server, struct mid_q_entry *mid)
 {
-	struct cifs_readdata *rdata = mid->callback_data;
+	struct cifs_io_subrequest *rdata = mid->callback_data;
 
 	return  __cifs_readv_discard(server, mid, rdata->result);
 }
@@ -1434,7 +1435,7 @@ cifs_readv_receive(struct TCP_Server_Info *server, struct mid_q_entry *mid)
 {
 	int length, len;
 	unsigned int data_offset, data_len;
-	struct cifs_readdata *rdata = mid->callback_data;
+	struct cifs_io_subrequest *rdata = mid->callback_data;
 	char *buf = server->smallbuf;
 	unsigned int buflen = server->pdu_size +
 		server->vals->header_preamble_size;
@@ -1546,7 +1547,7 @@ cifs_readv_receive(struct TCP_Server_Info *server, struct mid_q_entry *mid)
 		length = data_len; /* An RDMA read is already done. */
 	else
 #endif
-		length = cifs_read_iter_from_socket(server, &rdata->iter,
+		length = cifs_read_iter_from_socket(server, &rdata->subreq.iter,
 						    data_len);
 	if (length > 0)
 		rdata->got_bytes += length;
@@ -1568,12 +1569,12 @@ cifs_readv_receive(struct TCP_Server_Info *server, struct mid_q_entry *mid)
 static void
 cifs_readv_callback(struct mid_q_entry *mid)
 {
-	struct cifs_readdata *rdata = mid->callback_data;
+	struct cifs_io_subrequest *rdata = mid->callback_data;
 	struct cifs_tcon *tcon = tlink_tcon(rdata->cfile->tlink);
 	struct TCP_Server_Info *server = tcon->ses->server;
 	struct smb_rqst rqst = { .rq_iov = rdata->iov,
 				 .rq_nvec = 2,
-				 .rq_iter = rdata->iter };
+				 .rq_iter = rdata->subreq.iter };
 	struct cifs_credits credits = { .value = 1, .instance = 0 };
 
 	cifs_dbg(FYI, "%s: mid=%llu state=%d result=%d bytes=%u\n",
@@ -1611,19 +1612,18 @@ cifs_readv_callback(struct mid_q_entry *mid)
 	}
 
 	if (rdata->result == 0 || rdata->result == -EAGAIN)
-		iov_iter_advance(&rdata->subreq->iter, rdata->got_bytes);
-	netfs_subreq_terminated(rdata->subreq,
+		iov_iter_advance(&rdata->subreq.iter, rdata->got_bytes);
+	netfs_subreq_terminated(&rdata->subreq,
 				(rdata->result == 0 || rdata->result == -EAGAIN) ?
 				rdata->got_bytes : rdata->result,
 				false);
-	kref_put(&rdata->refcount, cifs_readdata_release);
 	DeleteMidQEntry(mid);
 	add_credits(server, &credits, 0);
 }
 
 /* cifs_async_readv - send an async write, and set up mid to handle result */
 int
-cifs_async_readv(struct cifs_readdata *rdata)
+cifs_async_readv(struct cifs_io_subrequest *rdata)
 {
 	int rc;
 	READ_REQ *smb = NULL;
@@ -1675,15 +1675,11 @@ cifs_async_readv(struct cifs_readdata *rdata)
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
diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index fcf92c25bc8f..fb2885134154 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -3322,35 +3322,6 @@ cifs_strict_writev(struct kiocb *iocb, struct iov_iter *from)
 	return written;
 }
 
-static struct cifs_readdata *cifs_readdata_alloc(work_func_t complete)
-{
-	struct cifs_readdata *rdata;
-
-	rdata = kzalloc(sizeof(*rdata), GFP_KERNEL);
-	if (rdata)
-		kref_init(&rdata->refcount);
-
-	return rdata;
-}
-
-void
-cifs_readdata_release(struct kref *refcount)
-{
-	struct cifs_readdata *rdata = container_of(refcount,
-					struct cifs_readdata, refcount);
-
-#ifdef CONFIG_CIFS_SMB_DIRECT
-	if (rdata->mr) {
-		smbd_deregister_mr(rdata->mr);
-		rdata->mr = NULL;
-	}
-#endif
-	if (rdata->cfile)
-		cifsFileInfo_put(rdata->cfile);
-
-	kfree(rdata);
-}
-
 ssize_t
 cifs_strict_readv(struct kiocb *iocb, struct iov_iter *to)
 {
@@ -3476,7 +3447,7 @@ static void cifs_req_issue_read(struct netfs_io_subrequest *subreq)
 {
 	struct netfs_io_request *rreq = subreq->rreq;
 	struct TCP_Server_Info *server;
-	struct cifs_readdata *rdata;
+	struct cifs_io_subrequest *rdata = container_of(subreq, struct cifs_io_subrequest, subreq);
 	struct cifsFileInfo *open_file = rreq->netfs_priv;
 	struct cifs_sb_info *cifs_sb = CIFS_SB(rreq->inode->i_sb);
 	struct cifs_credits credits_on_stack, *credits = &credits_on_stack;
@@ -3515,22 +3486,13 @@ static void cifs_req_issue_read(struct netfs_io_subrequest *subreq)
 	if (rc)
 		goto out;
 
-	rdata = cifs_readdata_alloc(NULL);
-	if (!rdata) {
-		add_credits_and_wake_if(server, credits, 0);
-		rc = -ENOMEM;
-		goto out;
-	}
-
 	__set_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags);
-	rdata->subreq	= subreq;
 	rdata->cfile	= cifsFileInfo_get(open_file);
 	rdata->server	= server;
 	rdata->offset	= subreq->start + subreq->transferred;
 	rdata->bytes	= subreq->len   - subreq->transferred;
 	rdata->pid	= pid;
 	rdata->credits	= credits_on_stack;
-	rdata->iter	= subreq->iter;
 
 	rc = adjust_credits(server, &rdata->credits, rdata->bytes);
 	if (!rc) {
@@ -3543,12 +3505,8 @@ static void cifs_req_issue_read(struct netfs_io_subrequest *subreq)
 	if (rc) {
 		add_credits_and_wake_if(server, &rdata->credits, 0);
 		/* Fallback to the readpage in error/reconnect cases */
-		kref_put(&rdata->refcount, cifs_readdata_release);
-		goto out;
 	}
 
-	kref_put(&rdata->refcount, cifs_readdata_release);
-
 out:
 	free_xid(xid);
 	if (rc)
@@ -3614,8 +3572,27 @@ static int cifs_begin_cache_operation(struct netfs_io_request *rreq)
 #endif
 }
 
+static void cifs_free_subrequest(struct netfs_io_subrequest *subreq)
+{
+	struct cifs_io_subrequest *rdata =
+		container_of(subreq, struct cifs_io_subrequest, subreq);
+
+	if (rdata->subreq.source == NETFS_DOWNLOAD_FROM_SERVER) {
+#ifdef CONFIG_CIFS_SMB_DIRECT
+		if (rdata->mr) {
+			smbd_deregister_mr(rdata->mr);
+			rdata->mr = NULL;
+		}
+#endif
+		if (rdata->cfile)
+			cifsFileInfo_put(rdata->cfile);
+	}
+}
+
 const struct netfs_request_ops cifs_req_ops = {
+	.io_subrequest_size	= sizeof(struct cifs_io_subrequest),
 	.init_request		= cifs_init_request,
+	.free_subrequest	= cifs_free_subrequest,
 	.begin_cache_operation	= cifs_begin_cache_operation,
 	.expand_readahead	= cifs_expand_readahead,
 	.issue_read		= cifs_req_issue_read,
diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index 2caac8696100..03bd64933b7b 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -4842,7 +4842,7 @@ handle_read_data(struct TCP_Server_Info *server, struct mid_q_entry *mid,
 	unsigned int cur_off;
 	unsigned int cur_page_idx;
 	unsigned int pad_len;
-	struct cifs_readdata *rdata = mid->callback_data;
+	struct cifs_io_subrequest *rdata = mid->callback_data;
 	struct smb2_hdr *shdr = (struct smb2_hdr *)buf;
 	int length;
 	bool use_rdma_mr = false;
@@ -4944,7 +4944,7 @@ handle_read_data(struct TCP_Server_Info *server, struct mid_q_entry *mid,
 
 		/* Copy the data to the output I/O iterator. */
 		rdata->result = cifs_copy_pages_to_iter(pages, pages_len,
-							cur_off, &rdata->iter);
+							cur_off, &rdata->subreq.iter);
 		if (rdata->result != 0) {
 			if (is_offloaded)
 				mid->mid_state = MID_RESPONSE_MALFORMED;
@@ -4958,7 +4958,7 @@ handle_read_data(struct TCP_Server_Info *server, struct mid_q_entry *mid,
 		/* read response payload is in buf */
 		WARN_ONCE(pages && !xa_empty(pages),
 			  "read data can be either in buf or in pages");
-		length = copy_to_iter(buf + data_offset, data_len, &rdata->iter);
+		length = copy_to_iter(buf + data_offset, data_len, &rdata->subreq.iter);
 		if (length < 0)
 			return length;
                rdata->got_bytes = data_len;
diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
index 19ad6c89121a..696e38da9ae7 100644
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -24,6 +24,7 @@
 #include <linux/pagemap.h>
 #include <linux/xattr.h>
 #include <linux/netfs.h>
+#include <trace/events/netfs.h>
 #include "cifsglob.h"
 #include "cifsacl.h"
 #include "cifsproto.h"
@@ -4012,7 +4013,7 @@ SMB2_flush(const unsigned int xid, struct cifs_tcon *tcon, u64 persistent_fid,
  */
 static int
 smb2_new_read_req(void **buf, unsigned int *total_len,
-	struct cifs_io_parms *io_parms, struct cifs_readdata *rdata,
+	struct cifs_io_parms *io_parms, struct cifs_io_subrequest *rdata,
 	unsigned int remaining_bytes, int request_type)
 {
 	int rc = -EACCES;
@@ -4108,7 +4109,7 @@ smb2_new_read_req(void **buf, unsigned int *total_len,
 static void
 smb2_readv_callback(struct mid_q_entry *mid)
 {
-	struct cifs_readdata *rdata = mid->callback_data;
+	struct cifs_io_subrequest *rdata = mid->callback_data;
 	struct cifs_tcon *tcon = tlink_tcon(rdata->cfile->tlink);
 	struct TCP_Server_Info *server = rdata->server;
 	struct smb2_hdr *shdr =
@@ -4116,7 +4117,7 @@ smb2_readv_callback(struct mid_q_entry *mid)
 	struct cifs_credits credits = { .value = 0, .instance = 0 };
 	struct smb_rqst rqst = { .rq_iov = &rdata->iov[1],
 				 .rq_nvec = 1,
-				 .rq_iter = rdata->iter };
+				 .rq_iter = rdata->subreq.iter };
 
 	WARN_ONCE(rdata->server != mid->server,
 		  "rdata server %p != mid server %p",
@@ -4187,22 +4188,21 @@ smb2_readv_callback(struct mid_q_entry *mid)
 		/* We may have got an EOF error because fallocate
 		 * failed to enlarge the file.
 		 */
-		if (rdata->subreq->start < rdata->subreq->rreq->i_size)
+		if (rdata->subreq.start < rdata->subreq.rreq->i_size)
 			rdata->result = 0;
 	}
 	if (rdata->result == 0 || rdata->result == -EAGAIN)
-		iov_iter_advance(&rdata->subreq->iter, rdata->got_bytes);
-	netfs_subreq_terminated(rdata->subreq,
+		iov_iter_advance(&rdata->subreq.iter, rdata->got_bytes);
+	netfs_subreq_terminated(&rdata->subreq,
 				(rdata->result == 0 || rdata->result == -EAGAIN) ?
 				rdata->got_bytes : rdata->result, true);
-	kref_put(&rdata->refcount, cifs_readdata_release);
 	DeleteMidQEntry(mid);
 	add_credits(server, &credits, 0);
 }
 
 /* smb2_async_readv - send an async read, and set up mid to handle result */
 int
-smb2_async_readv(struct cifs_readdata *rdata)
+smb2_async_readv(struct cifs_io_subrequest *rdata)
 {
 	int rc, flags = 0;
 	char *buf;
@@ -4253,13 +4253,11 @@ smb2_async_readv(struct cifs_readdata *rdata)
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
diff --git a/fs/cifs/smb2proto.h b/fs/cifs/smb2proto.h
index a69f1eed1cfe..fa36bb52c83b 100644
--- a/fs/cifs/smb2proto.h
+++ b/fs/cifs/smb2proto.h
@@ -197,7 +197,7 @@ extern int SMB2_query_acl(const unsigned int xid, struct cifs_tcon *tcon,
 extern int SMB2_get_srv_num(const unsigned int xid, struct cifs_tcon *tcon,
 			    u64 persistent_fid, u64 volatile_fid,
 			    __le64 *uniqueid);
-extern int smb2_async_readv(struct cifs_readdata *rdata);
+extern int smb2_async_readv(struct cifs_io_subrequest *rdata);
 extern int SMB2_read(const unsigned int xid, struct cifs_io_parms *io_parms,
 		     unsigned int *nbytes, char **buf, int *buf_type);
 extern int smb2_async_writev(struct cifs_writedata *wdata,


