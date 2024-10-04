Return-Path: <linux-fsdevel+bounces-30966-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD7C2990298
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 14:02:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 296DAB2108B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 12:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BEE415B133;
	Fri,  4 Oct 2024 12:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0n8bqCyF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD31157466
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Oct 2024 12:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728043312; cv=none; b=RvKU0CRsUBvX3WnsAPOvbf/Zf55YMBAGFfg63Ij61EL32FjoGVKB0rCd9j7X+Y2s1AxopR6YD42t51BoxMhSCJqL9qazZmtPFiecNCNp5o50sxSbPVH8DNWIccL12s6GY/aCBNwPDGLCg2ohv1oROGObGep851CTDPBlekxbtvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728043312; c=relaxed/simple;
	bh=bVrMBs0CrOjOoAR7i6eKmzV5c+8J2r1zokBipbTZ7Og=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N9kfCOGGY4ig+Hprncq8nI3pvqurFTK6Kl/cs9uBWi8jDKitNcIdsnpILiVvJE+QuSTs/YQQqwFCbeyaFLIIOQEVLNrIC+15abFdfQp5mZfSPxIQGYDmoA+68iUuQUXRiNZCHb2EN0lLjCYvDtdNRLrXHb2NkA2EeTcmgmFPYFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0n8bqCyF; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42cba6cdf32so20709305e9.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Oct 2024 05:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728043309; x=1728648109; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GOom1Jkoy4BQFztAW4256sSNg2cH9tlbYpqxilJfV6k=;
        b=0n8bqCyFzbFKJw0gKcc8wJUG7n65UvMdzdIXAnprtE0eIj4K/105vchveIo5pDo62e
         QJdUW0N+WNzQtgJa8riaCzKaTTnJLqe/S5pKr+UJHJ2KjHO+4DxHXX5jhHLJLjS6z1Zm
         eIR6HqpVtMI15/27R7HdVJmQq2vwxzKac0CaCRnBlyQTBKnVwncTP6oH1hOtRIcCwc79
         idjX2nxK/4LAmvg3/1F2RawNTXyVJ3vkStuzskkmsyB0XiKGb4jFgqGF7h0jyqDLkNPf
         /ibpst08K3LZUEbvIs2a1edmxiUApZa0hu6lNs1iDWdF65n4lVGoe9HAQ/3atjfUSbnX
         NBmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728043309; x=1728648109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GOom1Jkoy4BQFztAW4256sSNg2cH9tlbYpqxilJfV6k=;
        b=KTk/vDrbXNy5yTaTJppi5ksihT9hjNEsmxCXOTywbdAziOHNYS/N+mKQohbnF+DDWi
         umYUgLkc0P6pyOkI9EIc0rmH+PUPqskApbGbtrvol5aq2blwkJyPa2pU5Cfdn3mZLsFl
         ZVKiE/bvkNqhIjd749QtqO7O8t3eR0RXld+SmiiMw/jXKFtYQSGdEGQS9L4Pjvj6rmYb
         4niIYlRQi9LxJFknxip/K9jz+y6T6OKlDsvdTGUIqpNJobq6y4KZAne2jrzC0TsH3ZBA
         lhXbnMMD+WI/oqqbJ0Ci/7A05ydUOPPOcBuurYMRLsrrGT14pFToygxr4U3LTrmXt5wi
         w7oQ==
X-Forwarded-Encrypted: i=1; AJvYcCUg6Dtb0uVPFimOe4plUpjRr1B+kxgnDmH36/YeyK95QIrHMi3BhJ2gVrwijlO4qp6uZ00KyXORvkfMF8mf@vger.kernel.org
X-Gm-Message-State: AOJu0YxlcJS1AecdUvhKkPxdAw4OwWgWmjgnLWcvVR2pKFo6CHX0+QBo
	zGcgPkiL/rIAPA0he8c192THWCrn9DI/XLZRFqXKzCTT6qtIeJOMRoDECunV8U+aYqlS+ev8BwK
	zrn4ez8tS1cuocPqyqjiM2BGSKa+h+Qi4HS+S
X-Google-Smtp-Source: AGHT+IFSxpuFoLIKo3xZcb3aLkK001iUGVcwYMaj98CyRyr/Gc5dKmCpozl6LE5XE5+L+/WMEBkSYOvi9zZWsA434Zw=
X-Received: by 2002:a05:600c:68d9:b0:42f:512f:fafc with SMTP id
 5b1f17b1804b1-42f8947de8dmr287875e9.29.1728043308993; Fri, 04 Oct 2024
 05:01:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002-brauner-rust-pid_namespace-v5-1-a90e70d44fde@kernel.org>
