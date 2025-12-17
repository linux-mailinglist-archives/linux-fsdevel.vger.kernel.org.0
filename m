Return-Path: <linux-fsdevel+bounces-71515-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 744B4CC625E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 07:09:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D89033097CA4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 06:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB16D2D6E4B;
	Wed, 17 Dec 2025 06:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oFSUZOC8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923212D3A69;
	Wed, 17 Dec 2025 06:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765951696; cv=none; b=SP00nIw1rf4Q/tXDYA/DmF9juckchoEo3Lu7OAjVoDNW6rhbVYEkX5q5aYuyEzoggN9FDX5AFCHbo4Qh4Pu7ig2KETJ5yr/fAAH4oqilTov8WqNdEaJfV23VvpfM+s0ixjNeo8xg3mWiueDi9gp1N5p0VeVOIGuybqhakZxYABk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765951696; c=relaxed/simple;
	bh=k3ITkRT1IbmSJBBZV1rJaiHlj/cLrR0PURZVbIaahKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MFup2UAs0eGLOEMC4/E8xPJxs1cosT/bYlucbDLHWXdCGTTVeYGHKmoxVu4NtDvosPHiaK1+2KJa3wh1uToeJwK5u+15nZFs4KbptINdPqRw1oP4M+w0rsS2MJhQlsVNzuLBOVfGvguVSHLtT3hslvN0GtV1+p1q1rQIXEDqGUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oFSUZOC8; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=HNDXeoEEGYDMY0s8jbwyVYaM6MDglUg/vbdVEa1MEws=; b=oFSUZOC8kLOfMgVfE1rolkNW1J
	04LZ0sPONXOMQN3FgE2zDopVJV7MiyBUPRBBEV2N5uVx67EYI+zPw5ekhD3QaGBmUmSMMj/2qremA
	MDX2V9o+ykpjdmcCEQLCRJL6Uru+gExSw4k5QFX1s+e69Y1VFihbYNGkiAEQqxbQ/HiZTWT6WtCUz
	+fRf/zDFDfm6xyPG62DEv/LryiOjxaTzZmmRb8eZfR4Nc+WgB24k6DYpXagO/L07DBYSwGIZEIxX9
	mKSrrBhJFhhK1LHkAgOx8lH1l7tqPMj+X6S6tBo7WnbxjQ6pjGbvclqH2j6Ivp67fdl7mrOkKBSOk
	ASFiQ9tg==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVkhp-00000006DFL-2gIs;
	Wed, 17 Dec 2025 06:08:13 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Eric Biggers <ebiggers@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-fscrypt@vger.kernel.org
Subject: [PATCH 7/9] blk-crypto: use mempool_alloc_bulk for encrypted bio page allocation
Date: Wed, 17 Dec 2025 07:06:50 +0100
Message-ID: <20251217060740.923397-8-hch@lst.de>
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

Calling mempool_alloc in a loop is not safe unless the maximum allocation
size times the maximum number of threads using it is less than the
minimum pool size.  Use the new mempool_alloc_bulk helper to allocate
all missing elements in one pass to remove this deadlock risk.  This
also means that non-pool allocations now use alloc_pages_bulk which can
be significantly faster than a loop over individual page allocations.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-crypto-fallback.c | 70 ++++++++++++++++++++++++++++---------
 1 file changed, 53 insertions(+), 17 deletions(-)

diff --git a/block/blk-crypto-fallback.c b/block/blk-crypto-fallback.c
index 58b35c5d6949..1db4aa4d812a 100644
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
 
@@ -246,10 +284,8 @@ static void __blk_crypto_fallback_encrypt_bio(struct bio *src_bio,
 		/* Encrypt each data unit in this page */
 		for (j = 0; j < src_bv.bv_len; j += data_unit_size) {
 			blk_crypto_dun_to_iv(curr_dun, &iv);
-			if (crypto_skcipher_encrypt(ciph_req)) {
-				enc_idx++;
-				goto out_free_bounce_pages;
-			}
+			if (crypto_skcipher_encrypt(ciph_req))
+				goto out_free_enc_bio;
 			bio_crypt_dun_increment(curr_dun, 1);
 			src.offset += data_unit_size;
 			dst.offset += data_unit_size;
@@ -278,9 +314,9 @@ static void __blk_crypto_fallback_encrypt_bio(struct bio *src_bio,
 	submit_bio(enc_bio);
 	return;
 
-out_free_bounce_pages:
-	while (enc_idx > 0)
-		mempool_free(enc_bio->bi_io_vec[--enc_idx].bv_page,
+out_free_enc_bio:
+	for (enc_idx = 0; enc_idx < enc_bio->bi_max_vecs; enc_idx++)
+		mempool_free(enc_bio->bi_io_vec[enc_idx].bv_page,
 			     blk_crypto_bounce_page_pool);
 	bio_put(enc_bio);
 	cmpxchg(&src_bio->bi_status, 0, BLK_STS_IOERR);
-- 
2.47.3


