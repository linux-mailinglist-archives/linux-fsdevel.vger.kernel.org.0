Return-Path: <linux-fsdevel+bounces-15267-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8169388B635
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 01:37:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C1FB2E7D19
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 00:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A4BE1BC30;
	Tue, 26 Mar 2024 00:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NLb9kon9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1E918C3B
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 Mar 2024 00:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711413432; cv=none; b=h1ZPmExBHXljurmRUeiKBIeoU6rInQsOeJDvK0RhwybaLgkS+7+M5mS9KP0fJBaiFfaevAKUF0QKSGItq27W37r4uQMVejhxk7X9r9xP5EpEwNCVuTvym6yOsjHYKaVPSkLSxnUKR62Tw+wTx4jAtTyRkY7qDHCwbIQs5MVgM/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711413432; c=relaxed/simple;
	bh=ESqWTQ+HRZyQ87yUo/GTNFE0cDkeMSEhIHwbnTdrt8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q287/xLTHPrfqIlofZikinUt3o//pWL463OwiS25ghCDKdMGMGTLcKpQRL/M1T5fHGADsld68T6BDnrcYAMNv5xbu1IE47wHbkAyIDnYsY70pYk2nM8HGtGeqiH1w3QxCXxVTiKgvOjWG4i6b/klZh9cnsBeogpjOvt1+mIn808=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NLb9kon9; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 25 Mar 2024 20:36:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711413427;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K7/P1e12pVDFD60cFU8dr+GfEYW0gad9J1o/dhSRroU=;
	b=NLb9kon9YXeMPqajYlhJHM/8psRsNlhfBLdL0kTxa+vUMeGImlECNyeyGq09Ue5Wcutxh6
	kuHWyImi7GVqgD5GJuuGKm6U0F/3s9oQzoXGdf5FuRJtzoDtacMjGzA5sI9ReSSU6cClND
	6KC01NNpfxLWl6Prlf+9TF2C4TQVtpA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: "Dr. David Alan Gilbert" <dave@treblig.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Philipp Stanner <pstanner@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	llvm@lists.linux.dev, Miguel Ojeda <ojeda@kernel.org>, 
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
Message-ID: <vevxfv67ureybf7sjwfxzdvl4tt62khyn2gfzn7o74ke2m554s@xxddzz6nurbn>
References: <20240322233838.868874-1-boqun.feng@gmail.com>
 <s2jeqq22n5ef5jknaps37mfdjvuqrns4w7i22qp2r7r4bzjqs2@my3eyxoa3pl3>
 <CAHk-=whY5A=S=bLwCFL=043DoR0TTgSDUmfPDx2rXhkk3KANPQ@mail.gmail.com>
 <u2suttqa4c423q4ojehbucaxsm6wguqtgouj7vudp55jmuivq3@okzfgryarwnv>
 <CAHk-=whkQk=zq5XiMcaU3xj4v69+jyoP-y6Sywhq-TvxSSvfEA@mail.gmail.com>
 <c51227c9a4103ad1de43fc3cda5396b1196c31d7.camel@redhat.com>
 <CAHk-=wjP1i014DGPKTsAC6TpByC3xeNHDjVA4E4gsnzUgJBYBQ@mail.gmail.com>
 <bu3seu56hfozsvgpdqjarbdkqo3lsjfc4lhluk5oj456xmrjc7@lfbbjxuf4rpv>
 <CAHk-=wgLGWBXvNODAkzkVHEj7zrrnTq_hzMft62nKNkaL89ZGQ@mail.gmail.com>
 <ZgIRXL5YM2AwBD0Y@gallifrey>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZgIRXL5YM2AwBD0Y@gallifrey>
X-Migadu-Flow: FLOW_OUT

On Tue, Mar 26, 2024 at 12:05:48AM +0000, Dr. David Alan Gilbert wrote:
> * Linus Torvalds (torvalds@linux-foundation.org) wrote:
> 
> <snip>
> 
> > IOW, the whole access size problem that Boqun described is
> > *inherently* tied to the fact that the C++ and Rust memory model is
> > badly designed from the wrong principles.
> > 
> > Instead of designing it as a "this is an atomic object that you can do
> > these operations on", it should have been "this is an atomic access,
> > and you can use this simple object model to have the compiler generate
> > the accesses for you".
> 
> Isn't one of the aims of the Rust/C++ idea that you can't forget to access
> a shared piece of data atomically?
> 
> If you want to have 'atomic accesses' explicitly, how do you tell the compiler
> what you can use them on, and when it should stop you mixing them with
> normal accesses on the same object?

"can't forget to access data atomically" - that's only half of it. And
atomic accesses loads/stores are not a thing under the hood, they're
just loads and stores (possibly, but not necessarily, with memory
barriers).

The other half is at the _source_ level you don't want to treat accesses
to volatiles/atomics like accesses to normal variables, you really want
those to be explicit, and not look like normal variable accesses.

std:atomic_int is way better than volatile in the sense that it's not a
barely specified mess, but adding operator overloading was just
gratuitious and unnecessary.

This is a theme with C++ - they add a _ton_ of magic to make things
concise and pretty, but you have to understand in intimate detail what
all that magic is doing or you're totally fucked.

std::atomic_int makes it such that just changing a single line of code
in a single location in your program will change the semantics of your
_entire_ program and the only obserable result will be that it's faster
but a ticking time bomb because you just introduced a ton of races.

With Rust - I honestly haven't looked at whether they added operator
overlaoding for their atomics, but it's _much_ less of a concern because
changing the type to the non-atomic version means your program won't
compile if it's now racy.

