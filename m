Return-Path: <linux-fsdevel+bounces-73625-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 76CA5D1CEB3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 08:43:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 17D80301BDC2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 07:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0F534E760;
	Wed, 14 Jan 2026 07:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gn8E0a3I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6190F379998;
	Wed, 14 Jan 2026 07:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768376537; cv=none; b=id5482AvhokAXp+8nYiZyNTZT7Bvptm3zjBLW4JZISRqOwPGyOV95TeUVAQ0IXExZo2dmmFApnP6nbblWk6dH/iqzC3Rz1w68w6VVBdWApvICKw5my+mCi6MknywUp1FlkHYB+g3HAdxTAWi4H37xk/4lv41dzng0T2LLy63tNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768376537; c=relaxed/simple;
	bh=4lnzibLAK/PzA6PiQSmrFewrDaRZaTM0rc8WOqsFp7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=swMIun0H3btMbUKZ7taUtDdri2n6Krc2t8Cnk0WpXI/PQNROCgIbFCPgaiJp/K+6hZx/gRdgNeH0cHlisLzH2k0OWH6VCGos4Hjc7fWQ5bOqakYrB4A+d0IRHNjIZ6b11xii8gw2Jx83NGaJit8sc266pMCJldKK6+EyZOzpdlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gn8E0a3I; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=abBrKIe2PpNly7en7RWJ24/cn/rG2FMr6p46t98fOBc=; b=gn8E0a3I4Xzgx6TEff1g7/17Y5
	6UZSFb9j53p8oZZSNmD9CcUzeogABC0i7WR9uCxic5ypiC5QHzRYdDiI+IOln1Wo9z3hjlYBYFM3S
	5N36NuJCj9S1jXHVOUoYiAraTL8tgAsIOxtYgaDEimKEMjUOJ3943JXAGfa1+rzhqnh4OeFfgYi9V
	eE5BsothBFbCuD3r601SI10rfy0ELfsL3EotDXRcwS6da2Qp0ddnMqranUGC1zIWgSZMp9Nap79ze
	7c+U4eOlq7pEDKyKJO6r380OR+RoxAhO9G9yr4mSAnheWEe67eAnC6ykJrS1PCeKPLuKXoOJvl5c/
	NrHwsPEQ==;
Received: from 85-127-106-146.dsl.dynamic.surfer.at ([85.127.106.146] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfvW4-00000008DpO-3OyR;
	Wed, 14 Jan 2026 07:42:09 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	Qu Wenruo <wqu@suse.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-block@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 03/14] iov_iter: extract a iov_iter_extract_bvecs helper from bio code
Date: Wed, 14 Jan 2026 08:41:01 +0100
Message-ID: <20260114074145.3396036-4-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260114074145.3396036-1-hch@lst.de>
References: <20260114074145.3396036-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Massage __bio_iov_iter_get_pages so that it doesn't need the bio, and
move it to lib/iov_iter.c so that it can be used by block code for
other things than filling a bio and by other subsystems like netfs.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c         | 120 +++++++-------------------------------------
 include/linux/uio.h |   3 ++
 lib/iov_iter.c      |  98 ++++++++++++++++++++++++++++++++++++
 3 files changed, 119 insertions(+), 102 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 48d9f1592313..9cd1193ed807 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1169,102 +1169,6 @@ void bio_iov_bvec_set(struct bio *bio, const struct iov_iter *iter)
 	bio_set_flag(bio, BIO_CLONED);
 }
 
