Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2CA778650
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 05:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233360AbjHKD52 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Aug 2023 23:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjHKD51 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Aug 2023 23:57:27 -0400
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16EE2D78;
        Thu, 10 Aug 2023 20:57:24 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=teawaterz@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0VpVosIR_1691726232;
Received: from i85c04085.eu95sqa.tbsite.net(mailfrom:teawaterz@linux.alibaba.com fp:SMTPD_---0VpVosIR_1691726232)
          by smtp.aliyun-inc.com;
          Fri, 11 Aug 2023 11:57:19 +0800
From:   Hui Zhu <teawaterz@linux.alibaba.com>
To:     viro@zeniv.linux.org.uk, brauner@kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, akpm@linux-foundation.org, jack@suse.cz,
        willy@infradead.org, yi.zhang@huawei.com, hare@suse.de,
        p.raghav@samsung.com, ritesh.list@gmail.com, mpatocka@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
Cc:     teawater@antgroup.com, teawater@gmail.com
Subject: [PATCH] ext4_sb_breadahead_unmovable: Change to be no-blocking
Date:   Fri, 11 Aug 2023 03:57:05 +0000
Message-Id: <20230811035705.3296-1-teawaterz@linux.alibaba.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Hui Zhu <teawater@antgroup.com>

Encountered an issue where a large number of filesystem reads and writes
occurred suddenly within a container.  At the same time, other tasks on
the same host that were performing filesystem read and write operations
became blocked.  It was observed that many of the blocked tasks were
blocked on the ext4 journal lock. For example:
PID: 171453 TASK: ffff926566c9440 CPU: 54 COMMAND: "Thread"

Meanwhile, it was observed that the task holding the ext4 journal lock
was blocked for an extended period of time on "shrink_page_list" due to
"ext4_sb_breadahead_unmovable".

The function "grow_dev_page" increased the gfp mask with "__GFP_NOFAIL",
causing longer blocking times.
	/*
	 * XXX: __getblk_slow() can not really deal with failure and
	 * will endlessly loop on improvised global reclaim.  Prefer
	 * looping in the allocator rather than here, at least that
	 * code knows what it's doing.
	 */
	gfp_mask |= __GFP_NOFAIL;
However, "ext4_sb_breadahead_unmovable" is a prefetch function and
failures are acceptable.

Therefore, this commit changes "ext4_sb_breadahead_unmovable" to be
non-blocking, removing "__GFP_DIRECT_RECLAIM" from the gfp mask in the
"grow_dev_page" function if caller is ext4_sb_breadahead_unmovable to
alleviate memory-related blocking issues.

