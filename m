Return-Path: <linux-fsdevel+bounces-16342-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6CB89B905
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Apr 2024 09:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E2911C22331
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Apr 2024 07:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874A12E84F;
	Mon,  8 Apr 2024 07:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rjWGhKU6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32EC2C69A
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Apr 2024 07:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712562331; cv=none; b=gTOaW5UiJ02/Y2LfM+gPniOmGUwnhliV5pWy0WCuI9z2bIvYYub6e4qwrfCMEbV6TDwOcgdOT57Ox4PnNn/5I1rG77Vzxat8TbAkGavCPAJDijv1b6IA8KnsTfupg4JPoQoRNHF/YVsvJFfvKHzOjLRkLdB4y8OFZgfBkPtduo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712562331; c=relaxed/simple;
	bh=jJXfIWddi35UG/oL52cj2ushPCF4BAq92gOjRLTcBE4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XKMgzqsrY9s7ZP5CyRP3U3hzFx++vZUBQxnhBepOKVB1fCgy1hwR5cqXWLvmVHjAFJmm/EDRTctld6TwqXCYGpSnJoyYV5giYWTnJlpsyzqrjYix1rrholZRWqx4UW0PIUDdJOqSvc4wgN0cOwhk7Y4LqkyfjpXFMHXbzgw6Pt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rjWGhKU6; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dd169dd4183so5340677276.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Apr 2024 00:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712562328; x=1713167128; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OI5KpRzYDF5XZutb93rKx61o7Q8cGyD5sfKXE5dAqr8=;
        b=rjWGhKU69t7l0xyear2YyJmigRTBKfrDQQ04iYXmQJFFw5o3Tu3jFuT06d4AWV8SfM
         kUXWpDa3hiWOS7stim9zbm2PXnGyXKk0kiiLChLIZjAnvEAdcPGPKAKcAVuukUZuJtlD
         oblEC/7iNbA4Cct5cpjySnL8ssKgYNcvXRSkumI40k0LwJaEFdLyLfdXSpX92DpRkLAS
         35fX/r+cDCBaRPsG40tlPv+09RfdYlRw5uflXdY44mNrIi58+mNexDhxeB8Sw0uahVYv
         IZCu9lO7r5ymVxJr/XLntGEkqldNeaMrbcUSatQYOucKyOOiJdFcxaLGlzoosmvwVFHW
         Nlkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712562328; x=1713167128;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OI5KpRzYDF5XZutb93rKx61o7Q8cGyD5sfKXE5dAqr8=;
        b=B8wNFc++woh/rstboik84lG8WSsgvUJDBMaFj6fTnDbhHCDY/p6yHbKuiPmjjkM0bF
         oOP5IKJRaM3npylBgwWnNhvMRR3XsCg2TeksXPoaJGQld45KFDUYT49w0OpKyJHYzWKL
         2lsBoJn+9GcXzTwqsBJbs6sXenJ6Pnuw/BciedHfd/VlRa8cHqwHnReUCesw+XykJ0K5
         t+ukuFLr+ACJ5noLbol/PMM62SVP4Nwwz2lCgm6RGiBJxdVPAWT36BHdxMzGLYGHHuee
         WLt63lxRiyh+BYlSzaSqLJi78j+Dt3H1WZRCvXw4pU7I+/l5SjPQe9dBliQ01lncpx1R
         0N0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXEKpYLRoe4n8WHvJLt99GXyJ7B5Mqf0apVYYrdlpIFp3tnhimshuKJhZE47i/tqsQZiL+gwCkrsN8veBwWrsc9R00Zng1A6DE2OQhNIg==
X-Gm-Message-State: AOJu0Yw8t1LggG4AIJJX+65diHkaJZMPosmNu3EbGlxl2quyvgc0X+wq
	WEw8KNLE1rfKTfSlser4X9ZDNc6ZbnlIMtudIccwgbSTGM6aVbTbZ6VQn2O8oFNuIqBSWI57khd
	NupC/Rr0M02tZCg==
X-Google-Smtp-Source: AGHT+IHdL/aZamLg8UjszehMa3RrNVFmJ45XWHdjs/i9WmXXqcUrK0l1RcJc3xNBcaOPf7ZwAvcBlZJk1V+pf6U=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a25:aca4:0:b0:dcc:94b7:a7a3 with SMTP id
 x36-20020a25aca4000000b00dcc94b7a7a3mr650814ybi.12.1712562327891; Mon, 08 Apr
 2024 00:45:27 -0700 (PDT)
