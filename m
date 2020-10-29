Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EED1429DE28
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Oct 2020 01:53:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389854AbgJ2AxX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Oct 2020 20:53:23 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:60639 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731688AbgJ2Afd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Oct 2020 20:35:33 -0400
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kXvuX-0008Ep-FF; Thu, 29 Oct 2020 00:35:25 +0000
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
Subject: [PATCH 08/34] namei: add idmapped mount aware permission helpers
Date:   Thu, 29 Oct 2020 01:32:26 +0100
Message-Id: <20201029003252.2128653-9-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201029003252.2128653-1-christian.brauner@ubuntu.com>
References: <20201029003252.2128653-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The two helpers inode_permission() and generic_permission() are used by
the vfs to perform basic permission checking by verifying that the
caller is privileged over an inode. In order to handle idmapped mount we
add the two helpers mapped_inode_permission() to
mapped_generic_permission() which take a user namespace argument. On
idmapped mounts the two new helpers will make sure to map the inode
according to the mount's user namespace and then peform identical
permission checks to inode_permission() and generic_permission(). If the
initial user namespace is passed mapped_inode_permission() and
mapped_generic_permission() are identical to inode_permission() and
generic_permission() so there will be no performance impact on
non-idmapped mounts. This also means that the inode_permission() and
generic_permission() helpers can be implemented on top of
mapped_inode_permission() and mapped_generic_permission() respectively
by just passing in the initial user namespace so no code is
unnecessarily duplicated.

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 fs/namei.c                | 71 ++++++++++++++++++++++++++++-----------
 fs/posix_acl.c            | 16 ++++++---
 include/linux/fs.h        |  2 ++
 include/linux/posix_acl.h |  4 ++-
 4 files changed, 67 insertions(+), 26 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index d4a6dd772303..2635f6a57de5 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -259,7 +259,7 @@ void putname(struct filename *name)
 		__putname(name);
 }
 
-static int check_acl(struct inode *inode, int mask)
+static int check_acl(struct user_namespace *user_ns, struct inode *inode, int mask)
 {
 #ifdef CONFIG_FS_POSIX_ACL
 	struct posix_acl *acl;
@@ -271,14 +271,14 @@ static int check_acl(struct inode *inode, int mask)
 		/* no ->get_acl() calls in RCU mode... */
 		if (is_uncached_acl(acl))
 			return -ECHILD;
-	        return posix_acl_permission(inode, acl, mask);
+	        return posix_acl_permission(user_ns, inode, acl, mask);
 	}
 
 	acl = get_acl(inode, ACL_TYPE_ACCESS);
 	if (IS_ERR(acl))
 		return PTR_ERR(acl);
 	if (acl) {
-	        int error = posix_acl_permission(inode, acl, mask);
+	        int error = posix_acl_permission(user_ns, inode, acl, mask);
 	        posix_acl_release(acl);
 	        return error;
 	}
@@ -293,12 +293,14 @@ static int check_acl(struct inode *inode, int mask)
  * Note that the POSIX ACL check cares about the MAY_NOT_BLOCK bit,
  * for RCU walking.
  */
