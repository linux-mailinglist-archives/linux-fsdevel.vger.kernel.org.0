Return-Path: <linux-fsdevel+bounces-73270-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3203D13C9B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 16:48:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0BB8230223E8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 15:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77191363C4B;
	Mon, 12 Jan 2026 15:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rXkAcNx8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDD330498E
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jan 2026 15:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768232844; cv=none; b=Dm+HzJxtdQE10hyeGhkbzAc2VryYX8YELTEEaaDIHcfz+G9fy4no5P+rZ0uKV7EPbfkySddregvOswM6psU2g5JWSotKpUeDcCdfwXAC+ZYP6P3rZ8kPzuYO/9qQ5oQv6lMCu+Ye2mgOObLg8tVp7cqVGTnC/1qfmlCGVNpqPB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768232844; c=relaxed/simple;
	bh=Z7N63LQLlfdYPAkEQalMJeaHIQecczkrDpo9remg+94=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u3JpPpHZluHIPxef8C1KBETT9pj015bgWFZ7nOWPJtOvCticcZui36bnNPUT7C1sB9kD6bT+1md9Bf9F+mHNZafXaooW2wFO61a9rAvHeelXedIPMZDBeQv2KmgpZoHp72mWbIW/pHLsdo8+rdFXH5FZ+Y5FYg+4Ocr2VyvRsk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rXkAcNx8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9FAEC19423;
	Mon, 12 Jan 2026 15:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768232844;
	bh=Z7N63LQLlfdYPAkEQalMJeaHIQecczkrDpo9remg+94=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rXkAcNx8EUrCu689GfikHNcXusp7AOY8IZJD2/eoXmgppwZ5Ad2KxSC/2R0PDMm/o
	 QO2Nq/hCrDGr8B9gu2lpnH/NapmCgNU+Lgb+DJU1dawl5/nS0lPuzFQG6pRqCasW/S
	 cLqAyQ/jEajyw3PJKE/P8t2yO/aTimchIjlwAOrhApiK/nu48Eb4k1a8aSxW6feLPE
	 oeJW6reAM0EXsKkSuMo4hfawe9yoeeo/foIPUqGxGIwySiW77qUAXRL8DDiW+OTnwp
	 c25VCQNmmITIe1cmg5yLm1bwrkA3VozxIYfcbBwwsQ7UfYcfGzFApEeycsWZQZzZtO
	 u93JNzyxGqAIg==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 12 Jan 2026 16:47:09 +0100
Subject: [PATCH v2 2/4] fs: add init_pivot_root()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260112-work-immutable-rootfs-v2-2-88dd1c34a204@kernel.org>
References: <20260112-work-immutable-rootfs-v2-0-88dd1c34a204@kernel.org>
In-Reply-To: <20260112-work-immutable-rootfs-v2-0-88dd1c34a204@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
 Lennart Poettering <lennart@poettering.net>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 Josef Bacik <josef@toxicpanda.com>, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=8371; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Z7N63LQLlfdYPAkEQalMJeaHIQecczkrDpo9remg+94=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSmirfezDL+YafvtGPV3ky5vuKI4olGNsk671ss7rZ79
 AmI9Yp2lLIwiHExyIopsji0m4TLLeep2GyUqQEzh5UJZAgDF6cATOS6PSPDs28/5ObvF9cQubix
 0GXZ5gl3eX3EFmsoiQSHqK5/uvjnA4a/spusbjhGimwx3mD4c9GzWdenJF0vP+spXfbkGpNHvt0
 1NgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

We will soon be able to pivot_root() with the introduction of the
immutable rootfs. Add a wrapper for kernel internal usage.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/init.c                     |  17 +++++++
 fs/internal.h                 |   1 +
 fs/namespace.c                | 101 ++++++++++++++++++++++--------------------
 include/linux/init_syscalls.h |   1 +
 4 files changed, 73 insertions(+), 47 deletions(-)

diff --git a/fs/init.c b/fs/init.c
index e0f5429c0a49..e33b2690d851 100644
--- a/fs/init.c
+++ b/fs/init.c
@@ -13,6 +13,23 @@
 #include <linux/security.h>
 #include "internal.h"
 
