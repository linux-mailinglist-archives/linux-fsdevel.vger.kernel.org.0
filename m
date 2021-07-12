Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6B813C429E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 06:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbhGLEKJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jul 2021 00:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbhGLEKI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jul 2021 00:10:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F75C0613DD;
        Sun, 11 Jul 2021 21:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=8BqAUMfOa1WVvmE0VelStcNU5hdnII1y41I1KPo9ZbQ=; b=Fl0MLNaymG09dkvgn0X2g4N+MM
        sIXOFNsdl06b3571BPdJKQ97kGq+W7Yq5XCHJtMueT9ymmErvEVQ1gl8CBkC3AoCkJN6a5+cN7zWY
        +SNZ/ZAByD0if5PCUdtFZD/ro1HS5D1b9glsv1lJXjgO+LvUOTRKzEyXNb+3JMUpstdoHXWvITrQg
        elNAgbOeEBMB3Ng/CqDZzym3+KWTc/TTvKy5NiqL5IsvA9An6xdY8dd69695c5sFE6/V/d0k/Gz2N
        OMglFkPuSJjVYruTAOGKo9F35SI+3tNbjKiVV94jHbC5TuvNpi1X7qFmPfbTK5RvpVtoNm289kT1b
        v/+BQvQw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m2nCy-00GqxN-0z; Mon, 12 Jul 2021 04:06:25 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v13 113/137] mm/filemap: Convert filemap_read_page to take a folio
Date:   Mon, 12 Jul 2021 04:06:37 +0100
Message-Id: <20210712030701.4000097-114-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210712030701.4000097-1-willy@infradead.org>
References: <20210712030701.4000097-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

One of the callers already had a folio; the other two grow by a few
bytes, but filemap_read_page() shrinks by 50 bytes for a net reduction
of 27 bytes.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/filemap.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index e9674aabfff9..827e8872d2bd 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2302,8 +2302,8 @@ static void filemap_get_read_batch(struct address_space *mapping,
 	rcu_read_unlock();
 }
 
-static int filemap_read_page(struct file *file, struct address_space *mapping,
-		struct page *page)
+static int filemap_read_folio(struct file *file, struct address_space *mapping,
+		struct folio *folio)
 {
 	int error;
 
@@ -2312,16 +2312,16 @@ static int filemap_read_page(struct file *file, struct address_space *mapping,
 	 * eg. multipath errors.  PG_error will be set again if readpage
 	 * fails.
 	 */
-	ClearPageError(page);
+	folio_clear_error_flag(folio);
 	/* Start the actual read. The read will unlock the page. */
-	error = mapping->a_ops->readpage(file, page);
+	error = mapping->a_ops->readpage(file, &folio->page);
 	if (error)
 		return error;
 
-	error = wait_on_page_locked_killable(page);
+	error = folio_wait_locked_killable(folio);
 	if (error)
 		return error;
-	if (PageUptodate(page))
+	if (folio_uptodate(folio))
 		return 0;
 	shrink_readahead_size_eio(&file->f_ra);
 	return -EIO;
@@ -2383,7 +2383,7 @@ static int filemap_update_page(struct kiocb *iocb,
 	if (iocb->ki_flags & (IOCB_NOIO | IOCB_NOWAIT | IOCB_WAITQ))
 		goto unlock;
 
-	error = filemap_read_page(iocb->ki_filp, mapping, &folio->page);
+	error = filemap_read_folio(iocb->ki_filp, mapping, folio);
 	if (error == AOP_TRUNCATED_PAGE)
 		folio_put(folio);
 	return error;
@@ -2414,7 +2414,7 @@ static int filemap_create_page(struct file *file,
 	if (error)
 		goto error;
 
-	error = filemap_read_page(file, mapping, page);
+	error = filemap_read_folio(file, mapping, page_folio(page));
 	if (error)
 		goto error;
 
@@ -3043,7 +3043,7 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 	 * and we need to check for errors.
 	 */
 	fpin = maybe_unlock_mmap_for_io(vmf, fpin);
-	error = filemap_read_page(file, mapping, page);
+	error = filemap_read_folio(file, mapping, page_folio(page));
 	if (fpin)
 		goto out_retry;
 	put_page(page);
-- 
2.30.2