Signed-off-by: Hui Zhu <teawater@antgroup.com>
---
 fs/buffer.c                 | 41 +++++++++++++++++++++++--------------
 fs/ext4/super.c             |  2 +-
 include/linux/buffer_head.h | 17 ++++++++++-----
 3 files changed, 39 insertions(+), 21 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index bd091329026c..1086da366392 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1041,7 +1041,7 @@ static sector_t folio_init_buffers(struct folio *folio,
  */
 static int
 grow_dev_page(struct block_device *bdev, sector_t block,
-	      pgoff_t index, int size, int sizebits, gfp_t gfp)
+	      pgoff_t index, int size, int sizebits, gfp_t gfp, bool noblocking)
 {
 	struct inode *inode = bdev->bd_inode;
 	struct folio *folio;
@@ -1052,16 +1052,24 @@ grow_dev_page(struct block_device *bdev, sector_t block,
 
 	gfp_mask = mapping_gfp_constraint(inode->i_mapping, ~__GFP_FS) | gfp;
 
-	/*
-	 * XXX: __getblk_slow() can not really deal with failure and
-	 * will endlessly loop on improvised global reclaim.  Prefer
-	 * looping in the allocator rather than here, at least that
-	 * code knows what it's doing.
-	 */
-	gfp_mask |= __GFP_NOFAIL;
+	if (noblocking)
+		gfp_mask &= ~__GFP_DIRECT_RECLAIM;
+	else {
+		/*
+		 * XXX: __getblk_slow() can not really deal with failure and
+		 * will endlessly loop on improvised global reclaim.  Prefer
+		 * looping in the allocator rather than here, at least that
+		 * code knows what it's doing.
+		 */
+		gfp_mask |= __GFP_NOFAIL;
+	}
 
 	folio = __filemap_get_folio(inode->i_mapping, index,
 			FGP_LOCK | FGP_ACCESSED | FGP_CREAT, gfp_mask);
+	if (IS_ERR(folio)) {
+		ret = PTR_ERR(folio);
+		goto out;
+	}
 
 	bh = folio_buffers(folio);
 	if (bh) {
@@ -1091,6 +1099,7 @@ grow_dev_page(struct block_device *bdev, sector_t block,
 failed:
 	folio_unlock(folio);
 	folio_put(folio);
+out:
 	return ret;
 }
 
@@ -1099,7 +1108,8 @@ grow_dev_page(struct block_device *bdev, sector_t block,
  * that page was dirty, the buffers are set dirty also.
  */
 static int
-grow_buffers(struct block_device *bdev, sector_t block, int size, gfp_t gfp)
+grow_buffers(struct block_device *bdev, sector_t block, int size, gfp_t gfp,
+	     bool noblocking)
 {
 	pgoff_t index;
 	int sizebits;
@@ -1120,12 +1130,13 @@ grow_buffers(struct block_device *bdev, sector_t block, int size, gfp_t gfp)
 	}
 
 	/* Create a page with the proper size buffers.. */
-	return grow_dev_page(bdev, block, index, size, sizebits, gfp);
+	return grow_dev_page(bdev, block, index, size, sizebits, gfp,
+			     noblocking);
 }
 
 static struct buffer_head *
 __getblk_slow(struct block_device *bdev, sector_t block,
-	     unsigned size, gfp_t gfp)
+	      unsigned size, gfp_t gfp, bool noblocking)
 {
 	/* Size must be multiple of hard sectorsize */
 	if (unlikely(size & (bdev_logical_block_size(bdev)-1) ||
@@ -1147,7 +1158,7 @@ __getblk_slow(struct block_device *bdev, sector_t block,
 		if (bh)
 			return bh;
 
-		ret = grow_buffers(bdev, block, size, gfp);
+		ret = grow_buffers(bdev, block, size, gfp, noblocking);
 		if (ret < 0)
 			return NULL;
 	}
@@ -1436,13 +1447,13 @@ EXPORT_SYMBOL(__find_get_block);
  */
 struct buffer_head *
 __getblk_gfp(struct block_device *bdev, sector_t block,
-	     unsigned size, gfp_t gfp)
+	     unsigned size, gfp_t gfp, bool noblocking)
 {
 	struct buffer_head *bh = __find_get_block(bdev, block, size);
 
 	might_sleep();
 	if (bh == NULL)
-		bh = __getblk_slow(bdev, block, size, gfp);
+		bh = __getblk_slow(bdev, block, size, gfp, noblocking);
 	return bh;
 }
 EXPORT_SYMBOL(__getblk_gfp);
@@ -1476,7 +1487,7 @@ struct buffer_head *
 __bread_gfp(struct block_device *bdev, sector_t block,
 		   unsigned size, gfp_t gfp)
 {
-	struct buffer_head *bh = __getblk_gfp(bdev, block, size, gfp);
+	struct buffer_head *bh = __getblk_gfp(bdev, block, size, gfp, false);
 
 	if (likely(bh) && !buffer_uptodate(bh))
 		bh = __bread_slow(bh);
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index c94ebf704616..d13b6f5c21eb 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -254,7 +254,7 @@ struct buffer_head *ext4_sb_bread_unmovable(struct super_block *sb,
 
 void ext4_sb_breadahead_unmovable(struct super_block *sb, sector_t block)
 {
-	struct buffer_head *bh = sb_getblk_gfp(sb, block, 0);
+	struct buffer_head *bh = sb_getblk_noblocking(sb, block);
 
 	if (likely(bh)) {
 		if (trylock_buffer(bh))
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index 6cb3e9af78c9..50cb0cc81962 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -234,7 +234,7 @@ wait_queue_head_t *bh_waitq_head(struct buffer_head *bh);
 struct buffer_head *__find_get_block(struct block_device *bdev, sector_t block,
 			unsigned size);
 struct buffer_head *__getblk_gfp(struct block_device *bdev, sector_t block,
-				  unsigned size, gfp_t gfp);
+				  unsigned size, gfp_t gfp, bool noblocking);
 void __brelse(struct buffer_head *);
 void __bforget(struct buffer_head *);
 void __breadahead(struct block_device *, sector_t block, unsigned int size);
@@ -363,17 +363,24 @@ sb_breadahead(struct super_block *sb, sector_t block)
 	__breadahead(sb->s_bdev, block, sb->s_blocksize);
 }
 
+static inline struct buffer_head *
+sb_getblk_noblocking(struct super_block *sb, sector_t block)
+{
+	return __getblk_gfp(sb->s_bdev, block, sb->s_blocksize, 0, true);
+}
+
 static inline struct buffer_head *
 sb_getblk(struct super_block *sb, sector_t block)
 {
-	return __getblk_gfp(sb->s_bdev, block, sb->s_blocksize, __GFP_MOVABLE);
+	return __getblk_gfp(sb->s_bdev, block, sb->s_blocksize, __GFP_MOVABLE,
+			    false);
 }
 
 
 static inline struct buffer_head *
 sb_getblk_gfp(struct super_block *sb, sector_t block, gfp_t gfp)
 {
-	return __getblk_gfp(sb->s_bdev, block, sb->s_blocksize, gfp);
+	return __getblk_gfp(sb->s_bdev, block, sb->s_blocksize, gfp, false);
 }
 
 static inline struct buffer_head *
@@ -414,14 +421,14 @@ static inline struct buffer_head *getblk_unmovable(struct block_device *bdev,
 						   sector_t block,
 						   unsigned size)
 {
-	return __getblk_gfp(bdev, block, size, 0);
+	return __getblk_gfp(bdev, block, size, 0, false);
 }
 
 static inline struct buffer_head *__getblk(struct block_device *bdev,
 					   sector_t block,
 					   unsigned size)
 {
-	return __getblk_gfp(bdev, block, size, __GFP_MOVABLE);
+	return __getblk_gfp(bdev, block, size, __GFP_MOVABLE, false);
 }
 
 static inline void bh_readahead(struct buffer_head *bh, blk_opf_t op_flags)
-- 
2.19.1.6.gb485710b

