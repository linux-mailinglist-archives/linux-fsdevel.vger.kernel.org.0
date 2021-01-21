Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3692FEF06
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Jan 2021 16:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733065AbhAUPdu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Jan 2021 10:33:50 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:53891 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731835AbhAUNV5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Jan 2021 08:21:57 -0500
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1l2ZtI-0005g7-6I; Thu, 21 Jan 2021 13:20:48 +0000
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
Subject: [PATCH v6 07/40] attr: handle idmapped mounts
Date:   Thu, 21 Jan 2021 14:19:26 +0100
Message-Id: <20210121131959.646623-8-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210121131959.646623-1-christian.brauner@ubuntu.com>
References: <20210121131959.646623-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; i=ySHp/IRsSCZ22uUIZ1JWat8MdiucaagH+6NnvXYTxI4=; m=aSWTDwPpn9TNfTaBD/yVw5txtiUWuyyVu+Z7ZOEMLHs=; p=Wxynes6kia6fMPTcwTl/+bBPFilqM4hg5XTnsf9WsPw=; g=b10f55bbaaf47df48753204790e2f5ffaa4c2339
X-Patch-Sig: m=pgp; i=christian.brauner@ubuntu.com; s=0x0x91C61BC06578DCA2; b=iHUEABYKAB0WIQRAhzRXHqcMeLMyaSiRxhvAZXjcogUCYAl9owAKCRCRxhvAZXjcoiCtAP0W1Td O1d0Rc3S/KYziCa64c4VB50s6Xo4WKg1y+RtaIQD/QuCZpleah8Qqy29Bj7g0TJNlSD1Ie4PGMjBa 1smIgwE=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When file attributes are changed most filesystems rely on the
setattr_prepare(), setattr_copy(), and notify_change() helpers for
initialization and permission checking. Let them handle idmapped mounts.
If the inode is accessed through an idmapped mount map it into the
mount's user namespace. Afterwards the checks are identical to
non-idmapped mounts. If the initial user namespace is passed nothing
changes so non-idmapped mounts will see identical behavior as before.

Helpers that perform checks on the ia_uid and ia_gid fields in struct
iattr assume that ia_uid and ia_gid are intended values and have already
been mapped correctly at the userspace-kernelspace boundary as we
already do today. If the initial user namespace is passed nothing
changes so non-idmapped mounts will see identical behavior as before.

Link: https://lore.kernel.org/r/20210112220124.837960-14-christian.brauner@ubuntu.com
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
- kernel test robot <lkp@intel.com>:
  - Adapt __setattr_copy() in fs/f2fs when CONFIG_F2FS_FS_POSIX_ACL is
    selected.

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
  - Remove "extern" from headers.
---
 arch/powerpc/platforms/cell/spufs/inode.c |   2 +-
 drivers/base/devtmpfs.c                   |   4 +-
 fs/9p/vfs_inode.c                         |   4 +-
 fs/9p/vfs_inode_dotl.c                    |   4 +-
 fs/adfs/inode.c                           |   2 +-
 fs/affs/inode.c                           |   4 +-
 fs/attr.c                                 | 119 ++++++++++++++++------
 fs/btrfs/inode.c                          |   4 +-
 fs/cachefiles/interface.c                 |   4 +-
 fs/ceph/inode.c                           |   2 +-
 fs/cifs/inode.c                           |   8 +-
 fs/ecryptfs/inode.c                       |   7 +-
 fs/exfat/file.c                           |   4 +-
 fs/ext2/inode.c                           |   4 +-
 fs/ext4/inode.c                           |   4 +-
 fs/f2fs/file.c                            |  10 +-
 fs/fat/file.c                             |   4 +-
 fs/fuse/dir.c                             |   2 +-
 fs/gfs2/inode.c                           |   4 +-
 fs/hfs/inode.c                            |   4 +-
 fs/hfsplus/inode.c                        |   4 +-
 fs/hostfs/hostfs_kern.c                   |   4 +-
 fs/hpfs/inode.c                           |   4 +-
 fs/hugetlbfs/inode.c                      |   4 +-
 fs/inode.c                                |   2 +-
 fs/jffs2/fs.c                             |   2 +-
 fs/jfs/file.c                             |   4 +-
 fs/kernfs/inode.c                         |   4 +-
 fs/libfs.c                                |   4 +-
 fs/minix/file.c                           |   4 +-
 fs/nfsd/nfsproc.c                         |   2 +-
 fs/nfsd/vfs.c                             |   4 +-
 fs/nilfs2/inode.c                         |   4 +-
 fs/ntfs/inode.c                           |   2 +-
 fs/ocfs2/dlmfs/dlmfs.c                    |   4 +-
 fs/ocfs2/file.c                           |   4 +-
 fs/omfs/file.c                            |   4 +-
 fs/open.c                                 |   8 +-
 fs/orangefs/inode.c                       |   4 +-
 fs/overlayfs/copy_up.c                    |   8 +-
 fs/overlayfs/dir.c                        |   2 +-
 fs/overlayfs/inode.c                      |   4 +-
 fs/overlayfs/super.c                      |   2 +-
 fs/proc/base.c                            |   4 +-
 fs/proc/generic.c                         |   4 +-
 fs/proc/proc_sysctl.c                     |   4 +-
 fs/ramfs/file-nommu.c                     |   4 +-
 fs/reiserfs/inode.c                       |   4 +-
 fs/sysv/file.c                            |   4 +-
 fs/ubifs/file.c                           |   2 +-
 fs/udf/file.c                             |   4 +-
 fs/ufs/inode.c                            |   4 +-
 fs/utimes.c                               |   3 +-
 fs/xfs/xfs_iops.c                         |   2 +-
 fs/zonefs/super.c                         |   4 +-
 include/linux/fs.h                        |   8 +-
 mm/shmem.c                                |   4 +-
 57 files changed, 206 insertions(+), 137 deletions(-)

diff --git a/arch/powerpc/platforms/cell/spufs/inode.c b/arch/powerpc/platforms/cell/spufs/inode.c
index 25390569e24c..3de526eb2275 100644
--- a/arch/powerpc/platforms/cell/spufs/inode.c
+++ b/arch/powerpc/platforms/cell/spufs/inode.c
@@ -98,7 +98,7 @@ spufs_setattr(struct dentry *dentry, struct iattr *attr)
 	if ((attr->ia_valid & ATTR_SIZE) &&
 	    (attr->ia_size != inode->i_size))
 		return -EINVAL;
-	setattr_copy(inode, attr);
+	setattr_copy(&init_user_ns, inode, attr);
 	mark_inode_dirty(inode);
 	return 0;
 }
diff --git a/drivers/base/devtmpfs.c b/drivers/base/devtmpfs.c
index eac184e6d657..2e0c3cdb4184 100644
--- a/drivers/base/devtmpfs.c
+++ b/drivers/base/devtmpfs.c
@@ -221,7 +221,7 @@ static int handle_create(const char *nodename, umode_t mode, kuid_t uid,
 		newattrs.ia_gid = gid;
 		newattrs.ia_valid = ATTR_MODE|ATTR_UID|ATTR_GID;
 		inode_lock(d_inode(dentry));
-		notify_change(dentry, &newattrs, NULL);
+		notify_change(&init_user_ns, dentry, &newattrs, NULL);
 		inode_unlock(d_inode(dentry));
 
 		/* mark as kernel-created inode */
@@ -328,7 +328,7 @@ static int handle_remove(const char *nodename, struct device *dev)
 			newattrs.ia_valid =
 				ATTR_UID|ATTR_GID|ATTR_MODE;
 			inode_lock(d_inode(dentry));
-			notify_change(dentry, &newattrs, NULL);
+			notify_change(&init_user_ns, dentry, &newattrs, NULL);
 			inode_unlock(d_inode(dentry));
 			err = vfs_unlink(d_inode(parent.dentry), dentry, NULL);
 			if (!err || err == -ENOENT)
diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index f66eb3c12c8a..9c3ff6e9ab82 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -1062,7 +1062,7 @@ static int v9fs_vfs_setattr(struct dentry *dentry, struct iattr *iattr)
 	struct p9_wstat wstat;
 
 	p9_debug(P9_DEBUG_VFS, "\n");
-	retval = setattr_prepare(dentry, iattr);
+	retval = setattr_prepare(&init_user_ns, dentry, iattr);
 	if (retval)
 		return retval;
 
@@ -1118,7 +1118,7 @@ static int v9fs_vfs_setattr(struct dentry *dentry, struct iattr *iattr)
 
 	v9fs_invalidate_inode_attr(d_inode(dentry));
 
-	setattr_copy(d_inode(dentry), iattr);
+	setattr_copy(&init_user_ns, d_inode(dentry), iattr);
 	mark_inode_dirty(d_inode(dentry));
 	return 0;
 }
diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index 823c2eb5f1bf..302553101fcb 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -549,7 +549,7 @@ int v9fs_vfs_setattr_dotl(struct dentry *dentry, struct iattr *iattr)
 
 	p9_debug(P9_DEBUG_VFS, "\n");
 
-	retval = setattr_prepare(dentry, iattr);
+	retval = setattr_prepare(&init_user_ns, dentry, iattr);
 	if (retval)
 		return retval;
 
@@ -590,7 +590,7 @@ int v9fs_vfs_setattr_dotl(struct dentry *dentry, struct iattr *iattr)
 		truncate_setsize(inode, iattr->ia_size);
 
 	v9fs_invalidate_inode_attr(inode);
-	setattr_copy(inode, iattr);
+	setattr_copy(&init_user_ns, inode, iattr);
 	mark_inode_dirty(inode);
 	if (iattr->ia_valid & ATTR_MODE) {
 		/* We also want to update ACL when we update mode bits */
diff --git a/fs/adfs/inode.c b/fs/adfs/inode.c
index 32620f4a7623..278dcee6ae22 100644
--- a/fs/adfs/inode.c
+++ b/fs/adfs/inode.c
@@ -299,7 +299,7 @@ adfs_notify_change(struct dentry *dentry, struct iattr *attr)
 	unsigned int ia_valid = attr->ia_valid;
 	int error;
 	
-	error = setattr_prepare(dentry, attr);
+	error = setattr_prepare(&init_user_ns, dentry, attr);
 
 	/*
 	 * we can't change the UID or GID of any file -
diff --git a/fs/affs/inode.c b/fs/affs/inode.c
index 044412110b52..767e5bdfb703 100644
--- a/fs/affs/inode.c
+++ b/fs/affs/inode.c
@@ -223,7 +223,7 @@ affs_notify_change(struct dentry *dentry, struct iattr *attr)
 
 	pr_debug("notify_change(%lu,0x%x)\n", inode->i_ino, attr->ia_valid);
 
-	error = setattr_prepare(dentry, attr);
+	error = setattr_prepare(&init_user_ns, dentry, attr);
 	if (error)
 		goto out;
 
@@ -249,7 +249,7 @@ affs_notify_change(struct dentry *dentry, struct iattr *attr)
 		affs_truncate(inode);
 	}
 
-	setattr_copy(inode, attr);
+	setattr_copy(&init_user_ns, inode, attr);
 	mark_inode_dirty(inode);
 
 	if (attr->ia_valid & ATTR_MODE)
diff --git a/fs/attr.c b/fs/attr.c
index 00ae0b000146..f4543d2abdfb 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -18,27 +18,55 @@
 #include <linux/evm.h>
 #include <linux/ima.h>
 
-static bool chown_ok(const struct inode *inode, kuid_t uid)
+/**
+ * chown_ok - verify permissions to chown inode
+ * @mnt_userns:	user namespace of the mount @inode was found from
+ * @inode:	inode to check permissions on
+ * @uid:	uid to chown @inode to
+ *
+ * If the inode has been found through an idmapped mount the user namespace of
+ * the vfsmount must be passed through @mnt_userns. This function will then
+ * take care to map the inode according to @mnt_userns before checking
+ * permissions. On non-idmapped mounts or if permission checking is to be
+ * performed on the raw inode simply passs init_user_ns.
+ */
+static bool chown_ok(struct user_namespace *mnt_userns,
+		     const struct inode *inode,
+		     kuid_t uid)
 {
-	if (uid_eq(current_fsuid(), inode->i_uid) &&
-	    uid_eq(uid, inode->i_uid))
+	kuid_t kuid = i_uid_into_mnt(mnt_userns, inode);
+	if (uid_eq(current_fsuid(), kuid) && uid_eq(uid, kuid))
 		return true;
-	if (capable_wrt_inode_uidgid(&init_user_ns, inode, CAP_CHOWN))
+	if (capable_wrt_inode_uidgid(mnt_userns, inode, CAP_CHOWN))
 		return true;
-	if (uid_eq(inode->i_uid, INVALID_UID) &&
+	if (uid_eq(kuid, INVALID_UID) &&
 	    ns_capable(inode->i_sb->s_user_ns, CAP_CHOWN))
 		return true;
 	return false;
 }
 
-static bool chgrp_ok(const struct inode *inode, kgid_t gid)
+/**
+ * chgrp_ok - verify permissions to chgrp inode
+ * @mnt_userns:	user namespace of the mount @inode was found from
+ * @inode:	inode to check permissions on
+ * @gid:	gid to chown @inode to
+ *
+ * If the inode has been found through an idmapped mount the user namespace of
+ * the vfsmount must be passed through @mnt_userns. This function will then
+ * take care to map the inode according to @mnt_userns before checking
+ * permissions. On non-idmapped mounts or if permission checking is to be
+ * performed on the raw inode simply passs init_user_ns.
+ */
+static bool chgrp_ok(struct user_namespace *mnt_userns,
+		     const struct inode *inode, kgid_t gid)
 {
-	if (uid_eq(current_fsuid(), inode->i_uid) &&
-	    (in_group_p(gid) || gid_eq(gid, inode->i_gid)))
+	kgid_t kgid = i_gid_into_mnt(mnt_userns, inode);
+	if (uid_eq(current_fsuid(), i_uid_into_mnt(mnt_userns, inode)) &&
+	    (in_group_p(gid) || gid_eq(gid, kgid)))
 		return true;
-	if (capable_wrt_inode_uidgid(&init_user_ns, inode, CAP_CHOWN))
+	if (capable_wrt_inode_uidgid(mnt_userns, inode, CAP_CHOWN))
 		return true;
-	if (gid_eq(inode->i_gid, INVALID_GID) &&
+	if (gid_eq(kgid, INVALID_GID) &&
 	    ns_capable(inode->i_sb->s_user_ns, CAP_CHOWN))
 		return true;
 	return false;
@@ -46,6 +74,7 @@ static bool chgrp_ok(const struct inode *inode, kgid_t gid)
 
 /**
  * setattr_prepare - check if attribute changes to a dentry are allowed
+ * @mnt_userns:	user namespace of the mount the inode was found from
  * @dentry:	dentry to check
  * @attr:	attributes to change
  *
@@ -55,10 +84,17 @@ static bool chgrp_ok(const struct inode *inode, kgid_t gid)
  * SGID bit from mode if user is not allowed to set it. Also file capabilities
  * and IMA extended attributes are cleared if ATTR_KILL_PRIV is set.
  *
+ * If the inode has been found through an idmapped mount the user namespace of
+ * the vfsmount must be passed through @mnt_userns. This function will then
+ * take care to map the inode according to @mnt_userns before checking
+ * permissions. On non-idmapped mounts or if permission checking is to be
+ * performed on the raw inode simply passs init_user_ns.
+ *
  * Should be called as the first thing in ->setattr implementations,
  * possibly after taking additional locks.
  */
-int setattr_prepare(struct dentry *dentry, struct iattr *attr)
+int setattr_prepare(struct user_namespace *mnt_userns, struct dentry *dentry,
+		    struct iattr *attr)
 {
 	struct inode *inode = d_inode(dentry);
 	unsigned int ia_valid = attr->ia_valid;
@@ -78,27 +114,27 @@ int setattr_prepare(struct dentry *dentry, struct iattr *attr)
 		goto kill_priv;
 
 	/* Make sure a caller can chown. */
-	if ((ia_valid & ATTR_UID) && !chown_ok(inode, attr->ia_uid))
+	if ((ia_valid & ATTR_UID) && !chown_ok(mnt_userns, inode, attr->ia_uid))
 		return -EPERM;
 
 	/* Make sure caller can chgrp. */
-	if ((ia_valid & ATTR_GID) && !chgrp_ok(inode, attr->ia_gid))
+	if ((ia_valid & ATTR_GID) && !chgrp_ok(mnt_userns, inode, attr->ia_gid))
 		return -EPERM;
 
 	/* Make sure a caller can chmod. */
 	if (ia_valid & ATTR_MODE) {
-		if (!inode_owner_or_capable(&init_user_ns, inode))
+		if (!inode_owner_or_capable(mnt_userns, inode))
 			return -EPERM;
 		/* Also check the setgid bit! */
-		if (!in_group_p((ia_valid & ATTR_GID) ? attr->ia_gid :
-				inode->i_gid) &&
-		    !capable_wrt_inode_uidgid(&init_user_ns, inode, CAP_FSETID))
+               if (!in_group_p((ia_valid & ATTR_GID) ? attr->ia_gid :
+                                i_gid_into_mnt(mnt_userns, inode)) &&
+                    !capable_wrt_inode_uidgid(mnt_userns, inode, CAP_FSETID))
 			attr->ia_mode &= ~S_ISGID;
 	}
 
 	/* Check for setting the inode time. */
 	if (ia_valid & (ATTR_MTIME_SET | ATTR_ATIME_SET | ATTR_TIMES_SET)) {
-		if (!inode_owner_or_capable(&init_user_ns, inode))
+		if (!inode_owner_or_capable(mnt_userns, inode))
 			return -EPERM;
 	}
 
@@ -162,20 +198,33 @@ EXPORT_SYMBOL(inode_newsize_ok);
 
 /**
  * setattr_copy - copy simple metadata updates into the generic inode
+ * @mnt_userns:	user namespace of the mount the inode was found from
  * @inode:	the inode to be updated
  * @attr:	the new attributes
  *
  * setattr_copy must be called with i_mutex held.
  *
  * setattr_copy updates the inode's metadata with that specified
- * in attr. Noticeably missing is inode size update, which is more complex
+ * in attr on idmapped mounts. If file ownership is changed setattr_copy
+ * doesn't map ia_uid and ia_gid. It will asssume the caller has already
+ * provided the intended values. Necessary permission checks to determine
+ * whether or not the S_ISGID property needs to be removed are performed with
+ * the correct idmapped mount permission helpers.
+ * Noticeably missing is inode size update, which is more complex
  * as it requires pagecache updates.
  *
+ * If the inode has been found through an idmapped mount the user namespace of
+ * the vfsmount must be passed through @mnt_userns. This function will then
+ * take care to map the inode according to @mnt_userns before checking
+ * permissions. On non-idmapped mounts or if permission checking is to be
+ * performed on the raw inode simply passs init_user_ns.
+ *
  * The inode is not marked as dirty after this operation. The rationale is
  * that for "simple" filesystems, the struct inode is the inode storage.
  * The caller is free to mark the inode dirty afterwards if needed.
  */
-void setattr_copy(struct inode *inode, const struct iattr *attr)
+void setattr_copy(struct user_namespace *mnt_userns, struct inode *inode,
+		  const struct iattr *attr)
 {
 	unsigned int ia_valid = attr->ia_valid;
 
@@ -191,9 +240,9 @@ void setattr_copy(struct inode *inode, const struct iattr *attr)
 		inode->i_ctime = attr->ia_ctime;
 	if (ia_valid & ATTR_MODE) {
 		umode_t mode = attr->ia_mode;
-
-		if (!in_group_p(inode->i_gid) &&
-		    !capable_wrt_inode_uidgid(&init_user_ns, inode, CAP_FSETID))
+		kgid_t kgid = i_gid_into_mnt(mnt_userns, inode);
+		if (!in_group_p(kgid) &&
+		    !capable_wrt_inode_uidgid(mnt_userns, inode, CAP_FSETID))
 			mode &= ~S_ISGID;
 		inode->i_mode = mode;
 	}
@@ -202,6 +251,7 @@ EXPORT_SYMBOL(setattr_copy);
 
 /**
  * notify_change - modify attributes of a filesytem object
+ * @mnt_userns:	user namespace of the mount the inode was found from
  * @dentry:	object affected
  * @attr:	new attributes
  * @delegated_inode: returns inode, if the inode is delegated
@@ -214,13 +264,23 @@ EXPORT_SYMBOL(setattr_copy);
  * retry.  Because breaking a delegation may take a long time, the
  * caller should drop the i_mutex before doing so.
  *
+ * If file ownership is changed notify_change() doesn't map ia_uid and
+ * ia_gid. It will asssume the caller has already provided the intended values.
+ *
  * Alternatively, a caller may pass NULL for delegated_inode.  This may
  * be appropriate for callers that expect the underlying filesystem not
  * to be NFS exported.  Also, passing NULL is fine for callers holding
  * the file open for write, as there can be no conflicting delegation in
  * that case.
+ *
+ * If the inode has been found through an idmapped mount the user namespace of
+ * the vfsmount must be passed through @mnt_userns. This function will then
+ * take care to map the inode according to @mnt_userns before checking
+ * permissions. On non-idmapped mounts or if permission checking is to be
+ * performed on the raw inode simply passs init_user_ns.
  */
-int notify_change(struct dentry * dentry, struct iattr * attr, struct inode **delegated_inode)
+int notify_change(struct user_namespace *mnt_userns, struct dentry *dentry,
+		  struct iattr *attr, struct inode **delegated_inode)
 {
 	struct inode *inode = dentry->d_inode;
 	umode_t mode = inode->i_mode;
@@ -243,9 +303,8 @@ int notify_change(struct dentry * dentry, struct iattr * attr, struct inode **de
 		if (IS_IMMUTABLE(inode))
 			return -EPERM;
 
-		if (!inode_owner_or_capable(&init_user_ns, inode)) {
-			error = inode_permission(&init_user_ns, inode,
-						 MAY_WRITE);
+		if (!inode_owner_or_capable(mnt_userns, inode)) {
+			error = inode_permission(mnt_userns, inode, MAY_WRITE);
 			if (error)
 				return error;
 		}
@@ -321,9 +380,11 @@ int notify_change(struct dentry * dentry, struct iattr * attr, struct inode **de
 	/* Don't allow modifications of files with invalid uids or
 	 * gids unless those uids & gids are being made valid.
 	 */
-	if (!(ia_valid & ATTR_UID) && !uid_valid(inode->i_uid))
+	if (!(ia_valid & ATTR_UID) &&
+	    !uid_valid(i_uid_into_mnt(mnt_userns, inode)))
 		return -EOVERFLOW;
-	if (!(ia_valid & ATTR_GID) && !gid_valid(inode->i_gid))
+	if (!(ia_valid & ATTR_GID) &&
+	    !gid_valid(i_gid_into_mnt(mnt_userns, inode)))
 		return -EOVERFLOW;
 
 	error = security_inode_setattr(dentry, attr);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 07fe8b2f3bab..792191a8705b 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5054,7 +5054,7 @@ static int btrfs_setattr(struct dentry *dentry, struct iattr *attr)
 	if (btrfs_root_readonly(root))
 		return -EROFS;
 
-	err = setattr_prepare(dentry, attr);
+	err = setattr_prepare(&init_user_ns, dentry, attr);
 	if (err)
 		return err;
 
@@ -5065,7 +5065,7 @@ static int btrfs_setattr(struct dentry *dentry, struct iattr *attr)
 	}
 
 	if (attr->ia_valid) {
-		setattr_copy(inode, attr);
+		setattr_copy(&init_user_ns, inode, attr);
 		inode_inc_iversion(inode);
 		err = btrfs_dirty_inode(inode);
 
diff --git a/fs/cachefiles/interface.c b/fs/cachefiles/interface.c
index 4cea5fbf695e..5efa6a3702c0 100644
--- a/fs/cachefiles/interface.c
+++ b/fs/cachefiles/interface.c
@@ -470,14 +470,14 @@ static int cachefiles_attr_changed(struct fscache_object *_object)
 		_debug("discard tail %llx", oi_size);
 		newattrs.ia_valid = ATTR_SIZE;
 		newattrs.ia_size = oi_size & PAGE_MASK;
-		ret = notify_change(object->backer, &newattrs, NULL);
+		ret = notify_change(&init_user_ns, object->backer, &newattrs, NULL);
 		if (ret < 0)
 			goto truncate_failed;
 	}
 
 	newattrs.ia_valid = ATTR_SIZE;
 	newattrs.ia_size = ni_size;
-	ret = notify_change(object->backer, &newattrs, NULL);
+	ret = notify_change(&init_user_ns, object->backer, &newattrs, NULL);
 
 truncate_failed:
 	inode_unlock(d_inode(object->backer));
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index e8a15ee09bc1..285d3baca27e 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -2247,7 +2247,7 @@ int ceph_setattr(struct dentry *dentry, struct iattr *attr)
 	if (ceph_snap(inode) != CEPH_NOSNAP)
 		return -EROFS;
 
-	err = setattr_prepare(dentry, attr);
+	err = setattr_prepare(&init_user_ns, dentry, attr);
 	if (err != 0)
 		return err;
 
diff --git a/fs/cifs/inode.c b/fs/cifs/inode.c
index a83b3a8ffaac..27554f71f744 100644
--- a/fs/cifs/inode.c
+++ b/fs/cifs/inode.c
@@ -2610,7 +2610,7 @@ cifs_setattr_unix(struct dentry *direntry, struct iattr *attrs)
 	if (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_NO_PERM)
 		attrs->ia_valid |= ATTR_FORCE;
 
-	rc = setattr_prepare(direntry, attrs);
+	rc = setattr_prepare(&init_user_ns, direntry, attrs);
 	if (rc < 0)
 		goto out;
 
@@ -2715,7 +2715,7 @@ cifs_setattr_unix(struct dentry *direntry, struct iattr *attrs)
 	    attrs->ia_size != i_size_read(inode))
 		truncate_setsize(inode, attrs->ia_size);
 
-	setattr_copy(inode, attrs);
+	setattr_copy(&init_user_ns, inode, attrs);
 	mark_inode_dirty(inode);
 
 	/* force revalidate when any of these times are set since some
@@ -2757,7 +2757,7 @@ cifs_setattr_nounix(struct dentry *direntry, struct iattr *attrs)
 	if (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_NO_PERM)
 		attrs->ia_valid |= ATTR_FORCE;
 
-	rc = setattr_prepare(direntry, attrs);
+	rc = setattr_prepare(&init_user_ns, direntry, attrs);
 	if (rc < 0) {
 		free_xid(xid);
 		return rc;
@@ -2913,7 +2913,7 @@ cifs_setattr_nounix(struct dentry *direntry, struct iattr *attrs)
 	    attrs->ia_size != i_size_read(inode))
 		truncate_setsize(inode, attrs->ia_size);
 
-	setattr_copy(inode, attrs);
+	setattr_copy(&init_user_ns, inode, attrs);
 	mark_inode_dirty(inode);
 
 cifs_setattr_exit:
diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index 0b346baf110d..d3ea0c57b075 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -855,7 +855,8 @@ int ecryptfs_truncate(struct dentry *dentry, loff_t new_length)
 		struct dentry *lower_dentry = ecryptfs_dentry_to_lower(dentry);
 
 		inode_lock(d_inode(lower_dentry));
-		rc = notify_change(lower_dentry, &lower_ia, NULL);
+		rc = notify_change(&init_user_ns, lower_dentry,
+				   &lower_ia, NULL);
 		inode_unlock(d_inode(lower_dentry));
 	}
 	return rc;
@@ -934,7 +935,7 @@ static int ecryptfs_setattr(struct dentry *dentry, struct iattr *ia)
 	}
 	mutex_unlock(&crypt_stat->cs_mutex);
 
-	rc = setattr_prepare(dentry, ia);
+	rc = setattr_prepare(&init_user_ns, dentry, ia);
 	if (rc)
 		goto out;
 	if (ia->ia_valid & ATTR_SIZE) {
@@ -960,7 +961,7 @@ static int ecryptfs_setattr(struct dentry *dentry, struct iattr *ia)
 		lower_ia.ia_valid &= ~ATTR_MODE;
 
 	inode_lock(d_inode(lower_dentry));
-	rc = notify_change(lower_dentry, &lower_ia, NULL);
+	rc = notify_change(&init_user_ns, lower_dentry, &lower_ia, NULL);
 	inode_unlock(d_inode(lower_dentry));
 out:
 	fsstack_copy_attr_all(inode, lower_inode);
diff --git a/fs/exfat/file.c b/fs/exfat/file.c
index a92478eabfa4..ace35aa8e64b 100644
--- a/fs/exfat/file.c
+++ b/fs/exfat/file.c
@@ -305,7 +305,7 @@ int exfat_setattr(struct dentry *dentry, struct iattr *attr)
 				ATTR_TIMES_SET);
 	}
 
-	error = setattr_prepare(dentry, attr);
+	error = setattr_prepare(&init_user_ns, dentry, attr);
 	attr->ia_valid = ia_valid;
 	if (error)
 		goto out;
@@ -340,7 +340,7 @@ int exfat_setattr(struct dentry *dentry, struct iattr *attr)
 		up_write(&EXFAT_I(inode)->truncate_lock);
 	}
 
-	setattr_copy(inode, attr);
+	setattr_copy(&init_user_ns, inode, attr);
 	exfat_truncate_atime(&inode->i_atime);
 	mark_inode_dirty(inode);
 
diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
index 78c417d3c898..06c0cf28c1a0 100644
--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -1669,7 +1669,7 @@ int ext2_setattr(struct dentry *dentry, struct iattr *iattr)
 	struct inode *inode = d_inode(dentry);
 	int error;
 
-	error = setattr_prepare(dentry, iattr);
+	error = setattr_prepare(&init_user_ns, dentry, iattr);
 	if (error)
 		return error;
 
@@ -1689,7 +1689,7 @@ int ext2_setattr(struct dentry *dentry, struct iattr *iattr)
 		if (error)
 			return error;
 	}
-	setattr_copy(inode, iattr);
+	setattr_copy(&init_user_ns, inode, iattr);
 	if (iattr->ia_valid & ATTR_MODE)
 		error = posix_acl_chmod(inode, inode->i_mode);
 	mark_inode_dirty(inode);
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index c173c8405856..8edfa3e226e6 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5337,7 +5337,7 @@ int ext4_setattr(struct dentry *dentry, struct iattr *attr)
 				  ATTR_GID | ATTR_TIMES_SET))))
 		return -EPERM;
 
-	error = setattr_prepare(dentry, attr);
+	error = setattr_prepare(&init_user_ns, dentry, attr);
 	if (error)
 		return error;
 
@@ -5512,7 +5512,7 @@ int ext4_setattr(struct dentry *dentry, struct iattr *attr)
 	}
 
 	if (!error) {
-		setattr_copy(inode, attr);
+		setattr_copy(&init_user_ns, inode, attr);
 		mark_inode_dirty(inode);
 	}
 
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 5fc0ff28b5dd..90d7b89176de 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -831,7 +831,8 @@ int f2fs_getattr(const struct path *path, struct kstat *stat,
 }
 
 #ifdef CONFIG_F2FS_FS_POSIX_ACL
-static void __setattr_copy(struct inode *inode, const struct iattr *attr)
+static void __setattr_copy(struct user_namespace *mnt_userns, struct inode *inode,
+			   const struct iattr *attr)
 {
 	unsigned int ia_valid = attr->ia_valid;
 
@@ -847,8 +848,9 @@ static void __setattr_copy(struct inode *inode, const struct iattr *attr)
 		inode->i_ctime = attr->ia_ctime;
 	if (ia_valid & ATTR_MODE) {
 		umode_t mode = attr->ia_mode;
+		kgid_t kgid = i_gid_into_mnt(mnt_userns, inode);
 
-		if (!in_group_p(inode->i_gid) && !capable(CAP_FSETID))
+		if (!in_group_p(kgid) && !capable(CAP_FSETID))
 			mode &= ~S_ISGID;
 		set_acl_inode(inode, mode);
 	}
@@ -869,7 +871,7 @@ int f2fs_setattr(struct dentry *dentry, struct iattr *attr)
 		!f2fs_is_compress_backend_ready(inode))
 		return -EOPNOTSUPP;
 
-	err = setattr_prepare(dentry, attr);
+	err = setattr_prepare(&init_user_ns, dentry, attr);
 	if (err)
 		return err;
 
@@ -945,7 +947,7 @@ int f2fs_setattr(struct dentry *dentry, struct iattr *attr)
 		spin_unlock(&F2FS_I(inode)->i_size_lock);
 	}
 
-	__setattr_copy(inode, attr);
+	__setattr_copy(&init_user_ns, inode, attr);
 
 	if (attr->ia_valid & ATTR_MODE) {
 		err = posix_acl_chmod(inode, f2fs_get_inode_mode(inode));
diff --git a/fs/fat/file.c b/fs/fat/file.c
index f9ee27cf4d7c..805b501467e9 100644
--- a/fs/fat/file.c
+++ b/fs/fat/file.c
@@ -480,7 +480,7 @@ int fat_setattr(struct dentry *dentry, struct iattr *attr)
 			attr->ia_valid &= ~TIMES_SET_FLAGS;
 	}
 
-	error = setattr_prepare(dentry, attr);
+	error = setattr_prepare(&init_user_ns, dentry, attr);
 	attr->ia_valid = ia_valid;
 	if (error) {
 		if (sbi->options.quiet)
@@ -550,7 +550,7 @@ int fat_setattr(struct dentry *dentry, struct iattr *attr)
 		fat_truncate_time(inode, &attr->ia_mtime, S_MTIME);
 	attr->ia_valid &= ~(ATTR_ATIME|ATTR_CTIME|ATTR_MTIME);
 
-	setattr_copy(inode, attr);
+	setattr_copy(&init_user_ns, inode, attr);
 	mark_inode_dirty(inode);
 out:
 	return error;
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 7497009a5a45..74fdb6a7ebb3 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1611,7 +1611,7 @@ int fuse_do_setattr(struct dentry *dentry, struct iattr *attr,
 	if (!fc->default_permissions)
 		attr->ia_valid |= ATTR_FORCE;
 
-	err = setattr_prepare(dentry, attr);
+	err = setattr_prepare(&init_user_ns, dentry, attr);
 	if (err)
 		return err;
 
diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index 5b2ff0c74b67..59c25181d108 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -1861,7 +1861,7 @@ int gfs2_permission(struct inode *inode, int mask)
 
 static int __gfs2_setattr_simple(struct inode *inode, struct iattr *attr)
 {
-	setattr_copy(inode, attr);
+	setattr_copy(&init_user_ns, inode, attr);
 	mark_inode_dirty(inode);
 	return 0;
 }
@@ -1982,7 +1982,7 @@ static int gfs2_setattr(struct dentry *dentry, struct iattr *attr)
 	if (IS_IMMUTABLE(inode) || IS_APPEND(inode))
 		goto error;
 
-	error = setattr_prepare(dentry, attr);
+	error = setattr_prepare(&init_user_ns, dentry, attr);
 	if (error)
 		goto error;
 
diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
index f35a37c65e5f..c646218b72bf 100644
--- a/fs/hfs/inode.c
+++ b/fs/hfs/inode.c
@@ -608,7 +608,7 @@ int hfs_inode_setattr(struct dentry *dentry, struct iattr * attr)
 	struct hfs_sb_info *hsb = HFS_SB(inode->i_sb);
 	int error;
 
-	error = setattr_prepare(dentry, attr); /* basic permission checks */
+	error = setattr_prepare(&init_user_ns, dentry, attr); /* basic permission checks */
 	if (error)
 		return error;
 
@@ -647,7 +647,7 @@ int hfs_inode_setattr(struct dentry *dentry, struct iattr * attr)
 						  current_time(inode);
 	}
 
-	setattr_copy(inode, attr);
+	setattr_copy(&init_user_ns, inode, attr);
 	mark_inode_dirty(inode);
 	return 0;
 }
diff --git a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
index 21357046b039..ffa137f8234e 100644
--- a/fs/hfsplus/inode.c
+++ b/fs/hfsplus/inode.c
@@ -246,7 +246,7 @@ static int hfsplus_setattr(struct dentry *dentry, struct iattr *attr)
 	struct inode *inode = d_inode(dentry);
 	int error;
 
-	error = setattr_prepare(dentry, attr);
+	error = setattr_prepare(&init_user_ns, dentry, attr);
 	if (error)
 		return error;
 
@@ -264,7 +264,7 @@ static int hfsplus_setattr(struct dentry *dentry, struct iattr *attr)
 		inode->i_mtime = inode->i_ctime = current_time(inode);
 	}
 
-	setattr_copy(inode, attr);
+	setattr_copy(&init_user_ns, inode, attr);
 	mark_inode_dirty(inode);
 
 	return 0;
diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index b841a05a2b8c..6970e29a5287 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -792,7 +792,7 @@ static int hostfs_setattr(struct dentry *dentry, struct iattr *attr)
 
 	int fd = HOSTFS_I(inode)->fd;
 
-	err = setattr_prepare(dentry, attr);
+	err = setattr_prepare(&init_user_ns, dentry, attr);
 	if (err)
 		return err;
 
@@ -849,7 +849,7 @@ static int hostfs_setattr(struct dentry *dentry, struct iattr *attr)
 	    attr->ia_size != i_size_read(inode))
 		truncate_setsize(inode, attr->ia_size);
 
-	setattr_copy(inode, attr);
+	setattr_copy(&init_user_ns, inode, attr);
 	mark_inode_dirty(inode);
 	return 0;
 }
diff --git a/fs/hpfs/inode.c b/fs/hpfs/inode.c
index eb8b4baf0f2e..8ba2152a78ba 100644
--- a/fs/hpfs/inode.c
+++ b/fs/hpfs/inode.c
@@ -274,7 +274,7 @@ int hpfs_setattr(struct dentry *dentry, struct iattr *attr)
 	if ((attr->ia_valid & ATTR_SIZE) && attr->ia_size > inode->i_size)
 		goto out_unlock;
 
-	error = setattr_prepare(dentry, attr);
+	error = setattr_prepare(&init_user_ns, dentry, attr);
 	if (error)
 		goto out_unlock;
 
@@ -288,7 +288,7 @@ int hpfs_setattr(struct dentry *dentry, struct iattr *attr)
 		hpfs_truncate(inode);
 	}
 
-	setattr_copy(inode, attr);
+	setattr_copy(&init_user_ns, inode, attr);
 
 	hpfs_write_inode(inode);
 
diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 6737929e443c..327e572b4e00 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -761,7 +761,7 @@ static int hugetlbfs_setattr(struct dentry *dentry, struct iattr *attr)
 
 	BUG_ON(!inode);
 
-	error = setattr_prepare(dentry, attr);
+	error = setattr_prepare(&init_user_ns, dentry, attr);
 	if (error)
 		return error;
 
@@ -780,7 +780,7 @@ static int hugetlbfs_setattr(struct dentry *dentry, struct iattr *attr)
 			return error;
 	}
 
-	setattr_copy(inode, attr);
+	setattr_copy(&init_user_ns, inode, attr);
 	mark_inode_dirty(inode);
 	return 0;
 }