Date: Mon,  8 Apr 2024 07:45:24 +0000
In-Reply-To: <20240403-wohnort-flausen-748cb8b436af@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240403-wohnort-flausen-748cb8b436af@brauner>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240408074524.981052-1-aliceryhl@google.com>
Subject: Re: [PATCH v5 3/9] rust: file: add Rust abstraction for `struct file`
From: Alice Ryhl <aliceryhl@google.com>
To: brauner@kernel.org
Cc: a.hindborg@samsung.com, alex.gaynor@gmail.com, aliceryhl@google.com, 
	arve@android.com, benno.lossin@proton.me, bjorn3_gh@protonmail.com, 
	boqun.feng@gmail.com, cmllamas@google.com, dan.j.williams@intel.com, 
	dxu@dxuuu.xyz, gary@garyguo.net, gregkh@linuxfoundation.org, 
	joel@joelfernandes.org, keescook@chromium.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, maco@android.com, ojeda@kernel.org, 
	peterz@infradead.org, rust-for-linux@vger.kernel.org, surenb@google.com, 
	tglx@linutronix.de, tkjos@android.com, tmgross@umich.edu, 
	viro@zeniv.linux.org.uk, wedsonaf@gmail.com, willy@infradead.org, 
	yakoyoku@gmail.com
Content-Type: text/plain; charset="utf-8"

