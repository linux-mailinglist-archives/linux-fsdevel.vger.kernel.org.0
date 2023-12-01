Return-Path: <linux-fsdevel+bounces-4552-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0460A80085E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 11:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35DD11C20F31
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 10:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94043210E7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 10:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="n0r80qg2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 965D593;
	Fri,  1 Dec 2023 01:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=XNeUocVmGbm3ocmLAHCGAblGlIvYZUei+z/qerXS7Xo=; b=n0r80qg2hFc8o/xbFfUcnb8N2O
	MmQt+VYhfmlp8oN8P0/t42PwjoH6276YAc7dwvM3xMdBIXJdBJ4pB58PDEAzt61nxeEENIqIGWC5X
	p9hCKS4uCPSMCUVf8b5GVSvCqb9HJVgMBaU75pHajL92qihCbi8CkAQhi4cDqnr/chNHHXCxJwvyx
	JNEQkEIfk79CFtJaUbHEz1ymPMc4Nd2kB56Jc08HZ400gfGbXeKaVTrBUM/kO1TEM64DHCWW/h+wr
	6BPEiNjRtfT8XKSYy3nh8CoEIVk3bZvdDfhRn7RCw3+cUuWbo+oWWfHR6wBwKVszqHMvhHZH5TUFv
	khsOcfZA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1r900k-00FOrC-H7; Fri, 01 Dec 2023 09:40:39 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C9879300311; Fri,  1 Dec 2023 10:40:37 +0100 (CET)
Date: Fri, 1 Dec 2023 10:40:37 +0100
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
	linux-fsdevel@vger.kernel.org,
	Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH 1/7] rust: file: add Rust abstraction for `struct file`
Message-ID: <20231201094037.GI3818@noisy.programming.kicks-ass.net>
References: <20231129-alice-file-v1-0-f81afe8c7261@google.com>
 <20231129-alice-file-v1-1-f81afe8c7261@google.com>
 <ZWdVEk4QjbpTfnbn@casper.infradead.org>
 <20231129152305.GB23596@noisy.programming.kicks-ass.net>
 <ZWdv_jsaDFJxZk7G@Boquns-Mac-mini.home>
 <20231130104226.GB20191@noisy.programming.kicks-ass.net>
 <ZWipTZysC2YL7qsq@Boquns-Mac-mini.home>
 <20231201085328.GE3818@noisy.programming.kicks-ass.net>
 <ZWmlEiiPXAIOYsM1@Boquns-Mac-mini.home>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWmlEiiPXAIOYsM1@Boquns-Mac-mini.home>

On Fri, Dec 01, 2023 at 01:19:14AM -0800, Boqun Feng wrote:

> > > 	https://github.com/Amanieu/rfcs/blob/inline-asm/text/0000-inline-asm.md#asm-goto
> > 
> > Reading that makes all this even worse, apparently rust can't even use
> > memops.
> 
> What do you mean by "memops"?

Above link has the below in "future possibilities":

"Memory operands

We could support mem as an alternative to specifying a register class
which would leave the operand in memory and instead produce a memory
address when inserted into the asm string. This would allow generating
more efficient code by taking advantage of addressing modes instead of
using an intermediate register to hold the computed address."

Just so happens that every x86 atomic block uses memops.. and per-cpu
and ...



