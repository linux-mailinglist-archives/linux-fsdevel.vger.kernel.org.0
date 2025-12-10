Return-Path: <linux-fsdevel+bounces-71063-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D95A6CB3501
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Dec 2025 16:28:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 037EF3262385
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Dec 2025 15:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1DC322C67;
	Wed, 10 Dec 2025 15:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FJlP9nvF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C84F2417F0;
	Wed, 10 Dec 2025 15:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765380255; cv=none; b=iFPcPMJ/LmfgTs3InC/zdCSSKuRraN+q/CVDNokhT6K2lF6ulwXcWCqfSboiPrrvPlWxyUwANmQzEhx9611r2y7JvGfNLHoEffg1+Erq30qeH66l8qC17yT0297/6SIM35HlEIQUfIJ1HFthp3Q+StDQoXtboJ7Vgi5p/YLq+8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765380255; c=relaxed/simple;
	bh=OTJ4141/ER65BERGcl53Um1A43w2l4D4MIf6CEqZET8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PSMe5Dqi1SuVHTafLwx0ZlNerHnUrfy4UqRahBySnOKHpyHrztBM3Iu70LsaWiDOl+q21f1g3MvXnfE5d1pUYKZ3Ax1h8p3ZF6HJGlaKmpV6biqYcUR/XVoLOqLsC0t9b9MsRBlr/EqxvuhNJxh5JqnkiF9m94pUobz+bcRZsJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FJlP9nvF; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=3lwwqTuJ70KmDjYjsYDFxyt/aSvACikRKBv+BDKODDs=; b=FJlP9nvFluct5vWDc+1OpWhd3F
	6BnblVopAyi2xYUyAm56+SgFC9lv+4YPumzE0kzvfu0hIY8j72C2bqwRwQLcJ+CObGkv+bt3+OhUE
	i+Vj+6HU6TbJuE9hgQ2hYJnJhfVjz8ec2Eiq/YTyFuv20vk+xFmKxjEaQk+sRZjLWI28oPA8ljQ9N
	T92dL3YcqmQArQs+Pa/pSxobDvY5VJERnp/WN9DVjrbg4/rJ1TSpV/4krv8ZI0jR8sNB+lfBWBR7O
	MGlUqii7Am+O/kzqfVpi10BdPsAWDOMlNcGDlWThnmGQh2Qftx8GavnDtW3oOR0Tj4pznCFdl3MTr
	etpor30g==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vTM32-0000000FZ3I-37U1;
	Wed, 10 Dec 2025 15:24:13 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Eric Biggers <ebiggers@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-fscrypt@vger.kernel.org
Subject: [PATCH 7/9] blk-crypto: use mempool_alloc_bulk for encrypted bio page allocation
Date: Wed, 10 Dec 2025 16:23:36 +0100
Message-ID: <20251210152343.3666103-8-hch@lst.de>
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

Calling mempool_alloc in a lot is not safe unless the maximum allocation
size times the maximum number of threads using it is less than the
minimum pool size.  Use the new mempool_alloc_bulk helper to allocate
all missing elements in one pass to remove this deadlock risk.  This
also means that non-pool allocations now use alloc_pages_bulk which can
be significantly faster than a loop over individual page allocations.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-crypto-fallback.c | 58 ++++++++++++++++++++++++++++++-------
 1 file changed, 48 insertions(+), 10 deletions(-)

diff --git a/block/blk-crypto-fallback.c b/block/blk-crypto-fallback.c
index d2b9fb8273a9..86d27d74542c 100644
--- a/block/blk-crypto-fallback.c
+++ b/block/blk-crypto-fallback.c
@@ -22,7 +22,7 @@
 #include "blk-cgroup.h"
 #include "blk-crypto-internal.h"
 
-static unsigned int num_prealloc_bounce_pg = 32;
+static unsigned int num_prealloc_bounce_pg = BIO_MAX_VECS;
 module_param(num_prealloc_bounce_pg, uint, 0);
 MODULE_PARM_DESC(num_prealloc_bounce_pg,
 		 "Number of preallocated bounce pages for the blk-crypto crypto API fallback");
