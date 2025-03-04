Return-Path: <linux-fsdevel+bounces-43103-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA575A4DF3D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 14:28:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50A28189D6C4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 13:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1552D2045B0;
	Tue,  4 Mar 2025 13:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yn+j0ZBu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683FE202C2D
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Mar 2025 13:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741094852; cv=none; b=J/PGiHEO02gUScnjMYG3tJWE/8ivFImakPTbyIuMWinl/Yxp42ujG7sKcOA6crv5fes6kt8OwvI4bSF+lIgcNOzNDtlQ9K3S6SL2jwFV19guY/5t/YUW9570mkXGEr6+c5NoF0mAPTW8oH/fF2yV4jsDYjfO7iaCs3+j/BvoTNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741094852; c=relaxed/simple;
	bh=/BCaftms6dDoMqUN4+KvAvXoUG57+LKdk9uP3q0SDsE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y3m7VLe/slVnDF0rM9R/kOSrlyyzW9NrPnbfV47dsnCIFbWkULrL654bX2Xdu9WueZ0p5wxgOhFduBqE11DN4AdwvL4tun+qVxYkVmNgqDXGTQ+Bdls5EGv0vgd37KDeXP9O0zK8MminL7CsIMcN79Cpad8puW8q6n/e4lejOAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yn+j0ZBu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 445AEC4CEE5;
	Tue,  4 Mar 2025 13:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741094850;
	bh=/BCaftms6dDoMqUN4+KvAvXoUG57+LKdk9uP3q0SDsE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Yn+j0ZBuzrXZgFUSYoAbTwoN9UAdTgWX2To/dx4AzcMl/sdrDxABZFUXRdHTkvnUv
	 1vEPwIERyDeqUfjxYkGycmVH/rmTotIbz3kSo8yDLO62IdlHP3eE0u8UFkIGpVrFWL
	 f2Fog1AADaiW0byhXDbYBhwxtAsKPAzxQy13/DCMfXsTEEp43tPdKUkNtI+wWTvkDE
	 WgG+q3iHoFuomP0oSiXnvFM4V0xXNfnz7wJnpLX34OHgmsG28xvRlOzXmiFsi7qILL
	 CMrVnDblJ3Pm+DHhprXu1iX98nkjy3pgwoU6KwF9W2RShV9yTb08zi+GBc1+hfzLyE
	 IKzT7l8i30eGg==
Message-ID: <ffbcd994a251fe1e2c781f729273e94fb4026abd.camel@kernel.org>
Subject: Re: [PATCH v2 06/15] pidfs: allow to retrieve exit information
From: Jeff Layton <jlayton@kernel.org>
To: Christian Brauner <brauner@kernel.org>, Oleg Nesterov <oleg@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Lennart Poettering
 <lennart@poettering.net>,  Daan De Meyer <daan.j.demeyer@gmail.com>, Mike
 Yuan <me@yhndnzj.com>
