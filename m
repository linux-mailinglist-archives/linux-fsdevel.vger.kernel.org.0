Return-Path: <linux-fsdevel+bounces-15236-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD3288B27C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 22:16:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4053BB37A8B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 18:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4AAE1849;
	Mon, 25 Mar 2024 17:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="AV9Ue6Hs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653E8107A9
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Mar 2024 17:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711388727; cv=none; b=QqVRiSGDK6R3QCtkeevXqcEk8RYVxevEUiSOptwHMtq79HgKOKDhZheHSaO4jOVDnT/MdcdtngqrGQjhkkOSEaKcTW02qxKuwPtFBOrWDNDccAdqRWonrFe3QO/7LhyXJXcgFabPm74id7RjPzGPO1doSuZW+D+3yygw+hpkuvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711388727; c=relaxed/simple;
	bh=TpmJTEOgQOHM9HmdS/G5PTDNlrGN/J8csNvsXEYpiFE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S7ixPH4KdDDBNFhpd5qInR+313n3CpMEnhi1Xw1G7sh+SIXqx2tfyiC7YttOWxMiIGznrgKbch8fdvzUaBjppOzYPk87FjWXlSGHhNAB9pLpW1EmcmTwjCTriw8PHZkyw+McqHrEwqmjY1KuycKGDYlqyulxnDXoYEX8GjzG90g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=AV9Ue6Hs; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-515a86daf09so2208344e87.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Mar 2024 10:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1711388722; x=1711993522; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sd/wp9UpBSQuIXx6uQdvepokZABl7yLFwM775FKBHzQ=;
        b=AV9Ue6HsAWpr+nt7srlXmmiFk9Fvv6bJW6l8zoGb+Zl7eT2M7c4nZ5XYyUYYxqGssU
         gNHqW/frT1RfAZ0MHnKfA5JqIBKXyYQVq/LEix5ZzWKrBfhogbljkD/9FHWcP//7cHX+
         K2O/CW//Js31NM7Gj9ULd1FOsxg8cTI+T8F6c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711388722; x=1711993522;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sd/wp9UpBSQuIXx6uQdvepokZABl7yLFwM775FKBHzQ=;
        b=jWfvp8KV41+789IgLnRyEFk8ybxyIecRoT567iSHqZUV3YZZivdwmXa3yPsQl2q4cJ
         nEjDnf1r5NRreu6fwnUMWeisHrNgyv3KAbvSbdAu5gF243QeJmEavDdxWjFfHbwq7OW7
         YFOc3KUPhrr9TbdLyJW52He0NR0qfK1shGTgnfSzcnuKw+j1FqGu22lHtAuSZ/jPImb+
         hv6yvym0eSlGm+p1iPw7lNRM2U8qjQI5pFeQwyj88rSgdKU970viqISRtCf7rpi4RFUQ
         YdoAAOqAHedbPgYghUpoP2nuY9WmirmdGNVVRTUisgEnc9sEbQgVxtfUzD2WlfhZIM84
         Dzew==
X-Forwarded-Encrypted: i=1; AJvYcCU8ocMCISKiNgK2+HGPyvXiL+AlqwsnsZ+dx86kkNhq0qtOZoMj5ru9CXK49lqmNv6eOBYYsitbDkMIhcBKcVESbjsaeCK2upLPi4g8Hg==
X-Gm-Message-State: AOJu0YyXWFKakXhcuzbDB84qO39svvkEQfGOys4p29t7ahAkdL8kXj8i
	1/Ol9xZAVw46Kp8DuZeD4jBPXD3DqZk1n0FxR9M+37L9YdzJl3dioJQp50FfvJ3M/vB202euHKz
	pGC9MDg==
X-Google-Smtp-Source: AGHT+IGt+jlzN3NG/IHT+PvQtdvgp3de2hBBZaJFC6qMiPxfYEdteTsxpyzb4g4AmOb5QNF4c4F0Pg==
X-Received: by 2002:ac2:59c1:0:b0:515:9ae2:93b0 with SMTP id x1-20020ac259c1000000b005159ae293b0mr4709004lfn.19.1711388722409;
        Mon, 25 Mar 2024 10:45:22 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id j15-20020a056512344f00b00513b1dec266sm1159431lfr.245.2024.03.25.10.45.21
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 10:45:21 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-513e134f73aso5956974e87.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Mar 2024 10:45:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVdyGKGejbVi6YXUWoPsAQ/zhriAdb0RBolKvdKSJQ8XyagG7dWT2blVksm2i4peEruwQ3TAm1AnXR3J4ZKfJM3aGUjtYOp6Ui7qr6v7w==
X-Received: by 2002:a17:906:6dc4:b0:a45:94bf:18e6 with SMTP id
 j4-20020a1709066dc400b00a4594bf18e6mr5614781ejt.73.1711388700462; Mon, 25 Mar
 2024 10:45:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322233838.868874-1-boqun.feng@gmail.com> <s2jeqq22n5ef5jknaps37mfdjvuqrns4w7i22qp2r7r4bzjqs2@my3eyxoa3pl3>
 <CAHk-=whY5A=S=bLwCFL=043DoR0TTgSDUmfPDx2rXhkk3KANPQ@mail.gmail.com>
 <u2suttqa4c423q4ojehbucaxsm6wguqtgouj7vudp55jmuivq3@okzfgryarwnv>
 <CAHk-=whkQk=zq5XiMcaU3xj4v69+jyoP-y6Sywhq-TvxSSvfEA@mail.gmail.com> <c51227c9a4103ad1de43fc3cda5396b1196c31d7.camel@redhat.com>
