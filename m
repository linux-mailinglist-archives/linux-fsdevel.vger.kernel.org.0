Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37FBE2CE393
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Dec 2020 01:04:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389320AbgLDACd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Dec 2020 19:02:33 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:41731 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388388AbgLDACa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Dec 2020 19:02:30 -0500
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kkyXY-0007ka-9A; Fri, 04 Dec 2020 00:01:36 +0000
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
        Seth Forshee <seth.forshee@canonical.com>,
        =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@ubuntu.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Lennart Poettering <lennart@poettering.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>, smbarber@chromium.org,
        Phil Estes <estesp@gmail.com>, Serge Hallyn <serge@hallyn.com>,
        Kees Cook <keescook@chromium.org>,
        Todd Kjos <tkjos@google.com>, Paul Moore <paul@paul-moore.com>,
        Jonathan Corbet <corbet@lwn.net>,
        containers@lists.linux-foundation.org,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v4 12/40] inode: make init and permission helpers idmapped mount aware
Date:   Fri,  4 Dec 2020 00:57:08 +0100
Message-Id: <20201203235736.3528991-13-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201203235736.3528991-1-christian.brauner@ubuntu.com>
References: <20201203235736.3528991-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The inode_owner_or_capable() helper determines whether the caller is the
owner of the inode or is capable with respect to that inode. Allow it to
handle idmapped mounts. If the inode is accessed through an idmapped
mount we first need to map it according to the mount's user namespace.
Afterwards the checks are identical to non-idmapped mounts. If the
initial user namespace is passed nothing changes so non-idmapped mounts
will see identical behavior as before.

Similarly, we allow the inode_init_owner() helper to handle idmapped
mounts. It initializes a new inode on idmapped mounts by mapping the
fsuid and fsgid of the caller from the mount's user namespace. If the
initial user namespace is passed nothing changes so non-idmapped mounts
will see identical behavior as before.

Cc: Christoph Hellwig <hch@lst.de>
Cc: David Howells <dhowells@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
- Christoph Hellwig <hch@lst.de>:
  - Don't pollute the vfs with additional helpers simply extend the existing
    helpers with an additional argument and switch all callers.

/* v3 */
unchanged

/* v4 */
- Christoph Hellwig <hch@lst.de>:
  - Change commit message to reflect the fact that no new permission helpers are
    introduced but only the existing ones changed.

- Serge Hallyn <serge@hallyn.com>:
  - Use "mnt_userns" to refer to a vfsmount's userns everywhere to make
    terminology consistent.
  - Note that inode_owner_or_capable() contains a comparison of the
    caller's fsuid to the inode's i_uid to determine whether the caller
    is the owner of the inode. Serge asked whether it is possible that
    the caller's fsuid is INVALID_UID. If so and i_uid_into_mnt() makes
    the inode's i_uid INVALID_UID too then the caller could potentially
    gain privilege over an inode it doesn't own. But this is not
    feasible since the callers fsuid should never be INVALID_UID unless
    we have a severe bug how we manage set*id() calls or cred
    management. Also, if it is possible that the caller's fsuid were to
    be INVALID_UID we might already have an issue in case a filesystem
    was mounted with an s_user_ns that doesn't contain a mapping for a
    inode that was created when the filesystem was mounted with a
    different user namespace.
---
 fs/9p/acl.c                  |  2 +-
 fs/9p/vfs_inode.c            |  2 +-
 fs/attr.c                    |  6 +++---
 fs/bfs/dir.c                 |  2 +-
 fs/btrfs/inode.c             |  2 +-
 fs/btrfs/ioctl.c             | 10 +++++-----
 fs/btrfs/tests/btrfs-tests.c |  2 +-
 fs/crypto/policy.c           |  2 +-
 fs/efivarfs/file.c           |  2 +-
 fs/ext2/ialloc.c             |  2 +-
 fs/ext2/ioctl.c              |  6 +++---
 fs/ext4/ialloc.c             |  2 +-
 fs/ext4/ioctl.c              | 14 +++++++-------
 fs/f2fs/file.c               | 14 +++++++-------
 fs/f2fs/namei.c              |  2 +-
 fs/f2fs/xattr.c              |  2 +-
 fs/fcntl.c                   |  2 +-
 fs/gfs2/file.c               |  2 +-
 fs/hfsplus/inode.c           |  2 +-
 fs/hfsplus/ioctl.c           |  2 +-
 fs/hugetlbfs/inode.c         |  2 +-
 fs/inode.c                   | 35 ++++++++++++++++++++++++++---------
 fs/jfs/ioctl.c               |  2 +-
 fs/jfs/jfs_inode.c           |  2 +-
 fs/minix/bitmap.c            |  2 +-
 fs/namei.c                   |  4 ++--
 fs/nilfs2/inode.c            |  2 +-
 fs/nilfs2/ioctl.c            |  2 +-
 fs/ocfs2/dlmfs/dlmfs.c       |  4 ++--
 fs/ocfs2/ioctl.c             |  2 +-
 fs/ocfs2/namei.c             |  2 +-
 fs/omfs/inode.c              |  2 +-
 fs/overlayfs/dir.c           |  2 +-
 fs/overlayfs/file.c          |  4 ++--
 fs/overlayfs/super.c         |  2 +-
 fs/overlayfs/util.c          |  2 +-
 fs/posix_acl.c               |  2 +-
 fs/ramfs/inode.c             |  2 +-
 fs/reiserfs/ioctl.c          |  4 ++--
 fs/reiserfs/namei.c          |  2 +-
 fs/sysv/ialloc.c             |  2 +-
 fs/ubifs/dir.c               |  2 +-
 fs/ubifs/ioctl.c             |  2 +-
 fs/udf/ialloc.c              |  2 +-
 fs/ufs/ialloc.c              |  2 +-
 fs/xattr.c                   |  2 +-
 fs/xfs/xfs_ioctl.c           |  2 +-
 fs/zonefs/super.c            |  2 +-
 include/linux/fs.h           |  9 +++++----
 kernel/bpf/inode.c           |  2 +-
 mm/madvise.c                 |  2 +-
 mm/mincore.c                 |  2 +-
 mm/shmem.c                   |  2 +-
 security/selinux/hooks.c     |  4 ++--
 54 files changed, 108 insertions(+), 90 deletions(-)

