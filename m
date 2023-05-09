Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3DCC6FCC06
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 May 2023 18:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235107AbjEIQ6k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 May 2023 12:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234876AbjEIQ6E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 May 2023 12:58:04 -0400
Received: from out-3.mta1.migadu.com (out-3.mta1.migadu.com [95.215.58.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E5024EFC
        for <linux-fsdevel@vger.kernel.org>; Tue,  9 May 2023 09:57:24 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1683651443;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vmriaVgD/FyMiWTB+roCgu5nb9HM588jx+szztY1PGY=;
        b=Y8cJ4uv28KMitwKkI+rMDqec7BQ2sqWlk0uW6vvAlG9jpKl1sie9uI9aDFHiFVb13u6wND
        clc46Jy46U5eEEXSGiLDH/Y7ZmJRRCvaF1kF5jdMQUo8DDKWHlDC3UIxIbGMs6goGBumcG
        BFSx62tvZjG0iuHHX2esbeVWEw0JrYU=
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@linux.dev>,
        Matthew Wilcox <willy@infradead.org>,
        linux-block@vger.kernel.org
Subject: [PATCH 13/32] block: Rework bio_for_each_folio_all()
Date:   Tue,  9 May 2023 12:56:38 -0400
Message-Id: <20230509165657.1735798-14-kent.overstreet@linux.dev>
In-Reply-To: <20230509165657.1735798-1-kent.overstreet@linux.dev>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This reimplements bio_for_each_folio_all() on top of the newly-reworked
bvec_iter_all, and since it's now trivial we also provide
bio_for_each_folio.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: linux-block@vger.kernel.org
---
 fs/crypto/bio.c        |  9 +++--
 fs/iomap/buffered-io.c | 14 ++++---
 fs/verity/verify.c     |  9 +++--
 include/linux/bio.h    | 91 +++++++++++++++++++++---------------------
 include/linux/bvec.h   | 15 +++++--
 5 files changed, 75 insertions(+), 63 deletions(-)

diff --git a/fs/crypto/bio.c b/fs/crypto/bio.c
index d57d0a020f..6469861add 100644
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
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 6f4c97a6d7..60661c87d5 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -187,10 +187,11 @@ static void iomap_finish_folio_read(struct folio *folio, size_t offset,
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
 
@@ -1328,7 +1329,8 @@ iomap_finish_ioend(struct iomap_ioend *ioend, int error)
 	u32 folio_count = 0;
 
 	for (bio = &ioend->io_inline_bio; bio; bio = next) {
-		struct folio_iter fi;
+		struct bvec_iter_all iter;
+		struct folio_vec fv;
 
 		/*
 		 * For the last bio, bi_private points to the ioend, so we
@@ -1340,8 +1342,8 @@ iomap_finish_ioend(struct iomap_ioend *ioend, int error)
 			next = bio->bi_private;
 
 		/* walk all folios in bio, ending page IO on them */
-		bio_for_each_folio_all(fi, bio) {
-			iomap_finish_folio_write(inode, fi.folio, fi.length,
+		bio_for_each_folio_all(fv, bio, iter) {
+			iomap_finish_folio_write(inode, fv.fv_folio, fv.fv_len,
 					error);
 			folio_count++;
 		}
diff --git a/fs/verity/verify.c b/fs/verity/verify.c
index e250822275..b111ab0102 100644
--- a/fs/verity/verify.c
+++ b/fs/verity/verify.c
@@ -340,7 +340,8 @@ void fsverity_verify_bio(struct bio *bio)
 	struct inode *inode = bio_first_page_all(bio)->mapping->host;
 	struct fsverity_info *vi = inode->i_verity_info;
 	struct ahash_request *req;
-	struct folio_iter fi;
+	struct bvec_iter_all iter;
+	struct folio_vec fv;
 	unsigned long max_ra_pages = 0;
 
 	/* This allocation never fails, since it's mempool-backed. */
@@ -359,9 +360,9 @@ void fsverity_verify_bio(struct bio *bio)
 		max_ra_pages = bio->bi_iter.bi_size >> (PAGE_SHIFT + 2);
 	}
 
-	bio_for_each_folio_all(fi, bio) {
-		if (!verify_data_blocks(inode, vi, req, fi.folio, fi.length,
-					fi.offset, max_ra_pages)) {
+	bio_for_each_folio_all(fv, bio, iter) {
+		if (!verify_data_blocks(inode, vi, req, fv.fv_folio, fv.fv_len,
+					fv.fv_offset, max_ra_pages)) {
 			bio->bi_status = BLK_STS_IOERR;
 			break;
 		}
diff --git a/include/linux/bio.h b/include/linux/bio.h
index f86c7190c3..7ced281734 100644
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
@@ -277,59 +313,22 @@ static inline struct bio_vec *bio_last_bvec_all(struct bio *bio)
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
index 635fb54143..d238f959e3 100644
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
2.40.1

