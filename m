Return-Path: <linux-fsdevel+bounces-4547-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B1D4800852
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 11:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32D972813F9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 10:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB5A720B21
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 10:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="d7iw7/7V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B66E1700;
	Fri,  1 Dec 2023 01:01:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Y5uy0MWBWonI5NFoxzOx49kq9VkUlR2QCbejhy+1wrw=; b=d7iw7/7VqyuiiFGnXN/Iv8/rhp
	DKaeRnJK0R1GWrRLXEyYN87/g237v2HeFk8sjr1hdTYbOuQn7fK7iP48jyDb+OMooT6dB66DY5up6
	B6BJ58KjpPUNXdvjD8toyEEGKpu4zClJexJKZM5/MiT4uL4QDlnAP2BcpoIPthAkPrnjBUS872WmL
	35pMQ1MmeQAG9KicW0gt+mPYkuZqnXGquaWMZM5U4VMUCSr4ihufvyCnGBZ+kzRBsFNu+WETdM+RQ
	pYUSoYf5k9M9yU/UZN1rk1Tq0OVQu5m6gnvEZ5y3b4t2kn5DehmXJgY4ETB0UwoM8fO/IunW7JqKx
	440EuXMQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1r8zO4-0029xu-1C;
	Fri, 01 Dec 2023 09:00:43 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 056A830040C; Fri,  1 Dec 2023 10:00:40 +0100 (CET)
Date: Fri, 1 Dec 2023 10:00:39 +0100
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
Message-ID: <20231201090039.GF3818@noisy.programming.kicks-ass.net>
References: <20231129-alice-file-v1-0-f81afe8c7261@google.com>
 <20231129-alice-file-v1-1-f81afe8c7261@google.com>
 <ZWdVEk4QjbpTfnbn@casper.infradead.org>
 <20231129152305.GB23596@noisy.programming.kicks-ass.net>
 <ZWdv_jsaDFJxZk7G@Boquns-Mac-mini.home>
 <20231130104226.GB20191@noisy.programming.kicks-ass.net>
 <ZWipTZysC2YL7qsq@Boquns-Mac-mini.home>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWipTZysC2YL7qsq@Boquns-Mac-mini.home>

On Thu, Nov 30, 2023 at 07:25:01AM -0800, Boqun Feng wrote:

> seems to me, the plan for this is something like below:
> 
> 	asm!(
> 		"cmp {}, 42",
> 		"jeq {}",
> 		in(reg) val,
> 		label { println!("a"); },
> 		fallthrough { println!("b"); }
>     	);

Because rust has horrible syntax I can't parse, I can't tell if this is
useful or not :/ Can this be used to implement arch_static_branch*() ?

