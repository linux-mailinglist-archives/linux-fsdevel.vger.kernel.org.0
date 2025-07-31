Return-Path: <linux-fsdevel+bounces-56382-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 933E2B16FA0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 12:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82E5017CB52
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 10:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A30C3225417;
	Thu, 31 Jul 2025 10:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sr61EaQQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D681118B47E;
	Thu, 31 Jul 2025 10:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753957906; cv=none; b=oYDRp3vvnvE0jTaZj+1sXx/9k9CFYhBProNMoTpn8Pev1VQYtfcmDi5GCO4+gyQgUe3q57+RG8XJ4+fkJrcPs/UJQlvT7qlNvRotL6hQ25twafngxB50tTEV7nBCHxFqwvAP/uAxUmjIK1Ylfuq3SpT0c0Pt0ui2UMXThkHLySo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753957906; c=relaxed/simple;
	bh=7xI6SJc8l9/QF0tfKjYTzIOTaOS8WPagl3vTWmYZeWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bvr/QcAlsEyekKN4qD81YLiNZSvy6ruw23vPz1A0TiKBvWtxRjNMtGOd1sdjQ/gJe+ceFw7ljk+eYlnRcEia7+zPrZ/Kb0teqVD3m6zbBiSBNcFyDi9gQOy0PvAFn19U3E+lpBS41Gc2fwFg2QT89awaKDbi6YNhkukdb8EmI9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sr61EaQQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA4FEC4CEEF;
	Thu, 31 Jul 2025 10:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753957905;
	bh=7xI6SJc8l9/QF0tfKjYTzIOTaOS8WPagl3vTWmYZeWA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Sr61EaQQUfTWnAlFOaOhqudSv8vSNwOB3AO0uRxg2KrfomncIJWsicQ3eznZ8ujBC
	 Wy9EYW/n+BRFAiCIfY1NzAQgrXaaqe36mnxo10s39ybtrDqHkUf3c6feXBSTNLcbbF
	 GyAxcZ8QwI3/UOgtyc/pJJfxHhXW/pSzG9wgN+T1K0yATiuQxnxupO6ulrMs2IQR1+
	 pXaRohdhO6cGaoip+XbzFc4pv/7bBqYB+MU37WPF1T/IsjDJxKfN2XXCQfRJ76jd7T
	 uYMMfnK1XzjAFhwJ6KQNeD59Uulstz46YvETr6i0sV/NS4Nr0T30uVfHLd5/HQZKDr
	 jo5+7zo7O9wnQ==
Date: Thu, 31 Jul 2025 12:31:40 +0200
From: Christian Brauner <brauner@kernel.org>
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC v2 3/4] procfs: add PROCFS_GET_PID_NAMESPACE ioctl
Message-ID: <20250731-angliederung-mahlt-9e5811969817@brauner>
References: <20250723-procfs-pidns-api-v2-0-621e7edd8e40@cyphar.com>
 <20250723-procfs-pidns-api-v2-3-621e7edd8e40@cyphar.com>
 <20250724-beobachten-verfassen-9a39c0318341@brauner>
 <2025-07-25.1753409614-vile-track-icky-epidemic-frail-antidote-d7NYuu@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2025-07-25.1753409614-vile-track-icky-epidemic-frail-antidote-d7NYuu@cyphar.com>

