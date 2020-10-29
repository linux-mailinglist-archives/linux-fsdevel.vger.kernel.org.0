Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74B5829DDA3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Oct 2020 01:39:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388793AbgJ2Ajz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Oct 2020 20:39:55 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:33372 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730091AbgJ2Ajw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Oct 2020 20:39:52 -0400
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kXvvD-0008Ep-J8; Thu, 29 Oct 2020 00:36:07 +0000
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
Subject: [PATCH 32/34] overlayfs: handle idmapped lower directories
Date:   Thu, 29 Oct 2020 01:32:50 +0100
Message-Id: <20201029003252.2128653-33-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201029003252.2128653-1-christian.brauner@ubuntu.com>
References: <20201029003252.2128653-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

As an overlay filesystem overlayfs can be mounted on top of other filesystems
and bind-mounts. This means it can also be bind-mounted on top of one or
multiple idmapped lower directories and/or an idmapped upper directory.
In previous patches we've enabled the vfs to handle idmapped mounts and so we
should have all of the helpers available to let overlayfs handle idmapped
mounts. To handle such scenarios correctly overlayfs needs to be switched from
non-idmapped mount aware vfs helpers to idmapped mount aware vfs helpers.
In order to have overlayfs correctly support idmapped mounts as lower and upper
directories we need to pass down the mount's user namespace associated with the
lower and upper directories whenver we perform idmapped mount aware operations.

Luckily, when overlayfs is mounted it creates private mounts of the lower and
upper directories via clone_private_mount() which calls clone_mnt() internally.
If any of the lower or upper directories are on an idmapped mount then
clone_mnt() called in clone_private_mount() will also pin the user namespace
the vfsmount has been marked with. Overlayfs stashes the information about the
lower and upper directories and the mounts that they are on so that this
information can be retrieved when needed. This makes it possible to support
idmapped mounts as lower and upper directories. Support for idmapped merged
mounts will be added in a follow-up patch.

Whenever we perform idmap mount aware operations we need to pass down the
mount's user namespace to the vfs helpers we've introduced in earlier patches.
Permission checks on the lower and upper directories are performed by switching
from the inode_permission() and inode_owner_or_capable() helpers to the new
mapped_inode_permission() and mapped_inode_owner_or_capable() helpers.
Similarly we switch from non-idmapped mount aware lookup helpers to
idmapped-mount aware lookup helpers. In all cases where we need to check
permissions in the lower or upper directories we pass down the mount associated
with the lower and upper directory at the time of creating the overlayfs mount.
This nicely lines up with the permission model outlined in the overlayfs
documentation (Special thanks to Amir for pointing me to this document!).

Thank to Amir for pointing me to the overlayfs permission model documentation!

A very special thank you to my friend Seth Forshee who has given invaluable
advice when coming up with these patches!

As an example let's create overlayfs mount in the initial user namespace with
an idmapped lower and upper mount:

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
 mkdir /upper/work

 # Create an overlayfs mount.
 mount -t overlay overlay -o lowerdir=/lower1/,upperdir=/upper/upper/,workdir=/upper/work/ /merged/

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

 # Login as user
 root@f2-vm:/merged# sudo -u ubuntu -- bash -i

 # Create a file as simpel user
 ubuntu@f2-vm:/merged$ touch /merged/A-DIR/A-USER-FILE

 ubuntu@f2-vm:/merged$ ls -al /merged/A-DIR/A-USER-FILE
 -rw-rw-r-- 1 ubuntu ubuntu 0 Oct 28 12:18 /merged/A-DIR/A-USER-FILE

 # Let's look at these files in our idmapped upper directory
 ubuntu@f2-vm:/$ ls -alR /upper/upper/
 /upper/upper/:
 total 12
 drwxr-xr-x 3 root   root   4096 Oct 28 12:23 .
 drwxr-xr-x 4 root   root   4096 Oct 21 13:48 ..
 drwxr-xr-x 2 ubuntu ubuntu 4096 Oct 28 12:18 A-DIR
 -rw-r--r-- 1 ubuntu ubuntu    0 Oct 28 12:16 A-FILE

 /upper/upper/A-DIR:
 total 8
 drwxr-xr-x 2 ubuntu ubuntu 4096 Oct 28 12:18 .
 drwxr-xr-x 3 root   root   4096 Oct 28 12:23 ..
 -rw-rw-r-- 1 ubuntu ubuntu    0 Oct 28 12:18 A-USER-FILE

 # Let's remove the idmapped /upper mount (overlayfs will have it's own private mount anyway)
 umount /upper

 # Let's look at these files in our upper directory with the idmapped mount removed
 ubuntu@f2-vm:/$ ls -alR /upper/upper/
 /upper/upper/:
 total 12
 drwxr-xr-x 3 10000 10000 4096 Oct 28 12:23 .
 drwxr-xr-x 4 10000 10000 4096 Oct 21 13:48 ..
 drwxr-xr-x 2 11000 11000 4096 Oct 28 12:18 A-DIR
 -rw-r--r-- 1 11000 11000    0 Oct 28 12:16 A-FILE

 /upper/upper/A-DIR:
 total 8
 drwxr-xr-x 2 11000 11000 4096 Oct 28 12:18 .
 drwxr-xr-x 3 10000 10000 4096 Oct 28 12:23 ..
 -rw-rw-r-- 1 11000 11000    0 Oct 28 12:18 A-USER-FILE

 # Let's create a few acls from the /merged directory  on an already existing file
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

  # Let's look at this file from our upper directory
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
 fs/overlayfs/copy_up.c   | 100 +++++++++++++++-----------
 fs/overlayfs/dir.c       | 151 ++++++++++++++++++++++-----------------
 fs/overlayfs/export.c    |   3 +-
 fs/overlayfs/file.c      |  23 +++---
 fs/overlayfs/inode.c     |  89 ++++++++++++++++++-----
 fs/overlayfs/namei.c     |  64 ++++++++++-------
 fs/overlayfs/overlayfs.h | 149 ++++++++++++++++++++++++++------------
 fs/overlayfs/ovl_entry.h |   1 +
 fs/overlayfs/readdir.c   |  34 +++++----
 fs/overlayfs/super.c     | 106 ++++++++++++++++++++-------
 fs/overlayfs/util.c      |  38 +++++-----
 11 files changed, 494 insertions(+), 264 deletions(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 955ecd4030f0..1b8721796fd4 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -43,7 +43,8 @@ static bool ovl_must_copy_xattr(const char *name)
 	       !strncmp(name, XATTR_SECURITY_PREFIX, XATTR_SECURITY_PREFIX_LEN);
 }
 
