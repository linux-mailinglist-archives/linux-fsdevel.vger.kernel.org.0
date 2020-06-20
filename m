Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC297201FF0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Jun 2020 04:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732145AbgFTCxy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Jun 2020 22:53:54 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:54916 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732118AbgFTCxf (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Jun 2020 22:53:35 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 8A9974562A62E6CC226F;
        Sat, 20 Jun 2020 10:53:33 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Sat, 20 Jun 2020
 10:53:20 +0800
From:   "zhangyi (F)" <yi.zhang@huawei.com>
To:     <linux-ext4@vger.kernel.org>, <tytso@mit.edu>, <jack@suse.cz>
CC:     <adilger.kernel@dilger.ca>, <zhangxiaoxu5@huawei.com>,
        <yi.zhang@huawei.com>, <linux-fsdevel@vger.kernel.org>
Subject: [PATCH v3 1/5] ext4: abort the filesystem if failed to async write metadata buffer
Date:   Sat, 20 Jun 2020 10:54:23 +0800
Message-ID: <20200620025427.1756360-2-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200620025427.1756360-1-yi.zhang@huawei.com>
References: <20200620025427.1756360-1-yi.zhang@huawei.com>
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

This patch detect bdev mapping->wb_err when getting journal's write
access and mark the filesystem error if bdev's mapping->wb_err was
increased, this could prevent further writing and potential
inconsistency.

Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
Suggested-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/ext4.h      |  3 +++
 fs/ext4/ext4_jbd2.c | 25 +++++++++++++++++++++++++
 fs/ext4/super.c     | 17 +++++++++++++++++
 3 files changed, 45 insertions(+)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index b08841f70b69..60374eda1f51 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1573,6 +1573,9 @@ struct ext4_sb_info {
 #ifdef CONFIG_EXT4_DEBUG
 	unsigned long s_simulate_fail;
 #endif
+	/* Record the errseq of the backing block device */
+	errseq_t s_bdev_wb_err;
+	spinlock_t s_bdev_wb_lock;
 };
 
 static inline struct ext4_sb_info *EXT4_SB(struct super_block *sb)
diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
index 0c76cdd44d90..760b9ee49dc0 100644
--- a/fs/ext4/ext4_jbd2.c
+++ b/fs/ext4/ext4_jbd2.c
@@ -195,6 +195,28 @@ static void ext4_journal_abort_handle(const char *caller, unsigned int line,
 	jbd2_journal_abort_handle(handle);
 }
 
+static void ext4_check_bdev_write_error(struct super_block *sb)
+{
+	struct address_space *mapping = sb->s_bdev->bd_inode->i_mapping;
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
+	int err;
+
+	/*
+	 * If the block device has write error flag, it may have failed to
+	 * async write out metadata buffers in the background. In this case,
+	 * we could read old data from disk and write it out again, which
+	 * may lead to on-disk filesystem inconsistency.
+	 */
+	if (errseq_check(&mapping->wb_err, READ_ONCE(sbi->s_bdev_wb_err))) {
+		spin_lock(&sbi->s_bdev_wb_lock);
+		err = errseq_check_and_advance(&mapping->wb_err, &sbi->s_bdev_wb_err);
+		spin_unlock(&sbi->s_bdev_wb_lock);
+		if (err)
+			ext4_error_err(sb, -err,
+				       "Error while async write back metadata");
+	}
+}
+
 int __ext4_journal_get_write_access(const char *where, unsigned int line,
 				    handle_t *handle, struct buffer_head *bh)
 {
@@ -202,6 +224,9 @@ int __ext4_journal_get_write_access(const char *where, unsigned int line,
 
 	might_sleep();
 
+	if (bh->b_bdev->bd_super)
+		ext4_check_bdev_write_error(bh->b_bdev->bd_super);
+
 	if (ext4_handle_valid(handle)) {
 		err = jbd2_journal_get_write_access(handle, bh);
 		if (err)
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index c668f6b42374..8d3925c31b8a 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -4699,6 +4699,15 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
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
@@ -5562,6 +5571,14 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
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

