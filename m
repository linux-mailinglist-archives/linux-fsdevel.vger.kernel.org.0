Return-Path: <linux-fsdevel+bounces-66572-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 249ABC24332
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 10:37:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5EB204F06A8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 09:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020ED32ED41;
	Fri, 31 Oct 2025 09:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="yWkOZnV2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E7931B116;
	Fri, 31 Oct 2025 09:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761903369; cv=none; b=DRzBoWrzbpn+OTLqPDTDPZoDTbGlz9jm/4EbbiMbST8EkgQH0FHeyuADVAMYHyk4GytCiovREs5l1UnKi1YKAVQ+QayExnotmCxzQs6j8CV9TM2b+H2YY7zsPld2vYTtCxrd2rCKRfWv2UzUmdCVEtXZD9q+ZAbbn4x2wekASjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761903369; c=relaxed/simple;
	bh=QcenhZDtwQOzKw6Qnq/2+m7sv1jcEsW3eMJNr9ilQVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bJ1OR+B8j49peAq2gBer1M9ChXzqc1WCUKUS1MFOAev/aIakMSMPOsj4PfEggJ9LKWjyn832G7wygTlv0M23t3fBjf9BobojoXada/r3VS7I4y5NzRitLBkeqFqgzu+DVmh0eiafsr8x9Gre14pJcKuLBAR5EHcNnLh8cRcEBKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=yWkOZnV2; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=qmGTgW6afJ0vFRkby/75JyZyQGwop0nHFOHEgGPVxKU=; b=yWkOZnV2bEuSbAIehLiPLmhkPK
	GjNEKIFCvxWDjwumscvvswqQFBSHuG5QTDS7dNM8H37vxG2W2S3GOYOAxdyqNM9/bPaHYw0Huq6yo
	mJFyCL4Fq50xFDidQL3pkWcd2FCV5kOxyoMCof/wFBHEM8VHc3oja7T0M6JtQBd1t03HFFStlINXN
	SUK9D+WtRKnpPoCgEmL2LivCVml+I4o39InWHigt81MM/gXoC5yUs97sHc8JgwuxMIXGIi44m8tF1
	MFsvruFP6eykpn4bd+ggguWwJjYCnGM9/pacIEDnSstwJRSlQGKxNwPVQwjofxAbvUGAMj++u73VI
	eS1CZN1g==;
Received: from [2001:4bb8:2dc:1001:a959:25cf:98e9:329b] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vElYA-00000005otI-3gOH;
	Fri, 31 Oct 2025 09:36:03 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Eric Biggers <ebiggers@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-fscrypt@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 8/9] blk-crypto: use on-stack skciphers for fallback en/decryption
Date: Fri, 31 Oct 2025 10:34:38 +0100
Message-ID: <20251031093517.1603379-9-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251031093517.1603379-1-hch@lst.de>
References: <20251031093517.1603379-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Allocating a skcipher dynamically can deadlock or cause unexpected
I/O failures when called from writeback context.  Sidestep the
allocation by using on-stack skciphers, similar to what the non
blk-crypto fscrypt already does.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-crypto-fallback.c | 170 +++++++++++++++++-------------------
 1 file changed, 78 insertions(+), 92 deletions(-)

