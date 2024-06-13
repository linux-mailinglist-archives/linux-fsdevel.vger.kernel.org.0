Return-Path: <linux-fsdevel+bounces-21626-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF600906863
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 11:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 021EF1C24584
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 09:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35C614037C;
	Thu, 13 Jun 2024 09:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="A0TLT7/3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6531513E8A7;
	Thu, 13 Jun 2024 09:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718270294; cv=none; b=OKfdBTLOYaoM6ETT12uRUlEz0LvhVleSfWrUh75/EGq2p/w4tpji+1hS9bBwBPFzf9nofVZoS8enbIzEC59iWoTdl+Fdg+DDR9FHHgRXsioHRFdUiVYuYQm8qwAwt23kPK2TB/rReBJrDhOjFaObGAJkwMvR8AmQvjL2yJpnMVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718270294; c=relaxed/simple;
	bh=j57AjH7vWOzLYS8GEi6N0Sm4lqhf9PnfiNNs+BWRZvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ub9Sul6WhfiOSoZL6TupcoJSA6XFzYzfR9cPjZrtZ6TQmCVJEQeYm8tdR8QfzIui21jcwfDOqK0/dJGkfyjdzjZuxFuWtcZmv47TKSob4R0Bnt9NEVGB7Y3b7sbZEDHBfzWrmXnkS9HbstOpLSq1R58Li/BRmjQ2Or+TLt9EZP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=A0TLT7/3; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=p0dnDPDEIYuJ2y75CbrgMsy67e1FESlmVsvTOPepdeA=; b=A0TLT7/3PW8jq4FG22ssotSS0g
	zPEMM2uzluilJ2tNOjM9f5NZ6KZM2OQshkLdPgKv+9qmi+fIk9ccNkgp82a7JoC9sCGKPOG1eN6ZK
	fLtadKbtssSZyz+uAin1jf6o+EDnhCxsprUnKhbmaxCAdSCtSINGkMzMb9Sa8yQr+d8UJrIW4e37c
	Z7NIv6OC2+S2ZHiBSzwmuYy9biFMMC+KNad4ogL57b1BoNyAUNeuFmNTetACp01Gh8YYGucXUvY1w
	8ZL4IUDpKPtuypRva/qqBvfWB1zmtJIqc6lwu58UdEw3eYOIvsTlkddi7wZMC0I1YWt8D1tkXCRk/
	fWpzxxjQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHgaW-00000003Uvs-2WWA;
	Thu, 13 Jun 2024 09:17:48 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 4C42E300B40; Thu, 13 Jun 2024 11:17:47 +0200 (CEST)
Date: Thu, 13 Jun 2024 11:17:47 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
Message-ID: <20240613091747.GB17707@noisy.programming.kicks-ass.net>
References: <20240612223025.1158537-1-boqun.feng@gmail.com>
 <20240612223025.1158537-2-boqun.feng@gmail.com>
 <2024061341-whole-snowfall-89a6@gregkh>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024061341-whole-snowfall-89a6@gregkh>

On Thu, Jun 13, 2024 at 07:38:51AM +0200, Greg Kroah-Hartman wrote:
> On Wed, Jun 12, 2024 at 03:30:24PM -0700, Boqun Feng wrote:
> > +// Generated by scripts/atomic/gen-rust-atomic-helpers.sh
> > +// DO NOT MODIFY THIS FILE DIRECTLY
> 
> Why not just build this at build time and not check the file into the
> tree if it is always automatically generated?  That way it never gets
> out of sync.  We do this for other types of auto-generated files in the
> kernel today already.

Part of the problem is, is that a *TON* of files depend on the atomic.h
headers. If we'd generate it on every build, you'd basically get to
rebuild the whole kernel every single time.

Also, these files don't change too often. And if you look, there's a
hash in those files which is used to check if things somehow got stale.

