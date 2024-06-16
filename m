Return-Path: <linux-fsdevel+bounces-21777-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 715FB909DE6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Jun 2024 16:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B931281A68
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Jun 2024 14:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96EB110A19;
	Sun, 16 Jun 2024 14:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A1RRO9DD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C284E54D;
	Sun, 16 Jun 2024 14:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718546896; cv=none; b=ZygeXQ43JmK9Vv8YtFMCkQq3UW2F7PQLjeRaxgJKzFGF2S1YrQ6z0PV8Vur70zDK9JpiDozSFxXOdAH32nc2sHvNpPyZGvG98vaD1cB13yu+yQJ3qN0HYa9fVPATx5CAoNm95QR7qcBdW9rr50Ox9owivCZrpJMBIZwauImviz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718546896; c=relaxed/simple;
	bh=tNS9Etxsl6KrAzfyJHQLvYkh19XSh1b/dhR1ppMDTy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EXaF0uHX1VpR1MmA2a4f+TqyYRZ4X64kS6NqK1tP4wzOIGjd/qvG7DdqINJ6A2LA/tCGVkTDTAqcA042a7H3kakzjamZkKFU7DXJc+FyIMFqV4ZuySqGTwAa+zG7bsvMeiWYnHwTux0wOkOwTjH7UpJggwHMoLCg85FDnrTmG78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A1RRO9DD; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-43fecdecd32so18265701cf.1;
        Sun, 16 Jun 2024 07:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718546893; x=1719151693; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zWCtR0NK0A/iolZufFAg4WyNKPe6pDrlaIgYrNiP6lA=;
        b=A1RRO9DDW/DLW0FoMYp59eNqLduQHYMFrU9FUHaXi568vVaqJYUHf6q0HpQMkCJ+La
         TAivrhuHnVMwbeM7xkQkFh+DB6GzieGW4y7/k9CgpU6JsnabsP8ReffIXaxBdbMNemab
         oQDh0fQOEMRKmfcmBqf1mUeSyEf5F4Kh1PEs43InJ3YKCDeEPV3Ch1CyAOPAk7ixK/ch
         FqT8zKka2joXj45PF4W7AeQvLUNnrKzkxPD4CRap5zFJsqWoYZc3viaSnUIAAwbceAHA
         Wt1xRzjKVDVSabR/uAtag7rHuVUO8DroZB2ubunltZ7cvuB2PCW+0u6q5Lz1smqK9hBF
         Nf5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718546893; x=1719151693;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zWCtR0NK0A/iolZufFAg4WyNKPe6pDrlaIgYrNiP6lA=;
        b=TV2pJrEiCOF/ZZ0/tqf8EM/7GQTD0m0nWQz+n9knn7SM8cF9CP1WCup0L4KzmMIcOd
         bhJQ3fGOSS3GBxJXDwd8HNj0hzywluEqF6Q56u4NHvMoFDxeB2AQZCn5HuljShcO8k5H
         1s8MAxO0fOIT1Jx9dcYqXZV3n9Moz8JMmpdy4/0Z37i4boEJIqhjT/xcXXunCTPLhFAm
         9HwtHvQMnmrgvHcKJ/cqxiYjgbnDWlGd7QKh2DOrmQ3IhlZnmBybCYe5NLAyb11gt1IF
         QhSOgtKWVKf1Lj+VOv1yfK+Phv6yiW8sW7MFUaHg9Smg19W7iFVKRK+T8/PeBTWeHxIu
         fE3w==
X-Forwarded-Encrypted: i=1; AJvYcCVYmT8eKvp2zbX+pkYlpKqJ6rFfRUR3AqxLOqfktoK/VJ2S7XxZkCpuxc+3l66pLWXYRjHkLFMu3+VA+pTu4IQlqxGxGnHaF797cAntFyQFTBWK+Rhzq+mYljRG+BLf1ok/EyhB0R9uWaLgE5/r9RDskyIZFVNER8ZJUESSLKfQ1swJ+cA1hL/oBi7cKNgCoiBAm55DSmx+NukHfsYgOEAR5gBmVI21iA==
X-Gm-Message-State: AOJu0YwDv3eaCo7ApHPEzaQVapHf3bAllFbx0xDK8VtjWySse+b3oVp3
	vyoAaL2CMB6MIA5IpE4WwOxZYQtSmE+7gAVttxTfUKV3hkG3VLbg
X-Google-Smtp-Source: AGHT+IGlsF1MCeeD/KzOzQlwQyzWV7lOdWKNgh9/d8ctGowzFmw3RRNpVqJUcbfJaqo3xJiTmTpRUQ==
X-Received: by 2002:a05:622a:15d4:b0:441:2995:fa08 with SMTP id d75a77b69052e-4421687be0emr81833641cf.19.1718546893299;
        Sun, 16 Jun 2024 07:08:13 -0700 (PDT)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-441f310cdfasm36804731cf.96.2024.06.16.07.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jun 2024 07:08:12 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 8033F1200043;
	Sun, 16 Jun 2024 10:08:11 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sun, 16 Jun 2024 10:08:11 -0400
