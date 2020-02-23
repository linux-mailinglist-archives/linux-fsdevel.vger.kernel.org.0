Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 348F11692AF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Feb 2020 02:20:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbgBWBUo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 22 Feb 2020 20:20:44 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:50166 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727207AbgBWBUn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 22 Feb 2020 20:20:43 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j5fwc-00HDg5-3Z; Sun, 23 Feb 2020 01:20:30 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFC][PATCH v2 16/34] LOOKUP_MOUNTPOINT: fold path_mountpointat() into path_lookupat()
Date:   Sun, 23 Feb 2020 01:16:08 +0000
Message-Id: <20200223011626.4103706-16-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200223011626.4103706-1-viro@ZenIV.linux.org.uk>
References: <20200223011154.GY23230@ZenIV.linux.org.uk>
 <20200223011626.4103706-1-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

New LOOKUP flag, telling path_lookupat() to act as path_mountpointat().
IOW, traverse mounts at the final point and skip revalidation of the
location where it ends up.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/autofs/dev-ioctl.c |  6 ++--
 fs/internal.h         |  1 -
 fs/namei.c            | 89 ++++-----------------------------------------------
 fs/namespace.c        |  4 +--
 include/linux/namei.h |  2 +-
 5 files changed, 12 insertions(+), 90 deletions(-)

