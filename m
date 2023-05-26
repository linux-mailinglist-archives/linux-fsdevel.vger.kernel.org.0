Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07B1E71219B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 May 2023 09:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242597AbjEZH4K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 May 2023 03:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242138AbjEZH4H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 May 2023 03:56:07 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C0A3125;
        Fri, 26 May 2023 00:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=NWUBmxTvJYmgTPK2izgiLtu8bfX6PD49E6ZFMW3sIA8=; b=WnxjNjU6yVkEoG/2yJlDTptWs+
        IG4CY/nxbwF8l4vRcxt8rVMn+9Dke0fLaHt3F5PKjYHOCuggCCfmh6i38zB5Gx5JOJLWasGkYjxH0
        QrvgHFxs3p0IHA4D2naeXZvojSzJjquvJ8IOoTDRqg0KY+GyKnG89UoXRje+tPiuSXfkrionjwvMZ
        WwhJR2wNNcLjSsxhHhxiIqnT8Nk9scxo6r5Gv7Jlz/qvE29q34PedlMGogFKJpYEFffHm4TubN+Al
        +neu4w739RAZ/MuaXB06KM7rPauhpBwSTQwxfDsOHTDhLQFP7KD43o6lXsgWZlGEsM6hpYLW48oqt
        TUayW7nw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q2SIj-001WZw-39;
        Fri, 26 May 2023 07:55:53 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     hughd@google.com, akpm@linux-foundation.org, willy@infradead.org,
        brauner@kernel.org, djwong@kernel.org
Cc:     p.raghav@samsung.com, da.gomez@samsung.com, rohan.puri@samsung.com,
        rpuri.linux@gmail.com, a.manzanares@samsung.com, dave@stgolabs.net,
        yosryahmed@google.com, keescook@chromium.org, hare@suse.de,
        kbusch@kernel.org, mcgrof@kernel.org, patches@lists.linux.dev,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [RFC v2 6/8] shmem: consider block size in shmem_default_max_inodes()
Date:   Fri, 26 May 2023 00:55:50 -0700
Message-Id: <20230526075552.363524-7-mcgrof@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230526075552.363524-1-mcgrof@kernel.org>
References: <20230526075552.363524-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Today we allow for a max number of inodes in consideration for
the smallest possible inodes with just one block of size PAGE_SIZE.
The max number of inodes depend on the size of the block size then,
and if we want to support higher block sizes we end up with less
number of inodes.

Account for this in the computation for the max number of inodes.

If the blocksize is greater than the PAGE_SIZE, we simply divide the
number of pages usable, multiply by the page size and divide by the
blocksize.

This produces no functional changes right now as we don't support
larger block sizes yet.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 mm/shmem.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 179fde04f57f..d347a5ba49f1 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -145,11 +145,14 @@ static unsigned long shmem_default_max_blocks(unsigned char block_order)
 	return totalram_pages() >> (block_order - PAGE_SHIFT + 1);
 }
 
-static unsigned long shmem_default_max_inodes(void)
+static unsigned long shmem_default_max_inodes(unsigned char block_order)
 {
 	unsigned long nr_pages = totalram_pages();
+	unsigned long pages_for_inodes = min(nr_pages - totalhigh_pages(), nr_pages / 2);
 
-	return min(nr_pages - totalhigh_pages(), nr_pages / 2);
+	if (block_order == shmem_default_block_order())
+		return pages_for_inodes;
+	return pages_for_inodes >> (block_order - PAGE_SHIFT);
 }
 #else
 static u64 shmem_block_order(struct shmem_sb_info *sbinfo)
@@ -3910,7 +3913,7 @@ static int shmem_show_options(struct seq_file *seq, struct dentry *root)
 	if (sbinfo->max_blocks != shmem_default_max_blocks(shmem_default_block_order()))
 		seq_printf(seq, ",size=%luk",
 			sbinfo->max_blocks << (PAGE_SHIFT - 10));
-	if (sbinfo->max_inodes != shmem_default_max_inodes())
+	if (sbinfo->max_inodes != shmem_default_max_inodes(shmem_default_block_order()))
 		seq_printf(seq, ",nr_inodes=%lu", sbinfo->max_inodes);
 	if (sbinfo->mode != (0777 | S_ISVTX))
 		seq_printf(seq, ",mode=%03ho", sbinfo->mode);
@@ -3991,7 +3994,7 @@ static int shmem_fill_super(struct super_block *sb, struct fs_context *fc)
 		if (!(ctx->seen & SHMEM_SEEN_BLOCKS))
 			ctx->blocks = shmem_default_max_blocks(shmem_default_block_order());
 		if (!(ctx->seen & SHMEM_SEEN_INODES))
-			ctx->inodes = shmem_default_max_inodes();
+			ctx->inodes = shmem_default_max_inodes(shmem_default_block_order());
 		if (!(ctx->seen & SHMEM_SEEN_INUMS))
 			ctx->full_inums = IS_ENABLED(CONFIG_TMPFS_INODE64);
 		sbinfo->noswap = ctx->noswap;
-- 
2.39.2

