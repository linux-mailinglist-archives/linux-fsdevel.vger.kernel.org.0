Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA46B516A82
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 May 2022 07:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383411AbiEBGA2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 May 2022 02:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383388AbiEBF7t (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 May 2022 01:59:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 739A2201BF
        for <linux-fsdevel@vger.kernel.org>; Sun,  1 May 2022 22:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=FGj++rPXfLCPDaEoE2AaVd6b+IQknncZLGkmMWOxUUs=; b=e8uG/zDoFWHDki5Eui81Fm+9BW
        8KMDJSWup2FTgJOi5ozyfp7uWMwC8Zz7yTTbGsrbayTQdCdqLQUe5GCHhWnQUy2PWRGbM6/IeNOHq
        QW6ly8qEGbPLjwii07ULfLJEOpDIBJ3TDZTe4UP1ctIuEjZ9tPK9Eodwrp/T95WI2Pk+WdAldjs/S
        MdE8lDpiP5qlXvpwy3eMogKy/Wd4vO1xnELAGM3maLERSRKHVtx1uiEzTWwIxhkOBrPdE/PcCxFki
        EJ1ivWgvfWr+qnJL+82RzWQIGbeR0FCz8Wveg6BS18giJJqhKLeydk6LltGD7Nx0iD/BwAtmUBtFw
        JlZ1o8Gw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nlP2g-00EZWP-FD; Mon, 02 May 2022 05:56:18 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 13/26] hfsplus: Convert to release_folio
Date:   Mon,  2 May 2022 06:56:01 +0100
Message-Id: <20220502055614.3473032-14-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220502055614.3473032-1-willy@infradead.org>
References: <20220502055614.3473032-1-willy@infradead.org>
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

Use a folio throughout hfsplus_release_folio().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/hfsplus/inode.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
index 982b34eefec7..f723e0e91d51 100644
--- a/fs/hfsplus/inode.c
+++ b/fs/hfsplus/inode.c
@@ -63,14 +63,15 @@ static sector_t hfsplus_bmap(struct address_space *mapping, sector_t block)
 	return generic_block_bmap(mapping, block, hfsplus_get_block);
 }
 
-static int hfsplus_releasepage(struct page *page, gfp_t mask)
+static bool hfsplus_release_folio(struct folio *folio, gfp_t mask)
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
 	case HFSPLUS_EXT_CNID:
@@ -84,26 +85,26 @@ static int hfsplus_releasepage(struct page *page, gfp_t mask)
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
-		nidx = page->index >>
+		nidx = folio->index >>
 			(tree->node_size_shift - PAGE_SHIFT);
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
-		nidx = page->index <<
+		nidx = folio->index <<
 			(PAGE_SHIFT - tree->node_size_shift);
 		i = 1 << (PAGE_SHIFT - tree->node_size_shift);
 		spin_lock(&tree->hash_lock);
@@ -112,7 +113,7 @@ static int hfsplus_releasepage(struct page *page, gfp_t mask)
 			if (!node)
 				continue;
 			if (atomic_read(&node->refcnt)) {
-				res = 0;
+				res = false;
 				break;
 			}
 			hfs_bnode_unhash(node);
@@ -120,7 +121,7 @@ static int hfsplus_releasepage(struct page *page, gfp_t mask)
 		} while (--i && nidx < tree->node_count);
 		spin_unlock(&tree->hash_lock);
 	}
-	return res ? try_to_free_buffers(page) : 0;
+	return res ? try_to_free_buffers(&folio->page) : false;
 }
 
 static ssize_t hfsplus_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
@@ -162,7 +163,7 @@ const struct address_space_operations hfsplus_btree_aops = {
 	.write_begin	= hfsplus_write_begin,
 	.write_end	= generic_write_end,
 	.bmap		= hfsplus_bmap,
-	.releasepage	= hfsplus_releasepage,
+	.release_folio	= hfsplus_release_folio,
 };
 
 const struct address_space_operations hfsplus_aops = {
-- 
2.34.1

