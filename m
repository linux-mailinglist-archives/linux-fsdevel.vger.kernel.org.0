Return-Path: <linux-fsdevel+bounces-10411-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E5584AC14
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 03:14:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1CFB28796A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 02:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880AB56B7C;
	Tue,  6 Feb 2024 02:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="IlRvU4P0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C75856B66
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Feb 2024 02:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707185670; cv=none; b=LoPB8xs6/mEPlDIjUUn+/sLDWT3PAboGko6H++6QJ+xa6vdRSIWvB1V/wVwZj1mPanV+i3Gx+GNu2Yg9xYz6mbMCnUi1brxspa8kMDx6m/q2+GSQ5S5paLt4p7uqwYwNQN4KXo3AlB4XeiQDUjUwDYLkKuJkvjez5obDxrTa+C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707185670; c=relaxed/simple;
	bh=o25zqqGgJb+/DuJjbPME/jHUMuD6KdaPfV2xdG2bIQQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jd58BgePOtX5kutfrJXjERuM0R0oI6Z0S7hqXTj9gsJwmgH982ur3A0U9WUkpjf/4fhHK1QgE0+qlRXj72byNvvsntY1lAuAJxvOG+vEOF6Ln77Kjsh8xMQLqOEju+WS6DzfJmUkCX9q3Joaw8lP7jV5eKshd+e25uHBGYzkXnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=umich.edu; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=IlRvU4P0; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=umich.edu
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-603fd31f5c2so937697b3.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Feb 2024 18:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1707185667; x=1707790467; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TVFUfHzouElpgk6csojgEtg0jiRXTk/Brz1iEYU1QIQ=;
        b=IlRvU4P0yFmjhF68oSMMR9AJj4Iuw/GrVjQCyWvoEcQqF4vygb8qaUF9NigxgWrkhn
         IQTGMjKbwxOhrHXYq/pCXlnnm6H1oOJ212Lst9Ulfp5nZq4ycuEHT8kWr2xoPUiKwcZl
         T8WVRrFW9QzooB/r8IXK6hpK3gl36UpYRSb0ylrQPWlNTC43QTAmCvACBKdYusyUOiKZ
         udS7Nl9XYsrt8sirsSlcGEF7gAZUBg0k8FY06CGadcyG/HYoKkhD/NIXuqZZ5XCk6NSb
         VCzyNbUJOsIUJhavRdjqRXmwbSJ3DIld2QPWRKljSPBxtlJMvVQxYa+IhZ1E1MElrMjk
         1tMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707185667; x=1707790467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TVFUfHzouElpgk6csojgEtg0jiRXTk/Brz1iEYU1QIQ=;
        b=PU5fAExnFMTpZxfHQ3Fl3mY4LSyp2k1exiQeTDpap3GLpU9PnkbMdtUqUvnnDY5PYR
         qcuFEqjG4Xpm/H7bzCE3u7cLeMZu+N3r8geiR0iEOrd0Vv5FW3MQxz7pn37wLlEHZd3x
         sjZ9RbAAlVfsi2AtLJFjlPJmN+WeTrUHm0ZrMcHX477jnLuQmSOdkbSce9FP6nXDMtE2
         Vu5cYx06GzH19maQJ/SHQYqdNfx92conExXUzKGh/LW4LHggruH7mvRQ8GG58/rAOM6T
         INsd8k+9VdA9SZ/GKFAObi9DBkAcVpmxd1YdAql5SSr3hgFqT+O/zrWxvFwGeSxUwxxB
         WNTw==
X-Gm-Message-State: AOJu0YyJcES6pu7A/o1yJqqK15nuCypfpdKWCLt0y7dwLpmhs+mJ5UuX
	uHMmcE5y6aEB5xOE7tJf0wONOr6rPTNL92WnHwEVDvYj8gRCTI1xC5xDH6+JKDjhmbW4Cp4GpK+
	TLvQ+ajRWcYQ924cJkV+bmT8fkIO0jQue85HkYA==
X-Google-Smtp-Source: AGHT+IHalCWBoPrTOGrwUPX186ylELseC9bB/PUuUSj1Plms06LKwNv5q6YlTmjKBZkRPZ64RAiuwyU6eEhZflnqY4g=
X-Received: by 2002:a81:844e:0:b0:604:1d65:b66b with SMTP id
 u75-20020a81844e000000b006041d65b66bmr269588ywf.9.1707185666967; Mon, 05 Feb
 2024 18:14:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202-alice-file-v4-0-fc9c2080663b@google.com> <20240202-alice-file-v4-1-fc9c2080663b@google.com>
