Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14A5F306E32
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 08:12:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbhA1HKQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 02:10:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231528AbhA1HGc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 02:06:32 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0884C061351;
        Wed, 27 Jan 2021 23:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=oJK470q31PboFWBgTKWnce8VgiqHWIx7f5w+vailm0M=; b=O73MLdxTU1rbyUAViLl/rVGY/d
        wWX1I9J5qoQgcHr9zZ0ItNd/6tqre2gFc3mpoVquLPZ+ONqWCVxF4K72SzGZGo3hvuvqoltM8C/xj
        iZfNNTiYa6d77s4IdbTAFGvzXpBacpH2fbKbhLloEn7lBo9yTS6KPYD82QRrPfgBtbx0Uw/GdeK+4
        eHYEZwDFJGTBpAX9z1+AWfLpXQXyXa9KHsrYi5eF5/O4djjU0qGrkZYYkXLE2RzLbyOXsZ95QAWZp
        b5XVZeasnRGmI6jT3tmh5WZWQhmP6Jan6WSvaCCpAN6EfOI/LsC9IuDGPqhvCken67hRcM9lv4fSI
        AEAewdVg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l51M8-00848C-EN; Thu, 28 Jan 2021 07:04:41 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 16/25] mm: Convert lock_page_async to lock_folio_async
Date:   Thu, 28 Jan 2021 07:03:55 +0000
Message-Id: <20210128070404.1922318-17-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210128070404.1922318-1-willy@infradead.org>
References: <20210128070404.1922318-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When the caller already has a folio, this saves a call to compound_head().
If not, the call to compound_head() is merely moved.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/io_uring.c           |  2 +-
 include/linux/pagemap.h | 14 +++++++-------
 mm/filemap.c            | 12 ++++++------
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 03748faa5295..2627160ffd4c 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -3398,7 +3398,7 @@ static int io_read_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 }
 
 /*
- * This is our waitqueue callback handler, registered through lock_page_async()
+ * This is our waitqueue callback handler, registered through lock_folio_async()
  * when we initially tried to do the IO with the iocb armed our waitqueue.
  * This gets called when the page is unlocked, and we generally expect that to
  * happen when the page IO is completed and the page is now uptodate. This will
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 93a4ab9feaa8..131d1aa2af61 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -620,7 +620,7 @@ static inline bool wake_page_match(struct wait_page_queue *wait_page,
 
 void __lock_folio(struct folio *folio);
 int __lock_folio_killable(struct folio *folio);
-extern int __lock_page_async(struct page *page, struct wait_page_queue *wait);
+int __lock_folio_async(struct folio *folio, struct wait_page_queue *wait);
 extern int __lock_page_or_retry(struct page *page, struct mm_struct *mm,
 				unsigned int flags);
 void unlock_folio(struct folio *folio);
@@ -687,18 +687,18 @@ static inline int lock_page_killable(struct page *page)
 }
 
 /*
- * lock_page_async - Lock the page, unless this would block. If the page
- * is already locked, then queue a callback when the page becomes unlocked.
+ * lock_folio_async - Lock the folio, unless this would block. If the folio
+ * is already locked, then queue a callback when the folio becomes unlocked.
  * This callback can then retry the operation.
  *
- * Returns 0 if the page is locked successfully, or -EIOCBQUEUED if the page
+ * Returns 0 if the folio is locked successfully, or -EIOCBQUEUED if the folio
  * was already locked and the callback defined in 'wait' was queued.
  */
-static inline int lock_page_async(struct page *page,
+static inline int lock_folio_async(struct folio *folio,
 				  struct wait_page_queue *wait)
 {
-	if (!trylock_page(page))
-		return __lock_page_async(page, wait);
+	if (!trylock_folio(folio))
+		return __lock_folio_async(folio, wait);
 	return 0;
 }
 
diff --git a/mm/filemap.c b/mm/filemap.c
index c378b28c2bdc..a54eb4641385 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1524,18 +1524,18 @@ int __lock_folio_killable(struct folio *folio)
 }
 EXPORT_SYMBOL_GPL(__lock_folio_killable);
 
-int __lock_page_async(struct page *page, struct wait_page_queue *wait)
+int __lock_folio_async(struct folio *folio, struct wait_page_queue *wait)
 {
-	struct wait_queue_head *q = page_waitqueue(page);
+	struct wait_queue_head *q = page_waitqueue(&folio->page);
 	int ret = 0;
 
-	wait->page = page;
+	wait->page = &folio->page;
 	wait->bit_nr = PG_locked;
 
 	spin_lock_irq(&q->lock);
 	__add_wait_queue_entry_tail(q, &wait->wait);
-	SetPageWaiters(page);
-	ret = !trylock_page(page);
+	SetFolioWaiters(folio);
+	ret = !trylock_folio(folio);
 	/*
 	 * If we were successful now, we know we're still on the
 	 * waitqueue as we're still under the lock. This means it's
@@ -2293,7 +2293,7 @@ static int filemap_update_page(struct kiocb *iocb,
 			put_and_wait_on_page_locked(page, TASK_KILLABLE);
 			return AOP_TRUNCATED_PAGE;
 		}
-		error = __lock_page_async(page, iocb->ki_waitq);
+		error = __lock_folio_async(page_folio(page), iocb->ki_waitq);
 		if (error)
 			return error;
 	}
-- 
2.29.2

