Return-Path: <linux-fsdevel+bounces-15139-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D228875E7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Mar 2024 00:52:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EC17B225AB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 23:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7FED82D6C;
	Fri, 22 Mar 2024 23:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Yzb4FpFb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDD88289A;
	Fri, 22 Mar 2024 23:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711151546; cv=none; b=Ks/te+tAwwk0y/4JDYvlJPVkt6wYgvkUt/DrXvORvzYD7EMl7LdTcdQUtHzAAwYZneVUaEFgLYRfWf6L+zH9oHSJJgQGinwxDS8TGoQkfO7nF25Vqft6p/WFsQTDCbogHJqwImll1YRXOpdRSx3d8LXz872t12SmEkViG+jxkZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711151546; c=relaxed/simple;
	bh=acK5gS17AR6b39Fe+zrX9Reb0a2fMoJXlVkZ7SeAiTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h77Ksn7x6VUvTJTKnkBWK8hPBR+Y6t5ACWWmwQLeB++FvFm+Em6v9KpaIpV4NBBf1WrN0RWQzTKOg+hJLSJmVTPGe57Qwn0KgVLkRR2zSIa/+1iCb/zIn2orTbBuwEr70AzUMGrjFbZpQl0ppU8DX1x58HVAbM/yMWXxqd0ITac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Yzb4FpFb; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=cEgMG+B69ydCKnKl83inO8Zb3qtJvyCD019Uz+hkzzs=; b=Yzb4FpFbbjxyKfNEFDXEBWqApc
	jlI5wLrK3xiUk8/C5YI2s7752c36lq1M+Acb56T2p7PR9M1XrfmeTL5k+TB18q/rNhtriReYIHqnS
	AsOZCRMQlTkPsR0D+EzYenA28rGtczCmVVD+Jb4/qF6Vb/66+JYpPE4cooaHq92glorQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rnogC-00AzgP-5Q; Sat, 23 Mar 2024 00:52:08 +0100
Date: Sat, 23 Mar 2024 00:52:08 +0100
From: Andrew Lunn <andrew@lunn.ch>
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
Message-ID: <068a5983-8216-48a5-9eb5-784a42026836@lunn.ch>
References: <20240322233838.868874-1-boqun.feng@gmail.com>
 <20240322233838.868874-2-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240322233838.868874-2-boqun.feng@gmail.com>

> +//! These primitives should have the same semantics as their C counterparts, for precise definitions
> +//! of the semantics, please refer to tools/memory-model. Note that Linux Kernel Memory
> +//! (Consistency) Model is the only model for Rust development in kernel right now, please avoid to
> +//! use Rust's own atomics.

Is it possible to somehow poison rusts own atomics?  I would not be
too surprised if somebody with good Rust knowledge but new to the
kernel tries using Rusts atomics. Either getting the compiler to fail
the build, or it throws an Opps on first invocation would be good.

    Andrew

