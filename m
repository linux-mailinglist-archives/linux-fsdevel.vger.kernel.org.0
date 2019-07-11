Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EDD5659C7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2019 16:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729205AbfGKO6n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Jul 2019 10:58:43 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2219 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728892AbfGKO6m (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Jul 2019 10:58:42 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 6089A3C3145F2A7827F6;
        Thu, 11 Jul 2019 22:58:38 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.209) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 11 Jul
 2019 22:58:29 +0800
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
Subject: [PATCH v2 11/24] erofs: introduce xattr & posixacl support
Date:   Thu, 11 Jul 2019 22:57:42 +0800
Message-ID: <20190711145755.33908-12-gaoxiang25@huawei.com>
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

This implements xattr and posixacl functionalities.

1) Inline and shared xattrs are introduced for flexibility.

   Specifically, if the same xattr is used for a large number of
   inodes or the size of a xattr is so large that unsuitable to
   inline, a shared xattr will be used instead in xattr meta.

2) Add .get_acl() to read the file's acl from its xattrs to
   make POSIX ACL usable.

   Here is the on-disk detail,
   fullname: system.posix_acl_access
   struct erofs_xattr_entry:
           .e_name_len = 0
           .e_name_index = EROFS_XATTR_INDEX_POSIX_ACL_ACCESS (2)

   fullname: system.posix_acl_default
   struct erofs_xattr_entry:
           .e_name_len = 0
           .e_name_index = EROFS_XATTR_INDEX_POSIX_ACL_DEFAULT (3)

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 fs/erofs/Kconfig    |  37 +++
 fs/erofs/Makefile   |   1 +
 fs/erofs/inode.c    |  14 +-
 fs/erofs/internal.h |  16 +
 fs/erofs/namei.c    |   6 +-
 fs/erofs/super.c    |  78 ++++-
 fs/erofs/xattr.c    | 700 ++++++++++++++++++++++++++++++++++++++++++++
 fs/erofs/xattr.h    |  93 ++++++
 8 files changed, 942 insertions(+), 3 deletions(-)
 create mode 100644 fs/erofs/xattr.c
 create mode 100644 fs/erofs/xattr.h

diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
index bcab58d3f709..b6a4384936b3 100644
--- a/fs/erofs/Kconfig
+++ b/fs/erofs/Kconfig
@@ -43,3 +43,40 @@ config EROFS_FS_IO_MAX_RETRIES
 
 	  If unsure, leave the default value (5 retries, 6 IOs at most).
 