+int __init init_pivot_root(const char *new_root, const char *put_old)
+{
+	struct path new_path __free(path_put) = {};
+	struct path old_path __free(path_put) = {};
+	int ret;
+
+	ret = kern_path(new_root, LOOKUP_FOLLOW | LOOKUP_DIRECTORY, &new_path);
+	if (ret)
+		return ret;
+
+	ret = kern_path(put_old, LOOKUP_FOLLOW | LOOKUP_DIRECTORY, &old_path);
+	if (ret)
+		return ret;
+
+	return path_pivot_root(&new_path, &old_path);
+}
+
 int __init init_mount(const char *dev_name, const char *dir_name,
 		const char *type_page, unsigned long flags, void *data_page)
 {
diff --git a/fs/internal.h b/fs/internal.h
index ab638d41ab81..4b27a4b0fdef 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -90,6 +90,7 @@ extern bool may_mount(void);
 int path_mount(const char *dev_name, const struct path *path,
 		const char *type_page, unsigned long flags, void *data_page);
 int path_umount(const struct path *path, int flags);
+int path_pivot_root(struct path *new, struct path *old);
 
 int show_path(struct seq_file *m, struct dentry *root);
 
diff --git a/fs/namespace.c b/fs/namespace.c
index 8b082b1de7f3..9261f56ccc81 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4498,36 +4498,8 @@ bool path_is_under(const struct path *path1, const struct path *path2)
 }
 EXPORT_SYMBOL(path_is_under);
 
