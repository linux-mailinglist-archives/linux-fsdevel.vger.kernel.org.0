Return-Path: <linux-fsdevel+bounces-15478-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4150E88F0CD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Mar 2024 22:21:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6410F1C2E45B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Mar 2024 21:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88DE015357E;
	Wed, 27 Mar 2024 21:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AAuybtnm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA761534E0;
	Wed, 27 Mar 2024 21:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711574506; cv=none; b=ECOl8d5Up0xyN4EPcnSy3uv5QUvO/DI7iQfMzqyLnng+1SU3spJ6FpGNGiwm2Z+Dk4jyoY0XGN3yuTxPlVocLrA/aFlOqTdqFdnQvZGFTXzodLSufjDBZR8JoIxMPCaVIXIptgCk+4uypmO8vGYw106dfodtMy8HAhmG4FsVkB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711574506; c=relaxed/simple;
	bh=92sHhCo4mE16EEY2gWj9OXJXpJBX3IDmAVU4FCwQsfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=enf2BtTeNWHVYN6fgVbZmhU1VzGBdmWjSLTzyOzMIRP+gcKHU7Jo7u5Wu9IVMJx/dLtFYqws+fKfsaJf8rwuO1SeHXF34QswXzoUt/G3Og2iwwyNy13nvGFjEqyazmAXI1XkzcW0H1qAuG9acEyS5Td3U8L7mXcxjATB3OCKJ68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AAuybtnm; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6e673ffbd79so162109a34.2;
        Wed, 27 Mar 2024 14:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711574503; x=1712179303; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gPexr1qL1sWHkOO5VvKGmiwPJykaCN4OnZNa3Q9bZFY=;
        b=AAuybtnmRN498tp+DG9D25lRfb8dfbJA1RaX9SXwxXq79peONVzFNLjY8hzym820Xb
         x/t/gRGphvzVQlGhxj76k3Khl0lJwt2bUEm6JZiCgPHq3ExSFERP/V08vGyBVHBxfMA7
         fpDrwaqFhnmczCI5/t5bl6A2N+vwOSNZZB5hhtTcSSO8kVjWg7LT+Tx3xeKANnMAnrUH
         m2+HVSTditl6wBdx3sqvU4wyAB9B15J4876rRv2BUW3YHeh0Vk1XZo/5yZtgnl5jtz3c
         vs+cNB/HW8VK5w9h07IOPPfp3wrR36UTEAxCFPfokidORWEzCemo4Brt7FknBGaDqZQC
         hLGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711574503; x=1712179303;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gPexr1qL1sWHkOO5VvKGmiwPJykaCN4OnZNa3Q9bZFY=;
        b=eX9PpuRquYNSVAIquA4+udcb35SnCLq/viMl9Ow9xPynJGSeKB40k8NU3nmuR1dCMr
         LHVNMAEeNv+3g28TImsAEBcvCkVSczfNwaPXv6yBtOQfbIXsy9HjgFi64u0BqzjTk+ri
         b8BbCMf6f65VDj1hqSyhGvYo5iowzmMKt1gR1JoFlDcM++7EwRnve/qrB0ijhnTCHqKm
         uQ2SkiYHyLJNS7eSxhywt6EPCgIyLpsA6d4FWg51GE2hTjMGEnOtnSjmeLEWahLgMscm
         GzMq+PPwBozHefDeVBr8xmAKksvctP7qT6bBmuVCs+2ZLPgfzX56mOoZU2ow6ljNc1Iz
         4M3w==
