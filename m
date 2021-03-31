Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82B94350706
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Mar 2021 20:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235335AbhCaS4S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Mar 2021 14:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235264AbhCaSzl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Mar 2021 14:55:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F22BAC061574;
        Wed, 31 Mar 2021 11:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=1zffzRfF/qksfUk6SCeozTWh8oZItRpb2EQLHTuYvzI=; b=orLBgQzrijrW5OpsL7osfl8ckM
        nbYoQTlwXQmtmILknHgpK8O6X3sO4Mo9C1BF2jUXv2EwlahZaRokAVnAvfgdRjMLI00YYnCKzdVAZ
        ZzugK+Ln3CIlZavNVv+1YGJFrH9Sbqt5pzKpRbJL3G78G29qZh0IWWFr45vBVvgcT2C1pb6aGGM1j
        bN4fZSC6u3amoyRcTcTjKdZ16akY7VMknlN+HoxfQzdXluGSFHel/Qh4VRD3b4MkVC0NxRlJK98lS
        Z5OX/ZBFGmoNLjGsPyU9zbmNRCox+nMoefzSxpMSeeCSXNvt6MGSuRn9ORtJe4pdoEpUlILqYQl0+
        HFnyXW9w==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lRfys-004zob-MF; Wed, 31 Mar 2021 18:54:20 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org
Subject: [PATCH v6 25/27] mm/filemap: Convert wait_on_page_bit to wait_on_folio_bit
Date:   Wed, 31 Mar 2021 19:47:26 +0100
Message-Id: <20210331184728.1188084-26-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210331184728.1188084-1-willy@infradead.org>
References: <20210331184728.1188084-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We must always wait on the folio, otherwise we won't be woken up.

This commit shrinks the kernel by 691 bytes, mostly due to moving
the page waitqueue lookup into wait_on_folio_bit_common().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/afs/write.c          |  2 +-
 include/linux/netfs.h   |  2 +-
 include/linux/pagemap.h | 10 ++++----
 mm/filemap.c            | 56 ++++++++++++++++++-----------------------
 mm/page-writeback.c     |  4 +--
 5 files changed, 34 insertions(+), 40 deletions(-)

