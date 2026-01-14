Return-Path: <linux-fsdevel+bounces-73627-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DFBCBD1CE8F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 08:43:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8D9D3301C363
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 07:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89EB137A4BC;
	Wed, 14 Jan 2026 07:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XDp/naqA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCF1378D86;
	Wed, 14 Jan 2026 07:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768376548; cv=none; b=ZCWkbJ6c0qleIoV/SkHmSyFV+CyUkwvEh5HziZISI7xOUELmMVqQn1wsZXTltb4TjwECc1AAru8m1HO/iNvkjUhwDAJYp9QHIZ7Pl+d6DM+X4f2tPipvj6VNJGobbd19iVHuDt0o7G9kAJswaV7CmJUz5aWvLQemuy6t23nGq6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768376548; c=relaxed/simple;
	bh=ilO1blNTFcK/f3EBLML+94sfHivNHVLfK3iJAJlXh74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FDSFjou8ibj5Xw1lmbMrrl6JuygDDmmmdAh1bEMpg3d4lyAaKqyIQ4WZ3VSsKje+uGLKqavjuGplak2ODzLwgCtoJtTD3A/kWlMEbLw6+udSN8zm+tahHHvxjO7/Fohc655NeHI+fgKhU+873LBU/83ozUZlMK3zXfpRqVp25+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XDp/naqA; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=bkZdG/0joiMaqcYrlW5T4itbJhEmDhfPUdi5/6vPptM=; b=XDp/naqAjXtqeNEPUI4OAitY6o
	66MKBLsn63vVfRB6mb4Rma1A5Ibg77JjD2J9RFRzR4+L7RJXHNE30peig3H4TelyYutkFLpUSevtA
	7cvyAe13xnQdAcjp07hh7BhhAEbYpFAu76rQDxmsePIm5avygLAN0cYhlo7eFGescihOvjuFzBMD2
	dwCQvhGIBN5+K3lFL7uMs0vW7kqLkfW5n5jkokBmRsToXNW92ry78aiUBN8MjmPGbQtFtz7f214lW
	MxJe3ufJoVIDUoCkPV2AHrOhO/f7i0wwGIcFHV6IHf8NUgm4fTb3Uss8c2Bvp9p4N/R04K6f+50y3
	ubRrvgyg==;
Received: from 85-127-106-146.dsl.dynamic.surfer.at ([85.127.106.146] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfvWF-00000008Drz-2syi;
	Wed, 14 Jan 2026 07:42:20 +0000
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
Date: Wed, 14 Jan 2026 08:41:03 +0100
Message-ID: <20260114074145.3396036-6-hch@lst.de>
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
index 0955fe8b915e..763a5b53688a 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1263,6 +1263,184 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter,
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
index c75a9b3672aa..50e1460cd142 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -403,6 +403,29 @@ static inline int bio_iov_vecs_to_alloc(struct iov_iter *iter, int max_segs)
 	return iov_iter_npages(iter, max_segs);
 }
 
+/**
+ * bio_iov_bounce_nr_vecs - calculate number of bvecs for a boune bio
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


