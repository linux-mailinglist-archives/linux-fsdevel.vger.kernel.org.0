Return-Path: <linux-fsdevel+bounces-30251-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2941F9886ED
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 16:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DFD6B21357
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 14:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52CE812FB1B;
	Fri, 27 Sep 2024 14:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V/YqMEnw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92E2191;
	Fri, 27 Sep 2024 14:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727446869; cv=none; b=cAeCIalv0bMvM+Gqtz+i7SMSI4qfPw38S0lIJ9GJV+fUmMMOy7+9cyqZGcBYBptvCNIdkC1mzarwzIsUYy8ZcWdyExsJQ1npvY+NzMO+V57J1JKAs7y/x1+QynH52dLPy4KEuPuenULUrRxEC5xO7JrBJsHYuSWsZn3wELO5QZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727446869; c=relaxed/simple;
	bh=gfF8BLW/H49a8nGE/ZR/uoAaquOYmKRnzvMeUzAWyX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CQu2H2XEEviXK6GR8eeTAACVaKk7WL+XFQ+PWZ9cEf0K+adTKOQ5kDN35/E1sGY7yEJ1u3UwLqxsJ+dpe1N4fr+JTY7zJ7DDgUfjsl7bq9h0AmUhdLAfxtxfPFKOIoXERG319WmI6Nc6w9xreNDtTEZVHgAg85flkoZcgC/o9f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V/YqMEnw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E25E3C4CEC4;
	Fri, 27 Sep 2024 14:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727446869;
	bh=gfF8BLW/H49a8nGE/ZR/uoAaquOYmKRnzvMeUzAWyX0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V/YqMEnwi59r3EJQyMrx6JDqdvPO9uApn971oz+NC9UX6j8Gc7A5dTOuCWTNqgIUG
	 KQOEtI6YjfKl7qCqdzZeD/oHKobc9U+JZmPzMOGKZjSlK6P/RCPSRFP0vAD8SEVrGr
	 LwkWjpSmCx8sIcbM0mRWsGQudR6bDwQa3jPzlXGeWvSvCv+4E1C1JX9IxLpFtVqCET
	 8i8cSMKjj4odwcOD/JN6B4ofXTYRVUC64ars7F1G8xGNYO1UtWHpBgunynNV3HFnLG
	 +cv1APqiLEhLhj/Gg+Qlj1tc9ajHNG1Q+V/j2VUb1S3kdXpE/L4w3/dyAsXGOYpd5h
	 BlSIPtpnG+DCA==
Date: Fri, 27 Sep 2024 16:21:00 +0200
From: Christian Brauner <brauner@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Bjoern Roy Baron <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Peter Zijlstra <peterz@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arve Hjonnevag <arve@android.com>, Todd Kjos <tkjos@android.com>, 
	Martijn Coenen <maco@android.com>, Joel Fernandes <joel@joelfernandes.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, 
	Dan Williams <dan.j.williams@intel.com>, Matthew Wilcox <willy@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>, 
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>, Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Kees Cook <kees@kernel.org>
Subject: Re: [PATCH] [RFC] rust: add PidNamespace wrapper
Message-ID: <20240927-anreden-unwirklich-c98c1d9ac3a5@brauner>
References: <CAH5fLgixve=E5=ghc3maXVC+JdqkrPSDqKgJiYEJ9j_MD4GAzg@mail.gmail.com>
 <20240926-bewundere-beseitigen-59808f199f82@brauner>
 <20240926-pocht-sittlich-87108178c093@brauner>
 <CAH5fLghUj3-8eZMOVhhk0c9x29B7uMj=9dHWsRJYC1ghxqUdxg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLghUj3-8eZMOVhhk0c9x29B7uMj=9dHWsRJYC1ghxqUdxg@mail.gmail.com>

On Fri, Sep 27, 2024 at 02:04:13PM GMT, Alice Ryhl wrote:
> On Thu, Sep 26, 2024 at 6:36 PM Christian Brauner <brauner@kernel.org> wrote:
> >
> > Ok, so here's my feeble attempt at getting something going for wrapping
> > struct pid_namespace as struct pid_namespace indirectly came up in the
> > file abstraction thread.
> 
> This looks great!

Thanks!

> 
> > The lifetime of a pid namespace is intimately tied to the lifetime of
> > task. The pid namespace of a task doesn't ever change. A
> > unshare(CLONE_NEWPID) or setns(fd_pidns/pidfd, CLONE_NEWPID) will not
> > change the task's pid namespace only the pid namespace of children
> > spawned by the task. This invariant is important to keep in mind.
> >
> > After a task is reaped it will be detached from its associated struct
> > pids via __unhash_process(). This will also set task->thread_pid to
> > NULL.
> >
> > In order to retrieve the pid namespace of a task task_active_pid_ns()
> > can be used. The helper works on both current and non-current taks but
> > the requirements are slightly different in both cases and it depends on
> > where the helper is called.
> >
> > The rules for this are simple but difficult for me to translate into
> > Rust. If task_active_pid_ns() is called on current then no RCU locking
> > is needed as current is obviously alive. On the other hand calling
> > task_active_pid_ns() after release_task() would work but it would mean
> > task_active_pid_ns() will return NULL.
> >
> > Calling task_active_pid_ns() on a non-current task, while valid, must be
> > under RCU or other protection mechanism as the task might be
> > release_task() and thus in __unhash_process().
> 
> Just to confirm, calling task_active_pid_ns() on a non-current task
> requires the rcu lock even if you own a refcont on the task?

Interesting question. Afaik, yes. task_active_pid_ns() goes via
task->thread_pid which is a shorthand for task->pid_links[PIDTYPE_PID].

This will be NULLed when the task exits and is dead (so usually when
someone has waited on it - ignoring ptrace for sanity reasons and
autoreaping the latter amounts to the same thing just in-kernel):

T1                      T2                                                   T3
exit(0);
                        wait(T1)
                        -> wait_task_zombie()
                           -> release_task()
                              -> __exit_signals()
                                 -> __unash_process()
                                    // sets task->thread_pid == NULL         task_active_pid_ns(T1)
                                    // task->pid_links[PIDTYPE_PID] == NULL

So having a reference to struct task_struct doesn't prevent
task->thread_pid becoming NULL.

And you touch upon a very interesting point. The lifetime of struct
pid_namespace is actually tied to struct pid much tighter than it is to
struct task_struct. So when a task is released (transitions from zombie
to dead in the common case) the following happens:

release_task()
-> __exit_signals()
   -> thread_pid = get_pid(task->thread_pid)
      -> __unhash_process()
         -> detach_pid(PIDTYPE_PID)
            -> __change_pid()
               {
                       task->thread_pid = NULL;
                       task->pid_links[PIDTYPE_PID] = NULL;
                       free_pid(thread_pid)
               }
         put_pid(thread_pid)

And the free_pid() in __change_pid() does a delayed_put_pid() via
call_rcu().

So afaiu, taking the rcu_read_lock() synchronizes against that
delayed_put_pid() in __change_pid() so the call_rcu() will wait until
everyone who does

rcu_read_lock()
task_active_pid_ns(task)
rcu_read_unlock()

and sees task->thread_pid non-NULL, is done. This way no additional
reference count on struct task_struct or struct pid is needed before
plucking the pid namespace from there. Does that make sense or have I
gotten it all wrong?

