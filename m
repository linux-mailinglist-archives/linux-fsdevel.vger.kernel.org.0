Return-Path: <linux-fsdevel+bounces-7807-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 691C882B43B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jan 2024 18:39:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 185DD1F226F4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jan 2024 17:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC2852F92;
	Thu, 11 Jan 2024 17:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HPgO+BgO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B00F51C27
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Jan 2024 17:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 11 Jan 2024 12:38:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1704994741;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xtqt+XCKB8URLfIsERdpgm7zJXhhxVtHiUsa5sbp2Qs=;
	b=HPgO+BgOiUMMuo2RZ60QxQwyLWf4P3il3GGphNXgQBouaq1OB/mIzjNhVEP3afsyDA5DAJ
	PWpweSxttYFFzKAo9AXVddFHL4SDloJ1/QrY/HRNZAcTmNoBH0ugS47JTlcp7c8Buf6tkg
	MlTAdsKgmHq2vm3x1pL8iY8wb25jB0Q=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Mark Brown <broonie@kernel.org>
Cc: Kees Cook <keescook@chromium.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Nikolai Kondrashov <spbnick@gmail.com>
Subject: Re: [GIT PULL] bcachefs updates for 6.8
Message-ID: <gaxigrudck7pr3iltgn3fp5cdobt3ieqjwohrnkkmmv67fctla@atcpcc4kdr3o>
References: <wq27r7e3n5jz4z6pn2twwrcp2zklumcfibutcpxrw6sgaxcsl5@m5z7rwxyuh72>
 <202401101525.112E8234@keescook>
 <6pbl6vnzkwdznjqimowfssedtpawsz2j722dgiufi432aldjg4@6vn573zspwy3>
 <202401101625.3664EA5B@keescook>
 <xlynx7ydht5uixtbkrg6vgt7likpg5az76gsejfgluxkztukhf@eijjqp4uxnjk>
 <be2fa62f-f4d3-4b1c-984d-698088908ff3@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be2fa62f-f4d3-4b1c-984d-698088908ff3@sirena.org.uk>
X-Migadu-Flow: FLOW_OUT

On Thu, Jan 11, 2024 at 03:35:40PM +0000, Mark Brown wrote:
> On Wed, Jan 10, 2024 at 07:58:20PM -0500, Kent Overstreet wrote:
> > On Wed, Jan 10, 2024 at 04:39:22PM -0800, Kees Cook wrote:
> 
> > > With no central CI, the best we've got is everyone running the same
> > > "minimum set" of checks. I'm most familiar with netdev's CI which has
> > > such things (and checkpatch.pl is included). For example see:
> > > https://patchwork.kernel.org/project/netdevbpf/patch/20240110110451.5473-3-ptikhomirov@virtuozzo.com/
> 
> > Yeah, we badly need a central/common CI. I've been making noises that my
> > own thing could be a good basis for that - e.g. it shouldn't be much
> > work to use it for running our tests in tools/tesing/selftests. Sadly no
> > time for that myself, but happy to talk about it if someone does start
> > leading/coordinating that effort.
> 
> IME the actually running the tests bit isn't usually *so* much the
> issue, someone making a new test runner and/or output format does mean a
> bit of work integrating it into infrastructure but that's more usually
> annoying than a blocker.

No, the proliferation of test runners, test output formats, CI systems,
etc. really is an issue; it means we can't have one common driver that
anyone can run from the command line, and instead there's a bunch of
disparate systems with patchwork integration and all the feedback is nag
emails - after you've finished whan you were working on instead of
moving on to the next thing - with no way to get immediate feedback.

And it's because building something shiny and new is the fun part, no
one wants to do the grungy integration work.

> Issues tend to be more around arranging to
> drive the relevant test systems, figuring out which tests to run where
> (including things like figuring out capacity on test devices, or how
> long you're prepared to wait in interactive usage) and getting the
> environment on the target devices into a state where the tests can run.
> Plus any stability issues with the tests themselves of course, and
> there's a bunch of costs somewhere along the line.
> 
> I suspect we're more likely to get traction with aggregating test
> results and trying to do UI/reporting on top of that than with the
> running things bit, that really would be very good to have.  I've copied
> in Nikolai who's work on kcidb is the main thing I'm aware of there,
> though at the minute operational issues mean it's a bit write only.
> 
> > example tests, example output:
> > https://evilpiepirate.org/git/ktest.git/tree/tests/bcachefs/single_device.ktest
> > https://evilpiepirate.org/~testdashboard/ci?branch=bcachefs-testing
> 
> For example looking at the sample test there it looks like it needs
> among other things mkfs.btrfs, bcachefs, stress-ng, xfs_io, fio, mdadm,
> rsync

Getting all that set up by the end user is one command:
  ktest/root_image create
and running a test is one morecommand:
build-test-kernel run ~/ktest/tests/bcachefs/single_device.ktest

> and a reasonably performant disk with 40G of space available.
> None of that is especially unreasonable for a filesystems test but it's
> all things that we need to get onto the system where we want to run the
> test and there's a lot of systems where the storage requirements would
> be unsustainable for one reason or another.  It also appears to take
> about 33000s to run on whatever system you use which is distinctly
> non-trivial.

Getting sufficient coverage in filesystem land does take some amount of
resources, but it's not so bad - I'm leasing 80 core ARM64 machines from
Hetzner for $250/month and running 10 test VMs per machine, so it's
really not that expensive. Other subsystems would probably be fine with
less resources.

