Return-Path: <linux-fsdevel+bounces-21596-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 244EB90637F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 07:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBF0B1F235DC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 05:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F851369A4;
	Thu, 13 Jun 2024 05:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="l/xnAPnX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78704136982;
	Thu, 13 Jun 2024 05:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718257135; cv=none; b=quNbL+sh1eBicCLd7Us4UsHxJBl+4KEhsuqEAYEG2BWop5qRaToN45PRUHwzRWkd41U3yFwWsnXyMOeKqyCXB/8HI3R9KUq8tuQJlF6FrEaYB22qowmvqLlI9mGCBavrPImzxoKny74HmVW+cGL7hjIuows1tF/PFUFsooD/MQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718257135; c=relaxed/simple;
	bh=wPBovtDejZJ6K/KLoKALU7fnSUOeof+FbKpgp7tgs/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uD+A1oXHf7E9TQIzCYi2YO9lcNZu6ZjO7zTk6JG8CgnyP2BxyHauplCmcnilAZqJX18Z6CsCN9ET03rIlFbPrVlOM6uTtDAYCpz3NIAmdCuo2YUq2a1dycKojmc5Ywngc/dLSb3lq70AX5mKVKcsGtO06w+zsjGhh8skA1C484k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=l/xnAPnX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64240C2BBFC;
	Thu, 13 Jun 2024 05:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718257135;
	bh=wPBovtDejZJ6K/KLoKALU7fnSUOeof+FbKpgp7tgs/w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l/xnAPnXrPLIUqYbbrYEkEYIHpL5HXBAFLTC8PdO6M5Z2JyavAl6DyBowaNaB60Bh
	 FPTqi+S1JJB3FY+3QbundTkRGWWIn5L4alFqkQPyGOE67J5pugMEgJZ5pIsApHaI7y
	 wcZm4/ShNyyFiU0mGHLXYXUQE6iRRxE5jbZCUKyM=
Date: Thu, 13 Jun 2024 07:38:51 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
Message-ID: <2024061341-whole-snowfall-89a6@gregkh>
References: <20240612223025.1158537-1-boqun.feng@gmail.com>
 <20240612223025.1158537-2-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240612223025.1158537-2-boqun.feng@gmail.com>

On Wed, Jun 12, 2024 at 03:30:24PM -0700, Boqun Feng wrote:
> +// Generated by scripts/atomic/gen-rust-atomic-helpers.sh
> +// DO NOT MODIFY THIS FILE DIRECTLY

Why not just build this at build time and not check the file into the
tree if it is always automatically generated?  That way it never gets
out of sync.  We do this for other types of auto-generated files in the
kernel today already.

thanks,

greg k-h

