Return-Path: <linux-fsdevel+bounces-15147-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEBC588766C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Mar 2024 02:43:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9ED191F21AC5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Mar 2024 01:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2475E5CB5;
	Sat, 23 Mar 2024 01:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Y1WS4lKA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95ADB1A38DD
	for <linux-fsdevel@vger.kernel.org>; Sat, 23 Mar 2024 01:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711158171; cv=none; b=DdLaH+UXlVu0leEJyCVADksDBw+1l1SbtZ2COOK7dQ21mLAhmXA8ovGKn9R/Ju2V8/Npzgd0qZvjxZm971/VYWqHw0vZg6gK/+dfIkJXTvmQI9wfbi+SLJrEWtjWadhi45fXIgd+l5xFFrTfUEmGQRR6AFSQPLODp1MclF9lAO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711158171; c=relaxed/simple;
	bh=xRw80OmHUOdZy/5LOsJImKztlKT0glsQe04+QOE7Zio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f4nigKPgXg5Ctrd3/1hDzRUxE5pppBZITH5gCdjMeOibUML9Xam8q7OYv+gbCK4+WXDPEgv/T3GMlsydECw6MEwOj68Jmv4YscIlAy9fBBg/d0vJQN6Fzh2rH+kWgLWmLs/3TcJ91UmSTmZKCU4p+THH+yJGrKEicsgPbWGGq0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Y1WS4lKA; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 22 Mar 2024 21:42:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711158166;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dD6EJF/cqoVE6rTGymbaDjtYb5EyuzQQZLjYH+mQ0aY=;
	b=Y1WS4lKAH/M0gvaaIqhUPMVVjGnJ5D5J1mlllLUuf/wJdRmZwE+RQpK/uRkdis8VSBdPd5
	FAAGjk7O1X1lQgNzof95s65T8ZalrTYODKiuB9EtY3XrtQgVaU/B768Y9zuBEBbpZnvlQE
	cxNTro92OBkv0mUt9uy6fX1d73IBfVs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
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
	Catalin Marinas <catalin.marinas@arm.com>, torvalds@linux-foundation.org, 
	linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [WIP 0/3] Memory model and atomic API in Rust
Message-ID: <v7gcnb6a3kqolyx6jrusburtwhsnomg543jpulza233bjofesl@zrunbxkpaa2n>
References: <20240322233838.868874-1-boqun.feng@gmail.com>
 <s2jeqq22n5ef5jknaps37mfdjvuqrns4w7i22qp2r7r4bzjqs2@my3eyxoa3pl3>
 <Zf4fDJNBeRN5HOYo@boqun-archlinux>
 <Zf4nE_AvHPx9F2nQ@boqun-archlinux>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zf4nE_AvHPx9F2nQ@boqun-archlinux>
X-Migadu-Flow: FLOW_OUT

On Fri, Mar 22, 2024 at 05:49:23PM -0700, Boqun Feng wrote:
> On Fri, Mar 22, 2024 at 05:15:08PM -0700, Boqun Feng wrote:
> [...]
> > > 
> > > I wonder about that. The disadvantage of only supporting LKMM atomics is
> > > that we'll be incompatible with third party code, and we don't want to
> > > be rolling all of our own data structures forever.
> > > 
> > 
> > A possible solution to that is a set of C++ memory model atomics
> > implemented by LKMM atomics. That should be possible.
> > 
> 
> Another possible "solution" works in the opposite direction, since the
> folder rust/kernel/sync/atomic is quite stand-alone, we can export that
> as a Rust crate (library), and third party code can support using LKMM
> atomics instead of Rust own atomics ;-) Of course if the project is
> supposed to work with Linux kernel.

Not just from the Rust side, the C side would be useful as well. I've
got a quicky, dirty, hacky version of that in bcachefs-tools, and I
would switch immediately if someone took that over and made it a real
project, and I'm quite sure other projects would as well.

