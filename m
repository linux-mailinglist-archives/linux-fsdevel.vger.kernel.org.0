Return-Path: <linux-fsdevel+bounces-15148-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A0EE887690
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Mar 2024 03:07:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E49F61F22940
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Mar 2024 02:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58EF33F6;
	Sat, 23 Mar 2024 02:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="V/reHql5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775A7EC2;
	Sat, 23 Mar 2024 02:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711159663; cv=none; b=XxYoEBitjH9cBd95xA1kizSs58byq6nlBiAiSBFq7Ynb716a9WveAymkAY61qeMvEYNXMiOpaeWL8AC1+jTMRAgU1fooAiCwxDRMKgIUBNMBsXqgb1n0t7l/iKaCdq9x5Q2/E3Zty2DChuOs4Ed0tQ8HZ8uZz+ezwZCuG9OK6Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711159663; c=relaxed/simple;
	bh=8GsXswQNH/fqxcYIQ/3ggaBwPgXRrvOcvLwU+gyR6g4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oBxmT8TUftTYUAdb8JBbGrMRN6oKEZIZ3A43hT5LYZ9wVQ0V/V7XiP0IcQpZ4dypo1VbQCq6p7BeIo2OsPBhl80lmvfPBjgSBGjxf672KdKyly/ZhZnvaztarzKQdU/AbzTtrN7w7+g4jN69hvN2DEk0n5cnMWaTrouJebue8Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=V/reHql5; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 22 Mar 2024 22:07:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711159659;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ki2SqS4TDwK1+oUGgKMCMnFI/a9KHGHslLmG6vAgHw8=;
	b=V/reHql5hOMS9gGdH79dzncDq6IdjoyZaApKWlC7cZ6OzX8l7LjRUbkts5M8RXXkuqXjV3
	WyBun2puVO2pPSWekIesncvzcBvPaB2xEP+uyoKDGs2Khwkpocb7aoPvftDTHFQ9dBpOYJ
	wktB04MA4OATeTiHsnGdycZwKQqlRdg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, llvm@lists.linux.dev, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
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
	Catalin Marinas <catalin.marinas@arm.com>, linux-arm-kernel@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [WIP 0/3] Memory model and atomic API in Rust
Message-ID: <3modld2dafaqjxa2b7jln47ws4ylzhbsvhvnphoklwvzange5p@wlir7276aitp>
References: <20240322233838.868874-1-boqun.feng@gmail.com>
 <s2jeqq22n5ef5jknaps37mfdjvuqrns4w7i22qp2r7r4bzjqs2@my3eyxoa3pl3>
 <CAHk-=whY5A=S=bLwCFL=043DoR0TTgSDUmfPDx2rXhkk3KANPQ@mail.gmail.com>
 <u2suttqa4c423q4ojehbucaxsm6wguqtgouj7vudp55jmuivq3@okzfgryarwnv>
 <CAHk-=whkQk=zq5XiMcaU3xj4v69+jyoP-y6Sywhq-TvxSSvfEA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whkQk=zq5XiMcaU3xj4v69+jyoP-y6Sywhq-TvxSSvfEA@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Mar 22, 2024 at 05:36:00PM -0700, Linus Torvalds wrote:
> On Fri, 22 Mar 2024 at 17:21, Kent Overstreet <kent.overstreet@linux.dev> wrote:
> >
> > Besides that there's cross arch support to think about - it's hard to
> > imagine us ever ditching our own atomics.
> 
> Well, that's one of the advantages of using compiler builtins -
> projects that do want cross-architecture support, but that aren't
> actually maintaining their _own_ architecture support.
> 
> So I very much see the lure of compiler support for that kind of
> situation - to write portable code without having to know or care
> about architecture details.
> 
> This is one reason I think the kernel is kind of odd and special -
> because in the kernel, we obviously very fundamentally have to care
> about the architecture details _anyway_, so then having the
> architecture also define things like atomics is just a pretty small
> (and relatively straightforward) detail.
> 
> The same argument goes for compiler builtins vs inline asm. In the
> kernel, we have to have people who are intimately familiar with the
> architecture _anyway_, so inline asms and architecture-specific header
> files aren't some big pain-point: they'd be needed _anyway_.
> 
> But in some random user level program, where all you want is an
> efficient way to do "find first bit"? Then using a compiler intrinsic
> makes a lot more sense.

We've got a whole spectrum of kernel code though, and a lot of it is
code that - honestly, we'd be better off if it wasn't specific to the
kernel.

rhashtable comes to mind; it's a fully generic, excellent at what it
does, but it's had a number of annoyingly subtle bugs and sharp edges
over the years that are really just a result of it not having enough
users.

So I see some real value in regularizing things.

> > I was thinking about something more incremental - just an optional mode
> > where our atomics were C atomics underneath. It'd probably give the
> > compiler people a much more effective way to test their stuff than
> > anything they have now.
> 
> I suspect it might be painful, and some compiler people would throw
> their hands up in horror, because the C++ atomics model is based
> fairly solidly on atomic types, and the kernel memory model is much
> more fluid.
> 
> Boqun already mentioned the "mixing access sizes", which is actually
> quite fundamental in the kernel, where we play lots of games with that
> (typically around locking, where you find patterns line unlock writing
> a zero to a single byte, even though the whole lock data structure is
> a word). And sometimes the access size games are very explicit (eg
> lib/lockref.c).

I don't think mixing access sizes should be a real barrier. On the read
side we can obviously do that with a helper; the write side needs
compiler help, but "writing just a byte out of a word" is no different
from a compiler POV that "write a single bit", and we can already mix
atomic_or() with atomic_add(), with both C atomics and LKMM atomics.

> But it actually goes deeper than that. While we do have "atomic_t" etc
> for arithmetic atomics, and that probably would map fairly well to C++
> atomics, in other cases we simply base our atomics not on _types_, but
> on code.
> 
> IOW, we do things like "cmpxchg()", and the target of that atomic
> access is just a regular data structure field.

Well, some of that's historical cruft; cmpxchg() and atomic_cmpxchg()
have different orderings, and we can specify that more directly now.

But we definitely need the ability to cmpxchg() any struct of a size the
machine supports atomic access to. Rust should be able to manage that
more easily than C/C++ though - they've got a type system that can
sanely represent that.

