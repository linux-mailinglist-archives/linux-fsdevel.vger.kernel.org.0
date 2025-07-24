Return-Path: <linux-fsdevel+bounces-55921-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C275FB101AD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jul 2025 09:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1923AC17DB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jul 2025 07:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F159A238C1A;
	Thu, 24 Jul 2025 07:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hwT+W3vm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479CF23185E;
	Thu, 24 Jul 2025 07:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753341924; cv=none; b=SBM3JZtssH5sTIni2oaxTKgUeMNvp8sp+1W9srb0UNU0yuh9mvPdbA3hbIgooF/2DYuoTs6t0okYQwtQsDqirYeXjgkOpQIoja3MFD6+ODHXDCwaSHB8rTD+UF63DTDDkslJ0IZPsBtdcV+wTlRnS1oZZj1oROdb49Rwsu6Bin8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753341924; c=relaxed/simple;
	bh=ftERaJ4090HGPKp9um5iGce89kJm6Bv+mDMMqTyhr/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XKOSm8g1Jx2kxxsNZfL9w3c+8BWw9IcqA7QhefEhDjk4dRj5+4nkYyMmsmeQavrCT0Y3J8qrBzA3jcSU2PmlfxXt7kons66irHpayY0HTwiA0+FUjNY0jYaIlpIt/fZYz50zAcmZaqRPqp4nClxJb6rkVAWsXXJa4WS3KV/iWG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hwT+W3vm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A468C4CEF1;
	Thu, 24 Jul 2025 07:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753341923;
	bh=ftERaJ4090HGPKp9um5iGce89kJm6Bv+mDMMqTyhr/g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hwT+W3vmgMiDaaWGe9nffKw2Wy5TMJsjNanMFLYjsmuhlEbExD87OS5iTmRghletE
	 8d8fknPRfhruT8MKehkeD7kJRxOL+e+vmA12evg6BibdNx989nt0sZIQBC6IYswHOV
	 4+NbUOGXnf2h2jCv1to7O8rMecvF9sBCRmpXp9tmuuxxw6yEeCF7qaBUvnqdauh4so
	 3W72DDXPmxnoDCgxz3tSGKM/KoP2dRO0IEAPmVSx2qTbcK2JNsZ/Q0wbLFJyWAI0EZ
	 RhTSens9nlCAvvWL1mRsXuObvZaVu5vix1qtOkJj0tMj0Mb/c4H4oLtDjjY/r5Gxy4
	 Z3bUuHUkUIaNw==
Date: Thu, 24 Jul 2025 09:25:19 +0200
From: Christian Brauner <brauner@kernel.org>
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC v2 2/4] procfs: add "pidns" mount option
Message-ID: <20250724-ammoniak-gepinselt-6dd6255c2368@brauner>
References: <20250723-procfs-pidns-api-v2-0-621e7edd8e40@cyphar.com>
 <20250723-procfs-pidns-api-v2-2-621e7edd8e40@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250723-procfs-pidns-api-v2-2-621e7edd8e40@cyphar.com>

On Wed, Jul 23, 2025 at 09:18:52AM +1000, Aleksa Sarai wrote:
> Since the introduction of pid namespaces, their interaction with procfs
> has been entirely implicit in ways that require a lot of dancing around
> by programs that need to construct sandboxes with different PID
> namespaces.
> 
> Being able to explicitly specify the pid namespace to use when
> constructing a procfs super block will allow programs to no longer need
> to fork off a process which does then does unshare(2) / setns(2) and
> forks again in order to construct a procfs in a pidns.
> 
> So, provide a "pidns" mount option which allows such users to just
> explicitly state which pid namespace they want that procfs instance to
> use. This interface can be used with fsconfig(2) either with a file
> descriptor or a path:
> 
>   fsconfig(procfd, FSCONFIG_SET_FD, "pidns", NULL, nsfd);
>   fsconfig(procfd, FSCONFIG_SET_STRING, "pidns", "/proc/self/ns/pid", 0);

Fwiw, namespace mount options could just be VFS generic mount options.
But it's not something that we need to solve right now.

