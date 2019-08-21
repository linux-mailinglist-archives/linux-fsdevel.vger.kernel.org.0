Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53D2596E5B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2019 02:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbfHUAan (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Aug 2019 20:30:43 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56728 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfHUAam (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Aug 2019 20:30:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=TpSePgz02GkghZM1yEUYwUuZuyuUMUK08NAW5vfqrco=; b=Qeclk0a+RGaahcVQFrt2ipxglv
        ZpcmRN/jKfYeHqp66tjTyxed9nEyeVUF18o17kfrbJCFGfvUNipRUvwahdEkYkA/3QFqFTeowN/1A
        yAgQtuq9Dg/lJ9Qfh5Au7a8W01TjbdGw8c8JkxUFGviWm5RD8Hd9sPiD3sqGn5PSMMtG5a/rjih4a
        /dHUzHlRO6XaoUWEAYkfFGevg1xrBh8T9M81gUexspMuAgv5jztT2ok1e35m08RS+UWZX5p1iT7LK
        1j2XVL7ytbvfhdvEAF5OZu+NAzUuCFD/Hwl+IqBMm1QGMhLHYr/MD9yu2z7ulr5Iv2/MII320+c/p
        4T9dNvng==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i0EWQ-0003HR-81; Wed, 21 Aug 2019 00:30:42 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, hch@lst.de,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v2 1/5] fs: Introduce i_blocks_per_page
Date:   Tue, 20 Aug 2019 17:30:35 -0700
Message-Id: <20190821003039.12555-2-willy@infradead.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190821003039.12555-1-willy@infradead.org>
References: <20190821003039.12555-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

This helper is useful for both large pages in the page cache and for
supporting block size larger than page size.  Convert some example
users (we have a few different ways of writing this idiom).

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/iomap/buffered-io.c  |  4 ++--
 fs/jfs/jfs_metapage.c   |  2 +-
 fs/xfs/xfs_aops.c       |  8 ++++----
 include/linux/pagemap.h | 13 +++++++++++++
 4 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index e25901ae3ff4..0e76a4b6d98a 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -24,7 +24,7 @@ iomap_page_create(struct inode *inode, struct page *page)
 {
 	struct iomap_page *iop = to_iomap_page(page);
 
-	if (iop || i_blocksize(inode) == PAGE_SIZE)
+	if (iop || i_blocks_per_page(inode, page) <= 1)
 		return iop;
 
 	iop = kmalloc(sizeof(*iop), GFP_NOFS | __GFP_NOFAIL);
@@ -128,7 +128,7 @@ iomap_set_range_uptodate(struct page *page, unsigned off, unsigned len)
 	bool uptodate = true;
 
 	if (iop) {
-		for (i = 0; i < PAGE_SIZE / i_blocksize(inode); i++) {
+		for (i = 0; i < i_blocks_per_page(inode, page); i++) {
 			if (i >= first && i <= last)
 				set_bit(i, iop->uptodate);
 			else if (!test_bit(i, iop->uptodate))
diff --git a/fs/jfs/jfs_metapage.c b/fs/jfs/jfs_metapage.c
index a2f5338a5ea1..176580f54af9 100644
--- a/fs/jfs/jfs_metapage.c
+++ b/fs/jfs/jfs_metapage.c
@@ -473,7 +473,7 @@ static int metapage_readpage(struct file *fp, struct page *page)
 	struct inode *inode = page->mapping->host;
 	struct bio *bio = NULL;
 	int block_offset;
-	int blocks_per_page = PAGE_SIZE >> inode->i_blkbits;
+	int blocks_per_page = i_blocks_per_page(inode, page);
 	sector_t page_start;	/* address of page in fs blocks */
 	sector_t pblock;
 	int xlen;
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index f16d5f196c6b..102cfd8a97d6 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -68,7 +68,7 @@ xfs_finish_page_writeback(
 		mapping_set_error(inode->i_mapping, -EIO);
 	}
 
-	ASSERT(iop || i_blocksize(inode) == PAGE_SIZE);
+	ASSERT(iop || i_blocks_per_page(inode, bvec->bv_page) <= 1);
 	ASSERT(!iop || atomic_read(&iop->write_count) > 0);
 
 	if (!iop || atomic_dec_and_test(&iop->write_count))
@@ -839,7 +839,7 @@ xfs_aops_discard_page(
 			page, ip->i_ino, offset);
 
 	error = xfs_bmap_punch_delalloc_range(ip, start_fsb,
-			PAGE_SIZE / i_blocksize(inode));
+			i_blocks_per_page(inode, page));
 	if (error && !XFS_FORCED_SHUTDOWN(mp))
 		xfs_alert(mp, "page discard unable to remove delalloc mapping.");
 out_invalidate:
@@ -877,7 +877,7 @@ xfs_writepage_map(
 	uint64_t		file_offset;	/* file offset of page */
 	int			error = 0, count = 0, i;
 
-	ASSERT(iop || i_blocksize(inode) == PAGE_SIZE);
+	ASSERT(iop || i_blocks_per_page(inode, page) <= 1);
 	ASSERT(!iop || atomic_read(&iop->write_count) == 0);
 
 	/*
@@ -886,7 +886,7 @@ xfs_writepage_map(
 	 * one.
 	 */
 	for (i = 0, file_offset = page_offset(page);
-	     i < (PAGE_SIZE >> inode->i_blkbits) && file_offset < end_offset;
+	     i < i_blocks_per_page(inode, page) && file_offset < end_offset;
 	     i++, file_offset += len) {
 		if (iop && !test_bit(i, iop->uptodate))
 			continue;
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index cf837d313b96..2728f20fbc49 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -644,4 +644,17 @@ static inline unsigned long dir_pages(struct inode *inode)
 			       PAGE_SHIFT;
 }
 
+/**
+ * i_blocks_per_page - How many blocks fit in this page.
+ * @inode: The inode which contains the blocks.
+ * @page: The (potentially large) page.
+ *
+ * Context: Any context.
+ * Return: The number of filesystem blocks covered by this page.
+ */
+static inline
+unsigned int i_blocks_per_page(struct inode *inode, struct page *page)
+{
+	return page_size(page) >> inode->i_blkbits;
+}
 #endif /* _LINUX_PAGEMAP_H */
-- 
2.23.0.rc1

