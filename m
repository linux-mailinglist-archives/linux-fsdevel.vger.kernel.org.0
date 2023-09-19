Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAB357A58CC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 06:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbjISEwQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 00:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231532AbjISEvt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 00:51:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B17BE10E;
        Mon, 18 Sep 2023 21:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=a6i4bdchPc6HMgDBqig75VvpKzooiKHmiAIw8plYx/A=; b=vjMgplfMtIe6ZcEV1vMku1lxmK
        PsFTYRHWDXBNjUSROOLSN4Bpb8lsqCFcFKMBvDoRXH7TnevNJDUi34+FPo02N+/uTCvYDeID1YJFu
        X5X6Nm2kyS966fB/fY8ewnDwKUuifO0nAG70xJAsUBeOiSKo5OdkjxGmzxPKWhxVb3IbQE13DxT3d
        NlRzmC5f8FnnVxgQE7nPNMtMDvBIUfodl70TNxqc7hPn8VvrRfgWlmx5eOebWxhAuxW2QJX0k4OPx
        UwvgOVerjuBuo7KfmNdjhzbgNffAT61SUh1ITWJoWUN3F9EcfE4vA8SyYdU99IbkVskJIINWpIvZO
        661BslgA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qiSi4-00FFm2-QE; Tue, 19 Sep 2023 04:51:40 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev,
        linux-nilfs@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
        ntfs3@lists.linux.dev, ocfs2-devel@lists.linux.dev,
        reiserfs-devel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH 20/26] ocfs2: Convert ocfs2_map_page_blocks to use a folio
Date:   Tue, 19 Sep 2023 05:51:29 +0100
Message-Id: <20230919045135.3635437-21-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230919045135.3635437-1-willy@infradead.org>
References: <20230919045135.3635437-1-willy@infradead.org>
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

Convert the page argument to a folio and then use the folio APIs
throughout.  Replaces three hidden calls to compound_head() with one
explicit one.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ocfs2/aops.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/fs/ocfs2/aops.c b/fs/ocfs2/aops.c
index 0fdba30740ab..95d1e70b4401 100644
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

