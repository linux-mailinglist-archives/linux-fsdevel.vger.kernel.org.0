Return-Path: <linux-fsdevel+bounces-7841-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3788982B8FE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jan 2024 02:11:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 500051C2401C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jan 2024 01:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90DA210FE;
	Fri, 12 Jan 2024 01:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rI9GGQXG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA0EA3F
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jan 2024 01:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 11 Jan 2024 20:10:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705021851;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6oGLhiFkWJYxCQX4sImM6I3DqLEsgGCfjkZs61RF9Oo=;
	b=rI9GGQXGx7EXaFlxyd08Frv8dXmrBR3n85SDViVMju9SdaRaaG3W5Qy3t0KmnemS+jJYFV
	rWDOj85l2M/iD/zZBnMc1tsmtB9LB6FmDdqRYxSEBlqJ0WDaUNkKk+u0Q5rD6JkmZfU7DM
	AztHuQQ9RALaMvDDp9eslPwBfaZNvps=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Mark Brown <broonie@kernel.org>
Cc: Kees Cook <keescook@chromium.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Nikolai Kondrashov <spbnick@gmail.com>
Subject: Re: [GIT PULL] bcachefs updates for 6.8
Message-ID: <olmilpnd7jb57yarny6poqnw6ysqfnv7vdkc27pqxefaipwbdd@4qtlfeh2jcri>
References: <wq27r7e3n5jz4z6pn2twwrcp2zklumcfibutcpxrw6sgaxcsl5@m5z7rwxyuh72>
 <202401101525.112E8234@keescook>
 <6pbl6vnzkwdznjqimowfssedtpawsz2j722dgiufi432aldjg4@6vn573zspwy3>
 <202401101625.3664EA5B@keescook>
 <xlynx7ydht5uixtbkrg6vgt7likpg5az76gsejfgluxkztukhf@eijjqp4uxnjk>
 <be2fa62f-f4d3-4b1c-984d-698088908ff3@sirena.org.uk>
 <gaxigrudck7pr3iltgn3fp5cdobt3ieqjwohrnkkmmv67fctla@atcpcc4kdr3o>
 <f8023872-662f-4c3f-9f9b-be73fd775e2c@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8023872-662f-4c3f-9f9b-be73fd775e2c@sirena.org.uk>
X-Migadu-Flow: FLOW_OUT

On Thu, Jan 11, 2024 at 09:47:26PM +0000, Mark Brown wrote:
> On Thu, Jan 11, 2024 at 12:38:57PM -0500, Kent Overstreet wrote:
> > On Thu, Jan 11, 2024 at 03:35:40PM +0000, Mark Brown wrote:
> 
> > > IME the actually running the tests bit isn't usually *so* much the
> > > issue, someone making a new test runner and/or output format does mean a
> > > bit of work integrating it into infrastructure but that's more usually
> > > annoying than a blocker.
> 
> > No, the proliferation of test runners, test output formats, CI systems,
> > etc. really is an issue; it means we can't have one common driver that
> > anyone can run from the command line, and instead there's a bunch of
> > disparate systems with patchwork integration and all the feedback is nag
> > emails - after you've finished whan you were working on instead of
> > moving on to the next thing - with no way to get immediate feedback.
> 
> It's certainly an issue and it's much better if people do manage to fit
> their tests into some existing thing but I'm not convinced that's the
> big reason why you have a bunch of different systems running separately
> and doing different things.  For example the enterprise vendors will
> naturally tend to have a bunch of server systems in their labs and focus
> on their testing needs while I know the Intel audio CI setup has a bunch
> of laptops, laptop like dev boards and things in there with loopback
> audio cables and I think test equipment plugged in and focuses rather
> more on audio.  My own lab is built around on systems I can be in the
> same room as without getting too annoyed and does things I find useful,
> plus using spare bandwidth for KernelCI because they can take donated
> lab time.

No, you're overthinking.

The vast majority of kernel testing requires no special hardware, just a
virtual machine.

There is _no fucking reason_ we shouldn't be able to run tests on our
own local machines - _local_ machines, not waiting for the Intel CI
setup and asking for a git branch to be tested, not waiting for who
knows how long for the CI farm to get to it - just run the damn tests
immediately and get immediate feedback.

You guys are overthinking and overengineering and ignoring the basics,
the way enterprise people always do.

> > And it's because building something shiny and new is the fun part, no
> > one wants to do the grungy integration work.
> 
> I think you may be overestimating people's enthusiasm for writing test
> stuff there!  There is NIH stuff going on for sure but lot of the time
> when you look at something where people have gone off and done their own
> thing it's either much older than you initially thought and predates
> anything they might've integrated with or there's some reason why none
> of the existing systems fit well.  Anecdotally it seems much more common
> to see people looking for things to reuse in order to save time than it
> is to see people going off and reinventing the world.

It's a basic lack of leadership. Yes, the younger engineers are always
going to be doing the new and shiny, and always going to want to build
something new instead of finishing off the tests or integrating with
something existing. Which is why we're supposed to have managers saying
"ok, what do I need to prioritize for my team be able to develop
effectively".

> 
> > > > example tests, example output:
> > > > https://evilpiepirate.org/git/ktest.git/tree/tests/bcachefs/single_device.ktest
> > > > https://evilpiepirate.org/~testdashboard/ci?branch=bcachefs-testing
> 
> > > For example looking at the sample test there it looks like it needs
> > > among other things mkfs.btrfs, bcachefs, stress-ng, xfs_io, fio, mdadm,
> > > rsync
> 
> > Getting all that set up by the end user is one command:
> >   ktest/root_image create
> > and running a test is one morecommand:
> > build-test-kernel run ~/ktest/tests/bcachefs/single_device.ktest
> 
> That does assume that you're building and running everything directly on
> the system under test and are happy to have the test in a VM which isn't
> an assumption that holds universally, and also that whoever's doing the
> testing doesn't want to do something like use their own distro or
> something - like I say none of it looks too unreasonable for
> filesystems.

No, I'm doing it that way because technically that's the simplest way to
do it.

All you guys building crazy contraptions for running tests on Google
Cloud or Amazon or whatever - you're building technical workarounds for
broken procurement.

Just requisition the damn machines.

> Some will be, some will have more demanding requirements especially when
> you want to test on actual hardware rather than in a VM.  For example
> with my own test setup which is more focused on hardware the operating
> costs aren't such a big deal but I've got boards that are for various
> reasons irreplaceable, often single instances of boards (which makes
> scheduling a thing) and for some of the tests I'd like to get around to
> setting up I need special physical setup.  Some of the hardware I'd like
> to cover is only available in machines which are in various respects
> annoying to automate, I've got a couple of unused systems waiting for me
> to have sufficient bandwidth to work out how to automate them.  Either
> way I don't think the costs are trival enough to be completely handwaved
> away.

That does complicate things.

I'd also really like to get automated performance testing going too,
which would have similar requirements in that jobs would need to be
scheduled on specific dedicated machines. I think what you're doing
could still build off of some common infrastructure.

> I'd also note that the 9 hour turnaround time for that test set you're
> pointing at isn't exactly what I'd associate with immediate feedback.

My CI shards at the subtest level, and like I mentioned I run 10 VMs per
physical machine, so with just 2 of the 80 core Ampere boxes I get full
test runs done in ~20 minutes.

