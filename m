Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A66143A707F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jun 2021 22:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235302AbhFNUfJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Jun 2021 16:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233352AbhFNUfI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Jun 2021 16:35:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A0DC061574;
        Mon, 14 Jun 2021 13:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=jYFhjU6geHdIkGAXhc4aWSiWS5JJ0EEh0j9y/wkxhxU=; b=MG9Y0s6zv6wl2QjRW8ST5gIRhO
        aX1N/t76n8N95fX9OuDcVP2DwYBB5rcqiV+HcrjwdQDD1G2W8UMQhArFsRMPtU1E6+qkq2syJ78L2
        B7rCY9cAxMig+DllBI0VbErg+5ffPXgVXFtCVTSkAz2eTD9CR7b7zv42fCUr3cHaZD96OsVhR4J7M
        qGNZstTLqlJJHqf0g2zd0C5Jf0nu/wiott4xF0bl7Km/LJ8FO3qYwG0Bws2VwhNaOSByT5n2CdXru
        2dP5NdjZWlXpjGMN8Tql9BSxz378bdot9mVoxukI98ufIGYoXluUsAjZ9cUjAVOUBXVNevDZ44pwb
        Akdr4jWg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lstFI-005oGM-PQ; Mon, 14 Jun 2021 20:32:04 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     akpm@linux-foundation.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>
Subject: [PATCH v11 28/33] mm/filemap: Add folio_wait_bit()
Date:   Mon, 14 Jun 2021 21:14:30 +0100
Message-Id: <20210614201435.1379188-29-willy@infradead.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210614201435.1379188-1-willy@infradead.org>
References: <20210614201435.1379188-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Rename wait_on_page_bit() to folio_wait_bit().  We must always wait on
the folio, otherwise we won't be woken up due to the tail page hashing
to a different bucket from the head page.

This commit shrinks the kernel by 770 bytes, mostly due to moving
the page waitqueue lookup into folio_wait_bit_common().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Acked-by: Jeff Layton <jlayton@kernel.org>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
---
 include/linux/pagemap.h | 10 +++---
 mm/filemap.c            | 77 +++++++++++++++++++----------------------
 mm/page-writeback.c     |  4 +--
 3 files changed, 43 insertions(+), 48 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 8e31a02d3a56..6759f155eeda 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -717,11 +717,11 @@ static inline int lock_page_or_retry(struct page *page, struct mm_struct *mm,
 }
 
 /*
- * This is exported only for wait_on_page_locked/wait_on_page_writeback, etc.,
+ * This is exported only for folio_wait_locked/folio_wait_writeback, etc.,
  * and should not be used directly.
  */
-extern void wait_on_page_bit(struct page *page, int bit_nr);
-extern int wait_on_page_bit_killable(struct page *page, int bit_nr);
+void folio_wait_bit(struct folio *folio, int bit_nr);
+int folio_wait_bit_killable(struct folio *folio, int bit_nr);
 
 /* 
  * Wait for a folio to be unlocked.
@@ -733,14 +733,14 @@ extern int wait_on_page_bit_killable(struct page *page, int bit_nr);
 static inline void folio_wait_locked(struct folio *folio)
 {
 	if (folio_locked(folio))
-		wait_on_page_bit(&folio->page, PG_locked);
+		folio_wait_bit(folio, PG_locked);
 }
 
 static inline int folio_wait_locked_killable(struct folio *folio)
 {
 	if (!folio_locked(folio))
 		return 0;
-	return wait_on_page_bit_killable(&folio->page, PG_locked);
+	return folio_wait_bit_killable(folio, PG_locked);
 }
 
 static inline void wait_on_page_locked(struct page *page)
diff --git a/mm/filemap.c b/mm/filemap.c
index eb95a95d90c5..5c48b8dc1009 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1102,7 +1102,7 @@ static int wake_page_function(wait_queue_entry_t *wait, unsigned mode, int sync,
 	 *
 	 * So update the flags atomically, and wake up the waiter
 	 * afterwards to avoid any races. This store-release pairs
-	 * with the load-acquire in wait_on_page_bit_common().
+	 * with the load-acquire in folio_wait_bit_common().
 	 */
 	smp_store_release(&wait->flags, flags | WQ_FLAG_WOKEN);
 	wake_up_state(wait->private, mode);
