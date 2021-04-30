Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4BA4370070
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Apr 2021 20:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbhD3S1N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Apr 2021 14:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbhD3S1N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Apr 2021 14:27:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E58D4C06174A
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Apr 2021 11:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=U7qW5qvNaD+0f5JkRmi3lkD2zY05XTYiYtYU1+fotcM=; b=bYgBcvzc3hu2/9nc6zZEkZywjD
        DLmI9pAmewFLynkSIygXhthEQNFZtJlXBe89cKVOH0dr+tpmagvbyYflX7XAVlUYnRvxyquXzgi3S
        pjll4L34LcUL/nbbXLQvAnamqNCMT1l4BIKiSp5aLpThwdMGoLE/wH5/BzrfAZBTDbdZxMUYeNF0H
        Ovw1vX7t0pL7+cOSr8OUl5vQR430wtFLPW9++IOb7cGBW1V4fWOxfkMNcBDsmhYoxszy6P7GLDhhs
        GKELrmu2o9titI/qLgqSSqfNd2xmxDvTZYWt6OXPFd4a/MBQk4MfoLT6ax5oMbYsToktfOUuKutmR
        QZLI1e4g==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lcXoi-00BNOa-3e; Fri, 30 Apr 2021 18:25:04 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        akpm@linux-foundation.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v8 19/31] mm/filemap: Add folio_lock_killable
Date:   Fri, 30 Apr 2021 19:07:28 +0100
Message-Id: <20210430180740.2707166-20-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210430180740.2707166-1-willy@infradead.org>
References: <20210430180740.2707166-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is like lock_page_killable() but for use by callers who
know they have a folio.  Convert __lock_page_killable() to be
__folio_lock_killable().  This saves one call to compound_head() per
contended call to lock_page_killable().

__folio_lock_killable() is 20 bytes smaller than __lock_page_killable()
was.  lock_page_maybe_drop_mmap() shrinks by 68 bytes and
__lock_page_or_retry() shrinks by 66 bytes.  That's a total of 154 bytes
of text saved.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Acked-by: Jeff Layton <jlayton@kernel.org>
---
 include/linux/pagemap.h | 15 ++++++++++-----
 mm/filemap.c            | 17 +++++++++--------
 2 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index ff81be103539..332731ee541a 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -715,7 +715,7 @@ static inline bool wake_page_match(struct wait_page_queue *wait_page,
 }
 
 void __folio_lock(struct folio *folio);
-extern int __lock_page_killable(struct page *page);
+int __folio_lock_killable(struct folio *folio);
 extern int __lock_page_async(struct page *page, struct wait_page_queue *wait);
 extern int __lock_page_or_retry(struct page *page, struct mm_struct *mm,
 				unsigned int flags);
@@ -755,6 +755,14 @@ static inline void lock_page(struct page *page)
 		__folio_lock(folio);
 }
 
+static inline int folio_lock_killable(struct folio *folio)
+{
+	might_sleep();
+	if (!folio_trylock(folio))
+		return __folio_lock_killable(folio);
+	return 0;
+}
+
 /*
  * lock_page_killable is like lock_page but can be interrupted by fatal
  * signals.  It returns 0 if it locked the page and -EINTR if it was
@@ -762,10 +770,7 @@ static inline void lock_page(struct page *page)
  */
 static inline int lock_page_killable(struct page *page)
 {
-	might_sleep();
-	if (!trylock_page(page))
-		return __lock_page_killable(page);
-	return 0;
+	return folio_lock_killable(page_folio(page));
 }
 
 /*
diff --git a/mm/filemap.c b/mm/filemap.c
index 6935b068856f..27a86d53dd89 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1587,14 +1587,13 @@ void __folio_lock(struct folio *folio)
 }
 EXPORT_SYMBOL(__folio_lock);
 
-int __lock_page_killable(struct page *__page)
+int __folio_lock_killable(struct folio *folio)
 {
-	struct page *page = compound_head(__page);
-	wait_queue_head_t *q = page_waitqueue(page);
-	return wait_on_page_bit_common(q, page, PG_locked, TASK_KILLABLE,
+	wait_queue_head_t *q = page_waitqueue(&folio->page);
+	return wait_on_page_bit_common(q, &folio->page, PG_locked, TASK_KILLABLE,
 					EXCLUSIVE);
 }
-EXPORT_SYMBOL_GPL(__lock_page_killable);
+EXPORT_SYMBOL_GPL(__folio_lock_killable);
 
 int __lock_page_async(struct page *page, struct wait_page_queue *wait)
 {
@@ -1636,6 +1635,8 @@ int __lock_page_async(struct page *page, struct wait_page_queue *wait)
 int __lock_page_or_retry(struct page *page, struct mm_struct *mm,
 			 unsigned int flags)
 {
+	struct folio *folio = page_folio(page);
+
 	if (fault_flag_allow_retry_first(flags)) {
 		/*
 		 * CAUTION! In this case, mmap_lock is not released
@@ -1654,13 +1655,13 @@ int __lock_page_or_retry(struct page *page, struct mm_struct *mm,
 	if (flags & FAULT_FLAG_KILLABLE) {
 		int ret;
 
-		ret = __lock_page_killable(page);
+		ret = __folio_lock_killable(folio);
 		if (ret) {
 			mmap_read_unlock(mm);
 			return 0;
 		}
 	} else {
-		__folio_lock(page_folio(page));
+		__folio_lock(folio);
 	}
 
 	return 1;
@@ -2829,7 +2830,7 @@ static int lock_page_maybe_drop_mmap(struct vm_fault *vmf, struct page *page,
 
 	*fpin = maybe_unlock_mmap_for_io(vmf, *fpin);
 	if (vmf->flags & FAULT_FLAG_KILLABLE) {
-		if (__lock_page_killable(&folio->page)) {
+		if (__folio_lock_killable(folio)) {
 			/*
 			 * We didn't have the right flags to drop the mmap_lock,
 			 * but all fault_handlers only check for fatal signals
-- 
2.30.2

