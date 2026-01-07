Return-Path: <linux-fsdevel+bounces-72686-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 04519CFFB06
	for <lists+linux-fsdevel@lfdr.de>; Wed, 07 Jan 2026 20:17:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 795B1301596C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jan 2026 19:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C6F8265CA8;
	Wed,  7 Jan 2026 19:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WT7SW+oW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2201DFDA1;
	Wed,  7 Jan 2026 19:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767813470; cv=none; b=DOtAeFFkY9x+f4DB6CIIEbleEGsuWtsY2y7ZMpyhuDm7iZQn0nEO9UijDmzebuuXtEpPHRai9kdEEEjgdXKpFr2JkcvtQl5EEd5F7hjw2mLMb5D49NDT9BhFYcYqQG3abLcX0/vEnOz6w/8JC2I2sMu9tIsUnUXQyGzaiaBR29w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767813470; c=relaxed/simple;
	bh=wpCUsEx/DAHll49wE1QSK9nxwuSDleQeOJqWpzlb4qE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YdnikVcexEvlULeH/g2cg/fEUgiT9HyMGipaxjeYQbONDDuiXdSewXmTeTY4ItDXkGf9yQINIqzkmQVqEl2cwnzFBDzsxTSvn2fNvTnpuSEfa83fXX8/AgFHI5QlVZJ8XR1CKlCQFCu3TTG0pbe8Yp+OS3cvx2PNAn8hRn5B3rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WT7SW+oW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71A9EC4CEF1;
	Wed,  7 Jan 2026 19:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767813469;
	bh=wpCUsEx/DAHll49wE1QSK9nxwuSDleQeOJqWpzlb4qE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=WT7SW+oWUw8i87keBl/9o7xZic/L29/iJY5sM9Id1OuuX5PJyeq/uc9ECaDB4/6lY
	 NbAWzGSGVcYtQTMpQEY+mpGZltDKXtX74HeL132Y/g79cFBclirgmZJy6159WyGeHZ
	 a/03BCqdmPa9RLfu4Dbjx9M808/OS1hEaDn1NGgMdiy1cQT6lL6BHJlt1tDbQGDSZE
	 4apMzmpkQpCeLaQKzgmoxfyfQfkd04rQdCNC2OSFuJ0YaIRksXBcoijyvc7w+F0min
	 8f7Vr/B2oekSry31eXkDamQlKaasOGoUWZhHcsTLo9t0yvWkkIZ45V+qlo2+UyTlUw
	 9zJ8Stsvf6FUw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id E32B1CE098B; Wed,  7 Jan 2026 11:17:48 -0800 (PST)
Date: Wed, 7 Jan 2026 11:17:48 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>,
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
Message-ID: <be85a8be-2def-48b4-9bee-9c2a8c063608@paulmck-laptop>
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
 <20260107084322.GC272712@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260107084322.GC272712@noisy.programming.kicks-ass.net>

On Wed, Jan 07, 2026 at 09:43:22AM +0100, Peter Zijlstra wrote:
> On Tue, Jan 06, 2026 at 10:18:35AM -0800, Paul E. McKenney wrote:
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
> Not really; although it would of course be nice if that were accompanied
> with a pile of cleanup patches taking out the worst offenders or
> somesuch ;-)

Careful what you ask for.  You might get it...  ;-)

							Thanx, Paul

> > ------------------------------------------------------------------------
> > 
> > diff --git a/lib/Kconfig.kcsan b/lib/Kconfig.kcsan
> > index 4ce4b0c0109cb..e827e24ab5d42 100644
> > --- a/lib/Kconfig.kcsan
> > +++ b/lib/Kconfig.kcsan
> > @@ -199,7 +199,7 @@ config KCSAN_WEAK_MEMORY
> >  
> >  config KCSAN_REPORT_VALUE_CHANGE_ONLY
> >  	bool "Only report races where watcher observed a data value change"
> > -	default y
> > +	default n
> >  	depends on !KCSAN_STRICT
> >  	help
> >  	  If enabled and a conflicting write is observed via a watchpoint, but
> > @@ -208,7 +208,7 @@ config KCSAN_REPORT_VALUE_CHANGE_ONLY
> >  
> >  config KCSAN_ASSUME_PLAIN_WRITES_ATOMIC
> >  	bool "Assume that plain aligned writes up to word size are atomic"
> > -	default y
> > +	default n
> >  	depends on !KCSAN_STRICT
> >  	help
> >  	  Assume that plain aligned writes up to word size are atomic by

