Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 692772FA735
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Jan 2021 18:15:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406910AbhARROG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Jan 2021 12:14:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393305AbhARRDs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Jan 2021 12:03:48 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9660AC061575;
        Mon, 18 Jan 2021 09:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=oKL/0AT1Nju7i0tcqHvT0oZa3hDLpZ7KrfoZxjjiYIw=; b=kWfJepuJxOa/1cruoHb0LdtDkz
        dwMpHh18tMci0Acgcomcsy/u0vqcknsHxpZzT5IJA6zi6ktj3pt6Dosyb/r3fg6ZZi2sJ2Zi7bYxt
        r8mwYWlJ9i6yHzt7rP4L+d+UFqDy4UDh6c+5aof+7ZMPb72w5lhqh52YwnCKYh/0tMTWgtVKop2U8
        h4UeFpwLv9jU67PuRIKGRFAcqIxbibcHVvMjS8hODdG/PWCrSIDBWGUpO50LmTloLL8uHEteYThxM
        oZoode8AGbscIzfe456CkFWMYAy6F+Eve4slkPS5z5XNLG9PE06LV9twr3qCCXgNDTYgy8tzmJlUb
        yODOsHZA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l1Xvs-00D7Tr-BJ; Mon, 18 Jan 2021 17:03:17 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 20/27] mm: Convert wait_on_page_bit to wait_on_folio_bit
Date:   Mon, 18 Jan 2021 17:01:41 +0000
Message-Id: <20210118170148.3126186-21-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210118170148.3126186-1-willy@infradead.org>
References: <20210118170148.3126186-1-willy@infradead.org>
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
index 7a79e159307c..685f1b394629 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -719,8 +719,8 @@ static inline int lock_page_or_retry(struct page *page, struct mm_struct *mm,
  * This is exported only for wait_on_page_locked/wait_on_page_writeback, etc.,
  * and should not be used directly.
  */
-extern void wait_on_page_bit(struct page *page, int bit_nr);
-extern int wait_on_page_bit_killable(struct page *page, int bit_nr);
+extern void wait_on_folio_bit(struct folio *folio, int bit_nr);
+extern int wait_on_folio_bit_killable(struct folio *folio, int bit_nr);
 
 /* 
  * Wait for a page to be unlocked.
@@ -731,15 +731,17 @@ extern int wait_on_page_bit_killable(struct page *page, int bit_nr);
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
index 952457071630..7670e0c7dd97 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1070,7 +1070,7 @@ static int wake_page_function(wait_queue_entry_t *wait, unsigned mode, int sync,
 	 *
 	 * So update the flags atomically, and wake up the waiter
 	 * afterwards to avoid any races. This store-release pairs
-	 * with the load-acquire in wait_on_page_bit_common().
+	 * with the load-acquire in wait_on_folio_bit_common().
 	 */
 	smp_store_release(&wait->flags, flags | WQ_FLAG_WOKEN);
 	wake_up_state(wait->private, mode);
@@ -1151,7 +1151,7 @@ static void wake_up_folio(struct folio *folio, int bit)
 }
 
 /*
- * A choice of three behaviors for wait_on_page_bit_common():
+ * A choice of three behaviors for wait_on_folio_bit_common():
  */
 enum behavior {
 	EXCLUSIVE,	/* Hold ref to page and take the bit when woken, like
@@ -1185,9 +1185,10 @@ static inline bool trylock_page_bit_common(struct page *page, int bit_nr,
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
@@ -1196,8 +1197,8 @@ static inline int wait_on_page_bit_common(wait_queue_head_t *q,
 	unsigned long pflags;
 
 	if (bit_nr == PG_locked &&
-	    !PageUptodate(page) && PageWorkingset(page)) {
-		if (!PageSwapBacked(page)) {
+	    !FolioUptodate(folio) && FolioWorkingset(folio)) {
+		if (!FolioSwapBacked(folio)) {
 			delayacct_thrashing_start();
 			delayacct = true;
 		}
@@ -1207,7 +1208,7 @@ static inline int wait_on_page_bit_common(wait_queue_head_t *q,
 
 	init_wait(wait);
 	wait->func = wake_page_function;
-	wait_page.page = page;
+	wait_page.page = &folio->page;
 	wait_page.bit_nr = bit_nr;
 
 repeat:
@@ -1222,7 +1223,7 @@ static inline int wait_on_page_bit_common(wait_queue_head_t *q,
 	 * Do one last check whether we can get the
 	 * page bit synchronously.
 	 *
-	 * Do the SetPageWaiters() marking before that
+	 * Do the SetFolioWaiters() marking before that
 	 * to let any waker we _just_ missed know they
 	 * need to wake us up (otherwise they'll never
 	 * even go to the slow case that looks at the
@@ -1233,8 +1234,8 @@ static inline int wait_on_page_bit_common(wait_queue_head_t *q,
 	 * lock to avoid races.
 	 */
 	spin_lock_irq(&q->lock);
-	SetPageWaiters(page);
-	if (!trylock_page_bit_common(page, bit_nr, wait))
+	SetFolioWaiters(folio);
+	if (!trylock_page_bit_common(&folio->page, bit_nr, wait))
 		__add_wait_queue_entry_tail(q, wait);
 	spin_unlock_irq(&q->lock);
 
@@ -1244,10 +1245,10 @@ static inline int wait_on_page_bit_common(wait_queue_head_t *q,
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
@@ -1284,7 +1285,7 @@ static inline int wait_on_page_bit_common(wait_queue_head_t *q,
 		 *
 		 * And if that fails, we'll have to retry this all.
 		 */
-		if (unlikely(test_and_set_bit(bit_nr, &page->flags)))
+		if (unlikely(test_and_set_bit(bit_nr, folio_flags(folio))))
 			goto repeat;
 
 		wait->flags |= WQ_FLAG_DONE;
@@ -1324,19 +1325,17 @@ static inline int wait_on_page_bit_common(wait_queue_head_t *q,
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
 
 static int __wait_on_folio_locked_async(struct folio *folio,
 				       struct wait_page_queue *wait, bool set)
@@ -1388,11 +1387,8 @@ static int wait_on_folio_locked_async(struct folio *folio,
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
@@ -1523,16 +1519,14 @@ EXPORT_SYMBOL_GPL(page_endio);
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
index eb34d204d4ee..51b4326f0aaa 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2826,9 +2826,10 @@ EXPORT_SYMBOL(__test_set_page_writeback);
  */
 void wait_on_page_writeback(struct page *page)
 {
-	while (PageWriteback(page)) {
-		trace_wait_on_page_writeback(page, page_mapping(page));
-		wait_on_page_bit(page, PG_writeback);
+	struct folio *folio = page_folio(page);
+	while (FolioWriteback(folio)) {
+		trace_wait_on_page_writeback(page, folio_mapping(folio));
+		wait_on_folio_bit(folio, PG_writeback);
 	}
 }
 EXPORT_SYMBOL_GPL(wait_on_page_writeback);
-- 
2.29.2

