Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0923C9819
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 07:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239173AbhGOFOM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 01:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233239AbhGOFOM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 01:14:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94AEEC06175F;
        Wed, 14 Jul 2021 22:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=d3v7ENPKJDaWtjDqS2P9Smk/DURpXOWjWSUWHrOg3iA=; b=f6ycUXKhFnoFfq7Y74deRLZWHu
        9dBoRIjg2Eq0RYBWV/q+4/Yu+jPmrLfuP4m+PRTmT3CciTrrrAOoqPcX4XCiKwQ2E7iz4Tmt5p9e2
        /EbQ1yEE+5IhEP56vicLCUaAr95IX/LE4lmzDLtbPF3fIGEcdXG0ijdxkV6idcAJBZi2AAUwFsinw
        iFlwopLKh5pRK/a/kF5UDPrQcEdmGYUuzPiRnlrTx6/3kwTM+BFJ2qd0tU18RMezMgxyuqmMHgOVF
        pNKa2FT8fT0RAYLho3M7IgmINGk4E+o+e7CKTe6xtd9mKIGAbGf47BLhXXHUzLsuCxYvJizvHW+/b
        y/Vf9E3w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3td1-0030Aj-Bo; Thu, 15 Jul 2021 05:09:54 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v14 114/138] mm/filemap: Convert filemap_read_page to take a folio
Date:   Thu, 15 Jul 2021 04:36:40 +0100
Message-Id: <20210715033704.692967-115-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210715033704.692967-1-willy@infradead.org>
References: <20210715033704.692967-1-willy@infradead.org>
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
index 5a273d07eae6..5e2a2db1c715 100644
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
+	folio_clear_error(folio);
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
+	if (folio_test_uptodate(folio))
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

