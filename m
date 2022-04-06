Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EFA34F6E5E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Apr 2022 01:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237687AbiDFXIC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Apr 2022 19:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237620AbiDFXHJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Apr 2022 19:07:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AB2EF17E36
        for <linux-fsdevel@vger.kernel.org>; Wed,  6 Apr 2022 16:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649286294;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7ksHuD9EsHcVMNVLSmO/uWKDVO0pBQnbXvRVLyq28ew=;
        b=IvFvjiaPcGdf2hTActXCEKCaWkKLEcz3JVZGw3FnK/CzaxrrvZdJJQ49NRsWA76kHO8Qu4
        v6VS1MIpMB8tdFcsZMIwNpxeO5fUfqpspy3aT2kpP6c/QCKOySQpWy5ubTD7D6zMe0sta1
        +1oRdI22A8vZDGP4tdZV6HHrenHK0aM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-177-dI7o37mHPsuDVVUf2e_fkA-1; Wed, 06 Apr 2022 19:04:53 -0400
X-MC-Unique: dI7o37mHPsuDVVUf2e_fkA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 49EDE85A5BC;
        Wed,  6 Apr 2022 23:04:53 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.37.45])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DAF4640CF910;
        Wed,  6 Apr 2022 23:04:51 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 12/14] cifs: Expose netfs subrequest debug ID and index in
 read tracepoints
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
Date:   Thu, 07 Apr 2022 00:04:51 +0100
Message-ID: <164928629102.457102.17739324885642025232.stgit@warthog.procyon.org.uk>
In-Reply-To: <164928615045.457102.10607899252434268982.stgit@warthog.procyon.org.uk>
References: <164928615045.457102.10607899252434268982.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Expose the netfs request debug ID and subrequest index in the
smb3_read_enter, smb3_read_done and smb3_read_err tracepoints to match the
netfs tracepoints for convenient grepping.

Also expose the xid in some tracepoints where it is now available by virtue
of being stashed in the cifs_io_subrequest struct.

In future, the write tracepoints should be able to expose this also.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Shyam Prasad N <nspmangalore@gmail.com>
cc: Rohith Surabattula <rohiths.msft@gmail.com>
cc: linux-cifs@vger.kernel.org
---

 fs/cifs/smb2pdu.c |   35 ++++++++-----
 fs/cifs/trace.h   |  144 ++++++++++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 147 insertions(+), 32 deletions(-)

diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
index 952f242bee55..9a828b56d95a 100644
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -4041,10 +4041,12 @@ smb2_new_read_req(void **buf, unsigned int *total_len,
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
@@ -4174,12 +4176,16 @@ smb2_readv_callback(struct mid_q_entry *mid)
 #endif
 	if (rdata->result && rdata->result != -ENODATA) {
 		cifs_stats_fail_inc(tcon, SMB2_READ_HE);
-		trace_smb3_read_err(rdata->xid,
+		trace_smb3_read_err(rdata->rreq->debug_id,
+				    rdata->subreq.debug_index,
+				    rdata->xid,
 				    rdata->req->cfile->fid.persistent_fid,
 				    tcon->tid, tcon->ses->Suid, rdata->offset,
 				    rdata->bytes, rdata->result);
 	} else
-		trace_smb3_read_done(0 /* xid */,
+		trace_smb3_read_done(rdata->rreq->debug_id,
+				     rdata->subreq.debug_index,
+				     rdata->xid,
 				     rdata->req->cfile->fid.persistent_fid,
 				     tcon->tid, tcon->ses->Suid,
 				     rdata->offset, rdata->got_bytes);
@@ -4260,7 +4266,9 @@ smb2_async_readv(struct cifs_io_subrequest *rdata)
 			     &rdata->credits);
 	if (rc) {
 		cifs_stats_fail_inc(io_parms.tcon, SMB2_READ_HE);
-		trace_smb3_read_err(rdata->xid, io_parms.persistent_fid,
+		trace_smb3_read_err(rdata->rreq->debug_id,
+				    rdata->subreq.debug_index,
+				    rdata->xid, io_parms.persistent_fid,
 				    io_parms.tcon->tid,
 				    io_parms.tcon->ses->Suid,
 				    io_parms.offset, io_parms.length, rc);
@@ -4311,22 +4319,23 @@ SMB2_read(const unsigned int xid, struct cifs_io_parms *io_parms,
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
 
diff --git a/fs/cifs/trace.h b/fs/cifs/trace.h
index 6cecf302dcfd..c85cf0971eee 100644
--- a/fs/cifs/trace.h
+++ b/fs/cifs/trace.h
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
 
 /*
  * For handle based calls other than read and write, and get/set info


