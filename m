Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 019362A3E01
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Nov 2020 08:49:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbgKCHts (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Nov 2020 02:49:48 -0500
Received: from verein.lst.de ([213.95.11.211]:36075 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725958AbgKCHtr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Nov 2020 02:49:47 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id AEF6B67373; Tue,  3 Nov 2020 08:49:44 +0100 (CET)
Date:   Tue, 3 Nov 2020 08:49:44 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, hch@lst.de,
        kent.overstreet@gmail.com
Subject: Re: [PATCH 11/17] mm/filemap: Add filemap_range_uptodate
Message-ID: <20201103074944.GK8389@lst.de>
References: <20201102184312.25926-1-willy@infradead.org> <20201102184312.25926-12-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102184312.25926-12-willy@infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 02, 2020 at 06:43:06PM +0000, Matthew Wilcox (Oracle) wrote:
> Move the complicated condition and the calculations out of
> filemap_update_page() into its own function.

The logic looks good, but the flow inside of filemap_update_page looks
odd.  The patch below relative to this commit shows how I'd do it:

diff --git a/mm/filemap.c b/mm/filemap.c
index 81b569d818a3f8..304180c022d38a 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2266,40 +2266,39 @@ static int filemap_update_page(struct kiocb *iocb,
 	if (!trylock_page(page)) {
 		if (iocb->ki_flags & (IOCB_NOWAIT | IOCB_NOIO))
 			goto error;
-		if (iocb->ki_flags & IOCB_WAITQ) {
-			if (!first)
-				goto error;
-			error = __lock_page_async(page, iocb->ki_waitq);
-			if (error)
-				goto error;
-		} else {
+		if (!(iocb->ki_flags & IOCB_WAITQ)) {
 			put_and_wait_on_page_locked(page, TASK_KILLABLE);
 			return AOP_TRUNCATED_PAGE;
 		}
+		if (!first)
+			goto error;
+		error = __lock_page_async(page, iocb->ki_waitq);
+		if (error)
+			goto error;
 	}
 
+	error = AOP_TRUNCATED_PAGE;
 	if (!page->mapping)
-		goto truncated;
-	if (filemap_range_uptodate(iocb, mapping, iter, page)) {
-		unlock_page(page);
-		return 0;
-	}
+		goto error_unlock_page;
 
-	if (iocb->ki_flags & (IOCB_NOIO | IOCB_NOWAIT | IOCB_WAITQ)) {
-		unlock_page(page);
+	if (!filemap_range_uptodate(iocb, mapping, iter, page)) {
 		error = -EAGAIN;
-	} else {
+		if (iocb->ki_flags & (IOCB_NOIO | IOCB_NOWAIT | IOCB_WAITQ))
+			goto error_unlock_page;
 		error = filemap_read_page(iocb->ki_filp, mapping, page);
-		if (!error)
-			return 0;
+		if (error)
+			goto error;
+		return 0; /* filemap_read_page unlocks the page */
 	}
+
+	unlock_page(page);
+	return 0;
+
+error_unlock_page:
+	unlock_page(page);
 error:
 	put_page(page);
 	return error;
-truncated:
-	unlock_page(page);
-	put_page(page);
-	return AOP_TRUNCATED_PAGE;
 }
 
 static struct page *filemap_create_page(struct file *file,
