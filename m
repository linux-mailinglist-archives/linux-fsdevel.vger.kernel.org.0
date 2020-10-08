Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B79AD286FEB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Oct 2020 09:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728412AbgJHHx3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Oct 2020 03:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbgJHHx3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Oct 2020 03:53:29 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25448C0613D2;
        Thu,  8 Oct 2020 00:53:29 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id x22so3294014pfo.12;
        Thu, 08 Oct 2020 00:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=PpGMDQVveSnL4hAMh4jtybKG1eOjYS1M5jvQhB105cE=;
        b=oj426ml97WT/RNTqwQTs0CwCzfg2cbYR4xc2iVimdK+SNB5/05si5k8oCoHNrZCNXg
         jIW8j9PshRowyt6PiAfXAhfM3XJniAM/xcTHsbW35YSJnV5alOjZB/my8FbSswkgtbAi
         ZR2vPJQQ2mS1CT5xR18pJgwdXigmlqAhowEFs1HyR/b548A4DfV6eJofS4HYTCZ1KExQ
         F1m4sK+1NXRtr73xe1dkO4hxUtvO8lnbcLvEASSDIiG0z2CLtWZX6+cyjHweqc863QIq
         CyL+a6zrvLApUrtvUTnfVQAQhh6n7oecOV7vpOOMknvlua/nF9ac7zpeNUCm8YXTyibQ
         eLHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=PpGMDQVveSnL4hAMh4jtybKG1eOjYS1M5jvQhB105cE=;
        b=slpIil7lZ1Tuz36xU48cBrrCVOzlx4Jo2yWczPjLUW/1dOmtHdvHatYXHRPj2myuKf
         XycYpdHD7EG7O7wBNPzIUsNRoDuHiNHX391qxXsjuGwjG/NCd5E1Za7DsN1R3Z9QAXe8
         NDURb6cofFowdtiQkD26lXhdSjM36z2gcOG30L8OCI1BMOXiEouV4yf5ukT2JDqrAfoC
         GH4vtfw7j9A3zF2cqWkoHaaK7QLZ25hxXisSPqRRDzsnIv1JWu6/rzvC5RiwDDHRikFe
         vA5QGqpjpJc7WumPNov7IulfpLdP04ULiMCXB+YX5SqsRHX3B+6oq1OIoiEW6RA6c7AL
         9v5g==
X-Gm-Message-State: AOAM533VxQIkiH2fsGsm6R7K/SgydVm31jE2Df0pyTb0njpn9dMYxY/u
        HaH91Qqens+bznP8DTumRXo=
X-Google-Smtp-Source: ABdhPJxJedQZTY5EG7HomEYXY1tfz0id+kobQNH9f2jmxI3zfeVYTcxCbti+nlZAWEbUMHaUDjVH5g==
X-Received: by 2002:a63:7841:: with SMTP id t62mr6279888pgc.183.1602143608642;
        Thu, 08 Oct 2020 00:53:28 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.61])
        by smtp.gmail.com with ESMTPSA id k206sm6777106pfd.126.2020.10.08.00.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 00:53:28 -0700 (PDT)
From:   yulei.kernel@gmail.com
X-Google-Original-From: yuleixzhang@tencent.com
To:     akpm@linux-foundation.org, naoya.horiguchi@nec.com,
        viro@zeniv.linux.org.uk, pbonzini@redhat.com
Cc:     linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, xiaoguangrong.eric@gmail.com,
        kernellwp@gmail.com, lihaiwei.kernel@gmail.com,
        Yulei Zhang <yuleixzhang@tencent.com>,
        Xiao Guangrong <gloryxiao@tencent.com>
Subject: [PATCH 01/35] fs: introduce dmemfs module
Date:   Thu,  8 Oct 2020 15:53:51 +0800
Message-Id: <aa553faf9e97ee9306ecd5a67d3324a34f9ed4be.1602093760.git.yuleixzhang@tencent.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1602093760.git.yuleixzhang@tencent.com>
References: <cover.1602093760.git.yuleixzhang@tencent.com>
In-Reply-To: <cover.1602093760.git.yuleixzhang@tencent.com>
References: <cover.1602093760.git.yuleixzhang@tencent.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Yulei Zhang <yuleixzhang@tencent.com>

