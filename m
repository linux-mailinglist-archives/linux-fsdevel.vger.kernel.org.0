Return-Path: <linux-fsdevel+bounces-668-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 619E87CE156
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 17:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90F601C20D5C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 15:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8DF3B295;
	Wed, 18 Oct 2023 15:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="dQxncbks"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61621A278
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Oct 2023 15:38:33 +0000 (UTC)
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF2B116
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Oct 2023 08:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1697643497; x=1697902697;
	bh=GOjMqcIJx0+JWTcTd2nMkWtyAAk/mt7zT7hGLtJQlvY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=dQxncbkssdE3aFTAeLTnvKb5BfySKBnLLYavaW+mhtkdo/h752RM4+Vns4Wob6VjB
	 3D2YONy/AJJw2ADeYnKRvV/6YRyR48+khcoYrTsgIvW/NYrZf8083aa4aZeFuAgCPU
	 iE+5TmJHT3f2XjQ/slWvEW9RBhCYEl2y/O1f3puYLOVt9UftSl0BNrsj2A7JSNN+vM
	 /qySPp5pX4hVFPBq1S1uDk1S1OIgRh4Rs7sMlwiwI0dMhAys//vnB3RdUJMkmsU9Ge
	 jxkPkVTyNgoPRUeMe9qtqRAM9fckPSrWOZpSRy/8C8y55u2FdqxVpGH8iTUF3znj+z
	 lDklaufxOJc0w==
