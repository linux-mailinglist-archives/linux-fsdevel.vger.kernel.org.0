Return-Path: <linux-fsdevel+bounces-56897-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA5A2B1CDB6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 22:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 780BD18C643C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 20:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF2A21D58B;
	Wed,  6 Aug 2025 20:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U1uT59Gs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14142D0C6A
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Aug 2025 20:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754512725; cv=none; b=h+PlM7W7DPv+L91YPHkj71cGXHpj0FNw8kixxFPS8dTPe4+MQ6GCGURJ63bmm8+96D6niOXKFvFr8Ll38woJUBzKwmdXkAcuJKQBuEGoevbWXYUpCrHIeZNTY1R2hRyBztSzx18/GmkRonLkGjJd34gozjo2xpz3Rp4QzPybytg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754512725; c=relaxed/simple;
	bh=opiE35Rt9JSQmH+BQkXffbwbE089hXV3NX6PfZCng0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ubZxhQ+YjibmgGTl3tiryO+zRI9hfI1oGCf0Y2+iwTIPImEG1HI5nK65nUio1ahIbh8e+K8oW+7tL6UEWzsYbiJB0ExdVtrl5FP2srH9M0o8bgkhffF5SN6uqf5w8yMVdscD/F3Rf0TANFEqRqwr15fmCqHlBzGD60o1Q1vleh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U1uT59Gs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754512723;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=07VRXIBfvgv7/M7c2aX/ef138JEk7cb8LOoVOWgb+UY=;
	b=U1uT59Gsv9k1CF8MSzPLr7aa/d2p0X0EJBMfdMFQHK2k5TFUZblFqx736JPZAYZlhM3zHN
	FcnxQ8UmuNR5MgdexHXqA526ywv2wbw4eGy424a5+pMXJVWB7oUBf+P4TGO12YT5wCmWHO
	uBSotQWdx4iFE2iNmrNRolmkNCtevSY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-510-wi4ZoEewOyCnoGzN9CuKKw-1; Wed,
 06 Aug 2025 16:38:39 -0400
X-MC-Unique: wi4ZoEewOyCnoGzN9CuKKw-1
X-Mimecast-MFC-AGG-ID: wi4ZoEewOyCnoGzN9CuKKw_1754512718
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 017AA195608E;
	Wed,  6 Aug 2025 20:38:38 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.17])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E9EA530001A2;
	Wed,  6 Aug 2025 20:38:34 +0000 (UTC)
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
Subject: [RFC PATCH 17/31] cifs: Rework smb2 decryption
Date: Wed,  6 Aug 2025 21:36:38 +0100
Message-ID: <20250806203705.2560493-18-dhowells@redhat.com>
In-Reply-To: <20250806203705.2560493-1-dhowells@redhat.com>
References: <20250806203705.2560493-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Shyam Prasad N <sprasad@microsoft.com>
cc: Tom Talpey <tom@talpey.com>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/smb/client/cifsglob.h |  60 -----------------
 fs/smb/client/smb2ops.c  | 138 +++++----------------------------------
 2 files changed, 15 insertions(+), 183 deletions(-)

diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index ae06c2b5a9c8..1eed8a463b58 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -2280,66 +2280,6 @@ static inline void move_cifs_info_to_smb2(struct smb2_file_all_info *dst, const
 	dst->FileNameLength = src->FileNameLength;
 }
 
-static inline int cifs_get_num_sgs(const struct smb_rqst *rqst,
-				   int num_rqst,
-				   const u8 *sig)
-{
-	unsigned int len, skip;
-	unsigned int nents = 0;
-	unsigned long addr;
-	size_t data_size;
-	int i, j;
-
-	/*
-	 * The first rqst has a transform header where the first 20 bytes are
-	 * not part of the encrypted blob.
-	 */
-	skip = 20;
-
-	/* Assumes the first rqst has a transform header as the first iov.
-	 * I.e.
-	 * rqst[0].rq_iov[0]  is transform header
-	 * rqst[0].rq_iov[1+] data to be encrypted/decrypted
-	 * rqst[1+].rq_iov[0+] data to be encrypted/decrypted
-	 */
-	for (i = 0; i < num_rqst; i++) {
-		data_size = iov_iter_count(&rqst[i].rq_iter);
-
-		/* We really don't want a mixture of pinned and unpinned pages
-		 * in the sglist.  It's hard to keep track of which is what.
-		 * Instead, we convert to a BVEC-type iterator higher up.
-		 */
-		if (data_size &&
-		    WARN_ON_ONCE(user_backed_iter(&rqst[i].rq_iter)))
-			return -EIO;
-
-		/* We also don't want to have any extra refs or pins to clean
-		 * up in the sglist.
-		 */
-		if (data_size &&
-		    WARN_ON_ONCE(iov_iter_extract_will_pin(&rqst[i].rq_iter)))
-			return -EIO;
-
-		for (j = 0; j < rqst[i].rq_nvec; j++) {
-			struct kvec *iov = &rqst[i].rq_iov[j];
-
-			addr = (unsigned long)iov->iov_base + skip;
-			if (is_vmalloc_or_module_addr((void *)addr)) {
-				len = iov->iov_len - skip;
-				nents += DIV_ROUND_UP(offset_in_page(addr) + len,
-						      PAGE_SIZE);
-			} else {
-				nents++;
-			}
-			skip = 0;
-		}
-		if (data_size)
-			nents += iov_iter_npages(&rqst[i].rq_iter, INT_MAX);
-	}
-	nents += DIV_ROUND_UP(offset_in_page(sig) + SMB2_SIGNATURE_SIZE, PAGE_SIZE);
-	return nents;
-}
-
 /* We can not use the normal sg_set_buf() as we will sometimes pass a
  * stack object as buf.
  */
diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index baa54e746f0f..5933757d0170 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -4186,94 +4186,11 @@ fill_transform_hdr(struct smb2_transform_hdr *tr_hdr, unsigned int orig_len,
 		get_random_bytes(&tr_hdr->Nonce, SMB3_AES_CCM_NONCE);
 }
 
-static void *smb2_aead_req_alloc(struct crypto_aead *tfm, const struct smb_rqst *rqst,
-				 int num_rqst, const u8 *sig, u8 **iv,
-				 struct aead_request **req, struct sg_table *sgt,
-				 unsigned int *num_sgs, size_t *sensitive_size)
-{
-	unsigned int req_size = sizeof(**req) + crypto_aead_reqsize(tfm);
-	unsigned int iv_size = crypto_aead_ivsize(tfm);
-	unsigned int len;
-	u8 *p;
-
-	*num_sgs = cifs_get_num_sgs(rqst, num_rqst, sig);
-	if (IS_ERR_VALUE((long)(int)*num_sgs))
-		return ERR_PTR(*num_sgs);
-
-	len = iv_size;
-	len += crypto_aead_alignmask(tfm) & ~(crypto_tfm_ctx_alignment() - 1);
-	len = ALIGN(len, crypto_tfm_ctx_alignment());
-	len += req_size;
-	len = ALIGN(len, __alignof__(struct scatterlist));
-	len += array_size(*num_sgs, sizeof(struct scatterlist));
-	*sensitive_size = len;
-
-	p = kvzalloc(len, GFP_NOFS);
-	if (!p)
-		return ERR_PTR(-ENOMEM);
-
-	*iv = (u8 *)PTR_ALIGN(p, crypto_aead_alignmask(tfm) + 1);
-	*req = (struct aead_request *)PTR_ALIGN(*iv + iv_size,
-						crypto_tfm_ctx_alignment());
-	sgt->sgl = (struct scatterlist *)PTR_ALIGN((u8 *)*req + req_size,
-						   __alignof__(struct scatterlist));
-	return p;
-}
-
-static void *smb2_get_aead_req(struct crypto_aead *tfm, struct smb_rqst *rqst,
-			       int num_rqst, const u8 *sig, u8 **iv,
-			       struct aead_request **req, struct scatterlist **sgl,
-			       size_t *sensitive_size)
-{
-	struct sg_table sgtable = {};
-	unsigned int skip, num_sgs, i, j;
-	ssize_t rc;
-	void *p;
-
-	p = smb2_aead_req_alloc(tfm, rqst, num_rqst, sig, iv, req, &sgtable,
-				&num_sgs, sensitive_size);
-	if (IS_ERR(p))
-		return ERR_CAST(p);
-
-	sg_init_marker(sgtable.sgl, num_sgs);
-
-	/*
-	 * The first rqst has a transform header where the
-	 * first 20 bytes are not part of the encrypted blob.
-	 */
-	skip = 20;
-
-	for (i = 0; i < num_rqst; i++) {
-		struct iov_iter *iter = &rqst[i].rq_iter;
-		size_t count = iov_iter_count(iter);
-
-		for (j = 0; j < rqst[i].rq_nvec; j++) {
-			cifs_sg_set_buf(&sgtable,
-					rqst[i].rq_iov[j].iov_base + skip,
-					rqst[i].rq_iov[j].iov_len - skip);
-
-			/* See the above comment on the 'skip' assignment */
-			skip = 0;
-		}
-		sgtable.orig_nents = sgtable.nents;
-
-		rc = extract_iter_to_sg(iter, count, &sgtable,
-					num_sgs - sgtable.nents, 0);
-		iov_iter_revert(iter, rc);
-		sgtable.orig_nents = sgtable.nents;
-	}
-
-	cifs_sg_set_buf(&sgtable, sig, SMB2_SIGNATURE_SIZE);
-	sg_mark_end(&sgtable.sgl[sgtable.nents - 1]);
-	*sgl = sgtable.sgl;
-	return p;
-}
-
 /*
  * Allocate the context info needed for the encryption operation, along with a
  * scatterlist to point to the buffer.
  */
