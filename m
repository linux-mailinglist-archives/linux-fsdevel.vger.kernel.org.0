Return-Path: <linux-fsdevel+bounces-14913-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5DED881732
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Mar 2024 19:09:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BE01281825
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Mar 2024 18:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF866BFA7;
	Wed, 20 Mar 2024 18:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TkGY8Y9p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746376A8C5
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 Mar 2024 18:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710958151; cv=none; b=esunLfmpqUEfIMOJ4w+iAQK9Rrfga48d2+OJ+Hlmq1hSmU5mUHLoiYW9qFkcr20NTl8FFnWt2JFRVBb08JmsftdVnyoJ+ddXS15kM2LSSkDP7aIivNsbwIMneQRJbB/k/5ZT/EBuPSWgyDVrfiqzJuuYJwTDbWH51K68BcSWgaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710958151; c=relaxed/simple;
	bh=YJwn0EHmN4p0C1O8WY5aZR1nYAKu4era8MiJ7mxANe0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CfmEaqsLGlAf1K7fXW9oIbdbLYqLB1jK6x/DG99CAeOfK66CepOt67y2RfhpeM1nA0KQtxUihAKlY02Xee/PgWwRyNsjGW6wKnm4TecLp9F22u3YKP/zoSpFlk/Nd6iBI3I7cxJ+gujBphZVelwF4gEsnXNHIdXbeS7SfOafyzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TkGY8Y9p; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-607838c0800so12931757b3.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Mar 2024 11:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710958148; x=1711562948; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ysil0RDXkCVtzkTohmRbeyotl8h5MD3ps9kD7n3YY/k=;
        b=TkGY8Y9phbftfHMOkeiOTQO8zgdXhNP1xZDqUTkLUxrgqg0ovJHnfVWKTYA4vktd5f
         KtgJtlhx+iYAJADqp1QgeZeupiEFZHGtOFoJeD+5rBWYmxcdS3FlAJ3L7Ven44+evw3m
         wh3zdBDZ51IqDxZ3VQBnodJO1Kii94pQ4t1VNCuR2aW8UsWND1ShJ37uwsQXoiw8qgtk
         V17vvbWWMVQEk56fomjK/kVhCOa3K2JMEI3Q7KqtCNxbev0UfdoJa7xG/EzIOD1wvAOB
         /FZVIH7FxeIB2T7DLVwdPF+wmEiNWcA41E+4+8u7FSbPvJp2YtyCcT9KSEFMa7lpmvYz
         vYzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710958148; x=1711562948;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ysil0RDXkCVtzkTohmRbeyotl8h5MD3ps9kD7n3YY/k=;
        b=VpstVKh5xxFpU/yeKCxR/VUdbPp0M5CBfx4it/dcFg5Opo7lP4jYKYo/0l2j0Fibwv
         bI6f6bslydZoAmkakBiyU/nIfhJskEFXSAITZzwg0lPLW0/CBppl8enose43L2y/v+Px
         vvI8gxhppeVh0PZz0qyZsML72mw2iYDpB8/osSjFvsOIWEybnXIs8r4UnwiHrmSY/2T4
         0QNUe3eqWs7NkmJ6VVSSMJkR8WUqAuqKkt7qHcWBWpxfzAHqXEAcyH/tnZMU+PzlfVQg
         HZYiNf2RxnQC+DnClCDCyOOwa3bwllS2IlcYOfJSKWT9m/c6gqw4A5OAtUbxaVj5Xc/p
         eLUA==
X-Forwarded-Encrypted: i=1; AJvYcCUf+kuNtU07FT70hQLfvZflwOlOq6LDfoefVAg6+40QtOwI3dM++qOXc8hWdjgY2QlEE75hmORkjB8JN5knUraMFLKxrCWh8YZkcoryRQ==
X-Gm-Message-State: AOJu0YzzvXGM4fTI7trR/uaKPUUWytmSYRn9JIiP87hcIFeTzLVQPWih
	SpzLW/IvCqBDJ6RQim9cRUB3kf1leoimcWAYhY0Mvaj91Nggyy3x5FryH1NXN/K7nLE+2lnmQDB
	bVf4CyPyXPOrzIw==
X-Google-Smtp-Source: AGHT+IEIqn8S4bMIHC0aZaRRtDTwe38e01l0HkJ0Kk9R3YvZ5oW6uSg2Ip131RboSd66P7a916XUCWkVV/+A0wE=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a81:494f:0:b0:611:537:2c0f with SMTP id
 w76-20020a81494f000000b0061105372c0fmr9291ywa.2.1710958148515; Wed, 20 Mar
 2024 11:09:08 -0700 (PDT)
