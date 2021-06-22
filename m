Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42FD33B038B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jun 2021 14:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbhFVMEj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Jun 2021 08:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbhFVMEi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Jun 2021 08:04:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9250DC061574;
        Tue, 22 Jun 2021 05:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=nXbipUs68dyXXwV81c9RJkwor3GYl4DERwTXzNra0ZA=; b=mAXUibapHnaJj75UqyKx69wMfb
        mYh2hITVil/OIuiXjJdlslDtO1Tq1zyV19yNO80gbyz+joupAAVWMk0x7LOKC80GAykj245jVVULL
        5MNbWolkTChlrs79wu+dAFkkciCVHiuDnPybzyyNh5ara+jwqkIL6GCYxZW02/oY8K9raw8rDp/ze
        gv/i3m9vpqLzQjB2NiHB0cxNClzgdsFa/RR3z4Cdsnsqbs7dDwb7Gfa7wCevnPNLeEcz/t3IuPHZq
        KwpKqQx6ztrDThqYKvs/wWL4WvtHdCoE0yRXMgjYq51zgme+72uq+jI/nahEdg3P27z67peeIhRWv
        Bq2j0Obw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvf5G-00EEvO-EV; Tue, 22 Jun 2021 12:01:07 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     akpm@linux-foundation.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        William Kucharski <william.kucharski@oracle.com>
Subject: [PATCH v12 23/33] mm/filemap: Add __folio_lock_or_retry()
Date:   Tue, 22 Jun 2021 12:41:08 +0100
Message-Id: <20210622114118.3388190-24-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210622114118.3388190-1-willy@infradead.org>
References: <20210622114118.3388190-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert __lock_page_or_retry() to __folio_lock_or_retry().  This actually
saves 4 bytes in the only caller of lock_page_or_retry() (due to better
register allocation) and saves the 14 byte cost of calling page_folio()
in __folio_lock_or_retry() for a total saving of 18 bytes.  Also use
a bool for the return type.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Acked-by: Jeff Layton <jlayton@kernel.org>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
---
 include/linux/pagemap.h | 11 +++++++----
 mm/filemap.c            | 20 +++++++++-----------
 mm/memory.c             |  8 ++++----
 3 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 6f28eb6fb681..0b70b1fe53cb 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -654,7 +654,7 @@ static inline bool wake_page_match(struct wait_page_queue *wait_page,
 
 void __folio_lock(struct folio *folio);
 int __folio_lock_killable(struct folio *folio);
-extern int __lock_page_or_retry(struct page *page, struct mm_struct *mm,
+bool __folio_lock_or_retry(struct folio *folio, struct mm_struct *mm,
 				unsigned int flags);
 void unlock_page(struct page *page);
 void folio_unlock(struct folio *folio);
@@ -715,13 +715,16 @@ static inline int lock_page_killable(struct page *page)
  * caller indicated that it can handle a retry.
  *
  * Return value and mmap_lock implications depend on flags; see
- * __lock_page_or_retry().
+ * __folio_lock_or_retry().
  */
-static inline int lock_page_or_retry(struct page *page, struct mm_struct *mm,
+static inline bool lock_page_or_retry(struct page *page, struct mm_struct *mm,
 				     unsigned int flags)
 {
+	struct folio *folio;
 	might_sleep();
-	return trylock_page(page) || __lock_page_or_retry(page, mm, flags);
+
+	folio = page_folio(page);
+	return folio_trylock(folio) || __folio_lock_or_retry(folio, mm, flags);
 }
 
 /*
diff --git a/mm/filemap.c b/mm/filemap.c
index 1b76230d4345..37f9c72adc87 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1625,48 +1625,46 @@ static int __folio_lock_async(struct folio *folio, struct wait_page_queue *wait)
 
 /*
  * Return values:
- * 1 - page is locked; mmap_lock is still held.
- * 0 - page is not locked.
+ * true - folio is locked; mmap_lock is still held.
+ * false - folio is not locked.
  *     mmap_lock has been released (mmap_read_unlock(), unless flags had both
  *     FAULT_FLAG_ALLOW_RETRY and FAULT_FLAG_RETRY_NOWAIT set, in
  *     which case mmap_lock is still held.
  *
  * If neither ALLOW_RETRY nor KILLABLE are set, will always return 1
- * with the page locked and the mmap_lock unperturbed.
+ * with the folio locked and the mmap_lock unperturbed.
  */
-int __lock_page_or_retry(struct page *page, struct mm_struct *mm,
+bool __folio_lock_or_retry(struct folio *folio, struct mm_struct *mm,
 			 unsigned int flags)
 {
-	struct folio *folio = page_folio(page);
-
 	if (fault_flag_allow_retry_first(flags)) {
 		/*
 		 * CAUTION! In this case, mmap_lock is not released
 		 * even though return 0.
 		 */
 		if (flags & FAULT_FLAG_RETRY_NOWAIT)
-			return 0;
+			return false;
 
 		mmap_read_unlock(mm);
 		if (flags & FAULT_FLAG_KILLABLE)
 			folio_wait_locked_killable(folio);
 		else
 			folio_wait_locked(folio);
-		return 0;
+		return false;
 	}
 	if (flags & FAULT_FLAG_KILLABLE) {
-		int ret;
+		bool ret;
 
 		ret = __folio_lock_killable(folio);
 		if (ret) {
 			mmap_read_unlock(mm);
-			return 0;
+			return false;
 		}
 	} else {
 		__folio_lock(folio);
 	}
 
-	return 1;
+	return true;
 }
 
 /**
diff --git a/mm/memory.c b/mm/memory.c
index 730daa00952b..a8f0ddd9e84a 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4065,7 +4065,7 @@ static vm_fault_t do_shared_fault(struct vm_fault *vmf)
  * We enter with non-exclusive mmap_lock (to exclude vma changes,
  * but allow concurrent faults).
  * The mmap_lock may have been released depending on flags and our
- * return value.  See filemap_fault() and __lock_page_or_retry().
+ * return value.  See filemap_fault() and __folio_lock_or_retry().
  * If mmap_lock is released, vma may become invalid (for example
  * by other thread calling munmap()).
  */
@@ -4307,7 +4307,7 @@ static vm_fault_t wp_huge_pud(struct vm_fault *vmf, pud_t orig_pud)
  * concurrent faults).
  *
  * The mmap_lock may have been released depending on flags and our return value.
- * See filemap_fault() and __lock_page_or_retry().
+ * See filemap_fault() and __folio_lock_or_retry().
  */
 static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
 {
@@ -4411,7 +4411,7 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
  * By the time we get here, we already hold the mm semaphore
  *
  * The mmap_lock may have been released depending on flags and our
- * return value.  See filemap_fault() and __lock_page_or_retry().
+ * return value.  See filemap_fault() and __folio_lock_or_retry().
  */
 static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
 		unsigned long address, unsigned int flags)
@@ -4567,7 +4567,7 @@ static inline void mm_account_fault(struct pt_regs *regs,
  * By the time we get here, we already hold the mm semaphore
  *
  * The mmap_lock may have been released depending on flags and our
- * return value.  See filemap_fault() and __lock_page_or_retry().
+ * return value.  See filemap_fault() and __folio_lock_or_retry().
  */
 vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
 			   unsigned int flags, struct pt_regs *regs)
-- 
2.30.2

