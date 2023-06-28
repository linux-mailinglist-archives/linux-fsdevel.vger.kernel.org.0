Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 481BB741563
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 17:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232328AbjF1Pcw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 11:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232311AbjF1Pcg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 11:32:36 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF3A268F;
        Wed, 28 Jun 2023 08:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=B6Fz3GIuNoCACxA3ezmjCwn+xoSZbIPepw0++x2ObAA=; b=j0tWBvm1rnFENeLu0ylogbwyIU
        u3WmCLvd5HeQ38foiJVSRC8CScMG3btoj6dN6ijZnlAz9NuuGN4HsXUo0r8b1yUpTg1szPyWYgD5y
        p2zySF4RlzVpj0oIRgRvfjy5LVsOmANReNjE6UiQeSs1ZeVKJelAVCmWguCPOROmtaOrUr2W9fwOC
        ci9a1UKsiIO8eXkIPdVAXzyFhCgrLrL3gDFE9wlA9WeJEHw/VeY4FphTpbiE+TjreuxrDUcR6x1MU
        hY4WI9ZqTIdkrPGQYJMAT9LymoFpG4B6JK43NMubLXascaiNwFYkIskDrY8kcfnjm0UFUC5IUHHnM
        MJuv7H3Q==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qEX9l-00G0A5-03;
        Wed, 28 Jun 2023 15:32:33 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 14/23] btrfs: merge submit_compressed_extents and async_cow_submit
Date:   Wed, 28 Jun 2023 17:31:35 +0200
Message-Id: <20230628153144.22834-15-hch@lst.de>
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

The code in submit_compressed_extents just loops over the async_extents,
and doesn't need to be conditional on an inode being present, as there
won't be any async_extent in the list if we created and inline extent.
Merge the two functions to simplify the logic.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/inode.c | 39 ++++++++++-----------------------------
 1 file changed, 10 insertions(+), 29 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 1e1d6584e1abaa..09f8c6f2f4bf88 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1289,25 +1289,6 @@ static void submit_one_async_extent(struct async_chunk *async_chunk,
 	kfree(async_extent);
 }
 
-/*
- * Phase two of compressed writeback.  This is the ordered portion of the code,
- * which only gets called in the order the work was queued.  We walk all the
- * async extents created by compress_file_range and send them down to the disk.
- */
-static noinline void submit_compressed_extents(struct async_chunk *async_chunk)
-{
-	struct async_extent *async_extent;
-	u64 alloc_hint = 0;
-
-	while (!list_empty(&async_chunk->extents)) {
-		async_extent = list_entry(async_chunk->extents.next,
-					  struct async_extent, list);
-		list_del(&async_extent->list);
-
-		submit_one_async_extent(async_chunk, async_extent, &alloc_hint);
-	}
-}
-
 static u64 get_extent_allocation_hint(struct btrfs_inode *inode, u64 start,
 				      u64 num_bytes)
 {
@@ -1650,24 +1631,24 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
  * which only gets called in the order the work was queued.  We walk all the
  * async extents created by compress_file_range and send them down to the disk.
  */
-static noinline void async_cow_submit(struct btrfs_work *work)
+static noinline void submit_compressed_extents(struct btrfs_work *work)
 {
 	struct async_chunk *async_chunk = container_of(work, struct async_chunk,
 						     work);
 	struct btrfs_fs_info *fs_info = btrfs_work_owner(work);
+	struct async_extent *async_extent;
 	unsigned long nr_pages;
+	u64 alloc_hint = 0;
 
 	nr_pages = (async_chunk->end - async_chunk->start + PAGE_SIZE) >>
 		PAGE_SHIFT;
 
-	/*
-	 * ->inode could be NULL if async_chunk_start has failed to compress,
-	 * in which case we don't have anything to submit, yet we need to
-	 * always adjust ->async_delalloc_pages as its paired with the init
-	 * happening in run_delalloc_compressed
-	 */
-	if (async_chunk->inode)
-		submit_compressed_extents(async_chunk);
+	while (!list_empty(&async_chunk->extents)) {
+		async_extent = list_entry(async_chunk->extents.next,
+					  struct async_extent, list);
+		list_del(&async_extent->list);
+		submit_one_async_extent(async_chunk, async_extent, &alloc_hint);
+	}
 
 	/* atomic_sub_return implies a barrier */
 	if (atomic_sub_return(nr_pages, &fs_info->async_delalloc_pages) <
@@ -1767,7 +1748,7 @@ static bool run_delalloc_compressed(struct btrfs_inode *inode,
 		}
 
 		btrfs_init_work(&async_chunk[i].work, compress_file_range,
-				async_cow_submit, async_cow_free);
+				submit_compressed_extents, async_cow_free);
 
 		nr_pages = DIV_ROUND_UP(cur_end - start, PAGE_SIZE);
 		atomic_add(nr_pages, &fs_info->async_delalloc_pages);
-- 
2.39.2

