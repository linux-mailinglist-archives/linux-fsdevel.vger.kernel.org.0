Return-Path: <linux-fsdevel+bounces-37368-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 452F59F1748
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 21:13:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F5821615DB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 20:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1681019068E;
	Fri, 13 Dec 2024 20:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E3G4Io0m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD71A18C928;
	Fri, 13 Dec 2024 20:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734120793; cv=none; b=hW/rcMZqRosPKVrIm9DeSiiFg9z/96KyimScXhYsmpB5QRC9rzE217/CxNVpstt668AoZb5tIxdWvajXPhDBKE79ieu9djgPqdIJkCWmzFB9Q3T6CD4EkxwZgzGdYe4lXxdctxU6P+5iWQMRxkylgEO86cXsY9jgtIAbbY4DANY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734120793; c=relaxed/simple;
	bh=zlbBlFFmJXawofXO/orsUEwh6fcY+2EkTgzbeKXf6Hw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S4Tcg1mAAYu6IkeMkgFu+E4W5rY+B1715Um9zk8pCRBczWfnENWMASyLKdeqtz/4PKABX9sYRf/48k7lhReNyxmyRjP4ZxJUTyOtsaCuKwMD31zeUXGtJPkSunt+nnja+iGHigiSPre3rQgqdIu6lJ1zzO+SuRmf0TRjv5eTm4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E3G4Io0m; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7b6e24aa0dbso164532185a.1;
        Fri, 13 Dec 2024 12:13:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734120790; x=1734725590; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iRonZJxea5tra4fNXdRilKepTreMvxGV66B9FX5uzo8=;
        b=E3G4Io0mN4kbxokdXJGbREIYMcarmu4J2jLute8s4j8CJZUi9iVzl/AAHs34xGfhI/
         jzmvpVti0HyNK2NAWSBDdvCsLFL2GIkOf5wL8t7Z/AAOFci/Ia2egVi3voi00uHCRcf/
         lR+AzSoiaUHph+flEpEida74XE2pKrEoN4pDuW5HXkNm0nAaksBDG5IltoAMfD2O47e7
         7aJ1k3KPy3WWx0C9QiLCua9DmndWbZnDJshrD6f7O8xQloiJSB4+EMFwdyBe8a8zgyPF
         G0rVBzWdlwKwkrjWNu4urKB/fv9Qp7NejNVPL0BJFjk7mSnkr+jWIoVRU5u/v7PRnDWk
         u7jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734120790; x=1734725590;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iRonZJxea5tra4fNXdRilKepTreMvxGV66B9FX5uzo8=;
        b=snr/UMn0jK4GDOBaTwJIZ8mJqb80+z4Fim09OE68c0npHCLTVb/e0SUEHbgSGvPckN
         6GtnmMd5Hi+CjenHSO7IXw3lxZRRVlsj02cJSYndt78WYA3SmPJEO6HMdZnxElpmkN/g
         P7wm6JhbNCMmiDrHpxFy+nIHGgbtQCud7L8IwQsq/vnzwmkPkIq7MbUIeVOZenCmd5Nc
         9+jAKA8kzdasKih8HTEVVH27aQbgvP6v7vExBQxqVoECoh4OCEiLCNTXD8ojA/zg0GUA
         a7uCiVq++vnl+FnxQNn+Ezq99bU2kRwdBCWKxVW767dhvB0uri7PXCJ5XzKZjF7s9xY0
         V2+g==
X-Forwarded-Encrypted: i=1; AJvYcCU4MVytM+RBVQ4WD4wkdXeL2z1tOGXwM7jtHe1QELMmgYxtP7lT1kbKsN4WhlHW/chzSWPo8+zdQY933bHE@vger.kernel.org, AJvYcCVK9NqF3wS+fCEvdHBm1flsgzt6NwIqMP1CC7IrANUfZHsx/LKMsV1PIT6vNJjZQsWx7ooAQTNZizOAELvggw==@vger.kernel.org, AJvYcCVz0dPQvm5vIuj7pc3XEdo1wSYpNOEVwWEek9DI1es6Y6tNyLPcqgXLr89/02+OIUdEWJjW@vger.kernel.org, AJvYcCWG/Az1Ad9GVvnBm5H0hEDC0eww0id2FeBZ8TZdPGqYqPO9GJUZDZdjYsarIYb33BxDz3XOegrFmIa7@vger.kernel.org
X-Gm-Message-State: AOJu0YywTPSfWuJCMNxB3k+vjmkmUJHYJ+J5Qdh1ouc2u0XFakql0Amj
	i3VO0dgc9nREvF9xWo5hnAkMiUmqQroyFuQcZ7pNYd5VDuWdS3FSlNVTxA==
