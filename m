Return-Path: <linux-fsdevel+bounces-17106-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CECE78A7E1D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 10:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 340DEB23E14
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 08:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2117EF13;
	Wed, 17 Apr 2024 08:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fos1vaBM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C557D3F0
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Apr 2024 08:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713342168; cv=none; b=MtwNza2XcBTPCHC3tFhLDu6nJVGvARyM81eAtRIYABgbVEDM9UIMIh8OWNMfTjggzYcGV23XQg4WTfhWhZNxC3qR6wxQTydUU61ejGSg9qm3CCXuAjHmlbtCQAvdBBaAZKtY6LmpUX5eoxpzXtseUUNJVbne9f+jdrZat9UniCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713342168; c=relaxed/simple;
	bh=CVwHHQ3OisccgR1YQRWbpMofM7M63W9u3wjDpgjVcDg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=trICZFEw/RIQXzUYc46GJZwsHgQiV3x+OjgZKU4AHN7he07FTGVXdRJ/foc7FSCSeXb69T4HAOIbfVm9q62IuUDvtI9Lnxftl5XPkNnAXLUjHxeS1DDbmyr1xXkYc7ItxeaFcgo/AreIer7pYov35lgiMp85C856CxespgT0Xs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fos1vaBM; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-479dd0261c8so272508137.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Apr 2024 01:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713342165; x=1713946965; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vrDmylFAaEoVzcHcLq34XjnLmh1dTKImjpo45ykiV90=;
        b=Fos1vaBMR77jT8yEpIrFi8dPuodTZiD7kNTZ6YcXCSwgDYrBg1J52uDLcT49GP3XGF
         x3I81/gyqKtJA0n2JM28pQJnQI7iyHC+gwWT591Dggn4uqe1O0uGLjBKuRkgP7ktei5d
         SywdHPvxISKyzKyGETZBsh8hMIuAFxjcvlNCvnnWBlPWQfB7u7XInWRJeq599IZ3RtK2
         hOKzv75m7Fu5NZB8zi99ZfLUYBXzKy1zxcYEuA8amZau6ri/d8Hu6kNGsF0dnj0jZZPo
         d+Hyjna5EKRKokrEr51/pdx9Q19T7cMnd9U9lJbQYGfgrB3BV/M54xILHEzNmWqdPYko
         m5ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713342165; x=1713946965;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vrDmylFAaEoVzcHcLq34XjnLmh1dTKImjpo45ykiV90=;
        b=fEUnQG7KHYmpr+l/qL+USf60q9ca+LSQdHgxI/MOFkQVMHJBWEyFp+ImMYzL6Zfqm0
         d9/3n3nCUXzL/FGT/N5t2ZI+JCeHutA586kcyj2g40F8kB3rB3yIkEAbaaX1uSPxL069
         DVCtYzCdgTVMHcId2t9dPDOyvktJV6742L0AJdIIY0/4PMMR5Xqbq6Y3w8UCu+ldRw7n
         Xuj12oWQQ7TS75Z4y0uNbuu3oKUuRQvo5fFYJKmeipOIJQToUhEMO3A/+AZ/JMOxKjRr
         w9fR7ewwsNCyj+pNhEzv7GZpusexQgFo9ttOJpDh88JTTjYmRyatWbGQMZd3eVD79445
         bCoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXl0JGXkS9wyEluPVvzM9lc8YKAVhMZVmi1JeoiHtck20G1XpnrOTTLx25QV/bL610kSFgTdWyHS5Y5KeTt5b1+tEJCw/lEFIhMLZx4+A==
X-Gm-Message-State: AOJu0YxAUu+5nzjIqEwSNUB6djiwdUuWiF96m6PVrjI559r5sE7/PL5n
	9zMiFuQGa7NriGGSt+9mU5ZTYiW7Vs3SHi4RmpYVvQXq+osBRotYcEEp4ovaEq/4qdazOSaTuFb
	lza4IpNrmS85MsWobFlzC+m2Hcczr/dP2mWGw
