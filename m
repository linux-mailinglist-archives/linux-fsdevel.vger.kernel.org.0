Return-Path: <linux-fsdevel+bounces-70396-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A455C997D1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 02 Dec 2025 00:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0A583A62FD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Dec 2025 22:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246A32BE642;
	Mon,  1 Dec 2025 22:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ILAd/GjR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F09E29D281
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Dec 2025 22:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764629879; cv=none; b=p/RSqhyTaPFp71iyTLycd8xLJQVJhEldWFaZkjYKoVz1U382tuDJxSZOKi1i5djn0aufyWNc/ht8wrmLWSPj0Hh9TIYC6ykeH7djusvBtt91VJhIIcd+v+hCAF0a8s1OywQc/4glSuIGit3FIpKkBmfNrYUJvBbTWeRhVJPLJE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764629879; c=relaxed/simple;
	bh=v0w0wbBuRmE/hqCTHUNxRWFx5sXO9L3DeoDFuabhKQk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fyGRKS1RKQjX3JJzd8mWAunOlhZqYYJaqn2ci1u1FLmos+QBMLN3m73r4V1T4u4wNaEyWyvbqsqqnxGEu+SsJ2QYyaV4aU5n+3YnN5FYI1A9Pb9Z7n/pdgwcI54ToRbSi/1FDY4EqB2kZ4iEN74UWcjHQoGl6vs12UXWSiIfS7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ILAd/GjR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764629875;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7ZvOM2ptPjoWsye4CO/Rb2gimmR4GB33tvnhv1f5q2M=;
	b=ILAd/GjR7B+YLaH9X+9kORFZFsBJYN+TsLHD6Ly0MiZ/C7rZ/dGNPu2x7J6SVUG5XQJ417
	v8zEKX/jYK/pYKaX8kgvQB6QN+Ab6gSMf32cKA3sIVHThM9GmBlbv07xtO6dVx+hmpkc2S
	OD5OgMjFq7uDSwO05sjMS4jTJO51REg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-617-vq83y0RJNbqM3IFXqf4CkA-1; Mon,
 01 Dec 2025 17:57:50 -0500
X-MC-Unique: vq83y0RJNbqM3IFXqf4CkA-1
X-Mimecast-MFC-AGG-ID: vq83y0RJNbqM3IFXqf4CkA_1764629868
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 354D3180057A;
	Mon,  1 Dec 2025 22:57:48 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.14])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5529419560A7;
	Mon,  1 Dec 2025 22:57:45 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Steve French <sfrench@samba.org>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Stefan Metzmacher <metze@samba.org>,
	Tom Talpey <tom@talpey.com>,
	linux-cifs@vger.kernel.org,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 2/9] cifs: Make smb1's SendReceive() wrap cifs_send_recv()
Date: Mon,  1 Dec 2025 22:57:23 +0000
Message-ID: <20251201225732.1520128-3-dhowells@redhat.com>
In-Reply-To: <20251201225732.1520128-1-dhowells@redhat.com>
References: <20251201225732.1520128-1-dhowells@redhat.com>
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
 fs/smb/client/cifstransport.c | 82 +++++------------------------------
 1 file changed, 10 insertions(+), 72 deletions(-)

diff --git a/fs/smb/client/cifstransport.c b/fs/smb/client/cifstransport.c
index d12578b37179..1a28d361b1f7 100644
--- a/fs/smb/client/cifstransport.c
+++ b/fs/smb/client/cifstransport.c
@@ -236,12 +236,12 @@ SendReceive(const unsigned int xid, struct cifs_ses *ses,
 	    struct smb_hdr *in_buf, unsigned int in_len,
 	    struct smb_hdr *out_buf, int *pbytes_returned, const int flags)
 {
-	int rc = 0;
-	struct mid_q_entry *mid;
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
@@ -272,77 +272,15 @@ SendReceive(const unsigned int xid, struct cifs_ses *ses,
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
-	rc = allocate_mid(ses, in_buf, &mid);
-	if (rc) {
-		cifs_server_unlock(server);
-		/* Update # of requests on wire to server */
-		add_credits(server, &credits, 0);
-		return rc;
-	}
-
-	rc = cifs_sign_smb(in_buf, in_len, server, &mid->sequence_number);
-	if (rc) {
-		cifs_server_unlock(server);
-		goto out;
-	}
-
-	mid->mid_state = MID_REQUEST_SUBMITTED;
-
-	rc = smb_send(server, in_buf, in_len);
-	cifs_save_when_sent(mid);
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
-	rc = wait_for_response(server, mid);
-	if (rc != 0) {
-		send_cancel(server, &rqst, mid);
-		spin_lock(&mid->mid_lock);
-		if (mid->callback) {
-			/* no longer considered to be "in-flight" */
-			mid->callback = release_mid;
-			spin_unlock(&mid->mid_lock);
-			add_credits(server, &credits, 0);
-			return rc;
-		}
-		spin_unlock(&mid->mid_lock);
-	}
-
-	rc = cifs_sync_mid_result(mid, server);
-	if (rc != 0) {
-		add_credits(server, &credits, 0);
 		return rc;
-	}
-
-	if (!mid->resp_buf || !out_buf ||
-	    mid->mid_state != MID_RESPONSE_READY) {
-		rc = -EIO;
-		cifs_server_dbg(VFS, "Bad MID state?\n");
-		goto out;
-	}
-
-	*pbytes_returned = mid->response_pdu_len;
-	memcpy(out_buf, mid->resp_buf, *pbytes_returned);
-	rc = cifs_check_receive(mid, server, 0);
-out:
-	delete_mid(mid);
-	add_credits(server, &credits, 0);
 
+	*pbytes_returned = resp_iov.iov_len;
+	if (resp_iov.iov_len)
+		memcpy(out_buf, resp_iov.iov_base, resp_iov.iov_len);
+	free_rsp_buf(resp_buf_type, resp_iov.iov_base);
 	return rc;
 }
 


