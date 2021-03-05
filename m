Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20B9E32E0BB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Mar 2021 05:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbhCEE0N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Mar 2021 23:26:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbhCEE0N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Mar 2021 23:26:13 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC586C061574;
        Thu,  4 Mar 2021 20:26:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=A240a8RFlOLCpB1wjQo7mwwJUGZkhVYLRXzrJQR2XmA=; b=g0KWz96LnDBzndIXXzd8dvEQ56
        LEH5ZFAbtdATCWQxf4jQ45SE20bfh8mEKCeJLp9Oot0HQtKbfqdUQmGaQf1+Jlzz8uWNNRCQPY30E
        EnQdBK01XKOP113YHg0qEIwgKPYEsNPLinQkEBFr/zXd2wb347nKpn9IOR3ahIxtR3zDapG4QYPlk
        QEuCM/RGY69Ox8EDiQJx+z3Rk7Up3BP+8Flt1SQr7vf1yJCE9ITNv0MYi0B1MJqEcFleJjgqMejRJ
        AnzIEqt1xjbHHMPPwzQ/7eZ6jx3M4aAKFGDU4jKtlevQf2+bEOq8/yIg9OnB6STmDwXce3AXufgnx
        Dm4vrbxg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lI21d-00A4ff-94; Fri, 05 Mar 2021 04:25:22 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 20/25] mm/filemap: Convert wait_on_page_bit to wait_on_folio_bit
Date:   Fri,  5 Mar 2021 04:18:56 +0000
Message-Id: <20210305041901.2396498-21-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210305041901.2396498-1-willy@infradead.org>
References: <20210305041901.2396498-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We must always wait on the folio, otherwise we won't be woken up.

This commit shrinks the kernel by 695 bytes, mostly due to moving
the page waitqueue lookup into wait_on_folio_bit_common().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/afs/write.c          | 21 ++++++++--------
 include/linux/pagemap.h | 10 ++++----
 mm/filemap.c            | 56 ++++++++++++++++++-----------------------
 mm/page-writeback.c     |  2 +-
 4 files changed, 42 insertions(+), 47 deletions(-)

diff --git a/fs/afs/write.c b/fs/afs/write.c
index c9195fc67fd8..0c313117200a 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -834,13 +834,14 @@ int afs_fsync(struct file *file, loff_t start, loff_t end, int datasync)
  */
 vm_fault_t afs_page_mkwrite(struct vm_fault *vmf)
 {
+	struct folio *folio = page_folio(vmf->page);
 	struct file *file = vmf->vma->vm_file;
 	struct inode *inode = file_inode(file);
 	struct afs_vnode *vnode = AFS_FS_I(inode);
 	unsigned long priv;
 
 	_enter("{{%llx:%llu}},{%lx}",
-	       vnode->fid.vid, vnode->fid.vnode, vmf->page->index);
+	       vnode->fid.vid, vnode->fid.vnode, folio->page.index);
 
 	sb_start_pagefault(inode->i_sb);
 
@@ -851,27 +852,27 @@ vm_fault_t afs_page_mkwrite(struct vm_fault *vmf)
 	fscache_wait_on_page_write(vnode->cache, vmf->page);
 #endif
 
-	if (PageWriteback(vmf->page) &&
-	    wait_on_page_bit_killable(vmf->page, PG_writeback) < 0)
+	if (FolioWriteback(folio) &&
+	    wait_on_folio_bit_killable(folio, PG_writeback) < 0)
 		return VM_FAULT_RETRY;
 
-	if (lock_page_killable(vmf->page) < 0)
+	if (lock_folio_killable(folio) < 0)
 		return VM_FAULT_RETRY;
 
 	/* We mustn't change page->private until writeback is complete as that
 	 * details the portion of the page we need to write back and we might
 	 * need to redirty the page if there's a problem.
 	 */
-	wait_on_page_writeback(vmf->page);
+	wait_on_folio_writeback(folio);
 
-	priv = afs_page_dirty(0, PAGE_SIZE);
+	priv = afs_page_dirty(0, folio_size(folio));
 	priv = afs_page_dirty_mmapped(priv);
 	trace_afs_page_dirty(vnode, tracepoint_string("mkwrite"),
-			     vmf->page->index, priv);
-	if (PagePrivate(vmf->page))
-		set_page_private(vmf->page, priv);
+			     folio->page.index, priv);
+	if (FolioPrivate(folio))
+		set_folio_private(folio, priv);
 	else
-		attach_page_private(vmf->page, (void *)priv);
+		attach_folio_private(folio, (void *)priv);
 	file_update_time(file);
 
 	sb_end_pagefault(inode->i_sb);
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index e7ca8def2f0d..8737eb86602e 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -725,11 +725,11 @@ static inline int lock_page_or_retry(struct page *page, struct mm_struct *mm,
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
@@ -741,14 +741,14 @@ extern int wait_on_page_bit_killable(struct page *page, int bit_nr);
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
index 50263fa62574..ec5a743b4e0f 100644
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
@@ -1298,7 +1299,7 @@ static inline int wait_on_page_bit_common(wait_queue_head_t *q,
 
 	/*
 	 * If a signal happened, this 'finish_wait()' may remove the last
-	 * waiter from the wait-queues, but the PageWaiters bit will remain
+	 * waiter from the wait-queues, but the FolioWaiters bit will remain
 	 * set. That's ok. The next wakeup will take care of it, and trying
 	 * to do it here would be difficult and prone to races.
 	 */
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
 
 /**
  * put_and_wait_on_page_locked - Drop a reference and wait for it to be unlocked
@@ -1358,11 +1357,8 @@ EXPORT_SYMBOL(wait_on_page_bit_killable);
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
@@ -1493,16 +1489,14 @@ EXPORT_SYMBOL_GPL(page_endio);
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
index eef36edc9e0c..6c1b4737c383 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2835,7 +2835,7 @@ void wait_on_folio_writeback(struct folio *folio)
 {
 	while (FolioWriteback(folio)) {
 		trace_wait_on_page_writeback(&folio->page, folio_mapping(folio));
-		wait_on_page_bit(&folio->page, PG_writeback);
+		wait_on_folio_bit(folio, PG_writeback);
 	}
 }
 EXPORT_SYMBOL_GPL(wait_on_folio_writeback);
-- 
2.30.0

