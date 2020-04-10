Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D312F1A42D1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Apr 2020 09:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725912AbgDJHKr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Apr 2020 03:10:47 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49606 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbgDJHKq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Apr 2020 03:10:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EV3NrtooVHRjJY+MlwTwzjNQPxT1z8NkUvp3taFpeXA=; b=oP2PVRvx60vGvFkcdAOELeBTQ5
        nGD2leZ0wkLJLJZQjNcpuc80boabDsdB0BYH2NFmOI1NY3WqcJrMgNmQMyWcXA5LtgP8pqnI922/S
        TO8ncp1wUYQQ1FLa5oYgx5xNB8GrOkoR2r1B7nYZM9RnqX7qgL+n080aptjG6U+Jl1ocCgu58skGq
        eQHqx61ENvWo/ZksRsZYKSPr1q+X+4pisJPeoll6rY6Nx6ddLBTXnDTzdW0OZPwj2SuBXIfe5KkG5
        9cxT3VqeEwSshPCI2k24EikY1l9uBkJ5Am+O8rW//39SfJrGVtT0/wpRLV14iVfvPzLKqT5xPaa7/
        yINy/Wug==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jMnoL-0000OM-ED; Fri, 10 Apr 2020 07:10:45 +0000
Date:   Fri, 10 Apr 2020 00:10:45 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v5 02/10] block: Introduce REQ_OP_ZONE_APPEND
Message-ID: <20200410071045.GA13404@infradead.org>
References: <20200409165352.2126-1-johannes.thumshirn@wdc.com>
 <20200409165352.2126-3-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200409165352.2126-3-johannes.thumshirn@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I've just been auditing the bio code for now and have a few suggestions:

 - we really should be reusing the passthrough bio handling for
   zone append instead of reinventing it
 - I think __bio_iov_iter_get_pages should be split into a separate
   append version.  That matches the bvec split (which we fail to
   handle properly for append), avoids a branch for every page in
   the fast path and generall seems to look cleaner.

Patch on top of your whole branch attached:

diff --git a/block/bio.c b/block/bio.c
index 4029a48f3828..dd84bd5adc24 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -679,54 +679,6 @@ struct bio *bio_clone_fast(struct bio *bio, gfp_t gfp_mask, struct bio_set *bs)
 }
 EXPORT_SYMBOL(bio_clone_fast);
 
-static bool bio_try_merge_zone_append_page(struct bio *bio, struct page *page,
-					   unsigned int len, unsigned int off,
-					   bool *same_page)
-{
-	struct request_queue *q = bio->bi_disk->queue;
-	struct bio_vec *bv;
-	unsigned long mask = queue_segment_boundary(q);
-	phys_addr_t addr1, addr2;
-
-	if (bio->bi_vcnt < 1)
-		return false;
-
-	bv = &bio->bi_io_vec[bio->bi_vcnt - 1];
-
-	addr1 = page_to_phys(bv->bv_page) + bv->bv_offset;
-	addr2 = page_to_phys(page) + off + len - 1;
-
-	if ((addr1 | mask) != (addr2 | mask))
-		return false;
-	if (bv->bv_len + len > queue_max_segment_size(q))
-		return false;
-	return __bio_try_merge_page(bio, page, len, off, same_page);
-}
-
-static int bio_add_append_page(struct bio *bio, struct page *page, unsigned len,
-			       size_t offset)
-{
-	struct request_queue *q = bio->bi_disk->queue;
-	unsigned int max_append_sectors = queue_max_zone_append_sectors(q);
-	bool same_page = false;
-
-	if (WARN_ON_ONCE(!max_append_sectors))
-		return 0;
-
-	if (((bio->bi_iter.bi_size + len) >> 9) > max_append_sectors)
-		return 0;
-
-	if (bio_try_merge_zone_append_page(bio, page, len, offset, &same_page))
-		return len;
-
-	if (bio->bi_vcnt >= queue_max_segments(q))
-		return 0;
-
-	__bio_add_page(bio, page, len, offset);
-
-	return len;
-}
-
 static inline bool page_is_mergeable(const struct bio_vec *bv,
 		struct page *page, unsigned int len, unsigned int off,
 		bool *same_page)
