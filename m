Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33ABC2FEB93
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Jan 2021 14:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731971AbhAUNWS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Jan 2021 08:22:18 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:53889 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731831AbhAUNVy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Jan 2021 08:21:54 -0500
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1l2ZtM-0005g7-9f; Thu, 21 Jan 2021 13:20:53 +0000
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
Subject: [PATCH v6 08/40] acl: handle idmapped mounts
Date:   Thu, 21 Jan 2021 14:19:27 +0100
Message-Id: <20210121131959.646623-9-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210121131959.646623-1-christian.brauner@ubuntu.com>
References: <20210121131959.646623-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; i=RKz0iauU0hLnt7MR7SgnNo05MjWNv5jy1mlxwO0jxA8=; m=80G/TSc97yv3iZCBoIaY2ISrmK7KAm3jk6P6CfJKfW4=; p=PJasvfQCv5clvgMDmC4ijQ1gtz9DrcbWmHw+ChkH6LU=; g=87ae7083c1987c60c86a56903021e9bdcb1a4549
X-Patch-Sig: m=pgp; i=christian.brauner@ubuntu.com; s=0x0x91C61BC06578DCA2; b=iHUEABYKAB0WIQRAhzRXHqcMeLMyaSiRxhvAZXjcogUCYAl9pAAKCRCRxhvAZXjcoqllAP4pATm x9KzloFhk77OfxKS/kSPJ6ilUOEbxr+w3IqtigQD/avc5BcKkCTTdRDsAJTH6SwhL/MtLtMuTK7Ts yI/sVQw=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The posix acl permission checking helpers determine whether a caller is
privileged over an inode according to the acls associated with the
inode. Add helpers that make it possible to handle acls on idmapped
mounts.

