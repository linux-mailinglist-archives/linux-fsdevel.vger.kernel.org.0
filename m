Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E75737006E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Apr 2021 20:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbhD3S0X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Apr 2021 14:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbhD3S0W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Apr 2021 14:26:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1505EC06174A
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Apr 2021 11:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Mzg+H5+VuspZynYjmUeh5SwlcPqKX5asQ7MN0LcsEmc=; b=SlUVrzVFe1QZsjSvGzyjuptwuK
        8WoMCYyffSGUkGQeDQ7bOGDFeqKczmfBxCFkNc1flyEm3mvTyfhBkOKWjlDRL2t1nJQR6jEdoxyJm
        O8FuQYHVkqhGfR3/EyUkP/zav9ZWFbsU5IKM0QtEKejMnK74vVm56FbZf3lPKwZfk1rCL29Kh2jk2
        Kyfkakp8aNxlJCamHnyFRRvcKFrK5OlIQaNwSEEi8NlzJs9qPwmxm3QG/EXwhggxZ40GW2l4wQMFn
        2l4CF8Fgw6bwjRiRe1e/A7Gozx+lLTBlxgdcNwkEKOsSGNnrAISsHw2tVscOIb7IcsgbmUbRnKKnf
        3mXHiHMQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lcXnl-00BNM0-D0; Fri, 30 Apr 2021 18:24:10 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        akpm@linux-foundation.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v8 18/31] mm/filemap: Add folio_lock
Date:   Fri, 30 Apr 2021 19:07:27 +0100
Message-Id: <20210430180740.2707166-19-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210430180740.2707166-1-willy@infradead.org>
References: <20210430180740.2707166-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is like lock_page() but for use by callers who know they have a folio.
Convert __lock_page() to be __folio_lock().  This saves one call to
compound_head() per contended call to lock_page().

Saves 362 bytes of text; mostly from improved register allocation and
inlining decisions.  __folio_lock is 59 bytes while __lock_page was 79.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Acked-by: Jeff Layton <jlayton@kernel.org>
---
 include/linux/pagemap.h | 24 +++++++++++++++++++-----
 mm/filemap.c            | 29 +++++++++++++++--------------
 2 files changed, 34 insertions(+), 19 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 9126c0db3a60..ff81be103539 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -714,7 +714,7 @@ static inline bool wake_page_match(struct wait_page_queue *wait_page,
 	return true;
 }
 
-extern void __lock_page(struct page *page);
+void __folio_lock(struct folio *folio);
 extern int __lock_page_killable(struct page *page);
 extern int __lock_page_async(struct page *page, struct wait_page_queue *wait);
 extern int __lock_page_or_retry(struct page *page, struct mm_struct *mm,
@@ -722,13 +722,24 @@ extern int __lock_page_or_retry(struct page *page, struct mm_struct *mm,
 void unlock_page(struct page *page);
 void folio_unlock(struct folio *folio);
 
+static inline bool folio_trylock(struct folio *folio)
+{
+	return likely(!test_and_set_bit_lock(PG_locked, folio_flags(folio, 0)));
+}
+
 /*
  * Return true if the page was successfully locked
  */
 static inline int trylock_page(struct page *page)
 {
-	page = compound_head(page);
-	return (likely(!test_and_set_bit_lock(PG_locked, &page->flags)));
+	return folio_trylock(page_folio(page));
+}
+
+static inline void folio_lock(struct folio *folio)
+{
+	might_sleep();
+	if (!folio_trylock(folio))
+		__folio_lock(folio);
 }
 
 /*
@@ -736,9 +747,12 @@ static inline int trylock_page(struct page *page)
  */
 static inline void lock_page(struct page *page)
 {
+	struct folio *folio;
 	might_sleep();
-	if (!trylock_page(page))
-		__lock_page(page);
+
+	folio = page_folio(page);
+	if (!folio_trylock(folio))
+		__folio_lock(folio);
 }
 
 /*
diff --git a/mm/filemap.c b/mm/filemap.c
index 090b303bcd45..6935b068856f 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1187,7 +1187,7 @@ static void wake_up_page(struct page *page, int bit)
  */
 enum behavior {
 	EXCLUSIVE,	/* Hold ref to page and take the bit when woken, like
-			 * __lock_page() waiting on then setting PG_locked.
+			 * __folio_lock() waiting on then setting PG_locked.
 			 */
 	SHARED,		/* Hold ref to page and check the bit when woken, like
 			 * wait_on_page_writeback() waiting on PG_writeback.
@@ -1576,17 +1576,16 @@ void page_endio(struct page *page, bool is_write, int err)
 EXPORT_SYMBOL_GPL(page_endio);
 
 /**
- * __lock_page - get a lock on the page, assuming we need to sleep to get it
- * @__page: the page to lock
+ * __folio_lock - Get a lock on the folio, assuming we need to sleep to get it.
+ * @folio: The folio to lock
  */
-void __lock_page(struct page *__page)
+void __folio_lock(struct folio *folio)
 {
-	struct page *page = compound_head(__page);
-	wait_queue_head_t *q = page_waitqueue(page);
-	wait_on_page_bit_common(q, page, PG_locked, TASK_UNINTERRUPTIBLE,
+	wait_queue_head_t *q = page_waitqueue(&folio->page);
+	wait_on_page_bit_common(q, &folio->page, PG_locked, TASK_UNINTERRUPTIBLE,
 				EXCLUSIVE);
 }
-EXPORT_SYMBOL(__lock_page);
+EXPORT_SYMBOL(__folio_lock);
 
 int __lock_page_killable(struct page *__page)
 {
@@ -1661,10 +1660,10 @@ int __lock_page_or_retry(struct page *page, struct mm_struct *mm,
 			return 0;
 		}
 	} else {
-		__lock_page(page);
+		__folio_lock(page_folio(page));
 	}
-	return 1;
 
+	return 1;
 }
 
 /**
@@ -2815,7 +2814,9 @@ loff_t mapping_seek_hole_data(struct address_space *mapping, loff_t start,
 static int lock_page_maybe_drop_mmap(struct vm_fault *vmf, struct page *page,
 				     struct file **fpin)
 {
-	if (trylock_page(page))
+	struct folio *folio = page_folio(page);
+
+	if (folio_trylock(folio))
 		return 1;
 
 	/*
@@ -2828,7 +2829,7 @@ static int lock_page_maybe_drop_mmap(struct vm_fault *vmf, struct page *page,
 
 	*fpin = maybe_unlock_mmap_for_io(vmf, *fpin);
 	if (vmf->flags & FAULT_FLAG_KILLABLE) {
-		if (__lock_page_killable(page)) {
+		if (__lock_page_killable(&folio->page)) {
 			/*
 			 * We didn't have the right flags to drop the mmap_lock,
 			 * but all fault_handlers only check for fatal signals
@@ -2840,11 +2841,11 @@ static int lock_page_maybe_drop_mmap(struct vm_fault *vmf, struct page *page,
 			return 0;
 		}
 	} else
-		__lock_page(page);
+		__folio_lock(folio);
+
 	return 1;
 }
 
-
 /*
  * Synchronous readahead happens when we don't even find a page in the page
  * cache at all.  We don't want to perform IO under the mmap sem, so if we have
-- 
2.30.2

