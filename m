Return-Path: <linux-fsdevel+bounces-672-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 576B07CE2D2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 18:34:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6E94281C68
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 16:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA5E3D38D;
	Wed, 18 Oct 2023 16:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="TNJ/KLfx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DB43D39C
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Oct 2023 16:34:32 +0000 (UTC)
X-Greylist: delayed 3369 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 18 Oct 2023 09:34:29 PDT
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B02113
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Oct 2023 09:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1697646867; x=1697906067;
	bh=MxJLpw5Fcv3zbX8KGtwh44Quyk24CrqocmHxtY8Q1dA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=TNJ/KLfxwTBnFGuqTr4Qcu0xfRI7ot8iuQbBU047V5isq8ghea+HdIlMFPVK61Pog
	 cgS5eMZSKV+eNsy9agx/AUDME5eCRM7S4xS7/xUtIxgQZ3TFok9oTVf5dkMAw+CGDX
	 nzFnct6vizAT5PX+uIgsKLa45CVuHlKK/Rf21dL0ZUxf8jxJEvh/+wTknXyC/qFmcU
	 4KYUoB2fSECeAPlfJPRmgUb+tX9UB1cXBMbBPbWiAX38Dk0j4JdfTNDnLDYiR4Lli9
	 9tsdT5mxoN3emfWK//tJ0/zqk0oO3w4xc01BdGpyykgiIKQrkeGZd/92MI6PA3H+9O
	 8DX56DD1so/OQ==
