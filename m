Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D089F2A1458
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Oct 2020 10:04:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbgJaJE3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 31 Oct 2020 05:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbgJaJE3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 31 Oct 2020 05:04:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E31F7C0613D5
        for <linux-fsdevel@vger.kernel.org>; Sat, 31 Oct 2020 02:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=dg723lnpWwNTxY9ABCjUoTAWt08WeAMzn07QoHNZtdY=; b=rPE+iUoURvcX2caUdfem5LlykZ
        kyPM2JEYriA1DLC1gDnZmLc/R1XPQmrgQ+ZXDMbyG49cWcPfAkpxyPvEf/X1V4ZyGvDyUJcZS1S3J
        rm5DyhcN3+f6xhU3ywxEOlJjPX31jywIOCenUm/jwtd+mTi1gkKR8M11TtdixRpjkD9wBwU8EPrYi
        nOiIZAQ9Il5fEyhvUta8zvVqx+EkZyCFlZlB4K4Ffjks9w3LyDe9s+xqVMRUt42XuBpaXa4CVO48j
        nu0/eicU/avxbITINhBURcvaPiKOy3xugRiYFIajQv+/PQFSv7/Owqn7ElN/4Tj+ES4HS5NSUaZMO
        SANv1kSw==;
Received: from 089144193201.atnat0002.highway.a1.net ([89.144.193.201] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kYmoD-00075v-NF; Sat, 31 Oct 2020 09:04:26 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 01/13] mm: simplify generic_file_buffered_read_readpage
Date:   Sat, 31 Oct 2020 09:59:52 +0100
Message-Id: <20201031090004.452516-2-hch@lst.de>
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
use goto labels to share common code.  Also rename the function to
filemap_readpage as it is a fairly generic wrapper around ->readpage
that isn't really specific to generic_file_buffered_read.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/filemap.c | 66 ++++++++++++++++++++++++++++------------------------
 1 file changed, 36 insertions(+), 30 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index d90614f501daa5..2e997890cc81c2 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2168,59 +2168,53 @@ static int lock_page_for_iocb(struct kiocb *iocb, struct page *page)
 		return lock_page_killable(page);
 }
 
-static struct page *
-generic_file_buffered_read_readpage(struct kiocb *iocb,
-				    struct file *filp,
-				    struct address_space *mapping,
-				    struct page *page)
+static int filemap_readpage(struct kiocb *iocb, struct page *page)
 {
-	struct file_ra_state *ra = &filp->f_ra;
-	int error;
+	struct file *file = iocb->ki_filp;
+	int error = -EAGAIN;
 
 	if (iocb->ki_flags & (IOCB_NOIO | IOCB_NOWAIT)) {
 		unlock_page(page);
-		put_page(page);
-		return ERR_PTR(-EAGAIN);
+		goto out_put_page;
 	}
 
 	/*
-	 * A previous I/O error may have been due to temporary
-	 * failures, eg. multipath errors.
-	 * PG_error will be set again if readpage fails.
+	 * A previous I/O error may have been due to temporary failures, e.g.
+	 * multipath errors.  PG_error will be set again if readpage fails.
 	 */
 	ClearPageError(page);
 	/* Start the actual read. The read will unlock the page. */
-	error = mapping->a_ops->readpage(filp, page);
-
-	if (unlikely(error)) {
-		put_page(page);
-		return error != AOP_TRUNCATED_PAGE ? ERR_PTR(error) : NULL;
-	}
+	error = file->f_mapping->a_ops->readpage(file, page);
+	if (unlikely(error))
+		goto out_put_page;
 
 	if (!PageUptodate(page)) {
 		error = lock_page_for_iocb(iocb, page);
-		if (unlikely(error)) {
-			put_page(page);
-			return ERR_PTR(error);
-		}
+		if (unlikely(error))
+			goto out_put_page;
+
 		if (!PageUptodate(page)) {
 			if (page->mapping == NULL) {
 				/*
 				 * invalidate_mapping_pages got it
 				 */
 				unlock_page(page);
-				put_page(page);
-				return NULL;
+				error = AOP_TRUNCATED_PAGE;
+				goto out_put_page;
 			}
 			unlock_page(page);
-			shrink_readahead_size_eio(ra);
-			put_page(page);
-			return ERR_PTR(-EIO);
+			shrink_readahead_size_eio(&file->f_ra);
+			error = -EIO;
+			goto out_put_page;
 		}
+
 		unlock_page(page);
 	}
+	return 0;
 
-	return page;
+out_put_page:
+	put_page(page);
+	return error;
 }
 
 static struct page *
@@ -2291,7 +2285,13 @@ generic_file_buffered_read_pagenotuptodate(struct kiocb *iocb,
 		return page;
 	}
 
-	return generic_file_buffered_read_readpage(iocb, filp, mapping, page);
+	error = filemap_readpage(iocb, page);
+	if (error) {
+		if (error == AOP_TRUNCATED_PAGE)
+			return NULL;
+		return ERR_PTR(error);
+	}
+	return page;
 }
 
 static struct page *
@@ -2322,7 +2322,13 @@ generic_file_buffered_read_no_cached_page(struct kiocb *iocb,
 		return error != -EEXIST ? ERR_PTR(error) : NULL;
 	}
 
-	return generic_file_buffered_read_readpage(iocb, filp, mapping, page);
+	error = filemap_readpage(iocb, page);
+	if (error) {
+		if (error == AOP_TRUNCATED_PAGE)
+			return NULL;
+		return ERR_PTR(error);
+	}
+	return page;
 }
 
 static int generic_file_buffered_read_get_pages(struct kiocb *iocb,
-- 
2.28.0

