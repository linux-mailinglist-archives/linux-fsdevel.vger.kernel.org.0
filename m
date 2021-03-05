Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 348C132E0BD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Mar 2021 05:26:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbhCEE0w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Mar 2021 23:26:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbhCEE0v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Mar 2021 23:26:51 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8023BC061574;
        Thu,  4 Mar 2021 20:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=CMOjg81XZerkssgDq+SP0LVRKbTXWxJnSrFjpOwOOZM=; b=Icu7EZK28GOfZsNWl87jyTE4j2
        J5iOAHkQ/FjMiCLzY6C5/7U3MiqgcHYyd16QCFxZXbBYvtZVRRmA9jcpRHBaosC+Zfyf1ESpr0Ffo
        P1R8kdCK9kTyFWQ6cCpppT0VGzM8ArSEqqvp4EUdMJhvA5OvsHSfjjy4DFklHvro34FLEhWSiFL77
        YR6aDunljvzbiwdVHPa+DqX9ZHx4jUmyCzE69NGQngs62HnOW1hZ0AjrFRgmhdCO6MomeK8+nPUsV
        cfuqOoxdW/Wdfx0bP4+x8S51TG0CL9HFiNcivAatJnRVs/UixlX9x7MzjLhcsl9dXQ1qpE/okl0ZK
        KJHU+qFA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lI22B-00A4hV-C6; Fri, 05 Mar 2021 04:26:04 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 21/25] mm/filemap: Add __lock_folio_or_retry
Date:   Fri,  5 Mar 2021 04:18:57 +0000
Message-Id: <20210305041901.2396498-22-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210305041901.2396498-1-willy@infradead.org>
References: <20210305041901.2396498-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert __lock_page_or_retry() to __lock_folio_or_retry().  This actually
saves 4 bytes in the only caller of lock_page_or_retry() (due to better
register allocation) and saves the 20 byte cost of calling page_folio()
in __lock_folio_or_retry() for a total saving of 24 bytes.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h |  9 ++++++---
 mm/filemap.c            | 10 ++++------
 mm/memory.c             |  8 ++++----
 3 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 8737eb86602e..6ee4bc843f98 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -638,7 +638,7 @@ static inline bool wake_page_match(struct wait_page_queue *wait_page,
 void __lock_folio(struct folio *folio);
 int __lock_folio_killable(struct folio *folio);
 int __lock_folio_async(struct folio *folio, struct wait_page_queue *wait);
-extern int __lock_page_or_retry(struct page *page, struct mm_struct *mm,
+int __lock_folio_or_retry(struct folio *folio, struct mm_struct *mm,
 				unsigned int flags);
 void unlock_page(struct page *page);
 void unlock_folio(struct folio *folio);
@@ -715,13 +715,16 @@ static inline int lock_folio_async(struct folio *folio,
  * caller indicated that it can handle a retry.
  *
  * Return value and mmap_lock implications depend on flags; see
- * __lock_page_or_retry().
+ * __lock_folio_or_retry().
  */
 static inline int lock_page_or_retry(struct page *page, struct mm_struct *mm,
 				     unsigned int flags)
 {
+	struct folio *folio;
 	might_sleep();
-	return trylock_page(page) || __lock_page_or_retry(page, mm, flags);
+
+	folio = page_folio(page);
+	return trylock_folio(folio) || __lock_folio_or_retry(folio, mm, flags);
 }
 
 /*
diff --git a/mm/filemap.c b/mm/filemap.c
index ec5a743b4e0f..76c97cb9cbbe 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1529,20 +1529,18 @@ int __lock_folio_async(struct folio *folio, struct wait_page_queue *wait)
 
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
diff --git a/mm/memory.c b/mm/memory.c
index c8e357627318..51a3590418f0 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4022,7 +4022,7 @@ static vm_fault_t do_shared_fault(struct vm_fault *vmf)
  * We enter with non-exclusive mmap_lock (to exclude vma changes,
  * but allow concurrent faults).
  * The mmap_lock may have been released depending on flags and our
- * return value.  See filemap_fault() and __lock_page_or_retry().
+ * return value.  See filemap_fault() and __lock_folio_or_retry().
  * If mmap_lock is released, vma may become invalid (for example
  * by other thread calling munmap()).
  */
@@ -4256,7 +4256,7 @@ static vm_fault_t wp_huge_pud(struct vm_fault *vmf, pud_t orig_pud)
  * concurrent faults).
  *
  * The mmap_lock may have been released depending on flags and our return value.
- * See filemap_fault() and __lock_page_or_retry().
+ * See filemap_fault() and __lock_folio_or_retry().
  */
 static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
 {
@@ -4360,7 +4360,7 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
  * By the time we get here, we already hold the mm semaphore
  *
  * The mmap_lock may have been released depending on flags and our
- * return value.  See filemap_fault() and __lock_page_or_retry().
+ * return value.  See filemap_fault() and __lock_folio_or_retry().
  */
 static vm_fault_t __handle_mm_fault(struct vm_area_struct *vma,
 		unsigned long address, unsigned int flags)
@@ -4516,7 +4516,7 @@ static inline void mm_account_fault(struct pt_regs *regs,
  * By the time we get here, we already hold the mm semaphore
  *
  * The mmap_lock may have been released depending on flags and our
- * return value.  See filemap_fault() and __lock_page_or_retry().
+ * return value.  See filemap_fault() and __lock_folio_or_retry().
  */
 vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
 			   unsigned int flags, struct pt_regs *regs)
-- 
2.30.0

