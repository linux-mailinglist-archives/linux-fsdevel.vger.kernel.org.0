Return-Path: <linux-fsdevel+bounces-33520-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B23C59B9CF8
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Nov 2024 06:10:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A3C42834D0
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Nov 2024 05:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7847C1741EF;
	Sat,  2 Nov 2024 05:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="pPnJ68MB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE191494B3;
	Sat,  2 Nov 2024 05:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730524113; cv=none; b=C07iYIWdM/nmzmVpJ3/IinxBJz4QN7ujhLbVMcV4X9rGtRRrK31q9n30ZNwYlIP87x0WbtSnpUBwJJCt2XUPbc/C1piQukDgphyP+e6CMQz2VTsFkwuswwo0fYfewGcouC8EBiDetXhJ57PfWfds2KIOLc0ghUWLIckz4M3VHLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730524113; c=relaxed/simple;
	bh=EmbvT3uAOfRII6Lvv05CU/5uvZYQlhmRDCwDUkoah90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RCymH1w1MINEP/hJfScCEaACoJT1/43QcriLgjY8Pu0bh5TGIwQ7c25jpcINLU/LrmlYR6JHoxh99w1Ia/uQPKFb9Dv3CVZ5xOcgxNgwNsZsZJl8R6sEYNgLfRnQ95qqABA1R2T1uhKMEWoSdtnMEBeXIeG0ee1kKtRDTaozQuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=pPnJ68MB; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=amYRDIBlBRtWKscFW9TmYZ4wtPen0u+Qevr3ZHblcco=; b=pPnJ68MBQUxgcWdEgfYN54mvRr
	X72DAGxL4eu1kVHkb3rvxMdxd1RRBrqOycT1Ck2xamrqsckC3kq+mxjXBNIHxwR72mGtElarjc7Dy
	pIBeG2j5/PXC240sRrdRGcxvx7P+sB1F3Ar32xfJFLWQgupq2P0POOZMSE43MBhajbBUI4KL0Nxba
	VSGl3KTCqw9CEUm9Px2WOIvd5OAI4BM7ox0TpvExzd1KVk0qa6sIdN806HSoYofF1aASS7qPkhDMN
	ZLL+0z8/RP7uhoGHiOTz+UZjXMmtEY7TZM8mwj08j2SkrbM/JjFgU25rO3uz05UZHezjkFetzYYvD
	poEBSgVA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t76NA-0000000AHma-1mhy;
	Sat, 02 Nov 2024 05:08:28 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	cgroups@vger.kernel.org,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	torvalds@linux-foundation.org
Subject: [PATCH v3 10/28] fdget_raw() users: switch to CLASS(fd_raw)
Date: Sat,  2 Nov 2024 05:08:08 +0000
Message-ID: <20241102050827.2451599-10-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241102050827.2451599-1-viro@zeniv.linux.org.uk>
References: <20241102050219.GA2450028@ZenIV>
 <20241102050827.2451599-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/arm/kernel/sys_oabi-compat.c | 10 +++-----
 fs/fcntl.c                        | 42 +++++++++++++------------------
 fs/namei.c                        | 13 +++-------
 fs/open.c                         | 13 +++-------
 fs/quota/quota.c                  | 12 +++------
 fs/statfs.c                       | 12 ++++-----
 kernel/cgroup/cgroup.c            |  9 +++----
 security/landlock/syscalls.c      | 19 +++++---------
 8 files changed, 47 insertions(+), 83 deletions(-)

