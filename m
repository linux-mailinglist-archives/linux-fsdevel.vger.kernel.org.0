Return-Path: <linux-fsdevel+bounces-5052-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 674FB807B62
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 23:37:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6446B1C20B05
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 22:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB2B1C29
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 22:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bgXELJ87"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DCE5135
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Dec 2023 12:44:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=rhWeIRptRNUgjmaD/wW4RujIHeTM8TT1pwDCRhhFjIs=; b=bgXELJ87R3tP8ilGHXJDckrMyc
	um7q6N8PUmF7+nj38xs/U4N332ER8dXBJGjswS+mIChgL+rP4iCibhzI2q0FEbK0xu/jwMCDrtbra
	/LVKpOBFkKdya3/YhSODZ1JRdOv9ge3bi2FjsDUupFgnJlDRUSPisLCW7ZK7SQne3aPyNvXA8U+Nq
	cPLP62wTky1kQCUMXJfJR3PAdh71y4ajPM4HIe6SJEDg1W5xCIGtcUX8UrjpxWoayc6nR3xI6ANj+
	vvusKz5/IZr4EdgA++fzjxVDID31xZJnl6zK24rDa5gqt+TbinRbOq/ea8i5VyOB2EEciPXLhbxkJ
	NZA+MTjg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rAylA-003EgZ-Ic; Wed, 06 Dec 2023 20:44:44 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	Hugh Dickins <hughd@google.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Hannes Reinecke <hare@suse.com>
Subject: [PATCH] mm: Support order-1 folios in the page cache
Date: Wed,  6 Dec 2023 20:44:42 +0000
Message-Id: <20231206204442.771430-1-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Folios of order 1 have no space to store the deferred list.  This is
not a problem for the page cache as file-backed folios are never
placed on the deferred list.  All we need to do is prevent the core
MM from touching the deferred list for order 1 folios and remove the
code which prevented us from allocating order 1 folios.

Link: https://lore.kernel.org/linux-mm/90344ea7-4eec-47ee-5996-0c22f42d6a6a@google.com/
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/huge_mm.h |  7 +++++--
 mm/filemap.c            |  2 --
 mm/huge_memory.c        | 23 ++++++++++++++++++-----
 mm/internal.h           |  4 +---
 mm/readahead.c          |  8 ++------
 5 files changed, 26 insertions(+), 18 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index fa0350b0812a..7b59ff685da3 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -140,7 +140,7 @@ bool hugepage_vma_check(struct vm_area_struct *vma, unsigned long vm_flags,
 unsigned long thp_get_unmapped_area(struct file *filp, unsigned long addr,
 		unsigned long len, unsigned long pgoff, unsigned long flags);
 
-void folio_prep_large_rmappable(struct folio *folio);
+struct folio *folio_prep_large_rmappable(struct folio *folio);
 bool can_split_folio(struct folio *folio, int *pextra_pins);
 int split_huge_page_to_list(struct page *page, struct list_head *list);
 static inline int split_huge_page(struct page *page)
@@ -280,7 +280,10 @@ static inline bool hugepage_vma_check(struct vm_area_struct *vma,
 	return false;
 }
 
-static inline void folio_prep_large_rmappable(struct folio *folio) {}
+static inline struct folio *folio_prep_large_rmappable(struct folio *folio)
+{
+	return folio;
+}
 
 #define transparent_hugepage_flags 0UL
 
diff --git a/mm/filemap.c b/mm/filemap.c
index 32eedf3afd45..61321e920e30 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1911,8 +1911,6 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
 			gfp_t alloc_gfp = gfp;
 
 			err = -ENOMEM;
-			if (order == 1)
-				order = 0;
 			if (order > 0)
 				alloc_gfp |= __GFP_NORETRY | __GFP_NOWARN;
 			folio = filemap_alloc_folio(alloc_gfp, order);
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 4f542444a91f..0df68a318922 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -610,11 +610,15 @@ struct deferred_split *get_deferred_split_queue(struct folio *folio)
 }
 #endif
 
-void folio_prep_large_rmappable(struct folio *folio)
+struct folio *folio_prep_large_rmappable(struct folio *folio)
 {
-	VM_BUG_ON_FOLIO(folio_order(folio) < 2, folio);
-	INIT_LIST_HEAD(&folio->_deferred_list);
+	if (!folio || !folio_test_large(folio))
+		return folio;
+	if (folio_order(folio) > 1)
+		INIT_LIST_HEAD(&folio->_deferred_list);
 	folio_set_large_rmappable(folio);
+
+	return folio;
 }
 
 static inline bool is_transparent_hugepage(struct folio *folio)
@@ -2760,7 +2764,8 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 	/* Prevent deferred_split_scan() touching ->_refcount */
 	spin_lock(&ds_queue->split_queue_lock);
 	if (folio_ref_freeze(folio, 1 + extra_pins)) {
-		if (!list_empty(&folio->_deferred_list)) {
+		if (folio_order(folio) > 1 &&
+		    !list_empty(&folio->_deferred_list)) {
 			ds_queue->split_queue_len--;
 			list_del(&folio->_deferred_list);
 		}
@@ -2811,6 +2816,9 @@ void folio_undo_large_rmappable(struct folio *folio)
 	struct deferred_split *ds_queue;
 	unsigned long flags;
 
+	if (folio_order(folio) <= 1)
+		return;
+
 	/*
 	 * At this point, there is no one trying to add the folio to
 	 * deferred_list. If folio is not in deferred_list, it's safe
@@ -2836,7 +2844,12 @@ void deferred_split_folio(struct folio *folio)
 #endif
 	unsigned long flags;
 
-	VM_BUG_ON_FOLIO(folio_order(folio) < 2, folio);
+	/*
+	 * Order 1 folios have no space for a deferred list, but we also
+	 * won't waste much memory by not adding them to the deferred list.
+	 */
+	if (folio_order(folio) <= 1)
+		return;
 
 	/*
 	 * The try_to_unmap() in page reclaim path might reach here too,
diff --git a/mm/internal.h b/mm/internal.h
index b61034bd50f5..11a9021614dd 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -419,9 +419,7 @@ static inline struct folio *page_rmappable_folio(struct page *page)
 {
 	struct folio *folio = (struct folio *)page;
 
-	if (folio && folio_order(folio) > 1)
-		folio_prep_large_rmappable(folio);
-	return folio;
+	return folio_prep_large_rmappable(folio);
 }
 
 static inline void prep_compound_head(struct page *page, unsigned int order)
diff --git a/mm/readahead.c b/mm/readahead.c
index 6925e6959fd3..48cca8e8de17 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -513,14 +513,10 @@ void page_cache_ra_order(struct readahead_control *ractl,
 		/* Align with smaller pages if needed */
 		if (index & ((1UL << order) - 1)) {
 			order = __ffs(index);
-			if (order == 1)
-				order = 0;
 		}
 		/* Don't allocate pages past EOF */
-		while (index + (1UL << order) - 1 > limit) {
-			if (--order == 1)
-				order = 0;
-		}
+		while (index + (1UL << order) - 1 > limit)
+			--order;
 		err = ra_alloc_folio(ractl, index, mark, order, gfp);
 		if (err)
 			break;
-- 
2.42.0


