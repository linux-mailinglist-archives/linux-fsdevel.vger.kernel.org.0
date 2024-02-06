Return-Path: <linux-fsdevel+bounces-10415-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C29384AC90
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 03:58:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0FCFB23B76
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 02:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3363F73188;
	Tue,  6 Feb 2024 02:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="YPdUF8i7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C3673163
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Feb 2024 02:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707188276; cv=none; b=JtUfmaHUiy6QippN4bwlc4TIwI2oXzDQ6kWgjm86uLolM/rycY857u0ioFIcpzlwaJmE9+OZdnrEoVUM9flK6+mmZSXApsDSztISxV2rhGNWo3UTfXaDjTjZKzCJWJm3JYWuJvbXU4lsAO6Hda/jaKGy/HY9+44rRmjYEv+Dz7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707188276; c=relaxed/simple;
	bh=O9efCbCmhsoj+sAATb/aPhgANE/s9poFZaEC+g54d+U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T6FWLBvxSErjIVANkNZOQeycBfTwja2BJndqDLAddoDxWiu+dBf6AofqOSYC/l9iWZfjldi7FdviRR+ZF0r/wIhQK2owjKAgyulk2aHDtSDODToN2XjSlgKYOh3atsROelp1bzPd21pqKvPmy5LG5KbqE076sRWY1PWsxPkHCEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=umich.edu; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=YPdUF8i7; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=umich.edu
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6002317a427so44806067b3.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Feb 2024 18:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1707188273; x=1707793073; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bqepRb+abK4kcaQAp0APULWgQApL36tPQmX2Q86uLSU=;
        b=YPdUF8i7gbNLSxmvBNy2Y+AD4QP1PkXmdYR1he6kYp79j33nJCWr75tZYV7ESgxvPx
         o/1YnuZTYAfPoGCgRHz/QBzJqFE9xoN53DE87rccqdd+ea1f7tWdhJP8H9pZSQeaVXNX
         OB25bCJzzl1SeDJ/5rauiowFoNwQlYpqsRhQ7litRv9JbF0JrgnnJFe66TV58Z+CplZk
         GsaxxDzTcuyf+mXicpHlbMLQTgGkebLx3TbXu9utiKuNuU8oFjUoGKyWfPzJK5xAgEDa
         xZXKMXL+GvzjtNVvZm5Q3WEnJ0Y3qcEa+z4xNOSXWpMPymTOxVVi9R5pZXsThJHAN+GD
         Icbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707188273; x=1707793073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bqepRb+abK4kcaQAp0APULWgQApL36tPQmX2Q86uLSU=;
        b=n84nk9P0DJcuSeXBGfvnujGlvTgBnh7Lh1SoTs4fOsJB04X/+Uici4R/vstdOltmDP
         6Iv7S6GpgQKUD3gJOGx2CpQa2NxIEbsKv+RArIGefCwB57KKwub6EML2uPrr30GpsDan
         uXKtIdlw6uGDZyaiQYaaC7cuoyatyONvN112EXM7WBNS2+9OOd46NgOyjKTVhLJOrQY3
         OXndTNx6fx02XjC+bXTqo6c9a+P7xYSQgmFkdgOeJKE6ZUM+/ojRvE2pABvAbBo1f3x0
         M3rDrRjfQtzwl+U2MYjszF7kkWZqr2sptq7ISeGmoRwV6fbEQNvFRO0GFLdi2JjIgyUP
         tkog==
X-Gm-Message-State: AOJu0Yxltp7gEhC+k8rTHuzdxLT7vhZi7Qgp7jDLXYcZbfLmuI2he9OS
	rlNNJuiX8SWaxSyQajimjT+U3AXAvh4flnZOiQDv6vxKsGaSN3qIpYRk1apDp5xLC91EmjKYpil
	BSY3Aj8O/1kPAvhNjKOp7CKWiHIb7500vcK7zwg==
X-Google-Smtp-Source: AGHT+IH++za25FnYOnmuSi0flt+CIyuQPAZsWyHjSCdWi2Q/MRZt9aab2tF9livzcRICDlDepHOGlTEBrFkwzGNUdDI=
X-Received: by 2002:a81:c142:0:b0:604:6b32:b144 with SMTP id
 e2-20020a81c142000000b006046b32b144mr432214ywl.0.1707188273733; Mon, 05 Feb
 2024 18:57:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202-alice-file-v4-0-fc9c2080663b@google.com> <20240202-alice-file-v4-4-fc9c2080663b@google.com>
In-Reply-To: <20240202-alice-file-v4-4-fc9c2080663b@google.com>
From: Trevor Gross <tmgross@umich.edu>
Date: Mon, 5 Feb 2024 21:57:42 -0500
Message-ID: <CALNs47uVdBhc1bm0VrXacFNasbN9jUnuphGFRgSpX-4eng46+A@mail.gmail.com>
Subject: Re: [PATCH v4 4/9] rust: cred: add Rust abstraction for `struct cred`
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Peter Zijlstra <peterz@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	=?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Dan Williams <dan.j.williams@intel.com>, 
	Kees Cook <keescook@chromium.org>, Matthew Wilcox <willy@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 5:57=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> wr=
ote:
>
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
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> Co-developed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
> [...]
> diff --git a/rust/kernel/cred.rs b/rust/kernel/cred.rs
> new file mode 100644
> index 000000000000..fabc50e48c9e
> --- /dev/null
> +++ b/rust/kernel/cred.rs
> @@ -0,0 +1,72 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Credentials management.
> +//!
> +//! C header: [`include/linux/cred.h`](srctree/include/linux/cred.h).
> +//!
> +//! Reference: <https://www.kernel.org/doc/html/latest/security/credenti=
als.html>
> +
> +use crate::{
> +    bindings,
> +    types::{AlwaysRefCounted, Opaque},
> +};
> +
> +/// Wraps the kernel's `struct cred`.

Could you add a brief description to the summary line?

> +/// Most fields of credentials are immutable. When things have their cre=
dentials changed, that
> +/// happens by replacing the credential instad of changing an existing c=
redential. See the [kernel

s/instad/instead

> [...]

Reviewed-by: Trevor Gross <tmgross@umich.edu>

