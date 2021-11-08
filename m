Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92873447935
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Nov 2021 05:14:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235780AbhKHER1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 7 Nov 2021 23:17:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233610AbhKHERX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 7 Nov 2021 23:17:23 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10CF5C061570;
        Sun,  7 Nov 2021 20:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=2h36aUCIYCSPoxy7eXJco89TPHc5MyLSTGaYJ8/UStY=; b=bYWXvm9IN4UAjTtuuVCbnZ5RxI
        waxJm/yzqmbYGTf3RWMUZJ0zMbs5qLPOli6y7t97ENTi7MdzR9DlR4mQ69DtoSKNn6DxZSw2K0xjn
        kI7ZSMWTn1F9ypkxMjI1Yac9ZiIObJ0feohBcbmNAroGnBz1NYLKLwLaVUcNQJWJ3/OTVUxBm/7Ks
        cjjJfOkMVAA8wpxlClsazJ2Lo8ZOy/qttr3LsLrI5SmdUEn9KMEYmX7RK4HY7JHPuyEO5w2qqU1Tc
        gQn48CPmBsGHp7r5fnYvjyF2lROIso7fOmUWP9JhXU6cZaURcNRoFvMJIgS/bJ3aXDNcvKC/Gu2zK
        AKpoalDA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mjvzN-0089Wo-9X; Mon, 08 Nov 2021 04:11:03 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     "Darrick J . Wong " <djwong@kernel.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v2 02/28] mm: Add functions to zero portions of a folio
Date:   Mon,  8 Nov 2021 04:05:25 +0000
Message-Id: <20211108040551.1942823-3-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211108040551.1942823-1-willy@infradead.org>
References: <20211108040551.1942823-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

These functions are wrappers around zero_user_segments(), which means
that zero_user_segments() can now be called for compound pages even when
CONFIG_TRANSPARENT_HUGEPAGE is disabled.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/highmem.h | 44 ++++++++++++++++++++++++++++++++++++++---
 mm/highmem.c            |  2 --
 2 files changed, 41 insertions(+), 5 deletions(-)

diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index 25aff0f2ed0b..c343c69bb5b4 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -231,10 +231,10 @@ static inline void tag_clear_highpage(struct page *page)
  * If we pass in a base or tail page, we can zero up to PAGE_SIZE.
  * If we pass in a head page, we can zero up to the size of the compound page.
  */
-#if defined(CONFIG_HIGHMEM) && defined(CONFIG_TRANSPARENT_HUGEPAGE)
+#ifdef CONFIG_HIGHMEM
 void zero_user_segments(struct page *page, unsigned start1, unsigned end1,
 		unsigned start2, unsigned end2);
-#else /* !HIGHMEM || !TRANSPARENT_HUGEPAGE */
+#else
 static inline void zero_user_segments(struct page *page,
 		unsigned start1, unsigned end1,
 		unsigned start2, unsigned end2)
@@ -254,7 +254,7 @@ static inline void zero_user_segments(struct page *page,
 	for (i = 0; i < compound_nr(page); i++)
 		flush_dcache_page(page + i);
 }
-#endif /* !HIGHMEM || !TRANSPARENT_HUGEPAGE */
+#endif
 
 static inline void zero_user_segment(struct page *page,
 	unsigned start, unsigned end)
@@ -364,4 +364,42 @@ static inline void memzero_page(struct page *page, size_t offset, size_t len)
 	kunmap_local(addr);
 }
 
+/**
+ * folio_zero_segments() - Zero two byte ranges in a folio.
+ * @folio: The folio to write to.
+ * @start1: The first byte to zero.
+ * @end1: One more than the last byte in the first range.
+ * @start2: The first byte to zero in the second range.
+ * @end2: One more than the last byte in the second range.
+ */
+static inline void folio_zero_segments(struct folio *folio,
+		size_t start1, size_t end1, size_t start2, size_t end2)
+{
+	zero_user_segments(&folio->page, start1, end1, start2, end2);
+}
+
+/**
+ * folio_zero_segment() - Zero a byte range in a folio.
+ * @folio: The folio to write to.
+ * @start: The first byte to zero.
+ * @end: One more than the last byte in the first range.
+ */
+static inline void folio_zero_segment(struct folio *folio,
+		size_t start, size_t end)
+{
+	zero_user_segments(&folio->page, start, end, 0, 0);
+}
+
+/**
+ * folio_zero_range() - Zero a byte range in a folio.
+ * @folio: The folio to write to.
+ * @start: The first byte to zero.
+ * @length: The number of bytes to zero.
+ */
+static inline void folio_zero_range(struct folio *folio,
+		size_t start, size_t length)
+{
+	zero_user_segments(&folio->page, start, start + length, 0, 0);
+}
+
 #endif /* _LINUX_HIGHMEM_H */
diff --git a/mm/highmem.c b/mm/highmem.c
index 88f65f155845..819d41140e5b 100644
--- a/mm/highmem.c
+++ b/mm/highmem.c
@@ -359,7 +359,6 @@ void kunmap_high(struct page *page)
 }
 EXPORT_SYMBOL(kunmap_high);
 
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
 void zero_user_segments(struct page *page, unsigned start1, unsigned end1,
 		unsigned start2, unsigned end2)
 {
@@ -416,7 +415,6 @@ void zero_user_segments(struct page *page, unsigned start1, unsigned end1,
 	BUG_ON((start1 | start2 | end1 | end2) != 0);
 }
 EXPORT_SYMBOL(zero_user_segments);
-#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 #endif /* CONFIG_HIGHMEM */
 
 #ifdef CONFIG_KMAP_LOCAL
-- 
2.33.0

