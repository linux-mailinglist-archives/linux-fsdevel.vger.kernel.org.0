Return-Path: <linux-fsdevel+bounces-28212-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C66D96813C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 10:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CABF1C20FEE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 08:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5250C183CC2;
	Mon,  2 Sep 2024 08:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gYQEBuN4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CE9155739;
	Mon,  2 Sep 2024 08:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725264173; cv=none; b=LYNJ+Z9EjUpBNBmzojlfC5ByTygAJxPQZQfwjMl8qMRAIii7Zw4ifuJg32r7qYXzi1I89sPQ1w3dp4ZQX0FCs0dsHoWMaCu8Z+zEZCbck6vt/oQ08n1YVdhDXxq/BrqpihCRucAbU+NrNnd6DIuFQVqGpod7SRqZqunqTgKmb7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725264173; c=relaxed/simple;
	bh=o/vVg9cH/6lPXA0xLYlKu3oCei4KbktAECxPbfZLKVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A67aKshaernggprXuz2Nd+Zdf+t53F04nuXdK4QqFAqCj9soQszLg8TgMujzvm39iKgMbqrI5zFzZWik+dfJsq3klwomaDLO8xuTYCRwa6bG52+w7imfxUOvYk4AgiNE6f02/NGx0t4WuAEtVfdnBxrhTqYaandDvkmYlJLbf+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gYQEBuN4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4C9AC4CEC2;
	Mon,  2 Sep 2024 08:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725264173;
	bh=o/vVg9cH/6lPXA0xLYlKu3oCei4KbktAECxPbfZLKVA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gYQEBuN4ayOMO+zLup7I2SSmnCTaggmjKmoqm50eBwFjFePaiJrgsWk2rKnCqWwyP
	 tx1kPTnxGHx+YOpiADwlrAe6kxCBzQEyBDYsJv8dkNthcpB+J9i5HPc8lAuHKZFesx
	 r48I/5gqMIss+YAjp1i9Z+kXCh8T0mbFhGrmQmTvImNuA6f6gSdryCMDilrj7MhCqu
	 6yeotN1kr1QGQeylATdaZZEd7whlAIjKGWZo9mAq8wD9iVF15k/fQA1LeKLL2N0ha4
	 9xtASR+chibXFMjPfAcq/4251z85PJ7CbE9n68D7KjU3BCACoqMZt6btVENg9Q0thc
	 rv/ypnkbAuhAg==
Date: Mon, 2 Sep 2024 10:02:43 +0200
From: Christian Brauner <brauner@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Peter Zijlstra <peterz@infradead.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Arve =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Dan Williams <dan.j.williams@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>, 
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>, Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v9 0/8] File abstractions needed by Rust Binder
Message-ID: <20240902-dickdarm-zumeist-3858e57fb425@brauner>
References: <20240808-alice-file-v9-0-2cb7b934e0e1@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240808-alice-file-v9-0-2cb7b934e0e1@google.com>

On Thu, Aug 08, 2024 at 04:15:43PM GMT, Alice Ryhl wrote:
> This patchset contains the file abstractions needed by the Rust
> implementation of the Binder driver.
> 
> Please see the Rust Binder RFC for usage examples:
> https://lore.kernel.org/rust-for-linux/20231101-rust-binder-v1-0-08ba9197f637@google.com/
> 
> Users of "rust: types: add `NotThreadSafe`":
> 	[PATCH 5/9] rust: file: add `FileDescriptorReservation`
> 
> Users of "rust: task: add `Task::current_raw`":
> 	[PATCH 7/9] rust: file: add `Kuid` wrapper
> 	[PATCH 8/9] rust: file: add `DeferredFdCloser`
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
> Users of "rust: security: add abstraction for secctx":
> 	[PATCH RFC 06/20] rust_binder: add oneway transactions
> 
> Users of "rust: file: add `FileDescriptorReservation`":
> 	[PATCH RFC 13/20] rust_binder: add BINDER_TYPE_FD support
> 	[PATCH RFC 14/20] rust_binder: add BINDER_TYPE_FDA support
> 
> Users of "rust: file: add `Kuid` wrapper":
> 	[PATCH RFC 05/20] rust_binder: add nodes and context managers
> 	[PATCH RFC 06/20] rust_binder: add oneway transactions
> 
> Users of "rust: file: add abstraction for `poll_table`":
> 	[PATCH RFC 07/20] rust_binder: add epoll support
> 
> This patchset has some uses of read_volatile in place of READ_ONCE.
> Please see the following rfc for context on this:
> https://lore.kernel.org/all/20231025195339.1431894-1-boqun.feng@gmail.com/
> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---

So, this won't make v6.12 anymore. There already were pretty big changes
around files for the coming cycle so I did not also want to throw this
into the mix as well. (Sorry that this had to miss it's birthday, Alice.)

However, I do intend to merge a version for this for v6.13. There's some
wrapping of struct cred and specifically of struct secctx that I can
only handwave at. Ideally you get a nod from the LSM maintainers as well
but if that doesn't come in I don't see much point in making this sit in
limbo indefinitely.

