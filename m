Return-Path: <linux-fsdevel+bounces-73271-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB6FD13CA1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 16:49:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7CDFA304485E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 15:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6EDD361660;
	Mon, 12 Jan 2026 15:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rmYXBrP7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BAB29BD80
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jan 2026 15:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768232847; cv=none; b=VSW7tflzaHbj6u/5cUS2zKEVVpIHr3INZjCgZcOHAk4J141WoOEkB3KtUU/60yZDLANOoQyUjZwS1UdpS1uhsjC27rQEu+Ed4ya4aai6CJh+BsoZFiR6+513lx96rCgoder2YUzOSvcix3CJw/GNrVGvJBqVIIxFJTWnKATWm98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768232847; c=relaxed/simple;
	bh=Zcefr/clUNYpkIskByW8SES2RNUM6i5RESRdePue7lo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aiR/wziXbCvcpurrrckhJTO4IlwF0hrMLjOW9Bm1Jq8tFiU/QDrbAVB7e9K2CAlZMCpDp7JlnBTGm6831yrxKu4/VzO4VFnPGoUAXy+auYvTwaKFsD4Ay0C2PsN43MJ6JSgIKkyRa/qQBzB76pRJBVdJe8CZPuMtvWbPHzGAPTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rmYXBrP7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 048FEC19422;
	Mon, 12 Jan 2026 15:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768232846;
	bh=Zcefr/clUNYpkIskByW8SES2RNUM6i5RESRdePue7lo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rmYXBrP7iAEglelqo75qrXOFLRkI5PuFUPtY47E5xj3hPUY9P1HEwwqYlFqzWB6u1
	 tbfg8MzK+hnA4zg8suZfHZnpBxjvO55d+d/6+bx0kdzGuR0KzBnW1oGsiPAYkP5uPi
	 lh++764C7zb6AJNCzmNpJ8+ZKpDzoy3ETlfkggy9ksu+VzFR5N+uq7WV4x5IFm4S61
	 4o2gCx36vkRHgB/T0AvqC0G5MVLVh9v48LiDoxhLLsNxq6ck6vPRQPI7lcrworE4dW
	 qWcWEWTZBpk2awuFvoJyqytYBva2AK6V85WRN7mUQ4zFNFjnuBYfK6s0VkCWdux1xW
	 IoQxEaDGzaM3w==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 12 Jan 2026 16:47:10 +0100
Subject: [PATCH v2 3/4] fs: add immutable rootfs
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260112-work-immutable-rootfs-v2-3-88dd1c34a204@kernel.org>
References: <20260112-work-immutable-rootfs-v2-0-88dd1c34a204@kernel.org>
In-Reply-To: <20260112-work-immutable-rootfs-v2-0-88dd1c34a204@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
 Lennart Poettering <lennart@poettering.net>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 Josef Bacik <josef@toxicpanda.com>, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=9994; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Zcefr/clUNYpkIskByW8SES2RNUM6i5RESRdePue7lo=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSmirees8tcvkh1kdaG7Fn2c1O94/MEzqUsaPzw/HaEJ
 4P6IotPHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABOJe87IcHXz9CUaETUfLRxC
 Nk7ZcHt+ateGCBsPhd09XzpKVxfwbGNkaFpi2PH5VdTZu2f05u/s2zT1uLdOweY8k5mKL4pPPN+
 pxwsA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Currently pivot_root() doesn't work on the real rootfs because it
cannot be unmounted. Userspace has to do a recursive removal of the
initramfs contents manually before continuing the boot.

Really all we want from the real rootfs is to serve as the parent mount
for anything that is actually useful such as the tmpfs or ramfs for
initramfs unpacking or the rootfs itself. There's no need for the real
rootfs to actually be anything meaningful or useful. Add a immutable
rootfs called "nullfs" that can be selected via the "nullfs_rootfs"
kernel command line option.

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
 fs/namespace.c             | 82 +++++++++++++++++++++++++++++++++++++++-------
 fs/nullfs.c                | 70 +++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/magic.h |  1 +
 init/do_mounts.c           | 14 ++++++++
 init/do_mounts.h           |  1 +
 7 files changed, 159 insertions(+), 12 deletions(-)

