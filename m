Return-Path: <linux-fsdevel+bounces-51358-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33410AD5EF6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 21:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D0D33A9EAA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 19:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7CD02BD01E;
	Wed, 11 Jun 2025 19:23:22 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A604029AB0E
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Jun 2025 19:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749669802; cv=none; b=nGvGJze4AMfkRhwxwQHEGToEq6NSM+ri7bJ7aVzDHUFC8PIJh6sqyqlNctub0+9r6KTvaT5ZG7TiF+f7cwx0L70p7GGsHTLzRxVbKXO6ZFQ7QPXAtRrPSUCg/SH0VSyt6l+97Jw+2cVWMpYQPpITpN0dims0bzBGqij8r+HrAoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749669802; c=relaxed/simple;
	bh=wdAUIfA6Vz+0pVx2FNnom2a0zaaWLcLTW0x1GvWk3Bk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XokmEYMlZJcFkp5z7wdxBZRmOx+WWOrxrfVm2Wu9k1fRSmbJxYQr5hC+UEiWeS+BVUwclyOWs6C1WtuluL97q7Hz3ChctICENtG5BnU4Ts9xsxF44GjsmfBDsTLAtVBtRAjOYUejf+eZquSqlZeK46MYcUjNAuItKjrJM/DR7cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org ([154.16.192.62])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 55BJMp6G027563
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Jun 2025 15:22:53 -0400
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id E6850346B78; Wed, 11 Jun 2025 07:56:29 -0400 (EDT)
Date: Wed, 11 Jun 2025 10:56:29 -0100
From: "Theodore Ts'o" <tytso@mit.edu>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>, John@groves.net,
        bernd@bsbernd.com, miklos@szeredi.hu, joannelkoong@gmail.com,
        Josef Bacik <josef@toxicpanda.com>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        Allison Karlitskaya <lis@redhat.com>
Subject: Re: [RFC[RAP]] fuse: use fs-iomap for better performance so we can
 containerize ext4
Message-ID: <20250611115629.GL784455@mit.edu>
References: <20250521235837.GB9688@frogsfrogsfrogs>
 <CAOQ4uxh3vW5z_Q35DtDhhTWqWtrkpFzK7QUsw3MGLPY4hqUxLw@mail.gmail.com>
 <20250529164503.GB8282@frogsfrogsfrogs>
 <CAOQ4uxgqKO+8LNTve_KgKnAu3vxX1q-4NaotZqeLi6QaNMHQiQ@mail.gmail.com>
 <20250609223159.GB6138@frogsfrogsfrogs>
 <CAOQ4uxgUVOLs070MyBpfodt12E0zjUn_SvyaCSJcm_M3SW36Ug@mail.gmail.com>
 <20250610190026.GA6134@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250610190026.GA6134@frogsfrogsfrogs>

+Allison Karlitskaya

On Tue, Jun 10, 2025 at 12:00:26PM -0700, Darrick J. Wong wrote:
> > High level fuse interface is not the right tool for the job.
> > It's not even the easiest way to have written fuse2fs in the first place.
> 
> At the time I thought it would minimize friction across multiple
> operating systems' fuse implementations.
> 
> > High-level fuse API addresses file system objects with full paths.
> > This is good for writing simple virtual filesystems, but it is not the
> > correct nor is the easiest choice to write a userspace driver for ext4.
> 
> Agreed, it's a *terrible* way to implement ext4.
> 
> I think, however, that Ted would like to maintain compatibility with
> macfuse and freebsd(?) so he's been resistant to rewriting the entire
> program to work with the lowlevel library.

My priority is to make sure that we have compatibility with other OS's
(in particular MacOS, FreeBSD, if possible Windows, although that's
not something that I develop against or have test vehicles to
validate).  However, from what I can tell, they all support Fuse3 at
this point --- MacFuse, FreeBSD, and WinFSP all have Fuse3 support as
of today.

The only complaint that I've had about breaking support using Fuse2
was from Allison (Cc'ed), who was involved with another Github
project, whose Github Actions break because they were using a very old
version of Ubuntu LTS 20.04), which only had support for libfuse2.  I
am going to assume that this is probably only because they hadn't
bothered to update their .github/workflows/ci.yaml file, and not
because there was any inherit requirement that we support ancient
versions of Linux distributions.  (When I was at IBM, I remember
having to support customers who used RHEL4, and even in one extreme
case, RHEL3 because there were a customer paying $$$$$ that refused to
update; but that was well over a decade ago, and at this point, I'm
finding it a lot harder to care about that.  :-)

My plan is that after I release 1.47.2 (which will have some
interesting data corruption bugfixes thanks to Darrick and other users
using fuse2fs in deadly earnest, as opposed to as a lightweight way to
copy files in and out of an file system image), I plan to transition
the master and next branches for the future 1.48 release, and the
maint branch will have bug fixes for 1.47.N releases.

At that point, unless I hear some very strong arguments against, for
1.48, my current thinking is that we will drop support for Fuse2.  I
will still care about making sure that fuse2fs will build and work
well enough that casual file copies work on MacOS and FreeBSD, and
I'll accept patches that make fuse2fs work with WinFSP.  In practice,
this means that Linux-specific things like Verity support will need to
be #ifdef'ed so that they will build against MacFUSE, and I assume the
same will be true for fuseblk mode and iomap mode(?).

This may break the github actions for composefs-rs[1], but I'm going
to assume that they can figure out a way to transition to Fuse3
(hopefully by just using a newer version of Ubuntu, but I suppose it's
possible that Rust bindings only exist for Fuse2, and not Fuse3).  But
in any case, I don't think it makes sense to hold back fuse2fs
development just for the sake of Ubuntu Focal (LTS 20.04).  And if
necessary, composefs-rs can just stay back on e2fsprogs 1.47.N until
they can get off of Fuse2 and/or Ubuntu 20.04.  Allison, does that
sound fair to you?

[1] https://github.com/containers/composefs-rs

Does anyone else have any objections to dropping Fuse2 support?  And
is that sufficient for folks to more easily support iomap mode in
fuse2fs?

Cheers,

							- Ted

P.S.  Greetings from Greenland.  :-)  (We're currently in the middle of
a cruise that started in Iceland, and will be ending in New York City
next week.)