diff --git a/fs/afs/write.c b/fs/afs/write.c
index 7af2b57e601b..93f15e5770f2 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -847,7 +847,7 @@ vm_fault_t afs_page_mkwrite(struct vm_fault *vmf)
 	 */
 #ifdef CONFIG_AFS_FSCACHE
 	if (PageFsCache(page) &&
-	    wait_on_page_bit_killable(page, PG_fscache) < 0)
+	    wait_on_folio_bit_killable(folio, PG_fscache) < 0)
 		return VM_FAULT_RETRY;
 #endif
 
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 9d3fbed4e30a..f44142dca767 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -54,7 +54,7 @@ static inline void unlock_page_fscache(struct page *page)
 static inline void wait_on_page_fscache(struct page *page)
 {
 	if (PageFsCache(page))
-		wait_on_page_bit(compound_head(page), PG_fscache);
+		wait_on_folio_bit(page_folio(page), PG_fscache);
 }
 
 enum netfs_read_source {
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 001f8ec67ee7..d800fae55f98 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -791,11 +791,11 @@ static inline int lock_page_or_retry(struct page *page, struct mm_struct *mm,
 }
 
 /*
- * This is exported only for wait_on_page_locked/wait_on_page_writeback, etc.,
+ * This is exported only for wait_on_folio_locked/wait_on_folio_writeback, etc.,
  * and should not be used directly.
  */
-extern void wait_on_page_bit(struct page *page, int bit_nr);
-extern int wait_on_page_bit_killable(struct page *page, int bit_nr);
+extern void wait_on_folio_bit(struct folio *folio, int bit_nr);
+extern int wait_on_folio_bit_killable(struct folio *folio, int bit_nr);
 
 /* 
  * Wait for a folio to be unlocked.
@@ -807,14 +807,14 @@ extern int wait_on_page_bit_killable(struct page *page, int bit_nr);
 static inline void wait_on_folio_locked(struct folio *folio)
 {
 	if (FolioLocked(folio))
-		wait_on_page_bit(&folio->page, PG_locked);
+		wait_on_folio_bit(folio, PG_locked);
 }
 
 static inline int wait_on_folio_locked_killable(struct folio *folio)
 {
 	if (!FolioLocked(folio))
 		return 0;
-	return wait_on_page_bit_killable(&folio->page, PG_locked);
+	return wait_on_folio_bit_killable(folio, PG_locked);
 }
 
 static inline void wait_on_page_locked(struct page *page)
diff --git a/mm/filemap.c b/mm/filemap.c
index 4591974f2c28..76e1c4be1205 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1102,7 +1102,7 @@ static int wake_page_function(wait_queue_entry_t *wait, unsigned mode, int sync,
 	 *
 	 * So update the flags atomically, and wake up the waiter
 	 * afterwards to avoid any races. This store-release pairs
-	 * with the load-acquire in wait_on_page_bit_common().
+	 * with the load-acquire in wait_on_folio_bit_common().
 	 */
 	smp_store_release(&wait->flags, flags | WQ_FLAG_WOKEN);
 	wake_up_state(wait->private, mode);
@@ -1183,7 +1183,7 @@ static void wake_up_folio(struct folio *folio, int bit)
 }
 
 /*
- * A choice of three behaviors for wait_on_page_bit_common():
+ * A choice of three behaviors for wait_on_folio_bit_common():
  */
 enum behavior {
 	EXCLUSIVE,	/* Hold ref to page and take the bit when woken, like
@@ -1217,9 +1217,10 @@ static inline bool trylock_page_bit_common(struct page *page, int bit_nr,
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
@@ -1228,8 +1229,8 @@ static inline int wait_on_page_bit_common(wait_queue_head_t *q,
 	unsigned long pflags;
 
 	if (bit_nr == PG_locked &&
-	    !PageUptodate(page) && PageWorkingset(page)) {
-		if (!PageSwapBacked(page)) {
+	    !FolioUptodate(folio) && FolioWorkingset(folio)) {
+		if (!FolioSwapBacked(folio)) {
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
+	 * Do the SetFolioWaiters() marking before that
 	 * to let any waker we _just_ missed know they
 	 * need to wake us up (otherwise they'll never
 	 * even go to the slow case that looks at the
@@ -1265,8 +1266,8 @@ static inline int wait_on_page_bit_common(wait_queue_head_t *q,
 	 * lock to avoid races.
 	 */
 	spin_lock_irq(&q->lock);
-	SetPageWaiters(page);
-	if (!trylock_page_bit_common(page, bit_nr, wait))
+	SetFolioWaiters(folio);
+	if (!trylock_page_bit_common(&folio->page, bit_nr, wait))
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
+		put_folio(folio);
 
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
+	 * waiter from the wait-queues, but the FolioWaiters bit will remain
 	 * set. That's ok. The next wakeup will take care of it, and trying
 	 * to do it here would be difficult and prone to races.
 	 */
@@ -1356,19 +1357,17 @@ static inline int wait_on_page_bit_common(wait_queue_head_t *q,
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
+	return wait_on_folio_bit_common(page_folio(page), PG_locked, state,
+			DROP);
 }
 
 /**
@@ -1540,16 +1536,14 @@ EXPORT_SYMBOL_GPL(page_endio);
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
index 9d55ceec05c0..7aed4feabdd2 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2834,7 +2834,7 @@ void wait_on_folio_writeback(struct folio *folio)
 {
 	while (FolioWriteback(folio)) {
 		trace_wait_on_page_writeback(&folio->page, folio_mapping(folio));
-		wait_on_page_bit(&folio->page, PG_writeback);
+		wait_on_folio_bit(folio, PG_writeback);
 	}
 }
 EXPORT_SYMBOL_GPL(wait_on_folio_writeback);
@@ -2856,7 +2856,7 @@ int wait_on_folio_writeback_killable(struct folio *folio)
 {
 	while (FolioWriteback(folio)) {
 		trace_wait_on_page_writeback(&folio->page, folio_mapping(folio));
-		if (wait_on_page_bit_killable(&folio->page, PG_writeback))
+		if (wait_on_folio_bit_killable(folio, PG_writeback))
 			return -EINTR;
 	}
 
-- 
2.30.2

