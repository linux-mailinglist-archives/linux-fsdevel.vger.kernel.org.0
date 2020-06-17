Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D534E1FCCE8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jun 2020 13:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbgFQL6r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Jun 2020 07:58:47 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6352 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726494AbgFQL6p (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Jun 2020 07:58:45 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 839C8821DED86C1DCC9C;
        Wed, 17 Jun 2020 19:58:41 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Wed, 17 Jun 2020
 19:58:34 +0800
From:   "zhangyi (F)" <yi.zhang@huawei.com>
To:     <linux-ext4@vger.kernel.org>, <tytso@mit.edu>, <jack@suse.cz>
CC:     <adilger.kernel@dilger.ca>, <zhangxiaoxu5@huawei.com>,
        <yi.zhang@huawei.com>, <linux-fsdevel@vger.kernel.org>
Subject: [PATCH v2 2/5] ext4: mark filesystem error if failed to async write metadata
Date:   Wed, 17 Jun 2020 19:59:44 +0800
Message-ID: <20200617115947.836221-3-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200617115947.836221-1-yi.zhang@huawei.com>
References: <20200617115947.836221-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There is a risk of filesystem inconsistency if we failed to async write
back metadata buffer in the background. Because of current buffer's end
io procedure is handled by end_buffer_async_write() in the block layer,
and it only clear the buffer's uptodate flag and mark the write_io_error
flag, so ext4 cannot detect such failure immediately. In most cases of
getting metadata buffer (e.g. ext4_read_inode_bitmap()), although the
buffer's data is actually uptodate, it may still read data from disk
because the buffer's uptodate flag has been cleared. Finally, it may
lead to on-disk filesystem inconsistency if reading old data from the
disk successfully and write them out again.

This patch propagate ext4 end buffer callback to the block layer which
could detect metadata buffer's async error and invoke ext4 error handler
immediately.

Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
---
 fs/ext4/ext4.h    |  7 +++++++
 fs/ext4/page-io.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 fs/ext4/super.c   | 13 +++++++++++++
 3 files changed, 67 insertions(+)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 15b062efcff1..2f22476f41d2 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1515,6 +1515,10 @@ struct ext4_sb_info {
 	/* workqueue for reserved extent conversions (buffered io) */
 	struct workqueue_struct *rsv_conversion_wq;
 
+	/* workqueue for handle metadata buffer async writeback error */
+	struct workqueue_struct *s_bdev_wb_err_wq;
+	struct work_struct s_bdev_wb_err_work;
+
 	/* timer for periodic error stats printing */
 	struct timer_list s_err_report;
 
@@ -3426,6 +3430,9 @@ extern int ext4_bio_write_page(struct ext4_io_submit *io,
 			       bool keep_towrite);
 extern struct ext4_io_end_vec *ext4_alloc_io_end_vec(ext4_io_end_t *io_end);
 extern struct ext4_io_end_vec *ext4_last_io_end_vec(ext4_io_end_t *io_end);
+extern void ext4_end_buffer_async_write_error(struct work_struct *work);
+extern int ext4_bdev_write_page(struct page *page, get_block_t *get_block,
+				struct writeback_control *wbc);
 
 /* mmp.c */
 extern int ext4_multi_mount_protect(struct super_block *, ext4_fsblk_t);
diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
index de6fe969f773..50aa8e26e38c 100644
--- a/fs/ext4/page-io.c
+++ b/fs/ext4/page-io.c
@@ -560,3 +560,50 @@ int ext4_bio_write_page(struct ext4_io_submit *io,
 		end_page_writeback(page);
 	return ret;
 }
+
+/*
+ * Handle error of async writeback metadata buffer, just mark the filesystem
+ * error to prevent potential further inconsistency.
+ */
+void ext4_end_buffer_async_write_error(struct work_struct *work)
+{
+	struct ext4_sb_info *sbi = container_of(work,
+				struct ext4_sb_info, s_bdev_wb_err_work);
+
+	/*
+	 * If we failed to async write back metadata buffer, there is a risk
+	 * of filesystem inconsistency since we may read old metadata from the
+	 * disk successfully and write them out again.
+	 */
+	ext4_error_err(sbi->s_sb, -EIO, "Error while async write back metadata buffer");
+}
+
+static void ext4_end_buffer_async_write(struct buffer_head *bh, int uptodate)
+{
+	struct super_block *sb = bh->b_bdev->bd_super;
+
+	end_buffer_async_write(bh, uptodate);
+
+	if (!uptodate && sb && !sb_rdonly(sb)) {
+		struct ext4_sb_info *sbi = EXT4_SB(sb);
+
+		/* Handle error of async writeback metadata buffer */
+		queue_work(sbi->s_bdev_wb_err_wq, &sbi->s_bdev_wb_err_work);
+	}
+}
+
+int ext4_bdev_write_page(struct page *page, get_block_t *get_block,
+			 struct writeback_control *wbc)
+{
+	struct inode * const inode = page->mapping->host;
+	loff_t i_size = i_size_read(inode);
+	const pgoff_t end_index = i_size >> PAGE_SHIFT;
+	unsigned int offset;
+
+	offset = i_size & ~PAGE_MASK;
+	if (page->index == end_index && offset)
+		zero_user_segment(page, offset, PAGE_SIZE);
+
+	return __block_write_full_page(inode, page, get_block,
+				       wbc, ext4_end_buffer_async_write);
+}
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 9824cd8203e8..f04b161a64a0 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1013,6 +1013,7 @@ static void ext4_put_super(struct super_block *sb)
 	ext4_quota_off_umount(sb);
 
 	destroy_workqueue(sbi->rsv_conversion_wq);
+	destroy_workqueue(sbi->s_bdev_wb_err_wq);
 
 	/*
 	 * Unregister sysfs before destroying jbd2 journal.
@@ -1492,6 +1493,7 @@ static const struct super_operations ext4_sops = {
 	.get_dquots	= ext4_get_dquots,
 #endif
 	.bdev_try_to_free_page = bdev_try_to_free_page,
+	.bdev_write_page = ext4_bdev_write_page,
 };
 
 static const struct export_operations ext4_export_ops = {
@@ -4598,6 +4600,15 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 		goto failed_mount4;
 	}
 
+	EXT4_SB(sb)->s_bdev_wb_err_wq =
+		alloc_workqueue("ext4-bdev-write-error", WQ_MEM_RECLAIM | WQ_UNBOUND, 1);
+	if (!EXT4_SB(sb)->s_bdev_wb_err_wq) {
+		ext4_msg(sb, KERN_ERR, "failed to create workqueue\n");
+		ret = -ENOMEM;
+		goto failed_mount4;
+	}
+	INIT_WORK(&EXT4_SB(sb)->s_bdev_wb_err_work, ext4_end_buffer_async_write_error);
+
 	/*
 	 * The jbd2_journal_load will have done any necessary log recovery,
 	 * so we can safely mount the rest of the filesystem now.
@@ -4781,6 +4792,8 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 	sb->s_root = NULL;
 failed_mount4:
 	ext4_msg(sb, KERN_ERR, "mount failed");
+	if (EXT4_SB(sb)->s_bdev_wb_err_wq)
+		destroy_workqueue(EXT4_SB(sb)->s_bdev_wb_err_wq);
 	if (EXT4_SB(sb)->rsv_conversion_wq)
 		destroy_workqueue(EXT4_SB(sb)->rsv_conversion_wq);
 failed_mount_wq:
-- 
2.25.4

