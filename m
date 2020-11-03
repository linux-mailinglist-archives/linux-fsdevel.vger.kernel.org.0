Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE5FD2A3E2B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Nov 2020 08:57:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbgKCH5k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Nov 2020 02:57:40 -0500
Received: from verein.lst.de ([213.95.11.211]:36108 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725982AbgKCH5j (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Nov 2020 02:57:39 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3ABE167373; Tue,  3 Nov 2020 08:57:37 +0100 (CET)
Date:   Tue, 3 Nov 2020 08:57:36 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, hch@lst.de,
        kent.overstreet@gmail.com
Subject: Re: [PATCH 14/17] mm/filemap: Restructure filemap_get_pages
Message-ID: <20201103075736.GM8389@lst.de>
References: <20201102184312.25926-1-willy@infradead.org> <20201102184312.25926-15-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102184312.25926-15-willy@infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 02, 2020 at 06:43:09PM +0000, Matthew Wilcox (Oracle) wrote:
> Avoid a goto, and by the time we get to calling filemap_update_page(),
> we definitely have at least one page.

I find the error handling flow hard to follow and the existing but
heavily touched naming of the nr_got variable and the find_pages label
not helpful.  I'd do the following on top of this patch:

diff --git a/mm/filemap.c b/mm/filemap.c
index f16b1eb03bcad0..3ef73a58ce9456 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2344,51 +2344,54 @@ static int filemap_get_pages(struct kiocb *iocb, struct iov_iter *iter,
 	pgoff_t index = iocb->ki_pos >> PAGE_SHIFT;
 	pgoff_t last_index = (iocb->ki_pos + iter->count + PAGE_SIZE-1) >> PAGE_SHIFT;
 	struct page *page;
-	int nr_got, err = 0;
+	int nr_pages, err = 0;
 
 	nr = min_t(unsigned long, last_index - index, nr);
-find_page:
+retry:
 	if (fatal_signal_pending(current))
 		return -EINTR;
 
-	nr_got = mapping_get_read_thps(mapping, index, nr, pages);
-	if (!nr_got) {
+	nr_pages = mapping_get_read_thps(mapping, index, nr, pages);
+	if (!nr_pages) {
 		if (iocb->ki_flags & IOCB_NOIO)
 			return -EAGAIN;
 		page_cache_sync_readahead(mapping, ra, filp, index,
 				last_index - index);
-		nr_got = mapping_get_read_thps(mapping, index, nr, pages);
+		nr_pages = mapping_get_read_thps(mapping, index, nr, pages);
 	}
-	if (!nr_got) {
+	if (!nr_pages) {
 		if (iocb->ki_flags & (IOCB_NOWAIT | IOCB_WAITQ))
 			return -EAGAIN;
 		pages[0] = filemap_create_page(filp, mapping,
 				iocb->ki_pos >> PAGE_SHIFT);
 		if (!pages[0])
-			goto find_page;
+			goto retry;
 		if (IS_ERR(pages[0]))
 			return PTR_ERR(pages[0]);
 		return 1;
 	}
 
-	page = pages[nr_got - 1];
-	if (PageReadahead(page))
+	page = pages[nr_pages - 1];
+	if (PageReadahead(page)) {
 		err = filemap_readahead(iocb, filp, mapping, page, last_index);
-	if (!err && !PageUptodate(page))
+		if (err)
+			goto error;
+	}
+	if (!PageUptodate(page)) {
 		err = filemap_update_page(iocb, mapping, iter, page,
-				nr_got == 1);
+				nr_pages == 1);
+		if (err)
+			goto error;
+	}
 
-	if (err)
-		nr_got--;
-	if (likely(nr_got))
-		return nr_got;
-	if (err < 0)
-		return err;
-	err = 0;
-	/*
-	 * No pages and no error means we raced and should retry:
-	 */
-	goto find_page;
+	return nr_pages;
+
+error:
+	if (nr_pages > 1)
+		return nr_pages - 1;
+	if (err == AOP_TRUNCATED_PAGE)
+		goto retry;
+	return err;
 }
 
 /**
