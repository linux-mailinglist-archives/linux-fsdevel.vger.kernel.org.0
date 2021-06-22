Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3059B3B037F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jun 2021 14:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbhFVMCR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Jun 2021 08:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbhFVMCQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Jun 2021 08:02:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E852FC061574;
        Tue, 22 Jun 2021 05:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=5mFaMWjpVsNOYJd2gnj43T4C33wcFXhT1wRP93Y/9us=; b=OT/pFNPkMKfH1Y1iKW/x8lg2CX
        xPzR2RNRvgnXOGCn85TlhFIJpEcT3EKunwEkJrRjaNElaShNWlwI7tDqq0HLOn+slmHWD1dBi6b2g
        FDHWdaH8Qj4YZD1zkS0LTkppRvLVXomhuY3El0ZZN4aZiOk+MGz8gPqbPyrTd8dEqIrqyW59N63H2
        OSqUZ9aqPzn/lOB1Ta9Qz3kMLFvDVvC3pHBVxa17cSJHPR13py9smyPiBC2vdw8D8AJrI3xqknusu
        yvPeIoT0F3ExEQ+LIwvGUr8JQ3tcujBQan2oqLf/g4/OXqKPeHntWmumGPN/W6q9T1hww/yiqMVLN
        i6ql9Ymw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvf2s-00EEhz-02; Tue, 22 Jun 2021 11:58:27 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     akpm@linux-foundation.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>
Subject: [PATCH v12 20/33] mm/filemap: Add folio_lock_killable()
Date:   Tue, 22 Jun 2021 12:41:05 +0100
Message-Id: <20210622114118.3388190-21-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210622114118.3388190-1-willy@infradead.org>
References: <20210622114118.3388190-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is like lock_page_killable() but for use by callers who
know they have a folio.  Convert __lock_page_killable() to be
__folio_lock_killable().  This saves one call to compound_head() per
contended call to lock_page_killable().

__folio_lock_killable() is 19 bytes smaller than __lock_page_killable()
was.  filemap_fault() shrinks by 74 bytes and __lock_page_or_retry()
shrinks by 71 bytes.  That's a total of 164 bytes of text saved.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Acked-by: Jeff Layton <jlayton@kernel.org>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
---
 include/linux/pagemap.h | 15 ++++++++++-----
 mm/filemap.c            | 17 +++++++++--------
 2 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index f30b666a177e..bba73c10c9fe 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -653,7 +653,7 @@ static inline bool wake_page_match(struct wait_page_queue *wait_page,
 }
 
 void __folio_lock(struct folio *folio);
-extern int __lock_page_killable(struct page *page);
+int __folio_lock_killable(struct folio *folio);
 extern int __lock_page_async(struct page *page, struct wait_page_queue *wait);
 extern int __lock_page_or_retry(struct page *page, struct mm_struct *mm,
 				unsigned int flags);
@@ -693,6 +693,14 @@ static inline void lock_page(struct page *page)
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
@@ -700,10 +708,7 @@ static inline void lock_page(struct page *page)
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
index a89227132141..70dc1798f6d6 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1589,14 +1589,13 @@ void __folio_lock(struct folio *folio)
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
@@ -1638,6 +1637,8 @@ int __lock_page_async(struct page *page, struct wait_page_queue *wait)
 int __lock_page_or_retry(struct page *page, struct mm_struct *mm,
 			 unsigned int flags)
 {
+	struct folio *folio = page_folio(page);
+
 	if (fault_flag_allow_retry_first(flags)) {
 		/*
 		 * CAUTION! In this case, mmap_lock is not released
@@ -1656,13 +1657,13 @@ int __lock_page_or_retry(struct page *page, struct mm_struct *mm,
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
@@ -2851,7 +2852,7 @@ static int lock_page_maybe_drop_mmap(struct vm_fault *vmf, struct page *page,
 
 	*fpin = maybe_unlock_mmap_for_io(vmf, *fpin);
 	if (vmf->flags & FAULT_FLAG_KILLABLE) {
-		if (__lock_page_killable(&folio->page)) {
+		if (__folio_lock_killable(folio)) {
 			/*
 			 * We didn't have the right flags to drop the mmap_lock,
 			 * but all fault_handlers only check for fatal signals
-- 
2.30.2