-static void *smb2_aead_req_alloc_new(struct crypto_aead *tfm, const struct iov_iter *iter,
+static void *smb2_aead_req_alloc(struct crypto_aead *tfm, const struct iov_iter *iter,
 				 const u8 *sig, u8 **iv,
 				 struct aead_request **req, struct sg_table *sgt,
 				 unsigned int *num_sgs, size_t *sensitive_size)
@@ -4309,10 +4226,10 @@ static void *smb2_aead_req_alloc_new(struct crypto_aead *tfm, const struct iov_i
  * Set up for doing a crypto operation, building a scatterlist from the
  * supplied iterator.
  */
-static void *smb2_get_aead_req_new(struct crypto_aead *tfm, const struct iov_iter *iter,
-				   const u8 *sig, u8 **iv,
-				   struct aead_request **req, struct scatterlist **sgl,
-				   size_t *sensitive_size)
+static void *smb2_get_aead_req(struct crypto_aead *tfm, const struct iov_iter *iter,
+			       const u8 *sig, u8 **iv,
+			       struct aead_request **req, struct scatterlist **sgl,
+			       size_t *sensitive_size)
 {
 	struct sg_table sgtable = {};
 	struct iov_iter tmp = *iter;
@@ -4320,8 +4237,8 @@ static void *smb2_get_aead_req_new(struct crypto_aead *tfm, const struct iov_ite
 	ssize_t rc;
 	void *p;
 
-	p = smb2_aead_req_alloc_new(tfm, iter, sig, iv, req, &sgtable,
-				    &num_sgs, sensitive_size);
+	p = smb2_aead_req_alloc(tfm, iter, sig, iv, req, &sgtable,
+				&num_sgs, sensitive_size);
 	if (IS_ERR(p))
 		return ERR_CAST(p);
 
@@ -4412,8 +4329,8 @@ encrypt_message(struct TCP_Server_Info *server,
 		return rc;
 	}
 
-	creq = smb2_get_aead_req_new(tfm, iter, sign, &iv, &req, &sg,
-				     &sensitive_size);
+	creq = smb2_get_aead_req(tfm, iter, sign, &iv, &req, &sg,
+				 &sensitive_size);
 	if (IS_ERR(creq))
 		return PTR_ERR(creq);
 
@@ -4446,11 +4363,10 @@ encrypt_message(struct TCP_Server_Info *server,
  * untouched.
  */
 static int
-decrypt_message(struct TCP_Server_Info *server, int num_rqst,
-		struct smb_rqst *rqst, struct crypto_aead *tfm)
+decrypt_message(struct TCP_Server_Info *server,
+		struct smb2_transform_hdr *tr_hdr,
+		struct iov_iter *iter, struct crypto_aead *tfm)
 {
-	struct smb2_transform_hdr *tr_hdr =
-		(struct smb2_transform_hdr *)rqst[0].rq_iov[0].iov_base;
 	unsigned int assoc_data_len = sizeof(struct smb2_transform_hdr) - 20;
 	int rc = 0;
 	struct scatterlist *sg;
@@ -4486,8 +4402,7 @@ decrypt_message(struct TCP_Server_Info *server, int num_rqst,
 		return rc;
 	}
 
-	creq = smb2_get_aead_req(tfm, rqst, num_rqst, sign, &iv, &req, &sg,
-				 &sensitive_size);
+	creq = smb2_get_aead_req(tfm, iter, sign, &iv, &req, &sg, &sensitive_size);
 	if (IS_ERR(creq))
 		return PTR_ERR(creq);
 
@@ -4546,24 +4461,10 @@ decrypt_raw_data(struct TCP_Server_Info *server, char *buf,
 		 unsigned int buf_data_size, struct iov_iter *iter,
 		 bool is_offloaded)
 {
+	struct smb2_transform_hdr *tr_hdr = (struct smb2_transform_hdr *)buf;
 	struct crypto_aead *tfm;
-	struct smb_rqst rqst = {NULL};
-	struct kvec iov[2];
-	size_t iter_size = 0;
 	int rc;
 
-	iov[0].iov_base = buf;
-	iov[0].iov_len = sizeof(struct smb2_transform_hdr);
-	iov[1].iov_base = buf + sizeof(struct smb2_transform_hdr);
-	iov[1].iov_len = buf_data_size;
-
-	rqst.rq_iov = iov;
-	rqst.rq_nvec = 2;
-	if (iter) {
-		rqst.rq_iter = *iter;
-		iter_size = iov_iter_count(iter);
-	}
-
 	if (is_offloaded) {
 		if ((server->cipher_type == SMB2_ENCRYPTION_AES128_GCM) ||
 		    (server->cipher_type == SMB2_ENCRYPTION_AES256_GCM))
@@ -4583,20 +4484,11 @@ decrypt_raw_data(struct TCP_Server_Info *server, char *buf,
 		tfm = server->secmech.dec;
 	}
 
-	rc = decrypt_message(server, 1, &rqst, tfm);
+	rc = decrypt_message(server, tr_hdr, iter, tfm);
 	cifs_dbg(FYI, "Decrypt message returned %d\n", rc);
 
 	if (is_offloaded)
 		crypto_free_aead(tfm);
-
-	if (rc)
-		return rc;
-
-	memmove(buf, iov[1].iov_base, buf_data_size);
-
-	if (!is_offloaded)
-		server->total_read = buf_data_size + iter_size;
-
 	return rc;
 }
 


