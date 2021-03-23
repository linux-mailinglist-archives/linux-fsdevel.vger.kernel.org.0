Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7166C346974
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Mar 2021 21:01:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbhCWUAm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Mar 2021 16:00:42 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:54078 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232978AbhCWUAO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Mar 2021 16:00:14 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id C6F111F44DBA
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
To:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     krisman@collabora.com, smcv@collabora.com, kernel@collabora.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Daniel Rosenberg <drosen@google.com>,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
Subject: [RFC PATCH 3/4] mm: shmem: Add IOCTL support for tmpfs
Date:   Tue, 23 Mar 2021 16:59:40 -0300
Message-Id: <20210323195941.69720-4-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210323195941.69720-1-andrealmeid@collabora.com>
References: <20210323195941.69720-1-andrealmeid@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Implement IOCTL operations for files to set/get file flags. Implement
the only supported flag by now, that is S_CASEFOLD.

Signed-off-by: André Almeida <andrealmeid@collabora.com>
---
 include/linux/shmem_fs.h |  4 ++
 mm/shmem.c               | 84 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 87 insertions(+), 1 deletion(-)

diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index 29ee64352807..2c89c5a66508 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -140,4 +140,8 @@ extern int shmem_mfill_zeropage_pte(struct mm_struct *dst_mm,
 				 dst_addr)      ({ BUG(); 0; })
 #endif
 
+#define TMPFS_CASEFOLD_FL	0x40000000 /* Casefolded file */
+#define TMPFS_USER_FLS		TMPFS_CASEFOLD_FL /* Userspace supported flags */
+#define TMPFS_FLS		S_CASEFOLD /* Kernel supported flags */
+
 #endif
diff --git a/mm/shmem.c b/mm/shmem.c
index 20df81763995..2f2c996d215b 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -258,6 +258,7 @@ static inline void shmem_inode_unacct_blocks(struct inode *inode, long pages)
 static const struct super_operations shmem_ops;
 const struct address_space_operations shmem_aops;
 static const struct file_operations shmem_file_operations;
+static const struct file_operations shmem_dir_operations;
 static const struct inode_operations shmem_inode_operations;
 static const struct inode_operations shmem_dir_inode_operations;
 static const struct inode_operations shmem_special_inode_operations;
@@ -2347,7 +2348,7 @@ static struct inode *shmem_get_inode(struct super_block *sb, const struct inode
 			/* Some things misbehave if size == 0 on a directory */
 			inode->i_size = 2 * BOGO_DIRENT_SIZE;
 			inode->i_op = &shmem_dir_inode_operations;
-			inode->i_fop = &simple_dir_operations;
+			inode->i_fop = &shmem_dir_operations;
 			break;
 		case S_IFLNK:
 			/*
@@ -2838,6 +2839,76 @@ static long shmem_fallocate(struct file *file, int mode, loff_t offset,
 	return error;
 }
 
+static long shmem_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	int ret;
+	u32 fsflags = 0, old, new = 0;
+	struct inode *inode = file_inode(file);
+	struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
+
+	switch (cmd) {
+	case FS_IOC_GETFLAGS:
+		if ((inode->i_flags & S_CASEFOLD) && S_ISDIR(inode->i_mode))
+			fsflags |= TMPFS_CASEFOLD_FL;
+
+		if (put_user(fsflags, (int __user *)arg))
+			return -EFAULT;
+
+		return 0;
+
+	case FS_IOC_SETFLAGS:
+		if (get_user(fsflags, (int __user *)arg))
+			return -EFAULT;
+
+		old = inode->i_flags;
+
+		if (fsflags & ~TMPFS_USER_FLS)
+			return -EINVAL;
+
+		if (fsflags & TMPFS_CASEFOLD_FL) {
+			if (!sbinfo->casefold) {
+				pr_err("tmpfs: casefold disabled at this mount point\n");
+				return -EOPNOTSUPP;
+			}
+
+			if (!S_ISDIR(inode->i_mode))
+				return -ENOTDIR;
+
+			if (!simple_empty(file_dentry(file)))
+				return -ENOTEMPTY;
+
+			new |= S_CASEFOLD;
+		} else if (old & S_CASEFOLD) {
+			if (!simple_empty(file_dentry(file)))
+				return -ENOTEMPTY;
+		}
+
+		ret = mnt_want_write_file(file);
+		if (ret)
+			return ret;
+
+		inode_lock(inode);
+
+		ret = vfs_ioc_setflags_prepare(inode, old, new);
+		if (ret) {
+			inode_unlock(inode);
+			mnt_drop_write_file(file);
+			return ret;
+		}
+
+		inode_set_flags(inode, new, TMPFS_FLS);
+
+		inode_unlock(inode);
+		mnt_drop_write_file(file);
+		return 0;
+
+	default:
+		return -ENOTTY;
+	}
+
+	return 0;
+}
+
 static int shmem_statfs(struct dentry *dentry, struct kstatfs *buf)
 {
 	struct shmem_sb_info *sbinfo = SHMEM_SB(dentry->d_sb);
@@ -3916,6 +3987,7 @@ static const struct file_operations shmem_file_operations = {
 	.splice_read	= generic_file_splice_read,
 	.splice_write	= iter_file_splice_write,
 	.fallocate	= shmem_fallocate,
+	.unlocked_ioctl = shmem_ioctl,
 #endif
 };
 
@@ -3928,6 +4000,16 @@ static const struct inode_operations shmem_inode_operations = {
 #endif
 };
 
+static const struct file_operations shmem_dir_operations = {
+	.open		= dcache_dir_open,
+	.release	= dcache_dir_close,
+	.llseek		= dcache_dir_lseek,
+	.read		= generic_read_dir,
+	.iterate_shared	= dcache_readdir,
+	.fsync		= noop_fsync,
+	.unlocked_ioctl = shmem_ioctl,
+};
+
 static const struct inode_operations shmem_dir_inode_operations = {
 #ifdef CONFIG_TMPFS
 	.create		= shmem_create,
-- 
2.31.0

