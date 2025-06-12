Return-Path: <linux-fsdevel+bounces-51391-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71961AD661B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 05:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 089B33AC30E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 03:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83551DDA1B;
	Thu, 12 Jun 2025 03:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZO8jzZG6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498DABE5E;
	Thu, 12 Jun 2025 03:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749698408; cv=none; b=GeJKc2BV0nwn0E2iTovR32xbzJevEx1xsTv3QpeIe/jpdNG9EfwgO+RHJDncra/H1wgZ+WzjvsQeshObcD0DLbndelnXUt6GputwEjZIboKnF/158i2vRQcb51nxCqyA0D1cp2S9unRLWP3kQf3HjrBR1zvTKVfUeoJYvFO7eyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749698408; c=relaxed/simple;
	bh=JKrGxfJ9bY1VdlddKbZBYtnIpnFbzfj0wQ2bxGETc00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PT5ZHlcwCO1pCrquh+ky7M12KbDnQXRRbRrqADWTtU79W9gR97fG1Do8frQ2iKPbYyOOTyjdxcKS2h932c9pZgUYM7veuoRfxvbxyH2QT+9QMZhpUXP9wMKD9UI9f8bwDCvOfjz1Gre6bkNQVdeKuFmmXr5qOxed6IBs+HgWH7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZO8jzZG6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE41CC4CEEB;
	Thu, 12 Jun 2025 03:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749698407;
	bh=JKrGxfJ9bY1VdlddKbZBYtnIpnFbzfj0wQ2bxGETc00=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZO8jzZG6flEz1SlEaeLqAhfI48cg+Uq9RT214hBXxLaVla0kh6yZbqDfd/5j9AIcy
	 hg7FRB34On826XdWb/njONmiWCIuYU/AURBB5w7dy+Y14OTQAF40sRpkqMs2jp8YtT
	 oB8XxVJoOQJW2bxCGMBlUTVY2VlYboLfvfLB3zV61kdoTp9JXq1ptOoC+AhuWAgdTL
	 9KV/4vKzn76SkaGv8myx9Puu0MBmiJqryXzBp5TEFe4tAgw87v5Im/p8VkvFe3bsqe
	 gpztu9Iof9weAwIfiQTLtbgqkmLoq277bbqUiPNuX5RjxiLfj07a9c/VTWYEob9vij
	 8yQp77MlyII8w==
Date: Wed, 11 Jun 2025 20:20:07 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Amir Goldstein <amir73il@gmail.com>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, John@groves.net,
	bernd@bsbernd.com, miklos@szeredi.hu, joannelkoong@gmail.com,
	Josef Bacik <josef@toxicpanda.com>,
	linux-ext4 <linux-ext4@vger.kernel.org>,
	Allison Karlitskaya <lis@redhat.com>
Subject: Re: [RFC[RAP]] fuse: use fs-iomap for better performance so we can
 containerize ext4
Message-ID: <20250612032007.GD6134@frogsfrogsfrogs>
References: <20250521235837.GB9688@frogsfrogsfrogs>
 <CAOQ4uxh3vW5z_Q35DtDhhTWqWtrkpFzK7QUsw3MGLPY4hqUxLw@mail.gmail.com>
 <20250529164503.GB8282@frogsfrogsfrogs>
 <CAOQ4uxgqKO+8LNTve_KgKnAu3vxX1q-4NaotZqeLi6QaNMHQiQ@mail.gmail.com>
 <20250609223159.GB6138@frogsfrogsfrogs>
 <CAOQ4uxgUVOLs070MyBpfodt12E0zjUn_SvyaCSJcm_M3SW36Ug@mail.gmail.com>
 <20250610190026.GA6134@frogsfrogsfrogs>
 <20250611115629.GL784455@mit.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611115629.GL784455@mit.edu>

