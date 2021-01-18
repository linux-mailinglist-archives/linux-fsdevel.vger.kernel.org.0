Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE3592FA72A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Jan 2021 18:13:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406924AbhARRMs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Jan 2021 12:12:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393014AbhARRDz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Jan 2021 12:03:55 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B249C06179C;
        Mon, 18 Jan 2021 09:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Rst7vvQbDk2J8HAFzqRmEilF+OmTa2AVu5W9fc8h5jM=; b=DC8KqrAfhlxMJSvebGIfGEU9yj
        06tmYxMqCVH4lBWqJC7UejllurrAWZtTTw1y+6cS2KyQCVj6XbJeOnChObnNoYLG7pBo6D0R8KjH/
        lIFwYUJxTmcJqNwwR5Zky/6EVefuzC2uxa1X9fds5Ck/hjsjzDazTWyAIys1a9Ke3MtBD//7u9KxC
        gKHnmpLop6DCAyEkfTOkPXPXp01VNIyZHSi5XT9tMVnTFNgRSfw6in3xPowRQ4exB/nhd9jUPp+cm
        xOOHlegeSo/bdK0kprTaifwkDwO2fnr6eOBcWP9vDUGwmafyBr32kKPGugE06bByzfMhA9jffsd8r
        CCRbWVvQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l1XvH-00D7Me-5u; Mon, 18 Jan 2021 17:02:35 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 16/27] mm: Convert lock_page_async to lock_folio_async
Date:   Mon, 18 Jan 2021 17:01:37 +0000
Message-Id: <20210118170148.3126186-17-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210118170148.3126186-1-willy@infradead.org>
References: <20210118170148.3126186-1-willy@infradead.org>
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
 mm/filemap.c            |  6 +++---
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 7c48b667954f..52f35e69467f 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -3388,7 +3388,7 @@ static int io_read_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 }
 
 /*
- * This is our waitqueue callback handler, registered through lock_page_async()
+ * This is our waitqueue callback handler, registered through lock_folio_async()
  * when we initially tried to do the IO with the iocb armed our waitqueue.
  * This gets called when the page is unlocked, and we generally expect that to
  * happen when the page IO is completed and the page is now uptodate. This will
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 5260ae7d9196..44fa7d974aa4 100644
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
@@ -686,18 +686,18 @@ static inline int lock_page_killable(struct page *page)
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
index 31b90b878eba..95015bc57bb7 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1537,9 +1537,9 @@ int __lock_folio_killable(struct folio *folio)
 }
 EXPORT_SYMBOL_GPL(__lock_folio_killable);
 
-int __lock_page_async(struct page *page, struct wait_page_queue *wait)
+int __lock_folio_async(struct folio *folio, struct wait_page_queue *wait)
 {
-	return __wait_on_page_locked_async(page, wait, true);
+	return __wait_on_page_locked_async(&folio->page, wait, true);
 }
 
 /*
@@ -2177,7 +2177,7 @@ static void shrink_readahead_size_eio(struct file_ra_state *ra)
 static int lock_page_for_iocb(struct kiocb *iocb, struct page *page)
 {
 	if (iocb->ki_flags & IOCB_WAITQ)
-		return lock_page_async(page, iocb->ki_waitq);
+		return lock_folio_async(page_folio(page), iocb->ki_waitq);
 	else if (iocb->ki_flags & IOCB_NOWAIT)
 		return trylock_page(page) ? 0 : -EAGAIN;
 	else
-- 
2.29.2

