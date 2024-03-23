Return-Path: <linux-fsdevel+bounces-15154-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E8C88770D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Mar 2024 05:16:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE1001C2303C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Mar 2024 04:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411AF7465;
	Sat, 23 Mar 2024 04:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IDRcUmdN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5979D46A0
	for <linux-fsdevel@vger.kernel.org>; Sat, 23 Mar 2024 04:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711167380; cv=none; b=Xuhe2SxsjH6p2wSax5IZmiBifFgkW6xdd1wba+NQ39Bd5jaSS9WS+1XmHmYT/6lHG23g+3AGF1VXIkBHT5XvX8hr9Bky56d/1dYHAvezI1RIyvuoQpyem+oR5h+xqRmC+QorqAr7cPr3AG1Q1Geh5Hk9X47Qw1Z0axRGy1Qmmug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711167380; c=relaxed/simple;
	bh=oQwQPzepAo9xty2ZLMz/v4lfOpbZlyrOY1++1B41TBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TJ9BchIehzRCvY+/ilSPbQd38zvUJsUho+aPf25io5+3PSfA67PoRWCDsPquY+cmzcS0ch3NEChWR2vziiCeTUVSNUYxs5m3rgSwO2pMgRd9eup0bPTWterlah7/51mmz97EYkEO5lZvqgAl8rp+03Z8pKus7kn+S87XgQ0Ajqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IDRcUmdN; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 23 Mar 2024 00:16:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711167376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y0TVAH0ZYdb3ue+80a0C1DdjCsmM6e0n7TfPjNRdLqQ=;
	b=IDRcUmdN8orWoZ4O6XUTc0cdl71Ze4mloh1oBhIoF0zrSqXDQomr/bG5vKi/fR9JnYYoPv
	Rk4vAube+jtJ/qUZcGEgFwatJoO7CRYtry2xosgiRsPu5tsnK4eT43YGs2Jtd3JyJTAPfP
	E9PqylE35oFyzjlsZnYy+uumLQPen6A=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
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
Message-ID: <4ciizx33vzooa33ikjn7env6kvkpcv44dsawm4i2avqou2kdk4@b4hj6252l22l>
References: <s2jeqq22n5ef5jknaps37mfdjvuqrns4w7i22qp2r7r4bzjqs2@my3eyxoa3pl3>
 <CAHk-=whY5A=S=bLwCFL=043DoR0TTgSDUmfPDx2rXhkk3KANPQ@mail.gmail.com>
 <u2suttqa4c423q4ojehbucaxsm6wguqtgouj7vudp55jmuivq3@okzfgryarwnv>
 <CAHk-=whkQk=zq5XiMcaU3xj4v69+jyoP-y6Sywhq-TvxSSvfEA@mail.gmail.com>
 <3modld2dafaqjxa2b7jln47ws4ylzhbsvhvnphoklwvzange5p@wlir7276aitp>
 <Zf491DuptReGqvfd@Boquns-Mac-mini.home>
 <34r4signulvsclmsiqgghskmj5xce3zs5hwgfulzaez2wdyklr@ck6zrj732c4m>
 <Zf5FEFCfuy0TAjV6@Boquns-Mac-mini.home>
 <qsw2v5ikt2w6m2xfr6h4e2xauobhy37nrskarlfjro4ek4qw4b@jgxhav7bia55>
 <Zf5Rp0zR_fyZMADn@Boquns-Mac-mini.home>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zf5Rp0zR_fyZMADn@Boquns-Mac-mini.home>
X-Migadu-Flow: FLOW_OUT

On Fri, Mar 22, 2024 at 08:51:03PM -0700, Boqun Feng wrote:
> On Fri, Mar 22, 2024 at 11:10:36PM -0400, Kent Overstreet wrote:
> > On Fri, Mar 22, 2024 at 07:57:20PM -0700, Boqun Feng wrote:
> > > On Fri, Mar 22, 2024 at 10:33:13PM -0400, Kent Overstreet wrote:
> > > > On Fri, Mar 22, 2024 at 07:26:28PM -0700, Boqun Feng wrote:
> > > > > On Fri, Mar 22, 2024 at 10:07:31PM -0400, Kent Overstreet wrote:
> > > > > [...]
> > > > > > > Boqun already mentioned the "mixing access sizes", which is actually
> > > > > > > quite fundamental in the kernel, where we play lots of games with that
> > > > > > > (typically around locking, where you find patterns line unlock writing
> > > > > > > a zero to a single byte, even though the whole lock data structure is
> > > > > > > a word). And sometimes the access size games are very explicit (eg
> > > > > > > lib/lockref.c).
> > > > > > 
> > > > > > I don't think mixing access sizes should be a real barrier. On the read
> > > > > 
> > > > > Well, it actually is, since mixing access sizes is, guess what,
> > > > > an undefined behavior:
> > > > > 
> > > > > (example in https://doc.rust-lang.org/std/sync/atomic/#memory-model-for-atomic-accesses)
> > > > > 
> > > > > 	thread::scope(|s| {
> > > > > 	    // This is UB: using different-sized atomic accesses to the same data
> > > > > 	    s.spawn(|| atomic.store(1, Ordering::Relaxed));
> > > > > 	    s.spawn(|| unsafe {
> > > > > 		let differently_sized = transmute::<&AtomicU16, &AtomicU8>(&atomic);
> > > > > 		differently_sized.store(2, Ordering::Relaxed);
> > > > > 	    });
> > > > > 	});
> > > > > 
> > > > > Of course, you can say "I will just ignore the UB", but if you have to
> > > > > ignore "compiler rules" to make your code work, why bother use compiler
> > > > > builtin in the first place? Being UB means they are NOT guaranteed to
> > > > > work.
> > > > 
> > > > That's not what I'm proposing - you'd need additional compiler support.
> > > 
> > > Ah, OK.
> > > 
> > > > but the new intrinsic would be no different, semantics wise for the
> > > > compiler to model, than a "lock orb".
> > > 
> > > Be ready to be disappointed:
> > > 
> > > 	https://rust-lang.zulipchat.com/#narrow/stream/136281-t-opsem/topic/is.20atomic.20aliasing.20allowed.3F/near/402078545
> > > 	https://rust-lang.zulipchat.com/#narrow/stream/136281-t-opsem/topic/is.20atomic.20aliasing.20allowed.3F/near/402082631
> > > 
> > > ;-)
> > > 
> > > In fact, if you get a chance to read the previous discussion links I
> > > shared, you will find I was just like you in the beginning: hope we
> > > could extend the model to support more kernel code properly. But my
> > > overall feeling is that it's either very challenging or lack of
> > > motivation to do.
> > 
> > That's casting - that doesn't work because compiler people hate
> > aliasing.
> > 
> > But intrinsics for e.g.
> > __atomic32_read_u8(atomic_u32_t *a, unsigned byte)
> > __atomic32_write_u8(atomic_u32_t a*, unsigned byte)
> > 
> 
> so "byte" here is the byte indexing in the u32? Hmm... I guess that'll
> work. But I really don't know whether LLVM/Rust will support such an
> intrinsic...

They're going to need this eventually - really, entire structs that can
be marked as atomic. Types aren't limited to the integers.

