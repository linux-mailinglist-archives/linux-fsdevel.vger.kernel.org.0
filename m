Return-Path: <linux-fsdevel+bounces-70313-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 826C1C96788
	for <lists+linux-fsdevel@lfdr.de>; Mon, 01 Dec 2025 10:51:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3FC5F4E01D1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Dec 2025 09:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF69302CD7;
	Mon,  1 Dec 2025 09:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iKHse47U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8629302760
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Dec 2025 09:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764582588; cv=none; b=PTJa0TYCigUWB73oLBUTr37evlwOtAENS3S+JFzVxOIYymbnfd2JE7xg9Z/kiMg3tbdDqlNc9fznMbu4AiyyXGn4TD2zGALsXu5o3FZGkKEudifHMvqB3KXHBhOLNxaaUaB3iE3cXiJbFFXCbSN2ug3/mHgNXNamNpl27nG8KSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764582588; c=relaxed/simple;
	bh=/fgLqwsc8OnyA2ubG+QT+yMPG7OFt2umP/TM/quPPlo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X4vHw5FxP2RWb8JV+L5sY6eGvUbdh4JjgLnXbDTf3cXDEXwRn14MJH9iuOiglMAZ7DZuQkINwFrjAZGFYbhnbWwyJHzdd5APOd8PWWF9+VmYX6QNvet+g24T/cA8hSrdhAvWOAkFQZm5wu86Zzv1IM0qkk7ipM1qtRCuqPAJ5lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iKHse47U; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764582584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=59cSTudlRXsK26sKpeoMgn05TZUYBjt0EXhk4kqHfH8=;
	b=iKHse47U0mb+1TdsOnxG+MKiKO2DXtMFe8ISZJbYU3kpTdHVUHeZCdPrZJuyKcQddrxa7q
	9m2YVKuXfdCE+H7avRLFuiQNoW6h+klLOHnzS5QytJeIfoIIxaJ5qDTKcCktLdoCG+YA8w
	+5+/9pN92qg/DZYvi9Q1YnMRHOzF6SA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-502-CAV4GPb5NHK7InU_7lPyJQ-1; Mon,
 01 Dec 2025 04:49:42 -0500
X-MC-Unique: CAV4GPb5NHK7InU_7lPyJQ-1
X-Mimecast-MFC-AGG-ID: CAV4GPb5NHK7InU_7lPyJQ_1764582581
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 74AAD195608F;
	Mon,  1 Dec 2025 09:49:41 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.14])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 566A418004A3;
	Mon,  1 Dec 2025 09:49:38 +0000 (UTC)
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
Subject: [PATCH v5 4/9] cifs: Clean up some places where an extra kvec[] was required for rfc1002
Date: Mon,  1 Dec 2025 09:49:08 +0000
Message-ID: <20251201094916.1418415-5-dhowells@redhat.com>
In-Reply-To: <20251201094916.1418415-1-dhowells@redhat.com>
References: <20251201094916.1418415-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Clean up some places where previously an extra element in the kvec array
was being used to hold an rfc1002 header for SMB1 (a previous patch removed
this and generated it on the fly as for SMB2/3).

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Shyam Prasad N <sprasad@microsoft.com>
cc: Tom Talpey <tom@talpey.com>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/smb/client/cifsencrypt.c   | 52 ++++++++---------------------------
 fs/smb/client/cifsproto.h     |  7 -----
 fs/smb/client/cifstransport.c | 20 ++------------
 fs/smb/client/smb1ops.c       | 12 +++++---
 fs/smb/client/transport.c     | 28 +++++++++++--------
 5 files changed, 38 insertions(+), 81 deletions(-)

