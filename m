Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 774222FF282
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Jan 2021 18:54:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733301AbhAUPn7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Jan 2021 10:43:59 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:53826 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731713AbhAUNVa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Jan 2021 08:21:30 -0500
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1l2ZtA-0005g7-9J; Thu, 21 Jan 2021 13:20:40 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org
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
        Seth Forshee <seth.forshee@canonical.com>,
        =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@ubuntu.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Lennart Poettering <lennart@poettering.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>, smbarber@chromium.org,
        Phil Estes <estesp@gmail.com>, Serge Hallyn <serge@hallyn.com>,
        Kees Cook <keescook@chromium.org>,
        Todd Kjos <tkjos@google.com>, Paul Moore <paul@paul-moore.com>,
        Jonathan Corbet <corbet@lwn.net>,
        containers@lists.linux-foundation.org,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v6 05/39] namei: make permission helpers idmapped mount aware
Date:   Thu, 21 Jan 2021 14:19:24 +0100
Message-Id: <20210121131959.646623-6-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210121131959.646623-1-christian.brauner@ubuntu.com>
References: <20210121131959.646623-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; i=JgugUmcvVzbtzeqJr5O15Nzp+W5QX9ZcyABXeiG+Shk=; m=o77OoMU+EZmWfEdmfA9oQUJBcFwoNwu1/tdanBByf/s=; p=XxPaHwsZQcBhQd6ox5k0EJg1iyXp0XTnU8vye0yX2kA=; g=ae8eaaaf678acbbe0217ae09f07d7567d892dc8d
X-Patch-Sig: m=pgp; i=christian.brauner@ubuntu.com; s=0x0x91C61BC06578DCA2; b=iHUEABYKAB0WIQRAhzRXHqcMeLMyaSiRxhvAZXjcogUCYAl9owAKCRCRxhvAZXjcogNlAPsGE2P a/wA7ob8vWUfUkuP/+rNZWx2LwVNm1VBIg2A4XQD8CCrq0DmgzcBQuFCs+cE7xK2H35gexREWUFkU 9kMGAwQ=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The two helpers inode_permission() and generic_permission() are used by
the vfs to perform basic permission checking by verifying that the
caller is privileged over an inode. In order to handle idmapped mounts
we extend the two helpers with an additional user namespace argument.
On idmapped mounts the two helpers will make sure to map the inode
according to the mount's user namespace and then peform identical
permission checks to inode_permission() and generic_permission(). If the
initial user namespace is passed nothing changes so non-idmapped mounts
will see identical behavior as before.

Link: https://lore.kernel.org/r/20210112220124.837960-12-christian.brauner@ubuntu.com
Cc: Christoph Hellwig <hch@lst.de>
Cc: David Howells <dhowells@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Reviewed-by: Christoph Hellwig <hch@lst.de>
Acked-by: Serge Hallyn <serge@hallyn.com>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
- Christoph Hellwig <hch@lst.de>:
  - Don't pollute the vfs with additional helpers simply extend the existing
    helpers with an additional argument and switch all callers.

/* v3 */
unchanged

/* v4 */
- "Serge E. Hallyn" <serge@hallyn.com>:
  - Add proper documentation for all the changed permission checking helpers and
    adjust terminology to avoid any potential confusion.
  - Use "mnt_userns" to refer to a vfsmount's userns everywhere to make
    terminology consistent.

- Christoph Hellwig <hch@lst.de>:
  - Change commit message to reflect the fact that no new permission helpers are
    introduced but only the existing ones changed.

/* v5 */
unchanged
base-commit: 7c53f6b671f4aba70ff15e1b05148b10d58c2837

/* v6 */
base-commit: 19c329f6808995b142b3966301f217c831e7cf31

- Christoph Hellwig <hch@lst.de>:
  - Drop "extern"s in headers.
  - Wrap lines > 80 chars.
