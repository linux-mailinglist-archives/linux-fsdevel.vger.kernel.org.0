Return-Path: <linux-fsdevel+bounces-25398-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A6994B6DD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 08:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5ABCC1C21238
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 06:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE9B187862;
	Thu,  8 Aug 2024 06:40:22 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E0D186E2A;
	Thu,  8 Aug 2024 06:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723099221; cv=none; b=g7dI+80Gj71diRCVUuKd1zbh+fX+BonA/L4Wl/WyUaH23Vpr2x3DXZBXvYUYh9Tra5ranrJKl8Xv4AUHXnKAdPd4PPOiGfbABN7Dtb8CmLLWRojRNG6aH0eai4Jp4nuf3epzehFC9QZCtCBkipt9YRRETAnnh2Ch7DU9L9e3nVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723099221; c=relaxed/simple;
	bh=jEjzWT1uMorfMwo57o75GIU9Fe014okFVP4jVqv61vg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Wzcyve7tyO3TpQxuV702vPq9/VumDGMtBbvHzxs6gscbuRDsD66NVdF09JksD3h4LNrIaiP6sTuUSagid2+y+1ehTHXkdSzrTeiWjKIBB0OspnXXq8TQr/XKHQAlX+YmNCORe/uarBg8KRHAbKjRtehX2ajRFCSxb7VtI+6pMVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 4786dV6I061847;
	Thu, 8 Aug 2024 14:39:31 +0800 (+08)
	(envelope-from Dongliang.Cui@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4WfcgR2jpTz2Lks4k;
	Thu,  8 Aug 2024 14:33:23 +0800 (CST)
Received: from tj10379pcu.spreadtrum.com (10.5.32.15) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Thu, 8 Aug 2024 14:39:29 +0800
From: Dongliang Cui <dongliang.cui@unisoc.com>
To: <linkinjeon@kernel.org>, <sj1557.seo@samsung.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <niuzhiguo84@gmail.com>, <hao_hao.wang@unisoc.com>, <ke.wang@unisoc.com>,
        <dongliang.cui@unisoc.com>, <cuidongliang390@gmail.com>,
        Zhiguo Niu
	<zhiguo.niu@unisoc.com>
Subject: [PATCH v4] exfat: check disk status during buffer write
Date: Thu, 8 Aug 2024 14:36:48 +0800
Message-ID: <20240808063648.255732-1-dongliang.cui@unisoc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL:SHSQR01.spreadtrum.com 4786dV6I061847

We found that when writing a large file through buffer write, if the
disk is inaccessible, exFAT does not return an error normally, which
leads to the writing process not stopping properly.

To easily reproduce this issue, you can follow the steps below:

1. format a device to exFAT and then mount (with a full disk erase)
2. dd if=/dev/zero of=/exfat_mount/test.img bs=1M count=8192
3. eject the device

You may find that the dd process does not stop immediately and may
continue for a long time.

The root cause of this issue is that during buffer write process,
exFAT does not need to access the disk to look up directory entries
or the FAT table (whereas FAT would do) every time data is written.
Instead, exFAT simply marks the buffer as dirty and returns,
delegating the writeback operation to the writeback process.

If the disk cannot be accessed at this time, the error will only be
returned to the writeback process, and the original process will not
receive the error, so it cannot be returned to the user side.

When the disk cannot be accessed normally, an error should be returned
to stop the writing process.

xfstests results:

Apart from generic/622, all other shutdown-related cases can pass.

generic/622 fails the test after the shutdown ioctl implementation, but
when it's not implemented, this case will be skipped.

This case designed to test the lazytime mount option, based on the test
results, it appears that the atime and ctime of files cannot be
synchronized to the disk through interfaces such as sync or fsync.
It seems that it has little to do with the implementation of shutdown
itself.

If you need detailed information about generic/622, I can upload it.

Signed-off-by: Dongliang Cui <dongliang.cui@unisoc.com>
Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
---
Changes in v4:
 - Add shutdown check to the process related to writing.
 - Add shutdown related ioctl.
 - Upload the results of xfstest.
---
 fs/exfat/exfat_fs.h        | 12 ++++++++++++
 fs/exfat/file.c            | 21 ++++++++++++++++++++
 fs/exfat/inode.c           |  9 +++++++++
 fs/exfat/namei.c           | 15 +++++++++++++++
 fs/exfat/super.c           | 39 ++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/exfat.h | 25 ++++++++++++++++++++++++
 6 files changed, 121 insertions(+)
 create mode 100644 include/uapi/linux/exfat.h

diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index ecc5db952deb..7e29d153d852 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -10,6 +10,7 @@
 #include <linux/ratelimit.h>
 #include <linux/nls.h>
 #include <linux/blkdev.h>
+#include <uapi/linux/exfat.h>
 
 #define EXFAT_ROOT_INO		1
 
@@ -148,6 +149,9 @@ enum {
 #define DIR_CACHE_SIZE		\
 	(DIV_ROUND_UP(EXFAT_DEN_TO_B(ES_MAX_ENTRY_NUM), SECTOR_SIZE) + 1)
 
+/* Superblock flags */
+#define EXFAT_FLAGS_SHUTDOWN	1
+
 struct exfat_dentry_namebuf {
 	char *lfn;
 	int lfnbuf_len; /* usually MAX_UNINAME_BUF_SIZE */
@@ -267,6 +271,8 @@ struct exfat_sb_info {
 	unsigned int clu_srch_ptr; /* cluster search pointer */
 	unsigned int used_clusters; /* number of used clusters */
 
+	unsigned long s_exfat_flags; /* Exfat superblock flags */
+
 	struct mutex s_lock; /* superblock lock */
 	struct mutex bitmap_lock; /* bitmap lock */
 	struct exfat_mount_options options;
@@ -338,6 +344,11 @@ static inline struct exfat_inode_info *EXFAT_I(struct inode *inode)
 	return container_of(inode, struct exfat_inode_info, vfs_inode);
 }
 
+static inline int exfat_forced_shutdown(struct super_block *sb)
+{
+	return test_bit(EXFAT_FLAGS_SHUTDOWN, &EXFAT_SB(sb)->s_exfat_flags);
+}
+
 /*
  * If ->i_mode can't hold 0222 (i.e. ATTR_RO), we use ->i_attrs to
  * save ATTR_RO instead of ->i_mode.
@@ -461,6 +472,7 @@ int exfat_file_fsync(struct file *file, loff_t start, loff_t end, int datasync);
 long exfat_ioctl(struct file *filp, unsigned int cmd, unsigned long arg);
 long exfat_compat_ioctl(struct file *filp, unsigned int cmd,
 				unsigned long arg);
+int exfat_force_shutdown(struct super_block *sb, u32 flags);
 
 /* namei.c */
 extern const struct dentry_operations exfat_dentry_ops;
diff --git a/fs/exfat/file.c b/fs/exfat/file.c
index 64c31867bc76..cddaea3b8bbd 100644
--- a/fs/exfat/file.c
+++ b/fs/exfat/file.c
@@ -302,6 +302,9 @@ int exfat_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	unsigned int ia_valid;
 	int error;
 
+	if (unlikely(exfat_forced_shutdown(inode->i_sb)))
+		return -EIO;
+
 	if ((attr->ia_valid & ATTR_SIZE) &&
 	    attr->ia_size > i_size_read(inode)) {
 		error = exfat_cont_expand(inode, attr->ia_size);
@@ -485,6 +488,19 @@ static int exfat_ioctl_fitrim(struct inode *inode, unsigned long arg)
 	return 0;
 }
 
+static int exfat_ioctl_shutdown(struct super_block *sb, unsigned long arg)
+{
+	u32 flags;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	if (get_user(flags, (__u32 __user *)arg))
+		return -EFAULT;
+
+	return exfat_force_shutdown(sb, flags);
+}
+
 long exfat_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
 	struct inode *inode = file_inode(filp);
@@ -495,6 +511,8 @@ long exfat_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		return exfat_ioctl_get_attributes(inode, user_attr);
 	case FAT_IOCTL_SET_ATTRIBUTES:
 		return exfat_ioctl_set_attributes(filp, user_attr);
+	case EXFAT_IOC_SHUTDOWN:
+		return exfat_ioctl_shutdown(inode->i_sb, arg);
 	case FITRIM:
 		return exfat_ioctl_fitrim(inode, arg);
 	default:
@@ -515,6 +533,9 @@ int exfat_file_fsync(struct file *filp, loff_t start, loff_t end, int datasync)
 	struct inode *inode = filp->f_mapping->host;
 	int err;
 
+	if (unlikely(exfat_forced_shutdown(inode->i_sb)))
+		return -EIO;
+
 	err = __generic_file_fsync(filp, start, end, datasync);
 	if (err)
 		return err;
diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c
index dd894e558c91..44b6204d60dc 100644
--- a/fs/exfat/inode.c
+++ b/fs/exfat/inode.c
@@ -102,6 +102,9 @@ int exfat_write_inode(struct inode *inode, struct writeback_control *wbc)
 {
 	int ret;
 
+	if (unlikely(exfat_forced_shutdown(inode->i_sb)))
+		return -EIO;
+
 	mutex_lock(&EXFAT_SB(inode->i_sb)->s_lock);
 	ret = __exfat_write_inode(inode, wbc->sync_mode == WB_SYNC_ALL);
 	mutex_unlock(&EXFAT_SB(inode->i_sb)->s_lock);
@@ -432,6 +435,9 @@ static void exfat_readahead(struct readahead_control *rac)
 static int exfat_writepages(struct address_space *mapping,
 		struct writeback_control *wbc)
 {
+	if (unlikely(exfat_forced_shutdown(mapping->host->i_sb)))
+		return -EIO;
+
 	return mpage_writepages(mapping, wbc, exfat_get_block);
 }
 
@@ -452,6 +458,9 @@ static int exfat_write_begin(struct file *file, struct address_space *mapping,
 {
 	int ret;
 
+	if (unlikely(exfat_forced_shutdown(mapping->host->i_sb)))
+		return -EIO;
+
 	*pagep = NULL;
 	ret = block_write_begin(mapping, pos, len, pagep, exfat_get_block);
 
diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index 631ad9e8e32a..84941b5034c2 100644
--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -549,6 +549,9 @@ static int exfat_create(struct mnt_idmap *idmap, struct inode *dir,
 	int err;
 	loff_t size = i_size_read(dir);
 
+	if (unlikely(exfat_forced_shutdown(sb)))
+		return -EIO;
+
 	mutex_lock(&EXFAT_SB(sb)->s_lock);
 	exfat_set_volume_dirty(sb);
 	err = exfat_add_entry(dir, dentry->d_name.name, &cdir, TYPE_FILE,
@@ -772,6 +775,9 @@ static int exfat_unlink(struct inode *dir, struct dentry *dentry)
 	struct exfat_entry_set_cache es;
 	int entry, err = 0;
 
+	if (unlikely(exfat_forced_shutdown(sb)))
+		return -EIO;
+
 	mutex_lock(&EXFAT_SB(sb)->s_lock);
 	exfat_chain_dup(&cdir, &ei->dir);
 	entry = ei->entry;
@@ -825,6 +831,9 @@ static int exfat_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	int err;
 	loff_t size = i_size_read(dir);
 
+	if (unlikely(exfat_forced_shutdown(sb)))
+		return -EIO;
+
 	mutex_lock(&EXFAT_SB(sb)->s_lock);
 	exfat_set_volume_dirty(sb);
 	err = exfat_add_entry(dir, dentry->d_name.name, &cdir, TYPE_DIR,
@@ -915,6 +924,9 @@ static int exfat_rmdir(struct inode *dir, struct dentry *dentry)
 	struct exfat_entry_set_cache es;
 	int entry, err;
 
+	if (unlikely(exfat_forced_shutdown(sb)))
+		return -EIO;
+
 	mutex_lock(&EXFAT_SB(inode->i_sb)->s_lock);
 
 	exfat_chain_dup(&cdir, &ei->dir);
@@ -982,6 +994,9 @@ static int exfat_rename_file(struct inode *inode, struct exfat_chain *p_dir,
 	struct exfat_entry_set_cache old_es, new_es;
 	int sync = IS_DIRSYNC(inode);
 
+	if (unlikely(exfat_forced_shutdown(sb)))
+		return -EIO;
+
 	num_new_entries = exfat_calc_num_entries(p_uniname);
 	if (num_new_entries < 0)
 		return num_new_entries;
diff --git a/fs/exfat/super.c b/fs/exfat/super.c
index 323ecebe6f0e..6859365c71f8 100644
--- a/fs/exfat/super.c
+++ b/fs/exfat/super.c
@@ -46,6 +46,9 @@ static int exfat_sync_fs(struct super_block *sb, int wait)
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
 	int err = 0;
 
+	if (unlikely(exfat_forced_shutdown(sb)))
+		return 0;
+
 	if (!wait)
 		return 0;
 
@@ -167,6 +170,41 @@ static int exfat_show_options(struct seq_file *m, struct dentry *root)
 	return 0;
 }
 
+int exfat_force_shutdown(struct super_block *sb, u32 flags)
+{
+	int ret;
+	struct exfat_sb_info *sbi = sb->s_fs_info;
+	struct exfat_mount_options *opts = &sbi->options;
+
+	if (exfat_forced_shutdown(sb))
+		return 0;
+
+	switch (flags) {
+	case EXFAT_GOING_DOWN_DEFAULT:
+	case EXFAT_GOING_DOWN_FULLSYNC:
+		ret = bdev_freeze(sb->s_bdev);
+		if (ret)
+			return ret;
+		bdev_thaw(sb->s_bdev);
+		set_bit(EXFAT_FLAGS_SHUTDOWN, &sbi->s_exfat_flags);
+		break;
+	case EXFAT_GOING_DOWN_NOSYNC:
+		set_bit(EXFAT_FLAGS_SHUTDOWN, &sbi->s_exfat_flags);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (opts->discard)
+		opts->discard = 0;
+	return 0;
+}
+
+static void exfat_shutdown(struct super_block *sb)
+{
+	exfat_force_shutdown(sb, EXFAT_GOING_DOWN_NOSYNC);
+}
+
 static struct inode *exfat_alloc_inode(struct super_block *sb)
 {
 	struct exfat_inode_info *ei;
@@ -193,6 +231,7 @@ static const struct super_operations exfat_sops = {
 	.sync_fs	= exfat_sync_fs,
 	.statfs		= exfat_statfs,
 	.show_options	= exfat_show_options,
+	.shutdown	= exfat_shutdown,
 };
 
 enum {
diff --git a/include/uapi/linux/exfat.h b/include/uapi/linux/exfat.h
new file mode 100644
index 000000000000..46d95b16fc4b
--- /dev/null
+++ b/include/uapi/linux/exfat.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Copyright (C) 2024 Unisoc Technologies Co., Ltd.
+ */
+
+#ifndef _UAPI_LINUX_EXFAT_H
+#define _UAPI_LINUX_EXFAT_H
+#include <linux/types.h>
+#include <linux/ioctl.h>
+
+/*
+ * exfat-specific ioctl commands
+ */
+
+#define EXFAT_IOC_SHUTDOWN _IOR('X', 125, __u32)
+
+/*
+ * Flags used by EXFAT_IOC_SHUTDOWN
+ */
+
+#define EXFAT_GOING_DOWN_DEFAULT	0x0	/* default with full sync */
+#define EXFAT_GOING_DOWN_FULLSYNC	0x1     /* going down with full sync*/
+#define EXFAT_GOING_DOWN_NOSYNC         0x2     /* going down */
+
+#endif /* _UAPI_LINUX_EXFAT_H */
-- 
2.25.1


