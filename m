Return-Path: <linux-fsdevel+bounces-56890-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0DACB1CDA1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 22:40:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9C4D18844F9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 20:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37ED32BF011;
	Wed,  6 Aug 2025 20:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YRZ7TgYK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99542BD034
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Aug 2025 20:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754512698; cv=none; b=o+nY31yLkmxQ2QjcrAyLZT/nF8yl5X9h/af4/EOg9wMFUJYUzenvmA05N3oPQeZYbVpg6RdckcLAqAKI1ipzIim/Glwp+DDEvXkx+/K989B+G2mQZmRG+gANLBBkJy35P+jHep5zvo78B6VxtLppf5sIM1LpQY+P69DQfa+ofz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754512698; c=relaxed/simple;
	bh=o2Se6X7f1I01126JVjWyB6Ukzkb1OmFmO1QzSoGtdIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RDRzkpMqfDVF3nLxro6/zq7VIpHZ9fCFx7MvosiCVYwW6NsXP+tqisy4xEW75I7j14Xg3yaeiyJ89nGBQSDGjiUM6Gj8DaJiC0wmXw2ZJnDy8N7PHRp40wRfLPi7m9yAIK3O+nyUUBdbj9hIUckr+vhuHS2voX8YhXgv4igONFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YRZ7TgYK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754512690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G64e6jt2CdnkmDsoSf/wfbRhPuprMwqhhJmLQ88f750=;
	b=YRZ7TgYKS6M8ICm32k0VsmFkcX9b1+mQVvM090/sXzbrrQ8ENAxwtiYVU44oCurGgwiaou
	HhK1G+sBPGddRWEQQezk+4j6vgl+xoKNDWDsdAjDIIlMSI67vZcPyLk46NEfBv/SvG9ubw
	CWe2OPb8jGT2Q2P6k6XVMPoaRKEQV4s=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-157-WKmTYZv0PRe2M0ZyhtLarQ-1; Wed,
 06 Aug 2025 16:38:06 -0400
X-MC-Unique: WKmTYZv0PRe2M0ZyhtLarQ-1
X-Mimecast-MFC-AGG-ID: WKmTYZv0PRe2M0ZyhtLarQ_1754512685
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 154091955F3C;
	Wed,  6 Aug 2025 20:38:05 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.17])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 81FF51956086;
	Wed,  6 Aug 2025 20:38:00 +0000 (UTC)
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
Subject: [RFC PATCH 10/31] cifs: Make smb1's SendReceive() wrap cifs_send_recv()
Date: Wed,  6 Aug 2025 21:36:31 +0100
Message-ID: <20250806203705.2560493-11-dhowells@redhat.com>
In-Reply-To: <20250806203705.2560493-1-dhowells@redhat.com>
References: <20250806203705.2560493-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Make the smb1 transport's SendReceive() simply wrap cifs_send_recv() as
does SendReceive2().  This will then allow that to pick up the transport
changes there.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Shyam Prasad N <sprasad@microsoft.com>
cc: Tom Talpey <tom@talpey.com>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/smb/client/cifstransport.c | 85 +++++------------------------------
 1 file changed, 11 insertions(+), 74 deletions(-)

diff --git a/fs/smb/client/cifstransport.c b/fs/smb/client/cifstransport.c
index a3400a757968..f7fed73bc508 100644
--- a/fs/smb/client/cifstransport.c
+++ b/fs/smb/client/cifstransport.c
@@ -270,13 +270,13 @@ SendReceive(const unsigned int xid, struct cifs_ses *ses,
 	    struct smb_hdr *in_buf, struct smb_hdr *out_buf,
 	    int *pbytes_returned, const int flags)
 {
-	int rc = 0;
-	struct smb_message *smb;
 	unsigned int len = be32_to_cpu(in_buf->smb_buf_length);
+	struct TCP_Server_Info *server;
+	struct kvec resp_iov = {};
 	struct kvec iov = { .iov_base = in_buf, .iov_len = len };
 	struct smb_rqst rqst = { .rq_iov = &iov, .rq_nvec = 1 };
-	struct cifs_credits credits = { .value = 1, .instance = 0 };
-	struct TCP_Server_Info *server;
+	int resp_buf_type;
+	int rc = 0;
 
 	if (ses == NULL) {
 		cifs_dbg(VFS, "Null smb session\n");
@@ -305,78 +305,15 @@ SendReceive(const unsigned int xid, struct cifs_ses *ses,
 		return -EIO;
 	}
 
-	rc = wait_for_free_request(server, flags, &credits.instance);
-	if (rc)
-		return rc;
-
-	/* make sure that we sign in the same order that we send on this socket
-	   and avoid races inside tcp sendmsg code that could cause corruption
-	   of smb data */
-
-	cifs_server_lock(server);
-
-	rc = allocate_mid(ses, in_buf, &smb);
-	if (rc) {
-		cifs_server_unlock(server);
-		/* Update # of requests on wire to server */
-		add_credits(server, &credits, 0);
-		return rc;
-	}
-
-	rc = cifs_sign_smb(in_buf, server, &smb->sequence_number);
-	if (rc) {
-		cifs_server_unlock(server);
-		goto out;
-	}
-
-	smb->mid_state = MID_REQUEST_SUBMITTED;
-
-	rc = smb_send(server, in_buf, len);
-	cifs_save_when_sent(smb);
-
-	if (rc < 0)
-		server->sequence_number -= 2;
-
-	cifs_server_unlock(server);
-
+	rc = cifs_send_recv(xid, ses, ses->server,
+			    &rqst, &resp_buf_type, flags, &resp_iov);
 	if (rc < 0)
-		goto out;
-
-	rc = wait_for_response(server, smb);
-	if (rc != 0) {
-		send_cancel(server, &rqst, smb);
-		spin_lock(&server->mid_lock);
-		if (smb->mid_state == MID_REQUEST_SUBMITTED ||
-		    smb->mid_state == MID_RESPONSE_RECEIVED) {
-			/* no longer considered to be "in-flight" */
-			smb->callback = release_mid;
-			spin_unlock(&server->mid_lock);
-			add_credits(server, &credits, 0);
-			return rc;
-		}
-		spin_unlock(&server->mid_lock);
-	}
-
-	rc = cifs_sync_mid_result(smb, server);
-	if (rc != 0) {
-		add_credits(server, &credits, 0);
 		return rc;
-	}
-
-	if (!smb->resp_buf || !out_buf ||
-	    smb->mid_state != MID_RESPONSE_READY) {
-		rc = -EIO;
-		cifs_server_dbg(VFS, "Bad MID state?\n");
-		goto out;
-	}
-
-	*pbytes_returned = get_rfc1002_length(smb->resp_buf);
-	memcpy(out_buf, smb->resp_buf, *pbytes_returned + 4);
-	rc = cifs_check_receive(smb, server, 0);
-out:
-	delete_mid(smb);
-	add_credits(server, &credits, 0);
-
+	
+	*pbytes_returned = resp_iov.iov_len;
+	if (resp_iov.iov_len)
+		memcpy(out_buf, resp_iov.iov_base, resp_iov.iov_len);
+	free_rsp_buf(resp_buf_type, resp_iov.iov_base);
 	return rc;
 }
 