-int ovl_copy_xattr(struct super_block *sb, struct dentry *old,
+int ovl_copy_xattr(struct super_block *sb, struct user_namespace *old_user_ns,
+		   struct dentry *old, struct user_namespace *new_user_ns,
 		   struct dentry *new)
 {
 	ssize_t list_size, size, value_size = 0;
@@ -85,9 +86,9 @@ int ovl_copy_xattr(struct super_block *sb, struct dentry *old,
 		if (ovl_is_private_xattr(sb, name))
 			continue;
 retry:
-		size = vfs_getxattr(old, name, value, value_size);
+		size = vfs_mapped_getxattr(old_user_ns, old, name, value, value_size);
 		if (size == -ERANGE)
-			size = vfs_getxattr(old, name, NULL, 0);
+			size = vfs_mapped_getxattr(old_user_ns, old, name, NULL, 0);
 
 		if (size < 0) {
 			error = size;
@@ -114,7 +115,7 @@ int ovl_copy_xattr(struct super_block *sb, struct dentry *old,
 			error = 0;
 			continue; /* Discard */
 		}
-		error = vfs_setxattr(new, name, value, size, 0);
+		error = vfs_mapped_setxattr(new_user_ns, new, name, value, size, 0);
 		if (error) {
 			if (error != -EOPNOTSUPP || ovl_must_copy_xattr(name))
 				break;
@@ -228,17 +229,19 @@ static int ovl_copy_up_data(struct ovl_fs *ofs, struct path *old,
 	return error;
 }
 
-static int ovl_set_size(struct dentry *upperdentry, struct kstat *stat)
+static int ovl_set_size(struct user_namespace *user_ns,
+			struct dentry *upperdentry, struct kstat *stat)
 {
 	struct iattr attr = {
 		.ia_valid = ATTR_SIZE,
 		.ia_size = stat->size,
 	};
 
-	return notify_change(upperdentry, &attr, NULL);
+	return notify_mapped_change(user_ns, upperdentry, &attr, NULL);
 }
 
-static int ovl_set_timestamps(struct dentry *upperdentry, struct kstat *stat)
+static int ovl_set_timestamps(struct user_namespace *user_ns,
+			      struct dentry *upperdentry, struct kstat *stat)
 {
 	struct iattr attr = {
 		.ia_valid =
@@ -247,10 +250,11 @@ static int ovl_set_timestamps(struct dentry *upperdentry, struct kstat *stat)
 		.ia_mtime = stat->mtime,
 	};
 
-	return notify_change(upperdentry, &attr, NULL);
+	return notify_mapped_change(user_ns, upperdentry, &attr, NULL);
 }
 
-int ovl_set_attr(struct dentry *upperdentry, struct kstat *stat)
+int ovl_set_attr(struct user_namespace *user_ns, struct dentry *upperdentry,
+		 struct kstat *stat)
 {
 	int err = 0;
 
@@ -259,7 +263,7 @@ int ovl_set_attr(struct dentry *upperdentry, struct kstat *stat)
 			.ia_valid = ATTR_MODE,
 			.ia_mode = stat->mode,
 		};
-		err = notify_change(upperdentry, &attr, NULL);
+		err = notify_mapped_change(user_ns, upperdentry, &attr, NULL);
 	}
 	if (!err) {
 		struct iattr attr = {
@@ -267,10 +271,10 @@ int ovl_set_attr(struct dentry *upperdentry, struct kstat *stat)
 			.ia_uid = stat->uid,
 			.ia_gid = stat->gid,
 		};
-		err = notify_change(upperdentry, &attr, NULL);
+		err = notify_mapped_change(user_ns, upperdentry, &attr, NULL);
 	}
 	if (!err)
-		ovl_set_timestamps(upperdentry, stat);
+		ovl_set_timestamps(user_ns, upperdentry, stat);
 
 	return err;
 }
@@ -356,8 +360,8 @@ int ovl_set_origin(struct dentry *dentry, struct dentry *lower,
 }
 
 /* Store file handle of @upper dir in @index dir entry */
-static int ovl_set_upper_fh(struct ovl_fs *ofs, struct dentry *upper,
-			    struct dentry *index)
+static int ovl_set_upper_fh(struct ovl_fs *ofs, struct user_namespace *user_ns,
+			    struct dentry *upper, struct dentry *index)
 {
 	const struct ovl_fh *fh;
 	int err;
@@ -377,7 +381,8 @@ static int ovl_set_upper_fh(struct ovl_fs *ofs, struct dentry *upper,
  *
  * Caller must hold i_mutex on indexdir.
  */
-static int ovl_create_index(struct dentry *dentry, struct dentry *origin,
+static int ovl_create_index(struct user_namespace *user_ns,
+			    struct dentry *dentry, struct dentry *origin,
 			    struct dentry *upper)
 {
 	struct dentry *indexdir = ovl_indexdir(dentry->d_sb);
@@ -406,25 +411,25 @@ static int ovl_create_index(struct dentry *dentry, struct dentry *origin,
 	if (err)
 		return err;
 
-	temp = ovl_create_temp(indexdir, OVL_CATTR(S_IFDIR | 0));
+	temp = ovl_create_temp(user_ns, indexdir, OVL_CATTR(S_IFDIR | 0));
 	err = PTR_ERR(temp);
 	if (IS_ERR(temp))
 		goto free_name;
 
-	err = ovl_set_upper_fh(OVL_FS(dentry->d_sb), upper, temp);
+	err = ovl_set_upper_fh(OVL_FS(dentry->d_sb), user_ns, upper, temp);
 	if (err)
 		goto out;
 
-	index = lookup_one_len(name.name, indexdir, name.len);
+	index = lookup_one_len_mapped(name.name, indexdir, name.len, user_ns);
 	if (IS_ERR(index)) {
 		err = PTR_ERR(index);
 	} else {
-		err = ovl_do_rename(dir, temp, dir, index, 0);
+		err = ovl_do_rename(dir, user_ns, temp, dir, user_ns, index, 0);
 		dput(index);
 	}
 out:
 	if (err)
-		ovl_cleanup(dir, temp);
+		ovl_cleanup(user_ns, dir, temp);
 	dput(temp);
 free_name:
 	kfree(name.name);
@@ -441,6 +446,7 @@ struct ovl_copy_up_ctx {
 	struct dentry *destdir;
 	struct qstr destname;
 	struct dentry *workdir;
+	struct user_namespace *user_ns;
 	bool origin;
 	bool indexed;
 	bool metacopy;
@@ -463,16 +469,17 @@ static int ovl_link_up(struct ovl_copy_up_ctx *c)
 		return err;
 
 	inode_lock_nested(udir, I_MUTEX_PARENT);
-	upper = lookup_one_len(c->dentry->d_name.name, upperdir,
-			       c->dentry->d_name.len);
+	upper = lookup_one_len_mapped(c->dentry->d_name.name, upperdir,
+				  c->dentry->d_name.len,
+				  c->user_ns);
 	err = PTR_ERR(upper);
 	if (!IS_ERR(upper)) {
-		err = ovl_do_link(ovl_dentry_upper(c->dentry), udir, upper);
+		err = ovl_do_link(c->user_ns, ovl_dentry_upper(c->dentry), udir, upper);
 		dput(upper);
 
 		if (!err) {
 			/* Restore timestamps on parent (best effort) */
-			ovl_set_timestamps(upperdir, &c->pstat);
+			ovl_set_timestamps(c->user_ns, upperdir, &c->pstat);
 			ovl_dentry_set_upper_alias(c->dentry);
 		}
 	}
@@ -509,7 +516,8 @@ static int ovl_copy_up_inode(struct ovl_copy_up_ctx *c, struct dentry *temp)
 			return err;
 	}
 
-	err = ovl_copy_xattr(c->dentry->d_sb, c->lowerpath.dentry, temp);
+	err = ovl_copy_xattr(c->dentry->d_sb, mnt_user_ns(c->lowerpath.mnt),
+			     c->lowerpath.dentry, c->user_ns, temp);
 	if (err)
 		return err;
 
@@ -535,9 +543,9 @@ static int ovl_copy_up_inode(struct ovl_copy_up_ctx *c, struct dentry *temp)
 
 	inode_lock(temp->d_inode);
 	if (S_ISREG(c->stat.mode))
-		err = ovl_set_size(temp, &c->stat);
+		err = ovl_set_size(c->user_ns, temp, &c->stat);
 	if (!err)
-		err = ovl_set_attr(temp, &c->stat);
+		err = ovl_set_attr(c->user_ns, temp, &c->stat);
 	inode_unlock(temp->d_inode);
 
 	return err;
@@ -598,7 +606,7 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx *c)
 	if (err)
 		goto unlock;
 
-	temp = ovl_create_temp(c->workdir, &cattr);
+	temp = ovl_create_temp(c->user_ns, c->workdir, &cattr);
 	ovl_revert_cu_creds(&cc);
 
 	err = PTR_ERR(temp);
@@ -610,17 +618,18 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx *c)
 		goto cleanup;
 
 	if (S_ISDIR(c->stat.mode) && c->indexed) {
-		err = ovl_create_index(c->dentry, c->lowerpath.dentry, temp);
+		err = ovl_create_index(c->user_ns, c->dentry, c->lowerpath.dentry, temp);
 		if (err)
 			goto cleanup;
 	}
 
-	upper = lookup_one_len(c->destname.name, c->destdir, c->destname.len);
+	upper = lookup_one_len_mapped(c->destname.name, c->destdir, c->destname.len,
+				  c->user_ns);
 	err = PTR_ERR(upper);
 	if (IS_ERR(upper))
 		goto cleanup;
 
-	err = ovl_do_rename(wdir, temp, udir, upper, 0);
+	err = ovl_do_rename(wdir, c->user_ns, temp, udir, c->user_ns, upper, 0);
 	dput(upper);
 	if (err)
 		goto cleanup;
@@ -637,7 +646,7 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx *c)
 	return err;
 
 cleanup:
-	ovl_cleanup(wdir, temp);
+	ovl_cleanup(c->user_ns, wdir, temp);
 	dput(temp);
 	goto unlock;
 }
@@ -654,7 +663,7 @@ static int ovl_copy_up_tmpfile(struct ovl_copy_up_ctx *c)
 	if (err)
 		return err;
 
-	temp = ovl_do_tmpfile(c->workdir, c->stat.mode);
+	temp = ovl_do_tmpfile(c->user_ns, c->workdir, c->stat.mode);
 	ovl_revert_cu_creds(&cc);
 
 	if (IS_ERR(temp))
@@ -666,10 +675,11 @@ static int ovl_copy_up_tmpfile(struct ovl_copy_up_ctx *c)
 
 	inode_lock_nested(udir, I_MUTEX_PARENT);
 
-	upper = lookup_one_len(c->destname.name, c->destdir, c->destname.len);
+	upper = lookup_one_len_mapped(c->destname.name, c->destdir, c->destname.len,
+				  c->user_ns);
 	err = PTR_ERR(upper);
 	if (!IS_ERR(upper)) {
-		err = ovl_do_link(temp, udir, upper);
+		err = ovl_do_link(c->user_ns, temp, udir, upper);
 		dput(upper);
 	}
 	inode_unlock(udir);
@@ -757,7 +767,7 @@ static int ovl_do_copy_up(struct ovl_copy_up_ctx *c)
 
 		/* Restore timestamps on parent (best effort) */
 		inode_lock(udir);
-		ovl_set_timestamps(c->destdir, &c->pstat);
+		ovl_set_timestamps(c->user_ns, c->destdir, &c->pstat);
 		inode_unlock(udir);
 
 		ovl_dentry_set_upper_alias(c->dentry);
@@ -786,12 +796,13 @@ static bool ovl_need_meta_copy_up(struct dentry *dentry, umode_t mode,
 	return true;
 }
 
-static ssize_t ovl_getxattr(struct dentry *dentry, char *name, char **value)
+static ssize_t ovl_getxattr(struct user_namespace *user_ns,
+			    struct dentry *dentry, char *name, char **value)
 {
 	ssize_t res;
 	char *buf;
 
-	res = vfs_getxattr(dentry, name, NULL, 0);
+	res = vfs_mapped_getxattr(user_ns, dentry, name, NULL, 0);
 	if (res == -ENODATA || res == -EOPNOTSUPP)
 		res = 0;
 
@@ -800,7 +811,7 @@ static ssize_t ovl_getxattr(struct dentry *dentry, char *name, char **value)
 		if (!buf)
 			return -ENOMEM;
 
-		res = vfs_getxattr(dentry, name, buf, res);
+		res = vfs_mapped_getxattr(user_ns, dentry, name, buf, res);
 		if (res < 0)
 			kfree(buf);
 		else
@@ -814,6 +825,7 @@ static int ovl_copy_up_meta_inode_data(struct ovl_copy_up_ctx *c)
 {
 	struct ovl_fs *ofs = OVL_FS(c->dentry->d_sb);
 	struct path upperpath, datapath;
+	struct user_namespace *user_ns;
 	int err;
 	char *capability = NULL;
 	ssize_t cap_size;
@@ -827,8 +839,8 @@ static int ovl_copy_up_meta_inode_data(struct ovl_copy_up_ctx *c)
 		return -EIO;
 
 	if (c->stat.size) {
-		err = cap_size = ovl_getxattr(upperpath.dentry, XATTR_NAME_CAPS,
-					      &capability);
+		err = cap_size = ovl_getxattr(c->user_ns, upperpath.dentry,
+					      XATTR_NAME_CAPS, &capability);
 		if (cap_size < 0)
 			goto out;
 	}
@@ -841,9 +853,10 @@ static int ovl_copy_up_meta_inode_data(struct ovl_copy_up_ctx *c)
 	 * Writing to upper file will clear security.capability xattr. We
 	 * don't want that to happen for normal copy-up operation.
 	 */
+	user_ns = mnt_user_ns(upperpath.mnt);
 	if (capability) {
-		err = vfs_setxattr(upperpath.dentry, XATTR_NAME_CAPS,
-				   capability, cap_size, 0);
+		err = vfs_mapped_setxattr(user_ns, upperpath.dentry,
+				      XATTR_NAME_CAPS, capability, cap_size, 0);
 		if (err)
 			goto out_free;
 	}
@@ -887,6 +900,7 @@ static int ovl_copy_up_one(struct dentry *parent, struct dentry *dentry,
 		ovl_path_upper(parent, &parentpath);
 		ctx.destdir = parentpath.dentry;
 		ctx.destname = dentry->d_name;
+		ctx.user_ns = mnt_user_ns(parentpath.mnt);
 
 		err = vfs_getattr(&parentpath, &ctx.pstat,
 				  STATX_ATIME | STATX_MTIME,
diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 28a075b5f5b2..23d09de00957 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -23,15 +23,16 @@ MODULE_PARM_DESC(redirect_max,
 
 static int ovl_set_redirect(struct dentry *dentry, bool samedir);
 
-int ovl_cleanup(struct inode *wdir, struct dentry *wdentry)
+int ovl_cleanup(struct user_namespace *user_ns, struct inode *wdir,
+		struct dentry *wdentry)
 {
 	int err;
 
 	dget(wdentry);
 	if (d_is_dir(wdentry))
-		err = ovl_do_rmdir(wdir, wdentry);
+		err = ovl_do_rmdir(user_ns, wdir, wdentry);
 	else
-		err = ovl_do_unlink(wdir, wdentry);
+		err = ovl_do_unlink(user_ns, wdir, wdentry);
 	dput(wdentry);
 
 	if (err) {
@@ -42,7 +43,8 @@ int ovl_cleanup(struct inode *wdir, struct dentry *wdentry)
 	return err;
 }
 
-struct dentry *ovl_lookup_temp(struct dentry *workdir)
+struct dentry *ovl_lookup_temp(struct user_namespace *user_ns,
+			       struct dentry *workdir)
 {
 	struct dentry *temp;
 	char name[20];
@@ -51,7 +53,7 @@ struct dentry *ovl_lookup_temp(struct dentry *workdir)
 	/* counter is allowed to wrap, since temp dentries are ephemeral */
 	snprintf(name, sizeof(name), "#%x", atomic_inc_return(&temp_id));
 
-	temp = lookup_one_len(name, workdir, strlen(name));
+	temp = lookup_one_len_mapped(name, workdir, strlen(name), user_ns);
 	if (!IS_ERR(temp) && temp->d_inode) {
 		pr_err("workdir/%s already exists\n", name);
 		dput(temp);
@@ -68,13 +70,14 @@ static struct dentry *ovl_whiteout(struct ovl_fs *ofs)
 	struct dentry *whiteout;
 	struct dentry *workdir = ofs->workdir;
 	struct inode *wdir = workdir->d_inode;
+	struct user_namespace *user_ns = ovl_upper_mnt_user_ns(ofs);
 
 	if (!ofs->whiteout) {
-		whiteout = ovl_lookup_temp(workdir);
+		whiteout = ovl_lookup_temp(user_ns, workdir);
 		if (IS_ERR(whiteout))
 			goto out;
 
-		err = ovl_do_whiteout(wdir, whiteout);
+		err = ovl_do_whiteout(user_ns, wdir, whiteout);
 		if (err) {
 			dput(whiteout);
 			whiteout = ERR_PTR(err);
@@ -84,11 +87,11 @@ static struct dentry *ovl_whiteout(struct ovl_fs *ofs)
 	}
 
 	if (ofs->share_whiteout) {
-		whiteout = ovl_lookup_temp(workdir);
+		whiteout = ovl_lookup_temp(user_ns, workdir);
 		if (IS_ERR(whiteout))
 			goto out;
 
-		err = ovl_do_link(ofs->whiteout, wdir, whiteout);
+		err = ovl_do_link(user_ns, ofs->whiteout, wdir, whiteout);
 		if (!err)
 			goto out;
 
@@ -110,6 +113,7 @@ int ovl_cleanup_and_whiteout(struct ovl_fs *ofs, struct inode *dir,
 			     struct dentry *dentry)
 {
 	struct inode *wdir = ofs->workdir->d_inode;
+	struct user_namespace *user_ns = ovl_upper_mnt_user_ns(ofs);
 	struct dentry *whiteout;
 	int err;
 	int flags = 0;
@@ -122,28 +126,28 @@ int ovl_cleanup_and_whiteout(struct ovl_fs *ofs, struct inode *dir,
 	if (d_is_dir(dentry))
 		flags = RENAME_EXCHANGE;
 
-	err = ovl_do_rename(wdir, whiteout, dir, dentry, flags);
+	err = ovl_do_rename(wdir, user_ns, whiteout, dir, user_ns, dentry, flags);
 	if (err)
 		goto kill_whiteout;
 	if (flags)
-		ovl_cleanup(wdir, dentry);
+		ovl_cleanup(user_ns, wdir, dentry);
 
 out:
 	dput(whiteout);
 	return err;
 
 kill_whiteout:
-	ovl_cleanup(wdir, whiteout);
+	ovl_cleanup(user_ns, wdir, whiteout);
 	goto out;
 }
 
-static int ovl_mkdir_real(struct inode *dir, struct dentry **newdentry,
-			  umode_t mode)
+static int ovl_mkdir_real(struct user_namespace *user_ns, struct inode *dir,
+			  struct dentry **newdentry, umode_t mode)
 {
 	int err;
 	struct dentry *d, *dentry = *newdentry;
 
-	err = ovl_do_mkdir(dir, dentry, mode);
+	err = ovl_do_mkdir(user_ns, dir, dentry, mode);
 	if (err)
 		return err;
 
@@ -155,8 +159,8 @@ static int ovl_mkdir_real(struct inode *dir, struct dentry **newdentry,
 	 * to it unhashed and negative. If that happens, try to
 	 * lookup a new hashed and positive dentry.
 	 */
-	d = lookup_one_len(dentry->d_name.name, dentry->d_parent,
-			   dentry->d_name.len);
+	d = lookup_one_len_mapped(dentry->d_name.name, dentry->d_parent,
+			      dentry->d_name.len, user_ns);
 	if (IS_ERR(d)) {
 		pr_warn("failed lookup after mkdir (%pd2, err=%i).\n",
 			dentry, err);
@@ -168,7 +172,8 @@ static int ovl_mkdir_real(struct inode *dir, struct dentry **newdentry,
 	return 0;
 }
 
-struct dentry *ovl_create_real(struct inode *dir, struct dentry *newdentry,
+struct dentry *ovl_create_real(struct user_namespace *user_ns,
+			       struct inode *dir, struct dentry *newdentry,
 			       struct ovl_cattr *attr)
 {
 	int err;
@@ -181,28 +186,28 @@ struct dentry *ovl_create_real(struct inode *dir, struct dentry *newdentry,
 		goto out;
 
 	if (attr->hardlink) {
-		err = ovl_do_link(attr->hardlink, dir, newdentry);
+		err = ovl_do_link(user_ns, attr->hardlink, dir, newdentry);
 	} else {
 		switch (attr->mode & S_IFMT) {
 		case S_IFREG:
-			err = ovl_do_create(dir, newdentry, attr->mode);
+			err = ovl_do_create(user_ns, dir, newdentry, attr->mode);
 			break;
 
 		case S_IFDIR:
 			/* mkdir is special... */
-			err =  ovl_mkdir_real(dir, &newdentry, attr->mode);
+			err =  ovl_mkdir_real(user_ns, dir, &newdentry, attr->mode);
 			break;
 
 		case S_IFCHR:
 		case S_IFBLK:
 		case S_IFIFO:
 		case S_IFSOCK:
-			err = ovl_do_mknod(dir, newdentry, attr->mode,
+			err = ovl_do_mknod(user_ns, dir, newdentry, attr->mode,
 					   attr->rdev);
 			break;
 
 		case S_IFLNK:
-			err = ovl_do_symlink(dir, newdentry, attr->link);
+			err = ovl_do_symlink(user_ns, dir, newdentry, attr->link);
 			break;
 
 		default:
@@ -224,10 +229,11 @@ struct dentry *ovl_create_real(struct inode *dir, struct dentry *newdentry,
 	return newdentry;
 }
 
-struct dentry *ovl_create_temp(struct dentry *workdir, struct ovl_cattr *attr)
+struct dentry *ovl_create_temp(struct user_namespace *user_ns, struct dentry *workdir,
+			       struct ovl_cattr *attr)
 {
-	return ovl_create_real(d_inode(workdir), ovl_lookup_temp(workdir),
-			       attr);
+	return ovl_create_real(user_ns, d_inode(workdir),
+			       ovl_lookup_temp(user_ns, workdir), attr);
 }
 
 static int ovl_set_opaque_xerr(struct dentry *dentry, struct dentry *upper,
@@ -323,16 +329,18 @@ static int ovl_create_upper(struct dentry *dentry, struct inode *inode,
 	struct dentry *upperdir = ovl_dentry_upper(dentry->d_parent);
 	struct inode *udir = upperdir->d_inode;
 	struct dentry *newdentry;
+	struct user_namespace *user_ns = ovl_dentry_mnt_user_ns(dentry);
 	int err;
 
 	if (!attr->hardlink && !IS_POSIXACL(udir))
 		attr->mode &= ~current_umask();
 
 	inode_lock_nested(udir, I_MUTEX_PARENT);
-	newdentry = ovl_create_real(udir,
-				    lookup_one_len(dentry->d_name.name,
-						   upperdir,
-						   dentry->d_name.len),
+	newdentry = ovl_create_real(user_ns, udir,
+				    lookup_one_len_mapped(dentry->d_name.name,
+						      upperdir,
+						      dentry->d_name.len,
+						      user_ns),
 				    attr);
 	err = PTR_ERR(newdentry);
 	if (IS_ERR(newdentry))
@@ -351,7 +359,7 @@ static int ovl_create_upper(struct dentry *dentry, struct inode *inode,
 	return err;
 
 out_cleanup:
-	ovl_cleanup(udir, newdentry);
+	ovl_cleanup(user_ns, udir, newdentry);
 	dput(newdentry);
 	goto out_unlock;
 }
@@ -363,6 +371,7 @@ static struct dentry *ovl_clear_empty(struct dentry *dentry,
 	struct inode *wdir = workdir->d_inode;
 	struct dentry *upperdir = ovl_dentry_upper(dentry->d_parent);
 	struct inode *udir = upperdir->d_inode;
+	struct user_namespace *user_ns;
 	struct path upperpath;
 	struct dentry *upper;
 	struct dentry *opaquedir;
@@ -389,12 +398,13 @@ static struct dentry *ovl_clear_empty(struct dentry *dentry,
 	if (upper->d_parent->d_inode != udir)
 		goto out_unlock;
 
-	opaquedir = ovl_create_temp(workdir, OVL_CATTR(stat.mode));
+	user_ns = mnt_user_ns(upperpath.mnt);
+	opaquedir = ovl_create_temp(user_ns, workdir, OVL_CATTR(stat.mode));
 	err = PTR_ERR(opaquedir);
 	if (IS_ERR(opaquedir))
 		goto out_unlock;
 
-	err = ovl_copy_xattr(dentry->d_sb, upper, opaquedir);
+	err = ovl_copy_xattr(dentry->d_sb, user_ns, upper, user_ns, opaquedir);
 	if (err)
 		goto out_cleanup;
 
@@ -403,17 +413,17 @@ static struct dentry *ovl_clear_empty(struct dentry *dentry,
 		goto out_cleanup;
 
 	inode_lock(opaquedir->d_inode);
-	err = ovl_set_attr(opaquedir, &stat);
+	err = ovl_set_attr(user_ns, opaquedir, &stat);
 	inode_unlock(opaquedir->d_inode);
 	if (err)
 		goto out_cleanup;
 
-	err = ovl_do_rename(wdir, opaquedir, udir, upper, RENAME_EXCHANGE);
+	err = ovl_do_rename(wdir, user_ns, opaquedir, udir, user_ns, upper, RENAME_EXCHANGE);
 	if (err)
 		goto out_cleanup;
 
-	ovl_cleanup_whiteouts(upper, list);
-	ovl_cleanup(wdir, upper);
+	ovl_cleanup_whiteouts(user_ns, upper, list);
+	ovl_cleanup(user_ns, wdir, upper);
 	unlock_rename(workdir, upperdir);
 
 	/* dentry's upper doesn't match now, get rid of it */
@@ -422,7 +432,7 @@ static struct dentry *ovl_clear_empty(struct dentry *dentry,
 	return opaquedir;
 
 out_cleanup:
-	ovl_cleanup(wdir, opaquedir);
+	ovl_cleanup(user_ns, wdir, opaquedir);
 	dput(opaquedir);
 out_unlock:
 	unlock_rename(workdir, upperdir);
@@ -430,7 +440,8 @@ static struct dentry *ovl_clear_empty(struct dentry *dentry,
 	return ERR_PTR(err);
 }
 
-static int ovl_set_upper_acl(struct dentry *upperdentry, const char *name,
+static int ovl_set_upper_acl(struct user_namespace *user_ns,
+			     struct dentry *upperdentry, const char *name,
 			     const struct posix_acl *acl)
 {
 	void *buffer;
@@ -449,7 +460,7 @@ static int ovl_set_upper_acl(struct dentry *upperdentry, const char *name,
 	if (err < 0)
 		goto out_free;
 
-	err = vfs_setxattr(upperdentry, name, buffer, size, XATTR_CREATE);
+	err = vfs_mapped_setxattr(user_ns, upperdentry, name, buffer, size, XATTR_CREATE);
 out_free:
 	kfree(buffer);
 	return err;
@@ -464,6 +475,7 @@ static int ovl_create_over_whiteout(struct dentry *dentry, struct inode *inode,
 	struct inode *udir = upperdir->d_inode;
 	struct dentry *upper;
 	struct dentry *newdentry;
+	struct user_namespace *user_ns;
 	int err;
 	struct posix_acl *acl, *default_acl;
 	bool hardlink = !!cattr->hardlink;
@@ -482,8 +494,9 @@ static int ovl_create_over_whiteout(struct dentry *dentry, struct inode *inode,
 	if (err)
 		goto out;
 
-	upper = lookup_one_len(dentry->d_name.name, upperdir,
-			       dentry->d_name.len);
+	user_ns = ovl_dentry_mnt_user_ns(dentry->d_parent);
+	upper = lookup_one_len_mapped(dentry->d_name.name, upperdir,
+				  dentry->d_name.len, user_ns);
 	err = PTR_ERR(upper);
 	if (IS_ERR(upper))
 		goto out_unlock;
@@ -492,7 +505,7 @@ static int ovl_create_over_whiteout(struct dentry *dentry, struct inode *inode,
 	if (d_is_negative(upper) || !IS_WHITEOUT(d_inode(upper)))
 		goto out_dput;
 
-	newdentry = ovl_create_temp(workdir, cattr);
+	newdentry = ovl_create_temp(user_ns, workdir, cattr);
 	err = PTR_ERR(newdentry);
 	if (IS_ERR(newdentry))
 		goto out_dput;
@@ -508,18 +521,18 @@ static int ovl_create_over_whiteout(struct dentry *dentry, struct inode *inode,
 			.ia_mode = cattr->mode,
 		};
 		inode_lock(newdentry->d_inode);
-		err = notify_change(newdentry, &attr, NULL);
+		err = notify_mapped_change(user_ns, newdentry, &attr, NULL);
 		inode_unlock(newdentry->d_inode);
 		if (err)
 			goto out_cleanup;
 	}
 	if (!hardlink) {
-		err = ovl_set_upper_acl(newdentry, XATTR_NAME_POSIX_ACL_ACCESS,
+		err = ovl_set_upper_acl(user_ns, newdentry, XATTR_NAME_POSIX_ACL_ACCESS,
 					acl);
 		if (err)
 			goto out_cleanup;
 
-		err = ovl_set_upper_acl(newdentry, XATTR_NAME_POSIX_ACL_DEFAULT,
+		err = ovl_set_upper_acl(user_ns, newdentry, XATTR_NAME_POSIX_ACL_DEFAULT,
 					default_acl);
 		if (err)
 			goto out_cleanup;
@@ -530,14 +543,14 @@ static int ovl_create_over_whiteout(struct dentry *dentry, struct inode *inode,
 		if (err)
 			goto out_cleanup;
 
-		err = ovl_do_rename(wdir, newdentry, udir, upper,
+		err = ovl_do_rename(wdir, user_ns, newdentry, udir, user_ns, upper,
 				    RENAME_EXCHANGE);
 		if (err)
 			goto out_cleanup;
 
-		ovl_cleanup(wdir, upper);
+		ovl_cleanup(user_ns, wdir, upper);
 	} else {
-		err = ovl_do_rename(wdir, newdentry, udir, upper, 0);
+		err = ovl_do_rename(wdir, user_ns, newdentry, udir, user_ns, upper, 0);
 		if (err)
 			goto out_cleanup;
 	}
@@ -556,7 +569,7 @@ static int ovl_create_over_whiteout(struct dentry *dentry, struct inode *inode,
 	return err;
 
 out_cleanup:
-	ovl_cleanup(wdir, newdentry);
+	ovl_cleanup(user_ns, wdir, newdentry);
 	dput(newdentry);
 	goto out_dput;
 }
@@ -762,8 +775,9 @@ static int ovl_remove_and_whiteout(struct dentry *dentry,
 	if (err)
 		goto out_dput;
 
-	upper = lookup_one_len(dentry->d_name.name, upperdir,
-			       dentry->d_name.len);
+	upper = lookup_one_len_mapped(dentry->d_name.name, upperdir,
+				  dentry->d_name.len,
+				  ovl_upper_mnt_user_ns(ofs));
 	err = PTR_ERR(upper);
 	if (IS_ERR(upper))
 		goto out_unlock;
@@ -797,6 +811,7 @@ static int ovl_remove_upper(struct dentry *dentry, bool is_dir,
 {
 	struct dentry *upperdir = ovl_dentry_upper(dentry->d_parent);
 	struct inode *dir = upperdir->d_inode;
+	struct user_namespace *user_ns = ovl_dentry_mnt_user_ns(dentry->d_parent);
 	struct dentry *upper;
 	struct dentry *opaquedir = NULL;
 	int err;
@@ -809,8 +824,8 @@ static int ovl_remove_upper(struct dentry *dentry, bool is_dir,
 	}
 
 	inode_lock_nested(dir, I_MUTEX_PARENT);
-	upper = lookup_one_len(dentry->d_name.name, upperdir,
-			       dentry->d_name.len);
+	upper = lookup_one_len_mapped(dentry->d_name.name, upperdir,
+				  dentry->d_name.len, user_ns);
 	err = PTR_ERR(upper);
 	if (IS_ERR(upper))
 		goto out_unlock;
@@ -821,9 +836,9 @@ static int ovl_remove_upper(struct dentry *dentry, bool is_dir,
 		goto out_dput_upper;
 
 	if (is_dir)
-		err = vfs_rmdir(dir, upper);
+		err = vfs_mapped_rmdir(user_ns, dir, upper);
 	else
-		err = vfs_unlink(dir, upper, NULL);
+		err = vfs_mapped_unlink(user_ns, dir, upper, NULL);
 	ovl_dir_modified(dentry->d_parent, ovl_type_origin(dentry));
 
 	/*
@@ -920,7 +935,8 @@ static int ovl_do_remove(struct dentry *dentry, bool is_dir)
 	 */
 	upperdentry = ovl_dentry_upper(dentry);
 	if (upperdentry)
-		ovl_copyattr(d_inode(upperdentry), d_inode(dentry));
+		ovl_copyattr(ovl_inode_real_user_ns(d_inode(dentry)),
+			     d_inode(upperdentry), d_inode(dentry));
 
 out_drop_write:
 	ovl_drop_write(dentry);
@@ -1078,6 +1094,7 @@ static int ovl_rename(struct inode *olddir, struct dentry *old,
 	struct dentry *new_upperdir;
 	struct dentry *olddentry;
 	struct dentry *newdentry;
+	struct user_namespace *old_user_ns, *new_user_ns;
 	struct dentry *trap;
 	bool old_opaque;
 	bool new_opaque;
@@ -1181,10 +1198,12 @@ static int ovl_rename(struct inode *olddir, struct dentry *old,
 		}
 	}
 
+	old_user_ns = ovl_dentry_mnt_user_ns(old->d_parent);
+	new_user_ns = ovl_dentry_mnt_user_ns(new->d_parent);
 	trap = lock_rename(new_upperdir, old_upperdir);
 
-	olddentry = lookup_one_len(old->d_name.name, old_upperdir,
-				   old->d_name.len);
+	olddentry = lookup_one_len_mapped(old->d_name.name, old_upperdir,
+				      old->d_name.len, old_user_ns);
 	err = PTR_ERR(olddentry);
 	if (IS_ERR(olddentry))
 		goto out_unlock;
@@ -1193,8 +1212,8 @@ static int ovl_rename(struct inode *olddir, struct dentry *old,
 	if (!ovl_matches_upper(old, olddentry))
 		goto out_dput_old;
 
-	newdentry = lookup_one_len(new->d_name.name, new_upperdir,
-				   new->d_name.len);
+	newdentry = lookup_one_len_mapped(new->d_name.name, new_upperdir,
+				      new->d_name.len, new_user_ns);
 	err = PTR_ERR(newdentry);
 	if (IS_ERR(newdentry))
 		goto out_dput_old;
@@ -1241,13 +1260,13 @@ static int ovl_rename(struct inode *olddir, struct dentry *old,
 	if (err)
 		goto out_dput;
 
-	err = ovl_do_rename(old_upperdir->d_inode, olddentry,
-			    new_upperdir->d_inode, newdentry, flags);
+	err = ovl_do_rename(old_upperdir->d_inode, old_user_ns, olddentry,
+			    new_upperdir->d_inode, new_user_ns, newdentry, flags);
 	if (err)
 		goto out_dput;
 
 	if (cleanup_whiteout)
-		ovl_cleanup(old_upperdir->d_inode, newdentry);
+		ovl_cleanup(old_user_ns, old_upperdir->d_inode, newdentry);
 
 	if (overwrite && d_inode(new)) {
 		if (new_is_dir)
@@ -1262,9 +1281,9 @@ static int ovl_rename(struct inode *olddir, struct dentry *old,
 			 (d_inode(new) && ovl_type_origin(new)));
 
 	/* copy ctime: */
-	ovl_copyattr(d_inode(olddentry), d_inode(old));
+	ovl_copyattr(old_user_ns, d_inode(olddentry), d_inode(old));
 	if (d_inode(new) && ovl_dentry_upper(new))
-		ovl_copyattr(d_inode(newdentry), d_inode(new));
+		ovl_copyattr(new_user_ns, d_inode(newdentry), d_inode(new));
 
 out_dput:
 	dput(newdentry);
diff --git a/fs/overlayfs/export.c b/fs/overlayfs/export.c
index ed35be3fafc6..15620ddc458d 100644
--- a/fs/overlayfs/export.c
+++ b/fs/overlayfs/export.c
@@ -389,7 +389,8 @@ static struct dentry *ovl_lookup_real_one(struct dentry *connected,
 	 * pointer because we hold no lock on the real dentry.
 	 */
 	take_dentry_name_snapshot(&name, real);
-	this = lookup_one_len(name.name.name, connected, name.name.len);
+	this = lookup_one_len_mapped(name.name.name, connected, name.name.len,
+				 mnt_user_ns(layer->mnt));
 	err = PTR_ERR(this);
 	if (IS_ERR(this)) {
 		goto fail;
diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index efccb7c1f9bc..a685c73b684a 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -40,6 +40,8 @@ static struct file *ovl_open_realfile(const struct file *file,
 				      struct inode *realinode)
 {
 	struct inode *inode = file_inode(file);
+	struct path realpath;
+	struct user_namespace *user_ns;
 	struct file *realfile;
 	const struct cred *old_cred;
 	int flags = file->f_flags | OVL_OPEN_FLAGS;
@@ -49,11 +51,13 @@ static struct file *ovl_open_realfile(const struct file *file,
 	if (flags & O_APPEND)
 		acc_mode |= MAY_APPEND;
 
+	ovl_path_real(file_dentry(file), &realpath);
+	user_ns = mnt_user_ns(realpath.mnt);
 	old_cred = ovl_override_creds(inode->i_sb);
-	err = inode_permission(realinode, MAY_OPEN | acc_mode);
+	err = mapped_inode_permission(user_ns, realinode, MAY_OPEN | acc_mode);
 	if (err) {
 		realfile = ERR_PTR(err);
-	} else if (!inode_owner_or_capable(realinode)) {
+	} else if (!mapped_inode_owner_or_capable(user_ns, realinode)) {
 		realfile = ERR_PTR(-EPERM);
 	} else {
 		realfile = open_with_fake_path(&file->f_path, flags, realinode,
@@ -269,7 +273,8 @@ static void ovl_aio_cleanup_handler(struct ovl_aio_req *aio_req)
 		__sb_writers_acquired(file_inode(iocb->ki_filp)->i_sb,
 				      SB_FREEZE_WRITE);
 		file_end_write(iocb->ki_filp);
-		ovl_copyattr(ovl_inode_real(inode), inode);
+		ovl_copyattr(ovl_inode_real_user_ns(inode),
+			     ovl_inode_real(inode), inode);
 	}
 
 	orig_iocb->ki_pos = iocb->ki_pos;
@@ -345,7 +350,7 @@ static ssize_t ovl_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 
 	inode_lock(inode);
 	/* Update mode */
-	ovl_copyattr(ovl_inode_real(inode), inode);
+	ovl_copyattr(ovl_inode_real_user_ns(inode), ovl_inode_real(inode), inode);
 	ret = file_remove_privs(file);
 	if (ret)
 		goto out_unlock;
@@ -364,7 +369,8 @@ static ssize_t ovl_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 				     ovl_iocb_to_rwf(ifl));
 		file_end_write(real.file);
 		/* Update size */
-		ovl_copyattr(ovl_inode_real(inode), inode);
+		ovl_copyattr(ovl_inode_real_user_ns(inode),
+			     ovl_inode_real(inode), inode);
 	} else {
 		struct ovl_aio_req *aio_req;
 
@@ -511,7 +517,7 @@ static long ovl_fallocate(struct file *file, int mode, loff_t offset, loff_t len
 	revert_creds(old_cred);
 
 	/* Update size */
-	ovl_copyattr(ovl_inode_real(inode), inode);
+	ovl_copyattr(ovl_inode_real_user_ns(inode), ovl_inode_real(inode), inode);
 
 	fdput(real);
 
@@ -582,7 +588,7 @@ static long ovl_ioctl_set_flags(struct file *file, unsigned int cmd,
 	struct inode *inode = file_inode(file);
 	unsigned int oldflags;
 
-	if (!inode_owner_or_capable(inode))
+	if (!mapped_inode_owner_or_capable(mnt_user_ns(file->f_path.mnt), inode))
 		return -EACCES;
 
 	ret = mnt_want_write_file(file);
@@ -744,7 +750,8 @@ static loff_t ovl_copyfile(struct file *file_in, loff_t pos_in,
 	revert_creds(old_cred);
 
 	/* Update size */
-	ovl_copyattr(ovl_inode_real(inode_out), inode_out);
+	ovl_copyattr(ovl_inode_real_user_ns(inode_out),
+		     ovl_inode_real(inode_out), inode_out);
 
 	fdput(real_in);
 	fdput(real_out);
diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index b584dca845ba..b6c8b904f0e7 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -9,6 +9,7 @@
 #include <linux/cred.h>
 #include <linux/xattr.h>
 #include <linux/posix_acl.h>
+#include <linux/posix_acl_xattr.h>
 #include <linux/ratelimit.h>
 #include <linux/fiemap.h>
 #include "overlayfs.h"
@@ -46,6 +47,7 @@ int ovl_setattr(struct dentry *dentry, struct iattr *attr)
 		err = ovl_copy_up_with_data(dentry);
 	if (!err) {
 		struct inode *winode = NULL;
+		struct user_namespace *upper_user_ns;
 
 		upperdentry = ovl_dentry_upper(dentry);
 
@@ -77,12 +79,20 @@ int ovl_setattr(struct dentry *dentry, struct iattr *attr)
 		 */
 		attr->ia_valid &= ~ATTR_OPEN;
 
+		upper_user_ns = ovl_upper_mnt_user_ns(OVL_FS(dentry->d_sb));
+
+		if (attr->ia_valid & ATTR_UID)
+			attr->ia_uid = kuid_from_mnt(upper_user_ns, attr->ia_uid);
+		if (attr->ia_valid & ATTR_GID)
+			attr->ia_gid = kgid_from_mnt(upper_user_ns, attr->ia_gid);
+
 		inode_lock(upperdentry->d_inode);
 		old_cred = ovl_override_creds(dentry->d_sb);
-		err = notify_change(upperdentry, attr, NULL);
+		err = notify_mapped_change(upper_user_ns, upperdentry, attr, NULL);
 		revert_creds(old_cred);
 		if (!err)
-			ovl_copyattr(upperdentry->d_inode, dentry->d_inode);
+			ovl_copyattr(upper_user_ns, upperdentry->d_inode,
+				     dentry->d_inode);
 		inode_unlock(upperdentry->d_inode);
 
 		if (winode)
@@ -281,6 +291,7 @@ int ovl_permission(struct inode *inode, int mask)
 {
 	struct inode *upperinode = ovl_inode_upper(inode);
 	struct inode *realinode = upperinode ?: ovl_inode_lower(inode);
+	struct user_namespace *user_ns;
 	const struct cred *old_cred;
 	int err;
 
@@ -290,6 +301,11 @@ int ovl_permission(struct inode *inode, int mask)
 		return -ECHILD;
 	}
 
+	if (upperinode)
+		user_ns = ovl_upper_mnt_user_ns(OVL_FS(inode->i_sb));
+	else
+		user_ns = OVL_I(inode)->lower_user_ns;
+
 	/*
 	 * Check overlay inode with the creds of task and underlying inode
 	 * with creds of mounter
@@ -298,6 +314,7 @@ int ovl_permission(struct inode *inode, int mask)
 	if (err)
 		return err;
 
+	/* Handle idmapped lower mounts. */
 	old_cred = ovl_override_creds(inode->i_sb);
 	if (!upperinode &&
 	    !special_file(realinode->i_mode) && mask & MAY_WRITE) {
@@ -305,7 +322,7 @@ int ovl_permission(struct inode *inode, int mask)
 		/* Make sure mounter can read file for copy up later */
 		mask |= MAY_READ;
 	}
-	err = inode_permission(realinode, mask);
+	err = mapped_inode_permission(user_ns, realinode, mask);
 	revert_creds(old_cred);
 
 	return err;
@@ -337,16 +354,23 @@ int ovl_xattr_set(struct dentry *dentry, struct inode *inode, const char *name,
 		  const void *value, size_t size, int flags)
 {
 	int err;
+	void *val = NULL;
 	struct dentry *upperdentry = ovl_i_dentry_upper(inode);
 	struct dentry *realdentry = upperdentry ?: ovl_dentry_lower(dentry);
+	struct user_namespace *user_ns;
 	const struct cred *old_cred;
 
 	err = ovl_want_write(dentry);
 	if (err)
 		goto out;
 
+	if (upperdentry)
+		user_ns = ovl_upper_mnt_user_ns(OVL_FS(inode->i_sb));
+	else
+		user_ns = OVL_I(inode)->lower_user_ns;
+
 	if (!value && !upperdentry) {
-		err = vfs_getxattr(realdentry, name, NULL, 0);
+		err = vfs_mapped_getxattr(user_ns, realdentry, name, NULL, 0);
 		if (err < 0)
 			goto out_drop_write;
 	}
@@ -360,19 +384,34 @@ int ovl_xattr_set(struct dentry *dentry, struct inode *inode, const char *name,
 	}
 
 	old_cred = ovl_override_creds(dentry->d_sb);
-	if (value)
-		err = vfs_setxattr(realdentry, name, value, size, flags);
-	else {
+	if (value) {
+		val = kmalloc(size, GFP_KERNEL);
+		if (!val)
+			goto out_drop_write;
+		memcpy(val, value, size);
+
+		if ((strcmp(name, XATTR_NAME_POSIX_ACL_ACCESS) == 0) ||
+		    (strcmp(name, XATTR_NAME_POSIX_ACL_DEFAULT) == 0))
+			posix_acl_fix_xattr_from_user(user_ns, val, size);
+		else if (strcmp(name, XATTR_NAME_CAPS) == 0) {
+			err = cap_convert_nscap(user_ns, realdentry, &val, size);
+			if (err < 0)
+				goto out_drop_write;
+			size = err;
+		}
+		err = vfs_mapped_setxattr(user_ns, realdentry, name, val, size, flags);
+	} else {
 		WARN_ON(flags != XATTR_REPLACE);
-		err = vfs_removexattr(realdentry, name);
+		err = vfs_mapped_removexattr(user_ns, realdentry, name);
 	}
 	revert_creds(old_cred);
 
 	/* copy c/mtime */
-	ovl_copyattr(d_inode(realdentry), inode);
+	ovl_copyattr(user_ns, d_inode(realdentry), inode);
 
 out_drop_write:
 	ovl_drop_write(dentry);
+	kfree(val);
 out:
 	return err;
 }
@@ -382,11 +421,22 @@ int ovl_xattr_get(struct dentry *dentry, struct inode *inode, const char *name,
 {
 	ssize_t res;
 	const struct cred *old_cred;
-	struct dentry *realdentry =
-		ovl_i_dentry_upper(inode) ?: ovl_dentry_lower(dentry);
+	struct dentry *realdentry = ovl_i_dentry_upper(inode);
+	struct user_namespace *user_ns;
+
+
+	if (realdentry) {
+		user_ns = ovl_upper_mnt_user_ns(OVL_FS(inode->i_sb));
+	} else {
+		realdentry = ovl_dentry_lower(dentry);
+		user_ns = OVL_I(inode)->lower_user_ns;
+	}
 
 	old_cred = ovl_override_creds(dentry->d_sb);
-	res = vfs_getxattr(realdentry, name, value, size);
+	res = vfs_mapped_getxattr(user_ns, realdentry, name, value, size);
+	if ((strcmp(name, XATTR_NAME_POSIX_ACL_ACCESS) == 0) ||
+	    (strcmp(name, XATTR_NAME_POSIX_ACL_DEFAULT) == 0))
+		posix_acl_fix_xattr_to_user(user_ns, value, size);
 	revert_creds(old_cred);
 	return res;
 }
@@ -634,13 +684,15 @@ void ovl_inode_init(struct inode *inode, struct ovl_inode_params *oip,
 
 	if (oip->upperdentry)
 		OVL_I(inode)->__upperdentry = oip->upperdentry;
-	if (oip->lowerpath && oip->lowerpath->dentry)
+	if (oip->lowerpath && oip->lowerpath->dentry) {
 		OVL_I(inode)->lower = igrab(d_inode(oip->lowerpath->dentry));
+		OVL_I(inode)->lower_user_ns = get_user_ns(mnt_user_ns(oip->lowerpath->layer->mnt));
+	}
 	if (oip->lowerdata)
 		OVL_I(inode)->lowerdata = igrab(d_inode(oip->lowerdata));
 
 	realinode = ovl_inode_real(inode);
-	ovl_copyattr(realinode, inode);
+	ovl_copyattr(ovl_inode_real_user_ns(inode), realinode, inode);
 	ovl_copyflags(realinode, inode);
 	ovl_map_ino(inode, ino, fsid);
 }
@@ -751,8 +803,8 @@ unsigned int ovl_get_nlink(struct ovl_fs *ofs, struct dentry *lowerdentry,
 	if (!lowerdentry || !upperdentry || d_inode(lowerdentry)->i_nlink == 1)
 		return fallback;
 
-	err = ovl_do_getxattr(ofs, upperdentry, OVL_XATTR_NLINK,
-			      &buf, sizeof(buf) - 1);
+	err = ovl_do_getxattr(ofs, ovl_upper_mnt_user_ns(ofs), upperdentry,
+			      OVL_XATTR_NLINK, &buf, sizeof(buf) - 1);
 	if (err < 0)
 		goto fail;
 
@@ -956,6 +1008,7 @@ struct inode *ovl_get_inode(struct super_block *sb,
 	struct inode *realinode = upperdentry ? d_inode(upperdentry) : NULL;
 	struct inode *inode;
 	struct dentry *lowerdentry = lowerpath ? lowerpath->dentry : NULL;
+	struct user_namespace *user_ns = ovl_upper_mnt_user_ns(OVL_FS(sb));
 	bool bylower = ovl_hash_bylower(sb, upperdentry, lowerdentry,
 					oip->index);
 	int fsid = bylower ? lowerpath->layer->fsid : 0;
@@ -1028,8 +1081,10 @@ struct inode *ovl_get_inode(struct super_block *sb,
 
 	/* Check for non-merge dir that may have whiteouts */
 	if (is_dir) {
+		if (!upperdentry)
+			user_ns = mnt_user_ns(lowerpath->layer->mnt);
 		if (((upperdentry && lowerdentry) || oip->numlower > 1) ||
-		    ovl_check_origin_xattr(ofs, upperdentry ?: lowerdentry)) {
+		    ovl_check_origin_xattr(ofs, user_ns, upperdentry ?: lowerdentry)) {
 			ovl_set_flag(OVL_WHITEOUTS, inode);
 		}
 	}
diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
index a6162c4076db..4a5e9ef6524b 100644
--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -25,14 +25,15 @@ struct ovl_lookup_data {
 	bool metacopy;
 };
 
-static int ovl_check_redirect(struct dentry *dentry, struct ovl_lookup_data *d,
+static int ovl_check_redirect(struct user_namespace *mnt_user_ns,
+			      struct dentry *dentry, struct ovl_lookup_data *d,
 			      size_t prelen, const char *post)
 {
 	int res;
 	char *buf;
 	struct ovl_fs *ofs = OVL_FS(d->sb);
 
-	buf = ovl_get_redirect_xattr(ofs, dentry, prelen + strlen(post));
+	buf = ovl_get_redirect_xattr(ofs, mnt_user_ns, dentry, prelen + strlen(post));
 	if (IS_ERR_OR_NULL(buf))
 		return PTR_ERR(buf);
 
@@ -110,8 +111,9 @@ static struct ovl_fh *ovl_get_fh(struct ovl_fs *ofs, struct dentry *dentry,
 {
 	int res, err;
 	struct ovl_fh *fh = NULL;
+	struct user_namespace *user_ns = ovl_upper_mnt_user_ns(ofs);
 
-	res = ovl_do_getxattr(ofs, dentry, ox, NULL, 0);
+	res = ovl_do_getxattr(ofs, user_ns, dentry, ox, NULL, 0);
 	if (res < 0) {
 		if (res == -ENODATA || res == -EOPNOTSUPP)
 			return NULL;
@@ -125,7 +127,7 @@ static struct ovl_fh *ovl_get_fh(struct ovl_fs *ofs, struct dentry *dentry,
 	if (!fh)
 		return ERR_PTR(-ENOMEM);
 
-	res = ovl_do_getxattr(ofs, dentry, ox, fh->buf, res);
+	res = ovl_do_getxattr(ofs, user_ns, dentry, ox, fh->buf, res);
 	if (res < 0)
 		goto fail;
 
@@ -188,16 +190,19 @@ struct dentry *ovl_decode_real_fh(struct ovl_fh *fh, struct vfsmount *mnt,
 	return real;
 }
 
-static bool ovl_is_opaquedir(struct super_block *sb, struct dentry *dentry)
+static bool ovl_is_opaquedir(struct super_block *sb,
+			     struct user_namespace *user_ns,
+			     struct dentry *dentry)
 {
-	return ovl_check_dir_xattr(sb, dentry, OVL_XATTR_OPAQUE);
+	return ovl_check_dir_xattr(sb, user_ns, dentry, OVL_XATTR_OPAQUE);
 }
 
 static struct dentry *ovl_lookup_positive_unlocked(const char *name,
 						   struct dentry *base, int len,
-						   bool drop_negative)
+						   bool drop_negative,
+						   struct user_namespace *mnt_user_ns)
 {
-	struct dentry *ret = lookup_one_len_unlocked(name, base, len);
+	struct dentry *ret = lookup_one_len_mapped_unlocked(name, base, len, mnt_user_ns);
 
 	if (!IS_ERR(ret) && d_flags_negative(smp_load_acquire(&ret->d_flags))) {
 		if (drop_negative && ret->d_lockref.count == 1) {
@@ -216,13 +221,14 @@ static struct dentry *ovl_lookup_positive_unlocked(const char *name,
 static int ovl_lookup_single(struct dentry *base, struct ovl_lookup_data *d,
 			     const char *name, unsigned int namelen,
 			     size_t prelen, const char *post,
-			     struct dentry **ret, bool drop_negative)
+			     struct dentry **ret, bool drop_negative,
+			     struct user_namespace *mnt_user_ns)
 {
 	struct dentry *this;
 	int err;
 	bool last_element = !post[0];
 
-	this = ovl_lookup_positive_unlocked(name, base, namelen, drop_negative);
+	this = ovl_lookup_positive_unlocked(name, base, namelen, drop_negative, mnt_user_ns);
 	if (IS_ERR(this)) {
 		err = PTR_ERR(this);
 		this = NULL;
@@ -253,7 +259,7 @@ static int ovl_lookup_single(struct dentry *base, struct ovl_lookup_data *d,
 			d->stop = true;
 			goto put_and_out;
 		}
-		err = ovl_check_metacopy_xattr(OVL_FS(d->sb), this);
+		err = ovl_check_metacopy_xattr(OVL_FS(d->sb), mnt_user_ns, this);
 		if (err < 0)
 			goto out_err;
 
@@ -273,14 +279,14 @@ static int ovl_lookup_single(struct dentry *base, struct ovl_lookup_data *d,
 		if (d->last)
 			goto out;
 
-		if (ovl_is_opaquedir(d->sb, this)) {
+		if (ovl_is_opaquedir(d->sb, mnt_user_ns, this)) {
 			d->stop = true;
 			if (last_element)
 				d->opaque = true;
 			goto out;
 		}
 	}
-	err = ovl_check_redirect(this, d, prelen, post);
+	err = ovl_check_redirect(mnt_user_ns, this, d, prelen, post);
 	if (err)
 		goto out_err;
 out:
@@ -298,7 +304,8 @@ static int ovl_lookup_single(struct dentry *base, struct ovl_lookup_data *d,
 }
 
 static int ovl_lookup_layer(struct dentry *base, struct ovl_lookup_data *d,
-			    struct dentry **ret, bool drop_negative)
+			    struct dentry **ret, bool drop_negative,
+			    struct user_namespace *mnt_user_ns)
 {
 	/* Counting down from the end, since the prefix can change */
 	size_t rem = d->name.len - 1;
@@ -307,7 +314,7 @@ static int ovl_lookup_layer(struct dentry *base, struct ovl_lookup_data *d,
 
 	if (d->name.name[0] != '/')
 		return ovl_lookup_single(base, d, d->name.name, d->name.len,
-					 0, "", ret, drop_negative);
+					 0, "", ret, drop_negative, mnt_user_ns);
 
 	while (!IS_ERR_OR_NULL(base) && d_can_lookup(base)) {
 		const char *s = d->name.name + d->name.len - rem;
@@ -321,7 +328,7 @@ static int ovl_lookup_layer(struct dentry *base, struct ovl_lookup_data *d,
 
 		err = ovl_lookup_single(base, d, s, thislen,
 					d->name.len - rem, next, &base,
-					drop_negative);
+					drop_negative, mnt_user_ns);
 		dput(dentry);
 		if (err)
 			return err;
@@ -666,7 +673,8 @@ struct dentry *ovl_get_index_fh(struct ovl_fs *ofs, struct ovl_fh *fh)
 	if (err)
 		return ERR_PTR(err);
 
-	index = lookup_positive_unlocked(name.name, ofs->indexdir, name.len);
+	index = lookup_positive_mapped_unlocked(name.name, ofs->indexdir, name.len,
+					    ovl_upper_mnt_user_ns(ofs));
 	kfree(name.name);
 	if (IS_ERR(index)) {
 		if (PTR_ERR(index) == -ENOENT)
@@ -698,7 +706,8 @@ struct dentry *ovl_lookup_index(struct ovl_fs *ofs, struct dentry *upper,
 	if (err)
 		return ERR_PTR(err);
 
-	index = lookup_positive_unlocked(name.name, ofs->indexdir, name.len);
+	index = lookup_positive_mapped_unlocked(name.name, ofs->indexdir, name.len,
+					    ovl_upper_mnt_user_ns(ofs));
 	if (IS_ERR(index)) {
 		err = PTR_ERR(index);
 		if (err == -ENOENT) {
@@ -798,7 +807,7 @@ static int ovl_fix_origin(struct ovl_fs *ofs, struct dentry *dentry,
 {
 	int err;
 
-	if (ovl_check_origin_xattr(ofs, upper))
+	if (ovl_check_origin_xattr(ofs, ovl_upper_mnt_user_ns(ofs), upper))
 		return 0;
 
 	err = ovl_want_write(dentry);
@@ -818,6 +827,7 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 {
 	struct ovl_entry *oe;
 	const struct cred *old_cred;
+	struct user_namespace *user_ns;
 	struct ovl_fs *ofs = dentry->d_sb->s_fs_info;
 	struct ovl_entry *poe = dentry->d_parent->d_fsdata;
 	struct ovl_entry *roe = dentry->d_sb->s_root->d_fsdata;
@@ -850,7 +860,8 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 	old_cred = ovl_override_creds(dentry->d_sb);
 	upperdir = ovl_dentry_upper(dentry->d_parent);
 	if (upperdir) {
-		err = ovl_lookup_layer(upperdir, &d, &upperdentry, true);
+		user_ns = ovl_upper_mnt_user_ns(ofs);
+		err = ovl_lookup_layer(upperdir, &d, &upperdentry, true, user_ns);
 		if (err)
 			goto out;
 
@@ -905,7 +916,8 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 		else
 			d.last = lower.layer->idx == roe->numlower;
 
-		err = ovl_lookup_layer(lower.dentry, &d, &this, false);
+		user_ns = mnt_user_ns(lower.layer->mnt);
+		err = ovl_lookup_layer(lower.dentry, &d, &this, false, user_ns);
 		if (err)
 			goto out_put;
 
@@ -1062,14 +1074,15 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 	if (upperdentry)
 		ovl_dentry_set_upper_alias(dentry);
 	else if (index) {
+		struct user_namespace *upper_user_ns = ovl_upper_mnt_user_ns(ofs);
 		upperdentry = dget(index);
-		upperredirect = ovl_get_redirect_xattr(ofs, upperdentry, 0);
+		upperredirect = ovl_get_redirect_xattr(ofs, upper_user_ns, upperdentry, 0);
 		if (IS_ERR(upperredirect)) {
 			err = PTR_ERR(upperredirect);
 			upperredirect = NULL;
 			goto out_free_oe;
 		}
-		err = ovl_check_metacopy_xattr(ofs, upperdentry);
+		err = ovl_check_metacopy_xattr(ofs, upper_user_ns, upperdentry);
 		if (err < 0)
 			goto out_free_oe;
 		uppermetacopy = err;
@@ -1153,9 +1166,10 @@ bool ovl_lower_positive(struct dentry *dentry)
 	for (i = 0; !done && !positive && i < poe->numlower; i++) {
 		struct dentry *this;
 		struct dentry *lowerdir = poe->lowerstack[i].dentry;
+		struct user_namespace *user_ns = mnt_user_ns(poe->lowerstack[i].layer->mnt);
 
-		this = lookup_positive_unlocked(name->name, lowerdir,
-					       name->len);
+		this = lookup_positive_mapped_unlocked(name->name, lowerdir,
+						   name->len, user_ns);
 		if (IS_ERR(this)) {
 			switch (PTR_ERR(this)) {
 			case -ENOENT:
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 30ee48ddfaa2..63c257c3bfa8 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -7,6 +7,7 @@
 #include <linux/kernel.h>
 #include <linux/uuid.h>
 #include <linux/fs.h>
+#include <linux/mount.h>
 #include "ovl_entry.h"
 
 #undef pr_fmt
@@ -119,72 +120,90 @@ static inline const char *ovl_xattr(struct ovl_fs *ofs, enum ovl_xattr ox)
 	return ovl_xattr_table[ox];
 }
 
-static inline int ovl_do_rmdir(struct inode *dir, struct dentry *dentry)
+static inline struct user_namespace *ovl_upper_mnt_user_ns(struct ovl_fs *ofs)
 {
-	int err = vfs_rmdir(dir, dentry);
+	return mnt_user_ns(ovl_upper_mnt(ofs));
+}
+
+static inline struct user_namespace *ovl_dentry_mnt_user_ns(struct dentry *dentry)
+{
+	return mnt_user_ns(ovl_upper_mnt(OVL_FS(dentry->d_sb)));
+}
+
+static inline int ovl_do_rmdir(struct user_namespace *user_ns,
+			       struct inode *dir, struct dentry *dentry)
+{
+	int err = vfs_mapped_rmdir(user_ns, dir, dentry);
 
 	pr_debug("rmdir(%pd2) = %i\n", dentry, err);
 	return err;
 }
 
-static inline int ovl_do_unlink(struct inode *dir, struct dentry *dentry)
+static inline int ovl_do_unlink(struct user_namespace *user_ns,
+				struct inode *dir, struct dentry *dentry)
 {
-	int err = vfs_unlink(dir, dentry, NULL);
+	int err = vfs_mapped_unlink(user_ns, dir, dentry, NULL);
 
 	pr_debug("unlink(%pd2) = %i\n", dentry, err);
 	return err;
 }
 
-static inline int ovl_do_link(struct dentry *old_dentry, struct inode *dir,
+static inline int ovl_do_link(struct user_namespace *user_ns,
+			      struct dentry *old_dentry, struct inode *dir,
 			      struct dentry *new_dentry)
 {
-	int err = vfs_link(old_dentry, dir, new_dentry, NULL);
+	int err = vfs_mapped_link(old_dentry, user_ns, dir, new_dentry, NULL);
 
 	pr_debug("link(%pd2, %pd2) = %i\n", old_dentry, new_dentry, err);
 	return err;
 }
 
-static inline int ovl_do_create(struct inode *dir, struct dentry *dentry,
+static inline int ovl_do_create(struct user_namespace *user_ns,
+				struct inode *dir, struct dentry *dentry,
 				umode_t mode)
 {
-	int err = vfs_create(dir, dentry, mode, true);
+	int err = vfs_mapped_create(user_ns, dir, dentry, mode, true);
 
 	pr_debug("create(%pd2, 0%o) = %i\n", dentry, mode, err);
 	return err;
 }
 
-static inline int ovl_do_mkdir(struct inode *dir, struct dentry *dentry,
+static inline int ovl_do_mkdir(struct user_namespace *user_ns,
+			       struct inode *dir, struct dentry *dentry,
 			       umode_t mode)
 {
-	int err = vfs_mkdir(dir, dentry, mode);
+	int err = vfs_mapped_mkdir(user_ns, dir, dentry, mode);
 	pr_debug("mkdir(%pd2, 0%o) = %i\n", dentry, mode, err);
 	return err;
 }
 
-static inline int ovl_do_mknod(struct inode *dir, struct dentry *dentry,
+static inline int ovl_do_mknod(struct user_namespace *user_ns,
+			       struct inode *dir, struct dentry *dentry,
 			       umode_t mode, dev_t dev)
 {
-	int err = vfs_mknod(dir, dentry, mode, dev);
+	int err = vfs_mapped_mknod(user_ns, dir, dentry, mode, dev);
 
 	pr_debug("mknod(%pd2, 0%o, 0%o) = %i\n", dentry, mode, dev, err);
 	return err;
 }
 
-static inline int ovl_do_symlink(struct inode *dir, struct dentry *dentry,
+static inline int ovl_do_symlink(struct user_namespace *user_ns,
+				 struct inode *dir, struct dentry *dentry,
 				 const char *oldname)
 {
-	int err = vfs_symlink(dir, dentry, oldname);
+	int err = vfs_mapped_symlink(user_ns, dir, dentry, oldname);
 
 	pr_debug("symlink(\"%s\", %pd2) = %i\n", oldname, dentry, err);
 	return err;
 }
 
-static inline ssize_t ovl_do_getxattr(struct ovl_fs *ofs, struct dentry *dentry,
-				      enum ovl_xattr ox, void *value,
-				      size_t size)
+static inline ssize_t ovl_do_getxattr(struct ovl_fs *ofs,
+				      struct user_namespace *user_ns,
+				      struct dentry *dentry, enum ovl_xattr ox,
+				      void *value, size_t size)
 {
 	const char *name = ovl_xattr(ofs, ox);
-	return vfs_getxattr(dentry, name, value, size);
+	return vfs_mapped_getxattr(user_ns, dentry, name, value, size);
 }
 
 static inline int ovl_do_setxattr(struct ovl_fs *ofs, struct dentry *dentry,
@@ -192,7 +211,8 @@ static inline int ovl_do_setxattr(struct ovl_fs *ofs, struct dentry *dentry,
 				  size_t size)
 {
 	const char *name = ovl_xattr(ofs, ox);
-	int err = vfs_setxattr(dentry, name, value, size, 0);
+	struct user_namespace *user_ns = ovl_upper_mnt_user_ns(ofs);
+	int err = vfs_mapped_setxattr(user_ns, dentry, name, value, size, 0);
 	pr_debug("setxattr(%pd2, \"%s\", \"%*pE\", %zu, 0) = %i\n",
 		 dentry, name, min((int)size, 48), value, size, err);
 	return err;
@@ -202,19 +222,31 @@ static inline int ovl_do_removexattr(struct ovl_fs *ofs, struct dentry *dentry,
 				     enum ovl_xattr ox)
 {
 	const char *name = ovl_xattr(ofs, ox);
-	int err = vfs_removexattr(dentry, name);
+	struct user_namespace *user_ns = ovl_upper_mnt_user_ns(ofs);
+	int err = vfs_mapped_removexattr(user_ns, dentry, name);
 	pr_debug("removexattr(%pd2, \"%s\") = %i\n", dentry, name, err);
 	return err;
 }
 
-static inline int ovl_do_rename(struct inode *olddir, struct dentry *olddentry,
-				struct inode *newdir, struct dentry *newdentry,
-				unsigned int flags)
+static inline int ovl_do_rename(struct inode *olddir,
+				struct user_namespace *old_user_ns,
+				struct dentry *olddentry, struct inode *newdir,
+				struct user_namespace *new_user_ns,
+				struct dentry *newdentry, unsigned int flags)
 {
 	int err;
+	struct renamedata data = {
+		.old_dir	= olddir,
+		.old_dentry	= olddentry,
+		.old_user_ns	= old_user_ns,
+		.new_dir	= newdir,
+		.new_dentry	= newdentry,
+		.new_user_ns	= new_user_ns,
+		.flags		= flags,
+	};
 
 	pr_debug("rename(%pd2, %pd2, 0x%x)\n", olddentry, newdentry, flags);
-	err = vfs_rename(olddir, olddentry, newdir, newdentry, NULL, flags);
+	err = vfs_mapped_rename(&data);
 	if (err) {
 		pr_debug("...rename(%pd2, %pd2, ...) = %i\n",
 			 olddentry, newdentry, err);
@@ -222,16 +254,18 @@ static inline int ovl_do_rename(struct inode *olddir, struct dentry *olddentry,
 	return err;
 }
 
-static inline int ovl_do_whiteout(struct inode *dir, struct dentry *dentry)
+static inline int ovl_do_whiteout(struct user_namespace *user_ns,
+				  struct inode *dir, struct dentry *dentry)
 {
-	int err = vfs_whiteout(&init_user_ns, dir, dentry);
+	int err = vfs_whiteout(user_ns, dir, dentry);
 	pr_debug("whiteout(%pd2) = %i\n", dentry, err);
 	return err;
 }
 
-static inline struct dentry *ovl_do_tmpfile(struct dentry *dentry, umode_t mode)
+static inline struct dentry *ovl_do_tmpfile(struct user_namespace *user_ns,
+					    struct dentry *dentry, umode_t mode)
 {
-	struct dentry *ret = vfs_tmpfile(dentry, mode, 0);
+	struct dentry *ret = vfs_mapped_tmpfile(user_ns, dentry, mode, 0);
 	int err = PTR_ERR_OR_ZERO(ret);
 
 	pr_debug("tmpfile(%pd2, 0%o) = %i\n", dentry, mode, err);
@@ -301,9 +335,10 @@ struct file *ovl_path_open(struct path *path, int flags);
 int ovl_copy_up_start(struct dentry *dentry, int flags);
 void ovl_copy_up_end(struct dentry *dentry);
 bool ovl_already_copied_up(struct dentry *dentry, int flags);
-bool ovl_check_origin_xattr(struct ovl_fs *ofs, struct dentry *dentry);
-bool ovl_check_dir_xattr(struct super_block *sb, struct dentry *dentry,
-			 enum ovl_xattr ox);
+bool ovl_check_origin_xattr(struct ovl_fs *ofs, struct user_namespace *user_ns,
+			    struct dentry *dentry);
+bool ovl_check_dir_xattr(struct super_block *sb, struct user_namespace *user_ns,
+			 struct dentry *dentry, enum ovl_xattr ox);
 int ovl_check_setxattr(struct dentry *dentry, struct dentry *upperdentry,
 		       enum ovl_xattr ox, const void *value, size_t size,
 		       int xerr);
@@ -318,15 +353,17 @@ bool ovl_need_index(struct dentry *dentry);
 int ovl_nlink_start(struct dentry *dentry);
 void ovl_nlink_end(struct dentry *dentry);
 int ovl_lock_rename_workdir(struct dentry *workdir, struct dentry *upperdir);
-int ovl_check_metacopy_xattr(struct ovl_fs *ofs, struct dentry *dentry);
+int ovl_check_metacopy_xattr(struct ovl_fs *ofs, struct user_namespace *user_ns,
+			     struct dentry *dentry);
 bool ovl_is_metacopy_dentry(struct dentry *dentry);
-char *ovl_get_redirect_xattr(struct ovl_fs *ofs, struct dentry *dentry,
-			     int padding);
+char *ovl_get_redirect_xattr(struct ovl_fs *ofs, struct user_namespace *user_ns,
+			     struct dentry *dentry, int padding);
 
 static inline bool ovl_is_impuredir(struct super_block *sb,
 				    struct dentry *dentry)
 {
-	return ovl_check_dir_xattr(sb, dentry, OVL_XATTR_IMPURE);
+	return ovl_check_dir_xattr(sb, ovl_upper_mnt_user_ns(OVL_FS(sb)),
+				   dentry, OVL_XATTR_IMPURE);
 }
 
 /*
@@ -404,8 +441,7 @@ bool ovl_lower_positive(struct dentry *dentry);
 static inline int ovl_verify_origin(struct ovl_fs *ofs, struct dentry *upper,
 				    struct dentry *origin, bool set)
 {
-	return ovl_verify_set_fh(ofs, upper, OVL_XATTR_ORIGIN, origin,
-				 false, set);
+	return ovl_verify_set_fh(ofs, upper, OVL_XATTR_ORIGIN, origin, false, set);
 }
 
 static inline int ovl_verify_upper(struct ovl_fs *ofs, struct dentry *index,
@@ -418,7 +454,8 @@ static inline int ovl_verify_upper(struct ovl_fs *ofs, struct dentry *index,
 extern const struct file_operations ovl_dir_operations;
 struct file *ovl_dir_real_file(const struct file *file, bool want_upper);
 int ovl_check_empty_dir(struct dentry *dentry, struct list_head *list);
-void ovl_cleanup_whiteouts(struct dentry *upper, struct list_head *list);
+void ovl_cleanup_whiteouts(struct user_namespace *user_ns, struct dentry *upper,
+			   struct list_head *list);
 void ovl_cache_free(struct list_head *list);
 void ovl_dir_cache_free(struct inode *inode);
 int ovl_check_d_type_supported(struct path *realpath);
@@ -463,10 +500,11 @@ bool ovl_lookup_trap_inode(struct super_block *sb, struct dentry *dir);
 struct inode *ovl_get_trap_inode(struct super_block *sb, struct dentry *dir);
 struct inode *ovl_get_inode(struct super_block *sb,
 			    struct ovl_inode_params *oip);
-static inline void ovl_copyattr(struct inode *from, struct inode *to)
+static inline void ovl_copyattr(struct user_namespace *user_ns,
+				struct inode *from, struct inode *to)
 {
-	to->i_uid = from->i_uid;
-	to->i_gid = from->i_gid;
+	to->i_uid =  i_uid_into_mnt(user_ns, from);
+	to->i_gid =  i_gid_into_mnt(user_ns, from);
 	to->i_mode = from->i_mode;
 	to->i_atime = from->i_atime;
 	to->i_mtime = from->i_mtime;
@@ -474,6 +512,17 @@ static inline void ovl_copyattr(struct inode *from, struct inode *to)
 	i_size_write(to, i_size_read(from));
 }
 
+static inline struct user_namespace *ovl_inode_real_user_ns(struct inode *inode)
+{
+	struct inode *realinode;
+
+	realinode = ovl_inode_upper(inode);
+	if (realinode)
+		return ovl_upper_mnt_user_ns(OVL_FS(inode->i_sb));
+
+	return OVL_I(inode)->lower_user_ns;
+}
+
 static inline void ovl_copyflags(struct inode *from, struct inode *to)
 {
 	unsigned int mask = S_SYNC | S_IMMUTABLE | S_APPEND | S_NOATIME;
@@ -494,11 +543,15 @@ struct ovl_cattr {
 
 #define OVL_CATTR(m) (&(struct ovl_cattr) { .mode = (m) })
 
-struct dentry *ovl_create_real(struct inode *dir, struct dentry *newdentry,
+struct dentry *ovl_create_real(struct user_namespace *user_ns,
+			       struct inode *dir, struct dentry *newdentry,
 			       struct ovl_cattr *attr);
-int ovl_cleanup(struct inode *dir, struct dentry *dentry);
-struct dentry *ovl_lookup_temp(struct dentry *workdir);
-struct dentry *ovl_create_temp(struct dentry *workdir, struct ovl_cattr *attr);
+int ovl_cleanup(struct user_namespace *user_ns, struct inode *dir,
+		struct dentry *dentry);
+struct dentry *ovl_lookup_temp(struct user_namespace *user_ns,
+			       struct dentry *workdir);
+struct dentry *ovl_create_temp(struct user_namespace *user_ns,
+			       struct dentry *workdir, struct ovl_cattr *attr);
 
 /* file.c */
 extern const struct file_operations ovl_file_operations;
@@ -511,9 +564,11 @@ long ovl_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
 int ovl_copy_up(struct dentry *dentry);
 int ovl_copy_up_with_data(struct dentry *dentry);
 int ovl_maybe_copy_up(struct dentry *dentry, int flags);
-int ovl_copy_xattr(struct super_block *sb, struct dentry *old,
+int ovl_copy_xattr(struct super_block *sb, struct user_namespace *old_user_ns,
+		   struct dentry *old, struct user_namespace *new_user_ns,
 		   struct dentry *new);
-int ovl_set_attr(struct dentry *upper, struct kstat *stat);
+int ovl_set_attr(struct user_namespace *user_ns, struct dentry *upper,
+		 struct kstat *stat);
 struct ovl_fh *ovl_encode_real_fh(struct dentry *real, bool is_upper);
 int ovl_set_origin(struct dentry *dentry, struct dentry *lower,
 		   struct dentry *upper);
diff --git a/fs/overlayfs/ovl_entry.h b/fs/overlayfs/ovl_entry.h
index 1b5a2094df8e..c505605f27ee 100644
--- a/fs/overlayfs/ovl_entry.h
+++ b/fs/overlayfs/ovl_entry.h
@@ -126,6 +126,7 @@ struct ovl_inode {
 	struct inode vfs_inode;
 	struct dentry *__upperdentry;
 	struct inode *lower;
+	struct user_namespace *lower_user_ns;
 
 	/* synchronize copy up and more */
 	struct mutex lock;
diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index 01620ebae1bd..6927e4e93d44 100644
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -264,7 +264,8 @@ static int ovl_fill_merge(struct dir_context *ctx, const char *name,
 		return ovl_fill_lowest(rdd, name, namelen, offset, ino, d_type);
 }
 
-static int ovl_check_whiteouts(struct dentry *dir, struct ovl_readdir_data *rdd)
+static int ovl_check_whiteouts(struct user_namespace *user_ns,
+			       struct dentry *dir, struct ovl_readdir_data *rdd)
 {
 	int err;
 	struct ovl_cache_entry *p;
@@ -278,7 +279,7 @@ static int ovl_check_whiteouts(struct dentry *dir, struct ovl_readdir_data *rdd)
 		while (rdd->first_maybe_whiteout) {
 			p = rdd->first_maybe_whiteout;
 			rdd->first_maybe_whiteout = p->next_maybe_whiteout;
-			dentry = lookup_one_len(p->name, dir, p->len);
+			dentry = lookup_one_len_mapped(p->name, dir, p->len, user_ns);
 			if (!IS_ERR(dentry)) {
 				p->is_whiteout = ovl_is_whiteout(dentry);
 				dput(dentry);
@@ -312,7 +313,8 @@ static inline int ovl_dir_read(struct path *realpath,
 	} while (!err && rdd->count);
 
 	if (!err && rdd->first_maybe_whiteout && rdd->dentry)
-		err = ovl_check_whiteouts(realpath->dentry, rdd);
+		err = ovl_check_whiteouts(mnt_user_ns(realpath->mnt),
+					  realpath->dentry, rdd);
 
 	fput(realfile);
 
@@ -491,7 +493,7 @@ static int ovl_cache_update_ino(struct path *path, struct ovl_cache_entry *p)
 			goto get;
 		}
 	}
-	this = lookup_one_len(p->name, dir, p->len);
+	this = lookup_one_len_mapped(p->name, dir, p->len, mnt_user_ns(path->mnt));
 	if (IS_ERR_OR_NULL(this) || !this->d_inode) {
 		if (IS_ERR(this)) {
 			err = PTR_ERR(this);
@@ -1020,7 +1022,8 @@ int ovl_check_empty_dir(struct dentry *dentry, struct list_head *list)
 	return err;
 }
 
-void ovl_cleanup_whiteouts(struct dentry *upper, struct list_head *list)
+void ovl_cleanup_whiteouts(struct user_namespace *user_ns, struct dentry *upper,
+			   struct list_head *list)
 {
 	struct ovl_cache_entry *p;
 
@@ -1031,7 +1034,7 @@ void ovl_cleanup_whiteouts(struct dentry *upper, struct list_head *list)
 		if (WARN_ON(!p->is_whiteout || !p->is_upper))
 			continue;
 
-		dentry = lookup_one_len(p->name, upper, p->len);
+		dentry = lookup_one_len_mapped(p->name, upper, p->len, user_ns);
 		if (IS_ERR(dentry)) {
 			pr_err("lookup '%s/%.*s' failed (%i)\n",
 			       upper->d_name.name, p->len, p->name,
@@ -1039,7 +1042,7 @@ void ovl_cleanup_whiteouts(struct dentry *upper, struct list_head *list)
 			continue;
 		}
 		if (dentry->d_inode)
-			ovl_cleanup(upper->d_inode, dentry);
+			ovl_cleanup(user_ns, upper->d_inode, dentry);
 		dput(dentry);
 	}
 	inode_unlock(upper->d_inode);
@@ -1130,7 +1133,8 @@ static int ovl_workdir_cleanup_recurse(struct path *path, int level)
 			err = -EINVAL;
 			break;
 		}
-		dentry = lookup_one_len(p->name, path->dentry, p->len);
+		dentry = lookup_one_len_mapped(p->name, path->dentry, p->len,
+					   mnt_user_ns(path->mnt));
 		if (IS_ERR(dentry))
 			continue;
 		if (dentry->d_inode)
@@ -1149,12 +1153,13 @@ int ovl_workdir_cleanup(struct inode *dir, struct vfsmount *mnt,
 			 struct dentry *dentry, int level)
 {
 	int err;
+	struct user_namespace *user_ns = mnt_user_ns(mnt);
 
 	if (!d_is_dir(dentry) || level > 1) {
-		return ovl_cleanup(dir, dentry);
+		return ovl_cleanup(user_ns, dir, dentry);
 	}
 
-	err = ovl_do_rmdir(dir, dentry);
+	err = ovl_do_rmdir(user_ns, dir, dentry);
 	if (err) {
 		struct path path = { .mnt = mnt, .dentry = dentry };
 
@@ -1162,7 +1167,7 @@ int ovl_workdir_cleanup(struct inode *dir, struct vfsmount *mnt,
 		err = ovl_workdir_cleanup_recurse(&path, level + 1);
 		inode_lock_nested(dir, I_MUTEX_PARENT);
 		if (!err)
-			err = ovl_cleanup(dir, dentry);
+			err = ovl_cleanup(user_ns, dir, dentry);
 	}
 
 	return err;
@@ -1175,6 +1180,7 @@ int ovl_indexdir_cleanup(struct ovl_fs *ofs)
 	struct dentry *index = NULL;
 	struct inode *dir = indexdir->d_inode;
 	struct path path = { .mnt = ovl_upper_mnt(ofs), .dentry = indexdir };
+	struct user_namespace *user_ns = mnt_user_ns(path.mnt);
 	LIST_HEAD(list);
 	struct rb_root root = RB_ROOT;
 	struct ovl_cache_entry *p;
@@ -1198,7 +1204,7 @@ int ovl_indexdir_cleanup(struct ovl_fs *ofs)
 			if (p->len == 2 && p->name[1] == '.')
 				continue;
 		}
-		index = lookup_one_len(p->name, indexdir, p->len);
+		index = lookup_one_len_mapped(p->name, indexdir, p->len, user_ns);
 		if (IS_ERR(index)) {
 			err = PTR_ERR(index);
 			index = NULL;
@@ -1216,7 +1222,7 @@ int ovl_indexdir_cleanup(struct ovl_fs *ofs)
 			goto next;
 		} else if (err == -ESTALE) {
 			/* Cleanup stale index entries */
-			err = ovl_cleanup(dir, index);
+			err = ovl_cleanup(user_ns, dir, index);
 		} else if (err != -ENOENT) {
 			/*
 			 * Abort mount to avoid corrupting the index if
@@ -1232,7 +1238,7 @@ int ovl_indexdir_cleanup(struct ovl_fs *ofs)
 			err = ovl_cleanup_and_whiteout(ofs, dir, index);
 		} else {
 			/* Cleanup orphan index entries */
-			err = ovl_cleanup(dir, index);
+			err = ovl_cleanup(user_ns, dir, index);
 		}
 
 		if (err)
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 290983bcfbb3..755f651587a5 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -203,6 +203,7 @@ static void ovl_destroy_inode(struct inode *inode)
 
 	dput(oi->__upperdentry);
 	iput(oi->lower);
+	put_user_ns(oi->lower_user_ns);
 	if (S_ISDIR(inode->i_mode))
 		ovl_dir_cache_free(inode);
 	else
@@ -699,13 +700,14 @@ static struct dentry *ovl_workdir_create(struct ovl_fs *ofs,
 {
 	struct inode *dir =  ofs->workbasedir->d_inode;
 	struct vfsmount *mnt = ovl_upper_mnt(ofs);
+	struct user_namespace *user_ns = mnt_user_ns(mnt);
 	struct dentry *work;
 	int err;
 	bool retried = false;
 
 	inode_lock_nested(dir, I_MUTEX_PARENT);
 retry:
-	work = lookup_one_len(name, ofs->workbasedir, strlen(name));
+	work = lookup_one_len_mapped(name, ofs->workbasedir, strlen(name), user_ns);
 
 	if (!IS_ERR(work)) {
 		struct iattr attr = {
@@ -731,7 +733,7 @@ static struct dentry *ovl_workdir_create(struct ovl_fs *ofs,
 			goto retry;
 		}
 
-		work = ovl_create_real(dir, work, OVL_CATTR(attr.ia_mode));
+		work = ovl_create_real(user_ns, dir, work, OVL_CATTR(attr.ia_mode));
 		err = PTR_ERR(work);
 		if (IS_ERR(work))
 			goto out_err;
@@ -749,17 +751,17 @@ static struct dentry *ovl_workdir_create(struct ovl_fs *ofs,
 		 * allowed as upper are limited to "normal" ones, where checking
 		 * for the above two errors is sufficient.
 		 */
-		err = vfs_removexattr(work, XATTR_NAME_POSIX_ACL_DEFAULT);
+		err = vfs_mapped_removexattr(user_ns, work, XATTR_NAME_POSIX_ACL_DEFAULT);
 		if (err && err != -ENODATA && err != -EOPNOTSUPP)
 			goto out_dput;
 
-		err = vfs_removexattr(work, XATTR_NAME_POSIX_ACL_ACCESS);
+		err = vfs_mapped_removexattr(user_ns, work, XATTR_NAME_POSIX_ACL_ACCESS);
 		if (err && err != -ENODATA && err != -EOPNOTSUPP)
 			goto out_dput;
 
 		/* Clear any inherited mode bits */
 		inode_lock(work->d_inode);
-		err = notify_change(work, &attr, NULL);
+		err = notify_mapped_change(user_ns, work, &attr, NULL);
 		inode_unlock(work->d_inode);
 		if (err)
 			goto out_dput;
@@ -934,10 +936,11 @@ ovl_posix_acl_xattr_get(const struct xattr_handler *handler,
 }
 
 static int __maybe_unused
-ovl_posix_acl_xattr_set(const struct xattr_handler *handler,
-			struct dentry *dentry, struct inode *inode,
-			const char *name, const void *value,
-			size_t size, int flags)
+ovl_posix_acl_xattr_set_mapped(const struct xattr_handler *handler,
+			       struct user_namespace *user_ns,
+			       struct dentry *dentry, struct inode *inode,
+			       const char *name, const void *value,
+			       size_t size, int flags)
 {
 	struct dentry *workdir = ovl_workdir(dentry);
 	struct inode *realinode = ovl_inode_real(inode);
@@ -960,7 +963,7 @@ ovl_posix_acl_xattr_set(const struct xattr_handler *handler,
 		goto out_acl_release;
 	}
 	err = -EPERM;
-	if (!inode_owner_or_capable(inode))
+	if (!mapped_inode_owner_or_capable(user_ns, inode))
 		goto out_acl_release;
 
 	posix_acl_release(acl);
@@ -971,8 +974,8 @@ ovl_posix_acl_xattr_set(const struct xattr_handler *handler,
 	 */
 	if (unlikely(inode->i_mode & S_ISGID) &&
 	    handler->flags == ACL_TYPE_ACCESS &&
-	    !in_group_p(inode->i_gid) &&
-	    !capable_wrt_inode_uidgid(inode, CAP_FSETID)) {
+	    !in_group_p(i_gid_into_mnt(user_ns, inode)) &&
+	    !capable_wrt_mapped_inode_uidgid(user_ns, inode, CAP_FSETID)) {
 		struct iattr iattr = { .ia_valid = ATTR_KILL_SGID };
 
 		err = ovl_setattr(dentry, &iattr);
@@ -982,7 +985,7 @@ ovl_posix_acl_xattr_set(const struct xattr_handler *handler,
 
 	err = ovl_xattr_set(dentry, inode, handler->name, value, size, flags);
 	if (!err)
-		ovl_copyattr(ovl_inode_real(inode), inode);
+		ovl_copyattr(ovl_inode_real_user_ns(inode), realinode, inode);
 
 	return err;
 
@@ -991,6 +994,16 @@ ovl_posix_acl_xattr_set(const struct xattr_handler *handler,
 	return err;
 }
 
+static int __maybe_unused
+ovl_posix_acl_xattr_set(const struct xattr_handler *handler,
+			struct dentry *dentry, struct inode *inode,
+			const char *name, const void *value,
+			size_t size, int flags)
+{
+	return ovl_posix_acl_xattr_set_mapped(handler, &init_user_ns, dentry,
+					      inode, name, value, size, flags);
+}
+
 static int ovl_own_xattr_get(const struct xattr_handler *handler,
 			     struct dentry *dentry, struct inode *inode,
 			     const char *name, void *buffer, size_t size)
@@ -998,6 +1011,17 @@ static int ovl_own_xattr_get(const struct xattr_handler *handler,
 	return -EOPNOTSUPP;
 }
 
+#ifdef CONFIG_IDMAP_MOUNTS
+static int ovl_own_xattr_set_mapped(const struct xattr_handler *handler,
+				    struct user_namespace *user_ns,
+				    struct dentry *dentry, struct inode *inode,
+				    const char *name, const void *value,
+				    size_t size, int flags)
+{
+	return -EOPNOTSUPP;
+}
+#endif
+
 static int ovl_own_xattr_set(const struct xattr_handler *handler,
 			     struct dentry *dentry, struct inode *inode,
 			     const char *name, const void *value,
@@ -1013,6 +1037,17 @@ static int ovl_other_xattr_get(const struct xattr_handler *handler,
 	return ovl_xattr_get(dentry, inode, name, buffer, size);
 }
 
+#ifdef CONFIG_IDMAP_MOUNTS
+static int ovl_other_xattr_set_mapped(const struct xattr_handler *handler,
+				      struct user_namespace *user_ns,
+				      struct dentry *dentry,
+				      struct inode *inode, const char *name,
+				      const void *value, size_t size, int flags)
+{
+	return ovl_xattr_set(dentry, inode, name, value, size, flags);
+}
+#endif
+
 static int ovl_other_xattr_set(const struct xattr_handler *handler,
 			       struct dentry *dentry, struct inode *inode,
 			       const char *name, const void *value,
@@ -1027,6 +1062,9 @@ ovl_posix_acl_access_xattr_handler = {
 	.flags = ACL_TYPE_ACCESS,
 	.get = ovl_posix_acl_xattr_get,
 	.set = ovl_posix_acl_xattr_set,
+#ifdef CONFIG_IDMAP_MOUNTS
+	.set_mapped = ovl_posix_acl_xattr_set_mapped,
+#endif
 };
 
 static const struct xattr_handler __maybe_unused
@@ -1035,18 +1073,27 @@ ovl_posix_acl_default_xattr_handler = {
 	.flags = ACL_TYPE_DEFAULT,
 	.get = ovl_posix_acl_xattr_get,
 	.set = ovl_posix_acl_xattr_set,
+#ifdef CONFIG_IDMAP_MOUNTS
+	.set_mapped = ovl_posix_acl_xattr_set_mapped,
+#endif
 };
 
 static const struct xattr_handler ovl_own_xattr_handler = {
 	.prefix	= OVL_XATTR_PREFIX,
 	.get = ovl_own_xattr_get,
 	.set = ovl_own_xattr_set,
+#ifdef CONFIG_IDMAP_MOUNTS
+	.set_mapped = ovl_own_xattr_set_mapped,
+#endif
 };
 
 static const struct xattr_handler ovl_other_xattr_handler = {
 	.prefix	= "", /* catch all */
 	.get = ovl_other_xattr_get,
 	.set = ovl_other_xattr_set,
+#ifdef CONFIG_IDMAP_MOUNTS
+	.set_mapped = ovl_other_xattr_set_mapped,
+#endif
 };
 
 static const struct xattr_handler *ovl_xattr_handlers[] = {
@@ -1164,7 +1211,8 @@ static int ovl_get_upper(struct super_block *sb, struct ovl_fs *ofs,
  * Returns 1 if RENAME_WHITEOUT is supported, 0 if not supported and
  * negative values if error is encountered.
  */
-static int ovl_check_rename_whiteout(struct dentry *workdir)
+static int ovl_check_rename_whiteout(struct user_namespace *user_ns,
+				     struct dentry *workdir)
 {
 	struct inode *dir = d_inode(workdir);
 	struct dentry *temp;
@@ -1175,12 +1223,12 @@ static int ovl_check_rename_whiteout(struct dentry *workdir)
 
 	inode_lock_nested(dir, I_MUTEX_PARENT);
 
-	temp = ovl_create_temp(workdir, OVL_CATTR(S_IFREG | 0));
+	temp = ovl_create_temp(user_ns, workdir, OVL_CATTR(S_IFREG | 0));
 	err = PTR_ERR(temp);
 	if (IS_ERR(temp))
 		goto out_unlock;
 
-	dest = ovl_lookup_temp(workdir);
+	dest = ovl_lookup_temp(user_ns, workdir);
 	err = PTR_ERR(dest);
 	if (IS_ERR(dest)) {
 		dput(temp);
@@ -1189,14 +1237,14 @@ static int ovl_check_rename_whiteout(struct dentry *workdir)
 
 	/* Name is inline and stable - using snapshot as a copy helper */
 	take_dentry_name_snapshot(&name, temp);
-	err = ovl_do_rename(dir, temp, dir, dest, RENAME_WHITEOUT);
+	err = ovl_do_rename(dir, user_ns, temp, dir, user_ns, dest, RENAME_WHITEOUT);
 	if (err) {
 		if (err == -EINVAL)
 			err = 0;
 		goto cleanup_temp;
 	}
 
-	whiteout = lookup_one_len(name.name.name, workdir, name.name.len);
+	whiteout = lookup_one_len_mapped(name.name.name, workdir, name.name.len, user_ns);
 	err = PTR_ERR(whiteout);
 	if (IS_ERR(whiteout))
 		goto cleanup_temp;
@@ -1205,11 +1253,11 @@ static int ovl_check_rename_whiteout(struct dentry *workdir)
 
 	/* Best effort cleanup of whiteout and temp file */
 	if (err)
-		ovl_cleanup(dir, whiteout);
+		ovl_cleanup(user_ns, dir, whiteout);
 	dput(whiteout);
 
 cleanup_temp:
-	ovl_cleanup(dir, temp);
+	ovl_cleanup(user_ns, dir, temp);
 	release_dentry_name_snapshot(&name);
 	dput(temp);
 	dput(dest);
@@ -1220,16 +1268,17 @@ static int ovl_check_rename_whiteout(struct dentry *workdir)
 	return err;
 }
 
-static struct dentry *ovl_lookup_or_create(struct dentry *parent,
+static struct dentry *ovl_lookup_or_create(struct user_namespace *user_ns,
+					   struct dentry *parent,
 					   const char *name, umode_t mode)
 {
 	size_t len = strlen(name);
 	struct dentry *child;
 
 	inode_lock_nested(parent->d_inode, I_MUTEX_PARENT);
-	child = lookup_one_len(name, parent, len);
+	child = lookup_one_len_mapped(name, parent, len, user_ns);
 	if (!IS_ERR(child) && !child->d_inode)
-		child = ovl_create_real(parent->d_inode, child,
+		child = ovl_create_real(user_ns, parent->d_inode, child,
 					OVL_CATTR(mode));
 	inode_unlock(parent->d_inode);
 	dput(parent);
@@ -1251,7 +1300,8 @@ static int ovl_create_volatile_dirty(struct ovl_fs *ofs)
 	const char *const *name = volatile_path;
 
 	for (ctr = ARRAY_SIZE(volatile_path); ctr; ctr--, name++) {
-		d = ovl_lookup_or_create(d, *name, ctr > 1 ? S_IFDIR : S_IFREG);
+		d = ovl_lookup_or_create(ovl_upper_mnt_user_ns(ofs), d, *name,
+					 ctr > 1 ? S_IFDIR : S_IFREG);
 		if (IS_ERR(d))
 			return PTR_ERR(d);
 	}
@@ -1264,6 +1314,7 @@ static int ovl_make_workdir(struct super_block *sb, struct ovl_fs *ofs,
 {
 	struct vfsmount *mnt = ovl_upper_mnt(ofs);
 	struct dentry *temp, *workdir;
+	struct user_namespace *user_ns = mnt_user_ns(mnt);
 	bool rename_whiteout;
 	bool d_type;
 	int fh_type;
@@ -1299,7 +1350,7 @@ static int ovl_make_workdir(struct super_block *sb, struct ovl_fs *ofs,
 		pr_warn("upper fs needs to support d_type.\n");
 
 	/* Check if upper/work fs supports O_TMPFILE */
-	temp = ovl_do_tmpfile(ofs->workdir, S_IFREG | 0);
+	temp = ovl_do_tmpfile(user_ns, ofs->workdir, S_IFREG | 0);
 	ofs->tmpfile = !IS_ERR(temp);
 	if (ofs->tmpfile)
 		dput(temp);
@@ -1308,7 +1359,7 @@ static int ovl_make_workdir(struct super_block *sb, struct ovl_fs *ofs,
 
 
 	/* Check if upper/work fs supports RENAME_WHITEOUT */
-	err = ovl_check_rename_whiteout(ofs->workdir);
+	err = ovl_check_rename_whiteout(user_ns, ofs->workdir);
 	if (err < 0)
 		goto out;
 
@@ -1423,6 +1474,7 @@ static int ovl_get_indexdir(struct super_block *sb, struct ovl_fs *ofs,
 {
 	struct vfsmount *mnt = ovl_upper_mnt(ofs);
 	struct dentry *indexdir;
+	struct user_namespace *user_ns = mnt_user_ns(mnt);
 	int err;
 
 	err = mnt_want_write(mnt);
@@ -1462,7 +1514,7 @@ static int ovl_get_indexdir(struct super_block *sb, struct ovl_fs *ofs,
 		 * "trusted.overlay.upper" to indicate that index may have
 		 * directory entries.
 		 */
-		if (ovl_check_origin_xattr(ofs, ofs->indexdir)) {
+		if (ovl_check_origin_xattr(ofs, user_ns, ofs->indexdir)) {
 			err = ovl_verify_set_fh(ofs, ofs->indexdir,
 						OVL_XATTR_ORIGIN,
 						upperpath->dentry, true, false);
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index 23f475627d07..efd4dd067258 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -437,7 +437,8 @@ static void ovl_dentry_version_inc(struct dentry *dentry, bool impurity)
 void ovl_dir_modified(struct dentry *dentry, bool impurity)
 {
 	/* Copy mtime/ctime */
-	ovl_copyattr(d_inode(ovl_dentry_upper(dentry)), d_inode(dentry));
+	ovl_copyattr(ovl_upper_mnt_user_ns(OVL_FS(dentry->d_sb)),
+		     d_inode(ovl_dentry_upper(dentry)), d_inode(dentry));
 
 	ovl_dentry_version_inc(dentry, impurity);
 }
@@ -460,6 +461,7 @@ bool ovl_is_whiteout(struct dentry *dentry)
 struct file *ovl_path_open(struct path *path, int flags)
 {
 	struct inode *inode = d_inode(path->dentry);
+	struct user_namespace *user_ns = mnt_user_ns(path->mnt);
 	int err, acc_mode;
 
 	if (flags & ~(O_ACCMODE | O_LARGEFILE))
@@ -476,12 +478,12 @@ struct file *ovl_path_open(struct path *path, int flags)
 		BUG();
 	}
 
-	err = inode_permission(inode, acc_mode | MAY_OPEN);
+	err = mapped_inode_permission(user_ns, inode, acc_mode | MAY_OPEN);
 	if (err)
 		return ERR_PTR(err);
 
 	/* O_NOATIME is an optimization, don't fail if not permitted */
-	if (inode_owner_or_capable(inode))
+	if (mapped_inode_owner_or_capable(user_ns, inode))
 		flags |= O_NOATIME;
 
 	return dentry_open(path, flags, current_cred());
@@ -544,11 +546,12 @@ void ovl_copy_up_end(struct dentry *dentry)
 	ovl_inode_unlock(d_inode(dentry));
 }
 
-bool ovl_check_origin_xattr(struct ovl_fs *ofs, struct dentry *dentry)
+bool ovl_check_origin_xattr(struct ovl_fs *ofs, struct user_namespace *user_ns,
+			    struct dentry *dentry)
 {
 	int res;
 
-	res = ovl_do_getxattr(ofs, dentry, OVL_XATTR_ORIGIN, NULL, 0);
+	res = ovl_do_getxattr(ofs, user_ns, dentry, OVL_XATTR_ORIGIN, NULL, 0);
 
 	/* Zero size value means "copied up but origin unknown" */
 	if (res >= 0)
@@ -557,8 +560,8 @@ bool ovl_check_origin_xattr(struct ovl_fs *ofs, struct dentry *dentry)
 	return false;
 }
 
-bool ovl_check_dir_xattr(struct super_block *sb, struct dentry *dentry,
-			 enum ovl_xattr ox)
+bool ovl_check_dir_xattr(struct super_block *sb, struct user_namespace *user_ns,
+			 struct dentry *dentry, enum ovl_xattr ox)
 {
 	int res;
 	char val;
@@ -566,7 +569,7 @@ bool ovl_check_dir_xattr(struct super_block *sb, struct dentry *dentry,
 	if (!d_is_dir(dentry))
 		return false;
 
-	res = ovl_do_getxattr(OVL_FS(sb), dentry, ox, &val, 1);
+	res = ovl_do_getxattr(OVL_FS(sb), user_ns, dentry, ox, &val, 1);
 	if (res == 1 && val == 'y')
 		return true;
 
@@ -723,6 +726,7 @@ static void ovl_cleanup_index(struct dentry *dentry)
 	struct dentry *index = NULL;
 	struct inode *inode;
 	struct qstr name = { };
+	struct user_namespace *user_ns = ovl_dentry_mnt_user_ns(upperdentry);
 	int err;
 
 	err = ovl_get_index_name(lowerdentry, &name);
@@ -748,7 +752,7 @@ static void ovl_cleanup_index(struct dentry *dentry)
 	}
 
 	inode_lock_nested(dir, I_MUTEX_PARENT);
-	index = lookup_one_len(name.name, indexdir, name.len);
+	index = lookup_one_len_mapped(name.name, indexdir, name.len, user_ns);
 	err = PTR_ERR(index);
 	if (IS_ERR(index)) {
 		index = NULL;
@@ -758,7 +762,7 @@ static void ovl_cleanup_index(struct dentry *dentry)
 					       dir, index);
 	} else {
 		/* Cleanup orphan index entries */
-		err = ovl_cleanup(dir, index);
+		err = ovl_cleanup(user_ns, dir, index);
 	}
 
 	inode_unlock(dir);
@@ -867,7 +871,8 @@ int ovl_lock_rename_workdir(struct dentry *workdir, struct dentry *upperdir)
 }
 
 /* err < 0, 0 if no metacopy xattr, 1 if metacopy xattr found */
-int ovl_check_metacopy_xattr(struct ovl_fs *ofs, struct dentry *dentry)
+int ovl_check_metacopy_xattr(struct ovl_fs *ofs, struct user_namespace *user_ns,
+			     struct dentry *dentry)
 {
 	int res;
 
@@ -875,7 +880,7 @@ int ovl_check_metacopy_xattr(struct ovl_fs *ofs, struct dentry *dentry)
 	if (!S_ISREG(d_inode(dentry)->i_mode))
 		return 0;
 
-	res = ovl_do_getxattr(ofs, dentry, OVL_XATTR_METACOPY, NULL, 0);
+	res = ovl_do_getxattr(ofs, user_ns, dentry, OVL_XATTR_METACOPY, NULL, 0);
 	if (res < 0) {
 		if (res == -ENODATA || res == -EOPNOTSUPP)
 			return 0;
@@ -904,13 +909,14 @@ bool ovl_is_metacopy_dentry(struct dentry *dentry)
 	return (oe->numlower > 1);
 }
 
-char *ovl_get_redirect_xattr(struct ovl_fs *ofs, struct dentry *dentry,
-			     int padding)
+char *ovl_get_redirect_xattr(struct ovl_fs *ofs,
+			     struct user_namespace *mnt_user_ns,
+			     struct dentry *dentry, int padding)
 {
 	int res;
 	char *s, *next, *buf = NULL;
 
-	res = ovl_do_getxattr(ofs, dentry, OVL_XATTR_REDIRECT, NULL, 0);
+	res = ovl_do_getxattr(ofs, mnt_user_ns, dentry, OVL_XATTR_REDIRECT, NULL, 0);
 	if (res == -ENODATA || res == -EOPNOTSUPP)
 		return NULL;
 	if (res < 0)
@@ -922,7 +928,7 @@ char *ovl_get_redirect_xattr(struct ovl_fs *ofs, struct dentry *dentry,
 	if (!buf)
 		return ERR_PTR(-ENOMEM);
 
-	res = ovl_do_getxattr(ofs, dentry, OVL_XATTR_REDIRECT, buf, res);
+	res = ovl_do_getxattr(ofs, mnt_user_ns, dentry, OVL_XATTR_REDIRECT, buf, res);
 	if (res < 0)
 		goto fail;
 	if (res == 0)
-- 
2.29.0

