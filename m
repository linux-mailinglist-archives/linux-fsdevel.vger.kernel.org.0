Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38DF03CEF28
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 00:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382913AbhGSVbq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jul 2021 17:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350119AbhGSSF5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jul 2021 14:05:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B5FFC0613EF;
        Mon, 19 Jul 2021 11:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=zCf/+WAt5kl+bvMl9m+HufeShSb0v0zgYzCTuNOFtYg=; b=Umasx1i81sMBjUJVKN9cC0afgY
        lhrSYnm7IglhzP/2Y1Mq08lwm8fTV163MBtkXyFylN8FanM9CL60jNeSnyxpfPgf0vqv7yAoA1sec
        fj8VNTXZBUDZb4pt9y/SK2frJCQ25fL+L4SztXnZdYFxHy7BqO8rkWsOxc2WpLJKX7jgaTQyQa+lY
        /5M1ByspktSe+/rNftsokYIvN1ilmnpL4Pdudf+Mh6FdFJjedJ8vXAFgrRW7N/LQpS2FA6btVcLtm
        jKNNubcEfJrU0iIFsiDkVp+2/geTv4wlVrtL1G4AJ3l9EI74WPmzI/t2p+s0iK9oWHS8aXESCFDjH
        8lYr8/3g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m5YCM-007LUk-PC; Mon, 19 Jul 2021 18:41:17 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-block@vger.kernel.org
Subject: [PATCH v15 02/17] block: Add bio_for_each_folio_all()
Date:   Mon, 19 Jul 2021 19:39:46 +0100
Message-Id: <20210719184001.1750630-3-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210719184001.1750630-1-willy@infradead.org>
References: <20210719184001.1750630-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Allow callers to iterate over each folio instead of each page.  The
bio need not have been constructed using folios originally.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 Documentation/core-api/kernel-api.rst |  1 +
 include/linux/bio.h                   | 53 ++++++++++++++++++++++++++-
 2 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/Documentation/core-api/kernel-api.rst b/Documentation/core-api/kernel-api.rst
index 2a7444e3a4c2..b804605f705e 100644
--- a/Documentation/core-api/kernel-api.rst
+++ b/Documentation/core-api/kernel-api.rst
@@ -279,6 +279,7 @@ Accounting Framework
 Block Devices
 =============
 
+.. kernel-doc:: include/linux/bio.h
 .. kernel-doc:: block/blk-core.c
    :export:
 
diff --git a/include/linux/bio.h b/include/linux/bio.h
index ade93e2de6a1..a90a79ad7bd1 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -189,7 +189,7 @@ static inline void bio_advance_iter_single(const struct bio *bio,
  */
 #define bio_for_each_bvec_all(bvl, bio, i)		\
 	for (i = 0, bvl = bio_first_bvec_all(bio);	\
-	     i < (bio)->bi_vcnt; i++, bvl++)		\
+	     i < (bio)->bi_vcnt; i++, bvl++)
 
 #define bio_iter_last(bvec, iter) ((iter).bi_size == (bvec).bv_len)
 
@@ -314,6 +314,57 @@ static inline struct bio_vec *bio_last_bvec_all(struct bio *bio)
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
+static inline
+void bio_first_folio(struct folio_iter *fi, struct bio *bio, int i)
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
2.30.2