X-Forwarded-Encrypted: i=1; AJvYcCWRUvHkxw/LwKC84XA0xix35jh+chj7EpMYBaK1b2nIDxVvz30PCbQq9WiAehpEReAxUP1dQeIW0NxE4i5hWKulPTLhdFJMgULqh496GiEj2mdqAw4Mzd4UbQFb80hG/9yKZg6KUGyicOwZBREuuKXJKVAMk0ynVL26urpMgacxJNhdHuYsgUx/YFdhi1hM7/opknL9lN9CLpxy4yD0jlc4isBHBt2KQg==
X-Gm-Message-State: AOJu0YxnskFWparslt6BHVF8YUxy1iDNgS+tNzM3Q6d+mGWiH9utSbQL
	ij8ptAOLDXICsyG5k4w7r2afR9vZsBBkPGCV/1+S4rL9k3kl2nXy
X-Google-Smtp-Source: AGHT+IFwWxghWoZ03Kxvmq00ZJlmOcZRRjCIxBBmZTyM+9J4sTcFCpjAUAyRfv+g/a+r1EiNjL0Udw==
X-Received: by 2002:a05:6830:11c6:b0:6e6:a6fb:7a11 with SMTP id v6-20020a05683011c600b006e6a6fb7a11mr1161746otq.6.1711574503519;
        Wed, 27 Mar 2024 14:21:43 -0700 (PDT)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id b23-20020a05620a119700b0078a4590c62esm16536qkk.87.2024.03.27.14.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 14:21:43 -0700 (PDT)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfauth.nyi.internal (Postfix) with ESMTP id AE07E120006E;
	Wed, 27 Mar 2024 17:21:41 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Wed, 27 Mar 2024 17:21:41 -0400
X-ME-Sender: <xms:5I0EZmbZ27cWDN4rQSFDPD1mGD6J3gqPft95zmx1NK2_xZDwSctJQw>
    <xme:5I0EZpZQ6_OjJ4OxvaOAM9cbcgHQYN-sa1Vg36pOmk5WuxGGnxIwp5wZepZad9RGI
    IYMvvAo4wC3huvp4A>
X-ME-Received: <xmr:5I0EZg9sQJuKoJIbDUUTmu5CdPGalgp7jZROwpQq7h1O-iLEi9ncRTxMTws>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudduiedguddvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveei
    udffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:5I0EZoroOuCjY_LShRVntoYM4wBUgSW3y-Onjc31X25vu4l66PRUPA>
    <xmx:5I0EZhrDfK09Wfn5luLpWfnAQAXMzB9Uq5Ed0yTLBa7g1yum1g2u9A>
    <xmx:5I0EZmQKR94LcuhQkl-PDs_FjWU9DhiTb5rGtKjJy6FbvOqcsjCPFA>
    <xmx:5I0EZhrWYjaeSHmP1Tey_GBMyjcLKy9yKka_xoeMHz-c__VfBmPMrg>
    <xmx:5Y0EZkGtaDc1thMvTzTc1feW91AvSQk7aNfAr8PRT7LYvigqA7DzUcqTii7S3a-J>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Mar 2024 17:21:40 -0400 (EDT)
Date: Wed, 27 Mar 2024 14:21:03 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,	comex <comexk@gmail.com>,
	"Dr. David Alan Gilbert" <dave@treblig.org>,
	Philipp Stanner <pstanner@redhat.com>,
	rust-for-linux <rust-for-linux@vger.kernel.org>,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	llvm@lists.linux.dev, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Andrea Parri <parri.andrea@gmail.com>,	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Nicholas Piggin <npiggin@gmail.com>,	David Howells <dhowells@redhat.com>,
	Jade Alglave <j.alglave@ucl.ac.uk>,	Luc Maranget <luc.maranget@inria.fr>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,	Daniel Lustig <dlustig@nvidia.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,	kent.overstreet@gmail.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Marco Elver <elver@google.com>, Mark Rutland <mark.rutland@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,	Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [WIP 0/3] Memory model and atomic API in Rust
