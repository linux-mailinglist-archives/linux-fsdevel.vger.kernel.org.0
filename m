Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA072FA707
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Jan 2021 18:06:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406914AbhARRGa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Jan 2021 12:06:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406811AbhARREW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Jan 2021 12:04:22 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A284AC061786;
        Mon, 18 Jan 2021 09:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=TDmagHNYCl1BePgBbMSzXnIOMLvyoVF9AckYemLXuck=; b=cLjmwitnqXsaSJJ8oyqzM1NAGL
        /xumc0ZRp62Neq84Jsez9/gQuANk7HEztu6sW3AtbJqmjOOQtJNO5edKI0GkbDg6KRn5gEZEpssbs
        SQj+/w7lA9oUOVZ5mN6hneXAJ7a37yaMKbE9IidKIEb6gCi7BSHkKgoh30jJcn0V5dpgo6NXlWa40
        KLduGjjcMWhSmcQjPJx6xiBEI+6JxzbVFGyEIVpOoYwPbf2hT2z58f/M2KQ036u02DtXd8UULtCHt
        j+ooijziQCGWLnQ4reQy5d2LmEEPqYcO3e2826wh4WMd7YBLouTmqoOgyUBeuOXj8T3QXVm9n1uuX
        gyUiKq9Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l1Xw8-00D7WS-Tx; Mon, 18 Jan 2021 17:03:30 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 23/27] mm: Convert lock_page_or_retry to lock_folio_or_retry
