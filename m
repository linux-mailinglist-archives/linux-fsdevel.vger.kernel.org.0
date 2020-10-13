Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FFB128C76E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Oct 2020 05:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728355AbgJMDAN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Oct 2020 23:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727888AbgJMDAM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Oct 2020 23:00:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41E0EC0613D0
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Oct 2020 20:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=cGMqVBjPL8DLxvt5nvis30KLBURktAaBL51raCa7emk=; b=nUigWXzZc5IxgiiCum0fJXD9mK
        4kStJQmmLDB75T4qCMFt0LMmqZk0hQ5t5HbkIeLSooT45gdosZa68hddLwWrvP0DdnY7Y88cyKOPV
        3D2KAI/dfS3/oRo7B/ySJ3Wm1toQYsPhxA5/MPNTRhXxyxAx9wG4boxJv8LNxx1EKVPQ2Ltgk5mRk
        UMtOPAh0g5N9yRpiQSqVWSGm0OYQCh5PfUvwrDqNiODPpHWuQztvOVqrGL6ke///G0RZrif7kdb9J
        MhTz7MzB+VEcUhuFd5xt7sLkgLlJ/SdG3iavldqeFkMYQc5kupQLS/3SqrM+B1QrtMrZDiA2iH1Tg
        m11rrDkA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kSAXq-000765-H2; Tue, 13 Oct 2020 03:00:10 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 2/3] mm/filemap: Don't hold a page reference while waiting for unlock
Date:   Tue, 13 Oct 2020 04:00:07 +0100
Message-Id: <20201013030008.27219-4-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201013030008.27219-1-willy@infradead.org>
References: <20201013030008.27219-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In the upcoming THP patch series, if we find a !Uptodate page, it
is because of a read error.  In this case, we want to split the THP
into smaller pages so we can handle the error in as granular a fashion
as possible.  But xfstests generic/273 defeats this strategy by having
500 threads all sleeping on the same page, each waiting for their turn
to split the page.  None of them will ever succeed because splitting a
page requires that you hold the only reference to it.

To fix this, use put_and_wait_on_page_locked() to sleep without holding a
reference to the page.  Each of the readers will then go back and retry
the page lookup after the page is unlocked.

Since we now get the page lock a little earlier in
generic_file_buffered_read(), we can eliminate a number of duplicate
checks.  The original intent (commit ebded02788b5 ("avoid unnecessary
calls to lock_page when waiting for IO to complete during a read")
behind getting the page lock later was to avoid re-locking the page
after it has been brought uptodate by another thread.  We will still
avoid that because we go through the normal lookup path again after the
winning thread has brought the page uptodate.

Using the "fail 10% of readaheads" patch, which will induce the !Uptodate
case, I can detect no significant difference by applying this patch with
the generic/273 test.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/filemap.c | 69 +++++++++++++++-------------------------------------
 1 file changed, 20 insertions(+), 49 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index f70227941627..ac2dfa857568 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1254,14 +1254,6 @@ static int __wait_on_page_locked_async(struct page *page,
 	return ret;
 }
 
-static int wait_on_page_locked_async(struct page *page,
-				     struct wait_page_queue *wait)
-{
-	if (!PageLocked(page))
-		return 0;
-	return __wait_on_page_locked_async(compound_head(page), wait, false);
-}
-
 /**
  * put_and_wait_on_page_locked - Drop a reference and wait for it to be unlocked
  * @page: The page to wait for.
@@ -2128,34 +2120,37 @@ ssize_t generic_file_buffered_read(struct kiocb *iocb,
 					put_page(page);
 					goto out;
 				}
-				error = wait_on_page_locked_async(page,
-								iocb->ki_waitq);
+				error = lock_page_async(page, iocb->ki_waitq);
+				if (error)
+					goto readpage_error;
+			} else if (iocb->ki_flags & IOCB_NOWAIT) {
+				put_page(page);
+				goto would_block;
 			} else {
-				if (iocb->ki_flags & IOCB_NOWAIT) {
-					put_page(page);
-					goto would_block;
+				if (!trylock_page(page)) {
+					put_and_wait_on_page_locked(page,
+							TASK_KILLABLE);
+					continue;
 				}
-				error = wait_on_page_locked_killable(page);
 			}
-			if (unlikely(error))
-				goto readpage_error;
 			if (PageUptodate(page))
-				goto page_ok;
+				goto uptodate;
+			if (!page->mapping) {
+				unlock_page(page);
+				put_page(page);
+				continue;
+			}
 
 			if (inode->i_blkbits == PAGE_SHIFT ||
 					!mapping->a_ops->is_partially_uptodate)
-				goto page_not_up_to_date;
+				goto readpage;
 			/* pipes can't handle partially uptodate pages */
 			if (unlikely(iov_iter_is_pipe(iter)))
-				goto page_not_up_to_date;
-			if (!trylock_page(page))
-				goto page_not_up_to_date;
-			/* Did it get truncated before we got the lock? */
-			if (!page->mapping)
-				goto page_not_up_to_date_locked;
+				goto readpage;
 			if (!mapping->a_ops->is_partially_uptodate(page,
 							offset, iter->count))
-				goto page_not_up_to_date_locked;
+				goto readpage;
+uptodate:
 			unlock_page(page);
 		}
 page_ok:
@@ -2221,30 +2216,6 @@ ssize_t generic_file_buffered_read(struct kiocb *iocb,
 			goto out;
 		}
 		continue;
-
-page_not_up_to_date:
-		/* Get exclusive access to the page ... */
-		if (iocb->ki_flags & IOCB_WAITQ)
-			error = lock_page_async(page, iocb->ki_waitq);
-		else
-			error = lock_page_killable(page);
-		if (unlikely(error))
-			goto readpage_error;
-
-page_not_up_to_date_locked:
-		/* Did it get truncated before we got the lock? */
-		if (!page->mapping) {
-			unlock_page(page);
-			put_page(page);
-			continue;
-		}
-
-		/* Did somebody else fill it already? */
-		if (PageUptodate(page)) {
-			unlock_page(page);
-			goto page_ok;
-		}
-
 readpage:
 		if (iocb->ki_flags & (IOCB_NOIO | IOCB_NOWAIT)) {
 			unlock_page(page);
-- 
2.28.0

