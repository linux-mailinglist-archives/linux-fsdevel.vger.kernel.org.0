Return-Path: <linux-fsdevel+bounces-72972-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FBB6D06CB1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 09 Jan 2026 03:09:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 22E483012EA0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jan 2026 02:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A4E265620;
	Fri,  9 Jan 2026 02:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ovo2tZCR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C892254AF5;
	Fri,  9 Jan 2026 02:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767924577; cv=none; b=mnT8QFxjL/y4SpNtuOPoOcefRldTIegkD0rGAWytBTeKVdE9z8a4rZDfcxmlA6tGuBVdhc46RocY1twBh2py6qdamr10s+5kZnfaWgG/5yrGhwrYDTw6VOi/TnVoeKl+cQmOs/hxL7QcsYKjxVUC1k4FcdHmjFJGF9vmknA+O8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767924577; c=relaxed/simple;
	bh=S1EsGIjlfm3p3j/nKYkRHeLihDC3e818J3qnfAaeTtM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ArcEUWCLPDMtFwGshf7TTMWWd8rZRPzLw43wGbzJtBzRqP4DhdfVizuf4EnZB5XPfMSin/2tP29NM5z8svsmiXu60f/VrEagvs4ajzd69GEWdKr7aUNiBn3c763IJjX6VK8P13cqtvz7owyIdWj2k8odiv6zqmyPB5AMxTF0KdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ovo2tZCR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EB2EC116C6;
	Fri,  9 Jan 2026 02:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767924577;
	bh=S1EsGIjlfm3p3j/nKYkRHeLihDC3e818J3qnfAaeTtM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=Ovo2tZCR8FmJEfGkuXvQeEtYkOwTm/1Q13GyjAfohFh/gMy7vHBC7iGHTwCiV48xN
	 m0mE1syaEMppjZ01qcMOiCRr8Vify8P45NQoDCmRdTcJtPybMhGEPRS0cOce+YuQRL
	 L3CJfxn24fpr6DN+8cy5nZVFsFXlCdGs7u98n2ZaEQTxhBYu07sc7JKeBi4a4gpq3p
	 dQTSn29NTUueYdiuQpJX3QyXEe5/uJkJPDWtqRGMx4OgJoXCq/uVtzwPeIxOycwr8X
	 NiDEcWuu4uC3pO/AMNyXPYdKaqUKz36KRqyprcY0UUAvGPV30PLYMKF6AazvHMVV+s
	 1mwJH05YP+jmg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 9E3ECCE1690; Thu,  8 Jan 2026 18:09:36 -0800 (PST)
Date: Thu, 8 Jan 2026 18:09:36 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Marco Elver <elver@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Gary Guo <gary@garyguo.net>,
	Will Deacon <will@kernel.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>,
	Magnus Lindholm <linmag7@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Lyude Paul <lyude@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	kasan-dev@googlegroups.com
Subject: Re: [PATCH 0/5] Add READ_ONCE and WRITE_ONCE to Rust
Message-ID: <b0f3b2a6-e69c-4718-9f05-607b8c02d745@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20251231-rwonce-v1-0-702a10b85278@google.com>
 <20251231151216.23446b64.gary@garyguo.net>
 <aVXFk0L-FegoVJpC@google.com>
 <OFUIwAYmy6idQxDq-A3A_s2zDlhfKE9JmkSgcK40K8okU1OE_noL1rN6nUZD03AX6ixo4Xgfhi5C4XLl5RJlfA==@protonmail.internalid>
 <aVXKP8vQ6uAxtazT@tardis-2.local>
 <87fr8ij4le.fsf@t14s.mail-host-address-is-not-set>
 <aV0JkZdrZn97-d7d@tardis-2.local>
 <20260106145622.GB3707837@noisy.programming.kicks-ass.net>
 <7fa2c07e-acf9-4f9a-b056-4d4254ea61e5@paulmck-laptop>
 <CANpmjNPdnuCNTfo=q5VPxAfdvpeAt8DhesQu0jy+9ZpH3DcUnQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNPdnuCNTfo=q5VPxAfdvpeAt8DhesQu0jy+9ZpH3DcUnQ@mail.gmail.com>

