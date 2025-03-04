Return-Path: <linux-fsdevel+bounces-43099-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18042A4DEA2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 14:05:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E26D7A641E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 13:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6769E202F7E;
	Tue,  4 Mar 2025 13:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="msKcv5gH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70A7200BBC
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Mar 2025 13:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741093537; cv=none; b=B+p/3eUvuvSTB7WK34aGKcGt2d4y1jPrM0FK0XumKY3xTZ1WnKe0mgOGNR/2pVLGVu+iGWZDbsLWJ136PpAMcyQX0rJkwOgiv+1ohoPN4yDiKShQFuT98PRqp8QT6E/ecJrhdv1K4VOqFt12jvRLk0TfYEhpo5dU19yGyQHyWik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741093537; c=relaxed/simple;
	bh=TBoYwdmhVU3A7bZEtzR43pdugSQUMpT+SDJo1xqadbs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MhcUlYIlJnjhJf0zwzGsDtZAqierOMCqnQQKxSMB62RwE9pKTfOe4joUpZKH2ALUxQd1tJwEDZRx/dCpgeRUcPfD0kfHNHYE3kDBW32Puq3L5M+5Rldv4iW6wa+oskdSfeEJZ7Fas6aHFvUsx9nFAamEnxXXjYMzDNujtdKdHYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=msKcv5gH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0D2AC4CEE7;
	Tue,  4 Mar 2025 13:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741093537;
	bh=TBoYwdmhVU3A7bZEtzR43pdugSQUMpT+SDJo1xqadbs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=msKcv5gHkX3M3kEwWqwu150mMDzRZLvM2vb2CJ/vnzfTVzokax0eJG2L+yCCu4Y8t
	 AJvpJBoNv0V0AOhkEzOyLr5Iv/S/vON+FSkf0Zzhz8y75H0F/G9P0/zb4IT/EVz4DE
	 wgHPAqhboY6LJidAk8NaeydzFWk3V/LZ0tZf3Vz6SWVw5DGmRZ3zjpm/h3c4ggemIq
	 SEKLQxz5N5xMxVdEyUK2RcPj3SW88bqihQF7wVeZFlhOgOpbWWhl6tjZfs9dzPkGzS
	 m7rd89Kd8nYBzeEf24tE+JZLmQVjVwp13oDjiqVNjjvQii5IW10tM001CqED7me8yp
	 2T93v7G+d8GVQ==
Message-ID: <800082efb3b2537e80427eb9d3b0e20b10ac866c.camel@kernel.org>
Subject: Re: [PATCH v2 05/15] pidfs: record exit code and cgroupid at exit
From: Jeff Layton <jlayton@kernel.org>
To: Christian Brauner <brauner@kernel.org>, Oleg Nesterov <oleg@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Lennart Poettering
 <lennart@poettering.net>,  Daan De Meyer <daan.j.demeyer@gmail.com>, Mike
 Yuan <me@yhndnzj.com>
Date: Tue, 04 Mar 2025 08:05:35 -0500
In-Reply-To: <20250304-work-pidfs-kill_on_last_close-v2-5-44fdacfaa7b7@kernel.org>
References: 
	<20250304-work-pidfs-kill_on_last_close-v2-0-44fdacfaa7b7@kernel.org>
	 <20250304-work-pidfs-kill_on_last_close-v2-5-44fdacfaa7b7@kernel.org>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-03-04 at 10:41 +0100, Christian Brauner wrote:
> Record the exit code and cgroupid in do_exit() and stash in struct
> pidfs_exit_info so it can be retrieved even after the task has been
> reaped.
>=20
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  fs/internal.h         |  1 +
>  fs/libfs.c            |  4 ++--
>  fs/pidfs.c            | 41 ++++++++++++++++++++++++++++++++++++++++-
>  include/linux/pidfs.h |  1 +
>  kernel/exit.c         |  2 ++
>  5 files changed, 46 insertions(+), 3 deletions(-)
>=20
> diff --git a/fs/internal.h b/fs/internal.h
> index e7f02ae1e098..c1e6d8b294cb 100644
> --- a/fs/internal.h
> +++ b/fs/internal.h
> @@ -325,6 +325,7 @@ struct stashed_operations {
>  int path_from_stashed(struct dentry **stashed, struct vfsmount *mnt, voi=
d *data,
>  		      struct path *path);
>  void stashed_dentry_prune(struct dentry *dentry);
> +struct dentry *stashed_dentry_get(struct dentry **stashed);
>  /**
>   * path_mounted - check whether path is mounted
>   * @path: path to check
> diff --git a/fs/libfs.c b/fs/libfs.c
> index 8444f5cc4064..cf5a267aafe4 100644
> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -2113,7 +2113,7 @@ struct timespec64 simple_inode_init_ts(struct inode=
 *inode)
>  }
>  EXPORT_SYMBOL(simple_inode_init_ts);
> =20
> -static inline struct dentry *get_stashed_dentry(struct dentry **stashed)
> +struct dentry *stashed_dentry_get(struct dentry **stashed)
>  {
>  	struct dentry *dentry;
> =20
> @@ -2215,7 +2215,7 @@ int path_from_stashed(struct dentry **stashed, stru=
ct vfsmount *mnt, void *data,
>  	const struct stashed_operations *sops =3D mnt->mnt_sb->s_fs_info;
> =20
>  	/* See if dentry can be reused. */
> -	path->dentry =3D get_stashed_dentry(stashed);
> +	path->dentry =3D stashed_dentry_get(stashed);
>  	if (path->dentry) {
>  		sops->put_data(data);
>  		goto out_path;
> diff --git a/fs/pidfs.c b/fs/pidfs.c
> index eaecb0a947f0..258e1c13ee56 100644
> --- a/fs/pidfs.c
> +++ b/fs/pidfs.c
> @@ -32,7 +32,7 @@ static struct kmem_cache *pidfs_cachep __ro_after_init;
>   */
>  struct pidfs_exit_info {
>  	__u64 cgroupid;
> -	__u64 exit_code;
> +	__s32 exit_code;

^^^
The above delta should be folded into the previous patch.

>  };
> =20
>  struct pidfs_inode {
> @@ -458,6 +458,45 @@ struct pid *pidfd_pid(const struct file *file)
>  	return file_inode(file)->i_private;
>  }
> =20
> +/*
> + * We're called from release_task(). We know there's at least one
> + * reference to struct pid being held that won't be released until the
> + * task has been reaped which cannot happen until we're out of
> + * release_task().
> + *
> + * If this struct pid is refered to by a pidfd then stashed_dentry_get()
> + * will return the dentry and inode for that struct pid. Since we've
> + * taken a reference on it there's now an additional reference from the
> + * exit path on it. Which is fine. We're going to put it again in a
> + * second and we know that the pid is kept alive anyway.
> + *
> + * Worst case is that we've filled in the info and immediately free the
> + * dentry and inode afterwards since the pidfd has been closed. Since
> + * pidfs_exit() currently is placed after exit_task_work() we know that
> + * it cannot be us aka the exiting task holding a pidfd to ourselves.
> + */

That is a subtle interaction. Thanks for the comment!

> +void pidfs_exit(struct task_struct *tsk)
> +{
> +	struct dentry *dentry;
> +
> +	dentry =3D stashed_dentry_get(&task_pid(tsk)->stashed);
> +	if (dentry) {
> +		struct inode *inode =3D d_inode(dentry);
> +		struct pidfs_exit_info *exit_info =3D &pidfs_i(inode)->exit_info;
> +#ifdef CONFIG_CGROUPS
> +		struct cgroup *cgrp;
> +
> +		rcu_read_lock();
> +		cgrp =3D task_dfl_cgroup(tsk);
> +		exit_info->cgroupid =3D cgroup_id(cgrp);
> +		rcu_read_unlock();
> +#endif
> +		exit_info->exit_code =3D tsk->exit_code;
> +
> +		dput(dentry);
> +	}
> +}
> +
>  static struct vfsmount *pidfs_mnt __ro_after_init;
> =20
>  /*
> diff --git a/include/linux/pidfs.h b/include/linux/pidfs.h
> index 7c830d0dec9a..05e6f8f4a026 100644
> --- a/include/linux/pidfs.h
> +++ b/include/linux/pidfs.h
> @@ -6,6 +6,7 @@ struct file *pidfs_alloc_file(struct pid *pid, unsigned i=
nt flags);
>  void __init pidfs_init(void);
>  void pidfs_add_pid(struct pid *pid);
>  void pidfs_remove_pid(struct pid *pid);
> +void pidfs_exit(struct task_struct *tsk);
>  extern const struct dentry_operations pidfs_dentry_operations;
> =20
>  #endif /* _LINUX_PID_FS_H */
> diff --git a/kernel/exit.c b/kernel/exit.c
> index 3485e5fc499e..98d292120296 100644
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -69,6 +69,7 @@
>  #include <linux/sysfs.h>
>  #include <linux/user_events.h>
>  #include <linux/uaccess.h>
> +#include <linux/pidfs.h>
> =20
>  #include <uapi/linux/wait.h>
> =20
> @@ -254,6 +255,7 @@ void release_task(struct task_struct *p)
>  	write_lock_irq(&tasklist_lock);
>  	ptrace_release_task(p);
>  	thread_pid =3D get_pid(p->thread_pid);
> +	pidfs_exit(p);
>  	__exit_signal(p);
> =20
>  	/*
>=20

Reviewed-by: Jeff Layton <jlayton@kernel.org>