diff --git a/fs/inode.c b/fs/inode.c
index a9ac97a27784..49b512592dcd 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1912,7 +1912,7 @@ static int __remove_privs(struct dentry *dentry, int kill)
 	 * Note we call this on write, so notify_change will not
 	 * encounter any conflicting delegations:
 	 */
-	return notify_change(dentry, &newattrs, NULL);
+	return notify_change(&init_user_ns, dentry, &newattrs, NULL);
 }
 
 /*
diff --git a/fs/jffs2/fs.c b/fs/jffs2/fs.c
index 78858f6e9583..67993808f4da 100644
--- a/fs/jffs2/fs.c
+++ b/fs/jffs2/fs.c
@@ -195,7 +195,7 @@ int jffs2_setattr(struct dentry *dentry, struct iattr *iattr)
 	struct inode *inode = d_inode(dentry);
 	int rc;
 
-	rc = setattr_prepare(dentry, iattr);
+	rc = setattr_prepare(&init_user_ns, dentry, iattr);
 	if (rc)
 		return rc;
 
diff --git a/fs/jfs/file.c b/fs/jfs/file.c
index 930d2701f206..ff49876e9c9b 100644
--- a/fs/jfs/file.c
+++ b/fs/jfs/file.c
@@ -90,7 +90,7 @@ int jfs_setattr(struct dentry *dentry, struct iattr *iattr)
 	struct inode *inode = d_inode(dentry);
 	int rc;
 
-	rc = setattr_prepare(dentry, iattr);
+	rc = setattr_prepare(&init_user_ns, dentry, iattr);
 	if (rc)
 		return rc;
 
@@ -118,7 +118,7 @@ int jfs_setattr(struct dentry *dentry, struct iattr *iattr)
 		jfs_truncate(inode);
 	}
 
-	setattr_copy(inode, iattr);
+	setattr_copy(&init_user_ns, inode, iattr);
 	mark_inode_dirty(inode);
 
 	if (iattr->ia_valid & ATTR_MODE)
diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
index ff5598cc1de0..86bd4c593b78 100644
--- a/fs/kernfs/inode.c
+++ b/fs/kernfs/inode.c
@@ -122,7 +122,7 @@ int kernfs_iop_setattr(struct dentry *dentry, struct iattr *iattr)
 		return -EINVAL;
 
 	mutex_lock(&kernfs_mutex);
-	error = setattr_prepare(dentry, iattr);
+	error = setattr_prepare(&init_user_ns, dentry, iattr);
 	if (error)
 		goto out;
 
@@ -131,7 +131,7 @@ int kernfs_iop_setattr(struct dentry *dentry, struct iattr *iattr)
 		goto out;
 
 	/* this ignores size changes */
