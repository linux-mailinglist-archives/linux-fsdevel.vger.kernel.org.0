Return-Path: <linux-fsdevel+bounces-17212-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C9AB8A9033
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Apr 2024 02:55:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D81D1F21D88
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Apr 2024 00:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A134010976;
	Thu, 18 Apr 2024 00:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q9SWBlVP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF33A938
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Apr 2024 00:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713401699; cv=none; b=OXqdmHOAaPW1W9OzJJvBRC0MmQt4wESpaozF5TJHgH1Wh9vq1+kKygSvE8Ied8IfeNZ4M6dxAY3WVJKXNE1ByaD9Ic/Dl0Q/8tJZpUxnNTDZUaSqhLP6tCUS3b5SxPmDlzCO0xOCmRz4yInOaCCsT5a5bs4tAj80pO3n1zNZELo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713401699; c=relaxed/simple;
	bh=nNQZnzprETnUe07Rz0786AarczxAcMabbtAhiPRrjM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e4T3X8zygCZBpDHQKJET0Z6WyXmpoXclgz0ebswL/et/JvWW0zQcYERN48J4QfUCdB8EcrIMBjzuJv4iIT3xUZxSAqHIoNFT7+uzLT6ywIrSmZWh+od9DtNxrzIaFNC5tLOnaFt+7IfSJ/+Jse5EBOIDkl83XPOtSIW2JFYSSqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q9SWBlVP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 948BCC072AA;
	Thu, 18 Apr 2024 00:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713401698;
	bh=nNQZnzprETnUe07Rz0786AarczxAcMabbtAhiPRrjM4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q9SWBlVP7HTdvQCgBWdt/ic8AGFu+lItmy2UL/IwvEqiYSEkBwIWe/r6a1cL7SSYe
	 ZKACTxukXfJEE7Wa3JiYUPg+nHf+qm6hx8ScMZSiIHmYB+ZleWvSByDEyNx/HgR9Rm
	 +20XXc6xpjk01RkCkugmaKdvQK0Jxy3MJnFsPrUG7/ZI/tuABWJ3uGPC62TZb19euV
	 6MR8SKm6g7ULbwqAUqp9zLT/TUIzKwj/0WbAyTRH/eIQf6/BSQmlokDjjNUxMD31LA
	 4nNjAtPrPj8ory8IoOesQL4BZdcKDOzSD1suPRwJLIzQloEyTeFiJ/7NGfmLVm+Rrs
	 BK8yjKNp48YOQ==
Date: Wed, 17 Apr 2024 17:54:57 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-fsdevel@vger.kernel.org, lsf-pc@lists.linux-foundation.org,
	kernel-team@fb.com
Subject: Re: [LSF/MM/BPF TOPIC] Changing how we do file system maintenance
Message-ID: <20240418005457.GA11927@frogsfrogsfrogs>
References: <20240416180414.GA2100066@perftesting>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416180414.GA2100066@perftesting>

On Tue, Apr 16, 2024 at 02:04:14PM -0400, Josef Bacik wrote:
> Hello,
> 
> There have been a few common themes that have come up over the years that I feel
> like we should address.
> 
> 1. Adding new file systems.  This is a long and painful process, and I think it
>    should be more painful in order to encourage more FUSE use cases.  However, a
>    lot of the reason it's painful is because it's a "send to Linus and see what
>    happens" sort of process.  Obviously a lot of us get a say, but there's a
>    sort of arbitrary point where it becomes "well send a PR to Linus and see
>    what he thinks."  This is annoying for people who review stuff who may have
>    legitimate concerns, and it's annoying for new file systems who aren't sure
>    what feedback they're supposed to take seriously and what feedback is safe to
>    ignore.

What if we used the time at LSF to hammer out some guideline docs that
define one or two tiers of support for filesystems and what qualities
that filesystem and its project must have to attain that tier.

Tier 1 would be (for example) ext/xfs/btrfs/bcachefs, and anything
intended to be used as daily driver filesystem on Linux.  Regular
testing via fstests and contributions to for-next are required.  There
ought to be some defined roles (e.g. release manager, QA leads, various
levels of developers, documenters, LTS sustaining, bug triager, etc.).
The roles can be assigned to a group of people who each can work on the
code at least 50% of the time.

Tier 2 would be the smaller fs projects (jfs, etc).  Periodic testing is
still required, but there wouldn't need to be as much structure as tier
1.  Anyone building a hardened linux distribution would likely not
enable the tier 2 filesystems.  Perhaps the more general distributions
could devise a way to ask the device's user if they really want to mount
a tier 2 fs on its storage.

Tier 3 is bitrotting in the kernel and will get kicked out if it gets
in the way of a treewide cleanup or suffers major security problems.

(This isn't a fleshed out proposal, merely my reflections on the way
things are more or less right now.)

Then we say that a filesystem must be a good fit with the goals and
requirements of tiers 1 or 2 to get added, and will be deprecated and
removed if they fall out of tier 2 for more than a year.

(Oh hey, you advocate for something like this below!  Cool!)

> 2. Removing file systems.  We've gotten some good guidance from Greg and others
>    on this, but this still becomes a thing where nobody feels particularly
>    empowered to send the first patch of actually removing a file system.  In
>    super obvious cases it's easier, but there's a lot of non-obvious cases where
>    we kind of sit here and talk about it without doing anything.
> 
> 3. API changes.  Sometimes we make API changes in the core code and then
>    provided helpers for the other file systems to use until they're converted,
>    and that long tail goes on forever.

