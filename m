Return-Path: <linux-fsdevel+bounces-7991-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B1E82E033
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 19:43:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBB9C286C9A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 18:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1320118AF4;
	Mon, 15 Jan 2024 18:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IpLDVZvS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C2A18C08;
	Mon, 15 Jan 2024 18:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 15 Jan 2024 13:42:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705344178;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/DL5zGXc3f2lpK8C4qhcgo7eUWR/Jh/Vtp9T4Cor5uM=;
	b=IpLDVZvSJhL58OrZM3y4plEp15GKp3sH/cEtdM/RRm1JKJ5jP/wvoQDDb2KZSaQm0RCErB
	38eENewE7y2ZiY53GxCiPxw14LfmtHrCS86RqxyNLyqjegH8kSeJ/MIazeX8JEmZcXcr5T
	YwX/t9fFPFQo4ECD8TPw7pl+cD0N2og=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Mark Brown <broonie@kernel.org>
Cc: Neal Gompa <neal@gompa.dev>, Kees Cook <keescook@chromium.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Nikolai Kondrashov <spbnick@gmail.com>, Philip Li <philip.li@intel.com>, 
	Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [GIT PULL] bcachefs updates for 6.8
Message-ID: <2uh4sgj5mqqkuv7h7fjlpigwjurcxoo6mqxz7cjyzh4edvqdhv@h2y6ytnh37tj>
References: <202401101525.112E8234@keescook>
 <6pbl6vnzkwdznjqimowfssedtpawsz2j722dgiufi432aldjg4@6vn573zspwy3>
 <202401101625.3664EA5B@keescook>
 <xlynx7ydht5uixtbkrg6vgt7likpg5az76gsejfgluxkztukhf@eijjqp4uxnjk>
 <be2fa62f-f4d3-4b1c-984d-698088908ff3@sirena.org.uk>
 <gaxigrudck7pr3iltgn3fp5cdobt3ieqjwohrnkkmmv67fctla@atcpcc4kdr3o>
 <f8023872-662f-4c3f-9f9b-be73fd775e2c@sirena.org.uk>
 <olmilpnd7jb57yarny6poqnw6ysqfnv7vdkc27pqxefaipwbdd@4qtlfeh2jcri>
 <CAEg-Je8=RijGLavvYDvw3eOf+CtvQ_fqdLZ3DOZfoHKu34LOzQ@mail.gmail.com>
 <40bcbbe5-948e-4c92-8562-53e60fd9506d@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40bcbbe5-948e-4c92-8562-53e60fd9506d@sirena.org.uk>
X-Migadu-Flow: FLOW_OUT

On Fri, Jan 12, 2024 at 06:22:55PM +0000, Mark Brown wrote:
> This depends a lot on the area of the kernel you're looking at - some
> things are very amenable to testing in a VM but there's plenty of code
> where you really do want to ensure that at some point you're running
> with some actual hardware, ideally as wide a range of it with diverse
> implementation decisions as you can manage.  OTOH some things can only
> be tested virtually because the hardware doesn't exist yet!

Surface wise, there are a lot of drivers that need real hardware; but if
you look at where the complexity is, the hard complex algorithmic stuff
that really needs to be tested thoroughly - that's all essentially
library code that doesn't need specific drivers to test.

More broadly, whenever testing comes up the "special cases and special
hardware" keeps distracting us from making progress on the basics; which
is making sure as much of the kernel as possible can be tested in a
virtual machine, with no special setup.

And if we were better at that, it would be a good nudge towards driver
developers to make their stuff easier to test, perhaps by getting a
virtualized implementation into qemu, or to make the individual drivers
thinner and move heavy logic into easier to test library code.

> Yeah, similar with a lot of the more hardware focused or embedded stuff
> - running something on the machine that's in front of you is seldom the
> bit that causes substantial issues.  Most of the exceptions I've
> personally dealt with involved testing hardware (from simple stuff like
> wiring the audio inputs and outputs together to verify that they're
> working to attaching fancy test equipment to simulate things or validate
> that desired physical parameters are being achieved).

Is that sort of thing a frequent source of regressions?

That sounds like the sort of thing that should be a simple table, and
not something I would expect to need heavy regression testing - but, my
experience with driver development was nearly 15 years ago; not a lot of
day to day. How badly are typical kernel refactorings needing regression
testing in individual drivers?

Filesystem development, OTOH, needs _heavy_ regression testing for
everything we do. Similarly with mm, scheduler; many subtle interactions
going on.

> > > > of the existing systems fit well.  Anecdotally it seems much more common
> > > > to see people looking for things to reuse in order to save time than it
> > > > is to see people going off and reinventing the world.
> 
> > > It's a basic lack of leadership. Yes, the younger engineers are always
> > > going to be doing the new and shiny, and always going to want to build
> > > something new instead of finishing off the tests or integrating with
> > > something existing. Which is why we're supposed to have managers saying
> > > "ok, what do I need to prioritize for my team be able to develop
> > > effectively".
> 
> That sounds more like a "(reproducible) tests don't exist" complaint
> which is a different thing again to people going off and NIHing fancy
> frameworks.

No, it's a leadership/mentorship thing.

And this is something that's always been lacking in kernel culture.
Witness the kind of general grousing that goes on at maintainer summits;
maintainers complain about being overworked and people not stepping up
to help with the grungy responsibilities, while simultaneously we still
very much have a "fuck off if you haven't proven yourself" attitude
towards newcomers. Understandable given the historical realities (this
shit is hard and the penalties of fucking up are high, so there does
need to be a barrier to entry), but it's left us with some real gaps.

We don't have enough a people in the senier engineer role who lay out
designs and organise people to take on projects that are bigger than one
single person can do, or that are necessary but not "fun".

