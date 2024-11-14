Return-Path: <linux-fsdevel+bounces-34784-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD2F9C8B49
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 13:59:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDB58B2DE24
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 12:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4731FB3F9;
	Thu, 14 Nov 2024 12:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nKO38a7O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9F81FB3E0;
	Thu, 14 Nov 2024 12:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731588769; cv=none; b=bPUMVFmt1amFoyK/Pq6pXrXbl0gKe0KTaNCSY469t5P+14kih7PmymDGzVhGAfmNCbcMxu4QFBou5/Zdn09Q0cNCLWa5+GqpdlRF5kXyDs7DvameKFWrj9CgEc50KLqUgHG1ClwRNglRdw/kCLfKXvo9zWvn45PxLQEOtHf/KfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731588769; c=relaxed/simple;
	bh=UjcT7dBtB7ToYJCfSiyT2447CY82mEpIqgpZ28cgSs8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QTi5zieR3mA8fUk1nXzL7yaDlAx/nbcqPikUc+bGpX4xuWGYeA3SvlNcYu/ZKZFVZ8+Ij47W97hvLE5ycgT4u/Zp/rw20UodGU9XushYeSpJ36MCk+NM7UuGvmA64FfwzIYNubN/xQUHSCpVetugTHgWNpt3h5cusHx0K6b+IBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nKO38a7O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74740C4CECD;
	Thu, 14 Nov 2024 12:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731588768;
	bh=UjcT7dBtB7ToYJCfSiyT2447CY82mEpIqgpZ28cgSs8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nKO38a7OqOO7e5ZKpwzXtnYOSyof+RH4JD8qKIiDTAMmlmWbrgE7RoIMOoi2cMx7F
	 mnT/a6/rQsiLjAYX0HjxxefiGSZ/fEZjroS+9VDC/iWkS8zL+pXLJ1P2Do+QlHQKle
	 aJuK8MiTlswOQnyX8MIMZePdpRWY8xYDhKBEBwqWKfzIeBZ4tfzo3tj3N3gzJBfVAI
	 8dX1GvbCZ3/HgUN1bD25Aj9DGnVXnKjTqaIAVqik+h43XY1cB7jOxNUmX5/VZ6H372
	 62sCj+suffeftfQgfAuzassoWia25XrdjVuaQycoqnZHK2gP2oVnq33hprq9tyQe+3
	 bWUvhjJSmCWHA==
Date: Thu, 14 Nov 2024 13:52:44 +0100
From: Christian Brauner <brauner@kernel.org>
To: Erin Shepherd <erin.shepherd@e43.eu>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Chuck Lever <chuck.lever@oracle.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 3/3] pidfs: implement file handle support
Message-ID: <20241114-erhielten-mitziehen-68c7df0a2fa2@brauner>
References: <20241113-pidfs_fh-v2-0-9a4d28155a37@e43.eu>
 <20241113-pidfs_fh-v2-3-9a4d28155a37@e43.eu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241113-pidfs_fh-v2-3-9a4d28155a37@e43.eu>

On Wed, Nov 13, 2024 at 05:55:25PM +0000, Erin Shepherd wrote:
> On 64-bit platforms, userspace can read the pidfd's inode in order to
> get a never-repeated PID identifier. On 32-bit platforms this identifier
> is not exposed, as inodes are limited to 32 bits. Instead expose the
> identifier via export_fh, which makes it available to userspace via
> name_to_handle_at
> 
> In addition we implement fh_to_dentry, which allows userspace to
> recover a pidfd from a PID file handle.
> 
> We stash the process' PID in the root pid namespace inside the handle,
> and use that to recover the pid (validating that pid->ino matches the
> value in the handle, i.e. that the pid has not been reused).
> 
> We use the root namespace in order to ensure that file handles can be
> moved across namespaces; however, we validate that the PID exists in
> the current namespace before returning the inode.
> 
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Erin Shepherd <erin.shepherd@e43.eu>
> ---

I think you need at least something like the following completely
untested draft on top:

- the pidfs_finish_open_by_handle_at() is somewhat of a clutch to handle
  thread vs thread-group pidfds but it works.

- In contrast to pidfd_open() that uses dentry_open() to create a pidfd
  open_by_handle_at() uses file_open_root(). That's overall fine but
  makes pidfds subject to security hooks which they aren't via
  pidfd_open(). It also necessitats pidfs_finish_open_by_handle_at().
  There's probably other solutions I'm not currently seeing.

- The exportfs_decode_fh_raw() call that's used to decode the pidfd is
  passed vfs_dentry_acceptable() as acceptability callback. For pidfds
  we don't need any of that functionality and we don't need any of the
  disconnected dentry handling logic. So the easiest way to fix that is
  to rely on EXPORT_OP_UNRESTRICTED_OPEN to skip everything. That in
  turns means the only acceptability we have is the nop->fh_to_dentry()
  callback for pidfs.

- This all really needs rigorous selftests before we can even think of
  merging any of this.

Anway, here's the _completely untested, quickly drafted_ diff on top:

