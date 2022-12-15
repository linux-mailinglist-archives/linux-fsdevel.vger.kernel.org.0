Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A98A64E36E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Dec 2022 22:44:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbiLOVoR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Dec 2022 16:44:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbiLOVoE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Dec 2022 16:44:04 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21FE85C757
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Dec 2022 13:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=0k+Hmew8uEf7FDAacVor3Mh6CSlwV+m6dr5BNsU01p8=; b=jU3tz14SzE+kFxrT9h9LonHRW5
        expWMiNEIKfn4GRTgV29iJj8pYReGkQl1qDW4hbnSk3XWY309K5FHTPX6/MqZKLXmSKU1sJkMG0gH
        Zk1Ou8DG811PpZ7YaGeMvC8zf3+GLcgdniiSx67qoJETPAfHeOeCXBHv0OYqSTtftgXcT1H6386fQ
        pY00W1fShpCXKfXNzi2L8Zcf5mW5nIzdG0rn69vFddgqJljp4n2BYT54cf1G6lsDJcSIP9njZ1f8G
        zFTF52vxp0lC4oiBcNY4TUY0afXDrpBfpwqzPjxChxdOTXLN5nkXya2kSZ+RB+cwpn3s5hMD8Mcau
        I0/mUZQw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p5w1P-00EmMA-Km; Thu, 15 Dec 2022 21:44:07 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 10/12] nilfs2: Replace obvious uses of b_page with b_folio
Date:   Thu, 15 Dec 2022 21:44:00 +0000
Message-Id: <20221215214402.3522366-11-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221215214402.3522366-1-willy@infradead.org>
References: <20221215214402.3522366-1-willy@infradead.org>
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

These places just use b_page to get to the buffer's address_space
or the index of the page the buffer is in.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/nilfs2/btnode.c  | 2 +-
 fs/nilfs2/btree.c   | 2 +-
 fs/nilfs2/gcinode.c | 2 +-
 fs/nilfs2/mdt.c     | 4 ++--
 fs/nilfs2/segment.c | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/nilfs2/btnode.c b/fs/nilfs2/btnode.c
index e74fda212620..e956f886a1a1 100644
--- a/fs/nilfs2/btnode.c
+++ b/fs/nilfs2/btnode.c
@@ -188,7 +188,7 @@ int nilfs_btnode_prepare_change_key(struct address_space *btnc,
 		struct page *opage = obh->b_page;
 		lock_page(opage);
 retry:
-		/* BUG_ON(oldkey != obh->b_page->index); */
+		/* BUG_ON(oldkey != obh->b_folio->index); */
 		if (unlikely(oldkey != opage->index))
 			NILFS_PAGE_BUG(opage,
 				       "invalid oldkey %lld (newkey=%lld)",
diff --git a/fs/nilfs2/btree.c b/fs/nilfs2/btree.c
index b9d15c3df3cc..6b914217b0c7 100644
--- a/fs/nilfs2/btree.c
+++ b/fs/nilfs2/btree.c
@@ -398,7 +398,7 @@ int nilfs_btree_broken_node_block(struct buffer_head *bh)
 	if (buffer_nilfs_checked(bh))
 		return 0;
 
-	inode = bh->b_page->mapping->host;
+	inode = bh->b_folio->mapping->host;
 	ret = nilfs_btree_node_broken((struct nilfs_btree_node *)bh->b_data,
 				      bh->b_size, inode, bh->b_blocknr);
 	if (likely(!ret))
diff --git a/fs/nilfs2/gcinode.c b/fs/nilfs2/gcinode.c
index b0d22ff24b67..48fe71d309cb 100644
--- a/fs/nilfs2/gcinode.c
+++ b/fs/nilfs2/gcinode.c
@@ -140,7 +140,7 @@ int nilfs_gccache_wait_and_mark_dirty(struct buffer_head *bh)
 {
 	wait_on_buffer(bh);
 	if (!buffer_uptodate(bh)) {
-		struct inode *inode = bh->b_page->mapping->host;
+		struct inode *inode = bh->b_folio->mapping->host;
 
 		nilfs_err(inode->i_sb,
 			  "I/O error reading %s block for GC (ino=%lu, vblocknr=%llu)",
diff --git a/fs/nilfs2/mdt.c b/fs/nilfs2/mdt.c
index cbf4fa60eea2..19c8158605ed 100644
--- a/fs/nilfs2/mdt.c
+++ b/fs/nilfs2/mdt.c
@@ -563,7 +563,7 @@ int nilfs_mdt_freeze_buffer(struct inode *inode, struct buffer_head *bh)
 	struct page *page;
 	int blkbits = inode->i_blkbits;
 
-	page = grab_cache_page(shadow->inode->i_mapping, bh->b_page->index);
+	page = grab_cache_page(shadow->inode->i_mapping, bh->b_folio->index);
 	if (!page)
 		return -ENOMEM;
 
@@ -595,7 +595,7 @@ nilfs_mdt_get_frozen_buffer(struct inode *inode, struct buffer_head *bh)
 	struct page *page;
 	int n;
 
-	page = find_lock_page(shadow->inode->i_mapping, bh->b_page->index);
+	page = find_lock_page(shadow->inode->i_mapping, bh->b_folio->index);
 	if (page) {
 		if (page_has_buffers(page)) {
 			n = bh_offset(bh) >> inode->i_blkbits;
diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
index 3335ef352915..05a151e5c52b 100644
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -1581,7 +1581,7 @@ nilfs_segctor_update_payload_blocknr(struct nilfs_sc_info *sci,
 			nblocks = le32_to_cpu(finfo->fi_nblocks);
 			ndatablk = le32_to_cpu(finfo->fi_ndatablk);
 
-			inode = bh->b_page->mapping->host;
+			inode = bh->b_folio->mapping->host;
 
 			if (mode == SC_LSEG_DSYNC)
 				sc_op = &nilfs_sc_dsync_ops;
-- 
2.35.1

