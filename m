Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8348477E5F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Dec 2021 22:08:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242010AbhLPVIV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Dec 2021 16:08:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235454AbhLPVHY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Dec 2021 16:07:24 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA21C061759;
        Thu, 16 Dec 2021 13:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=9yx1uM3IgMq95UhqybQy+4eLkKdDKXGRUpPaw12iJ9Q=; b=ju6rjF/d1yjj/3tHRJNwSllSRo
        dYK94EWF3eLWYVvV2cnhGDp/odpgJzcbaIbJSyvdTL74dS/ZrlHR+NmM+zlaFKfZSaQgWOLvsJcdw
        5s+ljgkAD13+hPkG7C2YGTfAtGLyXQYgFDtJFPLrQqAjwd+4QrYBlHWy1AYvTRCr8k/htnO/8S7Oo
        FLD6BidvJWcDujrldJm3zKn1Nd1UhEqS+dRp7cBdGOMbauUC3lhTcNNjl4i9TdaOXc3aKkt0dSpGA
        +FpT/ArScSqyN4fzOgmPy0EbimIqX092cTIaKd3c6anX3lOvNhPKlQOgBCz8+aihk0s3P/Yb3HWlC
        wzGeKREQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mxxyB-00Fx38-1v; Thu, 16 Dec 2021 21:07:19 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v3 02/25] block: Add bio_for_each_folio_all()
Date:   Thu, 16 Dec 2021 21:06:52 +0000
Message-Id: <20211216210715.3801857-3-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211216210715.3801857-1-willy@infradead.org>
References: <20211216210715.3801857-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Allow callers to iterate over each folio instead of each page.  The
bio need not have been constructed using folios originally.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Jens Axboe <axboe@kernel.dk>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 Documentation/core-api/kernel-api.rst |  1 +
 include/linux/bio.h                   | 53 ++++++++++++++++++++++++++-
 2 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/Documentation/core-api/kernel-api.rst b/Documentation/core-api/kernel-api.rst
index 2e7186805148..7f0cb604b6ab 100644
--- a/Documentation/core-api/kernel-api.rst
+++ b/Documentation/core-api/kernel-api.rst
@@ -279,6 +279,7 @@ Accounting Framework
 Block Devices
 =============
 
+.. kernel-doc:: include/linux/bio.h
 .. kernel-doc:: block/blk-core.c
    :export:
 
diff --git a/include/linux/bio.h b/include/linux/bio.h
index a783cac49978..e3c9e8207f12 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -166,7 +166,7 @@ static inline void bio_advance(struct bio *bio, unsigned int nbytes)
  */
 #define bio_for_each_bvec_all(bvl, bio, i)		\
 	for (i = 0, bvl = bio_first_bvec_all(bio);	\
-	     i < (bio)->bi_vcnt; i++, bvl++)		\
+	     i < (bio)->bi_vcnt; i++, bvl++)
 
 #define bio_iter_last(bvec, iter) ((iter).bi_size == (bvec).bv_len)
 
@@ -260,6 +260,57 @@ static inline struct bio_vec *bio_last_bvec_all(struct bio *bio)
 	return &bio->bi_io_vec[bio->bi_vcnt - 1];
 }
 
+/**
+ * struct folio_iter - State for iterating all folios in a bio.
+ * @folio: The current folio we're iterating.  NULL after the last folio.
+ * @offset: The byte offset within the current folio.
+ * @length: The number of bytes in this iteration (will not cross folio
+ *	boundary).
+ */
+struct folio_iter {
+	struct folio *folio;
+	size_t offset;
+	size_t length;
+	/* private: for use by the iterator */
+	size_t _seg_count;
+	int _i;
+};
+
+static inline void bio_first_folio(struct folio_iter *fi, struct bio *bio,
+				   int i)
+{
+	struct bio_vec *bvec = bio_first_bvec_all(bio) + i;
+
+	fi->folio = page_folio(bvec->bv_page);
+	fi->offset = bvec->bv_offset +
+			PAGE_SIZE * (bvec->bv_page - &fi->folio->page);
+	fi->_seg_count = bvec->bv_len;
+	fi->length = min(folio_size(fi->folio) - fi->offset, fi->_seg_count);
+	fi->_i = i;
+}
+
+static inline void bio_next_folio(struct folio_iter *fi, struct bio *bio)
+{
+	fi->_seg_count -= fi->length;
+	if (fi->_seg_count) {
+		fi->folio = folio_next(fi->folio);
+		fi->offset = 0;
+		fi->length = min(folio_size(fi->folio), fi->_seg_count);
+	} else if (fi->_i + 1 < bio->bi_vcnt) {
+		bio_first_folio(fi, bio, fi->_i + 1);
+	} else {
+		fi->folio = NULL;
+	}
+}
+
+/**
+ * bio_for_each_folio_all - Iterate over each folio in a bio.
+ * @fi: struct folio_iter which is updated for each folio.
+ * @bio: struct bio to iterate over.
+ */
+#define bio_for_each_folio_all(fi, bio)				\
+	for (bio_first_folio(&fi, bio, 0); fi.folio; bio_next_folio(&fi, bio))
+
 enum bip_flags {
 	BIP_BLOCK_INTEGRITY	= 1 << 0, /* block layer owns integrity data */
 	BIP_MAPPED_INTEGRITY	= 1 << 1, /* ref tag has been remapped */
-- 
2.33.0

