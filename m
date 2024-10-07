Return-Path: <linux-fsdevel+bounces-31172-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73AE0992AE8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 14:00:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30A372835D1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 12:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B51F1D26EA;
	Mon,  7 Oct 2024 12:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jDFv16yy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799D21534E6;
	Mon,  7 Oct 2024 12:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728302400; cv=none; b=OMf7JLlnc5K6xX+P/8W4w//RxLZUhvDIB7hGFxlz8vf1m5WeKwhuHvGXa4vjWn1/7VpeNgsSaM36hTG0pgvAHx+/PAID7JyWXDJEgIJIPUFUdtej/jVZlhO43XmBP2+8d5cM54sKFE9tgS4NyBasQvTc7io5m387HGf5SPoJOUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728302400; c=relaxed/simple;
	bh=oPVpPn6Ui2amjEQc2TDRdQ2H8AwUBwwc0vm+6qGGTcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jea/hUsmjDuIUC0lsmDOfn39pB4H+zFr2Mszv+dqSHDWU+3Sc0h933fdnGaODW1+L00pdnmUqW6e1N+lAJfFLGHwA/vEczfjl1CAoq2CHIH9AQCoOQjEiMJNQvGr5FiKwn1hgVmIxDsICEd61hfMfH+poO+qBxnxxSxohf2nFp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jDFv16yy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7C0AC4CEC6;
	Mon,  7 Oct 2024 11:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728302400;
	bh=oPVpPn6Ui2amjEQc2TDRdQ2H8AwUBwwc0vm+6qGGTcE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jDFv16yyK5Dyi0nUfKh/hHBE5xHw9LEqpgbnFwy5Wxy2s7WywkpzO8PDv+bozVRsR
	 UVhs8JDUsZfXA2AVDv0u3sui1btanrgB92AIGuWaaww9ibp7ysoIDNIEJFQSEqYQny
	 gtIK3ZkgT80f4NIDNtx6wYANdDnKR+5Wr5aaLMKue1zFVM8e3QllTDU/ZEwTAPoscj
	 dof8xyEHybWP//Gv5m5LJI2FMh42N7HK8ok3NCWbQfHhLnNYHxmmpewYT8EslKelYw
	 /XdfWZ93xp76dDTwmdfmROisYPlYV7WQE1UlVYSG52mAsnkDn6Sd9ck9OTgGQ3yjtW
	 h6If/fyWytbBA==
Date: Mon, 7 Oct 2024 13:59:51 +0200
From: Christian Brauner <brauner@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: rust-for-linux@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Bjoern Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Peter Zijlstra <peterz@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arve Hjonnevag <arve@android.com>, Todd Kjos <tkjos@android.com>, 
	Martijn Coenen <maco@android.com>, Joel Fernandes <joel@joelfernandes.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, 
	Dan Williams <dan.j.williams@intel.com>, Matthew Wilcox <willy@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>, 
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>, Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, Kees Cook <kees@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>
Subject: Re: [PATCH v5] rust: add PidNamespace
Message-ID: <20241007-erfahrbar-bockig-43532f495bf4@brauner>
References: <20241002-brauner-rust-pid_namespace-v5-1-a90e70d44fde@kernel.org>
 <CAH5fLgg+zsU4q5mrv19+0MhVvTZARsJJzw9aonj6g6tAo5av1g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLgg+zsU4q5mrv19+0MhVvTZARsJJzw9aonj6g6tAo5av1g@mail.gmail.com>

