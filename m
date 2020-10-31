Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 884AE2A149B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Oct 2020 10:17:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbgJaJRh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 31 Oct 2020 05:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726499AbgJaJRg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 31 Oct 2020 05:17:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F2AFC0613D5
        for <linux-fsdevel@vger.kernel.org>; Sat, 31 Oct 2020 02:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=72kioQRjY98RpgK4QuUxSFT7vMo0vy/MqExRyumL2cA=; b=IncK17xmxYWZTcEyKXs6pri5QI
        Hj2ny0QoZ3iMGxMJGY0G6WifM0RBa2cfeKrYwppWi3h7m6HfSHfO6UMcIyflRBrO3e0av7Kx1GSWM
        zqnaA0q6MbmSxRTxCJf57uQYIkyyT1wOHGR5VACwSf0EjW6llaMsmdedtfhTnOHPMHiaH4E42uuz7
        +7rWxsdTlexlqd6xHlAhn23+H9kbb23KD3Du/9ufsKGavE9uhmxGMp6OmEHMpSSQy7BwUhJV74nMN
        L7layDB311k3/G0q7BiIhdG06ocXtmsjEyGn/3BYAr5gMkdpsDq8Lcd8UJuVlCkqbtSjqoA5fEl2j
        orwpbZuQ==;
Received: from 089144193201.atnat0002.highway.a1.net ([89.144.193.201] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kYn0w-0007zY-3a; Sat, 31 Oct 2020 09:17:34 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 07/13] mm: refactor generic_file_buffered_read_get_pages
Date:   Sat, 31 Oct 2020 09:59:58 +0100
Message-Id: <20201031090004.452516-8-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201031090004.452516-1-hch@lst.de>
References: <20201031090004.452516-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Move the call to filemap_make_page_uptodate for a newly allocated page
into filemap_new_page, which turns the new vs lookup decision into a
plain if / else statement, rename two identifier to be more obvious
and the function itself to filemap_read_pages which describes
it a little better while being much shorter.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/filemap.c | 52 ++++++++++++++++++++++++++--------------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 0af7ddaa0fe7ba..96855299247c56 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2320,7 +2320,10 @@ static int filemap_new_page(struct kiocb *iocb, struct iov_iter *iter,
 		return error;
 	}
 
-	return filemap_readpage(iocb, *page);
+	error = filemap_readpage(iocb, *page);
+	if (error)
+		return error;
+	return filemap_make_page_uptodate(iocb, iter, *page, index, true);
 }
 
 static int filemap_find_get_pages(struct kiocb *iocb, struct iov_iter *iter,
@@ -2344,40 +2347,38 @@ static int filemap_find_get_pages(struct kiocb *iocb, struct iov_iter *iter,
 	return find_get_pages_contig(mapping, index, nr, pages);
 }
 
-static int generic_file_buffered_read_get_pages(struct kiocb *iocb,
-						struct iov_iter *iter,
-						struct page **pages,
-						unsigned int nr)
+static int filemap_read_pages(struct kiocb *iocb, struct iov_iter *iter,
+		struct page **pages, unsigned int nr)
 {
 	pgoff_t index = iocb->ki_pos >> PAGE_SHIFT;
-	int i, j, nr_got, err = 0;
+	int nr_pages, err = 0, i, j;
 
-find_page:
+retry:
 	if (fatal_signal_pending(current))
 		return -EINTR;
 
-	nr_got = filemap_find_get_pages(iocb, iter, pages, nr);
-	if (!nr_got) {
+	nr_pages = filemap_find_get_pages(iocb, iter, pages, nr);
+	if (nr_pages) {
+		for (i = 0; i < nr_pages; i++) {
+			err = filemap_make_page_uptodate(iocb, iter, pages[i],
+					index + i, i == 0);
+			if (err) {
+				for (j = i + 1; j < nr_pages; j++)
+					put_page(pages[j]);
+				nr_pages = i;
+				break;
+			}
+		}
+	} else {
 		err = filemap_new_page(iocb, iter, &pages[0]);
 		if (!err)
-			nr_got = 1;
+			nr_pages = 1;
 	}
 
-	for (i = 0; i < nr_got; i++) {
-		err = filemap_make_page_uptodate(iocb, iter, pages[i],
-				index + i, i == 0);
-		if (err) {
-			for (j = i + 1; j < nr_got; j++)
-				put_page(pages[j]);
-			nr_got = i;
-			break;
-		}
-	}
-
-	if (likely(nr_got))
-		return nr_got;
+	if (likely(nr_pages))
+		return nr_pages;
 	if (err == -EEXIST || err == AOP_TRUNCATED_PAGE)
-		goto find_page;
+		goto retry;
 	return err;
 }
 
@@ -2436,8 +2437,7 @@ ssize_t generic_file_buffered_read(struct kiocb *iocb,
 			iocb->ki_flags |= IOCB_NOWAIT;
 
 		i = 0;
-		pg_nr = generic_file_buffered_read_get_pages(iocb, iter,
-							     pages, nr_pages);
+		pg_nr = filemap_read_pages(iocb, iter, pages, nr_pages);
 		if (pg_nr < 0) {
 			error = pg_nr;
 			break;
-- 
2.28.0

