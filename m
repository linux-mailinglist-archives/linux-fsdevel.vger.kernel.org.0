Return-Path: <linux-fsdevel+bounces-74390-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB4A9D3A07E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 08:49:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2EA8230AF9DE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 07:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E661A337B8F;
	Mon, 19 Jan 2026 07:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iNIiUS33"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84D63382C1;
	Mon, 19 Jan 2026 07:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768808700; cv=none; b=fwmzZzvEN4M90Dcw/ce5DXfgXjG590lLtP8jF13cqxsh+O2hT89iwAMvBPMinbNx1JV1RrrWKZd9pbd2CKn4NSxPQgnvH41HN+vqorBm8ba7J/XKdDUAQFKKfo4c/B9DRKHnn3xPLIBrqGVBKssjQQgfOwJuaCJv0eiV+FKFl7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768808700; c=relaxed/simple;
	bh=eanIg659YyfrYMXS7ihND5WhQJsnhxFvhZt/KnZbzbw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o88E3T/f+ZyIzMDE0R2ArlTRMm1Y9gngRj7nb1/aJjjZXm2ekR3JKm2caxZuoI2xvyT3eETBWqc20tiYTndi3fs2CRVTtjwKWhWXI8vxRN52xM2vZ4SBqGrRYIw21+c+rUZXmqM3dPJNWs/pQkw6enL276ulA+J+w4uU1Nuowi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=iNIiUS33; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=u28/5P22ObdCKGP7S+7XT7NXOBAdi59o5NTFvbqr3Qs=; b=iNIiUS33Hn1z699QOLJkM023yI
	X+HXw+insoYrpuzqrBbmvZ4Kr79VlKpPYqN+wuyseLztD51vs/G0f4Oepv9WaB6kAYLmWnU8vPq6c
	h5vsD/es3xqFlWLkDzPETFHxA4406AGjsv9OhZvdTc0b4iPjYUYfjAbFdNAQcocx5X5vYo0zNWREJ
	z4xNSLx0j8dg7u9GV6N/L7A2bcBk1qqjhawfipSFGG2YoQ/a9DhEF3+H9zecyXZXW75qO+EDtX584
	tNqk1iKFB5SRWX8yO0CEfRvI4wI4WhmcmCJvvGRhODTNZMgDxNqtI4gvjsBBRmwIXf9/EJ+bVQnkg
	3vu+gtFw==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vhjwQ-00000001WBE-1pFu;
	Mon, 19 Jan 2026 07:44:50 +0000
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
Subject: [PATCH 05/14] block: add helpers to bounce buffer an iov_iter into bios
Date: Mon, 19 Jan 2026 08:44:12 +0100
Message-ID: <20260119074425.4005867-6-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260119074425.4005867-1-hch@lst.de>
References: <20260119074425.4005867-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Add helpers to implement bounce buffering of data into a bio to implement
direct I/O for cases where direct user access is not possible because
stable in-flight data is required.  These are intended to be used as
easily as bio_iov_iter_get_pages for the zero-copy path.

The write side is trivial and just copies data into the bounce buffer.
The read side is a lot more complex because it needs to perform the copy
from the completion context, and without preserving the iov_iter through
the call chain.  It steals a trick from the integrity data user interface
and uses the first vector in the bio for the bounce buffer data that is
fed to the block I/O stack, and uses the others to record the user
buffer fragments.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c         | 178 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/bio.h |  26 +++++++
 2 files changed, 204 insertions(+)

diff --git a/block/bio.c b/block/bio.c
index c51b4e2470e2..da795b1df52a 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1266,6 +1266,184 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter,
 	return bio_iov_iter_align_down(bio, iter, len_align_mask);
 }
 
