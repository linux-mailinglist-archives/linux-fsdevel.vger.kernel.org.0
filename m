Return-Path: <linux-fsdevel+bounces-10778-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D0B284E3AF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 16:06:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D80612827D4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 15:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E367B3DA;
	Thu,  8 Feb 2024 15:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jpsqcyo/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6139F67E93
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Feb 2024 15:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707404774; cv=none; b=pwp9C6fOLRvPWxrKVH2K6MQmp+hbG+WPmnRtnTsB9GFrEkfSloUSSSfbuFdKJNRC+qvV4W03BkanXJgHFN0dF5El/74WGOrXGQivzroINDsYYuuSLO6b9QmwprU9WgpLVMqx0BTQNPXzybwbMSUKGvSt728CMXF5fTgrM8aoAzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707404774; c=relaxed/simple;
	bh=p7O5ChPBChshUWpDCRZGifl5wJ5DNvQULZn1nSKXFKE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KOqnDJFT0+XCd1eDLUb2IGwalFPCNx1mlI1pX5a0mAy0ZZvwRo3HjBL/dXzENm1fBAdi5QO/tPpa4hy9XiGH6lfN0u9wZkadYSUhfYzVWZSbIWLNAfVEsPVV8V8c+J6QdE3pl0TYFSS4WHgbidzEEmZEVGR2X9k7wi65TbXQJ8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jpsqcyo/; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-59a1a03d09aso553818eaf.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Feb 2024 07:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707404771; x=1708009571; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5qzJG2kbNcKXxgGCq8nsdXz25PJyvZWTgNzBaOYeMow=;
        b=jpsqcyo/Q4t0hmUdXu6q8T8VtRaZxnjDpLh12T00rAgxfsqmy++RM1LWHGTy9SRRyG
         GeaYtGH54FNk5EuWHL9SVyq+tQa6ssH+psjYqWQjVeVDkqoRixdqQjs7henReqHwP/iD
         2qYxm/s7Q7HiBMAQQbe4ZevuZ3BOWv61MxGMFT7i2f0Etn6Tiy2S9M9uiqKdD5TlteEP
         Wgktaa0q/zbnKMzJ5+fgRUG2+Fde2L8894XR8ERyOiGM5+mP/p5opAzqFm96TRdvNLhw
         T2jL9KfJwcZj5BijBwugDLwPT1sskB4twUtJHclz+F2PDwfc4qBE2AIDLzSrYXkuFTzT
         rIxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707404771; x=1708009571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5qzJG2kbNcKXxgGCq8nsdXz25PJyvZWTgNzBaOYeMow=;
        b=Bcxe32DjUuEFiiNxMEkH2k2te1sJ3agi7+mnv2FVFN9uZEPJ72LAHDBofYo6bg/ffa
         ThVO+FuU5xkteIRKKGUCpcTR0M9sgyeTojGgoSpTPa5T1YSI4hciCphDoPxAK9TLTLtE
         Dm7uq+uANIM3ft6wuWraFfGHYos1+7L9pGJD1FRwUORBv9oWmXPUJJtdAYMYRmvRL3UW
         mhW8B/lYicIppfW+3LUIkhfCAfyRsEyHisfyyl8SsAVYorStFMJ4MGViPzHE7l4E8XNE
         eBZ3uTP4bSNLCEMrs+ijxVnwjUmj7biI/U7OsQe2wjx7QX21vWR8FWJNXtCE8Bzj0nWu
         Ptvg==
X-Gm-Message-State: AOJu0YxD1wyyK+4Y9Jru8Kq7zz47P9vgz/GCZf9/QL43njFdDL/89yZV
	nrrJP7k1zPAU0S9DMhX1U68JlaMhr8V8emfb1GzqfLwLrSg/rj6YzwUl6RCYT3gxJhZiPKp3iXN
	cdUfZrSgGOPPSGjSBOI/pOQkativSLPO6JMCb
X-Google-Smtp-Source: AGHT+IGVTzN/oqMzo15INfA0ZHSAdSqplYV9Qa5dIb3U+KTOVVvNBXWUHlmLYvp3URuP+CjIaS1IbWWt5XJjO0Qgc/s=
X-Received: by 2002:a05:6358:2c82:b0:176:2852:3ac1 with SMTP id
 l2-20020a0563582c8200b0017628523ac1mr6819717rwm.28.1707404771171; Thu, 08 Feb
 2024 07:06:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202-alice-file-v4-0-fc9c2080663b@google.com>
 <20240202-alice-file-v4-3-fc9c2080663b@google.com> <09db8a4c-f471-4ff6-aa14-864697772bd0@gmail.com>
