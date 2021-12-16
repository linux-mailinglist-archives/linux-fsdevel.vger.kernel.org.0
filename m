Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED419477E3A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Dec 2021 22:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241708AbhLPVHn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Dec 2021 16:07:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241583AbhLPVHX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Dec 2021 16:07:23 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26BE3C06173F;
        Thu, 16 Dec 2021 13:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=tJpVpLh0vQUdHYCCDcCNSHG1cwy4vcBawwdcR1SJtWA=; b=p01MmXADRCGABY4peI+g8VfOqZ
        IzBiEz1SI6xIiJcRKZ1sMSJ09WHjTGPUNt9OfPcWQ1aV+rUK7M9DPPqZefX4/ndK7J4doIh7Llpdb
        RuqV4dDb2At8G18OBwtpRLAfV4A7AzXlteOEYio7mtTuXCz73SX3+/4owwcih7nIsGPpThB9Wnadl
        vibbFLdc7zaZRyDD8fufWw02xK75M03OCakegaD0xPHxPQyLTdalvFTgFPWZk9xsDqmzeUr5M4MPG
        L2yrjBcyJYpZzG1GBioMKgSVv4ZhTv9yU+guIOLxQJgy/68NM88oNPx1AG2BNuOKESTi129bhwR6z
        XtyKZP+Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mxxyD-00Fx5B-EZ; Thu, 16 Dec 2021 21:07:21 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: [PATCH v3 21/25] iomap: Simplify iomap_do_writepage()
Date:   Thu, 16 Dec 2021 21:07:11 +0000
Message-Id: <20211216210715.3801857-22-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211216210715.3801857-1-willy@infradead.org>
References: <20211216210715.3801857-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Rename end_offset to end_pos and offset_into_page to poff to match the
rest of the file.  Simplify the handling of the last page straddling
i_size by doing the EOF check based on the byte granularity i_size
instead of converting to a pgoff prematurely.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/iomap/buffered-io.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 20e7087aa75c..8bfdda8e5f1c 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1408,9 +1408,7 @@ iomap_do_writepage(struct page *page, struct writeback_control *wbc, void *data)
 {
 	struct iomap_writepage_ctx *wpc = data;
 	struct inode *inode = page->mapping->host;
-	pgoff_t end_index;
-	u64 end_offset;
-	loff_t offset;
+	u64 end_pos, isize;
 
 	trace_iomap_writepage(inode, page_offset(page), PAGE_SIZE);
 
@@ -1441,11 +1439,9 @@ iomap_do_writepage(struct page *page, struct writeback_control *wbc, void *data)
 	 * |     desired writeback range    |      see else    |
 	 * ---------------------------------^------------------|
 	 */
-	offset = i_size_read(inode);
-	end_index = offset >> PAGE_SHIFT;
-	if (page->index < end_index)
-		end_offset = (loff_t)(page->index + 1) << PAGE_SHIFT;
-	else {
+	isize = i_size_read(inode);
+	end_pos = page_offset(page) + PAGE_SIZE;
+	if (end_pos > isize) {
 		/*
 		 * Check whether the page to write out is beyond or straddles
 		 * i_size or not.
@@ -1457,7 +1453,8 @@ iomap_do_writepage(struct page *page, struct writeback_control *wbc, void *data)
 		 * |				    |      Straddles     |
 		 * ---------------------------------^-----------|--------|
 		 */
-		unsigned offset_into_page = offset & (PAGE_SIZE - 1);
+		size_t poff = offset_in_page(isize);
+		pgoff_t end_index = isize >> PAGE_SHIFT;
 
 		/*
 		 * Skip the page if it's fully outside i_size, e.g. due to a
@@ -1477,7 +1474,7 @@ iomap_do_writepage(struct page *page, struct writeback_control *wbc, void *data)
 		 * offset is just equal to the EOF.
 		 */
 		if (page->index > end_index ||
-		    (page->index == end_index && offset_into_page == 0))
+		    (page->index == end_index && poff == 0))
 			goto redirty;
 
 		/*
@@ -1488,13 +1485,13 @@ iomap_do_writepage(struct page *page, struct writeback_control *wbc, void *data)
 		 * memory is zeroed when mapped, and writes to that region are
 		 * not written out to the file."
 		 */
-		zero_user_segment(page, offset_into_page, PAGE_SIZE);
+		zero_user_segment(page, poff, PAGE_SIZE);
 
 		/* Adjust the end_offset to the end of file */
-		end_offset = offset;
+		end_pos = isize;
 	}
 
-	return iomap_writepage_map(wpc, wbc, inode, page, end_offset);
+	return iomap_writepage_map(wpc, wbc, inode, page, end_pos);
 
 redirty:
 	redirty_page_for_writepage(wbc, page);
-- 
2.33.0

