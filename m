Return-Path: <linux-fsdevel+bounces-56907-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D5E3B1CDDA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 22:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24E97580035
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 20:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98AF2BEC39;
	Wed,  6 Aug 2025 20:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TvZnF1Z/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E7B2D3EE6
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Aug 2025 20:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754512777; cv=none; b=V3PD4mlPDZSoJ3PLDzfu/7G9G4jZDqg6jjsZuiNKwzy4heuMl2xVeY7TxvkASX9E2lmwTzzu7VCqM/Ju0/UL6qwLpFp7Thd/AZElmjXvufBIH4M+YFl/k/cr1LVGOMYgK1UBRryWC2EPhYUW/8zJ5URIijEMe8JmT0Zzzh6Q8Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754512777; c=relaxed/simple;
	bh=EmcC1MzHMapaCFx8ngoOknAJSipRgtspC2cISwSR4YA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sdY9grF161TQLh8fxOelBUvUEKNRy7AIT+DJQN4BEQ98+NhYqj3v0PsFwzZ3Ec29X6kFA5UinjlcidKPEsUsS3vWzKqvXXCNW6WAQffn0nZP8IZdcQpky2wmxMyYFsDUlUrmjc6+HoU/BzN7IHqYgxVzfUfDlBDTjkXZQMH34K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TvZnF1Z/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754512771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1N8y8Gx1EbPTw63BonzmbK2SbB3Yno56oTacfPQuS/A=;
	b=TvZnF1Z/SY7LVQzDs4/G7kTuzWBc/HWUZoq/AAKUBsNZJzSL4LbENsCh/uFfLaKn9LZOS8
	9ALW0Pg9YXSpXGKgImH/ijblGqyn/Kt/w6I7Sdrj/kVmqO9A7WT9zJZkJiAlcQY3hoJNEV
	Ov0hL/Qcbra/txexS2L5ESu/fe0iPF0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-637-sf-38EwgNMepm8E2h_JoXw-1; Wed,
 06 Aug 2025 16:39:27 -0400
X-MC-Unique: sf-38EwgNMepm8E2h_JoXw-1
X-Mimecast-MFC-AGG-ID: sf-38EwgNMepm8E2h_JoXw_1754512765
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 501691800346;
	Wed,  6 Aug 2025 20:39:25 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.17])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D9C8619560AD;
	Wed,  6 Aug 2025 20:39:21 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Steve French <sfrench@samba.org>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Wang Zhaolong <wangzhaolong@huaweicloud.com>,
	Stefan Metzmacher <metze@samba.org>,
	Mina Almasry <almasrymina@google.com>,
	linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 27/31] cifs: Convert SMB2 Tree Connect request
Date: Wed,  6 Aug 2025 21:36:48 +0100
Message-ID: <20250806203705.2560493-28-dhowells@redhat.com>
In-Reply-To: <20250806203705.2560493-1-dhowells@redhat.com>
References: <20250806203705.2560493-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Shyam Prasad N <sprasad@microsoft.com>
cc: Tom Talpey <tom@talpey.com>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/smb/client/smb2pdu.c | 71 +++++++++++++++--------------------------
 1 file changed, 25 insertions(+), 46 deletions(-)

diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index c63c62cd6638..4300ae311ee2 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -2277,57 +2277,43 @@ int
 SMB2_tcon(const unsigned int xid, struct cifs_ses *ses, const char *tree,
 	  struct cifs_tcon *tcon, const struct nls_table *cp)
 {
-	struct smb_rqst rqst;
+	struct TCP_Server_Info *server = cifs_pick_channel(ses);
 	struct smb2_tree_connect_req *req;
 	struct smb2_tree_connect_rsp *rsp = NULL;
-	struct kvec iov[2];
-	struct kvec rsp_iov = { NULL, 0 };
-	int rc = 0;
-	int resp_buftype;
-	int unc_path_len;
-	__le16 *unc_path = NULL;
+	struct smb_message *smb = NULL;
+	int unc_path_size;
 	int flags = 0;
-	unsigned int total_len;
-	struct TCP_Server_Info *server = cifs_pick_channel(ses);
+	int rc = 0;
 
 	cifs_dbg(FYI, "TCON\n");
 
 	if (!server || !tree)
 		return -EIO;
 
-	unc_path = kmalloc(MAX_SHARENAME_LENGTH * 2, GFP_KERNEL);
-	if (unc_path == NULL)
-		return -ENOMEM;
-
-	unc_path_len = cifs_strtoUTF16(unc_path, tree, strlen(tree), cp);
-	if (unc_path_len <= 0) {
-		kfree(unc_path);
-		return -EINVAL;
-	}
-	unc_path_len *= 2;
+	unc_path_size = cifs_size_strtoUTF16(tree, INT_MAX, cp);
 
 	/* SMB2 TREE_CONNECT request must be called with TreeId == 0 */
 	tcon->tid = 0;
 	atomic_set(&tcon->num_remote_opens, 0);
-	rc = smb2_plain_req_init(SMB2_TREE_CONNECT, tcon, server,
-				 (void **) &req, &total_len);
-	if (rc) {
-		kfree(unc_path);
-		return rc;
-	}
+
+	smb = smb2_create_request(SMB2_TREE_CONNECT, server, tcon,
+				  sizeof(*req), sizeof(*req) + unc_path_size, 0,
+				  SMB2_REQ_DYNAMIC);
+	if (!smb)
+		return -ENOMEM;
 
 	if (smb3_encryption_required(tcon))
 		flags |= CIFS_TRANSFORM_REQ;
 
-	iov[0].iov_base = (char *)req;
-	/* 1 for pad */
-	iov[0].iov_len = total_len - 1;
-
 	/* Testing shows that buffer offset must be at location of Buffer[0] */
-	req->PathOffset = cpu_to_le16(sizeof(struct smb2_tree_connect_req));
-	req->PathLength = cpu_to_le16(unc_path_len);
-	iov[1].iov_base = unc_path;
-	iov[1].iov_len = unc_path_len;
+	req->PathOffset = cpu_to_le16(smb->ext_offset);
+	req->PathLength = cpu_to_le16(unc_path_size);
+
+	rc = cifs_strtoUTF16(smb->request + smb->ext_offset, tree, strlen(tree), cp);
+	if (rc <= 0) {
+		rc = -EINVAL;
+		goto tcon_exit;
+	}
 
 	/*
 	 * 3.11 tcon req must be signed if not encrypted. See MS-SMB2 3.2.4.1.1
@@ -2341,22 +2327,17 @@ SMB2_tcon(const unsigned int xid, struct cifs_ses *ses, const char *tree,
 	    ((ses->user_name != NULL) || (ses->sectype == Kerberos)))
 		req->hdr.Flags |= SMB2_FLAGS_SIGNED;
 
-	memset(&rqst, 0, sizeof(struct smb_rqst));
-	rqst.rq_iov = iov;
-	rqst.rq_nvec = 2;
-
 	/* Need 64 for max size write so ask for more in case not there yet */
 	if (server->credits >= server->max_credits)
 		req->hdr.CreditRequest = cpu_to_le16(0);
 	else
 		req->hdr.CreditRequest = cpu_to_le16(
-			min_t(int, server->max_credits -
-			      server->credits, 64));
+			min_t(int, server->max_credits - server->credits, 64));
 
-	rc = cifs_send_recv(xid, ses, server,
-			    &rqst, &resp_buftype, flags, &rsp_iov);
-	cifs_small_buf_release(req);
-	rsp = (struct smb2_tree_connect_rsp *)rsp_iov.iov_base;
+	rc = smb_send_recv_messages(xid, ses, server, smb, flags);
+	smb_clear_request(smb);
+
+	rsp = (struct smb2_tree_connect_rsp *)smb->response;
 	trace_smb3_tcon(xid, tcon->tid, ses->Suid, tree, rc);
 	if ((rc != 0) || (rsp == NULL)) {
 		cifs_stats_fail_inc(tcon, SMB2_TREE_CONNECT);
@@ -2403,9 +2384,7 @@ SMB2_tcon(const unsigned int xid, struct cifs_ses *ses, const char *tree,
 		if (tcon->share_flags & SMB2_SHAREFLAG_ISOLATED_TRANSPORT)
 			server->nosharesock = true;
 tcon_exit:
-
-	free_rsp_buf(resp_buftype, rsp);
-	kfree(unc_path);
+	smb_put_messages(smb);
 	return rc;
 
 tcon_error_exit:


