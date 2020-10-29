Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA7AD29DDF6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Oct 2020 01:44:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732869AbgJ2Afp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Oct 2020 20:35:45 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:60665 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731918AbgJ2Afh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Oct 2020 20:35:37 -0400
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kXvua-0008Ep-Vy; Thu, 29 Oct 2020 00:35:29 +0000
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
Subject: [PATCH 10/34] attr: handle idmapped mounts
Date:   Thu, 29 Oct 2020 01:32:28 +0100
Message-Id: <20201029003252.2128653-11-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201029003252.2128653-1-christian.brauner@ubuntu.com>
References: <20201029003252.2128653-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When file attributes are changed filesystems mostly rely on the
setattr_prepare(), setattr_copy(), and notify_change() helpers for
initialization and permission checking. Add the
setattr_mapped_prepare(), setattr_mapped_copy(), and
notify_mapped_change() helpers to handle idmapped mounts. If the inode
is accessed through an idmapped mount we need to map it according to the
mount's user namespace. Afterwards the checks are identical to
non-idmapped mounts. If the initial user namespace is passed all
operations are a nop so non-idmapped mounts will not see a change in
behavior and will also not see any performance impact. It also means
that the inode_owner_or_capable() helper can be implemented on top of
mapped_inode_owner_or_capable() by passing in the initial user
namespace. Helpers that perform checks on the ia_uid and ia_gid fields
in struct iattr assume that ia_uid and ia_gid are intended values and so
they won't be mapped according to the mount's user namespace. This is
more transparent to the caller and further aligns the permission for
notify_change() and notify_mapped_change().

If the initial user namespace is passed all operations are a nop so
non-idmapped mounts will not see a change in behavior and will also not
see any performance impact. It also means that the
setattr_prepare(), setattr_copy(), and notify_change() helpers can
simply be implemented on top of setattr_mapped_prepare(),
setattr_mapped_copy(), and notify_mapped_change() by passing in the
initial user namespace.

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 fs/attr.c          | 136 ++++++++++++++++++++++++++++++++++-----------
 include/linux/fs.h |   6 ++
 2 files changed, 110 insertions(+), 32 deletions(-)

diff --git a/fs/attr.c b/fs/attr.c
index b4bbdbd4c8ca..f39c03ac85e0 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -18,34 +18,39 @@
 #include <linux/evm.h>
 #include <linux/ima.h>
 
