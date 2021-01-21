Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE1A2FEE80
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Jan 2021 16:26:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731795AbhAUNYn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Jan 2021 08:24:43 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:54003 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731914AbhAUNWQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Jan 2021 08:22:16 -0500
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1l2Zte-0005g7-9s; Thu, 21 Jan 2021 13:21:10 +0000
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
Subject: [PATCH v6 12/40] namei: handle idmapped mounts in may_*() helpers
Date:   Thu, 21 Jan 2021 14:19:31 +0100
Message-Id: <20210121131959.646623-13-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210121131959.646623-1-christian.brauner@ubuntu.com>
References: <20210121131959.646623-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; i=KV+LhlrktsMncLO6e8jUpqKUgfKTYAz983qsIKoSFOE=; m=q5fidAq5XSKsg9h1mIP59dGUtSxaAlzATKpKxnay80g=; p=uZaSETPI8zJ4Ysu4PahrNGGvhxOVOdcPYzXQ2qfskQc=; g=c466597f702215eb6ec1150daa5986d854068eea
X-Patch-Sig: m=pgp; i=christian.brauner@ubuntu.com; s=0x0x91C61BC06578DCA2; b=iHUEABYKAB0WIQRAhzRXHqcMeLMyaSiRxhvAZXjcogUCYAl9pAAKCRCRxhvAZXjcohrhAP9fpTo gHMd2ojiORpDz6bVDkAV60p7qtP3qr852dOf82QEA0fGMovUsyZkrxsU1WPME9y9wqlCjyTBWj0m7 J4H1Ews=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The may_follow_link(), may_linkat(), may_lookup(), may_open(),
may_o_create(), may_create_in_sticky(), may_delete(), and may_create()
helpers determine whether the caller is privileged enough to perform the
associated operations. Let them handle idmapped mounts by mapping the
inode or fsids according to the mount's user namespace. Afterwards the
checks are identical to non-idmapped inodes. The patch takes care to
retrieve the mount's user namespace right before performing permission
checks and passing it down into the fileystem so the user namespace
can't change in between by someone idmapping a mount that is currently
not idmapped. If the initial user namespace is passed nothing changes so
non-idmapped mounts will see identical behavior as before.

Link: https://lore.kernel.org/r/20210112220124.837960-20-christian.brauner@ubuntu.com
Cc: Christoph Hellwig <hch@lst.de>
Cc: David Howells <dhowells@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
unchanged

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
unchanged
base-commit: 19c329f6808995b142b3966301f217c831e7cf31
---
 fs/btrfs/ioctl.c   |   5 +-
 fs/init.c          |   2 +-
 fs/inode.c         |   2 +-
 fs/internal.h      |   2 +-
 fs/namei.c         | 148 ++++++++++++++++++++++++++++-----------------
 fs/xattr.c         |   2 +-
 include/linux/fs.h |  14 +++--
 7 files changed, 108 insertions(+), 67 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 1f763c60415b..56f53d692fa2 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -927,8 +927,9 @@ static int btrfs_may_delete(struct inode *dir, struct dentry *victim, int isdir)
 		return error;
 	if (IS_APPEND(dir))
 		return -EPERM;
