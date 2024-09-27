Return-Path: <linux-fsdevel+bounces-30258-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E8429887BD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 16:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C5AE2828CC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 14:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3CD1C1732;
	Fri, 27 Sep 2024 14:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U+9auuQD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD001C0DEA
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Sep 2024 14:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727449117; cv=none; b=M5HwLmOI0+jy2EuUtFALcQm3b+7SPBbj7tMSmp56qVpfqEu4TN1sUNqh2qRr0la4iVGmOVKywPv5PsbeOWcQIDb/fzK/jDjkmBcPiThaZ3XRauXi/PHkFTX3lz0UJyS+yY8+FbZSs9P4bGAluOnfJvMcy/h/Rrr4RS+azZpBhoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727449117; c=relaxed/simple;
	bh=HE6O6W2Ruehr/Eu1RUwe4KQ4pn2Eq+ugNzVZ6pTe/kY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WtQ1BM/T4A/FcymPy+/z7WemztDQ+KOXbnr7h6YOomB9kp0ixYpi4M2D9vI3IkeMg3xXrJ1dFGKb8m0kE+vyYm/oqNNOURzhTzV3CcfepQRxBXeK1OLGT3DvR+7fJCu/hSojHvFYflCahBe9CMnuOJSxDS85HB1UqFoJ350gcqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U+9auuQD; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-37cd8972738so539993f8f.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Sep 2024 07:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727449114; x=1728053914; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wAEj/JO1jlpmIzcCBunmBgTlF+U4pRBZ4iY2MlnWamE=;
        b=U+9auuQD1gN8IyTFwAhQuQY5BEWkP8bq9xrzg/Ta1k3UZAU2ZajKm1H+ztVfAd8CBk
         8/dSvDM9zZWoZ2rK++xZojY5YmUfeepxSF+285Uc+atUoMqeGzsLGZxcb3plCzSfsngp
         wcKVGwmDu63yoQosieu3jk5nNoGbY6oTuB/KRrndaDqP3be/MZwCHgq4L2MbYOONhUpG
         KuEzZII5Ws24cGrxrYsPVXcPslabUUVfcNKaO3esTmhJ3kM9NHQt77DS96IFEIcNnPYO
         txPvoIM2S62CtHSkxjd/y05kvIiAk6v4W39eSlTY4yhTM1Uzkv6TJHoq10UV3enhcmh0
         W/3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727449114; x=1728053914;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wAEj/JO1jlpmIzcCBunmBgTlF+U4pRBZ4iY2MlnWamE=;
        b=CdyAei/lrktbepUMv9pxz5F2drROyWVPZHFjqrYuEkn71+wMmUSRjP/anmGjdeLvMv
         Ko0BTEd7gUcCfxh3rHqbMTaaGbLFiNHJF8E+K2qppCCbepl1+lMz+GAZGE0MlSvc4yDX
         EfcNSptc63d1OpfXr6pRLyEPfodfreCEzYv8Qs8sVY24uaznlO6TduzVnlSuh/9j7ch9
         DeRFV51sMBiJhrQqgU5mp5KzyQqWE7l6hIqpxbQ4irUctlXPD4/aaNEq/fKD9ZyGnOuJ
         MUj4RU87jtbr11vIF/aowrH8oQuwUCXmmwRK/l/63UmnVQ6fMyGSu6BYEv0wuHxeePpK
         AK1A==
X-Forwarded-Encrypted: i=1; AJvYcCUv92mqAo6F0r2dczMvCRLunJDbGxzvvoH+69i/60Nr5clQW3meYyttX0kkF1cfWVkLhHhYBxuOiVa+udiY@vger.kernel.org
X-Gm-Message-State: AOJu0YwXYFk8kOzv3OqNFlhNzCjE3TFpVLptf01AcbPOvIRU48gTjX2d
	KsWQa2qurYbxYsThMkyEvBrDCgm50evBrEYLONeo8m4zjKUHhIfNPHgRi7baVFJkoNprqv1uNQp
	Gbzy7oUTf6ui34on9ksnYFyRQTXUpVrn+4bih
X-Google-Smtp-Source: AGHT+IELcwZniWeDG7akdUbrExTM3vBAIwJAIYW45Dt9txQywxDtKH3Os+0yYl3V/P3S0nbbG9MVVsoloqvry+c98Qs=
X-Received: by 2002:adf:dd8e:0:b0:374:c8d1:70be with SMTP id
 ffacd0b85a97d-37cd5b31966mr2081724f8f.38.1727449113441; Fri, 27 Sep 2024
 07:58:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAH5fLgixve=E5=ghc3maXVC+JdqkrPSDqKgJiYEJ9j_MD4GAzg@mail.gmail.com>
 <20240926-bewundere-beseitigen-59808f199f82@brauner> <20240926-pocht-sittlich-87108178c093@brauner>
 <CAH5fLghUj3-8eZMOVhhk0c9x29B7uMj=9dHWsRJYC1ghxqUdxg@mail.gmail.com> <20240927-anreden-unwirklich-c98c1d9ac3a5@brauner>
