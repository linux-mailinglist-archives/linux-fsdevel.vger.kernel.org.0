Return-Path: <linux-fsdevel+bounces-30244-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC3139883DD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 14:04:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A38071F212B5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 12:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEDF318BB8F;
	Fri, 27 Sep 2024 12:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="097hUeN6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00FA61FCE
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Sep 2024 12:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727438669; cv=none; b=aNw9BArebPWp0M95Q8PxKJWoaUKnEUX01Z0q1hTviMnLuwvrg/SwcXn0/OSaK/GwHE+K5dExAZBuYA+XMnpu78m9Jj/1hfA0hAM/qjDwK47hbzH/ymdRNLM85VykrtrmKG4A2Py+WOuPpj8T9txRbuklOtWL9p9Ch6BmBWH9ZFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727438669; c=relaxed/simple;
	bh=A52lZ6eit/IH20xPJbZ0ifh6fyqIylwhlAVPULjwrM8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QP1N0VVr37+cxzJTwR9ZxWvm3ZqCwwdAPLQycPn7Xjzoixdk7y+jIt1JwVXzwCJesvIXRf2Yiz248WrHF+M8Fl1LD+FmAGxyjv4BPV8XGdiiBRiltA5EeGeD1ZQ+Q0EfyFR/knQszQA0IqPX5JRdHInfyp2MZY7qINiSZHYZvnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=097hUeN6; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-37cc9aeb01dso1298288f8f.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Sep 2024 05:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727438666; x=1728043466; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A52lZ6eit/IH20xPJbZ0ifh6fyqIylwhlAVPULjwrM8=;
        b=097hUeN6Fwz5/BL43oDYO8p/1fifXuzVn7Mso1pxqMg/WbzJaigjzvHc90Tf0v1XRc
         aOmdmBLaqJBV9u9K7cuC1AvCSOqZNP9Fr6vIBxF/Ubf5XCNqrHQH77mwanWhOj8HpMzO
         a/POu5LZcImYnMDDwXgUUi7j9BGYcaNfKSLfodZiHNfDt/i3ofPOxhcBKvkJNHHUwha/
         QNmPnUkazkbZCNO1OuIe1RvnVLS4+b8IK4BrDvCMv5xFOscPh7/GYkAONiddW1696Iww
         jpne4UrtHqdi7TISYT6v/2a8qnyNDxYSCxjUB89HoYBbsy+4YBzwH6hB04VMJe6okZ5f
         DzAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727438666; x=1728043466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A52lZ6eit/IH20xPJbZ0ifh6fyqIylwhlAVPULjwrM8=;
        b=KlAXl8R1pNU7/5eyz8EB0w9gyh6roS0saN7yN/IKxkHyOf6jbsDq2c3of8wPkW4z9O
         rIehYBomiSswSUpyF0R7h1csb4I8qdXcw2xKvZ/KsRmsNu9cOBEuk/vsar7Jv0UlNP+c
         qvdo3eXBmtQEHSIjKc5FhsSzenudN2ZmXBZJzpLML8wnpFW1LIh3UiQjosO0nDkE6H/e
         yWocqkq+TQGnJr3ViJcXlqgFkRjOu1i3Dc7NQYvh9WRrmoMmlQWRf/R3sjsV7uAYWTM2
         /aL7GD0GWHl092mamy5yfdCWKZ8PbpVOYvls1cvqwSF3DLDcNDPJshz16VGtjsCf/EPI
         eUKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVO1Ma+3XVPsOZQo07s694AM+oCTARTa74BXp652lfn9OVj5qwkmj1Hgv6onCmKkcWMGjU99hrCPPu3j/Cd@vger.kernel.org
X-Gm-Message-State: AOJu0YwsDtSXhCsZICr6Yo0GDJnqcXa9l0N3jGLvZpj7bTg/PJKPU+T5
	P3AfYVzTgE76EHYa7Bo5ICzgW1yN8ZS9TFTygo3I1IPRqqBsJbCE7EBK+BD5lbATrnizDpb2Osh
	77wVmi1+yPIUuQwIR1qj5pJSAoJG0awdE9lf4
X-Google-Smtp-Source: AGHT+IEy3dP7p1C2eMoRV16OpmNG4PB6S4oIj5yrTQFRdGKMIDUcgcOI2efalw5tNFlnpHn1BB6580PiK2e8zpr1Klo=
X-Received: by 2002:a5d:4808:0:b0:37c:d55a:38a5 with SMTP id
 ffacd0b85a97d-37cd5a69225mr1687246f8f.11.1727438665878; Fri, 27 Sep 2024
 05:04:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAH5fLgixve=E5=ghc3maXVC+JdqkrPSDqKgJiYEJ9j_MD4GAzg@mail.gmail.com>
 <20240926-bewundere-beseitigen-59808f199f82@brauner> <20240926-pocht-sittlich-87108178c093@brauner>
In-Reply-To: <20240926-pocht-sittlich-87108178c093@brauner>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 27 Sep 2024 14:04:13 +0200
Message-ID: <CAH5fLghUj3-8eZMOVhhk0c9x29B7uMj=9dHWsRJYC1ghxqUdxg@mail.gmail.com>
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

On Thu, Sep 26, 2024 at 6:36=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> Ok, so here's my feeble attempt at getting something going for wrapping
> struct pid_namespace as struct pid_namespace indirectly came up in the
> file abstraction thread.

This looks great!

> The lifetime of a pid namespace is intimately tied to the lifetime of
> task. The pid namespace of a task doesn't ever change. A
> unshare(CLONE_NEWPID) or setns(fd_pidns/pidfd, CLONE_NEWPID) will not
> change the task's pid namespace only the pid namespace of children
> spawned by the task. This invariant is important to keep in mind.
>
> After a task is reaped it will be detached from its associated struct
> pids via __unhash_process(). This will also set task->thread_pid to
> NULL.
>
> In order to retrieve the pid namespace of a task task_active_pid_ns()
> can be used. The helper works on both current and non-current taks but
> the requirements are slightly different in both cases and it depends on
> where the helper is called.
>
> The rules for this are simple but difficult for me to translate into
> Rust. If task_active_pid_ns() is called on current then no RCU locking
> is needed as current is obviously alive. On the other hand calling
> task_active_pid_ns() after release_task() would work but it would mean
> task_active_pid_ns() will return NULL.
>
> Calling task_active_pid_ns() on a non-current task, while valid, must be
> under RCU or other protection mechanism as the task might be
> release_task() and thus in __unhash_process().

Just to confirm, calling task_active_pid_ns() on a non-current task
requires the rcu lock even if you own a refcont on the task?

Alice

