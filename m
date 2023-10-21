Return-Path: <linux-fsdevel+bounces-873-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CEAA7D1D60
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Oct 2023 15:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E0842821B3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Oct 2023 13:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 908A7101C7;
	Sat, 21 Oct 2023 13:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="REyvqIJ6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6D079C5;
	Sat, 21 Oct 2023 13:57:45 +0000 (UTC)
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C93541A8;
	Sat, 21 Oct 2023 06:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=cy7sbnlpundi5fyfdzjzod6bu4.protonmail; t=1697896658; x=1698155858;
	bh=vvkKFbujKxzDq6ERk+nCxnSqIkepe4o/xnyCQpKwk5Q=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=REyvqIJ6bRsHrh3+88AJz97i81IABDvRxIcauXRE1E6R/eklDwUqpom8Qu2kefM7y
	 k0KMCnYlfQS5jDZIj1DlQV+BkCMQKg/KaXVNvWceGzd6BV5n+Ysv6FSpp78tphkhhp
	 ejyJtomLJAxL4ljg1Vwp+yxFzGm4peu5lS/Qq3+RPJchkOmiL95xgKeIbsH2iPfQE5
	 yIE33o0Y7nhwqn88VzjHzRpbaFcDLipF+vfaaYt3Q+IrHPmlf43dKRao/H40FLJtqz
	 n4dUjCYlsTxdmt55ZhCsMg8y7R81nrvPoWaYFY5tBkUHLNL5gh+qGg2zYbBCSniwHv
	 3J+0GK6SdLH/Q==
