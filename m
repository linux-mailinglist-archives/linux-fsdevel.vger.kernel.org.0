Return-Path: <linux-fsdevel+bounces-1234-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E94B27D81A9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Oct 2023 13:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1589282014
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Oct 2023 11:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9075B2D026;
	Thu, 26 Oct 2023 11:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OXHMup0e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B672811725;
	Thu, 26 Oct 2023 11:17:02 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28B21191;
	Thu, 26 Oct 2023 04:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5cohiNIB1FuP42t4pW7beekQI1iJD/MHJhnEGgn6Hk4=; b=OXHMup0eJ11eXPtr0XyZILpT2W
	QK73ZPV5Gh1MXIYdKATLblLvVMNNzIyUhhkt1NDZNH3IHqUzOMkIUSbRjfYGqA/DGj5h3dLAUAjPV
	HdETUfXELNLZEJDpknsAteTNcktZ6BDQRU4sdyL/8NXnd6IOvGqGKAQX93tNpTvDHCwdFfDNpjPvD
	0r1n1zWKUNDfGm/NQK+25GAeCBOoJxL1rZ9FJgupeVYdYPrgU1gN+pxAqW2M5HC1kEMa3Nn4B+JCd
	zbqH85Y+btf6RaY2W+D9rRtsxl85VwWps6ET3xzsfjV0J2kvTiixo7By3NJB3jpJFDumdEBdDM+u0
	KqfSMHrw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qvyLh-00HGQ2-2Q;
	Thu, 26 Oct 2023 11:16:26 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 6969D300473; Thu, 26 Oct 2023 13:16:25 +0200 (CEST)
Date: Thu, 26 Oct 2023 13:16:25 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Gary Guo <gary@garyguo.net>
Cc: Boqun Feng <boqun.feng@gmail.com>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	llvm@lists.linux.dev, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
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
Message-ID: <20231026111625.GK33965@noisy.programming.kicks-ass.net>
References: <20231025195339.1431894-1-boqun.feng@gmail.com>
 <20231026081345.GJ31411@noisy.programming.kicks-ass.net>
 <20231026113610.1425be1b@eugeo>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026113610.1425be1b@eugeo>

On Thu, Oct 26, 2023 at 11:36:10AM +0100, Gary Guo wrote:

> There's two reasons that we are using volatile read/write as opposed to
> relaxed atomic:
> * Rust lacks volatile atomics at the moment. Non-volatile atomics are
>   not sufficient because the compiler is allowed (although they
>   currently don't) optimise atomics. If you have two adjacent relaxed
>   loads, they could be merged into one.

Ah yes, that would be problematic, eg, if lifted out of a loop things
could go sideways fast.

> * Atomics only works for integer types determined by the platform. On
>   some 32-bit platforms you wouldn't be able to use 64-bit atomics at
>   all, and on x86 you get less optimal sequence since volatile load is
>   permitted to tear while atomic load needs to use LOCK CMPXCHG8B.

We only grudgingly allowed u64 READ_ONCE() on 32bit platforms because
the fallout was too numerous to fix. Some of them are probably bugs.

Also, I think cmpxchg8b without lock prefix would be sufficient, but
I've got too much of a head-ache to be sure. Worse is that we still
support targets without cmpxchg8b.

It might be interesting to make the Rust side more strict in this regard
and see where/when we run into trouble.

> * Atomics doesn't work for complex structs. Although I am not quite sure
>   of the value of supporting it.

So on the C side we mandate the size is no larger than machine word,
with the exception of the u64 on 32bit thing. We don't mandate strict
integer types because things like pte_t are wrapper types.



