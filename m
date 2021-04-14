Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5B135F502
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Apr 2021 15:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351438AbhDNNkG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Apr 2021 09:40:06 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:16914 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351417AbhDNNkD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Apr 2021 09:40:03 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FL3SV03CtzjZRZ;
        Wed, 14 Apr 2021 21:37:46 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.498.0; Wed, 14 Apr 2021
 21:39:30 +0800
From:   Zhang Yi <yi.zhang@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <linux-fsdevel@vger.kernel.org>, <tytso@mit.edu>,
        <adilger.kernel@dilger.ca>, <jack@suse.cz>, <yi.zhang@huawei.com>,
        <yukuai3@huawei.com>
Subject: [RFC PATCH v2 7/7] ext4: fix race between blkdev_releasepage() and ext4_put_super()
Date:   Wed, 14 Apr 2021 21:47:37 +0800
Message-ID: <20210414134737.2366971-8-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210414134737.2366971-1-yi.zhang@huawei.com>
References: <20210414134737.2366971-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There still exist a use after free issue when accessing the journal
structure and ext4_sb_info structure on freeing bdev buffers in
bdev_try_to_free_page(). The problem is bdev_try_to_free_page() could be
raced by ext4_put_super(), it dose freeing sb->s_fs_info and
sbi->s_journal while release page progress are still accessing them.
So it could end up trigger use-after-free or NULL pointer dereference.

drop cache                           umount filesystem
blkdev_releasepage()
 get sb
 bdev_try_to_free_page()             ext4_put_super()
                                      kfree(journal)
  if access EXT4_SB(sb)->s_journal  <-- leader to use after free
                                      sb->s_fs_info = NULL;
                                      kfree(sbi)
  if access EXT4_SB(sb)->s_journal  <-- trigger NULL pointer dereference

The above race could also happens on the error path of
ext4_fill_super(). Now the bdev_try_to_free_page() is under RCU
protection, this patch fix this race by use sb->s_usage_counter to
make bdev_try_to_free_page() safe against concurrent kill_block_super().

Fixes: c39a7f84d784 ("ext4: provide function to release metadata pages under memory pressure")
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/super.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 55c7a0d8d77d..14eedd8e5bd3 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1172,6 +1172,12 @@ static void ext4_put_super(struct super_block *sb)
 	 */
 	ext4_unregister_sysfs(sb);
 
+	/*
+	 * Prevent racing with bdev_try_to_free_page() access the sbi and
+	 * journal concurrently.
+	 */
+	sb_usage_counter_wait(sb);
+
 	if (sbi->s_journal) {
 		aborted = is_journal_aborted(sbi->s_journal);
 		err = jbd2_journal_destroy(sbi->s_journal);
@@ -1248,6 +1254,7 @@ static void ext4_put_super(struct super_block *sb)
 		kthread_stop(sbi->s_mmp_tsk);
 	brelse(sbi->s_sbh);
 	sb->s_fs_info = NULL;
+	percpu_ref_exit(&sb->s_usage_counter);
 	/*
 	 * Now that we are completely done shutting down the
 	 * superblock, we need to actually destroy the kobject.
@@ -1450,15 +1457,22 @@ static int ext4_nfs_commit_metadata(struct inode *inode)
 static int bdev_try_to_free_page(struct super_block *sb, struct page *page,
 				 gfp_t wait)
 {
-	journal_t *journal = EXT4_SB(sb)->s_journal;
+	int ret = 0;
 
 	WARN_ON(PageChecked(page));
 	if (!page_has_buffers(page))
 		return 0;
-	if (journal)
-		return jbd2_journal_try_to_free_buffers(journal, page);
 
-	return 0;
+	/* Racing with umount filesystem concurrently? */
+	if (percpu_ref_tryget_live(&sb->s_usage_counter)) {
+		journal_t *journal = EXT4_SB(sb)->s_journal;
+
+		if (journal)
+			ret = jbd2_journal_try_to_free_buffers(journal, page);
+		percpu_ref_put(&sb->s_usage_counter);
+	}
+
+	return ret;
 }
 
 #ifdef CONFIG_FS_ENCRYPTION
@@ -4709,6 +4723,9 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 	spin_lock_init(&sbi->s_error_lock);
 	INIT_WORK(&sbi->s_error_work, flush_stashed_error_work);
 
+	if (sb_usage_counter_init(sb))
+		goto failed_mount2a;
+
 	/* Register extent status tree shrinker */
 	if (ext4_es_register_shrinker(sbi))
 		goto failed_mount3;
@@ -5148,6 +5165,8 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 	ext4_xattr_destroy_cache(sbi->s_ea_block_cache);
 	sbi->s_ea_block_cache = NULL;
 
+	sb->s_bdev->bd_super = NULL;
+	sb_usage_counter_wait(sb);
 	if (sbi->s_journal) {
 		jbd2_journal_destroy(sbi->s_journal);
 		sbi->s_journal = NULL;
@@ -5155,6 +5174,8 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 failed_mount3a:
 	ext4_es_unregister_shrinker(sbi);
 failed_mount3:
+	percpu_ref_exit(&sb->s_usage_counter);
+failed_mount2a:
 	flush_work(&sbi->s_error_work);
 	del_timer_sync(&sbi->s_err_report);
 	if (sbi->s_mmp_tsk)
-- 
2.25.4

