Return-Path: <linux-fsdevel+bounces-15150-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B8A8876A8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Mar 2024 03:33:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 891B31F22D42
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Mar 2024 02:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8863B211C;
	Sat, 23 Mar 2024 02:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xmoGr6Zy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1804D38F;
	Sat, 23 Mar 2024 02:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711161206; cv=none; b=WZKr4nSj/Wz8VPfEsN/+EP1P4+2tv3RzIiwz2lal4qhvHx0/X5WvBl0G9gOQYpVAW17a0bcJRdE8q5c5Uccy9Ukm+yJZ6RytWHFYZLmQq1TmqhgLNTGdMCoNuVtGwuXYYZIcC6ke1MH6V0v95DQUbBRzJR0nPOcpEHZ3BbuAseo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711161206; c=relaxed/simple;
	bh=34TWMNT6M0hd6HGrpS/KoKUmis1d5YNlXoP1KScGnUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H1vO5+7Xb6f5pvabhx6jorOkJHuomKDTTIjJXjW+Ht12/mP1yLuKs1NGgaXvF86/LJiK7hNLDzgiION1eWPlSt4tg8SwRxgQ4SdSIZReolsXP8RYPTf5TxgtUQy3JPNebXdLH0sRgc9ZsQ10TI+K1nrbuFAQa8LxZvuRR8xRIwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xmoGr6Zy; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 22 Mar 2024 22:33:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711161201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dGiRxMGRKYQMRfH49RA51pj9cBv1uQC8JISxFiAALsM=;
	b=xmoGr6ZyTaRZLl83NHpBYA88BVWCxbSMGBYrs8r5D714hM3UEvZXAUpBN3vIJm8tmz2GLr
	T3y58i66roDsXvtXdR2y13/D9BngQutwTbLlD6Y7Fb0fVnuUokJb9XyJX0jEMID9lYp3ph
	8gUcfF+qotI0cy/V3ReJqUXnsbltt9U=
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
Message-ID: <34r4signulvsclmsiqgghskmj5xce3zs5hwgfulzaez2wdyklr@ck6zrj732c4m>
References: <20240322233838.868874-1-boqun.feng@gmail.com>
 <s2jeqq22n5ef5jknaps37mfdjvuqrns4w7i22qp2r7r4bzjqs2@my3eyxoa3pl3>
 <CAHk-=whY5A=S=bLwCFL=043DoR0TTgSDUmfPDx2rXhkk3KANPQ@mail.gmail.com>
 <u2suttqa4c423q4ojehbucaxsm6wguqtgouj7vudp55jmuivq3@okzfgryarwnv>
 <CAHk-=whkQk=zq5XiMcaU3xj4v69+jyoP-y6Sywhq-TvxSSvfEA@mail.gmail.com>
 <3modld2dafaqjxa2b7jln47ws4ylzhbsvhvnphoklwvzange5p@wlir7276aitp>
 <Zf491DuptReGqvfd@Boquns-Mac-mini.home>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zf491DuptReGqvfd@Boquns-Mac-mini.home>
X-Migadu-Flow: FLOW_OUT

On Fri, Mar 22, 2024 at 07:26:28PM -0700, Boqun Feng wrote:
> On Fri, Mar 22, 2024 at 10:07:31PM -0400, Kent Overstreet wrote:
> [...]
> > > Boqun already mentioned the "mixing access sizes", which is actually
> > > quite fundamental in the kernel, where we play lots of games with that
> > > (typically around locking, where you find patterns line unlock writing
> > > a zero to a single byte, even though the whole lock data structure is
> > > a word). And sometimes the access size games are very explicit (eg
> > > lib/lockref.c).
> > 
> > I don't think mixing access sizes should be a real barrier. On the read
> 
> Well, it actually is, since mixing access sizes is, guess what,
> an undefined behavior:
> 
> (example in https://doc.rust-lang.org/std/sync/atomic/#memory-model-for-atomic-accesses)
> 
> 	thread::scope(|s| {
> 	    // This is UB: using different-sized atomic accesses to the same data
> 	    s.spawn(|| atomic.store(1, Ordering::Relaxed));
> 	    s.spawn(|| unsafe {
> 		let differently_sized = transmute::<&AtomicU16, &AtomicU8>(&atomic);
> 		differently_sized.store(2, Ordering::Relaxed);
> 	    });
> 	});
> 
> Of course, you can say "I will just ignore the UB", but if you have to
> ignore "compiler rules" to make your code work, why bother use compiler
> builtin in the first place? Being UB means they are NOT guaranteed to
> work.

That's not what I'm proposing - you'd need additional compiler support.
but the new intrinsic would be no different, semantics wise for the
compiler to model, than a "lock orb".