-	if (check_sticky(dir, d_inode(victim)) || IS_APPEND(d_inode(victim)) ||
-	    IS_IMMUTABLE(d_inode(victim)) || IS_SWAPFILE(d_inode(victim)))
+	if (check_sticky(&init_user_ns, dir, d_inode(victim)) ||
+	    IS_APPEND(d_inode(victim)) || IS_IMMUTABLE(d_inode(victim)) ||
+	    IS_SWAPFILE(d_inode(victim)))
 		return -EPERM;
 	if (isdir) {
 		if (!d_is_dir(victim))
diff --git a/fs/init.c b/fs/init.c
index 02723bea8499..891284f8a443 100644
--- a/fs/init.c
+++ b/fs/init.c
@@ -181,7 +181,7 @@ int __init init_link(const char *oldname, const char *newname)
 	error = -EXDEV;
 	if (old_path.mnt != new_path.mnt)
 		goto out_dput;
-	error = may_linkat(&old_path);
+	error = may_linkat(&init_user_ns, &old_path);
 	if (unlikely(error))
 		goto out_dput;
 	error = security_path_link(old_path.dentry, &new_path, new_dentry);
diff --git a/fs/inode.c b/fs/inode.c
index 49b512592dcd..46116ef44c9f 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1796,7 +1796,7 @@ bool atime_needs_update(const struct path *path, struct inode *inode)
 	/* Atime updates will likely cause i_uid and i_gid to be written
 	 * back improprely if their true value is unknown to the vfs.
 	 */
-	if (HAS_UNMAPPED_ID(inode))
+	if (HAS_UNMAPPED_ID(mnt_user_ns(mnt), inode))
 		return false;
 
 	if (IS_NOATIME(inode))
diff --git a/fs/internal.h b/fs/internal.h
index 77c50befbfbe..6c8a4eddc7e6 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -73,7 +73,7 @@ extern int vfs_path_lookup(struct dentry *, struct vfsmount *,
 			   const char *, unsigned int, struct path *);
 long do_rmdir(int dfd, struct filename *name);
 long do_unlinkat(int dfd, struct filename *name);
-int may_linkat(struct path *link);
+int may_linkat(struct user_namespace *mnt_userns, struct path *link);
 int do_renameat2(int olddfd, struct filename *oldname, int newdfd,
 		 struct filename *newname, unsigned int flags);
 
diff --git a/fs/namei.c b/fs/namei.c
index 04b001ddade3..93fa7d803fb2 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -506,7 +506,7 @@ int inode_permission(struct user_namespace *mnt_userns,
 		 * written back improperly if their true value is unknown
 		 * to the vfs.
 		 */
-		if (HAS_UNMAPPED_ID(inode))
+		if (HAS_UNMAPPED_ID(mnt_userns, inode))
 			return -EACCES;
 	}
 
@@ -1004,11 +1004,16 @@ int sysctl_protected_regular __read_mostly;
  */
 static inline int may_follow_link(struct nameidata *nd, const struct inode *inode)
 {
+	struct user_namespace *mnt_userns;
+	kuid_t i_uid;
+
 	if (!sysctl_protected_symlinks)
 		return 0;
 
+	mnt_userns = mnt_user_ns(nd->path.mnt);
+	i_uid = i_uid_into_mnt(mnt_userns, inode);
 	/* Allowed if owner and follower match. */
-	if (uid_eq(current_cred()->fsuid, inode->i_uid))
+	if (uid_eq(current_cred()->fsuid, i_uid))
 		return 0;
 
 	/* Allowed if parent directory not sticky and world-writable. */
@@ -1016,7 +1021,7 @@ static inline int may_follow_link(struct nameidata *nd, const struct inode *inod
 		return 0;
 
 	/* Allowed if parent directory and link owner match. */
-	if (uid_valid(nd->dir_uid) && uid_eq(nd->dir_uid, inode->i_uid))
+	if (uid_valid(nd->dir_uid) && uid_eq(nd->dir_uid, i_uid))
 		return 0;
 
 	if (nd->flags & LOOKUP_RCU)
@@ -1029,6 +1034,7 @@ static inline int may_follow_link(struct nameidata *nd, const struct inode *inod
 
 /**
  * safe_hardlink_source - Check for safe hardlink conditions
+ * @mnt_userns:	user namespace of the mount the inode was found from
  * @inode: the source inode to hardlink from
  *
  * Return false if at least one of the following conditions:
@@ -1039,7 +1045,8 @@ static inline int may_follow_link(struct nameidata *nd, const struct inode *inod
  *
  * Otherwise returns true.
  */
-static bool safe_hardlink_source(struct inode *inode)
+static bool safe_hardlink_source(struct user_namespace *mnt_userns,
+				 struct inode *inode)
 {
 	umode_t mode = inode->i_mode;
 
@@ -1056,7 +1063,7 @@ static bool safe_hardlink_source(struct inode *inode)
 		return false;
 
 	/* Hardlinking to unreadable or unwritable sources is dangerous. */
-	if (inode_permission(&init_user_ns, inode, MAY_READ | MAY_WRITE))
+	if (inode_permission(mnt_userns, inode, MAY_READ | MAY_WRITE))
 		return false;
 
 	return true;
@@ -1064,6 +1071,7 @@ static bool safe_hardlink_source(struct inode *inode)
 
 /**
  * may_linkat - Check permissions for creating a hardlink
+ * @mnt_userns:	user namespace of the mount the inode was found from
  * @link: the source to hardlink from
  *
  * Block hardlink when all of:
@@ -1072,14 +1080,21 @@ static bool safe_hardlink_source(struct inode *inode)
  *  - hardlink source is unsafe (see safe_hardlink_source() above)
  *  - not CAP_FOWNER in a namespace with the inode owner uid mapped
  *
+ * If the inode has been found through an idmapped mount the user namespace of
+ * the vfsmount must be passed through @mnt_userns. This function will then take
+ * care to map the inode according to @mnt_userns before checking permissions.
+ * On non-idmapped mounts or if permission checking is to be performed on the
+ * raw inode simply passs init_user_ns.
+ *
  * Returns 0 if successful, -ve on error.
  */
-int may_linkat(struct path *link)
+int may_linkat(struct user_namespace *mnt_userns, struct path *link)
 {
 	struct inode *inode = link->dentry->d_inode;
 
 	/* Inode writeback is not safe when the uid or gid are invalid. */
-	if (!uid_valid(inode->i_uid) || !gid_valid(inode->i_gid))
+	if (!uid_valid(i_uid_into_mnt(mnt_userns, inode)) ||
+	    !gid_valid(i_gid_into_mnt(mnt_userns, inode)))
 		return -EOVERFLOW;
 
 	if (!sysctl_protected_hardlinks)
@@ -1088,8 +1103,8 @@ int may_linkat(struct path *link)
 	/* Source inode owner (or CAP_FOWNER) can hardlink all they like,
 	 * otherwise, it must be a safe source.
 	 */
-	if (safe_hardlink_source(inode) ||
-	    inode_owner_or_capable(&init_user_ns, inode))
+	if (safe_hardlink_source(mnt_userns, inode) ||
+	    inode_owner_or_capable(mnt_userns, inode))
 		return 0;
 
 	audit_log_path_denied(AUDIT_ANOM_LINK, "linkat");
@@ -1100,6 +1115,7 @@ int may_linkat(struct path *link)
  * may_create_in_sticky - Check whether an O_CREAT open in a sticky directory
  *			  should be allowed, or not, on files that already
  *			  exist.
+ * @mnt_userns:	user namespace of the mount the inode was found from
  * @dir_mode: mode bits of directory
  * @dir_uid: owner of directory
  * @inode: the inode of the file to open
@@ -1115,16 +1131,25 @@ int may_linkat(struct path *link)
  * the directory doesn't have to be world writable: being group writable will
  * be enough.
  *
+ * If the inode has been found through an idmapped mount the user namespace of
+ * the vfsmount must be passed through @mnt_userns. This function will then take
+ * care to map the inode according to @mnt_userns before checking permissions.
+ * On non-idmapped mounts or if permission checking is to be performed on the
+ * raw inode simply passs init_user_ns.
+ *
  * Returns 0 if the open is allowed, -ve on error.
  */
-static int may_create_in_sticky(umode_t dir_mode, kuid_t dir_uid,
-				struct inode * const inode)
+static int may_create_in_sticky(struct user_namespace *mnt_userns,
+				struct nameidata *nd, struct inode *const inode)
 {
+	umode_t dir_mode = nd->dir_mode;
+	kuid_t dir_uid = nd->dir_uid;
+
 	if ((!sysctl_protected_fifos && S_ISFIFO(inode->i_mode)) ||
 	    (!sysctl_protected_regular && S_ISREG(inode->i_mode)) ||
 	    likely(!(dir_mode & S_ISVTX)) ||
-	    uid_eq(inode->i_uid, dir_uid) ||
-	    uid_eq(current_fsuid(), inode->i_uid))
+	    uid_eq(i_uid_into_mnt(mnt_userns, inode), dir_uid) ||
+	    uid_eq(current_fsuid(), i_uid_into_mnt(mnt_userns, inode)))
 		return 0;
 
 	if (likely(dir_mode & 0002) ||
@@ -1614,17 +1639,18 @@ static struct dentry *lookup_slow(const struct qstr *name,
 	return res;
 }
 
-static inline int may_lookup(struct nameidata *nd)
+static inline int may_lookup(struct user_namespace *mnt_userns,
+			     struct nameidata *nd)
 {
 	if (nd->flags & LOOKUP_RCU) {
-		int err = inode_permission(&init_user_ns, nd->inode,
+		int err = inode_permission(mnt_userns, nd->inode,
 					   MAY_EXEC | MAY_NOT_BLOCK);
 		if (err != -ECHILD)
 			return err;
 		if (unlazy_walk(nd))
 			return -ECHILD;
 	}
-	return inode_permission(&init_user_ns, nd->inode, MAY_EXEC);
+	return inode_permission(mnt_userns, nd->inode, MAY_EXEC);
 }
 
 static int reserve_stack(struct nameidata *nd, struct path *link, unsigned seq)
@@ -2177,7 +2203,7 @@ static int link_path_walk(const char *name, struct nameidata *nd)
 		u64 hash_len;
 		int type;
 
-		err = may_lookup(nd);
+		err = may_lookup(&init_user_ns, nd);
 		if (err)
 			return err;
 
@@ -2225,7 +2251,7 @@ static int link_path_walk(const char *name, struct nameidata *nd)
 OK:
 			/* pathname or trailing symlink, done */
 			if (!depth) {
-				nd->dir_uid = nd->inode->i_uid;
+				nd->dir_uid = i_uid_into_mnt(&init_user_ns, nd->inode);
 				nd->dir_mode = nd->inode->i_mode;
 				nd->flags &= ~LOOKUP_PARENT;
 				return 0;
@@ -2703,15 +2729,16 @@ int user_path_at_empty(int dfd, const char __user *name, unsigned flags,
 }
 EXPORT_SYMBOL(user_path_at_empty);
 
-int __check_sticky(struct inode *dir, struct inode *inode)
+int __check_sticky(struct user_namespace *mnt_userns, struct inode *dir,
+		   struct inode *inode)
 {
 	kuid_t fsuid = current_fsuid();
 
-	if (uid_eq(inode->i_uid, fsuid))
+	if (uid_eq(i_uid_into_mnt(mnt_userns, inode), fsuid))
 		return 0;
-	if (uid_eq(dir->i_uid, fsuid))
+	if (uid_eq(i_uid_into_mnt(mnt_userns, dir), fsuid))
 		return 0;
-	return !capable_wrt_inode_uidgid(&init_user_ns, inode, CAP_FOWNER);
+	return !capable_wrt_inode_uidgid(mnt_userns, inode, CAP_FOWNER);
 }
 EXPORT_SYMBOL(__check_sticky);
 
@@ -2735,7 +2762,8 @@ EXPORT_SYMBOL(__check_sticky);
  * 11. We don't allow removal of NFS sillyrenamed files; it's handled by
  *     nfs_async_unlink().
  */
-static int may_delete(struct inode *dir, struct dentry *victim, bool isdir)
+static int may_delete(struct user_namespace *mnt_userns, struct inode *dir,
+		      struct dentry *victim, bool isdir)
 {
 	struct inode *inode = d_backing_inode(victim);
 	int error;
@@ -2747,19 +2775,21 @@ static int may_delete(struct inode *dir, struct dentry *victim, bool isdir)
 	BUG_ON(victim->d_parent->d_inode != dir);
 
 	/* Inode writeback is not safe when the uid or gid are invalid. */
-	if (!uid_valid(inode->i_uid) || !gid_valid(inode->i_gid))
+	if (!uid_valid(i_uid_into_mnt(mnt_userns, inode)) ||
+	    !gid_valid(i_gid_into_mnt(mnt_userns, inode)))
 		return -EOVERFLOW;
 
 	audit_inode_child(dir, victim, AUDIT_TYPE_CHILD_DELETE);
 
-	error = inode_permission(&init_user_ns, dir, MAY_WRITE | MAY_EXEC);
+	error = inode_permission(mnt_userns, dir, MAY_WRITE | MAY_EXEC);
 	if (error)
 		return error;
 	if (IS_APPEND(dir))
 		return -EPERM;
 
-	if (check_sticky(dir, inode) || IS_APPEND(inode) ||
-	    IS_IMMUTABLE(inode) || IS_SWAPFILE(inode) || HAS_UNMAPPED_ID(inode))
+	if (check_sticky(mnt_userns, dir, inode) || IS_APPEND(inode) ||
+	    IS_IMMUTABLE(inode) || IS_SWAPFILE(inode) ||
+	    HAS_UNMAPPED_ID(mnt_userns, inode))
 		return -EPERM;
 	if (isdir) {
 		if (!d_is_dir(victim))
@@ -2784,7 +2814,8 @@ static int may_delete(struct inode *dir, struct dentry *victim, bool isdir)
  *  4. We should have write and exec permissions on dir
  *  5. We can't do it if dir is immutable (done in permission())
  */
-static inline int may_create(struct inode *dir, struct dentry *child)
+static inline int may_create(struct user_namespace *mnt_userns,
+			     struct inode *dir, struct dentry *child)
 {
 	struct user_namespace *s_user_ns;
 	audit_inode_child(dir, child, AUDIT_TYPE_CHILD_CREATE);
@@ -2793,10 +2824,10 @@ static inline int may_create(struct inode *dir, struct dentry *child)
 	if (IS_DEADDIR(dir))
 		return -ENOENT;
 	s_user_ns = dir->i_sb->s_user_ns;
-	if (!kuid_has_mapping(s_user_ns, current_fsuid()) ||
-	    !kgid_has_mapping(s_user_ns, current_fsgid()))
+	if (!kuid_has_mapping(s_user_ns, fsuid_into_mnt(mnt_userns)) ||
+	    !kgid_has_mapping(s_user_ns, fsgid_into_mnt(mnt_userns)))
 		return -EOVERFLOW;
-	return inode_permission(&init_user_ns, dir, MAY_WRITE | MAY_EXEC);
+	return inode_permission(mnt_userns, dir, MAY_WRITE | MAY_EXEC);
 }
 
 /*
@@ -2846,7 +2877,7 @@ EXPORT_SYMBOL(unlock_rename);
 int vfs_create(struct inode *dir, struct dentry *dentry, umode_t mode,
 		bool want_excl)
 {
-	int error = may_create(dir, dentry);
+	int error = may_create(&init_user_ns, dir, dentry);
 	if (error)
 		return error;
 
@@ -2869,7 +2900,7 @@ int vfs_mkobj(struct dentry *dentry, umode_t mode,
 		void *arg)
 {
 	struct inode *dir = dentry->d_parent->d_inode;
-	int error = may_create(dir, dentry);
+	int error = may_create(&init_user_ns, dir, dentry);
 	if (error)
 		return error;
 
@@ -2891,7 +2922,8 @@ bool may_open_dev(const struct path *path)
 		!(path->mnt->mnt_sb->s_iflags & SB_I_NODEV);
 }
 
-static int may_open(const struct path *path, int acc_mode, int flag)
+static int may_open(struct user_namespace *mnt_userns, const struct path *path,
+		    int acc_mode, int flag)
 {
 	struct dentry *dentry = path->dentry;
 	struct inode *inode = dentry->d_inode;
@@ -2926,7 +2958,7 @@ static int may_open(const struct path *path, int acc_mode, int flag)
 		break;
 	}
 
-	error = inode_permission(&init_user_ns, inode, MAY_OPEN | acc_mode);
+	error = inode_permission(mnt_userns, inode, MAY_OPEN | acc_mode);
 	if (error)
 		return error;
 
@@ -2941,7 +2973,7 @@ static int may_open(const struct path *path, int acc_mode, int flag)
 	}
 
 	/* O_NOATIME can only be set by the owner or superuser */
-	if (flag & O_NOATIME && !inode_owner_or_capable(&init_user_ns, inode))
+	if (flag & O_NOATIME && !inode_owner_or_capable(mnt_userns, inode))
 		return -EPERM;
 
 	return 0;
@@ -2976,7 +3008,9 @@ static inline int open_to_namei_flags(int flag)
 	return flag;
 }
 
-static int may_o_create(const struct path *dir, struct dentry *dentry, umode_t mode)
+static int may_o_create(struct user_namespace *mnt_userns,
+			const struct path *dir, struct dentry *dentry,
+			umode_t mode)
 {
 	struct user_namespace *s_user_ns;
 	int error = security_path_mknod(dir, dentry, mode, 0);
@@ -2984,11 +3018,11 @@ static int may_o_create(const struct path *dir, struct dentry *dentry, umode_t m
 		return error;
 
 	s_user_ns = dir->dentry->d_sb->s_user_ns;
-	if (!kuid_has_mapping(s_user_ns, current_fsuid()) ||
-	    !kgid_has_mapping(s_user_ns, current_fsgid()))
+	if (!kuid_has_mapping(s_user_ns, fsuid_into_mnt(mnt_userns)) ||
+	    !kgid_has_mapping(s_user_ns, fsgid_into_mnt(mnt_userns)))
 		return -EOVERFLOW;
 
-	error = inode_permission(&init_user_ns, dir->dentry->d_inode,
+	error = inode_permission(mnt_userns, dir->dentry->d_inode,
 				 MAY_WRITE | MAY_EXEC);
 	if (error)
 		return error;
@@ -3121,7 +3155,8 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 		if (!IS_POSIXACL(dir->d_inode))
 			mode &= ~current_umask();
 		if (likely(got_write))
-			create_error = may_o_create(&nd->path, dentry, mode);
+			create_error = may_o_create(&init_user_ns, &nd->path,
+						    dentry, mode);
 		else
 			create_error = -EROFS;
 	}
@@ -3282,7 +3317,7 @@ static int do_open(struct nameidata *nd,
 			return -EEXIST;
 		if (d_is_dir(nd->path.dentry))
 			return -EISDIR;
-		error = may_create_in_sticky(nd->dir_mode, nd->dir_uid,
+		error = may_create_in_sticky(&init_user_ns, nd,
 					     d_backing_inode(nd->path.dentry));
 		if (unlikely(error))
 			return error;
@@ -3302,7 +3337,7 @@ static int do_open(struct nameidata *nd,
 			return error;
 		do_truncate = true;
 	}
-	error = may_open(&nd->path, acc_mode, open_flag);
+	error = may_open(&init_user_ns, &nd->path, acc_mode, open_flag);
 	if (!error && !(file->f_mode & FMODE_OPENED))
 		error = vfs_open(&nd->path, file);
 	if (!error)
@@ -3377,7 +3412,7 @@ static int do_tmpfile(struct nameidata *nd, unsigned flags,
 	path.dentry = child;
 	audit_inode(nd->name, child, 0);
 	/* Don't check for other permissions, the inode was just created */
-	error = may_open(&path, 0, op->open_flag);
+	error = may_open(&init_user_ns, &path, 0, op->open_flag);
 	if (error)
 		goto out2;
 	file->f_path.mnt = path.mnt;
@@ -3584,7 +3619,7 @@ EXPORT_SYMBOL(user_path_create);
 int vfs_mknod(struct inode *dir, struct dentry *dentry, umode_t mode, dev_t dev)
 {
 	bool is_whiteout = S_ISCHR(mode) && dev == WHITEOUT_DEV;
-	int error = may_create(dir, dentry);
+	int error = may_create(&init_user_ns, dir, dentry);
 
 	if (error)
 		return error;
@@ -3685,7 +3720,7 @@ SYSCALL_DEFINE3(mknod, const char __user *, filename, umode_t, mode, unsigned, d
 
 int vfs_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 {
-	int error = may_create(dir, dentry);
+	int error = may_create(&init_user_ns, dir, dentry);
 	unsigned max_links = dir->i_sb->s_max_links;
 
 	if (error)
@@ -3746,7 +3781,7 @@ SYSCALL_DEFINE2(mkdir, const char __user *, pathname, umode_t, mode)
 
 int vfs_rmdir(struct inode *dir, struct dentry *dentry)
 {
-	int error = may_delete(dir, dentry, 1);
+	int error = may_delete(&init_user_ns, dir, dentry, 1);
 
 	if (error)
 		return error;
@@ -3868,7 +3903,7 @@ SYSCALL_DEFINE1(rmdir, const char __user *, pathname)
 int vfs_unlink(struct inode *dir, struct dentry *dentry, struct inode **delegated_inode)
 {
 	struct inode *target = dentry->d_inode;
-	int error = may_delete(dir, dentry, 0);
+	int error = may_delete(&init_user_ns, dir, dentry, 0);
 
 	if (error)
 		return error;
@@ -4000,7 +4035,7 @@ SYSCALL_DEFINE1(unlink, const char __user *, pathname)
 
 int vfs_symlink(struct inode *dir, struct dentry *dentry, const char *oldname)
 {
-	int error = may_create(dir, dentry);
+	int error = may_create(&init_user_ns, dir, dentry);
 
 	if (error)
 		return error;
@@ -4089,7 +4124,7 @@ int vfs_link(struct dentry *old_dentry, struct inode *dir, struct dentry *new_de
 	if (!inode)
 		return -ENOENT;
 
-	error = may_create(dir, new_dentry);
+	error = may_create(&init_user_ns, dir, new_dentry);
 	if (error)
 		return error;
 
@@ -4106,7 +4141,7 @@ int vfs_link(struct dentry *old_dentry, struct inode *dir, struct dentry *new_de
 	 * be writen back improperly if their true value is unknown to
 	 * the vfs.
 	 */
-	if (HAS_UNMAPPED_ID(inode))
+	if (HAS_UNMAPPED_ID(&init_user_ns, inode))
 		return -EPERM;
 	if (!dir->i_op->link)
 		return -EPERM;
@@ -4188,7 +4223,7 @@ static int do_linkat(int olddfd, const char __user *oldname, int newdfd,
 	error = -EXDEV;
 	if (old_path.mnt != new_path.mnt)
 		goto out_dput;
-	error = may_linkat(&old_path);
+	error = may_linkat(&init_user_ns, &old_path);
 	if (unlikely(error))
 		goto out_dput;
 	error = security_path_link(old_path.dentry, &new_path, new_dentry);
@@ -4281,6 +4316,7 @@ int vfs_rename(struct inode *old_dir, struct dentry *old_dentry,
 	       struct inode **delegated_inode, unsigned int flags)
 {
 	int error;
+	struct user_namespace *mnt_userns = &init_user_ns;
 	bool is_dir = d_is_dir(old_dentry);
 	struct inode *source = old_dentry->d_inode;
 	struct inode *target = new_dentry->d_inode;
@@ -4291,19 +4327,19 @@ int vfs_rename(struct inode *old_dir, struct dentry *old_dentry,
 	if (source == target)
 		return 0;
 
-	error = may_delete(old_dir, old_dentry, is_dir);
+	error = may_delete(mnt_userns, old_dir, old_dentry, is_dir);
 	if (error)
 		return error;
 
 	if (!target) {
-		error = may_create(new_dir, new_dentry);
+		error = may_create(mnt_userns, new_dir, new_dentry);
 	} else {
 		new_is_dir = d_is_dir(new_dentry);
 
 		if (!(flags & RENAME_EXCHANGE))
-			error = may_delete(new_dir, new_dentry, is_dir);
+			error = may_delete(mnt_userns, new_dir, new_dentry, is_dir);
 		else
-			error = may_delete(new_dir, new_dentry, new_is_dir);
+			error = may_delete(mnt_userns, new_dir, new_dentry, new_is_dir);
 	}
 	if (error)
 		return error;
diff --git a/fs/xattr.c b/fs/xattr.c
index 79c439d31eaa..b3444e06cded 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -98,7 +98,7 @@ xattr_permission(struct user_namespace *mnt_userns, struct inode *inode,
 		 * to be writen back improperly if their true value is
 		 * unknown to the vfs.
 		 */
-		if (HAS_UNMAPPED_ID(inode))
+		if (HAS_UNMAPPED_ID(mnt_userns, inode))
 			return -EPERM;
 	}
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 182641d8322f..a27884af7222 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2083,9 +2083,11 @@ static inline bool sb_rdonly(const struct super_block *sb) { return sb->s_flags
 #define IS_WHITEOUT(inode)	(S_ISCHR(inode->i_mode) && \
 				 (inode)->i_rdev == WHITEOUT_DEV)
 
-static inline bool HAS_UNMAPPED_ID(struct inode *inode)
+static inline bool HAS_UNMAPPED_ID(struct user_namespace *mnt_userns,
+				   struct inode *inode)
 {
-	return !uid_valid(inode->i_uid) || !gid_valid(inode->i_gid);
+	return !uid_valid(i_uid_into_mnt(mnt_userns, inode)) ||
+	       !gid_valid(i_gid_into_mnt(mnt_userns, inode));
 }
 
 static inline enum rw_hint file_write_hint(struct file *file)
@@ -2823,7 +2825,8 @@ static inline int path_permission(const struct path *path, int mask)
 	return inode_permission(mnt_user_ns(path->mnt),
 				d_inode(path->dentry), mask);
 }
-extern int __check_sticky(struct inode *dir, struct inode *inode);
+int __check_sticky(struct user_namespace *mnt_userns, struct inode *dir,
+		   struct inode *inode);
 
 static inline bool execute_ok(struct inode *inode)
 {
@@ -3442,12 +3445,13 @@ static inline bool is_sxid(umode_t mode)
 	return (mode & S_ISUID) || ((mode & S_ISGID) && (mode & S_IXGRP));
 }
 
-static inline int check_sticky(struct inode *dir, struct inode *inode)
+static inline int check_sticky(struct user_namespace *mnt_userns,
+			       struct inode *dir, struct inode *inode)
 {
 	if (!(dir->i_mode & S_ISVTX))
 		return 0;
 
-	return __check_sticky(dir, inode);
+	return __check_sticky(mnt_userns, dir, inode);
 }
 
 static inline void inode_has_no_xattr(struct inode *inode)
-- 
2.30.0