In-Reply-To: <20241002-brauner-rust-pid_namespace-v5-1-a90e70d44fde@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 4 Oct 2024 14:01:36 +0200
Message-ID: <CAH5fLgg+zsU4q5mrv19+0MhVvTZARsJJzw9aonj6g6tAo5av1g@mail.gmail.com>
Subject: Re: [PATCH v5] rust: add PidNamespace
To: Christian Brauner <brauner@kernel.org>
Cc: rust-for-linux@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Bjoern Roy Baron <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Peter Zijlstra <peterz@infradead.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Arve Hjonnevag <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Dan Williams <dan.j.williams@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>, 
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>, Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Kees Cook <kees@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 2, 2024 at 1:38=E2=80=AFPM Christian Brauner <brauner@kernel.or=
g> wrote:
>
> The lifetime of `PidNamespace` is bound to `Task` and `struct pid`.
>
> The `PidNamespace` of a `Task` doesn't ever change once the `Task` is
> alive. A `unshare(CLONE_NEWPID)` or `setns(fd_pidns/pidfd, CLONE_NEWPID)`
> will not have an effect on the calling `Task`'s pid namespace. It will
> only effect the pid namespace of children created by the calling `Task`.
> This invariant guarantees that after having acquired a reference to a
> `Task`'s pid namespace it will remain unchanged.
>
> When a task has exited and been reaped `release_task()` will be called.
> This will set the `PidNamespace` of the task to `NULL`. So retrieving
> the `PidNamespace` of a task that is dead will return `NULL`. Note, that
> neither holding the RCU lock nor holding a referencing count to the
> `Task` will prevent `release_task()` being called.
>
> In order to retrieve the `PidNamespace` of a `Task` the
> `task_active_pid_ns()` function can be used. There are two cases to
> consider:
>
> (1) retrieving the `PidNamespace` of the `current` task (2) retrieving
> the `PidNamespace` of a non-`current` task
>
> From system call context retrieving the `PidNamespace` for case (1) is
> always safe and requires neither RCU locking nor a reference count to be
> held. Retrieving the `PidNamespace` after `release_task()` for current
> will return `NULL` but no codepath like that is exposed to Rust.
>
> Retrieving the `PidNamespace` from system call context for (2) requires
> RCU protection. Accessing `PidNamespace` outside of RCU protection
> requires a reference count that must've been acquired while holding the
> RCU lock. Note that accessing a non-`current` task means `NULL` can be
> returned as the non-`current` task could have already passed through
> `release_task()`.
>
> To retrieve (1) the `current_pid_ns!()` macro should be used which
> ensure that the returned `PidNamespace` cannot outlive the calling
> scope. The associated `current_pid_ns()` function should not be called
> directly as it could be abused to created an unbounded lifetime for
> `PidNamespace`. The `current_pid_ns!()` macro allows Rust to handle the
> common case of accessing `current`'s `PidNamespace` without RCU
> protection and without having to acquire a reference count.
>
> For (2) the `task_get_pid_ns()` method must be used. This will always
> acquire a reference on `PidNamespace` and will return an `Option` to
> force the caller to explicitly handle the case where `PidNamespace` is
> `None`, something that tends to be forgotten when doing the equivalent
> operation in `C`. Missing RCU primitives make it difficult to perform
> operations that are otherwise safe without holding a reference count as
> long as RCU protection is guaranteed. But it is not important currently.
> But we do want it in the future.
>
> Note for (2) the required RCU protection around calling
> `task_active_pid_ns()` synchronizes against putting the last reference
> of the associated `struct pid` of `task->thread_pid`. The `struct pid`
> stored in that field is used to retrieve the `PidNamespace` of the
> caller. When `release_task()` is called `task->thread_pid` will be
> `NULL`ed and `put_pid()` on said `struct pid` will be delayed in
> `free_pid()` via `call_rcu()` allowing everyone with an RCU protected
> access to the `struct pid` acquired from `task->thread_pid` to finish.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Overall looks good! A few comments below.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

> +            task: unsafe { &*PidNamespace::from_ptr(pidns) },

I think you can simplify this to:
task: unsafe { PidNamespace::from_ptr(pidns) },

> +    /// Returns the given task's pid in the provided pid namespace.
> +    #[doc(alias =3D "task_tgid_nr_ns")]
> +    pub fn tgid_nr_ns(&self, pidns: Option<&PidNamespace>) -> Pid {
> +        match pidns {
> +            // SAFETY: By the type invariant, we know that `self.0` is v=
alid. We received a valid
> +            // PidNamespace that we can use as a pointer.
> +            Some(pidns) =3D> unsafe { bindings::task_tgid_nr_ns(self.0.g=
et(), pidns.as_ptr()) },
> +            // SAFETY: By the type invariant, we know that `self.0` is v=
alid. We received an empty
> +            // PidNamespace and thus pass a null pointer. The underlying=
 C function is safe to be
> +            // used with NULL pointers.
> +            None =3D> unsafe { bindings::task_tgid_nr_ns(self.0.get(), p=
tr::null_mut()) },

The compiler generates better code if you do this:

let pidns =3D match pidns {
    Some(pidns) =3D> pidns.as_ptr(),
    None =3D> core::ptr::null_mut(),
};
unsafe { bindings::task_tgid_nr_ns(self.0.get(), pidns) };

Here it should be able to compile the entire match statement down to a
no-op since None is represented as a null pointer.


Alice

