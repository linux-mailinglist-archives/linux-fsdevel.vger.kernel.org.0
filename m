Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92BC029DDD6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Oct 2020 01:42:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388891AbgJ2AmV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Oct 2020 20:42:21 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:33473 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388849AbgJ2Ako (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Oct 2020 20:40:44 -0400
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kXvvF-0008Ep-FV; Thu, 29 Oct 2020 00:36:09 +0000
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
        Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
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
        linux-ext4@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-audit@redhat.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 33/34] overlayfs: handle idmapped merged mounts
Date:   Thu, 29 Oct 2020 01:32:51 +0100
Message-Id: <20201029003252.2128653-34-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201029003252.2128653-1-christian.brauner@ubuntu.com>
References: <20201029003252.2128653-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now that overlayfs handles idmapped lower and upper mounts enable it to support
idmapped merged directories, i.e. support idmapping overlayfs mounts themselves.

In contrast to supporting lower and upper idmapped mounts this requires very
little changes. Permission checking will continue to work as before, i.e. we
will verify that we are privileged over the overlay inode itself and we are
privileged over the lower and upper inodes.

A very special thank you to my friend Seth Forshee who has given invaluable
advice around the permission checking!

 # This is a directory where all file ownership starts with uid and gid 10000.
 root@f2-vm:/# ls -al /var/lib/lxc/f1/rootfs
 total 108
 drwxr-xr-x  20 10000 10000  4096 Oct 28 11:13 .
 drwxrwx---   4 10000 10000  4096 Oct 28 11:17 ..
 -rw-r--r--   1 10000 10000  7197 Oct 24 09:45 asdf
 drwxr-xr-x   2 10000 10000  4096 Oct 16 19:07 ASDF
 lrwxrwxrwx   1 10000 10000     7 Sep 24 07:43 bin -> usr/bin
 drwxr-xr-x   2 10000 10000  4096 Apr 15  2020 boot
 -rw-r--r--   1 10000 10000 13059 Oct  8 12:38 ccc
 drwxr-xr-x   2 11000 11000  4096 Oct 23 17:10 ddd
 drwxr-xr-x   3 10000 10000  4096 Sep 25 08:04 dev
 drwxr-xr-x  61 10000 10000  4096 Sep 25 08:04 etc

 # Create an idmapped mount on the host such that all files owned by uid and
 # gid 10000 show up as being owned by uid 0 and gid 0.
 /mount2 --idmap both:10000:0:10000 /var/lib/lxc/f1/rootfs/ /lower1/

 # Verify that the files show up as uid and gid 0 under the idmapped mount at /lower1
 root@f2-vm:/# ls -al /lower1/
 total 108
 drwxr-xr-x  20 root   root    4096 Oct 28 11:13 .
 drwxr-xr-x  29 root   root    4096 Oct 28 11:57 ..
 -rw-r--r--   1 root   root    7197 Oct 24 09:45 asdf
 drwxr-xr-x   2 root   root    4096 Oct 16 19:07 ASDF
 lrwxrwxrwx   1 root   root       7 Sep 24 07:43 bin -> usr/bin
 drwxr-xr-x   2 root   root    4096 Apr 15  2020 boot
 -rw-r--r--   1 root   root   13059 Oct  8 12:38 ccc
 drwxr-xr-x   2 ubuntu ubuntu  4096 Oct 23 17:10 ddd
 drwxr-xr-x   3 root   root    4096 Sep 25 08:04 dev
 drwxr-xr-x  61 root   root    4096 Sep 25 08:04 etc

 # Create an idmapped upper mount at /upper. Now, files created as id 0 will
 # show up as id 10000 in /upper and files created as id 1000 will show up as
 # id 11000 under /upper.
 /mount2 --idmap both:10000:0:10000 /upper /upper
 mkdir /upper/upper
 chown 10000:10000 /upper/upper
 mkdir /upper/work
 chown 10000:10000 /upper/work

 # Create an overlayfs mount.
 mount -t overlay overlay -o lowerdir=/lower1/,upperdir=/upper/upper/,workdir=/upper/work/ /merged/

 # Create a new user namespace with an id mapping of 0:20000:10000 and then
 # create an idmapped overlayfs merged mount with the same id mapping.
 ./mount2 -cb:0:20000:10000 -mb:0:20000:10000 /merged/ /merged/

 # Verify that we are in a user namespace with the expected id mapping
 root@f2-vm:/# cat /proc/self/uid_map
          0      20000      10000
 root@f2-vm:/# cat /proc/self/gid_map
          0      20000      10000

 # The merged mount should show up starting from uid and gid 0
 root@f2-vm:/# ls -al /merged/
 total 124
 drwxr-xr-x   1 root   root    4096 Oct 25 23:04 .
 drwxr-xr-x  29 root   root    4096 Oct 28 12:07 ..
 -rw-r--r--   1 root   root    7197 Oct 24 09:45 asdf
 drwxr-xr-x   2 root   root    4096 Oct 16 19:07 ASDF
 lrwxrwxrwx   1 root   root       7 Sep 24 07:43 bin -> usr/bin
 drwxr-xr-x   2 root   root    4096 Apr 15  2020 boot
 -rw-r--r--   1 root   root   13059 Oct  8 12:38 ccc
 drwxr-xr-x   2 ubuntu ubuntu  4096 Oct 23 17:10 ddd
 drwxr-xr-x   3 root   root    4096 Sep 25 08:04 dev
 drwxr-xr-x  61 root   root    4096 Sep 25 08:04 etc

 # Create a file as as root
 root@f2-vm:/merged# touch /merged/A-FILE

 root@f2-vm:/merged# ls -al /merged/A-FILE
 -rw-r--r-- 1 root root 0 Oct 28 12:16 /merged/A-FILE

 # Chown the file to a simple user
 root@f2-vm:/merged# chown 1000:1000 /merged/A-FILE

 root@f2-vm:/merged# ls -al /merged/A-FILE
 -rw-r--r-- 1 ubuntu ubuntu 0 Oct 28 12:16 /merged/A-FILE

 # Create a directory and delegate to simple user
 root@f2-vm:/merged# mkdir /merged/A-DIR

 root@f2-vm:/merged# chown 1000:1000 /merged/A-DIR/

 # Let's look at these files in our idmapped upper directory from within the
 # user namespace. All files should appear to be owned by 65534:65534 since the
 # /upper mount is idmapped to 10000:0:10000 but we are in a user namespace
 # with an idmapping of 0:20000:20000.
 root@f2-vm:/merged# ls -al /upper/upper/
 total 12
 drwxr-xr-x 3 nobody nogroup 4096 Oct 28 13:26 .
 drwxr-xr-x 4 nobody nogroup 4096 Oct 21 13:48 ..
 drwxr-xr-x 2 nobody nogroup 4096 Oct 28 13:26 A-DIR
 -rw-r--r-- 1 nobody nogroup    0 Oct 28 13:25 A-FILE

 # Let's look at this /upper from the initial user namespace (where it is
 # mounted idmapped with 10000:0:10000)
 root@f2-vm:~# ls -al /upper/upper/
 total 12
 drwxr-xr-x 3 root   root   4096 Oct 28 13:26 .
 drwxr-xr-x 4 root   root   4096 Oct 21 13:48 ..
 drwxr-xr-x 2 ubuntu ubuntu 4096 Oct 28 13:26 A-DIR
 -rw-r--r-- 1 ubuntu ubuntu    0 Oct 28 13:25 A-FILE

 # Let's remove the idmapped /upper mount (overlayfs will have it's own private mount anyway)
 umount /upper

 # Let's look at these files in our upper directory with the idmapped mount removed
 ubuntu@f2-vm:/$ ls -al /upper/upper/
 root@f2-vm:~# ls -al /upper/upper/
 total 12
 drwxr-xr-x 3 10000 10000 4096 Oct 28 13:26 .
 drwxr-xr-x 4 10000 10000 4096 Oct 21 13:48 ..
 drwxr-xr-x 2 11000 11000 4096 Oct 28 13:26 A-DIR
 -rw-r--r-- 1 11000 11000    0 Oct 28 13:25 A-FILE

 # Let's create a few acls from the /merged directory on an already existing file
 # triggering a copy-up operation
 root@f2-vm:/merged# setfacl -m u:1000:rwx /merged/asdf
 root@f2-vm:/merged# getfacl /merged/asdf
 getfacl: Removing leading '/' from absolute path names
 # file: merged/asdf
 # owner: root
 # group: root
 user::rw-
 user:ubuntu:rwx
 group::r--
 mask::rwx
 other::r--

 # Let's look at this file from our upper directory from the initial user namespace
 root@f2-vm:/merged# getfacl /upper/upper/asdf
 getfacl: Removing leading '/' from absolute path names
 # file: upper/upper/asdf
 # owner: 10000
 # group: 10000
 user::rw-
 user:11000:rwx
 group::r--
 mask::rwx
 other::r--

