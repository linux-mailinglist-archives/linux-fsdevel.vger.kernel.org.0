Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2C9429DE3F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Oct 2020 01:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390300AbgJ2Axb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Oct 2020 20:53:31 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:60647 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730334AbgJ2Afc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Oct 2020 20:35:32 -0400
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kXvuZ-0008Ep-AG; Thu, 29 Oct 2020 00:35:27 +0000
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
Subject: [PATCH 09/34] inode: add idmapped mount aware init and permission helpers
Date:   Thu, 29 Oct 2020 01:32:27 +0100
Message-Id: <20201029003252.2128653-10-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201029003252.2128653-1-christian.brauner@ubuntu.com>
References: <20201029003252.2128653-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The inode_owner_or_capable() helper determines whether the caller is the
owner of the inode or is capable with respect to that inode. Add a new
mapped_inode_owner_or_capable() helper to handle idmapped mounts. If the
If the inode is accessed through an idmapped mount we first need to map
it according to the mount's user namespace. Afterwards the checks are
identical to non-idmapped mounts. If the initial user namespace is
passed all operations are a nop so non-idmapped mounts will not see a
change in behavior and will also not see any performance impact. It also
means that the inode_owner_or_capable() helper can be implemented on top
of mapped_inode_owner_or_capable() by passing in the initial user
namespace.

Similarly, we add a new mapped_inode_init_owner() helper which
initializes a new inode on idmapped mounts by mapping the fsuid and
fsgid of the caller from the mount's user namespace. If the initial user
namespace is passed all operations are a nop so non-idmapped mounts will
not see a change in behavior and will also not see any performance
impact. It also means that the inode_init_owner() helper can be
implemented on top of mapped_inode_init_owner() by passing in the
initial user namespace.

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 fs/inode.c         | 53 ++++++++++++++++++++++++++++++++++++----------
 include/linux/fs.h |  4 ++++
 2 files changed, 46 insertions(+), 11 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 9d78c37b00b8..22de3cb3b1f4 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -2130,15 +2130,17 @@ void init_special_inode(struct inode *inode, umode_t mode, dev_t rdev)
 EXPORT_SYMBOL(init_special_inode);
 
 /**
- * inode_init_owner - Init uid,gid,mode for new inode according to posix standards
+ * mapped_inode_init_owner - Init uid,gid,mode for new inode according to posix
+ *                           standards on idmapped mounts
  * @inode: New inode
+ * @user_ns: User namespace the inode is accessed from
  * @dir: Directory inode
  * @mode: mode of the new inode
  */
-void inode_init_owner(struct inode *inode, const struct inode *dir,
-			umode_t mode)
+void mapped_inode_init_owner(struct inode *inode, struct user_namespace *user_ns,
+			 const struct inode *dir, umode_t mode)
 {
-	inode->i_uid = current_fsuid();
+	inode->i_uid = fsuid_into_mnt(user_ns);
 	if (dir && dir->i_mode & S_ISGID) {
 		inode->i_gid = dir->i_gid;
 
@@ -2146,34 +2148,63 @@ void inode_init_owner(struct inode *inode, const struct inode *dir,
 		if (S_ISDIR(mode))
 			mode |= S_ISGID;
 		else if ((mode & (S_ISGID | S_IXGRP)) == (S_ISGID | S_IXGRP) &&
-			 !in_group_p(inode->i_gid) &&
-			 !capable_wrt_inode_uidgid(dir, CAP_FSETID))
+			 !in_group_p(i_gid_into_mnt(user_ns, inode)) &&
+			 !capable_wrt_mapped_inode_uidgid(user_ns, dir, CAP_FSETID))
 			mode &= ~S_ISGID;
 	} else
-		inode->i_gid = current_fsgid();
+		inode->i_gid = fsgid_into_mnt(user_ns);
 	inode->i_mode = mode;
 }
+EXPORT_SYMBOL(mapped_inode_init_owner);
+
+/**
+ * inode_init_owner - Init uid,gid,mode for new inode according to posix standards
+ * @inode: New inode
+ * @dir: Directory inode
+ * @mode: mode of the new inode
+ */
+void inode_init_owner(struct inode *inode, const struct inode *dir,
+			umode_t mode)
+{
+	return mapped_inode_init_owner(inode, &init_user_ns, dir, mode);
+}
 EXPORT_SYMBOL(inode_init_owner);
 
 /**
- * inode_owner_or_capable - check current task permissions to inode
+ * mapped_inode_owner_or_capable - check current task permissions to inode on idmapped mounts
+ * @user_ns: User namespace the inode is accessed from
  * @inode: inode being checked
  *
  * Return true if current either has CAP_FOWNER in a namespace with the
  * inode owner uid mapped, or owns the file.
  */
-bool inode_owner_or_capable(const struct inode *inode)
+bool mapped_inode_owner_or_capable(struct user_namespace *user_ns, const struct inode *inode)
 {
+	kuid_t i_uid;
 	struct user_namespace *ns;
 
-	if (uid_eq(current_fsuid(), inode->i_uid))
+	i_uid = i_uid_into_mnt(user_ns, inode);
+	if (uid_eq(current_fsuid(), i_uid))
 		return true;
 
 	ns = current_user_ns();
-	if (kuid_has_mapping(ns, inode->i_uid) && ns_capable(ns, CAP_FOWNER))
+	if (kuid_has_mapping(ns, i_uid) && ns_capable(ns, CAP_FOWNER))
 		return true;
 	return false;
 }
+EXPORT_SYMBOL(mapped_inode_owner_or_capable);
+
+/**
+ * inode_owner_or_capable - check current task permissions to inode
+ * @inode: inode being checked
+ *
+ * Return true if current either has CAP_FOWNER in a namespace with the
+ * inode owner uid mapped, or owns the file.
+ */
+bool inode_owner_or_capable(const struct inode *inode)
+{
+	return mapped_inode_owner_or_capable(&init_user_ns, inode);
+}
 EXPORT_SYMBOL(inode_owner_or_capable);
 
 /*
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 750ca4b3d89f..f9e2d292b7b6 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1777,6 +1777,8 @@ static inline int sb_start_intwrite_trylock(struct super_block *sb)
 
 
 extern bool inode_owner_or_capable(const struct inode *inode);
+extern bool mapped_inode_owner_or_capable(struct user_namespace *ns,
+				      const struct inode *inode);
 
 /*
  * VFS helper functions..
@@ -1820,6 +1822,8 @@ extern long compat_ptr_ioctl(struct file *file, unsigned int cmd,
  */
 extern void inode_init_owner(struct inode *inode, const struct inode *dir,
 			umode_t mode);
+extern void mapped_inode_init_owner(struct inode *inode, struct user_namespace *user_ns,
+			 const struct inode *dir, umode_t mode);
 extern bool may_open_dev(const struct path *path);
 
 /*
-- 
2.29.0

