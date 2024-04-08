Return-Path: <linux-fsdevel+bounces-16378-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C00089CB8A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Apr 2024 20:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0B841F22E23
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Apr 2024 18:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7A51448DE;
	Mon,  8 Apr 2024 18:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="rD/DuaXG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3906B1E532;
	Mon,  8 Apr 2024 18:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712600103; cv=none; b=qHei4SoMm5ukA5X4eBA25jHVdmmhiFexFFA29YQ8TT9w7iLYXP7DkPhcg0kt+bHYiGW6wKaxqfAm4Pe2Vh3mI3pP4PL5MHIwWv+0qG+eL+6PIB1auKHobYF4pIlHcUr+3GsgI5jmOE1xaMct54eKe7xeglxdJ7Vg57d8Xp38HaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712600103; c=relaxed/simple;
	bh=DRLQBzi4n7i2Dg4ZtyUnMCFLjm5PQPflcAJMjZDoMg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QXLwom81nuTjJ+uJbk8Or74jR4RwT5FvGZNVbPUZFB6JMRXp8OazOnol8RuwKXJCgPQGOuW/N8sX1NL0efr1jV6an9w2QnVjqumW3P0Zi7PSgKW0TT2ylcK+BQSfTdN4ey43Ka/qhWJ3bVWvO6TugzofLHmsin49ynfHm4x5BKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=rD/DuaXG; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=lABSIXPCn9p8sq353W0yAZhqYSCgGyOF0S6qhldHPVs=; b=rD/DuaXGJUwscfQo6NGAG8g65s
	tCzL7+mWcBjrNTrmZag077vReK7YhF9gncf0MwHcNkynQKZrrryCqMno6LpBRbsLVkbJMYcqMTk8p
	j5iM0qqotUpxDQkZc8YMeNhn2cmm3ZYMqLbv1IJXwIUjXasU7KmeUFqQvZMU5UYpUgad729+PY6uv
	3I1xKRatGGvS5iW2NGLFI18yKnjFt+vrFUqwT+7nvKoM/L+0XYV31HiBHJxan0g8SvYgmUIdZUgj/
	5zB/CAY0RdNSRipc6fkXry6fwS74eDECzfGai5oX7VzRgvQJxFnC3suRfxdoHCWpGXqr3xatvzgfQ
	99plpD5Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rttVt-008cm8-04;
	Mon, 08 Apr 2024 18:14:37 +0000
Date: Mon, 8 Apr 2024 19:14:36 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>,
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
Message-ID: <20240408181436.GO538574@ZenIV>
References: <20240322233838.868874-1-boqun.feng@gmail.com>
 <s2jeqq22n5ef5jknaps37mfdjvuqrns4w7i22qp2r7r4bzjqs2@my3eyxoa3pl3>
 <CAHk-=whY5A=S=bLwCFL=043DoR0TTgSDUmfPDx2rXhkk3KANPQ@mail.gmail.com>
 <u2suttqa4c423q4ojehbucaxsm6wguqtgouj7vudp55jmuivq3@okzfgryarwnv>
 <CAHk-=whkQk=zq5XiMcaU3xj4v69+jyoP-y6Sywhq-TvxSSvfEA@mail.gmail.com>
 <c51227c9a4103ad1de43fc3cda5396b1196c31d7.camel@redhat.com>
 <CAHk-=wjP1i014DGPKTsAC6TpByC3xeNHDjVA4E4gsnzUgJBYBQ@mail.gmail.com>
 <ZhQVHZnU3beOhEGU@casper.infradead.org>
 <CAHk-=whmmeU_r_o+sPMcr7tPr-EU+HLnmL+GaWUkMUW0kDzDxw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whmmeU_r_o+sPMcr7tPr-EU+HLnmL+GaWUkMUW0kDzDxw@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Apr 08, 2024 at 10:01:32AM -0700, Linus Torvalds wrote:

> For our own historical reasons, while we have a few generic atomic
> operations: bit operations, cmpxchg, etc, most of our arithmetic and
> logical ops all rely on a special "atomic_t" type (later extended with
> "atomic_long_t").
> 
> The reason? The garbage that is legacy Sparc atomics.
> 
> Sparc historically basically didn't have any atomics outside of the
> 'test and set byte' one, so if you wanted an atomic counter thing, and
> you cared about sparc, you had to play games with "some bits of the
> counter are the atomic byte lock".
> 
> And we do not care about that Sparc horror any *more*, but we used to.

FWIW, PA-RISC is no better - the same "fetch and replace with constant"
kind of primitive as for sparc32, only the constant is (u32)0 instead
of (u8)~0.  And unlike sparc64, 64bit variant didn't get better.

