Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40D007787F5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 09:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233669AbjHKHPz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 03:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233755AbjHKHPq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 03:15:46 -0400
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F00A35B6;
        Fri, 11 Aug 2023 00:15:33 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=teawaterz@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0VpWb30T_1691738121;
Received: from i85c04085.eu95sqa.tbsite.net(mailfrom:teawaterz@linux.alibaba.com fp:SMTPD_---0VpWb30T_1691738121)
          by smtp.aliyun-inc.com;
          Fri, 11 Aug 2023 15:15:28 +0800
From:   Hui Zhu <teawaterz@linux.alibaba.com>
To:     viro@zeniv.linux.org.uk, brauner@kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, akpm@linux-foundation.org, jack@suse.cz,
        willy@infradead.org, yi.zhang@huawei.com, hare@suse.de,
        p.raghav@samsung.com, ritesh.list@gmail.com, mpatocka@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
Cc:     teawater@antgroup.com, teawater@gmail.com
Subject: [PATCH] ext4_sb_breadahead_unmovable: Change to be no-blocking
Date:   Fri, 11 Aug 2023 07:15:19 +0000
Message-Id: <20230811071519.1094-1-teawaterz@linux.alibaba.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Hui Zhu <teawater@antgroup.com>

This version fix the gfp flags in the callers instead of working this
new "bool" flag through the buffer head layers according to the comments
from Matthew Wilcox.

Encountered an issue where a large number of filesystem reads and writes
occurred suddenly within a container.  At the same time, other tasks on
the same host that were performing filesystem read and write operations
became blocked.  It was observed that many of the blocked tasks were
blocked on the ext4 journal lock. For example:
PID: 171453 TASK: ffff926566c9440 CPU: 54 COMMAND: "Thread"
0 [] __schedule at xxxxxxxxxxxxxxx
1 [] schedule at xxxxxxxxxxxxxxx
2 [] wait_transaction_locked at xxxxxxxxxxxxxxx
3 [] add_transaction_credits at xxxxxxxxxxxxxxx
4 [] start_this_handle at xxxxxxxxxxxxxxx
5 [] jbd2__journal_start at xxxxxxxxxxxxxxx
6 [] ext4_journal_start_sb at xxxxxxxxxxxxxxx
7 [] ext4_dirty_inode at xxxxxxxxxxxxxxx
8 [] mark_inode_dirty at xxxxxxxxxxxxxxx
9 [] generic_update_time at xxxxxxxxxxxxxxx

Meanwhile, it was observed that the task holding the ext4 journal lock
was blocked for an extended period of time on "shrink_page_list" due to
"ext4_sb_breadahead_unmovable".
0 [] __schedule at xxxxxxxxxxxxxxx
1 [] _cond_resched at xxxxxxxxxxxxxxx
2 [] shrink_page_list at xxxxxxxxxxxxxxx
3 [] shrink_inactive_list at xxxxxxxxxxxxxxx
4 [] shrink_lruvec at xxxxxxxxxxxxxxx
5 [] shrink_node_memcgs at xxxxxxxxxxxxxxx
6 [] shrink_node at xxxxxxxxxxxxxxx
7 [] shrink_zones at xxxxxxxxxxxxxxx
8 [] do_try_to_free_pages at xxxxxxxxxxxxxxx
9 [] try_to_free_mem_cgroup_pages at xxxxxxxxxxxxxxx
10 [] try_charge at xxxxxxxxxxxxxxx
11 [] mem_cgroup_charge at xxxxxxxxxxxxxxx
12 [] __add_to_page_cache_locked at xxxxxxxxxxxxxxx
13 [] add_to_page_cache_lru at xxxxxxxxxxxxxxx
14 [] pagecache_get_page at xxxxxxxxxxxxxxx
15 [] grow_dev_page at xxxxxxxxxxxxxxx
16 [] __getblk_slow at xxxxxxxxxxxxxxx
17 [] ext4_sb_breadahead_unmovable at xxxxxxxxxxxxxxx
18 [] __ext4_get_inode_loc at xxxxxxxxxxxxxxx
19 [] ext4_get_inode_loc at xxxxxxxxxxxxxxx
20 [] ext4_reserve_inode_write at xxxxxxxxxxxxxxx
21 [] __ext4_mark_inode_dirty at xxxxxxxxxxxxxxx
22 [] add_dirent_to_buf at xxxxxxxxxxxxxxx
23 [] ext4_add_entry at xxxxxxxxxxxxxxx
24 [] ext4_add_nondir at xxxxxxxxxxxxxxx
25 [] ext4_create at xxxxxxxxxxxxxxx
26 [] vfs_create at xxxxxxxxxxxxxxx

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
non-blocking.
Change gfp to ~__GFP_DIRECT_RECLAIM when ext4_sb_breadahead_unmovable
calls sb_getblk_gfp.
Modify grow_dev_page to will not be blocked by the allocation of folio
if gfp is ~__GFP_DIRECT_RECLAIM.

Signed-off-by: Hui Zhu <teawater@antgroup.com>
---
 fs/buffer.c     | 27 +++++++++++++++++++--------
 fs/ext4/super.c |  3 ++-
 2 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index bd091329026c..330cf19c77b1 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1038,6 +1038,7 @@ static sector_t folio_init_buffers(struct folio *folio,
  * Create the page-cache page that contains the requested block.
  *
  * This is used purely for blockdev mappings.
+ * Will not blocking by allocate folio if gfp is ~__GFP_DIRECT_RECLAIM.
  */
 static int
 grow_dev_page(struct block_device *bdev, sector_t block,
@@ -1050,18 +1051,27 @@ grow_dev_page(struct block_device *bdev, sector_t block,
 	int ret = 0;
 	gfp_t gfp_mask;
 
-	gfp_mask = mapping_gfp_constraint(inode->i_mapping, ~__GFP_FS) | gfp;
+	gfp_mask = mapping_gfp_constraint(inode->i_mapping, ~__GFP_FS);
+	if (gfp == ~__GFP_DIRECT_RECLAIM)
+		gfp_mask &= ~__GFP_DIRECT_RECLAIM;
+	else {
+		gfp_mask |= gfp;
 
-	/*
-	 * XXX: __getblk_slow() can not really deal with failure and
-	 * will endlessly loop on improvised global reclaim.  Prefer
-	 * looping in the allocator rather than here, at least that
-	 * code knows what it's doing.
-	 */
-	gfp_mask |= __GFP_NOFAIL;
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
@@ -1091,6 +1101,7 @@ grow_dev_page(struct block_device *bdev, sector_t block,
 failed:
 	folio_unlock(folio);
 	folio_put(folio);
+out:
 	return ret;
 }
 
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index c94ebf704616..6a529509b83b 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -254,7 +254,8 @@ struct buffer_head *ext4_sb_bread_unmovable(struct super_block *sb,
 
 void ext4_sb_breadahead_unmovable(struct super_block *sb, sector_t block)
 {
-	struct buffer_head *bh = sb_getblk_gfp(sb, block, 0);
+	struct buffer_head *bh = sb_getblk_gfp(sb, block,
+					       ~__GFP_DIRECT_RECLAIM);
 
 	if (likely(bh)) {
 		if (trylock_buffer(bh))
-- 
2.19.1.6.gb485710b

