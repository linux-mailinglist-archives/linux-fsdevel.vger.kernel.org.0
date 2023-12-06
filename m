Return-Path: <linux-fsdevel+bounces-5048-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3845807978
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 21:36:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55FEDB20B49
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 20:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF22E4B144
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 20:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DSiuBhxP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3CB011F
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Dec 2023 12:05:11 -0800 (PST)
Date: Wed, 6 Dec 2023 15:05:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1701893109;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DVvoOu1nO86z3rBa8QuPbOMrMP9wXD66qlron+EA3cE=;
	b=DSiuBhxPyccRtaejPvhXZlfY+WUmmoAG44XwRHcEdfGJBybAFDIVPzSo5beyiAod1NLpqs
	weR1wnTb3NW0mykvRvaRUtxrAKom72MmdaTaRfkE7TpFUmBBxHibdx33wzqmmVwJ93iCbK
	K+vNgW4NlzokdYfH2sJudsiA3i2BwfY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Christian Brauner <brauner@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Peter Zijlstra <peterz@infradead.org>,
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
Subject: Re: [PATCH 0/7] File abstractions needed by Rust Binder
Message-ID: <20231206200505.nsmauqpetkyisyjd@moria.home.lan>
References: <20231129-alice-file-v1-0-f81afe8c7261@google.com>
 <20231129-mitsingen-umweltschutz-c6f8d9569234@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231129-mitsingen-umweltschutz-c6f8d9569234@brauner>
X-Migadu-Flow: FLOW_OUT

On Wed, Nov 29, 2023 at 05:31:44PM +0100, Christian Brauner wrote:
> On Wed, Nov 29, 2023 at 12:51:06PM +0000, Alice Ryhl wrote:
> > This patchset contains the file abstractions needed by the Rust
> > implementation of the Binder driver.
> > 
> > Please see the Rust Binder RFC for usage examples:
> > https://lore.kernel.org/rust-for-linux/20231101-rust-binder-v1-0-08ba9197f637@google.com/
> > 
> > Users of "rust: file: add Rust abstraction for `struct file`":
> > 	[PATCH RFC 02/20] rust_binder: add binderfs support to Rust binder
> > 	[PATCH RFC 03/20] rust_binder: add threading support
> > 
> > Users of "rust: cred: add Rust abstraction for `struct cred`":
> > 	[PATCH RFC 05/20] rust_binder: add nodes and context managers
> > 	[PATCH RFC 06/20] rust_binder: add oneway transactions
> > 	[PATCH RFC 11/20] rust_binder: send nodes in transaction
> > 	[PATCH RFC 13/20] rust_binder: add BINDER_TYPE_FD support
> > 
> > Users of "rust: security: add abstraction for security_secid_to_secctx":
> > 	[PATCH RFC 06/20] rust_binder: add oneway transactions
> > 
> > Users of "rust: file: add `FileDescriptorReservation`":
> > 	[PATCH RFC 13/20] rust_binder: add BINDER_TYPE_FD support
> > 	[PATCH RFC 14/20] rust_binder: add BINDER_TYPE_FDA support
> > 
> > Users of "rust: file: add kuid getters":
> > 	[PATCH RFC 05/20] rust_binder: add nodes and context managers
> > 	[PATCH RFC 06/20] rust_binder: add oneway transactions
> > 
> > Users of "rust: file: add `DeferredFdCloser`":
> > 	[PATCH RFC 14/20] rust_binder: add BINDER_TYPE_FDA support
> > 
> > Users of "rust: file: add abstraction for `poll_table`":
> > 	[PATCH RFC 07/20] rust_binder: add epoll support
> > 
> > This patchset has some uses of read_volatile in place of READ_ONCE.
> > Please see the following rfc for context on this:
> > https://lore.kernel.org/all/20231025195339.1431894-1-boqun.feng@gmail.com/
> > 
> > This was previously sent as an rfc:
> > https://lore.kernel.org/all/20230720152820.3566078-1-aliceryhl@google.com/
> > 
> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> > ---
> > Alice Ryhl (4):
> >       rust: security: add abstraction for security_secid_to_secctx
> >       rust: file: add `Kuid` wrapper
> >       rust: file: add `DeferredFdCloser`
> >       rust: file: add abstraction for `poll_table`
> > 
> > Wedson Almeida Filho (3):
> >       rust: file: add Rust abstraction for `struct file`
> >       rust: cred: add Rust abstraction for `struct cred`
> >       rust: file: add `FileDescriptorReservation`
> > 
> >  rust/bindings/bindings_helper.h |   9 ++
> >  rust/bindings/lib.rs            |   1 +
> >  rust/helpers.c                  |  94 +++++++++++
> >  rust/kernel/cred.rs             |  73 +++++++++
> >  rust/kernel/file.rs             | 345 ++++++++++++++++++++++++++++++++++++++++
> >  rust/kernel/file/poll_table.rs  |  97 +++++++++++
> 
> That's pretty far away from the subsystem these wrappers belong to. I
> would prefer if wrappers such as this would live directly in fs/rust/
> and so live within the subsystem they belong to. I think I mentioned
> that before. Maybe I missed some sort of agreement here?

I spoke to Miguel about this and it was my understanding that everything
was in place for moving Rust wrappers to the proper directory -
previously there was build system stuff blocking, but he said that's all
working now. Perhaps the memo just didn't get passed down?

(My vote would actually be for fs/ directly, not fs/rust, and a 1:1
mapping between .c files and the .rs files that wrap them).

