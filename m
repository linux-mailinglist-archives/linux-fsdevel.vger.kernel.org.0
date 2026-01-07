Return-Path: <linux-fsdevel+bounces-72595-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E1EE8CFCAAB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 07 Jan 2026 09:47:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8ACCE3017679
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jan 2026 08:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFCC32C2368;
	Wed,  7 Jan 2026 08:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fTZpoVpt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B672C11EE;
	Wed,  7 Jan 2026 08:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767775414; cv=none; b=vBE2rwkBdgguTZjLAd/aKD3owuEVcc4h7+rCB8jLsED6ueeG9ec7ChnTp0paZYz1G1132wKkOgvbl2SuZbZI+v9OSqSWto4w3Mc16Km1tn8y63/OA6FvdAoLnpCSIUCdUvkJm9eFA2yqPaCASKo/bFKGfSdK+0MKNJtyjyWC7Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767775414; c=relaxed/simple;
	bh=gUFl4vMy7ghUOaKzP1PiSEetw3MPIc2N5A2mLJP19Ao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aAwu6fS5YEvy8iOgqZqcHmRTHgHjyn0gh8SB9Beax+rgm/uunpXcZ7U0GZ2wUpO3YvmlZelyx6liazPwaKfVwPGuZutDROgSLbE+Y7CESOEtGH9oF2rJQ8XaY2tyjzDEnZAcRdZW5jaHjdkeAGAKFYG0kiOhyiRJzwpt1VKXFWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fTZpoVpt; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=UybR8h6LJ7X/dgWxJlHGwPKuKCGXzpl1N/omiIktehk=; b=fTZpoVptxZ/3tmwLvBwSdnL2AS
	U8jHIbhl6dXo7juEQx0yz8jmkvjflFZRAri/iPtz52WmUV4PJh1G5QVK0fwDIa63YmTM2UPDH41wE
	ie90xZf1RVXoqk1IGR7h81Vh5Ry/LnENCUozWvynA6/m7jt5dyK088VnOJ6YO3WBkxbIGuhgalysk
	m2yF1vWOvcnLJGKQDrY5lG5b3wh3ljIUFHb7tLd8LhhIImdxRfsiBURiOudgppLnXWWlDB2jIlvV8
	iLiZaM/4qqHzpWhlp0xxAoPk4VtKuKOrsVO7iu+l49kvMn+tE/GWHD+oF8byJ5pQqVyYo2V+dPEeI
	oBTcbjmA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdP8V-0000000B0RI-14Mc;
	Wed, 07 Jan 2026 08:43:23 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 29E43300329; Wed, 07 Jan 2026 09:43:22 +0100 (CET)
Date: Wed, 7 Jan 2026 09:43:22 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
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
Message-ID: <20260107084322.GC272712@noisy.programming.kicks-ass.net>
References: <20251231-rwonce-v1-0-702a10b85278@google.com>
 <20251231151216.23446b64.gary@garyguo.net>
 <aVXFk0L-FegoVJpC@google.com>
 <OFUIwAYmy6idQxDq-A3A_s2zDlhfKE9JmkSgcK40K8okU1OE_noL1rN6nUZD03AX6ixo4Xgfhi5C4XLl5RJlfA==@protonmail.internalid>
 <aVXKP8vQ6uAxtazT@tardis-2.local>
 <87fr8ij4le.fsf@t14s.mail-host-address-is-not-set>
 <aV0JkZdrZn97-d7d@tardis-2.local>
 <20260106145622.GB3707837@noisy.programming.kicks-ass.net>
 <7fa2c07e-acf9-4f9a-b056-4d4254ea61e5@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7fa2c07e-acf9-4f9a-b056-4d4254ea61e5@paulmck-laptop>

On Tue, Jan 06, 2026 at 10:18:35AM -0800, Paul E. McKenney wrote:
> On Tue, Jan 06, 2026 at 03:56:22PM +0100, Peter Zijlstra wrote:
> > On Tue, Jan 06, 2026 at 09:09:37PM +0800, Boqun Feng wrote:
> > 
> > > Some C code believes a plain write to a properly aligned location is
> > > atomic (see KCSAN_ASSUME_PLAIN_WRITES_ATOMIC, and no, this doesn't mean
> > > it's recommended to assume such), and I guess that's the case for
> > > hrtimer, if it's not much a trouble you can replace the plain write with
> > > WRITE_ONCE() on C side ;-)
> > 
> > GCC used to provide this guarantee, some of the older code was written
> > on that. GCC no longer provides that guarantee (there are known cases
> > where it breaks and all that) and newer code should not rely on this.
> > 
> > All such places *SHOULD* be updated to use READ_ONCE/WRITE_ONCE.
> 
> Agreed!
> 
> In that vein, any objections to the patch shown below?

Not really; although it would of course be nice if that were accompanied
with a pile of cleanup patches taking out the worst offenders or
somesuch ;-)

> ------------------------------------------------------------------------
> 
> diff --git a/lib/Kconfig.kcsan b/lib/Kconfig.kcsan
> index 4ce4b0c0109cb..e827e24ab5d42 100644
> --- a/lib/Kconfig.kcsan
> +++ b/lib/Kconfig.kcsan
> @@ -199,7 +199,7 @@ config KCSAN_WEAK_MEMORY
>  
>  config KCSAN_REPORT_VALUE_CHANGE_ONLY
>  	bool "Only report races where watcher observed a data value change"
> -	default y
> +	default n
>  	depends on !KCSAN_STRICT
>  	help
>  	  If enabled and a conflicting write is observed via a watchpoint, but
> @@ -208,7 +208,7 @@ config KCSAN_REPORT_VALUE_CHANGE_ONLY
>  
>  config KCSAN_ASSUME_PLAIN_WRITES_ATOMIC
>  	bool "Assume that plain aligned writes up to word size are atomic"
> -	default y
> +	default n
>  	depends on !KCSAN_STRICT
>  	help
>  	  Assume that plain aligned writes up to word size are atomic by

