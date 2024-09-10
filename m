Return-Path: <linux-fsdevel+bounces-29012-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7776F973031
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 11:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D312F1F23D67
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 09:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3188418B49E;
	Tue, 10 Sep 2024 09:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="u2JIBnPw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8080617BEAE;
	Tue, 10 Sep 2024 09:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725962304; cv=none; b=layV1HzaaFqaEgNsSPKfL/NrnylCHngfG8Ep5j6Bbdw5mbwfEmtjQ9lkmmRYJaJAmRz4mmc6n25PcvWKbOI4q5qmQiDw6LIa2f5Fr59dVd9aRVAozIEeFxDbCadhWIYPyNr2tn5CwkOy/3H/hwARL2BuqHG7s1yM6agGeOwLmuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725962304; c=relaxed/simple;
	bh=9Ww1WAp4VlxtTS4UdwlfJGyCK/nU2KHWk2hi7/D/Ckc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u5uMu/mTwK35i5EaK12u6eTrlJuhln57fUmYxwCoE9vhQ8cQI3MnPiWUYagZ1WSrlJr7XSvPM7Fm/hfn/D6eY08km4jwE9t2906HWLNA6FsTr2cDtQ1dJ8sMSELpcgDZZqNf01FKqktspJUhWPSHd2KT016ehV71UPAoqt6iUcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=u2JIBnPw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05240C4CEC3;
	Tue, 10 Sep 2024 09:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725962304;
	bh=9Ww1WAp4VlxtTS4UdwlfJGyCK/nU2KHWk2hi7/D/Ckc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u2JIBnPwYa6RbDChZOw8kewW/k7P78zfHQQ8xf4UBBeiu9OQj6AgDFw3ONh1iZKyP
	 vNuTtfEY+QP2nQoFu5rkvS5dKRA5ElYJuikkksmKnfu1S5L6lZXnXjszuxjkKo/wsf
	 dH1E0ng3hZFnRsCYRmXaAVbntzj+h+wV61L5DlSI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Howells <dhowells@redhat.com>,
	Steve French <stfrench@microsoft.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Jeff Layton <jlayton@kernel.org>,
	linux-cifs@vger.kernel.org,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 364/375] cifs: Fix SMB1 readv/writev callback in the same way as SMB2/3
Date: Tue, 10 Sep 2024 11:32:41 +0200
Message-ID: <20240910092634.852621735@linuxfoundation.org>
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

[ Upstream commit a68c74865f517e26728735aba0ae05055eaff76c ]

Port a number of SMB2/3 async readv/writev fixes to the SMB1 transport:

    commit a88d60903696c01de577558080ec4fc738a70475
    cifs: Don't advance the I/O iterator before terminating subrequest

    commit ce5291e56081730ec7d87bc9aa41f3de73ff3256
    cifs: Defer read completion

    commit 1da29f2c39b67b846b74205c81bf0ccd96d34727
    netfs, cifs: Fix handling of short DIO read

Fixes: 3ee1a1fc3981 ("cifs: Cut over to using netfslib")
Signed-off-by: David Howells <dhowells@redhat.com>
Reported-by: Steve French <stfrench@microsoft.com>
Reviewed-by: Paulo Alcantara <pc@manguebit.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/cifssmb.c | 54 +++++++++++++++++++++++++++++++++++------
 1 file changed, 46 insertions(+), 8 deletions(-)

diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
index 6dce70f17208..cfae2e918209 100644
--- a/fs/smb/client/cifssmb.c
+++ b/fs/smb/client/cifssmb.c
@@ -1261,16 +1261,32 @@ CIFS_open(const unsigned int xid, struct cifs_open_parms *oparms, int *oplock,
 	return rc;
 }
 
