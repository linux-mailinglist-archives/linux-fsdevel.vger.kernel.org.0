Return-Path: <linux-fsdevel+bounces-73005-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A5FA2D0756F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 09 Jan 2026 07:09:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AAB34305CCCE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jan 2026 06:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B3729DB8F;
	Fri,  9 Jan 2026 06:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qHwE2KbG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A776B273803;
	Fri,  9 Jan 2026 06:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767938923; cv=none; b=HhE8BoRubnww9nMR2Zzs+kgDyHgVmw16cquri7hRIsvBcO4G9NvPMUVL3K+gsHEHArf0awGy3ziy7QjicSBloK/u/9IDXb7swMYZt/8w3eGezldkbRLHr17KRg+6PMfRl45Pwiqoed2qzfphguqpEXCkr5NHpHb24TBla7V0QDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767938923; c=relaxed/simple;
	bh=Px42aambIlUAXdbRwVtIJmb4NC+JZpofA+C+RF0L2RA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jDBpLb7o6kYnJDAAPwPyEeHzOjjaes03mfThqb1Z3XtDMC5iobMhcEIBBXROPsQBBZCBMg0wkPyf4bUzyTPaJUKxCnHdmlnvHSHb8M+xb93iyZEgp4XP+qIJpupDiREl4pi+TeAv24suRb74Zz5Iugc+Ib4533UTMiRmiJcZpp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qHwE2KbG; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=ycC0gR5IVgfCQUun5CgGGh8X9mjB5nAHrP5QEvmLjS8=; b=qHwE2KbGhxJkdQwx2mzC6SOgnA
	aBi64UeRQQH7ITiBzMVYc0UaTJxptXaVmp1AFACsZ/ZqFfInhn5q6x2Fo275E08RUZqSq5pmoz4t1
	rQF7YMBwvMnboS36HIK3HiTdYItFt5pXB1d8uhQIAMbv5bwkFcNk4ZVEH4VQMWJAlw7iK0Y4eOCrK
	JBoJJBvLu/ItrSKsPvaB/S0YPqVoKZgCmWfqJuTvfroeYsF7bWArZRJ49KlkCN2KXD4yYSJfDOXbr
	YNwLH1NH6i2eFt3SuPXnIM/3SRIwkDjHCCl0tj7hUjzR395qwbu4aL3T/xPiXn/jNa3B1talAwSOj
	KwbNw7hw==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ve5fs-00000001WW8-3MHw;
	Fri, 09 Jan 2026 06:08:41 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Eric Biggers <ebiggers@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-fscrypt@vger.kernel.org
Subject: [PATCH 6/9] blk-crypto: use on-stack skcipher requests for fallback en/decryption
Date: Fri,  9 Jan 2026 07:07:46 +0100
Message-ID: <20260109060813.2226714-7-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260109060813.2226714-1-hch@lst.de>
References: <20260109060813.2226714-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Allocating a skcipher request dynamically can deadlock or cause
unexpected I/O failures when called from writeback context.  Avoid the
allocation entirely by using on-stack skciphers, similar to what the
non-blk-crypto fscrypt path already does.

This drops the incomplete support for asynchronous algorithms, which
previously could be used, but only synchronously.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Eric Biggers <ebiggers@kernel.org>
---
 block/blk-crypto-fallback.c | 179 ++++++++++++++++--------------------
 1 file changed, 79 insertions(+), 100 deletions(-)

diff --git a/block/blk-crypto-fallback.c b/block/blk-crypto-fallback.c
index 4ec7da342280..4a682230c278 100644
--- a/block/blk-crypto-fallback.c
+++ b/block/blk-crypto-fallback.c
@@ -75,7 +75,7 @@ static bool tfms_inited[BLK_ENCRYPTION_MODE_MAX];
 
 static struct blk_crypto_fallback_keyslot {
 	enum blk_crypto_mode_num crypto_mode;
-	struct crypto_skcipher *tfms[BLK_ENCRYPTION_MODE_MAX];
+	struct crypto_sync_skcipher *tfms[BLK_ENCRYPTION_MODE_MAX];
 } *blk_crypto_keyslots;
 
 static struct blk_crypto_profile *blk_crypto_fallback_profile;
@@ -98,7 +98,7 @@ static void blk_crypto_fallback_evict_keyslot(unsigned int slot)
 	WARN_ON(slotp->crypto_mode == BLK_ENCRYPTION_MODE_INVALID);
 
 	/* Clear the key in the skcipher */