diff --git a/fs/smb/client/cifsencrypt.c b/fs/smb/client/cifsencrypt.c
index 1e0ac87c6686..a9a57904c6b1 100644
--- a/fs/smb/client/cifsencrypt.c
+++ b/fs/smb/client/cifsencrypt.c
@@ -86,26 +86,21 @@ static int cifs_sig_iter(const struct iov_iter *iter, size_t maxsize,
 int __cifs_calc_signature(struct smb_rqst *rqst, struct TCP_Server_Info *server,
 			  char *signature, struct cifs_calc_sig_ctx *ctx)
 {
-	int i;
+	struct iov_iter iter;
 	ssize_t rc;
-	struct kvec *iov = rqst->rq_iov;
-	int n_vec = rqst->rq_nvec;
+	size_t size = 0;
 
-	for (i = 0; i < n_vec; i++) {
-		if (iov[i].iov_len == 0)
-			continue;
-		if (iov[i].iov_base == NULL) {
-			cifs_dbg(VFS, "null iovec entry\n");
-			return -EIO;
-		}
+	for (int i = 0; i < rqst->rq_nvec; i++)
+		size += rqst->rq_iov[i].iov_len;
 
-		rc = cifs_sig_update(ctx, iov[i].iov_base, iov[i].iov_len);
-		if (rc) {
-			cifs_dbg(VFS, "%s: Could not update with payload\n",
-				 __func__);
-			return rc;
-		}
-	}
+	iov_iter_kvec(&iter, ITER_SOURCE, rqst->rq_iov, rqst->rq_nvec, size);
+
+	if (iov_iter_count(&iter) <= 4)
+		return -EIO;
+
+	rc = cifs_sig_iter(&iter, iov_iter_count(&iter), ctx);
+	if (rc < 0)
+		return rc;
 
 	rc = cifs_sig_iter(&rqst->rq_iter, iov_iter_count(&rqst->rq_iter), ctx);
 	if (rc < 0)
@@ -186,29 +181,6 @@ int cifs_sign_rqst(struct smb_rqst *rqst, struct TCP_Server_Info *server,
 	return rc;
 }
 
-int cifs_sign_smbv(struct kvec *iov, int n_vec, struct TCP_Server_Info *server,
-		   __u32 *pexpected_response_sequence)
-{
-	struct smb_rqst rqst = { .rq_iov = iov,
-				 .rq_nvec = n_vec };
-
-	return cifs_sign_rqst(&rqst, server, pexpected_response_sequence);
-}
-
-/* must be called with server->srv_mutex held */
-int cifs_sign_smb(struct smb_hdr *cifs_pdu, unsigned int pdu_len,
-		  struct TCP_Server_Info *server,
-		  __u32 *pexpected_response_sequence_number)
-{
-	struct kvec iov[1] = {
-		[0].iov_base = (char *)cifs_pdu,
-		[0].iov_len = pdu_len,
-	};
-
-	return cifs_sign_smbv(iov, ARRAY_SIZE(iov), server,
-			      pexpected_response_sequence_number);
-}
-
 int cifs_verify_signature(struct smb_rqst *rqst,
 			  struct TCP_Server_Info *server,
 			  __u32 expected_sequence_number)
diff --git a/fs/smb/client/cifsproto.h b/fs/smb/client/cifsproto.h
index 7d03b425c6bb..4657635e6dfc 100644
--- a/fs/smb/client/cifsproto.h
+++ b/fs/smb/client/cifsproto.h
@@ -30,8 +30,6 @@ extern void cifs_buf_release(void *);
 extern struct smb_hdr *cifs_small_buf_get(void);
 extern void cifs_small_buf_release(void *);
 extern void free_rsp_buf(int, void *);
-extern int smb_send(struct TCP_Server_Info *, struct smb_hdr *,
-			unsigned int /* length */);
 extern int smb_send_kvec(struct TCP_Server_Info *server,
 			 struct msghdr *msg,
 			 size_t *sent);
@@ -562,11 +560,6 @@ extern void tconInfoFree(struct cifs_tcon *tcon, enum smb3_tcon_ref_trace trace)
 
 extern int cifs_sign_rqst(struct smb_rqst *rqst, struct TCP_Server_Info *server,
 		   __u32 *pexpected_response_sequence_number);
-int cifs_sign_smbv(struct kvec *iov, int n_vec, struct TCP_Server_Info *server,
-		   __u32 *pexpected_response_sequence);
-int cifs_sign_smb(struct smb_hdr *cifs_pdu, unsigned int pdu_len,
-		  struct TCP_Server_Info *server,
-		  __u32 *pexpected_response_sequence_number);
 int cifs_verify_signature(struct smb_rqst *rqst,
 			  struct TCP_Server_Info *server,
 			  __u32 expected_sequence_number);
diff --git a/fs/smb/client/cifstransport.c b/fs/smb/client/cifstransport.c
index fb8b34944c02..5b07d0555526 100644
--- a/fs/smb/client/cifstransport.c
+++ b/fs/smb/client/cifstransport.c
@@ -70,22 +70,6 @@ alloc_mid(const struct smb_hdr *smb_buffer, struct TCP_Server_Info *server)
 	return smb;
 }
 
-int
-smb_send(struct TCP_Server_Info *server, struct smb_hdr *smb_buffer,
-	 unsigned int smb_buf_length)
-{
-	struct kvec iov[1] = {
-		[0].iov_base = smb_buffer,
-		[0].iov_len = smb_buf_length,
-	};
-	struct smb_rqst rqst = {
-		.rq_iov = iov,
-		.rq_nvec = ARRAY_SIZE(iov),
-	};
-
-	return __smb_send_rqst(server, 1, &rqst);
-}
-
 static int allocate_mid(struct cifs_ses *ses, struct smb_hdr *in_buf,
 			struct smb_message **ppmidQ)
 {
@@ -369,7 +353,7 @@ int SendReceiveBlockingLock(const unsigned int xid, struct cifs_tcon *tcon,
 		return rc;
 	}
 
-	rc = cifs_sign_smb(in_buf, in_len, server, &smb->sequence_number);
+	rc = cifs_sign_rqst(&rqst, server, &smb->sequence_number);
 	if (rc) {
 		delete_mid(smb);
 		cifs_server_unlock(server);
@@ -377,7 +361,7 @@ int SendReceiveBlockingLock(const unsigned int xid, struct cifs_tcon *tcon,
 	}
 
 	smb->mid_state = MID_REQUEST_SUBMITTED;
-	rc = smb_send(server, in_buf, in_len);
+	rc = __smb_send_rqst(server, 1, &rqst);
 	cifs_save_when_sent(smb);
 
 	if (rc < 0)
diff --git a/fs/smb/client/smb1ops.c b/fs/smb/client/smb1ops.c
index e7d83bca1c38..93c52e4288db 100644
--- a/fs/smb/client/smb1ops.c
+++ b/fs/smb/client/smb1ops.c
@@ -32,17 +32,21 @@ static int
 send_nt_cancel(struct TCP_Server_Info *server, struct smb_rqst *rqst,
 	       struct smb_message *smb)
 {
-	int rc = 0;
 	struct smb_hdr *in_buf = (struct smb_hdr *)rqst->rq_iov[0].iov_base;
-	unsigned int in_len = rqst->rq_iov[0].iov_len;
+	struct kvec iov[1];
+	struct smb_rqst crqst = { .rq_iov = iov, .rq_nvec = 1 };
+	int rc = 0;
 
 	/* +2 for BCC field */
 	in_buf->Command = SMB_COM_NT_CANCEL;
 	in_buf->WordCount = 0;
 	put_bcc(0, in_buf);
 
+	iov[0].iov_base = in_buf;
+	iov[0].iov_len  = sizeof(struct smb_hdr) + 2;
+
 	cifs_server_lock(server);
-	rc = cifs_sign_smb(in_buf, in_len, server, &smb->sequence_number);
+	rc = cifs_sign_rqst(&crqst, server, &smb->sequence_number);
 	if (rc) {
 		cifs_server_unlock(server);
 		return rc;
@@ -54,7 +58,7 @@ send_nt_cancel(struct TCP_Server_Info *server, struct smb_rqst *rqst,
 	 * after signing here.
 	 */
 	--server->sequence_number;
-	rc = smb_send(server, in_buf, in_len);
+	rc = __smb_send_rqst(server, 1, &crqst);
 	if (rc < 0)
 		server->sequence_number--;
 
diff --git a/fs/smb/client/transport.c b/fs/smb/client/transport.c
index 2e338e186809..7036acd6542b 100644
--- a/fs/smb/client/transport.c
+++ b/fs/smb/client/transport.c
@@ -995,6 +995,9 @@ compound_send_recv(const unsigned int xid, struct cifs_ses *ses,
 	if ((ses->ses_status == SES_NEW) || (optype & CIFS_NEG_OP) || (optype & CIFS_SESS_OP)) {
 		spin_unlock(&ses->ses_lock);
 
+		if (WARN_ON_ONCE(num_rqst != 1 || !resp_iov))
+			return -EINVAL;
+
 		cifs_server_lock(server);
 		smb311_update_preauth_hash(ses, server, rqst[0].rq_iov, rqst[0].rq_nvec);
 		cifs_server_unlock(server);
@@ -1043,22 +1046,23 @@ compound_send_recv(const unsigned int xid, struct cifs_ses *ses,
 			goto out;
 		}
 
-		buf = (char *)smb[i]->resp_buf;
-		resp_iov[i].iov_base = buf;
-		resp_iov[i].iov_len = smb[i]->resp_buf_size;
-
-		if (smb[i]->large_buf)
-			resp_buf_type[i] = CIFS_LARGE_BUFFER;
-		else
-			resp_buf_type[i] = CIFS_SMALL_BUFFER;
-
 		rc = server->ops->check_receive(smb[i], server,
 						     flags & CIFS_LOG_ERROR);
 
-		/* mark it so buf will not be freed by delete_mid */
-		if ((flags & CIFS_NO_RSP_BUF) == 0)
-			smb[i]->resp_buf = NULL;
+		if (resp_iov) {
+			buf = (char *)smb[i]->resp_buf;
+			resp_iov[i].iov_base = buf;
+			resp_iov[i].iov_len = smb[i]->resp_buf_size;
+
+			if (smb[i]->large_buf)
+				resp_buf_type[i] = CIFS_LARGE_BUFFER;
+			else
+				resp_buf_type[i] = CIFS_SMALL_BUFFER;
 
+			/* mark it so buf will not be freed by delete_mid */
+			if ((flags & CIFS_NO_RSP_BUF) == 0)
+				smb[i]->resp_buf = NULL;
+		}
 	}
 
 	/*


