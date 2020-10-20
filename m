Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 268582934FD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Oct 2020 08:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404299AbgJTGaU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Oct 2020 02:30:20 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:57172 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730310AbgJTGaT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Oct 2020 02:30:19 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R691e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=zoucao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0UCcQsrc_1603175410;
Received: from localhost(mailfrom:zoucao@linux.alibaba.com fp:SMTPD_---0UCcQsrc_1603175410)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 20 Oct 2020 14:30:10 +0800
From:   Zou Cao <zoucao@linux.alibaba.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/2] fs:regfs: add register easy filesystem
Date:   Tue, 20 Oct 2020 14:30:07 +0800
Message-Id: <1603175408-96164-1-git-send-email-zoucao@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

register filesystem is mapping the register into file dentry, it
will use the io readio to get the register val. DBT file is use
to decript the register tree, you can use it as follow:

	mount -t regfs -o dtb=test.dtb none /mnt

	test.dts:
	/ {

	compatible = "hisilicon,hi6220-hikey", "hisilicon,hi6220";
	#address-cells = <0x2>;
	#size-cells = <0x2>;
	model = "HiKey Development Board";

	gic-v3-dist{
		reg = <0x0 0x8000000 0x0 0x10000>;
		GIC_CTRL {
			offset = <0x0>;
		};
		GICD_TYPER {
			offset = <0x4>;
		};
	   };
	};

it will create all regiter dentry file in /mnt

Signed-off-by: Zou Cao <zoucao@linux.alibaba.com>
---
 fs/Kconfig             |   1 +
 fs/Makefile            |   1 +
 fs/regfs/Kconfig       |   7 +
 fs/regfs/Makefile      |   8 ++
 fs/regfs/file.c        | 107 +++++++++++++++
 fs/regfs/inode.c       | 354 +++++++++++++++++++++++++++++++++++++++++++++++++
 fs/regfs/internal.h    |  32 +++++
 fs/regfs/regfs_inode.h |  32 +++++
 fs/regfs/supper.c      |  71 ++++++++++
 9 files changed, 613 insertions(+)
 create mode 100644 fs/regfs/Kconfig
 create mode 100644 fs/regfs/Makefile
 create mode 100644 fs/regfs/file.c
 create mode 100644 fs/regfs/inode.c
 create mode 100644 fs/regfs/internal.h
 create mode 100644 fs/regfs/regfs_inode.h
 create mode 100644 fs/regfs/supper.c

diff --git a/fs/Kconfig b/fs/Kconfig
index a88aa3a..d95acaf 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -324,6 +324,7 @@ endif # NETWORK_FILESYSTEMS
 source "fs/nls/Kconfig"
 source "fs/dlm/Kconfig"
 source "fs/unicode/Kconfig"
+source "fs/regfs/Kconfig"
 
 config IO_WQ
 	bool
diff --git a/fs/Makefile b/fs/Makefile
index 2ce5112..24f3878 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -136,3 +136,4 @@ obj-$(CONFIG_EFIVAR_FS)		+= efivarfs/
 obj-$(CONFIG_EROFS_FS)		+= erofs/
 obj-$(CONFIG_VBOXSF_FS)		+= vboxsf/
 obj-$(CONFIG_ZONEFS_FS)		+= zonefs/
