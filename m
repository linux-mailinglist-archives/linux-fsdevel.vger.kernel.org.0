Return-Path: <linux-fsdevel+bounces-56894-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6FAAB1CDAB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 22:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BC631890DDF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 20:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 407F02C2AA5;
	Wed,  6 Aug 2025 20:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EWpuGyPi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9C72C08AB
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Aug 2025 20:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754512712; cv=none; b=QZEWCZrxpOVQVbmkyaXXXUc83mO6zf0R1TR2Wl2CTHDGQQ55chhce5XiTEakvW+I0gYm3yaCoh58f/9RriwX/f8QImK4S2g50GKbzsSo8SiQ02iwZAGzQ0PsZkc7OaNKE7ogQaI0S3El6frT9HWhjQYo3rzesEqeqB1ktF208/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754512712; c=relaxed/simple;
	bh=RADfIKwPhj+DkAPatNQkX2gb7fWflAIEqUTVTjDwFZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F+G5qiFzjCZaQNfByfw7BK+xgScl0u8zEK5guDhkLRR6sOhOtygC36/zQMOF3UNcXE8UpM4UuMNqpbu+lLMA1Nl43B3uwBzBmYWp5A/5+oMZOj3XItbIUTcFcDdbseMJRsdCOB3uYyD/MYjlCrbDJXU1TEiPwDrmyv1A5x6QDcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EWpuGyPi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754512708;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V53J5dLsJ8va+hHlO5XgVswqLQWMnx9lx0yK9P6Bodw=;
	b=EWpuGyPiwtPbOgouHE0851awW6fNPZvWULjROaDkTogdHGwb1AEMwLd0rMzHmDWxj5gBlk
	oVVVCu91NrJfWapXmAEROA2DWv0RM00SKXTVTCiJuCPWnJVx0nnUDQ+6h7InDSzKpDRHJa
	N5uxwfmpXGS7kadmtgLF4SZ0InmkCoY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-685-bKiLt4O8MsOY2Yur167_xg-1; Wed,
 06 Aug 2025 16:38:25 -0400
X-MC-Unique: bKiLt4O8MsOY2Yur167_xg-1
X-Mimecast-MFC-AGG-ID: bKiLt4O8MsOY2Yur167_xg_1754512703
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8E0EA1800342;
	Wed,  6 Aug 2025 20:38:23 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.17])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 714FE180035C;
	Wed,  6 Aug 2025 20:38:20 +0000 (UTC)
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
Subject: [RFC PATCH 14/31] cifs: Split crypt_message() into encrypt and decrypt variants
Date: Wed,  6 Aug 2025 21:36:35 +0100
Message-ID: <20250806203705.2560493-15-dhowells@redhat.com>
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

Split crypt_message() into encrypt and decrypt variants so that the encrypt
variant can be substantially changed.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Shyam Prasad N <sprasad@microsoft.com>
cc: Tom Talpey <tom@talpey.com>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/smb/client/smb2ops.c | 100 ++++++++++++++++++++++++++++++++++------
 1 file changed, 85 insertions(+), 15 deletions(-)

diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 7b714e50f681..0ad4a2a012a0 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -4297,16 +4297,17 @@ smb2_get_enc_key(struct TCP_Server_Info *server, __u64 ses_id, int enc, u8 *key)
 
 	return -EAGAIN;
 }
+
 /*
- * Encrypt or decrypt @rqst message. @rqst[0] has the following format:
+ * Encrypt @rqst message. @rqst[0] has the following format:
  * iov[0]   - transform header (associate data),
  * iov[1-N] - SMB2 header and pages - data to encrypt.
  * On success return encrypted data in iov[1-N] and pages, leave iov[0]
  * untouched.
  */
 static int