---
 fs/attr.c                 |   3 +-
 fs/btrfs/inode.c          |   2 +-
 fs/btrfs/ioctl.c          |  12 ++--
 fs/ceph/inode.c           |   2 +-
 fs/cifs/cifsfs.c          |   2 +-
 fs/configfs/symlink.c     |   3 +-
 fs/ecryptfs/inode.c       |   3 +-
 fs/exec.c                 |   2 +-
 fs/fuse/dir.c             |   5 +-
 fs/gfs2/inode.c           |   2 +-
 fs/hostfs/hostfs_kern.c   |   2 +-
 fs/kernfs/inode.c         |   2 +-
 fs/libfs.c                |   7 ++-
 fs/namei.c                | 121 +++++++++++++++++++++++++++-----------
 fs/nfs/dir.c              |   2 +-
 fs/nfsd/nfsfh.c           |   3 +-
 fs/nfsd/vfs.c             |   5 +-
 fs/nilfs2/inode.c         |   2 +-
 fs/ocfs2/file.c           |   2 +-
 fs/ocfs2/refcounttree.c   |   4 +-
 fs/open.c                 |   4 +-
 fs/orangefs/inode.c       |   2 +-
 fs/overlayfs/file.c       |   2 +-
 fs/overlayfs/inode.c      |   4 +-
 fs/overlayfs/util.c       |   2 +-
 fs/posix_acl.c            |  17 ++++--
 fs/proc/base.c            |   4 +-
 fs/proc/fd.c              |   2 +-
 fs/reiserfs/xattr.c       |   2 +-
 fs/remap_range.c          |   2 +-
 fs/xattr.c                |   2 +-
 include/linux/fs.h        |  10 ++--
 include/linux/posix_acl.h |   7 ++-
 ipc/mqueue.c              |   2 +-
 kernel/bpf/inode.c        |   2 +-
 kernel/cgroup/cgroup.c    |   2 +-
 36 files changed, 164 insertions(+), 88 deletions(-)

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
index a8e0a6b038d3..512ee2650bbb 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -9889,7 +9889,7 @@ static int btrfs_permission(struct inode *inode, int mask)
 		if (BTRFS_I(inode)->flags & BTRFS_INODE_READONLY)
 			return -EACCES;
 	}
-	return generic_permission(inode, mask);
+	return generic_permission(&init_user_ns, inode, mask);
 }
 
 static int btrfs_tmpfile(struct inode *dir, struct dentry *dentry, umode_t mode)
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index dde49a791f3e..8ced6dfefee4 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -922,7 +922,7 @@ static int btrfs_may_delete(struct inode *dir, struct dentry *victim, int isdir)
 	BUG_ON(d_inode(victim->d_parent) != dir);
 	audit_inode_child(dir, victim, AUDIT_TYPE_CHILD_DELETE);
 
-	error = inode_permission(dir, MAY_WRITE | MAY_EXEC);
+	error = inode_permission(&init_user_ns, dir, MAY_WRITE | MAY_EXEC);
 	if (error)
 		return error;
 	if (IS_APPEND(dir))
@@ -951,7 +951,7 @@ static inline int btrfs_may_create(struct inode *dir, struct dentry *child)
 		return -EEXIST;
 	if (IS_DEADDIR(dir))
 		return -ENOENT;
-	return inode_permission(dir, MAY_WRITE | MAY_EXEC);
+	return inode_permission(&init_user_ns, dir, MAY_WRITE | MAY_EXEC);
 }
 
 /*
@@ -2538,7 +2538,8 @@ static int btrfs_search_path_in_tree_user(struct inode *inode,
 				ret = PTR_ERR(temp_inode);
 				goto out_put;
 			}
-			ret = inode_permission(temp_inode, MAY_READ | MAY_EXEC);
+			ret = inode_permission(&init_user_ns, temp_inode,
+					       MAY_READ | MAY_EXEC);
 			iput(temp_inode);
 			if (ret) {
 				ret = -EACCES;
@@ -3068,7 +3069,8 @@ static noinline int btrfs_ioctl_snap_destroy(struct file *file,
 		if (root == dest)
 			goto out_dput;
 
-		err = inode_permission(inode, MAY_WRITE | MAY_EXEC);
+		err = inode_permission(&init_user_ns, inode,
+				       MAY_WRITE | MAY_EXEC);
 		if (err)
 			goto out_dput;
 	}
@@ -3139,7 +3141,7 @@ static int btrfs_ioctl_defrag(struct file *file, void __user *argp)
 		 * running and allows defrag on files open in read-only mode.
 		 */
 		if (!capable(CAP_SYS_ADMIN) &&
-		    inode_permission(inode, MAY_WRITE)) {
+		    inode_permission(&init_user_ns, inode, MAY_WRITE)) {
 			ret = -EPERM;
 			goto out;
 		}
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index adc8fc3c5d85..e8a15ee09bc1 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -2331,7 +2331,7 @@ int ceph_permission(struct inode *inode, int mask)
 	err = ceph_do_getattr(inode, CEPH_CAP_AUTH_SHARED, false);
 
 	if (!err)
