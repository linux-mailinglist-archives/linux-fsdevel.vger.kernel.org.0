Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4F43C4196
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 05:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232730AbhGLDWO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Jul 2021 23:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbhGLDWN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Jul 2021 23:22:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F7BC0613DD;
        Sun, 11 Jul 2021 20:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=bnxZuPXXkg/pf8fuypLYZLSgrM6CCG/4M1QIHHvv0uc=; b=bg8TeQGyJHxPo6FQizZZI1m395
        bftjm7r/BbZInqh1cXbDqCM1b+15p7gFVQcWagQCC2K/1v9HFGwsru70IbTmqROlr0JLjrHDgI8cr
        OsnxRzaj9e6DkEFU7ifITodatJAtFz0qNjmObxs5OzFiE8QKG87MSqxsALKCLQYG1ihKcyYJD3TXO
        D0gySJ0tN1YrOCTeqVMTeXRbPVaWyN+LtGSA3KvL+ag7ch9okqX8CKxnPoGVtJjt+BT4u/1kQgddg
        ZfCnJwFgXhhxY0qKmTWWtLtVsTIEu8YQ1ty6K2z0S5DfFG9muo8alYaIQ2TFclhR0SfAK+9N4Mtr9
        s8IcLVSw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m2mSh-00GnVU-13; Mon, 12 Jul 2021 03:18:32 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        David Howells <dhowells@redhat.com>
Subject: [PATCH v13 020/137] mm/filemap: Add __folio_lock_async()
Date:   Mon, 12 Jul 2021 04:05:04 +0100
Message-Id: <20210712030701.4000097-21-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210712030701.4000097-1-willy@infradead.org>
References: <20210712030701.4000097-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There aren't any actual callers of lock_page_async(), so remove it.
Convert filemap_update_page() to call __folio_lock_async().

__folio_lock_async() is 21 bytes smaller than __lock_page_async(),
but the real savings come from using a folio in filemap_update_page(),
shrinking it from 515 bytes to 404 bytes, saving 110 bytes.  The text
shrinks by 132 bytes in total.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Acked-by: Jeff Layton <jlayton@kernel.org>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
Reviewed-by: David Howells <dhowells@redhat.com>
---
 fs/io_uring.c           |  2 +-
 include/linux/pagemap.h | 17 -----------------
 mm/filemap.c            | 31 ++++++++++++++++---------------
 3 files changed, 17 insertions(+), 33 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index d94fb5835a20..7e30c7c361e6 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -3149,7 +3149,7 @@ static int io_read_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 }
 
 /*
- * This is our waitqueue callback handler, registered through lock_page_async()
+ * This is our waitqueue callback handler, registered through __folio_lock_async()
  * when we initially tried to do the IO with the iocb armed our waitqueue.
  * This gets called when the page is unlocked, and we generally expect that to
  * happen when the page IO is completed and the page is now uptodate. This will
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 3d78d96c163d..79ff079346aa 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -655,7 +655,6 @@ static inline bool wake_page_match(struct wait_page_queue *wait_page,
 
 void __folio_lock(struct folio *folio);
 int __folio_lock_killable(struct folio *folio);
-extern int __lock_page_async(struct page *page, struct wait_page_queue *wait);
 extern int __lock_page_or_retry(struct page *page, struct mm_struct *mm,
 				unsigned int flags);
 void unlock_page(struct page *page);
@@ -712,22 +711,6 @@ static inline int lock_page_killable(struct page *page)
 	return folio_lock_killable(page_folio(page));
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
index 108cc825638f..19c1486d85d2 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1597,18 +1597,18 @@ int __folio_lock_killable(struct folio *folio)
 }
 EXPORT_SYMBOL_GPL(__folio_lock_killable);
 
-int __lock_page_async(struct page *page, struct wait_page_queue *wait)
+static int __folio_lock_async(struct folio *folio, struct wait_page_queue *wait)
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
+	folio_set_waiters_flag(folio);
+	ret = !folio_trylock(folio);
 	/*
 	 * If we were successful now, we know we're still on the
 	 * waitqueue as we're still under the lock. This means it's
@@ -2381,41 +2381,42 @@ static int filemap_update_page(struct kiocb *iocb,
 		struct address_space *mapping, struct iov_iter *iter,
 		struct page *page)
 {
+	struct folio *folio = page_folio(page);
 	int error;
 
-	if (!trylock_page(page)) {
+	if (!folio_trylock(folio)) {
 		if (iocb->ki_flags & (IOCB_NOWAIT | IOCB_NOIO))
 			return -EAGAIN;
 		if (!(iocb->ki_flags & IOCB_WAITQ)) {
-			put_and_wait_on_page_locked(page, TASK_KILLABLE);
+			put_and_wait_on_page_locked(&folio->page, TASK_KILLABLE);
 			return AOP_TRUNCATED_PAGE;
 		}
-		error = __lock_page_async(page, iocb->ki_waitq);
+		error = __folio_lock_async(folio, iocb->ki_waitq);
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
+		folio_put(folio);
 	return error;
 truncated:
-	unlock_page(page);
-	put_page(page);
+	folio_unlock(folio);
+	folio_put(folio);
 	return AOP_TRUNCATED_PAGE;
 unlock:
-	unlock_page(page);
+	folio_unlock(folio);
 	return error;
 }
 
-- 
2.30.2

