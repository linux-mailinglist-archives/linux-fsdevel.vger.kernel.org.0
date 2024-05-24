Return-Path: <linux-fsdevel+bounces-20107-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 929278CE417
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 May 2024 12:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49419281CD8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 May 2024 10:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808B485643;
	Fri, 24 May 2024 10:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aOsEfIdE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D921585274
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 May 2024 10:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716545988; cv=none; b=D8vK/liViOWKcHP28BWBMgPjmm8BrioUuLZrLzfH3LT9VgHxuU2Szsadn9IgYkCuCyFGTnDpn2ufesWOEjMjFeByZr2REm9PJfR1HahLUo5vY1dQIbOiQL8K1l+P5gfEBffynUtr1YDYrhvtSnd5GTzMIYz7k9yd6uVonMDK740=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716545988; c=relaxed/simple;
	bh=oXd2UY5DlnmtsdPJQlpnRB5QeRRSr/2LamVUqHAXA8k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=qczOFgrxE4d3/YInthz3H9NSJCJdpu5Jie6++aEunOQlvKLkUtDkLKIjJFiU/g9gUt7TixEO9EbjQR6Zgn7Fi8ZcN+t42zSJ6LQMsnL+o6qV+NwEqddlFQOtQxhAPHfykS92MZTTwQpRbL6ba/nXBnk3dQHkPA9GAngLAQXbpmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aOsEfIdE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06490C2BBFC;
	Fri, 24 May 2024 10:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716545988;
	bh=oXd2UY5DlnmtsdPJQlpnRB5QeRRSr/2LamVUqHAXA8k=;
	h=From:Date:Subject:To:Cc:From;
	b=aOsEfIdERSxCJUKoAjCbw61xlR8zx0fy5ovbTynhkVghi8VA73mVAIsnnvgAqAGEe
	 HrfzzlpOXhv2D08JcB/aLLHViC476jVYwLQBtmORHwzH+pV0PTgzsfeod+FMrjXy/w
	 oCNTvSgTs9PmFyX9G+3A5KjOSe8hmon2NcNxHLDPU9NFnB45kIeyZkvwSpjKcfb/nM
	 19OR2aLIh7xp0w4HPYnMw01LIbOvy14DCyo4KBHsWE16Ee7cDZI0SweyCpXScMC/eW
	 5gUrsRZKbxPoNv2s3ZEL59xHX8mSpbMgOsjOp706UGiuPkO0/0nfAwNUjb/nQGxm00
	 2JBEZBt2VK+mw==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 24 May 2024 12:19:39 +0200
Subject: [PATCH RFC] : fhandle: relax open_by_handle_at() permission checks
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240524-vfs-open_by_handle_at-v1-1-3d4b7d22736b@kernel.org>
X-B4-Tracking: v=1; b=H4sIALppUGYC/x3MUQrCMBCE4auUfXYlxtSAV5ESknRqA5qWbClK6
 d1Nffxh5ttIUBKE7s1GBWuSNOUal1NDcfT5CU59bdJKG9Vqw+sgPM3ILnxdHfQvOL+wvUat7M0
 iGFD9zgVD+vzdR1c7eAGH4nMcD+3tZUE5HyirlrWhff8B1/jRLIsAAAA=
To: Amir Goldstein <amir73il@gmail.com>, Jeff Layton <jlayton@kernel.org>, 
 Chuck Lever <chuck.lever@oracle.com>, Aleksa Sarai <cyphar@cyphar.com>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=13212; i=brauner@kernel.org;
 h=from:subject:message-id; bh=oXd2UY5DlnmtsdPJQlpnRB5QeRRSr/2LamVUqHAXA8k=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQFZB5Ku/ljWdsas9zfC/TNJx1Ly1f2LDK/mXawJG1aM
 0eP+slFHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABMpsGNkmOU3R/vucrYLZ64I
 7vV+/TlP1e4/7yZb52kZX6yMJqw+bs7I0GLS/VDI7euGJDZL/tbbHy3+q7y/IDx1pZ47j39zK+M
 aVgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

A current limitation of open_by_handle_at() is that it's currently not possible
to use it from within containers at all because we require CAP_DAC_READ_SEARCH
in the initial namespace. That's unfortunate because there are scenarios where
using open_by_handle_at() from within containers.

Two examples:

(1) cgroupfs allows to encode cgroups to file handles and reopen them with
    open_by_handle_at().
(2) Fanotify allows placing filesystem watches they currently aren't usable in
    containers because the returned file handles cannot be used.

Here's a proposal for relaxing the permission check for open_by_handle_at().

(1) Opening file handles when the caller has privileges over the filesystem
    (1.1) The caller has an unobstructed view of the filesystem.
    (1.2) The caller has permissions to follow a path to the file handle.

This doesn't address the problem of opening a file handle when only a portion
of a filesystem is exposed as is common in containers by e.g., bind-mounting a
subtree. The proposal to solve this use-case is:

(2) Opening file handles when the caller has privileges over a subtree
    (2.1) The caller is able to reach the file from the provided mount fd.
    (2.2) The caller has permissions to construct an unobstructed path to the
          file handle.
    (2.3) The caller has permissions to follow a path to the file handle.

The relaxed permission checks are currently restricted to directory file
handles which are what both cgroupfs and fanotify need. Handling disconnected
non-directory file handles would lead to a potentially non-deterministic api.
If a disconnected non-directory file handle is provided we may fail to decode
a valid path that we could use for permission checking. That in itself isn't a
problem as we would just return EACCES in that case. However, confusion may
arise if a non-disconnected dentry ends up in the cache later and those opening
the file handle would suddenly succeed.

* It's potentially possible to use timing information (side-channel) to infer
  whether a given inode exists. I don't think that's particularly
  problematic. Thanks to Jann for bringing this to my attention.

* An unrelated note (IOW, these are thoughts that apply to
  open_by_handle_at() generically and are unrelated to the changes here):
  Jann pointed out that we should verify whether deleted files could
  potentially be reopened through open_by_handle_at(). I don't think that's
  possible though.

  Another potential thing to check is whether open_by_handle_at() could be
  abused to open internal stuff like memfds or gpu stuff. I don't think so
  but I haven't had the time to completely verify this.

This dates back to discussions Amir and I had quite some time ago and thanks to
him for providing a lot of details around the export code and related patches!

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/exportfs/expfs.c      |   9 ++-
 fs/fhandle.c             | 162 ++++++++++++++++++++++++++++++++++++-----------
 fs/mount.h               |   1 +
 fs/namespace.c           |   2 +-
 fs/nfsd/nfsfh.c          |   2 +-
 include/linux/exportfs.h |   1 +
 6 files changed, 137 insertions(+), 40 deletions(-)

diff --git a/fs/exportfs/expfs.c b/fs/exportfs/expfs.c
index 07ea3d62b298..b23b052df715 100644
--- a/fs/exportfs/expfs.c
+++ b/fs/exportfs/expfs.c
@@ -427,7 +427,7 @@ EXPORT_SYMBOL_GPL(exportfs_encode_fh);
 
 struct dentry *
 exportfs_decode_fh_raw(struct vfsmount *mnt, struct fid *fid, int fh_len,
-		       int fileid_type,
+		       int fileid_type, bool directory,
 		       int (*acceptable)(void *, struct dentry *),
 		       void *context)
 {
@@ -445,6 +445,11 @@ exportfs_decode_fh_raw(struct vfsmount *mnt, struct fid *fid, int fh_len,
 	if (IS_ERR_OR_NULL(result))
 		return result;
 
+	if (directory && !d_is_dir(result)) {
+		err = -ENOTDIR;
+		goto err_result;
+	}
+
 	/*
 	 * If no acceptance criteria was specified by caller, a disconnected
 	 * dentry is also accepatable. Callers may use this mode to query if
@@ -581,7 +586,7 @@ struct dentry *exportfs_decode_fh(struct vfsmount *mnt, struct fid *fid,
 {
 	struct dentry *ret;
 
-	ret = exportfs_decode_fh_raw(mnt, fid, fh_len, fileid_type,
+	ret = exportfs_decode_fh_raw(mnt, fid, fh_len, fileid_type, false,
 				     acceptable, context);
 	if (IS_ERR_OR_NULL(ret)) {
 		if (ret == ERR_PTR(-ENOMEM))
diff --git a/fs/fhandle.c b/fs/fhandle.c
index 8a7f86c2139a..c6ed832ddbb8 100644
--- a/fs/fhandle.c
+++ b/fs/fhandle.c
@@ -115,88 +115,174 @@ SYSCALL_DEFINE5(name_to_handle_at, int, dfd, const char __user *, name,
 	return err;
 }
 
-static struct vfsmount *get_vfsmount_from_fd(int fd)
+static int get_path_from_fd(int fd, struct path *root)
 {
-	struct vfsmount *mnt;
-
 	if (fd == AT_FDCWD) {
 		struct fs_struct *fs = current->fs;
 		spin_lock(&fs->lock);
-		mnt = mntget(fs->pwd.mnt);
+		*root = fs->pwd;
+		path_get(root);
 		spin_unlock(&fs->lock);
 	} else {
 		struct fd f = fdget(fd);
 		if (!f.file)
-			return ERR_PTR(-EBADF);
-		mnt = mntget(f.file->f_path.mnt);
+			return -EBADF;
+		*root = f.file->f_path;
+		path_get(root);
 		fdput(f);
 	}
-	return mnt;
+
+	return 0;
 }
 
+enum handle_to_path_flags {
+	HANDLE_CHECK_PERMS   = (1 << 0),
+	HANDLE_CHECK_SUBTREE = (1 << 1),
+};
+
+struct handle_to_path_ctx {
+	struct path root;
+	enum handle_to_path_flags flags;
+	bool directory;
+};
+
 static int vfs_dentry_acceptable(void *context, struct dentry *dentry)
 {
-	return 1;
+	struct handle_to_path_ctx *ctx = context;
+	struct user_namespace *user_ns = current_user_ns();
+	struct dentry *d, *root = ctx->root.dentry;
+	struct mnt_idmap *idmap = mnt_idmap(ctx->root.mnt);
+	int retval = 0;
+
+	if (!root)
+		return 1;
+
+	/* Old permission model with global CAP_DAC_READ_SEARCH. */
+	if (!ctx->flags)
+		return 1;
+
+	/*
+	 * It's racy as we're not taking rename_lock but we're able to ignore
+	 * permissions and we just need an approximation whether we were able
+	 * to follow a path to the file.
+	 */
+	d = dget(dentry);
+	while (d != root && !IS_ROOT(d)) {
+		struct dentry *parent = dget_parent(d);
+
+		/*
+		 * We know that we have the ability to override DAC permissions
+		 * as we've verified this earlier via CAP_DAC_READ_SEARCH. But
+		 * we also need to make sure that there aren't any unmapped
+		 * inodes in the path that would prevent us from reaching the
+		 * file.
+		 */
+		if (!privileged_wrt_inode_uidgid(user_ns, idmap,
+						 d_inode(parent))) {
+			dput(d);
+			dput(parent);
+			return retval;
+		}
+
+		dput(d);
+		d = parent;
+	}
+
+	if (!(ctx->flags & HANDLE_CHECK_SUBTREE) || d == root)
+		retval = 1;
+
+	dput(d);
+	return retval;
 }
 
 static int do_handle_to_path(int mountdirfd, struct file_handle *handle,
-			     struct path *path)
+			     struct path *path, struct handle_to_path_ctx *ctx)
 {
-	int retval = 0;
 	int handle_dwords;
+	struct vfsmount *mnt = ctx->root.mnt;
 
-	path->mnt = get_vfsmount_from_fd(mountdirfd);
-	if (IS_ERR(path->mnt)) {
-		retval = PTR_ERR(path->mnt);
-		goto out_err;
-	}
 	/* change the handle size to multiple of sizeof(u32) */
 	handle_dwords = handle->handle_bytes >> 2;
-	path->dentry = exportfs_decode_fh(path->mnt,
+	path->dentry = exportfs_decode_fh_raw(mnt,
 					  (struct fid *)handle->f_handle,
 					  handle_dwords, handle->handle_type,
-					  vfs_dentry_acceptable, NULL);
-	if (IS_ERR(path->dentry)) {
-		retval = PTR_ERR(path->dentry);
-		goto out_mnt;
+					  ctx->directory,
+					  vfs_dentry_acceptable, ctx);
+	if (IS_ERR_OR_NULL(path->dentry)) {
+		if (path->dentry == ERR_PTR(-ENOMEM))
+			return -ENOMEM;
+		return -ESTALE;
 	}
+	path->mnt = mntget(mnt);
 	return 0;
-out_mnt:
-	mntput(path->mnt);
-out_err:
-	return retval;
 }
 
 static int handle_to_path(int mountdirfd, struct file_handle __user *ufh,
-		   struct path *path)
+		   struct path *path, unsigned int o_flags)
 {
 	int retval = 0;
 	struct file_handle f_handle;
 	struct file_handle *handle = NULL;
+	struct handle_to_path_ctx ctx = {};
+
+	retval = get_path_from_fd(mountdirfd, &ctx.root);
+	if (retval)
+		goto out_err;
 
-	/*
-	 * With handle we don't look at the execute bit on the
-	 * directory. Ideally we would like CAP_DAC_SEARCH.
-	 * But we don't have that
-	 */
 	if (!capable(CAP_DAC_READ_SEARCH)) {
+		/*
+		 * Allow relaxed permissions of file handles if the caller has
+		 * the ability to mount the filesystem or create a bind-mount
+		 * of the provided @mountdirfd.
+		 *
+		 * In both cases the caller may be able to get an unobstructed
+		 * way to the encoded file handle. If the caller is only able
+		 * to create a bind-mount we need to verify that there are no
+		 * locked mounts on top of it that could prevent us from
+		 * getting to the encoded file.
+		 *
+		 * In principle, locked mounts can prevent the caller from
+		 * mounting the filesystem but that only applies to procfs and
+		 * sysfs neither of which support decoding file handles.
+		 *
+		 * This is currently restricted to O_DIRECTORY to provide a
+		 * deterministic API that avoids a confusing api in the face of
+		 * disconnected non-dir dentries.
+		 */
+
 		retval = -EPERM;
-		goto out_err;
+		if (!(o_flags & O_DIRECTORY))
+			goto out_path;
+
+		if (ns_capable(ctx.root.mnt->mnt_sb->s_user_ns, CAP_SYS_ADMIN))
+			ctx.flags = HANDLE_CHECK_PERMS;
+		else if (ns_capable(real_mount(ctx.root.mnt)->mnt_ns->user_ns, CAP_SYS_ADMIN) &&
+			   !has_locked_children(real_mount(ctx.root.mnt), ctx.root.dentry))
+			ctx.flags = HANDLE_CHECK_PERMS | HANDLE_CHECK_SUBTREE;
+		else
+			goto out_path;
+
+		/* Are we able to override DAC permissions? */
+		if (!ns_capable(current_user_ns(), CAP_DAC_READ_SEARCH))
+			goto out_path;
+
+		ctx.directory = true;
 	}
+
 	if (copy_from_user(&f_handle, ufh, sizeof(struct file_handle))) {
 		retval = -EFAULT;
-		goto out_err;
+		goto out_path;
 	}
 	if ((f_handle.handle_bytes > MAX_HANDLE_SZ) ||
 	    (f_handle.handle_bytes == 0)) {
 		retval = -EINVAL;
-		goto out_err;
+		goto out_path;
 	}
 	handle = kmalloc(struct_size(handle, f_handle, f_handle.handle_bytes),
 			 GFP_KERNEL);
 	if (!handle) {
 		retval = -ENOMEM;
-		goto out_err;
+		goto out_path;
 	}
 	/* copy the full handle */
 	*handle = f_handle;
@@ -207,10 +293,14 @@ static int handle_to_path(int mountdirfd, struct file_handle __user *ufh,
 		goto out_handle;
 	}
 
-	retval = do_handle_to_path(mountdirfd, handle, path);
+	retval = do_handle_to_path(mountdirfd, handle, path, &ctx);
+	if (retval)
+		goto out_handle;
 
 out_handle:
 	kfree(handle);
+out_path:
+	path_put(&ctx.root);
 out_err:
 	return retval;
 }
