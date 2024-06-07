Return-Path: <linux-fsdevel+bounces-21144-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 709FB8FF9CB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 04:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BCD7284A7D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 02:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133DE18EA8;
	Fri,  7 Jun 2024 02:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="ZihFAkmd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A8212B73
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Jun 2024 02:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717725602; cv=none; b=EGb4A1hZE7OcSyX+3LlArui2K+HsGI2OCfKOOvrfd4eUQAj443GqIg08qbDWw0Bh+QIhQ/s4CiovO74Q9cmv85KOF+/nWtq/C3zSev6CX4QfY/vumGIodwmolvLeqPjR9xxymJJWHHugc4wwFLOu3fMCLagcaEMTdlbiAWxbIh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717725602; c=relaxed/simple;
	bh=waupRMH9XLCEdgiisehW8lFfsL6DBt+T0zNAwVd7+gw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ueX1BMfZkxxa1Mu9N7SrFya94RzFg2au7B8Uw4wSA37Ylpw8TOquR/vPqYokQ81pbIa1L0jbNFlfkqbYkGX8/NJC7LLCi0iEhlBN/FW44IiBFqow+n+jnIz2cE/qadCozLOSr0hpERPoOrQ0EYaN7xDjn9SkyVJC+NpC1w7fDJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=ZihFAkmd; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=z8nCzcgRDkfAk5n+DwK1pXzkK9q3BsG2xPPikL9WKXI=; b=ZihFAkmdOhG1aSJUZuSHsiCh3K
	VM9ZddBeYSTIducNd4ljNT6ZLLbaS8LtUP6ddHe9S79+95tMriVc4sA7qPmg5sUSDeWiioKvZ2ffA
	AWxELSY0OBSqTS1xXPuMaDZd5v3PcI3qkQxe/ZPEc6kgxCfpFp2xkfxUaBr3Z3aQMnyBmHiqTL9aJ
	Q+qc177ngHcAo11XutHMik0I/ekNhplycoAdSqCbp8lN4K+IZk75SlwugfCh8/TNFeX/UPpXFuJlp
	WbThBXvmf2ZYjanghacwmSAnon/Z5yfKwCgEdipIE8dUmgpl/EyDn9hlQ7GUw3wba5YuXawJnRbKK
	J0vXKuCQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1sFOta-009xBq-37;
	Fri, 07 Jun 2024 01:59:59 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	torvalds@linux-foundation.org
Subject: [PATCH 08/19] fdget_raw() users: switch to CLASS(fd_raw, ...)
Date: Fri,  7 Jun 2024 02:59:46 +0100
Message-Id: <20240607015957.2372428-8-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240607015957.2372428-1-viro@zeniv.linux.org.uk>
References: <20240607015656.GX1629371@ZenIV>
 <20240607015957.2372428-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/arm/kernel/sys_oabi-compat.c | 10 +++-----
 fs/fcntl.c                        | 42 +++++++++++++------------------
 fs/namei.c                        | 13 +++-------
 fs/open.c                         | 13 +++-------
 fs/quota/quota.c                  | 12 +++------
 fs/stat.c                         | 10 +++-----
 fs/statfs.c                       | 12 ++++-----
 kernel/bpf/bpf_inode_storage.c    | 25 ++++++------------
 kernel/cgroup/cgroup.c            |  9 +++----
 security/landlock/syscalls.c      | 19 +++++---------
 10 files changed, 58 insertions(+), 107 deletions(-)

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
index 2b5616762354..f96328ee3853 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -476,24 +476,21 @@ static int check_fcntl_cmd(unsigned cmd)
 
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
 
@@ -502,21 +499,21 @@ SYSCALL_DEFINE3(fcntl64, unsigned int, fd, unsigned int, cmd,
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
@@ -541,9 +538,6 @@ SYSCALL_DEFINE3(fcntl64, unsigned int, fd, unsigned int, cmd,
 		err = do_fcntl(fd, cmd, arg, fd_file(f));
 		break;
 	}
-out1:
-	fdput(f);
-out:
 	return err;
 }
 #endif
@@ -639,21 +633,21 @@ static int fixup_compat_flock(struct flock *flock)
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
@@ -696,8 +690,6 @@ static long do_compat_fcntl64(unsigned int fd, unsigned int cmd,
 		err = do_fcntl(fd, cmd, arg, fd_file(f));
 		break;
 	}
-out_put:
-	fdput(f);
 	return err;
 }
 