The vfs and the filesystems targeted by this first iteration make use of
posix_acl_fix_xattr_from_user() and posix_acl_fix_xattr_to_user() to
translate basic posix access and default permissions such as the
ACL_USER and ACL_GROUP type according to the initial user namespace (or
the superblock's user namespace) to and from the caller's current user
namespace. Adapt these two helpers to handle idmapped mounts whereby we
either map from or into the mount's user namespace depending on in which
direction we're translating.
Similarly, cap_convert_nscap() is used by the vfs to translate user
namespace and non-user namespace aware filesystem capabilities from the
superblock's user namespace to the caller's user namespace. Enable it to
handle idmapped mounts by accounting for the mount's user namespace.

In addition the fileystems targeted in the first iteration of this patch
series make use of the posix_acl_chmod() and, posix_acl_update_mode()
helpers. Both helpers perform permission checks on the target inode. Let
them handle idmapped mounts. These two helpers are called when posix
acls are set by the respective filesystems to handle this case we extend
the ->set() method to take an additional user namespace argument to pass
the mount's user namespace down.

Link: https://lore.kernel.org/r/20210112220124.837960-15-christian.brauner@ubuntu.com
Cc: Christoph Hellwig <hch@lst.de>
Cc: David Howells <dhowells@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
- Christoph Hellwig <hch@lst.de>:
  - Don't pollute the vfs with additional helpers simply extend the existing
    helpers with an additional argument and switch all callers.

/* v3 */
unchanged

/* v4 */
- Serge Hallyn <serge@hallyn.com>:
  - Use "mnt_userns" to refer to a vfsmount's userns everywhere to make
    terminology consistent.

/* v5 */
unchanged
base-commit: 7c53f6b671f4aba70ff15e1b05148b10d58c2837

/* v6 */
base-commit: 19c329f6808995b142b3966301f217c831e7cf31

- Christoph Hellwig <hch@lst.de>:
  - Remove "extern" from header.
---
 Documentation/filesystems/locking.rst |  7 ++-
 Documentation/filesystems/porting.rst |  2 +
 fs/9p/acl.c                           |  4 +-
 fs/9p/xattr.c                         |  1 +
 fs/afs/xattr.c                        |  2 +
 fs/btrfs/acl.c                        |  3 +-
 fs/btrfs/inode.c                      |  3 +-
 fs/btrfs/xattr.c                      |  2 +
 fs/ceph/acl.c                         |  3 +-
 fs/ceph/inode.c                       |  2 +-
 fs/ceph/xattr.c                       |  1 +
 fs/cifs/xattr.c                       |  1 +
 fs/ecryptfs/inode.c                   |  1 +
 fs/ext2/acl.c                         |  3 +-
 fs/ext2/inode.c                       |  2 +-
 fs/ext2/xattr_security.c              |  1 +
 fs/ext2/xattr_trusted.c               |  1 +
 fs/ext2/xattr_user.c                  |  1 +
 fs/ext4/acl.c                         |  3 +-
 fs/ext4/inode.c                       |  2 +-
 fs/ext4/xattr_hurd.c                  |  1 +
 fs/ext4/xattr_security.c              |  1 +
 fs/ext4/xattr_trusted.c               |  1 +
 fs/ext4/xattr_user.c                  |  1 +
 fs/f2fs/acl.c                         |  3 +-
 fs/f2fs/file.c                        |  7 ++-
 fs/f2fs/xattr.c                       |  2 +
 fs/fuse/xattr.c                       |  2 +
 fs/gfs2/acl.c                         |  2 +-
 fs/gfs2/inode.c                       |  3 +-
 fs/gfs2/xattr.c                       |  1 +
 fs/hfs/attr.c                         |  1 +
 fs/hfsplus/xattr.c                    |  1 +
 fs/hfsplus/xattr_security.c           |  1 +
 fs/hfsplus/xattr_trusted.c            |  1 +
 fs/hfsplus/xattr_user.c               |  1 +
 fs/jffs2/acl.c                        |  3 +-
 fs/jffs2/fs.c                         |  2 +-
 fs/jffs2/security.c                   |  1 +
 fs/jffs2/xattr_trusted.c              |  1 +
 fs/jffs2/xattr_user.c                 |  1 +
 fs/jfs/acl.c                          |  2 +-
 fs/jfs/file.c                         |  2 +-
 fs/jfs/xattr.c                        |  2 +
 fs/kernfs/inode.c                     |  2 +
 fs/nfs/nfs4proc.c                     |  3 +
 fs/nfsd/nfs2acl.c                     |  6 +-
 fs/nfsd/nfs3acl.c                     |  6 +-
 fs/nfsd/nfs4acl.c                     |  5 +-
 fs/ocfs2/acl.c                        |  3 +-
 fs/ocfs2/xattr.c                      |  3 +
 fs/orangefs/acl.c                     |  3 +-
 fs/orangefs/inode.c                   |  2 +-
 fs/orangefs/xattr.c                   |  1 +
 fs/overlayfs/super.c                  |  3 +
 fs/posix_acl.c                        | 79 ++++++++++++++++++++-------
 fs/reiserfs/xattr_acl.c               |  5 +-
 fs/reiserfs/xattr_security.c          |  3 +-
 fs/reiserfs/xattr_trusted.c           |  3 +-
 fs/reiserfs/xattr_user.c              |  3 +-
 fs/ubifs/xattr.c                      |  1 +
 fs/xattr.c                            | 14 +++--
 fs/xfs/xfs_acl.c                      |  3 +-
 fs/xfs/xfs_iops.c                     |  2 +-
 fs/xfs/xfs_xattr.c                    |  7 ++-
 include/linux/capability.h            |  3 +-
 include/linux/posix_acl.h             | 11 ++--
 include/linux/posix_acl_xattr.h       | 12 ++--
 include/linux/xattr.h                 |  3 +-
 mm/shmem.c                            |  3 +-
 net/socket.c                          |  1 +
 security/commoncap.c                  | 45 ++++++++++++---
 72 files changed, 238 insertions(+), 85 deletions(-)

diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
index c0f2c7586531..b7dcc86c92a4 100644
--- a/Documentation/filesystems/locking.rst
+++ b/Documentation/filesystems/locking.rst
@@ -126,9 +126,10 @@ prototypes::
 	int (*get)(const struct xattr_handler *handler, struct dentry *dentry,
 		   struct inode *inode, const char *name, void *buffer,
 		   size_t size);
-	int (*set)(const struct xattr_handler *handler, struct dentry *dentry,
-		   struct inode *inode, const char *name, const void *buffer,
-		   size_t size, int flags);
+	int (*set)(const struct xattr_handler *handler,
+                   struct user_namespace *mnt_userns,
+                   struct dentry *dentry, struct inode *inode, const char *name,
+                   const void *buffer, size_t size, int flags);
 
 locking rules:
 	all may block
diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
index 867036aa90b8..de1dcec3b5b8 100644
--- a/Documentation/filesystems/porting.rst
+++ b/Documentation/filesystems/porting.rst
@@ -717,6 +717,8 @@ be removed.  Switch while you still can; the old one won't stay.
 **mandatory**
 
 ->setxattr() and xattr_handler.set() get dentry and inode passed separately.
+The xattr_handler.set() gets passed the user namespace of the mount the inode
+is seen from so filesystems can idmap the i_uid and i_gid accordingly.
 dentry might be yet to be attached to inode, so do _not_ use its ->d_inode
 in the instances.  Rationale: !@#!@# security_d_instantiate() needs to be
 called before we attach dentry to inode and !@#!@##!@$!$#!@#$!@$!@$ smack
diff --git a/fs/9p/acl.c b/fs/9p/acl.c
index d77b28e8d57a..1c14f18a6ec9 100644
--- a/fs/9p/acl.c
+++ b/fs/9p/acl.c
@@ -239,6 +239,7 @@ static int v9fs_xattr_get_acl(const struct xattr_handler *handler,
 }
 
 static int v9fs_xattr_set_acl(const struct xattr_handler *handler,
+			      struct user_namespace *mnt_userns,
 			      struct dentry *dentry, struct inode *inode,
 			      const char *name, const void *value,
 			      size_t size, int flags)
@@ -279,7 +280,8 @@ static int v9fs_xattr_set_acl(const struct xattr_handler *handler,
 			struct iattr iattr = { 0 };
 			struct posix_acl *old_acl = acl;
 
-			retval = posix_acl_update_mode(inode, &iattr.ia_mode, &acl);
+			retval = posix_acl_update_mode(mnt_userns, inode,
+						       &iattr.ia_mode, &acl);
 			if (retval)
 				goto err_out;
 			if (!acl) {
diff --git a/fs/9p/xattr.c b/fs/9p/xattr.c
index 87217dd0433e..ee331845e2c7 100644
--- a/fs/9p/xattr.c
+++ b/fs/9p/xattr.c
@@ -157,6 +157,7 @@ static int v9fs_xattr_handler_get(const struct xattr_handler *handler,
 }
 
 static int v9fs_xattr_handler_set(const struct xattr_handler *handler,
+				  struct user_namespace *mnt_userns,
 				  struct dentry *dentry, struct inode *inode,
 				  const char *name, const void *value,
 				  size_t size, int flags)
diff --git a/fs/afs/xattr.c b/fs/afs/xattr.c
index 95c573dcda11..c629caae5002 100644
--- a/fs/afs/xattr.c
+++ b/fs/afs/xattr.c
@@ -120,6 +120,7 @@ static const struct afs_operation_ops afs_store_acl_operation = {
  * Set a file's AFS3 ACL.
  */
 static int afs_xattr_set_acl(const struct xattr_handler *handler,
+			     struct user_namespace *mnt_userns,
                              struct dentry *dentry,
                              struct inode *inode, const char *name,
                              const void *buffer, size_t size, int flags)
@@ -248,6 +249,7 @@ static const struct afs_operation_ops yfs_store_opaque_acl2_operation = {
  * Set a file's YFS ACL.
  */
 static int afs_xattr_set_yfs(const struct xattr_handler *handler,
+			     struct user_namespace *mnt_userns,
                              struct dentry *dentry,
                              struct inode *inode, const char *name,
                              const void *buffer, size_t size, int flags)
diff --git a/fs/btrfs/acl.c b/fs/btrfs/acl.c
index a0af1b952c4d..d12a5a8730a8 100644
--- a/fs/btrfs/acl.c
+++ b/fs/btrfs/acl.c
@@ -113,7 +113,8 @@ int btrfs_set_acl(struct inode *inode, struct posix_acl *acl, int type)
 	umode_t old_mode = inode->i_mode;
 
 	if (type == ACL_TYPE_ACCESS && acl) {
-		ret = posix_acl_update_mode(inode, &inode->i_mode, &acl);
+		ret = posix_acl_update_mode(&init_user_ns, inode,
+					    &inode->i_mode, &acl);
 		if (ret)
 			return ret;
 	}
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 792191a8705b..6c18fb1a25af 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5070,7 +5070,8 @@ static int btrfs_setattr(struct dentry *dentry, struct iattr *attr)
 		err = btrfs_dirty_inode(inode);
 
 		if (!err && attr->ia_valid & ATTR_MODE)
-			err = posix_acl_chmod(inode, inode->i_mode);
+			err = posix_acl_chmod(&init_user_ns, inode,
+					      inode->i_mode);
 	}
 
 	return err;
diff --git a/fs/btrfs/xattr.c b/fs/btrfs/xattr.c
index af6246f36a9e..b025102e435f 100644
--- a/fs/btrfs/xattr.c
+++ b/fs/btrfs/xattr.c
@@ -362,6 +362,7 @@ static int btrfs_xattr_handler_get(const struct xattr_handler *handler,
 }
 
 static int btrfs_xattr_handler_set(const struct xattr_handler *handler,
+				   struct user_namespace *mnt_userns,
 				   struct dentry *unused, struct inode *inode,
 				   const char *name, const void *buffer,
 				   size_t size, int flags)
@@ -371,6 +372,7 @@ static int btrfs_xattr_handler_set(const struct xattr_handler *handler,
 }
 
 static int btrfs_xattr_handler_set_prop(const struct xattr_handler *handler,
+					struct user_namespace *mnt_userns,
 					struct dentry *unused, struct inode *inode,
 					const char *name, const void *value,
 					size_t size, int flags)
diff --git a/fs/ceph/acl.c b/fs/ceph/acl.c
index e0465741c591..52a01ddbc4ac 100644
--- a/fs/ceph/acl.c
+++ b/fs/ceph/acl.c
@@ -100,7 +100,8 @@ int ceph_set_acl(struct inode *inode, struct posix_acl *acl, int type)
 	case ACL_TYPE_ACCESS:
 		name = XATTR_NAME_POSIX_ACL_ACCESS;
 		if (acl) {
-			ret = posix_acl_update_mode(inode, &new_mode, &acl);
+			ret = posix_acl_update_mode(&init_user_ns, inode,
+						    &new_mode, &acl);
 			if (ret)
 				goto out;
 		}
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 285d3baca27e..145e26a4ddbb 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -2262,7 +2262,7 @@ int ceph_setattr(struct dentry *dentry, struct iattr *attr)
 	err = __ceph_setattr(inode, attr);
 
 	if (err >= 0 && (attr->ia_valid & ATTR_MODE))
-		err = posix_acl_chmod(inode, attr->ia_mode);
+		err = posix_acl_chmod(&init_user_ns, inode, attr->ia_mode);
 
 	return err;
 }
diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
index 24997982de01..02f59bcb4f27 100644
--- a/fs/ceph/xattr.c
+++ b/fs/ceph/xattr.c
@@ -1238,6 +1238,7 @@ static int ceph_get_xattr_handler(const struct xattr_handler *handler,
 }
 
 static int ceph_set_xattr_handler(const struct xattr_handler *handler,
+				  struct user_namespace *mnt_userns,
 				  struct dentry *unused, struct inode *inode,
 				  const char *name, const void *value,
 				  size_t size, int flags)
diff --git a/fs/cifs/xattr.c b/fs/cifs/xattr.c
index 6b658a1172ef..41a611e76bb7 100644
--- a/fs/cifs/xattr.c
+++ b/fs/cifs/xattr.c
@@ -101,6 +101,7 @@ static int cifs_creation_time_set(unsigned int xid, struct cifs_tcon *pTcon,
 }
 
 static int cifs_xattr_set(const struct xattr_handler *handler,
+			  struct user_namespace *mnt_userns,
 			  struct dentry *dentry, struct inode *inode,
 			  const char *name, const void *value,
 			  size_t size, int flags)
diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index d3ea0c57b075..ac6472a82567 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -1133,6 +1133,7 @@ static int ecryptfs_xattr_get(const struct xattr_handler *handler,
 }
 
 static int ecryptfs_xattr_set(const struct xattr_handler *handler,
+			      struct user_namespace *mnt_userns,
 			      struct dentry *dentry, struct inode *inode,
 			      const char *name, const void *value, size_t size,
 			      int flags)
diff --git a/fs/ext2/acl.c b/fs/ext2/acl.c
index cf4c77f8dd08..9031f7df2d48 100644
--- a/fs/ext2/acl.c
+++ b/fs/ext2/acl.c
@@ -223,7 +223,8 @@ ext2_set_acl(struct inode *inode, struct posix_acl *acl, int type)
 	umode_t mode = inode->i_mode;
 
 	if (type == ACL_TYPE_ACCESS && acl) {
-		error = posix_acl_update_mode(inode, &mode, &acl);
+		error = posix_acl_update_mode(&init_user_ns, inode, &mode,
+					      &acl);
 		if (error)
 			return error;
 		update_mode = 1;
diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
index 06c0cf28c1a0..9de813635d8d 100644
--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -1691,7 +1691,7 @@ int ext2_setattr(struct dentry *dentry, struct iattr *iattr)
 	}
 	setattr_copy(&init_user_ns, inode, iattr);
 	if (iattr->ia_valid & ATTR_MODE)
-		error = posix_acl_chmod(inode, inode->i_mode);
+		error = posix_acl_chmod(&init_user_ns, inode, inode->i_mode);
 	mark_inode_dirty(inode);
 
 	return error;
diff --git a/fs/ext2/xattr_security.c b/fs/ext2/xattr_security.c
index 9a682e440acb..ebade1f52451 100644
--- a/fs/ext2/xattr_security.c
+++ b/fs/ext2/xattr_security.c
@@ -19,6 +19,7 @@ ext2_xattr_security_get(const struct xattr_handler *handler,
 
 static int
 ext2_xattr_security_set(const struct xattr_handler *handler,
+			struct user_namespace *mnt_userns,
 			struct dentry *unused, struct inode *inode,
 			const char *name, const void *value,
 			size_t size, int flags)
diff --git a/fs/ext2/xattr_trusted.c b/fs/ext2/xattr_trusted.c
index 49add1107850..18a87d5dd1ab 100644
--- a/fs/ext2/xattr_trusted.c
+++ b/fs/ext2/xattr_trusted.c
@@ -26,6 +26,7 @@ ext2_xattr_trusted_get(const struct xattr_handler *handler,
 
 static int
 ext2_xattr_trusted_set(const struct xattr_handler *handler,
+		       struct user_namespace *mnt_userns,
 		       struct dentry *unused, struct inode *inode,
 		       const char *name, const void *value,
 		       size_t size, int flags)
diff --git a/fs/ext2/xattr_user.c b/fs/ext2/xattr_user.c
index c243a3b4d69d..58092449f8ff 100644
--- a/fs/ext2/xattr_user.c
+++ b/fs/ext2/xattr_user.c
@@ -30,6 +30,7 @@ ext2_xattr_user_get(const struct xattr_handler *handler,
 
 static int
 ext2_xattr_user_set(const struct xattr_handler *handler,
+		    struct user_namespace *mnt_userns,
 		    struct dentry *unused, struct inode *inode,
 		    const char *name, const void *value,
 		    size_t size, int flags)
diff --git a/fs/ext4/acl.c b/fs/ext4/acl.c
index 68aaed48315f..7b0fb66bc04d 100644
--- a/fs/ext4/acl.c
+++ b/fs/ext4/acl.c
@@ -245,7 +245,8 @@ ext4_set_acl(struct inode *inode, struct posix_acl *acl, int type)
 	ext4_fc_start_update(inode);
 
 	if ((type == ACL_TYPE_ACCESS) && acl) {
-		error = posix_acl_update_mode(inode, &mode, &acl);
+		error = posix_acl_update_mode(&init_user_ns, inode, &mode,
+					      &acl);
 		if (error)
 			goto out_stop;
 		if (mode != inode->i_mode)
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 8edfa3e226e6..24ea5851e90a 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5524,7 +5524,7 @@ int ext4_setattr(struct dentry *dentry, struct iattr *attr)
 		ext4_orphan_del(NULL, inode);
 
 	if (!error && (ia_valid & ATTR_MODE))
-		rc = posix_acl_chmod(inode, inode->i_mode);
+		rc = posix_acl_chmod(&init_user_ns, inode, inode->i_mode);
 
 err_out:
 	if  (error)
diff --git a/fs/ext4/xattr_hurd.c b/fs/ext4/xattr_hurd.c
index 8cfa74a56361..c78df5790377 100644
--- a/fs/ext4/xattr_hurd.c
+++ b/fs/ext4/xattr_hurd.c
@@ -32,6 +32,7 @@ ext4_xattr_hurd_get(const struct xattr_handler *handler,
 
 static int
 ext4_xattr_hurd_set(const struct xattr_handler *handler,
+		    struct user_namespace *mnt_userns,
 		    struct dentry *unused, struct inode *inode,
 		    const char *name, const void *value,
 		    size_t size, int flags)
diff --git a/fs/ext4/xattr_security.c b/fs/ext4/xattr_security.c
index 197a9d8a15ef..8213f66f7b2d 100644
--- a/fs/ext4/xattr_security.c
+++ b/fs/ext4/xattr_security.c
@@ -23,6 +23,7 @@ ext4_xattr_security_get(const struct xattr_handler *handler,
 
 static int
 ext4_xattr_security_set(const struct xattr_handler *handler,
+			struct user_namespace *mnt_userns,
 			struct dentry *unused, struct inode *inode,
 			const char *name, const void *value,
 			size_t size, int flags)
diff --git a/fs/ext4/xattr_trusted.c b/fs/ext4/xattr_trusted.c
index e9389e5d75c3..7c21ffb26d25 100644
--- a/fs/ext4/xattr_trusted.c
+++ b/fs/ext4/xattr_trusted.c
@@ -30,6 +30,7 @@ ext4_xattr_trusted_get(const struct xattr_handler *handler,
 
 static int
 ext4_xattr_trusted_set(const struct xattr_handler *handler,
+		       struct user_namespace *mnt_userns,
 		       struct dentry *unused, struct inode *inode,
 		       const char *name, const void *value,
 		       size_t size, int flags)
diff --git a/fs/ext4/xattr_user.c b/fs/ext4/xattr_user.c
index d4546184b34b..2fe7ff0a479c 100644
--- a/fs/ext4/xattr_user.c
+++ b/fs/ext4/xattr_user.c
@@ -31,6 +31,7 @@ ext4_xattr_user_get(const struct xattr_handler *handler,
 
 static int
 ext4_xattr_user_set(const struct xattr_handler *handler,
+		    struct user_namespace *mnt_userns,
 		    struct dentry *unused, struct inode *inode,
 		    const char *name, const void *value,
 		    size_t size, int flags)
diff --git a/fs/f2fs/acl.c b/fs/f2fs/acl.c
index 1e5e9b1136ee..6a95bf28f602 100644
--- a/fs/f2fs/acl.c
+++ b/fs/f2fs/acl.c
@@ -213,7 +213,8 @@ static int __f2fs_set_acl(struct inode *inode, int type,
 	case ACL_TYPE_ACCESS:
 		name_index = F2FS_XATTR_INDEX_POSIX_ACL_ACCESS;
 		if (acl && !ipage) {
-			error = posix_acl_update_mode(inode, &mode, &acl);
+			error = posix_acl_update_mode(&init_user_ns, inode,
+						      &mode, &acl);
 			if (error)
 				return error;
 			set_acl_inode(inode, mode);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 90d7b89176de..6ccdfe0606d9 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -831,8 +831,8 @@ int f2fs_getattr(const struct path *path, struct kstat *stat,
 }
 
 #ifdef CONFIG_F2FS_FS_POSIX_ACL
-static void __setattr_copy(struct user_namespace *mnt_userns, struct inode *inode,
-			   const struct iattr *attr)
+static void __setattr_copy(struct user_namespace *mnt_userns,
+			   struct inode *inode, const struct iattr *attr)
 {
 	unsigned int ia_valid = attr->ia_valid;
 
@@ -950,7 +950,8 @@ int f2fs_setattr(struct dentry *dentry, struct iattr *attr)
 	__setattr_copy(&init_user_ns, inode, attr);
 
 	if (attr->ia_valid & ATTR_MODE) {
-		err = posix_acl_chmod(inode, f2fs_get_inode_mode(inode));
+		err = posix_acl_chmod(&init_user_ns, inode,
+				      f2fs_get_inode_mode(inode));
 		if (err || is_inode_flag_set(inode, FI_ACL_MODE)) {
 			inode->i_mode = F2FS_I(inode)->i_acl_mode;
 			clear_inode_flag(inode, FI_ACL_MODE);
diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index d772bf13a814..10081bf74324 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -64,6 +64,7 @@ static int f2fs_xattr_generic_get(const struct xattr_handler *handler,
 }
 
 static int f2fs_xattr_generic_set(const struct xattr_handler *handler,
+		struct user_namespace *mnt_userns,
 		struct dentry *unused, struct inode *inode,
 		const char *name, const void *value,
 		size_t size, int flags)
@@ -107,6 +108,7 @@ static int f2fs_xattr_advise_get(const struct xattr_handler *handler,
 }
 
 static int f2fs_xattr_advise_set(const struct xattr_handler *handler,
+		struct user_namespace *mnt_userns,
 		struct dentry *unused, struct inode *inode,
 		const char *name, const void *value,
 		size_t size, int flags)
diff --git a/fs/fuse/xattr.c b/fs/fuse/xattr.c
index cdea18de94f7..1a7d7ace54e1 100644
--- a/fs/fuse/xattr.c
+++ b/fs/fuse/xattr.c
@@ -188,6 +188,7 @@ static int fuse_xattr_get(const struct xattr_handler *handler,
 }
 
 static int fuse_xattr_set(const struct xattr_handler *handler,
+			  struct user_namespace *mnt_userns,
 			  struct dentry *dentry, struct inode *inode,
 			  const char *name, const void *value, size_t size,
 			  int flags)
@@ -214,6 +215,7 @@ static int no_xattr_get(const struct xattr_handler *handler,
 }
 
 static int no_xattr_set(const struct xattr_handler *handler,
+			struct user_namespace *mnt_userns,
 			struct dentry *dentry, struct inode *nodee,
 			const char *name, const void *value,
 			size_t size, int flags)
diff --git a/fs/gfs2/acl.c b/fs/gfs2/acl.c
index 2e939f5fe751..ce88ef29eef0 100644
--- a/fs/gfs2/acl.c
+++ b/fs/gfs2/acl.c
@@ -130,7 +130,7 @@ int gfs2_set_acl(struct inode *inode, struct posix_acl *acl, int type)
 
 	mode = inode->i_mode;
 	if (type == ACL_TYPE_ACCESS && acl) {
-		ret = posix_acl_update_mode(inode, &mode, &acl);
+		ret = posix_acl_update_mode(&init_user_ns, inode, &mode, &acl);
 		if (ret)
 			goto unlock;
 	}
diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index 59c25181d108..728405d15a05 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -1993,7 +1993,8 @@ static int gfs2_setattr(struct dentry *dentry, struct iattr *attr)
 	else {
 		error = gfs2_setattr_simple(inode, attr);
 		if (!error && attr->ia_valid & ATTR_MODE)
-			error = posix_acl_chmod(inode, inode->i_mode);
+			error = posix_acl_chmod(&init_user_ns, inode,
+						inode->i_mode);
 	}
 
 error:
diff --git a/fs/gfs2/xattr.c b/fs/gfs2/xattr.c
index 9d7667bc4292..13969a813410 100644
--- a/fs/gfs2/xattr.c
+++ b/fs/gfs2/xattr.c
@@ -1214,6 +1214,7 @@ int __gfs2_xattr_set(struct inode *inode, const char *name,
 }
 
 static int gfs2_xattr_set(const struct xattr_handler *handler,
+			  struct user_namespace *mnt_userns,
 			  struct dentry *unused, struct inode *inode,
 			  const char *name, const void *value,
 			  size_t size, int flags)
diff --git a/fs/hfs/attr.c b/fs/hfs/attr.c
index 74fa62643136..2bd54efaf416 100644
--- a/fs/hfs/attr.c
+++ b/fs/hfs/attr.c
@@ -121,6 +121,7 @@ static int hfs_xattr_get(const struct xattr_handler *handler,
 }
 
 static int hfs_xattr_set(const struct xattr_handler *handler,
+			 struct user_namespace *mnt_userns,
 			 struct dentry *unused, struct inode *inode,
 			 const char *name, const void *value, size_t size,
 			 int flags)
diff --git a/fs/hfsplus/xattr.c b/fs/hfsplus/xattr.c
index bb0b27d88e50..4d169c5a2673 100644
--- a/fs/hfsplus/xattr.c
+++ b/fs/hfsplus/xattr.c
@@ -858,6 +858,7 @@ static int hfsplus_osx_getxattr(const struct xattr_handler *handler,
 }
 
 static int hfsplus_osx_setxattr(const struct xattr_handler *handler,
+				struct user_namespace *mnt_userns,
 				struct dentry *unused, struct inode *inode,
 				const char *name, const void *buffer,
 				size_t size, int flags)
diff --git a/fs/hfsplus/xattr_security.c b/fs/hfsplus/xattr_security.c
index cfbe6a3bfb1e..c1c7a16cbf21 100644
--- a/fs/hfsplus/xattr_security.c
+++ b/fs/hfsplus/xattr_security.c
@@ -23,6 +23,7 @@ static int hfsplus_security_getxattr(const struct xattr_handler *handler,
 }
 
 static int hfsplus_security_setxattr(const struct xattr_handler *handler,
+				     struct user_namespace *mnt_userns,
 				     struct dentry *unused, struct inode *inode,
 				     const char *name, const void *buffer,
 				     size_t size, int flags)
diff --git a/fs/hfsplus/xattr_trusted.c b/fs/hfsplus/xattr_trusted.c
index fbad91e1dada..e150372ec564 100644
--- a/fs/hfsplus/xattr_trusted.c
+++ b/fs/hfsplus/xattr_trusted.c
@@ -22,6 +22,7 @@ static int hfsplus_trusted_getxattr(const struct xattr_handler *handler,
 }
 
 static int hfsplus_trusted_setxattr(const struct xattr_handler *handler,
+				    struct user_namespace *mnt_userns,
 				    struct dentry *unused, struct inode *inode,
 				    const char *name, const void *buffer,
 				    size_t size, int flags)
diff --git a/fs/hfsplus/xattr_user.c b/fs/hfsplus/xattr_user.c
index 74d19faf255e..a6b60b153916 100644
--- a/fs/hfsplus/xattr_user.c
+++ b/fs/hfsplus/xattr_user.c
@@ -22,6 +22,7 @@ static int hfsplus_user_getxattr(const struct xattr_handler *handler,
 }
 
 static int hfsplus_user_setxattr(const struct xattr_handler *handler,
+				 struct user_namespace *mnt_userns,
 				 struct dentry *unused, struct inode *inode,
 				 const char *name, const void *buffer,
 				 size_t size, int flags)
diff --git a/fs/jffs2/acl.c b/fs/jffs2/acl.c
index 093ffbd82395..5f27ac593479 100644
--- a/fs/jffs2/acl.c
+++ b/fs/jffs2/acl.c
@@ -236,7 +236,8 @@ int jffs2_set_acl(struct inode *inode, struct posix_acl *acl, int type)
 		if (acl) {
 			umode_t mode;
 
-			rc = posix_acl_update_mode(inode, &mode, &acl);
+			rc = posix_acl_update_mode(&init_user_ns, inode, &mode,
+						   &acl);
 			if (rc)
 				return rc;
 			if (inode->i_mode != mode) {
diff --git a/fs/jffs2/fs.c b/fs/jffs2/fs.c
index 67993808f4da..ee9f51bab4c6 100644
--- a/fs/jffs2/fs.c
+++ b/fs/jffs2/fs.c
@@ -201,7 +201,7 @@ int jffs2_setattr(struct dentry *dentry, struct iattr *iattr)
 
 	rc = jffs2_do_setattr(inode, iattr);
 	if (!rc && (iattr->ia_valid & ATTR_MODE))
-		rc = posix_acl_chmod(inode, inode->i_mode);
+		rc = posix_acl_chmod(&init_user_ns, inode, inode->i_mode);
 
 	return rc;
 }
diff --git a/fs/jffs2/security.c b/fs/jffs2/security.c
index c2332e30f218..aef5522551db 100644
--- a/fs/jffs2/security.c
+++ b/fs/jffs2/security.c
@@ -57,6 +57,7 @@ static int jffs2_security_getxattr(const struct xattr_handler *handler,
 }
 
 static int jffs2_security_setxattr(const struct xattr_handler *handler,
+				   struct user_namespace *mnt_userns,
 				   struct dentry *unused, struct inode *inode,
 				   const char *name, const void *buffer,
 				   size_t size, int flags)
diff --git a/fs/jffs2/xattr_trusted.c b/fs/jffs2/xattr_trusted.c
index 5d6030826c52..cc3f24883e7d 100644
--- a/fs/jffs2/xattr_trusted.c
+++ b/fs/jffs2/xattr_trusted.c
@@ -25,6 +25,7 @@ static int jffs2_trusted_getxattr(const struct xattr_handler *handler,
 }
 
 static int jffs2_trusted_setxattr(const struct xattr_handler *handler,
+				  struct user_namespace *mnt_userns,
 				  struct dentry *unused, struct inode *inode,
 				  const char *name, const void *buffer,
 				  size_t size, int flags)
diff --git a/fs/jffs2/xattr_user.c b/fs/jffs2/xattr_user.c
index 9d027b4abcf9..fb945977c013 100644
--- a/fs/jffs2/xattr_user.c
+++ b/fs/jffs2/xattr_user.c
@@ -25,6 +25,7 @@ static int jffs2_user_getxattr(const struct xattr_handler *handler,
 }
 
 static int jffs2_user_setxattr(const struct xattr_handler *handler,
+			       struct user_namespace *mnt_userns,
 			       struct dentry *unused, struct inode *inode,
 			       const char *name, const void *buffer,
 			       size_t size, int flags)
diff --git a/fs/jfs/acl.c b/fs/jfs/acl.c
index 92cc0ac2d1fc..cf79a34bfada 100644
--- a/fs/jfs/acl.c
+++ b/fs/jfs/acl.c
@@ -101,7 +101,7 @@ int jfs_set_acl(struct inode *inode, struct posix_acl *acl, int type)
 	tid = txBegin(inode->i_sb, 0);
 	mutex_lock(&JFS_IP(inode)->commit_mutex);
 	if (type == ACL_TYPE_ACCESS && acl) {
-		rc = posix_acl_update_mode(inode, &mode, &acl);
+		rc = posix_acl_update_mode(&init_user_ns, inode, &mode, &acl);
 		if (rc)
 			goto end_tx;
 		if (mode != inode->i_mode)
diff --git a/fs/jfs/file.c b/fs/jfs/file.c
index ff49876e9c9b..61c3b0c1fbf6 100644
--- a/fs/jfs/file.c
+++ b/fs/jfs/file.c
@@ -122,7 +122,7 @@ int jfs_setattr(struct dentry *dentry, struct iattr *iattr)
 	mark_inode_dirty(inode);
 
 	if (iattr->ia_valid & ATTR_MODE)
-		rc = posix_acl_chmod(inode, inode->i_mode);
+		rc = posix_acl_chmod(&init_user_ns, inode, inode->i_mode);
 	return rc;
 }
 
diff --git a/fs/jfs/xattr.c b/fs/jfs/xattr.c
index db41e7803163..f9273f6901c8 100644
--- a/fs/jfs/xattr.c
+++ b/fs/jfs/xattr.c
@@ -932,6 +932,7 @@ static int jfs_xattr_get(const struct xattr_handler *handler,
 }
 
 static int jfs_xattr_set(const struct xattr_handler *handler,
+			 struct user_namespace *mnt_userns,
 			 struct dentry *unused, struct inode *inode,
 			 const char *name, const void *value,
 			 size_t size, int flags)
@@ -950,6 +951,7 @@ static int jfs_xattr_get_os2(const struct xattr_handler *handler,
 }
 
 static int jfs_xattr_set_os2(const struct xattr_handler *handler,
+			     struct user_namespace *mnt_userns,
 			     struct dentry *unused, struct inode *inode,
 			     const char *name, const void *value,
 			     size_t size, int flags)
diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
index 86bd4c593b78..7e44052b42e1 100644
--- a/fs/kernfs/inode.c
+++ b/fs/kernfs/inode.c
@@ -319,6 +319,7 @@ static int kernfs_vfs_xattr_get(const struct xattr_handler *handler,
 }
 
 static int kernfs_vfs_xattr_set(const struct xattr_handler *handler,
+				struct user_namespace *mnt_userns,
 				struct dentry *unused, struct inode *inode,
 				const char *suffix, const void *value,
 				size_t size, int flags)
@@ -385,6 +386,7 @@ static int kernfs_vfs_user_xattr_rm(struct kernfs_node *kn,
 }
 
 static int kernfs_vfs_user_xattr_set(const struct xattr_handler *handler,
+				     struct user_namespace *mnt_userns,
 				     struct dentry *unused, struct inode *inode,
 				     const char *suffix, const void *value,
 				     size_t size, int flags)
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 2f4679a62712..a07530cf673d 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -7491,6 +7491,7 @@ nfs4_release_lockowner(struct nfs_server *server, struct nfs4_lock_state *lsp)
 #define XATTR_NAME_NFSV4_ACL "system.nfs4_acl"
 
 static int nfs4_xattr_set_nfs4_acl(const struct xattr_handler *handler,
+				   struct user_namespace *mnt_userns,
 				   struct dentry *unused, struct inode *inode,
 				   const char *key, const void *buf,
 				   size_t buflen, int flags)
@@ -7513,6 +7514,7 @@ static bool nfs4_xattr_list_nfs4_acl(struct dentry *dentry)
 #ifdef CONFIG_NFS_V4_SECURITY_LABEL
 
 static int nfs4_xattr_set_nfs4_label(const struct xattr_handler *handler,
+				     struct user_namespace *mnt_userns,
 				     struct dentry *unused, struct inode *inode,
 				     const char *key, const void *buf,
 				     size_t buflen, int flags)
@@ -7563,6 +7565,7 @@ nfs4_listxattr_nfs4_label(struct inode *inode, char *list, size_t list_len)
 
 #ifdef CONFIG_NFS_V4_2
 static int nfs4_xattr_set_nfs4_user(const struct xattr_handler *handler,
+				    struct user_namespace *mnt_userns,
 				    struct dentry *unused, struct inode *inode,
 				    const char *key, const void *buf,
 				    size_t buflen, int flags)
diff --git a/fs/nfsd/nfs2acl.c b/fs/nfsd/nfs2acl.c
index b0f66604532a..b83f222558e3 100644
--- a/fs/nfsd/nfs2acl.c
+++ b/fs/nfsd/nfs2acl.c
@@ -113,10 +113,12 @@ static __be32 nfsacld_proc_setacl(struct svc_rqst *rqstp)
 
 	fh_lock(fh);
 
-	error = set_posix_acl(inode, ACL_TYPE_ACCESS, argp->acl_access);
+	error = set_posix_acl(&init_user_ns, inode, ACL_TYPE_ACCESS,
+			      argp->acl_access);
 	if (error)
 		goto out_drop_lock;
-	error = set_posix_acl(inode, ACL_TYPE_DEFAULT, argp->acl_default);
+	error = set_posix_acl(&init_user_ns, inode, ACL_TYPE_DEFAULT,
+			      argp->acl_default);
 	if (error)
 		goto out_drop_lock;
 
diff --git a/fs/nfsd/nfs3acl.c b/fs/nfsd/nfs3acl.c
index 7c30876a31a1..f18ec7e8094d 100644
--- a/fs/nfsd/nfs3acl.c
+++ b/fs/nfsd/nfs3acl.c
@@ -103,10 +103,12 @@ static __be32 nfsd3_proc_setacl(struct svc_rqst *rqstp)
 
 	fh_lock(fh);
 
-	error = set_posix_acl(inode, ACL_TYPE_ACCESS, argp->acl_access);
+	error = set_posix_acl(&init_user_ns, inode, ACL_TYPE_ACCESS,
+			      argp->acl_access);
 	if (error)
 		goto out_drop_lock;
-	error = set_posix_acl(inode, ACL_TYPE_DEFAULT, argp->acl_default);
+	error = set_posix_acl(&init_user_ns, inode, ACL_TYPE_DEFAULT,
+			      argp->acl_default);
 
 out_drop_lock:
 	fh_unlock(fh);
diff --git a/fs/nfsd/nfs4acl.c b/fs/nfsd/nfs4acl.c
index 71292a0d6f09..eaa3a0cf38f1 100644
--- a/fs/nfsd/nfs4acl.c
+++ b/fs/nfsd/nfs4acl.c
@@ -781,12 +781,13 @@ nfsd4_set_nfs4_acl(struct svc_rqst *rqstp, struct svc_fh *fhp,
 
 	fh_lock(fhp);
 
-	host_error = set_posix_acl(inode, ACL_TYPE_ACCESS, pacl);
+	host_error = set_posix_acl(&init_user_ns, inode, ACL_TYPE_ACCESS, pacl);
 	if (host_error < 0)
 		goto out_drop_lock;
 
 	if (S_ISDIR(inode->i_mode)) {
-		host_error = set_posix_acl(inode, ACL_TYPE_DEFAULT, dpacl);
+		host_error = set_posix_acl(&init_user_ns, inode,
+					   ACL_TYPE_DEFAULT, dpacl);
 	}
 
 out_drop_lock:
diff --git a/fs/ocfs2/acl.c b/fs/ocfs2/acl.c
index 7b07f5df3a29..990756cee4bd 100644
--- a/fs/ocfs2/acl.c
+++ b/fs/ocfs2/acl.c
@@ -274,7 +274,8 @@ int ocfs2_iop_set_acl(struct inode *inode, struct posix_acl *acl, int type)
 	if (type == ACL_TYPE_ACCESS && acl) {
 		umode_t mode;
 
-		status = posix_acl_update_mode(inode, &mode, &acl);
+		status = posix_acl_update_mode(&init_user_ns, inode, &mode,
+					       &acl);
 		if (status)
 			goto unlock;
 
diff --git a/fs/ocfs2/xattr.c b/fs/ocfs2/xattr.c
index 9ccd19d8f7b1..36ae47a4aef6 100644
--- a/fs/ocfs2/xattr.c
+++ b/fs/ocfs2/xattr.c
@@ -7249,6 +7249,7 @@ static int ocfs2_xattr_security_get(const struct xattr_handler *handler,
 }
 
 static int ocfs2_xattr_security_set(const struct xattr_handler *handler,
+				    struct user_namespace *mnt_userns,
 				    struct dentry *unused, struct inode *inode,
 				    const char *name, const void *value,
 				    size_t size, int flags)
@@ -7321,6 +7322,7 @@ static int ocfs2_xattr_trusted_get(const struct xattr_handler *handler,
 }
 
 static int ocfs2_xattr_trusted_set(const struct xattr_handler *handler,
+				   struct user_namespace *mnt_userns,
 				   struct dentry *unused, struct inode *inode,
 				   const char *name, const void *value,
 				   size_t size, int flags)
@@ -7351,6 +7353,7 @@ static int ocfs2_xattr_user_get(const struct xattr_handler *handler,
 }
 
 static int ocfs2_xattr_user_set(const struct xattr_handler *handler,
+				struct user_namespace *mnt_userns,
 				struct dentry *unused, struct inode *inode,
 				const char *name, const void *value,
 				size_t size, int flags)
diff --git a/fs/orangefs/acl.c b/fs/orangefs/acl.c
index a25e6c890975..628921952d16 100644
--- a/fs/orangefs/acl.c
+++ b/fs/orangefs/acl.c
@@ -132,7 +132,8 @@ int orangefs_set_acl(struct inode *inode, struct posix_acl *acl, int type)
 		 * and "mode" to the new desired value. It is up to
 		 * us to propagate the new mode back to the server...
 		 */
-		error = posix_acl_update_mode(inode, &iattr.ia_mode, &acl);
+		error = posix_acl_update_mode(&init_user_ns, inode,
+					      &iattr.ia_mode, &acl);
 		if (error) {
 			gossip_err("%s: posix_acl_update_mode err: %d\n",
 				   __func__,
diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index 8ac9491ceb9a..563fe9ab8eb2 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -861,7 +861,7 @@ int __orangefs_setattr(struct inode *inode, struct iattr *iattr)
 
 	if (iattr->ia_valid & ATTR_MODE)
 		/* change mod on a file that has ACLs */
-		ret = posix_acl_chmod(inode, inode->i_mode);
+		ret = posix_acl_chmod(&init_user_ns, inode, inode->i_mode);
 
 	ret = 0;
 out:
diff --git a/fs/orangefs/xattr.c b/fs/orangefs/xattr.c
index bdc285aea360..9a5b757fbd2f 100644
--- a/fs/orangefs/xattr.c
+++ b/fs/orangefs/xattr.c
@@ -526,6 +526,7 @@ ssize_t orangefs_listxattr(struct dentry *dentry, char *buffer, size_t size)
 }
 
 static int orangefs_xattr_set_default(const struct xattr_handler *handler,
+				      struct user_namespace *mnt_userns,
 				      struct dentry *unused,
 				      struct inode *inode,
 				      const char *name,
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 39b2e9aa0e5b..e24c995c5fd4 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -980,6 +980,7 @@ ovl_posix_acl_xattr_get(const struct xattr_handler *handler,
 
 static int __maybe_unused
 ovl_posix_acl_xattr_set(const struct xattr_handler *handler,
+			struct user_namespace *mnt_userns,
 			struct dentry *dentry, struct inode *inode,
 			const char *name, const void *value,
 			size_t size, int flags)
@@ -1044,6 +1045,7 @@ static int ovl_own_xattr_get(const struct xattr_handler *handler,
 }
 
 static int ovl_own_xattr_set(const struct xattr_handler *handler,
+			     struct user_namespace *mnt_userns,
 			     struct dentry *dentry, struct inode *inode,
 			     const char *name, const void *value,
 			     size_t size, int flags)
@@ -1059,6 +1061,7 @@ static int ovl_other_xattr_get(const struct xattr_handler *handler,
 }
 
 static int ovl_other_xattr_set(const struct xattr_handler *handler,
+			       struct user_namespace *mnt_userns,
 			       struct dentry *dentry, struct inode *inode,
 			       const char *name, const void *value,
 			       size_t size, int flags)
diff --git a/fs/posix_acl.c b/fs/posix_acl.c
index 9ce8214bfdac..d31b60f5d40d 100644
--- a/fs/posix_acl.c
+++ b/fs/posix_acl.c
@@ -558,8 +558,22 @@ __posix_acl_chmod(struct posix_acl **acl, gfp_t gfp, umode_t mode)
 }
 EXPORT_SYMBOL(__posix_acl_chmod);
 
+/**
+ * posix_acl_chmod - chmod a posix acl
+ *
+ * @mnt_userns:	user namespace of the mount @inode was found from
+ * @inode:	inode to check permissions on
+ * @mode:	the new mode of @inode
+ *
+ * If the inode has been found through an idmapped mount the user namespace of
+ * the vfsmount must be passed through @mnt_userns. This function will then
+ * take care to map the inode according to @mnt_userns before checking
+ * permissions. On non-idmapped mounts or if permission checking is to be
+ * performed on the raw inode simply passs init_user_ns.
+ */
 int
-posix_acl_chmod(struct inode *inode, umode_t mode)
+ posix_acl_chmod(struct user_namespace *mnt_userns, struct inode *inode,
+		    umode_t mode)
 {
 	struct posix_acl *acl;
 	int ret = 0;
@@ -638,9 +652,10 @@ EXPORT_SYMBOL_GPL(posix_acl_create);
 
 /**
  * posix_acl_update_mode  -  update mode in set_acl
- * @inode: target inode
- * @mode_p: mode (pointer) for update
- * @acl: acl pointer
+ * @mnt_userns:	user namespace of the mount @inode was found from
+ * @inode:	target inode
+ * @mode_p:	mode (pointer) for update
+ * @acl:	acl pointer
  *
  * Update the file mode when setting an ACL: compute the new file permission
  * bits based on the ACL.  In addition, if the ACL is equivalent to the new
@@ -649,9 +664,16 @@ EXPORT_SYMBOL_GPL(posix_acl_create);
  * As with chmod, clear the setgid bit if the caller is not in the owning group
  * or capable of CAP_FSETID (see inode_change_ok).
  *
+ * If the inode has been found through an idmapped mount the user namespace of
+ * the vfsmount must be passed through @mnt_userns. This function will then
+ * take care to map the inode according to @mnt_userns before checking
+ * permissions. On non-idmapped mounts or if permission checking is to be
+ * performed on the raw inode simply passs init_user_ns.
+ *
  * Called from set_acl inode operations.
  */
-int posix_acl_update_mode(struct inode *inode, umode_t *mode_p,
+int posix_acl_update_mode(struct user_namespace *mnt_userns,
+			  struct inode *inode, umode_t *mode_p,
 			  struct posix_acl **acl)
 {
 	umode_t mode = inode->i_mode;
@@ -662,8 +684,8 @@ int posix_acl_update_mode(struct inode *inode, umode_t *mode_p,
 		return error;
 	if (error == 0)
 		*acl = NULL;
-	if (!in_group_p(inode->i_gid) &&
-	    !capable_wrt_inode_uidgid(&init_user_ns, inode, CAP_FSETID))
+	if (!in_group_p(i_gid_into_mnt(mnt_userns, inode)) &&
+	    !capable_wrt_inode_uidgid(mnt_userns, inode, CAP_FSETID))
 		mode &= ~S_ISGID;
 	*mode_p = mode;
 	return 0;
@@ -675,7 +697,8 @@ EXPORT_SYMBOL(posix_acl_update_mode);
  */
 static void posix_acl_fix_xattr_userns(
 	struct user_namespace *to, struct user_namespace *from,
-	void *value, size_t size)
+	struct user_namespace *mnt_userns,
+	void *value, size_t size, bool from_user)
 {
 	struct posix_acl_xattr_header *header = value;
 	struct posix_acl_xattr_entry *entry = (void *)(header + 1), *end;
@@ -700,10 +723,18 @@ static void posix_acl_fix_xattr_userns(
 		switch(le16_to_cpu(entry->e_tag)) {
 		case ACL_USER:
 			uid = make_kuid(from, le32_to_cpu(entry->e_id));
+			if (from_user)
+				uid = kuid_from_mnt(mnt_userns, uid);
+			else
+				uid = kuid_into_mnt(mnt_userns, uid);
 			entry->e_id = cpu_to_le32(from_kuid(to, uid));
 			break;
 		case ACL_GROUP:
 			gid = make_kgid(from, le32_to_cpu(entry->e_id));
+			if (from_user)
+				gid = kgid_from_mnt(mnt_userns, gid);
+			else
+				gid = kgid_into_mnt(mnt_userns, gid);
 			entry->e_id = cpu_to_le32(from_kgid(to, gid));
 			break;
 		default:
@@ -712,20 +743,24 @@ static void posix_acl_fix_xattr_userns(
 	}
 }
 
-void posix_acl_fix_xattr_from_user(void *value, size_t size)
+void posix_acl_fix_xattr_from_user(struct user_namespace *mnt_userns,
+				   void *value, size_t size)
 {
 	struct user_namespace *user_ns = current_user_ns();
-	if (user_ns == &init_user_ns)
+	if ((user_ns == &init_user_ns) && (mnt_userns == &init_user_ns))
 		return;
-	posix_acl_fix_xattr_userns(&init_user_ns, user_ns, value, size);
+	posix_acl_fix_xattr_userns(&init_user_ns, user_ns, mnt_userns, value,
+				   size, true);
 }
 
-void posix_acl_fix_xattr_to_user(void *value, size_t size)
+void posix_acl_fix_xattr_to_user(struct user_namespace *mnt_userns,
+				 void *value, size_t size)
 {
 	struct user_namespace *user_ns = current_user_ns();
-	if (user_ns == &init_user_ns)
+	if ((user_ns == &init_user_ns) && (mnt_userns == &init_user_ns))
 		return;
-	posix_acl_fix_xattr_userns(user_ns, &init_user_ns, value, size);
+	posix_acl_fix_xattr_userns(user_ns, &init_user_ns, mnt_userns, value,
+				   size, false);
 }
 
 /*
@@ -865,7 +900,8 @@ posix_acl_xattr_get(const struct xattr_handler *handler,
 }
 
 int
-set_posix_acl(struct inode *inode, int type, struct posix_acl *acl)
+set_posix_acl(struct user_namespace *mnt_userns, struct inode *inode,
+	      int type, struct posix_acl *acl)
 {
 	if (!IS_POSIXACL(inode))
 		return -EOPNOTSUPP;
@@ -874,7 +910,7 @@ set_posix_acl(struct inode *inode, int type, struct posix_acl *acl)
 
 	if (type == ACL_TYPE_DEFAULT && !S_ISDIR(inode->i_mode))
 		return acl ? -EACCES : 0;
-	if (!inode_owner_or_capable(&init_user_ns, inode))
+	if (!inode_owner_or_capable(mnt_userns, inode))
 		return -EPERM;
 
 	if (acl) {
@@ -888,9 +924,10 @@ EXPORT_SYMBOL(set_posix_acl);
 
 static int
 posix_acl_xattr_set(const struct xattr_handler *handler,
-		    struct dentry *unused, struct inode *inode,
-		    const char *name, const void *value,
-		    size_t size, int flags)
+			   struct user_namespace *mnt_userns,
+			   struct dentry *unused, struct inode *inode,
+			   const char *name, const void *value, size_t size,
+			   int flags)
 {
 	struct posix_acl *acl = NULL;
 	int ret;
@@ -900,7 +937,7 @@ posix_acl_xattr_set(const struct xattr_handler *handler,
 		if (IS_ERR(acl))
 			return PTR_ERR(acl);
 	}
-	ret = set_posix_acl(inode, handler->flags, acl);
+	ret = set_posix_acl(mnt_userns, inode, handler->flags, acl);
 	posix_acl_release(acl);
 	return ret;
 }
@@ -934,7 +971,7 @@ int simple_set_acl(struct inode *inode, struct posix_acl *acl, int type)
 	int error;
 
 	if (type == ACL_TYPE_ACCESS) {
-		error = posix_acl_update_mode(inode,
+		error = posix_acl_update_mode(&init_user_ns, inode,
 				&inode->i_mode, &acl);
 		if (error)
 			return error;
diff --git a/fs/reiserfs/xattr_acl.c b/fs/reiserfs/xattr_acl.c
index ccd40df6eb45..4bf976bc7bad 100644
--- a/fs/reiserfs/xattr_acl.c
+++ b/fs/reiserfs/xattr_acl.c
@@ -40,7 +40,8 @@ reiserfs_set_acl(struct inode *inode, struct posix_acl *acl, int type)
 	reiserfs_write_unlock(inode->i_sb);
 	if (error == 0) {
 		if (type == ACL_TYPE_ACCESS && acl) {
-			error = posix_acl_update_mode(inode, &mode, &acl);
+			error = posix_acl_update_mode(&init_user_ns, inode,
+						      &mode, &acl);
 			if (error)
 				goto unlock;
 			update_mode = 1;
@@ -399,5 +400,5 @@ int reiserfs_acl_chmod(struct inode *inode)
 	    !reiserfs_posixacl(inode->i_sb))
 		return 0;
 
-	return posix_acl_chmod(inode, inode->i_mode);
+	return posix_acl_chmod(&init_user_ns, inode, inode->i_mode);
 }
diff --git a/fs/reiserfs/xattr_security.c b/fs/reiserfs/xattr_security.c
index 20be9a0e5870..8965c8e5e172 100644
--- a/fs/reiserfs/xattr_security.c
+++ b/fs/reiserfs/xattr_security.c
@@ -21,7 +21,8 @@ security_get(const struct xattr_handler *handler, struct dentry *unused,
 }
 
 static int
-security_set(const struct xattr_handler *handler, struct dentry *unused,
+security_set(const struct xattr_handler *handler,
+	     struct user_namespace *mnt_userns, struct dentry *unused,
 	     struct inode *inode, const char *name, const void *buffer,
 	     size_t size, int flags)
 {
diff --git a/fs/reiserfs/xattr_trusted.c b/fs/reiserfs/xattr_trusted.c
index 5ed48da3d02b..d853cea2afcd 100644
--- a/fs/reiserfs/xattr_trusted.c
+++ b/fs/reiserfs/xattr_trusted.c
@@ -20,7 +20,8 @@ trusted_get(const struct xattr_handler *handler, struct dentry *unused,
 }
 
 static int
-trusted_set(const struct xattr_handler *handler, struct dentry *unused,
+trusted_set(const struct xattr_handler *handler,
+	    struct user_namespace *mnt_userns, struct dentry *unused,
 	    struct inode *inode, const char *name, const void *buffer,
 	    size_t size, int flags)
 {
diff --git a/fs/reiserfs/xattr_user.c b/fs/reiserfs/xattr_user.c
index a573ca45bacc..65d9cd10a5ea 100644
--- a/fs/reiserfs/xattr_user.c
+++ b/fs/reiserfs/xattr_user.c
@@ -18,7 +18,8 @@ user_get(const struct xattr_handler *handler, struct dentry *unused,
 }
 
 static int
-user_set(const struct xattr_handler *handler, struct dentry *unused,
+user_set(const struct xattr_handler *handler, struct user_namespace *mnt_userns,
+	 struct dentry *unused,
 	 struct inode *inode, const char *name, const void *buffer,
 	 size_t size, int flags)
 {
diff --git a/fs/ubifs/xattr.c b/fs/ubifs/xattr.c
index a0b9b349efe6..8f4135c22ab6 100644
--- a/fs/ubifs/xattr.c
+++ b/fs/ubifs/xattr.c
@@ -681,6 +681,7 @@ static int xattr_get(const struct xattr_handler *handler,
 }
 
 static int xattr_set(const struct xattr_handler *handler,
+			   struct user_namespace *mnt_userns,
 			   struct dentry *dentry, struct inode *inode,
 			   const char *name, const void *value,
 			   size_t size, int flags)
diff --git a/fs/xattr.c b/fs/xattr.c
index c669922e1bde..d777025121e0 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -175,7 +175,8 @@ __vfs_setxattr(struct dentry *dentry, struct inode *inode, const char *name,
 		return -EOPNOTSUPP;
 	if (size == 0)
 		value = "";  /* empty EA, do not remove */
-	return handler->set(handler, dentry, inode, name, value, size, flags);
+	return handler->set(handler, &init_user_ns, dentry, inode, name, value,
+			    size, flags);
 }
 EXPORT_SYMBOL(__vfs_setxattr);
 
@@ -281,7 +282,7 @@ vfs_setxattr(struct dentry *dentry, const char *name, const void *value,
 	int error;
 
 	if (size && strcmp(name, XATTR_NAME_CAPS) == 0) {
-		error = cap_convert_nscap(dentry, &value, size);
+		error = cap_convert_nscap(&init_user_ns, dentry, &value, size);
 		if (error < 0)
 			return error;
 		size = error;
@@ -450,7 +451,8 @@ __vfs_removexattr(struct dentry *dentry, const char *name)
 		return PTR_ERR(handler);
 	if (!handler->set)
 		return -EOPNOTSUPP;
-	return handler->set(handler, dentry, inode, name, NULL, 0, XATTR_REPLACE);
+	return handler->set(handler, &init_user_ns, dentry, inode, name, NULL,
+			    0, XATTR_REPLACE);
 }
 EXPORT_SYMBOL(__vfs_removexattr);
 
@@ -548,7 +550,8 @@ setxattr(struct dentry *d, const char __user *name, const void __user *value,
 		}
 		if ((strcmp(kname, XATTR_NAME_POSIX_ACL_ACCESS) == 0) ||
 		    (strcmp(kname, XATTR_NAME_POSIX_ACL_DEFAULT) == 0))
-			posix_acl_fix_xattr_from_user(kvalue, size);
+			posix_acl_fix_xattr_from_user(&init_user_ns, kvalue,
+						      size);
 	}
 
 	error = vfs_setxattr(d, kname, kvalue, size, flags);
@@ -642,7 +645,8 @@ getxattr(struct dentry *d, const char __user *name, void __user *value,
 	if (error > 0) {
 		if ((strcmp(kname, XATTR_NAME_POSIX_ACL_ACCESS) == 0) ||
 		    (strcmp(kname, XATTR_NAME_POSIX_ACL_DEFAULT) == 0))
-			posix_acl_fix_xattr_to_user(kvalue, error);
+			posix_acl_fix_xattr_to_user(&init_user_ns, kvalue,
+						    error);
 		if (size && copy_to_user(value, kvalue, error))
 			error = -EFAULT;
 	} else if (error == -ERANGE && size >= XATTR_SIZE_MAX) {
diff --git a/fs/xfs/xfs_acl.c b/fs/xfs/xfs_acl.c
index 779cb73b3d00..368351298bd5 100644
--- a/fs/xfs/xfs_acl.c
+++ b/fs/xfs/xfs_acl.c
@@ -252,7 +252,8 @@ xfs_set_acl(struct inode *inode, struct posix_acl *acl, int type)
 		return error;
 
 	if (type == ACL_TYPE_ACCESS) {
-		error = posix_acl_update_mode(inode, &mode, &acl);
+		error = posix_acl_update_mode(&init_user_ns, inode, &mode,
+					      &acl);
 		if (error)
 			return error;
 		set_mode = true;
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 08a478d25122..26d22edef741 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -807,7 +807,7 @@ xfs_setattr_nonsize(
 	 * 	     Posix ACL code seems to care about this issue either.
 	 */
 	if (mask & ATTR_MODE) {
-		error = posix_acl_chmod(inode, inode->i_mode);
+		error = posix_acl_chmod(&init_user_ns, inode, inode->i_mode);
 		if (error)
 			return error;
 	}
diff --git a/fs/xfs/xfs_xattr.c b/fs/xfs/xfs_xattr.c
index bca48b308c02..12be32f66dc1 100644
--- a/fs/xfs/xfs_xattr.c
+++ b/fs/xfs/xfs_xattr.c
@@ -38,9 +38,10 @@ xfs_xattr_get(const struct xattr_handler *handler, struct dentry *unused,
 }
 
 static int
-xfs_xattr_set(const struct xattr_handler *handler, struct dentry *unused,
-		struct inode *inode, const char *name, const void *value,
-		size_t size, int flags)
+xfs_xattr_set(const struct xattr_handler *handler,
+	      struct user_namespace *mnt_userns, struct dentry *unused,
+	      struct inode *inode, const char *name, const void *value,
+	      size_t size, int flags)
 {
 	struct xfs_da_args	args = {
 		.dp		= XFS_I(inode),
diff --git a/include/linux/capability.h b/include/linux/capability.h
index 62bfa3ed84d7..da21ef118b04 100644
--- a/include/linux/capability.h
+++ b/include/linux/capability.h
@@ -273,6 +273,7 @@ static inline bool checkpoint_restore_ns_capable(struct user_namespace *ns)
 /* audit system wants to get cap info from files as well */
 extern int get_vfs_caps_from_disk(const struct dentry *dentry, struct cpu_vfs_cap_data *cpu_caps);
 
-extern int cap_convert_nscap(struct dentry *dentry, const void **ivalue, size_t size);
+int cap_convert_nscap(struct user_namespace *mnt_userns, struct dentry *dentry,
+		      const void **ivalue, size_t size);
 
 #endif /* !_LINUX_CAPABILITY_H */
diff --git a/include/linux/posix_acl.h b/include/linux/posix_acl.h
index 85fb4c0c650a..6dcd8b8f6ab5 100644
--- a/include/linux/posix_acl.h
+++ b/include/linux/posix_acl.h
@@ -69,13 +69,15 @@ extern int __posix_acl_create(struct posix_acl **, gfp_t, umode_t *);
 extern int __posix_acl_chmod(struct posix_acl **, gfp_t, umode_t);
 
 extern struct posix_acl *get_posix_acl(struct inode *, int);
-extern int set_posix_acl(struct inode *, int, struct posix_acl *);
+extern int set_posix_acl(struct user_namespace *, struct inode *, int,
+			 struct posix_acl *);
 
 #ifdef CONFIG_FS_POSIX_ACL
-extern int posix_acl_chmod(struct inode *, umode_t);
+int posix_acl_chmod(struct user_namespace *, struct inode *, umode_t);
 extern int posix_acl_create(struct inode *, umode_t *, struct posix_acl **,
 		struct posix_acl **);
-extern int posix_acl_update_mode(struct inode *, umode_t *, struct posix_acl **);
+int posix_acl_update_mode(struct user_namespace *, struct inode *, umode_t *,
+			  struct posix_acl **);
 
 extern int simple_set_acl(struct inode *, struct posix_acl *, int);
 extern int simple_acl_create(struct inode *, struct inode *);
@@ -95,7 +97,8 @@ static inline void cache_no_acl(struct inode *inode)
 	inode->i_default_acl = NULL;
 }
 #else
-static inline int posix_acl_chmod(struct inode *inode, umode_t mode)
+static inline int posix_acl_chmod(struct user_namespace *mnt_userns,
+				  struct inode *inode, umode_t mode)
 {
 	return 0;
 }
diff --git a/include/linux/posix_acl_xattr.h b/include/linux/posix_acl_xattr.h
index 2387709991b5..060e8d203181 100644
--- a/include/linux/posix_acl_xattr.h
+++ b/include/linux/posix_acl_xattr.h
@@ -33,13 +33,17 @@ posix_acl_xattr_count(size_t size)
 }
 
 #ifdef CONFIG_FS_POSIX_ACL
-void posix_acl_fix_xattr_from_user(void *value, size_t size);
-void posix_acl_fix_xattr_to_user(void *value, size_t size);
+void posix_acl_fix_xattr_from_user(struct user_namespace *mnt_userns,
+				   void *value, size_t size);
+void posix_acl_fix_xattr_to_user(struct user_namespace *mnt_userns,
+				 void *value, size_t size);
 #else
-static inline void posix_acl_fix_xattr_from_user(void *value, size_t size)
+static inline void posix_acl_fix_xattr_from_user(struct user_namespace *mnt_userns,
+						 void *value, size_t size)
 {
 }
-static inline void posix_acl_fix_xattr_to_user(void *value, size_t size)
+static inline void posix_acl_fix_xattr_to_user(struct user_namespace *mnt_userns,
+					       void *value, size_t size)
 {
 }
 #endif
diff --git a/include/linux/xattr.h b/include/linux/xattr.h
index 10b4dc2709f0..260c9bcb0edb 100644
--- a/include/linux/xattr.h
+++ b/include/linux/xattr.h
@@ -34,7 +34,8 @@ struct xattr_handler {
 	int (*get)(const struct xattr_handler *, struct dentry *dentry,
 		   struct inode *inode, const char *name, void *buffer,
 		   size_t size);
-	int (*set)(const struct xattr_handler *, struct dentry *dentry,
+	int (*set)(const struct xattr_handler *,
+		   struct user_namespace *mnt_userns, struct dentry *dentry,
 		   struct inode *inode, const char *name, const void *buffer,
 		   size_t size, int flags);
 };
diff --git a/mm/shmem.c b/mm/shmem.c
index 1cb451e131ec..23b8e9c15a42 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1143,7 +1143,7 @@ static int shmem_setattr(struct dentry *dentry, struct iattr *attr)
 
 	setattr_copy(&init_user_ns, inode, attr);
 	if (attr->ia_valid & ATTR_MODE)
-		error = posix_acl_chmod(inode, inode->i_mode);
+		error = posix_acl_chmod(&init_user_ns, inode, inode->i_mode);
 	return error;
 }
 
@@ -3273,6 +3273,7 @@ static int shmem_xattr_handler_get(const struct xattr_handler *handler,
 }
 
 static int shmem_xattr_handler_set(const struct xattr_handler *handler,
+				   struct user_namespace *mnt_userns,
 				   struct dentry *unused, struct inode *inode,
 				   const char *name, const void *value,
 				   size_t size, int flags)
diff --git a/net/socket.c b/net/socket.c
index 33e8b6c4e1d3..c76703c6f480 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -334,6 +334,7 @@ static const struct xattr_handler sockfs_xattr_handler = {
 };
 
 static int sockfs_security_xattr_set(const struct xattr_handler *handler,
+				     struct user_namespace *mnt_userns,
 				     struct dentry *dentry, struct inode *inode,
 				     const char *suffix, const void *value,
 				     size_t size, int flags)
diff --git a/security/commoncap.c b/security/commoncap.c
index 88ee345f7bfa..c3fd9b86ea9a 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -450,16 +450,33 @@ int cap_inode_getsecurity(struct inode *inode, const char *name, void **buffer,
 	return size;
 }
 
+/**
+ * rootid_from_xattr - translate root uid of vfs caps
+ *
+ * @value:	vfs caps value which may be modified by this function
+ * @size:	size of @ivalue
+ * @task_ns:	user namespace of the caller
+ * @mnt_userns:	user namespace of the mount the inode was found from
+ *
+ * If the inode has been found through an idmapped mount the user namespace of
+ * the vfsmount must be passed through @mnt_userns. This function will then
+ * take care to map the inode according to @mnt_userns before checking
+ * permissions. On non-idmapped mounts or if permission checking is to be
+ * performed on the raw inode simply passs init_user_ns.
+ */
 static kuid_t rootid_from_xattr(const void *value, size_t size,
-				struct user_namespace *task_ns)
+				struct user_namespace *task_ns,
+				struct user_namespace *mnt_userns)
 {
 	const struct vfs_ns_cap_data *nscap = value;
+	kuid_t rootkid;
 	uid_t rootid = 0;
 
 	if (size == XATTR_CAPS_SZ_3)
 		rootid = le32_to_cpu(nscap->rootid);
 
-	return make_kuid(task_ns, rootid);
+	rootkid = make_kuid(task_ns, rootid);
+	return kuid_from_mnt(mnt_userns, rootkid);
 }
 
 static bool validheader(size_t size, const struct vfs_cap_data *cap)
@@ -467,13 +484,27 @@ static bool validheader(size_t size, const struct vfs_cap_data *cap)
 	return is_v2header(size, cap) || is_v3header(size, cap);
 }
 
-/*
+/**
+ * cap_convert_nscap - check vfs caps
+ *
+ * @mnt_userns:	user namespace of the mount the inode was found from
+ * @dentry:	used to retrieve inode to check permissions on
+ * @ivalue:	vfs caps value which may be modified by this function
+ * @size:	size of @ivalue
+ *
  * User requested a write of security.capability.  If needed, update the
  * xattr to change from v2 to v3, or to fixup the v3 rootid.
  *
+ * If the inode has been found through an idmapped mount the user namespace of
+ * the vfsmount must be passed through @mnt_userns. This function will then
+ * take care to map the inode according to @mnt_userns before checking
+ * permissions. On non-idmapped mounts or if permission checking is to be
+ * performed on the raw inode simply passs init_user_ns.
+ *
  * If all is ok, we return the new size, on error return < 0.
  */
-int cap_convert_nscap(struct dentry *dentry, const void **ivalue, size_t size)
+int cap_convert_nscap(struct user_namespace *mnt_userns, struct dentry *dentry,
+		      const void **ivalue, size_t size)
 {
 	struct vfs_ns_cap_data *nscap;
 	uid_t nsrootid;
@@ -489,14 +520,14 @@ int cap_convert_nscap(struct dentry *dentry, const void **ivalue, size_t size)
 		return -EINVAL;
 	if (!validheader(size, cap))
 		return -EINVAL;
-	if (!capable_wrt_inode_uidgid(&init_user_ns, inode, CAP_SETFCAP))
+	if (!capable_wrt_inode_uidgid(mnt_userns, inode, CAP_SETFCAP))
 		return -EPERM;
-	if (size == XATTR_CAPS_SZ_2)
+	if (size == XATTR_CAPS_SZ_2 && (mnt_userns == &init_user_ns))
 		if (ns_capable(inode->i_sb->s_user_ns, CAP_SETFCAP))
 			/* user is privileged, just write the v2 */
 			return size;
 
-	rootid = rootid_from_xattr(*ivalue, size, task_ns);
+	rootid = rootid_from_xattr(*ivalue, size, task_ns, mnt_userns);
 	if (!uid_valid(rootid))
 		return -EINVAL;
 
-- 
2.30.0

