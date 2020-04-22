Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 257771B4814
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Apr 2020 17:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728165AbgDVPDK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Apr 2020 11:03:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:58098 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728116AbgDVPDI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Apr 2020 11:03:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 884A9AE6E;
        Wed, 22 Apr 2020 15:03:03 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 8DA181E0E56; Wed, 22 Apr 2020 17:03:03 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 13/23] mm: Use xas_store_noinit() when storing non-NULL
Date:   Wed, 22 Apr 2020 17:02:46 +0200
Message-Id: <20200422150256.23473-14-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200422150256.23473-1-jack@suse.cz>
References: <20200422150256.23473-1-jack@suse.cz>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When we store value different from NULL, xas_store_noinit() is
equivalent to xas_store(). Transition these places to
xas_store_noinit().

Signed-off-by: Jan Kara <jack@suse.cz>
---
 mm/filemap.c    | 6 +++---
 mm/khugepaged.c | 6 +++---
 mm/migrate.c    | 6 +++---
 mm/shmem.c      | 4 ++--
 mm/swap_state.c | 2 +-
 5 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 48c488b505ad..4fb515d8c242 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -134,7 +134,7 @@ static void page_cache_delete(struct address_space *mapping,
 	VM_BUG_ON_PAGE(PageTail(page), page);
 	VM_BUG_ON_PAGE(nr != 1 && shadow, page);
 
-	xas_store(&xas, shadow);
+	xas_store_noinit(&xas, shadow);
 	xas_init_marks(&xas);
 
 	page->mapping = NULL;
@@ -803,7 +803,7 @@ int replace_page_cache_page(struct page *old, struct page *new, gfp_t gfp_mask)
 	new->index = offset;
 
 	xas_lock_irqsave(&xas, flags);
-	xas_store(&xas, new);
+	xas_store_noinit(&xas, new);
 
 	old->mapping = NULL;
 	/* hugetlb pages do not participate in page cache accounting. */
@@ -856,7 +856,7 @@ static int __add_to_page_cache_locked(struct page *page,
 		old = xas_load(&xas);
 		if (old && !xa_is_value(old))
 			xas_set_err(&xas, -EEXIST);
-		xas_store(&xas, page);
+		xas_store_noinit(&xas, page);
 		if (xas_error(&xas))
 			goto unlock;
 
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 8da820c02de7..79e5f0d12517 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1588,7 +1588,7 @@ static void collapse_file(struct mm_struct *mm,
 					result = SCAN_FAIL;
 					goto xa_locked;
 				}
-				xas_store(&xas, new_page);
+				xas_store_noinit(&xas, new_page);
 				nr_none++;
 				continue;
 			}
@@ -1724,7 +1724,7 @@ static void collapse_file(struct mm_struct *mm,
 		list_add_tail(&page->lru, &pagelist);
 
 		/* Finally, replace with the new page. */
-		xas_store(&xas, new_page);
+		xas_store_noinit(&xas, new_page);
 		continue;
 out_unlock:
 		unlock_page(page);
@@ -1828,7 +1828,7 @@ static void collapse_file(struct mm_struct *mm,
 			/* Unfreeze the page. */
 			list_del(&page->lru);
 			page_ref_unfreeze(page, 2);
-			xas_store(&xas, page);
+			xas_store_noinit(&xas, page);
 			xas_pause(&xas);
 			xas_unlock_irq(&xas);
 			unlock_page(page);
diff --git a/mm/migrate.c b/mm/migrate.c
index 7160c1556f79..1610b7336af8 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -459,13 +459,13 @@ int migrate_page_move_mapping(struct address_space *mapping,
 		SetPageDirty(newpage);
 	}
 
-	xas_store(&xas, newpage);
+	xas_store_noinit(&xas, newpage);
 	if (PageTransHuge(page)) {
 		int i;
 
 		for (i = 1; i < HPAGE_PMD_NR; i++) {
 			xas_next(&xas);
-			xas_store(&xas, newpage);
+			xas_store_noinit(&xas, newpage);
 		}
 	}
 
@@ -536,7 +536,7 @@ int migrate_huge_page_move_mapping(struct address_space *mapping,
 
 	get_page(newpage);
 
-	xas_store(&xas, newpage);
+	xas_store_noinit(&xas, newpage);
 
 	page_ref_unfreeze(page, expected_count - 1);
 
diff --git a/mm/shmem.c b/mm/shmem.c
index bd8840082c94..35a4abd9b417 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -361,7 +361,7 @@ static int shmem_replace_entry(struct address_space *mapping,
 	item = xas_load(&xas);
 	if (item != expected)
 		return -ENOENT;
-	xas_store(&xas, replacement);
+	xas_store_noinit(&xas, replacement);
 	return 0;
 }
 
@@ -631,7 +631,7 @@ static int shmem_add_to_page_cache(struct page *page,
 		if (xas_error(&xas))
 			goto unlock;
 next:
-		xas_store(&xas, page);
+		xas_store_noinit(&xas, page);
 		if (++i < nr) {
 			xas_next(&xas);
 			goto next;
diff --git a/mm/swap_state.c b/mm/swap_state.c
index ebed37bbf7a3..1afbf68f1724 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -133,7 +133,7 @@ int add_to_swap_cache(struct page *page, swp_entry_t entry, gfp_t gfp)
 		for (i = 0; i < nr; i++) {
 			VM_BUG_ON_PAGE(xas.xa_index != idx + i, page);
 			set_page_private(page + i, entry.val + i);
-			xas_store(&xas, page);
+			xas_store_noinit(&xas, page);
 			xas_next(&xas);
 		}
 		address_space->nrpages += nr;
-- 
2.16.4