-/*
- * pivot_root Semantics:
- * Moves the root file system of the current process to the directory put_old,
- * makes new_root as the new root file system of the current process, and sets
- * root/cwd of all processes which had them on the current root to new_root.
- *
- * Restrictions:
- * The new_root and put_old must be directories, and  must not be on the
- * same file  system as the current process root. The put_old  must  be
- * underneath new_root,  i.e. adding a non-zero number of /.. to the string
- * pointed to by put_old must yield the same directory as new_root. No other
- * file system may be mounted on put_old. After all, new_root is a mountpoint.
- *
- * Also, the current root cannot be on the 'rootfs' (initial ramfs) filesystem.
- * See Documentation/filesystems/ramfs-rootfs-initramfs.rst for alternatives
- * in this situation.
- *
- * Notes:
- *  - we don't move root/cwd if they are not at the root (reason: if something
- *    cared enough to change them, it's probably wrong to force them elsewhere)
- *  - it's okay to pick a root that isn't the root of a file system, e.g.
- *    /nfs/my_root where /nfs is the mount point. It must be a mountpoint,
- *    though, so you may need to say mount --bind /nfs/my_root /nfs/my_root
- *    first.
- */
-SYSCALL_DEFINE2(pivot_root, const char __user *, new_root,
-		const char __user *, put_old)
+int path_pivot_root(struct path *new, struct path *old)
 {
-	struct path new __free(path_put) = {};
-	struct path old __free(path_put) = {};
 	struct path root __free(path_put) = {};
 	struct mount *new_mnt, *root_mnt, *old_mnt, *root_parent, *ex_parent;
 	int error;
@@ -4535,28 +4507,18 @@ SYSCALL_DEFINE2(pivot_root, const char __user *, new_root,
 	if (!may_mount())
 		return -EPERM;
 
-	error = user_path_at(AT_FDCWD, new_root,
-			     LOOKUP_FOLLOW | LOOKUP_DIRECTORY, &new);
-	if (error)
-		return error;
-
-	error = user_path_at(AT_FDCWD, put_old,
-			     LOOKUP_FOLLOW | LOOKUP_DIRECTORY, &old);
-	if (error)
-		return error;
-
-	error = security_sb_pivotroot(&old, &new);
+	error = security_sb_pivotroot(old, new);
 	if (error)
 		return error;
 
 	get_fs_root(current->fs, &root);
 
-	LOCK_MOUNT(old_mp, &old);
+	LOCK_MOUNT(old_mp, old);
 	old_mnt = old_mp.parent;
 	if (IS_ERR(old_mnt))
 		return PTR_ERR(old_mnt);
 
-	new_mnt = real_mount(new.mnt);
+	new_mnt = real_mount(new->mnt);
 	root_mnt = real_mount(root.mnt);
 	ex_parent = new_mnt->mnt_parent;
 	root_parent = root_mnt->mnt_parent;
@@ -4568,7 +4530,7 @@ SYSCALL_DEFINE2(pivot_root, const char __user *, new_root,
 		return -EINVAL;
 	if (new_mnt->mnt.mnt_flags & MNT_LOCKED)
 		return -EINVAL;
-	if (d_unlinked(new.dentry))
+	if (d_unlinked(new->dentry))
 		return -ENOENT;
 	if (new_mnt == root_mnt || old_mnt == root_mnt)
 		return -EBUSY; /* loop, on the same file system  */
@@ -4576,15 +4538,15 @@ SYSCALL_DEFINE2(pivot_root, const char __user *, new_root,
 		return -EINVAL; /* not a mountpoint */
 	if (!mnt_has_parent(root_mnt))
 		return -EINVAL; /* absolute root */
-	if (!path_mounted(&new))
+	if (!path_mounted(new))
 		return -EINVAL; /* not a mountpoint */
 	if (!mnt_has_parent(new_mnt))
 		return -EINVAL; /* absolute root */
 	/* make sure we can reach put_old from new_root */
-	if (!is_path_reachable(old_mnt, old_mp.mp->m_dentry, &new))
+	if (!is_path_reachable(old_mnt, old_mp.mp->m_dentry, new))
 		return -EINVAL;
 	/* make certain new is below the root */
-	if (!is_path_reachable(new_mnt, new.dentry, &root))
+	if (!is_path_reachable(new_mnt, new->dentry, &root))
 		return -EINVAL;
 	lock_mount_hash();
 	umount_mnt(new_mnt);
@@ -4603,10 +4565,55 @@ SYSCALL_DEFINE2(pivot_root, const char __user *, new_root,
 	unlock_mount_hash();
 	mnt_notify_add(root_mnt);
 	mnt_notify_add(new_mnt);
-	chroot_fs_refs(&root, &new);
+	chroot_fs_refs(&root, new);
 	return 0;
 }
 
+/*
+ * pivot_root Semantics:
+ * Moves the root file system of the current process to the directory put_old,
+ * makes new_root as the new root file system of the current process, and sets
+ * root/cwd of all processes which had them on the current root to new_root.
+ *
+ * Restrictions:
+ * The new_root and put_old must be directories, and  must not be on the
+ * same file  system as the current process root. The put_old  must  be
+ * underneath new_root,  i.e. adding a non-zero number of /.. to the string
+ * pointed to by put_old must yield the same directory as new_root. No other
+ * file system may be mounted on put_old. After all, new_root is a mountpoint.
+ *
+ * Also, the current root cannot be on the 'rootfs' (initial ramfs) filesystem.
+ * See Documentation/filesystems/ramfs-rootfs-initramfs.rst for alternatives
+ * in this situation.
+ *
+ * Notes:
+ *  - we don't move root/cwd if they are not at the root (reason: if something
+ *    cared enough to change them, it's probably wrong to force them elsewhere)
+ *  - it's okay to pick a root that isn't the root of a file system, e.g.
+ *    /nfs/my_root where /nfs is the mount point. It must be a mountpoint,
+ *    though, so you may need to say mount --bind /nfs/my_root /nfs/my_root
+ *    first.
+ */
+SYSCALL_DEFINE2(pivot_root, const char __user *, new_root,
+		const char __user *, put_old)
+{
+	struct path new __free(path_put) = {};
+	struct path old __free(path_put) = {};
+	int error;
+
+	error = user_path_at(AT_FDCWD, new_root,
+			     LOOKUP_FOLLOW | LOOKUP_DIRECTORY, &new);
+	if (error)
+		return error;
+
+	error = user_path_at(AT_FDCWD, put_old,
+			     LOOKUP_FOLLOW | LOOKUP_DIRECTORY, &old);
+	if (error)
+		return error;
+
+	return path_pivot_root(&new, &old);
+}
+
 static unsigned int recalc_flags(struct mount_kattr *kattr, struct mount *mnt)
 {
 	unsigned int flags = mnt->mnt.mnt_flags;
diff --git a/include/linux/init_syscalls.h b/include/linux/init_syscalls.h
index 92045d18cbfc..28776ee28d8e 100644
--- a/include/linux/init_syscalls.h
+++ b/include/linux/init_syscalls.h
@@ -17,3 +17,4 @@ int __init init_mkdir(const char *pathname, umode_t mode);
 int __init init_rmdir(const char *pathname);
 int __init init_utimes(char *filename, struct timespec64 *ts);
 int __init init_dup(struct file *file);
+int __init init_pivot_root(const char *new_root, const char *put_old);

-- 
2.47.3