-static unsigned int get_contig_folio_len(struct page **pages,
-					 unsigned int *num_pages, size_t left,
-					 size_t offset)
-{
-	struct folio *folio = page_folio(pages[0]);
-	size_t contig_sz = min_t(size_t, PAGE_SIZE - offset, left);
-	unsigned int max_pages, i;
-	size_t folio_offset, len;
-
-	folio_offset = PAGE_SIZE * folio_page_idx(folio, pages[0]) + offset;
-	len = min(folio_size(folio) - folio_offset, left);
-
-	/*
-	 * We might COW a single page in the middle of a large folio, so we have
-	 * to check that all pages belong to the same folio.
-	 */
-	left -= contig_sz;
-	max_pages = DIV_ROUND_UP(offset + len, PAGE_SIZE);
-	for (i = 1; i < max_pages; i++) {
-		size_t next = min_t(size_t, PAGE_SIZE, left);
-
-		if (page_folio(pages[i]) != folio ||
-		    pages[i] != pages[i - 1] + 1)
-			break;
-		contig_sz += next;
-		left -= next;
-	}
-
-	*num_pages = i;
-	return contig_sz;
-}
-
-#define PAGE_PTRS_PER_BVEC     (sizeof(struct bio_vec) / sizeof(struct page *))
-
-/**
- * __bio_iov_iter_get_pages - pin user or kernel pages and add them to a bio
- * @bio: bio to add pages to
- * @iter: iov iterator describing the region to be mapped
- *
- * Extracts pages from *iter and appends them to @bio's bvec array.  The pages
- * will have to be cleaned up in the way indicated by the BIO_PAGE_PINNED flag.
- * For a multi-segment *iter, this function only adds pages from the next
- * non-empty segment of the iov iterator.
- */
-static ssize_t __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
-{
-	iov_iter_extraction_t extraction_flags = 0;
-	unsigned short nr_pages = bio->bi_max_vecs - bio->bi_vcnt;
-	unsigned short entries_left = bio->bi_max_vecs - bio->bi_vcnt;
-	struct bio_vec *bv = bio->bi_io_vec + bio->bi_vcnt;
-	struct page **pages = (struct page **)bv;
-	ssize_t size;
-	unsigned int i = 0;
-	size_t offset, left, len;
-
-	/*
-	 * Move page array up in the allocated memory for the bio vecs as far as
-	 * possible so that we can start filling biovecs from the beginning
-	 * without overwriting the temporary page array.
-	 */
-	BUILD_BUG_ON(PAGE_PTRS_PER_BVEC < 2);
-	pages += entries_left * (PAGE_PTRS_PER_BVEC - 1);
-
-	if (bio->bi_bdev && blk_queue_pci_p2pdma(bio->bi_bdev->bd_disk->queue))
-		extraction_flags |= ITER_ALLOW_P2PDMA;
-
-	size = iov_iter_extract_pages(iter, &pages,
-				      UINT_MAX - bio->bi_iter.bi_size,
-				      nr_pages, extraction_flags, &offset);
-	if (unlikely(size <= 0))
-		return size ? size : -EFAULT;
-
-	nr_pages = DIV_ROUND_UP(offset + size, PAGE_SIZE);
-	for (left = size; left > 0; left -= len) {
-		unsigned int nr_to_add;
-
-		if (bio->bi_vcnt > 0) {
-			struct bio_vec *prev = &bio->bi_io_vec[bio->bi_vcnt - 1];
-
-			if (!zone_device_pages_have_same_pgmap(prev->bv_page,
-					pages[i]))
-				break;
-		}
-
-		len = get_contig_folio_len(&pages[i], &nr_to_add, left, offset);
-		__bio_add_page(bio, pages[i], len, offset);
-		i += nr_to_add;
-		offset = 0;
-	}
-
-	iov_iter_revert(iter, left);
-	while (i < nr_pages)
-		bio_release_page(bio, pages[i++]);
-	return size - left;
-}
-
 /*
  * Aligns the bio size to the len_align_mask, releasing excessive bio vecs that
  * __bio_iov_iter_get_pages may have inserted, and reverts the trimmed length
@@ -1322,7 +1226,7 @@ static int bio_iov_iter_align_down(struct bio *bio, struct iov_iter *iter,
 int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter,
 			   unsigned len_align_mask)
 {
-	ssize_t ret;
+	iov_iter_extraction_t flags = 0;
 
 	if (WARN_ON_ONCE(bio_flagged(bio, BIO_CLONED)))
 		return -EIO;
@@ -1335,14 +1239,26 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter,
 
 	if (iov_iter_extract_will_pin(iter))
 		bio_set_flag(bio, BIO_PAGE_PINNED);
+	if (bio->bi_bdev && blk_queue_pci_p2pdma(bio->bi_bdev->bd_disk->queue))
+		flags |= ITER_ALLOW_P2PDMA;
 
 	do {
-		ret = __bio_iov_iter_get_pages(bio, iter);
-	} while (ret > 0 && iov_iter_count(iter) && !bio_full(bio, 0));
+		ssize_t ret;
+
+		ret = iov_iter_extract_bvecs(iter, bio->bi_io_vec,
+				UINT_MAX - bio->bi_iter.bi_size, &bio->bi_vcnt,
+				bio->bi_max_vecs, flags);
+		if (ret <= 0) {
+			if (!bio->bi_vcnt)
+				return ret;
+			break;
+		}
+		bio->bi_iter.bi_size += ret;
+	} while (iov_iter_count(iter) && !bio_full(bio, 0));
 
-	if (bio->bi_vcnt)
-		return bio_iov_iter_align_down(bio, iter, len_align_mask);
-	return ret;
+	if (is_pci_p2pdma_page(bio->bi_io_vec->bv_page))
+		bio->bi_opf |= REQ_NOMERGE;
+	return bio_iov_iter_align_down(bio, iter, len_align_mask);
 }
 
 static void submit_bio_wait_endio(struct bio *bio)
diff --git a/include/linux/uio.h b/include/linux/uio.h
index 5b127043a151..a9bc5b3067e3 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -389,6 +389,9 @@ ssize_t iov_iter_extract_pages(struct iov_iter *i, struct page ***pages,
 			       size_t maxsize, unsigned int maxpages,
 			       iov_iter_extraction_t extraction_flags,
 			       size_t *offset0);
+ssize_t iov_iter_extract_bvecs(struct iov_iter *iter, struct bio_vec *bv,
+		size_t max_size, unsigned short *nr_vecs,
+		unsigned short max_vecs, iov_iter_extraction_t extraction_flags);
 
 /**
  * iov_iter_extract_will_pin - Indicate how pages from the iterator will be retained
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 896760bad455..545250507f08 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1845,3 +1845,101 @@ ssize_t iov_iter_extract_pages(struct iov_iter *i,
 	return -EFAULT;
 }
 EXPORT_SYMBOL_GPL(iov_iter_extract_pages);
+
+static unsigned int get_contig_folio_len(struct page **pages,
+		unsigned int *num_pages, size_t left, size_t offset)
+{
+	struct folio *folio = page_folio(pages[0]);
+	size_t contig_sz = min_t(size_t, PAGE_SIZE - offset, left);
+	unsigned int max_pages, i;
+	size_t folio_offset, len;
+
+	folio_offset = PAGE_SIZE * folio_page_idx(folio, pages[0]) + offset;
+	len = min(folio_size(folio) - folio_offset, left);
+
+	/*
+	 * We might COW a single page in the middle of a large folio, so we have
+	 * to check that all pages belong to the same folio.
+	 */
+	left -= contig_sz;
+	max_pages = DIV_ROUND_UP(offset + len, PAGE_SIZE);
+	for (i = 1; i < max_pages; i++) {
+		size_t next = min_t(size_t, PAGE_SIZE, left);
+
+		if (page_folio(pages[i]) != folio ||
+		    pages[i] != pages[i - 1] + 1)
+			break;
+		contig_sz += next;
+		left -= next;
+	}
+
+	*num_pages = i;
+	return contig_sz;
+}
+
+#define PAGE_PTRS_PER_BVEC     (sizeof(struct bio_vec) / sizeof(struct page *))
+
+/**
+ * iov_iter_extract_bvecs - Extract bvecs from an iterator
+ * @iter:	the iterator to extract from
+ * @bv:		bvec return array
+ * @max_size:	maximum size to extract from @iter
+ * @nr_vecs:	number of vectors in @bv (on in and output)
+ * @max_vecs:	maximum vectors in @bv, including those filled before calling
+ * @extraction_flags: flags to qualify request
+ *
+ * Like iov_iter_extract_pages(), but returns physically contiguous ranges
+ * contained in a single folio as a single bvec instead of multiple entries.
+ *
+ * Returns the number of bytes extracted when successful, or a negative errno.
+ * If @nr_vecs was non-zero on entry, the number of successfully extracted bytes
+ * can be 0.
+ */
+ssize_t iov_iter_extract_bvecs(struct iov_iter *iter, struct bio_vec *bv,
+		size_t max_size, unsigned short *nr_vecs,
+		unsigned short max_vecs, iov_iter_extraction_t extraction_flags)
+{
+	unsigned short entries_left = max_vecs - *nr_vecs;
+	unsigned short nr_pages, i = 0;
+	size_t left, offset, len;
+	struct page **pages;
+	ssize_t size;
+
+	/*
+	 * Move page array up in the allocated memory for the bio vecs as far as
+	 * possible so that we can start filling biovecs from the beginning
+	 * without overwriting the temporary page array.
+	 */
+	BUILD_BUG_ON(PAGE_PTRS_PER_BVEC < 2);
+	pages = (struct page **)(bv + *nr_vecs) +
+		entries_left * (PAGE_PTRS_PER_BVEC - 1);
+
+	size = iov_iter_extract_pages(iter, &pages, max_size, entries_left,
+			extraction_flags, &offset);
+	if (unlikely(size <= 0))
+		return size ? size : -EFAULT;
+
+	nr_pages = DIV_ROUND_UP(offset + size, PAGE_SIZE);
+	for (left = size; left > 0; left -= len) {
+		unsigned int nr_to_add;
+
+		if (*nr_vecs > 0 &&
+		    !zone_device_pages_have_same_pgmap(bv[*nr_vecs - 1].bv_page,
+				pages[i]))
+			break;
+
+		len = get_contig_folio_len(&pages[i], &nr_to_add, left, offset);
+		bvec_set_page(&bv[*nr_vecs], pages[i], len, offset);
+		i += nr_to_add;
+		(*nr_vecs)++;
+		offset = 0;
+	}
+
+	iov_iter_revert(iter, left);
+	if (iov_iter_extract_will_pin(iter)) {
+		while (i < nr_pages)
+			unpin_user_page(pages[i++]);
+	}
+	return size - left;
+}
+EXPORT_SYMBOL_GPL(iov_iter_extract_bvecs);
-- 
2.47.3


