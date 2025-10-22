Return-Path: <linux-fsdevel+bounces-65075-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E0BBFAEAA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 10:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 297F6422C8B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 08:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE5D30C612;
	Wed, 22 Oct 2025 08:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eNENQrci"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749B82773F1;
	Wed, 22 Oct 2025 08:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761122077; cv=none; b=Mqe2wtc1LE7px6wEfZIDqr//L9GwmPQbCu2Z9zlMrNtgQQndMqIxpFZyWc7Sn7NJd/IcEHA76V1oaFF+yuRaKOpqIfkYljMUo1SGbw8CcSx/2o+qoxBo3Utb2Iu/ivIta+T8+562/jAhLuceNA68d4BTgDl13pB1JWg6lMB/YfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761122077; c=relaxed/simple;
	bh=lzCbKU7QItIkr+mzKOU75bPyRFomE2+TIRxFLe0FUWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n/b7e3mBW02CG7hP9AxRAhAwvvhVT8FxtdRspAqC9F6dur2zxch0+yxI1xdZVGaraXhGFjQycKs4omAevcCDakp+2psGUO4RaMP9T+mTZVhsPWNGsw+HdbH96XghnedgDwgIieSCgbyP1ImoPXdlOzIn30ULm9rf5sisOAg5UEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eNENQrci; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B9F3C4CEE7;
	Wed, 22 Oct 2025 08:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761122077;
	bh=lzCbKU7QItIkr+mzKOU75bPyRFomE2+TIRxFLe0FUWk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eNENQrcijcTgroitdHL2f4ePo57qFYdmGZUemOnJ78NywWQnQtQrOb1AxabP2RXOU
	 RT6odx4YLLn3fzKG2+oDTNbHyf3mry6rONviKjb4GPu5YUzRcSO4HBQlnvOsUIScvq
	 HSUbnYfMy92yW1gnMMYb7CiPw7lAcS+wFJhnxVLo5ym1i6l9S2TKoLZAcJfXH0jpVK
	 HH49quTYRA7Eqb9QopaARqJTYR5D8EGOtoJCTPV9IxxqJSYqG5ihRtFNfbM3pRIeOe
	 bPRuQlVjb9ZlP68ysXySotx7GYcYmYJyoVfy8Dh0SwkKMwHu2bYtGf5c8SijT/fLeZ
	 ARWTDed3EBIgQ==
Date: Wed, 22 Oct 2025 10:34:29 +0200
From: Christian Brauner <brauner@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
	Jann Horn <jannh@google.com>, Mike Yuan <me@yhndnzj.com>, 
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, Lennart Poettering <mzxreary@0pointer.de>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
	Amir Goldstein <amir73il@gmail.com>, Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	bpf@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH RFC DRAFT 00/50] nstree: listns()
Message-ID: <20251022-autoverkehr-begreifbar-9532f1dc148a@brauner>
References: <20251021-work-namespace-nstree-listns-v1-0-ad44261a8a5b@kernel.org>
 <20251021143454.GA8072@fedora>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251021143454.GA8072@fedora>

