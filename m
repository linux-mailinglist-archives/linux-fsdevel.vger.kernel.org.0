Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E67752CE43D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Dec 2020 01:13:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502124AbgLDAMd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Dec 2020 19:12:33 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:43190 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbgLDAMd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Dec 2020 19:12:33 -0500
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kkyY7-0007ka-FP; Fri, 04 Dec 2020 00:02:11 +0000
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
Subject: [PATCH v4 31/40] fs: make helpers idmap mount aware
Date:   Fri,  4 Dec 2020 00:57:27 +0100
Message-Id: <20201203235736.3528991-32-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201203235736.3528991-1-christian.brauner@ubuntu.com>
References: <20201203235736.3528991-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Extend some inode methods with an additional user namespace argument. A
filesystem that is aware of idmapped mounts will receive the user
namespace the mount has been marked with. This can be used for
additional permission checking and also to enable filesystems to
translate between uids and gids if they need to. We have implemented all
relevant helpers in earlier patches.

As requested we simply extend the exisiting inode method instead of
introducing new ones. This is a little more code churn but it's mostly
mechanical and doesnt't leave us with additional inode methods.

Cc: Christoph Hellwig <hch@lst.de>
Cc: David Howells <dhowells@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
- Christoph Hellwig <hch@lst.de>:
  - Don't pollute the vfs with additional helpers simply extend the existing
    inode methods with an additional argument and switch all callers.

/* v3 */
- kernel test robot <lkp@intel.com>:
  - Fix call to simple_rename() in drivers/android/binderfs.c.
  - Fix ntfs_setattr() in fs/ntfs/file.c.

/* v4 */
- Serge Hallyn <serge@hallyn.com>:
  - Use "mnt_userns" to refer to a vfsmount's userns everywhere to make
    terminology consistent.
---
 Documentation/filesystems/vfs.rst         | 19 +++++----
 arch/powerpc/platforms/cell/spufs/inode.c |  3 +-
 drivers/android/binderfs.c                |  6 ++-
 fs/9p/acl.c                               |  4 +-
 fs/9p/v9fs.h                              |  3 +-
 fs/9p/v9fs_vfs.h                          |  2 +-
 fs/9p/vfs_inode.c                         | 26 +++++++-----
 fs/9p/vfs_inode_dotl.c                    | 31 ++++++++------
 fs/adfs/adfs.h                            |  3 +-
 fs/adfs/inode.c                           |  3 +-
 fs/affs/affs.h                            | 10 ++---
 fs/affs/inode.c                           |  3 +-
 fs/affs/namei.c                           | 15 ++++---
 fs/afs/dir.c                              | 34 ++++++++-------
 fs/afs/inode.c                            |  7 +--
 fs/afs/internal.h                         |  7 +--
 fs/afs/security.c                         |  2 +-
 fs/attr.c                                 |  4 +-
 fs/autofs/root.c                          | 13 +++---
 fs/bad_inode.c                            | 36 ++++++++++------
 fs/bfs/dir.c                              | 10 ++---
 fs/btrfs/acl.c                            |  3 +-
 fs/btrfs/ctree.h                          |  3 +-
 fs/btrfs/inode.c                          | 33 ++++++++------
 fs/ceph/acl.c                             |  3 +-
 fs/ceph/dir.c                             | 23 +++++-----
 fs/ceph/inode.c                           |  9 ++--
 fs/ceph/super.h                           | 12 ++++--
 fs/cifs/cifsfs.c                          |  2 +-
 fs/cifs/cifsfs.h                          | 21 ++++-----
 fs/cifs/dir.c                             |  8 ++--
 fs/cifs/inode.c                           | 16 ++++---
 fs/cifs/link.c                            |  3 +-
 fs/coda/coda_linux.h                      |  6 +--
 fs/coda/dir.c                             | 17 +++++---
 fs/coda/inode.c                           |  7 +--
 fs/coda/pioctl.c                          |  6 ++-
 fs/configfs/configfs_internal.h           |  7 +--
 fs/configfs/dir.c                         |  3 +-
 fs/configfs/inode.c                       |  5 ++-
 fs/configfs/symlink.c                     |  3 +-
 fs/debugfs/inode.c                        |  9 ++--
 fs/ecryptfs/inode.c                       | 31 ++++++++------
 fs/efivarfs/inode.c                       |  4 +-
 fs/erofs/inode.c                          |  5 ++-
 fs/erofs/internal.h                       |  5 ++-
 fs/exfat/exfat_fs.h                       |  8 ++--
 fs/exfat/file.c                           |  8 ++--
 fs/exfat/namei.c                          | 14 +++---
 fs/ext2/acl.c                             |  3 +-
 fs/ext2/acl.h                             |  3 +-
 fs/ext2/ext2.h                            |  5 ++-
 fs/ext2/inode.c                           |  7 +--
 fs/ext2/namei.c                           | 22 ++++++----
 fs/ext4/acl.c                             |  3 +-
 fs/ext4/acl.h                             |  3 +-
 fs/ext4/ext4.h                            |  8 ++--
 fs/ext4/inode.c                           | 12 +++---
 fs/ext4/namei.c                           | 19 +++++----
 fs/f2fs/acl.c                             |  3 +-
 fs/f2fs/acl.h                             |  3 +-
 fs/f2fs/f2fs.h                            |  7 +--
 fs/f2fs/file.c                            |  7 +--
 fs/f2fs/namei.c                           | 21 +++++----
 fs/fat/fat.h                              |  6 ++-
 fs/fat/file.c                             |  9 ++--
 fs/fat/namei_msdos.c                      | 10 +++--
 fs/fat/namei_vfat.c                       | 13 +++---
 fs/fuse/acl.c                             |  3 +-
 fs/fuse/dir.c                             | 37 +++++++++-------
 fs/fuse/fuse_i.h                          |  4 +-
 fs/gfs2/acl.c                             |  3 +-
 fs/gfs2/acl.h                             |  3 +-
 fs/gfs2/file.c                            |  2 +-
 fs/gfs2/inode.c                           | 49 ++++++++++++---------
 fs/gfs2/inode.h                           |  3 +-
 fs/hfs/dir.c                              | 13 +++---
 fs/hfs/hfs_fs.h                           |  2 +-
 fs/hfs/inode.c                            |  3 +-
 fs/hfsplus/dir.c                          | 25 +++++------
 fs/hfsplus/hfsplus_fs.h                   |  5 ++-
 fs/hfsplus/inode.c                        |  8 ++--
 fs/hostfs/hostfs_kern.c                   | 23 ++++++----
 fs/hpfs/hpfs_fn.h                         |  2 +-
 fs/hpfs/inode.c                           |  3 +-
 fs/hpfs/namei.c                           | 20 +++++----
 fs/hugetlbfs/inode.c                      | 25 ++++++-----
 fs/jffs2/acl.c                            |  3 +-
 fs/jffs2/acl.h                            |  3 +-
 fs/jffs2/dir.c                            | 32 ++++++++------
 fs/jffs2/fs.c                             |  3 +-
 fs/jffs2/os-linux.h                       |  2 +-
 fs/jfs/acl.c                              |  3 +-
 fs/jfs/file.c                             |  3 +-
 fs/jfs/jfs_acl.h                          |  3 +-
 fs/jfs/jfs_inode.h                        |  2 +-
 fs/jfs/namei.c                            | 21 ++++-----
 fs/kernfs/dir.c                           |  7 +--
 fs/kernfs/inode.c                         |  9 ++--
 fs/kernfs/kernfs-internal.h               |  9 ++--
 fs/libfs.c                                | 31 +++++++-------
 fs/minix/file.c                           |  3 +-
 fs/minix/inode.c                          |  4 +-
 fs/minix/minix.h                          |  3 +-
 fs/minix/namei.c                          | 24 ++++++-----
 fs/namei.c                                | 51 ++++++++++++----------
 fs/nfs/dir.c                              | 23 ++++++----
 fs/nfs/inode.c                            |  7 +--
 fs/nfs/internal.h                         | 10 ++---
 fs/nfs/namespace.c                        | 12 +++---
 fs/nfs/nfs3_fs.h                          |  3 +-
 fs/nfs/nfs3acl.c                          |  3 +-
 fs/nilfs2/inode.c                         |  5 ++-
 fs/nilfs2/namei.c                         | 19 +++++----
 fs/nilfs2/nilfs.h                         |  4 +-
 fs/ntfs/inode.c                           |  4 +-
 fs/ntfs/inode.h                           |  3 +-
 fs/ocfs2/acl.c                            |  3 +-
 fs/ocfs2/acl.h                            |  3 +-
 fs/ocfs2/dlmfs/dlmfs.c                    |  9 ++--
 fs/ocfs2/file.c                           |  9 ++--
 fs/ocfs2/file.h                           | 11 +++--
 fs/ocfs2/namei.c                          | 19 ++++++---
 fs/omfs/dir.c                             | 13 +++---
 fs/omfs/file.c                            |  3 +-
 fs/orangefs/acl.c                         |  3 +-
 fs/orangefs/inode.c                       | 10 +++--
 fs/orangefs/namei.c                       | 12 ++++--
 fs/orangefs/orangefs-kernel.h             | 13 +++---
 fs/overlayfs/dir.c                        | 21 ++++-----
 fs/overlayfs/inode.c                      | 10 +++--
 fs/overlayfs/overlayfs.h                  |  9 ++--
 fs/overlayfs/super.c                      |  2 +-
 fs/posix_acl.c                            |  9 ++--
 fs/proc/base.c                            | 16 ++++---
 fs/proc/fd.c                              |  3 +-
 fs/proc/fd.h                              |  3 +-
 fs/proc/generic.c                         |  6 ++-
 fs/proc/internal.h                        |  5 ++-
 fs/proc/proc_net.c                        |  3 +-
 fs/proc/proc_sysctl.c                     |  9 ++--
 fs/proc/root.c                            |  3 +-
 fs/ramfs/file-nommu.c                     |  5 ++-
 fs/ramfs/inode.c                          | 16 ++++---
 fs/reiserfs/acl.h                         |  3 +-
 fs/reiserfs/inode.c                       |  3 +-
 fs/reiserfs/namei.c                       | 19 +++++----
 fs/reiserfs/reiserfs.h                    |  3 +-
 fs/reiserfs/xattr.c                       | 10 ++---
 fs/reiserfs/xattr.h                       |  3 +-
 fs/reiserfs/xattr_acl.c                   |  3 +-
 fs/stat.c                                 |  8 ++--
 fs/sysv/file.c                            |  3 +-
 fs/sysv/itree.c                           |  4 +-
 fs/sysv/namei.c                           | 21 +++++----
 fs/sysv/sysv.h                            |  3 +-
 fs/tracefs/inode.c                        |  4 +-
 fs/ubifs/dir.c                            | 26 ++++++------
 fs/ubifs/file.c                           |  3 +-
 fs/ubifs/ubifs.h                          |  5 ++-
 fs/udf/file.c                             |  3 +-
 fs/udf/namei.c                            | 24 ++++++-----
 fs/udf/symlink.c                          |  5 ++-
 fs/ufs/inode.c                            |  3 +-
 fs/ufs/namei.c                            | 19 +++++----
 fs/ufs/ufs.h                              |  3 +-
 fs/vboxsf/dir.c                           | 12 ++++--
 fs/vboxsf/utils.c                         |  7 +--
 fs/vboxsf/vfsmod.h                        |  8 ++--
 fs/xfs/xfs_acl.c                          |  3 +-
 fs/xfs/xfs_acl.h                          |  3 +-
 fs/xfs/xfs_iops.c                         | 52 +++++++++++++----------
 fs/zonefs/super.c                         |  3 +-
 include/linux/fs.h                        | 31 ++++++++------
 include/linux/nfs_fs.h                    |  7 +--
 include/linux/posix_acl.h                 |  2 +-
 ipc/mqueue.c                              |  4 +-
 kernel/bpf/inode.c                        |  7 +--
 mm/shmem.c                                | 37 ++++++++++------
 net/socket.c                              |  5 ++-
 security/apparmor/apparmorfs.c            |  3 +-
 security/integrity/evm/evm_secfs.c        |  2 +-
 182 files changed, 1055 insertions(+), 758 deletions(-)

diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index ca52c82e5bb5..98290ef311ca 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -415,28 +415,29 @@ As of kernel 2.6.22, the following members are defined:
 .. code-block:: c
 
 	struct inode_operations {
-		int (*create) (struct inode *,struct dentry *, umode_t, bool);
+		int (*create) (struct user_namespace *, struct inode *,struct dentry *, umode_t, bool);
 		struct dentry * (*lookup) (struct inode *,struct dentry *, unsigned int);
 		int (*link) (struct dentry *,struct inode *,struct dentry *);
 		int (*unlink) (struct inode *,struct dentry *);
-		int (*symlink) (struct inode *,struct dentry *,const char *);
-		int (*mkdir) (struct inode *,struct dentry *,umode_t);
+		int (*symlink) (struct user_namespace *, struct inode *,struct dentry *,const char *);
+		int (*mkdir) (struct user_namespace *, struct inode *,struct dentry *,umode_t);
 		int (*rmdir) (struct inode *,struct dentry *);
-		int (*mknod) (struct inode *,struct dentry *,umode_t,dev_t);
-		int (*rename) (struct inode *, struct dentry *,
+		int (*mknod) (struct user_namespace *, struct inode *,struct dentry *,umode_t,dev_t);
+		int (*rename) (struct user_namespace *, struct inode *, struct dentry *,
 			       struct inode *, struct dentry *, unsigned int);
 		int (*readlink) (struct dentry *, char __user *,int);
 		const char *(*get_link) (struct dentry *, struct inode *,
 					 struct delayed_call *);
-		int (*permission) (struct inode *, int);
+		int (*permission) (struct user_namespace *, struct inode *, int);
 		int (*get_acl)(struct inode *, int);
-		int (*setattr) (struct dentry *, struct iattr *);
-		int (*getattr) (const struct path *, struct kstat *, u32, unsigned int);
+		int (*setattr) (struct user_namespace *, struct dentry *, struct iattr *);
+		int (*getattr) (struct user_namespace *, const struct path *, struct kstat *, u32, unsigned int);
 		ssize_t (*listxattr) (struct dentry *, char *, size_t);
 		void (*update_time)(struct inode *, struct timespec *, int);
 		int (*atomic_open)(struct inode *, struct dentry *, struct file *,
 				   unsigned open_flag, umode_t create_mode);
-		int (*tmpfile) (struct inode *, struct dentry *, umode_t);
+		int (*tmpfile) (struct user_namespace *, struct inode *, struct dentry *, umode_t);
+	        int (*set_acl)(struct user_namespace *, struct inode *, struct posix_acl *, int);
 	};
 
 Again, all methods are called without any locks being held, unless
diff --git a/arch/powerpc/platforms/cell/spufs/inode.c b/arch/powerpc/platforms/cell/spufs/inode.c
index 3de526eb2275..b83a3670bd74 100644
--- a/arch/powerpc/platforms/cell/spufs/inode.c
+++ b/arch/powerpc/platforms/cell/spufs/inode.c
@@ -91,7 +91,8 @@ spufs_new_inode(struct super_block *sb, umode_t mode)
 }
 
 static int
-spufs_setattr(struct dentry *dentry, struct iattr *attr)
+spufs_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
+	      struct iattr *attr)
 {
 	struct inode *inode = d_inode(dentry);
 
diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
index 7b4f154f07e6..e80ba93c62a9 100644
--- a/drivers/android/binderfs.c
+++ b/drivers/android/binderfs.c
@@ -355,7 +355,8 @@ static inline bool is_binderfs_control_device(const struct dentry *dentry)
 	return info->control_dentry == dentry;
 }
 
