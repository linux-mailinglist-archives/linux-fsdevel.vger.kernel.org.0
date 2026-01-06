Return-Path: <linux-fsdevel+bounces-72513-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB82CF8EA9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 06 Jan 2026 15:57:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9EB6E3028E40
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jan 2026 14:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 904DE33066A;
	Tue,  6 Jan 2026 14:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bjHvd4Ac"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3373203B5;
	Tue,  6 Jan 2026 14:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767711396; cv=none; b=jCG0jlZmBDV+JJfvZ1N5geWQ5H4wh9PnvlyPUfQ3TeuniEKGpaVVW6Ks9iwrNvJQUz6h4gPCFi9HPKPRFhROwhcfmC8Lc9mwhbKapLrKkd4fxESC7trFCg60wFeTyaxF2XQpV96QiqNGOlgE4WiNvo0g1Rl2EaowcfNaLqyE728=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767711396; c=relaxed/simple;
	bh=F++X+waLmj9d+5eJ7s+Pnye5YZ3oIpFoEnARYztMaTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AvPSIQwmkY6CcDJ+O8MkuhrOfoKYoBgbgswyNjUaNkfURE2oT4rw3j1jyTScYIEqQZKDGPqDFdO7M6wquqqVBNPn4Ce0LKeeMeXXM/o/9bcIAZmhPHeWArxmWCxhLc3/F1534lgUKJniTP8xMz7oqltkI7w0w+2wWTfojzpAA0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bjHvd4Ac; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=F++X+waLmj9d+5eJ7s+Pnye5YZ3oIpFoEnARYztMaTU=; b=bjHvd4AchX4OX8btHy3c3ti0E5
	XWujH7TztZmJyVjlONn5y71LDgfkcktFr0sinUGsypZwk/GUVna+Y7uMEwBz9AuqYd3k8AuJAf9hn
	NvLtdAGw5LES1uKJxpe/fNY0O5h9yBc2ToLxQa3pR8vtdS+F9l2IeqnOpHrBD2iKOWIwJQB1BBrx4
	b7KTF5tOfUEONpp8MsqyTKoLhfDnU5nuE8REZm1bugTHwhKvawElhw4q/x5HKbeDnvcqTHipyia+t
	Uo8yDnf4EThWU4Ge3KcULO3c0bMFvzkKzc199VwrTVJc/4uiyRjj1g3NUb8wtIxm99vaBZVe56v/7
	UCHPmwCg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vd8Tv-00000009uwx-2Ndu;
	Tue, 06 Jan 2026 14:56:23 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 15B0030056B; Tue, 06 Jan 2026 15:56:22 +0100 (CET)
Date: Tue, 6 Jan 2026 15:56:22 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Gary Guo <gary@garyguo.net>,
	Will Deacon <will@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
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
	rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/5] Add READ_ONCE and WRITE_ONCE to Rust
Message-ID: <20260106145622.GB3707837@noisy.programming.kicks-ass.net>
References: <20251231-rwonce-v1-0-702a10b85278@google.com>
 <20251231151216.23446b64.gary@garyguo.net>
 <aVXFk0L-FegoVJpC@google.com>
 <OFUIwAYmy6idQxDq-A3A_s2zDlhfKE9JmkSgcK40K8okU1OE_noL1rN6nUZD03AX6ixo4Xgfhi5C4XLl5RJlfA==@protonmail.internalid>
 <aVXKP8vQ6uAxtazT@tardis-2.local>
 <87fr8ij4le.fsf@t14s.mail-host-address-is-not-set>
 <aV0JkZdrZn97-d7d@tardis-2.local>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aV0JkZdrZn97-d7d@tardis-2.local>

On Tue, Jan 06, 2026 at 09:09:37PM +0800, Boqun Feng wrote:

> Some C code believes a plain write to a properly aligned location is
> atomic (see KCSAN_ASSUME_PLAIN_WRITES_ATOMIC, and no, this doesn't mean
> it's recommended to assume such), and I guess that's the case for
> hrtimer, if it's not much a trouble you can replace the plain write with
> WRITE_ONCE() on C side ;-)

GCC used to provide this guarantee, some of the older code was written
on that. GCC no longer provides that guarantee (there are known cases
where it breaks and all that) and newer code should not rely on this.

All such places *SHOULD* be updated to use READ_ONCE/WRITE_ONCE.