In-Reply-To: <09db8a4c-f471-4ff6-aa14-864697772bd0@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 8 Feb 2024 16:06:00 +0100
Message-ID: <CAH5fLgh3vrm6sH4dWejqRGEq6DCPHy-qViBybX4BwUWRbid55g@mail.gmail.com>
Subject: Re: [PATCH v4 3/9] rust: file: add Rust abstraction for `struct file`
To: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
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

On Thu, Feb 8, 2024 at 1:35=E2=80=AFAM Martin Rodriguez Reboredo
<yakoyoku@gmail.com> wrote:
>
> On 2/2/24 07:55, Alice Ryhl wrote:
> > From: Wedson Almeida Filho <wedsonaf@gmail.com>
> >
> > This abstraction makes it possible to manipulate the open files for a
> > process. The new `File` struct wraps the C `struct file`. When accessin=
g
> > it using the smart pointer `ARef<File>`, the pointer will own a
> > reference count to the file. When accessing it as `&File`, then the
> > reference does not own a refcount, but the borrow checker will ensure
> > that the reference count does not hit zero while the `&File` is live.
> >
> > Since this is intended to manipulate the open files of a process, we
> > introduce an `fget` constructor that corresponds to the C `fget`
> > method. In future patches, it will become possible to create a new fd i=
n
> > a process and bind it to a `File`. Rust Binder will use these to send
> > fds from one process to another.
> >
> > We also provide a method for accessing the file's flags. Rust Binder
> > will use this to access the flags of the Binder fd to check whether the
> > non-blocking flag is set, which affects what the Binder ioctl does.
> >
> > This introduces a struct for the EBADF error type, rather than just
> > using the Error type directly. This has two advantages:
> > * `File::from_fd` returns a `Result<ARef<File>, BadFdError>`, which the
> >    compiler will represent as a single pointer, with null being an erro=
r.
> >    This is possible because the compiler understands that `BadFdError`
> >    has only one possible value, and it also understands that the
> >    `ARef<File>` smart pointer is guaranteed non-null.
> > * Additionally, we promise to users of the method that the method can
> >    only fail with EBADF, which means that they can rely on this promise
> >    without having to inspect its implementation.
> > That said, there are also two disadvantages:
> > * Defining additional error types involves boilerplate.
> > * The question mark operator will only utilize the `From` trait once,
> >    which prevents you from using the question mark operator on
> >    `BadFdError` in methods that return some third error type that the
> >    kernel `Error` is convertible into. (However, it works fine in metho=
ds
> >    that return `Error`.)
> >
> > Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> > Co-developed-by: Daniel Xu <dxu@dxuuu.xyz>
> > Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> > Co-developed-by: Alice Ryhl <aliceryhl@google.com>
> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> > ---
> > [...]
> > +/// ## Rust references
> > +///
> > +/// The reference type `&File` is similar to light refcounts:
> > +///
> > +/// * `&File` references don't own a reference count. They can only ex=
ist as long as the reference
> > +///   count stays positive, and can only be created when there is some=
 mechanism in place to ensure
> > +///   this.
> > +///
> > +/// * The Rust borrow-checker normally ensures this by enforcing that =
the `ARef<File>` from which
> > +///   a `&File` is created outlives the `&File`.
> > +///
> > +/// * Using the unsafe [`File::from_ptr`] means that it is up to the c=
aller to ensure that the
> > +///   `&File` only exists while the reference count is positive.
> > +///
> > +/// * You can think of `fdget` as using an fd to look up an `ARef<File=
>` in the `struct
> > +///   files_struct` and create an `&File` from it. The "fd cannot be c=
losed" rule is like the Rust
> > +///   rule "the `ARef<File>` must outlive the `&File`".
>
> I find it kinda odd that this unordered list interspaces elements with
> blank lines as opposed to the following one, though, I don't see it as
> rather a big deal.

Shrug. I did it here because I found it more readable.

> > +///
> > +/// # Invariants
> > +///
> > +/// * Instances of this type are refcounted using the `f_count` field.
> > +/// * If an fd with active light refcounts is closed, then it must be =
the case that the file
> > +///   refcount is positive until all light refcounts of the fd have be=
en dropped.
> > +/// * A light refcount must be dropped before returning to userspace.
> > [...]
>
> Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>

