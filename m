Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1F242DC669
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Dec 2020 19:26:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730515AbgLPSZu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Dec 2020 13:25:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727255AbgLPSZj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Dec 2020 13:25:39 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF27C0619D5;
        Wed, 16 Dec 2020 10:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=tZOfY+118CWH3KnZnfDFTdA9tQUY0P7yOd1XlANpu5w=; b=DwM1CuzooXH+o8npX92XMZeKFD
        cvBoPCBIfoq3VtHKUxFp280B+vZAVXE+QSI8r2nhbPW/IEnmY1V5EYjkHE2HyQQJkFPGnsja2FmR+
        G4c8YMMO+qtcZjT09Qkzl5NlntCC+XVJJmwgxgER/AsY1Vvvoq3JNML8n8fltnuJY9Mc6JNe/5Hy6
        8jXbfd1Lq28JiojKZz2WE1TOcJUe3WorMfae6A2u0acoSINEH6CQb3iumQtAYOAossFlYA5QxOr+P
        yPanez+f8U0u94UDtiG9LyjgFuwXLJROxnBMYmVX1t2rJz/p81c1IPFys0TPhLQxVB+o+ILzetGrP
        oPphJjrw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kpbSh-00078l-Uj; Wed, 16 Dec 2020 18:23:43 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 21/25] mm: Convert wait_on_page_bit to wait_on_folio_bit
Date:   Wed, 16 Dec 2020 18:23:31 +0000
Message-Id: <20201216182335.27227-22-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201216182335.27227-1-willy@infradead.org>
References: <20201216182335.27227-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We must deal with folios here otherwise we'll get the wrong waitqueue
and fail to receive wakeups.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/afs/write.c          |  2 +-
 include/linux/pagemap.h | 14 ++++++-----
 mm/filemap.c            | 54 ++++++++++++++++++-----------------------
 mm/page-writeback.c     |  7 +++---
 4 files changed, 37 insertions(+), 40 deletions(-)

