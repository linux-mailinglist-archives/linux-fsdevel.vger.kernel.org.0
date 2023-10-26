Return-Path: <linux-fsdevel+bounces-1261-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F197D873D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Oct 2023 19:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 215BB282063
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Oct 2023 17:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D8038BBA;
	Thu, 26 Oct 2023 17:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kvKAZN2M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58792381C4;
	Thu, 26 Oct 2023 17:08:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5A6EC433C7;
	Thu, 26 Oct 2023 17:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698340108;
	bh=q5nu5IfnRwPtcWkLDIu4aKyLwlMTLZH09mIm5x2Tuis=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=kvKAZN2MMSkl1+CvCbw+bKVWIonlMLlGvoyOkrluhiKxg6aAKGv7elmEkFI6RMlk1
	 L2WGU4VBOmRIzvFLMQIivxqRBZldlSs8hE8LrXKkZvVdM2jdW0IhKifYjRnNGI7dp0
	 7GQYBSYrAQlElOlklY4PCPR1C1dNMK0Uw2AOLO2LFZDz38HOx9uPZRUVr74ZD42lkF
	 uppRnkPjzY+r3oIpxavk/wSZbZ/WlJA9yD6XOQadktbY7anFw+dikPBP35tY9L6fPm
	 qG6bVF1QQPHi3CLYEyTauxQqHXJDcKe4/mmhnOyBtQH8L5gr09L5S4iXS8vUROldXF
	 udSXExCrBk2jA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id E3628CE0D12; Thu, 26 Oct 2023 10:08:27 -0700 (PDT)
Date: Thu, 26 Oct 2023 10:08:27 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Gary Guo <gary@garyguo.net>, Boqun Feng <boqun.feng@gmail.com>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, llvm@lists.linux.dev,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Andrea Parri <parri.andrea@gmail.com>,
	Will Deacon <will@kernel.org>, Nicholas Piggin <npiggin@gmail.com>,
	David Howells <dhowells@redhat.com>,
	Jade Alglave <j.alglave@ucl.ac.uk>,
	Luc Maranget <luc.maranget@inria.fr>,
	Akira Yokosawa <akiyks@gmail.com>,
	Daniel Lustig <dlustig@nvidia.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, kent.overstreet@gmail.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, elver@google.com,
	Matthew Wilcox <willy@infradead.org>,
	Dave Chinner <david@fromorbit.com>, linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC] rust: types: Add read_once and write_once
Message-ID: <272fb0fa-bff7-4ccf-bea1-fba388c5d512@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20231025195339.1431894-1-boqun.feng@gmail.com>
 <20231026081345.GJ31411@noisy.programming.kicks-ass.net>
 <20231026113610.1425be1b@eugeo>
 <20231026111625.GK33965@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026111625.GK33965@noisy.programming.kicks-ass.net>

On Thu, Oct 26, 2023 at 01:16:25PM +0200, Peter Zijlstra wrote:
> On Thu, Oct 26, 2023 at 11:36:10AM +0100, Gary Guo wrote:
> 
> > There's two reasons that we are using volatile read/write as opposed to
> > relaxed atomic:
> > * Rust lacks volatile atomics at the moment. Non-volatile atomics are
> >   not sufficient because the compiler is allowed (although they
> >   currently don't) optimise atomics. If you have two adjacent relaxed
> >   loads, they could be merged into one.
> 
> Ah yes, that would be problematic, eg, if lifted out of a loop things
> could go sideways fast.
> 
> > * Atomics only works for integer types determined by the platform. On
> >   some 32-bit platforms you wouldn't be able to use 64-bit atomics at
> >   all, and on x86 you get less optimal sequence since volatile load is
> >   permitted to tear while atomic load needs to use LOCK CMPXCHG8B.
> 
> We only grudgingly allowed u64 READ_ONCE() on 32bit platforms because
> the fallout was too numerous to fix. Some of them are probably bugs.
> 
> Also, I think cmpxchg8b without lock prefix would be sufficient, but
> I've got too much of a head-ache to be sure. Worse is that we still
> support targets without cmpxchg8b.

Plus cmpxchg8b can be quite a bit heavier weight than READ_ONCE(),
in some cases to the point that you would instead use some other
concurrency design.

> It might be interesting to make the Rust side more strict in this regard
> and see where/when we run into trouble.

And maybe have some other name for READ_ONCE() that is permitted to tear.

> > * Atomics doesn't work for complex structs. Although I am not quite sure
> >   of the value of supporting it.
> 
> So on the C side we mandate the size is no larger than machine word,
> with the exception of the u64 on 32bit thing. We don't mandate strict
> integer types because things like pte_t are wrapper types.

On C-language atomics, people who have talked about implementing atomics
for objects too large for tear-free loads and stores have tended to want
ot invent locks.  :-(

							Thanx, Paul

