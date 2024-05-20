Return-Path: <linux-fsdevel+bounces-19824-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF5598CA08C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 18:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2C6B1C2100F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 16:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8979813957D;
	Mon, 20 May 2024 16:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="mc0vJ9lJ";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="mc0vJ9lJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F071369BE;
	Mon, 20 May 2024 16:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716221436; cv=none; b=lQVsUVFVxKJ/SPqKCn/wLaIsQeElIXLa/iCopavPEYQJc9VSlvSwsswaMOVbYdElKfu2oihF13xb9f4aK3yEAFIj2T1aQ1ppfBfs0nYOPuvJ7zMEe8zC8XxW0hDFqc+c1gSMlW5ihFQr6Mg0F1fphW8Yc6txWUKlOffHPeurU1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716221436; c=relaxed/simple;
	bh=IOs4DH5M43q00GczYFv9Oi8cYP+skYziCQpw1joauX4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NvaSV1v8XfxeH8XXt+ffdjqUR+XtgqkoZk1Zf9KyM6gci//fUpgfzRp1q006NUUDkaOZum4yJ+7CmKe8z6I0SoUUIeJpRgJEATxicOdrPJ56msd+pL5vV6oyhrTNDFYJ5mZ87lNfnxZRskvXk3oYEITH0APgMbW1ByaidNM7q9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=mc0vJ9lJ; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=mc0vJ9lJ; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1716221433;
	bh=IOs4DH5M43q00GczYFv9Oi8cYP+skYziCQpw1joauX4=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=mc0vJ9lJ9uyQHkslbAiOF7LcKLywrCmbXqyLOuJN/rtYUGVMzMXu50NQnOvRaFb2w
	 c640ichN1OQL0Q1LUA7xfxtKtIF/r5Gv6gtLf8qq3LSuCCWzDTPDAZeSudrk2yRgWi
	 C2/+gK8V5Q85uDck52PW1+bQ2ILDf1wOM5FBFOE4=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 44D8B1280773;
	Mon, 20 May 2024 12:10:33 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id 6LAfKhO5IFA9; Mon, 20 May 2024 12:10:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1716221433;
	bh=IOs4DH5M43q00GczYFv9Oi8cYP+skYziCQpw1joauX4=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=mc0vJ9lJ9uyQHkslbAiOF7LcKLywrCmbXqyLOuJN/rtYUGVMzMXu50NQnOvRaFb2w
	 c640ichN1OQL0Q1LUA7xfxtKtIF/r5Gv6gtLf8qq3LSuCCWzDTPDAZeSudrk2yRgWi
	 C2/+gK8V5Q85uDck52PW1+bQ2ILDf1wOM5FBFOE4=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 65CE11280728;
	Mon, 20 May 2024 12:10:32 -0400 (EDT)
Message-ID: <a1aa10f9d97b2d80048a26f518df2a4b90c90620.camel@HansenPartnership.com>
Subject: Re: [GIT PULL] bcachefs updates fro 6.10-rc1
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Kent Overstreet <kent.overstreet@linux.dev>, Kees Cook
	 <keescook@chromium.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Linus Torvalds
	 <torvalds@linux-foundation.org>, linux-bcachefs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 20 May 2024 12:10:31 -0400
In-Reply-To: <2uuhtn5rnrfqvwx7krec6lc57gptqearrwwbtbpedvlbor7ziw@zgbzssfacdbe>
References: 
	<zhtllemg2gcex7hwybjzoavzrsnrwheuxtswqyo3mn2dlhsxbx@dkfnr5zx3r2x>
	 <202405191921.C218169@keescook>
	 <2uuhtn5rnrfqvwx7krec6lc57gptqearrwwbtbpedvlbor7ziw@zgbzssfacdbe>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 2024-05-19 at 23:52 -0400, Kent Overstreet wrote:
> On Sun, May 19, 2024 at 07:39:38PM -0700, Kees Cook wrote:
> > On Sun, May 19, 2024 at 12:14:34PM -0400, Kent Overstreet wrote:
> > > [...]
> > > bcachefs changes for 6.10-rc1
> > > [...]
> > >       bcachefs: bch2_btree_path_to_text()
> > 
> > Hi Kent,
> > 
> > I've asked after this before[1], but there continues to be a lot of
> > bcachefs development going on that is only visible when it appears
> > in
> > -next or during the merge window. I cannot find the above commit on
> > any mailing list on lore.kernel.org[2]. The rules for -next are
> > clear: patches _must_ appear on a list _somewhere_ before they land
> > in -next (much less Linus's tree). The point is to get additional
> > reviews, and to serve as a focal point for any discussions that pop
> > up over a given change. Please adjust the bcachefs development
> > workflow to address this.
> 
> Over the course of my career, I've found the kind of workflow and
> level of review you seem to asking for to be at best not useful, and
> at worst harmful to productive functioning of a team - to my ability
> to teach people and get them happy and productive.
> 
> The reality has just been that no one has ever been able to keep up
> with the rate at which I work and write code [0], and attempting to
> do code review of every patch means no one else gets anything done
> and we get sidetracked on irrelevant details. When I do post my
> patches to the list, the majority of what I get ends up being
> spelling fixes or at best the kinds of bugs that shake out quickly in
> real testing. In short, I've had to learn to write code without
> anyone looking over my shoulder, and I take pride in debugging my own
> code and not saddling other people with that.

I get that in your head you have a superior development methodology but
if I look at the reasons you advance below: 

> 
> So instead, I prioritize:
>  - real discussion over the work being done, which does tend to
> happen
>    person to person or in meetings (getting more of that on the list
>    would not be a bad idea; I do need to be spending more time
> writing
>    documentation and design docs, especially at this point).
>  - good effective test infrastructure
>  - heavy and thoughtful use of assertions; there's a real art to
>    effective use of assertions, where you think about what the
>    correctness proof would look like and write assertions for the
>    invariants (and assertions should be on _state_, not _logic_)
> 
> I also do (try to) post patches to the list that are doing something
> interesting and worth discussion; the vast majority this cycle has
> been boring syzbot crap...

you still don't say what problem not posting most patches solves?  You
imply it would slow you down, but getting git-send-email to post to a
mailing list can actually be automated through a pre-push commit hook
with no slowdown in the awesome rate at which you apply patches to your
own tree.

Linux kernel process exists because it's been found to work over time.
That's not to say it can't be changed, but it usually requires at least
some stab at a reason before that happens.

> IOW, I'm not trying to _flout_ process here, even if I do things
> somewhat differently; I've got quite a few people I'm actively
> teaching and bringing in and that's where most of my energy is going.
> And we do spend a lot of time going over code together, the meetings
> I run (especially with the younger guys) are very much code-and-
> workflow focused.

These are echo chamber reviews.  Even if you echo chamber happens
produce good reviews there's still no harm in getting them from outside
it as well.  Plus we can't make this generic workflow because too many
less awesome contributors would take advantage of the laxity it offers.

> You'll also find I'm quite responsive, on IRC and the list, should
> you have anything you wish to complain or yell about.
> 
> (btw, there's also been some discussions in fs land about other
> people changing their workflows to something that looks more like
> mine; get the important stuff on the list, make the list less spammy,
> work with each other on a quicker timeline than that. They're not
> quite doing what I'm doing, but I do think there's room for the /way/
> we do code review and the expectations around it to evolve a bit.
> Personally, I mostly just want code to be readable).
> 
> I personally approach code review as being primarily about
> mentorship... I don't want people to have the expectation that I'm
> going to pore over their code and find their bugs; I'm not going to
> do that.

Just because you won't check others' code for bugs doesn't mean that
others won't check your code for bugs...

> I expect people to be adults, and take as much time as they need to
> to get it right; if there's something they're not sure about, I
> expect _them_ to bring it up.

This is an unknown unknown problem: you can't bring up to others things
you don't know about yourself. 

>  I personally feel that this mindset teaches more responsibility and
> the "right" kind of defensiveness that it takes to write reliable
> code.

So you didn't answer whether you ran checkpatch and ignored the warning
(in which case a commit comment explaining why would have been useful)
or didn't run checkpatch (in which case why not?).

James