You mean like buffer heads? ;)

>                                         We generally avoid doing work that
>    touches all the file systems because we have to coordinate with at least 4
>    major trees.

I don't like adding user interfaces -- we spend a /lot/ of time arguing
about minor points of new ioctls and syscalls, not really enough time
documenting or writing tests for them, and then after v20 gets posted it
turns into "send a PR to Linus and see if he complains".

From my observation, people (myself included) act like they're afraid
that an interface is baked in stone forever and therefore everything has
to be perfect.  Nobody seems to think it practicable to have a kernel
call nursery to try out new functionality that can be withdrawn or
changed ... but if it's critical to get it right on the first try, why
isn't there a bunch of guidelines and a working group to support this?

>                 I'm particularly guilty of this one, I didn't even notice when
>    the new mount API went in, and then I wasn't sufficiently motivated to work
>    on it until it intersected with some other work I was doing.  I was easily
>    halfway through the work when I found out that Christian had done all of the
>    work for us previously, which brings me to #4.

<rant>
The transition to the new mount API has not been managed.  The author
wrote the initial patches, converted a few filesystems, and then moved
on to other things without communicating much of a plan to get the rest
of the filesystems converted.  Now his manager(!) seems to be doing the
rest of the work himself.  There still aren't even manual pages for the
new syscalls, and it's been five years since the code got merged.
</rant>

> 4. We all have our own ways of doing things, but we're all really similar at the
>    same time.  In btrfs land we prefer small, bitesize patches.  This makes it
>    easier for review, easier for bisecting, etc.  This exists because we take in
>    3x the number of changes as any other file system, we have been bitten
>    several times by some 6'4" jackass with a swearing problem with a 6000 line
>    patch with an unhelpful changelog.  I've had developers get frustrated with

At the opposite extreme, we have a 6'0" jackass with a swearing problem
who sends 600 patches in a week with changelogs that are bitrotting
because he can't keep track of all that, and review is painfully slow. :P

>    our way of running our tree because it's setup differently than others. At
>    the end of the day however a lot of our policies exist to make it as easy as
>    possible for everybody involved to understand what is going on, and to make
>    sure we don't repeat previous mistakes.  At the same time we all do a lot of
>    the same things, emphasize patch review and testing.
> 
> There are other related problems, but these are the big ones as I see them.
> 
> I would like to propose we organize ourselves more akin to the other large

IOWs, this is "5. Maintaining file systems."? :)

> subsystems.  We are one of the few where everybody sends their own PR to Linus,
> so oftentimes the first time we're testing eachothers code is when we all rebase
> our respective trees onto -rc1.  I think we could benefit from getting more
> organized amongst ourselves, having a single tree we all flow into, and then
> have that tree flow into Linus.

I think it takes too long to get feedback on patches.  There's too much
knowledge that is either locked up in peoples' brains or available only
after deep studying of a lot of kernel code, which means that junior
engineers tell me they don't see any point in reviewing patches because
someone senior will see the flaws in a given patch that they don't.  I
think that reflects a need for better mentorship so that those junior
people can get the experience they need to become senior.

(At the same time, I'm a senior person, and I'm so burnt out that I
would not and do not _make_ a good mentor.)

> I'm also not a fan of single maintainers in general, much less for this large of
> an undertaking.  I would also propose that we have a maintainership group where
> we rotate the responsibilities of the mechanics of running a tree like this.

+1 to this.  Single maintainership is a *very bad idea* for complex
codebases like filesystems.  xfs have burned through/out two maintainers
in 10 years; I'm surprised that btrfs and ext still have theirs.

Back when I was maintainer of fs/iomap/, I was careful to push all the
changes for the next cycle into for-next during the week after -rc4 so
that all five filesystems that use it would have a month or so where the
-next testing would (hopefully) shake out the problems.  That did not
make me popular.

> I'm nothing if not unreliable so I wouldn't be part of this group per se, but I
> don't think we should just make Christian do it.  This would be a big job, and
> it would need to be shared.

Heh.

> I would also propose that along with this single tree and group maintainership
> we organize some guidelines about the above problems and all collectively agree
> on how we're going to address them.  Having clear guidelines for adding new file
> systems, clear guidelines for removing them.  Giving developers the ability to
> make big API changes outside of the individual file systems trees to make it
> easier to get things merged instead of having to base against 4 or 5 different
> trees.  Develop some guidelines about how we want patches to look, how we want
> testing to be done, etc. so people can move through our different communities
> and not have drastically different experiences.

Can we also find a way to attract some people who specialize in fs
tooling so that the rest of us can retire our homebrew gluepots of bash
scripts (speaking only for myself, obviously).

> This is a massive proposal, and not one that we're going to be able to nail down
> and implement quickly or easily.  But I think in the long term it'll make
> working in our community simpler, more predictable, and less frustrating for
> everybody.  Thanks,

Frankly I would be totally happy if we had a driver to cache file
mappings provided through a fuse-like interface and feed them to iomap
as needed.  Then we could eject most filesystms from the kernel and
never have to deal with it ever again.  That would probably suck hard
for most of the COW filesystems though...

--D

> 
> Josef
> 

