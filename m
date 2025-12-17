Return-Path: <linux-fsdevel+bounces-71516-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DA84DCC6264
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 07:10:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF68930341C4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 06:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E5B2D6E75;
	Wed, 17 Dec 2025 06:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DTjt73yn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BDD2D3EC1;
	Wed, 17 Dec 2025 06:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765951700; cv=none; b=aqKfqNJ1XUG2ZodYNxZyDIAA0T18vp8zSSGFNM9Jlmd3RGyvs5xITedHa+tR0ZHtFn0Wo9JIdmnn6WKaMlU1zLHiYjqCO3EbXuqXzpGsif0ZGrC3rubtAg0T5n7kT6swCyZYPyIvSvuejjD7E0nh749iE8VOCxbgcDpBAT+fev8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765951700; c=relaxed/simple;
	bh=ae5anGri52YIzpxB+4QAk3EhtSgJLhhsx5/GipmI5yU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B9cChRp5ABcvrAZMCudG0Zwu7mgG3E0XdEgNXpfIs0ioHcJcMACrtRlouTgDE+8e/5U5HIM8oceZA/Jr4PGCQ4+ytkVF8nA3Ee06mCmaTOFW5+l7ucB0NDiRbdGgO0xUBBd9rHpTQAEAf1llTcYprgGcIm4CSry6asF4IqgIhtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DTjt73yn; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=HhsZbE+8BS35yNic4plLIZmgCAyMt0svF8GrJig9Pos=; b=DTjt73ynhvuPwikiZNFG3cpMKW
	eE51uArrJtMFpowaARHNzXm9qn5E+3Qoa6Uo+RvOY5T6rAPukleu827OMr7a1AEMVukZ1ZFEgteN+
	dFK6KDeDvKgFgi+19rKTXKgNjLGLCPuMgYGRyssoTc/IfZ0VyXl7ULI53oiCk8KgtO8Qk2GsUZWBp
	boqx/WVBhB9uhTCdn9O3+k+RRu/iTPb7d4/Pz/uJBxiT7ti/HsaR5SQoZZ8loWQA98erwIkWfX+cI
	ZdEeM5vzvsLixZzrwLMPb9AWqZVvnLQUDs65ImQc3nlmxUSus8zlabUfv3dk5RFXDmaozuLq0W1WO
	Y8tb1TCA==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVkhs-00000006DFw-3AXM;
	Wed, 17 Dec 2025 06:08:18 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Eric Biggers <ebiggers@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-fscrypt@vger.kernel.org
Subject: [PATCH 8/9] blk-crypto: optimize data unit alignment checking
Date: Wed, 17 Dec 2025 07:06:51 +0100
Message-ID: <20251217060740.923397-9-hch@lst.de>
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

Avoid the relatively high overhead of constructing and walking per-page
segment bio_vecs for data unit alignment checking by merging the checks
into existing loops.

For hardware support crypto, perform the check in bio_split_io_at, which
already contains a similar alignment check applied for all I/O.  This
means bio-based drivers that do not call bio_split_to_limits, should they
ever grow blk-crypto support, need to implement the check themselves,
just like all other queue limits checks.

For blk-crypto-fallback do it in the encryption/decryption loops.  This
means alignment errors for decryption will only be detected after I/O
has completed, but that seems like a worthwhile trade off.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-crypto-fallback.c | 14 ++++++++++++--
 block/blk-crypto.c          | 22 ----------------------
 block/blk-merge.c           |  9 ++++++++-
 3 files changed, 20 insertions(+), 25 deletions(-)

