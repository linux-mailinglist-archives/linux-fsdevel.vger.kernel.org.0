Return-Path: <linux-fsdevel+bounces-72324-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3620ACEEC66
	for <lists+linux-fsdevel@lfdr.de>; Fri, 02 Jan 2026 15:37:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8126E302C8C9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Jan 2026 14:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D0320010C;
	Fri,  2 Jan 2026 14:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g+nlb/b5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9DE13AD05
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Jan 2026 14:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767364598; cv=none; b=JK80LGsW2ABN29m/pf/Niq8QzUczavguqCFHI8e65DLOpgJTQCH/mEBHf32Bfecn7UzS9a4X4NMtPy72VHuVjrVS7y7lwo1lv2UNM50Bg5gDhyx/yYOUd0/mkYJpDIaxN6ea7vK9SqtKIbMxEp4VqhLWHlOrslxNMt7KRNFNpHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767364598; c=relaxed/simple;
	bh=semsSVoL+la8RnM1MGmltZogg8lZY7YioYiPjcTnP0Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cRyJJs7XAVQE5JZSE68YKrtzHaIYHx07OZFZsi8+trSjaODhJGYnwbvWwNU2SE314j+zQw97HPlU2HiCpDEsW8mvoJhAbmTjtv3A/txhYtbur53WR+0FFT2SuEvQ6Qrvc7Aero2XcP5pFKHoaYhl6Kd3TONIkcw9fZiKd6mkpR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g+nlb/b5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83E14C116B1;
	Fri,  2 Jan 2026 14:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767364598;
	bh=semsSVoL+la8RnM1MGmltZogg8lZY7YioYiPjcTnP0Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=g+nlb/b55k5T2BoGgnARjG2Iqbk9w3yt6IxWv3E0PWDjc3uUR4f2nq2E2nYj8PKcU
	 NP61QdDVDXu0upS6v3EsNbjcDWls1Ia+12dihOdExz2XDtHjTiW5oeltTlXhBMBfpR
	 cE4YVfMBAtsUA1YrDgtdJYbKlA+9Qu12cMBj8wTgdPUsJod8biD2G1w6kclWT16a1N
	 673yFi9QySlu8DWMtp3yd0E/gXVRImjAjgYjW2PItFMr1S5g5piD9P37bZ5Aeq953a
	 vyYG8+wMD1T3aTWWISYRnidzgHHFA/vQ7qk+idkpdjIPnIA9H404ozT/c0gzFNQTzR
	 eqg8Afevfmshg==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 02 Jan 2026 15:36:24 +0100
Subject: [PATCH 3/3] fs: add immutable rootfs
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260102-work-immutable-rootfs-v1-3-f2073b2d1602@kernel.org>
References: <20260102-work-immutable-rootfs-v1-0-f2073b2d1602@kernel.org>
In-Reply-To: <20260102-work-immutable-rootfs-v1-0-f2073b2d1602@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
 Lennart Poettering <lennart@poettering.net>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 Josef Bacik <josef@toxicpanda.com>, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=9356; i=brauner@kernel.org;
 h=from:subject:message-id; bh=semsSVoL+la8RnM1MGmltZogg8lZY7YioYiPjcTnP0Q=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSGX3/jcOxfZ/Eko0jmzQxl596vygxU/fspUy9mz23mA
 /Xr3RzSO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACairsjwT1dALfpZ6jJf+WO6
 jp8DRf72v1zi83PFDgVLH+XL4u86DBkZWp3ftFa+MAz02B9gsNZpXUKUzfuUKoGkl9qPCmL3ZDR
 yAQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Currently pivot_root() doesnt't work on the real rootfs because it
cannot be unmounted. Userspace has to do a recursive removal of the
initramfs contents manually before continuing the boot.

Really all we want from the real rootfs is to serve as the parent mount
for anything that is actually useful such as the tmpfs or ramfs for
initramfs unpacking or the rootfs itself. There's no need for the real
rootfs to actually be anything meaningful or useful. Add a immutable
rootfs that can be selected via the "immutable_rootfs" kernel command
line option.

The kernel will mount a tmpfs/ramfs on top of it, unpack the initramfs
and fire up userspace which mounts the rootfs and can then just do:

  chdir(rootfs);
  pivot_root(".", ".");
  umount2(".", MNT_DETACH);

and be done with it. (Ofc, userspace can also choose to retain the
initramfs contents by using something like pivot_root(".", "/initramfs")
without unmounting it.)

Technically this also means that the rootfs mount in unprivileged
namespaces doesn't need to become MNT_LOCKED anymore as it's guaranteed
that the immutable rootfs remains permanently empty so there cannot be
anything revealed by unmounting the covering mount.

In the future this will also allow us to create completely empty mount
namespaces without risking to leak anything.

systemd already handles this all correctly as it tries to pivot_root()
first and falls back to MS_MOVE only when that fails.