diff --git a/block/blk-crypto-fallback.c b/block/blk-crypto-fallback.c
index 16a1809e2667..33aa7b26ed37 100644
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
@@ -195,28 +195,13 @@ static struct bio *blk_crypto_alloc_enc_bio(struct bio *bio_src,
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
@@ -238,12 +223,12 @@ static void blk_crypto_dun_to_iv(const u64 dun[BLK_CRYPTO_DUN_ARRAY_SIZE],
  * encryption, encrypts the input bio using crypto API and submits the bounce
  * bio.
  */
-void blk_crypto_fallback_encrypt_bio(struct bio *src_bio)
+static blk_status_t __blk_crypto_fallback_encrypt_bio(struct bio *src_bio,
+		struct crypto_sync_skcipher *tfm)
 {
 	struct bio_crypt_ctx *bc = src_bio->bi_crypt_context;
 	int data_unit_size = bc->bc_key->crypto_cfg.data_unit_size;
-	struct skcipher_request *ciph_req = NULL;
-	struct blk_crypto_keyslot *slot;
+	SYNC_SKCIPHER_REQUEST_ON_STACK(ciph_req, tfm);
 	DECLARE_CRYPTO_WAIT(wait);
 	u64 curr_dun[BLK_CRYPTO_DUN_ARRAY_SIZE];
 	struct scatterlist src, dst;
@@ -252,27 +237,11 @@ void blk_crypto_fallback_encrypt_bio(struct bio *src_bio)
 	unsigned int nr_segs;
 	unsigned int enc_idx = 0;
 	unsigned int j;
-	blk_status_t blk_st;
 
-	if (!blk_crypto_fallback_bio_valid(src_bio))
-		return;
-
-	/*
-	 * Get a blk-crypto-fallback keyslot that contains a crypto_skcipher for
-	 * this bio's algorithm and key.
-	 */
-	blk_st = blk_crypto_get_keyslot(blk_crypto_fallback_profile,
-					bc->bc_key, &slot);
-	if (blk_st != BLK_STS_OK) {
-		src_bio->bi_status = blk_st;
-		goto endio;
-	}
-
-	/* and then allocate an skcipher_request for it */
-	if (!blk_crypto_fallback_alloc_cipher_req(slot, &ciph_req, &wait)) {
-		src_bio->bi_status = BLK_STS_RESOURCE;
-		goto out_release_keyslot;
-	}
+	skcipher_request_set_callback(ciph_req,
+				      CRYPTO_TFM_REQ_MAY_BACKLOG |
+				      CRYPTO_TFM_REQ_MAY_SLEEP,
+				      crypto_req_done, &wait);
 
 	memcpy(curr_dun, bc->bc_dun, sizeof(curr_dun));
 	sg_init_table(&src, 1);
@@ -332,62 +301,61 @@ void blk_crypto_fallback_encrypt_bio(struct bio *src_bio)
 		nr_segs--;
 	}
 
-	skcipher_request_free(ciph_req);
-	blk_crypto_put_keyslot(slot);
 	submit_bio(enc_bio);
-	return;
+	return BLK_STS_OK;
 
 out_ioerror:
 	while (enc_idx > 0)
 		mempool_free(enc_bio->bi_io_vec[enc_idx--].bv_page,
 			     blk_crypto_bounce_page_pool);
 	bio_put(enc_bio);
-	src_bio->bi_status = BLK_STS_IOERR;
-	skcipher_request_free(ciph_req);
-out_release_keyslot:
-	blk_crypto_put_keyslot(slot);
-endio:
-	bio_endio(src_bio);
+	return BLK_STS_IOERR;
+}
+
+void blk_crypto_fallback_encrypt_bio(struct bio *src_bio)
+{
+	struct bio_crypt_ctx *bc = src_bio->bi_crypt_context;
+	struct blk_crypto_keyslot *slot;
+	blk_status_t status;
+
+	if (!blk_crypto_fallback_bio_valid(src_bio))
+		return;
+
+	status = blk_crypto_get_keyslot(blk_crypto_fallback_profile,
+					bc->bc_key, &slot);
+	if (status == BLK_STS_OK) {
+		status = __blk_crypto_fallback_encrypt_bio(src_bio,
+			blk_crypto_fallback_tfm(slot));
+		blk_crypto_put_keyslot(slot);
+	}
+	if (status != BLK_STS_OK) {
+		src_bio->bi_status = status;
+		bio_endio(src_bio);
+		return;
+	}
 }
 
 /*
  * The crypto API fallback's main decryption routine.
  * Decrypts input bio in place, and calls bio_endio on the bio.
  */
-static void blk_crypto_fallback_decrypt_bio(struct work_struct *work)
+static blk_status_t __blk_crypto_fallback_decrypt_bio(struct bio *bio,
+		struct bio_crypt_ctx *bc, struct bvec_iter iter,
+		struct crypto_sync_skcipher *tfm)
 {
-	struct bio_fallback_crypt_ctx *f_ctx =
-		container_of(work, struct bio_fallback_crypt_ctx, work);
-	struct bio *bio = f_ctx->bio;
-	struct bio_crypt_ctx *bc = &f_ctx->crypt_ctx;
-	struct blk_crypto_keyslot *slot;
-	struct skcipher_request *ciph_req = NULL;
+	SYNC_SKCIPHER_REQUEST_ON_STACK(ciph_req, tfm);
 	DECLARE_CRYPTO_WAIT(wait);
 	u64 curr_dun[BLK_CRYPTO_DUN_ARRAY_SIZE];
 	union blk_crypto_iv iv;
 	struct scatterlist sg;
 	struct bio_vec bv;
-	struct bvec_iter iter;
 	const int data_unit_size = bc->bc_key->crypto_cfg.data_unit_size;
 	unsigned int i;
-	blk_status_t blk_st;
 
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
-
-	/* and then allocate an skcipher_request for it */
-	if (!blk_crypto_fallback_alloc_cipher_req(slot, &ciph_req, &wait)) {
-		bio->bi_status = BLK_STS_RESOURCE;
-		goto out;
-	}
+	skcipher_request_set_callback(ciph_req,
+				      CRYPTO_TFM_REQ_MAY_BACKLOG |
+				      CRYPTO_TFM_REQ_MAY_SLEEP,
+				      crypto_req_done, &wait);
 
 	memcpy(curr_dun, bc->bc_dun, sizeof(curr_dun));
 	sg_init_table(&sg, 1);
@@ -395,7 +363,7 @@ static void blk_crypto_fallback_decrypt_bio(struct work_struct *work)
 				   iv.bytes);
 
 	/* Decrypt each segment in the bio */
-	__bio_for_each_segment(bv, bio, iter, f_ctx->crypt_iter) {
+	__bio_for_each_segment(bv, bio, iter, iter) {
 		struct page *page = bv.bv_page;
 
 		sg_set_page(&sg, page, data_unit_size, bv.bv_offset);
@@ -404,19 +372,36 @@ static void blk_crypto_fallback_decrypt_bio(struct work_struct *work)
 		for (i = 0; i < bv.bv_len; i += data_unit_size) {
 			blk_crypto_dun_to_iv(curr_dun, &iv);
 			if (crypto_wait_req(crypto_skcipher_decrypt(ciph_req),
-					    &wait)) {
-				bio->bi_status = BLK_STS_IOERR;
-				goto out;
-			}
+					    &wait))
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
+		status = __blk_crypto_fallback_decrypt_bio(f_ctx->bio,
+				&f_ctx->crypt_ctx, f_ctx->crypt_iter,
+				blk_crypto_fallback_tfm(slot));
+		blk_crypto_put_keyslot(slot);
+	}
+
+	if (status != BLK_STS_OK)
+		bio->bi_status = status;
 	mempool_free(f_ctx, bio_fallback_crypt_ctx_pool);
 	bio_endio(bio);
 }
@@ -590,7 +575,8 @@ int blk_crypto_fallback_start_using_mode(enum blk_crypto_mode_num mode_num)
 
 	for (i = 0; i < blk_crypto_num_keyslots; i++) {
 		slotp = &blk_crypto_keyslots[i];
-		slotp->tfms[mode_num] = crypto_alloc_skcipher(cipher_str, 0, 0);
+		slotp->tfms[mode_num] = crypto_alloc_sync_skcipher(cipher_str,
+				0, 0);
 		if (IS_ERR(slotp->tfms[mode_num])) {
 			err = PTR_ERR(slotp->tfms[mode_num]);
 			if (err == -ENOENT) {
@@ -602,7 +588,7 @@ int blk_crypto_fallback_start_using_mode(enum blk_crypto_mode_num mode_num)
 			goto out_free_tfms;
 		}
 
-		crypto_skcipher_set_flags(slotp->tfms[mode_num],
+		crypto_sync_skcipher_set_flags(slotp->tfms[mode_num],
 					  CRYPTO_TFM_REQ_FORBID_WEAK_KEYS);
 	}
 
@@ -616,7 +602,7 @@ int blk_crypto_fallback_start_using_mode(enum blk_crypto_mode_num mode_num)
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


