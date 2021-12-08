Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6963246CC59
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Dec 2021 05:23:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240128AbhLHE0s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Dec 2021 23:26:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbhLHE0n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Dec 2021 23:26:43 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3979CC0617A1
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Dec 2021 20:23:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=q7qEbqnJ5RUpHWaUhfXKj7MwXRK65W02Wk/Lkz0SF+4=; b=GancLpAeAyY7nvDVkXACF9qJa4
        krZ1QlZRrR/yK0Z/87T2oirxcg/QArqFxyD1oAn0iGaXHE5vt0OZI0XRGVMuoXiJw+vGV1wQISIci
        M07sLdYrt2d3KDOG3vFHK7Wi04vVQo3TC8WJPvYXxNhlkrQcP3KZop4f4GDZI6WjvXw0LXb+x+C1Q
        2gOZcWPDB6ffn9HrwipFsnuqgCqg3p8rJERS9XuC8sSz9FDNn+cTSWMRBswUnWJbYOD6f6+A+GTgP
        3kx5sKRYeJh8EYOgYI7LXuZj039zdqG3zWLCrsnMV8fiBJ/XEX5VuesinO3uvbup0woeO9qKklpAe
        v3ad9+NA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1muoU2-0084XK-F3; Wed, 08 Dec 2021 04:23:10 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 09/48] filemap: Add folio_put_wait_locked()
Date:   Wed,  8 Dec 2021 04:22:17 +0000
Message-Id: <20211208042256.1923824-10-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211208042256.1923824-1-willy@infradead.org>
References: <20211208042256.1923824-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert all three callers of put_and_wait_on_page_locked() to
folio_put_wait_locked().  This shrinks the kernel overall by 19 bytes.
filemap_update_page() shrinks by 19 bytes while __migration_entry_wait()
is unchanged.  folio_put_wait_locked() is 14 bytes smaller than
put_and_wait_on_page_locked(), but pmd_migration_entry_wait() grows by
14 bytes.  It removes the assumption from pmd_migration_entry_wait()
that pages cannot be larger than a PMD (which is true today, but
may be interesting to explore in the future).

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h |  2 +-
 mm/filemap.c            | 27 +++++++++++++++------------
 mm/migrate.c            | 21 ++++++++++-----------
 3 files changed, 26 insertions(+), 24 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 605246452305..841f7ba62d7d 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -868,7 +868,7 @@ static inline int wait_on_page_locked_killable(struct page *page)
 	return folio_wait_locked_killable(page_folio(page));
 }
 
-int put_and_wait_on_page_locked(struct page *page, int state);
+int folio_put_wait_locked(struct folio *folio, int state);
 void wait_on_page_writeback(struct page *page);
 void folio_wait_writeback(struct folio *folio);
 int folio_wait_writeback_killable(struct folio *folio);
diff --git a/mm/filemap.c b/mm/filemap.c
index 39c4c46c6133..5dd3c6e39c9f 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1259,10 +1259,10 @@ enum behavior {
 			 * __folio_lock() waiting on then setting PG_locked.
 			 */
 	SHARED,		/* Hold ref to page and check the bit when woken, like
-			 * wait_on_page_writeback() waiting on PG_writeback.
+			 * folio_wait_writeback() waiting on PG_writeback.
 			 */
 	DROP,		/* Drop ref to page before wait, no check when woken,
-			 * like put_and_wait_on_page_locked() on PG_locked.
+			 * like folio_put_wait_locked() on PG_locked.
 			 */
 };
 
@@ -1439,22 +1439,21 @@ int folio_wait_bit_killable(struct folio *folio, int bit_nr)
 EXPORT_SYMBOL(folio_wait_bit_killable);
 
 /**
- * put_and_wait_on_page_locked - Drop a reference and wait for it to be unlocked
- * @page: The page to wait for.
+ * folio_put_wait_locked - Drop a reference and wait for it to be unlocked
+ * @folio: The folio to wait for.
  * @state: The sleep state (TASK_KILLABLE, TASK_UNINTERRUPTIBLE, etc).
  *
- * The caller should hold a reference on @page.  They expect the page to
+ * The caller should hold a reference on @folio.  They expect the page to
  * become unlocked relatively soon, but do not wish to hold up migration
- * (for example) by holding the reference while waiting for the page to
+ * (for example) by holding the reference while waiting for the folio to
  * come unlocked.  After this function returns, the caller should not
- * dereference @page.
+ * dereference @folio.
  *
- * Return: 0 if the page was unlocked or -EINTR if interrupted by a signal.
+ * Return: 0 if the folio was unlocked or -EINTR if interrupted by a signal.
  */
