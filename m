Return-Path: <linux-fsdevel+bounces-42898-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B693A4B191
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Mar 2025 13:33:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFAC23AC0E5
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Mar 2025 12:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F34001DBB38;
	Sun,  2 Mar 2025 12:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NLX10IWc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF91FC0E
	for <linux-fsdevel@vger.kernel.org>; Sun,  2 Mar 2025 12:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740918820; cv=none; b=e8TjAA4pdFQ5Iqqi0y8MoTU9XfDjW7l32yZtU6lx5nT7920xQKUIFjcMHGqdRGuj3T+3VcF7Q/AocSS/nkpg3V3MrdOloH6gSe8mBiU6yw32ytc1OJDnf2IW/nBAEeU0xnemt9pTqWgSH756xnOUeWvekVtdHLLUsdkEZ7Y5Rx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740918820; c=relaxed/simple;
	bh=JpIs7x4Zfg99kHbTl74/hyNujkpQoLQtHod0kBP7LEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ok7BAEURrPD5Lq7qncAJc+Gw0H4m8XsZWMgt9YM7Y00MRrjwX4xHtviiZ7OrX7HiWcacM5ixmsoSpCUWtMkXfDYD6qIbMggOnYWPdjXOk7K51AxHxkHm1KwUS0DMWBsK8uFil20DzWn+8b4v4X+hEJBoYFLGtb6/Izi2WvkVYWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NLX10IWc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F119AC4CED6;
	Sun,  2 Mar 2025 12:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740918819;
	bh=JpIs7x4Zfg99kHbTl74/hyNujkpQoLQtHod0kBP7LEQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NLX10IWcBj7Jo7/tsM+eyWE1OjW/yl3BB7YsvnAQoXXW7+hqZSfKvSPrQvbaXvE4T
	 GFH0HgduveJy9Skl2iU1Xjb1IOKmIcG9gVi9utZaE2IK1MzGIH1cJpjDWanYQneJWv
	 KCS0UWuTh4Kp6s33J40kYznm0L6NQcNX2wyeYvKbAVPgAO6TJ3I/w641+qqYE7wtEP
	 6bPSNtbC2DKXvHGgYMBC4z0SDbkZnJRtXU7cd6Mk+RWzitreGRM/Oo6fAG14OwImbQ
	 szhdHgUwaMZFaWOyXQMBR0oqNUqF+wqH13kq9tqnxA9Va6HRF5aMl7JtpuYMvtin3v
	 ZPkleVBuJPEnQ==
Date: Sun, 2 Mar 2025 13:33:35 +0100
From: Christian Brauner <brauner@kernel.org>
To: Mike Yuan <me@yhndnzj.com>
Cc: "oleg@redhat.com" <oleg@redhat.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "jlayton@kernel.org" <jlayton@kernel.org>, 
	"lennart@poettering.net" <lennart@poettering.net>, "daan.j.demeyer@gmail.com" <daan.j.demeyer@gmail.com>
Subject: Re: [PATCH RFC 06/10] pidfs: allow to retrieve exit information
Message-ID: <20250302-unfreiwillig-auferlegen-59d076937020@brauner>
References: <20250228-work-pidfs-kill_on_last_close-v1-0-5bd7e6bb428e@kernel.org>
 <20250228-work-pidfs-kill_on_last_close-v1-6-5bd7e6bb428e@kernel.org>
 <PigydyZoBgz1RFKczs1bdoqAZ_78rpjO1GBZLInZupvPRSLnqu3T9HxUdOrskXFBKCf3tXaIO9f9t2n13Pxf8Nu9Gq8JEl1WaxFwgJpdQb4=@yhndnzj.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <PigydyZoBgz1RFKczs1bdoqAZ_78rpjO1GBZLInZupvPRSLnqu3T9HxUdOrskXFBKCf3tXaIO9f9t2n13Pxf8Nu9Gq8JEl1WaxFwgJpdQb4=@yhndnzj.com>