-		err = generic_permission(inode, mask);
+		err = generic_permission(&init_user_ns, inode, mask);
 	return err;
 }
 
diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
index ce0d0037fd0a..ce14e6f8adb6 100644
--- a/fs/cifs/cifsfs.c
+++ b/fs/cifs/cifsfs.c
@@ -320,7 +320,7 @@ static int cifs_permission(struct inode *inode, int mask)
 		on the client (above and beyond ACL on servers) for
 		servers which do not support setting and viewing mode bits,
 		so allowing client to check permissions is useful */
-		return generic_permission(inode, mask);
+		return generic_permission(&init_user_ns, inode, mask);
 }
 
 static struct kmem_cache *cifs_inode_cachep;
diff --git a/fs/configfs/symlink.c b/fs/configfs/symlink.c
index cb61467478ca..8ca36394fa30 100644
--- a/fs/configfs/symlink.c
+++ b/fs/configfs/symlink.c
@@ -197,7 +197,8 @@ int configfs_symlink(struct inode *dir, struct dentry *dentry, const char *symna
 	if (dentry->d_inode || d_unhashed(dentry))
 		ret = -EEXIST;
 	else
-		ret = inode_permission(dir, MAY_WRITE | MAY_EXEC);
+		ret = inode_permission(&init_user_ns, dir,
+				       MAY_WRITE | MAY_EXEC);
 	if (!ret)
 		ret = type->ct_item_ops->allow_link(parent_item, target_item);
 	if (!ret) {
diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index e23752d9a79f..0b346baf110d 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -864,7 +864,8 @@ int ecryptfs_truncate(struct dentry *dentry, loff_t new_length)
 static int
 ecryptfs_permission(struct inode *inode, int mask)
 {
-	return inode_permission(ecryptfs_inode_to_lower(inode), mask);
+	return inode_permission(&init_user_ns,
+				ecryptfs_inode_to_lower(inode), mask);
 }
 
 /**
diff --git a/fs/exec.c b/fs/exec.c
index 89d4780ff48f..a8ec371cd3cd 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1404,7 +1404,7 @@ EXPORT_SYMBOL(begin_new_exec);
 void would_dump(struct linux_binprm *bprm, struct file *file)
 {
 	struct inode *inode = file_inode(file);
-	if (inode_permission(inode, MAY_READ) < 0) {
+	if (inode_permission(&init_user_ns, inode, MAY_READ) < 0) {
 		struct user_namespace *old, *user_ns;
 		bprm->interp_flags |= BINPRM_FLAGS_ENFORCE_NONDUMP;
 
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 78f9f209078c..7497009a5a45 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1280,7 +1280,7 @@ static int fuse_permission(struct inode *inode, int mask)
 	}
 
 	if (fc->default_permissions) {
-		err = generic_permission(inode, mask);
+		err = generic_permission(&init_user_ns, inode, mask);
 
 		/* If permission is denied, try to refresh file
 		   attributes.  This is also needed, because the root
@@ -1288,7 +1288,8 @@ static int fuse_permission(struct inode *inode, int mask)
 		if (err == -EACCES && !refreshed) {
 			err = fuse_perm_getattr(inode, mask);
 			if (!err)
-				err = generic_permission(inode, mask);
+				err = generic_permission(&init_user_ns,
+							 inode, mask);
 		}
 
 		/* Note: the opposite of the above test does not
diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index c1b77e8d6b1c..5b2ff0c74b67 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -1852,7 +1852,7 @@ int gfs2_permission(struct inode *inode, int mask)
 	if ((mask & MAY_WRITE) && IS_IMMUTABLE(inode))
 		error = -EPERM;
 	else
-		error = generic_permission(inode, mask);
+		error = generic_permission(&init_user_ns, inode, mask);
 	if (gfs2_holder_initialized(&i_gh))
 		gfs2_glock_dq_uninit(&i_gh);
 
diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index aea35459d390..b841a05a2b8c 100644
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
index d1c3bade9f30..f8b3c02b4f0f 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -1318,9 +1318,14 @@ static ssize_t empty_dir_listxattr(struct dentry *dentry, char *list, size_t siz
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
index fd4724bce4f5..d78d74f5f5af 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -259,7 +259,24 @@ void putname(struct filename *name)
 		__putname(name);
 }
 
-static int check_acl(struct inode *inode, int mask)
+/**
+ * check_acl - perform ACL permission checking
+ * @mnt_userns:	user namespace of the mount the inode was found from
+ * @inode:	inode to check permissions on
+ * @mask:	right to check for (%MAY_READ, %MAY_WRITE, %MAY_EXEC ...)
+ *
+ * This function performs the ACL permission checking. Since this function
+ * retrieve POSIX acls it needs to know whether it is called from a blocking or
+ * non-blocking context and thus cares about the MAY_NOT_BLOCK bit.
+ *
+ * If the inode has been found through an idmapped mount the user namespace of
+ * the vfsmount must be passed through @mnt_userns. This function will then take
+ * care to map the inode according to @mnt_userns before checking permissions.
+ * On non-idmapped mounts or if permission checking is to be performed on the
+ * raw inode simply passs init_user_ns.
+ */
+static int check_acl(struct user_namespace *mnt_userns,
+		     struct inode *inode, int mask)
 {
 #ifdef CONFIG_FS_POSIX_ACL
 	struct posix_acl *acl;
@@ -271,14 +288,14 @@ static int check_acl(struct inode *inode, int mask)
 		/* no ->get_acl() calls in RCU mode... */
 		if (is_uncached_acl(acl))
 			return -ECHILD;
-	        return posix_acl_permission(inode, acl, mask);
+	        return posix_acl_permission(mnt_userns, inode, acl, mask);
 	}
 
 	acl = get_acl(inode, ACL_TYPE_ACCESS);
 	if (IS_ERR(acl))
 		return PTR_ERR(acl);
 	if (acl) {
-	        int error = posix_acl_permission(inode, acl, mask);
+	        int error = posix_acl_permission(mnt_userns, inode, acl, mask);
 	        posix_acl_release(acl);
 	        return error;
 	}
@@ -287,18 +304,31 @@ static int check_acl(struct inode *inode, int mask)
 	return -EAGAIN;
 }
 
-/*
- * This does the basic UNIX permission checking.
+/**
+ * acl_permission_check - perform basic UNIX permission checking
+ * @mnt_userns:	user namespace of the mount the inode was found from
+ * @inode:	inode to check permissions on
+ * @mask:	right to check for (%MAY_READ, %MAY_WRITE, %MAY_EXEC ...)
+ *
+ * This function performs the basic UNIX permission checking. Since this
+ * function may retrieve POSIX acls it needs to know whether it is called from a
+ * blocking or non-blocking context and thus cares about the MAY_NOT_BLOCK bit.
  *
- * Note that the POSIX ACL check cares about the MAY_NOT_BLOCK bit,
- * for RCU walking.
+ * If the inode has been found through an idmapped mount the user namespace of
+ * the vfsmount must be passed through @mnt_userns. This function will then take
+ * care to map the inode according to @mnt_userns before checking permissions.
+ * On non-idmapped mounts or if permission checking is to be performed on the
+ * raw inode simply passs init_user_ns.
  */
-static int acl_permission_check(struct inode *inode, int mask)
+static int acl_permission_check(struct user_namespace *mnt_userns,
+				struct inode *inode, int mask)
 {
 	unsigned int mode = inode->i_mode;
+	kuid_t i_uid;
 
 	/* Are we the owner? If so, ACL's don't matter */
-	if (likely(uid_eq(current_fsuid(), inode->i_uid))) {
+	i_uid = i_uid_into_mnt(mnt_userns, inode);
+	if (likely(uid_eq(current_fsuid(), i_uid))) {
 		mask &= 7;
 		mode >>= 6;
 		return (mask & ~mode) ? -EACCES : 0;
@@ -306,7 +336,7 @@ static int acl_permission_check(struct inode *inode, int mask)
 
 	/* Do we have ACL's? */
 	if (IS_POSIXACL(inode) && (mode & S_IRWXG)) {
-		int error = check_acl(inode, mask);
+		int error = check_acl(mnt_userns, inode, mask);
 		if (error != -EAGAIN)
 			return error;
 	}
@@ -320,7 +350,8 @@ static int acl_permission_check(struct inode *inode, int mask)
 	 * about? Need to check group ownership if so.
 	 */
 	if (mask & (mode ^ (mode >> 3))) {
-		if (in_group_p(inode->i_gid))
+		kgid_t kgid = i_gid_into_mnt(mnt_userns, inode);
+		if (in_group_p(kgid))
 			mode >>= 3;
 	}
 
@@ -330,6 +361,7 @@ static int acl_permission_check(struct inode *inode, int mask)
 
 /**
  * generic_permission -  check for access rights on a Posix-like filesystem
+ * @mnt_userns:	user namespace of the mount the inode was found from
  * @inode:	inode to check access rights for
  * @mask:	right to check for (%MAY_READ, %MAY_WRITE, %MAY_EXEC,
  *		%MAY_NOT_BLOCK ...)
@@ -342,25 +374,32 @@ static int acl_permission_check(struct inode *inode, int mask)
  * generic_permission is rcu-walk aware. It returns -ECHILD in case an rcu-walk
  * request cannot be satisfied (eg. requires blocking or too much complexity).
  * It would then be called again in ref-walk mode.
+ *
+ * If the inode has been found through an idmapped mount the user namespace of
+ * the vfsmount must be passed through @mnt_userns. This function will then take
+ * care to map the inode according to @mnt_userns before checking permissions.
+ * On non-idmapped mounts or if permission checking is to be performed on the
+ * raw inode simply passs init_user_ns.
  */
-int generic_permission(struct inode *inode, int mask)
+int generic_permission(struct user_namespace *mnt_userns, struct inode *inode,
+		       int mask)
 {
 	int ret;
 
 	/*
 	 * Do the basic permission checks.
 	 */
-	ret = acl_permission_check(inode, mask);
+	ret = acl_permission_check(mnt_userns, inode, mask);
 	if (ret != -EACCES)
 		return ret;
 
 	if (S_ISDIR(inode->i_mode)) {
 		/* DACs are overridable for directories */
 		if (!(mask & MAY_WRITE))
-			if (capable_wrt_inode_uidgid(&init_user_ns, inode,
+			if (capable_wrt_inode_uidgid(mnt_userns, inode,
 						     CAP_DAC_READ_SEARCH))
 				return 0;
-		if (capable_wrt_inode_uidgid(&init_user_ns, inode,
+		if (capable_wrt_inode_uidgid(mnt_userns, inode,
 					     CAP_DAC_OVERRIDE))
 			return 0;
 		return -EACCES;
@@ -371,7 +410,7 @@ int generic_permission(struct inode *inode, int mask)
 	 */
 	mask &= MAY_READ | MAY_WRITE | MAY_EXEC;
 	if (mask == MAY_READ)
-		if (capable_wrt_inode_uidgid(&init_user_ns, inode,
+		if (capable_wrt_inode_uidgid(mnt_userns, inode,
 					     CAP_DAC_READ_SEARCH))
 			return 0;
 	/*
@@ -380,7 +419,7 @@ int generic_permission(struct inode *inode, int mask)
 	 * at least one exec bit set.
 	 */
 	if (!(mask & MAY_EXEC) || (inode->i_mode & S_IXUGO))
-		if (capable_wrt_inode_uidgid(&init_user_ns, inode,
+		if (capable_wrt_inode_uidgid(mnt_userns, inode,
 					     CAP_DAC_OVERRIDE))
 			return 0;
 
@@ -388,13 +427,19 @@ int generic_permission(struct inode *inode, int mask)
 }
 EXPORT_SYMBOL(generic_permission);
 
-/*
+/**
+ * do_inode_permission - UNIX permission checking
+ * @mnt_userns:	user namespace of the mount the inode was found from
+ * @inode:	inode to check permissions on
+ * @mask:	right to check for (%MAY_READ, %MAY_WRITE, %MAY_EXEC ...)
+ *
  * We _really_ want to just do "generic_permission()" without
  * even looking at the inode->i_op values. So we keep a cache
  * flag in inode->i_opflags, that says "this has not special
  * permission function, use the fast case".
  */
-static inline int do_inode_permission(struct inode *inode, int mask)
+static inline int do_inode_permission(struct user_namespace *mnt_userns,
+				      struct inode *inode, int mask)
 {
 	if (unlikely(!(inode->i_opflags & IOP_FASTPERM))) {
 		if (likely(inode->i_op->permission))
@@ -405,7 +450,7 @@ static inline int do_inode_permission(struct inode *inode, int mask)
 		inode->i_opflags |= IOP_FASTPERM;
 		spin_unlock(&inode->i_lock);
 	}
-	return generic_permission(inode, mask);
+	return generic_permission(mnt_userns, inode, mask);
 }
 
 /**
@@ -430,8 +475,9 @@ static int sb_permission(struct super_block *sb, struct inode *inode, int mask)
 
 /**
  * inode_permission - Check for access rights to a given inode
- * @inode: Inode to check permission on
- * @mask: Right to check for (%MAY_READ, %MAY_WRITE, %MAY_EXEC)
+ * @mnt_userns:	User namespace of the mount the inode was found from
+ * @inode:	Inode to check permission on
+ * @mask:	Right to check for (%MAY_READ, %MAY_WRITE, %MAY_EXEC)
  *
  * Check for read/write/execute permissions on an inode.  We use fs[ug]id for
  * this, letting us set arbitrary permissions for filesystem access without
@@ -439,7 +485,8 @@ static int sb_permission(struct super_block *sb, struct inode *inode, int mask)
  *
  * When checking for MAY_APPEND, MAY_WRITE must also be set in @mask.
  */
-int inode_permission(struct inode *inode, int mask)
+int inode_permission(struct user_namespace *mnt_userns,
+		     struct inode *inode, int mask)
 {
 	int retval;
 
@@ -463,7 +510,7 @@ int inode_permission(struct inode *inode, int mask)
 			return -EACCES;
 	}
 
-	retval = do_inode_permission(inode, mask);
+	retval = do_inode_permission(mnt_userns, inode, mask);
 	if (retval)
 		return retval;
 
@@ -1009,7 +1056,7 @@ static bool safe_hardlink_source(struct inode *inode)
 		return false;
 
 	/* Hardlinking to unreadable or unwritable sources is dangerous. */
-	if (inode_permission(inode, MAY_READ | MAY_WRITE))
+	if (inode_permission(&init_user_ns, inode, MAY_READ | MAY_WRITE))
 		return false;
 
 	return true;
@@ -1569,13 +1616,14 @@ static struct dentry *lookup_slow(const struct qstr *name,
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
@@ -2509,7 +2557,7 @@ static int lookup_one_len_common(const char *name, struct dentry *base,
 			return err;
 	}
 
-	return inode_permission(base->d_inode, MAY_EXEC);
+	return inode_permission(&init_user_ns, base->d_inode, MAY_EXEC);
 }
 
 /**
@@ -2703,7 +2751,7 @@ static int may_delete(struct inode *dir, struct dentry *victim, bool isdir)
 
 	audit_inode_child(dir, victim, AUDIT_TYPE_CHILD_DELETE);
 
-	error = inode_permission(dir, MAY_WRITE | MAY_EXEC);
+	error = inode_permission(&init_user_ns, dir, MAY_WRITE | MAY_EXEC);
 	if (error)
 		return error;
 	if (IS_APPEND(dir))
@@ -2747,7 +2795,7 @@ static inline int may_create(struct inode *dir, struct dentry *child)
 	if (!kuid_has_mapping(s_user_ns, current_fsuid()) ||
 	    !kgid_has_mapping(s_user_ns, current_fsgid()))
 		return -EOVERFLOW;
-	return inode_permission(dir, MAY_WRITE | MAY_EXEC);
+	return inode_permission(&init_user_ns, dir, MAY_WRITE | MAY_EXEC);
 }
 
 /*
@@ -2877,7 +2925,7 @@ static int may_open(const struct path *path, int acc_mode, int flag)
 		break;
 	}
 
-	error = inode_permission(inode, MAY_OPEN | acc_mode);
+	error = inode_permission(&init_user_ns, inode, MAY_OPEN | acc_mode);
 	if (error)
 		return error;
 
@@ -2939,7 +2987,8 @@ static int may_o_create(const struct path *dir, struct dentry *dentry, umode_t m
 	    !kgid_has_mapping(s_user_ns, current_fsgid()))
 		return -EOVERFLOW;
 
-	error = inode_permission(dir->dentry->d_inode, MAY_WRITE | MAY_EXEC);
+	error = inode_permission(&init_user_ns, dir->dentry->d_inode,
+				 MAY_WRITE | MAY_EXEC);
 	if (error)
 		return error;
 
@@ -3276,7 +3325,7 @@ struct dentry *vfs_tmpfile(struct dentry *dentry, umode_t mode, int open_flag)
 	int error;
 
 	/* we want directory to be writable */
-	error = inode_permission(dir, MAY_WRITE | MAY_EXEC);
+	error = inode_permission(&init_user_ns, dir, MAY_WRITE | MAY_EXEC);
 	if (error)
 		goto out_err;
 	error = -EOPNOTSUPP;
@@ -4267,12 +4316,14 @@ int vfs_rename(struct inode *old_dir, struct dentry *old_dentry,
 	 */
 	if (new_dir != old_dir) {
 		if (is_dir) {
-			error = inode_permission(source, MAY_WRITE);
+			error = inode_permission(&init_user_ns, source,
+						 MAY_WRITE);
 			if (error)
 				return error;
 		}
 		if ((flags & RENAME_EXCHANGE) && new_is_dir) {
-			error = inode_permission(target, MAY_WRITE);
+			error = inode_permission(&init_user_ns, target,
+						 MAY_WRITE);
 			if (error)
 				return error;
 		}
diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index ef827ae193d2..727e01a84503 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -2987,7 +2987,7 @@ int nfs_permission(struct inode *inode, int mask)
 
 	res = nfs_revalidate_inode(NFS_SERVER(inode), inode);
 	if (res == 0)
-		res = generic_permission(inode, mask);
+		res = generic_permission(&init_user_ns, inode, mask);
 	goto out;
 }
 EXPORT_SYMBOL_GPL(nfs_permission);
diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index 66f2ef67792a..8d90796e236a 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -40,7 +40,8 @@ static int nfsd_acceptable(void *expv, struct dentry *dentry)
 		/* make sure parents give x permission to user */
 		int err;
 		parent = dget_parent(tdentry);
-		err = inode_permission(d_inode(parent), MAY_EXEC);
+		err = inode_permission(&init_user_ns,
+				       d_inode(parent), MAY_EXEC);
 		if (err < 0) {
 			dput(parent);
 			break;
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 04937e51de56..0edf11258aaa 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -2391,13 +2391,14 @@ nfsd_permission(struct svc_rqst *rqstp, struct svc_export *exp,
 		return 0;
 
 	/* This assumes  NFSD_MAY_{READ,WRITE,EXEC} == MAY_{READ,WRITE,EXEC} */
-	err = inode_permission(inode, acc & (MAY_READ|MAY_WRITE|MAY_EXEC));
+	err = inode_permission(&init_user_ns, inode,
+			       acc & (MAY_READ | MAY_WRITE | MAY_EXEC));
 
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
index cd1efd254cad..a6dac6d97988 100644
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
index bd9dd38347ae..b2948e7b3210 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -50,7 +50,7 @@ static struct file *ovl_open_realfile(const struct file *file,
 		acc_mode |= MAY_APPEND;
 
 	old_cred = ovl_override_creds(inode->i_sb);
-	err = inode_permission(realinode, MAY_OPEN | acc_mode);
+	err = inode_permission(&init_user_ns, realinode, MAY_OPEN | acc_mode);
 	if (err) {
 		realfile = ERR_PTR(err);
 	} else {
diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index d739e14c6814..c101ebbb7a77 100644
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
index 6569031af3cd..de5c2047a0e9 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -479,7 +479,7 @@ struct file *ovl_path_open(struct path *path, int flags)
 		BUG();
 	}
 
-	err = inode_permission(inode, acc_mode | MAY_OPEN);
+	err = inode_permission(&init_user_ns, inode, acc_mode | MAY_OPEN);
 	if (err)
 		return ERR_PTR(err);
 
diff --git a/fs/posix_acl.c b/fs/posix_acl.c
index 4ca6d53c6f0a..5d9fe2fb2953 100644
--- a/fs/posix_acl.c
+++ b/fs/posix_acl.c
@@ -345,10 +345,13 @@ EXPORT_SYMBOL(posix_acl_from_mode);
  * by the acl. Returns -E... otherwise.
  */
 int
-posix_acl_permission(struct inode *inode, const struct posix_acl *acl, int want)
+posix_acl_permission(struct user_namespace *mnt_userns, struct inode *inode,
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
+				uid = i_uid_into_mnt(mnt_userns, inode);
+				if (uid_eq(uid, current_fsuid()))
                                         goto check_perm;
                                 break;
                         case ACL_USER:
-				if (uid_eq(pa->e_uid, current_fsuid()))
+				uid = kuid_into_mnt(mnt_userns, pa->e_uid);
+				if (uid_eq(uid, current_fsuid()))
                                         goto mask;
 				break;
                         case ACL_GROUP_OBJ:
-                                if (in_group_p(inode->i_gid)) {
+				gid = i_gid_into_mnt(mnt_userns, inode);
+				if (in_group_p(gid)) {
 					found = 1;
 					if ((pa->e_perm & want) == want)
 						goto mask;
                                 }
 				break;
                         case ACL_GROUP:
-				if (in_group_p(pa->e_gid)) {
+				gid = kgid_into_mnt(mnt_userns, pa->e_gid);
+				if (in_group_p(gid)) {
 					found = 1;
 					if ((pa->e_perm & want) == want)
 						goto mask;
diff --git a/fs/proc/base.c b/fs/proc/base.c
index b3422cda2a91..b4ec9293625e 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -751,7 +751,7 @@ static int proc_pid_permission(struct inode *inode, int mask)
 
 		return -EPERM;
 	}
-	return generic_permission(inode, mask);
+	return generic_permission(&init_user_ns, inode, mask);
 }
 
 
@@ -3492,7 +3492,7 @@ static int proc_tid_comm_permission(struct inode *inode, int mask)
 		return 0;
 	}
 
-	return generic_permission(inode, mask);
+	return generic_permission(&init_user_ns, inode, mask);
 }
 
 static const struct inode_operations proc_tid_comm_inode_operations = {
diff --git a/fs/proc/fd.c b/fs/proc/fd.c
index cb51763ed554..d6e76461e135 100644
--- a/fs/proc/fd.c
+++ b/fs/proc/fd.c
@@ -281,7 +281,7 @@ int proc_fd_permission(struct inode *inode, int mask)
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
index 77dba3a49e65..29a4a4dbfe12 100644
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
diff --git a/fs/xattr.c b/fs/xattr.c
index fd57153b1f61..56151bd9e642 100644
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
index bcd17097d441..a85dfe6962df 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2810,15 +2810,17 @@ static inline int bmap(struct inode *inode,  sector_t *block)
 #endif
 
 extern int notify_change(struct dentry *, struct iattr *, struct inode **);
-extern int inode_permission(struct inode *, int);
-extern int generic_permission(struct inode *, int);
+int inode_permission(struct user_namespace *, struct inode *, int);
+int generic_permission(struct user_namespace *, struct inode *, int);
 static inline int file_permission(struct file *file, int mask)
 {
-	return inode_permission(file_inode(file), mask);
+	return inode_permission(file_mnt_user_ns(file),
+				file_inode(file), mask);
 }
 static inline int path_permission(const struct path *path, int mask)
 {
-	return inode_permission(d_inode(path->dentry), mask);
+	return inode_permission(mnt_user_ns(path->mnt),
+				d_inode(path->dentry), mask);
 }
 extern int __check_sticky(struct inode *dir, struct inode *inode);
 
diff --git a/include/linux/posix_acl.h b/include/linux/posix_acl.h
index 90797f1b421d..85fb4c0c650a 100644
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
@@ -61,8 +63,6 @@ posix_acl_release(struct posix_acl *acl)
 
 extern void posix_acl_init(struct posix_acl *, int);
 extern struct posix_acl *posix_acl_alloc(int, gfp_t);
-extern int posix_acl_valid(struct user_namespace *, const struct posix_acl *);
-extern int posix_acl_permission(struct inode *, const struct posix_acl *, int);
 extern struct posix_acl *posix_acl_from_mode(umode_t, gfp_t);
 extern int posix_acl_equiv_mode(const struct posix_acl *, umode_t *);
 extern int __posix_acl_create(struct posix_acl **, gfp_t, umode_t *);
@@ -85,6 +85,9 @@ struct posix_acl *get_cached_acl_rcu(struct inode *inode, int type);
 void set_cached_acl(struct inode *inode, int type, struct posix_acl *acl);
 void forget_cached_acl(struct inode *inode, int type);
 void forget_all_cached_acls(struct inode *inode);
+int posix_acl_valid(struct user_namespace *, const struct posix_acl *);
+int posix_acl_permission(struct user_namespace *, struct inode *,
+			 const struct posix_acl *, int);
 
 static inline void cache_no_acl(struct inode *inode)
 {
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
index 8962f139521e..e3226b65f5dc 100644
--- a/kernel/bpf/inode.c
+++ b/kernel/bpf/inode.c
@@ -558,7 +558,7 @@ int bpf_obj_get_user(const char __user *pathname, int flags)
 static struct bpf_prog *__get_prog_inode(struct inode *inode, enum bpf_prog_type type)
 {
 	struct bpf_prog *prog;
-	int ret = inode_permission(inode, MAY_READ);
+	int ret = inode_permission(&init_user_ns, inode, MAY_READ);
 	if (ret)
 		return ERR_PTR(ret);
 
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 613845769103..091ffb5d2939 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -4670,7 +4670,7 @@ static int cgroup_may_write(const struct cgroup *cgrp, struct super_block *sb)
 	if (!inode)
 		return -ENOMEM;
 
-	ret = inode_permission(inode, MAY_WRITE);
+	ret = inode_permission(&init_user_ns, inode, MAY_WRITE);
 	iput(inode);
 	return ret;
 }
-- 
2.30.0