On Wed, Jun 11, 2025 at 10:56:29AM -0100, Theodore Ts'o wrote:
> +Allison Karlitskaya
> 
> On Tue, Jun 10, 2025 at 12:00:26PM -0700, Darrick J. Wong wrote:
> > > High level fuse interface is not the right tool for the job.
> > > It's not even the easiest way to have written fuse2fs in the first place.
> > 
> > At the time I thought it would minimize friction across multiple
> > operating systems' fuse implementations.
> > 
> > > High-level fuse API addresses file system objects with full paths.
> > > This is good for writing simple virtual filesystems, but it is not the
> > > correct nor is the easiest choice to write a userspace driver for ext4.
> > 
> > Agreed, it's a *terrible* way to implement ext4.
> > 
> > I think, however, that Ted would like to maintain compatibility with
> > macfuse and freebsd(?) so he's been resistant to rewriting the entire
> > program to work with the lowlevel library.
> 
> My priority is to make sure that we have compatibility with other OS's
> (in particular MacOS, FreeBSD, if possible Windows, although that's
> not something that I develop against or have test vehicles to
> validate).  However, from what I can tell, they all support Fuse3 at
> this point --- MacFuse, FreeBSD, and WinFSP all have Fuse3 support as
> of today.
> 
> The only complaint that I've had about breaking support using Fuse2
> was from Allison (Cc'ed), who was involved with another Github
> project, whose Github Actions break because they were using a very old
> version of Ubuntu LTS 20.04), which only had support for libfuse2.  I
> am going to assume that this is probably only because they hadn't
> bothered to update their .github/workflows/ci.yaml file, and not
> because there was any inherit requirement that we support ancient
> versions of Linux distributions.  (When I was at IBM, I remember
> having to support customers who used RHEL4, and even in one extreme
> case, RHEL3 because there were a customer paying $$$$$ that refused to
> update; but that was well over a decade ago, and at this point, I'm
> finding it a lot harder to care about that.  :-)
> 
> My plan is that after I release 1.47.2 (which will have some
> interesting data corruption bugfixes thanks to Darrick and other users
> using fuse2fs in deadly earnest, as opposed to as a lightweight way to
> copy files in and out of an file system image), I plan to transition
> the master and next branches for the future 1.48 release, and the
> maint branch will have bug fixes for 1.47.N releases.
> 
> At that point, unless I hear some very strong arguments against, for
> 1.48, my current thinking is that we will drop support for Fuse2.  I
> will still care about making sure that fuse2fs will build and work
> well enough that casual file copies work on MacOS and FreeBSD, and
> I'll accept patches that make fuse2fs work with WinFSP.  In practice,
> this means that Linux-specific things like Verity support will need to
> be #ifdef'ed so that they will build against MacFUSE, and I assume the
> same will be true for fuseblk mode and iomap mode(?).

<nod> I might just drop fuseblk mode since it's unusable for
unprivileged userspace and regular files; and is a real pain even for
"I'm pretending to be the kernel" mode.

> This may break the github actions for composefs-rs[1], but I'm going
> to assume that they can figure out a way to transition to Fuse3
> (hopefully by just using a newer version of Ubuntu, but I suppose it's
> possible that Rust bindings only exist for Fuse2, and not Fuse3).  But
> in any case, I don't think it makes sense to hold back fuse2fs
> development just for the sake of Ubuntu Focal (LTS 20.04).  And if
> necessary, composefs-rs can just stay back on e2fsprogs 1.47.N until
> they can get off of Fuse2 and/or Ubuntu 20.04.  Allison, does that
> sound fair to you?
> 
> [1] https://github.com/containers/composefs-rs
> 
> Does anyone else have any objections to dropping Fuse2 support?  And
> is that sufficient for folks to more easily support iomap mode in
> fuse2fs?

I don't have any objections to cleaning the fuse2 crud out of fuse2fs.

I /do/ worry that rewriting fuse2fs to target the lowlevel fuse3 library
instead of the highlevel one is going to break the !linux platforms.
Although I *think* macfuse and freebsd fuse actually support the
lowlevel library will be ok, I do worry that we might lose windows
support.  I can't tell if winfsp or dokan are what you're supposed to
use there, but afaict neither of them support the lowlevel interface.

That said, I could just fork fuse2fs and make the fork ("fuse4fs") talk
to the lowlevel library, and we can see what happens when/if people try
to build it on those platforms.

(Though again I have zero capacity to build macos or windows programs...)

TBH it might be a huge relief to just start with a new fuse4fs codebase
where I can focus on making iomap the single IO path that works really
well, rather than try to support the existing one.  There's a lot of IO
manager changes in the fuse2fs+iomap prototype that I think just go away
if you don't need to support doing the file IO yourself.

Any code that's shareable between fuse[24]fs should of course get split
out, which should ease the maintenance burden of having two fuse
servers.  Most of fuse2fs' "smarts" are just calling libext2fs anyway.
Maybe someday we can pull an egcs. :P

> Cheers,
> 
> 							- Ted
> 
> P.S.  Greetings from Greenland.  :-)  (We're currently in the middle of
> a cruise that started in Iceland, and will be ending in New York City
> next week.)

Heh, enjoy your cruise!!

--D

