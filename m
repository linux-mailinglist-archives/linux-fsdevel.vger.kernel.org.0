Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96F112A9631
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Nov 2020 13:30:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbgKFMap (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Nov 2020 07:30:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbgKFMao (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Nov 2020 07:30:44 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E8C7C0613CF
        for <linux-fsdevel@vger.kernel.org>; Fri,  6 Nov 2020 04:30:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=FYfTJc/cRnp3dh2kVQ7v0u0iDrX6gANg53dGJ+BqfQ0=; b=QGgesoFqkX35kbIS61E/vS9DMw
        nrOfKvHPvDPlMupVmUbr30VyOixlbjuISXTjvoEvLDo9kHtfc3Ry8ZF2v8CAXlZHnDcWrHnA+PMkt
        ZeuGGhVZaC4/F9vl8iF89cbcXzs1oSYN4N5FUQOdoyIWOPEsyeEtQ19eGzHFQERjW0Y2AgiLoaL13
        uF461OmOzcn6MCRt02ce7mHnbZgW8gHhUaLBMgxHE+9HveyzYwOXl0/OPuVwTtJRZIaC+iOJ/aTEP
        Mgf0UtFim0JjZBJInTLICZK9Yt+FObqAK3ns2T/KM+4C3YykoHjXs66Ggw4gCQbNQyYy0EvkUNz61
        lkHyWdsQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kb0t8-0007Qr-Oh; Fri, 06 Nov 2020 12:30:42 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, hch@lst.de,
        kent.overstreet@gmail.com
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 4/4] mm/filemap: Use a dynamically allocated pagevec in filemap_read
Date:   Fri,  6 Nov 2020 12:30:40 +0000
Message-Id: <20201106123040.28451-4-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201106123040.28451-1-willy@infradead.org>
References: <20201106080815.GC31585@lst.de>
 <20201106123040.28451-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Restore Kent's optimisation for I/O sizes between 64kB and 1MB.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/filemap.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index f41de0759e86..2b4d8ed241bd 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2427,7 +2427,7 @@ ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
 	struct file_ra_state *ra = &filp->f_ra;
 	struct address_space *mapping = filp->f_mapping;
 	struct inode *inode = mapping->host;
-	struct pagevec pvec;
+	struct pagevec pvec_stack, *pvec = NULL;
 	int i, error = 0;
 	bool writably_mapped;
 	loff_t isize, end_offset;
@@ -2436,6 +2436,10 @@ ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
 		return 0;
 	iov_iter_truncate(iter, inode->i_sb->s_maxbytes);
 
+	if (iter->count / PAGE_SIZE > PAGEVEC_SIZE)
+		pvec = pagevec_alloc(iter->count / PAGE_SIZE + 1, GFP_KERNEL);
+	if (!pvec)
+		pvec = &pvec_stack;
 	do {
 		cond_resched();
 
@@ -2447,7 +2451,7 @@ ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
 		if ((iocb->ki_flags & IOCB_WAITQ) && already_read)
 			iocb->ki_flags |= IOCB_NOWAIT;
 
-		error = filemap_get_pages(iocb, iter, &pvec);
+		error = filemap_get_pages(iocb, iter, pvec);
 		if (error < 0)
 			break;
 
@@ -2476,10 +2480,10 @@ ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
 		 */
 		if (iocb->ki_pos >> PAGE_SHIFT !=
 		    ra->prev_pos >> PAGE_SHIFT)
-			mark_page_accessed(pvec.pages[0]);
+			mark_page_accessed(pvec->pages[0]);
 
-		for (i = 0; i < pagevec_count(&pvec); i++) {
-			struct page *page = pvec.pages[i];
+		for (i = 0; i < pagevec_count(pvec); i++) {
+			struct page *page = pvec->pages[i];
 			size_t page_size = thp_size(page);
 			size_t offset = iocb->ki_pos & (page_size - 1);
 			size_t bytes = min_t(loff_t, end_offset - iocb->ki_pos,
@@ -2514,7 +2518,7 @@ ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
 			}
 		}
 put_pages:
-		pagevec_release(&pvec);
+		pagevec_release(pvec);
 	} while (iov_iter_count(iter) && iocb->ki_pos < isize && !error);
 
 	file_accessed(filp);
-- 
2.28.0

