Return-Path: <linux-fsdevel+bounces-37370-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF849F175E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 21:29:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51E6F188B175
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 20:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3841922F5;
	Fri, 13 Dec 2024 20:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MtgjQxZH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38A918C002;
	Fri, 13 Dec 2024 20:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734121731; cv=none; b=pOALEcRHXVTSWeilK+6B2ukiJ/YXUfm46G3eW7zZUSeZkFjoeavz/GgmDnoE+yCzPdB5zYqdaHsepS5IZ0WnBoBwqaFCD82ieOCYS500vsV4MwSi5t0Aav/wcUI4YTrhI9+OvbY5Al/0f+pjKPR/jdLlJ9gjURlCodQzkqQ5ugA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734121731; c=relaxed/simple;
	bh=5bn8oXNQA2053l7zQok4dmxpsp3aILhYx8v20d7OHts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bmnY5jyWKrhPsbc/tErS6mlCVHIjjzosb7zP6IGLZa7Btb2ECqwmyUsqnlH7hdkV9U4Rieh6IGUt0qYylsMlAJONPtBvd69rECF+ZA+8wf10KE9ZuUk7Q3+QnvCbRUVTdWHWLrP8nzF9fr9SS/7mUOM8UWedXEK2QcmHAXSIkaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MtgjQxZH; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-467a1ee7ff2so14562101cf.0;
        Fri, 13 Dec 2024 12:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734121729; x=1734726529; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oy+g6CCR8H9z+qQ9IKAP5iLictR2vzTnBiPMNSCfde4=;
        b=MtgjQxZHzxg9rWflg3Btj+Un26/j+wxaShGxKMA7AiG23Peeq+oH4hxuramJZsnvoC
         kLVF9DHop9wkujR+xKdFMFbtIjadaeBRJLbLm3dUHuQWhtn0QZyJvtTNJ7vUQACv63dj
         03vAsbfqfAf7u4j2wqsk61LuVp+tG/OPJb9XRDLPMZ9rBVI9VFP+fNBVbSIcUYQsjhIX
         C2yle+ui5YPn6p/sodBxnLzkR9xvgKY4b+FASQ6H6xwr9p8axFS35incwBFNUm/6TvBW
         SWrik3/XFHqMy1Cl9NL38dVu9ElABFKAi1cd7DSEDj9e8oug/D+7ONOY84gTX04DpFv7
         pXLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734121729; x=1734726529;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oy+g6CCR8H9z+qQ9IKAP5iLictR2vzTnBiPMNSCfde4=;
        b=tbkWlBF1XJw7kDQbLbqFwuDcFrx/sua6dcetkjZW5kWkHlzmg+3v16zRdFAmfP63js
         keDzaVrrKnNo+O4ykJXTh3mG/Z4kbG8HxjcT/djO642O3oYUqgxTqoGpr4c2AjdZ4fQw
         OcXvhU9Gzc377BlMGE10jE2bb1ikLLS9X/zw0jTTHNe9jgm2G3M7I/BVyNBc04wtkCpz
         XhPhy46gJhyK1E2I3TvVqvNZNFuhbWUNpE5D9uxtwiCGL7dyLFO+NI8pjIYMzXEXPNze
         dl8DONnvh0Hn1MmhpJxF8UHIqOy/4+2tC0nMFIlrASkCBDodsTLEsnypJJWaH9Kxe2kz
         6JeA==
X-Forwarded-Encrypted: i=1; AJvYcCUqLBRDLPhffOFojkuxzmTEeR1TnxxpMBCadcnJLAQ7DgP/D2wb9V8nbTKyyOCr9fhyYt++@vger.kernel.org, AJvYcCUvG+zzN5sqW2zAHOb70GMJjqHul6mUBwBlhvUK+OAkbSMQUi2CU56IxoFKxZqkIaCGD9qGByJiBxAYBbO1@vger.kernel.org, AJvYcCVRUZwv7XH4bS69CpC0iC/Agf/J6wTrpm0xE7W2ra5yh72oSbax/np9LZVqZ5Lfcj7DL75H4C5k7+nboBeQCg==@vger.kernel.org, AJvYcCXTDrGsXZMVjWs1Q/FDf+p8m453qmMSp3gsxIxaECX7aovOayf9FNkhbA0qZev4R0eJPPCXHzG1N8qt@vger.kernel.org
X-Gm-Message-State: AOJu0YwOZuRfXijkG6n7oIywXvaLpmbnNiUmAFi/+AQoRPP0iOyebgdk
	2gjWk+b8REPdEBmju4OD7Wlgsz2x4w2ZCuvWO8mwA0DU458LyL55
