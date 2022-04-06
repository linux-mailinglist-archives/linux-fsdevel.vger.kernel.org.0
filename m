Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2FBC4F6E65
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Apr 2022 01:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237738AbiDFXHM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Apr 2022 19:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237716AbiDFXGl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Apr 2022 19:06:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D9B7EE0CC
        for <linux-fsdevel@vger.kernel.org>; Wed,  6 Apr 2022 16:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649286282;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w7h7+PuFLAksX+bBW4/tZmn4xBNA1eMgPeuAnKSM7lg=;
        b=OBseqo1kdq0itQVo3EXPRoUzua1qcoly5TvwlJ8LZb7uaJGrc59YnfZ7Wo7BbSt8FFddqy
        OKzBo8bh4Ad4XIg7+7vXV6ifzTnh3UxEQnA4nD03ExWkQ9TEbdbs4R1m52iQoeow/kcmUq
        MsDES8wHOCd1Ak5op0ezXXvgV164Cw4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-403-N3eexJxfNqeP5v9fobSlTQ-1; Wed, 06 Apr 2022 19:04:39 -0400
X-MC-Unique: N3eexJxfNqeP5v9fobSlTQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8AC1A29AB3E0;
        Wed,  6 Apr 2022 23:04:38 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.37.45])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2A0CB145B973;
        Wed,  6 Apr 2022 23:04:36 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 10/14] cifs: Hold the open file on netfs_io_request,
 not netfs_io_subrequest
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
Date:   Thu, 07 Apr 2022 00:04:36 +0100
Message-ID: <164928627647.457102.2829578394147148029.stgit@warthog.procyon.org.uk>
In-Reply-To: <164928615045.457102.10607899252434268982.stgit@warthog.procyon.org.uk>
References: <164928615045.457102.10607899252434268982.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
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

Hold the file open on the netfs_io_request rather than on the
netfs_io_subrequest struct, thereby sharing the open file with all
subrequests contributing to a request.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Shyam Prasad N <nspmangalore@gmail.com>
cc: Rohith Surabattula <rohiths.msft@gmail.com>
cc: linux-cifs@vger.kernel.org
---

 fs/cifs/cifsglob.h |   12 ++++++++++--
 fs/cifs/cifssmb.c  |    6 +++---
 fs/cifs/file.c     |   32 +++++++++++++++++++++-----------
 fs/cifs/smb2pdu.c  |   14 +++++++-------
 4 files changed, 41 insertions(+), 23 deletions(-)

