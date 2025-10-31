Return-Path: <linux-fsdevel+bounces-66570-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A2EC24372
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 10:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DDE23A60BF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 09:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5308332E6B8;
	Fri, 31 Oct 2025 09:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Bteif0mR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FDD2D9797;
	Fri, 31 Oct 2025 09:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761903356; cv=none; b=T2nx7aCzpLkKnXTKEuMwvv9Gz5O726ZFdS08YG/gcMlYWTzQTjTMwQPTEz7l2slI2VCBugCwSq2GEcUHoAxWlN6iDMboex7ii/p9iJ6TsE+t+iwLIb10X7Pb/2JI7MhurpaPuBzEJoHtLDkrxnI9kMIwSGW3yNBHnTqUAty4ZPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761903356; c=relaxed/simple;
	bh=Ch8dnRvIPiOumk4fubF1bzEeJTaSOPFH1JLOkzI+eu8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NoQV9R4m87Vz4vKE4HMavX8bPBPwNn1eNtM51hojOH8T6Vg4OkbpYl6z7foSMx1/fZPpn9MchfknhqeiTCic1dJFx9xNaIV7xepBcHDrYpMGRScgzaY9GyQaXh2rPfcWnzojcY/7QRXOepyMnafDL9bQ6HTDao5qEs6ogZuJ+CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Bteif0mR; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=gz1ZHnV8MPEOv0SwBRPIHVFkDVJvCNG/ND6yLhSPhtA=; b=Bteif0mR4s8h/WLphDjB4FnnRa
	xMbZsylDUJHp4lv94cx6I9VZU5TTU/iWLAzzKakTc0Z/f87IIU7PtPegAXa+BbRRg6ygx9umE9zL0
	GqjwckW9hC4yBBTY25LUhEA18fYoiGyqrmEtEA0/XUrEGisNeLpU+7j6FqSnI9GgUJ0eHig4eIZqo
	yJgXMttc+E056wFOHElCBIDt6HlGThnfVWg6Dh53azJX0rqU3yH590/ADIL+whfP2FXie4b3Vv8Wf
	sCVf72qObjvoXlORWjgN8n8RPp9OGliqR/FvObUMRSegl3eCfVzqD+9909fGcxrbKwacGLQoT6UUx
	Uz48B2Xg==;
Received: from [2001:4bb8:2dc:1001:a959:25cf:98e9:329b] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vElY0-00000005orm-1z1q;
	Fri, 31 Oct 2025 09:35:52 +0000
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
Subject: [PATCH 6/9] blk-crypto: optimize bio splitting in blk_crypto_fallback_encrypt_bio
Date: Fri, 31 Oct 2025 10:34:36 +0100
Message-ID: <20251031093517.1603379-7-hch@lst.de>
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

The current code in blk_crypto_fallback_encrypt_bio is inefficient and
prone to deadlocks under memory pressure: It first walks to pass in
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
---
 block/blk-crypto-fallback.c | 162 ++++++++++++++----------------------
 1 file changed, 63 insertions(+), 99 deletions(-)

diff --git a/block/blk-crypto-fallback.c b/block/blk-crypto-fallback.c
index 86b27f96051a..1f58010fb437 100644
--- a/block/blk-crypto-fallback.c
+++ b/block/blk-crypto-fallback.c
@@ -152,35 +152,26 @@ static void blk_crypto_fallback_encrypt_endio(struct bio *enc_bio)
 
 	src_bio->bi_status = enc_bio->bi_status;
 
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
+			GFP_NOIO, &crypto_bio_split);
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
 
