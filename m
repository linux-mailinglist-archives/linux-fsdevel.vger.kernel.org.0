Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6BB232E0B0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Mar 2021 05:24:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbhCEEYj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Mar 2021 23:24:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbhCEEYi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Mar 2021 23:24:38 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53F51C061574;
        Thu,  4 Mar 2021 20:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=9d+mCHMlGcGG93YO8zcxGxoaCO1Ob3kebJ3Y/BX0vCc=; b=IIGNZaLDlocbNOcWiZR2oI2902
        +OZ55+HOrai+yAVmwk2XoY0yL7yta2iyZ+Ght67SpbXgE0OOlM3MG4a8hKR44x7Aj97+TbU6WHlmv
        /RS66N1HAb7AeRvuNdDeE51EoM5X5wT9+FVl5dR503b5bZGc+r4a/qFKy9zranoD/wQckeVdiy72x
        aE4+2X/hyFqfyLcraQVDNYhP0Y/3btPMiP95E5/GDNnmWMjAvkCfrIT1eEXIPdk4LM9cReJ2PYedB
        Fh7ramj855Ib1FaLyAuLzqXJpvsBRoFHwXVfS7bVKMgNNk267WoOqfs311kLb+Q5o0hq5FCvNXFh0
        CktHqZ/g==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lI204-00A3oB-Sv; Fri, 05 Mar 2021 04:23:45 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 15/25] mm/filemap: Convert lock_page_async to lock_folio_async
Date:   Fri,  5 Mar 2021 04:18:51 +0000
Message-Id: <20210305041901.2396498-16-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210305041901.2396498-1-willy@infradead.org>
References: <20210305041901.2396498-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There aren't any actual callers of lock_page_async(), but convert
filemap_update_page() to call __lock_folio_async().

__lock_folio_async() is 21 bytes smaller than __lock_page_async(),
but the real savings come from using a folio in filemap_update_page(),
shrinking it from 514 bytes to 403 bytes, saving 111 bytes.  The text
shrinks by 132 bytes in total.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/io_uring.c           |  2 +-
 include/linux/pagemap.h | 14 +++++++-------
 mm/filemap.c            | 31 ++++++++++++++++---------------
 3 files changed, 24 insertions(+), 23 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 4a088581b0f2..55687707b5fb 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -3155,7 +3155,7 @@ static int io_read_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 }
 
 /*
- * This is our waitqueue callback handler, registered through lock_page_async()
+ * This is our waitqueue callback handler, registered through lock_folio_async()
  * when we initially tried to do the IO with the iocb armed our waitqueue.
  * This gets called when the page is unlocked, and we generally expect that to
  * happen when the page IO is completed and the page is now uptodate. This will
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 0fa1a0338e54..9dbd9cf7d541 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -637,7 +637,7 @@ static inline bool wake_page_match(struct wait_page_queue *wait_page,
 
 void __lock_folio(struct folio *folio);
 int __lock_folio_killable(struct folio *folio);
-extern int __lock_page_async(struct page *page, struct wait_page_queue *wait);
+int __lock_folio_async(struct folio *folio, struct wait_page_queue *wait);
 extern int __lock_page_or_retry(struct page *page, struct mm_struct *mm,
 				unsigned int flags);
 void unlock_page(struct page *page);
@@ -695,18 +695,18 @@ static inline int lock_page_killable(struct page *page)
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
index 5acadffed25d..b99b068bc058 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1507,18 +1507,18 @@ int __lock_folio_killable(struct folio *folio)
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
@@ -2265,41 +2265,42 @@ static int filemap_update_page(struct kiocb *iocb,
 		struct address_space *mapping, struct iov_iter *iter,
 		struct page *page)
 {
+	struct folio *folio = page_folio(page);
 	int error;
 
-	if (!trylock_page(page)) {
+	if (!trylock_folio(folio)) {
 		if (iocb->ki_flags & (IOCB_NOWAIT | IOCB_NOIO))
 			return -EAGAIN;
 		if (!(iocb->ki_flags & IOCB_WAITQ)) {
-			put_and_wait_on_page_locked(page, TASK_KILLABLE);
+			put_and_wait_on_page_locked(&folio->page, TASK_KILLABLE);
 			return AOP_TRUNCATED_PAGE;
 		}
-		error = __lock_page_async(page, iocb->ki_waitq);
+		error = __lock_folio_async(folio, iocb->ki_waitq);
 		if (error)
 			return error;
 	}
 
-	if (!page->mapping)
+	if (!folio->page.mapping)
 		goto truncated;
 
 	error = 0;
-	if (filemap_range_uptodate(mapping, iocb->ki_pos, iter, page))
+	if (filemap_range_uptodate(mapping, iocb->ki_pos, iter, &folio->page))
 		goto unlock;
 
 	error = -EAGAIN;
 	if (iocb->ki_flags & (IOCB_NOIO | IOCB_NOWAIT | IOCB_WAITQ))
 		goto unlock;
 
-	error = filemap_read_page(iocb->ki_filp, mapping, page);
+	error = filemap_read_page(iocb->ki_filp, mapping, &folio->page);
 	if (error == AOP_TRUNCATED_PAGE)
-		put_page(page);
+		put_folio(folio);
 	return error;
 truncated:
-	unlock_page(page);
-	put_page(page);
+	unlock_folio(folio);
+	put_folio(folio);
 	return AOP_TRUNCATED_PAGE;
 unlock:
-	unlock_page(page);
+	unlock_folio(folio);
 	return error;
 }
 
-- 
2.30.0

