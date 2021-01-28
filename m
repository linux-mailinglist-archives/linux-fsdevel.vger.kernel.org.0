Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3F0306E29
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 08:10:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbhA1HIl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 02:08:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231531AbhA1HGe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 02:06:34 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC9AC061353;
        Wed, 27 Jan 2021 23:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=eDn22njYgy16brcOrkAAMp8iBYtor2K3+ZpZIPkgrZo=; b=fFObk1dsvRE/nkV3tkLDzPLGJt
        2QZPYILedC5Vyltemv09YoWyRPxqlVmcO6gG6ZYac15mdiV1fTayaXuhToaeU8WmF9CQuqIFTSR5X
        4K+/GXIFCL4Z9CZG+GGIspRGQ0dA36nTuzSy5NCJhz7glbzRAnx73Clnd+RkW5ghlp7haGt3b7jIk
        dGs2iq/+Dv4oyDiv73QcU64SRxhoauapKFY9iHNzTFXL9HT6xJeShgJ9PjLRjghvSg2/thDlgmkr7
        dJ/LFNJDmKcDGToDUbePSgiYSzqCgJchJAijUyFXDl8xY0u0DESB7oKafQUwpvPayT8KJrLE6udF6
        jGvLn7Hw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l51MB-00848M-OQ; Thu, 28 Jan 2021 07:04:44 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 18/25] mm: Convert wait_on_page_bit to wait_on_folio_bit
Date:   Thu, 28 Jan 2021 07:03:57 +0000
Message-Id: <20210128070404.1922318-19-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210128070404.1922318-1-willy@infradead.org>
References: <20210128070404.1922318-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We must deal with folios here otherwise we'll get the wrong waitqueue
and fail to receive wakeups.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/afs/write.c          | 31 ++++++++++++-----------
 include/linux/pagemap.h | 19 +++++++++------
 mm/filemap.c            | 54 ++++++++++++++++++-----------------------
 mm/page-writeback.c     |  7 +++---
 4 files changed, 56 insertions(+), 55 deletions(-)

