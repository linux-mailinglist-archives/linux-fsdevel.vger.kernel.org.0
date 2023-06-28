Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8F3741559
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 17:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232364AbjF1Pct (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 11:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232292AbjF1Pcc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 11:32:32 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E34802110;
        Wed, 28 Jun 2023 08:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=xJ1qPIJfB3vnqEcbxhABSkV4Ss9+HxmJh6KO2xy1RwM=; b=aToMyk5kp3G+oyaR05SyvG45RM
        YFwbeCyZajLKo8OxWD9LuMhDm3RX4hyuQONN2DTLG63hqDRxTb7x//SmiYIvbpqTVmOgU7N5YQhv5
        6ohvtydKJfaf0dZ/fc4dQp/ZlFgadg0t6ETKYGRro6XDXo26eolUOKasOnYDPAER1PgiwytW8U2oO
        0v5HjpDwJbwFcjt3YNZrtSrhs1NCXoikvJMsUhb8pUfCBf/zpCWb8blyrNRBl2Gtge58QXKDGwCCM
        t3aa21HFltrmVW4qRJhnSrcRkKS4cXuYw0/e5K0jNJLzDFEzCwyzZshVmcTaORwjI6v7Ctxz9CRDk
        EWBqzO8w==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qEX9h-00G09M-1t;
        Wed, 28 Jun 2023 15:32:30 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 13/23] btrfs: merge async_cow_start and compress_file_range
Date:   Wed, 28 Jun 2023 17:31:34 +0200
Message-Id: <20230628153144.22834-14-hch@lst.de>
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

There is no good reason to have the simple async_cow_start wrapper,
merge the argument conversion into the main compress_file_range function.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/inode.c | 43 ++++++++++++++++---------------------------
 1 file changed, 16 insertions(+), 27 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index f8fbcd359a304d..1e1d6584e1abaa 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -816,24 +816,22 @@ static inline void inode_should_defrag(struct btrfs_inode *inode,
 }
 
 /*
- * we create compressed extents in two phases.  The first
- * phase compresses a range of pages that have already been
- * locked (both pages and state bits are locked).
+ * Work queue call back to started compression on a file and pages.
  *
- * This is done inside an ordered work queue, and the compression
- * is spread across many cpus.  The actual IO submission is step
- * two, and the ordered work queue takes care of making sure that
- * happens in the same order things were put onto the queue by
- * writepages and friends.
+ * This is done inside an ordered work queue, and the compression is spread
+ * across many cpus.  The actual IO submission is step two, and the ordered work
+ * queue takes care of making sure that happens in the same order things were
+ * put onto the queue by writepages and friends.
  *
- * If this code finds it can't get good compression, it puts an
- * entry onto the work queue to write the uncompressed bytes.  This
- * makes sure that both compressed inodes and uncompressed inodes
- * are written in the same order that the flusher thread sent them
- * down.
+ * If this code finds it can't get good compression, it puts an entry onto the
+ * work queue to write the uncompressed bytes.  This makes sure that both
+ * compressed inodes and uncompressed inodes are written in the same order that
+ * the flusher thread sent them down.
  */
-static noinline void compress_file_range(struct async_chunk *async_chunk)
+static void compress_file_range(struct btrfs_work *work)
 {
+	struct async_chunk *async_chunk =
+		container_of(work, struct async_chunk, work);
 	struct btrfs_inode *inode = async_chunk->inode;
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct address_space *mapping = inode->vfs_inode.i_mapping;
@@ -1648,18 +1646,9 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 }
 
 /*
- * work queue call back to started compression on a file and pages
- */
-static noinline void async_cow_start(struct btrfs_work *work)
-{
-	struct async_chunk *async_chunk;
-
-	async_chunk = container_of(work, struct async_chunk, work);
-	compress_file_range(async_chunk);
-}
-
-/*
- * work queue call back to submit previously compressed pages
+ * Phase two of compressed writeback.  This is the ordered portion of the code,
+ * which only gets called in the order the work was queued.  We walk all the
+ * async extents created by compress_file_range and send them down to the disk.
  */
 static noinline void async_cow_submit(struct btrfs_work *work)
 {
@@ -1777,7 +1766,7 @@ static bool run_delalloc_compressed(struct btrfs_inode *inode,
 			async_chunk[i].blkcg_css = NULL;
 		}
 
-		btrfs_init_work(&async_chunk[i].work, async_cow_start,
+		btrfs_init_work(&async_chunk[i].work, compress_file_range,
 				async_cow_submit, async_cow_free);
 
 		nr_pages = DIV_ROUND_UP(cur_end - start, PAGE_SIZE);
-- 
2.39.2