X-Google-Smtp-Source: AGHT+IEWQQsRoQu4D0u7v6YXab0/ufKNXGlUCaV20b5mO+/raOrOYk9zsZ9abAeLKJ7aLpPWiSUBXebDK9Dq22503FY=
X-Received: by 2002:a05:6102:1499:b0:47b:9264:dbd5 with SMTP id
 d25-20020a056102149900b0047b9264dbd5mr4211312vsv.2.1713342164757; Wed, 17 Apr
 2024 01:22:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403-wohnort-flausen-748cb8b436af@brauner> <20240408074524.981052-1-aliceryhl@google.com>
In-Reply-To: <20240408074524.981052-1-aliceryhl@google.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 17 Apr 2024 10:22:33 +0200
Message-ID: <CAH5fLghsK3TKjA-CQr35i1CGQtBjRs8aVyJhK6D7YevJKPLdaQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/9] rust: file: add Rust abstraction for `struct file`
To: brauner@kernel.org
Cc: a.hindborg@samsung.com, alex.gaynor@gmail.com, arve@android.com, 
	benno.lossin@proton.me, bjorn3_gh@protonmail.com, boqun.feng@gmail.com, 
	cmllamas@google.com, dan.j.williams@intel.com, dxu@dxuuu.xyz, 
	gary@garyguo.net, gregkh@linuxfoundation.org, joel@joelfernandes.org, 
	keescook@chromium.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, maco@android.com, ojeda@kernel.org, 
	peterz@infradead.org, rust-for-linux@vger.kernel.org, surenb@google.com, 
	tglx@linutronix.de, tkjos@android.com, tmgross@umich.edu, 
	viro@zeniv.linux.org.uk, wedsonaf@gmail.com, willy@infradead.org, 
	yakoyoku@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 8, 2024 at 9:45=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> wr=
ote:
>
> Christian Brauner <brauner@kernel.org> wrote:
> > On Tue, Apr 02, 2024 at 09:39:57AM +0000, Alice Ryhl wrote:
> >> Christian Brauner <brauner@kernel.org> wrote:
> >>> On Mon, Apr 01, 2024 at 12:09:08PM +0000, Alice Ryhl wrote:
> >>>> Christian Brauner <brauner@kernel.org> wrote:
> >>>>> On Wed, Mar 20, 2024 at 06:09:05PM +0000, Alice Ryhl wrote:
> >>>>>> Christian Brauner <brauner@kernel.org> wrote:
> >>>>>>> On Fri, Feb 09, 2024 at 11:18:16AM +0000, Alice Ryhl wrote:
> >>>>>>>> +/// Wraps the kernel's `struct file`.
> >>>>>>>> +///
> >>>>>>>> +/// This represents an open file rather than a file on a filesy=
stem. Processes generally reference
> >>>>>>>> +/// open files using file descriptors. However, file descriptor=
s are not the same as files. A file
> >>>>>>>> +/// descriptor is just an integer that corresponds to a file, a=
nd a single file may be referenced
> >>>>>>>> +/// by multiple file descriptors.
> >>>>>>>> +///
> >>>>>>>> +/// # Refcounting
> >>>>>>>> +///
> >>>>>>>> +/// Instances of this type are reference-counted. The reference=
 count is incremented by the
> >>>>>>>> +/// `fget`/`get_file` functions and decremented by `fput`. The =
Rust type `ARef<File>` represents a
> >>>>>>>> +/// pointer that owns a reference count on the file.
> >>>>>>>> +///
> >>>>>>>> +/// Whenever a process opens a file descriptor (fd), it stores =
a pointer to the file in its `struct
> >>>>>>>> +/// files_struct`. This pointer owns a reference count to the f=
ile, ensuring the file isn't
> >>>>>>>> +/// prematurely deleted while the file descriptor is open. In R=
ust terminology, the pointers in
> >>>>>>>> +/// `struct files_struct` are `ARef<File>` pointers.
> >>>>>>>> +///
> >>>>>>>> +/// ## Light refcounts
> >>>>>>>> +///
> >>>>>>>> +/// Whenever a process has an fd to a file, it may use somethin=
g called a "light refcount" as a
> >>>>>>>> +/// performance optimization. Light refcounts are acquired by c=
alling `fdget` and released with
> >>>>>>>> +/// `fdput`. The idea behind light refcounts is that if the fd =
is not closed between the calls to
> >>>>>>>> +/// `fdget` and `fdput`, then the refcount cannot hit zero duri=
ng that time, as the `struct
> >>>>>>>> +/// files_struct` holds a reference until the fd is closed. Thi=
s means that it's safe to access the
> >>>>>>>> +/// file even if `fdget` does not increment the refcount.
> >>>>>>>> +///
> >>>>>>>> +/// The requirement that the fd is not closed during a light re=
fcount applies globally across all
> >>>>>>>> +/// threads - not just on the thread using the light refcount. =
For this reason, light refcounts are
> >>>>>>>> +/// only used when the `struct files_struct` is not shared with=
 other threads, since this ensures
