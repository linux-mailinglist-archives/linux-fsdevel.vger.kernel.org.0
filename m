Return-Path: <linux-fsdevel+bounces-69238-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 900DBC750C0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 16:40:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5F94435ABFC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 15:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3856336B047;
	Thu, 20 Nov 2025 15:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zt/I8/7O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B464535E553
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Nov 2025 15:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763652377; cv=none; b=Oy/adtMy5B6tB9ixLCiiKDQkVxf70/aN3ILkAe9Faf2rmVvwGmlS+hUHcUk3DwdtU0VssuMf86uLMUG6q0fReWNfv03EjZjCQUuJlPHMFVVgwcffa/0tnnRsW/KEKIm46cSb7+gHEZpqMoEY55IZ/cGFDMNDZuaMVdXQ+FjZ4a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763652377; c=relaxed/simple;
	bh=CWFpkwzQspbVWx+p2Ufn4OIYGB0SSbmtNQsRDskcWPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K99u/uVJJUSdlEzgwJuWG/JAJZFQ9SuNWFZx9fJ5h1xeo6/vPCaJf0S4ST2e/RlTUZLcZZrcek48aX8D/lreQ/gr4OzS247ITe/7eOjQFzOrywVT6CxLr2Gc8saou4yu1aMoc0Rjvt7rbYxKr09GLDRFNKnCySpffyEob6rr79c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zt/I8/7O; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763652374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QawhQR0Z0RDo+/KtTlQ5FWHEzEfJj2ch2niN9d13a0s=;
	b=Zt/I8/7ONqmKA2uAKwIvf6QmOar+VxaJXru8bLCLh6zdhLd+s5GNf4/9+Rl2rcZp8kVP9M
	ttRfBddCVulvGZzLecvq5GV8c7IdhWlVkifbMPhgm/zRz9EqN+J4WlxzD4mR5EL1GhyEzA
	w2KCAWb3siC5FGkDi5tf0o30S8uF90I=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-428-usi6sJ9GMeWXExfgST3yIg-1; Thu,
 20 Nov 2025 10:26:11 -0500
X-MC-Unique: usi6sJ9GMeWXExfgST3yIg-1
X-Mimecast-MFC-AGG-ID: usi6sJ9GMeWXExfgST3yIg_1763652369
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4A09B1800473;
	Thu, 20 Nov 2025 15:26:01 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.5])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D8D021800947;
	Thu, 20 Nov 2025 15:25:57 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Steve French <sfrench@samba.org>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Shyam Prasad N <sprasad@microsoft.com>,
	linux-cifs@vger.kernel.org,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tom Talpey <tom@talpey.com>
Subject: [PATCH v2 5/9] cifs: Make smb1's SendReceive() wrap cifs_send_recv()
Date: Thu, 20 Nov 2025 15:25:18 +0000
Message-ID: <20251120152524.2711660-6-dhowells@redhat.com>
In-Reply-To: <20251120152524.2711660-1-dhowells@redhat.com>
References: <20251120152524.2711660-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

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
index 94f43c8df07a..91797ee716d0 100644
--- a/fs/smb/client/cifstransport.c
+++ b/fs/smb/client/cifstransport.c
@@ -236,12 +236,12 @@ SendReceive(const unsigned int xid, struct cifs_ses *ses,
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
@@ -272,78 +272,15 @@ SendReceive(const unsigned int xid, struct cifs_ses *ses,
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
-
+	
+	*pbytes_returned = resp_iov.iov_len;
+	if (resp_iov.iov_len)
+		memcpy(out_buf, resp_iov.iov_base, resp_iov.iov_len);
+	free_rsp_buf(resp_buf_type, resp_iov.iov_base);
 	return rc;
 }
 


