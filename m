Return-Path: <linux-fsdevel+bounces-9415-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C0B840BCF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 17:40:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E6DB28B829
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 16:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 055311586E9;
	Mon, 29 Jan 2024 16:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KMUc2Y4x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE691586CE
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jan 2024 16:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706546089; cv=none; b=nXOT+JlHVuTDJl20FzMMbZe24cagNiKVs2WAiCGg9KLv3T7ZaojRm20/WV6RR9xvjeP+TwknpfOhupcXUfUw7Xctf+3cAPT0ZfDp7zkSl6gEypWaRSK7euQrLJQIUFcWjxpw2Rmy39DpeXl0hSs3PfJyF8r3k9V889fLU9kSLbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706546089; c=relaxed/simple;
	bh=2ysp8xzZ2ijLpC3UjlfBYnMfMc42OZjhzu/pM53zauA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YGdKcrmOLzoIEat7yr6h3gFVQMD/CyaB30aniOdnf9+ITHunCgZfwlMKGEUwGcvHHBkooJzBYvNo5ofuvNwxDySHXBJLjbyOraU8shWPYXpGV6bvTl8GwCxuzFsG4u9wxlp+DAHpQfhMR38ec6RuBNmxInjo69P0rutNNVspE1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KMUc2Y4x; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-46b20b23ff7so419158137.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jan 2024 08:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706546086; x=1707150886; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MpVKM3yRiP+yg4ryGA4vjUxvWh8Rf+cYKGJ33h6BpOE=;
        b=KMUc2Y4xPCZUSi/Ue23kT1qgxUEgsVKPlpRf9rP62SddLsMUKd/1AIxQQDNVctfrTM
         fNziAwl0nxeNovcJ7KvR/EefjoI/VzzKeA40e43tiItMhtyZ22sQu0BQU/x/kChndQ3n
         BZsW4xtNvQHfJQA0cuTXjhzbxzQySAvYDTGhNsBovxetq5CE5cQG83NAa0aYbiDL5VVU
         rPYT1AIcRgdDHOYmAI3XunuSwiCa0Y0iXXRNmLOdFZZDyQ6703RRLGqldlIbsOu0Ht64
         liiG6llxq9T2J6jZtEEgss1ucmQyjstSDV1jBVei/TQOK0gWzaIHbI7LoRxpaiVMPQMJ
         7huQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706546086; x=1707150886;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MpVKM3yRiP+yg4ryGA4vjUxvWh8Rf+cYKGJ33h6BpOE=;
        b=sKd/WWhLqMmCIHK222v9BvDZe/M9bnMu/WIsV4ac0jgi7UShcTQwtXGdr7X1bpC6cO
         PfOTOVgEYQZk3pP7m1qRY96DMTlVaEvwuZutIIYWJdq51Zo7qe6rag09pJecIUxjrcGh
         b8OO7M78s3uuNiA/hl6ErfQ8boXG25OhBLi9/6OKtOsYoxmqRhB0SNNijiLDi4BKREDr
         80tHNroYMqEuHmnV4EjQf3xIVLHDB1+YB3ReQrtgts17CHQLzbEh5FvIH8YA05Ci+WHc
         +ckBE4L1ulMY6s89s6fEisTvpagEwcK0u+mqqfPQ8PffgDww4QQSz8NM5q7wtpUjPAtm
         yyLg==
X-Gm-Message-State: AOJu0YydnDogvEp0B6067edgo7wziBd4vMblV4KBg2nNGEK5hvDM+8NU
	tC1oDo73C/ON2eQapXdxnRnC78YVc1abkoEnnsGuiOJRkOdWQ1XbtwuKcmcjq5ujXkcORt113aO
	xOYpdv3B/Oux3tnCnHvyPDJqo5DUVWLITEgPP
X-Google-Smtp-Source: AGHT+IH9l25M7IOzt7jHNHtkHsBSedNrJnFYPe/KE0LARVNkZZdyeCfjl0cIWiUtZoxx0bQaZKajdD7rdO2BApZGu+M=
X-Received: by 2002:a05:6122:4b14:b0:4b6:c37b:726e with SMTP id
 fc20-20020a0561224b1400b004b6c37b726emr2162707vkb.18.1706546084941; Mon, 29
 Jan 2024 08:34:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240118-alice-file-v3-0-9694b6f9580c@google.com>
 <20240118-alice-file-v3-1-9694b6f9580c@google.com> <5dbbaba2-fd7f-4734-9f44-15d2a09b4216@proton.me>
