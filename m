Return-Path: <linux-fsdevel+bounces-29006-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79552972F18
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 11:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE5E61F223C6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 09:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D720D18C030;
	Tue, 10 Sep 2024 09:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pVVeKoRF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333EC186E4B;
	Tue, 10 Sep 2024 09:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725961694; cv=none; b=tUvCukdI9HfkSb0J0W6TNRJH34a1udwYXv2hlu7Ncu05KGQ4NzII9vI2aTLmp07BJ19sHM8MJ1e5vAr4ksnVsFPrbDODyHADRcF59O064XJu5qB42aVnAnVFGaTfMj1HR2qXj6uVnaZWfs9Q0tW7ckBT3SSeGWWZixirhyvedT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725961694; c=relaxed/simple;
	bh=SsPPc8/ju8UxBgxLMPTlbFOKFK9qbk1Rd0JClPmxdgk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z38F/xnZeRDGA4iCExbWdeXSCPcdKnb+VE/GV0MMX+7O0fOAMFpPdxVBZZYWSpbgVphAD/nIyoI7ufuFFbsRGBgcF7PpUVc8KkcBHkJRmhV2oFDKgIhUPQEV0y7WOgEHkfXLm5My3l0hobWkBkR6u5mbr8PDYixUKjWo0zuBG2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pVVeKoRF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5624BC4CEC3;
	Tue, 10 Sep 2024 09:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725961693;
	bh=SsPPc8/ju8UxBgxLMPTlbFOKFK9qbk1Rd0JClPmxdgk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pVVeKoRFQCUAfB14bJUxWc/BWT8fOc3iiFFtUowkPrtmE7k+AWY54HhN5TJpjOqQk
	 uuNVZ16+Ouy7+Szw14VnburQx6cdkavzVRyxGAry5Rkm1O20EPEKyXMpyT81Oaiy4y
	 FllbAijjPleU+rxuvx1ooYmUEH/TOVGx468omWhA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Howells <dhowells@redhat.com>,
	Steve French <sfrench@samba.org>,
	Paulo Alcantara <pc@manguebit.com>,
	Jeff Layton <jlayton@kernel.org>,
	linux-cifs@vger.kernel.org,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 156/375] cifs: Fix lack of credit renegotiation on read retry
Date: Tue, 10 Sep 2024 11:29:13 +0200
Message-ID: <20240910092627.714206606@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910092622.245959861@linuxfoundation.org>
References: <20240910092622.245959861@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Howells <dhowells@redhat.com>

[ Upstream commit 6a5dcd487791e0c2d86622064602a5c7459941ed ]

When netfslib asks cifs to issue a read operation, it prefaces this with a
call to ->clamp_length() which cifs uses to negotiate credits, providing
receive capacity on the server; however, in the event that a read op needs
reissuing, netfslib doesn't call ->clamp_length() again as that could
shorten the subrequest, leaving a gap.

This causes the retried read to be done with zero credits which causes the
server to reject it with STATUS_INVALID_PARAMETER.  This is a problem for a
DIO read that is requested that would go over the EOF.  The short read will
be retried, causing EINVAL to be returned to the user when it fails.

Fix this by making cifs_req_issue_read() negotiate new credits if retrying
(NETFS_SREQ_RETRYING now gets set in the read side as well as the write
side in this instance).

This isn't sufficient, however: the new credits might not be sufficient to
complete the remainder of the read, so also add an additional field,
rreq->actual_len, that holds the actual size of the op we want to perform
without having to alter subreq->len.

We then rely on repeated short reads being retried until we finish the read
or reach the end of file and make a zero-length read.

Also fix a couple of places where the subrequest start and length need to
be altered by the amount so far transferred when being used.

Fixes: 69c3c023af25 ("cifs: Implement netfslib hooks")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/netfs/io.c            |  2 ++
 fs/smb/client/cifsglob.h |  1 +
 fs/smb/client/file.c     | 37 +++++++++++++++++++++++++++++++++----
 fs/smb/client/smb2ops.c  |  2 +-
 fs/smb/client/smb2pdu.c  | 28 +++++++++++++++++-----------
 fs/smb/client/trace.h    |  1 +
 6 files changed, 55 insertions(+), 16 deletions(-)

