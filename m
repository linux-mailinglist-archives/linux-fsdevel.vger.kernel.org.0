Return-Path: <linux-fsdevel+bounces-15805-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C08289319D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 Mar 2024 14:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46A172820B3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 Mar 2024 12:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3641448F2;
	Sun, 31 Mar 2024 12:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JIZqx5Ie"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D551C0DD3;
	Sun, 31 Mar 2024 12:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711889745; cv=none; b=puC2cPP+miNnFoBneQkZgBB99B6fWvzqJhf/n8RBGib+DETaO75ch04yh2NYaO4ooJTmhbFD5PeXfxviWunEZz7OA09kI6A2IQRDjGWSsesmXoHMyK7GEim+hanBRJC0Q1spOHOmF4LpkVgW8d3VrTBu3NM1hswjJkuQlAQe0Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711889745; c=relaxed/simple;
	bh=8nhBa9A6E7OCBceKD5lGdt//TuWHKMwSZP1rusZVNGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C+5MjYykpr0L0nzy9bWpra6GJGptBcgO1YAk+IMS0GPaCTyDx22qI6SQRr1w6Szy9hhpZNHEhGCXhCs/N/J4q13hFKGOADEcTbisDeypByiNv7m7NXXsPH90bleBmQlL0nVTAVfW6pCGJHsqVxkD1O31Kff/oXv9UjWZNuFLfS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JIZqx5Ie; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D1DBC433F1;
	Sun, 31 Mar 2024 12:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711889745;
	bh=8nhBa9A6E7OCBceKD5lGdt//TuWHKMwSZP1rusZVNGw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JIZqx5IeHFq/LF+LOnbGEorwt2qCR42M543FksbPJaB68hgfYHdX3rqm+fRFQabiT
	 y37CrAJ9idUub/lXCH8yZQ7CGRZ4z587xCuS3KxgEwSI27Z0TsFHSOjfzNmF8mqR+k
	 nVc32Mi2AJFiLos2AoyMKJkq6NpmxXkcrG07KnNubkbfzRBUqmK/UFSf0b56YEBX8S
	 wqO8GLu+hAdO/a+GS5MwGT+8MtrAncaCH+uO9anTgzeNS5DaPXLCinpwtLio9H9gfA
	 UxyoPhUbTl/dFXpAjQjw+zLBAAduMO/U1FBVVCO3Vu1SuJwJTIMfW2eFjKmXbuyBn2
	 SY+d7eMLpUwwg==
Date: Sun, 31 Mar 2024 14:55:13 +0200
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
Message-ID: <20240331-kellner-ausrufen-5b6c191fba35@brauner>
References: <20240320-wegziehen-teilhaben-86e071fa163c@brauner>
 <20240320180905.3858535-1-aliceryhl@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240320180905.3858535-1-aliceryhl@google.com>

