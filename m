Return-Path: <linux-fsdevel+bounces-10037-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A878473C5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 16:56:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9215B2262F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 15:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 084911474A5;
	Fri,  2 Feb 2024 15:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vpJPjleQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F235C14690C
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Feb 2024 15:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706889389; cv=none; b=FeoY/x1AHtwfahztGKpM7CkZJhzKfD7VJw08KKRRgsHbuJdRLMQA1IR2l5DqtrrhA1+7LY5ZwCyAeHg4DRMJWjL8oTe3xA0yGEhx7kugEUftNvIwbna22GUN1DHg7pemnZWaFPZJ2+uYko7dtP4hdob35pjFy76oVV5xt3M363U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706889389; c=relaxed/simple;
	bh=FNDJQ9xh+RWwPD9Nki93GLkLV+DCmLpnpSZYdhe5EYk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZK7OI5F8oHIfqAQNw9vGJqBNmWnw+UvNyyG2ROhNUA1iKJQPRWVyWd7jA5FaweANdlJxRR80Rf5dupnllMX+uK3zAlYwtbs639l+hHMS1uUCeF5NtQCI5mNHg9jdgkalHe6SE4eS5bLehtWVfAOWSeeFcGJGr7S/pb685fjL0OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vpJPjleQ; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-4bd45397c17so796748e0c.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 Feb 2024 07:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706889387; x=1707494187; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lmJR7Ww8ojzofhT9CYA10sXCxDHSnn8Gqx6UiwVGV8g=;
        b=vpJPjleQQtzxFs6XeeETAEBppD4dE7iPK/ZucSJdqHpC5yiYQcT8gXIaFBeQsA+EyW
         HkI8BKy4Zb8WtX/LC/G98S0pjVR6EfE0/uesIwcw1U5AGhBk91awjtOhrku/uDyWxq5Q
         QoBUhWnlQqp9Y/WdTTwEsL+iszr2if8jEgZyMyINv0aBKWaUkVg+VBOLpvf/1ANXjNW+
         e9vsfAqQVr0z+NQYDLUn0zhNIsz6FfxenjFqOQLdkvXLqibn58H6BpCjYv8jYcZgsdjZ
         r4U3DDjOE1OspcRn2jMHtwrno6UnrQtEHIHB+TZJlQbJx3gP5R0nhvUzamC6KeG5pktF
         dOfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706889387; x=1707494187;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lmJR7Ww8ojzofhT9CYA10sXCxDHSnn8Gqx6UiwVGV8g=;
        b=BOnxASVvF5fs1YQTaQuBIdjSrfVMZ2Yi2E1mT6dQYPR4buZuP4mqC1BgHcDtcx6MEy
         TmrR8cht8K39CDoQey4zASyuu4YHieE+wy6GXQ97z93UBF9Kied8HUtMHpNRXIC4kxGP
         eCkYppE1gaV9WIhkLXfwtpYlgm9yv9JlqMEIJWAIocby0ywqw8vPMIsc8uG86fg1ke4f
         DcGkYweHQJHZAHWhh48Xo3fjjxpPu/5ffADJUQSe/RIrSvyHl8KLhrmFT+wOMtt3MLh2
         cvX4fvFRsSwhCb2pteEixo2h+lpuYzTxxW5VCG1Ullf2quwsQihqdFEZTYiNVPuKaoeg
         Jzow==
X-Gm-Message-State: AOJu0YybifD+XGSTIAyEjLwPgKYPa2nq4jICf8LXOr0PpfSWXHgjUG14
	dQajx4Hmuqe4BQjeFg03/AQ/tffp41yjFmfp3fqeArYnFfmlLWomnSHTeVqHXLwCEKnH0/9rNO2
	oWDcS8TH1ZSJQldqWAwfANyyFshr6rGIJacEh
X-Google-Smtp-Source: AGHT+IH2Og0a7twSwhicsL764k2gi6eQEWtu6vNVhCfq/Nv88snUC2LLMaOgyqphlIrFstt/i2vCM6+wbYKlaJvFsdQ=
X-Received: by 2002:a1f:7d05:0:b0:4b7:6c2f:fdb0 with SMTP id
 y5-20020a1f7d05000000b004b76c2ffdb0mr2486777vkc.0.1706889386687; Fri, 02 Feb
 2024 07:56:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202-alice-file-v4-0-fc9c2080663b@google.com>
 <20240202-alice-file-v4-7-fc9c2080663b@google.com> <2024020214-concierge-rework-2ac5@gregkh>
In-Reply-To: <2024020214-concierge-rework-2ac5@gregkh>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 2 Feb 2024 16:56:15 +0100
Message-ID: <CAH5fLgj=m78KdWaxzyy3YkDh3UkxczXsh_i7ekOZDjzuwe10bA@mail.gmail.com>
Subject: Re: [PATCH v4 7/9] rust: file: add `Kuid` wrapper
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Peter Zijlstra <peterz@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Dan Williams <dan.j.williams@intel.com>, 
	Kees Cook <keescook@chromium.org>, Matthew Wilcox <willy@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 4:36=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Feb 02, 2024 at 10:55:41AM +0000, Alice Ryhl wrote:
> > +    /// Returns the given task's pid in the current pid namespace.
> > +    pub fn pid_in_current_ns(&self) -> Pid {
> > +        let current =3D Task::current_raw();
> > +        // SAFETY: Calling `task_active_pid_ns` with the current task =
is always safe.
> > +        let namespace =3D unsafe { bindings::task_active_pid_ns(curren=
t) };
> > +        // SAFETY: We know that `self.0.get()` is valid by the type in=
variant, and the namespace
> > +        // pointer is not dangling since it points at this task's name=
space.
> > +        unsafe { bindings::task_tgid_nr_ns(self.0.get(), namespace) }
> > +    }
>
> pids are reference counted in the kernel, how does this deal with that?
> Are they just ignored somehow?  Where is the reference count given back?

The intention is that it will be used to replicate the following line
of code from C binder:

trd->sender_pid =3D task_tgid_nr_ns(sender, task_active_pid_ns(current));

The context of this is an ioctl where the `trd` struct contains what
will be copied into userspace as the output of the ioctl. So, the pid
here is just a number that is given to userspace immediately, and
userspace can then do with it as it likes. It is true that the pid is
stale immediately, as the remote process could die and the pid could
get reused. But it is up to userspace to handle that properly. Binder
has a different mechanism than pids that userspace can use for a
trusted way of verifying credentials (see the 5th patch).

If this implementation of pid_in_current_ns actually takes a refcount
on the pid, then it is incorrect because it will leak the refcount in
that case.

Alice