diff --git a/fs/afs/write.c b/fs/afs/write.c
index c9195fc67fd8..b58e7a69a464 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -852,7 +852,7 @@ vm_fault_t afs_page_mkwrite(struct vm_fault *vmf)
 #endif
 
 	if (PageWriteback(vmf->page) &&
-	    wait_on_page_bit_killable(vmf->page, PG_writeback) < 0)
+	    wait_on_folio_bit_killable(page_folio(vmf->page), PG_writeback) < 0)
 		return VM_FAULT_RETRY;
 
 	if (lock_page_killable(vmf->page) < 0)
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 2283e58ebe32..ac4d3e2ac86c 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -717,8 +717,8 @@ static inline int lock_page_or_retry(struct page *page, struct mm_struct *mm,
  * This is exported only for wait_on_page_locked/wait_on_page_writeback, etc.,
  * and should not be used directly.
  */
-extern void wait_on_page_bit(struct page *page, int bit_nr);
-extern int wait_on_page_bit_killable(struct page *page, int bit_nr);
+extern void wait_on_folio_bit(struct folio *folio, int bit_nr);
+extern int wait_on_folio_bit_killable(struct folio *folio, int bit_nr);
 
 /* 
  * Wait for a page to be unlocked.
@@ -729,15 +729,17 @@ extern int wait_on_page_bit_killable(struct page *page, int bit_nr);
  */
 static inline void wait_on_page_locked(struct page *page)
 {
-	if (PageLocked(page))
-		wait_on_page_bit(compound_head(page), PG_locked);
+	struct folio *folio = page_folio(page);
+	if (FolioLocked(folio))
+		wait_on_folio_bit(folio, PG_locked);
 }
 
 static inline int wait_on_page_locked_killable(struct page *page)
 {
-	if (!PageLocked(page))
+	struct folio *folio = page_folio(page);
+	if (!FolioLocked(folio))
 		return 0;
-	return wait_on_page_bit_killable(compound_head(page), PG_locked);
+	return wait_on_folio_bit_killable(folio, PG_locked);
 }
 
 extern void put_and_wait_on_page_locked(struct page *page);
diff --git a/mm/filemap.c b/mm/filemap.c
index 3c5eb39452c3..a5925450ee13 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1075,7 +1075,7 @@ static int wake_page_function(wait_queue_entry_t *wait, unsigned mode, int sync,
 	 *
 	 * So update the flags atomically, and wake up the waiter
 	 * afterwards to avoid any races. This store-release pairs
-	 * with the load-acquire in wait_on_page_bit_common().
+	 * with the load-acquire in wait_on_folio_bit_common().
 	 */
 	smp_store_release(&wait->flags, flags | WQ_FLAG_WOKEN);
 	wake_up_state(wait->private, mode);
@@ -1156,7 +1156,7 @@ static void wake_up_folio(struct folio *folio, int bit)
 }
 
 /*
- * A choice of three behaviors for wait_on_page_bit_common():
+ * A choice of three behaviors for wait_on_folio_bit_common():
  */
 enum behavior {
 	EXCLUSIVE,	/* Hold ref to page and take the bit when woken, like
@@ -1190,9 +1190,10 @@ static inline bool trylock_page_bit_common(struct page *page, int bit_nr,
 /* How many times do we accept lock stealing from under a waiter? */
 int sysctl_page_lock_unfairness = 5;
 
-static inline int wait_on_page_bit_common(wait_queue_head_t *q,
-	struct page *page, int bit_nr, int state, enum behavior behavior)
+static inline int wait_on_folio_bit_common(struct folio *folio, int bit_nr,
+		int state, enum behavior behavior)
 {
+	wait_queue_head_t *q = page_waitqueue(&folio->page);
 	int unfairness = sysctl_page_lock_unfairness;
 	struct wait_page_queue wait_page;
 	wait_queue_entry_t *wait = &wait_page.wait;
@@ -1201,8 +1202,8 @@ static inline int wait_on_page_bit_common(wait_queue_head_t *q,
 	unsigned long pflags;
 
 	if (bit_nr == PG_locked &&
-	    !PageUptodate(page) && PageWorkingset(page)) {
-		if (!PageSwapBacked(page)) {
+	    !FolioUptodate(folio) && FolioWorkingset(folio)) {
+		if (!FolioSwapBacked(folio)) {
 			delayacct_thrashing_start();
 			delayacct = true;
 		}
@@ -1212,7 +1213,7 @@ static inline int wait_on_page_bit_common(wait_queue_head_t *q,
 
 	init_wait(wait);
 	wait->func = wake_page_function;
-	wait_page.page = page;
+	wait_page.page = &folio->page;
 	wait_page.bit_nr = bit_nr;
 
 repeat:
@@ -1227,7 +1228,7 @@ static inline int wait_on_page_bit_common(wait_queue_head_t *q,
 	 * Do one last check whether we can get the
 	 * page bit synchronously.
 	 *
-	 * Do the SetPageWaiters() marking before that
+	 * Do the SetFolioWaiters() marking before that
 	 * to let any waker we _just_ missed know they
 	 * need to wake us up (otherwise they'll never
 	 * even go to the slow case that looks at the
@@ -1238,8 +1239,8 @@ static inline int wait_on_page_bit_common(wait_queue_head_t *q,
 	 * lock to avoid races.
 	 */
 	spin_lock_irq(&q->lock);
-	SetPageWaiters(page);
-	if (!trylock_page_bit_common(page, bit_nr, wait))
+	SetFolioWaiters(folio);
+	if (!trylock_page_bit_common(&folio->page, bit_nr, wait))
 		__add_wait_queue_entry_tail(q, wait);
 	spin_unlock_irq(&q->lock);
 
@@ -1249,10 +1250,10 @@ static inline int wait_on_page_bit_common(wait_queue_head_t *q,
 	 * see whether the page bit testing has already
 	 * been done by the wake function.
 	 *
-	 * We can drop our reference to the page.
+	 * We can drop our reference to the folio.
 	 */
 	if (behavior == DROP)
-		put_page(page);
+		put_folio(folio);
 
 	/*
 	 * Note that until the "finish_wait()", or until
@@ -1289,7 +1290,7 @@ static inline int wait_on_page_bit_common(wait_queue_head_t *q,
 		 *
 		 * And if that fails, we'll have to retry this all.
 		 */
-		if (unlikely(test_and_set_bit(bit_nr, &page->flags)))
+		if (unlikely(test_and_set_bit(bit_nr, folio_flags(folio))))
 			goto repeat;
 
 		wait->flags |= WQ_FLAG_DONE;
@@ -1329,19 +1330,17 @@ static inline int wait_on_page_bit_common(wait_queue_head_t *q,
 	return wait->flags & WQ_FLAG_WOKEN ? 0 : -EINTR;
 }
 
-void wait_on_page_bit(struct page *page, int bit_nr)
+void wait_on_folio_bit(struct folio *folio, int bit_nr)
 {
-	wait_queue_head_t *q = page_waitqueue(page);
-	wait_on_page_bit_common(q, page, bit_nr, TASK_UNINTERRUPTIBLE, SHARED);
+	wait_on_folio_bit_common(folio, bit_nr, TASK_UNINTERRUPTIBLE, SHARED);
 }
-EXPORT_SYMBOL(wait_on_page_bit);
+EXPORT_SYMBOL(wait_on_folio_bit);
 
-int wait_on_page_bit_killable(struct page *page, int bit_nr)
+int wait_on_folio_bit_killable(struct folio *folio, int bit_nr)
 {
-	wait_queue_head_t *q = page_waitqueue(page);
-	return wait_on_page_bit_common(q, page, bit_nr, TASK_KILLABLE, SHARED);
+	return wait_on_folio_bit_common(folio, bit_nr, TASK_KILLABLE, SHARED);
 }
-EXPORT_SYMBOL(wait_on_page_bit_killable);
+EXPORT_SYMBOL(wait_on_folio_bit_killable);
 
 static int __wait_on_page_locked_async(struct page *page,
 				       struct wait_page_queue *wait, bool set)
@@ -1393,11 +1392,8 @@ static int wait_on_page_locked_async(struct page *page,
  */
 void put_and_wait_on_page_locked(struct page *page)
 {
-	wait_queue_head_t *q;
-
-	page = compound_head(page);
-	q = page_waitqueue(page);
-	wait_on_page_bit_common(q, page, PG_locked, TASK_UNINTERRUPTIBLE, DROP);
+	wait_on_folio_bit_common(page_folio(page), PG_locked,
+				TASK_UNINTERRUPTIBLE, DROP);
 }
 
 /**
@@ -1530,16 +1526,14 @@ EXPORT_SYMBOL_GPL(page_endio);
  */
 void __lock_folio(struct folio *folio)
 {
-	wait_queue_head_t *q = page_waitqueue(&folio->page);
-	wait_on_page_bit_common(q, &folio->page, PG_locked, TASK_UNINTERRUPTIBLE,
+	wait_on_folio_bit_common(folio, PG_locked, TASK_UNINTERRUPTIBLE,
 				EXCLUSIVE);
 }
 EXPORT_SYMBOL(__lock_folio);
 
 int __lock_folio_killable(struct folio *folio)
 {
-	wait_queue_head_t *q = page_waitqueue(&folio->page);
-	return wait_on_page_bit_common(q, &folio->page, PG_locked, TASK_KILLABLE,
+	return wait_on_folio_bit_common(folio, PG_locked, TASK_KILLABLE,
 					EXCLUSIVE);
 }
 EXPORT_SYMBOL_GPL(__lock_folio_killable);
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 586042472ac9..500ed9afcec2 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2826,9 +2826,10 @@ EXPORT_SYMBOL(__test_set_page_writeback);
  */
 void wait_on_page_writeback(struct page *page)
 {
-	if (PageWriteback(page)) {
-		trace_wait_on_page_writeback(page, page_mapping(page));
-		wait_on_page_bit(page, PG_writeback);
+	struct folio *folio = page_folio(page);
+	if (FolioWriteback(folio)) {
+		trace_wait_on_page_writeback(page, folio_mapping(folio));
+		wait_on_folio_bit(folio, PG_writeback);
 	}
 }
 EXPORT_SYMBOL_GPL(wait_on_page_writeback);
-- 
2.29.2

