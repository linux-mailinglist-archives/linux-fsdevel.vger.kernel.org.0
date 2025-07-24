Return-Path: <linux-fsdevel+bounces-55924-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E997BB101F6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jul 2025 09:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3E857A63FC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jul 2025 07:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6385B25EFBB;
	Thu, 24 Jul 2025 07:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vDGK8z7n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC142227E82;
	Thu, 24 Jul 2025 07:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753342505; cv=none; b=NVnx2yqzWCDvRszX59kK/qZp6iC4b6HRXc5Rt6jz8SlyamIy4poAUqHv2hmgG4uILYm3WjQq6v8hgxwywdkCTLa/D+m06iWI85HHswzR6ltLBEASaPjC1LOoOhOlakd3v/j4E0NpJXDbx62QvqA5Xd/rGi5dyKPMIBrwipuf/xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753342505; c=relaxed/simple;
	bh=boX6F5sei7MSmTCCIbj4GWW0P15W+4DPD72x6Bq1I3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iGsWkyQTSc3b6kUvitXg1N4CrIu1vNL2OECUnX0hY4C+2mFzo59rWnG4qK2eWe19fK45m1JHV8fNsk8KDBfuuWALyJCfqDL2n9/7wgTOpv6PG1Xmdr0fR/w1MeuJUG8NbpiNwwiIC2eytvf5AGfWcN28rlXwah9reQtzajWjOmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vDGK8z7n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99461C4CEED;
	Thu, 24 Jul 2025 07:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753342505;
	bh=boX6F5sei7MSmTCCIbj4GWW0P15W+4DPD72x6Bq1I3A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vDGK8z7nlGmYaHnCxcqVnJ1kW0ynINthtc+Vnr4An3Ml+zFdDkPM6HtPU0OBe9mkJ
	 MyqIIBtzcRveSTqHycPhkBxHtshe2IpgCap3RcbyrH4KDB7o42ANfYJmAK2KNuzxJO
	 J/7ZKIMJwd1g19tC43Q7lsMPTFNVeGk+P+UgL9rqmo7GukwNCzJfigkFL0a+aaAcdc
	 7mS+kPTUkVDTFD8TP/ikNG9qcEQj9OU8ggPCvzbbBBgcxjUzObRyJnyOEIyBgHpRol
	 5xRZj0tsTgz3kp/NDHDvXaJVlXp8tZM74fPh9O9eQL8sZeBiOsZ7+VZ/3C6EeYNltG
	 fQYCtF9PtGkAQ==
Date: Thu, 24 Jul 2025 09:34:59 +0200
From: Christian Brauner <brauner@kernel.org>
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC v2 3/4] procfs: add PROCFS_GET_PID_NAMESPACE ioctl
Message-ID: <20250724-beobachten-verfassen-9a39c0318341@brauner>
References: <20250723-procfs-pidns-api-v2-0-621e7edd8e40@cyphar.com>
 <20250723-procfs-pidns-api-v2-3-621e7edd8e40@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250723-procfs-pidns-api-v2-3-621e7edd8e40@cyphar.com>

