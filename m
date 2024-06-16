Return-Path: <linux-fsdevel+bounces-21784-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C22FC909E21
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Jun 2024 17:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EDC01F21364
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Jun 2024 15:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E26A1758C;
	Sun, 16 Jun 2024 15:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="feWXWjPK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DBB15ACB
	for <linux-fsdevel@vger.kernel.org>; Sun, 16 Jun 2024 15:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718551413; cv=none; b=mVO/PU4HaFy+lX9GGbVaB02K1OS3DPofqExxeeE/7N2LUo0f4iaXXHHFa/xV5qlEXoOxWKvTwu9MYQLIURa9sG1t7UM1krEzMBFnxLZvwnHXhcc8e7JfVU1HqCeRDN/yldhJb2vHeG4DVJrmfc8UwB1qD+TXViiMz5CeMZAMnZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718551413; c=relaxed/simple;
	bh=No/yQzvhSQo5eA4MVA3Ontr93OnajiTCJcU9VnBHmPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XRZzG1yD1ZisKoeOpJyZmCHFi+63JLZFVkL9itwyKO15zREU4m+3S5dhlJkP800IVIGxvR22TTnZaFdnjP8KYlDL8L6mssiTEamI1p2LY7zsDX3dx27PP+rfMWB7tD5XTmibLs/+Gck6CpBaX4EAtc65rnVKEhOoP3LnElZ4z9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=feWXWjPK; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: boqun.feng@gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718551409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+Y0ywigxrcxoZLMnkkInJwDOVqW5TO6Aw/Ls7GsS5vA=;
	b=feWXWjPKXXY7VhKtIp2DrasCgMafipVFZJqsNNTR46i50F7JtgPaTyHGZrVzvKgTPXfIop
	WWU8jryipa3fHFey+xiAVr+eIxX5lyPSUIT/Q0P7ZxQlWEfNatfhz+vepE0+dVYnnvuUCE
	RgLLOMq/CTSyPIrdJhB58exbhTZzXR8=
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
Date: Sun, 16 Jun 2024 11:23:20 -0400
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
Message-ID: <zq5p4o6j4avgncfacqrz6naaw7yqk4e5fbmwz547ge7xi52vmq@zjk3ncmsdrkk>
References: <CANiq72myhoCCWs7j0eZuxfoYMbTez7cPa795T57+gz2Dpd+xAw@mail.gmail.com>
 <ZmtC7h7v1t6XJ6EI@boqun-archlinux>
 <CANiq72=JdqTRPiUfT=-YMTTN+bHeAe2Pba8nERxU3cN8Q-BEOw@mail.gmail.com>
 <ZmxUxaIwHWnB42h-@Boquns-Mac-mini.home>
 <c1c45a2e-afdf-40a6-9f44-142752368d5e@proton.me>
 <ZmzvVr7lYfR6Dpca@Boquns-Mac-mini.home>
 <b692945b-8fa4-4918-93f6-783fbcde375c@proton.me>
 <Zm4R0XwTpsASpBhx@Boquns-Mac-mini.home>
 <5lwylk6fhlvqfgxmt7xdoxdrhtvmplo5kazpdbt3kxpnlltxit@v5xbpiv3dnqq>
 <Zm7zvt7cNT2YpiIi@Boquns-Mac-mini.home>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zm7zvt7cNT2YpiIi@Boquns-Mac-mini.home>
X-Migadu-Flow: FLOW_OUT

On Sun, Jun 16, 2024 at 07:16:30AM -0700, Boqun Feng wrote:
> On Sun, Jun 16, 2024 at 05:51:07AM -0400, Kent Overstreet wrote:
> > On Sat, Jun 15, 2024 at 03:12:33PM -0700, Boqun Feng wrote:
> > > What's the issue of having AtomicI32 and AtomicI64 first then? We don't
> > > need to do 1 or 2 until the real users show up.
> > > 
> > > And I'd like also to point out that there are a few more trait bound
> > > designs needed for Atomic<T>, for example, Atomic<u32> and Atomic<i32>
> > > have different sets of API (no inc_unless_negative() for u32).
> > > 
> > > Don't make me wrong, I have no doubt we can handle this in the type
> > > system, but given the design work need, won't it make sense that we take
> > > baby steps on this? We can first introduce AtomicI32 and AtomicI64 which
> > > already have real users, and then if there are some values of generic
> > > atomics, we introduce them and have proper discussion on design.
> > > 
> > > To me, it's perfectly fine that Atomic{I32,I64} co-exist with Atomic<T>.
> > > What's the downside? A bit specific example would help me understand
> > > the real concern here.
> > 
> > Err, what?
> > 
> > Of course we want generic atomics, and we need that for properly
> > supporting cmpxchg.
> > 
> 
> Nope. Note this series only introduces the atomic types (atomic_ C
> APIs), but cmpxchg C APIs (no atomic_ prefix) are probably presented via
> a different API, where we need to make it easier to interact with normal
> types, and we may use generic there.
> 
> > Bogun, you've got all the rust guys pushing for doing this with
> > generics, I'm not sure why you're being stubborn here?
> 
> Hmm? Have you seen the email I replied to John, a broader Rust community
> seems doesn't appreciate the idea of generic atomics.

Apologies, I appear to have gotten things backwards in my pre-coffee
reading, I'll have to catch up on the whole thread :)

