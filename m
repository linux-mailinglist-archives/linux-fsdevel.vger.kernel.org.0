Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00F0F659DB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2019 17:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728848AbfGKPAP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Jul 2019 11:00:15 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:40228 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729077AbfGKO61 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Jul 2019 10:58:27 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 54FF5440A8B4D1905726;
        Thu, 11 Jul 2019 22:58:23 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.209) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 11 Jul
 2019 22:58:15 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     <linux-fsdevel@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        LKML <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, Chao Yu <yuchao0@huawei.com>,
        Miao Xie <miaoxie@huawei.com>,
        Li Guifu <bluce.liguifu@huawei.com>,
        Fang Wei <fangwei1@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH v2 03/24] erofs: add super block operations
Date:   Thu, 11 Jul 2019 22:57:34 +0800
Message-ID: <20190711145755.33908-4-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190711145755.33908-1-gaoxiang25@huawei.com>
References: <20190711145755.33908-1-gaoxiang25@huawei.com>
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
 fs/erofs/super.c | 502 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 502 insertions(+)
 create mode 100644 fs/erofs/super.c

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
new file mode 100644
index 000000000000..d83e55bdd4a8
--- /dev/null
+++ b/fs/erofs/super.c
@@ -0,0 +1,502 @@
+// SPDX-License-Identifier: GPL-2.0
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
+
+		default:
+			errln("Unrecognized mount option \"%s\" or missing value", p);
+			return -EINVAL;
+		}
+	}
+	return 0;
+}
+
+static int erofs_read_super(struct super_block *sb,
+			    const char *dev_name,
+			    void *data, int silent)
+{
+	struct inode *inode;
+	struct erofs_sb_info *sbi;
+	int err = -EINVAL;
+
+	infoln("read_super, device -> %s", dev_name);
+	infoln("options -> %s", (char *)data);
+
+	if (unlikely(!sb_set_blocksize(sb, EROFS_BLKSIZ))) {
+		errln("failed to set erofs blksize");
+		goto err;
+	}
+
+	sbi = kzalloc(sizeof(*sbi), GFP_KERNEL);
+	if (unlikely(!sbi)) {
+		err = -ENOMEM;
+		goto err;
+	}
+	sb->s_fs_info = sbi;
+
+	err = superblock_read(sb);
+	if (err)
+		goto err_sbread;
+
+	sb->s_magic = EROFS_SUPER_MAGIC;
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
+	if (err)
+		goto err_parseopt;
+
+	if (!silent)
+		infoln("root inode @ nid %llu", ROOT_NID(sbi));
+
+	/* get the root inode */
+	inode = erofs_iget(sb, ROOT_NID(sbi), true);
+	if (IS_ERR(inode)) {
+		err = PTR_ERR(inode);
+		goto err_iget;
+	}
+
+	if (!S_ISDIR(inode->i_mode)) {
+		errln("rootino(nid %llu) is not a directory(i_mode %o)",
+		      ROOT_NID(sbi), inode->i_mode);
+		err = -EINVAL;
+		iput(inode);
+		goto err_iget;
+	}
+
+	sb->s_root = d_make_root(inode);
+	if (!sb->s_root) {
+		err = -ENOMEM;
+		goto err_iget;
+	}
+
+	/* save the device name to sbi */
+	sbi->dev_name = __getname();
+	if (!sbi->dev_name) {
+		err = -ENOMEM;
+		goto err_devname;
+	}
+
+	snprintf(sbi->dev_name, PATH_MAX, "%s", dev_name);
+	sbi->dev_name[PATH_MAX - 1] = '\0';
+
+	if (!silent)
+		infoln("mounted on %s with opts: %s.", dev_name,
+		       (char *)data);
+	return 0;
+	/*
+	 * please add a label for each exit point and use
+	 * the following name convention, thus new features
+	 * can be integrated easily without renaming labels.
+	 */
+err_devname:
+	dput(sb->s_root);
+	sb->s_root = NULL;
+err_iget:
+err_parseopt:
+err_sbread:
+	sb->s_fs_info = NULL;
+	kfree(sbi);
+err:
+	return err;
+}
+
+/*
+ * could be triggered after deactivate_locked_super()
+ * is called, thus including umount and failed to initialize.
+ */
+static void erofs_put_super(struct super_block *sb)
+{
+	struct erofs_sb_info *sbi = EROFS_SB(sb);
+
+	/* for cases which are failed in "read_super" */
+	if (!sbi)
+		return;
+
+	WARN_ON(sb->s_magic != EROFS_SUPER_MAGIC);
+
+	infoln("unmounted for %s", sbi->dev_name);
+	__putname(sbi->dev_name);
+
+	kfree(sbi);
+	sb->s_fs_info = NULL;
+}
+
+
+struct erofs_mount_private {
+	const char *dev_name;
+	char *options;
+};
+
+/* support mount_bdev() with options */
+static int erofs_fill_super(struct super_block *sb,
+			    void *_priv, int silent)
+{
+	struct erofs_mount_private *priv = _priv;
+
+	return erofs_read_super(sb, priv->dev_name,
+		priv->options, silent);
+}
+
+static struct dentry *erofs_mount(
+	struct file_system_type *fs_type, int flags,
+	const char *dev_name, void *data)
+{
+	struct erofs_mount_private priv = {
+		.dev_name = dev_name,
+		.options = data
+	};
+
+	return mount_bdev(fs_type, flags, dev_name,
+		&priv, erofs_fill_super);
+}
+
+static void erofs_kill_sb(struct super_block *sb)
+{
+	kill_block_super(sb);
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
+	.put_super = erofs_put_super,
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

