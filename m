Return-Path: <linux-fsdevel+bounces-52850-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47527AE7915
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 09:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 437C87AA2F2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 07:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77D720E01F;
	Wed, 25 Jun 2025 07:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ah1WEzRh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403A220D4E7;
	Wed, 25 Jun 2025 07:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750837980; cv=none; b=hycPWJZFj/qleyKrubWUytT4WlvJynE4tylOsrrVHIPcdY2hdunq9ZAYONMJLNb+Abz78Ib8ML4CyVr4VQcW+YbFLJ+jcE4h7xxwJy3ZvaaT1z3UuAUrReO0/Y6F88TTO7g+Zs0rO5tKFwEr1LbFqGgKwoBazq2qGvDMjX0aKh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750837980; c=relaxed/simple;
	bh=YrZgrbikDaYNR1WY02G2lGf7gpVdJEXGZMbY9mKQT+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ANLZHAuS/CbYYyu+QnYmWnoWzMGE8d2foQuDpiklRA8HEC4+q5H6sShO4ZGzXW++VgTH8T8xK/pVP9wksCA2vLEOW5gGoPPxIrWEfRpfBD3ETJkUSL8zTpOuf/jKmbwlEvRcD8TeCpC6DGBsvSNOU7BeVSnQu9SidYBi1yfuhRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ah1WEzRh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 428CDC4CEEA;
	Wed, 25 Jun 2025 07:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750837979;
	bh=YrZgrbikDaYNR1WY02G2lGf7gpVdJEXGZMbY9mKQT+g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ah1WEzRhOj4IPF77CI7b5K47bF/8MOVb6bD0Rvl76aRnSAk9iebSn4YJcCLbXUvnL
	 gXuOhYjB67BngCEpefmyauwM6Nd9Xqa7MUATYisFn5meXStmsa8IEhz+WEkv3ij29L
	 +pqnIEGsFb5hfzV0ATx6MZzGVr7LRRofuj2mGUCVDetMqY1wUrzUd/EryeOnfJiI8h
	 mPh6/uF7Lmz+iQjQ9GxDceAEy6bgRAsR0pq4sqA9srYVNO+i8U7J2NMXoxJWGWAVvT
	 wx9q5atY07RvQNvG75U4p7Ay9usTrr4w0/OcSQ6ZsjP4E1nngKcw0HFajDy9IDsQC/
	 yTXdZwhwM/4WQ==
Date: Wed, 25 Jun 2025 09:52:55 +0200
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, Simona Vetter <simona@ffwll.ch>, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 10/11] fhandle, pidfs: support open_by_handle_at()
 purely based on file handle
Message-ID: <20250625-vollwertig-wahlen-2196bc53e9ba@brauner>
References: <20250624-work-pidfs-fhandle-v2-0-d02a04858fe3@kernel.org>
 <20250624-work-pidfs-fhandle-v2-10-d02a04858fe3@kernel.org>
 <ng6fvyydyem4qh3rtkvaeyyxm3suixjoef5nepyhwgc4k26chp@n2tlycbek4vl>
 <CAOQ4uxgB+01GsNh2hAJOqZF4oUaXqqCeiFVEwmm+_h9WhG-KdA@mail.gmail.com>
 <CAOQ4uxjYGipMt4t+ZzYEQgn3EhWh327iEyoKyeoqKKGzwuHRsg@mail.gmail.com>
 <20250624-reinreden-museen-5b07804eaffe@brauner>
 <CAOQ4uxg_0+Z9vV1ArX2MbpDu=aGDXQSzQmMXR3mPPu5mFB8rTQ@mail.gmail.com>
 <20250624-dankt-ruhekissen-896ff2e32821@brauner>
 <CAOQ4uxjeAw3npz0pV4OgoZbY4weAOtK41HnYr2AWk8TRsGfohw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxjeAw3npz0pV4OgoZbY4weAOtK41HnYr2AWk8TRsGfohw@mail.gmail.com>