Date: Sat, 21 Oct 2023 13:57:28 +0000
To: Wedson Almeida Filho <wedsonaf@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Matthew Wilcox <willy@infradead.org>, Kent Overstreet <kent.overstreet@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-fsdevel@vger.kernel.org, rust-for-linux@vger.kernel.org, Wedson Almeida Filho <walmeida@microsoft.com>
Subject: Re: [RFC PATCH 17/19] rust: fs: allow per-inode data
Message-ID: <bopwx-FHBNoDb89v2Smh-d2qM4oZwkDwMjS6wf1zsCJVlVBsc1fya6GPArBlEc1hu1Rj3Ote0V473D-a44O-mwySrdi1igSTeMQENhr2UZg=@proton.me>
In-Reply-To: <20231018122518.128049-18-wedsonaf@gmail.com>
References: <20231018122518.128049-1-wedsonaf@gmail.com> <20231018122518.128049-18-wedsonaf@gmail.com>
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
> Allow Rust file systems to attach extra [typed] data to each inode. If
> no data is needed, use the regular inode kmem_cache, otherwise we create
> a new one.
>=20
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> ---
>   rust/helpers.c            |   7 +++
>   rust/kernel/fs.rs         | 128 +++++++++++++++++++++++++++++++++++---
>   rust/kernel/mem_cache.rs  |   2 -
>   samples/rust/rust_rofs.rs |   9 ++-
>   4 files changed, 131 insertions(+), 15 deletions(-)
>=20
> diff --git a/rust/helpers.c b/rust/helpers.c
> index bc19f3b7b93e..7b12a6d4cf5c 100644
> --- a/rust/helpers.c
> +++ b/rust/helpers.c
> @@ -222,6 +222,13 @@ void rust_helper_kunmap_local(const void *vaddr)
>   }
>   EXPORT_SYMBOL_GPL(rust_helper_kunmap_local);
>=20
> +void *rust_helper_alloc_inode_sb(struct super_block *sb,
> +=09=09=09=09 struct kmem_cache *cache, gfp_t gfp)
> +{
> +=09return alloc_inode_sb(sb, cache, gfp);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_alloc_inode_sb);
> +
>   void rust_helper_i_uid_write(struct inode *inode, uid_t uid)
>   {
>   =09i_uid_write(inode, uid);
> diff --git a/rust/kernel/fs.rs b/rust/kernel/fs.rs
> index b1ad5c110dbb..b07203758674 100644
> --- a/rust/kernel/fs.rs
> +++ b/rust/kernel/fs.rs
> @@ -9,8 +9,12 @@
>   use crate::error::{code::*, from_result, to_result, Error, Result};
>   use crate::folio::{LockedFolio, UniqueFolio};
>   use crate::types::{ARef, AlwaysRefCounted, Either, ForeignOwnable, Opaq=
ue, ScopeGuard};
> -use crate::{bindings, init::PinInit, str::CStr, time::Timespec, try_pin_=
init, ThisModule};
> -use core::{marker::PhantomData, marker::PhantomPinned, mem::ManuallyDrop=
, pin::Pin, ptr};
> +use crate::{
> +    bindings, container_of, init::PinInit, mem_cache::MemCache, str::CSt=
r, time::Timespec,
> +    try_pin_init, ThisModule,
> +};
> +use core::mem::{size_of, ManuallyDrop, MaybeUninit};
> +use core::{marker::PhantomData, marker::PhantomPinned, pin::Pin, ptr};
>   use macros::{pin_data, pinned_drop};
>=20
>   #[cfg(CONFIG_BUFFER_HEAD)]
> @@ -35,6 +39,9 @@ pub trait FileSystem {
>       /// Data associated with each file system instance (super-block).
>       type Data: ForeignOwnable + Send + Sync;
>=20
> +    /// Type of data associated with each inode.
> +    type INodeData: Send + Sync;
> +
>       /// The name of the file system type.
>       const NAME: &'static CStr;
>=20
> @@ -165,6 +172,7 @@ fn try_from(v: u32) -> Result<Self> {
>   pub struct Registration {
>       #[pin]
>       fs: Opaque<bindings::file_system_type>,
> +    inode_cache: Option<MemCache>,
>       #[pin]
>       _pin: PhantomPinned,
>   }
> @@ -182,6 +190,14 @@ impl Registration {
>       pub fn new<T: FileSystem + ?Sized>(module: &'static ThisModule) -> =
impl PinInit<Self, Error> {
>           try_pin_init!(Self {
>               _pin: PhantomPinned,
> +            inode_cache: if size_of::<T::INodeData>() =3D=3D 0 {
> +                None
> +            } else {
> +                Some(MemCache::try_new::<INodeWithData<T::INodeData>>(
> +                    T::NAME,
> +                    Some(Self::inode_init_once_callback::<T>),
> +                )?)
> +            },
>               fs <- Opaque::try_ffi_init(|fs_ptr: *mut bindings::file_sys=
tem_type| {
>                   // SAFETY: `try_ffi_init` guarantees that `fs_ptr` is v=
alid for write.
>                   unsafe { fs_ptr.write(bindings::file_system_type::defau=
lt()) };
> @@ -239,6 +255,16 @@ pub fn new<T: FileSystem + ?Sized>(module: &'static =
ThisModule) -> impl PinInit<
>               unsafe { T::Data::from_foreign(ptr) };
>           }
>       }
> +
> +    unsafe extern "C" fn inode_init_once_callback<T: FileSystem + ?Sized=
>(
> +        outer_inode: *mut core::ffi::c_void,
> +    ) {
> +        let ptr =3D outer_inode.cast::<INodeWithData<T::INodeData>>();
> +
> +        // SAFETY: This is only used in `new`, so we know that we have a=
 valid `INodeWithData`
> +        // instance whose inode part can be initialised.
> +        unsafe { bindings::inode_init_once(ptr::addr_of_mut!((*ptr).inod=
e)) };
> +    }
>   }
>=20
>   #[pinned_drop]
> @@ -280,6 +306,15 @@ pub fn super_block(&self) -> &SuperBlock<T> {
>           unsafe { &*(*self.0.get()).i_sb.cast() }
>       }
>=20
> +    /// Returns the data associated with the inode.
> +    pub fn data(&self) -> &T::INodeData {
> +        let outerp =3D container_of!(self.0.get(), INodeWithData<T::INod=
eData>, inode);
> +        // SAFETY: `self` is guaranteed to be valid by the existence of =
a shared reference
> +        // (`&self`) to it. Additionally, we know `T::INodeData` is alwa=
ys initialised in an
> +        // `INode`.
> +        unsafe { &*(*outerp).data.as_ptr() }
> +    }
> +
>       /// Returns the size of the inode contents.
>       pub fn size(&self) -> i64 {
>           // SAFETY: `self` is guaranteed to be valid by the existence of=
 a shared reference.
> @@ -300,15 +335,29 @@ unsafe fn dec_ref(obj: ptr::NonNull<Self>) {
>       }
>   }
>=20
> +struct INodeWithData<T> {
> +    data: MaybeUninit<T>,
> +    inode: bindings::inode,

No `Opaque`?

> +}
> +
>   /// An inode that is locked and hasn't been initialised yet.
>   #[repr(transparent)]
>   pub struct NewINode<T: FileSystem + ?Sized>(ARef<INode<T>>);
>=20
>   impl<T: FileSystem + ?Sized> NewINode<T> {
>       /// Initialises the new inode with the given parameters.
> -    pub fn init(self, params: INodeParams) -> Result<ARef<INode<T>>> {
> -        // SAFETY: This is a new inode, so it's safe to manipulate it mu=
tably.
> -        let inode =3D unsafe { &mut *self.0 .0.get() };
> +    pub fn init(self, params: INodeParams<T::INodeData>) -> Result<ARef<=
INode<T>>> {
> +        let outerp =3D container_of!(self.0 .0.get(), INodeWithData<T::I=
NodeData>, inode);
> +
> +        // SAFETY: This is a newly-created inode. No other references to=
 it exist, so it is
> +        // safe to mutably dereference it.
> +        let outer =3D unsafe { &mut *outerp.cast_mut() };
> +
> +        // N.B. We must always write this to a newly allocated inode bec=
ause the free callback
> +        // expects the data to be initialised and drops it.

This should be an invariant.

> +        outer.data.write(params.value);
> +
> +        let inode =3D &mut outer.inode;
>=20
>           let mode =3D match params.typ {
>               INodeType::Dir =3D> {
> @@ -424,7 +473,7 @@ pub enum INodeType {
>   /// Required inode parameters.
>   ///
>   /// This is used when creating new inodes.
> -pub struct INodeParams {
> +pub struct INodeParams<T> {
>       /// The access mode. It's a mask that grants execute (1), write (2)=
 and read (4) access to
>       /// everyone, the owner group, and the owner.
>       pub mode: u16,
> @@ -459,6 +508,9 @@ pub struct INodeParams {
>=20
>       /// Last access time.
>       pub atime: Timespec,
> +
> +    /// Value to attach to this node.
> +    pub value: T,
>   }
>=20
>   /// A file system super block.
> @@ -735,8 +787,12 @@ impl<T: FileSystem + ?Sized> Tables<T> {
>       }
>=20
>       const SUPER_BLOCK: bindings::super_operations =3D bindings::super_o=
perations {
> -        alloc_inode: None,
> -        destroy_inode: None,
> +        alloc_inode: if size_of::<T::INodeData>() !=3D 0 {
> +            Some(Self::alloc_inode_callback)
> +        } else {
> +            None
> +        },
> +        destroy_inode: Some(Self::destroy_inode_callback),
>           free_inode: None,
>           dirty_inode: None,
>           write_inode: None,
> @@ -766,6 +822,61 @@ impl<T: FileSystem + ?Sized> Tables<T> {
>           shutdown: None,
>       };
>=20
> +    unsafe extern "C" fn alloc_inode_callback(
> +        sb: *mut bindings::super_block,
> +    ) -> *mut bindings::inode {
> +        // SAFETY: The callback contract guarantees that `sb` is valid f=
or read.
> +        let super_type =3D unsafe { (*sb).s_type };
> +
> +        // SAFETY: This callback is only used in `Registration`, so `sup=
er_type` is necessarily
> +        // embedded in a `Registration`, which is guaranteed to be valid=
 because it has a
> +        // superblock associated to it.
> +        let reg =3D unsafe { &*container_of!(super_type, Registration, f=
s) };
> +
> +        // SAFETY: `sb` and `cache` are guaranteed to be valid by the ca=
llback contract and by
> +        // the existence of a superblock respectively.
> +        let ptr =3D unsafe {
> +            bindings::alloc_inode_sb(sb, MemCache::ptr(&reg.inode_cache)=
, bindings::GFP_KERNEL)
> +        }
> +        .cast::<INodeWithData<T::INodeData>>();
> +        if ptr.is_null() {
> +            return ptr::null_mut();
> +        }
> +        ptr::addr_of_mut!((*ptr).inode)
> +    }
> +
> +    unsafe extern "C" fn destroy_inode_callback(inode: *mut bindings::in=
ode) {
> +        // SAFETY: By the C contract, `inode` is a valid pointer.
> +        let is_bad =3D unsafe { bindings::is_bad_inode(inode) };
> +
> +        // SAFETY: The inode is guaranteed to be valid by the callback c=
ontract. Additionally, the
> +        // superblock is also guaranteed to still be valid by the inode =
existence.
> +        let super_type =3D unsafe { (*(*inode).i_sb).s_type };
> +
> +        // SAFETY: This callback is only used in `Registration`, so `sup=
er_type` is necessarily
> +        // embedded in a `Registration`, which is guaranteed to be valid=
 because it has a
> +        // superblock associated to it.
> +        let reg =3D unsafe { &*container_of!(super_type, Registration, f=
s) };
> +        let ptr =3D container_of!(inode, INodeWithData<T::INodeData>, in=
ode).cast_mut();
> +
> +        if !is_bad {
> +            // SAFETY: The code either initialises the data or marks the=
 inode as bad. Since the

Where exactly is it marked as "bad"?

--=20
Cheers,
Benno

> +            // inode is not bad, the data is initialised, and thus safe =
to drop.
> +            unsafe { ptr::drop_in_place((*ptr).data.as_mut_ptr()) };
> +        }
> +
> +        if size_of::<T::INodeData>() =3D=3D 0 {
> +            // SAFETY: When the size of `INodeData` is zero, we don't us=
e a separate mem_cache, so
> +            // it is allocated from the regular mem_cache, which is what=
 `free_inode_nonrcu` uses
> +            // to free the inode.
> +            unsafe { bindings::free_inode_nonrcu(inode) };
> +        } else {
> +            // The callback contract guarantees that the inode was previ=
ously allocated via the
> +            // `alloc_inode_callback` callback, so it is safe to free it=
 back to the cache.
> +            unsafe { bindings::kmem_cache_free(MemCache::ptr(&reg.inode_=
cache), ptr.cast()) };
> +        }
> +    }
> +
>       unsafe extern "C" fn statfs_callback(
>           dentry: *mut bindings::dentry,
>           buf: *mut bindings::kstatfs,
> @@ -1120,6 +1231,7 @@ fn init(module: &'static ThisModule) -> impl PinIni=
t<Self, Error> {
>   /// struct MyFs;
>   /// impl fs::FileSystem for MyFs {
>   ///     type Data =3D ();
> +///     type INodeData =3D();
>   ///     const NAME: &'static CStr =3D c_str!("myfs");
>   ///     fn super_params(_: &NewSuperBlock<Self>) -> Result<SuperParams<=
Self::Data>> {
>   ///         todo!()
> diff --git a/rust/kernel/mem_cache.rs b/rust/kernel/mem_cache.rs
> index 05e5f2bc9781..bf6ce2d2d3e1 100644
> --- a/rust/kernel/mem_cache.rs
> +++ b/rust/kernel/mem_cache.rs
> @@ -20,7 +20,6 @@ impl MemCache {
>       /// Allocates a new `kmem_cache` for type `T`.
>       ///
>       /// `init` is called by the C code when entries are allocated.
> -    #[allow(dead_code)]
>       pub(crate) fn try_new<T>(
>           name: &'static CStr,
>           init: Option<unsafe extern "C" fn(*mut core::ffi::c_void)>,
> @@ -43,7 +42,6 @@ pub(crate) fn try_new<T>(
>       /// Returns the pointer to the `kmem_cache` instance, or null if it=
's `None`.
>       ///
>       /// This is a helper for functions like `alloc_inode_sb` where the =
cache is optional.
> -    #[allow(dead_code)]
>       pub(crate) fn ptr(c: &Option<Self>) -> *mut bindings::kmem_cache {
>           match c {
>               Some(m) =3D> m.ptr.as_ptr(),
> diff --git a/samples/rust/rust_rofs.rs b/samples/rust/rust_rofs.rs
> index 093425650f26..dfe745439842 100644
> --- a/samples/rust/rust_rofs.rs
> +++ b/samples/rust/rust_rofs.rs
> @@ -53,6 +53,7 @@ struct Entry {
>   struct RoFs;
>   impl fs::FileSystem for RoFs {
>       type Data =3D ();
> +    type INodeData =3D &'static Entry;
>       const NAME: &'static CStr =3D c_str!("rust-fs");
>=20
>       fn super_params(_sb: &NewSuperBlock<Self>) -> Result<SuperParams<Se=
lf::Data>> {
> @@ -79,6 +80,7 @@ fn init_root(sb: &SuperBlock<Self>) -> Result<ARef<INod=
e<Self>>> {
>                   atime: UNIX_EPOCH,
>                   ctime: UNIX_EPOCH,
>                   mtime: UNIX_EPOCH,
> +                value: &ENTRIES[0],
>               }),
>           }
>       }
> @@ -122,6 +124,7 @@ fn lookup(parent: &INode<Self>, name: &[u8]) -> Resul=
t<ARef<INode<Self>>> {
>                           atime: UNIX_EPOCH,
>                           ctime: UNIX_EPOCH,
>                           mtime: UNIX_EPOCH,
> +                        value: e,
>                       }),
>                   };
>               }
> @@ -131,11 +134,7 @@ fn lookup(parent: &INode<Self>, name: &[u8]) -> Resu=
lt<ARef<INode<Self>>> {
>       }
>=20
>       fn read_folio(inode: &INode<Self>, mut folio: LockedFolio<'_>) -> R=
esult {
> -        let data =3D match inode.ino() {
> -            2 =3D> ENTRIES[2].contents,
> -            3 =3D> ENTRIES[3].contents,
> -            _ =3D> return Err(EINVAL),
> -        };
> +        let data =3D inode.data().contents;
>=20
>           let pos =3D usize::try_from(folio.pos()).unwrap_or(usize::MAX);
>           let copied =3D if pos >=3D data.len() {
> --
> 2.34.1
>=20
> 

