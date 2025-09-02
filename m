Return-Path: <linux-fsdevel+bounces-59966-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3261FB3FBB2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 12:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9D662C2216
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 10:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 243392F4A0B;
	Tue,  2 Sep 2025 10:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E27hA+Co"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628F42F49FC;
	Tue,  2 Sep 2025 10:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756807384; cv=none; b=HcPBjtzNwtf6DmUQQB0l8E1NBd9RoCh/mmOu8X/pKqSsgHu8NCTnqhwWm7JKfbNWlPhrD2BtFGtBPmMQx1RPPcTSx3r9t4D7Dha75jRg66JM9mSTbRfmUabD3g/FL93Fs2Sfo5V2JdaNzkQbHOElg3dlY9WmAfdbafZg6/kFkWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756807384; c=relaxed/simple;
	bh=b6/BfC8ztD20vSiS51W/7u+srH7z5AW8ewRgiLndpEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aIZoXsDNM0yakr+v4ygDhfhqKkXq4ofGp7q3Ozu6IYiK+aatXYGHZ02QWUj0XN+vpuntq6OTnc9U+ja4sKc2pc+2VXSoE+SLjOlKsdLOpFhvhqvYgH7mWYYbE45UUlt2aeDPnVuljdapZdJMu1dpMJmDWAVLUHEoyEvTicVe/gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E27hA+Co; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EF98C4CEF8;
	Tue,  2 Sep 2025 10:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756807384;
	bh=b6/BfC8ztD20vSiS51W/7u+srH7z5AW8ewRgiLndpEg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E27hA+CoE7S9suQrmeukP6WwB1DUInrAmKiIJUs5E+0253eC1MfeiXJ5i3o3Qmyn6
	 TXPQ7bK7zhZGsfD27X5zndyAQLvh1e2GFRRUV9K5WOHji1A0ctNzVmS9/pN4Ca5suG
	 y4tnE8Nyjn5Dk+n9mU+YTSvAJng8nfm9f+O4km3bX3//lMSO1UeemZ31AmHZxPzsfd
	 bWGxJivlIo2amptKiq/EIb7OMM+/DB3Ob5IIauuzaqn8YrpXUZS9/md5M4KeSvv0ek
	 nbdHGMYFvrTt0xi1KA/Q1GW5CpMSgJwF1E19/wh3PUFoJhZK71FGFt3A+ZTtvgRqHo
	 0HsDXgZnuHXYA==
Date: Tue, 2 Sep 2025 12:02:58 +0200
From: Christian Brauner <brauner@kernel.org>
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, 
	Andy Lutomirski <luto@amacapital.net>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 0/4] procfs: make reference pidns more user-visible
Message-ID: <20250902-gehofft-ruheraum-3c286b25b6d3@brauner>
References: <20250805-procfs-pidns-api-v4-0-705f984940e7@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250805-procfs-pidns-api-v4-0-705f984940e7@cyphar.com>

