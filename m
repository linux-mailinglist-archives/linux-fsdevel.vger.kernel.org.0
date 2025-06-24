Return-Path: <linux-fsdevel+bounces-52786-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96AF0AE69FA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 17:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C2CF4E60A8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 14:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C452DCBF7;
	Tue, 24 Jun 2025 14:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="APRWrJk0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77152DA77C;
	Tue, 24 Jun 2025 14:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750776678; cv=none; b=qQvI6T9Lkp6fa/wxHGrf3a4JVu+cFyYDlpS6t1yfPyfDPYY0VMENAGpZDHDrEjOb2bWP2/TCmjHY16SXGhauwPHOWsxyKGO/iqdThET1Dso6zcq7lP3gqEwOi3gkokcei1PaPK8VnzHpnmkrkuGLLcU7amXmgoBppcfsejQz5Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750776678; c=relaxed/simple;
	bh=4FXMS79DcS8BbxaLke7Vk9FCmdpHBX51wOPt5Z19XYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T4g6kBtVarxUwOObjPSdpPbqf8kmi8m6yuxXC4fAqbmb7p5LPfsVJw4DHSBLpVrP6qTMfzDBVSO4JYfC2Wrb5VyX6h8dK1Ugsx7bTrNVJniPv6Fe6vvmFrcp+I174tO/y4JebUhcj27whnpdAX/9SOhKZRlaSE9cMmV5P1KTLEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=APRWrJk0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADCA0C4CEEE;
	Tue, 24 Jun 2025 14:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750776676;
	bh=4FXMS79DcS8BbxaLke7Vk9FCmdpHBX51wOPt5Z19XYo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=APRWrJk0qA0+9j7O8SY+nXgXVUp/clhoGJTA2ZjHHCQ2y4VqyApFnXSnWec55e6Lg
	 0rzT74gyuheYUdZNG3yktpNkCn8eKBRVwBPIge7CPFkjUdOSgOCMSlZo2bvi18ke7o
	 I6tkk0wj3z86bqYxEHrs6YgbnfQ7gCzXueUxIuAIckg95iGI7Om5G2gEYhrsqwAbxI
	 V7xQIU3D+SzT8SUiJ6rXTNoI9NF0Fxf7waax+Fw+ZzpzJZboLPEBIFJvXZXPbpJbFQ
	 GmK3goFPpCIR2jRwCF00Ic6177++vJt99SmHDisj2+sIVCV3MBtM+sJev0I8Il8Xx7
	 wrbzTiDilboFA==
Date: Tue, 24 Jun 2025 16:51:12 +0200
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, Simona Vetter <simona@ffwll.ch>, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 10/11] fhandle, pidfs: support open_by_handle_at()
 purely based on file handle
Message-ID: <20250624-reinreden-museen-5b07804eaffe@brauner>
References: <20250624-work-pidfs-fhandle-v2-0-d02a04858fe3@kernel.org>
 <20250624-work-pidfs-fhandle-v2-10-d02a04858fe3@kernel.org>
 <ng6fvyydyem4qh3rtkvaeyyxm3suixjoef5nepyhwgc4k26chp@n2tlycbek4vl>
 <CAOQ4uxgB+01GsNh2hAJOqZF4oUaXqqCeiFVEwmm+_h9WhG-KdA@mail.gmail.com>
 <CAOQ4uxjYGipMt4t+ZzYEQgn3EhWh327iEyoKyeoqKKGzwuHRsg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxjYGipMt4t+ZzYEQgn3EhWh327iEyoKyeoqKKGzwuHRsg@mail.gmail.com>