+static void cifs_readv_worker(struct work_struct *work)
+{
+	struct cifs_io_subrequest *rdata =
+		container_of(work, struct cifs_io_subrequest, subreq.work);
+
+	netfs_subreq_terminated(&rdata->subreq,
+				(rdata->result == 0 || rdata->result == -EAGAIN) ?
+				rdata->got_bytes : rdata->result, true);
+}
+
 static void
 cifs_readv_callback(struct mid_q_entry *mid)
 {
 	struct cifs_io_subrequest *rdata = mid->callback_data;
+	struct netfs_inode *ictx = netfs_inode(rdata->rreq->inode);
 	struct cifs_tcon *tcon = tlink_tcon(rdata->req->cfile->tlink);
 	struct TCP_Server_Info *server = tcon->ses->server;
 	struct smb_rqst rqst = { .rq_iov = rdata->iov,
 				 .rq_nvec = 2,
 				 .rq_iter = rdata->subreq.io_iter };
-	struct cifs_credits credits = { .value = 1, .instance = 0 };
+	struct cifs_credits credits = {
+		.value = 1,
+		.instance = 0,
+		.rreq_debug_id = rdata->rreq->debug_id,
+		.rreq_debug_index = rdata->subreq.debug_index,
+	};
 
 	cifs_dbg(FYI, "%s: mid=%llu state=%d result=%d bytes=%zu\n",
 		 __func__, mid->mid, mid->mid_state, rdata->result,
@@ -1282,6 +1298,7 @@ cifs_readv_callback(struct mid_q_entry *mid)
 		if (server->sign) {
 			int rc = 0;
 
+			iov_iter_truncate(&rqst.rq_iter, rdata->got_bytes);
 			rc = cifs_verify_signature(&rqst, server,
 						  mid->sequence_number);
 			if (rc)
@@ -1306,13 +1323,21 @@ cifs_readv_callback(struct mid_q_entry *mid)
 		rdata->result = -EIO;
 	}
 
-	if (rdata->result == 0 || rdata->result == -EAGAIN)
-		iov_iter_advance(&rdata->subreq.io_iter, rdata->got_bytes);
+	if (rdata->result == -ENODATA) {
+		__set_bit(NETFS_SREQ_HIT_EOF, &rdata->subreq.flags);
+		rdata->result = 0;
+	} else {
+		if (rdata->got_bytes < rdata->actual_len &&
+		    rdata->subreq.start + rdata->subreq.transferred + rdata->got_bytes ==
+		    ictx->remote_i_size) {
+			__set_bit(NETFS_SREQ_HIT_EOF, &rdata->subreq.flags);
+			rdata->result = 0;
+		}
+	}
+
 	rdata->credits.value = 0;
-	netfs_subreq_terminated(&rdata->subreq,
-				(rdata->result == 0 || rdata->result == -EAGAIN) ?
-				rdata->got_bytes : rdata->result,
-				false);
+	INIT_WORK(&rdata->subreq.work, cifs_readv_worker);
+	queue_work(cifsiod_wq, &rdata->subreq.work);
 	release_mid(mid);
 	add_credits(server, &credits, 0);
 }
@@ -1619,9 +1644,15 @@ static void
 cifs_writev_callback(struct mid_q_entry *mid)
 {
 	struct cifs_io_subrequest *wdata = mid->callback_data;
+	struct TCP_Server_Info *server = wdata->server;
 	struct cifs_tcon *tcon = tlink_tcon(wdata->req->cfile->tlink);
 	WRITE_RSP *smb = (WRITE_RSP *)mid->resp_buf;
-	struct cifs_credits credits = { .value = 1, .instance = 0 };
+	struct cifs_credits credits = {
+		.value = 1,
+		.instance = 0,
+		.rreq_debug_id = wdata->rreq->debug_id,
+		.rreq_debug_index = wdata->subreq.debug_index,
+	};
 	ssize_t result;
 	size_t written;
 
@@ -1657,9 +1688,16 @@ cifs_writev_callback(struct mid_q_entry *mid)
 		break;
 	}
 
+	trace_smb3_rw_credits(credits.rreq_debug_id, credits.rreq_debug_index,
+			      wdata->credits.value,
+			      server->credits, server->in_flight,
+			      0, cifs_trace_rw_credits_write_response_clear);
 	wdata->credits.value = 0;
 	cifs_write_subrequest_terminated(wdata, result, true);
 	release_mid(mid);
+	trace_smb3_rw_credits(credits.rreq_debug_id, credits.rreq_debug_index, 0,
+			      server->credits, server->in_flight,
+			      credits.value, cifs_trace_rw_credits_write_response_add);
 	add_credits(tcon->ses->server, &credits, 0);
 }
 
-- 
2.43.0




