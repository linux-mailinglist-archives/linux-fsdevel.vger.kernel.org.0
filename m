Return-Path: <linux-fsdevel+bounces-21776-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D29909CDB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Jun 2024 11:51:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9640B210AC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Jun 2024 09:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A2E1836D3;
	Sun, 16 Jun 2024 09:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iesUFZJX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D85917F4F6
	for <linux-fsdevel@vger.kernel.org>; Sun, 16 Jun 2024 09:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718531480; cv=none; b=PcWxOFLIymfDGY3YeZxCW7mGCmGoJeQ4XrSaT5rcQrZI6Qmwc/m77oBjmdKiorjI2SDDg/2TZbiIiUiCHWO26x9UeFXQpg6LOxKnqH2R0d+zZHx67TW92rq27La0FoevtUqzzzU84rWluF80XyiPMFqc23A+zCeVv+NI6Im9UUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718531480; c=relaxed/simple;
	bh=n4cx1Z6BJEH5jWA2Zuabkll9jSUK+CtlbukX047kvG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RKyYVlcNZRiPSilqUX7cC47nr9cKFqGUUC6fFrSWiLhuG0lrEFxve0SS9fx4IgpwISVS36KQqwJiEjT2hwIzFWzd38vPBMvWY2ErUVFE9Tsvw82f+qzHbDoYfo2UCc4suBMHH8MO43P81NV5C3MV3u+GmgjFTr7nzRseTvk6v5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iesUFZJX; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: boqun.feng@gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718531475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Sc0GTYUsIOhy53GbTc5pAmG+S0kUyWsfKR1YRXBUAFE=;
	b=iesUFZJXhWISzzq/1WrJCPxUjjWPh+mWd0w/rzEVrhEGyJ9Mu71NzjiWpCZw4M545BFaiX
	6I6iA1L5/DyAIpTb5sGMdC+H5Wfr2HYiyZgVOeNRwTrakO+019XDxBDppjj9IzIEeftDxk
	ehJ13CJGG4rAG8eVqVxA6fTLZTfcuoY=
X-Envelope-To: benno.lossin@proton.me
X-Envelope-To: miguel.ojeda.sandonis@gmail.com
X-Envelope-To: gary@garyguo.net
X-Envelope-To: rust-for-linux@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: linux-arch@vger.kernel.org
X-Envelope-To: llvm@lists.linux.dev
X-Envelope-To: ojeda@kernel.org
X-Envelope-To: alex.gaynor@gmail.com
X-Envelope-To: wedsonaf@gmail.com
X-Envelope-To: bjorn3_gh@protonmail.com
X-Envelope-To: a.hindborg@samsung.com
X-Envelope-To: aliceryhl@google.com
X-Envelope-To: stern@rowland.harvard.edu
X-Envelope-To: parri.andrea@gmail.com
X-Envelope-To: will@kernel.org
X-Envelope-To: peterz@infradead.org
X-Envelope-To: npiggin@gmail.com
X-Envelope-To: dhowells@redhat.com
X-Envelope-To: j.alglave@ucl.ac.uk
X-Envelope-To: luc.maranget@inria.fr
X-Envelope-To: paulmck@kernel.org
X-Envelope-To: akiyks@gmail.com
X-Envelope-To: dlustig@nvidia.com
X-Envelope-To: joel@joelfernandes.org
X-Envelope-To: nathan@kernel.org
X-Envelope-To: ndesaulniers@google.com
X-Envelope-To: kent.overstreet@gmail.com
X-Envelope-To: gregkh@linuxfoundation.org
X-Envelope-To: elver@google.com
X-Envelope-To: mark.rutland@arm.com
X-Envelope-To: tglx@linutronix.de
X-Envelope-To: mingo@redhat.com
X-Envelope-To: bp@alien8.de
X-Envelope-To: dave.hansen@linux.intel.com
X-Envelope-To: x86@kernel.org
X-Envelope-To: hpa@zytor.com
X-Envelope-To: catalin.marinas@arm.com
X-Envelope-To: torvalds@linux-foundation.org
X-Envelope-To: linux-arm-kernel@lists.infradead.org
X-Envelope-To: linux-fsdevel@vger.kernel.org
X-Envelope-To: tmgross@umich.edu
X-Envelope-To: dakr@redhat.com
Date: Sun, 16 Jun 2024 05:51:07 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Benno Lossin <benno.lossin@proton.me>, 
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Gary Guo <gary@garyguo.net>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, llvm@lists.linux.dev, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, =?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, 
	Alan Stern <stern@rowland.harvard.edu>, Andrea Parri <parri.andrea@gmail.com>, 
	Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, 
	Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Akira Yokosawa <akiyks@gmail.com>, 
	Daniel Lustig <dlustig@nvidia.com>, Joel Fernandes <joel@joelfernandes.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	kent.overstreet@gmail.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	elver@google.com, Mark Rutland <mark.rutland@arm.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, torvalds@linux-foundation.org, 
	linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, Trevor Gross <tmgross@umich.edu>, 
	dakr@redhat.com
Subject: Re: [RFC 2/2] rust: sync: Add atomic support
Message-ID: <5lwylk6fhlvqfgxmt7xdoxdrhtvmplo5kazpdbt3kxpnlltxit@v5xbpiv3dnqq>
References: <20240613144432.77711a3a@eugeo>
 <ZmseosxVQXdsQjNB@boqun-archlinux>
 <CANiq72myhoCCWs7j0eZuxfoYMbTez7cPa795T57+gz2Dpd+xAw@mail.gmail.com>
 <ZmtC7h7v1t6XJ6EI@boqun-archlinux>
 <CANiq72=JdqTRPiUfT=-YMTTN+bHeAe2Pba8nERxU3cN8Q-BEOw@mail.gmail.com>
 <ZmxUxaIwHWnB42h-@Boquns-Mac-mini.home>
 <c1c45a2e-afdf-40a6-9f44-142752368d5e@proton.me>
 <ZmzvVr7lYfR6Dpca@Boquns-Mac-mini.home>
 <b692945b-8fa4-4918-93f6-783fbcde375c@proton.me>
 <Zm4R0XwTpsASpBhx@Boquns-Mac-mini.home>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zm4R0XwTpsASpBhx@Boquns-Mac-mini.home>
X-Migadu-Flow: FLOW_OUT

On Sat, Jun 15, 2024 at 03:12:33PM -0700, Boqun Feng wrote:
> What's the issue of having AtomicI32 and AtomicI64 first then? We don't
> need to do 1 or 2 until the real users show up.
> 
> And I'd like also to point out that there are a few more trait bound
> designs needed for Atomic<T>, for example, Atomic<u32> and Atomic<i32>
> have different sets of API (no inc_unless_negative() for u32).
> 
> Don't make me wrong, I have no doubt we can handle this in the type
> system, but given the design work need, won't it make sense that we take
> baby steps on this? We can first introduce AtomicI32 and AtomicI64 which
> already have real users, and then if there are some values of generic
> atomics, we introduce them and have proper discussion on design.
> 
> To me, it's perfectly fine that Atomic{I32,I64} co-exist with Atomic<T>.
> What's the downside? A bit specific example would help me understand
> the real concern here.

Err, what?

Of course we want generic atomics, and we need that for properly
supporting cmpxchg.

Bogun, you've got all the rust guys pushing for doing this with
generics, I'm not sure why you're being stubborn here?