+static struct folio *folio_alloc_greedy(gfp_t gfp, size_t *size)
+{
+	struct folio *folio;
+
+	while (*size > PAGE_SIZE) {
+		folio = folio_alloc(gfp | __GFP_NORETRY, get_order(*size));
+		if (folio)
+			return folio;
+		*size = rounddown_pow_of_two(*size - 1);
+	}
+
+	return folio_alloc(gfp, get_order(*size));
+}
+
+static void bio_free_folios(struct bio *bio)
+{
+	struct bio_vec *bv;
+	int i;
+
+	bio_for_each_bvec_all(bv, bio, i) {
+		struct folio *folio = page_folio(bv->bv_page);
+
+		if (!is_zero_folio(folio))
+			folio_put(page_folio(bv->bv_page));
+	}
+}
+
+static int bio_iov_iter_bounce_write(struct bio *bio, struct iov_iter *iter)
+{
+	size_t total_len = iov_iter_count(iter);
+
+	if (WARN_ON_ONCE(bio_flagged(bio, BIO_CLONED)))
+		return -EINVAL;
+	if (WARN_ON_ONCE(bio->bi_iter.bi_size))
+		return -EINVAL;
+	if (WARN_ON_ONCE(bio->bi_vcnt >= bio->bi_max_vecs))
+		return -EINVAL;
+
+	do {
+		size_t this_len = min(total_len, SZ_1M);
+		struct folio *folio;
+
+		if (this_len > PAGE_SIZE * 2)
+			this_len = rounddown_pow_of_two(this_len);
+
+		if (bio->bi_iter.bi_size > UINT_MAX - this_len)
+			break;
+
+		folio = folio_alloc_greedy(GFP_KERNEL, &this_len);
+		if (!folio)
+			break;
+		bio_add_folio_nofail(bio, folio, this_len, 0);
+
+		if (copy_from_iter(folio_address(folio), this_len, iter) !=
+				this_len) {
+			bio_free_folios(bio);
+			return -EFAULT;
+		}
+
+		total_len -= this_len;
+	} while (total_len && bio->bi_vcnt < bio->bi_max_vecs);
+
+	if (!bio->bi_iter.bi_size)
+		return -ENOMEM;
+	return 0;
+}
+
+static int bio_iov_iter_bounce_read(struct bio *bio, struct iov_iter *iter)
+{
+	size_t len = min(iov_iter_count(iter), SZ_1M);
+	struct folio *folio;
+
+	folio = folio_alloc_greedy(GFP_KERNEL, &len);
+	if (!folio)
+		return -ENOMEM;
+
+	do {
+		ssize_t ret;
+
+		ret = iov_iter_extract_bvecs(iter, bio->bi_io_vec + 1, len,
+				&bio->bi_vcnt, bio->bi_max_vecs - 1, 0);
+		if (ret <= 0) {
+			if (!bio->bi_vcnt)
+				return ret;
+			break;
+		}
+		len -= ret;
+		bio->bi_iter.bi_size += ret;
+	} while (len && bio->bi_vcnt < bio->bi_max_vecs - 1);
+
+	/*
+	 * Set the folio directly here.  The above loop has already calculated
+	 * the correct bi_size, and we use bi_vcnt for the user buffers.  That
+	 * is safe as bi_vcnt is only for user by the submitter and not looked
+	 * at by the actual I/O path.
+	 */
+	bvec_set_folio(&bio->bi_io_vec[0], folio, bio->bi_iter.bi_size, 0);
+	if (iov_iter_extract_will_pin(iter))
+		bio_set_flag(bio, BIO_PAGE_PINNED);
+	return 0;
+}
+
+/**
+ * bio_iov_iter_bounce - bounce buffer data from an iter into a bio
+ * @bio:	bio to send
+ * @iter:	iter to read from / write into
+ *
+ * Helper for direct I/O implementations that need to bounce buffer because
+ * we need to checksum the data or perform other operations that require
+ * consistency.  Allocates folios to back the bounce buffer, and for writes
+ * copies the data into it.  Needs to be paired with bio_iov_iter_unbounce()
+ * called on completion.
+ */
+int bio_iov_iter_bounce(struct bio *bio, struct iov_iter *iter)
+{
+	if (op_is_write(bio_op(bio)))
+		return bio_iov_iter_bounce_write(bio, iter);
+	return bio_iov_iter_bounce_read(bio, iter);
+}
+
+static void bvec_unpin(struct bio_vec *bv, bool mark_dirty)
+{
+	struct folio *folio = page_folio(bv->bv_page);
+	size_t nr_pages = (bv->bv_offset + bv->bv_len - 1) / PAGE_SIZE -
+			bv->bv_offset / PAGE_SIZE + 1;
+
+	if (mark_dirty)
+		folio_mark_dirty_lock(folio);
+	unpin_user_folio(folio, nr_pages);
+}
+
+static void bio_iov_iter_unbounce_read(struct bio *bio, bool is_error,
+		bool mark_dirty)
+{
+	unsigned int len = bio->bi_io_vec[0].bv_len;
+
+	if (likely(!is_error)) {
+		void *buf = bvec_virt(&bio->bi_io_vec[0]);
+		struct iov_iter to;
+
+		iov_iter_bvec(&to, ITER_DEST, bio->bi_io_vec + 1, bio->bi_vcnt,
+				len);
+		WARN_ON_ONCE(copy_to_iter(buf, len, &to) != len);
+	} else {
+		/* No need to mark folios dirty if never copied to them */
+		mark_dirty = false;
+	}
+
+	if (bio_flagged(bio, BIO_PAGE_PINNED)) {
+		int i;
+
+		for (i = 0; i < bio->bi_vcnt; i++)
+			bvec_unpin(&bio->bi_io_vec[1 + i], mark_dirty);
+	}
+
+	folio_put(page_folio(bio->bi_io_vec[0].bv_page));
+}
+
+/**
+ * bio_iov_iter_unbounce - finish a bounce buffer operation
+ * @bio:	completed bio
+ * @is_error:	%true if an I/O error occurred and data should not be copied
+ * @mark_dirty:	If %true, folios will be marked dirty.
+ *
+ * Helper for direct I/O implementations that need to bounce buffer because
+ * we need to checksum the data or perform other operations that require
+ * consistency.  Called to complete a bio set up by bio_iov_iter_bounce().
+ * Copies data back for reads, and marks the original folios dirty if
+ * requested and then frees the bounce buffer.
+ */
+void bio_iov_iter_unbounce(struct bio *bio, bool is_error, bool mark_dirty)
+{
+	if (op_is_write(bio_op(bio)))
+		bio_free_folios(bio);
+	else
+		bio_iov_iter_unbounce_read(bio, is_error, mark_dirty);
+}
+
 static void submit_bio_wait_endio(struct bio *bio)
 {
 	complete(bio->bi_private);
diff --git a/include/linux/bio.h b/include/linux/bio.h
index c75a9b3672aa..95cfc79b88b8 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -403,6 +403,29 @@ static inline int bio_iov_vecs_to_alloc(struct iov_iter *iter, int max_segs)
 	return iov_iter_npages(iter, max_segs);
 }
 
