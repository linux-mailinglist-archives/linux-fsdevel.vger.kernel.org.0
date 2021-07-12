Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4248C3C6366
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 21:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236207AbhGLTQg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jul 2021 15:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233758AbhGLTQf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jul 2021 15:16:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 177F8C0613DD;
        Mon, 12 Jul 2021 12:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=TKpv8jv52+/tyYttM/Fpota/kApUiJsztQgoXoI1kJI=; b=LNsdl1xUo5qnry6y2pNKOI4XHL
        4i3UfLjkL1nUX2LBasDcfGnH+FDVS3/0KSKYETIHjTjG6oXQOhqX+IxE1qobc++9BQBiMDKVvTrK2
        IaiFbBxdkQ0okSFAlWqwMEl+Ptqevj3gpZgNSmyK4YFLxQV/jC0cgDkRk93OsNrzyPuvHCZw8GeGL
        MsltyQ9A60XihfC5xCfRux9NkXzPMLXQ23Jtb/ylkOFL5A6Y/q6XYS35RtatVrCwIkvjS0fZnpmgQ
        /zHm/NnjV9OFriR9COiCLLC4UBgw/+KqGS0oW349KLvifxML3detOUGC3csDgt9F3fQeYi1FhFmhS
        EaNeI7hw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m31M3-000Lzt-Qu; Mon, 12 Jul 2021 19:12:40 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     akpm@linux-foundation.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>
Subject: [PATCH v13 19/32] mm/filemap: Add folio_lock_killable()
Date:   Mon, 12 Jul 2021 20:01:51 +0100
Message-Id: <20210712190204.80979-20-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210712190204.80979-1-willy@infradead.org>
References: <20210712190204.80979-1-willy@infradead.org>
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
index 5c82933af2fe..3d78d96c163d 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -654,7 +654,7 @@ static inline bool wake_page_match(struct wait_page_queue *wait_page,
 }
 
 void __folio_lock(struct folio *folio);
-extern int __lock_page_killable(struct page *page);
+int __folio_lock_killable(struct folio *folio);
 extern int __lock_page_async(struct page *page, struct wait_page_queue *wait);
 extern int __lock_page_or_retry(struct page *page, struct mm_struct *mm,
 				unsigned int flags);
@@ -694,6 +694,14 @@ static inline void lock_page(struct page *page)
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
@@ -701,10 +709,7 @@ static inline void lock_page(struct page *page)
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
index cc2682b72584..108cc825638f 100644
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

