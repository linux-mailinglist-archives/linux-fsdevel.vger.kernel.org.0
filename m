Return-Path: <linux-fsdevel+bounces-71512-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 87FA5CC624C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 07:09:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9D4003084DB5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 06:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C9E2D6409;
	Wed, 17 Dec 2025 06:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Wil8xJrx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79242D3EF5;
	Wed, 17 Dec 2025 06:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765951682; cv=none; b=LBZ4fHLjiQywJ7/y0TmZAJ1qzsSLKgBYogsOpsPCUcL47bu519BDm4RVbkw5QNcsloT3jP6KbexmP7uYKdO5U7e1TU4/B+ycgh+3SQcPQcDC0uBoQv1/v8TyEgx24wvjZJMaJV2nHglOB9Eict5EuurT09w464tz/rJo/mUOBlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765951682; c=relaxed/simple;
	bh=7GMWDfalQAqsP6aDSVCbSKHiq0RBUDNCK9itAsT+rO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pSs5JFo1jX1LhBaofetALDqrp0LwJmIXOrZYBfgE6aLsRklaC0kckTN7kTZUA1SOqz5cGZK9a/UkAwdfNbiolEsO1HNzJYET5wEkiPgHOvewKomEhxg2frG6Uxn5c7e5K8bBiPptNiDMqGPhhmkJeJEHHsPSCSrT8HSokUOZoKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Wil8xJrx; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=TnEFrSttJFYCIF992tF8Zd6lno2LhvZb3B5OpsB86kg=; b=Wil8xJrxuLzL+oGQMYxM08oXjj
	Y9er+tzvAWKjYiJQVyFHI6Yv5buwOhKerAmb14C+0+WC6piOubwuS9vAi7MncDS+vSiiY/c0UwT+i
	fqIlJl26cLolCx5WA6VncsAI3RwE7OawukZjgfJHze1dl2tuWliLcOjdIT384GcjBY/xewN5bsJZ0
	tbF+gOycHzGq5C4ZkM2pHSnVnNwz5i9f5rKDzTdhwIFbOPI24i4zOsxG6YEkT8Zt+XYNqIhptRJrp
	lQQmHx1yolYwtqiuBhwfmos2cPt9x/yyXKE/UOkuqBIq8TjwqBYcP34AXxEGewmbHOjmGDBQsAlv5
	oPilsldQ==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVkhb-00000006DDn-0NoU;
	Wed, 17 Dec 2025 06:08:00 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Eric Biggers <ebiggers@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-fscrypt@vger.kernel.org
Subject: [PATCH 4/9] blk-crypto: submit the encrypted bio in blk_crypto_fallback_bio_prep
Date: Wed, 17 Dec 2025 07:06:47 +0100
Message-ID: <20251217060740.923397-5-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251217060740.923397-1-hch@lst.de>
References: <20251217060740.923397-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Restructure blk_crypto_fallback_bio_prep so that it always submits the
encrypted bio instead of passing it back to the caller, which allows
to simplify the calling conventions for blk_crypto_fallback_bio_prep and
blk_crypto_bio_prep so that they never have to return a bio, and can
use a true return value to indicate that the caller should submit the
bio, and false that the blk-crypto code consumed it.

The submission is handled by the on-stack bio list in the current
task_struct by the block layer and does not cause additional stack
usage or major overhead.  It also prepares for the following optimization
and fixes for the blk-crypto fallback write path.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c            |  2 +-
 block/blk-crypto-fallback.c | 70 +++++++++++++++++--------------------
 block/blk-crypto-internal.h | 19 ++++------
 block/blk-crypto.c          | 53 ++++++++++++++--------------
 4 files changed, 67 insertions(+), 77 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 8387fe50ea15..f87e5f1a101f 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -628,7 +628,7 @@ static void __submit_bio(struct bio *bio)
 	/* If plug is not used, add new plug here to cache nsecs time. */
 	struct blk_plug plug;
 
-	if (unlikely(!blk_crypto_bio_prep(&bio)))
+	if (unlikely(!blk_crypto_bio_prep(bio)))
 		return;
 
 	blk_start_plug(&plug);
