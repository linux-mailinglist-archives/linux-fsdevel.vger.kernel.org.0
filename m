Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9DB29F566
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Oct 2020 20:34:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbgJ2Te2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Oct 2020 15:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgJ2TeM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Oct 2020 15:34:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B3DBC0613D3
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2020 12:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=toB6t8pYm3LNmloiIQYto1Jnb9pOJ7DO7/Ur4ZlMNcE=; b=b0ecZ0DXNvHzbtvr3lRs9mLhr1
        3gFIpggSVNuTQP6apiQvXyXhbVeyFuUt8FzveMDCuYRrxSY/ySB/u09BhV7CNCROjkJq8FfaULIrW
        PVzglXmnsWoXRa4okzDML9C1j6nZN05GcGhmPvuT7tSdkIwfEzSEl7qWfLBpu1/rOhdlJBDrLh+TM
        DToJBTbso6oLe34BpzzfzJ+bqb+G2oeM8KQAkfyVhXKTa3sDyapEvIAaN9gEnDF6o7aXsHUt4qCXo
        QAqvtOXrdwqW7z2ZrK7RHXrswqSbLmchxoUFVsuLHHpvlOP9OVfyBv7EcpdTTuMOckXiyFkwmPDFb
        vIeyp1sg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kYDgY-0007cU-V3; Thu, 29 Oct 2020 19:34:11 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 13/19] mm/filemap: Support readpage splitting a page
Date:   Thu, 29 Oct 2020 19:33:59 +0000
Message-Id: <20201029193405.29125-14-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201029193405.29125-1-willy@infradead.org>
References: <20201029193405.29125-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We need to tell readpage which subpage we're actually interested in
(by passing the subpage to gfbr_read_page()), and if it does split the
THP, we need to update the page in the page array to be the subpage.

For page splitting to succeed, the thread asking to split the
page has to be the only one with a reference to the page.  Calling
wait_on_page_locked() while holding a reference to the page will
effectively prevent this from happening with sufficient threads waiting
on the same page.  Use put_and_wait_on_page_locked() to sleep without
holding a reference to the page, then retry the page lookup after the
page is unlocked.

Since we now get the page lock a little earlier in gfbr_update_page(),
we can eliminate a number of duplicate checks.  The original intent
(commit ebded02788b5 ("avoid unnecessary calls to lock_page when waiting
for IO to complete during a read") behind getting the page lock later
was to avoid re-locking the page after it has been brought uptodate by
another thread.  We will still avoid that because we go through the normal
lookup path again after the winning thread has brought the page uptodate.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/filemap.c | 76 +++++++++++++++++-----------------------------------
 1 file changed, 24 insertions(+), 52 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 215729048cbd..87f89e5dd64e 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1358,14 +1358,6 @@ static int __wait_on_page_locked_async(struct page *page,
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
@@ -2259,6 +2251,7 @@ static struct page *gfbr_read_page(struct kiocb *iocb,
 		return error != AOP_TRUNCATED_PAGE ? ERR_PTR(error) : NULL;
 	}
 
+	page = thp_head(page);
 	if (!PageUptodate(page)) {
 		error = lock_page_for_iocb(iocb, page);
 		if (unlikely(error)) {
@@ -2292,64 +2285,42 @@ static struct page *gfbr_update_page(struct kiocb *iocb,
 	struct inode *inode = mapping->host;
 	int error;
 
-	/*
-	 * See comment in do_read_cache_page on why
-	 * wait_on_page_locked is used to avoid unnecessarily
-	 * serialisations and why it's safe.
-	 */
 	if (iocb->ki_flags & IOCB_WAITQ) {
-		error = wait_on_page_locked_async(page,
-						iocb->ki_waitq);
-	} else {
-		error = wait_on_page_locked_killable(page);
-	}
-	if (unlikely(error)) {
-		put_page(page);
-		return ERR_PTR(error);
+		error = lock_page_async(page, iocb->ki_waitq);
+		if (error) {
+			put_page(page);
+			return ERR_PTR(error);
+		}
+	} else if (!trylock_page(page)) {
+		put_and_wait_on_page_locked(page, TASK_KILLABLE);
+		return NULL;
 	}
+
 	if (PageUptodate(page))
-		return page;
+		goto uptodate;
 
 	if (inode->i_blkbits == PAGE_SHIFT ||
 			!mapping->a_ops->is_partially_uptodate)
-		goto page_not_up_to_date;
+		goto readpage;
 	/* pipes can't handle partially uptodate pages */
 	if (unlikely(iov_iter_is_pipe(iter)))
-		goto page_not_up_to_date;
-	if (!trylock_page(page))
-		goto page_not_up_to_date;
-	/* Did it get truncated before we got the lock? */
+		goto readpage;
 	if (!page->mapping)
-		goto page_not_up_to_date_locked;
+		goto truncated;
 	if (!mapping->a_ops->is_partially_uptodate(page,
-				pos & ~PAGE_MASK, count))
-		goto page_not_up_to_date_locked;
+				pos & (thp_size(page) - 1), count))
+		goto readpage;
+uptodate:
 	unlock_page(page);
 	return page;
 
-page_not_up_to_date:
-	/* Get exclusive access to the page ... */
-	error = lock_page_for_iocb(iocb, page);
-	if (unlikely(error)) {
-		put_page(page);
-		return ERR_PTR(error);
-	}
-
-page_not_up_to_date_locked:
-	/* Did it get truncated before we got the lock? */
-	if (!page->mapping) {
-		unlock_page(page);
-		put_page(page);
-		return NULL;
-	}
-
-	/* Did somebody else fill it already? */
-	if (PageUptodate(page)) {
-		unlock_page(page);
-		return page;
-	}
-
+readpage:
+	page += (pos / PAGE_SIZE) - page->index;
 	return gfbr_read_page(iocb, mapping, page);
+truncated:
+	unlock_page(page);
+	put_page(page);
+	return NULL;
 }
 
 static struct page *gfbr_create_page(struct kiocb *iocb,
@@ -2443,6 +2414,7 @@ static int gfbr_get_pages(struct kiocb *iocb, struct iov_iter *iter,
 				err = PTR_ERR_OR_ZERO(page);
 				break;
 			}
+			pages[i] = page;
 		}
 	}
 
-- 
2.28.0