+obj-$(CONFIG_REGFS_FS)		+= zonefs/
diff --git a/fs/regfs/Kconfig b/fs/regfs/Kconfig
new file mode 100644
index 0000000..74ba85b
--- /dev/null
+++ b/fs/regfs/Kconfig
@@ -0,0 +1,7 @@
+config REGFS_FS
+	tristate "registers filesystem support"
+	depends on ARM64
+	help
+	  regfs support the read and write register of device resource by
+	  dentry filesystem, it is more easy to support bsp debug. it also
+	  support to printk the register val when panic
diff --git a/fs/regfs/Makefile b/fs/regfs/Makefile
new file mode 100644
index 0000000..26d5eef
--- /dev/null
+++ b/fs/regfs/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+#Makefile for the linux ramfs routines.
+#
+
+obj-y += regfs.o
+
+regfs-objs += inode.o file.o supper.o
diff --git a/fs/regfs/file.c b/fs/regfs/file.c
new file mode 100644
index 0000000..6cd9f3d
--- /dev/null
+++ b/fs/regfs/file.c
@@ -0,0 +1,107 @@
+#include <linux/fs.h>
+#include <linux/mm.h>
+#include <linux/mpage.h>
+#include <linux/writeback.h>
+#include <linux/buffer_head.h>
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/memcontrol.h>
+#include <linux/iomap.h>
+#include <linux/pagemap.h>
+#include <linux/uio.h>
+#include <linux/buffer_head.h>
+#include <linux/dax.h>
+#include <linux/writeback.h>
+#include <linux/swap.h>
+#include <linux/bio.h>
+#include <linux/sched/signal.h>
+#include <linux/migrate.h>
+
+#include "regfs_inode.h"
+#include "internal.h"
+
+ssize_t regfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
+{
+	struct file *file = iocb->ki_filp;
+	struct inode *inode = file->f_mapping->host;
+	ssize_t ret;
+
+	inode_lock(inode);
+	ret = generic_write_checks(iocb, from);
+	if (ret > 0)
+		ret = __generic_file_write_iter(iocb, from);
+	inode_unlock(inode);
+
+	if (ret > 0)
+		ret = generic_write_sync(iocb, ret);
+	return ret;
+}
+
+static ssize_t regfs_file_read(struct file *file, char __user *buf, size_t len, loff_t *ppos)
+{
+	struct address_space *mapping = file->f_mapping;
+	struct regfs_inode_info  *info = REGFS_I(mapping->host);
+	char str[64];
+	unsigned long val;
+
+	val = readl_relaxed(info->base + info->offset);
+
+	loc_debug("name:%s base:%p val:%lx\n"
+			, file->f_path.dentry->d_iname
+			, info->base + info->offset
+			, val);
+
+	snprintf(str, 64, "%lx", val);
+
+	return simple_read_from_buffer(buf, len, ppos, str, strlen(str));
+}
+
+static ssize_t regfs_file_write(struct file *file, const char __user *buf, size_t len, loff_t *ppos)
+{
+	struct address_space *mapping = file->f_mapping;
+	struct regfs_inode_info  *info = REGFS_I(mapping->host);
+	char str[67];
+	unsigned long val = 0;
+	loff_t pos = *ppos;
+	size_t res;
+
+	if (pos < 0)
+		return -EINVAL;
+	if (pos >= len || len > 66)
+		return 0;
+
+	res = copy_from_user(str, buf, len);
+	if (res)
+		return -EFAULT;
+	str[len] = 0;
+
+	if (kstrtoul(str, 16, &val) < 0)
+		return -EINVAL;
+
+	writel_relaxed(val, info->base + info->offset);
+
+	loc_debug("name:%s base:%p val:%lx\n"
+			, file->f_path.dentry->d_iname
+			, info->base + info->offset
+			, val);
+
+	return len;
+}
+
+const struct file_operations regfs_file_operations = {
+	.read = regfs_file_read,
+	.write = regfs_file_write,
+};
+
+const struct inode_operations regfs_file_inode_operations = {
+	.setattr	= simple_setattr,
+	.getattr	= simple_getattr,
+};
+
+const struct address_space_operations regfs_aops = {
+	.readpage   = simple_readpage,
+	.write_begin    = simple_write_begin,
+	.write_end  = simple_write_end,
+	.set_page_dirty = __set_page_dirty_buffers,
+};
+
diff --git a/fs/regfs/inode.c b/fs/regfs/inode.c
new file mode 100644
index 0000000..1643fcd
--- /dev/null
+++ b/fs/regfs/inode.c
@@ -0,0 +1,354 @@
+/*
+ * Resizable simple ram filesystem for Linux.
+ *
+ * Copyright (C) 2000 Linus Torvalds.
+ *               2000 Transmeta Corp.
+ *
+ * Usage limits added by David Gibson, Linuxcare Australia.
+ * This file is released under the GPL.
+ */
+
+/*
+ * NOTE! This filesystem is probably most useful
+ * not as a real filesystem, but as an example of
+ * how virtual filesystems can be written.
+ *
+ * It doesn't get much simpler than this. Consider
+ * that this file implements the full semantics of
+ * a POSIX-compliant read-write filesystem.
+ *
+ * Note in particular how the filesystem does not
+ * need to implement any data structures of its own
+ * to keep track of the virtual data: using the VFS
+ * caches is sufficient.
+ */
+
+#include <linux/fs.h>
+#include <linux/pagemap.h>
+#include <linux/highmem.h>
+#include <linux/time.h>
+#include <linux/init.h>
+#include <linux/string.h>
+#include <linux/backing-dev.h>
+#include <linux/sched.h>
+#include <linux/parser.h>
+#include <linux/magic.h>
+#include <linux/slab.h>
+#include <linux/kernel.h>
+#include <linux/of.h>
+#include <linux/of_fdt.h>
+#include <linux/libfdt.h>
+#include <asm/uaccess.h>
+#include <linux/module.h>
+#include "regfs_inode.h"
+#include "internal.h"
+
+static LIST_HEAD(regfs_head);
+
+static const struct inode_operations regfs_dir_inode_operations;
+int regfs_debug;
+module_param(regfs_debug, int, S_IRUGO);
+MODULE_PARM_DESC(regfs_debug, "enable regfs debug mode");
+
+struct inode *regfs_get_inode(struct super_block *sb, const struct inode *dir, umode_t mode, dev_t dev)
+{
+	struct inode *inode = new_inode(sb);
+
+	if (inode) {
+		inode->i_ino = get_next_ino();
+		inode_init_owner(inode, dir, mode);
+		inode->i_mapping->a_ops = &regfs_aops;
+		//inode->i_mapping->backing_dev_info = &regfs_backing_dev_info;
+		mapping_set_gfp_mask(inode->i_mapping, GFP_HIGHUSER);
+		mapping_set_unevictable(inode->i_mapping);
+		inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
+		switch (mode & S_IFMT) {
+		default:
+			init_special_inode(inode, mode, dev);
+			break;
+		case S_IFREG:
+			inode->i_op = &regfs_file_inode_operations;
+			inode->i_fop = &regfs_file_operations;
+			break;
+		case S_IFDIR:
+			inode->i_op = &regfs_dir_inode_operations;
+			inode->i_fop = &simple_dir_operations;
+
+			/* directory inodes start off with i_nlink == 2 (for "." entry) */
+			inc_nlink(inode);
+			break;
+		case S_IFLNK:
+			inode->i_op = &page_symlink_inode_operations;
+			break;
+		}
+	}
+
+	return inode;
+}
+
+static const struct inode_operations regfs_dir_inode_operations = {
+	.lookup		= simple_lookup,
+};
+
+static struct dentry *new_dentry_create(struct super_block *sb, struct dentry *parent,
+		 const char *name, bool is_dir, struct res_data *res)
+{
+	struct dentry *dentry;
+	struct inode *inode;
+	struct regfs_inode_info *ei;
+	struct regfs_fs_info *fsi = sb->s_fs_info;
+
+	dentry = d_alloc_name(parent, name);
+	if (!dentry)
+		return NULL;
+
+	inode = new_inode(sb);
+	if (!inode)
+		goto out;
+
+	ei = REGFS_I(inode);
+	inode->i_ino = get_next_ino();;
+	inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
+	inode->i_uid =  GLOBAL_ROOT_UID;
+	inode->i_gid =  GLOBAL_ROOT_GID;
+	if (is_dir) {
+		inode->i_mode = S_IFDIR | S_IRUGO | S_IWUSR;
+		inode->i_op = &regfs_dir_inode_operations;
+		inode->i_fop = &simple_dir_operations;
+		list_add(&ei->list, &fsi->list);
+	} else {
+		inode->i_mode = S_IFREG | S_IRUGO | S_IWUSR;
+		inode->i_op = &regfs_file_inode_operations;
+		inode->i_fop = &regfs_file_operations;
+		inc_nlink(inode);
+	}
+	ei->base = (void *)res->base;
+	ei->offset = res->offset;
+	ei->type = res->type;
+
+	d_add(dentry, inode);
+
+	loc_debug("new dentry io base:%llx offset:%llx ei:%llx\n", (u64)ei->base, (u64)ei->offset, (u64)ei);
+	return dentry;
+out:
+	dput(dentry);
+	return NULL;
+}
+
+static void node_transfer_dentry(struct super_block *sb)
+{
+	struct regfs_fs_info *fsi = sb->s_fs_info;
+	void *blob = fsi->dtb_buf;
+	const char *pathp;
+	int node_offset, depth = -1;
+	struct dentry *parent = NULL;
+	u64 parent_base;
+
+	for (node_offset = fdt_next_node(blob, -1, &depth);
+		node_offset >= 0 && depth >= 0;
+		node_offset = fdt_next_node(blob, node_offset, &depth)) {
+
+		const struct fdt_property *prop;
+		struct res_data res;
+
+		pathp = fdt_get_name(blob, node_offset, NULL);
+		prop = (void *)fdt_getprop(blob, node_offset, "reg", NULL);
+
+		if (prop) {
+			unsigned long phys;
+
+			phys = fdt32_to_cpu(((const __be32 *)prop)[1]);
+			res.type = RES_TYPE_RANGE;
+			res.offset = fdt32_to_cpu(((const __be32 *)prop)[3]);
+			res.base = (u64)ioremap(phys, res.offset);
+
+			if (!res.base) {
+				parent = NULL;
+				parent_base = 0;
+				continue;
+			}
+
+			loc_debug("%s reg:%lx size:%lx map:%llx\n\n", pathp
+				 , (unsigned long) fdt32_to_cpu(((const __be32 *)prop)[1])
+				 , (unsigned long) fdt32_to_cpu(((const __be32 *)prop)[3])
+				 , (u64)res.base);
+
+			parent = new_dentry_create(sb, sb->s_root, (const char *)pathp, true, &res);
+			parent_base = res.base;
+
+		} else {
+			// parent dentry is create failed, igonre all child dentry
+			if (!parent)
+				continue;
+
+			prop = (void *)fdt_getprop(blob, node_offset, "offset", NULL);
+			if (prop) {
+
+				res.offset = fdt32_to_cpu(*(const __be32 *)prop);
+				res.base = parent_base;
+				res.type = RES_TYPE_ITEM;
+
+				new_dentry_create(sb, parent, (const char *) pathp, false, &res);
+				loc_debug("%s offset:%lx\n", pathp, (unsigned long)fdt32_to_cpu(*(const __be32 *)prop));
+			}
+		}
+	}
+}
+
+static int parse_options(char *options, struct super_block *sb)
+{
+	char *p;
+	int ret = -EINVAL;
+	struct regfs_fs_info *fsi;
+	size_t msize = INT_MAX;
+
+	fsi = sb->s_fs_info;
+
+	if (!options)
+		return -EINVAL;
+
+	while ((p = strsep(&options, ",")) != NULL) {
+		char *name, *name_val;
+
+		name = strsep(&p, "=");
+		if (name == NULL)
+			goto failed;
+
+		name_val = strsep(&p, "=");
+		if (name_val == NULL)
+			goto failed;
+
+		//get resource address
+		if (!strcmp(name, "dtb")) {
+			ret = kernel_read_file_from_path(name_val, &fsi->dtb_buf, &fsi->dtb_len, msize, READING_UNKNOWN);
+			if (ret) {
+				pr_err("load %s failed\n", name_val);
+				goto failed;
+			}
+		} else
+			goto failed;
+	};
+
+	return 0;
+
+failed:
+	return ret;
+}
+
+int regfs_fill_super(struct super_block *sb, void *data, int silent)
+{
+	struct regfs_fs_info *fsi;
+	struct inode *inode;
+	int err;
+
+	fsi = kzalloc(sizeof(struct regfs_fs_info), GFP_KERNEL);
+	if (!fsi)
+		return -ENOMEM;
+
+	sb->s_fs_info = fsi;
+	fsi->sb = sb;
+
+	err = parse_options((char *)data, sb);
+	if (err)
+		goto out;
+
+	sb->s_maxbytes		= MAX_LFS_FILESIZE;
+	sb->s_blocksize		= PAGE_SIZE;
+	sb->s_blocksize_bits	= PAGE_SHIFT;
+	sb->s_magic		= RAMFS_MAGIC;
+	sb->s_op		= &regfs_ops;
+	sb->s_time_gran		= 1;
+
+	inode = regfs_get_inode(sb, NULL, S_IFDIR, 0);
+	sb->s_root = d_make_root(inode);
+	if (!sb->s_root)
+		goto out;
+
+	INIT_LIST_HEAD(&fsi->list);
+	INIT_LIST_HEAD(&fsi->regfs_head);
+	list_add(&fsi->regfs_head, &regfs_head);
+
+	return 0;
+
+out:
+	if (fsi)
+		kfree(fsi);
+
+	return err;
+}
+
+struct dentry *regfs_mount(struct file_system_type *fs_type,
+	int flags, const char *dev_name, void *data)
+{
+	struct dentry *root_dentry;
+	struct super_block *sb;
+
+	root_dentry = mount_nodev(fs_type, flags, data, regfs_fill_super);
+
+	sb = root_dentry->d_sb;
+
+	if (sb->s_root) {
+		node_transfer_dentry(sb);
+	} else
+		return NULL;
+
+	return root_dentry;
+}
+
+static void regfs_kill_sb(struct super_block *sb)
+{
+	struct regfs_fs_info *fsi = sb->s_fs_info;
+	struct regfs_inode_info *info_res;
+
+	list_for_each_entry(info_res,  &fsi->list, list)
+		iounmap(info_res->base);
+
+	if (fsi) {
+		if (fsi->dtb_buf)
+			vfree(fsi->dtb_buf);
+		list_del(&fsi->regfs_head);
+		kfree(sb->s_fs_info);
+	}
+	kill_litter_super(sb);
+}
+
+static struct file_system_type regfs_fs_type = {
+	.name		= "regfs",
+	.mount		= regfs_mount,
+	.kill_sb	= regfs_kill_sb,
+	.fs_flags	= FS_USERNS_MOUNT,
+};
+
+static void init_once(void *foo)
+{
+	struct regfs_inode_info *ei = (struct regfs_inode_info *) foo;
+
+	inode_init_once(&ei->vfs_inode);
+}
+
+static int __init init_regfs_fs(void)
+{
+
+	regfs_inode_cachep = kmem_cache_create_usercopy("regfs_inode_cache",
+				sizeof(struct regfs_inode_info), 0,
+				(SLAB_RECLAIM_ACCOUNT | SLAB_MEM_SPREAD | SLAB_ACCOUNT),
+				0, 0, init_once);
+
+	if (!regfs_inode_cachep)
+		return -ENOMEM;
+
+	return  register_filesystem(&regfs_fs_type);
+}
+
+static void __exit exit_regfs_fs(void)
+{
+	unregister_filesystem(&regfs_fs_type);
+	rcu_barrier();
+	kmem_cache_destroy(regfs_inode_cachep);
+}
+
+module_init(init_regfs_fs);
+module_exit(exit_regfs_fs);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Zou Cao<zoucaox@linux.alibaba.com>");
diff --git a/fs/regfs/internal.h b/fs/regfs/internal.h
new file mode 100644
index 0000000..61577bb
--- /dev/null
+++ b/fs/regfs/internal.h
@@ -0,0 +1,32 @@
+#ifndef __INTERNAL_H__
+#define __INTERNAL_H__
+
+#define loc_debug(fmt, ...)   \
+	do {                       \
+		if (regfs_debug)   \
+			printk(fmt, ##__VA_ARGS__); \
+	} while (0)
+
+struct regfs_fs_info {
+	struct super_block *sb;
+	void   *dtb_buf;
+	u64  	dtb_len;
+	u64  	iomem;
+	u64  size;
+	// supper ifs list
+	struct list_head regfs_head;
+	// io map list of inode
+	struct list_head list;
+};
+
+#define RAMFS_DEFAULT_MODE	0755
+
+extern int regfs_debug;
+extern const struct address_space_operations regfs_aops;
+extern const struct inode_operations regfs_file_inode_operations;
+extern const struct file_operations regfs_file_operations;
+extern const struct super_operations regfs_ops;
+extern struct kmem_cache *regfs_inode_cachep;
+int regfs_supper_init(void);
+
+#endif
diff --git a/fs/regfs/regfs_inode.h b/fs/regfs/regfs_inode.h
new file mode 100644
index 0000000..0883e05
--- /dev/null
+++ b/fs/regfs/regfs_inode.h
@@ -0,0 +1,32 @@
+#ifndef __REGFS_INODE_H__
+#define __REGFS_INODE_H__
+
+enum res_type {
+	RES_TYPE_NONE = 0,
+	RES_TYPE_RANGE,
+	RES_TYPE_ITEM,
+};
+
+struct regfs_inode_info {
+	unsigned long flag;
+	struct inode vfs_inode;
+	void __iomem *base;
+	u64  offset;
+	u64  val;  //for panic save
+	struct list_head list;  //inode list
+	enum res_type type;
+};
+
+struct res_data {
+	enum res_type type;
+	u64  base;
+	u64  offset;
+};
+
+static inline struct regfs_inode_info *REGFS_I(struct inode *inode)
+{
+	return container_of(inode, struct regfs_inode_info, vfs_inode);
+}
+
+#endif
+
diff --git a/fs/regfs/supper.c b/fs/regfs/supper.c
new file mode 100644
index 0000000..35733b6
--- /dev/null
+++ b/fs/regfs/supper.c
@@ -0,0 +1,71 @@
+#include <linux/fs.h>
+#include <linux/pagemap.h>
+#include <linux/highmem.h>
+#include <linux/time.h>
+#include <linux/init.h>
+#include <linux/string.h>
+#include <linux/backing-dev.h>
+#include <linux/sched.h>
+#include <linux/parser.h>
+#include <linux/magic.h>
+#include <linux/slab.h>
+#include <linux/kernel.h>
+#include <linux/uaccess.h>
+#include <linux/module.h>
+#include <linux/iversion.h>
+#include "regfs_inode.h"
+#include "internal.h"
+
+struct kmem_cache *regfs_inode_cachep;
+
+/*
+ * Display the mount options in /proc/mounts.
+ */
+
+static struct inode *regfs_alloc_inode(struct super_block *sb)
+{
+	struct regfs_inode_info *ei;
+
+	ei = kmem_cache_alloc(regfs_inode_cachep, GFP_NOFS);
+	if (!ei)
+		return NULL;
+
+	inode_set_iversion(&ei->vfs_inode, 1);
+	ei->type = RES_TYPE_NONE;
+
+	return &ei->vfs_inode;
+}
+
+static void regfs_i_callback(struct rcu_head *head)
+{
+	struct inode *inode = container_of(head, struct inode, i_rcu);
+
+	kmem_cache_free(regfs_inode_cachep, REGFS_I(inode));
+}
+
+static void regfs_destroy_inode(struct inode *inode)
+{
+	call_rcu(&inode->i_rcu, regfs_i_callback);
+}
+
+static int regfs_write_inode(struct inode *inode, struct writeback_control *wbc)
+{
+	return 0;
+}
+
+static int regfs_drop_inode(struct inode *inode)
+{
+	return generic_drop_inode(inode);
+}
+
+const struct super_operations regfs_ops = {
+	.alloc_inode    = regfs_alloc_inode,
+	.destroy_inode  = regfs_destroy_inode,
+	.write_inode    = regfs_write_inode,
+	.drop_inode = regfs_drop_inode,
+};
+
+int regfs_supper_init(void)
+{
+	return 0;
+}
-- 
1.8.3.1