Date: Tue, 04 Mar 2025 08:27:29 -0500
In-Reply-To: <20250304-work-pidfs-kill_on_last_close-v2-6-44fdacfaa7b7@kernel.org>
References: 
	<20250304-work-pidfs-kill_on_last_close-v2-0-44fdacfaa7b7@kernel.org>
	 <20250304-work-pidfs-kill_on_last_close-v2-6-44fdacfaa7b7@kernel.org>
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
> Some tools like systemd's jounral need to retrieve the exit and cgroup
> information after a process has already been reaped. This can e.g.,
> happen when retrieving a pidfd via SCM_PIDFD or SCM_PEERPIDFD.
>=20
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  fs/pidfs.c                 | 88 ++++++++++++++++++++++++++++++++++++----=
------
>  include/uapi/linux/pidfd.h |  3 +-
>  kernel/exit.c              |  2 +-
>  3 files changed, 73 insertions(+), 20 deletions(-)
>=20
> diff --git a/fs/pidfs.c b/fs/pidfs.c
> index 258e1c13ee56..11744d7fe177 100644
> --- a/fs/pidfs.c
> +++ b/fs/pidfs.c
> @@ -36,7 +36,8 @@ struct pidfs_exit_info {
>  };
> =20
>  struct pidfs_inode {
> -	struct pidfs_exit_info exit_info;
> +	struct pidfs_exit_info __pei;
> +	struct pidfs_exit_info *exit_info;
>  	struct inode vfs_inode;
>  };
> =20
> @@ -228,17 +229,28 @@ static __poll_t pidfd_poll(struct file *file, struc=
t poll_table_struct *pts)
>  	return poll_flags;
>  }
> =20
> -static long pidfd_info(struct task_struct *task, unsigned int cmd, unsig=
ned long arg)
> +static inline bool current_in_pidns(struct pid *pid)
> +{
> +	const struct pid_namespace *ns =3D task_active_pid_ns(current);
> +
> +	if (ns->level <=3D pid->level)
> +		return pid->numbers[ns->level].ns =3D=3D ns;
> +
> +	return false;
> +}
> +
> +static long pidfd_info(struct file *file, unsigned int cmd, unsigned lon=
g arg)
>  {
>  	struct pidfd_info __user *uinfo =3D (struct pidfd_info __user *)arg;
> +	struct pid *pid =3D pidfd_pid(file);
>  	size_t usize =3D _IOC_SIZE(cmd);
>  	struct pidfd_info kinfo =3D {};
> +	struct pidfs_exit_info *exit_info;
> +	struct inode *inode =3D file_inode(file);
>  	struct user_namespace *user_ns;
> +	struct task_struct *task;
>  	const struct cred *c;
>  	__u64 mask;
> -#ifdef CONFIG_CGROUPS
> -	struct cgroup *cgrp;
> -#endif
> =20
>  	if (!uinfo)
>  		return -EINVAL;
> @@ -248,6 +260,37 @@ static long pidfd_info(struct task_struct *task, uns=
igned int cmd, unsigned long
>  	if (copy_from_user(&mask, &uinfo->mask, sizeof(mask)))
>  		return -EFAULT;
> =20
> +	task =3D get_pid_task(pid, PIDTYPE_PID);
> +	if (!task) {
> +		if (!(mask & PIDFD_INFO_EXIT))
> +			return -ESRCH;
> +
> +		if (!current_in_pidns(pid))
> +			return -ESRCH;
> +	}
> +
> +	if (mask & PIDFD_INFO_EXIT) {
> +		exit_info =3D READ_ONCE(pidfs_i(inode)->exit_info);
> +		if (exit_info) {
> +#ifdef CONFIG_CGROUPS
> +			kinfo.cgroupid =3D exit_info->cgroupid;
> +			kinfo.mask |=3D PIDFD_INFO_EXIT | PIDFD_INFO_CGROUPID;
> +#endif
> +			kinfo.exit_code =3D exit_info->exit_code;
> +		}
> +	}
> +
> +	/*
> +	 * If the task has already been reaped only exit information
> +	 * can be provided. It's entirely possible that the task has
> +	 * already been reaped but we managed to grab a reference to it
> +	 * before that. So a full set of information about @task doesn't
> +	 * mean it hasn't been waited upon. Similarly, a full set of
> +	 * information doesn't mean that the task hasn't already exited.
> +	 */
> +	if (!task)
> +		goto copy_out;
> +
>  	c =3D get_task_cred(task);
>  	if (!c)
>  		return -ESRCH;
> @@ -267,11 +310,15 @@ static long pidfd_info(struct task_struct *task, un=
signed int cmd, unsigned long
>  	put_cred(c);
> =20
>  #ifdef CONFIG_CGROUPS
> -	rcu_read_lock();
> -	cgrp =3D task_dfl_cgroup(task);
> -	kinfo.cgroupid =3D cgroup_id(cgrp);
> -	kinfo.mask |=3D PIDFD_INFO_CGROUPID;
> -	rcu_read_unlock();
> +	if (!kinfo.cgroupid) {
> +		struct cgroup *cgrp;
> +
> +		rcu_read_lock();
> +		cgrp =3D task_dfl_cgroup(task);
> +		kinfo.cgroupid =3D cgroup_id(cgrp);
> +		kinfo.mask |=3D PIDFD_INFO_CGROUPID;
> +		rcu_read_unlock();
> +	}
>  #endif
> =20
>  	/*
> @@ -291,6 +338,7 @@ static long pidfd_info(struct task_struct *task, unsi=
gned int cmd, unsigned long
>  	if (kinfo.pid =3D=3D 0 || kinfo.tgid =3D=3D 0 || (kinfo.ppid =3D=3D 0 &=
& kinfo.pid !=3D 1))
>  		return -ESRCH;
> =20
> +copy_out:
>  	/*
>  	 * If userspace and the kernel have the same struct size it can just
>  	 * be copied. If userspace provides an older struct, only the bits that
> @@ -325,7 +373,6 @@ static long pidfd_ioctl(struct file *file, unsigned i=
nt cmd, unsigned long arg)
>  {
>  	struct task_struct *task __free(put_task) =3D NULL;
>  	struct nsproxy *nsp __free(put_nsproxy) =3D NULL;
> -	struct pid *pid =3D pidfd_pid(file);
>  	struct ns_common *ns_common =3D NULL;
>  	struct pid_namespace *pid_ns;
> =20
> @@ -340,13 +387,13 @@ static long pidfd_ioctl(struct file *file, unsigned=
 int cmd, unsigned long arg)
>  		return put_user(file_inode(file)->i_generation, argp);
>  	}
> =20
> -	task =3D get_pid_task(pid, PIDTYPE_PID);
> -	if (!task)
> -		return -ESRCH;
> -
>  	/* Extensible IOCTL that does not open namespace FDs, take a shortcut *=
/
>  	if (_IOC_NR(cmd) =3D=3D _IOC_NR(PIDFD_GET_INFO))
> -		return pidfd_info(task, cmd, arg);
> +		return pidfd_info(file, cmd, arg);
> +
> +	task =3D get_pid_task(pidfd_pid(file), PIDTYPE_PID);
> +	if (!task)
> +		return -ESRCH;
> =20
>  	if (arg)
>  		return -EINVAL;
> @@ -479,10 +526,12 @@ void pidfs_exit(struct task_struct *tsk)
>  {
>  	struct dentry *dentry;
> =20
> +	might_sleep();
> +
>  	dentry =3D stashed_dentry_get(&task_pid(tsk)->stashed);
>  	if (dentry) {
>  		struct inode *inode =3D d_inode(dentry);
> -		struct pidfs_exit_info *exit_info =3D &pidfs_i(inode)->exit_info;
> +		struct pidfs_exit_info *exit_info =3D &pidfs_i(inode)->__pei;
>  #ifdef CONFIG_CGROUPS
>  		struct cgroup *cgrp;
> =20
> @@ -493,6 +542,8 @@ void pidfs_exit(struct task_struct *tsk)
>  #endif
>  		exit_info->exit_code =3D tsk->exit_code;
> =20
> +		/* Ensure that PIDFD_GET_INFO sees either all or nothing. */
> +		smp_store_release(&pidfs_i(inode)->exit_info, &pidfs_i(inode)->__pei);
>  		dput(dentry);
>  	}
>  }
> @@ -560,7 +611,8 @@ static struct inode *pidfs_alloc_inode(struct super_b=
lock *sb)
>  	if (!pi)
>  		return NULL;
> =20
> -	memset(&pi->exit_info, 0, sizeof(pi->exit_info));
> +	memset(&pi->__pei, 0, sizeof(pi->__pei));
> +	pi->exit_info =3D NULL;
> =20
>  	return &pi->vfs_inode;
>  }
> diff --git a/include/uapi/linux/pidfd.h b/include/uapi/linux/pidfd.h
> index e0abd0b18841..e5966f1a7743 100644
> --- a/include/uapi/linux/pidfd.h
> +++ b/include/uapi/linux/pidfd.h
> @@ -20,6 +20,7 @@
>  #define PIDFD_INFO_PID			(1UL << 0) /* Always returned, even if not requ=
ested */
>  #define PIDFD_INFO_CREDS		(1UL << 1) /* Always returned, even if not req=
uested */
>  #define PIDFD_INFO_CGROUPID		(1UL << 2) /* Always returned if available,=
 even if not requested */
