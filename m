Return-Path: <linux-fsdevel+bounces-66573-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD084C24383
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 10:41:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0A5C560934
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 09:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2FA8329E52;
	Fri, 31 Oct 2025 09:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cR8gyRvi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B355331B116;
	Fri, 31 Oct 2025 09:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761903372; cv=none; b=PTcsv8Hy+L+/uSe32lkf2rGizNCc1VIQbWRhU+ZLx1KZ2AQof6CanPVpnLqO02Pk3LVBoy8M/sopEMK772Q1tx4AwJD1ea6Caowt9QoV0nT8FWlILsl3IbRF5puRxUXg8qMRBf7DVXsrKqN61dM3c+RxoQLi/YECqyxtIlFb3Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761903372; c=relaxed/simple;
	bh=3VtwKXYw6rGGIpLcHovkjlsw/+Gggv6WoWb7yAUCwPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IlE8gdbP4D3XcVyPfbMwE12i/29MSQiM/Z62oV5FBPyKp1Uq4zgeu4snRdYog/eOzTn3xBeIPlg9SPIr3OXjMPhMkR0rKLMAjTjrZ7y1OADZ9YATvuN9gxc8CYtNEtvohgm8fu7/ugNmdwRE28FfQwKVgD3nccUJHc67oVObkDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cR8gyRvi; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=wAylb0D6cMRFiTtOtljfzXlqGrVPob/jf/2jDFIsOSQ=; b=cR8gyRvic/ui/DEy2j6JZJjgqb
	koZlP+rhGEHVJw278pizwXCpDr0qxKxM/N+B2BWiChuTizldoR4I7iaqaN2pPpGphC0il3ZekmM4e
	WjZMM/GJad4al3Vxmi6ou6JDhPqXiJqEK/15u6LOyxrepYe36kQzWikRTVCKlE17fb7SwsZvwE9Ua
	wBQ9oBOwOQ/ym95wjQd+KV5yVF3BRww1k9+GwcqtL6Jx8VCZomqWz7e2wVsKi453wCrKay9zxWdoF
	6z4ywdyIkdg/sNTO62addxh0ClAirhABJALDs1JPnx2xUComewurIVbR1OAcijTlIjiNVVncnrr1B
	GWwfQI4A==;
Received: from [2001:4bb8:2dc:1001:a959:25cf:98e9:329b] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vElYG-00000005ou9-1GlQ;
	Fri, 31 Oct 2025 09:36:08 +0000
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
Subject: [PATCH 9/9] blk-crypto: use mempool_alloc_bulk for encrypted bio page allocation
Date: Fri, 31 Oct 2025 10:34:39 +0100
Message-ID: <20251031093517.1603379-10-hch@lst.de>
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

Calling mempool_alloc in a lot is not safe unless the maximum allocation
size times the maximum number of threads using it is less than the
minimum pool size.  Use the new mempool_alloc_bulk helper to allocate
all missing elements in one pass to remove this deadlock risk.  This
also means that non-pool allocations now use alloc_pages_bulk which can
be significantly faster than a loop over individual page allocations.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-crypto-fallback.c | 54 ++++++++++++++++++++++++++++++-------
 1 file changed, 45 insertions(+), 9 deletions(-)

diff --git a/block/blk-crypto-fallback.c b/block/blk-crypto-fallback.c
index 33aa7b26ed37..2f78027f0cce 100644
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
@@ -164,11 +164,21 @@ static bool blk_crypto_fallback_bio_valid(struct bio *bio)
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
 
 	src_bio->bi_status = enc_bio->bi_status;
 
@@ -176,9 +186,12 @@ static void blk_crypto_fallback_encrypt_endio(struct bio *enc_bio)
 	bio_endio(src_bio);
 }
 
+#define PAGE_PTRS_PER_BVEC     (sizeof(struct bio_vec) / sizeof(struct page *))
+
 static struct bio *blk_crypto_alloc_enc_bio(struct bio *bio_src,
-		unsigned int nr_segs)
+		unsigned int nr_segs, struct page ***pages_ret)
 {
+	struct page **pages;
 	struct bio *bio;
 
 	bio = bio_alloc_bioset(bio_src->bi_bdev, nr_segs, bio_src->bi_opf,
@@ -192,6 +205,29 @@ static struct bio *blk_crypto_alloc_enc_bio(struct bio *bio_src,
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
+	if (alloc_pages_bulk(GFP_NOFS, nr_segs, pages) < nr_segs) {
+		mempool_alloc_bulk(blk_crypto_bounce_page_pool, (void **)pages,
+				nr_segs, GFP_NOIO);
+	}
+	*pages_ret = pages;
 	return bio;
 }
 
@@ -234,6 +270,7 @@ static blk_status_t __blk_crypto_fallback_encrypt_bio(struct bio *src_bio,
 	struct scatterlist src, dst;
 	union blk_crypto_iv iv;
 	struct bio *enc_bio = NULL;
+	struct page **enc_pages;
 	unsigned int nr_segs;
 	unsigned int enc_idx = 0;
 	unsigned int j;
@@ -259,11 +296,10 @@ static blk_status_t __blk_crypto_fallback_encrypt_bio(struct bio *src_bio,
 
 		if (!enc_bio) {
 			enc_bio = blk_crypto_alloc_enc_bio(src_bio,
-					min(nr_segs, BIO_MAX_VECS));
+					min(nr_segs, BIO_MAX_VECS), &enc_pages);
 		}
 
-		enc_page = mempool_alloc(blk_crypto_bounce_page_pool,
-				GFP_NOIO);
+		enc_page = enc_pages[enc_idx];
 		__bio_add_page(enc_bio, enc_page, src_bv.bv_len,
 				src_bv.bv_offset);
 
-- 
2.47.3