> >>>>>>>> +/// that other unrelated threads cannot suddenly start using th=
e fd and close it. Therefore,
> >>>>>>>> +/// calling `fdget` on a shared `struct files_struct` creates a=
 normal refcount instead of a light
> >>>>>>>> +/// refcount.
> >>>>>>>
> >>>>>>> When the fdget() calling task doesn't have a shared file descript=
or
> >>>>>>> table fdget() will not increment the reference count, yes. This
> >>>>>>> also implies that you cannot have task A use fdget() and then pas=
s
> >>>>>>> f.file to task B that holds on to it while A returns to userspace=
. It's
> >>>>>>> irrelevant that task A won't drop the reference count or that tas=
k B
> >>>>>>> won't drop the reference count. Because task A could return back =
to
> >>>>>>> userspace and immediately close the fd via a regular close() syst=
em call
> >>>>>>> at which point task B has a UAF. In other words a file that has b=
een
> >>>>>>> gotten via fdget() can't be Send to another task without the Send
> >>>>>>> implying taking a reference to it.
> >>>>>>
> >>>>>> That matches my understanding.
> >>>>>>
> >>>>>> I suppose that technically you can still send it to another thread=
 *if* you
> >>>>>> ensure that the current thread waits until that other thread stops=
 using the
> >>>>>> file before returning to userspace.
> >>>>>
> >>>>> _Technically_ yes, but it would be brittle as hell. The problem is =
that
> >>>>> fdget() _relies_ on being single-threaded for the time that fd is u=
sed
> >>>>> until fdput(). There's locking assumptions that build on that e.g.,=
 for
