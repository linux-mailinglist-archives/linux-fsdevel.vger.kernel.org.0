Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8226EB3C8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Apr 2023 23:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233682AbjDUVo0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Apr 2023 17:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233520AbjDUVoS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Apr 2023 17:44:18 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07EFB1FD6;
        Fri, 21 Apr 2023 14:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=qZHhB8oJRc4fNtBxtSdci4h920oOcANZrFW/y3BBdxc=; b=qwUcweMcO4pJRMTax4NLy0VSpN
        KXR/HutcTxUAf1AkUOpohVQt9D1HYkGbVjqLunH8jowN6HHKGq80LixliXi2Hao7TSPjFNtf1/IzO
        7hDxeIEAYf+PFCY6rZWFQl4IGZWfP0KyQ5vipRU6TqfGLflWy21DT0TJE7R0QUnYRa/WxByUTqiII
        BuHGKTgRoWB8MbgfuNMvCOuGnM+sX/c7GBDhVEJw9LJtgPKEyst4dKWFE7LdUCITswqVJpNqKk8W9
        slkIqwAA4DulGimTxOQmf5WZEzZP8nrP9FTqQ4fOvBM8gc8Qmz0rtULu5SAg6nZRtVW89WyRdSDAo
        le8pzh1w==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1ppyY1-00Btoq-2J;
        Fri, 21 Apr 2023 21:44:05 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     hughd@google.com, akpm@linux-foundation.org, willy@infradead.org,
        brauner@kernel.org, djwong@kernel.org
Cc:     p.raghav@samsung.com, da.gomez@samsung.com,
        a.manzanares@samsung.com, dave@stgolabs.net, yosryahmed@google.com,
        keescook@chromium.org, hare@suse.de, kbusch@kernel.org,
        mcgrof@kernel.org, patches@lists.linux.dev,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [RFC 5/8] shmem: account for larger blocks sizes for shmem_default_max_blocks()
Date:   Fri, 21 Apr 2023 14:43:57 -0700
Message-Id: <20230421214400.2836131-6-mcgrof@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230421214400.2836131-1-mcgrof@kernel.org>
References: <20230421214400.2836131-1-mcgrof@kernel.org>
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

If we end up supporting a larger block size than PAGE_SIZE the calculations in
shmem_default_max_blocks() need to be modified to take into account the fact
that multiple pages would be required for a single block.

Today the max number of blocks is computed based on the fact that we
will by default use half of the available memory and each block is of
PAGE_SIZE.

And so we end up with:

totalram_pages() / 2

That's becauase blocksize == PAGE_SIZE. When blocksize > PAGE_SIZE
we need to consider how how many blocks fit into totalram_pages() first,
then just divide by 2. This ends up being:

totalram_pages * PAGE_SIZE / blocksize / 2
totalram_pages * 2^PAGE_SHIFT / 2^bbits / 2
totalram_pages * 2^(PAGE_SHIFT - bbits - 1)

We know bbits > PAGE_SHIFT so we'll end up with a negative
power of 2. 2^(-some_val). We can factor the -1 out by changing
this to a division of power of 2 and flipping the values for
the signs:

-1 * (PAGE_SHIFT - bbits -1) = (-PAGE_SHIFT + bbits + 1)
                             = (bbits - PAGE_SHIFT + 1)

And so we end up with:

totalram_pages / 2^(bbits - PAGE_SHIFT + 1)

We use __ffs(blocksize) as this computation is needed early on before
any inode is established.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 mm/shmem.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 162384b58a5c..b83596467706 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -136,9 +136,11 @@ static u64 shmem_sb_blocksize(struct shmem_sb_info *sbinfo)
 	return sbinfo->blocksize;
 }
 
-static unsigned long shmem_default_max_blocks(void)
+static unsigned long shmem_default_max_blocks(u64 blocksize)
 {
-	return totalram_pages() / 2;
+	if (blocksize == shmem_default_bsize())
+		return totalram_pages() / 2;
+	return totalram_pages() >> (__ffs(blocksize) - PAGE_SHIFT + 1);
 }
 
 static unsigned long shmem_default_max_inodes(void)
@@ -3816,7 +3818,7 @@ static int shmem_parse_one(struct fs_context *fc, struct fs_parameter *param)
 		}
 		if (*rest)
 			goto bad_value;
-		ctx->blocks = DIV_ROUND_UP(size, PAGE_SIZE);
+		ctx->blocks = DIV_ROUND_UP(size, shmem_default_bsize());
 		ctx->seen |= SHMEM_SEEN_BLOCKS;
 		break;
 	case Opt_nr_blocks:
@@ -4023,7 +4025,7 @@ static int shmem_show_options(struct seq_file *seq, struct dentry *root)
 {
 	struct shmem_sb_info *sbinfo = SHMEM_SB(root->d_sb);
 
-	if (sbinfo->max_blocks != shmem_default_max_blocks())
+	if (sbinfo->max_blocks != shmem_default_max_blocks(shmem_default_bsize()))
 		seq_printf(seq, ",size=%luk",
 			sbinfo->max_blocks << (PAGE_SHIFT - 10));
 	if (sbinfo->max_inodes != shmem_default_max_inodes())
@@ -4105,7 +4107,7 @@ static int shmem_fill_super(struct super_block *sb, struct fs_context *fc)
 	 */
 	if (!(sb->s_flags & SB_KERNMOUNT)) {
 		if (!(ctx->seen & SHMEM_SEEN_BLOCKS))
-			ctx->blocks = shmem_default_max_blocks();
+			ctx->blocks = shmem_default_max_blocks(shmem_default_bsize());
 		if (!(ctx->seen & SHMEM_SEEN_INODES))
 			ctx->inodes = shmem_default_max_inodes();
 		if (!(ctx->seen & SHMEM_SEEN_INUMS))
-- 
2.39.2

