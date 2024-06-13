Return-Path: <linux-fsdevel+bounces-21597-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A2C4906382
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 07:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89AB92841DE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 05:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3A913699A;
	Thu, 13 Jun 2024 05:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="W0eg7I6U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045FA44C86;
	Thu, 13 Jun 2024 05:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718257208; cv=none; b=RX9hUzBDdLKT/TemmJ10UR0Nd26csLosVY2thcJF3jzxW84HU0dgdM3IbvuCNsSwqwNwBpjH7JiW9Z58yaDW3BeJpymEZzrhEbGGwcWL5SNzM9dUoMhsJs8bLmkqNyAEfpTwmi76b2G0L3pBw5Q7TTz8zpzetzW0KiBK4DDiQj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718257208; c=relaxed/simple;
	bh=ZcYTQFWs5+97Y49ShyJGWZXOwlDhMY34Jftimf0oxws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=euhnJQjeuwMD7rvqCMSD5pqx+sAAKnyh9rvmTK7lT+MBg6YxJr49d35LdAfeatgJscn2i1qcu8g6WjQrqzhr8ma8rJuqRddjzq3kcBo9Tf8fjxpsffKfp6yDoxP2chUta23pH9vR0My9dtJ5gWeKqt16M46TPkrEHxm6a98xf7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=W0eg7I6U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC6CDC2BBFC;
	Thu, 13 Jun 2024 05:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718257207;
	bh=ZcYTQFWs5+97Y49ShyJGWZXOwlDhMY34Jftimf0oxws=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W0eg7I6UwZWJCF3Nborq1V0QGwtPnyFwcJ6uuPowJNY0HJJLn4RRmb2/DWPN5RnbA
	 Y/VLxnIUqobXvf5llPnQTCA+dUKbpFSIJ0LMLkRthOl3edJhorS8D2zG/clLROt6J6
	 FIjGgs2OgvYPjQmpukp5A2JMX0tpZuTOy406nH9U=
Date: Thu, 13 Jun 2024 07:40:04 +0200
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
Subject: Re: [RFC 2/2] rust: sync: Add atomic support
Message-ID: <2024061340-charger-discourse-f077@gregkh>
References: <20240612223025.1158537-1-boqun.feng@gmail.com>
 <20240612223025.1158537-3-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240612223025.1158537-3-boqun.feng@gmail.com>

On Wed, Jun 12, 2024 at 03:30:25PM -0700, Boqun Feng wrote:
> --- /dev/null
> +++ b/rust/kernel/sync/atomic/impl.rs
> @@ -0,0 +1,1375 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Generated by scripts/atomic/gen-rust-atomic.sh
> +//! DO NOT MODIFY THIS FILE DIRECTLY

Again, why not generate at build time?

thanks,

greg k-h