On Fri, Oct 04, 2024 at 02:01:36PM GMT, Alice Ryhl wrote:
> On Wed, Oct 2, 2024 at 1:38 PM Christian Brauner <brauner@kernel.org> wrote:
> >
> > The lifetime of `PidNamespace` is bound to `Task` and `struct pid`.
> >
> > The `PidNamespace` of a `Task` doesn't ever change once the `Task` is
> > alive. A `unshare(CLONE_NEWPID)` or `setns(fd_pidns/pidfd, CLONE_NEWPID)`
> > will not have an effect on the calling `Task`'s pid namespace. It will
> > only effect the pid namespace of children created by the calling `Task`.
> > This invariant guarantees that after having acquired a reference to a
> > `Task`'s pid namespace it will remain unchanged.
> >
> > When a task has exited and been reaped `release_task()` will be called.
> > This will set the `PidNamespace` of the task to `NULL`. So retrieving
> > the `PidNamespace` of a task that is dead will return `NULL`. Note, that
> > neither holding the RCU lock nor holding a referencing count to the
> > `Task` will prevent `release_task()` being called.
> >
> > In order to retrieve the `PidNamespace` of a `Task` the
> > `task_active_pid_ns()` function can be used. There are two cases to
> > consider:
> >
> > (1) retrieving the `PidNamespace` of the `current` task (2) retrieving
> > the `PidNamespace` of a non-`current` task
> >
> > From system call context retrieving the `PidNamespace` for case (1) is
> > always safe and requires neither RCU locking nor a reference count to be
> > held. Retrieving the `PidNamespace` after `release_task()` for current
> > will return `NULL` but no codepath like that is exposed to Rust.
> >
> > Retrieving the `PidNamespace` from system call context for (2) requires
> > RCU protection. Accessing `PidNamespace` outside of RCU protection
> > requires a reference count that must've been acquired while holding the
> > RCU lock. Note that accessing a non-`current` task means `NULL` can be
> > returned as the non-`current` task could have already passed through
> > `release_task()`.
> >
> > To retrieve (1) the `current_pid_ns!()` macro should be used which
> > ensure that the returned `PidNamespace` cannot outlive the calling
> > scope. The associated `current_pid_ns()` function should not be called
> > directly as it could be abused to created an unbounded lifetime for
> > `PidNamespace`. The `current_pid_ns!()` macro allows Rust to handle the
> > common case of accessing `current`'s `PidNamespace` without RCU
> > protection and without having to acquire a reference count.
> >
> > For (2) the `task_get_pid_ns()` method must be used. This will always
> > acquire a reference on `PidNamespace` and will return an `Option` to
> > force the caller to explicitly handle the case where `PidNamespace` is
> > `None`, something that tends to be forgotten when doing the equivalent
> > operation in `C`. Missing RCU primitives make it difficult to perform
> > operations that are otherwise safe without holding a reference count as
> > long as RCU protection is guaranteed. But it is not important currently.
> > But we do want it in the future.
> >
> > Note for (2) the required RCU protection around calling
> > `task_active_pid_ns()` synchronizes against putting the last reference
> > of the associated `struct pid` of `task->thread_pid`. The `struct pid`
> > stored in that field is used to retrieve the `PidNamespace` of the
> > caller. When `release_task()` is called `task->thread_pid` will be
> > `NULL`ed and `put_pid()` on said `struct pid` will be delayed in
> > `free_pid()` via `call_rcu()` allowing everyone with an RCU protected
> > access to the `struct pid` acquired from `task->thread_pid` to finish.
> >
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> 
> Overall looks good! A few comments below.
> 
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> 
> > +            task: unsafe { &*PidNamespace::from_ptr(pidns) },
> 
> I think you can simplify this to:
> task: unsafe { PidNamespace::from_ptr(pidns) },

Done.

> 
> > +    /// Returns the given task's pid in the provided pid namespace.
> > +    #[doc(alias = "task_tgid_nr_ns")]
> > +    pub fn tgid_nr_ns(&self, pidns: Option<&PidNamespace>) -> Pid {
> > +        match pidns {
> > +            // SAFETY: By the type invariant, we know that `self.0` is valid. We received a valid
> > +            // PidNamespace that we can use as a pointer.
> > +            Some(pidns) => unsafe { bindings::task_tgid_nr_ns(self.0.get(), pidns.as_ptr()) },
> > +            // SAFETY: By the type invariant, we know that `self.0` is valid. We received an empty
> > +            // PidNamespace and thus pass a null pointer. The underlying C function is safe to be
> > +            // used with NULL pointers.
> > +            None => unsafe { bindings::task_tgid_nr_ns(self.0.get(), ptr::null_mut()) },
> 
> The compiler generates better code if you do this:
> 
> let pidns = match pidns {
>     Some(pidns) => pidns.as_ptr(),
>     None => core::ptr::null_mut(),
> };
> unsafe { bindings::task_tgid_nr_ns(self.0.get(), pidns) };
> 
> Here it should be able to compile the entire match statement down to a
> no-op since None is represented as a null pointer.

Ah, great. Thanks and done!

