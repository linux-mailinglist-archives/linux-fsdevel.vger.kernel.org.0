Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 490472FEEC3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Jan 2021 16:30:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732912AbhAUPaA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Jan 2021 10:30:00 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:54068 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730048AbhAUNWN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Jan 2021 08:22:13 -0500
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1l2Ztp-0005g7-Iy; Thu, 21 Jan 2021 13:21:21 +0000
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
Subject: [PATCH v6 15/40] open: handle idmapped mounts in do_truncate()
Date:   Thu, 21 Jan 2021 14:19:34 +0100
Message-Id: <20210121131959.646623-16-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210121131959.646623-1-christian.brauner@ubuntu.com>
References: <20210121131959.646623-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; i=luWr+VA/K8XJzgT4gX4nqMzEuQJylBRV32CcnmZlQJ8=; m=XJu4Sx96Qgw5F+dLWfwKUfgcuJm55dwwUprxzq2rY3M=; p=RlnmoKapstAZLJe1gLcqaUTCPfjFgeMKYnLu+MXn0JY=; g=dc5ad43796544c09b03298270d4c6bfc5aba8333
X-Patch-Sig: m=pgp; i=christian.brauner@ubuntu.com; s=0x0x91C61BC06578DCA2; b=iHUEABYKAB0WIQRAhzRXHqcMeLMyaSiRxhvAZXjcogUCYAl9pAAKCRCRxhvAZXjcorJkAP9a62J J2k8eV2GeBOzU+3th+V7gqNipGLUMyUlEa/9OrQD/QqERsALVXZ/lkmI6jvBjiJeBhmRMd7zToPe2 VZ19nAc=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When truncating files the vfs will verify that the caller is privileged
over the inode. Extend it to handle idmapped mounts. If the inode is
accessed through an idmapped mount it is mapped according to the mount's
user namespace. Afterwards the permissions checks are identical to
non-idmapped mounts. If the initial user namespace is passed nothing
changes so non-idmapped mounts will see identical behavior as before.

Link: https://lore.kernel.org/r/20210112220124.837960-23-christian.brauner@ubuntu.com
Cc: Christoph Hellwig <hch@lst.de>
Cc: David Howells <dhowells@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
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
base-commit: 7c53f6b671f4aba70ff15e1b05148b10d58c2837

- Christoph Hellwig <hch@lst.de>:
  - Use new file_mnt_user_ns() helper.

/* v6 */
base-commit: 19c329f6808995b142b3966301f217c831e7cf31

- Christoph Hellwig <hch@lst.de>:
  - Remove local mnt_userns variable in favor of calling
    file_mnt_user_ns() directly.
---
 fs/coredump.c      | 10 +++++++---
 fs/inode.c         |  7 ++++---
 fs/namei.c         |  2 +-
 fs/open.c          | 16 +++++++++-------
 include/linux/fs.h |  4 ++--
 5 files changed, 23 insertions(+), 16 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index a2f6ecc8e345..ae778937a1ff 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -703,6 +703,7 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 			goto close_fail;
 		}
 	} else {
+		struct user_namespace *mnt_userns;
 		struct inode *inode;
 		int open_flags = O_CREAT | O_RDWR | O_NOFOLLOW |
 				 O_LARGEFILE | O_EXCL;
@@ -780,13 +781,15 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 		 * a process dumps core while its cwd is e.g. on a vfat
 		 * filesystem.
 		 */
-		if (!uid_eq(inode->i_uid, current_fsuid()))
+		mnt_userns = file_mnt_user_ns(cprm.file);
+		if (!uid_eq(i_uid_into_mnt(mnt_userns, inode), current_fsuid()))
 			goto close_fail;
 		if ((inode->i_mode & 0677) != 0600)
 			goto close_fail;
 		if (!(cprm.file->f_mode & FMODE_CAN_WRITE))
 			goto close_fail;
-		if (do_truncate(cprm.file->f_path.dentry, 0, 0, cprm.file))
+		if (do_truncate(mnt_userns, cprm.file->f_path.dentry,
+				0, 0, cprm.file))
 			goto close_fail;
 	}
 
@@ -931,7 +934,8 @@ void dump_truncate(struct coredump_params *cprm)
 	if (file->f_op->llseek && file->f_op->llseek != no_llseek) {
 		offset = file->f_op->llseek(file, 0, SEEK_CUR);
 		if (i_size_read(file->f_mapping->host) < offset)
-			do_truncate(file->f_path.dentry, offset, 0, file);
+			do_truncate(file_mnt_user_ns(file), file->f_path.dentry,
+				    offset, 0, file);
 	}
 }
 EXPORT_SYMBOL(dump_truncate);
diff --git a/fs/inode.c b/fs/inode.c
index 46116ef44c9f..08151968c9ef 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1903,7 +1903,8 @@ int dentry_needs_remove_privs(struct dentry *dentry)
 	return mask;
 }
 