On Fri, Jul 25, 2025 at 12:24:28PM +1000, Aleksa Sarai wrote:
> On 2025-07-24, Christian Brauner <brauner@kernel.org> wrote:
> > On Wed, Jul 23, 2025 at 09:18:53AM +1000, Aleksa Sarai wrote:
> > > /proc has historically had very opaque semantics about PID namespaces,
> > > which is a little unfortunate for container runtimes and other programs
> > > that deal with switching namespaces very often. One common issue is that
> > > of converting between PIDs in the process's namespace and PIDs in the
> > > namespace of /proc.
> > > 
> > > In principle, it is possible to do this today by opening a pidfd with
> > > pidfd_open(2) and then looking at /proc/self/fdinfo/$n (which will
> > > contain a PID value translated to the pid namespace associated with that
> > > procfs superblock). However, allocating a new file for each PID to be
> > > converted is less than ideal for programs that may need to scan procfs,
> > > and it is generally useful for userspace to be able to finally get this
> > > information from procfs.
> > > 
> > > So, add a new API for this in the form of an ioctl(2) you can call on
> > > the root directory of procfs. The returned file descriptor will have
> > > O_CLOEXEC set. This acts as a sister feature to the new "pidns" mount
> > > option, finally allowing userspace full control of the pid namespaces
> > > associated with procfs instances.
> > > 
> > > The permission model for this is a bit looser than that of the "pidns"
> > > mount option, but this is mainly because /proc/1/ns/pid provides the
> > > same information, so as long as you have access to that magic-link (or
> > > something equivalently reasonable such as privileges with CAP_SYS_ADMIN
> > > or being in an ancestor pid namespace) it makes sense to allow userspace
> > > to grab a handle. setns(2) will still have their own permission checks,
> > > so being able to open a pidns handle doesn't really provide too many
> > > other capabilities.
> > > 
> > > Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
> > > ---
> > >  Documentation/filesystems/proc.rst |  4 +++
> > >  fs/proc/root.c                     | 54 ++++++++++++++++++++++++++++++++++++--
> > >  include/uapi/linux/fs.h            |  3 +++
> > >  3 files changed, 59 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
> > > index c520b9f8a3fd..506383273c9d 100644
> > > --- a/Documentation/filesystems/proc.rst
> > > +++ b/Documentation/filesystems/proc.rst
> > > @@ -2398,6 +2398,10 @@ pidns= specifies a pid namespace (either as a string path to something like
> > >  will be used by the procfs instance when translating pids. By default, procfs
> > >  will use the calling process's active pid namespace.
> > >  
> > > +Processes can check which pid namespace is used by a procfs instance by using
> > > +the `PROCFS_GET_PID_NAMESPACE` ioctl() on the root directory of the procfs
> > > +instance.
> > > +
> > >  Chapter 5: Filesystem behavior
> > >  ==============================
> > >  
> > > diff --git a/fs/proc/root.c b/fs/proc/root.c
> > > index 057c8a125c6e..548a57ec2152 100644
> > > --- a/fs/proc/root.c
> > > +++ b/fs/proc/root.c
> > > @@ -23,8 +23,10 @@
> > >  #include <linux/cred.h>
> > >  #include <linux/magic.h>
> > >  #include <linux/slab.h>
> > > +#include <linux/ptrace.h>
> > >  
> > >  #include "internal.h"
> > > +#include "../internal.h"
> > >  
> > >  struct proc_fs_context {
> > >  	struct pid_namespace	*pid_ns;
> > > @@ -418,15 +420,63 @@ static int proc_root_readdir(struct file *file, struct dir_context *ctx)
> > >  	return proc_pid_readdir(file, ctx);
> > >  }
> > >  
> > > +static long int proc_root_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
> > > +{
> > > +	switch (cmd) {
> > > +#ifdef CONFIG_PID_NS
> > > +	case PROCFS_GET_PID_NAMESPACE: {
> > > +		struct pid_namespace *active = task_active_pid_ns(current);
> > > +		struct pid_namespace *ns = proc_pid_ns(file_inode(filp)->i_sb);
> > > +		bool can_access_pidns = false;
> > > +
> > > +		/*
> > > +		 * If we are in an ancestors of the pidns, or have join
> > > +		 * privileges (CAP_SYS_ADMIN), then it makes sense that we
> > > +		 * would be able to grab a handle to the pidns.
> > > +		 *
> > > +		 * Otherwise, if there is a root process, then being able to
> > > +		 * access /proc/$pid/ns/pid is equivalent to this ioctl and so
> > > +		 * we should probably match the permission model. For empty
> > > +		 * namespaces it seems unlikely for there to be a downside to
> > > +		 * allowing unprivileged users to open a handle to it (setns
> > > +		 * will fail for unprivileged users anyway).
> > > +		 */
> > > +		can_access_pidns = pidns_is_ancestor(ns, active) ||
> > > +				   ns_capable(ns->user_ns, CAP_SYS_ADMIN);
> > 
> > This seems to imply that if @ns is a descendant of @active that the
> > caller holds privileges over it. Is that actually always true?
> > 
> > IOW, why is the check different from the previous pidns= mount option
> > check. I would've expected:
> > 
> > ns_capable(_no_audit)(ns->user_ns) && pidns_is_ancestor(ns, active)
> > 
> > and then the ptrace check as a fallback.
> 
> That would mirror pidns_install(), and I did think about it. The primary
> (mostly handwave-y) reasoning I had for making it less strict was that:
> 
>  * If you are in an ancestor pidns, then you can already see those
>    processes in your own /proc. In theory that means that you will be
>    able to access /proc/$pid/ns/pid for at least some subprocess there
>    (even if some subprocesses have SUID_DUMP_DISABLE, that flag is
>    cleared on ).
> 
>    Though hypothetically if they are all running as a different user,
>    this does not apply (and you could create scenarios where a child
>    pidns is owned by a userns that you do not have privileges over -- if
>    you deal with setuid binaries). Maybe that risk means we should just
>    combine them, I'm not sure.
> 
>  * If you have CAP_SYS_ADMIN permissions over the pidns, it seems
>    strange to disallow access even if it is not in an ancestor
>    namespace. This is distinct to pidns_install(), where you want to
>    ensure you cannot escape to a parent pid namespace, this is about
>    getting a handle to do other operations (i.e. NS_GET_{P,TG}ID_*_PIDNS).
> 
> Maybe they should be combined to match pidns_install(), but then I would
> expect the ptrace_may_access() check to apply to all processes in the
> pidns to make it less restrictive, which is not something you can
> practically do (and there is a higher chance that pid1 will have
> SUID_DUMP_DISABLE than some random subprocess, which almost certainly
> will not be SUID_DUMP_DISABLE).
> 
> Fundamentally, I guess I'm still trying to see what the risk is of
> allowing a process to get a handle to a pidns that they have some kind
> of privilege over (whether it's CAP_SYS_ADMIN, or by the virtue of being

There shouldn't be. For example, you kinda implicitly do that with a
pidfd, no? Because you can pass the pidfd to setns() instead of a
namespace fd itself. Maybe that's the argument you're lookin for?