diff --git a/fs/exportfs/expfs.c b/fs/exportfs/expfs.c
index 4f2dd4ab4486..65c93f7132d4 100644
--- a/fs/exportfs/expfs.c
+++ b/fs/exportfs/expfs.c
@@ -450,6 +450,13 @@ exportfs_decode_fh_raw(struct vfsmount *mnt, struct fid *fid, int fh_len,
 		goto err_result;
 	}
 
+	/*
+	 * The filesystem has no acceptance criteria other than those in
+	 * nop->fh_to_dentry().
+	 */
+	if (nop->flags & EXPORT_OP_UNRESTRICTED_OPEN)
+		return result;
+
 	/*
 	 * If no acceptance criteria was specified by caller, a disconnected
 	 * dentry is also accepatable. Callers may use this mode to query if
diff --git a/fs/fhandle.c b/fs/fhandle.c
index 056116e58f43..89c2efacc0c3 100644
--- a/fs/fhandle.c
+++ b/fs/fhandle.c
@@ -11,6 +11,7 @@
 #include <linux/personality.h>
 #include <linux/uaccess.h>
 #include <linux/compat.h>
+#include <linux/pidfs.h>
 #include "internal.h"
 #include "mount.h"
 
@@ -218,20 +219,21 @@ static int do_handle_to_path(struct file_handle *handle, struct path *path,
 {
 	int handle_dwords;
 	struct vfsmount *mnt = ctx->root.mnt;
+	struct dentry *dentry;
 
 	/* change the handle size to multiple of sizeof(u32) */
 	handle_dwords = handle->handle_bytes >> 2;
-	path->dentry = exportfs_decode_fh_raw(mnt,
-					  (struct fid *)handle->f_handle,
-					  handle_dwords, handle->handle_type,
-					  ctx->fh_flags,
-					  vfs_dentry_acceptable, ctx);
-	if (IS_ERR_OR_NULL(path->dentry)) {
-		if (path->dentry == ERR_PTR(-ENOMEM))
+	dentry = exportfs_decode_fh_raw(mnt, (struct fid *)handle->f_handle,
+					handle_dwords, handle->handle_type,
+					ctx->fh_flags, vfs_dentry_acceptable,
+					ctx);
+	if (IS_ERR_OR_NULL(dentry)) {
+		if (dentry == ERR_PTR(-ENOMEM))
 			return -ENOMEM;
 		return -ESTALE;
 	}
 	path->mnt = mntget(mnt);
+	path->dentry = dentry;
 	return 0;
 }
 