@@ -208,32 +199,6 @@ blk_crypto_fallback_alloc_cipher_req(struct blk_crypto_keyslot *slot,
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
@@ -257,34 +222,22 @@ static void blk_crypto_dun_to_iv(const u64 dun[BLK_CRYPTO_DUN_ARRAY_SIZE],
  */
 static bool blk_crypto_fallback_encrypt_bio(struct bio **bio_ptr)
 {
-	struct bio *src_bio, *enc_bio;
-	struct bio_crypt_ctx *bc;
-	struct blk_crypto_keyslot *slot;
-	int data_unit_size;
+	struct bio *src_bio = *bio_ptr;
+	struct bio_crypt_ctx *bc = src_bio->bi_crypt_context;
+	int data_unit_size = bc->bc_key->crypto_cfg.data_unit_size;
 	struct skcipher_request *ciph_req = NULL;
+	struct blk_crypto_keyslot *slot;
 	DECLARE_CRYPTO_WAIT(wait);
 	u64 curr_dun[BLK_CRYPTO_DUN_ARRAY_SIZE];
 	struct scatterlist src, dst;
 	union blk_crypto_iv iv;
-	unsigned int i, j;
+	struct bio *enc_bio = NULL;
+	unsigned int nr_segs;
+	unsigned int enc_idx = 0;
+	unsigned int j;
 	bool ret = false;
 	blk_status_t blk_st;
 
-	/* Split the bio if it's too big for single page bvec */
-	if (!blk_crypto_fallback_split_bio_if_needed(bio_ptr))
-		return false;
-
-	src_bio = *bio_ptr;
-	bc = src_bio->bi_crypt_context;
-	data_unit_size = bc->bc_key->crypto_cfg.data_unit_size;
-
-	/* Allocate bounce bio for encryption */
-	enc_bio = blk_crypto_fallback_clone_bio(src_bio);
-	if (!enc_bio) {
-		src_bio->bi_status = BLK_STS_RESOURCE;
-		return false;
-	}
-
 	/*
 	 * Get a blk-crypto-fallback keyslot that contains a crypto_skcipher for
 	 * this bio's algorithm and key.
@@ -293,7 +246,7 @@ static bool blk_crypto_fallback_encrypt_bio(struct bio **bio_ptr)
 					bc->bc_key, &slot);
 	if (blk_st != BLK_STS_OK) {
 		src_bio->bi_status = blk_st;
-		goto out_put_enc_bio;
+		return false;
 	}
 
 	/* and then allocate an skcipher_request for it */
@@ -309,61 +262,72 @@ static bool blk_crypto_fallback_encrypt_bio(struct bio **bio_ptr)
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
+	/* Encrypt each page in the origin bio */
+	nr_segs = bio_segments(src_bio);
+	for (;;) {
+		struct bio_vec src_bv =
+			bio_iter_iovec(src_bio, src_bio->bi_iter);
+		struct page *enc_page;
 
-		if (!ciphertext_page) {
-			src_bio->bi_status = BLK_STS_RESOURCE;
-			goto out_free_bounce_pages;
+		if (!enc_bio) {
+			enc_bio = blk_crypto_alloc_enc_bio(src_bio,
+					min(nr_segs, BIO_MAX_VECS));
 		}
 
-		sg_set_page(&src, plaintext_page, data_unit_size,
-			    enc_bvec->bv_offset);
-		sg_set_page(&dst, ciphertext_page, data_unit_size,
-			    enc_bvec->bv_offset);
+		enc_page = mempool_alloc(blk_crypto_bounce_page_pool,
+				GFP_NOIO);
+		__bio_add_page(enc_bio, enc_page, src_bv.bv_len,
+				src_bv.bv_offset);
+
+		sg_set_page(&src, src_bv.bv_page, data_unit_size,
+			    src_bv.bv_offset);
+		sg_set_page(&dst, enc_page, data_unit_size, src_bv.bv_offset);
 
 		/* Encrypt each data unit in this page */
-		for (j = 0; j < enc_bvec->bv_len; j += data_unit_size) {
+		for (j = 0; j < src_bv.bv_len; j += data_unit_size) {
 			blk_crypto_dun_to_iv(curr_dun, &iv);
 			if (crypto_wait_req(crypto_skcipher_encrypt(ciph_req),
-					    &wait)) {
-				i++;
-				src_bio->bi_status = BLK_STS_IOERR;
-				goto out_free_bounce_pages;
-			}
+					    &wait))
+				goto out_ioerror;
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
+		if (++enc_idx == enc_bio->bi_max_vecs) {
+			/*
+			 * Each encrypted bio will call bio_endio in the
+			 * completion handler, so ensure the remaining count
+			 * matches the number of submitted bios.
+			 */
+			bio_inc_remaining(src_bio);
+			submit_bio(enc_bio);
+			enc_bio = NULL;
+			enc_idx = 0;
+		}
+		nr_segs--;
 	}
 
-	enc_bio->bi_private = src_bio;
-	enc_bio->bi_end_io = blk_crypto_fallback_encrypt_endio;
 	*bio_ptr = enc_bio;
 	ret = true;
-
-	enc_bio = NULL;
-	goto out_free_ciph_req;
-
-out_free_bounce_pages:
-	while (i > 0)
-		mempool_free(enc_bio->bi_io_vec[--i].bv_page,
-			     blk_crypto_bounce_page_pool);
 out_free_ciph_req:
 	skcipher_request_free(ciph_req);
 out_release_keyslot:
 	blk_crypto_put_keyslot(slot);
-out_put_enc_bio:
-	if (enc_bio)
-		bio_uninit(enc_bio);
-	kfree(enc_bio);
 	return ret;
+
+out_ioerror:
+	while (enc_idx > 0)
+		mempool_free(enc_bio->bi_io_vec[enc_idx--].bv_page,
+			     blk_crypto_bounce_page_pool);
+	bio_put(enc_bio);
+	src_bio->bi_status = BLK_STS_IOERR;
+	goto out_free_ciph_req;
 }
 
 /*
@@ -537,7 +501,7 @@ static int blk_crypto_fallback_init(void)
 
 	get_random_bytes(blank_key, sizeof(blank_key));
 
-	err = bioset_init(&crypto_bio_split, 64, 0, 0);
+	err = bioset_init(&crypto_bio_split, 64, 0, BIOSET_NEED_BVECS);
 	if (err)
 		goto out;
 
-- 
2.47.3


