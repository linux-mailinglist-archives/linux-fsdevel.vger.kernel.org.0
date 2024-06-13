Return-Path: <linux-fsdevel+bounces-21630-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3B5906A25
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 12:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE26B2817F4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 10:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 276D41428F2;
	Thu, 13 Jun 2024 10:36:27 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633C025632;
	Thu, 13 Jun 2024 10:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718274986; cv=none; b=b0z2+vRFtNbsGtRSzTZBvxDzirSZ/SgbSwz+UCEiDSHbsA0usAbG9R60h55u+su++pl81lOa6pOLVTofLQJfP6Fj/BcykqpQ4wZRqAfjUx2HDgboiRdMSay01NwV2k75CsrrfZef2osTTY2ijzAsSRvQInEnmevc1NLMg2toMsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718274986; c=relaxed/simple;
	bh=cHpapWwllRR92WhnROTVW7uuoH/zjVZME5D0Uwcllug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nFCdRzakVCdoG/G+WWu26nBhHmeEZcLdDqcRVoykWKUeiimrjmdDslp/mHZPrb2aU0SC3R3psftxrijHZc9r+jKGVNivZ8AOdcjPpcSFD1BPNTyecmuUdubcv44gONbq3YnHkaecqzah69Gti5z4N5tWKZHeECJUyiTsEgFCuXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4C82113D5;
	Thu, 13 Jun 2024 03:36:43 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CD2203F5A1;
	Thu, 13 Jun 2024 03:36:12 -0700 (PDT)
Date: Thu, 13 Jun 2024 11:36:10 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Boqun Feng <boqun.feng@gmail.com>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	llvm@lists.linux.dev, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
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
	kent.overstreet@gmail.com, elver@google.com,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	torvalds@linux-foundation.org, linux-arm-kernel@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, Trevor Gross <tmgross@umich.edu>,
	dakr@redhat.com
Subject: Re: [RFC 1/2] rust: Introduce atomic API helpers
Message-ID: <ZmrLmnPz_0Q8oXny@J2N7QTR9R3>
References: <20240612223025.1158537-1-boqun.feng@gmail.com>
 <20240612223025.1158537-2-boqun.feng@gmail.com>
 <2024061341-whole-snowfall-89a6@gregkh>
 <20240613091747.GB17707@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613091747.GB17707@noisy.programming.kicks-ass.net>

On Thu, Jun 13, 2024 at 11:17:47AM +0200, Peter Zijlstra wrote:
> On Thu, Jun 13, 2024 at 07:38:51AM +0200, Greg Kroah-Hartman wrote:
> > On Wed, Jun 12, 2024 at 03:30:24PM -0700, Boqun Feng wrote:
> > > +// Generated by scripts/atomic/gen-rust-atomic-helpers.sh
> > > +// DO NOT MODIFY THIS FILE DIRECTLY
> > 
> > Why not just build this at build time and not check the file into the
> > tree if it is always automatically generated?  That way it never gets
> > out of sync.  We do this for other types of auto-generated files in the
> > kernel today already.
> 
> Part of the problem is, is that a *TON* of files depend on the atomic.h
> headers. If we'd generate it on every build, you'd basically get to
> rebuild the whole kernel every single time.
> 
> Also, these files don't change too often. And if you look, there's a
> hash in those files which is used to check if things somehow got stale.

That and:

1) The generation is currently slow (multiple seconds), which gets
   people angry if they have to wait for it for a clean build. Improving
   that would require changing the way we generate the headers (e.g.
   rewrite that in something else to avoid the subshell fork problem).

   Last I looked there wasn't an obvious better way to do this, because
   nice options ended up pulling in more build-time dependencies.

2) Linus wanted git grep to work, which meant checking in the generated
   files:

   https://lore.kernel.org/all/CA+55aFxjU0op8QLLu0n-RjHBs7gQsLvD8jcyedgw6jeZFN7B+Q@mail.gmail.com/

Mark.

