Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AED8429DDFA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Oct 2020 01:44:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731301AbgJ2Aob (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Oct 2020 20:44:31 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:60781 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729745AbgJ2Afp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Oct 2020 20:35:45 -0400
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kXvuh-0008Ep-SK; Thu, 29 Oct 2020 00:35:35 +0000
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
Subject: [PATCH 14/34] commoncap: handle idmapped mounts
Date:   Thu, 29 Oct 2020 01:32:32 +0100
Message-Id: <20201029003252.2128653-15-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201029003252.2128653-1-christian.brauner@ubuntu.com>
References: <20201029003252.2128653-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
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
In order to actually get filesystem capabilities from disk the capability
infrastructure exposes the get_vfs_caps_from_disk() helper. For user namespace
aware filesystem capabilities a root uid is stored alongside the capabilities.
In order to determine whether the caller can make use of the filesystem
capability or whether it needs to be ignored it is translated according to the
superblock's user namespace. If it can be translated to uid 0 according to that
id mapping the caller can use the filesystem capabilities stored on disk. If we
are accessing the inode that holds the filesystem capabilities through an
idmapped mount we need to map root uid according to the mount's user namespace.
Afterwards the checks are identical to non-idmapped mounts. Reading filesystem
caps from disk enforces that the root uid associated with the filesystem
capability must have a mapping in the superblock's user namespace and that the
caller is either in the same user namespace or is a descendant of the superblock's user
namespace. For filesystems that are mountable inside user namespace the
container can just mount the filesystem and won't usually need to idmap it. If
it does create an idmapped mount it can mark it with a user namespace it has
created and which is therefore a descendant of the s_user_ns. For filesystems
that are not mountable inside user namespaces the descendant rule is trivially
true because the s_user_ns will be the initial user namespace.

If the initial user namespace is passed all operations are a nop so
non-idmapped mounts will not see a change in behavior and will also not
see any performance impact. It also means that the non-idmapped-mount
aware helpers can be implemented on top of their idmapped-mount aware
counterparts by passing the initial user namespace.

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 fs/attr.c                     |  2 +-
 fs/xattr.c                    | 12 ++++++------
 include/linux/capability.h    |  3 +++
 include/linux/lsm_hook_defs.h | 10 ++++++----
 include/linux/lsm_hooks.h     |  1 +
 include/linux/security.h      | 36 +++++++++++++++++++++++------------
 kernel/auditsc.c              |  3 ++-
 security/commoncap.c          | 35 ++++++++++++++++++++++++----------
 security/security.c           | 18 +++++++++++-------
 security/selinux/hooks.c      | 13 ++++++++-----
 security/smack/smack_lsm.c    | 11 ++++++-----
 11 files changed, 93 insertions(+), 51 deletions(-)

diff --git a/fs/attr.c b/fs/attr.c
index f39c03ac85e0..4daf6ac6de6d 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -113,7 +113,7 @@ int setattr_mapped_prepare(struct user_namespace *user_ns,
 	if (ia_valid & ATTR_KILL_PRIV) {
 		int error;
 
-		error = security_inode_killpriv(dentry);
+		error = security_inode_killpriv(user_ns, dentry);
 		if (error)
 			return error;
 	}
diff --git a/fs/xattr.c b/fs/xattr.c
index cdda2baeb9f7..40b02227257e 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -331,18 +331,18 @@ vfs_setxattr(struct dentry *dentry, const char *name, const void *value,
 EXPORT_SYMBOL_GPL(vfs_setxattr);
 
 static ssize_t
-xattr_getsecurity(struct inode *inode, const char *name, void *value,
-			size_t size)
+xattr_getsecurity(struct user_namespace *user_ns, struct inode *inode,
+		  const char *name, void *value, size_t size)
 {
 	void *buffer = NULL;
 	ssize_t len;
 
 	if (!value || !size) {
-		len = security_inode_getsecurity(inode, name, &buffer, false);
+		len = security_inode_getsecurity(user_ns, inode, name, &buffer, false);
 		goto out_noalloc;
 	}
 
-	len = security_inode_getsecurity(inode, name, &buffer, true);
+	len = security_inode_getsecurity(user_ns, inode, name, &buffer, true);
 	if (len < 0)
 		return len;
 	if (size < len) {
@@ -440,7 +440,7 @@ vfs_mapped_getxattr(struct user_namespace *user_ns, struct dentry *dentry,
 	if (!strncmp(name, XATTR_SECURITY_PREFIX,
 				XATTR_SECURITY_PREFIX_LEN)) {
 		const char *suffix = name + XATTR_SECURITY_PREFIX_LEN;
-		int ret = xattr_getsecurity(inode, suffix, value, size);
+		int ret = xattr_getsecurity(user_ns, inode, suffix, value, size);
 		/*
 		 * Only overwrite the return value if a security module
 		 * is actually active.
@@ -515,7 +515,7 @@ __vfs_mapped_removexattr_locked(struct user_namespace *user_ns,
 	if (error)
 		return error;
 
-	error = security_inode_removexattr(dentry, name);
+	error = security_inode_removexattr(user_ns, dentry, name);
 	if (error)
 		goto out;
 
diff --git a/include/linux/capability.h b/include/linux/capability.h
index 7e9277d64024..630fcc60b955 100644
--- a/include/linux/capability.h
+++ b/include/linux/capability.h
@@ -273,6 +273,9 @@ static inline bool checkpoint_restore_ns_capable(struct user_namespace *ns)
 
 /* audit system wants to get cap info from files as well */
 extern int get_vfs_caps_from_disk(const struct dentry *dentry, struct cpu_vfs_cap_data *cpu_caps);
+extern int get_mapped_vfs_caps_from_disk(struct user_namespace *user_ns,
+				     const struct dentry *dentry,
+				     struct cpu_vfs_cap_data *cpu_caps);
 
 extern int cap_convert_nscap(struct user_namespace *user_ns,
 			     struct dentry *dentry, void **ivalue, size_t size);
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 32a940117e7a..980297f9028f 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -139,11 +139,13 @@ LSM_HOOK(void, LSM_RET_VOID, inode_post_setxattr, struct dentry *dentry,
 	 const char *name, const void *value, size_t size, int flags)
 LSM_HOOK(int, 0, inode_getxattr, struct dentry *dentry, const char *name)
 LSM_HOOK(int, 0, inode_listxattr, struct dentry *dentry)
-LSM_HOOK(int, 0, inode_removexattr, struct dentry *dentry, const char *name)
+LSM_HOOK(int, 0, inode_removexattr, struct user_namespace *user_ns,
+	 struct dentry *dentry, const char *name)
 LSM_HOOK(int, 0, inode_need_killpriv, struct dentry *dentry)
-LSM_HOOK(int, 0, inode_killpriv, struct dentry *dentry)
-LSM_HOOK(int, -EOPNOTSUPP, inode_getsecurity, struct inode *inode,
-	 const char *name, void **buffer, bool alloc)
+LSM_HOOK(int, 0, inode_killpriv, struct user_namespace *user_ns,
+	 struct dentry *dentry)
+LSM_HOOK(int, -EOPNOTSUPP, inode_getsecurity, struct user_namespace *user_ns,
+	 struct inode *inode, const char *name, void **buffer, bool alloc)
 LSM_HOOK(int, -EOPNOTSUPP, inode_setsecurity, struct inode *inode,
 	 const char *name, const void *value, size_t size, int flags)
 LSM_HOOK(int, 0, inode_listsecurity, struct inode *inode, char *buffer,
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index c503f7ab8afb..465c9c308922 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -444,6 +444,7 @@
  * @inode_killpriv:
  *	The setuid bit is being removed.  Remove similar security labels.
  *	Called with the dentry->d_inode->i_mutex held.
+ *	@user_ns the user namespace of the mount.
  *	@dentry is the dentry being changed.
  *	Return 0 on success.  If error is returned, then the operation
  *	causing setuid bit removal is failed.
diff --git a/include/linux/security.h b/include/linux/security.h
index bc2725491560..c148200041e8 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -146,10 +146,13 @@ extern int cap_capset(struct cred *new, const struct cred *old,
 extern int cap_bprm_creds_from_file(struct linux_binprm *bprm, struct file *file);
 extern int cap_inode_setxattr(struct dentry *dentry, const char *name,
 			      const void *value, size_t size, int flags);
-extern int cap_inode_removexattr(struct dentry *dentry, const char *name);
+extern int cap_inode_removexattr(struct user_namespace *user_ns,
+				 struct dentry *dentry, const char *name);
 extern int cap_inode_need_killpriv(struct dentry *dentry);
-extern int cap_inode_killpriv(struct dentry *dentry);
-extern int cap_inode_getsecurity(struct inode *inode, const char *name,
+extern int cap_inode_killpriv(struct user_namespace *user_ns,
+			      struct dentry *dentry);
+extern int cap_inode_getsecurity(struct user_namespace *user_ns,
+				 struct inode *inode, const char *name,
 				 void **buffer, bool alloc);
 extern int cap_mmap_addr(unsigned long addr);
 extern int cap_mmap_file(struct file *file, unsigned long reqprot,
@@ -350,10 +353,14 @@ void security_inode_post_setxattr(struct dentry *dentry, const char *name,
 				  const void *value, size_t size, int flags);
 int security_inode_getxattr(struct dentry *dentry, const char *name);
 int security_inode_listxattr(struct dentry *dentry);
-int security_inode_removexattr(struct dentry *dentry, const char *name);
+int security_inode_removexattr(struct user_namespace *user_ns,
+			       struct dentry *dentry, const char *name);
 int security_inode_need_killpriv(struct dentry *dentry);
-int security_inode_killpriv(struct dentry *dentry);
-int security_inode_getsecurity(struct inode *inode, const char *name, void **buffer, bool alloc);
+int security_inode_killpriv(struct user_namespace *user_ns,
+			    struct dentry *dentry);
+int security_inode_getsecurity(struct user_namespace *user_ns,
+			       struct inode *inode, const char *name,
+			       void **buffer, bool alloc);
 int security_inode_setsecurity(struct inode *inode, const char *name, const void *value, size_t size, int flags);
 int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer_size);
 void security_inode_getsecid(struct inode *inode, u32 *secid);
@@ -851,10 +858,11 @@ static inline int security_inode_listxattr(struct dentry *dentry)
 	return 0;
 }
 
-static inline int security_inode_removexattr(struct dentry *dentry,
-			const char *name)
+static inline int security_inode_removexattr(struct user_namespace *user_ns,
+					     struct dentry *dentry,
+					     const char *name)
 {
-	return cap_inode_removexattr(dentry, name);
+	return cap_inode_removexattr(user_ns, dentry, name);
 }
 
 static inline int security_inode_need_killpriv(struct dentry *dentry)
@@ -862,12 +870,16 @@ static inline int security_inode_need_killpriv(struct dentry *dentry)
 	return cap_inode_need_killpriv(dentry);
 }
 
-static inline int security_inode_killpriv(struct dentry *dentry)
+static inline int security_inode_killpriv(struct user_namespace *user_ns,
+					  struct dentry *dentry)
 {
-	return cap_inode_killpriv(dentry);
+	return cap_inode_killpriv(user_ns, dentry);
 }
 
-static inline int security_inode_getsecurity(struct inode *inode, const char *name, void **buffer, bool alloc)
+static inline int security_inode_getsecurity(struct user_namespace *user_ns,
+					     struct inode *inode,
+					     const char *name, void **buffer,
+					     bool alloc)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 8dba8f0983b5..9cdecdea61d9 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -2495,7 +2495,8 @@ int __audit_log_bprm_fcaps(struct linux_binprm *bprm,
 	ax->d.next = context->aux;
 	context->aux = (void *)ax;
 
-	get_vfs_caps_from_disk(bprm->file->f_path.dentry, &vcaps);
+	get_mapped_vfs_caps_from_disk(mnt_user_ns(bprm->file->f_path.mnt),
+				  bprm->file->f_path.dentry, &vcaps);
 
 	ax->fcap.permitted = vcaps.permitted;
 	ax->fcap.inheritable = vcaps.inheritable;
diff --git a/security/commoncap.c b/security/commoncap.c
index 21f2ff7c346b..4da61ed86b1d 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -303,17 +303,18 @@ int cap_inode_need_killpriv(struct dentry *dentry)
 
 /**
  * cap_inode_killpriv - Erase the security markings on an inode
+ * @user_ns: The user namespace of the mount
  * @dentry: The inode/dentry to alter
  *
  * Erase the privilege-enhancing security markings on an inode.
  *
  * Returns 0 if successful, -ve on error.
  */
-int cap_inode_killpriv(struct dentry *dentry)
+int cap_inode_killpriv(struct user_namespace *user_ns, struct dentry *dentry)
 {
 	int error;
 
-	error = __vfs_removexattr(dentry, XATTR_NAME_CAPS);
+	error = __vfs_mapped_removexattr(user_ns, dentry, XATTR_NAME_CAPS);
 	if (error == -EOPNOTSUPP)
 		error = 0;
 	return error;
@@ -366,8 +367,8 @@ static bool is_v3header(size_t size, const struct vfs_cap_data *cap)
  * by the integrity subsystem, which really wants the unconverted values -
  * so that's good.
  */
-int cap_inode_getsecurity(struct inode *inode, const char *name, void **buffer,
-			  bool alloc)
+int cap_inode_getsecurity(struct user_namespace *user_ns, struct inode *inode,
+			  const char *name, void **buffer, bool alloc)
 {
 	int size, ret;
 	kuid_t kroot;
@@ -386,8 +387,8 @@ int cap_inode_getsecurity(struct inode *inode, const char *name, void **buffer,
 		return -EINVAL;
 
 	size = sizeof(struct vfs_ns_cap_data);
-	ret = (int) vfs_getxattr_alloc(dentry, XATTR_NAME_CAPS,
-				 &tmpbuf, size, GFP_NOFS);
+	ret = (int)vfs_mapped_getxattr_alloc(user_ns, dentry, XATTR_NAME_CAPS,
+					 &tmpbuf, size, GFP_NOFS);
 	dput(dentry);
 
 	if (ret < 0)
@@ -412,6 +413,9 @@ int cap_inode_getsecurity(struct inode *inode, const char *name, void **buffer,
 	root = le32_to_cpu(nscap->rootid);
 	kroot = make_kuid(fs_ns, root);
 
+	/* If this is an idmapped mount shift the kuid. */
+	kroot = kuid_into_mnt(user_ns, kroot);
+
 	/* If the root kuid maps to a valid uid in current ns, then return
 	 * this as a nscap. */
 	mappedroot = from_kuid(current_user_ns(), kroot);
@@ -573,7 +577,9 @@ static inline int bprm_caps_from_vfs_caps(struct cpu_vfs_cap_data *caps,
 /*
  * Extract the on-exec-apply capability sets for an executable file.
  */
-int get_vfs_caps_from_disk(const struct dentry *dentry, struct cpu_vfs_cap_data *cpu_caps)
+int get_mapped_vfs_caps_from_disk(struct user_namespace *user_ns,
+			      const struct dentry *dentry,
+			      struct cpu_vfs_cap_data *cpu_caps)
 {
 	struct inode *inode = d_backing_inode(dentry);
 	__u32 magic_etc;
@@ -629,6 +635,7 @@ int get_vfs_caps_from_disk(const struct dentry *dentry, struct cpu_vfs_cap_data
 	/* Limit the caps to the mounter of the filesystem
 	 * or the more limited uid specified in the xattr.
 	 */
+	rootkuid = kuid_into_mnt(user_ns, rootkuid);
 	if (!rootid_owns_currentns(rootkuid))
 		return -ENODATA;
 
@@ -647,6 +654,12 @@ int get_vfs_caps_from_disk(const struct dentry *dentry, struct cpu_vfs_cap_data
 	return 0;
 }
 
+int get_vfs_caps_from_disk(const struct dentry *dentry,
+			   struct cpu_vfs_cap_data *cpu_caps)
+{
+	return get_mapped_vfs_caps_from_disk(&init_user_ns, dentry, cpu_caps);
+}
+
 /*
  * Attempt to get the on-exec apply capability sets for an executable file from
  * its xattrs and, if present, apply them to the proposed credentials being
@@ -674,7 +687,7 @@ static int get_file_caps(struct linux_binprm *bprm, struct file *file,
 	if (!current_in_userns(file->f_path.mnt->mnt_sb->s_user_ns))
 		return 0;
 
-	rc = get_vfs_caps_from_disk(file->f_path.dentry, &vcaps);
+	rc = get_mapped_vfs_caps_from_disk(mnt_user_ns(file->f_path.mnt), file->f_path.dentry, &vcaps);
 	if (rc < 0) {
 		if (rc == -EINVAL)
 			printk(KERN_NOTICE "Invalid argument reading file caps for %s\n",
@@ -939,6 +952,7 @@ int cap_inode_setxattr(struct dentry *dentry, const char *name,
 
 /**
  * cap_inode_removexattr - Determine whether an xattr may be removed
+ * @user_ns: The user namespace of the vfsmount
  * @dentry: The inode/dentry being altered
  * @name: The name of the xattr to be changed
  *
@@ -948,7 +962,8 @@ int cap_inode_setxattr(struct dentry *dentry, const char *name,
  * This is used to make sure security xattrs don't get removed by those who
  * aren't privileged to remove them.
  */
-int cap_inode_removexattr(struct dentry *dentry, const char *name)
+int cap_inode_removexattr(struct user_namespace *mnt_user_ns,
+			  struct dentry *dentry, const char *name)
 {
 	struct user_namespace *user_ns = dentry->d_sb->s_user_ns;
 
@@ -962,7 +977,7 @@ int cap_inode_removexattr(struct dentry *dentry, const char *name)
 		struct inode *inode = d_backing_inode(dentry);
 		if (!inode)
 			return -EINVAL;
-		if (!capable_wrt_inode_uidgid(inode, CAP_SETFCAP))
+		if (!capable_wrt_mapped_inode_uidgid(mnt_user_ns, inode, CAP_SETFCAP))
 			return -EPERM;
 		return 0;
 	}
diff --git a/security/security.c b/security/security.c
index a28045dc9e7f..b72940314ed5 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1326,7 +1326,8 @@ int security_inode_listxattr(struct dentry *dentry)
 	return call_int_hook(inode_listxattr, 0, dentry);
 }
 
-int security_inode_removexattr(struct dentry *dentry, const char *name)
+int security_inode_removexattr(struct user_namespace *user_ns,
+			       struct dentry *dentry, const char *name)
 {
 	int ret;
 
@@ -1336,9 +1337,9 @@ int security_inode_removexattr(struct dentry *dentry, const char *name)
 	 * SELinux and Smack integrate the cap call,
 	 * so assume that all LSMs supplying this call do so.
 	 */
-	ret = call_int_hook(inode_removexattr, 1, dentry, name);
+	ret = call_int_hook(inode_removexattr, 1, user_ns, dentry, name);
 	if (ret == 1)
-		ret = cap_inode_removexattr(dentry, name);
+		ret = cap_inode_removexattr(user_ns, dentry, name);
 	if (ret)
 		return ret;
 	ret = ima_inode_removexattr(dentry, name);
@@ -1352,12 +1353,15 @@ int security_inode_need_killpriv(struct dentry *dentry)
 	return call_int_hook(inode_need_killpriv, 0, dentry);
 }
 
-int security_inode_killpriv(struct dentry *dentry)
+int security_inode_killpriv(struct user_namespace *user_ns,
+			    struct dentry *dentry)
 {
-	return call_int_hook(inode_killpriv, 0, dentry);
+	return call_int_hook(inode_killpriv, 0, user_ns, dentry);
 }
 
-int security_inode_getsecurity(struct inode *inode, const char *name, void **buffer, bool alloc)
+int security_inode_getsecurity(struct user_namespace *user_ns,
+			       struct inode *inode, const char *name,
+			       void **buffer, bool alloc)
 {
 	struct security_hook_list *hp;
 	int rc;
@@ -1368,7 +1372,7 @@ int security_inode_getsecurity(struct inode *inode, const char *name, void **buf
 	 * Only one module will provide an attribute with a given name.
 	 */
 	hlist_for_each_entry(hp, &security_hook_heads.inode_getsecurity, list) {
-		rc = hp->hook.inode_getsecurity(inode, name, buffer, alloc);
+		rc = hp->hook.inode_getsecurity(user_ns, inode, name, buffer, alloc);
 		if (rc != LSM_RET_DEFAULT(inode_getsecurity))
 			return rc;
 	}
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 6b1826fc3658..3af7e8a39fd4 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3260,10 +3260,11 @@ static int selinux_inode_listxattr(struct dentry *dentry)
 	return dentry_has_perm(cred, dentry, FILE__GETATTR);
 }
 
-static int selinux_inode_removexattr(struct dentry *dentry, const char *name)
+static int selinux_inode_removexattr(struct user_namespace *user_ns,
+				     struct dentry *dentry, const char *name)
 {
 	if (strcmp(name, XATTR_NAME_SELINUX)) {
-		int rc = cap_inode_removexattr(dentry, name);
+		int rc = cap_inode_removexattr(user_ns, dentry, name);
 		if (rc)
 			return rc;
 
@@ -3329,7 +3330,9 @@ static int selinux_path_notify(const struct path *path, u64 mask,
  *
  * Permission check is handled by selinux_inode_getxattr hook.
  */
-static int selinux_inode_getsecurity(struct inode *inode, const char *name, void **buffer, bool alloc)
+static int selinux_inode_getsecurity(struct user_namespace *user_ns,
+				     struct inode *inode, const char *name,
+				     void **buffer, bool alloc)
 {
 	u32 size;
 	int error;
@@ -6524,8 +6527,8 @@ static int selinux_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen)
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
index 5c90b9fa4d40..1baf2da5d3e3 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -1362,7 +1362,8 @@ static int smack_inode_getxattr(struct dentry *dentry, const char *name)
  *
  * Returns 0 if access is permitted, an error code otherwise
  */
-static int smack_inode_removexattr(struct dentry *dentry, const char *name)
+static int smack_inode_removexattr(struct user_namespace *user_ns,
+				   struct dentry *dentry, const char *name)
 {
 	struct inode_smack *isp;
 	struct smk_audit_info ad;
@@ -1377,7 +1378,7 @@ static int smack_inode_removexattr(struct dentry *dentry, const char *name)
 		if (!smack_privileged(CAP_MAC_ADMIN))
 			rc = -EPERM;
 	} else
-		rc = cap_inode_removexattr(dentry, name);
+		rc = cap_inode_removexattr(user_ns, dentry, name);
 
 	if (rc != 0)
 		return rc;
@@ -1420,9 +1421,9 @@ static int smack_inode_removexattr(struct dentry *dentry, const char *name)
  *
  * Returns the size of the attribute or an error code
  */
-static int smack_inode_getsecurity(struct inode *inode,
-				   const char *name, void **buffer,
-				   bool alloc)
+static int smack_inode_getsecurity(struct user_namespace *user_ns,
+				   struct inode *inode, const char *name,
+				   void **buffer, bool alloc)
 {
 	struct socket_smack *ssp;
 	struct socket *sock;
-- 
2.29.0

