Return-Path: <linux-fsdevel+bounces-72435-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA1F5CF7137
	for <lists+linux-fsdevel@lfdr.de>; Tue, 06 Jan 2026 08:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD97F3095AA4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jan 2026 07:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABEAE30AD1D;
	Tue,  6 Jan 2026 07:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="V9otVQ1l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A9D30ACF1;
	Tue,  6 Jan 2026 07:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767685038; cv=none; b=oIhhQH+KI4ZihE0/Kfbz9QolM1KWScIE36c8GZ6BhlMHe5P7dhKmgnAIsvvTU5Bvm4JUXpB9SiEutV1WO8WHTHPYUHVBIZCc7uUvqfCKeqhhByh58L8ObrUrm4kMtE8pSEFrKvBp6/ZpvQX/V4LR6dJ9LRV0xXAGMBk0NLIPO1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767685038; c=relaxed/simple;
	bh=Puh5nuIAp2imtnU9KH35mf1CI0dDjNrCVUCDTZ2hjW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DnvkQyXTiomwB2mUKwVro9YrIG7DIs6IN012KJCvJoQ7x8a0qfRrtmkcTPW428o0RiCHDR++KvJuqGLVGmKeSUlgaW/SuSlIEEXSpugPvx+xWCioNgDfjSBY2bc86cSkI1+v4LHoLiTzGQzmmI6brrLZZ7Avtt+XaYwjwoUm8V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=V9otVQ1l; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=kfKQTHZY5t9VrcCN6JDoPfHLzf0OU+y0OHLqZeBttwA=; b=V9otVQ1l7VsS3pA0No9NwdKtvb
	TKv0g1s0QOmYNHdeS+OivnBxZWXfQI33u8UrTuPtunwgb01bxZZED5L0f/B/b7q19XH5jNWbikbAW
	utaOl+j7J4GaEXH/QSJ2Kg4f7nE7VMyHhlL1tj3GXjK1OLNJhTcFbII/nkFiDkz6z4tcvBRe9+ATs
	VqpU71bYvkoW35wdDJYMCwCsRlvkSRcHTWkeZMHVrfNUJIl5FmEaPRZlVmRF6aYV4vPRfq/JJeuIV
	8159Mt96LRKYm44LzY9le+AuXQWgQ+/HCqT4Wf77G8d+LVtwkuYfoAgX9tPehUg3sFq/oxGoWoUoS
	ykowWDrA==;
Received: from [213.208.157.59] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vd1cx-0000000CWhe-12h2;
	Tue, 06 Jan 2026 07:37:15 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Eric Biggers <ebiggers@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-fscrypt@vger.kernel.org
Subject: [PATCH 5/9] blk-crypto: optimize bio splitting in blk_crypto_fallback_encrypt_bio
Date: Tue,  6 Jan 2026 08:36:28 +0100
Message-ID: <20260106073651.1607371-6-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260106073651.1607371-1-hch@lst.de>
References: <20260106073651.1607371-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

The current code in blk_crypto_fallback_encrypt_bio is inefficient and
prone to deadlocks under memory pressure: It first walks the passed in
plaintext bio to see how much of it can fit into a single encrypted
bio using up to BIO_MAX_VEC PAGE_SIZE segments, and then allocates a
plaintext clone that fits the size, only to allocate another bio for
the ciphertext later.  While the plaintext clone uses a bioset to avoid
deadlocks when allocations could fail, the ciphertex one uses bio_kmalloc
which is a no-go in the file system I/O path.

Switch blk_crypto_fallback_encrypt_bio to walk the source plaintext bio
while consuming bi_iter without cloning it, and instead allocate a
ciphertext bio at the beginning and whenever we fille up the previous
one.  The existing bio_set for the plaintext clones is reused for the
ciphertext bios to remove the deadlock risk.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Eric Biggers <ebiggers@kernel.org>
---
 block/blk-crypto-fallback.c | 189 +++++++++++++++---------------------
 1 file changed, 80 insertions(+), 109 deletions(-)

