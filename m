Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7147D1E730B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 May 2020 05:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407492AbgE2C6q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 22:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391623AbgE2C6e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 22:58:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A09C014D07;
        Thu, 28 May 2020 19:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=ZJvaEr5U2kZRZcf2t8EEk8IqgSIXKuiXLgLZOLB5+d0=; b=UpCNN+v5D9G6Ud8+KqU4T/GKDu
        /JiZLT8JEzBWfRiHlt3mpWNLXkaxa0fnykvbFrFyl6VkDY1vsnmxQKTxwtLzcj088LkpjrAxlZZ0M
        HLaxV1C7ZX4971CCGf6sHbzX5AbrNSBRNECNoI0PZ/zhFKPO2ejvrKtHsfFA+0vOqAd5JuxKCOj6H
        zbRQQbtb/BRv9y2r+OVyzVUUcXxYvGwGiSnqiTAQ4n7hwJC95MNxjVAzgtIEacuIUfDbhx45IQL/X
        xC8a1H/LHw4ei7CtXS2+dqGmeJnjK+JdOPxxsmQS4Vkpmh5bOpQxeMuHQQbRgSW9zFLbiIP6xhLJ9
        RWpoiUYw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jeVE2-0008QU-Tf; Fri, 29 May 2020 02:58:26 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v5 09/39] fs: Introduce i_blocks_per_page
Date:   Thu, 28 May 2020 19:57:54 -0700
Message-Id: <20200529025824.32296-10-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200529025824.32296-1-willy@infradead.org>
References: <20200529025824.32296-1-willy@infradead.org>
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
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/buffered-io.c  |  8 ++++----
 fs/jfs/jfs_metapage.c   |  2 +-
 fs/xfs/xfs_aops.c       |  2 +-
 include/linux/pagemap.h | 16 ++++++++++++++++
 4 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 890c8fcda4f3..4bc37bf8d057 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -46,7 +46,7 @@ iomap_page_create(struct inode *inode, struct page *page)
 {
 	struct iomap_page *iop = to_iomap_page(page);
 
-	if (iop || i_blocksize(inode) == PAGE_SIZE)
+	if (iop || i_blocks_per_page(inode, page) <= 1)
 		return iop;
 
 	iop = kmalloc(sizeof(*iop), GFP_NOFS | __GFP_NOFAIL);
@@ -152,7 +152,7 @@ iomap_iop_set_range_uptodate(struct page *page, unsigned off, unsigned len)
 	unsigned int i;
 
 	spin_lock_irqsave(&iop->uptodate_lock, flags);
-	for (i = 0; i < PAGE_SIZE / i_blocksize(inode); i++) {
+	for (i = 0; i < i_blocks_per_page(inode, page); i++) {
 		if (i >= first && i <= last)
 			set_bit(i, iop->uptodate);
 		else if (!test_bit(i, iop->uptodate))
@@ -1090,7 +1090,7 @@ iomap_finish_page_writeback(struct inode *inode, struct page *page,
 		mapping_set_error(inode->i_mapping, -EIO);
 	}
 
-	WARN_ON_ONCE(i_blocksize(inode) < PAGE_SIZE && !iop);
+	WARN_ON_ONCE(i_blocks_per_page(inode, page) > 1 && !iop);
 	WARN_ON_ONCE(iop && atomic_read(&iop->write_count) <= 0);
 
 	if (!iop || atomic_dec_and_test(&iop->write_count))
@@ -1386,7 +1386,7 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 	int error = 0, count = 0, i;
 	LIST_HEAD(submit_list);
 
-	WARN_ON_ONCE(i_blocksize(inode) < PAGE_SIZE && !iop);
+	WARN_ON_ONCE(i_blocks_per_page(inode, page) > 1 && !iop);
 	WARN_ON_ONCE(iop && atomic_read(&iop->write_count) != 0);
 
 	/*
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
index 1fd4fb7a607c..5b25f5ee84dc 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -544,7 +544,7 @@ xfs_discard_page(
 			page, ip->i_ino, offset);
 
 	error = xfs_bmap_punch_delalloc_range(ip, start_fsb,
-			PAGE_SIZE / i_blocksize(inode));
+			i_blocks_per_page(inode, page));
 	if (error && !XFS_FORCED_SHUTDOWN(mp))
 		xfs_alert(mp, "page discard unable to remove delalloc mapping.");
 out_invalidate:
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index e40527e53620..53a914105591 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -851,4 +851,20 @@ static inline int page_mkwrite_check_truncate(struct page *page,
 	return offset;
 }
 
+/**
+ * i_blocks_per_page - How many blocks fit in this page.
+ * @inode: The inode which contains the blocks.
+ * @page: The (potentially large) page.
+ *
+ * If the block size is larger than the size of this page, will return
+ * zero,
+ *
+ * Context: Any context.
+ * Return: The number of filesystem blocks covered by this page.
+ */
+static inline
+unsigned int i_blocks_per_page(struct inode *inode, struct page *page)
+{
+	return thp_size(page) >> inode->i_blkbits;
+}
 #endif /* _LINUX_PAGEMAP_H */
-- 
2.26.2

