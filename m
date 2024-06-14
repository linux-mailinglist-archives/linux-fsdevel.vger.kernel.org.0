Return-Path: <linux-fsdevel+bounces-21700-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 679589088CB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jun 2024 11:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4751B26582
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jun 2024 09:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1ABA197A97;
	Fri, 14 Jun 2024 09:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bKHqjXQG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F66B1946CA;
	Fri, 14 Jun 2024 09:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718358699; cv=none; b=P/VqgciYAcMTdqZanNfyk6wFv4pPLFfk403Grd+FVBJLCLQm3M/zJQnVKJ7VB/0JkcDJF8owAZuTP0riEXBpJatYsEBbWWsFSfhbddL+UARl9ctOQXFXrm3u8KzpE2tuuWgaVvU8Q/JoH+jJW4nFON2HUTdQtJPefZgxF0Opcl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718358699; c=relaxed/simple;
	bh=YY13vYUMWiH23OOj6eMMyehLr25oWbUwaRTSmzzu/jM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ekuB2KHBAT5s9MgIw8n8+R/lTopXKm1EZyt/ANvdtsYgAKv+AW4TezOWeiMUQfpZnQ6/XBiu298/roJpe3DOHbJ8jbizFGEZClJIgQYknnlnc/uyMvnfCMjDQFwJrSnPcibG3IZJ6MZmtgtGU3KrOSNg15gJvpNrgAYrG/2xAiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bKHqjXQG; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=D9R7E/DpQNgNsvkfegKfRFjQEUms/ZvV0CqLhYXEFAA=; b=bKHqjXQGGIli99vP1x6nMU+0Wv
	brwBnfym82dpij06ITc7lhF4/DrVQ57Rc9tY++BYcFExsfbjR0XKprP2XHneZN/UP/9xwBhuyMBiI
	wlhFvx/kqIHBrq3o7fR9RdOOdsZlHMzYQYnRJ3HqOI6pHMMTMiT5FUAJ5QPUUpn+gWyZPCrhkYiSf
	FeGGy4wnXf1PgUVqVAji84k1epbdnE9UJlWLnyO8KMpSqvA4Bw/zgpJmJ5AzyWVkmbRsjQhll5Dul
	NgxZPYtR27wlrT+/wqmquormdS9nbzjQp1UOplrndUGRb45Nl1sOtfuBrAYzEX/zLdOFxHLC6Lgwn
	ndhwOYFA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sI3af-0000000GqAB-0CFR;
	Fri, 14 Jun 2024 09:51:25 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A8C26300886; Fri, 14 Jun 2024 11:51:24 +0200 (CEST)
Date: Fri, 14 Jun 2024 11:51:24 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Gary Guo <gary@garyguo.net>, rust-for-linux@vger.kernel.org,
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
	kent.overstreet@gmail.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, elver@google.com,
	Mark Rutland <mark.rutland@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	torvalds@linux-foundation.org, linux-arm-kernel@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, Trevor Gross <tmgross@umich.edu>,
	dakr@redhat.com
Subject: Re: [RFC 2/2] rust: sync: Add atomic support
Message-ID: <20240614095124.GN8774@noisy.programming.kicks-ass.net>
References: <20240612223025.1158537-1-boqun.feng@gmail.com>
 <20240612223025.1158537-3-boqun.feng@gmail.com>
 <20240613144432.77711a3a@eugeo>
 <ZmseosxVQXdsQjNB@boqun-archlinux>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmseosxVQXdsQjNB@boqun-archlinux>

On Thu, Jun 13, 2024 at 09:30:26AM -0700, Boqun Feng wrote:

> We can always add a layer on top of what we have here to provide the
> generic `Atomic<T>`. However, I personally don't think generic
> `Atomic<T>` is a good idea, for a few reasons:
> 
> *	I'm not sure it will bring benefits to users, the current atomic
> 	users in kernel are pretty specific on the size of atomic they
> 	use, so they want to directly use AtomicI32 or AtomicI64 in
> 	their type definitions rather than use a `Atomic<T>` where their
> 	users can provide type later.
> 
> *	I can also see the future where we have different APIs on
> 	different types of atomics, for example, we could have a:
> 
> 		impl AtomicI64 {
> 		    pub fn split(&self) -> (&AtomicI32, &AtomicI32)
> 		}
> 
> 	which doesn't exist for AtomicI32. Note this is not a UB because
> 	we write our atomic implementation in asm, so it's perfectly
> 	fine for mix-sized atomics.
> 
> So let's start with some basic and simple until we really have a need
> for generic `Atomic<T>`. Thoughts?

Not on the generic thing, but on the lack of long. atomic_long_t is
often used when we have pointers with extra bits on. Then you want a
number type in order to be able to manipulate the low bits.

