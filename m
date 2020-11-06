Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC00D2A919D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Nov 2020 09:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbgKFIht (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Nov 2020 03:37:49 -0500
Received: from verein.lst.de ([213.95.11.211]:50655 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725830AbgKFIht (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Nov 2020 03:37:49 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id A7CE368B02; Fri,  6 Nov 2020 09:37:46 +0100 (CET)
Date:   Fri, 6 Nov 2020 09:37:46 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, hch@lst.de,
        kent.overstreet@gmail.com
Subject: Re: [PATCH v2 11/18] mm/filemap: Convert filemap_update_page to
 return an errno
Message-ID: <20201106083746.GA720@lst.de>
References: <20201104204219.23810-1-willy@infradead.org> <20201104204219.23810-12-willy@infradead.org> <20201106081420.GF31585@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201106081420.GF31585@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 06, 2020 at 09:14:20AM +0100, Christoph Hellwig wrote:
> We could still consolidate the page unlocking by having another label.
> Or even better move the put_page into the caller like I did in my
> series, which would conceputally fit in pretty nicely here:

FYI, this is what we should do for putting the page (on top of your
whole series), which also catches the leak for the readahead NOIO case:

diff --git a/mm/filemap.c b/mm/filemap.c
index 500e9fd4232cf9..dacee60b92d3d9 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2268,40 +2268,35 @@ static int filemap_update_page(struct kiocb *iocb,
 		struct address_space *mapping, struct iov_iter *iter,
 		struct page *page)
 {
-	int error = -EAGAIN;
+	int error = 0;
 
 	if (!trylock_page(page)) {
 		if (iocb->ki_flags & (IOCB_NOWAIT | IOCB_NOIO))
-			goto error;
+			return -EAGAIN;
 		if (!(iocb->ki_flags & IOCB_WAITQ)) {
 			put_and_wait_on_page_locked(page, TASK_KILLABLE);
 			return AOP_TRUNCATED_PAGE;
 		}
 		error = __lock_page_async(page, iocb->ki_waitq);
 		if (error)
-			goto error;
+			return error;
 	}
 
-	error = AOP_TRUNCATED_PAGE;
-	if (!page->mapping)
-		goto unlock;
-	if (filemap_range_uptodate(iocb, mapping, iter, page)) {
+	if (!page->mapping) {
 		unlock_page(page);
-		return 0;
+		put_page(page);
+		return AOP_TRUNCATED_PAGE;
 	}
 
-	error = -EAGAIN;
-	if (iocb->ki_flags & (IOCB_NOIO | IOCB_NOWAIT | IOCB_WAITQ))
-		goto unlock;
+	if (!filemap_range_uptodate(iocb, mapping, iter, page)) {
+		error = -EAGAIN;
+		if (iocb->ki_flags & (IOCB_NOIO | IOCB_NOWAIT | IOCB_WAITQ))
+			goto unlock;
+		return filemap_read_page(iocb->ki_filp, mapping, page);
+	}
 
-	error = filemap_read_page(iocb->ki_filp, mapping, page);
-	if (error)
-		goto error;
-	return 0;
 unlock:
 	unlock_page(page);
-error:
-	put_page(page);
 	return error;
 }
 
@@ -2396,8 +2391,9 @@ static int filemap_get_pages(struct kiocb *iocb, struct iov_iter *iter,
 
 	return 0;
 err:
-	pvec->nr--;
-	if (likely(pvec->nr))
+	if (err < 0)
+		put_page(page);
+	if (likely(--pvec->nr))
 		return 0;
 	if (err == AOP_TRUNCATED_PAGE)
 		goto retry;
