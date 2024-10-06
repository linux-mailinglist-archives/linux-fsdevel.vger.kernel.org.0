Return-Path: <linux-fsdevel+bounces-31099-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 409CC991BAA
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Oct 2024 02:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DFB2B21481
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Oct 2024 00:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 562623A8D2;
	Sun,  6 Oct 2024 00:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UIVLUQqT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C1DAD2C
	for <linux-fsdevel@vger.kernel.org>; Sun,  6 Oct 2024 00:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728176086; cv=none; b=VRz3+yu0PXdhqkIGsB8nn+vDkD5aPyIy0ve1HzYSbZXa79D19ZzB/b2NLeUJy+h0vRjuF0USFbohlGmap1EcEm5z9tHYirVI5mpHjS/ro+71sLscw6j/fVKOuobkWA8TLvCo3zOMtM61uxA0RSj6uKXX1rK04av38vUQVOjDQ1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728176086; c=relaxed/simple;
	bh=zd5x3q3iXlFjQy2ZXqLZf2Fg3QPYCCucg1PgrZ8v5ZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UifW3emuLBIZ0UNbDU8dQxJBgp8/kDqmIxHZSoqQyCo8q51LaPGysVQJ/sEZQ3tXAAvXjY3WzTwQng0SkIciy63YxmVdPg/yTpDQZ6rVFWNM8H86mo4ONQvL8fy7+tm8y03xJrzxUGbIHQIQJfwv9FKJzp8yeb4y9IpqSVdcR8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UIVLUQqT; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 5 Oct 2024 20:54:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728176078;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5ANbMm2vpRjIu7wF5S2mm9W4M4SuN2KC2/rhtvgUEpE=;
	b=UIVLUQqTN4Rm4jspkESyVbuWELlY8OTv3pxY0JsX8AM/oGLtVSeCRB8C1TzVu+J+wh8lOe
	diQR9dN5QiI10/fLBkmJAXQNEhQ9X5+ikvDLh4iQhswV2BdYMRlrZ+wYxRv8mHmlb+UUnT
	ELmCjVEYNimQFy77yRhg95/obCuSvWY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs fixes for 6.12-rc2
Message-ID: <2nyd5xfm765iklvzjxvn2nx3onhtdntqrnmvlg2panhtdbff7i@evgk5ecmkuoo>
References: <cphtxla2se4gavql3re5xju7mqxld4rp6q4wbqephb6by5ibfa@5myddcaxerpb>
 <CAHk-=wjit-1ETRxCBrQAw49AUcE5scEM5O++M=793bDWnQktmw@mail.gmail.com>
 <x7w7lr3yniqrgcuy7vzor5busql2cglirhput67pjk6gtxtbfc@ghb46xdnjvgw>
 <CAHk-=wi-nKcOEnvX3RX+ovpsC4GvsHz1f6iZ5ZeD-34wiWvPgA@mail.gmail.com>
 <e3qmolajxidrxkuizuheumydigvzi7qwplggpd2mm2cxwxxzvr@5nkt3ylphmtl>
 <CAHk-=wjns3i5bm++338SrfJhrDUt6wyzvUPMLrEvMZan5ezmxQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjns3i5bm++338SrfJhrDUt6wyzvUPMLrEvMZan5ezmxQ@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Sat, Oct 05, 2024 at 05:14:31PM GMT, Linus Torvalds wrote:
> On Sat, 5 Oct 2024 at 16:41, Kent Overstreet <kent.overstreet@linux.dev> wrote:
> >
> > If what you want is patches appearing on the list, I'm not unwilling to
> > make that change.
> 
> I want you to WORK WITH OTHERS. Including me - which means working
> with the rules and processes we have in place.

That has to work both ways.

Because when I explain my reasoning and processes, and it's ignored and
the same basic stuff is repeatedly yelled back, I'm just going to tune
it out.

I'm more than happy to work with people, but that's got to be a
conversation, and one based on mutual respect.

> Making the argument that we didn't have those rules twenty years ago
> is just stupid.  We have them NOW, because we learnt better. You don't
> get to say "look, you didn't have rules 20 years ago, so why should I
> have them now?"

