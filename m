Return-Path: <linux-fsdevel+bounces-4359-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F35EF7FEF3C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 13:39:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5849FB20AD7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 12:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B913BB5B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 12:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PI3jJuxm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FEDC20DCF;
	Thu, 30 Nov 2023 10:48:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC100C433CA;
	Thu, 30 Nov 2023 10:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701341319;
	bh=bufpou9GNUdKv5vFbZyVV6ZfqMjQGT4obnVzWciYDyM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PI3jJuxmpPnUxQf0rMrzIX+jFl13ryzAS/cf15S8rC0wDURJJHd1IxMcGIQlxeWx0
	 D13SByMb8adx9bCLSZSEZ1A+v3dq30OPfuV26idIWCb3EIof1TG5JsAVdBajmLRWUC
	 O0lDHY55SxHtTHeztrkkK6yVLo1H3vtSPLKFLTrETPa8T5JSSeTUIuCZHoNGfkf1bX
	 2keNpzzTLMud5Yq4pjtZ20WCT+H4JRClL7sUp25tMHVb+guYuQIvnZANECh+HJjGJT
	 EJc4IWs70g3vAOBONbnBs4bplylOlgKcLzdfC69iYy5w2TVn7rE+kkDdRZ0VGte+zG
	 DffwForAr66gQ==
Date: Thu, 30 Nov 2023 11:48:31 +0100
From: Christian Brauner <brauner@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: a.hindborg@samsung.com, alex.gaynor@gmail.com, arve@android.com,
	benno.lossin@proton.me, bjorn3_gh@protonmail.com,
	boqun.feng@gmail.com, cmllamas@google.com, dan.j.williams@intel.com,
	dxu@dxuuu.xyz, gary@garyguo.net, gregkh@linuxfoundation.org,
	joel@joelfernandes.org, keescook@chromium.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	maco@android.com, ojeda@kernel.org, peterz@infradead.org,
	rust-for-linux@vger.kernel.org, surenb@google.com,
	tglx@linutronix.de, tkjos@android.com, viro@zeniv.linux.org.uk,
	wedsonaf@gmail.com, willy@infradead.org
Subject: Re: [PATCH 1/7] rust: file: add Rust abstraction for `struct file`
Message-ID: <20231130-sackgasse-abdichtung-62c23edd9a9f@brauner>
References: <20231129-geleckt-verebben-04ea0c08a53c@brauner>
 <20231129212707.3520214-1-aliceryhl@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231129212707.3520214-1-aliceryhl@google.com>

On Wed, Nov 29, 2023 at 09:27:07PM +0000, Alice Ryhl wrote:
> Christian Brauner <brauner@kernel.org> writes:
> >> This abstraction makes it possible to manipulate the open files for a
> >> process. The new `File` struct wraps the C `struct file`. When accessing
> >> it using the smart pointer `ARef<File>`, the pointer will own a
> >> reference count to the file. When accessing it as `&File`, then the
> >> reference does not own a refcount, but the borrow checker will ensure
> >> that the reference count does not hit zero while the `&File` is live.
> > 
> > Could you explain this in more details please? Ideally with some C and
> > how that translates to your Rust wrappers, please. Sorry, this is going
> > to be a long journey...
> 
> Yes of course. This touches on what I think is one of the most important

Thanks for all the background.

