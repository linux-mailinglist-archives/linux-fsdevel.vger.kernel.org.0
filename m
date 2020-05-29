Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 772B21E7307
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 May 2020 05:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407404AbgE2C6k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 22:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391621AbgE2C6d (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 22:58:33 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35053C08C5D1;
        Thu, 28 May 2020 19:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=tyoiEDA4aqW5ranAPIIS6qQtQA5yS6rXGQxRGVOBB6U=; b=k2CC7tnkLvS8z2fd5QeRhMqp8T
        yQqr103mhfIUe+Ji2BNm45yavheiNdJl/RXtMZC0sLBMJnjwYmYbgU8qgMkuaWYxUBYlwWoHfb8xF
        yYIllVkPsmCK4WjVKUzZh/duOesf3Hy7svyY0u56SNpXKHpJykFkTdzd56Oh2KCbltw2IzRsbuZwb
        MfmBTzqEydD7H1DFgEuXejabK2yzGxQ8ZVAfLlfTXHDXYVngz0ub7iyG6P2wyPu95TtR3A5NiZ7+n
        Sv2boynRs/qoeKk658aPwtsOpf+q1HcgX2OWY5UVv4lDrhNNcU+7ORhkEy8JxeLgu9BMO9oesZUqT
        YtzmwMCg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jeVE2-0008Qg-W5; Fri, 29 May 2020 02:58:26 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 11/39] fs: Support THPs in zero_user_segments
Date:   Thu, 28 May 2020 19:57:56 -0700
Message-Id: <20200529025824.32296-12-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200529025824.32296-1-willy@infradead.org>
References: <20200529025824.32296-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

We can only kmap() one subpage of a THP at a time, so loop over all
relevant subpages, skipping ones which don't need to be zeroed.  This is
too large to inline when THPs are enabled and we actually need highmem,
so put it in highmem.c.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/highmem.h | 15 +++++++---
 mm/highmem.c            | 62 +++++++++++++++++++++++++++++++++++++++--
 2 files changed, 71 insertions(+), 6 deletions(-)

diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index ea5cdbd8c2c3..74614903619d 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -215,13 +215,18 @@ static inline void clear_highpage(struct page *page)
 	kunmap_atomic(kaddr);
 }
 
+#if defined(CONFIG_HIGHMEM) && defined(CONFIG_TRANSPARENT_HUGEPAGE)
+void zero_user_segments(struct page *page, unsigned start1, unsigned end1,
+		unsigned start2, unsigned end2);
+#else /* !HIGHMEM || !TRANSPARENT_HUGEPAGE */
 static inline void zero_user_segments(struct page *page,
-	unsigned start1, unsigned end1,
-	unsigned start2, unsigned end2)
+		unsigned start1, unsigned end1,
+		unsigned start2, unsigned end2)
 {
+	unsigned long i;
 	void *kaddr = kmap_atomic(page);
 
-	BUG_ON(end1 > PAGE_SIZE || end2 > PAGE_SIZE);
+	BUG_ON(end1 > thp_size(page) || end2 > thp_size(page));
 
 	if (end1 > start1)
 		memset(kaddr + start1, 0, end1 - start1);
@@ -230,8 +235,10 @@ static inline void zero_user_segments(struct page *page,
 		memset(kaddr + start2, 0, end2 - start2);
 
 	kunmap_atomic(kaddr);
-	flush_dcache_page(page);
+	for (i = 0; i < hpage_nr_pages(page); i++)
+		flush_dcache_page(page + i);
 }
+#endif /* !HIGHMEM || !TRANSPARENT_HUGEPAGE */
 
 static inline void zero_user_segment(struct page *page,
 	unsigned start, unsigned end)
diff --git a/mm/highmem.c b/mm/highmem.c
index 64d8dea47dd1..3a85c66ef532 100644
--- a/mm/highmem.c
+++ b/mm/highmem.c
@@ -367,9 +367,67 @@ void kunmap_high(struct page *page)
 	if (need_wakeup)
 		wake_up(pkmap_map_wait);
 }
-
 EXPORT_SYMBOL(kunmap_high);
-#endif
+
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+void zero_user_segments(struct page *page, unsigned start1, unsigned end1,
+		unsigned start2, unsigned end2)
+{
+	unsigned int i;
+
+	BUG_ON(end1 > thp_size(page) || end2 > thp_size(page));
+
+	for (i = 0; i < hpage_nr_pages(page); i++) {
+		void *kaddr;
+		unsigned this_end;
+
+		if (end1 == 0 && start2 >= PAGE_SIZE) {
+			start2 -= PAGE_SIZE;
+			end2 -= PAGE_SIZE;
+			continue;
+		}
+
+		if (start1 >= PAGE_SIZE) {
+			start1 -= PAGE_SIZE;
+			end1 -= PAGE_SIZE;
+			if (start2) {
+				start2 -= PAGE_SIZE;
+				end2 -= PAGE_SIZE;
+			}
+			continue;
+		}
+
+		kaddr = kmap_atomic(page + i);
+
+		this_end = min_t(unsigned, end1, PAGE_SIZE);
+		if (end1 > start1)
+			memset(kaddr + start1, 0, this_end - start1);
+		end1 -= this_end;
+		start1 = 0;
+
+		if (start2 >= PAGE_SIZE) {
+			start2 -= PAGE_SIZE;
+			end2 -= PAGE_SIZE;
+		} else {
+			this_end = min_t(unsigned, end2, PAGE_SIZE);
+			if (end2 > start2)
+				memset(kaddr + start2, 0, this_end - start2);
+			end2 -= this_end;
+			start2 = 0;
+		}
+
+		kunmap_atomic(kaddr);
+		flush_dcache_page(page + i);
+
+		if (!end1 && !end2)
+			break;
+	}
+
+	BUG_ON((start1 | start2 | end1 | end2) != 0);
+}
+EXPORT_SYMBOL(zero_user_segments);
+#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
+#endif /* CONFIG_HIGHMEM */
 
 #if defined(HASHED_PAGE_VIRTUAL)
 
-- 
2.26.2

