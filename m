Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 919A51F5CDC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jun 2020 22:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730920AbgFJURA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jun 2020 16:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730538AbgFJUNt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jun 2020 16:13:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B93FC08C5C1;
        Wed, 10 Jun 2020 13:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Nm4e+jFJPwTorBmgbzzcocpiWsS+VJ//sRHdCySBlWE=; b=GALygLUc1KauPQ2HJMEuNvYE6Q
        ce7q96xbsj5KD/sjyR8fyip6MN1E2b723YDlEl0u/ZS0CJHj0iP7YyI1b2b0Anr19eipwud+IEFNb
        R7H8dTDxB70aead3m4fp2UDTZ3r9n+dEazPZKpm1n6QP4gTCj4icZJyV8Q5cqI4UZEXVo1J4qMbi/
        XyPDOppf6DtTLTmqSljpz/ay7jeXhBuFZmw49sfZotYJj2T5YRFTbjP/ftsFAg8vbEAmdXirFzLOR
        U3Qi0lDelVVIBV5QGh48CcHyHcHLEBGoe9eDU5HV/jdkWyebQPjO0ZA4f5xX/X9LCtEZ/qf39aKiW
        BiF/N9Dw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jj76a-0003Uw-0V; Wed, 10 Jun 2020 20:13:48 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 20/51] block: Add bio_for_each_thp_segment_all
Date:   Wed, 10 Jun 2020 13:13:14 -0700
Message-Id: <20200610201345.13273-21-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200610201345.13273-1-willy@infradead.org>
References: <20200610201345.13273-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Iterate once for each THP instead of once for each base page.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/bio.h  | 13 +++++++++++++
 include/linux/bvec.h | 23 +++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/include/linux/bio.h b/include/linux/bio.h
index 91676d4b2dfe..1489e196abf5 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -131,12 +131,25 @@ static inline bool bio_next_segment(const struct bio *bio,
 	return true;
 }
 
+static inline bool bio_next_thp_segment(const struct bio *bio,
+				    struct bvec_iter_all *iter)
+{
+	if (iter->idx >= bio->bi_vcnt)
+		return false;
+
+	bvec_thp_advance(&bio->bi_io_vec[iter->idx], iter);
+	return true;
+}
+
 /*
  * drivers should _never_ use the all version - the bio may have been split
  * before it got to the driver and the driver won't own all of it
  */
 #define bio_for_each_segment_all(bvl, bio, iter) \
 	for (bvl = bvec_init_iter_all(&iter); bio_next_segment((bio), &iter); )
+#define bio_for_each_thp_segment_all(bvl, bio, iter) \
+	for (bvl = bvec_init_iter_all(&iter); \
+	     bio_next_thp_segment((bio), &iter); )
 
 static inline void bio_advance_iter(const struct bio *bio,
 				    struct bvec_iter *iter, unsigned int bytes)
diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index ac0c7299d5b8..71b435e573e1 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -162,4 +162,27 @@ static inline void bvec_advance(const struct bio_vec *bvec,
 	}
 }
 
+static inline void bvec_thp_advance(const struct bio_vec *bvec,
+				struct bvec_iter_all *iter_all)
+{
+	struct bio_vec *bv = &iter_all->bv;
+	unsigned int page_size = thp_size(bvec->bv_page);
+
+	if (iter_all->done) {
+		bv->bv_page += thp_nr_pages(bv->bv_page);
+		bv->bv_offset = 0;
+	} else {
+		BUG_ON(bvec->bv_offset >= page_size);
+		bv->bv_page = bvec->bv_page;
+		bv->bv_offset = bvec->bv_offset & (page_size - 1);
+	}
+	bv->bv_len = min(page_size - bv->bv_offset,
+			 bvec->bv_len - iter_all->done);
+	iter_all->done += bv->bv_len;
+
+	if (iter_all->done == bvec->bv_len) {
+		iter_all->idx++;
+		iter_all->done = 0;
+	}
+}
 #endif /* __LINUX_BVEC_ITER_H */
-- 
2.26.2

