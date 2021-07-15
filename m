Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EEC23C96BF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 05:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233541AbhGOD7u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jul 2021 23:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbhGOD7u (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jul 2021 23:59:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4127C06175F;
        Wed, 14 Jul 2021 20:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=VFl3zrR+bFgfKhJ6ajFoVdpV67mhNLeF8WnzvdQ2QpU=; b=BkZUJad2D6CLWbPugbVe9ZDjCu
        En99eHdadccQdbtGUzClnrSXaZcsVkp5Bl9710HYI261Jh9cN2QCWbbqSH7nPmt2U+jZHPXx+qwst
        Ji7JI3IJjNKwQIG0ZBxW0f3dFF6Z21H/uSDLT6goPydbMoMJbbk6O2Z7zslAAAmxH4GRGi33CqCKP
        3zUlqOtgNlYDJR1nDSOzZeWD/XstF8kJS60ZD85QHCHgDZ/dSDUNsIF+gNzt3D8AQ5yymZPyUz+G2
        mfzfcvZ2kJes3Rk9cSb1mbaU/zeEbG+yEFumDOv3deGZ/IxmKVJqJcblC9sq3FT+PJFqkChoZJUgW
        5CFsIVJQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3sSz-002vKP-43; Thu, 15 Jul 2021 03:55:43 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        William Kucharski <william.kucharski@oracle.com>
Subject: [PATCH v14 022/138] mm/filemap: Add __folio_lock_or_retry()
Date:   Thu, 15 Jul 2021 04:35:08 +0100
Message-Id: <20210715033704.692967-23-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210715033704.692967-1-willy@infradead.org>
References: <20210715033704.692967-1-willy@infradead.org>
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
index 03fea8bbfd8e..626dbccbfb90 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -655,7 +655,7 @@ static inline bool wake_page_match(struct wait_page_queue *wait_page,
 
 void __folio_lock(struct folio *folio);
 int __folio_lock_killable(struct folio *folio);
-extern int __lock_page_or_retry(struct page *page, struct mm_struct *mm,
+bool __folio_lock_or_retry(struct folio *folio, struct mm_struct *mm,
 				unsigned int flags);
 void unlock_page(struct page *page);
 void folio_unlock(struct folio *folio);
@@ -716,13 +716,16 @@ static inline int lock_page_killable(struct page *page)
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
index 04fb4a84cf0d..fb6398a532e5 100644
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
index 747a01d495f2..2f111f9b3dbc 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4248,7 +4248,7 @@ static vm_fault_t do_shared_fault(struct vm_fault *vmf)
  * We enter with non-exclusive mmap_lock (to exclude vma changes,
  * but allow concurrent faults).
  * The mmap_lock may have been released depending on flags and our
- * return value.  See filemap_fault() and __lock_page_or_retry().
+ * return value.  See filemap_fault() and __folio_lock_or_retry().
  * If mmap_lock is released, vma may become invalid (for example
  * by other thread calling munmap()).
  */
@@ -4489,7 +4489,7 @@ static vm_fault_t wp_huge_pud(struct vm_fault *vmf, pud_t orig_pud)
  * concurrent faults).
  *
  * The mmap_lock may have been released depending on flags and our return value.
- * See filemap_fault() and __lock_page_or_retry().
+ * See filemap_fault() and __folio_lock_or_retry().
  */
 static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
 {
@@ -4593,7 +4593,7 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
  * By the time we get here, we already hold the mm semaphore
  *
  * The mmap_lock may have been released depending on flags and our
- * return value.  See filemap_fault() and __lock_page_or_retry().
+ * return value.  See filemap_fault() and __folio_lock_or_retry().
  */
 static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
 		unsigned long address, unsigned int flags)
@@ -4749,7 +4749,7 @@ static inline void mm_account_fault(struct pt_regs *regs,
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