@@ -239,7 +241,7 @@ static inline bool may_decode_fh(struct handle_to_path_ctx *ctx,
 				 unsigned int o_flags)
 {
 	struct path *root = &ctx->root;
-	struct export_operations *nop = root->mnt->mnt_sb->s_export_op;
+	const struct export_operations *nop = root->mnt->mnt_sb->s_export_op;
 
 	if (nop && nop->flags & EXPORT_OP_UNRESTRICTED_OPEN)
 		return true;
@@ -342,7 +344,7 @@ static long do_handle_open(int mountdirfd, struct file_handle __user *ufh,
 			   int open_flag)
 {
 	long retval = 0;
-	struct path path;
+	struct path path __free(path_put) = {};
 	struct file *file;
 	int fd;
 
@@ -351,19 +353,24 @@ static long do_handle_open(int mountdirfd, struct file_handle __user *ufh,
 		return retval;
 
 	fd = get_unused_fd_flags(open_flag);
-	if (fd < 0) {
-		path_put(&path);
+	if (fd < 0)
 		return fd;
-	}
+
 	file = file_open_root(&path, "", open_flag, 0);
 	if (IS_ERR(file)) {
 		put_unused_fd(fd);
-		retval =  PTR_ERR(file);
-	} else {
-		retval = fd;
-		fd_install(fd, file);
+		return PTR_ERR(file);
 	}
-	path_put(&path);
+
+	retval = pidfs_finish_open_by_handle_at(file, open_flag);
+	if (retval) {
+		put_unused_fd(fd);
+		fput(file);
+		return retval;
+	}
+
+	retval = fd;
+	fd_install(fd, file);
 	return retval;
 }
 
diff --git a/fs/pidfs.c b/fs/pidfs.c
index 0684a9b8fe71..19948002f395 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -237,6 +237,24 @@ struct pid *pidfd_pid(const struct file *file)
 	return file_inode(file)->i_private;
 }
 
+int pidfs_finish_open_by_handle_at(struct file *file, unsigned int oflags)
+{
+	struct pid *pid;
+	bool thread = oflags & PIDFD_THREAD;
+
+	pid = pidfd_pid(file);
+	if (IS_ERR(pid))
+		return 0;
+
+	if (!pid_has_task(pid, thread ? PIDTYPE_PID : PIDTYPE_TGID))
+		return -EINVAL;
+
+	if (thread)
+		file->f_flags |= PIDFD_THREAD;
+
+	return 0;
+}
+
 static struct vfsmount *pidfs_mnt __ro_after_init;
 
 #if BITS_PER_LONG == 32
@@ -377,7 +395,7 @@ static struct dentry *pidfs_fh_to_dentry(struct super_block *sb,
 					 int fh_len, int fh_type)
 {
 	int ret;
-	struct path path;
+	struct path path __free(path_put) = {};
 	struct pidfd_fid *fid = (struct pidfd_fid *)gen_fid;
 	struct pid *pid;
 
@@ -393,11 +411,12 @@ static struct dentry *pidfs_fh_to_dentry(struct super_block *sb,
 	}
 
 	ret = path_from_stashed(&pid->stashed, pidfs_mnt, pid, &path);
-	if (ret < 0)
+	if (ret < 0) {
+		put_pid(pid);
 		return ERR_PTR(ret);
+	}
 
-	mntput(path.mnt);
-	return path.dentry;
+	return dget(path.dentry);
 }
 
 static const struct export_operations pidfs_export_operations = {
diff --git a/include/linux/pidfs.h b/include/linux/pidfs.h
index 75bdf9807802..9a4130056e7d 100644
--- a/include/linux/pidfs.h
+++ b/include/linux/pidfs.h
@@ -3,6 +3,7 @@
 #define _LINUX_PID_FS_H
 
 struct file *pidfs_alloc_file(struct pid *pid, unsigned int flags);
+int pidfs_finish_open_by_handle_at(struct file *file, unsigned int oflags);
 void __init pidfs_init(void);
 
 #endif /* _LINUX_PID_FS_H */


>  fs/pidfs.c | 62 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 61 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/pidfs.c b/fs/pidfs.c
> index 80675b6bf88459c22787edaa68db360bdc0d0782..0684a9b8fe71c5205fb153b2714bc9c672045fd5 100644
> --- a/fs/pidfs.c
> +++ b/fs/pidfs.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <linux/anon_inodes.h>
> +#include <linux/exportfs.h>
>  #include <linux/file.h>
>  #include <linux/fs.h>
>  #include <linux/magic.h>
> @@ -347,11 +348,69 @@ static const struct dentry_operations pidfs_dentry_operations = {
>  	.d_prune	= stashed_dentry_prune,
>  };
>  
> +#define PIDFD_FID_LEN 3
> +
> +struct pidfd_fid {
> +	u64 ino;
> +	s32 pid;
> +} __packed;
> +
> +static int pidfs_encode_fh(struct inode *inode, u32 *fh, int *max_len,
> +			   struct inode *parent)
> +{
> +	struct pid *pid = inode->i_private;
> +	struct pidfd_fid *fid = (struct pidfd_fid *)fh;
> +
> +	if (*max_len < PIDFD_FID_LEN) {
> +		*max_len = PIDFD_FID_LEN;
> +		return FILEID_INVALID;
> +	}
> +
> +	fid->ino = pid->ino;
> +	fid->pid = pid_nr(pid);
> +	*max_len = PIDFD_FID_LEN;
> +	return FILEID_INO64_GEN;
> +}
> +
> +static struct dentry *pidfs_fh_to_dentry(struct super_block *sb,
> +					 struct fid *gen_fid,
> +					 int fh_len, int fh_type)
> +{
> +	int ret;
> +	struct path path;
> +	struct pidfd_fid *fid = (struct pidfd_fid *)gen_fid;
> +	struct pid *pid;
> +
> +	if (fh_type != FILEID_INO64_GEN || fh_len < PIDFD_FID_LEN)
> +		return NULL;
> +
> +	scoped_guard(rcu) {
> +		pid = find_pid_ns(fid->pid, &init_pid_ns);
> +		if (!pid || pid->ino != fid->ino || pid_vnr(pid) == 0)
> +			return NULL;
> +
> +		pid = get_pid(pid);
> +	}
> +
> +	ret = path_from_stashed(&pid->stashed, pidfs_mnt, pid, &path);
> +	if (ret < 0)
> +		return ERR_PTR(ret);
> +
> +	mntput(path.mnt);
> +	return path.dentry;
> +}
> +
> +static const struct export_operations pidfs_export_operations = {
> +	.encode_fh = pidfs_encode_fh,
> +	.fh_to_dentry = pidfs_fh_to_dentry,
> +	.flags = EXPORT_OP_UNRESTRICTED_OPEN,
> +};
> +
>  static int pidfs_init_inode(struct inode *inode, void *data)
>  {
>  	inode->i_private = data;
>  	inode->i_flags |= S_PRIVATE;
> -	inode->i_mode |= S_IRWXU;
> +	inode->i_mode |= S_IRWXU | S_IRWXG | S_IRWXO;
>  	inode->i_op = &pidfs_inode_operations;
>  	inode->i_fop = &pidfs_file_operations;
>  	/*
> @@ -382,6 +441,7 @@ static int pidfs_init_fs_context(struct fs_context *fc)
>  		return -ENOMEM;
>  
>  	ctx->ops = &pidfs_sops;
> +	ctx->eops = &pidfs_export_operations;
>  	ctx->dops = &pidfs_dentry_operations;
>  	fc->s_fs_info = (void *)&pidfs_stashed_ops;
>  	return 0;
> 
> -- 
> 2.46.1
> 