> >>>>> concurrent read/write. So no, that shouldn't be allowed.
> >>>>>
> >>>>> Look at how this broke our back when we introduced pidfd_getfd() wh=
ere
> >>>>> we steal an fd from another task. I have a lengthy explanation how =
that
> >>>>> can be used to violate our elided-locking which is based on assumin=
g
> >>>>> that we're always single-threaded and the file can't be suddenly sh=
ared
> >>>>> with another task. So maybe doable but it would make the semantics =
even
> >>>>> more intricate.
> >>>>
> >>>> Hmm, the part about elided locking is surprising to me, and may be a=
n
> >>>> issue. Can you give more details on that?  Because the current
> >>>
> >>> So what I referred to was that we do have fdget_pos(). Roughly, if
> >>> there's more than one reference on the file then we need to acquire a
> >>> mutex but if it's only a single reference then we can avoid taking th=
e
> >>> mutex because we know that we're the only one that has a reference to
> >>> that file and no one else can acquire one. Whether or not that mutex =
was
> >>> taken is taken track of in struct fd.
> >>>
> >>> So you can't share a file after fdget_pos() has been called on it and
> >>> you haven't taken the position mutex. So let's say you had:
> >>>
> >>> * Tread A that calls fdget_pos() on file1 and the reference count is
> >>>   one. So Thread A doesn't acquire the file position mutex for file1.
> >>> * Now somehow that file1 becomes shared, e.g., Thread B calls fget() =
on
> >>>   it and now Thread B does some operation that requires the file
> >>>   position mutex.
> >>> =3D> Thread A and Thread B race on the file position.
> >>>
> >>> So just because you have a reference to a file from somewhere it does=
n't
> >>> mean you can just share it with another thread.
> >>>
> >>> So if yo have an arbitrary reference to a file in Rust and that someh=
ow
> >>> can be shared with another thread you risk races here.
> >>>
> >>>> abstractions here *do* actually allow what I described, since we
> >>>> implement Sync for File.
> >>>>
> >>>> I'm not familiar with the pidfd_getfd discussion you are referring t=
o.
> >>>> Do you have a link?
> >>>
> >>> https://lore.kernel.org/linux-fsdevel/20230724-vfs-fdget_pos-v1-1-a4a=
bfd7103f3@kernel.org
> >>>
> >>> pidfd_getfd() can be used to steal a file descriptor from another tas=
k.
> >>> It's like a non-cooperative SCM_RIGHTS. That means you can have exact=
ly
> >>> the scenario described above where a file assumed to be non-shared is
> >>> suddenly shared and you have racing reads/writes.
> >>>
> >>> For readdir we nowadays always take the file position mutex because o=
f
> >>> the pidfd_getfd() business because that might corrupt internal state.
> >>>
> >>>>
> >>>> I'm thinking that we may have to provide two different `struct file`
> >>>> wrappers to accurately model this API in Rust. Perhaps they could be
> >>>> called File and LocalFile, where one is marked as thread safe and th=
e
> >>>> other isn't. I can make all LocalFile methods available on File to a=
void
> >>>> having to duplicate methods that are available on both.
> >>>
> >>> But isn't that just struct file and struct fd? Ideally we'd stay clos=
e
> >>> to something like this.
> >>
> >> Right, that kind of naming seems sensible. But I still need to
> >> understand the details a bit better. See below on fdget_pos.
> >>
> >>>> But it's not clear to me that this is even enough. Even if we give y=
ou a
> >>>> &LocalFile to prevent you from moving it across threads, you can jus=
t
> >>>> call File::fget to get an ARef<File> to the same file and then move
> >>>> *that* across threads.
> >>>
> >>> Yes, absolutely.
> >>
> >> One of my challenges is that Binder wants to call File::fget,
> >> immediately move it to another thread, and then call fd_install. And
> >> it would be pretty unfortunate if that requires unsafe. But like I arg=
ue
> >> below, it seems hard to design a safe API for this in the face of
> >> fdget_pos.
> >>
> >>>> This kind of global requirement is not so easy to model. Maybe klint=
 [1]
> >>>> could do it ... atomic context violations are a similar kind of glob=
al
> >>>> check. But having klint do it would be far out.
> >>>>
> >>>> Or maybe File::fget should also return a LocalFile?
> >>>>
> >>>> But this raises a different question to me. Let's say process A uses
> >>>> Binder to send its own fd to process B, and the following things hap=
pen:
> >>>>
> >>>> 1. Process A enters the ioctl and takes fdget on the fd.
> >>>> 2. Process A calls fget on the same fd to send it to another process=
.
> >>>> 3. Process A goes to sleep, waiting for process B to respond.
> >>>> 4. Process B receives the message, installs the fd, and returns to u=
serspace.
> >>>> 5. Process B responds to the transaction, but does not close the fd.
> >>>
> >>> The fd just installed in 4. and the fd you're referring to in 5. are
> >>> identical, right? IOW, we're not talking about two different fd (dup)
> >>> for the same file, right?
> >>
> >> I'm referring to whatever fd_install does given the `struct file` I go=
t
> >> from fget in step 2.
> >>
> >>>> 6a. Process A finishes sleeping, and returns to userspace from the i=
octl.
> >>>> 6b. Process B tries to do an operation (e.g. read) on the fd.
> >>>>
> >>>> Let's say that 6a and 6b run in parallel.
> >>>>
> >>>> Could this potentially result in a data race between step 6a and 6b?=
 I'm
> >>>> guessing that step 6a probably doesn't touch any of the code that ha=
s
> >>>> elided locking assumptions, so in practice I guess there's not a pro=
blem
> >>>> ... but if you make any sort of elided locking assumption as you exi=
t
> >>>> from the ioctl (before reaching the fdput), then it seems to me that=
 you