+/**
+ * bio_iov_bounce_nr_vecs - calculate number of bvecs for a bounce bio
+ * @iter:	iter to bounce from
+ * @op:		REQ_OP_* for the bio
+ *
+ * Calculates how many bvecs are needed for the next bio to bounce from/to
+ * @iter.
+ */
+static inline unsigned short
+bio_iov_bounce_nr_vecs(struct iov_iter *iter, blk_opf_t op)
+{
+	/*
+	 * We still need to bounce bvec iters, so don't special case them
+	 * here unlike in bio_iov_vecs_to_alloc.
+	 *
+	 * For reads we need to use a vector for the bounce buffer, account
+	 * for that here.
+	 */
+	if (op_is_write(op))
+		return iov_iter_npages(iter, BIO_MAX_VECS);
+	return iov_iter_npages(iter, BIO_MAX_VECS - 1) + 1;
+}
+
 struct request_queue;
 
 void bio_init(struct bio *bio, struct block_device *bdev, struct bio_vec *table,
@@ -456,6 +479,9 @@ void __bio_release_pages(struct bio *bio, bool mark_dirty);
 extern void bio_set_pages_dirty(struct bio *bio);
 extern void bio_check_pages_dirty(struct bio *bio);
 
+int bio_iov_iter_bounce(struct bio *bio, struct iov_iter *iter);
+void bio_iov_iter_unbounce(struct bio *bio, bool is_error, bool mark_dirty);
+
 extern void bio_copy_data_iter(struct bio *dst, struct bvec_iter *dst_iter,
 			       struct bio *src, struct bvec_iter *src_iter);
 extern void bio_copy_data(struct bio *dst, struct bio *src);
-- 
2.47.3


