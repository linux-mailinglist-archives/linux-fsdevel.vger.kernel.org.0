Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2A8E2ACBEF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Nov 2020 04:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731377AbgKJDhQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Nov 2020 22:37:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731035AbgKJDhK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Nov 2020 22:37:10 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE748C0613D4
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 Nov 2020 19:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=n9yY+OuF+/jJuK0/yeMSG8Xr1624zMt+Oin9X33PihY=; b=WX07c/ipioJ1fTlelv673UPthd
        KGrlefLxRkDNBUv/xAJanLBYLDTAjwmy2vvLbZVNQLWcedePiuMqG2LlFfsnutXtrDxx5GHBttFNV
        0K4LssFOzdaPFJP3lNG0R/qbuEkJRPZb+4vrZQY+DMgK86qeGETpIBIEtMBcFixP3xj1AvIwUj/o0
        nocWkZdMRz4ErYBBW0tj58MpFaIgxUh20N4W0CeiJn3C3fAetzh3feAO8cdgOvM2Y7q3XMJ+7WpWo
        A0v/a45JyAmstOPkacFr83q3uN4L0PYzOJNhYeuVqCf0ScfY+GcrdPPUxBEFdKampTXIzzGOwTlc1
        Fnu6SiDQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kcKSy-000654-76; Tue, 10 Nov 2020 03:37:08 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, hch@lst.de,
        kent.overstreet@gmail.com
Subject: [PATCH v3 06/18] mm/filemap: Support readpage splitting a page
Date:   Tue, 10 Nov 2020 03:36:51 +0000
Message-Id: <20201110033703.23261-7-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201110033703.23261-1-willy@infradead.org>
References: <20201110033703.23261-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

For page splitting to succeed, the thread asking to split the
page has to be the only one with a reference to the page.  Calling
wait_on_page_locked() while holding a reference to the page will
effectively prevent this from happening with sufficient threads waiting
on the same page.  Use put_and_wait_on_page_locked() to sleep without
holding a reference to the page, then retry the page lookup after the
page is unlocked.

Since we now get the page lock a little earlier in filemap_update_page(),
we can eliminate a number of duplicate checks.  The original intent
(commit ebded02788b5 ("avoid unnecessary calls to lock_page when waiting
for IO to complete during a read")) behind getting the page lock later
was to avoid re-locking the page after it has been brought uptodate by
another thread.  We still avoid that because we go through the normal
lookup path again after the winning thread has brought the page uptodate.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Kent Overstreet <kent.overstreet@gmail.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 mm/filemap.c | 76 ++++++++++++++++------------------------------------
 1 file changed, 23 insertions(+), 53 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index a2681f6882cf..cf75780eb6e0 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1347,14 +1347,6 @@ static int __wait_on_page_locked_async(struct page *page,
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
@@ -2284,64 +2276,42 @@ static struct page *filemap_update_page(struct kiocb *iocb, struct file *filp,
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
+		error = lock_page_async(page, iocb->ki_waitq);
+		if (error) {
+			put_page(page);
+			return ERR_PTR(error);
+		}
 	} else {
-		error = wait_on_page_locked_killable(page);
-	}
-	if (unlikely(error)) {
-		put_page(page);
-		return ERR_PTR(error);
+		if (!trylock_page(page)) {
+			put_and_wait_on_page_locked(page, TASK_KILLABLE);
+			return NULL;
+		}
 	}
-	if (PageUptodate(page))
-		return page;
 
+	if (!page->mapping)
+		goto truncated;
+	if (PageUptodate(page))
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
-	if (!page->mapping)
-		goto page_not_up_to_date_locked;
+		goto readpage;
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
 	return filemap_read_page(iocb, filp, mapping, page);
+truncated:
+	unlock_page(page);
+	put_page(page);
+	return NULL;
 }
 
 static struct page *filemap_create_page(struct kiocb *iocb,
-- 
2.28.0