diff --git a/arch/arm/kernel/sys_oabi-compat.c b/arch/arm/kernel/sys_oabi-compat.c
index f5781ff54a5c..2944721e82a2 100644
--- a/arch/arm/kernel/sys_oabi-compat.c
+++ b/arch/arm/kernel/sys_oabi-compat.c
@@ -235,12 +235,12 @@ asmlinkage long sys_oabi_fcntl64(unsigned int fd, unsigned int cmd,
 				 unsigned long arg)
 {
 	void __user *argp = (void __user *)arg;
-	struct fd f = fdget_raw(fd);
+	CLASS(fd_raw, f)(fd);
 	struct flock64 flock;
-	long err = -EBADF;
+	long err;
 
-	if (!fd_file(f))
-		goto out;
+	if (fd_empty(f))
+		return -EBADF;
 
 	switch (cmd) {
 	case F_GETLK64:
@@ -271,8 +271,6 @@ asmlinkage long sys_oabi_fcntl64(unsigned int fd, unsigned int cmd,
 		err = sys_fcntl64(fd, cmd, arg);
 		break;
 	}
-	fdput(f);
-out:
 	return err;
 }
 
diff --git a/fs/fcntl.c b/fs/fcntl.c
index 22dd9dcce7ec..bd022a54bd0d 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -570,24 +570,21 @@ static int check_fcntl_cmd(unsigned cmd)
 
 SYSCALL_DEFINE3(fcntl, unsigned int, fd, unsigned int, cmd, unsigned long, arg)
 {	
-	struct fd f = fdget_raw(fd);
-	long err = -EBADF;
+	CLASS(fd_raw, f)(fd);
+	long err;
 
-	if (!fd_file(f))
-		goto out;
+	if (fd_empty(f))
+		return -EBADF;
 
 	if (unlikely(fd_file(f)->f_mode & FMODE_PATH)) {
 		if (!check_fcntl_cmd(cmd))
-			goto out1;
+			return -EBADF;
 	}
 
 	err = security_file_fcntl(fd_file(f), cmd, arg);
 	if (!err)
 		err = do_fcntl(fd, cmd, arg, fd_file(f));
 
-out1:
- 	fdput(f);
-out:
 	return err;
 }
 
@@ -596,21 +593,21 @@ SYSCALL_DEFINE3(fcntl64, unsigned int, fd, unsigned int, cmd,
 		unsigned long, arg)
 {	
 	void __user *argp = (void __user *)arg;
-	struct fd f = fdget_raw(fd);
+	CLASS(fd_raw, f)(fd);
 	struct flock64 flock;
-	long err = -EBADF;
+	long err;
 
-	if (!fd_file(f))
-		goto out;
+	if (fd_empty(f))
+		return -EBADF;
 
 	if (unlikely(fd_file(f)->f_mode & FMODE_PATH)) {
 		if (!check_fcntl_cmd(cmd))
-			goto out1;
+			return -EBADF;
 	}
 
 	err = security_file_fcntl(fd_file(f), cmd, arg);
 	if (err)
-		goto out1;
+		return err;
 	
 	switch (cmd) {
 	case F_GETLK64:
@@ -635,9 +632,6 @@ SYSCALL_DEFINE3(fcntl64, unsigned int, fd, unsigned int, cmd,
 		err = do_fcntl(fd, cmd, arg, fd_file(f));
 		break;
 	}
-out1:
-	fdput(f);
-out:
 	return err;
 }
 #endif
@@ -733,21 +727,21 @@ static int fixup_compat_flock(struct flock *flock)
 static long do_compat_fcntl64(unsigned int fd, unsigned int cmd,
 			     compat_ulong_t arg)
 {
-	struct fd f = fdget_raw(fd);
+	CLASS(fd_raw, f)(fd);
 	struct flock flock;
-	long err = -EBADF;
+	long err;
 
-	if (!fd_file(f))
-		return err;
+	if (fd_empty(f))
+		return -EBADF;
 
 	if (unlikely(fd_file(f)->f_mode & FMODE_PATH)) {
 		if (!check_fcntl_cmd(cmd))
-			goto out_put;
+			return -EBADF;
 	}
 
 	err = security_file_fcntl(fd_file(f), cmd, arg);
 	if (err)
-		goto out_put;
+		return err;
 
 	switch (cmd) {
 	case F_GETLK:
@@ -790,8 +784,6 @@ static long do_compat_fcntl64(unsigned int fd, unsigned int cmd,
 		err = do_fcntl(fd, cmd, arg, fd_file(f));
 		break;
 	}
-out_put:
-	fdput(f);
 	return err;
 }
 
diff --git a/fs/namei.c b/fs/namei.c
index 4a4a22a08ac2..f0db1e724262 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2503,26 +2503,22 @@ static const char *path_init(struct nameidata *nd, unsigned flags)
 		}
 	} else {
 		/* Caller must check execute permissions on the starting path component */
-		struct fd f = fdget_raw(nd->dfd);
+		CLASS(fd_raw, f)(nd->dfd);
 		struct dentry *dentry;
 
-		if (!fd_file(f))
+		if (fd_empty(f))
 			return ERR_PTR(-EBADF);
 
 		if (flags & LOOKUP_LINKAT_EMPTY) {
 			if (fd_file(f)->f_cred != current_cred() &&
-			    !ns_capable(fd_file(f)->f_cred->user_ns, CAP_DAC_READ_SEARCH)) {
-				fdput(f);
+			    !ns_capable(fd_file(f)->f_cred->user_ns, CAP_DAC_READ_SEARCH))
 				return ERR_PTR(-ENOENT);
-			}
 		}
 
 		dentry = fd_file(f)->f_path.dentry;
 
-		if (*s && unlikely(!d_can_lookup(dentry))) {
-			fdput(f);
+		if (*s && unlikely(!d_can_lookup(dentry)))
 			return ERR_PTR(-ENOTDIR);
-		}
 
 		nd->path = fd_file(f)->f_path;
 		if (flags & LOOKUP_RCU) {
@@ -2532,7 +2528,6 @@ static const char *path_init(struct nameidata *nd, unsigned flags)
 			path_get(&nd->path);
 			nd->inode = nd->path.dentry->d_inode;
 		}
-		fdput(f);
 	}
 
 	/* For scoped-lookups we need to set the root to the dirfd as well. */