On Wed, Mar 20, 2024 at 06:09:05PM +0000, Alice Ryhl wrote:
> Christian Brauner <brauner@kernel.org> wrote:
> > On Fri, Feb 09, 2024 at 11:18:16AM +0000, Alice Ryhl wrote:
> >> From: Wedson Almeida Filho <wedsonaf@gmail.com>
> >> 
> >> This abstraction makes it possible to manipulate the open files for a
> >> process. The new `File` struct wraps the C `struct file`. When accessing
> >> it using the smart pointer `ARef<File>`, the pointer will own a
> >> reference count to the file. When accessing it as `&File`, then the
> >> reference does not own a refcount, but the borrow checker will ensure
> >> that the reference count does not hit zero while the `&File` is live.
> >> 
> >> Since this is intended to manipulate the open files of a process, we
> >> introduce an `fget` constructor that corresponds to the C `fget`
> >> method. In future patches, it will become possible to create a new fd in
> >> a process and bind it to a `File`. Rust Binder will use these to send
> >> fds from one process to another.
> >> 
> >> We also provide a method for accessing the file's flags. Rust Binder
> >> will use this to access the flags of the Binder fd to check whether the
> >> non-blocking flag is set, which affects what the Binder ioctl does.
> >> 
> >> This introduces a struct for the EBADF error type, rather than just
> >> using the Error type directly. This has two advantages:
> >> * `File::from_fd` returns a `Result<ARef<File>, BadFdError>`, which the
> > 
> > Sorry, where's that method?
> 
> Sorry, this is supposed to say `File::fget`.
> 
> >> +/// Wraps the kernel's `struct file`.
> >> +///
> >> +/// This represents an open file rather than a file on a filesystem. Processes generally reference
> >> +/// open files using file descriptors. However, file descriptors are not the same as files. A file
> >> +/// descriptor is just an integer that corresponds to a file, and a single file may be referenced
> >> +/// by multiple file descriptors.
> >> +///
> >> +/// # Refcounting
> >> +///
> >> +/// Instances of this type are reference-counted. The reference count is incremented by the
> >> +/// `fget`/`get_file` functions and decremented by `fput`. The Rust type `ARef<File>` represents a
> >> +/// pointer that owns a reference count on the file.
> >> +///
> >> +/// Whenever a process opens a file descriptor (fd), it stores a pointer to the file in its `struct
> >> +/// files_struct`. This pointer owns a reference count to the file, ensuring the file isn't
> >> +/// prematurely deleted while the file descriptor is open. In Rust terminology, the pointers in
> >> +/// `struct files_struct` are `ARef<File>` pointers.
> >> +///
> >> +/// ## Light refcounts
> >> +///
> >> +/// Whenever a process has an fd to a file, it may use something called a "light refcount" as a
> >> +/// performance optimization. Light refcounts are acquired by calling `fdget` and released with
> >> +/// `fdput`. The idea behind light refcounts is that if the fd is not closed between the calls to
> >> +/// `fdget` and `fdput`, then the refcount cannot hit zero during that time, as the `struct
> >> +/// files_struct` holds a reference until the fd is closed. This means that it's safe to access the
> >> +/// file even if `fdget` does not increment the refcount.
> >> +///
> >> +/// The requirement that the fd is not closed during a light refcount applies globally across all
> >> +/// threads - not just on the thread using the light refcount. For this reason, light refcounts are
> >> +/// only used when the `struct files_struct` is not shared with other threads, since this ensures
> >> +/// that other unrelated threads cannot suddenly start using the fd and close it. Therefore,
> >> +/// calling `fdget` on a shared `struct files_struct` creates a normal refcount instead of a light
> >> +/// refcount.
> > 
> > When the fdget() calling task doesn't have a shared file descriptor
> > table fdget() will not increment the reference count, yes. This
> > also implies that you cannot have task A use fdget() and then pass
> > f.file to task B that holds on to it while A returns to userspace. It's
> > irrelevant that task A won't drop the reference count or that task B
> > won't drop the reference count. Because task A could return back to
> > userspace and immediately close the fd via a regular close() system call
> > at which point task B has a UAF. In other words a file that has been
> > gotten via fdget() can't be Send to another task without the Send
> > implying taking a reference to it.
> 
> That matches my understanding.
> 
> I suppose that technically you can still send it to another thread *if* you
> ensure that the current thread waits until that other thread stops using the
> file before returning to userspace.

_Technically_ yes, but it would be brittle as hell. The problem is that
fdget() _relies_ on being single-threaded for the time that fd is used
until fdput(). There's locking assumptions that build on that e.g., for
concurrent read/write. So no, that shouldn't be allowed.

Look at how this broke our back when we introduced pidfd_getfd() where
we steal an fd from another task. I have a lengthy explanation how that
can be used to violate our elided-locking which is based on assuming
that we're always single-threaded and the file can't be suddenly shared
with another task. So maybe doable but it would make the semantics even
more intricate.

> >> +///
> >> +/// Light reference counts must be released with `fdput` before the system call returns to
> >> +/// userspace. This means that if you wait until the current system call returns to userspace, then
> >> +/// all light refcounts that existed at the time have gone away.
> >> +///
> >> +/// ## Rust references
> >> +///
> >> +/// The reference type `&File` is similar to light refcounts:
> >> +///
> >> +/// * `&File` references don't own a reference count. They can only exist as long as the reference
> >> +///   count stays positive, and can only be created when there is some mechanism in place to ensure
> >> +///   this.
> >> +///
> >> +/// * The Rust borrow-checker normally ensures this by enforcing that the `ARef<File>` from which
> >> +///   a `&File` is created outlives the `&File`.
> > 
> > The section confuses me a little: Does the borrow-checker always ensure
> > that a &File stays valid or are there circumstances where it doesn't or
> > are you saying it doesn't enforce it?
> 
> The borrow-checker always ensures it.

Ok, thanks.

> 
> A &File is actually short-hand for &'a File, where 'a is some
> unspecified lifetime. We say that &'a File is annotated with 'a. The
> borrow-checker rejects any code that tries to use a reference after the
> end of the lifetime annotated on it.

Thanks for the explanation.

> 
> So as long as you annotate the reference with a sufficiently short
> lifetime, the borrow checker will prevent UAF. And outside of cases like

Sorry, but can you explain "sufficiently short lifetime"?

