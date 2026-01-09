Return-Path: <linux-fsdevel+bounces-73007-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BF925D07584
	for <lists+linux-fsdevel@lfdr.de>; Fri, 09 Jan 2026 07:10:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8F01030650A4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jan 2026 06:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD9B29DB8F;
	Fri,  9 Jan 2026 06:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1DNiAshz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3317C28934F;
	Fri,  9 Jan 2026 06:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767938929; cv=none; b=nTyZcelxXuF5qRFmq6/GNjqOLh1ATE11ZVpS5MFlkubVrJiVAfzSA3YTmWWkwHxUdphnACtLiEE6VgM9jDlHWUtb6z18rwHJc5o98NQczTi9ml6JkuqaID6HcDgBtxSmjrIfhO0KNKkARnpveWkTwQbg+Zowjh0gDcMtGwaipvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767938929; c=relaxed/simple;
	bh=W4HQjjT145LsVXqr1iFsv91jPgQttU2MXq3p54VJtC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BR0HjDIf4rP4qSIaLdA8z8dbO03HJmg90gEHAG1D948ogRG6qwVuSx10zIvo6H0KDmdg3bsiTV+mAH2ubQU2RAsPIZHTZqP0TkHVAfBGQpN9zGu8cJMla+PwJZHxXazS/w11EDUmGI5GLmbi1TPs+ub+DqKJjTfKcrv+rh6qRRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=1DNiAshz; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=DUSwJ3JJcfMYOiIi3fXsbr1VRU8UKte/YlFAwVilFlk=; b=1DNiAshz6YqKbkqsMUmaK/EZVj
	qC38hxrG6tOpGEGdtDpgXL79y96xNORmhna6CZkGMVxZZqzgWoQj/GjEi93mGxRYVwP1eogi7bQdy
	T+1q8IfQY4x1Up4ZFRxF0cC0y0dqRaLbiak/QlJwGKcX1Gf4ER2pJGD/oJcf4INc51/9qEzfDctGL
	2uuFtEbOmGeNNAm4J9qODnPy/b+371fNSg26YoHHrVo+6MKEe2WhOHAhWm604SOqbJazt0b0JBrHM
	J65KLa9lY8p6YcpGCoLi/qDe3QTueLsUuE/Eth/i4zD5YttqWjeEcah7spKRyr70/BYJyG+3Eeb43
	yfSzWSKw==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ve5fz-00000001WXL-0vUD;
	Fri, 09 Jan 2026 06:08:47 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Eric Biggers <ebiggers@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-fscrypt@vger.kernel.org
Subject: [PATCH 8/9] blk-crypto: optimize data unit alignment checking
Date: Fri,  9 Jan 2026 07:07:48 +0100
Message-ID: <20260109060813.2226714-9-hch@lst.de>
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
Reviewed-by: Eric Biggers <ebiggers@kernel.org>
---
 block/blk-crypto-fallback.c | 15 +++++++++++++--
 block/blk-crypto.c          | 22 ----------------------
 block/blk-merge.c           |  9 ++++++++-
 3 files changed, 21 insertions(+), 25 deletions(-)

diff --git a/block/blk-crypto-fallback.c b/block/blk-crypto-fallback.c
index 6be971859542..a331b061dbf4 100644
--- a/block/blk-crypto-fallback.c
+++ b/block/blk-crypto-fallback.c
@@ -278,6 +278,12 @@ static void __blk_crypto_fallback_encrypt_bio(struct bio *src_bio,
 			bio_iter_iovec(src_bio, src_bio->bi_iter);
 		struct page *enc_page = enc_pages[enc_idx];
 
+		if (!IS_ALIGNED(src_bv.bv_len | src_bv.bv_offset,
+				data_unit_size)) {
+			enc_bio->bi_status = BLK_STS_INVAL;
+			goto out_free_enc_bio;
+		}
+
 		__bio_add_page(enc_bio, enc_page, src_bv.bv_len,
 				src_bv.bv_offset);
 
@@ -296,8 +302,10 @@ static void __blk_crypto_fallback_encrypt_bio(struct bio *src_bio,
 		 */
 		for (i = 0; i < src_bv.bv_len; i += data_unit_size) {
 			blk_crypto_dun_to_iv(curr_dun, &iv);
-			if (crypto_skcipher_encrypt(ciph_req))
+			if (crypto_skcipher_encrypt(ciph_req)) {
+				enc_bio->bi_status = BLK_STS_IOERR;
 				goto out_free_enc_bio;
+			}
 			bio_crypt_dun_increment(curr_dun, 1);
 			src.offset += data_unit_size;
 			dst.offset += data_unit_size;
@@ -334,7 +342,7 @@ static void __blk_crypto_fallback_encrypt_bio(struct bio *src_bio,
 	 */
 	for (; enc_idx < nr_enc_pages; enc_idx++)
 		__bio_add_page(enc_bio, enc_pages[enc_idx], PAGE_SIZE, 0);
-	bio_io_error(enc_bio);
+	bio_endio(enc_bio);
 }
 
 /*
@@ -387,6 +395,9 @@ static blk_status_t __blk_crypto_fallback_decrypt_bio(struct bio *bio,
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


