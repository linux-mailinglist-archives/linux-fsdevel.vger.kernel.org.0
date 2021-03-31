Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 960D23506ED
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Mar 2021 20:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235938AbhCaSyF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Mar 2021 14:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235615AbhCaSxp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Mar 2021 14:53:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1187CC061574;
        Wed, 31 Mar 2021 11:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=22dOaDPiu0/1Ekt8r9SHPbn92F8+e+bKZneHj/hcHKY=; b=Ha/cnx309NaLd0g/9QI0z4XgAs
        4Uu+xTlBmbxY3+MbjOAKh7wfUXqu45s36TF6r8mbsktfJl/wxOSYJBAAzZFRvoVpGagneN5Wi0UI1
        4k2KU8CN++T2rTW83feTTopgcRbhK9oVJo1L+ugYlIl6AsLJQqn72xyt8u3Y8yuNiMZQQk3QA8FIl
        fghP4f3URQOTwBu38BTa3rQmxGAibkpo1bITzzjuRLX64Sv5640raO8659TnO+Xf34/WuES8uDtXx
        AXweK65MwN5dpQP/qEqo72eglcQZq0yl5k2/1yqyKNMKn5RJshSGZxaRcwCYTdv42Bd4AE3icq7qi
        DPQF27Mg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lRfy4-004zey-SN; Wed, 31 Mar 2021 18:53:29 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org
Subject: [PATCH v6 17/27] mm/filemap: Add lock_folio
Date:   Wed, 31 Mar 2021 19:47:18 +0100
Message-Id: <20210331184728.1188084-18-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210331184728.1188084-1-willy@infradead.org>
References: <20210331184728.1188084-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is like lock_page() but for use by callers who know they have a folio.
Convert __lock_page() to be __lock_folio().  This saves one call to
compound_head() per contended call to lock_page().

Saves 362 bytes of text; mostly from improved register allocation and
inlining decisions.  __lock_folio is 59 bytes while __lock_page was 79.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h | 24 +++++++++++++++++++-----
 mm/filemap.c            | 29 +++++++++++++++--------------
 2 files changed, 34 insertions(+), 19 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index ee83ada556e0..1e0705c74539 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -714,7 +714,7 @@ static inline bool wake_page_match(struct wait_page_queue *wait_page,
 	return true;
 }
 
-extern void __lock_page(struct page *page);
+void __lock_folio(struct folio *folio);
 extern int __lock_page_killable(struct page *page);
 extern int __lock_page_async(struct page *page, struct wait_page_queue *wait);
 extern int __lock_page_or_retry(struct page *page, struct mm_struct *mm,
@@ -723,13 +723,24 @@ void unlock_page(struct page *page);
 void unlock_folio(struct folio *folio);
 void unlock_page_private_2(struct page *page);
 
+static inline bool trylock_folio(struct folio *folio)
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
@@ -737,9 +748,12 @@ static inline int trylock_page(struct page *page)
  */
 static inline void lock_page(struct page *page)
 {
+	struct folio *folio;
 	might_sleep();
-	if (!trylock_page(page))
-		__lock_page(page);
+
+	folio = page_folio(page);
+	if (!trylock_folio(folio))
+		__lock_folio(folio);
 }
 
 /*
diff --git a/mm/filemap.c b/mm/filemap.c
index 6d320264e5e0..daf66d00e57a 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1187,7 +1187,7 @@ static void wake_up_page(struct page *page, int bit)
  */
 enum behavior {
 	EXCLUSIVE,	/* Hold ref to page and take the bit when woken, like
-			 * __lock_page() waiting on then setting PG_locked.
+			 * __lock_folio() waiting on then setting PG_locked.
 			 */
 	SHARED,		/* Hold ref to page and check the bit when woken, like
 			 * wait_on_page_writeback() waiting on PG_writeback.
@@ -1535,17 +1535,16 @@ void page_endio(struct page *page, bool is_write, int err)
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
@@ -1620,10 +1619,10 @@ int __lock_page_or_retry(struct page *page, struct mm_struct *mm,
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
@@ -2767,7 +2766,9 @@ loff_t mapping_seek_hole_data(struct address_space *mapping, loff_t start,
 static int lock_page_maybe_drop_mmap(struct vm_fault *vmf, struct page *page,
 				     struct file **fpin)
 {
-	if (trylock_page(page))
+	struct folio *folio = page_folio(page);
+
+	if (trylock_folio(folio))
 		return 1;
 
 	/*
@@ -2780,7 +2781,7 @@ static int lock_page_maybe_drop_mmap(struct vm_fault *vmf, struct page *page,
 
 	*fpin = maybe_unlock_mmap_for_io(vmf, *fpin);
 	if (vmf->flags & FAULT_FLAG_KILLABLE) {
-		if (__lock_page_killable(page)) {
+		if (__lock_page_killable(&folio->page)) {
 			/*
 			 * We didn't have the right flags to drop the mmap_lock,
 			 * but all fault_handlers only check for fatal signals
@@ -2792,11 +2793,11 @@ static int lock_page_maybe_drop_mmap(struct vm_fault *vmf, struct page *page,
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
2.30.2

