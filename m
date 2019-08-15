Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E822F8E41C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2019 06:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729627AbfHOEms (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Aug 2019 00:42:48 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4262 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728660AbfHOEmr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Aug 2019 00:42:47 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 12D86C00FEADA92A4856;
        Thu, 15 Aug 2019 12:42:43 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.210) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 15 Aug
 2019 12:42:32 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     <linux-fsdevel@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        "Alexander Viro" <viro@zeniv.linux.org.uk>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Theodore Ts'o <tytso@mit.edu>, "Pavel Machek" <pavel@denx.de>,
        David Sterba <dsterba@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        "Jaegeuk Kim" <jaegeuk@kernel.org>, Jan Kara <jack@suse.cz>,
        Richard Weinberger <richard@nod.at>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        <linux-erofs@lists.ozlabs.org>, Chao Yu <yuchao0@huawei.com>,
        Miao Xie <miaoxie@huawei.com>,
        Li Guifu <bluce.liguifu@huawei.com>,
        Fang Wei <fangwei1@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH v8 03/24] erofs: add super block operations
Date:   Thu, 15 Aug 2019 12:41:34 +0800
Message-ID: <20190815044155.88483-4-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190815044155.88483-1-gaoxiang25@huawei.com>
References: <20190815044155.88483-1-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.140.130.215]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This commit adds erofs super block operations, including (u)mount,
remount_fs, show_options, statfs, in addition to some private
icache management functions.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 fs/erofs/super.c | 437 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 437 insertions(+)
 create mode 100644 fs/erofs/super.c

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
new file mode 100644
index 000000000000..cd4bd6f48173
--- /dev/null
+++ b/fs/erofs/super.c
@@ -0,0 +1,437 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * linux/fs/erofs/super.c
+ *
+ * Copyright (C) 2017-2018 HUAWEI, Inc.
+ *             http://www.huawei.com/
+ * Created by Gao Xiang <gaoxiang25@huawei.com>
+ */
+#include <linux/module.h>
+#include <linux/buffer_head.h>
+#include <linux/statfs.h>
+#include <linux/parser.h>
+#include <linux/seq_file.h>
+#include "internal.h"
+
+#define CREATE_TRACE_POINTS
+#include <trace/events/erofs.h>
+
+static struct kmem_cache *erofs_inode_cachep __read_mostly;
+
+static void init_once(void *ptr)
+{
+	struct erofs_vnode *vi = ptr;
+
+	inode_init_once(&vi->vfs_inode);
+}
+
+static int __init erofs_init_inode_cache(void)
+{
+	erofs_inode_cachep = kmem_cache_create("erofs_inode",
+					       sizeof(struct erofs_vnode), 0,
+					       SLAB_RECLAIM_ACCOUNT,
+					       init_once);
+
+	return erofs_inode_cachep ? 0 : -ENOMEM;
+}
+
+static void erofs_exit_inode_cache(void)
+{
+	kmem_cache_destroy(erofs_inode_cachep);
+}
+
+static struct inode *alloc_inode(struct super_block *sb)
+{
+	struct erofs_vnode *vi =
+		kmem_cache_alloc(erofs_inode_cachep, GFP_KERNEL);
+
+	if (!vi)
+		return NULL;
+
+	/* zero out everything except vfs_inode */
+	memset(vi, 0, offsetof(struct erofs_vnode, vfs_inode));
+	return &vi->vfs_inode;
+}
+
+static void free_inode(struct inode *inode)
+{
+	struct erofs_vnode *vi = EROFS_V(inode);
+
+	/* be careful RCU symlink path (see ext4_inode_info->i_data)! */
+	if (is_inode_fast_symlink(inode))
+		kfree(inode->i_link);
+
+	kmem_cache_free(erofs_inode_cachep, vi);
+}
+
+static bool check_layout_compatibility(struct super_block *sb,
+				       struct erofs_super_block *layout)
+{
+	const unsigned int requirements = le32_to_cpu(layout->requirements);
+
+	EROFS_SB(sb)->requirements = requirements;
+
+	/* check if current kernel meets all mandatory requirements */
+	if (requirements & (~EROFS_ALL_REQUIREMENTS)) {
+		errln("unidentified requirements %x, please upgrade kernel version",
+		      requirements & ~EROFS_ALL_REQUIREMENTS);
+		return false;
+	}
+	return true;
+}
+
+static int superblock_read(struct super_block *sb)
+{
+	struct erofs_sb_info *sbi;
+	struct buffer_head *bh;
+	struct erofs_super_block *layout;
+	unsigned int blkszbits;
+	int ret;
+
+	bh = sb_bread(sb, 0);
+
+	if (!bh) {
+		errln("cannot read erofs superblock");
+		return -EIO;
+	}
+
+	sbi = EROFS_SB(sb);
+	layout = (struct erofs_super_block *)((u8 *)bh->b_data
+		 + EROFS_SUPER_OFFSET);
+
+	ret = -EINVAL;
+	if (le32_to_cpu(layout->magic) != EROFS_SUPER_MAGIC_V1) {
+		errln("cannot find valid erofs superblock");
+		goto out;
+	}
+
+	blkszbits = layout->blkszbits;
+	/* 9(512 bytes) + LOG_SECTORS_PER_BLOCK == LOG_BLOCK_SIZE */
+	if (unlikely(blkszbits != LOG_BLOCK_SIZE)) {
+		errln("blksize %u isn't supported on this platform",
+		      1 << blkszbits);
+		goto out;
+	}
+
+	if (!check_layout_compatibility(sb, layout))
+		goto out;
+
+	sbi->blocks = le32_to_cpu(layout->blocks);
+	sbi->meta_blkaddr = le32_to_cpu(layout->meta_blkaddr);
+	sbi->islotbits = ffs(sizeof(struct erofs_inode_v1)) - 1;
+	sbi->root_nid = le16_to_cpu(layout->root_nid);
+	sbi->inos = le64_to_cpu(layout->inos);
+
+	sbi->build_time = le64_to_cpu(layout->build_time);
+	sbi->build_time_nsec = le32_to_cpu(layout->build_time_nsec);
+
+	memcpy(&sb->s_uuid, layout->uuid, sizeof(layout->uuid));
+	memcpy(sbi->volume_name, layout->volume_name,
+	       sizeof(layout->volume_name));
+
+	ret = 0;
+out:
+	brelse(bh);
+	return ret;
+}
+
+#ifdef CONFIG_EROFS_FAULT_INJECTION
+const char *erofs_fault_name[FAULT_MAX] = {
+	[FAULT_KMALLOC]		= "kmalloc",
+	[FAULT_READ_IO]		= "read IO error",
+};
+
+static void __erofs_build_fault_attr(struct erofs_sb_info *sbi,
+				     unsigned int rate)
+{
+	struct erofs_fault_info *ffi = &sbi->fault_info;
+
+	if (rate) {
+		atomic_set(&ffi->inject_ops, 0);
+		ffi->inject_rate = rate;
+		ffi->inject_type = (1 << FAULT_MAX) - 1;
+	} else {
+		memset(ffi, 0, sizeof(struct erofs_fault_info));
+	}
+
+	set_opt(sbi, FAULT_INJECTION);
+}
+
+static int erofs_build_fault_attr(struct erofs_sb_info *sbi,
+				  substring_t *args)
+{
+	int rate = 0;
+
+	if (args->from && match_int(args, &rate))
+		return -EINVAL;
+
+	__erofs_build_fault_attr(sbi, rate);
+	return 0;
+}
+
+static unsigned int erofs_get_fault_rate(struct erofs_sb_info *sbi)
+{
+	return sbi->fault_info.inject_rate;
+}
+#else
+static void __erofs_build_fault_attr(struct erofs_sb_info *sbi,
+				     unsigned int rate)
+{
+}
+
+static int erofs_build_fault_attr(struct erofs_sb_info *sbi,
+				  substring_t *args)
+{
+	infoln("fault_injection options not supported");
+	return 0;
+}
+
+static unsigned int erofs_get_fault_rate(struct erofs_sb_info *sbi)
+{
+	return 0;
+}
+#endif
+
+/* set up default EROFS parameters */
+static void default_options(struct erofs_sb_info *sbi)
+{
+}
+
+enum {
+	Opt_fault_injection,
+	Opt_err
+};
+
+static match_table_t erofs_tokens = {
+	{Opt_fault_injection, "fault_injection=%u"},
+	{Opt_err, NULL}
+};
+
+static int parse_options(struct super_block *sb, char *options)
+{
+	substring_t args[MAX_OPT_ARGS];
+	char *p;
+	int err;
+
+	if (!options)
+		return 0;
+
+	while ((p = strsep(&options, ","))) {
+		int token;
+
+		if (!*p)
+			continue;
+
+		args[0].to = args[0].from = NULL;
+		token = match_token(p, erofs_tokens, args);
+
+		switch (token) {
+		case Opt_fault_injection:
+			err = erofs_build_fault_attr(EROFS_SB(sb), args);
+			if (err)
+				return err;
+			break;
+		default:
+			errln("Unrecognized mount option \"%s\" or missing value", p);
+			return -EINVAL;
+		}
+	}
+	return 0;
+}
+
+static int erofs_fill_super(struct super_block *sb, void *data, int silent)
+{
+	struct inode *inode;
+	struct erofs_sb_info *sbi;
+	int err;
+
+	infoln("fill_super, device -> %s", sb->s_id);
+	infoln("options -> %s", (char *)data);
+
+	sb->s_magic = EROFS_SUPER_MAGIC;
+
+	if (unlikely(!sb_set_blocksize(sb, EROFS_BLKSIZ))) {
+		errln("failed to set erofs blksize");
+		return -EINVAL;
+	}
+
+	sbi = kzalloc(sizeof(*sbi), GFP_KERNEL);
+	if (unlikely(!sbi))
+		return -ENOMEM;
+
+	sb->s_fs_info = sbi;
+	err = superblock_read(sb);
+	if (err)
+		return err;
+
+	sb->s_flags |= SB_RDONLY | SB_NOATIME;
+	sb->s_maxbytes = MAX_LFS_FILESIZE;
+	sb->s_time_gran = 1;
+
+	sb->s_op = &erofs_sops;
+
+	/* set erofs default mount options */
+	default_options(sbi);
+
+	err = parse_options(sb, data);
+	if (unlikely(err))
+		return err;
+
+	if (!silent)
+		infoln("root inode @ nid %llu", ROOT_NID(sbi));
+
+	/* get the root inode */
+	inode = erofs_iget(sb, ROOT_NID(sbi), true);
+	if (IS_ERR(inode))
+		return PTR_ERR(inode);
+
+	if (unlikely(!S_ISDIR(inode->i_mode))) {
+		errln("rootino(nid %llu) is not a directory(i_mode %o)",
+		      ROOT_NID(sbi), inode->i_mode);
+		iput(inode);
+		return -EINVAL;
+	}
+
+	sb->s_root = d_make_root(inode);
+	if (unlikely(!sb->s_root))
+		return -ENOMEM;
+
+	if (!silent)
+		infoln("mounted on %s with opts: %s.", sb->s_id, (char *)data);
+	return 0;
+}
+
+static struct dentry *erofs_mount(struct file_system_type *fs_type, int flags,
+				  const char *dev_name, void *data)
+{
+	return mount_bdev(fs_type, flags, dev_name, data, erofs_fill_super);
+}
+
+/*
+ * could be triggered after deactivate_locked_super()
+ * is called, thus including umount and failed to initialize.
+ */
+static void erofs_kill_sb(struct super_block *sb)
+{
+	struct erofs_sb_info *sbi;
+
+	WARN_ON(sb->s_magic != EROFS_SUPER_MAGIC);
+	infoln("unmounting for %s", sb->s_id);
+
+	kill_block_super(sb);
+
+	sbi = EROFS_SB(sb);
+	if (!sbi)
+		return;
+	kfree(sbi);
+	sb->s_fs_info = NULL;
+}
+
+static struct file_system_type erofs_fs_type = {
+	.owner          = THIS_MODULE,
+	.name           = "erofs",
+	.mount          = erofs_mount,
+	.kill_sb        = erofs_kill_sb,
+	.fs_flags       = FS_REQUIRES_DEV,
+};
+MODULE_ALIAS_FS("erofs");
+
+static int __init erofs_module_init(void)
+{
+	int err;
+
+	erofs_check_ondisk_layout_definitions();
+	infoln("initializing erofs " EROFS_VERSION);
+
+	err = erofs_init_inode_cache();
+	if (err)
+		goto icache_err;
+
+	err = register_filesystem(&erofs_fs_type);
+	if (err)
+		goto fs_err;
+
+	infoln("successfully to initialize erofs");
+	return 0;
+
+fs_err:
+	erofs_exit_inode_cache();
+icache_err:
+	return err;
+}
+
+static void __exit erofs_module_exit(void)
+{
+	unregister_filesystem(&erofs_fs_type);
+	erofs_exit_inode_cache();
+	infoln("successfully finalize erofs");
+}
+
+/* get filesystem statistics */
+static int erofs_statfs(struct dentry *dentry, struct kstatfs *buf)
+{
+	struct super_block *sb = dentry->d_sb;
+	struct erofs_sb_info *sbi = EROFS_SB(sb);
+	u64 id = huge_encode_dev(sb->s_bdev->bd_dev);
+
+	buf->f_type = sb->s_magic;
+	buf->f_bsize = EROFS_BLKSIZ;
+	buf->f_blocks = sbi->blocks;
+	buf->f_bfree = buf->f_bavail = 0;
+
+	buf->f_files = ULLONG_MAX;
+	buf->f_ffree = ULLONG_MAX - sbi->inos;
+
+	buf->f_namelen = EROFS_NAME_LEN;
+
+	buf->f_fsid.val[0] = (u32)id;
+	buf->f_fsid.val[1] = (u32)(id >> 32);
+	return 0;
+}
+
+static int erofs_show_options(struct seq_file *seq, struct dentry *root)
+{
+	struct erofs_sb_info *sbi __maybe_unused = EROFS_SB(root->d_sb);
+
+	if (test_opt(sbi, FAULT_INJECTION))
+		seq_printf(seq, ",fault_injection=%u",
+			   erofs_get_fault_rate(sbi));
+	return 0;
+}
+
+static int erofs_remount(struct super_block *sb, int *flags, char *data)
+{
+	struct erofs_sb_info *sbi = EROFS_SB(sb);
+	unsigned int org_mnt_opt = sbi->mount_opt;
+	unsigned int org_inject_rate = erofs_get_fault_rate(sbi);
+	int err;
+
+	DBG_BUGON(!sb_rdonly(sb));
+	err = parse_options(sb, data);
+	if (err)
+		goto out;
+
+	*flags |= SB_RDONLY;
+	return 0;
+out:
+	__erofs_build_fault_attr(sbi, org_inject_rate);
+	sbi->mount_opt = org_mnt_opt;
+
+	return err;
+}
+
+const struct super_operations erofs_sops = {
+	.alloc_inode = alloc_inode,
+	.free_inode = free_inode,
+	.statfs = erofs_statfs,
+	.show_options = erofs_show_options,
+	.remount_fs = erofs_remount,
+};
+
+module_init(erofs_module_init);
+module_exit(erofs_module_exit);
+
+MODULE_DESCRIPTION("Enhanced ROM File System");
+MODULE_AUTHOR("Gao Xiang, Chao Yu, Miao Xie, CONSUMER BG, HUAWEI Inc.");
+MODULE_LICENSE("GPL");
+
-- 
2.17.1