On Tue, Jan 06, 2026 at 08:28:41PM +0100, Marco Elver wrote:
> On Tue, 6 Jan 2026 at 19:18, 'Paul E. McKenney' via kasan-dev
> <kasan-dev@googlegroups.com> wrote:
> > On Tue, Jan 06, 2026 at 03:56:22PM +0100, Peter Zijlstra wrote:
> > > On Tue, Jan 06, 2026 at 09:09:37PM +0800, Boqun Feng wrote:
> > >
> > > > Some C code believes a plain write to a properly aligned location is
> > > > atomic (see KCSAN_ASSUME_PLAIN_WRITES_ATOMIC, and no, this doesn't mean
> > > > it's recommended to assume such), and I guess that's the case for
> > > > hrtimer, if it's not much a trouble you can replace the plain write with
> > > > WRITE_ONCE() on C side ;-)
> > >
> > > GCC used to provide this guarantee, some of the older code was written
> > > on that. GCC no longer provides that guarantee (there are known cases
> > > where it breaks and all that) and newer code should not rely on this.
> > >
> > > All such places *SHOULD* be updated to use READ_ONCE/WRITE_ONCE.
> >
> > Agreed!
> >
> > In that vein, any objections to the patch shown below?
> 
> I'd be in favor, as that's what we did in the very initial version of
> KCSAN (we started strict and then loosened things up).
> 
> However, the fallout will be even more perceived "noise", despite
> being legitimate data races. These config knobs were added after much
> discussion in 2019/2020, somewhere around this discussion (I think
> that's the one that spawned KCSAN_REPORT_VALUE_CHANGE_ONLY, can't find
> the source for KCSAN_ASSUME_PLAIN_WRITES_ATOMIC):
> https://lore.kernel.org/all/CAHk-=wgu-QXU83ai4XBnh7JJUo2NBW41XhLWf=7wrydR4=ZP0g@mail.gmail.com/

Fair point!

> While the situation has gotten better since 2020, we still have latent
> data races that need some thought (given papering over things blindly
> with *ONCE is not right either). My recommendation these days is to
> just set CONFIG_KCSAN_STRICT=y for those who care (although I'd wish
> everyone cared the same amount :-)).
> 
> Should you feel the below change is appropriate for 2026, feel free to
> carry it (consider this my Ack).
> 
> However, I wasn't thinking of tightening the screws until the current
> set of known data races has gotten to a manageable amount (say below
> 50)
> https://syzkaller.appspot.com/upstream?manager=ci2-upstream-kcsan-gce
> Then again, on syzbot the config can remain unchanged.

Is there an easy way to map from a report to the SHA-1 that the
corresponding test ran against?  Probably me being blind, but I am not
seeing it.  Though I do very much like the symbolic names in those
stack traces!

							Thanx, Paul

> Thanks,
> -- Marco
> 
> >                                                         Thanx, Paul
> >
> > ------------------------------------------------------------------------
> >
> > diff --git a/lib/Kconfig.kcsan b/lib/Kconfig.kcsan
> > index 4ce4b0c0109cb..e827e24ab5d42 100644
> > --- a/lib/Kconfig.kcsan
> > +++ b/lib/Kconfig.kcsan
> > @@ -199,7 +199,7 @@ config KCSAN_WEAK_MEMORY
> >
> >  config KCSAN_REPORT_VALUE_CHANGE_ONLY
> >         bool "Only report races where watcher observed a data value change"
> > -       default y
> > +       default n
> >         depends on !KCSAN_STRICT
> >         help
> >           If enabled and a conflicting write is observed via a watchpoint, but
> > @@ -208,7 +208,7 @@ config KCSAN_REPORT_VALUE_CHANGE_ONLY
> >
> >  config KCSAN_ASSUME_PLAIN_WRITES_ATOMIC
> >         bool "Assume that plain aligned writes up to word size are atomic"
> > -       default y
> > +       default n
> >         depends on !KCSAN_STRICT
> >         help
> >           Assume that plain aligned writes up to word size are atomic by
> >