In-Reply-To: <c51227c9a4103ad1de43fc3cda5396b1196c31d7.camel@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 25 Mar 2024 10:44:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjP1i014DGPKTsAC6TpByC3xeNHDjVA4E4gsnzUgJBYBQ@mail.gmail.com>
Message-ID: <CAHk-=wjP1i014DGPKTsAC6TpByC3xeNHDjVA4E4gsnzUgJBYBQ@mail.gmail.com>
Subject: Re: [WIP 0/3] Memory model and atomic API in Rust
To: Philipp Stanner <pstanner@redhat.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, Boqun Feng <boqun.feng@gmail.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, llvm@lists.linux.dev, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, Alan Stern <stern@rowland.harvard.edu>, 
	Andrea Parri <parri.andrea@gmail.com>, Will Deacon <will@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Nicholas Piggin <npiggin@gmail.com>, 
	David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, 
	Luc Maranget <luc.maranget@inria.fr>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Akira Yokosawa <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, kent.overstreet@gmail.com, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, elver@google.com, 
	Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 25 Mar 2024 at 06:57, Philipp Stanner <pstanner@redhat.com> wrote:
>
> On Fri, 2024-03-22 at 17:36 -0700, Linus Torvalds wrote:
> >
> > It's kind of like our "volatile" usage. If you read the C (and C++)
> > standards, you'll find that you should use "volatile" on data types.
> > That's almost *never* what the kernel does. The kernel uses
> > "volatile"
> > in _code_ (ie READ_ONCE() etc), and uses it by casting etc.
> >
> > Compiler people don't tend to really like those kinds of things.
>
> Just for my understanding: Why don't they like it?

So I actually think most compiler people are perfectly fine with the
kernel model of mostly doing 'volatile' not on the data structures
themselves, but as accesses through casts.

It's very traditional C, and there's actually nothing particularly odd
about it. Not even from a compiler standpoint.

In fact, I personally will argue that it is fundamentally wrong to
think that the underlying data has to be volatile. A variable may be
entirely stable in some cases (ie locks held), but not in others.

So it's not the *variable* (aka "object") that is 'volatile', it's the
*context* that makes a particular access volatile.

That explains why the kernel has basically zero actual volatile
objects, and 99% of all volatile accesses are done through accessor
functions that use a cast to mark a particular access volatile.

But I've had negative comments from compiler people who read the
standards as language lawyers (which honestly, I despise - it's always
possible to try to argue what the meaning of some wording is), and
particularly C++ people used to be very very antsy about "volatile".

They had some truly _serious_ problems with volatile.

The C++ people spent absolutely insane amounts of time arguing about
"volatile objects" vs "accesses", and how an access through a cast
didn't make the underlying object volatile etc.

There were endless discussions because a lvalue isn't supposed to be
an access (an lvalue is something that is being acted on, and it
shouldn't imply an access because an access will then cause other
things in C++). So a statement expression that was just an lvalue
shouldn't imply an access in C++ originally, but obviously when the
thing was volatile it *had* to do so, and there was gnashing of teeth
over this all.

And all of it was purely semantic nitpicking about random wording. The
C++ people finally tried to save face by claiming that it was always
the C (not C++) rules that were unclear, and introduced the notion of
"glvalue", and it's all good now, but there's literally decades of
language lawyering and pointless nitpicking about the difference
between "objects" and "accesses".

Sane people didn't care, but if you reported a compiler bug about
volatile use, you had better be ready to sit back and be flamed for
how your volatile pointer cast wasn't an "object" and that the
compiler that clearly generated wrong code was technically correct,
and that your mother was a hamster.

It's a bit like the NULL debacle. Another thing that took the C++
people a couple of decades to admit they were wrong all along, and
that NULL isn't actually 'integer zero' in any sane language that
claims to care deeply about types.

[ And again, to save face, at no point did they say "ok, '(void *)0'
is fine" - they introduced a new __nullptr thing just so that they
wouldn't have to admit that their decades of arguing was just them
being wrong. You'll find another decade of arguments explaining the
finer details about _that_ difference ]

It turns out that the people who are language-lawyering nitpickers are
then happy to be "proven right" by adding some more pointless
syntacting language-lawyering language.

Which I guess makes sense, but to the rest of us it all looks a bit pointless.

                  Linus

