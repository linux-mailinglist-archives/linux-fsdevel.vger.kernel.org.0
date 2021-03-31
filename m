Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD70D3506F0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Mar 2021 20:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235965AbhCaSyI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Mar 2021 14:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235907AbhCaSxw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Mar 2021 14:53:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C83E5C061574;
        Wed, 31 Mar 2021 11:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=EjkychSF9RPhmkVCTT5unmNfJORu5p7UXYOr5c99H5Y=; b=KAytf3UuHBKfFMM5PB7Q8QSVIu
        wg9ebIgYHQKuUybVdhbGPH3m+L4KxEcou5phxadUe5G1xd+w660MYW99NCUkTAi7sDm0rGtI6MSyI
        3SKETJRnkQb53OdbEvZC9tVpHU4qULn8fU4z6n6wg+C566ln3SL654WGULTU5J3SpLoaeBDLZQqqR
        pVC5pKrnSM+EKmNQqIV/DlqQ5eik1t62i1nkTNH4NvkmKSgyLDvr6gUlE7PJE53+5/Gc/CVMRdm6g
        l4i7oFUzz4SfiSZzDDcRBjMcFScc9OwJSrS+n6LqXCtWY8jru9hNBluZXJlYEr4njI47A2m+g+NN+
        4OyTucxg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lRfy7-004zfA-23; Wed, 31 Mar 2021 18:53:32 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org
Subject: [PATCH v6 18/27] mm/filemap: Add lock_folio_killable
Date:   Wed, 31 Mar 2021 19:47:19 +0100
Message-Id: <20210331184728.1188084-19-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210331184728.1188084-1-willy@infradead.org>
References: <20210331184728.1188084-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is like lock_page_killable() but for use by callers who
know they have a folio.  Convert __lock_page_killable() to be
__lock_folio_killable().  This saves one call to compound_head() per
contended call to lock_page_killable().

__lock_folio_killable() is 20 bytes smaller than __lock_page_killable()
was.  lock_page_maybe_drop_mmap() shrinks by 68 bytes and
__lock_page_or_retry() shrinks by 66 bytes.  That's a total of 154 bytes
of text saved.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h | 15 ++++++++++-----
 mm/filemap.c            | 17 +++++++++--------
 2 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 1e0705c74539..75060da77be5 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -715,7 +715,7 @@ static inline bool wake_page_match(struct wait_page_queue *wait_page,
 }
 
 void __lock_folio(struct folio *folio);
-extern int __lock_page_killable(struct page *page);
+int __lock_folio_killable(struct folio *folio);
 extern int __lock_page_async(struct page *page, struct wait_page_queue *wait);
 extern int __lock_page_or_retry(struct page *page, struct mm_struct *mm,
 				unsigned int flags);
@@ -756,6 +756,14 @@ static inline void lock_page(struct page *page)
 		__lock_folio(folio);
 }
 
+static inline int lock_folio_killable(struct folio *folio)
+{
+	might_sleep();
+	if (!trylock_folio(folio))
+		return __lock_folio_killable(folio);
+	return 0;
+}
+
 /*
  * lock_page_killable is like lock_page but can be interrupted by fatal
  * signals.  It returns 0 if it locked the page and -EINTR if it was
@@ -763,10 +771,7 @@ static inline void lock_page(struct page *page)
  */
 static inline int lock_page_killable(struct page *page)
 {
-	might_sleep();
-	if (!trylock_page(page))
-		return __lock_page_killable(page);
-	return 0;
+	return lock_folio_killable(page_folio(page));
 }
 
 /*
diff --git a/mm/filemap.c b/mm/filemap.c
index daf66d00e57a..5675237c985a 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1546,14 +1546,13 @@ void __lock_folio(struct folio *folio)
 }
 EXPORT_SYMBOL(__lock_folio);
 
-int __lock_page_killable(struct page *__page)
+int __lock_folio_killable(struct folio *folio)
 {
-	struct page *page = compound_head(__page);
-	wait_queue_head_t *q = page_waitqueue(page);
-	return wait_on_page_bit_common(q, page, PG_locked, TASK_KILLABLE,
+	wait_queue_head_t *q = page_waitqueue(&folio->page);
+	return wait_on_page_bit_common(q, &folio->page, PG_locked, TASK_KILLABLE,
 					EXCLUSIVE);
 }
-EXPORT_SYMBOL_GPL(__lock_page_killable);
+EXPORT_SYMBOL_GPL(__lock_folio_killable);
 
 int __lock_page_async(struct page *page, struct wait_page_queue *wait)
 {
@@ -1595,6 +1594,8 @@ int __lock_page_async(struct page *page, struct wait_page_queue *wait)
 int __lock_page_or_retry(struct page *page, struct mm_struct *mm,
 			 unsigned int flags)
 {
+	struct folio *folio = page_folio(page);
+
 	if (fault_flag_allow_retry_first(flags)) {
 		/*
 		 * CAUTION! In this case, mmap_lock is not released
@@ -1613,13 +1614,13 @@ int __lock_page_or_retry(struct page *page, struct mm_struct *mm,
 	if (flags & FAULT_FLAG_KILLABLE) {
 		int ret;
 
-		ret = __lock_page_killable(page);
+		ret = __lock_folio_killable(folio);
 		if (ret) {
 			mmap_read_unlock(mm);
 			return 0;
 		}
 	} else {
-		__lock_folio(page_folio(page));
+		__lock_folio(folio);
 	}
 
 	return 1;
@@ -2781,7 +2782,7 @@ static int lock_page_maybe_drop_mmap(struct vm_fault *vmf, struct page *page,
 
 	*fpin = maybe_unlock_mmap_for_io(vmf, *fpin);
 	if (vmf->flags & FAULT_FLAG_KILLABLE) {
-		if (__lock_page_killable(&folio->page)) {
+		if (__lock_folio_killable(folio)) {
 			/*
 			 * We didn't have the right flags to drop the mmap_lock,
 			 * but all fault_handlers only check for fatal signals
-- 
2.30.2