@@ -223,7 +313,7 @@ static long do_handle_open(int mountdirfd, struct file_handle __user *ufh,
 	struct file *file;
 	int fd;
 
-	retval = handle_to_path(mountdirfd, ufh, &path);
+	retval = handle_to_path(mountdirfd, ufh, &path, open_flag);
 	if (retval)
 		return retval;
 
diff --git a/fs/mount.h b/fs/mount.h
index 4a42fc68f4cc..4adce73211ae 100644
--- a/fs/mount.h
+++ b/fs/mount.h
@@ -152,3 +152,4 @@ static inline void move_from_ns(struct mount *mnt, struct list_head *dt_list)
 }
 
 extern void mnt_cursor_del(struct mnt_namespace *ns, struct mount *cursor);
+bool has_locked_children(struct mount *mnt, struct dentry *dentry);
diff --git a/fs/namespace.c b/fs/namespace.c
index 5a51315c6678..4386787210c7 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2078,7 +2078,7 @@ void drop_collected_mounts(struct vfsmount *mnt)
 	namespace_unlock();
 }
 
-static bool has_locked_children(struct mount *mnt, struct dentry *dentry)
+bool has_locked_children(struct mount *mnt, struct dentry *dentry)
 {
 	struct mount *child;
 
diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index 0b75305fb5f5..3e7f81eb2818 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -247,7 +247,7 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct svc_fh *fhp)
 		dentry = dget(exp->ex_path.dentry);
 	else {
 		dentry = exportfs_decode_fh_raw(exp->ex_path.mnt, fid,
-						data_left, fileid_type,
+						data_left, fileid_type, false,
 						nfsd_acceptable, exp);
 		if (IS_ERR_OR_NULL(dentry)) {
 			trace_nfsd_set_fh_dentry_badhandle(rqstp, fhp,
diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
index bb37ad5cc954..90c4b0111218 100644
--- a/include/linux/exportfs.h
+++ b/include/linux/exportfs.h
@@ -305,6 +305,7 @@ static inline int exportfs_encode_fid(struct inode *inode, struct fid *fid,
 extern struct dentry *exportfs_decode_fh_raw(struct vfsmount *mnt,
 					     struct fid *fid, int fh_len,
 					     int fileid_type,
+					     bool directory,
 					     int (*acceptable)(void *, struct dentry *),
 					     void *context);
 extern struct dentry *exportfs_decode_fh(struct vfsmount *mnt, struct fid *fid,

---
base-commit: 8f6a15f095a63a83b096d9b29aaff4f0fbe6f6e6
change-id: 20240524-vfs-open_by_handle_at-73c20767eb4e


