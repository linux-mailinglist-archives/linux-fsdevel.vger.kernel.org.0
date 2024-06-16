Return-Path: <linux-fsdevel+bounces-21781-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1180909E0C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Jun 2024 17:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A02232816F5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Jun 2024 15:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3225014292;
	Sun, 16 Jun 2024 15:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Valy6Z1L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E647FBF6;
	Sun, 16 Jun 2024 15:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718550372; cv=none; b=RSJpOrLwuQM4lKpROOKtoojDK1wYNAbUZjj5EuZSncSgj5Sbu1yre/qxQnXZ2c4UXu9nZk/ftOH6xDBhxHpO1d9GICwhVBFRKGD5pr/56Brnmn/WGpk5+yTsWi3N5y3XsCWYEhrrN11DY7TAOH19OvKuCAvrd+7thEmSCeuugHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718550372; c=relaxed/simple;
	bh=eodZ+veoHiLvaS3SWWrwg+RSiia4D2YjRohGE/R66+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=izeO9JhvM/VrWkUfv+ZLHRqt7T5fR5b8voKgh6IVtC3Q4LlUjzUMae1zuwFaMfoDy0aKxLA3vSEpwJqJ7NG1MBy63O6QZBj5Ox6dEa9QK972uuOHsR5+MHCS7vC4wg9e4KMwQ7b7qw83YLpBVFQyhABjNYIYtXfv0rfMunFSbHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Valy6Z1L; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6b064841f81so29326496d6.1;
        Sun, 16 Jun 2024 08:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718550369; x=1719155169; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VqObIqQp+WLPy3VVCqeSeRx29NarkCBbux5QQu76V4Y=;
        b=Valy6Z1LcuOAYdNLqh5s7edYH5rWeCdAvw1rqRfa62QjQ8JQv0seDl2fLDU4Dgv6CN
         vnAK3Jnbxm8pBcSlbfx9q5Olgj6P5bqmIBzAb7CKEUbOyQRrDhHiqynUH+yTNmu8fH9+
         NVimIgAkawEqICLKSwkJL2N6WHpWyrU6E5ptygm01WVwGYf5ePTsTgVyxOcfbzp8+M4C
         0SXmkeC5z+OSwd8PNvJiT8xqOlL5iyfnHeqqHyy7Dx78MDb5cL/V8hcVFQnv2beOzmCW
         vmugyYSmfoK3h+taPnrI1ZsMgSTKFXowvfVOAmzGtRJQLP8zFVYzrZC6ZcTCY06Wd2qw
         PlHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718550369; x=1719155169;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VqObIqQp+WLPy3VVCqeSeRx29NarkCBbux5QQu76V4Y=;
        b=k80mVug6C5BdtYeJnpchpoW8VMpVCvmFdjItyqaEQLhcnW8HT5ybpOpjXL4LUmADvW
         XgmTr9BbpPEUKZ3KqtQLb2Wm3AruJUfJiD8xoXv6QFJFY4Sb23qCi+J/17UfWJahYk3d
         02z9e6VZrDfRtxjvq61BzmIcYNUOhl6LP7/nb7GRJCm0UgjOcMJVCgtEjjL5fa2mF8ZX
         up1WAiIjIJqDq3woPsFscY5xBMG/HNcYW5lmYgd/RhJ+Dfo9omHMA8Rb+D1vp2/EAXf7
         6f36wjuWcJJHVtE3XSf5gK/rSqMpM59FaQp77/UkHwTK78PNpsBZV7cZhQ2d4ujvuakD
         +uhw==
X-Forwarded-Encrypted: i=1; AJvYcCXK1fzEAXYqINnIvYoqXQnYCw4JSxISebbkcg6uXufEVFCe/FiCko6XfI3C4BN/0ZmI4TuloPs+bDPWji1zieUVcaDoS27e7AnKi3X8tCyNEuQOkziF1WBeKywS1iX4OCKGhhHRLJ7Z6XXNYDXPIR3LbzGHRiWX2ZGHLZ+y5grqk7uRcpvTrfpFvQmtTuU3l0BD45VmdvhHxwnUEiEP6PkJc/WeHNT7RA==
X-Gm-Message-State: AOJu0YxWAF7wF1NIhPApsVfFPvZULCqo4RWjJ6+hpnCuysTgyJ/315Ii
	AUa1WpltMVlStgROnRASLkb9W9Uc2GRQJgJHGxSR38HzhqHpSY65