On Tue, Jun 24, 2025 at 09:23:36PM +0200, Amir Goldstein wrote:
> On Tue, Jun 24, 2025 at 5:23 PM Christian Brauner <brauner@kernel.org> wrote:
> >
> > On Tue, Jun 24, 2025 at 05:07:59PM +0200, Amir Goldstein wrote:
> > > On Tue, Jun 24, 2025 at 4:51 PM Christian Brauner <brauner@kernel.org> wrote:
> > > >
> > > > On Tue, Jun 24, 2025 at 04:28:50PM +0200, Amir Goldstein wrote:
> > > > > On Tue, Jun 24, 2025 at 12:53 PM Amir Goldstein <amir73il@gmail.com> wrote:
> > > > > >
> > > > > > On Tue, Jun 24, 2025 at 11:30 AM Jan Kara <jack@suse.cz> wrote:
> > > > > > >
> > > > > > > On Tue 24-06-25 10:29:13, Christian Brauner wrote:
> > > > > > > > Various filesystems such as pidfs (and likely drm in the future) have a
> > > > > > > > use-case to support opening files purely based on the handle without
> > > > > > > > having to require a file descriptor to another object. That's especially
> > > > > > > > the case for filesystems that don't do any lookup whatsoever and there's
> > > > > > > > zero relationship between the objects. Such filesystems are also
> > > > > > > > singletons that stay around for the lifetime of the system meaning that
> > > > > > > > they can be uniquely identified and accessed purely based on the file
> > > > > > > > handle type. Enable that so that userspace doesn't have to allocate an
> > > > > > > > object needlessly especially if they can't do that for whatever reason.
> > > > > > > >
> > > > > > > > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > > > > > > > ---
> > > > > > > >  fs/fhandle.c | 22 ++++++++++++++++++++--
> > > > > > > >  fs/pidfs.c   |  5 ++++-
> > > > > > > >  2 files changed, 24 insertions(+), 3 deletions(-)
> > > > > > > >
> > > > > > > > diff --git a/fs/fhandle.c b/fs/fhandle.c
> > > > > > > > index ab4891925b52..54081e19f594 100644
> > > > > > > > --- a/fs/fhandle.c
> > > > > > > > +++ b/fs/fhandle.c
> > > > > > > > @@ -173,7 +173,7 @@ SYSCALL_DEFINE5(name_to_handle_at, int, dfd, const char __user *, name,
> > > > > > > >       return err;
> > > > > > > >  }
> > > > > > > >
> > > > > > > > -static int get_path_anchor(int fd, struct path *root)
> > > > > > > > +static int get_path_anchor(int fd, struct path *root, int handle_type)
> > > > > > > >  {
> > > > > > > >       if (fd >= 0) {
> > > > > > > >               CLASS(fd, f)(fd);
> > > > > > > > @@ -193,6 +193,24 @@ static int get_path_anchor(int fd, struct path *root)
> > > > > > > >               return 0;
> > > > > > > >       }
> > > > > > > >
> > > > > > > > +     /*
> > > > > > > > +      * Only autonomous handles can be decoded without a file
> > > > > > > > +      * descriptor.
> > > > > > > > +      */
> > > > > > > > +     if (!(handle_type & FILEID_IS_AUTONOMOUS))
> > > > > > > > +             return -EOPNOTSUPP;
> > > > > > >
> > > > > > > This somewhat ties to my comment to patch 5 that if someone passed invalid
> > > > > > > fd < 0 before, we'd be returning -EBADF and now we'd be returning -EINVAL
> > > > > > > or -EOPNOTSUPP based on FILEID_IS_AUTONOMOUS setting. I don't care that
> > > > > > > much about it so feel free to ignore me but I think the following might be
> > > > > > > more sensible error codes:
> > > > > > >
> > > > > > >         if (!(handle_type & FILEID_IS_AUTONOMOUS)) {
> > > > > > >                 if (fd == FD_INVALID)
> > > > > > >                         return -EOPNOTSUPP;
> > > > > > >                 return -EBADF;
> > > > > > >         }
> > > > > > >
> > > > > > >         if (fd != FD_INVALID)
> > > > > > >                 return -EBADF; (or -EINVAL no strong preference here)
> > > > > >
> > > > > > FWIW, I like -EBADF better.
> > > > > > it makes the error more descriptive and keeps the flow simple:
> > > > > >
> > > > > > +       /*
> > > > > > +        * Only autonomous handles can be decoded without a file
> > > > > > +        * descriptor and only when FD_INVALID is provided.
> > > > > > +        */
> > > > > > +       if (fd != FD_INVALID)
> > > > > > +               return -EBADF;
> > > > > > +
> > > > > > +       if (!(handle_type & FILEID_IS_AUTONOMOUS))
> > > > > > +               return -EOPNOTSUPP;
> > > > > >
> > > > >
> > > > > Thinking about it some more, as I am trying to address your concerns
> > > > > about crafting autonomous file handles by systemd, as you already
> > > > > decided to define a range for kernel reserved values for fd, why not,
> > > > > instead of requiring FD_INVALID for autonomous file handle, that we
> > > > > actually define a kernel fd value that translates to "the root of pidfs":
> > > > >
> > > > > +       /*
> > > > > +        * Autonomous handles can be decoded with a special file
> > > > > +        * descriptor value that describes the filesystem.
> > > > > +        */
> > > > > +       switch (fd) {
> > > > > +       case FD_PIDFS_ROOT:
> > > > > +               pidfs_get_root(root);
> > > > > +               break;
> > > > > +       default:
> > > > > +               return -EBADF;
> > > > > +       }
> > > > > +
> > > > >
> > > > > Then you can toss all my old ideas, including FILEID_IS_AUTONOMOUS,
> > > > > and EXPORT_OP_AUTONOMOUS_HANDLES and you do not even need
> > > > > to define FILEID_PIDFS anymore, just keep exporting FILEID_KERNFS
> > > > > as before (you can also keep the existing systemd code) and when you want
> > > > > to open file by handle you just go
> > > > > open_by_handle_at(FD_PIDFS, &handle, 0)
> > > > > and that's it.
> > > > >
> > > > > In the end, my one and only concern with autonomous file handles is that
> > > > > there should be a user opt-in to request them.
> > > > >
> > > > > Sorry for taking the long road to get to this simpler design.
> > > > > WDYT?
> > > >
> > > > And simply place FD_PIDFS_ROOT into the -10000 range?
> > > > Sounds good to me.
> > >
> > > Yes.
> > >
> > > I mean I don't expect there will be a flood of those singleton
> > > filesystems, but generally speaking, a unique fd constant
> > > to describe the root of a singleton filesystem makes sense IMO.
> >
> > Agreed. See the appended updated patches. I'm not resending completely.
> > I just dropped other patches.
> 
> For those can also add:
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> 
> But I see that FD_INVALID is still there.
> Are you planning to keep the FD_INVALID patch without any
> users for FD_INVALID?

Yes, even if just for userspace to get used to.

