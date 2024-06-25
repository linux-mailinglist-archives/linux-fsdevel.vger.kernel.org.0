Return-Path: <linux-fsdevel+bounces-22387-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E02D916BEC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 17:08:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29D2A1F24032
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 15:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5096517F367;
	Tue, 25 Jun 2024 15:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ofAZaNkM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B175117E91E
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jun 2024 15:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719327755; cv=none; b=kCM4Q7Gv8z1TkFRqbHESeGu8sIoxappFX1vO/PaVRn9p4QgZffFcSjPRyWXZjkYg+afufsOuZb83LJgQuH58cGupasbvx5IaeYYv721QhNNlUe7hGjcd7SfvagbRI/hlGSukd9gKbnOJK2a4tJKvcG3X5DTI2K6PDghVg1RtNVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719327755; c=relaxed/simple;
	bh=b7Nw5okBQqCcvaFHn1Nk+C1gVZREh2E97VU0CLvXzlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CUHhyGtJx2cF+uUov+9BfM9F+tosnj/bSJMEuM+5be7RP5VjblV1jnRPmqX06M7esfrjEpyQ483w0xzoMeDdfljgAlOAw4OX52sgmle5SIa07ZFo/EORY0ggaVT2DNf5wMM+q0JoCaoP9guoSQkpf6D2+N3mtqzeT0nFVk/SwuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ofAZaNkM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F0A2C4AF10;
	Tue, 25 Jun 2024 15:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719327755;
	bh=b7Nw5okBQqCcvaFHn1Nk+C1gVZREh2E97VU0CLvXzlw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ofAZaNkMDxxH2DY7u5+34QJaM7L5MB/yAFG2rSv16uS/TyRD0wXLWw2kqsY558Q2h
	 6I5iIlK7r6uxONlcHzy5kpWYvLmBEZHE7sejn1+FE52sDFfTyIjQFmoB2nJjldgD1v
	 M4tZ0ziOtlws7LmJgUcSxau5jbLG0dtQlzD9B5E0Px/ydRBudFWs7IYLQXT9yhv58l
	 6n3e1yxKxMg8GxT1XdVeL9KVWM0j7fMXcBDyAL8bMHzYxYrxndkLMPJrJZIwnFCLej
	 vUyH/ZHe9vMNsZlbkQTXOHHncQPwm93DfEoDWzpc3AvKtmK3IrZChy35N+JChCSKLo
	 qwzwpXPCa4cyw==
Date: Tue, 25 Jun 2024 17:02:31 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org, 
	kernel-team@fb.com
Subject: Re: [PATCH 7/8] fs: add an ioctl to get the mnt ns id from nsfs
Message-ID: <20240625-wacklig-wahlzettel-ae6415b17adb@brauner>
References: <cover.1719243756.git.josef@toxicpanda.com>
 <180449959d5a756af7306d6bda55f41b9d53e3cb.1719243756.git.josef@toxicpanda.com>
 <14330f15065f92a88c7c0364cba3e26c294293a4.camel@kernel.org>
 <20240625-darunter-wieweit-9ced87b1df0b@brauner>
 <1833a18f7935aed5df264ed295d1084672234541.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1833a18f7935aed5df264ed295d1084672234541.camel@kernel.org>