-	setattr_copy(inode, iattr);
+	setattr_copy(&init_user_ns, inode, iattr);
 
 out:
 	mutex_unlock(&kernfs_mutex);
diff --git a/fs/libfs.c b/fs/libfs.c
index f8b3c02b4f0f..a73fe109403c 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -497,13 +497,13 @@ int simple_setattr(struct dentry *dentry, struct iattr *iattr)
 	struct inode *inode = d_inode(dentry);
 	int error;
 
-	error = setattr_prepare(dentry, iattr);
+	error = setattr_prepare(&init_user_ns, dentry, iattr);
 	if (error)
 		return error;
 
 	if (iattr->ia_valid & ATTR_SIZE)
 		truncate_setsize(inode, iattr->ia_size);
-	setattr_copy(inode, iattr);
+	setattr_copy(&init_user_ns, inode, iattr);
 	mark_inode_dirty(inode);
 	return 0;
 }
diff --git a/fs/minix/file.c b/fs/minix/file.c
index c50b0a20fcd9..f07acd268577 100644
--- a/fs/minix/file.c
+++ b/fs/minix/file.c
@@ -27,7 +27,7 @@ static int minix_setattr(struct dentry *dentry, struct iattr *attr)
 	struct inode *inode = d_inode(dentry);
 	int error;
 