diff --git a/fs/cifs/cifsglob.h b/fs/cifs/cifsglob.h
index 61b40721178a..e1e77225d634 100644
--- a/fs/cifs/cifsglob.h
+++ b/fs/cifs/cifsglob.h
@@ -1313,10 +1313,18 @@ struct cifs_aio_ctx {
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
+	union {
+		struct netfs_io_subrequest subreq;
+		struct netfs_io_request *rreq;
+		struct cifs_io_request *req;
+	};
 	__u64				offset;
 	ssize_t				got_bytes;
 	unsigned int			bytes;
diff --git a/fs/cifs/cifssmb.c b/fs/cifs/cifssmb.c
index f736493746b4..0c039eee1234 100644
--- a/fs/cifs/cifssmb.c
+++ b/fs/cifs/cifssmb.c
@@ -1570,7 +1570,7 @@ static void
 cifs_readv_callback(struct mid_q_entry *mid)
 {
 	struct cifs_io_subrequest *rdata = mid->callback_data;
-	struct cifs_tcon *tcon = tlink_tcon(rdata->cfile->tlink);
+	struct cifs_tcon *tcon = tlink_tcon(rdata->req->cfile->tlink);
 	struct TCP_Server_Info *server = tcon->ses->server;
 	struct smb_rqst rqst = { .rq_iov = rdata->iov,
 				 .rq_nvec = 2,
@@ -1628,7 +1628,7 @@ cifs_async_readv(struct cifs_io_subrequest *rdata)
 	int rc;
 	READ_REQ *smb = NULL;
 	int wct;
-	struct cifs_tcon *tcon = tlink_tcon(rdata->cfile->tlink);
+	struct cifs_tcon *tcon = tlink_tcon(rdata->req->cfile->tlink);
 	struct smb_rqst rqst = { .rq_iov = rdata->iov,
 				 .rq_nvec = 2 };
 
@@ -1653,7 +1653,7 @@ cifs_async_readv(struct cifs_io_subrequest *rdata)
 	smb->hdr.PidHigh = cpu_to_le16((__u16)(rdata->pid >> 16));
 
 	smb->AndXCommand = 0xFF;	/* none */
-	smb->Fid = rdata->cfile->fid.netfid;
+	smb->Fid = rdata->req->cfile->fid.netfid;
 	smb->OffsetLow = cpu_to_le32(rdata->offset & 0xFFFFFFFF);
 	if (wct == 12)
 		smb->OffsetHigh = cpu_to_le32(rdata->offset >> 32);
diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index fc3a46f7e2cf..45510bd1f702 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -3448,7 +3448,7 @@ static void cifs_req_issue_read(struct netfs_io_subrequest *subreq)
 	struct netfs_io_request *rreq = subreq->rreq;
 	struct TCP_Server_Info *server;
 	struct cifs_io_subrequest *rdata = container_of(subreq, struct cifs_io_subrequest, subreq);
-	struct cifsFileInfo *open_file = rreq->netfs_priv;
+	struct cifs_io_request *req = container_of(subreq->rreq, struct cifs_io_request, rreq);
 	struct cifs_sb_info *cifs_sb = CIFS_SB(rreq->inode->i_sb);
 	unsigned int xid;
 	pid_t pid;
@@ -3458,19 +3458,19 @@ static void cifs_req_issue_read(struct netfs_io_subrequest *subreq)
 	xid = get_xid();
 
 	if (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_RWPIDFORWARD)
-		pid = open_file->pid;
+		pid = req->cfile->pid;
 	else
 		pid = current->tgid; // Ummm...  This may be a workqueue
 
-	server = cifs_pick_channel(tlink_tcon(open_file->tlink)->ses);
+	server = cifs_pick_channel(tlink_tcon(req->cfile->tlink)->ses);
 
 	cifs_dbg(FYI, "%s: op=%08x[%x] mapping=%p len=%zu/%zu\n",
 		 __func__, rreq->debug_id, subreq->debug_index, rreq->mapping,
 		 subreq->transferred, subreq->len);
 
-	if (open_file->invalidHandle) {
+	if (req->cfile->invalidHandle) {
 		do {
-			rc = cifs_reopen_file(open_file, true);
+			rc = cifs_reopen_file(req->cfile, true);
 		} while (rc == -EAGAIN);
 		if (rc)
 			goto out;
@@ -3478,7 +3478,7 @@ static void cifs_req_issue_read(struct netfs_io_subrequest *subreq)
 
 	if (cifs_sb->ctx->rsize == 0)
 		cifs_sb->ctx->rsize =
-			server->ops->negotiate_rsize(tlink_tcon(open_file->tlink),
+			server->ops->negotiate_rsize(tlink_tcon(req->cfile->tlink),
 						     cifs_sb->ctx);
 
 	rc = server->ops->wait_mtu_credits(server, cifs_sb->ctx->rsize, &rsize,
@@ -3487,7 +3487,6 @@ static void cifs_req_issue_read(struct netfs_io_subrequest *subreq)
 		goto out;
 
 	__set_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags);
-	rdata->cfile	= cifsFileInfo_get(open_file);
 	rdata->server	= server;
 	rdata->offset	= subreq->start + subreq->transferred;
 	rdata->bytes	= subreq->len   - subreq->transferred;
@@ -3495,7 +3494,7 @@ static void cifs_req_issue_read(struct netfs_io_subrequest *subreq)
 
 	rc = adjust_credits(server, &rdata->credits, rdata->bytes);
 	if (!rc) {
-		if (rdata->cfile->invalidHandle)
+		if (rdata->req->cfile->invalidHandle)
 			rc = -EAGAIN;
 		else
 			rc = server->ops->async_readv(rdata);
@@ -3509,7 +3508,10 @@ static void cifs_req_issue_read(struct netfs_io_subrequest *subreq)
 
 static int cifs_init_request(struct netfs_io_request *rreq, struct file *file)
 {
-	rreq->netfs_priv = file->private_data;
+	struct cifs_io_request *req = container_of(rreq, struct cifs_io_request, rreq);
+	struct cifsFileInfo *open_file = file->private_data;
+
+	req->cfile = cifsFileInfo_get(open_file);
 	return 0;
 }
 
@@ -3566,6 +3568,14 @@ static int cifs_begin_cache_operation(struct netfs_io_request *rreq)
 #endif
 }
 
+static void cifs_free_request(struct netfs_io_request *rreq)
+{
+	struct cifs_io_request *req = container_of(rreq, struct cifs_io_request, rreq);
+
+	if (req->cfile)
+		cifsFileInfo_put(req->cfile);
+}
+
 static void cifs_free_subrequest(struct netfs_io_subrequest *subreq)
 {
 	struct cifs_io_subrequest *rdata =
@@ -3580,14 +3590,14 @@ static void cifs_free_subrequest(struct netfs_io_subrequest *subreq)
 #endif
 
 		add_credits_and_wake_if(rdata->server, &rdata->credits, 0);
-		if (rdata->cfile)
-			cifsFileInfo_put(rdata->cfile);
 	}
 }
 
 const struct netfs_request_ops cifs_req_ops = {
+	.io_request_size	= sizeof(struct cifs_io_request),
 	.io_subrequest_size	= sizeof(struct cifs_io_subrequest),
 	.init_request		= cifs_init_request,
+	.free_request		= cifs_free_request,
 	.free_subrequest	= cifs_free_subrequest,
 	.begin_cache_operation	= cifs_begin_cache_operation,
 	.expand_readahead	= cifs_expand_readahead,
diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
index 696e38da9ae7..6a8aaa003e54 100644
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -4110,7 +4110,7 @@ static void
 smb2_readv_callback(struct mid_q_entry *mid)
 {
 	struct cifs_io_subrequest *rdata = mid->callback_data;
-	struct cifs_tcon *tcon = tlink_tcon(rdata->cfile->tlink);
+	struct cifs_tcon *tcon = tlink_tcon(rdata->req->cfile->tlink);
 	struct TCP_Server_Info *server = rdata->server;
 	struct smb2_hdr *shdr =
 				(struct smb2_hdr *)rdata->iov[0].iov_base;
@@ -4175,12 +4175,12 @@ smb2_readv_callback(struct mid_q_entry *mid)
 	if (rdata->result && rdata->result != -ENODATA) {
 		cifs_stats_fail_inc(tcon, SMB2_READ_HE);
 		trace_smb3_read_err(0 /* xid */,
-				    rdata->cfile->fid.persistent_fid,
+				    rdata->req->cfile->fid.persistent_fid,
 				    tcon->tid, tcon->ses->Suid, rdata->offset,
 				    rdata->bytes, rdata->result);
 	} else
 		trace_smb3_read_done(0 /* xid */,
-				     rdata->cfile->fid.persistent_fid,
+				     rdata->req->cfile->fid.persistent_fid,
 				     tcon->tid, tcon->ses->Suid,
 				     rdata->offset, rdata->got_bytes);
 
@@ -4211,7 +4211,7 @@ smb2_async_readv(struct cifs_io_subrequest *rdata)
 	struct smb_rqst rqst = { .rq_iov = rdata->iov,
 				 .rq_nvec = 1 };
 	struct TCP_Server_Info *server;
-	struct cifs_tcon *tcon = tlink_tcon(rdata->cfile->tlink);
+	struct cifs_tcon *tcon = tlink_tcon(rdata->req->cfile->tlink);
 	unsigned int total_len;
 
 	cifs_dbg(FYI, "%s: offset=%llu bytes=%u\n",
@@ -4220,12 +4220,12 @@ smb2_async_readv(struct cifs_io_subrequest *rdata)
 	if (!rdata->server)
 		rdata->server = cifs_pick_channel(tcon->ses);
 
-	io_parms.tcon = tlink_tcon(rdata->cfile->tlink);
+	io_parms.tcon = tlink_tcon(rdata->req->cfile->tlink);
 	io_parms.server = server = rdata->server;
 	io_parms.offset = rdata->offset;
 	io_parms.length = rdata->bytes;
-	io_parms.persistent_fid = rdata->cfile->fid.persistent_fid;
-	io_parms.volatile_fid = rdata->cfile->fid.volatile_fid;
+	io_parms.persistent_fid = rdata->req->cfile->fid.persistent_fid;
+	io_parms.volatile_fid = rdata->req->cfile->fid.volatile_fid;
 	io_parms.pid = rdata->pid;
 
 	rc = smb2_new_read_req(


