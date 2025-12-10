Return-Path: <linux-fsdevel+bounces-71064-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 70AA5CB3507
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Dec 2025 16:28:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB0A3315A355
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Dec 2025 15:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB9C318151;
	Wed, 10 Dec 2025 15:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dW0nVlDt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DD530506C;
	Wed, 10 Dec 2025 15:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765380258; cv=none; b=gmShUDwerFtoZPSJiVHugzL6yZVwoVGY+mTqch46AUvtxsCg/xZkQoFxTFlaf+h5a8Sc31K/T1/CMoabuNLqHETwZv6MNz2NMhm6LHIXVqDKtdQjzitbsWEta95NvbgGdbVUIhHrUWEgu/21siKTkLFPfl2nOFNgVI+DIpGpJ78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765380258; c=relaxed/simple;
	bh=kPnDS22NHYIkvFc8X9A3HYtYWQ+AYEXwLW7jJkZOUog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XoMyodJzE6nys9EXpfbreUelf8X5lLQRoi4zwycTENXWnFQ0/BMlG0sUcmNk1yQwnNZ9VGOkB4nUiGuIYDK4WLk/ZB6KYm37D03WGONvkocKKfPkam9reG+AbsZJWEahePZ2d47KQBCZwCHytoeWIl/GU8Ce95tNLixrHtgywkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dW0nVlDt; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=NSRJlXPArmc06u5FjBk6ZhGtDA4whaChgHWV0HFS2dM=; b=dW0nVlDt68jIFjuNNRIg1WbULI
	QeNHjy9MsMsuNQCkF0y95xllpxosPnvcRESc3Dr7Y8Ea6h8FyEu18h1Nt9A8Rnj8mxeCTzKgAGbkP
	sfgGcFLfyPvMcb/tudjYwG0tlA+RGcK6yUXXpxOXbkMGJEDwlhbvUAImGVFq8MiDzt9+JU8/O//z0
	2DKgmFcRfHzm6utmYrhf/a4wmC1xZDAI7KEY40bT92dHk7aikYNiwzdxfglQ+IxM1wRTNlIQMgtJu
	dsAoR57WBZiJ+TMwQFV3Ibscs2fpXYdsP8yLh5d+w5jh8sZV6FWvMsz6aC/KOT9pwLTO7iY9ymgYI
	WcfISXyg==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vTM35-0000000FZ3P-3kC8;
	Wed, 10 Dec 2025 15:24:16 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Eric Biggers <ebiggers@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-fscrypt@vger.kernel.org
Subject: [PATCH 8/9] blk-crypto: optimize data unit alignment checking
Date: Wed, 10 Dec 2025 16:23:37 +0100
Message-ID: <20251210152343.3666103-9-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251210152343.3666103-1-hch@lst.de>
References: <20251210152343.3666103-1-hch@lst.de>
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
 block/blk-crypto-fallback.c | 15 +++++++++++++--
 block/blk-crypto.c          | 22 ----------------------
 block/blk-merge.c           |  9 ++++++++-
 3 files changed, 21 insertions(+), 25 deletions(-)

diff --git a/block/blk-crypto-fallback.c b/block/blk-crypto-fallback.c
index 86d27d74542c..b2137b173520 100644
--- a/block/blk-crypto-fallback.c
+++ b/block/blk-crypto-fallback.c
@@ -253,6 +253,7 @@ static void __blk_crypto_fallback_encrypt_bio(struct bio *src_bio,
 	unsigned int enc_idx;
 	struct bio *enc_bio;
 	unsigned int j;
+	blk_status_t status;
 
 	skcipher_request_set_callback(ciph_req,
 			CRYPTO_TFM_REQ_MAY_BACKLOG | CRYPTO_TFM_REQ_MAY_SLEEP,
@@ -274,6 +275,12 @@ static void __blk_crypto_fallback_encrypt_bio(struct bio *src_bio,
 			bio_iter_iovec(src_bio, src_bio->bi_iter);
 		struct page *enc_page = enc_pages[enc_idx];
 
+		if (!IS_ALIGNED(src_bv.bv_len | src_bv.bv_offset,
+				data_unit_size)) {
+			status = BLK_STS_INVAL;
+			goto out_free_bounce_pages;
+		}
+
 		__bio_add_page(enc_bio, enc_page, src_bv.bv_len,
 				src_bv.bv_offset);
 
@@ -285,7 +292,7 @@ static void __blk_crypto_fallback_encrypt_bio(struct bio *src_bio,
 		for (j = 0; j < src_bv.bv_len; j += data_unit_size) {
 			blk_crypto_dun_to_iv(curr_dun, &iv);
 			if (crypto_skcipher_encrypt(ciph_req)) {
-				enc_idx++;
+				status = BLK_STS_IOERR;
 				goto out_free_bounce_pages;
 			}
 			bio_crypt_dun_increment(curr_dun, 1);
@@ -317,11 +324,12 @@ static void __blk_crypto_fallback_encrypt_bio(struct bio *src_bio,
 	return;
 
 out_free_bounce_pages:
+	enc_idx++;
 	while (enc_idx > 0)
 		mempool_free(enc_bio->bi_io_vec[--enc_idx].bv_page,
 			     blk_crypto_bounce_page_pool);
 	bio_put(enc_bio);
-	cmpxchg(&src_bio->bi_status, 0, BLK_STS_IOERR);
+	cmpxchg(&src_bio->bi_status, 0, status);
 	bio_endio(src_bio);
 }
 
@@ -375,6 +383,9 @@ static blk_status_t __blk_crypto_fallback_decrypt_bio(struct bio *bio,
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
index 6cea8fb3e968..829ee288065a 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -326,9 +326,16 @@ int bio_split_io_at(struct bio *bio, const struct queue_limits *lim,
 	struct bio_vec bv, bvprv, *bvprvp = NULL;
 	unsigned nsegs = 0, bytes = 0, gaps = 0;
 	struct bvec_iter iter;
+	unsigned len_align_mask = lim->dma_alignment;
+
+	if (bio_has_crypt_ctx(bio)) {
+		struct bio_crypt_ctx *bc = bio->bi_crypt_context;
+
+		len_align_mask |= (bc->bc_key->crypto_cfg.data_unit_size - 1);
+	}
 
 	bio_for_each_bvec(bv, bio, iter) {
-		if (bv.bv_offset & lim->dma_alignment)
+		if (bv.bv_offset & len_align_mask)
 			return -EINVAL;
 
 		/*
-- 
2.47.3


