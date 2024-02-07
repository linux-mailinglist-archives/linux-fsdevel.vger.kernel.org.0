Return-Path: <linux-fsdevel+bounces-10670-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B8AA84D351
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 21:57:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E8101C21AE4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 20:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24BAC1272D1;
	Wed,  7 Feb 2024 20:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VSJ+o9BF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87CCD1EEEA;
	Wed,  7 Feb 2024 20:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707339463; cv=none; b=A64VWPQdFhpb4aI/8xY+awEG1LfnC8V2Seq8gxt0mq733Swr5Le4dZvzUOHJWrU0d3vW+evLLX+4blEGvqhwAph0TL+CRVkYGHg9ftHsS8JAt1F/nPVLsNfcw69TIaxDLd6sh2kBA3OO9xpCSMYn+5M5463ZZczcAhXwv2e21CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707339463; c=relaxed/simple;
	bh=XV+X/Mz+hLnzcD1YhLXxBTUtZbag586OdZMitsbk9nw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ID6BWhIyc9BcjxzVl5LSwbgy0IF+iXtUhHOV065hbzyZKWAwJ8EIWCawDe8U6gLb1RLQzXkG5vr2ecEn6KZTmrWcOqMETFkZ4od86+q/qhUxfUdif8ksZHZ734t6+RkeM9zO/uIXzJy73sPIcz2GA0IrmxPmVzh5O5CWT7ipoLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VSJ+o9BF; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 7 Feb 2024 15:57:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707339459;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lJQSMzEIWem3PDHTwEkM4bvQgxivH0lgBv0DRyhl9VM=;
	b=VSJ+o9BFGrvyVwY/t401Z0zNcBy19k9hET2uIyNQq6534mRplb5fLUt1Nxkg720tCWi3Iq
	LbDv3qmidbsMQBQhI9m3PfbirY0kmSnleWq6aADp7AFtOF4CZjX75hIGaOKv9UYCVI63Jm
	pw41WGlkKBfSz6zuob18fMto/2HXRkw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Thomas Bertschinger <tahbertschinger@gmail.com>, 
	rust-for-linux@vger.kernel.org, linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, bfoster@redhat.com, ojeda@kernel.org, alex.gaynor@gmail.com, 
	wedsonaf@gmail.com, masahiroy@kernel.org
Subject: Re: [PATCH RFC 0/3] bcachefs: add framework for internal Rust code
Message-ID: <qo637rxuw5tcskmgubutpe6dfmhhms4d4pjivzhewl5tpg3eth@xil6gpcvdiya>
References: <20240207055558.611606-1-tahbertschinger@gmail.com>
 <CANiq72=00+vZ+BqacSh+Xk8_VtNPVADH2Hcsyo-MPufojXvNFQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72=00+vZ+BqacSh+Xk8_VtNPVADH2Hcsyo-MPufojXvNFQ@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Feb 07, 2024 at 12:06:05PM +0100, Miguel Ojeda wrote:
> On Wed, Feb 7, 2024 at 6:57 AM Thomas Bertschinger
> <tahbertschinger@gmail.com> wrote:
> >
> > This series adds support for Rust code into bcachefs. This only enables
> > using Rust internally within bcachefs; there are no public Rust APIs
> > added. Rust support is hidden behind a new config option,
> > CONFIG_BCACHEFS_RUST. It is optional and bcachefs can still be built
> > with full functionality without rust.
> 
> But is it the goal to make it use Rust always? If not, do you mean you
> are you going to have 2 "modes" in bcachefs? i.e. one with all C, and
> one with some parts replaced (i.e. duplicated) in Rust?
> 
> If it is the former (dropping C), then please note that it will limit
> where bcachefs can be built for, i.e. architectures and configurations
> (at least for the time being, i.e. we want to relax all that, but it
> will take time).
> 
> If it is the latter (duplication), then please note that the kernel
> has only gone the "duplication" route for "Rust reference drivers" as
> an exceptional case that we requested to bootstrap their subsystems
> and give Rust a try.
> 
> Could you please explain more about what is the intention here?

I think we're still at the "making sure everything works" stage.

I'll try to keep Rust optional a release or two, more so that we can
iron out any toolchain hiccups, and in that period we'll be looking for
non critical stuff to transition to Rust (the debugfs code, most
likely).

When we make Rust a hard dependency kernel side will have to be a topic
of discussion - but Rust is already a hard dependency on the userspace
side, in -tools, so the lack of full architecture support is definitely
something I'm hoping get addressed sooner rather than later, but it's
probably not the blocker here.

As soon as we're ok with making Rust a hard dependency kernel side,
we'll be looking at switching a lot of stuff to Rust (e.g. fsck).

> Either way, the approach you are taking in this patch series seems to
> be about calling C code directly, rather than writing and using
> abstractions in general. For instance, in one of the patches you
> mention in a comment "If/when a Rust API is provided" to justify the
> functions, but it is the other way around, i.e. you need to first
> write the abstractions for that C code, upstream them through the
> relevant tree/maintainers, and then you use them from your Rust code.

I didn't see that comment, but we're mainly looking at what we can do
inside fs/bcachefs/, and I've already got Rust bindings for the btree
interface (that I talked about in a meeting with you guys, actually)
that we'll be pulling in soon.

> Instead, to bootstrap things, what about writing a bcachefs module in
> Rust that uses e.g. the VFS abstractions posted by Wedson, and
> perhaps, to experiment/prototype, fill it with calls to the relevant C
> parts of bcachefs? That way you can start working on the abstractions
> and code you will eventually need for a Rust bcachefs module, without
> limiting what C bcachefs can do/build for. And that way it would also
> help to justify the upstreaming of the VFS abstractions too, since you
> would be another expected user of them, and so on.

You mean a new, from scratch bcachefs module? Sorry, but that would not
be practical :)

Wedson's work is on my radar too - that opens up a lot of possibilities.
But right now my goal is just to get /some/ Rust code into bcachefs,
and make sure we can incrementally bring in more Rust code within the same
module.

> 
> > I wasn't sure if this needed to be an RFC based on the current status
> > of accepting Rust code outside of the rust/ tree, so I designated it as
> > such to be safe. However, Kent plans to merge rust+bcachefs code in the
> > 6.9 merge window, so I hope at least the first 2 patches in this series,
> > the ones that actually enable Rust for bcachefs, can be accepted.
> 
> This is worrying -- there has been no discussion about mixing C and
> Rust like this, but you say it is targeted for 6.9. I feel there is a
> disconnect somewhere. Perhaps it would be a good idea to have a quick
> meeting about this.

Oh? This is exactly what I said we were going to do at the conference :)

Happy to meet though, let's figure out a time that works for Thomas too.

Cheers,
Kent

