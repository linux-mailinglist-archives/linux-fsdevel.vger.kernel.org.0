Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C03E51F195
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 May 2022 22:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233269AbiEHUho (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 May 2022 16:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232963AbiEHUgq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 May 2022 16:36:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8994211C23
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 May 2022 13:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=FGj++rPXfLCPDaEoE2AaVd6b+IQknncZLGkmMWOxUUs=; b=vq+Yo5+cIWR+pefOU62PYoc1ju
        +Bi7AnHVx3vpdrCt1ValLfaj2Wp53+vKek0kAkOJ9ii43uce00mBOCpHmKcrZ0M1BU8Paail9s1l/
        DPaJxf9fvDqfjH4+tbUGpRjV4+EBLJlpchUkR+h8LV3qTOzsWRl8g4SXObkmoUfOtwK41TY7yZy5B
        3/TljC3v8JrCr8SGnZugS/gW1kqUQTofbez4FGdS/h92jIMw0H8sBDWwmhKmg0ca73l/uJz3jt/fS
        JVwqDhoU2BE0hVWoMNR5n99JzulYKuwV6EtJ1W0fIeJc9dGOKZreFNLuzW5N4q7/83VlW7CGDYYlb
        7qHFQJ+Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nnnaE-002o1k-DD; Sun, 08 May 2022 20:32:50 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 13/26] hfsplus: Convert to release_folio
Date:   Sun,  8 May 2022 21:32:34 +0100
Message-Id: <20220508203247.668791-14-willy@infradead.org>
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