Tests and test infrastructure fall into the necessary but not fun
category, so they languish.

They are also things that you don't really learn the value of until
you've been doing this stuff for a decade or so and you've learned by
experience that yes, good tests really make life easier, as well as how
to write effective tests, and that's knowledge that needs to be
instilled.

> 
> > > > That does assume that you're building and running everything directly on
> > > > the system under test and are happy to have the test in a VM which isn't
> > > > an assumption that holds universally, and also that whoever's doing the
> > > > testing doesn't want to do something like use their own distro or
> > > > something - like I say none of it looks too unreasonable for
> > > > filesystems.
> 
> > > No, I'm doing it that way because technically that's the simplest way to
> > > do it.
> 
> > > All you guys building crazy contraptions for running tests on Google
> > > Cloud or Amazon or whatever - you're building technical workarounds for
> > > broken procurement.
> 
> I think you're addressing some specific stuff that I'm not super
> familiar with here?  My own stuff (and most of the stuff I end up
> looking at) involves driving actual hardware.

Yeah that's fair; that was addressed more towards what's been going on
in the filesystem testing world, where I still (outside of my own stuff)
haven't seen a CI with a proper dashboard of test results; instead a lot
of code has been burned on multi-distro, highly configurable stuff that
targets multiple clouds, but - I want simple and functional, not
whiz-bang features.

> > > Just requisition the damn machines.
> 
> There's some assumptions there which are true for a lot of people
> working on the kernel but not all of them...

$500 a month for my setup (and this is coming out of my patreon funding
right now!). It's a matter of priorities, and being willing to present
this as _necessary_ to the people who control the purse strings.

> > Running in the cloud does not mean it has to be complicated. It can be
> > a simple Buildbot or whatever that knows how to spawn spot instances
> > for tests and destroy them when they're done *if the test passed*. If
> > a test failed on an instance, it could hold onto them for a day or two
> > for someone to debug if needed.
> 
> > (I mention Buildbot because in a previous life, I used that to run
> > tests for the dattobd out-of-tree kernel module before. That was the
> > strategy I used for it.)
> 
> Yeah, or if your thing runs in a Docker container rather than a VM then
> throwing it at a Kubernetes cluster using a batch job isn't a big jump.

Kubernetes might be next level; I'm not a kubernetes guy so I can't say
if it would simplify things over what I've got. But if it meant running
on existing kubernetes clouds, that would make requisitioning hardware
easier.

> > > I'd also really like to get automated performance testing going too,
> > > which would have similar requirements in that jobs would need to be
> > > scheduled on specific dedicated machines. I think what you're doing
> > > could still build off of some common infrastructure.
> 
> It does actually - like quite a few test labs mine is based around LAVA,
> labgrid is the other popular option (people were actually thinking about
> integrating the two recently since labgrid is a bit lower level than
> LAVA and they could conceptually play nicely with each other).  Since
> the control API is internet accessible this means that it's really
> simple for me to to donate spare time on the boards to KernelCI as it
> understands how to drive LAVA, testing that I in turn use myself.  Both
> my stuff and KernelCI use a repository of glue which knows how to drive
> various testsuites inside a LAVA job, that's also used by other systems
> using LAVA like LKFT.
> 
> The custom stuff I have is all fairly thin (and quite janky), mostly
> just either things specific to my physical lab or managing which tests I
> want to run and what results I expect.  What I've got is *much* more
> limited than I'd like, and frankly if I wasn't able to pick up huge
> amounts of preexisting work most of this stuff would not be happening.

That's interesting. Do you have or would you be willing to write an
overview of what you've got? The way you describe it I wonder if we've
got some commonality.

The short overview of my system: tests are programs that expose
subcommends for listing depencies (i.e. virtual machine options, kernel
config options) and for listing and running subtests. Tests themselves
are shell scripts, with various library code for e.g. standard
kernel/vm config options, hooking up tracing, core dump catching, etc.

The idea is for tests to be entirely self contained and need no outside
configuration.

The test framework knows how to
 - build an appropriately configured kernel
 - launch a VM, which needs no prior configuration besides creation of a
   RO root filesystem image (single command, as mentioned)
 - exposes subcommands for qemu's gdb interface, kgdb, ssh access, etc.
   for when running interactively
 - implements watchdogs/test timeouts

and the CI, on top of all that, watches various git repositories and -
as you saw - tests every commit, newest to oldest, and provides the
results in a git log format.

The last one, "results in git log format", is _huge_. I don't know why I
haven't seen anyone else do that - it was a must-have feature for any
system over 10 years ago, and it never appeared so I finally built it
myself.

We (inherently!) have lots of issues with tests that only sometimes fail
making it hard to know when a regression was introduced, but running all
the tests on every commit with a good way to see the results makes this
nearly a non issue - that is, with a weak and noisy signal (tests
results) we just have to gather enough data and present the results
properly to make the signal stand out (which commit(s) were buggy).

I write a lot of code (over 200 commits for bcachefs this merge window
alone), and this is a huge part of why I'm able to - I never have to do
manual bisection anymore, and thanks to a codebase that's littered with
assertions and debugging tools I don't spend that much time bug hunting
either.

> > > > I'd also note that the 9 hour turnaround time for that test set you're
> > > > pointing at isn't exactly what I'd associate with immediate feedback.
> 
> > > My CI shards at the subtest level, and like I mentioned I run 10 VMs per
> > > physical machine, so with just 2 of the 80 core Ampere boxes I get full
> > > test runs done in ~20 minutes.
> 
> > This design, ironically, is way more cloud-friendly than a lot of
> > testing system designs I've seen in the past. :)
> 
> Sounds like a small private cloud to me!  :P

Yep :)

