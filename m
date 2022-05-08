Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85EAE51F183
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 May 2022 22:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232933AbiEHUhk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 May 2022 16:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232942AbiEHUgo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 May 2022 16:36:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A01111C21
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 May 2022 13:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=X/FdUeb8/fKBYopFgvblMRIua7elDBktuNiBwtVDsgc=; b=sbB1LymSJK9TOBLGnGRykDXvHX
        YsWD9C0TNWgUFCM0x/6bIRz/uGbGC/r0IzpC9KAN6+I2cY/iBZ6xseg0h6e2TDLiVmEPyvHH8eTTk
        KMmH3DJIhXeywN+oYqcL4FIQaWcOUh0uSUEUnHeWDC6o6WhBeNtDkIXpdtyomrdWervWm5XBGdZy5
        1QWD1s18S0hUM/1+OLi2J2QfJx0v3D0A81xW1y8xoaZoKqB2p0lLihIieLMeikCzf9i38SazyR2Vr
        hoPqFwBz101c7ndU85NcCuNBSdVj4BEd9fmBh4WqqYI+juaLa7/jg/q34f+8Ru+LiDh6Zve0+U8Q3
        EpdOV3DA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nnnaE-002o1f-9P; Sun, 08 May 2022 20:32:50 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 12/26] hfs: Convert to release_folio
Date:   Sun,  8 May 2022 21:32:33 +0100
Message-Id: <20220508203247.668791-13-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220508203247.668791-1-willy@infradead.org>
References: <YngbFluT9ftR5dqf@casper.infradead.org>
 <20220508203247.668791-1-willy@infradead.org>
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

Use a folio throughout hfs_release_folio().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/hfs/inode.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
index ba3ff9cd7cfc..86fd50e5fccb 100644
--- a/fs/hfs/inode.c
+++ b/fs/hfs/inode.c
@@ -69,14 +69,15 @@ static sector_t hfs_bmap(struct address_space *mapping, sector_t block)
 	return generic_block_bmap(mapping, block, hfs_get_block);
 }
 
-static int hfs_releasepage(struct page *page, gfp_t mask)
+static bool hfs_release_folio(struct folio *folio, gfp_t mask)
 {
-	struct inode *inode = page->mapping->host;
+	struct inode *inode = folio->mapping->host;
 	struct super_block *sb = inode->i_sb;
 	struct hfs_btree *tree;
 	struct hfs_bnode *node;
 	u32 nidx;
-	int i, res = 1;
+	int i;
+	bool res = true;
 
 	switch (inode->i_ino) {
 	case HFS_EXT_CNID:
@@ -87,27 +88,27 @@ static int hfs_releasepage(struct page *page, gfp_t mask)
 		break;
 	default:
 		BUG();
-		return 0;
+		return false;
 	}
 
 	if (!tree)
-		return 0;
+		return false;
 
 	if (tree->node_size >= PAGE_SIZE) {
-		nidx = page->index >> (tree->node_size_shift - PAGE_SHIFT);
+		nidx = folio->index >> (tree->node_size_shift - PAGE_SHIFT);
 		spin_lock(&tree->hash_lock);
 		node = hfs_bnode_findhash(tree, nidx);
 		if (!node)
 			;
 		else if (atomic_read(&node->refcnt))
-			res = 0;
+			res = false;
 		if (res && node) {
 			hfs_bnode_unhash(node);
 			hfs_bnode_free(node);
 		}
 		spin_unlock(&tree->hash_lock);
 	} else {
-		nidx = page->index << (PAGE_SHIFT - tree->node_size_shift);
+		nidx = folio->index << (PAGE_SHIFT - tree->node_size_shift);
 		i = 1 << (PAGE_SHIFT - tree->node_size_shift);
 		spin_lock(&tree->hash_lock);
 		do {
@@ -115,7 +116,7 @@ static int hfs_releasepage(struct page *page, gfp_t mask)
 			if (!node)
 				continue;
 			if (atomic_read(&node->refcnt)) {
-				res = 0;
+				res = false;
 				break;
 			}
 			hfs_bnode_unhash(node);
@@ -123,7 +124,7 @@ static int hfs_releasepage(struct page *page, gfp_t mask)
 		} while (--i && nidx < tree->node_count);
 		spin_unlock(&tree->hash_lock);
 	}
-	return res ? try_to_free_buffers(page) : 0;
+	return res ? try_to_free_buffers(&folio->page) : false;
 }
 
 static ssize_t hfs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
@@ -165,7 +166,7 @@ const struct address_space_operations hfs_btree_aops = {
 	.write_begin	= hfs_write_begin,
 	.write_end	= generic_write_end,
 	.bmap		= hfs_bmap,
-	.releasepage	= hfs_releasepage,
+	.release_folio	= hfs_release_folio,
 };
 
 const struct address_space_operations hfs_aops = {
-- 
2.34.1