diff --git a/block/blk-crypto-fallback.c b/block/blk-crypto-fallback.c
index 1db4aa4d812a..23e097197450 100644
--- a/block/blk-crypto-fallback.c
+++ b/block/blk-crypto-fallback.c
@@ -274,6 +274,12 @@ static void __blk_crypto_fallback_encrypt_bio(struct bio *src_bio,
 			bio_iter_iovec(src_bio, src_bio->bi_iter);
 		struct page *enc_page = enc_pages[enc_idx];
 
+		if (!IS_ALIGNED(src_bv.bv_len | src_bv.bv_offset,
+				data_unit_size)) {
+			cmpxchg(&src_bio->bi_status, 0, BLK_STS_INVAL);
+			goto out_free_enc_bio;
+		}
+
 		__bio_add_page(enc_bio, enc_page, src_bv.bv_len,
 				src_bv.bv_offset);
 
@@ -284,8 +290,10 @@ static void __blk_crypto_fallback_encrypt_bio(struct bio *src_bio,
 		/* Encrypt each data unit in this page */
 		for (j = 0; j < src_bv.bv_len; j += data_unit_size) {
 			blk_crypto_dun_to_iv(curr_dun, &iv);
-			if (crypto_skcipher_encrypt(ciph_req))
+			if (crypto_skcipher_encrypt(ciph_req)) {
+				cmpxchg(&src_bio->bi_status, 0, BLK_STS_IOERR);
 				goto out_free_enc_bio;
+			}
 			bio_crypt_dun_increment(curr_dun, 1);
 			src.offset += data_unit_size;
 			dst.offset += data_unit_size;
@@ -319,7 +327,6 @@ static void __blk_crypto_fallback_encrypt_bio(struct bio *src_bio,
 		mempool_free(enc_bio->bi_io_vec[enc_idx].bv_page,
 			     blk_crypto_bounce_page_pool);
 	bio_put(enc_bio);
-	cmpxchg(&src_bio->bi_status, 0, BLK_STS_IOERR);
 	bio_endio(src_bio);
 }
 
@@ -373,6 +380,9 @@ static blk_status_t __blk_crypto_fallback_decrypt_bio(struct bio *bio,
 	__bio_for_each_segment(bv, bio, iter, iter) {
 		struct page *page = bv.bv_page;
 
+		if (!IS_ALIGNED(bv.bv_len | bv.bv_offset, data_unit_size))
+			return BLK_STS_INVAL;
+
 		sg_set_page(&sg, page, data_unit_size, bv.bv_offset);
 
 		/* Decrypt each data unit in the segment */
diff --git a/block/blk-crypto.c b/block/blk-crypto.c
index 69e869d1c9bd..0b2535d8dbcc 100644
--- a/block/blk-crypto.c
+++ b/block/blk-crypto.c
@@ -219,22 +219,6 @@ bool bio_crypt_ctx_mergeable(struct bio_crypt_ctx *bc1, unsigned int bc1_bytes,
 	return !bc1 || bio_crypt_dun_is_contiguous(bc1, bc1_bytes, bc2->bc_dun);
 }
 
-/* Check that all I/O segments are data unit aligned. */
-static bool bio_crypt_check_alignment(struct bio *bio)
-{
-	const unsigned int data_unit_size =
-		bio->bi_crypt_context->bc_key->crypto_cfg.data_unit_size;
-	struct bvec_iter iter;
-	struct bio_vec bv;
-
-	bio_for_each_segment(bv, bio, iter) {
-		if (!IS_ALIGNED(bv.bv_len | bv.bv_offset, data_unit_size))
-			return false;
-	}
-
-	return true;
-}
-
 blk_status_t __blk_crypto_rq_get_keyslot(struct request *rq)
 {
 	return blk_crypto_get_keyslot(rq->q->crypto_profile,
@@ -287,12 +271,6 @@ bool __blk_crypto_bio_prep(struct bio *bio)
 		return false;
 	}
 
-	if (!bio_crypt_check_alignment(bio)) {
-		bio->bi_status = BLK_STS_INVAL;
-		bio_endio(bio);
-		return false;
-	}
-
 	/*
 	 * If the device does not natively support the encryption context, try to use
 	 * the fallback if available.
diff --git a/block/blk-merge.c b/block/blk-merge.c
index d3115d7469df..b82c6d304658 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -324,12 +324,19 @@ static inline unsigned int bvec_seg_gap(struct bio_vec *bvprv,
 int bio_split_io_at(struct bio *bio, const struct queue_limits *lim,
 		unsigned *segs, unsigned max_bytes, unsigned len_align_mask)
 {
+	struct bio_crypt_ctx *bc = bio_crypt_ctx(bio);
 	struct bio_vec bv, bvprv, *bvprvp = NULL;
 	unsigned nsegs = 0, bytes = 0, gaps = 0;
 	struct bvec_iter iter;
+	unsigned start_align_mask = lim->dma_alignment;
+
+	if (bc) {
+		start_align_mask |= (bc->bc_key->crypto_cfg.data_unit_size - 1);
+		len_align_mask |= (bc->bc_key->crypto_cfg.data_unit_size - 1);
+	}
 
 	bio_for_each_bvec(bv, bio, iter) {
-		if (bv.bv_offset & lim->dma_alignment ||
+		if (bv.bv_offset & start_align_mask ||
 		    bv.bv_len & len_align_mask)
 			return -EINVAL;
 
-- 
2.47.3


