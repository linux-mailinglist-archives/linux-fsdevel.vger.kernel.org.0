Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A81B5151F6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Apr 2022 19:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379548AbiD2RaP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Apr 2022 13:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379570AbiD2R3b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Apr 2022 13:29:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0EF0A2067
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Apr 2022 10:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=CQhlAxAHQzk+AEjI6LKArIMIixM35AqfoLm5FxZqqHk=; b=JeHab9DKa1eBDLQLfygP4EG0Op
        hMYpe/7DrW7aq0V5gxpjFVtu5+Jr3GjSMWGAgD4XwDYS1xPZDTeGpVb2XJ31Ymp6WlKLaXXg3S/PQ
        EA34nyNhqnPpnyb/fQDy1BIUD6bTFdZdruON+zRc+vhdpluoBp+AP5QJU0hiotKCH1LMkeYILWY16
        jr4qGiPBMgXslphqN2DlwSZTEEDwQ58CmUjF66o6qHe8pVADx+Ki31dCY+TVIESTgk/4vprjk+kbp
        B/yMxmdgTrHlL0MSrk6FxdyRE+t7wRq1iCHLk3yTRF4mbMDigbBXw59nM8EPzY8JZAjn4LQeUsf0T
        rlO9C3EQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nkUNa-00CdaM-Q8; Fri, 29 Apr 2022 17:26:06 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 38/69] fs: Convert mpage_readpage to mpage_read_folio
Date:   Fri, 29 Apr 2022 18:25:25 +0100
Message-Id: <20220429172556.3011843-39-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220429172556.3011843-1-willy@infradead.org>
References: <20220429172556.3011843-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

mpage_readpage still works in terms of pages, and has not been audited
for correctness with large folios, so include an assertion that the
filesystem is not passing it large folios.  Convert all the filesystems
to call mpage_read_folio() instead of mpage_readpage().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/exfat/inode.c       |  6 +++---
 fs/ext2/inode.c        |  8 ++++----
 fs/fat/inode.c         |  6 +++---
 fs/gfs2/aops.c         | 15 +++++++--------
 fs/hpfs/file.c         |  6 +++---
 fs/iomap/buffered-io.c |  2 +-
 fs/isofs/inode.c       |  6 +++---
 fs/jfs/inode.c         |  6 +++---
 fs/mpage.c             |  8 +++++---
 fs/nilfs2/inode.c      | 10 +++++-----
 fs/ntfs3/inode.c       |  9 +++++----
 fs/qnx6/inode.c        |  6 +++---
 fs/udf/inode.c         |  6 +++---
 include/linux/mpage.h  |  2 +-
 14 files changed, 49 insertions(+), 47 deletions(-)

diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c
index b9f63113db2d..0133d385d8e8 100644
--- a/fs/exfat/inode.c
+++ b/fs/exfat/inode.c
@@ -357,9 +357,9 @@ static int exfat_get_block(struct inode *inode, sector_t iblock,
 	return err;
 }
 
-static int exfat_readpage(struct file *file, struct page *page)
+static int exfat_read_folio(struct file *file, struct folio *folio)
 {
-	return mpage_readpage(page, exfat_get_block);
+	return mpage_read_folio(folio, exfat_get_block);
 }
 
 static void exfat_readahead(struct readahead_control *rac)
@@ -492,7 +492,7 @@ int exfat_block_truncate_page(struct inode *inode, loff_t from)
 static const struct address_space_operations exfat_aops = {
 	.dirty_folio	= block_dirty_folio,
 	.invalidate_folio = block_invalidate_folio,
-	.readpage	= exfat_readpage,
+	.read_folio	= exfat_read_folio,
 	.readahead	= exfat_readahead,
 	.writepage	= exfat_writepage,
 	.writepages	= exfat_writepages,
diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
index d8ca8050945a..9e1ecd89f47f 100644
--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -875,9 +875,9 @@ static int ext2_writepage(struct page *page, struct writeback_control *wbc)
 	return block_write_full_page(page, ext2_get_block, wbc);
 }
 