Christian Brauner <brauner@kernel.org> wrote:
> On Tue, Apr 02, 2024 at 09:39:57AM +0000, Alice Ryhl wrote:
>> Christian Brauner <brauner@kernel.org> wrote:
>>> On Mon, Apr 01, 2024 at 12:09:08PM +0000, Alice Ryhl wrote:
>>>> Christian Brauner <brauner@kernel.org> wrote:
>>>>> On Wed, Mar 20, 2024 at 06:09:05PM +0000, Alice Ryhl wrote:
>>>>>> Christian Brauner <brauner@kernel.org> wrote:
>>>>>>> On Fri, Feb 09, 2024 at 11:18:16AM +0000, Alice Ryhl wrote:
>>>>>>>> +/// Wraps the kernel's `struct file`.
>>>>>>>> +///
>>>>>>>> +/// This represents an open file rather than a file on a filesystem. Processes generally reference
>>>>>>>> +/// open files using file descriptors. However, file descriptors are not the same as files. A file
>>>>>>>> +/// descriptor is just an integer that corresponds to a file, and a single file may be referenced
>>>>>>>> +/// by multiple file descriptors.
>>>>>>>> +///
>>>>>>>> +/// # Refcounting
>>>>>>>> +///
>>>>>>>> +/// Instances of this type are reference-counted. The reference count is incremented by the
>>>>>>>> +/// `fget`/`get_file` functions and decremented by `fput`. The Rust type `ARef<File>` represents a
>>>>>>>> +/// pointer that owns a reference count on the file.
>>>>>>>> +///
>>>>>>>> +/// Whenever a process opens a file descriptor (fd), it stores a pointer to the file in its `struct
>>>>>>>> +/// files_struct`. This pointer owns a reference count to the file, ensuring the file isn't
>>>>>>>> +/// prematurely deleted while the file descriptor is open. In Rust terminology, the pointers in
>>>>>>>> +/// `struct files_struct` are `ARef<File>` pointers.
>>>>>>>> +///
>>>>>>>> +/// ## Light refcounts
>>>>>>>> +///
>>>>>>>> +/// Whenever a process has an fd to a file, it may use something called a "light refcount" as a
>>>>>>>> +/// performance optimization. Light refcounts are acquired by calling `fdget` and released with
>>>>>>>> +/// `fdput`. The idea behind light refcounts is that if the fd is not closed between the calls to
>>>>>>>> +/// `fdget` and `fdput`, then the refcount cannot hit zero during that time, as the `struct
>>>>>>>> +/// files_struct` holds a reference until the fd is closed. This means that it's safe to access the
>>>>>>>> +/// file even if `fdget` does not increment the refcount.
>>>>>>>> +///
>>>>>>>> +/// The requirement that the fd is not closed during a light refcount applies globally across all
>>>>>>>> +/// threads - not just on the thread using the light refcount. For this reason, light refcounts are
>>>>>>>> +/// only used when the `struct files_struct` is not shared with other threads, since this ensures
>>>>>>>> +/// that other unrelated threads cannot suddenly start using the fd and close it. Therefore,
>>>>>>>> +/// calling `fdget` on a shared `struct files_struct` creates a normal refcount instead of a light
>>>>>>>> +/// refcount.
>>>>>>> 
>>>>>>> When the fdget() calling task doesn't have a shared file descriptor
>>>>>>> table fdget() will not increment the reference count, yes. This
>>>>>>> also implies that you cannot have task A use fdget() and then pass
>>>>>>> f.file to task B that holds on to it while A returns to userspace. It's
>>>>>>> irrelevant that task A won't drop the reference count or that task B
>>>>>>> won't drop the reference count. Because task A could return back to
>>>>>>> userspace and immediately close the fd via a regular close() system call
>>>>>>> at which point task B has a UAF. In other words a file that has been
>>>>>>> gotten via fdget() can't be Send to another task without the Send
>>>>>>> implying taking a reference to it.
>>>>>> 
>>>>>> That matches my understanding.
>>>>>> 
>>>>>> I suppose that technically you can still send it to another thread *if* you
>>>>>> ensure that the current thread waits until that other thread stops using the
>>>>>> file before returning to userspace.
>>>>> 
>>>>> _Technically_ yes, but it would be brittle as hell. The problem is that
>>>>> fdget() _relies_ on being single-threaded for the time that fd is used
>>>>> until fdput(). There's locking assumptions that build on that e.g., for
>>>>> concurrent read/write. So no, that shouldn't be allowed.
>>>>> 
>>>>> Look at how this broke our back when we introduced pidfd_getfd() where
>>>>> we steal an fd from another task. I have a lengthy explanation how that
>>>>> can be used to violate our elided-locking which is based on assuming
>>>>> that we're always single-threaded and the file can't be suddenly shared
>>>>> with another task. So maybe doable but it would make the semantics even
>>>>> more intricate.
>>>> 
>>>> Hmm, the part about elided locking is surprising to me, and may be an
>>>> issue. Can you give more details on that?  Because the current
>>> 
>>> So what I referred to was that we do have fdget_pos(). Roughly, if
>>> there's more than one reference on the file then we need to acquire a
>>> mutex but if it's only a single reference then we can avoid taking the
>>> mutex because we know that we're the only one that has a reference to
>>> that file and no one else can acquire one. Whether or not that mutex was
>>> taken is taken track of in struct fd.
>>> 
>>> So you can't share a file after fdget_pos() has been called on it and
>>> you haven't taken the position mutex. So let's say you had:
>>> 
>>> * Tread A that calls fdget_pos() on file1 and the reference count is
>>>   one. So Thread A doesn't acquire the file position mutex for file1.
>>> * Now somehow that file1 becomes shared, e.g., Thread B calls fget() on
>>>   it and now Thread B does some operation that requires the file
>>>   position mutex.
>>> => Thread A and Thread B race on the file position.
>>> 
>>> So just because you have a reference to a file from somewhere it doesn't
>>> mean you can just share it with another thread.
>>> 
>>> So if yo have an arbitrary reference to a file in Rust and that somehow
>>> can be shared with another thread you risk races here.
>>> 
>>>> abstractions here *do* actually allow what I described, since we
>>>> implement Sync for File.
>>>> 
>>>> I'm not familiar with the pidfd_getfd discussion you are referring to.
>>>> Do you have a link?
>>> 
>>> https://lore.kernel.org/linux-fsdevel/20230724-vfs-fdget_pos-v1-1-a4abfd7103f3@kernel.org
>>> 
>>> pidfd_getfd() can be used to steal a file descriptor from another task.
>>> It's like a non-cooperative SCM_RIGHTS. That means you can have exactly
>>> the scenario described above where a file assumed to be non-shared is
>>> suddenly shared and you have racing reads/writes.
>>> 
>>> For readdir we nowadays always take the file position mutex because of
>>> the pidfd_getfd() business because that might corrupt internal state.
>>> 
>>>> 
>>>> I'm thinking that we may have to provide two different `struct file`
>>>> wrappers to accurately model this API in Rust. Perhaps they could be
>>>> called File and LocalFile, where one is marked as thread safe and the
>>>> other isn't. I can make all LocalFile methods available on File to avoid
>>>> having to duplicate methods that are available on both.
>>> 
>>> But isn't that just struct file and struct fd? Ideally we'd stay close
>>> to something like this.
>> 
>> Right, that kind of naming seems sensible. But I still need to
>> understand the details a bit better. See below on fdget_pos.
>> 
>>>> But it's not clear to me that this is even enough. Even if we give you a
>>>> &LocalFile to prevent you from moving it across threads, you can just
>>>> call File::fget to get an ARef<File> to the same file and then move
>>>> *that* across threads.
>>> 
>>> Yes, absolutely.
>> 
>> One of my challenges is that Binder wants to call File::fget,
>> immediately move it to another thread, and then call fd_install. And
>> it would be pretty unfortunate if that requires unsafe. But like I argue
>> below, it seems hard to design a safe API for this in the face of
>> fdget_pos.
>> 
>>>> This kind of global requirement is not so easy to model. Maybe klint [1]
>>>> could do it ... atomic context violations are a similar kind of global
>>>> check. But having klint do it would be far out.
>>>> 
>>>> Or maybe File::fget should also return a LocalFile?
>>>> 
>>>> But this raises a different question to me. Let's say process A uses
>>>> Binder to send its own fd to process B, and the following things happen:
>>>> 
>>>> 1. Process A enters the ioctl and takes fdget on the fd.
>>>> 2. Process A calls fget on the same fd to send it to another process.
>>>> 3. Process A goes to sleep, waiting for process B to respond.
>>>> 4. Process B receives the message, installs the fd, and returns to userspace.
>>>> 5. Process B responds to the transaction, but does not close the fd.
>>> 
>>> The fd just installed in 4. and the fd you're referring to in 5. are
>>> identical, right? IOW, we're not talking about two different fd (dup)
>>> for the same file, right?
>> 
>> I'm referring to whatever fd_install does given the `struct file` I got
>> from fget in step 2.
>> 
>>>> 6a. Process A finishes sleeping, and returns to userspace from the ioctl.
>>>> 6b. Process B tries to do an operation (e.g. read) on the fd.
>>>> 
>>>> Let's say that 6a and 6b run in parallel.
>>>> 
>>>> Could this potentially result in a data race between step 6a and 6b? I'm
>>>> guessing that step 6a probably doesn't touch any of the code that has
>>>> elided locking assumptions, so in practice I guess there's not a problem
>>>> ... but if you make any sort of elided locking assumption as you exit
>>>> from the ioctl (before reaching the fdput), then it seems to me that you
>>>> have a problem.
>>> 
>>> Yes, 6a doesn't touch any code that has elided locking assumptions.
>>> 
>>> 1'.  Process A enters the ioctl and takes fdget() on the fd. Process A
>>>      holds the only reference to that file and the file descriptor table
>>>      isn't shared. Therefore, f_count is left untouched and remains at 1.
>>> 2'.  Process A calls fget() which unconditionally bumps f_count bringing
>>>      it to 2 and sending it another process (Presumably you intend to
>>>      imply that this reference is now owned by the second process.).
>>> 3'.  [as 3.]
>>> 4'.  Process B installs the file into it's file descriptor table
>>>      consuming that reference from 2'. The f_count remains at 2 with the
>>>      reference from 2' now being owned by Process B.
>>> 5'.  Since Process B isn't closing the fd and has just called
>>>      fd_install() it returns to userspace with f_count untouched and
>>>      still at 2.
>>> 6'a. Process A finishes sleeping and returns to userspace calling
>>>      fdput(). Since the original fdget() was done without bumping the
>>>      reference count the fdput() of Process A will not decrement the
>>>      reference count. So f_count remains at 2.
>>> 6'b. Process B performs a read/write syscall and calls fdget_pos().
>>>      fdget_pos() sees that this file has f_count > 1 and takes the
>>>      file position mutex.
>>> 
>>> So this isn't a problem. The problem is when a file becomes shared
>>> implicitly without the original owner of the file knowing.
>> 
>> Hmm. Yes, but the ioctl code that called fdget doesn't really know that
>> the ioctl shared the file? So why is it okay?
> 
> Why does it matter to the ioctl() code itself? The ioctl() code never
> calls fdget_pos().
> 
>> 
>> It really seems like there are two different things going on here. When
>> it comes to fdget, we only really care about operations that could
>> remove it from the local file descriptor table, since fdget relies on
>> the refcount in that table remaining valid until fdput.
> 
> Yes.
> 
>> 
>> On the other hand, for fdget_pos it also matters whether it gets
>> installed in other file descriptor tables. Threads that reference it
>> through a different fd table will still access the same position.
> 
> Yes, they operate on the same f_pos.
> 
>> 
>> And so this means that between fdget/fdput, there's never any problem
>> with installing the `struct file` into another file descriptor table.
>> Nothing you can do from that other fd table could cause the local fd
>> table to drop its refcount on the file. Whereas such an install can be
>> a problem between fdget_pos/fdput_pos, since that could introduce a race
>> on the position.
>> 
>> Is this correct?
> 
> Yes, but that would imply you're sharing and installing a file into a
> file descriptor table from a read/write/seek codepath. I don't see how
> this can happen without something like e.g., pidfd_getfd(). And the
> fd_install()ing task would then have to go back to userspace and issue a
> concurrent read/write/seek system call while the other thread is still
> reading/writing.
> 
> Overall, we really only care about f_pos consistency because posix
> requires atomicity between reads/writes/seeks. For pidfd_getfd() where
> such sharing can happen non-cooperatively we just don't care as we've
> just declared this to be an instance where we're outside of posix
> guarantees. And for readdir() we unconditionally acquire the mutex.
> 
> I think io_uring is racing on f_pos as well under certain circumstances
> (REQ_F_CUR_POS?) as they don't use fdget_pos() at all. But iirc Jens
> dislikes that they ever allowed that.
> 
>> 
>> I was thinking that if we have some sort of File/LocalFile distinction
>> (or File/Fd), then we may be able to get it to work by limiting what a
>> File can do. For example, let's say that the only thing you can do with
>> a File is install it into fd tables, then by the previous logic, there's
>> no problem with it being safe to move across threads even if there's an
>> active fdget.
>> 
>> But the fdget_pos kind of throws a wrench into that, because now I can
>> no longer say "it's always safe to do File::fget, move it to another
>> thread, and install it into the remote fd table", since that could cause
>> races on the position if there's an active fdget_pos when we call
>> File::fget.
> 
> I think I understand why that's a problem for you but let me try and
> spell it out so I can understand where you're coming from:
> 
> You want the Rust compiler to reject a file becoming shared implicitly
> from any codepath that is beneath fdget_pos() even though no such code
> yet exists (ignoring pidfd_getfd()). So it's a correctness issue to you.

