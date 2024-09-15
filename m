Return-Path: <linux-fsdevel+bounces-29414-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4497A9798B3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Sep 2024 22:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 772251C21A68
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Sep 2024 20:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9261CA6AC;
	Sun, 15 Sep 2024 20:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fxujmghc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9CDEAE7;
	Sun, 15 Sep 2024 20:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726431879; cv=none; b=Zgg9KXBnTus6B9EqzbhJD9biabcARbUcIHWWLLhZQPO/QtWe1lQxDgO7IisLr+Y+U07zSCVq1wOf9sWIh284vRMade7OmIb4y1jFgVw4lxw0h1rFMwBFSJrJJrxYPfJtVU+yYk7j2GkPu4vS/qwv15hr9aTHsrgmCyQK7sliMNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726431879; c=relaxed/simple;
	bh=F29wHTMOl2UoZimULwhaDRQ88yiU9IOuqXw6WDIs0bM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r8j+vUTglhCQtPpovVOlbH6Om6sBxNFOuRawV8WG0E7scOx5FAdY/TmhZabxJva2Q8V4EL/7DCXLEVbf/5nBopW48Bu+nudF5rrNzp5FYet9OAocgLS2mfACJQPAY4Q1GLVMpXMbfMF0h2HnYMzqdXSHoT81VyzaN71dbeGXN7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fxujmghc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F624C4CEC3;
	Sun, 15 Sep 2024 20:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726431878;
	bh=F29wHTMOl2UoZimULwhaDRQ88yiU9IOuqXw6WDIs0bM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fxujmghczhubiD5/ERDfHzzJ7Q7aWb3zgCzZ2j1ZUsFjX2xf3KRebbsUTLiO5ipNY
	 WphGWJ28ew62deSVmyNvORdSelirXb1oiDfrGUY7dOBUPslDHcv8K+WIaq/YYeD0/g
	 3ycGYs8il1ayHFHl8gMi0Axh4LKmg95HExHdcCOYlP8zeQ5olDxnj6j6tSFiISOoL/
	 0XzQYaYwYuUKplKC4eoOUkz/ITZHYwloRtMtwemlt/zYFSBMOC4/0mkZCyEm5fHt9Q
	 69GyuEMhzm5Ty7voFdngMTqL0uH9bHr9Y1c/ehbGPkHZWHcYaPWRdYe7xDK5FuVXtP
	 lnOzW7sPQ/Phg==
Date: Sun, 15 Sep 2024 13:24:38 -0700
From: Kees Cook <kees@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Carlos Llamas <cmllamas@google.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>,
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
	Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v10 4/8] rust: cred: add Rust abstraction for `struct
 cred`
Message-ID: <202409151318.7985B253@keescook>
References: <20240915-alice-file-v10-0-88484f7a3dcf@google.com>
 <20240915-alice-file-v10-4-88484f7a3dcf@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240915-alice-file-v10-4-88484f7a3dcf@google.com>

On Sun, Sep 15, 2024 at 02:31:30PM +0000, Alice Ryhl wrote:
> From: Wedson Almeida Filho <wedsonaf@gmail.com>
> 
> Add a wrapper around `struct cred` called `Credential`, and provide
> functionality to get the `Credential` associated with a `File`.
> 
> Rust Binder must check the credentials of processes when they attempt to
> perform various operations, and these checks usually take a
> `&Credential` as parameter. The security_binder_set_context_mgr function
> would be one example. This patch is necessary to access these security_*
> methods from Rust.
> 
> This Rust abstraction makes the following assumptions about the C side:
> * `struct cred` is refcounted with `get_cred`/`put_cred`.

Yes

> * It's okay to transfer a `struct cred` across threads, that is, you do
>   not need to call `put_cred` on the same thread as where you called
>   `get_cred`.

Yes

> * The `euid` field of a `struct cred` never changes after
>   initialization.

"after initialization", yes. The bprm cred during exec is special in
that it gets updated (bprm_fill_uid) before it is installed into current
via commit_creds() in begin_new_exec() (the point of no return for
exec).

> * The `f_cred` field of a `struct file` never changes after
>   initialization.

Yes.

> 
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> Co-developed-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Trevor Gross <tmgross@umich.edu>
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
> Reviewed-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

