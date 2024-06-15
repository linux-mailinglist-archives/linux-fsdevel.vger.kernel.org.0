Return-Path: <linux-fsdevel+bounces-21766-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21911909A34
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Jun 2024 00:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CE551C20BD0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Jun 2024 22:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40AD64CCC;
	Sat, 15 Jun 2024 22:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eux/TtLv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91961773A;
	Sat, 15 Jun 2024 22:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718489560; cv=none; b=Hnqy6Ce2wFBMAtTnZULFqf39PRUS8ZRnrVIr1YhlKKhDJ9D6GZhxj5wKVJ4aRvmPiam9QISyucH40V0p5i0X4iQaT+0YAZvX1K1v8fR3faqf+aKb0EkceheT7ee0CChJ6dRxrg2waKqmc/bGWTK/YYZ4axxV+vMLbXu2gr54ggo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718489560; c=relaxed/simple;
	bh=lHxr0MwsemA2ZMnqJsxiMmV5XulPnNeOMTCLuiEYGpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l41UMoK4APSA13FYJGYjlFu0TNq6/7/sK5Jbs2zh4ou/Vw3veK/grHgE4O5sS6Q9aEBpqQX0Gr7yLMULUGmeGqIUWyupipDSMEOMul5nY0ZA10i/GRSb1UGueSMjsnFMRboInNfCdsk1MT27jlsTyzQSkGDBOFDJ/6P42AJWRlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eux/TtLv; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6ae259b1c87so36347206d6.1;
        Sat, 15 Jun 2024 15:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718489558; x=1719094358; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VQbZ8odua1hQgPb+pK/nZMpMy6s0hU++zOMWAbph2Ak=;
        b=Eux/TtLvuTusRZoxAFHYLpBs35dyCC8YSls+jMkP7QQwd1yQhU3u4RT+l+NjUgYqYi
         nF3p/Iw5KYi4ch9YRhx8F5O1ppWIyZym3+x9xTFa7dpgbtJT+Xzi3NJSDO2O/LVNF7tB
         d/b/6s3Nd6KN0pD1Pqwf5KLd4d0oupIxJH2g22vECnKRlt0McP18nh39PPtHGWSPkIF0
         25FlbbW+YwWqky7FGZy+GpUZjkySk/UZGpkaHB/myTimima29cCKc7AxE7jNYGYJ4UIx
         0w2EqeFp/HgTkqJPQP3n/1WXkK183ApHhln1kGLif5uODEA/5l8vcKH28Kgs6OiwQC1R
         V1Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718489558; x=1719094358;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VQbZ8odua1hQgPb+pK/nZMpMy6s0hU++zOMWAbph2Ak=;
        b=t0U4lkC0E+gn8bn/wqxA48oqM22JVcwVQVH+d5ZS4op/TjVq7cnkemdwDBQU6LFXRj
         Yj8BlLwPuRL+/XUPQbJn1SYDKw+gN5Iu/IPfgpMbRVIDyMrYS7wGAZj77XSGEkB9n1qR
         AifQJ3VXXGXxQsek3NOgoPynyVH8P0X4LHRCQETgLSHUeM8PlTEnRs0VKq5pSovVNT0t
         EM7WRaxBOKASNaWOSXBoq32A/vFUYgNwWauXMyEcdLKp9DI8QLRt2CuIQyi0/6ysMqtp
         weLG4cTiT7pcxpmhR2F9/O7r676kM+lED856VqexhOl3CwCjdJavtqaMQwRIZWbN//Pi
         HOrw==
X-Forwarded-Encrypted: i=1; AJvYcCXR4369Dw27eFJwqdcNzuH6jlSouVZz+mn6p5olpMNW1h4nDO09OmpiczJjTEwDeteHVuKnrkJE01cMrNVSCvR5M/Jsjh/8mtcCtlLNlCToJTvMcJreOb1h+u6XCGGgZCBWdfa/ow3Ne+VzByPRh9NVMHMkmXDVM1yyVnkxGHe+OxnrGyALTN8Dji6VZ8zMY5xgQVe2QB5ThxmU0TJwnm1pQjWWMgLohQ==
X-Gm-Message-State: AOJu0YwD0mtqcEhllUz5u34AX/EEFYmt49gbvPlDYu4QV1Zqx8kskRL2
	gGq9HoSk8nSkfm7cA5n7dhnkb7PeTPpXq2/KB3yihVz+pPT3Uxnn
