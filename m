Return-Path: <linux-fsdevel+bounces-8135-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F41D82FFD8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 06:31:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5DCC1F26371
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 05:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5AF8F65;
	Wed, 17 Jan 2024 05:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="p6E0pJ9j";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZnBywQrO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from wnew4-smtp.messagingengine.com (wnew4-smtp.messagingengine.com [64.147.123.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57968F54;
	Wed, 17 Jan 2024 05:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705469490; cv=none; b=mgoW0b+nH/3b2ZejfmBWfOYnObWEd7ZX5jdrAywywLmpvn6wv9W7W60dkUkY4oSXA8rI+u2hihz9CmNOeyFkAeVXZKtiS3a4y5QjCW7k/2ByiFE3+TRP8vLi+pBXzHQhwNoY0dZqNtQaB9wqueI6q07dHwF6X1CdIOG85yauYyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705469490; c=relaxed/simple;
	bh=jHL2J3+E38Au+xWZe7O4FJLaMCCvPQTV1dGdd+k4q2c=;
	h=Received:Received:DKIM-Signature:DKIM-Signature:X-ME-Sender:
	 X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PCIm6Mf2EgR25Zv5jZiOfsXstT4fTq5FduznEH2vbu0W7DTd0rgdIInfwHYLf5dDdlaDTkI4xfATM9lwHV/qMN7+vy5NpanzFsVOcUUz23lR9iBtn6I9t3YoqMcGpiPOfvWX3a44+r6AInWcPNJVLBCU+4KgsgkUWpckdD+RKEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=p6E0pJ9j; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZnBywQrO; arc=none smtp.client-ip=64.147.123.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailnew.west.internal (Postfix) with ESMTP id 80DD62B0033A;
	Wed, 17 Jan 2024 00:31:24 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Wed, 17 Jan 2024 00:31:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1705469484; x=1705476684; bh=YadxD7argV
	wfwOZCJO/d0Knc3t1gSPI/urFbVLP3SN8=; b=p6E0pJ9jY0Qi3MgC507KiUYpte
	5ydSLIAl/skKovet9YCXtrq8FUm+nnoeuRwIP5X84eYwVWdfeHet1cB3VCQCwpYo
	GIY+exwPTFTkokZOggHPj5pwutOvi0wU/UP1MQAo3aqRMgHdqLkCZ7u3NPS7IuCJ
	SWJ0InIyZpJw4zeMzxAZLp1WGc8gLHvrCwHS0g67svCZGc+JN6WXSurz2D7qdgmm
	tbUcVYsDUbd/sUujL0i1jsV7Md27BBp+j2K9jJLGfm8LnTKdqASfUEXuYS/if0sT
	LI2/4fjYW3FFHpqw233HDbe38n0sjXB2a3qjH17fa4yrdOMUz1xDV6vUrU8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1705469484; x=1705476684; bh=YadxD7argVwfwOZCJO/d0Knc3t1g
	SPI/urFbVLP3SN8=; b=ZnBywQrOW+kdZkSVVuHGkoCgUjsrrGPIAG63B8NFpx0+
	zGOkodqNL5CZ6mivLDV8Di76QJhqlSBh6iV2k/KsQ05dEYrZG5XFH861nC6YLfz/
	O7X0yu5/0e4AMuxUwGHs2w2QD89MErhusgTBje7zeRJXkJ/o7shRUPzMlpDes4UL
	DZaYmcKC4DtFZCR3j1LwQHbubjF1WnZro0crTWIVS2XKqUZPvXkfY1e4d+8Y+GP9
	4irmlNi20JryuxGmliQKJ18iIjleM81eAU2bg2dh6a44B0xDFJhmFxTv8VX48jYH
	MVUzc7YyfvjO7uKS88L42bbpWLB4Kvb7UV4mXMKMiA==
X-ME-Sender: <xms:K2anZVmTMBOqIL4FRMBqM8A3mAhOqwIGZAzEeN8kB5P40URcnaBakw>
    <xme:K2anZQ3PEhyID0WYqjBjAwvw7eFA1M0z_TGowkRXLWD6yzGD-wPrZYSyfGmo1XvU-
    huYW0S1EUSfQw>
X-ME-Received: <xmr:K2anZbouZPfz8xAe0HdHFJsW3WUs2sBGDYQshXxDlqxjTlHHgemNsaLU9M6o342aPLqeaS5KB_m-IZ6hiB8TvoxgVDJpp4S_Gg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdejgedgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:K2anZVlt_vvqq1JNwh5yiPO24pM2uVFeFkAmuiJqm9918mtOK9Xz6A>
    <xmx:K2anZT1J4hmtDZ8bp_CMc3yA5sk8NdiTlpVOFCSWBBSCWEOIFgsgjg>
    <xmx:K2anZUuZSD4gtMNlsK4mQpe-JgYphWxQwXQMm4gxqQT1B6zni6UfWg>
    <xmx:LGanZRlOV6b14O6fhsuLdvFUH1pYr29tW6gdjY3wRQPfVFI6VEzhnbpUurY>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Jan 2024 00:31:23 -0500 (EST)
Date: Wed, 17 Jan 2024 06:31:20 +0100
From: Greg KH <greg@kroah.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Mark Brown <broonie@kernel.org>, Neal Gompa <neal@gompa.dev>,
	Kees Cook <keescook@chromium.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	Nikolai Kondrashov <spbnick@gmail.com>,
	Philip Li <philip.li@intel.com>,
	Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [GIT PULL] bcachefs updates for 6.8
Message-ID: <2024011754-footer-saturday-2dda@gregkh>
References: <xlynx7ydht5uixtbkrg6vgt7likpg5az76gsejfgluxkztukhf@eijjqp4uxnjk>
 <be2fa62f-f4d3-4b1c-984d-698088908ff3@sirena.org.uk>
 <gaxigrudck7pr3iltgn3fp5cdobt3ieqjwohrnkkmmv67fctla@atcpcc4kdr3o>
 <f8023872-662f-4c3f-9f9b-be73fd775e2c@sirena.org.uk>
 <olmilpnd7jb57yarny6poqnw6ysqfnv7vdkc27pqxefaipwbdd@4qtlfeh2jcri>
 <CAEg-Je8=RijGLavvYDvw3eOf+CtvQ_fqdLZ3DOZfoHKu34LOzQ@mail.gmail.com>
 <40bcbbe5-948e-4c92-8562-53e60fd9506d@sirena.org.uk>
 <2uh4sgj5mqqkuv7h7fjlpigwjurcxoo6mqxz7cjyzh4edvqdhv@h2y6ytnh37tj>
 <2024011532-mortician-region-8302@gregkh>
 <lr2wz4hos4pcavyrmswpvokiht5mmcww2e7eqyc2m7x5k6nbgf@6zwehwujgez3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <lr2wz4hos4pcavyrmswpvokiht5mmcww2e7eqyc2m7x5k6nbgf@6zwehwujgez3>

On Tue, Jan 16, 2024 at 11:41:25PM -0500, Kent Overstreet wrote:
> On Mon, Jan 15, 2024 at 09:13:01PM +0100, Greg KH wrote:
> > On Mon, Jan 15, 2024 at 01:42:53PM -0500, Kent Overstreet wrote:
> > > > That sounds more like a "(reproducible) tests don't exist" complaint
> > > > which is a different thing again to people going off and NIHing fancy
> > > > frameworks.
> > > 
> > > No, it's a leadership/mentorship thing.
> > > 
> > > And this is something that's always been lacking in kernel culture.
> > > Witness the kind of general grousing that goes on at maintainer summits;
> > > maintainers complain about being overworked and people not stepping up
> > > to help with the grungy responsibilities, while simultaneously we still
> > > very much have a "fuck off if you haven't proven yourself" attitude
> > > towards newcomers. Understandable given the historical realities (this
> > > shit is hard and the penalties of fucking up are high, so there does
> > > need to be a barrier to entry), but it's left us with some real gaps.
> > > 
> > > We don't have enough a people in the senier engineer role who lay out
> > > designs and organise people to take on projects that are bigger than one
> > > single person can do, or that are necessary but not "fun".
> > > 
> > > Tests and test infrastructure fall into the necessary but not fun
> > > category, so they languish.
> > 
> > No, they fall into the "no company wants to pay someone to do the work"
> > category, so it doesn't get done.
> > 
> > It's not a "leadership" issue, what is the "leadership" supposed to do
> > here, refuse to take any new changes unless someone ponys up and does
> > the infrastructure and testing work first?  That's not going to fly, for
> > valid reasons.
> > 
> > And as proof of this, we have had many real features, that benefit
> > everyone, called out as "please, companies, pay for this to be done, you
> > all want it, and so do we!" and yet, no one does it.  One real example
> > is the RT work, it has a real roadmap, people to do the work, a tiny
> > price tag, yet almost no one sponsoring it.  Yes, for that specific
> > issue it's slowly getting there and better, but it is one example of how
> > you view of this might not be all that correct.
> 
> Well, what's so special about any of those features? What's special
> about the RT work? The list of features and enhancements we want is
> never ending.

Nothing is special about RT except it is a good example of the kernel
"leadership" asking for help, and companies just ignoring us by not
funding the work to be done that they themselves want to see happen
because their own devices rely on it.

> But good tools are important beacuse they affect the rate of everyday
> development; they're a multiplier on the money everone is spending on
> salaries.
> 
> In everyday development, the rate at which we can run tests and verify
> the corectness of the code we're working on is more often than not _the_
> limiting factor on rate of development. It's a particularly big deal for
> getting new people up to speed, and for work that crosses subsystems.

Agreed, I'm not objecting here at all.

> > And you will see that we now have the infrastructure in places for this.
> > The great kunit testing framework, the kselftest framework, and the
> > stuff tying it all together is there.  All it takes is people actually
> > using it to write their tests, which is slowly happening.
> > 
> > So maybe, the "leadership" here is working, but in a nice organic way of
> > "wouldn't it be nice if you cleaned that out-of-tree unit test framework
> > up and get it merged" type of leadership, not mandates-from-on-high that
> > just don't work.  So organic you might have missed it :)
> 
> Things are moving in the right direction; the testing track at Plumber's
> was exciting to see.
> 
> Kselftests is not there yet, though. Those tests could all be runnable
> with a single command - and _most_ of what's needed is there, the kernel
> config dependencies are listed out, but we're still lacking a
> testrunner.

'make kselftest' is a good start, it outputs in proper format that test
runners can consume.  We even have 'make rusttest' now too because "rust
is special" for some odd reason :)

And that should be all that the kernel needs to provide as test runners
all work differently for various reasons, but if you want to help
standardize on something, that's what kernelci is doing, I know they can
always appreciate the help as well.

> I've been trying to get someone interested in hooking them up to ktest
> (my ktest, not that other thing), so that we'd have one common
> testrunner for running anything that can be a VM test. Similarly with
> blktests, mmtests, et cetera.

Hey, that "other" ktest.pl is what I have been using for stable kernel
test builds for years, it does work well for what it is designed for,
and I know other developers also use it.

> Having one common way of running all our functional VM tests, and a
> common collection of those tests would be a huge win for productivity
> because _way_ too many developers are still using slow ad hoc testing
> methods, and a good test runner (ktest) gets the edit/compile/test cycle
> down to < 1 minute, with the same tests framework for local development
> and automated testing in the big test cloud...

Agreed, and that's what kernelci is working to help provide.

thanks,

greg k-h

