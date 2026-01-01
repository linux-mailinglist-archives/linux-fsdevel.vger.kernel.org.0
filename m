Return-Path: <linux-fsdevel+bounces-72298-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1870CECB70
	for <lists+linux-fsdevel@lfdr.de>; Thu, 01 Jan 2026 01:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B4A843011ED9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Jan 2026 00:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452922472A2;
	Thu,  1 Jan 2026 00:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iJvmc6iA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8C550276
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 Jan 2026 00:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767228827; cv=none; b=Lmn0S+kE0QOsGEBsQ/MtjAtg+jJdnqgesJTOIl+kdReiytAN6ka9Vek7Shqlw944clf5cno8IVaVw6pG8CasUizKa8IOmnLYVYqeRSTE6BGA7XTYKVwIOg1kIHaE2V/irRx/C6YfanYG6XCASnpY5GQUPvMPzmOVXy0tfVwZNgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767228827; c=relaxed/simple;
	bh=FJxmCTvLM25zFfWpcNP5yBD/9nFfmtlGgUOBfBuzQiM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lo+mIzhp9DcJP6aDWfyDBMp/aelNyJA5kRrvnbpo0vH6bEoQ7/xHDrSepSfvr/ZK93LHMEO9yG9jJrLu0I8cAcvsnjKou22xyJMzjti/n/0CGdTQbeYrR6pphBhO3fdU2u2Y7JGjbhkiMcLgDtcGzrBdTZ4qN9DlpTGI2JZGC6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iJvmc6iA; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-b70b1778687so974238566b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 Dec 2025 16:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767228821; x=1767833621; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ALybukQ368MxKZuRBiA6l9FsoHeskqo5LiIi7UTqkwI=;
        b=iJvmc6iAlq+AGWwQlMfFpUv590zRrBmK9KHqa/L+nel4mOmog6irZk1MSKC7Z2r19y
         rT8zEbz4u7YdtSJkKJcmltsqALqK+hrSYeB7E48uQM8gugOrXeCxGhousoIe5uyCxnQZ
         2+YwvXiL1iRtvRt2RBjS3JfLHtn97je52gO5gazY1dQvKNsvphb6H9qD0UKtUnHcGJsQ
         md1zNznurxGuorqpsB21pNxmyx84nhAiTnDOQcP8TdUkSZN6IZt/RUV2iu0UjrUXB61V
         DsZYu+AG9Jb4apwuHJa8OznjSivAOVrbOZgEm96FRa1/ptCViI4sdMnn4j9y/3EJyl5o
         CxRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767228821; x=1767833621;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ALybukQ368MxKZuRBiA6l9FsoHeskqo5LiIi7UTqkwI=;
        b=KAOfsJ4lT6jNxcfy5brF8GdHcTI3Qm34kkv07qqb68LrNZ9S0/JpaFH1lHhEG/1Q4/
         6VAHaQJkFpC4gc/RpIvAKpPcmdme1sqeaoT2HrJ2LJ5n1w0mvEAT1IImoDAd3KXy9Te1
         +B9J9l9KB6OV2q0DK/XdHsAkGYJES0wi+1nIBSQ97+X3xk9ggGzG4SKEt8qo3/ZRy5rV
         a4KNv/jgQ0LugKsluxRPskJ/pL1i5ydyAPPu1F4sxuY1OeEE+1eqCweHHsHUq1epqBY1
         v4s5BCrfSOqCVNKf6/fqFh8sGIj39i53VhuqwekBoZr/pb8OC5crgxbCpNu1NI9H8iZ9
         cSww==
X-Forwarded-Encrypted: i=1; AJvYcCWGf8ohlEd0vZttW66cKfZLZdUoLpRsAh3Ng7yXB0ctrUe6zEJ86m9aNu8f5WPppbFSTsvNFHb59l5+Ajj1@vger.kernel.org
X-Gm-Message-State: AOJu0YxSdiC1iEYmcBFW2D22/Rf/p+bUxdXzwbNDUEj9WhlEYAl4HEr9
	2+HEpBM1B+MaFYXUdJ5ex7dB5hbe0vGvnE5RIfRyA5+t8qhb6XS8eYY4vwfXJIM6JWYx5SOkbRY
	2v4jxnS9vf6vT0SwpmQ==
X-Google-Smtp-Source: AGHT+IEWmy8RAXCgqnhUehDWXxrrCi36bifjxhWe3kp7T+r3sxEL7vClkSWEcaAst8kVOoT68CYG7PpgofIxyHk=
X-Received: from ejcul5.prod.google.com ([2002:a17:907:ca85:b0:b7f:fed7:3bc2])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:3f23:b0:b76:6020:ed2b with SMTP id a640c23a62f3a-b80371970a2mr3724571266b.45.1767228820647;
 Wed, 31 Dec 2025 16:53:40 -0800 (PST)
Date: Thu, 1 Jan 2026 00:53:39 +0000
In-Reply-To: <20251231151216.23446b64.gary@garyguo.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251231-rwonce-v1-0-702a10b85278@google.com> <20251231151216.23446b64.gary@garyguo.net>
Message-ID: <aVXFk0L-FegoVJpC@google.com>
Subject: Re: [PATCH 0/5] Add READ_ONCE and WRITE_ONCE to Rust
From: Alice Ryhl <aliceryhl@google.com>
To: Gary Guo <gary@garyguo.net>
Cc: Boqun Feng <boqun.feng@gmail.com>, Will Deacon <will@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Richard Henderson <richard.henderson@linaro.org>, Matt Turner <mattst88@gmail.com>, 
	Magnus Lindholm <linmag7@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Miguel Ojeda <ojeda@kernel.org>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, Frederic Weisbecker <frederic@kernel.org>, 
	Lyude Paul <lyude@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, John Stultz <jstultz@google.com>, 
	Stephen Boyd <sboyd@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org, 
	linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Wed, Dec 31, 2025 at 03:12:16PM +0000, Gary Guo wrote:
> On Wed, 31 Dec 2025 12:22:24 +0000
> Alice Ryhl <aliceryhl@google.com> wrote:
> 
> > There are currently a few places in the kernel where we use volatile
> > reads when we really should be using `READ_ONCE`. To make it possible to
> > replace these with proper `READ_ONCE` calls, introduce a Rust version of
> > `READ_ONCE`.
> > 
> > A new config option CONFIG_ARCH_USE_CUSTOM_READ_ONCE is introduced so
> > that Rust is able to use conditional compilation to implement READ_ONCE
> > in terms of either a volatile read, or by calling into a C helper
> > function, depending on the architecture.
> > 
> > This series is intended to be merged through ATOMIC INFRASTRUCTURE.
> 
> Hi Alice,
> 
> I would prefer not to expose the READ_ONCE/WRITE_ONCE functions, at
> least not with their atomic semantics.
> 
> Both callsites that you have converted should be using
> 
> 	Atomic::from_ptr().load(Relaxed)
> 
> Please refer to the documentation of `Atomic` about this. Fujita has a
> series that expand the type to u8/u16 if you need narrower accesses.

Why? If we say that we're using the LKMM, then it seems confusing to not
have a READ_ONCE() for cases where we interact with C code, and that C
code documents that READ_ONCE() should be used.

Alice