This goes back to various discussion in previous years and a LPC 2024
presentation about this very topic.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/Makefile                |  2 +-
 fs/mount.h                 |  1 +
 fs/namespace.c             | 78 ++++++++++++++++++++++++++++++++++++++++------
 fs/rootfs.c                | 65 ++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/magic.h |  1 +
 init/do_mounts.c           | 13 ++++++--
 init/do_mounts.h           |  1 +
 7 files changed, 149 insertions(+), 12 deletions(-)

diff --git a/fs/Makefile b/fs/Makefile
index a04274a3c854..d31b56b7c4d5 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -16,7 +16,7 @@ obj-y :=	open.o read_write.o file_table.o super.o \
 		stack.o fs_struct.o statfs.o fs_pin.o nsfs.o \
 		fs_dirent.o fs_context.o fs_parser.o fsopen.o init.o \
 		kernel_read_file.o mnt_idmapping.o remap_range.o pidfs.o \
-		file_attr.o
+		file_attr.o rootfs.o
 
 obj-$(CONFIG_BUFFER_HEAD)	+= buffer.o mpage.o
 obj-$(CONFIG_PROC_FS)		+= proc_namespace.o
diff --git a/fs/mount.h b/fs/mount.h
index 2d28ef2a3aed..c3e0d9dbfaa4 100644
--- a/fs/mount.h
+++ b/fs/mount.h
@@ -5,6 +5,7 @@
 #include <linux/ns_common.h>
 #include <linux/fs_pin.h>
 
