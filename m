Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25EC32B33B4
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Nov 2020 11:39:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbgKOKjF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 15 Nov 2020 05:39:05 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:58788 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727025AbgKOKiz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 15 Nov 2020 05:38:55 -0500
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1keFQd-0000Kt-4L; Sun, 15 Nov 2020 10:38:39 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org
Cc:     John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Geoffrey Thomas <geofft@ldpreload.com>,
        Mrunal Patel <mpatel@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Andy Lutomirski <luto@kernel.org>,
        Theodore Tso <tytso@mit.edu>, Alban Crequy <alban@kinvolk.io>,
        Tycho Andersen <tycho@tycho.ws>,
        David Howells <dhowells@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Jann Horn <jannh@google.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@ubuntu.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Lennart Poettering <lennart@poettering.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>, smbarber@chromium.org,
        Phil Estes <estesp@gmail.com>, Serge Hallyn <serge@hallyn.com>,
        Kees Cook <keescook@chromium.org>,
        Todd Kjos <tkjos@google.com>, Jonathan Corbet <corbet@lwn.net>,
        containers@lists.linux-foundation.org,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-audit@redhat.com,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 09/39] namei: add idmapped mount aware permission helpers
Date:   Sun, 15 Nov 2020 11:36:48 +0100
Message-Id: <20201115103718.298186-10-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201115103718.298186-1-christian.brauner@ubuntu.com>
References: <20201115103718.298186-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The two helpers inode_permission() and generic_permission() are used by the
vfs to perform basic permission checking by verifying that the caller is
privileged over an inode. In order to handle idmapped mounts we extend the
two helpers with an additional user namespace argument. On idmapped mounts
the two helpers will make sure to map the inode according to the mount's
user namespace and then peform identical permission checks to
inode_permission() and generic_permission(). If the initial user namespace
is passed nothing changes so there will be no performance impact on
non-idmapped mounts.

Cc: Christoph Hellwig <hch@lst.de>
Cc: David Howells <dhowells@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
- Christoph Hellwig:
  - Don't pollute the vfs with additional helpers simply extend the existing
    helpers with an additional argument and switch all callers.
---
 fs/attr.c                          |  3 +-
 fs/btrfs/inode.c                   |  2 +-
 fs/btrfs/ioctl.c                   | 10 ++---
 fs/ceph/inode.c                    |  2 +-
 fs/cifs/cifsfs.c                   |  2 +-
 fs/configfs/symlink.c              |  2 +-
 fs/ecryptfs/inode.c                |  2 +-
 fs/exec.c                          |  2 +-
 fs/fuse/dir.c                      |  4 +-
 fs/gfs2/inode.c                    |  2 +-
 fs/hostfs/hostfs_kern.c            |  2 +-
 fs/init.c                          |  9 ++--
 fs/kernfs/inode.c                  |  2 +-
 fs/libfs.c                         |  7 ++-
 fs/namei.c                         | 68 +++++++++++++++++-------------
 fs/nfs/dir.c                       |  2 +-
 fs/nfsd/nfsfh.c                    |  2 +-
 fs/nfsd/vfs.c                      |  4 +-
 fs/nilfs2/inode.c                  |  2 +-
 fs/notify/fanotify/fanotify_user.c |  2 +-
 fs/notify/inotify/inotify_user.c   |  2 +-
 fs/ocfs2/file.c                    |  2 +-
 fs/ocfs2/refcounttree.c            |  4 +-
 fs/open.c                          | 10 ++---
 fs/orangefs/inode.c                |  2 +-
 fs/overlayfs/file.c                |  2 +-
 fs/overlayfs/inode.c               |  4 +-
 fs/overlayfs/util.c                |  2 +-
 fs/posix_acl.c                     | 17 +++++---
 fs/proc/base.c                     |  4 +-
 fs/proc/fd.c                       |  2 +-
 fs/reiserfs/xattr.c                |  2 +-
 fs/remap_range.c                   |  2 +-
 fs/udf/file.c                      |  2 +-
 fs/verity/enable.c                 |  2 +-
 fs/xattr.c                         |  2 +-
 include/linux/fs.h                 |  4 +-
 include/linux/posix_acl.h          |  4 +-
 ipc/mqueue.c                       |  2 +-
 kernel/bpf/inode.c                 |  4 +-
 kernel/cgroup/cgroup.c             |  2 +-
 kernel/sys.c                       |  2 +-
 mm/madvise.c                       |  2 +-
 mm/memcontrol.c                    |  2 +-
 mm/mincore.c                       |  2 +-
 net/unix/af_unix.c                 |  2 +-
 46 files changed, 122 insertions(+), 96 deletions(-)

diff --git a/fs/attr.c b/fs/attr.c
index d270f640a192..c9e29e589cec 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -244,7 +244,8 @@ int notify_change(struct dentry * dentry, struct iattr * attr, struct inode **de
 			return -EPERM;
 
 		if (!inode_owner_or_capable(inode)) {
-			error = inode_permission(inode, MAY_WRITE);
+			error = inode_permission(&init_user_ns, inode,
+						 MAY_WRITE);
 			if (error)
 				return error;
 		}
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index da58c58ef9aa..32e3bf88d4f7 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -9794,7 +9794,7 @@ static int btrfs_permission(struct inode *inode, int mask)
 		if (BTRFS_I(inode)->flags & BTRFS_INODE_READONLY)
 			return -EACCES;
 	}
-	return generic_permission(inode, mask);
+	return generic_permission(&init_user_ns, inode, mask);
 }
 
 static int btrfs_tmpfile(struct inode *dir, struct dentry *dentry, umode_t mode)
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index ab408a23ba32..771ee08920ed 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -910,7 +910,7 @@ static int btrfs_may_delete(struct inode *dir, struct dentry *victim, int isdir)
 	BUG_ON(d_inode(victim->d_parent) != dir);
 	audit_inode_child(dir, victim, AUDIT_TYPE_CHILD_DELETE);
 
-	error = inode_permission(dir, MAY_WRITE | MAY_EXEC);
+	error = inode_permission(&init_user_ns, dir, MAY_WRITE | MAY_EXEC);
 	if (error)
 		return error;
 	if (IS_APPEND(dir))
