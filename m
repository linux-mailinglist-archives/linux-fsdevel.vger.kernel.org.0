Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81736350701
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Mar 2021 20:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235991AbhCaSyM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Mar 2021 14:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234289AbhCaSx4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Mar 2021 14:53:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70789C061574;
        Wed, 31 Mar 2021 11:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=U5NCt1hhi6ejl0rYgO7/d81/HJ9ufI3Q3zidzFkj0w4=; b=LKvxtSNbpRL4cXIDuWR8BynI1/
        RryHtIrhiybGcLkFTaMDJb5ap48zizaVesJ2wHEgIMguPdkTVsVXpRujJ3rna6YG+5VfTymMdA3BM
        SKzCzDDj+RCZZlBAj1sChR8OGF5rsnvPEGhHYPnwSlpNUCPU07eRxIu6GJDoCcArRqraEwlzh+LAC
        HCMqwLITWEXwVeDEA1e44sqlhUYp8ToslaWSdxhkekBDzIZ+15helT9P+kT6GzJnek1bxXWAZ2/GH
        9wD8SfY3wgVpEY1qcaXN/OP4LR+NOCP5USNhyAeVvh7xWR+S3laIKC7b6BDnNgkI7KzGupLeL5xyE
        OW0JDAwg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lRfyJ-004zhW-NO; Wed, 31 Mar 2021 18:53:44 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org
Subject: [PATCH v6 19/27] mm/filemap: Add __lock_folio_async
Date:   Wed, 31 Mar 2021 19:47:20 +0100
Message-Id: <20210331184728.1188084-20-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210331184728.1188084-1-willy@infradead.org>
References: <20210331184728.1188084-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There aren't any actual callers of lock_page_async(), so remove it.
Convert filemap_update_page() to call __lock_folio_async().

__lock_folio_async() is 21 bytes smaller than __lock_page_async(),
but the real savings come from using a folio in filemap_update_page(),
shrinking it from 514 bytes to 403 bytes, saving 111 bytes.  The text
shrinks by 132 bytes in total.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/io_uring.c           |  2 +-
 include/linux/pagemap.h | 17 -----------------
 mm/filemap.c            | 31 ++++++++++++++++---------------
 3 files changed, 17 insertions(+), 33 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 962c121fa107..64a22b2ea6c5 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -3156,7 +3156,7 @@ static int io_read_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 }
 
 /*
- * This is our waitqueue callback handler, registered through lock_page_async()
+ * This is our waitqueue callback handler, registered through lock_folio_async()
  * when we initially tried to do the IO with the iocb armed our waitqueue.
  * This gets called when the page is unlocked, and we generally expect that to
  * happen when the page IO is completed and the page is now uptodate. This will
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 75060da77be5..054e9dd7628e 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -716,7 +716,6 @@ static inline bool wake_page_match(struct wait_page_queue *wait_page,
 
 void __lock_folio(struct folio *folio);
 int __lock_folio_killable(struct folio *folio);
-extern int __lock_page_async(struct page *page, struct wait_page_queue *wait);
 extern int __lock_page_or_retry(struct page *page, struct mm_struct *mm,
 				unsigned int flags);
 void unlock_page(struct page *page);
@@ -774,22 +773,6 @@ static inline int lock_page_killable(struct page *page)
 	return lock_folio_killable(page_folio(page));
 }
 
-/*
- * lock_page_async - Lock the page, unless this would block. If the page
- * is already locked, then queue a callback when the page becomes unlocked.
- * This callback can then retry the operation.
- *
- * Returns 0 if the page is locked successfully, or -EIOCBQUEUED if the page
- * was already locked and the callback defined in 'wait' was queued.
- */
-static inline int lock_page_async(struct page *page,
-				  struct wait_page_queue *wait)
-{
-	if (!trylock_page(page))
-		return __lock_page_async(page, wait);
-	return 0;
-}
-
 /*
  * lock_page_or_retry - Lock the page, unless this would block and the
  * caller indicated that it can handle a retry.
diff --git a/mm/filemap.c b/mm/filemap.c
index 5675237c985a..84642e41c6b5 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1554,18 +1554,18 @@ int __lock_folio_killable(struct folio *folio)
 }
 EXPORT_SYMBOL_GPL(__lock_folio_killable);
 
-int __lock_page_async(struct page *page, struct wait_page_queue *wait)
+static int __lock_folio_async(struct folio *folio, struct wait_page_queue *wait)
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
@@ -2312,41 +2312,42 @@ static int filemap_update_page(struct kiocb *iocb,
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
+	if (!folio->mapping)
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
2.30.2