X-Google-Smtp-Source: AGHT+IG4HmvNaRjIhMLhZmWvrLBxGBdGzpx8lIGc5erMmHO1rw2wmIF90qlwEKwxcvp0aYOUU1vmBA==
X-Received: by 2002:a0c:c486:0:b0:6af:33ed:87de with SMTP id 6a1803df08f44-6b2af2eef89mr96166876d6.20.1718489557589;
        Sat, 15 Jun 2024 15:12:37 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5ee01d9sm36048266d6.111.2024.06.15.15.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jun 2024 15:12:36 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfauth.nyi.internal (Postfix) with ESMTP id BB4DA120006D;
	Sat, 15 Jun 2024 18:12:35 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sat, 15 Jun 2024 18:12:35 -0400
X-ME-Sender: <xms:0xFuZlrY_bE0nKnF8etf9N11hrXBGTSZUsqajV7vSx_NMcCiVHBxWA>
    <xme:0xFuZnoWZKABHQym_Al27-R6FbyuPJoHjXkImVwCQoKNHNYPV12cPXCh74-QPxjV_
    uP26wfRs8Syfm4Y4A>
X-ME-Received: <xmr:0xFuZiOGp7JlumhoS4vNAISpZyxHz9paxafo9_oM3Q3HNZ-HrbFMwNYdRw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedvvddgtdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhepvefghfeuveekudetgfevudeuudejfeeltdfhgfehgeekkeeigfdukefh
    gfegleefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:0xFuZg77_tq59ml7HlC_Z5h69QygySdhdEM0vBwuiOHNNd6XPNeTBw>
    <xmx:0xFuZk49SyUhxrXrXcs19xpi75s5rJM0mbiY4SfqTWFVFONMGKODWA>
    <xmx:0xFuZojK6yKmo-LzjJ8_UBHNkd4DUJUUGkL1C4hN7ct-SpajKsTZ2g>
    <xmx:0xFuZm79WM7Y1DZ3Gur-JaVOLAvHAiLK2HHqVh31qOKaLNauBRm6Nw>
    <xmx:0xFuZrKIrd0e9826BTvfWSIKsKcRvW-fQZ4wYyZNqlSrPnFgBSdCr7By>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 15 Jun 2024 18:12:34 -0400 (EDT)
Date: Sat, 15 Jun 2024 15:12:33 -0700
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
Message-ID: <Zm4R0XwTpsASpBhx@Boquns-Mac-mini.home>
References: <20240612223025.1158537-3-boqun.feng@gmail.com>
 <20240613144432.77711a3a@eugeo>
 <ZmseosxVQXdsQjNB@boqun-archlinux>
 <CANiq72myhoCCWs7j0eZuxfoYMbTez7cPa795T57+gz2Dpd+xAw@mail.gmail.com>
 <ZmtC7h7v1t6XJ6EI@boqun-archlinux>
 <CANiq72=JdqTRPiUfT=-YMTTN+bHeAe2Pba8nERxU3cN8Q-BEOw@mail.gmail.com>
 <ZmxUxaIwHWnB42h-@Boquns-Mac-mini.home>
 <c1c45a2e-afdf-40a6-9f44-142752368d5e@proton.me>
 <ZmzvVr7lYfR6Dpca@Boquns-Mac-mini.home>
 <b692945b-8fa4-4918-93f6-783fbcde375c@proton.me>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b692945b-8fa4-4918-93f6-783fbcde375c@proton.me>

