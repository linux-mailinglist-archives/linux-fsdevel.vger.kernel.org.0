Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA9522A1485
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Oct 2020 10:11:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbgJaJLE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 31 Oct 2020 05:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbgJaJLD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 31 Oct 2020 05:11:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79640C0613D5
        for <linux-fsdevel@vger.kernel.org>; Sat, 31 Oct 2020 02:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=2sJM8L6vqDc82P4Zib4xzj+qKJ0+sgvNKXsT+iu4GIo=; b=ACTuWGopBUTRfiwiY/2UfoxmBR
        rxlS/8ys9h/z7FKsIObrB0RA1+xvAQ9HVg0vBHoa/CVwBaxVa8CUyrKCfZk9Zbs0BMxExyA4D4rov
        C0hKhk1MiwGZfLO6hspSTCPN9O0aBkqKxGS53TmTdDsswPbzGIBnU5WxADliiqgtmGxhMFu+NV4Fb
        KcVxuvmXwbfAk2OxgHAbfnPD4/pAVSEFIYE4MK4ldW6XnJmi0ej1WSV3dMccPpFKexJ+5ZqgrybcR
        Hcffrm3fEpATXviWbUOiL8YwF1+Jj8mZpZEXWUz8/EHBIkLnHcJM+gRgXz4ggpFq9r4mVtRGAsBPn
        x2T2HJtg==;
Received: from 089144193201.atnat0002.highway.a1.net ([89.144.193.201] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kYmua-0007ZY-Ru; Sat, 31 Oct 2020 09:11:01 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 04/13] mm: handle readahead in generic_file_buffered_read_pagenotuptodate
Date:   Sat, 31 Oct 2020 09:59:55 +0100
Message-Id: <20201031090004.452516-5-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201031090004.452516-1-hch@lst.de>
References: <20201031090004.452516-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Move the calculation of the per-page variables and the readahead handling
from the only caller into generic_file_buffered_read_pagenotuptodate,
which now becomes a routine to handle everything related to bringing
one page uptodate and thus is renamed to filemap_read_one_page.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/filemap.c | 63 +++++++++++++++++++++++-----------------------------
 1 file changed, 28 insertions(+), 35 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index bae5b905aa7bdc..5cdf8090d4e12c 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2217,13 +2217,26 @@ static int filemap_readpage(struct kiocb *iocb, struct page *page)
 	return error;
 }
 
-static int generic_file_buffered_read_pagenotuptodate(struct kiocb *iocb,
-		struct iov_iter *iter, struct page *page, loff_t pos,
-		loff_t count, bool first)
+static int filemap_make_page_uptodate(struct kiocb *iocb, struct iov_iter *iter,
+		struct page *page, pgoff_t pg_index, bool first)
 {
-	struct address_space *mapping = iocb->ki_filp->f_mapping;
+	struct file *file = iocb->ki_filp;
+	struct address_space *mapping = file->f_mapping;
+	loff_t last = iocb->ki_pos + iter->count;
+	pgoff_t last_index = (last + PAGE_SIZE - 1) >> PAGE_SHIFT;
+	loff_t pos = max(iocb->ki_pos, (loff_t)pg_index << PAGE_SHIFT);
 	int error = -EAGAIN;
 
+	if (PageReadahead(page)) {
+		if (iocb->ki_flags & IOCB_NOIO)
+			goto put_page;
+		page_cache_async_readahead(mapping, &file->f_ra, file, page,
+					   pg_index, last_index - pg_index);
+	}
+
+	if (PageUptodate(page))
+		return 0;
+
 	if (iocb->ki_flags & IOCB_NOWAIT)
 		goto put_page;
 
@@ -2255,8 +2268,8 @@ static int generic_file_buffered_read_pagenotuptodate(struct kiocb *iocb,
 	/* Did it get truncated before we got the lock? */
 	if (!page->mapping)
 		goto page_not_up_to_date_locked;
-	if (!mapping->a_ops->is_partially_uptodate(page,
-				pos & ~PAGE_MASK, count))
+	if (!mapping->a_ops->is_partially_uptodate(page, pos & ~PAGE_MASK,
+			last - pos))
 		goto page_not_up_to_date_locked;
 
 unlock_page:
@@ -2360,35 +2373,15 @@ static int generic_file_buffered_read_get_pages(struct kiocb *iocb,
 		nr_got = 1;
 got_pages:
 	for (i = 0; i < nr_got; i++) {
-		struct page *page = pages[i];
-		pgoff_t pg_index = index + i;
-		loff_t pg_pos = max(iocb->ki_pos,
-				    (loff_t) pg_index << PAGE_SHIFT);
-		loff_t pg_count = iocb->ki_pos + iter->count - pg_pos;
-
-		if (PageReadahead(page)) {
-			if (iocb->ki_flags & IOCB_NOIO) {
-				for (j = i; j < nr_got; j++)
-					put_page(pages[j]);
-				nr_got = i;
-				err = -EAGAIN;
-				break;
-			}
-			page_cache_async_readahead(mapping, ra, filp, page,
-					pg_index, last_index - pg_index);
-		}
-
-		if (!PageUptodate(page)) {
-			err = generic_file_buffered_read_pagenotuptodate(iocb,
-					iter, page, pg_pos, pg_count, i == 0);
-			if (err) {
-				if (err == AOP_TRUNCATED_PAGE)
-					err = 0;
-				for (j = i + 1; j < nr_got; j++)
-					put_page(pages[j]);
-				nr_got = i;
-				break;
-			}
+		err = filemap_make_page_uptodate(iocb, iter, pages[i],
+				index + i, i == 0);
+		if (err) {
+			if (err == AOP_TRUNCATED_PAGE)
+				err = 0;
+			for (j = i + 1; j < nr_got; j++)
+				put_page(pages[j]);
+			nr_got = i;
+			break;
 		}
 	}
 
-- 
2.28.0

