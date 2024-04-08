Return-Path: <linux-fsdevel+bounces-16374-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 847DB89CA21
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Apr 2024 18:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E99541F27006
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Apr 2024 16:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 773AC14387F;
	Mon,  8 Apr 2024 16:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CBqmxFJN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6F3142E7D;
	Mon,  8 Apr 2024 16:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712595325; cv=none; b=fbkNVTLH4HEZ+0sEnPsqqV5S4XLBamKxwF6azTGTITQcLR3S6WfGSpRezrZ5QRxu17KMXqG0uocaZPKtceOa9fgiR15fACZ81WnW4be8IYGNmzZfXSc0rRZNPKGEzxsGs4zr6I4+egxxp/NtyUnCUQFVNYuzMG960W5Wco0rJKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712595325; c=relaxed/simple;
	bh=YFesB505hWnJdX9pdGDcBCrm9rzqVPPUgN5AuPqk1jo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MjNO6rovc5DZ3TixSze9tlIwAfN0rMtZtri7/8JgdEOHoJx/xfM2pg6CJzNkyS73j7VRfjTpxzCQkK0GXuw1SpxSiSH8qGUnh2xyFjzNLqBdN2Z7JcaJOEk4p4tNs13byolTJpsqhTL70Rfn662+9pmsr8dEw/sEchZheDBIPBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CBqmxFJN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5068EC433F1;
	Mon,  8 Apr 2024 16:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712595324;
	bh=YFesB505hWnJdX9pdGDcBCrm9rzqVPPUgN5AuPqk1jo=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=CBqmxFJNWXXmB6Mytn75OQxNrcngJMryHSEI+Hp/ETWN1cAsGUcQGncp66pzuie3g
	 glriyS4CYQaYGBNVTbzUEP4ZAR3mDwqKs7WKq9UFu3L8lA632C5CN9LhoPlvCgNjir
	 qnHTDCaE7XOnpNDku2GaUCUZukZTycMhid4NyM3moCZIx0R6y2X0HtKXMtbHZ1WuXz
	 4dqXce9nprWNNPskUmQgAlDfHVHVxTaJGkqZLgpI+V+x0YSjWHAdfcQs7bvOfAf9M5
	 h6PcDlYaKvgcNNRgT6xaTSiUS7o39LVA3AvYyBEgsyF1EaAnLyFWVTK2ppk2ktwpxv
	 YYKk/40Nxicww==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id E96B8CE126C; Mon,  8 Apr 2024 09:55:23 -0700 (PDT)
Date: Mon, 8 Apr 2024 09:55:23 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Philipp Stanner <pstanner@redhat.com>,
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
Message-ID: <fec60bba-e414-43d1-bc3e-870f5ffe4626@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240322233838.868874-1-boqun.feng@gmail.com>
 <s2jeqq22n5ef5jknaps37mfdjvuqrns4w7i22qp2r7r4bzjqs2@my3eyxoa3pl3>
 <CAHk-=whY5A=S=bLwCFL=043DoR0TTgSDUmfPDx2rXhkk3KANPQ@mail.gmail.com>
 <u2suttqa4c423q4ojehbucaxsm6wguqtgouj7vudp55jmuivq3@okzfgryarwnv>
 <CAHk-=whkQk=zq5XiMcaU3xj4v69+jyoP-y6Sywhq-TvxSSvfEA@mail.gmail.com>
 <c51227c9a4103ad1de43fc3cda5396b1196c31d7.camel@redhat.com>
 <CAHk-=wjP1i014DGPKTsAC6TpByC3xeNHDjVA4E4gsnzUgJBYBQ@mail.gmail.com>
 <ZhQVHZnU3beOhEGU@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZhQVHZnU3beOhEGU@casper.infradead.org>

On Mon, Apr 08, 2024 at 05:02:37PM +0100, Matthew Wilcox wrote:
> On Mon, Mar 25, 2024 at 10:44:43AM -0700, Linus Torvalds wrote:
> > So I actually think most compiler people are perfectly fine with the
> > kernel model of mostly doing 'volatile' not on the data structures
> > themselves, but as accesses through casts.
> > 
> > It's very traditional C, and there's actually nothing particularly odd
> > about it. Not even from a compiler standpoint.
> > 
> > In fact, I personally will argue that it is fundamentally wrong to
> > think that the underlying data has to be volatile. A variable may be
> > entirely stable in some cases (ie locks held), but not in others.
> > 
> > So it's not the *variable* (aka "object") that is 'volatile', it's the
> > *context* that makes a particular access volatile.
> > 
> > That explains why the kernel has basically zero actual volatile
> > objects, and 99% of all volatile accesses are done through accessor
> > functions that use a cast to mark a particular access volatile.
> 
> What annoys me is that 'volatile' accesses have (at least) two distinct
> meanings:
>  - Make this access untorn
>  - Prevent various optimisations (code motion,
>    common-subexpression-elimination, ...)
> 
> As an example, folio_migrate_flags() (in mm/migrate.c):
> 
>         if (folio_test_error(folio))
>                 folio_set_error(newfolio);
>         if (folio_test_referenced(folio))
>                 folio_set_referenced(newfolio);
>         if (folio_test_uptodate(folio))
>                 folio_mark_uptodate(newfolio);
> 
> ... which becomes...
> 
>       1f:       f6 c4 04                test   $0x4,%ah
>       22:       74 05                   je     29 <folio_migrate_flags+0x19>
>       24:       f0 80 4f 01 04          lock orb $0x4,0x1(%rdi)
>       29:       48 8b 03                mov    (%rbx),%rax
>       2c:       a8 04                   test   $0x4,%al
>       2e:       74 05                   je     35 <folio_migrate_flags+0x25>
>       30:       f0 80 4d 00 04          lock orb $0x4,0x0(%rbp)
>       35:       48 8b 03                mov    (%rbx),%rax
>       38:       a8 08                   test   $0x8,%al
>       3a:       74 05                   je     41 <folio_migrate_flags+0x31>
>       3c:       f0 80 4d 00 08          lock orb $0x8,0x0(%rbp)
> 
> In my ideal world, the compiler would turn this into:
> 
> 	newfolio->flags |= folio->flags & MIGRATE_MASK;
> 
> but because folio_test_foo() and folio_set_foo() contain all manner of
> volatile casts, the compiler is forced to do individual tests and sets.
> 
> Part of that is us being dumb; folio_set_foo() should be __folio_set_foo()
> because this folio is newly allocated and nobody else can be messing
> with its flags word yet.  I failed to spot that at the time I was doing
> the conversion from SetPageFoo to folio_set_foo.
> 
> But if the compiler people could give us something a little more
> granular than "scary volatile access disable everything", that would
> be nice.  Also hard, because now you have to figure out what this new
> thing interacts with and when is it safe to do what.

OK, I will bite...

Why not accumulate the changes in a mask, and then apply the mask the
one time?  (In situations where __folio_set_foo() need not apply.)

If it turns out that we really do need a not-quite-volatile, what exactly
does it do?  You clearly want it to be able to be optimized so as to merge
similar accesses.  Is there a limit to the number of accesses that can
be merged or to the region of code over which such merging is permitted?
Either way, how is the compiler informed of these limits?

(I admit that I am not crazy about this sort of proposal, but that might
have something to do with the difficulty of repeatedly convincing
people that volatile is necessary and must be retained...)

							Thanx, Paul

