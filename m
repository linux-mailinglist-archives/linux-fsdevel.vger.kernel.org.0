Return-Path: <linux-fsdevel+bounces-868-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA9317D1BC1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Oct 2023 10:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F11C1F21EC4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Oct 2023 08:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B61B0D511;
	Sat, 21 Oct 2023 08:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="eENk317K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D86D521;
	Sat, 21 Oct 2023 08:33:18 +0000 (UTC)
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD1BF99;
	Sat, 21 Oct 2023 01:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1697877190; x=1698136390;
	bh=evNZfUZewebke5VF7D/J1Y0A1uXIGodpSi0YOrrzLRU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=eENk317KIqmHDOI2GMHGGglwzNn4WYz8eF7XrsmkWl2Z1yvIZvSQFIr/wAr6KzCxg
	 YRzYwZYMrnSWPcxfVyijt3MVJCzq3ewvWIv8f02BWFs5qp+TLN7tI3mjit9lUOc41a
	 hEhYIRKA467WYe9y+WVOBmt5ovuLviImytYlOXbphtuCP+uPPdkpS3Yn5MfxKQXZhH
	 Y3JzZ9GFU4WWBcJOjk6Sq/wGZsX0NKhVJCWxJWXmglPFu4GUcDkK3tRm87R6Lchdg0
	 WfZ7OMQIYqVm6g+9cnwePVCcjfUGD9WN6HWscw/P4+Y2bGDtugjLIvKXfIx4ctH07O
	 Bq6YGLffWQHwQ==
