Return-Path: <linux-fsdevel+bounces-31135-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DEE49920B0
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Oct 2024 21:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8ACCB213FF
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Oct 2024 19:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4667318A6B5;
	Sun,  6 Oct 2024 19:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Dr/cBv1k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379DD155336
	for <linux-fsdevel@vger.kernel.org>; Sun,  6 Oct 2024 19:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728243002; cv=none; b=eaiMfi5QjZlRT0e88j5Tvvq5Di3+ZEi3/DhVOK8fHh9XbBYmuXgatYOre63jkuUaSknvPX7BSzG8ARgvDJ36MeeoDhoK5isUUPI7sy/vditITdjmzR/GIWaNR2xjjS5setcsSxWtKRVAs3+2Hl7A22+w9IivA6563wpvRssQifE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728243002; c=relaxed/simple;
	bh=HVkO5LEhMZLrODSqw8mIeWz8WKkjrGidtwujuWM6350=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZyRycfWyvZXCNS3XUuIqgS0qaFqtdmnHqvz88HSpB+tL1VyXCEmNvTWgfIf47cPKcyJphQobmtzPEWw2SxbEMrNSuPN7iYWni0bHazfjDhyOOh48IlIxLw/ybyLqWk+Sqb8fYubkxXtofQOQGCfFHVP2hec8Dk4eGVYCAcPGDeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Dr/cBv1k; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sun, 6 Oct 2024 15:29:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728242998;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g4SriiM6xUMZbQFWfzvr7O0YJAKehcxesJsblIv0LMw=;
	b=Dr/cBv1kbw5xOFa08qOy9eXHkRsNh5fV+lPxJEBdXPxWSBbCTYwhbn1LYt3lbStL/WJNUy
	UdxmEQMK8I2TpXZVNDBO3PSDj3nLxEM+pUvI4S0EDMeRopE6BvInXM1R6NrTvU7PoYN2GH
	H2ch83vRKMyIN0IfGIE0lQL9R7Fb9AM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Theodore Ts'o <tytso@mit.edu>, linux-bcachefs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs fixes for 6.12-rc2
Message-ID: <dcfwznpfogbtbsiwbtj56fa3dxnba4aptkcq5a5buwnkma76nc@rjon67szaahh>
References: <cphtxla2se4gavql3re5xju7mqxld4rp6q4wbqephb6by5ibfa@5myddcaxerpb>
 <CAHk-=wjit-1ETRxCBrQAw49AUcE5scEM5O++M=793bDWnQktmw@mail.gmail.com>
 <x7w7lr3yniqrgcuy7vzor5busql2cglirhput67pjk6gtxtbfc@ghb46xdnjvgw>
 <CAHk-=wi-nKcOEnvX3RX+ovpsC4GvsHz1f6iZ5ZeD-34wiWvPgA@mail.gmail.com>
 <e3qmolajxidrxkuizuheumydigvzi7qwplggpd2mm2cxwxxzvr@5nkt3ylphmtl>
 <CAHk-=wjns3i5bm++338SrfJhrDUt6wyzvUPMLrEvMZan5ezmxQ@mail.gmail.com>
 <2nyd5xfm765iklvzjxvn2nx3onhtdntqrnmvlg2panhtdbff7i@evgk5ecmkuoo>
 <20241006043002.GE158527@mit.edu>
 <jhvwp3wgm6avhzspf7l7nldkiy5lcdzne5lekpvxugbb5orcci@mkvn5n7z2qlr>
 <CAHk-=wh_oAnEY3if4fRC6sJsZxZm=OhULV_9hUDVFm5n7UZ3eA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh_oAnEY3if4fRC6sJsZxZm=OhULV_9hUDVFm5n7UZ3eA@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Sun, Oct 06, 2024 at 12:04:45PM GMT, Linus Torvalds wrote:
> On Sat, 5 Oct 2024 at 21:33, Kent Overstreet <kent.overstreet@linux.dev> wrote:
> >
> > On Sun, Oct 06, 2024 at 12:30:02AM GMT, Theodore Ts'o wrote:
> > >
> > > You may believe that yours is better than anyone else's, but with
> > > respect, I disagree, at least for my own workflow and use case.  And
> > > if you look at the number of contributors in both Luis and my xfstests
> > > runners[2][3], I suspect you'll find that we have far more
> > > contributors in our git repo than your solo effort....
> >
> > Correct me if I'm wrong, but your system isn't available to the
> > community, and I haven't seen a CI or dashboard for kdevops?
> >
> > Believe me, I would love to not be sinking time into this as well, but
> > we need to standardize on something everyone can use.
> 
> I really don't think we necessarily need to standardize. Certainly not
> across completely different subsystems.
> 
> Maybe filesystem people have something in common, but honestly, even
> that is rather questionable. Different filesystems have enough
> different features that you will have different testing needs.
> 
> And a filesystem tree and an architecture tree (or the networking
> tree, or whatever) have basically almost _zero_ overlap in testing -
> apart from the obvious side of just basic build and boot testing.
> 
> And don't even get me started on drivers, which have a whole different
> thing and can generally not be tested in some random VM at all.

Drivers are obviously a whole different ballgame, but what I'm after is
more
- tooling the community can use
- some level of common infrastructure, so we're not all rolling our own.