> features that Rust brings to the table, which is the idea of defining
> many different pointer types for different ownership semantics.
> 
> In the case of `struct file`, there are two pointer types that are
> relevant:
> 
>  * `&File`. This is an "immutable reference" or "shared reference"
>    (both names are used). This pointer type is used when you don't have
>    any ownership over the target at all. All you have is _some_ sort of
>    guarantee that target stays alive while the reference is live. In
>    many cases, the borrow checker helps validate this at compile-time,
>    but you can also use a backdoor (in this case from_ptr) to just
>    unsafely say "I know this value is valid, so shut up compiler".
>    Shared references have no destructor.
> 
>  * `ARef<File>`. The `ARef` type is a custom pointer type defined in the
>    kernel in `rust/kernel/types.rs`. It represents a pointer that owns a
>    ref-count to the inner value. ARef can only be used with types that
>    have an `unsafe impl AlwaysRefCounted for T` block. Whenever you
>    clone an `ARef`, it calls into the `inc_ref` method that you defined
>    for the type, and whenever it goes out of scope and the destructor
>    runs, it calls the `dec_ref` method that you defined for the type.
> 
> Potentially we might want a third in the future. The third pointer type
> could be another custom pointer type just for `struct file` that uses
> `fdget` instead of `fget`. However, I haven't added this since I don't
> need it (dead code and so on).
> 
> To give an example of this, consider this really simple C function:
> 
> 	bool is_nonblocking(struct file *file) {
> 		return !!(filp->f_flags & O_NONBLOCK);
> 	}
> 
> What are the ownership semantics of `file`? Well, we don't really care.
> The caller needs to somehow ensure that the `file` is valid, but we
> don't care if they're doing that with `fdget` or `fget` or whatever.
> This corresponds to &File, so the Rust equivalent would be:
> 
> 	fn is_nonblocking(file: &File) -> bool {
> 		(file.flags() & O_NONBLOCK) != 0
> 	}
> 
> Another example:
> 
> 	void set_nonblocking_and_fput(struct file *file) {
> 		// Let's just ignore the lock for this example.
> 		file->f_flags |= O_NONBLOCK;
> 
> 		fput(file);
> 	}
> 
> This method takes a file, sets it to non-blocking, and then destroys the
> ref-count. What are the ownership semantics? Well, the caller should own
> an `fget` ref-count, and we consume that ref-count. The equivalent Rust
> code would be to take an `ARef<File>`:
> 
> 	fn set_nonblocking_and_fput(file: ARef<File>) {
> 		file.set_flag(O_NONBLOCK);
> 
> 		// When `file` goes out of scope here, the destructor
> 		// runs and calls `fput`. (Since that's what we defined
> 		// `ARef` to do on drop in `fn dec_ref`.)
> 	}
> 
> You can also explicitly call the destructor with `drop(file)`:
> 
> 	fn set_nonblocking_and_fput(file: ARef<File>) {
> 		file.set_flag(O_NONBLOCK);
> 		drop(file);
> 
> 		// When `file` goes out of scope, the destructor does
> 		// *not* run. This is because `drop(file)` is a move
> 		// (due to the signature of drop), and if you perform a
> 		// move, then the destructor no longer runs at the end
> 		// of the scope.
> 	}
> 
> And note that this would not compile, because we give up ownership of
> the `ARef` by passing it to `drop`:
> 
> 	fn set_nonblocking_and_fput(file: ARef<File>) {
> 		drop(file);
> 		file.set_flag(O_NONBLOCK);
> 	}
> 
> A third example:
> 
> 	struct holds_a_file {
> 		struct file *inner;
> 	};
> 
> 	struct file *get_the_file(struct holds_a_file *holder) {
> 		return holder->inner;
> 	}
> 
> What are the ownership semantics? Well, let's say that `holds_a_file`
> owns a refcount to the file. Then, the pointer returned by get_the_file
> is valid as long as `holder` is, but it doesn't have any ownership
> over the file. You must stop using the returned file pointer before the
> holder is destroyed.
> 
> The Rust equivalent is:
> 
> 	struct HoldsAFile {
> 		inner: ARef<File>,
> 	}
> 
> 	fn get_the_file(holder: &HoldsAFile) -> &File {
> 		&holder.inner
> 	}
> 
> The method signature is short-hand for (see [1]):
> 
> 	fn get_the_file<'a>(holder: &'a HoldsAFile) -> &'a File {

Whenever you implement something like this - at least for fs/vfs
wrappers - I would ask you to please annotate the lifetimes with
comments. I've done a decent amount of (userspace) Rust
https://github.com/brauner/rlxc but the syntax isn't second nature to me
and I expect there to be quite a few other developers/maintainers that
aren't familiar.

> 		&holder.inner
> 	}
> 
> Here, 'a is a lifetime, and it ties together `holder` and the returned

The lieftime of the file is bound to the lifetime of the holder, ok.

