Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B126F2CE420
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Dec 2020 01:10:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389519AbgLDAKo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Dec 2020 19:10:44 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:42836 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbgLDAKn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Dec 2020 19:10:43 -0500
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kkyY0-0007ka-3F; Fri, 04 Dec 2020 00:02:04 +0000
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
        Aleksa Sarai <cyphar@cyphar.com>,
        Lennart Poettering <lennart@poettering.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>, smbarber@chromium.org,
        Phil Estes <estesp@gmail.com>, Serge Hallyn <serge@hallyn.com>,
        Kees Cook <keescook@chromium.org>,
        Todd Kjos <tkjos@google.com>, Paul Moore <paul@paul-moore.com>,
        Jonathan Corbet <corbet@lwn.net>,
        containers@lists.linux-foundation.org,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v4 27/40] init: handle idmapped mounts
Date:   Fri,  4 Dec 2020 00:57:23 +0100
Message-Id: <20201203235736.3528991-28-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201203235736.3528991-1-christian.brauner@ubuntu.com>
References: <20201203235736.3528991-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Enable the init helpers to handle idmapped mounts by passing down the
mount's user namespace. If the initial user namespace is passed nothing
changes so non-idmapped mounts will see identical behavior as before.

Cc: Christoph Hellwig <hch@lst.de>
Cc: David Howells <dhowells@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
patch introduced

/* v3 */
unchanged

/* v4 */
unchanged
---
 fs/init.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/fs/init.c b/fs/init.c
index 06d8e52ce18e..1db2b392e4e6 100644
--- a/fs/init.c
+++ b/fs/init.c
@@ -49,7 +49,7 @@ int __init init_chdir(const char *filename)
 	error = kern_path(filename, LOOKUP_FOLLOW | LOOKUP_DIRECTORY, &path);
 	if (error)
 		return error;
-	error = inode_permission(&init_user_ns, path.dentry->d_inode,
+	error = inode_permission(mnt_user_ns(path.mnt), path.dentry->d_inode,
 				 MAY_EXEC | MAY_CHDIR);
 	if (!error)
 		set_fs_pwd(current->fs, &path);
@@ -65,7 +65,7 @@ int __init init_chroot(const char *filename)
 	error = kern_path(filename, LOOKUP_FOLLOW | LOOKUP_DIRECTORY, &path);
 	if (error)
 		return error;
-	error = inode_permission(&init_user_ns, path.dentry->d_inode,
+	error = inode_permission(mnt_user_ns(path.mnt), path.dentry->d_inode,
 				 MAY_EXEC | MAY_CHDIR);
 	if (error)
 		goto dput_and_out;
@@ -120,7 +120,7 @@ int __init init_eaccess(const char *filename)
 	error = kern_path(filename, LOOKUP_FOLLOW, &path);
 	if (error)
 		return error;
-	error = inode_permission(&init_user_ns, d_inode(path.dentry),
+	error = inode_permission(mnt_user_ns(path.mnt), d_inode(path.dentry),
 				 MAY_ACCESS);
 	path_put(&path);
 	return error;
@@ -160,8 +160,8 @@ int __init init_mknod(const char *filename, umode_t mode, unsigned int dev)
 		mode &= ~current_umask();
 	error = security_path_mknod(&path, dentry, mode, dev);
 	if (!error)
-		error = vfs_mknod(&init_user_ns, path.dentry->d_inode, dentry,
-				  mode, new_decode_dev(dev));
+		error = vfs_mknod(mnt_user_ns(path.mnt), path.dentry->d_inode,
+				  dentry, mode, new_decode_dev(dev));
 	done_path_create(&path, dentry);
 	return error;
 }
@@ -170,6 +170,7 @@ int __init init_link(const char *oldname, const char *newname)
 {
 	struct dentry *new_dentry;
 	struct path old_path, new_path;
+	struct user_namespace *mnt_userns;
 	int error;
 
 	error = kern_path(oldname, 0, &old_path);
@@ -184,14 +185,15 @@ int __init init_link(const char *oldname, const char *newname)
 	error = -EXDEV;
 	if (old_path.mnt != new_path.mnt)
 		goto out_dput;
-	error = may_linkat(&init_user_ns, &old_path);
+	mnt_userns = mnt_user_ns(new_path.mnt);
+	error = may_linkat(mnt_userns, &old_path);
 	if (unlikely(error))
 		goto out_dput;
 	error = security_path_link(old_path.dentry, &new_path, new_dentry);
 	if (error)
 		goto out_dput;
-	error = vfs_link(old_path.dentry, &init_user_ns,
-			 new_path.dentry->d_inode, new_dentry, NULL);
+	error = vfs_link(old_path.dentry, mnt_userns, new_path.dentry->d_inode,
+			 new_dentry, NULL);
 out_dput:
 	done_path_create(&new_path, new_dentry);
 out:
@@ -210,7 +212,8 @@ int __init init_symlink(const char *oldname, const char *newname)
 		return PTR_ERR(dentry);
 	error = security_path_symlink(&path, dentry, oldname);
 	if (!error)
-		error = vfs_symlink(&init_user_ns, path.dentry->d_inode, dentry, oldname);
+		error = vfs_symlink(mnt_user_ns(path.mnt), path.dentry->d_inode,
+				    dentry, oldname);
 	done_path_create(&path, dentry);
 	return error;
 }
@@ -233,7 +236,8 @@ int __init init_mkdir(const char *pathname, umode_t mode)
 		mode &= ~current_umask();
 	error = security_path_mkdir(&path, dentry, mode);
 	if (!error)
-		error = vfs_mkdir(&init_user_ns, path.dentry->d_inode, dentry, mode);
+		error = vfs_mkdir(mnt_user_ns(path.mnt), path.dentry->d_inode,
+				  dentry, mode);
 	done_path_create(&path, dentry);
 	return error;
 }
-- 
2.29.2

