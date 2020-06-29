Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5267420E35B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jun 2020 00:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731122AbgF2VNY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Jun 2020 17:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730131AbgF2S5n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:57:43 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25AC7C03078C
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jun 2020 08:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=ttGcAvOxnEG9VnrEf9OemS0lv4LPw6xb0Xhlc9yhXlI=; b=e7DH7+XYvnm256uXhaetvoi9BG
        WtCwgjk35pEDD8jAiGlfADSVwU6vsF4doBpW84LEI/nosr1otS3xCmImn9Z9zVS7x2ANLtXdoPBKI
        oESvfOmPzqgZzOjG8B0QCT3DAFYCbHFj1mPs7/ItICl8/52JuGL17Aj2/DZSf9a9MSWDVReENcyMK
        z8vFUCW1iBySwBuv6OVPA3TgjioK42BMzqQn4VUUNewCG5E4N7fk2R4yVI+WHWr01mdNE1E9m1I/T
        2Wr8m7/7wFLSOr31GHyImQGlkgl2YSTtqFSGHHlxt7hSPQV3EB0s01x7wFX0s8hnzGXHaQ7PB3Ho9
        wFYQoacw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jpvZo-0004CF-8Q; Mon, 29 Jun 2020 15:20:08 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 3/7] mm: Add thp_order
Date:   Mon, 29 Jun 2020 16:19:55 +0100
Message-Id: <20200629151959.15779-4-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200629151959.15779-1-willy@infradead.org>
References: <20200629151959.15779-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This function returns the order of a transparent huge page.  It
compiles to 0 if CONFIG_TRANSPARENT_HUGEPAGE is disabled.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/huge_mm.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 71f20776b06c..dd19720a8bc2 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -265,6 +265,19 @@ static inline spinlock_t *pud_trans_huge_lock(pud_t *pud,
 	else
 		return NULL;
 }
+
+/**
+ * thp_order - Order of a transparent huge page.
+ * @page: Head page of a transparent huge page.
+ */
+static inline unsigned int thp_order(struct page *page)
+{
+	VM_BUG_ON_PGFLAGS(PageTail(page), page);
+	if (PageHead(page))
+		return HPAGE_PMD_ORDER;
+	return 0;
+}
+
 static inline int hpage_nr_pages(struct page *page)
 {
 	if (unlikely(PageTransHuge(page)))
@@ -324,6 +337,12 @@ static inline struct list_head *page_deferred_list(struct page *page)
 #define HPAGE_PUD_MASK ({ BUILD_BUG(); 0; })
 #define HPAGE_PUD_SIZE ({ BUILD_BUG(); 0; })
 
+static inline unsigned int thp_order(struct page *page)
+{
+	VM_BUG_ON_PGFLAGS(PageTail(page), page);
+	return 0;
+}
+
 static inline int hpage_nr_pages(struct page *page)
 {
 	VM_BUG_ON_PAGE(PageTail(page), page);
-- 
2.27.0

