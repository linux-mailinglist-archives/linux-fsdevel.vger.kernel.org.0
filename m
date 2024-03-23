Return-Path: <linux-fsdevel+bounces-15158-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C988878EC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Mar 2024 15:10:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA38DB22EF6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Mar 2024 14:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 576723F8C7;
	Sat, 23 Mar 2024 14:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Mb97SIkc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4421A38F4;
	Sat, 23 Mar 2024 14:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711203034; cv=none; b=pJO5d9eBlKVfCGxIAHbcSNa48a/J7bPjrvTjkeJFjotbnId4XdtsQUKqxno0Kmag2Hj4VZ+0k3cfcjYJ6I1fmDEAz1idCNVNvehIHqQZqN1RO/Rd6LOSOO63JUHHGGLaas0Xr0cE7pcgeIwg+Qxz/xGoJ64/gHXCT+lGcHzW6eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711203034; c=relaxed/simple;
	bh=vpI2jBHlh6dsG2SS2eT9xX6YVg4ZX5BR2WV/eWEg+MA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TjeLqe+Cs3jgklzYbL3cFbL3b7L90JujbgPM6iTgSCFVRXPPuaGT8BkEvRRuqJcGkHF6lJY0c/XpIS8ari/uOLyzckHSfPhray7qJHOV4BYyazOaT/15vQw/Le/v+M5Tn0IE9KU3115tTgzECKZo/H+6M0Egbld4aW3AimpYuI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Mb97SIkc; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=mMJIH5/fIvPZW8NeQXlIeeRpf5h3/o6asdfcYdeLYYU=; b=Mb
	97SIkcFf6RiGosPIvWmz81W9Tp/neBsuP1WTUaUSrsWhsiDdOVBFU6SmKQvKIJU5t9HoTng5vbAHz
	cee9x2n3fWh4zNNBCVa1YJLNPHa309YzyVDRdbNna5ABsrhzUGFbEqN+NhrfCEvPB8JwkajSLYHwu
	kDuu1og5p4MP98w=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ro24j-00B3OA-OU; Sat, 23 Mar 2024 15:10:21 +0100
Date: Sat, 23 Mar 2024 15:10:21 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	llvm@lists.linux.dev, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
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
	torvalds@linux-foundation.org, linux-arm-kernel@lists.infradead.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [WIP 1/3] rust: Introduce atomic module
Message-ID: <497668ec-c2d5-4cb4-9c2d-8e6f7129a42e@lunn.ch>
References: <20240322233838.868874-1-boqun.feng@gmail.com>
 <20240322233838.868874-2-boqun.feng@gmail.com>
 <068a5983-8216-48a5-9eb5-784a42026836@lunn.ch>
 <CAH5fLggdVDccDwBa3z+3YfjKFLegh7ZvcSzfhnEbAGSk=THKrw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLggdVDccDwBa3z+3YfjKFLegh7ZvcSzfhnEbAGSk=THKrw@mail.gmail.com>

On Sat, Mar 23, 2024 at 10:58:16AM +0100, Alice Ryhl wrote:
> On Sat, Mar 23, 2024 at 12:52 AM Andrew Lunn <andrew@lunn.ch> wrote:
> >
> > > +//! These primitives should have the same semantics as their C counterparts, for precise definitions
> > > +//! of the semantics, please refer to tools/memory-model. Note that Linux Kernel Memory
> > > +//! (Consistency) Model is the only model for Rust development in kernel right now, please avoid to
> > > +//! use Rust's own atomics.
> >
> > Is it possible to somehow poison rusts own atomics?  I would not be
> > too surprised if somebody with good Rust knowledge but new to the
> > kernel tries using Rusts atomics. Either getting the compiler to fail
> > the build, or it throws an Opps on first invocation would be good.
> 
> We could try to get a flag added to the Rust standard library that
> removes the core::sync::atomic module entirely, then pass that flag.

Just looking down the road a bit, are there other features in the
standard library which are not applicable to Linux kernel space?
Ideally we want a solution not just for atomics but a generic solution
which can disable a collection of features? Maybe one by one?

And i assume somebody will try to use Rust in uboot/barebox. It
probably has similar requirements to the Linux kernel? But what about
Zephyr? Or VxWorks? Darwin?

	Andrew

