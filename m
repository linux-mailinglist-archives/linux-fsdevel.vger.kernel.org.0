Return-Path: <linux-fsdevel+bounces-56896-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D3F5B1CDB2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 22:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6D5518C574D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 20:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635C421D3E9;
	Wed,  6 Aug 2025 20:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AJU8j05x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B371C2C375F
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Aug 2025 20:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754512723; cv=none; b=aI6JwBdoy1OgVYuiAnm3SQfkJqRM1VTBM619MRmD3j42P6duxooYFT0pUfxByGl7zc37o+PQZOSPQIW2LVElSjsN72siovVtjQBe6teR07TILlCANiBvUBZdHopakYHyXAZlA3hu3ihur0xSodHTJB2ftgbqXOjeR2jiC6oAM+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754512723; c=relaxed/simple;
	bh=Ev9aDVlQl03tSih1Vac14+mpYMO5Vzjk9GuHD3Qq5Zk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cbnx7Wh/soJUhrV48scPQuvYbKxAZjg7cfXVXEQJQFEwsnC7VRcTin1LGVNiUFVk7VjmcU5RXiq5DjL5aKFiM7UkTY8upEaH1IVCDmwU/tM1Gxd2eUgLVw8qLmtgVl/h8xhZ/YEA3H3L7+DiCHZkzMHuVAPv5hVdWdhKkPnQpfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AJU8j05x; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754512718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nYpFtBQ1DTRlehEoGRFF9StIG4KMdzYznICqXS3nZGg=;
	b=AJU8j05xVPdHWscInxpeF4TahkepAJjrqChvAEfh0f7gT4SSKErWKm6T1+R42y1B6cb3S+
	BPBX6Um4WAH4UcPl6iQJKaaX4eWuFyxU3r65n1j81S8HePME3C2C+vVElJLeVvYJRZpOcI
	Kxg5e9vtpjHm/1AZsAm0kcfj9M9T6dQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-455-NvBeLjk3PH-T2pf-0kfhIA-1; Wed,
 06 Aug 2025 16:38:35 -0400
X-MC-Unique: NvBeLjk3PH-T2pf-0kfhIA-1
X-Mimecast-MFC-AGG-ID: NvBeLjk3PH-T2pf-0kfhIA_1754512713
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4E2F3195608E;
	Wed,  6 Aug 2025 20:38:33 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.17])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 05B311800447;
	Wed,  6 Aug 2025 20:38:29 +0000 (UTC)
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
Subject: [RFC PATCH 16/31] cifs: Rewrite base TCP transmission
Date: Wed,  6 Aug 2025 21:36:37 +0100
Message-ID: <20250806203705.2560493-17-dhowells@redhat.com>
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

[!] NOTE: This patch is not fully complete: RDMA is untested and compression
is currently disabled

Rewrite the base TCP transmission in cifs to copy all the content in a
(compound) message into a buffer of pages in a bvecq chain.  In future, the
pages in this bvecq chain will be allocated from the netmem allocator so
that the advance DMA/IOMMU handling will be done.

This list of pages can then be attached to an ITER_BVEC_QUEUE-type iov_iter
and passed in a single call to sendmsg() with MSG_SPLICE_PAGES, thereby
avoiding the need to copy the data in the TCP stack.

The encryption code can also be simplified as it only needs to encrypt the
data stored in those pages, with the bonus that the content in the pages is
correctly aligned for the encryption in place such that it does not need to
copy the data whilst encrypting it.

It could be arranged for the data to be held in contiguous pages if
possible and if necessary such that crypto can be offloaded to devices that
only permit a single contiguous buffer.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Shyam Prasad N <sprasad@microsoft.com>
cc: Tom Talpey <tom@talpey.com>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/buffer.c         |   3 +-
 fs/smb/client/cifsglob.h  |   7 +-
 fs/smb/client/cifsproto.h |   5 +-
 fs/smb/client/smb1ops.c   |   5 +-
 fs/smb/client/smb2ops.c   | 193 ++++++++++++-------------
 fs/smb/client/smbdirect.c |  88 ++----------
 fs/smb/client/smbdirect.h |   5 +-
 fs/smb/client/transport.c | 291 +++++++++++++++++++++++++++-----------
 8 files changed, 330 insertions(+), 267 deletions(-)

diff --git a/fs/netfs/buffer.c b/fs/netfs/buffer.c
index 1e4ed2746e95..84d5ddc2a2c0 100644
--- a/fs/netfs/buffer.c
+++ b/fs/netfs/buffer.c
@@ -93,7 +93,8 @@ void netfs_free_bvecq_buffer(struct bvecq *bq)
 
 	for (; bq; bq = next) {
 		for (int seg = 0; seg < bq->nr_segs; seg++)
-			__free_page(bq->bv[seg].bv_page);
+			if (bq->bv[seg].bv_page)
+				__free_page(bq->bv[seg].bv_page);
 		next = bq->next;
 		kfree(bq);
 	}
diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index 90dafae1e9ab..ae06c2b5a9c8 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -594,8 +594,10 @@ struct smb_version_operations {
 	long (*fallocate)(struct file *, struct cifs_tcon *, int, loff_t,
 			  loff_t);
 	/* init transform (compress/encrypt) request */
-	int (*init_transform_rq)(struct TCP_Server_Info *, int num_rqst,
-				 struct smb_rqst *, struct smb_rqst *);
+	int (*init_transform_rq)(struct TCP_Server_Info *server,
+				 int num_rqst, const struct smb_rqst *rqst,
+				 struct smb2_transform_hdr *tr_hdr,
+				 struct iov_iter *iter);
 	int (*is_transform_hdr)(void *buf);
 	int (*receive_transform)(struct TCP_Server_Info *,
 				 struct smb_message **smb, char **, int *);
@@ -1356,7 +1358,6 @@ struct tcon_link {
 };
 
 extern struct tcon_link *cifs_sb_tlink(struct cifs_sb_info *cifs_sb);
-extern void smb3_free_compound_rqst(int num_rqst, struct smb_rqst *rqst);
 
 static inline struct cifs_tcon *
 tlink_tcon(struct tcon_link *tlink)
diff --git a/fs/smb/client/cifsproto.h b/fs/smb/client/cifsproto.h
index 6f27fb6ef5dc..76cb047b2715 100644
--- a/fs/smb/client/cifsproto.h
+++ b/fs/smb/client/cifsproto.h
@@ -32,6 +32,8 @@ extern void free_rsp_buf(int, void *);
 extern int smb_send_kvec(struct TCP_Server_Info *server,
 			 struct msghdr *msg,
 			 size_t *sent);
+int smb_sendmsg(struct TCP_Server_Info *server, struct msghdr *smb_msg,
+		size_t *sent);
 extern unsigned int _get_xid(void);
 extern void _free_xid(unsigned int);
 #define get_xid()							\
@@ -120,8 +122,7 @@ extern struct smb_message *cifs_setup_request(struct cifs_ses *,
 				struct smb_rqst *);
 extern struct smb_message *cifs_setup_async_request(struct TCP_Server_Info *,
 						struct smb_rqst *);
-int __smb_send_rqst(struct TCP_Server_Info *server, int num_rqst,
-		    struct smb_rqst *rqst);
+int __smb_send_rqst(struct TCP_Server_Info *server, struct iov_iter *iter);
 extern int cifs_check_receive(struct smb_message *msg,
 			struct TCP_Server_Info *server, bool log_error);
 int wait_for_free_request(struct TCP_Server_Info *server, const int flags,
diff --git a/fs/smb/client/smb1ops.c b/fs/smb/client/smb1ops.c
index cc5b3c531c77..185210b7fd03 100644
--- a/fs/smb/client/smb1ops.c
+++ b/fs/smb/client/smb1ops.c
@@ -32,6 +32,7 @@ send_nt_cancel(struct cifs_ses *ses, struct TCP_Server_Info *server,
 	       struct smb_rqst *rqst, struct smb_message *smb,
 	       unsigned int xid)
 {
+	struct iov_iter iter;
 	struct smb_hdr *in_buf = (struct smb_hdr *)rqst->rq_iov[0].iov_base;
 	struct kvec iov[1];
 	struct smb_rqst crqst = { .rq_iov = iov, .rq_nvec = 1 };
@@ -53,13 +54,15 @@ send_nt_cancel(struct cifs_ses *ses, struct TCP_Server_Info *server,
 		return rc;
 	}
 
+	iov_iter_kvec(&iter, ITER_SOURCE, iov, 1, iov[0].iov_len);
+
 	/*
 	 * The response to this call was already factored into the sequence
 	 * number when the call went out, so we must adjust it back downward
 	 * after signing here.
 	 */
 	--server->sequence_number;
-	rc = __smb_send_rqst(server, 1, &crqst);
+	rc = __smb_send_rqst(server, &iter);
 	if (rc < 0)
 		server->sequence_number--;
 
diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 161cef316346..baa54e746f0f 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -4169,21 +4169,21 @@ smb2_dir_needs_close(struct cifsFileInfo *cfile)
 
 static void
 fill_transform_hdr(struct smb2_transform_hdr *tr_hdr, unsigned int orig_len,
-		   struct smb_rqst *old_rq, __le16 cipher_type)
+		   const struct smb_rqst *old_rq, __le16 cipher_type)
 {
-	struct smb2_hdr *shdr =
-			(struct smb2_hdr *)old_rq->rq_iov[0].iov_base;
+	struct smb2_hdr *shdr = (struct smb2_hdr *)old_rq->rq_iov[0].iov_base;
 
-	memset(tr_hdr, 0, sizeof(struct smb2_transform_hdr));
-	tr_hdr->ProtocolId = SMB2_TRANSFORM_PROTO_NUM;
-	tr_hdr->OriginalMessageSize = cpu_to_le32(orig_len);
-	tr_hdr->Flags = cpu_to_le16(0x01);
+	*tr_hdr = (struct smb2_transform_hdr){
+		.ProtocolId		= SMB2_TRANSFORM_PROTO_NUM,
+		.OriginalMessageSize	= cpu_to_le32(orig_len),
+		.Flags			= cpu_to_le16(0x01),
+		.SessionId		= shdr->SessionId,
+	};
 	if ((cipher_type == SMB2_ENCRYPTION_AES128_GCM) ||
 	    (cipher_type == SMB2_ENCRYPTION_AES256_GCM))
 		get_random_bytes(&tr_hdr->Nonce, SMB3_AES_GCM_NONCE);
 	else
 		get_random_bytes(&tr_hdr->Nonce, SMB3_AES_CCM_NONCE);
-	memcpy(&tr_hdr->SessionId, &shdr->SessionId, 8);
 }
 
 static void *smb2_aead_req_alloc(struct crypto_aead *tfm, const struct smb_rqst *rqst,
@@ -4269,6 +4269,75 @@ static void *smb2_get_aead_req(struct crypto_aead *tfm, struct smb_rqst *rqst,
 	return p;
 }
 
+/*
+ * Allocate the context info needed for the encryption operation, along with a
+ * scatterlist to point to the buffer.
+ */
+static void *smb2_aead_req_alloc_new(struct crypto_aead *tfm, const struct iov_iter *iter,
+				 const u8 *sig, u8 **iv,
+				 struct aead_request **req, struct sg_table *sgt,
+				 unsigned int *num_sgs, size_t *sensitive_size)
+{
+	unsigned int req_size = sizeof(**req) + crypto_aead_reqsize(tfm);
+	unsigned int iv_size = crypto_aead_ivsize(tfm);
+	unsigned int len;
+	u8 *p;
+
+	*num_sgs = iov_iter_npages(iter, INT_MAX);
+
+	len = iv_size;
+	len += crypto_aead_alignmask(tfm) & ~(crypto_tfm_ctx_alignment() - 1);
+	len = ALIGN(len, crypto_tfm_ctx_alignment());
+	len += req_size;
+	len = ALIGN(len, __alignof__(struct scatterlist));
+	len += array_size(*num_sgs, sizeof(struct scatterlist));
+	*sensitive_size = len;
+
+	p = kvzalloc(len, GFP_NOFS);
+	if (!p)
+		return ERR_PTR(-ENOMEM);
+
+	*iv = (u8 *)PTR_ALIGN(p, crypto_aead_alignmask(tfm) + 1);
+	*req = (struct aead_request *)PTR_ALIGN(*iv + iv_size,
+						crypto_tfm_ctx_alignment());
+	sgt->sgl = (struct scatterlist *)PTR_ALIGN((u8 *)*req + req_size,
+						   __alignof__(struct scatterlist));
+	return p;
+}
+
+/*
+ * Set up for doing a crypto operation, building a scatterlist from the
+ * supplied iterator.
+ */
+static void *smb2_get_aead_req_new(struct crypto_aead *tfm, const struct iov_iter *iter,
+				   const u8 *sig, u8 **iv,
+				   struct aead_request **req, struct scatterlist **sgl,
+				   size_t *sensitive_size)
+{
+	struct sg_table sgtable = {};
+	struct iov_iter tmp = *iter;
+	unsigned int num_sgs;
+	ssize_t rc;
+	void *p;
+
+	p = smb2_aead_req_alloc_new(tfm, iter, sig, iv, req, &sgtable,
+				    &num_sgs, sensitive_size);
+	if (IS_ERR(p))
+		return ERR_CAST(p);
+
+	sg_init_marker(sgtable.sgl, num_sgs);
+
+	rc = extract_iter_to_sg(&tmp, iov_iter_count(iter), &sgtable, num_sgs, 0);
+	sgtable.orig_nents = sgtable.nents;
+	if (rc < 0)
+		return ERR_PTR(rc);
+
+	cifs_sg_set_buf(&sgtable, sig, SMB2_SIGNATURE_SIZE);
+	sg_mark_end(&sgtable.sgl[sgtable.nents - 1]);
+	*sgl = sgtable.sgl;
+	return p;
+}
+
 static int
 smb2_get_enc_key(struct TCP_Server_Info *server, __u64 ses_id, int enc, u8 *key)
 {
@@ -4299,18 +4368,15 @@ smb2_get_enc_key(struct TCP_Server_Info *server, __u64 ses_id, int enc, u8 *key)
 }
 
 /*
- * Encrypt @rqst message. @rqst[0] has the following format:
- * iov[0]   - transform header (associate data),
- * iov[1-N] - SMB2 header and pages - data to encrypt.
+ * Encrypt the message in the buffer described by the iterator.
  * On success return encrypted data in iov[1-N] and pages, leave iov[0]
  * untouched.
  */
 static int
-encrypt_message(struct TCP_Server_Info *server, int num_rqst,
-		struct smb_rqst *rqst, struct crypto_aead *tfm)
+encrypt_message(struct TCP_Server_Info *server,
+		struct smb2_transform_hdr *tr_hdr,
+		struct iov_iter *iter, struct crypto_aead *tfm)
 {
-	struct smb2_transform_hdr *tr_hdr =
-		(struct smb2_transform_hdr *)rqst[0].rq_iov[0].iov_base;
 	unsigned int assoc_data_len = sizeof(struct smb2_transform_hdr) - 20;
 	int rc = 0;
 	struct scatterlist *sg;
@@ -4346,8 +4412,8 @@ encrypt_message(struct TCP_Server_Info *server, int num_rqst,
 		return rc;
 	}
 
-	creq = smb2_get_aead_req(tfm, rqst, num_rqst, sign, &iv, &req, &sg,
-				 &sensitive_size);
+	creq = smb2_get_aead_req_new(tfm, iter, sign, &iv, &req, &sg,
+				     &sensitive_size);
 	if (IS_ERR(creq))
 		return PTR_ERR(creq);
 
@@ -4447,94 +4513,23 @@ decrypt_message(struct TCP_Server_Info *server, int num_rqst,
 }
 
 /*
- * Copy data from an iterator to the folios in a folio queue buffer.
- */
-static bool cifs_copy_iter_to_folioq(struct iov_iter *iter, size_t size,
-				     struct folio_queue *buffer)
-{
-	for (; buffer; buffer = buffer->next) {
-		for (int s = 0; s < folioq_count(buffer); s++) {
-			struct folio *folio = folioq_folio(buffer, s);
-			size_t part = folioq_folio_size(buffer, s);
-
-			part = umin(part, size);
-
-			if (copy_folio_from_iter(folio, 0, part, iter) != part)
-				return false;
-			size -= part;
-		}
-	}
-	return true;
-}
-
-void
-smb3_free_compound_rqst(int num_rqst, struct smb_rqst *rqst)
-{
-	for (int i = 0; i < num_rqst; i++)
-		netfs_free_folioq_buffer(rqst[i].rq_buffer);
-}
-
-/*
- * This function will initialize new_rq and encrypt the content.
- * The first entry, new_rq[0], only contains a single iov which contains
- * a smb2_transform_hdr and is pre-allocated by the caller.
- * This function then populates new_rq[1+] with the content from olq_rq[0+].
- *
- * The end result is an array of smb_rqst structures where the first structure
- * only contains a single iov for the transform header which we then can pass
- * to crypt_message().
- *
- * new_rq[0].rq_iov[0] :  smb2_transform_hdr pre-allocated by the caller
- * new_rq[1+].rq_iov[*] == old_rq[0+].rq_iov[*] : SMB2/3 requests
+ * This function encrypts the content in the buffer described by the iterator
+ * and fills in the transform header.  The source request buffers are provided
+ * for reference.
  */
 static int
-smb3_init_transform_rq(struct TCP_Server_Info *server, int num_rqst,
-		       struct smb_rqst *new_rq, struct smb_rqst *old_rq)
+smb3_init_transform_rq(struct TCP_Server_Info *server,
+		       int num_rqst, const struct smb_rqst *rqst,
+		       struct smb2_transform_hdr *tr_hdr,
+		       struct iov_iter *iter)
 {
-	struct smb2_transform_hdr *tr_hdr = new_rq[0].rq_iov[0].iov_base;
-	unsigned int orig_len = 0;
-	int rc = -ENOMEM;
-
-	for (int i = 1; i < num_rqst; i++) {
-		struct smb_rqst *old = &old_rq[i - 1];
-		struct smb_rqst *new = &new_rq[i];
-		struct folio_queue *buffer;
-		size_t size = iov_iter_count(&old->rq_iter);
-
-		orig_len += smb_rqst_len(server, old);
-		new->rq_iov = old->rq_iov;
-		new->rq_nvec = old->rq_nvec;
-
-		if (size > 0) {
-			size_t cur_size = 0;
-			rc = netfs_alloc_folioq_buffer(NULL, &buffer, &cur_size,
-						       size, GFP_NOFS);
-			if (rc < 0)
-				goto err_free;
-
-			new->rq_buffer = buffer;
-			iov_iter_folio_queue(&new->rq_iter, ITER_SOURCE,
-					     buffer, 0, 0, size);
-
-			if (!cifs_copy_iter_to_folioq(&old->rq_iter, size, buffer)) {
-				rc = -EIO;
-				goto err_free;
-			}
-		}
-	}
+	int rc;
 
-	/* fill the 1st iov with a transform header */
-	fill_transform_hdr(tr_hdr, orig_len, old_rq, server->cipher_type);
+	fill_transform_hdr(tr_hdr, iov_iter_count(iter), rqst,
+			   server->cipher_type);
 
-	rc = encrypt_message(server, num_rqst, new_rq, server->secmech.enc);
+	rc = encrypt_message(server, tr_hdr, iter, server->secmech.enc);
 	cifs_dbg(FYI, "Encrypt message returned %d\n", rc);
-	if (rc)
-		goto err_free;
-
-	return rc;
-
-err_free:
-	smb3_free_compound_rqst(num_rqst - 1, &new_rq[1]);
 	return rc;
 }
 
diff --git a/fs/smb/client/smbdirect.c b/fs/smb/client/smbdirect.c
index 754e94a0e07f..a75cb3f0ca72 100644
--- a/fs/smb/client/smbdirect.c
+++ b/fs/smb/client/smbdirect.c
@@ -1015,27 +1015,6 @@ static int smbd_post_send_empty(struct smbd_connection *info)
 	return smbd_post_send_iter(info, NULL, &remaining_data_length);
 }
 
-static int smbd_post_send_full_iter(struct smbd_connection *info,
-				    struct iov_iter *iter,
-				    int *_remaining_data_length)
-{
-	int rc = 0;
-
-	/*
-	 * smbd_post_send_iter() respects the
-	 * negotiated max_send_size, so we need to
-	 * loop until the full iter is posted
-	 */
-
-	while (iov_iter_count(iter) > 0) {
-		rc = smbd_post_send_iter(info, iter, _remaining_data_length);
-		if (rc < 0)
-			break;
-	}
-
-	return rc;
-}
-
 /*
  * Post a receive request to the transport
  * The remote peer can only send data when a receive request is posted
@@ -1929,75 +1908,38 @@ int smbd_recv(struct smbd_connection *info, struct msghdr *msg)
 
 /*
  * Send data to transport
- * Each rqst is transported as a SMBDirect payload
- * rqst: the data to write
  * return value: 0 if successfully write, otherwise error code
  */
-int smbd_send(struct TCP_Server_Info *server,
-	int num_rqst, struct smb_rqst *rqst_array)
+int smbd_send(struct TCP_Server_Info *server, struct iov_iter *iter)
 {
 	struct smbd_connection *info = server->smbd_conn;
 	struct smbdirect_socket *sc = &info->socket;
 	struct smbdirect_socket_parameters *sp = &sc->parameters;
-	struct smb_rqst *rqst;
-	struct iov_iter iter;
-	unsigned int remaining_data_length, klen;
-	int rc, i, rqst_idx;
+	size_t size = iov_iter_count(iter);
+	unsigned int remain = 0;
+	int rc;
 
 	if (sc->status != SMBDIRECT_SOCKET_CONNECTED)
 		return -EAGAIN;
 
-	/*
-	 * Add in the page array if there is one. The caller needs to set
-	 * rq_tailsz to PAGE_SIZE when the buffer has multiple pages and
-	 * ends at page boundary
-	 */
-	remaining_data_length = 0;
-	for (i = 0; i < num_rqst; i++)
-		remaining_data_length += smb_rqst_len(server, &rqst_array[i]);
-
-	if (unlikely(remaining_data_length > sp->max_fragmented_send_size)) {
+	if (unlikely(size > sp->max_fragmented_send_size)) {
 		/* assertion: payload never exceeds negotiated maximum */
-		log_write(ERR, "payload size %d > max size %d\n",
-			remaining_data_length, sp->max_fragmented_send_size);
+		log_write(ERR, "payload size %zu > max size %d\n",
+			  size, sp->max_fragmented_send_size);
 		return -EINVAL;
 	}
 
-	log_write(INFO, "num_rqst=%d total length=%u\n",
-			num_rqst, remaining_data_length);
-
-	rqst_idx = 0;
-	do {
-		rqst = &rqst_array[rqst_idx];
-
-		cifs_dbg(FYI, "Sending smb (RDMA): idx=%d smb_len=%lu\n",
-			 rqst_idx, smb_rqst_len(server, rqst));
-		for (i = 0; i < rqst->rq_nvec; i++)
-			dump_smb(rqst->rq_iov[i].iov_base, rqst->rq_iov[i].iov_len);
-
-		log_write(INFO, "RDMA-WR[%u] nvec=%d len=%u iter=%zu rqlen=%lu\n",
-			  rqst_idx, rqst->rq_nvec, remaining_data_length,
-			  iov_iter_count(&rqst->rq_iter), smb_rqst_len(server, rqst));
+	log_write(INFO, "size=%zu\n", size);
 
-		/* Send the metadata pages. */
-		klen = 0;
-		for (i = 0; i < rqst->rq_nvec; i++)
-			klen += rqst->rq_iov[i].iov_len;
-		iov_iter_kvec(&iter, ITER_SOURCE, rqst->rq_iov, rqst->rq_nvec, klen);
-
-		rc = smbd_post_send_full_iter(info, &iter, &remaining_data_length);
+	/*
+	 * smbd_post_send_iter() respects the negotiated max_send_size, so we
+	 * need to loop until the full iter is posted
+	 */
+	while (iov_iter_count(iter) > 0) {
+		rc = smbd_post_send_iter(info, iter, &remain);
 		if (rc < 0)
 			break;
-
-		if (iov_iter_count(&rqst->rq_iter) > 0) {
-			/* And then the data pages if there are any */
-			rc = smbd_post_send_full_iter(info, &rqst->rq_iter,
-						      &remaining_data_length);
-			if (rc < 0)
-				break;
-		}
-
-	} while (++rqst_idx < num_rqst);
+	}
 
 	/*
 	 * As an optimization, we don't wait for individual I/O to finish
diff --git a/fs/smb/client/smbdirect.h b/fs/smb/client/smbdirect.h
index 75b3f491c3ad..aec119d95c5c 100644
--- a/fs/smb/client/smbdirect.h
+++ b/fs/smb/client/smbdirect.h
@@ -214,8 +214,7 @@ void smbd_destroy(struct TCP_Server_Info *server);
 
 /* Interface for carrying upper layer I/O through send/recv */
 int smbd_recv(struct smbd_connection *info, struct msghdr *msg);
-int smbd_send(struct TCP_Server_Info *server,
-	int num_rqst, struct smb_rqst *rqst);
+int smbd_send(struct TCP_Server_Info *server, struct iov_iter *iter);
 
 enum mr_state {
 	MR_READY,
@@ -254,7 +253,7 @@ static inline void *smbd_get_connection(
 static inline int smbd_reconnect(struct TCP_Server_Info *server) {return -1; }
 static inline void smbd_destroy(struct TCP_Server_Info *server) {}
 static inline int smbd_recv(struct smbd_connection *info, struct msghdr *msg) {return -1; }
-static inline int smbd_send(struct TCP_Server_Info *server, int num_rqst, struct smb_rqst *rqst) {return -1; }
+static inline int smbd_send(struct TCP_Server_Info *server, struct iov_iter *iter) {return -1; }
 #endif
 
 #endif
diff --git a/fs/smb/client/transport.c b/fs/smb/client/transport.c
index 288351c27fc4..6459acf959f3 100644
--- a/fs/smb/client/transport.c
+++ b/fs/smb/client/transport.c
@@ -22,6 +22,8 @@
 #include <linux/mempool.h>
 #include <linux/sched/signal.h>
 #include <linux/task_io_accounting_ops.h>
+#include <linux/iov_iter.h>
+#include "rfc1002pdu.h"
 #include "cifspdu.h"
 #include "cifsglob.h"
 #include "cifsproto.h"
@@ -244,6 +246,80 @@ smb_send_kvec(struct TCP_Server_Info *server, struct msghdr *smb_msg,
 	return 0;
 }
 
+/*
+ * smb_sendmsg - send a buffer to the socket
+ * @server:	Server to send the data to
+ * @smb_msg:	Message to send
+ * @sent:	amount of data sent on socket is stored here
+ *
+ * Our basic "send data to server" function. Should be called with srv_mutex
+ * held. The caller is responsible for handling the results.
+ */
+int smb_sendmsg(struct TCP_Server_Info *server, struct msghdr *smb_msg,
+		size_t *sent)
+{
+	int rc = 0;
+	int retries = 0;
+	struct socket *ssocket = server->ssocket;
+
+	*sent = 0;
+
+	if (server->noblocksnd)
+		smb_msg->msg_flags = MSG_DONTWAIT + MSG_NOSIGNAL;
+	else
+		smb_msg->msg_flags = MSG_NOSIGNAL;
+	smb_msg->msg_flags = MSG_SPLICE_PAGES;
+
+	while (msg_data_left(smb_msg)) {
+		/*
+		 * If blocking send, we try 3 times, since each can block
+		 * for 5 seconds. For nonblocking  we have to try more
+		 * but wait increasing amounts of time allowing time for
+		 * socket to clear.  The overall time we wait in either
+		 * case to send on the socket is about 15 seconds.
+		 * Similarly we wait for 15 seconds for a response from
+		 * the server in SendReceive[2] for the server to send
+		 * a response back for most types of requests (except
+		 * SMB Write past end of file which can be slow, and
+		 * blocking lock operations). NFS waits slightly longer
+		 * than CIFS, but this can make it take longer for
+		 * nonresponsive servers to be detected and 15 seconds
+		 * is more than enough time for modern networks to
+		 * send a packet.  In most cases if we fail to send
+		 * after the retries we will kill the socket and
+		 * reconnect which may clear the network problem.
+		 */
+		rc = sock_sendmsg(ssocket, smb_msg);
+		if (rc == -EAGAIN) {
+			retries++;
+			if (retries >= 14 ||
+			    (!server->noblocksnd && (retries > 2))) {
+				cifs_server_dbg(VFS, "sends on sock %p stuck for 15 seconds\n",
+					 ssocket);
+				return -EAGAIN;
+			}
+			msleep(1 << retries);
+			continue;
+		}
+
+		if (rc < 0)
+			return rc;
+
+		if (rc == 0) {
+			/* should never happen, letting socket clear before
+			   retrying is our only obvious option here */
+			cifs_server_dbg(VFS, "tcp sent no data\n");
+			msleep(500);
+			continue;
+		}
+
+		/* send was at least partially successful */
+		*sent += rc;
+		retries = 0; /* in case we get ENOSPC on the next send */
+	}
+	return 0;
+}
+
 unsigned long
 smb_rqst_len(struct TCP_Server_Info *server, struct smb_rqst *rqst)
 {
@@ -269,26 +345,22 @@ smb_rqst_len(struct TCP_Server_Info *server, struct smb_rqst *rqst)
 	return buflen;
 }
 
-int __smb_send_rqst(struct TCP_Server_Info *server, int num_rqst,
-		    struct smb_rqst *rqst)
+int
+__smb_send_rqst(struct TCP_Server_Info *server, struct iov_iter *iter)
 {
-	int rc;
-	struct kvec *iov;
-	int n_vec;
+	struct socket *ssocket = server->ssocket;
+	struct msghdr smb_msg = { .msg_iter = *iter, };
 	unsigned int send_length = 0;
-	unsigned int i, j;
 	sigset_t mask, oldmask;
-	size_t total_len = 0, sent, size;
-	struct socket *ssocket = server->ssocket;
-	struct msghdr smb_msg = {};
-	__be32 rfc1002_marker;
+	size_t total_len = 0, sent;
+	int rc;
 
 	cifs_in_send_inc(server);
 	if (cifs_rdma_enabled(server)) {
 		/* return -EAGAIN when connecting or reconnecting */
 		rc = -EAGAIN;
 		if (server->smbd_conn)
-			rc = smbd_send(server, num_rqst, rqst);
+			rc = smbd_send(server, iter);
 		goto smbd_done;
 	}
 
@@ -306,10 +378,6 @@ int __smb_send_rqst(struct TCP_Server_Info *server, int num_rqst,
 	/* cork the socket */
 	tcp_sock_set_cork(ssocket->sk, true);
 
-	for (j = 0; j < num_rqst; j++)
-		send_length += smb_rqst_len(server, &rqst[j]);
-	rfc1002_marker = cpu_to_be32(send_length);
-
 	/*
 	 * We should not allow signals to interrupt the network send because
 	 * any partial send will cause session reconnects thus increasing
@@ -320,52 +388,9 @@ int __smb_send_rqst(struct TCP_Server_Info *server, int num_rqst,
 	sigfillset(&mask);
 	sigprocmask(SIG_BLOCK, &mask, &oldmask);
 
-	/* Generate a rfc1002 marker for SMB2+ */
-	if (!is_smb1(server)) {
-		struct kvec hiov = {
-			.iov_base = &rfc1002_marker,
-			.iov_len  = 4
-		};
-		iov_iter_kvec(&smb_msg.msg_iter, ITER_SOURCE, &hiov, 1, 4);
-		rc = smb_send_kvec(server, &smb_msg, &sent);
-		if (rc < 0)
-			goto unmask;
-
-		total_len += sent;
-		send_length += 4;
-	}
-
-	cifs_dbg(FYI, "Sending smb: smb_len=%u\n", send_length);
-
-	for (j = 0; j < num_rqst; j++) {
-		iov = rqst[j].rq_iov;
-		n_vec = rqst[j].rq_nvec;
-
-		size = 0;
-		for (i = 0; i < n_vec; i++) {
-			dump_smb(iov[i].iov_base, iov[i].iov_len);
-			size += iov[i].iov_len;
-		}
-
-		iov_iter_kvec(&smb_msg.msg_iter, ITER_SOURCE, iov, n_vec, size);
-
-		rc = smb_send_kvec(server, &smb_msg, &sent);
-		if (rc < 0)
-			goto unmask;
+	cifs_dbg(FYI, "Sending smb: smb_len=%zu\n", iov_iter_count(iter));
+	rc = smb_sendmsg(server, &smb_msg, &sent);
 
-		total_len += sent;
-
-		if (iov_iter_count(&rqst[j].rq_iter) > 0) {
-			smb_msg.msg_iter = rqst[j].rq_iter;
-			rc = smb_send_kvec(server, &smb_msg, &sent);
-			if (rc < 0)
-				break;
-			total_len += sent;
-		}
-
-}
-
-unmask:
 	sigprocmask(SIG_SETMASK, &oldmask, NULL);
 
 	/*
@@ -379,7 +404,7 @@ int __smb_send_rqst(struct TCP_Server_Info *server, int num_rqst,
 	 * won't be any response from the server to handle.
 	 */
 
-	if (signal_pending(current) && (total_len != send_length)) {
+	if (signal_pending(current) && (total_len != iov_iter_count(iter))) {
 		cifs_dbg(FYI, "signal is pending after attempt to send\n");
 		rc = -ERESTARTSYS;
 	}
@@ -387,7 +412,7 @@ int __smb_send_rqst(struct TCP_Server_Info *server, int num_rqst,
 	/* uncork it */
 	tcp_sock_set_cork(ssocket->sk, false);
 
-	if ((total_len > 0) && (total_len != send_length)) {
+	if (total_len > 0 && total_len != iov_iter_count(iter)) {
 		cifs_dbg(FYI, "partial send (wanted=%u sent=%zu): terminating session\n",
 			 send_length, total_len);
 		/*
@@ -417,41 +442,137 @@ int __smb_send_rqst(struct TCP_Server_Info *server, int num_rqst,
 	return rc;
 }
 
+static size_t smb3_copy_data_iter(void *iter_from, size_t progress, size_t len,
+				  void *priv, void *priv2)
+{
+	struct iov_iter *iter = priv;
+	return copy_to_iter(iter_from, len, iter) == len ? 0 : len;
+}
+
+/*
+ * Copy the data into a buffer that we can use for encryption in place and also
+ * pass to sendmsg() with MSG_SPLICE_PAGES.  This avoids a lot of copies in TCP
+ * at the expense of an upfront here.  A spare slot is left in the bvec queue
+ * at the front for the header(s).
+ */
+static int smb_copy_data_into_buffer(struct TCP_Server_Info *server,
+				     int num_rqst, struct smb_rqst *rqst,
+				     struct iov_iter *iter, struct bvecq **_bq)
+{
+	struct bvecq *bq;
+	size_t total_len = 0, offset = 0;
+
+	for (int i = 0; i < num_rqst; i++) {
+		struct smb_rqst *req = &rqst[i];
+		size_t size = iov_iter_count(&req->rq_iter);
+
+		for (int j = 0; j < req->rq_nvec; j++)
+			size += req->rq_iov[j].iov_len;
+		total_len = ALIGN8(total_len);
+		total_len += size;
+	}
+
+	bq = netfs_alloc_bvecq_buffer(total_len, 1, GFP_NOFS);
+	if (!bq)
+		return -ENOMEM;
+
+	iov_iter_bvec_queue(iter, ITER_DEST, bq, 1, 0, total_len);
+
+	for (int i = 0; i < num_rqst; i++) {
+		struct smb_rqst *req = &rqst[i];
+		size_t size = iov_iter_count(&req->rq_iter);
+
+		if (offset & 7) {
+			unsigned int tmp = offset;
+			offset = ALIGN8(offset);
+			iov_iter_zero(offset - tmp, iter);
+		}
+
+		for (int j = 0; j < req->rq_nvec; j++) {
+			size_t len = req->rq_iov[j].iov_len;
+			if (copy_to_iter(req->rq_iov[j].iov_base, len, iter) != len)
+				goto error;
+			offset += len;
+		}
+
+		if (iterate_and_advance_kernel(&req->rq_iter,
+					       size, iter, NULL,
+					       smb3_copy_data_iter) != size)
+			goto error;
+
+		offset += size;
+	}
+
+	if (WARN_ONCE(offset != total_len,
+		      "offset=%zx total_len=%zx\n", offset, total_len)) {
+		goto error;
+	}
+	iov_iter_bvec_queue(iter, ITER_DEST, bq, 1, 0, total_len);
+	*_bq = bq;
+	return 0;
+error:
+	netfs_free_bvecq_buffer(bq);
+	*_bq = NULL;
+	return -EIO;
+}
+
 static int
 smb_send_rqst(struct TCP_Server_Info *server, int num_rqst,
 	      struct smb_rqst *rqst, int flags)
 {
-	struct smb2_transform_hdr tr_hdr;
-	struct smb_rqst new_rqst[MAX_COMPOUND] = {};
-	struct kvec iov = {
-		.iov_base = &tr_hdr,
-		.iov_len = sizeof(tr_hdr),
-	};
+	struct smb2_transform_hdr *tr_hdr;
+	struct iov_iter iter;
+	struct bvecq *bq;
+	u32 content_len;
 	int rc;
 
-	if (flags & CIFS_COMPRESS_REQ)
-		return smb_compress(server, &rqst[0], __smb_send_rqst);
-
-	if (!(flags & CIFS_TRANSFORM_REQ))
-		return __smb_send_rqst(server, num_rqst, rqst);
-
-	if (WARN_ON_ONCE(num_rqst > MAX_COMPOUND - 1))
-		return -EIO;
-
-	if (!server->ops->init_transform_rq) {
+	if ((flags & CIFS_TRANSFORM_REQ) &&
+	    !server->ops->init_transform_rq) {
 		cifs_server_dbg(VFS, "Encryption requested but transform callback is missing\n");
 		return -EIO;
 	}
 
-	new_rqst[0].rq_iov = &iov;
-	new_rqst[0].rq_nvec = 1;
+	rc = smb_copy_data_into_buffer(server, num_rqst, rqst, &iter, &bq);
+	if (rc)
+		return rc;
+	content_len = iov_iter_count(&iter);
+
+	if (is_smb1(server)) {
+		iov_iter_bvec_queue(&iter, ITER_SOURCE, bq, 1, 0, content_len);
+	} else {
+		__le32 *rfc1002;
+		void *hdr_blob;
+		u32 hdr_len = 0;
+
+		/* TODO: Allocate netmem here */
+		rc = -ENOMEM;
+		hdr_blob = (void *)__get_free_page(GFP_NOFS);
+		if (!hdr_blob)
+			goto error;
+
+		//if (flags & CIFS_COMPRESS_REQ)
+		//	return smb_compress(server, &iter, &bq);
+
+		/* Set the RFC1002 header at the front. */
+		rfc1002 = hdr_blob;
+		*rfc1002 = cpu_to_be32(RFC1002_SESSION_MESSAGE << 24 | content_len);
+
+		if (flags & CIFS_TRANSFORM_REQ) {
+			tr_hdr = hdr_blob + 4;
+			hdr_len += sizeof(*tr_hdr);
+			iov_iter_bvec_queue(&iter, ITER_SOURCE, bq, 1, 0, content_len);
+
+			rc = server->ops->init_transform_rq(server, num_rqst, rqst, tr_hdr, &iter);
+			if (rc)
+				goto error;
+		}
 
-	rc = server->ops->init_transform_rq(server, num_rqst + 1,
-					    new_rqst, rqst);
-	if (!rc) {
-		rc = __smb_send_rqst(server, num_rqst + 1, new_rqst);
-		smb3_free_compound_rqst(num_rqst, &new_rqst[1]);
+		bvec_set_virt(&bq->bv[0], hdr_blob, hdr_len);
+		iov_iter_bvec_queue(&iter, ITER_SOURCE, bq, 0, 0, hdr_len + content_len);
 	}
+	rc = __smb_send_rqst(server, &iter);
+error:
+	netfs_free_bvecq_buffer(bq);
 	return rc;
 }
 


