Return-Path: <linux-fsdevel+bounces-21628-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C7D906990
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 12:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1158B1F23023
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 10:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1FC1411D6;
	Thu, 13 Jun 2024 10:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NqNPZhTJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BCF134409;
	Thu, 13 Jun 2024 10:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718272987; cv=none; b=tC7jmHQ9xKhItrBQXQmYz3FNHLKDQNA0/x0CHLf9TVenGVNn4eNR4TcU+00DL7Sm9HaKSjipj1LZizmpsgkEwqggt6xygjDcKKX0z4PFYt5QVB0Y+b0ixzCXi2vkzdT11MbzgukLnXhFWUqry13PeW52lraB/drG9bw09kCCeHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718272987; c=relaxed/simple;
	bh=CqHO2/KK7eIKe3EFoA4TtHPEMTMPdLClBxAJ4UmrvLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KXEbRwvpUv0yDre/bda07f9U93V5poLFzW8WRCqXVi3juaBI/RjmH5CmvqwrsdZwxAgvZ1OnCZMwtzsoVbOQotE8mnl7Vg5APzQQAAT21ifCZBx9XtcMwA58yBnjXizWxf/jHl6pVkA6HIdkNwFI2GvoXODN9gU1Ylu4Ss34FHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NqNPZhTJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18679C2BBFC;
	Thu, 13 Jun 2024 10:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718272986;
	bh=CqHO2/KK7eIKe3EFoA4TtHPEMTMPdLClBxAJ4UmrvLg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NqNPZhTJEpyCvzXfGU5AnNh2gavLMwsYzQ5eTYx5mLDPdSSIqSRAKZLJPIpCHaYJR
	 ZbGmNlNWp/ql5XfAGCsjaIZewR5YWdNBQPF/JbE+b4CeU2YsQUlvxT4PItgpgWF4TL
	 CUhzvnxOEk/9SvVUdnWqARHGMUiC0hjz2Vn2kezE=
Date: Thu, 13 Jun 2024 12:03:03 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, rust-for-linux@vger.kernel.org,
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
	Mark Rutland <mark.rutland@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	torvalds@linux-foundation.org, linux-arm-kernel@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, Trevor Gross <tmgross@umich.edu>,
	dakr@redhat.com
Subject: Re: [RFC 1/2] rust: Introduce atomic API helpers
Message-ID: <2024061353-stillness-unearned-dc4f@gregkh>
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

Ok, fair enough, if you all don't think this will change often...