diff --git a/fs/namei.c b/fs/namei.c
index 72736b6328a6..ae916b49a25f 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2416,26 +2416,22 @@ static const char *path_init(struct nameidata *nd, unsigned flags)
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
@@ -2445,7 +2441,6 @@ static const char *path_init(struct nameidata *nd, unsigned flags)
 			path_get(&nd->path);
 			nd->inode = nd->path.dentry->d_inode;
 		}
-		fdput(f);
 	}
 
 	/* For scoped-lookups we need to set the root to the dirfd as well. */
diff --git a/fs/open.c b/fs/open.c
index 29e0ec819bc4..4cb5e12e84a5 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -577,23 +577,18 @@ SYSCALL_DEFINE1(chdir, const char __user *, filename)
 
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
diff --git a/fs/stat.c b/fs/stat.c
index 740e5997da09..e593fbbfed83 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -189,15 +189,11 @@ EXPORT_SYMBOL(vfs_getattr);
  */
 int vfs_fstat(int fd, struct kstat *stat)
 {
-	struct fd f;
-	int error;
+	CLASS(fd_raw, f)(fd);
 
-	f = fdget_raw(fd);
-	if (!fd_file(f))
+	if (fd_empty(f))
 		return -EBADF;
-	error = vfs_getattr(&fd_file(f)->f_path, stat, STATX_BASIC_STATS, 0);
-	fdput(f);
-	return error;
+	return vfs_getattr(&fd_file(f)->f_path, stat, STATX_BASIC_STATS, 0);
 }
 
 int getname_statx_lookup_flags(int flags)
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
diff --git a/kernel/bpf/bpf_inode_storage.c b/kernel/bpf/bpf_inode_storage.c
index 0a79aee6523d..a2c05db49ebc 100644
--- a/kernel/bpf/bpf_inode_storage.c
+++ b/kernel/bpf/bpf_inode_storage.c
@@ -78,13 +78,12 @@ void bpf_inode_storage_free(struct inode *inode)
 static void *bpf_fd_inode_storage_lookup_elem(struct bpf_map *map, void *key)
 {
 	struct bpf_local_storage_data *sdata;
-	struct fd f = fdget_raw(*(int *)key);
+	CLASS(fd_raw, f)(*(int *)key);
 
-	if (!fd_file(f))
+	if (fd_empty(f))
 		return ERR_PTR(-EBADF);
 
 	sdata = inode_storage_lookup(file_inode(fd_file(f)), map, true);
-	fdput(f);
 	return sdata ? sdata->data : NULL;
 }
 
@@ -92,19 +91,16 @@ static long bpf_fd_inode_storage_update_elem(struct bpf_map *map, void *key,
 					     void *value, u64 map_flags)
 {
 	struct bpf_local_storage_data *sdata;
-	struct fd f = fdget_raw(*(int *)key);
+	CLASS(fd_raw, f)(*(int *)key);
 
-	if (!fd_file(f))
+	if (fd_empty(f))
 		return -EBADF;
-	if (!inode_storage_ptr(file_inode(fd_file(f)))) {
-		fdput(f);
+	if (!inode_storage_ptr(file_inode(fd_file(f))))
 		return -EBADF;
-	}
 
 	sdata = bpf_local_storage_update(file_inode(fd_file(f)),
 					 (struct bpf_local_storage_map *)map,
 					 value, map_flags, GFP_ATOMIC);
-	fdput(f);
 	return PTR_ERR_OR_ZERO(sdata);
 }
 
@@ -123,15 +119,10 @@ static int inode_storage_delete(struct inode *inode, struct bpf_map *map)
 
 static long bpf_fd_inode_storage_delete_elem(struct bpf_map *map, void *key)
 {
-	struct fd f = fdget_raw(*(int *)key);
-	int err;
-
-	if (!fd_file(f))
+	CLASS(fd_raw, f)(*(int *)key);
+	if (fd_empty(f))
 		return -EBADF;
-
-	err = inode_storage_delete(file_inode(fd_file(f)), map);
-	fdput(f);
-	return err;
+	return inode_storage_delete(file_inode(fd_file(f)), map);
 }
 
 /* *gfp_flags* is a hidden argument provided by the verifier */
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 0a6e9f566ca6..d53673ccaefc 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -6880,14 +6880,11 @@ EXPORT_SYMBOL_GPL(cgroup_get_from_path);
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
index 44edbf57644d..97b3df540dc7 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -269,15 +269,12 @@ static struct landlock_ruleset *get_ruleset_from_fd(const int fd,
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
@@ -288,16 +285,12 @@ static int get_path_from_fd(const s32 fd, struct path *const path)
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
2.39.2