-int put_and_wait_on_page_locked(struct page *page, int state)
+int folio_put_wait_locked(struct folio *folio, int state)
 {
-	return folio_wait_bit_common(page_folio(page), PG_locked, state,
-			DROP);
+	return folio_wait_bit_common(folio, PG_locked, state, DROP);
 }
 
 /**
@@ -2447,7 +2446,11 @@ static int filemap_update_page(struct kiocb *iocb,
 			goto unlock_mapping;
 		if (!(iocb->ki_flags & IOCB_WAITQ)) {
 			filemap_invalidate_unlock_shared(mapping);
-			put_and_wait_on_page_locked(&folio->page, TASK_KILLABLE);
+			/*
+			 * This is where we usually end up waiting for a
+			 * previously submitted readahead to finish.
+			 */
+			folio_put_wait_locked(folio, TASK_KILLABLE);
 			return AOP_TRUNCATED_PAGE;
 		}
 		error = __folio_lock_async(folio, iocb->ki_waitq);
diff --git a/mm/migrate.c b/mm/migrate.c
index cf25b00f03c8..311638177536 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -291,7 +291,7 @@ void __migration_entry_wait(struct mm_struct *mm, pte_t *ptep,
 {
 	pte_t pte;
 	swp_entry_t entry;
-	struct page *page;
+	struct folio *folio;
 
 	spin_lock(ptl);
 	pte = *ptep;
@@ -302,18 +302,17 @@ void __migration_entry_wait(struct mm_struct *mm, pte_t *ptep,
 	if (!is_migration_entry(entry))
 		goto out;
 
-	page = pfn_swap_entry_to_page(entry);
-	page = compound_head(page);
+	folio = page_folio(pfn_swap_entry_to_page(entry));
 
 	/*
 	 * Once page cache replacement of page migration started, page_count
-	 * is zero; but we must not call put_and_wait_on_page_locked() without
-	 * a ref. Use get_page_unless_zero(), and just fault again if it fails.
+	 * is zero; but we must not call folio_put_wait_locked() without
+	 * a ref. Use folio_try_get(), and just fault again if it fails.
 	 */
-	if (!get_page_unless_zero(page))
+	if (!folio_try_get(folio))
 		goto out;
 	pte_unmap_unlock(ptep, ptl);
-	put_and_wait_on_page_locked(page, TASK_UNINTERRUPTIBLE);
+	folio_put_wait_locked(folio, TASK_UNINTERRUPTIBLE);
 	return;
 out:
 	pte_unmap_unlock(ptep, ptl);
@@ -338,16 +337,16 @@ void migration_entry_wait_huge(struct vm_area_struct *vma,
 void pmd_migration_entry_wait(struct mm_struct *mm, pmd_t *pmd)
 {
 	spinlock_t *ptl;
-	struct page *page;
+	struct folio *folio;
 
 	ptl = pmd_lock(mm, pmd);
 	if (!is_pmd_migration_entry(*pmd))
 		goto unlock;
-	page = pfn_swap_entry_to_page(pmd_to_swp_entry(*pmd));
-	if (!get_page_unless_zero(page))
+	folio = page_folio(pfn_swap_entry_to_page(pmd_to_swp_entry(*pmd)));
+	if (!folio_try_get(folio))
 		goto unlock;
 	spin_unlock(ptl);
-	put_and_wait_on_page_locked(page, TASK_UNINTERRUPTIBLE);
+	folio_put_wait_locked(folio, TASK_UNINTERRUPTIBLE);
 	return;
 unlock:
 	spin_unlock(ptl);
-- 
2.33.0

