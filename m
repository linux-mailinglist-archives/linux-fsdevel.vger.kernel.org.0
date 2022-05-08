Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE08A51F151
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 May 2022 22:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232568AbiEHUff (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 May 2022 16:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232421AbiEHUfa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 May 2022 16:35:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62AEE10EC
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 May 2022 13:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=vOAIN/In0MbNioyKOxTz1tgWXM+3BlLsUhXZLSiXz50=; b=h1a+8P9BBu05E6XOc4a1PKNZlB
        2XjJtwNQ7Lyxw0psdS9PM5Zc5UvswsCJZLK21l85SIMNGGIk9tSno7EtKO011ilAT1wpdOxn34Tb/
        R0udm1qLXa3GDX+iu0G5S00JD6jxpMFhgc+XZ9qwZU3uFvAEKlX6TE57J2bc8ouuTHDPhz8IFdkR6
        Ss4qZUlzOVa9f3BEczdJhEwJBdNFbNPk9MfOXnZKDQUjU+Foo+siEcbLmatZH+Xh/kvYBld8pnTRA
        S42lo7OegwDr0bSABSWSPKwhEQy/z+vAKdjDxnYc7GlhLGOtuB9t1lDhdd6gGoyjtM8lHyuhHDJDB
        gwN3aVPw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nnnZ3-002nnE-AE; Sun, 08 May 2022 20:31:37 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 04/37] fs: Convert iomap_readpage to iomap_read_folio
Date:   Sun,  8 May 2022 21:30:58 +0100
Message-Id: <20220508203131.667959-5-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220508203131.667959-1-willy@infradead.org>
References: <YngbFluT9ftR5dqf@casper.infradead.org>
 <20220508203131.667959-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A straightforward conversion as iomap_readpage already worked in folios.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/erofs/data.c        |  6 +++---
 fs/gfs2/aops.c         |  3 ++-
 fs/iomap/buffered-io.c | 12 +++++-------
 fs/xfs/xfs_aops.c      |  8 ++++----
 fs/zonefs/super.c      |  6 +++---
 include/linux/iomap.h  |  2 +-
 6 files changed, 18 insertions(+), 19 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 780db1e5f4b7..2edca5669578 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -337,9 +337,9 @@ int erofs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
  * since we dont have write or truncate flows, so no inode
  * locking needs to be held at the moment.
  */
-static int erofs_readpage(struct file *file, struct page *page)
+static int erofs_read_folio(struct file *file, struct folio *folio)
 {
-	return iomap_readpage(page, &erofs_iomap_ops);
+	return iomap_read_folio(folio, &erofs_iomap_ops);
 }
 
 static void erofs_readahead(struct readahead_control *rac)