diff --git a/block/blk-crypto-fallback.c b/block/blk-crypto-fallback.c
index 86b27f96051a..cc9e90be23b7 100644
--- a/block/blk-crypto-fallback.c
+++ b/block/blk-crypto-fallback.c
@@ -250,14 +250,14 @@ static void blk_crypto_dun_to_iv(const u64 dun[BLK_CRYPTO_DUN_ARRAY_SIZE],
 
 /*
  * The crypto API fallback's encryption routine.
- * Allocate a bounce bio for encryption, encrypt the input bio using crypto API,
- * and replace *bio_ptr with the bounce bio. May split input bio if it's too
- * large. Returns true on success. Returns false and sets bio->bi_status on
- * error.
+ *
+ * Allocate one or more bios for encryption, encrypt the input bio using the
+ * crypto API, and submit the encrypted bios.  Sets bio->bi_status and
+ * completes the source bio on error
  */
-static bool blk_crypto_fallback_encrypt_bio(struct bio **bio_ptr)
+static void blk_crypto_fallback_encrypt_bio(struct bio *src_bio)
 {
-	struct bio *src_bio, *enc_bio;
+	struct bio *enc_bio;
 	struct bio_crypt_ctx *bc;
 	struct blk_crypto_keyslot *slot;
 	int data_unit_size;
@@ -267,14 +267,12 @@ static bool blk_crypto_fallback_encrypt_bio(struct bio **bio_ptr)
 	struct scatterlist src, dst;
 	union blk_crypto_iv iv;
 	unsigned int i, j;
-	bool ret = false;
 	blk_status_t blk_st;
 
 	/* Split the bio if it's too big for single page bvec */
-	if (!blk_crypto_fallback_split_bio_if_needed(bio_ptr))
-		return false;
+	if (!blk_crypto_fallback_split_bio_if_needed(&src_bio))
+		goto out_endio;
 
-	src_bio = *bio_ptr;
 	bc = src_bio->bi_crypt_context;
 	data_unit_size = bc->bc_key->crypto_cfg.data_unit_size;
 
@@ -282,7 +280,7 @@ static bool blk_crypto_fallback_encrypt_bio(struct bio **bio_ptr)
 	enc_bio = blk_crypto_fallback_clone_bio(src_bio);
 	if (!enc_bio) {
 		src_bio->bi_status = BLK_STS_RESOURCE;
-		return false;
+		goto out_endio;
 	}
 
 	/*
@@ -345,25 +343,23 @@ static bool blk_crypto_fallback_encrypt_bio(struct bio **bio_ptr)
 
 	enc_bio->bi_private = src_bio;
 	enc_bio->bi_end_io = blk_crypto_fallback_encrypt_endio;
-	*bio_ptr = enc_bio;
-	ret = true;
-
-	enc_bio = NULL;
-	goto out_free_ciph_req;
+	skcipher_request_free(ciph_req);
+	blk_crypto_put_keyslot(slot);
+	submit_bio(enc_bio);
+	return;
 
 out_free_bounce_pages:
 	while (i > 0)
 		mempool_free(enc_bio->bi_io_vec[--i].bv_page,
 			     blk_crypto_bounce_page_pool);
-out_free_ciph_req:
 	skcipher_request_free(ciph_req);
 out_release_keyslot:
 	blk_crypto_put_keyslot(slot);
 out_put_enc_bio:
-	if (enc_bio)
-		bio_uninit(enc_bio);
+	bio_uninit(enc_bio);
 	kfree(enc_bio);
-	return ret;
+out_endio:
+	bio_endio(src_bio);
 }
 
 /*
@@ -466,44 +462,44 @@ static void blk_crypto_fallback_decrypt_endio(struct bio *bio)
 
 /**
  * blk_crypto_fallback_bio_prep - Prepare a bio to use fallback en/decryption
+ * @bio: bio to prepare
  *
- * @bio_ptr: pointer to the bio to prepare
- *
- * If bio is doing a WRITE operation, this splits the bio into two parts if it's
- * too big (see blk_crypto_fallback_split_bio_if_needed()). It then allocates a
- * bounce bio for the first part, encrypts it, and updates bio_ptr to point to
- * the bounce bio.
+ * If bio is doing a WRITE operation, allocate one or more bios to contain the
+ * encrypted payload and submit them.
  *
- * For a READ operation, we mark the bio for decryption by using bi_private and
+ * For a READ operation, mark the bio for decryption by using bi_private and
  * bi_end_io.
  *
- * In either case, this function will make the bio look like a regular bio (i.e.
- * as if no encryption context was ever specified) for the purposes of the rest
- * of the stack except for blk-integrity (blk-integrity and blk-crypto are not
- * currently supported together).
+ * In either case, this function will make the submitted bio(s) look like
+ * regular bios (i.e. as if no encryption context was ever specified) for the
+ * purposes of the rest of the stack except for blk-integrity (blk-integrity and
+ * blk-crypto are not currently supported together).
  *
- * Return: true on success. Sets bio->bi_status and returns false on error.
+ * Return: true if @bio should be submitted to the driver by the caller, else
+ * false.  Sets bio->bi_status, calls bio_endio and returns false on error.
  */
-bool blk_crypto_fallback_bio_prep(struct bio **bio_ptr)
+bool blk_crypto_fallback_bio_prep(struct bio *bio)
 {
-	struct bio *bio = *bio_ptr;
 	struct bio_crypt_ctx *bc = bio->bi_crypt_context;
 	struct bio_fallback_crypt_ctx *f_ctx;
 
 	if (WARN_ON_ONCE(!tfms_inited[bc->bc_key->crypto_cfg.crypto_mode])) {
 		/* User didn't call blk_crypto_start_using_key() first */
-		bio->bi_status = BLK_STS_IOERR;
+		bio_io_error(bio);
 		return false;
 	}
 
 	if (!__blk_crypto_cfg_supported(blk_crypto_fallback_profile,
 					&bc->bc_key->crypto_cfg)) {
 		bio->bi_status = BLK_STS_NOTSUPP;
+		bio_endio(bio);
 		return false;
 	}
 
-	if (bio_data_dir(bio) == WRITE)
-		return blk_crypto_fallback_encrypt_bio(bio_ptr);
+	if (bio_data_dir(bio) == WRITE) {
+		blk_crypto_fallback_encrypt_bio(bio);
+		return false;
+	}
 
 	/*
 	 * bio READ case: Set up a f_ctx in the bio's bi_private and set the
diff --git a/block/blk-crypto-internal.h b/block/blk-crypto-internal.h
index ccf6dff6ff6b..d65023120341 100644
--- a/block/blk-crypto-internal.h
+++ b/block/blk-crypto-internal.h
@@ -165,11 +165,11 @@ static inline void bio_crypt_do_front_merge(struct request *rq,
 #endif
 }
 
-bool __blk_crypto_bio_prep(struct bio **bio_ptr);
-static inline bool blk_crypto_bio_prep(struct bio **bio_ptr)
+bool __blk_crypto_bio_prep(struct bio *bio);
+static inline bool blk_crypto_bio_prep(struct bio *bio)
 {
-	if (bio_has_crypt_ctx(*bio_ptr))
-		return __blk_crypto_bio_prep(bio_ptr);
+	if (bio_has_crypt_ctx(bio))
+		return __blk_crypto_bio_prep(bio);
 	return true;
 }
 
@@ -215,12 +215,12 @@ static inline int blk_crypto_rq_bio_prep(struct request *rq, struct bio *bio,
 	return 0;
 }
 
+bool blk_crypto_fallback_bio_prep(struct bio *bio);
+
 #ifdef CONFIG_BLK_INLINE_ENCRYPTION_FALLBACK
 
 int blk_crypto_fallback_start_using_mode(enum blk_crypto_mode_num mode_num);
 
-bool blk_crypto_fallback_bio_prep(struct bio **bio_ptr);
-
 int blk_crypto_fallback_evict_key(const struct blk_crypto_key *key);
 
 #else /* CONFIG_BLK_INLINE_ENCRYPTION_FALLBACK */
@@ -232,13 +232,6 @@ blk_crypto_fallback_start_using_mode(enum blk_crypto_mode_num mode_num)
 	return -ENOPKG;
 }
 
-static inline bool blk_crypto_fallback_bio_prep(struct bio **bio_ptr)
-{
-	pr_warn_once("crypto API fallback disabled; failing request.\n");
-	(*bio_ptr)->bi_status = BLK_STS_NOTSUPP;
-	return false;
-}
-
 static inline int
 blk_crypto_fallback_evict_key(const struct blk_crypto_key *key)
 {
diff --git a/block/blk-crypto.c b/block/blk-crypto.c
index 3e7bf1974cbd..69e869d1c9bd 100644
--- a/block/blk-crypto.c
+++ b/block/blk-crypto.c
@@ -260,54 +260,55 @@ void __blk_crypto_free_request(struct request *rq)
 
 /**
  * __blk_crypto_bio_prep - Prepare bio for inline encryption
- *
- * @bio_ptr: pointer to original bio pointer
+ * @bio: bio to prepare
  *
  * If the bio crypt context provided for the bio is supported by the underlying
  * device's inline encryption hardware, do nothing.
  *
  * Otherwise, try to perform en/decryption for this bio by falling back to the
- * kernel crypto API. When the crypto API fallback is used for encryption,
- * blk-crypto may choose to split the bio into 2 - the first one that will
- * continue to be processed and the second one that will be resubmitted via
- * submit_bio_noacct. A bounce bio will be allocated to encrypt the contents
- * of the aforementioned "first one", and *bio_ptr will be updated to this
- * bounce bio.
+ * kernel crypto API.  For encryption this means submitting newly allocated
+ * bios for the encrypted payload while keeping back the source bio until they
+ * complete, while for reads the decryption happens in-place by a hooked in
+ * completion handler.
  *
  * Caller must ensure bio has bio_crypt_ctx.
  *
- * Return: true on success; false on error (and bio->bi_status will be set
- *	   appropriately, and bio_endio() will have been called so bio
- *	   submission should abort).
+ * Return: true if @bio should be submitted to the driver by the caller, else
+ * false.  Sets bio->bi_status, calls bio_endio and returns false on error.
  */
-bool __blk_crypto_bio_prep(struct bio **bio_ptr)
+bool __blk_crypto_bio_prep(struct bio *bio)
 {
-	struct bio *bio = *bio_ptr;
 	const struct blk_crypto_key *bc_key = bio->bi_crypt_context->bc_key;
+	struct block_device *bdev = bio->bi_bdev;
 
 	/* Error if bio has no data. */
 	if (WARN_ON_ONCE(!bio_has_data(bio))) {
-		bio->bi_status = BLK_STS_IOERR;
-		goto fail;
+		bio_io_error(bio);
+		return false;
 	}
 
 	if (!bio_crypt_check_alignment(bio)) {
 		bio->bi_status = BLK_STS_INVAL;
-		goto fail;
+		bio_endio(bio);
+		return false;
 	}
 
 	/*
-	 * Success if device supports the encryption context, or if we succeeded
-	 * in falling back to the crypto API.
+	 * If the device does not natively support the encryption context, try to use
+	 * the fallback if available.
 	 */
-	if (blk_crypto_config_supported_natively(bio->bi_bdev,
-						 &bc_key->crypto_cfg))
-		return true;
-	if (blk_crypto_fallback_bio_prep(bio_ptr))
-		return true;
-fail:
-	bio_endio(*bio_ptr);
-	return false;
+	if (!blk_crypto_config_supported_natively(bdev, &bc_key->crypto_cfg)) {
+		if (!IS_ENABLED(CONFIG_BLK_INLINE_ENCRYPTION_FALLBACK)) {
+			pr_warn_once("%pg: crypto API fallback disabled; failing request.\n",
+				bdev);
+			bio->bi_status = BLK_STS_NOTSUPP;
+			bio_endio(bio);
+			return false;
+		}
+		return blk_crypto_fallback_bio_prep(bio);
+	}
+
+	return true;
 }
 
 int __blk_crypto_rq_bio_prep(struct request *rq, struct bio *bio,
-- 
2.47.3


