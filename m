Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C32C62D33A9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Dec 2020 21:28:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729138AbgLHUWt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Dec 2020 15:22:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729141AbgLHUWs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Dec 2020 15:22:48 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F8C1C0617A6;
        Tue,  8 Dec 2020 12:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=8VJ332uTBlKXmEE3FnlTYYTEEXOjnPvsTHCMA5xgkYk=; b=fW525uEy7EWOYwtBtvHWsaXDCd
        yBv8ZrLPsBupfeIx+NvHoxRXHr/FGyD0BwUExbh1sW7AJW9XFbriX3n+o5CXIF8tBurFNDePShzjw
        bSkDlpvJWbx5QoRXwtlP8VpPlg/VMbsDM3UL2w3PJUaKo46XCyy3FcbYHI7fuN29x/+ATgGRlf+yp
        TATTmQHfiWY5ObTvs0Vf0GcvD4xuBvZFWTCRhOFYzOGl2sNoZ7WN6tTP4zTGKwUVcj5/ANjBYL584
        tvglFaXrLnXAlO7iQ+J6Y/ODiBFJEJCwYgv/rUuPtiRiG9nHzpBByIBUvMRgX6I8AIfo2IBH58j32
        dCI3ZHLA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kmiwt-00050k-0i; Tue, 08 Dec 2020 19:46:59 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 06/11] mm: Add lock_folio
Date:   Tue,  8 Dec 2020 19:46:48 +0000
Message-Id: <20201208194653.19180-7-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201208194653.19180-1-willy@infradead.org>
References: <20201208194653.19180-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is like lock_page() but for use by callers who know they have a folio.
Convert __lock_page() to be __lock_folio().  This saves one call to
compound_head() per contended call to lock_page().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h | 21 +++++++++++++++------
 mm/filemap.c            | 29 +++++++++++++++--------------
 2 files changed, 30 insertions(+), 20 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 64ae1bb62765..1d4a1828a434 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -583,7 +583,7 @@ static inline bool wake_page_match(struct wait_page_queue *wait_page,
 	return true;
 }
 
-extern void __lock_page(struct page *page);
+extern void __lock_folio(struct folio *folio);
 extern int __lock_page_killable(struct page *page);
 extern int __lock_page_async(struct page *page, struct wait_page_queue *wait);
 extern int __lock_page_or_retry(struct page *page, struct mm_struct *mm,
@@ -604,13 +604,24 @@ static inline void unlock_page(struct page *page)
 	return unlock_folio(page_folio(page));
 }
 
+static inline bool trylock_folio(struct folio *folio)
+{
+	return likely(!test_and_set_bit_lock(PG_locked, folio_flags(folio)));
+}
+
 /*
  * Return true if the page was successfully locked
  */
 static inline int trylock_page(struct page *page)
 {
-	page = compound_head(page);
-	return (likely(!test_and_set_bit_lock(PG_locked, &page->flags)));
+	return trylock_folio(page_folio(page));
+}
+
+static inline void lock_folio(struct folio *folio)
+{
+	might_sleep();
+	if (!trylock_folio(folio))
+		__lock_folio(folio);
 }
 
 /*
@@ -618,9 +629,7 @@ static inline int trylock_page(struct page *page)
  */
 static inline void lock_page(struct page *page)
 {
-	might_sleep();
-	if (!trylock_page(page))
-		__lock_page(page);
+	lock_folio(page_folio(page));
 }
 
 /*
diff --git a/mm/filemap.c b/mm/filemap.c
index de8372307b33..8e87906f5dd6 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1160,7 +1160,7 @@ static void wake_up_page(struct page *page, int bit)
  */
 enum behavior {
 	EXCLUSIVE,	/* Hold ref to page and take the bit when woken, like
-			 * __lock_page() waiting on then setting PG_locked.
+			 * __lock_folio() waiting on then setting PG_locked.
 			 */
 	SHARED,		/* Hold ref to page and check the bit when woken, like
 			 * wait_on_page_writeback() waiting on PG_writeback.
@@ -1523,17 +1523,16 @@ void page_endio(struct page *page, bool is_write, int err)
 EXPORT_SYMBOL_GPL(page_endio);
 
 /**
- * __lock_page - get a lock on the page, assuming we need to sleep to get it
- * @__page: the page to lock
+ * __lock_folio - Get a lock on the folio, assuming we need to sleep to get it.
+ * @folio: The folio to lock
  */
-void __lock_page(struct page *__page)
+void __lock_folio(struct folio *folio)
 {
-	struct page *page = compound_head(__page);
-	wait_queue_head_t *q = page_waitqueue(page);
-	wait_on_page_bit_common(q, page, PG_locked, TASK_UNINTERRUPTIBLE,
+	wait_queue_head_t *q = page_waitqueue(&folio->page);
+	wait_on_page_bit_common(q, &folio->page, PG_locked, TASK_UNINTERRUPTIBLE,
 				EXCLUSIVE);
 }
-EXPORT_SYMBOL(__lock_page);
+EXPORT_SYMBOL(__lock_folio);
 
 int __lock_page_killable(struct page *__page)
 {
@@ -1587,10 +1586,10 @@ int __lock_page_or_retry(struct page *page, struct mm_struct *mm,
 			return 0;
 		}
 	} else {
-		__lock_page(page);
+		__lock_folio(page_folio(page));
 	}
-	return 1;
 
+	return 1;
 }
 
 /**
@@ -2764,7 +2763,9 @@ loff_t mapping_seek_hole_data(struct address_space *mapping, loff_t start,
 static int lock_page_maybe_drop_mmap(struct vm_fault *vmf, struct page *page,
 				     struct file **fpin)
 {
-	if (trylock_page(page))
+	struct folio *folio = page_folio(page);
+
+	if (trylock_folio(folio))
 		return 1;
 
 	/*
@@ -2777,7 +2778,7 @@ static int lock_page_maybe_drop_mmap(struct vm_fault *vmf, struct page *page,
 
 	*fpin = maybe_unlock_mmap_for_io(vmf, *fpin);
 	if (vmf->flags & FAULT_FLAG_KILLABLE) {
-		if (__lock_page_killable(page)) {
+		if (__lock_page_killable(&folio->page)) {
 			/*
 			 * We didn't have the right flags to drop the mmap_lock,
 			 * but all fault_handlers only check for fatal signals
@@ -2789,11 +2790,11 @@ static int lock_page_maybe_drop_mmap(struct vm_fault *vmf, struct page *page,
 			return 0;
 		}
 	} else
-		__lock_page(page);
+		__lock_folio(folio);
+
 	return 1;
 }
 
-
 /*
  * Synchronous readahead happens when we don't even find a page in the page
  * cache at all.  We don't want to perform IO under the mmap sem, so if we have
-- 
2.29.2