X-Gm-Gg: ASbGnctbsRjXM2dZ1yPVPgOkcBDovxOx5P1ywgP/VYIml2bfwyKcOjqMkODqRv+F/q2
	szwcK0L1MJbjcm+8714Uxscw4PLmadvbhU+ZBRX81U3E02AVcsT8qdTQ8mmcgXWITm79SqhHa47
	M/bxyRWjo8pstxV98qafq8xBZggLCkirGSyO9itSIf+upSt/RMAetK2neNqW4SVZuQAlfCI8rCn
	R6LKc9HJ8GcJ+gRtRl+XCBleOGLrFfJQfNchgihhInUvCGkBrIMKxvA2eLGmVPWqvt3SsRoXjKI
	AuKyaJFarqhlrfeqpirO6klbFoVbCb63WomUATsx/UgM7LU=
X-Google-Smtp-Source: AGHT+IEBWHf4XTEy2MD84YewAXauMsR7xN9Mi94snkVedBERT43cN1RkEYeGpEagZImPtqz7R0x/qg==
X-Received: by 2002:a05:620a:6083:b0:7b6:d34e:b21a with SMTP id af79cd13be357-7b6fbf1aab1mr750908185a.37.1734120790487;
        Fri, 13 Dec 2024 12:13:10 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b7047f3f5dsm10759385a.66.2024.12.13.12.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 12:13:10 -0800 (PST)
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id 73AE9120006A;
	Fri, 13 Dec 2024 15:13:09 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 13 Dec 2024 15:13:09 -0500
X-ME-Sender: <xms:VZVcZ2qm-gu0s5limXzj9CZtxmfXx-mAmK6XnJfcqZqIlz2H7Jg3Lg>
    <xme:VZVcZ0oz6uhXAI5mxSKLN9h20-Upxd-X6g00btvJxS-QjAmx4cL7LNMaXQOfaSIp6
    Wps8lgGWLSKs9fybw>
X-ME-Received: <xmr:VZVcZ7OqZAG8r-rJe68lZBczKBXcFOthWJt97mY426ybeMQERtCYzdJIEMD3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkeejgddufedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdej
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhepvefghfeuveekudetgfevudeuudejfeeltdfh
    gfehgeekkeeigfdukefhgfegleefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghl
    ihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepgh
    hmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopeehjedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtoheprghlihgtvghrhihhlhesghhoohhglhgvrd
    gtohhmpdhrtghpthhtoheprhhushhtqdhfohhrqdhlihhnuhigsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheprhgtuhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehlihhnuhigqdgrrhgthhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehllhhvmheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehl
    khhmmheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehojhgvuggrsehkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopegrlhgvgidrghgrhihnohhrsehgmhgrihhlrdgt
    ohhm
X-ME-Proxy: <xmx:VZVcZ17sIOWSp0-LnbL-fy2QYuFdSefH1z64bjLq5i0dlHHmLM4ABw>
    <xmx:VZVcZ17cTMpI_xHOYGh92J2TPP7xAIvXKWEVuYhNw1ypPrtkJoMSIQ>
    <xmx:VZVcZ1jkRFzWZAWC-Ye4VlQO89TxiV19LoR25aIcLJrsS0YavTcA9Q>
    <xmx:VZVcZ_7aOXLCRagx9UfKTR-SJr85felqwQWrfbxdholKhOG_rXSiXA>
    <xmx:VZVcZwI_O8zWb7p8jSNmkNTjjYElFeZR68mnl6uDR6jLfCN-yWQAj0yk>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Dec 2024 15:13:07 -0500 (EST)
Date: Fri, 13 Dec 2024 12:13:06 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: rust-for-linux@vger.kernel.org, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	llvm@lists.linux.dev, lkmm@lists.linux.dev,
	Miguel Ojeda <ojeda@kernel.org>,	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
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
 Trevor Gross <tmgross@umich.edu>,	dakr@redhat.com,
 Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,	Albert Ou <aou@eecs.berkeley.edu>,
 linux-riscv@lists.infradead.org
Subject: Re: [RFC v2 04/13] rust: sync: atomic: Add generic atomics
Message-ID: <Z1yVUmGBIxKH1xR-@tardis.local>
References: <20241101060237.1185533-1-boqun.feng@gmail.com>
 <20241101060237.1185533-5-boqun.feng@gmail.com>
 <CAH5fLgjhQouU=kqVx7LET2yeWt6sKt-VO5PR5SnQ8doaG4ihuQ@mail.gmail.com>
 <Z1seogLmy5H8-hXn@boqun-archlinux>
 <CAH5fLgjGg8_s8imOkmPb0yLAMwD1sF1aoBZWkAy-YLNh41zCuw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLgjGg8_s8imOkmPb0yLAMwD1sF1aoBZWkAy-YLNh41zCuw@mail.gmail.com>