> >>>> have a problem.
> >>>
> >>> Yes, 6a doesn't touch any code that has elided locking assumptions.
> >>>
> >>> 1'.  Process A enters the ioctl and takes fdget() on the fd. Process =
A
> >>>      holds the only reference to that file and the file descriptor ta=
ble
> >>>      isn't shared. Therefore, f_count is left untouched and remains a=
t 1.
> >>> 2'.  Process A calls fget() which unconditionally bumps f_count bring=
ing
> >>>      it to 2 and sending it another process (Presumably you intend to
> >>>      imply that this reference is now owned by the second process.).
> >>> 3'.  [as 3.]
> >>> 4'.  Process B installs the file into it's file descriptor table
> >>>      consuming that reference from 2'. The f_count remains at 2 with =
the
> >>>      reference from 2' now being owned by Process B.
> >>> 5'.  Since Process B isn't closing the fd and has just called
> >>>      fd_install() it returns to userspace with f_count untouched and
> >>>      still at 2.
> >>> 6'a. Process A finishes sleeping and returns to userspace calling
> >>>      fdput(). Since the original fdget() was done without bumping the
> >>>      reference count the fdput() of Process A will not decrement the
> >>>      reference count. So f_count remains at 2.
> >>> 6'b. Process B performs a read/write syscall and calls fdget_pos().
> >>>      fdget_pos() sees that this file has f_count > 1 and takes the
> >>>      file position mutex.
> >>>
> >>> So this isn't a problem. The problem is when a file becomes shared
> >>> implicitly without the original owner of the file knowing.
> >>
> >> Hmm. Yes, but the ioctl code that called fdget doesn't really know tha=
t
> >> the ioctl shared the file? So why is it okay?
> >
> > Why does it matter to the ioctl() code itself? The ioctl() code never
> > calls fdget_pos().
> >
> >>
> >> It really seems like there are two different things going on here. Whe=
n
> >> it comes to fdget, we only really care about operations that could
> >> remove it from the local file descriptor table, since fdget relies on
> >> the refcount in that table remaining valid until fdput.
> >
> > Yes.
> >
> >>
> >> On the other hand, for fdget_pos it also matters whether it gets
> >> installed in other file descriptor tables. Threads that reference it
> >> through a different fd table will still access the same position.
> >
> > Yes, they operate on the same f_pos.
> >
> >>
> >> And so this means that between fdget/fdput, there's never any problem
> >> with installing the `struct file` into another file descriptor table.
> >> Nothing you can do from that other fd table could cause the local fd
> >> table to drop its refcount on the file. Whereas such an install can be
> >> a problem between fdget_pos/fdput_pos, since that could introduce a ra=
ce
> >> on the position.
> >>
> >> Is this correct?
> >
> > Yes, but that would imply you're sharing and installing a file into a
> > file descriptor table from a read/write/seek codepath. I don't see how
> > this can happen without something like e.g., pidfd_getfd(). And the
> > fd_install()ing task would then have to go back to userspace and issue =
a
> > concurrent read/write/seek system call while the other thread is still
> > reading/writing.
> >
> > Overall, we really only care about f_pos consistency because posix
> > requires atomicity between reads/writes/seeks. For pidfd_getfd() where
> > such sharing can happen non-cooperatively we just don't care as we've
> > just declared this to be an instance where we're outside of posix
> > guarantees. And for readdir() we unconditionally acquire the mutex.
> >
> > I think io_uring is racing on f_pos as well under certain circumstances
> > (REQ_F_CUR_POS?) as they don't use fdget_pos() at all. But iirc Jens
> > dislikes that they ever allowed that.
> >
> >>
> >> I was thinking that if we have some sort of File/LocalFile distinction
> >> (or File/Fd), then we may be able to get it to work by limiting what a
> >> File can do. For example, let's say that the only thing you can do wit=
h
> >> a File is install it into fd tables, then by the previous logic, there=
's
> >> no problem with it being safe to move across threads even if there's a=
n
> >> active fdget.
> >>
> >> But the fdget_pos kind of throws a wrench into that, because now I can
> >> no longer say "it's always safe to do File::fget, move it to another
> >> thread, and install it into the remote fd table", since that could cau=
se
> >> races on the position if there's an active fdget_pos when we call
> >> File::fget.
> >
> > I think I understand why that's a problem for you but let me try and
> > spell it out so I can understand where you're coming from:
> >
> > You want the Rust compiler to reject a file becoming shared implicitly
> > from any codepath that is beneath fdget_pos() even though no such code
> > yet exists (ignoring pidfd_getfd()). So it's a correctness issue to you=
.
>
> Hi Christian,
>
> I thought some more about this. Here's an idea of how we can encode this
> knowledge in the API. It seems like there are a few different things we
> might know about a pointer:
>
> 1. The pointer is fully shared, that is, all active fdget / fdget_pos
>    references (if any) actually incremented the refcount / took the
>    lock.
>
> 2. The pointer may have active fdget references that didn't increment
>    the refcount, but all fdget_pos references (if any) incremented the
>    refcount and took the lock.
>
> 3. The pointer may have active fdget or fdget_pos references that didn't
>    increment the refcount / didn't take the lock.
>
> And orthogonal from that, all of the fdget / fdget_pos references are on
> a single thread, so we either know that we are on the same thread as
> them, or we don't know that. (Though we don't care about this
> distinction in the fully shared case.)
>
> I might encode this information with five different "states":
>
> * FullyShared        - fully shared
> * MaybeFdget         - might have fdget, not necessarily on this thread
> * MaybeLocalFdget    - might have fdget, but if so, it's on this thread
> * MaybeFdgetPos      - might have fdget_pos, not necessarily on this thre=
ad
> * MaybeLocalFdgetPos - might have fdget_pos, but if so, it's on this thre=
ad
>
> And you can make this a parameter on File, so you get pointer types like
> these:
>
> * ARef<File<MaybeFdget>> - A pointer to a file that owns a refcount and
>   might have an active fdget, possibly on a different thread.
>
> * &File<FullyShared> - A reference to a file that doesn't own a
>   refcount, and which is fully shared.
>
> * ARef<File<MaybeLocalFdgetPos>> - A pointer to a file that owns a
>   refcount, and may have both active fdget and fdget_pos calls. If it
>   does, they're on the same thread as this reference. This is the return
>   type of fget.
>
> And if we introduce an Fdget smart pointer too, then it would probably
> be typed Fdget<MaybeLocalFdget> or Fdget<MaybeLocalFdgetPos>.
>
> You could do different things with these. For example, a MaybeFdget
> reference can be used with fd_install, but a MaybeFdgetPos reference
> can't. Similarly, you can close an fd using a FullyShared reference, but
> not using any of the weaker kinds.
>
> As for how you get each kind, well, the fget method would return an
> MaybeLocalFdgetPos reference, since we know that we're on the right
> thread if any fdget/fdget_pos references exist, but we don't otherwise
> know anything.
>
> And you could use something similar to the DeferredFdCloser to take a
> MaybeLocalFdgetPos or MaybeLocalFdget file reference any upgrade it to a
> FullyShared one by waiting until we return to userspace. (But you can't
> do this with the non-local variants.)
>
> When we write a Rust wrapper around file_operations that internally uses
> File::from_raw_file, then we can have it pass a &File<MaybeLocalFdget>
> to the ioctl handler, and a &File<MaybeLocalFdgetPos> to the
> read/write/seek handlers. That way, the ioctl handler can do things with
> the provided file that don't work when there's an fdget_pos, but the
> read/write/seek handlers can't.
>
> Or we can have unsafe methods that do upgrades. For example, the
> codepath in Binder that sends an fd from one process to another will
> most likely just call fget and then use unsafe to say "I know there are
> no active fdget_pos references since I'm in an ioctl" to upgrade the
> MaybeLocalFdgetPos it got from fget into an MaybeFdget (not FullyShared
> since the ioctl uses fdget), that it sends to the other process and then
> fd_installs.
>
> Does this sound sane to you?

Forget what I said above, it's wrong.

I forgot that the fdget regions are tied to the fdtable's refcount,
not the file's refcount. Doing an fget and waiting until the current
thread returns to userspace is not enough to guarantee that no
non-shared fdget regions exist.

But the logic still applies to fdget_pos regions.

Alice

