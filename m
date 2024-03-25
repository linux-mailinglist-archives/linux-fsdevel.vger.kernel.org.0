Return-Path: <linux-fsdevel+bounces-15243-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A0088AF22
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 19:59:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E22361C3F98B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 18:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21FDE610D;
	Mon, 25 Mar 2024 18:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Dq7T0k6+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BAE4A28
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Mar 2024 18:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711393185; cv=none; b=E7M2Y7RPjjmwxZMNow4ztzw6BXMxH6whsj3RLXKE1Z2dM2/yFO+RfuCmXAym+DtAJ/AeNesJj9uWLfe+htRu398x+OS87sdZUlU7doU5hqc77t3YMeo9NFNnjJ7044ZjO9c5gOtJaUpnukCp5x+073OLSE20HlDXWKhAnyTUoz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711393185; c=relaxed/simple;
	bh=5gZosMRdgXPNa3JQMcKlsbHmM1gyLPrPMFgAM70+YQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k2mCpyj9btd32YHNiwpnvOwBQwIjh/+4JqUkRe5YMD+5058GfTKERcGFOqua7U6+3J/nKs/Qt4z9CBhRGr2dXeOEuyu910MmvWa/jYX8fRwjObBHx4MSfy0T/dQYkESVWH+JfEbY69ycn6ilABSrOJENWNW34O5CdSYB8zsItxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Dq7T0k6+; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 25 Mar 2024 14:59:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711393181;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VkxyhaTa5U3F8wqjsa7LRBFbMSJiyk7bCAom1K7zW40=;
	b=Dq7T0k6+H7nOTJbABp2Z2wN8NULCHNW0C7jHxsGk8umchshL+Bt0+paSu3yXZ0U/Y4O7Qw
	2Wpvlj/e3fmhSm/vChaqixf/iHXD+YHD9CLhy0X4PoAiONraZ+KcYsPwPUDyOPWoE0DhGp
	ati/oPgLBYa7j6sRtKFgS2L5MNPZSGU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Philipp Stanner <pstanner@redhat.com>, 
	Boqun Feng <boqun.feng@gmail.com>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
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
Message-ID: <bu3seu56hfozsvgpdqjarbdkqo3lsjfc4lhluk5oj456xmrjc7@lfbbjxuf4rpv>
References: <20240322233838.868874-1-boqun.feng@gmail.com>
 <s2jeqq22n5ef5jknaps37mfdjvuqrns4w7i22qp2r7r4bzjqs2@my3eyxoa3pl3>
 <CAHk-=whY5A=S=bLwCFL=043DoR0TTgSDUmfPDx2rXhkk3KANPQ@mail.gmail.com>
 <u2suttqa4c423q4ojehbucaxsm6wguqtgouj7vudp55jmuivq3@okzfgryarwnv>
 <CAHk-=whkQk=zq5XiMcaU3xj4v69+jyoP-y6Sywhq-TvxSSvfEA@mail.gmail.com>
 <c51227c9a4103ad1de43fc3cda5396b1196c31d7.camel@redhat.com>
 <CAHk-=wjP1i014DGPKTsAC6TpByC3xeNHDjVA4E4gsnzUgJBYBQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjP1i014DGPKTsAC6TpByC3xeNHDjVA4E4gsnzUgJBYBQ@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Mar 25, 2024 at 10:44:43AM -0700, Linus Torvalds wrote:
> On Mon, 25 Mar 2024 at 06:57, Philipp Stanner <pstanner@redhat.com> wrote:
> >
> > On Fri, 2024-03-22 at 17:36 -0700, Linus Torvalds wrote:
> > >
> > > It's kind of like our "volatile" usage. If you read the C (and C++)
> > > standards, you'll find that you should use "volatile" on data types.
> > > That's almost *never* what the kernel does. The kernel uses
> > > "volatile"
> > > in _code_ (ie READ_ONCE() etc), and uses it by casting etc.
> > >
> > > Compiler people don't tend to really like those kinds of things.
> >
> > Just for my understanding: Why don't they like it?
> 
> So I actually think most compiler people are perfectly fine with the
> kernel model of mostly doing 'volatile' not on the data structures
> themselves, but as accesses through casts.
> 
> It's very traditional C, and there's actually nothing particularly odd
> about it. Not even from a compiler standpoint.
> 
> In fact, I personally will argue that it is fundamentally wrong to
> think that the underlying data has to be volatile. A variable may be
> entirely stable in some cases (ie locks held), but not in others.
> 
> So it's not the *variable* (aka "object") that is 'volatile', it's the
> *context* that makes a particular access volatile.
> 
> That explains why the kernel has basically zero actual volatile
> objects, and 99% of all volatile accesses are done through accessor
> functions that use a cast to mark a particular access volatile.
> 
> But I've had negative comments from compiler people who read the
> standards as language lawyers (which honestly, I despise - it's always
> possible to try to argue what the meaning of some wording is), and
> particularly C++ people used to be very very antsy about "volatile".
> 
> They had some truly _serious_ problems with volatile.
> 
> The C++ people spent absolutely insane amounts of time arguing about
> "volatile objects" vs "accesses", and how an access through a cast
> didn't make the underlying object volatile etc.

To be fair, "volatile" dates from an era when we didn't have the haziest
understanding of what a working memory model for C would look like or
why we'd even want one.

(Someone might want to think about depracating volatile on objects and
adding compiler flag to disable it; I suspect it'd be a useful cleanup
for the compiler guys if they could get rid of it.)

The way the kernel uses volatile in e.g. READ_ONCE() is fully in line
with modern thinking, just done with the tools available at the time. A
more modern version would be just

__atomic_load_n(ptr, __ATOMIC_RELAXED)

Except C atomics only support pointer and integer types, READ_ONCE()
supports anything up to machine word size - that's something the C
people need to fix.

