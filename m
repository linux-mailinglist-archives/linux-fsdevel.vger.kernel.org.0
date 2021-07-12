Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3378C3C4261
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 05:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233149AbhGLD6k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Jul 2021 23:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbhGLD6k (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Jul 2021 23:58:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63950C0613DD;
        Sun, 11 Jul 2021 20:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=nR2oa5e93nFAI2YDNXg5bh3xw6tIvBeN/m4O0bgKbkg=; b=l198RB7Ryk+ugCiSv9NKroHe0h
        Oo+Ax+u2HO0oZD+1jDDh/20rkHJpXXkiAI+fcHyJPHhApWl8Xqox6krDRlzf2spNQBo9w/tUhrwE3
        QUHMY3LeLWEUtipIlKpgqwyZtE+0kYnVV31hoyZQoyG+UwhFOHM/A43eRZHzl4yLwoDqeX/QzmIZM
        6fg4+6vwedrzBt1Pq8JbBeZ5XHcgN+tXLi4cUtDMdoRGZmVzegkXMSdKerSPesLylsc4ADPoyypPZ
        T0lNbv+dbyW6266yO3RW6spRWQ/kPRudP6XM599c7S7UQbz6J8I0QyHAYlZ6ApGTiuCQw3/WAPK/T
        87xmdw1Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m2n1j-00Gq6M-Ga; Mon, 12 Jul 2021 03:54:43 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v13 090/137] block: Add bio_for_each_folio_all()
Date:   Mon, 12 Jul 2021 04:06:14 +0100
Message-Id: <20210712030701.4000097-91-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210712030701.4000097-1-willy@infradead.org>
References: <20210712030701.4000097-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Allow callers to iterate over each folio instead of each page.  The
bio need not have been constructed using folios originally.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/bio.h | 43 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/include/linux/bio.h b/include/linux/bio.h
index ade93e2de6a1..d462bbc95c4b 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -189,7 +189,7 @@ static inline void bio_advance_iter_single(const struct bio *bio,
  */
 #define bio_for_each_bvec_all(bvl, bio, i)		\
 	for (i = 0, bvl = bio_first_bvec_all(bio);	\
-	     i < (bio)->bi_vcnt; i++, bvl++)		\
+	     i < (bio)->bi_vcnt; i++, bvl++)
 
 #define bio_iter_last(bvec, iter) ((iter).bi_size == (bvec).bv_len)
 
@@ -314,6 +314,47 @@ static inline struct bio_vec *bio_last_bvec_all(struct bio *bio)
 	return &bio->bi_io_vec[bio->bi_vcnt - 1];
 }
 
+struct folio_iter {
+	struct folio *folio;
+	size_t offset;
+	size_t length;
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
+/*
+ * Iterate over each folio in a bio.
+ */
+#define bio_for_each_folio_all(fi, bio)				\
+	for (bio_first_folio(&fi, bio, 0); fi.folio; bio_next_folio(&fi, bio))
+
 enum bip_flags {
 	BIP_BLOCK_INTEGRITY	= 1 << 0, /* block layer owns integrity data */
 	BIP_MAPPED_INTEGRITY	= 1 << 1, /* ref tag has been remapped */
-- 
2.30.2

