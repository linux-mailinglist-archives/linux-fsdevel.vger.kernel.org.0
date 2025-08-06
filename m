Return-Path: <linux-fsdevel+bounces-56891-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3FD3B1CDA2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 22:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1D815652E0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 20:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2021F220F29;
	Wed,  6 Aug 2025 20:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XVXe7lFp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D3F2BE051
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Aug 2025 20:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754512699; cv=none; b=OcFDjjstXiBbgzvLuX1JbFNFc0OVnszhe6oZE/2wRQFTNs4b12R2+7cNOqyVSlvVIOEsgIn6Lb+6a7AMVxawS0z4IPv+hs7Exq8v8jXmfF6eIKb7jmZDNvabQlEDo4a2quwHZWKgIdcaZsz6FzkOQ8mdd8OePhtc9WEXffspUNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754512699; c=relaxed/simple;
	bh=gDaXEXJDUMkLWSrJWjx1ltg2Wa9lzByBdJ1ftNaDH3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=th2OC3iXdxhZG4gNCF1mx0ca0Rz36jHqMCbVX3cGEykf1U243f0RHSYJnbOodhdgNt6IK9iC1dKqDdoE+XuNkSeS/lES7IxFeCRC+wpV7Nt8OyRyKMAh2wpMJ/d5w44ygYSAWDr7ZIo4yEuNT1wqYGwWptlf0XnxqT7VarAe6es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XVXe7lFp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754512695;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AZxxbXT3Ta/qf75DsVMKh90isbtBz2lEPc6Xx8XIGa0=;
	b=XVXe7lFpLy+iqruVPp0262pPDOEf8gyltymIPUMkbxmWvVeauUxRYnGZsIBNUFwK8yeuG8
	75+eRKqb6RWVSFtWd4QT1FSmldtbNMhuEGMUrFTGguafeNfL53pFk+Qyd/4EH4HCQC0OAc
	2L1XoqohI4TIGLLWVJG2Fp6SK4wfuIg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-534-LYiIFpnuNyW4ZXlySuoW7Q-1; Wed,
 06 Aug 2025 16:38:11 -0400
X-MC-Unique: LYiIFpnuNyW4ZXlySuoW7Q-1
X-Mimecast-MFC-AGG-ID: LYiIFpnuNyW4ZXlySuoW7Q_1754512689
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B4D001955E95;
	Wed,  6 Aug 2025 20:38:09 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.17])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A7C8D180035C;
	Wed,  6 Aug 2025 20:38:06 +0000 (UTC)
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
Subject: [RFC PATCH 11/31] cifs: Fix SMB1 to not require separate kvec for the rfc1002 header
Date: Wed,  6 Aug 2025 21:36:32 +0100
Message-ID: <20250806203705.2560493-12-dhowells@redhat.com>
In-Reply-To: <20250806203705.2560493-1-dhowells@redhat.com>
References: <20250806203705.2560493-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Fix SMB1 to not require separate kvec for the rfc1002 header, which seems
to be something intended to make the signing algorithm simpler, but at the
expense of additional complexity everywhere else.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Shyam Prasad N <sprasad@microsoft.com>
cc: Tom Talpey <tom@talpey.com>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/smb/client/cifsencrypt.c   | 77 +++++++--------------------------
 fs/smb/client/cifsproto.h     |  5 ---
 fs/smb/client/cifssmb.c       | 28 ++++++------
 fs/smb/client/cifstransport.c | 81 +++++++----------------------------
 fs/smb/client/smb1ops.c       | 11 +++--
 fs/smb/client/transport.c     | 27 ++++++------
 6 files changed, 65 insertions(+), 164 deletions(-)

