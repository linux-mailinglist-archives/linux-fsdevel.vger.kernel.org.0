Return-Path: <linux-fsdevel+bounces-72488-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 260A7CF8638
	for <lists+linux-fsdevel@lfdr.de>; Tue, 06 Jan 2026 13:53:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 921B73044852
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jan 2026 12:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1497E32C937;
	Tue,  6 Jan 2026 12:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fF8x1imp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E692C5695;
	Tue,  6 Jan 2026 12:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767703420; cv=none; b=VctbePU8H/MiFij4ovghLALuxr5PY2CD2p6Yrx0hDIGe5QZEWbSZj7VbGvWQrsza/J1b/7EeVD4e5hGyIs55t9NQvcotFv479kAraIwWL+2KTcwbjzRD1ytteFIayRQ4ktJlRjfYkVKSRriUzUsn/PXz3zYtsBwmQGerTQpmEzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767703420; c=relaxed/simple;
	bh=l6XET2g82VU5NPqDA34kNchMz8416gLMHeQDf+qqDuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fcFGWWwNZSMVxTzCFwiMenUUac/dqE+TSsSK2QqxnxRazgMMEwvHWjGQdJI1b5AZE70wM7EQ6xxZonAvco42EQhSThfCWYhpJURsY4MXlwntgYmhfrcIoX/4Ve2/4OzT78xrFflvz/JeObave3Yc4vinJvefe+LtZ+aSKjdg9iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fF8x1imp; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=oRMkA/Ca563y0+dy1t5I/0e9W9y6rU2HQmmd09ZD4+8=; b=fF8x1implaMTwmDC1WueQdrygX
	hcp2Jzf/RJx5Vzset7UUh3RO0L/rISk8A28NzSvDhKtM+KuzehXVbdI6XKw1XyKJ9zk99lU9ACzmz
	ps1tMiWLfwcFAuz1KVztHAKzPhJY77fcfFUiYzYoge4bvvx9pKlRj4h+FfrbuhZMvhsy11PXQNACB
	e+9UYVgjmYoMI/Gnx+rjnEq2YOn0ecUTgl4m7qpqMsbThPBPAG6n+3vDgQz3LBhrNiALCbrFmxVTu
	AynL8hzMi0+ECj6C1VSYyxSUJTWMGVt0W/9ccLrJLC90FS97UHXrepDcMzj9P48L3wT/3enG9ZnSs
	uVWcN5zA==;
Received: from 2001-1c00-8d85-5700-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:5700:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vd6PH-0000000BmZ5-1z2W;
	Tue, 06 Jan 2026 12:43:27 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 0D77630039E; Tue, 06 Jan 2026 13:43:26 +0100 (CET)
Date: Tue, 6 Jan 2026 13:43:26 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, Will Deacon <will@kernel.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>,
	Magnus Lindholm <linmag7@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
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
Subject: Re: [PATCH 3/5] rust: sync: support using bool with READ_ONCE
Message-ID: <20260106124326.GY3707891@noisy.programming.kicks-ass.net>
References: <20251231-rwonce-v1-0-702a10b85278@google.com>
 <20251231-rwonce-v1-3-702a10b85278@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251231-rwonce-v1-3-702a10b85278@google.com>

On Wed, Dec 31, 2025 at 12:22:27PM +0000, Alice Ryhl wrote:
> Normally it is undefined behavior for a bool to take any value other
> than 0 or 1. However, in the case of READ_ONCE(some_bool) is used, this
> UB seems dangerous and unnecessary. I can easily imagine some Rust code
> that looks like this:
> 
> 	if READ_ONCE(&raw const (*my_c_struct).my_bool_field) {
> 	    ...
> 	}
> 
> And by making an analogy to what the equivalent C code is, anyone
> writing this probably just meant to treat any non-zero value as true.
> 
> For WRITE_ONCE no special logic is required.
> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/kernel/sync/rwonce.rs | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/rust/kernel/sync/rwonce.rs b/rust/kernel/sync/rwonce.rs
> index a1660e43c9ef94011812d1816713cf031a73de1d..73477f53131926996614df573b2d50fff98e624f 100644
> --- a/rust/kernel/sync/rwonce.rs
> +++ b/rust/kernel/sync/rwonce.rs
> @@ -163,6 +163,7 @@ unsafe fn write_once(ptr: *mut Self, val: Self) {
>  // sizes, so picking the wrong helper should lead to a build error.
>  
>  impl_rw_once_type! {
> +    bool, read_once_bool, write_once_1;
>      u8,   read_once_1, write_once_1;
>      i8,   read_once_1, write_once_1;
>      u16,  read_once_2, write_once_2;
> @@ -186,3 +187,21 @@ unsafe fn write_once(ptr: *mut Self, val: Self) {
>      usize, read_once_8, write_once_8;
>      isize, read_once_8, write_once_8;
>  }
> +
> +/// Read an integer as a boolean once.
> +///
> +/// Returns `true` if the value behind the pointer is non-zero. Otherwise returns `false`.
> +///
> +/// # Safety
> +///
> +/// It must be safe to `READ_ONCE` the `ptr` with type `u8`.
> +#[inline(always)]
> +#[track_caller]
> +unsafe fn read_once_bool(ptr: *const bool) -> bool {
> +    // Implement `read_once_bool` in terms of `read_once_1`. The arch-specific logic is inside
> +    // of `read_once_1`.
> +    //
> +    // SAFETY: It is safe to `READ_ONCE` the `ptr` with type `u8`.
> +    let byte = unsafe { read_once_1(ptr.cast::<u8>()) };
> +    byte != 0u8
> +}

Does this hardcode that sizeof(_Bool) == 1? There are ABIs where this is
not the case.