In-Reply-To: <20240927-anreden-unwirklich-c98c1d9ac3a5@brauner>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 27 Sep 2024 16:58:20 +0200
Message-ID: <CAH5fLggZDETQz6CDGwR8504u3wANFZ_PSw96H9BhHAaCkHjgQg@mail.gmail.com>
Subject: Re: [PATCH] [RFC] rust: add PidNamespace wrapper
To: Christian Brauner <brauner@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Bjoern Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Peter Zijlstra <peterz@infradead.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Arve Hjonnevag <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Dan Williams <dan.j.williams@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>, 
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>, Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2024 at 4:21=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Fri, Sep 27, 2024 at 02:04:13PM GMT, Alice Ryhl wrote:
> > On Thu, Sep 26, 2024 at 6:36=E2=80=AFPM Christian Brauner <brauner@kern=
el.org> wrote:
> > >
> > > Ok, so here's my feeble attempt at getting something going for wrappi=
ng
> > > struct pid_namespace as struct pid_namespace indirectly came up in th=
e
> > > file abstraction thread.
> >
> > This looks great!
>
> Thanks!
>
> >
> > > The lifetime of a pid namespace is intimately tied to the lifetime of
> > > task. The pid namespace of a task doesn't ever change. A
> > > unshare(CLONE_NEWPID) or setns(fd_pidns/pidfd, CLONE_NEWPID) will not
> > > change the task's pid namespace only the pid namespace of children
> > > spawned by the task. This invariant is important to keep in mind.
> > >
> > > After a task is reaped it will be detached from its associated struct
> > > pids via __unhash_process(). This will also set task->thread_pid to
> > > NULL.
> > >
> > > In order to retrieve the pid namespace of a task task_active_pid_ns()
> > > can be used. The helper works on both current and non-current taks bu=
t
> > > the requirements are slightly different in both cases and it depends =
on
> > > where the helper is called.
> > >
> > > The rules for this are simple but difficult for me to translate into
> > > Rust. If task_active_pid_ns() is called on current then no RCU lockin=
g
> > > is needed as current is obviously alive. On the other hand calling
> > > task_active_pid_ns() after release_task() would work but it would mea=
n
> > > task_active_pid_ns() will return NULL.
> > >
> > > Calling task_active_pid_ns() on a non-current task, while valid, must=
 be
> > > under RCU or other protection mechanism as the task might be
> > > release_task() and thus in __unhash_process().
> >
> > Just to confirm, calling task_active_pid_ns() on a non-current task
> > requires the rcu lock even if you own a refcont on the task?
>
> Interesting question. Afaik, yes. task_active_pid_ns() goes via
> task->thread_pid which is a shorthand for task->pid_links[PIDTYPE_PID].
>
> This will be NULLed when the task exits and is dead (so usually when
> someone has waited on it - ignoring ptrace for sanity reasons and
> autoreaping the latter amounts to the same thing just in-kernel):
>
> T1                      T2                                               =
    T3
> exit(0);
>                         wait(T1)
>                         -> wait_task_zombie()
>                            -> release_task()
>                               -> __exit_signals()
>                                  -> __unash_process()
>                                     // sets task->thread_pid =3D=3D NULL =
        task_active_pid_ns(T1)
>                                     // task->pid_links[PIDTYPE_PID] =3D=
=3D NULL
>
> So having a reference to struct task_struct doesn't prevent
> task->thread_pid becoming NULL.
>
> And you touch upon a very interesting point. The lifetime of struct
> pid_namespace is actually tied to struct pid much tighter than it is to
> struct task_struct. So when a task is released (transitions from zombie
> to dead in the common case) the following happens:
>
> release_task()
> -> __exit_signals()
>    -> thread_pid =3D get_pid(task->thread_pid)
>       -> __unhash_process()
>          -> detach_pid(PIDTYPE_PID)
>             -> __change_pid()
>                {
>                        task->thread_pid =3D NULL;
>                        task->pid_links[PIDTYPE_PID] =3D NULL;
>                        free_pid(thread_pid)
>                }
>          put_pid(thread_pid)
>
> And the free_pid() in __change_pid() does a delayed_put_pid() via
> call_rcu().
>
> So afaiu, taking the rcu_read_lock() synchronizes against that
> delayed_put_pid() in __change_pid() so the call_rcu() will wait until
> everyone who does
>
> rcu_read_lock()
> task_active_pid_ns(task)
> rcu_read_unlock()
>
> and sees task->thread_pid non-NULL, is done. This way no additional
> reference count on struct task_struct or struct pid is needed before
> plucking the pid namespace from there. Does that make sense or have I
> gotten it all wrong?

Okay. I agree that the code you have is the best we can do; at least
until we get an rcu guard in Rust.

The macro doesn't quite work. You need to do something to constrain
the lifetime used by `PidNamespace::from_ptr`. Right now, there is no
constraint on the lifetime, so the caller can just pick the lifetime
'static which is the lifetime that never ends. We want to constrain it
to a lifetime that ends before the task dies. The easiest is to create
a local variable and use the lifetime of that local variable. That
way, the reference can never escape the current function, and hence,
can't escape the current task.

More generally, I'm sure there are lots of fields in current where we
can access them without rcu only because we know the current task
isn't going to die on us. I don't think we should have a macro for
every single one. I think we can put together a single macro for
getting a lifetime that ends before returning to userspace, and then
reuse that lifetime for both `current` and `current_pid_ns`, and
possibly also the `DeferredFd` patch.

Alice