@@ -394,7 +394,7 @@ static ssize_t erofs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 
 /* for uncompressed (aligned) files and raw access for other files */
 const struct address_space_operations erofs_raw_access_aops = {
-	.readpage = erofs_readpage,
+	.read_folio = erofs_read_folio,
 	.readahead = erofs_readahead,
 	.bmap = erofs_bmap,
 	.direct_IO = noop_direct_IO,
diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
index 72c9f31ce724..a29eb1e5bfe2 100644
--- a/fs/gfs2/aops.c
+++ b/fs/gfs2/aops.c
@@ -467,6 +467,7 @@ static int stuffed_readpage(struct gfs2_inode *ip, struct page *page)
 
 static int __gfs2_readpage(void *file, struct page *page)
 {
+	struct folio *folio = page_folio(page);
 	struct inode *inode = page->mapping->host;
 	struct gfs2_inode *ip = GFS2_I(inode);
 	struct gfs2_sbd *sdp = GFS2_SB(inode);
@@ -474,7 +475,7 @@ static int __gfs2_readpage(void *file, struct page *page)
 
 	if (!gfs2_is_jdata(ip) ||
 	    (i_blocksize(inode) == PAGE_SIZE && !page_has_buffers(page))) {
-		error = iomap_readpage(page, &gfs2_iomap_ops);
+		error = iomap_read_folio(folio, &gfs2_iomap_ops);
 	} else if (gfs2_is_stuffed(ip)) {
 		error = stuffed_readpage(ip, page);
 		unlock_page(page);
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 8ce8720093b9..72f63d719c7c 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -320,10 +320,8 @@ static loff_t iomap_readpage_iter(const struct iomap_iter *iter,
 	return pos - orig_pos + plen;
 }
 
-int
-iomap_readpage(struct page *page, const struct iomap_ops *ops)
+int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
 {
-	struct folio *folio = page_folio(page);
 	struct iomap_iter iter = {
 		.inode		= folio->mapping->host,
 		.pos		= folio_pos(folio),
@@ -352,12 +350,12 @@ iomap_readpage(struct page *page, const struct iomap_ops *ops)
 
 	/*
 	 * Just like mpage_readahead and block_read_full_page, we always
-	 * return 0 and just mark the page as PageError on errors.  This
+	 * return 0 and just set the folio error flag on errors.  This
 	 * should be cleaned up throughout the stack eventually.
 	 */
 	return 0;
 }
-EXPORT_SYMBOL_GPL(iomap_readpage);
+EXPORT_SYMBOL_GPL(iomap_read_folio);
 
 static loff_t iomap_readahead_iter(const struct iomap_iter *iter,
 		struct iomap_readpage_ctx *ctx)
@@ -663,10 +661,10 @@ static size_t __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
 
 	/*
 	 * The blocks that were entirely written will now be uptodate, so we
-	 * don't have to worry about a readpage reading them and overwriting a
+	 * don't have to worry about a read_folio reading them and overwriting a
 	 * partial write.  However, if we've encountered a short write and only
 	 * partially written into a block, it will not be marked uptodate, so a
-	 * readpage might come in and destroy our partial write.
+	 * read_folio might come in and destroy our partial write.
 	 *
 	 * Do the simplest thing and just treat any short write to a
 	 * non-uptodate page as a zero-length write, and force the caller to
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 90b7f4d127de..a9c4bb500d53 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -538,11 +538,11 @@ xfs_vm_bmap(
 }
 
 STATIC int
-xfs_vm_readpage(
+xfs_vm_read_folio(
 	struct file		*unused,
-	struct page		*page)
+	struct folio		*folio)
 {
-	return iomap_readpage(page, &xfs_read_iomap_ops);
+	return iomap_read_folio(folio, &xfs_read_iomap_ops);
 }
 
 STATIC void
@@ -564,7 +564,7 @@ xfs_iomap_swapfile_activate(
 }
 
 const struct address_space_operations xfs_address_space_operations = {
-	.readpage		= xfs_vm_readpage,
+	.read_folio		= xfs_vm_read_folio,
 	.readahead		= xfs_vm_readahead,
 	.writepages		= xfs_vm_writepages,
 	.dirty_folio		= filemap_dirty_folio,
diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index e20e7c841489..c3a38f711b24 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -124,9 +124,9 @@ static const struct iomap_ops zonefs_iomap_ops = {
 	.iomap_begin	= zonefs_iomap_begin,
 };
 
-static int zonefs_readpage(struct file *unused, struct page *page)
+static int zonefs_read_folio(struct file *unused, struct folio *folio)
 {
-	return iomap_readpage(page, &zonefs_iomap_ops);
+	return iomap_read_folio(folio, &zonefs_iomap_ops);
 }
 
 static void zonefs_readahead(struct readahead_control *rac)
@@ -192,7 +192,7 @@ static int zonefs_swap_activate(struct swap_info_struct *sis,
 }
 
 static const struct address_space_operations zonefs_file_aops = {
-	.readpage		= zonefs_readpage,
+	.read_folio		= zonefs_read_folio,
 	.readahead		= zonefs_readahead,
 	.writepage		= zonefs_writepage,
 	.writepages		= zonefs_writepages,
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index b76f0dd149fb..5b2aa45ddda3 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -225,7 +225,7 @@ static inline const struct iomap *iomap_iter_srcmap(const struct iomap_iter *i)
 
 ssize_t iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *from,
 		const struct iomap_ops *ops);
-int iomap_readpage(struct page *page, const struct iomap_ops *ops);
+int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops);
 void iomap_readahead(struct readahead_control *, const struct iomap_ops *ops);
 bool iomap_is_partially_uptodate(struct folio *, size_t from, size_t count);
 int iomap_releasepage(struct page *page, gfp_t gfp_mask);
-- 
2.34.1

