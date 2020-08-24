Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E285250107
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Aug 2020 17:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgHXPZg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Aug 2020 11:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727073AbgHXPRN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Aug 2020 11:17:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A63EEC061755;
        Mon, 24 Aug 2020 08:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=dHPPYRW7Wyiha4H6WrrBOpZ59u0yhrJkqhE0Dkrp7hM=; b=KjEwPAyZ8OUP/RcNmcLBjN6pV9
        DYxhARYtqve1duOzKEr5Xcr8ocVEgCPy5en8ISypdz3pD0/emFMaoaK964ggJbBJd4CHSpyT3WEhu
        0y6wYMVR7+fRIFcOy93o7M7VjwVQJ2xwbm+pdChAWPmGp+OmWbWtvw+aOaVa57kmuz7SRhwBIN4Fc
        30r8ipYwGYpOa8V4zgtr8UIVLB1lL3cJvWUX0JclfJMAnpd40fQMPlocGCq31ZPxGn3lcZpHClZrm
        zqQ8gd6k7v8fIGqGlKFqh8jNJvV/8acgEr2H0EAiXuLTwto1N6KPDtw4/WKYOVuujDGyEcyB9Ml0W
        Dnaqwevg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kAEDX-0004Cj-1b; Mon, 24 Aug 2020 15:17:03 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        linux-block@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 04/11] block: Add bio_for_each_thp_segment_all
Date:   Mon, 24 Aug 2020 16:16:53 +0100
Message-Id: <20200824151700.16097-5-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200824151700.16097-1-willy@infradead.org>
References: <20200824151700.16097-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Iterate once for each THP instead of once for each base page.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/bio.h  | 13 +++++++++++++
 include/linux/bvec.h | 27 +++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/include/linux/bio.h b/include/linux/bio.h
index c6d765382926..a0e104910097 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -129,12 +129,25 @@ static inline bool bio_next_segment(const struct bio *bio,
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
index ac0c7299d5b8..ea8a37a7515b 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -162,4 +162,31 @@ static inline void bvec_advance(const struct bio_vec *bvec,
 	}
 }
 
+static inline void bvec_thp_advance(const struct bio_vec *bvec,
+				struct bvec_iter_all *iter_all)
+{
+	struct bio_vec *bv = &iter_all->bv;
+	unsigned int page_size;
+
+	if (iter_all->done) {
+		bv->bv_page += thp_nr_pages(bv->bv_page);
+		page_size = thp_size(bv->bv_page);
+		bv->bv_offset = 0;
+	} else {
+		bv->bv_page = thp_head(bvec->bv_page +
+				(bvec->bv_offset >> PAGE_SHIFT));
+		page_size = thp_size(bv->bv_page);
+		bv->bv_offset = bvec->bv_offset -
+				(bv->bv_page - bvec->bv_page) * PAGE_SIZE;
+		BUG_ON(bv->bv_offset >= page_size);
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
2.28.0