+config EROFS_FS_XATTR
+	bool "EROFS extended attributes"
+	depends on EROFS_FS
+	default y
+	help
+	  Extended attributes are name:value pairs associated with inodes by
+	  the kernel or by users (see the attr(5) manual page, or visit
+	  <http://acl.bestbits.at/> for details).
+
+	  If unsure, say N.
+
+config EROFS_FS_POSIX_ACL
+	bool "EROFS Access Control Lists"
+	depends on EROFS_FS_XATTR
+	select FS_POSIX_ACL
+	default y
+	help
+	  Posix Access Control Lists (ACLs) support permissions for users and
+	  groups beyond the owner/group/world scheme.
+
+	  To learn more about Access Control Lists, visit the POSIX ACLs for
+	  Linux website <http://acl.bestbits.at/>.
+
+	  If you don't know what Access Control Lists are, say N.
+
+config EROFS_FS_SECURITY
+	bool "EROFS Security Labels"
+	depends on EROFS_FS_XATTR
+	help
+	  Security labels provide an access control facility to support Linux
+	  Security Models (LSMs) accepted by AppArmor, SELinux, Smack and TOMOYO
+	  Linux. This option enables an extended attribute handler for file
+	  security labels in the erofs filesystem, so that it requires enabling
+	  the extended attribute support in advance.
+
+	  If you are not using a security module, say N.
+
diff --git a/fs/erofs/Makefile b/fs/erofs/Makefile
index ec2795f33dc5..fc5d1cd3345f 100644
--- a/fs/erofs/Makefile
+++ b/fs/erofs/Makefile
@@ -6,4 +6,5 @@ ccflags-y += -DEROFS_VERSION=\"$(EROFS_VERSION)\"
 
 obj-$(CONFIG_EROFS_FS) += erofs.o
 erofs-objs := super.o inode.o data.o namei.o dir.o
+erofs-$(CONFIG_EROFS_FS_XATTR) += xattr.o
 
diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index 5a95cd076fcc..8fa5cdf6c0de 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -6,7 +6,7 @@
  *             http://www.huawei.com/
  * Created by Gao Xiang <gaoxiang25@huawei.com>
  */
-#include "internal.h"
+#include "xattr.h"
 
 #include <trace/events/erofs.h>
 
@@ -300,15 +300,27 @@ int erofs_getattr(const struct path *path, struct kstat *stat,
 
 const struct inode_operations erofs_generic_iops = {
 	.getattr = erofs_getattr,
+#ifdef CONFIG_EROFS_FS_XATTR
+	.listxattr = erofs_listxattr,
+#endif
+	.get_acl = erofs_get_acl,
 };
 
 const struct inode_operations erofs_symlink_iops = {
 	.get_link = page_get_link,
 	.getattr = erofs_getattr,
+#ifdef CONFIG_EROFS_FS_XATTR
+	.listxattr = erofs_listxattr,
+#endif
+	.get_acl = erofs_get_acl,
 };
 
 const struct inode_operations erofs_fast_symlink_iops = {
 	.get_link = simple_get_link,
 	.getattr = erofs_getattr,
+#ifdef CONFIG_EROFS_FS_XATTR
+	.listxattr = erofs_listxattr,
+#endif
+	.get_acl = erofs_get_acl,
 };
 
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 03ce8420d20c..ccef7f2a7cf3 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -62,6 +62,9 @@ typedef u32 erofs_blk_t;
 struct erofs_sb_info {
 	u32 blocks;
 	u32 meta_blkaddr;
+#ifdef CONFIG_EROFS_FS_XATTR
+	u32 xattr_blkaddr;
+#endif
 
 	/* inode slot unit size in bit shift */
 	unsigned char islotbits;
@@ -132,6 +135,8 @@ static inline void *erofs_kmalloc(struct erofs_sb_info *sbi,
 #define EROFS_I_SB(inode) ((struct erofs_sb_info *)(inode)->i_sb->s_fs_info)
 
 /* Mount flags set via mount options or defaults */
+#define EROFS_MOUNT_XATTR_USER		0x00000010
+#define EROFS_MOUNT_POSIX_ACL		0x00000020
 #define EROFS_MOUNT_FAULT_INJECTION	0x00000040
 
 #define clear_opt(sbi, option)	((sbi)->mount_opt &= ~EROFS_MOUNT_##option)
@@ -164,13 +169,24 @@ static inline erofs_off_t iloc(struct erofs_sb_info *sbi, erofs_nid_t nid)
 	return blknr_to_addr(sbi->meta_blkaddr) + (nid << sbi->islotbits);
 }
 
+/* atomic flag definitions */
+#define EROFS_V_EA_INITED_BIT	0
+
+/* bitlock definitions (arranged in reverse order) */
+#define EROFS_V_BL_XATTR_BIT	(BITS_PER_LONG - 1)
 struct erofs_vnode {
 	erofs_nid_t nid;
 
+	/* atomic flags (including bitlocks) */
+	unsigned long flags;
+
 	unsigned char datamode;
 	unsigned char inode_isize;
 	unsigned short xattr_isize;
 
+	unsigned xattr_shared_count;
+	unsigned *xattr_shared_xattrs;
+
 	erofs_blk_t raw_blkaddr;
 	/* the corresponding vfs inode */
 	struct inode vfs_inode;
diff --git a/fs/erofs/namei.c b/fs/erofs/namei.c
index 7665d3603503..0e9675dc4f37 100644
--- a/fs/erofs/namei.c
+++ b/fs/erofs/namei.c
@@ -6,7 +6,7 @@
  *             http://www.huawei.com/
  * Created by Gao Xiang <gaoxiang25@huawei.com>
  */
-#include "internal.h"
+#include "xattr.h"
 
 #include <trace/events/erofs.h>
 
@@ -242,5 +242,9 @@ static struct dentry *erofs_lookup(struct inode *dir,
 const struct inode_operations erofs_dir_iops = {
 	.lookup = erofs_lookup,
 	.getattr = erofs_getattr,
+#ifdef CONFIG_EROFS_FS_XATTR
+	.listxattr = erofs_listxattr,
+#endif
+	.get_acl = erofs_get_acl,
 };
 
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index d83e55bdd4a8..bb1ae1f416e6 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -11,7 +11,7 @@
 #include <linux/statfs.h>
 #include <linux/parser.h>
 #include <linux/seq_file.h>
-#include "internal.h"
+#include "xattr.h"
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/erofs.h>
@@ -61,6 +61,8 @@ static void free_inode(struct inode *inode)
 	if (is_inode_fast_symlink(inode))
 		kfree(inode->i_link);
 
+	kfree(vi->xattr_shared_xattrs);
+
 	kmem_cache_free(erofs_inode_cachep, vi);
 }
 
@@ -118,6 +120,9 @@ static int superblock_read(struct super_block *sb)
 
 	sbi->blocks = le32_to_cpu(layout->blocks);
 	sbi->meta_blkaddr = le32_to_cpu(layout->meta_blkaddr);
+#ifdef CONFIG_EROFS_FS_XATTR
+	sbi->xattr_blkaddr = le32_to_cpu(layout->xattr_blkaddr);
+#endif
 	sbi->islotbits = ffs(sizeof(struct erofs_inode_v1)) - 1;
 	sbi->root_nid = le16_to_cpu(layout->root_nid);
 	sbi->inos = le64_to_cpu(layout->inos);
@@ -195,14 +200,29 @@ static unsigned int erofs_get_fault_rate(struct erofs_sb_info *sbi)
 /* set up default EROFS parameters */
 static void default_options(struct erofs_sb_info *sbi)
 {
+#ifdef CONFIG_EROFS_FS_XATTR
+	set_opt(sbi, XATTR_USER);
+#endif
+
+#ifdef CONFIG_EROFS_FS_POSIX_ACL
+	set_opt(sbi, POSIX_ACL);
+#endif
 }
 
 enum {
+	Opt_user_xattr,
+	Opt_nouser_xattr,
+	Opt_acl,
+	Opt_noacl,
 	Opt_fault_injection,
 	Opt_err
 };
 
 static match_table_t erofs_tokens = {
+	{Opt_user_xattr, "user_xattr"},
+	{Opt_nouser_xattr, "nouser_xattr"},
+	{Opt_acl, "acl"},
+	{Opt_noacl, "noacl"},
 	{Opt_fault_injection, "fault_injection=%u"},
 	{Opt_err, NULL}
 };
@@ -226,6 +246,36 @@ static int parse_options(struct super_block *sb, char *options)
 		token = match_token(p, erofs_tokens, args);
 
 		switch (token) {
+#ifdef CONFIG_EROFS_FS_XATTR
+		case Opt_user_xattr:
+			set_opt(EROFS_SB(sb), XATTR_USER);
+			break;
+		case Opt_nouser_xattr:
+			clear_opt(EROFS_SB(sb), XATTR_USER);
+			break;
+#else
+		case Opt_user_xattr:
+			infoln("user_xattr options not supported");
+			break;
+		case Opt_nouser_xattr:
+			infoln("nouser_xattr options not supported");
+			break;
+#endif
+#ifdef CONFIG_EROFS_FS_POSIX_ACL
+		case Opt_acl:
+			set_opt(EROFS_SB(sb), POSIX_ACL);
+			break;
+		case Opt_noacl:
+			clear_opt(EROFS_SB(sb), POSIX_ACL);
+			break;
+#else
+		case Opt_acl:
+			infoln("acl options not supported");
+			break;
+		case Opt_noacl:
+			infoln("noacl options not supported");
+			break;
+#endif
 		case Opt_fault_injection:
 			err = erofs_build_fault_attr(EROFS_SB(sb), args);
 			if (err)
@@ -274,6 +324,10 @@ static int erofs_read_super(struct super_block *sb,
 
 	sb->s_op = &erofs_sops;
 
+#ifdef CONFIG_EROFS_FS_XATTR
+	sb->s_xattr = erofs_xattr_handlers;
+#endif
+
 	/* set erofs default mount options */
 	default_options(sbi);
 
@@ -284,6 +338,11 @@ static int erofs_read_super(struct super_block *sb,
 	if (!silent)
 		infoln("root inode @ nid %llu", ROOT_NID(sbi));
 
+	if (test_opt(sbi, POSIX_ACL))
+		sb->s_flags |= SB_POSIXACL;
+	else
+		sb->s_flags &= ~SB_POSIXACL;
+
 	/* get the root inode */
 	inode = erofs_iget(sb, ROOT_NID(sbi), true);
 	if (IS_ERR(inode)) {
@@ -457,6 +516,18 @@ static int erofs_show_options(struct seq_file *seq, struct dentry *root)
 {
 	struct erofs_sb_info *sbi __maybe_unused = EROFS_SB(root->d_sb);
 
+#ifdef CONFIG_EROFS_FS_XATTR
+	if (test_opt(sbi, XATTR_USER))
+		seq_puts(seq, ",user_xattr");
+	else
+		seq_puts(seq, ",nouser_xattr");
+#endif
+#ifdef CONFIG_EROFS_FS_POSIX_ACL
+	if (test_opt(sbi, POSIX_ACL))
+		seq_puts(seq, ",acl");
+	else
+		seq_puts(seq, ",noacl");
+#endif
 	if (test_opt(sbi, FAULT_INJECTION))
 		seq_printf(seq, ",fault_injection=%u",
 			   erofs_get_fault_rate(sbi));
@@ -475,6 +546,11 @@ static int erofs_remount(struct super_block *sb, int *flags, char *data)
 	if (err)
 		goto out;
 
+	if (test_opt(sbi, POSIX_ACL))
+		sb->s_flags |= SB_POSIXACL;
+	else
+		sb->s_flags &= ~SB_POSIXACL;
+
 	*flags |= SB_RDONLY;
 	return 0;
 out:
diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
new file mode 100644
index 000000000000..4c48430af608
--- /dev/null
+++ b/fs/erofs/xattr.c
@@ -0,0 +1,700 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * linux/fs/erofs/xattr.c
+ *
+ * Copyright (C) 2017-2018 HUAWEI, Inc.
+ *             http://www.huawei.com/
+ * Created by Gao Xiang <gaoxiang25@huawei.com>
+ */
+#include <linux/security.h>
+#include "xattr.h"
+
+struct xattr_iter {
+	struct super_block *sb;
+	struct page *page;
+	void *kaddr;
+
+	erofs_blk_t blkaddr;
+	unsigned int ofs;
+};
+
+static inline void xattr_iter_end(struct xattr_iter *it, bool atomic)
+{
+	/* the only user of kunmap() is 'init_inode_xattrs' */
+	if (unlikely(!atomic))
+		kunmap(it->page);
+	else
+		kunmap_atomic(it->kaddr);
+
+	unlock_page(it->page);
+	put_page(it->page);
+}
+
+static inline void xattr_iter_end_final(struct xattr_iter *it)
+{
+	if (!it->page)
+		return;
+
+	xattr_iter_end(it, true);
+}
+
+static int init_inode_xattrs(struct inode *inode)
+{
+	struct erofs_vnode *const vi = EROFS_V(inode);
+	struct xattr_iter it;
+	unsigned int i;
+	struct erofs_xattr_ibody_header *ih;
+	struct super_block *sb;
+	struct erofs_sb_info *sbi;
+	bool atomic_map;
+	int ret = 0;
+
+	/* the most case is that xattrs of this inode are initialized. */
+	if (test_bit(EROFS_V_EA_INITED_BIT, &vi->flags))
+		return 0;
+
+	if (wait_on_bit_lock(&vi->flags, EROFS_V_BL_XATTR_BIT, TASK_KILLABLE))
+		return -ERESTARTSYS;
+
+	/* someone has initialized xattrs for us? */
+	if (test_bit(EROFS_V_EA_INITED_BIT, &vi->flags))
+		goto out_unlock;
+
+	/*
+	 * bypass all xattr operations if ->xattr_isize is not greater than
+	 * sizeof(struct erofs_xattr_ibody_header), in detail:
+	 * 1) it is not enough to contain erofs_xattr_ibody_header then
+	 *    ->xattr_isize should be 0 (it means no xattr);
+	 * 2) it is just to contain erofs_xattr_ibody_header, which is on-disk
+	 *    undefined right now (maybe use later with some new sb feature).
+	 */
+	if (vi->xattr_isize == sizeof(struct erofs_xattr_ibody_header)) {
+		errln("xattr_isize %d of nid %llu is not supported yet",
+		      vi->xattr_isize, vi->nid);
+		ret = -ENOTSUPP;
+		goto out_unlock;
+	} else if (vi->xattr_isize < sizeof(struct erofs_xattr_ibody_header)) {
+		if (unlikely(vi->xattr_isize)) {
+			DBG_BUGON(1);
+			ret = -EIO;
+			goto out_unlock;	/* xattr ondisk layout error */
+		}
+		ret = -ENOATTR;
+		goto out_unlock;
+	}
+
+	sb = inode->i_sb;
+	sbi = EROFS_SB(sb);
+	it.blkaddr = erofs_blknr(iloc(sbi, vi->nid) + vi->inode_isize);
+	it.ofs = erofs_blkoff(iloc(sbi, vi->nid) + vi->inode_isize);
+
+	it.page = erofs_get_inline_page(inode, it.blkaddr);
+	if (IS_ERR(it.page)) {
+		ret = PTR_ERR(it.page);
+		goto out_unlock;
+	}
+
+	/* read in shared xattr array (non-atomic, see kmalloc below) */
+	it.kaddr = kmap(it.page);
+	atomic_map = false;
+
+	ih = (struct erofs_xattr_ibody_header *)(it.kaddr + it.ofs);
+
+	vi->xattr_shared_count = ih->h_shared_count;
+	vi->xattr_shared_xattrs = kmalloc_array(vi->xattr_shared_count,
+						sizeof(uint), GFP_KERNEL);
+	if (!vi->xattr_shared_xattrs) {
+		xattr_iter_end(&it, atomic_map);
+		ret = -ENOMEM;
+		goto out_unlock;
+	}
+
+	/* let's skip ibody header */
+	it.ofs += sizeof(struct erofs_xattr_ibody_header);
+
+	for (i = 0; i < vi->xattr_shared_count; ++i) {
+		if (unlikely(it.ofs >= EROFS_BLKSIZ)) {
+			/* cannot be unaligned */
+			BUG_ON(it.ofs != EROFS_BLKSIZ);
+			xattr_iter_end(&it, atomic_map);
+
+			it.page = erofs_get_meta_page(sb, ++it.blkaddr,
+						      S_ISDIR(inode->i_mode));
+			if (IS_ERR(it.page)) {
+				kfree(vi->xattr_shared_xattrs);
+				vi->xattr_shared_xattrs = NULL;
+				ret = PTR_ERR(it.page);
+				goto out_unlock;
+			}
+
+			it.kaddr = kmap_atomic(it.page);
+			atomic_map = true;
+			it.ofs = 0;
+		}
+		vi->xattr_shared_xattrs[i] =
+			le32_to_cpu(*(__le32 *)(it.kaddr + it.ofs));
+		it.ofs += sizeof(__le32);
+	}
+	xattr_iter_end(&it, atomic_map);
+
+	set_bit(EROFS_V_EA_INITED_BIT, &vi->flags);
+
+out_unlock:
+	clear_and_wake_up_bit(EROFS_V_BL_XATTR_BIT, &vi->flags);
+	return ret;
+}
+
+/*
+ * the general idea for these return values is
+ * if    0 is returned, go on processing the current xattr;
+ *       1 (> 0) is returned, skip this round to process the next xattr;
+ *    -err (< 0) is returned, an error (maybe ENOXATTR) occurred
+ *                            and need to be handled
+ */
+struct xattr_iter_handlers {
+	int (*entry)(struct xattr_iter *_it, struct erofs_xattr_entry *entry);
+	int (*name)(struct xattr_iter *_it, unsigned int processed, char *buf,
+		    unsigned int len);
+	int (*alloc_buffer)(struct xattr_iter *_it, unsigned int value_sz);
+	void (*value)(struct xattr_iter *_it, unsigned int processed, char *buf,
+		      unsigned int len);
+};
+
+static inline int xattr_iter_fixup(struct xattr_iter *it)
+{
+	if (it->ofs < EROFS_BLKSIZ)
+		return 0;
+
+	xattr_iter_end(it, true);
+
+	it->blkaddr += erofs_blknr(it->ofs);
+
+	it->page = erofs_get_meta_page(it->sb, it->blkaddr, false);
+	if (IS_ERR(it->page)) {
+		int err = PTR_ERR(it->page);
+
+		it->page = NULL;
+		return err;
+	}
+
+	it->kaddr = kmap_atomic(it->page);
+	it->ofs = erofs_blkoff(it->ofs);
+	return 0;
+}
+
+static int inline_xattr_iter_begin(struct xattr_iter *it,
+				   struct inode *inode)
+{
+	struct erofs_vnode *const vi = EROFS_V(inode);
+	struct erofs_sb_info *const sbi = EROFS_SB(inode->i_sb);
+	unsigned int xattr_header_sz, inline_xattr_ofs;
+
+	xattr_header_sz = inlinexattr_header_size(inode);
+	if (unlikely(xattr_header_sz >= vi->xattr_isize)) {
+		BUG_ON(xattr_header_sz > vi->xattr_isize);
+		return -ENOATTR;
+	}
+
+	inline_xattr_ofs = vi->inode_isize + xattr_header_sz;
+
+	it->blkaddr = erofs_blknr(iloc(sbi, vi->nid) + inline_xattr_ofs);
+	it->ofs = erofs_blkoff(iloc(sbi, vi->nid) + inline_xattr_ofs);
+
+	it->page = erofs_get_inline_page(inode, it->blkaddr);
+	if (IS_ERR(it->page))
+		return PTR_ERR(it->page);
+
+	it->kaddr = kmap_atomic(it->page);
+	return vi->xattr_isize - xattr_header_sz;
+}
+
+/*
+ * Regardless of success or failure, `xattr_foreach' will end up with
+ * `ofs' pointing to the next xattr item rather than an arbitrary position.
+ */
+static int xattr_foreach(struct xattr_iter *it,
+			 const struct xattr_iter_handlers *op,
+			 unsigned int *tlimit)
+{
+	struct erofs_xattr_entry entry;
+	unsigned int value_sz, processed, slice;
+	int err;
+
+	/* 0. fixup blkaddr, ofs, ipage */
+	err = xattr_iter_fixup(it);
+	if (err)
+		return err;
+
+	/*
+	 * 1. read xattr entry to the memory,
+	 *    since we do EROFS_XATTR_ALIGN
+	 *    therefore entry should be in the page
+	 */
+	entry = *(struct erofs_xattr_entry *)(it->kaddr + it->ofs);
+	if (tlimit) {
+		unsigned int entry_sz = EROFS_XATTR_ENTRY_SIZE(&entry);
+
+		BUG_ON(*tlimit < entry_sz);
+		*tlimit -= entry_sz;
+	}
+
+	it->ofs += sizeof(struct erofs_xattr_entry);
+	value_sz = le16_to_cpu(entry.e_value_size);
+
+	/* handle entry */
+	err = op->entry(it, &entry);
+	if (err) {
+		it->ofs += entry.e_name_len + value_sz;
+		goto out;
+	}
+
+	/* 2. handle xattr name (ofs will finally be at the end of name) */
+	processed = 0;
+
+	while (processed < entry.e_name_len) {
+		if (it->ofs >= EROFS_BLKSIZ) {
+			BUG_ON(it->ofs > EROFS_BLKSIZ);
+
+			err = xattr_iter_fixup(it);
+			if (err)
+				goto out;
+			it->ofs = 0;
+		}
+
+		slice = min_t(unsigned int, PAGE_SIZE - it->ofs,
+			      entry.e_name_len - processed);
+
+		/* handle name */
+		err = op->name(it, processed, it->kaddr + it->ofs, slice);
+		if (err) {
+			it->ofs += entry.e_name_len - processed + value_sz;
+			goto out;
+		}
+
+		it->ofs += slice;
+		processed += slice;
+	}
+
+	/* 3. handle xattr value */
+	processed = 0;
+
+	if (op->alloc_buffer) {
+		err = op->alloc_buffer(it, value_sz);
+		if (err) {
+			it->ofs += value_sz;
+			goto out;
+		}
+	}
+
+	while (processed < value_sz) {
+		if (it->ofs >= EROFS_BLKSIZ) {
+			BUG_ON(it->ofs > EROFS_BLKSIZ);
+
+			err = xattr_iter_fixup(it);
+			if (err)
+				goto out;
+			it->ofs = 0;
+		}
+
+		slice = min_t(unsigned int, PAGE_SIZE - it->ofs,
+			      value_sz - processed);
+		op->value(it, processed, it->kaddr + it->ofs, slice);
+		it->ofs += slice;
+		processed += slice;
+	}
+
+out:
+	/* xattrs should be 4-byte aligned (on-disk constraint) */
+	it->ofs = EROFS_XATTR_ALIGN(it->ofs);
+	return err < 0 ? err : 0;
+}
+
+struct getxattr_iter {
+	struct xattr_iter it;
+
+	char *buffer;
+	int buffer_size, index;
+	struct qstr name;
+};
+
+static int xattr_entrymatch(struct xattr_iter *_it,
+			    struct erofs_xattr_entry *entry)
+{
+	struct getxattr_iter *it = container_of(_it, struct getxattr_iter, it);
+
+	return (it->index != entry->e_name_index ||
+		it->name.len != entry->e_name_len) ? -ENOATTR : 0;
+}
+
+static int xattr_namematch(struct xattr_iter *_it,
+			   unsigned int processed, char *buf, unsigned int len)
+{
+	struct getxattr_iter *it = container_of(_it, struct getxattr_iter, it);
+
+	return memcmp(buf, it->name.name + processed, len) ? -ENOATTR : 0;
+}
+
+static int xattr_checkbuffer(struct xattr_iter *_it,
+			     unsigned int value_sz)
+{
+	struct getxattr_iter *it = container_of(_it, struct getxattr_iter, it);
+	int err = it->buffer_size < value_sz ? -ERANGE : 0;
+
+	it->buffer_size = value_sz;
+	return !it->buffer ? 1 : err;
+}
+
+static void xattr_copyvalue(struct xattr_iter *_it,
+			    unsigned int processed,
+			    char *buf, unsigned int len)
+{
+	struct getxattr_iter *it = container_of(_it, struct getxattr_iter, it);
+
+	memcpy(it->buffer + processed, buf, len);
+}
+
+static const struct xattr_iter_handlers find_xattr_handlers = {
+	.entry = xattr_entrymatch,
+	.name = xattr_namematch,
+	.alloc_buffer = xattr_checkbuffer,
+	.value = xattr_copyvalue
+};
+
+static int inline_getxattr(struct inode *inode, struct getxattr_iter *it)
+{
+	int ret;
+	unsigned int remaining;
+
+	ret = inline_xattr_iter_begin(&it->it, inode);
+	if (ret < 0)
+		return ret;
+
+	remaining = ret;
+	while (remaining) {
+		ret = xattr_foreach(&it->it, &find_xattr_handlers, &remaining);
+		if (ret != -ENOATTR)
+			break;
+	}
+	xattr_iter_end_final(&it->it);
+
+	return ret ? ret : it->buffer_size;
+}
+
+static int shared_getxattr(struct inode *inode, struct getxattr_iter *it)
+{
+	struct erofs_vnode *const vi = EROFS_V(inode);
+	struct super_block *const sb = inode->i_sb;
+	struct erofs_sb_info *const sbi = EROFS_SB(sb);
+	unsigned int i;
+	int ret = -ENOATTR;
+
+	for (i = 0; i < vi->xattr_shared_count; ++i) {
+		erofs_blk_t blkaddr =
+			xattrblock_addr(sbi, vi->xattr_shared_xattrs[i]);
+
+		it->it.ofs = xattrblock_offset(sbi, vi->xattr_shared_xattrs[i]);
+
+		if (!i || blkaddr != it->it.blkaddr) {
+			if (i)
+				xattr_iter_end(&it->it, true);
+
+			it->it.page = erofs_get_meta_page(sb, blkaddr, false);
+			if (IS_ERR(it->it.page))
+				return PTR_ERR(it->it.page);
+
+			it->it.kaddr = kmap_atomic(it->it.page);
+			it->it.blkaddr = blkaddr;
+		}
+
+		ret = xattr_foreach(&it->it, &find_xattr_handlers, NULL);
+		if (ret != -ENOATTR)
+			break;
+	}
+	if (vi->xattr_shared_count)
+		xattr_iter_end_final(&it->it);
+
+	return ret ? ret : it->buffer_size;
+}
+
+static bool erofs_xattr_user_list(struct dentry *dentry)
+{
+	return test_opt(EROFS_SB(dentry->d_sb), XATTR_USER);
+}
+
+static bool erofs_xattr_trusted_list(struct dentry *dentry)
+{
+	return capable(CAP_SYS_ADMIN);
+}
+
+int erofs_getxattr(struct inode *inode, int index,
+		   const char *name,
+		   void *buffer, size_t buffer_size)
+{
+	int ret;
+	struct getxattr_iter it;
+
+	if (unlikely(!name))
+		return -EINVAL;
+
+	ret = init_inode_xattrs(inode);
+	if (ret)
+		return ret;
+
+	it.index = index;
+
+	it.name.len = strlen(name);
+	if (it.name.len > EROFS_NAME_LEN)
+		return -ERANGE;
+	it.name.name = name;
+
+	it.buffer = buffer;
+	it.buffer_size = buffer_size;
+
+	it.it.sb = inode->i_sb;
+	ret = inline_getxattr(inode, &it);
+	if (ret == -ENOATTR)
+		ret = shared_getxattr(inode, &it);
+	return ret;
+}
+
+static int erofs_xattr_generic_get(const struct xattr_handler *handler,
+				   struct dentry *unused, struct inode *inode,
+				   const char *name, void *buffer, size_t size)
+{
+	struct erofs_sb_info *const sbi = EROFS_I_SB(inode);
+
+	switch (handler->flags) {
+	case EROFS_XATTR_INDEX_USER:
+		if (!test_opt(sbi, XATTR_USER))
+			return -EOPNOTSUPP;
+		break;
+	case EROFS_XATTR_INDEX_TRUSTED:
+		if (!capable(CAP_SYS_ADMIN))
+			return -EPERM;
+		break;
+	case EROFS_XATTR_INDEX_SECURITY:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return erofs_getxattr(inode, handler->flags, name, buffer, size);
+}
+
+const struct xattr_handler erofs_xattr_user_handler = {
+	.prefix	= XATTR_USER_PREFIX,
+	.flags	= EROFS_XATTR_INDEX_USER,
+	.list	= erofs_xattr_user_list,
+	.get	= erofs_xattr_generic_get,
+};
+
+const struct xattr_handler erofs_xattr_trusted_handler = {
+	.prefix	= XATTR_TRUSTED_PREFIX,
+	.flags	= EROFS_XATTR_INDEX_TRUSTED,
+	.list	= erofs_xattr_trusted_list,
+	.get	= erofs_xattr_generic_get,
+};
+
+#ifdef CONFIG_EROFS_FS_SECURITY
+const struct xattr_handler __maybe_unused erofs_xattr_security_handler = {
+	.prefix	= XATTR_SECURITY_PREFIX,
+	.flags	= EROFS_XATTR_INDEX_SECURITY,
+	.get	= erofs_xattr_generic_get,
+};
+#endif
+
+const struct xattr_handler *erofs_xattr_handlers[] = {
+	&erofs_xattr_user_handler,
+#ifdef CONFIG_EROFS_FS_POSIX_ACL
+	&posix_acl_access_xattr_handler,
+	&posix_acl_default_xattr_handler,
+#endif
+	&erofs_xattr_trusted_handler,
+#ifdef CONFIG_EROFS_FS_SECURITY
+	&erofs_xattr_security_handler,
+#endif
+	NULL,
+};
+
+struct listxattr_iter {
+	struct xattr_iter it;
+
+	struct dentry *dentry;
+	char *buffer;
+	int buffer_size, buffer_ofs;
+};
+
+static int xattr_entrylist(struct xattr_iter *_it,
+			   struct erofs_xattr_entry *entry)
+{
+	struct listxattr_iter *it =
+		container_of(_it, struct listxattr_iter, it);
+	unsigned int prefix_len;
+	const char *prefix;
+
+	const struct xattr_handler *h =
+		erofs_xattr_handler(entry->e_name_index);
+
+	if (!h || (h->list && !h->list(it->dentry)))
+		return 1;
+
+	prefix = xattr_prefix(h);
+	prefix_len = strlen(prefix);
+
+	if (!it->buffer) {
+		it->buffer_ofs += prefix_len + entry->e_name_len + 1;
+		return 1;
+	}
+
+	if (it->buffer_ofs + prefix_len
+		+ entry->e_name_len + 1 > it->buffer_size)
+		return -ERANGE;
+
+	memcpy(it->buffer + it->buffer_ofs, prefix, prefix_len);
+	it->buffer_ofs += prefix_len;
+	return 0;
+}
+
+static int xattr_namelist(struct xattr_iter *_it,
+			  unsigned int processed, char *buf, unsigned int len)
+{
+	struct listxattr_iter *it =
+		container_of(_it, struct listxattr_iter, it);
+
+	memcpy(it->buffer + it->buffer_ofs, buf, len);
+	it->buffer_ofs += len;
+	return 0;
+}
+
+static int xattr_skipvalue(struct xattr_iter *_it,
+			   unsigned int value_sz)
+{
+	struct listxattr_iter *it =
+		container_of(_it, struct listxattr_iter, it);
+
+	it->buffer[it->buffer_ofs++] = '\0';
+	return 1;
+}
+
+static const struct xattr_iter_handlers list_xattr_handlers = {
+	.entry = xattr_entrylist,
+	.name = xattr_namelist,
+	.alloc_buffer = xattr_skipvalue,
+	.value = NULL
+};
+
+static int inline_listxattr(struct listxattr_iter *it)
+{
+	int ret;
+	unsigned int remaining;
+
+	ret = inline_xattr_iter_begin(&it->it, d_inode(it->dentry));
+	if (ret < 0)
+		return ret;
+
+	remaining = ret;
+	while (remaining) {
+		ret = xattr_foreach(&it->it, &list_xattr_handlers, &remaining);
+		if (ret)
+			break;
+	}
+	xattr_iter_end_final(&it->it);
+	return ret ? ret : it->buffer_ofs;
+}
+
+static int shared_listxattr(struct listxattr_iter *it)
+{
+	struct inode *const inode = d_inode(it->dentry);
+	struct erofs_vnode *const vi = EROFS_V(inode);
+	struct super_block *const sb = inode->i_sb;
+	struct erofs_sb_info *const sbi = EROFS_SB(sb);
+	unsigned int i;
+	int ret = 0;
+
+	for (i = 0; i < vi->xattr_shared_count; ++i) {
+		erofs_blk_t blkaddr =
+			xattrblock_addr(sbi, vi->xattr_shared_xattrs[i]);
+
+		it->it.ofs = xattrblock_offset(sbi, vi->xattr_shared_xattrs[i]);
+		if (!i || blkaddr != it->it.blkaddr) {
+			if (i)
+				xattr_iter_end(&it->it, true);
+
+			it->it.page = erofs_get_meta_page(sb, blkaddr, false);
+			if (IS_ERR(it->it.page))
+				return PTR_ERR(it->it.page);
+
+			it->it.kaddr = kmap_atomic(it->it.page);
+			it->it.blkaddr = blkaddr;
+		}
+
+		ret = xattr_foreach(&it->it, &list_xattr_handlers, NULL);
+		if (ret)
+			break;
+	}
+	if (vi->xattr_shared_count)
+		xattr_iter_end_final(&it->it);
+
+	return ret ? ret : it->buffer_ofs;
+}
+
+ssize_t erofs_listxattr(struct dentry *dentry,
+			char *buffer, size_t buffer_size)
+{
+	int ret;
+	struct listxattr_iter it;
+
+	ret = init_inode_xattrs(d_inode(dentry));
+	if (ret)
+		return ret;
+
+	it.dentry = dentry;
+	it.buffer = buffer;
+	it.buffer_size = buffer_size;
+	it.buffer_ofs = 0;
+
+	it.it.sb = dentry->d_sb;
+
+	ret = inline_listxattr(&it);
+	if (ret < 0 && ret != -ENOATTR)
+		return ret;
+	return shared_listxattr(&it);
+}
+
+#ifdef CONFIG_EROFS_FS_POSIX_ACL
+struct posix_acl *erofs_get_acl(struct inode *inode, int type)
+{
+	struct posix_acl *acl;
+	int prefix, rc;
+	char *value = NULL;
+
+	switch (type) {
+	case ACL_TYPE_ACCESS:
+		prefix = EROFS_XATTR_INDEX_POSIX_ACL_ACCESS;
+		break;
+	case ACL_TYPE_DEFAULT:
+		prefix = EROFS_XATTR_INDEX_POSIX_ACL_DEFAULT;
+		break;
+	default:
+		return ERR_PTR(-EINVAL);
+	}
+
+	rc = erofs_getxattr(inode, prefix, "", NULL, 0);
+	if (rc > 0) {
+		value = kmalloc(rc, GFP_KERNEL);
+		if (!value)
+			return ERR_PTR(-ENOMEM);
+		rc = erofs_getxattr(inode, prefix, "", value, rc);
+	}
+
+	if (rc == -ENOATTR)
+		acl = NULL;
+	else if (rc < 0)
+		acl = ERR_PTR(rc);
+	else
+		acl = posix_acl_from_xattr(&init_user_ns, value, rc);
+	kfree(value);
+	return acl;
+}
+#endif
+
diff --git a/fs/erofs/xattr.h b/fs/erofs/xattr.h
new file mode 100644
index 000000000000..186276225291
--- /dev/null
+++ b/fs/erofs/xattr.h
@@ -0,0 +1,93 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * linux/fs/erofs/xattr.h
+ *
+ * Copyright (C) 2017-2018 HUAWEI, Inc.
+ *             http://www.huawei.com/
+ * Created by Gao Xiang <gaoxiang25@huawei.com>
+ */
+#ifndef __EROFS_XATTR_H
+#define __EROFS_XATTR_H
+
+#include "internal.h"
+#include <linux/posix_acl_xattr.h>
+#include <linux/xattr.h>
+
+/* Attribute not found */
+#define ENOATTR         ENODATA
+
+static inline unsigned int inlinexattr_header_size(struct inode *inode)
+{
+	return sizeof(struct erofs_xattr_ibody_header) +
+		sizeof(u32) * EROFS_V(inode)->xattr_shared_count;
+}
+
+static inline erofs_blk_t xattrblock_addr(struct erofs_sb_info *sbi,
+					  unsigned int xattr_id)
+{
+#ifdef CONFIG_EROFS_FS_XATTR
+	return sbi->xattr_blkaddr +
+		xattr_id * sizeof(__u32) / EROFS_BLKSIZ;
+#else
+	return 0;
+#endif
+}
+
+static inline unsigned int xattrblock_offset(struct erofs_sb_info *sbi,
+					     unsigned int xattr_id)
+{
+	return (xattr_id * sizeof(__u32)) % EROFS_BLKSIZ;
+}
+
+#ifdef CONFIG_EROFS_FS_XATTR
+extern const struct xattr_handler erofs_xattr_user_handler;
+extern const struct xattr_handler erofs_xattr_trusted_handler;
+#ifdef CONFIG_EROFS_FS_SECURITY
+extern const struct xattr_handler erofs_xattr_security_handler;
+#endif
+
+static inline const struct xattr_handler *erofs_xattr_handler(unsigned int idx)
+{
+static const struct xattr_handler *xattr_handler_map[] = {
+	[EROFS_XATTR_INDEX_USER] = &erofs_xattr_user_handler,
+#ifdef CONFIG_EROFS_FS_POSIX_ACL
+	[EROFS_XATTR_INDEX_POSIX_ACL_ACCESS] = &posix_acl_access_xattr_handler,
+	[EROFS_XATTR_INDEX_POSIX_ACL_DEFAULT] =
+		&posix_acl_default_xattr_handler,
+#endif
+	[EROFS_XATTR_INDEX_TRUSTED] = &erofs_xattr_trusted_handler,
+#ifdef CONFIG_EROFS_FS_SECURITY
+	[EROFS_XATTR_INDEX_SECURITY] = &erofs_xattr_security_handler,
+#endif
+};
+	return idx && idx < ARRAY_SIZE(xattr_handler_map) ?
+		xattr_handler_map[idx] : NULL;
+}
+
+extern const struct xattr_handler *erofs_xattr_handlers[];
+
+int erofs_getxattr(struct inode *, int, const char *, void *, size_t);
+ssize_t erofs_listxattr(struct dentry *, char *, size_t);
+#else
+static inline int erofs_getxattr(struct inode *inode, int index,
+				 const char *name, void *buffer,
+				 size_t buffer_size)
+{
+	return -ENOTSUPP;
+}
+
+static inline ssize_t erofs_listxattr(struct dentry *dentry,
+				      char *buffer, size_t buffer_size)
+{
+	return -ENOTSUPP;
+}
+#endif
+
+#ifdef CONFIG_EROFS_FS_POSIX_ACL
+struct posix_acl *erofs_get_acl(struct inode *inode, int type);
+#else
+#define erofs_get_acl	(NULL)
+#endif
+
+#endif
+
-- 
2.17.1

