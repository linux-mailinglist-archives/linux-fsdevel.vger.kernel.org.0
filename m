Return-Path: <linux-fsdevel+bounces-478-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 891B47CB418
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 22:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1174FB213ED
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 20:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 944B738F9A;
	Mon, 16 Oct 2023 20:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IvedTuBN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28F13717D
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 20:11:33 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 095CF102;
	Mon, 16 Oct 2023 13:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=uRYwye2tS2VKcBuJRmgCvN2KUM2u4JgvivY1TEOS98E=; b=IvedTuBNDiadfAJVjuQlYJbb4B
	KmeqvJPgZuAUxOvSLTvscBsaOsG1BrvGiX+0gd2qH0H1eC/O6Bv4xu5d5HdSdg0xqTce4I2jrxpSb
	hlAW4f+qsw9TA5ump6FTVG28aNbp2EGxy5W+DpaHt+aWqvjyMuDC+F7FEUEBVF12N/UObw5aJFbL+
	x8ILnbo8oVMNp/6FKkjCFtdu0kmxeDfzHweamKvMF1mYMBMHj24QgsaTkiWALjcV+BSyZRXd5zHny
	ZS+kalvqG5pYR9p+nRRSBPpOpyccaX77Gdto7mHFtMkdoubqdFj1kAz1unMSv4Zj262LCGIYJRgL+
	fmFLWTEg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1qsTvr-0085cR-5C; Mon, 16 Oct 2023 20:11:19 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-nilfs@vger.kernel.org,
	linux-ntfs-dev@lists.sourceforge.net,
	ntfs3@lists.linux.dev,
	ocfs2-devel@lists.linux.dev,
	reiserfs-devel@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH v2 21/27] ocfs2: Convert ocfs2_map_page_blocks to use a folio
Date: Mon, 16 Oct 2023 21:11:08 +0100
Message-Id: <20231016201114.1928083-22-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231016201114.1928083-1-willy@infradead.org>
References: <20231016201114.1928083-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Convert the page argument to a folio and then use the folio APIs
throughout.  Replaces three hidden calls to compound_head() with one
explicit one.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ocfs2/aops.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/fs/ocfs2/aops.c b/fs/ocfs2/aops.c
index 6ab03494fc6e..001ad1d288ec 100644
--- a/fs/ocfs2/aops.c
+++ b/fs/ocfs2/aops.c
@@ -568,10 +568,10 @@ static void ocfs2_clear_page_regions(struct page *page,
  * read-in the blocks at the tail of our file. Avoid reading them by
  * testing i_size against each block offset.
  */
-static int ocfs2_should_read_blk(struct inode *inode, struct page *page,
+static int ocfs2_should_read_blk(struct inode *inode, struct folio *folio,
 				 unsigned int block_start)
 {
-	u64 offset = page_offset(page) + block_start;
+	u64 offset = folio_pos(folio) + block_start;
 
 	if (ocfs2_sparse_alloc(OCFS2_SB(inode->i_sb)))
 		return 1;
@@ -593,15 +593,16 @@ int ocfs2_map_page_blocks(struct page *page, u64 *p_blkno,
 			  struct inode *inode, unsigned int from,
 			  unsigned int to, int new)
 {
+	struct folio *folio = page_folio(page);
 	int ret = 0;
 	struct buffer_head *head, *bh, *wait[2], **wait_bh = wait;
 	unsigned int block_end, block_start;
 	unsigned int bsize = i_blocksize(inode);
 
-	if (!page_has_buffers(page))
-		create_empty_buffers(page, bsize, 0);
+	head = folio_buffers(folio);
+	if (!head)
+		head = folio_create_empty_buffers(folio, bsize, 0);
 
-	head = page_buffers(page);
 	for (bh = head, block_start = 0; bh != head || !block_start;
 	     bh = bh->b_this_page, block_start += bsize) {
 		block_end = block_start + bsize;
@@ -613,7 +614,7 @@ int ocfs2_map_page_blocks(struct page *page, u64 *p_blkno,
 		 * they may belong to unallocated clusters.
 		 */
 		if (block_start >= to || block_end <= from) {
-			if (PageUptodate(page))
+			if (folio_test_uptodate(folio))
 				set_buffer_uptodate(bh);
 			continue;
 		}
@@ -630,11 +631,11 @@ int ocfs2_map_page_blocks(struct page *page, u64 *p_blkno,
 			clean_bdev_bh_alias(bh);
 		}
 
-		if (PageUptodate(page)) {
+		if (folio_test_uptodate(folio)) {
 			set_buffer_uptodate(bh);
 		} else if (!buffer_uptodate(bh) && !buffer_delay(bh) &&
 			   !buffer_new(bh) &&
-			   ocfs2_should_read_blk(inode, page, block_start) &&
+			   ocfs2_should_read_blk(inode, folio, block_start) &&
 			   (block_start < from || block_end > to)) {
 			bh_read_nowait(bh, 0);
 			*wait_bh++=bh;
@@ -668,7 +669,7 @@ int ocfs2_map_page_blocks(struct page *page, u64 *p_blkno,
 		if (block_start >= to)
 			break;
 
-		zero_user(page, block_start, bh->b_size);
+		folio_zero_range(folio, block_start, bh->b_size);
 		set_buffer_uptodate(bh);
 		mark_buffer_dirty(bh);
 
-- 
2.40.1