In-Reply-To: <20240202-alice-file-v4-1-fc9c2080663b@google.com>
From: Trevor Gross <tmgross@umich.edu>
Date: Mon, 5 Feb 2024 21:14:15 -0500
Message-ID: <CALNs47vWo1Ae2PJ+80xm1eB057DDsF+SbmVun-UHc9+vzpr7nQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/9] rust: types: add `NotThreadSafe`
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

On Fri, Feb 2, 2024 at 5:56=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> wr=
ote:
>
> This introduces a new marker type for types that shouldn't be thread
> safe. By adding a field of this type to a struct, it becomes non-Send
> and non-Sync, which means that it cannot be accessed in any way from
> threads other than the one it was created on.
>
> This is useful for APIs that require globals such as `current` to remain
> constant while the value exists.
>
> We update two existing users in the Kernel to use this helper:
>
>  * `Task::current()` - moving the return type of this value to a
>    different thread would not be safe as you can no longer be guaranteed
>    that the `current` pointer remains valid.
>  * Lock guards. Mutexes and spinlocks should be unlocked on the same
>    thread as where they were locked, so we enforce this using the Send
>    trait.
>
> There are also additional users in later patches of this patchset. See
> [1] and [2] for the discussion that led to the introducion of this

s/introducion/introduction

> patch.
>
> Link: https://lore.kernel.org/all/nFDPJFnzE9Q5cqY7FwSMByRH2OAn_BpI4H53NQf=
WIlN6I2qfmAqnkp2wRqn0XjMO65OyZY4h6P4K2nAGKJpAOSzksYXaiAK_FoH_8QbgBI4=3D@pro=
ton.me/ [1]
> Link: https://lore.kernel.org/all/nFDPJFnzE9Q5cqY7FwSMByRH2OAn_BpI4H53NQf=
WIlN6I2qfmAqnkp2wRqn0XjMO65OyZY4h6P4K2nAGKJpAOSzksYXaiAK_FoH_8QbgBI4=3D@pro=
ton.me/ [2]
> Suggested-by: Benno Lossin <benno.lossin@proton.me>
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/kernel/sync/lock.rs | 15 +++++++++++----
>  rust/kernel/task.rs      | 10 ++++++----
>  rust/kernel/types.rs     | 17 +++++++++++++++++
>  3 files changed, 34 insertions(+), 8 deletions(-)
>
> diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
> index 149a5259d431..d08d9d32915a 100644
> --- a/rust/kernel/sync/lock.rs
> +++ b/rust/kernel/sync/lock.rs
> @@ -6,8 +6,15 @@
>  //! spinlocks, raw spinlocks) to be provided with minimal effort.
>
>  use super::LockClassKey;
> -use crate::{bindings, init::PinInit, pin_init, str::CStr, types::Opaque,=
 types::ScopeGuard};
> -use core::{cell::UnsafeCell, marker::PhantomData, marker::PhantomPinned}=
;
> +use crate::{
> +    bindings,
> +    init::PinInit,
> +    pin_init,
> +    str::CStr,
> +    types::ScopeGuard,
> +    types::{NotThreadSafe, Opaque},

Formatting nit: ScopeGuard could probably be placed in the same group
as NotThreadSafe & Opaque

> [...]
> +
> +/// Zero-sized type to mark types not [`Send`].
> +///
> +/// Add this type as a field to your struct if your type should not be s=
ent to a different task.
> +/// Since [`Send`] is an auto trait, adding a single field that is `!Sen=
d` will ensure that the
> +/// whole type is `!Send`.
> +///
> +/// If a type is `!Send` it is impossible to give control over an instan=
ce of the type to another
> +/// task. This is useful when a type stores task-local information for e=
xample file descriptors.

I initially read this thinking it meant to include this type if your
struct also had a FD rather than being part of the FD. Maybe

    This is useful to include in types that store or reference task-local
    information. A file descriptor is an example of one such type.

> +pub type NotThreadSafe =3D PhantomData<*mut ()>;
> +
> +/// Used to construct instances of type [`NotThreadSafe`] similar to how=
 we construct
> +/// `PhantomData`.

I think it sounds slightly better reworded from personal to passive, i.e.

    ... similar to how `PhantomData` is constructed.

> +/// [`NotThreadSafe`]: type@NotThreadSafe
> +#[allow(non_upper_case_globals)]
> +pub const NotThreadSafe: NotThreadSafe =3D PhantomData;
> --
> 2.43.0.594.gd9cf4e227d-goog

This looks good, sounds nice to make the intent more clear. Nothing
that isn't optional, so

Reviewed-by: Trevor Gross <tmgross@umich.edu>