dmemfs (Direct Memory filesystem) is device memory or reserved
memory based filesystem. This kind of memory is special as it
is not managed by kernel and it is without 'struct page'.

The original purpose of dmemfs is to drop the usage of
'struct page' to save extra system memory.

This patch introduces the basic framework of dmemfs and only
mkdir and create regular file are supported.

Signed-off-by: Xiao Guangrong  <gloryxiao@tencent.com>
Signed-off-by: Yulei Zhang <yuleixzhang@tencent.com>
---
 fs/Kconfig                 |   1 +
 fs/Makefile                |   1 +
 fs/dmemfs/Kconfig          |  13 ++
 fs/dmemfs/Makefile         |   7 +
 fs/dmemfs/inode.c          | 275 +++++++++++++++++++++++++++++++++++++
 include/uapi/linux/magic.h |   1 +
 6 files changed, 298 insertions(+)
 create mode 100644 fs/dmemfs/Kconfig
 create mode 100644 fs/dmemfs/Makefile
 create mode 100644 fs/dmemfs/inode.c

diff --git a/fs/Kconfig b/fs/Kconfig
index aa4c12282301..18e72089426f 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -41,6 +41,7 @@ source "fs/btrfs/Kconfig"
 source "fs/nilfs2/Kconfig"
 source "fs/f2fs/Kconfig"
 source "fs/zonefs/Kconfig"
+source "fs/dmemfs/Kconfig"
 
 config FS_DAX
 	bool "Direct Access (DAX) support"
diff --git a/fs/Makefile b/fs/Makefile
index 1c7b0e3f6daa..10e0302c5902 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -136,3 +136,4 @@ obj-$(CONFIG_EFIVAR_FS)		+= efivarfs/
 obj-$(CONFIG_EROFS_FS)		+= erofs/
 obj-$(CONFIG_VBOXSF_FS)		+= vboxsf/
 obj-$(CONFIG_ZONEFS_FS)		+= zonefs/
