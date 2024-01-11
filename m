Return-Path: <linux-fsdevel+bounces-7761-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F0582A573
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jan 2024 01:58:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9F1E1F25002
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jan 2024 00:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D5D7EE;
	Thu, 11 Jan 2024 00:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EhAh2ulh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE8A394
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Jan 2024 00:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 10 Jan 2024 19:58:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1704934703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uKlEmnKmoRwLGvbX64cWBURlwsmoJLESEdYznjpxklU=;
	b=EhAh2ulhiwZwyUkbFXFCIAjKgwM9zUonDQAoZ1Cezpk8kL0YUw0jcm3/Hfiq1jj+AYz7m5
	pOWRTzrHXaajh0Ma1AzAYFZZ68EAqns0GKkQqCINiewRIAbM225UpNsP0vXvBmUMoWk72m
	VuXA+jCZPK05M0KYuu8BESyifWnD6Xc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs updates for 6.8
Message-ID: <xlynx7ydht5uixtbkrg6vgt7likpg5az76gsejfgluxkztukhf@eijjqp4uxnjk>
References: <wq27r7e3n5jz4z6pn2twwrcp2zklumcfibutcpxrw6sgaxcsl5@m5z7rwxyuh72>
 <202401101525.112E8234@keescook>
 <6pbl6vnzkwdznjqimowfssedtpawsz2j722dgiufi432aldjg4@6vn573zspwy3>
 <202401101625.3664EA5B@keescook>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202401101625.3664EA5B@keescook>
X-Migadu-Flow: FLOW_OUT

On Wed, Jan 10, 2024 at 04:39:22PM -0800, Kees Cook wrote:
> On Wed, Jan 10, 2024 at 07:04:47PM -0500, Kent Overstreet wrote:
> > On Wed, Jan 10, 2024 at 03:48:43PM -0800, Kees Cook wrote:
> > > On Wed, Jan 10, 2024 at 02:36:30PM -0500, Kent Overstreet wrote:
> > > > [...]
> > > >       bcachefs: %pg is banished
> > > 
> > > Hi!
> > > 
> > > Not a PR blocker, but this patch re-introduces users of strlcpy() which
> > > has been otherwise removed this cycle. I'll send a patch to replace
> > > these new uses, but process-wise, I'd like check on how bcachefs patches
> > > are reviewed.
> > 
> > I'm happy to fix it. Perhaps the declaration could get a depracated
> > warning, though?
> 
> That's one of checkpatch.pl's purposes, seeing as how deprecation warnings
> are ... deprecated. :P
> https://docs.kernel.org/process/deprecated.html#id1
> This has made treewide changes like this more difficult, but these are
> the Rules From Linus. ;)

...And how does that make any sense? "The warnings weren't getting
cleaned up, so get rid of them - except not really, just move them off
to the side so they'll be more annoying when they do come up"...

Perhaps we could've just switched to deprecation warnings being on in a
W=1 build?

> Okay, gotcha. I personally don't care how maintainers handle rebasing; I
> was just confused about the timing and why I couldn't find the original
> patch on any lists. :) And to potentially warn about Linus possibly not
> liking the rebase too.

*nod* If there's some other reason why it's convenient to be on rc2 I
could possibly switch my workflow, but pushing code out quickly is the
norm for me.

> > > It also seems it didn't get a run through scripts/checkpatch.pl, which
> > > shows 4 warnings, 2 or which point out the strlcpy deprecation:
> > > 
> > > WARNING: Prefer strscpy over strlcpy - see: https://github.com/KSPP/linux/issues/89
> > > #123: FILE: fs/bcachefs/super.c:1389:
> > > +               strlcpy(c->name, name.buf, sizeof(c->name));
> > > 
> > > WARNING: Prefer strscpy over strlcpy - see: https://github.com/KSPP/linux/issues/89
> > > #124: FILE: fs/bcachefs/super.c:1390:
> > > +       strlcpy(ca->name, name.buf, sizeof(ca->name));
> > > 
> > > Please make sure you're running checkpatch.pl -- it'll make integration,
> > > technical debt reduction, and coding style adjustments much easier. :)
> > 
> > Well, we do have rather a lot of linters these days.
> > 
> > That's actually something I've been meaning to raise - perhaps we could
> > start thinking about some pluggable way of running linters so that
> > they're all run as part of a normal kernel build (and something that
> > would be easy to drop new linters in to; I'd like to write some bcachefs
> > specific ones).
> 
> With no central CI, the best we've got is everyone running the same
> "minimum set" of checks. I'm most familiar with netdev's CI which has
> such things (and checkpatch.pl is included). For example see:
> https://patchwork.kernel.org/project/netdevbpf/patch/20240110110451.5473-3-ptikhomirov@virtuozzo.com/

Yeah, we badly need a central/common CI. I've been making noises that my
own thing could be a good basis for that - e.g. it shouldn't be much
work to use it for running our tests in tools/tesing/selftests. Sadly no
time for that myself, but happy to talk about it if someone does start
leading/coordinating that effort.

example tests, example output:
https://evilpiepirate.org/git/ktest.git/tree/tests/bcachefs/single_device.ktest
https://evilpiepirate.org/~testdashboard/ci?branch=bcachefs-testing

> > The current model of "I have to remember to run these 5 things, and then
> > I'm going to get email nags for 3 more that I can't run" is not terribly
> > scalable :)
> 
> Oh, I hear you. It's positively agonizing for those of us doing treewide
> changes. I've got at least 4 CIs I check (in addition to my own) just to
> check everyone's various coverage tools.
> 
> At the very least, checkpatch.pl is the common denominator:
> https://docs.kernel.org/process/submitting-patches.html#style-check-your-changes

At one point in my career I was religious about checkpatch; since then
the warnings it produces have seemed to me more on the naggy and less on
the useful end of the spectrum - I like smatch better in that respect.
But - I'll start running it again for the deprecation warnings :)