That wasn't my argument.

My point was that a codebase at an earlier phase of development, that
hasn't had as long to stabilize, is inherently going to be more in flux.
Earlier in development fixing bugs is going to be a high prioritity,
relatively speaking, vs. avoiding regressions; sometimes the important
thing is to make forward progress, iterate, and ship and get feedback
from users.

I think the way you guys were doing development 20 years ago was
entirely appropriate at that time, and that's what I need to be doing
now; I need to be less conservative than the kernel as a whole.

That isn't to say that there aren't things we can and should be doing
to mitigate that (i.e. improving build testing, which now that I'm
finishing up with the current project I can do), or that there isn't
room for discussion on the particulars.

But seriously; bcachefs is shaping up far better than btrfs (which,
afaik _did_ try to play by all the rules), and process has _absolutely_
been a factor in that.

> Patches appearing on the list is not some kind of sufficient thing.
> It's the absolute minimal requirement. The fact that absolutely *NONE*
> of the patches in your pull request showed up when I searched just
> means that you clearly didn't even attempt to have others involved
> (ok, I probably only searched for half of them and then I gave up in
> disgust).

Those fixes were all pretty basic, and broadly speaking I know what
everyone else who's working on bcachefs is doing and what they're
working on. Hongbo has been quite helpful with a bunch of things (and
starting to help out in the bug tracker and IRC channel), Alan has been
digging around in six locks and most recently the cycle detector code,
and I've been answering questions as he learns his way around, Thomas
has been getting started on some backpointers scalability work.

Nothing will be served by having them review thoroughly a big stream of
small uninteresting fixes, it'd suck up all their time and prevent them
from doing anything productive. I have, quite literally, tried this and
had it happen on multiple occasions in the past.

I do post when I've got something more interesting going on, and I'd
been anticipating posting more as the stabilizing slows down.

> We literally had a bcachefs build failure last week. It showed up
> pretty much immediately after I pulled your tree. And because you sent
> in the bcachefs "fixes" with the bug the day before I cut rc1, we
> ended up with a broken rc1.
> 
> And hey, mistakes happen. But when the *SAME* absolute disregard for
> testing happens the very next weekend, do you really expect me to be
> happy about it?

And I do apologize for the build failure, and I will get on the
automated multi-arch build testing - that needed to happen anyways.

But I also have to remind you that I'm one of the few people who's
actually been pushing for more and better automated testing (I now have
infrastructure for the communty that anyone can use, just ask me for an
account) - and that's been another solo effort because so few people are
even interested, so the fact that this even came up grates on me. This
is a problem with a technical solution, and instead we're all just
arguing.

> It's this complete disregard for anybody else that I find problematic.
> You don't even try to get other developers involved, or follow
> upstream rules.

Linus, just because you don't see it doesn't mean it doesn't exist. I
spend a significant fraction of my day on IRC and the phone with both
users and other developers.

And "upstream rules" has always been a fairly ad-hoc thing, which even
you barely seem able to spell out.

It's taken _forever_ to get to "yes, you do want patches on the list",
and you seem to have some feeling that the volume of fixes is an issue
for you, but god only knows if that's more than a hazy feeling for you.

> > If you're so convinced you know best, I invite you to start writing your
> > own filesystem. Go for it.
> 
> Not at all. I'm not interested in creating another bcachefs.
> 
> I'm contemplating just removing bcachefs entirely from the mainline
> tree. Because you show again and again that you have no interest in
> trying to make mainline work.

You can do that, and it won't be the end of the world for me (although a
definite inconvenience) - but it's going to suck for a lot of users.

> You can do it out of mainline. You did it for a decade, and that
> didn't cause problems. I thought it would be better if it finally got
> mainlined, but by all your actions you seem to really want to just
> play in your own sandbox and not involve anybody else.
> 
> So if this is just your project and nobody else is expected to
> participate, and you don't care about the fact that you break the
> mainline build, why the hell did you want to be in the mainline tree
> in the first place?

Honestly?

Because I want Linux to have a filesystem we can all be proud of, that
users can rely on, that has a level of robustness and polish that we can
all aspire to.