@@ -1183,7 +1183,7 @@ static void folio_wake(struct folio *folio, int bit)
 }
 
 /*
- * A choice of three behaviors for wait_on_page_bit_common():
+ * A choice of three behaviors for folio_wait_bit_common():
  */
 enum behavior {
 	EXCLUSIVE,	/* Hold ref to page and take the bit when woken, like
@@ -1198,16 +1198,16 @@ enum behavior {
 };
 
 /*
- * Attempt to check (or get) the page bit, and mark us done
+ * Attempt to check (or get) the folio flag, and mark us done
  * if successful.
  */
-static inline bool trylock_page_bit_common(struct page *page, int bit_nr,
+static inline bool folio_trylock_flag(struct folio *folio, int bit_nr,
 					struct wait_queue_entry *wait)
 {
 	if (wait->flags & WQ_FLAG_EXCLUSIVE) {
-		if (test_and_set_bit(bit_nr, &page->flags))
+		if (test_and_set_bit(bit_nr, &folio->flags))
 			return false;
-	} else if (test_bit(bit_nr, &page->flags))
+	} else if (test_bit(bit_nr, &folio->flags))
 		return false;
 
 	wait->flags |= WQ_FLAG_WOKEN | WQ_FLAG_DONE;
@@ -1217,9 +1217,10 @@ static inline bool trylock_page_bit_common(struct page *page, int bit_nr,
 /* How many times do we accept lock stealing from under a waiter? */
 int sysctl_page_lock_unfairness = 5;
 
-static inline int wait_on_page_bit_common(wait_queue_head_t *q,
-	struct page *page, int bit_nr, int state, enum behavior behavior)
+static inline int folio_wait_bit_common(struct folio *folio, int bit_nr,
+		int state, enum behavior behavior)
 {
+	wait_queue_head_t *q = page_waitqueue(&folio->page);
 	int unfairness = sysctl_page_lock_unfairness;
 	struct wait_page_queue wait_page;
 	wait_queue_entry_t *wait = &wait_page.wait;
@@ -1228,8 +1229,8 @@ static inline int wait_on_page_bit_common(wait_queue_head_t *q,
 	unsigned long pflags;
 
 	if (bit_nr == PG_locked &&
-	    !PageUptodate(page) && PageWorkingset(page)) {
-		if (!PageSwapBacked(page)) {
+	    !folio_uptodate(folio) && folio_workingset(folio)) {
+		if (!folio_swapbacked(folio)) {
 			delayacct_thrashing_start();
 			delayacct = true;
 		}
@@ -1239,7 +1240,7 @@ static inline int wait_on_page_bit_common(wait_queue_head_t *q,
 
 	init_wait(wait);
 	wait->func = wake_page_function;
-	wait_page.page = page;
+	wait_page.page = &folio->page;
 	wait_page.bit_nr = bit_nr;
 
 repeat:
@@ -1254,7 +1255,7 @@ static inline int wait_on_page_bit_common(wait_queue_head_t *q,
 	 * Do one last check whether we can get the
 	 * page bit synchronously.
 	 *
-	 * Do the SetPageWaiters() marking before that
+	 * Do the folio_set_waiters_flag() marking before that
 	 * to let any waker we _just_ missed know they
 	 * need to wake us up (otherwise they'll never
 	 * even go to the slow case that looks at the
@@ -1265,8 +1266,8 @@ static inline int wait_on_page_bit_common(wait_queue_head_t *q,
 	 * lock to avoid races.
 	 */
 	spin_lock_irq(&q->lock);
-	SetPageWaiters(page);
-	if (!trylock_page_bit_common(page, bit_nr, wait))
+	folio_set_waiters_flag(folio);
+	if (!folio_trylock_flag(folio, bit_nr, wait))
 		__add_wait_queue_entry_tail(q, wait);
 	spin_unlock_irq(&q->lock);
 
@@ -1276,10 +1277,10 @@ static inline int wait_on_page_bit_common(wait_queue_head_t *q,
 	 * see whether the page bit testing has already
 	 * been done by the wake function.
 	 *
-	 * We can drop our reference to the page.
+	 * We can drop our reference to the folio.
 	 */
 	if (behavior == DROP)
-		put_page(page);
+		folio_put(folio);
 
 	/*
 	 * Note that until the "finish_wait()", or until
@@ -1316,7 +1317,7 @@ static inline int wait_on_page_bit_common(wait_queue_head_t *q,
 		 *
 		 * And if that fails, we'll have to retry this all.
 		 */
-		if (unlikely(test_and_set_bit(bit_nr, &page->flags)))
+		if (unlikely(test_and_set_bit(bit_nr, folio_flags(folio, 0))))
 			goto repeat;
 
 		wait->flags |= WQ_FLAG_DONE;
@@ -1325,7 +1326,7 @@ static inline int wait_on_page_bit_common(wait_queue_head_t *q,
 
 	/*
 	 * If a signal happened, this 'finish_wait()' may remove the last
-	 * waiter from the wait-queues, but the PageWaiters bit will remain
+	 * waiter from the wait-queues, but the folio_waiters bit will remain
 	 * set. That's ok. The next wakeup will take care of it, and trying
 	 * to do it here would be difficult and prone to races.
 	 */
@@ -1356,19 +1357,17 @@ static inline int wait_on_page_bit_common(wait_queue_head_t *q,
 	return wait->flags & WQ_FLAG_WOKEN ? 0 : -EINTR;
 }
 
-void wait_on_page_bit(struct page *page, int bit_nr)
+void folio_wait_bit(struct folio *folio, int bit_nr)
 {
-	wait_queue_head_t *q = page_waitqueue(page);
-	wait_on_page_bit_common(q, page, bit_nr, TASK_UNINTERRUPTIBLE, SHARED);
+	folio_wait_bit_common(folio, bit_nr, TASK_UNINTERRUPTIBLE, SHARED);
 }
-EXPORT_SYMBOL(wait_on_page_bit);
+EXPORT_SYMBOL(folio_wait_bit);
 
-int wait_on_page_bit_killable(struct page *page, int bit_nr)
+int folio_wait_bit_killable(struct folio *folio, int bit_nr)
 {
-	wait_queue_head_t *q = page_waitqueue(page);
-	return wait_on_page_bit_common(q, page, bit_nr, TASK_KILLABLE, SHARED);
+	return folio_wait_bit_common(folio, bit_nr, TASK_KILLABLE, SHARED);
 }
-EXPORT_SYMBOL(wait_on_page_bit_killable);
+EXPORT_SYMBOL(folio_wait_bit_killable);
 
 /**
  * put_and_wait_on_page_locked - Drop a reference and wait for it to be unlocked
@@ -1385,11 +1384,8 @@ EXPORT_SYMBOL(wait_on_page_bit_killable);
  */
 int put_and_wait_on_page_locked(struct page *page, int state)
 {
-	wait_queue_head_t *q;
-
-	page = compound_head(page);
-	q = page_waitqueue(page);
-	return wait_on_page_bit_common(q, page, PG_locked, state, DROP);
+	return folio_wait_bit_common(page_folio(page), PG_locked, state,
+			DROP);
 }
 
 /**
@@ -1483,9 +1479,10 @@ EXPORT_SYMBOL(end_page_private_2);
  */
 void wait_on_page_private_2(struct page *page)
 {
-	page = compound_head(page);
-	while (PagePrivate2(page))
-		wait_on_page_bit(page, PG_private_2);
+	struct folio *folio = page_folio(page);
+
+	while (folio_private_2(folio))
+		folio_wait_bit(folio, PG_private_2);
 }
 EXPORT_SYMBOL(wait_on_page_private_2);
 
@@ -1502,11 +1499,11 @@ EXPORT_SYMBOL(wait_on_page_private_2);
  */
 int wait_on_page_private_2_killable(struct page *page)
 {
+	struct folio *folio = page_folio(page);
 	int ret = 0;
 
-	page = compound_head(page);
-	while (PagePrivate2(page)) {
-		ret = wait_on_page_bit_killable(page, PG_private_2);
+	while (folio_private_2(folio)) {
+		ret = folio_wait_bit_killable(folio, PG_private_2);
 		if (ret < 0)
 			break;
 	}
@@ -1583,16 +1580,14 @@ EXPORT_SYMBOL_GPL(page_endio);
  */
 void __folio_lock(struct folio *folio)
 {
-	wait_queue_head_t *q = page_waitqueue(&folio->page);
-	wait_on_page_bit_common(q, &folio->page, PG_locked, TASK_UNINTERRUPTIBLE,
+	folio_wait_bit_common(folio, PG_locked, TASK_UNINTERRUPTIBLE,
 				EXCLUSIVE);
 }
 EXPORT_SYMBOL(__folio_lock);
 
 int __folio_lock_killable(struct folio *folio)
 {
-	wait_queue_head_t *q = page_waitqueue(&folio->page);
-	return wait_on_page_bit_common(q, &folio->page, PG_locked, TASK_KILLABLE,
+	return folio_wait_bit_common(folio, PG_locked, TASK_KILLABLE,
 					EXCLUSIVE);
 }
 EXPORT_SYMBOL_GPL(__folio_lock_killable);
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 8b15c44552f7..157ed52e4b7d 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2834,7 +2834,7 @@ void folio_wait_writeback(struct folio *folio)
 {
 	while (folio_writeback(folio)) {
 		trace_wait_on_page_writeback(&folio->page, folio_mapping(folio));
-		wait_on_page_bit(&folio->page, PG_writeback);
+		folio_wait_bit(folio, PG_writeback);
 	}
 }
 EXPORT_SYMBOL_GPL(folio_wait_writeback);
@@ -2856,7 +2856,7 @@ int folio_wait_writeback_killable(struct folio *folio)
 {
 	while (folio_writeback(folio)) {
 		trace_wait_on_page_writeback(&folio->page, folio_mapping(folio));
-		if (wait_on_page_bit_killable(&folio->page, PG_writeback))
+		if (folio_wait_bit_killable(folio, PG_writeback))
 			return -EINTR;
 	}
 
-- 
2.30.2

