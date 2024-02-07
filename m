Return-Path: <linux-fsdevel+bounces-10685-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3FBC84D5E8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 23:39:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81C6E2831F8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 22:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F971D6A8;
	Wed,  7 Feb 2024 22:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iTRaAeCr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57621CD3B;
	Wed,  7 Feb 2024 22:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707345569; cv=none; b=Xh6bD/+Sf0/v4FSFei4Xbee3XsXTqRmDdTh3x/7vTJAVy3k5A1vc5DxXmjmD5VxOdUzVpADOWXIMJnSr0RKYcyDzzN0aQVEAy5HgH5c0BV4iFAdK+fo5sdOq8bshkYp55/UcZnagZ7UDSpG820nPYGnHPs2HXeeP7eu1HggB1SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707345569; c=relaxed/simple;
	bh=xMOaIVhx48NIioEbimuqRqYO72FMYmmhLs/sNkCSrXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jWkRKQmhtpcBFLJu0phjSMa6BviQtqeVtZpPsqvFKKq2hIAq5L97x6IaXWK17BXxFeSzZ+tSTnQcmyfX1mxlMlI5F5YXxSBTolcdIuBGqwmf/eWUsMzJOBCdVrCDiHMeNgeMQw3YxahK4Kmf/KJAieJWnMTNDsoRImsh/QhFceE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iTRaAeCr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 691BCC433F1;
	Wed,  7 Feb 2024 22:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707345568;
	bh=xMOaIVhx48NIioEbimuqRqYO72FMYmmhLs/sNkCSrXY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iTRaAeCrxWemwYCo9mYeW8F3+H7LUNOrI4p8+tjMe6jP1FStteSFv1Y4d/Dl0CUHn
	 57YKt10WADlw0LZQeh8OC1KF9VYRIoT+SvuQucQ6/G1L52RpvltAHINlF8TKWG42vc
	 HRHB9mrbE8HCJdbw5kJ+8vrMvLQb62NhyfHmxLXZk+BCf2K/TKJXjHq65NNcavvVAK
	 VPKu6qa2x8sVsjZujSKGLJxj0RWRwxmEcbDzY6koQIexelt57CQGzhn7p+n5ipgKKX
	 TGWRPZRN2/aTOaoPr9iKKGfHKMBd7pYYnovQVp3cpGdt13kfBsrV4ttAEUvw/IDcwK
	 2HXAGu2QZRVWQ==
Date: Wed, 7 Feb 2024 14:39:27 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Thomas Bertschinger <tahbertschinger@gmail.com>,
	rust-for-linux@vger.kernel.org, linux-bcachefs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org,
	bfoster@redhat.com, ojeda@kernel.org, alex.gaynor@gmail.com,
	wedsonaf@gmail.com, masahiroy@kernel.org
Subject: Re: [PATCH RFC 0/3] bcachefs: add framework for internal Rust code
Message-ID: <20240207223927.GM6184@frogsfrogsfrogs>
References: <20240207055558.611606-1-tahbertschinger@gmail.com>
 <CANiq72=00+vZ+BqacSh+Xk8_VtNPVADH2Hcsyo-MPufojXvNFQ@mail.gmail.com>
 <qo637rxuw5tcskmgubutpe6dfmhhms4d4pjivzhewl5tpg3eth@xil6gpcvdiya>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <qo637rxuw5tcskmgubutpe6dfmhhms4d4pjivzhewl5tpg3eth@xil6gpcvdiya>

On Wed, Feb 07, 2024 at 03:57:35PM -0500, Kent Overstreet wrote:
> On Wed, Feb 07, 2024 at 12:06:05PM +0100, Miguel Ojeda wrote:
> > On Wed, Feb 7, 2024 at 6:57 AM Thomas Bertschinger
> > <tahbertschinger@gmail.com> wrote:
> > >
> > > This series adds support for Rust code into bcachefs. This only enables
> > > using Rust internally within bcachefs; there are no public Rust APIs
> > > added. Rust support is hidden behind a new config option,
> > > CONFIG_BCACHEFS_RUST. It is optional and bcachefs can still be built
> > > with full functionality without rust.
> > 
> > But is it the goal to make it use Rust always? If not, do you mean you
> > are you going to have 2 "modes" in bcachefs? i.e. one with all C, and
> > one with some parts replaced (i.e. duplicated) in Rust?
> > 
> > If it is the former (dropping C), then please note that it will limit
> > where bcachefs can be built for, i.e. architectures and configurations
> > (at least for the time being, i.e. we want to relax all that, but it
> > will take time).

Which architectures are supported by RoL at this point?