On Tue, Jun 24, 2025 at 04:28:50PM +0200, Amir Goldstein wrote:
> On Tue, Jun 24, 2025 at 12:53 PM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > On Tue, Jun 24, 2025 at 11:30 AM Jan Kara <jack@suse.cz> wrote:
> > >
> > > On Tue 24-06-25 10:29:13, Christian Brauner wrote:
> > > > Various filesystems such as pidfs (and likely drm in the future) have a
> > > > use-case to support opening files purely based on the handle without
> > > > having to require a file descriptor to another object. That's especially
> > > > the case for filesystems that don't do any lookup whatsoever and there's
> > > > zero relationship between the objects. Such filesystems are also
> > > > singletons that stay around for the lifetime of the system meaning that
> > > > they can be uniquely identified and accessed purely based on the file
> > > > handle type. Enable that so that userspace doesn't have to allocate an
> > > > object needlessly especially if they can't do that for whatever reason.
> > > >
> > > > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > > > ---
> > > >  fs/fhandle.c | 22 ++++++++++++++++++++--
> > > >  fs/pidfs.c   |  5 ++++-
> > > >  2 files changed, 24 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/fs/fhandle.c b/fs/fhandle.c
> > > > index ab4891925b52..54081e19f594 100644
> > > > --- a/fs/fhandle.c
> > > > +++ b/fs/fhandle.c
> > > > @@ -173,7 +173,7 @@ SYSCALL_DEFINE5(name_to_handle_at, int, dfd, const char __user *, name,
> > > >       return err;
> > > >  }
> > > >
> > > > -static int get_path_anchor(int fd, struct path *root)
> > > > +static int get_path_anchor(int fd, struct path *root, int handle_type)
> > > >  {
> > > >       if (fd >= 0) {
> > > >               CLASS(fd, f)(fd);
> > > > @@ -193,6 +193,24 @@ static int get_path_anchor(int fd, struct path *root)
> > > >               return 0;
> > > >       }
> > > >
> > > > +     /*
> > > > +      * Only autonomous handles can be decoded without a file
> > > > +      * descriptor.
> > > > +      */
> > > > +     if (!(handle_type & FILEID_IS_AUTONOMOUS))
> > > > +             return -EOPNOTSUPP;
> > >
> > > This somewhat ties to my comment to patch 5 that if someone passed invalid
> > > fd < 0 before, we'd be returning -EBADF and now we'd be returning -EINVAL
> > > or -EOPNOTSUPP based on FILEID_IS_AUTONOMOUS setting. I don't care that
> > > much about it so feel free to ignore me but I think the following might be
> > > more sensible error codes:
> > >
> > >         if (!(handle_type & FILEID_IS_AUTONOMOUS)) {
> > >                 if (fd == FD_INVALID)
> > >                         return -EOPNOTSUPP;
> > >                 return -EBADF;
> > >         }
> > >
> > >         if (fd != FD_INVALID)
> > >                 return -EBADF; (or -EINVAL no strong preference here)
> >
> > FWIW, I like -EBADF better.
> > it makes the error more descriptive and keeps the flow simple:
> >
> > +       /*
> > +        * Only autonomous handles can be decoded without a file
> > +        * descriptor and only when FD_INVALID is provided.
> > +        */
> > +       if (fd != FD_INVALID)
> > +               return -EBADF;
> > +
> > +       if (!(handle_type & FILEID_IS_AUTONOMOUS))
> > +               return -EOPNOTSUPP;
> >
> 
> Thinking about it some more, as I am trying to address your concerns
> about crafting autonomous file handles by systemd, as you already
> decided to define a range for kernel reserved values for fd, why not,
> instead of requiring FD_INVALID for autonomous file handle, that we
> actually define a kernel fd value that translates to "the root of pidfs":
> 
> +       /*
> +        * Autonomous handles can be decoded with a special file
> +        * descriptor value that describes the filesystem.
> +        */
> +       switch (fd) {
> +       case FD_PIDFS_ROOT:
> +               pidfs_get_root(root);
> +               break;
> +       default:
> +               return -EBADF;
> +       }
> +
> 
> Then you can toss all my old ideas, including FILEID_IS_AUTONOMOUS,
> and EXPORT_OP_AUTONOMOUS_HANDLES and you do not even need
> to define FILEID_PIDFS anymore, just keep exporting FILEID_KERNFS
> as before (you can also keep the existing systemd code) and when you want
> to open file by handle you just go
> open_by_handle_at(FD_PIDFS, &handle, 0)
> and that's it.
> 
> In the end, my one and only concern with autonomous file handles is that
> there should be a user opt-in to request them.
> 
> Sorry for taking the long road to get to this simpler design.
> WDYT?

And simply place FD_PIDFS_ROOT into the -10000 range?
Sounds good to me.