> reference in the way I described above. So e.g., this compiles:
> 
> 	let holder = ...;
> 	let file = get_the_file(&holder);
> 	use_the_file(file);
> 
> But this doesn't:
> 
> 	let holder = ...;
> 	let file = get_the_file(&holder);
> 	drop(holder);
> 	use_the_file(file); // Oops, destroying holder calls fput.
> 
> Notice also how the compiler accepted `&holder.inner` as the type
> `&File` even though `inner` has type `ARef<File>`. This is because
> `ARef` is defined to use something called deref coercion, which makes it
> act like a real pointer type. This means that if you have an
> `ARef<File>`, but you want to call a method that accepts `&File`, then
> it will just work. (Deref coercion only exists for conversions into
> reference types, so you can't pass a `&File` to something that takes an
> `ARef<File>` without explicitly upgrading it to an `ARef<File>` by
> taking a ref-count.)
> 
> [1]: https://doc.rust-lang.org/reference/lifetime-elision.html
> 
> >> +    /// Constructs a new `struct file` wrapper from a file descriptor.
> >> +    ///
> >> +    /// The file descriptor belongs to the current process.
> >> +    pub fn from_fd(fd: u32) -> Result<ARef<Self>, BadFdError> {
> >> +        // SAFETY: FFI call, there are no requirements on `fd`.
> >> +        let ptr = ptr::NonNull::new(unsafe { bindings::fget(fd) }).ok_or(BadFdError)?;
> >> +
> >> +        // INVARIANT: `fget` increments the refcount before returning.
> >> +        Ok(unsafe { ARef::from_raw(ptr.cast()) })
> >> +    }
> > 
> > I think this is really misnamed.
> > 
> > File reference counting has two modes. For simplicity let's ignore
> > fdget_pos() for now:
> > 
> > (1) fdget()
> >     Return file either with or without an increased reference count.
> >     If the fdtable was shared increment reference count, if not don't
> >     increment refernce count.
> > (2) fget()
> >     Always increase refcount.
> > 
> > Your File implementation currently only deals with (2). And this
> > terminology is terribly important as far as I'm concerned. This wants to
> > be fget() and not from_fd(). The latter tells me nothing. I feel we
> > really need to try and mirror the current naming closely. Not
> > religiously ofc but core stuff such as this really benefits from having
> > an almost 1:1 mapping between C names and Rust names, I think.
> > Especially in the beginning.
> 
> Sure, I'll rename these methods in the next version.
> 
> >> +    /// Creates a reference to a [`File`] from a valid pointer.
> >> +    ///
> >> +    /// # Safety
> >> +    ///
> >> +    /// The caller must ensure that `ptr` points at a valid file and that its refcount does not
> >> +    /// reach zero during the lifetime 'a.
> >> +    pub unsafe fn from_ptr<'a>(ptr: *const bindings::file) -> &'a File {
> >> +        // INVARIANT: The safety requirements guarantee that the refcount does not hit zero during
> >> +        // 'a. The cast is okay because `File` is `repr(transparent)`.
> >> +        unsafe { &*ptr.cast() }
> >> +    }
> > 
> > How does that work and what is this used for? It's required that a
> > caller has called from_fd()/fget() first before from_ptr() can be used?
> > 
> > Can you show how this would be used in an example, please? Unless you
> > hold file_lock it is now invalid to access fields in struct file just
> > with rcu lock held for example. Which is why returning a pointer without
> > holding a reference seems dodgy. I'm probably just missing context.
> 
> This is the backdoor. You use it when *you* know that the file is okay

And a huge one.

> to access, but Rust doesn't. It's unsafe because it's not checked by
> Rust.
> 
> For example you could do this:
> 
> 	let ptr = unsafe { bindings::fdget(fd) };
> 
> 	// SAFETY: We just called `fdget`.
> 	let file = unsafe { File::from_ptr(ptr) };
> 	use_file(file);
> 
> 	// SAFETY: We're not using `file` after this call.
> 	unsafe { bindings::fdput(ptr) };
> 
> It's used in Binder here:
> https://github.com/Darksonn/linux/blob/dca45e6c7848e024709b165a306cdbe88e5b086a/drivers/android/rust_binder.rs#L331-L332
> 
> Basically, I use it to say "C code has called fdget for us so it's okay
> to access the file", whenever userspace uses a syscall to call into the
> driver.

Yeah, ok, because the fd you're operating on may be coming from fdget(). Iirc,
binder is almost by default used multi-threaded with a shared file descriptor
table? But while that means fdget() will usually bump the reference count you
can't be sure. Hmkay.

