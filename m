Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB4D7CA25
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2019 19:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730584AbfGaRRj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Jul 2019 13:17:39 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44924 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729707AbfGaRRj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Jul 2019 13:17:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=HV9OHEipfxCPgutiQGXqeRhXySlsjKTgVgxjP7nxxBU=; b=P0rJHAe2ztcyEKOVHrZ1l4pFJ3
        mEzC80jwBqdblXcD0Vkz2OWUd2FntcuKByR2b+2SengM4mEEM85AZc/w83DoO+PVSCi53R4FCES0T
        fp5qVSMyZrkkY9IlLeapeoz9/sCFnrvS/Y7pM7IY+t/asRTihuD5iz6GqlTBjaIreECilnj50m7Rb
        9Y/kg8tKY9CvoVRfvtS+En6Ewn+mdphPcaqI/P1zS7BkFNaLcS2mdUWcDsQaGecEsdsuwA1TAHF+a
        +9y5GCC0A+IX3MQQZaoxthYtRihLqyIhIIWOYEyWJBOvjOQpJZcHUMC/CtOFpuV4qRmju87sgaZhg
        n3QDaLew==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hssEN-0005dN-6i; Wed, 31 Jul 2019 17:17:39 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, hch@lst.de,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 2/2] xfs: Support large pages
Date:   Wed, 31 Jul 2019 10:17:34 -0700
Message-Id: <20190731171734.21601-3-willy@infradead.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190731171734.21601-1-willy@infradead.org>
References: <20190731171734.21601-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Mostly this is just checking the page size of each page instead of
assuming PAGE_SIZE.  Clean up the logic in writepage a little.

Based on a patch from Christoph Hellwig.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/xfs/xfs_aops.c | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index f16d5f196c6b..4952cd7d8c6c 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -58,21 +58,22 @@ xfs_find_daxdev_for_inode(
 static void
 xfs_finish_page_writeback(
 	struct inode		*inode,
-	struct bio_vec	*bvec,
+	struct bio_vec		*bvec,
 	int			error)
 {
-	struct iomap_page	*iop = to_iomap_page(bvec->bv_page);
+	struct page		*page = bvec->bv_page;
+	struct iomap_page	*iop = to_iomap_page(page);
 
 	if (error) {
-		SetPageError(bvec->bv_page);
+		SetPageError(page);
 		mapping_set_error(inode->i_mapping, -EIO);
 	}
 
-	ASSERT(iop || i_blocksize(inode) == PAGE_SIZE);
+	ASSERT(iop || i_blocksize(inode) == page_size(page));
 	ASSERT(!iop || atomic_read(&iop->write_count) > 0);
 
 	if (!iop || atomic_dec_and_test(&iop->write_count))
-		end_page_writeback(bvec->bv_page);
+		end_page_writeback(page);
 }
 
 /*
@@ -765,7 +766,7 @@ xfs_add_to_ioend(
 	struct xfs_mount	*mp = ip->i_mount;
 	struct block_device	*bdev = xfs_find_bdev_for_inode(inode);
 	unsigned		len = i_blocksize(inode);
-	unsigned		poff = offset & (PAGE_SIZE - 1);
+	unsigned		poff = offset & (page_size(page) - 1);
 	bool			merged, same_page = false;
 	sector_t		sector;
 
@@ -839,11 +840,11 @@ xfs_aops_discard_page(
 			page, ip->i_ino, offset);
 
 	error = xfs_bmap_punch_delalloc_range(ip, start_fsb,
-			PAGE_SIZE / i_blocksize(inode));
+			page_size(page) / i_blocksize(inode));
 	if (error && !XFS_FORCED_SHUTDOWN(mp))
 		xfs_alert(mp, "page discard unable to remove delalloc mapping.");
 out_invalidate:
-	xfs_vm_invalidatepage(page, 0, PAGE_SIZE);
+	xfs_vm_invalidatepage(page, 0, page_size(page));
 }
 
 /*
@@ -877,7 +878,7 @@ xfs_writepage_map(
 	uint64_t		file_offset;	/* file offset of page */
 	int			error = 0, count = 0, i;
 
-	ASSERT(iop || i_blocksize(inode) == PAGE_SIZE);
+	ASSERT(iop || i_blocksize(inode) == page_size(page));
 	ASSERT(!iop || atomic_read(&iop->write_count) == 0);
 
 	/*
@@ -886,7 +887,8 @@ xfs_writepage_map(
 	 * one.
 	 */
 	for (i = 0, file_offset = page_offset(page);
-	     i < (PAGE_SIZE >> inode->i_blkbits) && file_offset < end_offset;
+	     i < (page_size(page) >> inode->i_blkbits) &&
+						file_offset < end_offset;
 	     i++, file_offset += len) {
 		if (iop && !test_bit(i, iop->uptodate))
 			continue;
@@ -984,8 +986,7 @@ xfs_do_writepage(
 	struct xfs_writepage_ctx *wpc = data;
 	struct inode		*inode = page->mapping->host;
 	loff_t			offset;
-	uint64_t              end_offset;
-	pgoff_t                 end_index;
+	uint64_t		end_offset;
 
 	trace_xfs_writepage(inode, page, 0, 0);
 
@@ -1024,10 +1025,9 @@ xfs_do_writepage(
 	 * ---------------------------------^------------------|
 	 */
 	offset = i_size_read(inode);
-	end_index = offset >> PAGE_SHIFT;
-	if (page->index < end_index)
-		end_offset = (xfs_off_t)(page->index + 1) << PAGE_SHIFT;
-	else {
+	end_offset = (xfs_off_t)(page->index + compound_nr(page)) << PAGE_SHIFT;
+
+	if (end_offset > offset) {
 		/*
 		 * Check whether the page to write out is beyond or straddles
 		 * i_size or not.
@@ -1039,7 +1039,8 @@ xfs_do_writepage(
 		 * |				    |      Straddles     |
 		 * ---------------------------------^-----------|--------|
 		 */
-		unsigned offset_into_page = offset & (PAGE_SIZE - 1);
+		unsigned offset_into_page = offset & (page_size(page) - 1);
+		pgoff_t end_index = offset >> PAGE_SHIFT;
 
 		/*
 		 * Skip the page if it is fully outside i_size, e.g. due to a
@@ -1070,7 +1071,7 @@ xfs_do_writepage(
 		 * memory is zeroed when mapped, and writes to that region are
 		 * not written out to the file."
 		 */
-		zero_user_segment(page, offset_into_page, PAGE_SIZE);
+		zero_user_segment(page, offset_into_page, page_size(page));
 
 		/* Adjust the end_offset to the end of file */
 		end_offset = offset;
-- 
2.20.1

