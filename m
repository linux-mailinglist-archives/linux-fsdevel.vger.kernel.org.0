Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CBE113046C
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Jan 2020 21:41:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbgADUlI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 Jan 2020 15:41:08 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:48208 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726118AbgADUlI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 Jan 2020 15:41:08 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 4452E8EE0DA;
        Sat,  4 Jan 2020 12:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1578170468;
        bh=K/k1pHjU5ore9G0SsAo6xrfI0Mbdtk3e+AhXsnqJQ/A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n+KUloFPpezjMN95okT+iJpB2i4J6a/Tg3wivS35osGg5hKvqdACQB3JbvY9CBYnn
         k2deFSA6MM8qq4+qWYHO9R2H+tLhLMy5xIorz1LmAg2gQtby1dzRw+8veK0RwFJ0FN
         tJCTBLpDH+YmYge7eEW9lmu48Mc3EkucEuoz1JXI=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 6g6bKF2if_QU; Sat,  4 Jan 2020 12:41:08 -0800 (PST)
Received: from jarvis.int.hansenpartnership.com (jarvis.ext.hansenpartnership.com [153.66.160.226])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 7607B8EE079;
        Sat,  4 Jan 2020 12:41:07 -0800 (PST)
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Seth Forshee <seth.forshee@canonical.com>,
        linux-unionfs@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
        =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@ubuntu.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        containers@lists.linux-foundation.org
Subject: [PATCH v2 2/3] fs: introduce uid/gid shifting bind mount
Date:   Sat,  4 Jan 2020 12:39:45 -0800
Message-Id: <20200104203946.27914-3-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200104203946.27914-1-James.Bottomley@HansenPartnership.com>
References: <20200104203946.27914-1-James.Bottomley@HansenPartnership.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This implementation reverse shifts according to the user_ns belonging
to the mnt_ns.  So if the vfsmount has the newly introduced flag
MNT_SHIFT and the current user_ns is the same as the mount_ns->user_ns
then we shift back using the user_ns before committing to the
underlying filesystem.

For example, if a user_ns is created where interior (fake root, uid 0)
is mapped to kernel uid 100000 then writes from interior root normally
go to the filesystem at the kernel uid.  However, if MNT_SHIFT is set,
they will be shifted back to write at uid 0, meaning we can bind mount
real image filesystems to user_ns protected faker root.

In essence there are several things which have to be done for this to
occur safely.  Firstly for all operations on the filesystem, new
credentials have to be installed where fsuid and fsgid are set to the
*interior* values. Next all inodes used from the filesystem have to
have i_uid and i_gid shifted back to the kernel values and attributes
set from user space have to have ia_uid and ia_gid shifted from the
kernel values to the interior values.  The capability checks have to
be done using ns_capable against the kernel values, but the inode
capability checks have to be done against the shifted ids.

Since creating a new credential is a reasonably expensive proposition
and we have to shift and unshift many times during path walking, a
cached copy of the shifted credential is saved to a newly created
place in the task structure.  This serves the dual purpose of allowing
us to use a pre-prepared copy of the shifted credentials and also
allows us to recognise whenever the shift is actually in effect (the
cached shifted credential pointer being equal to the current_cred()
pointer).

To get this all to work, we have a check for the vfsmount flag and the
user_ns gating a shifting of the credentials over all user space
entries to filesystem functions.  In theory the path has to be present
everywhere we do this, so we can check the vfsmount flags.  However,
for lower level functions we can cheat this path check of vfsmount
simply to check whether a shifted credential is in effect or not to
gate things like the inode permission check, which means the path
doesn't have to be threaded all the way through the permission
checking functions.  if the credential is shifted check passes, we can
also be sure that the current user_ns is the same as the mnt->user_ns,
so we can use it and thus have no need of the struct mount at the
point of the shift.

Although the shift can be effected simply by executing
do_reconfigure_mnt with MNT_SHIFT in the flags, this patch only
contains the shifting mechanisms.  The follow on patch wires up the
user visible API for turning the flag on.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>

---

Note this patch depends on the rethreading notify_change to use a path
instead of a dentry patch
---
 fs/attr.c             |  87 ++++++++++++++++++++++++++++++----------
 fs/exec.c             |   7 +++-
 fs/inode.c            |   9 +++--
 fs/internal.h         |   2 +
 fs/namei.c            | 108 +++++++++++++++++++++++++++++++++++++++++---------
 fs/open.c             |  25 +++++++++++-
 fs/posix_acl.c        |   4 +-
 fs/stat.c             |  31 +++++++++++++--
 include/linux/cred.h  |  10 +++++
 include/linux/mount.h |   4 +-
 include/linux/sched.h |   5 +++
 kernel/capability.c   |  14 ++++++-
 kernel/cred.c         |  20 ++++++++++
 kernel/groups.c       |   7 ++++
 14 files changed, 279 insertions(+), 54 deletions(-)

diff --git a/fs/attr.c b/fs/attr.c
index 370b18807f05..3efb2dc67896 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -18,14 +18,22 @@
 #include <linux/evm.h>
 #include <linux/ima.h>
 
+#include "internal.h"
+#include "mount.h"
+
 static bool chown_ok(const struct inode *inode, kuid_t uid)
 {
+	kuid_t i_uid = inode->i_uid;
+
+	if (cred_is_shifted())
+		i_uid = make_kuid(current_user_ns(), __kuid_val(i_uid));
+
 	if (uid_eq(current_fsuid(), inode->i_uid) &&
-	    uid_eq(uid, inode->i_uid))
+	    uid_eq(uid, i_uid))
 		return true;
 	if (capable_wrt_inode_uidgid(inode, CAP_CHOWN))
 		return true;