Hi Christian,

I thought some more about this. Here's an idea of how we can encode this
knowledge in the API. It seems like there are a few different things we
might know about a pointer:

1. The pointer is fully shared, that is, all active fdget / fdget_pos
   references (if any) actually incremented the refcount / took the
   lock.

2. The pointer may have active fdget references that didn't increment
   the refcount, but all fdget_pos references (if any) incremented the
   refcount and took the lock.

3. The pointer may have active fdget or fdget_pos references that didn't
   increment the refcount / didn't take the lock.

And orthogonal from that, all of the fdget / fdget_pos references are on
a single thread, so we either know that we are on the same thread as
them, or we don't know that. (Though we don't care about this
distinction in the fully shared case.)

I might encode this information with five different "states":

* FullyShared        - fully shared
* MaybeFdget         - might have fdget, not necessarily on this thread
* MaybeLocalFdget    - might have fdget, but if so, it's on this thread
* MaybeFdgetPos      - might have fdget_pos, not necessarily on this thread
* MaybeLocalFdgetPos - might have fdget_pos, but if so, it's on this thread

And you can make this a parameter on File, so you get pointer types like
these:

* ARef<File<MaybeFdget>> - A pointer to a file that owns a refcount and
  might have an active fdget, possibly on a different thread.

* &File<FullyShared> - A reference to a file that doesn't own a
  refcount, and which is fully shared.