diff --git a/fs/netfs/io.c b/fs/netfs/io.c
index c96431d3da6d..2a5c22606fb1 100644
--- a/fs/netfs/io.c
+++ b/fs/netfs/io.c
@@ -306,6 +306,7 @@ static bool netfs_rreq_perform_resubmissions(struct netfs_io_request *rreq)
 				break;
 			subreq->source = NETFS_DOWNLOAD_FROM_SERVER;
 			subreq->error = 0;
+			__set_bit(NETFS_SREQ_RETRYING, &subreq->flags);
 			netfs_stat(&netfs_n_rh_download_instead);
 			trace_netfs_sreq(subreq, netfs_sreq_trace_download_instead);
 			netfs_get_subrequest(subreq, netfs_sreq_trace_get_resubmit);
@@ -313,6 +314,7 @@ static bool netfs_rreq_perform_resubmissions(struct netfs_io_request *rreq)
 			netfs_reset_subreq_iter(rreq, subreq);
 			netfs_read_from_server(rreq, subreq);
 		} else if (test_bit(NETFS_SREQ_SHORT_IO, &subreq->flags)) {
+			__set_bit(NETFS_SREQ_RETRYING, &subreq->flags);
 			netfs_reset_subreq_iter(rreq, subreq);
 			netfs_rreq_short_read(rreq, subreq);
 		}
diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index 1e4da268de3b..552792f28122 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -1508,6 +1508,7 @@ struct cifs_io_subrequest {
 		struct cifs_io_request *req;
 	};
 	ssize_t				got_bytes;
+	size_t				actual_len;
 	unsigned int			xid;
 	int				result;
 	bool				have_xid;
diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index b202eac6584e..533f76118316 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -111,6 +111,7 @@ static void cifs_issue_write(struct netfs_io_subrequest *subreq)
 		goto fail;
 	}
 
+	wdata->actual_len = wdata->subreq.len;
 	rc = adjust_credits(wdata->server, wdata, cifs_trace_rw_credits_issue_write_adjust);
 	if (rc)
 		goto fail;
@@ -153,7 +154,7 @@ static bool cifs_clamp_length(struct netfs_io_subrequest *subreq)
 	struct cifs_io_request *req = container_of(subreq->rreq, struct cifs_io_request, rreq);
 	struct TCP_Server_Info *server = req->server;
 	struct cifs_sb_info *cifs_sb = CIFS_SB(rreq->inode->i_sb);
-	size_t rsize = 0;
+	size_t rsize;
 	int rc;
 
 	rdata->xid = get_xid();
@@ -166,8 +167,8 @@ static bool cifs_clamp_length(struct netfs_io_subrequest *subreq)
 						     cifs_sb->ctx);
 
 
-	rc = server->ops->wait_mtu_credits(server, cifs_sb->ctx->rsize, &rsize,
-					   &rdata->credits);
+	rc = server->ops->wait_mtu_credits(server, cifs_sb->ctx->rsize,
+					   &rsize, &rdata->credits);
 	if (rc) {
 		subreq->error = rc;
 		return false;
@@ -183,7 +184,8 @@ static bool cifs_clamp_length(struct netfs_io_subrequest *subreq)
 			      server->credits, server->in_flight, 0,
 			      cifs_trace_rw_credits_read_submit);
 
-	subreq->len = min_t(size_t, subreq->len, rsize);
+	subreq->len = umin(subreq->len, rsize);
+	rdata->actual_len = subreq->len;
 
 #ifdef CONFIG_CIFS_SMB_DIRECT
 	if (server->smbd_conn)
@@ -203,12 +205,39 @@ static void cifs_req_issue_read(struct netfs_io_subrequest *subreq)
 	struct netfs_io_request *rreq = subreq->rreq;
 	struct cifs_io_subrequest *rdata = container_of(subreq, struct cifs_io_subrequest, subreq);
 	struct cifs_io_request *req = container_of(subreq->rreq, struct cifs_io_request, rreq);