-	if (uid_eq(inode->i_uid, INVALID_UID) &&
+	if (uid_eq(i_uid, INVALID_UID) &&
 	    ns_capable(inode->i_sb->s_user_ns, CAP_CHOWN))
 		return true;
 	return false;
@@ -33,12 +41,21 @@ static bool chown_ok(const struct inode *inode, kuid_t uid)
 
 static bool chgrp_ok(const struct inode *inode, kgid_t gid)
 {
+	kgid_t i_gid = inode->i_gid;
+	kuid_t i_uid = inode->i_uid;
+
+	if (cred_is_shifted()) {
+		struct user_namespace *ns = current_user_ns();
+
+		i_uid = make_kuid(ns, __kuid_val(i_uid));
+		i_gid = make_kgid(ns, __kgid_val(i_gid));
+	}
 	if (uid_eq(current_fsuid(), inode->i_uid) &&
-	    (in_group_p(gid) || gid_eq(gid, inode->i_gid)))
+	    (in_group_p(gid) || gid_eq(gid, i_gid)))
 		return true;
 	if (capable_wrt_inode_uidgid(inode, CAP_CHOWN))
 		return true;
-	if (gid_eq(inode->i_gid, INVALID_GID) &&
+	if (gid_eq(i_gid, INVALID_GID) &&
 	    ns_capable(inode->i_sb->s_user_ns, CAP_CHOWN))
 		return true;
 	return false;
@@ -89,9 +106,10 @@ int setattr_prepare(struct dentry *dentry, struct iattr *attr)
 	if (ia_valid & ATTR_MODE) {
 		if (!inode_owner_or_capable(inode))
 			return -EPERM;
+
 		/* Also check the setgid bit! */
-		if (!in_group_p((ia_valid & ATTR_GID) ? attr->ia_gid :
-				inode->i_gid) &&
+		if (!in_group_p_shifted((ia_valid & ATTR_GID) ? attr->ia_gid :
+					inode->i_gid) &&
 		    !capable_wrt_inode_uidgid(inode, CAP_FSETID))
 			attr->ia_mode &= ~S_ISGID;
 	}
@@ -198,7 +216,7 @@ void setattr_copy(struct inode *inode, const struct iattr *attr)
 	if (ia_valid & ATTR_MODE) {
 		umode_t mode = attr->ia_mode;
 
-		if (!in_group_p(inode->i_gid) &&
+		if (!in_group_p_shifted(inode->i_gid) &&
 		    !capable_wrt_inode_uidgid(inode, CAP_FSETID))
 			mode &= ~S_ISGID;
 		inode->i_mode = mode;
@@ -235,6 +253,9 @@ int notify_change(const struct path *path, struct iattr * attr,
 	int error;
 	struct timespec64 now;
 	unsigned int ia_valid = attr->ia_valid;
+	const struct cred *cred;
+	kuid_t i_uid = inode->i_uid;
+	kgid_t i_gid = inode->i_gid;
 
 	WARN_ON_ONCE(!inode_is_locked(inode));
 
@@ -243,18 +264,28 @@ int notify_change(const struct path *path, struct iattr * attr,
 			return -EPERM;
 	}
 
+	cred = change_userns_creds(path);
+	if (cred) {
+		struct mount *m = real_mount(path->mnt);
+
+		attr->ia_uid = KUIDT_INIT(from_kuid(m->mnt_ns->user_ns, attr->ia_uid));
+		attr->ia_gid = KGIDT_INIT(from_kgid(m->mnt_ns->user_ns, attr->ia_gid));
+	}
+
 	/*
 	 * If utimes(2) and friends are called with times == NULL (or both
 	 * times are UTIME_NOW), then we need to check for write permission
 	 */
 	if (ia_valid & ATTR_TOUCH) {
-		if (IS_IMMUTABLE(inode))
-			return -EPERM;
+		if (IS_IMMUTABLE(inode)) {
+			error = -EPERM;
+			goto err;
+		}
 
 		if (!inode_owner_or_capable(inode)) {
 			error = inode_permission(inode, MAY_WRITE);
 			if (error)
-				return error;
+				goto err;
 		}
 	}
 
@@ -275,7 +306,7 @@ int notify_change(const struct path *path, struct iattr * attr,
 	if (ia_valid & ATTR_KILL_PRIV) {
 		error = security_inode_need_killpriv(dentry);
 		if (error < 0)
-			return error;
+			goto err;
 		if (error == 0)
 			ia_valid = attr->ia_valid &= ~ATTR_KILL_PRIV;
 	}
@@ -306,34 +337,46 @@ int notify_change(const struct path *path, struct iattr * attr,
 			attr->ia_mode &= ~S_ISGID;
 		}
 	}
-	if (!(attr->ia_valid & ~(ATTR_KILL_SUID | ATTR_KILL_SGID)))
-		return 0;
+	if (!(attr->ia_valid & ~(ATTR_KILL_SUID | ATTR_KILL_SGID))) {
+		error = 0;
+		goto err;
+	}
 
 	/*
 	 * Verify that uid/gid changes are valid in the target
 	 * namespace of the superblock.
 	 */
+	error = -EOVERFLOW;
 	if (ia_valid & ATTR_UID &&
 	    !kuid_has_mapping(inode->i_sb->s_user_ns, attr->ia_uid))
-		return -EOVERFLOW;
+		goto err;
+
 	if (ia_valid & ATTR_GID &&
 	    !kgid_has_mapping(inode->i_sb->s_user_ns, attr->ia_gid))
-		return -EOVERFLOW;
+		goto err;
 
 	/* Don't allow modifications of files with invalid uids or
 	 * gids unless those uids & gids are being made valid.
 	 */
-	if (!(ia_valid & ATTR_UID) && !uid_valid(inode->i_uid))
-		return -EOVERFLOW;
-	if (!(ia_valid & ATTR_GID) && !gid_valid(inode->i_gid))
-		return -EOVERFLOW;
+	if (cred_is_shifted()) {
+		struct user_namespace *ns = current_user_ns();
+
+		i_uid = make_kuid(ns, __kuid_val(i_uid));
+		i_gid = make_kgid(ns, __kgid_val(i_gid));
+	}
+
+	if (!(ia_valid & ATTR_UID) && !uid_valid(i_uid))
+		goto err;
+
+	if (!(ia_valid & ATTR_GID) && !gid_valid(i_gid))
+		goto err;
 
 	error = security_inode_setattr(dentry, attr);
 	if (error)
-		return error;
+		goto err;
 	error = try_break_deleg(inode, delegated_inode);
 	if (error)
-		return error;
+		goto err;
 
 	if (inode->i_op->setattr)
 		error = inode->i_op->setattr(dentry, attr);
@@ -346,6 +389,8 @@ int notify_change(const struct path *path, struct iattr * attr,
 		evm_inode_post_setattr(dentry, ia_valid);
 	}
 
+ err:
+	revert_userns_creds(cred);
 	return error;
 }
 EXPORT_SYMBOL(notify_change);
diff --git a/fs/exec.c b/fs/exec.c
index 74d88dab98dd..4baf91391689 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1539,13 +1539,18 @@ static void bprm_fill_uid(struct linux_binprm *bprm)
 
 	/* Be careful if suid/sgid is set */
 	inode_lock(inode);
-
 	/* reload atomically mode/uid/gid now that lock held */
 	mode = inode->i_mode;
 	uid = inode->i_uid;
 	gid = inode->i_gid;
 	inode_unlock(inode);
 
+	if (cred_is_shifted()) {
+		struct user_namespace *ns = current_user_ns();
+
+		uid = make_kuid(ns, __kuid_val(uid));
+		gid = make_kgid(ns, __kgid_val(gid));
+	}
 	/* We ignore suid/sgid if there are no mappings for them in the ns */
 	if (!kuid_has_mapping(bprm->cred->user_ns, uid) ||
 		 !kgid_has_mapping(bprm->cred->user_ns, gid))
diff --git a/fs/inode.c b/fs/inode.c
index 18ff3081bda0..f5f7f7cbd374 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -2060,7 +2060,7 @@ void inode_init_owner(struct inode *inode, const struct inode *dir,
 		if (S_ISDIR(mode))
 			mode |= S_ISGID;
 		else if ((mode & (S_ISGID | S_IXGRP)) == (S_ISGID | S_IXGRP) &&
-			 !in_group_p(inode->i_gid) &&
+			 !in_group_p_shifted(inode->i_gid) &&
 			 !capable_wrt_inode_uidgid(dir, CAP_FSETID))
 			mode &= ~S_ISGID;
 	} else
@@ -2079,12 +2079,15 @@ EXPORT_SYMBOL(inode_init_owner);
 bool inode_owner_or_capable(const struct inode *inode)
 {
 	struct user_namespace *ns;
+	kuid_t uid = inode->i_uid;
 
-	if (uid_eq(current_fsuid(), inode->i_uid))
+	if (uid_eq(current_fsuid(), uid))
 		return true;
 
 	ns = current_user_ns();
-	if (kuid_has_mapping(ns, inode->i_uid) && ns_capable(ns, CAP_FOWNER))
+	if (cred_is_shifted())
+		uid = make_kuid(ns, __kuid_val(uid));
+	if (kuid_has_mapping(ns, uid) && ns_capable(ns, CAP_FOWNER))
 		return true;
 	return false;
 }
diff --git a/fs/internal.h b/fs/internal.h
index 9cbf6097c77f..47ac2f295f70 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -73,6 +73,8 @@ long do_symlinkat(const char __user *oldname, int newdfd,
 		  const char __user *newname);
 int do_linkat(int olddfd, const char __user *oldname, int newdfd,
 	      const char __user *newname, int flags);
+const struct cred *change_userns_creds(const struct path *p);
+void revert_userns_creds(const struct cred *cred);
 
 /*
  * namespace.c
diff --git a/fs/namei.c b/fs/namei.c
index 7bb4b1dcf3cc..0f36f21e6964 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -124,6 +124,38 @@
 
 #define EMBEDDED_NAME_MAX	(PATH_MAX - offsetof(struct filename, iname))
 
+const struct cred *change_userns_creds(const struct path *p)
+{
+	struct mount *m = real_mount(p->mnt);
+
+	if ((p->mnt->mnt_flags & MNT_SHIFT) == 0)
+		return NULL;
+
+	if (current->nsproxy->mnt_ns->user_ns != m->mnt_ns->user_ns)
+		return NULL;
+
+	if (current->mnt != p->mnt) {
+		struct cred *cred;
+		struct user_namespace *user_ns = m->mnt_ns->user_ns;
+
+		if (current->mnt_cred)
+			put_cred(current->mnt_cred);
+		cred = prepare_creds();
+		cred->fsuid = KUIDT_INIT(from_kuid(user_ns, current->cred->fsuid));
+		cred->fsgid = KGIDT_INIT(from_kgid(user_ns, current->cred->fsgid));
+		current->mnt = p->mnt; /* no reference needed */
+		current->mnt_cred = cred;
+	}
+	return override_creds(current->mnt_cred);
+}
+
+void revert_userns_creds(const struct cred *cred)
+{
+	if (!cred)
+		return;
+	revert_creds(cred);
+}
+
 struct filename *
 getname_flags(const char __user *filename, int flags, int *empty)
 {
@@ -303,7 +335,7 @@ static int acl_permission_check(struct inode *inode, int mask)
 				return error;
 		}
 
-		if (in_group_p(inode->i_gid))
+		if (in_group_p_shifted(inode->i_gid))
 			mode >>= 3;
 	}
 
@@ -366,7 +398,6 @@ int generic_permission(struct inode *inode, int mask)
 	if (!(mask & MAY_EXEC) || (inode->i_mode & S_IXUGO))
 		if (capable_wrt_inode_uidgid(inode, CAP_DAC_OVERRIDE))
 			return 0;
-
 	return -EACCES;
 }
 EXPORT_SYMBOL(generic_permission);
@@ -1784,6 +1815,7 @@ static int walk_component(struct nameidata *nd, int flags)
 	struct inode *inode;
 	unsigned seq;
 	int err;
+	const struct cred *cred;
 	/*
 	 * "." and ".." are special - ".." especially so because it has
 	 * to be able to know about the current root directory and
@@ -1795,25 +1827,31 @@ static int walk_component(struct nameidata *nd, int flags)
 			put_link(nd);
 		return err;
 	}
+	cred = change_userns_creds(&nd->path);
 	err = lookup_fast(nd, &path, &inode, &seq);
 	if (unlikely(err <= 0)) {
 		if (err < 0)
-			return err;
+			goto out;
 		path.dentry = lookup_slow(&nd->last, nd->path.dentry,
 					  nd->flags);
-		if (IS_ERR(path.dentry))
-			return PTR_ERR(path.dentry);
+		if (IS_ERR(path.dentry)) {
+			err = PTR_ERR(path.dentry);
+			goto out;
+		}
 
 		path.mnt = nd->path.mnt;
 		err = follow_managed(&path, nd);
 		if (unlikely(err < 0))
-			return err;
+			goto out;
 
 		seq = 0;	/* we are already out of RCU mode */
 		inode = d_backing_inode(path.dentry);
 	}
 