@@ -939,7 +939,7 @@ static inline int btrfs_may_create(struct inode *dir, struct dentry *child)
 		return -EEXIST;
 	if (IS_DEADDIR(dir))
 		return -ENOENT;
-	return inode_permission(dir, MAY_WRITE | MAY_EXEC);
+	return inode_permission(&init_user_ns, dir, MAY_WRITE | MAY_EXEC);
 }
 
 /*
@@ -2489,7 +2489,7 @@ static int btrfs_search_path_in_tree_user(struct inode *inode,
 				ret = PTR_ERR(temp_inode);
 				goto out_put;
 			}
-			ret = inode_permission(temp_inode, MAY_READ | MAY_EXEC);
+			ret = inode_permission(&init_user_ns, temp_inode, MAY_READ | MAY_EXEC);
 			iput(temp_inode);
 			if (ret) {
 				ret = -EACCES;
@@ -3019,7 +3019,7 @@ static noinline int btrfs_ioctl_snap_destroy(struct file *file,
 		if (root == dest)
 			goto out_dput;
 
-		err = inode_permission(inode, MAY_WRITE | MAY_EXEC);
+		err = inode_permission(&init_user_ns, inode, MAY_WRITE | MAY_EXEC);
 		if (err)
 			goto out_dput;
 	}
@@ -3090,7 +3090,7 @@ static int btrfs_ioctl_defrag(struct file *file, void __user *argp)
 		 * running and allows defrag on files open in read-only mode.
 		 */
 		if (!capable(CAP_SYS_ADMIN) &&
-		    inode_permission(inode, MAY_WRITE)) {
+		    inode_permission(&init_user_ns, inode, MAY_WRITE)) {
 			ret = -EPERM;
 			goto out;
 		}
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 526faf4778ce..abfe42df8a1a 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -2335,7 +2335,7 @@ int ceph_permission(struct inode *inode, int mask)
 	err = ceph_do_getattr(inode, CEPH_CAP_AUTH_SHARED, false);
 
 	if (!err)
-		err = generic_permission(inode, mask);
+		err = generic_permission(&init_user_ns, inode, mask);
 	return err;
 }
 
diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
index 472cb7777e3e..f79dbc581eee 100644
--- a/fs/cifs/cifsfs.c
+++ b/fs/cifs/cifsfs.c
@@ -316,7 +316,7 @@ static int cifs_permission(struct inode *inode, int mask)
 		on the client (above and beyond ACL on servers) for
 		servers which do not support setting and viewing mode bits,
 		so allowing client to check permissions is useful */
-		return generic_permission(inode, mask);
+		return generic_permission(&init_user_ns, inode, mask);
 }
 
 static struct kmem_cache *cifs_inode_cachep;
