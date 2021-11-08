Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC36D4479B0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Nov 2021 06:06:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbhKHFIu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Nov 2021 00:08:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbhKHFIt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Nov 2021 00:08:49 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7208C061570;
        Sun,  7 Nov 2021 21:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=ikXVfb3U7753RVO9peExC5rw1TDOslVL28+m2Sxvq0U=; b=SXKuFm0Xf05uGZuTi/Efy41wbA
        2XGeUfX3gdJGqjg03noxDJ1jTsx/oSEeMswJ2Ne7yQisOKse62Kovgsdad6V48rbA5R6kh6izi4kk
        8RGZjU7R+HXctSKhKl5S18HrHZVC03dJb51vfun8NzbpJBwTt3/9G66L8uD+K2GgB6twSMJx1NC+N
        LXhF3MWUYNhKRDy49FDGFTyCUm/vdDlKMf7i1B5ulHQIZT8GQFE6etZd1b/9bbX+p0tGShA6pSovZ
        cF4FAafZ1Eb8rwbDCcCG9jl771R+el5zW1D2xx3eD3ZVM+TR/ekrHWzMszWa3tT4zVnx5tFtEQz54
        /Cv1Vc2A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mjwnm-008AoK-34; Mon, 08 Nov 2021 05:02:57 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     "Darrick J . Wong " <djwong@kernel.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 24/28] iomap: Simplify iomap_do_writepage()
Date:   Mon,  8 Nov 2021 04:05:47 +0000
Message-Id: <20211108040551.1942823-25-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211108040551.1942823-1-willy@infradead.org>
References: <20211108040551.1942823-1-willy@infradead.org>
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
index 87190b86ef1f..b168cc0fe8be 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1394,9 +1394,7 @@ iomap_do_writepage(struct page *page, struct writeback_control *wbc, void *data)
 {
 	struct iomap_writepage_ctx *wpc = data;
 	struct inode *inode = page->mapping->host;
-	pgoff_t end_index;
-	u64 end_offset;
-	loff_t offset;
+	u64 end_pos, isize;
 
 	trace_iomap_writepage(inode, page_offset(page), PAGE_SIZE);
 
@@ -1427,11 +1425,9 @@ iomap_do_writepage(struct page *page, struct writeback_control *wbc, void *data)
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
@@ -1443,7 +1439,8 @@ iomap_do_writepage(struct page *page, struct writeback_control *wbc, void *data)
 		 * |				    |      Straddles     |
 		 * ---------------------------------^-----------|--------|
 		 */
-		unsigned offset_into_page = offset & (PAGE_SIZE - 1);
+		size_t poff = offset_in_page(isize);
+		pgoff_t end_index = isize >> PAGE_SHIFT;
 
 		/*
 		 * Skip the page if it's fully outside i_size, e.g. due to a
@@ -1463,7 +1460,7 @@ iomap_do_writepage(struct page *page, struct writeback_control *wbc, void *data)
 		 * offset is just equal to the EOF.
 		 */
 		if (page->index > end_index ||
-		    (page->index == end_index && offset_into_page == 0))
+		    (page->index == end_index && poff == 0))
 			goto redirty;
 
 		/*
@@ -1474,13 +1471,13 @@ iomap_do_writepage(struct page *page, struct writeback_control *wbc, void *data)
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