-static int binderfs_rename(struct inode *old_dir, struct dentry *old_dentry,
+static int binderfs_rename(struct user_namespace *mnt_userns,
+			   struct inode *old_dir, struct dentry *old_dentry,
 			   struct inode *new_dir, struct dentry *new_dentry,
 			   unsigned int flags)
 {
@@ -363,7 +364,8 @@ static int binderfs_rename(struct inode *old_dir, struct dentry *old_dentry,
 	    is_binderfs_control_device(new_dentry))
 		return -EPERM;
 
-	return simple_rename(old_dir, old_dentry, new_dir, new_dentry, flags);
+	return simple_rename(&init_user_ns, old_dir, old_dentry, new_dir,
+			     new_dentry, flags);
 }
 
 static int binderfs_unlink(struct inode *dir, struct dentry *dentry)
diff --git a/fs/9p/acl.c b/fs/9p/acl.c
index 1c14f18a6ec9..bb1b286c49ae 100644
--- a/fs/9p/acl.c
+++ b/fs/9p/acl.c
@@ -280,7 +280,7 @@ static int v9fs_xattr_set_acl(const struct xattr_handler *handler,
 			struct iattr iattr = { 0 };
 			struct posix_acl *old_acl = acl;
 
-			retval = posix_acl_update_mode(mnt_userns, inode,
+			retval = posix_acl_update_mode(&init_user_ns, inode,
 						       &iattr.ia_mode, &acl);
 			if (retval)
 				goto err_out;
@@ -299,7 +299,7 @@ static int v9fs_xattr_set_acl(const struct xattr_handler *handler,
 			 * What is the following setxattr update the
 			 * mode ?
 			 */
-			v9fs_vfs_setattr_dotl(dentry, &iattr);
+			v9fs_vfs_setattr_dotl(&init_user_ns, dentry, &iattr);
 		}
 		break;
 	case ACL_TYPE_DEFAULT:
diff --git a/fs/9p/v9fs.h b/fs/9p/v9fs.h
index 7b763776306e..4ca56c5dd637 100644
--- a/fs/9p/v9fs.h
+++ b/fs/9p/v9fs.h
@@ -135,7 +135,8 @@ extern struct dentry *v9fs_vfs_lookup(struct inode *dir, struct dentry *dentry,
 			unsigned int flags);
 extern int v9fs_vfs_unlink(struct inode *i, struct dentry *d);
 extern int v9fs_vfs_rmdir(struct inode *i, struct dentry *d);
-extern int v9fs_vfs_rename(struct inode *old_dir, struct dentry *old_dentry,
+extern int v9fs_vfs_rename(struct user_namespace *mnt_userns,
+			   struct inode *old_dir, struct dentry *old_dentry,
 			   struct inode *new_dir, struct dentry *new_dentry,
 			   unsigned int flags);
 extern struct inode *v9fs_inode_from_fid(struct v9fs_session_info *v9ses,
diff --git a/fs/9p/v9fs_vfs.h b/fs/9p/v9fs_vfs.h
index fd2a2b040250..f65e95f7fb20 100644
--- a/fs/9p/v9fs_vfs.h
+++ b/fs/9p/v9fs_vfs.h
@@ -59,7 +59,7 @@ void v9fs_inode2stat(struct inode *inode, struct p9_wstat *stat);
 int v9fs_uflags2omode(int uflags, int extended);
 
 void v9fs_blank_wstat(struct p9_wstat *wstat);
-int v9fs_vfs_setattr_dotl(struct dentry *, struct iattr *);
+int v9fs_vfs_setattr_dotl(struct user_namespace *, struct dentry *, struct iattr *);
 int v9fs_file_fsync_dotl(struct file *filp, loff_t start, loff_t end,
 			 int datasync);
 int v9fs_refresh_inode(struct p9_fid *fid, struct inode *inode);
diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index ca3ac5a8daa8..5446a7f1fb02 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -667,8 +667,8 @@ v9fs_create(struct v9fs_session_info *v9ses, struct inode *dir,
  */
 
 static int
-v9fs_vfs_create(struct inode *dir, struct dentry *dentry, umode_t mode,
-		bool excl)
+v9fs_vfs_create(struct user_namespace *mnt_userns, struct inode *dir,
+		struct dentry *dentry, umode_t mode, bool excl)
 {
 	struct v9fs_session_info *v9ses = v9fs_inode2v9ses(dir);
 	u32 perm = unixmode2p9mode(v9ses, mode);
@@ -693,7 +693,8 @@ v9fs_vfs_create(struct inode *dir, struct dentry *dentry, umode_t mode,
  *
  */
 
-static int v9fs_vfs_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
+static int v9fs_vfs_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
+			  struct dentry *dentry, umode_t mode)
 {
 	int err;
 	u32 perm;
@@ -894,9 +895,9 @@ int v9fs_vfs_rmdir(struct inode *i, struct dentry *d)
  */
 
 int
-v9fs_vfs_rename(struct inode *old_dir, struct dentry *old_dentry,
-		struct inode *new_dir, struct dentry *new_dentry,
-		unsigned int flags)
+v9fs_vfs_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
+		struct dentry *old_dentry, struct inode *new_dir,
+		struct dentry *new_dentry, unsigned int flags)
 {
 	int retval;
 	struct inode *old_inode;
@@ -995,8 +996,8 @@ v9fs_vfs_rename(struct inode *old_dir, struct dentry *old_dentry,
  */
 
 static int
-v9fs_vfs_getattr(const struct path *path, struct kstat *stat,
-		 u32 request_mask, unsigned int flags)
+v9fs_vfs_getattr(struct user_namespace *mnt_userns, const struct path *path,
+		 struct kstat *stat, u32 request_mask, unsigned int flags)
 {
 	struct dentry *dentry = path->dentry;
 	struct v9fs_session_info *v9ses;
@@ -1032,7 +1033,8 @@ v9fs_vfs_getattr(const struct path *path, struct kstat *stat,
  *
  */
 
-static int v9fs_vfs_setattr(struct dentry *dentry, struct iattr *iattr)
+static int v9fs_vfs_setattr(struct user_namespace *mnt_userns,
+			    struct dentry *dentry, struct iattr *iattr)
 {
 	int retval;
 	struct v9fs_session_info *v9ses;
@@ -1266,7 +1268,8 @@ static int v9fs_vfs_mkspecial(struct inode *dir, struct dentry *dentry,
  */
 
 static int
-v9fs_vfs_symlink(struct inode *dir, struct dentry *dentry, const char *symname)
+v9fs_vfs_symlink(struct user_namespace *mnt_userns, struct inode *dir,
+		 struct dentry *dentry, const char *symname)
 {
 	p9_debug(P9_DEBUG_VFS, " %lu,%pd,%s\n",
 		 dir->i_ino, dentry, symname);
@@ -1319,7 +1322,8 @@ v9fs_vfs_link(struct dentry *old_dentry, struct inode *dir,
  */
 
 static int
-v9fs_vfs_mknod(struct inode *dir, struct dentry *dentry, umode_t mode, dev_t rdev)
+v9fs_vfs_mknod(struct user_namespace *mnt_userns, struct inode *dir,
+	       struct dentry *dentry, umode_t mode, dev_t rdev)
 {
 	struct v9fs_session_info *v9ses = v9fs_inode2v9ses(dir);
 	int retval;
diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index 8f3c1daf72ba..893b48154e05 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -33,8 +33,8 @@
 #include "acl.h"
 
 static int
-v9fs_vfs_mknod_dotl(struct inode *dir, struct dentry *dentry, umode_t omode,
-		    dev_t rdev);
+v9fs_vfs_mknod_dotl(struct user_namespace *mnt_userns, struct inode *dir,
+		    struct dentry *dentry, umode_t omode, dev_t rdev);
 
 /**
  * v9fs_get_fsgid_for_create - Helper function to get the gid for creating a
@@ -218,10 +218,10 @@ int v9fs_open_to_dotl_flags(int flags)
  */
 
 static int
-v9fs_vfs_create_dotl(struct inode *dir, struct dentry *dentry, umode_t omode,
-		bool excl)
+v9fs_vfs_create_dotl(struct user_namespace *mnt_userns, struct inode *dir,
+		     struct dentry *dentry, umode_t omode, bool excl)
 {
-	return v9fs_vfs_mknod_dotl(dir, dentry, omode, 0);
+	return v9fs_vfs_mknod_dotl(mnt_userns, dir, dentry, omode, 0);
 }
 
 static int
@@ -365,8 +365,9 @@ v9fs_vfs_atomic_open_dotl(struct inode *dir, struct dentry *dentry,
  *
  */
 
-static int v9fs_vfs_mkdir_dotl(struct inode *dir,
-			       struct dentry *dentry, umode_t omode)
+static int v9fs_vfs_mkdir_dotl(struct user_namespace *mnt_userns,
+			       struct inode *dir, struct dentry *dentry,
+			       umode_t omode)
 {
 	int err;
 	struct v9fs_session_info *v9ses;
@@ -455,8 +456,9 @@ static int v9fs_vfs_mkdir_dotl(struct inode *dir,
 }
 
 static int
-v9fs_vfs_getattr_dotl(const struct path *path, struct kstat *stat,
-		 u32 request_mask, unsigned int flags)
+v9fs_vfs_getattr_dotl(struct user_namespace *mnt_userns,
+		      const struct path *path, struct kstat *stat,
+		      u32 request_mask, unsigned int flags)
 {
 	struct dentry *dentry = path->dentry;
 	struct v9fs_session_info *v9ses;
@@ -537,7 +539,8 @@ static int v9fs_mapped_iattr_valid(int iattr_valid)
  *
  */
 
-int v9fs_vfs_setattr_dotl(struct dentry *dentry, struct iattr *iattr)
+int v9fs_vfs_setattr_dotl(struct user_namespace *mnt_userns, struct dentry *dentry,
+			  struct iattr *iattr)
 {
 	int retval;
 	struct p9_fid *fid = NULL;
@@ -670,8 +673,8 @@ v9fs_stat2inode_dotl(struct p9_stat_dotl *stat, struct inode *inode,
 }
 
 static int
-v9fs_vfs_symlink_dotl(struct inode *dir, struct dentry *dentry,
-		const char *symname)
+v9fs_vfs_symlink_dotl(struct user_namespace *mnt_userns, struct inode *dir,
+		      struct dentry *dentry, const char *symname)
 {
 	int err;
 	kgid_t gid;
@@ -804,8 +807,8 @@ v9fs_vfs_link_dotl(struct dentry *old_dentry, struct inode *dir,
  *
  */
 static int
-v9fs_vfs_mknod_dotl(struct inode *dir, struct dentry *dentry, umode_t omode,
-		dev_t rdev)
+v9fs_vfs_mknod_dotl(struct user_namespace *mnt_userns, struct inode *dir,
+		    struct dentry *dentry, umode_t omode, dev_t rdev)
 {
 	int err;
 	kgid_t gid;
diff --git a/fs/adfs/adfs.h b/fs/adfs/adfs.h
index 699c4fa8b78b..06b7c92343ad 100644
--- a/fs/adfs/adfs.h
+++ b/fs/adfs/adfs.h
@@ -144,7 +144,8 @@ struct adfs_discmap {
 /* Inode stuff */
 struct inode *adfs_iget(struct super_block *sb, struct object_info *obj);
 int adfs_write_inode(struct inode *inode, struct writeback_control *wbc);
-int adfs_notify_change(struct dentry *dentry, struct iattr *attr);
+int adfs_notify_change(struct user_namespace *mnt_userns, struct dentry *dentry,
+		       struct iattr *attr);
 
 /* map.c */
 int adfs_map_lookup(struct super_block *sb, u32 frag_id, unsigned int offset);
diff --git a/fs/adfs/inode.c b/fs/adfs/inode.c
index 278dcee6ae22..fb7ee026d101 100644
--- a/fs/adfs/inode.c
+++ b/fs/adfs/inode.c
@@ -292,7 +292,8 @@ adfs_iget(struct super_block *sb, struct object_info *obj)
  * later.
  */
 int
-adfs_notify_change(struct dentry *dentry, struct iattr *attr)
+adfs_notify_change(struct user_namespace *mnt_userns, struct dentry *dentry,
+		   struct iattr *attr)
 {
 	struct inode *inode = d_inode(dentry);
 	struct super_block *sb = inode->i_sb;
diff --git a/fs/affs/affs.h b/fs/affs/affs.h
index a755bef7c4c7..59cc1e6fa0ea 100644
--- a/fs/affs/affs.h
+++ b/fs/affs/affs.h
@@ -167,21 +167,21 @@ extern const struct export_operations affs_export_ops;
 extern int	affs_hash_name(struct super_block *sb, const u8 *name, unsigned int len);
 extern struct dentry *affs_lookup(struct inode *dir, struct dentry *dentry, unsigned int);
 extern int	affs_unlink(struct inode *dir, struct dentry *dentry);
-extern int	affs_create(struct inode *dir, struct dentry *dentry, umode_t mode, bool);
-extern int	affs_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode);
+extern int	affs_create(struct user_namespace *mnt_userns, struct inode *dir, struct dentry *dentry, umode_t mode, bool);
+extern int	affs_mkdir(struct user_namespace *mnt_userns, struct inode *dir, struct dentry *dentry, umode_t mode);
 extern int	affs_rmdir(struct inode *dir, struct dentry *dentry);
 extern int	affs_link(struct dentry *olddentry, struct inode *dir,
 			  struct dentry *dentry);
-extern int	affs_symlink(struct inode *dir, struct dentry *dentry,
+extern int	affs_symlink(struct user_namespace *mnt_userns, struct inode *dir, struct dentry *dentry,
 			     const char *symname);
-extern int	affs_rename2(struct inode *old_dir, struct dentry *old_dentry,
+extern int	affs_rename2(struct user_namespace *mnt_userns, struct inode *old_dir, struct dentry *old_dentry,
 			    struct inode *new_dir, struct dentry *new_dentry,
 			    unsigned int flags);
 
 /* inode.c */
 
 extern struct inode		*affs_new_inode(struct inode *dir);
-extern int			 affs_notify_change(struct dentry *dentry, struct iattr *attr);
+extern int			 affs_notify_change(struct user_namespace *mnt_userns, struct dentry *dentry, struct iattr *attr);
 extern void			 affs_evict_inode(struct inode *inode);
 extern struct inode		*affs_iget(struct super_block *sb,
 					unsigned long ino);
diff --git a/fs/affs/inode.c b/fs/affs/inode.c
index 767e5bdfb703..2352a75bd9d6 100644
--- a/fs/affs/inode.c
+++ b/fs/affs/inode.c
@@ -216,7 +216,8 @@ affs_write_inode(struct inode *inode, struct writeback_control *wbc)
 }
 
 int
-affs_notify_change(struct dentry *dentry, struct iattr *attr)
+affs_notify_change(struct user_namespace *mnt_userns, struct dentry *dentry,
+		   struct iattr *attr)
 {
 	struct inode *inode = d_inode(dentry);
 	int error;
diff --git a/fs/affs/namei.c b/fs/affs/namei.c
index 41c5749f4db7..9ad22befce28 100644
--- a/fs/affs/namei.c
+++ b/fs/affs/namei.c
@@ -242,7 +242,8 @@ affs_unlink(struct inode *dir, struct dentry *dentry)
 }
 
 int
-affs_create(struct inode *dir, struct dentry *dentry, umode_t mode, bool excl)
+affs_create(struct user_namespace *mnt_userns, struct inode *dir,
+	    struct dentry *dentry, umode_t mode, bool excl)
 {
 	struct super_block *sb = dir->i_sb;
 	struct inode	*inode;
@@ -273,7 +274,8 @@ affs_create(struct inode *dir, struct dentry *dentry, umode_t mode, bool excl)
 }
 
 int
-affs_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
+affs_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
+	   struct dentry *dentry, umode_t mode)
 {
 	struct inode		*inode;
 	int			 error;
@@ -311,7 +313,8 @@ affs_rmdir(struct inode *dir, struct dentry *dentry)
 }
 
 int
-affs_symlink(struct inode *dir, struct dentry *dentry, const char *symname)
+affs_symlink(struct user_namespace *mnt_userns, struct inode *dir,
+	     struct dentry *dentry, const char *symname)
 {
 	struct super_block	*sb = dir->i_sb;
 	struct buffer_head	*bh;
@@ -498,9 +501,9 @@ affs_xrename(struct inode *old_dir, struct dentry *old_dentry,
 	return retval;
 }
 
-int affs_rename2(struct inode *old_dir, struct dentry *old_dentry,
-			struct inode *new_dir, struct dentry *new_dentry,
-			unsigned int flags)
+int affs_rename2(struct user_namespace *mnt_userns, struct inode *old_dir,
+		 struct dentry *old_dentry, struct inode *new_dir,
+		 struct dentry *new_dentry, unsigned int flags)
 {
 
 	if (flags & ~(RENAME_NOREPLACE | RENAME_EXCHANGE))
diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 9068d5578a26..3b7d1288d2b9 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -28,18 +28,19 @@ static int afs_lookup_one_filldir(struct dir_context *ctx, const char *name, int
 				  loff_t fpos, u64 ino, unsigned dtype);
 static int afs_lookup_filldir(struct dir_context *ctx, const char *name, int nlen,
 			      loff_t fpos, u64 ino, unsigned dtype);
-static int afs_create(struct inode *dir, struct dentry *dentry, umode_t mode,
-		      bool excl);
-static int afs_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode);
+static int afs_create(struct user_namespace *mnt_userns, struct inode *dir,
+		      struct dentry *dentry, umode_t mode, bool excl);
+static int afs_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
+		     struct dentry *dentry, umode_t mode);
 static int afs_rmdir(struct inode *dir, struct dentry *dentry);
 static int afs_unlink(struct inode *dir, struct dentry *dentry);
 static int afs_link(struct dentry *from, struct inode *dir,
 		    struct dentry *dentry);
-static int afs_symlink(struct inode *dir, struct dentry *dentry,
-		       const char *content);
-static int afs_rename(struct inode *old_dir, struct dentry *old_dentry,
-		      struct inode *new_dir, struct dentry *new_dentry,
-		      unsigned int flags);
+static int afs_symlink(struct user_namespace *mnt_userns, struct inode *dir,
+		       struct dentry *dentry, const char *content);
+static int afs_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
+		      struct dentry *old_dentry, struct inode *new_dir,
+		      struct dentry *new_dentry, unsigned int flags);
 static int afs_dir_releasepage(struct page *page, gfp_t gfp_flags);
 static void afs_dir_invalidatepage(struct page *page, unsigned int offset,
 				   unsigned int length);
@@ -1322,7 +1323,8 @@ static const struct afs_operation_ops afs_mkdir_operation = {
 /*
  * create a directory on an AFS filesystem
  */
-static int afs_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
+static int afs_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
+		     struct dentry *dentry, umode_t mode)
 {
 	struct afs_operation *op;
 	struct afs_vnode *dvnode = AFS_FS_I(dir);
@@ -1616,8 +1618,8 @@ static const struct afs_operation_ops afs_create_operation = {
 /*
  * create a regular file on an AFS filesystem
  */
-static int afs_create(struct inode *dir, struct dentry *dentry, umode_t mode,
-		      bool excl)
+static int afs_create(struct user_namespace *mnt_userns, struct inode *dir,
+		      struct dentry *dentry, umode_t mode, bool excl)
 {
 	struct afs_operation *op;
 	struct afs_vnode *dvnode = AFS_FS_I(dir);
@@ -1738,8 +1740,8 @@ static const struct afs_operation_ops afs_symlink_operation = {
 /*
  * create a symlink in an AFS filesystem
  */
-static int afs_symlink(struct inode *dir, struct dentry *dentry,
-		       const char *content)
+static int afs_symlink(struct user_namespace *mnt_userns, struct inode *dir,
+		       struct dentry *dentry, const char *content)
 {
 	struct afs_operation *op;
 	struct afs_vnode *dvnode = AFS_FS_I(dir);
@@ -1873,9 +1875,9 @@ static const struct afs_operation_ops afs_rename_operation = {
 /*
  * rename a file in an AFS filesystem and/or move it between directories
  */
-static int afs_rename(struct inode *old_dir, struct dentry *old_dentry,
-		      struct inode *new_dir, struct dentry *new_dentry,
-		      unsigned int flags)
+static int afs_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
+		      struct dentry *old_dentry, struct inode *new_dir,
+		      struct dentry *new_dentry, unsigned int flags)
 {
 	struct afs_operation *op;
 	struct afs_vnode *orig_dvnode, *new_dvnode, *vnode;
diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index 795ee5cb3817..1156b2df28d3 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -734,8 +734,8 @@ int afs_validate(struct afs_vnode *vnode, struct key *key)
 /*
  * read the attributes of an inode
  */
-int afs_getattr(const struct path *path, struct kstat *stat,
-		u32 request_mask, unsigned int query_flags)
+int afs_getattr(struct user_namespace *mnt_userns, const struct path *path,
+		struct kstat *stat, u32 request_mask, unsigned int query_flags)
 {
 	struct inode *inode = d_inode(path->dentry);
 	struct afs_vnode *vnode = AFS_FS_I(inode);
@@ -857,7 +857,8 @@ static const struct afs_operation_ops afs_setattr_operation = {
 /*
  * set the attributes of an inode
  */
-int afs_setattr(struct dentry *dentry, struct iattr *attr)
+int afs_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
+		struct iattr *attr)
 {
 	struct afs_operation *op;
 	struct afs_vnode *vnode = AFS_FS_I(d_inode(dentry));
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 0d150a29e39e..b626e38e9ab5 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -1149,8 +1149,9 @@ extern struct inode *afs_iget(struct afs_operation *, struct afs_vnode_param *);
 extern struct inode *afs_root_iget(struct super_block *, struct key *);
 extern bool afs_check_validity(struct afs_vnode *);
 extern int afs_validate(struct afs_vnode *, struct key *);
-extern int afs_getattr(const struct path *, struct kstat *, u32, unsigned int);
-extern int afs_setattr(struct dentry *, struct iattr *);
+extern int afs_getattr(struct user_namespace *mnt_userns, const struct path *,
+		       struct kstat *, u32, unsigned int);
+extern int afs_setattr(struct user_namespace *mnt_userns, struct dentry *, struct iattr *);
 extern void afs_evict_inode(struct inode *);
 extern int afs_drop_inode(struct inode *);
 
@@ -1361,7 +1362,7 @@ extern void afs_zap_permits(struct rcu_head *);
 extern struct key *afs_request_key(struct afs_cell *);
 extern struct key *afs_request_key_rcu(struct afs_cell *);
 extern int afs_check_permit(struct afs_vnode *, struct key *, afs_access_t *);
-extern int afs_permission(struct inode *, int);
+extern int afs_permission(struct user_namespace *, struct inode *, int);
 extern void __exit afs_clean_up_permit_cache(void);
 
 /*
diff --git a/fs/afs/security.c b/fs/afs/security.c
index 9cf3102f370c..2c14c543bccb 100644
--- a/fs/afs/security.c
+++ b/fs/afs/security.c
@@ -396,7 +396,7 @@ int afs_check_permit(struct afs_vnode *vnode, struct key *key,
  * - AFS ACLs are attached to directories only, and a file is controlled by its
  *   parent directory's ACL
  */
-int afs_permission(struct inode *inode, int mask)
+int afs_permission(struct user_namespace *mnt_userns, struct inode *inode, int mask)
 {
 	struct afs_vnode *vnode = AFS_FS_I(inode);
 	afs_access_t access;
diff --git a/fs/attr.c b/fs/attr.c
index 3ee0b1b0f207..2a180598d8a5 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -393,9 +393,9 @@ int notify_change(struct user_namespace *mnt_userns, struct dentry *dentry,
 		return error;
 
 	if (inode->i_op->setattr)
-		error = inode->i_op->setattr(dentry, attr);
+		error = inode->i_op->setattr(mnt_userns, dentry, attr);
 	else
-		error = simple_setattr(dentry, attr);
+		error = simple_setattr(mnt_userns, dentry, attr);
 
 	if (!error) {
 		fsnotify_change(dentry, ia_valid);
diff --git a/fs/autofs/root.c b/fs/autofs/root.c
index 5aaa1732bf1e..9aff7d516e6c 100644
--- a/fs/autofs/root.c
+++ b/fs/autofs/root.c
@@ -10,10 +10,12 @@
 
 #include "autofs_i.h"
 
-static int autofs_dir_symlink(struct inode *, struct dentry *, const char *);
+static int autofs_dir_symlink(struct user_namespace *, struct inode *,
+			      struct dentry *, const char *);
 static int autofs_dir_unlink(struct inode *, struct dentry *);
 static int autofs_dir_rmdir(struct inode *, struct dentry *);
-static int autofs_dir_mkdir(struct inode *, struct dentry *, umode_t);
+static int autofs_dir_mkdir(struct user_namespace *, struct inode *,
+			    struct dentry *, umode_t);
 static long autofs_root_ioctl(struct file *, unsigned int, unsigned long);
 #ifdef CONFIG_COMPAT
 static long autofs_root_compat_ioctl(struct file *,
@@ -524,9 +526,8 @@ static struct dentry *autofs_lookup(struct inode *dir,
 	return NULL;
 }
 
-static int autofs_dir_symlink(struct inode *dir,
-			       struct dentry *dentry,
-			       const char *symname)
+static int autofs_dir_symlink(struct user_namespace *mnt_userns, struct inode *dir,
+			      struct dentry *dentry, const char *symname)
 {
 	struct autofs_sb_info *sbi = autofs_sbi(dir->i_sb);
 	struct autofs_info *ino = autofs_dentry_ino(dentry);
@@ -715,7 +716,7 @@ static int autofs_dir_rmdir(struct inode *dir, struct dentry *dentry)
 	return 0;
 }
 
-static int autofs_dir_mkdir(struct inode *dir,
+static int autofs_dir_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
 			    struct dentry *dentry, umode_t mode)
 {
 	struct autofs_sb_info *sbi = autofs_sbi(dir->i_sb);
diff --git a/fs/bad_inode.c b/fs/bad_inode.c
index 54f0ce444272..48e16144c1f7 100644
--- a/fs/bad_inode.c
+++ b/fs/bad_inode.c
@@ -27,8 +27,9 @@ static const struct file_operations bad_file_ops =
 	.open		= bad_file_open,
 };
 
-static int bad_inode_create (struct inode *dir, struct dentry *dentry,
-		umode_t mode, bool excl)
+static int bad_inode_create(struct user_namespace *mnt_userns,
+			    struct inode *dir, struct dentry *dentry,
+			    umode_t mode, bool excl)
 {
 	return -EIO;
 }
@@ -50,14 +51,15 @@ static int bad_inode_unlink(struct inode *dir, struct dentry *dentry)
 	return -EIO;
 }
 
-static int bad_inode_symlink (struct inode *dir, struct dentry *dentry,
-		const char *symname)
+static int bad_inode_symlink(struct user_namespace *mnt_userns,
+			     struct inode *dir, struct dentry *dentry,
+			     const char *symname)
 {
 	return -EIO;
 }
 
-static int bad_inode_mkdir(struct inode *dir, struct dentry *dentry,
-			umode_t mode)
+static int bad_inode_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
+			   struct dentry *dentry, umode_t mode)
 {
 	return -EIO;
 }
@@ -67,13 +69,14 @@ static int bad_inode_rmdir (struct inode *dir, struct dentry *dentry)
 	return -EIO;
 }
 
-static int bad_inode_mknod (struct inode *dir, struct dentry *dentry,
-			umode_t mode, dev_t rdev)
+static int bad_inode_mknod(struct user_namespace *mnt_userns, struct inode *dir,
+			   struct dentry *dentry, umode_t mode, dev_t rdev)
 {
 	return -EIO;
 }
 
-static int bad_inode_rename2(struct inode *old_dir, struct dentry *old_dentry,
+static int bad_inode_rename2(struct user_namespace *mnt_userns,
+			     struct inode *old_dir, struct dentry *old_dentry,
 			     struct inode *new_dir, struct dentry *new_dentry,
 			     unsigned int flags)
 {
@@ -86,18 +89,21 @@ static int bad_inode_readlink(struct dentry *dentry, char __user *buffer,
 	return -EIO;
 }
 
-static int bad_inode_permission(struct inode *inode, int mask)
+static int bad_inode_permission(struct user_namespace *mnt_userns,
+				struct inode *inode, int mask)
 {
 	return -EIO;
 }
 
-static int bad_inode_getattr(const struct path *path, struct kstat *stat,
+static int bad_inode_getattr(struct user_namespace *mnt_userns,
+			     const struct path *path, struct kstat *stat,
 			     u32 request_mask, unsigned int query_flags)
 {
 	return -EIO;
 }
 
-static int bad_inode_setattr(struct dentry *direntry, struct iattr *attrs)
+static int bad_inode_setattr(struct user_namespace *mnt_userns,
+			     struct dentry *direntry, struct iattr *attrs)
 {
 	return -EIO;
 }
@@ -140,13 +146,15 @@ static int bad_inode_atomic_open(struct inode *inode, struct dentry *dentry,
 	return -EIO;
 }
 
-static int bad_inode_tmpfile(struct inode *inode, struct dentry *dentry,
+static int bad_inode_tmpfile(struct user_namespace *mnt_userns,
+			     struct inode *inode, struct dentry *dentry,
 			     umode_t mode)
 {
 	return -EIO;
 }
 
-static int bad_inode_set_acl(struct inode *inode, struct posix_acl *acl,
+static int bad_inode_set_acl(struct user_namespace *mnt_userns,
+			     struct inode *inode, struct posix_acl *acl,
 			     int type)
 {
 	return -EIO;
diff --git a/fs/bfs/dir.c b/fs/bfs/dir.c
index be1335a8d25b..34d4f68f786b 100644
--- a/fs/bfs/dir.c
+++ b/fs/bfs/dir.c
@@ -75,8 +75,8 @@ const struct file_operations bfs_dir_operations = {
 	.llseek		= generic_file_llseek,
 };
 
-static int bfs_create(struct inode *dir, struct dentry *dentry, umode_t mode,
-						bool excl)
+static int bfs_create(struct user_namespace *mnt_userns, struct inode *dir,
+		      struct dentry *dentry, umode_t mode, bool excl)
 {
 	int err;
 	struct inode *inode;
@@ -199,9 +199,9 @@ static int bfs_unlink(struct inode *dir, struct dentry *dentry)
 	return error;
 }
 
-static int bfs_rename(struct inode *old_dir, struct dentry *old_dentry,
-		      struct inode *new_dir, struct dentry *new_dentry,
-		      unsigned int flags)
+static int bfs_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
+		      struct dentry *old_dentry, struct inode *new_dir,
+		      struct dentry *new_dentry, unsigned int flags)
 {
 	struct inode *old_inode, *new_inode;
 	struct buffer_head *old_bh, *new_bh;
diff --git a/fs/btrfs/acl.c b/fs/btrfs/acl.c
index b5a683e895c6..8fc4a3df8040 100644
--- a/fs/btrfs/acl.c
+++ b/fs/btrfs/acl.c
@@ -107,7 +107,8 @@ static int __btrfs_set_acl(struct btrfs_trans_handle *trans,
 	return ret;
 }
 
-int btrfs_set_acl(struct inode *inode, struct posix_acl *acl, int type)
+int btrfs_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
+		  struct posix_acl *acl, int type)
 {
 	int ret;
 	umode_t old_mode = inode->i_mode;
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 0b29bdb25105..efdd3c48a5c4 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3493,7 +3493,8 @@ static inline int __btrfs_fs_compat_ro(struct btrfs_fs_info *fs_info, u64 flag)
 /* acl.c */
 #ifdef CONFIG_BTRFS_FS_POSIX_ACL
 struct posix_acl *btrfs_get_acl(struct inode *inode, int type);
-int btrfs_set_acl(struct inode *inode, struct posix_acl *acl, int type);
+int btrfs_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
+		  struct posix_acl *acl, int type);
 int btrfs_init_acl(struct btrfs_trans_handle *trans,
 		   struct inode *inode, struct inode *dir);
 #else
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 694644bbd2d9..70d78d7ddb02 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4924,7 +4924,8 @@ static int btrfs_setsize(struct inode *inode, struct iattr *attr)
 	return ret;
 }
 
-static int btrfs_setattr(struct dentry *dentry, struct iattr *attr)
+static int btrfs_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
+			 struct iattr *attr)
 {
 	struct inode *inode = d_inode(dentry);
 	struct btrfs_root *root = BTRFS_I(inode)->root;
@@ -6234,8 +6235,8 @@ static int btrfs_add_nondir(struct btrfs_trans_handle *trans,
 	return err;
 }
 
-static int btrfs_mknod(struct inode *dir, struct dentry *dentry,
-			umode_t mode, dev_t rdev)
+static int btrfs_mknod(struct user_namespace *mnt_userns, struct inode *dir,
+		       struct dentry *dentry, umode_t mode, dev_t rdev)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(dir->i_sb);
 	struct btrfs_trans_handle *trans;
@@ -6298,8 +6299,8 @@ static int btrfs_mknod(struct inode *dir, struct dentry *dentry,
 	return err;
 }
 
-static int btrfs_create(struct inode *dir, struct dentry *dentry,
-			umode_t mode, bool excl)
+static int btrfs_create(struct user_namespace *mnt_userns, struct inode *dir,
+			struct dentry *dentry, umode_t mode, bool excl)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(dir->i_sb);
 	struct btrfs_trans_handle *trans;
@@ -6443,7 +6444,8 @@ static int btrfs_link(struct dentry *old_dentry, struct inode *dir,
 	return err;
 }
 
-static int btrfs_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
+static int btrfs_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
+		       struct dentry *dentry, umode_t mode)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(dir->i_sb);
 	struct inode *inode = NULL;
@@ -8816,7 +8818,8 @@ int __init btrfs_init_cachep(void)
 	return -ENOMEM;
 }
 
-static int btrfs_getattr(const struct path *path, struct kstat *stat,
+static int btrfs_getattr(struct user_namespace *mnt_userns,
+			 const struct path *path, struct kstat *stat,
 			 u32 request_mask, unsigned int flags)
 {
 	u64 delalloc_bytes;
@@ -9331,9 +9334,9 @@ static int btrfs_rename(struct inode *old_dir, struct dentry *old_dentry,
 	return ret;
 }
 
-static int btrfs_rename2(struct inode *old_dir, struct dentry *old_dentry,
-			 struct inode *new_dir, struct dentry *new_dentry,
-			 unsigned int flags)
+static int btrfs_rename2(struct user_namespace *mnt_userns, struct inode *old_dir,
+			 struct dentry *old_dentry, struct inode *new_dir,
+			 struct dentry *new_dentry, unsigned int flags)
 {
 	if (flags & ~(RENAME_NOREPLACE | RENAME_EXCHANGE | RENAME_WHITEOUT))
 		return -EINVAL;
@@ -9508,8 +9511,8 @@ int btrfs_start_delalloc_roots(struct btrfs_fs_info *fs_info, u64 nr)
 	return ret;
 }
 
-static int btrfs_symlink(struct inode *dir, struct dentry *dentry,
-			 const char *symname)
+static int btrfs_symlink(struct user_namespace *mnt_userns, struct inode *dir,
+			 struct dentry *dentry, const char *symname)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(dir->i_sb);
 	struct btrfs_trans_handle *trans;
@@ -9840,7 +9843,8 @@ static int btrfs_set_page_dirty(struct page *page)
 	return __set_page_dirty_nobuffers(page);
 }
 
-static int btrfs_permission(struct inode *inode, int mask)
+static int btrfs_permission(struct user_namespace *mnt_userns,
+			    struct inode *inode, int mask)
 {
 	struct btrfs_root *root = BTRFS_I(inode)->root;
 	umode_t mode = inode->i_mode;
@@ -9855,7 +9859,8 @@ static int btrfs_permission(struct inode *inode, int mask)
 	return generic_permission(&init_user_ns, inode, mask);
 }
 
-static int btrfs_tmpfile(struct inode *dir, struct dentry *dentry, umode_t mode)
+static int btrfs_tmpfile(struct user_namespace *mnt_userns, struct inode *dir,
+			 struct dentry *dentry, umode_t mode)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(dir->i_sb);
 	struct btrfs_trans_handle *trans;
diff --git a/fs/ceph/acl.c b/fs/ceph/acl.c
index bceab4c01585..e68ea90e47b8 100644
--- a/fs/ceph/acl.c
+++ b/fs/ceph/acl.c
@@ -82,7 +82,8 @@ struct posix_acl *ceph_get_acl(struct inode *inode, int type)
 	return acl;
 }
 
-int ceph_set_acl(struct inode *inode, struct posix_acl *acl, int type)
+int ceph_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
+		 struct posix_acl *acl, int type)
 {
 	int ret = 0, size = 0;
 	const char *name = NULL;
diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index a4d48370b2b3..359c48b263a1 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -823,8 +823,8 @@ int ceph_handle_notrace_create(struct inode *dir, struct dentry *dentry)
 	return PTR_ERR(result);
 }
 
-static int ceph_mknod(struct inode *dir, struct dentry *dentry,
-		      umode_t mode, dev_t rdev)
+static int ceph_mknod(struct user_namespace *mnt_userns, struct inode *dir,
+		      struct dentry *dentry, umode_t mode, dev_t rdev)
 {
 	struct ceph_mds_client *mdsc = ceph_sb_to_mdsc(dir->i_sb);
 	struct ceph_mds_request *req;
@@ -878,14 +878,14 @@ static int ceph_mknod(struct inode *dir, struct dentry *dentry,
 	return err;
 }
 
-static int ceph_create(struct inode *dir, struct dentry *dentry, umode_t mode,
-		       bool excl)
+static int ceph_create(struct user_namespace *mnt_userns, struct inode *dir,
+		       struct dentry *dentry, umode_t mode, bool excl)
 {
-	return ceph_mknod(dir, dentry, mode, 0);
+	return ceph_mknod(mnt_userns, dir, dentry, mode, 0);
 }
 
-static int ceph_symlink(struct inode *dir, struct dentry *dentry,
-			    const char *dest)
+static int ceph_symlink(struct user_namespace *mnt_userns, struct inode *dir,
+			struct dentry *dentry, const char *dest)
 {
 	struct ceph_mds_client *mdsc = ceph_sb_to_mdsc(dir->i_sb);
 	struct ceph_mds_request *req;
@@ -937,7 +937,8 @@ static int ceph_symlink(struct inode *dir, struct dentry *dentry,
 	return err;
 }
 
-static int ceph_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
+static int ceph_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
+		      struct dentry *dentry, umode_t mode)
 {
 	struct ceph_mds_client *mdsc = ceph_sb_to_mdsc(dir->i_sb);
 	struct ceph_mds_request *req;
@@ -1183,9 +1184,9 @@ static int ceph_unlink(struct inode *dir, struct dentry *dentry)
 	return err;
 }
 
-static int ceph_rename(struct inode *old_dir, struct dentry *old_dentry,
-		       struct inode *new_dir, struct dentry *new_dentry,
-		       unsigned int flags)
+static int ceph_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
+		       struct dentry *old_dentry, struct inode *new_dir,
+		       struct dentry *new_dentry, unsigned int flags)
 {
 	struct ceph_mds_client *mdsc = ceph_sb_to_mdsc(old_dir->i_sb);
 	struct ceph_mds_request *req;
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index decfa5e1ec4c..4bce923dcf00 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -2242,7 +2242,8 @@ int __ceph_setattr(struct inode *inode, struct iattr *attr)
 /*
  * setattr
  */
-int ceph_setattr(struct dentry *dentry, struct iattr *attr)
+int ceph_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
+		 struct iattr *attr)
 {
 	struct inode *inode = d_inode(dentry);
 	struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
@@ -2325,7 +2326,7 @@ int __ceph_do_getattr(struct inode *inode, struct page *locked_page,
  * Check inode permissions.  We verify we have a valid value for
  * the AUTH cap, then call the generic handler.
  */
-int ceph_permission(struct inode *inode, int mask)
+int ceph_permission(struct user_namespace *mnt_userns, struct inode *inode, int mask)
 {
 	int err;
 
@@ -2364,8 +2365,8 @@ static int statx_to_caps(u32 want)
  * Get all the attributes. If we have sufficient caps for the requested attrs,
  * then we can avoid talking to the MDS at all.
  */
-int ceph_getattr(const struct path *path, struct kstat *stat,
-		 u32 request_mask, unsigned int flags)
+int ceph_getattr(struct user_namespace *mnt_userns, const struct path *path,
+		 struct kstat *stat, u32 request_mask, unsigned int flags)
 {
 	struct inode *inode = d_inode(path->dentry);
 	struct ceph_inode_info *ci = ceph_inode(inode);
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 482473e4cce1..36067896ce66 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -973,10 +973,13 @@ static inline int ceph_do_getattr(struct inode *inode, int mask, bool force)
 {
 	return __ceph_do_getattr(inode, NULL, mask, force);
 }
-extern int ceph_permission(struct inode *inode, int mask);
+extern int ceph_permission(struct user_namespace *mnt_userns,
+			   struct inode *inode, int mask);
 extern int __ceph_setattr(struct inode *inode, struct iattr *attr);
-extern int ceph_setattr(struct dentry *dentry, struct iattr *attr);
-extern int ceph_getattr(const struct path *path, struct kstat *stat,
+extern int ceph_setattr(struct user_namespace *mnt_userns,
+			struct dentry *dentry, struct iattr *attr);
+extern int ceph_getattr(struct user_namespace *mnt_userns,
+			const struct path *path, struct kstat *stat,
 			u32 request_mask, unsigned int flags);
 
 /* xattr.c */
@@ -1037,7 +1040,8 @@ void ceph_release_acl_sec_ctx(struct ceph_acl_sec_ctx *as_ctx);
 #ifdef CONFIG_CEPH_FS_POSIX_ACL
 
 struct posix_acl *ceph_get_acl(struct inode *, int);
-int ceph_set_acl(struct inode *inode, struct posix_acl *acl, int type);
+int ceph_set_acl(struct user_namespace *mnt_userns,
+		 struct inode *inode, struct posix_acl *acl, int type);
 int ceph_pre_init_acls(struct inode *dir, umode_t *mode,
 		       struct ceph_acl_sec_ctx *as_ctx);
 void ceph_init_inode_acls(struct inode *inode,
diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
index f79dbc581eee..6b02f3ccdb50 100644
--- a/fs/cifs/cifsfs.c
+++ b/fs/cifs/cifsfs.c
@@ -301,7 +301,7 @@ static long cifs_fallocate(struct file *file, int mode, loff_t off, loff_t len)
 	return -EOPNOTSUPP;
 }
 
-static int cifs_permission(struct inode *inode, int mask)
+static int cifs_permission(struct user_namespace *mnt_userns, struct inode *inode, int mask)
 {
 	struct cifs_sb_info *cifs_sb;
 
diff --git a/fs/cifs/cifsfs.h b/fs/cifs/cifsfs.h
index 905d03863721..bd47f744fe9d 100644
--- a/fs/cifs/cifsfs.h
+++ b/fs/cifs/cifsfs.h
@@ -62,19 +62,19 @@ extern void cifs_sb_deactive(struct super_block *sb);
 /* Functions related to inodes */
 extern const struct inode_operations cifs_dir_inode_ops;
 extern struct inode *cifs_root_iget(struct super_block *);
-extern int cifs_create(struct inode *, struct dentry *, umode_t,
-		       bool excl);
+extern int cifs_create(struct user_namespace *, struct inode *,
+		       struct dentry *, umode_t, bool excl);
 extern int cifs_atomic_open(struct inode *, struct dentry *,
 			    struct file *, unsigned, umode_t);
 extern struct dentry *cifs_lookup(struct inode *, struct dentry *,
 				  unsigned int);
 extern int cifs_unlink(struct inode *dir, struct dentry *dentry);
 extern int cifs_hardlink(struct dentry *, struct inode *, struct dentry *);
-extern int cifs_mknod(struct inode *, struct dentry *, umode_t, dev_t);
-extern int cifs_mkdir(struct inode *, struct dentry *, umode_t);
+extern int cifs_mknod(struct user_namespace *, struct inode *, struct dentry *, umode_t, dev_t);
+extern int cifs_mkdir(struct user_namespace *, struct inode *, struct dentry *, umode_t);
 extern int cifs_rmdir(struct inode *, struct dentry *);
-extern int cifs_rename2(struct inode *, struct dentry *, struct inode *,
-			struct dentry *, unsigned int);
+extern int cifs_rename2(struct user_namespace *, struct inode *,
+			struct dentry *, struct inode *, struct dentry *, unsigned int);
 extern int cifs_revalidate_file_attr(struct file *filp);
 extern int cifs_revalidate_dentry_attr(struct dentry *);
 extern int cifs_revalidate_file(struct file *filp);
@@ -82,8 +82,9 @@ extern int cifs_revalidate_dentry(struct dentry *);
 extern int cifs_invalidate_mapping(struct inode *inode);
 extern int cifs_revalidate_mapping(struct inode *inode);
 extern int cifs_zap_mapping(struct inode *inode);
-extern int cifs_getattr(const struct path *, struct kstat *, u32, unsigned int);
-extern int cifs_setattr(struct dentry *, struct iattr *);
+extern int cifs_getattr(struct user_namespace *, const struct path *,
+			struct kstat *, u32, unsigned int);
+extern int cifs_setattr(struct user_namespace *, struct dentry *, struct iattr *);
 extern int cifs_fiemap(struct inode *, struct fiemap_extent_info *, u64 start,
 		       u64 len);
 
@@ -132,8 +133,8 @@ extern struct vfsmount *cifs_dfs_d_automount(struct path *path);
 /* Functions related to symlinks */
 extern const char *cifs_get_link(struct dentry *, struct inode *,
 			struct delayed_call *);
-extern int cifs_symlink(struct inode *inode, struct dentry *direntry,
-			const char *symname);
+extern int cifs_symlink(struct user_namespace *mnt_userns, struct inode *inode,
+			struct dentry *direntry, const char *symname);
 
 #ifdef CONFIG_CIFS_XATTR
 extern const struct xattr_handler *cifs_xattr_handlers[];
diff --git a/fs/cifs/dir.c b/fs/cifs/dir.c
index 398c1eef7190..77546e90dd31 100644
--- a/fs/cifs/dir.c
+++ b/fs/cifs/dir.c
@@ -566,8 +566,8 @@ cifs_atomic_open(struct inode *inode, struct dentry *direntry,
 	return rc;
 }
 
-int cifs_create(struct inode *inode, struct dentry *direntry, umode_t mode,
-		bool excl)
+int cifs_create(struct user_namespace *mnt_userns, struct inode *inode,
+		struct dentry *direntry, umode_t mode, bool excl)
 {
 	int rc;
 	unsigned int xid = get_xid();
@@ -610,8 +610,8 @@ int cifs_create(struct inode *inode, struct dentry *direntry, umode_t mode,
 	return rc;
 }
 
-int cifs_mknod(struct inode *inode, struct dentry *direntry, umode_t mode,
-		dev_t device_number)
+int cifs_mknod(struct user_namespace *mnt_userns, struct inode *inode,
+	       struct dentry *direntry, umode_t mode, dev_t device_number)
 {
 	int rc = -EPERM;
 	unsigned int xid;
diff --git a/fs/cifs/inode.c b/fs/cifs/inode.c
index 4fb3b6961096..b0021316bc23 100644
--- a/fs/cifs/inode.c
+++ b/fs/cifs/inode.c
@@ -1851,7 +1851,8 @@ cifs_posix_mkdir(struct inode *inode, struct dentry *dentry, umode_t mode,
 	goto posix_mkdir_out;
 }
 
-int cifs_mkdir(struct inode *inode, struct dentry *direntry, umode_t mode)
+int cifs_mkdir(struct user_namespace *mnt_userns, struct inode *inode,
+	       struct dentry *direntry, umode_t mode)
 {
 	int rc = 0;
 	unsigned int xid;
@@ -2061,9 +2062,9 @@ cifs_do_rename(const unsigned int xid, struct dentry *from_dentry,
 }
 
 int
-cifs_rename2(struct inode *source_dir, struct dentry *source_dentry,
-	     struct inode *target_dir, struct dentry *target_dentry,
-	     unsigned int flags)
+cifs_rename2(struct user_namespace *mnt_userns, struct inode *source_dir,
+	     struct dentry *source_dentry, struct inode *target_dir,
+	     struct dentry *target_dentry, unsigned int flags)
 {
 	char *from_name = NULL;
 	char *to_name = NULL;
@@ -2362,8 +2363,8 @@ int cifs_revalidate_dentry(struct dentry *dentry)
 	return cifs_revalidate_mapping(inode);
 }
 
-int cifs_getattr(const struct path *path, struct kstat *stat,
-		 u32 request_mask, unsigned int flags)
+int cifs_getattr(struct user_namespace *mnt_userns, const struct path *path,
+		 struct kstat *stat, u32 request_mask, unsigned int flags)
 {
 	struct dentry *dentry = path->dentry;
 	struct cifs_sb_info *cifs_sb = CIFS_SB(dentry->d_sb);
@@ -2907,7 +2908,8 @@ cifs_setattr_nounix(struct dentry *direntry, struct iattr *attrs)
 }
 
 int
-cifs_setattr(struct dentry *direntry, struct iattr *attrs)
+cifs_setattr(struct user_namespace *mnt_userns, struct dentry *direntry,
+	     struct iattr *attrs)
 {
 	struct cifs_sb_info *cifs_sb = CIFS_SB(direntry->d_sb);
 	struct cifs_tcon *pTcon = cifs_sb_master_tcon(cifs_sb);
diff --git a/fs/cifs/link.c b/fs/cifs/link.c
index 94dab4309fbb..7c5878a645d9 100644
--- a/fs/cifs/link.c
+++ b/fs/cifs/link.c
@@ -661,7 +661,8 @@ cifs_get_link(struct dentry *direntry, struct inode *inode,
 }
 
 int
-cifs_symlink(struct inode *inode, struct dentry *direntry, const char *symname)
+cifs_symlink(struct user_namespace *mnt_userns, struct inode *inode,
+	     struct dentry *direntry, const char *symname)
 {
 	int rc = -EOPNOTSUPP;
 	unsigned int xid;
diff --git a/fs/coda/coda_linux.h b/fs/coda/coda_linux.h
index d5ebd36fb2cc..6563aa00eb79 100644
--- a/fs/coda/coda_linux.h
+++ b/fs/coda/coda_linux.h
@@ -46,10 +46,10 @@ extern const struct file_operations coda_ioctl_operations;
 /* operations shared over more than one file */
 int coda_open(struct inode *i, struct file *f);
 int coda_release(struct inode *i, struct file *f);
-int coda_permission(struct inode *inode, int mask);
+int coda_permission(struct user_namespace *mnt_userns, struct inode *inode, int mask);
 int coda_revalidate_inode(struct inode *);
-int coda_getattr(const struct path *, struct kstat *, u32, unsigned int);
-int coda_setattr(struct dentry *, struct iattr *);
+int coda_getattr(struct user_namespace *, const struct path *, struct kstat *, u32, unsigned int);
+int coda_setattr(struct user_namespace *, struct dentry *, struct iattr *);
 
 /* this file:  heloers */
 char *coda_f2s(struct CodaFid *f);
diff --git a/fs/coda/dir.c b/fs/coda/dir.c
index ca40c2556ba6..7c0fed9a2344 100644
--- a/fs/coda/dir.c
+++ b/fs/coda/dir.c
@@ -73,7 +73,7 @@ static struct dentry *coda_lookup(struct inode *dir, struct dentry *entry, unsig
 }
 
 
-int coda_permission(struct inode *inode, int mask)
+int coda_permission(struct user_namespace *mnt_userns, struct inode *inode, int mask)
 {
 	int error;
 
@@ -132,7 +132,8 @@ static inline void coda_dir_drop_nlink(struct inode *dir)
 }
 
 /* creation routines: create, mknod, mkdir, link, symlink */
-static int coda_create(struct inode *dir, struct dentry *de, umode_t mode, bool excl)
+static int coda_create(struct user_namespace *mnt_userns, struct inode *dir,
+		       struct dentry *de, umode_t mode, bool excl)
 {
 	int error;
 	const char *name=de->d_name.name;
@@ -164,7 +165,8 @@ static int coda_create(struct inode *dir, struct dentry *de, umode_t mode, bool
 	return error;
 }
 
-static int coda_mkdir(struct inode *dir, struct dentry *de, umode_t mode)
+static int coda_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
+		      struct dentry *de, umode_t mode)
 {
 	struct inode *inode;
 	struct coda_vattr attrs;
@@ -225,7 +227,8 @@ static int coda_link(struct dentry *source_de, struct inode *dir_inode,
 }
 
 
-static int coda_symlink(struct inode *dir_inode, struct dentry *de,
+static int coda_symlink(struct user_namespace *mnt_userns,
+			struct inode *dir_inode, struct dentry *de,
 			const char *symname)
 {
 	const char *name = de->d_name.name;
@@ -291,9 +294,9 @@ static int coda_rmdir(struct inode *dir, struct dentry *de)
 }
 
 /* rename */
-static int coda_rename(struct inode *old_dir, struct dentry *old_dentry,
-		       struct inode *new_dir, struct dentry *new_dentry,
-		       unsigned int flags)
+static int coda_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
+		       struct dentry *old_dentry, struct inode *new_dir,
+		       struct dentry *new_dentry, unsigned int flags)
 {
 	const char *old_name = old_dentry->d_name.name;
 	const char *new_name = new_dentry->d_name.name;
diff --git a/fs/coda/inode.c b/fs/coda/inode.c
index 4d113e191cb8..d9f1bd7153df 100644
--- a/fs/coda/inode.c
+++ b/fs/coda/inode.c
@@ -251,8 +251,8 @@ static void coda_evict_inode(struct inode *inode)
 	coda_cache_clear_inode(inode);
 }
 
-int coda_getattr(const struct path *path, struct kstat *stat,
-		 u32 request_mask, unsigned int flags)
+int coda_getattr(struct user_namespace *mnt_userns, const struct path *path,
+		 struct kstat *stat, u32 request_mask, unsigned int flags)
 {
 	int err = coda_revalidate_inode(d_inode(path->dentry));
 	if (!err)
@@ -260,7 +260,8 @@ int coda_getattr(const struct path *path, struct kstat *stat,
 	return err;
 }
 
-int coda_setattr(struct dentry *de, struct iattr *iattr)
+int coda_setattr(struct user_namespace *mnt_userns, struct dentry *de,
+		 struct iattr *iattr)
 {
 	struct inode *inode = d_inode(de);
 	struct coda_vattr vattr;
diff --git a/fs/coda/pioctl.c b/fs/coda/pioctl.c
index 3aec27e5eb82..cb9fd59a688c 100644
--- a/fs/coda/pioctl.c
+++ b/fs/coda/pioctl.c
@@ -24,7 +24,8 @@
 #include "coda_linux.h"
 
 /* pioctl ops */
-static int coda_ioctl_permission(struct inode *inode, int mask);
+static int coda_ioctl_permission(struct user_namespace *mnt_userns,
+				 struct inode *inode, int mask);
 static long coda_pioctl(struct file *filp, unsigned int cmd,
 			unsigned long user_data);
 
@@ -40,7 +41,8 @@ const struct file_operations coda_ioctl_operations = {
 };
 
 /* the coda pioctl inode ops */
-static int coda_ioctl_permission(struct inode *inode, int mask)
+static int coda_ioctl_permission(struct user_namespace *mnt_userns,
+				 struct inode *inode, int mask)
 {
 	return (mask & MAY_EXEC) ? -EACCES : 0;
 }
diff --git a/fs/configfs/configfs_internal.h b/fs/configfs/configfs_internal.h
index 22dce2d35a4b..4bbd9299a422 100644
--- a/fs/configfs/configfs_internal.h
+++ b/fs/configfs/configfs_internal.h
@@ -79,7 +79,8 @@ extern void configfs_hash_and_remove(struct dentry * dir, const char * name);
 
 extern const unsigned char * configfs_get_name(struct configfs_dirent *sd);
 extern void configfs_drop_dentry(struct configfs_dirent *sd, struct dentry *parent);
-extern int configfs_setattr(struct dentry *dentry, struct iattr *iattr);
+extern int configfs_setattr(struct user_namespace *mnt_userns,
+			    struct dentry *dentry, struct iattr *iattr);
 
 extern struct dentry *configfs_pin_fs(void);
 extern void configfs_release_fs(void);
@@ -92,8 +93,8 @@ extern const struct inode_operations configfs_root_inode_operations;
 extern const struct inode_operations configfs_symlink_inode_operations;
 extern const struct dentry_operations configfs_dentry_ops;
 
-extern int configfs_symlink(struct inode *dir, struct dentry *dentry,
-			    const char *symname);
+extern int configfs_symlink(struct user_namespace *mnt_userns, struct inode *dir,
+			    struct dentry *dentry, const char *symname);
 extern int configfs_unlink(struct inode *dir, struct dentry *dentry);
 
 int configfs_create_link(struct configfs_dirent *target, struct dentry *parent,
diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index b0983e2a4e2c..f2d74a2254fd 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -1267,7 +1267,8 @@ int configfs_depend_item_unlocked(struct configfs_subsystem *caller_subsys,
 }
 EXPORT_SYMBOL(configfs_depend_item_unlocked);
 
-static int configfs_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
+static int configfs_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
+			  struct dentry *dentry, umode_t mode)
 {
 	int ret = 0;
 	int module_got = 0;
diff --git a/fs/configfs/inode.c b/fs/configfs/inode.c
index 8bd6a883c94c..42c348bb2903 100644
--- a/fs/configfs/inode.c
+++ b/fs/configfs/inode.c
@@ -40,7 +40,8 @@ static const struct inode_operations configfs_inode_operations ={
 	.setattr	= configfs_setattr,
 };
 
-int configfs_setattr(struct dentry * dentry, struct iattr * iattr)
+int configfs_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
+		     struct iattr *iattr)
 {
 	struct inode * inode = d_inode(dentry);
 	struct configfs_dirent * sd = dentry->d_fsdata;
@@ -67,7 +68,7 @@ int configfs_setattr(struct dentry * dentry, struct iattr * iattr)
 	}
 	/* attributes were changed atleast once in past */
 
-	error = simple_setattr(dentry, iattr);
+	error = simple_setattr(mnt_userns, dentry, iattr);
 	if (error)
 		return error;
 
diff --git a/fs/configfs/symlink.c b/fs/configfs/symlink.c
index 0b592c55f38e..5c0798626f9f 100644
--- a/fs/configfs/symlink.c
+++ b/fs/configfs/symlink.c
@@ -139,7 +139,8 @@ static int get_target(const char *symname, struct path *path,
 }
 
 
-int configfs_symlink(struct inode *dir, struct dentry *dentry, const char *symname)
+int configfs_symlink(struct user_namespace *mnt_userns, struct inode *dir,
+		     struct dentry *dentry, const char *symname)
 {
 	int ret;
 	struct path path;
diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index 2fcf66473436..c35249497b9b 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -42,13 +42,14 @@ static unsigned int debugfs_allow = DEFAULT_DEBUGFS_ALLOW_BITS;
  * so that we can use the file mode as part of a heuristic to determine whether
  * to lock down individual files.
  */
-static int debugfs_setattr(struct dentry *dentry, struct iattr *ia)
+static int debugfs_setattr(struct user_namespace *mnt_userns,
+			   struct dentry *dentry, struct iattr *ia)
 {
 	int ret = security_locked_down(LOCKDOWN_DEBUGFS);
 
 	if (ret && (ia->ia_valid & (ATTR_MODE | ATTR_UID | ATTR_GID)))
 		return ret;
-	return simple_setattr(dentry, ia);
+	return simple_setattr(&init_user_ns, dentry, ia);
 }
 
 static const struct inode_operations debugfs_file_inode_operations = {
@@ -775,8 +776,8 @@ struct dentry *debugfs_rename(struct dentry *old_dir, struct dentry *old_dentry,
 
 	take_dentry_name_snapshot(&old_name, old_dentry);
 
-	error = simple_rename(d_inode(old_dir), old_dentry, d_inode(new_dir),
-			      dentry, 0);
+	error = simple_rename(&init_user_ns, d_inode(old_dir), old_dentry,
+			      d_inode(new_dir), dentry, 0);
 	if (error) {
 		release_dentry_name_snapshot(&old_name);
 		goto exit;
diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index 0c97a1c37e5d..8edbb9dd9e87 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -255,8 +255,8 @@ int ecryptfs_initialize_file(struct dentry *ecryptfs_dentry,
  * Returns zero on success; non-zero on error condition
  */
 static int
-ecryptfs_create(struct inode *directory_inode, struct dentry *ecryptfs_dentry,
-		umode_t mode, bool excl)
+ecryptfs_create(struct user_namespace *mnt_userns, struct inode *directory_inode,
+		struct dentry *ecryptfs_dentry, umode_t mode, bool excl)
 {
 	struct inode *ecryptfs_inode;
 	int rc;
@@ -461,8 +461,8 @@ static int ecryptfs_unlink(struct inode *dir, struct dentry *dentry)
 	return ecryptfs_do_unlink(dir, dentry, d_inode(dentry));
 }
 
-static int ecryptfs_symlink(struct inode *dir, struct dentry *dentry,
-			    const char *symname)
+static int ecryptfs_symlink(struct user_namespace *mnt_userns, struct inode *dir,
+			    struct dentry *dentry, const char *symname)
 {
 	int rc;
 	struct dentry *lower_dentry;
@@ -500,7 +500,8 @@ static int ecryptfs_symlink(struct inode *dir, struct dentry *dentry,
 	return rc;
 }
 
-static int ecryptfs_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
+static int ecryptfs_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
+			  struct dentry *dentry, umode_t mode)
 {
 	int rc;
 	struct dentry *lower_dentry;
@@ -556,7 +557,8 @@ static int ecryptfs_rmdir(struct inode *dir, struct dentry *dentry)
 }
 
 static int
-ecryptfs_mknod(struct inode *dir, struct dentry *dentry, umode_t mode, dev_t dev)
+ecryptfs_mknod(struct user_namespace *mnt_userns, struct inode *dir,
+	       struct dentry *dentry, umode_t mode, dev_t dev)
 {
 	int rc;
 	struct dentry *lower_dentry;
@@ -581,9 +583,9 @@ ecryptfs_mknod(struct inode *dir, struct dentry *dentry, umode_t mode, dev_t dev
 }
 
 static int
-ecryptfs_rename(struct inode *old_dir, struct dentry *old_dentry,
-		struct inode *new_dir, struct dentry *new_dentry,
-		unsigned int flags)
+ecryptfs_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
+		struct dentry *old_dentry, struct inode *new_dir,
+		struct dentry *new_dentry, unsigned int flags)
 {
 	int rc;
 	struct dentry *lower_old_dentry;
@@ -870,7 +872,7 @@ int ecryptfs_truncate(struct dentry *dentry, loff_t new_length)
 }
 
 static int
-ecryptfs_permission(struct inode *inode, int mask)
+ecryptfs_permission(struct user_namespace *mnt_userns, struct inode *inode, int mask)
 {
 	return inode_permission(&init_user_ns, ecryptfs_inode_to_lower(inode), mask);
 }
@@ -887,7 +889,8 @@ ecryptfs_permission(struct inode *inode, int mask)
  * All other metadata changes will be passed right to the lower filesystem,
  * and we will just update our inode to look like the lower.
  */
-static int ecryptfs_setattr(struct dentry *dentry, struct iattr *ia)
+static int ecryptfs_setattr(struct user_namespace *mnt_userns,
+			    struct dentry *dentry, struct iattr *ia)
 {
 	int rc = 0;
 	struct dentry *lower_dentry;
@@ -974,7 +977,8 @@ static int ecryptfs_setattr(struct dentry *dentry, struct iattr *ia)
 	return rc;
 }
 
-static int ecryptfs_getattr_link(const struct path *path, struct kstat *stat,
+static int ecryptfs_getattr_link(struct user_namespace *mnt_userns,
+				 const struct path *path, struct kstat *stat,
 				 u32 request_mask, unsigned int flags)
 {
 	struct dentry *dentry = path->dentry;
@@ -999,7 +1003,8 @@ static int ecryptfs_getattr_link(const struct path *path, struct kstat *stat,
 	return rc;
 }
 
-static int ecryptfs_getattr(const struct path *path, struct kstat *stat,
+static int ecryptfs_getattr(struct user_namespace *mnt_userns,
+			    const struct path *path, struct kstat *stat,
 			    u32 request_mask, unsigned int flags)
 {
 	struct dentry *dentry = path->dentry;
diff --git a/fs/efivarfs/inode.c b/fs/efivarfs/inode.c
index 0297ad95eb5c..14e2947975fd 100644
--- a/fs/efivarfs/inode.c
+++ b/fs/efivarfs/inode.c
@@ -66,8 +66,8 @@ bool efivarfs_valid_name(const char *str, int len)
 	return uuid_is_valid(s);
 }
 
-static int efivarfs_create(struct inode *dir, struct dentry *dentry,
-			  umode_t mode, bool excl)
+static int efivarfs_create(struct user_namespace *mnt_userns, struct inode *dir,
+			   struct dentry *dentry, umode_t mode, bool excl)
 {
 	struct inode *inode = NULL;
 	struct efivar_entry *var;
diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index 083818063ac6..119fdce1b520 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -331,8 +331,9 @@ struct inode *erofs_iget(struct super_block *sb,
 	return inode;
 }
 
-int erofs_getattr(const struct path *path, struct kstat *stat,
-		  u32 request_mask, unsigned int query_flags)
+int erofs_getattr(struct user_namespace *mnt_userns, const struct path *path,
+		  struct kstat *stat, u32 request_mask,
+		  unsigned int query_flags)
 {
 	struct inode *const inode = d_inode(path->dentry);
 
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 67a7ec945686..351dae524a0c 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -373,8 +373,9 @@ extern const struct inode_operations erofs_symlink_iops;
 extern const struct inode_operations erofs_fast_symlink_iops;
 
 struct inode *erofs_iget(struct super_block *sb, erofs_nid_t nid, bool dir);
-int erofs_getattr(const struct path *path, struct kstat *stat,
-		  u32 request_mask, unsigned int query_flags);
+int erofs_getattr(struct user_namespace *mnt_userns, const struct path *path,
+		  struct kstat *stat, u32 request_mask,
+		  unsigned int query_flags);
 
 /* namei.c */
 extern const struct inode_operations erofs_dir_iops;
diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index b8f0e829ecbd..d905bb9cd2ca 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -416,9 +416,11 @@ int exfat_count_used_clusters(struct super_block *sb, unsigned int *ret_count);
 extern const struct file_operations exfat_file_operations;
 int __exfat_truncate(struct inode *inode, loff_t new_size);
 void exfat_truncate(struct inode *inode, loff_t size);
-int exfat_setattr(struct dentry *dentry, struct iattr *attr);
-int exfat_getattr(const struct path *path, struct kstat *stat,
-		unsigned int request_mask, unsigned int query_flags);
+int exfat_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
+		  struct iattr *attr);
+int exfat_getattr(struct user_namespace *mnt_userns, const struct path *path,
+		  struct kstat *stat, unsigned int request_mask,
+		  unsigned int query_flags);
 int exfat_file_fsync(struct file *file, loff_t start, loff_t end, int datasync);
 
 /* namei.c */
diff --git a/fs/exfat/file.c b/fs/exfat/file.c
index e9705b3295d3..3aa6eb4de5e3 100644
--- a/fs/exfat/file.c
+++ b/fs/exfat/file.c
@@ -267,8 +267,9 @@ void exfat_truncate(struct inode *inode, loff_t size)
 	mutex_unlock(&sbi->s_lock);
 }
 
-int exfat_getattr(const struct path *path, struct kstat *stat,
-		unsigned int request_mask, unsigned int query_flags)
+int exfat_getattr(struct user_namespace *mnt_uerns, const struct path *path,
+		  struct kstat *stat, unsigned int request_mask,
+		  unsigned int query_flags)
 {
 	struct inode *inode = d_backing_inode(path->dentry);
 	struct exfat_inode_info *ei = EXFAT_I(inode);
@@ -282,7 +283,8 @@ int exfat_getattr(const struct path *path, struct kstat *stat,
 	return 0;
 }
 
-int exfat_setattr(struct dentry *dentry, struct iattr *attr)
+int exfat_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
+		  struct iattr *attr)
 {
 	struct exfat_sb_info *sbi = EXFAT_SB(dentry->d_sb);
 	struct inode *inode = dentry->d_inode;
diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index 2932b23a3b6c..d9e8ec689c55 100644
--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -541,8 +541,8 @@ static int exfat_add_entry(struct inode *inode, const char *path,
 	return ret;
 }
 
-static int exfat_create(struct inode *dir, struct dentry *dentry, umode_t mode,
-		bool excl)
+static int exfat_create(struct user_namespace *mnt_userns, struct inode *dir,
+			struct dentry *dentry, umode_t mode, bool excl)
 {
 	struct super_block *sb = dir->i_sb;
 	struct inode *inode;
@@ -827,7 +827,8 @@ static int exfat_unlink(struct inode *dir, struct dentry *dentry)
 	return err;
 }
 
-static int exfat_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
+static int exfat_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
+		       struct dentry *dentry, umode_t mode)
 {
 	struct super_block *sb = dir->i_sb;
 	struct inode *inode;
@@ -1318,9 +1319,10 @@ static int __exfat_rename(struct inode *old_parent_inode,
 	return ret;
 }
 
-static int exfat_rename(struct inode *old_dir, struct dentry *old_dentry,
-		struct inode *new_dir, struct dentry *new_dentry,
-		unsigned int flags)
+static int exfat_rename(struct user_namespace *mnt_userns,
+			struct inode *old_dir, struct dentry *old_dentry,
+			struct inode *new_dir, struct dentry *new_dentry,
+			unsigned int flags)
 {
 	struct inode *old_inode, *new_inode;
 	struct super_block *sb = old_dir->i_sb;
diff --git a/fs/ext2/acl.c b/fs/ext2/acl.c
index 826987b23ccb..9760a2e44a3c 100644
--- a/fs/ext2/acl.c
+++ b/fs/ext2/acl.c
@@ -216,7 +216,8 @@ __ext2_set_acl(struct inode *inode, struct posix_acl *acl, int type)
  * inode->i_mutex: down
  */
 int
-ext2_set_acl(struct inode *inode, struct posix_acl *acl, int type)
+ext2_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
+	     struct posix_acl *acl, int type)
 {
 	int error;
 	int update_mode = 0;
diff --git a/fs/ext2/acl.h b/fs/ext2/acl.h
index 0f01c759daac..917db5f6630a 100644
--- a/fs/ext2/acl.h
+++ b/fs/ext2/acl.h
@@ -56,7 +56,8 @@ static inline int ext2_acl_count(size_t size)
 
 /* acl.c */
 extern struct posix_acl *ext2_get_acl(struct inode *inode, int type);
-extern int ext2_set_acl(struct inode *inode, struct posix_acl *acl, int type);
+extern int ext2_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
+			struct posix_acl *acl, int type);
 extern int ext2_init_acl (struct inode *, struct inode *);
 
 #else
diff --git a/fs/ext2/ext2.h b/fs/ext2/ext2.h
index 5136b7289e8d..c09da446d512 100644
--- a/fs/ext2/ext2.h
+++ b/fs/ext2/ext2.h
@@ -757,8 +757,9 @@ extern struct inode *ext2_iget (struct super_block *, unsigned long);
 extern int ext2_write_inode (struct inode *, struct writeback_control *);
 extern void ext2_evict_inode(struct inode *);
 extern int ext2_get_block(struct inode *, sector_t, struct buffer_head *, int);
-extern int ext2_setattr (struct dentry *, struct iattr *);
-extern int ext2_getattr (const struct path *, struct kstat *, u32, unsigned int);
+extern int ext2_setattr (struct user_namespace *, struct dentry *, struct iattr *);
+extern int ext2_getattr (struct user_namespace *, const struct path *,
+			 struct kstat *, u32, unsigned int);
 extern void ext2_set_inode_flags(struct inode *inode);
 extern int ext2_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 		       u64 start, u64 len);
diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
index 7fcda76094ff..ce4b4e6e6adf 100644
--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -1637,8 +1637,8 @@ int ext2_write_inode(struct inode *inode, struct writeback_control *wbc)
 	return __ext2_write_inode(inode, wbc->sync_mode == WB_SYNC_ALL);
 }
 
-int ext2_getattr(const struct path *path, struct kstat *stat,
-		u32 request_mask, unsigned int query_flags)
+int ext2_getattr(struct user_namespace *mnt_userns, const struct path *path,
+		 struct kstat *stat, u32 request_mask, unsigned int query_flags)
 {
 	struct inode *inode = d_inode(path->dentry);
 	struct ext2_inode_info *ei = EXT2_I(inode);
@@ -1663,7 +1663,8 @@ int ext2_getattr(const struct path *path, struct kstat *stat,
 	return 0;
 }
 
-int ext2_setattr(struct dentry *dentry, struct iattr *iattr)
+int ext2_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
+		 struct iattr *iattr)
 {
 	struct inode *inode = d_inode(dentry);
 	int error;
diff --git a/fs/ext2/namei.c b/fs/ext2/namei.c
index 5bf2c145643b..b11e336be8e2 100644
--- a/fs/ext2/namei.c
+++ b/fs/ext2/namei.c
@@ -100,7 +100,8 @@ struct dentry *ext2_get_parent(struct dentry *child)
  * If the create succeeds, we fill in the inode information
  * with d_instantiate(). 
  */
-static int ext2_create (struct inode * dir, struct dentry * dentry, umode_t mode, bool excl)
+static int ext2_create (struct user_namespace * mnt_userns,
+			struct inode * dir, struct dentry * dentry, umode_t mode, bool excl)
 {
 	struct inode *inode;
 	int err;
@@ -118,7 +119,8 @@ static int ext2_create (struct inode * dir, struct dentry * dentry, umode_t mode
 	return ext2_add_nondir(dentry, inode);
 }
 
-static int ext2_tmpfile(struct inode *dir, struct dentry *dentry, umode_t mode)
+static int ext2_tmpfile(struct user_namespace *mnt_userns, struct inode *dir,
+			struct dentry *dentry, umode_t mode)
 {
 	struct inode *inode = ext2_new_inode(dir, mode, NULL);
 	if (IS_ERR(inode))
@@ -131,7 +133,8 @@ static int ext2_tmpfile(struct inode *dir, struct dentry *dentry, umode_t mode)
 	return 0;
 }
 
-static int ext2_mknod (struct inode * dir, struct dentry *dentry, umode_t mode, dev_t rdev)
+static int ext2_mknod (struct user_namespace * mnt_userns, struct inode * dir,
+	struct dentry *dentry, umode_t mode, dev_t rdev)
 {
 	struct inode * inode;
 	int err;
@@ -151,8 +154,8 @@ static int ext2_mknod (struct inode * dir, struct dentry *dentry, umode_t mode,
 	return err;
 }
 
-static int ext2_symlink (struct inode * dir, struct dentry * dentry,
-	const char * symname)
+static int ext2_symlink (struct user_namespace * mnt_userns, struct inode * dir,
+	struct dentry * dentry, const char * symname)
 {
 	struct super_block * sb = dir->i_sb;
 	int err = -ENAMETOOLONG;
@@ -225,7 +228,8 @@ static int ext2_link (struct dentry * old_dentry, struct inode * dir,
 	return err;
 }
 
-static int ext2_mkdir(struct inode * dir, struct dentry * dentry, umode_t mode)
+static int ext2_mkdir(struct user_namespace * mnt_userns,
+	struct inode * dir, struct dentry * dentry, umode_t mode)
 {
 	struct inode * inode;
 	int err;
@@ -315,9 +319,9 @@ static int ext2_rmdir (struct inode * dir, struct dentry *dentry)
 	return err;
 }
 
-static int ext2_rename (struct inode * old_dir, struct dentry * old_dentry,
-			struct inode * new_dir,	struct dentry * new_dentry,
-			unsigned int flags)
+static int ext2_rename (struct user_namespace * mnt_userns, struct inode * old_dir,
+			struct dentry * old_dentry, struct inode * new_dir,
+			struct dentry * new_dentry, unsigned int flags)
 {
 	struct inode * old_inode = d_inode(old_dentry);
 	struct inode * new_inode = d_inode(new_dentry);
diff --git a/fs/ext4/acl.c b/fs/ext4/acl.c
index 4aad060010d8..39f453ad05a0 100644
--- a/fs/ext4/acl.c
+++ b/fs/ext4/acl.c
@@ -222,7 +222,8 @@ __ext4_set_acl(handle_t *handle, struct inode *inode, int type,
 }
 
 int
-ext4_set_acl(struct inode *inode, struct posix_acl *acl, int type)
+ext4_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
+	     struct posix_acl *acl, int type)
 {
 	handle_t *handle;
 	int error, credits, retries = 0;
diff --git a/fs/ext4/acl.h b/fs/ext4/acl.h
index 9b63f5416a2f..84b8942a57f2 100644
--- a/fs/ext4/acl.h
+++ b/fs/ext4/acl.h
@@ -56,7 +56,8 @@ static inline int ext4_acl_count(size_t size)
 
 /* acl.c */
 struct posix_acl *ext4_get_acl(struct inode *inode, int type);
-int ext4_set_acl(struct inode *inode, struct posix_acl *acl, int type);
+int ext4_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
+		 struct posix_acl *acl, int type);
 extern int ext4_init_acl(handle_t *, struct inode *, struct inode *);
 
 #else  /* CONFIG_EXT4_FS_POSIX_ACL */
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 65ecaf96d0a4..d1512ba7be9e 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2847,11 +2847,13 @@ extern struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 	__ext4_iget((sb), (ino), (flags), __func__, __LINE__)
 
 extern int  ext4_write_inode(struct inode *, struct writeback_control *);
-extern int  ext4_setattr(struct dentry *, struct iattr *);
-extern int  ext4_getattr(const struct path *, struct kstat *, u32, unsigned int);
+extern int  ext4_setattr(struct user_namespace *, struct dentry *, struct iattr *);
+extern int  ext4_getattr(struct user_namespace *, const struct path *,
+			 struct kstat *, u32, unsigned int);
 extern void ext4_evict_inode(struct inode *);
 extern void ext4_clear_inode(struct inode *);
-extern int  ext4_file_getattr(const struct path *, struct kstat *, u32, unsigned int);
+extern int  ext4_file_getattr(struct user_namespace *, const struct path *,
+			      struct kstat *, u32, unsigned int);
 extern int  ext4_sync_inode(handle_t *, struct inode *);
 extern void ext4_dirty_inode(struct inode *, int);
 extern int ext4_change_inode_journal_flag(struct inode *, int);
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index d992fef2e7c2..f9cf9e81fcb7 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5306,7 +5306,8 @@ static void ext4_wait_for_tail_page_commit(struct inode *inode)
  *
  * Called with inode->i_mutex down.
  */
-int ext4_setattr(struct dentry *dentry, struct iattr *attr)
+int ext4_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
+		 struct iattr *attr)
 {
 	struct inode *inode = d_inode(dentry);
 	int error, rc = 0;
@@ -5522,8 +5523,8 @@ int ext4_setattr(struct dentry *dentry, struct iattr *attr)
 	return error;
 }
 
-int ext4_getattr(const struct path *path, struct kstat *stat,
-		 u32 request_mask, unsigned int query_flags)
+int ext4_getattr(struct user_namespace *mnt_userns, const struct path *path,
+		 struct kstat *stat, u32 request_mask, unsigned int query_flags)
 {
 	struct inode *inode = d_inode(path->dentry);
 	struct ext4_inode *raw_inode;
@@ -5562,13 +5563,14 @@ int ext4_getattr(const struct path *path, struct kstat *stat,
 	return 0;
 }
 
-int ext4_file_getattr(const struct path *path, struct kstat *stat,
+int ext4_file_getattr(struct user_namespace *mnt_userns,
+		      const struct path *path, struct kstat *stat,
 		      u32 request_mask, unsigned int query_flags)
 {
 	struct inode *inode = d_inode(path->dentry);
 	u64 delalloc_blocks;
 
-	ext4_getattr(path, stat, request_mask, query_flags);
+	ext4_getattr(&init_user_ns, path, stat, request_mask, query_flags);
 
 	/*
 	 * If there is inline data in the inode, the inode will normally not
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 33509266f5a0..f9560829c4f8 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -2602,8 +2602,8 @@ static int ext4_add_nondir(handle_t *handle,
  * If the create succeeds, we fill in the inode information
  * with d_instantiate().
  */
-static int ext4_create(struct inode *dir, struct dentry *dentry, umode_t mode,
-		       bool excl)
+static int ext4_create(struct user_namespace *mnt_userns, struct inode *dir,
+		       struct dentry *dentry, umode_t mode, bool excl)
 {
 	handle_t *handle;
 	struct inode *inode;
@@ -2637,8 +2637,8 @@ static int ext4_create(struct inode *dir, struct dentry *dentry, umode_t mode,
 	return err;
 }
 
-static int ext4_mknod(struct inode *dir, struct dentry *dentry,
-		      umode_t mode, dev_t rdev)
+static int ext4_mknod(struct user_namespace *mnt_userns, struct inode *dir,
+		      struct dentry *dentry, umode_t mode, dev_t rdev)
 {
 	handle_t *handle;
 	struct inode *inode;
@@ -2671,7 +2671,8 @@ static int ext4_mknod(struct inode *dir, struct dentry *dentry,
 	return err;
 }
 
-static int ext4_tmpfile(struct inode *dir, struct dentry *dentry, umode_t mode)
+static int ext4_tmpfile(struct user_namespace *mnt_userns, struct inode *dir,
+			struct dentry *dentry, umode_t mode)
 {
 	handle_t *handle;
 	struct inode *inode;
@@ -2780,7 +2781,8 @@ int ext4_init_new_dir(handle_t *handle, struct inode *dir,
 	return err;
 }
 
-static int ext4_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
+static int ext4_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
+		      struct dentry *dentry, umode_t mode)
 {
 	handle_t *handle;
 	struct inode *inode;
@@ -3292,7 +3294,7 @@ static int ext4_unlink(struct inode *dir, struct dentry *dentry)
 	return retval;
 }
 
-static int ext4_symlink(struct inode *dir,
+static int ext4_symlink(struct user_namespace *mnt_userns, struct inode *dir,
 			struct dentry *dentry, const char *symname)
 {
 	handle_t *handle;
@@ -4084,7 +4086,8 @@ static int ext4_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
 	return retval;
 }
 
-static int ext4_rename2(struct inode *old_dir, struct dentry *old_dentry,
+static int ext4_rename2(struct user_namespace *mnt_userns,
+			struct inode *old_dir, struct dentry *old_dentry,
 			struct inode *new_dir, struct dentry *new_dentry,
 			unsigned int flags)
 {
diff --git a/fs/f2fs/acl.c b/fs/f2fs/acl.c
index 50735e8a354e..73a8e76161c6 100644
--- a/fs/f2fs/acl.c
+++ b/fs/f2fs/acl.c
@@ -248,7 +248,8 @@ static int __f2fs_set_acl(struct inode *inode, int type,
 	return error;
 }
 
-int f2fs_set_acl(struct inode *inode, struct posix_acl *acl, int type)
+int f2fs_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
+		 struct posix_acl *acl, int type)
 {
 	if (unlikely(f2fs_cp_error(F2FS_I_SB(inode))))
 		return -EIO;
diff --git a/fs/f2fs/acl.h b/fs/f2fs/acl.h
index 124868c13f80..986fd1bc780b 100644
--- a/fs/f2fs/acl.h
+++ b/fs/f2fs/acl.h
@@ -34,7 +34,8 @@ struct f2fs_acl_header {
 #ifdef CONFIG_F2FS_FS_POSIX_ACL
 
 extern struct posix_acl *f2fs_get_acl(struct inode *, int);
-extern int f2fs_set_acl(struct inode *, struct posix_acl *, int);
+extern int f2fs_set_acl(struct user_namespace *, struct inode *,
+			struct posix_acl *, int);
 extern int f2fs_init_acl(struct inode *, struct inode *, struct page *,
 							struct page *);
 #else
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index cb700d797296..5d7b3cdb482f 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3167,9 +3167,10 @@ void f2fs_truncate_data_blocks(struct dnode_of_data *dn);
 int f2fs_do_truncate_blocks(struct inode *inode, u64 from, bool lock);
 int f2fs_truncate_blocks(struct inode *inode, u64 from, bool lock);
 int f2fs_truncate(struct inode *inode);
-int f2fs_getattr(const struct path *path, struct kstat *stat,
-			u32 request_mask, unsigned int flags);
-int f2fs_setattr(struct dentry *dentry, struct iattr *attr);
+int f2fs_getattr(struct user_namespace *mnt_userns, const struct path *path,
+		 struct kstat *stat, u32 request_mask, unsigned int flags);
+int f2fs_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
+		 struct iattr *attr);
 int f2fs_truncate_hole(struct inode *inode, pgoff_t pg_start, pgoff_t pg_end);
 void f2fs_truncate_data_blocks_range(struct dnode_of_data *dn, int count);
 int f2fs_precache_extents(struct inode *inode);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 712e1eaff4d5..640f132e1151 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -777,8 +777,8 @@ int f2fs_truncate(struct inode *inode)
 	return 0;
 }
 
-int f2fs_getattr(const struct path *path, struct kstat *stat,
-		 u32 request_mask, unsigned int query_flags)
+int f2fs_getattr(struct user_namespace *mnt_userns, const struct path *path,
+		 struct kstat *stat, u32 request_mask, unsigned int query_flags)
 {
 	struct inode *inode = d_inode(path->dentry);
 	struct f2fs_inode_info *fi = F2FS_I(inode);
@@ -853,7 +853,8 @@ static void __setattr_copy(struct user_namespace *mnt_userns, struct inode *inod
 #define __setattr_copy setattr_copy
 #endif
 
-int f2fs_setattr(struct dentry *dentry, struct iattr *attr)
+int f2fs_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
+		 struct iattr *attr)
 {
 	struct inode *inode = d_inode(dentry);
 	int err;
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 8a69cf3e3b15..13ae47307016 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -314,8 +314,8 @@ static void set_compress_inode(struct f2fs_sb_info *sbi, struct inode *inode,
 	}
 }
 
-static int f2fs_create(struct inode *dir, struct dentry *dentry, umode_t mode,
-						bool excl)
+static int f2fs_create(struct user_namespace *mnt_userns, struct inode *dir,
+		       struct dentry *dentry, umode_t mode, bool excl)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(dir);
 	struct inode *inode;
@@ -636,8 +636,8 @@ static const char *f2fs_get_link(struct dentry *dentry,
 	return link;
 }
 
-static int f2fs_symlink(struct inode *dir, struct dentry *dentry,
-					const char *symname)
+static int f2fs_symlink(struct user_namespace *mnt_userns, struct inode *dir,
+			struct dentry *dentry, const char *symname)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(dir);
 	struct inode *inode;
@@ -716,7 +716,8 @@ static int f2fs_symlink(struct inode *dir, struct dentry *dentry,
 	return err;
 }
 
-static int f2fs_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
+static int f2fs_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
+		      struct dentry *dentry, umode_t mode)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(dir);
 	struct inode *inode;
@@ -769,8 +770,8 @@ static int f2fs_rmdir(struct inode *dir, struct dentry *dentry)
 	return -ENOTEMPTY;
 }
 
-static int f2fs_mknod(struct inode *dir, struct dentry *dentry,
-				umode_t mode, dev_t rdev)
+static int f2fs_mknod(struct user_namespace *mnt_userns, struct inode *dir,
+		      struct dentry *dentry, umode_t mode, dev_t rdev)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(dir);
 	struct inode *inode;
@@ -873,7 +874,8 @@ static int __f2fs_tmpfile(struct inode *dir, struct dentry *dentry,
 	return err;
 }
 
-static int f2fs_tmpfile(struct inode *dir, struct dentry *dentry, umode_t mode)
+static int f2fs_tmpfile(struct user_namespace *mnt_userns, struct inode *dir,
+			struct dentry *dentry, umode_t mode)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(dir);
 
@@ -1246,7 +1248,8 @@ static int f2fs_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
 	return err;
 }
 
-static int f2fs_rename2(struct inode *old_dir, struct dentry *old_dentry,
+static int f2fs_rename2(struct user_namespace *mnt_userns,
+			struct inode *old_dir, struct dentry *old_dentry,
 			struct inode *new_dir, struct dentry *new_dentry,
 			unsigned int flags)
 {
diff --git a/fs/fat/fat.h b/fs/fat/fat.h
index 922a0c6ba46c..02d4d4234956 100644
--- a/fs/fat/fat.h
+++ b/fs/fat/fat.h
@@ -397,9 +397,11 @@ extern long fat_generic_ioctl(struct file *filp, unsigned int cmd,
 			      unsigned long arg);
 extern const struct file_operations fat_file_operations;
 extern const struct inode_operations fat_file_inode_operations;
-extern int fat_setattr(struct dentry *dentry, struct iattr *attr);
+extern int fat_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
+		       struct iattr *attr);
 extern void fat_truncate_blocks(struct inode *inode, loff_t offset);
-extern int fat_getattr(const struct path *path, struct kstat *stat,
+extern int fat_getattr(struct user_namespace *mnt_userns,
+		       const struct path *path, struct kstat *stat,
 		       u32 request_mask, unsigned int flags);
 extern int fat_file_fsync(struct file *file, loff_t start, loff_t end,
 			  int datasync);
diff --git a/fs/fat/file.c b/fs/fat/file.c
index f7e04f533d31..73acd0843d92 100644
--- a/fs/fat/file.c
+++ b/fs/fat/file.c
@@ -95,7 +95,7 @@ static int fat_ioctl_set_attributes(struct file *file, u32 __user *user_attr)
 		goto out_unlock_inode;
 
 	/* This MUST be done before doing anything irreversible... */
-	err = fat_setattr(file->f_path.dentry, &ia);
+	err = fat_setattr(mnt_user_ns(file->f_path.mnt), file->f_path.dentry, &ia);
 	if (err)
 		goto out_unlock_inode;
 
@@ -394,8 +394,8 @@ void fat_truncate_blocks(struct inode *inode, loff_t offset)
 	fat_flush_inodes(inode->i_sb, inode, NULL);
 }
 
-int fat_getattr(const struct path *path, struct kstat *stat,
-		u32 request_mask, unsigned int flags)
+int fat_getattr(struct user_namespace *mnt_userns, const struct path *path,
+		struct kstat *stat, u32 request_mask, unsigned int flags)
 {
 	struct inode *inode = d_inode(path->dentry);
 	generic_fillattr(&init_user_ns, inode, stat);
@@ -466,7 +466,8 @@ static int fat_allow_set_time(struct msdos_sb_info *sbi, struct inode *inode)
 /* valid file mode bits */
 #define FAT_VALID_MODE	(S_IFREG | S_IFDIR | S_IRWXUGO)
 
-int fat_setattr(struct dentry *dentry, struct iattr *attr)
+int fat_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
+		struct iattr *attr)
 {
 	struct msdos_sb_info *sbi = MSDOS_SB(dentry->d_sb);
 	struct inode *inode = d_inode(dentry);
diff --git a/fs/fat/namei_msdos.c b/fs/fat/namei_msdos.c
index 9d062886fbc1..a8f3375d9d10 100644
--- a/fs/fat/namei_msdos.c
+++ b/fs/fat/namei_msdos.c
@@ -261,8 +261,8 @@ static int msdos_add_entry(struct inode *dir, const unsigned char *name,
 }
 
 /***** Create a file */
-static int msdos_create(struct inode *dir, struct dentry *dentry, umode_t mode,
-			bool excl)
+static int msdos_create(struct user_namespace *mnt_userns, struct inode *dir,
+			struct dentry *dentry, umode_t mode, bool excl)
 {
 	struct super_block *sb = dir->i_sb;
 	struct inode *inode = NULL;
@@ -339,7 +339,8 @@ static int msdos_rmdir(struct inode *dir, struct dentry *dentry)
 }
 
 /***** Make a directory */
-static int msdos_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
+static int msdos_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
+		       struct dentry *dentry, umode_t mode)
 {
 	struct super_block *sb = dir->i_sb;
 	struct fat_slot_info sinfo;
@@ -593,7 +594,8 @@ static int do_msdos_rename(struct inode *old_dir, unsigned char *old_name,
 }
 
 /***** Rename, a wrapper for rename_same_dir & rename_diff_dir */
-static int msdos_rename(struct inode *old_dir, struct dentry *old_dentry,
+static int msdos_rename(struct user_namespace *mnt_userns,
+			struct inode *old_dir, struct dentry *old_dentry,
 			struct inode *new_dir, struct dentry *new_dentry,
 			unsigned int flags)
 {
diff --git a/fs/fat/namei_vfat.c b/fs/fat/namei_vfat.c
index 0cdd0fb9f742..23936ecf79a5 100644
--- a/fs/fat/namei_vfat.c
+++ b/fs/fat/namei_vfat.c
@@ -756,8 +756,8 @@ static struct dentry *vfat_lookup(struct inode *dir, struct dentry *dentry,
 	return ERR_PTR(err);
 }
 
-static int vfat_create(struct inode *dir, struct dentry *dentry, umode_t mode,
-		       bool excl)
+static int vfat_create(struct user_namespace *mnt_userns, struct inode *dir,
+		       struct dentry *dentry, umode_t mode, bool excl)
 {
 	struct super_block *sb = dir->i_sb;
 	struct inode *inode;
@@ -846,7 +846,8 @@ static int vfat_unlink(struct inode *dir, struct dentry *dentry)
 	return err;
 }
 
-static int vfat_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
+static int vfat_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
+		      struct dentry *dentry, umode_t mode)
 {
 	struct super_block *sb = dir->i_sb;
 	struct inode *inode;
@@ -892,9 +893,9 @@ static int vfat_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 	return err;
 }
 
-static int vfat_rename(struct inode *old_dir, struct dentry *old_dentry,
-		       struct inode *new_dir, struct dentry *new_dentry,
-		       unsigned int flags)
+static int vfat_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
+		       struct dentry *old_dentry, struct inode *new_dir,
+		       struct dentry *new_dentry, unsigned int flags)
 {
 	struct buffer_head *dotdot_bh;
 	struct msdos_dir_entry *dotdot_de;
diff --git a/fs/fuse/acl.c b/fs/fuse/acl.c
index 5a48cee6d7d3..327d5e3e9071 100644
--- a/fs/fuse/acl.c
+++ b/fs/fuse/acl.c
@@ -47,7 +47,8 @@ struct posix_acl *fuse_get_acl(struct inode *inode, int type)
 	return acl;
 }
 
-int fuse_set_acl(struct inode *inode, struct posix_acl *acl, int type)
+int fuse_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
+		 struct posix_acl *acl, int type)
 {
 	struct fuse_conn *fc = get_fuse_conn(inode);
 	const char *name;
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 0750755685cd..658fcee11c52 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -597,7 +597,8 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
 	return err;
 }
 
-static int fuse_mknod(struct inode *, struct dentry *, umode_t, dev_t);
+static int fuse_mknod(struct user_namespace *, struct inode *, struct dentry *,
+		      umode_t, dev_t);
 static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
 			    struct file *file, unsigned flags,
 			    umode_t mode)
@@ -634,7 +635,7 @@ static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
 	return err;
 
 mknod:
-	err = fuse_mknod(dir, entry, mode, 0);
+	err = fuse_mknod(&init_user_ns, dir, entry, mode, 0);
 	if (err)
 		goto out_dput;
 no_open:
@@ -701,8 +702,8 @@ static int create_new_entry(struct fuse_mount *fm, struct fuse_args *args,
 	return err;
 }
 
-static int fuse_mknod(struct inode *dir, struct dentry *entry, umode_t mode,
-		      dev_t rdev)
+static int fuse_mknod(struct user_namespace *mnt_userns, struct inode *dir,
+		      struct dentry *entry, umode_t mode, dev_t rdev)
 {
 	struct fuse_mknod_in inarg;
 	struct fuse_mount *fm = get_fuse_mount(dir);
@@ -724,13 +725,14 @@ static int fuse_mknod(struct inode *dir, struct dentry *entry, umode_t mode,
 	return create_new_entry(fm, &args, dir, entry, mode);
 }
 
-static int fuse_create(struct inode *dir, struct dentry *entry, umode_t mode,
-		       bool excl)
+static int fuse_create(struct user_namespace *mnt_userns, struct inode *dir,
+		       struct dentry *entry, umode_t mode, bool excl)
 {
-	return fuse_mknod(dir, entry, mode, 0);
+	return fuse_mknod(&init_user_ns, dir, entry, mode, 0);
 }
 
-static int fuse_mkdir(struct inode *dir, struct dentry *entry, umode_t mode)
+static int fuse_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
+		      struct dentry *entry, umode_t mode)
 {
 	struct fuse_mkdir_in inarg;
 	struct fuse_mount *fm = get_fuse_mount(dir);
@@ -751,8 +753,8 @@ static int fuse_mkdir(struct inode *dir, struct dentry *entry, umode_t mode)
 	return create_new_entry(fm, &args, dir, entry, S_IFDIR);
 }
 
-static int fuse_symlink(struct inode *dir, struct dentry *entry,
-			const char *link)
+static int fuse_symlink(struct user_namespace *mnt_userns, struct inode *dir,
+			struct dentry *entry, const char *link)
 {
 	struct fuse_mount *fm = get_fuse_mount(dir);
 	unsigned len = strlen(link) + 1;
@@ -888,9 +890,9 @@ static int fuse_rename_common(struct inode *olddir, struct dentry *oldent,
 	return err;
 }
 
-static int fuse_rename2(struct inode *olddir, struct dentry *oldent,
-			struct inode *newdir, struct dentry *newent,
-			unsigned int flags)
+static int fuse_rename2(struct user_namespace *mnt_userns, struct inode *olddir,
+			struct dentry *oldent, struct inode *newdir,
+			struct dentry *newent, unsigned int flags)
 {
 	struct fuse_conn *fc = get_fuse_conn(olddir);
 	int err;
@@ -1226,7 +1228,8 @@ static int fuse_perm_getattr(struct inode *inode, int mask)
  * access request is sent.  Execute permission is still checked
  * locally based on file mode.
  */
-static int fuse_permission(struct inode *inode, int mask)
+static int fuse_permission(struct user_namespace *mnt_userns,
+			   struct inode *inode, int mask)
 {
 	struct fuse_conn *fc = get_fuse_conn(inode);
 	bool refreshed = false;
@@ -1720,7 +1723,8 @@ int fuse_do_setattr(struct dentry *dentry, struct iattr *attr,
 	return err;
 }
 
-static int fuse_setattr(struct dentry *entry, struct iattr *attr)
+static int fuse_setattr(struct user_namespace *mnt_userns, struct dentry *entry,
+			struct iattr *attr)
 {
 	struct inode *inode = d_inode(entry);
 	struct fuse_conn *fc = get_fuse_conn(inode);
@@ -1779,7 +1783,8 @@ static int fuse_setattr(struct dentry *entry, struct iattr *attr)
 	return ret;
 }
 
-static int fuse_getattr(const struct path *path, struct kstat *stat,
+static int fuse_getattr(struct user_namespace *mnt_userns,
+			const struct path *path, struct kstat *stat,
 			u32 request_mask, unsigned int flags)
 {
 	struct inode *inode = d_inode(path->dentry);
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index d51598017d13..a05e469ba108 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1177,8 +1177,8 @@ extern const struct xattr_handler *fuse_no_acl_xattr_handlers[];
 
 struct posix_acl;
 struct posix_acl *fuse_get_acl(struct inode *inode, int type);
-int fuse_set_acl(struct inode *inode, struct posix_acl *acl, int type);
-
+int fuse_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
+		 struct posix_acl *acl, int type);
 
 /* readdir.c */
 int fuse_readdir(struct file *file, struct dir_context *ctx);
diff --git a/fs/gfs2/acl.c b/fs/gfs2/acl.c
index ce88ef29eef0..9165d70ead07 100644
--- a/fs/gfs2/acl.c
+++ b/fs/gfs2/acl.c
@@ -106,7 +106,8 @@ int __gfs2_set_acl(struct inode *inode, struct posix_acl *acl, int type)
 	return error;
 }
 
-int gfs2_set_acl(struct inode *inode, struct posix_acl *acl, int type)
+int gfs2_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
+		 struct posix_acl *acl, int type)
 {
 	struct gfs2_inode *ip = GFS2_I(inode);
 	struct gfs2_holder gh;
diff --git a/fs/gfs2/acl.h b/fs/gfs2/acl.h
index 61353a1501c5..eccc6a43326c 100644
--- a/fs/gfs2/acl.h
+++ b/fs/gfs2/acl.h
@@ -13,6 +13,7 @@
 
 extern struct posix_acl *gfs2_get_acl(struct inode *inode, int type);
 extern int __gfs2_set_acl(struct inode *inode, struct posix_acl *acl, int type);
-extern int gfs2_set_acl(struct inode *inode, struct posix_acl *acl, int type);
+extern int gfs2_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
+			struct posix_acl *acl, int type);
 
 #endif /* __ACL_DOT_H__ */
diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
index 1d994bdfffaa..8f5523822788 100644
--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -256,7 +256,7 @@ static int do_gfs2_set_flags(struct file *filp, u32 reqflags, u32 mask,
 	    !capable(CAP_LINUX_IMMUTABLE))
 		goto out;
 	if (!IS_IMMUTABLE(inode)) {
-		error = gfs2_permission(inode, MAY_WRITE);
+		error = gfs2_permission(&init_user_ns, inode, MAY_WRITE);
 		if (error)
 			goto out;
 	}
diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index f1841667bcd9..c09a73a68d37 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -321,7 +321,7 @@ struct inode *gfs2_lookupi(struct inode *dir, const struct qstr *name,
 	}
 
 	if (!is_root) {
-		error = gfs2_permission(dir, MAY_EXEC);
+		error = gfs2_permission(&init_user_ns, dir, MAY_EXEC);
 		if (error)
 			goto out;
 	}
@@ -351,7 +351,8 @@ static int create_ok(struct gfs2_inode *dip, const struct qstr *name,
 {
 	int error;
 
-	error = gfs2_permission(&dip->i_inode, MAY_WRITE | MAY_EXEC);
+	error = gfs2_permission(&init_user_ns, &dip->i_inode,
+				MAY_WRITE | MAY_EXEC);
 	if (error)
 		return error;
 
@@ -842,8 +843,8 @@ static int gfs2_create_inode(struct inode *dir, struct dentry *dentry,
  * Returns: errno
  */
 
-static int gfs2_create(struct inode *dir, struct dentry *dentry,
-		       umode_t mode, bool excl)
+static int gfs2_create(struct user_namespace *mnt_userns, struct inode *dir,
+		       struct dentry *dentry, umode_t mode, bool excl)
 {
 	return gfs2_create_inode(dir, dentry, NULL, S_IFREG | mode, 0, NULL, 0, excl);
 }
@@ -950,7 +951,7 @@ static int gfs2_link(struct dentry *old_dentry, struct inode *dir,
 	if (inode->i_nlink == 0)
 		goto out_gunlock;
 
-	error = gfs2_permission(dir, MAY_WRITE | MAY_EXEC);
+	error = gfs2_permission(&init_user_ns, dir, MAY_WRITE | MAY_EXEC);
 	if (error)
 		goto out_gunlock;
 
@@ -1067,7 +1068,8 @@ static int gfs2_unlink_ok(struct gfs2_inode *dip, const struct qstr *name,
 	if (IS_APPEND(&dip->i_inode))
 		return -EPERM;
 
-	error = gfs2_permission(&dip->i_inode, MAY_WRITE | MAY_EXEC);
+	error = gfs2_permission(&init_user_ns, &dip->i_inode,
+				MAY_WRITE | MAY_EXEC);
 	if (error)
 		return error;
 
@@ -1203,8 +1205,8 @@ static int gfs2_unlink(struct inode *dir, struct dentry *dentry)
  * Returns: errno
  */
 
-static int gfs2_symlink(struct inode *dir, struct dentry *dentry,
-			const char *symname)
+static int gfs2_symlink(struct user_namespace *mnt_userns, struct inode *dir,
+			struct dentry *dentry, const char *symname)
 {
 	unsigned int size;
 
@@ -1224,7 +1226,8 @@ static int gfs2_symlink(struct inode *dir, struct dentry *dentry,
  * Returns: errno
  */
 
-static int gfs2_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
+static int gfs2_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
+		      struct dentry *dentry, umode_t mode)
 {
 	unsigned dsize = gfs2_max_stuffed_size(GFS2_I(dir));
 	return gfs2_create_inode(dir, dentry, NULL, S_IFDIR | mode, 0, NULL, dsize, 0);
@@ -1239,8 +1242,8 @@ static int gfs2_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
  *
  */
 
-static int gfs2_mknod(struct inode *dir, struct dentry *dentry, umode_t mode,
-		      dev_t dev)
+static int gfs2_mknod(struct user_namespace *mnt_userns, struct inode *dir,
+		      struct dentry *dentry, umode_t mode, dev_t dev)
 {
 	return gfs2_create_inode(dir, dentry, NULL, mode, dev, NULL, 0, 0);
 }
@@ -1489,7 +1492,7 @@ static int gfs2_rename(struct inode *odir, struct dentry *odentry,
 			}
 		}
 	} else {
-		error = gfs2_permission(ndir, MAY_WRITE | MAY_EXEC);
+		error = gfs2_permission(&init_user_ns, ndir, MAY_WRITE | MAY_EXEC);
 		if (error)
 			goto out_gunlock;
 
@@ -1524,7 +1527,7 @@ static int gfs2_rename(struct inode *odir, struct dentry *odentry,
 	/* Check out the dir to be renamed */
 
 	if (dir_rename) {
-		error = gfs2_permission(d_inode(odentry), MAY_WRITE);
+		error = gfs2_permission(&init_user_ns, d_inode(odentry), MAY_WRITE);
 		if (error)
 			goto out_gunlock;
 	}
@@ -1687,12 +1690,12 @@ static int gfs2_exchange(struct inode *odir, struct dentry *odentry,
 		goto out_gunlock;
 
 	if (S_ISDIR(old_mode)) {
-		error = gfs2_permission(odentry->d_inode, MAY_WRITE);
+		error = gfs2_permission(&init_user_ns, odentry->d_inode, MAY_WRITE);
 		if (error)
 			goto out_gunlock;
 	}
 	if (S_ISDIR(new_mode)) {
-		error = gfs2_permission(ndentry->d_inode, MAY_WRITE);
+		error = gfs2_permission(&init_user_ns, ndentry->d_inode, MAY_WRITE);
 		if (error)
 			goto out_gunlock;
 	}
@@ -1746,9 +1749,9 @@ static int gfs2_exchange(struct inode *odir, struct dentry *odentry,
 	return error;
 }
 
-static int gfs2_rename2(struct inode *odir, struct dentry *odentry,
-			struct inode *ndir, struct dentry *ndentry,
-			unsigned int flags)
+static int gfs2_rename2(struct user_namespace *mnt_userns, struct inode *odir,
+			struct dentry *odentry, struct inode *ndir,
+			struct dentry *ndentry, unsigned int flags)
 {
 	flags &= ~RENAME_NOREPLACE;
 
@@ -1832,7 +1835,8 @@ static const char *gfs2_get_link(struct dentry *dentry,
  * Returns: errno
  */
 
-int gfs2_permission(struct inode *inode, int mask)
+int gfs2_permission(struct user_namespace *mnt_userns, struct inode *inode,
+		    int mask)
 {
 	struct gfs2_inode *ip;
 	struct gfs2_holder i_gh;
@@ -1962,7 +1966,8 @@ static int setattr_chown(struct inode *inode, struct iattr *attr)
  * Returns: errno
  */
 
-static int gfs2_setattr(struct dentry *dentry, struct iattr *attr)
+static int gfs2_setattr(struct user_namespace *mnt_userns,
+			struct dentry *dentry, struct iattr *attr)
 {
 	struct inode *inode = d_inode(dentry);
 	struct gfs2_inode *ip = GFS2_I(inode);
@@ -2006,6 +2011,7 @@ static int gfs2_setattr(struct dentry *dentry, struct iattr *attr)
 
 /**
  * gfs2_getattr - Read out an inode's attributes
+ * @mnt_userns:	user namespace of the mount the inode was found from
  * @path: Object to query
  * @stat: The inode's stats
  * @request_mask: Mask of STATX_xxx flags indicating the caller's interests
@@ -2020,7 +2026,8 @@ static int gfs2_setattr(struct dentry *dentry, struct iattr *attr)
  * Returns: errno
  */
 
-static int gfs2_getattr(const struct path *path, struct kstat *stat,
+static int gfs2_getattr(struct user_namespace *mnt_userns,
+			const struct path *path, struct kstat *stat,
 			u32 request_mask, unsigned int flags)
 {
 	struct inode *inode = d_inode(path->dentry);
diff --git a/fs/gfs2/inode.h b/fs/gfs2/inode.h
index b52ecf4ffe63..64eb951b6156 100644
--- a/fs/gfs2/inode.h
+++ b/fs/gfs2/inode.h
@@ -99,7 +99,8 @@ extern int gfs2_inode_refresh(struct gfs2_inode *ip);
 
 extern struct inode *gfs2_lookupi(struct inode *dir, const struct qstr *name,
 				  int is_root);
-extern int gfs2_permission(struct inode *inode, int mask);
+extern int gfs2_permission(struct user_namespace *mnt_userns,
+			   struct inode *inode, int mask);
 extern int gfs2_setattr_simple(struct inode *inode, struct iattr *attr);
 extern struct inode *gfs2_lookup_simple(struct inode *dip, const char *name);
 extern void gfs2_dinode_out(const struct gfs2_inode *ip, void *buf);
diff --git a/fs/hfs/dir.c b/fs/hfs/dir.c
index 3bf2ae0e467c..527f6e46cbe8 100644
--- a/fs/hfs/dir.c
+++ b/fs/hfs/dir.c
@@ -189,8 +189,8 @@ static int hfs_dir_release(struct inode *inode, struct file *file)
  * a directory and return a corresponding inode, given the inode for
  * the directory and the name (and its length) of the new file.
  */
-static int hfs_create(struct inode *dir, struct dentry *dentry, umode_t mode,
-		      bool excl)
+static int hfs_create(struct user_namespace *mnt_userns, struct inode *dir,
+		      struct dentry *dentry, umode_t mode, bool excl)
 {
 	struct inode *inode;
 	int res;
@@ -219,7 +219,8 @@ static int hfs_create(struct inode *dir, struct dentry *dentry, umode_t mode,
  * in a directory, given the inode for the parent directory and the
  * name (and its length) of the new directory.
  */
-static int hfs_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
+static int hfs_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
+		     struct dentry *dentry, umode_t mode)
 {
 	struct inode *inode;
 	int res;
@@ -279,9 +280,9 @@ static int hfs_remove(struct inode *dir, struct dentry *dentry)
  * new file/directory.
  * XXX: how do you handle must_be dir?
  */
-static int hfs_rename(struct inode *old_dir, struct dentry *old_dentry,
-		      struct inode *new_dir, struct dentry *new_dentry,
-		      unsigned int flags)
+static int hfs_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
+		      struct dentry *old_dentry, struct inode *new_dir,
+		      struct dentry *new_dentry, unsigned int flags)
 {
 	int res;
 
diff --git a/fs/hfs/hfs_fs.h b/fs/hfs/hfs_fs.h
index f71c384064c8..e84985416511 100644
--- a/fs/hfs/hfs_fs.h
+++ b/fs/hfs/hfs_fs.h
@@ -204,7 +204,7 @@ extern const struct address_space_operations hfs_btree_aops;
 extern struct inode *hfs_new_inode(struct inode *, const struct qstr *, umode_t);
 extern void hfs_inode_write_fork(struct inode *, struct hfs_extent *, __be32 *, __be32 *);
 extern int hfs_write_inode(struct inode *, struct writeback_control *);
-extern int hfs_inode_setattr(struct dentry *, struct iattr *);
+extern int hfs_inode_setattr(struct user_namespace *, struct dentry *, struct iattr *);
 extern void hfs_inode_read_fork(struct inode *inode, struct hfs_extent *ext,
 			__be32 log_size, __be32 phys_size, u32 clump_size);
 extern struct inode *hfs_iget(struct super_block *, struct hfs_cat_key *, hfs_cat_rec *);
diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
index c646218b72bf..4486a9004754 100644
--- a/fs/hfs/inode.c
+++ b/fs/hfs/inode.c
@@ -602,7 +602,8 @@ static int hfs_file_release(struct inode *inode, struct file *file)
  *     correspond to the same HFS file.
  */
 
-int hfs_inode_setattr(struct dentry *dentry, struct iattr * attr)
+int hfs_inode_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
+		      struct iattr *attr)
 {
 	struct inode *inode = d_inode(dentry);
 	struct hfs_sb_info *hsb = HFS_SB(inode->i_sb);
diff --git a/fs/hfsplus/dir.c b/fs/hfsplus/dir.c
index 29a9dcfbe81f..fc59cb0b0949 100644
--- a/fs/hfsplus/dir.c
+++ b/fs/hfsplus/dir.c
@@ -434,8 +434,8 @@ static int hfsplus_rmdir(struct inode *dir, struct dentry *dentry)
 	return res;
 }
 
-static int hfsplus_symlink(struct inode *dir, struct dentry *dentry,
-			   const char *symname)
+static int hfsplus_symlink(struct user_namespace *mnt_userns, struct inode *dir,
+			   struct dentry *dentry, const char *symname)
 {
 	struct hfsplus_sb_info *sbi = HFSPLUS_SB(dir->i_sb);
 	struct inode *inode;
@@ -476,8 +476,8 @@ static int hfsplus_symlink(struct inode *dir, struct dentry *dentry,
 	return res;
 }
 
-static int hfsplus_mknod(struct inode *dir, struct dentry *dentry,
-			 umode_t mode, dev_t rdev)
+static int hfsplus_mknod(struct user_namespace *mnt_userns, struct inode *dir,
+			 struct dentry *dentry, umode_t mode, dev_t rdev)
 {
 	struct hfsplus_sb_info *sbi = HFSPLUS_SB(dir->i_sb);
 	struct inode *inode;
@@ -517,20 +517,21 @@ static int hfsplus_mknod(struct inode *dir, struct dentry *dentry,
 	return res;
 }
 
-static int hfsplus_create(struct inode *dir, struct dentry *dentry, umode_t mode,
-			  bool excl)
+static int hfsplus_create(struct user_namespace *mnt_userns, struct inode *dir,
+			  struct dentry *dentry, umode_t mode, bool excl)
 {
-	return hfsplus_mknod(dir, dentry, mode, 0);
+	return hfsplus_mknod(&init_user_ns, dir, dentry, mode, 0);
 }
 
-static int hfsplus_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
+static int hfsplus_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
+			 struct dentry *dentry, umode_t mode)
 {
-	return hfsplus_mknod(dir, dentry, mode | S_IFDIR, 0);
+	return hfsplus_mknod(&init_user_ns, dir, dentry, mode | S_IFDIR, 0);
 }
 
-static int hfsplus_rename(struct inode *old_dir, struct dentry *old_dentry,
-			  struct inode *new_dir, struct dentry *new_dentry,
-			  unsigned int flags)
+static int hfsplus_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
+			  struct dentry *old_dentry, struct inode *new_dir,
+			  struct dentry *new_dentry, unsigned int flags)
 {
 	int res;
 
diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
index a92de5199ec3..12b20479ed2b 100644
--- a/fs/hfsplus/hfsplus_fs.h
+++ b/fs/hfsplus/hfsplus_fs.h
@@ -488,8 +488,9 @@ void hfsplus_inode_write_fork(struct inode *inode,
 			      struct hfsplus_fork_raw *fork);
 int hfsplus_cat_read_inode(struct inode *inode, struct hfs_find_data *fd);
 int hfsplus_cat_write_inode(struct inode *inode);
-int hfsplus_getattr(const struct path *path, struct kstat *stat,
-		    u32 request_mask, unsigned int query_flags);
+int hfsplus_getattr(struct user_namespace *mnt_userns, const struct path *path,
+		    struct kstat *stat, u32 request_mask,
+		    unsigned int query_flags);
 int hfsplus_file_fsync(struct file *file, loff_t start, loff_t end,
 		       int datasync);
 
diff --git a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
index 642e067d8fe8..7a937de9b2ad 100644
--- a/fs/hfsplus/inode.c
+++ b/fs/hfsplus/inode.c
@@ -241,7 +241,8 @@ static int hfsplus_file_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
-static int hfsplus_setattr(struct dentry *dentry, struct iattr *attr)
+static int hfsplus_setattr(struct user_namespace *mnt_userns,
+			   struct dentry *dentry, struct iattr *attr)
 {
 	struct inode *inode = d_inode(dentry);
 	int error;
@@ -270,8 +271,9 @@ static int hfsplus_setattr(struct dentry *dentry, struct iattr *attr)
 	return 0;
 }
 
-int hfsplus_getattr(const struct path *path, struct kstat *stat,
-		    u32 request_mask, unsigned int query_flags)
+int hfsplus_getattr(struct user_namespace *mnt_userns, const struct path *path,
+		    struct kstat *stat, u32 request_mask,
+		    unsigned int query_flags)
 {
 	struct inode *inode = d_inode(path->dentry);
 	struct hfsplus_inode_info *hip = HFSPLUS_I(inode);
diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index a00899c8fd52..2a24c0d28fee 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -555,8 +555,8 @@ static int read_name(struct inode *ino, char *name)
 	return 0;
 }
 
-static int hostfs_create(struct inode *dir, struct dentry *dentry, umode_t mode,
-			 bool excl)
+static int hostfs_create(struct user_namespace *mnt_userns, struct inode *dir,
+			 struct dentry *dentry, umode_t mode, bool excl)
 {
 	struct inode *inode;
 	char *name;
@@ -654,8 +654,8 @@ static int hostfs_unlink(struct inode *ino, struct dentry *dentry)
 	return err;
 }
 
-static int hostfs_symlink(struct inode *ino, struct dentry *dentry,
-			  const char *to)
+static int hostfs_symlink(struct user_namespace *mnt_userns, struct inode *ino,
+			  struct dentry *dentry, const char *to)
 {
 	char *file;
 	int err;
@@ -667,7 +667,8 @@ static int hostfs_symlink(struct inode *ino, struct dentry *dentry,
 	return err;
 }
 
-static int hostfs_mkdir(struct inode *ino, struct dentry *dentry, umode_t mode)
+static int hostfs_mkdir(struct user_namespace *mnt_userns, struct inode *ino,
+			struct dentry *dentry, umode_t mode)
 {
 	char *file;
 	int err;
@@ -691,7 +692,8 @@ static int hostfs_rmdir(struct inode *ino, struct dentry *dentry)
 	return err;
 }
 
-static int hostfs_mknod(struct inode *dir, struct dentry *dentry, umode_t mode, dev_t dev)
+static int hostfs_mknod(struct user_namespace *mnt_userns, struct inode *dir,
+			struct dentry *dentry, umode_t mode, dev_t dev)
 {
 	struct inode *inode;
 	char *name;
@@ -729,7 +731,8 @@ static int hostfs_mknod(struct inode *dir, struct dentry *dentry, umode_t mode,
 	return err;
 }
 
-static int hostfs_rename2(struct inode *old_dir, struct dentry *old_dentry,
+static int hostfs_rename2(struct user_namespace *mnt_userns,
+			  struct inode *old_dir, struct dentry *old_dentry,
 			  struct inode *new_dir, struct dentry *new_dentry,
 			  unsigned int flags)
 {
@@ -757,7 +760,8 @@ static int hostfs_rename2(struct inode *old_dir, struct dentry *old_dentry,
 	return err;
 }
 
-static int hostfs_permission(struct inode *ino, int desired)
+static int hostfs_permission(struct user_namespace *mnt_userns,
+			     struct inode *ino, int desired)
 {
 	char *name;
 	int r = 0, w = 0, x = 0, err;
@@ -783,7 +787,8 @@ static int hostfs_permission(struct inode *ino, int desired)
 	return err;
 }
 
-static int hostfs_setattr(struct dentry *dentry, struct iattr *attr)
+static int hostfs_setattr(struct user_namespace *mnt_userns,
+			  struct dentry *dentry, struct iattr *attr)
 {
 	struct inode *inode = d_inode(dentry);
 	struct hostfs_iattr attrs;
diff --git a/fs/hpfs/hpfs_fn.h b/fs/hpfs/hpfs_fn.h
index 1cca83218fb5..167ec6884642 100644
--- a/fs/hpfs/hpfs_fn.h
+++ b/fs/hpfs/hpfs_fn.h
@@ -280,7 +280,7 @@ void hpfs_init_inode(struct inode *);
 void hpfs_read_inode(struct inode *);
 void hpfs_write_inode(struct inode *);
 void hpfs_write_inode_nolock(struct inode *);
-int hpfs_setattr(struct dentry *, struct iattr *);
+int hpfs_setattr(struct user_namespace *, struct dentry *, struct iattr *);
 void hpfs_write_if_changed(struct inode *);
 void hpfs_evict_inode(struct inode *);
 
diff --git a/fs/hpfs/inode.c b/fs/hpfs/inode.c
index 8ba2152a78ba..82208cc28ebd 100644
--- a/fs/hpfs/inode.c
+++ b/fs/hpfs/inode.c
@@ -257,7 +257,8 @@ void hpfs_write_inode_nolock(struct inode *i)
 	brelse(bh);
 }
 
-int hpfs_setattr(struct dentry *dentry, struct iattr *attr)
+int hpfs_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
+		 struct iattr *attr)
 {
 	struct inode *inode = d_inode(dentry);
 	int error = -EINVAL;
diff --git a/fs/hpfs/namei.c b/fs/hpfs/namei.c
index 1aee39160ac5..d73f8a67168e 100644
--- a/fs/hpfs/namei.c
+++ b/fs/hpfs/namei.c
@@ -20,7 +20,8 @@ static void hpfs_update_directory_times(struct inode *dir)
 	hpfs_write_inode_nolock(dir);
 }
 
-static int hpfs_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
+static int hpfs_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
+		      struct dentry *dentry, umode_t mode)
 {
 	const unsigned char *name = dentry->d_name.name;
 	unsigned len = dentry->d_name.len;
@@ -128,7 +129,8 @@ static int hpfs_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 	return err;
 }
 
-static int hpfs_create(struct inode *dir, struct dentry *dentry, umode_t mode, bool excl)
+static int hpfs_create(struct user_namespace *mnt_userns, struct inode *dir,
+		       struct dentry *dentry, umode_t mode, bool excl)
 {
 	const unsigned char *name = dentry->d_name.name;
 	unsigned len = dentry->d_name.len;
@@ -215,7 +217,8 @@ static int hpfs_create(struct inode *dir, struct dentry *dentry, umode_t mode, b
 	return err;
 }
 
-static int hpfs_mknod(struct inode *dir, struct dentry *dentry, umode_t mode, dev_t rdev)
+static int hpfs_mknod(struct user_namespace *mnt_userns, struct inode *dir,
+		      struct dentry *dentry, umode_t mode, dev_t rdev)
 {
 	const unsigned char *name = dentry->d_name.name;
 	unsigned len = dentry->d_name.len;
@@ -289,7 +292,8 @@ static int hpfs_mknod(struct inode *dir, struct dentry *dentry, umode_t mode, de
 	return err;
 }
 
-static int hpfs_symlink(struct inode *dir, struct dentry *dentry, const char *symlink)
+static int hpfs_symlink(struct user_namespace *mnt_userns, struct inode *dir,
+			struct dentry *dentry, const char *symlink)
 {
 	const unsigned char *name = dentry->d_name.name;
 	unsigned len = dentry->d_name.len;
@@ -506,10 +510,10 @@ static int hpfs_symlink_readpage(struct file *file, struct page *page)
 const struct address_space_operations hpfs_symlink_aops = {
 	.readpage	= hpfs_symlink_readpage
 };
-	
-static int hpfs_rename(struct inode *old_dir, struct dentry *old_dentry,
-		       struct inode *new_dir, struct dentry *new_dentry,
-		       unsigned int flags)
+
+static int hpfs_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
+		       struct dentry *old_dentry, struct inode *new_dir,
+		       struct dentry *new_dentry, unsigned int flags)
 {
 	const unsigned char *old_name = old_dentry->d_name.name;
 	unsigned old_len = old_dentry->d_name.len;
diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 327e572b4e00..87222bc5fdab 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -751,7 +751,8 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
 	return error;
 }
 
-static int hugetlbfs_setattr(struct dentry *dentry, struct iattr *attr)
+static int hugetlbfs_setattr(struct user_namespace *mnt_userns,
+			     struct dentry *dentry, struct iattr *attr)
 {
 	struct inode *inode = d_inode(dentry);
 	struct hstate *h = hstate_inode(inode);
@@ -898,33 +899,35 @@ static int do_hugetlbfs_mknod(struct inode *dir,
 	return error;
 }
 
-static int hugetlbfs_mknod(struct inode *dir,
-			struct dentry *dentry, umode_t mode, dev_t dev)
+static int hugetlbfs_mknod(struct user_namespace *mnt_userns, struct inode *dir,
+			   struct dentry *dentry, umode_t mode, dev_t dev)
 {
 	return do_hugetlbfs_mknod(dir, dentry, mode, dev, false);
 }
 
-static int hugetlbfs_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
+static int hugetlbfs_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
+			   struct dentry *dentry, umode_t mode)
 {
-	int retval = hugetlbfs_mknod(dir, dentry, mode | S_IFDIR, 0);
+	int retval = hugetlbfs_mknod(&init_user_ns, dir, dentry, mode | S_IFDIR, 0);
 	if (!retval)
 		inc_nlink(dir);
 	return retval;
 }
 
-static int hugetlbfs_create(struct inode *dir, struct dentry *dentry, umode_t mode, bool excl)
+static int hugetlbfs_create(struct user_namespace *mnt_userns, struct inode *dir,
+			    struct dentry *dentry, umode_t mode, bool excl)
 {
-	return hugetlbfs_mknod(dir, dentry, mode | S_IFREG, 0);
+	return hugetlbfs_mknod(&init_user_ns, dir, dentry, mode | S_IFREG, 0);
 }
 
-static int hugetlbfs_tmpfile(struct inode *dir,
-			struct dentry *dentry, umode_t mode)
+static int hugetlbfs_tmpfile(struct user_namespace *mnt_userns, struct inode *dir,
+			     struct dentry *dentry, umode_t mode)
 {
 	return do_hugetlbfs_mknod(dir, dentry, mode | S_IFREG, 0, true);
 }
 
-static int hugetlbfs_symlink(struct inode *dir,
-			struct dentry *dentry, const char *symname)
+static int hugetlbfs_symlink(struct user_namespace *mnt_userns, struct inode *dir,
+			     struct dentry *dentry, const char *symname)
 {
 	struct inode *inode;
 	int error = -ENOSPC;
diff --git a/fs/jffs2/acl.c b/fs/jffs2/acl.c
index cf07a2fdf8bf..96557e6d4add 100644
--- a/fs/jffs2/acl.c
+++ b/fs/jffs2/acl.c
@@ -226,7 +226,8 @@ static int __jffs2_set_acl(struct inode *inode, int xprefix, struct posix_acl *a
 	return rc;
 }
 
-int jffs2_set_acl(struct inode *inode, struct posix_acl *acl, int type)
+int jffs2_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
+		  struct posix_acl *acl, int type)
 {
 	int rc, xprefix;
 
diff --git a/fs/jffs2/acl.h b/fs/jffs2/acl.h
index 12d0271bdde3..62c50da9d493 100644
--- a/fs/jffs2/acl.h
+++ b/fs/jffs2/acl.h
@@ -28,7 +28,8 @@ struct jffs2_acl_header {
 #ifdef CONFIG_JFFS2_FS_POSIX_ACL
 
 struct posix_acl *jffs2_get_acl(struct inode *inode, int type);
-int jffs2_set_acl(struct inode *inode, struct posix_acl *acl, int type);
+int jffs2_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
+		  struct posix_acl *acl, int type);
 extern int jffs2_init_acl_pre(struct inode *, struct inode *, umode_t *);
 extern int jffs2_init_acl_post(struct inode *);
 
diff --git a/fs/jffs2/dir.c b/fs/jffs2/dir.c
index 776493713153..7ec7e0181f2b 100644
--- a/fs/jffs2/dir.c
+++ b/fs/jffs2/dir.c
@@ -24,17 +24,18 @@
 
 static int jffs2_readdir (struct file *, struct dir_context *);
 
-static int jffs2_create (struct inode *,struct dentry *,umode_t,
-			 bool);
+static int jffs2_create (struct user_namespace *, struct inode *,
+		         struct dentry *, umode_t, bool);
 static struct dentry *jffs2_lookup (struct inode *,struct dentry *,
 				    unsigned int);
 static int jffs2_link (struct dentry *,struct inode *,struct dentry *);
 static int jffs2_unlink (struct inode *,struct dentry *);
-static int jffs2_symlink (struct inode *,struct dentry *,const char *);
-static int jffs2_mkdir (struct inode *,struct dentry *,umode_t);
+static int jffs2_symlink (struct user_namespace *, struct inode *,
+			  struct dentry *, const char *);
+static int jffs2_mkdir (struct user_namespace *, struct inode *,struct dentry *,umode_t);
 static int jffs2_rmdir (struct inode *,struct dentry *);
-static int jffs2_mknod (struct inode *,struct dentry *,umode_t,dev_t);
-static int jffs2_rename (struct inode *, struct dentry *,
+static int jffs2_mknod (struct user_namespace *, struct inode *,struct dentry *,umode_t,dev_t);
+static int jffs2_rename (struct user_namespace *, struct inode *, struct dentry *,
 			 struct inode *, struct dentry *,
 			 unsigned int);
 
@@ -157,8 +158,8 @@ static int jffs2_readdir(struct file *file, struct dir_context *ctx)
 /***********************************************************************/
 
 
-static int jffs2_create(struct inode *dir_i, struct dentry *dentry,
-			umode_t mode, bool excl)
+static int jffs2_create(struct user_namespace *mnt_userns, struct inode *dir_i,
+			struct dentry *dentry, umode_t mode, bool excl)
 {
 	struct jffs2_raw_inode *ri;
 	struct jffs2_inode_info *f, *dir_f;
@@ -276,7 +277,8 @@ static int jffs2_link (struct dentry *old_dentry, struct inode *dir_i, struct de
 
 /***********************************************************************/
 
-static int jffs2_symlink (struct inode *dir_i, struct dentry *dentry, const char *target)
+static int jffs2_symlink (struct user_namespace *mnt_userns, struct inode *dir_i,
+			  struct dentry *dentry, const char *target)
 {
 	struct jffs2_inode_info *f, *dir_f;
 	struct jffs2_sb_info *c;
@@ -438,7 +440,8 @@ static int jffs2_symlink (struct inode *dir_i, struct dentry *dentry, const char
 }
 
 
-static int jffs2_mkdir (struct inode *dir_i, struct dentry *dentry, umode_t mode)
+static int jffs2_mkdir (struct user_namespace *mnt_userns, struct inode *dir_i,
+		        struct dentry *dentry, umode_t mode)
 {
 	struct jffs2_inode_info *f, *dir_f;
 	struct jffs2_sb_info *c;
@@ -609,7 +612,8 @@ static int jffs2_rmdir (struct inode *dir_i, struct dentry *dentry)
 	return ret;
 }
 
-static int jffs2_mknod (struct inode *dir_i, struct dentry *dentry, umode_t mode, dev_t rdev)
+static int jffs2_mknod (struct user_namespace *mnt_userns, struct inode *dir_i,
+		        struct dentry *dentry, umode_t mode, dev_t rdev)
 {
 	struct jffs2_inode_info *f, *dir_f;
 	struct jffs2_sb_info *c;
@@ -756,9 +760,9 @@ static int jffs2_mknod (struct inode *dir_i, struct dentry *dentry, umode_t mode
 	return ret;
 }
 
-static int jffs2_rename (struct inode *old_dir_i, struct dentry *old_dentry,
-			 struct inode *new_dir_i, struct dentry *new_dentry,
-			 unsigned int flags)
+static int jffs2_rename (struct user_namespace *mnt_userns, struct inode *old_dir_i,
+		         struct dentry *old_dentry, struct inode *new_dir_i,
+		         struct dentry *new_dentry, unsigned int flags)
 {
 	int ret;
 	struct jffs2_sb_info *c = JFFS2_SB_INFO(old_dir_i->i_sb);
diff --git a/fs/jffs2/fs.c b/fs/jffs2/fs.c
index ee9f51bab4c6..2ac410477c4f 100644
--- a/fs/jffs2/fs.c
+++ b/fs/jffs2/fs.c
@@ -190,7 +190,8 @@ int jffs2_do_setattr (struct inode *inode, struct iattr *iattr)
 	return 0;
 }
 
-int jffs2_setattr(struct dentry *dentry, struct iattr *iattr)
+int jffs2_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
+		  struct iattr *iattr)
 {
 	struct inode *inode = d_inode(dentry);
 	int rc;
diff --git a/fs/jffs2/os-linux.h b/fs/jffs2/os-linux.h
index ef1cfa61549e..173eccac691d 100644
--- a/fs/jffs2/os-linux.h
+++ b/fs/jffs2/os-linux.h
@@ -164,7 +164,7 @@ long jffs2_ioctl(struct file *, unsigned int, unsigned long);
 extern const struct inode_operations jffs2_symlink_inode_operations;
 
 /* fs.c */
-int jffs2_setattr (struct dentry *, struct iattr *);
+int jffs2_setattr (struct user_namespace *, struct dentry *, struct iattr *);
 int jffs2_do_setattr (struct inode *, struct iattr *);
 struct inode *jffs2_iget(struct super_block *, unsigned long);
 void jffs2_evict_inode (struct inode *);
diff --git a/fs/jfs/acl.c b/fs/jfs/acl.c
index cf79a34bfada..43c285c3d2a7 100644
--- a/fs/jfs/acl.c
+++ b/fs/jfs/acl.c
@@ -91,7 +91,8 @@ static int __jfs_set_acl(tid_t tid, struct inode *inode, int type,
 	return rc;
 }
 
-int jfs_set_acl(struct inode *inode, struct posix_acl *acl, int type)
+int jfs_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
+		struct posix_acl *acl, int type)
 {
 	int rc;
 	tid_t tid;
diff --git a/fs/jfs/file.c b/fs/jfs/file.c
index 61c3b0c1fbf6..28b70e7c7dd4 100644
--- a/fs/jfs/file.c
+++ b/fs/jfs/file.c
@@ -85,7 +85,8 @@ static int jfs_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
-int jfs_setattr(struct dentry *dentry, struct iattr *iattr)
+int jfs_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
+		struct iattr *iattr)
 {
 	struct inode *inode = d_inode(dentry);
 	int rc;
diff --git a/fs/jfs/jfs_acl.h b/fs/jfs/jfs_acl.h
index 9f8f92dd6f84..7ae389a7a366 100644
--- a/fs/jfs/jfs_acl.h
+++ b/fs/jfs/jfs_acl.h
@@ -8,7 +8,8 @@
 #ifdef CONFIG_JFS_POSIX_ACL
 
 struct posix_acl *jfs_get_acl(struct inode *inode, int type);
-int jfs_set_acl(struct inode *inode, struct posix_acl *acl, int type);
+int jfs_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
+		struct posix_acl *acl, int type);
 int jfs_init_acl(tid_t, struct inode *, struct inode *);
 
 #else
diff --git a/fs/jfs/jfs_inode.h b/fs/jfs/jfs_inode.h
index 70a0d12e427e..01daa0cb0ae5 100644
--- a/fs/jfs/jfs_inode.h
+++ b/fs/jfs/jfs_inode.h
@@ -26,7 +26,7 @@ extern struct dentry *jfs_fh_to_parent(struct super_block *sb, struct fid *fid,
 	int fh_len, int fh_type);
 extern void jfs_set_inode_flags(struct inode *);
 extern int jfs_get_block(struct inode *, sector_t, struct buffer_head *, int);
-extern int jfs_setattr(struct dentry *, struct iattr *);
+extern int jfs_setattr(struct user_namespace *, struct dentry *, struct iattr *);
 
 extern const struct address_space_operations jfs_aops;
 extern const struct inode_operations jfs_dir_inode_operations;
diff --git a/fs/jfs/namei.c b/fs/jfs/namei.c
index 7a55d14cc1af..9abed0d750e5 100644
--- a/fs/jfs/namei.c
+++ b/fs/jfs/namei.c
@@ -59,8 +59,8 @@ static inline void free_ea_wmap(struct inode *inode)
  * RETURN:	Errors from subroutines
  *
  */
-static int jfs_create(struct inode *dip, struct dentry *dentry, umode_t mode,
-		bool excl)
+static int jfs_create(struct user_namespace *mnt_userns, struct inode *dip,
+		      struct dentry *dentry, umode_t mode, bool excl)
 {
 	int rc = 0;
 	tid_t tid;		/* transaction id */
@@ -192,7 +192,8 @@ static int jfs_create(struct inode *dip, struct dentry *dentry, umode_t mode,
  * note:
  * EACCES: user needs search+write permission on the parent directory
  */
-static int jfs_mkdir(struct inode *dip, struct dentry *dentry, umode_t mode)
+static int jfs_mkdir(struct user_namespace *mnt_userns, struct inode *dip,
+		     struct dentry *dentry, umode_t mode)
 {
 	int rc = 0;
 	tid_t tid;		/* transaction id */
@@ -868,8 +869,8 @@ static int jfs_link(struct dentry *old_dentry,
  * an intermediate result whose length exceeds PATH_MAX [XPG4.2]
 */
 
-static int jfs_symlink(struct inode *dip, struct dentry *dentry,
-		const char *name)
+static int jfs_symlink(struct user_namespace *mnt_userns, struct inode *dip,
+		       struct dentry *dentry, const char *name)
 {
 	int rc;
 	tid_t tid;
@@ -1058,9 +1059,9 @@ static int jfs_symlink(struct inode *dip, struct dentry *dentry,
  *
  * FUNCTION:	rename a file or directory
  */
-static int jfs_rename(struct inode *old_dir, struct dentry *old_dentry,
-		      struct inode *new_dir, struct dentry *new_dentry,
-		      unsigned int flags)
+static int jfs_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
+		      struct dentry *old_dentry, struct inode *new_dir,
+		      struct dentry *new_dentry, unsigned int flags)
 {
 	struct btstack btstack;
 	ino_t ino;
@@ -1344,8 +1345,8 @@ static int jfs_rename(struct inode *old_dir, struct dentry *old_dentry,
  *
  * FUNCTION:	Create a special file (device)
  */
-static int jfs_mknod(struct inode *dir, struct dentry *dentry,
-		umode_t mode, dev_t rdev)
+static int jfs_mknod(struct user_namespace *mnt_userns, struct inode *dir,
+		     struct dentry *dentry, umode_t mode, dev_t rdev)
 {
 	struct jfs_inode_info *jfs_ip;
 	struct btstack btstack;
diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 9aec80b9d7c6..1c0cf0d48ccb 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -1111,8 +1111,8 @@ static struct dentry *kernfs_iop_lookup(struct inode *dir,
 	return ret;
 }
 
-static int kernfs_iop_mkdir(struct inode *dir, struct dentry *dentry,
-			    umode_t mode)
+static int kernfs_iop_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
+			    struct dentry *dentry, umode_t mode)
 {
 	struct kernfs_node *parent = dir->i_private;
 	struct kernfs_syscall_ops *scops = kernfs_root(parent)->syscall_ops;
@@ -1148,7 +1148,8 @@ static int kernfs_iop_rmdir(struct inode *dir, struct dentry *dentry)
 	return ret;
 }
 
-static int kernfs_iop_rename(struct inode *old_dir, struct dentry *old_dentry,
+static int kernfs_iop_rename(struct user_namespace *mnt_userns,
+			     struct inode *old_dir, struct dentry *old_dentry,
 			     struct inode *new_dir, struct dentry *new_dentry,
 			     unsigned int flags)
 {
diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
index 032d3d7546d8..d73950fc3d57 100644
--- a/fs/kernfs/inode.c
+++ b/fs/kernfs/inode.c
@@ -112,7 +112,8 @@ int kernfs_setattr(struct kernfs_node *kn, const struct iattr *iattr)
 	return ret;
 }
 
-int kernfs_iop_setattr(struct dentry *dentry, struct iattr *iattr)
+int kernfs_iop_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
+		       struct iattr *iattr)
 {
 	struct inode *inode = d_inode(dentry);
 	struct kernfs_node *kn = inode->i_private;
@@ -183,7 +184,8 @@ static void kernfs_refresh_inode(struct kernfs_node *kn, struct inode *inode)
 		set_nlink(inode, kn->dir.subdirs + 2);
 }
 
-int kernfs_iop_getattr(const struct path *path, struct kstat *stat,
+int kernfs_iop_getattr(struct user_namespace *mnt_userns,
+		       const struct path *path, struct kstat *stat,
 		       u32 request_mask, unsigned int query_flags)
 {
 	struct inode *inode = d_inode(path->dentry);
@@ -272,7 +274,8 @@ void kernfs_evict_inode(struct inode *inode)
 	kernfs_put(kn);
 }
 
-int kernfs_iop_permission(struct inode *inode, int mask)
+int kernfs_iop_permission(struct user_namespace *mnt_userns,
+			  struct inode *inode, int mask)
 {
 	struct kernfs_node *kn;
 
diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
index 7ee97ef59184..ccc3b44f6306 100644
--- a/fs/kernfs/kernfs-internal.h
+++ b/fs/kernfs/kernfs-internal.h
@@ -89,9 +89,12 @@ extern struct kmem_cache *kernfs_node_cache, *kernfs_iattrs_cache;
  */
 extern const struct xattr_handler *kernfs_xattr_handlers[];
 void kernfs_evict_inode(struct inode *inode);
-int kernfs_iop_permission(struct inode *inode, int mask);
-int kernfs_iop_setattr(struct dentry *dentry, struct iattr *iattr);
-int kernfs_iop_getattr(const struct path *path, struct kstat *stat,
+int kernfs_iop_permission(struct user_namespace *mnt_userns,
+			  struct inode *inode, int mask);
+int kernfs_iop_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
+		       struct iattr *iattr);
+int kernfs_iop_getattr(struct user_namespace *mnt_userns,
+		       const struct path *path, struct kstat *stat,
 		       u32 request_mask, unsigned int query_flags);
 ssize_t kernfs_iop_listxattr(struct dentry *dentry, char *buf, size_t size);
 int __kernfs_setattr(struct kernfs_node *kn, const struct iattr *iattr);
diff --git a/fs/libfs.c b/fs/libfs.c
index ea9d53d68ca5..c143b2d017dd 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -27,8 +27,9 @@
 
 #include "internal.h"
 
-int simple_getattr(const struct path *path, struct kstat *stat,
-		   u32 request_mask, unsigned int query_flags)
+int simple_getattr(struct user_namespace *mnt_userns, const struct path *path,
+		   struct kstat *stat, u32 request_mask,
+		   unsigned int query_flags)
 {
 	struct inode *inode = d_inode(path->dentry);
 	generic_fillattr(&init_user_ns, inode, stat);
@@ -447,9 +448,9 @@ int simple_rmdir(struct inode *dir, struct dentry *dentry)
 }
 EXPORT_SYMBOL(simple_rmdir);
 
-int simple_rename(struct inode *old_dir, struct dentry *old_dentry,
-		  struct inode *new_dir, struct dentry *new_dentry,
-		  unsigned int flags)
+int simple_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
+		  struct dentry *old_dentry, struct inode *new_dir,
+		  struct dentry *new_dentry, unsigned int flags)
 {
 	struct inode *inode = d_inode(old_dentry);
 	int they_are_dirs = d_is_dir(old_dentry);
@@ -492,18 +493,19 @@ EXPORT_SYMBOL(simple_rename);
  * on simple regular filesystems.  Anything that needs to change on-disk
  * or wire state on size changes needs its own setattr method.
  */
-int simple_setattr(struct dentry *dentry, struct iattr *iattr)
+int simple_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
+		   struct iattr *iattr)
 {
 	struct inode *inode = d_inode(dentry);
 	int error;
 
-	error = setattr_prepare(&init_user_ns, dentry, iattr);
+	error = setattr_prepare(mnt_userns, dentry, iattr);
 	if (error)
 		return error;
 
 	if (iattr->ia_valid & ATTR_SIZE)
 		truncate_setsize(inode, iattr->ia_size);
-	setattr_copy(&init_user_ns, inode, iattr);
+	setattr_copy(mnt_userns, inode, iattr);
 	mark_inode_dirty(inode);
 	return 0;
 }
@@ -1300,7 +1302,8 @@ static struct dentry *empty_dir_lookup(struct inode *dir, struct dentry *dentry,
 	return ERR_PTR(-ENOENT);
 }
 
-static int empty_dir_getattr(const struct path *path, struct kstat *stat,
+static int empty_dir_getattr(struct user_namespace *mnt_userns,
+			     const struct path *path, struct kstat *stat,
 			     u32 request_mask, unsigned int query_flags)
 {
 	struct inode *inode = d_inode(path->dentry);
@@ -1308,7 +1311,8 @@ static int empty_dir_getattr(const struct path *path, struct kstat *stat,
 	return 0;
 }
 
-static int empty_dir_setattr(struct dentry *dentry, struct iattr *attr)
+static int empty_dir_setattr(struct user_namespace *mnt_userns,
+			     struct dentry *dentry, struct iattr *attr)
 {
 	return -EPERM;
 }
@@ -1318,14 +1322,9 @@ static ssize_t empty_dir_listxattr(struct dentry *dentry, char *list, size_t siz
 	return -EOPNOTSUPP;
 }
 
-static int empty_dir_permission(struct inode *inode, int mask)
-{
-	return generic_permission(&init_user_ns, inode, mask);
-}
-
 static const struct inode_operations empty_dir_inode_operations = {
 	.lookup		= empty_dir_lookup,
-	.permission	= empty_dir_permission,
+	.permission	= generic_permission,
 	.setattr	= empty_dir_setattr,
 	.getattr	= empty_dir_getattr,
 	.listxattr	= empty_dir_listxattr,
diff --git a/fs/minix/file.c b/fs/minix/file.c
index f07acd268577..6a7bd2d9eec0 100644
--- a/fs/minix/file.c
+++ b/fs/minix/file.c
@@ -22,7 +22,8 @@ const struct file_operations minix_file_operations = {
 	.splice_read	= generic_file_splice_read,
 };
 
-static int minix_setattr(struct dentry *dentry, struct iattr *attr)
+static int minix_setattr(struct user_namespace *mnt_userns,
+			 struct dentry *dentry, struct iattr *attr)
 {
 	struct inode *inode = d_inode(dentry);
 	int error;
diff --git a/fs/minix/inode.c b/fs/minix/inode.c
index 91c81d2fc90d..a532a99bbe81 100644
--- a/fs/minix/inode.c
+++ b/fs/minix/inode.c
@@ -652,8 +652,8 @@ static int minix_write_inode(struct inode *inode, struct writeback_control *wbc)
 	return err;
 }
 
-int minix_getattr(const struct path *path, struct kstat *stat,
-		  u32 request_mask, unsigned int flags)
+int minix_getattr(struct user_namespace *mnt_userns, const struct path *path,
+		  struct kstat *stat, u32 request_mask, unsigned int flags)
 {
 	struct super_block *sb = path->dentry->d_sb;
 	struct inode *inode = d_inode(path->dentry);
diff --git a/fs/minix/minix.h b/fs/minix/minix.h
index 168d45d3de73..202173368025 100644
--- a/fs/minix/minix.h
+++ b/fs/minix/minix.h
@@ -51,7 +51,8 @@ extern unsigned long minix_count_free_inodes(struct super_block *sb);
 extern int minix_new_block(struct inode * inode);
 extern void minix_free_block(struct inode *inode, unsigned long block);
 extern unsigned long minix_count_free_blocks(struct super_block *sb);
-extern int minix_getattr(const struct path *, struct kstat *, u32, unsigned int);
+extern int minix_getattr(struct user_namespace *, const struct path *,
+			 struct kstat *, u32, unsigned int);
 extern int minix_prepare_chunk(struct page *page, loff_t pos, unsigned len);
 
 extern void V1_minix_truncate(struct inode *);
diff --git a/fs/minix/namei.c b/fs/minix/namei.c
index 1a6084d2b02e..937fa5fae2b8 100644
--- a/fs/minix/namei.c
+++ b/fs/minix/namei.c
@@ -33,7 +33,8 @@ static struct dentry *minix_lookup(struct inode * dir, struct dentry *dentry, un
 	return d_splice_alias(inode, dentry);
 }
 
-static int minix_mknod(struct inode * dir, struct dentry *dentry, umode_t mode, dev_t rdev)
+static int minix_mknod(struct user_namespace *mnt_userns, struct inode *dir,
+		       struct dentry *dentry, umode_t mode, dev_t rdev)
 {
 	int error;
 	struct inode *inode;
@@ -51,7 +52,8 @@ static int minix_mknod(struct inode * dir, struct dentry *dentry, umode_t mode,
 	return error;
 }
 
-static int minix_tmpfile(struct inode *dir, struct dentry *dentry, umode_t mode)
+static int minix_tmpfile(struct user_namespace *mnt_userns, struct inode *dir,
+			 struct dentry *dentry, umode_t mode)
 {
 	int error;
 	struct inode *inode = minix_new_inode(dir, mode, &error);
@@ -63,14 +65,14 @@ static int minix_tmpfile(struct inode *dir, struct dentry *dentry, umode_t mode)
 	return error;
 }
 
-static int minix_create(struct inode *dir, struct dentry *dentry, umode_t mode,
-		bool excl)
+static int minix_create(struct user_namespace *mnt_userns, struct inode *dir,
+			struct dentry *dentry, umode_t mode, bool excl)
 {
-	return minix_mknod(dir, dentry, mode, 0);
+	return minix_mknod(mnt_userns, dir, dentry, mode, 0);
 }
 
-static int minix_symlink(struct inode * dir, struct dentry *dentry,
-	  const char * symname)
+static int minix_symlink(struct user_namespace *mnt_userns, struct inode *dir,
+			 struct dentry *dentry, const char *symname)
 {
 	int err = -ENAMETOOLONG;
 	int i = strlen(symname)+1;
@@ -109,7 +111,8 @@ static int minix_link(struct dentry * old_dentry, struct inode * dir,
 	return add_nondir(dentry, inode);
 }
 
-static int minix_mkdir(struct inode * dir, struct dentry *dentry, umode_t mode)
+static int minix_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
+		       struct dentry *dentry, umode_t mode)
 {
 	struct inode * inode;
 	int err;
@@ -181,8 +184,9 @@ static int minix_rmdir(struct inode * dir, struct dentry *dentry)
 	return err;
 }
 
-static int minix_rename(struct inode * old_dir, struct dentry *old_dentry,
-			struct inode * new_dir, struct dentry *new_dentry,
+static int minix_rename(struct user_namespace *mnt_userns,
+			struct inode *old_dir, struct dentry *old_dentry,
+			struct inode *new_dir, struct dentry *new_dentry,
 			unsigned int flags)
 {
 	struct inode * old_inode = d_inode(old_dentry);
diff --git a/fs/namei.c b/fs/namei.c
index a2c4ecd26966..5c31eafce18c 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -441,7 +441,7 @@ static inline int do_inode_permission(struct user_namespace *mnt_userns,
 {
 	if (unlikely(!(inode->i_opflags & IOP_FASTPERM))) {
 		if (likely(inode->i_op->permission))
-			return inode->i_op->permission(inode, mask);
+			return inode->i_op->permission(mnt_userns, inode, mask);
 
 		/* This gets set once for the inode lifetime */
 		spin_lock(&inode->i_lock);
@@ -2195,11 +2195,13 @@ static int link_path_walk(const char *name, struct nameidata *nd)
 
 	/* At this point we know we have a real path component. */
 	for(;;) {
+		struct user_namespace *mnt_userns;
 		const char *link;
 		u64 hash_len;
 		int type;
 
-		err = may_lookup(&init_user_ns, nd);
+		mnt_userns = mnt_user_ns(nd->path.mnt);
+		err = may_lookup(mnt_userns, nd);
 		if (err)
 			return err;
 
@@ -2247,7 +2249,7 @@ static int link_path_walk(const char *name, struct nameidata *nd)
 OK:
 			/* pathname or trailing symlink, done */
 			if (!depth) {
-				nd->dir_uid = i_uid_into_mnt(&init_user_ns, nd->inode);
+				nd->dir_uid = i_uid_into_mnt(mnt_userns, nd->inode);
 				nd->dir_mode = nd->inode->i_mode;
 				nd->flags &= ~LOOKUP_PARENT;
 				return 0;
@@ -2900,7 +2902,7 @@ int vfs_create(struct user_namespace *mnt_userns, struct inode *dir,
 	error = security_inode_create(dir, dentry, mode);
 	if (error)
 		return error;
-	error = dir->i_op->create(dir, dentry, mode, want_excl);
+	error = dir->i_op->create(mnt_userns, dir, dentry, mode, want_excl);
 	if (!error)
 		fsnotify_create(dir, dentry);
 	return error;
@@ -2991,7 +2993,7 @@ static int may_open(struct user_namespace *mnt_userns, const struct path *path,
 	return 0;
 }
 
-static int handle_truncate(struct file *filp)
+static int handle_truncate(struct user_namespace *mnt_userns, struct file *filp)
 {
 	const struct path *path = &filp->f_path;
 	struct inode *inode = path->dentry->d_inode;
@@ -3005,8 +3007,7 @@ static int handle_truncate(struct file *filp)
 	if (!error)
 		error = security_path_truncate(path);
 	if (!error) {
-		error = do_truncate(mnt_user_ns(filp->f_path.mnt),
-				    path->dentry, 0,
+		error = do_truncate(mnt_userns, path->dentry, 0,
 				    ATTR_MTIME | ATTR_CTIME | ATTR_OPEN, filp);
 	}
 	put_write_access(inode);
@@ -3114,6 +3115,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 				  const struct open_flags *op,
 				  bool got_write)
 {
+	struct user_namespace *mnt_userns;
 	struct dentry *dir = nd->path.dentry;
 	struct inode *dir_inode = dir->d_inode;
 	int open_flag = op->open_flag;
@@ -3161,13 +3163,14 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 	 */
 	if (unlikely(!got_write))
 		open_flag &= ~O_TRUNC;
+	mnt_userns = mnt_user_ns(nd->path.mnt);
 	if (open_flag & O_CREAT) {
 		if (open_flag & O_EXCL)
 			open_flag &= ~O_TRUNC;
 		if (!IS_POSIXACL(dir->d_inode))
 			mode &= ~current_umask();
 		if (likely(got_write))
-			create_error = may_o_create(&init_user_ns, &nd->path,
+			create_error = may_o_create(mnt_userns, &nd->path,
 						    dentry, mode);
 		else
 			create_error = -EROFS;
@@ -3203,8 +3206,9 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 			error = -EACCES;
 			goto out_dput;
 		}
-		error = dir_inode->i_op->create(dir_inode, dentry, mode,
-						open_flag & O_EXCL);
+
+		error = dir_inode->i_op->create(mnt_userns, dir_inode, dentry,
+						mode, open_flag & O_EXCL);
 		if (error)
 			goto out_dput;
 	}
@@ -3312,6 +3316,7 @@ static const char *open_last_lookups(struct nameidata *nd,
 static int do_open(struct nameidata *nd,
 		   struct file *file, const struct open_flags *op)
 {
+	struct user_namespace *mnt_userns;
 	int open_flag = op->open_flag;
 	bool do_truncate;
 	int acc_mode;
@@ -3324,12 +3329,13 @@ static int do_open(struct nameidata *nd,
 	}
 	if (!(file->f_mode & FMODE_CREATED))
 		audit_inode(nd->name, nd->path.dentry, 0);
+	mnt_userns = mnt_user_ns(nd->path.mnt);
 	if (open_flag & O_CREAT) {
 		if ((open_flag & O_EXCL) && !(file->f_mode & FMODE_CREATED))
 			return -EEXIST;
 		if (d_is_dir(nd->path.dentry))
 			return -EISDIR;
-		error = may_create_in_sticky(&init_user_ns, nd,
+		error = may_create_in_sticky(mnt_userns, nd,
 					     d_backing_inode(nd->path.dentry));
 		if (unlikely(error))
 			return error;
@@ -3349,13 +3355,13 @@ static int do_open(struct nameidata *nd,
 			return error;
 		do_truncate = true;
 	}
-	error = may_open(&init_user_ns, &nd->path, acc_mode, open_flag);
+	error = may_open(mnt_userns, &nd->path, acc_mode, open_flag);
 	if (!error && !(file->f_mode & FMODE_OPENED))
 		error = vfs_open(&nd->path, file);
 	if (!error)
 		error = ima_file_check(file, op->acc_mode);
 	if (!error && do_truncate)
-		error = handle_truncate(file);
+		error = handle_truncate(mnt_userns, file);
 	if (unlikely(error > 0)) {
 		WARN_ON(1);
 		error = -EINVAL;
@@ -3399,7 +3405,7 @@ struct dentry *vfs_tmpfile(struct user_namespace *mnt_userns,
 	child = d_alloc(dentry, &slash_name);
 	if (unlikely(!child))
 		goto out_err;
-	error = dir->i_op->tmpfile(dir, child, mode);
+	error = dir->i_op->tmpfile(mnt_userns, dir, child, mode);
 	if (error)
 		goto out_err;
 	error = -ENOENT;
@@ -3442,7 +3448,7 @@ static int do_tmpfile(struct nameidata *nd, unsigned flags,
 	path.dentry = child;
 	audit_inode(nd->name, child, 0);
 	/* Don't check for other permissions, the inode was just created */
-	error = may_open(&init_user_ns, &path, 0, op->open_flag);
+	error = may_open(mnt_userns, &path, 0, op->open_flag);
 	if (error)
 		goto out2;
 	file->f_path.mnt = path.mnt;
@@ -3686,7 +3692,7 @@ int vfs_mknod(struct user_namespace *mnt_userns, struct inode *dir,
 	if (error)
 		return error;
 
-	error = dir->i_op->mknod(dir, dentry, mode, dev);
+	error = dir->i_op->mknod(mnt_userns, dir, dentry, mode, dev);
 	if (!error)
 		fsnotify_create(dir, dentry);
 	return error;
@@ -3805,7 +3811,7 @@ int vfs_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
 	if (max_links && dir->i_nlink >= max_links)
 		return -EMLINK;
 
-	error = dir->i_op->mkdir(dir, dentry, mode);
+	error = dir->i_op->mkdir(mnt_userns, dir, dentry, mode);
 	if (!error)
 		fsnotify_mkdir(dir, dentry);
 	return error;
@@ -4162,7 +4168,7 @@ int vfs_symlink(struct user_namespace *mnt_userns, struct inode *dir,
 	if (error)
 		return error;
 
-	error = dir->i_op->symlink(dir, dentry, oldname);
+	error = dir->i_op->symlink(mnt_userns, dir, dentry, oldname);
 	if (!error)
 		fsnotify_create(dir, dentry);
 	return error;
@@ -4353,13 +4359,13 @@ static int do_linkat(int olddfd, const char __user *oldname, int newdfd,
 	error = -EXDEV;
 	if (old_path.mnt != new_path.mnt)
 		goto out_dput;
-	error = may_linkat(&init_user_ns, &old_path);
+	mnt_userns = mnt_user_ns(new_path.mnt);
+	error = may_linkat(mnt_userns, &old_path);
 	if (unlikely(error))
 		goto out_dput;
 	error = security_path_link(old_path.dentry, &new_path, new_dentry);
 	if (error)
 		goto out_dput;
-	mnt_userns = mnt_user_ns(new_path.mnt);
 	error = vfs_link(old_path.dentry, mnt_userns, new_path.dentry->d_inode,
 			 new_dentry, &delegated_inode);
 out_dput:
@@ -4448,7 +4454,6 @@ SYSCALL_DEFINE2(link, const char __user *, oldname, const char __user *, newname
 int vfs_rename(struct renamedata *rd)
 {
 	int error;
-	struct user_namespace *mnt_userns = &init_user_ns;
 	struct inode *old_dir = rd->old_dir, *new_dir = rd->new_dir;
 	struct dentry *old_dentry = rd->old_dentry;
 	struct dentry *new_dentry = rd->new_dentry;
@@ -4535,8 +4540,8 @@ int vfs_rename(struct renamedata *rd)
 		if (error)
 			goto out;
 	}
-	error = old_dir->i_op->rename(old_dir, old_dentry,
-				       new_dir, new_dentry, flags);
+	error = old_dir->i_op->rename(rd->new_mnt_userns, old_dir, old_dentry,
+				      new_dir, new_dentry, flags);
 	if (error)
 		goto out;
 
diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 170ecc575519..fb79efe722d3 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -1896,8 +1896,8 @@ EXPORT_SYMBOL_GPL(nfs_instantiate);
  * that the operation succeeded on the server, but an error in the
  * reply path made it appear to have failed.
  */
-int nfs_create(struct inode *dir, struct dentry *dentry,
-		umode_t mode, bool excl)
+int nfs_create(struct user_namespace *mnt_userns, struct inode *dir,
+	       struct dentry *dentry, umode_t mode, bool excl)
 {
 	struct iattr attr;
 	int open_flags = excl ? O_CREAT | O_EXCL : O_CREAT;
@@ -1925,7 +1925,8 @@ EXPORT_SYMBOL_GPL(nfs_create);
  * See comments for nfs_proc_create regarding failed operations.
  */
 int
-nfs_mknod(struct inode *dir, struct dentry *dentry, umode_t mode, dev_t rdev)
+nfs_mknod(struct user_namespace *mnt_userns, struct inode *dir,
+	  struct dentry *dentry, umode_t mode, dev_t rdev)
 {
 	struct iattr attr;
 	int status;
@@ -1951,7 +1952,8 @@ EXPORT_SYMBOL_GPL(nfs_mknod);
 /*
  * See comments for nfs_proc_create regarding failed operations.
  */
-int nfs_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
+int nfs_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
+	      struct dentry *dentry, umode_t mode)
 {
 	struct iattr attr;
 	int error;
@@ -2096,7 +2098,8 @@ EXPORT_SYMBOL_GPL(nfs_unlink);
  * now have a new file handle and can instantiate an in-core NFS inode
  * and move the raw page into its mapping.
  */
-int nfs_symlink(struct inode *dir, struct dentry *dentry, const char *symname)
+int nfs_symlink(struct user_namespace *mnt_userns, struct inode *dir,
+		struct dentry *dentry, const char *symname)
 {
 	struct page *page;
 	char *kaddr;
@@ -2199,9 +2202,9 @@ EXPORT_SYMBOL_GPL(nfs_link);
  * If these conditions are met, we can drop the dentries before doing
  * the rename.
  */
-int nfs_rename(struct inode *old_dir, struct dentry *old_dentry,
-	       struct inode *new_dir, struct dentry *new_dentry,
-	       unsigned int flags)
+int nfs_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
+	       struct dentry *old_dentry, struct inode *new_dir,
+	       struct dentry *new_dentry, unsigned int flags)
 {
 	struct inode *old_inode = d_inode(old_dentry);
 	struct inode *new_inode = d_inode(new_dentry);
@@ -2740,7 +2743,9 @@ static int nfs_execute_ok(struct inode *inode, int mask)
 	return ret;
 }
 
-int nfs_permission(struct inode *inode, int mask)
+int nfs_permission(struct user_namespace *mnt_userns,
+		   struct inode *inode,
+		   int mask)
 {
 	const struct cred *cred = current_cred();
 	int res = 0;
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 8d74974d7992..b38d052954f6 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -595,7 +595,8 @@ EXPORT_SYMBOL_GPL(nfs_fhget);
 #define NFS_VALID_ATTRS (ATTR_MODE|ATTR_UID|ATTR_GID|ATTR_SIZE|ATTR_ATIME|ATTR_ATIME_SET|ATTR_MTIME|ATTR_MTIME_SET|ATTR_FILE|ATTR_OPEN)
 
 int
-nfs_setattr(struct dentry *dentry, struct iattr *attr)
+nfs_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
+	    struct iattr *attr)
 {
 	struct inode *inode = d_inode(dentry);
 	struct nfs_fattr *fattr;
@@ -788,8 +789,8 @@ static bool nfs_need_revalidate_inode(struct inode *inode)
 	return false;
 }
 
-int nfs_getattr(const struct path *path, struct kstat *stat,
-		u32 request_mask, unsigned int query_flags)
+int nfs_getattr(struct user_namespace *mnt_userns, const struct path *path,
+		struct kstat *stat, u32 request_mask, unsigned int query_flags)
 {
 	struct inode *inode = d_inode(path->dentry);
 	struct nfs_server *server = NFS_SERVER(inode);
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 6673a77884d9..9db2fbe8c9b0 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -364,14 +364,14 @@ extern unsigned long nfs_access_cache_count(struct shrinker *shrink,
 extern unsigned long nfs_access_cache_scan(struct shrinker *shrink,
 					   struct shrink_control *sc);
 struct dentry *nfs_lookup(struct inode *, struct dentry *, unsigned int);
-int nfs_create(struct inode *, struct dentry *, umode_t, bool);
-int nfs_mkdir(struct inode *, struct dentry *, umode_t);
+int nfs_create(struct user_namespace *, struct inode *, struct dentry *, umode_t, bool);
+int nfs_mkdir(struct user_namespace *, struct inode *, struct dentry *, umode_t);
 int nfs_rmdir(struct inode *, struct dentry *);
 int nfs_unlink(struct inode *, struct dentry *);
-int nfs_symlink(struct inode *, struct dentry *, const char *);
+int nfs_symlink(struct user_namespace *, struct inode *, struct dentry *, const char *);
 int nfs_link(struct dentry *, struct inode *, struct dentry *);
-int nfs_mknod(struct inode *, struct dentry *, umode_t, dev_t);
-int nfs_rename(struct inode *, struct dentry *,
+int nfs_mknod(struct user_namespace *, struct inode *, struct dentry *, umode_t, dev_t);
+int nfs_rename(struct user_namespace *, struct inode *, struct dentry *,
 	       struct inode *, struct dentry *, unsigned int);
 
 /* file.c */
diff --git a/fs/nfs/namespace.c b/fs/nfs/namespace.c
index 55fc711e368b..a4bd6e1c3825 100644
--- a/fs/nfs/namespace.c
+++ b/fs/nfs/namespace.c
@@ -208,20 +208,22 @@ struct vfsmount *nfs_d_automount(struct path *path)
 }
 
 static int
-nfs_namespace_getattr(const struct path *path, struct kstat *stat,
-			u32 request_mask, unsigned int query_flags)
+nfs_namespace_getattr(struct user_namespace *mnt_userns,
+		      const struct path *path, struct kstat *stat,
+		      u32 request_mask, unsigned int query_flags)
 {
 	if (NFS_FH(d_inode(path->dentry))->size != 0)
-		return nfs_getattr(path, stat, request_mask, query_flags);
+		return nfs_getattr(mnt_userns, path, stat, request_mask, query_flags);
 	generic_fillattr(&init_user_ns, d_inode(path->dentry), stat);
 	return 0;
 }
 
 static int
-nfs_namespace_setattr(struct dentry *dentry, struct iattr *attr)
+nfs_namespace_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
+		      struct iattr *attr)
 {
 	if (NFS_FH(d_inode(dentry))->size != 0)
-		return nfs_setattr(dentry, attr);
+		return nfs_setattr(mnt_userns, dentry, attr);
 	return -EACCES;
 }
 
diff --git a/fs/nfs/nfs3_fs.h b/fs/nfs/nfs3_fs.h
index 1b950b66b3bb..c8a192802dda 100644
--- a/fs/nfs/nfs3_fs.h
+++ b/fs/nfs/nfs3_fs.h
@@ -12,7 +12,8 @@
  */
 #ifdef CONFIG_NFS_V3_ACL
 extern struct posix_acl *nfs3_get_acl(struct inode *inode, int type);
-extern int nfs3_set_acl(struct inode *inode, struct posix_acl *acl, int type);
+extern int nfs3_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
+			struct posix_acl *acl, int type);
 extern int nfs3_proc_setacls(struct inode *inode, struct posix_acl *acl,
 		struct posix_acl *dfacl);
 extern ssize_t nfs3_listxattr(struct dentry *, char *, size_t);
diff --git a/fs/nfs/nfs3acl.c b/fs/nfs/nfs3acl.c
index c6c863382f37..5604e807fc01 100644
--- a/fs/nfs/nfs3acl.c
+++ b/fs/nfs/nfs3acl.c
@@ -251,7 +251,8 @@ int nfs3_proc_setacls(struct inode *inode, struct posix_acl *acl,
 
 }
 
-int nfs3_set_acl(struct inode *inode, struct posix_acl *acl, int type)
+int nfs3_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
+		 struct posix_acl *acl, int type)
 {
 	struct posix_acl *orig = acl, *dfacl = NULL, *alloc;
 	int status;
diff --git a/fs/nilfs2/inode.c b/fs/nilfs2/inode.c
index 8aad3c48092a..29a560f76ffd 100644
--- a/fs/nilfs2/inode.c
+++ b/fs/nilfs2/inode.c
@@ -805,7 +805,8 @@ void nilfs_evict_inode(struct inode *inode)
 	 */
 }
 
-int nilfs_setattr(struct dentry *dentry, struct iattr *iattr)
+int nilfs_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
+		  struct iattr *iattr)
 {
 	struct nilfs_transaction_info ti;
 	struct inode *inode = d_inode(dentry);
@@ -843,7 +844,7 @@ int nilfs_setattr(struct dentry *dentry, struct iattr *iattr)
 	return err;
 }
 
-int nilfs_permission(struct inode *inode, int mask)
+int nilfs_permission(struct user_namespace *mnt_userns, struct inode *inode, int mask)
 {
 	struct nilfs_root *root = NILFS_I(inode)->i_root;
 
diff --git a/fs/nilfs2/namei.c b/fs/nilfs2/namei.c
index a6ec7961d4f5..ecace5f96a95 100644
--- a/fs/nilfs2/namei.c
+++ b/fs/nilfs2/namei.c
@@ -72,8 +72,8 @@ nilfs_lookup(struct inode *dir, struct dentry *dentry, unsigned int flags)
  * If the create succeeds, we fill in the inode information
  * with d_instantiate().
  */
-static int nilfs_create(struct inode *dir, struct dentry *dentry, umode_t mode,
-			bool excl)
+static int nilfs_create(struct user_namespace *mnt_userns, struct inode *dir,
+			struct dentry *dentry, umode_t mode, bool excl)
 {
 	struct inode *inode;
 	struct nilfs_transaction_info ti;
@@ -100,7 +100,8 @@ static int nilfs_create(struct inode *dir, struct dentry *dentry, umode_t mode,
 }
 
 static int
-nilfs_mknod(struct inode *dir, struct dentry *dentry, umode_t mode, dev_t rdev)
+nilfs_mknod(struct user_namespace *mnt_userns, struct inode *dir,
+	    struct dentry *dentry, umode_t mode, dev_t rdev)
 {
 	struct inode *inode;
 	struct nilfs_transaction_info ti;
@@ -124,8 +125,8 @@ nilfs_mknod(struct inode *dir, struct dentry *dentry, umode_t mode, dev_t rdev)
 	return err;
 }
 
-static int nilfs_symlink(struct inode *dir, struct dentry *dentry,
-			 const char *symname)
+static int nilfs_symlink(struct user_namespace *mnt_userns, struct inode *dir,
+			 struct dentry *dentry, const char *symname)
 {
 	struct nilfs_transaction_info ti;
 	struct super_block *sb = dir->i_sb;
@@ -201,7 +202,8 @@ static int nilfs_link(struct dentry *old_dentry, struct inode *dir,
 	return err;
 }
 
-static int nilfs_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
+static int nilfs_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
+		       struct dentry *dentry, umode_t mode)
 {
 	struct inode *inode;
 	struct nilfs_transaction_info ti;
@@ -338,8 +340,9 @@ static int nilfs_rmdir(struct inode *dir, struct dentry *dentry)
 	return err;
 }
 
-static int nilfs_rename(struct inode *old_dir, struct dentry *old_dentry,
-			struct inode *new_dir,	struct dentry *new_dentry,
+static int nilfs_rename(struct user_namespace *mnt_userns,
+			struct inode *old_dir, struct dentry *old_dentry,
+			struct inode *new_dir, struct dentry *new_dentry,
 			unsigned int flags)
 {
 	struct inode *old_inode = d_inode(old_dentry);
diff --git a/fs/nilfs2/nilfs.h b/fs/nilfs2/nilfs.h
index f8450ee3fd06..ade263d6dd7d 100644
--- a/fs/nilfs2/nilfs.h
+++ b/fs/nilfs2/nilfs.h
@@ -267,9 +267,9 @@ extern struct inode *nilfs_iget_for_gc(struct super_block *sb,
 extern void nilfs_update_inode(struct inode *, struct buffer_head *, int);
 extern void nilfs_truncate(struct inode *);
 extern void nilfs_evict_inode(struct inode *);
-extern int nilfs_setattr(struct dentry *, struct iattr *);
+extern int nilfs_setattr(struct user_namespace *, struct dentry *, struct iattr *);
 extern void nilfs_write_failed(struct address_space *mapping, loff_t to);
-int nilfs_permission(struct inode *inode, int mask);
+int nilfs_permission(struct user_namespace *mnt_userns, struct inode *inode, int mask);
 int nilfs_load_inode_block(struct inode *inode, struct buffer_head **pbh);
 extern int nilfs_inode_dirty(struct inode *);
 int nilfs_set_file_dirty(struct inode *inode, unsigned int nr_dirty);
diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
index 1f2ab03f4903..c0156421c6aa 100644
--- a/fs/ntfs/inode.c
+++ b/fs/ntfs/inode.c
@@ -2850,6 +2850,7 @@ void ntfs_truncate_vfs(struct inode *vi) {
 
 /**
  * ntfs_setattr - called from notify_change() when an attribute is being changed
+ * @mnt_userns:	user namespace of the mount the inode was found from
  * @dentry:	dentry whose attributes to change
  * @attr:	structure describing the attributes and the changes
  *
@@ -2862,7 +2863,8 @@ void ntfs_truncate_vfs(struct inode *vi) {
  *
  * Called with ->i_mutex held.
  */
-int ntfs_setattr(struct dentry *dentry, struct iattr *attr)
+int ntfs_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
+		 struct iattr *attr)
 {
 	struct inode *vi = d_inode(dentry);
 	int err;
diff --git a/fs/ntfs/inode.h b/fs/ntfs/inode.h
index 363e4e820673..6f78ee00f57f 100644
--- a/fs/ntfs/inode.h
+++ b/fs/ntfs/inode.h
@@ -289,7 +289,8 @@ extern int ntfs_show_options(struct seq_file *sf, struct dentry *root);
 extern int ntfs_truncate(struct inode *vi);
 extern void ntfs_truncate_vfs(struct inode *vi);
 
-extern int ntfs_setattr(struct dentry *dentry, struct iattr *attr);
+extern int ntfs_setattr(struct user_namespace *mnt_userns,
+			struct dentry *dentry, struct iattr *attr);
 
 extern int __ntfs_write_inode(struct inode *vi, int sync);
 
diff --git a/fs/ocfs2/acl.c b/fs/ocfs2/acl.c
index 7e64dbe93251..08b84e4c0b6c 100644
--- a/fs/ocfs2/acl.c
+++ b/fs/ocfs2/acl.c
@@ -262,7 +262,8 @@ static int ocfs2_set_acl(handle_t *handle,
 	return ret;
 }
 
-int ocfs2_iop_set_acl(struct inode *inode, struct posix_acl *acl, int type)
+int ocfs2_iop_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
+		      struct posix_acl *acl, int type)
 {
 	struct buffer_head *bh = NULL;
 	int status, had_lock;
diff --git a/fs/ocfs2/acl.h b/fs/ocfs2/acl.h
index 127b13432146..4e86450917b2 100644
--- a/fs/ocfs2/acl.h
+++ b/fs/ocfs2/acl.h
@@ -19,7 +19,8 @@ struct ocfs2_acl_entry {
 };
 
 struct posix_acl *ocfs2_iop_get_acl(struct inode *inode, int type);
-int ocfs2_iop_set_acl(struct inode *inode, struct posix_acl *acl, int type);
+int ocfs2_iop_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
+		      struct posix_acl *acl, int type);
 extern int ocfs2_acl_chmod(struct inode *, struct buffer_head *);
 extern int ocfs2_init_acl(handle_t *, struct inode *, struct inode *,
 			  struct buffer_head *, struct buffer_head *,
diff --git a/fs/ocfs2/dlmfs/dlmfs.c b/fs/ocfs2/dlmfs/dlmfs.c
index 9fa66cd1f622..b2870f1a31df 100644
--- a/fs/ocfs2/dlmfs/dlmfs.c
+++ b/fs/ocfs2/dlmfs/dlmfs.c
@@ -190,7 +190,8 @@ static int dlmfs_file_release(struct inode *inode,
  * We do ->setattr() just to override size changes.  Our size is the size
  * of the LVB and nothing else.
  */
-static int dlmfs_file_setattr(struct dentry *dentry, struct iattr *attr)
+static int dlmfs_file_setattr(struct user_namespace *mnt_userns,
+			      struct dentry *dentry, struct iattr *attr)
 {
 	int error;
 	struct inode *inode = d_inode(dentry);
@@ -395,7 +396,8 @@ static struct inode *dlmfs_get_inode(struct inode *parent,
  * File creation. Allocate an inode, and we're done..
  */
 /* SMP-safe */
-static int dlmfs_mkdir(struct inode * dir,
+static int dlmfs_mkdir(struct user_namespace * mnt_userns,
+		       struct inode * dir,
 		       struct dentry * dentry,
 		       umode_t mode)
 {
@@ -443,7 +445,8 @@ static int dlmfs_mkdir(struct inode * dir,
 	return status;
 }
 
-static int dlmfs_create(struct inode *dir,
+static int dlmfs_create(struct user_namespace *mnt_userns,
+			struct inode *dir,
 			struct dentry *dentry,
 			umode_t mode,
 			bool excl)
diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
index a070d4c9b6ed..24a9a5f9f8be 100644
--- a/fs/ocfs2/file.c
+++ b/fs/ocfs2/file.c
@@ -1112,7 +1112,8 @@ static int ocfs2_extend_file(struct inode *inode,
 	return ret;
 }
 
-int ocfs2_setattr(struct dentry *dentry, struct iattr *attr)
+int ocfs2_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
+		  struct iattr *attr)
 {
 	int status = 0, size_change;
 	int inode_locked = 0;
@@ -1298,8 +1299,8 @@ int ocfs2_setattr(struct dentry *dentry, struct iattr *attr)
 	return status;
 }
 
-int ocfs2_getattr(const struct path *path, struct kstat *stat,
-		  u32 request_mask, unsigned int flags)
+int ocfs2_getattr(struct user_namespace *mnt_userns, const struct path *path,
+		  struct kstat *stat, u32 request_mask, unsigned int flags)
 {
 	struct inode *inode = d_inode(path->dentry);
 	struct super_block *sb = path->dentry->d_sb;
@@ -1330,7 +1331,7 @@ int ocfs2_getattr(const struct path *path, struct kstat *stat,
 	return err;
 }
 
-int ocfs2_permission(struct inode *inode, int mask)
+int ocfs2_permission(struct user_namespace *mnt_userns, struct inode *inode, int mask)
 {
 	int ret, had_lock;
 	struct ocfs2_lock_holder oh;
diff --git a/fs/ocfs2/file.h b/fs/ocfs2/file.h
index 4832cbceba5b..8536cec5f122 100644
--- a/fs/ocfs2/file.h
+++ b/fs/ocfs2/file.h
@@ -51,10 +51,13 @@ int ocfs2_extend_no_holes(struct inode *inode, struct buffer_head *di_bh,
 			  u64 new_i_size, u64 zero_to);
 int ocfs2_zero_extend(struct inode *inode, struct buffer_head *di_bh,
 		      loff_t zero_to);
-int ocfs2_setattr(struct dentry *dentry, struct iattr *attr);
-int ocfs2_getattr(const struct path *path, struct kstat *stat,
-		  u32 request_mask, unsigned int flags);
-int ocfs2_permission(struct inode *inode, int mask);
+int ocfs2_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
+		  struct iattr *attr);
+int ocfs2_getattr(struct user_namespace *mnt_userns, const struct path *path,
+		  struct kstat *stat, u32 request_mask, unsigned int flags);
+int ocfs2_permission(struct user_namespace *mnt_userns,
+		     struct inode *inode,
+		     int mask);
 
 int ocfs2_should_update_atime(struct inode *inode,
 			      struct vfsmount *vfsmnt);
diff --git a/fs/ocfs2/namei.c b/fs/ocfs2/namei.c
index a4965133bd5e..a995414dccab 100644
--- a/fs/ocfs2/namei.c
+++ b/fs/ocfs2/namei.c
@@ -221,7 +221,8 @@ static void ocfs2_cleanup_add_entry_failure(struct ocfs2_super *osb,
 	iput(inode);
 }
 
-static int ocfs2_mknod(struct inode *dir,
+static int ocfs2_mknod(struct user_namespace *mnt_userns,
+		       struct inode *dir,
 		       struct dentry *dentry,
 		       umode_t mode,
 		       dev_t dev)
@@ -645,7 +646,8 @@ static int ocfs2_mknod_locked(struct ocfs2_super *osb,
 	return status;
 }
 
-static int ocfs2_mkdir(struct inode *dir,
+static int ocfs2_mkdir(struct user_namespace *mnt_userns,
+		       struct inode *dir,
 		       struct dentry *dentry,
 		       umode_t mode)
 {
@@ -653,14 +655,15 @@ static int ocfs2_mkdir(struct inode *dir,
 
 	trace_ocfs2_mkdir(dir, dentry, dentry->d_name.len, dentry->d_name.name,
 			  OCFS2_I(dir)->ip_blkno, mode);
-	ret = ocfs2_mknod(dir, dentry, mode | S_IFDIR, 0);
+	ret = ocfs2_mknod(&init_user_ns, dir, dentry, mode | S_IFDIR, 0);
 	if (ret)
 		mlog_errno(ret);
 
 	return ret;
 }
 
-static int ocfs2_create(struct inode *dir,
+static int ocfs2_create(struct user_namespace *mnt_userns,
+			struct inode *dir,
 			struct dentry *dentry,
 			umode_t mode,
 			bool excl)
@@ -669,7 +672,7 @@ static int ocfs2_create(struct inode *dir,
 
 	trace_ocfs2_create(dir, dentry, dentry->d_name.len, dentry->d_name.name,
 			   (unsigned long long)OCFS2_I(dir)->ip_blkno, mode);
-	ret = ocfs2_mknod(dir, dentry, mode | S_IFREG, 0);
+	ret = ocfs2_mknod(&init_user_ns, dir, dentry, mode | S_IFREG, 0);
 	if (ret)
 		mlog_errno(ret);
 
@@ -1195,7 +1198,8 @@ static void ocfs2_double_unlock(struct inode *inode1, struct inode *inode2)
 		ocfs2_inode_unlock(inode2, 1);
 }
 
-static int ocfs2_rename(struct inode *old_dir,
+static int ocfs2_rename(struct user_namespace *mnt_userns,
+			struct inode *old_dir,
 			struct dentry *old_dentry,
 			struct inode *new_dir,
 			struct dentry *new_dentry,
@@ -1784,7 +1788,8 @@ static int ocfs2_create_symlink_data(struct ocfs2_super *osb,
 	return status;
 }
 
-static int ocfs2_symlink(struct inode *dir,
+static int ocfs2_symlink(struct user_namespace *mnt_userns,
+			 struct inode *dir,
 			 struct dentry *dentry,
 			 const char *symname)
 {
diff --git a/fs/omfs/dir.c b/fs/omfs/dir.c
index a0f45651f3b7..c219f91f44e9 100644
--- a/fs/omfs/dir.c
+++ b/fs/omfs/dir.c
@@ -279,13 +279,14 @@ static int omfs_add_node(struct inode *dir, struct dentry *dentry, umode_t mode)
 	return err;
 }
 
-static int omfs_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
+static int omfs_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
+		      struct dentry *dentry, umode_t mode)
 {
 	return omfs_add_node(dir, dentry, mode | S_IFDIR);
 }
 
-static int omfs_create(struct inode *dir, struct dentry *dentry, umode_t mode,
-		bool excl)
+static int omfs_create(struct user_namespace *mnt_userns, struct inode *dir,
+		       struct dentry *dentry, umode_t mode, bool excl)
 {
 	return omfs_add_node(dir, dentry, mode | S_IFREG);
 }
@@ -369,9 +370,9 @@ static bool omfs_fill_chain(struct inode *dir, struct dir_context *ctx,
 	return true;
 }
 
-static int omfs_rename(struct inode *old_dir, struct dentry *old_dentry,
-		       struct inode *new_dir, struct dentry *new_dentry,
-		       unsigned int flags)
+static int omfs_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
+		       struct dentry *old_dentry, struct inode *new_dir,
+		       struct dentry *new_dentry, unsigned int flags)
 {
 	struct inode *new_inode = d_inode(new_dentry);
 	struct inode *old_inode = d_inode(old_dentry);
diff --git a/fs/omfs/file.c b/fs/omfs/file.c
index 729339cd7902..11e733aab25d 100644
--- a/fs/omfs/file.c
+++ b/fs/omfs/file.c
@@ -343,7 +343,8 @@ const struct file_operations omfs_file_operations = {
 	.splice_read = generic_file_splice_read,
 };
 
-static int omfs_setattr(struct dentry *dentry, struct iattr *attr)
+static int omfs_setattr(struct user_namespace *mnt_userns,
+			struct dentry *dentry, struct iattr *attr)
 {
 	struct inode *inode = d_inode(dentry);
 	int error;
diff --git a/fs/orangefs/acl.c b/fs/orangefs/acl.c
index ba55d61906c2..c992ee66f420 100644
--- a/fs/orangefs/acl.c
+++ b/fs/orangefs/acl.c
@@ -116,7 +116,8 @@ static int __orangefs_set_acl(struct inode *inode, struct posix_acl *acl,
 	return error;
 }
 
-int orangefs_set_acl(struct inode *inode, struct posix_acl *acl, int type)
+int orangefs_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
+		     struct posix_acl *acl, int type)
 {
 	int error;
 	struct iattr iattr;
diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index b94032f77e61..5079cfafa8d7 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -871,7 +871,8 @@ int __orangefs_setattr(struct inode *inode, struct iattr *iattr)
 /*
  * Change attributes of an object referenced by dentry.
  */
-int orangefs_setattr(struct dentry *dentry, struct iattr *iattr)
+int orangefs_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
+		     struct iattr *iattr)
 {
 	int ret;
 	gossip_debug(GOSSIP_INODE_DEBUG, "__orangefs_setattr: called on %pd\n",
@@ -890,8 +891,8 @@ int orangefs_setattr(struct dentry *dentry, struct iattr *iattr)
 /*
  * Obtain attributes of an object given a dentry
  */
-int orangefs_getattr(const struct path *path, struct kstat *stat,
-		     u32 request_mask, unsigned int flags)
+int orangefs_getattr(struct user_namespace *mnt_userns, const struct path *path,
+		     struct kstat *stat, u32 request_mask, unsigned int flags)
 {
 	int ret;
 	struct inode *inode = path->dentry->d_inode;
@@ -919,7 +920,8 @@ int orangefs_getattr(const struct path *path, struct kstat *stat,
 	return ret;
 }
 
-int orangefs_permission(struct inode *inode, int mask)
+int orangefs_permission(struct user_namespace *mnt_userns,
+			struct inode *inode, int mask)
 {
 	int ret;
 
diff --git a/fs/orangefs/namei.c b/fs/orangefs/namei.c
index 3e7cf3d0a494..600e8eee541f 100644
--- a/fs/orangefs/namei.c
+++ b/fs/orangefs/namei.c
@@ -15,7 +15,8 @@
 /*
  * Get a newly allocated inode to go with a negative dentry.
  */
-static int orangefs_create(struct inode *dir,
+static int orangefs_create(struct user_namespace *mnt_userns,
+			struct inode *dir,
 			struct dentry *dentry,
 			umode_t mode,
 			bool exclusive)
@@ -215,7 +216,8 @@ static int orangefs_unlink(struct inode *dir, struct dentry *dentry)
 	return ret;
 }
 
-static int orangefs_symlink(struct inode *dir,
+static int orangefs_symlink(struct user_namespace *mnt_userns,
+		         struct inode *dir,
 			 struct dentry *dentry,
 			 const char *symname)
 {
@@ -303,7 +305,8 @@ static int orangefs_symlink(struct inode *dir,
 	return ret;
 }
 
-static int orangefs_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
+static int orangefs_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
+			  struct dentry *dentry, umode_t mode)
 {
 	struct orangefs_inode_s *parent = ORANGEFS_I(dir);
 	struct orangefs_kernel_op_s *new_op;
@@ -372,7 +375,8 @@ static int orangefs_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode
 	return ret;
 }
 
-static int orangefs_rename(struct inode *old_dir,
+static int orangefs_rename(struct user_namespace *mnt_userns,
+			struct inode *old_dir,
 			struct dentry *old_dentry,
 			struct inode *new_dir,
 			struct dentry *new_dentry,
diff --git a/fs/orangefs/orangefs-kernel.h b/fs/orangefs/orangefs-kernel.h
index e12aeb9623d6..0e6b97682e41 100644
--- a/fs/orangefs/orangefs-kernel.h
+++ b/fs/orangefs/orangefs-kernel.h
@@ -107,7 +107,9 @@ extern int orangefs_init_acl(struct inode *inode, struct inode *dir);
 extern const struct xattr_handler *orangefs_xattr_handlers[];
 
 extern struct posix_acl *orangefs_get_acl(struct inode *inode, int type);
-extern int orangefs_set_acl(struct inode *inode, struct posix_acl *acl, int type);
+extern int orangefs_set_acl(struct user_namespace *mnt_userns,
+			    struct inode *inode, struct posix_acl *acl,
+			    int type);
 
 /*
  * orangefs data structures
@@ -359,12 +361,13 @@ struct inode *orangefs_new_inode(struct super_block *sb,
 			      struct orangefs_object_kref *ref);
 
 int __orangefs_setattr(struct inode *, struct iattr *);
-int orangefs_setattr(struct dentry *, struct iattr *);
+int orangefs_setattr(struct user_namespace *, struct dentry *, struct iattr *);
 
-int orangefs_getattr(const struct path *path, struct kstat *stat,
-		     u32 request_mask, unsigned int flags);
+int orangefs_getattr(struct user_namespace *mnt_userns, const struct path *path,
+		     struct kstat *stat, u32 request_mask, unsigned int flags);
 
-int orangefs_permission(struct inode *inode, int mask);
+int orangefs_permission(struct user_namespace *mnt_userns,
+			struct inode *inode, int mask);
 
 int orangefs_update_time(struct inode *, struct timespec64 *, int);
 
diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 6904cc2ed7bb..8b3be7342a8c 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -650,19 +650,20 @@ static int ovl_create_object(struct dentry *dentry, int mode, dev_t rdev,
 	return err;
 }
 
-static int ovl_create(struct inode *dir, struct dentry *dentry, umode_t mode,
-		      bool excl)
+static int ovl_create(struct user_namespace *mnt_userns, struct inode *dir,
+		      struct dentry *dentry, umode_t mode, bool excl)
 {
 	return ovl_create_object(dentry, (mode & 07777) | S_IFREG, 0, NULL);
 }
 
-static int ovl_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
+static int ovl_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
+		     struct dentry *dentry, umode_t mode)
 {
 	return ovl_create_object(dentry, (mode & 07777) | S_IFDIR, 0, NULL);
 }
 
-static int ovl_mknod(struct inode *dir, struct dentry *dentry, umode_t mode,
-		     dev_t rdev)
+static int ovl_mknod(struct user_namespace *mnt_userns, struct inode *dir,
+		     struct dentry *dentry, umode_t mode, dev_t rdev)
 {
 	/* Don't allow creation of "whiteout" on overlay */
 	if (S_ISCHR(mode) && rdev == WHITEOUT_DEV)
@@ -671,8 +672,8 @@ static int ovl_mknod(struct inode *dir, struct dentry *dentry, umode_t mode,
 	return ovl_create_object(dentry, mode, rdev, NULL);
 }
 
-static int ovl_symlink(struct inode *dir, struct dentry *dentry,
-		       const char *link)
+static int ovl_symlink(struct user_namespace *mnt_userns, struct inode *dir,
+		       struct dentry *dentry, const char *link)
 {
 	return ovl_create_object(dentry, S_IFLNK, 0, link);
 }
@@ -1069,9 +1070,9 @@ static int ovl_set_redirect(struct dentry *dentry, bool samedir)
 	return err;
 }
 
-static int ovl_rename(struct inode *olddir, struct dentry *old,
-		      struct inode *newdir, struct dentry *new,
-		      unsigned int flags)
+static int ovl_rename(struct user_namespace *mnt_userns, struct inode *olddir,
+		      struct dentry *old, struct inode *newdir,
+		      struct dentry *new, unsigned int flags)
 {
 	int err;
 	struct dentry *old_upperdir;
diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index 2835f33f386a..49ee88d26997 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -14,7 +14,8 @@
 #include "overlayfs.h"
 
 
-int ovl_setattr(struct dentry *dentry, struct iattr *attr)
+int ovl_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
+		struct iattr *attr)
 {
 	int err;
 	bool full_copy_up = false;
@@ -154,8 +155,8 @@ static int ovl_map_dev_ino(struct dentry *dentry, struct kstat *stat, int fsid)
 	return 0;
 }
 
-int ovl_getattr(const struct path *path, struct kstat *stat,
-		u32 request_mask, unsigned int flags)
+int ovl_getattr(struct user_namespace *mnt_userns, const struct path *path,
+		struct kstat *stat, u32 request_mask, unsigned int flags)
 {
 	struct dentry *dentry = path->dentry;
 	enum ovl_path_type type;
@@ -277,7 +278,8 @@ int ovl_getattr(const struct path *path, struct kstat *stat,
 	return err;
 }
 
-int ovl_permission(struct inode *inode, int mask)
+int ovl_permission(struct user_namespace *mnt_userns,
+		   struct inode *inode, int mask)
 {
 	struct inode *upperinode = ovl_inode_upper(inode);
 	struct inode *realinode = upperinode ?: ovl_inode_lower(inode);
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 5556e85552c1..f8ab96e93068 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -441,10 +441,11 @@ int ovl_set_nlink_lower(struct dentry *dentry);
 unsigned int ovl_get_nlink(struct ovl_fs *ofs, struct dentry *lowerdentry,
 			   struct dentry *upperdentry,
 			   unsigned int fallback);
-int ovl_setattr(struct dentry *dentry, struct iattr *attr);
-int ovl_getattr(const struct path *path, struct kstat *stat,
-		u32 request_mask, unsigned int flags);
-int ovl_permission(struct inode *inode, int mask);
+int ovl_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
+		struct iattr *attr);
+int ovl_getattr(struct user_namespace *mnt_userns, const struct path *path,
+		struct kstat *stat, u32 request_mask, unsigned int flags);
+int ovl_permission(struct user_namespace *mnt_userns, struct inode *inode, int mask);
 int ovl_xattr_set(struct dentry *dentry, struct inode *inode, const char *name,
 		  const void *value, size_t size, int flags);
 int ovl_xattr_get(struct dentry *dentry, struct inode *inode, const char *name,
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index bc295e695a23..aed21e569390 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -976,7 +976,7 @@ ovl_posix_acl_xattr_set(const struct xattr_handler *handler,
 	    !capable_wrt_inode_uidgid(&init_user_ns, inode, CAP_FSETID)) {
 		struct iattr iattr = { .ia_valid = ATTR_KILL_SGID };
 
-		err = ovl_setattr(dentry, &iattr);
+		err = ovl_setattr(&init_user_ns, dentry, &iattr);
 		if (err)
 			return err;
 	}
diff --git a/fs/posix_acl.c b/fs/posix_acl.c
index 7f579917195b..2b1458bc3ded 100644
--- a/fs/posix_acl.c
+++ b/fs/posix_acl.c
@@ -592,7 +592,7 @@ posix_acl_chmod(struct user_namespace *mnt_userns, struct inode *inode, umode_t
 	ret = __posix_acl_chmod(&acl, GFP_KERNEL, mode);
 	if (ret)
 		return ret;
-	ret = inode->i_op->set_acl(inode, acl, ACL_TYPE_ACCESS);
+	ret = inode->i_op->set_acl(mnt_userns, inode, acl, ACL_TYPE_ACCESS);
 	posix_acl_release(acl);
 	return ret;
 }
@@ -914,7 +914,7 @@ set_posix_acl(struct user_namespace *mnt_userns, struct inode *inode,
 		if (ret)
 			return ret;
 	}
-	return inode->i_op->set_acl(inode, acl, type);
+	return inode->i_op->set_acl(mnt_userns, inode, acl, type);
 }
 EXPORT_SYMBOL(set_posix_acl);
 
@@ -962,12 +962,13 @@ const struct xattr_handler posix_acl_default_xattr_handler = {
 };
 EXPORT_SYMBOL_GPL(posix_acl_default_xattr_handler);
 
-int simple_set_acl(struct inode *inode, struct posix_acl *acl, int type)
+int simple_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
+		   struct posix_acl *acl, int type)
 {
 	int error;
 
 	if (type == ACL_TYPE_ACCESS) {
-		error = posix_acl_update_mode(&init_user_ns, inode,
+		error = posix_acl_update_mode(mnt_userns, inode,
 				&inode->i_mode, &acl);
 		if (error)
 			return error;
diff --git a/fs/proc/base.c b/fs/proc/base.c
index bf4b203103a7..005da71a58eb 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -685,7 +685,8 @@ static int proc_fd_access_allowed(struct inode *inode)
 	return allowed;
 }
 
-int proc_setattr(struct dentry *dentry, struct iattr *attr)
+int proc_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
+		 struct iattr *attr)
 {
 	int error;
 	struct inode *inode = d_inode(dentry);
@@ -726,7 +727,8 @@ static bool has_pid_permissions(struct proc_fs_info *fs_info,
 }
 
 
-static int proc_pid_permission(struct inode *inode, int mask)
+static int proc_pid_permission(struct user_namespace *mnt_userns,
+			       struct inode *inode, int mask)
 {
 	struct proc_fs_info *fs_info = proc_sb_info(inode->i_sb);
 	struct task_struct *task;
@@ -1927,8 +1929,8 @@ struct inode *proc_pid_make_inode(struct super_block * sb,
 	return NULL;
 }
 
-int pid_getattr(const struct path *path, struct kstat *stat,
-		u32 request_mask, unsigned int query_flags)
+int pid_getattr(struct user_namespace *mnt_userns, const struct path *path,
+		struct kstat *stat, u32 request_mask, unsigned int query_flags)
 {
 	struct inode *inode = d_inode(path->dentry);
 	struct proc_fs_info *fs_info = proc_sb_info(inode->i_sb);
@@ -3470,7 +3472,8 @@ int proc_pid_readdir(struct file *file, struct dir_context *ctx)
  * This function makes sure that the node is always accessible for members of
  * same thread group.
  */
-static int proc_tid_comm_permission(struct inode *inode, int mask)
+static int proc_tid_comm_permission(struct user_namespace *mnt_userns,
+				    struct inode *inode, int mask)
 {
 	bool is_same_tgroup;
 	struct task_struct *task;
@@ -3792,7 +3795,8 @@ static int proc_task_readdir(struct file *file, struct dir_context *ctx)
 	return 0;
 }
 
-static int proc_task_getattr(const struct path *path, struct kstat *stat,
+static int proc_task_getattr(struct user_namespace *mnt_userns,
+			     const struct path *path, struct kstat *stat,
 			     u32 request_mask, unsigned int query_flags)
 {
 	struct inode *inode = d_inode(path->dentry);
diff --git a/fs/proc/fd.c b/fs/proc/fd.c
index ad692a39381d..01377317f92a 100644
--- a/fs/proc/fd.c
+++ b/fs/proc/fd.c
@@ -294,7 +294,8 @@ static struct dentry *proc_lookupfd(struct inode *dir, struct dentry *dentry,
  * /proc/pid/fd needs a special permission handler so that a process can still
  * access /proc/self/fd after it has executed a setuid().
  */
-int proc_fd_permission(struct inode *inode, int mask)
+int proc_fd_permission(struct user_namespace *mnt_userns,
+		       struct inode *inode, int mask)
 {
 	struct task_struct *p;
 	int rv;
diff --git a/fs/proc/fd.h b/fs/proc/fd.h
index f371a602bf58..c5a921a06a0b 100644
--- a/fs/proc/fd.h
+++ b/fs/proc/fd.h
@@ -10,7 +10,8 @@ extern const struct inode_operations proc_fd_inode_operations;
 extern const struct file_operations proc_fdinfo_operations;
 extern const struct inode_operations proc_fdinfo_inode_operations;
 
-extern int proc_fd_permission(struct inode *inode, int mask);
+extern int proc_fd_permission(struct user_namespace *mnt_userns,
+			      struct inode *inode, int mask);
 
 static inline unsigned int proc_fd(struct inode *inode)
 {
diff --git a/fs/proc/generic.c b/fs/proc/generic.c
index 5c6345c68fc5..ad3a4aa53113 100644
--- a/fs/proc/generic.c
+++ b/fs/proc/generic.c
@@ -115,7 +115,8 @@ static bool pde_subdir_insert(struct proc_dir_entry *dir,
 	return true;
 }
 
-static int proc_notify_change(struct dentry *dentry, struct iattr *iattr)
+static int proc_notify_change(struct user_namespace *mnt_userns,
+			      struct dentry *dentry, struct iattr *iattr)
 {
 	struct inode *inode = d_inode(dentry);
 	struct proc_dir_entry *de = PDE(inode);
@@ -133,7 +134,8 @@ static int proc_notify_change(struct dentry *dentry, struct iattr *iattr)
 	return 0;
 }
 
-static int proc_getattr(const struct path *path, struct kstat *stat,
+static int proc_getattr(struct user_namespace *mnt_userns,
+			const struct path *path, struct kstat *stat,
 			u32 request_mask, unsigned int query_flags)
 {
 	struct inode *inode = d_inode(path->dentry);
diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index 917cc85e3466..6ce093a26020 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -162,8 +162,9 @@ extern int proc_pid_statm(struct seq_file *, struct pid_namespace *,
  * base.c
  */
 extern const struct dentry_operations pid_dentry_operations;
-extern int pid_getattr(const struct path *, struct kstat *, u32, unsigned int);
-extern int proc_setattr(struct dentry *, struct iattr *);
+extern int pid_getattr(struct user_namespace *, const struct path *,
+		       struct kstat *, u32, unsigned int);
+extern int proc_setattr(struct user_namespace *, struct dentry *, struct iattr *);
 extern void proc_pid_evict_inode(struct proc_inode *);
 extern struct inode *proc_pid_make_inode(struct super_block *, struct task_struct *, umode_t);
 extern void pid_update_inode(struct task_struct *, struct inode *);
diff --git a/fs/proc/proc_net.c b/fs/proc/proc_net.c
index bc555b7da6dc..50cf592336d2 100644
--- a/fs/proc/proc_net.c
+++ b/fs/proc/proc_net.c
@@ -305,7 +305,8 @@ static struct dentry *proc_tgid_net_lookup(struct inode *dir,
 	return de;
 }
 
-static int proc_tgid_net_getattr(const struct path *path, struct kstat *stat,
+static int proc_tgid_net_getattr(struct user_namespace *mnt_userns,
+				 const struct path *path, struct kstat *stat,
 				 u32 request_mask, unsigned int query_flags)
 {
 	struct inode *inode = d_inode(path->dentry);
diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 87c828348140..2daac06727d0 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -785,7 +785,8 @@ static int proc_sys_readdir(struct file *file, struct dir_context *ctx)
 	return 0;
 }
 
-static int proc_sys_permission(struct inode *inode, int mask)
+static int proc_sys_permission(struct user_namespace *mnt_userns,
+			       struct inode *inode, int mask)
 {
 	/*
 	 * sysctl entries that are not writeable,
@@ -813,7 +814,8 @@ static int proc_sys_permission(struct inode *inode, int mask)
 	return error;
 }
 
-static int proc_sys_setattr(struct dentry *dentry, struct iattr *attr)
+static int proc_sys_setattr(struct user_namespace *mnt_userns,
+			    struct dentry *dentry, struct iattr *attr)
 {
 	struct inode *inode = d_inode(dentry);
 	int error;
@@ -830,7 +832,8 @@ static int proc_sys_setattr(struct dentry *dentry, struct iattr *attr)
 	return 0;
 }
 
-static int proc_sys_getattr(const struct path *path, struct kstat *stat,
+static int proc_sys_getattr(struct user_namespace *mnt_userns,
+			    const struct path *path, struct kstat *stat,
 			    u32 request_mask, unsigned int query_flags)
 {
 	struct inode *inode = d_inode(path->dentry);
diff --git a/fs/proc/root.c b/fs/proc/root.c
index 244e4b6f15ef..c7e3b1350ef8 100644
--- a/fs/proc/root.c
+++ b/fs/proc/root.c
@@ -308,7 +308,8 @@ void __init proc_root_init(void)
 	register_filesystem(&proc_fs_type);
 }
 
-static int proc_root_getattr(const struct path *path, struct kstat *stat,
+static int proc_root_getattr(struct user_namespace *mnt_userns,
+			     const struct path *path, struct kstat *stat,
 			     u32 request_mask, unsigned int query_flags)
 {
 	generic_fillattr(&init_user_ns, d_inode(path->dentry), stat);
diff --git a/fs/ramfs/file-nommu.c b/fs/ramfs/file-nommu.c
index f0358fe410d3..ba3525ccc27e 100644
--- a/fs/ramfs/file-nommu.c
+++ b/fs/ramfs/file-nommu.c
@@ -22,7 +22,7 @@
 #include <linux/uaccess.h>
 #include "internal.h"
 
-static int ramfs_nommu_setattr(struct dentry *, struct iattr *);
+static int ramfs_nommu_setattr(struct user_namespace *, struct dentry *, struct iattr *);
 static unsigned long ramfs_nommu_get_unmapped_area(struct file *file,
 						   unsigned long addr,
 						   unsigned long len,
@@ -158,7 +158,8 @@ static int ramfs_nommu_resize(struct inode *inode, loff_t newsize, loff_t size)
  * handle a change of attributes
  * - we're specifically interested in a change of size
  */
-static int ramfs_nommu_setattr(struct dentry *dentry, struct iattr *ia)
+static int ramfs_nommu_setattr(struct user_namespace *mnt_userns,
+			       struct dentry *dentry, struct iattr *ia)
 {
 	struct inode *inode = d_inode(dentry);
 	unsigned int old_ia_valid = ia->ia_valid;
diff --git a/fs/ramfs/inode.c b/fs/ramfs/inode.c
index 3fd4326f36b5..3c2658c8fde0 100644
--- a/fs/ramfs/inode.c
+++ b/fs/ramfs/inode.c
@@ -101,7 +101,8 @@ struct inode *ramfs_get_inode(struct super_block *sb,
  */
 /* SMP-safe */
 static int
-ramfs_mknod(struct inode *dir, struct dentry *dentry, umode_t mode, dev_t dev)
+ramfs_mknod(struct user_namespace *mnt_userns, struct inode *dir,
+	    struct dentry *dentry, umode_t mode, dev_t dev)
 {
 	struct inode * inode = ramfs_get_inode(dir->i_sb, dir, mode, dev);
 	int error = -ENOSPC;
@@ -115,20 +116,23 @@ ramfs_mknod(struct inode *dir, struct dentry *dentry, umode_t mode, dev_t dev)
 	return error;
 }
 
-static int ramfs_mkdir(struct inode * dir, struct dentry * dentry, umode_t mode)
+static int ramfs_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
+		       struct dentry *dentry, umode_t mode)
 {
-	int retval = ramfs_mknod(dir, dentry, mode | S_IFDIR, 0);
+	int retval = ramfs_mknod(&init_user_ns, dir, dentry, mode | S_IFDIR, 0);
 	if (!retval)
 		inc_nlink(dir);
 	return retval;
 }
 
-static int ramfs_create(struct inode *dir, struct dentry *dentry, umode_t mode, bool excl)
+static int ramfs_create(struct user_namespace *mnt_userns, struct inode *dir,
+			struct dentry *dentry, umode_t mode, bool excl)
 {
-	return ramfs_mknod(dir, dentry, mode | S_IFREG, 0);
+	return ramfs_mknod(&init_user_ns, dir, dentry, mode | S_IFREG, 0);
 }
 
-static int ramfs_symlink(struct inode * dir, struct dentry *dentry, const char * symname)
+static int ramfs_symlink(struct user_namespace *mnt_userns, struct inode *dir,
+			 struct dentry *dentry, const char *symname)
 {
 	struct inode *inode;
 	int error = -ENOSPC;
diff --git a/fs/reiserfs/acl.h b/fs/reiserfs/acl.h
index 0c1c847f992f..fd58618da360 100644
--- a/fs/reiserfs/acl.h
+++ b/fs/reiserfs/acl.h
@@ -49,7 +49,8 @@ static inline int reiserfs_acl_count(size_t size)
 
 #ifdef CONFIG_REISERFS_FS_POSIX_ACL
 struct posix_acl *reiserfs_get_acl(struct inode *inode, int type);
-int reiserfs_set_acl(struct inode *inode, struct posix_acl *acl, int type);
+int reiserfs_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
+		     struct posix_acl *acl, int type);
 int reiserfs_acl_chmod(struct inode *inode);
 int reiserfs_inherit_default_acl(struct reiserfs_transaction_handle *th,
 				 struct inode *dir, struct dentry *dentry,
diff --git a/fs/reiserfs/inode.c b/fs/reiserfs/inode.c
index 944f2b487cf8..780bb90c1804 100644
--- a/fs/reiserfs/inode.c
+++ b/fs/reiserfs/inode.c
@@ -3282,7 +3282,8 @@ static ssize_t reiserfs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 	return ret;
 }
 
-int reiserfs_setattr(struct dentry *dentry, struct iattr *attr)
+int reiserfs_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
+		     struct iattr *attr)
 {
 	struct inode *inode = d_inode(dentry);
 	unsigned int ia_valid;
diff --git a/fs/reiserfs/namei.c b/fs/reiserfs/namei.c
index a67a7d371725..e6eb05e2b2f1 100644
--- a/fs/reiserfs/namei.c
+++ b/fs/reiserfs/namei.c
@@ -619,8 +619,8 @@ static int new_inode_init(struct inode *inode, struct inode *dir, umode_t mode)
 	return dquot_initialize(inode);
 }
 
-static int reiserfs_create(struct inode *dir, struct dentry *dentry, umode_t mode,
-			   bool excl)
+static int reiserfs_create(struct user_namespace *mnt_userns, struct inode *dir,
+			   struct dentry *dentry, umode_t mode, bool excl)
 {
 	int retval;
 	struct inode *inode;
@@ -698,8 +698,8 @@ static int reiserfs_create(struct inode *dir, struct dentry *dentry, umode_t mod
 	return retval;
 }
 
-static int reiserfs_mknod(struct inode *dir, struct dentry *dentry, umode_t mode,
-			  dev_t rdev)
+static int reiserfs_mknod(struct user_namespace *mnt_userns, struct inode *dir,
+			  struct dentry *dentry, umode_t mode, dev_t rdev)
 {
 	int retval;
 	struct inode *inode;
@@ -781,7 +781,8 @@ static int reiserfs_mknod(struct inode *dir, struct dentry *dentry, umode_t mode
 	return retval;
 }
 
-static int reiserfs_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
+static int reiserfs_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
+			  struct dentry *dentry, umode_t mode)
 {
 	int retval;
 	struct inode *inode;
@@ -1094,8 +1095,9 @@ static int reiserfs_unlink(struct inode *dir, struct dentry *dentry)
 	return retval;
 }
 
-static int reiserfs_symlink(struct inode *parent_dir,
-			    struct dentry *dentry, const char *symname)
+static int reiserfs_symlink(struct user_namespace *mnt_userns,
+			    struct inode *parent_dir, struct dentry *dentry,
+			    const char *symname)
 {
 	int retval;
 	struct inode *inode;
@@ -1304,7 +1306,8 @@ static void set_ino_in_dir_entry(struct reiserfs_dir_entry *de,
  * one path. If it holds 2 or more, it can get into endless waiting in
  * get_empty_nodes or its clones
  */
-static int reiserfs_rename(struct inode *old_dir, struct dentry *old_dentry,
+static int reiserfs_rename(struct user_namespace *mnt_userns,
+			   struct inode *old_dir, struct dentry *old_dentry,
 			   struct inode *new_dir, struct dentry *new_dentry,
 			   unsigned int flags)
 {
diff --git a/fs/reiserfs/reiserfs.h b/fs/reiserfs/reiserfs.h
index f69871516167..0ca2ac62e534 100644
--- a/fs/reiserfs/reiserfs.h
+++ b/fs/reiserfs/reiserfs.h
@@ -3102,7 +3102,8 @@ static inline void reiserfs_update_sd(struct reiserfs_transaction_handle *th,
 }
 
 void sd_attrs_to_i_attrs(__u16 sd_attrs, struct inode *inode);
-int reiserfs_setattr(struct dentry *dentry, struct iattr *attr);
+int reiserfs_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
+		     struct iattr *attr);
 
 int __reiserfs_write_begin(struct page *page, unsigned from, unsigned len);
 
diff --git a/fs/reiserfs/xattr.c b/fs/reiserfs/xattr.c
index ec440d1957a1..643461ad9267 100644
--- a/fs/reiserfs/xattr.c
+++ b/fs/reiserfs/xattr.c
@@ -66,14 +66,14 @@
 static int xattr_create(struct inode *dir, struct dentry *dentry, int mode)
 {
 	BUG_ON(!inode_is_locked(dir));
-	return dir->i_op->create(dir, dentry, mode, true);
+	return dir->i_op->create(&init_user_ns, dir, dentry, mode, true);
 }
 #endif
 
 static int xattr_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 {
 	BUG_ON(!inode_is_locked(dir));
-	return dir->i_op->mkdir(dir, dentry, mode);
+	return dir->i_op->mkdir(&init_user_ns, dir, dentry, mode);
 }
 
 /*
@@ -352,7 +352,7 @@ static int chown_one_xattr(struct dentry *dentry, void *data)
 	 * ATTR_MODE is set.
 	 */
 	attrs->ia_valid &= (ATTR_UID|ATTR_GID);
-	err = reiserfs_setattr(dentry, attrs);
+	err = reiserfs_setattr(&init_user_ns, dentry, attrs);
 	attrs->ia_valid = ia_valid;
 
 	return err;
@@ -604,7 +604,7 @@ reiserfs_xattr_set_handle(struct reiserfs_transaction_handle *th,
 		inode_lock_nested(d_inode(dentry), I_MUTEX_XATTR);
 		inode_dio_wait(d_inode(dentry));
 
-		err = reiserfs_setattr(dentry, &newattrs);
+		err = reiserfs_setattr(&init_user_ns, dentry, &newattrs);
 		inode_unlock(d_inode(dentry));
 	} else
 		update_ctime(inode);
@@ -948,7 +948,7 @@ static int xattr_mount_check(struct super_block *s)
 	return 0;
 }
 
-int reiserfs_permission(struct inode *inode, int mask)
+int reiserfs_permission(struct user_namespace *mnt_userns, struct inode *inode, int mask)
 {
 	/*
 	 * We don't do permission checks on the internal objects.
diff --git a/fs/reiserfs/xattr.h b/fs/reiserfs/xattr.h
index c764352447ba..9b3b06da568c 100644
--- a/fs/reiserfs/xattr.h
+++ b/fs/reiserfs/xattr.h
@@ -16,7 +16,8 @@ int reiserfs_xattr_init(struct super_block *sb, int mount_flags);
 int reiserfs_lookup_privroot(struct super_block *sb);
 int reiserfs_delete_xattrs(struct inode *inode);
 int reiserfs_chown_xattrs(struct inode *inode, struct iattr *attrs);
-int reiserfs_permission(struct inode *inode, int mask);
+int reiserfs_permission(struct user_namespace *mnt_userns,
+			struct inode *inode, int mask);
 
 #ifdef CONFIG_REISERFS_FS_XATTR
 #define has_xattr_dir(inode) (REISERFS_I(inode)->i_flags & i_has_xattr_dir)
diff --git a/fs/reiserfs/xattr_acl.c b/fs/reiserfs/xattr_acl.c
index b8f397134c17..1eb7ce156e43 100644
--- a/fs/reiserfs/xattr_acl.c
+++ b/fs/reiserfs/xattr_acl.c
@@ -18,7 +18,8 @@ static int __reiserfs_set_acl(struct reiserfs_transaction_handle *th,
 
 
 int
-reiserfs_set_acl(struct inode *inode, struct posix_acl *acl, int type)
+reiserfs_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
+		 struct posix_acl *acl, int type)
 {
 	int error, error2;
 	struct reiserfs_transaction_handle th;
diff --git a/fs/stat.c b/fs/stat.c
index 8c58c37ef1ab..e1cb9ae2d850 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -75,6 +75,7 @@ EXPORT_SYMBOL(generic_fillattr);
 int vfs_getattr_nosec(const struct path *path, struct kstat *stat,
 		      u32 request_mask, unsigned int query_flags)
 {
+	struct user_namespace *mnt_userns;
 	struct inode *inode = d_backing_inode(path->dentry);
 
 	memset(stat, 0, sizeof(*stat));
@@ -91,11 +92,12 @@ int vfs_getattr_nosec(const struct path *path, struct kstat *stat,
 	if (IS_DAX(inode))
 		stat->attributes |= STATX_ATTR_DAX;
 
+	mnt_userns = mnt_user_ns(path->mnt);
 	if (inode->i_op->getattr)
-		return inode->i_op->getattr(path, stat, request_mask,
-					    query_flags);
+		return inode->i_op->getattr(mnt_userns, path, stat,
+					    request_mask, query_flags);
 
-	generic_fillattr(mnt_user_ns(path->mnt), inode, stat);
+	generic_fillattr(mnt_userns, inode, stat);
 	return 0;
 }
 EXPORT_SYMBOL(vfs_getattr_nosec);
diff --git a/fs/sysv/file.c b/fs/sysv/file.c
index ca7e216b7b9e..09779cddb559 100644
--- a/fs/sysv/file.c
+++ b/fs/sysv/file.c
@@ -29,7 +29,8 @@ const struct file_operations sysv_file_operations = {
 	.splice_read	= generic_file_splice_read,
 };
 
-static int sysv_setattr(struct dentry *dentry, struct iattr *attr)
+static int sysv_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
+			struct iattr *attr)
 {
 	struct inode *inode = d_inode(dentry);
 	int error;
diff --git a/fs/sysv/itree.c b/fs/sysv/itree.c
index 83cffab6955f..8b2e99b7bc9f 100644
--- a/fs/sysv/itree.c
+++ b/fs/sysv/itree.c
@@ -441,8 +441,8 @@ static unsigned sysv_nblocks(struct super_block *s, loff_t size)
 	return blocks;
 }
 
-int sysv_getattr(const struct path *path, struct kstat *stat,
-		 u32 request_mask, unsigned int flags)
+int sysv_getattr(struct user_namespace *mnt_userns, const struct path *path,
+		 struct kstat *stat, u32 request_mask, unsigned int flags)
 {
 	struct super_block *s = path->dentry->d_sb;
 	generic_fillattr(&init_user_ns, d_inode(path->dentry), stat);
diff --git a/fs/sysv/namei.c b/fs/sysv/namei.c
index ea2414b385ec..b2e6abc06a2d 100644
--- a/fs/sysv/namei.c
+++ b/fs/sysv/namei.c
@@ -41,7 +41,8 @@ static struct dentry *sysv_lookup(struct inode * dir, struct dentry * dentry, un
 	return d_splice_alias(inode, dentry);
 }
 
-static int sysv_mknod(struct inode * dir, struct dentry * dentry, umode_t mode, dev_t rdev)
+static int sysv_mknod(struct user_namespace *mnt_userns, struct inode *dir,
+		      struct dentry *dentry, umode_t mode, dev_t rdev)
 {
 	struct inode * inode;
 	int err;
@@ -60,13 +61,14 @@ static int sysv_mknod(struct inode * dir, struct dentry * dentry, umode_t mode,
 	return err;
 }
 
-static int sysv_create(struct inode * dir, struct dentry * dentry, umode_t mode, bool excl)
+static int sysv_create(struct user_namespace *mnt_userns, struct inode *dir,
+		       struct dentry *dentry, umode_t mode, bool excl)
 {
-	return sysv_mknod(dir, dentry, mode, 0);
+	return sysv_mknod(&init_user_ns, dir, dentry, mode, 0);
 }
 
-static int sysv_symlink(struct inode * dir, struct dentry * dentry, 
-	const char * symname)
+static int sysv_symlink(struct user_namespace *mnt_userns, struct inode *dir,
+			struct dentry *dentry, const char *symname)
 {
 	int err = -ENAMETOOLONG;
 	int l = strlen(symname)+1;
@@ -108,7 +110,8 @@ static int sysv_link(struct dentry * old_dentry, struct inode * dir,
 	return add_nondir(dentry, inode);
 }
 
-static int sysv_mkdir(struct inode * dir, struct dentry *dentry, umode_t mode)
+static int sysv_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
+		      struct dentry *dentry, umode_t mode)
 {
 	struct inode * inode;
 	int err;
@@ -186,9 +189,9 @@ static int sysv_rmdir(struct inode * dir, struct dentry * dentry)
  * Anybody can rename anything with this: the permission checks are left to the
  * higher-level routines.
  */
-static int sysv_rename(struct inode * old_dir, struct dentry * old_dentry,
-		       struct inode * new_dir, struct dentry * new_dentry,
-		       unsigned int flags)
+static int sysv_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
+		       struct dentry *old_dentry, struct inode *new_dir,
+		       struct dentry *new_dentry, unsigned int flags)
 {
 	struct inode * old_inode = d_inode(old_dentry);
 	struct inode * new_inode = d_inode(new_dentry);
diff --git a/fs/sysv/sysv.h b/fs/sysv/sysv.h
index 1cff585526b1..99ddf033da4f 100644
--- a/fs/sysv/sysv.h
+++ b/fs/sysv/sysv.h
@@ -141,7 +141,8 @@ extern struct inode *sysv_iget(struct super_block *, unsigned int);
 extern int sysv_write_inode(struct inode *, struct writeback_control *wbc);
 extern int sysv_sync_inode(struct inode *);
 extern void sysv_set_inode(struct inode *, dev_t);
-extern int sysv_getattr(const struct path *, struct kstat *, u32, unsigned int);
+extern int sysv_getattr(struct user_namespace *, const struct path *,
+			struct kstat *, u32, unsigned int);
 extern int sysv_init_icache(void);
 extern void sysv_destroy_icache(void);
 
diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index 0ee8c6dfb036..4b83cbded559 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -67,7 +67,9 @@ static char *get_dname(struct dentry *dentry)
 	return name;
 }
 
-static int tracefs_syscall_mkdir(struct inode *inode, struct dentry *dentry, umode_t mode)
+static int tracefs_syscall_mkdir(struct user_namespace *mnt_userns,
+				 struct inode *inode, struct dentry *dentry,
+				 umode_t mode)
 {
 	char *name;
 	int ret;
diff --git a/fs/ubifs/dir.c b/fs/ubifs/dir.c
index e61d6fa7ed18..ca21dabbf245 100644
--- a/fs/ubifs/dir.c
+++ b/fs/ubifs/dir.c
@@ -270,8 +270,8 @@ static struct dentry *ubifs_lookup(struct inode *dir, struct dentry *dentry,
 	return d_splice_alias(inode, dentry);
 }
 
-static int ubifs_create(struct inode *dir, struct dentry *dentry, umode_t mode,
-			bool excl)
+static int ubifs_create(struct user_namespace *mnt_userns, struct inode *dir,
+			struct dentry *dentry, umode_t mode, bool excl)
 {
 	struct inode *inode;
 	struct ubifs_info *c = dir->i_sb->s_fs_info;
@@ -431,8 +431,8 @@ static int do_tmpfile(struct inode *dir, struct dentry *dentry,
 	return err;
 }
 
-static int ubifs_tmpfile(struct inode *dir, struct dentry *dentry,
-			 umode_t mode)
+static int ubifs_tmpfile(struct user_namespace *mnt_userns, struct inode *dir,
+			 struct dentry *dentry, umode_t mode)
 {
 	return do_tmpfile(dir, dentry, mode, NULL);
 }
@@ -932,7 +932,8 @@ static int ubifs_rmdir(struct inode *dir, struct dentry *dentry)
 	return err;
 }
 
-static int ubifs_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
+static int ubifs_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
+		       struct dentry *dentry, umode_t mode)
 {
 	struct inode *inode;
 	struct ubifs_inode *dir_ui = ubifs_inode(dir);
@@ -1003,8 +1004,8 @@ static int ubifs_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 	return err;
 }
 
-static int ubifs_mknod(struct inode *dir, struct dentry *dentry,
-		       umode_t mode, dev_t rdev)
+static int ubifs_mknod(struct user_namespace *mnt_userns, struct inode *dir,
+		       struct dentry *dentry, umode_t mode, dev_t rdev)
 {
 	struct inode *inode;
 	struct ubifs_inode *ui;
@@ -1092,8 +1093,8 @@ static int ubifs_mknod(struct inode *dir, struct dentry *dentry,
 	return err;
 }
 
-static int ubifs_symlink(struct inode *dir, struct dentry *dentry,
-			 const char *symname)
+static int ubifs_symlink(struct user_namespace *mnt_userns, struct inode *dir,
+			 struct dentry *dentry, const char *symname)
 {
 	struct inode *inode;
 	struct ubifs_inode *ui;
@@ -1532,7 +1533,8 @@ static int ubifs_xrename(struct inode *old_dir, struct dentry *old_dentry,
 	return err;
 }
 
-static int ubifs_rename(struct inode *old_dir, struct dentry *old_dentry,
+static int ubifs_rename(struct user_namespace *mnt_userns,
+			struct inode *old_dir, struct dentry *old_dentry,
 			struct inode *new_dir, struct dentry *new_dentry,
 			unsigned int flags)
 {
@@ -1556,8 +1558,8 @@ static int ubifs_rename(struct inode *old_dir, struct dentry *old_dentry,
 	return do_rename(old_dir, old_dentry, new_dir, new_dentry, flags);
 }
 
-int ubifs_getattr(const struct path *path, struct kstat *stat,
-		  u32 request_mask, unsigned int flags)
+int ubifs_getattr(struct user_namespace *mnt_userns, const struct path *path,
+		  struct kstat *stat, u32 request_mask, unsigned int flags)
 {
 	loff_t size;
 	struct inode *inode = d_inode(path->dentry);
diff --git a/fs/ubifs/file.c b/fs/ubifs/file.c
index 25041c6d08e3..f0e10661782f 100644
--- a/fs/ubifs/file.c
+++ b/fs/ubifs/file.c
@@ -1257,7 +1257,8 @@ static int do_setattr(struct ubifs_info *c, struct inode *inode,
 	return err;
 }
 
-int ubifs_setattr(struct dentry *dentry, struct iattr *attr)
+int ubifs_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
+		  struct iattr *attr)
 {
 	int err;
 	struct inode *inode = d_inode(dentry);
diff --git a/fs/ubifs/ubifs.h b/fs/ubifs/ubifs.h
index 4ffd832e3b93..de37a0bc7774 100644
--- a/fs/ubifs/ubifs.h
+++ b/fs/ubifs/ubifs.h
@@ -1989,13 +1989,14 @@ int ubifs_calc_dark(const struct ubifs_info *c, int spc);
 
 /* file.c */
 int ubifs_fsync(struct file *file, loff_t start, loff_t end, int datasync);
-int ubifs_setattr(struct dentry *dentry, struct iattr *attr);
+int ubifs_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
+		  struct iattr *attr);
 int ubifs_update_time(struct inode *inode, struct timespec64 *time, int flags);
 
 /* dir.c */
 struct inode *ubifs_new_inode(struct ubifs_info *c, struct inode *dir,
 			      umode_t mode);
-int ubifs_getattr(const struct path *path, struct kstat *stat,
+int ubifs_getattr(struct user_namespace *mnt_userns, const struct path *path, struct kstat *stat,
 		  u32 request_mask, unsigned int flags);
 int ubifs_check_dir_empty(struct inode *dir);
 
diff --git a/fs/udf/file.c b/fs/udf/file.c
index 0d5ade491b1a..90748df627ff 100644
--- a/fs/udf/file.c
+++ b/fs/udf/file.c
@@ -253,7 +253,8 @@ const struct file_operations udf_file_operations = {
 	.llseek			= generic_file_llseek,
 };
 
-static int udf_setattr(struct dentry *dentry, struct iattr *attr)
+static int udf_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
+		       struct iattr *attr)
 {
 	struct inode *inode = d_inode(dentry);
 	struct super_block *sb = inode->i_sb;
diff --git a/fs/udf/namei.c b/fs/udf/namei.c
index e169d8fe35b5..f146b3089f3d 100644
--- a/fs/udf/namei.c
+++ b/fs/udf/namei.c
@@ -604,8 +604,8 @@ static int udf_add_nondir(struct dentry *dentry, struct inode *inode)
 	return 0;
 }
 
-static int udf_create(struct inode *dir, struct dentry *dentry, umode_t mode,
-		      bool excl)
+static int udf_create(struct user_namespace *mnt_userns, struct inode *dir,
+		      struct dentry *dentry, umode_t mode, bool excl)
 {
 	struct inode *inode = udf_new_inode(dir, mode);
 
@@ -623,7 +623,8 @@ static int udf_create(struct inode *dir, struct dentry *dentry, umode_t mode,
 	return udf_add_nondir(dentry, inode);
 }
 
-static int udf_tmpfile(struct inode *dir, struct dentry *dentry, umode_t mode)
+static int udf_tmpfile(struct user_namespace *mnt_userns, struct inode *dir,
+		       struct dentry *dentry, umode_t mode)
 {
 	struct inode *inode = udf_new_inode(dir, mode);
 
@@ -642,8 +643,8 @@ static int udf_tmpfile(struct inode *dir, struct dentry *dentry, umode_t mode)
 	return 0;
 }
 
-static int udf_mknod(struct inode *dir, struct dentry *dentry, umode_t mode,
-		     dev_t rdev)
+static int udf_mknod(struct user_namespace *mnt_userns, struct inode *dir,
+		     struct dentry *dentry, umode_t mode, dev_t rdev)
 {
 	struct inode *inode;
 
@@ -658,7 +659,8 @@ static int udf_mknod(struct inode *dir, struct dentry *dentry, umode_t mode,
 	return udf_add_nondir(dentry, inode);
 }
 
-static int udf_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
+static int udf_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
+		     struct dentry *dentry, umode_t mode)
 {
 	struct inode *inode;
 	struct udf_fileident_bh fibh;
@@ -877,8 +879,8 @@ static int udf_unlink(struct inode *dir, struct dentry *dentry)
 	return retval;
 }
 
-static int udf_symlink(struct inode *dir, struct dentry *dentry,
-		       const char *symname)
+static int udf_symlink(struct user_namespace *mnt_userns, struct inode *dir,
+		       struct dentry *dentry, const char *symname)
 {
 	struct inode *inode = udf_new_inode(dir, S_IFLNK | 0777);
 	struct pathComponent *pc;
@@ -1065,9 +1067,9 @@ static int udf_link(struct dentry *old_dentry, struct inode *dir,
 /* Anybody can rename anything with this: the permission checks are left to the
  * higher-level routines.
  */
-static int udf_rename(struct inode *old_dir, struct dentry *old_dentry,
-		      struct inode *new_dir, struct dentry *new_dentry,
-		      unsigned int flags)
+static int udf_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
+		      struct dentry *old_dentry, struct inode *new_dir,
+		      struct dentry *new_dentry, unsigned int flags)
 {
 	struct inode *old_inode = d_inode(old_dentry);
 	struct inode *new_inode = d_inode(new_dentry);
diff --git a/fs/udf/symlink.c b/fs/udf/symlink.c
index 54a44d1f023c..9b223421a3c5 100644
--- a/fs/udf/symlink.c
+++ b/fs/udf/symlink.c
@@ -152,8 +152,9 @@ static int udf_symlink_filler(struct file *file, struct page *page)
 	return err;
 }
 
-static int udf_symlink_getattr(const struct path *path, struct kstat *stat,
-				u32 request_mask, unsigned int flags)
+static int udf_symlink_getattr(struct user_namespace *mnt_userns,
+			       const struct path *path, struct kstat *stat,
+			       u32 request_mask, unsigned int flags)
 {
 	struct dentry *dentry = path->dentry;
 	struct inode *inode = d_backing_inode(dentry);
diff --git a/fs/ufs/inode.c b/fs/ufs/inode.c
index 6b51f3b20143..debc282c1bb4 100644
--- a/fs/ufs/inode.c
+++ b/fs/ufs/inode.c
@@ -1211,7 +1211,8 @@ static int ufs_truncate(struct inode *inode, loff_t size)
 	return err;
 }
 
-int ufs_setattr(struct dentry *dentry, struct iattr *attr)
+int ufs_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
+		struct iattr *attr)
 {
 	struct inode *inode = d_inode(dentry);
 	unsigned int ia_valid = attr->ia_valid;
diff --git a/fs/ufs/namei.c b/fs/ufs/namei.c
index 9ef40f100415..29d5a0e0c8f0 100644
--- a/fs/ufs/namei.c
+++ b/fs/ufs/namei.c
@@ -69,7 +69,8 @@ static struct dentry *ufs_lookup(struct inode * dir, struct dentry *dentry, unsi
  * If the create succeeds, we fill in the inode information
  * with d_instantiate(). 
  */
-static int ufs_create (struct inode * dir, struct dentry * dentry, umode_t mode,
+static int ufs_create (struct user_namespace * mnt_userns,
+		struct inode * dir, struct dentry * dentry, umode_t mode,
 		bool excl)
 {
 	struct inode *inode;
@@ -85,7 +86,8 @@ static int ufs_create (struct inode * dir, struct dentry * dentry, umode_t mode,
 	return ufs_add_nondir(dentry, inode);
 }
 
-static int ufs_mknod(struct inode *dir, struct dentry *dentry, umode_t mode, dev_t rdev)
+static int ufs_mknod(struct user_namespace *mnt_userns, struct inode *dir,
+		     struct dentry *dentry, umode_t mode, dev_t rdev)
 {
 	struct inode *inode;
 	int err;
@@ -104,8 +106,8 @@ static int ufs_mknod(struct inode *dir, struct dentry *dentry, umode_t mode, dev
 	return err;
 }
 
-static int ufs_symlink (struct inode * dir, struct dentry * dentry,
-	const char * symname)
+static int ufs_symlink (struct user_namespace * mnt_userns, struct inode * dir,
+	struct dentry * dentry, const char * symname)
 {
 	struct super_block * sb = dir->i_sb;
 	int err;
@@ -164,7 +166,8 @@ static int ufs_link (struct dentry * old_dentry, struct inode * dir,
 	return error;
 }
 
-static int ufs_mkdir(struct inode * dir, struct dentry * dentry, umode_t mode)
+static int ufs_mkdir(struct user_namespace * mnt_userns, struct inode * dir,
+	struct dentry * dentry, umode_t mode)
 {
 	struct inode * inode;
 	int err;
@@ -240,9 +243,9 @@ static int ufs_rmdir (struct inode * dir, struct dentry *dentry)
 	return err;
 }
 
-static int ufs_rename(struct inode *old_dir, struct dentry *old_dentry,
-		      struct inode *new_dir, struct dentry *new_dentry,
-		      unsigned int flags)
+static int ufs_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
+		      struct dentry *old_dentry, struct inode *new_dir,
+		      struct dentry *new_dentry, unsigned int flags)
 {
 	struct inode *old_inode = d_inode(old_dentry);
 	struct inode *new_inode = d_inode(new_dentry);
diff --git a/fs/ufs/ufs.h b/fs/ufs/ufs.h
index b49e0efdf3d7..550f7c5a3636 100644
--- a/fs/ufs/ufs.h
+++ b/fs/ufs/ufs.h
@@ -123,7 +123,8 @@ extern struct inode *ufs_iget(struct super_block *, unsigned long);
 extern int ufs_write_inode (struct inode *, struct writeback_control *);
 extern int ufs_sync_inode (struct inode *);
 extern void ufs_evict_inode (struct inode *);
-extern int ufs_setattr(struct dentry *dentry, struct iattr *attr);
+extern int ufs_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
+		       struct iattr *attr);
 
 /* namei.c */
 extern const struct file_operations ufs_dir_operations;
diff --git a/fs/vboxsf/dir.c b/fs/vboxsf/dir.c
index 4d569f14a8d8..7aee0ec63ade 100644
--- a/fs/vboxsf/dir.c
+++ b/fs/vboxsf/dir.c
@@ -288,13 +288,15 @@ static int vboxsf_dir_create(struct inode *parent, struct dentry *dentry,
 	return 0;
 }
 
-static int vboxsf_dir_mkfile(struct inode *parent, struct dentry *dentry,
+static int vboxsf_dir_mkfile(struct user_namespace *mnt_userns,
+			     struct inode *parent, struct dentry *dentry,
 			     umode_t mode, bool excl)
 {
 	return vboxsf_dir_create(parent, dentry, mode, 0);
 }
 
-static int vboxsf_dir_mkdir(struct inode *parent, struct dentry *dentry,
+static int vboxsf_dir_mkdir(struct user_namespace *mnt_userns,
+			    struct inode *parent, struct dentry *dentry,
 			    umode_t mode)
 {
 	return vboxsf_dir_create(parent, dentry, mode, 1);
@@ -332,7 +334,8 @@ static int vboxsf_dir_unlink(struct inode *parent, struct dentry *dentry)
 	return 0;
 }
 
-static int vboxsf_dir_rename(struct inode *old_parent,
+static int vboxsf_dir_rename(struct user_namespace *mnt_userns,
+			     struct inode *old_parent,
 			     struct dentry *old_dentry,
 			     struct inode *new_parent,
 			     struct dentry *new_dentry,
@@ -374,7 +377,8 @@ static int vboxsf_dir_rename(struct inode *old_parent,
 	return err;
 }
 
-static int vboxsf_dir_symlink(struct inode *parent, struct dentry *dentry,
+static int vboxsf_dir_symlink(struct user_namespace *mnt_userns,
+			      struct inode *parent, struct dentry *dentry,
 			      const char *symname)
 {
 	struct vboxsf_inode *sf_parent_i = VBOXSF_I(parent);
diff --git a/fs/vboxsf/utils.c b/fs/vboxsf/utils.c
index d2cd1c99f48e..3b847e3fba24 100644
--- a/fs/vboxsf/utils.c
+++ b/fs/vboxsf/utils.c
@@ -212,8 +212,8 @@ int vboxsf_inode_revalidate(struct dentry *dentry)
 	return 0;
 }
 
-int vboxsf_getattr(const struct path *path, struct kstat *kstat,
-		   u32 request_mask, unsigned int flags)
+int vboxsf_getattr(struct user_namespace *mnt_userns, const struct path *path,
+		   struct kstat *kstat, u32 request_mask, unsigned int flags)
 {
 	int err;
 	struct dentry *dentry = path->dentry;
@@ -237,7 +237,8 @@ int vboxsf_getattr(const struct path *path, struct kstat *kstat,
 	return 0;
 }
 
-int vboxsf_setattr(struct dentry *dentry, struct iattr *iattr)
+int vboxsf_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
+		   struct iattr *iattr)
 {
 	struct vboxsf_inode *sf_i = VBOXSF_I(d_inode(dentry));
 	struct vboxsf_sbi *sbi = VBOXSF_SBI(dentry->d_sb);
diff --git a/fs/vboxsf/vfsmod.h b/fs/vboxsf/vfsmod.h
index 18f95b00fc33..760524e78c88 100644
--- a/fs/vboxsf/vfsmod.h
+++ b/fs/vboxsf/vfsmod.h
@@ -90,9 +90,11 @@ int vboxsf_stat(struct vboxsf_sbi *sbi, struct shfl_string *path,
 		struct shfl_fsobjinfo *info);
 int vboxsf_stat_dentry(struct dentry *dentry, struct shfl_fsobjinfo *info);
 int vboxsf_inode_revalidate(struct dentry *dentry);
-int vboxsf_getattr(const struct path *path, struct kstat *kstat,
-		   u32 request_mask, unsigned int query_flags);
-int vboxsf_setattr(struct dentry *dentry, struct iattr *iattr);
+int vboxsf_getattr(struct user_namespace *mnt_userns, const struct path *path,
+		   struct kstat *kstat, u32 request_mask,
+		   unsigned int query_flags);
+int vboxsf_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
+		   struct iattr *iattr);
 struct shfl_string *vboxsf_path_from_dentry(struct vboxsf_sbi *sbi,
 					    struct dentry *dentry);
 int vboxsf_nlscpy(struct vboxsf_sbi *sbi, char *name, size_t name_bound_len,
diff --git a/fs/xfs/xfs_acl.c b/fs/xfs/xfs_acl.c
index 2e9d2d2878ce..1ea3df6aec89 100644
--- a/fs/xfs/xfs_acl.c
+++ b/fs/xfs/xfs_acl.c
@@ -230,7 +230,8 @@ xfs_set_mode(struct inode *inode, umode_t mode)
 }
 
 int
-xfs_set_acl(struct inode *inode, struct posix_acl *acl, int type)
+xfs_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
+	    struct posix_acl *acl, int type)
 {
 	umode_t mode;
 	bool set_mode = false;
diff --git a/fs/xfs/xfs_acl.h b/fs/xfs/xfs_acl.h
index c042c0868016..7bdb3a4ed798 100644
--- a/fs/xfs/xfs_acl.h
+++ b/fs/xfs/xfs_acl.h
@@ -11,7 +11,8 @@ struct posix_acl;
 
 #ifdef CONFIG_XFS_POSIX_ACL
 extern struct posix_acl *xfs_get_acl(struct inode *inode, int type);
-extern int xfs_set_acl(struct inode *inode, struct posix_acl *acl, int type);
+extern int xfs_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
+		       struct posix_acl *acl, int type);
 extern int __xfs_set_acl(struct inode *inode, struct posix_acl *acl, int type);
 void xfs_forget_acl(struct inode *inode, const char *name);
 #else
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index c5f0db50c00f..94c03e885147 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -222,29 +222,32 @@ xfs_generic_create(
 
 STATIC int
 xfs_vn_mknod(
-	struct inode	*dir,
-	struct dentry	*dentry,
-	umode_t		mode,
-	dev_t		rdev)
+	struct user_namespace	*mnt_userns,
+	struct inode		*dir,
+	struct dentry		*dentry,
+	umode_t			mode,
+	dev_t			rdev)
 {
 	return xfs_generic_create(dir, dentry, mode, rdev, false);
 }
 
 STATIC int
 xfs_vn_create(
-	struct inode	*dir,
-	struct dentry	*dentry,
-	umode_t		mode,
-	bool		flags)
+	struct user_namespace	*mnt_userns,
+	struct inode		*dir,
+	struct dentry		*dentry,
+	umode_t			mode,
+	bool			flags)
 {
 	return xfs_generic_create(dir, dentry, mode, 0, false);
 }
 
 STATIC int
 xfs_vn_mkdir(
-	struct inode	*dir,
-	struct dentry	*dentry,
-	umode_t		mode)
+	struct user_namespace	*mnt_userns,
+	struct inode		*dir,
+	struct dentry		*dentry,
+	umode_t			mode)
 {
 	return xfs_generic_create(dir, dentry, mode | S_IFDIR, 0, false);
 }
@@ -363,9 +366,10 @@ xfs_vn_unlink(
 
 STATIC int
 xfs_vn_symlink(
-	struct inode	*dir,
-	struct dentry	*dentry,
-	const char	*symname)
+	struct user_namespace	*mnt_userns,
+	struct inode		*dir,
+	struct dentry		*dentry,
+	const char		*symname)
 {
 	struct inode	*inode;
 	struct xfs_inode *cip = NULL;
@@ -405,11 +409,12 @@ xfs_vn_symlink(
 
 STATIC int
 xfs_vn_rename(
-	struct inode	*odir,
-	struct dentry	*odentry,
-	struct inode	*ndir,
-	struct dentry	*ndentry,
-	unsigned int	flags)
+	struct user_namespace	*mnt_userns,
+	struct inode		*odir,
+	struct dentry		*odentry,
+	struct inode		*ndir,
+	struct dentry		*ndentry,
+	unsigned int		flags)
 {
 	struct inode	*new_inode = d_inode(ndentry);
 	int		omode = 0;
@@ -531,6 +536,7 @@ xfs_stat_blksize(
 
 STATIC int
 xfs_vn_getattr(
+	struct user_namespace	*mnt_userns,
 	const struct path	*path,
 	struct kstat		*stat,
 	u32			request_mask,
@@ -1066,6 +1072,7 @@ xfs_vn_setattr_size(
 
 STATIC int
 xfs_vn_setattr(
+	struct user_namespace	*mnt_userns,
 	struct dentry		*dentry,
 	struct iattr		*iattr)
 {
@@ -1159,9 +1166,10 @@ xfs_vn_fiemap(
 
 STATIC int
 xfs_vn_tmpfile(
-	struct inode	*dir,
-	struct dentry	*dentry,
-	umode_t		mode)
+	struct user_namespace	*mnt_userns,
+	struct inode		*dir,
+	struct dentry		*dentry,
+	umode_t			mode)
 {
 	return xfs_generic_create(dir, dentry, mode, 0, true);
 }
diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index 18039a57f70f..fa18e0bde6a8 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -480,7 +480,8 @@ static int zonefs_file_truncate(struct inode *inode, loff_t isize)
 	return ret;
 }
 
-static int zonefs_inode_setattr(struct dentry *dentry, struct iattr *iattr)
+static int zonefs_inode_setattr(struct user_namespace *mnt_userns,
+				struct dentry *dentry, struct iattr *iattr)
 {
 	struct inode *inode = d_inode(dentry);
 	int ret;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 616aeee07d69..91666187afaa 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1927,22 +1927,22 @@ struct file_operations {
 struct inode_operations {
 	struct dentry * (*lookup) (struct inode *,struct dentry *, unsigned int);
 	const char * (*get_link) (struct dentry *, struct inode *, struct delayed_call *);
-	int (*permission) (struct inode *, int);
+	int (*permission) (struct user_namespace *, struct inode *, int);
 	struct posix_acl * (*get_acl)(struct inode *, int);
 
 	int (*readlink) (struct dentry *, char __user *,int);
 
-	int (*create) (struct inode *,struct dentry *, umode_t, bool);
+	int (*create) (struct user_namespace *, struct inode *,struct dentry *, umode_t, bool);
 	int (*link) (struct dentry *,struct inode *,struct dentry *);
 	int (*unlink) (struct inode *,struct dentry *);
-	int (*symlink) (struct inode *,struct dentry *,const char *);
-	int (*mkdir) (struct inode *,struct dentry *,umode_t);
+	int (*symlink) (struct user_namespace *, struct inode *,struct dentry *,const char *);
+	int (*mkdir) (struct user_namespace *, struct inode *,struct dentry *,umode_t);
 	int (*rmdir) (struct inode *,struct dentry *);
-	int (*mknod) (struct inode *,struct dentry *,umode_t,dev_t);
-	int (*rename) (struct inode *, struct dentry *,
+	int (*mknod) (struct user_namespace *, struct inode *,struct dentry *,umode_t,dev_t);
+	int (*rename) (struct user_namespace *, struct inode *, struct dentry *,
 			struct inode *, struct dentry *, unsigned int);
-	int (*setattr) (struct dentry *, struct iattr *);
-	int (*getattr) (const struct path *, struct kstat *, u32, unsigned int);
+	int (*setattr) (struct user_namespace *, struct dentry *, struct iattr *);
+	int (*getattr) (struct user_namespace *, const struct path *, struct kstat *, u32, unsigned int);
 	ssize_t (*listxattr) (struct dentry *, char *, size_t);
 	int (*fiemap)(struct inode *, struct fiemap_extent_info *, u64 start,
 		      u64 len);
@@ -1950,8 +1950,8 @@ struct inode_operations {
 	int (*atomic_open)(struct inode *, struct dentry *,
 			   struct file *, unsigned open_flag,
 			   umode_t create_mode);
-	int (*tmpfile) (struct inode *, struct dentry *, umode_t);
-	int (*set_acl)(struct inode *, struct posix_acl *, int);
+	int (*tmpfile) (struct user_namespace *, struct inode *, struct dentry *, umode_t);
+	int (*set_acl)(struct user_namespace *, struct inode *, struct posix_acl *, int);
 } ____cacheline_aligned;
 
 static inline ssize_t call_read_iter(struct file *file, struct kiocb *kio,
@@ -3213,15 +3213,18 @@ extern int dcache_dir_open(struct inode *, struct file *);
 extern int dcache_dir_close(struct inode *, struct file *);
 extern loff_t dcache_dir_lseek(struct file *, loff_t, int);
 extern int dcache_readdir(struct file *, struct dir_context *);
-extern int simple_setattr(struct dentry *, struct iattr *);
-extern int simple_getattr(const struct path *, struct kstat *, u32, unsigned int);
+extern int simple_setattr(struct user_namespace *, struct dentry *,
+			  struct iattr *);
+extern int simple_getattr(struct user_namespace *, const struct path *,
+			  struct kstat *, u32, unsigned int);
 extern int simple_statfs(struct dentry *, struct kstatfs *);
 extern int simple_open(struct inode *inode, struct file *file);
 extern int simple_link(struct dentry *, struct inode *, struct dentry *);
 extern int simple_unlink(struct inode *, struct dentry *);
 extern int simple_rmdir(struct inode *, struct dentry *);
-extern int simple_rename(struct inode *, struct dentry *,
-			 struct inode *, struct dentry *, unsigned int);
+extern int simple_rename(struct user_namespace *, struct inode *,
+			 struct dentry *, struct inode *, struct dentry *,
+			 unsigned int);
 extern void simple_recursive_removal(struct dentry *,
                               void (*callback)(struct dentry *));
 extern int noop_fsync(struct file *, loff_t, loff_t, int);
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index a2c6455ea3fa..4884e5867dd5 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -374,10 +374,11 @@ extern int nfs_refresh_inode(struct inode *, struct nfs_fattr *);
 extern int nfs_post_op_update_inode(struct inode *inode, struct nfs_fattr *fattr);
 extern int nfs_post_op_update_inode_force_wcc(struct inode *inode, struct nfs_fattr *fattr);
 extern int nfs_post_op_update_inode_force_wcc_locked(struct inode *inode, struct nfs_fattr *fattr);
-extern int nfs_getattr(const struct path *, struct kstat *, u32, unsigned int);
+extern int nfs_getattr(struct user_namespace *, const struct path *,
+		       struct kstat *, u32, unsigned int);
 extern void nfs_access_add_cache(struct inode *, struct nfs_access_entry *);
 extern void nfs_access_set_mask(struct nfs_access_entry *, u32);
-extern int nfs_permission(struct inode *, int);
+extern int nfs_permission(struct user_namespace *, struct inode *, int);
 extern int nfs_open(struct inode *, struct file *);
 extern int nfs_attribute_cache_expired(struct inode *inode);
 extern int nfs_revalidate_inode(struct nfs_server *server, struct inode *inode);
@@ -385,7 +386,7 @@ extern int __nfs_revalidate_inode(struct nfs_server *, struct inode *);
 extern bool nfs_mapping_need_revalidate_inode(struct inode *inode);
 extern int nfs_revalidate_mapping(struct inode *inode, struct address_space *mapping);
 extern int nfs_revalidate_mapping_rcu(struct inode *inode);
-extern int nfs_setattr(struct dentry *, struct iattr *);
+extern int nfs_setattr(struct user_namespace *, struct dentry *, struct iattr *);
 extern void nfs_setattr_update_inode(struct inode *inode, struct iattr *attr, struct nfs_fattr *);
 extern void nfs_setsecurity(struct inode *inode, struct nfs_fattr *fattr,
 				struct nfs4_label *label);
diff --git a/include/linux/posix_acl.h b/include/linux/posix_acl.h
index 50e266fdaaef..03a74211fd81 100644
--- a/include/linux/posix_acl.h
+++ b/include/linux/posix_acl.h
@@ -79,7 +79,7 @@ extern int posix_acl_create(struct inode *, umode_t *, struct posix_acl **,
 		struct posix_acl **);
 extern int posix_acl_update_mode(struct user_namespace *, struct inode *, umode_t *, struct posix_acl **);
 
-extern int simple_set_acl(struct inode *, struct posix_acl *, int);
+extern int simple_set_acl(struct user_namespace *, struct inode *, struct posix_acl *, int);
 extern int simple_acl_create(struct inode *, struct inode *);
 
 struct posix_acl *get_cached_acl(struct inode *inode, int type);
diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index 8b8c300854db..b73a824d8bca 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -594,8 +594,8 @@ static int mqueue_create_attr(struct dentry *dentry, umode_t mode, void *arg)
 	return error;
 }
 
-static int mqueue_create(struct inode *dir, struct dentry *dentry,
-				umode_t mode, bool excl)
+static int mqueue_create(struct user_namespace *mnt_userns, struct inode *dir,
+			 struct dentry *dentry, umode_t mode, bool excl)
 {
 	return mqueue_create_attr(dentry, mode, NULL);
 }
diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
index dd6f124c12c7..3570583fddd1 100644
--- a/kernel/bpf/inode.c
+++ b/kernel/bpf/inode.c
@@ -152,7 +152,8 @@ static void bpf_dentry_finalize(struct dentry *dentry, struct inode *inode,
 	dir->i_ctime = dir->i_mtime;
 }
 
-static int bpf_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
+static int bpf_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
+		     struct dentry *dentry, umode_t mode)
 {
 	struct inode *inode;
 
@@ -381,8 +382,8 @@ bpf_lookup(struct inode *dir, struct dentry *dentry, unsigned flags)
 	return simple_lookup(dir, dentry, flags);
 }
 
-static int bpf_symlink(struct inode *dir, struct dentry *dentry,
-		       const char *target)
+static int bpf_symlink(struct user_namespace *mnt_userns, struct inode *dir,
+		       struct dentry *dentry, const char *target)
 {
 	char *link = kstrdup(target, GFP_USER | __GFP_NOWARN);
 	struct inode *inode;
diff --git a/mm/shmem.c b/mm/shmem.c
index fe43360c5888..d16c172744b0 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1060,7 +1060,8 @@ void shmem_truncate_range(struct inode *inode, loff_t lstart, loff_t lend)
 }
 EXPORT_SYMBOL_GPL(shmem_truncate_range);
 
-static int shmem_getattr(const struct path *path, struct kstat *stat,
+static int shmem_getattr(struct user_namespace *mnt_userns,
+			 const struct path *path, struct kstat *stat,
 			 u32 request_mask, unsigned int query_flags)
 {
 	struct inode *inode = path->dentry->d_inode;
@@ -1080,7 +1081,8 @@ static int shmem_getattr(const struct path *path, struct kstat *stat,
 	return 0;
 }
 
-static int shmem_setattr(struct dentry *dentry, struct iattr *attr)
+static int shmem_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
+			 struct iattr *attr)
 {
 	struct inode *inode = d_inode(dentry);
 	struct shmem_inode_info *info = SHMEM_I(inode);
@@ -2922,7 +2924,8 @@ static int shmem_statfs(struct dentry *dentry, struct kstatfs *buf)
  * File creation. Allocate an inode, and we're done..
  */
 static int
-shmem_mknod(struct inode *dir, struct dentry *dentry, umode_t mode, dev_t dev)
+shmem_mknod(struct user_namespace *mnt_userns, struct inode *dir,
+	    struct dentry *dentry, umode_t mode, dev_t dev)
 {
 	struct inode *inode;
 	int error = -ENOSPC;
@@ -2951,7 +2954,8 @@ shmem_mknod(struct inode *dir, struct dentry *dentry, umode_t mode, dev_t dev)
 }
 
 static int
-shmem_tmpfile(struct inode *dir, struct dentry *dentry, umode_t mode)
+shmem_tmpfile(struct user_namespace *mnt_userns, struct inode *dir,
+	      struct dentry *dentry, umode_t mode)
 {
 	struct inode *inode;
 	int error = -ENOSPC;
@@ -2974,20 +2978,21 @@ shmem_tmpfile(struct inode *dir, struct dentry *dentry, umode_t mode)
 	return error;
 }
 
-static int shmem_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
+static int shmem_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
+		       struct dentry *dentry, umode_t mode)
 {
 	int error;
 
-	if ((error = shmem_mknod(dir, dentry, mode | S_IFDIR, 0)))
+	if ((error = shmem_mknod(&init_user_ns, dir, dentry, mode | S_IFDIR, 0)))
 		return error;
 	inc_nlink(dir);
 	return 0;
 }
 
-static int shmem_create(struct inode *dir, struct dentry *dentry, umode_t mode,
-		bool excl)
+static int shmem_create(struct user_namespace *mnt_userns, struct inode *dir,
+			struct dentry *dentry, umode_t mode, bool excl)
 {
-	return shmem_mknod(dir, dentry, mode | S_IFREG, 0);
+	return shmem_mknod(&init_user_ns, dir, dentry, mode | S_IFREG, 0);
 }
 
 /*
@@ -3067,7 +3072,8 @@ static int shmem_exchange(struct inode *old_dir, struct dentry *old_dentry, stru
 	return 0;
 }
 
-static int shmem_whiteout(struct inode *old_dir, struct dentry *old_dentry)
+static int shmem_whiteout(struct user_namespace *mnt_userns, struct inode *old_dir,
+			  struct dentry *old_dentry)
 {
 	struct dentry *whiteout;
 	int error;
@@ -3076,7 +3082,7 @@ static int shmem_whiteout(struct inode *old_dir, struct dentry *old_dentry)
 	if (!whiteout)
 		return -ENOMEM;
 
-	error = shmem_mknod(old_dir, whiteout,
+	error = shmem_mknod(&init_user_ns, old_dir, whiteout,
 			    S_IFCHR | WHITEOUT_MODE, WHITEOUT_DEV);
 	dput(whiteout);
 	if (error)
@@ -3099,7 +3105,9 @@ static int shmem_whiteout(struct inode *old_dir, struct dentry *old_dentry)
  * it exists so that the VFS layer correctly free's it when it
  * gets overwritten.
  */
-static int shmem_rename2(struct inode *old_dir, struct dentry *old_dentry, struct inode *new_dir, struct dentry *new_dentry, unsigned int flags)
+static int shmem_rename2(struct user_namespace *mnt_userns, struct inode *old_dir,
+			 struct dentry *old_dentry, struct inode *new_dir,
+			 struct dentry *new_dentry, unsigned int flags)
 {
 	struct inode *inode = d_inode(old_dentry);
 	int they_are_dirs = S_ISDIR(inode->i_mode);
@@ -3116,7 +3124,7 @@ static int shmem_rename2(struct inode *old_dir, struct dentry *old_dentry, struc
 	if (flags & RENAME_WHITEOUT) {
 		int error;
 
-		error = shmem_whiteout(old_dir, old_dentry);
+		error = shmem_whiteout(&init_user_ns, old_dir, old_dentry);
 		if (error)
 			return error;
 	}
@@ -3140,7 +3148,8 @@ static int shmem_rename2(struct inode *old_dir, struct dentry *old_dentry, struc
 	return 0;
 }
 
-static int shmem_symlink(struct inode *dir, struct dentry *dentry, const char *symname)
+static int shmem_symlink(struct user_namespace *mnt_userns, struct inode *dir,
+			 struct dentry *dentry, const char *symname)
 {
 	int error;
 	int len;
diff --git a/net/socket.c b/net/socket.c
index f2e401b4665e..01014a3e571d 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -537,9 +537,10 @@ static ssize_t sockfs_listxattr(struct dentry *dentry, char *buffer,
 	return used;
 }
 
-static int sockfs_setattr(struct dentry *dentry, struct iattr *iattr)
+static int sockfs_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
+			  struct iattr *iattr)
 {
-	int err = simple_setattr(dentry, iattr);
+	int err = simple_setattr(&init_user_ns, dentry, iattr);
 
 	if (!err && (iattr->ia_valid & ATTR_UID)) {
 		struct socket *sock = SOCKET_I(d_inode(dentry));
diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
index 5fd4a64e431f..06f0adaa9361 100644
--- a/security/apparmor/apparmorfs.c
+++ b/security/apparmor/apparmorfs.c
@@ -1773,7 +1773,8 @@ int __aafs_profile_mkdir(struct aa_profile *profile, struct dentry *parent)
 	return error;
 }
 
-static int ns_mkdir_op(struct inode *dir, struct dentry *dentry, umode_t mode)
+static int ns_mkdir_op(struct user_namespace *mnt_userns, struct inode *dir,
+		       struct dentry *dentry, umode_t mode)
 {
 	struct aa_ns *ns, *parent;
 	/* TODO: improve permission check */
diff --git a/security/integrity/evm/evm_secfs.c b/security/integrity/evm/evm_secfs.c
index cfc3075769bb..bbc85637e18b 100644
--- a/security/integrity/evm/evm_secfs.c
+++ b/security/integrity/evm/evm_secfs.c
@@ -219,7 +219,7 @@ static ssize_t evm_write_xattrs(struct file *file, const char __user *buf,
 		newattrs.ia_valid = ATTR_MODE;
 		inode = evm_xattrs->d_inode;
 		inode_lock(inode);
-		err = simple_setattr(evm_xattrs, &newattrs);
+		err = simple_setattr(&init_user_ns, evm_xattrs, &newattrs);
 		inode_unlock(inode);
 		if (!err)
 			err = count;
-- 
2.29.2

