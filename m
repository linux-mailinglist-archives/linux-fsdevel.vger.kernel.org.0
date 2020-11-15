Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFAC62B3449
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Nov 2020 11:49:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbgKOKss (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 15 Nov 2020 05:48:48 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:59901 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726808AbgKOKsj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 15 Nov 2020 05:48:39 -0500
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1keFRC-0000Kt-3n; Sun, 15 Nov 2020 10:39:14 +0000
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
        linux-ext4@vger.kernel.org, linux-audit@redhat.com,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 20/39] open: handle idmapped mounts
Date:   Sun, 15 Nov 2020 11:36:59 +0100
Message-Id: <20201115103718.298186-21-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201115103718.298186-1-christian.brauner@ubuntu.com>
References: <20201115103718.298186-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

For core file operations such as changing directories or chrooting,
determining file access, changing mode or ownership the vfs will verify
that the caller is privileged over the inode. Extend the various helpers to
handle idmapped mounts. If the inode is accessed through an idmapped mount
it is mapped according to the mount's user namespace.  Afterwards the
permissions checks are identical to non-idmapped mounts.  When changing
file ownership we need to map the mount from the mount's user namespace. If
the initial user namespace is passed all mapping operations are a nop so
non-idmapped mounts will not see a change in behavior and will also not see
any performance impact.

Cc: Christoph Hellwig <hch@lst.de>
Cc: David Howells <dhowells@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
unchanged
---
 fs/open.c | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/fs/open.c b/fs/open.c
