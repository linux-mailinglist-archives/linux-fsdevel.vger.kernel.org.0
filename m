Return-Path: <linux-fsdevel+bounces-37315-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C249F0F55
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 15:37:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 377B01884B36
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 14:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3231E1A14;
	Fri, 13 Dec 2024 14:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PfOFw51S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310601E0E08
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2024 14:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734100649; cv=none; b=JdYN5YXi+P3+9deYcEcjP7ECFcjTSAkpksbZhL0T89yn2ugKdM9w16THNKLRVdUdpYkmXxczkkNsdB/O+mG7p9SBEm00OnvZ0gR/AiVr1EwLz/Pl3Fg8t8Qi6bp+mQjh5BvGngQhTEtn0seVHr+3uFZhAygxsQNDfnN/tEF+XZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734100649; c=relaxed/simple;
	bh=cSE7YfpxLSVqgzR60SozadvYSPlf/zv5LQnl9qv4L1k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JQibWeLNmDaGeeKsyc4hcp6BXqdAo4uJqYvJu42kxbsx8hrF4l66dH4dkZoL4/uGZ8vCM2Kh1W5kUVUv2RHNFtXBYUNNVCUhndxb9LpxM/gU6ESCuCZyeCL9DoDDrBMH2Q9V0fB4zMv9RtKTAgliJf3Mah5fTufx/ptLL+EskOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PfOFw51S; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43625c4a50dso12453245e9.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2024 06:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734100645; x=1734705445; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2GEPFVvt/WcPx7hwmrvPddq2GA3SILVOBgchd5bamcM=;
        b=PfOFw51Sc6+iHmr4t7p92tJRccDwESqAyiHjn8XOfpSW8u0+dEeagmIhd8ycLxIZrt
         CZgNE5rE74B6NCA73ubjF2qTPu5tE3eZClthiamwwwooFKoornNfDxl7c+E6MSxTPnrz
         q5ySVQ9F9dGKl0ehQbxaNxH5lUjCV1PMj3CMIbz0KKDqC87gg19s7BsnlYjUv0yyamS9
         NHonNwe68la396ZNorewQ0ctILQ5T9ZAdppFp/OljKJav2W4c143NmBSsziJIumfjofI
         X1731XrUj0boIqgFoA5m2nPVsh9yFu4sIayC3IK/ZYtBVu3op4hCDmhFWl3KFz/9Kbu7
         vohg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734100645; x=1734705445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2GEPFVvt/WcPx7hwmrvPddq2GA3SILVOBgchd5bamcM=;
        b=O1I2UdN450+O+aRwDIR4RDP0XGleBzbOySJn+h6Y0tZMAu20rNuyLTPWPHlBQZQt4a
         1oR4AG8zbD7VcQTbfWo9CXxpZMYWk+l0REjySlfpzfv4S+EVtI4Nfm0DWLcYxw1PAM+g
         Ay1Y2XdRTzgMV2oTSohxUah/L8Kl/AO1/J6W66Bo5znXv7HWBw0egZdrIFh6R46EyDAm
         KLis6PCDUjiEhQo7ku2LnWA35Mu8wmdeVtFxa95SflUFIcO+c38n/X5MsAq/ds0sbpXv
         e2PI0Wgcn8mCsZTDCamSeVvKDyIC8KKOm7SjMTtc302+Qpv3Y9N3V70tACsSequGhFvS
         L4MA==
X-Forwarded-Encrypted: i=1; AJvYcCVxIJTucgjTNhvl5s1jum5hNm2iUBXwIoewtKNmK6WjGpQOO8cmVvRp0tjT4JxUo3pd739cUix8hkPZV6vq@vger.kernel.org
X-Gm-Message-State: AOJu0Yza+Vquwn5W/uRDrK2wBAwEaE+lyNUSR/ogkthVvRRzPeXzXDQ8
	8BwyG8f92J98G3LXyRyIgqEDo+s8TuANc+7GhtYKpuNk5RP0m/Ikv8lfokiVFN5k8EBcW9Yz4cd
	e97gjZm25m55sKadojNZqMmnbrpD+43oEJOcb