On Tue, Oct 21, 2025 at 10:34:54AM -0400, Josef Bacik wrote:
> On Tue, Oct 21, 2025 at 01:43:06PM +0200, Christian Brauner wrote:
> > Hey,
> > 
> > As announced a while ago this is the next step building on the nstree
> > work from prior cycles. There's a bunch of fixes and semantic cleanups
> > in here and a ton of tests.
> > 
> > I need helper here!: Consider the following current design:
> > 
> > Currently listns() is relying on active namespace reference counts which
> > are introduced alongside this series.
> > 
> > The active reference count of a namespace consists of the live tasks
> > that make use of this namespace and any namespace file descriptors that
> > explicitly pin the namespace.
> > 
> > Once all tasks making use of this namespace have exited or reaped, all
> > namespace file descriptors for that namespace have been closed and all
> > bind-mounts for that namespace unmounted it ceases to appear in the
> > listns() output.
> > 
> > My reason for introducing the active reference count was that namespaces
> > might obviously still be pinned internally for various reasons. For
> > example the user namespace might still be pinned because there are still
> > open files that have stashed the openers credentials in file->f_cred, or
> > the last reference might be put with an rcu delay keeping that namespace
> > active on the namespace lists.
> > 
> > But one particularly strange example is CONFIG_MMU_LAZY_TLB_REFCOUNT=y.
> > Various architectures support the CONFIG_MMU_LAZY_TLB_REFCOUNT option
> > which uses lazy TLB destruction.
> > 
> > When this option is set a userspace task's struct mm_struct may be used
> > for kernel threads such as the idle task and will only be destroyed once
> > the cpu's runqueue switches back to another task. So the kernel thread
> > will take a reference on the struct mm_struct pinning it.
> > 
> > And for ptrace() based access checks struct mm_struct stashes the user
> > namespace of the task that struct mm_struct belonged to originally and
> > thus takes a reference to the users namespace and pins it.
> > 
> > So on an idle system such user namespaces can be persisted for pretty
> > arbitrary amounts of time via struct mm_struct.
> > 
> > Now, without the active reference count regulating visibility all
> > namespace that still are pinned in some way on the system will appear in
> > the listns() output and can be reopened using namespace file handles.
> > 
> > Of course that requires suitable privileges and it's not really a
> > concern per se because a task could've also persist the namespace
> > recorded in struct mm_struct explicitly and then the idle task would
> > still reuse that struct mm_struct and another task could still happily
> > setns() to it afaict and reuse it for something else.
> > 
> > The active reference count though has drawbacks itself. Namely that
> > socket files break the assumption that namespaces can only be opened if
> > there's either live processes pinning the namespace or there are file
> > descriptors open that pin the namespace itself as the socket SIOCGSKNS
> > ioctl() can be used to open a network namespace based on a socket which
> > only indirectly pins a network namespace.
> > 
> > So that punches a whole in the active reference count tracking. So this
> > will have to be handled as right now socket file descriptors that pin a
> > network namespace that don't have an active reference anymore (no live
> > processes, not explicit persistence via namespace fds) can't be used to
> > issue a SIOCGSKNS ioctl() to open the associated network namespace.
> > 
> > So two options I see if the api is based on ids:
> > 
> > (1) We use the active reference count and somehow also make it work with
> >     sockets.
> > (2) The active reference count is not needed and we say that listns() is
> >     an introspection system call anyway so we just always list
> >     namespaces regardless of why they are still pinned: files,
> >     mm_struct, network devices, everything is fair game.
> > (3) Throw hands up in the air and just not do it.
> >
> 
> I think the active reference counts are just nice to have, if I'm not missing
> something we still have to figure out which pid is using the namespace we may
> want to enter, so there's already a "time of check, time of use" issue. I think
> if we want to have the active count we can do it just as an advisory thing, have
> a flag that says "this ns is dying and you can't do anything with it", and then
> for network namespaces we can just never set the flag and let the existing
> SIOCKGSNS ioctl work as is.
> 
> The bigger question (and sorry I didn't think about this before now), is how are
> we going to integrate this into the rest of the NS related syscalls? Having
> progromatic introspection is excellent from a usabiility point of view, but we
> also want to be able to have an easy way to get a PID from these namespaces, and
> even eventually do things like setns() based on these IDs. Those are followup
> series of course, but we should at least have a plan for them. Thanks,

I don't think we even need to have separate system calls to operate
directly on the IDs that's why I added namespace file handles.

We have listns() to iterate through namespaces in various ways.
This will be followed by statns() which will indeed operate on these
IDs to retrieve namespace specific information.

I already have that one drafted as well (That can contain all kinds of
namespace specific information like number of mounts (mntns), or number
of sockets (netns), number of network devices (netns), number of process
(pidns) what have you. Although what to expose I'm leaving to the
individual namespaces to figure out. IOW, I'm not going to figure out
what information statns() whould expose for network namespaces. I'll
leave that to net/).

But to your other point: to perform traditional operations like setns()
or all of the ioctls associated with such namespaces, it's pretty easy:

  struct file_handle **net_handle;
  char net_buf[sizeof(*net_handle) + MAX_HANDLE_SZ];

  net_handle = (struct file_handle *)net_buf;
  net_handle->handle_bytes = sizeof(struct nsfs_file_handle);
  net_handle->handle_type = FILEID_NSFS;
  struct nsfs_file_handle *net_fh = (struct nsfs_file_handle *)net_handle->f_handle;
  net_fh->ns_id = netns_id;

Now obviously that should exist in a nice simple define and aligned and
not nastily open-coded like I did here but you get the point. The
namespace id is sufficient to open an fd to it which is the main api to
perform actual semantic operations on it.

  /*
   * As long as the caller has CAP_SYS_ADMIN in the owning user namespace
   * of the etwork namespace or is located in the network namespace they
   * can open a file descriptor to it just like with
   * /proc/<pid>/ns/<ns_type>
   */
  int netns_fd = open_by_handle_at(FD_NSFS_ROOT, net_handle, O_RDONLY);
  
  setns(netns_fd, CLONE_NEWNET)

Getting pids from pid namespaces or translating them between pid
namespaces is something I added a while ago as well, via ioctl_nsfs:

/* Translate pid from target pid namespace into the caller's pid namespace. */
#define NS_GET_PID_FROM_PIDNS	_IOR(NSIO, 0x6, int)
/* Return thread-group leader id of pid in the callers pid namespace. */
#define NS_GET_TGID_FROM_PIDNS	_IOR(NSIO, 0x7, int)
/* Translate pid from caller's pid namespace into a target pid namespace. */
#define NS_GET_PID_IN_PIDNS	_IOR(NSIO, 0x8, int)
/* Return thread-group leader id of pid in the target pid namespace. */
#define NS_GET_TGID_IN_PIDNS	_IOR(NSIO, 0x9, int)

That also works fd-based and so is covered by open_by_handle_at().

