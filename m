Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 829F715F5A4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2020 19:40:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730843AbgBNSiO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Feb 2020 13:38:14 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:33741 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730765AbgBNSiN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Feb 2020 13:38:13 -0500
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1j2fqa-0000uO-CK; Fri, 14 Feb 2020 18:37:52 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@ubuntu.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Aleksa Sarai <cyphar@cyphar.com>, Jann Horn <jannh@google.com>
Cc:     smbarber@chromium.org, Seth Forshee <seth.forshee@canonical.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Serge Hallyn <serge@hallyn.com>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Phil Estes <estesp@gmail.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        containers@lists.linux-foundation.org,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v2 16/28] namei: may_{o_}create(): handle fsid mappings
Date:   Fri, 14 Feb 2020 19:35:42 +0100
Message-Id: <20200214183554.1133805-17-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200214183554.1133805-1-christian.brauner@ubuntu.com>
References: <20200214183554.1133805-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Switch may_{o_}create() to lookup fsids in the fsid mappings. If no fsid
mappings are setup the behavior is unchanged, i.e. fsids are looked up in the
id mappings.

Filesystems that share a superblock in all user namespaces they are mounted in
will retain their old semantics even with the introduction of fsidmappings.

Cc: Jann Horn <jannh@google.com>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
- Jann Horn <jannh@google.com>:
  - Ensure that the correct fsid is used when dealing with userns visible
    filesystems like proc.
---
 fs/namei.c | 36 ++++++++++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 8 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index db6565c99825..c5b014000f13 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -39,6 +39,7 @@
 #include <linux/bitops.h>
 #include <linux/init_task.h>
 #include <linux/uaccess.h>
+#include <linux/fsuidgid.h>
 
 #include "internal.h"
 #include "mount.h"
@@ -287,6 +288,13 @@ static int check_acl(struct inode *inode, int mask)
 	return -EAGAIN;
 }
 
+static inline kuid_t get_current_fsuid(const struct inode *inode)
+{
+	if (is_userns_visible(inode->i_sb->s_iflags))
+		return current_kfsuid();
+	return current_fsuid();
+}
+
 /*
  * This does the basic permission checking
  */
@@ -294,7 +302,7 @@ static int acl_permission_check(struct inode *inode, int mask)
 {
 	unsigned int mode = inode->i_mode;
 
-	if (likely(uid_eq(current_fsuid(), inode->i_uid)))
+	if (likely(uid_eq(get_current_fsuid(inode), inode->i_uid)))
 		mode >>= 6;
 	else {
 		if (IS_POSIXACL(inode) && (mode & S_IRWXG)) {
@@ -980,7 +988,7 @@ static inline int may_follow_link(struct nameidata *nd)
 
 	/* Allowed if owner and follower match. */
 	inode = nd->link_inode;
-	if (uid_eq(current_cred()->fsuid, inode->i_uid))
+	if (uid_eq(get_current_fsuid(inode), inode->i_uid))
 		return 0;
 
 	/* Allowed if parent directory not sticky and world-writable. */
@@ -1097,7 +1105,7 @@ static int may_create_in_sticky(umode_t dir_mode, kuid_t dir_uid,
 	    (!sysctl_protected_regular && S_ISREG(inode->i_mode)) ||
 	    likely(!(dir_mode & S_ISVTX)) ||
 	    uid_eq(inode->i_uid, dir_uid) ||
-	    uid_eq(current_fsuid(), inode->i_uid))
+	    uid_eq(get_current_fsuid(inode), inode->i_uid))
 		return 0;
 
 	if (likely(dir_mode & 0002) ||
@@ -2832,7 +2840,7 @@ EXPORT_SYMBOL(kern_path_mountpoint);
 
 int __check_sticky(struct inode *dir, struct inode *inode)
 {
-	kuid_t fsuid = current_fsuid();
+	kuid_t fsuid = get_current_fsuid(inode);
 
 	if (uid_eq(inode->i_uid, fsuid))
 		return 0;
@@ -2902,6 +2910,20 @@ static int may_delete(struct inode *dir, struct dentry *victim, bool isdir)
 	return 0;
 }
 
+static bool fsid_has_mapping(struct user_namespace *ns, struct super_block *sb)
+{
+	if (is_userns_visible(sb->s_iflags)) {
+		if (!kuid_has_mapping(ns, current_kfsuid()) ||
+		    !kgid_has_mapping(ns, current_kfsgid()))
+			return false;
+	} else if (!kfsuid_has_mapping(ns, current_fsuid()) ||
+		   !kfsgid_has_mapping(ns, current_fsgid())) {
+		return false;
+	}
+
+	return true;
+}
+
 /*	Check whether we can create an object with dentry child in directory
  *  dir.
  *  1. We can't do it if child already exists (open has special treatment for
@@ -2920,8 +2942,7 @@ static inline int may_create(struct inode *dir, struct dentry *child)
 	if (IS_DEADDIR(dir))
 		return -ENOENT;
 	s_user_ns = dir->i_sb->s_user_ns;
-	if (!kuid_has_mapping(s_user_ns, current_fsuid()) ||
-	    !kgid_has_mapping(s_user_ns, current_fsgid()))
+	if (!fsid_has_mapping(s_user_ns, dir->i_sb))
 		return -EOVERFLOW;
 	return inode_permission(dir, MAY_WRITE | MAY_EXEC);
 }
@@ -3103,8 +3124,7 @@ static int may_o_create(const struct path *dir, struct dentry *dentry, umode_t m
 		return error;
 
 	s_user_ns = dir->dentry->d_sb->s_user_ns;
-	if (!kuid_has_mapping(s_user_ns, current_fsuid()) ||
-	    !kgid_has_mapping(s_user_ns, current_fsgid()))
+	if (!fsid_has_mapping(s_user_ns, dir->dentry->d_sb))
 		return -EOVERFLOW;
 
 	error = inode_permission(dir->dentry->d_inode, MAY_WRITE | MAY_EXEC);
-- 
2.25.0