On Tue, Jun 25, 2024 at 10:50:57AM GMT, Jeff Layton wrote:
> On Tue, 2024-06-25 at 16:21 +0200, Christian Brauner wrote:
> > On Tue, Jun 25, 2024 at 10:10:29AM GMT, Jeff Layton wrote:
> > > On Mon, 2024-06-24 at 11:49 -0400, Josef Bacik wrote:
> > > > In order to utilize the listmount() and statmount() extensions that
> > > > allow us to call them on different namespaces we need a way to get
> > > > the
> > > > mnt namespace id from user space.  Add an ioctl to nsfs that will
> > > > allow
> > > > us to extract the mnt namespace id in order to make these new
> > > > extensions
> > > > usable.
> > > > 
> > > > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > > > ---
> > > >  fs/nsfs.c                 | 14 ++++++++++++++
> > > >  include/uapi/linux/nsfs.h |  2 ++
> > > >  2 files changed, 16 insertions(+)
> > > > 
> > > > diff --git a/fs/nsfs.c b/fs/nsfs.c
> > > > index 07e22a15ef02..af352dadffe1 100644
> > > > --- a/fs/nsfs.c
> > > > +++ b/fs/nsfs.c
> > > > @@ -12,6 +12,7 @@
> > > >  #include <linux/nsfs.h>
> > > >  #include <linux/uaccess.h>
> > > >  
> > > > +#include "mount.h"
> > > >  #include "internal.h"
> > > >  
> > > >  static struct vfsmount *nsfs_mnt;
> > > > @@ -143,6 +144,19 @@ static long ns_ioctl(struct file *filp, unsigned
> > > > int ioctl,
> > > >  		argp = (uid_t __user *) arg;
> > > >  		uid = from_kuid_munged(current_user_ns(), user_ns-
> > > > > owner);
> > > >  		return put_user(uid, argp);
> > > > +	case NS_GET_MNTNS_ID: {
> > > > +		struct mnt_namespace *mnt_ns;
> > > > +		__u64 __user *idp;
> > > > +		__u64 id;
> > > > +
> > > > +		if (ns->ops->type != CLONE_NEWNS)
> > > > +			return -EINVAL;
> > > > +
> > > > +		mnt_ns = container_of(ns, struct mnt_namespace, ns);
> > > > +		idp = (__u64 __user *)arg;
> > > > +		id = mnt_ns->seq;
> > > > +		return put_user(id, idp);
> > > > +	}
> > > >  	default:
> > > >  		return -ENOTTY;
> > > >  	}
> > > > diff --git a/include/uapi/linux/nsfs.h b/include/uapi/linux/nsfs.h
> > > > index a0c8552b64ee..56e8b1639b98 100644
> > > > --- a/include/uapi/linux/nsfs.h
> > > > +++ b/include/uapi/linux/nsfs.h
> > > > @@ -15,5 +15,7 @@
> > > >  #define NS_GET_NSTYPE		_IO(NSIO, 0x3)
> > > >  /* Get owner UID (in the caller's user namespace) for a user
> > > > namespace */
> > > >  #define NS_GET_OWNER_UID	_IO(NSIO, 0x4)
> > > > +/* Get the id for a mount namespace */
> > > > +#define NS_GET_MNTNS_ID		_IO(NSIO, 0x5)
> > > >  
> > > >  #endif /* __LINUX_NSFS_H */
> > > 
> > > Thinking about this more...
> > > 
> > > Would it also make sense to wire up a similar ioctl in pidfs? It seems
> > > like it might be nice to just open a pidfd for pid and then issue the
> > > above to get its mntns id, rather than having to grovel around in nsfs.
> > 
> > I had a different idea yesterday: get a mount namespace fd from a pidfd
> > in fact, get any namespace fd based on a pidfd. It's the equivalent to:
> > /proc/$pid/ns* and then you can avoid having to go via procfs at all.
> 
> That would work too. I'd specifically like to be able to avoid crawling
> around in /proc/<pid> as much as possible.

Yes, this would do just that for namespaces and it is a natural
extension of what I added some time ago, namely that you can already use
a pidfd in lieu of a namespace fd in setns. For example, you can do:

setns(pidfd, CLONE_NEWNS | CLONE_NEWUSER | CLONE_NEWPID | CLONE_NEWNET | ...)

to switch to the namespaces of another task (atomically ) where the
kernel also takes care of the ordering between owning user namespace and
other namespaces for the caller.

(This still lacks a SETNS_PIDFD_ALL extension that would amount to
switching all namespaces that are different from the caller's current
namespaces (bc right now you would get EPERM if you're in the same user
namespace as the target).)

> At this point, I think we're still stuck with having to walk /proc to
> know what pids currently exist though, right? I don't think there is
> any way to walk all the pids just using pidfds is there?

No, that doesn't exist right now. But it wouldn't be out of the question
to add something like this (but it would have to be a new data structure
most likely) if the use-case is sufficiently compelling.

However, a container manager will know what what processes it tracks and
it doesn't have to crawl /proc and so there it's immediately useful.

Another thing is that I find it useful if there's a connection between
two interfaces, say pidfs and nsfs so that you could go from a pidfd to
a namespace fd. But I find it odd if we just duplicate nsfs ioctls on
top of pidfs.

> 
> > 
> > Needs to be governed by ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS).
> > 
> > (We also need an ioctl() on the pidfd to get to the PID without procfs btw.
> 
> A PIDFS_GET_PID ioctl seems like a reasonable thing to add.
> -- 
> Jeff Layton <jlayton@kernel.org>

