Return-Path: <linux-fsdevel+bounces-15259-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B46288B272
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 22:15:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1CB31C63658
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 21:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F5A6D1AE;
	Mon, 25 Mar 2024 21:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uiEgXaX1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0925B669
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Mar 2024 21:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711401292; cv=none; b=W0eVMqdIv0SgebgRIuWZB+D10Zv6kCTKMHeNEUHhr63YSYH7AgvZhL4ASi3r6ThR5VW338Hr6WMH8+P1GbNLoMTDswZbY2zY/0PMlEeGh9RodVL4CM+FH4BTJ2ItmepiamDOvzix/8KFCe9bsd9TpXvd3+pOHKy4dPrUcRRi82M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711401292; c=relaxed/simple;
	bh=W1hWRjm3jNJ351RXmnzHe0zzrwx7OW190ghWMHNY1Mw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UYJL6Hca8a7AG5fntF7lKP47EwF7DrvnXIKjgJaroX3VenabH0hw8uivnD4PuKoPkZZIOXkoqQrovRW/nHzIzwYdTQk4t9Wfkfj9JnKyB/PTJGjHgj4J3UbDwFWah5CVrROUMBAriZMeTjkVYqyVrbO+NfdqYO59a4s/FFuGvDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uiEgXaX1; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 25 Mar 2024 17:14:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711401287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=llHHasdPTnE564yAWRIEDlb7QeNB14A4Flfy8lgEg5U=;
	b=uiEgXaX1EP5tHiPl9/JxgOTwnEkgEqLTkBqdn1FGdGdStYBsEYrfnHyG72l2Ygm0omugkq
	hspjjqtAH5hNoEQrqWg0Akg1oKhMqTHMnJCEQrJ5aIv4gYjmjaqTT2aN19dl9XREDZdahI
	RBHeMDIwoVU+fqu2uBvmz9Gzn2npmts=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Philipp Stanner <pstanner@redhat.com>, 
	Boqun Feng <boqun.feng@gmail.com>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, llvm@lists.linux.dev, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, Alan Stern <stern@rowland.harvard.edu>, 
	Andrea Parri <parri.andrea@gmail.com>, Will Deacon <will@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Nicholas Piggin <npiggin@gmail.com>, 
	David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, 
	Luc Maranget <luc.maranget@inria.fr>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Akira Yokosawa <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, kent.overstreet@gmail.com, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, elver@google.com, Mark Rutland <mark.rutland@arm.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, linux-arm-kernel@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [WIP 0/3] Memory model and atomic API in Rust
Message-ID: <gewmacbbjxwsn4h54w2jfvbiq5iwr2zdm56pc3pv3rctxyd4lt@sqqa544ezmez>
References: <20240322233838.868874-1-boqun.feng@gmail.com>
 <s2jeqq22n5ef5jknaps37mfdjvuqrns4w7i22qp2r7r4bzjqs2@my3eyxoa3pl3>
 <CAHk-=whY5A=S=bLwCFL=043DoR0TTgSDUmfPDx2rXhkk3KANPQ@mail.gmail.com>
 <u2suttqa4c423q4ojehbucaxsm6wguqtgouj7vudp55jmuivq3@okzfgryarwnv>
 <CAHk-=whkQk=zq5XiMcaU3xj4v69+jyoP-y6Sywhq-TvxSSvfEA@mail.gmail.com>
 <c51227c9a4103ad1de43fc3cda5396b1196c31d7.camel@redhat.com>
 <CAHk-=wjP1i014DGPKTsAC6TpByC3xeNHDjVA4E4gsnzUgJBYBQ@mail.gmail.com>
 <bu3seu56hfozsvgpdqjarbdkqo3lsjfc4lhluk5oj456xmrjc7@lfbbjxuf4rpv>
 <CAHk-=wgLGWBXvNODAkzkVHEj7zrrnTq_hzMft62nKNkaL89ZGQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgLGWBXvNODAkzkVHEj7zrrnTq_hzMft62nKNkaL89ZGQ@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Mar 25, 2024 at 12:44:34PM -0700, Linus Torvalds wrote:
> On Mon, 25 Mar 2024 at 11:59, Kent Overstreet <kent.overstreet@linux.dev> wrote:
> >
> > To be fair, "volatile" dates from an era when we didn't have the haziest
> > understanding of what a working memory model for C would look like or
> > why we'd even want one.
> 
> I don't disagree, but I find it very depressing that now that we *do*
> know about memory models etc, the C++ memory model basically doubled
> down on the same "object" model.
> 
> > The way the kernel uses volatile in e.g. READ_ONCE() is fully in line
> > with modern thinking, just done with the tools available at the time. A
> > more modern version would be just
> >
> > __atomic_load_n(ptr, __ATOMIC_RELAXED)
> 
> Yes. Again, that's the *right* model in many ways, where you mark the
> *access*, not the variable. You make it completely and utterly clear
> that this is a very explicit access to memory.
> 
> But that's not what C++ actually did. They went down the same old
> "volatile object" road, and instead of marking the access, they mark
> the object, and the way you do the above is
> 
>     std::atomic_int value;
> 
> and then you just access 'value' and magic happens.
> 
> EXACTLY the same way that
> 
>    volatile int value;
> 
> works, in other words. With exactly the same downsides.

Yeah that's crap. Unfortunate too, because this does need to be a type
system thing and we have all the tools to do it correctly now.

What we need is for loads and stores to be explict, and that absolutely
can and should be a type system thing.

In Rust terminology, what we want is

  Volatile<T>

where T is any type that fits in a machine word, and the only operations
it supports are get(), set(), xchg() and cmpxchG().

You DO NOT want it to be possible to transparantly use Volatile<T> in
place of a regular T - in exactly the same way as an atomic_t can't be
used in place of a regular integer.

