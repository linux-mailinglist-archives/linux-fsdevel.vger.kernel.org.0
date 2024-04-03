Return-Path: <linux-fsdevel+bounces-15972-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3CC4896450
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 08:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B4461F24C84
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 06:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CE0650A6D;
	Wed,  3 Apr 2024 06:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PiTRdK6I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61CF4CDF9;
	Wed,  3 Apr 2024 06:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712124122; cv=none; b=lB3NYTbPOeB4pgDqgSGhrZ9scBsYijBWCs5/z3+Chflr/PsMoOFER5sUe4aCxBoJWXPP2Hk4tDzUpVFjcSbh6EIpTFlw2Fd0TVeZSfZiyiZqcUTLc0hCAq+o2oAS91g9NANuCFtv9E4DbeqYNvqCpptU3u0iXPIuuzaHw9VRh8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712124122; c=relaxed/simple;
	bh=NpfBDI28NY5DSPIX3ZCfvhcRXG2J9qzHrrnnoPV9lbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oIvtND3iKF7fL8ONRrSVNicG+9I2lC8bURT0gfjWA0pqyMrS5nZeblwl6cMQf6XnOaZcxf5E0+1xlIJu84AT2AKJVMBrrUKy9t9AoYu7yUytXdlm/gqZVxxcDaCiMF4K7XZjXLUOm3SZ3oD5r2lpr3+Fu1KgGIizZ9jZ4N9U2sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PiTRdK6I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CFFDC433C7;
	Wed,  3 Apr 2024 06:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712124122;
	bh=NpfBDI28NY5DSPIX3ZCfvhcRXG2J9qzHrrnnoPV9lbw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PiTRdK6IjeaAKeAelYQ9As04g+6SUPQ1Ss176wniWxpEYSqY5+zgT9NUF7EwbJEND
	 GNYfD2zUeyvvLxGb+paMvXOInJksqtwDvthnKewH0rmSOXkq8JZSAOYU7XOEJXKabw
	 Ew5ijY1nYYoGSeZwnbx2QB7pwgPoTatY5CYTi4+RiqdCNIFuqyio0vqAvCCmvb/c9S
	 yFHBQ4ANYDAAU/xFE4KrvqlM5ty9L61IyZPQXVtaD5v7lMDtRrJlLfF2lXMJdGpNu0
	 55YlQXL6gwlwsnWyFARg+9Te5E8vbGLoHS+LfFnyb3/S7FYG/CMRbXuf36QNpG3plm
	 QGvCtAXPHL5JQ==
Date: Wed, 3 Apr 2024 08:01:50 +0200
From: Christian Brauner <brauner@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: a.hindborg@samsung.com, alex.gaynor@gmail.com, arve@android.com, 
	benno.lossin@proton.me, bjorn3_gh@protonmail.com, boqun.feng@gmail.com, 
	cmllamas@google.com, dan.j.williams@intel.com, dxu@dxuuu.xyz, gary@garyguo.net, 
	gregkh@linuxfoundation.org, joel@joelfernandes.org, keescook@chromium.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, maco@android.com, ojeda@kernel.org, 
	peterz@infradead.org, rust-for-linux@vger.kernel.org, surenb@google.com, 
	tglx@linutronix.de, tkjos@android.com, tmgross@umich.edu, viro@zeniv.linux.org.uk, 
	wedsonaf@gmail.com, willy@infradead.org, yakoyoku@gmail.com
Subject: Re: [PATCH v5 3/9] rust: file: add Rust abstraction for `struct file`
Message-ID: <20240403-wohnort-flausen-748cb8b436af@brauner>
References: <20240401-marge-gepaukt-9a1972c848d9@brauner>
 <20240402093957.3541602-1-aliceryhl@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240402093957.3541602-1-aliceryhl@google.com>

