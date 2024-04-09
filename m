Return-Path: <linux-fsdevel+bounces-16411-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CD5289D19B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 06:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AED4A1C21DF7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 04:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF4B54902;
	Tue,  9 Apr 2024 04:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X1TuIwKI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6613BBE4;
	Tue,  9 Apr 2024 04:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712638025; cv=none; b=sYLEMwWgx4tPHuSEU9FxyHEiRgMXUoTMZgj2KH8cOvIYJ+V5ZXYAHBqeIMC+UlLCi0jldS3DgKwFiT/L4rpIFvra26MVmKtOC6V2X8doBjr5/2FHtuN0UTx49keL1qm64iue3OHbavf4FOBpZOZSfjt3nmuNW6Q+J/sAdAsraXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712638025; c=relaxed/simple;
	bh=/wRns2YHr/e81UAE5ln2nftiOF08Py5b8V2ul1ELJLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kOYjYKpg1TZAgZWHhGw+EU1tewpVcEEFTeAJBRu6L3dcVsyysYgZApFJGh42X7V7grd8jaOjIPiUvB08YaQZkOyPeoIPd/OIZqzpw0FL7z7iwUCSta/Wy0jbf6fxHM7/Hocl1yHg3G+Czlz9GHX/I40rgmRpBkkhyxJrBlClAw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X1TuIwKI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A1ABC433F1;
	Tue,  9 Apr 2024 04:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712638025;
	bh=/wRns2YHr/e81UAE5ln2nftiOF08Py5b8V2ul1ELJLo=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=X1TuIwKIKFgH28lx1aWSzHSc/l9q/5WsShWTyf1COXe+KH8o5qkJx/+4l/MZAGdp5
	 tY3Ii6O3xstLwGlLDwl0ILyJ7iLmlhqJpVaf9zwMAbt2nTNVKmLFa7ltyTVmS1NTjZ
	 tGQeJYyeNoqkSiziXYMahy4CWp65HxqT8GXv8eYg5hxNH7UTpcJlX4wLvi5xJ22Ds+
	 gB4OedgEhtiGv0uIRIAN1xSU0atqatc0m59MImyALJFnXLBTf2f8uK3EZb/RfJs8NM
	 /sxh6FUkFe9z/bUfWj9DDmpuNCe2M5nqp4kqYkxUFErlAYmYmP2tP3htmQfirFktDf
	 Og+X9lFiXyI0g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id B751ACE12F2; Mon,  8 Apr 2024 21:47:04 -0700 (PDT)
Date: Mon, 8 Apr 2024 21:47:04 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Matthew Wilcox <willy@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Philipp Stanner <pstanner@redhat.com>,
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
Message-ID: <6fa87fef-5676-4a26-86d9-45eca6ebd798@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <s2jeqq22n5ef5jknaps37mfdjvuqrns4w7i22qp2r7r4bzjqs2@my3eyxoa3pl3>
 <CAHk-=whY5A=S=bLwCFL=043DoR0TTgSDUmfPDx2rXhkk3KANPQ@mail.gmail.com>
 <u2suttqa4c423q4ojehbucaxsm6wguqtgouj7vudp55jmuivq3@okzfgryarwnv>
 <CAHk-=whkQk=zq5XiMcaU3xj4v69+jyoP-y6Sywhq-TvxSSvfEA@mail.gmail.com>
 <c51227c9a4103ad1de43fc3cda5396b1196c31d7.camel@redhat.com>
 <CAHk-=wjP1i014DGPKTsAC6TpByC3xeNHDjVA4E4gsnzUgJBYBQ@mail.gmail.com>
 <ZhQVHZnU3beOhEGU@casper.infradead.org>
 <fec60bba-e414-43d1-bc3e-870f5ffe4626@paulmck-laptop>
 <ZhQjT4xdS3h-GbtC@casper.infradead.org>
 <bmbsx3zfgedqo5ef6yzzvpnwx2ukhzhm33ovb6zyhq4g6vutnn@b7qlnf2pyxvj>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bmbsx3zfgedqo5ef6yzzvpnwx2ukhzhm33ovb6zyhq4g6vutnn@b7qlnf2pyxvj>

On Mon, Apr 08, 2024 at 08:58:18PM -0400, Kent Overstreet wrote:
> On Mon, Apr 08, 2024 at 06:03:11PM +0100, Matthew Wilcox wrote:
> > On Mon, Apr 08, 2024 at 09:55:23AM -0700, Paul E. McKenney wrote:
> > > On Mon, Apr 08, 2024 at 05:02:37PM +0100, Matthew Wilcox wrote:
> > > > In my ideal world, the compiler would turn this into:
> > > > 
> > > > 	newfolio->flags |= folio->flags & MIGRATE_MASK;
> > > 
> > > Why not accumulate the changes in a mask, and then apply the mask the
> > > one time?  (In situations where __folio_set_foo() need not apply.)
> > 
> > But it irks me that we can't tell the compiler this is a safe
> > transformation for it to make. There are a number of places where
> > similar things happen.
> 
> Same thing comes up with bignum code - you really want to be able to
> tell the compiler "you can apply x/y/z optimizations for these
> functions", e.g. replace add(mul(a, b), c) with fma(a, b, c).
> 
> Compiler optimizations are just algebraic transformations, we just need
> a way to tell the compiler what the algebraic properties of our
> functions are.

That might indeed be more straightforward than doing this on a per-type
basis.  But the C++ guys would likely just start shouting "template
metaprogramming!!!"  ;-)

							Thanx, Paul

