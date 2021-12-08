Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1A546CC5F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Dec 2021 05:23:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240063AbhLHE11 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Dec 2021 23:27:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240074AbhLHE0s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Dec 2021 23:26:48 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A24C061D5F
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Dec 2021 20:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Ffq/cQVPcFt5LoElUBw8aA2bmdFv10SCY9OdwQ5yJQA=; b=ZoCCrfBFGomvt8SJ8oYXyTew2p
        pDTXUDYEZDZQGTw0CSnLSGvksOSX4S9AYEAh/nNrd7DnRZ+FLb0kWO1KxyChPrtabjtzCd9ZCAcbR
        wNG90x7cVYy000WVHvgV1SdORhzBmPT3bpVy/BnPRuYJCkqnE3cuOdb98lpKcOQANraMI34RVVoH6
        o4y5qvFFLPRKi8n3PwaI0XkqqW4zsLOv4NXx/lAvkeeIUkwx1duj/83q+e/bRFLMwSeVkD9PRLZ+8
        iO4yBbRfol1nHLB037r7RlXrN1ddM0xm8/IEy3Jq/MpY6ta65Q88Nsnne18F4SseSNEdyZPf4kpmV
        ZD3gyquQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1muoU3-0084YC-KU; Wed, 08 Dec 2021 04:23:11 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 18/48] filemap: Convert filemap_read_page to take a folio
Date:   Wed,  8 Dec 2021 04:22:26 +0000
Message-Id: <20211208042256.1923824-19-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211208042256.1923824-1-willy@infradead.org>
References: <20211208042256.1923824-1-willy@infradead.org>
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
index 33e638f1ca34..581f9fdb3406 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2369,8 +2369,8 @@ static void filemap_get_read_batch(struct address_space *mapping,
 	rcu_read_unlock();
 }
 
-static int filemap_read_page(struct file *file, struct address_space *mapping,
-		struct page *page)
+static int filemap_read_folio(struct file *file, struct address_space *mapping,
+		struct folio *folio)
 {
 	int error;
 
@@ -2379,16 +2379,16 @@ static int filemap_read_page(struct file *file, struct address_space *mapping,
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
@@ -2464,7 +2464,7 @@ static int filemap_update_page(struct kiocb *iocb,
 	if (iocb->ki_flags & (IOCB_NOIO | IOCB_NOWAIT | IOCB_WAITQ))
 		goto unlock;
 
-	error = filemap_read_page(iocb->ki_filp, mapping, &folio->page);
+	error = filemap_read_folio(iocb->ki_filp, mapping, folio);
 	goto unlock_mapping;
 unlock:
 	folio_unlock(folio);
@@ -2506,7 +2506,7 @@ static int filemap_create_page(struct file *file,
 	if (error)
 		goto error;
 
-	error = filemap_read_page(file, mapping, page);
+	error = filemap_read_folio(file, mapping, page_folio(page));
 	if (error)
 		goto error;
 
@@ -3168,7 +3168,7 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 	 * and we need to check for errors.
 	 */
 	fpin = maybe_unlock_mmap_for_io(vmf, fpin);
-	error = filemap_read_page(file, mapping, page);
+	error = filemap_read_folio(file, mapping, page_folio(page));
 	if (fpin)
 		goto out_retry;
 	put_page(page);
-- 
2.33.0

