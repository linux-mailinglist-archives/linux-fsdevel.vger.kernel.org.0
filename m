Return-Path: <linux-fsdevel+bounces-15480-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E446C88F11B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Mar 2024 22:42:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 135841C2AB6F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Mar 2024 21:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1154F153819;
	Wed, 27 Mar 2024 21:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="P9fz0LZ6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E911514FD
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Mar 2024 21:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711575716; cv=none; b=aDwI3Mgqfh6EZt47BTswKWDi5i6IllISPCFFLQHt9+7N+fHsNTrnVq3bQ4pKRdQOMynrayJh4HKFqdmTgXtVi6Dge86YWJYuiIs+Y8+EVgM04Wsgb1rI0rF09onbcJLi9gri87UJ5sq54Tq32pjVoc7rE2rfdpU4XWyRnWOGzGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711575716; c=relaxed/simple;
	bh=Ka4yhsa8pA7IN8JWhrFeenVCI3gTYxePnH/a155TeVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n6JkD5zNzAxJe6z3yVu174hXuzi9ffWbD5CPwlfsYxGbR5/QQ7dDeoQBLgI0pSU5EhXNVfM8OgqEkhqgNXWljbHRnCVZRfsojX8BCE8xHqUklktSsAgKvph26AS880MO4Z1gko95XE6o7v5mIHuMkaYXlC9rCZpxXVkdA/k9DHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=P9fz0LZ6; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 27 Mar 2024 17:41:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711575711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dfpvhmi8rKro1b2dyL3uY2Ed1/z/apHoJwqWNRmO5B4=;
	b=P9fz0LZ6KX4HbsV78Toh0xVvAAPtEhIh/vnyagTO6/lh+tTBkoFPRjJ/AFAokCzLbmN29U
	CulIj0vF4mNJoUBAND7yLvIraMiM91VioMqDNlE8vn0vuML+CofPaw07zpuXQQmW+GZP2G
	68JzFd6/7l4lnSoUl7RV9RRY1Pn48F8=
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
Message-ID: <psy7q3fbnjeyk7fu6wyfecpvgsaxel5vcc6cudftxgyvj4zuhf@3xhjikjjy5pn>
References: <CAHk-=wjP1i014DGPKTsAC6TpByC3xeNHDjVA4E4gsnzUgJBYBQ@mail.gmail.com>
 <bu3seu56hfozsvgpdqjarbdkqo3lsjfc4lhluk5oj456xmrjc7@lfbbjxuf4rpv>
 <CAHk-=wgLGWBXvNODAkzkVHEj7zrrnTq_hzMft62nKNkaL89ZGQ@mail.gmail.com>
 <ZgIRXL5YM2AwBD0Y@gallifrey>
 <CAHk-=wjwxKD9CxYsf5x+K5fJbJa_JYZh1eKB4PT5cZJq1+foGw@mail.gmail.com>
 <160DB953-1588-418E-A490-381009CD8DE0@gmail.com>
 <qyjrex54hbhvhw4gmn7b6l2hr45o56bwt6fazfalykwcp5zzkx@vwt7k3d6kdwt>
 <CAHk-=wgQy+FRKjO_BvZgZN56w6-+jDO8p-Mt=X=zM70CG=CVBQ@mail.gmail.com>
 <bjorlxatlpzjlh6dfulham3u4mqsfqt7ir5wtayacaoefr2r7x@lmfcqzcobl3f>
 <CAHk-=wiSiNtf4Z=Bvfs=sGJn6SYCZ=F7hvWwsQiOX4=V0Bgp_Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiSiNtf4Z=Bvfs=sGJn6SYCZ=F7hvWwsQiOX4=V0Bgp_Q@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Mar 27, 2024 at 01:45:46PM -0700, Linus Torvalds wrote:
> On Wed, 27 Mar 2024 at 12:41, Kent Overstreet <kent.overstreet@linux.dev> wrote:
> >
> > _But_: the lack of any aliasing guarantees means that writing through
> > any pointer can invalidate practically anything, and this is a real
> > problem.
> 
> It's actually much less of a problem than you make it out to be.
> 
> A lot of common aliasing information is statically visible (offsets
> off the same struct pointer etc).
> 
> The big problems tend to be
> 
>  (a) old in-order hardware that really wants the compiler to schedule
> memory operations
> 
>  (b) vectorization and HPC

Yeah, I was being a bit dramatic given the current state of the world -
OOO machines _mostly_ do a reasonable job of hiding the negative effects of
this (although not always, when memory barriers are involved).

But I think this is going to become important again in the future, for a
couple reasons.

On the hardware end, the Mill guys were pointing out years ago that
register renaming is a big power bottleneck in modern processors; the
actual functional units consume practically nothing compared to just
moving data around. They never built anything, but there's at least one
new startup I know of that's continuing their work. Yes, VLIW has been a
bust repeatedly, but as we keep going wider and wider (because what else
are we going to do?) I think it's going to happen eventually.

On the compiler side, I'm taking the long view: it's really not just
about a few reloads here and there, it's that you fundamentally can't do
that much with code that's mutating arbitrary state; analysis that
optimizations depend on is impossible. In the compiler you really want
to be working with code that's pure functional - then all your
optimizations are just algebra. And internally, compilers do this as
much as they can (SSA form...), but - unrestricted pointers really put a
limit on what they can do.

The beautiful thing about Rust to me is that we finally might have a
path out of this; the rules of Rust references constrain mutability in
such a way that's almost as good as being purely functional, yet it's
something we can actually do systems programming with.

I think this is going to lead to substantially better code optimization
in the future, and based on a much more sound model that means we won't
constantly be fighting with compiler people because they're doing shady
shit and breaking previously working code. Based on my experiences with
writing iterator heavy code in both C and Rust, I think it already is.

