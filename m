Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F09262FEF2F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Jan 2021 16:42:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731894AbhAUNVs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Jan 2021 08:21:48 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:53786 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731816AbhAUNVZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Jan 2021 08:21:25 -0500
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1l2Zt1-0005g7-TV; Thu, 21 Jan 2021 13:20:32 +0000
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
Subject: [PATCH v6 03/40] fs: add file and path permissions helpers
Date:   Thu, 21 Jan 2021 14:19:22 +0100
Message-Id: <20210121131959.646623-4-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210121131959.646623-1-christian.brauner@ubuntu.com>
References: <20210121131959.646623-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; i=EPGeccrW2ND6sEpUnqQWbJwVn6//nORjnK8IWU4CF0s=; m=jt/t+jriCkeKCD//7Jka1ydzn2GvYl+uifElu/w/ryk=; p=3/e8UsyR5VgYfXV6lXbZvOEZRVy3SJYhqT7zv3IWG78=; g=781dcf4cb525770f61fcb94f6f378ed86904f06c
X-Patch-Sig: m=pgp; i=christian.brauner@ubuntu.com; s=0x0x91C61BC06578DCA2; b=iHUEABYKAB0WIQRAhzRXHqcMeLMyaSiRxhvAZXjcogUCYAl9owAKCRCRxhvAZXjcom/7AP0aUrt 81FdUoZP/syHyN2DRxUz08P8UjRoZe1pjLq7DYgEAs/b6nrnXUBrctKKGN+rlnZHHSlNShp4uugis FcrYUwg=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add two simple helpers to check permissions on a file and path
respectively and convert over some callers. It simplifies quite a few
codepaths and also reduces the churn in later patches quite a bit.
Christoph also correctly points out that this makes codepaths (e.g.
ioctls) way easier to follow that would otherwise have to do more
complex argument passing than necessary.

Link: https://lore.kernel.org/r/20210112220124.837960-16-christian.brauner@ubuntu.com
Cc: David Howells <dhowells@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Suggested-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
patch not present

/* v3 */
patch not present

/* v4 */
patch not present

/* v5 */
patch not present

/* v6 */
base-commit: 19c329f6808995b142b3966301f217c831e7cf31

- Christoph Hellwig <hch@lst.de>:
  - Make file_user_ns() static inline.
  - Add file_permission() and path_permission() helpers.
---
 fs/init.c                          | 6 +++---
 fs/notify/fanotify/fanotify_user.c | 2 +-
 fs/notify/inotify/inotify_user.c   | 2 +-
 fs/open.c                          | 6 +++---
 fs/udf/file.c                      | 2 +-
 fs/verity/enable.c                 | 2 +-
 include/linux/fs.h                 | 8 ++++++++
 kernel/bpf/inode.c                 | 2 +-
 kernel/sys.c                       | 2 +-
 mm/madvise.c                       | 2 +-
 mm/memcontrol.c                    | 2 +-
 mm/mincore.c                       | 2 +-
 net/unix/af_unix.c                 | 2 +-
 13 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/fs/init.c b/fs/init.c
index e9c320a48cf1..02723bea8499 100644
--- a/fs/init.c
+++ b/fs/init.c
@@ -49,7 +49,7 @@ int __init init_chdir(const char *filename)
 	error = kern_path(filename, LOOKUP_FOLLOW | LOOKUP_DIRECTORY, &path);
 	if (error)
 		return error;
-	error = inode_permission(path.dentry->d_inode, MAY_EXEC | MAY_CHDIR);
+	error = path_permission(&path, MAY_EXEC | MAY_CHDIR);
 	if (!error)
 		set_fs_pwd(current->fs, &path);
 	path_put(&path);
@@ -64,7 +64,7 @@ int __init init_chroot(const char *filename)
 	error = kern_path(filename, LOOKUP_FOLLOW | LOOKUP_DIRECTORY, &path);
 	if (error)
 		return error;