Date:   Mon, 18 Jan 2021 17:01:44 +0000
Message-Id: <20210118170148.3126186-24-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210118170148.3126186-1-willy@infradead.org>
References: <20210118170148.3126186-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There's already a hidden compound_head() call in trylock_page(), so
just make it explicit in the caller, which may later have a folio
for its own reasons.  This saves a call to compound_head() inside
__lock_page_or_retry().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h | 10 +++++-----
 mm/filemap.c            | 16 +++++++---------
 mm/memory.c             | 10 +++++-----
 3 files changed, 17 insertions(+), 19 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index d28b53f91275..d287e1a680e8 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -621,7 +621,7 @@ static inline bool wake_page_match(struct wait_page_queue *wait_page,
 void __lock_folio(struct folio *folio);
 int __lock_folio_killable(struct folio *folio);
 int __lock_folio_async(struct folio *folio, struct wait_page_queue *wait);
-extern int __lock_page_or_retry(struct page *page, struct mm_struct *mm,
+int __lock_folio_or_retry(struct folio *folio, struct mm_struct *mm,
 				unsigned int flags);
 void unlock_folio(struct folio *folio);
 
@@ -702,17 +702,17 @@ static inline int lock_folio_async(struct folio *folio,
 }
 
 /*
- * lock_page_or_retry - Lock the page, unless this would block and the
+ * lock_folio_or_retry - Lock the folio, unless this would block and the
  * caller indicated that it can handle a retry.
  *
  * Return value and mmap_lock implications depend on flags; see
- * __lock_page_or_retry().
+ * __lock_folio_or_retry().
  */
-static inline int lock_page_or_retry(struct page *page, struct mm_struct *mm,
+static inline int lock_folio_or_retry(struct folio *folio, struct mm_struct *mm,
 				     unsigned int flags)
 {
 	might_sleep();
-	return trylock_page(page) || __lock_page_or_retry(page, mm, flags);
+	return trylock_folio(folio) || __lock_folio_or_retry(folio, mm, flags);
 }
 
 /*
diff --git a/mm/filemap.c b/mm/filemap.c
index 7670e0c7dd97..4ece44f694f6 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1538,20 +1538,18 @@ int __lock_folio_async(struct folio *folio, struct wait_page_queue *wait)
 
 /*
  * Return values:
- * 1 - page is locked; mmap_lock is still held.
- * 0 - page is not locked.
+ * 1 - folio is locked; mmap_lock is still held.
+ * 0 - folio is not locked.
  *     mmap_lock has been released (mmap_read_unlock(), unless flags had both
  *     FAULT_FLAG_ALLOW_RETRY and FAULT_FLAG_RETRY_NOWAIT set, in
  *     which case mmap_lock is still held.
  *
  * If neither ALLOW_RETRY nor KILLABLE are set, will always return 1
- * with the page locked and the mmap_lock unperturbed.
+ * with the folio locked and the mmap_lock unperturbed.
  */
-int __lock_page_or_retry(struct page *page, struct mm_struct *mm,
+int __lock_folio_or_retry(struct folio *folio, struct mm_struct *mm,
 			 unsigned int flags)
 {
-	struct folio *folio = page_folio(page);
-
 	if (fault_flag_allow_retry_first(flags)) {
 		/*
 		 * CAUTION! In this case, mmap_lock is not released
@@ -1562,9 +1560,9 @@ int __lock_page_or_retry(struct page *page, struct mm_struct *mm,
 
 		mmap_read_unlock(mm);
 		if (flags & FAULT_FLAG_KILLABLE)
-			wait_on_page_locked_killable(page);
+			wait_on_folio_locked_killable(folio);
 		else
-			wait_on_page_locked(page);
+			wait_on_folio_locked(folio);
 		return 0;
 	}
 	if (flags & FAULT_FLAG_KILLABLE) {
@@ -2749,7 +2747,7 @@ loff_t mapping_seek_hole_data(struct address_space *mapping, loff_t start,
  * @page - the page to lock.
  * @fpin - the pointer to the file we may pin (or is already pinned).
  *
- * This works similar to lock_page_or_retry in that it can drop the mmap_lock.
+ * This works similar to lock_folio_or_retry in that it can drop the mmap_lock.
  * It differs in that it actually returns the page locked if it returns 1 and 0
  * if it couldn't lock the page.  If we did have to drop the mmap_lock then fpin
  * will point to the pinned file and needs to be fput()'ed at a later point.
diff --git a/mm/memory.c b/mm/memory.c
index 8079c181efff..f5490cafe531 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3352,7 +3352,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		goto out_release;
 	}
 
-	locked = lock_page_or_retry(page, vma->vm_mm, vmf->flags);
+	locked = lock_folio_or_retry(page_folio(page), vma->vm_mm, vmf->flags);
 
 	delayacct_clear_flag(DELAYACCT_PF_SWAPIN);
 	if (!locked) {
@@ -4104,7 +4104,7 @@ static vm_fault_t do_shared_fault(struct vm_fault *vmf)
  * We enter with non-exclusive mmap_lock (to exclude vma changes,
  * but allow concurrent faults).
  * The mmap_lock may have been released depending on flags and our
- * return value.  See filemap_fault() and __lock_page_or_retry().
+ * return value.  See filemap_fault() and __lock_folio_or_retry().
  * If mmap_lock is released, vma may become invalid (for example
  * by other thread calling munmap()).
  */
@@ -4338,7 +4338,7 @@ static vm_fault_t wp_huge_pud(struct vm_fault *vmf, pud_t orig_pud)
  * concurrent faults).
  *
  * The mmap_lock may have been released depending on flags and our return value.
- * See filemap_fault() and __lock_page_or_retry().
+ * See filemap_fault() and __lock_folio_or_retry().
  */
 static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
 {
@@ -4431,7 +4431,7 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
  * By the time we get here, we already hold the mm semaphore
  *
  * The mmap_lock may have been released depending on flags and our
- * return value.  See filemap_fault() and __lock_page_or_retry().
+ * return value.  See filemap_fault() and __lock_folio_or_retry().
  */
 static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
 		unsigned long address, unsigned int flags)
@@ -4587,7 +4587,7 @@ static inline void mm_account_fault(struct pt_regs *regs,
  * By the time we get here, we already hold the mm semaphore
  *
  * The mmap_lock may have been released depending on flags and our
- * return value.  See filemap_fault() and __lock_page_or_retry().
+ * return value.  See filemap_fault() and __lock_folio_or_retry().
  */
 vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
 			   unsigned int flags, struct pt_regs *regs)
-- 
2.29.2

