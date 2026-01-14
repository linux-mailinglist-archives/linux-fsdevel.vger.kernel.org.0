Return-Path: <linux-fsdevel+bounces-73658-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B4BD1E1BB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 11:35:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8CDB83062CC7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 10:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5559138FF16;
	Wed, 14 Jan 2026 10:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jR5eF6ui"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D7238B7C4
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 10:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768386753; cv=none; b=adnydZtWPyJ/P+fZkVPtwf0i4n8Os4f8WhfYNdDUsM1yw/kT4WnY62Na88fzu6UZLOjaAL4fOzu8gbcptKxCjmvFF6cbgAo0MQCvhdsTW6irQl68ajC0mOVJZKcjhn0XnAKApBiiribsq9w75nsPRVQZmTd3lwxVbLFt2e30MeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768386753; c=relaxed/simple;
	bh=qS93f7lFYw30L9021OWayewYrdgNAkKUeMA372FLjwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BoJPkQmsE1o4KwGS6/mQRZLWxlp8jRGOruFOr5e/w1FfJR2OWUuvb6PHDUDEuAqydWdf+4/mcJnocCursbukM2+TmtDgjWYbkS/PN+E/UCvLZ4jBn7QlEl4va5OMTt6VRicR5LZ9CGiYCqXZZwvLgpiuZX0a7BfRDKYtLpb6xn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jR5eF6ui; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F64FC19423;
	Wed, 14 Jan 2026 10:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768386752;
	bh=qS93f7lFYw30L9021OWayewYrdgNAkKUeMA372FLjwY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jR5eF6uitew7Cbmvkp+lf1NegW67DCHfvc8r1IzkYB4DHqrwjZqjriNwzc+80yDgp
	 BetTiwxKJvCFnbpsW7Vpvul35Hl/G5h8PGrH2K6Z4hxjzUhM0XM1H2HhVc+sSyAgOW
	 pxKZ2geolSQzYrUxIzRIr9M6JKAhtw794Xg4kSG4zmrlcsZKukBsoa1T5UfcxQDZCy
	 B4zTCQHdUXMLP8jPSN42ftXmyjM5C2hl4JfvPqm7/c2gpMhUdGAp3wyt+j3ZoUxxDJ
	 SMLTlIMRlU9m9l/IbrL31SIZdq3Z7fz1DC9sE1YsmLN+i0UlySt1M7q0n1PRjkomzd
	 dvwYNSgaRYREg==
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>,
	Lennart Poettering <lennart@poettering.net>,
	=?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	Josef Bacik <josef@toxicpanda.com>
Subject: [RFC PATCH 5/4] fs: use nullfs unconditionally as the real rootfs
Date: Wed, 14 Jan 2026 11:32:11 +0100
Message-ID: <20260114-nennwert-pixeln-da3a611f7c40@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260114-zarte-zerrbild-0e20b46eb1a6@brauner>
References: <20260114-zarte-zerrbild-0e20b46eb1a6@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8347; i=brauner@kernel.org; h=from:subject:message-id; bh=qS93f7lFYw30L9021OWayewYrdgNAkKUeMA372FLjwY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSmF6y9a+kXY7ez0KCHf2+sg/p+j60c76Vq8+o95544z 5o359TEjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgImkljD804o/s31b28mlLowX NXY63b2V/G+G2UWpRdMid7S3MwTyJjAy/NPP/OI0/YBr0GW39uf6eb6b2I86NsV0XO2/d2ni+vt FfAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Remove the "nullfs_rootfs" boot parameter and try to simply always use
nullfs. The mutable rootfs will be mounted on top of it. Systems that
don't use pivot_root() to pivot away from the real rootfs will have an
additional mount stick around but that shouldn't be a problem at all. If
it is we'll rever this commit.

This also simplifies the boot process and removes the need for the
traditional switch_root workarounds.

Suggested-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 .../filesystems/ramfs-rootfs-initramfs.rst    | 24 ++-----
 fs/namespace.c                                | 64 ++++++-------------
 init/do_mounts.c                              | 20 ++----
 init/do_mounts.h                              |  1 -
 4 files changed, 32 insertions(+), 77 deletions(-)