On Tue, Apr 02, 2024 at 09:39:57AM +0000, Alice Ryhl wrote:
> Christian Brauner <brauner@kernel.org> wrote:
> > On Mon, Apr 01, 2024 at 12:09:08PM +0000, Alice Ryhl wrote:
> >> Christian Brauner <brauner@kernel.org> wrote:
> >>> On Wed, Mar 20, 2024 at 06:09:05PM +0000, Alice Ryhl wrote:
> >>>> Christian Brauner <brauner@kernel.org> wrote:
> >>>>> On Fri, Feb 09, 2024 at 11:18:16AM +0000, Alice Ryhl wrote:
> >>>>>> +/// Wraps the kernel's `struct file`.
> >>>>>> +///
> >>>>>> +/// This represents an open file rather than a file on a filesystem. Processes generally reference
> >>>>>> +/// open files using file descriptors. However, file descriptors are not the same as files. A file
> >>>>>> +/// descriptor is just an integer that corresponds to a file, and a single file may be referenced
> >>>>>> +/// by multiple file descriptors.
> >>>>>> +///
> >>>>>> +/// # Refcounting
> >>>>>> +///
> >>>>>> +/// Instances of this type are reference-counted. The reference count is incremented by the
> >>>>>> +/// `fget`/`get_file` functions and decremented by `fput`. The Rust type `ARef<File>` represents a
> >>>>>> +/// pointer that owns a reference count on the file.
> >>>>>> +///
> >>>>>> +/// Whenever a process opens a file descriptor (fd), it stores a pointer to the file in its `struct
> >>>>>> +/// files_struct`. This pointer owns a reference count to the file, ensuring the file isn't
> >>>>>> +/// prematurely deleted while the file descriptor is open. In Rust terminology, the pointers in
> >>>>>> +/// `struct files_struct` are `ARef<File>` pointers.
> >>>>>> +///
> >>>>>> +/// ## Light refcounts
> >>>>>> +///
> >>>>>> +/// Whenever a process has an fd to a file, it may use something called a "light refcount" as a
> >>>>>> +/// performance optimization. Light refcounts are acquired by calling `fdget` and released with
> >>>>>> +/// `fdput`. The idea behind light refcounts is that if the fd is not closed between the calls to
> >>>>>> +/// `fdget` and `fdput`, then the refcount cannot hit zero during that time, as the `struct
> >>>>>> +/// files_struct` holds a reference until the fd is closed. This means that it's safe to access the
> >>>>>> +/// file even if `fdget` does not increment the refcount.
> >>>>>> +///
> >>>>>> +/// The requirement that the fd is not closed during a light refcount applies globally across all
> >>>>>> +/// threads - not just on the thread using the light refcount. For this reason, light refcounts are
> >>>>>> +/// only used when the `struct files_struct` is not shared with other threads, since this ensures
> >>>>>> +/// that other unrelated threads cannot suddenly start using the fd and close it. Therefore,
> >>>>>> +/// calling `fdget` on a shared `struct files_struct` creates a normal refcount instead of a light
> >>>>>> +/// refcount.
> >>>>> 
> >>>>> When the fdget() calling task doesn't have a shared file descriptor
> >>>>> table fdget() will not increment the reference count, yes. This
> >>>>> also implies that you cannot have task A use fdget() and then pass
> >>>>> f.file to task B that holds on to it while A returns to userspace. It's
> >>>>> irrelevant that task A won't drop the reference count or that task B
> >>>>> won't drop the reference count. Because task A could return back to
> >>>>> userspace and immediately close the fd via a regular close() system call
> >>>>> at which point task B has a UAF. In other words a file that has been
> >>>>> gotten via fdget() can't be Send to another task without the Send
> >>>>> implying taking a reference to it.
> >>>> 
> >>>> That matches my understanding.
> >>>> 
> >>>> I suppose that technically you can still send it to another thread *if* you
> >>>> ensure that the current thread waits until that other thread stops using the
> >>>> file before returning to userspace.
> >>> 
> >>> _Technically_ yes, but it would be brittle as hell. The problem is that
> >>> fdget() _relies_ on being single-threaded for the time that fd is used
> >>> until fdput(). There's locking assumptions that build on that e.g., for
> >>> concurrent read/write. So no, that shouldn't be allowed.
> >>> 
> >>> Look at how this broke our back when we introduced pidfd_getfd() where
> >>> we steal an fd from another task. I have a lengthy explanation how that
> >>> can be used to violate our elided-locking which is based on assuming
> >>> that we're always single-threaded and the file can't be suddenly shared
> >>> with another task. So maybe doable but it would make the semantics even
> >>> more intricate.
> >> 
> >> Hmm, the part about elided locking is surprising to me, and may be an
> >> issue. Can you give more details on that?  Because the current
> > 
> > So what I referred to was that we do have fdget_pos(). Roughly, if
> > there's more than one reference on the file then we need to acquire a
> > mutex but if it's only a single reference then we can avoid taking the
> > mutex because we know that we're the only one that has a reference to
> > that file and no one else can acquire one. Whether or not that mutex was
> > taken is taken track of in struct fd.
> > 
> > So you can't share a file after fdget_pos() has been called on it and
> > you haven't taken the position mutex. So let's say you had:
> > 
> > * Tread A that calls fdget_pos() on file1 and the reference count is
> >   one. So Thread A doesn't acquire the file position mutex for file1.
> > * Now somehow that file1 becomes shared, e.g., Thread B calls fget() on
> >   it and now Thread B does some operation that requires the file
> >   position mutex.
> > => Thread A and Thread B race on the file position.
> > 
> > So just because you have a reference to a file from somewhere it doesn't
> > mean you can just share it with another thread.
> > 
> > So if yo have an arbitrary reference to a file in Rust and that somehow
> > can be shared with another thread you risk races here.
> > 
> >> abstractions here *do* actually allow what I described, since we
> >> implement Sync for File.
> >> 
> >> I'm not familiar with the pidfd_getfd discussion you are referring to.
> >> Do you have a link?
> > 
> > https://lore.kernel.org/linux-fsdevel/20230724-vfs-fdget_pos-v1-1-a4abfd7103f3@kernel.org
> > 
> > pidfd_getfd() can be used to steal a file descriptor from another task.
> > It's like a non-cooperative SCM_RIGHTS. That means you can have exactly
> > the scenario described above where a file assumed to be non-shared is
> > suddenly shared and you have racing reads/writes.
> > 
> > For readdir we nowadays always take the file position mutex because of
> > the pidfd_getfd() business because that might corrupt internal state.
> > 
> >> 
> >> I'm thinking that we may have to provide two different `struct file`
> >> wrappers to accurately model this API in Rust. Perhaps they could be
> >> called File and LocalFile, where one is marked as thread safe and the
> >> other isn't. I can make all LocalFile methods available on File to avoid
> >> having to duplicate methods that are available on both.
> > 
> > But isn't that just struct file and struct fd? Ideally we'd stay close
> > to something like this.
> 
> Right, that kind of naming seems sensible. But I still need to
> understand the details a bit better. See below on fdget_pos.
> 
> >> But it's not clear to me that this is even enough. Even if we give you a
> >> &LocalFile to prevent you from moving it across threads, you can just
> >> call File::fget to get an ARef<File> to the same file and then move
> >> *that* across threads.
> > 
> > Yes, absolutely.
> 
> One of my challenges is that Binder wants to call File::fget,
> immediately move it to another thread, and then call fd_install. And
> it would be pretty unfortunate if that requires unsafe. But like I argue
> below, it seems hard to design a safe API for this in the face of
> fdget_pos.
> 
> >> This kind of global requirement is not so easy to model. Maybe klint [1]
> >> could do it ... atomic context violations are a similar kind of global
> >> check. But having klint do it would be far out.
> >> 
> >> Or maybe File::fget should also return a LocalFile?
> >> 
> >> But this raises a different question to me. Let's say process A uses
> >> Binder to send its own fd to process B, and the following things happen:
> >> 
> >> 1. Process A enters the ioctl and takes fdget on the fd.
> >> 2. Process A calls fget on the same fd to send it to another process.
> >> 3. Process A goes to sleep, waiting for process B to respond.
> >> 4. Process B receives the message, installs the fd, and returns to userspace.
> >> 5. Process B responds to the transaction, but does not close the fd.
> > 
> > The fd just installed in 4. and the fd you're referring to in 5. are
> > identical, right? IOW, we're not talking about two different fd (dup)
> > for the same file, right?
> 
> I'm referring to whatever fd_install does given the `struct file` I got
> from fget in step 2.
> 
> >> 6a. Process A finishes sleeping, and returns to userspace from the ioctl.
> >> 6b. Process B tries to do an operation (e.g. read) on the fd.
> >> 
> >> Let's say that 6a and 6b run in parallel.
> >> 
> >> Could this potentially result in a data race between step 6a and 6b? I'm
> >> guessing that step 6a probably doesn't touch any of the code that has
> >> elided locking assumptions, so in practice I guess there's not a problem
> >> ... but if you make any sort of elided locking assumption as you exit
> >> from the ioctl (before reaching the fdput), then it seems to me that you
> >> have a problem.
> > 
> > Yes, 6a doesn't touch any code that has elided locking assumptions.
> > 
> > 1'.  Process A enters the ioctl and takes fdget() on the fd. Process A
> >      holds the only reference to that file and the file descriptor table
> >      isn't shared. Therefore, f_count is left untouched and remains at 1.
> > 2'.  Process A calls fget() which unconditionally bumps f_count bringing
> >      it to 2 and sending it another process (Presumably you intend to
> >      imply that this reference is now owned by the second process.).
> > 3'.  [as 3.]
> > 4'.  Process B installs the file into it's file descriptor table
> >      consuming that reference from 2'. The f_count remains at 2 with the
> >      reference from 2' now being owned by Process B.
> > 5'.  Since Process B isn't closing the fd and has just called
> >      fd_install() it returns to userspace with f_count untouched and
> >      still at 2.
> > 6'a. Process A finishes sleeping and returns to userspace calling
> >      fdput(). Since the original fdget() was done without bumping the
> >      reference count the fdput() of Process A will not decrement the
> >      reference count. So f_count remains at 2.
> > 6'b. Process B performs a read/write syscall and calls fdget_pos().
> >      fdget_pos() sees that this file has f_count > 1 and takes the
> >      file position mutex.
> > 
> > So this isn't a problem. The problem is when a file becomes shared
> > implicitly without the original owner of the file knowing.
> 
> Hmm. Yes, but the ioctl code that called fdget doesn't really know that
> the ioctl shared the file? So why is it okay?