> +#define PIDFD_INFO_EXIT			(1UL << 3) /* Always returned if available, ev=
en if not requested */
> =20
>  #define PIDFD_INFO_SIZE_VER0		64 /* sizeof first published struct */
> =20
> @@ -86,7 +87,7 @@ struct pidfd_info {
>  	__u32 sgid;
>  	__u32 fsuid;
>  	__u32 fsgid;
> -	__u32 spare0[1];
> +	__s32 exit_code;
>  };
> =20
>  #define PIDFS_IOCTL_MAGIC 0xFF
> diff --git a/kernel/exit.c b/kernel/exit.c
> index 98d292120296..9916305e34d3 100644
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -250,12 +250,12 @@ void release_task(struct task_struct *p)
>  	dec_rlimit_ucounts(task_ucounts(p), UCOUNT_RLIMIT_NPROC, 1);
>  	rcu_read_unlock();
> =20
> +	pidfs_exit(p);
>  	cgroup_release(p);
> =20
>  	write_lock_irq(&tasklist_lock);
>  	ptrace_release_task(p);
>  	thread_pid =3D get_pid(p->thread_pid);
> -	pidfs_exit(p);

Why move this after you just added it?

>  	__exit_signal(p);
> =20
>  	/*
>=20

Everything else looks fine though. Assuming you fix the nit above, you
can add:

Reviewed-by: Jeff Layton <jlayton@kernel.org>

