Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9BA1306E1F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 08:10:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231542AbhA1HGq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 02:06:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbhA1HGH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 02:06:07 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5044C0617AB;
        Wed, 27 Jan 2021 23:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=tMlKhew7ndgk0qOg+5AjyGBRQQoI8Dkzst9tOl3B0xU=; b=biyDQe2hpC/qqRkm9fBwEVMKeO
        TlQRAhC4jsYYXb9Kf/drzLfnJNrCSDHGXltdimzRUBnps6Oo1gc3uzWdgOtq88H5aPYm+phRz/o4+
        XDxj9ijsXcl9NQDnhfMJkdaUr5jPe7aUA6HKV93+Mth8XLZ33T6H/NrhCwOBaDH6AkHLTt8xp8PiH
        civOxNppepZAZUqAOsKLjngY2dDfsVvTwLn/62Kw5jp4bPNfz+DOO5GWyvfPtIcslBjKqeTCIUZWT
        PhCXoCGFdCOR3+Vn9vI603NY4BOMt2XZQ8G77jRBZ2nfp8+ZZmQe++K1Rv2vVo8L9LKKwpP4LCU0r
        t8dEqt7w==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l51M6-008487-UA; Thu, 28 Jan 2021 07:04:39 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 15/25] mm: Add lock_folio_killable
Date:   Thu, 28 Jan 2021 07:03:54 +0000
Message-Id: <20210128070404.1922318-16-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210128070404.1922318-1-willy@infradead.org>
References: <20210128070404.1922318-1-willy@infradead.org>
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
index 0e9ad46e8d55..93a4ab9feaa8 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -619,7 +619,7 @@ static inline bool wake_page_match(struct wait_page_queue *wait_page,
 }
 
 void __lock_folio(struct folio *folio);
-extern int __lock_page_killable(struct page *page);
+int __lock_folio_killable(struct folio *folio);
 extern int __lock_page_async(struct page *page, struct wait_page_queue *wait);
 extern int __lock_page_or_retry(struct page *page, struct mm_struct *mm,
 				unsigned int flags);
@@ -668,6 +668,14 @@ static inline void lock_page(struct page *page)
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
@@ -675,10 +683,7 @@ static inline void lock_page(struct page *page)
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
index f95967ef16da..c378b28c2bdc 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1516,14 +1516,13 @@ void __lock_folio(struct folio *folio)
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
@@ -1565,6 +1564,8 @@ int __lock_page_async(struct page *page, struct wait_page_queue *wait)
 int __lock_page_or_retry(struct page *page, struct mm_struct *mm,
 			 unsigned int flags)
 {
+	struct folio *folio = page_folio(page);
+
 	if (fault_flag_allow_retry_first(flags)) {
 		/*
 		 * CAUTION! In this case, mmap_lock is not released
@@ -1583,13 +1584,13 @@ int __lock_page_or_retry(struct page *page, struct mm_struct *mm,
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
@@ -2752,7 +2753,7 @@ static int lock_page_maybe_drop_mmap(struct vm_fault *vmf, struct page *page,
 
 	*fpin = maybe_unlock_mmap_for_io(vmf, *fpin);
 	if (vmf->flags & FAULT_FLAG_KILLABLE) {
-		if (__lock_page_killable(&folio->page)) {
+		if (__lock_folio_killable(folio)) {
 			/*
 			 * We didn't have the right flags to drop the mmap_lock,
 			 * but all fault_handlers only check for fatal signals
-- 
2.29.2

