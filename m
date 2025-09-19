Return-Path: <linux-fsdevel+bounces-62251-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 924A9B8ACB4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 19:42:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6B4F5A6EAC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 17:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D7532254F;
	Fri, 19 Sep 2025 17:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PHwDOxA+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153C61DD543;
	Fri, 19 Sep 2025 17:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758303739; cv=none; b=t71+opxUNlO6F8FZV4RoTMRKOKK1z0ybbobA73sFlauXc87EbPU5BJEc+fnIOunvo/eqT5og3ePfJTnoYkbrFfBl9FNbDP2H6QlaR9yy2ywWYHcJPMUGGa0tA90WD8uAB9ghlhLXLCVemxn2uIDtBCxyiNxDbjRlsj53dU9md4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758303739; c=relaxed/simple;
	bh=Th5bUbEZmOHY9hvIpQNIVC4LEnB8Ks6CrxC8wdKtVkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ero7Kt859kHmE13ljzeIwMAdoHF8Y6eBwUG6m0ljQkmP3noNYKPb+kvOAgCNXDfQHV3kYh392viNweJxYsYtqxOuPjg9PnuUrLTyw6wPMTHH1+yW1/ZHSoBuU4dSCutk0y/b+P9f97uP7oAV8wkFZ/6WhYT+X8OELdSnOHUjB6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PHwDOxA+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CD25C4CEF0;
	Fri, 19 Sep 2025 17:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758303738;
	bh=Th5bUbEZmOHY9hvIpQNIVC4LEnB8Ks6CrxC8wdKtVkM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PHwDOxA+2WanjtUS6HKHxHrm2tqB17AAHhkTb8d3ERSE6o2PumAQmpqdSYYK9+R52
	 3vIBTmx/YeAgoxq7LRLRGYUuJ/Ja+UlpdLDusUu6vUvFH1s29oVeSgILPXfH8mLWfY
	 K09JylFAh2uSDdS5DnfbdUaX9ul4QmX/jrDex70JL2dOeDZtY0uHHbB3+3CUuSmik9
	 FRCqF80WyRm/Ky+iWzUJkM7jQukfDAqX7kfHEa/YFoJmP4cblIAKfYsrC12pT7b8tX
	 PF5uwRcJUO2ZlJhnhxjv2ZA9BDhtT7urfhMHqZjGdagaRM6JR4uPpoh3x3js68x76T
	 dk369nmrBGddw==
Date: Fri, 19 Sep 2025 10:42:17 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, bernd@bsbernd.com,
	linux-xfs@vger.kernel.org, John@groves.net,
	linux-fsdevel@vger.kernel.org, neal@gompa.dev,
	joannelkoong@gmail.com
Subject: Re: [PATCH 04/28] fuse: adapt FUSE_DEV_IOC_BACKING_{OPEN,CLOSE} to
 add new iomap devices
Message-ID: <20250919174217.GE8117@frogsfrogsfrogs>
References: <175798151087.382724.2707973706304359333.stgit@frogsfrogsfrogs>
 <175798151352.382724.799745519035147130.stgit@frogsfrogsfrogs>
 <CAOQ4uxibHLq7YVpjtXdrHk74rXrOLSc7sAW7s=RADc7OYN2ndA@mail.gmail.com>
 <20250918181703.GR1587915@frogsfrogsfrogs>
 <CAOQ4uxiH1d3fV0kgiO3-JjqGH4DKboXdtEpe=Z=gKooPgz7B8g@mail.gmail.com>
 <CAJfpegsrBN9uSmKzYbrbdbP2mKxFTGkMS_0Hx4094e4PtiAXHg@mail.gmail.com>
 <CAOQ4uxgvzrJVErnbHW5ow1t-++PE8Y3uN-Fc8Vv+Q02RgDHA=Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxgvzrJVErnbHW5ow1t-++PE8Y3uN-Fc8Vv+Q02RgDHA=Q@mail.gmail.com>

On Fri, Sep 19, 2025 at 11:54:39AM +0200, Amir Goldstein wrote:
> On Fri, Sep 19, 2025 at 9:14 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
> >
> > On Thu, 18 Sept 2025 at 20:42, Amir Goldstein <amir73il@gmail.com> wrote:
> > >
> > > On Thu, Sep 18, 2025 at 8:17 PM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > > > How about restricting the backing ids to RLIMIT_NOFILE?  The @end param
> > > > to idr_alloc_cyclic constrains them in exactly that way.
> > >
> > > IDK. My impression was that Miklos didn't like having a large number
> > > of unaccounted files, but it's up to him.
> >
> > There's no 1:1 mapping between a fuse instance and a "fuse server
> > process", so the question is whose RLIMIT_NOFILE?  Accounting to the
> > process that registered the fd would be good, but implementing it
> > looks exceedingly complex.  Just taking RLIMIT_NOFILE value from the
> > process that is doing the fd registering should work, I guess.

Or perhaps a static limit of 1024 for now, and if someone comes up with
a humongous filesystem that needs more, we can figure out how to support
that later.

Since we're already adding flag bits to the /dev/fuse file::private_data
for synchronous init, I guess we could expand that into a full struct so
that you could open /dev/fuse, ask for various config options, and then
apply them to the fuse_dev when it gets created?

> > There's still the question of unhiding these files.  Latest discussion
> > ended with lets create a proper directory tree for open files in proc.
> > I.e. /proc/PID/fdtree/FD/hidden/...

All the iomap backing files are block devices, perhaps we could put a
symlink in /sys/block/XXX/holders/ to something associated with the
fuse_mount?  Perhaps the s_bdi?

This is a more general problem, because there's no standard way to
figure out that a given bdev is an auxiliary device attached to a
multi-device filesystems (e.g. xfs realtime volume or external log).

The downsides are that "holders" is sysfs-happy and even symlinks
require a target kobject; and lsof doesn't know about holders.  But at
least it wouldn't be 100% invisible like it is now.

> Yes, well, fuse_backing_open() says:
> /* TODO: relax CAP_SYS_ADMIN once backing files are visible to lsof */
> So that's the reason I was saying there is no justification to
> relax this for FUSE_IOMAP as long as this issue is not resolved.
> 
> As Darrick writes, fuse4fs needs only 1 backing blockdev
> and other iomap fuse fs are unlikely to need more than a few
> backing blockdevs.

Until someone has a go at making btrfs-fuse fully functional.  But that
can be their problem. ;)

> So maybe, similar to max_stack_depth, we require the server to
> negotiate the max_backing_id at FUSE_INIT time.
> 
> We could allow any "reasonable" number without any capabilities
> and regardless of RLIMIT_NOFILE or we can account max_backing_id
> in advance for the user setting up the connection.
> 
> For backward compat (or for privileged servers) zero max_backing_id
> means unlimited (within the int32 range) and that requires
> CAP_SYS_ADMIN for fuse_backing_open() regardless of which
> type of backing file it is.
> 
> WDYT?

I think capping at 1024 now (or 256, or even 8) is fine for now, and we
can figure out the request protocol later when someone wants more.

Alternately, I wonder if there's a way to pin the fd that is used to
create the backing id so that the fuse server can't close it?  There's
probably no non-awful way to pin the fd table entry though.

--D

> Thanks,
> Amir.