diff --git a/fs/autofs/dev-ioctl.c b/fs/autofs/dev-ioctl.c
index a3cdb0036c5d..f3a0f412b43b 100644
--- a/fs/autofs/dev-ioctl.c
+++ b/fs/autofs/dev-ioctl.c
@@ -186,7 +186,7 @@ static int find_autofs_mount(const char *pathname,
 	struct path path;
 	int err;
 
-	err = kern_path_mountpoint(AT_FDCWD, pathname, &path, 0);
+	err = kern_path(pathname, LOOKUP_MOUNTPOINT, &path);
 	if (err)
 		return err;
 	err = -ENOENT;
@@ -519,8 +519,8 @@ static int autofs_dev_ioctl_ismountpoint(struct file *fp,
 
 	if (!fp || param->ioctlfd == -1) {
 		if (autofs_type_any(type))
-			err = kern_path_mountpoint(AT_FDCWD,
-						   name, &path, LOOKUP_FOLLOW);
+			err = kern_path(name, LOOKUP_FOLLOW | LOOKUP_MOUNTPOINT,
+					&path);
 		else
 			err = find_autofs_mount(name, &path,
 						test_by_type, &type);
diff --git a/fs/internal.h b/fs/internal.h
index f3f280b952a3..b108a8eb75ca 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -61,7 +61,6 @@ extern int finish_clean_context(struct fs_context *fc);
  */
 extern int filename_lookup(int dfd, struct filename *name, unsigned flags,
 			   struct path *path, struct path *root);
-extern int user_path_mountpoint_at(int, const char __user *, unsigned int, struct path *);
 extern int vfs_path_lookup(struct dentry *, struct vfsmount *,
 			   const char *, unsigned int, struct path *);
 long do_mknodat(int dfd, const char __user *filename, umode_t mode,
diff --git a/fs/namei.c b/fs/namei.c
index 28835ee7168a..6f1f46b931a6 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2382,6 +2382,10 @@ static int path_lookupat(struct nameidata *nd, unsigned flags, struct path *path
 	if (!err && nd->flags & LOOKUP_DIRECTORY)
 		if (!d_can_lookup(nd->path.dentry))
 			err = -ENOTDIR;
+	if (!err && unlikely(nd->flags & LOOKUP_MOUNTPOINT)) {
+		err = handle_lookup_down(nd);
+		nd->flags &= ~LOOKUP_JUMPED; // no d_weak_revalidate(), please...
+	}
 	if (!err) {
 		*path = nd->path;
 		nd->path.mnt = NULL;
@@ -2410,7 +2414,8 @@ int filename_lookup(int dfd, struct filename *name, unsigned flags,
 		retval = path_lookupat(&nd, flags | LOOKUP_REVAL, path);
 
 	if (likely(!retval))
-		audit_inode(name, path->dentry, 0);
+		audit_inode(name, path->dentry,
+			    flags & LOOKUP_MOUNTPOINT ? AUDIT_INODE_NOEVAL : 0);
 	restore_nameidata();
 	putname(name);
 	return retval;
@@ -2688,88 +2693,6 @@ int user_path_at_empty(int dfd, const char __user *name, unsigned flags,
 }
 EXPORT_SYMBOL(user_path_at_empty);
 
-/**
- * path_mountpoint - look up a path to be umounted
- * @nd:		lookup context
- * @flags:	lookup flags
- * @path:	pointer to container for result
- *
- * Look up the given name, but don't attempt to revalidate the last component.
- * Returns 0 and "path" will be valid on success; Returns error otherwise.
- */
-static int
-path_mountpoint(struct nameidata *nd, unsigned flags, struct path *path)
-{
-	const char *s = path_init(nd, flags);
-	int err;
-
-	while (!(err = link_path_walk(s, nd)) &&
-		(err = lookup_last(nd)) > 0) {
-		s = trailing_symlink(nd);
-	}
-	if (!err && (nd->flags & LOOKUP_RCU))
-		err = unlazy_walk(nd);
-	if (!err)
-		err = handle_lookup_down(nd);
-	if (!err) {
-		*path = nd->path;
-		nd->path.mnt = NULL;
-		nd->path.dentry = NULL;
-	}
-	terminate_walk(nd);
-	return err;
-}
-
-static int
-filename_mountpoint(int dfd, struct filename *name, struct path *path,
-			unsigned int flags)
-{
-	struct nameidata nd;
-	int error;
-	if (IS_ERR(name))
-		return PTR_ERR(name);
-	set_nameidata(&nd, dfd, name);
-	error = path_mountpoint(&nd, flags | LOOKUP_RCU, path);
-	if (unlikely(error == -ECHILD))
-		error = path_mountpoint(&nd, flags, path);
-	if (unlikely(error == -ESTALE))
-		error = path_mountpoint(&nd, flags | LOOKUP_REVAL, path);
-	if (likely(!error))
-		audit_inode(name, path->dentry, AUDIT_INODE_NOEVAL);
-	restore_nameidata();
-	putname(name);
-	return error;
-}
-
-/**
- * user_path_mountpoint_at - lookup a path from userland in order to umount it
- * @dfd:	directory file descriptor
- * @name:	pathname from userland
- * @flags:	lookup flags
- * @path:	pointer to container to hold result
- *
- * A umount is a special case for path walking. We're not actually interested
- * in the inode in this situation, and ESTALE errors can be a problem. We
- * simply want track down the dentry and vfsmount attached at the mountpoint
- * and avoid revalidating the last component.
- *
- * Returns 0 and populates "path" on success.
- */
-int
-user_path_mountpoint_at(int dfd, const char __user *name, unsigned int flags,
-			struct path *path)
-{
-	return filename_mountpoint(dfd, getname(name), path, flags);
-}
-
-int
-kern_path_mountpoint(int dfd, const char *name, struct path *path,
-			unsigned int flags)
-{
-	return filename_mountpoint(dfd, getname_kernel(name), path, flags);
-}
-EXPORT_SYMBOL(kern_path_mountpoint);
-
 int __check_sticky(struct inode *dir, struct inode *inode)
 {
 	kuid_t fsuid = current_fsuid();
diff --git a/fs/namespace.c b/fs/namespace.c
index a9e556224945..ef3f2a33992c 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1669,7 +1669,7 @@ int ksys_umount(char __user *name, int flags)
 	struct path path;
 	struct mount *mnt;
 	int retval;
-	int lookup_flags = 0;
+	int lookup_flags = LOOKUP_MOUNTPOINT;
 
 	if (flags & ~(MNT_FORCE | MNT_DETACH | MNT_EXPIRE | UMOUNT_NOFOLLOW))
 		return -EINVAL;
@@ -1680,7 +1680,7 @@ int ksys_umount(char __user *name, int flags)
 	if (!(flags & UMOUNT_NOFOLLOW))
 		lookup_flags |= LOOKUP_FOLLOW;
 
-	retval = user_path_mountpoint_at(AT_FDCWD, name, lookup_flags, &path);
+	retval = user_path_at(AT_FDCWD, name, lookup_flags, &path);
 	if (retval)
 		goto out;
 	mnt = real_mount(path.mnt);
diff --git a/include/linux/namei.h b/include/linux/namei.h
index 0dd980d7318f..d9576a051808 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -23,6 +23,7 @@ enum {LAST_NORM, LAST_ROOT, LAST_DOT, LAST_DOTDOT, LAST_BIND};
 #define LOOKUP_AUTOMOUNT	0x0004  /* force terminal automount */
 #define LOOKUP_EMPTY		0x4000	/* accept empty path [user_... only] */
 #define LOOKUP_DOWN		0x8000	/* follow mounts in the starting point */
+#define LOOKUP_MOUNTPOINT	0x0080	/* follow mounts in the end */
 
 #define LOOKUP_REVAL		0x0020	/* tell ->d_revalidate() to trust no cache */
 #define LOOKUP_RCU		0x0040	/* RCU pathwalk mode; semi-internal */
@@ -64,7 +65,6 @@ extern struct dentry *kern_path_create(int, const char *, struct path *, unsigne
 extern struct dentry *user_path_create(int, const char __user *, struct path *, unsigned int);
 extern void done_path_create(struct path *, struct dentry *);
 extern struct dentry *kern_path_locked(const char *, struct path *);
-extern int kern_path_mountpoint(int, const char *, struct path *, unsigned int);
 
 extern struct dentry *try_lookup_one_len(const char *, struct dentry *, int);
 extern struct dentry *lookup_one_len(const char *, struct dentry *, int);
-- 
2.11.0

