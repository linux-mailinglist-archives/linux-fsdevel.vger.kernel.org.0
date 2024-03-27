Return-Path: <linux-fsdevel+bounces-15486-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6802488F344
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 00:36:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C74D1F2EB68
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Mar 2024 23:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F831552FC;
	Wed, 27 Mar 2024 23:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="M3TFh9ja"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A8515445B
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Mar 2024 23:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711582551; cv=none; b=ezOjsMKiPLnNp4i06aqz1GLmXTIfHgJ9qG7cbt68t3NCHeajvd9aJaoADdHXDod8VAvYm4L0MtPq44z5jEOGCZvGAHV7+3WWmFO/PC2WHScJvp1dMM8nu+Wug8kV5zOP1bwBQjA2Va3LEcYqwZD/w9gyNp4GpT4vrgjua5v1FEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711582551; c=relaxed/simple;
	bh=xkBP270Wrqe98MexcD6HIuIpMWYJMnbzhP17BG8Q2Gg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WzybVZLBmWJVOf+diA/rwvVpmri8gg0/i6H8N36AYnuUDuSdvi8ONXPXjYgq/VwGI2Qv+bPs4aDaRf2DpsQixZuKfxSEkmJscYTo2Y8l1pnUmzx6D2/SHemdYMJypDPxJkYSuM91jRh7wIWiw9vsmcQnnJJ9GAj1792fmK5k0gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=M3TFh9ja; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 27 Mar 2024 19:35:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711582546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kyr6r49yidhJsKUTui64nFbL4DNm+avYdIXieZOZcaY=;
	b=M3TFh9jarTrlSwg1Hd3LxsdCADhyi15sAjIQfsgPibimB3Mn0Yknm2azjPx6C7aHaqZTGL
	ZJMH9Jrg+Q6GKan/n0ZlVVYLJ7zpnOCcaFNhoOQ1yaOjCGmXDGDr5O7JgvSsX+WyCPznk5
	l6Nt7HD73IpgAwSW/TCOe9wu08NDBf4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: comex <comexk@gmail.com>, "Dr. David Alan Gilbert" <dave@treblig.org>, 
	Philipp Stanner <pstanner@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
	rust-for-linux <rust-for-linux@vger.kernel.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
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
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marco Elver <elver@google.com>, 
	Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, linux-arm-kernel@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [WIP 0/3] Memory model and atomic API in Rust
Message-ID: <4tyipncgbrl5yidulxcsobk6pq5jl3dvzkqtckrqjldqpsh6bm@q5xeyqz5j2to>
References: <CAHk-=wgLGWBXvNODAkzkVHEj7zrrnTq_hzMft62nKNkaL89ZGQ@mail.gmail.com>
 <ZgIRXL5YM2AwBD0Y@gallifrey>
 <CAHk-=wjwxKD9CxYsf5x+K5fJbJa_JYZh1eKB4PT5cZJq1+foGw@mail.gmail.com>
 <160DB953-1588-418E-A490-381009CD8DE0@gmail.com>
 <qyjrex54hbhvhw4gmn7b6l2hr45o56bwt6fazfalykwcp5zzkx@vwt7k3d6kdwt>
 <CAHk-=wgQy+FRKjO_BvZgZN56w6-+jDO8p-Mt=X=zM70CG=CVBQ@mail.gmail.com>
 <bjorlxatlpzjlh6dfulham3u4mqsfqt7ir5wtayacaoefr2r7x@lmfcqzcobl3f>
 <CAHk-=wiSiNtf4Z=Bvfs=sGJn6SYCZ=F7hvWwsQiOX4=V0Bgp_Q@mail.gmail.com>
 <psy7q3fbnjeyk7fu6wyfecpvgsaxel5vcc6cudftxgyvj4zuhf@3xhjikjjy5pn>
 <CAHk-=wgjpos9wLwxgoUwp10C70DuOSGbC3uZiPp8ufEvM-bNtQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgjpos9wLwxgoUwp10C70DuOSGbC3uZiPp8ufEvM-bNtQ@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Mar 27, 2024 at 03:57:12PM -0700, Linus Torvalds wrote:
> On Wed, 27 Mar 2024 at 14:41, Kent Overstreet <kent.overstreet@linux.dev> wrote:
> >
> >
> > On the hardware end, the Mill guys were pointing out years ago that
> > register renaming is a big power bottleneck in modern processors;
> 
> LOL.
> 
> The Mill guys took the arguments from the Itanium people, and turned
> the crazy up to 11, with "the belt" and seemingly trying to do a
> dataflow machine but not worrying over-much about memory accesses etc.
> 
> The whole "we'll deal with it in the compiler" is crazy talk.

And Itanium did way better on Fortran, but all those spills and reloads
due to aliasing that an OoO processor can hide are death when you're
statically scheduled.

Unrestricted pointers are fundamentally a real barrier to improved ILP.
It's not _all_ branches and cache effects, though I will grant you that
cache effects do dominate.

But I think there's hope for improvement on that one too. A _lot_ of
kernel code defaults to lists instead of vectors even though we know
that vectors are better for performance - beacuse people are afraid of
memory allocations and error paths. Rust makes it way harder to fuck up
your error paths, and also makes it safer to refactor to improve your
data structures.

