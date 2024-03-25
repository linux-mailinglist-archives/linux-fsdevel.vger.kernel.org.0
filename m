Return-Path: <linux-fsdevel+bounces-15263-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EEEE88B385
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 23:09:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B15C1F63799
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 22:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4418C73174;
	Mon, 25 Mar 2024 22:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="b+sCf2Jf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D8371756
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Mar 2024 22:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711404570; cv=none; b=Clp0DF9p3sAueD+54WKE31zdektBfLrw3Z6G+/+LnouMgR4rXv8580dEw994Bspn0wk02C918dHGz1Tl0aLaHtAAUJWtlwpzPVAJQpMXvCgAVLyFvG+qju6uOx7XxHAfPecDRbHUcfzth/UY3mpj08+AfPN1xo0jt8MLCprHsnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711404570; c=relaxed/simple;
	bh=fW2hIWHhR41/L1F+bpZzRKnNxDSzchbJIxBCkq7SfGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GHp+gm6xIIIRW4aCOuXIJ4vtBPP/uiOEOa5Rvr503Z+SX7Gj4hr1fXfsF49tNFitM1Lqy6Qx+2yg/q4b0fcnrjB5qJ0W8RWsClsVlMqJlfrjsET86P1d1dQhKLjaYIwn4jTvWqgS2//0X7kd6qO9x5Nyq/NdUbpstAr3paNcBng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=b+sCf2Jf; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 25 Mar 2024 18:09:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711404566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=afGy8CRECdAELjgTa63PphAb8Je/7LgfWp/vpSHkqks=;
	b=b+sCf2JfZ1bUx+SgaAuv492wBmpuur/6BjEMdbR9Z4ZCD4+uG7E/QItW3rmDr4vs7AeTLM
	Xi1XoeDaJNa86zHWG0ZtX4cQdV1EpkxCGd1xKdkCh2oT+rvTG85ldwxSNrlBGl947PDi2s
	eNzsKmqELeZnnjPlz9lpgr/m4xIcqSQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Philipp Stanner <pstanner@redhat.com>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
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
Message-ID: <jyijwrrzzhlsrffj37xj4sskipxqbxfewydnb3yzgybjobj6tg@cbv5y7znhm3n>
References: <s2jeqq22n5ef5jknaps37mfdjvuqrns4w7i22qp2r7r4bzjqs2@my3eyxoa3pl3>
 <CAHk-=whY5A=S=bLwCFL=043DoR0TTgSDUmfPDx2rXhkk3KANPQ@mail.gmail.com>
 <u2suttqa4c423q4ojehbucaxsm6wguqtgouj7vudp55jmuivq3@okzfgryarwnv>
 <CAHk-=whkQk=zq5XiMcaU3xj4v69+jyoP-y6Sywhq-TvxSSvfEA@mail.gmail.com>
 <c51227c9a4103ad1de43fc3cda5396b1196c31d7.camel@redhat.com>
 <CAHk-=wjP1i014DGPKTsAC6TpByC3xeNHDjVA4E4gsnzUgJBYBQ@mail.gmail.com>
 <bu3seu56hfozsvgpdqjarbdkqo3lsjfc4lhluk5oj456xmrjc7@lfbbjxuf4rpv>
 <CAHk-=wgLGWBXvNODAkzkVHEj7zrrnTq_hzMft62nKNkaL89ZGQ@mail.gmail.com>
 <gewmacbbjxwsn4h54w2jfvbiq5iwr2zdm56pc3pv3rctxyd4lt@sqqa544ezmez>
 <ZgHuioMM1cAWNDiX@boqun-archlinux>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZgHuioMM1cAWNDiX@boqun-archlinux>
X-Migadu-Flow: FLOW_OUT

On Mon, Mar 25, 2024 at 02:37:14PM -0700, Boqun Feng wrote:
> On Mon, Mar 25, 2024 at 05:14:41PM -0400, Kent Overstreet wrote:
> > On Mon, Mar 25, 2024 at 12:44:34PM -0700, Linus Torvalds wrote:
> > > On Mon, 25 Mar 2024 at 11:59, Kent Overstreet <kent.overstreet@linux.dev> wrote:
> > > >
> > > > To be fair, "volatile" dates from an era when we didn't have the haziest
> > > > understanding of what a working memory model for C would look like or
> > > > why we'd even want one.
> > > 
> > > I don't disagree, but I find it very depressing that now that we *do*
> > > know about memory models etc, the C++ memory model basically doubled
> > > down on the same "object" model.
> > > 
> > > > The way the kernel uses volatile in e.g. READ_ONCE() is fully in line
> > > > with modern thinking, just done with the tools available at the time. A
> > > > more modern version would be just
> > > >
> > > > __atomic_load_n(ptr, __ATOMIC_RELAXED)
> 
> Note that Rust does have something similiar:
> 
> 	https://doc.rust-lang.org/std/ptr/fn.read_volatile.html
> 
> 	pub unsafe fn read_volatile<T>(src: *const T) -> T
> 
> (and also write_volatile()). So they made a good design putting the
> volatile on the accesses rather than the type. However, per the current
> Rust memory model these two primitives will be UB when data races happen
> :-(
> 
> I mean, sure, if I use read_volatile() on an enum (whose valid values
> are only 0, 1, 2), and I get a value 3, and the compiler says "you have
> a logic bug and I refuse to compile the program correctly", I'm OK. But
> if I use read_volatile() to read something like a u32, and I know it's
> racy so my program actually handle that, I don't know any sane compiler
> would miss-compile, so I don't know why that has to be a UB.

Well, if T is too big to read/write atomically then you'll get torn
reads, including potentially a bit representation that is not a valid T.

Which is why the normal read_volatile<> or Volatile<> should disallow
that.

> > where T is any type that fits in a machine word, and the only operations
> > it supports are get(), set(), xchg() and cmpxchG().
> > 
> > You DO NOT want it to be possible to transparantly use Volatile<T> in
> > place of a regular T - in exactly the same way as an atomic_t can't be
> > used in place of a regular integer.
> 
> Yes, this is useful. But no it's not that useful, how could you use that
> to read another CPU's stack during some debug functions in a way you
> know it's racy?

That's a pretty difficult thing to do, because you don't know the
_layout_ of the other CPU's stack, and even if you do it's going to be
changing underneath you without locking.

So the races thare are equivalent to a bad mem::transmute(), and that is
very much UB.

For a more typical usage of volatile, consider a ringbuffer with one
thread producing and another thread consuming. Then you've got head and
tail pointers, each written by one thread and read by another.

You don't need any locking, just memory barriers and
READ_ONCE()/WRITE_ONCE() to update the head and tail pointers. If you
were writing this in Rust today the easy way would be an atomic integer,
but that's not really correct - you're not doing atomic operations
(locked arithmetic), just volatile reads and writes.

Volatile<T> would be Send and Sync, just like atomic integers. You don't
need locking if you're just working with single values that are small
enough for the machine to read/write atomically.