Cc: Seth Forshee <seth.forshee@canonical.com>
Cc: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 fs/overlayfs/copy_up.c   |  4 +--
 fs/overlayfs/dir.c       | 68 ++++++++++++++++++++++++++++++++--------
 fs/overlayfs/inode.c     | 40 +++++++++++++++++------
 fs/overlayfs/overlayfs.h |  9 +++++-
 fs/overlayfs/super.c     |  3 ++
 5 files changed, 99 insertions(+), 25 deletions(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 1b8721796fd4..91134203c511 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -268,8 +268,8 @@ int ovl_set_attr(struct user_namespace *user_ns, struct dentry *upperdentry,
 	if (!err) {
 		struct iattr attr = {
 			.ia_valid = ATTR_UID | ATTR_GID,
-			.ia_uid = stat->uid,
-			.ia_gid = stat->gid,
+			.ia_uid = kuid_from_mnt(user_ns, stat->uid),
+			.ia_gid = kgid_from_mnt(user_ns, stat->gid),
 		};
 		err = notify_mapped_change(user_ns, upperdentry, &attr, NULL);
 	}
diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 23d09de00957..1c0153b1ad6d 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -625,7 +625,8 @@ static int ovl_create_or_link(struct dentry *dentry, struct inode *inode,
 	return err;
 }
 
-static int ovl_create_object(struct dentry *dentry, int mode, dev_t rdev,
+static int ovl_create_object(struct user_namespace *user_ns,
+			     struct dentry *dentry, int mode, dev_t rdev,
 			     const char *link)
 {
 	int err;
@@ -649,7 +650,7 @@ static int ovl_create_object(struct dentry *dentry, int mode, dev_t rdev,
 	inode->i_state |= I_CREATING;
 	spin_unlock(&inode->i_lock);
 
-	inode_init_owner(inode, dentry->d_parent->d_inode, mode);
+	mapped_inode_init_owner(inode, user_ns, dentry->d_parent->d_inode, mode);
 	attr.mode = inode->i_mode;
 
 	err = ovl_create_or_link(dentry, inode, &attr, false);
@@ -663,31 +664,55 @@ static int ovl_create_object(struct dentry *dentry, int mode, dev_t rdev,
 	return err;
 }
 
-static int ovl_create(struct inode *dir, struct dentry *dentry, umode_t mode,
-		      bool excl)
+static int ovl_create_mapped(struct user_namespace *user_ns, struct inode *dir,
+			     struct dentry *dentry, umode_t mode, bool excl)
 {
-	return ovl_create_object(dentry, (mode & 07777) | S_IFREG, 0, NULL);
+	return ovl_create_object(user_ns, dentry, (mode & 07777) | S_IFREG, 0, NULL);
+}
+
+static int ovl_create(struct inode *dir, struct dentry *dentry, umode_t mode, bool excl)
+{
+	return ovl_create_mapped(&init_user_ns, dir, dentry, mode, excl);
+}
+
+static int ovl_mkdir_mapped(struct user_namespace *user_ns, struct inode *dir,
+			    struct dentry *dentry, umode_t mode)
+{
+	return ovl_create_object(user_ns, dentry,
+				 (mode & 07777) | S_IFDIR, 0, NULL);
 }
 
 static int ovl_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 {
-	return ovl_create_object(dentry, (mode & 07777) | S_IFDIR, 0, NULL);
+	return ovl_mkdir_mapped(&init_user_ns, dir, dentry, mode);
 }
 
-static int ovl_mknod(struct inode *dir, struct dentry *dentry, umode_t mode,
-		     dev_t rdev)
+static int ovl_mknod_mapped(struct user_namespace *user_ns, struct inode *dir,
+			    struct dentry *dentry, umode_t mode, dev_t rdev)
 {
 	/* Don't allow creation of "whiteout" on overlay */
 	if (S_ISCHR(mode) && rdev == WHITEOUT_DEV)
 		return -EPERM;
 
-	return ovl_create_object(dentry, mode, rdev, NULL);
+	return ovl_create_object(user_ns, dentry, mode, rdev, NULL);
+}
+
+static int ovl_mknod(struct inode *dir, struct dentry *dentry, umode_t mode,
+		     dev_t rdev)
+{
+	return ovl_mknod_mapped(&init_user_ns, dir, dentry, mode, rdev);
+}
+
+static int ovl_symlink_mapped(struct user_namespace *user_ns, struct inode *dir,
+			      struct dentry *dentry, const char *link)
+{
+	return ovl_create_object(user_ns, dentry, S_IFLNK, 0, link);
 }
 
 static int ovl_symlink(struct inode *dir, struct dentry *dentry,
 		       const char *link)
 {
-	return ovl_create_object(dentry, S_IFLNK, 0, link);
+	return ovl_symlink_mapped(&init_user_ns, dir, dentry, link);
 }
 
 static int ovl_set_link_redirect(struct dentry *dentry)
@@ -1085,9 +1110,10 @@ static int ovl_set_redirect(struct dentry *dentry, bool samedir)
 	return err;
 }
 
-static int ovl_rename(struct inode *olddir, struct dentry *old,
-		      struct inode *newdir, struct dentry *new,
-		      unsigned int flags)
+static int ovl_rename_mapped(struct user_namespace *user_ns,
+			     struct inode *olddir, struct dentry *old,
+			     struct inode *newdir, struct dentry *new,
+			     unsigned int flags)
 {
 	int err;
 	struct dentry *old_upperdir;
@@ -1303,6 +1329,13 @@ static int ovl_rename(struct inode *olddir, struct dentry *old,
 	return err;
 }
 
+static int ovl_rename(struct inode *olddir, struct dentry *old,
+		      struct inode *newdir, struct dentry *new,
+		      unsigned int flags)
+{
+	return ovl_rename_mapped(&init_user_ns, olddir, old, newdir, new, flags);
+}
+
 const struct inode_operations ovl_dir_inode_operations = {
 	.lookup		= ovl_lookup,
 	.mkdir		= ovl_mkdir,
@@ -1319,4 +1352,13 @@ const struct inode_operations ovl_dir_inode_operations = {
 	.listxattr	= ovl_listxattr,
 	.get_acl	= ovl_get_acl,
 	.update_time	= ovl_update_time,
+#ifdef CONFIG_IDMAP_MOUNTS
+	.permission_mapped	= ovl_permission_mapped,
+	.mkdir_mapped		= ovl_mkdir_mapped,
+	.create_mapped		= ovl_create_mapped,
+	.mknod_mapped		= ovl_mknod_mapped,
+	.symlink_mapped		= ovl_symlink_mapped,
+	.setattr_mapped		= ovl_setattr_mapped,
+	.rename_mapped		= ovl_rename_mapped,
+#endif
 };
diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index b6c8b904f0e7..3831ddbe57f8 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -14,15 +14,15 @@
 #include <linux/fiemap.h>
 #include "overlayfs.h"
 
-
-int ovl_setattr(struct dentry *dentry, struct iattr *attr)
+int ovl_setattr_mapped(struct user_namespace *user_ns, struct dentry *dentry,
+		       struct iattr *attr)
 {
 	int err;
 	bool full_copy_up = false;
 	struct dentry *upperdentry;
 	const struct cred *old_cred;
 
-	err = setattr_prepare(dentry, attr);
+	err = setattr_mapped_prepare(user_ns, dentry, attr);
 	if (err)
 		return err;
 
@@ -104,6 +104,11 @@ int ovl_setattr(struct dentry *dentry, struct iattr *attr)
 	return err;
 }
 
+int ovl_setattr(struct dentry *dentry, struct iattr *attr)
+{
+	return ovl_setattr_mapped(&init_user_ns, dentry, attr);
+}
+
 static int ovl_map_dev_ino(struct dentry *dentry, struct kstat *stat, int fsid)
 {
 	bool samefs = ovl_same_fs(dentry->d_sb);
@@ -167,6 +172,7 @@ static int ovl_map_dev_ino(struct dentry *dentry, struct kstat *stat, int fsid)
 int ovl_getattr(const struct path *path, struct kstat *stat,
 		u32 request_mask, unsigned int flags)
 {
+	struct user_namespace *user_ns;
 	struct dentry *dentry = path->dentry;
 	enum ovl_path_type type;
 	struct path realpath;
@@ -284,14 +290,19 @@ int ovl_getattr(const struct path *path, struct kstat *stat,
 out:
 	revert_creds(old_cred);
 
+	user_ns = mnt_user_ns(path->mnt);
+	stat->uid = kuid_into_mnt(user_ns, stat->uid);
+	stat->gid = kgid_into_mnt(user_ns, stat->gid);
+
 	return err;
 }
 
-int ovl_permission(struct inode *inode, int mask)
+int ovl_permission_mapped(struct user_namespace *user_ns,
+			  struct inode *inode, int mask)
 {
 	struct inode *upperinode = ovl_inode_upper(inode);
 	struct inode *realinode = upperinode ?: ovl_inode_lower(inode);
-	struct user_namespace *user_ns;
+	struct user_namespace *real_user_ns;
 	const struct cred *old_cred;
 	int err;
 
@@ -302,15 +313,15 @@ int ovl_permission(struct inode *inode, int mask)
 	}
 
 	if (upperinode)
-		user_ns = ovl_upper_mnt_user_ns(OVL_FS(inode->i_sb));
+		real_user_ns = ovl_upper_mnt_user_ns(OVL_FS(inode->i_sb));
 	else
-		user_ns = OVL_I(inode)->lower_user_ns;
+		real_user_ns = OVL_I(inode)->lower_user_ns;
 
 	/*
 	 * Check overlay inode with the creds of task and underlying inode
 	 * with creds of mounter
 	 */
-	err = generic_permission(inode, mask);
+	err = mapped_generic_permission(user_ns, inode, mask);
 	if (err)
 		return err;
 
@@ -322,7 +333,7 @@ int ovl_permission(struct inode *inode, int mask)
 		/* Make sure mounter can read file for copy up later */
 		mask |= MAY_READ;
 	}
-	err = mapped_inode_permission(user_ns, realinode, mask);
+	err = mapped_inode_permission(real_user_ns, realinode, mask);
 	revert_creds(old_cred);
 
 	return err;
@@ -547,6 +558,10 @@ static const struct inode_operations ovl_file_inode_operations = {
 	.get_acl	= ovl_get_acl,
 	.update_time	= ovl_update_time,
 	.fiemap		= ovl_fiemap,
+#ifdef CONFIG_IDMAP_MOUNTS
+	.permission_mapped	= ovl_permission_mapped,
+	.setattr_mapped		= ovl_setattr_mapped,
+#endif
 };
 
 static const struct inode_operations ovl_symlink_inode_operations = {
@@ -555,6 +570,9 @@ static const struct inode_operations ovl_symlink_inode_operations = {
 	.getattr	= ovl_getattr,
 	.listxattr	= ovl_listxattr,
 	.update_time	= ovl_update_time,
+#ifdef CONFIG_IDMAP_MOUNTS
+	.setattr_mapped	= ovl_setattr_mapped,
+#endif
 };
 
 static const struct inode_operations ovl_special_inode_operations = {
@@ -564,6 +582,10 @@ static const struct inode_operations ovl_special_inode_operations = {
 	.listxattr	= ovl_listxattr,
 	.get_acl	= ovl_get_acl,
 	.update_time	= ovl_update_time,
+#ifdef CONFIG_IDMAP_MOUNTS
+	.permission_mapped	= ovl_permission_mapped,
+	.setattr_mapped		= ovl_setattr_mapped,
+#endif
 };
 
 static const struct address_space_operations ovl_aops = {
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 63c257c3bfa8..97c8c34cd6d0 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -470,9 +470,16 @@ unsigned int ovl_get_nlink(struct ovl_fs *ofs, struct dentry *lowerdentry,
 			   struct dentry *upperdentry,
 			   unsigned int fallback);
 int ovl_setattr(struct dentry *dentry, struct iattr *attr);
+int ovl_setattr_mapped(struct user_namespace *user_ns, struct dentry *dentry,
+		       struct iattr *attr);
 int ovl_getattr(const struct path *path, struct kstat *stat,
 		u32 request_mask, unsigned int flags);
-int ovl_permission(struct inode *inode, int mask);
+int ovl_permission_mapped(struct user_namespace *user_ns,
+			  struct inode *inode, int mask);
+static inline int ovl_permission(struct inode *inode, int mask)
+{
+	return ovl_permission_mapped(&init_user_ns, inode, mask);
+}
 int ovl_xattr_set(struct dentry *dentry, struct inode *inode, const char *name,
 		  const void *value, size_t size, int flags);
 int ovl_xattr_get(struct dentry *dentry, struct inode *inode, const char *name,
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 755f651587a5..8db8ccd70b6f 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -2082,6 +2082,9 @@ static struct file_system_type ovl_fs_type = {
 	.name		= "overlay",
 	.mount		= ovl_mount,
 	.kill_sb	= kill_anon_super,
+#ifdef CONFIG_IDMAP_MOUNTS
+	.fs_flags	= FS_ALLOW_IDMAP,
+#endif
 };
 MODULE_ALIAS_FS("overlay");
 
-- 
2.29.0