On Fri, Dec 13, 2024 at 03:32:47PM +0100, Alice Ryhl wrote:
> On Thu, Dec 12, 2024 at 6:34 PM Boqun Feng <boqun.feng@gmail.com> wrote:
> >
> > On Thu, Dec 12, 2024 at 11:57:07AM +0100, Alice Ryhl wrote:
> > [...]
> > > > diff --git a/rust/kernel/sync/atomic/generic.rs b/rust/kernel/sync/atomic/generic.rs
> > > > new file mode 100644
> > > > index 000000000000..204da38e2691
> > > > --- /dev/null
> > > > +++ b/rust/kernel/sync/atomic/generic.rs
> > > > @@ -0,0 +1,253 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +
> > > > +//! Generic atomic primitives.
> > > > +
> > > > +use super::ops::*;
> > > > +use super::ordering::*;
> > > > +use crate::types::Opaque;
> > > > +
> > > > +/// A generic atomic variable.
> > > > +///
> > > > +/// `T` must impl [`AllowAtomic`], that is, an [`AtomicImpl`] has to be chosen.
> > > > +///
> > > > +/// # Invariants
> > > > +///
> > > > +/// Doing an atomic operation while holding a reference of [`Self`] won't cause a data race, this
> > > > +/// is guaranteed by the safety requirement of [`Self::from_ptr`] and the extra safety requirement
> > > > +/// of the usage on pointers returned by [`Self::as_ptr`].
> > > > +#[repr(transparent)]
> > > > +pub struct Atomic<T: AllowAtomic>(Opaque<T>);
> > > > +
> > > > +// SAFETY: `Atomic<T>` is safe to share among execution contexts because all accesses are atomic.
> > > > +unsafe impl<T: AllowAtomic> Sync for Atomic<T> {}
> > >
> > > Surely it should also be Send?
> > >
> >
> > It's `Send` here because `Opaque<T>` is `Send` when `T` is `Send`. And
> > in patch #9, I changed the definition of `AllowAtomic`, which is not a
> > subtrait of `Send` anymore, and an `impl Send` block was added there.
> >
> > > > +/// Atomics that support basic atomic operations.
> > > > +///
> > > > +/// TODO: Unless the `impl` is a `#[repr(transparet)]` new type of an existing [`AllowAtomic`], the
> > > > +/// impl block should be only done in atomic mod. And currently only basic integer types can
> > > > +/// implement this trait in atomic mod.
> > >
> > > What's up with this TODO? Can't you just write an appropriate safety
> > > requirement?
> > >
> >
> > Because the limited scope of types that allows atomic is an artificial
> > choice, i.e. we want to start with a limited number of types and make
> > forward progress, and the types that we don't want to support atomics
> > for now are not because of safety reasons, but more of a lack of
> > users/motivations. So I don't think this is something we should use
> > safety requirement to describe.
> 
> I found the wording very confusing. Could you reword it to say
> something about future possibilities?
> 

Sure, how about:

/// TODO: Currently the [`AllowAtomic`] types are restricted within
/// basic integer types (and their transparent new types). In the
/// future, we could extend the scope to more data types when there is a
/// clear and meaningful usage, but for now, [`AllowAtomic`] should only
/// be implemented inside atomic mod for the restricted types mentioned
/// above.

?

> > > > +/// # Safety
> > > > +///
> > > > +/// [`Self`] must have the same size and alignment as [`Self::Repr`].
> > > > +pub unsafe trait AllowAtomic: Sized + Send + Copy {
> > > > +    /// The backing atomic implementation type.
> > > > +    type Repr: AtomicImpl;
> > > > +
> > > > +    /// Converts into a [`Self::Repr`].
> > > > +    fn into_repr(self) -> Self::Repr;
> > > > +
> > > > +    /// Converts from a [`Self::Repr`].
> > > > +    fn from_repr(repr: Self::Repr) -> Self;
> > >
> > > What do you need these methods for?
> > >
> >
> > Converting a `AtomicImpl` value (currently only `i32` and `i64`) to a
> > `AllowAtomic` value without using transmute in `impl` block of
> > `Atomic<T>`. Any better idea?
> 
> You could use transmute?
> 

In a draft version, I did use transmute, but Benno commented that he
wanted to avoid arbitrary transmute as hard as possible (if I didn't
misunderstand him). Hence these two functions are provided. Now think
about it, I don't think doing either way (transmute or *_repr()
function) would affect most of users, since most of users won't need to 
impl `AllowAtomic` themselves, therefore I think keeping it as it is is
fine. Do you have any user observable concern of defining these
functions?

Regards,
Boqun

> Alice