+obj-$(CONFIG_DMEM_FS)		+= dmemfs/
diff --git a/fs/dmemfs/Kconfig b/fs/dmemfs/Kconfig
new file mode 100644
index 000000000000..d2894a513de0
--- /dev/null
+++ b/fs/dmemfs/Kconfig
@@ -0,0 +1,13 @@
+config DMEM_FS
+	tristate "Direct Memory filesystem support"
+	help
+	  dmemfs (Direct Memory filesystem) is device memory or reserved
+	  memory based filesystem. This kind of memory is special as it
+	  is not managed by kernel and it is without 'struct page'.
+
+	  The original purpose of dmemfs is saving extra memory of
+	  'struct page' that reduces the total cost of ownership (TCO)
+	  for cloud providers.
+
+	  To compile this file system support as a module, choose M here: the
+	  module will be called dmemfs.
diff --git a/fs/dmemfs/Makefile b/fs/dmemfs/Makefile
new file mode 100644
index 000000000000..73bdc9cbc87e
--- /dev/null
+++ b/fs/dmemfs/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for the linux dmem-filesystem routines.
+#
+obj-$(CONFIG_DMEM_FS) += dmemfs.o
+
+dmemfs-y += inode.o
diff --git a/fs/dmemfs/inode.c b/fs/dmemfs/inode.c
new file mode 100644
index 000000000000..6a8a2d9f94e9
--- /dev/null
+++ b/fs/dmemfs/inode.c
@@ -0,0 +1,275 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ *  linux/fs/dmemfs/inode.c
+ *
+ * Authors:
+ *   Xiao Guangrong  <gloryxiao@tencent.com>
+ *   Chen Zhuo	     <sagazchen@tencent.com>
+ *   Haiwei Li	     <gerryhwli@tencent.com>
+ *   Yulei Zhang     <yuleixzhang@tencent.com>
+ */
+
+#include <linux/module.h>
+#include <linux/fs.h>
+#include <linux/mount.h>
+#include <linux/file.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/string.h>
+#include <linux/capability.h>
+#include <linux/magic.h>
+#include <linux/mman.h>
+#include <linux/statfs.h>
+#include <linux/pagemap.h>
+#include <linux/parser.h>
+#include <linux/pfn_t.h>
+#include <linux/pagevec.h>
+#include <linux/fs_parser.h>
+#include <linux/seq_file.h>
+
+MODULE_AUTHOR("Tencent Corporation");
+MODULE_LICENSE("GPL v2");
+
+struct dmemfs_mount_opts {
+	unsigned long dpage_size;
+};
+
+struct dmemfs_fs_info {
+	struct dmemfs_mount_opts mount_opts;
+};
+
+enum dmemfs_param {
+	Opt_dpagesize,
+};
+
+const struct fs_parameter_spec dmemfs_fs_parameters[] = {
+	fsparam_string("pagesize", Opt_dpagesize),
+	{}
+};
+
+static int check_dpage_size(unsigned long dpage_size)
+{
+	if (dpage_size != PAGE_SIZE && dpage_size != PMD_SIZE &&
+	      dpage_size != PUD_SIZE)
+		return -EINVAL;
+
+	return 0;
+}
+
+static struct inode *
+dmemfs_get_inode(struct super_block *sb, const struct inode *dir, umode_t mode,
+		 dev_t dev);
+
+static int
+dmemfs_mknod(struct inode *dir, struct dentry *dentry, umode_t mode, dev_t dev)
+{
+	struct inode *inode = dmemfs_get_inode(dir->i_sb, dir, mode, dev);
+	int error = -ENOSPC;
+
+	if (inode) {
+		d_instantiate(dentry, inode);
+		dget(dentry);	/* Extra count - pin the dentry in core */
+		error = 0;
+		dir->i_mtime = dir->i_ctime = current_time(inode);
+	}
+	return error;
+}
+
+static int dmemfs_create(struct inode *dir, struct dentry *dentry,
+			 umode_t mode, bool excl)
+{
+	return dmemfs_mknod(dir, dentry, mode | S_IFREG, 0);
+}
+
+static int dmemfs_mkdir(struct inode *dir, struct dentry *dentry,
+			umode_t mode)
+{
+	int retval = dmemfs_mknod(dir, dentry, mode | S_IFDIR, 0);
+
+	if (!retval)
+		inc_nlink(dir);
+	return retval;
+}
+
+static const struct inode_operations dmemfs_dir_inode_operations = {
+	.create		= dmemfs_create,
+	.lookup		= simple_lookup,
+	.unlink		= simple_unlink,
+	.mkdir		= dmemfs_mkdir,
+	.rmdir		= simple_rmdir,
+	.rename		= simple_rename,
+};
+
+static const struct inode_operations dmemfs_file_inode_operations = {
+	.setattr = simple_setattr,
+	.getattr = simple_getattr,
+};
+
+int dmemfs_file_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	return 0;
+}
+
+static const struct file_operations dmemfs_file_operations = {
+	.mmap = dmemfs_file_mmap,
+};
+
+static int dmemfs_parse_param(struct fs_context *fc, struct fs_parameter *param)
+{
+	struct dmemfs_fs_info *fsi = fc->s_fs_info;
+	struct fs_parse_result result;
+	int opt, ret;
+
+	opt = fs_parse(fc, dmemfs_fs_parameters, param, &result);
+	if (opt < 0)
+		return opt;
+
+	switch (opt) {
+	case Opt_dpagesize:
+		fsi->mount_opts.dpage_size = memparse(param->string, NULL);
+		ret = check_dpage_size(fsi->mount_opts.dpage_size);
+		if (ret) {
+			pr_warn("dmemfs: unknown pagesize %x.\n",
+				result.uint_32);
+			return ret;
+		}
+		break;
+	default:
+		pr_warn("dmemfs: unknown mount option [%x].\n",
+			opt);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+struct inode *dmemfs_get_inode(struct super_block *sb,
+			       const struct inode *dir, umode_t mode, dev_t dev)
+{
+	struct inode *inode = new_inode(sb);
+
+	if (inode) {
+		inode->i_ino = get_next_ino();
+		inode_init_owner(inode, dir, mode);
+		inode->i_mapping->a_ops = &empty_aops;
+		mapping_set_gfp_mask(inode->i_mapping, GFP_HIGHUSER);
+		mapping_set_unevictable(inode->i_mapping);
+		inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
+		switch (mode & S_IFMT) {
+		default:
+			init_special_inode(inode, mode, dev);
+			break;
+		case S_IFREG:
+			inode->i_op = &dmemfs_file_inode_operations;
+			inode->i_fop = &dmemfs_file_operations;
+			break;
+		case S_IFDIR:
+			inode->i_op = &dmemfs_dir_inode_operations;
+			inode->i_fop = &simple_dir_operations;
+
+			/*
+			 * directory inodes start off with i_nlink == 2
+			 * (for "." entry)
+			 */
+			inc_nlink(inode);
+			break;
+		case S_IFLNK:
+			inode->i_op = &page_symlink_inode_operations;
+			break;
+		}
+	}
+	return inode;
+}
+
+static int dmemfs_statfs(struct dentry *dentry, struct kstatfs *buf)
+{
+	simple_statfs(dentry, buf);
+	buf->f_bsize = dentry->d_sb->s_blocksize;
+
+	return 0;
+}
+
+static const struct super_operations dmemfs_ops = {
+	.statfs	= dmemfs_statfs,
+	.drop_inode = generic_delete_inode,
+};
+
+static int
+dmemfs_fill_super(struct super_block *sb, struct fs_context *fc)
+{
+	struct inode *inode;
+	struct dmemfs_fs_info *fsi = sb->s_fs_info;
+
+	sb->s_maxbytes = MAX_LFS_FILESIZE;
+	sb->s_blocksize = fsi->mount_opts.dpage_size;
+	sb->s_blocksize_bits = ilog2(fsi->mount_opts.dpage_size);
+	sb->s_magic = DMEMFS_MAGIC;
+	sb->s_op = &dmemfs_ops;
+	sb->s_time_gran = 1;
+
+	inode = dmemfs_get_inode(sb, NULL, S_IFDIR, 0);
+	sb->s_root = d_make_root(inode);
+	if (!sb->s_root)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static int dmemfs_get_tree(struct fs_context *fc)
+{
+	return get_tree_nodev(fc, dmemfs_fill_super);
+}
+
+static void dmemfs_free_fc(struct fs_context *fc)
+{
+	kfree(fc->s_fs_info);
+}
+
+static const struct fs_context_operations dmemfs_context_ops = {
+	.free		= dmemfs_free_fc,
+	.parse_param	= dmemfs_parse_param,
+	.get_tree	= dmemfs_get_tree,
+};
+
+int dmemfs_init_fs_context(struct fs_context *fc)
+{
+	struct dmemfs_fs_info *fsi;
+
+	fsi = kzalloc(sizeof(*fsi), GFP_KERNEL);
+	if (!fsi)
+		return -ENOMEM;
+
+	fsi->mount_opts.dpage_size = PAGE_SIZE;
+	fc->s_fs_info = fsi;
+	fc->ops = &dmemfs_context_ops;
+	return 0;
+}
+
+static void dmemfs_kill_sb(struct super_block *sb)
+{
+	kill_litter_super(sb);
+}
+
+static struct file_system_type dmemfs_fs_type = {
+	.owner		= THIS_MODULE,
+	.name		= "dmemfs",
+	.init_fs_context = dmemfs_init_fs_context,
+	.kill_sb	= dmemfs_kill_sb,
+};
+
+static int __init dmemfs_init(void)
+{
+	int ret;
+
+	ret = register_filesystem(&dmemfs_fs_type);
+
+	return ret;
+}
+
+static void __exit dmemfs_uninit(void)
+{
+	unregister_filesystem(&dmemfs_fs_type);
+}
+
+module_init(dmemfs_init)
+module_exit(dmemfs_uninit)
diff --git a/include/uapi/linux/magic.h b/include/uapi/linux/magic.h
index f3956fc11de6..3fbd06661c8c 100644
--- a/include/uapi/linux/magic.h
+++ b/include/uapi/linux/magic.h
@@ -97,5 +97,6 @@
 #define DEVMEM_MAGIC		0x454d444d	/* "DMEM" */
 #define Z3FOLD_MAGIC		0x33
 #define PPC_CMM_MAGIC		0xc7571590
+#define DMEMFS_MAGIC		0x2ace90c6
 
 #endif /* __LINUX_MAGIC_H__ */
-- 
2.28.0