> 
> >> +// SAFETY: The type invariants guarantee that `File` is always ref-counted.
> >> +unsafe impl AlwaysRefCounted for File {
> >> +    fn inc_ref(&self) {
> >> +        // SAFETY: The existence of a shared reference means that the refcount is nonzero.
> >> +        unsafe { bindings::get_file(self.0.get()) };
> >> +    }
> > 
> > Why inc_ref() and not just get_file()?
> 
> Whenever you see an impl block that uses the keyword "for", then the
> code is implementing a trait. In this case, the trait being implemented
> is AlwaysRefCounted, which allows File to work with ARef.

Ah, right. Thanks.

> 
> It has to be `inc_ref` because that's what AlwaysRefCounted calls this
> method.
> 
> >> +    unsafe fn dec_ref(obj: ptr::NonNull<Self>) {
> >> +        // SAFETY: The safety requirements guarantee that the refcount is nonzero.
> >> +        unsafe { bindings::fput(obj.cast().as_ptr()) }
> >> +    }
> > 
> > Ok, so this makes me think that from_ptr() requires you to have called
> > from_fd()/fget() first which would be good.
> 
> Actually, `from_ptr` has nothing to do with this. The above code only
> applies to code that uses the `ARef` pointer type, but `from_ptr` uses
> the `&File` pointer type instead.
> 
> >> +    /// Returns the flags associated with the file.
> >> +    ///
> >> +    /// The flags are a combination of the constants in [`flags`].
> >> +    pub fn flags(&self) -> u32 {
> >> +        // This `read_volatile` is intended to correspond to a READ_ONCE call.
> >> +        //
> >> +        // SAFETY: The file is valid because the shared reference guarantees a nonzero refcount.
> > 
> > I really need to understand what you mean by shared reference. At least
> > in the current C implementation you can't share a reference without
> > another task as the other task might fput() behind you and then you're
> > hosed. That's why we have the fdget() logic.
> 
> By "shared reference" I just mean an `&File`. They're called shared
> because there could be other pointers to the same object elsewhere in
> the program, and not because we have explicitly shared it ourselves.

Ok, that was confusing to me because I wasn't sure whether you were talking
about sharing an ->f_count reference.

> 
> Rust's other type of reference `&mut T` is called a "mutable reference"
> or "exclusive reference". Like with `&T`, both names are used.
> 
> > > +// SAFETY: It's OK to access `File` through shared references from other threads because we're
> > > +// either accessing properties that don't change or that are properly synchronised by C code.
> > 
> > Uhm, what guarantees are you talking about specifically, please?
> > Examples would help.
> > 
> > > +unsafe impl Sync for File {}
> 
> The Sync trait defines whether a value may be accessed from several
> threads in parallel (using shared/immutable references). In our case,

So let me put this into my own words and you correct me, please:

So, this really just means that if I have two processes both with their own
fdtable and they happen to hold fds that refer to the same @file:

P1				P2
struct fd fd1 = fdget(1234);
                                 struct fd fd2 = fdget(5678);
if (!fd1.file)                   if (!fd2.file)
	return -EBADF;                 return -EBADF;

// fd1.file == fd2.file

the only if the Sync trait is implemented both P1 and P2 can in parallel call
file->f_op->poll(@file)?

So if the Sync trait isn't implemented then the compiler will prohibit that P1
and P2 at the same time call file->f_op->poll(@file)? And that's all that's
meant by a shared reference? It's really about sharing the pointer.

The thing is that "shared reference" gets a bit in our way here:

(1) If you have SCM_RIGHTs in the mix then P1 can open fd1 to @file and then
    send that @file to P2 which now has fd2 refering to @file as well. The
    @file->f_count is bumped in that process. So @file->f_count is now 2.

    Now both P1 and P2 call fdget(). Since they don't have a shared fdtable
    none of them take an additional reference to @file. IOW, @file->f_count
    may remain 2 all throughout the @file->f_op->*() operation.

    So they share a reference to that file and elide both the
    atomic_inc_not_zero() and the atomic_dec_not_zero().

(2) io_uring has fixed files whose reference count always stays at 1.
    So all io_uring operations on such fixed files share a single reference.

So that's why this is a bit confusing at first to read "shared reference".

Please add a comment on top of unsafe impl Sync for File {}
explaining/clarifying this a little that it's about calling methods on the same
file.

> every method on `File` that accepts a `&File` is okay to be called in
> parallel from several threads, so it's okay for `File` to implement
> `Sync`.
> 
> I'm actually making a statement about the rest of the Rust code in this
> file here. If I added a method that took `&File`, but couldn't be called
> in parallel, then `File` could no longer be `Sync`.