-	error = setattr_prepare(dentry, attr);
+	error = setattr_prepare(&init_user_ns, dentry, attr);
 	if (error)
 		return error;
 
@@ -41,7 +41,7 @@ static int minix_setattr(struct dentry *dentry, struct iattr *attr)
 		minix_truncate(inode);
 	}
 
-	setattr_copy(inode, attr);
+	setattr_copy(&init_user_ns, inode, attr);
 	mark_inode_dirty(inode);
 	return 0;
 }
diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index 9473d048efec..0ea0554d20d1 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -90,7 +90,7 @@ nfsd_proc_setattr(struct svc_rqst *rqstp)
 		if (delta < 0)
 			delta = -delta;
 		if (delta < MAX_TOUCH_TIME_ERROR &&
-		    setattr_prepare(fhp->fh_dentry, iap) != 0) {
+		    setattr_prepare(&init_user_ns, fhp->fh_dentry, iap) != 0) {
 			/*
 			 * Turn off ATTR_[AM]TIME_SET but leave ATTR_[AM]TIME.
 			 * This will cause notify_change to set these times
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 0edf11258aaa..1905b39be1c2 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -448,7 +448,7 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp, struct iattr *iap,
 			.ia_size	= iap->ia_size,
 		};
 
-		host_err = notify_change(dentry, &size_attr, NULL);
+		host_err = notify_change(&init_user_ns, dentry, &size_attr, NULL);
 		if (host_err)
 			goto out_unlock;
 		iap->ia_valid &= ~ATTR_SIZE;
@@ -463,7 +463,7 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp, struct iattr *iap,
 	}
 
 	iap->ia_valid |= ATTR_CTIME;
-	host_err = notify_change(dentry, iap, NULL);
+	host_err = notify_change(&init_user_ns, dentry, iap, NULL);
 
 out_unlock:
 	fh_unlock(fhp);
diff --git a/fs/nilfs2/inode.c b/fs/nilfs2/inode.c
index 11225a659736..8aad3c48092a 100644
--- a/fs/nilfs2/inode.c
+++ b/fs/nilfs2/inode.c
@@ -812,7 +812,7 @@ int nilfs_setattr(struct dentry *dentry, struct iattr *iattr)
 	struct super_block *sb = inode->i_sb;
 	int err;
 
-	err = setattr_prepare(dentry, iattr);
+	err = setattr_prepare(&init_user_ns, dentry, iattr);
 	if (err)
 		return err;
 
@@ -827,7 +827,7 @@ int nilfs_setattr(struct dentry *dentry, struct iattr *iattr)
 		nilfs_truncate(inode);
 	}
 
-	setattr_copy(inode, iattr);
+	setattr_copy(&init_user_ns, inode, iattr);
 	mark_inode_dirty(inode);
 
 	if (iattr->ia_valid & ATTR_MODE) {
diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
index f7e4cbc26eaf..38f4cf1d4497 100644
--- a/fs/ntfs/inode.c
+++ b/fs/ntfs/inode.c
@@ -2866,7 +2866,7 @@ int ntfs_setattr(struct dentry *dentry, struct iattr *attr)
 	int err;
 	unsigned int ia_valid = attr->ia_valid;
 
-	err = setattr_prepare(dentry, attr);
+	err = setattr_prepare(&init_user_ns, dentry, attr);
 	if (err)
 		goto out;
 	/* We do not support NTFS ACLs yet. */
diff --git a/fs/ocfs2/dlmfs/dlmfs.c b/fs/ocfs2/dlmfs/dlmfs.c
index 37c7d03a6284..9fa66cd1f622 100644
--- a/fs/ocfs2/dlmfs/dlmfs.c
+++ b/fs/ocfs2/dlmfs/dlmfs.c
@@ -196,11 +196,11 @@ static int dlmfs_file_setattr(struct dentry *dentry, struct iattr *attr)
 	struct inode *inode = d_inode(dentry);
 
 	attr->ia_valid &= ~ATTR_SIZE;
-	error = setattr_prepare(dentry, attr);
+	error = setattr_prepare(&init_user_ns, dentry, attr);
 	if (error)
 		return error;
 
-	setattr_copy(inode, attr);
+	setattr_copy(&init_user_ns, inode, attr);
 	mark_inode_dirty(inode);
 	return 0;
 }
diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
index 0c75619adf54..cabf355b148f 100644
--- a/fs/ocfs2/file.c
+++ b/fs/ocfs2/file.c
@@ -1142,7 +1142,7 @@ int ocfs2_setattr(struct dentry *dentry, struct iattr *attr)
 	if (!(attr->ia_valid & OCFS2_VALID_ATTRS))
 		return 0;
 
-	status = setattr_prepare(dentry, attr);
+	status = setattr_prepare(&init_user_ns, dentry, attr);
 	if (status)
 		return status;
 
@@ -1263,7 +1263,7 @@ int ocfs2_setattr(struct dentry *dentry, struct iattr *attr)
 		}
 	}
 
-	setattr_copy(inode, attr);
+	setattr_copy(&init_user_ns, inode, attr);
 	mark_inode_dirty(inode);
 
 	status = ocfs2_mark_inode_dirty(handle, inode, bh);
diff --git a/fs/omfs/file.c b/fs/omfs/file.c
index 2c7b70ee1388..729339cd7902 100644
--- a/fs/omfs/file.c
+++ b/fs/omfs/file.c
@@ -348,7 +348,7 @@ static int omfs_setattr(struct dentry *dentry, struct iattr *attr)
 	struct inode *inode = d_inode(dentry);
 	int error;
 
-	error = setattr_prepare(dentry, attr);
+	error = setattr_prepare(&init_user_ns, dentry, attr);
 	if (error)
 		return error;
 
@@ -361,7 +361,7 @@ static int omfs_setattr(struct dentry *dentry, struct iattr *attr)
 		omfs_truncate(inode);
 	}
 
-	setattr_copy(inode, attr);
+	setattr_copy(&init_user_ns, inode, attr);
 	mark_inode_dirty(inode);
 	return 0;
 }
diff --git a/fs/open.c b/fs/open.c
index a6dac6d97988..c3e4dc43dd8d 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -61,7 +61,7 @@ int do_truncate(struct dentry *dentry, loff_t length, unsigned int time_attrs,
 
 	inode_lock(dentry->d_inode);
 	/* Note any delegations or leases have already been broken: */
-	ret = notify_change(dentry, &newattrs, NULL);
+	ret = notify_change(&init_user_ns, dentry, &newattrs, NULL);
 	inode_unlock(dentry->d_inode);
 	return ret;
 }