Why does it matter to the ioctl() code itself? The ioctl() code never
calls fdget_pos().

> 
> It really seems like there are two different things going on here. When
> it comes to fdget, we only really care about operations that could
> remove it from the local file descriptor table, since fdget relies on
> the refcount in that table remaining valid until fdput.

Yes.

> 
> On the other hand, for fdget_pos it also matters whether it gets
> installed in other file descriptor tables. Threads that reference it
> through a different fd table will still access the same position.

Yes, they operate on the same f_pos.

> 
> And so this means that between fdget/fdput, there's never any problem
> with installing the `struct file` into another file descriptor table.
> Nothing you can do from that other fd table could cause the local fd
> table to drop its refcount on the file. Whereas such an install can be
> a problem between fdget_pos/fdput_pos, since that could introduce a race
> on the position.
> 
> Is this correct?

Yes, but that would imply you're sharing and installing a file into a
file descriptor table from a read/write/seek codepath. I don't see how
this can happen without something like e.g., pidfd_getfd(). And the
fd_install()ing task would then have to go back to userspace and issue a
concurrent read/write/seek system call while the other thread is still
reading/writing.

Overall, we really only care about f_pos consistency because posix
requires atomicity between reads/writes/seeks. For pidfd_getfd() where
such sharing can happen non-cooperatively we just don't care as we've
just declared this to be an instance where we're outside of posix
guarantees. And for readdir() we unconditionally acquire the mutex.

