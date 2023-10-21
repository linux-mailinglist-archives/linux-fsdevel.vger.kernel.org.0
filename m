Return-Path: <linux-fsdevel+bounces-871-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A9C7D1D45
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Oct 2023 15:39:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A4B6B214DC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Oct 2023 13:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A79DF4C;
	Sat, 21 Oct 2023 13:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="cPYZhxZO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21235D285
	for <linux-fsdevel@vger.kernel.org>; Sat, 21 Oct 2023 13:39:41 +0000 (UTC)
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41DD9D65
	for <linux-fsdevel@vger.kernel.org>; Sat, 21 Oct 2023 06:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1697895572; x=1698154772;
	bh=s1HaVgcscp4n+KUsIZLXySLXPUfH3CgwYaitPLZxLt4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=cPYZhxZOooCzKgJhDnKoQZgzVaC+CIMSuA1YwW6X8e7BFS1T273Qk4vs7UY175dtf
	 +00uVZEYOLWVXA5EybF9Vv9epQXWhLaRJhMPaKWmB2ipk3EwqJhcM0KSsj+CckIc0g
	 /PwovSBt+JzjEk5Y2uZXy6oWB0TkK37ZdKeYJalCjSETpdF3MNF64NnffcXUklLnTe
	 hydcsk5F6Ud4bkzLv86utBDGS7nEG5o4f50Pl2yg3SYoOvDTbb2/N6XDe/qXPpbUj2
	 kRa14ykI3m/L5JSkrbAzmv+tLvP8NdI6qlxiQPtiomBziMgYDaVLv/saNqjFPJ44yq
	 p+OjSkJXvDJXw==