@@ -580,7 +580,8 @@ int chmod_common(const struct path *path, umode_t mode)
 		goto out_unlock;
 	newattrs.ia_mode = (mode & S_IALLUGO) | (inode->i_mode & ~S_IALLUGO);
 	newattrs.ia_valid = ATTR_MODE | ATTR_CTIME;
-	error = notify_change(path->dentry, &newattrs, &delegated_inode);
+	error = notify_change(&init_user_ns, path->dentry, &newattrs,
+			      &delegated_inode);
 out_unlock:
 	inode_unlock(inode);
 	if (delegated_inode) {
@@ -671,7 +672,8 @@ int chown_common(const struct path *path, uid_t user, gid_t group)
 	inode_lock(inode);
 	error = security_path_chown(path, uid, gid);
 	if (!error)
-		error = notify_change(path->dentry, &newattrs, &delegated_inode);
+		error = notify_change(&init_user_ns, path->dentry, &newattrs,
+				      &delegated_inode);
 	inode_unlock(inode);
 	if (delegated_inode) {
 		error = break_deleg_wait(&delegated_inode);
diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index 4c790cc8042d..8ac9491ceb9a 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -855,7 +855,7 @@ int __orangefs_setattr(struct inode *inode, struct iattr *iattr)
 		ORANGEFS_I(inode)->attr_uid = current_fsuid();
 		ORANGEFS_I(inode)->attr_gid = current_fsgid();
 	}
-	setattr_copy(inode, iattr);
+	setattr_copy(&init_user_ns, inode, iattr);
 	spin_unlock(&inode->i_lock);
 	mark_inode_dirty(inode);
 
@@ -876,7 +876,7 @@ int orangefs_setattr(struct dentry *dentry, struct iattr *iattr)
 	int ret;
 	gossip_debug(GOSSIP_INODE_DEBUG, "__orangefs_setattr: called on %pd\n",
 	    dentry);
-	ret = setattr_prepare(dentry, iattr);
+	ret = setattr_prepare(&init_user_ns, dentry, iattr);
 	if (ret)
 	        goto out;
 	ret = __orangefs_setattr(d_inode(dentry), iattr);
diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index e5b616c93e11..3e9957ae19fa 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -235,7 +235,7 @@ static int ovl_set_size(struct dentry *upperdentry, struct kstat *stat)
 		.ia_size = stat->size,
 	};
 
-	return notify_change(upperdentry, &attr, NULL);
+	return notify_change(&init_user_ns, upperdentry, &attr, NULL);
 }
 
 static int ovl_set_timestamps(struct dentry *upperdentry, struct kstat *stat)
@@ -247,7 +247,7 @@ static int ovl_set_timestamps(struct dentry *upperdentry, struct kstat *stat)
 		.ia_mtime = stat->mtime,
 	};
 
-	return notify_change(upperdentry, &attr, NULL);
+	return notify_change(&init_user_ns, upperdentry, &attr, NULL);
 }
 
 int ovl_set_attr(struct dentry *upperdentry, struct kstat *stat)
@@ -259,7 +259,7 @@ int ovl_set_attr(struct dentry *upperdentry, struct kstat *stat)
 			.ia_valid = ATTR_MODE,
 			.ia_mode = stat->mode,
 		};
-		err = notify_change(upperdentry, &attr, NULL);
+		err = notify_change(&init_user_ns, upperdentry, &attr, NULL);
 	}
 	if (!err) {
 		struct iattr attr = {
@@ -267,7 +267,7 @@ int ovl_set_attr(struct dentry *upperdentry, struct kstat *stat)
 			.ia_uid = stat->uid,
 			.ia_gid = stat->gid,
 		};
-		err = notify_change(upperdentry, &attr, NULL);
+		err = notify_change(&init_user_ns, upperdentry, &attr, NULL);
 	}
 	if (!err)
 		ovl_set_timestamps(upperdentry, stat);
diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 98a23353b19a..29840820a46c 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -508,7 +508,7 @@ static int ovl_create_over_whiteout(struct dentry *dentry, struct inode *inode,
 			.ia_mode = cattr->mode,
 		};
 		inode_lock(newdentry->d_inode);
-		err = notify_change(newdentry, &attr, NULL);
+		err = notify_change(&init_user_ns, newdentry, &attr, NULL);
 		inode_unlock(newdentry->d_inode);
 		if (err)
 			goto out_cleanup;
diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index c101ebbb7a77..5aa66881dbd7 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -21,7 +21,7 @@ int ovl_setattr(struct dentry *dentry, struct iattr *attr)
 	struct dentry *upperdentry;
 	const struct cred *old_cred;
 
-	err = setattr_prepare(dentry, attr);
+	err = setattr_prepare(&init_user_ns, dentry, attr);
 	if (err)
 		return err;
 
@@ -79,7 +79,7 @@ int ovl_setattr(struct dentry *dentry, struct iattr *attr)
 
 		inode_lock(upperdentry->d_inode);
 		old_cred = ovl_override_creds(dentry->d_sb);
-		err = notify_change(upperdentry, attr, NULL);
+		err = notify_change(&init_user_ns, upperdentry, attr, NULL);
 		revert_creds(old_cred);
 		if (!err)
 			ovl_copyattr(upperdentry->d_inode, dentry->d_inode);
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 3e925deaa19a..39b2e9aa0e5b 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -804,7 +804,7 @@ static struct dentry *ovl_workdir_create(struct ovl_fs *ofs,
 
 		/* Clear any inherited mode bits */
 		inode_lock(work->d_inode);
-		err = notify_change(work, &attr, NULL);
+		err = notify_change(&init_user_ns, work, &attr, NULL);
 		inode_unlock(work->d_inode);
 		if (err)
 			goto out_dput;
diff --git a/fs/proc/base.c b/fs/proc/base.c
index b4ec9293625e..bb4e63a3684f 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -693,11 +693,11 @@ int proc_setattr(struct dentry *dentry, struct iattr *attr)
 	if (attr->ia_valid & ATTR_MODE)
 		return -EPERM;
 
-	error = setattr_prepare(dentry, attr);
+	error = setattr_prepare(&init_user_ns, dentry, attr);
 	if (error)
 		return error;
 
-	setattr_copy(inode, attr);
+	setattr_copy(&init_user_ns, inode, attr);
 	mark_inode_dirty(inode);
 	return 0;
 }
diff --git a/fs/proc/generic.c b/fs/proc/generic.c
index 6c0a05f55d6b..6d4fabab8aa7 100644
--- a/fs/proc/generic.c
+++ b/fs/proc/generic.c
@@ -121,11 +121,11 @@ static int proc_notify_change(struct dentry *dentry, struct iattr *iattr)
 	struct proc_dir_entry *de = PDE(inode);
 	int error;
 
-	error = setattr_prepare(dentry, iattr);
+	error = setattr_prepare(&init_user_ns, dentry, iattr);
 	if (error)
 		return error;
 
-	setattr_copy(inode, iattr);
+	setattr_copy(&init_user_ns, inode, iattr);
 	mark_inode_dirty(inode);
 
 	proc_set_user(de, inode->i_uid, inode->i_gid);
diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 317899222d7f..ec67dbc1f705 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -821,11 +821,11 @@ static int proc_sys_setattr(struct dentry *dentry, struct iattr *attr)
 	if (attr->ia_valid & (ATTR_MODE | ATTR_UID | ATTR_GID))
 		return -EPERM;
 
-	error = setattr_prepare(dentry, attr);
+	error = setattr_prepare(&init_user_ns, dentry, attr);
 	if (error)
 		return error;
 
-	setattr_copy(inode, attr);
+	setattr_copy(&init_user_ns, inode, attr);
 	mark_inode_dirty(inode);
 	return 0;
 }
diff --git a/fs/ramfs/file-nommu.c b/fs/ramfs/file-nommu.c
index 355523f4a4bf..f0358fe410d3 100644
--- a/fs/ramfs/file-nommu.c
+++ b/fs/ramfs/file-nommu.c
@@ -165,7 +165,7 @@ static int ramfs_nommu_setattr(struct dentry *dentry, struct iattr *ia)
 	int ret = 0;
 
 	/* POSIX UID/GID verification for setting inode attributes */