diff --git a/fs/afs/write.c b/fs/afs/write.c
index e672833c99bc..b3dac7afd123 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -915,13 +915,14 @@ int afs_fsync(struct file *file, loff_t start, loff_t end, int datasync)
  */
 vm_fault_t afs_page_mkwrite(struct vm_fault *vmf)
 {
-	struct page *page = thp_head(vmf->page);
+	struct folio *folio = page_folio(vmf->page);
 	struct file *file = vmf->vma->vm_file;
 	struct inode *inode = file_inode(file);
 	struct afs_vnode *vnode = AFS_FS_I(inode);
 	unsigned long priv;
 
-	_enter("{{%llx:%llu}},{%lx}", vnode->fid.vid, vnode->fid.vnode, page->index);
+	_enter("{{%llx:%llu}},{%lx}", vnode->fid.vid, vnode->fid.vnode,
+			folio->page.index);
 
 	sb_start_pagefault(inode->i_sb);
 
@@ -929,32 +930,34 @@ vm_fault_t afs_page_mkwrite(struct vm_fault *vmf)
 	 * be modified.  We then assume the entire page will need writing back.
 	 */
 #ifdef CONFIG_AFS_FSCACHE
-	if (PageFsCache(page) &&
-	    wait_on_page_bit_killable(page, PG_fscache) < 0)
+	if (FolioFsCache(folio) &&
+	    wait_on_folio_bit_killable(folio, PG_fscache) < 0)
 		return VM_FAULT_RETRY;
 #endif
 
-	if (PageWriteback(page) &&
-	    wait_on_page_bit_killable(page, PG_writeback) < 0)
+	if (FolioWriteback(folio) &&
+	    wait_on_folio_bit_killable(folio, PG_writeback) < 0)
 		return VM_FAULT_RETRY;
 
-	if (lock_page_killable(page) < 0)
+	if (lock_folio_killable(folio) < 0)
 		return VM_FAULT_RETRY;
 
 	/* We mustn't change page->private until writeback is complete as that
 	 * details the portion of the page we need to write back and we might
 	 * need to redirty the page if there's a problem.
 	 */
-	wait_on_page_writeback(page);
+	wait_on_page_writeback(&folio->page);
 
-	priv = afs_page_dirty(page, 0, thp_size(page));
+	priv = afs_page_dirty(&folio->page, 0, folio_size(folio));
 	priv = afs_page_dirty_mmapped(priv);
-	if (PagePrivate(page)) {
-		set_page_private(page, priv);
-		trace_afs_page_dirty(vnode, tracepoint_string("mkwrite+"), page);
+	if (FolioPrivate(folio)) {
+		set_folio_private(folio, priv);
+		trace_afs_page_dirty(vnode, tracepoint_string("mkwrite+"),
+				&folio->page);
 	} else {
-		attach_page_private(page, (void *)priv);
-		trace_afs_page_dirty(vnode, tracepoint_string("mkwrite"), page);
+		attach_folio_private(folio, (void *)priv);
+		trace_afs_page_dirty(vnode, tracepoint_string("mkwrite"),
+				&folio->page);
 	}
 	file_update_time(file);
 
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 67d3badc9fe0..55f3c1a8be3c 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -720,8 +720,8 @@ static inline int lock_page_or_retry(struct page *page, struct mm_struct *mm,
  * This is exported only for wait_on_page_locked/wait_on_page_writeback, etc.,
  * and should not be used directly.
  */
-extern void wait_on_page_bit(struct page *page, int bit_nr);
-extern int wait_on_page_bit_killable(struct page *page, int bit_nr);
+extern void wait_on_folio_bit(struct folio *folio, int bit_nr);
+extern int wait_on_folio_bit_killable(struct folio *folio, int bit_nr);
 
 /* 
  * Wait for a page to be unlocked.
@@ -732,15 +732,17 @@ extern int wait_on_page_bit_killable(struct page *page, int bit_nr);
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
 
 /**
@@ -752,8 +754,9 @@ static inline int wait_on_page_locked_killable(struct page *page)
  */
 static inline void wait_on_page_fscache(struct page *page)
 {
-	if (PagePrivate2(page))
-		wait_on_page_bit(compound_head(page), PG_fscache);
+	struct folio *folio = page_folio(page);
+	if (FolioPrivate2(folio))
+		wait_on_folio_bit(folio, PG_fscache);
 }
 
 int put_and_wait_on_page_locked(struct page *page, int state);
diff --git a/mm/filemap.c b/mm/filemap.c
index 65008c42e47d..f68bf0129458 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1074,7 +1074,7 @@ static int wake_page_function(wait_queue_entry_t *wait, unsigned mode, int sync,
 	 *
 	 * So update the flags atomically, and wake up the waiter
 	 * afterwards to avoid any races. This store-release pairs
-	 * with the load-acquire in wait_on_page_bit_common().
+	 * with the load-acquire in wait_on_folio_bit_common().
 	 */
 	smp_store_release(&wait->flags, flags | WQ_FLAG_WOKEN);
 	wake_up_state(wait->private, mode);
@@ -1155,7 +1155,7 @@ static void wake_up_folio(struct folio *folio, int bit)
 }
 
 /*
- * A choice of three behaviors for wait_on_page_bit_common():
+ * A choice of three behaviors for wait_on_folio_bit_common():
  */
 enum behavior {
 	EXCLUSIVE,	/* Hold ref to page and take the bit when woken, like
@@ -1189,9 +1189,10 @@ static inline bool trylock_page_bit_common(struct page *page, int bit_nr,
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
@@ -1200,8 +1201,8 @@ static inline int wait_on_page_bit_common(wait_queue_head_t *q,
 	unsigned long pflags;
 
 	if (bit_nr == PG_locked &&
-	    !PageUptodate(page) && PageWorkingset(page)) {
-		if (!PageSwapBacked(page)) {
+	    !FolioUptodate(folio) && FolioWorkingset(folio)) {
+		if (!FolioSwapBacked(folio)) {
 			delayacct_thrashing_start();
 			delayacct = true;
 		}
@@ -1211,7 +1212,7 @@ static inline int wait_on_page_bit_common(wait_queue_head_t *q,
 
 	init_wait(wait);
 	wait->func = wake_page_function;
-	wait_page.page = page;
+	wait_page.page = &folio->page;
 	wait_page.bit_nr = bit_nr;
 
 repeat:
@@ -1226,7 +1227,7 @@ static inline int wait_on_page_bit_common(wait_queue_head_t *q,
 	 * Do one last check whether we can get the
 	 * page bit synchronously.
 	 *
-	 * Do the SetPageWaiters() marking before that
+	 * Do the SetFolioWaiters() marking before that
 	 * to let any waker we _just_ missed know they
 	 * need to wake us up (otherwise they'll never
 	 * even go to the slow case that looks at the
@@ -1237,8 +1238,8 @@ static inline int wait_on_page_bit_common(wait_queue_head_t *q,
 	 * lock to avoid races.
 	 */
 	spin_lock_irq(&q->lock);
-	SetPageWaiters(page);
-	if (!trylock_page_bit_common(page, bit_nr, wait))
+	SetFolioWaiters(folio);
+	if (!trylock_page_bit_common(&folio->page, bit_nr, wait))
 		__add_wait_queue_entry_tail(q, wait);
 	spin_unlock_irq(&q->lock);
 
@@ -1248,10 +1249,10 @@ static inline int wait_on_page_bit_common(wait_queue_head_t *q,
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
@@ -1288,7 +1289,7 @@ static inline int wait_on_page_bit_common(wait_queue_head_t *q,
 		 *
 		 * And if that fails, we'll have to retry this all.
 		 */
-		if (unlikely(test_and_set_bit(bit_nr, &page->flags)))
+		if (unlikely(test_and_set_bit(bit_nr, folio_flags(folio))))
 			goto repeat;
 
 		wait->flags |= WQ_FLAG_DONE;
@@ -1328,19 +1329,17 @@ static inline int wait_on_page_bit_common(wait_queue_head_t *q,
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
@@ -1357,11 +1356,8 @@ EXPORT_SYMBOL(wait_on_page_bit_killable);
  */
 int put_and_wait_on_page_locked(struct page *page, int state)
 {
-	wait_queue_head_t *q;
-
-	page = compound_head(page);
-	q = page_waitqueue(page);
-	return wait_on_page_bit_common(q, page, PG_locked, state, DROP);
+	wait_on_folio_bit_common(page_folio(page), PG_locked,
+				state, DROP);
 }
 
 /**
@@ -1510,16 +1506,14 @@ EXPORT_SYMBOL_GPL(page_endio);
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