X-ME-Sender: <xms:y_FuZoXUsb9Fea5tacKe7eNwuAduShZLmEcoXqH6crBYlzsqlWhXXQ>
    <xme:y_FuZskWOezMBnbYwjp3og6tmJi6ObsIwojhL1uwpy0hMjnCVOBAphc03TX7xMPNj
    lmyZz4_LHW4hVCHRA>
X-ME-Received: <xmr:y_FuZsahcyUHHHnG69tBUNBnER5r1oF-OUUbM1izy9llRsYN5ywcLyvjXw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedvfedgjeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhepvefghfeuveekudetgfevudeuudejfeeltdfhgfehgeekkeeigfdukefh
    gfegleefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:y_FuZnUx__DUoq5IJxvYBVdDZm-X6WSSWZ8Z-L_nZ-y6mMIGpuf-8Q>
    <xmx:y_FuZinxNi3Rq56P5ak2cUuMiZkEUDrhPpfP75NZChRPdkUhVF0xpA>
    <xmx:y_FuZscgwv2EqjXGDgVbBL6IiFxNxf5Hy6kQFFxC96wFkn0CI9XFqg>
    <xmx:y_FuZkFQLLHo9gTdQVexGeTslO0hz1bpm4ObMNBvYQOwEg4MghJO3Q>
    <xmx:y_FuZolelaIdKyco5D_xqsRgD6CHUK2IYZP5MPr78Ej5fkWxjjy1F2cT>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Jun 2024 10:08:10 -0400 (EDT)
Date: Sun, 16 Jun 2024 07:08:09 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Gary Guo <gary@garyguo.net>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	llvm@lists.linux.dev, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
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
Message-ID: <Zm7xySzPJcddF-I_@Boquns-Mac-mini.home>
References: <20240612223025.1158537-3-boqun.feng@gmail.com>
 <CANiq72myhoCCWs7j0eZuxfoYMbTez7cPa795T57+gz2Dpd+xAw@mail.gmail.com>
 <ZmtC7h7v1t6XJ6EI@boqun-archlinux>
 <CANiq72=JdqTRPiUfT=-YMTTN+bHeAe2Pba8nERxU3cN8Q-BEOw@mail.gmail.com>
 <ZmxUxaIwHWnB42h-@Boquns-Mac-mini.home>
 <c1c45a2e-afdf-40a6-9f44-142752368d5e@proton.me>
 <ZmzvVr7lYfR6Dpca@Boquns-Mac-mini.home>
 <b692945b-8fa4-4918-93f6-783fbcde375c@proton.me>
 <Zm4R0XwTpsASpBhx@Boquns-Mac-mini.home>
 <d67aeb8c-3499-4498-aaf9-4ac459c2f747@proton.me>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d67aeb8c-3499-4498-aaf9-4ac459c2f747@proton.me>