diff --git a/Documentation/filesystems/ramfs-rootfs-initramfs.rst b/Documentation/filesystems/ramfs-rootfs-initramfs.rst
index a8899f849e90..165117a721ce 100644
--- a/Documentation/filesystems/ramfs-rootfs-initramfs.rst
+++ b/Documentation/filesystems/ramfs-rootfs-initramfs.rst
@@ -76,13 +76,8 @@ What is rootfs?
 ---------------
 
 Rootfs is a special instance of ramfs (or tmpfs, if that's enabled), which is
-always present in 2.6 systems.  Traditionally, you can't unmount rootfs for
-approximately the same reason you can't kill the init process; rather than
-having special code to check for and handle an empty list, it's smaller and
-simpler for the kernel to just make sure certain lists can't become empty.
-
-However, if the kernel is booted with "nullfs_rootfs", an immutable empty
-filesystem called nullfs is used as the true root, with the mutable rootfs
+always present in Linux systems.  The kernel uses an immutable empty filesystem
+called nullfs as the true root of the VFS hierarchy, with the mutable rootfs
 (tmpfs/ramfs) mounted on top of it.  This allows pivot_root() and unmounting
 of the initramfs to work normally.
 
@@ -126,25 +121,14 @@ All this differs from the old initrd in several ways:
     program.  See the switch_root utility, below.)
 
   - When switching another root device, initrd would pivot_root and then
-    umount the ramdisk.  Traditionally, initramfs is rootfs: you can neither
-    pivot_root rootfs, nor unmount it.  Instead delete everything out of
-    rootfs to free up the space (find -xdev / -exec rm '{}' ';'), overmount
-    rootfs with the new root (cd /newmount; mount --move . /; chroot .),
-    attach stdin/stdout/stderr to the new /dev/console, and exec the new init.
-
-    Since this is a remarkably persnickety process (and involves deleting
-    commands before you can run them), the klibc package introduced a helper
-    program (utils/run_init.c) to do all this for you.  Most other packages
-    (such as busybox) have named this command "switch_root".
-
-    However, if the kernel is booted with "nullfs_rootfs", pivot_root() works
+    umount the ramdisk.  With nullfs as the true root, pivot_root() works
     normally from the initramfs.  Userspace can simply do::
 
       chdir(new_root);
       pivot_root(".", ".");
       umount2(".", MNT_DETACH);
 
-    This is the preferred method when nullfs_rootfs is enabled.
+    This is the preferred method for switching root filesystems.
 
 Populating initramfs:
 ---------------------
diff --git a/fs/namespace.c b/fs/namespace.c
index a44ebb2f1161..53d1055c1825 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -75,17 +75,6 @@ static int __init initramfs_options_setup(char *str)
 
 __setup("initramfs_options=", initramfs_options_setup);
 
-bool nullfs_rootfs = false;
-
-static int __init nullfs_rootfs_setup(char *str)
-{
-	if (*str)
-		return 0;
-	nullfs_rootfs = true;
-	return 1;
-}
-__setup("nullfs_rootfs", nullfs_rootfs_setup);
-
 static u64 event;
 static DEFINE_XARRAY_FLAGS(mnt_id_xa, XA_FLAGS_ALLOC);
 static DEFINE_IDA(mnt_group_ida);
@@ -4593,10 +4582,9 @@ int path_pivot_root(struct path *new, struct path *old)
  * pointed to by put_old must yield the same directory as new_root. No other
  * file system may be mounted on put_old. After all, new_root is a mountpoint.
  *
- * Also, the current root cannot be on the 'rootfs' (initial ramfs) filesystem
- * unless the kernel was booted with "nullfs_rootfs". See
- * Documentation/filesystems/ramfs-rootfs-initramfs.rst for alternatives
- * in this situation.
+ * The immutable nullfs filesystem is mounted as the true root of the VFS
+ * hierarchy. The mutable rootfs (tmpfs/ramfs) is layered on top of this,
+ * allowing pivot_root() to work normally from initramfs.
  *
  * Notes:
  *  - we don't move root/cwd if they are not at the root (reason: if something
@@ -5993,49 +5981,39 @@ static void __init init_mount_tree(void)
 	struct path root;
 
 	/*
-	 * When nullfs is used, we create two mounts:
+	 * We create two mounts:
 	 *
 	 * (1) nullfs with mount id 1
 	 * (2) mutable rootfs with mount id 2
 	 *
 	 * with (2) mounted on top of (1).
 	 */
