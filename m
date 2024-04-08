Return-Path: <linux-fsdevel+bounces-16373-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 624F789C948
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Apr 2024 18:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C9E6B2556D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Apr 2024 16:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019001422D9;
	Mon,  8 Apr 2024 16:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iBigXMxg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFF41420D5;
	Mon,  8 Apr 2024 16:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712592168; cv=none; b=Oie8SiX3o90Z/DH+06Xm0fUokeaI3BQZngI8GndNvBB52g9erZy7I6bzMZ6jcLl/57JwPXhLJfwPF10vrzrSIuulIcQJJ5U+5oevdi3JdggVp82SiaMFDPXqUmQyDQf2/1RufDmzJRGrC1RGaHZkZb2xH2WYuykNiqFH6Bql1B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712592168; c=relaxed/simple;
	bh=Y30PmaNhnezUuMlBCV6pB7+TsKy2Xq+rK8IH/JfTHog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j0MGV4YI7tsSvB/Ap2QCkEZGnQIOQ4TuQJmJRyEegQPmD+1cDaYEiFXpxrMWzXbKmxO1dmCExYnQNIgyMi5rL9e+z7vANgt2JGwe1TSLWxB1fICxstVjWZ2Td2rre+wb88LnfeTp/d+Z0CWngYBFGVNhWc2FaIYKpo2D4cSIZ5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=iBigXMxg; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=izUM//YtAco+VvWir8uJwOQef2J3aIrjmbstnFNAkDI=; b=iBigXMxgZi2deI/ZFxgrEINoG9
	ynsx+q7hfmtWcVmHw0IWtJMqsPdA9jDQbFF8f1uvh+/Kee0EfWOzl7xMVtCZhzF8TQWvru7Zcin4M
	OzwZ002fnCE6hxU5qx5ssj62e5dsuNMzauIyLwg5+q/6YeFmfVBQKqsGbo9TGdSr9qBr2MqdFmVuW
	iFw0QPZR6RKbpTRKzGHN6XuxlgGcYz4T7bKnfvCEWmPIRjmBq/zSkf9/B43LCOtdXtmDZx926JW9S
	TZNQSKznDjkDVm1i5h/AcUiheZt1qx1v8cYU0PN7RPGq5MySGKDLaqm+U86RIdVuGRZuglLRmVIDF
	OXJt75vQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtrS9-000000009mo-2kya;
	Mon, 08 Apr 2024 16:02:37 +0000
Date: Mon, 8 Apr 2024 17:02:37 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Philipp Stanner <pstanner@redhat.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Boqun Feng <boqun.feng@gmail.com>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	llvm@lists.linux.dev, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Andrea Parri <parri.andrea@gmail.com>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Nicholas Piggin <npiggin@gmail.com>,
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
	Mark Rutland <mark.rutland@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [WIP 0/3] Memory model and atomic API in Rust
Message-ID: <ZhQVHZnU3beOhEGU@casper.infradead.org>
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

On Mon, Mar 25, 2024 at 10:44:43AM -0700, Linus Torvalds wrote:
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

What annoys me is that 'volatile' accesses have (at least) two distinct
meanings:
 - Make this access untorn
 - Prevent various optimisations (code motion,
   common-subexpression-elimination, ...)

As an example, folio_migrate_flags() (in mm/migrate.c):

        if (folio_test_error(folio))
                folio_set_error(newfolio);
        if (folio_test_referenced(folio))
                folio_set_referenced(newfolio);
        if (folio_test_uptodate(folio))
                folio_mark_uptodate(newfolio);

... which becomes...

      1f:       f6 c4 04                test   $0x4,%ah
      22:       74 05                   je     29 <folio_migrate_flags+0x19>
      24:       f0 80 4f 01 04          lock orb $0x4,0x1(%rdi)
      29:       48 8b 03                mov    (%rbx),%rax
      2c:       a8 04                   test   $0x4,%al
      2e:       74 05                   je     35 <folio_migrate_flags+0x25>
      30:       f0 80 4d 00 04          lock orb $0x4,0x0(%rbp)
      35:       48 8b 03                mov    (%rbx),%rax
      38:       a8 08                   test   $0x8,%al
      3a:       74 05                   je     41 <folio_migrate_flags+0x31>
      3c:       f0 80 4d 00 08          lock orb $0x8,0x0(%rbp)

In my ideal world, the compiler would turn this into:

	newfolio->flags |= folio->flags & MIGRATE_MASK;

but because folio_test_foo() and folio_set_foo() contain all manner of
volatile casts, the compiler is forced to do individual tests and sets.

Part of that is us being dumb; folio_set_foo() should be __folio_set_foo()
because this folio is newly allocated and nobody else can be messing
with its flags word yet.  I failed to spot that at the time I was doing
the conversion from SetPageFoo to folio_set_foo.

But if the compiler people could give us something a little more
granular than "scary volatile access disable everything", that would
be nice.  Also hard, because now you have to figure out what this new
thing interacts with and when is it safe to do what.

