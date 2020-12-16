Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5BE2DC63F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Dec 2020 19:26:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730455AbgLPSZI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Dec 2020 13:25:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730385AbgLPSYy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Dec 2020 13:24:54 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F17FC061282;
        Wed, 16 Dec 2020 10:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=JSvZZqi7MEK8ZAmIYAnJnUZ9ds1FU5ZiR4iDKCSaABw=; b=aM6EcGVyF+e1tVa6lE4eeskGRi
        ApOJiXaIwsBDxZsnqz3na2pQTL+SpK8jbeN+8QPZoH8A81Nyaozs+i9ESSPFUdMRgFvsfQ8Mmjsac
        ZKqQ+AVGi+XQMNmOztYc87qPodqc63PwVCUOYdi3lCfb9GHkFzkJMYil0BZmUIxYngQfOyNmTVC2p
        MxUEl9BBoEPtf4j1UC6kUCr/iBKaYmCsraQn/uOjGolpQiRqSbAuxdqqEUJuFOzYjadSixLlrKukH
        JHFxT8OCZCgkvlhKfuyJfDc1HKNZwaL9kQeq8zUFWBsIBslWUaclD6sLBLb+qf4M+YRs2Vba7CFE3
        LMispZ2g==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kpbSc-00076Z-Af; Wed, 16 Dec 2020 18:23:38 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 07/25] mm: Add lock_folio_killable
Date:   Wed, 16 Dec 2020 18:23:17 +0000
Message-Id: <20201216182335.27227-8-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201216182335.27227-1-willy@infradead.org>
References: <20201216182335.27227-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is like lock_page_killable() but for use by callers who
know they have a folio.  Convert __lock_page_killable() to be
__lock_folio_killable().  This saves one call to compound_head() per
contended call to lock_page_killable().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h | 15 ++++++++++-----
 mm/filemap.c            | 17 +++++++++--------
 2 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index c5fe759872b5..5acebbb75d41 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -600,7 +600,7 @@ static inline bool wake_page_match(struct wait_page_queue *wait_page,
 }
 
 extern void __lock_folio(struct folio *folio);
-extern int __lock_page_killable(struct page *page);
+extern int __lock_folio_killable(struct folio *folio);
 extern int __lock_page_async(struct page *page, struct wait_page_queue *wait);
 extern int __lock_page_or_retry(struct page *page, struct mm_struct *mm,
 				unsigned int flags);
@@ -648,6 +648,14 @@ static inline void lock_page(struct page *page)
 	lock_folio(page_folio(page));
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
@@ -655,10 +663,7 @@ static inline void lock_page(struct page *page)
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
index 50fdc03590b3..dd26b50e3676 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1534,14 +1534,13 @@ void __lock_folio(struct folio *folio)
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
@@ -1562,6 +1561,8 @@ int __lock_page_async(struct page *page, struct wait_page_queue *wait)
 int __lock_page_or_retry(struct page *page, struct mm_struct *mm,
 			 unsigned int flags)
 {
+	struct folio *folio = page_folio(page);
+
 	if (fault_flag_allow_retry_first(flags)) {
 		/*
 		 * CAUTION! In this case, mmap_lock is not released
@@ -1580,13 +1581,13 @@ int __lock_page_or_retry(struct page *page, struct mm_struct *mm,
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
@@ -2778,7 +2779,7 @@ static int lock_page_maybe_drop_mmap(struct vm_fault *vmf, struct page *page,
 
 	*fpin = maybe_unlock_mmap_for_io(vmf, *fpin);
 	if (vmf->flags & FAULT_FLAG_KILLABLE) {
-		if (__lock_page_killable(&folio->page)) {
+		if (__lock_folio_killable(folio)) {
 			/*
 			 * We didn't have the right flags to drop the mmap_lock,
 			 * but all fault_handlers only check for fatal signals
-- 
2.29.2

