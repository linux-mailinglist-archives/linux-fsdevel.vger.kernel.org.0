Return-Path: <linux-fsdevel+bounces-759-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A9B7CFCC0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 16:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D0531C20EF2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 14:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ECAB2FE10;
	Thu, 19 Oct 2023 14:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="XGkIuLwx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BCD2FE08
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 14:31:32 +0000 (UTC)
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7180FD45
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 07:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1697725868; x=1697985068;
	bh=4VRsucx7Os9zi35oChWOMMTwI2zOzp8mr3Zm9FvgxKk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=XGkIuLwxHS5h79IsiDPVEU/zHjxh7MP7jGdbdEdiZl6Sm8WLod1UtUdIGfGZhD5ty
	 PX+Vfcg2qwSfrLLktP1/i1fP3ngFrB5x+GqjinsFhqCgB4VOH7fui643URPMNGTDYX
	 l8VyiNv/UKNmOAT1mPyzCVmScX7ZzhNV83KHUT9OZXOf0fnu06AjTHg3kWM/6c4c6E
	 3FMyDtv+czX+0B4d/RKbsIl+AQYs1OnLOPSVdkXIp+wBtZwmh1SjK8wcnboG1bPG1h
	 fWYjrnUXZ3vifVpMWzPtJN3+Pzb/SZrj6zcznHvciZjxuPAXLjjHk5trHIMi5BMg6N
	 bNlPpRdMZ/aEQ==