X-Gm-Gg: ASbGncvvBpY81RTzGOxI6/q4KbnBOUjJ06n//BytL461/8rn0TqUQxgJMB3pMmu829V
	F/0cOA0kybb1+lNfKtSbXTEVl+UjcHX/iuz2WsRWbBH94d94fl3+j0ueuf0Cpwe9Wm6y7qSBOJg
	XTLj3+gQAMjKicixg5T6ueJSqPKyPMK2sTscpknVJ7HsuaQTwbEHLY7fkOv38QUiqE3e7Cv3aLj
	ayXBkecq/68vD44XBVa+u1L0FPVmDlUWylByhWPJby9nqo9y45X7fdDpkDTKsOGqiyMgsaLDh98
	Fn7RdY8VM8U3IvKh8uXes8+iWLrdHjNZNmncNZc9pIdbRV4=
X-Google-Smtp-Source: AGHT+IE+typyqa+c+sehJ31gByo0JHXafJZohfOiskIhz13g3nXxbmg6ccM58eE7yA0wkS9fbfPtVQ==
X-Received: by 2002:a05:622a:11d5:b0:467:6508:2385 with SMTP id d75a77b69052e-467a5829f17mr76237551cf.34.1734121728767;
        Fri, 13 Dec 2024 12:28:48 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-467b2cc278dsm1297491cf.48.2024.12.13.12.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 12:28:48 -0800 (PST)
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfauth.phl.internal (Postfix) with ESMTP id B8C611200066;
	Fri, 13 Dec 2024 15:28:47 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Fri, 13 Dec 2024 15:28:47 -0500
X-ME-Sender: <xms:_5hcZ52D0Txfq3afYHx_FbgTtmEk_XFYGdsCxZrFemGViQYgimNBIw>
    <xme:_5hcZwE0JuQpAx-sNtF1T4lNVXCTxpu8QQK39LNMwvRar7kPxKYKGILxZCLuwVeiw
    JqiJqyI3iHFHYZ3VA>
X-ME-Received: <xmr:_5hcZ55iST0Ld5UtgJO19PFmYPPES1IEZQ5fvzsB0A8k-EhTnaQH_VgICyoU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkeejgddufeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrd
    gtohhmqeenucggtffrrghtthgvrhhnpefftdeihfeigedtvdeuueffieetvedtgeejuefh
    hffgudfgfeeggfeftdeigeehvdenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdo
    mhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejke
    ehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgr
    mhgvpdhnsggprhgtphhtthhopeehjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    eprghlihgtvghrhihhlhesghhoohhglhgvrdgtohhmpdhrtghpthhtoheprhhushhtqdhf
    ohhrqdhlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhgtuh
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgv
    lhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgrrhgthh
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehllhhvmheslhhishhtshdr
    lhhinhhugidruggvvhdprhgtphhtthhopehlkhhmmheslhhishhtshdrlhhinhhugidrug
    gvvhdprhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegr
    lhgvgidrghgrhihnohhrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:_5hcZ21dZDlSFPHhJ-hR_xqZ1E0rep-r4WrXiwUQyM1nizooQS9AnA>
    <xmx:_5hcZ8F5a37Iksgu8azbe4LtJh86oPlDtiIZrtuMnU4PwfLQHgkdaA>
    <xmx:_5hcZ3_Z-H-jUwynNjV6TS1Q48CIKGofI_-xcmhDLwS-hAy2MJ1wxA>
    <xmx:_5hcZ5lGDiaKlmxar7Ng2QGY3xkyj4bsqNu3LdLxBbywFujFVq5mLg>
    <xmx:_5hcZwFSPtMAKsGOW-8Vmvi_oCQ7KHZB-ZN7yeYoB03uVjiO-lIrMZ-I>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Dec 2024 15:28:45 -0500 (EST)
