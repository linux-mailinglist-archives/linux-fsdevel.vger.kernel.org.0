Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A722C29955C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Oct 2020 19:31:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1789830AbgJZSbo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Oct 2020 14:31:44 -0400
Received: from casper.infradead.org ([90.155.50.34]:47252 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1784911AbgJZSbn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Oct 2020 14:31:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=+JsIPUMhHfnx/SncjzGyFlWSq6+WuP+wYEhUHsuc6pU=; b=r+7NWmZ6RWrdYBMYBO2LPkXPp3
        R8QYndbr8XFgRWFpIK8Aau+mNdkdvIPJFr3z2Q6WCLqo5TR24fcgQGzlYEGcI9txWjw1ju9EFkv7c
        iCH6gUDXsERthfOhpPI+ky5/c2ifRG/3RsKcb7dmm/6V1MJaq9hSf29sNJwR+pwAHyqRNXsypCBWF
        PeUcgNsq3Q6IklNFVpqbMhews/yLPeMbOg3Nub3IMM8WUtV3dROFMzF8kmt6hFDPnUlfL2tTmBgt4
        ylg3VVskobRonF3xW0nPVSn1vnLA7uOFP3UvfiaDyBBJSJg6yzAx8YafWMSrkjSlwZ3dGdgRv6xQP
        6EFsKdJw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kX7HR-0002jF-3N; Mon, 26 Oct 2020 18:31:41 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/9] mm: Support THPs in zero_user_segments
Date:   Mon, 26 Oct 2020 18:31:28 +0000
Message-Id: <20201026183136.10404-2-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201026183136.10404-1-willy@infradead.org>
References: <20201026183136.10404-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We can only kmap() one subpage of a THP at a time, so loop over all
relevant subpages, skipping ones which don't need to be zeroed.  This is
too large to inline when THPs are enabled and we actually need highmem,
so put it in highmem.c.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/highmem.h | 19 ++++++++++---
 mm/highmem.c            | 62 +++++++++++++++++++++++++++++++++++++++--
 2 files changed, 75 insertions(+), 6 deletions(-)

diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index 14e6202ce47f..8e21fe82b3a3 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -284,13 +284,22 @@ static inline void clear_highpage(struct page *page)
 	kunmap_atomic(kaddr);
 }
 
+/*
+ * If we pass in a base or tail page, we can zero up to PAGE_SIZE.
+ * If we pass in a head page, we can zero up to the size of the compound page.
+ */
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
 	void *kaddr = kmap_atomic(page);
+	unsigned int i;
 
-	BUG_ON(end1 > PAGE_SIZE || end2 > PAGE_SIZE);
+	BUG_ON(end1 > page_size(page) || end2 > page_size(page));
 
 	if (end1 > start1)
 		memset(kaddr + start1, 0, end1 - start1);
@@ -299,8 +308,10 @@ static inline void zero_user_segments(struct page *page,
 		memset(kaddr + start2, 0, end2 - start2);
 
 	kunmap_atomic(kaddr);
-	flush_dcache_page(page);
+	for (i = 0; i < compound_nr(page); i++)
+		flush_dcache_page(page + i);
 }
+#endif /* !HIGHMEM || !TRANSPARENT_HUGEPAGE */
 
 static inline void zero_user_segment(struct page *page,
 	unsigned start, unsigned end)
diff --git a/mm/highmem.c b/mm/highmem.c
index 1352a27951e3..9901a806617a 100644
--- a/mm/highmem.c
+++ b/mm/highmem.c
@@ -367,9 +367,67 @@ void kunmap_high(struct page *page)
 	if (need_wakeup)
 		wake_up(pkmap_map_wait);
 }
-
 EXPORT_SYMBOL(kunmap_high);
-#endif	/* CONFIG_HIGHMEM */
+
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+void zero_user_segments(struct page *page, unsigned start1, unsigned end1,
+		unsigned start2, unsigned end2)
+{
+	unsigned int i;
+
+	BUG_ON(end1 > page_size(page) || end2 > page_size(page));
+
+	for (i = 0; i < compound_nr(page); i++) {
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
2.28.0