In-Reply-To: <5dbbaba2-fd7f-4734-9f44-15d2a09b4216@proton.me>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 29 Jan 2024 17:34:33 +0100
Message-ID: <CAH5fLghgc_z23dOR2L5vnPhVmhiKqZxR6jin9KCA5e_ii4BL3w@mail.gmail.com>
Subject: Re: [PATCH v3 1/9] rust: file: add Rust abstraction for `struct file`
To: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Peter Zijlstra <peterz@infradead.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Dan Williams <dan.j.williams@intel.com>, 
	Kees Cook <keescook@chromium.org>, Matthew Wilcox <willy@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2024 at 4:04=E2=80=AFPM Benno Lossin <benno.lossin@proton.m=
e> wrote:
>
> On 18.01.24 15:36, Alice Ryhl wrote:
> > +/// Wraps the kernel's `struct file`.
> > +///
> > +/// # Refcounting
> > +///
> > +/// Instances of this type are reference-counted. The reference count =
is incremented by the
> > +/// `fget`/`get_file` functions and decremented by `fput`. The Rust ty=
pe `ARef<File>` represents a
> > +/// pointer that owns a reference count on the file.
> > +///
> > +/// Whenever a process opens a file descriptor (fd), it stores a point=
er to the file in its `struct
> > +/// files_struct`. This pointer owns a reference count to the file, en=
suring the file isn't
> > +/// prematurely deleted while the file descriptor is open. In Rust ter=
minology, the pointers in
> > +/// `struct files_struct` are `ARef<File>` pointers.
> > +///
> > +/// ## Light refcounts
> > +///
> > +/// Whenever a process has an fd to a file, it may use something calle=
d a "light refcount" as a
> > +/// performance optimization. Light refcounts are acquired by calling =
`fdget` and released with
> > +/// `fdput`. The idea behind light refcounts is that if the fd is not =
closed between the calls to
> > +/// `fdget` and `fdput`, then the refcount cannot hit zero during that=
 time, as the `struct
> > +/// files_struct` holds a reference until the fd is closed. This means=
 that it's safe to access the
> > +/// file even if `fdget` does not increment the refcount.
> > +///
> > +/// The requirement that the fd is not closed during a light refcount =
applies globally across all
> > +/// threads - not just on the thread using the light refcount. For thi=
s reason, light refcounts are
> > +/// only used when the `struct files_struct` is not shared with other =
threads, since this ensures
> > +/// that other unrelated threads cannot suddenly start using the fd an=
d close it. Therefore,
> > +/// calling `fdget` on a shared `struct files_struct` creates a normal=
 refcount instead of a light
> > +/// refcount.
> > +///
> > +/// Light reference counts must be released with `fdput` before the sy=
stem call returns to
> > +/// userspace. This means that if you wait until the current system ca=
ll returns to userspace, then
> > +/// all light refcounts that existed at the time have gone away.
> > +///
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
> > +///
> > +/// # Invariants
> > +///
> > +/// * Instances of this type are refcounted using the `f_count` field.
> > +/// * If an fd with active light refcounts is closed, then it must be =
the case that the file
> > +///   refcount is positive until there are no more light refcounts cre=
ated from the fd that got
>
> I think this wording can be easily misinterpreted: "until there
> are no more light refcounts created" could mean that you are allowed
> to drop the refcount to zero after the last light refcount has been
> created. But in reality you want all light refcounts to be released
> first.
> I would suggest "until all light refcounts of the fd have been dropped"
> or similar.

Will do.

> > +///   closed.
> > +/// * A light refcount must be dropped before returning to userspace.
> > +#[repr(transparent)]
> > +pub struct File(Opaque<bindings::file>);
> > +
> > +// SAFETY: By design, the only way to access a `File` is via an immuta=
ble reference or an `ARef`.
> > +// This means that the only situation in which a `File` can be accesse=
d mutably is when the
> > +// refcount drops to zero and the destructor runs. It is safe for that=
 to happen on any thread, so
> > +// it is ok for this type to be `Send`.
>
> Technically, `drop` is never called for `File`, since it is only used
> via `ARef<File>` which calls `dec_ref` instead. Also since it only contai=
ns
> an `Opaque`, dropping it is a noop.
> But what does `Send` mean for this type? Since it is used together with
> `ARef`, being `Send` means that `File::dec_ref` can be called from any
> thread. I think we are missing this as a safety requirement on
> `AlwaysRefCounted`, do you agree?
> I think the safety justification here could be (with the requirement adde=
d
> to `AlwaysRefCounted`):
>
>      SAFETY:
>      - `File::drop` can be called from any thread.
>      - `File::dec_ref` can be called from any thread.

This wording was taken from rust/kernel/task.rs. I think it's out of
scope to reword it.

Besides, it says "destructor runs", not "drop runs". The destructor
can be interpreted to mean the right thing for ARef.

The right safety comment would probably be that dec_ref can be called
from any thread.

Alice