Message-ID: <ZgSNvzTkR4CY7kQC@boqun-archlinux>
References: <c51227c9a4103ad1de43fc3cda5396b1196c31d7.camel@redhat.com>
 <CAHk-=wjP1i014DGPKTsAC6TpByC3xeNHDjVA4E4gsnzUgJBYBQ@mail.gmail.com>
 <bu3seu56hfozsvgpdqjarbdkqo3lsjfc4lhluk5oj456xmrjc7@lfbbjxuf4rpv>
 <CAHk-=wgLGWBXvNODAkzkVHEj7zrrnTq_hzMft62nKNkaL89ZGQ@mail.gmail.com>
 <ZgIRXL5YM2AwBD0Y@gallifrey>
 <CAHk-=wjwxKD9CxYsf5x+K5fJbJa_JYZh1eKB4PT5cZJq1+foGw@mail.gmail.com>
 <160DB953-1588-418E-A490-381009CD8DE0@gmail.com>
 <qyjrex54hbhvhw4gmn7b6l2hr45o56bwt6fazfalykwcp5zzkx@vwt7k3d6kdwt>
 <CAHk-=wgQy+FRKjO_BvZgZN56w6-+jDO8p-Mt=X=zM70CG=CVBQ@mail.gmail.com>
 <bjorlxatlpzjlh6dfulham3u4mqsfqt7ir5wtayacaoefr2r7x@lmfcqzcobl3f>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bjorlxatlpzjlh6dfulham3u4mqsfqt7ir5wtayacaoefr2r7x@lmfcqzcobl3f>

On Wed, Mar 27, 2024 at 03:41:16PM -0400, Kent Overstreet wrote:
> On Wed, Mar 27, 2024 at 12:07:26PM -0700, Linus Torvalds wrote:
> > On Wed, 27 Mar 2024 at 11:51, Kent Overstreet <kent.overstreet@linux.dev> wrote:
> > >
> > > On Wed, Mar 27, 2024 at 09:16:09AM -0700, comex wrote:
> > > > Meanwhile, Rust intentionally lacks strict aliasing.
> > >
> > > I wasn't aware of this. Given that unrestricted pointers are a real
> > > impediment to compiler optimization, I thought that with Rust we were
> > > finally starting to nail down a concrete enough memory model to tackle
> > > this safely. But I guess not?
> > 
> > Strict aliasing is a *horrible* mistake.
> > 
> > It's not even *remotely* "tackle this safely". It's the exact
> > opposite. It's completely broken.
> > 
> > Anybody who thinks strict aliasing is a good idea either
> > 
> >  (a) doesn't understand what it means
> > 
> >  (b) has been brainwashed by incompetent compiler people.
> > 
> > it's a horrendous crock that was introduced by people who thought it
> > was too complicated to write out "restrict" keywords, and that thought
> > that "let's break old working programs and make it harder to write new
> > programs" was a good idea.
> 
> Strict aliasing is crap in C and C++ because we started out with
> unrestricetd pointers, and it just doesn't work in C and C++ with the
> realities of the kind of code we have to write, and we never got any
> kind of a model that would have made it workable. Never mind trying to
> graft that onto existing codebases...
> 
> (Restrict was crap too... no scoping, nothing but a single f*cking
> keyword? Who ever thought _that_ was going to work?)
> 
> _But_: the lack of any aliasing guarantees means that writing through
> any pointer can invalidate practically anything, and this is a real

I don't know whether I'm 100% correct on this, but Rust has references,
so things like "you have a unique reference to a part of memory, no one
would touch it in the meanwhile" are represented by `&mut`, to get a
`&mut` from a raw pointer, you need unsafe, where programmers can
provide the reasoning of the safety of the accesses. More like "pointers
can alias anyone but references cannot" to me.

Regards,
Boqun

> problem. A lot of C programmers have stockholm syndrome when it comes to
> this, we end up writing a lot of code in weirdly baroque and artificial
> styles to partially work around this when we care about performance -
> saving things into locals because at least the _stack_ generally can't
> alias to avoid forced reloads, or passing and returning things by
> reference instead of by value when that's _not the semantics we want_
> because otherwise the compiler is going to do an unnecessary copy -
> again, that's fundamentally because of aliasing.

