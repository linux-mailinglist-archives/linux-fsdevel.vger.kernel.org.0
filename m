Return-Path: <linux-fsdevel+bounces-11043-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85AFB85036C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Feb 2024 08:52:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F25B11F23D90
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Feb 2024 07:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76C232186;
	Sat, 10 Feb 2024 07:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="p4Hz46jY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E3C134DD
	for <linux-fsdevel@vger.kernel.org>; Sat, 10 Feb 2024 07:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707551549; cv=none; b=NCxy2Qu7DcryUZ/syXDkfCqaDNKALyOojGLeSDkEWGJJZTyG7See1ShE3gtaY42B9+QyXf60WXMp2iqY9ZP+WYPz6Ftnd8nzQktYb7qUtuAWB2CtIDdTsBbfff7Psj6382M4fDH7+RMXHrRX2y3B7Jv+XGvpSf704bcW++VK17Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707551549; c=relaxed/simple;
	bh=gZo8nudx91n7QmkKsXW07rSEvmw1YmQIFCRQ9PVoTH4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OCd1bLA9obcfzlCdvRGXz5vfXImD3HqNQx96hcMVjofSvD0SgL21GcD3KaHjLTMgtLLlqEr7PG9F1XMFcfyvi37bCKwL8BAwhzkuBscqeVafiSqy4fb0hhmP68LZUO33u0S0xr8CWZlzRiWX5dBmb+D38+n5/VIHRDxzreXXg6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=umich.edu; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=p4Hz46jY; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=umich.edu
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dc754853524so1180943276.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Feb 2024 23:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1707551546; x=1708156346; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0g4QBN1/rGV7VTiFr0/5TgIubmQLI1xDKrfOY+r3ugk=;
        b=p4Hz46jYpc+qRjV8GuJEwQaP4mM/nrHF0nqpHQAa4LELGQa9otfR+sukLDTAkeU0n5
         aDHF4dZxbCh1GcYaW76hyT+S2OLWO2bYkKrFL6QKQMg8z16uBbmxlcStO/25b8sAn3sI
         8DGybrgoPJslvavZbaNOJ3UnxDb5GO3XfurPTZBbHRjH0UDjfs/Zeub34NyX09bYHfx3
         EJLVH2Po0vOBxf7771d71MLR97JST5rhWB7M6gE7CgTpr/N5UiZOu3Xr517spBbyIZcL
         aZ27AfmdPhudqB0glav8lp5pjiMgKR34ZnRK3VvGhtQUxSNagjJVzpyBD7AZvsE8IhgE
         L3gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707551546; x=1708156346;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0g4QBN1/rGV7VTiFr0/5TgIubmQLI1xDKrfOY+r3ugk=;
        b=DaamQfKYCtVmIDsO30p1oe66EOiSBr9SD4tH9QVg5idPn/BcvO/Sr15VK4Jwo8ig0Z
         gLIYghuFjaa+iGXpm37Cwu23rG81FpBAIoYfvq9tgbWwDNdyboAEbuGwZqJ2LWQkftVP
         1eJkOQHIfzfREZ2MAp0Mk2WsA6RHzq6mwgN9uE0qTOJVj+7q7PZzWOTsfse90FsBTWfo
         1C9R7gIsKn8OQs4ac74umGtcFgj9nWAADLgyXFlu7ITn9E2RnF2hPYHrF0zGW3+NLyQa
         JwT6tz7MxNzJgv3xyk/e1E+uj8udjp+LSyeWjkHPJNhc6R1tiM651RzxeHnHdXOf7nt+
         6oUw==
X-Forwarded-Encrypted: i=1; AJvYcCW9JlBy45JRZQrjVqZxAG/Rr+B80wxxTXf8A9RIX82b7hdZxbFM17k30RxJRotCWfhLOVf/wcHvOnJ3jy46lJlpi4ef7WTN25vqg8sy0Q==
X-Gm-Message-State: AOJu0Yy3zZUW4JSFXO+dk6XGzQ7KTeR2EyoOMl8o7P7FDEgVkmT7U4Wk
	HQgucP5Zjg+chez5sN6rGL4lR60wiDC0LfArgB+t8XlWm6stEkabuChgkmRf2GoXn9GKd6mz8Iz
	IVXcrauhdIIBpC/y6bD70lCD6awu62mjX73bJBA==
X-Google-Smtp-Source: AGHT+IEUiIzOiHLRzdgkH99+QuE32ywhnMdkTVC8NBgzI5fk5Ybz9uul1p9W6i4OO6rbzEw6xjwAViPCw8z3mDUGJlk=
X-Received: by 2002:a25:28d:0:b0:dc6:d87e:77d1 with SMTP id
 135-20020a25028d000000b00dc6d87e77d1mr1096217ybc.43.1707551545768; Fri, 09
 Feb 2024 23:52:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209-alice-file-v5-0-a37886783025@google.com> <20240209-alice-file-v5-9-a37886783025@google.com>
In-Reply-To: <20240209-alice-file-v5-9-a37886783025@google.com>
From: Trevor Gross <tmgross@umich.edu>
Date: Sat, 10 Feb 2024 01:52:14 -0600
Message-ID: <CALNs47sV5QSgRkrFmazYvcKjY_TC2gP0oeg1TiT6YozBoTT-+w@mail.gmail.com>
Subject: Re: [PATCH v5 9/9] rust: file: add abstraction for `poll_table`
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
	rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 9, 2024 at 5:22=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> wr=
ote:
>
> The existing `CondVar` abstraction is a wrapper around
> `wait_queue_head`, but it does not support all use-cases of the C
> `wait_queue_head` type. To be specific, a `CondVar` cannot be registered
> with a `struct poll_table`. This limitation has the advantage that you
> do not need to call `synchronize_rcu` when destroying a `CondVar`.
>
> However, we need the ability to register a `poll_table` with a
> `wait_queue_head` in Rust Binder. To enable this, introduce a type
> called `PollCondVar`, which is like `CondVar` except that you can
> register a `poll_table`. We also introduce `PollTable`, which is a safe
> wrapper around `poll_table` that is intended to be used with
> `PollCondVar`.
>
> The destructor of `PollCondVar` unconditionally calls `synchronize_rcu`
> to ensure that the removal of epoll waiters has fully completed before
> the `wait_queue_head` is destroyed.
>
> That said, `synchronize_rcu` is rather expensive and is not needed in
> all cases: If we have never registered a `poll_table` with the
> `wait_queue_head`, then we don't need to call `synchronize_rcu`. (And
> this is a common case in Binder - not all processes use Binder with
> epoll.) The current implementation does not account for this, but if we
> find that it is necessary to improve this, a future patch could store a
> boolean next to the `wait_queue_head` to keep track of whether a
> `poll_table` has ever been registered.
>
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

One nit below

Reviewed-by: Trevor Gross <tmgross@umich.edu>

> +/// Creates a [`PollCondVar`] initialiser with the given name and a newl=
y-created lock class.
> +#[macro_export]
> +macro_rules! new_poll_condvar {
> +    ($($name:literal)?) =3D> {
> +        $crate::sync::poll::PollCondVar::new($crate::optional_name!($($n=
ame)?), $crate::static_lock_class!())
> +    };
> +}

Length > 100, this could wrap:

    macro_rules! new_poll_condvar {
        ($($name:literal)?) =3D> {
            $crate::sync::poll::PollCondVar::new(
                $crate::optional_name!($($name)?), $crate::static_lock_clas=
s!()
            )
        };
    }