-	ret = setattr_prepare(dentry, ia);
+	ret = setattr_prepare(&init_user_ns, dentry, ia);
 	if (ret)
 		return ret;
 
@@ -185,7 +185,7 @@ static int ramfs_nommu_setattr(struct dentry *dentry, struct iattr *ia)
 		}
 	}
 
-	setattr_copy(inode, ia);
+	setattr_copy(&init_user_ns, inode, ia);
  out:
 	ia->ia_valid = old_ia_valid;
 	return ret;
diff --git a/fs/reiserfs/inode.c b/fs/reiserfs/inode.c
index c76d563dec0e..944f2b487cf8 100644
--- a/fs/reiserfs/inode.c
+++ b/fs/reiserfs/inode.c
@@ -3288,7 +3288,7 @@ int reiserfs_setattr(struct dentry *dentry, struct iattr *attr)
 	unsigned int ia_valid;
 	int error;
 
-	error = setattr_prepare(dentry, attr);
+	error = setattr_prepare(&init_user_ns, dentry, attr);
 	if (error)
 		return error;
 
@@ -3413,7 +3413,7 @@ int reiserfs_setattr(struct dentry *dentry, struct iattr *attr)
 	}
 
 	if (!error) {
-		setattr_copy(inode, attr);
+		setattr_copy(&init_user_ns, inode, attr);
 		mark_inode_dirty(inode);
 	}
 
diff --git a/fs/sysv/file.c b/fs/sysv/file.c
index 45fc79a18594..ca7e216b7b9e 100644
--- a/fs/sysv/file.c
+++ b/fs/sysv/file.c
@@ -34,7 +34,7 @@ static int sysv_setattr(struct dentry *dentry, struct iattr *attr)
 	struct inode *inode = d_inode(dentry);
 	int error;
 
-	error = setattr_prepare(dentry, attr);
+	error = setattr_prepare(&init_user_ns, dentry, attr);
 	if (error)
 		return error;
 
@@ -47,7 +47,7 @@ static int sysv_setattr(struct dentry *dentry, struct iattr *attr)
 		sysv_truncate(inode);
 	}
 
-	setattr_copy(inode, attr);
+	setattr_copy(&init_user_ns, inode, attr);
 	mark_inode_dirty(inode);
 	return 0;
 }
diff --git a/fs/ubifs/file.c b/fs/ubifs/file.c
index 2bc7780d2963..76ef392b1e41 100644
--- a/fs/ubifs/file.c
+++ b/fs/ubifs/file.c
@@ -1265,7 +1265,7 @@ int ubifs_setattr(struct dentry *dentry, struct iattr *attr)
 
 	dbg_gen("ino %lu, mode %#x, ia_valid %#x",
 		inode->i_ino, inode->i_mode, attr->ia_valid);
-	err = setattr_prepare(dentry, attr);
+	err = setattr_prepare(&init_user_ns, dentry, attr);
 	if (err)
 		return err;
 
diff --git a/fs/udf/file.c b/fs/udf/file.c
index 3671a40ed3c3..7c7d161315c2 100644
--- a/fs/udf/file.c
+++ b/fs/udf/file.c
@@ -259,7 +259,7 @@ static int udf_setattr(struct dentry *dentry, struct iattr *attr)
 	struct super_block *sb = inode->i_sb;
 	int error;
 
-	error = setattr_prepare(dentry, attr);
+	error = setattr_prepare(&init_user_ns, dentry, attr);
 	if (error)
 		return error;
 
@@ -282,7 +282,7 @@ static int udf_setattr(struct dentry *dentry, struct iattr *attr)
 	if (attr->ia_valid & ATTR_MODE)
 		udf_update_extra_perms(inode, attr->ia_mode);
 
-	setattr_copy(inode, attr);
+	setattr_copy(&init_user_ns, inode, attr);
 	mark_inode_dirty(inode);
 	return 0;
 }
diff --git a/fs/ufs/inode.c b/fs/ufs/inode.c
index c843ec858cf7..6b51f3b20143 100644
--- a/fs/ufs/inode.c
+++ b/fs/ufs/inode.c
@@ -1217,7 +1217,7 @@ int ufs_setattr(struct dentry *dentry, struct iattr *attr)
 	unsigned int ia_valid = attr->ia_valid;
 	int error;
 
-	error = setattr_prepare(dentry, attr);
+	error = setattr_prepare(&init_user_ns, dentry, attr);
 	if (error)
 		return error;
 
@@ -1227,7 +1227,7 @@ int ufs_setattr(struct dentry *dentry, struct iattr *attr)
 			return error;
 	}
 
-	setattr_copy(inode, attr);
+	setattr_copy(&init_user_ns, inode, attr);
 	mark_inode_dirty(inode);
 	return 0;
 }
diff --git a/fs/utimes.c b/fs/utimes.c
index fd3cc4226224..4572b91ddb91 100644
--- a/fs/utimes.c
+++ b/fs/utimes.c
@@ -62,7 +62,8 @@ int vfs_utimes(const struct path *path, struct timespec64 *times)
 	}
 retry_deleg:
 	inode_lock(inode);
-	error = notify_change(path->dentry, &newattrs, &delegated_inode);
+	error = notify_change(&init_user_ns, path->dentry, &newattrs,
+			      &delegated_inode);
 	inode_unlock(inode);
 	if (delegated_inode) {
 		error = break_deleg_wait(&delegated_inode);
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 67c8dc9de8aa..08a478d25122 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -637,7 +637,7 @@ xfs_vn_change_ok(
 	if (XFS_FORCED_SHUTDOWN(mp))
 		return -EIO;
 
-	return setattr_prepare(dentry, iattr);
+	return setattr_prepare(&init_user_ns, dentry, iattr);
 }
 
 /*
diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index 569525ee8f69..8a1f69677784 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -488,7 +488,7 @@ static int zonefs_inode_setattr(struct dentry *dentry, struct iattr *iattr)
 	if (unlikely(IS_IMMUTABLE(inode)))
 		return -EPERM;
 
-	ret = setattr_prepare(dentry, iattr);
+	ret = setattr_prepare(&init_user_ns, dentry, iattr);
 	if (ret)
 		return ret;
 
@@ -516,7 +516,7 @@ static int zonefs_inode_setattr(struct dentry *dentry, struct iattr *iattr)
 			return ret;
 	}
 
-	setattr_copy(inode, iattr);
+	setattr_copy(&init_user_ns, inode, iattr);
 
 	return 0;
 }
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 2a9d4af6a64d..e3ea1d7c3367 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2809,7 +2809,8 @@ static inline int bmap(struct inode *inode,  sector_t *block)
 }
 #endif
 
-extern int notify_change(struct dentry *, struct iattr *, struct inode **);
+int notify_change(struct user_namespace *, struct dentry *,
+		  struct iattr *, struct inode **);
 int inode_permission(struct user_namespace *, struct inode *, int);
 int generic_permission(struct user_namespace *, struct inode *, int);
 static inline int file_permission(struct file *file, int mask)
@@ -3274,9 +3275,10 @@ extern int buffer_migrate_page_norefs(struct address_space *,
 #define buffer_migrate_page_norefs NULL
 #endif
 
-extern int setattr_prepare(struct dentry *, struct iattr *);
+int setattr_prepare(struct user_namespace *, struct dentry *, struct iattr *);
 extern int inode_newsize_ok(const struct inode *, loff_t offset);
-extern void setattr_copy(struct inode *inode, const struct iattr *attr);
+void setattr_copy(struct user_namespace *, struct inode *inode,
+		  const struct iattr *attr);
 
 extern int file_update_time(struct file *file);
 
diff --git a/mm/shmem.c b/mm/shmem.c
index 1c68c9edba5e..1cb451e131ec 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1087,7 +1087,7 @@ static int shmem_setattr(struct dentry *dentry, struct iattr *attr)
 	struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
 	int error;
 
-	error = setattr_prepare(dentry, attr);
+	error = setattr_prepare(&init_user_ns, dentry, attr);
 	if (error)
 		return error;
 
@@ -1141,7 +1141,7 @@ static int shmem_setattr(struct dentry *dentry, struct iattr *attr)
 		}
 	}
 
-	setattr_copy(inode, attr);
+	setattr_copy(&init_user_ns, inode, attr);
 	if (attr->ia_valid & ATTR_MODE)
 		error = posix_acl_chmod(inode, inode->i_mode);
 	return error;
-- 
2.30.0