Date: Wed, 20 Mar 2024 18:09:05 +0000
In-Reply-To: <20240320-wegziehen-teilhaben-86e071fa163c@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240320-wegziehen-teilhaben-86e071fa163c@brauner>
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
Message-ID: <20240320180905.3858535-1-aliceryhl@google.com>
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
> On Fri, Feb 09, 2024 at 11:18:16AM +0000, Alice Ryhl wrote:
>> From: Wedson Almeida Filho <wedsonaf@gmail.com>
>> 
>> This abstraction makes it possible to manipulate the open files for a
>> process. The new `File` struct wraps the C `struct file`. When accessing
>> it using the smart pointer `ARef<File>`, the pointer will own a
>> reference count to the file. When accessing it as `&File`, then the
>> reference does not own a refcount, but the borrow checker will ensure
>> that the reference count does not hit zero while the `&File` is live.
>> 
>> Since this is intended to manipulate the open files of a process, we
>> introduce an `fget` constructor that corresponds to the C `fget`
>> method. In future patches, it will become possible to create a new fd in
>> a process and bind it to a `File`. Rust Binder will use these to send
>> fds from one process to another.
>> 
>> We also provide a method for accessing the file's flags. Rust Binder
>> will use this to access the flags of the Binder fd to check whether the
>> non-blocking flag is set, which affects what the Binder ioctl does.
>> 
>> This introduces a struct for the EBADF error type, rather than just
>> using the Error type directly. This has two advantages:
>> * `File::from_fd` returns a `Result<ARef<File>, BadFdError>`, which the
> 
> Sorry, where's that method?

Sorry, this is supposed to say `File::fget`.

>> +/// Wraps the kernel's `struct file`.
>> +///
>> +/// This represents an open file rather than a file on a filesystem. Processes generally reference
>> +/// open files using file descriptors. However, file descriptors are not the same as files. A file
>> +/// descriptor is just an integer that corresponds to a file, and a single file may be referenced
>> +/// by multiple file descriptors.
>> +///
>> +/// # Refcounting
>> +///
>> +/// Instances of this type are reference-counted. The reference count is incremented by the
>> +/// `fget`/`get_file` functions and decremented by `fput`. The Rust type `ARef<File>` represents a
>> +/// pointer that owns a reference count on the file.
>> +///
>> +/// Whenever a process opens a file descriptor (fd), it stores a pointer to the file in its `struct
>> +/// files_struct`. This pointer owns a reference count to the file, ensuring the file isn't
>> +/// prematurely deleted while the file descriptor is open. In Rust terminology, the pointers in
>> +/// `struct files_struct` are `ARef<File>` pointers.
>> +///
>> +/// ## Light refcounts
>> +///
>> +/// Whenever a process has an fd to a file, it may use something called a "light refcount" as a
>> +/// performance optimization. Light refcounts are acquired by calling `fdget` and released with
>> +/// `fdput`. The idea behind light refcounts is that if the fd is not closed between the calls to
>> +/// `fdget` and `fdput`, then the refcount cannot hit zero during that time, as the `struct
>> +/// files_struct` holds a reference until the fd is closed. This means that it's safe to access the
>> +/// file even if `fdget` does not increment the refcount.
>> +///
>> +/// The requirement that the fd is not closed during a light refcount applies globally across all
>> +/// threads - not just on the thread using the light refcount. For this reason, light refcounts are
>> +/// only used when the `struct files_struct` is not shared with other threads, since this ensures
>> +/// that other unrelated threads cannot suddenly start using the fd and close it. Therefore,
>> +/// calling `fdget` on a shared `struct files_struct` creates a normal refcount instead of a light
>> +/// refcount.
> 
> When the fdget() calling task doesn't have a shared file descriptor
> table fdget() will not increment the reference count, yes. This
> also implies that you cannot have task A use fdget() and then pass
> f.file to task B that holds on to it while A returns to userspace. It's
> irrelevant that task A won't drop the reference count or that task B
> won't drop the reference count. Because task A could return back to
> userspace and immediately close the fd via a regular close() system call
> at which point task B has a UAF. In other words a file that has been
> gotten via fdget() can't be Send to another task without the Send
> implying taking a reference to it.

That matches my understanding.

I suppose that technically you can still send it to another thread *if* you
ensure that the current thread waits until that other thread stops using the
file before returning to userspace.