+extern struct file_system_type immutable_rootfs_fs_type;
 extern struct list_head notify_list;
 
 struct mnt_namespace {
diff --git a/fs/namespace.c b/fs/namespace.c
index 9261f56ccc81..30597f4610fd 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -75,6 +75,17 @@ static int __init initramfs_options_setup(char *str)
 
 __setup("initramfs_options=", initramfs_options_setup);
 
+bool immutable_rootfs = false;
+
+static int __init immutable_rootfs_setup(char *str)
+{
+	if (*str)
+		return 0;
+	immutable_rootfs = true;
+	return 1;
+}
+__setup("immutable_rootfs", immutable_rootfs_setup);
+
 static u64 event;
 static DEFINE_XARRAY_FLAGS(mnt_id_xa, XA_FLAGS_ALLOC);
 static DEFINE_IDA(mnt_group_ida);
@@ -5976,24 +5987,73 @@ struct mnt_namespace init_mnt_ns = {
 
 static void __init init_mount_tree(void)
 {
-	struct vfsmount *mnt;
-	struct mount *m;
+	struct vfsmount *mnt, *immutable_mnt;
+	struct mount *mnt_root;
 	struct path root;
 
+	/*
+	 * When the immutable rootfs is used, we create two mounts:
+	 *
+	 * (1) immutable rootfs with mount id 1
+	 * (2) mutable rootfs with mount id 2
+	 *
+	 * with (2) mounted on top of (1).
+	 */
+	if (immutable_rootfs) {
+		immutable_mnt = vfs_kern_mount(&immutable_rootfs_fs_type, 0,
+					       "rootfs", NULL);
+		if (IS_ERR(immutable_mnt))
+			panic("VFS: Failed to create immutable rootfs");
+	}
+
 	mnt = vfs_kern_mount(&rootfs_fs_type, 0, "rootfs", initramfs_options);
 	if (IS_ERR(mnt))
 		panic("Can't create rootfs");
 
-	m = real_mount(mnt);
-	init_mnt_ns.root = m;
-	init_mnt_ns.nr_mounts = 1;
-	mnt_add_to_ns(&init_mnt_ns, m);
+	if (immutable_rootfs) {
+		VFS_WARN_ON_ONCE(real_mount(immutable_mnt)->mnt_id != 1);
+		VFS_WARN_ON_ONCE(real_mount(mnt)->mnt_id != 2);
+
+		/* The namespace root is the immutable rootfs. */
+		mnt_root		= real_mount(immutable_mnt);
+		init_mnt_ns.root	= mnt_root;
+
+		/* Mount mutable rootfs on top of the immutable rootfs. */
+		root.mnt		= immutable_mnt;
+		root.dentry		= immutable_mnt->mnt_root;
+
+		LOCK_MOUNT_EXACT(mp, &root);
+		if (unlikely(IS_ERR(mp.parent)))
+			panic("VFS: Failed to setup immutable rootfs");
+		scoped_guard(mount_writer)
+			attach_mnt(real_mount(mnt), mp.parent, mp.mp);
+
+		pr_info("VFS: Finished setting up immutable rootfs\n");
+	} else {
+		VFS_WARN_ON_ONCE(real_mount(mnt)->mnt_id != 1);
+
+		/* The namespace root is the mutable rootfs. */
+		mnt_root		= real_mount(mnt);
+		init_mnt_ns.root	= mnt_root;
+	}
+
+	/*
+	 * We've dropped all locks here but that's fine. Not just are we
+	 * the only task that's running, there's no other mount
+	 * namespace in existence and the initial mount namespace is
+	 * completely empty until we add the mounts we just created.
+	 */
+	for (struct mount *p = mnt_root; p; p = next_mnt(p, mnt_root)) {
+		mnt_add_to_ns(&init_mnt_ns, p);
+		init_mnt_ns.nr_mounts++;
+	}
+
 	init_task.nsproxy->mnt_ns = &init_mnt_ns;
 	get_mnt_ns(&init_mnt_ns);
 
-	root.mnt = mnt;
-	root.dentry = mnt->mnt_root;
-
+	/* The root and pwd always point to the mutable rootfs. */
+	root.mnt	= mnt;
+	root.dentry	= mnt->mnt_root;
 	set_fs_pwd(current->fs, &root);
 	set_fs_root(current->fs, &root);
 
diff --git a/fs/rootfs.c b/fs/rootfs.c
new file mode 100644
index 000000000000..b82b73bb8bb2
--- /dev/null
+++ b/fs/rootfs.c
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2026 Christian Brauner <brauner@kernel.org> */
+#include <linux/fs/super_types.h>
+#include <linux/fs_context.h>
+#include <linux/magic.h>
+
+static const struct super_operations rootfs_super_operations = {
+	.statfs	= simple_statfs,
+};
+
+static int rootfs_fs_fill_super(struct super_block *s, struct fs_context *fc)
+{
+	struct inode *inode;
+
+	s->s_maxbytes		= MAX_LFS_FILESIZE;
+	s->s_blocksize		= PAGE_SIZE;
+	s->s_blocksize_bits	= PAGE_SHIFT;
+	s->s_magic		= ROOT_FS_MAGIC;
+	s->s_op			= &rootfs_super_operations;
+	s->s_export_op		= NULL;
+	s->s_xattr		= NULL;
+	s->s_time_gran		= 1;
+	s->s_d_flags		= 0;
+
+	inode = new_inode(s);
+	if (!inode)
+		return -ENOMEM;
+
+	/* The real rootfs is permanently empty... */
+	make_empty_dir_inode(inode);
+	simple_inode_init_ts(inode);
+	inode->i_ino	= 1;
+	/* ... and immutable. */
+	inode->i_flags |= S_IMMUTABLE;
+
+	s->s_root = d_make_root(inode);
+	if (!s->s_root)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static int rootfs_fs_get_tree(struct fs_context *fc)
+{
+	return get_tree_single(fc, rootfs_fs_fill_super);
+}
+
+static const struct fs_context_operations rootfs_fs_context_ops = {
+	.get_tree	= rootfs_fs_get_tree,
+};
+
+static int rootfs_init_fs_context(struct fs_context *fc)
+{
+	fc->ops		= &rootfs_fs_context_ops;
+	fc->global	= true;
+	fc->sb_flags	= SB_NOUSER;
+	fc->s_iflags	= SB_I_NOEXEC | SB_I_NODEV;
+	return 0;
+}
+
+struct file_system_type immutable_rootfs_fs_type = {
+	.name			= "rootfs",
+	.init_fs_context	= rootfs_init_fs_context,
+	.kill_sb		= kill_anon_super,
+};
diff --git a/include/uapi/linux/magic.h b/include/uapi/linux/magic.h
index 638ca21b7a90..1a3a5a5b785a 100644
--- a/include/uapi/linux/magic.h
+++ b/include/uapi/linux/magic.h
@@ -104,5 +104,6 @@
 #define SECRETMEM_MAGIC		0x5345434d	/* "SECM" */
 #define PID_FS_MAGIC		0x50494446	/* "PIDF" */
 #define GUEST_MEMFD_MAGIC	0x474d454d	/* "GMEM" */
+#define ROOT_FS_MAGIC		0x524F4F54	/* "ROOT" */
 
 #endif /* __LINUX_MAGIC_H__ */
diff --git a/init/do_mounts.c b/init/do_mounts.c
index defbbf1d55f7..e245e5e4e954 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -492,8 +492,17 @@ void __init prepare_namespace(void)
 	mount_root(saved_root_name);
 out:
 	devtmpfs_mount();
-	init_mount(".", "/", NULL, MS_MOVE, NULL);
-	init_chroot(".");
+
+	if (immutable_rootfs) {
+		if (init_pivot_root(".", "."))
+			pr_err("VFS: Failed to pivot into new rootfs\n");
+		if (init_umount(".", MNT_DETACH))
+			pr_err("VFS: Failed to unmount old rootfs\n");
+		pr_info("VFS: Pivoted into new rootfs\n");
+	} else {
+		init_mount(".", "/", NULL, MS_MOVE, NULL);
+		init_chroot(".");
+	}
 }
 
 static bool is_tmpfs;
diff --git a/init/do_mounts.h b/init/do_mounts.h
index 6069ea3eb80d..d05870fcb662 100644
--- a/init/do_mounts.h
+++ b/init/do_mounts.h
@@ -15,6 +15,7 @@
 void  mount_root_generic(char *name, char *pretty_name, int flags);
 void  mount_root(char *root_device_name);
 extern int root_mountflags;
+extern bool immutable_rootfs;
 
 static inline __init int create_dev(char *name, dev_t dev)
 {

-- 
2.47.3


