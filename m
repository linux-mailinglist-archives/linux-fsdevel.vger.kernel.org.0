Return-Path: <linux-fsdevel+bounces-72537-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 516A0CFA8D6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 06 Jan 2026 20:17:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A35B316A20F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jan 2026 18:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC168355023;
	Tue,  6 Jan 2026 18:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tzz8m5do"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FDC354AE2;
	Tue,  6 Jan 2026 18:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767723517; cv=none; b=bWygxdV7VGwdO3pTrPUwF6BBkT4JMfrnkX7jUXatjanKGBvP45E6LMX0IAkFjN5G543kwhUXklzVgsNErIPzaVww/dvnoUs6WfBU8ghC2bRzK4RaZyFFuOYnfv1odwLBNL7fQIyQs9M2kzEOzgbOERF6LuktI3ULT1Yr6ThsZuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767723517; c=relaxed/simple;
	bh=bO8klnJTIuS36gg4GjV1n5g1dixU1LM1E0r280+OdQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nRywGbi3byMYo4eJ5Bjmfd9UO3xUXtEzeskOtb6PRmd2ThC7bTFKnnNDXNZTfNv4NmjAYJfww8dzXQ1HLJLgqnPGh2LRv8XJqQ97jVpfeQ/02GavKYdDgvSTrJthG1DOC7eeLf4WdfeCl0ng0uUuj5W4qAaF33Akevs7PeqRfW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tzz8m5do; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74CC6C116C6;
	Tue,  6 Jan 2026 18:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767723516;
	bh=bO8klnJTIuS36gg4GjV1n5g1dixU1LM1E0r280+OdQo=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=tzz8m5doGvbrAN0e/5sV7Gi9HpRCFgI7iTC1PeibUA7LxcoVnPfYBUSqOrXWcQw/7
	 BN6Y7+O93ECYj7PMpIaSx0SaJmlujXs0QZ+3c6AOlbe55DrUQ49H3bdQ/KSiqm/KnE
	 U7olZ5CxaLUADwizq/DqCqg6hTeFKElqfhepBfMQa/LtVeryxqYO6NNJrwXqZDOaYJ
	 UG4MbWW14RAvx97mXtzBg6kNsiQ1qSmjXr+FryUFE2Ure4eAaWcy4Ly/ENn3yOwGXd
	 tPq5mREwkkbbjWQHiFKqKTTi04flj8/xK0Akn29F9JPrf1xjXtoFBmhBAkye0uetpx
	 INtcG2/fIFNAA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id D8D24CE0F95; Tue,  6 Jan 2026 10:18:35 -0800 (PST)
Date: Tue, 6 Jan 2026 10:18:35 -0800
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
Message-ID: <7fa2c07e-acf9-4f9a-b056-4d4254ea61e5@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20251231-rwonce-v1-0-702a10b85278@google.com>
 <20251231151216.23446b64.gary@garyguo.net>
 <aVXFk0L-FegoVJpC@google.com>
 <OFUIwAYmy6idQxDq-A3A_s2zDlhfKE9JmkSgcK40K8okU1OE_noL1rN6nUZD03AX6ixo4Xgfhi5C4XLl5RJlfA==@protonmail.internalid>
 <aVXKP8vQ6uAxtazT@tardis-2.local>
 <87fr8ij4le.fsf@t14s.mail-host-address-is-not-set>
 <aV0JkZdrZn97-d7d@tardis-2.local>
 <20260106145622.GB3707837@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260106145622.GB3707837@noisy.programming.kicks-ass.net>

On Tue, Jan 06, 2026 at 03:56:22PM +0100, Peter Zijlstra wrote:
> On Tue, Jan 06, 2026 at 09:09:37PM +0800, Boqun Feng wrote:
> 
> > Some C code believes a plain write to a properly aligned location is
> > atomic (see KCSAN_ASSUME_PLAIN_WRITES_ATOMIC, and no, this doesn't mean
> > it's recommended to assume such), and I guess that's the case for
> > hrtimer, if it's not much a trouble you can replace the plain write with
> > WRITE_ONCE() on C side ;-)
> 
> GCC used to provide this guarantee, some of the older code was written
> on that. GCC no longer provides that guarantee (there are known cases
> where it breaks and all that) and newer code should not rely on this.
> 
> All such places *SHOULD* be updated to use READ_ONCE/WRITE_ONCE.

Agreed!

In that vein, any objections to the patch shown below?

							Thanx, Paul

------------------------------------------------------------------------

diff --git a/lib/Kconfig.kcsan b/lib/Kconfig.kcsan
index 4ce4b0c0109cb..e827e24ab5d42 100644
--- a/lib/Kconfig.kcsan
+++ b/lib/Kconfig.kcsan
@@ -199,7 +199,7 @@ config KCSAN_WEAK_MEMORY
 
 config KCSAN_REPORT_VALUE_CHANGE_ONLY
 	bool "Only report races where watcher observed a data value change"
-	default y
+	default n
 	depends on !KCSAN_STRICT
 	help
 	  If enabled and a conflicting write is observed via a watchpoint, but
@@ -208,7 +208,7 @@ config KCSAN_REPORT_VALUE_CHANGE_ONLY
 
 config KCSAN_ASSUME_PLAIN_WRITES_ATOMIC
 	bool "Assume that plain aligned writes up to word size are atomic"
-	default y
+	default n
 	depends on !KCSAN_STRICT
 	help
 	  Assume that plain aligned writes up to word size are atomic by

