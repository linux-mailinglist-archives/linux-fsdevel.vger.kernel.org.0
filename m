Return-Path: <linux-fsdevel+bounces-4358-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E5B7FEF3B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 13:38:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE7A7B20B4B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 12:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768AB38DDE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 12:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XCEugS2X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D859B10D1;
	Thu, 30 Nov 2023 02:42:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hyrv81R5Ub/RrtryIRWyveNrWyfgqiq7YVnqYjKCqPM=; b=XCEugS2XJXylp1LUwX4VzdjfP2
	cmkjBz9mLmbbRowqsmXCBuF6TRDGV37ygXMkckfjwHBVK3SytxDX0Riwzm/u8nTyq9Rv/OrfsRRx5
	wnWw8A7giy5IVw14Xg2wcxUO5EzdArsuPjZDAkgPyN/hzZLEAnvkkGsT94M7udkanFrWCpxnJY7Sf
	GzNwDtfUW6roa92fyikzAjzYsK5dMcKU0WKv+6P4NsJ6GmXzEERt39W1PdcE4238KedfxGDRmNzFH
	YExvKpkXpOpVcnYRWuiE/kVulhb93Ah4ck9vBUboCgy/aWFAKVPM4oSQMgsGJ1HSunTp9r6hwRT6V
	Y8s5t6CA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1r8eV1-0011qr-1F;
	Thu, 30 Nov 2023 10:42:27 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 0BD87300293; Thu, 30 Nov 2023 11:42:27 +0100 (CET)
Date: Thu, 30 Nov 2023 11:42:26 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>, Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Carlos Llamas <cmllamas@google.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Kees Cook <keescook@chromium.org>,
	Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/7] rust: file: add Rust abstraction for `struct file`
Message-ID: <20231130104226.GB20191@noisy.programming.kicks-ass.net>
References: <20231129-alice-file-v1-0-f81afe8c7261@google.com>
 <20231129-alice-file-v1-1-f81afe8c7261@google.com>
 <ZWdVEk4QjbpTfnbn@casper.infradead.org>
 <20231129152305.GB23596@noisy.programming.kicks-ass.net>
 <ZWdv_jsaDFJxZk7G@Boquns-Mac-mini.home>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWdv_jsaDFJxZk7G@Boquns-Mac-mini.home>

On Wed, Nov 29, 2023 at 09:08:14AM -0800, Boqun Feng wrote:

> But but but, I then realized we have asm goto in C but Rust doesn't
> support them, and I haven't thought through how hard tht would be..

You're kidding right?

I thought we *finally* deprecated all compilers that didn't support
asm-goto and x86 now mandates asm-goto to build, and then this toy
language comes around ?

What a load of crap ... 