diff --git a/fs/9p/acl.c b/fs/9p/acl.c
index 6261719f6f2a..d77b28e8d57a 100644
--- a/fs/9p/acl.c
+++ b/fs/9p/acl.c
@@ -258,7 +258,7 @@ static int v9fs_xattr_set_acl(const struct xattr_handler *handler,
 
 	if (S_ISLNK(inode->i_mode))
 		return -EOPNOTSUPP;
-	if (!inode_owner_or_capable(inode))
+	if (!inode_owner_or_capable(&init_user_ns, inode))
 		return -EPERM;
 	if (value) {
 		/* update the cached acl value */
diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index ae0c38ad1fcb..a3eb4f345f2c 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -251,7 +251,7 @@ int v9fs_init_inode(struct v9fs_session_info *v9ses,
 {
 	int err = 0;
 
-	inode_init_owner(inode, NULL, mode);
+	inode_init_owner(&init_user_ns,inode,  NULL, mode);
 	inode->i_blocks = 0;
 	inode->i_rdev = rdev;
 	inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
diff --git a/fs/attr.c b/fs/attr.c
index c9e29e589cec..00ae0b000146 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -87,7 +87,7 @@ int setattr_prepare(struct dentry *dentry, struct iattr *attr)
 
 	/* Make sure a caller can chmod. */
 	if (ia_valid & ATTR_MODE) {
-		if (!inode_owner_or_capable(inode))
+		if (!inode_owner_or_capable(&init_user_ns, inode))
 			return -EPERM;
 		/* Also check the setgid bit! */
 		if (!in_group_p((ia_valid & ATTR_GID) ? attr->ia_gid :
@@ -98,7 +98,7 @@ int setattr_prepare(struct dentry *dentry, struct iattr *attr)
 
 	/* Check for setting the inode time. */
 	if (ia_valid & (ATTR_MTIME_SET | ATTR_ATIME_SET | ATTR_TIMES_SET)) {
-		if (!inode_owner_or_capable(inode))
+		if (!inode_owner_or_capable(&init_user_ns, inode))
 			return -EPERM;
 	}
 
@@ -243,7 +243,7 @@ int notify_change(struct dentry * dentry, struct iattr * attr, struct inode **de
 		if (IS_IMMUTABLE(inode))
 			return -EPERM;
 
-		if (!inode_owner_or_capable(inode)) {
+		if (!inode_owner_or_capable(&init_user_ns, inode)) {
 			error = inode_permission(&init_user_ns, inode,
 						 MAY_WRITE);
 			if (error)
diff --git a/fs/bfs/dir.c b/fs/bfs/dir.c
index d8dfe3a0cb39..be1335a8d25b 100644
--- a/fs/bfs/dir.c
+++ b/fs/bfs/dir.c
@@ -96,7 +96,7 @@ static int bfs_create(struct inode *dir, struct dentry *dentry, umode_t mode,
 	}
 	set_bit(ino, info->si_imap);
 	info->si_freei--;
-	inode_init_owner(inode, dir, mode);
+	inode_init_owner(&init_user_ns, inode, dir, mode);
 	inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
 	inode->i_blocks = 0;
 	inode->i_op = &bfs_file_inops;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index ea4a70850f5e..4a67533c72fb 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6073,7 +6073,7 @@ static struct inode *btrfs_new_inode(struct btrfs_trans_handle *trans,
 	if (ret != 0)
 		goto fail_unlock;
 
-	inode_init_owner(inode, dir, mode);
+	inode_init_owner(&init_user_ns, inode, dir, mode);
 	inode_set_bytes(inode, 0);
 
 	inode->i_mtime = current_time(inode);
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 74500c15bdc1..f5d3ebca4c5f 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -205,7 +205,7 @@ static int btrfs_ioctl_setflags(struct file *file, void __user *arg)
 	const char *comp = NULL;
 	u32 binode_flags;
 
-	if (!inode_owner_or_capable(inode))
+	if (!inode_owner_or_capable(&init_user_ns, inode))
 		return -EPERM;
 
 	if (btrfs_root_readonly(root))
@@ -417,7 +417,7 @@ static int btrfs_ioctl_fssetxattr(struct file *file, void __user *arg)
 	unsigned old_i_flags;
 	int ret = 0;
 
-	if (!inode_owner_or_capable(inode))
+	if (!inode_owner_or_capable(&init_user_ns, inode))
 		return -EPERM;
 
 	if (btrfs_root_readonly(root))
@@ -1811,7 +1811,7 @@ static noinline int __btrfs_ioctl_snap_create(struct file *file,
 			btrfs_info(BTRFS_I(file_inode(file))->root->fs_info,
 				   "Snapshot src from another FS");
 			ret = -EXDEV;
-		} else if (!inode_owner_or_capable(src_inode)) {
+		} else if (!inode_owner_or_capable(&init_user_ns, src_inode)) {
 			/*
 			 * Subvolume creation is not restricted, but snapshots
 			 * are limited to own subvolumes only
@@ -1931,7 +1931,7 @@ static noinline int btrfs_ioctl_subvol_setflags(struct file *file,
 	u64 flags;
 	int ret = 0;
 
-	if (!inode_owner_or_capable(inode))
+	if (!inode_owner_or_capable(&init_user_ns, inode))
 		return -EPERM;
 
 	ret = mnt_want_write_file(file);
@@ -4401,7 +4401,7 @@ static long _btrfs_ioctl_set_received_subvol(struct file *file,
 	int ret = 0;
 	int received_uuid_changed;
 
-	if (!inode_owner_or_capable(inode))
+	if (!inode_owner_or_capable(&init_user_ns, inode))
 		return -EPERM;
 
 	ret = mnt_want_write_file(file);
diff --git a/fs/btrfs/tests/btrfs-tests.c b/fs/btrfs/tests/btrfs-tests.c
index 999c14e5d0bd..a4ac32f15c33 100644
--- a/fs/btrfs/tests/btrfs-tests.c
+++ b/fs/btrfs/tests/btrfs-tests.c
@@ -56,7 +56,7 @@ struct inode *btrfs_new_test_inode(void)
 
 	inode = new_inode(test_mnt->mnt_sb);
 	if (inode)
-		inode_init_owner(inode, NULL, S_IFREG);
+		inode_init_owner(&init_user_ns, inode, NULL, S_IFREG);
 
 	return inode;
 }
diff --git a/fs/crypto/policy.c b/fs/crypto/policy.c
index 4441d9944b9e..6ddd9f0d8b36 100644
--- a/fs/crypto/policy.c
+++ b/fs/crypto/policy.c
@@ -462,7 +462,7 @@ int fscrypt_ioctl_set_policy(struct file *filp, const void __user *arg)
 		return -EFAULT;
 	policy.version = version;
 
-	if (!inode_owner_or_capable(inode))
+	if (!inode_owner_or_capable(&init_user_ns, inode))
 		return -EACCES;
 
 	ret = mnt_want_write_file(filp);
diff --git a/fs/efivarfs/file.c b/fs/efivarfs/file.c
index feaa5e182b7b..e6bc0302643b 100644
--- a/fs/efivarfs/file.c
+++ b/fs/efivarfs/file.c
@@ -137,7 +137,7 @@ efivarfs_ioc_setxflags(struct file *file, void __user *arg)
 	unsigned int oldflags = efivarfs_getflags(inode);
 	int error;
 
-	if (!inode_owner_or_capable(inode))
+	if (!inode_owner_or_capable(&init_user_ns, inode))
 		return -EACCES;
 
 	if (copy_from_user(&flags, arg, sizeof(flags)))
diff --git a/fs/ext2/ialloc.c b/fs/ext2/ialloc.c
index 432c3febea6d..df14e750e9fe 100644
--- a/fs/ext2/ialloc.c
+++ b/fs/ext2/ialloc.c
@@ -551,7 +551,7 @@ struct inode *ext2_new_inode(struct inode *dir, umode_t mode,
 		inode->i_uid = current_fsuid();
 		inode->i_gid = dir->i_gid;
 	} else
-		inode_init_owner(inode, dir, mode);
+		inode_init_owner(&init_user_ns, inode, dir, mode);
 
 	inode->i_ino = ino;
 	inode->i_blocks = 0;
diff --git a/fs/ext2/ioctl.c b/fs/ext2/ioctl.c
index 32a8d10b579d..b399cbb7022d 100644
--- a/fs/ext2/ioctl.c
+++ b/fs/ext2/ioctl.c
@@ -39,7 +39,7 @@ long ext2_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		if (ret)
 			return ret;
 
-		if (!inode_owner_or_capable(inode)) {
+		if (!inode_owner_or_capable(&init_user_ns, inode)) {
 			ret = -EACCES;
 			goto setflags_out;
 		}
@@ -84,7 +84,7 @@ long ext2_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	case EXT2_IOC_SETVERSION: {
 		__u32 generation;
 
-		if (!inode_owner_or_capable(inode))
+		if (!inode_owner_or_capable(&init_user_ns, inode))
 			return -EPERM;
 		ret = mnt_want_write_file(filp);
 		if (ret)
@@ -117,7 +117,7 @@ long ext2_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		if (!test_opt(inode->i_sb, RESERVATION) ||!S_ISREG(inode->i_mode))
 			return -ENOTTY;
 
-		if (!inode_owner_or_capable(inode))
+		if (!inode_owner_or_capable(&init_user_ns, inode))
 			return -EACCES;
 
 		if (get_user(rsv_window_size, (int __user *)arg))
diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
index b215c564bc31..00c1ec6eee16 100644
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -972,7 +972,7 @@ struct inode *__ext4_new_inode(handle_t *handle, struct inode *dir,
 		inode->i_uid = current_fsuid();
 		inode->i_gid = dir->i_gid;
 	} else
-		inode_init_owner(inode, dir, mode);
+		inode_init_owner(&init_user_ns, inode, dir, mode);
 
 	if (ext4_has_feature_project(sb) &&
 	    ext4_test_inode_flag(dir, EXT4_INODE_PROJINHERIT))
diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index f0381876a7e5..e35aba820254 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -139,7 +139,7 @@ static long swap_inode_boot_loader(struct super_block *sb,
 	}
 
 	if (IS_RDONLY(inode) || IS_APPEND(inode) || IS_IMMUTABLE(inode) ||
-	    !inode_owner_or_capable(inode) || !capable(CAP_SYS_ADMIN)) {
+	    !inode_owner_or_capable(&init_user_ns, inode) || !capable(CAP_SYS_ADMIN)) {
 		err = -EPERM;
 		goto journal_err_out;
 	}
@@ -829,7 +829,7 @@ static long __ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	case FS_IOC_SETFLAGS: {
 		int err;
 
-		if (!inode_owner_or_capable(inode))
+		if (!inode_owner_or_capable(&init_user_ns, inode))
 			return -EACCES;
 
 		if (get_user(flags, (int __user *) arg))
@@ -871,7 +871,7 @@ static long __ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		__u32 generation;
 		int err;
 
-		if (!inode_owner_or_capable(inode))
+		if (!inode_owner_or_capable(&init_user_ns, inode))
 			return -EPERM;
 
 		if (ext4_has_metadata_csum(inode->i_sb)) {
@@ -1010,7 +1010,7 @@ static long __ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	case EXT4_IOC_MIGRATE:
 	{
 		int err;
-		if (!inode_owner_or_capable(inode))
+		if (!inode_owner_or_capable(&init_user_ns, inode))
 			return -EACCES;
 
 		err = mnt_want_write_file(filp);
@@ -1032,7 +1032,7 @@ static long __ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	case EXT4_IOC_ALLOC_DA_BLKS:
 	{
 		int err;
-		if (!inode_owner_or_capable(inode))
+		if (!inode_owner_or_capable(&init_user_ns, inode))
 			return -EACCES;
 
 		err = mnt_want_write_file(filp);
@@ -1214,7 +1214,7 @@ static long __ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 
 	case EXT4_IOC_CLEAR_ES_CACHE:
 	{
-		if (!inode_owner_or_capable(inode))
+		if (!inode_owner_or_capable(&init_user_ns, inode))
 			return -EACCES;
 		ext4_clear_inode_es(inode);
 		return 0;
@@ -1260,7 +1260,7 @@ static long __ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 			return -EFAULT;
 
 		/* Make sure caller has proper permission */
-		if (!inode_owner_or_capable(inode))
+		if (!inode_owner_or_capable(&init_user_ns, inode))
 			return -EACCES;
 
 		if (fa.fsx_xflags & ~EXT4_SUPPORTED_FS_XFLAGS)
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index ee861c6d9ff0..333442e96cc4 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1955,7 +1955,7 @@ static int f2fs_ioc_setflags(struct file *filp, unsigned long arg)
 	u32 iflags;
 	int ret;
 
-	if (!inode_owner_or_capable(inode))
+	if (!inode_owner_or_capable(&init_user_ns, inode))
 		return -EACCES;
 
 	if (get_user(fsflags, (int __user *)arg))
@@ -2002,7 +2002,7 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	int ret;
 
-	if (!inode_owner_or_capable(inode))
+	if (!inode_owner_or_capable(&init_user_ns, inode))
 		return -EACCES;
 
 	if (!S_ISREG(inode->i_mode))
@@ -2069,7 +2069,7 @@ static int f2fs_ioc_commit_atomic_write(struct file *filp)
 	struct inode *inode = file_inode(filp);
 	int ret;
 
-	if (!inode_owner_or_capable(inode))
+	if (!inode_owner_or_capable(&init_user_ns, inode))
 		return -EACCES;
 
 	ret = mnt_want_write_file(filp);
@@ -2111,7 +2111,7 @@ static int f2fs_ioc_start_volatile_write(struct file *filp)
 	struct inode *inode = file_inode(filp);
 	int ret;
 
-	if (!inode_owner_or_capable(inode))
+	if (!inode_owner_or_capable(&init_user_ns, inode))
 		return -EACCES;
 
 	if (!S_ISREG(inode->i_mode))
@@ -2146,7 +2146,7 @@ static int f2fs_ioc_release_volatile_write(struct file *filp)
 	struct inode *inode = file_inode(filp);
 	int ret;
 
-	if (!inode_owner_or_capable(inode))
+	if (!inode_owner_or_capable(&init_user_ns, inode))
 		return -EACCES;
 
 	ret = mnt_want_write_file(filp);
@@ -2175,7 +2175,7 @@ static int f2fs_ioc_abort_volatile_write(struct file *filp)
 	struct inode *inode = file_inode(filp);
 	int ret;
 
-	if (!inode_owner_or_capable(inode))
+	if (!inode_owner_or_capable(&init_user_ns, inode))
 		return -EACCES;
 
 	ret = mnt_want_write_file(filp);
@@ -3153,7 +3153,7 @@ static int f2fs_ioc_fssetxattr(struct file *filp, unsigned long arg)
 		return -EFAULT;
 
 	/* Make sure caller has proper permission */
-	if (!inode_owner_or_capable(inode))
+	if (!inode_owner_or_capable(&init_user_ns, inode))
 		return -EACCES;
 
 	if (fa.fsx_xflags & ~F2FS_SUPPORTED_XFLAGS)
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 8fa37d1434de..8a69cf3e3b15 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -46,7 +46,7 @@ static struct inode *f2fs_new_inode(struct inode *dir, umode_t mode)
 
 	nid_free = true;
 
-	inode_init_owner(inode, dir, mode);
+	inode_init_owner(&init_user_ns, inode, dir, mode);
 
 	inode->i_ino = ino;
 	inode->i_blocks = 0;
diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index 65afcc3cc68a..d772bf13a814 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -114,7 +114,7 @@ static int f2fs_xattr_advise_set(const struct xattr_handler *handler,
 	unsigned char old_advise = F2FS_I(inode)->i_advise;
 	unsigned char new_advise;
 
-	if (!inode_owner_or_capable(inode))
+	if (!inode_owner_or_capable(&init_user_ns, inode))
 		return -EPERM;
 	if (value == NULL)
 		return -EINVAL;
diff --git a/fs/fcntl.c b/fs/fcntl.c
index 19ac5baad50f..df091d435603 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -46,7 +46,7 @@ static int setfl(int fd, struct file * filp, unsigned long arg)
 
 	/* O_NOATIME can only be set by the owner or superuser */
 	if ((arg & O_NOATIME) && !(filp->f_flags & O_NOATIME))
-		if (!inode_owner_or_capable(inode))
+		if (!inode_owner_or_capable(&init_user_ns, inode))
 			return -EPERM;
 
 	/* required for strict SunOS emulation */
diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
index b39b339feddc..1d994bdfffaa 100644
--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -238,7 +238,7 @@ static int do_gfs2_set_flags(struct file *filp, u32 reqflags, u32 mask,
 		goto out;
 
 	error = -EACCES;
-	if (!inode_owner_or_capable(inode))
+	if (!inode_owner_or_capable(&init_user_ns, inode))
 		goto out;
 
 	error = 0;
diff --git a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
index e3da9e96b835..21357046b039 100644
--- a/fs/hfsplus/inode.c
+++ b/fs/hfsplus/inode.c
@@ -376,7 +376,7 @@ struct inode *hfsplus_new_inode(struct super_block *sb, struct inode *dir,
 		return NULL;
 
 	inode->i_ino = sbi->next_cnid++;
-	inode_init_owner(inode, dir, mode);
+	inode_init_owner(&init_user_ns, inode, dir, mode);
 	set_nlink(inode, 1);
 	inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
 
diff --git a/fs/hfsplus/ioctl.c b/fs/hfsplus/ioctl.c
index ce15b9496b77..3edb1926d127 100644
--- a/fs/hfsplus/ioctl.c
+++ b/fs/hfsplus/ioctl.c
@@ -91,7 +91,7 @@ static int hfsplus_ioctl_setflags(struct file *file, int __user *user_flags)
 	if (err)
 		goto out;
 
-	if (!inode_owner_or_capable(inode)) {
+	if (!inode_owner_or_capable(&init_user_ns, inode)) {
 		err = -EACCES;
 		goto out_drop_write;
 	}
diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index b5c109703daa..6737929e443c 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -836,7 +836,7 @@ static struct inode *hugetlbfs_get_inode(struct super_block *sb,
 		struct hugetlbfs_inode_info *info = HUGETLBFS_I(inode);
 
 		inode->i_ino = get_next_ino();
-		inode_init_owner(inode, dir, mode);
+		inode_init_owner(&init_user_ns, inode, dir, mode);
 		lockdep_set_class(&inode->i_mapping->i_mmap_rwsem,
 				&hugetlbfs_i_mmap_rwsem_key);
 		inode->i_mapping->a_ops = &hugetlbfs_aops;
diff --git a/fs/inode.c b/fs/inode.c
index 7a15372d9c2d..b402e45b3ada 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -2131,14 +2131,21 @@ EXPORT_SYMBOL(init_special_inode);
 
 /**
  * inode_init_owner - Init uid,gid,mode for new inode according to posix standards
+ * @mnt_userns:	User namespace of the mount the inode was created from
  * @inode: New inode
  * @dir: Directory inode
  * @mode: mode of the new inode
+ *
+ * If the inode has been created through an idmapped mount the user namespace of
+ * the vfsmount must be passed through @mnt_userns. This function will then take
+ * care to map the inode according to @mnt_userns before checking permissions
+ * and initializing i_uid and i_gid. On non-idmapped mounts or if permission
+ * checking is to be performed on the raw inode simply passs init_user_ns.
  */
-void inode_init_owner(struct inode *inode, const struct inode *dir,
-			umode_t mode)
+void inode_init_owner(struct user_namespace *mnt_userns, struct inode *inode,
+		      const struct inode *dir, umode_t mode)
 {
-	inode->i_uid = current_fsuid();
+	inode->i_uid = fsuid_into_mnt(mnt_userns);
 	if (dir && dir->i_mode & S_ISGID) {
 		inode->i_gid = dir->i_gid;
 
@@ -2146,31 +2153,41 @@ void inode_init_owner(struct inode *inode, const struct inode *dir,
 		if (S_ISDIR(mode))
 			mode |= S_ISGID;
 		else if ((mode & (S_ISGID | S_IXGRP)) == (S_ISGID | S_IXGRP) &&
-			 !in_group_p(inode->i_gid) &&
-			 !capable_wrt_inode_uidgid(&init_user_ns, dir, CAP_FSETID))
+			 !in_group_p(i_gid_into_mnt(mnt_userns, dir)) &&
+			 !capable_wrt_inode_uidgid(mnt_userns, dir, CAP_FSETID))
 			mode &= ~S_ISGID;
 	} else
-		inode->i_gid = current_fsgid();
+		inode->i_gid = fsgid_into_mnt(mnt_userns);
 	inode->i_mode = mode;
 }
 EXPORT_SYMBOL(inode_init_owner);
 
 /**
  * inode_owner_or_capable - check current task permissions to inode
+ * @mnt_userns:	user namespace of the mount the inode was found from
  * @inode: inode being checked
  *
  * Return true if current either has CAP_FOWNER in a namespace with the
  * inode owner uid mapped, or owns the file.
+ *
+ * If the inode has been found through an idmapped mount the user namespace of
+ * the vfsmount must be passed through @mnt_userns. This function will then take
+ * care to map the inode according to @mnt_userns before checking permissions.
+ * On non-idmapped mounts or if permission checking is to be performed on the
+ * raw inode simply passs init_user_ns.
  */
-bool inode_owner_or_capable(const struct inode *inode)
+bool inode_owner_or_capable(struct user_namespace *mnt_userns,
+			    const struct inode *inode)
 {
+	kuid_t i_uid;
 	struct user_namespace *ns;
 
-	if (uid_eq(current_fsuid(), inode->i_uid))
+	i_uid = i_uid_into_mnt(mnt_userns, inode);
+	if (uid_eq(current_fsuid(), i_uid))
 		return true;
 
 	ns = current_user_ns();
-	if (kuid_has_mapping(ns, inode->i_uid) && ns_capable(ns, CAP_FOWNER))
+	if (kuid_has_mapping(ns, i_uid) && ns_capable(ns, CAP_FOWNER))
 		return true;
 	return false;
 }
diff --git a/fs/jfs/ioctl.c b/fs/jfs/ioctl.c
index 10ee0ecca1a8..2581d4db58ff 100644
--- a/fs/jfs/ioctl.c
+++ b/fs/jfs/ioctl.c
@@ -76,7 +76,7 @@ long jfs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		if (err)
 			return err;
 
-		if (!inode_owner_or_capable(inode)) {
+		if (!inode_owner_or_capable(&init_user_ns, inode)) {
 			err = -EACCES;
 			goto setflags_out;
 		}
diff --git a/fs/jfs/jfs_inode.c b/fs/jfs/jfs_inode.c
index 4cef170630db..59379089e939 100644
--- a/fs/jfs/jfs_inode.c
+++ b/fs/jfs/jfs_inode.c
@@ -64,7 +64,7 @@ struct inode *ialloc(struct inode *parent, umode_t mode)
 		goto fail_put;
 	}
 
-	inode_init_owner(inode, parent, mode);
+	inode_init_owner(&init_user_ns, inode, parent, mode);
 	/*
 	 * New inodes need to save sane values on disk when
 	 * uid & gid mount options are used
diff --git a/fs/minix/bitmap.c b/fs/minix/bitmap.c
index f4e5e5181a14..9115948c624e 100644
--- a/fs/minix/bitmap.c
+++ b/fs/minix/bitmap.c
@@ -252,7 +252,7 @@ struct inode *minix_new_inode(const struct inode *dir, umode_t mode, int *error)
 		iput(inode);
 		return NULL;
 	}
-	inode_init_owner(inode, dir, mode);
+	inode_init_owner(&init_user_ns, inode, dir, mode);
 	inode->i_ino = j;
 	inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
 	inode->i_blocks = 0;
diff --git a/fs/namei.c b/fs/namei.c
index 79814dbbfc82..aed328571a6b 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1086,7 +1086,7 @@ int may_linkat(struct path *link)
 	/* Source inode owner (or CAP_FOWNER) can hardlink all they like,
 	 * otherwise, it must be a safe source.
 	 */
-	if (safe_hardlink_source(inode) || inode_owner_or_capable(inode))
+	if (safe_hardlink_source(inode) || inode_owner_or_capable(&init_user_ns, inode))
 		return 0;
 
 	audit_log_path_denied(AUDIT_ANOM_LINK, "linkat");
@@ -2936,7 +2936,7 @@ static int may_open(const struct path *path, int acc_mode, int flag)
 	}
 
 	/* O_NOATIME can only be set by the owner or superuser */
-	if (flag & O_NOATIME && !inode_owner_or_capable(inode))
+	if (flag & O_NOATIME && !inode_owner_or_capable(&init_user_ns, inode))
 		return -EPERM;
 
 	return 0;
diff --git a/fs/nilfs2/inode.c b/fs/nilfs2/inode.c
index b6517220cad5..11225a659736 100644
--- a/fs/nilfs2/inode.c
+++ b/fs/nilfs2/inode.c
@@ -348,7 +348,7 @@ struct inode *nilfs_new_inode(struct inode *dir, umode_t mode)
 	/* reference count of i_bh inherits from nilfs_mdt_read_block() */
 
 	atomic64_inc(&root->inodes_count);
-	inode_init_owner(inode, dir, mode);
+	inode_init_owner(&init_user_ns, inode, dir, mode);
 	inode->i_ino = ino;
 	inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
 
diff --git a/fs/nilfs2/ioctl.c b/fs/nilfs2/ioctl.c
index 07d26f61f22a..b053b40315bf 100644
--- a/fs/nilfs2/ioctl.c
+++ b/fs/nilfs2/ioctl.c
@@ -132,7 +132,7 @@ static int nilfs_ioctl_setflags(struct inode *inode, struct file *filp,
 	unsigned int flags, oldflags;
 	int ret;
 
-	if (!inode_owner_or_capable(inode))
+	if (!inode_owner_or_capable(&init_user_ns, inode))
 		return -EACCES;
 
 	if (get_user(flags, (int __user *)argp))
diff --git a/fs/ocfs2/dlmfs/dlmfs.c b/fs/ocfs2/dlmfs/dlmfs.c
index 583820ec63e2..37c7d03a6284 100644
--- a/fs/ocfs2/dlmfs/dlmfs.c
+++ b/fs/ocfs2/dlmfs/dlmfs.c
@@ -329,7 +329,7 @@ static struct inode *dlmfs_get_root_inode(struct super_block *sb)
 
 	if (inode) {
 		inode->i_ino = get_next_ino();
-		inode_init_owner(inode, NULL, mode);
+		inode_init_owner(&init_user_ns, inode, NULL, mode);
 		inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
 		inc_nlink(inode);
 
@@ -352,7 +352,7 @@ static struct inode *dlmfs_get_inode(struct inode *parent,
 		return NULL;
 
 	inode->i_ino = get_next_ino();
-	inode_init_owner(inode, parent, mode);
+	inode_init_owner(&init_user_ns, inode, parent, mode);
 	inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
 
 	ip = DLMFS_I(inode);
diff --git a/fs/ocfs2/ioctl.c b/fs/ocfs2/ioctl.c
index 89984172fc4a..50c9b30ee9f6 100644
--- a/fs/ocfs2/ioctl.c
+++ b/fs/ocfs2/ioctl.c
@@ -96,7 +96,7 @@ static int ocfs2_set_inode_attr(struct inode *inode, unsigned flags,
 	}
 
 	status = -EACCES;
-	if (!inode_owner_or_capable(inode))
+	if (!inode_owner_or_capable(&init_user_ns, inode))
 		goto bail_unlock;
 
 	if (!S_ISDIR(inode->i_mode))
diff --git a/fs/ocfs2/namei.c b/fs/ocfs2/namei.c
index c46bf7f581a1..a4965133bd5e 100644
--- a/fs/ocfs2/namei.c
+++ b/fs/ocfs2/namei.c
@@ -198,7 +198,7 @@ static struct inode *ocfs2_get_init_inode(struct inode *dir, umode_t mode)
 	 * callers. */
 	if (S_ISDIR(mode))
 		set_nlink(inode, 2);
-	inode_init_owner(inode, dir, mode);
+	inode_init_owner(&init_user_ns, inode, dir, mode);
 	status = dquot_initialize(inode);
 	if (status)
 		return ERR_PTR(status);
diff --git a/fs/omfs/inode.c b/fs/omfs/inode.c
index ce93ccca8639..2a0e83236c01 100644
--- a/fs/omfs/inode.c
+++ b/fs/omfs/inode.c
@@ -48,7 +48,7 @@ struct inode *omfs_new_inode(struct inode *dir, umode_t mode)
 		goto fail;
 
 	inode->i_ino = new_block;
-	inode_init_owner(inode, NULL, mode);
+	inode_init_owner(&init_user_ns, inode, NULL, mode);
 	inode->i_mapping->a_ops = &omfs_aops;
 
 	inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 28a075b5f5b2..98a23353b19a 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -636,7 +636,7 @@ static int ovl_create_object(struct dentry *dentry, int mode, dev_t rdev,
 	inode->i_state |= I_CREATING;
 	spin_unlock(&inode->i_lock);
 
-	inode_init_owner(inode, dentry->d_parent->d_inode, mode);
+	inode_init_owner(&init_user_ns, inode, dentry->d_parent->d_inode, mode);
 	attr.mode = inode->i_mode;
 
 	err = ovl_create_or_link(dentry, inode, &attr, false);
diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index f966b5108358..d58b49a1ea3b 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -53,7 +53,7 @@ static struct file *ovl_open_realfile(const struct file *file,
 	err = inode_permission(&init_user_ns, realinode, MAY_OPEN | acc_mode);
 	if (err) {
 		realfile = ERR_PTR(err);
-	} else if (!inode_owner_or_capable(realinode)) {
+	} else if (!inode_owner_or_capable(&init_user_ns, realinode)) {
 		realfile = ERR_PTR(-EPERM);
 	} else {
 		realfile = open_with_fake_path(&file->f_path, flags, realinode,
@@ -582,7 +582,7 @@ static long ovl_ioctl_set_flags(struct file *file, unsigned int cmd,
 	struct inode *inode = file_inode(file);
 	unsigned int oldflags;
 
-	if (!inode_owner_or_capable(inode))
+	if (!inode_owner_or_capable(&init_user_ns, inode))
 		return -EACCES;
 
 	ret = mnt_want_write_file(file);
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 196fe3e3f02b..82f2c35894e4 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -960,7 +960,7 @@ ovl_posix_acl_xattr_set(const struct xattr_handler *handler,
 		goto out_acl_release;
 	}
 	err = -EPERM;
-	if (!inode_owner_or_capable(inode))
+	if (!inode_owner_or_capable(&init_user_ns, inode))
 		goto out_acl_release;
 
 	posix_acl_release(acl);
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index ff67da201303..0a1f4bccb5da 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -481,7 +481,7 @@ struct file *ovl_path_open(struct path *path, int flags)
 		return ERR_PTR(err);
 
 	/* O_NOATIME is an optimization, don't fail if not permitted */
-	if (inode_owner_or_capable(inode))
+	if (inode_owner_or_capable(&init_user_ns, inode))
 		flags |= O_NOATIME;
 
 	return dentry_open(path, flags, current_cred());
diff --git a/fs/posix_acl.c b/fs/posix_acl.c
index 5d9fe2fb2953..9ce8214bfdac 100644
--- a/fs/posix_acl.c
+++ b/fs/posix_acl.c
@@ -874,7 +874,7 @@ set_posix_acl(struct inode *inode, int type, struct posix_acl *acl)
 
 	if (type == ACL_TYPE_DEFAULT && !S_ISDIR(inode->i_mode))
 		return acl ? -EACCES : 0;
-	if (!inode_owner_or_capable(inode))
+	if (!inode_owner_or_capable(&init_user_ns, inode))
 		return -EPERM;
 
 	if (acl) {
diff --git a/fs/ramfs/inode.c b/fs/ramfs/inode.c
index ee179a81b3da..3fd4326f36b5 100644
--- a/fs/ramfs/inode.c
+++ b/fs/ramfs/inode.c
@@ -67,7 +67,7 @@ struct inode *ramfs_get_inode(struct super_block *sb,
 
 	if (inode) {
 		inode->i_ino = get_next_ino();
-		inode_init_owner(inode, dir, mode);
+		inode_init_owner(&init_user_ns, inode, dir, mode);
 		inode->i_mapping->a_ops = &ramfs_aops;
 		mapping_set_gfp_mask(inode->i_mapping, GFP_HIGHUSER);
 		mapping_set_unevictable(inode->i_mapping);
diff --git a/fs/reiserfs/ioctl.c b/fs/reiserfs/ioctl.c
index adb21bea3d60..4f1cbd930179 100644
--- a/fs/reiserfs/ioctl.c
+++ b/fs/reiserfs/ioctl.c
@@ -59,7 +59,7 @@ long reiserfs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 			if (err)
 				break;
 
-			if (!inode_owner_or_capable(inode)) {
+			if (!inode_owner_or_capable(&init_user_ns, inode)) {
 				err = -EPERM;
 				goto setflags_out;
 			}
@@ -101,7 +101,7 @@ long reiserfs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		err = put_user(inode->i_generation, (int __user *)arg);
 		break;
 	case REISERFS_IOC_SETVERSION:
-		if (!inode_owner_or_capable(inode)) {
+		if (!inode_owner_or_capable(&init_user_ns, inode)) {
 			err = -EPERM;
 			break;
 		}
diff --git a/fs/reiserfs/namei.c b/fs/reiserfs/namei.c
index 1594687582f0..a67a7d371725 100644
--- a/fs/reiserfs/namei.c
+++ b/fs/reiserfs/namei.c
@@ -615,7 +615,7 @@ static int new_inode_init(struct inode *inode, struct inode *dir, umode_t mode)
 	 * the quota init calls have to know who to charge the quota to, so
 	 * we have to set uid and gid here
 	 */
-	inode_init_owner(inode, dir, mode);
+	inode_init_owner(&init_user_ns, inode, dir, mode);
 	return dquot_initialize(inode);
 }
 
diff --git a/fs/sysv/ialloc.c b/fs/sysv/ialloc.c
index 6c9801986af6..50df794a3c1f 100644
--- a/fs/sysv/ialloc.c
+++ b/fs/sysv/ialloc.c
@@ -163,7 +163,7 @@ struct inode * sysv_new_inode(const struct inode * dir, umode_t mode)
 	*sbi->s_sb_fic_count = cpu_to_fs16(sbi, count);
 	fs16_add(sbi, sbi->s_sb_total_free_inodes, -1);
 	dirty_sb(sb);
-	inode_init_owner(inode, dir, mode);
+	inode_init_owner(&init_user_ns, inode, dir, mode);
 	inode->i_ino = fs16_to_cpu(sbi, ino);
 	inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
 	inode->i_blocks = 0;
diff --git a/fs/ubifs/dir.c b/fs/ubifs/dir.c
index 155521e51ac5..a2bbd7ed39e9 100644
--- a/fs/ubifs/dir.c
+++ b/fs/ubifs/dir.c
@@ -94,7 +94,7 @@ struct inode *ubifs_new_inode(struct ubifs_info *c, struct inode *dir,
 	 */
 	inode->i_flags |= S_NOCMTIME;
 
-	inode_init_owner(inode, dir, mode);
+	inode_init_owner(&init_user_ns, inode, dir, mode);
 	inode->i_mtime = inode->i_atime = inode->i_ctime =
 			 current_time(inode);
 	inode->i_mapping->nrpages = 0;
diff --git a/fs/ubifs/ioctl.c b/fs/ubifs/ioctl.c
index 4363d85a3fd4..2326d5122beb 100644
--- a/fs/ubifs/ioctl.c
+++ b/fs/ubifs/ioctl.c
@@ -155,7 +155,7 @@ long ubifs_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		if (IS_RDONLY(inode))
 			return -EROFS;
 
-		if (!inode_owner_or_capable(inode))
+		if (!inode_owner_or_capable(&init_user_ns, inode))
 			return -EACCES;
 
 		if (get_user(flags, (int __user *) arg))
diff --git a/fs/udf/ialloc.c b/fs/udf/ialloc.c
index 84ed23edebfd..2ecf0e87660e 100644
--- a/fs/udf/ialloc.c
+++ b/fs/udf/ialloc.c
@@ -103,7 +103,7 @@ struct inode *udf_new_inode(struct inode *dir, umode_t mode)
 		mutex_unlock(&sbi->s_alloc_mutex);
 	}
 
-	inode_init_owner(inode, dir, mode);
+	inode_init_owner(&init_user_ns, inode, dir, mode);
 	if (UDF_QUERY_FLAG(sb, UDF_FLAG_UID_SET))
 		inode->i_uid = sbi->s_uid;
 	if (UDF_QUERY_FLAG(sb, UDF_FLAG_GID_SET))
diff --git a/fs/ufs/ialloc.c b/fs/ufs/ialloc.c
index 969fd60436d3..7e3e08c0166f 100644
--- a/fs/ufs/ialloc.c
+++ b/fs/ufs/ialloc.c
@@ -289,7 +289,7 @@ struct inode *ufs_new_inode(struct inode *dir, umode_t mode)
 	ufs_mark_sb_dirty(sb);
 
 	inode->i_ino = cg * uspi->s_ipg + bit;
-	inode_init_owner(inode, dir, mode);
+	inode_init_owner(&init_user_ns, inode, dir, mode);
 	inode->i_blocks = 0;
 	inode->i_generation = 0;
 	inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
diff --git a/fs/xattr.c b/fs/xattr.c
index 61a9947f62f4..fcc79c2a1ea1 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -127,7 +127,7 @@ xattr_permission(struct inode *inode, const char *name, int mask)
 		if (!S_ISREG(inode->i_mode) && !S_ISDIR(inode->i_mode))
 			return (mask & MAY_WRITE) ? -EPERM : -ENODATA;
 		if (S_ISDIR(inode->i_mode) && (inode->i_mode & S_ISVTX) &&
-		    (mask & MAY_WRITE) && !inode_owner_or_capable(inode))
+		    (mask & MAY_WRITE) && !inode_owner_or_capable(&init_user_ns, inode))
 			return -EPERM;
 	}
 
diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index 97bd29fc8c43..218e80afc859 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -1300,7 +1300,7 @@ xfs_ioctl_setattr_get_trans(
 	 * The user ID of the calling process must be equal to the file owner
 	 * ID, except in cases where the CAP_FSETID capability is applicable.
 	 */
-	if (!inode_owner_or_capable(VFS_I(ip))) {
+	if (!inode_owner_or_capable(&init_user_ns, VFS_I(ip))) {
 		error = -EPERM;
 		goto out_cancel;
 	}
diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index ff5930be096c..e301a131bf1e 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -1221,7 +1221,7 @@ static void zonefs_init_dir_inode(struct inode *parent, struct inode *inode,
 	struct super_block *sb = parent->i_sb;
 
 	inode->i_ino = blkdev_nr_zones(sb->s_bdev->bd_disk) + type + 1;
-	inode_init_owner(inode, parent, S_IFDIR | 0555);
+	inode_init_owner(&init_user_ns, inode, parent, S_IFDIR | 0555);
 	inode->i_op = &zonefs_dir_inode_operations;
 	inode->i_fop = &simple_dir_operations;
 	set_nlink(inode, 2);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 8fb288dd9185..e77a270bd195 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1763,8 +1763,8 @@ static inline bool sb_start_intwrite_trylock(struct super_block *sb)
 	return __sb_start_write_trylock(sb, SB_FREEZE_FS);
 }
 
-
-extern bool inode_owner_or_capable(const struct inode *inode);
+extern bool inode_owner_or_capable(struct user_namespace *mnt_userns,
+				   const struct inode *inode);
 
 /*
  * VFS helper functions..
@@ -1806,8 +1806,9 @@ extern long compat_ptr_ioctl(struct file *file, unsigned int cmd,
 /*
  * VFS file helper functions.
  */
-extern void inode_init_owner(struct inode *inode, const struct inode *dir,
-			umode_t mode);
+extern void inode_init_owner(struct user_namespace *mnt_userns,
+			     struct inode *inode, const struct inode *dir,
+			     umode_t mode);
 extern bool may_open_dev(const struct path *path);
 
 /*
diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
index f1c393e5d47d..dd6f124c12c7 100644
--- a/kernel/bpf/inode.c
+++ b/kernel/bpf/inode.c
@@ -122,7 +122,7 @@ static struct inode *bpf_get_inode(struct super_block *sb,
 	inode->i_mtime = inode->i_atime;
 	inode->i_ctime = inode->i_atime;
 
-	inode_init_owner(inode, dir, mode);
+	inode_init_owner(&init_user_ns, inode, dir, mode);
 
 	return inode;
 }
diff --git a/mm/madvise.c b/mm/madvise.c
index bd87d0019266..5b2ec08e1484 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -539,7 +539,7 @@ static inline bool can_do_pageout(struct vm_area_struct *vma)
 	 * otherwise we'd be including shared non-exclusive mappings, which
 	 * opens a side channel.
 	 */
-	return inode_owner_or_capable(file_inode(vma->vm_file)) ||
+	return inode_owner_or_capable(&init_user_ns, file_inode(vma->vm_file)) ||
 		inode_permission(&init_user_ns, file_inode(vma->vm_file), MAY_WRITE) == 0;
 }
 
diff --git a/mm/mincore.c b/mm/mincore.c
index d5a58e61eac6..ad2dfb7a4500 100644
--- a/mm/mincore.c
+++ b/mm/mincore.c
@@ -166,7 +166,7 @@ static inline bool can_do_mincore(struct vm_area_struct *vma)
 	 * for writing; otherwise we'd be including shared non-exclusive
 	 * mappings, which opens a side channel.
 	 */
-	return inode_owner_or_capable(file_inode(vma->vm_file)) ||
+	return inode_owner_or_capable(&init_user_ns, file_inode(vma->vm_file)) ||
 		inode_permission(&init_user_ns, file_inode(vma->vm_file), MAY_WRITE) == 0;
 }
 
diff --git a/mm/shmem.c b/mm/shmem.c
index 537c137698f8..90dfdc8b7423 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2303,7 +2303,7 @@ static struct inode *shmem_get_inode(struct super_block *sb, const struct inode
 	inode = new_inode(sb);
 	if (inode) {
 		inode->i_ino = ino;
-		inode_init_owner(inode, dir, mode);
+		inode_init_owner(&init_user_ns, inode, dir, mode);
 		inode->i_blocks = 0;
 		inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
 		inode->i_generation = prandom_u32();
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 6b1826fc3658..14a195fa55eb 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3133,13 +3133,13 @@ static int selinux_inode_setxattr(struct dentry *dentry, const char *name,
 	}
 
 	if (!selinux_initialized(&selinux_state))
-		return (inode_owner_or_capable(inode) ? 0 : -EPERM);
+		return (inode_owner_or_capable(&init_user_ns, inode) ? 0 : -EPERM);
 
 	sbsec = inode->i_sb->s_security;
 	if (!(sbsec->flags & SBLABEL_MNT))
 		return -EOPNOTSUPP;
 
-	if (!inode_owner_or_capable(inode))
+	if (!inode_owner_or_capable(&init_user_ns, inode))
 		return -EPERM;
 
 	ad.type = LSM_AUDIT_DATA_DENTRY;
-- 
2.29.2