* ARef<File<MaybeLocalFdgetPos>> - A pointer to a file that owns a
  refcount, and may have both active fdget and fdget_pos calls. If it
  does, they're on the same thread as this reference. This is the return
  type of fget.

And if we introduce an Fdget smart pointer too, then it would probably
be typed Fdget<MaybeLocalFdget> or Fdget<MaybeLocalFdgetPos>.

You could do different things with these. For example, a MaybeFdget
reference can be used with fd_install, but a MaybeFdgetPos reference
can't. Similarly, you can close an fd using a FullyShared reference, but
not using any of the weaker kinds.

As for how you get each kind, well, the fget method would return an
MaybeLocalFdgetPos reference, since we know that we're on the right
thread if any fdget/fdget_pos references exist, but we don't otherwise
know anything.

And you could use something similar to the DeferredFdCloser to take a
MaybeLocalFdgetPos or MaybeLocalFdget file reference any upgrade it to a
FullyShared one by waiting until we return to userspace. (But you can't
do this with the non-local variants.)

When we write a Rust wrapper around file_operations that internally uses
File::from_raw_file, then we can have it pass a &File<MaybeLocalFdget>
to the ioctl handler, and a &File<MaybeLocalFdgetPos> to the
read/write/seek handlers. That way, the ioctl handler can do things with
the provided file that don't work when there's an fdget_pos, but the
read/write/seek handlers can't.

Or we can have unsafe methods that do upgrades. For example, the
codepath in Binder that sends an fd from one process to another will
most likely just call fget and then use unsafe to say "I know there are
no active fdget_pos references since I'm in an ioctl" to upgrade the
MaybeLocalFdgetPos it got from fget into an MaybeFdget (not FullyShared
since the ioctl uses fdget), that it sends to the other process and then
fd_installs.

Does this sound sane to you?

Alice