Date: Wed, 18 Oct 2023 16:34:18 +0000
To: Wedson Almeida Filho <wedsonaf@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Matthew Wilcox <willy@infradead.org>, Kent Overstreet <kent.overstreet@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-fsdevel@vger.kernel.org, rust-for-linux@vger.kernel.org, Wedson Almeida Filho <walmeida@microsoft.com>
Subject: Re: [RFC PATCH 04/19] rust: fs: introduce `FileSystem::super_params`
Message-ID: <E5dn4WQzlLvA0snHR_r_i2h1IPRjiiTIwssBSR403Rda6JA2Fgd-7lOonQQ6Oz1DMqp45cvtDfyW0JwRFgSZurzvtXIk3KGNhtSBqvvBnF0=@proton.me>
In-Reply-To: <20231018122518.128049-5-wedsonaf@gmail.com>
References: <20231018122518.128049-1-wedsonaf@gmail.com> <20231018122518.128049-5-wedsonaf@gmail.com>
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
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 18.10.23 14:25, Wedson Almeida Filho wrote:
> From: Wedson Almeida Filho <walmeida@microsoft.com>
>=20
> Allow Rust file systems to initialise superblocks, which allows them
> to be mounted (though they are still empty).
>=20
> Some scaffolding code is added to create an empty directory as the root.
> It is replaced by proper inode creation in a subsequent patch in this
> series.
>=20
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> ---
>   rust/bindings/bindings_helper.h |   5 +
>   rust/bindings/lib.rs            |   4 +
>   rust/kernel/fs.rs               | 176 ++++++++++++++++++++++++++++++--
>   samples/rust/rust_rofs.rs       |  10 ++
>   4 files changed, 189 insertions(+), 6 deletions(-)
>=20
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_hel=
per.h
> index 9c23037b33d0..ca1898ce9527 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -9,6 +9,7 @@
>   #include <kunit/test.h>
>   #include <linux/errname.h>
>   #include <linux/fs.h>
> +#include <linux/fs_context.h>
>   #include <linux/slab.h>
>   #include <linux/refcount.h>
>   #include <linux/wait.h>
> @@ -22,3 +23,7 @@ const gfp_t BINDINGS___GFP_ZERO =3D __GFP_ZERO;
>   const slab_flags_t BINDINGS_SLAB_RECLAIM_ACCOUNT =3D SLAB_RECLAIM_ACCOU=
NT;
>   const slab_flags_t BINDINGS_SLAB_MEM_SPREAD =3D SLAB_MEM_SPREAD;
>   const slab_flags_t BINDINGS_SLAB_ACCOUNT =3D SLAB_ACCOUNT;
> +
> +const unsigned long BINDINGS_SB_RDONLY =3D SB_RDONLY;
> +
> +const loff_t BINDINGS_MAX_LFS_FILESIZE =3D MAX_LFS_FILESIZE;
> diff --git a/rust/bindings/lib.rs b/rust/bindings/lib.rs
> index 6a8c6cd17e45..426915d3fb57 100644
> --- a/rust/bindings/lib.rs
> +++ b/rust/bindings/lib.rs
> @@ -55,3 +55,7 @@ mod bindings_helper {
>   pub const SLAB_RECLAIM_ACCOUNT: slab_flags_t =3D BINDINGS_SLAB_RECLAIM_=
ACCOUNT;
>   pub const SLAB_MEM_SPREAD: slab_flags_t =3D BINDINGS_SLAB_MEM_SPREAD;
>   pub const SLAB_ACCOUNT: slab_flags_t =3D BINDINGS_SLAB_ACCOUNT;
> +
> +pub const SB_RDONLY: core::ffi::c_ulong =3D BINDINGS_SB_RDONLY;
> +
> +pub const MAX_LFS_FILESIZE: loff_t =3D BINDINGS_MAX_LFS_FILESIZE;
> diff --git a/rust/kernel/fs.rs b/rust/kernel/fs.rs
> index 1df54c234101..31cf643aaded 100644
> --- a/rust/kernel/fs.rs
> +++ b/rust/kernel/fs.rs
> @@ -6,16 +6,22 @@
>   //!
>   //! C headers: [`include/linux/fs.h`](../../include/linux/fs.h)
>=20
> -use crate::error::{code::*, from_result, to_result, Error};
> +use crate::error::{code::*, from_result, to_result, Error, Result};
>   use crate::types::Opaque;
>   use crate::{bindings, init::PinInit, str::CStr, try_pin_init, ThisModul=
e};
>   use core::{marker::PhantomData, marker::PhantomPinned, pin::Pin};
>   use macros::{pin_data, pinned_drop};
>=20
> +/// Maximum size of an inode.
> +pub const MAX_LFS_FILESIZE: i64 =3D bindings::MAX_LFS_FILESIZE;
> +
>   /// A file system type.
>   pub trait FileSystem {
>       /// The name of the file system type.
>       const NAME: &'static CStr;
> +
> +    /// Returns the parameters to initialise a super block.
> +    fn super_params(sb: &NewSuperBlock<Self>) -> Result<SuperParams>;
>   }
>=20
>   /// A registration of a file system.
> @@ -49,7 +55,7 @@ pub fn new<T: FileSystem + ?Sized>(module: &'static Thi=
sModule) -> impl PinInit<
>                   let fs =3D unsafe { &mut *fs_ptr };
>                   fs.owner =3D module.0;
>                   fs.name =3D T::NAME.as_char_ptr();
> -                fs.init_fs_context =3D Some(Self::init_fs_context_callba=
ck);
> +                fs.init_fs_context =3D Some(Self::init_fs_context_callba=
ck::<T>);
>                   fs.kill_sb =3D Some(Self::kill_sb_callback);
>                   fs.fs_flags =3D 0;
>=20
> @@ -60,13 +66,22 @@ pub fn new<T: FileSystem + ?Sized>(module: &'static T=
hisModule) -> impl PinInit<
>           })
>       }
>=20
> -    unsafe extern "C" fn init_fs_context_callback(
> -        _fc_ptr: *mut bindings::fs_context,
> +    unsafe extern "C" fn init_fs_context_callback<T: FileSystem + ?Sized=
>(
> +        fc_ptr: *mut bindings::fs_context,
>       ) -> core::ffi::c_int {
> -        from_result(|| Err(ENOTSUPP))
> +        from_result(|| {
> +            // SAFETY: The C callback API guarantees that `fc_ptr` is va=
lid.
> +            let fc =3D unsafe { &mut *fc_ptr };

This safety comment is not enough, the pointer needs to be unique and
pointing to a valid value for this to be ok. I would recommend to do
this instead:

    unsafe { addr_of_mut!((*fc_ptr).ops).write(&Tables::<T>::CONTEXT) };

> +            fc.ops =3D &Tables::<T>::CONTEXT;
> +            Ok(0)
> +        })
>       }
>=20
> -    unsafe extern "C" fn kill_sb_callback(_sb_ptr: *mut bindings::super_=
block) {}
> +    unsafe extern "C" fn kill_sb_callback(sb_ptr: *mut bindings::super_b=
lock) {
> +        // SAFETY: In `get_tree_callback` we always call `get_tree_nodev=
`, so `kill_anon_super` is
> +        // the appropriate function to call for cleanup.
> +        unsafe { bindings::kill_anon_super(sb_ptr) };
> +    }
>   }
>=20
>   #[pinned_drop]
> @@ -79,6 +94,151 @@ fn drop(self: Pin<&mut Self>) {
>       }
>   }
>=20
> +/// A file system super block.
> +///
> +/// Wraps the kernel's `struct super_block`.
> +#[repr(transparent)]
> +pub struct SuperBlock<T: FileSystem + ?Sized>(Opaque<bindings::super_blo=
ck>, PhantomData<T>);
> +
> +/// Required superblock parameters.
> +///
> +/// This is returned by implementations of [`FileSystem::super_params`].
> +pub struct SuperParams {
> +    /// The magic number of the superblock.
> +    pub magic: u32,
> +
> +    /// The size of a block in powers of 2 (i.e., for a value of `n`, th=
e size is `2^n`).
> +    pub blocksize_bits: u8,
> +
> +    /// Maximum size of a file.
> +    ///
> +    /// The maximum allowed value is [`MAX_LFS_FILESIZE`].
> +    pub maxbytes: i64,
> +
> +    /// Granularity of c/m/atime in ns (cannot be worse than a second).
> +    pub time_gran: u32,
> +}
> +
> +/// A superblock that is still being initialised.
> +///
> +/// # Invariants
> +///
> +/// The superblock is a newly-created one and this is the only active po=
inter to it.

This struct is not wrapping a pointer?

> +#[repr(transparent)]
> +pub struct NewSuperBlock<T: FileSystem + ?Sized>(bindings::super_block, =
PhantomData<T>);

No `Opaque`?

> +
> +struct Tables<T: FileSystem + ?Sized>(T);

Please add a newline here.

Also the field `self.0` is never actually used, should it be
`PhantomData<T>` instead?

> +impl<T: FileSystem + ?Sized> Tables<T> {
> +    const CONTEXT: bindings::fs_context_operations =3D bindings::fs_cont=
ext_operations {
> +        free: None,
> +        parse_param: None,
> +        get_tree: Some(Self::get_tree_callback),
> +        reconfigure: None,
> +        parse_monolithic: None,
> +        dup: None,
> +    };
> +
> +    unsafe extern "C" fn get_tree_callback(fc: *mut bindings::fs_context=
) -> core::ffi::c_int {
> +        // SAFETY: `fc` is valid per the callback contract. `fill_super_=
callback` also has
> +        // the right type and is a valid callback.
> +        unsafe { bindings::get_tree_nodev(fc, Some(Self::fill_super_call=
back)) }
> +    }
> +
> +    unsafe extern "C" fn fill_super_callback(
> +        sb_ptr: *mut bindings::super_block,
> +        _fc: *mut bindings::fs_context,
> +    ) -> core::ffi::c_int {
> +        from_result(|| {
> +            // SAFETY: The callback contract guarantees that `sb_ptr` is=
 a unique pointer to a
> +            // newly-created superblock.
> +            let sb =3D unsafe { &mut *sb_ptr.cast() };

It would be helpful if you spelled out the `NewSuperBlock` type here
somewhere (e.g. on the `cast::<NewSuperBlock>`).

Is it really ok to create a mutable reference to a `bindings::super_block`?
Since it is not wrapped in `Opaque`, I would rather have you avoid this.

> +            let params =3D T::super_params(sb)?;
> +
> +            sb.0.s_magic =3D params.magic as _;
> +            sb.0.s_op =3D &Tables::<T>::SUPER_BLOCK;
> +            sb.0.s_maxbytes =3D params.maxbytes;
> +            sb.0.s_time_gran =3D params.time_gran;
> +            sb.0.s_blocksize_bits =3D params.blocksize_bits;
> +            sb.0.s_blocksize =3D 1;
> +            if sb.0.s_blocksize.leading_zeros() < params.blocksize_bits.=
into() {
> +                return Err(EINVAL);
> +            }

I think you could add a comment that explains what this `if` does.

> +            sb.0.s_blocksize =3D 1 << sb.0.s_blocksize_bits;
> +            sb.0.s_flags |=3D bindings::SB_RDONLY;
> +
> +            // The following is scaffolding code that will be removed in=
 a subsequent patch. It is
> +            // needed to build a root dentry, otherwise core code will B=
UG().
> +            // SAFETY: `sb` is the superblock being initialised, it is v=
alid for read and write.
> +            let inode =3D unsafe { bindings::new_inode(&mut sb.0) };
> +            if inode.is_null() {
> +                return Err(ENOMEM);
> +            }
> +
> +            // SAFETY: `inode` is valid for write.
> +            unsafe { bindings::set_nlink(inode, 2) };
> +
> +            {
> +                // SAFETY: This is a newly-created inode. No other refer=
ences to it exist, so it is
> +                // safe to mutably dereference it.
> +                let inode =3D unsafe { &mut *inode };

The inode also needs to be initialized and have valid values as its fields.
Not sure if this is kept and it would probably be better to keep using raw
pointers here.

--
Cheers,
Benno

> +                inode.i_ino =3D 1;
> +                inode.i_mode =3D (bindings::S_IFDIR | 0o755) as _;
> +
> +                // SAFETY: `simple_dir_operations` never changes, it's s=
afe to reference it.
> +                inode.__bindgen_anon_3.i_fop =3D unsafe { &bindings::sim=
ple_dir_operations };
> +
> +                // SAFETY: `simple_dir_inode_operations` never changes, =
it's safe to reference it.
> +                inode.i_op =3D unsafe { &bindings::simple_dir_inode_oper=
ations };
> +            }
> +
> +            // SAFETY: `d_make_root` requires that `inode` be valid and =
referenced, which is the
> +            // case for this call.
> +            //
> +            // It takes over the inode, even on failure, so we don't nee=
d to clean it up.
> +            let dentry =3D unsafe { bindings::d_make_root(inode) };
> +            if dentry.is_null() {
> +                return Err(ENOMEM);
> +            }
> +
> +            sb.0.s_root =3D dentry;
> +
> +            Ok(0)
> +        })
> +    }
> +
> +    const SUPER_BLOCK: bindings::super_operations =3D bindings::super_op=
erations {
> +        alloc_inode: None,
> +        destroy_inode: None,
> +        free_inode: None,
> +        dirty_inode: None,
> +        write_inode: None,
> +        drop_inode: None,
> +        evict_inode: None,
> +        put_super: None,
> +        sync_fs: None,
> +        freeze_super: None,
> +        freeze_fs: None,
> +        thaw_super: None,
> +        unfreeze_fs: None,
> +        statfs: None,
> +        remount_fs: None,
> +        umount_begin: None,
> +        show_options: None,
> +        show_devname: None,
> +        show_path: None,
> +        show_stats: None,
> +        #[cfg(CONFIG_QUOTA)]
> +        quota_read: None,
> +        #[cfg(CONFIG_QUOTA)]
> +        quota_write: None,
> +        #[cfg(CONFIG_QUOTA)]
> +        get_dquots: None,
> +        nr_cached_objects: None,
> +        free_cached_objects: None,
> +        shutdown: None,
> +    };
> +}
> +
>   /// Kernel module that exposes a single file system implemented by `T`.
>   #[pin_data]
>   pub struct Module<T: FileSystem + ?Sized> {
> @@ -105,6 +265,7 @@ fn init(module: &'static ThisModule) -> impl PinInit<=
Self, Error> {
>   ///
>   /// ```
>   /// # mod module_fs_sample {
> +/// use kernel::fs::{NewSuperBlock, SuperParams};
>   /// use kernel::prelude::*;
>   /// use kernel::{c_str, fs};
>   ///
> @@ -119,6 +280,9 @@ fn init(module: &'static ThisModule) -> impl PinInit<=
Self, Error> {
>   /// struct MyFs;
>   /// impl fs::FileSystem for MyFs {
>   ///     const NAME: &'static CStr =3D c_str!("myfs");
> +///     fn super_params(_: &NewSuperBlock<Self>) -> Result<SuperParams> =
{
> +///         todo!()
> +///     }
>   /// }
>   /// # }
>   /// ```
> diff --git a/samples/rust/rust_rofs.rs b/samples/rust/rust_rofs.rs
> index 1c00b1da8b94..9878bf88b991 100644
> --- a/samples/rust/rust_rofs.rs
> +++ b/samples/rust/rust_rofs.rs
> @@ -2,6 +2,7 @@
>=20
>   //! Rust read-only file system sample.
>=20
> +use kernel::fs::{NewSuperBlock, SuperParams};
>   use kernel::prelude::*;
>   use kernel::{c_str, fs};
>=20
> @@ -16,4 +17,13 @@
>   struct RoFs;
>   impl fs::FileSystem for RoFs {
>       const NAME: &'static CStr =3D c_str!("rust-fs");
> +
> +    fn super_params(_sb: &NewSuperBlock<Self>) -> Result<SuperParams> {
> +        Ok(SuperParams {
> +            magic: 0x52555354,
> +            blocksize_bits: 12,
> +            maxbytes: fs::MAX_LFS_FILESIZE,
> +            time_gran: 1,
> +        })
> +    }
>   }
> --
> 2.34.1
>=20
> 

