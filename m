Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94ECC1FCCE3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jun 2020 13:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbgFQL6o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Jun 2020 07:58:44 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6355 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726331AbgFQL6o (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Jun 2020 07:58:44 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 888448F7336F4E89B39A;
        Wed, 17 Jun 2020 19:58:41 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Wed, 17 Jun 2020
 19:58:34 +0800
From:   "zhangyi (F)" <yi.zhang@huawei.com>
To:     <linux-ext4@vger.kernel.org>, <tytso@mit.edu>, <jack@suse.cz>
CC:     <adilger.kernel@dilger.ca>, <zhangxiaoxu5@huawei.com>,
        <yi.zhang@huawei.com>, <linux-fsdevel@vger.kernel.org>
Subject: [PATCH v2 3/5] ext4: detect metadata async write error when getting journal's write access
Date:   Wed, 17 Jun 2020 19:59:45 +0800
Message-ID: <20200617115947.836221-4-yi.zhang@huawei.com>
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

Although we have already introduce s_bdev_wb_err_work to detect and
handle async write metadata buffer error as soon as possible, there is
still a potential race that could lead to filesystem inconsistency,
which is the buffer may reading and re-writing out to journal before
s_bdev_wb_err_work run. So this patch detect bdev mapping->wb_err when
getting journal's write access and also mark the filesystem error if
something bad happened.

Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
---
 fs/ext4/ext4.h      |  4 ++++
 fs/ext4/ext4_jbd2.c | 34 +++++++++++++++++++++++++++++-----
 fs/ext4/page-io.c   | 12 +++++++++++-
 fs/ext4/super.c     | 17 +++++++++++++++++
 4 files changed, 61 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 2f22476f41d2..82ae41a828dd 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1519,6 +1519,10 @@ struct ext4_sb_info {
 	struct workqueue_struct *s_bdev_wb_err_wq;
 	struct work_struct s_bdev_wb_err_work;
 
+	/* Record the errseq of the backing block device */
+	errseq_t s_bdev_wb_err;
+	spinlock_t s_bdev_wb_lock;
+
 	/* timer for periodic error stats printing */
 	struct timer_list s_err_report;
 
diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
index 0c76cdd44d90..66620324f019 100644
--- a/fs/ext4/ext4_jbd2.c
+++ b/fs/ext4/ext4_jbd2.c
@@ -198,16 +198,40 @@ static void ext4_journal_abort_handle(const char *caller, unsigned int line,
 int __ext4_journal_get_write_access(const char *where, unsigned int line,
 				    handle_t *handle, struct buffer_head *bh)
 {
+	struct super_block *sb = bh->b_bdev->bd_super;
 	int err = 0;
 
 	might_sleep();
 
-	if (ext4_handle_valid(handle)) {
-		err = jbd2_journal_get_write_access(handle, bh);
-		if (err)
-			ext4_journal_abort_handle(where, line, __func__, bh,
-						  handle, err);
+	/*
+	 * If the block device has write error flag, it may have failed to
+	 * async write out metadata buffers in the background but the error
+	 * handle worker hasn't been executed yet. In this case, we could
+	 * read old data from disk and write it out again, which may lead
+	 * to on-disk filesystem inconsistency.
+	 */
+	if (sb) {
+		struct address_space *mapping = sb->s_bdev->bd_inode->i_mapping;
+		struct ext4_sb_info *sbi = EXT4_SB(sb);
+
+		if (errseq_check(&mapping->wb_err, READ_ONCE(sbi->s_bdev_wb_err))) {
+			spin_lock(&sbi->s_bdev_wb_lock);
+			err = errseq_check_and_advance(&mapping->wb_err,
+						       &sbi->s_bdev_wb_err);
+			spin_unlock(&sbi->s_bdev_wb_lock);
+			if (err) {
+				ext4_error_err(sb, err,
+					       "Error while async write back metadata");
+				goto out;
+			}
+		}
 	}
+
+	if (ext4_handle_valid(handle))
+		err = jbd2_journal_get_write_access(handle, bh);
+out:
+	if (err)
+		ext4_journal_abort_handle(where, line, __func__, bh, handle, err);
 	return err;
 }
 
diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
index 50aa8e26e38c..b2c3da4be2aa 100644
--- a/fs/ext4/page-io.c
+++ b/fs/ext4/page-io.c
@@ -569,13 +569,23 @@ void ext4_end_buffer_async_write_error(struct work_struct *work)
 {
 	struct ext4_sb_info *sbi = container_of(work,
 				struct ext4_sb_info, s_bdev_wb_err_work);
+	struct address_space *mapping = sbi->s_sb->s_bdev->bd_inode->i_mapping;
+	int err;
 
 	/*
 	 * If we failed to async write back metadata buffer, there is a risk
 	 * of filesystem inconsistency since we may read old metadata from the
 	 * disk successfully and write them out again.
 	 */
-	ext4_error_err(sbi->s_sb, -EIO, "Error while async write back metadata buffer");
+	if (errseq_check(&mapping->wb_err, READ_ONCE(sbi->s_bdev_wb_err))) {
+		spin_lock(&sbi->s_bdev_wb_lock);
+		err = errseq_check_and_advance(&mapping->wb_err,
+					       &sbi->s_bdev_wb_err);
+		spin_unlock(&sbi->s_bdev_wb_lock);
+		if (err)
+			ext4_error_err(sbi->s_sb, -EIO,
+				       "Error while async write back metadata buffer");
+	}
 }
 
 static void ext4_end_buffer_async_write(struct buffer_head *bh, int uptodate)
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index f04b161a64a0..3e867ff452cd 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -4715,6 +4715,15 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 	}
 #endif  /* CONFIG_QUOTA */
 
+	/*
+	 * Save the original bdev mapping's wb_err value which could be
+	 * used to detect the metadata async write error.
+	 */
+	spin_lock_init(&sbi->s_bdev_wb_lock);
+	if (!sb_rdonly(sb))
+		errseq_check_and_advance(&sb->s_bdev->bd_inode->i_mapping->wb_err,
+					 &sbi->s_bdev_wb_err);
+	sb->s_bdev->bd_super = sb;
 	EXT4_SB(sb)->s_mount_state |= EXT4_ORPHAN_FS;
 	ext4_orphan_cleanup(sb, es);
 	EXT4_SB(sb)->s_mount_state &= ~EXT4_ORPHAN_FS;
@@ -5580,6 +5589,14 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
 				goto restore_opts;
 			}
 
+			/*
+			 * Update the original bdev mapping's wb_err value
+			 * which could be used to detect the metadata async
+			 * write error.
+			 */
+			errseq_check_and_advance(&sb->s_bdev->bd_inode->i_mapping->wb_err,
+						 &sbi->s_bdev_wb_err);
+
 			/*
 			 * Mounting a RDONLY partition read-write, so reread
 			 * and store the current valid flag.  (It may have
-- 
2.25.4