On Wed, Jul 23, 2025 at 09:18:53AM +1000, Aleksa Sarai wrote:
> /proc has historically had very opaque semantics about PID namespaces,
> which is a little unfortunate for container runtimes and other programs
> that deal with switching namespaces very often. One common issue is that
> of converting between PIDs in the process's namespace and PIDs in the
> namespace of /proc.
> 
> In principle, it is possible to do this today by opening a pidfd with
> pidfd_open(2) and then looking at /proc/self/fdinfo/$n (which will
> contain a PID value translated to the pid namespace associated with that
> procfs superblock). However, allocating a new file for each PID to be
> converted is less than ideal for programs that may need to scan procfs,
> and it is generally useful for userspace to be able to finally get this
> information from procfs.
> 
> So, add a new API for this in the form of an ioctl(2) you can call on
> the root directory of procfs. The returned file descriptor will have
> O_CLOEXEC set. This acts as a sister feature to the new "pidns" mount
> option, finally allowing userspace full control of the pid namespaces
> associated with procfs instances.
> 
> The permission model for this is a bit looser than that of the "pidns"
> mount option, but this is mainly because /proc/1/ns/pid provides the
> same information, so as long as you have access to that magic-link (or
> something equivalently reasonable such as privileges with CAP_SYS_ADMIN
> or being in an ancestor pid namespace) it makes sense to allow userspace
> to grab a handle. setns(2) will still have their own permission checks,
> so being able to open a pidns handle doesn't really provide too many
> other capabilities.
> 
> Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
> ---
>  Documentation/filesystems/proc.rst |  4 +++
>  fs/proc/root.c                     | 54 ++++++++++++++++++++++++++++++++++++--
>  include/uapi/linux/fs.h            |  3 +++
>  3 files changed, 59 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
> index c520b9f8a3fd..506383273c9d 100644
> --- a/Documentation/filesystems/proc.rst
> +++ b/Documentation/filesystems/proc.rst
> @@ -2398,6 +2398,10 @@ pidns= specifies a pid namespace (either as a string path to something like
>  will be used by the procfs instance when translating pids. By default, procfs
>  will use the calling process's active pid namespace.
>  
> +Processes can check which pid namespace is used by a procfs instance by using
> +the `PROCFS_GET_PID_NAMESPACE` ioctl() on the root directory of the procfs
> +instance.
> +
>  Chapter 5: Filesystem behavior
>  ==============================
>  
> diff --git a/fs/proc/root.c b/fs/proc/root.c
> index 057c8a125c6e..548a57ec2152 100644
> --- a/fs/proc/root.c
> +++ b/fs/proc/root.c
> @@ -23,8 +23,10 @@
>  #include <linux/cred.h>
>  #include <linux/magic.h>
>  #include <linux/slab.h>
> +#include <linux/ptrace.h>
>  
>  #include "internal.h"
> +#include "../internal.h"
>  
>  struct proc_fs_context {
>  	struct pid_namespace	*pid_ns;
> @@ -418,15 +420,63 @@ static int proc_root_readdir(struct file *file, struct dir_context *ctx)
>  	return proc_pid_readdir(file, ctx);
>  }
>  
> +static long int proc_root_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
> +{
> +	switch (cmd) {
> +#ifdef CONFIG_PID_NS
> +	case PROCFS_GET_PID_NAMESPACE: {
> +		struct pid_namespace *active = task_active_pid_ns(current);
> +		struct pid_namespace *ns = proc_pid_ns(file_inode(filp)->i_sb);
> +		bool can_access_pidns = false;
> +
> +		/*
> +		 * If we are in an ancestors of the pidns, or have join
> +		 * privileges (CAP_SYS_ADMIN), then it makes sense that we
> +		 * would be able to grab a handle to the pidns.
> +		 *
> +		 * Otherwise, if there is a root process, then being able to
> +		 * access /proc/$pid/ns/pid is equivalent to this ioctl and so
> +		 * we should probably match the permission model. For empty
> +		 * namespaces it seems unlikely for there to be a downside to
> +		 * allowing unprivileged users to open a handle to it (setns
> +		 * will fail for unprivileged users anyway).
> +		 */
> +		can_access_pidns = pidns_is_ancestor(ns, active) ||
> +				   ns_capable(ns->user_ns, CAP_SYS_ADMIN);

This seems to imply that if @ns is a descendant of @active that the
caller holds privileges over it. Is that actually always true?

IOW, why is the check different from the previous pidns= mount option
check. I would've expected:

ns_capable(_no_audit)(ns->user_ns) && pidns_is_ancestor(ns, active)

and then the ptrace check as a fallback.

> +		if (!can_access_pidns) {
> +			bool cannot_ptrace_pid1 = false;
> +
> +			read_lock(&tasklist_lock);
> +			if (ns->child_reaper)
> +				cannot_ptrace_pid1 = ptrace_may_access(ns->child_reaper,
> +								       PTRACE_MODE_READ_FSCREDS);
> +			read_unlock(&tasklist_lock);
> +			can_access_pidns = !cannot_ptrace_pid1;
> +		}
> +		if (!can_access_pidns)
> +			return -EPERM;
> +
> +		/* open_namespace() unconditionally consumes the reference. */
> +		get_pid_ns(ns);
> +		return open_namespace(to_ns_common(ns));
> +	}
> +#endif /* CONFIG_PID_NS */
> +	default:
> +		return -ENOIOCTLCMD;
> +	}
> +}
> +
>  /*
>   * The root /proc directory is special, as it has the
>   * <pid> directories. Thus we don't use the generic
>   * directory handling functions for that..
>   */
>  static const struct file_operations proc_root_operations = {
> -	.read		 = generic_read_dir,
> -	.iterate_shared	 = proc_root_readdir,
> +	.read		= generic_read_dir,
> +	.iterate_shared	= proc_root_readdir,
>  	.llseek		= generic_file_llseek,
> +	.unlocked_ioctl = proc_root_ioctl,
> +	.compat_ioctl   = compat_ptr_ioctl,
>  };
>  
>  /*
> diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> index 0bd678a4a10e..aa642cb48feb 100644
> --- a/include/uapi/linux/fs.h
> +++ b/include/uapi/linux/fs.h
> @@ -437,6 +437,9 @@ typedef int __bitwise __kernel_rwf_t;
>  
>  #define PROCFS_IOCTL_MAGIC 'f'
>  
> +/* procfs root ioctls */
> +#define PROCFS_GET_PID_NAMESPACE	_IO(PROCFS_IOCTL_MAGIC, 1)
> +
>  /* Pagemap ioctl */
>  #define PAGEMAP_SCAN	_IOWR(PROCFS_IOCTL_MAGIC, 16, struct pm_scan_arg)
>  
> 
> -- 
> 2.50.0
> 