-	if (nullfs_rootfs) {
-		nullfs_mnt = vfs_kern_mount(&nullfs_fs_type, 0, "nullfs", NULL);
-		if (IS_ERR(nullfs_mnt))
-			panic("VFS: Failed to create nullfs");
-	}
+	nullfs_mnt = vfs_kern_mount(&nullfs_fs_type, 0, "nullfs", NULL);
+	if (IS_ERR(nullfs_mnt))
+		panic("VFS: Failed to create nullfs");
 
 	mnt = vfs_kern_mount(&rootfs_fs_type, 0, "rootfs", initramfs_options);
 	if (IS_ERR(mnt))
 		panic("Can't create rootfs");
 
-	if (nullfs_rootfs) {
-		VFS_WARN_ON_ONCE(real_mount(nullfs_mnt)->mnt_id != 1);
-		VFS_WARN_ON_ONCE(real_mount(mnt)->mnt_id != 2);
+	VFS_WARN_ON_ONCE(real_mount(nullfs_mnt)->mnt_id != 1);
+	VFS_WARN_ON_ONCE(real_mount(mnt)->mnt_id != 2);
 
-		/* The namespace root is the nullfs mnt. */
-		mnt_root		= real_mount(nullfs_mnt);
-		init_mnt_ns.root	= mnt_root;
+	/* The namespace root is the nullfs mnt. */
+	mnt_root		= real_mount(nullfs_mnt);
+	init_mnt_ns.root	= mnt_root;
 
-		/* Mount mutable rootfs on top of nullfs. */
-		root.mnt		= nullfs_mnt;
-		root.dentry		= nullfs_mnt->mnt_root;
+	/* Mount mutable rootfs on top of nullfs. */
+	root.mnt		= nullfs_mnt;
+	root.dentry		= nullfs_mnt->mnt_root;
 
-		LOCK_MOUNT_EXACT(mp, &root);
-		if (unlikely(IS_ERR(mp.parent)))
-			panic("VFS: Failed to mount rootfs on nullfs");
-		scoped_guard(mount_writer)
-			attach_mnt(real_mount(mnt), mp.parent, mp.mp);
+	LOCK_MOUNT_EXACT(mp, &root);
+	if (unlikely(IS_ERR(mp.parent)))
+		panic("VFS: Failed to mount rootfs on nullfs");
+	scoped_guard(mount_writer)
+		attach_mnt(real_mount(mnt), mp.parent, mp.mp);
 
-		pr_info("VFS: Finished mounting rootfs on nullfs\n");
-	} else {
-		VFS_WARN_ON_ONCE(real_mount(mnt)->mnt_id != 1);
-
-		/* The namespace root is the mutable rootfs. */
-		mnt_root		= real_mount(mnt);
-		init_mnt_ns.root	= mnt_root;
-	}
+	pr_info("VFS: Finished mounting rootfs on nullfs\n");
 
 	/*
 	 * We've dropped all locks here but that's fine. Not just are we
diff --git a/init/do_mounts.c b/init/do_mounts.c
index 675397c8a7a4..df6847bcf1f2 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -493,21 +493,15 @@ void __init prepare_namespace(void)
 out:
 	devtmpfs_mount();
 
-	if (nullfs_rootfs) {
-		if (init_pivot_root(".", ".")) {
-			pr_err("VFS: Failed to pivot into new rootfs\n");
-			return;
-		}
-		if (init_umount(".", MNT_DETACH)) {
-			pr_err("VFS: Failed to unmount old rootfs\n");
-			return;
-		}
-		pr_info("VFS: Pivoted into new rootfs\n");
+	if (init_pivot_root(".", ".")) {
+		pr_err("VFS: Failed to pivot into new rootfs\n");
 		return;
 	}
-
-	init_mount(".", "/", NULL, MS_MOVE, NULL);
-	init_chroot(".");
+	if (init_umount(".", MNT_DETACH)) {
+		pr_err("VFS: Failed to unmount old rootfs\n");
+		return;
+	}
+	pr_info("VFS: Pivoted into new rootfs\n");
 }
 
 static bool is_tmpfs;
diff --git a/init/do_mounts.h b/init/do_mounts.h
index fbfee810aa89..6069ea3eb80d 100644
--- a/init/do_mounts.h
+++ b/init/do_mounts.h
@@ -15,7 +15,6 @@
 void  mount_root_generic(char *name, char *pretty_name, int flags);
 void  mount_root(char *root_device_name);
 extern int root_mountflags;
-extern bool nullfs_rootfs;
 
 static inline __init int create_dev(char *name, dev_t dev)
 {
-- 
2.47.3


