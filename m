Return-Path: <linux-fsdevel+bounces-72437-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B506CF714F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 06 Jan 2026 08:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 69B5F30B08BD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jan 2026 07:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C23630AD1D;
	Tue,  6 Jan 2026 07:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="U+7p2VlS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AD630BB9B;
	Tue,  6 Jan 2026 07:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767685044; cv=none; b=qICYYJ0lvT7fNAQIggJbW4yIEqHfZIAb5IJEhBdImyO0ymvfk4iBZCrv2i8LNR//D2D1J1MYQdRDEuecTqSvApuJ5+815UJ0APzpFRFMyhXbynAFN6VvKNEnVJJxbqqx8KZZvFHDIYYTw5Ns5JqotvCt3KyXm1tIfShBaq3r6mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767685044; c=relaxed/simple;
	bh=+Ybv17Z3KifL+e3QkAHo9IpSi1ZvUBunswhAw9kxtGE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QsFmbsFXqi6F1pHVO5nbYwTsM6vsBX4/DQoV2ihP194FFLeMKloxB48vmOe/RwyHzs//lZitPKjr3HYAnZ5iZdT1kuYZemTaiE9FqOMomBX4wucv9yCJ191gkGHoIAT1whyELQwS65xqaUuFbSbkHHXcwuJcdohVC6q2v2q29Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=U+7p2VlS; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=C6aSF8hoyXo4uqv0UMRO5ZGOS/MmF1M+vXrByc6bCwM=; b=U+7p2VlSJkWjDdZ9PwxCOwwbIh
	ZhplC5a/zSus9tn9LaSrNkUzfa7HjQHSiCajKBWhUwuSMbh22jOKeXaI4GdJehu/xQ1ovZ6Ubh8Vo
	XeASCb62vouoxiCySkQcqSGvpjtOihUdCL/SzMOG2aKrVdHxUIRMLdYEncwXEYqJ98NbR12noxZi8
	LD9HXm1uiTJf7hBVjP7kN4LXTiZmBBcAz32DbVeBq3fM4CQXvFiCuNGhX9i5LxSNiL0Q96Nqj56/u
	XslzxGyHOebbe0X9ZXB/w/64LxelcoNgzSQjVT4Ucnx+PaIJDxArzwYSoBoyD9VCJpt9fIigX3zgr
	BWhXEbhA==;
Received: from [213.208.157.59] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vd1d4-0000000CWiy-1LlX;
	Tue, 06 Jan 2026 07:37:22 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Eric Biggers <ebiggers@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-fscrypt@vger.kernel.org
Subject: [PATCH 7/9] blk-crypto: use mempool_alloc_bulk for encrypted bio page allocation
Date: Tue,  6 Jan 2026 08:36:30 +0100
Message-ID: <20260106073651.1607371-8-hch@lst.de>
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

Calling mempool_alloc in a loop is not safe unless the maximum allocation
size times the maximum number of threads using it is less than the
minimum pool size.  Use the new mempool_alloc_bulk helper to allocate
all missing elements in one pass to remove this deadlock risk.  This
also means that non-pool allocations now use alloc_pages_bulk which can
be significantly faster than a loop over individual page allocations.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-crypto-fallback.c | 76 ++++++++++++++++++++++++++++++-------
 1 file changed, 62 insertions(+), 14 deletions(-)

diff --git a/block/blk-crypto-fallback.c b/block/blk-crypto-fallback.c
index 4a682230c278..7ff7b6912fe4 100644
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
+
+	/*
+	 * Use the same trick as the alloc side to avoid the need for an extra
+	 * pages array.
+	 */
+	bio_for_each_bvec_all(bv, enc_bio, i)
+		pages[i] = bv->bv_page;
 
-	for (i = 0; i < enc_bio->bi_vcnt; i++)
-		mempool_free(enc_bio->bi_io_vec[i].bv_page,
-			     blk_crypto_bounce_page_pool);
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
 
 	bio = bio_alloc_bioset(bio_src->bi_bdev, nr_segs, bio_src->bi_opf,
@@ -173,6 +188,30 @@ static struct bio *blk_crypto_alloc_enc_bio(struct bio *bio_src,
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
 
@@ -209,6 +248,7 @@ static void __blk_crypto_fallback_encrypt_bio(struct bio *src_bio,
 	struct scatterlist src, dst;
 	union blk_crypto_iv iv;
 	unsigned int nr_enc_pages, enc_idx;
+	struct page **enc_pages;
 	struct bio *enc_bio;
 	unsigned int i;
 
@@ -231,15 +271,13 @@ static void __blk_crypto_fallback_encrypt_bio(struct bio *src_bio,
 	 */
 new_bio:
 	nr_enc_pages = min(bio_segments(src_bio), BIO_MAX_VECS);
-	enc_bio = blk_crypto_alloc_enc_bio(src_bio, nr_enc_pages);
+	enc_bio = blk_crypto_alloc_enc_bio(src_bio, nr_enc_pages, &enc_pages);
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
 
@@ -258,10 +296,8 @@ static void __blk_crypto_fallback_encrypt_bio(struct bio *src_bio,
 		 */
 		for (i = 0; i < src_bv.bv_len; i += data_unit_size) {
 			blk_crypto_dun_to_iv(curr_dun, &iv);
-			if (crypto_skcipher_encrypt(ciph_req)) {
-				bio_io_error(enc_bio);
-				return;
-			}
+			if (crypto_skcipher_encrypt(ciph_req))
+				goto out_free_enc_bio;
 			bio_crypt_dun_increment(curr_dun, 1);
 			src.offset += data_unit_size;
 			dst.offset += data_unit_size;
@@ -287,6 +323,18 @@ static void __blk_crypto_fallback_encrypt_bio(struct bio *src_bio,
 	}
 
 	submit_bio(enc_bio);
+	return;
+
+out_free_enc_bio:
+	/*
+	 * Add the remaining pages to the bio so that the normal completion path
+	 * in blk_crypto_fallback_encrypt_endio frees them.  The exact data
+	 * layout does not matter for that, so don't bother iterating the source
+	 * bio.
+	 */
+	for (; enc_idx < nr_enc_pages; enc_idx++)
+		__bio_add_page(enc_bio, enc_pages[enc_idx++], PAGE_SIZE, 0);
+	bio_io_error(enc_bio);
 }
 
 /*
-- 
2.47.3


