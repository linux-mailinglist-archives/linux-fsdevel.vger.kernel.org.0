Return-Path: <linux-fsdevel+bounces-1227-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8757B7D7E30
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Oct 2023 10:14:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1206B212C2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Oct 2023 08:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812271946A;
	Thu, 26 Oct 2023 08:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PcOA/EqA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC3518644;
	Thu, 26 Oct 2023 08:14:36 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48F20B8;
	Thu, 26 Oct 2023 01:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7Ac2lsTLX6oaCFTK+hAgvsoBjk6RrYwjBJWA86xwxA8=; b=PcOA/EqANSQyrrzaA6ZNbON/qw
	2GuUgXTosP7z60vDMEAt/QzqafvyRBZ/yV9b/kaPi23W8blMVIEjNfUphG9iltyG6Qi1mitrUR8Kj
	MRzl05qUDnGaLri4lil6C0/yAGD9swRKnKBjLPu2/B+H1Xg6nwz+Kt/rqUrmkCbKvZG8IffR5pSiK
	FTdf2fs6HmjryxBtpNoHkuMpvY92HNKF6pewQECWNib6WX6dAWjPaEZg3gCHdp+DGRQaVe0VOovTZ
	EA0d8v/nB2omlsg0EDU7ypHQD5oJJG8vnhbC8N/wyXiENErE4Rt/5sD9TXl2vpVIlABQszutn7vPl
	FptwUvjw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qvvUw-00H96Y-0x;
	Thu, 26 Oct 2023 08:13:46 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id EB2D8300473; Thu, 26 Oct 2023 10:13:45 +0200 (CEST)
Date: Thu, 26 Oct 2023 10:13:45 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, llvm@lists.linux.dev,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
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
	Tom Rix <trix@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, kent.overstreet@gmail.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, elver@google.com,
	Matthew Wilcox <willy@infradead.org>,
	Dave Chinner <david@fromorbit.com>, linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC] rust: types: Add read_once and write_once
Message-ID: <20231026081345.GJ31411@noisy.programming.kicks-ass.net>
References: <20231025195339.1431894-1-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025195339.1431894-1-boqun.feng@gmail.com>

On Wed, Oct 25, 2023 at 12:53:39PM -0700, Boqun Feng wrote:
> In theory, `read_volatile` and `write_volatile` in Rust can have UB in
> case of the data races [1]. However, kernel uses volatiles to implement
> READ_ONCE() and WRITE_ONCE(), and expects races on these marked accesses
> don't cause UB. And they are proven to have a lot of usages in kernel.
> 
> To close this gap, `read_once` and `write_once` are introduced, they
> have the same semantics as `READ_ONCE` and `WRITE_ONCE` especially
> regarding data races under the assumption that `read_volatile` and
> `write_volatile` have the same behavior as a volatile pointer in C from
> a compiler point of view.
> 
> Longer term solution is to work with Rust language side for a better way
> to implement `read_once` and `write_once`. But so far, it should be good
> enough.

So the whole READ_ONCE()/WRITE_ONCE() thing does two things we care
about (AFAIR):

 - single-copy-atomicy; this can also be achieved using the C11
   __atomic_load_n(.memorder=__ATOMIC_RELAXED) /
   __atomic_store_n(.memorder=__ATOMIC_RELAXED) thingies.

 - the ONCE thing; that is inhibits re-materialization, and here I'm not
   sure C11 atomics help, they might since re-reading an atomic is
   definitely dodgy -- after all it could've changed.

Now, traditionally we've relied on the whole volatile thing simply
because there was no C11, or our oldest compiler didn't do C11. But
these days we actually *could*.

Now, obviously C11 has issues vs LKMM, but perhaps the load/store
semantics are near enough to be useful.  (IIRC this also came up in the
*very* long x86/percpu thread)

So is there any distinction between the volatile load/store and the C11
atomic load/store that we care about and could not Rust use the atomic
load/store to avoid their UB ?