-	error = inode_permission(path.dentry->d_inode, MAY_EXEC | MAY_CHDIR);
+	error = path_permission(&path, MAY_EXEC | MAY_CHDIR);
 	if (error)
 		goto dput_and_out;
 	error = -EPERM;
@@ -118,7 +118,7 @@ int __init init_eaccess(const char *filename)
 	error = kern_path(filename, LOOKUP_FOLLOW, &path);
 	if (error)
 		return error;
-	error = inode_permission(d_inode(path.dentry), MAY_ACCESS);
+	error = path_permission(&path, MAY_ACCESS);
 	path_put(&path);
 	return error;
 }
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index dcab112e1f00..64cfc1a3015d 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -702,7 +702,7 @@ static int fanotify_find_path(int dfd, const char __user *filename,
 	}
 
 	/* you can only watch an inode if you have read permissions on it */
-	ret = inode_permission(path->dentry->d_inode, MAY_READ);
+	ret = path_permission(path, MAY_READ);
 	if (ret) {
 		path_put(path);
 		goto out;
diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
index 59c177011a0f..e1155d32ef6f 100644
--- a/fs/notify/inotify/inotify_user.c
+++ b/fs/notify/inotify/inotify_user.c
@@ -352,7 +352,7 @@ static int inotify_find_inode(const char __user *dirname, struct path *path,
 	if (error)
 		return error;
 	/* you can only watch an inode if you have read permissions on it */
-	error = inode_permission(path->dentry->d_inode, MAY_READ);
+	error = path_permission(path, MAY_READ);
 	if (error) {
 		path_put(path);
 		return error;
diff --git a/fs/open.c b/fs/open.c
index 1e06e443a565..cd1efd254cad 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -492,7 +492,7 @@ SYSCALL_DEFINE1(chdir, const char __user *, filename)
 	if (error)
 		goto out;
 
-	error = inode_permission(path.dentry->d_inode, MAY_EXEC | MAY_CHDIR);
+	error = path_permission(&path, MAY_EXEC | MAY_CHDIR);
 	if (error)
 		goto dput_and_out;
 
@@ -521,7 +521,7 @@ SYSCALL_DEFINE1(fchdir, unsigned int, fd)
 	if (!d_can_lookup(f.file->f_path.dentry))
 		goto out_putf;
 
-	error = inode_permission(file_inode(f.file), MAY_EXEC | MAY_CHDIR);
+	error = file_permission(f.file, MAY_EXEC | MAY_CHDIR);
 	if (!error)
 		set_fs_pwd(current->fs, &f.file->f_path);
 out_putf:
@@ -540,7 +540,7 @@ SYSCALL_DEFINE1(chroot, const char __user *, filename)
 	if (error)
 		goto out;
 
-	error = inode_permission(path.dentry->d_inode, MAY_EXEC | MAY_CHDIR);
+	error = path_permission(&path, MAY_EXEC | MAY_CHDIR);
 	if (error)
 		goto dput_and_out;
 
diff --git a/fs/udf/file.c b/fs/udf/file.c
index ad8eefad27d7..3671a40ed3c3 100644
--- a/fs/udf/file.c
+++ b/fs/udf/file.c
@@ -183,7 +183,7 @@ long udf_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	long old_block, new_block;
 	int result;
 
-	if (inode_permission(inode, MAY_READ) != 0) {
+	if (file_permission(filp, MAY_READ) != 0) {
 		udf_debug("no permission to access inode %lu\n", inode->i_ino);
 		return -EPERM;
 	}
diff --git a/fs/verity/enable.c b/fs/verity/enable.c
index f7e997a01ad0..77e159a0346b 100644
--- a/fs/verity/enable.c
+++ b/fs/verity/enable.c
@@ -369,7 +369,7 @@ int fsverity_ioctl_enable(struct file *filp, const void __user *uarg)
 	 * has verity enabled, and to stabilize the data being hashed.
 	 */
 
-	err = inode_permission(inode, MAY_WRITE);
+	err = file_permission(filp, MAY_WRITE);
 	if (err)
 		return err;
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 3165998e2294..bcd17097d441 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2812,6 +2812,14 @@ static inline int bmap(struct inode *inode,  sector_t *block)
 extern int notify_change(struct dentry *, struct iattr *, struct inode **);
 extern int inode_permission(struct inode *, int);
 extern int generic_permission(struct inode *, int);
+static inline int file_permission(struct file *file, int mask)
+{
+	return inode_permission(file_inode(file), mask);
+}
+static inline int path_permission(const struct path *path, int mask)
+{
+	return inode_permission(d_inode(path->dentry), mask);
+}
 extern int __check_sticky(struct inode *dir, struct inode *inode);
 
 static inline bool execute_ok(struct inode *inode)
diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
index dd4b7fd60ee7..8962f139521e 100644
--- a/kernel/bpf/inode.c
+++ b/kernel/bpf/inode.c
@@ -507,7 +507,7 @@ static void *bpf_obj_do_get(const char __user *pathname,
 		return ERR_PTR(ret);
 
 	inode = d_backing_inode(path.dentry);
-	ret = inode_permission(inode, ACC_MODE(flags));
+	ret = path_permission(&path, ACC_MODE(flags));
 	if (ret)
 		goto out;
 
diff --git a/kernel/sys.c b/kernel/sys.c
index 51f00fe20e4d..138fb253b344 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -1848,7 +1848,7 @@ static int prctl_set_mm_exe_file(struct mm_struct *mm, unsigned int fd)
 	if (!S_ISREG(inode->i_mode) || path_noexec(&exe.file->f_path))
 		goto exit;
 
-	err = inode_permission(inode, MAY_EXEC);
+	err = file_permission(exe.file, MAY_EXEC);
 	if (err)
 		goto exit;
 
diff --git a/mm/madvise.c b/mm/madvise.c
index 6a660858784b..175c5582d8a9 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -540,7 +540,7 @@ static inline bool can_do_pageout(struct vm_area_struct *vma)
 	 * opens a side channel.
 	 */
 	return inode_owner_or_capable(file_inode(vma->vm_file)) ||
-		inode_permission(file_inode(vma->vm_file), MAY_WRITE) == 0;
+	       file_permission(vma->vm_file, MAY_WRITE) == 0;
 }
 
 static long madvise_pageout(struct vm_area_struct *vma,
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 605f671203ef..cf9076f58582 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4899,7 +4899,7 @@ static ssize_t memcg_write_event_control(struct kernfs_open_file *of,
 
 	/* the process need read permission on control file */
 	/* AV: shouldn't we check that it's been opened for read instead? */
-	ret = inode_permission(file_inode(cfile.file), MAY_READ);
+	ret = file_permission(cfile.file, MAY_READ);
 	if (ret < 0)
 		goto out_put_cfile;
 
diff --git a/mm/mincore.c b/mm/mincore.c
index 02db1a834021..7bdb4673f776 100644
--- a/mm/mincore.c
+++ b/mm/mincore.c
@@ -167,7 +167,7 @@ static inline bool can_do_mincore(struct vm_area_struct *vma)
 	 * mappings, which opens a side channel.
 	 */
 	return inode_owner_or_capable(file_inode(vma->vm_file)) ||
-		inode_permission(file_inode(vma->vm_file), MAY_WRITE) == 0;
+	       file_permission(vma->vm_file, MAY_WRITE) == 0;
 }
 
 static const struct mm_walk_ops mincore_walk_ops = {
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 41c3303c3357..18453d15dddf 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -936,7 +936,7 @@ static struct sock *unix_find_other(struct net *net,
 		if (err)
 			goto fail;
 		inode = d_backing_inode(path.dentry);
-		err = inode_permission(inode, MAY_WRITE);
+		err = path_permission(&path, MAY_WRITE);
 		if (err)
 			goto put_fail;
 
-- 
2.30.0