I think io_uring is racing on f_pos as well under certain circumstances
(REQ_F_CUR_POS?) as they don't use fdget_pos() at all. But iirc Jens
dislikes that they ever allowed that.

> 
> I was thinking that if we have some sort of File/LocalFile distinction
> (or File/Fd), then we may be able to get it to work by limiting what a
> File can do. For example, let's say that the only thing you can do with
> a File is install it into fd tables, then by the previous logic, there's
> no problem with it being safe to move across threads even if there's an
> active fdget.
> 
> But the fdget_pos kind of throws a wrench into that, because now I can
> no longer say "it's always safe to do File::fget, move it to another
> thread, and install it into the remote fd table", since that could cause
> races on the position if there's an active fdget_pos when we call
> File::fget.

I think I understand why that's a problem for you but let me try and
spell it out so I can understand where you're coming from:

You want the Rust compiler to reject a file becoming shared implicitly
from any codepath that is beneath fdget_pos() even though no such code
yet exists (ignoring pidfd_getfd()). So it's a correctness issue to you.

> 
> >>>>>> +///
> >>>>>> +/// Light reference counts must be released with `fdput` before the system call returns to
> >>>>>> +/// userspace. This means that if you wait until the current system call returns to userspace, then
> >>>>>> +/// all light refcounts that existed at the time have gone away.
> >>>>>> +///
> >>>>>> +/// ## Rust references
> >>>>>> +///
> >>>>>> +/// The reference type `&File` is similar to light refcounts:
> >>>>>> +///
> >>>>>> +/// * `&File` references don't own a reference count. They can only exist as long as the reference
> >>>>>> +///   count stays positive, and can only be created when there is some mechanism in place to ensure
> >>>>>> +///   this.
> >>>>>> +///
> >>>>>> +/// * The Rust borrow-checker normally ensures this by enforcing that the `ARef<File>` from which
> >>>>>> +///   a `&File` is created outlives the `&File`.
> >>>>> 
> >>>>> The section confuses me a little: Does the borrow-checker always ensure
> >>>>> that a &File stays valid or are there circumstances where it doesn't or
> >>>>> are you saying it doesn't enforce it?
> >>>> 
> >>>> The borrow-checker always ensures it.
> >>> 
> >>> Ok, thanks.
> >>> 
> >>>> 
> >>>> A &File is actually short-hand for &'a File, where 'a is some
> >>>> unspecified lifetime. We say that &'a File is annotated with 'a. The
> >>>> borrow-checker rejects any code that tries to use a reference after the
> >>>> end of the lifetime annotated on it.
> >>> 
> >>> Thanks for the explanation.
> >>> 
> >>>> 
> >>>> So as long as you annotate the reference with a sufficiently short
> >>>> lifetime, the borrow checker will prevent UAF. And outside of cases like
> >>> 
> >>> Sorry, but can you explain "sufficiently short lifetime"?
> >> 
> >> By "sufficiently short lifetime" I mean "lifetime that ends before the
> >> object is destroyed".
> > 
> > Ah, ok. It sounded like it was a specific concept that Rust is
> > implementing in contrast to long-term lifetime or sm. Thanks!
> > 
> >> 
> >> Idea being that if the lifetime ends before the object is freed, and the
> >> borrow-checker rejects attempts to use it after the lifetime ends, then
> >> it follows that the borrow-checker prevents use-after-frees.
> >> 
> >>>> from_ptr, the borrow-checker also takes care of ensuring that the
> >>>> lifetimes are sufficiently short.
> >>>> 
> >>>> (Technically &'a File and &'b File are two completely different types,
> >>>> so &File is technically a class of types and not a single type. Rust
> >>>> will automatically convert &'long File to &'short File.)
> >>>> 
> >>>>>> +///
> >>>>>> +/// * Using the unsafe [`File::from_ptr`] means that it is up to the caller to ensure that the
> >>>>>> +///   `&File` only exists while the reference count is positive.
> >>>>> 
> >>>>> What is this used for in binder? If it's not used don't add it.
> >>>> 
> >>>> This is used on the boundary between the Rust part of Binder and the
> >>>> binderfs component that is implemented in C. For example:
> >>> 
> >>> I see, I'm being foiled by my own code...
> >>> 
> >>>> 
> >>>> 	unsafe extern "C" fn rust_binder_open(
> >>>> 	    inode: *mut bindings::inode,
> >>>> 	    file_ptr: *mut bindings::file,
> >>>> 	) -> core::ffi::c_int {
> >>>> 	    // SAFETY: The `rust_binderfs.c` file ensures that `i_private` is set to the return value of a
> >>>> 	    // successful call to `rust_binder_new_device`.
> >>>> 	    let ctx = unsafe { Arc::<Context>::borrow((*inode).i_private) };
> >>>> 	
> >>>> 	    // SAFETY: The caller provides a valid file pointer to a new `struct file`.
> >>>> 	    let file = unsafe { File::from_ptr(file_ptr) };
> >>> 
> >>> We need a better name for this helper than from_ptr() imho. I think
> >>> from_ptr() and as_ptr() is odd for C. How weird would it be to call
> >>> that from_raw_file() and as_raw_file()?
> >>  
> >> That's a reasonable name. I would be happy to rename to that, and I
> >> don't think it is unidiomatic.
> > 
> > Thanks!
> > 
> >> 
> >>> But bigger picture I somewhat struggle with the semantics of this
> >>> because this is not an interface that we have in C and this is really
> >>> about a low-level contract between C and Rust. Specifically this states
> >>> that this pointer is _somehow_ guaranteed valid. And really, this seems
> >>> a bit of a hack.
> >> 
> >> Indeed ... but I think it's a quite common hack. After all, any time you
> >> dereference a raw pointer in Rust, you are making the same assumption.
> >> 
> >>> Naively, I think this should probably not be necessary if
> >>> file_operations are properly wrapped. Or it should at least be demotable
> >>> to a purely internal method that can't be called directly or something.
> >> 
> >> Yes, the usage here of File::from_ptr could probably be hidden inside a
> >> suitably designed file_operations wrapper. The thing is, Rust Binder
> >> doesn't currently use such a wrapper at all. It just exports a global of
> >> type file_operations and the C code in binderfs then references that
> >> global.
> > 
> > Yeah.
> > 
> >> 
> >> Rust Binder used to use such an abstraction, but I ripped it out before
> >> sending the Rust Binder RFC because it didn't actually help. It was
> >> designed for cases where the file system is also implemented in Rust, so
> >> to get it to expose a file_operations global to the C code in binderfs,
> >> I had to reach inside its internal implementation. It did not save me
> >> from doing stuff such as using File::from_ptr from Binder.
> >> 
> >> Now, you could most likely modify those file_operations abstractions to
> >> support my use-case better. But calling into C is already unsafe, so
> >> unless we get multiple drivers that have a similar C/Rust split, it's
> >> not clear that it's useful to extract the logic from Binder. I would
> >> prefer to wait for the file_operations abstraction to get upstreamed by
> >> the people working on VFS bindings, and then we can decide whether we
> >> should rewrite binderfs into Rust and get rid of the logic, or whether
> >> it's worth to expand the file_operations abstraction to support split
> >> C/Rust drivers like the current binderfs.
> >> 
> >>> So what I mean is. fdget() may or may not take a reference. The C
> >>> interface internally knows whether a reference is owned or not by
> >>> abusing the lower two bits in a pointer to keep track of that. Naively,
> >>> I would expect the same information to be available to rust so that it's
> >>> clear to Rust wheter it's dealing with an explicitly referenced file or
> >>> an elided-reference file. Maybe that's not possible and I'm not
> >>> well-versed enough to see that yet.
> >> 
> >> I'm sure Rust can access the same information, but I don't think I'm
> >> currently doing anything that cares about the distinction?
> > 
> > Ok. My main goal is that we end up with an almost 1:1 correspondence
> > between the Rust and C interface so it's easy for current maintainers
> > and developers that don't want to care about Rust to continue to do so
> > and also just somewhat verify that changes they do are sane.
> 
> Sure, that goal makes total sense to me.
> 
> Alice