diff --git a/block/blk-crypto-fallback.c b/block/blk-crypto-fallback.c
index cc9e90be23b7..4ec7da342280 100644
--- a/block/blk-crypto-fallback.c
+++ b/block/blk-crypto-fallback.c
@@ -81,7 +81,7 @@ static struct blk_crypto_fallback_keyslot {
 static struct blk_crypto_profile *blk_crypto_fallback_profile;
 static struct workqueue_struct *blk_crypto_wq;
 static mempool_t *blk_crypto_bounce_page_pool;
-static struct bio_set crypto_bio_split;
+static struct bio_set enc_bio_set;
 
 /*
  * This is the key we set when evicting a keyslot. This *should* be the all 0's
@@ -150,37 +150,29 @@ static void blk_crypto_fallback_encrypt_endio(struct bio *enc_bio)
 		mempool_free(enc_bio->bi_io_vec[i].bv_page,
 			     blk_crypto_bounce_page_pool);
 
-	src_bio->bi_status = enc_bio->bi_status;
+	if (enc_bio->bi_status)
+		cmpxchg(&src_bio->bi_status, 0, enc_bio->bi_status);
 
-	bio_uninit(enc_bio);
-	kfree(enc_bio);
+	bio_put(enc_bio);
 	bio_endio(src_bio);
 }
 
-static struct bio *blk_crypto_fallback_clone_bio(struct bio *bio_src)
+static struct bio *blk_crypto_alloc_enc_bio(struct bio *bio_src,
+		unsigned int nr_segs)
 {
-	unsigned int nr_segs = bio_segments(bio_src);
-	struct bvec_iter iter;
-	struct bio_vec bv;
 	struct bio *bio;
 
-	bio = bio_kmalloc(nr_segs, GFP_NOIO);
-	if (!bio)
-		return NULL;
-	bio_init_inline(bio, bio_src->bi_bdev, nr_segs, bio_src->bi_opf);
+	bio = bio_alloc_bioset(bio_src->bi_bdev, nr_segs, bio_src->bi_opf,
+			GFP_NOIO, &enc_bio_set);
 	if (bio_flagged(bio_src, BIO_REMAPPED))
 		bio_set_flag(bio, BIO_REMAPPED);
+	bio->bi_private		= bio_src;
+	bio->bi_end_io		= blk_crypto_fallback_encrypt_endio;
 	bio->bi_ioprio		= bio_src->bi_ioprio;
 	bio->bi_write_hint	= bio_src->bi_write_hint;
 	bio->bi_write_stream	= bio_src->bi_write_stream;
 	bio->bi_iter.bi_sector	= bio_src->bi_iter.bi_sector;
-	bio->bi_iter.bi_size	= bio_src->bi_iter.bi_size;
-
-	bio_for_each_segment(bv, bio_src, iter)
-		bio->bi_io_vec[bio->bi_vcnt++] = bv;
-
 	bio_clone_blkg_association(bio, bio_src);
-
 	return bio;
 }
 
@@ -208,32 +200,6 @@ blk_crypto_fallback_alloc_cipher_req(struct blk_crypto_keyslot *slot,
 	return true;
 }
 
-static bool blk_crypto_fallback_split_bio_if_needed(struct bio **bio_ptr)
-{
-	struct bio *bio = *bio_ptr;
-	unsigned int i = 0;
-	unsigned int num_sectors = 0;
-	struct bio_vec bv;
-	struct bvec_iter iter;
-
-	bio_for_each_segment(bv, bio, iter) {
-		num_sectors += bv.bv_len >> SECTOR_SHIFT;
-		if (++i == BIO_MAX_VECS)
-			break;
-	}
-
-	if (num_sectors < bio_sectors(bio)) {
-		bio = bio_submit_split_bioset(bio, num_sectors,
-					      &crypto_bio_split);
-		if (!bio)
-			return false;
-
-		*bio_ptr = bio;
-	}
-
-	return true;
-}
-
 union blk_crypto_iv {
 	__le64 dun[BLK_CRYPTO_DUN_ARRAY_SIZE];
 	u8 bytes[BLK_CRYPTO_MAX_IV_SIZE];
@@ -257,46 +223,35 @@ static void blk_crypto_dun_to_iv(const u64 dun[BLK_CRYPTO_DUN_ARRAY_SIZE],
  */
 static void blk_crypto_fallback_encrypt_bio(struct bio *src_bio)
 {
-	struct bio *enc_bio;
-	struct bio_crypt_ctx *bc;
-	struct blk_crypto_keyslot *slot;
-	int data_unit_size;
+	struct bio_crypt_ctx *bc = src_bio->bi_crypt_context;
+	int data_unit_size = bc->bc_key->crypto_cfg.data_unit_size;
 	struct skcipher_request *ciph_req = NULL;
+	struct blk_crypto_keyslot *slot;
 	DECLARE_CRYPTO_WAIT(wait);
 	u64 curr_dun[BLK_CRYPTO_DUN_ARRAY_SIZE];
 	struct scatterlist src, dst;
 	union blk_crypto_iv iv;
-	unsigned int i, j;
-	blk_status_t blk_st;
-
-	/* Split the bio if it's too big for single page bvec */
-	if (!blk_crypto_fallback_split_bio_if_needed(&src_bio))
-		goto out_endio;
-
-	bc = src_bio->bi_crypt_context;
-	data_unit_size = bc->bc_key->crypto_cfg.data_unit_size;
-
-	/* Allocate bounce bio for encryption */
-	enc_bio = blk_crypto_fallback_clone_bio(src_bio);
-	if (!enc_bio) {
-		src_bio->bi_status = BLK_STS_RESOURCE;
-		goto out_endio;
-	}
+	unsigned int nr_enc_pages, enc_idx;
+	struct bio *enc_bio;
+	blk_status_t status;
+	unsigned int i;
 
 	/*
 	 * Get a blk-crypto-fallback keyslot that contains a crypto_skcipher for
 	 * this bio's algorithm and key.
 	 */
-	blk_st = blk_crypto_get_keyslot(blk_crypto_fallback_profile,
+	status = blk_crypto_get_keyslot(blk_crypto_fallback_profile,
 					bc->bc_key, &slot);
-	if (blk_st != BLK_STS_OK) {
-		src_bio->bi_status = blk_st;
-		goto out_put_enc_bio;
+	if (status != BLK_STS_OK) {
+		src_bio->bi_status = status;
+		bio_endio(src_bio);
+		return;
 	}
 
 	/* and then allocate an skcipher_request for it */
 	if (!blk_crypto_fallback_alloc_cipher_req(slot, &ciph_req, &wait)) {
 		src_bio->bi_status = BLK_STS_RESOURCE;
+		bio_endio(src_bio);
 		goto out_release_keyslot;
 	}
 
@@ -307,59 +262,75 @@ static void blk_crypto_fallback_encrypt_bio(struct bio *src_bio)
 	skcipher_request_set_crypt(ciph_req, &src, &dst, data_unit_size,
 				   iv.bytes);
 
-	/* Encrypt each page in the bounce bio */
-	for (i = 0; i < enc_bio->bi_vcnt; i++) {
-		struct bio_vec *enc_bvec = &enc_bio->bi_io_vec[i];
-		struct page *plaintext_page = enc_bvec->bv_page;
-		struct page *ciphertext_page =
-			mempool_alloc(blk_crypto_bounce_page_pool, GFP_NOIO);
-
-		enc_bvec->bv_page = ciphertext_page;
-
-		if (!ciphertext_page) {
-			src_bio->bi_status = BLK_STS_RESOURCE;
-			goto out_free_bounce_pages;
-		}
-
-		sg_set_page(&src, plaintext_page, data_unit_size,
-			    enc_bvec->bv_offset);
-		sg_set_page(&dst, ciphertext_page, data_unit_size,
-			    enc_bvec->bv_offset);
-
-		/* Encrypt each data unit in this page */
-		for (j = 0; j < enc_bvec->bv_len; j += data_unit_size) {
+	/*
+	 * Encrypt each page in the source bio.  Because the source bio could
+	 * have bio_vecs that span more than a single page, but the encrypted
+	 * bios are limited to a single page per bio_vec, this can generate
+	 * more than a single encrypted bio per source bio.
+	 */
+new_bio:
+	nr_enc_pages = min(bio_segments(src_bio), BIO_MAX_VECS);
+	enc_bio = blk_crypto_alloc_enc_bio(src_bio, nr_enc_pages);
+	enc_idx = 0;
+	for (;;) {
+		struct bio_vec src_bv =
+			bio_iter_iovec(src_bio, src_bio->bi_iter);
+		struct page *enc_page;
+
+		enc_page = mempool_alloc(blk_crypto_bounce_page_pool,
+				GFP_NOIO);
+		__bio_add_page(enc_bio, enc_page, src_bv.bv_len,
+				src_bv.bv_offset);
+
+		sg_set_page(&src, src_bv.bv_page, data_unit_size,
+			    src_bv.bv_offset);
+		sg_set_page(&dst, enc_page, data_unit_size, src_bv.bv_offset);
+
+		/*
+		 * Increment the index now that the encrypted page is added to
+		 * the bio.  This is important for the error unwind path.
+		 */
+		enc_idx++;
+
+		/*
+		 * Encrypt each data unit in this page.
+		 */
+		for (i = 0; i < src_bv.bv_len; i += data_unit_size) {
 			blk_crypto_dun_to_iv(curr_dun, &iv);
 			if (crypto_wait_req(crypto_skcipher_encrypt(ciph_req),
 					    &wait)) {
-				i++;
-				src_bio->bi_status = BLK_STS_IOERR;
-				goto out_free_bounce_pages;
+				bio_io_error(enc_bio);
+				goto out_free_request;
 			}
 			bio_crypt_dun_increment(curr_dun, 1);
 			src.offset += data_unit_size;
 			dst.offset += data_unit_size;
 		}
+
+		bio_advance_iter_single(src_bio, &src_bio->bi_iter,
+				src_bv.bv_len);
+		if (!src_bio->bi_iter.bi_size)
+			break;
+
+		if (enc_idx == nr_enc_pages) {
+			/*
+			 * For each additional encrypted bio submitted,
+			 * increment the source bio's remaining count.  Each
+			 * encrypted bio's completion handler calls bio_endio on
+			 * the source bio, so this keeps the source bio from
+			 * completing until the last encrypted bio does.
+			 */
+			bio_inc_remaining(src_bio);
+			submit_bio(enc_bio);
+			goto new_bio;
+		}
 	}
 
-	enc_bio->bi_private = src_bio;
-	enc_bio->bi_end_io = blk_crypto_fallback_encrypt_endio;
-	skcipher_request_free(ciph_req);
-	blk_crypto_put_keyslot(slot);
 	submit_bio(enc_bio);
-	return;
-
-out_free_bounce_pages:
-	while (i > 0)
-		mempool_free(enc_bio->bi_io_vec[--i].bv_page,
-			     blk_crypto_bounce_page_pool);
+out_free_request:
 	skcipher_request_free(ciph_req);
 out_release_keyslot:
 	blk_crypto_put_keyslot(slot);
-out_put_enc_bio:
-	bio_uninit(enc_bio);
-	kfree(enc_bio);
-out_endio:
-	bio_endio(src_bio);
 }
 
 /*
@@ -533,7 +504,7 @@ static int blk_crypto_fallback_init(void)
 
 	get_random_bytes(blank_key, sizeof(blank_key));
 
-	err = bioset_init(&crypto_bio_split, 64, 0, 0);
+	err = bioset_init(&enc_bio_set, 64, 0, BIOSET_NEED_BVECS);
 	if (err)
 		goto out;
 
@@ -603,7 +574,7 @@ static int blk_crypto_fallback_init(void)
 fail_free_profile:
 	kfree(blk_crypto_fallback_profile);
 fail_free_bioset:
-	bioset_exit(&crypto_bio_split);
+	bioset_exit(&enc_bio_set);
 out:
 	return err;
 }
-- 
2.47.3