diff --git a/fs/smb/client/cifsencrypt.c b/fs/smb/client/cifsencrypt.c
index 35892df7335c..a1f17604b4c6 100644
--- a/fs/smb/client/cifsencrypt.c
+++ b/fs/smb/client/cifsencrypt.c
@@ -58,38 +58,25 @@ int __cifs_calc_signature(struct smb_rqst *rqst,
 			  struct TCP_Server_Info *server, char *signature,
 			  struct shash_desc *shash)
 {
-	int i;
+	struct iov_iter iter;
 	ssize_t rc;
-	struct kvec *iov = rqst->rq_iov;
-	int n_vec = rqst->rq_nvec;
-
-	/* iov[0] is actual data and not the rfc1002 length for SMB2+ */
-	if (!is_smb1(server)) {
-		if (iov[0].iov_len <= 4)
-			return -EIO;
-		i = 0;
-	} else {
-		if (n_vec < 2 || iov[0].iov_len != 4)
-			return -EIO;
-		i = 1; /* skip rfc1002 length */
-	}
+	size_t size = 0;
 
-	for (; i < n_vec; i++) {
-		if (iov[i].iov_len == 0)
-			continue;
-		if (iov[i].iov_base == NULL) {
-			cifs_dbg(VFS, "null iovec entry\n");
-			return -EIO;
-		}
+	for (int i = 0; i < rqst->rq_nvec; i++)
+		size += rqst->rq_iov[i].iov_len;
 
-		rc = crypto_shash_update(shash,
-					 iov[i].iov_base, iov[i].iov_len);
-		if (rc) {
-			cifs_dbg(VFS, "%s: Could not update with payload\n",
-				 __func__);
-			return rc;
-		}
-	}
+	iov_iter_kvec(&iter, ITER_SOURCE, rqst->rq_iov, rqst->rq_nvec, size);
+
+	/* Skip the rfc1002 length for SMB1 */
+	if (is_smb1(server))
+		iov_iter_advance(&iter, 4);
+
+	if (iov_iter_count(&iter) <= 4)
+		return -EIO;
+
+	rc = cifs_shash_iter(&iter, iov_iter_count(&iter), shash);
+	if (rc < 0)
+		return rc;
 
 	rc = cifs_shash_iter(&rqst->rq_iter, iov_iter_count(&rqst->rq_iter), shash);
 	if (rc < 0)
@@ -145,10 +132,6 @@ int cifs_sign_rqst(struct smb_rqst *rqst, struct TCP_Server_Info *server,
 	char smb_signature[20];
 	struct smb_hdr *cifs_pdu = (struct smb_hdr *)rqst->rq_iov[0].iov_base;
 
-	if (rqst->rq_iov[0].iov_len != 4 ||
-	    rqst->rq_iov[0].iov_base + 4 != rqst->rq_iov[1].iov_base)
-		return -EIO;
-
 	if ((cifs_pdu == NULL) || (server == NULL))
 		return -EINVAL;
 
@@ -181,30 +164,6 @@ int cifs_sign_rqst(struct smb_rqst *rqst, struct TCP_Server_Info *server,
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
-int cifs_sign_smb(struct smb_hdr *cifs_pdu, struct TCP_Server_Info *server,
-		  __u32 *pexpected_response_sequence_number)
-{
-	struct kvec iov[2];
-
-	iov[0].iov_base = cifs_pdu;
-	iov[0].iov_len = 4;
-	iov[1].iov_base = (char *)cifs_pdu + 4;
-	iov[1].iov_len = be32_to_cpu(cifs_pdu->smb_buf_length);
-
-	return cifs_sign_smbv(iov, 2, server,
-			      pexpected_response_sequence_number);
-}
-
 int cifs_verify_signature(struct smb_rqst *rqst,
 			  struct TCP_Server_Info *server,
 			  __u32 expected_sequence_number)
@@ -214,10 +173,6 @@ int cifs_verify_signature(struct smb_rqst *rqst,
 	char what_we_think_sig_should_be[20];
 	struct smb_hdr *cifs_pdu = (struct smb_hdr *)rqst->rq_iov[0].iov_base;
 
-	if (rqst->rq_iov[0].iov_len != 4 ||
-	    rqst->rq_iov[0].iov_base + 4 != rqst->rq_iov[1].iov_base)
-		return -EIO;
-
 	if (cifs_pdu == NULL || server == NULL)
 		return -EINVAL;
 
diff --git a/fs/smb/client/cifsproto.h b/fs/smb/client/cifsproto.h
index 1126feb4ba5f..2b89469187d8 100644
--- a/fs/smb/client/cifsproto.h
+++ b/fs/smb/client/cifsproto.h
@@ -29,8 +29,6 @@ extern void cifs_buf_release(void *);
 extern struct smb_hdr *cifs_small_buf_get(void);
 extern void cifs_small_buf_release(void *);
 extern void free_rsp_buf(int, void *);
-extern int smb_send(struct TCP_Server_Info *, struct smb_hdr *,
-			unsigned int /* length */);
 extern int smb_send_kvec(struct TCP_Server_Info *server,
 			 struct msghdr *msg,
 			 size_t *sent);
@@ -556,9 +554,6 @@ extern void tconInfoFree(struct cifs_tcon *tcon, enum smb3_tcon_ref_trace trace)
 
 extern int cifs_sign_rqst(struct smb_rqst *rqst, struct TCP_Server_Info *server,
 		   __u32 *pexpected_response_sequence_number);
-extern int cifs_sign_smbv(struct kvec *iov, int n_vec, struct TCP_Server_Info *,
-			  __u32 *);
-extern int cifs_sign_smb(struct smb_hdr *, struct TCP_Server_Info *, __u32 *);
 extern int cifs_verify_signature(struct smb_rqst *rqst,
 				 struct TCP_Server_Info *server,
 				__u32 expected_sequence_number);
diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
index 879fa0ad6e44..66d8e2ad8cde 100644
--- a/fs/smb/client/cifssmb.c
+++ b/fs/smb/client/cifssmb.c
@@ -591,9 +591,11 @@ CIFSSMBEcho(struct TCP_Server_Info *server)
 {
 	ECHO_REQ *smb;
 	int rc = 0;
-	struct kvec iov[2];
-	struct smb_rqst rqst = { .rq_iov = iov,
-				 .rq_nvec = 2 };
+	struct kvec iov[1];
+	struct smb_rqst rqst = {
+		.rq_iov = iov,
+		.rq_nvec = ARRAY_SIZE(iov),
+	};
 
 	cifs_dbg(FYI, "In echo request\n");
 
@@ -612,10 +614,8 @@ CIFSSMBEcho(struct TCP_Server_Info *server)
 	smb->Data[0] = 'a';
 	inc_rfc1001_len(smb, 3);
 
-	iov[0].iov_len = 4;
+	iov[0].iov_len = 4 + get_rfc1002_length(smb);
 	iov[0].iov_base = smb;
-	iov[1].iov_len = get_rfc1002_length(smb);
-	iov[1].iov_base = (char *)smb + 4;
 
 	rc = cifs_call_async(server, &rqst, NULL, cifs_echo_callback, NULL,
 			     server, CIFS_NON_BLOCKING | CIFS_ECHO_OP, NULL);
@@ -1392,7 +1392,7 @@ cifs_async_readv(struct cifs_io_subrequest *rdata)
 	int wct;
 	struct cifs_tcon *tcon = tlink_tcon(rdata->req->cfile->tlink);
 	struct smb_rqst rqst = { .rq_iov = rdata->iov,
-				 .rq_nvec = 2 };
+				 .rq_nvec = 1 };
 
 	cifs_dbg(FYI, "%s: offset=%llu bytes=%zu\n",
 		 __func__, rdata->subreq.start, rdata->subreq.len);
@@ -1433,9 +1433,7 @@ cifs_async_readv(struct cifs_io_subrequest *rdata)
 
 	/* 4 for RFC1001 length + 1 for BCC */
 	rdata->iov[0].iov_base = smb;
-	rdata->iov[0].iov_len = 4;
-	rdata->iov[1].iov_base = (char *)smb + 4;
-	rdata->iov[1].iov_len = get_rfc1002_length(smb);
+	rdata->iov[0].iov_len = 4 + get_rfc1002_length(smb);
 
 	rc = cifs_call_async(tcon->ses->server, &rqst, cifs_readv_receive,
 			     cifs_readv_callback, NULL, rdata, 0, NULL);
@@ -1764,7 +1762,7 @@ cifs_async_writev(struct cifs_io_subrequest *wdata)
 	WRITE_REQ *req = NULL;
 	int wct;
 	struct cifs_tcon *tcon = tlink_tcon(wdata->req->cfile->tlink);
-	struct kvec iov[2];
+	struct kvec iov[1];
 	struct smb_rqst rqst = { };
 
 	if (tcon->ses->capabilities & CAP_LARGE_FILES) {
@@ -1798,13 +1796,11 @@ cifs_async_writev(struct cifs_io_subrequest *wdata)
 	    cpu_to_le16(offsetof(struct smb_com_write_req, Data) - 4);
 
 	/* 4 for RFC1001 length + 1 for BCC */
-	iov[0].iov_len = 4;
 	iov[0].iov_base = req;
-	iov[1].iov_len = get_rfc1002_length(req) + 1;
-	iov[1].iov_base = (char *)req + 4;
+	iov[0].iov_len = 4 + get_rfc1002_length(req) + 1;
 
 	rqst.rq_iov = iov;
-	rqst.rq_nvec = 2;
+	rqst.rq_nvec = 1;
 	rqst.rq_iter = wdata->subreq.io_iter;
 
 	cifs_dbg(FYI, "async write at %llu %zu bytes\n",
@@ -1822,7 +1818,7 @@ cifs_async_writev(struct cifs_io_subrequest *wdata)
 				(struct smb_com_writex_req *)req;
 		inc_rfc1001_len(&reqw->hdr, wdata->subreq.len + 5);
 		put_bcc(wdata->subreq.len + 5, &reqw->hdr);
-		iov[1].iov_len += 4; /* pad bigger by four bytes */
+		iov[0].iov_len += 4; /* pad bigger by four bytes */
 	}
 
 	rc = cifs_call_async(tcon->ses->server, &rqst, NULL,
diff --git a/fs/smb/client/cifstransport.c b/fs/smb/client/cifstransport.c
index f7fed73bc508..e5b75d9b9281 100644
--- a/fs/smb/client/cifstransport.c
+++ b/fs/smb/client/cifstransport.c
@@ -69,22 +69,6 @@ alloc_mid(const struct smb_hdr *smb_buffer, struct TCP_Server_Info *server)
 	return smb;
 }
 
-int
-smb_send(struct TCP_Server_Info *server, struct smb_hdr *smb_buffer,
-	 unsigned int smb_buf_length)
-{
-	struct kvec iov[2];
-	struct smb_rqst rqst = { .rq_iov = iov,
-				 .rq_nvec = 2 };
-
-	iov[0].iov_base = smb_buffer;
-	iov[0].iov_len = 4;
-	iov[1].iov_base = (char *)smb_buffer + 4;
-	iov[1].iov_len = smb_buf_length;
-
-	return __smb_send_rqst(server, 1, &rqst);
-}
-
 static int allocate_mid(struct cifs_ses *ses, struct smb_hdr *in_buf,
 			struct smb_message **ppmidQ)
 {
@@ -124,10 +108,6 @@ cifs_setup_async_request(struct TCP_Server_Info *server, struct smb_rqst *rqst)
 	struct smb_hdr *hdr = (struct smb_hdr *)rqst->rq_iov[0].iov_base;
 	struct smb_message *smb;
 
-	if (rqst->rq_iov[0].iov_len != 4 ||
-	    rqst->rq_iov[0].iov_base + 4 != rqst->rq_iov[1].iov_base)
-		return ERR_PTR(-EIO);
-
 	/* enable signing if server requires it */
 	if (server->sign)
 		hdr->Flags2 |= SMBFLG2_SECURITY_SIGNATURE;
@@ -176,21 +156,19 @@ int
 cifs_check_receive(struct smb_message *smb, struct TCP_Server_Info *server,
 		   bool log_error)
 {
-	unsigned int len = get_rfc1002_length(smb->resp_buf) + 4;
+	unsigned int len = get_rfc1002_length(smb->resp_buf);
 
 	dump_smb(smb->resp_buf, min_t(u32, 92, len));
 
 	/* convert the length into a more usable form */
 	if (server->sign) {
-		struct kvec iov[2];
+		struct kvec iov[1];
 		int rc = 0;
 		struct smb_rqst rqst = { .rq_iov = iov,
-					 .rq_nvec = 2 };
+					 .rq_nvec = 1 };
 
 		iov[0].iov_base = smb->resp_buf;
-		iov[0].iov_len = 4;
-		iov[1].iov_base = (char *)smb->resp_buf + 4;
-		iov[1].iov_len = len - 4;
+		iov[0].iov_len = len;
 		/* FIXME: add code to kill session */
 		rc = cifs_verify_signature(&rqst, server,
 					   smb->sequence_number);
@@ -211,10 +189,6 @@ cifs_setup_request(struct cifs_ses *ses, struct TCP_Server_Info *ignored,
 	struct smb_hdr *hdr = (struct smb_hdr *)rqst->rq_iov[0].iov_base;
 	struct smb_message *smb;
 
-	if (rqst->rq_iov[0].iov_len != 4 ||
-	    rqst->rq_iov[0].iov_base + 4 != rqst->rq_iov[1].iov_base)
-		return ERR_PTR(-EIO);
-
 	rc = allocate_mid(ses, hdr, &smb);
 	if (rc)
 		return ERR_PTR(rc);
@@ -231,38 +205,13 @@ SendReceive2(const unsigned int xid, struct cifs_ses *ses,
 	     struct kvec *iov, int n_vec, int *resp_buf_type /* ret */,
 	     const int flags, struct kvec *resp_iov)
 {
-	struct smb_rqst rqst;
-	struct kvec s_iov[CIFS_MAX_IOV_SIZE], *new_iov;
-	int rc;
+	struct smb_rqst rqst = {
+		.rq_iov  = iov,
+		.rq_nvec = n_vec,
+	};
 
-	if (n_vec + 1 > CIFS_MAX_IOV_SIZE) {
-		new_iov = kmalloc_array(n_vec + 1, sizeof(struct kvec),
-					GFP_KERNEL);
-		if (!new_iov) {
-			/* otherwise cifs_send_recv below sets resp_buf_type */
-			*resp_buf_type = CIFS_NO_BUFFER;
-			return -ENOMEM;
-		}
-	} else
-		new_iov = s_iov;
-
-	/* 1st iov is a RFC1001 length followed by the rest of the packet */
-	memcpy(new_iov + 1, iov, (sizeof(struct kvec) * n_vec));
-
-	new_iov[0].iov_base = new_iov[1].iov_base;
-	new_iov[0].iov_len = 4;
-	new_iov[1].iov_base += 4;
-	new_iov[1].iov_len -= 4;
-
-	memset(&rqst, 0, sizeof(struct smb_rqst));
-	rqst.rq_iov = new_iov;
-	rqst.rq_nvec = n_vec + 1;
-
-	rc = cifs_send_recv(xid, ses, ses->server,
-			    &rqst, resp_buf_type, flags, resp_iov);
-	if (n_vec + 1 > CIFS_MAX_IOV_SIZE)
-		kfree(new_iov);
-	return rc;
+	return cifs_send_recv(xid, ses, ses->server,
+			      &rqst, resp_buf_type, flags, resp_iov);
 }
 
 int
@@ -273,7 +222,7 @@ SendReceive(const unsigned int xid, struct cifs_ses *ses,
 	unsigned int len = be32_to_cpu(in_buf->smb_buf_length);
 	struct TCP_Server_Info *server;
 	struct kvec resp_iov = {};
-	struct kvec iov = { .iov_base = in_buf, .iov_len = len };
+	struct kvec iov = { .iov_base = in_buf, .iov_len = len + 4 };
 	struct smb_rqst rqst = { .rq_iov = &iov, .rq_nvec = 1 };
 	int resp_buf_type;
 	int rc = 0;
@@ -309,7 +258,7 @@ SendReceive(const unsigned int xid, struct cifs_ses *ses,
 			    &rqst, &resp_buf_type, flags, &resp_iov);
 	if (rc < 0)
 		return rc;
-	
+
 	*pbytes_returned = resp_iov.iov_len;
 	if (resp_iov.iov_len)
 		memcpy(out_buf, resp_iov.iov_base, resp_iov.iov_len);
@@ -352,7 +301,7 @@ SendReceiveBlockingLock(const unsigned int xid, struct cifs_tcon *tcon,
 	struct smb_message *smb;
 	struct cifs_ses *ses;
 	unsigned int len = be32_to_cpu(in_buf->smb_buf_length);
-	struct kvec iov = { .iov_base = in_buf, .iov_len = len };
+	struct kvec iov = { .iov_base = in_buf, .iov_len = len + 4 };
 	struct smb_rqst rqst = { .rq_iov = &iov, .rq_nvec = 1 };
 	unsigned int instance;
 	struct TCP_Server_Info *server;
@@ -402,7 +351,7 @@ SendReceiveBlockingLock(const unsigned int xid, struct cifs_tcon *tcon,
 		return rc;
 	}
 
-	rc = cifs_sign_smb(in_buf, server, &smb->sequence_number);
+	rc = cifs_sign_rqst(&rqst, server, &smb->sequence_number);
 	if (rc) {
 		delete_mid(smb);
 		cifs_server_unlock(server);
@@ -410,7 +359,7 @@ SendReceiveBlockingLock(const unsigned int xid, struct cifs_tcon *tcon,
 	}
 
 	smb->mid_state = MID_REQUEST_SUBMITTED;
-	rc = smb_send(server, in_buf, len);
+	rc = __smb_send_rqst(server, 1, &rqst);
 	cifs_save_when_sent(smb);
 
 	if (rc < 0)
diff --git a/fs/smb/client/smb1ops.c b/fs/smb/client/smb1ops.c
index dc2daba936e2..401450eadf2c 100644
--- a/fs/smb/client/smb1ops.c
+++ b/fs/smb/client/smb1ops.c
@@ -31,8 +31,10 @@ static int
 send_nt_cancel(struct TCP_Server_Info *server, struct smb_rqst *rqst,
 	       struct smb_message *smb)
 {
-	int rc = 0;
 	struct smb_hdr *in_buf = (struct smb_hdr *)rqst->rq_iov[0].iov_base;
+	struct kvec iov[1];
+	struct smb_rqst crqst = { .rq_iov = iov, .rq_nvec = 1 };
+	int rc = 0;
 
 	/* -4 for RFC1001 length and +2 for BCC field */
 	in_buf->smb_buf_length = cpu_to_be32(sizeof(struct smb_hdr) - 4  + 2);
@@ -40,8 +42,11 @@ send_nt_cancel(struct TCP_Server_Info *server, struct smb_rqst *rqst,
 	in_buf->WordCount = 0;
 	put_bcc(0, in_buf);
 
+	iov[0].iov_base = in_buf;
+	iov[0].iov_len  = sizeof(struct smb_hdr) + 2;
+
 	cifs_server_lock(server);
-	rc = cifs_sign_smb(in_buf, server, &smb->sequence_number);
+	rc = cifs_sign_rqst(&crqst, server, &smb->sequence_number);
 	if (rc) {
 		cifs_server_unlock(server);
 		return rc;
@@ -53,7 +58,7 @@ send_nt_cancel(struct TCP_Server_Info *server, struct smb_rqst *rqst,
 	 * after signing here.
 	 */
 	--server->sequence_number;
-	rc = smb_send(server, in_buf, be32_to_cpu(in_buf->smb_buf_length));
+	rc = __smb_send_rqst(server, 1, &crqst);
 	if (rc < 0)
 		server->sequence_number--;
 
diff --git a/fs/smb/client/transport.c b/fs/smb/client/transport.c
index d55b24d1aa77..db9ce9e84406 100644
--- a/fs/smb/client/transport.c
+++ b/fs/smb/client/transport.c
@@ -1036,23 +1036,24 @@ compound_send_recv(const unsigned int xid, struct cifs_ses *ses,
 			goto out;
 		}
 
-		buf = (char *)smb[i]->resp_buf;
-		resp_iov[i].iov_base = buf;
-		resp_iov[i].iov_len = smb[i]->resp_buf_size +
-			HEADER_PREAMBLE_SIZE(server);
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
+			resp_iov[i].iov_len = smb[i]->resp_buf_size +
+				HEADER_PREAMBLE_SIZE(server);
 
+			if (smb[i]->large_buf)
+				resp_buf_type[i] = CIFS_LARGE_BUFFER;
+			else
+				resp_buf_type[i] = CIFS_SMALL_BUFFER;
+
+			/* mark it so buf will not be freed by delete_mid */
+			if ((flags & CIFS_NO_RSP_BUF) == 0)
+				smb[i]->resp_buf = NULL;
+		}
 	}
 
 	/*


