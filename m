Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 034D774155F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 17:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232306AbjF1Pcg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 11:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231268AbjF1Pca (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 11:32:30 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31BAC268F;
        Wed, 28 Jun 2023 08:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=PJKul60FOrF0f6XpU9hW903HmzmLSrQrksohee9v4z0=; b=X6RDIoN45khiqil7iJ0SnHv1Aw
        w5x9uGpEx6EWZTE2nfb5niCwAg0r4uy6bOfJLle0uEstoRP/zxZ5Rhqw8Rmsoktg4SlRuPlx7MKMF
        hsbeQXS1Gr+9uZG5DNj8fmbNxNYd6Lraq4FarhpsubSB/FqJ28XedqTFP2tKG7LVOM1VtfU0AzkwZ
        3j4l+fmvGibllJUFR/KOI0v760gzvfHfRXVPzmgIxlb7UKUexM2/SkE816KNWWzrVlGAUzzuoYVmh
        QDRr4iIdlMcGgERqgeKe5Eaw2xkZrHdWhIsgQuOUL+JHj6dmd6D1M0NZQXktRxKedPQHv0KvEvImz
        a7zruMoQ==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qEX9e-00G08o-2p;
        Wed, 28 Jun 2023 15:32:27 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 12/23] btrfs: don't clear async_chunk->inode in async_cow_start
Date:   Wed, 28 Jun 2023 17:31:33 +0200
Message-Id: <20230628153144.22834-13-hch@lst.de>
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

Now that the ->inode check isn't needed in submit_compressed_extents
any more, there is no reason to clear the field early.  Always keep
the inode around until the work item is finished and remove the special
casing, and the counting of compressed extents in compress_file_range.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/inode.c | 23 +++++------------------
 1 file changed, 5 insertions(+), 18 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 6197b33fb0b23b..f8fbcd359a304d 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -832,7 +832,7 @@ static inline void inode_should_defrag(struct btrfs_inode *inode,
  * are written in the same order that the flusher thread sent them
  * down.
  */
-static noinline int compress_file_range(struct async_chunk *async_chunk)
+static noinline void compress_file_range(struct async_chunk *async_chunk)
 {
 	struct btrfs_inode *inode = async_chunk->inode;
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
@@ -850,7 +850,6 @@ static noinline int compress_file_range(struct async_chunk *async_chunk)
 	int i;
 	int will_compress;
 	int compress_type = fs_info->compress_type;
-	int compressed_extents = 0;
 	int redirty = 0;
 
 	inode_should_defrag(inode, start, end, end - start + 1, SZ_16K);
@@ -1027,7 +1026,7 @@ static noinline int compress_file_range(struct async_chunk *async_chunk)
 				}
 				kfree(pages);
 			}
-			return 0;
+			return;
 		}
 	}
 
@@ -1046,8 +1045,6 @@ static noinline int compress_file_range(struct async_chunk *async_chunk)
 		 */
 		total_in = round_up(total_in, fs_info->sectorsize);
 		if (total_compressed + blocksize <= total_in) {
-			compressed_extents++;
-
 			/*
 			 * The async work queues will take care of doing actual
 			 * allocation on disk for these compressed pages, and
@@ -1063,7 +1060,7 @@ static noinline int compress_file_range(struct async_chunk *async_chunk)
 				cond_resched();
 				goto again;
 			}
-			return compressed_extents;
+			return;
 		}
 	}
 	if (pages) {
@@ -1104,9 +1101,6 @@ static noinline int compress_file_range(struct async_chunk *async_chunk)
 		extent_range_redirty_for_io(&inode->vfs_inode, start, end);
 	add_async_extent(async_chunk, start, end - start + 1, 0, NULL, 0,
 			 BTRFS_COMPRESS_NONE);
-	compressed_extents++;
-
-	return compressed_extents;
 }
 
 static void free_async_extent_pages(struct async_extent *async_extent)
@@ -1659,15 +1653,9 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 static noinline void async_cow_start(struct btrfs_work *work)
 {
 	struct async_chunk *async_chunk;
-	int compressed_extents;
 
 	async_chunk = container_of(work, struct async_chunk, work);
-
-	compressed_extents = compress_file_range(async_chunk);
-	if (compressed_extents == 0) {
-		btrfs_add_delayed_iput(async_chunk->inode);
-		async_chunk->inode = NULL;
-	}
+	compress_file_range(async_chunk);
 }
 
 /*
@@ -1704,8 +1692,7 @@ static noinline void async_cow_free(struct btrfs_work *work)
 	struct async_cow *async_cow;
 
 	async_chunk = container_of(work, struct async_chunk, work);
-	if (async_chunk->inode)
-		btrfs_add_delayed_iput(async_chunk->inode);
+	btrfs_add_delayed_iput(async_chunk->inode);
 	if (async_chunk->blkcg_css)
 		css_put(async_chunk->blkcg_css);
 
-- 
2.39.2

