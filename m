Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19D877642BB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jul 2023 01:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbjGZXwc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 19:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjGZXwa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 19:52:30 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D7C8BF
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 16:52:27 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-98dfb3f9af6so36094266b.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 16:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1690415546; x=1691020346;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VE4t0MHRbptM3cte7NJENQQexqmO7oHZypjHMYHhyBI=;
        b=QMr9VteXNHwjahVZzvhMAMpHVUsgCaz9yA/EhbGwyBj2sGcUm1TgDQDVt5NFXVqfP9
         Yxlo+MGrp2JHj+rZbMNsAy929ZzP2XQOLD4gGyWuw5XsVpk7zWBJoB6Gl8tFQd80RP4v
         x22zpVtOBr1asbCgxTMHDL4jIs9eF9kic1MLr6rEPbMo9KkeP2dhjOxuNC263hPYMETx
         /LKd449YJd348Yh24zO176QORBKTCrh0SrcbVhWQw3nOftOI5t5y4cS6HiPMWyqPzzRf
         v1JJhrcaWP02Y24wZMCfdObj4KRSJWOQKpxRx2UuDaMAZQEIf4q9DLtjbULzpLAcOfyL
         5xVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690415546; x=1691020346;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VE4t0MHRbptM3cte7NJENQQexqmO7oHZypjHMYHhyBI=;
        b=LKJFbPR8w7Uhj4aSXkT5/B/HyFFdeGd/ZbTj2QoKwXBROCWqJLApE8KnKDn6CAK4HY
         1cVPOO7yVkcZ4eWv2O0u6Jy3tGsbYaQi799da9x4/rXH9qCtwXkFOmTzVIGSt+mKqYs7
         Fq3eT9YrU+P7IFd95suGW09htzAjsqXOKJ5gzky5xaLuliprs9uH7G5So4sG0rJ6x7iR
         4gyxHGM7YU6XkGsbdoglaN6passDyjdGP7w1DVUnPFXTRmijAsuojAR/ZogFXq9/8XQJ
         MpSJpaausCTHHceevZXeQ/2V95Z3c2tfBSTqqyxsuI7VPN6FukoJZ8DyxgCysqAOEkra
         baHA==
X-Gm-Message-State: ABy/qLYKQ7+q2NCk+klRnjwxlJia17ceYxucqMyijBGPv3xVge/uiMD7
        k2mdEkSkMyAfVmoTWnrMjKJabkhKPDI4S9fK2N3U4g==
X-Google-Smtp-Source: APBJJlHCx1zJGrmVcbJXdhFOfadSP+F29WX5PX5AYMaOBopXRUF1yVoD2WjOwrCXIR6LkEwGpYbupHn1CTHHcAgrNQ8=
X-Received: by 2002:a17:906:74d8:b0:99b:cb78:8537 with SMTP id
 z24-20020a17090674d800b0099bcb788537mr464601ejl.11.1690415545887; Wed, 26 Jul
 2023 16:52:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230726164535.230515-1-amiculas@cisco.com> <20230726164535.230515-5-amiculas@cisco.com>
In-Reply-To: <20230726164535.230515-5-amiculas@cisco.com>
From:   Trevor Gross <tmgross@umich.edu>
Date:   Wed, 26 Jul 2023 19:52:13 -0400
Message-ID: <CALNs47svt4481_3Te9FzskAJ29ur6h115NdLfej3Ejfcd5tO7w@mail.gmail.com>
Subject: Re: [RFC PATCH v2 04/10] rust: file: Add a new RegularFile newtype
 useful for reading files
To:     Ariel Miculas <amiculas@cisco.com>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tycho@tycho.pizza,
        brauner@kernel.org, viro@zeniv.linux.org.uk, ojeda@kernel.org,
        alex.gaynor@gmail.com, wedsonaf@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 26, 2023 at 12:54=E2=80=AFPM Ariel Miculas <amiculas@cisco.com>=
 wrote:
>
> Implement from_path, from_path_in_root_mnt, read_with_offset,
> read_to_end and get_file_size methods for a RegularFile newtype.
>
> Signed-off-by: Ariel Miculas <amiculas@cisco.com>
> ---
>  rust/helpers.c       |   6 ++
>  rust/kernel/error.rs |   4 +-
>  rust/kernel/file.rs  | 129 ++++++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 135 insertions(+), 4 deletions(-)
>
> diff --git a/rust/helpers.c b/rust/helpers.c
> index eed8ace52fb5..9e860a554cda 100644
> --- a/rust/helpers.c
> +++ b/rust/helpers.c
> @@ -213,6 +213,12 @@ void *rust_helper_alloc_inode_sb(struct super_block =
*sb,
>  }
>  EXPORT_SYMBOL_GPL(rust_helper_alloc_inode_sb);
>
> +loff_t rust_helper_i_size_read(const struct inode *inode)
> +{
> +       return i_size_read(inode);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_i_size_read);
> +
>  /*
>   * We use `bindgen`'s `--size_t-is-usize` option to bind the C `size_t` =
type
>   * as the Rust `usize` type, so we can use it in contexts where Rust
> diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
> index 05fcab6abfe6..e061c83f806a 100644
> --- a/rust/kernel/error.rs
> +++ b/rust/kernel/error.rs
> @@ -273,9 +273,7 @@ pub fn to_result(err: core::ffi::c_int) -> Result {
>  ///     }
>  /// }
>  /// ```
> -// TODO: Remove `dead_code` marker once an in-kernel client is available=
.
> -#[allow(dead_code)]
> -pub(crate) fn from_err_ptr<T>(ptr: *mut T) -> Result<*mut T> {
> +pub fn from_err_ptr<T>(ptr: *mut T) -> Result<*mut T> {
>      // CAST: Casting a pointer to `*const core::ffi::c_void` is always v=
alid.
>      let const_ptr: *const core::ffi::c_void =3D ptr.cast();
>      // SAFETY: The FFI function does not deref the pointer.
> diff --git a/rust/kernel/file.rs b/rust/kernel/file.rs
> index 494939ba74df..a3002c416dbb 100644
> --- a/rust/kernel/file.rs
> +++ b/rust/kernel/file.rs
> @@ -8,11 +8,13 @@
>  use crate::{
>      bindings,
>      cred::Credential,
> -    error::{code::*, from_result, Error, Result},
> +    error::{code::*, from_err_ptr, from_result, Error, Result},
>      fs,
>      io_buffer::{IoBufferReader, IoBufferWriter},
>      iov_iter::IovIter,
>      mm,
> +    mount::Vfsmount,
> +    str::CStr,
>      sync::CondVar,
>      types::ARef,
>      types::AlwaysRefCounted,
> @@ -20,6 +22,7 @@
>      types::Opaque,
>      user_ptr::{UserSlicePtr, UserSlicePtrReader, UserSlicePtrWriter},
>  };
> +use alloc::vec::Vec;
>  use core::convert::{TryFrom, TryInto};
>  use core::{marker, mem, ptr};
>  use macros::vtable;
> @@ -201,6 +204,130 @@ unsafe fn dec_ref(obj: ptr::NonNull<Self>) {
>      }
>  }
>
> +/// A newtype over file, specific to regular files
> +pub struct RegularFile(ARef<File>);
> +impl RegularFile {
> +    /// Creates a new instance of Self if the file is a regular file
> +    ///
> +    /// # Safety
> +    ///
> +    /// The caller must ensure file_ptr.f_inode is initialized to a vali=
d pointer (e.g. file_ptr is
> +    /// a pointer returned by path_openat); It must also ensure that fil=
e_ptr's reference count was
> +    /// incremented at least once
> +    fn create_if_regular(file_ptr: ptr::NonNull<bindings::file>) -> Resu=
lt<RegularFile> {

This function should be unsafe, correct? You instead take a
`&bindings::file` instead of `NonNull` but still keep it unsafe, so
the "valid pointer" invariant is always reached.

Or, could this take `&kernel::file::File` instead to reduce some duplicatio=
n?

> +        // SAFETY: file_ptr is a NonNull pointer
> +        let inode =3D unsafe { core::ptr::addr_of!((*file_ptr.as_ptr()).=
f_inode).read() };
> +        // SAFETY: the caller must ensure f_inode is initialized to a va=
lid pointer
> +        unsafe {
> +            if bindings::S_IFMT & ((*inode).i_mode) as u32 !=3D bindings=
::S_IFREG {
> +                return Err(EINVAL);
> +            }
> +        }

Nit: factor `unsafe { ((*inode).i_mode) }` out so it doesn't look like
the whole statement is unsafe

> +        // SAFETY: the safety requirements state that file_ptr's referen=
ce count was incremented at
> +        // least once
> +        Ok(RegularFile(unsafe { ARef::from_raw(file_ptr.cast()) }))
> +    }
> +    /// Constructs a new [`struct file`] wrapper from a path.
> +    pub fn from_path(filename: &CStr, flags: i32, mode: u16) -> Result<S=
elf> {
> +        let file_ptr =3D unsafe {
> +            // SAFETY: filename is a reference, so it's a valid pointer
> +            from_err_ptr(bindings::filp_open(
> +                filename.as_ptr() as *const i8,
> +                flags,
> +                mode,
> +            ))?
> +        };

I mentioned in another email that `.cast::<i8>()` can be more
idiomatic and a bit safer than `as`, it's a stylistic choice but there
are a few places it could be changed here if desired

Also, the `// SAFETY` comments need to go outside the unsafe block

> +        let file_ptr =3D ptr::NonNull::new(file_ptr).ok_or(ENOENT)?;
> +
> +        // SAFETY: `filp_open` initializes the refcount with 1
> +        Self::create_if_regular(file_ptr)
> +    }

Will need unsafe block if `create_if_regular` becomes unsafe

> +
> +    /// Constructs a new [`struct file`] wrapper from a path and a vfsmo=
unt.
> +    pub fn from_path_in_root_mnt(
> +        mount: &Vfsmount,
> +        filename: &CStr,
> +        flags: i32,
> +        mode: u16,
> +    ) -> Result<Self> {
> +        let file_ptr =3D {
> +            let mnt =3D mount.get();
> +            // construct a path from vfsmount, see file_open_root_mnt
> +            let raw_path =3D bindings::path {
> +                mnt,
> +                // SAFETY: Vfsmount structure stores a valid vfsmount ob=
ject
> +                dentry: unsafe { (*mnt).mnt_root },
> +            };
> +            unsafe {
> +                // SAFETY: raw_path and filename are both references
> +                from_err_ptr(bindings::file_open_root(
> +                    &raw_path,
> +                    filename.as_ptr() as *const i8,
> +                    flags,
> +                    mode,
> +                ))?
> +            }
> +        };

Is there a reason to use the larger scope block, rather than moving
`mnt` and `raw_path` out and doing `let file_ptr =3D unsafe { ... }`? If
so, a comment would be good.

> +        let file_ptr =3D ptr::NonNull::new(file_ptr).ok_or(ENOENT)?;
> +
> +        // SAFETY: `file_open_root` initializes the refcount with 1
> +        Self::create_if_regular(file_ptr)
> +    }
> +
> +    /// Read from the file into the specified buffer
> +    pub fn read_with_offset(&self, buf: &mut [u8], offset: u64) -> Resul=
t<usize> {
> +        Ok({
> +            // kernel_read_file expects a pointer to a "void *" buffer
> +            let mut ptr_to_buf =3D buf.as_mut_ptr() as *mut core::ffi::c=
_void;
> +            // Unless we give a non-null pointer to the file size:
> +            // 1. we cannot give a non-zero value for the offset
> +            // 2. we cannot have offset 0 and buffer_size > file_size
> +            let mut file_size =3D 0;
> +
> +            // SAFETY: 'file' is valid because it's taken from Self, 'bu=
f' and 'file_size` are
> +            // references to the stack variables 'ptr_to_buf' and 'file_=
size'; ptr_to_buf is also
> +            // a pointer to a valid buffer that was obtained from a refe=
rence
> +            let result =3D unsafe {
> +                bindings::kernel_read_file(
> +                    self.0 .0.get(),

Is this spacing intentional? If so, `(self.0).0.get()` may be cleaner

> +                    offset.try_into()?,
> +                    &mut ptr_to_buf,
> +                    buf.len(),
> +                    &mut file_size,
> +                    bindings::kernel_read_file_id_READING_UNKNOWN,
> +                )
> +            };
> +
> +            // kernel_read_file returns the number of bytes read on succ=
ess or negative on error.
> +            if result < 0 {
> +                return Err(Error::from_errno(result.try_into()?));
> +            }
> +
> +            result.try_into()?
> +        })
> +    }

I think you could remove the block here and just return `Ok(result.try_into=
()?)`

> +
> +    /// Allocate and return a vector containing the contents of the enti=
re file
> +    pub fn read_to_end(&self) -> Result<Vec<u8>> {
> +        let file_size =3D self.get_file_size()?;
> +        let mut buffer =3D Vec::try_with_capacity(file_size)?;
> +        buffer.try_resize(file_size, 0)?;
> +        self.read_with_offset(&mut buffer, 0)?;
> +        Ok(buffer)
> +    }
> +
> +    fn get_file_size(&self) -> Result<usize> {
> +        // SAFETY: 'file' is valid because it's taken from Self
> +        let file_size =3D unsafe { bindings::i_size_read((*self.0 .0.get=
()).f_inode) };
> +
> +        if file_size < 0 {
> +            return Err(EINVAL);
> +        }
> +
> +        Ok(file_size.try_into()?)
> +    }
> +}
> +
>  /// A file descriptor reservation.
>  ///
>  /// This allows the creation of a file descriptor in two steps: first, w=
e reserve a slot for it,
> --
> 2.41.0
>
>