-	err = crypto_skcipher_setkey(slotp->tfms[crypto_mode], blank_key,
+	err = crypto_sync_skcipher_setkey(slotp->tfms[crypto_mode], blank_key,
 				     blk_crypto_modes[crypto_mode].keysize);
 	WARN_ON(err);
 	slotp->crypto_mode = BLK_ENCRYPTION_MODE_INVALID;
@@ -119,7 +119,7 @@ blk_crypto_fallback_keyslot_program(struct blk_crypto_profile *profile,
 		blk_crypto_fallback_evict_keyslot(slot);
 
 	slotp->crypto_mode = crypto_mode;
-	err = crypto_skcipher_setkey(slotp->tfms[crypto_mode], key->bytes,
+	err = crypto_sync_skcipher_setkey(slotp->tfms[crypto_mode], key->bytes,
 				     key->size);
 	if (err) {
 		blk_crypto_fallback_evict_keyslot(slot);
@@ -176,28 +176,13 @@ static struct bio *blk_crypto_alloc_enc_bio(struct bio *bio_src,
 	return bio;
 }
 
-static bool
-blk_crypto_fallback_alloc_cipher_req(struct blk_crypto_keyslot *slot,
-				     struct skcipher_request **ciph_req_ret,
-				     struct crypto_wait *wait)
+static struct crypto_sync_skcipher *
+blk_crypto_fallback_tfm(struct blk_crypto_keyslot *slot)
 {
-	struct skcipher_request *ciph_req;
-	const struct blk_crypto_fallback_keyslot *slotp;
-	int keyslot_idx = blk_crypto_keyslot_index(slot);
-
-	slotp = &blk_crypto_keyslots[keyslot_idx];
-	ciph_req = skcipher_request_alloc(slotp->tfms[slotp->crypto_mode],
-					  GFP_NOIO);
-	if (!ciph_req)
-		return false;
-
-	skcipher_request_set_callback(ciph_req,
-				      CRYPTO_TFM_REQ_MAY_BACKLOG |
-				      CRYPTO_TFM_REQ_MAY_SLEEP,
-				      crypto_req_done, wait);
-	*ciph_req_ret = ciph_req;
+	const struct blk_crypto_fallback_keyslot *slotp =
+		&blk_crypto_keyslots[blk_crypto_keyslot_index(slot)];
 
-	return true;
+	return slotp->tfms[slotp->crypto_mode];
 }
 
 union blk_crypto_iv {
@@ -214,46 +199,22 @@ static void blk_crypto_dun_to_iv(const u64 dun[BLK_CRYPTO_DUN_ARRAY_SIZE],
 		iv->dun[i] = cpu_to_le64(dun[i]);
 }
 
-/*
- * The crypto API fallback's encryption routine.
- *
- * Allocate one or more bios for encryption, encrypt the input bio using the
- * crypto API, and submit the encrypted bios.  Sets bio->bi_status and
- * completes the source bio on error
- */
-static void blk_crypto_fallback_encrypt_bio(struct bio *src_bio)
+static void __blk_crypto_fallback_encrypt_bio(struct bio *src_bio,
+		struct crypto_sync_skcipher *tfm)
 {
 	struct bio_crypt_ctx *bc = src_bio->bi_crypt_context;
 	int data_unit_size = bc->bc_key->crypto_cfg.data_unit_size;
-	struct skcipher_request *ciph_req = NULL;
-	struct blk_crypto_keyslot *slot;
-	DECLARE_CRYPTO_WAIT(wait);
+	SYNC_SKCIPHER_REQUEST_ON_STACK(ciph_req, tfm);
 	u64 curr_dun[BLK_CRYPTO_DUN_ARRAY_SIZE];
 	struct scatterlist src, dst;
 	union blk_crypto_iv iv;
 	unsigned int nr_enc_pages, enc_idx;
 	struct bio *enc_bio;
-	blk_status_t status;
 	unsigned int i;
 
-	/*
-	 * Get a blk-crypto-fallback keyslot that contains a crypto_skcipher for
-	 * this bio's algorithm and key.
-	 */
-	status = blk_crypto_get_keyslot(blk_crypto_fallback_profile,
-					bc->bc_key, &slot);
-	if (status != BLK_STS_OK) {
-		src_bio->bi_status = status;
-		bio_endio(src_bio);
-		return;
-	}
-
-	/* and then allocate an skcipher_request for it */
-	if (!blk_crypto_fallback_alloc_cipher_req(slot, &ciph_req, &wait)) {
-		src_bio->bi_status = BLK_STS_RESOURCE;
-		bio_endio(src_bio);
-		goto out_release_keyslot;
-	}
+	skcipher_request_set_callback(ciph_req,
+			CRYPTO_TFM_REQ_MAY_BACKLOG | CRYPTO_TFM_REQ_MAY_SLEEP,
+			NULL, NULL);
 
 	memcpy(curr_dun, bc->bc_dun, sizeof(curr_dun));
 	sg_init_table(&src, 1);
@@ -297,10 +258,9 @@ static void blk_crypto_fallback_encrypt_bio(struct bio *src_bio)
 		 */
 		for (i = 0; i < src_bv.bv_len; i += data_unit_size) {
 			blk_crypto_dun_to_iv(curr_dun, &iv);
-			if (crypto_wait_req(crypto_skcipher_encrypt(ciph_req),
-					    &wait)) {
+			if (crypto_skcipher_encrypt(ciph_req)) {
 				bio_io_error(enc_bio);
-				goto out_free_request;
+				return;
 			}
 			bio_crypt_dun_increment(curr_dun, 1);
 			src.offset += data_unit_size;
@@ -327,50 +287,48 @@ static void blk_crypto_fallback_encrypt_bio(struct bio *src_bio)
 	}
 
 	submit_bio(enc_bio);
-out_free_request:
-	skcipher_request_free(ciph_req);
-out_release_keyslot:
-	blk_crypto_put_keyslot(slot);
 }
 
 /*
- * The crypto API fallback's main decryption routine.
- * Decrypts input bio in place, and calls bio_endio on the bio.
+ * The crypto API fallback's encryption routine.
+ *
+ * Allocate one or more bios for encryption, encrypt the input bio using the
+ * crypto API, and submit the encrypted bios.  Sets bio->bi_status and
+ * completes the source bio on error
  */
-static void blk_crypto_fallback_decrypt_bio(struct work_struct *work)
+static void blk_crypto_fallback_encrypt_bio(struct bio *src_bio)
 {
-	struct bio_fallback_crypt_ctx *f_ctx =
-		container_of(work, struct bio_fallback_crypt_ctx, work);
-	struct bio *bio = f_ctx->bio;
-	struct bio_crypt_ctx *bc = &f_ctx->crypt_ctx;
+	struct bio_crypt_ctx *bc = src_bio->bi_crypt_context;
 	struct blk_crypto_keyslot *slot;
-	struct skcipher_request *ciph_req = NULL;
-	DECLARE_CRYPTO_WAIT(wait);
+	blk_status_t status;
+
+	status = blk_crypto_get_keyslot(blk_crypto_fallback_profile,
+					bc->bc_key, &slot);
+	if (status != BLK_STS_OK) {
+		src_bio->bi_status = status;
+		bio_endio(src_bio);
+		return;
+	}
+	__blk_crypto_fallback_encrypt_bio(src_bio,
+			blk_crypto_fallback_tfm(slot));
+	blk_crypto_put_keyslot(slot);
+}
+
+static blk_status_t __blk_crypto_fallback_decrypt_bio(struct bio *bio,
+		struct bio_crypt_ctx *bc, struct bvec_iter iter,
+		struct crypto_sync_skcipher *tfm)
+{
+	SYNC_SKCIPHER_REQUEST_ON_STACK(ciph_req, tfm);
 	u64 curr_dun[BLK_CRYPTO_DUN_ARRAY_SIZE];
 	union blk_crypto_iv iv;
 	struct scatterlist sg;
 	struct bio_vec bv;
-	struct bvec_iter iter;
 	const int data_unit_size = bc->bc_key->crypto_cfg.data_unit_size;
 	unsigned int i;
-	blk_status_t blk_st;
-
-	/*
-	 * Get a blk-crypto-fallback keyslot that contains a crypto_skcipher for
-	 * this bio's algorithm and key.
-	 */
-	blk_st = blk_crypto_get_keyslot(blk_crypto_fallback_profile,
-					bc->bc_key, &slot);
-	if (blk_st != BLK_STS_OK) {
-		bio->bi_status = blk_st;
-		goto out_no_keyslot;
-	}
 
-	/* and then allocate an skcipher_request for it */
-	if (!blk_crypto_fallback_alloc_cipher_req(slot, &ciph_req, &wait)) {
-		bio->bi_status = BLK_STS_RESOURCE;
-		goto out;
-	}
+	skcipher_request_set_callback(ciph_req,
+			CRYPTO_TFM_REQ_MAY_BACKLOG | CRYPTO_TFM_REQ_MAY_SLEEP,
+			NULL, NULL);
 
 	memcpy(curr_dun, bc->bc_dun, sizeof(curr_dun));
 	sg_init_table(&sg, 1);
@@ -378,7 +336,7 @@ static void blk_crypto_fallback_decrypt_bio(struct work_struct *work)
 				   iv.bytes);
 
 	/* Decrypt each segment in the bio */
-	__bio_for_each_segment(bv, bio, iter, f_ctx->crypt_iter) {
+	__bio_for_each_segment(bv, bio, iter, iter) {
 		struct page *page = bv.bv_page;
 
 		sg_set_page(&sg, page, data_unit_size, bv.bv_offset);
@@ -386,21 +344,41 @@ static void blk_crypto_fallback_decrypt_bio(struct work_struct *work)
 		/* Decrypt each data unit in the segment */
 		for (i = 0; i < bv.bv_len; i += data_unit_size) {
 			blk_crypto_dun_to_iv(curr_dun, &iv);
-			if (crypto_wait_req(crypto_skcipher_decrypt(ciph_req),
-					    &wait)) {
-				bio->bi_status = BLK_STS_IOERR;
-				goto out;
-			}
+			if (crypto_skcipher_decrypt(ciph_req))
+				return BLK_STS_IOERR;
 			bio_crypt_dun_increment(curr_dun, 1);
 			sg.offset += data_unit_size;
 		}
 	}
 
-out:
-	skcipher_request_free(ciph_req);
-	blk_crypto_put_keyslot(slot);
-out_no_keyslot:
+	return BLK_STS_OK;
+}
+
+/*
+ * The crypto API fallback's main decryption routine.
+ *
+ * Decrypts input bio in place, and calls bio_endio on the bio.
+ */
+static void blk_crypto_fallback_decrypt_bio(struct work_struct *work)
+{
+	struct bio_fallback_crypt_ctx *f_ctx =
+		container_of(work, struct bio_fallback_crypt_ctx, work);
+	struct bio *bio = f_ctx->bio;
+	struct bio_crypt_ctx *bc = &f_ctx->crypt_ctx;
+	struct blk_crypto_keyslot *slot;
+	blk_status_t status;
+
+	status = blk_crypto_get_keyslot(blk_crypto_fallback_profile,
+					bc->bc_key, &slot);
+	if (status == BLK_STS_OK) {
+		status = __blk_crypto_fallback_decrypt_bio(bio, bc,
+				f_ctx->crypt_iter,
+				blk_crypto_fallback_tfm(slot));
+		blk_crypto_put_keyslot(slot);
+	}
 	mempool_free(f_ctx, bio_fallback_crypt_ctx_pool);
+
+	bio->bi_status = status;
 	bio_endio(bio);
 }
 
@@ -608,7 +586,8 @@ int blk_crypto_fallback_start_using_mode(enum blk_crypto_mode_num mode_num)
 
 	for (i = 0; i < blk_crypto_num_keyslots; i++) {
 		slotp = &blk_crypto_keyslots[i];
-		slotp->tfms[mode_num] = crypto_alloc_skcipher(cipher_str, 0, 0);
+		slotp->tfms[mode_num] = crypto_alloc_sync_skcipher(cipher_str,
+				0, 0);
 		if (IS_ERR(slotp->tfms[mode_num])) {
 			err = PTR_ERR(slotp->tfms[mode_num]);
 			if (err == -ENOENT) {
@@ -620,7 +599,7 @@ int blk_crypto_fallback_start_using_mode(enum blk_crypto_mode_num mode_num)
 			goto out_free_tfms;
 		}
 
-		crypto_skcipher_set_flags(slotp->tfms[mode_num],
+		crypto_sync_skcipher_set_flags(slotp->tfms[mode_num],
 					  CRYPTO_TFM_REQ_FORBID_WEAK_KEYS);
 	}
 
@@ -634,7 +613,7 @@ int blk_crypto_fallback_start_using_mode(enum blk_crypto_mode_num mode_num)
 out_free_tfms:
 	for (i = 0; i < blk_crypto_num_keyslots; i++) {
 		slotp = &blk_crypto_keyslots[i];
-		crypto_free_skcipher(slotp->tfms[mode_num]);
+		crypto_free_sync_skcipher(slotp->tfms[mode_num]);
 		slotp->tfms[mode_num] = NULL;
 	}
 out:
-- 
2.47.3