@@ -144,11 +144,21 @@ static const struct blk_crypto_ll_ops blk_crypto_fallback_ll_ops = {
 static void blk_crypto_fallback_encrypt_endio(struct bio *enc_bio)
 {
 	struct bio *src_bio = enc_bio->bi_private;
-	int i;
+	struct page **pages = (struct page **)enc_bio->bi_io_vec;
+	struct bio_vec *bv;
+	unsigned int i;
 
-	for (i = 0; i < enc_bio->bi_vcnt; i++)
-		mempool_free(enc_bio->bi_io_vec[i].bv_page,
-			     blk_crypto_bounce_page_pool);
+	/*
+	 * Use the same trick as the alloc side to avoid the need for an extra
+	 * pages array.
+	 */
+	bio_for_each_bvec_all(bv, enc_bio, i)
+		pages[i] = bv->bv_page;
+
+	i = mempool_free_bulk(blk_crypto_bounce_page_pool, (void **)pages,
+			enc_bio->bi_vcnt);
+	if (i < enc_bio->bi_vcnt)
+		release_pages(pages + i, enc_bio->bi_vcnt - i);
 
 	if (enc_bio->bi_status)
 		cmpxchg(&src_bio->bi_status, 0, enc_bio->bi_status);
@@ -157,9 +167,14 @@ static void blk_crypto_fallback_encrypt_endio(struct bio *enc_bio)
 	bio_endio(src_bio);
 }
 
+#define PAGE_PTRS_PER_BVEC     (sizeof(struct bio_vec) / sizeof(struct page *))
+
 static struct bio *blk_crypto_alloc_enc_bio(struct bio *bio_src,
-		unsigned int nr_segs)
+		unsigned int nr_segs, struct page ***pages_ret)
 {
+	unsigned int memflags = memalloc_noio_save();
+	unsigned int nr_allocated;
+	struct page **pages;
 	struct bio *bio;
 
 	nr_segs = min(nr_segs, BIO_MAX_VECS);
@@ -174,6 +189,30 @@ static struct bio *blk_crypto_alloc_enc_bio(struct bio *bio_src,
 	bio->bi_write_stream	= bio_src->bi_write_stream;
 	bio->bi_iter.bi_sector	= bio_src->bi_iter.bi_sector;
 	bio_clone_blkg_association(bio, bio_src);
+
+	/*
+	 * Move page array up in the allocated memory for the bio vecs as far as
+	 * possible so that we can start filling biovecs from the beginning
+	 * without overwriting the temporary page array.
+	 */
+	static_assert(PAGE_PTRS_PER_BVEC > 1);
+	pages = (struct page **)bio->bi_io_vec;
+	pages += nr_segs * (PAGE_PTRS_PER_BVEC - 1);
+
+	/*
+	 * Try a bulk allocation first.  This could leave random pages in the
+	 * array unallocated, but we'll fix that up later in mempool_alloc_bulk.
+	 *
+	 * Note: alloc_pages_bulk needs the array to be zeroed, as it assumes
+	 * any non-zero slot already contains a valid allocation.
+	 */
+	memset(pages, 0, sizeof(struct page *) * nr_segs);
+	nr_allocated = alloc_pages_bulk(GFP_KERNEL, nr_segs, pages);
+	if (nr_allocated < nr_segs)
+		mempool_alloc_bulk(blk_crypto_bounce_page_pool, (void **)pages,
+				nr_segs, nr_allocated);
+	memalloc_noio_restore(memflags);
+	*pages_ret = pages;
 	return bio;
 }
 
@@ -210,6 +249,7 @@ static void __blk_crypto_fallback_encrypt_bio(struct bio *src_bio,
 	u64 curr_dun[BLK_CRYPTO_DUN_ARRAY_SIZE];
 	struct scatterlist src, dst;
 	union blk_crypto_iv iv;
+	struct page **enc_pages;
 	unsigned int enc_idx;
 	struct bio *enc_bio;
 	unsigned int j;
@@ -227,15 +267,13 @@ static void __blk_crypto_fallback_encrypt_bio(struct bio *src_bio,
 
 	/* Encrypt each page in the source bio */
 new_bio:
-	enc_bio = blk_crypto_alloc_enc_bio(src_bio, nr_segs);
+	enc_bio = blk_crypto_alloc_enc_bio(src_bio, nr_segs, &enc_pages);
 	enc_idx = 0;
 	for (;;) {
 		struct bio_vec src_bv =
 			bio_iter_iovec(src_bio, src_bio->bi_iter);
-		struct page *enc_page;
+		struct page *enc_page = enc_pages[enc_idx];
 
-		enc_page = mempool_alloc(blk_crypto_bounce_page_pool,
-				GFP_NOIO);
 		__bio_add_page(enc_bio, enc_page, src_bv.bv_len,
 				src_bv.bv_offset);
 
-- 
2.47.3


