Return-Path: <linux-fsdevel+bounces-15203-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86EA488AB4E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 18:19:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9048DC049D6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 14:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD9B1C2337;
	Mon, 25 Mar 2024 11:29:51 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC0017D23D;
	Mon, 25 Mar 2024 10:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711363501; cv=none; b=lol9DxDbvPP9K2/71SQ/SYgMCxeAmgN6lujHBpZzzpSdwiXXwNxPREV6yNZqaXLWpaxWjrWy34ee5cJ8cxaqzoSffbrjP873+ruU/OyhBpfYGE01q0NWlP/dC7lq/sy6r5k+41zMhQL+tepVhUwDHztnWOakWV1cA08FQXDPFds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711363501; c=relaxed/simple;
	bh=HVlViT7fg37ArzDR5okosyV0TQroP4C7gOqT9V4q2f0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LJVgG1cja4QnpRC+43Tf3ug6jce0R7PXmitvWr8upEsksCGCbGoAMRLoH4HTE92+Ct0wLJ40FoMz4Nn6rTOG0AHm5FTsg9jCaOyLcPuG67SI9sr7DBzuMXUxYcgh6a3O4OmtYpjBOAGYPMXy19Z8pUNo6PYKz6RzrBhlyeJpqKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C15E01FB;
	Mon, 25 Mar 2024 03:45:31 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.16.150])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AFF8B3F67D;
	Mon, 25 Mar 2024 03:44:51 -0700 (PDT)
Date: Mon, 25 Mar 2024 10:44:45 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, llvm@lists.linux.dev,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?us-ascii?Q?Bj=22orn?= Roy Baron <bjorn3_gh@protonmail.com>,
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
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	torvalds@linux-foundation.org, linux-arm-kernel@lists.infradead.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [WIP 0/3] Memory model and atomic API in Rust
Message-ID: <ZgFVnar3nS4F8eIX@FVFF77S0Q05N>
References: <20240322233838.868874-1-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240322233838.868874-1-boqun.feng@gmail.com>

On Fri, Mar 22, 2024 at 04:38:35PM -0700, Boqun Feng wrote:
> Hi,
> 
> Since I see more and more Rust code is comming in, I feel like this
> should be sent sooner rather than later, so here is a WIP to open the
> discussion and get feedback.
> 
> One of the most important questions we need to answer is: which
> memory (ordering) model we should use when developing Rust in Linux
> kernel, given Rust has its own memory ordering model[1]. I had some
> discussion with Rust language community to understand their position
> on this:
> 
> 	https://github.com/rust-lang/unsafe-code-guidelines/issues/348#issuecomment-1218407557
> 	https://github.com/rust-lang/unsafe-code-guidelines/issues/476#issue-2001382992
> 
> My takeaway from these discussions, along with other offline discussion
> is that supporting two memory models is challenging for both correctness
> reasoning (some one needs to provide a model) and implementation (one
> model needs to be aware of the other model). So that's not wise to do
> (at least at the beginning). So the most reasonable option to me is:
> 
> 	we only use LKMM for Rust code in kernel (i.e. avoid using
> 	Rust's own atomic).
> 
> Because kernel developers are more familiar with LKMM and when Rust code
> interacts with C code, it has to use the model that C code uses.

I think that makes sense; if nothing else it's consistent with how we handle
the C atomics today.

> And this patchset is the result of that option. I introduced an atomic
> library to wrap and implement LKMM atomics (of course, given it's a WIP,
> so it's unfinished). Things to notice:
> 
> * I know I could use Rust macro to generate the whole set of atomics,
>   but I choose not to in the beginning, as I want to make it easier to
>   review.
> 
> * Very likely, we will only have AtomicI32, AtomicI64 and AtomicUsize
>   (i.e no atomic for bool, u8, u16, etc), with limited support for
>   atomic load and store on 8/16 bits.
> 
> * I choose to re-implement atomics in Rust `asm` because we are still
>   figuring out how we can make it easy and maintainable for Rust to call
>   a C function _inlinely_ (Gary makes some progress [2]). Otherwise,
>   atomic primitives would be function calls, and that can be performance
>   bottleneck in a few cases.

I don't think we want to maintain two copies of each architecture's atomics.
This gets painful very quickly (e.g. as arm64's atomics get patched between
LL/SC and LSE forms).

Can we start off with out-of-line atomics, and see where the bottlenecks are?

It's relatively easy to do that today, at least for the atomic*_*() APIs:

  https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/commit/?h=atomics/outlined&id=e0a77bfa63e7416d610769aa4ab62bc06993ce56

... which IIUC covers the "AtomicI32, AtomicI64 and AtomicUsize" cases you
mention above.

Mark.

