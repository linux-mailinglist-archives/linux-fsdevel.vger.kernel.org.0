Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1875B2A1460
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Oct 2020 10:06:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgJaJGk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 31 Oct 2020 05:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbgJaJGj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 31 Oct 2020 05:06:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D93FC0613D5
        for <linux-fsdevel@vger.kernel.org>; Sat, 31 Oct 2020 02:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=UhjBocD9yV7vleGZemMhqxRkxBzWAvsA1Wt9SDILgQE=; b=b5SHlqYU5G3+SmN+u5SR0LlG8C
        BTFqhQLOoRnZHy3KYgfOy97MJKbm9ykalT3/zTPvErfjA1NrftfvBF6sFepKFVZiPDK4a1yol+S6I
        mlwhwKvwKQ47jL1yT2M85T6ulDw3WiQ+unelr+p3NUGNwcy080uMoNcJ0B/NjQ9QmRlkmMuIETcnz
        kPQ+rP+1tV+DzLWdWw3dzLU3rFYAfhzM0LbjeSPTkVXwGpgJAHA8QVqJ4EznWsKPzwKz1G6gKNqyi
        xDn0bf42iyU54YL+QsZccEpvmU3QoHSncLRgVeoe1uODpiwhVeMijaIaK2QB4YuZFvAfd2DpmibvZ
        /TntT/GA==;
Received: from 089144193201.atnat0002.highway.a1.net ([89.144.193.201] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kYmqK-0007Fl-R6; Sat, 31 Oct 2020 09:06:37 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 02/13] mm: simplify generic_file_buffered_read_pagenotuptodate
Date:   Sat, 31 Oct 2020 09:59:53 +0100
Message-Id: <20201031090004.452516-3-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201031090004.452516-1-hch@lst.de>
References: <20201031090004.452516-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Stop passing pointless arguments, and return an int instead of a page
struct that contains either the passed in page, an ERR_PTR or NULL and
use goto labels to share common code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/filemap.c | 65 ++++++++++++++++++++++------------------------------
 1 file changed, 28 insertions(+), 37 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 2e997890cc81c2..c717cfe35cc72a 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2217,15 +2217,11 @@ static int filemap_readpage(struct kiocb *iocb, struct page *page)
 	return error;
 }
 
-static struct page *
-generic_file_buffered_read_pagenotuptodate(struct kiocb *iocb,
-					   struct file *filp,
-					   struct iov_iter *iter,
-					   struct page *page,
-					   loff_t pos, loff_t count)
+static int generic_file_buffered_read_pagenotuptodate(struct kiocb *iocb,
+		struct iov_iter *iter, struct page *page, loff_t pos,
+		loff_t count)
 {
-	struct address_space *mapping = filp->f_mapping;
-	struct inode *inode = mapping->host;
+	struct address_space *mapping = iocb->ki_filp->f_mapping;
 	int error;
 
 	/*
@@ -2239,15 +2235,14 @@ generic_file_buffered_read_pagenotuptodate(struct kiocb *iocb,
 	} else {
 		error = wait_on_page_locked_killable(page);
 	}
-	if (unlikely(error)) {
-		put_page(page);
-		return ERR_PTR(error);
-	}
+	if (unlikely(error))
+		goto put_page;
+
 	if (PageUptodate(page))
-		return page;
+		return 0;
 
-	if (inode->i_blkbits == PAGE_SHIFT ||
-			!mapping->a_ops->is_partially_uptodate)
+	if (mapping->host->i_blkbits == PAGE_SHIFT ||
+	    !mapping->a_ops->is_partially_uptodate)
 		goto page_not_up_to_date;
 	/* pipes can't handle partially uptodate pages */
 	if (unlikely(iov_iter_is_pipe(iter)))
@@ -2260,38 +2255,33 @@ generic_file_buffered_read_pagenotuptodate(struct kiocb *iocb,
 	if (!mapping->a_ops->is_partially_uptodate(page,
 				pos & ~PAGE_MASK, count))
 		goto page_not_up_to_date_locked;
+
+unlock_page:
 	unlock_page(page);
-	return page;
+	return 0;
 
 page_not_up_to_date:
 	/* Get exclusive access to the page ... */
 	error = lock_page_for_iocb(iocb, page);
-	if (unlikely(error)) {
-		put_page(page);
-		return ERR_PTR(error);
-	}
+	if (unlikely(error))
+		goto put_page;
 
 page_not_up_to_date_locked:
 	/* Did it get truncated before we got the lock? */
 	if (!page->mapping) {
 		unlock_page(page);
-		put_page(page);
-		return NULL;
+		error = AOP_TRUNCATED_PAGE;
+		goto put_page;
 	}
 
 	/* Did somebody else fill it already? */
-	if (PageUptodate(page)) {
-		unlock_page(page);
-		return page;
-	}
+	if (PageUptodate(page))
+		goto unlock_page;
+	return filemap_readpage(iocb, page);
 
-	error = filemap_readpage(iocb, page);
-	if (error) {
-		if (error == AOP_TRUNCATED_PAGE)
-			return NULL;
-		return ERR_PTR(error);
-	}
-	return page;
+put_page:
+	put_page(page);
+	return error;
 }
 
 static struct page *
@@ -2395,13 +2385,14 @@ static int generic_file_buffered_read_get_pages(struct kiocb *iocb,
 				break;
 			}
 
-			page = generic_file_buffered_read_pagenotuptodate(iocb,
-					filp, iter, page, pg_pos, pg_count);
-			if (IS_ERR_OR_NULL(page)) {
+			err = generic_file_buffered_read_pagenotuptodate(iocb,
+					iter, page, pg_pos, pg_count);
+			if (err) {
+				if (err == AOP_TRUNCATED_PAGE)
+					err = 0;
 				for (j = i + 1; j < nr_got; j++)
 					put_page(pages[j]);
 				nr_got = i;
-				err = PTR_ERR_OR_ZERO(page);
 				break;
 			}
 		}
-- 
2.28.0