X-Google-Smtp-Source: AGHT+IGBNIQC6j0BqwcDzH3wRTTRHzh/QPcr+NqgMAY2KJ5ds6X+rg2sPyjML9quC4pDD9ZSVedEYg==
X-Received: by 2002:ad4:4ea9:0:b0:6b0:8f42:2435 with SMTP id 6a1803df08f44-6b2afd6a451mr116202186d6.51.1718550368805;
        Sun, 16 Jun 2024 08:06:08 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5bf2879sm44716896d6.21.2024.06.16.08.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jun 2024 08:06:08 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 3E0C61200043;
	Sun, 16 Jun 2024 11:06:07 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sun, 16 Jun 2024 11:06:07 -0400
X-ME-Sender: <xms:X_9uZvCCkIhVEDfGa96FmikD-smutPRls8X6T98ysAk3o8mYV0NSEA>
    <xme:X_9uZlh8YRgX0duI0y2Ie5sn-Jn-72D0ogLmixpPtK7D8IM8JBp9sxggGiclyNTGA
    XZkNo2M92bSJ9xOiw>
X-ME-Received: <xmr:X_9uZqlZud_vyJdZgPDo1LlRLeUHA1ZC_X2ILBo2_1CboirpuDTWN8zYcw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedvfedgkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhepgffgheejtdfhheehtdejffehgedujeekudfgieejledttedvvdeiuefg
    fedvffdvnecuffhomhgrihhnpegtrhgrthgvshdrihhonecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhh
    phgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunh
    drfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:X_9uZhxvKEM97Ulpcf4GVxbxFnA7E_JZZyvyZz9dedGrt-a4kbWJyA>
    <xmx:X_9uZkQ7Ht69gXaoQIf43_cdFuyBs6VfZDjIjuKy3uUQbzEFkenwZg>
    <xmx:X_9uZkbwtNcKXt6VNNVWdwo_nPXrIIQUFO-9iL9Gp-BAppy8gxX2uA>
    <xmx:X_9uZlTDDg_hBZyPuca8BcznkGuTRWsh_xJwHtIlUASb2--utKbj3Q>
    <xmx:X_9uZqBv556ZNnyPfitADxfD6mvgWmY6JVws7eQzSbfTxCHhO7UNroo1>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Jun 2024 11:06:06 -0400 (EDT)
Date: Sun, 16 Jun 2024 08:06:05 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Gary Guo <gary@garyguo.net>
Cc: John Hubbard <jhubbard@nvidia.com>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, llvm@lists.linux.dev,
	Miguel Ojeda <ojeda@kernel.org>,	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
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
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, elver@google.com,
	Mark Rutland <mark.rutland@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,	Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Catalin Marinas <catalin.marinas@arm.com>,	torvalds@linux-foundation.org,
 linux-arm-kernel@lists.infradead.org,	linux-fsdevel@vger.kernel.org,
 Trevor Gross <tmgross@umich.edu>,	dakr@redhat.com
Subject: Re: [RFC 2/2] rust: sync: Add atomic support
Message-ID: <Zm7_XWe6ciy1yN-h@Boquns-Mac-mini.home>
References: <20240613144432.77711a3a@eugeo>
 <ZmseosxVQXdsQjNB@boqun-archlinux>
 <CANiq72myhoCCWs7j0eZuxfoYMbTez7cPa795T57+gz2Dpd+xAw@mail.gmail.com>
 <ZmtC7h7v1t6XJ6EI@boqun-archlinux>
 <CANiq72=JdqTRPiUfT=-YMTTN+bHeAe2Pba8nERxU3cN8Q-BEOw@mail.gmail.com>
 <79239550-dd6e-4738-acea-e7df50176487@nvidia.com>
 <ZmztZd9OJdLnBZs5@Boquns-Mac-mini.home>
 <c243bef3-e152-462f-be68-91dbf876092b@nvidia.com>
 <Zmz-338Ad6r4vzM-@Boquns-Mac-mini.home>
 <20240616155145.54371240.gary@garyguo.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240616155145.54371240.gary@garyguo.net>