-static int acl_permission_check(struct inode *inode, int mask)
+static int acl_permission_check(struct user_namespace *user_ns, struct inode *inode, int mask)
 {
 	unsigned int mode = inode->i_mode;
+	kuid_t i_uid;
 
 	/* Are we the owner? If so, ACL's don't matter */
-	if (likely(uid_eq(current_fsuid(), inode->i_uid))) {
+	i_uid = i_uid_into_mnt(user_ns, inode);
+	if (likely(uid_eq(current_fsuid(), i_uid))) {
 		mask &= 7;
 		mode >>= 6;
 		return (mask & ~mode) ? -EACCES : 0;
@@ -306,7 +308,7 @@ static int acl_permission_check(struct inode *inode, int mask)
 
 	/* Do we have ACL's? */
 	if (IS_POSIXACL(inode) && (mode & S_IRWXG)) {
-		int error = check_acl(inode, mask);
+		int error = check_acl(user_ns, inode, mask);
 		if (error != -EAGAIN)
 			return error;
 	}
@@ -320,7 +322,8 @@ static int acl_permission_check(struct inode *inode, int mask)
 	 * about? Need to check group ownership if so.
 	 */
 	if (mask & (mode ^ (mode >> 3))) {
-		if (in_group_p(inode->i_gid))
+		kgid_t kgid = i_gid_into_mnt(user_ns, inode);
+		if (in_group_p(kgid))
 			mode >>= 3;
 	}
 
@@ -329,7 +332,7 @@ static int acl_permission_check(struct inode *inode, int mask)
 }
 
 /**
- * generic_permission -  check for access rights on a Posix-like filesystem
+ * mapped_generic_permission -  check for access rights on a Posix-like filesystem
  * @inode:	inode to check access rights for
  * @mask:	right to check for (%MAY_READ, %MAY_WRITE, %MAY_EXEC,
  *		%MAY_NOT_BLOCK ...)
@@ -343,24 +346,25 @@ static int acl_permission_check(struct inode *inode, int mask)
  * request cannot be satisfied (eg. requires blocking or too much complexity).
  * It would then be called again in ref-walk mode.
  */
-int generic_permission(struct inode *inode, int mask)
+int mapped_generic_permission(struct user_namespace *user_ns, struct inode *inode,
+			  int mask)
 {
 	int ret;
 
 	/*
 	 * Do the basic permission checks.
 	 */
-	ret = acl_permission_check(inode, mask);
+	ret = acl_permission_check(user_ns, inode, mask);
 	if (ret != -EACCES)
 		return ret;
 
 	if (S_ISDIR(inode->i_mode)) {
 		/* DACs are overridable for directories */
 		if (!(mask & MAY_WRITE))
-			if (capable_wrt_inode_uidgid(inode,
-						     CAP_DAC_READ_SEARCH))
+			if (capable_wrt_mapped_inode_uidgid(user_ns, inode,
+							    CAP_DAC_READ_SEARCH))
 				return 0;
-		if (capable_wrt_inode_uidgid(inode, CAP_DAC_OVERRIDE))
+		if (capable_wrt_mapped_inode_uidgid(user_ns, inode, CAP_DAC_OVERRIDE))
 			return 0;
 		return -EACCES;
 	}
@@ -370,7 +374,8 @@ int generic_permission(struct inode *inode, int mask)
 	 */
 	mask &= MAY_READ | MAY_WRITE | MAY_EXEC;
 	if (mask == MAY_READ)
-		if (capable_wrt_inode_uidgid(inode, CAP_DAC_READ_SEARCH))
+		if (capable_wrt_mapped_inode_uidgid(user_ns, inode,
+						    CAP_DAC_READ_SEARCH))
 			return 0;
 	/*
 	 * Read/write DACs are always overridable.
@@ -378,11 +383,18 @@ int generic_permission(struct inode *inode, int mask)
 	 * at least one exec bit set.
 	 */
 	if (!(mask & MAY_EXEC) || (inode->i_mode & S_IXUGO))
-		if (capable_wrt_inode_uidgid(inode, CAP_DAC_OVERRIDE))
+		if (capable_wrt_mapped_inode_uidgid(user_ns, inode,
+						    CAP_DAC_OVERRIDE))
 			return 0;
 
 	return -EACCES;
 }
+EXPORT_SYMBOL(mapped_generic_permission);
+
+int generic_permission(struct inode *inode, int mask)
+{
+	return mapped_generic_permission(&init_user_ns, inode, mask);
+}
 EXPORT_SYMBOL(generic_permission);
 
 /*
@@ -391,7 +403,7 @@ EXPORT_SYMBOL(generic_permission);
  * flag in inode->i_opflags, that says "this has not special
  * permission function, use the fast case".
  */
-static inline int do_inode_permission(struct inode *inode, int mask)
+static inline int do_inode_permission(struct user_namespace *user_ns, struct inode *inode, int mask)
 {
 	if (unlikely(!(inode->i_opflags & IOP_FASTPERM))) {
 		if (likely(inode->i_op->permission))
@@ -402,7 +414,7 @@ static inline int do_inode_permission(struct inode *inode, int mask)
 		inode->i_opflags |= IOP_FASTPERM;
 		spin_unlock(&inode->i_lock);
 	}
-	return generic_permission(inode, mask);
+	return mapped_generic_permission(user_ns, inode, mask);
 }
 
 /**
@@ -426,7 +438,9 @@ static int sb_permission(struct super_block *sb, struct inode *inode, int mask)
 }
 
 /**
- * inode_permission - Check for access rights to a given inode
+ * mapped_inode_permission - Check for access rights to a given inode as seen from
+ *			 a given user namespace
+ * @userns: The user namespace the inode is seen from
  * @inode: Inode to check permission on
  * @mask: Right to check for (%MAY_READ, %MAY_WRITE, %MAY_EXEC)
  *
@@ -436,7 +450,7 @@ static int sb_permission(struct super_block *sb, struct inode *inode, int mask)
  *
  * When checking for MAY_APPEND, MAY_WRITE must also be set in @mask.
  */
-int inode_permission(struct inode *inode, int mask)
+int mapped_inode_permission(struct user_namespace *user_ns, struct inode *inode, int mask)
 {
 	int retval;
 
@@ -460,7 +474,7 @@ int inode_permission(struct inode *inode, int mask)
 			return -EACCES;
 	}
 
-	retval = do_inode_permission(inode, mask);
+	retval = do_inode_permission(user_ns, inode, mask);
 	if (retval)
 		return retval;
 
@@ -470,6 +484,23 @@ int inode_permission(struct inode *inode, int mask)
 
 	return security_inode_permission(inode, mask);
 }
+EXPORT_SYMBOL(mapped_inode_permission);
+
+/**
+ * inode_permission - Check for access rights to a given inode
+ * @inode: Inode to check permission on
+ * @mask: Right to check for (%MAY_READ, %MAY_WRITE, %MAY_EXEC)
+ *
+ * Check for read/write/execute permissions on an inode.  We use fs[ug]id for
+ * this, letting us set arbitrary permissions for filesystem access without
+ * changing the "normal" UIDs which are used for other things.
+ *
+ * When checking for MAY_APPEND, MAY_WRITE must also be set in @mask.
+ */
+int inode_permission(struct inode *inode, int mask)
+{
+	return mapped_inode_permission(&init_user_ns, inode, mask);
+}
 EXPORT_SYMBOL(inode_permission);
 
 /**
diff --git a/fs/posix_acl.c b/fs/posix_acl.c
index 95882b3f5f62..f15b6ad35ec3 100644
--- a/fs/posix_acl.c
+++ b/fs/posix_acl.c
@@ -345,10 +345,12 @@ EXPORT_SYMBOL(posix_acl_from_mode);
  * by the acl. Returns -E... otherwise.
  */
 int
-posix_acl_permission(struct inode *inode, const struct posix_acl *acl, int want)
+posix_acl_permission(struct user_namespace *user_ns, struct inode *inode, const struct posix_acl *acl, int want)
 {
 	const struct posix_acl_entry *pa, *pe, *mask_obj;
 	int found = 0;
+	kuid_t uid;
+	kgid_t gid;
 
 	want &= MAY_READ | MAY_WRITE | MAY_EXEC;
 
@@ -356,22 +358,26 @@ posix_acl_permission(struct inode *inode, const struct posix_acl *acl, int want)
                 switch(pa->e_tag) {
                         case ACL_USER_OBJ:
 				/* (May have been checked already) */
-				if (uid_eq(inode->i_uid, current_fsuid()))
+				uid = i_uid_into_mnt(user_ns, inode);
+				if (uid_eq(uid, current_fsuid()))
                                         goto check_perm;
                                 break;
                         case ACL_USER:
-				if (uid_eq(pa->e_uid, current_fsuid()))
+				uid = kuid_into_mnt(user_ns, pa->e_uid);
+				if (uid_eq(uid, current_fsuid()))
                                         goto mask;
 				break;
                         case ACL_GROUP_OBJ:
-                                if (in_group_p(inode->i_gid)) {
+				gid = i_gid_into_mnt(user_ns, inode);
+                                if (in_group_p(gid)) {
 					found = 1;
 					if ((pa->e_perm & want) == want)
 						goto mask;
                                 }
 				break;
                         case ACL_GROUP:
-				if (in_group_p(pa->e_gid)) {
+				gid = kgid_into_mnt(user_ns, pa->e_gid);
+				if (in_group_p(gid)) {
 					found = 1;
 					if ((pa->e_perm & want) == want)
 						goto mask;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 8a891b80d0b4..750ca4b3d89f 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2820,7 +2820,9 @@ static inline int bmap(struct inode *inode,  sector_t *block)
 
 extern int notify_change(struct dentry *, struct iattr *, struct inode **);
 extern int inode_permission(struct inode *, int);
+extern int mapped_inode_permission(struct user_namespace *, struct inode *, int);
 extern int generic_permission(struct inode *, int);
+extern int mapped_generic_permission(struct user_namespace *, struct inode *, int);
 extern int __check_sticky(struct inode *dir, struct inode *inode);
 
 static inline bool execute_ok(struct inode *inode)
diff --git a/include/linux/posix_acl.h b/include/linux/posix_acl.h
index 90797f1b421d..8276baefed13 100644
--- a/include/linux/posix_acl.h
+++ b/include/linux/posix_acl.h
@@ -15,6 +15,8 @@
 #include <linux/refcount.h>
 #include <uapi/linux/posix_acl.h>
 
+struct user_namespace;
+
 struct posix_acl_entry {
 	short			e_tag;
 	unsigned short		e_perm;
@@ -62,7 +64,7 @@ posix_acl_release(struct posix_acl *acl)
 extern void posix_acl_init(struct posix_acl *, int);
 extern struct posix_acl *posix_acl_alloc(int, gfp_t);
 extern int posix_acl_valid(struct user_namespace *, const struct posix_acl *);
-extern int posix_acl_permission(struct inode *, const struct posix_acl *, int);
+extern int posix_acl_permission(struct user_namespace *, struct inode *, const struct posix_acl *, int);
 extern struct posix_acl *posix_acl_from_mode(umode_t, gfp_t);
 extern int posix_acl_equiv_mode(const struct posix_acl *, umode_t *);
 extern int __posix_acl_create(struct posix_acl **, gfp_t, umode_t *);
-- 
2.29.0