Date: Fri, 13 Dec 2024 12:28:45 -0800
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
Subject: Re: [RFC v2 02/13] rust: sync: Add basic atomic operation mapping
 framework
Message-ID: <Z1yY_Yr0B6KpWLmJ@tardis.local>
References: <20241101060237.1185533-1-boqun.feng@gmail.com>
 <20241101060237.1185533-3-boqun.feng@gmail.com>
 <CAH5fLghYjcb-mpR_rr2aC_W8rRb6g8jCFxgky7iEqVgmpHjf=Q@mail.gmail.com>
 <Z1sYNOYJPzQmJXn6@boqun-archlinux>
 <CAH5fLgidmY7FtKLKR-Yxb6U-mQvsyatGRToqSHHRACfTdiAtUA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH5fLgidmY7FtKLKR-Yxb6U-mQvsyatGRToqSHHRACfTdiAtUA@mail.gmail.com>

On Fri, Dec 13, 2024 at 03:37:13PM +0100, Alice Ryhl wrote:
[...]
> > > > @@ -0,0 +1,19 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +
> > > > +//! Atomic primitives.
> > > > +//!
> > > > +//! These primitives have the same semantics as their C counterparts: and the precise definitions of
> > > > +//! semantics can be found at [`LKMM`]. Note that Linux Kernel Memory (Consistency) Model is the
> > > > +//! only model for Rust code in kernel, and Rust's own atomics should be avoided.
> > > > +//!
> > > > +//! # Data races
> > > > +//!
> > > > +//! [`LKMM`] atomics have different rules regarding data races:
> > > > +//!
> > > > +//! - A normal read doesn't data-race with an atomic read.
> > >
> > > This was fixed:
> > > https://github.com/rust-lang/rust/pull/128778
> > >
> >
> > Yeah, I was aware of that effort, and good to know it's finally merged.
> > Thanks!
> >
> > This will be in 1.83, right? If so, we will still need the above until
> > we bump up the minimal rustc version to 1.83 or beyond. I will handle
> > this properly with the minimal rustc 1.83 (i.e. if this goes in first,
> > will send a follow up patch). I will also mention in the above that this
> > has been changed in 1.83.
> >
> > This also reminds that I should add that LKMM allows mixed-size atomic
> > accesses (as non data race), I will add that in the version.
> 
> This is just documentation. I don't think you need to do any special

The PR also contained miri changes, so the same code will be reported
differently by miri. That was what I was thinking of. However, now think
about it, we are not going to use Rust atomics, so this difference
shouldn't affect us. Therefore I agree, I will drop this.

> MSRV handling.
> 
> > > > +mod private {
> > > > +    /// Sealed trait marker to disable customized impls on atomic implementation traits.
> > > > +    pub trait Sealed {}
> > > > +}
> > >
> > > Just make the trait unsafe?
> > >
> >
> > And make the safety requirement of `AtomicImpl` something like:
> >
> >     The type must have the implementation for atomic operations.
> >
> > ? Hmm.. I don't think that's a good safety requirement TBH. Actually the
> > reason that we need to restrict `AtomicImpl` types is more of an
> > iplementation issue (the implementation need to be done if we want to
> > support i8 or i16) rather than safety issue. So a sealed trait is proper
> > here. Does this make sense? Or am I missing something?
> 
> Where is the AtomicImpl trait used?
> 

It's used when `impl`ing an `AllowAtomic` type, `AllowAtomic` has an
associate type named `Repr` which must be an `AtomicImpl`, i.e. each
type that has atomic operation support must select the underlying
implementation types (currently we only have i32 and i64 from C side
APIs). Using a sealed trait is appropriate in this case, because unless
you are adding atomic support for different sizes of data, you shouldn't
impl `AtomicImpl`.

Regards,
Boqun

> Alice