"Test infrastructure the community can use" is a big one, because
enabling the community and making it easier for people to participate
and do real development is where our pipeline of new engineers comes
from.

Over the past 15 years, I've seen the filesystem community get smaller
and older, and that's not a good thing. I've had some good success with
giving ktest access to people in the community, who then start using it
actively and contributing (small, so far) patches (and interesting, a
lot of the new activity is from China) - this means they can do
development at a reasonable pace and I don't have to look at their code
until it's actually passing all the tests, which is _huge_.

And filesystem tests take overnight to run on a single machine, so
having something that gets them results back in 20 minutes is also huge.

The other thing I'd really like is to take the best of what we've got
for testrunner/CI dashboard (and opinions will vary, but of course I
like ktest the best) and make it available to other subsystems (mm,
block, kselftests) because not everyone has time to roll their own.

That takes a lot of facetime - getting to know people's workflows,
porting tests - so it hasn't happened as much as I'd like, but it's
still an active interest of mine.

> So no. People should *not* try to standardize on something everyone can use.
> 
> But _everybody_ should participate in the basic build testing (and the
> basic boot testing we have, even if it probably doesn't exercise much
> of most subsystems).  That covers a *lot* of stuff that various
> domain-specific testing does not (and generally should not).
> 
> For example, when you do filesystem-specific testing, you very seldom
> have much issues with different compilers or architectures. Sure,
> there can be compiler version issues that affect behavior, but let's
> be honest: it's very very rare. And yes, there are big-endian machines
> and the whole 32-bit vs 64-bit thing, and that can certainly affect
> your filesystem testing, but I would expect it to be a fairly rare and
> secondary thing for you to worry about when you try to stress your
> filesystem for correctness.

But - a big gap right now is endian /portability/, and that one is a
pain to cover with automated tests because you either need access to
both big and little endian hardware (at a minumm for creating test
images), or you need to run qemu in full-emulation mode, which is pretty
unbearably slow.

> But build and boot testing? All those random configs, all those odd
> architectures, and all those odd compilers *do* affect build testing.
> So you as a filesystem maintainer should *not* generally strive to do
> your own basic build test, but very much participate in the generic
> build test that is being done by various bots (not just on linux-next,
> but things like the 0day bot on various patch series posted to the
> list etc).
> 
> End result: one size does not fit all. But I get unhappy when I see
> some subsystem that doesn't seem to participate in what I consider the
> absolute bare minimum.

So the big issue for me has been that with the -next/0day pipeline, I
have no visibility into when it finishes; which means it has to go onto
my mental stack of things to watch for and becomes yet another thing to
pipeline, and the more I have to pipeline the more I lose track of
things.

(Seriously: when I am constantly tracking 5 different bug reports and
talking to 5 different users, every additional bit of mental state I
have to remember is death by a thousand cuts).

Which would all be solved with a dashboard - which is why adding the
bulid testing to ktest (or ideally, stealing _all_ the 0day tests for
ktest) is becoming a bigger and bigger priority.

> Btw, there are other ways to make me less unhappy. For example, a
> couple of years ago, we had a string of issues with the networking
> tree. Not because there was any particular maintenance issue, but
> because the networking tree is basically one of the biggest subsystems
> there are, and so bugs just happen more for that simple reason. Random
> driver issues that got found resolved quickly, but that kept happening
> in rc releases (or even final releases).
> 
> And that was *despite* the networking fixes generally having been in linux-next.

Yeah, same thing has been going on in filesystem land, which is why now
have fs-next that we're supposed to be targeting our testing automation
at.

That one will likely come slower for me, because I need to clear out a
bunch of CI failing tests before I'll want to look at that, but it's on
my radar.

> Now, the reason I mention the networking tree is that the one simple
> thing that made it a lot less stressful was that I asked whether the
> networking fixes pulls could just come in on Thursday instead of late
> on Friday or Saturday. That meant that any silly things that the bots
> picked up on (or good testers picked up on quickly) now had an extra
> day or two to get resolved.

Ok, if fixes coming in on Saturday is an issue for you that's something
I can absolutely change. The only _critical_ one for rc2 was the
__wait_for_freeing_inode() fix (which did come in late), the rest
could've waited until Monday.

> Now, it may be that the string of unfortunate networking issues that
> caused this policy were entirely just bad luck, and we just haven't
> had that. But the networking pull still comes in on Thursdays, and
> we've been doing it that way for four years, and it seems to have
> worked out well for both sides. I certainly feel a lot better about
> being able to do the (sometimes fairly sizeable) pull on a Thursday,
> knowing that if there is some last-minute issue, we can still fix just
> *that* before the rc or final release.
> 
> And hey, that's literally just a "this was how we dealt with one
> particular situation". Not everybody needs to have the same rules,
> because the exact details will be different. I like doing releases on
> Sundays, because that way the people who do a fairly normal Mon-Fri
> week come in to a fresh release (whether rc or not). And people tend
> to like sending in their "work of the week" to me on Fridays, so I get
> a lot of pull requests on Friday, and most of the time that works just
> fine.
> 
> So the networking tree timing policy ended up working quite well for
> that, but there's no reason it should be "The Rule" and that everybody
> should do it. But maybe it would lessen the stress on both sides for
> bcachefs too if we aimed for that kind of thing?

Yeah, that sounds like the plan then.

