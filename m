Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 271707A084C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Sep 2023 17:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240649AbjINPAe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Sep 2023 11:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240640AbjINPAb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Sep 2023 11:00:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F2C61FC7;
        Thu, 14 Sep 2023 08:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=2ERUJARyhaXmh0gLnsbd3jYfQIo/z0Z13UimQ2AlYZ8=; b=UPC+2bkVu2mnbMUS8GEJgyK6eh
        SsXSBIpSVWRXB0Q7QmZ92d91VjbqvyQkB7NcgkzCdGgOzmt+k0ehzMEoPWfGXSr0SqAghFlAeaSeO
        IdYqeSL6uXTYhvVlMR0Zd9r/Y8mRBKW/JKlCMUfOgM26dn06qfCfB8O7vudRpcuOhLEvdjcv0YKee
        JGS2UtIZt72x48oZlUMdboUPBdgIyz/rzYKHZxGIuH3VJGURF/U+iZzm0r4g5Sj8PMwkXpRe95PnW
        WAYF3i718W6dAiyAVUVEtzlypGW+ziZt+2qbI8r3EVhspkhGmDVlk4PNGhDJJBXCEI7spA7P63UWV
        ULJg63Iw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qgnpG-003XOY-HN; Thu, 14 Sep 2023 15:00:14 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     akpm@linux-foundation.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Hui Zhu <teawater@antgroup.com>, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: [PATCH v2 8/8] buffer: Remove __getblk_gfp()
Date:   Thu, 14 Sep 2023 16:00:11 +0100
Message-Id: <20230914150011.843330-9-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230914150011.843330-1-willy@infradead.org>
References: <20230914150011.843330-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Inline it into __bread_gfp().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/buffer.c                 | 36 +++++++++++-------------------------
 include/linux/buffer_head.h |  2 --
 2 files changed, 11 insertions(+), 27 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 58546bfd8903..ad2526dd7cb4 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1420,9 +1420,6 @@ EXPORT_SYMBOL(__find_get_block);
  * @size: The size of buffer_heads for this @bdev.
  * @gfp: The memory allocation flags to use.
  *
- * In contrast to __getblk_gfp(), the @gfp flags must be all of the flags;
- * they are not augmented with the mapping's GFP flags.
- *
  * Return: The buffer head, or NULL if memory could not be allocated.
  */
 struct buffer_head *bdev_getblk(struct block_device *bdev, sector_t block,
@@ -1438,27 +1435,6 @@ struct buffer_head *bdev_getblk(struct block_device *bdev, sector_t block,
 }
 EXPORT_SYMBOL(bdev_getblk);
 
-/*
- * __getblk_gfp() will locate (and, if necessary, create) the buffer_head
- * which corresponds to the passed block_device, block and size. The
- * returned buffer has its reference count incremented.
- */
-struct buffer_head *
-__getblk_gfp(struct block_device *bdev, sector_t block,
-	     unsigned size, gfp_t gfp)
-{
-	gfp |= mapping_gfp_constraint(bdev->bd_inode->i_mapping, ~__GFP_FS);
-
-	/*
-	 * Prefer looping in the allocator rather than here, at least that
-	 * code knows what it's doing.
-	 */
-	gfp |= __GFP_NOFAIL;
-
-	return bdev_getblk(bdev, block, size, gfp);
-}
-EXPORT_SYMBOL(__getblk_gfp);
-
 /*
  * Do async read-ahead on a buffer..
  */
@@ -1490,7 +1466,17 @@ struct buffer_head *
 __bread_gfp(struct block_device *bdev, sector_t block,
 		   unsigned size, gfp_t gfp)
 {
-	struct buffer_head *bh = __getblk_gfp(bdev, block, size, gfp);
+	struct buffer_head *bh;
+
+	gfp |= mapping_gfp_constraint(bdev->bd_inode->i_mapping, ~__GFP_FS);
+
+	/*
+	 * Prefer looping in the allocator rather than here, at least that
+	 * code knows what it's doing.
+	 */
+	gfp |= __GFP_NOFAIL;
+
+	bh = bdev_getblk(bdev, block, size, gfp);
 
 	if (likely(bh) && !buffer_uptodate(bh))
 		bh = __bread_slow(bh);
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index 5372deef732e..5f9208c3fa73 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -226,8 +226,6 @@ struct buffer_head *__find_get_block(struct block_device *bdev, sector_t block,
 			unsigned size);
 struct buffer_head *bdev_getblk(struct block_device *bdev, sector_t block,
 		unsigned size, gfp_t gfp);
-struct buffer_head *__getblk_gfp(struct block_device *bdev, sector_t block,
-				  unsigned size, gfp_t gfp);
 void __brelse(struct buffer_head *);
 void __bforget(struct buffer_head *);
 void __breadahead(struct block_device *, sector_t block, unsigned int size);
-- 
2.40.1