X-Gm-Gg: ASbGnctOG2l3c5RipdXiW53pSx03hWBEFbBGsQ//dDVpWly4O6DCMn6ocScnK1oseI4
	rTsD09P6jpsqngrOIuhYf9t6dAI82/jZ8LWwY44Y=
X-Google-Smtp-Source: AGHT+IF5nz9iFwihOnmrHXThptEMDz6uAvc2eauPyTTcPdqXIp7ICHSubzS0ZSdBwH7W3Dcgfoy53emLLyY7/WPXocY=
X-Received: by 2002:a05:6000:154b:b0:385:f092:e00 with SMTP id
 ffacd0b85a97d-3889ad32da3mr2133093f8f.50.1734100645390; Fri, 13 Dec 2024
 06:37:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241101060237.1185533-1-boqun.feng@gmail.com>
 <20241101060237.1185533-3-boqun.feng@gmail.com> <CAH5fLghYjcb-mpR_rr2aC_W8rRb6g8jCFxgky7iEqVgmpHjf=Q@mail.gmail.com>
 <Z1sYNOYJPzQmJXn6@boqun-archlinux>
In-Reply-To: <Z1sYNOYJPzQmJXn6@boqun-archlinux>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 13 Dec 2024 15:37:13 +0100
Message-ID: <CAH5fLgidmY7FtKLKR-Yxb6U-mQvsyatGRToqSHHRACfTdiAtUA@mail.gmail.com>
Subject: Re: [RFC v2 02/13] rust: sync: Add basic atomic operation mapping framework
To: Boqun Feng <boqun.feng@gmail.com>
Cc: rust-for-linux@vger.kernel.org, rcu@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	llvm@lists.linux.dev, lkmm@lists.linux.dev, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alan Stern <stern@rowland.harvard.edu>, Andrea Parri <parri.andrea@gmail.com>, 
	Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, 
	Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Akira Yokosawa <akiyks@gmail.com>, 
	Daniel Lustig <dlustig@nvidia.com>, Joel Fernandes <joel@joelfernandes.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, kent.overstreet@gmail.com, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, elver@google.com, 
	Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Catalin Marinas <catalin.marinas@arm.com>, torvalds@linux-foundation.org, 
	linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
	Trevor Gross <tmgross@umich.edu>, dakr@redhat.com, 
	Frederic Weisbecker <frederic@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 6:07=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> On Thu, Dec 12, 2024 at 11:51:23AM +0100, Alice Ryhl wrote:
> > On Fri, Nov 1, 2024 at 7:03=E2=80=AFAM Boqun Feng <boqun.feng@gmail.com=
> wrote:
> > >
> > > Preparation for generic atomic implementation. To unify the
> > > ipmlementation of a generic method over `i32` and `i64`, the C side
> > > atomic methods need to be grouped so that in a generic method, they c=
an
> > > be referred as <type>::<method>, otherwise their parameters and retur=
n
> > > value are different between `i32` and `i64`, which would require usin=
g
> > > `transmute()` to unify the type into a `T`.
> > >
> > > Introduce `AtomicIpml` to represent a basic type in Rust that has the
> > > direct mapping to an atomic implementation from C. This trait is seal=
ed,
> > > and currently only `i32` and `i64` ipml this.
> >
> > There seems to be quite a few instances of "impl" spelled as "ipml" her=
e.
> >
>
> Will fix!
>
> > > Further, different methods are put into different `*Ops` trait groups=
,
> > > and this is for the future when smaller types like `i8`/`i16` are
> > > supported but only with a limited set of API (e.g. only set(), load()=
,
> > > xchg() and cmpxchg(), no add() or sub() etc).
> > >
> > > While the atomic mod is introduced, documentation is also added for
> > > memory models and data races.
> > >
> > > Also bump my role to the maintainer of ATOMIC INFRASTRUCTURE to refle=
ct
> > > my responsiblity on the Rust atomic mod.
> > >
> > > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> > > ---
> > >  MAINTAINERS                    |   4 +-
> > >  rust/kernel/sync.rs            |   1 +
> > >  rust/kernel/sync/atomic.rs     |  19 ++++
> > >  rust/kernel/sync/atomic/ops.rs | 199 +++++++++++++++++++++++++++++++=
++
> > >  4 files changed, 222 insertions(+), 1 deletion(-)
> > >  create mode 100644 rust/kernel/sync/atomic.rs
> > >  create mode 100644 rust/kernel/sync/atomic/ops.rs
> > >
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index b77f4495dcf4..e09471027a63 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -3635,7 +3635,7 @@ F:        drivers/input/touchscreen/atmel_mxt_t=
s.c
> > >  ATOMIC INFRASTRUCTURE
> > >  M:     Will Deacon <will@kernel.org>
> > >  M:     Peter Zijlstra <peterz@infradead.org>
> > > -R:     Boqun Feng <boqun.feng@gmail.com>
> > > +M:     Boqun Feng <boqun.feng@gmail.com>
> > >  R:     Mark Rutland <mark.rutland@arm.com>
> > >  L:     linux-kernel@vger.kernel.org
> > >  S:     Maintained
> > > @@ -3644,6 +3644,8 @@ F:        arch/*/include/asm/atomic*.h
> > >  F:     include/*/atomic*.h
> > >  F:     include/linux/refcount.h
> > >  F:     scripts/atomic/
> > > +F:     rust/kernel/sync/atomic.rs
> > > +F:     rust/kernel/sync/atomic/
> >
> > This is why mod.rs files are superior :)
> >
>
> ;-) Not going to do anything right now, but let me think about this.
>
> > > @@ -0,0 +1,19 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +
> > > +//! Atomic primitives.
> > > +//!
> > > +//! These primitives have the same semantics as their C counterparts=
: and the precise definitions of
> > > +//! semantics can be found at [`LKMM`]. Note that Linux Kernel Memor=
y (Consistency) Model is the
> > > +//! only model for Rust code in kernel, and Rust's own atomics shoul=
d be avoided.
> > > +//!
> > > +//! # Data races
> > > +//!
> > > +//! [`LKMM`] atomics have different rules regarding data races:
> > > +//!
> > > +//! - A normal read doesn't data-race with an atomic read.
> >
> > This was fixed:
> > https://github.com/rust-lang/rust/pull/128778
> >
>
> Yeah, I was aware of that effort, and good to know it's finally merged.
> Thanks!
>
> This will be in 1.83, right? If so, we will still need the above until
> we bump up the minimal rustc version to 1.83 or beyond. I will handle
> this properly with the minimal rustc 1.83 (i.e. if this goes in first,
> will send a follow up patch). I will also mention in the above that this
> has been changed in 1.83.
>
> This also reminds that I should add that LKMM allows mixed-size atomic
> accesses (as non data race), I will add that in the version.

This is just documentation. I don't think you need to do any special
MSRV handling.

> > > +mod private {
> > > +    /// Sealed trait marker to disable customized impls on atomic im=
plementation traits.
> > > +    pub trait Sealed {}
> > > +}
> >
> > Just make the trait unsafe?
> >
>
> And make the safety requirement of `AtomicImpl` something like:
>
>     The type must have the implementation for atomic operations.
>
> ? Hmm.. I don't think that's a good safety requirement TBH. Actually the
> reason that we need to restrict `AtomicImpl` types is more of an
> iplementation issue (the implementation need to be done if we want to
> support i8 or i16) rather than safety issue. So a sealed trait is proper
> here. Does this make sense? Or am I missing something?

Where is the AtomicImpl trait used?

Alice