On Sun, Jun 16, 2024 at 03:51:45PM +0100, Gary Guo wrote:
> On Fri, 14 Jun 2024 19:39:27 -0700
> Boqun Feng <boqun.feng@gmail.com> wrote:
> 
> > On Fri, Jun 14, 2024 at 06:28:00PM -0700, John Hubbard wrote:
> > > On 6/14/24 6:24 PM, Boqun Feng wrote:  
> > > > On Fri, Jun 14, 2024 at 06:03:37PM -0700, John Hubbard wrote:  
> > > > > On 6/14/24 2:59 AM, Miguel Ojeda wrote:  
> > > > > > On Thu, Jun 13, 2024 at 9:05 PM Boqun Feng <boqun.feng@gmail.com> wrote:  
> > > > > > > 
> > > > > > > Does this make sense?  
> > > > > > 
> > > > > > Implementation-wise, if you think it is simpler or more clear/elegant
> > > > > > to have the extra lower level layer, then that sounds fine.
> > > > > > 
> > > > > > However, I was mainly talking about what we would eventually expose to
> > > > > > users, i.e. do we want to provide `Atomic<T>` to begin with? If yes,
> > > > > > then we could make the lower layer private already.
> > > > > > 
> > > > > > We can defer that extra layer/work if needed even if we go for
> > > > > > `Atomic<T>`, but it would be nice to understand if we have consensus
> > > > > > for an eventual user-facing API, or if someone has any other opinion
> > > > > > or concerns on one vs. the other.  
> > > > > 
> > > > > Well, here's one:
> > > > > 
> > > > > The reason that we have things like atomic64_read() in the C code is
> > > > > because C doesn't have generics.
> > > > > 
> > > > > In Rust, we should simply move directly to Atomic<T>, as there are,
> > > > > after all, associated benefits. And it's very easy to see the connection  
> > > > 
> > > > What are the associated benefits you are referring to? Rust std doesn't
> > > > use Atomic<T>, that somewhat proves that we don't need it.  
> > > Just the stock things that a generic provides: less duplicated code,  
> > 
> > It's still a bit handwavy, sorry.
> > 
> > Admittedly, I haven't looked into too much Rust concurrent code, maybe
> > it's even true for C code ;-) So I took a look at the crate that Gary
> > mentioned (the one provides generic atomic APIs):
> > 
> > 	https://crates.io/crates/atomic
> > 
> > there's a "Dependent" tab where you can see the other crates that
> > depends on it. With a quick look, I haven't found any Rust concurrent
> > project I'm aware of (no crossbeam, no tokio, no futures). On the other
> > hand, there is a non-generic based atomic library:
> > 
> > 	https://crates.io/crates/portable-atomic
> > 
> > which has more projects depend on it, and there are some Rust concurrent
> > projects that I'm aware of: futures, async-task etc. Note that people
> > can get the non-generic based atomic API from Rust std library, and
> > the "portable-atomic" crate is only 2-year old, while "atomic" crate is
> > 8-year old.
> > 
> > More interestingly, the same author of "atomic" crate, who is an expert
> > in concurrent areas, has another project (there are a lot projects from
> > the author, but this is the one I'm mostly aware of) "parking_lot",
> > which "provides implementations of Mutex, RwLock, Condvar and Once that
> > are smaller, faster and more flexible than those in the Rust standard
> > library, as well as a ReentrantMutex type which supports recursive
> > locking.", and it doesn't use the "atomic" crate either.
> 
> Note that crossbeam's AtomicCell is also generic, and crossbeam is used
> by tons of crates. As Miguel mentioned, I think it's very likely that in
> the future we want be able to do atomics on new types (e.g. for
> seqlocks perhaps). We probably don't need the non-lock-free fallback of

Good, another design bit, thank you!

What's our overall idea on sub-word types, like Atomic<u8> and
Atomic<u16>, do we plan to say no to them, or they could have a limited
APIs? IIUC, some operations on them are relatively sub-optimal on some
architectures, supporting the same set of API as i32 and i64 is probably
a bad idea.

Another thing in my mind is making `Atomic<T>`

	pub struct Atomic<T: Send + ...> { ... }

so that `Atomic<T>` will always be `Sync`, because quite frankly, an
atomic type that cannot `Sync` is pointless.

Regards,
Boqun

> crossbeam's AtomicCell, but the lock-free subset with newtype support
> is desirable.
> 
> People in general don't use the `atomic` crate because it provides no
> additional feature compared to the standard library. But it doesn't
> really mean that the standard library's atomic design is good.
> 
> People decided to use AtomicT and NonZeroT instead of Atomic<T> or
> NonZero<T> long time ago, but many now thinks the decision was bad.
> Introduction of NonZero<T> is a good example of it. NonZeroT are now
> all type aliases of NonZero<T>.
> 
> I also don't see any downside in using generics. We can provide type
> aliases so people can use `AtomicI32` and `AtomicI64` when they want
> their code to be compatible with userspace Rust can still do so.
> 
> `Atomic<i32>` is also just aesthetically better than `AtomicI32` IMO.
> When all other types look like `NonZero<i32>`, `Wrapping<i32>`, I don't
> think we should have `AtomicI32` just because "it's done this way in
> Rust std". Our alloc already deviates a lot from Rust std.
> 
> Best,
> Gary