Date: Sat, 21 Oct 2023 13:39:20 +0000
To: Wedson Almeida Filho <wedsonaf@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Matthew Wilcox <willy@infradead.org>, Kent Overstreet <kent.overstreet@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-fsdevel@vger.kernel.org, rust-for-linux@vger.kernel.org, Wedson Almeida Filho <walmeida@microsoft.com>
Subject: Re: [RFC PATCH 16/19] rust: fs: allow file systems backed by a block device
Message-ID: <gb4CNFpmDdn45YQDB8da-G8kJfYH4OT_dDpY1WpRzF5xui6NuiiZJQR0pxRHI0ECrrzQvrpHFEhEYcKXRDT2Tj44-0FU9avzwON2VPPo2pA=@proton.me>
In-Reply-To: <20231018122518.128049-17-wedsonaf@gmail.com>
References: <20231018122518.128049-1-wedsonaf@gmail.com> <20231018122518.128049-17-wedsonaf@gmail.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 18.10.23 14:25, Wedson Almeida Filho wrote:
> From: Wedson Almeida Filho <walmeida@microsoft.com>
>=20
> Allow Rust file systems that are backed by block devices (in addition to
> in-memory ones).
>=20
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> ---
>   rust/bindings/bindings_helper.h |   1 +
>   rust/helpers.c                  |  14 +++
>   rust/kernel/fs.rs               | 177 +++++++++++++++++++++++++++++---
>   rust/kernel/fs/buffer.rs        |   1 -
>   4 files changed, 180 insertions(+), 13 deletions(-)
>=20
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_hel=
per.h
> index d328375f7cb7..8403f13d4d48 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -7,6 +7,7 @@
>    */
>=20
>   #include <kunit/test.h>
> +#include <linux/bio.h>
>   #include <linux/buffer_head.h>
>   #include <linux/errname.h>
>   #include <linux/fs.h>
> diff --git a/rust/helpers.c b/rust/helpers.c
> index a5393c6b93f2..bc19f3b7b93e 100644
> --- a/rust/helpers.c
> +++ b/rust/helpers.c
> @@ -21,6 +21,7 @@
>    */
>=20
>   #include <kunit/test-bug.h>
> +#include <linux/blkdev.h>
>   #include <linux/buffer_head.h>
>   #include <linux/bug.h>
>   #include <linux/build_bug.h>
> @@ -252,6 +253,13 @@ unsigned int rust_helper_MKDEV(unsigned int major, u=
nsigned int minor)
>   EXPORT_SYMBOL_GPL(rust_helper_MKDEV);
>=20
>   #ifdef CONFIG_BUFFER_HEAD
> +struct buffer_head *rust_helper_sb_bread(struct super_block *sb,
> +=09=09sector_t block)
> +{
> +=09return sb_bread(sb, block);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_sb_bread);
> +
>   void rust_helper_get_bh(struct buffer_head *bh)
>   {
>   =09get_bh(bh);
> @@ -265,6 +273,12 @@ void rust_helper_put_bh(struct buffer_head *bh)
>   EXPORT_SYMBOL_GPL(rust_helper_put_bh);
>   #endif
>=20
> +sector_t rust_helper_bdev_nr_sectors(struct block_device *bdev)
> +{
> +=09return bdev_nr_sectors(bdev);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_bdev_nr_sectors);
> +
>   /*
>    * `bindgen` binds the C `size_t` type as the Rust `usize` type, so we =
can
>    * use it in contexts where Rust expects a `usize` like slice (array) i=
ndices.
> diff --git a/rust/kernel/fs.rs b/rust/kernel/fs.rs
> index 4f04cb1d3c6f..b1ad5c110dbb 100644
> --- a/rust/kernel/fs.rs
> +++ b/rust/kernel/fs.rs
> @@ -7,11 +7,9 @@
>   //! C headers: [`include/linux/fs.h`](../../include/linux/fs.h)
>=20
>   use crate::error::{code::*, from_result, to_result, Error, Result};
> -use crate::types::{ARef, AlwaysRefCounted, Either, ForeignOwnable, Opaqu=
e};
> -use crate::{
> -    bindings, folio::LockedFolio, init::PinInit, str::CStr, time::Timesp=
ec, try_pin_init,
> -    ThisModule,
> -};
> +use crate::folio::{LockedFolio, UniqueFolio};
> +use crate::types::{ARef, AlwaysRefCounted, Either, ForeignOwnable, Opaqu=
e, ScopeGuard};
> +use crate::{bindings, init::PinInit, str::CStr, time::Timespec, try_pin_=
init, ThisModule};
>   use core::{marker::PhantomData, marker::PhantomPinned, mem::ManuallyDro=
p, pin::Pin, ptr};
>   use macros::{pin_data, pinned_drop};
>=20
> @@ -21,6 +19,17 @@
>   /// Maximum size of an inode.
>   pub const MAX_LFS_FILESIZE: i64 =3D bindings::MAX_LFS_FILESIZE;
>=20
> +/// Type of superblock keying.
> +///
> +/// It determines how C's `fs_context_operations::get_tree` is implement=
ed.
> +pub enum Super {
> +    /// Multiple independent superblocks may exist.
> +    Independent,
> +
> +    /// Uses a block device.
> +    BlockDev,
> +}
> +
>   /// A file system type.
>   pub trait FileSystem {
>       /// Data associated with each file system instance (super-block).
> @@ -29,6 +38,9 @@ pub trait FileSystem {
>       /// The name of the file system type.
>       const NAME: &'static CStr;
>=20
> +    /// Determines how superblocks for this file system type are keyed.
> +    const SUPER_TYPE: Super =3D Super::Independent;
> +
>       /// Returns the parameters to initialise a super block.
>       fn super_params(sb: &NewSuperBlock<Self>) -> Result<SuperParams<Sel=
f::Data>>;
>=20
> @@ -181,7 +193,9 @@ pub fn new<T: FileSystem + ?Sized>(module: &'static T=
hisModule) -> impl PinInit<
>                   fs.name =3D T::NAME.as_char_ptr();
>                   fs.init_fs_context =3D Some(Self::init_fs_context_callb=
ack::<T>);
>                   fs.kill_sb =3D Some(Self::kill_sb_callback::<T>);
> -                fs.fs_flags =3D 0;
> +                fs.fs_flags =3D if let Super::BlockDev =3D T::SUPER_TYPE=
 {
> +                    bindings::FS_REQUIRES_DEV as i32
> +                } else { 0 };
>=20
>                   // SAFETY: Pointers stored in `fs` are static so will l=
ive for as long as the
>                   // registration is active (it is undone in `drop`).
> @@ -204,9 +218,16 @@ pub fn new<T: FileSystem + ?Sized>(module: &'static =
ThisModule) -> impl PinInit<
>       unsafe extern "C" fn kill_sb_callback<T: FileSystem + ?Sized>(
>           sb_ptr: *mut bindings::super_block,
>       ) {
> -        // SAFETY: In `get_tree_callback` we always call `get_tree_nodev=
`, so `kill_anon_super` is
> -        // the appropriate function to call for cleanup.
> -        unsafe { bindings::kill_anon_super(sb_ptr) };
> +        match T::SUPER_TYPE {
> +            // SAFETY: In `get_tree_callback` we always call `get_tree_b=
dev` for
> +            // `Super::BlockDev`, so `kill_block_super` is the appropria=
te function to call
> +            // for cleanup.
> +            Super::BlockDev =3D> unsafe { bindings::kill_block_super(sb_=
ptr) },
> +            // SAFETY: In `get_tree_callback` we always call `get_tree_n=
odev` for
> +            // `Super::Independent`, so `kill_anon_super` is the appropr=
iate function to call
> +            // for cleanup.
> +            Super::Independent =3D> unsafe { bindings::kill_anon_super(s=
b_ptr) },
> +        }
>=20
>           // SAFETY: The C API contract guarantees that `sb_ptr` is valid=
 for read.
>           let ptr =3D unsafe { (*sb_ptr).s_fs_info };
> @@ -479,6 +500,65 @@ pub fn get_or_create_inode(&self, ino: Ino) -> Resul=
t<Either<ARef<INode<T>>, New
>               })))
>           }
>       }
> +
> +    /// Reads a block from the block device.
> +    #[cfg(CONFIG_BUFFER_HEAD)]
> +    pub fn bread(&self, block: u64) -> Result<ARef<buffer::Head>> {
> +        // Fail requests for non-blockdev file systems. This is a compil=
e-time check.
> +        match T::SUPER_TYPE {
> +            Super::BlockDev =3D> {}
> +            _ =3D> return Err(EIO),
> +        }

Would it make sense to use `build_error` instead of returning an error
here?

Also, do you think that separating this into a trait, `BlockDevFS` would
make sense?

> +
> +        // SAFETY: This function is only valid after the `NeedsInit` typ=
estate, so the block size
> +        // is known and the superblock can be used to read blocks.

Stale SAFETY comment, there are not typestates in this patch?

> +        let ptr =3D
> +            ptr::NonNull::new(unsafe { bindings::sb_bread(self.0.get(), =
block) }).ok_or(EIO)?;
> +        // SAFETY: `sb_bread` returns a referenced buffer head. Ownershi=
p of the increment is
> +        // passed to the `ARef` instance.
> +        Ok(unsafe { ARef::from_raw(ptr.cast()) })
> +    }
> +
> +    /// Reads `size` bytes starting from `offset` bytes.
> +    ///
> +    /// Returns an iterator that returns slices based on blocks.
> +    #[cfg(CONFIG_BUFFER_HEAD)]
> +    pub fn read(
> +        &self,
> +        offset: u64,
> +        size: u64,
> +    ) -> Result<impl Iterator<Item =3D Result<buffer::View>> + '_> {
> +        struct BlockIter<'a, T: FileSystem + ?Sized> {
> +            sb: &'a SuperBlock<T>,
> +            next_offset: u64,
> +            end: u64,
> +        }
> +        impl<'a, T: FileSystem + ?Sized> Iterator for BlockIter<'a, T> {
> +            type Item =3D Result<buffer::View>;
> +
> +            fn next(&mut self) -> Option<Self::Item> {
> +                if self.next_offset >=3D self.end {
> +                    return None;
> +                }
> +
> +                // SAFETY: The superblock is valid and has had its block=
 size initialised.
> +                let block_size =3D unsafe { (*self.sb.0.get()).s_blocksi=
ze };
> +                let bh =3D match self.sb.bread(self.next_offset / block_=
size) {
> +                    Ok(bh) =3D> bh,
> +                    Err(e) =3D> return Some(Err(e)),
> +                };
> +                let boffset =3D self.next_offset & (block_size - 1);
> +                let bsize =3D core::cmp::min(self.end - self.next_offset=
, block_size - boffset);
> +                self.next_offset +=3D bsize;
> +                Some(Ok(buffer::View::new(bh, boffset as usize, bsize as=
 usize)))
> +            }
> +        }
> +        Ok(BlockIter {
> +            sb: self,
> +            next_offset: offset,
> +            end: offset.checked_add(size).ok_or(ERANGE)?,
> +        })
> +    }
>   }
>=20
>   /// Required superblock parameters.
> @@ -511,6 +591,70 @@ pub struct SuperParams<T: ForeignOwnable + Send + Sy=
nc> {
>   #[repr(transparent)]
>   pub struct NewSuperBlock<T: FileSystem + ?Sized>(bindings::super_block,=
 PhantomData<T>);
>=20
> +impl<T: FileSystem + ?Sized> NewSuperBlock<T> {
> +    /// Reads sectors.
> +    ///
> +    /// `count` must be such that the total size doesn't exceed a page.
> +    pub fn sread(&self, sector: u64, count: usize, folio: &mut UniqueFol=
io) -> Result {
> +        // Fail requests for non-blockdev file systems. This is a compil=
e-time check.
> +        match T::SUPER_TYPE {
> +            // The superblock is valid and given that it's a blockdev su=
perblock it must have a
> +            // valid `s_bdev`.
> +            Super::BlockDev =3D> {}
> +            _ =3D> return Err(EIO),
> +        }
> +
> +        crate::build_assert!(count * (bindings::SECTOR_SIZE as usize) <=
=3D bindings::PAGE_SIZE);

Maybe add an error message that explains why this is not ok?

> +
> +        // Read the sectors.
> +        let mut bio =3D bindings::bio::default();
> +        let bvec =3D Opaque::<bindings::bio_vec>::uninit();
> +
> +        // SAFETY: `bio` and `bvec` are allocated on the stack, they're =
both valid.
> +        unsafe {
> +            bindings::bio_init(
> +                &mut bio,
> +                self.0.s_bdev,
> +                bvec.get(),
> +                1,
> +                bindings::req_op_REQ_OP_READ,
> +            )
> +        };
> +
> +        // SAFETY: `bio` was just initialised with `bio_init` above, so =
it's safe to call
> +        // `bio_uninit` on the way out.
> +        let mut bio =3D
> +            ScopeGuard::new_with_data(bio, |mut b| unsafe { bindings::bi=
o_uninit(&mut b) });
> +
> +        // SAFETY: We have one free `bvec` (initialsied above). We also =
know that size won't exceed
> +        // a page size (build_assert above).

I think you should move the `build_assert` above this line.

--=20
Cheers,
Benno

> +        unsafe {
> +            bindings::bio_add_folio_nofail(
> +                &mut *bio,
> +                folio.0 .0.get(),
> +                count * (bindings::SECTOR_SIZE as usize),
> +                0,
> +            )
> +        };
> +        bio.bi_iter.bi_sector =3D sector;
> +
> +        // SAFETY: The bio was fully initialised above.
> +        to_result(unsafe { bindings::submit_bio_wait(&mut *bio) })?;
> +        Ok(())
> +    }
> +
> +    /// Returns the number of sectors in the underlying block device.
> +    pub fn sector_count(&self) -> Result<u64> {
> +        // Fail requests for non-blockdev file systems. This is a compil=
e-time check.
> +        match T::SUPER_TYPE {
> +            // The superblock is valid and given that it's a blockdev su=
perblock it must have a
> +            // valid `s_bdev`.
> +            Super::BlockDev =3D> Ok(unsafe { bindings::bdev_nr_sectors(s=
elf.0.s_bdev) }),
> +            _ =3D> Err(EIO),
> +        }
> +    }
> +}
> +
>   struct Tables<T: FileSystem + ?Sized>(T);
>   impl<T: FileSystem + ?Sized> Tables<T> {
>       const CONTEXT: bindings::fs_context_operations =3D bindings::fs_con=
text_operations {
> @@ -523,9 +667,18 @@ impl<T: FileSystem + ?Sized> Tables<T> {
>       };
>=20
>       unsafe extern "C" fn get_tree_callback(fc: *mut bindings::fs_contex=
t) -> core::ffi::c_int {
> -        // SAFETY: `fc` is valid per the callback contract. `fill_super_=
callback` also has
> -        // the right type and is a valid callback.
> -        unsafe { bindings::get_tree_nodev(fc, Some(Self::fill_super_call=
back)) }
> +        match T::SUPER_TYPE {
> +            // SAFETY: `fc` is valid per the callback contract. `fill_su=
per_callback` also has
> +            // the right type and is a valid callback.
> +            Super::BlockDev =3D> unsafe {
> +                bindings::get_tree_bdev(fc, Some(Self::fill_super_callba=
ck))
> +            },
> +            // SAFETY: `fc` is valid per the callback contract. `fill_su=
per_callback` also has
> +            // the right type and is a valid callback.
> +            Super::Independent =3D> unsafe {
> +                bindings::get_tree_nodev(fc, Some(Self::fill_super_callb=
ack))
> +            },
> +        }
>       }
>=20
>       unsafe extern "C" fn fill_super_callback(
> diff --git a/rust/kernel/fs/buffer.rs b/rust/kernel/fs/buffer.rs
> index 6052af8822b3..de23d0fee66c 100644
> --- a/rust/kernel/fs/buffer.rs
> +++ b/rust/kernel/fs/buffer.rs
> @@ -49,7 +49,6 @@ pub struct View {
>   }
>=20
>   impl View {
> -    #[allow(dead_code)]
>       pub(crate) fn new(head: ARef<Head>, offset: usize, size: usize) -> =
Self {
>           Self { head, size, offset }
>       }
> --
> 2.34.1
>=20
> 

