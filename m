Return-Path: <linux-fsdevel+bounces-3494-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C2B7F5489
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Nov 2023 00:28:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 788E22816DC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 23:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED8621370;
	Wed, 22 Nov 2023 23:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qVPKJqdS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [IPv6:2001:41d0:1004:224b::ac])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84DC8199
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Nov 2023 15:28:27 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1700695706;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nSlVHS2FqUDkgyXo8OaH+PY2FOlXv5QWatX7YM/6Q4M=;
	b=qVPKJqdStYw4Ss1jbKZes2vyG4pZXgI2lNLp7xNrCUpaVC3bpHsBTZjODf1wvrLTNnYJqi
	GHcrE6OfVJKnD4Qcpkpi7BRDCr9g4N1WJf2LY1YWyIFDmDBHPJIMVzA+mzlMQJfe1wljoU
	5fNiK3w8CIm0gE4PhQUakpFdQGSuv18=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: axboe@kernel.dk,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 2/3] block: Rework bio_for_each_folio_all(), add bio_for_each_folio()
Date: Wed, 22 Nov 2023 18:28:14 -0500
Message-ID: <20231122232818.178256-2-kent.overstreet@linux.dev>
In-Reply-To: <20231122232818.178256-1-kent.overstreet@linux.dev>
References: <20231122232818.178256-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This reimplements bio_for_each_folio_all() on top of the newly-reworked
bvec_iter_all, and adds a new common helper biovec_to_foliovec() for
both bio_for_each_folio_all() and bio_for_each_folio().

This allows bcachefs's private bio_for_each_folio() to be dropped.

Cc: Matthew Wilcox <willy@infradead.org>
Cc: linux-block@vger.kernel.org
Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 drivers/md/dm-crypt.c        | 13 +++---
 drivers/md/dm-flakey.c       |  7 +--
 fs/bcachefs/fs-io-buffered.c | 38 ++++++++-------
 fs/bcachefs/fs-io.h          | 43 -----------------
 fs/crypto/bio.c              |  9 ++--
 fs/ext4/page-io.c            | 11 +++--
 fs/ext4/readpage.c           |  7 +--
 fs/iomap/buffered-io.c       | 14 +++---
 fs/mpage.c                   | 22 +++++----
 fs/verity/verify.c           |  7 +--
 include/linux/bio.h          | 91 ++++++++++++++++++------------------
 include/linux/bvec.h         | 15 ++++--
 12 files changed, 127 insertions(+), 150 deletions(-)

diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index 2ae8560b6a14..adc130e158cd 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -1737,16 +1737,17 @@ static struct bio *crypt_alloc_buffer(struct dm_crypt_io *io, unsigned int size)
 
 static void crypt_free_buffer_pages(struct crypt_config *cc, struct bio *clone)
 {
-	struct folio_iter fi;
+	struct bvec_iter_all iter;
+	struct folio_vec fv;
 
 	if (clone->bi_vcnt > 0) { /* bio_for_each_folio_all crashes with an empty bio */
-		bio_for_each_folio_all(fi, clone) {
-			if (folio_test_large(fi.folio)) {
+		bio_for_each_folio_all(fv, clone, iter) {
+			if (folio_test_large(fv.fv_folio)) {
 				percpu_counter_sub(&cc->n_allocated_pages,
-						1 << folio_order(fi.folio));
-				folio_put(fi.folio);
+						1 << folio_order(fv.fv_folio));
+				folio_put(fv.fv_folio);
 			} else {
-				mempool_free(&fi.folio->page, &cc->page_pool);
+				mempool_free(&fv.fv_folio->page, &cc->page_pool);
 			}
 		}
 	}
diff --git a/drivers/md/dm-flakey.c b/drivers/md/dm-flakey.c
index 120153e44ae0..906cb2c66945 100644
--- a/drivers/md/dm-flakey.c
+++ b/drivers/md/dm-flakey.c
@@ -391,11 +391,12 @@ static void corrupt_bio_random(struct bio *bio)
 
 static void clone_free(struct bio *clone)
 {
-	struct folio_iter fi;
+	struct bvec_iter_all iter;
+	struct folio_vec fv;
 
 	if (clone->bi_vcnt > 0) { /* bio_for_each_folio_all crashes with an empty bio */
-		bio_for_each_folio_all(fi, clone)
-			folio_put(fi.folio);
+		bio_for_each_folio_all(fv, clone, iter)
+			folio_put(fv.fv_folio);
 	}
 
 	bio_uninit(clone);
diff --git a/fs/bcachefs/fs-io-buffered.c b/fs/bcachefs/fs-io-buffered.c
index 52f0e7acda3d..021308492766 100644
--- a/fs/bcachefs/fs-io-buffered.c
+++ b/fs/bcachefs/fs-io-buffered.c
@@ -28,16 +28,17 @@ static inline bool bio_full(struct bio *bio, unsigned len)
 
 static void bch2_readpages_end_io(struct bio *bio)
 {
-	struct folio_iter fi;
+	struct bvec_iter_all iter;
+	struct folio_vec fv;
 
-	bio_for_each_folio_all(fi, bio) {
+	bio_for_each_folio_all(fv, bio, iter) {
 		if (!bio->bi_status) {
-			folio_mark_uptodate(fi.folio);
+			folio_mark_uptodate(fv.fv_folio);
 		} else {
-			folio_clear_uptodate(fi.folio);
-			folio_set_error(fi.folio);
+			folio_clear_uptodate(fv.fv_folio);
+			folio_set_error(fv.fv_folio);
 		}
-		folio_unlock(fi.folio);
+		folio_unlock(fv.fv_folio);
 	}
 
 	bio_put(bio);
@@ -410,33 +411,34 @@ static void bch2_writepage_io_done(struct bch_write_op *op)
 		container_of(op, struct bch_writepage_io, op);
 	struct bch_fs *c = io->op.c;
 	struct bio *bio = &io->op.wbio.bio;
-	struct folio_iter fi;
+	struct bvec_iter_all iter;
+	struct folio_vec fv;
 	unsigned i;
 
 	if (io->op.error) {
 		set_bit(EI_INODE_ERROR, &io->inode->ei_flags);
 
-		bio_for_each_folio_all(fi, bio) {
+		bio_for_each_folio_all(fv, bio, iter) {
 			struct bch_folio *s;
 
-			folio_set_error(fi.folio);
-			mapping_set_error(fi.folio->mapping, -EIO);
+			folio_set_error(fv.fv_folio);
+			mapping_set_error(fv.fv_folio->mapping, -EIO);
 
-			s = __bch2_folio(fi.folio);
+			s = __bch2_folio(fv.fv_folio);
 			spin_lock(&s->lock);
-			for (i = 0; i < folio_sectors(fi.folio); i++)
+			for (i = 0; i < folio_sectors(fv.fv_folio); i++)
 				s->s[i].nr_replicas = 0;
 			spin_unlock(&s->lock);
 		}
 	}
 
 	if (io->op.flags & BCH_WRITE_WROTE_DATA_INLINE) {
-		bio_for_each_folio_all(fi, bio) {
+		bio_for_each_folio_all(fv, bio, iter) {
 			struct bch_folio *s;
 
-			s = __bch2_folio(fi.folio);
+			s = __bch2_folio(fv.fv_folio);
 			spin_lock(&s->lock);
-			for (i = 0; i < folio_sectors(fi.folio); i++)
+			for (i = 0; i < folio_sectors(fv.fv_folio); i++)
 				s->s[i].nr_replicas = 0;
 			spin_unlock(&s->lock);
 		}
@@ -461,11 +463,11 @@ static void bch2_writepage_io_done(struct bch_write_op *op)
 	 */
 	bch2_i_sectors_acct(c, io->inode, NULL, io->op.i_sectors_delta);
 
-	bio_for_each_folio_all(fi, bio) {
-		struct bch_folio *s = __bch2_folio(fi.folio);
+	bio_for_each_folio_all(fv, bio, iter) {
+		struct bch_folio *s = __bch2_folio(fv.fv_folio);
 
 		if (atomic_dec_and_test(&s->write_count))
-			folio_end_writeback(fi.folio);
+			folio_end_writeback(fv.fv_folio);
 	}
 
 	bio_put(&io->op.wbio.bio);
diff --git a/fs/bcachefs/fs-io.h b/fs/bcachefs/fs-io.h
index ca70346e68dc..8c618b3df8dc 100644
--- a/fs/bcachefs/fs-io.h
+++ b/fs/bcachefs/fs-io.h
@@ -11,49 +11,6 @@
 
 #include <linux/uio.h>
 
-struct folio_vec {
-	struct folio	*fv_folio;
-	size_t		fv_offset;
-	size_t		fv_len;
-};
-
-static inline struct folio_vec biovec_to_foliovec(struct bio_vec bv)
-{
-
-	struct folio *folio	= page_folio(bv.bv_page);
-	size_t offset		= (folio_page_idx(folio, bv.bv_page) << PAGE_SHIFT) +
-		bv.bv_offset;
-	size_t len = min_t(size_t, folio_size(folio) - offset, bv.bv_len);
-
-	return (struct folio_vec) {
-		.fv_folio	= folio,
-		.fv_offset	= offset,
-		.fv_len		= len,
-	};
-}
-
-static inline struct folio_vec bio_iter_iovec_folio(struct bio *bio,
-						    struct bvec_iter iter)
-{
-	return biovec_to_foliovec(bio_iter_iovec(bio, iter));
-}
-
-#define __bio_for_each_folio(bvl, bio, iter, start)			\
-	for (iter = (start);						\
-	     (iter).bi_size &&						\
-		((bvl = bio_iter_iovec_folio((bio), (iter))), 1);	\
-	     bio_advance_iter_single((bio), &(iter), (bvl).fv_len))
-
-/**
- * bio_for_each_folio - iterate over folios within a bio
- *
- * Like other non-_all versions, this iterates over what bio->bi_iter currently
- * points to. This version is for drivers, where the bio may have previously
- * been split or cloned.
- */
-#define bio_for_each_folio(bvl, bio, iter)				\
-	__bio_for_each_folio(bvl, bio, iter, (bio)->bi_iter)
-
 struct quota_res {
 	u64				sectors;
 };
diff --git a/fs/crypto/bio.c b/fs/crypto/bio.c
index 0ad8c30b8fa5..5cfc146c68b6 100644
--- a/fs/crypto/bio.c
+++ b/fs/crypto/bio.c
@@ -30,11 +30,12 @@
  */
 bool fscrypt_decrypt_bio(struct bio *bio)
 {
-	struct folio_iter fi;
+	struct bvec_iter_all iter;
+	struct folio_vec fv;
 
-	bio_for_each_folio_all(fi, bio) {
-		int err = fscrypt_decrypt_pagecache_blocks(fi.folio, fi.length,
-							   fi.offset);
+	bio_for_each_folio_all(fv, bio, iter) {
+		int err = fscrypt_decrypt_pagecache_blocks(fv.fv_folio, fv.fv_len,
+							   fv.fv_offset);
 
 		if (err) {
 			bio->bi_status = errno_to_blk_status(err);
diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
index dfdd7e5cf038..c5938b3e8825 100644
--- a/fs/ext4/page-io.c
+++ b/fs/ext4/page-io.c
@@ -99,14 +99,15 @@ static void buffer_io_error(struct buffer_head *bh)
 
 static void ext4_finish_bio(struct bio *bio)
 {
-	struct folio_iter fi;
+	struct bvec_iter_all iter;
+	struct folio_vec fv;
 
-	bio_for_each_folio_all(fi, bio) {
-		struct folio *folio = fi.folio;
+	bio_for_each_folio_all(fv, bio, iter) {
+		struct folio *folio = fv.fv_folio;
 		struct folio *io_folio = NULL;
 		struct buffer_head *bh, *head;
-		size_t bio_start = fi.offset;
-		size_t bio_end = bio_start + fi.length;
+		size_t bio_start = fv.fv_offset;
+		size_t bio_end = bio_start + fv.fv_len;
 		unsigned under_io = 0;
 		unsigned long flags;
 
diff --git a/fs/ext4/readpage.c b/fs/ext4/readpage.c
index 21e8f0aebb3c..14b67ba01fbe 100644
--- a/fs/ext4/readpage.c
+++ b/fs/ext4/readpage.c
@@ -68,10 +68,11 @@ struct bio_post_read_ctx {
 
 static void __read_end_io(struct bio *bio)
 {
-	struct folio_iter fi;
+	struct bvec_iter_all iter;
+	struct folio_vec fv;
 
-	bio_for_each_folio_all(fi, bio)
-		folio_end_read(fi.folio, bio->bi_status == 0);
+	bio_for_each_folio_all(fv, bio, iter)
+		folio_end_read(fv.fv_folio, bio->bi_status == 0);
 	if (bio->bi_private)
 		mempool_free(bio->bi_private, bio_post_read_ctx_pool);
 	bio_put(bio);
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 3356df4d8fb9..83615117ece2 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -277,10 +277,11 @@ static void iomap_finish_folio_read(struct folio *folio, size_t off,
 static void iomap_read_end_io(struct bio *bio)
 {
 	int error = blk_status_to_errno(bio->bi_status);
-	struct folio_iter fi;
+	struct bvec_iter_all iter;
+	struct folio_vec fv;
 
-	bio_for_each_folio_all(fi, bio)
-		iomap_finish_folio_read(fi.folio, fi.offset, fi.length, error);
+	bio_for_each_folio_all(fv, bio, iter)
+		iomap_finish_folio_read(fv.fv_folio, fv.fv_offset, fv.fv_len, error);
 	bio_put(bio);
 }
 
@@ -1514,7 +1515,8 @@ iomap_finish_ioend(struct iomap_ioend *ioend, int error)
 	u32 folio_count = 0;
 
 	for (bio = &ioend->io_inline_bio; bio; bio = next) {
-		struct folio_iter fi;
+		struct bvec_iter_all iter;
+		struct folio_vec fv;
 
 		/*
 		 * For the last bio, bi_private points to the ioend, so we
@@ -1526,8 +1528,8 @@ iomap_finish_ioend(struct iomap_ioend *ioend, int error)
 			next = bio->bi_private;
 
 		/* walk all folios in bio, ending page IO on them */
-		bio_for_each_folio_all(fi, bio) {
-			iomap_finish_folio_write(inode, fi.folio, fi.length,
+		bio_for_each_folio_all(fv, bio, iter) {
+			iomap_finish_folio_write(inode, fv.fv_folio, fv.fv_len,
 					error);
 			folio_count++;
 		}
diff --git a/fs/mpage.c b/fs/mpage.c
index ffb064ed9d04..0196edf9a684 100644
--- a/fs/mpage.c
+++ b/fs/mpage.c
@@ -45,15 +45,16 @@
  */
 static void mpage_read_end_io(struct bio *bio)
 {
-	struct folio_iter fi;
+	struct bvec_iter_all iter;
+	struct folio_vec fv;
 	int err = blk_status_to_errno(bio->bi_status);
 
-	bio_for_each_folio_all(fi, bio) {
+	bio_for_each_folio_all(fv, bio, iter) {
 		if (err)
-			folio_set_error(fi.folio);
+			folio_set_error(fv.fv_folio);
 		else
-			folio_mark_uptodate(fi.folio);
-		folio_unlock(fi.folio);
+			folio_mark_uptodate(fv.fv_folio);
+		folio_unlock(fv.fv_folio);
 	}
 
 	bio_put(bio);
@@ -61,15 +62,16 @@ static void mpage_read_end_io(struct bio *bio)
 
 static void mpage_write_end_io(struct bio *bio)
 {
-	struct folio_iter fi;
+	struct bvec_iter_all iter;
+	struct folio_vec fv;
 	int err = blk_status_to_errno(bio->bi_status);
 
-	bio_for_each_folio_all(fi, bio) {
+	bio_for_each_folio_all(fv, bio, iter) {
 		if (err) {
-			folio_set_error(fi.folio);
-			mapping_set_error(fi.folio->mapping, err);
+			folio_set_error(fv.fv_folio);
+			mapping_set_error(fv.fv_folio->mapping, err);
 		}
-		folio_end_writeback(fi.folio);
+		folio_end_writeback(fv.fv_folio);
 	}
 
 	bio_put(bio);
diff --git a/fs/verity/verify.c b/fs/verity/verify.c
index 904ccd7e8e16..8d444b1c546d 100644
--- a/fs/verity/verify.c
+++ b/fs/verity/verify.c
@@ -307,7 +307,8 @@ EXPORT_SYMBOL_GPL(fsverity_verify_blocks);
  */
 void fsverity_verify_bio(struct bio *bio)
 {
-	struct folio_iter fi;
+	struct bvec_iter_all iter;
+	struct folio_vec fv;
 	unsigned long max_ra_pages = 0;
 
 	if (bio->bi_opf & REQ_RAHEAD) {
@@ -323,8 +324,8 @@ void fsverity_verify_bio(struct bio *bio)
 		max_ra_pages = bio->bi_iter.bi_size >> (PAGE_SHIFT + 2);
 	}
 
-	bio_for_each_folio_all(fi, bio) {
-		if (!verify_data_blocks(fi.folio, fi.length, fi.offset,
+	bio_for_each_folio_all(fv, bio, iter) {
+		if (!verify_data_blocks(fv.fv_folio, fv.fv_len, fv.fv_offset,
 					max_ra_pages)) {
 			bio->bi_status = BLK_STS_IOERR;
 			break;
diff --git a/include/linux/bio.h b/include/linux/bio.h
index a251859f1b66..eaaf7e5f0d54 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -169,6 +169,42 @@ static inline void bio_advance(struct bio *bio, unsigned int nbytes)
 #define bio_for_each_segment(bvl, bio, iter)				\
 	__bio_for_each_segment(bvl, bio, iter, (bio)->bi_iter)
 
+struct folio_vec {
+	struct folio	*fv_folio;
+	size_t		fv_offset;
+	size_t		fv_len;
+};
+
+static inline struct folio_vec biovec_to_foliovec(struct bio_vec bv)
+{
+
+	struct folio *folio	= page_folio(bv.bv_page);
+	size_t offset		= (folio_page_idx(folio, bv.bv_page) << PAGE_SHIFT) +
+		bv.bv_offset;
+	size_t len = min_t(size_t, folio_size(folio) - offset, bv.bv_len);
+
+	return (struct folio_vec) {
+		.fv_folio	= folio,
+		.fv_offset	= offset,
+		.fv_len		= len,
+	};
+}
+
+static inline struct folio_vec bio_iter_iovec_folio(struct bio *bio,
+						    struct bvec_iter iter)
+{
+	return biovec_to_foliovec(bio_iter_iovec(bio, iter));
+}
+
+#define __bio_for_each_folio(bvl, bio, iter, start)			\
+	for (iter = (start);						\
+	     (iter).bi_size &&						\
+		((bvl = bio_iter_iovec_folio((bio), (iter))), 1);	\
+	     bio_advance_iter_single((bio), &(iter), (bvl).fv_len))
+
+#define bio_for_each_folio(bvl, bio, iter)				\
+	__bio_for_each_folio(bvl, bio, iter, (bio)->bi_iter)
+
 #define __bio_for_each_bvec(bvl, bio, iter, start)		\
 	for (iter = (start);						\
 	     (iter).bi_size &&						\
@@ -282,59 +318,22 @@ static inline struct bio_vec *bio_last_bvec_all(struct bio *bio)
 	return &bio->bi_io_vec[bio->bi_vcnt - 1];
 }
 
-/**
- * struct folio_iter - State for iterating all folios in a bio.
- * @folio: The current folio we're iterating.  NULL after the last folio.
- * @offset: The byte offset within the current folio.
- * @length: The number of bytes in this iteration (will not cross folio
- *	boundary).
- */
-struct folio_iter {
-	struct folio *folio;
-	size_t offset;
-	size_t length;
-	/* private: for use by the iterator */
-	struct folio *_next;
-	size_t _seg_count;
-	int _i;
-};
-
-static inline void bio_first_folio(struct folio_iter *fi, struct bio *bio,
-				   int i)
-{
-	struct bio_vec *bvec = bio_first_bvec_all(bio) + i;
-
-	fi->folio = page_folio(bvec->bv_page);
-	fi->offset = bvec->bv_offset +
-			PAGE_SIZE * (bvec->bv_page - &fi->folio->page);
-	fi->_seg_count = bvec->bv_len;
-	fi->length = min(folio_size(fi->folio) - fi->offset, fi->_seg_count);
-	fi->_next = folio_next(fi->folio);
-	fi->_i = i;
-}
-
-static inline void bio_next_folio(struct folio_iter *fi, struct bio *bio)
+static inline struct folio_vec bio_folio_iter_all_peek(const struct bio *bio,
+						       const struct bvec_iter_all *iter)
 {
-	fi->_seg_count -= fi->length;
-	if (fi->_seg_count) {
-		fi->folio = fi->_next;
-		fi->offset = 0;
-		fi->length = min(folio_size(fi->folio), fi->_seg_count);
-		fi->_next = folio_next(fi->folio);
-	} else if (fi->_i + 1 < bio->bi_vcnt) {
-		bio_first_folio(fi, bio, fi->_i + 1);
-	} else {
-		fi->folio = NULL;
-	}
+	return biovec_to_foliovec(__bvec_iter_all_peek(bio->bi_io_vec, iter));
 }
 
 /**
  * bio_for_each_folio_all - Iterate over each folio in a bio.
- * @fi: struct folio_iter which is updated for each folio.
+ * @fi: struct bio_folio_iter_all which is updated for each folio.
  * @bio: struct bio to iterate over.
  */
-#define bio_for_each_folio_all(fi, bio)				\
-	for (bio_first_folio(&fi, bio, 0); fi.folio; bio_next_folio(&fi, bio))
+#define bio_for_each_folio_all(fv, bio, iter)				\
+	for (bvec_iter_all_init(&iter);					\
+	     iter.idx < bio->bi_vcnt &&					\
+		((fv = bio_folio_iter_all_peek(bio, &iter)), true);	\
+	     bio_iter_all_advance((bio), &iter, fv.fv_len))
 
 enum bip_flags {
 	BIP_BLOCK_INTEGRITY	= 1 << 0, /* block layer owns integrity data */
diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index 635fb5414321..d238f959e36c 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -205,18 +205,27 @@ static inline void bvec_iter_all_init(struct bvec_iter_all *iter_all)
 	iter_all->idx = 0;
 }
 
-static inline struct bio_vec bvec_iter_all_peek(const struct bio_vec *bvec,
-						struct bvec_iter_all *iter)
+static inline struct bio_vec __bvec_iter_all_peek(const struct bio_vec *bvec,
+						  const struct bvec_iter_all *iter)
 {
 	struct bio_vec bv = bvec[iter->idx];
 
+	BUG_ON(iter->done >= bv.bv_len);
+
 	bv.bv_offset	+= iter->done;
 	bv.bv_len	-= iter->done;
 
 	bv.bv_page	+= bv.bv_offset >> PAGE_SHIFT;
 	bv.bv_offset	&= ~PAGE_MASK;
-	bv.bv_len	= min_t(unsigned, PAGE_SIZE - bv.bv_offset, bv.bv_len);
+	return bv;
+}
+
+static inline struct bio_vec bvec_iter_all_peek(const struct bio_vec *bvec,
+						const struct bvec_iter_all *iter)
+{
+	struct bio_vec bv = __bvec_iter_all_peek(bvec, iter);
 
+	bv.bv_len = min_t(unsigned, PAGE_SIZE - bv.bv_offset, bv.bv_len);
 	return bv;
 }
 
-- 
2.42.0


