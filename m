Return-Path: <linux-fsdevel+bounces-5514-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA0D80D04D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 16:59:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C24381F21932
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 15:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E7B4C3B8;
	Mon, 11 Dec 2023 15:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oZlTzftu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573FC268B;
	Mon, 11 Dec 2023 07:59:16 -0800 (PST)
Date: Mon, 11 Dec 2023 10:58:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702310354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iTqyHUAM8Y8CTQWaVxNypmVJd4cL32JtHj8W07cIG1s=;
	b=oZlTzftu1xM4Uy81K6BPPht40D6wXyU4rig7xmFxREm4jat2OGKs5vZf7ecwRdgGMbe+oH
	2eAWXtolC9pbNA7LfWV6t2s6db/Ow437NkbOSNWN0d+IDCiuPRtJBmBU3uQp6mJ/iSkfPn
	nBqIe+mIXVbyFDYiKbV0mZMkknokXF4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Benno Lossin <benno.lossin@proton.me>,
	Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
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
Subject: Re: [PATCH v2 5/7] rust: file: add `Kuid` wrapper
Message-ID: <20231211155836.4qb4pfcfaguhuzo7@moria.home.lan>
References: <20231206-alice-file-v2-0-af617c0d9d94@google.com>
 <20231206-alice-file-v2-5-af617c0d9d94@google.com>
 <jtCKrRw-FNajNJOXOuI1sweeDxI8T_uYnJ7DxMuqnJc9sgWjS0zouT_XIS-KmPferL7lU51BwD6nu73jZtzzB0T17pDeQP0-sFGRQxdjnaA=@proton.me>
 <ZXNHp5BoR2LJuv7D@Boquns-Mac-mini.home>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXNHp5BoR2LJuv7D@Boquns-Mac-mini.home>
X-Migadu-Flow: FLOW_OUT

On Fri, Dec 08, 2023 at 08:43:19AM -0800, Boqun Feng wrote:
> On Fri, Dec 08, 2023 at 04:40:09PM +0000, Benno Lossin wrote:
> > On 12/6/23 12:59, Alice Ryhl wrote:
> > > +    /// Returns the given task's pid in the current pid namespace.
> > > +    pub fn pid_in_current_ns(&self) -> Pid {
> > > +        // SAFETY: Calling `task_active_pid_ns` with the current task is always safe.
> > > +        let namespace = unsafe { bindings::task_active_pid_ns(bindings::get_current()) };
> > 
> > Why not create a safe wrapper for `bindings::get_current()`?
> > This patch series has three occurrences of `get_current`, so I think it
> > should be ok to add a wrapper.
> > I would also prefer to move the call to `bindings::get_current()` out of
> > the `unsafe` block.
> 
> FWIW, we have a current!() macro, we should use it here.

Why does it need to be a macro?