+	struct TCP_Server_Info *server = req->server;
+	struct cifs_sb_info *cifs_sb = CIFS_SB(rreq->inode->i_sb);
 	int rc = 0;
 
 	cifs_dbg(FYI, "%s: op=%08x[%x] mapping=%p len=%zu/%zu\n",
 		 __func__, rreq->debug_id, subreq->debug_index, rreq->mapping,
 		 subreq->transferred, subreq->len);
 
+	if (test_bit(NETFS_SREQ_RETRYING, &subreq->flags)) {
+		/*
+		 * As we're issuing a retry, we need to negotiate some new
+		 * credits otherwise the server may reject the op with
+		 * INVALID_PARAMETER.  Note, however, we may get back less
+		 * credit than we need to complete the op, in which case, we
+		 * shorten the op and rely on additional rounds of retry.
+		 */
+		size_t rsize = umin(subreq->len - subreq->transferred,
+				    cifs_sb->ctx->rsize);
+
+		rc = server->ops->wait_mtu_credits(server, rsize, &rdata->actual_len,
+						   &rdata->credits);
+		if (rc)
+			goto out;
+
+		rdata->credits.in_flight_check = 1;
+
+		trace_smb3_rw_credits(rdata->rreq->debug_id,
+				      rdata->subreq.debug_index,
+				      rdata->credits.value,
+				      server->credits, server->in_flight, 0,
+				      cifs_trace_rw_credits_read_resubmit);
+	}
+
 	if (req->cfile->invalidHandle) {
 		do {
 			rc = cifs_reopen_file(req->cfile, true);
diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index f44f5f249400..42352f70b01c 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -301,7 +301,7 @@ smb2_adjust_credits(struct TCP_Server_Info *server,
 		    unsigned int /*enum smb3_rw_credits_trace*/ trace)
 {
 	struct cifs_credits *credits = &subreq->credits;
-	int new_val = DIV_ROUND_UP(subreq->subreq.len, SMB2_MAX_BUFFER_SIZE);
+	int new_val = DIV_ROUND_UP(subreq->actual_len, SMB2_MAX_BUFFER_SIZE);
 	int scredits, in_flight;
 
 	if (!credits->value || credits->value == new_val)
diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index d262e70100c9..5f5f51bf9850 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -4523,9 +4523,9 @@ smb2_readv_callback(struct mid_q_entry *mid)
 		  "rdata server %p != mid server %p",
 		  rdata->server, mid->server);
 
-	cifs_dbg(FYI, "%s: mid=%llu state=%d result=%d bytes=%zu\n",
+	cifs_dbg(FYI, "%s: mid=%llu state=%d result=%d bytes=%zu/%zu\n",
 		 __func__, mid->mid, mid->mid_state, rdata->result,
-		 rdata->subreq.len);
+		 rdata->actual_len, rdata->subreq.len - rdata->subreq.transferred);
 
 	switch (mid->mid_state) {
 	case MID_RESPONSE_RECEIVED:
@@ -4579,15 +4579,18 @@ smb2_readv_callback(struct mid_q_entry *mid)
 				    rdata->subreq.debug_index,
 				    rdata->xid,
 				    rdata->req->cfile->fid.persistent_fid,
-				    tcon->tid, tcon->ses->Suid, rdata->subreq.start,
-				    rdata->subreq.len, rdata->result);
+				    tcon->tid, tcon->ses->Suid,
+				    rdata->subreq.start + rdata->subreq.transferred,
+				    rdata->actual_len,
+				    rdata->result);
 	} else
 		trace_smb3_read_done(rdata->rreq->debug_id,
 				     rdata->subreq.debug_index,
 				     rdata->xid,
 				     rdata->req->cfile->fid.persistent_fid,
 				     tcon->tid, tcon->ses->Suid,
-				     rdata->subreq.start, rdata->got_bytes);
+				     rdata->subreq.start + rdata->subreq.transferred,
+				     rdata->got_bytes);
 
 	if (rdata->result == -ENODATA) {
 		/* We may have got an EOF error because fallocate
@@ -4615,6 +4618,7 @@ smb2_async_readv(struct cifs_io_subrequest *rdata)
 {
 	int rc, flags = 0;
 	char *buf;
+	struct netfs_io_subrequest *subreq = &rdata->subreq;
 	struct smb2_hdr *shdr;
 	struct cifs_io_parms io_parms;
 	struct smb_rqst rqst = { .rq_iov = rdata->iov,
@@ -4625,15 +4629,15 @@ smb2_async_readv(struct cifs_io_subrequest *rdata)
 	int credit_request;
 
 	cifs_dbg(FYI, "%s: offset=%llu bytes=%zu\n",
-		 __func__, rdata->subreq.start, rdata->subreq.len);
+		 __func__, subreq->start, subreq->len);
 
 	if (!rdata->server)
 		rdata->server = cifs_pick_channel(tcon->ses);
 
 	io_parms.tcon = tlink_tcon(rdata->req->cfile->tlink);
 	io_parms.server = server = rdata->server;
-	io_parms.offset = rdata->subreq.start;
-	io_parms.length = rdata->subreq.len;
+	io_parms.offset = subreq->start + subreq->transferred;
+	io_parms.length = rdata->actual_len;
 	io_parms.persistent_fid = rdata->req->cfile->fid.persistent_fid;
 	io_parms.volatile_fid = rdata->req->cfile->fid.volatile_fid;
 	io_parms.pid = rdata->req->pid;
@@ -4648,11 +4652,13 @@ smb2_async_readv(struct cifs_io_subrequest *rdata)
 
 	rdata->iov[0].iov_base = buf;
 	rdata->iov[0].iov_len = total_len;
+	rdata->got_bytes = 0;
+	rdata->result = 0;
 
 	shdr = (struct smb2_hdr *)buf;
 
 	if (rdata->credits.value > 0) {
-		shdr->CreditCharge = cpu_to_le16(DIV_ROUND_UP(rdata->subreq.len,
+		shdr->CreditCharge = cpu_to_le16(DIV_ROUND_UP(rdata->actual_len,
 						SMB2_MAX_BUFFER_SIZE));
 		credit_request = le16_to_cpu(shdr->CreditCharge) + 8;
 		if (server->credits >= server->max_credits)
@@ -4676,11 +4682,11 @@ smb2_async_readv(struct cifs_io_subrequest *rdata)
 	if (rc) {
 		cifs_stats_fail_inc(io_parms.tcon, SMB2_READ_HE);
 		trace_smb3_read_err(rdata->rreq->debug_id,
-				    rdata->subreq.debug_index,
+				    subreq->debug_index,
 				    rdata->xid, io_parms.persistent_fid,
 				    io_parms.tcon->tid,
 				    io_parms.tcon->ses->Suid,
-				    io_parms.offset, io_parms.length, rc);
+				    io_parms.offset, rdata->actual_len, rc);
 	}
 
 async_readv_out:
diff --git a/fs/smb/client/trace.h b/fs/smb/client/trace.h
index 36d5295c2a6f..13adfe550b99 100644
--- a/fs/smb/client/trace.h
+++ b/fs/smb/client/trace.h
@@ -30,6 +30,7 @@
 	EM(cifs_trace_rw_credits_old_session,		"old-session") \
 	EM(cifs_trace_rw_credits_read_response_add,	"rd-resp-add") \
 	EM(cifs_trace_rw_credits_read_response_clear,	"rd-resp-clr") \
+	EM(cifs_trace_rw_credits_read_resubmit,		"rd-resubmit") \
 	EM(cifs_trace_rw_credits_read_submit,		"rd-submit  ") \
 	EM(cifs_trace_rw_credits_write_prepare,		"wr-prepare ") \
 	EM(cifs_trace_rw_credits_write_response_add,	"wr-resp-add") \
-- 
2.43.0