On Sun, Jun 16, 2024 at 09:46:45AM +0000, Benno Lossin wrote:
> On 16.06.24 00:12, Boqun Feng wrote:
> > On Sat, Jun 15, 2024 at 07:09:30AM +0000, Benno Lossin wrote:
> >> On 15.06.24 03:33, Boqun Feng wrote:
> >>> On Fri, Jun 14, 2024 at 09:22:24PM +0000, Benno Lossin wrote:
> >>>> On 14.06.24 16:33, Boqun Feng wrote:
> >>>>> On Fri, Jun 14, 2024 at 11:59:58AM +0200, Miguel Ojeda wrote:
> >>>>>> On Thu, Jun 13, 2024 at 9:05 PM Boqun Feng <boqun.feng@gmail.com> wrote:
> >>>>>>>
> >>>>>>> Does this make sense?
> >>>>>>
> >>>>>> Implementation-wise, if you think it is simpler or more clear/elegant
> >>>>>> to have the extra lower level layer, then that sounds fine.
> >>>>>>
> >>>>>> However, I was mainly talking about what we would eventually expose to
> >>>>>> users, i.e. do we want to provide `Atomic<T>` to begin with? If yes,
> >>>>>
> >>>>> The truth is I don't know ;-) I don't have much data on which one is
> >>>>> better. Personally, I think AtomicI32 and AtomicI64 make the users have
> >>>>> to think about size, alignment, etc, and I think that's important for
> >>>>> atomic users and people who review their code, because before one uses
> >>>>> atomics, one should ask themselves: why don't I use a lock? Atomics
> >>>>> provide the ablities to do low level stuffs and when doing low level
> >>>>> stuffs, you want to be more explicit than ergonomic.
> >>>>
> >>>> How would this be different with `Atomic<i32>` and `Atomic<i64>`? Just
> >>>
> >>> The difference is that with Atomic{I32,I64} APIs, one has to choose (and
> >>> think about) the size when using atomics, and cannot leave that option
> >>> open. It's somewhere unconvenient, but as I said, atomics variables are
> >>> different. For example, if someone is going to implement a reference
> >>> counter struct, they can define as follow:
> >>>
> >>> 	struct Refcount<T> {
> >>> 	    refcount: AtomicI32,
> >>> 	    data: UnsafeCell<T>
> >>> 	}
> >>>
> >>> but with atomic generic, people can leave that option open and do:
> >>>
> >>> 	struct Refcount<R, T> {
> >>> 	    refcount: Atomic<R>,
> >>> 	    data: UnsafeCell<T>
> >>> 	}
> >>>
> >>> while it provides configurable options for experienced users, but it
> >>> also provides opportunities for sub-optimal types, e.g. Refcount<u8, T>:
> >>> on ll/sc architectures, because `data` and `refcount` can be in the same
> >>> machine-word, the accesses of `refcount` are affected by the accesses of
> >>> `data`.
> >>
> >> I think this is a non-issue. We have two options of counteracting this:
> >> 1. We can just point this out in reviews and force people to use
> >>    `Atomic<T>` with a concrete type. In cases where there really is the
> >>    need to be generic, we can have it.
> >> 2. We can add a private trait in the bounds for the generic, nobody
> >>    outside of the module can access it and thus they need to use a
> >>    concrete type:
> >>
> >>         // needs a better name
> >>         trait Integer {}
> >>         impl Integer for i32 {}
> >>         impl Integer for i64 {}
> >>
> >>         pub struct Atomic<T: Integer> {
> >>             /* ... */
> >>         }
> >>
> >> And then in the other module, you can't do this (with compiler error):
> >>
> >>         pub struct Refcount<R: Integer, T> {
> >>                             // ^^^^^^^ not found in this scope
> >>                             // note: trait `crate::atomic::Integer` exists but is inaccessible
> >>             refcount: Atomic<R>,
> >>             data: UnsafeCell<T>,
> >>         }
> >>
> >> I think that we can start with approach 2 and if we find a use-case
> >> where generics are really unavoidable, we can either put it in the same
> >> module as `Atomic<T>`, or change the access of `Integer`.
> >>
> > 
> > What's the issue of having AtomicI32 and AtomicI64 first then? We don't
> > need to do 1 or 2 until the real users show up.
> 
> Generics allow you to avoid code duplication (I don't think that you
> want to create the `Atomic{I32,I64}` types via macros...). We would have
> to do a lot of refactoring, when we want to introduce it. I don't see

You can simply do

	type AtomicI32=Atomic<i32>;

Plus, we always do refactoring in kernel, because it's impossible to get
everything right at the first time. TBH, it's too confident to think one
can.

> the harm of introducing generics from the get-go.
> 
> > And I'd like also to point out that there are a few more trait bound
> > designs needed for Atomic<T>, for example, Atomic<u32> and Atomic<i32>
> > have different sets of API (no inc_unless_negative() for u32).
> 
> Sure, just like Gary said, you can just do:
> 
>     impl Atomic<i32> {
>         pub fn inc_unless_negative(&self, ordering: Ordering) -> bool;
>     }
> 
> Or add a `HasNegative` trait.
> 
> > Don't make me wrong, I have no doubt we can handle this in the type
> > system, but given the design work need, won't it make sense that we take
> > baby steps on this? We can first introduce AtomicI32 and AtomicI64 which
> > already have real users, and then if there are some values of generic
> > atomics, we introduce them and have proper discussion on design.
> 
> I don't understand this point, why can't we put in the effort for a good
> design? AFAIK we normally spend considerable time to get the API right
> and I think in this case it would include making it generic.
> 

What's the design you propose here? Well, the conversation between us is
only the design bit I saw, elsewhere it's all handwaving that "generics
are overall really good". I'm happy to get the API right, and it's easy
and simple to do on concrete types. But IIUC, Gary's suggestion is to
only have Atomic<i32> and Atomic<i64> first, and do the design later,
which I really don't like. It may not be a complete design, but I need
to see the design now to understand whether we need to go to that
direction. I cannot just introduce a TBD generic.

Regards,
Boqun

> > To me, it's perfectly fine that Atomic{I32,I64} co-exist with Atomic<T>.
> > What's the downside? A bit specific example would help me understand
> > the real concern here.
> 
> I don't like that, why have two ways of doing the same thing? People
> will be confused whether they should use `AtomicI32` vs `Atomic<i32>`...
> 
> ---
> Cheers,
> Benno
> 

