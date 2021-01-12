Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46C852F3ECF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Jan 2021 01:45:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394159AbhALWEn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Jan 2021 17:04:43 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:43255 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394012AbhALWEW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Jan 2021 17:04:22 -0500
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kzRlC-0003bd-Hu; Tue, 12 Jan 2021 22:03:30 +0000
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
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v5 17/42] commoncap: handle idmapped mounts
Date:   Tue, 12 Jan 2021 23:00:59 +0100
Message-Id: <20210112220124.837960-18-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210112220124.837960-1-christian.brauner@ubuntu.com>
References: <20210112220124.837960-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; i=WhZz6dFTkPB9Ac8KF5gDuEo0teg/zF3gmQyHeNGP1bo=; m=nQ7Jm6ALni9At1JnS+Ms9lOVzRm9dQ6O1dlcHZrbzCY=; p=G4xQniPXZT8q3huH7deVR4nFOXsIyfbQuA64NmonFhI=; g=11643c091621a99585b5a5d328e2511ea9a67ae4
X-Patch-Sig: m=pgp; i=christian.brauner@ubuntu.com; s=0x0x91C61BC06578DCA2; b=iHUEABYKAB0WIQRAhzRXHqcMeLMyaSiRxhvAZXjcogUCX/4YtgAKCRCRxhvAZXjcogfJAQDgxPv xQSCyDeFrvEv/iN1gISleNu+vlp8JPN6bnFiSvwEA3J1VWa9wrwwY4KFURv96foRAqNYGy4GQ7HBA /1fwMwM=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When interacting with user namespace and non-user namespace aware
filesystem capabilities the vfs will perform various security checks to
determine whether or not the filesystem capabilities can be used by the
caller (e.g. during exec), or even whether they need to be removed. The
main infrastructure for this resides in the capability codepaths but
they are called through the LSM security infrastructure even though they
are not technically an LSM or optional. This extends the existing
security hooks security_inode_removexattr(), security_inode_killpriv(),
security_inode_getsecurity() to pass down the mount's user namespace and
makes them aware of idmapped mounts.

In order to actually get filesystem capabilities from disk the
capability infrastructure exposes the get_vfs_caps_from_disk() helper.
For user namespace aware filesystem capabilities a root uid is stored
alongside the capabilities.

In order to determine whether the caller can make use of the filesystem
capability or whether it needs to be ignored it is translated according
to the superblock's user namespace. If it can be translated to uid 0
according to that id mapping the caller can use the filesystem
capabilities stored on disk. If we are accessing the inode that holds
the filesystem capabilities through an idmapped mount we need to map the
root uid according to the mount's user namespace.

Afterwards the checks are identical to non-idmapped mounts. Reading
filesystem caps from disk enforces that the root uid associated with the
filesystem capability must have a mapping in the superblock's user
namespace and that the caller is either in the same user namespace or is
a descendant of the superblock's user namespace. For filesystems that
are mountable inside user namespace the caller can just mount the
filesystem and won't usually need to idmap it. If they do want to idmap
it they can create an idmapped mount and mark it with a user namespace
they created and which is thus a descendant of s_user_ns. For
filesystems that are not mountable inside user namespaces the descendant
rule is trivially true because the s_user_ns will be the initial user
namespace.

If the initial user namespace is passed nothing changes so non-idmapped
mounts will see identical behavior as before.

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
- Paul Moore <paul@paul-moore.com>:
  - All audit logging is currently based on init_user_ns and will remain so
    until other work unrelated to this patchset has landed so always pass
    &init_user_ns in audit.

/* v4 */
- Serge Hallyn <serge@hallyn.com>:
  - Use "mnt_userns" to refer to a vfsmount's userns everywhere to make
    terminology consistent.

/* v5 */
base-commit: 7c53f6b671f4aba70ff15e1b05148b10d58c2837

- Christoph Hellwig <hch@lst.de>:
  - Use new file_userns_helper().
