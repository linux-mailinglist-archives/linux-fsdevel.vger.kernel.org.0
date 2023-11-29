Return-Path: <linux-fsdevel+bounces-4216-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F187FDD52
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 17:38:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EC351F20F86
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 16:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29413B783
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 16:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gyVeEX6f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27C3210E5;
	Wed, 29 Nov 2023 07:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7wC+SUX8Lci4mgC43CU9lNbkaIyYQmQqt28/ZZo7MdQ=; b=gyVeEX6f4oIWr2q5CEBXAuvFHX
	L37ewXQQCp97LuXd0NiaKmcLhHzgr7ud1rq8JsFVvO5qMYWUFb21Sr7j2PtB0g86Y/p+1OQjgwzYW
	g+LHXhLTi5LWseAZNSd+t187jv9HgYH/+5cflPOVNL4fpwvXeS/c0di/iLR6ZLGkQCF0WOUSw8V7J
	RWDGsdSQFlY7Xo4KGoodUI3ENP7k6VnrV/T0zBGm/wjFyhDmmSlTH8MVh0uC7hGTRr1+vYzhKruYS
	h4Wvp95Jh8msaACPgUlESic0u3FzS6utXWuXU+WhidPrRGT8w+qI6253g2cNF7zKiE59vQZaIKgtA
	/ZLtF3bA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1r8MP4-00DWAy-Cf; Wed, 29 Nov 2023 15:23:06 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A817530017D; Wed, 29 Nov 2023 16:23:05 +0100 (CET)
Date: Wed, 29 Nov 2023 16:23:05 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
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
Message-ID: <20231129152305.GB23596@noisy.programming.kicks-ass.net>
References: <20231129-alice-file-v1-0-f81afe8c7261@google.com>
 <20231129-alice-file-v1-1-f81afe8c7261@google.com>
 <ZWdVEk4QjbpTfnbn@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWdVEk4QjbpTfnbn@casper.infradead.org>

On Wed, Nov 29, 2023 at 03:13:22PM +0000, Matthew Wilcox wrote:

> > @@ -157,6 +158,12 @@ void rust_helper_init_work_with_key(struct work_struct *work, work_func_t func,
> >  }
> >  EXPORT_SYMBOL_GPL(rust_helper_init_work_with_key);
> >  
> > +struct file *rust_helper_get_file(struct file *f)
> > +{
> > +	return get_file(f);
> > +}
> > +EXPORT_SYMBOL_GPL(rust_helper_get_file);
> 
> This is ridiculous.  A function call instead of doing the
> atomic_long_inc() in Rust?

Yeah, I complained about something similar a while ago. And recently
talked to Boqun about this as well,

Bindgen *could* in theory 'compile' the inline C headers into (unsafe)
Rust, the immediate problem is that Rust has a wildly different inline
asm syntax (because Rust needs terrible syntax or whatever).

Boqun said it should all be fixable, but is a non-trivial amount of
work.