Date: Sat, 21 Oct 2023 08:33:07 +0000
To: Wedson Almeida Filho <wedsonaf@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Matthew Wilcox <willy@infradead.org>, Kent Overstreet <kent.overstreet@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-fsdevel@vger.kernel.org, rust-for-linux@vger.kernel.org, Wedson Almeida Filho <walmeida@microsoft.com>
Subject: Re: [RFC PATCH 07/19] rust: fs: introduce `FileSystem::read_dir`
Message-ID: <33R0DFqZ0Tuc1nSu5Gsqta5UX7jnjkdSMG608vlN-_Vye2igSRvCFHW1A631lygFhAG_uz5EMkNXApNbvMdiZfs3a8otPZQ0ZXW-AJ7Dies=@proton.me>
In-Reply-To: <20231018122518.128049-8-wedsonaf@gmail.com>
References: <20231018122518.128049-1-wedsonaf@gmail.com> <20231018122518.128049-8-wedsonaf@gmail.com>
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
> Allow Rust file systems to report the contents of their directory
> inodes. The reported entries cannot be opened yet.
>=20
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> ---
>   rust/kernel/fs.rs         | 193 +++++++++++++++++++++++++++++++++++++-
>   samples/rust/rust_rofs.rs |  49 +++++++++-
>   2 files changed, 236 insertions(+), 6 deletions(-)
>=20
> diff --git a/rust/kernel/fs.rs b/rust/kernel/fs.rs
> index f3a41cf57502..89611c44e4c5 100644
> --- a/rust/kernel/fs.rs
> +++ b/rust/kernel/fs.rs
> @@ -28,6 +28,70 @@ pub trait FileSystem {
>       /// This is called during initialisation of a superblock after [`Fi=
leSystem::super_params`] has
>       /// completed successfully.
>       fn init_root(sb: &SuperBlock<Self>) -> Result<ARef<INode<Self>>>;
> +
> +    /// Reads directory entries from directory inodes.
> +    ///
> +    /// [`DirEmitter::pos`] holds the current position of the directory =
reader.
> +    fn read_dir(inode: &INode<Self>, emitter: &mut DirEmitter) -> Result=
;
> +}
> +
> +/// The types of directory entries reported by [`FileSystem::read_dir`].
> +#[repr(u32)]
> +#[derive(Copy, Clone)]
> +pub enum DirEntryType {
> +    /// Unknown type.
> +    Unknown =3D bindings::DT_UNKNOWN,
> +
> +    /// Named pipe (first-in, first-out) type.
> +    Fifo =3D bindings::DT_FIFO,
> +
> +    /// Character device type.
> +    Chr =3D bindings::DT_CHR,
> +
> +    /// Directory type.
> +    Dir =3D bindings::DT_DIR,
> +
> +    /// Block device type.
> +    Blk =3D bindings::DT_BLK,
> +
> +    /// Regular file type.
> +    Reg =3D bindings::DT_REG,
> +
> +    /// Symbolic link type.
> +    Lnk =3D bindings::DT_LNK,
> +
> +    /// Named unix-domain socket type.
> +    Sock =3D bindings::DT_SOCK,
> +
> +    /// White-out type.
> +    Wht =3D bindings::DT_WHT,
> +}
> +
> +impl From<INodeType> for DirEntryType {
> +    fn from(value: INodeType) -> Self {
> +        match value {
> +            INodeType::Dir =3D> DirEntryType::Dir,
> +        }
> +    }
> +}
> +
> +impl core::convert::TryFrom<u32> for DirEntryType {
> +    type Error =3D crate::error::Error;
> +
> +    fn try_from(v: u32) -> Result<Self> {
> +        match v {
> +            v if v =3D=3D Self::Unknown as u32 =3D> Ok(Self::Unknown),
> +            v if v =3D=3D Self::Fifo as u32 =3D> Ok(Self::Fifo),
> +            v if v =3D=3D Self::Chr as u32 =3D> Ok(Self::Chr),
> +            v if v =3D=3D Self::Dir as u32 =3D> Ok(Self::Dir),
> +            v if v =3D=3D Self::Blk as u32 =3D> Ok(Self::Blk),
> +            v if v =3D=3D Self::Reg as u32 =3D> Ok(Self::Reg),
> +            v if v =3D=3D Self::Lnk as u32 =3D> Ok(Self::Lnk),
> +            v if v =3D=3D Self::Sock as u32 =3D> Ok(Self::Sock),
> +            v if v =3D=3D Self::Wht as u32 =3D> Ok(Self::Wht),
> +            _ =3D> Err(EDOM),
> +        }
> +    }
>   }
>=20
>   /// A registration of a file system.
> @@ -161,9 +225,7 @@ pub fn init(self, params: INodeParams) -> Result<ARef=
<INode<T>>> {
>=20
>           let mode =3D match params.typ {
>               INodeType::Dir =3D> {
> -                // SAFETY: `simple_dir_operations` never changes, it's s=
afe to reference it.
> -                inode.__bindgen_anon_3.i_fop =3D unsafe { &bindings::sim=
ple_dir_operations };
> -
> +                inode.__bindgen_anon_3.i_fop =3D &Tables::<T>::DIR_FILE_=
OPERATIONS;
>                   // SAFETY: `simple_dir_inode_operations` never changes,=
 it's safe to reference it.
>                   inode.i_op =3D unsafe { &bindings::simple_dir_inode_ope=
rations };
>                   bindings::S_IFDIR
> @@ -403,6 +465,126 @@ impl<T: FileSystem + ?Sized> Tables<T> {
>           free_cached_objects: None,
>           shutdown: None,
>       };
> +
> +    const DIR_FILE_OPERATIONS: bindings::file_operations =3D bindings::f=
ile_operations {
> +        owner: ptr::null_mut(),
> +        llseek: Some(bindings::generic_file_llseek),
> +        read: Some(bindings::generic_read_dir),
> +        write: None,
> +        read_iter: None,
> +        write_iter: None,
> +        iopoll: None,
> +        iterate_shared: Some(Self::read_dir_callback),
> +        poll: None,
> +        unlocked_ioctl: None,
> +        compat_ioctl: None,
> +        mmap: None,
> +        mmap_supported_flags: 0,
> +        open: None,
> +        flush: None,
> +        release: None,
> +        fsync: None,
> +        fasync: None,
> +        lock: None,
> +        get_unmapped_area: None,
> +        check_flags: None,
> +        flock: None,
> +        splice_write: None,
> +        splice_read: None,
> +        splice_eof: None,
> +        setlease: None,
> +        fallocate: None,
> +        show_fdinfo: None,
> +        copy_file_range: None,
> +        remap_file_range: None,
> +        fadvise: None,
> +        uring_cmd: None,
> +        uring_cmd_iopoll: None,
> +    };
> +
> +    unsafe extern "C" fn read_dir_callback(
> +        file: *mut bindings::file,
> +        ctx_ptr: *mut bindings::dir_context,
> +    ) -> core::ffi::c_int {
> +        from_result(|| {
> +            // SAFETY: The C API guarantees that `file` is valid for rea=
d. And since `f_inode` is
> +            // immutable, we can read it directly.
> +            let inode =3D unsafe { &*(*file).f_inode.cast::<INode<T>>() =
};
> +
> +            // SAFETY: The C API guarantees that this is the only refere=
nce to the `dir_context`
> +            // instance.
> +            let emitter =3D unsafe { &mut *ctx_ptr.cast::<DirEmitter>() =
};
> +            let orig_pos =3D emitter.pos();
> +
> +            // Call the module implementation. We ignore errors if direc=
tory entries have been
> +            // succesfully emitted: this is because we want users to see=
 them before the error.
> +            match T::read_dir(inode, emitter) {
> +                Ok(_) =3D> Ok(0),
> +                Err(e) =3D> {
> +                    if emitter.pos() =3D=3D orig_pos {
> +                        Err(e)
> +                    } else {
> +                        Ok(0)
> +                    }
> +                }
> +            }
> +        })
> +    }
> +}
> +
> +/// Directory entry emitter.
> +///
> +/// This is used in [`FileSystem::read_dir`] implementations to report t=
he directory entry.
> +#[repr(transparent)]
> +pub struct DirEmitter(bindings::dir_context);

No `Opaque`?

> +
> +impl DirEmitter {
> +    /// Returns the current position of the emitter.
> +    pub fn pos(&self) -> i64 {
> +        self.0.pos
> +    }
> +
> +    /// Emits a directory entry.
> +    ///
> +    /// `pos_inc` is the number with which to increment the current posi=
tion on success.
> +    ///
> +    /// `name` is the name of the entry.
> +    ///
> +    /// `ino` is the inode number of the entry.
> +    ///
> +    /// `etype` is the type of the entry.

It might make sense to create a struct for all these parameters.

> +    ///
> +    /// Returns `false` when the entry could not be emitted, possibly be=
cause the user-provided
> +    /// buffer is full.
> +    pub fn emit(&mut self, pos_inc: i64, name: &[u8], ino: Ino, etype: D=
irEntryType) -> bool {
> +        let Ok(name_len) =3D i32::try_from(name.len()) else {
> +            return false;
> +        };
> +
> +        let Some(actor) =3D self.0.actor else {
> +            return false;
> +        };
> +
> +        let Some(new_pos) =3D self.0.pos.checked_add(pos_inc) else {
> +            return false;
> +        };
> +
> +        // SAFETY: `name` is valid at least for the duration of the `act=
or` call.

What about `&mut self.0`?  Since this is a function pointer, can we
really be sure about the safety requirements?

--=20
Cheers,
Benno

> +        let ret =3D unsafe {
> +            actor(
> +                &mut self.0,
> +                name.as_ptr().cast(),
> +                name_len,
> +                self.0.pos,
> +                ino,
> +                etype as _,
> +            )
> +        };
> +        if ret {
> +            self.0.pos =3D new_pos;
> +        }
> +        ret
> +    }
>   }
>=20
>   /// Kernel module that exposes a single file system implemented by `T`.
> @@ -431,7 +613,7 @@ fn init(module: &'static ThisModule) -> impl PinInit<=
Self, Error> {
>   ///
>   /// ```
>   /// # mod module_fs_sample {
> -/// use kernel::fs::{INode, NewSuperBlock, SuperBlock, SuperParams};
> +/// use kernel::fs::{DirEmitter, INode, NewSuperBlock, SuperBlock, Super=
Params};
>   /// use kernel::prelude::*;
>   /// use kernel::{c_str, fs, types::ARef};
>   ///
> @@ -452,6 +634,9 @@ fn init(module: &'static ThisModule) -> impl PinInit<=
Self, Error> {
>   ///     fn init_root(_sb: &SuperBlock<Self>) -> Result<ARef<INode<Self>=
>> {
>   ///         todo!()
>   ///     }
> +///     fn read_dir(_: &INode<Self>, _: &mut DirEmitter) -> Result {
> +///         todo!()
> +///     }
>   /// }
>   /// # }
>   /// ```
> diff --git a/samples/rust/rust_rofs.rs b/samples/rust/rust_rofs.rs
> index 9e5f4c7d1c06..4e61a94afa70 100644
> --- a/samples/rust/rust_rofs.rs
> +++ b/samples/rust/rust_rofs.rs
> @@ -2,7 +2,9 @@
>=20
>   //! Rust read-only file system sample.
>=20
> -use kernel::fs::{INode, INodeParams, INodeType, NewSuperBlock, SuperBloc=
k, SuperParams};
> +use kernel::fs::{
> +    DirEmitter, INode, INodeParams, INodeType, NewSuperBlock, SuperBlock=
, SuperParams,
> +};
>   use kernel::prelude::*;
>   use kernel::{c_str, fs, time::UNIX_EPOCH, types::ARef, types::Either};
>=20
> @@ -14,6 +16,30 @@
>       license: "GPL",
>   }
>=20
> +struct Entry {
> +    name: &'static [u8],
> +    ino: u64,
> +    etype: INodeType,
> +}
> +
> +const ENTRIES: [Entry; 3] =3D [
> +    Entry {
> +        name: b".",
> +        ino: 1,
> +        etype: INodeType::Dir,
> +    },
> +    Entry {
> +        name: b"..",
> +        ino: 1,
> +        etype: INodeType::Dir,
> +    },
> +    Entry {
> +        name: b"subdir",
> +        ino: 2,
> +        etype: INodeType::Dir,
> +    },
> +];
> +
>   struct RoFs;
>   impl fs::FileSystem for RoFs {
>       const NAME: &'static CStr =3D c_str!("rust-fs");
> @@ -33,7 +59,7 @@ fn init_root(sb: &SuperBlock<Self>) -> Result<ARef<INod=
e<Self>>> {
>               Either::Right(new) =3D> new.init(INodeParams {
>                   typ: INodeType::Dir,
>                   mode: 0o555,
> -                size: 1,
> +                size: ENTRIES.len().try_into()?,
>                   blocks: 1,
>                   nlink: 2,
>                   uid: 0,
> @@ -44,4 +70,23 @@ fn init_root(sb: &SuperBlock<Self>) -> Result<ARef<INo=
de<Self>>> {
>               }),
>           }
>       }
> +
> +    fn read_dir(inode: &INode<Self>, emitter: &mut DirEmitter) -> Result=
 {
> +        if inode.ino() !=3D 1 {
> +            return Ok(());
> +        }
> +
> +        let pos =3D emitter.pos();
> +        if pos >=3D ENTRIES.len().try_into()? {
> +            return Ok(());
> +        }
> +
> +        for e in ENTRIES.iter().skip(pos.try_into()?) {
> +            if !emitter.emit(1, e.name, e.ino, e.etype.into()) {
> +                break;
> +            }
> +        }
> +
> +        Ok(())
> +    }
>   }
> --
> 2.34.1
>=20
> 