---
 fs/attr.c                     |  2 +-
 fs/xattr.c                    | 14 ++++----
 include/linux/capability.h    |  4 ++-
 include/linux/lsm_hook_defs.h | 15 +++++----
 include/linux/lsm_hooks.h     |  1 +
 include/linux/security.h      | 46 ++++++++++++++++---------
 kernel/auditsc.c              |  5 +--
 security/commoncap.c          | 63 ++++++++++++++++++++++++++---------
 security/security.c           | 25 ++++++++------
 security/selinux/hooks.c      | 20 ++++++-----
 security/smack/smack_lsm.c    | 14 ++++----
 11 files changed, 137 insertions(+), 72 deletions(-)

diff --git a/fs/attr.c b/fs/attr.c
index 939402dea6f7..3ee0b1b0f207 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -143,7 +143,7 @@ int setattr_prepare(struct user_namespace *mnt_userns, struct dentry *dentry,
 	if (ia_valid & ATTR_KILL_PRIV) {
 		int error;
 
-		error = security_inode_killpriv(dentry);
+		error = security_inode_killpriv(mnt_userns, dentry);
 		if (error)
 			return error;
 	}
diff --git a/fs/xattr.c b/fs/xattr.c
index 1c7d1d4e5f32..03afd803e50b 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -259,7 +259,7 @@ __vfs_setxattr_locked(struct user_namespace *mnt_userns, struct dentry *dentry,
 	if (error)
 		return error;
 
-	error = security_inode_setxattr(dentry, name, value, size, flags);
+	error = security_inode_setxattr(mnt_userns, dentry, name, value, size, flags);
 	if (error)
 		goto out;
 
@@ -309,18 +309,18 @@ vfs_setxattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 EXPORT_SYMBOL_GPL(vfs_setxattr);
 
 static ssize_t
-xattr_getsecurity(struct inode *inode, const char *name, void *value,
-			size_t size)
+xattr_getsecurity(struct user_namespace *mnt_userns, struct inode *inode,
+		  const char *name, void *value, size_t size)
 {
 	void *buffer = NULL;
 	ssize_t len;
 
 	if (!value || !size) {
-		len = security_inode_getsecurity(inode, name, &buffer, false);
+		len = security_inode_getsecurity(mnt_userns, inode, name, &buffer, false);
 		goto out_noalloc;
 	}
 
-	len = security_inode_getsecurity(inode, name, &buffer, true);
+	len = security_inode_getsecurity(mnt_userns, inode, name, &buffer, true);
 	if (len < 0)
 		return len;
 	if (size < len) {
@@ -410,7 +410,7 @@ vfs_getxattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 	if (!strncmp(name, XATTR_SECURITY_PREFIX,
 				XATTR_SECURITY_PREFIX_LEN)) {
 		const char *suffix = name + XATTR_SECURITY_PREFIX_LEN;
-		int ret = xattr_getsecurity(inode, suffix, value, size);
+		int ret = xattr_getsecurity(mnt_userns, inode, suffix, value, size);
 		/*
 		 * Only overwrite the return value if a security module
 		 * is actually active.
@@ -479,7 +479,7 @@ __vfs_removexattr_locked(struct user_namespace *mnt_userns, struct dentry *dentr
 	if (error)
 		return error;
 
-	error = security_inode_removexattr(dentry, name);
+	error = security_inode_removexattr(mnt_userns, dentry, name);
 	if (error)
 		goto out;
 
diff --git a/include/linux/capability.h b/include/linux/capability.h
index 575436b977bc..95421b941ffc 100644
--- a/include/linux/capability.h
+++ b/include/linux/capability.h
@@ -271,7 +271,9 @@ static inline bool checkpoint_restore_ns_capable(struct user_namespace *ns)
 }
 
 /* audit system wants to get cap info from files as well */
-extern int get_vfs_caps_from_disk(const struct dentry *dentry, struct cpu_vfs_cap_data *cpu_caps);
+extern int get_vfs_caps_from_disk(struct user_namespace *mnt_userns,
+				  const struct dentry *dentry,
+				  struct cpu_vfs_cap_data *cpu_caps);
 
 extern int cap_convert_nscap(struct user_namespace *mnt_userns,
 			     struct dentry *dentry, const void **ivalue,
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 7aaa753b8608..df4cdad6681e 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -133,17 +133,20 @@ LSM_HOOK(int, 0, inode_follow_link, struct dentry *dentry, struct inode *inode,
 LSM_HOOK(int, 0, inode_permission, struct inode *inode, int mask)
 LSM_HOOK(int, 0, inode_setattr, struct dentry *dentry, struct iattr *attr)
 LSM_HOOK(int, 0, inode_getattr, const struct path *path)
-LSM_HOOK(int, 0, inode_setxattr, struct dentry *dentry, const char *name,
-	 const void *value, size_t size, int flags)
+LSM_HOOK(int, 0, inode_setxattr, struct user_namespace *mnt_userns,
+	 struct dentry *dentry, const char *name, const void *value,
+	 size_t size, int flags)
 LSM_HOOK(void, LSM_RET_VOID, inode_post_setxattr, struct dentry *dentry,
 	 const char *name, const void *value, size_t size, int flags)
 LSM_HOOK(int, 0, inode_getxattr, struct dentry *dentry, const char *name)
 LSM_HOOK(int, 0, inode_listxattr, struct dentry *dentry)
-LSM_HOOK(int, 0, inode_removexattr, struct dentry *dentry, const char *name)
+LSM_HOOK(int, 0, inode_removexattr, struct user_namespace *mnt_userns,
+	 struct dentry *dentry, const char *name)
 LSM_HOOK(int, 0, inode_need_killpriv, struct dentry *dentry)
-LSM_HOOK(int, 0, inode_killpriv, struct dentry *dentry)
-LSM_HOOK(int, -EOPNOTSUPP, inode_getsecurity, struct inode *inode,
-	 const char *name, void **buffer, bool alloc)
+LSM_HOOK(int, 0, inode_killpriv, struct user_namespace *mnt_userns,
+	 struct dentry *dentry)
+LSM_HOOK(int, -EOPNOTSUPP, inode_getsecurity, struct user_namespace *mnt_userns,
+	 struct inode *inode, const char *name, void **buffer, bool alloc)
 LSM_HOOK(int, -EOPNOTSUPP, inode_setsecurity, struct inode *inode,
 	 const char *name, const void *value, size_t size, int flags)
 LSM_HOOK(int, 0, inode_listsecurity, struct inode *inode, char *buffer,
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index a19adef1f088..98a5e263aabb 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -444,6 +444,7 @@
  * @inode_killpriv:
  *	The setuid bit is being removed.  Remove similar security labels.
  *	Called with the dentry->d_inode->i_mutex held.
+ *	@mnt_userns: user namespace of the mount
  *	@dentry is the dentry being changed.
  *	Return 0 on success.  If error is returned, then the operation
  *	causing setuid bit removal is failed.
diff --git a/include/linux/security.h b/include/linux/security.h
index c35ea0ffccd9..9fb375cda5a4 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -147,10 +147,13 @@ extern int cap_capset(struct cred *new, const struct cred *old,
 extern int cap_bprm_creds_from_file(struct linux_binprm *bprm, struct file *file);
 extern int cap_inode_setxattr(struct dentry *dentry, const char *name,
 			      const void *value, size_t size, int flags);
-extern int cap_inode_removexattr(struct dentry *dentry, const char *name);
+extern int cap_inode_removexattr(struct user_namespace *mnt_userns,
+				 struct dentry *dentry, const char *name);
 extern int cap_inode_need_killpriv(struct dentry *dentry);
-extern int cap_inode_killpriv(struct dentry *dentry);
-extern int cap_inode_getsecurity(struct inode *inode, const char *name,
+extern int cap_inode_killpriv(struct user_namespace *mnt_userns,
+			      struct dentry *dentry);
+extern int cap_inode_getsecurity(struct user_namespace *mnt_userns,
+				 struct inode *inode, const char *name,
 				 void **buffer, bool alloc);
 extern int cap_mmap_addr(unsigned long addr);
 extern int cap_mmap_file(struct file *file, unsigned long reqprot,
@@ -345,16 +348,21 @@ int security_inode_follow_link(struct dentry *dentry, struct inode *inode,
 int security_inode_permission(struct inode *inode, int mask);
 int security_inode_setattr(struct dentry *dentry, struct iattr *attr);
 int security_inode_getattr(const struct path *path);
-int security_inode_setxattr(struct dentry *dentry, const char *name,
+int security_inode_setxattr(struct user_namespace *mnt_userns,
+			    struct dentry *dentry, const char *name,
 			    const void *value, size_t size, int flags);
 void security_inode_post_setxattr(struct dentry *dentry, const char *name,
 				  const void *value, size_t size, int flags);
 int security_inode_getxattr(struct dentry *dentry, const char *name);
 int security_inode_listxattr(struct dentry *dentry);
-int security_inode_removexattr(struct dentry *dentry, const char *name);
+int security_inode_removexattr(struct user_namespace *mnt_userns,
+			       struct dentry *dentry, const char *name);
 int security_inode_need_killpriv(struct dentry *dentry);
-int security_inode_killpriv(struct dentry *dentry);
-int security_inode_getsecurity(struct inode *inode, const char *name, void **buffer, bool alloc);
+int security_inode_killpriv(struct user_namespace *mnt_userns,
+			    struct dentry *dentry);
+int security_inode_getsecurity(struct user_namespace *mnt_userns,
+			       struct inode *inode, const char *name,
+			       void **buffer, bool alloc);
 int security_inode_setsecurity(struct inode *inode, const char *name, const void *value, size_t size, int flags);
 int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer_size);
 void security_inode_getsecid(struct inode *inode, u32 *secid);
@@ -831,8 +839,9 @@ static inline int security_inode_getattr(const struct path *path)
 	return 0;
 }
 
-static inline int security_inode_setxattr(struct dentry *dentry,
-		const char *name, const void *value, size_t size, int flags)
+static inline int security_inode_setxattr(struct user_namespace *mnt_userns,
+		struct dentry *dentry, const char *name, const void *value,
+		size_t size, int flags)
 {
 	return cap_inode_setxattr(dentry, name, value, size, flags);
 }
@@ -852,10 +861,11 @@ static inline int security_inode_listxattr(struct dentry *dentry)
 	return 0;
 }
 
-static inline int security_inode_removexattr(struct dentry *dentry,
-			const char *name)
+static inline int security_inode_removexattr(struct user_namespace *mnt_userns,
+					     struct dentry *dentry,
+					     const char *name)
 {
-	return cap_inode_removexattr(dentry, name);
+	return cap_inode_removexattr(mnt_userns, dentry, name);
 }
 
 static inline int security_inode_need_killpriv(struct dentry *dentry)
@@ -863,14 +873,18 @@ static inline int security_inode_need_killpriv(struct dentry *dentry)
 	return cap_inode_need_killpriv(dentry);
 }
 
-static inline int security_inode_killpriv(struct dentry *dentry)
+static inline int security_inode_killpriv(struct user_namespace *mnt_userns,
+					  struct dentry *dentry)
 {
-	return cap_inode_killpriv(dentry);
+	return cap_inode_killpriv(mnt_userns, dentry);
 }
 
-static inline int security_inode_getsecurity(struct inode *inode, const char *name, void **buffer, bool alloc)
+static inline int security_inode_getsecurity(struct user_namespace *mnt_userns,
+					     struct inode *inode,
+					     const char *name, void **buffer,
+					     bool alloc)
 {
-	return cap_inode_getsecurity(inode, name, buffer, alloc);
+	return cap_inode_getsecurity(mnt_userns, inode, name, buffer, alloc);
 }
 
 static inline int security_inode_setsecurity(struct inode *inode, const char *name, const void *value, size_t size, int flags)
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index ce8c9e2279ba..fdfdd71405ff 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -1930,7 +1930,7 @@ static inline int audit_copy_fcaps(struct audit_names *name,
 	if (!dentry)
 		return 0;
 
-	rc = get_vfs_caps_from_disk(dentry, &caps);
+	rc = get_vfs_caps_from_disk(&init_user_ns, dentry, &caps);
 	if (rc)
 		return rc;
 
@@ -2481,7 +2481,8 @@ int __audit_log_bprm_fcaps(struct linux_binprm *bprm,
 	ax->d.next = context->aux;
 	context->aux = (void *)ax;
 
-	get_vfs_caps_from_disk(bprm->file->f_path.dentry, &vcaps);
+	get_vfs_caps_from_disk(&init_user_ns,
+			       bprm->file->f_path.dentry, &vcaps);
 
 	ax->fcap.permitted = vcaps.permitted;
 	ax->fcap.inheritable = vcaps.inheritable;
diff --git a/security/commoncap.c b/security/commoncap.c
index b6f89ae5c88a..f864a4b4fed9 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -303,17 +303,25 @@ int cap_inode_need_killpriv(struct dentry *dentry)
 
 /**
  * cap_inode_killpriv - Erase the security markings on an inode
- * @dentry: The inode/dentry to alter
+ *
+ * @mnt_userns:	user namespace of the mount the inode was found from
+ * @dentry:	The inode/dentry to alter
  *
  * Erase the privilege-enhancing security markings on an inode.
  *
+ * If the inode has been found through an idmapped mount the user namespace of
+ * the vfsmount must be passed through @mnt_userns. This function will then take
+ * care to map the inode according to @mnt_userns before checking permissions. On
+ * non-idmapped mounts or if permission checking is to be performed on the raw
+ * inode simply passs init_user_ns.
+ *
  * Returns 0 if successful, -ve on error.
  */
-int cap_inode_killpriv(struct dentry *dentry)
+int cap_inode_killpriv(struct user_namespace *mnt_userns, struct dentry *dentry)
 {
 	int error;
 
-	error = __vfs_removexattr(&init_user_ns, dentry, XATTR_NAME_CAPS);
+	error = __vfs_removexattr(mnt_userns, dentry, XATTR_NAME_CAPS);
 	if (error == -EOPNOTSUPP)
 		error = 0;
 	return error;
@@ -366,8 +374,8 @@ static bool is_v3header(size_t size, const struct vfs_cap_data *cap)
  * by the integrity subsystem, which really wants the unconverted values -
  * so that's good.
  */
-int cap_inode_getsecurity(struct inode *inode, const char *name, void **buffer,
-			  bool alloc)
+int cap_inode_getsecurity(struct user_namespace *mnt_userns, struct inode *inode,
+			  const char *name, void **buffer, bool alloc)
 {
 	int size, ret;
 	kuid_t kroot;
@@ -386,7 +394,7 @@ int cap_inode_getsecurity(struct inode *inode, const char *name, void **buffer,
 		return -EINVAL;
 
 	size = sizeof(struct vfs_ns_cap_data);
-	ret = (int)vfs_getxattr_alloc(&init_user_ns, dentry, XATTR_NAME_CAPS,
+	ret = (int)vfs_getxattr_alloc(mnt_userns, dentry, XATTR_NAME_CAPS,
 				      &tmpbuf, size, GFP_NOFS);
 	dput(dentry);
 
@@ -412,6 +420,9 @@ int cap_inode_getsecurity(struct inode *inode, const char *name, void **buffer,
 	root = le32_to_cpu(nscap->rootid);
 	kroot = make_kuid(fs_ns, root);
 
+	/* If this is an idmapped mount shift the kuid. */
+	kroot = kuid_into_mnt(mnt_userns, kroot);
+
 	/* If the root kuid maps to a valid uid in current ns, then return
 	 * this as a nscap. */
 	mappedroot = from_kuid(current_user_ns(), kroot);
@@ -551,7 +562,6 @@ int cap_convert_nscap(struct user_namespace *mnt_userns, struct dentry *dentry,
 	*ivalue = nscap;
 	return newsize;
 }
-EXPORT_SYMBOL(cap_convert_nscap);
 
 /*
  * Calculate the new process capability sets from the capability sets attached
@@ -597,10 +607,24 @@ static inline int bprm_caps_from_vfs_caps(struct cpu_vfs_cap_data *caps,
 	return *effective ? ret : 0;
 }
 
-/*
+/**
+ * get_vfs_caps_from_disk - retrieve vfs caps from disk
+ *
+ * @mnt_userns:	user namespace of the mount the inode was found from
+ * @dentry:	dentry from which @inode is retrieved
+ * @cpu_caps:	vfs capabilities
+ *
  * Extract the on-exec-apply capability sets for an executable file.
+ *
+ * If the inode has been found through an idmapped mount the user namespace of
+ * the vfsmount must be passed through @mnt_userns. This function will then take
+ * care to map the inode according to @mnt_userns before checking permissions. On
+ * non-idmapped mounts or if permission checking is to be performed on the raw
+ * inode simply passs init_user_ns.
  */
-int get_vfs_caps_from_disk(const struct dentry *dentry, struct cpu_vfs_cap_data *cpu_caps)
+int get_vfs_caps_from_disk(struct user_namespace *mnt_userns,
+			   const struct dentry *dentry,
+			   struct cpu_vfs_cap_data *cpu_caps)
 {
 	struct inode *inode = d_backing_inode(dentry);
 	__u32 magic_etc;
@@ -656,6 +680,7 @@ int get_vfs_caps_from_disk(const struct dentry *dentry, struct cpu_vfs_cap_data
 	/* Limit the caps to the mounter of the filesystem
 	 * or the more limited uid specified in the xattr.
 	 */
+	rootkuid = kuid_into_mnt(mnt_userns, rootkuid);
 	if (!rootid_owns_currentns(rootkuid))
 		return -ENODATA;
 
@@ -701,7 +726,7 @@ static int get_file_caps(struct linux_binprm *bprm, struct file *file,
 	if (!current_in_userns(file->f_path.mnt->mnt_sb->s_user_ns))
 		return 0;
 
-	rc = get_vfs_caps_from_disk(file->f_path.dentry, &vcaps);
+	rc = get_vfs_caps_from_disk(file_user_ns(file), file->f_path.dentry, &vcaps);
 	if (rc < 0) {
 		if (rc == -EINVAL)
 			printk(KERN_NOTICE "Invalid argument reading file caps for %s\n",
@@ -966,16 +991,25 @@ int cap_inode_setxattr(struct dentry *dentry, const char *name,
 
 /**
  * cap_inode_removexattr - Determine whether an xattr may be removed
- * @dentry: The inode/dentry being altered
- * @name: The name of the xattr to be changed
+ *
+ * @mnt_userns:	User namespace of the mount the inode was found from
+ * @dentry:	The inode/dentry being altered
+ * @name:	The name of the xattr to be changed
  *
  * Determine whether an xattr may be removed from an inode, returning 0 if
  * permission is granted, -ve if denied.
  *
+ * If the inode has been found through an idmapped mount the user namespace of
+ * the vfsmount must be passed through @mnt_userns. This function will then take
+ * care to map the inode according to @mnt_userns before checking permissions. On
+ * non-idmapped mounts or if permission checking is to be performed on the raw
+ * inode simply passs init_user_ns.
+ *
  * This is used to make sure security xattrs don't get removed by those who
  * aren't privileged to remove them.
  */
-int cap_inode_removexattr(struct dentry *dentry, const char *name)
+int cap_inode_removexattr(struct user_namespace *mnt_userns,
+			  struct dentry *dentry, const char *name)
 {
 	struct user_namespace *user_ns = dentry->d_sb->s_user_ns;
 
@@ -989,8 +1023,7 @@ int cap_inode_removexattr(struct dentry *dentry, const char *name)
 		struct inode *inode = d_backing_inode(dentry);
 		if (!inode)
 			return -EINVAL;
-		if (!capable_wrt_inode_uidgid(&init_user_ns, inode,
-					      CAP_SETFCAP))
+		if (!capable_wrt_inode_uidgid(mnt_userns, inode, CAP_SETFCAP))
 			return -EPERM;
 		return 0;
 	}
diff --git a/security/security.c b/security/security.c
index 7b09cfbae94f..698a9f17bad7 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1280,7 +1280,8 @@ int security_inode_getattr(const struct path *path)
 	return call_int_hook(inode_getattr, 0, path);
 }
 
-int security_inode_setxattr(struct dentry *dentry, const char *name,
+int security_inode_setxattr(struct user_namespace *mnt_userns,
+			    struct dentry *dentry, const char *name,
 			    const void *value, size_t size, int flags)
 {
 	int ret;
@@ -1291,8 +1292,8 @@ int security_inode_setxattr(struct dentry *dentry, const char *name,
 	 * SELinux and Smack integrate the cap call,
 	 * so assume that all LSMs supplying this call do so.
 	 */
-	ret = call_int_hook(inode_setxattr, 1, dentry, name, value, size,
-				flags);
+	ret = call_int_hook(inode_setxattr, 1, mnt_userns, dentry, name, value,
+			    size, flags);
 
 	if (ret == 1)
 		ret = cap_inode_setxattr(dentry, name, value, size, flags);
@@ -1327,7 +1328,8 @@ int security_inode_listxattr(struct dentry *dentry)
 	return call_int_hook(inode_listxattr, 0, dentry);
 }
 
-int security_inode_removexattr(struct dentry *dentry, const char *name)
+int security_inode_removexattr(struct user_namespace *mnt_userns,
+			       struct dentry *dentry, const char *name)
 {
 	int ret;
 
@@ -1337,9 +1339,9 @@ int security_inode_removexattr(struct dentry *dentry, const char *name)
 	 * SELinux and Smack integrate the cap call,
 	 * so assume that all LSMs supplying this call do so.
 	 */
-	ret = call_int_hook(inode_removexattr, 1, dentry, name);
+	ret = call_int_hook(inode_removexattr, 1, mnt_userns, dentry, name);
 	if (ret == 1)
-		ret = cap_inode_removexattr(dentry, name);
+		ret = cap_inode_removexattr(mnt_userns, dentry, name);
 	if (ret)
 		return ret;
 	ret = ima_inode_removexattr(dentry, name);
@@ -1353,12 +1355,15 @@ int security_inode_need_killpriv(struct dentry *dentry)
 	return call_int_hook(inode_need_killpriv, 0, dentry);
 }
 
-int security_inode_killpriv(struct dentry *dentry)
+int security_inode_killpriv(struct user_namespace *mnt_userns,
+			    struct dentry *dentry)
 {
-	return call_int_hook(inode_killpriv, 0, dentry);
+	return call_int_hook(inode_killpriv, 0, mnt_userns, dentry);
 }
 
-int security_inode_getsecurity(struct inode *inode, const char *name, void **buffer, bool alloc)
+int security_inode_getsecurity(struct user_namespace *mnt_userns,
+			       struct inode *inode, const char *name,
+			       void **buffer, bool alloc)
 {
 	struct security_hook_list *hp;
 	int rc;
@@ -1369,7 +1374,7 @@ int security_inode_getsecurity(struct inode *inode, const char *name, void **buf
 	 * Only one module will provide an attribute with a given name.
 	 */
 	hlist_for_each_entry(hp, &security_hook_heads.inode_getsecurity, list) {
-		rc = hp->hook.inode_getsecurity(inode, name, buffer, alloc);
+		rc = hp->hook.inode_getsecurity(mnt_userns, inode, name, buffer, alloc);
 		if (rc != LSM_RET_DEFAULT(inode_getsecurity))
 			return rc;
 	}
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 98756f53a929..6408d763b652 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3119,7 +3119,8 @@ static bool has_cap_mac_admin(bool audit)
 	return true;
 }
 
-static int selinux_inode_setxattr(struct dentry *dentry, const char *name,
+static int selinux_inode_setxattr(struct user_namespace *mnt_userns,
+				  struct dentry *dentry, const char *name,
 				  const void *value, size_t size, int flags)
 {
 	struct inode *inode = d_backing_inode(dentry);
@@ -3140,13 +3141,13 @@ static int selinux_inode_setxattr(struct dentry *dentry, const char *name,
 	}
 
 	if (!selinux_initialized(&selinux_state))
-		return (inode_owner_or_capable(&init_user_ns, inode) ? 0 : -EPERM);
+		return (inode_owner_or_capable(mnt_userns, inode) ? 0 : -EPERM);
 
 	sbsec = inode->i_sb->s_security;
 	if (!(sbsec->flags & SBLABEL_MNT))
 		return -EOPNOTSUPP;
 
-	if (!inode_owner_or_capable(&init_user_ns, inode))
+	if (!inode_owner_or_capable(mnt_userns, inode))
 		return -EPERM;
 
 	ad.type = LSM_AUDIT_DATA_DENTRY;
@@ -3267,10 +3268,11 @@ static int selinux_inode_listxattr(struct dentry *dentry)
 	return dentry_has_perm(cred, dentry, FILE__GETATTR);
 }
 
-static int selinux_inode_removexattr(struct dentry *dentry, const char *name)
+static int selinux_inode_removexattr(struct user_namespace *mnt_userns,
+				     struct dentry *dentry, const char *name)
 {
 	if (strcmp(name, XATTR_NAME_SELINUX)) {
-		int rc = cap_inode_removexattr(dentry, name);
+		int rc = cap_inode_removexattr(mnt_userns, dentry, name);
 		if (rc)
 			return rc;
 
@@ -3336,7 +3338,9 @@ static int selinux_path_notify(const struct path *path, u64 mask,
  *
  * Permission check is handled by selinux_inode_getxattr hook.
  */
-static int selinux_inode_getsecurity(struct inode *inode, const char *name, void **buffer, bool alloc)
+static int selinux_inode_getsecurity(struct user_namespace *mnt_userns,
+				     struct inode *inode, const char *name,
+				     void **buffer, bool alloc)
 {
 	u32 size;
 	int error;
@@ -6532,8 +6536,8 @@ static int selinux_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen)
 static int selinux_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen)
 {
 	int len = 0;
-	len = selinux_inode_getsecurity(inode, XATTR_SELINUX_SUFFIX,
-						ctx, true);
+	len = selinux_inode_getsecurity(&init_user_ns, inode,
+					XATTR_SELINUX_SUFFIX, ctx, true);
 	if (len < 0)
 		return len;
 	*ctxlen = len;
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 8b0b90c6dda2..e2ea446defcc 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -1240,7 +1240,8 @@ static int smack_inode_getattr(const struct path *path)
  *
  * Returns 0 if access is permitted, an error code otherwise
  */
-static int smack_inode_setxattr(struct dentry *dentry, const char *name,
+static int smack_inode_setxattr(struct user_namespace *mnt_userns,
+				struct dentry *dentry, const char *name,
 				const void *value, size_t size, int flags)
 {
 	struct smk_audit_info ad;
@@ -1362,7 +1363,8 @@ static int smack_inode_getxattr(struct dentry *dentry, const char *name)
  *
  * Returns 0 if access is permitted, an error code otherwise
  */
-static int smack_inode_removexattr(struct dentry *dentry, const char *name)
+static int smack_inode_removexattr(struct user_namespace *mnt_userns,
+				   struct dentry *dentry, const char *name)
 {
 	struct inode_smack *isp;
 	struct smk_audit_info ad;
@@ -1377,7 +1379,7 @@ static int smack_inode_removexattr(struct dentry *dentry, const char *name)
 		if (!smack_privileged(CAP_MAC_ADMIN))
 			rc = -EPERM;
 	} else
-		rc = cap_inode_removexattr(dentry, name);
+		rc = cap_inode_removexattr(mnt_userns, dentry, name);
 
 	if (rc != 0)
 		return rc;
@@ -1420,9 +1422,9 @@ static int smack_inode_removexattr(struct dentry *dentry, const char *name)
  *
  * Returns the size of the attribute or an error code
  */
-static int smack_inode_getsecurity(struct inode *inode,
-				   const char *name, void **buffer,
-				   bool alloc)
+static int smack_inode_getsecurity(struct user_namespace *mnt_userns,
+				   struct inode *inode, const char *name,
+				   void **buffer, bool alloc)
 {
 	struct socket_smack *ssp;
 	struct socket *sock;
-- 
2.30.0