I can't speak for kmo, but bcachefs is new(ish) to the kernel, and
restricting support to the five major 64-bit arches (x64, arm64, ppc64,
s390x, riscv64) might be quite a load off him and his team.

Just speaking for myself, where xfs gets occasional weird bug reports of
strange behavior on platforms that none of us can test (csky) or OOM
reports with multi-TB filesystems on m68k.

> > If it is the latter (duplication), then please note that the kernel
> > has only gone the "duplication" route for "Rust reference drivers" as
> > an exceptional case that we requested to bootstrap their subsystems
> > and give Rust a try.
> > 
> > Could you please explain more about what is the intention here?
> 
> I think we're still at the "making sure everything works" stage.
> 
> I'll try to keep Rust optional a release or two, more so that we can
> iron out any toolchain hiccups, and in that period we'll be looking for
> non critical stuff to transition to Rust (the debugfs code, most
> likely).
> 
> When we make Rust a hard dependency kernel side will have to be a topic
> of discussion - but Rust is already a hard dependency on the userspace
> side, in -tools, so the lack of full architecture support is definitely
> something I'm hoping get addressed sooner rather than later, but it's
> probably not the blocker here.

> As soon as we're ok with making Rust a hard dependency kernel side,
> we'll be looking at switching a lot of stuff to Rust (e.g. fsck).
> 
> > Either way, the approach you are taking in this patch series seems to
> > be about calling C code directly, rather than writing and using
> > abstractions in general. For instance, in one of the patches you
> > mention in a comment "If/when a Rust API is provided" to justify the
> > functions, but it is the other way around, i.e. you need to first
> > write the abstractions for that C code, upstream them through the
> > relevant tree/maintainers, and then you use them from your Rust code.
> 
> I didn't see that comment, but we're mainly looking at what we can do
> inside fs/bcachefs/, and I've already got Rust bindings for the btree
> interface (that I talked about in a meeting with you guys, actually)
> that we'll be pulling in soon.

Personally, I suspect that converting the existing big-glob-of-C fs
implementations is going to be a long slow task of rewriting the C code
piece by testable piece, starting with the outer rings and moving in
towards the core.  Until the core is done, there's probably going to be
a lot of FFI'ing going on.

I think that's what Kent is getting at when he talks about rewriting
online fsck before moving on to the guts of bcachefs.  Or at least,
that's the approach I would take if I were to start converting XFS.

Messing around with core structures like xfs_inode and xfs_mount will
come muuuuch later.

> > Instead, to bootstrap things, what about writing a bcachefs module in
> > Rust that uses e.g. the VFS abstractions posted by Wedson, and
> > perhaps, to experiment/prototype, fill it with calls to the relevant C
> > parts of bcachefs? That way you can start working on the abstractions
> > and code you will eventually need for a Rust bcachefs module, without
> > limiting what C bcachefs can do/build for. And that way it would also
> > help to justify the upstreaming of the VFS abstractions too, since you
> > would be another expected user of them, and so on.
> 
> You mean a new, from scratch bcachefs module? Sorry, but that would not
> be practical :)
> 
> Wedson's work is on my radar too - that opens up a lot of possibilities.
> But right now my goal is just to get /some/ Rust code into bcachefs,
> and make sure we can incrementally bring in more Rust code within the same
> module.

Is the ultimate goal of the RoL project to build Rust wrappers around
the C filesystem objects?  Or to design something more Rustic(?) and
present the interfaces that the VFS wants to the VFS only as needed?

I might be talking nonsense here, I've only started learning Rust.  But
I /can/ speculate about what a Rust fs will need based on all the stuff
I've learned over the past 20y of wrangling the C filesystems.

> > > I wasn't sure if this needed to be an RFC based on the current status
> > > of accepting Rust code outside of the rust/ tree, so I designated it as
> > > such to be safe. However, Kent plans to merge rust+bcachefs code in the
> > > 6.9 merge window, so I hope at least the first 2 patches in this series,
> > > the ones that actually enable Rust for bcachefs, can be accepted.
> > 
> > This is worrying -- there has been no discussion about mixing C and
> > Rust like this, but you say it is targeted for 6.9. I feel there is a
> > disconnect somewhere. Perhaps it would be a good idea to have a quick
> > meeting about this.
> 
> Oh? This is exactly what I said we were going to do at the conference :)
> 
> Happy to meet though, let's figure out a time that works for Thomas too.

Honestly, these three patches seem to me like the barest stub to be able
to plant a flag and say "Hey look, Rust in a merged linux fs driver!"
Even if the only progress anyone makes on that this year is to wrap the
bcachefs btree iterators in Rust and reimplement a bunch of ioctls.

--D

> Cheers,
> Kent
> 

