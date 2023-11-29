Return-Path: <linux-fsdevel+bounces-4223-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8647D7FDD5A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 17:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ED782825FB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 16:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9853B780
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 16:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f5uUeUH6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83653B286;
	Wed, 29 Nov 2023 16:31:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 540D9C433C7;
	Wed, 29 Nov 2023 16:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701275513;
	bh=oeU9mJXNv22m4r52x0N8/9ZuPInwmlkw3ATWm9P9Cuo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f5uUeUH6sjnbA0eYQEji83M7RGbEQEXqKlIRrMRKUNcZ3ttH2/9R9LJZprO9hdZB0
	 OOChZr5JhbaymIJdJn2tYG5isatJ0BEXr5KMMvlvlfv08My8gB7DggTN/mV6zCgkal
	 bP8nZ3cx3julG9+bzIDhu8ojwiSI5Kv5K0FrVZnPB6pYdqkd7rCm04oktDx6V/bgWY
	 L1/eZnzL30J/+ydZezISNuByuKguIKo/1XqIFsbVbUmAf0FoZJzE2d2tKkSAVYiDwZ
	 2KHlT6dSSuXsCIhbMuKs+z1oceVjPMrETSIy0qNnM+sTXSxK6sPT5qIdbRvtgeJktc
	 fAqEGaWUUYgIA==
Date: Wed, 29 Nov 2023 17:31:44 +0100
From: Christian Brauner <brauner@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
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
Message-ID: <20231129-mitsingen-umweltschutz-c6f8d9569234@brauner>
References: <20231129-alice-file-v1-0-f81afe8c7261@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231129-alice-file-v1-0-f81afe8c7261@google.com>

On Wed, Nov 29, 2023 at 12:51:06PM +0000, Alice Ryhl wrote:
> This patchset contains the file abstractions needed by the Rust
> implementation of the Binder driver.
> 
> Please see the Rust Binder RFC for usage examples:
> https://lore.kernel.org/rust-for-linux/20231101-rust-binder-v1-0-08ba9197f637@google.com/
> 
> Users of "rust: file: add Rust abstraction for `struct file`":
> 	[PATCH RFC 02/20] rust_binder: add binderfs support to Rust binder
> 	[PATCH RFC 03/20] rust_binder: add threading support
> 
> Users of "rust: cred: add Rust abstraction for `struct cred`":
> 	[PATCH RFC 05/20] rust_binder: add nodes and context managers
> 	[PATCH RFC 06/20] rust_binder: add oneway transactions
> 	[PATCH RFC 11/20] rust_binder: send nodes in transaction
> 	[PATCH RFC 13/20] rust_binder: add BINDER_TYPE_FD support
> 
> Users of "rust: security: add abstraction for security_secid_to_secctx":
> 	[PATCH RFC 06/20] rust_binder: add oneway transactions
> 
> Users of "rust: file: add `FileDescriptorReservation`":
> 	[PATCH RFC 13/20] rust_binder: add BINDER_TYPE_FD support
> 	[PATCH RFC 14/20] rust_binder: add BINDER_TYPE_FDA support
> 
> Users of "rust: file: add kuid getters":
> 	[PATCH RFC 05/20] rust_binder: add nodes and context managers
> 	[PATCH RFC 06/20] rust_binder: add oneway transactions
> 
> Users of "rust: file: add `DeferredFdCloser`":
> 	[PATCH RFC 14/20] rust_binder: add BINDER_TYPE_FDA support
> 
> Users of "rust: file: add abstraction for `poll_table`":
> 	[PATCH RFC 07/20] rust_binder: add epoll support
> 
> This patchset has some uses of read_volatile in place of READ_ONCE.
> Please see the following rfc for context on this:
> https://lore.kernel.org/all/20231025195339.1431894-1-boqun.feng@gmail.com/
> 
> This was previously sent as an rfc:
> https://lore.kernel.org/all/20230720152820.3566078-1-aliceryhl@google.com/
> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
> Alice Ryhl (4):
>       rust: security: add abstraction for security_secid_to_secctx
>       rust: file: add `Kuid` wrapper
>       rust: file: add `DeferredFdCloser`
>       rust: file: add abstraction for `poll_table`
> 
> Wedson Almeida Filho (3):
>       rust: file: add Rust abstraction for `struct file`
>       rust: cred: add Rust abstraction for `struct cred`
>       rust: file: add `FileDescriptorReservation`
> 
>  rust/bindings/bindings_helper.h |   9 ++
>  rust/bindings/lib.rs            |   1 +
>  rust/helpers.c                  |  94 +++++++++++
>  rust/kernel/cred.rs             |  73 +++++++++
>  rust/kernel/file.rs             | 345 ++++++++++++++++++++++++++++++++++++++++
>  rust/kernel/file/poll_table.rs  |  97 +++++++++++

That's pretty far away from the subsystem these wrappers belong to. I
would prefer if wrappers such as this would live directly in fs/rust/
and so live within the subsystem they belong to. I think I mentioned
that before. Maybe I missed some sort of agreement here?

>  rust/kernel/lib.rs              |   3 +
>  rust/kernel/security.rs         |  78 +++++++++
>  rust/kernel/sync/condvar.rs     |   2 +-
>  rust/kernel/task.rs             |  71 ++++++++-
>  10 files changed, 771 insertions(+), 2 deletions(-)
> ---
> base-commit: 98b1cc82c4affc16f5598d4fa14b1858671b2263
> change-id: 20231123-alice-file-525b98e8a724
> 
> Best regards,
> -- 
> Alice Ryhl <aliceryhl@google.com>
> 

