Return-Path: <linux-fsdevel+bounces-16388-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA13789CF97
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 02:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29BA41C21E6F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 00:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB096FD5;
	Tue,  9 Apr 2024 00:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Yg0oT7qs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABCE2572
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Apr 2024 00:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712624310; cv=none; b=m0Jw+pri6I2uXdLaFHC+RMYZiNUqfNeoerUKLYIyY60bs4leuD+SqlGmMTidw4UgMJb883v14ZjKeO1kCru140zQcW5gGq8zIZ9ouo1qdFHoSAxgw5ER9MrWI2fy2k98Eieuwm/6XrWOGhHiYwgYLK9zM1jbHupdVyjS7n6d0lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712624310; c=relaxed/simple;
	bh=V3FgUl+FC3/IXTQNHB8mnAyeNIvxhDluphd24WLUhWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zip/R8gfDXwyWyadf5PbdfoLzxYH7OK+9GpS0HRXxYsqpI96XcteNiL0onfB4mo7Vo8fiz98Ie5REzrDKk39HSfUhrGHwf3siRef+q/kWjUCWUZgUrFD8Q4PDYlhcKazKqmmwXf04RBotbn0FUI5/GIzS/4DyTePkAV49AmhPyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Yg0oT7qs; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 8 Apr 2024 20:58:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712624306;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3p52dOP2BlWsYrHqgAKRiWPR5jPclXgPdAlCcB00rdo=;
	b=Yg0oT7qsnYRV74HSHZV+PlfEXWOlcnFzfPrvXVczJoE3Vngi7zfHZ2/ShgxuejqSLDaMMK
	U5FGxqvfqWMQDSdwmZz3Le+3pQE/gahuOSVkMc0TjzXwTPfS204xfiJqi1B2ETV4/d0MJb
	jYvHh/kfoPgNCoQM/NPr2GXhQRCRdz8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Matthew Wilcox <willy@infradead.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Philipp Stanner <pstanner@redhat.com>, 
	Boqun Feng <boqun.feng@gmail.com>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, llvm@lists.linux.dev, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, Alan Stern <stern@rowland.harvard.edu>, 
	Andrea Parri <parri.andrea@gmail.com>, Will Deacon <will@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Nicholas Piggin <npiggin@gmail.com>, 
	David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, 
	Luc Maranget <luc.maranget@inria.fr>, Akira Yokosawa <akiyks@gmail.com>, 
	Daniel Lustig <dlustig@nvidia.com>, Joel Fernandes <joel@joelfernandes.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	kent.overstreet@gmail.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	elver@google.com, Mark Rutland <mark.rutland@arm.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, linux-arm-kernel@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [WIP 0/3] Memory model and atomic API in Rust
Message-ID: <bmbsx3zfgedqo5ef6yzzvpnwx2ukhzhm33ovb6zyhq4g6vutnn@b7qlnf2pyxvj>
References: <20240322233838.868874-1-boqun.feng@gmail.com>
 <s2jeqq22n5ef5jknaps37mfdjvuqrns4w7i22qp2r7r4bzjqs2@my3eyxoa3pl3>
 <CAHk-=whY5A=S=bLwCFL=043DoR0TTgSDUmfPDx2rXhkk3KANPQ@mail.gmail.com>
 <u2suttqa4c423q4ojehbucaxsm6wguqtgouj7vudp55jmuivq3@okzfgryarwnv>
 <CAHk-=whkQk=zq5XiMcaU3xj4v69+jyoP-y6Sywhq-TvxSSvfEA@mail.gmail.com>
 <c51227c9a4103ad1de43fc3cda5396b1196c31d7.camel@redhat.com>
 <CAHk-=wjP1i014DGPKTsAC6TpByC3xeNHDjVA4E4gsnzUgJBYBQ@mail.gmail.com>
 <ZhQVHZnU3beOhEGU@casper.infradead.org>
 <fec60bba-e414-43d1-bc3e-870f5ffe4626@paulmck-laptop>
 <ZhQjT4xdS3h-GbtC@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZhQjT4xdS3h-GbtC@casper.infradead.org>
X-Migadu-Flow: FLOW_OUT

On Mon, Apr 08, 2024 at 06:03:11PM +0100, Matthew Wilcox wrote:
> On Mon, Apr 08, 2024 at 09:55:23AM -0700, Paul E. McKenney wrote:
> > On Mon, Apr 08, 2024 at 05:02:37PM +0100, Matthew Wilcox wrote:
> > > In my ideal world, the compiler would turn this into:
> > > 
> > > 	newfolio->flags |= folio->flags & MIGRATE_MASK;
> > 
> > Why not accumulate the changes in a mask, and then apply the mask the
> > one time?  (In situations where __folio_set_foo() need not apply.)
> 
> But it irks me that we can't tell the compiler this is a safe
> transformation for it to make. There are a number of places where
> similar things happen.

Same thing comes up with bignum code - you really want to be able to
tell the compiler "you can apply x/y/z optimizations for these
functions", e.g. replace add(mul(a, b), c) with fma(a, b, c).

Compiler optimizations are just algebraic transformations, we just need
a way to tell the compiler what the algebraic properties of our
functions are.

