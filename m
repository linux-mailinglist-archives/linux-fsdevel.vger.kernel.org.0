Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ECC377941B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 18:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235132AbjHKQPw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 12:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235157AbjHKQPq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 12:15:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C582271E;
        Fri, 11 Aug 2023 09:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=vnCMJDHvrSrLNSZkcpfQR1Q0wFl30okMiQEpgzdx9ds=; b=USTOcRLnPKT38Z7UkKIopQ+evQ
        +U6mA6hybkvUu3vUq2cTEdn6mIS9VGPYYF5fvVdHBxkigAjcbpMI6X8tJgNnCvtGtRkqMAaalNA7E
        7nCFXGIl+jVu2RnbwmlODeDHQRBqw7M+VjNfBXRCqj4M8gbC+p4HY7E0t51umne9y9jiTyfLCm3S8
        +hekBh7O12rkJsxZ6bsasm1Ctz+kl1ZP539DmEfEStQ8zAATDW6HRh0rbDT04l8moQE/EtKCqX56b
        k4sk6igMuKis+SGUSMjhkbcpM1DOf4xXwvVlQ7FkQQZQN4y8eXOedNeQHu8xkEi5NvkJ24x43q1hz
        2x+TJIsQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qUUnT-0027kY-2q; Fri, 11 Aug 2023 16:15:31 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     akpm@linux-foundation.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Hui Zhu <teawater@antgroup.com>, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: [PATCH 2/3] buffer: Hoist GFP flags from grow_dev_page() to __getblk_gfp()
Date:   Fri, 11 Aug 2023 17:15:27 +0100
Message-Id: <20230811161528.506437-3-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230811161528.506437-1-willy@infradead.org>
References: <20230811161528.506437-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

grow_dev_page() is only called by grow_buffers().  grow_buffers()
is only called by __getblk_slow() and __getblk_slow() is only called
from __getblk_gfp(), so it is safe to move the GFP flags setting
all the way up.  With that done, add a new bdev_getblk() entry point
that leaves the GFP flags the way the caller specified them.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/buffer.c                 | 60 ++++++++++++++++++++++++-------------
 include/linux/buffer_head.h |  2 ++
 2 files changed, 41 insertions(+), 21 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 7326acc29541..122b7d16befb 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1048,20 +1048,11 @@ grow_dev_page(struct block_device *bdev, sector_t block,
 	struct buffer_head *bh;
 	sector_t end_block;
 	int ret = 0;
-	gfp_t gfp_mask;
-
-	gfp_mask = mapping_gfp_constraint(inode->i_mapping, ~__GFP_FS) | gfp;
-
-	/*
-	 * XXX: __getblk_slow() can not really deal with failure and
-	 * will endlessly loop on improvised global reclaim.  Prefer
-	 * looping in the allocator rather than here, at least that
-	 * code knows what it's doing.
-	 */
-	gfp_mask |= __GFP_NOFAIL;
 
 	folio = __filemap_get_folio(inode->i_mapping, index,
-			FGP_LOCK | FGP_ACCESSED | FGP_CREAT, gfp_mask);
+			FGP_LOCK | FGP_ACCESSED | FGP_CREAT, gfp);
+	if (IS_ERR(folio))
+		return PTR_ERR(folio);
 
 	bh = folio_buffers(folio);
 	if (bh) {
@@ -1074,7 +1065,9 @@ grow_dev_page(struct block_device *bdev, sector_t block,
 			goto failed;
 	}
 
-	bh = folio_alloc_buffers(folio, size, gfp_mask);
+	bh = folio_alloc_buffers(folio, size, gfp);
+	if (!bh)
+		goto failed;
 
 	/*
 	 * Link the folio to the buffers and initialise them.  Take the
@@ -1426,24 +1419,49 @@ __find_get_block(struct block_device *bdev, sector_t block, unsigned size)
 }
 EXPORT_SYMBOL(__find_get_block);
 
+/**
+ * bdev_getblk - Get a buffer_head in a block device's buffer cache.
+ * @bdev: The block device.
+ * @block: The block number.
+ * @size: The size of buffer_heads for this @bdev.
+ * @gfp: The memory allocation flags to use.
+ *
+ * In contrast to __getblk_gfp(), the @gfp flags must be all of the flags;
+ * they are not augmented with the mapping's GFP flags.
+ *
+ * Return: The buffer head, or NULL if memory could not be allocated.
+ */
+struct buffer_head *bdev_getblk(struct block_device *bdev, sector_t block,
+		unsigned size, gfp_t gfp)
+{
+	struct buffer_head *bh = __find_get_block(bdev, block, size);
+
+	might_alloc(gfp);
+	if (bh)
+		return bh;
+
+	return __getblk_slow(bdev, block, size, gfp);
+}
+EXPORT_SYMBOL(bdev_getblk);
+
 /*
  * __getblk_gfp() will locate (and, if necessary, create) the buffer_head
  * which corresponds to the passed block_device, block and size. The
  * returned buffer has its reference count incremented.
- *
- * __getblk_gfp() will lock up the machine if grow_dev_page's
- * try_to_free_buffers() attempt is failing.  FIXME, perhaps?
  */
 struct buffer_head *
 __getblk_gfp(struct block_device *bdev, sector_t block,
 	     unsigned size, gfp_t gfp)
 {
-	struct buffer_head *bh = __find_get_block(bdev, block, size);
+	gfp |= mapping_gfp_constraint(bdev->bd_inode->i_mapping, ~__GFP_FS);
 
-	might_sleep();
-	if (bh == NULL)
-		bh = __getblk_slow(bdev, block, size, gfp);
-	return bh;
+	/*
+	 * Prefer looping in the allocator rather than here, at least that
+	 * code knows what it's doing.
+	 */
+	gfp |= __GFP_NOFAIL;
+
+	return bdev_getblk(bdev, block, size, gfp);
 }
 EXPORT_SYMBOL(__getblk_gfp);
 
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index d17efb8b7976..01110db9213c 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -233,6 +233,8 @@ void __wait_on_buffer(struct buffer_head *);
 wait_queue_head_t *bh_waitq_head(struct buffer_head *bh);
 struct buffer_head *__find_get_block(struct block_device *bdev, sector_t block,
 			unsigned size);
+struct buffer_head *bdev_getblk(struct block_device *bdev, sector_t block,
+		unsigned size, gfp_t gfp);
 struct buffer_head *__getblk_gfp(struct block_device *bdev, sector_t block,
 				  unsigned size, gfp_t gfp);
 void __brelse(struct buffer_head *);
-- 
2.40.1

