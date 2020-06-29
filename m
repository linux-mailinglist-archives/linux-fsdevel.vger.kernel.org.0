Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF04720E367
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jun 2020 00:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387770AbgF2VNo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Jun 2020 17:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730128AbgF2S5n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:57:43 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 098BBC03078A
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jun 2020 08:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=VUEVNNECw/4mLTBYjmKDtM2Yal+jOfXT7Nzt4Wxvl/0=; b=rxRY+R2JmvAh6TJfGs+n+zuubF
        eza9rQx0nC3v5+XYJd8mMkMSvt4FyVqFzqZCL9c5N7gvCKBqgUJutEQp5ecY6NIAGMxL0AWmJvNyZ
        QCfwS+5t2sN/3oGVt8iYZqSW6sodBUuOjPZDOlCDtPC/Y62KnsL78S6pF20Aq9PA21w8o1wX4PhQ6
        /0vmebOfB3mcvxA51lSW+9ucpXHBM3i9tt5NY43SZOrnev3LE6Cy/EOI7tNyR4JT9rNUDXSEu0OPY
        Dfw1G3RVhhab9VNjS4u9KW5ywksN4H5rTIfBDeBnOZyTaPLgQwKTxeA6hk7NMP9pYBxZBSzrJx2XW
        kGJ66+pw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jpvZn-0004C0-GN; Mon, 29 Jun 2020 15:20:07 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 1/7] mm: Store compound_nr as well as compound_order
Date:   Mon, 29 Jun 2020 16:19:53 +0100
Message-Id: <20200629151959.15779-2-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200629151959.15779-1-willy@infradead.org>
References: <20200629151959.15779-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This removes a few instructions from functions which need to know how many
pages are in a compound page.  The storage used is either page->mapping
on 64-bit or page->index on 32-bit.  Both of these are fine to overlay
on tail pages.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/mm.h       | 5 ++++-
 include/linux/mm_types.h | 1 +
 mm/page_alloc.c          | 5 +++--
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index dc7b87310c10..af0305ad090f 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -911,12 +911,15 @@ static inline int compound_pincount(struct page *page)
 static inline void set_compound_order(struct page *page, unsigned int order)
 {
 	page[1].compound_order = order;
+	page[1].compound_nr = 1U << order;
 }
 
 /* Returns the number of pages in this potentially compound page. */
 static inline unsigned long compound_nr(struct page *page)
 {
-	return 1UL << compound_order(page);
+	if (!PageHead(page))
+		return 1;
+	return page[1].compound_nr;
 }
 
 /* Returns the number of bytes in this potentially compound page. */
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 64ede5f150dc..561ed987ab44 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -134,6 +134,7 @@ struct page {
 			unsigned char compound_dtor;
 			unsigned char compound_order;
 			atomic_t compound_mapcount;
+			unsigned int compound_nr; /* 1 << compound_order */
 		};
 		struct {	/* Second tail page of compound page */
 			unsigned long _compound_pad_1;	/* compound_head */
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 48eb0f1410d4..c7beb5f13193 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -673,8 +673,6 @@ void prep_compound_page(struct page *page, unsigned int order)
 	int i;
 	int nr_pages = 1 << order;
 
-	set_compound_page_dtor(page, COMPOUND_PAGE_DTOR);
-	set_compound_order(page, order);
 	__SetPageHead(page);
 	for (i = 1; i < nr_pages; i++) {
 		struct page *p = page + i;
@@ -682,6 +680,9 @@ void prep_compound_page(struct page *page, unsigned int order)
 		p->mapping = TAIL_MAPPING;
 		set_compound_head(p, page);
 	}
+
+	set_compound_page_dtor(page, COMPOUND_PAGE_DTOR);
+	set_compound_order(page, order);
 	atomic_set(compound_mapcount_ptr(page), -1);
 	if (hpage_pincount_available(page))
 		atomic_set(compound_pincount_ptr(page), 0);
-- 
2.27.0