index 137dcc52d2f8..2e2eb55976b1 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -401,6 +401,7 @@ static const struct cred *access_override_creds(void)
 
 static long do_faccessat(int dfd, const char __user *filename, int mode, int flags)
 {
+	struct user_namespace *user_ns;
 	struct path path;
 	struct inode *inode;
 	int res;
@@ -441,7 +442,8 @@ static long do_faccessat(int dfd, const char __user *filename, int mode, int fla
 			goto out_path_release;
 	}
 
-	res = inode_permission(&init_user_ns, inode, mode | MAY_ACCESS);
+	user_ns = mnt_user_ns(path.mnt);
+	res = inode_permission(user_ns, inode, mode | MAY_ACCESS);
 	/* SuS v2 requires we report a read only fs too */
 	if (res || !(mode & S_IWOTH) || special_file(inode->i_mode))
 		goto out_path_release;
@@ -489,6 +491,7 @@ SYSCALL_DEFINE2(access, const char __user *, filename, int, mode)
 
 SYSCALL_DEFINE1(chdir, const char __user *, filename)
 {
+	struct user_namespace *user_ns;
 	struct path path;
 	int error;
 	unsigned int lookup_flags = LOOKUP_FOLLOW | LOOKUP_DIRECTORY;
@@ -497,7 +500,8 @@ SYSCALL_DEFINE1(chdir, const char __user *, filename)
 	if (error)
 		goto out;
 
-	error = inode_permission(&init_user_ns, path.dentry->d_inode, MAY_EXEC | MAY_CHDIR);
+	user_ns = mnt_user_ns(path.mnt);
+	error = inode_permission(user_ns, path.dentry->d_inode, MAY_EXEC | MAY_CHDIR);
 	if (error)
 		goto dput_and_out;
 
@@ -515,6 +519,7 @@ SYSCALL_DEFINE1(chdir, const char __user *, filename)
 
 SYSCALL_DEFINE1(fchdir, unsigned int, fd)
 {
+	struct user_namespace *user_ns;
 	struct fd f = fdget_raw(fd);
 	int error;
 
@@ -526,7 +531,8 @@ SYSCALL_DEFINE1(fchdir, unsigned int, fd)
 	if (!d_can_lookup(f.file->f_path.dentry))
 		goto out_putf;
 
-	error = inode_permission(&init_user_ns, file_inode(f.file), MAY_EXEC | MAY_CHDIR);
+	user_ns = mnt_user_ns(f.file->f_path.mnt);
+	error = inode_permission(user_ns, file_inode(f.file), MAY_EXEC | MAY_CHDIR);
 	if (!error)
 		set_fs_pwd(current->fs, &f.file->f_path);
 out_putf:
@@ -537,6 +543,7 @@ SYSCALL_DEFINE1(fchdir, unsigned int, fd)
 
 SYSCALL_DEFINE1(chroot, const char __user *, filename)
 {
+	struct user_namespace *user_ns;
 	struct path path;
 	int error;
 	unsigned int lookup_flags = LOOKUP_FOLLOW | LOOKUP_DIRECTORY;
@@ -545,7 +552,8 @@ SYSCALL_DEFINE1(chroot, const char __user *, filename)
 	if (error)
 		goto out;
 
-	error = inode_permission(&init_user_ns, path.dentry->d_inode, MAY_EXEC | MAY_CHDIR);
+	user_ns = mnt_user_ns(path.mnt);
+	error = inode_permission(user_ns, path.dentry->d_inode, MAY_EXEC | MAY_CHDIR);
 	if (error)
 		goto dput_and_out;
 
@@ -570,6 +578,7 @@ SYSCALL_DEFINE1(chroot, const char __user *, filename)
 
 int chmod_common(const struct path *path, umode_t mode)
 {
+	struct user_namespace *user_ns;
 	struct inode *inode = path->dentry->d_inode;
 	struct inode *delegated_inode = NULL;
 	struct iattr newattrs;
@@ -585,7 +594,8 @@ int chmod_common(const struct path *path, umode_t mode)
 		goto out_unlock;
 	newattrs.ia_mode = (mode & S_IALLUGO) | (inode->i_mode & ~S_IALLUGO);
 	newattrs.ia_valid = ATTR_MODE | ATTR_CTIME;
-	error = notify_change(&init_user_ns, path->dentry, &newattrs, &delegated_inode);
+	user_ns = mnt_user_ns(path->mnt);
+	error = notify_change(user_ns, path->dentry, &newattrs, &delegated_inode);
 out_unlock:
 	inode_unlock(inode);
 	if (delegated_inode) {
@@ -646,6 +656,7 @@ SYSCALL_DEFINE2(chmod, const char __user *, filename, umode_t, mode)
 
 int chown_common(const struct path *path, uid_t user, gid_t group)
 {
+	struct user_namespace *user_ns;
 	struct inode *inode = path->dentry->d_inode;
 	struct inode *delegated_inode = NULL;
 	int error;
@@ -656,6 +667,12 @@ int chown_common(const struct path *path, uid_t user, gid_t group)
 	uid = make_kuid(current_user_ns(), user);
 	gid = make_kgid(current_user_ns(), group);
 
+	user_ns = mnt_user_ns(path->mnt);
+	if (mnt_idmapped(path->mnt)) {
+		uid = kuid_from_mnt(user_ns, uid);
+		gid = kgid_from_mnt(user_ns, gid);
+	}
+
 retry_deleg:
 	newattrs.ia_valid =  ATTR_CTIME;
 	if (user != (uid_t) -1) {
@@ -676,7 +693,7 @@ int chown_common(const struct path *path, uid_t user, gid_t group)
 	inode_lock(inode);
 	error = security_path_chown(path, uid, gid);
 	if (!error)
-		error = notify_change(&init_user_ns, path->dentry, &newattrs, &delegated_inode);
+		error = notify_change(user_ns, path->dentry, &newattrs, &delegated_inode);
 	inode_unlock(inode);
 	if (delegated_inode) {
 		error = break_deleg_wait(&delegated_inode);
@@ -1133,7 +1150,7 @@ struct file *filp_open(const char *filename, int flags, umode_t mode)
 {
 	struct filename *name = getname_kernel(filename);
 	struct file *file = ERR_CAST(name);
-	
+
 	if (!IS_ERR(name)) {
 		file = file_open_name(name, flags, mode);
 		putname(name);
-- 
2.29.2

