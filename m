Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97F091F5CA3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jun 2020 22:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730802AbgFJUPV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jun 2020 16:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730576AbgFJUNv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jun 2020 16:13:51 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D9AC00863A;
        Wed, 10 Jun 2020 13:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=K+NqwcuwBBsF5gvk4uOfKfFisJ5O9Bzckjl4rjWXvjY=; b=qA6a873s/Zff6UrlIw+ycMtkmr
        r7DXIh0LqRMxP8WmkQDOXoK4uBozwknJV1jplSMSs98TIdUIx9XWMUHtY5l3pS6At6H0Xo3WrxqxB
        Hd4PKKJiOVr/UNzXW9P1ADiQ2BXcPTKbHqHw4Vu3jZHP/lMxn1vwvo14aDBfSs/nxM5xlnqoahpLH
        bOivbzFTqd30i9dX6D36QV9MDuQJbVOHE7P8sXzMHd/HO5kvplNVn8doNMTZ7o47aCSZFxVTtjAEa
        kwGXfT5L3TCXUpfoZOZ8sSz+qHMzHK1b84OTzHcsHm1cPxLrUaCSX1eV8+lK+rgZy7PRnoEdC+vgv
        paZTSwUA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jj76a-0003XE-SA; Wed, 10 Jun 2020 20:13:48 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 39/51] mm: Remove assumptions of THP size
Date:   Wed, 10 Jun 2020 13:13:33 -0700
Message-Id: <20200610201345.13273-40-willy@infradead.org>
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

Remove direct uses of HPAGE_PMD_NR in paths that aren't necessarily
PMD sized.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/huge_memory.c | 15 ++++++++-------
 mm/rmap.c        | 10 +++++-----
 2 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 744863aa0374..c25d8e2310e8 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2340,7 +2340,7 @@ static void remap_page(struct page *page)
 	if (PageTransHuge(page)) {
 		remove_migration_ptes(page, page, true);
 	} else {
-		for (i = 0; i < HPAGE_PMD_NR; i++)
+		for (i = 0; i < thp_nr_pages(page); i++)
 			remove_migration_ptes(page + i, page + i, true);
 	}
 }
@@ -2415,6 +2415,7 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 	struct lruvec *lruvec;
 	struct address_space *swap_cache = NULL;
 	unsigned long offset = 0;
+	unsigned int nr = thp_nr_pages(head);
 	int i;
 
 	lruvec = mem_cgroup_page_lruvec(head, pgdat);
@@ -2430,7 +2431,7 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 		xa_lock(&swap_cache->i_pages);
 	}
 
-	for (i = HPAGE_PMD_NR - 1; i >= 1; i--) {
+	for (i = nr - 1; i >= 1; i--) {
 		__split_huge_page_tail(head, i, lruvec, list);
 		/* Some pages can be beyond i_size: drop them from page cache */
 		if (head[i].index >= end) {
@@ -2471,7 +2472,7 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 
 	remap_page(head);
 
-	for (i = 0; i < HPAGE_PMD_NR; i++) {
+	for (i = 0; i < nr; i++) {
 		struct page *subpage = head + i;
 		if (subpage == page)
 			continue;
@@ -2553,14 +2554,14 @@ int page_trans_huge_mapcount(struct page *page, int *total_mapcount)
 	page = compound_head(page);
 
 	_total_mapcount = ret = 0;
-	for (i = 0; i < HPAGE_PMD_NR; i++) {
+	for (i = 0; i < thp_nr_pages(page); i++) {
 		mapcount = atomic_read(&page[i]._mapcount) + 1;
 		ret = max(ret, mapcount);
 		_total_mapcount += mapcount;
 	}
 	if (PageDoubleMap(page)) {
 		ret -= 1;
-		_total_mapcount -= HPAGE_PMD_NR;
+		_total_mapcount -= thp_nr_pages(page);
 	}
 	mapcount = compound_mapcount(page);
 	ret += mapcount;
@@ -2577,9 +2578,9 @@ bool can_split_huge_page(struct page *page, int *pextra_pins)
 
 	/* Additional pins from page cache */
 	if (PageAnon(page))
-		extra_pins = PageSwapCache(page) ? HPAGE_PMD_NR : 0;
+		extra_pins = PageSwapCache(page) ? thp_nr_pages(page) : 0;
 	else
-		extra_pins = HPAGE_PMD_NR;
+		extra_pins = thp_nr_pages(page);
 	if (pextra_pins)
 		*pextra_pins = extra_pins;
 	return total_mapcount(page) == page_count(page) - extra_pins - 1;
diff --git a/mm/rmap.c b/mm/rmap.c
index c56fab5826c1..c0295282928b 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1205,7 +1205,7 @@ void page_add_file_rmap(struct page *page, bool compound)
 	VM_BUG_ON_PAGE(compound && !PageTransHuge(page), page);
 	lock_page_memcg(page);
 	if (compound && PageTransHuge(page)) {
-		for (i = 0, nr = 0; i < HPAGE_PMD_NR; i++) {
+		for (i = 0, nr = 0; i < thp_nr_pages(page); i++) {
 			if (atomic_inc_and_test(&page[i]._mapcount))
 				nr++;
 		}
@@ -1246,7 +1246,7 @@ static void page_remove_file_rmap(struct page *page, bool compound)
 
 	/* page still mapped by someone else? */
 	if (compound && PageTransHuge(page)) {
-		for (i = 0, nr = 0; i < HPAGE_PMD_NR; i++) {
+		for (i = 0, nr = 0; i < thp_nr_pages(page); i++) {
 			if (atomic_add_negative(-1, &page[i]._mapcount))
 				nr++;
 		}
@@ -1293,7 +1293,7 @@ static void page_remove_anon_compound_rmap(struct page *page)
 		 * Subpages can be mapped with PTEs too. Check how many of
 		 * them are still mapped.
 		 */
-		for (i = 0, nr = 0; i < HPAGE_PMD_NR; i++) {
+		for (i = 0, nr = 0; i < thp_nr_pages(page); i++) {
 			if (atomic_add_negative(-1, &page[i]._mapcount))
 				nr++;
 		}
@@ -1303,10 +1303,10 @@ static void page_remove_anon_compound_rmap(struct page *page)
 		 * page of the compound page is unmapped, but at least one
 		 * small page is still mapped.
 		 */
-		if (nr && nr < HPAGE_PMD_NR)
+		if (nr && nr < thp_nr_pages(page))
 			deferred_split_huge_page(page);
 	} else {
-		nr = HPAGE_PMD_NR;
+		nr = thp_nr_pages(page);
 	}
 
 	if (unlikely(PageMlocked(page)))
-- 
2.26.2