> from_ptr, the borrow-checker also takes care of ensuring that the
> lifetimes are sufficiently short.
> 
> (Technically &'a File and &'b File are two completely different types,
> so &File is technically a class of types and not a single type. Rust
> will automatically convert &'long File to &'short File.)
> 
> >> +///
> >> +/// * Using the unsafe [`File::from_ptr`] means that it is up to the caller to ensure that the
> >> +///   `&File` only exists while the reference count is positive.
> > 
> > What is this used for in binder? If it's not used don't add it.
> 
> This is used on the boundary between the Rust part of Binder and the
> binderfs component that is implemented in C. For example:

I see, I'm being foiled by my own code...

> 
> 	unsafe extern "C" fn rust_binder_open(
> 	    inode: *mut bindings::inode,
> 	    file_ptr: *mut bindings::file,
> 	) -> core::ffi::c_int {
> 	    // SAFETY: The `rust_binderfs.c` file ensures that `i_private` is set to the return value of a
> 	    // successful call to `rust_binder_new_device`.
> 	    let ctx = unsafe { Arc::<Context>::borrow((*inode).i_private) };
> 	
> 	    // SAFETY: The caller provides a valid file pointer to a new `struct file`.
> 	    let file = unsafe { File::from_ptr(file_ptr) };

We need a better name for this helper than from_ptr() imho. I think
from_ptr() and as_ptr() is odd for C. How weird would it be to call
that from_raw_file() and as_raw_file()?

But bigger picture I somewhat struggle with the semantics of this
because this is not an interface that we have in C and this is really
about a low-level contract between C and Rust. Specifically this states
that this pointer is _somehow_ guaranteed valid. And really, this seems
a bit of a hack.

Naively, I think this should probably not be necessary if
file_operations are properly wrapped. Or it should at least be demotable
to a purely internal method that can't be called directly or something.

So what I mean is. fdget() may or may not take a reference. The C
interface internally knows whether a reference is owned or not by
abusing the lower two bits in a pointer to keep track of that. Naively,
I would expect the same information to be available to rust so that it's
clear to Rust wheter it's dealing with an explicitly referenced file or
an elided-reference file. Maybe that's not possible and I'm not
well-versed enough to see that yet.

> 	    let process = match Process::open(ctx, file) {
> 	        Ok(process) => process,
> 	        Err(err) => return err.to_errno(),
> 	    };
> 	    // SAFETY: This file is associated with Rust binder, so we own the `private_data` field.
> 	    unsafe {
> 	        (*file_ptr).private_data = process.into_foreign().cast_mut();
> 	    }
> 	    0
> 	}
> 
> Here, rust_binder_open is the open function in a struct file_operations
> vtable. In this case, file_ptr is guaranteed by the caller to be valid

Where's the code that wraps struct file_operations?

> for the duration of the call to rust_binder_open. Binder uses from_ptr
> to get a &File from the raw pointer.
> 
> As far as I understand, the caller of rust_binder_open uses fdget to
> ensure that file_ptr is valid for the duration of the call, but the Rust
> code doesn't assume that it does this with fdget. As long as file_ptr is
> valid for the duration of the rust_binder_open call, this use of
> from_ptr is okay. It will continue to work even if the caller is changed
> to use fget.

Ok.

> 
> As for how this code ensures that `file` ends up annotated with a
> sufficiently short lifetime, well, that has to do with the signature of
> Process::open. Here it is:
> 
> 	impl Process {
> 	    pub(crate) fn open(ctx: ArcBorrow<'_, Context>, file: &File) -> Result<Arc<Process>> {
> 	        Self::new(ctx.into(), ARef::from(file.cred()))
> 	    }
> 	}
> 
> In this case, &File is used without specifying a lifetime. It's a
> function argument, so this means that the lifetime annotated on the
> `file` argument will be exactly the duration in which Process::open is
> called. So any attempt to use `file` after the end of the call to
> Process::open will be rejected by the borrow-checker. (E.g., if
> Process::open tried to schedule something on the workqueue using `file`,
> then that would not compile. Storing it in a global variable would not
> compile either.)
> 
> This means that the borrow-checker will not catch mistakes in
> rust_binder_open, but it *will* catch mistakes in Process::open, and
> anything called by Process::open.
> 
> These examples come from patch 2 of the Binder RFC:
> https://lore.kernel.org/rust-for-linux/20231101-rust-binder-v1-2-08ba9197f637@google.com/
> 
> >> +///
> >> +/// * You can think of `fdget` as using an fd to look up an `ARef<File>` in the `struct
> > 
> > Could you explain why there isn't an explicit fdget() then and you have
> > that from_ptr() method?
> 
> I don't provide an fdget implementation because Binder never calls it.
> However, if you would like, I would be happy to add one to the patchset.
> 
> As for from_ptr, see above.
> 
> Alice

