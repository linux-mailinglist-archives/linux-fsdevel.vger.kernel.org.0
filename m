Return-Path: <linux-fsdevel+bounces-69660-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 971A9C80881
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 13:44:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C3BC4345316
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 12:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8CCB301707;
	Mon, 24 Nov 2025 12:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i+XA2CV/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783DA30149D
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Nov 2025 12:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763988216; cv=none; b=ZXHPrvQFwmEJ6PJZA5wsw/Teysw/iHF1zlOcwNhhDbdDtHynSnwyJnnd8uVbkFv/ZBZyq9jRUdNJY60FY63e4T5ycu2sSPjTqAHjsl50dJr5JMwBtnTBLISqql0uUBMGeoHMcEz033nhpxeNFtcqF+wZxL3NrCHA/e7KZGgC/+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763988216; c=relaxed/simple;
	bh=dfj697H1h67D7hHtq07SOsJ7IR78dPGt8xJLON5lKNw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N8uwXDS1uRGRz7eBQgBQtDP08fyeSa6N3Q9OqO0Ba/RDDBs+uFJim/ppnOhZiGKaYi1d5vyVUTIocbMbqhzeNvVEVf5aLHMej5R7IwQA8XCOwxalZY0zcoMsp6/qV7PzqP2/ABTPTkwIkOB3MkkgUzgAm1mds8bjyYobXGFTvXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i+XA2CV/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763988213;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VZTfKIqZMw/8ui18rUPwNiaq7K+/Orm6QqFRuL2B6Mw=;
	b=i+XA2CV/1xaqRxq6JRPcLXTfliUYazBgvVWFhUCxDWn/iGfvAnr9ylIIQvgG0kriWK63tq
	hxyx6nVjZmSeoyF0Ph+h3OWQqhjrsO8BJnw1IGJxUphmvDWyr+tH+MmVF1w1ucI4vENTTh
	pF/N649DI6ls9NXQK1RMZmpHRfCDSuM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-133-jWwGLYfXOXS-Jyw-jETJ-Q-1; Mon,
 24 Nov 2025 07:43:26 -0500
X-MC-Unique: jWwGLYfXOXS-Jyw-jETJ-Q-1
X-Mimecast-MFC-AGG-ID: jWwGLYfXOXS-Jyw-jETJ-Q_1763988205
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 263861956068;
	Mon, 24 Nov 2025 12:43:25 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.14])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8B28719560A7;
	Mon, 24 Nov 2025 12:43:22 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Steve French <sfrench@samba.org>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Stefan Metzmacher <metze@samba.org>,
	linux-cifs@vger.kernel.org,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tom Talpey <tom@talpey.com>
Subject: [PATCH v4 06/11] cifs: Make smb1's SendReceive() wrap cifs_send_recv()
Date: Mon, 24 Nov 2025 12:42:45 +0000
Message-ID: <20251124124251.3565566-7-dhowells@redhat.com>
In-Reply-To: <20251124124251.3565566-1-dhowells@redhat.com>
References: <20251124124251.3565566-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

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
 fs/smb/client/cifstransport.c | 83 +++++------------------------------
 1 file changed, 10 insertions(+), 73 deletions(-)

diff --git a/fs/smb/client/cifstransport.c b/fs/smb/client/cifstransport.c
index d67b256a2ee7..1a0b80fc97d4 100644
--- a/fs/smb/client/cifstransport.c
+++ b/fs/smb/client/cifstransport.c
@@ -237,12 +237,12 @@ SendReceive(const unsigned int xid, struct cifs_ses *ses,
 	    struct smb_hdr *in_buf, unsigned int in_len,
 	    struct smb_hdr *out_buf, int *pbytes_returned, const int flags)
 {
-	int rc = 0;
-	struct smb_message *smb;
+	struct TCP_Server_Info *server;
+	struct kvec resp_iov = {};
 	struct kvec iov = { .iov_base = in_buf, .iov_len = in_len };
 	struct smb_rqst rqst = { .rq_iov = &iov, .rq_nvec = 1 };
-	struct cifs_credits credits = { .value = 1, .instance = 0 };
-	struct TCP_Server_Info *server;
+	int resp_buf_type;
+	int rc = 0;
 
 	if (WARN_ON_ONCE(in_len > 0xffffff))
 		return -EIO;
@@ -273,78 +273,15 @@ SendReceive(const unsigned int xid, struct cifs_ses *ses,
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
-	rc = cifs_sign_smb(in_buf, in_len, server, &smb->sequence_number);
-	if (rc) {
-		cifs_server_unlock(server);
-		goto out;
-	}
-
-	smb->mid_state = MID_REQUEST_SUBMITTED;
-
-	rc = smb_send(server, in_buf, in_len);
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
-		spin_lock(&smb->mid_lock);
-		if (smb->mid_state == MID_REQUEST_SUBMITTED ||
-		    smb->mid_state == MID_RESPONSE_RECEIVED) {
-			/* no longer considered to be "in-flight" */
-			smb->callback = release_mid;
-			spin_unlock(&smb->mid_lock);
-			add_credits(server, &credits, 0);
-			return rc;
-		}
-		spin_unlock(&smb->mid_lock);
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
-	*pbytes_returned = smb->response_pdu_len;
-	memcpy(out_buf, smb->resp_buf, *pbytes_returned);
-	rc = cifs_check_receive(smb, server, 0);
-out:
-	delete_mid(smb);
-	add_credits(server, &credits, 0);
 
+	*pbytes_returned = resp_iov.iov_len;
+	if (resp_iov.iov_len)
+		memcpy(out_buf, resp_iov.iov_base, resp_iov.iov_len);
+	free_rsp_buf(resp_buf_type, resp_iov.iov_base);
 	return rc;
 }
 