On Tue, Aug 05, 2025 at 03:45:07PM +1000, Aleksa Sarai wrote:
> Ever since the introduction of pid namespaces, procfs has had very
> implicit behaviour surrounding them (the pidns used by a procfs mount is
> auto-selected based on the mounting process's active pidns, and the
> pidns itself is basically hidden once the mount has been constructed).
> 
> /* pidns mount option for procfs */
> 
> This implicit behaviour has historically meant that userspace was
> required to do some special dances in order to configure the pidns of a
> procfs mount as desired. Examples include:
> 
>  * In order to bypass the mnt_too_revealing() check, Kubernetes creates
>    a procfs mount from an empty pidns so that user namespaced containers
>    can be nested (without this, the nested containers would fail to
>    mount procfs). But this requires forking off a helper process because
>    you cannot just one-shot this using mount(2).
> 
>  * Container runtimes in general need to fork into a container before
>    configuring its mounts, which can lead to security issues in the case
>    of shared-pidns containers (a privileged process in the pidns can
>    interact with your container runtime process). While
>    SUID_DUMP_DISABLE and user namespaces make this less of an issue, the
>    strict need for this due to a minor uAPI wart is kind of unfortunate.
> 
> Things would be much easier if there was a way for userspace to just
> specify the pidns they want. Patch 1 implements a new "pidns" argument
> which can be set using fsconfig(2):
> 
>     fsconfig(procfd, FSCONFIG_SET_FD, "pidns", NULL, nsfd);
>     fsconfig(procfd, FSCONFIG_SET_STRING, "pidns", "/proc/self/ns/pid", 0);
> 
> or classic mount(2) / mount(8):
> 
>     // mount -t proc -o pidns=/proc/self/ns/pid proc /tmp/proc
>     mount("proc", "/tmp/proc", "proc", MS_..., "pidns=/proc/self/ns/pid");
> 
> The initial security model I have in this RFC is to be as conservative
> as possible and just mirror the security model for setns(2) -- which
> means that you can only set pidns=... to pid namespaces that your
> current pid namespace is a direct ancestor of and you have CAP_SYS_ADMIN
> privileges over the pid namespace. This fulfils the requirements of
> container runtimes, but I suspect that this may be too strict for some
> usecases.
> 
> The pidns argument is not displayed in mountinfo -- it's not clear to me
> what value it would make sense to show (maybe we could just use ns_dname
> to provide an identifier for the namespace, but this number would be
> fairly useless to userspace). I'm open to suggestions. Note that
> PROCFS_GET_PID_NAMESPACE (see below) does at least let userspace get
> information about this outside of mountinfo.
> 
> Note that you cannot change the pidns of an already-created procfs
> instance. The primary reason is that allowing this to be changed would
> require RCU-protecting proc_pid_ns(sb) and thus auditing all of
> fs/proc/* and some of the users in fs/* to make sure they wouldn't UAF
> the pid namespace. Since creating procfs instances is very cheap, it
> seems unnecessary to overcomplicate this upfront. Trying to reconfigure
> procfs this way errors out with -EBUSY.
> 
> /* ioctl(PROCFS_GET_PID_NAMESPACE) */
> 
> In addition, being able to figure out what pid namespace is being used
> by a procfs mount is quite useful when you have an administrative
> process (such as a container runtime) which wants to figure out the
> correct way of mapping PIDs between its own namespace and the namespace
> for procfs (using NS_GET_{PID,TGID}_{IN,FROM}_PIDNS). There are
> alternative ways to do this, but they all rely on ancillary information
> that third-party libraries and tools do not necessarily have access to.
> 
> To make this easier, add a new ioctl (PROCFS_GET_PID_NAMESPACE) which
> can be used to get a reference to the pidns that a procfs is using.
> 
> Rather than copying the (fairly strict) security model for setns(2),
> apply a slightly looser model to better match what userspace can already
> do:
> 
>  * Make the ioctl only valid on the root (meaning that a process without
>    access to the procfs root -- such as only having an fd to a procfs
>    file or some open_tree(2)-like subset -- cannot use this API). This
>    means that the process already has some level of access to the
>    /proc/$pid directories.
> 
>  * If the calling process is in an ancestor pidns, then they can already
>    create pidfd for processes inside the pidns, which is morally
>    equivalent to a pidns file descriptor according to setns(2). So it
>    seems reasonable to just allow it in this case. (The justification
>    for this model was suggested by Christian.)
> 
>  * If the process has access to /proc/1/ns/pid already (i.e. has
>    ptrace-read access to the pidns pid1), then this ioctl is equivalent
>    to just opening a handle to it that way.
> 
>    Ideally we would check for ptrace-read access against all processes
>    in the pidns (which is very likely to be true for at least one
>    process, as SUID_DUMP_DISABLE is cleared on exec(2) and is rarely set
>    by most programs), but this would obviously not scale.
> 
> I'm open to suggestions for whether we need to make this stricter (or
> possibly allow more cases).
> 
> Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>

Thanks for the patchset. Being able to specify what pid namespace the
procfs instance is supposed to belong to is super useful and will make
things easier for userspace for sure.

The code you added contains a minor wrinkle that I disliked which I've
changed and you tell me if you can live with this restriction or not.

The way you've implemented it specifying a pid namespace that the caller
holds privilege over would silently also override the user namespace the
filesystem is supposed to belong to.

Specifically, you did something like:

        put_pid_ns(ctx->pid_ns);
        ctx->pid_ns = get_pid_ns(target);
        put_user_ns(fc->user_ns);
        fc->user_ns = get_user_ns(ctx->pid_ns->user_ns);

This silently overrides the user namespace recorded at fsopen() time. I
think that's too subtle and we should just not allow that at all for
now.

Instead I've changed this to:

        if (fc->user_ns != target->user_ns)
                return invalfc(fc, "owning user namespace of pid namespace doesn't match procfs user namespace");

        put_pid_ns(ctx->pid_ns);
        ctx->pid_ns = get_pid_ns(target);

so we just refuse different owernship.

I've also dropped the procfs ioctl because I'm not sure how much value
it will actually add given that you can do this via /proc/1/ns/pid.

If that is something that libpathrs despearately needs I would like to
do it as a separate patch anyways.

Thanks for the excellent cover letter. This was a pleasure merging!