> 
> or with classic mount(2) / mount(8):
> 
>   // mount -t proc -o pidns=/proc/self/ns/pid proc /tmp/proc
>   mount("proc", "/tmp/proc", "proc", MS_..., "pidns=/proc/self/ns/pid");
> 
> As this new API is effectively shorthand for setns(2) followed by
> mount(2), the permission model for this mirrors pidns_install() to avoid
> opening up new attack surfaces by loosening the existing permission
> model.
> 
> Note that the mount infrastructure also allows userspace to reconfigure
> the pidns of an existing procfs mount, which may or may not be useful to
> some users.
> 
> Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
> ---
>  Documentation/filesystems/proc.rst |  6 +++
>  fs/proc/root.c                     | 90 +++++++++++++++++++++++++++++++++++---
>  2 files changed, 90 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
> index 5236cb52e357..c520b9f8a3fd 100644
> --- a/Documentation/filesystems/proc.rst
> +++ b/Documentation/filesystems/proc.rst
> @@ -2360,6 +2360,7 @@ The following mount options are supported:
>  	hidepid=	Set /proc/<pid>/ access mode.
>  	gid=		Set the group authorized to learn processes information.
>  	subset=		Show only the specified subset of procfs.
> +	pidns=		Specify a the namespace used by this procfs.
>  	=========	========================================================
>  
>  hidepid=off or hidepid=0 means classic mode - everybody may access all
> @@ -2392,6 +2393,11 @@ information about processes information, just add identd to this group.
>  subset=pid hides all top level files and directories in the procfs that
>  are not related to tasks.
>  
> +pidns= specifies a pid namespace (either as a string path to something like
> +`/proc/$pid/ns/pid`, or a file descriptor when using `FSCONFIG_SET_FD`) that
> +will be used by the procfs instance when translating pids. By default, procfs
> +will use the calling process's active pid namespace.
> +
>  Chapter 5: Filesystem behavior
>  ==============================
>  
> diff --git a/fs/proc/root.c b/fs/proc/root.c
> index ed86ac710384..057c8a125c6e 100644
> --- a/fs/proc/root.c
> +++ b/fs/proc/root.c
> @@ -38,12 +38,18 @@ enum proc_param {
>  	Opt_gid,
>  	Opt_hidepid,
>  	Opt_subset,
> +#ifdef CONFIG_PID_NS
> +	Opt_pidns,
> +#endif
>  };
>  
>  static const struct fs_parameter_spec proc_fs_parameters[] = {
> -	fsparam_u32("gid",	Opt_gid),
> +	fsparam_u32("gid",		Opt_gid),
>  	fsparam_string("hidepid",	Opt_hidepid),
>  	fsparam_string("subset",	Opt_subset),
> +#ifdef CONFIG_PID_NS
> +	fsparam_file_or_string("pidns",	Opt_pidns),
> +#endif
>  	{}
>  };
>  
> @@ -109,11 +115,67 @@ static int proc_parse_subset_param(struct fs_context *fc, char *value)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_PID_NS
> +static int proc_parse_pidns_param(struct fs_context *fc,
> +				  struct fs_parameter *param,
> +				  struct fs_parse_result *result)
> +{
> +	struct proc_fs_context *ctx = fc->fs_private;
> +	struct pid_namespace *target, *active = task_active_pid_ns(current);
> +	struct ns_common *ns;
> +	struct file *ns_filp __free(fput) = NULL;
> +
> +	switch (param->type) {
> +	case fs_value_is_file:
> +		/* came throug fsconfig, steal the file reference */
> +		ns_filp = param->file;
> +		param->file = NULL;

This can be shortened to:

ns_filp = no_free_ptr(param->file);

> +		break;
> +	case fs_value_is_string:
> +		ns_filp = filp_open(param->string, O_RDONLY, 0);
> +		break;
> +	default:
> +		WARN_ON_ONCE(true);
> +		break;
> +	}
> +	if (!ns_filp)
> +		ns_filp = ERR_PTR(-EBADF);
> +	if (IS_ERR(ns_filp)) {
> +		errorfc(fc, "could not get file from pidns argument");
> +		return PTR_ERR(ns_filp);
> +	}
> +
> +	if (!proc_ns_file(ns_filp))
> +		return invalfc(fc, "pidns argument is not an nsfs file");
> +	ns = get_proc_ns(file_inode(ns_filp));
> +	if (ns->ops->type != CLONE_NEWPID)
> +		return invalfc(fc, "pidns argument is not a pidns file");
> +	target = container_of(ns, struct pid_namespace, ns);
> +
> +	/*
> +	 * pidns= is shorthand for joining the pidns to get a fsopen fd, so the
> +	 * permission model should be the same as pidns_install().
> +	 */
> +	if (!ns_capable(target->user_ns, CAP_SYS_ADMIN)) {
> +		errorfc(fc, "insufficient permissions to set pidns");
> +		return -EPERM;
> +	}
> +	if (!pidns_is_ancestor(target, active))
> +		return invalfc(fc, "cannot set pidns to non-descendant pidns");

This made me think. If one rewrote this as:

if (!ns_capable(task_active_pidns(current)->user_ns, CAP_SYS_ADMIN))

if (!pidns_is_ancestor(target, active))

that would also work, right? IOW, you'd be checking whether you're
capable over your current pid namespace owning userns and if the target
pidns is an ancestor it's also implied by the first check that you're
capable over it.

The only way this would not be true is if a descendant pidns would be
owned by a userns over which you don't hold privileges and I wondered
whether that's even possible? I don't think it is but maybe you see a
way.

> +
> +	put_pid_ns(ctx->pid_ns);
> +	ctx->pid_ns = get_pid_ns(target);
> +	put_user_ns(fc->user_ns);
> +	fc->user_ns = get_user_ns(ctx->pid_ns->user_ns);
> +	return 0;
> +}
> +#endif /* CONFIG_PID_NS */
> +
>  static int proc_parse_param(struct fs_context *fc, struct fs_parameter *param)
>  {
>  	struct proc_fs_context *ctx = fc->fs_private;
>  	struct fs_parse_result result;
> -	int opt;
> +	int opt, err;
>  
>  	opt = fs_parse(fc, proc_fs_parameters, param, &result);
>  	if (opt < 0)
> @@ -125,14 +187,24 @@ static int proc_parse_param(struct fs_context *fc, struct fs_parameter *param)
>  		break;
>  
>  	case Opt_hidepid:
> -		if (proc_parse_hidepid_param(fc, param))
> -			return -EINVAL;
> +		err = proc_parse_hidepid_param(fc, param);
> +		if (err)
> +			return err;
>  		break;
>  
>  	case Opt_subset:
> -		if (proc_parse_subset_param(fc, param->string) < 0)
> -			return -EINVAL;
> +		err = proc_parse_subset_param(fc, param->string);
> +		if (err)
> +			return err;
> +		break;
> +
> +#ifdef CONFIG_PID_NS
> +	case Opt_pidns:

I think it would be easier if we returned EOPNOTSUPP when !CONFIG_PID_NS
instead of EINVALing this?

> +		err = proc_parse_pidns_param(fc, param, &result);
> +		if (err)
> +			return err;
>  		break;
> +#endif
>  
>  	default:
>  		return -EINVAL;
> @@ -154,6 +226,12 @@ static void proc_apply_options(struct proc_fs_info *fs_info,
>  		fs_info->hide_pid = ctx->hidepid;
>  	if (ctx->mask & (1 << Opt_subset))
>  		fs_info->pidonly = ctx->pidonly;
> +#ifdef CONFIG_PID_NS
> +	if (ctx->mask & (1 << Opt_pidns)) {
> +		put_pid_ns(fs_info->pid_ns);
> +		fs_info->pid_ns = get_pid_ns(ctx->pid_ns);
> +	}
> +#endif
>  }
>  
>  static int proc_fill_super(struct super_block *s, struct fs_context *fc)
> 
> -- 
> 2.50.0
> 

