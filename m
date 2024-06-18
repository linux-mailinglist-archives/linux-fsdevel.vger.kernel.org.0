Return-Path: <linux-fsdevel+bounces-21879-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF9A190CFF6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jun 2024 15:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77DCAB243DA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jun 2024 13:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93F611607BC;
	Tue, 18 Jun 2024 12:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MbToklhY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E2B13DDCA;
	Tue, 18 Jun 2024 12:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718715103; cv=none; b=aDFfFGnfJU4EzQUEMMMNBcMQEa+179XZnWJ5VsA9YBU/d8MJAZR29lhvo7mwkAI2WVrGkn7Ys/ufV+KKm/C5p8+7X/fLjN0DuT0jBJC1K7hbGiPiDWqLYL22qdDsDHLHFNowZLi2g+j2BROwSTMTApVmLH59EEctRuAidYPHwIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718715103; c=relaxed/simple;
	bh=bWWHOOolzcldV+ZcDBIhIGp1QXXq76b8XqurYqP1laU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UJXYWqz8YbrbT173z+cCSE98bYSBBIU3evEwYFzE9k6vAi3CLIWxtfDdY+VTmD43otknfqz1rMP4cHshmZqgEQUUZWeuvDG95DKOMYrJU0MASW8WOUgmZ7xv7TFNd++91Z2YAU/biwmZrA7u90GmfXubg31MSIKqHsUtbF5SAkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MbToklhY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77E85C3277B;
	Tue, 18 Jun 2024 12:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718715102;
	bh=bWWHOOolzcldV+ZcDBIhIGp1QXXq76b8XqurYqP1laU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MbToklhYotKIUBAYwfCecX24GA4H3e3Jgl5zyzbHswr3lQOsrn7UVSqLerusC0NMI
	 wlF479qMdd47G2WWuG/B0trVYgrQMNlhN8glLA2hc3QP+F0awnNQ8QY11h9CWU+qPU
	 mVNcUb+m0l9alrVpKONWqV605B1ejpKI6B1joOfE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Howells <dhowells@redhat.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	James Morris <jamorris@linux.microsoft.com>,
	Christian Brauner <christian.brauner@ubuntu.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 195/770] fs: add file and path permissions helpers
Date: Tue, 18 Jun 2024 14:30:48 +0200
Message-ID: <20240618123414.802969388@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240618123407.280171066@linuxfoundation.org>
References: <20240618123407.280171066@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christian Brauner <christian.brauner@ubuntu.com>

[ Upstream commit 02f92b3868a1b34ab98464e76b0e4e060474ba10 ]

Add two simple helpers to check permissions on a file and path
respectively and convert over some callers. It simplifies quite a few
codepaths and also reduces the churn in later patches quite a bit.
Christoph also correctly points out that this makes codepaths (e.g.
ioctls) way easier to follow that would otherwise have to do more
complex argument passing than necessary.

Link: https://lore.kernel.org/r/20210121131959.646623-4-christian.brauner@ubuntu.com
Cc: David Howells <dhowells@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Suggested-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: James Morris <jamorris@linux.microsoft.com>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
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
index e9c320a48cf15..02723bea84990 100644
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
index 3e905b2e1b9c3..829ead2792dfb 100644
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
index ad8fb4bca6dc1..82fc0cf86a7c3 100644
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
index 48933cbb75391..9f56ebacfbefe 100644
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
index e283a62701b83..25f7c915f22b7 100644
--- a/fs/udf/file.c
+++ b/fs/udf/file.c
@@ -181,7 +181,7 @@ long udf_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	long old_block, new_block;
 	int result;
 
-	if (inode_permission(inode, MAY_READ) != 0) {
+	if (file_permission(filp, MAY_READ) != 0) {
 		udf_debug("no permission to access inode %lu\n", inode->i_ino);
 		return -EPERM;
 	}
diff --git a/fs/verity/enable.c b/fs/verity/enable.c
index 5ceae66e1ae02..29becb66d0d88 100644
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
index 6de70634e5471..0974e8160f50c 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2824,6 +2824,14 @@ static inline int bmap(struct inode *inode,  sector_t *block)
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
index 6b14b4c4068cc..5966013bc788b 100644
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
index efc213ae4c5ad..7a2cfb57fa9e7 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -1873,7 +1873,7 @@ static int prctl_set_mm_exe_file(struct mm_struct *mm, unsigned int fd)
 	if (!S_ISREG(inode->i_mode) || path_noexec(&exe.file->f_path))
 		goto exit;
 
-	err = inode_permission(inode, MAY_EXEC);
+	err = file_permission(exe.file, MAY_EXEC);
 	if (err)
 		goto exit;
 
diff --git a/mm/madvise.c b/mm/madvise.c
index f71fc88f0b331..a63aa04ec7fa3 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -543,7 +543,7 @@ static inline bool can_do_pageout(struct vm_area_struct *vma)
 	 * opens a side channel.
 	 */
 	return inode_owner_or_capable(file_inode(vma->vm_file)) ||
-		inode_permission(file_inode(vma->vm_file), MAY_WRITE) == 0;
+	       file_permission(vma->vm_file, MAY_WRITE) == 0;
 }
 
 static long madvise_pageout(struct vm_area_struct *vma,
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index ddc8ed096deca..186ae9dba0fd5 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4918,7 +4918,7 @@ static ssize_t memcg_write_event_control(struct kernfs_open_file *of,
 
 	/* the process need read permission on control file */
 	/* AV: shouldn't we check that it's been opened for read instead? */
-	ret = inode_permission(file_inode(cfile.file), MAY_READ);
+	ret = file_permission(cfile.file, MAY_READ);
 	if (ret < 0)
 		goto out_put_cfile;
 
diff --git a/mm/mincore.c b/mm/mincore.c
index 02db1a834021b..7bdb4673f776a 100644
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
index 3ab726a668e8a..405bf3e6eb796 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -959,7 +959,7 @@ static struct sock *unix_find_other(struct net *net,
 		if (err)
 			goto fail;
 		inode = d_backing_inode(path.dentry);
-		err = inode_permission(inode, MAY_WRITE);
+		err = path_permission(&path, MAY_WRITE);
 		if (err)
 			goto put_fail;
 
-- 
2.43.0