-	return step_into(nd, &path, flags, inode, seq);
+	err = step_into(nd, &path, flags, inode, seq);
+ out:
+	revert_userns_creds(cred);
+	return err;
 }
 
 /*
@@ -2067,8 +2105,10 @@ static int link_path_walk(const char *name, struct nameidata *nd)
 	for(;;) {
 		u64 hash_len;
 		int type;
+		const struct cred *cred = change_userns_creds(&nd->path);
 
 		err = may_lookup(nd);
+		revert_userns_creds(cred);
 		if (err)
 			return err;
 
@@ -2242,12 +2282,17 @@ static const char *path_init(struct nameidata *nd, unsigned flags)
 static const char *trailing_symlink(struct nameidata *nd)
 {
 	const char *s;
+	const struct cred *cred = change_userns_creds(&nd->path);
 	int error = may_follow_link(nd);
-	if (unlikely(error))
-		return ERR_PTR(error);
+	if (unlikely(error)) {
+		s = ERR_PTR(error);
+		goto out;
+	}
 	nd->flags |= LOOKUP_PARENT;
 	nd->stack[0].name = NULL;
 	s = get_link(nd);
+ out:
+	revert_userns_creds(cred);
 	return s ? s : "";
 }
 
@@ -3273,6 +3318,7 @@ static int do_last(struct nameidata *nd,
 	struct inode *inode;
 	struct path path;
 	int error;
+	const struct cred *cred = change_userns_creds(&nd->path);
 
 	nd->flags &= ~LOOKUP_PARENT;
 	nd->flags |= op->intent;
@@ -3280,7 +3326,7 @@ static int do_last(struct nameidata *nd,
 	if (nd->last_type != LAST_NORM) {
 		error = handle_dots(nd, nd->last_type);
 		if (unlikely(error))
-			return error;
+			goto err;
 		goto finish_open;
 	}
 
@@ -3293,7 +3339,7 @@ static int do_last(struct nameidata *nd,
 			goto finish_lookup;
 
 		if (error < 0)
-			return error;
+			goto err;
 
 		BUG_ON(nd->inode != dir->d_inode);
 		BUG_ON(nd->flags & LOOKUP_RCU);
@@ -3306,12 +3352,14 @@ static int do_last(struct nameidata *nd,
 		 */
 		error = complete_walk(nd);
 		if (error)