diff --git a/fs/configfs/symlink.c b/fs/configfs/symlink.c
index cb61467478ca..0b592c55f38e 100644
--- a/fs/configfs/symlink.c
+++ b/fs/configfs/symlink.c
@@ -197,7 +197,7 @@ int configfs_symlink(struct inode *dir, struct dentry *dentry, const char *symna
 	if (dentry->d_inode || d_unhashed(dentry))
 		ret = -EEXIST;
 	else
-		ret = inode_permission(dir, MAY_WRITE | MAY_EXEC);
+		ret = inode_permission(&init_user_ns, dir, MAY_WRITE | MAY_EXEC);
 	if (!ret)
 		ret = type->ct_item_ops->allow_link(parent_item, target_item);
 	if (!ret) {
diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index e23752d9a79f..9b1ae410983c 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -864,7 +864,7 @@ int ecryptfs_truncate(struct dentry *dentry, loff_t new_length)
 static int
 ecryptfs_permission(struct inode *inode, int mask)
 {
-	return inode_permission(ecryptfs_inode_to_lower(inode), mask);
+	return inode_permission(&init_user_ns, ecryptfs_inode_to_lower(inode), mask);
 }
 
 /**
diff --git a/fs/exec.c b/fs/exec.c
index 8e75d7a33514..b499a1a03934 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1391,7 +1391,7 @@ EXPORT_SYMBOL(begin_new_exec);
 void would_dump(struct linux_binprm *bprm, struct file *file)
 {
 	struct inode *inode = file_inode(file);
-	if (inode_permission(inode, MAY_READ) < 0) {
+	if (inode_permission(&init_user_ns, inode, MAY_READ) < 0) {
 		struct user_namespace *old, *user_ns;
 		bprm->interp_flags |= BINPRM_FLAGS_ENFORCE_NONDUMP;
 
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index ff7dbeb16f88..7ce7baed3f4f 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1254,7 +1254,7 @@ static int fuse_permission(struct inode *inode, int mask)
 	}
 
 	if (fc->default_permissions) {
-		err = generic_permission(inode, mask);
+		err = generic_permission(&init_user_ns, inode, mask);
 
 		/* If permission is denied, try to refresh file
 		   attributes.  This is also needed, because the root
@@ -1262,7 +1262,7 @@ static int fuse_permission(struct inode *inode, int mask)
 		if (err == -EACCES && !refreshed) {
 			err = fuse_perm_getattr(inode, mask);
 			if (!err)
-				err = generic_permission(inode, mask);
+				err = generic_permission(&init_user_ns, inode, mask);
 		}
 
 		/* Note: the opposite of the above test does not
diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index 6774865f5b5b..5d6ffa898030 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -1850,7 +1850,7 @@ int gfs2_permission(struct inode *inode, int mask)
 	if ((mask & MAY_WRITE) && IS_IMMUTABLE(inode))
 		error = -EPERM;
 	else
-		error = generic_permission(inode, mask);
+		error = generic_permission(&init_user_ns, inode, mask);
 	if (gfs2_holder_initialized(&i_gh))
 		gfs2_glock_dq_uninit(&i_gh);
 
diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index c070c0d8e3e9..36da0c31d053 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -779,7 +779,7 @@ static int hostfs_permission(struct inode *ino, int desired)
 		err = access_file(name, r, w, x);
 	__putname(name);
 	if (!err)
-		err = generic_permission(ino, desired);
+		err = generic_permission(&init_user_ns, ino, desired);
 	return err;
 }
 
diff --git a/fs/init.c b/fs/init.c
index e9c320a48cf1..2b4842f4802b 100644
--- a/fs/init.c
+++ b/fs/init.c
@@ -49,7 +49,8 @@ int __init init_chdir(const char *filename)
 	error = kern_path(filename, LOOKUP_FOLLOW | LOOKUP_DIRECTORY, &path);
 	if (error)
 		return error;
-	error = inode_permission(path.dentry->d_inode, MAY_EXEC | MAY_CHDIR);
+	error = inode_permission(&init_user_ns, path.dentry->d_inode,
+				 MAY_EXEC | MAY_CHDIR);
 	if (!error)
 		set_fs_pwd(current->fs, &path);
 	path_put(&path);
@@ -64,7 +65,8 @@ int __init init_chroot(const char *filename)
 	error = kern_path(filename, LOOKUP_FOLLOW | LOOKUP_DIRECTORY, &path);
 	if (error)
 		return error;
-	error = inode_permission(path.dentry->d_inode, MAY_EXEC | MAY_CHDIR);
+	error = inode_permission(&init_user_ns, path.dentry->d_inode,
+				 MAY_EXEC | MAY_CHDIR);
 	if (error)
 		goto dput_and_out;
 	error = -EPERM;
@@ -118,7 +120,8 @@ int __init init_eaccess(const char *filename)
 	error = kern_path(filename, LOOKUP_FOLLOW, &path);
 	if (error)
 		return error;
-	error = inode_permission(d_inode(path.dentry), MAY_ACCESS);
+	error = inode_permission(&init_user_ns, d_inode(path.dentry),
+				 MAY_ACCESS);
 	path_put(&path);
 	return error;
 }
diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
index fc2469a20fed..ff5598cc1de0 100644
--- a/fs/kernfs/inode.c
+++ b/fs/kernfs/inode.c
@@ -285,7 +285,7 @@ int kernfs_iop_permission(struct inode *inode, int mask)
 	kernfs_refresh_inode(kn, inode);
 	mutex_unlock(&kernfs_mutex);
 
-	return generic_permission(inode, mask);
+	return generic_permission(&init_user_ns, inode, mask);
 }
 
 int kernfs_xattr_get(struct kernfs_node *kn, const char *name,
diff --git a/fs/libfs.c b/fs/libfs.c
index fc34361c1489..23d0a00668fd 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -1316,9 +1316,14 @@ static ssize_t empty_dir_listxattr(struct dentry *dentry, char *list, size_t siz
 	return -EOPNOTSUPP;
 }
 
+static int empty_dir_permission(struct inode *inode, int mask)
+{
+	return generic_permission(&init_user_ns, inode, mask);
+}
+
 static const struct inode_operations empty_dir_inode_operations = {
 	.lookup		= empty_dir_lookup,
-	.permission	= generic_permission,
+	.permission	= empty_dir_permission,
 	.setattr	= empty_dir_setattr,
 	.getattr	= empty_dir_getattr,
 	.listxattr	= empty_dir_listxattr,
diff --git a/fs/namei.c b/fs/namei.c
index 3f52730af6c5..38222f92efb6 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -259,7 +259,7 @@ void putname(struct filename *name)
 		__putname(name);
 }
 
-static int check_acl(struct inode *inode, int mask)
+static int check_acl(struct user_namespace *user_ns, struct inode *inode, int mask)
 {
 #ifdef CONFIG_FS_POSIX_ACL
 	struct posix_acl *acl;
@@ -271,14 +271,14 @@ static int check_acl(struct inode *inode, int mask)
 		/* no ->get_acl() calls in RCU mode... */
 		if (is_uncached_acl(acl))
 			return -ECHILD;
-	        return posix_acl_permission(inode, acl, mask);
+	        return posix_acl_permission(user_ns, inode, acl, mask);
 	}
 
 	acl = get_acl(inode, ACL_TYPE_ACCESS);
 	if (IS_ERR(acl))
 		return PTR_ERR(acl);
 	if (acl) {
-	        int error = posix_acl_permission(inode, acl, mask);
+	        int error = posix_acl_permission(user_ns, inode, acl, mask);
 	        posix_acl_release(acl);
 	        return error;
 	}
@@ -293,12 +293,15 @@ static int check_acl(struct inode *inode, int mask)
  * Note that the POSIX ACL check cares about the MAY_NOT_BLOCK bit,
  * for RCU walking.
  */
-static int acl_permission_check(struct inode *inode, int mask)
+static int acl_permission_check(struct user_namespace *user_ns,
+				struct inode *inode, int mask)
 {
 	unsigned int mode = inode->i_mode;
+	kuid_t i_uid;
 
 	/* Are we the owner? If so, ACL's don't matter */
-	if (likely(uid_eq(current_fsuid(), inode->i_uid))) {
+	i_uid = i_uid_into_mnt(user_ns, inode);
+	if (likely(uid_eq(current_fsuid(), i_uid))) {
 		mask &= 7;
 		mode >>= 6;
 		return (mask & ~mode) ? -EACCES : 0;
@@ -306,7 +309,7 @@ static int acl_permission_check(struct inode *inode, int mask)
 
 	/* Do we have ACL's? */
 	if (IS_POSIXACL(inode) && (mode & S_IRWXG)) {
-		int error = check_acl(inode, mask);
+		int error = check_acl(user_ns, inode, mask);
 		if (error != -EAGAIN)
 			return error;
 	}
@@ -320,7 +323,8 @@ static int acl_permission_check(struct inode *inode, int mask)
 	 * about? Need to check group ownership if so.
 	 */
 	if (mask & (mode ^ (mode >> 3))) {
-		if (in_group_p(inode->i_gid))
+		kgid_t kgid = i_gid_into_mnt(user_ns, inode);
+		if (in_group_p(kgid))
 			mode >>= 3;
 	}
 
@@ -343,25 +347,25 @@ static int acl_permission_check(struct inode *inode, int mask)
  * request cannot be satisfied (eg. requires blocking or too much complexity).
  * It would then be called again in ref-walk mode.
  */
-int generic_permission(struct inode *inode, int mask)
+int generic_permission(struct user_namespace *user_ns, struct inode *inode,
+		       int mask)
 {
 	int ret;
 
 	/*
 	 * Do the basic permission checks.
 	 */
-	ret = acl_permission_check(inode, mask);
+	ret = acl_permission_check(user_ns, inode, mask);
 	if (ret != -EACCES)
 		return ret;
 
 	if (S_ISDIR(inode->i_mode)) {
 		/* DACs are overridable for directories */
 		if (!(mask & MAY_WRITE))
-			if (capable_wrt_inode_uidgid(&init_user_ns, inode,
+			if (capable_wrt_inode_uidgid(user_ns, inode,
 						     CAP_DAC_READ_SEARCH))
 				return 0;
-		if (capable_wrt_inode_uidgid(&init_user_ns, inode,
-					     CAP_DAC_OVERRIDE))
+		if (capable_wrt_inode_uidgid(user_ns, inode, CAP_DAC_OVERRIDE))
 			return 0;
 		return -EACCES;
 	}
@@ -371,7 +375,7 @@ int generic_permission(struct inode *inode, int mask)
 	 */
 	mask &= MAY_READ | MAY_WRITE | MAY_EXEC;
 	if (mask == MAY_READ)
-		if (capable_wrt_inode_uidgid(&init_user_ns, inode,
+		if (capable_wrt_inode_uidgid(user_ns, inode,
 					     CAP_DAC_READ_SEARCH))
 			return 0;
 	/*
@@ -380,8 +384,7 @@ int generic_permission(struct inode *inode, int mask)
 	 * at least one exec bit set.
 	 */
 	if (!(mask & MAY_EXEC) || (inode->i_mode & S_IXUGO))
-		if (capable_wrt_inode_uidgid(&init_user_ns, inode,
-					     CAP_DAC_OVERRIDE))
+		if (capable_wrt_inode_uidgid(user_ns, inode, CAP_DAC_OVERRIDE))
 			return 0;
 
 	return -EACCES;
@@ -394,7 +397,8 @@ EXPORT_SYMBOL(generic_permission);
  * flag in inode->i_opflags, that says "this has not special
  * permission function, use the fast case".
  */
-static inline int do_inode_permission(struct inode *inode, int mask)
+static inline int do_inode_permission(struct user_namespace *user_ns,
+				      struct inode *inode, int mask)
 {
 	if (unlikely(!(inode->i_opflags & IOP_FASTPERM))) {
 		if (likely(inode->i_op->permission))
@@ -405,7 +409,7 @@ static inline int do_inode_permission(struct inode *inode, int mask)
 		inode->i_opflags |= IOP_FASTPERM;
 		spin_unlock(&inode->i_lock);
 	}
-	return generic_permission(inode, mask);
+	return generic_permission(user_ns, inode, mask);
 }
 
 /**
@@ -430,6 +434,7 @@ static int sb_permission(struct super_block *sb, struct inode *inode, int mask)
 
 /**
  * inode_permission - Check for access rights to a given inode
+ * @userns: The user namespace the inode is seen from
  * @inode: Inode to check permission on
  * @mask: Right to check for (%MAY_READ, %MAY_WRITE, %MAY_EXEC)
  *
@@ -439,7 +444,8 @@ static int sb_permission(struct super_block *sb, struct inode *inode, int mask)
  *
  * When checking for MAY_APPEND, MAY_WRITE must also be set in @mask.
  */
-int inode_permission(struct inode *inode, int mask)
+int inode_permission(struct user_namespace *user_ns,
+		     struct inode *inode, int mask)
 {
 	int retval;
 
@@ -463,7 +469,7 @@ int inode_permission(struct inode *inode, int mask)
 			return -EACCES;
 	}
 
-	retval = do_inode_permission(inode, mask);
+	retval = do_inode_permission(user_ns, inode, mask);
 	if (retval)
 		return retval;
 
@@ -1009,7 +1015,7 @@ static bool safe_hardlink_source(struct inode *inode)
 		return false;
 
 	/* Hardlinking to unreadable or unwritable sources is dangerous. */
-	if (inode_permission(inode, MAY_READ | MAY_WRITE))
+	if (inode_permission(&init_user_ns, inode, MAY_READ | MAY_WRITE))
 		return false;
 
 	return true;
@@ -1569,13 +1575,14 @@ static struct dentry *lookup_slow(const struct qstr *name,
 static inline int may_lookup(struct nameidata *nd)
 {
 	if (nd->flags & LOOKUP_RCU) {
-		int err = inode_permission(nd->inode, MAY_EXEC|MAY_NOT_BLOCK);
+		int err = inode_permission(&init_user_ns, nd->inode,
+					   MAY_EXEC | MAY_NOT_BLOCK);
 		if (err != -ECHILD)
 			return err;
 		if (unlazy_walk(nd))
 			return -ECHILD;
 	}
-	return inode_permission(nd->inode, MAY_EXEC);
+	return inode_permission(&init_user_ns, nd->inode, MAY_EXEC);
 }
 
 static int reserve_stack(struct nameidata *nd, struct path *link, unsigned seq)
@@ -2507,7 +2514,7 @@ static int lookup_one_len_common(const char *name, struct dentry *base,
 			return err;
 	}
 
-	return inode_permission(base->d_inode, MAY_EXEC);
+	return inode_permission(&init_user_ns, base->d_inode, MAY_EXEC);
 }
 
 /**
@@ -2701,7 +2708,7 @@ static int may_delete(struct inode *dir, struct dentry *victim, bool isdir)
 
 	audit_inode_child(dir, victim, AUDIT_TYPE_CHILD_DELETE);
 
-	error = inode_permission(dir, MAY_WRITE | MAY_EXEC);
+	error = inode_permission(&init_user_ns, dir, MAY_WRITE | MAY_EXEC);
 	if (error)
 		return error;
 	if (IS_APPEND(dir))
@@ -2745,7 +2752,7 @@ static inline int may_create(struct inode *dir, struct dentry *child)
 	if (!kuid_has_mapping(s_user_ns, current_fsuid()) ||
 	    !kgid_has_mapping(s_user_ns, current_fsgid()))
 		return -EOVERFLOW;
-	return inode_permission(dir, MAY_WRITE | MAY_EXEC);
+	return inode_permission(&init_user_ns, dir, MAY_WRITE | MAY_EXEC);
 }
 
 /*
@@ -2875,7 +2882,7 @@ static int may_open(const struct path *path, int acc_mode, int flag)
 		break;
 	}
 
-	error = inode_permission(inode, MAY_OPEN | acc_mode);
+	error = inode_permission(&init_user_ns, inode, MAY_OPEN | acc_mode);
 	if (error)
 		return error;
 
@@ -2937,7 +2944,8 @@ static int may_o_create(const struct path *dir, struct dentry *dentry, umode_t m
 	    !kgid_has_mapping(s_user_ns, current_fsgid()))
 		return -EOVERFLOW;
 
-	error = inode_permission(dir->dentry->d_inode, MAY_WRITE | MAY_EXEC);
+	error = inode_permission(&init_user_ns, dir->dentry->d_inode,
+				 MAY_WRITE | MAY_EXEC);
 	if (error)
 		return error;
 
@@ -3274,7 +3282,7 @@ struct dentry *vfs_tmpfile(struct dentry *dentry, umode_t mode, int open_flag)
 	int error;
 
 	/* we want directory to be writable */
-	error = inode_permission(dir, MAY_WRITE | MAY_EXEC);
+	error = inode_permission(&init_user_ns, dir, MAY_WRITE | MAY_EXEC);
 	if (error)
 		goto out_err;
 	error = -EOPNOTSUPP;
@@ -4265,12 +4273,12 @@ int vfs_rename(struct inode *old_dir, struct dentry *old_dentry,
 	 */
 	if (new_dir != old_dir) {
 		if (is_dir) {
-			error = inode_permission(source, MAY_WRITE);
+			error = inode_permission(&init_user_ns, source, MAY_WRITE);
 			if (error)
 				return error;
 		}
 		if ((flags & RENAME_EXCHANGE) && new_is_dir) {
-			error = inode_permission(target, MAY_WRITE);
+			error = inode_permission(&init_user_ns, target, MAY_WRITE);
 			if (error)
 				return error;
 		}
diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index cb52db9a0cfb..c890144c496a 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -2793,7 +2793,7 @@ int nfs_permission(struct inode *inode, int mask)
 
 	res = nfs_revalidate_inode(NFS_SERVER(inode), inode);
 	if (res == 0)
-		res = generic_permission(inode, mask);
+		res = generic_permission(&init_user_ns, inode, mask);
 	goto out;
 }
 EXPORT_SYMBOL_GPL(nfs_permission);
diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index c81dbbad8792..380f0f74740c 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -40,7 +40,7 @@ static int nfsd_acceptable(void *expv, struct dentry *dentry)
 		/* make sure parents give x permission to user */
 		int err;
 		parent = dget_parent(tdentry);
-		err = inode_permission(d_inode(parent), MAY_EXEC);
+		err = inode_permission(&init_user_ns, d_inode(parent), MAY_EXEC);
 		if (err < 0) {
 			dput(parent);
 			break;
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 1ecaceebee13..3cad79c3b441 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -2380,13 +2380,13 @@ nfsd_permission(struct svc_rqst *rqstp, struct svc_export *exp,
 		return 0;
 
 	/* This assumes  NFSD_MAY_{READ,WRITE,EXEC} == MAY_{READ,WRITE,EXEC} */
-	err = inode_permission(inode, acc & (MAY_READ|MAY_WRITE|MAY_EXEC));
+	err = inode_permission(&init_user_ns, inode, acc & (MAY_READ|MAY_WRITE|MAY_EXEC));
 
 	/* Allow read access to binaries even when mode 111 */
 	if (err == -EACCES && S_ISREG(inode->i_mode) &&
 	     (acc == (NFSD_MAY_READ | NFSD_MAY_OWNER_OVERRIDE) ||
 	      acc == (NFSD_MAY_READ | NFSD_MAY_READ_IF_EXEC)))
-		err = inode_permission(inode, MAY_EXEC);
+		err = inode_permission(&init_user_ns, inode, MAY_EXEC);
 
 	return err? nfserrno(err) : 0;
 }
diff --git a/fs/nilfs2/inode.c b/fs/nilfs2/inode.c
index 745d371d6fea..b6517220cad5 100644
--- a/fs/nilfs2/inode.c
+++ b/fs/nilfs2/inode.c
@@ -851,7 +851,7 @@ int nilfs_permission(struct inode *inode, int mask)
 	    root->cno != NILFS_CPTREE_CURRENT_CNO)
 		return -EROFS; /* snapshot is not writable */
 
-	return generic_permission(inode, mask);
+	return generic_permission(&init_user_ns, inode, mask);
 }
 
 int nilfs_load_inode_block(struct inode *inode, struct buffer_head **pbh)
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 3e01d8f2ab90..de4d01bb1d8d 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -702,7 +702,7 @@ static int fanotify_find_path(int dfd, const char __user *filename,
 	}
 
 	/* you can only watch an inode if you have read permissions on it */
-	ret = inode_permission(path->dentry->d_inode, MAY_READ);
+	ret = inode_permission(&init_user_ns, path->dentry->d_inode, MAY_READ);
 	if (ret) {
 		path_put(path);
 		goto out;
diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
index 186722ba3894..e995fd4e4e53 100644
--- a/fs/notify/inotify/inotify_user.c
+++ b/fs/notify/inotify/inotify_user.c
@@ -343,7 +343,7 @@ static int inotify_find_inode(const char __user *dirname, struct path *path,
 	if (error)
 		return error;
 	/* you can only watch an inode if you have read permissions on it */
-	error = inode_permission(path->dentry->d_inode, MAY_READ);
+	error = inode_permission(&init_user_ns, path->dentry->d_inode, MAY_READ);
 	if (error) {
 		path_put(path);
 		return error;
diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
index 85979e2214b3..0c75619adf54 100644
--- a/fs/ocfs2/file.c
+++ b/fs/ocfs2/file.c
@@ -1355,7 +1355,7 @@ int ocfs2_permission(struct inode *inode, int mask)
 		dump_stack();
 	}
 
-	ret = generic_permission(inode, mask);
+	ret = generic_permission(&init_user_ns, inode, mask);
 
 	ocfs2_inode_unlock_tracker(inode, 0, &oh, had_lock);
 out:
diff --git a/fs/ocfs2/refcounttree.c b/fs/ocfs2/refcounttree.c
index 3b397fa9c9e8..c26937824be1 100644
--- a/fs/ocfs2/refcounttree.c
+++ b/fs/ocfs2/refcounttree.c
@@ -4346,7 +4346,7 @@ static inline int ocfs2_may_create(struct inode *dir, struct dentry *child)
 		return -EEXIST;
 	if (IS_DEADDIR(dir))
 		return -ENOENT;
-	return inode_permission(dir, MAY_WRITE | MAY_EXEC);
+	return inode_permission(&init_user_ns, dir, MAY_WRITE | MAY_EXEC);
 }
 
 /**
@@ -4400,7 +4400,7 @@ static int ocfs2_vfs_reflink(struct dentry *old_dentry, struct inode *dir,
 	 * file.
 	 */
 	if (!preserve) {
-		error = inode_permission(inode, MAY_READ);
+		error = inode_permission(&init_user_ns, inode, MAY_READ);
 		if (error)
 			return error;
 	}
diff --git a/fs/open.c b/fs/open.c
index 9af548fb841b..b0e8430e29f3 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -83,7 +83,7 @@ long vfs_truncate(const struct path *path, loff_t length)
 	if (error)
 		goto out;
 
-	error = inode_permission(inode, MAY_WRITE);
+	error = inode_permission(&init_user_ns, inode, MAY_WRITE);
 	if (error)
 		goto mnt_drop_write_and_out;
 
@@ -436,7 +436,7 @@ static long do_faccessat(int dfd, const char __user *filename, int mode, int fla
 			goto out_path_release;
 	}
 
-	res = inode_permission(inode, mode | MAY_ACCESS);
+	res = inode_permission(&init_user_ns, inode, mode | MAY_ACCESS);
 	/* SuS v2 requires we report a read only fs too */
 	if (res || !(mode & S_IWOTH) || special_file(inode->i_mode))
 		goto out_path_release;
@@ -492,7 +492,7 @@ SYSCALL_DEFINE1(chdir, const char __user *, filename)
 	if (error)
 		goto out;
 
-	error = inode_permission(path.dentry->d_inode, MAY_EXEC | MAY_CHDIR);
+	error = inode_permission(&init_user_ns, path.dentry->d_inode, MAY_EXEC | MAY_CHDIR);
 	if (error)
 		goto dput_and_out;
 
@@ -521,7 +521,7 @@ SYSCALL_DEFINE1(fchdir, unsigned int, fd)
 	if (!d_can_lookup(f.file->f_path.dentry))
 		goto out_putf;
 
-	error = inode_permission(file_inode(f.file), MAY_EXEC | MAY_CHDIR);
+	error = inode_permission(&init_user_ns, file_inode(f.file), MAY_EXEC | MAY_CHDIR);
 	if (!error)
 		set_fs_pwd(current->fs, &f.file->f_path);
 out_putf:
@@ -540,7 +540,7 @@ SYSCALL_DEFINE1(chroot, const char __user *, filename)
 	if (error)
 		goto out;
 
-	error = inode_permission(path.dentry->d_inode, MAY_EXEC | MAY_CHDIR);
+	error = inode_permission(&init_user_ns, path.dentry->d_inode, MAY_EXEC | MAY_CHDIR);
 	if (error)
 		goto dput_and_out;
 
diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index 48f0547d4850..4c790cc8042d 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -933,7 +933,7 @@ int orangefs_permission(struct inode *inode, int mask)
 	if (ret < 0)
 		return ret;
 
-	return generic_permission(inode, mask);
+	return generic_permission(&init_user_ns, inode, mask);
 }
 
 int orangefs_update_time(struct inode *inode, struct timespec64 *time, int flags)
diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index efccb7c1f9bc..f966b5108358 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -50,7 +50,7 @@ static struct file *ovl_open_realfile(const struct file *file,
 		acc_mode |= MAY_APPEND;
 
 	old_cred = ovl_override_creds(inode->i_sb);
-	err = inode_permission(realinode, MAY_OPEN | acc_mode);
+	err = inode_permission(&init_user_ns, realinode, MAY_OPEN | acc_mode);
 	if (err) {
 		realfile = ERR_PTR(err);
 	} else if (!inode_owner_or_capable(realinode)) {
diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index b584dca845ba..c8e3c17ca131 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -294,7 +294,7 @@ int ovl_permission(struct inode *inode, int mask)
 	 * Check overlay inode with the creds of task and underlying inode
 	 * with creds of mounter
 	 */
-	err = generic_permission(inode, mask);
+	err = generic_permission(&init_user_ns, inode, mask);
 	if (err)
 		return err;
 
@@ -305,7 +305,7 @@ int ovl_permission(struct inode *inode, int mask)
 		/* Make sure mounter can read file for copy up later */
 		mask |= MAY_READ;
 	}
-	err = inode_permission(realinode, mask);
+	err = inode_permission(&init_user_ns, realinode, mask);
 	revert_creds(old_cred);
 
 	return err;
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index 23f475627d07..ff67da201303 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -476,7 +476,7 @@ struct file *ovl_path_open(struct path *path, int flags)
 		BUG();
 	}
 
-	err = inode_permission(inode, acc_mode | MAY_OPEN);
+	err = inode_permission(&init_user_ns, inode, acc_mode | MAY_OPEN);
 	if (err)
 		return ERR_PTR(err);
 
diff --git a/fs/posix_acl.c b/fs/posix_acl.c
index 4ca6d53c6f0a..5b6296cc89c4 100644
--- a/fs/posix_acl.c
+++ b/fs/posix_acl.c
@@ -345,10 +345,13 @@ EXPORT_SYMBOL(posix_acl_from_mode);
  * by the acl. Returns -E... otherwise.
  */
 int
-posix_acl_permission(struct inode *inode, const struct posix_acl *acl, int want)
+posix_acl_permission(struct user_namespace *user_ns, struct inode *inode,
+		     const struct posix_acl *acl, int want)
 {
 	const struct posix_acl_entry *pa, *pe, *mask_obj;
 	int found = 0;
+	kuid_t uid;
+	kgid_t gid;
 
 	want &= MAY_READ | MAY_WRITE | MAY_EXEC;
 
@@ -356,22 +359,26 @@ posix_acl_permission(struct inode *inode, const struct posix_acl *acl, int want)
                 switch(pa->e_tag) {
                         case ACL_USER_OBJ:
 				/* (May have been checked already) */
-				if (uid_eq(inode->i_uid, current_fsuid()))
+				uid = i_uid_into_mnt(user_ns, inode);
+				if (uid_eq(uid, current_fsuid()))
                                         goto check_perm;
                                 break;
                         case ACL_USER:
-				if (uid_eq(pa->e_uid, current_fsuid()))
+				uid = kuid_into_mnt(user_ns, pa->e_uid);
+				if (uid_eq(uid, current_fsuid()))
                                         goto mask;
 				break;
                         case ACL_GROUP_OBJ:
-                                if (in_group_p(inode->i_gid)) {
+				gid = i_gid_into_mnt(user_ns, inode);
+				if (in_group_p(gid)) {
 					found = 1;
 					if ((pa->e_perm & want) == want)
 						goto mask;
                                 }
 				break;
                         case ACL_GROUP:
-				if (in_group_p(pa->e_gid)) {
+				gid = kgid_into_mnt(user_ns, pa->e_gid);
+				if (in_group_p(gid)) {
 					found = 1;
 					if ((pa->e_perm & want) == want)
 						goto mask;
diff --git a/fs/proc/base.c b/fs/proc/base.c
index 0f707003dda5..3d21c0150e05 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -751,7 +751,7 @@ static int proc_pid_permission(struct inode *inode, int mask)
 
 		return -EPERM;
 	}
-	return generic_permission(inode, mask);
+	return generic_permission(&init_user_ns, inode, mask);
 }
 
 
@@ -3487,7 +3487,7 @@ static int proc_tid_comm_permission(struct inode *inode, int mask)
 		return 0;
 	}
 
-	return generic_permission(inode, mask);
+	return generic_permission(&init_user_ns, inode, mask);
 }
 
 static const struct inode_operations proc_tid_comm_inode_operations = {
diff --git a/fs/proc/fd.c b/fs/proc/fd.c
index 81882a13212d..ad692a39381d 100644
--- a/fs/proc/fd.c
+++ b/fs/proc/fd.c
@@ -299,7 +299,7 @@ int proc_fd_permission(struct inode *inode, int mask)
 	struct task_struct *p;
 	int rv;
 
-	rv = generic_permission(inode, mask);
+	rv = generic_permission(&init_user_ns, inode, mask);
 	if (rv == 0)
 		return rv;
 
diff --git a/fs/reiserfs/xattr.c b/fs/reiserfs/xattr.c
index fe63a7c3e0da..ec440d1957a1 100644
--- a/fs/reiserfs/xattr.c
+++ b/fs/reiserfs/xattr.c
@@ -957,7 +957,7 @@ int reiserfs_permission(struct inode *inode, int mask)
 	if (IS_PRIVATE(inode))
 		return 0;
 
-	return generic_permission(inode, mask);
+	return generic_permission(&init_user_ns, inode, mask);
 }
 
 static int xattr_hide_revalidate(struct dentry *dentry, unsigned int flags)
diff --git a/fs/remap_range.c b/fs/remap_range.c
index e6099beefa97..9e5b27641756 100644
--- a/fs/remap_range.c
+++ b/fs/remap_range.c
@@ -438,7 +438,7 @@ static bool allow_file_dedupe(struct file *file)
 		return true;
 	if (uid_eq(current_fsuid(), file_inode(file)->i_uid))
 		return true;
-	if (!inode_permission(file_inode(file), MAY_WRITE))
+	if (!inode_permission(&init_user_ns, file_inode(file), MAY_WRITE))
 		return true;
 	return false;
 }
diff --git a/fs/udf/file.c b/fs/udf/file.c
index ad8eefad27d7..928283925d68 100644
--- a/fs/udf/file.c
+++ b/fs/udf/file.c
@@ -183,7 +183,7 @@ long udf_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	long old_block, new_block;
 	int result;
 
-	if (inode_permission(inode, MAY_READ) != 0) {
+	if (inode_permission(&init_user_ns, inode, MAY_READ) != 0) {
 		udf_debug("no permission to access inode %lu\n", inode->i_ino);
 		return -EPERM;
 	}
diff --git a/fs/verity/enable.c b/fs/verity/enable.c
index 5ab3bbec8108..7449ef0050f4 100644
--- a/fs/verity/enable.c
+++ b/fs/verity/enable.c
@@ -369,7 +369,7 @@ int fsverity_ioctl_enable(struct file *filp, const void __user *uarg)
 	 * has verity enabled, and to stabilize the data being hashed.
 	 */
 
-	err = inode_permission(inode, MAY_WRITE);
+	err = inode_permission(&init_user_ns, inode, MAY_WRITE);
 	if (err)
 		return err;
 
diff --git a/fs/xattr.c b/fs/xattr.c
index cd7a563e8bcd..61a9947f62f4 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -131,7 +131,7 @@ xattr_permission(struct inode *inode, const char *name, int mask)
 			return -EPERM;
 	}
 
-	return inode_permission(inode, mask);
+	return inode_permission(&init_user_ns, inode, mask);
 }
 
 /*
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 9e05fb4f997c..8f6fb065450b 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2787,8 +2787,8 @@ static inline int bmap(struct inode *inode,  sector_t *block)
 #endif
 
 extern int notify_change(struct dentry *, struct iattr *, struct inode **);
-extern int inode_permission(struct inode *, int);
-extern int generic_permission(struct inode *, int);
+extern int inode_permission(struct user_namespace *, struct inode *, int);
+extern int generic_permission(struct user_namespace *, struct inode *, int);
 extern int __check_sticky(struct inode *dir, struct inode *inode);
 
 static inline bool execute_ok(struct inode *inode)
diff --git a/include/linux/posix_acl.h b/include/linux/posix_acl.h
index 90797f1b421d..8276baefed13 100644
--- a/include/linux/posix_acl.h
+++ b/include/linux/posix_acl.h
@@ -15,6 +15,8 @@
 #include <linux/refcount.h>
 #include <uapi/linux/posix_acl.h>
 
+struct user_namespace;
+
 struct posix_acl_entry {
 	short			e_tag;
 	unsigned short		e_perm;
@@ -62,7 +64,7 @@ posix_acl_release(struct posix_acl *acl)
 extern void posix_acl_init(struct posix_acl *, int);
 extern struct posix_acl *posix_acl_alloc(int, gfp_t);
 extern int posix_acl_valid(struct user_namespace *, const struct posix_acl *);
-extern int posix_acl_permission(struct inode *, const struct posix_acl *, int);
+extern int posix_acl_permission(struct user_namespace *, struct inode *, const struct posix_acl *, int);
 extern struct posix_acl *posix_acl_from_mode(umode_t, gfp_t);
 extern int posix_acl_equiv_mode(const struct posix_acl *, umode_t *);
 extern int __posix_acl_create(struct posix_acl **, gfp_t, umode_t *);
diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index beff0cfcd1e8..693f01fe1216 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -873,7 +873,7 @@ static int prepare_open(struct dentry *dentry, int oflag, int ro,
 	if ((oflag & O_ACCMODE) == (O_RDWR | O_WRONLY))
 		return -EINVAL;
 	acc = oflag2acc[oflag & O_ACCMODE];
-	return inode_permission(d_inode(dentry), acc);
+	return inode_permission(&init_user_ns, d_inode(dentry), acc);
 }
 
 static int do_mq_open(const char __user *u_name, int oflag, umode_t mode,
diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
index dd4b7fd60ee7..f1c393e5d47d 100644
--- a/kernel/bpf/inode.c
+++ b/kernel/bpf/inode.c
@@ -507,7 +507,7 @@ static void *bpf_obj_do_get(const char __user *pathname,
 		return ERR_PTR(ret);
 
 	inode = d_backing_inode(path.dentry);
-	ret = inode_permission(inode, ACC_MODE(flags));
+	ret = inode_permission(&init_user_ns, inode, ACC_MODE(flags));
 	if (ret)
 		goto out;
 
@@ -558,7 +558,7 @@ int bpf_obj_get_user(const char __user *pathname, int flags)
 static struct bpf_prog *__get_prog_inode(struct inode *inode, enum bpf_prog_type type)
 {
 	struct bpf_prog *prog;
-	int ret = inode_permission(inode, MAY_READ);
+	int ret = inode_permission(&init_user_ns, inode, MAY_READ);
 	if (ret)
 		return ERR_PTR(ret);
 
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index e41c21819ba0..b13aab5a9715 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -4673,7 +4673,7 @@ static int cgroup_may_write(const struct cgroup *cgrp, struct super_block *sb)
 	if (!inode)
 		return -ENOMEM;
 
-	ret = inode_permission(inode, MAY_WRITE);
+	ret = inode_permission(&init_user_ns, inode, MAY_WRITE);
 	iput(inode);
 	return ret;
 }
diff --git a/kernel/sys.c b/kernel/sys.c
index a730c03ee607..469a659c8e84 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -1847,7 +1847,7 @@ static int prctl_set_mm_exe_file(struct mm_struct *mm, unsigned int fd)
 	if (!S_ISREG(inode->i_mode) || path_noexec(&exe.file->f_path))
 		goto exit;
 
-	err = inode_permission(inode, MAY_EXEC);
+	err = inode_permission(&init_user_ns, inode, MAY_EXEC);
 	if (err)
 		goto exit;
 
diff --git a/mm/madvise.c b/mm/madvise.c
index 416a56b8e757..8afabc363b6b 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -540,7 +540,7 @@ static inline bool can_do_pageout(struct vm_area_struct *vma)
 	 * opens a side channel.
 	 */
 	return inode_owner_or_capable(file_inode(vma->vm_file)) ||
-		inode_permission(file_inode(vma->vm_file), MAY_WRITE) == 0;
+		inode_permission(&init_user_ns, file_inode(vma->vm_file), MAY_WRITE) == 0;
 }
 
 static long madvise_pageout(struct vm_area_struct *vma,
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 3a24e3b619f5..d876e82055d8 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4900,7 +4900,7 @@ static ssize_t memcg_write_event_control(struct kernfs_open_file *of,
 
 	/* the process need read permission on control file */
 	/* AV: shouldn't we check that it's been opened for read instead? */
-	ret = inode_permission(file_inode(cfile.file), MAY_READ);
+	ret = inode_permission(&init_user_ns, file_inode(cfile.file), MAY_READ);
 	if (ret < 0)
 		goto out_put_cfile;
 
diff --git a/mm/mincore.c b/mm/mincore.c
index 02db1a834021..d5a58e61eac6 100644
--- a/mm/mincore.c
+++ b/mm/mincore.c
@@ -167,7 +167,7 @@ static inline bool can_do_mincore(struct vm_area_struct *vma)
 	 * mappings, which opens a side channel.
 	 */
 	return inode_owner_or_capable(file_inode(vma->vm_file)) ||
-		inode_permission(file_inode(vma->vm_file), MAY_WRITE) == 0;
+		inode_permission(&init_user_ns, file_inode(vma->vm_file), MAY_WRITE) == 0;
 }
 
 static const struct mm_walk_ops mincore_walk_ops = {
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 41c3303c3357..f568526d4a02 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -936,7 +936,7 @@ static struct sock *unix_find_other(struct net *net,
 		if (err)
 			goto fail;
 		inode = d_backing_inode(path.dentry);
-		err = inode_permission(inode, MAY_WRITE);
+		err = inode_permission(&init_user_ns, inode, MAY_WRITE);
 		if (err)
 			goto put_fail;
 
-- 
2.29.2

