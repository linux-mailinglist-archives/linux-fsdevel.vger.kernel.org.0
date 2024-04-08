Return-Path: <linux-fsdevel+bounces-16376-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8180089CA3A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Apr 2024 19:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E3F1288166
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Apr 2024 17:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53989142E9C;
	Mon,  8 Apr 2024 17:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aiNc++Ts"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242B76E60E;
	Mon,  8 Apr 2024 17:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712595803; cv=none; b=N8j2jfrMH+MXK+SNc7xO3VyLq+XD4ysLe9vu3MYvNkTGnAyFQhe5bK6EShCtaOpy8yQiC5PwI/1May8wQrTz2po4qPg5RcFHMw6of4oDhHWgwuY0BHPb3NZWkIgcLgZ433+1yBmvqkqOapHSt130KhmTNyz1gEliBZn7rY5q0EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712595803; c=relaxed/simple;
	bh=gN//XILcBlT0DJQEOTanYjKqrO+N1Qj9zEhssZWgESs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S9GN/SZX4xgj3LOy33wBl9t/NauJV7i8gJRXhp4j8SkMhkuPf5Aw19PcVzsX4ZT70HNvGYx5c4f+Dl1tO80iKLFjiPQCLqCw89Y4Cn+hgLrBuOaRMSfozvRCHZgKjaFVEWoJIfqTSH0blpGR+ykc9CK79ndSLjSyQB/dJCPQ4TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=aiNc++Ts; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=EC+c0K53M4cQQaYWWH6ov1Mzjcw38TyRZLp9ANkJLfo=; b=aiNc++TsrqGY3idP8BZBqBlc23
	oDcNXXEP/RYnFgfQlOPLjGuK9TyM29iXrAGUee+aG7r2LzkLZm3oki+4c3erRNHbk6dMGfEFjMs4I
	FTKkciLzcgIwLKHkl1eY78PCHKwjaPO86ZVwYHCxX4QdmJB67yprKZRnjijIXIvZTfkqMKvacRcxu
	nH1VzsXeLWU7yECxgsj+2YHhAwMGTKhhyxnqIzXdjbb9vdOSvLe67vpVrSG0J9QzB4BhBNxuMhk1t
	TCl1NW+7G3YF8eev+borvQZqjaJVd7MnzNDG5NUNdpmA1v/ZJnCJV0VHqR9LXo4wwNtZpFziOEsBJ
	ZSxQj4EQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtsOl-00000000Fng-1Lf1;
	Mon, 08 Apr 2024 17:03:11 +0000
Date: Mon, 8 Apr 2024 18:03:11 +0100
From: Matthew Wilcox <willy@infradead.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
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
Message-ID: <ZhQjT4xdS3h-GbtC@casper.infradead.org>
References: <20240322233838.868874-1-boqun.feng@gmail.com>
 <s2jeqq22n5ef5jknaps37mfdjvuqrns4w7i22qp2r7r4bzjqs2@my3eyxoa3pl3>
 <CAHk-=whY5A=S=bLwCFL=043DoR0TTgSDUmfPDx2rXhkk3KANPQ@mail.gmail.com>
 <u2suttqa4c423q4ojehbucaxsm6wguqtgouj7vudp55jmuivq3@okzfgryarwnv>
 <CAHk-=whkQk=zq5XiMcaU3xj4v69+jyoP-y6Sywhq-TvxSSvfEA@mail.gmail.com>
 <c51227c9a4103ad1de43fc3cda5396b1196c31d7.camel@redhat.com>
 <CAHk-=wjP1i014DGPKTsAC6TpByC3xeNHDjVA4E4gsnzUgJBYBQ@mail.gmail.com>
 <ZhQVHZnU3beOhEGU@casper.infradead.org>
 <fec60bba-e414-43d1-bc3e-870f5ffe4626@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fec60bba-e414-43d1-bc3e-870f5ffe4626@paulmck-laptop>

On Mon, Apr 08, 2024 at 09:55:23AM -0700, Paul E. McKenney wrote:
> On Mon, Apr 08, 2024 at 05:02:37PM +0100, Matthew Wilcox wrote:
> > In my ideal world, the compiler would turn this into:
> > 
> > 	newfolio->flags |= folio->flags & MIGRATE_MASK;
> 
> Why not accumulate the changes in a mask, and then apply the mask the
> one time?  (In situations where __folio_set_foo() need not apply.)

Yes, absolutely, we can, should and probably eventually will do this
when it gets to the top of somebody's todo list.  But it irks me that
we can't tell the compiler this is a safe transformation for it to make.
There are a number of places where similar things happen.

$ git grep folio_test.*folio_test

will find you 82 of them (where they happen to be on the same line)

                if (folio_test_dirty(folio) || folio_test_locked(folio) ||
                                folio_test_writeback(folio))
                        break;

turns into:

    1f41:       48 8b 29                mov    (%rcx),%rbp
    1f44:       48 c1 ed 04             shr    $0x4,%rbp
    1f48:       83 e5 01                and    $0x1,%ebp
    1f4b:       0f 85 d5 00 00 00       jne    2026 <filemap_range_has_writeback+0x1a6>
    1f51:       48 8b 29                mov    (%rcx),%rbp
    1f54:       83 e5 01                and    $0x1,%ebp
    1f57:       0f 85 c9 00 00 00       jne    2026 <filemap_range_has_writeback+0x1a6>
    1f5d:       48 8b 29                mov    (%rcx),%rbp
    1f60:       48 d1 ed                shr    $1,%rbp
    1f63:       83 e5 01                and    $0x1,%ebp
    1f66:       0f 85 ba 00 00 00       jne    2026 <filemap_range_has_writeback+0x1a6>

rather than _one_ load from rcx and a test against a mask.

> If it turns out that we really do need a not-quite-volatile, what exactly
> does it do?  You clearly want it to be able to be optimized so as to merge
> similar accesses.  Is there a limit to the number of accesses that can
> be merged or to the region of code over which such merging is permitted?
> Either way, how is the compiler informed of these limits?

Right, like I said, it's not going to be easy to define exactly what we
want.

