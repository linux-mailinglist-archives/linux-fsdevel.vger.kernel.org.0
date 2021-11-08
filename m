Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5F7544795B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Nov 2021 05:26:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237439AbhKHE3C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 7 Nov 2021 23:29:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234867AbhKHE3B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 7 Nov 2021 23:29:01 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72249C061570;
        Sun,  7 Nov 2021 20:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=WY6kzfOOoEWe6Ipqka3nGQ4VS7/xg01EduApj6vUHxI=; b=ei0+4reeZ5Q3XiJhdhd8KLWA5W
        CGPXjj5gFIWx/sAV2I/PwR+POTMJujRf43MVlDApbSdVbxt6PbVoKUwTlXeWVJKLA84GClGgB2NdQ
        1408pVCQYetXbLxgJyWKyigKOP9hCpxhmUPjrKv3s4qpwVpTV2z34TN+SGBPOTcuXq6p6B0RUeunt
        kMBsjltM/hEylhEJI0cL/E5Qbt9mOxp4fJ9w55TBUbBj4J7Pw3TtZe2P+yiC9d7XxMXfVm/bLv4WS
        gWL5cI13m2PuCRaDBzIs243n/gyw781EIvbsZ5JYSR+ui+maAItcByciDM/DRqT+obiFH6kMACpI1
        86PcxAjA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mjw9L-0089oU-5Q; Mon, 08 Nov 2021 04:21:33 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     "Darrick J . Wong " <djwong@kernel.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 06/28] block: Add bio_for_each_folio_all()
Date:   Mon,  8 Nov 2021 04:05:29 +0000
Message-Id: <20211108040551.1942823-7-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211108040551.1942823-1-willy@infradead.org>
References: <20211108040551.1942823-1-willy@infradead.org>
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