On Sat, Jun 15, 2024 at 07:09:30AM +0000, Benno Lossin wrote:
> On 15.06.24 03:33, Boqun Feng wrote:
> > On Fri, Jun 14, 2024 at 09:22:24PM +0000, Benno Lossin wrote:
> >> On 14.06.24 16:33, Boqun Feng wrote:
> >>> On Fri, Jun 14, 2024 at 11:59:58AM +0200, Miguel Ojeda wrote:
> >>>> On Thu, Jun 13, 2024 at 9:05 PM Boqun Feng <boqun.feng@gmail.com> wrote:
> >>>>>
> >>>>> Does this make sense?
> >>>>
> >>>> Implementation-wise, if you think it is simpler or more clear/elegant
> >>>> to have the extra lower level layer, then that sounds fine.
> >>>>
> >>>> However, I was mainly talking about what we would eventually expose to
> >>>> users, i.e. do we want to provide `Atomic<T>` to begin with? If yes,
> >>>
> >>> The truth is I don't know ;-) I don't have much data on which one is
> >>> better. Personally, I think AtomicI32 and AtomicI64 make the users have
> >>> to think about size, alignment, etc, and I think that's important for
> >>> atomic users and people who review their code, because before one uses
> >>> atomics, one should ask themselves: why don't I use a lock? Atomics
> >>> provide the ablities to do low level stuffs and when doing low level
> >>> stuffs, you want to be more explicit than ergonomic.
> >>
> >> How would this be different with `Atomic<i32>` and `Atomic<i64>`? Just
> > 
> > The difference is that with Atomic{I32,I64} APIs, one has to choose (and
> > think about) the size when using atomics, and cannot leave that option
> > open. It's somewhere unconvenient, but as I said, atomics variables are
> > different. For example, if someone is going to implement a reference
> > counter struct, they can define as follow:
> > 
> > 	struct Refcount<T> {
> > 	    refcount: AtomicI32,
> > 	    data: UnsafeCell<T>
> > 	}
> > 
> > but with atomic generic, people can leave that option open and do:
> > 
> > 	struct Refcount<R, T> {
> > 	    refcount: Atomic<R>,
> > 	    data: UnsafeCell<T>
> > 	}
> > 
> > while it provides configurable options for experienced users, but it
> > also provides opportunities for sub-optimal types, e.g. Refcount<u8, T>:
> > on ll/sc architectures, because `data` and `refcount` can be in the same
> > machine-word, the accesses of `refcount` are affected by the accesses of
> > `data`.
> 
> I think this is a non-issue. We have two options of counteracting this:
> 1. We can just point this out in reviews and force people to use
>    `Atomic<T>` with a concrete type. In cases where there really is the
>    need to be generic, we can have it.
> 2. We can add a private trait in the bounds for the generic, nobody
>    outside of the module can access it and thus they need to use a
>    concrete type:
> 
>         // needs a better name
>         trait Integer {}
>         impl Integer for i32 {}
>         impl Integer for i64 {}
> 
>         pub struct Atomic<T: Integer> {
>             /* ... */
>         }
> 
> And then in the other module, you can't do this (with compiler error):
> 
>         pub struct Refcount<R: Integer, T> {
>                             // ^^^^^^^ not found in this scope
>                             // note: trait `crate::atomic::Integer` exists but is inaccessible
>             refcount: Atomic<R>,
>             data: UnsafeCell<T>,
>         }
> 
> I think that we can start with approach 2 and if we find a use-case
> where generics are really unavoidable, we can either put it in the same
> module as `Atomic<T>`, or change the access of `Integer`.
> 

What's the issue of having AtomicI32 and AtomicI64 first then? We don't
need to do 1 or 2 until the real users show up.

And I'd like also to point out that there are a few more trait bound
designs needed for Atomic<T>, for example, Atomic<u32> and Atomic<i32>
have different sets of API (no inc_unless_negative() for u32).

Don't make me wrong, I have no doubt we can handle this in the type
system, but given the design work need, won't it make sense that we take
baby steps on this? We can first introduce AtomicI32 and AtomicI64 which
already have real users, and then if there are some values of generic
atomics, we introduce them and have proper discussion on design.

To me, it's perfectly fine that Atomic{I32,I64} co-exist with Atomic<T>.
What's the downside? A bit specific example would help me understand
the real concern here.


Regards,
Boqun

> ---
> Cheers,
> Benno
> 
> > The point I'm trying to make here is: when you are using atomics, you
> > care about performance a lot (otherwise, why don't you use a lock?), and
> > because of that, you should care about the size of the atomics, because
> > it may affect the performance significantly.
> 