-static int ext2_readpage(struct file *file, struct page *page)
+static int ext2_read_folio(struct file *file, struct folio *folio)
 {
-	return mpage_readpage(page, ext2_get_block);
+	return mpage_read_folio(folio, ext2_get_block);
 }
 
 static void ext2_readahead(struct readahead_control *rac)
@@ -966,7 +966,7 @@ ext2_dax_writepages(struct address_space *mapping, struct writeback_control *wbc
 const struct address_space_operations ext2_aops = {
 	.dirty_folio		= block_dirty_folio,
 	.invalidate_folio	= block_invalidate_folio,
-	.readpage		= ext2_readpage,
+	.read_folio		= ext2_read_folio,
 	.readahead		= ext2_readahead,
 	.writepage		= ext2_writepage,
 	.write_begin		= ext2_write_begin,
@@ -982,7 +982,7 @@ const struct address_space_operations ext2_aops = {
 const struct address_space_operations ext2_nobh_aops = {
 	.dirty_folio		= block_dirty_folio,
 	.invalidate_folio	= block_invalidate_folio,
-	.readpage		= ext2_readpage,
+	.read_folio		= ext2_read_folio,
 	.readahead		= ext2_readahead,
 	.writepage		= ext2_nobh_writepage,
 	.write_begin		= ext2_nobh_write_begin,
diff --git a/fs/fat/inode.c b/fs/fat/inode.c
index 1f15b0fd1bb0..8a81017f8d60 100644
--- a/fs/fat/inode.c
+++ b/fs/fat/inode.c
@@ -205,9 +205,9 @@ static int fat_writepages(struct address_space *mapping,
 	return mpage_writepages(mapping, wbc, fat_get_block);
 }
 
-static int fat_readpage(struct file *file, struct page *page)
+static int fat_read_folio(struct file *file, struct folio *folio)
 {
-	return mpage_readpage(page, fat_get_block);
+	return mpage_read_folio(folio, fat_get_block);
 }
 
 static void fat_readahead(struct readahead_control *rac)
@@ -344,7 +344,7 @@ int fat_block_truncate_page(struct inode *inode, loff_t from)
 static const struct address_space_operations fat_aops = {
 	.dirty_folio	= block_dirty_folio,
 	.invalidate_folio = block_invalidate_folio,
-	.readpage	= fat_readpage,
+	.read_folio	= fat_read_folio,
 	.readahead	= fat_readahead,
 	.writepage	= fat_writepage,
 	.writepages	= fat_writepages,
diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
index a29eb1e5bfe2..340bf5d0e835 100644
--- a/fs/gfs2/aops.c
+++ b/fs/gfs2/aops.c
@@ -480,7 +480,7 @@ static int __gfs2_readpage(void *file, struct page *page)
 		error = stuffed_readpage(ip, page);
 		unlock_page(page);
 	} else {
-		error = mpage_readpage(page, gfs2_block_map);
+		error = mpage_read_folio(folio, gfs2_block_map);
 	}
 
 	if (unlikely(gfs2_withdrawn(sdp)))
@@ -490,14 +490,13 @@ static int __gfs2_readpage(void *file, struct page *page)
 }
 
 /**
- * gfs2_readpage - read a page of a file
+ * gfs2_read_folio - read a folio from a file
  * @file: The file to read
- * @page: The page of the file
+ * @folio: The folio in the file
  */
-
-static int gfs2_readpage(struct file *file, struct page *page)
+static int gfs2_read_folio(struct file *file, struct folio *folio)
 {
-	return __gfs2_readpage(file, page);
+	return __gfs2_readpage(file, &folio->page);
 }
 
 /**
@@ -773,7 +772,7 @@ int gfs2_releasepage(struct page *page, gfp_t gfp_mask)
 static const struct address_space_operations gfs2_aops = {
 	.writepage = gfs2_writepage,
 	.writepages = gfs2_writepages,
-	.readpage = gfs2_readpage,
+	.read_folio = gfs2_read_folio,
 	.readahead = gfs2_readahead,
 	.dirty_folio = filemap_dirty_folio,
 	.releasepage = iomap_releasepage,
@@ -788,7 +787,7 @@ static const struct address_space_operations gfs2_aops = {
 static const struct address_space_operations gfs2_jdata_aops = {
 	.writepage = gfs2_jdata_writepage,
 	.writepages = gfs2_jdata_writepages,
-	.readpage = gfs2_readpage,
+	.read_folio = gfs2_read_folio,
 	.readahead = gfs2_readahead,
 	.dirty_folio = jdata_dirty_folio,
 	.bmap = gfs2_bmap,
diff --git a/fs/hpfs/file.c b/fs/hpfs/file.c
index 8b590b3826c3..f7547a62c81f 100644
--- a/fs/hpfs/file.c
+++ b/fs/hpfs/file.c
@@ -158,9 +158,9 @@ static const struct iomap_ops hpfs_iomap_ops = {
 	.iomap_begin		= hpfs_iomap_begin,
 };
 
-static int hpfs_readpage(struct file *file, struct page *page)
+static int hpfs_read_folio(struct file *file, struct folio *folio)
 {
-	return mpage_readpage(page, hpfs_get_block);
+	return mpage_read_folio(folio, hpfs_get_block);
 }
 
 static int hpfs_writepage(struct page *page, struct writeback_control *wbc)
@@ -247,7 +247,7 @@ static int hpfs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 const struct address_space_operations hpfs_aops = {
 	.dirty_folio	= block_dirty_folio,
 	.invalidate_folio = block_invalidate_folio,
-	.readpage = hpfs_readpage,
+	.read_folio = hpfs_read_folio,
 	.writepage = hpfs_writepage,
 	.readahead = hpfs_readahead,
 	.writepages = hpfs_writepages,
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 75eb0c27a0e8..2de087ac87b6 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -297,7 +297,7 @@ static loff_t iomap_readpage_iter(const struct iomap_iter *iter,
 		/*
 		 * If the bio_alloc fails, try it again for a single page to
 		 * avoid having to deal with partial page reads.  This emulates
-		 * what do_mpage_readpage does.
+		 * what do_mpage_read_folio does.
 		 */
 		if (!ctx->bio) {
 			ctx->bio = bio_alloc(iomap->bdev, 1, REQ_OP_READ,
diff --git a/fs/isofs/inode.c b/fs/isofs/inode.c
index d7491692aea3..88bf20303466 100644
--- a/fs/isofs/inode.c
+++ b/fs/isofs/inode.c
@@ -1174,9 +1174,9 @@ struct buffer_head *isofs_bread(struct inode *inode, sector_t block)
 	return sb_bread(inode->i_sb, blknr);
 }
 
-static int isofs_readpage(struct file *file, struct page *page)
+static int isofs_read_folio(struct file *file, struct folio *folio)
 {
-	return mpage_readpage(page, isofs_get_block);
+	return mpage_read_folio(folio, isofs_get_block);
 }
 
 static void isofs_readahead(struct readahead_control *rac)
@@ -1190,7 +1190,7 @@ static sector_t _isofs_bmap(struct address_space *mapping, sector_t block)
 }
 
 static const struct address_space_operations isofs_aops = {
-	.readpage = isofs_readpage,
+	.read_folio = isofs_read_folio,
 	.readahead = isofs_readahead,
 	.bmap = _isofs_bmap
 };
diff --git a/fs/jfs/inode.c b/fs/jfs/inode.c
index aa9f112107b2..a5dd7e53754a 100644
--- a/fs/jfs/inode.c
+++ b/fs/jfs/inode.c
@@ -293,9 +293,9 @@ static int jfs_writepages(struct address_space *mapping,
 	return mpage_writepages(mapping, wbc, jfs_get_block);
 }
 
-static int jfs_readpage(struct file *file, struct page *page)
+static int jfs_read_folio(struct file *file, struct folio *folio)
 {
-	return mpage_readpage(page, jfs_get_block);
+	return mpage_read_folio(folio, jfs_get_block);
 }
 
 static void jfs_readahead(struct readahead_control *rac)
@@ -359,7 +359,7 @@ static ssize_t jfs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 const struct address_space_operations jfs_aops = {
 	.dirty_folio	= block_dirty_folio,
 	.invalidate_folio = block_invalidate_folio,
-	.readpage	= jfs_readpage,
+	.read_folio	= jfs_read_folio,
 	.readahead	= jfs_readahead,
 	.writepage	= jfs_writepage,
 	.writepages	= jfs_writepages,
diff --git a/fs/mpage.c b/fs/mpage.c
index a04439b84ae2..6df9c3aa5728 100644
--- a/fs/mpage.c
+++ b/fs/mpage.c
@@ -364,20 +364,22 @@ EXPORT_SYMBOL(mpage_readahead);
 /*
  * This isn't called much at all
  */
-int mpage_readpage(struct page *page, get_block_t get_block)
+int mpage_read_folio(struct folio *folio, get_block_t get_block)
 {
 	struct mpage_readpage_args args = {
-		.page = page,
+		.page = &folio->page,
 		.nr_pages = 1,
 		.get_block = get_block,
 	};
 
+	VM_BUG_ON_FOLIO(folio_test_large(folio), folio);
+
 	args.bio = do_mpage_readpage(&args);
 	if (args.bio)
 		mpage_bio_submit(args.bio);
 	return 0;
 }
-EXPORT_SYMBOL(mpage_readpage);
+EXPORT_SYMBOL(mpage_read_folio);
 
 /*
  * Writing is not so simple.
diff --git a/fs/nilfs2/inode.c b/fs/nilfs2/inode.c
index 02297ec8dc55..26b8065401b0 100644
--- a/fs/nilfs2/inode.c
+++ b/fs/nilfs2/inode.c
@@ -140,14 +140,14 @@ int nilfs_get_block(struct inode *inode, sector_t blkoff,
 }
 
 /**
- * nilfs_readpage() - implement readpage() method of nilfs_aops {}
+ * nilfs_read_folio() - implement read_folio() method of nilfs_aops {}
  * address_space_operations.
  * @file - file struct of the file to be read
- * @page - the page to be read
+ * @folio - the folio to be read
  */
-static int nilfs_readpage(struct file *file, struct page *page)
+static int nilfs_read_folio(struct file *file, struct folio *folio)
 {
-	return mpage_readpage(page, nilfs_get_block);
+	return mpage_read_folio(folio, nilfs_get_block);
 }
 
 static void nilfs_readahead(struct readahead_control *rac)
@@ -298,7 +298,7 @@ nilfs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 
 const struct address_space_operations nilfs_aops = {
 	.writepage		= nilfs_writepage,
-	.readpage		= nilfs_readpage,
+	.read_folio		= nilfs_read_folio,
 	.writepages		= nilfs_writepages,
 	.dirty_folio		= nilfs_dirty_folio,
 	.readahead		= nilfs_readahead,
diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index bfd71f384e21..74f60c457f28 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -676,8 +676,9 @@ static sector_t ntfs_bmap(struct address_space *mapping, sector_t block)
 	return generic_block_bmap(mapping, block, ntfs_get_block_bmap);
 }
 
-static int ntfs_readpage(struct file *file, struct page *page)
+static int ntfs_read_folio(struct file *file, struct folio *folio)
 {
+	struct page *page = &folio->page;
 	int err;
 	struct address_space *mapping = page->mapping;
 	struct inode *inode = mapping->host;
@@ -701,7 +702,7 @@ static int ntfs_readpage(struct file *file, struct page *page)
 	}
 
 	/* Normal + sparse files. */
-	return mpage_readpage(page, ntfs_get_block);
+	return mpage_read_folio(folio, ntfs_get_block);
 }
 
 static void ntfs_readahead(struct readahead_control *rac)
@@ -1940,7 +1941,7 @@ const struct inode_operations ntfs_link_inode_operations = {
 };
 
 const struct address_space_operations ntfs_aops = {
-	.readpage	= ntfs_readpage,
+	.read_folio	= ntfs_read_folio,
 	.readahead	= ntfs_readahead,
 	.writepage	= ntfs_writepage,
 	.writepages	= ntfs_writepages,
@@ -1952,7 +1953,7 @@ const struct address_space_operations ntfs_aops = {
 };
 
 const struct address_space_operations ntfs_aops_cmpr = {
-	.readpage	= ntfs_readpage,
+	.read_folio	= ntfs_read_folio,
 	.readahead	= ntfs_readahead,
 };
 // clang-format on
diff --git a/fs/qnx6/inode.c b/fs/qnx6/inode.c
index 9d8e7e9788a1..b9895afca9d1 100644
--- a/fs/qnx6/inode.c
+++ b/fs/qnx6/inode.c
@@ -94,9 +94,9 @@ static int qnx6_check_blockptr(__fs32 ptr)
 	return 1;
 }
 
-static int qnx6_readpage(struct file *file, struct page *page)
+static int qnx6_read_folio(struct file *file, struct folio *folio)
 {
-	return mpage_readpage(page, qnx6_get_block);
+	return mpage_read_folio(folio, qnx6_get_block);
 }
 
 static void qnx6_readahead(struct readahead_control *rac)
@@ -496,7 +496,7 @@ static sector_t qnx6_bmap(struct address_space *mapping, sector_t block)
 	return generic_block_bmap(mapping, block, qnx6_get_block);
 }
 static const struct address_space_operations qnx6_aops = {
-	.readpage	= qnx6_readpage,
+	.read_folio	= qnx6_read_folio,
 	.readahead	= qnx6_readahead,
 	.bmap		= qnx6_bmap
 };
diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index 866f9a53248e..edc88716751a 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -193,9 +193,9 @@ static int udf_writepages(struct address_space *mapping,
 	return mpage_writepages(mapping, wbc, udf_get_block);
 }
 
-static int udf_readpage(struct file *file, struct page *page)
+static int udf_read_folio(struct file *file, struct folio *folio)
 {
-	return mpage_readpage(page, udf_get_block);
+	return mpage_read_folio(folio, udf_get_block);
 }
 
 static void udf_readahead(struct readahead_control *rac)
@@ -237,7 +237,7 @@ static sector_t udf_bmap(struct address_space *mapping, sector_t block)
 const struct address_space_operations udf_aops = {
 	.dirty_folio	= block_dirty_folio,
 	.invalidate_folio = block_invalidate_folio,
-	.readpage	= udf_readpage,
+	.read_folio	= udf_read_folio,
 	.readahead	= udf_readahead,
 	.writepage	= udf_writepage,
 	.writepages	= udf_writepages,
diff --git a/include/linux/mpage.h b/include/linux/mpage.h
index f4f5e90a6844..43986f7ec4dd 100644
--- a/include/linux/mpage.h
+++ b/include/linux/mpage.h
@@ -16,7 +16,7 @@ struct writeback_control;
 struct readahead_control;
 
 void mpage_readahead(struct readahead_control *, get_block_t get_block);
-int mpage_readpage(struct page *page, get_block_t get_block);
+int mpage_read_folio(struct folio *folio, get_block_t get_block);
 int mpage_writepages(struct address_space *mapping,
 		struct writeback_control *wbc, get_block_t get_block);
 int mpage_writepage(struct page *page, get_block_t *get_block,
-- 
2.34.1