>> +///
>> +/// Light reference counts must be released with `fdput` before the system call returns to
>> +/// userspace. This means that if you wait until the current system call returns to userspace, then
>> +/// all light refcounts that existed at the time have gone away.
>> +///
>> +/// ## Rust references
>> +///
>> +/// The reference type `&File` is similar to light refcounts:
>> +///
>> +/// * `&File` references don't own a reference count. They can only exist as long as the reference
>> +///   count stays positive, and can only be created when there is some mechanism in place to ensure
>> +///   this.
>> +///
>> +/// * The Rust borrow-checker normally ensures this by enforcing that the `ARef<File>` from which
>> +///   a `&File` is created outlives the `&File`.
> 
> The section confuses me a little: Does the borrow-checker always ensure
> that a &File stays valid or are there circumstances where it doesn't or
> are you saying it doesn't enforce it?

The borrow-checker always ensures it.

A &File is actually short-hand for &'a File, where 'a is some
unspecified lifetime. We say that &'a File is annotated with 'a. The
borrow-checker rejects any code that tries to use a reference after the
end of the lifetime annotated on it.

So as long as you annotate the reference with a sufficiently short
lifetime, the borrow checker will prevent UAF. And outside of cases like
from_ptr, the borrow-checker also takes care of ensuring that the
lifetimes are sufficiently short.

(Technically &'a File and &'b File are two completely different types,
so &File is technically a class of types and not a single type. Rust
will automatically convert &'long File to &'short File.)

>> +///
>> +/// * Using the unsafe [`File::from_ptr`] means that it is up to the caller to ensure that the
>> +///   `&File` only exists while the reference count is positive.
> 
> What is this used for in binder? If it's not used don't add it.

This is used on the boundary between the Rust part of Binder and the
binderfs component that is implemented in C. For example:

	unsafe extern "C" fn rust_binder_open(
	    inode: *mut bindings::inode,
	    file_ptr: *mut bindings::file,
	) -> core::ffi::c_int {
	    // SAFETY: The `rust_binderfs.c` file ensures that `i_private` is set to the return value of a
	    // successful call to `rust_binder_new_device`.
	    let ctx = unsafe { Arc::<Context>::borrow((*inode).i_private) };
	
	    // SAFETY: The caller provides a valid file pointer to a new `struct file`.
	    let file = unsafe { File::from_ptr(file_ptr) };
	    let process = match Process::open(ctx, file) {
	        Ok(process) => process,
	        Err(err) => return err.to_errno(),
	    };
	    // SAFETY: This file is associated with Rust binder, so we own the `private_data` field.
	    unsafe {
	        (*file_ptr).private_data = process.into_foreign().cast_mut();
	    }
	    0
	}

Here, rust_binder_open is the open function in a struct file_operations
vtable. In this case, file_ptr is guaranteed by the caller to be valid
for the duration of the call to rust_binder_open. Binder uses from_ptr
to get a &File from the raw pointer.

As far as I understand, the caller of rust_binder_open uses fdget to
ensure that file_ptr is valid for the duration of the call, but the Rust
code doesn't assume that it does this with fdget. As long as file_ptr is
valid for the duration of the rust_binder_open call, this use of
from_ptr is okay. It will continue to work even if the caller is changed
to use fget.

As for how this code ensures that `file` ends up annotated with a
sufficiently short lifetime, well, that has to do with the signature of
Process::open. Here it is:

	impl Process {
	    pub(crate) fn open(ctx: ArcBorrow<'_, Context>, file: &File) -> Result<Arc<Process>> {
	        Self::new(ctx.into(), ARef::from(file.cred()))
	    }
	}

In this case, &File is used without specifying a lifetime. It's a
function argument, so this means that the lifetime annotated on the
`file` argument will be exactly the duration in which Process::open is
called. So any attempt to use `file` after the end of the call to
Process::open will be rejected by the borrow-checker. (E.g., if
Process::open tried to schedule something on the workqueue using `file`,
then that would not compile. Storing it in a global variable would not
compile either.)

This means that the borrow-checker will not catch mistakes in
rust_binder_open, but it *will* catch mistakes in Process::open, and
anything called by Process::open.

These examples come from patch 2 of the Binder RFC:
https://lore.kernel.org/rust-for-linux/20231101-rust-binder-v1-2-08ba9197f637@google.com/

>> +///
>> +/// * You can think of `fdget` as using an fd to look up an `ARef<File>` in the `struct
> 
> Could you explain why there isn't an explicit fdget() then and you have
> that from_ptr() method?

I don't provide an fdget implementation because Binder never calls it.
However, if you would like, I would be happy to add one to the patchset.

As for from_ptr, see above.

Alice