-			return error;
+			goto err;
 
 		audit_inode(nd->name, dir, AUDIT_INODE_PARENT);
 		/* trailing slashes? */
-		if (unlikely(nd->last.name[nd->last.len]))
-			return -EISDIR;
+		if (unlikely(nd->last.name[nd->last.len])) {
+			error = -EISDIR;
+			goto err;
+		}
 	}
 
 	if (open_flag & (O_CREAT | O_TRUNC | O_WRONLY | O_RDWR)) {
@@ -3367,7 +3415,7 @@ static int do_last(struct nameidata *nd,
 
 	error = follow_managed(&path, nd);
 	if (unlikely(error < 0))
-		return error;
+		goto err;
 
 	/*
 	 * create/update audit record if it already exists.
@@ -3376,7 +3424,8 @@ static int do_last(struct nameidata *nd,
 
 	if (unlikely((open_flag & (O_EXCL | O_CREAT)) == (O_EXCL | O_CREAT))) {
 		path_to_nameidata(&path, nd);
-		return -EEXIST;
+		error = -EEXIST;
+		goto err;
 	}
 
 	seq = 0;	/* out of RCU mode, so the value doesn't matter */
@@ -3384,12 +3433,12 @@ static int do_last(struct nameidata *nd,
 finish_lookup:
 	error = step_into(nd, &path, 0, inode, seq);
 	if (unlikely(error))
-		return error;
+		goto err;
 finish_open:
 	/* Why this, you ask?  _Now_ we might have grown LOOKUP_JUMPED... */
 	error = complete_walk(nd);
 	if (error)
-		return error;
+		goto err;
 	audit_inode(nd->name, nd->path.dentry, 0);
 	if (open_flag & O_CREAT) {
 		error = -EISDIR;
@@ -3431,6 +3480,8 @@ static int do_last(struct nameidata *nd,
 	}
 	if (got_write)
 		mnt_drop_write(nd->path.mnt);
+ err:
+	revert_userns_creds(cred);
 	return error;
 }
 
@@ -3749,6 +3800,7 @@ long do_mknodat(int dfd, const char __user *filename, umode_t mode,
 	struct path path;
 	int error;
 	unsigned int lookup_flags = 0;
+	const struct cred *cred;
 
 	error = may_mknod(mode);
 	if (error)
@@ -3758,6 +3810,7 @@ long do_mknodat(int dfd, const char __user *filename, umode_t mode,
 	if (IS_ERR(dentry))
 		return PTR_ERR(dentry);
 
+	cred = change_userns_creds(&path);
 	if (!IS_POSIXACL(path.dentry->d_inode))
 		mode &= ~current_umask();
 	error = security_path_mknod(&path, dentry, mode, dev);
@@ -3779,6 +3832,7 @@ long do_mknodat(int dfd, const char __user *filename, umode_t mode,
 	}
 out:
 	done_path_create(&path, dentry);
+	revert_userns_creds(cred);
 	if (retry_estale(error, lookup_flags)) {
 		lookup_flags |= LOOKUP_REVAL;
 		goto retry;
@@ -3829,18 +3883,21 @@ long do_mkdirat(int dfd, const char __user *pathname, umode_t mode)
 	struct path path;
 	int error;
 	unsigned int lookup_flags = LOOKUP_DIRECTORY;
+	const struct cred *cred;
 
 retry:
 	dentry = user_path_create(dfd, pathname, &path, lookup_flags);
 	if (IS_ERR(dentry))
 		return PTR_ERR(dentry);
 
+	cred = change_userns_creds(&path);
 	if (!IS_POSIXACL(path.dentry->d_inode))
 		mode &= ~current_umask();
 	error = security_path_mkdir(&path, dentry, mode);
 	if (!error)
 		error = vfs_mkdir(path.dentry->d_inode, dentry, mode);
 	done_path_create(&path, dentry);
+	revert_userns_creds(cred);
 	if (retry_estale(error, lookup_flags)) {
 		lookup_flags |= LOOKUP_REVAL;
 		goto retry;
@@ -3907,12 +3964,14 @@ long do_rmdir(int dfd, const char __user *pathname)
 	struct qstr last;
 	int type;
 	unsigned int lookup_flags = 0;
+	const struct cred *cred;
 retry:
 	name = filename_parentat(dfd, getname(pathname), lookup_flags,
 				&path, &last, &type);
 	if (IS_ERR(name))
 		return PTR_ERR(name);
 
+	cred = change_userns_creds(&path);
 	switch (type) {
 	case LAST_DOTDOT:
 		error = -ENOTEMPTY;
@@ -3948,6 +4007,7 @@ long do_rmdir(int dfd, const char __user *pathname)
 	inode_unlock(path.dentry->d_inode);
 	mnt_drop_write(path.mnt);
 exit1:
+	revert_userns_creds(cred);
 	path_put(&path);
 	putname(name);
 	if (retry_estale(error, lookup_flags)) {
@@ -4037,11 +4097,13 @@ long do_unlinkat(int dfd, struct filename *name)
 	struct inode *inode = NULL;
 	struct inode *delegated_inode = NULL;
 	unsigned int lookup_flags = 0;
+	const struct cred *cred;
 retry:
 	name = filename_parentat(dfd, name, lookup_flags, &path, &last, &type);
 	if (IS_ERR(name))
 		return PTR_ERR(name);
 
+	cred = change_userns_creds(&path);
 	error = -EISDIR;
 	if (type != LAST_NORM)
 		goto exit1;
@@ -4079,6 +4141,7 @@ long do_unlinkat(int dfd, struct filename *name)
 	}
 	mnt_drop_write(path.mnt);
 exit1:
+	revert_userns_creds(cred);
 	path_put(&path);
 	if (retry_estale(error, lookup_flags)) {
 		lookup_flags |= LOOKUP_REVAL;
@@ -4143,6 +4206,7 @@ long do_symlinkat(const char __user *oldname, int newdfd,
 	struct dentry *dentry;
 	struct path path;
 	unsigned int lookup_flags = 0;
+	const struct cred *cred;
 
 	from = getname(oldname);
 	if (IS_ERR(from))
@@ -4153,6 +4217,7 @@ long do_symlinkat(const char __user *oldname, int newdfd,
 	if (IS_ERR(dentry))
 		goto out_putname;
 
+	cred = change_userns_creds(&path);
 	error = security_path_symlink(&path, dentry, from->name);
 	if (!error)
 		error = vfs_symlink(path.dentry->d_inode, dentry, from->name);
@@ -4161,6 +4226,7 @@ long do_symlinkat(const char __user *oldname, int newdfd,
 		lookup_flags |= LOOKUP_REVAL;
 		goto retry;
 	}
+	revert_userns_creds(cred);
 out_putname:
 	putname(from);
 	return error;
@@ -4274,6 +4340,7 @@ int do_linkat(int olddfd, const char __user *oldname, int newdfd,
 	struct inode *delegated_inode = NULL;
 	int how = 0;
 	int error;
+	const struct cred *cred;
 
 	if ((flags & ~(AT_SYMLINK_FOLLOW | AT_EMPTY_PATH)) != 0)
 		return -EINVAL;
@@ -4301,6 +4368,7 @@ int do_linkat(int olddfd, const char __user *oldname, int newdfd,
 	if (IS_ERR(new_dentry))
 		goto out;
 
+	cred = change_userns_creds(&new_path);
 	error = -EXDEV;
 	if (old_path.mnt != new_path.mnt)
 		goto out_dput;
@@ -4312,6 +4380,7 @@ int do_linkat(int olddfd, const char __user *oldname, int newdfd,
 		goto out_dput;
 	error = vfs_link(old_path.dentry, new_path.dentry->d_inode, new_dentry, &delegated_inode);
 out_dput:
+	revert_userns_creds(cred);
 	done_path_create(&new_path, new_dentry);
 	if (delegated_inode) {
 		error = break_deleg_wait(&delegated_inode);
@@ -4531,6 +4600,7 @@ static int do_renameat2(int olddfd, const char __user *oldname, int newdfd,
 	unsigned int lookup_flags = 0, target_flags = LOOKUP_RENAME_TARGET;
 	bool should_retry = false;
 	int error;
+	const struct cred *cred;
 
 	if (flags & ~(RENAME_NOREPLACE | RENAME_EXCHANGE | RENAME_WHITEOUT))
 		return -EINVAL;
@@ -4560,6 +4630,7 @@ static int do_renameat2(int olddfd, const char __user *oldname, int newdfd,
 		goto exit1;
 	}
 
+	cred = change_userns_creds(&new_path);
 	error = -EXDEV;
 	if (old_path.mnt != new_path.mnt)
 		goto exit2;
@@ -4644,6 +4715,7 @@ static int do_renameat2(int olddfd, const char __user *oldname, int newdfd,
 	}
 	mnt_drop_write(old_path.mnt);
 exit2:
+	revert_userns_creds(cred);
 	if (retry_estale(error, lookup_flags))
 		should_retry = true;
 	path_put(&new_path);
diff --git a/fs/open.c b/fs/open.c
index 033e2112fbda..7cad2b723925 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -456,11 +456,13 @@ int ksys_chdir(const char __user *filename)
 	struct path path;
 	int error;
 	unsigned int lookup_flags = LOOKUP_FOLLOW | LOOKUP_DIRECTORY;
+	const struct cred *cred;
 retry:
 	error = user_path_at(AT_FDCWD, filename, lookup_flags, &path);
 	if (error)
 		goto out;
 
+	cred = change_userns_creds(&path);
 	error = inode_permission(path.dentry->d_inode, MAY_EXEC | MAY_CHDIR);
 	if (error)
 		goto dput_and_out;
@@ -468,6 +470,7 @@ int ksys_chdir(const char __user *filename)
 	set_fs_pwd(current->fs, &path);
 
 dput_and_out:
+	revert_userns_creds(cred);
 	path_put(&path);
 	if (retry_estale(error, lookup_flags)) {
 		lookup_flags |= LOOKUP_REVAL;
@@ -486,11 +489,13 @@ SYSCALL_DEFINE1(fchdir, unsigned int, fd)
 {
 	struct fd f = fdget_raw(fd);
 	int error;
+	const struct cred *cred;
 
 	error = -EBADF;
 	if (!f.file)
 		goto out;
 
+	cred = change_userns_creds(&f.file->f_path);
 	error = -ENOTDIR;
 	if (!d_can_lookup(f.file->f_path.dentry))
 		goto out_putf;
@@ -499,6 +504,7 @@ SYSCALL_DEFINE1(fchdir, unsigned int, fd)
 	if (!error)
 		set_fs_pwd(current->fs, &f.file->f_path);
 out_putf:
+	revert_userns_creds(cred);
 	fdput(f);
 out:
 	return error;
@@ -547,11 +553,13 @@ static int chmod_common(const struct path *path, umode_t mode)
 	struct inode *inode = path->dentry->d_inode;
 	struct inode *delegated_inode = NULL;
 	struct iattr newattrs;
+	const struct cred *cred;
 	int error;
 
+	cred = change_userns_creds(path);
 	error = mnt_want_write(path->mnt);
 	if (error)
-		return error;
+		goto out;
 retry_deleg:
 	inode_lock(inode);
 	error = security_path_chmod(path, mode);
@@ -568,6 +576,8 @@ static int chmod_common(const struct path *path, umode_t mode)
 			goto retry_deleg;
 	}
 	mnt_drop_write(path->mnt);
+ out:
+	revert_userns_creds(cred);
 	return error;
 }
 
@@ -666,6 +676,7 @@ int do_fchownat(int dfd, const char __user *filename, uid_t user, gid_t group,
 	struct path path;
 	int error = -EINVAL;
 	int lookup_flags;
+	const struct cred *cred;
 
 	if ((flag & ~(AT_SYMLINK_NOFOLLOW | AT_EMPTY_PATH)) != 0)
 		goto out;
@@ -677,12 +688,14 @@ int do_fchownat(int dfd, const char __user *filename, uid_t user, gid_t group,
 	error = user_path_at(dfd, filename, lookup_flags, &path);
 	if (error)
 		goto out;
+	cred = change_userns_creds(&path);
 	error = mnt_want_write(path.mnt);
 	if (error)
 		goto out_release;
 	error = chown_common(&path, user, group);
 	mnt_drop_write(path.mnt);
 out_release:
+	revert_userns_creds(cred);
 	path_put(&path);
 	if (retry_estale(error, lookup_flags)) {
 		lookup_flags |= LOOKUP_REVAL;
@@ -713,10 +726,12 @@ int ksys_fchown(unsigned int fd, uid_t user, gid_t group)
 {
 	struct fd f = fdget(fd);
 	int error = -EBADF;
+	const struct cred *cred;
 
 	if (!f.file)
 		goto out;
 
+	cred = change_userns_creds(&f.file->f_path);
 	error = mnt_want_write_file(f.file);
 	if (error)
 		goto out_fput;
@@ -724,6 +739,7 @@ int ksys_fchown(unsigned int fd, uid_t user, gid_t group)
 	error = chown_common(&f.file->f_path, user, group);
 	mnt_drop_write_file(f.file);
 out_fput:
+	revert_userns_creds(cred);
 	fdput(f);
 out:
 	return error;
@@ -911,8 +927,13 @@ EXPORT_SYMBOL(file_path);
  */
 int vfs_open(const struct path *path, struct file *file)
 {
+	int ret;
+	const struct cred *cred = change_userns_creds(path);
+
 	file->f_path = *path;
-	return do_dentry_open(file, d_backing_inode(path->dentry), NULL);
+	ret = do_dentry_open(file, d_backing_inode(path->dentry), NULL);
+	revert_userns_creds(cred);
+	return ret;
 }
 
 struct file *dentry_open(const struct path *path, int flags,
diff --git a/fs/posix_acl.c b/fs/posix_acl.c
index 84ad1c90d535..b5aa36261964 100644
--- a/fs/posix_acl.c
+++ b/fs/posix_acl.c
@@ -364,7 +364,7 @@ posix_acl_permission(struct inode *inode, const struct posix_acl *acl, int want)
                                         goto mask;
 				break;
                         case ACL_GROUP_OBJ:
-                                if (in_group_p(inode->i_gid)) {
+				if (in_group_p_shifted(inode->i_gid)) {
 					found = 1;
 					if ((pa->e_perm & want) == want)
 						goto mask;
@@ -652,7 +652,7 @@ int posix_acl_update_mode(struct inode *inode, umode_t *mode_p,
 		return error;
 	if (error == 0)
 		*acl = NULL;
-	if (!in_group_p(inode->i_gid) &&
+	if (!in_group_p_shifted(inode->i_gid) &&
 	    !capable_wrt_inode_uidgid(inode, CAP_FSETID))
 		mode &= ~S_ISGID;
 	*mode_p = mode;
diff --git a/fs/stat.c b/fs/stat.c
index c38e4c2e1221..0018b168d7a7 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -21,6 +21,8 @@
 #include <linux/uaccess.h>
 #include <asm/unistd.h>
 
+#include "mount.h"
+
 /**
  * generic_fillattr - Fill in the basic attributes from the inode struct
  * @inode: Inode to use as the source
@@ -48,6 +50,21 @@ void generic_fillattr(struct inode *inode, struct kstat *stat)
 }
 EXPORT_SYMBOL(generic_fillattr);
 
+static void shift_check(struct vfsmount *mnt, struct kstat *stat)
+{
+	struct mount *m = real_mount(mnt);
+	struct user_namespace *user_ns = m->mnt_ns->user_ns;
+
+	if ((mnt->mnt_flags & MNT_SHIFT) == 0)
+		return;
+
+	if (current->nsproxy->mnt_ns->user_ns != m->mnt_ns->user_ns)
+		return;
+
+	stat->uid = make_kuid(user_ns, __kuid_val(stat->uid));
+	stat->gid = make_kgid(user_ns, __kgid_val(stat->gid));
+}
+
 /**
  * vfs_getattr_nosec - getattr without security checks
  * @path: file to get attributes from
@@ -65,6 +82,7 @@ int vfs_getattr_nosec(const struct path *path, struct kstat *stat,
 		      u32 request_mask, unsigned int query_flags)
 {
 	struct inode *inode = d_backing_inode(path->dentry);
+	int ret;
 
 	memset(stat, 0, sizeof(*stat));
 	stat->result_mask |= STATX_BASIC_STATS;
@@ -77,12 +95,17 @@ int vfs_getattr_nosec(const struct path *path, struct kstat *stat,
 	if (IS_AUTOMOUNT(inode))
 		stat->attributes |= STATX_ATTR_AUTOMOUNT;
 
+	ret = 0;
 	if (inode->i_op->getattr)
-		return inode->i_op->getattr(path, stat, request_mask,
-					    query_flags);
+		ret = inode->i_op->getattr(path, stat, request_mask,
+					   query_flags);
+	else
+		generic_fillattr(inode, stat);
 
-	generic_fillattr(inode, stat);
-	return 0;
+	if (!ret)
+		shift_check(path->mnt, stat);
+
+	return ret;
 }
 EXPORT_SYMBOL(vfs_getattr_nosec);
 
diff --git a/include/linux/cred.h b/include/linux/cred.h
index 18639c069263..8a5f2c9b613a 100644
--- a/include/linux/cred.h
+++ b/include/linux/cred.h
@@ -59,6 +59,7 @@ extern struct group_info *groups_alloc(int);
 extern void groups_free(struct group_info *);
 
 extern int in_group_p(kgid_t);
+extern int in_group_p_shifted(kgid_t);
 extern int in_egroup_p(kgid_t);
 extern int groups_search(const struct group_info *, kgid_t);
 
@@ -75,6 +76,10 @@ static inline int in_group_p(kgid_t grp)
 {
         return 1;
 }
+static inline int in_group_p_shifted(kgid_t grp)
+{
+	return 1;
+}
 static inline int in_egroup_p(kgid_t grp)
 {
         return 1;
@@ -422,4 +427,9 @@ do {						\
 	*(_fsgid) = __cred->fsgid;		\
 } while(0)
 
+static inline bool cred_is_shifted(void)
+{
+	return current_cred() == current->mnt_cred;
+}
+
 #endif /* _LINUX_CRED_H */
diff --git a/include/linux/mount.h b/include/linux/mount.h
index bf8cc4108b8f..cdc5d981d594 100644
--- a/include/linux/mount.h
+++ b/include/linux/mount.h
@@ -46,7 +46,7 @@ struct fs_context;
 #define MNT_SHARED_MASK	(MNT_UNBINDABLE)
 #define MNT_USER_SETTABLE_MASK  (MNT_NOSUID | MNT_NODEV | MNT_NOEXEC \
 				 | MNT_NOATIME | MNT_NODIRATIME | MNT_RELATIME \
-				 | MNT_READONLY)
+				 | MNT_READONLY | MNT_SHIFT)
 #define MNT_ATIME_MASK (MNT_NOATIME | MNT_NODIRATIME | MNT_RELATIME )
 
 #define MNT_INTERNAL_FLAGS (MNT_SHARED | MNT_WRITE_HOLD | MNT_INTERNAL | \
@@ -65,6 +65,8 @@ struct fs_context;
 #define MNT_MARKED		0x4000000
 #define MNT_UMOUNT		0x8000000
 
+#define MNT_SHIFT		0x10000000
+
 struct vfsmount {
 	struct dentry *mnt_root;	/* root of the mounted tree */
 	struct super_block *mnt_sb;	/* pointer to superblock */
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 467d26046416..d376dc7bcf76 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -19,6 +19,7 @@
 #include <linux/plist.h>
 #include <linux/hrtimer.h>
 #include <linux/seccomp.h>
+#include <linux/mount.h>
 #include <linux/nodemask.h>
 #include <linux/rcupdate.h>
 #include <linux/refcount.h>
@@ -882,6 +883,10 @@ struct task_struct {
 	/* Effective (overridable) subjective task credentials (COW): */
 	const struct cred __rcu		*cred;
 
+	/* cache for uid/gid shifted cred tied to mnt */
+	struct cred			*mnt_cred;
+	struct vfsmount			*mnt;
+
 #ifdef CONFIG_KEYS
 	/* Cached requested key. */
 	struct key			*cached_requested_key;
diff --git a/kernel/capability.c b/kernel/capability.c
index 1444f3954d75..3273e85a644c 100644
--- a/kernel/capability.c
+++ b/kernel/capability.c
@@ -486,8 +486,18 @@ EXPORT_SYMBOL(file_ns_capable);
  */
 bool privileged_wrt_inode_uidgid(struct user_namespace *ns, const struct inode *inode)
 {
-	return kuid_has_mapping(ns, inode->i_uid) &&
-		kgid_has_mapping(ns, inode->i_gid);
+	kuid_t i_uid = inode->i_uid;
+	kgid_t i_gid = inode->i_gid;
+
+	if (cred_is_shifted()) {
+		struct user_namespace *cns = current_user_ns();
+
+		i_uid = make_kuid(cns, __kuid_val(i_uid));
+		i_gid = make_kgid(cns, __kgid_val(i_gid));
+	}
+
+	return kuid_has_mapping(ns, i_uid) &&
+		kgid_has_mapping(ns, i_gid);
 }
 
 /**
diff --git a/kernel/cred.c b/kernel/cred.c
index c0a4c12d38b2..bbe0e2e64081 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -167,6 +167,8 @@ void exit_creds(struct task_struct *tsk)
 	validate_creds(cred);
 	alter_cred_subscribers(cred, -1);
 	put_cred(cred);
+	if (tsk->mnt_cred)
+		put_cred(tsk->mnt_cred);
 
 	cred = (struct cred *) tsk->cred;
 	tsk->cred = NULL;
@@ -318,6 +320,17 @@ struct cred *prepare_exec_creds(void)
 	return new;
 }
 
+static void flush_mnt_cred(struct task_struct *t)
+{
+	if (t->mnt_cred == t->cred)
+		return;
+	if (t->mnt_cred)
+		put_cred(t->mnt_cred);
+	t->mnt_cred = NULL;
+	/* mnt is only used for comparison, so it has no reference */
+	t->mnt = NULL;
+}
+
 /*
  * Copy credentials for the new process created by fork()
  *
@@ -344,6 +357,8 @@ int copy_creds(struct task_struct *p, unsigned long clone_flags)
 	    ) {
 		p->real_cred = get_cred(p->cred);
 		get_cred(p->cred);
+		p->mnt = NULL;
+		p->mnt_cred = NULL;
 		alter_cred_subscribers(p->cred, 2);
 		kdebug("share_creds(%p{%d,%d})",
 		       p->cred, atomic_read(&p->cred->usage),
@@ -383,6 +398,8 @@ int copy_creds(struct task_struct *p, unsigned long clone_flags)
 
 	atomic_inc(&new->user->processes);
 	p->cred = p->real_cred = get_cred(new);
+	p->mnt = NULL;
+	p->mnt_cred = NULL;
 	alter_cred_subscribers(new, 2);
 	validate_creds(new);
 	return 0;
@@ -506,6 +523,7 @@ int commit_creds(struct cred *new)
 	/* release the old obj and subj refs both */
 	put_cred(old);
 	put_cred(old);
+	flush_mnt_cred(task);
 	return 0;
 }
 EXPORT_SYMBOL(commit_creds);
@@ -564,6 +582,7 @@ const struct cred *override_creds(const struct cred *new)
 	alter_cred_subscribers(new, 1);
 	rcu_assign_pointer(current->cred, new);
 	alter_cred_subscribers(old, -1);
+	flush_mnt_cred(current);
 
 	kdebug("override_creds() = %p{%d,%d}", old,
 	       atomic_read(&old->usage),
@@ -589,6 +608,7 @@ void revert_creds(const struct cred *old)
 
 	validate_creds(old);
 	validate_creds(override);
+	flush_mnt_cred(current);
 	alter_cred_subscribers(old, 1);
 	rcu_assign_pointer(current->cred, old);
 	alter_cred_subscribers(override, -1);
diff --git a/kernel/groups.c b/kernel/groups.c
index daae2f2dc6d4..772b49a367b0 100644
--- a/kernel/groups.c
+++ b/kernel/groups.c
@@ -228,6 +228,13 @@ int in_group_p(kgid_t grp)
 
 EXPORT_SYMBOL(in_group_p);
 
+int in_group_p_shifted(kgid_t grp)
+{
+	if (cred_is_shifted())
+		grp = make_kgid(current_user_ns(), __kgid_val(grp));
+	return in_group_p(grp);
+}
+
 int in_egroup_p(kgid_t grp)
 {
 	const struct cred *cred = current_cred();
-- 
2.16.4