-static int __remove_privs(struct dentry *dentry, int kill)
+static int __remove_privs(struct user_namespace *mnt_userns,
+			  struct dentry *dentry, int kill)
 {
 	struct iattr newattrs;
 
@@ -1912,7 +1913,7 @@ static int __remove_privs(struct dentry *dentry, int kill)
 	 * Note we call this on write, so notify_change will not
 	 * encounter any conflicting delegations:
 	 */
-	return notify_change(&init_user_ns, dentry, &newattrs, NULL);
+	return notify_change(mnt_userns, dentry, &newattrs, NULL);
 }
 
 /*
@@ -1939,7 +1940,7 @@ int file_remove_privs(struct file *file)
 	if (kill < 0)
 		return kill;
 	if (kill)
-		error = __remove_privs(dentry, kill);
+		error = __remove_privs(file_mnt_user_ns(file), dentry, kill);
 	if (!error)
 		inode_has_no_xattr(inode);
 
diff --git a/fs/namei.c b/fs/namei.c
index 5c9f6f8e90c4..c8c083daf368 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3009,7 +3009,7 @@ static int handle_truncate(struct file *filp)
 	if (!error)
 		error = security_path_truncate(path);
 	if (!error) {
-		error = do_truncate(path->dentry, 0,
+		error = do_truncate(&init_user_ns, path->dentry, 0,
 				    ATTR_MTIME|ATTR_CTIME|ATTR_OPEN,
 				    filp);
 	}
diff --git a/fs/open.c b/fs/open.c
index c3e4dc43dd8d..8b3f3eb652d0 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -35,8 +35,8 @@
 
 #include "internal.h"
 
-int do_truncate(struct dentry *dentry, loff_t length, unsigned int time_attrs,
-	struct file *filp)
+int do_truncate(struct user_namespace *mnt_userns, struct dentry *dentry,
+		loff_t length, unsigned int time_attrs, struct file *filp)
 {
 	int ret;
 	struct iattr newattrs;
@@ -61,13 +61,14 @@ int do_truncate(struct dentry *dentry, loff_t length, unsigned int time_attrs,
 
 	inode_lock(dentry->d_inode);
 	/* Note any delegations or leases have already been broken: */
-	ret = notify_change(&init_user_ns, dentry, &newattrs, NULL);
+	ret = notify_change(mnt_userns, dentry, &newattrs, NULL);
 	inode_unlock(dentry->d_inode);
 	return ret;
 }
 
 long vfs_truncate(const struct path *path, loff_t length)
 {
+	struct user_namespace *mnt_userns;
 	struct inode *inode;
 	long error;
 
@@ -83,7 +84,8 @@ long vfs_truncate(const struct path *path, loff_t length)
 	if (error)
 		goto out;
 
-	error = inode_permission(&init_user_ns, inode, MAY_WRITE);
+	mnt_userns = mnt_user_ns(path->mnt);
+	error = inode_permission(mnt_userns, inode, MAY_WRITE);
 	if (error)
 		goto mnt_drop_write_and_out;
 
@@ -107,7 +109,7 @@ long vfs_truncate(const struct path *path, loff_t length)
 	if (!error)
 		error = security_path_truncate(path);
 	if (!error)
-		error = do_truncate(path->dentry, length, 0, NULL);
+		error = do_truncate(mnt_userns, path->dentry, length, 0, NULL);
 
 put_write_and_out:
 	put_write_access(inode);
@@ -186,13 +188,13 @@ long do_sys_ftruncate(unsigned int fd, loff_t length, int small)
 	/* Check IS_APPEND on real upper inode */
 	if (IS_APPEND(file_inode(f.file)))
 		goto out_putf;
-
 	sb_start_write(inode->i_sb);
 	error = locks_verify_truncate(inode, f.file, length);
 	if (!error)
 		error = security_path_truncate(&f.file->f_path);
 	if (!error)
-		error = do_truncate(dentry, length, ATTR_MTIME|ATTR_CTIME, f.file);
+		error = do_truncate(file_mnt_user_ns(f.file), dentry, length,
+				    ATTR_MTIME | ATTR_CTIME, f.file);
 	sb_end_write(inode->i_sb);
 out_putf:
 	fdput(f);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 29d7b2fe7de4..f0601cca1930 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2593,8 +2593,8 @@ static inline struct user_namespace *file_mnt_user_ns(struct file *file)
 	return mnt_user_ns(file->f_path.mnt);
 }
 extern long vfs_truncate(const struct path *, loff_t);
-extern int do_truncate(struct dentry *, loff_t start, unsigned int time_attrs,
-		       struct file *filp);
+int do_truncate(struct user_namespace *, struct dentry *, loff_t start,
+		unsigned int time_attrs, struct file *filp);
 extern int vfs_fallocate(struct file *file, int mode, loff_t offset,
 			loff_t len);
 extern long do_sys_open(int dfd, const char __user *filename, int flags,
-- 
2.30.0