diff --git a/fs/open.c b/fs/open.c
index acaeb3e25c88..a0c1fa3f60d5 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -580,23 +580,18 @@ SYSCALL_DEFINE1(chdir, const char __user *, filename)
 
 SYSCALL_DEFINE1(fchdir, unsigned int, fd)
 {
-	struct fd f = fdget_raw(fd);
+	CLASS(fd_raw, f)(fd);
 	int error;
 
-	error = -EBADF;
-	if (!fd_file(f))
-		goto out;
+	if (fd_empty(f))
+		return -EBADF;
 
-	error = -ENOTDIR;
 	if (!d_can_lookup(fd_file(f)->f_path.dentry))
-		goto out_putf;
+		return -ENOTDIR;
 
 	error = file_permission(fd_file(f), MAY_EXEC | MAY_CHDIR);
 	if (!error)
 		set_fs_pwd(current->fs, &fd_file(f)->f_path);
-out_putf:
-	fdput(f);
-out:
 	return error;
 }
 
diff --git a/fs/quota/quota.c b/fs/quota/quota.c
index 290157bc7bec..7c2b75a44485 100644
--- a/fs/quota/quota.c
+++ b/fs/quota/quota.c
@@ -976,21 +976,19 @@ SYSCALL_DEFINE4(quotactl_fd, unsigned int, fd, unsigned int, cmd,
 	struct super_block *sb;
 	unsigned int cmds = cmd >> SUBCMDSHIFT;
 	unsigned int type = cmd & SUBCMDMASK;
-	struct fd f;
+	CLASS(fd_raw, f)(fd);
 	int ret;
 
-	f = fdget_raw(fd);
-	if (!fd_file(f))
+	if (fd_empty(f))
 		return -EBADF;
 
-	ret = -EINVAL;
 	if (type >= MAXQUOTAS)
-		goto out;
+		return -EINVAL;
 
 	if (quotactl_cmd_write(cmds)) {
 		ret = mnt_want_write(fd_file(f)->f_path.mnt);
 		if (ret)
-			goto out;
+			return ret;
 	}
 
 	sb = fd_file(f)->f_path.mnt->mnt_sb;
@@ -1008,7 +1006,5 @@ SYSCALL_DEFINE4(quotactl_fd, unsigned int, fd, unsigned int, cmd,
 
 	if (quotactl_cmd_write(cmds))
 		mnt_drop_write(fd_file(f)->f_path.mnt);
-out:
-	fdput(f);
 	return ret;
 }
diff --git a/fs/statfs.c b/fs/statfs.c
index 9c7bb27e7932..a45ac85e6048 100644
--- a/fs/statfs.c
+++ b/fs/statfs.c
@@ -114,13 +114,11 @@ int user_statfs(const char __user *pathname, struct kstatfs *st)
 
 int fd_statfs(int fd, struct kstatfs *st)
 {
-	struct fd f = fdget_raw(fd);
-	int error = -EBADF;
-	if (fd_file(f)) {
-		error = vfs_statfs(&fd_file(f)->f_path, st);
-		fdput(f);
-	}
-	return error;
+	CLASS(fd_raw, f)(fd);
+
+	if (fd_empty(f))
+		return -EBADF;
+	return vfs_statfs(&fd_file(f)->f_path, st);
 }
 
 static int do_statfs_native(struct kstatfs *st, struct statfs __user *p)
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 5886b95c6eae..8305a67ea8d9 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -6966,14 +6966,11 @@ EXPORT_SYMBOL_GPL(cgroup_get_from_path);
  */
 struct cgroup *cgroup_v1v2_get_from_fd(int fd)
 {
-	struct cgroup *cgrp;
-	struct fd f = fdget_raw(fd);
-	if (!fd_file(f))
+	CLASS(fd_raw, f)(fd);
+	if (fd_empty(f))
 		return ERR_PTR(-EBADF);
 
-	cgrp = cgroup_v1v2_get_from_file(fd_file(f));
-	fdput(f);
-	return cgrp;
+	return cgroup_v1v2_get_from_file(fd_file(f));
 }
 
 /**
diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index f5a0e7182ec0..f32eb38abd0f 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -276,15 +276,12 @@ static struct landlock_ruleset *get_ruleset_from_fd(const int fd,
  */
 static int get_path_from_fd(const s32 fd, struct path *const path)
 {
-	struct fd f;
-	int err = 0;
+	CLASS(fd_raw, f)(fd);
 
 	BUILD_BUG_ON(!__same_type(
 		fd, ((struct landlock_path_beneath_attr *)NULL)->parent_fd));
 
-	/* Handles O_PATH. */
-	f = fdget_raw(fd);
-	if (!fd_file(f))
+	if (fd_empty(f))
 		return -EBADF;
 	/*
 	 * Forbids ruleset FDs, internal filesystems (e.g. nsfs), including
@@ -295,16 +292,12 @@ static int get_path_from_fd(const s32 fd, struct path *const path)
 	    (fd_file(f)->f_path.mnt->mnt_flags & MNT_INTERNAL) ||
 	    (fd_file(f)->f_path.dentry->d_sb->s_flags & SB_NOUSER) ||
 	    d_is_negative(fd_file(f)->f_path.dentry) ||
-	    IS_PRIVATE(d_backing_inode(fd_file(f)->f_path.dentry))) {
-		err = -EBADFD;
-		goto out_fdput;
-	}
+	    IS_PRIVATE(d_backing_inode(fd_file(f)->f_path.dentry)))
+		return -EBADFD;
+
 	*path = fd_file(f)->f_path;
 	path_get(path);
-
-out_fdput:
-	fdput(f);
-	return err;
+	return 0;
 }
 
 static int add_rule_path_beneath(struct landlock_ruleset *const ruleset,
-- 
2.39.5