-static bool chown_ok(const struct inode *inode, kuid_t uid)
+static bool chown_ok(struct user_namespace *user_ns,
+		     const struct inode *inode,
+		     kuid_t uid)
 {
-	if (uid_eq(current_fsuid(), inode->i_uid) &&
-	    uid_eq(uid, inode->i_uid))
+	kuid_t kuid = i_uid_into_mnt(user_ns, inode);
+	if (uid_eq(current_fsuid(), kuid) && uid_eq(uid, kuid))
 		return true;
-	if (capable_wrt_inode_uidgid(inode, CAP_CHOWN))
+	if (capable_wrt_mapped_inode_uidgid(user_ns, inode, CAP_CHOWN))
 		return true;
-	if (uid_eq(inode->i_uid, INVALID_UID) &&
+	if (uid_eq(kuid, INVALID_UID) &&
 	    ns_capable(inode->i_sb->s_user_ns, CAP_CHOWN))
 		return true;
 	return false;
 }
 
-static bool chgrp_ok(const struct inode *inode, kgid_t gid)
+static bool chgrp_ok(struct user_namespace *user_ns,
+		     const struct inode *inode, kgid_t gid)
 {
-	if (uid_eq(current_fsuid(), inode->i_uid) &&
-	    (in_group_p(gid) || gid_eq(gid, inode->i_gid)))
+	kgid_t kgid = i_gid_into_mnt(user_ns, inode);
+	if (uid_eq(current_fsuid(), i_uid_into_mnt(user_ns, inode)) &&
+	    (in_group_p(gid) || gid_eq(gid, kgid)))
 		return true;
-	if (capable_wrt_inode_uidgid(inode, CAP_CHOWN))
+	if (capable_wrt_mapped_inode_uidgid(user_ns, inode, CAP_CHOWN))
 		return true;
-	if (gid_eq(inode->i_gid, INVALID_GID) &&
+	if (gid_eq(kgid, INVALID_GID) &&
 	    ns_capable(inode->i_sb->s_user_ns, CAP_CHOWN))
 		return true;
 	return false;
 }
 
 /**
- * setattr_prepare - check if attribute changes to a dentry are allowed
+ * setattr_mapped_prepare - check if attribute changes to a dentry are allowed
+ * @user_ns:	user namespace of the mount
  * @dentry:	dentry to check
  * @attr:	attributes to change
  *
@@ -58,7 +63,8 @@ static bool chgrp_ok(const struct inode *inode, kgid_t gid)
  * Should be called as the first thing in ->setattr implementations,
  * possibly after taking additional locks.
  */
-int setattr_prepare(struct dentry *dentry, struct iattr *attr)
+int setattr_mapped_prepare(struct user_namespace *user_ns,
+			   struct dentry *dentry, struct iattr *attr)
 {
 	struct inode *inode = d_inode(dentry);
 	unsigned int ia_valid = attr->ia_valid;
@@ -78,27 +84,27 @@ int setattr_prepare(struct dentry *dentry, struct iattr *attr)
 		goto kill_priv;
 
 	/* Make sure a caller can chown. */
-	if ((ia_valid & ATTR_UID) && !chown_ok(inode, attr->ia_uid))
+	if ((ia_valid & ATTR_UID) && !chown_ok(user_ns, inode, attr->ia_uid))
 		return -EPERM;
 
 	/* Make sure caller can chgrp. */
-	if ((ia_valid & ATTR_GID) && !chgrp_ok(inode, attr->ia_gid))
+	if ((ia_valid & ATTR_GID) && !chgrp_ok(user_ns, inode, attr->ia_gid))
 		return -EPERM;
 
 	/* Make sure a caller can chmod. */
 	if (ia_valid & ATTR_MODE) {
-		if (!inode_owner_or_capable(inode))
+		if (!mapped_inode_owner_or_capable(user_ns, inode))
 			return -EPERM;
 		/* Also check the setgid bit! */
-		if (!in_group_p((ia_valid & ATTR_GID) ? attr->ia_gid :
-				inode->i_gid) &&
-		    !capable_wrt_inode_uidgid(inode, CAP_FSETID))
+               if (!in_group_p((ia_valid & ATTR_GID) ? attr->ia_gid :
+                                i_gid_into_mnt(user_ns, inode)) &&
+                    !capable_wrt_inode_uidgid(inode, CAP_FSETID))
 			attr->ia_mode &= ~S_ISGID;
 	}
 
 	/* Check for setting the inode time. */
 	if (ia_valid & (ATTR_MTIME_SET | ATTR_ATIME_SET | ATTR_TIMES_SET)) {
-		if (!inode_owner_or_capable(inode))
+		if (!mapped_inode_owner_or_capable(user_ns, inode))
 			return -EPERM;
 	}
 
@@ -114,6 +120,12 @@ int setattr_prepare(struct dentry *dentry, struct iattr *attr)
 
 	return 0;
 }
+EXPORT_SYMBOL(setattr_mapped_prepare);
+
+int setattr_prepare(struct dentry *dentry, struct iattr *attr)
+{
+	return setattr_mapped_prepare(&init_user_ns, dentry, attr);
+}
 EXPORT_SYMBOL(setattr_prepare);
 
 /**
@@ -161,21 +173,28 @@ int inode_newsize_ok(const struct inode *inode, loff_t offset)
 EXPORT_SYMBOL(inode_newsize_ok);
 
 /**
- * setattr_copy - copy simple metadata updates into the generic inode
+ * setattr_mappedcopy - copy simple metadata updates into the generic inode on idmapped mounts
+ * @user_ns:	the user namespace the inode is accessed from
  * @inode:	the inode to be updated
  * @attr:	the new attributes
  *
- * setattr_copy must be called with i_mutex held.
+ * setattr_mapped_copy must be called with i_mutex held.
  *
- * setattr_copy updates the inode's metadata with that specified
- * in attr. Noticeably missing is inode size update, which is more complex
+ * setattr_mapped_copy updates the inode's metadata with that specified
+ * in attr on idmapped mounts. If file ownership is changed setattr_mapped_copy
+ * doesn't map ia_uid and ia_gid. It will asssume the caller has already
+ * provided the intended values. Necessary permission checks to determine
+ * whether or not the S_ISGID property needs to be removed are performed with
+ * the correct idmapped mount permission helpers.
+ * Noticeably missing is inode size update, which is more complex
  * as it requires pagecache updates.
  *
  * The inode is not marked as dirty after this operation. The rationale is
  * that for "simple" filesystems, the struct inode is the inode storage.
  * The caller is free to mark the inode dirty afterwards if needed.
  */
-void setattr_copy(struct inode *inode, const struct iattr *attr)
+void setattr_mapped_copy(struct user_namespace *user_ns, struct inode *inode,
+			 const struct iattr *attr)
 {
 	unsigned int ia_valid = attr->ia_valid;
 
@@ -191,36 +210,62 @@ void setattr_copy(struct inode *inode, const struct iattr *attr)
 		inode->i_ctime = attr->ia_ctime;
 	if (ia_valid & ATTR_MODE) {
 		umode_t mode = attr->ia_mode;
-
-		if (!in_group_p(inode->i_gid) &&
-		    !capable_wrt_inode_uidgid(inode, CAP_FSETID))
+		kgid_t kgid = i_gid_into_mnt(user_ns, inode);
+		if (!in_group_p(kgid) &&
+		    !capable_wrt_mapped_inode_uidgid(user_ns, inode, CAP_FSETID))
 			mode &= ~S_ISGID;
 		inode->i_mode = mode;
 	}
 }
+EXPORT_SYMBOL(setattr_mapped_copy);
+
+/**
+ * setattr_copy - copy simple metadata updates into the generic inode
+ * @inode:	the inode to be updated
+ * @attr:	the new attributes
+ *
+ * setattr_copy must be called with i_mutex held.
+ *
+ * setattr_copy updates the inode's metadata with that specified
+ * in attr. Noticeably missing is inode size update, which is more complex
+ * as it requires pagecache updates.
+ *
+ * The inode is not marked as dirty after this operation. The rationale is
+ * that for "simple" filesystems, the struct inode is the inode storage.
+ * The caller is free to mark the inode dirty afterwards if needed.
+ */
+void setattr_copy(struct inode *inode, const struct iattr *attr)
+{
+	return setattr_mapped_copy(&init_user_ns, inode, attr);
+}
 EXPORT_SYMBOL(setattr_copy);
 
 /**
- * notify_change - modify attributes of a filesytem object
+ * notify_mapped_change - modify attributes of a filesytem object on idmapped mounts
+ * @user_ns:	the user namespace of the mount
  * @dentry:	object affected
  * @attr:	new attributes
  * @delegated_inode: returns inode, if the inode is delegated
  *
  * The caller must hold the i_mutex on the affected object.
  *
- * If notify_change discovers a delegation in need of breaking,
+ * If notify_mapped_change discovers a delegation in need of breaking,
  * it will return -EWOULDBLOCK and return a reference to the inode in
  * delegated_inode.  The caller should then break the delegation and
  * retry.  Because breaking a delegation may take a long time, the
  * caller should drop the i_mutex before doing so.
  *
+ * If file ownership is changed notify_mapped_change() doesn't map ia_uid and
+ * ia_gid. It will asssume the caller has already provided the intended values.
+ *
  * Alternatively, a caller may pass NULL for delegated_inode.  This may
  * be appropriate for callers that expect the underlying filesystem not
  * to be NFS exported.  Also, passing NULL is fine for callers holding
  * the file open for write, as there can be no conflicting delegation in
  * that case.
  */
-int notify_change(struct dentry * dentry, struct iattr * attr, struct inode **delegated_inode)
+int notify_mapped_change(struct user_namespace *user_ns, struct dentry *dentry,
+			 struct iattr *attr, struct inode **delegated_inode)
 {
 	struct inode *inode = dentry->d_inode;
 	umode_t mode = inode->i_mode;
@@ -243,8 +288,8 @@ int notify_change(struct dentry * dentry, struct iattr * attr, struct inode **de
 		if (IS_IMMUTABLE(inode))
 			return -EPERM;
 
-		if (!inode_owner_or_capable(inode)) {
-			error = inode_permission(inode, MAY_WRITE);
+		if (!mapped_inode_owner_or_capable(user_ns, inode)) {
+			error = mapped_inode_permission(user_ns, inode, MAY_WRITE);
 			if (error)
 				return error;
 		}
@@ -345,4 +390,31 @@ int notify_change(struct dentry * dentry, struct iattr * attr, struct inode **de
 
 	return error;
 }
+EXPORT_SYMBOL(notify_mapped_change);
+
+/**
+ * notify_change - modify attributes of a filesytem object
+ * @dentry:	object affected
+ * @attr:	new attributes
+ * @delegated_inode: returns inode, if the inode is delegated
+ *
+ * The caller must hold the i_mutex on the affected object.
+ *
+ * If notify_change discovers a delegation in need of breaking,
+ * it will return -EWOULDBLOCK and return a reference to the inode in
+ * delegated_inode.  The caller should then break the delegation and
+ * retry.  Because breaking a delegation may take a long time, the
+ * caller should drop the i_mutex before doing so.
+ *
+ * Alternatively, a caller may pass NULL for delegated_inode.  This may
+ * be appropriate for callers that expect the underlying filesystem not
+ * to be NFS exported.  Also, passing NULL is fine for callers holding
+ * the file open for write, as there can be no conflicting delegation in
+ * that case.
+ */
+int notify_change(struct dentry *dentry, struct iattr *attr,
+		  struct inode **delegated_inode)
+{
+	return notify_mapped_change(&init_user_ns, dentry, attr, delegated_inode);
+}
 EXPORT_SYMBOL(notify_change);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index f9e2d292b7b6..f41d93b0e6d7 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2823,6 +2823,8 @@ static inline int bmap(struct inode *inode,  sector_t *block)
 #endif
 
 extern int notify_change(struct dentry *, struct iattr *, struct inode **);
+extern int notify_mapped_change(struct user_namespace *, struct dentry *,
+			    struct iattr *, struct inode **);
 extern int inode_permission(struct inode *, int);
 extern int mapped_inode_permission(struct user_namespace *, struct inode *, int);
 extern int generic_permission(struct inode *, int);
@@ -3282,8 +3284,12 @@ extern int buffer_migrate_page_norefs(struct address_space *,
 #endif
 
 extern int setattr_prepare(struct dentry *, struct iattr *);
+extern int setattr_mapped_prepare(struct user_namespace *, struct dentry *,
+			      struct iattr *);
 extern int inode_newsize_ok(const struct inode *, loff_t offset);
 extern void setattr_copy(struct inode *inode, const struct iattr *attr);
+extern void setattr_mapped_copy(struct user_namespace *user_ns, struct inode *inode,
+			    const struct iattr *attr);
 
 extern int file_update_time(struct file *file);
 
-- 
2.29.0