@@ -746,9 +698,13 @@ static inline bool page_is_mergeable(const struct bio_vec *bv,
 	return true;
 }
 
-static bool bio_try_merge_pc_page(struct request_queue *q, struct bio *bio,
-		struct page *page, unsigned len, unsigned offset,
-		bool *same_page)
+/*
+ * Try to merge a page into a segment, while obeying the hardware segment
+ * size limit.  This is not for normal read/write bios, but for passthrough
+ * or Zone Append operations that we can't split.
+ */
+static bool bio_try_merge_hw_seg(struct request_queue *q, struct bio *bio,
+		struct page *page, unsigned len, unsigned offset, bool *same_page)
 {
 	struct bio_vec *bv = &bio->bi_io_vec[bio->bi_vcnt - 1];
 	unsigned long mask = queue_segment_boundary(q);
@@ -762,39 +718,24 @@ static bool bio_try_merge_pc_page(struct request_queue *q, struct bio *bio,
 	return __bio_try_merge_page(bio, page, len, offset, same_page);
 }
 
-/**
- *	__bio_add_pc_page	- attempt to add page to passthrough bio
- *	@q: the target queue
- *	@bio: destination bio
- *	@page: page to add
- *	@len: vec entry length
- *	@offset: vec entry offset
- *	@same_page: return if the merge happen inside the same page
- *
- *	Attempt to add a page to the bio_vec maplist. This can fail for a
- *	number of reasons, such as the bio being full or target block device
- *	limitations. The target block device must allow bio's up to PAGE_SIZE,
- *	so it is always possible to add a single page to an empty bio.
- *
- *	This should only be used by passthrough bios.
+/*
+ * Add a page to a bio while respecting the hardware max_sectors, max_segment
+ * and gap limitations.
  */
-static int __bio_add_pc_page(struct request_queue *q, struct bio *bio,
+static int bio_add_hw_page(struct request_queue *q, struct bio *bio,
 		struct page *page, unsigned int len, unsigned int offset,
-		bool *same_page)
+		unsigned int max_sectors, bool *same_page)
 {
 	struct bio_vec *bvec;
 
-	/*
-	 * cloned bio must not modify vec list
-	 */
-	if (unlikely(bio_flagged(bio, BIO_CLONED)))
+	if (WARN_ON_ONCE(bio_flagged(bio, BIO_CLONED)))
 		return 0;
 
-	if (((bio->bi_iter.bi_size + len) >> 9) > queue_max_hw_sectors(q))
+	if (((bio->bi_iter.bi_size + len) >> 9) > max_sectors)
 		return 0;
 
 	if (bio->bi_vcnt > 0) {
-		if (bio_try_merge_pc_page(q, bio, page, len, offset, same_page))
+		if (bio_try_merge_hw_seg(q, bio, page, len, offset, same_page))
 			return len;
 
 		/*
@@ -821,11 +762,27 @@ static int __bio_add_pc_page(struct request_queue *q, struct bio *bio,
 	return len;
 }
 
+/**
+ * bio_add_pc_page	- attempt to add page to passthrough bio
+ * @q: the target queue
+ * @bio: destination bio
+ * @page: page to add
+ * @len: vec entry length
+ * @offset: vec entry offset
+ *
+ * Attempt to add a page to the bio_vec maplist. This can fail for a
+ * number of reasons, such as the bio being full or target block device
+ * limitations. The target block device must allow bio's up to PAGE_SIZE,
+ * so it is always possible to add a single page to an empty bio.
+ *
+ * This should only be used by passthrough bios.
+ */
 int bio_add_pc_page(struct request_queue *q, struct bio *bio,
 		struct page *page, unsigned int len, unsigned int offset)
 {
 	bool same_page = false;
-	return __bio_add_pc_page(q, bio, page, len, offset, &same_page);
+	return bio_add_hw_page(q, bio, page, len, offset,
+			queue_max_hw_sectors(q), &same_page);
 }
 EXPORT_SYMBOL(bio_add_pc_page);
 
@@ -993,27 +950,12 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 		struct page *page = pages[i];
 
 		len = min_t(size_t, PAGE_SIZE - offset, left);
-		if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
-			int ret;
-
-			if (bio_try_merge_zone_append_page(bio, page, len,
-							   offset,
-							   &same_page)) {
-				if (same_page)
-					put_page(page);
-			} else {
-				ret = bio_add_append_page(bio, page, len,
-							  offset);
-				if (ret != len)
-					return -EINVAL;
-			}
-		} else if (__bio_try_merge_page(bio, page, len, offset,
-						&same_page)) {
+		if (__bio_try_merge_page(bio, page, len, offset, &same_page)) {
 			if (same_page)
 				put_page(page);
 		} else {
 			if (WARN_ON_ONCE(bio_full(bio, len)))
-                                return -EINVAL;
+				return -EINVAL;
 			__bio_add_page(bio, page, len, offset);
 		}
 		offset = 0;
@@ -1023,6 +965,50 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 	return 0;
 }
 
+static int __bio_iov_append_get_pages(struct bio *bio, struct iov_iter *iter)
+{
+	unsigned short nr_pages = bio->bi_max_vecs - bio->bi_vcnt;
+	unsigned short entries_left = bio->bi_max_vecs - bio->bi_vcnt;
+	struct request_queue *q = bio->bi_disk->queue;
+	unsigned int max_append_sectors = queue_max_zone_append_sectors(q);
+	struct bio_vec *bv = bio->bi_io_vec + bio->bi_vcnt;
+	struct page **pages = (struct page **)bv;
+	ssize_t size, left;
+	unsigned len, i;
+	size_t offset;
+
+	if (WARN_ON_ONCE(!max_append_sectors))
+		return 0;
+
+	/*
+	 * Move page array up in the allocated memory for the bio vecs as far as
+	 * possible so that we can start filling biovecs from the beginning
+	 * without overwriting the temporary page array.
+	*/
+	BUILD_BUG_ON(PAGE_PTRS_PER_BVEC < 2);
+	pages += entries_left * (PAGE_PTRS_PER_BVEC - 1);
+
+	size = iov_iter_get_pages(iter, pages, LONG_MAX, nr_pages, &offset);
+	if (unlikely(size <= 0))
+		return size ? size : -EFAULT;
+
+	for (left = size, i = 0; left > 0; left -= len, i++) {
+		struct page *page = pages[i];
+		bool same_page = false;
+
+		len = min_t(size_t, PAGE_SIZE - offset, left);
+		if (bio_add_hw_page(q, bio, page, len, offset,
+				max_append_sectors, &same_page) != len)
+			return -EINVAL;
+		if (same_page)
+			put_page(page);
+		offset = 0;
+	}
+
+	iov_iter_advance(iter, size);
+	return 0;
+}
+
 /**
  * bio_iov_iter_get_pages - add user or kernel pages to a bio
  * @bio: bio to add pages to
@@ -1052,10 +1038,16 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 		return -EINVAL;
 
 	do {
-		if (is_bvec)
-			ret = __bio_iov_bvec_add_pages(bio, iter);
-		else
-			ret = __bio_iov_iter_get_pages(bio, iter);
+		if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
+			if (WARN_ON_ONCE(is_bvec))
+				return -EINVAL;
+			ret = __bio_iov_append_get_pages(bio, iter);
+		} else {
+			if (is_bvec)
+				ret = __bio_iov_bvec_add_pages(bio, iter);
+			else
+				ret = __bio_iov_iter_get_pages(bio, iter);
+		}
 	} while (!ret && iov_iter_count(iter) && !bio_full(bio, 0));
 
 	if (is_bvec)
@@ -1455,6 +1447,7 @@ struct bio *bio_map_user_iov(struct request_queue *q,
 			     struct iov_iter *iter,
 			     gfp_t gfp_mask)
 {
+	unsigned int max_sectors = queue_max_hw_sectors(q);
 	int j;
 	struct bio *bio;
 	int ret;
@@ -1492,8 +1485,8 @@ struct bio *bio_map_user_iov(struct request_queue *q,
 				if (n > bytes)
 					n = bytes;
 
-				if (!__bio_add_pc_page(q, bio, page, n, offs,
-						&same_page)) {
+				if (!bio_add_hw_page(q, bio, page, n, offs,
+						max_sectors, &same_page)) {
 					if (same_page)
 						put_page(page);
 					break;