-crypt_message(struct TCP_Server_Info *server, int num_rqst,
-	      struct smb_rqst *rqst, int enc, struct crypto_aead *tfm)
+encrypt_message(struct TCP_Server_Info *server, int num_rqst,
+		struct smb_rqst *rqst, struct crypto_aead *tfm)
 {
 	struct smb2_transform_hdr *tr_hdr =
 		(struct smb2_transform_hdr *)rqst[0].rq_iov[0].iov_base;
@@ -4321,10 +4322,10 @@ crypt_message(struct TCP_Server_Info *server, int num_rqst,
 	void *creq;
 	size_t sensitive_size;
 
-	rc = smb2_get_enc_key(server, le64_to_cpu(tr_hdr->SessionId), enc, key);
+	rc = smb2_get_enc_key(server, le64_to_cpu(tr_hdr->SessionId), 1, key);
 	if (rc) {
-		cifs_server_dbg(FYI, "%s: Could not get %scryption key. sid: 0x%llx\n", __func__,
-			 enc ? "en" : "de", le64_to_cpu(tr_hdr->SessionId));
+		cifs_server_dbg(FYI, "%s: Could not get encryption key. sid: 0x%llx\n",
+				__func__, le64_to_cpu(tr_hdr->SessionId));
 		return rc;
 	}
 
@@ -4350,11 +4351,6 @@ crypt_message(struct TCP_Server_Info *server, int num_rqst,
 	if (IS_ERR(creq))
 		return PTR_ERR(creq);
 
-	if (!enc) {
-		memcpy(sign, &tr_hdr->Signature, SMB2_SIGNATURE_SIZE);
-		crypt_len += SMB2_SIGNATURE_SIZE;
-	}
-
 	if ((server->cipher_type == SMB2_ENCRYPTION_AES128_GCM) ||
 	    (server->cipher_type == SMB2_ENCRYPTION_AES256_GCM))
 		memcpy(iv, (char *)tr_hdr->Nonce, SMB3_AES_GCM_NONCE);
@@ -4367,15 +4363,89 @@ crypt_message(struct TCP_Server_Info *server, int num_rqst,
 	aead_request_set_crypt(req, sg, sg, crypt_len, iv);
 	aead_request_set_ad(req, assoc_data_len);
 
-	rc = enc ? crypto_aead_encrypt(req) : crypto_aead_decrypt(req);
+	rc = crypto_aead_encrypt(req);
 
-	if (!rc && enc)
+	if (!rc)
 		memcpy(&tr_hdr->Signature, sign, SMB2_SIGNATURE_SIZE);
 
 	kvfree_sensitive(creq, sensitive_size);
 	return rc;
 }
 
+/*
+ * Decrypt @rqst message. @rqst[0] has the following format:
+ * iov[0]   - transform header (associate data),
+ * iov[1-N] - SMB2 header and pages - data to decrypt.
+ * On success return encrypted data in iov[1-N] and pages, leave iov[0]
+ * untouched.
+ */
+static int
+decrypt_message(struct TCP_Server_Info *server, int num_rqst,
+		struct smb_rqst *rqst, struct crypto_aead *tfm)
+{
+	struct smb2_transform_hdr *tr_hdr =
+		(struct smb2_transform_hdr *)rqst[0].rq_iov[0].iov_base;
+	unsigned int assoc_data_len = sizeof(struct smb2_transform_hdr) - 20;
+	int rc = 0;
+	struct scatterlist *sg;
+	u8 sign[SMB2_SIGNATURE_SIZE] = {};
+	u8 key[SMB3_ENC_DEC_KEY_SIZE];
+	struct aead_request *req;
+	u8 *iv;
+	unsigned int crypt_len = le32_to_cpu(tr_hdr->OriginalMessageSize);
+	void *creq;
+	size_t sensitive_size;
+
+	rc = smb2_get_enc_key(server, le64_to_cpu(tr_hdr->SessionId), 0, key);
+	if (rc) {
+		cifs_server_dbg(FYI, "%s: Could not get decryption key. sid: 0x%llx\n",
+				__func__, le64_to_cpu(tr_hdr->SessionId));
+		return rc;
+	}
+
+	if ((server->cipher_type == SMB2_ENCRYPTION_AES256_CCM) ||
+		(server->cipher_type == SMB2_ENCRYPTION_AES256_GCM))
+		rc = crypto_aead_setkey(tfm, key, SMB3_GCM256_CRYPTKEY_SIZE);
+	else
+		rc = crypto_aead_setkey(tfm, key, SMB3_GCM128_CRYPTKEY_SIZE);
+
+	if (rc) {
+		cifs_server_dbg(VFS, "%s: Failed to set aead key %d\n", __func__, rc);
+		return rc;
+	}
+
+	rc = crypto_aead_setauthsize(tfm, SMB2_SIGNATURE_SIZE);
+	if (rc) {
+		cifs_server_dbg(VFS, "%s: Failed to set authsize %d\n", __func__, rc);
+		return rc;
+	}
+
+	creq = smb2_get_aead_req(tfm, rqst, num_rqst, sign, &iv, &req, &sg,
+				 &sensitive_size);
+	if (IS_ERR(creq))
+		return PTR_ERR(creq);
+
+	memcpy(sign, &tr_hdr->Signature, SMB2_SIGNATURE_SIZE);
+	crypt_len += SMB2_SIGNATURE_SIZE;
+
+	if ((server->cipher_type == SMB2_ENCRYPTION_AES128_GCM) ||
+	    (server->cipher_type == SMB2_ENCRYPTION_AES256_GCM))
+		memcpy(iv, (char *)tr_hdr->Nonce, SMB3_AES_GCM_NONCE);
+	else {
+		iv[0] = 3;
+		memcpy(iv + 1, (char *)tr_hdr->Nonce, SMB3_AES_CCM_NONCE);
+	}
+
+	aead_request_set_tfm(req, tfm);
+	aead_request_set_crypt(req, sg, sg, crypt_len, iv);
+	aead_request_set_ad(req, assoc_data_len);
+
+	rc = crypto_aead_decrypt(req);
+
+	kvfree_sensitive(creq, sensitive_size);
+	return rc;
+}
+
 /*
  * Clear a read buffer, discarding the folios which have the 1st mark set.
  */
@@ -4509,7 +4579,7 @@ smb3_init_transform_rq(struct TCP_Server_Info *server, int num_rqst,
 	/* fill the 1st iov with a transform header */
 	fill_transform_hdr(tr_hdr, orig_len, old_rq, server->cipher_type);
 
-	rc = crypt_message(server, num_rqst, new_rq, 1, server->secmech.enc);
+	rc = encrypt_message(server, num_rqst, new_rq, server->secmech.enc);
 	cifs_dbg(FYI, "Encrypt message returned %d\n", rc);
 	if (rc)
 		goto err_free;
@@ -4571,7 +4641,7 @@ decrypt_raw_data(struct TCP_Server_Info *server, char *buf,
 		tfm = server->secmech.dec;
 	}
 
-	rc = crypt_message(server, 1, &rqst, 0, tfm);
+	rc = decrypt_message(server, 1, &rqst, tfm);
 	cifs_dbg(FYI, "Decrypt message returned %d\n", rc);
 
 	if (is_offloaded)