Date: Thu, 19 Oct 2023 14:30:56 +0000
To: Wedson Almeida Filho <wedsonaf@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Matthew Wilcox <willy@infradead.org>, Kent Overstreet <kent.overstreet@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-fsdevel@vger.kernel.org, rust-for-linux@vger.kernel.org, Wedson Almeida Filho <walmeida@microsoft.com>
Subject: Re: [RFC PATCH 06/19] rust: fs: introduce `FileSystem::init_root`
Message-ID: <OjZkAoZLnJc9yA0MENJhQx_32ptXZ1cLAFjEnEFog05C4pEmaAUHaA6wBvCFXWtaXbrNN5upFFi3ohQ6neLklIXZBURaYLlQYf3-2gscw_s=@proton.me>
In-Reply-To: <20231018122518.128049-7-wedsonaf@gmail.com>
References: <20231018122518.128049-1-wedsonaf@gmail.com> <20231018122518.128049-7-wedsonaf@gmail.com>
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
> Allow Rust file systems to specify their root directory. Also allow them
> to create (and do cache lookups of) directory inodes. (More types of
> inodes are added in subsequent patches in the series.)
>=20
> The `NewINode` type ensures that a new inode is properly initialised
> before it is marked so. It also facilitates error paths by automatically
> marking inodes as failed if they're not properly initialised.
>=20
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> ---
>   rust/helpers.c            |  12 +++
>   rust/kernel/fs.rs         | 178 +++++++++++++++++++++++++++++++-------
>   samples/rust/rust_rofs.rs |  22 ++++-
>   3 files changed, 181 insertions(+), 31 deletions(-)
>=20
> diff --git a/rust/helpers.c b/rust/helpers.c
> index fe45f8ddb31f..c5a2bec6467d 100644
> --- a/rust/helpers.c
> +++ b/rust/helpers.c
> @@ -145,6 +145,18 @@ struct kunit *rust_helper_kunit_get_current_test(voi=
d)
>   }
>   EXPORT_SYMBOL_GPL(rust_helper_kunit_get_current_test);
>=20
> +void rust_helper_i_uid_write(struct inode *inode, uid_t uid)
> +{
> +=09i_uid_write(inode, uid);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_i_uid_write);
> +
> +void rust_helper_i_gid_write(struct inode *inode, gid_t gid)
> +{
> +=09i_gid_write(inode, gid);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_i_gid_write);
> +
>   off_t rust_helper_i_size_read(const struct inode *inode)
>   {
>   =09return i_size_read(inode);
> diff --git a/rust/kernel/fs.rs b/rust/kernel/fs.rs
> index 30fa1f312f33..f3a41cf57502 100644
> --- a/rust/kernel/fs.rs
> +++ b/rust/kernel/fs.rs
> @@ -7,9 +7,9 @@
>   //! C headers: [`include/linux/fs.h`](../../include/linux/fs.h)
>=20
>   use crate::error::{code::*, from_result, to_result, Error, Result};
> -use crate::types::{AlwaysRefCounted, Opaque};
> -use crate::{bindings, init::PinInit, str::CStr, try_pin_init, ThisModule=
};
> -use core::{marker::PhantomData, marker::PhantomPinned, pin::Pin, ptr};
> +use crate::types::{ARef, AlwaysRefCounted, Either, Opaque};
> +use crate::{bindings, init::PinInit, str::CStr, time::Timespec, try_pin_=
init, ThisModule};
> +use core::{marker::PhantomData, marker::PhantomPinned, mem::ManuallyDrop=
, pin::Pin, ptr};
>   use macros::{pin_data, pinned_drop};
>=20
>   /// Maximum size of an inode.
> @@ -22,6 +22,12 @@ pub trait FileSystem {
>=20
>       /// Returns the parameters to initialise a super block.
>       fn super_params(sb: &NewSuperBlock<Self>) -> Result<SuperParams>;
> +
> +    /// Initialises and returns the root inode of the given superblock.
> +    ///
> +    /// This is called during initialisation of a superblock after [`Fil=
eSystem::super_params`] has
> +    /// completed successfully.
> +    fn init_root(sb: &SuperBlock<Self>) -> Result<ARef<INode<Self>>>;
>   }
>=20
>   /// A registration of a file system.
> @@ -143,12 +149,136 @@ unsafe fn dec_ref(obj: ptr::NonNull<Self>) {
>       }
>   }
>=20
> +/// An inode that is locked and hasn't been initialised yet.
> +#[repr(transparent)]
> +pub struct NewINode<T: FileSystem + ?Sized>(ARef<INode<T>>);
> +
> +impl<T: FileSystem + ?Sized> NewINode<T> {
> +    /// Initialises the new inode with the given parameters.
> +    pub fn init(self, params: INodeParams) -> Result<ARef<INode<T>>> {
> +        // SAFETY: This is a new inode, so it's safe to manipulate it mu=
tably.

How do you know that this is a new inode? Maybe add a type invariant?

> +        let inode =3D unsafe { &mut *self.0 .0.get() };
> +
> +        let mode =3D match params.typ {
> +            INodeType::Dir =3D> {
> +                // SAFETY: `simple_dir_operations` never changes, it's s=
afe to reference it.
> +                inode.__bindgen_anon_3.i_fop =3D unsafe { &bindings::sim=
ple_dir_operations };
> +
> +                // SAFETY: `simple_dir_inode_operations` never changes, =
it's safe to reference it.
> +                inode.i_op =3D unsafe { &bindings::simple_dir_inode_oper=
ations };
> +                bindings::S_IFDIR
> +            }
> +        };
> +
> +        inode.i_mode =3D (params.mode & 0o777) | u16::try_from(mode)?;
> +        inode.i_size =3D params.size;
> +        inode.i_blocks =3D params.blocks;
> +
> +        inode.__i_ctime =3D params.ctime.into();
> +        inode.i_mtime =3D params.mtime.into();
> +        inode.i_atime =3D params.atime.into();
> +
> +        // SAFETY: inode is a new inode, so it is valid for write.
> +        unsafe {
> +            bindings::set_nlink(inode, params.nlink);
> +            bindings::i_uid_write(inode, params.uid);
> +            bindings::i_gid_write(inode, params.gid);
> +            bindings::unlock_new_inode(inode);
> +        }
> +
> +        // SAFETY: We are manually destructuring `self` and preventing `=
drop` from being called.
> +        Ok(unsafe { (&ManuallyDrop::new(self).0 as *const ARef<INode<T>>=
).read() })

Add a comment that explains why you need to do this instead of `self.0`.

> +    }
> +}
> +
> +impl<T: FileSystem + ?Sized> Drop for NewINode<T> {
> +    fn drop(&mut self) {
> +        // SAFETY: The new inode failed to be turned into an initialised=
 inode, so it's safe (and
> +        // in fact required) to call `iget_failed` on it.
> +        unsafe { bindings::iget_failed(self.0 .0.get()) };
> +    }
> +}
> +
> +/// The type of the inode.
> +#[derive(Copy, Clone)]
> +pub enum INodeType {
> +    /// Directory type.
> +    Dir,
> +}
> +
> +/// Required inode parameters.
> +///
> +/// This is used when creating new inodes.
> +pub struct INodeParams {
> +    /// The access mode. It's a mask that grants execute (1), write (2) =
and read (4) access to
> +    /// everyone, the owner group, and the owner.
> +    pub mode: u16,
> +
> +    /// Type of inode.
> +    ///
> +    /// Also carries additional per-type data.
> +    pub typ: INodeType,
> +
> +    /// Size of the contents of the inode.
> +    ///
> +    /// Its maximum value is [`MAX_LFS_FILESIZE`].
> +    pub size: i64,
> +
> +    /// Number of blocks.
> +    pub blocks: u64,
> +
> +    /// Number of links to the inode.
> +    pub nlink: u32,
> +
> +    /// User id.
> +    pub uid: u32,
> +
> +    /// Group id.
> +    pub gid: u32,
> +
> +    /// Creation time.
> +    pub ctime: Timespec,
> +
> +    /// Last modification time.
> +    pub mtime: Timespec,
> +
> +    /// Last access time.
> +    pub atime: Timespec,
> +}
> +
>   /// A file system super block.
>   ///
>   /// Wraps the kernel's `struct super_block`.
>   #[repr(transparent)]
>   pub struct SuperBlock<T: FileSystem + ?Sized>(Opaque<bindings::super_bl=
ock>, PhantomData<T>);
>=20
> +impl<T: FileSystem + ?Sized> SuperBlock<T> {
> +    /// Tries to get an existing inode or create a new one if it doesn't=
 exist yet.
> +    pub fn get_or_create_inode(&self, ino: Ino) -> Result<Either<ARef<IN=
ode<T>>, NewINode<T>>> {
> +        // SAFETY: The only initialisation missing from the superblock i=
s the root, and this
> +        // function is needed to create the root, so it's safe to call i=
t.

This is a weird safety comment. Why is the superblock not fully
initialized? Why is safe to call the function? This comment doesn't
really explain anything.

> +        let inode =3D
> +            ptr::NonNull::new(unsafe { bindings::iget_locked(self.0.get(=
), ino) }).ok_or(ENOMEM)?;
> +
> +        // SAFETY: `inode` is valid for read, but there could be concurr=
ent writers (e.g., if it's
> +        // an already-initialised inode), so we use `read_volatile` to r=
ead its current state.
> +        let state =3D unsafe { ptr::read_volatile(ptr::addr_of!((*inode.=
as_ptr()).i_state)) };

Are you sure that `read_volatile` is sufficient for this use case? The
documentation [1] clearly states that concurrent write operations are still
UB:

    Just like in C, whether an operation is volatile has no bearing
    whatsoever on questions involving concurrent access from multiple
    threads. Volatile accesses behave exactly like non-atomic accesses in
    that regard. In particular, a race between a read_volatile and any
    write operation to the same location is undefined behavior.

[1]: https://doc.rust-lang.org/core/ptr/fn.read_volatile.html

--=20
Cheers,
Benno

> +        if state & u64::from(bindings::I_NEW) =3D=3D 0 {
> +            // The inode is cached. Just return it.
> +            //
> +            // SAFETY: `inode` had its refcount incremented by `iget_loc=
ked`; this increment is now
> +            // owned by `ARef`.
> +            Ok(Either::Left(unsafe { ARef::from_raw(inode.cast()) }))
> +        } else {
> +            // SAFETY: The new inode is valid but not fully initialised =
yet, so it's ok to create a
> +            // `NewINode`.
> +            Ok(Either::Right(NewINode(unsafe {
> +                ARef::from_raw(inode.cast())
> +            })))
> +        }
> +    }
> +}
> +
>   /// Required superblock parameters.
>   ///
>   /// This is returned by implementations of [`FileSystem::super_params`]=
.
> @@ -215,41 +345,28 @@ impl<T: FileSystem + ?Sized> Tables<T> {
>               sb.0.s_blocksize =3D 1 << sb.0.s_blocksize_bits;
>               sb.0.s_flags |=3D bindings::SB_RDONLY;
>=20
> -            // The following is scaffolding code that will be removed in=
 a subsequent patch. It is
> -            // needed to build a root dentry, otherwise core code will B=
UG().
> -            // SAFETY: `sb` is the superblock being initialised, it is v=
alid for read and write.
> -            let inode =3D unsafe { bindings::new_inode(&mut sb.0) };
> -            if inode.is_null() {
> -                return Err(ENOMEM);
> -            }
> -
> -            // SAFETY: `inode` is valid for write.
> -            unsafe { bindings::set_nlink(inode, 2) };
> -
> -            {
> -                // SAFETY: This is a newly-created inode. No other refer=
ences to it exist, so it is
> -                // safe to mutably dereference it.
> -                let inode =3D unsafe { &mut *inode };
> -                inode.i_ino =3D 1;
> -                inode.i_mode =3D (bindings::S_IFDIR | 0o755) as _;
> -
> -                // SAFETY: `simple_dir_operations` never changes, it's s=
afe to reference it.
> -                inode.__bindgen_anon_3.i_fop =3D unsafe { &bindings::sim=
ple_dir_operations };
> +            // SAFETY: The callback contract guarantees that `sb_ptr` is=
 a unique pointer to a
> +            // newly-created (and initialised above) superblock.
> +            let sb =3D unsafe { &mut *sb_ptr.cast() };
> +            let root =3D T::init_root(sb)?;
>=20
> -                // SAFETY: `simple_dir_inode_operations` never changes, =
it's safe to reference it.
> -                inode.i_op =3D unsafe { &bindings::simple_dir_inode_oper=
ations };
> +            // Reject root inode if it belongs to a different superblock=
.
> +            if !ptr::eq(root.super_block(), sb) {
> +                return Err(EINVAL);
>               }
>=20
>               // SAFETY: `d_make_root` requires that `inode` be valid and=
 referenced, which is the
>               // case for this call.
>               //
>               // It takes over the inode, even on failure, so we don't ne=
ed to clean it up.
> -            let dentry =3D unsafe { bindings::d_make_root(inode) };
> +            let dentry =3D unsafe { bindings::d_make_root(ManuallyDrop::=
new(root).0.get()) };
>               if dentry.is_null() {
>                   return Err(ENOMEM);
>               }
>=20
> -            sb.0.s_root =3D dentry;
> +            // SAFETY: The callback contract guarantees that `sb_ptr` is=
 a unique pointer to a
> +            // newly-created (and initialised above) superblock.
> +            unsafe { (*sb_ptr).s_root =3D dentry };
>=20
>               Ok(0)
>           })
> @@ -314,9 +431,9 @@ fn init(module: &'static ThisModule) -> impl PinInit<=
Self, Error> {
>   ///
>   /// ```
>   /// # mod module_fs_sample {
> -/// use kernel::fs::{NewSuperBlock, SuperParams};
> +/// use kernel::fs::{INode, NewSuperBlock, SuperBlock, SuperParams};
>   /// use kernel::prelude::*;
> -/// use kernel::{c_str, fs};
> +/// use kernel::{c_str, fs, types::ARef};
>   ///
>   /// kernel::module_fs! {
>   ///     type: MyFs,
> @@ -332,6 +449,9 @@ fn init(module: &'static ThisModule) -> impl PinInit<=
Self, Error> {
>   ///     fn super_params(_: &NewSuperBlock<Self>) -> Result<SuperParams>=
 {
>   ///         todo!()
>   ///     }
> +///     fn init_root(_sb: &SuperBlock<Self>) -> Result<ARef<INode<Self>>=
> {
> +///         todo!()
> +///     }
>   /// }
>   /// # }
>   /// ```
> diff --git a/samples/rust/rust_rofs.rs b/samples/rust/rust_rofs.rs
> index 9878bf88b991..9e5f4c7d1c06 100644
> --- a/samples/rust/rust_rofs.rs
> +++ b/samples/rust/rust_rofs.rs
> @@ -2,9 +2,9 @@
>=20
>   //! Rust read-only file system sample.
>=20
> -use kernel::fs::{NewSuperBlock, SuperParams};
> +use kernel::fs::{INode, INodeParams, INodeType, NewSuperBlock, SuperBloc=
k, SuperParams};
>   use kernel::prelude::*;
> -use kernel::{c_str, fs};
> +use kernel::{c_str, fs, time::UNIX_EPOCH, types::ARef, types::Either};
>=20
>   kernel::module_fs! {
>       type: RoFs,
> @@ -26,4 +26,22 @@ fn super_params(_sb: &NewSuperBlock<Self>) -> Result<S=
uperParams> {
>               time_gran: 1,
>           })
>       }
> +
> +    fn init_root(sb: &SuperBlock<Self>) -> Result<ARef<INode<Self>>> {
> +        match sb.get_or_create_inode(1)? {
> +            Either::Left(existing) =3D> Ok(existing),
> +            Either::Right(new) =3D> new.init(INodeParams {
> +                typ: INodeType::Dir,
> +                mode: 0o555,
> +                size: 1,
> +                blocks: 1,
> +                nlink: 2,
> +                uid: 0,
> +                gid: 0,
> +                atime: UNIX_EPOCH,
> +                ctime: UNIX_EPOCH,
> +                mtime: UNIX_EPOCH,
> +            }),
> +        }
> +    }
>   }
> --
> 2.34.1
>=20
> 

