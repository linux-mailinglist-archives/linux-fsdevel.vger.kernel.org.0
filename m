Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39D6374155C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 17:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232283AbjF1Pcc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 11:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232238AbjF1PcR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 11:32:17 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB8B12713;
        Wed, 28 Jun 2023 08:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Y3NvaUq2249b1rQUIlkJw0hqbZfV+rhFDosLqAAfO14=; b=hm9NV0S/AzFOxIxFGFhPs1W3kz
        mKwMu8JPOoJqpbayBuwTr37HTBmPeyGwCp7BKt+7LRdlDLDwBztWL9/CEEo27De/6IfIXYjlyJgI/
        qZAEbAtJZRrDMrP/GlHWCEL64o2gLYS9SRyCBalc5ysiqRRccfBXF0u9cjylXG8LOv1xF0cJ0Tvc6
        ZPNLo7TRchxtvwEkGfAecwjTaqHDBmSQ6PlM+BoIYco5VwAE/n0e7YdJQd+KhOejmippGA/WZr1iL
        ctM9gALO9yhSvAM+5GE3HAg35FXxkp27DGCobXpN5IQKZwPYwhsvxYbgFMJVnmoi6qY/NNgosTiMZ
        P69C1zJA==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qEX9L-00G04o-0M;
        Wed, 28 Jun 2023 15:32:07 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 06/23] btrfs: reduce debug spam from submit_compressed_extents
Date:   Wed, 28 Jun 2023 17:31:27 +0200
Message-Id: <20230628153144.22834-7-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230628153144.22834-1-hch@lst.de>
References: <20230628153144.22834-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Move the printk that is supposed to help to debug failures in
submit_one_async_extent into submit_one_async_extent and make it
coniditonal on actually having an error condition instead of spamming
the log unconditionally.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/inode.c | 33 +++++++++++++--------------------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index d746b0fe0f994b..0f709f766b6a94 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1181,11 +1181,11 @@ static int submit_uncompressed_range(struct btrfs_inode *inode,
 	return ret;
 }
 
-static int submit_one_async_extent(struct btrfs_inode *inode,
-				   struct async_chunk *async_chunk,
-				   struct async_extent *async_extent,
-				   u64 *alloc_hint)
+static void submit_one_async_extent(struct async_chunk *async_chunk,
+				    struct async_extent *async_extent,
+				    u64 *alloc_hint)
 {
+	struct btrfs_inode *inode = async_chunk->inode;
 	struct extent_io_tree *io_tree = &inode->io_tree;
 	struct btrfs_root *root = inode->root;
 	struct btrfs_fs_info *fs_info = root->fs_info;
@@ -1279,7 +1279,7 @@ static int submit_one_async_extent(struct btrfs_inode *inode,
 	if (async_chunk->blkcg_css)
 		kthread_associate_blkcg(NULL);
 	kfree(async_extent);
-	return ret;
+	return;
 
 out_free_reserve:
 	btrfs_dec_block_group_reservations(fs_info, ins.objectid);
@@ -1293,7 +1293,13 @@ static int submit_one_async_extent(struct btrfs_inode *inode,
 				     PAGE_UNLOCK | PAGE_START_WRITEBACK |
 				     PAGE_END_WRITEBACK);
 	free_async_extent_pages(async_extent);
-	goto done;
+	if (async_chunk->blkcg_css)
+		kthread_associate_blkcg(NULL);
+	btrfs_debug(fs_info,
+"async extent submission failed root=%lld inode=%llu start=%llu len=%llu ret=%d",
+		    root->root_key.objectid, btrfs_ino(inode), start,
+		    async_extent->ram_size, ret);
+	kfree(async_extent);
 }
 
 /*
@@ -1303,28 +1309,15 @@ static int submit_one_async_extent(struct btrfs_inode *inode,
  */
 static noinline void submit_compressed_extents(struct async_chunk *async_chunk)
 {
-	struct btrfs_inode *inode = async_chunk->inode;
-	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct async_extent *async_extent;
 	u64 alloc_hint = 0;
-	int ret = 0;
 
 	while (!list_empty(&async_chunk->extents)) {
-		u64 extent_start;
-		u64 ram_size;
-
 		async_extent = list_entry(async_chunk->extents.next,
 					  struct async_extent, list);
 		list_del(&async_extent->list);
-		extent_start = async_extent->start;
-		ram_size = async_extent->ram_size;
 
-		ret = submit_one_async_extent(inode, async_chunk, async_extent,
-					      &alloc_hint);
-		btrfs_debug(fs_info,
-"async extent submission failed root=%lld inode=%llu start=%llu len=%llu ret=%d",
-			    inode->root->root_key.objectid,
-			    btrfs_ino(inode), extent_start, ram_size, ret);
+		submit_one_async_extent(async_chunk, async_extent, &alloc_hint);
 	}
 }
 
-- 
2.39.2

