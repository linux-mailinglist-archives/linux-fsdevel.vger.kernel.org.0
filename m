Return-Path: <linux-fsdevel+bounces-16434-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3CC89D742
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 12:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B8031C22610
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 10:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20FB284D3A;
	Tue,  9 Apr 2024 10:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="A6+c2l4N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2690C823AE;
	Tue,  9 Apr 2024 10:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712659841; cv=none; b=h/yZy94C2zJgbCJrFFSHSJnfGvAmsGCggBYIzQzLzN0a++6ytLRmPsQs5n30WBAG4ifeQtfcCFobaTaEn+nbJEWKDdj881kKpT1I0aBhMNvmIi8JImbTN+ZJoj/yGDH0VsHtXun2zxIwCKPZiqQFd1NbUrpzZjyxykJHl33Z9ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712659841; c=relaxed/simple;
	bh=7d49H/3MDKc37vAmRfm+8BB1JMNOPrM2MZ5puWV2Yvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dy3UBQLITymu/Ecm0KDnRnu+dbOr+UcUKio5dY9Y7L0OkSD0+3Ugsd7Px5UUmJ25QKzM1YxJXjpDzxz9FdJjMQH7rZBDIqch7rYM4HcqgIfuuBXwn075pwBqSDga3RxLBIcmChy2/pjsUFKy6s/iG/LKhh5qkJ/BaZZDra1s/OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=A6+c2l4N; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=fdPl3WFCWHLRN70qmtNx/X3LaV4RnMmwDJdJ+T0QErQ=; b=A6+c2l4NtzCr3n9/z3r782zwiM
	t8LFZ2Y+6asvkVk0ieqbUPKWxtF67/X0IAKbJiidA9qgUMCQu80Bd3Ys70P+z1te0VntRDE6sSgSY
	od9Q4gM6yCXEsrnDuoAvwP49i2cA1aJ4AV5t5dJJJ9TI4oHZ6vjCMcMcrqZTcf8Xm5TXOwyzEkmJD
	aeVg+rKtRVKRuL2YMkIfLqGYTnjFPe+NQBKSioszfByY63QFkGFeO0C4uaypuWZ4L2Qd1pDGR4ooc
	xgsclxyA2Ldrsb2q7geUJ5Qs31a4NVyzYmJc97Jplwk1LT2VPVVjQylOoLtgQk5zMsBgGEgMjtG9B
	zNw4txXA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ru93Q-00000007Z81-2AVo;
	Tue, 09 Apr 2024 10:50:17 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 0C0F630040C; Tue,  9 Apr 2024 12:50:16 +0200 (CEST)
Date: Tue, 9 Apr 2024 12:50:15 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	llvm@lists.linux.dev, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	"Bj\"orn Roy Baron" <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Andrea Parri <parri.andrea@gmail.com>,
	Will Deacon <will@kernel.org>, Nicholas Piggin <npiggin@gmail.com>,
	David Howells <dhowells@redhat.com>,
	Jade Alglave <j.alglave@ucl.ac.uk>,
	Luc Maranget <luc.maranget@inria.fr>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,
	Daniel Lustig <dlustig@nvidia.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	kent.overstreet@gmail.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, elver@google.com,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	torvalds@linux-foundation.org, linux-arm-kernel@lists.infradead.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [WIP 0/3] Memory model and atomic API in Rust
Message-ID: <20240409105015.GC21779@noisy.programming.kicks-ass.net>
References: <20240322233838.868874-1-boqun.feng@gmail.com>
 <ZgFVnar3nS4F8eIX@FVFF77S0Q05N>
 <ZgHly_fioG7X4wGE@boqun-archlinux>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZgHly_fioG7X4wGE@boqun-archlinux>

On Mon, Mar 25, 2024 at 01:59:55PM -0700, Boqun Feng wrote:
> On Mon, Mar 25, 2024 at 10:44:45AM +0000, Mark Rutland wrote:
> [...]
> > > 
> > > * I choose to re-implement atomics in Rust `asm` because we are still
> > >   figuring out how we can make it easy and maintainable for Rust to call
> > >   a C function _inlinely_ (Gary makes some progress [2]). Otherwise,
> > >   atomic primitives would be function calls, and that can be performance
> > >   bottleneck in a few cases.
> > 
> > I don't think we want to maintain two copies of each architecture's atomics.
> > This gets painful very quickly (e.g. as arm64's atomics get patched between
> > LL/SC and LSE forms).
> > 
> 
> No argument here ;-)

Didn't we talk about bindgen being able to convert inline C functions
into equivalent inline Rust functions? ISTR that getting stuck on Rust
not having a useful inline asm.

But fixing all that in a hurry seems like the much saner path forward.

