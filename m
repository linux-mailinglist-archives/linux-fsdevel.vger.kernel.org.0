Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8B12A1491
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Oct 2020 10:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbgJaJP0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 31 Oct 2020 05:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbgJaJP0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 31 Oct 2020 05:15:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7736C0613D5
        for <linux-fsdevel@vger.kernel.org>; Sat, 31 Oct 2020 02:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=w7pP6ZwoBFCgYWc3JUgMBAPIvDyVUgvDwMandxHayiQ=; b=q/5iaxo7WNboQxCOEfk/hZZKVn
        lsOCR6oywpH+8Q85yuTc4j6w6RUrKjDYY9Yp/oEVqqgDBB5UUrUKXvwLSMJuTUCgR5fvjvkmywmw0
        LK8pbVDmYAWjwr4omJ4hPvYfzqE11pKgHLcMS/3XapoBYtpO7FZrLwoxn/vA/kEkG1y8SKUdT5koP
        wsLb0OmJ3lPbuEsRxW0GkOfXHLSAKEtgSYLtpjTFV3NNDsyW4rvrQX75CaAmhoynw8xD/JXfAQNEQ
        gju31KMDTItTMPfvJl99M9THTaSjHSEmTzhcKo9IWonpBr2KyjVAoEGR6vpkq05SnSIZRGue6jFO/
        WNc3pkOA==;
Received: from 089144193201.atnat0002.highway.a1.net ([89.144.193.201] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kYmyp-0007tB-0l; Sat, 31 Oct 2020 09:15:23 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 06/13] mm: factor out a filemap_find_get_pages helper
Date:   Sat, 31 Oct 2020 09:59:57 +0100
Message-Id: <20201031090004.452516-7-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201031090004.452516-1-hch@lst.de>
References: <20201031090004.452516-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Factor out a helper to lookup a range of contiguous pages from
generic_file_buffered_read_get_pages.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/filemap.c | 47 +++++++++++++++++++++++++++--------------------
 1 file changed, 27 insertions(+), 20 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 9e1cc18afe1134..0af7ddaa0fe7ba 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2323,39 +2323,46 @@ static int filemap_new_page(struct kiocb *iocb, struct iov_iter *iter,
 	return filemap_readpage(iocb, *page);
 }
 
+static int filemap_find_get_pages(struct kiocb *iocb, struct iov_iter *iter,
+		struct page **pages, unsigned int nr)
+{
+	struct address_space *mapping = iocb->ki_filp->f_mapping;
+	pgoff_t index = iocb->ki_pos >> PAGE_SHIFT;
+	pgoff_t last_index = (iocb->ki_pos + iter->count + PAGE_SIZE - 1) >>
+			PAGE_SHIFT;
+	int nr_pages;
+
+	nr = min_t(unsigned long, last_index - index, nr);
+	nr_pages = find_get_pages_contig(mapping, index, nr, pages);
+	if (nr_pages)
+		return nr_pages;
+
+	if (iocb->ki_flags & IOCB_NOIO)
+		return -EAGAIN;
+	page_cache_sync_readahead(mapping, &iocb->ki_filp->f_ra, iocb->ki_filp,
+			index, last_index - index);
+	return find_get_pages_contig(mapping, index, nr, pages);
+}
+
 static int generic_file_buffered_read_get_pages(struct kiocb *iocb,
 						struct iov_iter *iter,
 						struct page **pages,
 						unsigned int nr)
 {
-	struct file *filp = iocb->ki_filp;
-	struct address_space *mapping = filp->f_mapping;
-	struct file_ra_state *ra = &filp->f_ra;
 	pgoff_t index = iocb->ki_pos >> PAGE_SHIFT;
-	pgoff_t last_index = (iocb->ki_pos + iter->count + PAGE_SIZE-1) >> PAGE_SHIFT;
 	int i, j, nr_got, err = 0;
 
-	nr = min_t(unsigned long, last_index - index, nr);
 find_page:
 	if (fatal_signal_pending(current))
 		return -EINTR;
 
-	nr_got = find_get_pages_contig(mapping, index, nr, pages);
-	if (nr_got)
-		goto got_pages;
-
-	if (iocb->ki_flags & IOCB_NOIO)
-		return -EAGAIN;
-
-	page_cache_sync_readahead(mapping, ra, filp, index, last_index - index);
+	nr_got = filemap_find_get_pages(iocb, iter, pages, nr);
+	if (!nr_got) {
+		err = filemap_new_page(iocb, iter, &pages[0]);
+		if (!err)
+			nr_got = 1;
+	}
 
-	nr_got = find_get_pages_contig(mapping, index, nr, pages);
-	if (nr_got)
-		goto got_pages;
-	err = filemap_new_page(iocb, iter, &pages[0]);
-	if (!err)
-		nr_got = 1;
-got_pages:
 	for (i = 0; i < nr_got; i++) {
 		err = filemap_make_page_uptodate(iocb, iter, pages[i],
 				index + i, i == 0);
-- 
2.28.0

