Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10FC02B33CF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Nov 2020 11:41:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbgKOKjZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 15 Nov 2020 05:39:25 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:58891 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726932AbgKOKjF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 15 Nov 2020 05:39:05 -0500
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1keFQm-0000Kt-Hd; Sun, 15 Nov 2020 10:38:48 +0000
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
Subject: [PATCH v2 12/39] acl: handle idmapped mounts
Date:   Sun, 15 Nov 2020 11:36:51 +0100
Message-Id: <20201115103718.298186-13-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201115103718.298186-1-christian.brauner@ubuntu.com>
References: <20201115103718.298186-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The posix acl permission checking helpers determine whether a caller is
privileged over an inode according to the acls associated with the inode.
Add helpers that make it possible to handle acls on idampped mounts.

The vfs and the filesystems targeted by this first iteration make use of
posix_acl_fix_xattr_from_user() and posix_acl_fix_xattr_to_user() to
translate basic posix access and default permissions such as the ACL_USER
and ACL_GROUP type according to the initial user namespace (or the
superblock's user namespace) to and from the caller's current user
namespace. Adapt these two helpers to handle idmapped mounts whereby we
either shift from or into the mount's user namespace depending on in which
direction we're translating.
Similarly, cap_convert_nscap() is used by the vfs to translate user
namespace and non-user namespace aware filesystem capabilities from the
superblock's user namespace to the caller's user namespace. Enable it to
handle idmapped mounts by accounting for the mount's user namespace.

In addition the fileystems targeted in the first iteration of this patch
series make use of the posix_acl_chmod() and, posix_acl_update_mode()
helpers. Both helpers perform permission checks on the target inode. Let
them handle idmapped mounts. These two helpers are called when posix acls
are set by the respective filesystems to handle this case we extend the
->set() method to take an additional user namespace argument to pass the
mount's user namespace down.

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
 Documentation/filesystems/locking.rst |  6 +--
 Documentation/filesystems/porting.rst |  2 +
 fs/9p/acl.c                           |  3 +-
 fs/9p/xattr.c                         |  1 +
 fs/afs/xattr.c                        |  2 +
 fs/btrfs/acl.c                        |  2 +-
 fs/btrfs/inode.c                      |  2 +-
 fs/btrfs/xattr.c                      |  2 +
 fs/ceph/acl.c                         |  2 +-
 fs/ceph/inode.c                       |  2 +-
 fs/ceph/xattr.c                       |  1 +
 fs/cifs/xattr.c                       |  1 +
 fs/ecryptfs/inode.c                   |  1 +
 fs/ext2/acl.c                         |  2 +-
 fs/ext2/inode.c                       |  2 +-
 fs/ext2/xattr_security.c              |  1 +
 fs/ext2/xattr_trusted.c               |  1 +
 fs/ext2/xattr_user.c                  |  1 +
 fs/ext4/acl.c                         |  2 +-
 fs/ext4/inode.c                       |  2 +-
 fs/ext4/xattr_hurd.c                  |  1 +
 fs/ext4/xattr_security.c              |  1 +
 fs/ext4/xattr_trusted.c               |  1 +
 fs/ext4/xattr_user.c                  |  1 +
 fs/f2fs/acl.c                         |  2 +-
 fs/f2fs/file.c                        |  2 +-
 fs/f2fs/xattr.c                       |  2 +
 fs/fuse/xattr.c                       |  2 +
 fs/gfs2/acl.c                         |  2 +-
 fs/gfs2/inode.c                       |  2 +-
 fs/gfs2/xattr.c                       |  1 +
 fs/hfs/attr.c                         |  1 +
 fs/hfsplus/xattr.c                    |  1 +
 fs/hfsplus/xattr_security.c           |  1 +
 fs/hfsplus/xattr_trusted.c            |  1 +
 fs/hfsplus/xattr_user.c               |  1 +
 fs/jffs2/acl.c                        |  2 +-
 fs/jffs2/fs.c                         |  2 +-
 fs/jffs2/security.c                   |  1 +
 fs/jffs2/xattr_trusted.c              |  1 +
 fs/jffs2/xattr_user.c                 |  1 +
 fs/jfs/acl.c                          |  2 +-
 fs/jfs/file.c                         |  2 +-
 fs/jfs/xattr.c                        |  2 +
 fs/kernfs/inode.c                     |  2 +
 fs/nfs/nfs4proc.c                     |  3 ++
 fs/nfsd/nfs2acl.c                     |  4 +-
 fs/nfsd/nfs3acl.c                     |  4 +-
 fs/nfsd/nfs4acl.c                     |  4 +-
 fs/ocfs2/acl.c                        |  2 +-
 fs/ocfs2/xattr.c                      |  3 ++
 fs/orangefs/acl.c                     |  2 +-
 fs/orangefs/inode.c                   |  2 +-
 fs/orangefs/xattr.c                   |  1 +
 fs/overlayfs/super.c                  |  3 ++
 fs/posix_acl.c                        | 54 +++++++++++++++++----------
 fs/reiserfs/xattr_acl.c               |  4 +-
 fs/reiserfs/xattr_security.c          |  3 +-
 fs/reiserfs/xattr_trusted.c           |  3 +-
 fs/reiserfs/xattr_user.c              |  3 +-
 fs/ubifs/xattr.c                      |  1 +
 fs/xattr.c                            | 10 ++---
 fs/xfs/xfs_acl.c                      |  2 +-
 fs/xfs/xfs_iops.c                     |  2 +-
 fs/xfs/xfs_xattr.c                    |  3 +-
 include/linux/capability.h            |  3 +-
 include/linux/posix_acl.h             |  9 +++--
 include/linux/posix_acl_xattr.h       | 12 ++++--
 include/linux/xattr.h                 |  6 +--
 mm/shmem.c                            |  3 +-
 net/socket.c                          |  1 +
 security/commoncap.c                  | 17 ++++++---
 72 files changed, 159 insertions(+), 80 deletions(-)

diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
index c0f2c7586531..e3b33c59b7f6 100644
--- a/Documentation/filesystems/locking.rst
+++ b/Documentation/filesystems/locking.rst
@@ -126,9 +126,9 @@ prototypes::
 	int (*get)(const struct xattr_handler *handler, struct dentry *dentry,
 		   struct inode *inode, const char *name, void *buffer,
 		   size_t size);
-	int (*set)(const struct xattr_handler *handler, struct dentry *dentry,
-		   struct inode *inode, const char *name, const void *buffer,
-		   size_t size, int flags);
+	int (*set)(const struct xattr_handler *handler, struct user_namespace *user_ns,
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
index d77b28e8d57a..650b14dd3ccd 100644
--- a/fs/9p/acl.c
+++ b/fs/9p/acl.c
@@ -239,6 +239,7 @@ static int v9fs_xattr_get_acl(const struct xattr_handler *handler,
 }
 
 static int v9fs_xattr_set_acl(const struct xattr_handler *handler,
+			      struct user_namespace *user_ns,
 			      struct dentry *dentry, struct inode *inode,
 			      const char *name, const void *value,
 			      size_t size, int flags)
@@ -279,7 +280,7 @@ static int v9fs_xattr_set_acl(const struct xattr_handler *handler,
 			struct iattr iattr = { 0 };
 			struct posix_acl *old_acl = acl;
 
-			retval = posix_acl_update_mode(inode, &iattr.ia_mode, &acl);
+			retval = posix_acl_update_mode(user_ns, inode, &iattr.ia_mode, &acl);
 			if (retval)
 				goto err_out;
 			if (!acl) {
diff --git a/fs/9p/xattr.c b/fs/9p/xattr.c
index ac8ff8ca4c11..13d8cb1712d6 100644
--- a/fs/9p/xattr.c
+++ b/fs/9p/xattr.c
@@ -147,6 +147,7 @@ static int v9fs_xattr_handler_get(const struct xattr_handler *handler,
 }
 
 static int v9fs_xattr_handler_set(const struct xattr_handler *handler,
+				  struct user_namespace *user_ns,
 				  struct dentry *dentry, struct inode *inode,
 				  const char *name, const void *value,
 				  size_t size, int flags)
diff --git a/fs/afs/xattr.c b/fs/afs/xattr.c
index 38884d6c57cd..e8217f020970 100644
--- a/fs/afs/xattr.c
+++ b/fs/afs/xattr.c
@@ -120,6 +120,7 @@ static const struct afs_operation_ops afs_store_acl_operation = {
  * Set a file's AFS3 ACL.
  */
 static int afs_xattr_set_acl(const struct xattr_handler *handler,
+			     struct user_namespace *user_ns,
                              struct dentry *dentry,
                              struct inode *inode, const char *name,
                              const void *buffer, size_t size, int flags)
@@ -253,6 +254,7 @@ static const struct afs_operation_ops yfs_store_opaque_acl2_operation = {
  * Set a file's YFS ACL.
  */
 static int afs_xattr_set_yfs(const struct xattr_handler *handler,
+			     struct user_namespace *user_ns,
                              struct dentry *dentry,
                              struct inode *inode, const char *name,
                              const void *buffer, size_t size, int flags)
diff --git a/fs/btrfs/acl.c b/fs/btrfs/acl.c
index a0af1b952c4d..b5a683e895c6 100644
--- a/fs/btrfs/acl.c
+++ b/fs/btrfs/acl.c
@@ -113,7 +113,7 @@ int btrfs_set_acl(struct inode *inode, struct posix_acl *acl, int type)
 	umode_t old_mode = inode->i_mode;
 
 	if (type == ACL_TYPE_ACCESS && acl) {
-		ret = posix_acl_update_mode(inode, &inode->i_mode, &acl);
+		ret = posix_acl_update_mode(&init_user_ns, inode, &inode->i_mode, &acl);
 		if (ret)
 			return ret;
 	}
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index e65c54b7e828..e6f4aed0d311 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4891,7 +4891,7 @@ static int btrfs_setattr(struct dentry *dentry, struct iattr *attr)
 		err = btrfs_dirty_inode(inode);
 
 		if (!err && attr->ia_valid & ATTR_MODE)
-			err = posix_acl_chmod(inode, inode->i_mode);
+			err = posix_acl_chmod(&init_user_ns, inode, inode->i_mode);
 	}
 
 	return err;
diff --git a/fs/btrfs/xattr.c b/fs/btrfs/xattr.c
index 95d9aebff2c4..a6adb9decdfc 100644
--- a/fs/btrfs/xattr.c
+++ b/fs/btrfs/xattr.c
@@ -360,6 +360,7 @@ static int btrfs_xattr_handler_get(const struct xattr_handler *handler,
 }
 
 static int btrfs_xattr_handler_set(const struct xattr_handler *handler,
+				   struct user_namespace *user_ns,
 				   struct dentry *unused, struct inode *inode,
 				   const char *name, const void *buffer,
 				   size_t size, int flags)
@@ -369,6 +370,7 @@ static int btrfs_xattr_handler_set(const struct xattr_handler *handler,
 }
 
 static int btrfs_xattr_handler_set_prop(const struct xattr_handler *handler,
+					struct user_namespace *user_ns,
 					struct dentry *unused, struct inode *inode,
 					const char *name, const void *value,
 					size_t size, int flags)
diff --git a/fs/ceph/acl.c b/fs/ceph/acl.c
index e0465741c591..bceab4c01585 100644
--- a/fs/ceph/acl.c
+++ b/fs/ceph/acl.c
@@ -100,7 +100,7 @@ int ceph_set_acl(struct inode *inode, struct posix_acl *acl, int type)
 	case ACL_TYPE_ACCESS:
 		name = XATTR_NAME_POSIX_ACL_ACCESS;
 		if (acl) {
-			ret = posix_acl_update_mode(inode, &new_mode, &acl);
+			ret = posix_acl_update_mode(&init_user_ns, inode, &new_mode, &acl);
 			if (ret)
 				goto out;
 		}
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 06645c2efa6f..19ec845ba5ec 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -2266,7 +2266,7 @@ int ceph_setattr(struct dentry *dentry, struct iattr *attr)
 	err = __ceph_setattr(inode, attr);
 
 	if (err >= 0 && (attr->ia_valid & ATTR_MODE))
-		err = posix_acl_chmod(inode, attr->ia_mode);
+		err = posix_acl_chmod(&init_user_ns, inode, attr->ia_mode);
 
 	return err;
 }
diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
index 197cb1234341..a01e0563049a 100644
--- a/fs/ceph/xattr.c
+++ b/fs/ceph/xattr.c
@@ -1163,6 +1163,7 @@ static int ceph_get_xattr_handler(const struct xattr_handler *handler,
 }
 
 static int ceph_set_xattr_handler(const struct xattr_handler *handler,
+				  struct user_namespace *user_ns,
 				  struct dentry *unused, struct inode *inode,
 				  const char *name, const void *value,
 				  size_t size, int flags)
diff --git a/fs/cifs/xattr.c b/fs/cifs/xattr.c
index b8299173ea7e..33935bd038aa 100644
--- a/fs/cifs/xattr.c
+++ b/fs/cifs/xattr.c
@@ -99,6 +99,7 @@ static int cifs_creation_time_set(unsigned int xid, struct cifs_tcon *pTcon,
 }
 
 static int cifs_xattr_set(const struct xattr_handler *handler,
+			  struct user_namespace *user_ns,
 			  struct dentry *dentry, struct inode *inode,
 			  const char *name, const void *value,
 			  size_t size, int flags)
diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index 2454aef02a68..28cf830f0a4d 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -1131,6 +1131,7 @@ static int ecryptfs_xattr_get(const struct xattr_handler *handler,
 }
 
 static int ecryptfs_xattr_set(const struct xattr_handler *handler,
+			      struct user_namespace *user_ns,
 			      struct dentry *dentry, struct inode *inode,
 			      const char *name, const void *value, size_t size,
 			      int flags)
diff --git a/fs/ext2/acl.c b/fs/ext2/acl.c
index cf4c77f8dd08..826987b23ccb 100644
--- a/fs/ext2/acl.c
+++ b/fs/ext2/acl.c
@@ -223,7 +223,7 @@ ext2_set_acl(struct inode *inode, struct posix_acl *acl, int type)
 	umode_t mode = inode->i_mode;
 
 	if (type == ACL_TYPE_ACCESS && acl) {
-		error = posix_acl_update_mode(inode, &mode, &acl);
+		error = posix_acl_update_mode(&init_user_ns, inode, &mode, &acl);
 		if (error)
 			return error;
 		update_mode = 1;
diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
index 8eccb67d04b2..5ff1e5e3c0fe 100644
--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -1690,7 +1690,7 @@ int ext2_setattr(struct dentry *dentry, struct iattr *iattr)
 	}
 	setattr_copy(&init_user_ns, inode, iattr);
 	if (iattr->ia_valid & ATTR_MODE)
-		error = posix_acl_chmod(inode, inode->i_mode);
+		error = posix_acl_chmod(&init_user_ns, inode, inode->i_mode);
 	mark_inode_dirty(inode);
 
 	return error;
diff --git a/fs/ext2/xattr_security.c b/fs/ext2/xattr_security.c
index 9a682e440acb..f536f656b1dd 100644
--- a/fs/ext2/xattr_security.c
+++ b/fs/ext2/xattr_security.c
@@ -19,6 +19,7 @@ ext2_xattr_security_get(const struct xattr_handler *handler,
 
 static int
 ext2_xattr_security_set(const struct xattr_handler *handler,
+			struct user_namespace *user_ns,
 			struct dentry *unused, struct inode *inode,
 			const char *name, const void *value,
 			size_t size, int flags)
diff --git a/fs/ext2/xattr_trusted.c b/fs/ext2/xattr_trusted.c
index 49add1107850..2a20108a8253 100644
--- a/fs/ext2/xattr_trusted.c
+++ b/fs/ext2/xattr_trusted.c
@@ -26,6 +26,7 @@ ext2_xattr_trusted_get(const struct xattr_handler *handler,
 
 static int
 ext2_xattr_trusted_set(const struct xattr_handler *handler,
+		       struct user_namespace *user_ns,
 		       struct dentry *unused, struct inode *inode,
 		       const char *name, const void *value,
 		       size_t size, int flags)
diff --git a/fs/ext2/xattr_user.c b/fs/ext2/xattr_user.c
index c243a3b4d69d..e710f491663c 100644
--- a/fs/ext2/xattr_user.c
+++ b/fs/ext2/xattr_user.c
@@ -30,6 +30,7 @@ ext2_xattr_user_get(const struct xattr_handler *handler,
 
 static int
 ext2_xattr_user_set(const struct xattr_handler *handler,
+		    struct user_namespace *user_ns,
 		    struct dentry *unused, struct inode *inode,
 		    const char *name, const void *value,
 		    size_t size, int flags)
diff --git a/fs/ext4/acl.c b/fs/ext4/acl.c
index 68aaed48315f..4aad060010d8 100644
--- a/fs/ext4/acl.c
+++ b/fs/ext4/acl.c
@@ -245,7 +245,7 @@ ext4_set_acl(struct inode *inode, struct posix_acl *acl, int type)
 	ext4_fc_start_update(inode);
 
 	if ((type == ACL_TYPE_ACCESS) && acl) {
-		error = posix_acl_update_mode(inode, &mode, &acl);
+		error = posix_acl_update_mode(&init_user_ns, inode, &mode, &acl);
 		if (error)
 			goto out_stop;
 		if (mode != inode->i_mode)
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 554ffd367b44..7bc58f25bf2e 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5510,7 +5510,7 @@ int ext4_setattr(struct dentry *dentry, struct iattr *attr)
 		ext4_orphan_del(NULL, inode);
 
 	if (!error && (ia_valid & ATTR_MODE))
-		rc = posix_acl_chmod(inode, inode->i_mode);
+		rc = posix_acl_chmod(&init_user_ns, inode, inode->i_mode);
 
 err_out:
 	if  (error)
diff --git a/fs/ext4/xattr_hurd.c b/fs/ext4/xattr_hurd.c
index 8cfa74a56361..74925eace7dc 100644
--- a/fs/ext4/xattr_hurd.c
+++ b/fs/ext4/xattr_hurd.c
@@ -32,6 +32,7 @@ ext4_xattr_hurd_get(const struct xattr_handler *handler,
 
 static int
 ext4_xattr_hurd_set(const struct xattr_handler *handler,
+		    struct user_namespace *user_ns,
 		    struct dentry *unused, struct inode *inode,
 		    const char *name, const void *value,
 		    size_t size, int flags)
diff --git a/fs/ext4/xattr_security.c b/fs/ext4/xattr_security.c
index 197a9d8a15ef..cf6c772200b9 100644
--- a/fs/ext4/xattr_security.c
+++ b/fs/ext4/xattr_security.c
@@ -23,6 +23,7 @@ ext4_xattr_security_get(const struct xattr_handler *handler,
 
 static int
 ext4_xattr_security_set(const struct xattr_handler *handler,
+			struct user_namespace *user_ns,
 			struct dentry *unused, struct inode *inode,
 			const char *name, const void *value,
 			size_t size, int flags)
diff --git a/fs/ext4/xattr_trusted.c b/fs/ext4/xattr_trusted.c
index e9389e5d75c3..b62112b9cb3b 100644
--- a/fs/ext4/xattr_trusted.c
+++ b/fs/ext4/xattr_trusted.c
@@ -30,6 +30,7 @@ ext4_xattr_trusted_get(const struct xattr_handler *handler,
 
 static int
 ext4_xattr_trusted_set(const struct xattr_handler *handler,
+		       struct user_namespace *user_ns,
 		       struct dentry *unused, struct inode *inode,
 		       const char *name, const void *value,
 		       size_t size, int flags)
diff --git a/fs/ext4/xattr_user.c b/fs/ext4/xattr_user.c
index d4546184b34b..6cd01df6e8a5 100644
--- a/fs/ext4/xattr_user.c
+++ b/fs/ext4/xattr_user.c
@@ -31,6 +31,7 @@ ext4_xattr_user_get(const struct xattr_handler *handler,
 
 static int
 ext4_xattr_user_set(const struct xattr_handler *handler,
+		    struct user_namespace *user_ns,
 		    struct dentry *unused, struct inode *inode,
 		    const char *name, const void *value,
 		    size_t size, int flags)
diff --git a/fs/f2fs/acl.c b/fs/f2fs/acl.c
index 306413589827..50735e8a354e 100644
--- a/fs/f2fs/acl.c
+++ b/fs/f2fs/acl.c
@@ -213,7 +213,7 @@ static int __f2fs_set_acl(struct inode *inode, int type,
 	case ACL_TYPE_ACCESS:
 		name_index = F2FS_XATTR_INDEX_POSIX_ACL_ACCESS;
 		if (acl && !ipage) {
-			error = posix_acl_update_mode(inode, &mode, &acl);
+			error = posix_acl_update_mode(&init_user_ns, inode, &mode, &acl);
 			if (error)
 				return error;
 			set_acl_inode(inode, mode);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 39bc0c77a895..5fc6c44020ed 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -942,7 +942,7 @@ int f2fs_setattr(struct dentry *dentry, struct iattr *attr)
 	__setattr_copy(inode, attr);
 
 	if (attr->ia_valid & ATTR_MODE) {
-		err = posix_acl_chmod(inode, f2fs_get_inode_mode(inode));
+		err = posix_acl_chmod(&init_user_ns, inode, f2fs_get_inode_mode(inode));
 		if (err || is_inode_flag_set(inode, FI_ACL_MODE)) {
 			inode->i_mode = F2FS_I(inode)->i_acl_mode;
 			clear_inode_flag(inode, FI_ACL_MODE);
diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
index d772bf13a814..2b0b270ca80e 100644
--- a/fs/f2fs/xattr.c
+++ b/fs/f2fs/xattr.c
@@ -64,6 +64,7 @@ static int f2fs_xattr_generic_get(const struct xattr_handler *handler,
 }
 
 static int f2fs_xattr_generic_set(const struct xattr_handler *handler,
+		struct user_namespace *user_ns,
 		struct dentry *unused, struct inode *inode,
 		const char *name, const void *value,
 		size_t size, int flags)
@@ -107,6 +108,7 @@ static int f2fs_xattr_advise_get(const struct xattr_handler *handler,
 }
 
 static int f2fs_xattr_advise_set(const struct xattr_handler *handler,
+		struct user_namespace *user_ns,
 		struct dentry *unused, struct inode *inode,
 		const char *name, const void *value,
 		size_t size, int flags)
diff --git a/fs/fuse/xattr.c b/fs/fuse/xattr.c
index 371bdcbc7233..518590494fdc 100644
--- a/fs/fuse/xattr.c
+++ b/fs/fuse/xattr.c
@@ -182,6 +182,7 @@ static int fuse_xattr_get(const struct xattr_handler *handler,
 }
 
 static int fuse_xattr_set(const struct xattr_handler *handler,
+			  struct user_namespace *user_ns,
 			  struct dentry *dentry, struct inode *inode,
 			  const char *name, const void *value, size_t size,
 			  int flags)
@@ -205,6 +206,7 @@ static int no_xattr_get(const struct xattr_handler *handler,
 }
 
 static int no_xattr_set(const struct xattr_handler *handler,
+			struct user_namespace *user_ns,
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
index e6f481ff6f8e..00a90287b919 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -1991,7 +1991,7 @@ static int gfs2_setattr(struct dentry *dentry, struct iattr *attr)
 	else {
 		error = gfs2_setattr_simple(inode, attr);
 		if (!error && attr->ia_valid & ATTR_MODE)
-			error = posix_acl_chmod(inode, inode->i_mode);
+			error = posix_acl_chmod(&init_user_ns, inode, inode->i_mode);
 	}
 
 error:
diff --git a/fs/gfs2/xattr.c b/fs/gfs2/xattr.c
index 9d7667bc4292..8e0eb5b3528f 100644
--- a/fs/gfs2/xattr.c
+++ b/fs/gfs2/xattr.c
@@ -1214,6 +1214,7 @@ int __gfs2_xattr_set(struct inode *inode, const char *name,
 }
 
 static int gfs2_xattr_set(const struct xattr_handler *handler,
+			  struct user_namespace *user_ns,
 			  struct dentry *unused, struct inode *inode,
 			  const char *name, const void *value,
 			  size_t size, int flags)
diff --git a/fs/hfs/attr.c b/fs/hfs/attr.c
index 74fa62643136..ed2a50535bc1 100644
--- a/fs/hfs/attr.c
+++ b/fs/hfs/attr.c
@@ -121,6 +121,7 @@ static int hfs_xattr_get(const struct xattr_handler *handler,
 }
 
 static int hfs_xattr_set(const struct xattr_handler *handler,
+			 struct user_namespace *user_ns,
 			 struct dentry *unused, struct inode *inode,
 			 const char *name, const void *value, size_t size,
 			 int flags)
diff --git a/fs/hfsplus/xattr.c b/fs/hfsplus/xattr.c
index bb0b27d88e50..0fc6000659db 100644
--- a/fs/hfsplus/xattr.c
+++ b/fs/hfsplus/xattr.c
@@ -858,6 +858,7 @@ static int hfsplus_osx_getxattr(const struct xattr_handler *handler,
 }
 
 static int hfsplus_osx_setxattr(const struct xattr_handler *handler,
+				struct user_namespace *user_ns,
 				struct dentry *unused, struct inode *inode,
 				const char *name, const void *buffer,
 				size_t size, int flags)
diff --git a/fs/hfsplus/xattr_security.c b/fs/hfsplus/xattr_security.c
index cfbe6a3bfb1e..00c82f82a1dd 100644
--- a/fs/hfsplus/xattr_security.c
+++ b/fs/hfsplus/xattr_security.c
@@ -23,6 +23,7 @@ static int hfsplus_security_getxattr(const struct xattr_handler *handler,
 }
 
 static int hfsplus_security_setxattr(const struct xattr_handler *handler,
+				     struct user_namespace *user_ns,
 				     struct dentry *unused, struct inode *inode,
 				     const char *name, const void *buffer,
 				     size_t size, int flags)
diff --git a/fs/hfsplus/xattr_trusted.c b/fs/hfsplus/xattr_trusted.c
index fbad91e1dada..e3a2712a55d1 100644
--- a/fs/hfsplus/xattr_trusted.c
+++ b/fs/hfsplus/xattr_trusted.c
@@ -22,6 +22,7 @@ static int hfsplus_trusted_getxattr(const struct xattr_handler *handler,
 }
 
 static int hfsplus_trusted_setxattr(const struct xattr_handler *handler,
+				    struct user_namespace *user_ns,
 				    struct dentry *unused, struct inode *inode,
 				    const char *name, const void *buffer,
 				    size_t size, int flags)
diff --git a/fs/hfsplus/xattr_user.c b/fs/hfsplus/xattr_user.c
index 74d19faf255e..497f8114a132 100644
--- a/fs/hfsplus/xattr_user.c
+++ b/fs/hfsplus/xattr_user.c
@@ -22,6 +22,7 @@ static int hfsplus_user_getxattr(const struct xattr_handler *handler,
 }
 
 static int hfsplus_user_setxattr(const struct xattr_handler *handler,
+				 struct user_namespace *user_ns,
 				 struct dentry *unused, struct inode *inode,
 				 const char *name, const void *buffer,
 				 size_t size, int flags)
diff --git a/fs/jffs2/acl.c b/fs/jffs2/acl.c
index 093ffbd82395..cf07a2fdf8bf 100644
--- a/fs/jffs2/acl.c
+++ b/fs/jffs2/acl.c
@@ -236,7 +236,7 @@ int jffs2_set_acl(struct inode *inode, struct posix_acl *acl, int type)
 		if (acl) {
 			umode_t mode;
 
-			rc = posix_acl_update_mode(inode, &mode, &acl);
+			rc = posix_acl_update_mode(&init_user_ns, inode, &mode, &acl);
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
index c2332e30f218..451e603c61c1 100644
--- a/fs/jffs2/security.c
+++ b/fs/jffs2/security.c
@@ -57,6 +57,7 @@ static int jffs2_security_getxattr(const struct xattr_handler *handler,
 }
 
 static int jffs2_security_setxattr(const struct xattr_handler *handler,
+				   struct user_namespace *user_ns,
 				   struct dentry *unused, struct inode *inode,
 				   const char *name, const void *buffer,
 				   size_t size, int flags)
diff --git a/fs/jffs2/xattr_trusted.c b/fs/jffs2/xattr_trusted.c
index 5d6030826c52..ca1afca47910 100644
--- a/fs/jffs2/xattr_trusted.c
+++ b/fs/jffs2/xattr_trusted.c
@@ -25,6 +25,7 @@ static int jffs2_trusted_getxattr(const struct xattr_handler *handler,
 }
 
 static int jffs2_trusted_setxattr(const struct xattr_handler *handler,
+				  struct user_namespace *user_ns,
 				  struct dentry *unused, struct inode *inode,
 				  const char *name, const void *buffer,
 				  size_t size, int flags)
diff --git a/fs/jffs2/xattr_user.c b/fs/jffs2/xattr_user.c
index 9d027b4abcf9..f6bc7da9c0d3 100644
--- a/fs/jffs2/xattr_user.c
+++ b/fs/jffs2/xattr_user.c
@@ -25,6 +25,7 @@ static int jffs2_user_getxattr(const struct xattr_handler *handler,
 }
 
 static int jffs2_user_setxattr(const struct xattr_handler *handler,
+			       struct user_namespace *user_ns,
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
index db41e7803163..2c83750bdf2b 100644
--- a/fs/jfs/xattr.c
+++ b/fs/jfs/xattr.c
@@ -932,6 +932,7 @@ static int jfs_xattr_get(const struct xattr_handler *handler,
 }
 
 static int jfs_xattr_set(const struct xattr_handler *handler,
+			 struct user_namespace *user_ns,
 			 struct dentry *unused, struct inode *inode,
 			 const char *name, const void *value,
 			 size_t size, int flags)
@@ -950,6 +951,7 @@ static int jfs_xattr_get_os2(const struct xattr_handler *handler,
 }
 
 static int jfs_xattr_set_os2(const struct xattr_handler *handler,
+			     struct user_namespace *user_ns,
 			     struct dentry *unused, struct inode *inode,
 			     const char *name, const void *value,
 			     size_t size, int flags)
diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
index 86bd4c593b78..74ee0ffcfe71 100644
--- a/fs/kernfs/inode.c
+++ b/fs/kernfs/inode.c
@@ -319,6 +319,7 @@ static int kernfs_vfs_xattr_get(const struct xattr_handler *handler,
 }
 
 static int kernfs_vfs_xattr_set(const struct xattr_handler *handler,
+				struct user_namespace *user_ns,
 				struct dentry *unused, struct inode *inode,
 				const char *suffix, const void *value,
 				size_t size, int flags)
@@ -385,6 +386,7 @@ static int kernfs_vfs_user_xattr_rm(struct kernfs_node *kn,
 }
 
 static int kernfs_vfs_user_xattr_set(const struct xattr_handler *handler,
+				     struct user_namespace *user_ns,
 				     struct dentry *unused, struct inode *inode,
 				     const char *suffix, const void *value,
 				     size_t size, int flags)
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 9e0ca9b2b210..77504501323c 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -7486,6 +7486,7 @@ nfs4_release_lockowner(struct nfs_server *server, struct nfs4_lock_state *lsp)
 #define XATTR_NAME_NFSV4_ACL "system.nfs4_acl"
 
 static int nfs4_xattr_set_nfs4_acl(const struct xattr_handler *handler,
+				   struct user_namespace *user_ns,
 				   struct dentry *unused, struct inode *inode,
 				   const char *key, const void *buf,
 				   size_t buflen, int flags)
@@ -7508,6 +7509,7 @@ static bool nfs4_xattr_list_nfs4_acl(struct dentry *dentry)
 #ifdef CONFIG_NFS_V4_SECURITY_LABEL
 
 static int nfs4_xattr_set_nfs4_label(const struct xattr_handler *handler,
+				     struct user_namespace *user_ns,
 				     struct dentry *unused, struct inode *inode,
 				     const char *key, const void *buf,
 				     size_t buflen, int flags)
@@ -7558,6 +7560,7 @@ nfs4_listxattr_nfs4_label(struct inode *inode, char *list, size_t list_len)
 
 #ifdef CONFIG_NFS_V4_2
 static int nfs4_xattr_set_nfs4_user(const struct xattr_handler *handler,
+				    struct user_namespace *user_ns,
 				    struct dentry *unused, struct inode *inode,
 				    const char *key, const void *buf,
 				    size_t buflen, int flags)
diff --git a/fs/nfsd/nfs2acl.c b/fs/nfsd/nfs2acl.c
index 6a900f770dd2..e5f06f21c24a 100644
--- a/fs/nfsd/nfs2acl.c
+++ b/fs/nfsd/nfs2acl.c
@@ -113,10 +113,10 @@ static __be32 nfsacld_proc_setacl(struct svc_rqst *rqstp)
 
 	fh_lock(fh);
 
-	error = set_posix_acl(inode, ACL_TYPE_ACCESS, argp->acl_access);
+	error = set_posix_acl(&init_user_ns, inode, ACL_TYPE_ACCESS, argp->acl_access);
 	if (error)
 		goto out_drop_lock;
-	error = set_posix_acl(inode, ACL_TYPE_DEFAULT, argp->acl_default);
+	error = set_posix_acl(&init_user_ns, inode, ACL_TYPE_DEFAULT, argp->acl_default);
 	if (error)
 		goto out_drop_lock;
 
diff --git a/fs/nfsd/nfs3acl.c b/fs/nfsd/nfs3acl.c
index 34a394e50e1d..3618f62e118e 100644
--- a/fs/nfsd/nfs3acl.c
+++ b/fs/nfsd/nfs3acl.c
@@ -103,10 +103,10 @@ static __be32 nfsd3_proc_setacl(struct svc_rqst *rqstp)
 
 	fh_lock(fh);
 
-	error = set_posix_acl(inode, ACL_TYPE_ACCESS, argp->acl_access);
+	error = set_posix_acl(&init_user_ns, inode, ACL_TYPE_ACCESS, argp->acl_access);
 	if (error)
 		goto out_drop_lock;
-	error = set_posix_acl(inode, ACL_TYPE_DEFAULT, argp->acl_default);
+	error = set_posix_acl(&init_user_ns, inode, ACL_TYPE_DEFAULT, argp->acl_default);
 
 out_drop_lock:
 	fh_unlock(fh);
diff --git a/fs/nfsd/nfs4acl.c b/fs/nfsd/nfs4acl.c
index 71292a0d6f09..0b35bc490aee 100644
--- a/fs/nfsd/nfs4acl.c
+++ b/fs/nfsd/nfs4acl.c
@@ -781,12 +781,12 @@ nfsd4_set_nfs4_acl(struct svc_rqst *rqstp, struct svc_fh *fhp,
 
 	fh_lock(fhp);
 
-	host_error = set_posix_acl(inode, ACL_TYPE_ACCESS, pacl);
+	host_error = set_posix_acl(&init_user_ns, inode, ACL_TYPE_ACCESS, pacl);
 	if (host_error < 0)
 		goto out_drop_lock;
 
 	if (S_ISDIR(inode->i_mode)) {
-		host_error = set_posix_acl(inode, ACL_TYPE_DEFAULT, dpacl);
+		host_error = set_posix_acl(&init_user_ns, inode, ACL_TYPE_DEFAULT, dpacl);
 	}
 
 out_drop_lock:
diff --git a/fs/ocfs2/acl.c b/fs/ocfs2/acl.c
index 7b07f5df3a29..7e64dbe93251 100644
--- a/fs/ocfs2/acl.c
+++ b/fs/ocfs2/acl.c
@@ -274,7 +274,7 @@ int ocfs2_iop_set_acl(struct inode *inode, struct posix_acl *acl, int type)
 	if (type == ACL_TYPE_ACCESS && acl) {
 		umode_t mode;
 
-		status = posix_acl_update_mode(inode, &mode, &acl);
+		status = posix_acl_update_mode(&init_user_ns, inode, &mode, &acl);
 		if (status)
 			goto unlock;
 
diff --git a/fs/ocfs2/xattr.c b/fs/ocfs2/xattr.c
index 9ccd19d8f7b1..7b034aef0b0d 100644
--- a/fs/ocfs2/xattr.c
+++ b/fs/ocfs2/xattr.c
@@ -7249,6 +7249,7 @@ static int ocfs2_xattr_security_get(const struct xattr_handler *handler,
 }
 
 static int ocfs2_xattr_security_set(const struct xattr_handler *handler,
+				    struct user_namespace *user_ns,
 				    struct dentry *unused, struct inode *inode,
 				    const char *name, const void *value,
 				    size_t size, int flags)
@@ -7321,6 +7322,7 @@ static int ocfs2_xattr_trusted_get(const struct xattr_handler *handler,
 }
 
 static int ocfs2_xattr_trusted_set(const struct xattr_handler *handler,
+				   struct user_namespace *user_ns,
 				   struct dentry *unused, struct inode *inode,
 				   const char *name, const void *value,
 				   size_t size, int flags)
@@ -7351,6 +7353,7 @@ static int ocfs2_xattr_user_get(const struct xattr_handler *handler,
 }
 
 static int ocfs2_xattr_user_set(const struct xattr_handler *handler,
+				struct user_namespace *user_ns,
 				struct dentry *unused, struct inode *inode,
 				const char *name, const void *value,
 				size_t size, int flags)
diff --git a/fs/orangefs/acl.c b/fs/orangefs/acl.c
index a25e6c890975..ba55d61906c2 100644
--- a/fs/orangefs/acl.c
+++ b/fs/orangefs/acl.c
@@ -132,7 +132,7 @@ int orangefs_set_acl(struct inode *inode, struct posix_acl *acl, int type)
 		 * and "mode" to the new desired value. It is up to
 		 * us to propagate the new mode back to the server...
 		 */
-		error = posix_acl_update_mode(inode, &iattr.ia_mode, &acl);
+		error = posix_acl_update_mode(&init_user_ns, inode, &iattr.ia_mode, &acl);
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
index bdc285aea360..41a4145ba697 100644
--- a/fs/orangefs/xattr.c
+++ b/fs/orangefs/xattr.c
@@ -526,6 +526,7 @@ ssize_t orangefs_listxattr(struct dentry *dentry, char *buffer, size_t size)
 }
 
 static int orangefs_xattr_set_default(const struct xattr_handler *handler,
+				      struct user_namespace *user_ns,
 				      struct dentry *unused,
 				      struct inode *inode,
 				      const char *name,
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 64f5f8f6f84e..9c12df942407 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -935,6 +935,7 @@ ovl_posix_acl_xattr_get(const struct xattr_handler *handler,
 
 static int __maybe_unused
 ovl_posix_acl_xattr_set(const struct xattr_handler *handler,
+			struct user_namespace *user_ns,
 			struct dentry *dentry, struct inode *inode,
 			const char *name, const void *value,
 			size_t size, int flags)
@@ -999,6 +1000,7 @@ static int ovl_own_xattr_get(const struct xattr_handler *handler,
 }
 
 static int ovl_own_xattr_set(const struct xattr_handler *handler,
+			     struct user_namespace *user_ns,
 			     struct dentry *dentry, struct inode *inode,
 			     const char *name, const void *value,
 			     size_t size, int flags)
@@ -1014,6 +1016,7 @@ static int ovl_other_xattr_get(const struct xattr_handler *handler,
 }
 
 static int ovl_other_xattr_set(const struct xattr_handler *handler,
+			       struct user_namespace *user_ns,
 			       struct dentry *dentry, struct inode *inode,
 			       const char *name, const void *value,
 			       size_t size, int flags)
diff --git a/fs/posix_acl.c b/fs/posix_acl.c
index 87b5ec67000b..ee6c017802c3 100644
--- a/fs/posix_acl.c
+++ b/fs/posix_acl.c
@@ -559,7 +559,7 @@ __posix_acl_chmod(struct posix_acl **acl, gfp_t gfp, umode_t mode)
 EXPORT_SYMBOL(__posix_acl_chmod);
 
 int
-posix_acl_chmod(struct inode *inode, umode_t mode)
+posix_acl_chmod(struct user_namespace *user_ns, struct inode *inode, umode_t mode)
 {
 	struct posix_acl *acl;
 	int ret = 0;
@@ -638,6 +638,7 @@ EXPORT_SYMBOL_GPL(posix_acl_create);
 
 /**
  * posix_acl_update_mode  -  update mode in set_acl
+ * @user_ns: user namespace the inode is accessed from
  * @inode: target inode
  * @mode_p: mode (pointer) for update
  * @acl: acl pointer
@@ -651,8 +652,8 @@ EXPORT_SYMBOL_GPL(posix_acl_create);
  *
  * Called from set_acl inode operations.
  */
-int posix_acl_update_mode(struct inode *inode, umode_t *mode_p,
-			  struct posix_acl **acl)
+int posix_acl_update_mode(struct user_namespace *user_ns, struct inode *inode,
+			  umode_t *mode_p, struct posix_acl **acl)
 {
 	umode_t mode = inode->i_mode;
 	int error;
@@ -662,8 +663,8 @@ int posix_acl_update_mode(struct inode *inode, umode_t *mode_p,
 		return error;
 	if (error == 0)
 		*acl = NULL;
-	if (!in_group_p(inode->i_gid) &&
-	    !capable_wrt_inode_uidgid(&init_user_ns, inode, CAP_FSETID))
+	if (!in_group_p(i_gid_into_mnt(user_ns, inode)) &&
+	    !capable_wrt_inode_uidgid(user_ns, inode, CAP_FSETID))
 		mode &= ~S_ISGID;
 	*mode_p = mode;
 	return 0;
@@ -675,7 +676,8 @@ EXPORT_SYMBOL(posix_acl_update_mode);
  */
 static void posix_acl_fix_xattr_userns(
 	struct user_namespace *to, struct user_namespace *from,
-	void *value, size_t size)
+	struct user_namespace *mnt_user_ns,
+	void *value, size_t size, bool from_user)
 {
 	struct posix_acl_xattr_header *header = value;
 	struct posix_acl_xattr_entry *entry = (void *)(header + 1), *end;
@@ -700,10 +702,18 @@ static void posix_acl_fix_xattr_userns(
 		switch(le16_to_cpu(entry->e_tag)) {
 		case ACL_USER:
 			uid = make_kuid(from, le32_to_cpu(entry->e_id));
+			if (from_user)
+				uid = kuid_from_mnt(mnt_user_ns, uid);
+			else
+				uid = kuid_into_mnt(mnt_user_ns, uid);
 			entry->e_id = cpu_to_le32(from_kuid(to, uid));
 			break;
 		case ACL_GROUP:
 			gid = make_kgid(from, le32_to_cpu(entry->e_id));
+			if (from_user)
+				gid = kgid_from_mnt(mnt_user_ns, gid);
+			else
+				gid = kgid_into_mnt(mnt_user_ns, gid);
 			entry->e_id = cpu_to_le32(from_kgid(to, gid));
 			break;
 		default:
@@ -712,21 +722,25 @@ static void posix_acl_fix_xattr_userns(
 	}
 }
 
-void posix_acl_fix_xattr_from_user(void *value, size_t size)
+void posix_acl_fix_xattr_from_user(struct user_namespace *mnt_user_ns,
+				   void *value, size_t size)
 {
 	struct user_namespace *user_ns = current_user_ns();
-	if (user_ns == &init_user_ns)
+	if ((user_ns == &init_user_ns) && (mnt_user_ns == &init_user_ns))
 		return;
-	posix_acl_fix_xattr_userns(&init_user_ns, user_ns, value, size);
+	posix_acl_fix_xattr_userns(&init_user_ns, user_ns, mnt_user_ns, value, size, true);
 }
+EXPORT_SYMBOL(posix_acl_fix_xattr_from_user);
 
-void posix_acl_fix_xattr_to_user(void *value, size_t size)
+void posix_acl_fix_xattr_to_user(struct user_namespace *mnt_user_ns,
+				 void *value, size_t size)
 {
 	struct user_namespace *user_ns = current_user_ns();
-	if (user_ns == &init_user_ns)
+	if ((user_ns == &init_user_ns) && (mnt_user_ns == &init_user_ns))
 		return;
-	posix_acl_fix_xattr_userns(user_ns, &init_user_ns, value, size);
+	posix_acl_fix_xattr_userns(user_ns, &init_user_ns, mnt_user_ns, value, size, false);
 }
+EXPORT_SYMBOL(posix_acl_fix_xattr_to_user);
 
 /*
  * Convert from extended attribute to in-memory representation.
@@ -865,7 +879,8 @@ posix_acl_xattr_get(const struct xattr_handler *handler,
 }
 
 int
-set_posix_acl(struct inode *inode, int type, struct posix_acl *acl)
+set_posix_acl(struct user_namespace *user_ns, struct inode *inode,
+	      int type, struct posix_acl *acl)
 {
 	if (!IS_POSIXACL(inode))
 		return -EOPNOTSUPP;
@@ -874,7 +889,7 @@ set_posix_acl(struct inode *inode, int type, struct posix_acl *acl)
 
 	if (type == ACL_TYPE_DEFAULT && !S_ISDIR(inode->i_mode))
 		return acl ? -EACCES : 0;
-	if (!inode_owner_or_capable(&init_user_ns, inode))
+	if (!inode_owner_or_capable(user_ns, inode))
 		return -EPERM;
 
 	if (acl) {
@@ -888,9 +903,10 @@ EXPORT_SYMBOL(set_posix_acl);
 
 static int
 posix_acl_xattr_set(const struct xattr_handler *handler,
-		    struct dentry *unused, struct inode *inode,
-		    const char *name, const void *value,
-		    size_t size, int flags)
+			   struct user_namespace *user_ns,
+			   struct dentry *unused, struct inode *inode,
+			   const char *name, const void *value, size_t size,
+			   int flags)
 {
 	struct posix_acl *acl = NULL;
 	int ret;
@@ -900,7 +916,7 @@ posix_acl_xattr_set(const struct xattr_handler *handler,
 		if (IS_ERR(acl))
 			return PTR_ERR(acl);
 	}
-	ret = set_posix_acl(inode, handler->flags, acl);
+	ret = set_posix_acl(user_ns, inode, handler->flags, acl);
 	posix_acl_release(acl);
 	return ret;
 }
@@ -934,7 +950,7 @@ int simple_set_acl(struct inode *inode, struct posix_acl *acl, int type)
 	int error;
 
 	if (type == ACL_TYPE_ACCESS) {
-		error = posix_acl_update_mode(inode,
+		error = posix_acl_update_mode(&init_user_ns, inode,
 				&inode->i_mode, &acl);
 		if (error)
 			return error;
diff --git a/fs/reiserfs/xattr_acl.c b/fs/reiserfs/xattr_acl.c
index ccd40df6eb45..b8f397134c17 100644
--- a/fs/reiserfs/xattr_acl.c
+++ b/fs/reiserfs/xattr_acl.c
@@ -40,7 +40,7 @@ reiserfs_set_acl(struct inode *inode, struct posix_acl *acl, int type)
 	reiserfs_write_unlock(inode->i_sb);
 	if (error == 0) {
 		if (type == ACL_TYPE_ACCESS && acl) {
-			error = posix_acl_update_mode(inode, &mode, &acl);
+			error = posix_acl_update_mode(&init_user_ns, inode, &mode, &acl);
 			if (error)
 				goto unlock;
 			update_mode = 1;
@@ -399,5 +399,5 @@ int reiserfs_acl_chmod(struct inode *inode)
 	    !reiserfs_posixacl(inode->i_sb))
 		return 0;
 
-	return posix_acl_chmod(inode, inode->i_mode);
+	return posix_acl_chmod(&init_user_ns, inode, inode->i_mode);
 }
diff --git a/fs/reiserfs/xattr_security.c b/fs/reiserfs/xattr_security.c
index 20be9a0e5870..c98411a46c64 100644
--- a/fs/reiserfs/xattr_security.c
+++ b/fs/reiserfs/xattr_security.c
@@ -21,7 +21,8 @@ security_get(const struct xattr_handler *handler, struct dentry *unused,
 }
 
 static int
-security_set(const struct xattr_handler *handler, struct dentry *unused,
+security_set(const struct xattr_handler *handler, struct user_namespace *user_ns,
+	     struct dentry *unused,
 	     struct inode *inode, const char *name, const void *buffer,
 	     size_t size, int flags)
 {
diff --git a/fs/reiserfs/xattr_trusted.c b/fs/reiserfs/xattr_trusted.c
index 5ed48da3d02b..d197cd9da0ec 100644
--- a/fs/reiserfs/xattr_trusted.c
+++ b/fs/reiserfs/xattr_trusted.c
@@ -20,7 +20,8 @@ trusted_get(const struct xattr_handler *handler, struct dentry *unused,
 }
 
 static int
-trusted_set(const struct xattr_handler *handler, struct dentry *unused,
+trusted_set(const struct xattr_handler *handler, struct user_namespace *user_ns,
+	    struct dentry *unused,
 	    struct inode *inode, const char *name, const void *buffer,
 	    size_t size, int flags)
 {
diff --git a/fs/reiserfs/xattr_user.c b/fs/reiserfs/xattr_user.c
index a573ca45bacc..a79112aa0b4d 100644
--- a/fs/reiserfs/xattr_user.c
+++ b/fs/reiserfs/xattr_user.c
@@ -18,7 +18,8 @@ user_get(const struct xattr_handler *handler, struct dentry *unused,
 }
 
 static int
-user_set(const struct xattr_handler *handler, struct dentry *unused,
+user_set(const struct xattr_handler *handler, struct user_namespace *user_ns,
+	 struct dentry *unused,
 	 struct inode *inode, const char *name, const void *buffer,
 	 size_t size, int flags)
 {
diff --git a/fs/ubifs/xattr.c b/fs/ubifs/xattr.c
index a0b9b349efe6..87d710d0e5b1 100644
--- a/fs/ubifs/xattr.c
+++ b/fs/ubifs/xattr.c
@@ -681,6 +681,7 @@ static int xattr_get(const struct xattr_handler *handler,
 }
 
 static int xattr_set(const struct xattr_handler *handler,
+			   struct user_namespace *user_ns,
 			   struct dentry *dentry, struct inode *inode,
 			   const char *name, const void *value,
 			   size_t size, int flags)
diff --git a/fs/xattr.c b/fs/xattr.c
index fcc79c2a1ea1..ff9ffe77a4b2 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -174,7 +174,7 @@ __vfs_setxattr(struct dentry *dentry, struct inode *inode, const char *name,
 		return -EOPNOTSUPP;
 	if (size == 0)
 		value = "";  /* empty EA, do not remove */
-	return handler->set(handler, dentry, inode, name, value, size, flags);
+	return handler->set(handler, &init_user_ns, dentry, inode, name, value, size, flags);
 }
 EXPORT_SYMBOL(__vfs_setxattr);
 
@@ -438,7 +438,7 @@ __vfs_removexattr(struct dentry *dentry, const char *name)
 		return PTR_ERR(handler);
 	if (!handler->set)
 		return -EOPNOTSUPP;
-	return handler->set(handler, dentry, inode, name, NULL, 0, XATTR_REPLACE);
+	return handler->set(handler, &init_user_ns, dentry, inode, name, NULL, 0, XATTR_REPLACE);
 }
 EXPORT_SYMBOL(__vfs_removexattr);
 
@@ -536,9 +536,9 @@ setxattr(struct dentry *d, const char __user *name, const void __user *value,
 		}
 		if ((strcmp(kname, XATTR_NAME_POSIX_ACL_ACCESS) == 0) ||
 		    (strcmp(kname, XATTR_NAME_POSIX_ACL_DEFAULT) == 0))
-			posix_acl_fix_xattr_from_user(kvalue, size);
+			posix_acl_fix_xattr_from_user(&init_user_ns, kvalue, size);
 		else if (strcmp(kname, XATTR_NAME_CAPS) == 0) {
-			error = cap_convert_nscap(d, &kvalue, size);
+			error = cap_convert_nscap(&init_user_ns, d, &kvalue, size);
 			if (error < 0)
 				goto out;
 			size = error;
@@ -636,7 +636,7 @@ getxattr(struct dentry *d, const char __user *name, void __user *value,
 	if (error > 0) {
 		if ((strcmp(kname, XATTR_NAME_POSIX_ACL_ACCESS) == 0) ||
 		    (strcmp(kname, XATTR_NAME_POSIX_ACL_DEFAULT) == 0))
-			posix_acl_fix_xattr_to_user(kvalue, error);
+			posix_acl_fix_xattr_to_user(&init_user_ns, kvalue, error);
 		if (size && copy_to_user(value, kvalue, error))
 			error = -EFAULT;
 	} else if (error == -ERANGE && size >= XATTR_SIZE_MAX) {
diff --git a/fs/xfs/xfs_acl.c b/fs/xfs/xfs_acl.c
index c544951a0c07..2e9d2d2878ce 100644
--- a/fs/xfs/xfs_acl.c
+++ b/fs/xfs/xfs_acl.c
@@ -244,7 +244,7 @@ xfs_set_acl(struct inode *inode, struct posix_acl *acl, int type)
 		return error;
 
 	if (type == ACL_TYPE_ACCESS) {
-		error = posix_acl_update_mode(inode, &mode, &acl);
+		error = posix_acl_update_mode(&init_user_ns, inode, &mode, &acl);
 		if (error)
 			return error;
 		set_mode = true;
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 33c6c8c14275..36d583ed8d25 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -810,7 +810,7 @@ xfs_setattr_nonsize(
 	 * 	     Posix ACL code seems to care about this issue either.
 	 */
 	if ((mask & ATTR_MODE) && !(flags & XFS_ATTR_NOACL)) {
-		error = posix_acl_chmod(inode, inode->i_mode);
+		error = posix_acl_chmod(&init_user_ns, inode, inode->i_mode);
 		if (error)
 			return error;
 	}
diff --git a/fs/xfs/xfs_xattr.c b/fs/xfs/xfs_xattr.c
index bca48b308c02..76c9bdab2234 100644
--- a/fs/xfs/xfs_xattr.c
+++ b/fs/xfs/xfs_xattr.c
@@ -38,7 +38,8 @@ xfs_xattr_get(const struct xattr_handler *handler, struct dentry *unused,
 }
 
 static int
-xfs_xattr_set(const struct xattr_handler *handler, struct dentry *unused,
+xfs_xattr_set(const struct xattr_handler *handler, struct user_namespace *user_ns,
+		struct dentry *unused,
 		struct inode *inode, const char *name, const void *value,
 		size_t size, int flags)
 {
diff --git a/include/linux/capability.h b/include/linux/capability.h
index 041e336f3369..0d54ca8abaed 100644
--- a/include/linux/capability.h
+++ b/include/linux/capability.h
@@ -273,6 +273,7 @@ static inline bool checkpoint_restore_ns_capable(struct user_namespace *ns)
 /* audit system wants to get cap info from files as well */
 extern int get_vfs_caps_from_disk(const struct dentry *dentry, struct cpu_vfs_cap_data *cpu_caps);
 
-extern int cap_convert_nscap(struct dentry *dentry, void **ivalue, size_t size);
+extern int cap_convert_nscap(struct user_namespace *user_ns,
+			     struct dentry *dentry, void **ivalue, size_t size);
 
 #endif /* !_LINUX_CAPABILITY_H */
diff --git a/include/linux/posix_acl.h b/include/linux/posix_acl.h
index 8276baefed13..28a789218d83 100644
--- a/include/linux/posix_acl.h
+++ b/include/linux/posix_acl.h
@@ -71,13 +71,13 @@ extern int __posix_acl_create(struct posix_acl **, gfp_t, umode_t *);
 extern int __posix_acl_chmod(struct posix_acl **, gfp_t, umode_t);
 
 extern struct posix_acl *get_posix_acl(struct inode *, int);
-extern int set_posix_acl(struct inode *, int, struct posix_acl *);
+extern int set_posix_acl(struct user_namespace *, struct inode *, int, struct posix_acl *);
 
 #ifdef CONFIG_FS_POSIX_ACL
-extern int posix_acl_chmod(struct inode *, umode_t);
+extern int posix_acl_chmod(struct user_namespace *, struct inode *, umode_t);
 extern int posix_acl_create(struct inode *, umode_t *, struct posix_acl **,
 		struct posix_acl **);
-extern int posix_acl_update_mode(struct inode *, umode_t *, struct posix_acl **);
+extern int posix_acl_update_mode(struct user_namespace *, struct inode *, umode_t *, struct posix_acl **);
 
 extern int simple_set_acl(struct inode *, struct posix_acl *, int);
 extern int simple_acl_create(struct inode *, struct inode *);
@@ -94,7 +94,8 @@ static inline void cache_no_acl(struct inode *inode)
 	inode->i_default_acl = NULL;
 }
 #else
-static inline int posix_acl_chmod(struct inode *inode, umode_t mode)
+static inline int posix_acl_chmod(struct user_namespace *user_ns,
+				  struct inode *inode, umode_t mode)
 {
 	return 0;
 }
diff --git a/include/linux/posix_acl_xattr.h b/include/linux/posix_acl_xattr.h
index 2387709991b5..9fdac573e1cb 100644
--- a/include/linux/posix_acl_xattr.h
+++ b/include/linux/posix_acl_xattr.h
@@ -33,13 +33,17 @@ posix_acl_xattr_count(size_t size)
 }
 
 #ifdef CONFIG_FS_POSIX_ACL
-void posix_acl_fix_xattr_from_user(void *value, size_t size);
-void posix_acl_fix_xattr_to_user(void *value, size_t size);
+void posix_acl_fix_xattr_from_user(struct user_namespace *mnt_user_ns,
+				   void *value, size_t size);
+void posix_acl_fix_xattr_to_user(struct user_namespace *mnt_user_ns,
+				 void *value, size_t size);
 #else
-static inline void posix_acl_fix_xattr_from_user(void *value, size_t size)
+static inline void posix_acl_fix_xattr_from_user(struct user_namespace *mnt_user_ns,
+						 void *value, size_t size)
 {
 }
-static inline void posix_acl_fix_xattr_to_user(void *value, size_t size)
+static inline void posix_acl_fix_xattr_to_user(struct user_namespace *mnt_user_ns,
+					       void *value, size_t size)
 {
 }
 #endif
diff --git a/include/linux/xattr.h b/include/linux/xattr.h
index 10b4dc2709f0..6d2ef03ba399 100644
--- a/include/linux/xattr.h
+++ b/include/linux/xattr.h
@@ -34,9 +34,9 @@ struct xattr_handler {
 	int (*get)(const struct xattr_handler *, struct dentry *dentry,
 		   struct inode *inode, const char *name, void *buffer,
 		   size_t size);
-	int (*set)(const struct xattr_handler *, struct dentry *dentry,
-		   struct inode *inode, const char *name, const void *buffer,
-		   size_t size, int flags);
+	int (*set)(const struct xattr_handler *, struct user_namespace *user_ns,
+		   struct dentry *dentry, struct inode *inode, const char *name,
+		   const void *buffer, size_t size, int flags);
 };
 
 const char *xattr_full_name(const struct xattr_handler *, const char *);
diff --git a/mm/shmem.c b/mm/shmem.c
index 368555ddc411..8fdf52576e06 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1143,7 +1143,7 @@ static int shmem_setattr(struct dentry *dentry, struct iattr *attr)
 
 	setattr_copy(&init_user_ns, inode, attr);
 	if (attr->ia_valid & ATTR_MODE)
-		error = posix_acl_chmod(inode, inode->i_mode);
+		error = posix_acl_chmod(&init_user_ns, inode, inode->i_mode);
 	return error;
 }
 
@@ -3278,6 +3278,7 @@ static int shmem_xattr_handler_get(const struct xattr_handler *handler,
 }
 
 static int shmem_xattr_handler_set(const struct xattr_handler *handler,
+				   struct user_namespace *user_ns,
 				   struct dentry *unused, struct inode *inode,
 				   const char *name, const void *value,
 				   size_t size, int flags)
diff --git a/net/socket.c b/net/socket.c
index 6e6cccc2104f..3bf36327f531 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -334,6 +334,7 @@ static const struct xattr_handler sockfs_xattr_handler = {
 };
 
 static int sockfs_security_xattr_set(const struct xattr_handler *handler,
+				     struct user_namespace *user_ns,
 				     struct dentry *dentry, struct inode *inode,
 				     const char *suffix, const void *value,
 				     size_t size, int flags)
diff --git a/security/commoncap.c b/security/commoncap.c
index 4cd2bdfd0a8b..abefe9223b5e 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -451,15 +451,18 @@ int cap_inode_getsecurity(struct inode *inode, const char *name, void **buffer,
 }
 
 static kuid_t rootid_from_xattr(const void *value, size_t size,
-				struct user_namespace *task_ns)
+				struct user_namespace *task_ns,
+				struct user_namespace *user_ns)
 {
 	const struct vfs_ns_cap_data *nscap = value;
+	kuid_t rootkid;
 	uid_t rootid = 0;
 
 	if (size == XATTR_CAPS_SZ_3)
 		rootid = le32_to_cpu(nscap->rootid);
 
-	return make_kuid(task_ns, rootid);
+	rootkid = make_kuid(task_ns, rootid);
+	return kuid_from_mnt(user_ns, rootkid);
 }
 
 static bool validheader(size_t size, const struct vfs_cap_data *cap)
@@ -473,7 +476,8 @@ static bool validheader(size_t size, const struct vfs_cap_data *cap)
  *
  * If all is ok, we return the new size, on error return < 0.
  */
-int cap_convert_nscap(struct dentry *dentry, void **ivalue, size_t size)
+int cap_convert_nscap(struct user_namespace *user_ns, struct dentry *dentry,
+		      void **ivalue, size_t size)
 {
 	struct vfs_ns_cap_data *nscap;
 	uid_t nsrootid;
@@ -489,14 +493,14 @@ int cap_convert_nscap(struct dentry *dentry, void **ivalue, size_t size)
 		return -EINVAL;
 	if (!validheader(size, cap))
 		return -EINVAL;
-	if (!capable_wrt_inode_uidgid(&init_user_ns, inode, CAP_SETFCAP))
+	if (!capable_wrt_inode_uidgid(user_ns, inode, CAP_SETFCAP))
 		return -EPERM;
-	if (size == XATTR_CAPS_SZ_2)
+	if (size == XATTR_CAPS_SZ_2 && (user_ns == &init_user_ns))
 		if (ns_capable(inode->i_sb->s_user_ns, CAP_SETFCAP))
 			/* user is privileged, just write the v2 */
 			return size;
 
-	rootid = rootid_from_xattr(*ivalue, size, task_ns);
+	rootid = rootid_from_xattr(*ivalue, size, task_ns, user_ns);
 	if (!uid_valid(rootid))
 		return -EINVAL;
 
@@ -520,6 +524,7 @@ int cap_convert_nscap(struct dentry *dentry, void **ivalue, size_t size)
 	*ivalue = nscap;
 	return newsize;
 }
+EXPORT_SYMBOL(cap_convert_nscap);
 
 /*
  * Calculate the new process capability sets from the capability sets attached
-- 
2.29.2

