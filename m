Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E90D27A0845
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Sep 2023 17:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240583AbjINPAX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Sep 2023 11:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234000AbjINPAW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Sep 2023 11:00:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C481FC7;
        Thu, 14 Sep 2023 08:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=NroVptGAg7UiwR86yM/4X82UzTADz9yzrquSWsPuA2k=; b=SmWGmjfDia4E7tr7sB9PhfA+ZS
        Vn2edipEN9qDaa5zOx5zLu5H8Od4ezEpWXFWdUZtDME+2u18JqhxslFNB9CLCjR5Mlu1I7o33igGq
        rNBFqXPUV8q9SmXL6hFXl90DQ+n+yGPomR27vOuWXHhtLQH6lnao+/B/EN/jrF3cOBtaHTkLIx1NX
        bdM43qNUxRVCmFaBrLWG1zfWLwa0n3wMNL09UeTFxtKrIsRAyD4sZmcdS/i7DIDm4YOUr8uCFkimw
        YNXoxAABl+FciUZgO2JGj79eT2EAvIps+moLDmrhRfgB05Lo5DzkJEjPHSYdfH3SgV0HTcDkjI/av
        S+FhhH5g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qgnpG-003XOS-4w; Thu, 14 Sep 2023 15:00:14 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     akpm@linux-foundation.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Hui Zhu <teawater@antgroup.com>, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: [PATCH v2 5/8] buffer: Convert getblk_unmovable() and __getblk() to use bdev_getblk()
Date:   Thu, 14 Sep 2023 16:00:08 +0100
Message-Id: <20230914150011.843330-6-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230914150011.843330-1-willy@infradead.org>
References: <20230914150011.843330-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Move these two functions up in the file for the benefit of the next patch,
and pass in all of the GFP flags to use instead of the partial GFP flags
used by __getblk_gfp().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/buffer_head.h | 36 ++++++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index e389f0fbba5a..e92f604a423e 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -337,6 +337,28 @@ sb_breadahead(struct super_block *sb, sector_t block)
 	__breadahead(sb->s_bdev, block, sb->s_blocksize);
 }
 
+static inline struct buffer_head *getblk_unmovable(struct block_device *bdev,
+		sector_t block, unsigned size)
+{
+	gfp_t gfp;
+
+	gfp = mapping_gfp_constraint(bdev->bd_inode->i_mapping, ~__GFP_FS);
+	gfp |= __GFP_NOFAIL;
+
+	return bdev_getblk(bdev, block, size, gfp);
+}
+
+static inline struct buffer_head *__getblk(struct block_device *bdev,
+		sector_t block, unsigned size)
+{
+	gfp_t gfp;
+
+	gfp = mapping_gfp_constraint(bdev->bd_inode->i_mapping, ~__GFP_FS);
+	gfp |= __GFP_MOVABLE | __GFP_NOFAIL;
+
+	return bdev_getblk(bdev, block, size, gfp);
+}
+
 static inline struct buffer_head *
 sb_getblk(struct super_block *sb, sector_t block)
 {
@@ -384,20 +406,6 @@ static inline void lock_buffer(struct buffer_head *bh)
 		__lock_buffer(bh);
 }
 
-static inline struct buffer_head *getblk_unmovable(struct block_device *bdev,
-						   sector_t block,
-						   unsigned size)
-{
-	return __getblk_gfp(bdev, block, size, 0);
-}
-
-static inline struct buffer_head *__getblk(struct block_device *bdev,
-					   sector_t block,
-					   unsigned size)
-{
-	return __getblk_gfp(bdev, block, size, __GFP_MOVABLE);
-}
-
 static inline void bh_readahead(struct buffer_head *bh, blk_opf_t op_flags)
 {
 	if (!buffer_uptodate(bh) && trylock_buffer(bh)) {
-- 
2.40.1

