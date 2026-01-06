Return-Path: <linux-fsdevel+bounces-72490-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1B7CF8733
	for <lists+linux-fsdevel@lfdr.de>; Tue, 06 Jan 2026 14:16:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 855CB302BA92
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jan 2026 13:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8F532E74E;
	Tue,  6 Jan 2026 13:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g4dWGLt7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275CA1E868;
	Tue,  6 Jan 2026 13:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767704627; cv=none; b=eylk4LmmIuSi5qCvbHTptPuRAB7d7Io/5bjj2boRiWxs1DfPd8jkiStM4HVvj4XK5SPD8JTN1XOMaVTACC+hxAkvweNSiR7+VjMjJ+Do/2CvqD/qUDY3EXFgOGNWhUdhpDo2GEtvZdaVgQ5uoBe4un7tujiMQZi+CU+fBepO5L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767704627; c=relaxed/simple;
	bh=G1ENUbpw7ERc93thDSpYrQx7X7lw43ebLSgAnTOACjU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GJ32IlyevFrtrY7rWCiqdP9pFj4KgSSMHthjpy6OdJU/7rbf7i6tF6+VNv+oQw2f+9UA8nlNs7ePG6pXCYbsLwO+wIx667naRhg2OdqLzjeznOzJ9g4/7k4PqT4XWk1dbUoFf2JX+5/lgTgzCLkaSqumxTQfRwGBqoiG7eH5uo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g4dWGLt7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 422ECC116C6;
	Tue,  6 Jan 2026 13:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767704626;
	bh=G1ENUbpw7ERc93thDSpYrQx7X7lw43ebLSgAnTOACjU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=g4dWGLt7m4E0SQ9mCzeaUxVahU58dRj5+yK1M0Yi0vcArWGi7BQzL9SNMWUv1FSDj
	 ONUuHss2z35npwgqgbVoKhrcSdjM4c8W6z4sjplOeai6ksuXJsqKxNEXsqlWaK96vD
	 b/2mDe7idva+VdeoIPeAS8YA/k1iKmtqdNk0VCnmTwVNH8DQU15b/VL+4XCHlYEG28
	 fZZ57XcWR6RufesthzzKLMyfKj08QizH2NtOEp8hdcpnAhfbeA+WZA1I0rHcjdtN+y
	 w9aTuteJPU3SP8IQWa4LAcxxdPGQVrtJwLksSMmg/n9megtSVhdYwdjN2kD73VvL16
	 WTCHY3/uG6rbQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>, Alice Ryhl <aliceryhl@google.com>
Cc: Gary Guo <gary@garyguo.net>, Will Deacon <will@kernel.org>, Peter
 Zijlstra <peterz@infradead.org>, "Paul E. McKenney" <paulmck@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>, Matt Turner
 <mattst88@gmail.com>, Magnus Lindholm <linmag7@gmail.com>, Catalin
 Marinas <catalin.marinas@arm.com>, Miguel Ojeda <ojeda@kernel.org>,
 =?utf-8?Q?Bj=C3=B6rn?=
 Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Trevor
 Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, FUJITA Tomonori
 <fujita.tomonori@gmail.com>, Frederic Weisbecker <frederic@kernel.org>,
 Lyude Paul <lyude@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>, John Stultz
 <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan
 Kara <jack@suse.cz>, linux-kernel@vger.kernel.org,
 linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/5] Add READ_ONCE and WRITE_ONCE to Rust
In-Reply-To: <aVXKP8vQ6uAxtazT@tardis-2.local>
References: <20251231-rwonce-v1-0-702a10b85278@google.com>
 <20251231151216.23446b64.gary@garyguo.net> <aVXFk0L-FegoVJpC@google.com>
 <OFUIwAYmy6idQxDq-A3A_s2zDlhfKE9JmkSgcK40K8okU1OE_noL1rN6nUZD03AX6ixo4Xgfhi5C4XLl5RJlfA==@protonmail.internalid>
 <aVXKP8vQ6uAxtazT@tardis-2.local>
Date: Tue, 06 Jan 2026 13:41:33 +0100
Message-ID: <87fr8ij4le.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Boqun Feng" <boqun.feng@gmail.com> writes:

> On Thu, Jan 01, 2026 at 12:53:39AM +0000, Alice Ryhl wrote:
>> On Wed, Dec 31, 2025 at 03:12:16PM +0000, Gary Guo wrote:
>> > On Wed, 31 Dec 2025 12:22:24 +0000
>> > Alice Ryhl <aliceryhl@google.com> wrote:
>> >
>> > > There are currently a few places in the kernel where we use volatile
>> > > reads when we really should be using `READ_ONCE`. To make it possible to
>> > > replace these with proper `READ_ONCE` calls, introduce a Rust version of
>> > > `READ_ONCE`.
>> > >
>> > > A new config option CONFIG_ARCH_USE_CUSTOM_READ_ONCE is introduced so
>> > > that Rust is able to use conditional compilation to implement READ_ONCE
>> > > in terms of either a volatile read, or by calling into a C helper
>> > > function, depending on the architecture.
>> > >
>> > > This series is intended to be merged through ATOMIC INFRASTRUCTURE.
>> >
>> > Hi Alice,
>> >
>> > I would prefer not to expose the READ_ONCE/WRITE_ONCE functions, at
>> > least not with their atomic semantics.
>> >
>> > Both callsites that you have converted should be using
>> >
>> > 	Atomic::from_ptr().load(Relaxed)
>> >
>> > Please refer to the documentation of `Atomic` about this. Fujita has a
>> > series that expand the type to u8/u16 if you need narrower accesses.
>>
>> Why? If we say that we're using the LKMM, then it seems confusing to not
>> have a READ_ONCE() for cases where we interact with C code, and that C
>> code documents that READ_ONCE() should be used.
>>
>
> The problem of READ_ONCE() and WRITE_ONCE() is that the semantics is
> complicated. Sometimes they are used for atomicity, sometimes they are
> used for preventing data race. So yes, we are using LKMM in Rust as
> well, but whenever possible, we need to clarify the intentation of the
> API, using Atomic::from_ptr().load(Relaxed) helps on that front.
>
> IMO, READ_ONCE()/WRITE_ONCE() is like a "band aid" solution to a few
> problems, having it would prevent us from developing a more clear view
> for concurrent programming.

What is the semantics of a non-atomic write in C code under lock racing
with a READ_ONCE/atomic relaxed read in Rust? That is the hrtimer case.


Best regards,
Andreas Hindborg