Date: Wed, 18 Oct 2023 15:38:09 +0000
To: Wedson Almeida Filho <wedsonaf@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Matthew Wilcox <willy@infradead.org>, Kent Overstreet <kent.overstreet@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-fsdevel@vger.kernel.org, rust-for-linux@vger.kernel.org, Wedson Almeida Filho <walmeida@microsoft.com>
Subject: Re: [RFC PATCH 01/19] rust: fs: add registration/unregistration of file systems
Message-ID: <ku6rR-zBwLrTfSf1JW07NywKOZFCPMS7nF-mrdBKGJthn7WGBn9lcAQOhoN5V6igk1iGBguGfV5G0PDWQciDQTopf3OYYGt049OJYhsiivk=@proton.me>
In-Reply-To: <20231018122518.128049-2-wedsonaf@gmail.com>
References: <20231018122518.128049-1-wedsonaf@gmail.com> <20231018122518.128049-2-wedsonaf@gmail.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 18.10.23 14:25, Wedson Almeida Filho wrote:
> From: Wedson Almeida Filho <walmeida@microsoft.com>
>=20
> Allow basic registration and unregistration of Rust file system types.
> Unregistration happens automatically when a registration variable is
> dropped (e.g., when it goes out of scope).
>=20
> File systems registered this way are visible in `/proc/filesystems` but
> cannot be mounted yet because `init_fs_context` fails.
>=20
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> ---
>   rust/bindings/bindings_helper.h |  1 +
>   rust/kernel/error.rs            |  2 -
>   rust/kernel/fs.rs               | 80 +++++++++++++++++++++++++++++++++
>   rust/kernel/lib.rs              |  1 +
>   4 files changed, 82 insertions(+), 2 deletions(-)
>   create mode 100644 rust/kernel/fs.rs
>=20
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_hel=
per.h
> index 3b620ae07021..9c23037b33d0 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -8,6 +8,7 @@
>=20
>   #include <kunit/test.h>
>   #include <linux/errname.h>
> +#include <linux/fs.h>
>   #include <linux/slab.h>
>   #include <linux/refcount.h>
>   #include <linux/wait.h>
> diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
> index 05fcab6abfe6..e6d7ce46be55 100644
> --- a/rust/kernel/error.rs
> +++ b/rust/kernel/error.rs
> @@ -320,8 +320,6 @@ pub(crate) fn from_err_ptr<T>(ptr: *mut T) -> Result<=
*mut T> {
>   ///     })
>   /// }
>   /// ```
> -// TODO: Remove `dead_code` marker once an in-kernel client is available=
.
> -#[allow(dead_code)]
>   pub(crate) fn from_result<T, F>(f: F) -> T
>   where
>       T: From<i16>,
> diff --git a/rust/kernel/fs.rs b/rust/kernel/fs.rs
> new file mode 100644
> index 000000000000..f3fb09db41ba
> --- /dev/null
> +++ b/rust/kernel/fs.rs
> @@ -0,0 +1,80 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Kernel file systems.
> +//!
> +//! This module allows Rust code to register new kernel file systems.
> +//!
> +//! C headers: [`include/linux/fs.h`](../../include/linux/fs.h)
> +
> +use crate::error::{code::*, from_result, to_result, Error};
> +use crate::types::Opaque;
> +use crate::{bindings, init::PinInit, str::CStr, try_pin_init, ThisModule=
};
> +use core::{marker::PhantomPinned, pin::Pin};
> +use macros::{pin_data, pinned_drop};
> +
> +/// A file system type.
> +pub trait FileSystem {
> +    /// The name of the file system type.
> +    const NAME: &'static CStr;
> +}
> +
> +/// A registration of a file system.
> +#[pin_data(PinnedDrop)]
> +pub struct Registration {
> +    #[pin]
> +    fs: Opaque<bindings::file_system_type>,
> +    #[pin]
> +    _pin: PhantomPinned,

Note that since commit 0b4e3b6f6b79 ("rust: types: make `Opaque` be
`!Unpin`") you do not need an extra pinned `PhantomPinned` in your struct
(if you already have a pinned `Opaque`), since `Opaque` already is
`!Unpin`.

> +}
> +
> +// SAFETY: `Registration` doesn't provide any `&self` methods, so it is =
safe to pass references
> +// to it around.
> +unsafe impl Sync for Registration {}
> +
> +// SAFETY: Both registration and unregistration are implemented in C and=
 safe to be performed
> +// from any thread, so `Registration` is `Send`.
> +unsafe impl Send for Registration {}
> +
> +impl Registration {
> +    /// Creates the initialiser of a new file system registration.
> +    pub fn new<T: FileSystem + ?Sized>(module: &'static ThisModule) -> i=
mpl PinInit<Self, Error> {

I am a bit curious why you specify `?Sized` here, is it common
for types that implement `FileSystem` to not be `Sized`?

Or do you want to use `dyn FileSystem`?

> +        try_pin_init!(Self {
> +            _pin: PhantomPinned,
> +            fs <- Opaque::try_ffi_init(|fs_ptr: *mut bindings::file_syst=
em_type| {
> +                // SAFETY: `try_ffi_init` guarantees that `fs_ptr` is va=
lid for write.
> +                unsafe { fs_ptr.write(bindings::file_system_type::defaul=
t()) };
> +
> +                // SAFETY: `try_ffi_init` guarantees that `fs_ptr` is va=
lid for write, and it has
> +                // just been initialised above, so it's also valid for r=
ead.
> +                let fs =3D unsafe { &mut *fs_ptr };
> +                fs.owner =3D module.0;
> +                fs.name =3D T::NAME.as_char_ptr();
> +                fs.init_fs_context =3D Some(Self::init_fs_context_callba=
ck);
> +                fs.kill_sb =3D Some(Self::kill_sb_callback);
> +                fs.fs_flags =3D 0;
> +
> +                // SAFETY: Pointers stored in `fs` are static so will li=
ve for as long as the
> +                // registration is active (it is undone in `drop`).
> +                to_result(unsafe { bindings::register_filesystem(fs_ptr)=
 })
> +            }),
> +        })
> +    }
> +
> +    unsafe extern "C" fn init_fs_context_callback(
> +        _fc_ptr: *mut bindings::fs_context,
> +    ) -> core::ffi::c_int {
> +        from_result(|| Err(ENOTSUPP))
> +    }
> +
> +    unsafe extern "C" fn kill_sb_callback(_sb_ptr: *mut bindings::super_=
block) {}
> +}
> +
> +#[pinned_drop]
> +impl PinnedDrop for Registration {
> +    fn drop(self: Pin<&mut Self>) {
> +        // SAFETY: If an instance of `Self` has been successfully create=
d, a call to
> +        // `register_filesystem` has necessarily succeeded. So it's ok t=
o call
> +        // `unregister_filesystem` on the previously registered fs.

I would simply add an invariant on `Registration` that `self.fs` is
registered, then you do not need such a lengthy explanation here.

--=20
Cheers,
Benno

> +        unsafe { bindings::unregister_filesystem(self.fs.get()) };
> +    }
> +}
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index 187d58f906a5..00059b80c240 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -34,6 +34,7 @@
>   mod allocator;
>   mod build_assert;
>   pub mod error;
> +pub mod fs;
>   pub mod init;
>   pub mod ioctl;
>   #[cfg(CONFIG_KUNIT)]
> --
> 2.34.1
>=20
>