On Sun, Mar 02, 2025 at 02:40:16AM +0000, Mike Yuan wrote:
> On 2/28/25 13:44, Christian Brauner <brauner@kernel.org> wrote:
> 
> >  Some tools like systemd's jounral need to retrieve the exit and cgroup
> >  information after a process has already been reaped. This can e.g.,
> >  happen when retrieving a pidfd via SCM_PIDFD or SCM_PEERPIDFD.
> >  
> >  Signed-off-by: Christian Brauner <brauner@kernel.org>
> >  ---
> >   fs/pidfs.c                 | 70 +++++++++++++++++++++++++++++++++++++---------
> >   include/uapi/linux/pidfd.h |  3 +-
> >   2 files changed, 59 insertions(+), 14 deletions(-)
> >  
> >  diff --git a/fs/pidfs.c b/fs/pidfs.c
> >  index 433f676c066c..e500bc4c5af2 100644
> >  --- a/fs/pidfs.c
> >  +++ b/fs/pidfs.c
> >  @@ -32,11 +32,12 @@ static struct kmem_cache *pidfs_cachep __ro_after_init;
> >    */
> >   struct pidfs_exit_info {
> >   	__u64 cgroupid;
> >  -	__u64 exit_code;
> >  +	__s32 exit_code;
> >   };
> >  
> >   struct pidfs_inode {
> >  -	struct pidfs_exit_info exit_info;
> >  +	struct pidfs_exit_info __pei;
> >  +	struct pidfs_exit_info *exit_info;
> >   	struct inode vfs_inode;
> >   };
> >  
> >  @@ -228,11 +229,14 @@ static __poll_t pidfd_poll(struct file *file, struct poll_table_struct *pts)
> >   	return poll_flags;
> >   }
> >  
> >  -static long pidfd_info(struct task_struct *task, unsigned int cmd, unsigned long arg)
> >  +static long pidfd_info(struct file *file, struct task_struct *task,
> >  +		       unsigned int cmd, unsigned long arg)
> >   {
> >   	struct pidfd_info __user *uinfo = (struct pidfd_info __user *)arg;
> >   	size_t usize = _IOC_SIZE(cmd);
> >   	struct pidfd_info kinfo = {};
> >  +	struct pidfs_exit_info *exit_info;
> >  +	struct inode *inode = file_inode(file);
> >   	struct user_namespace *user_ns;
> >   	const struct cred *c;
> >   	__u64 mask;
> >  @@ -248,6 +252,39 @@ static long pidfd_info(struct task_struct *task, unsigned int cmd, unsigned long
> >   	if (copy_from_user(&mask, &uinfo->mask, sizeof(mask)))
> >   		return -EFAULT;
> >  
> >  +	exit_info = READ_ONCE(pidfs_i(inode)->exit_info);
> >  +	if (exit_info) {
> >  +		/*
> >  +		 * TODO: Oleg, I didn't see a reason for putting
> >  +		 * retrieval of the exit status of a task behind some
> >  +		 * form of permission check. Maybe there's some
> >  +		 * potential concerns with seeing the exit status of a
> >  +		 * SIGKILLed suid binary or something but even then I'm
> >  +		 * not sure that's a problem.
> >  +		 *
> >  +		 * If we want this we could put this behind some *uid
> >  +		 * check similar to what ptrace access does by recording
> >  +		 * parts of the creds we'd need for checking this. But
> >  +		 * only if we really need it.
> >  +		 */
> >  +		kinfo.exit_code = exit_info->exit_code;
> >  +#ifdef CONFIG_CGROUPS
> >  +		kinfo.cgroupid = exit_info->cgroupid;
> >  +		kinfo.mask |= PIDFD_INFO_EXIT | PIDFD_INFO_CGROUPID;
> >  +#endif
> >  +	}
> >  +
> >  +	/*
> >  +	 * If the task has already been reaped only exit information
> >  +	 * can be provided. It's entirely possible that the task has
> >  +	 * already been reaped but we managed to grab a reference to it
> >  +	 * before that. So a full set of information about @task doesn't
> >  +	 * mean it hasn't been waited upon. Similarly, a full set of
> >  +	 * information doesn't mean that the task hasn't already exited.
> >  +	 */
> >  +	if (!task)
> >  +		goto copy_out;
> >  +
> >   	c = get_task_cred(task);
> >   	if (!c)
> >   		return -ESRCH;
> >  @@ -267,11 +304,13 @@ static long pidfd_info(struct task_struct *task, unsigned int cmd, unsigned long
> >   	put_cred(c);
> >  
> >   #ifdef CONFIG_CGROUPS
> >  -	rcu_read_lock();
> >  -	cgrp = task_dfl_cgroup(task);
> >  -	kinfo.cgroupid = cgroup_id(cgrp);
> >  -	kinfo.mask |= PIDFD_INFO_CGROUPID;
> >  -	rcu_read_unlock();
> >  +	if (!kinfo.cgroupid) {
> >  +		rcu_read_lock();
> >  +		cgrp = task_dfl_cgroup(task);
> >  +		kinfo.cgroupid = cgroup_id(cgrp);
> >  +		kinfo.mask |= PIDFD_INFO_CGROUPID;
> >  +		rcu_read_unlock();
> >  +	}
> >   #endif
> >  
> >   	/*
> >  @@ -291,6 +330,7 @@ static long pidfd_info(struct task_struct *task, unsigned int cmd, unsigned long
> >   	if (kinfo.pid == 0 || kinfo.tgid == 0 || (kinfo.ppid == 0 && kinfo.pid != 1))
> >   		return -ESRCH;
> >  
> >  +copy_out:
> >   	/*
> >   	 * If userspace and the kernel have the same struct size it can just
> >   	 * be copied. If userspace provides an older struct, only the bits that
> >  @@ -341,12 +381,13 @@ static long pidfd_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
> >   	}
> >  
> >   	task = get_pid_task(pid, PIDTYPE_PID);
> >  -	if (!task)
> >  -		return -ESRCH;
> 
> Hmm, this breaks our current assumption/assertion on the API in
> systemd (see pidfd_get_pid_ioctl() in basic/pidfd-util.c).
> Moreover, it now imposes an inconsistency: if the pidfd refers to a
> process from foreign pidns, the current impl treats it as if the
> process didn't exist, and returns -ESRCH. Now a truly exited task
> deviates from that...

Thanks for spotting that. It should not be possible to retrieve
PIDFD_INFO_EXIT if the dead task is outside the pid namespace hierarchy.
That's easy to handle though.

> 
> I'd prefer to retain the current behavior of returning -ESRCH unless
> PIDFD_INFO_EXIT is specified in mask, in which case it's then
> guaranteed that -ESRCH would never be seen. IOW the caller should be
> explicit on what they want, which feels semantically more reasonable
> to me and probably even simpler?

Sure.

> 
> >  
> >   	/* Extensible IOCTL that does not open namespace FDs, take a shortcut */
> >   	if (_IOC_NR(cmd) == _IOC_NR(PIDFD_GET_INFO))
> >  -		return pidfd_info(task, cmd, arg);
> >  +		return pidfd_info(file, task, cmd, arg);
> >  +
> >  +	if (!task)
> >  +		return -ESRCH;
> >  
> >   	if (arg)
> >   		return -EINVAL;
> >  @@ -486,7 +527,7 @@ void pidfs_exit(struct task_struct *tsk)
> >   		struct cgroup *cgrp;
> >   #endif
> >   		inode = d_inode(dentry);
> >  -		exit_info = &pidfs_i(inode)->exit_info;
> >  +		exit_info = &pidfs_i(inode)->__pei;
> >  
> >   		/* TODO: Annoy Oleg to tell me how to do this correctly. */
> >   		if (tsk->signal->flags & SIGNAL_GROUP_EXIT)
> >  @@ -501,6 +542,8 @@ void pidfs_exit(struct task_struct *tsk)
> >   		rcu_read_unlock();
> >   #endif
> >  
> >  +		/* Ensure that PIDFD_GET_INFO sees either all or nothing. */
> >  +		smp_store_release(&pidfs_i(inode)->exit_info, &pidfs_i(inode)->__pei);
> >   		dput(dentry);
> >   	}
> >   }
> >  @@ -568,7 +611,8 @@ static struct inode *pidfs_alloc_inode(struct super_block *sb)
> >   	if (!pi)
> >   		return NULL;
> >  
> >  -	memset(&pi->exit_info, 0, sizeof(pi->exit_info));
> >  +	memset(&pi->__pei, 0, sizeof(pi->__pei));
> >  +	pi->exit_info = NULL;
> >  
> >   	return &pi->vfs_inode;
> >   }
> >  diff --git a/include/uapi/linux/pidfd.h b/include/uapi/linux/pidfd.h
> >  index e0abd0b18841..e5966f1a7743 100644
> >  --- a/include/uapi/linux/pidfd.h
> >  +++ b/include/uapi/linux/pidfd.h
> >  @@ -20,6 +20,7 @@
> >   #define PIDFD_INFO_PID			(1UL << 0) /* Always returned, even if not requested */
> >   #define PIDFD_INFO_CREDS		(1UL << 1) /* Always returned, even if not requested */
> >   #define PIDFD_INFO_CGROUPID		(1UL << 2) /* Always returned if available, even if not requested */
> >  +#define PIDFD_INFO_EXIT			(1UL << 3) /* Always returned if available, even if not requested */
> >  
> >   #define PIDFD_INFO_SIZE_VER0		64 /* sizeof first published struct */
> >  
> >  @@ -86,7 +87,7 @@ struct pidfd_info {
> >   	__u32 sgid;
> >   	__u32 fsuid;
> >   	__u32 fsgid;
> >  -	__u32 spare0[1];
> >  +	__s32 exit_code;
> >   };
> >  
> >   #define PIDFS_IOCTL_MAGIC 0xFF
> >  
> >  --
> >  2.47.2
> >  
> >

