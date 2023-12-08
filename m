Return-Path: <linux-fsdevel+bounces-5369-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3ED280AE10
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 21:38:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DD341F21157
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 20:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB3657884
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 20:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="r8wNqSd/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b6])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DADC81734
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Dec 2023 11:58:16 -0800 (PST)
Date: Fri, 8 Dec 2023 14:58:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702065495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TsaD7mhW8SXQP1nbpaw4AQMft3LLxjzczN7R3X3tAxQ=;
	b=r8wNqSd/u9g5IyjKN6ZrfGfi8UvmYzVZvDTBKpMA8L/A0HyY8PSd9pb9uqtoc8VJzsAm5h
	NUJSsXmCtd0WZcMtOCo+G6RmAn7Deo0J4prFrniY3miadYKZ1B7nX9m6iODDWndhIpOXF5
	MTwcc2S3heTAvuFucv4fGqpPHv3sGkw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Carlos Llamas <cmllamas@google.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Kees Cook <keescook@chromium.org>,
	Matthew Wilcox <willy@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 5/7] rust: file: add `Kuid` wrapper
Message-ID: <20231208195809.fzpezhcntqsm2ub3@moria.home.lan>
References: <20231129-alice-file-v1-0-f81afe8c7261@google.com>
 <20231129-alice-file-v1-5-f81afe8c7261@google.com>
 <20231129-etappen-knapp-08e2e3af539f@brauner>
 <20231129164815.GI23596@noisy.programming.kicks-ass.net>
 <20231130-wohle-einfuhr-1708e9c3e596@brauner>
 <20231206195911.vcp3c6q57zvkm7bf@moria.home.lan>
 <20231208162616.GH28727@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208162616.GH28727@noisy.programming.kicks-ass.net>
X-Migadu-Flow: FLOW_OUT

On Fri, Dec 08, 2023 at 05:26:16PM +0100, Peter Zijlstra wrote:
> On Wed, Dec 06, 2023 at 02:59:11PM -0500, Kent Overstreet wrote:
> 
> > I suspect even if the manpower existed to go that route we'd end up
> > regretting it, because then the Rust compiler would need to be able to
> > handle _all_ the craziness a modern C compiler knows how to do -
> > preprocessor magic/devilry isn't even the worst of it, it gets even
> > worse when you start to consider things like bitfields and all the crazy
> > __attributes__(()) people have invented.
> 
> Dude, clang can already handle all of that. Both rust and clang are
> build on top of llvm, they generate the same IR, you can simply feed a
> string into libclang and get IR out of it, which you can splice into
> your rust generated IR.

If only it were that simple :)

This is struct definitions we're talking about, not code, so what you
want isn't even IR, what you're generating is a memory layout for a
type, linked in with all your other type information.

And people critize Linux for being a giant monorepo that makes no
considerations for making our code reusable in other contexts; clang and
LLVM are no different. But that's not really the issue because you're
going to need a huge chunk of clang to even parse this stuff, what you
really want is a way to invoke clang and dump _type information_ in a
standardized, easy to consume way. What you want is actually more akin
to the debug info that's generated today.

So... yeah, sure, lovely if it existed, but not the world we live in :)

(As an aside, I've actually got an outstanding bug filed with rustc
because it needs to be able to handle types that are marked both packed
and aligned... if anyone in this thread _does_ know some rust compiler
folks, we need that for bcachefs on disk format types).