diff --git a/fs/Makefile b/fs/Makefile
index a04274a3c854..becf133e4791 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -16,7 +16,7 @@ obj-y :=	open.o read_write.o file_table.o super.o \
 		stack.o fs_struct.o statfs.o fs_pin.o nsfs.o \
 		fs_dirent.o fs_context.o fs_parser.o fsopen.o init.o \
 		kernel_read_file.o mnt_idmapping.o remap_range.o pidfs.o \
-		file_attr.o
+		file_attr.o nullfs.o
 
 obj-$(CONFIG_BUFFER_HEAD)	+= buffer.o mpage.o
 obj-$(CONFIG_PROC_FS)		+= proc_namespace.o
diff --git a/fs/mount.h b/fs/mount.h
index 2d28ef2a3aed..e0816c11a198 100644
--- a/fs/mount.h
+++ b/fs/mount.h
@@ -5,6 +5,7 @@
 #include <linux/ns_common.h>
 #include <linux/fs_pin.h>
 
+extern struct file_system_type nullfs_fs_type;
 extern struct list_head notify_list;
 
 struct mnt_namespace {
diff --git a/fs/namespace.c b/fs/namespace.c
index 9261f56ccc81..a44ebb2f1161 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -75,6 +75,17 @@ static int __init initramfs_options_setup(char *str)
 
 __setup("initramfs_options=", initramfs_options_setup);
 
+bool nullfs_rootfs = false;
+
+static int __init nullfs_rootfs_setup(char *str)
+{
+	if (*str)
+		return 0;
+	nullfs_rootfs = true;
+	return 1;
+}
+__setup("nullfs_rootfs", nullfs_rootfs_setup);
+
 static u64 event;
 static DEFINE_XARRAY_FLAGS(mnt_id_xa, XA_FLAGS_ALLOC);
 static DEFINE_IDA(mnt_group_ida);
@@ -4582,8 +4593,9 @@ int path_pivot_root(struct path *new, struct path *old)
  * pointed to by put_old must yield the same directory as new_root. No other
  * file system may be mounted on put_old. After all, new_root is a mountpoint.
  *
- * Also, the current root cannot be on the 'rootfs' (initial ramfs) filesystem.
- * See Documentation/filesystems/ramfs-rootfs-initramfs.rst for alternatives
+ * Also, the current root cannot be on the 'rootfs' (initial ramfs) filesystem
+ * unless the kernel was booted with "nullfs_rootfs". See
+ * Documentation/filesystems/ramfs-rootfs-initramfs.rst for alternatives
  * in this situation.
  *
  * Notes:
@@ -5976,24 +5988,72 @@ struct mnt_namespace init_mnt_ns = {
 
 static void __init init_mount_tree(void)
 {
-	struct vfsmount *mnt;
-	struct mount *m;
+	struct vfsmount *mnt, *nullfs_mnt;
+	struct mount *mnt_root;
 	struct path root;
 
+	/*
+	 * When nullfs is used, we create two mounts:
+	 *
+	 * (1) nullfs with mount id 1
+	 * (2) mutable rootfs with mount id 2
+	 *
+	 * with (2) mounted on top of (1).
+	 */
+	if (nullfs_rootfs) {
+		nullfs_mnt = vfs_kern_mount(&nullfs_fs_type, 0, "nullfs", NULL);
+		if (IS_ERR(nullfs_mnt))
+			panic("VFS: Failed to create nullfs");
+	}
+
 	mnt = vfs_kern_mount(&rootfs_fs_type, 0, "rootfs", initramfs_options);
 	if (IS_ERR(mnt))
 		panic("Can't create rootfs");
 
-	m = real_mount(mnt);
-	init_mnt_ns.root = m;
-	init_mnt_ns.nr_mounts = 1;
-	mnt_add_to_ns(&init_mnt_ns, m);
+	if (nullfs_rootfs) {
+		VFS_WARN_ON_ONCE(real_mount(nullfs_mnt)->mnt_id != 1);
+		VFS_WARN_ON_ONCE(real_mount(mnt)->mnt_id != 2);
+
+		/* The namespace root is the nullfs mnt. */
+		mnt_root		= real_mount(nullfs_mnt);
+		init_mnt_ns.root	= mnt_root;
+
+		/* Mount mutable rootfs on top of nullfs. */
+		root.mnt		= nullfs_mnt;
+		root.dentry		= nullfs_mnt->mnt_root;
+
+		LOCK_MOUNT_EXACT(mp, &root);
+		if (unlikely(IS_ERR(mp.parent)))
+			panic("VFS: Failed to mount rootfs on nullfs");
+		scoped_guard(mount_writer)
+			attach_mnt(real_mount(mnt), mp.parent, mp.mp);
+
+		pr_info("VFS: Finished mounting rootfs on nullfs\n");
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
 
diff --git a/fs/nullfs.c b/fs/nullfs.c
new file mode 100644
index 000000000000..fdbd3e5d3d71
--- /dev/null
+++ b/fs/nullfs.c
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2026 Christian Brauner <brauner@kernel.org> */
+#include <linux/fs/super_types.h>
+#include <linux/fs_context.h>
+#include <linux/magic.h>
+
+static const struct super_operations nullfs_super_operations = {
+	.statfs	= simple_statfs,
+};
+
+static int nullfs_fs_fill_super(struct super_block *s, struct fs_context *fc)
+{
+	struct inode *inode;
+
+	s->s_maxbytes		= MAX_LFS_FILESIZE;
+	s->s_blocksize		= PAGE_SIZE;
+	s->s_blocksize_bits	= PAGE_SHIFT;
+	s->s_magic		= NULL_FS_MAGIC;
+	s->s_op			= &nullfs_super_operations;
+	s->s_export_op		= NULL;
+	s->s_xattr		= NULL;
+	s->s_time_gran		= 1;
+	s->s_d_flags		= 0;
+
+	inode = new_inode(s);
+	if (!inode)
+		return -ENOMEM;
+
+	/* nullfs is permanently empty... */
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
+/*
+ * For now this is a single global instance. If needed we can make it
+ * mountable by userspace at which point we will need to make it
+ * multi-instance.
+ */
+static int nullfs_fs_get_tree(struct fs_context *fc)
+{
+	return get_tree_single(fc, nullfs_fs_fill_super);
+}
+
+static const struct fs_context_operations nullfs_fs_context_ops = {
+	.get_tree	= nullfs_fs_get_tree,
+};
+
+static int nullfs_init_fs_context(struct fs_context *fc)
+{
+	fc->ops		= &nullfs_fs_context_ops;
+	fc->global	= true;
+	fc->sb_flags	= SB_NOUSER;
+	fc->s_iflags	= SB_I_NOEXEC | SB_I_NODEV;
+	return 0;
+}
+
+struct file_system_type nullfs_fs_type = {
+	.name			= "nullfs",
+	.init_fs_context	= nullfs_init_fs_context,
+	.kill_sb		= kill_anon_super,
+};
diff --git a/include/uapi/linux/magic.h b/include/uapi/linux/magic.h
index 638ca21b7a90..4f2da935a76c 100644
--- a/include/uapi/linux/magic.h
+++ b/include/uapi/linux/magic.h
@@ -104,5 +104,6 @@
 #define SECRETMEM_MAGIC		0x5345434d	/* "SECM" */
 #define PID_FS_MAGIC		0x50494446	/* "PIDF" */
 #define GUEST_MEMFD_MAGIC	0x474d454d	/* "GMEM" */
+#define NULL_FS_MAGIC		0x4E554C4C	/* "NULL" */
 
 #endif /* __LINUX_MAGIC_H__ */
diff --git a/init/do_mounts.c b/init/do_mounts.c
index defbbf1d55f7..675397c8a7a4 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -492,6 +492,20 @@ void __init prepare_namespace(void)
 	mount_root(saved_root_name);
 out:
 	devtmpfs_mount();
+
+	if (nullfs_rootfs) {
+		if (init_pivot_root(".", ".")) {
+			pr_err("VFS: Failed to pivot into new rootfs\n");
+			return;
+		}
+		if (init_umount(".", MNT_DETACH)) {
+			pr_err("VFS: Failed to unmount old rootfs\n");
+			return;
+		}
+		pr_info("VFS: Pivoted into new rootfs\n");
+		return;
+	}
+
 	init_mount(".", "/", NULL, MS_MOVE, NULL);
 	init_chroot(".");
 }
diff --git a/init/do_mounts.h b/init/do_mounts.h
index 6069ea3eb80d..fbfee810aa89 100644
--- a/init/do_mounts.h
+++ b/init/do_mounts.h
@@ -15,6 +15,7 @@
 void  mount_root_generic(char *name, char *pretty_name, int flags);
 void  mount_root(char *root_device_name);
 extern int root_mountflags;
+extern bool nullfs_rootfs;
 
 static inline __init int create_dev(char *name, dev_t dev)
 {

-- 
2.47.3


