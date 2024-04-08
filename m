Return-Path: <linux-fsdevel+bounces-16380-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C4C89CBEE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Apr 2024 20:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA8871C2171E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Apr 2024 18:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A403D1448E0;
	Mon,  8 Apr 2024 18:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QH3VMMm5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14B71119A;
	Mon,  8 Apr 2024 18:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712602060; cv=none; b=lgdunCBSJZXSISm5qXrrQnhm7nGiLJ7xu1c/Xvk6ws69gZWjh6/3U1AQ2N1JCTZfKagBBxff7AzAT989NQweuZieIV14peGiyBIuWwpLBIofEck/j6D0oCohmx9UUSSWDxJyQ/f85Ql8rytzDRDwZ57+eNgk+iezWeCafH6Is/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712602060; c=relaxed/simple;
	bh=SYyVUdi9VjoNm97IS/XTV920oO6eW28EJnO10HujZm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BAD1uGh5/jiEisr7PO2yg9oUKY485YTarDPD1+eXGVLB7fx9XsfUWXQOYwGE6VuOaGCyhEWojXZ1SWneUy9/lAPKHRsjX8JXTVM+JAPFqJwLpGN+PdwGFkPilREbowxgQUMVaRk3U2N87QDV4dqJ9bgf4u7Z5YdV3OgaRlSQgWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QH3VMMm5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7457AC433C7;
	Mon,  8 Apr 2024 18:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712602059;
	bh=SYyVUdi9VjoNm97IS/XTV920oO6eW28EJnO10HujZm8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=QH3VMMm5SOy+a5/Le74mjOj7Gdef3Nx9WwKw4QdG6/4a+h1jicQcuUxj5+AbinxgI
	 5O0WFSLX1tLKfiZqZk9z4W57aYMdLzXxokbye8N4IAJTRT10k5C02VRxNvZLANEXPH
	 96FljbScvGcjKUjEf5DwEKEM5c1SQmnDIiMku/rAZriOl1SsozESEUU/P8SlrWCidN
	 AipWE/sidcx/TcflQso3P15T0WQ+VhU8rBrSGPPBvGDzMSc4OkBRiugBoJDyCVH95M
	 4e8DhZGuKYDGFqEyanXAB5XTPjkKaLhR1rfGz4FVPrUCAKzWUpjPKSi5TP6PlVxXdc
	 VWuo/YoxOqJ0w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 17CC2CE126C; Mon,  8 Apr 2024 11:47:39 -0700 (PDT)
Date: Mon, 8 Apr 2024 11:47:39 -0700
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
Message-ID: <c3e507cb-26bb-4fdc-b1dc-b512c7bfc093@paulmck-laptop>
Reply-To: paulmck@kernel.org
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
> Yes, absolutely, we can, should and probably eventually will do this
> when it gets to the top of somebody's todo list.  But it irks me that
> we can't tell the compiler this is a safe transformation for it to make.
> There are a number of places where similar things happen.
> 
> $ git grep folio_test.*folio_test
> 
> will find you 82 of them (where they happen to be on the same line)
> 
>                 if (folio_test_dirty(folio) || folio_test_locked(folio) ||
>                                 folio_test_writeback(folio))
>                         break;
> 
> turns into:
> 
>     1f41:       48 8b 29                mov    (%rcx),%rbp
>     1f44:       48 c1 ed 04             shr    $0x4,%rbp
>     1f48:       83 e5 01                and    $0x1,%ebp
>     1f4b:       0f 85 d5 00 00 00       jne    2026 <filemap_range_has_writeback+0x1a6>
>     1f51:       48 8b 29                mov    (%rcx),%rbp
>     1f54:       83 e5 01                and    $0x1,%ebp
>     1f57:       0f 85 c9 00 00 00       jne    2026 <filemap_range_has_writeback+0x1a6>
>     1f5d:       48 8b 29                mov    (%rcx),%rbp
>     1f60:       48 d1 ed                shr    $1,%rbp
>     1f63:       83 e5 01                and    $0x1,%ebp
>     1f66:       0f 85 ba 00 00 00       jne    2026 <filemap_range_has_writeback+0x1a6>
> 
> rather than _one_ load from rcx and a test against a mask.

Agreed, it would be nice if we could convince the compiler to do this
for us, preferably without breaking anything.

> > If it turns out that we really do need a not-quite-volatile, what exactly
> > does it do?  You clearly want it to be able to be optimized so as to merge
> > similar accesses.  Is there a limit to the number of accesses that can
> > be merged or to the region of code over which such merging is permitted?
> > Either way, how is the compiler informed of these limits?
> 
> Right, like I said, it's not going to be easy to define exactly what we
> want.

Or to convince the usual suspects that any definition we might come up
with is useful/implementable/teacheable/...  :-/

							Thanx, Paul

