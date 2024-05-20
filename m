Return-Path: <linux-fsdevel+bounces-19832-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D4E8CA2C8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 21:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3958EB21B03
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 19:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACFFC137C5A;
	Mon, 20 May 2024 19:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jfv5w/C6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0607F1E878;
	Mon, 20 May 2024 19:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716233901; cv=none; b=gYZ8NScmvRdIrbBjxroFiTN2AgSGdwDOQuSMt6t+Src2k6O4l9VtIRlyi1hsG+wUWCvtWvhAsyMW00dOENOHWzF0juY+qTpsn/1ceD3boGF/h7y/aEWE9tGLR8xZMWAA2u8kIQeqf/6qtZpoWiodcfyiokn6fm2JNqpg4OJVn+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716233901; c=relaxed/simple;
	bh=mFwxHcnKu1CEeeaWmEEHiBTn0+332GiwmLzNdKjPuxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DZ2GTHisrTZakxsGnt2G+U5lB8O7djxWzhZCJ5viN+IacDvNe8PQkbF4brlXgXM4HqIdWI8nNrY466qeUHbI5oZDHbAL7laMaT7SounKGSyWQAZiWuzgODpiZWuii0n5NkL1Dj/+08Ng7xB5zoK+Pm6Coj7UIh4sheF8DS6/sVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jfv5w/C6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7981FC2BD10;
	Mon, 20 May 2024 19:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716233900;
	bh=mFwxHcnKu1CEeeaWmEEHiBTn0+332GiwmLzNdKjPuxc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jfv5w/C6H2HchJM+z58h7XzUaVxKrYyGOX+bH3mKftBR3YvCpHP8Fe+Mtvl7vNTNr
	 P8+GBml8ieP48tZz/0LfdTNr/ypJmBOCxgkuKVEzbR6RDdp5o2T00ZbQqBxZHtLlYM
	 El2Hfd5mhx3pqqKQvtE/0FufB5sKp86lbGKiwSmh1rNAKgeWv8WTX2C2CdKAcgNbd4
	 i+eK41Kf6DozvGiF2v+4r5bTC88IBla6jDxCHjSf1rmDhfEIixORE3FYDdiy4eXYSi
	 UTS8YwotfIy44oX7ObvE1AThnhHERQm/gfEPxYUuPJ3i6zFDBjgOoMetDt2upkN+3K
	 ZefxxplT3g01Q==
Date: Mon, 20 May 2024 12:38:19 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Wedson Almeida Filho <wedsonaf@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Dave Chinner <david@fromorbit.com>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fsdevel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wedson Almeida Filho <walmeida@microsoft.com>
Subject: Re: [RFC PATCH v2 04/30] rust: fs: introduce `FileSystem::fill_super`
Message-ID: <20240520193819.GB25504@frogsfrogsfrogs>
References: <20240514131711.379322-1-wedsonaf@gmail.com>
 <20240514131711.379322-5-wedsonaf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240514131711.379322-5-wedsonaf@gmail.com>

On Tue, May 14, 2024 at 10:16:45AM -0300, Wedson Almeida Filho wrote:
> From: Wedson Almeida Filho <walmeida@microsoft.com>
> 
> Allow Rust file systems to initialise superblocks, which allows them
> to be mounted (though they are still empty).
> 
> Some scaffolding code is added to create an empty directory as the root.
> It is replaced by proper inode creation in a subsequent patch in this
> series.
> 
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> ---
>  rust/bindings/bindings_helper.h |   5 ++
>  rust/kernel/fs.rs               | 147 ++++++++++++++++++++++++++++++--
>  rust/kernel/fs/sb.rs            |  50 +++++++++++
>  samples/rust/rust_rofs.rs       |   6 ++
>  4 files changed, 202 insertions(+), 6 deletions(-)
>  create mode 100644 rust/kernel/fs/sb.rs
> 
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
> index 1bef4dff3019..dabb5a787e0d 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -12,6 +12,7 @@
>  #include <linux/ethtool.h>
>  #include <linux/file.h>
>  #include <linux/fs.h>
> +#include <linux/fs_context.h>
>  #include <linux/jiffies.h>
>  #include <linux/mdio.h>
>  #include <linux/phy.h>
> @@ -32,3 +33,7 @@ const gfp_t RUST_CONST_HELPER___GFP_ZERO = __GFP_ZERO;
>  
>  const slab_flags_t RUST_CONST_HELPER_SLAB_RECLAIM_ACCOUNT = SLAB_RECLAIM_ACCOUNT;
>  const slab_flags_t RUST_CONST_HELPER_SLAB_ACCOUNT = SLAB_ACCOUNT;
> +
> +const unsigned long RUST_CONST_HELPER_SB_RDONLY = SB_RDONLY;
> +
> +const loff_t RUST_CONST_HELPER_MAX_LFS_FILESIZE = MAX_LFS_FILESIZE;
> diff --git a/rust/kernel/fs.rs b/rust/kernel/fs.rs
> index fb7a9b200b85..263b4b6186ae 100644
> --- a/rust/kernel/fs.rs
> +++ b/rust/kernel/fs.rs
> @@ -6,16 +6,30 @@
>  //!
>  //! C headers: [`include/linux/fs.h`](srctree/include/linux/fs.h)
>  
> -use crate::error::{code::*, from_result, to_result, Error};
> +use crate::error::{code::*, from_result, to_result, Error, Result};
>  use crate::types::Opaque;
>  use crate::{bindings, init::PinInit, str::CStr, try_pin_init, ThisModule};
>  use core::{ffi, marker::PhantomData, pin::Pin};
>  use macros::{pin_data, pinned_drop};
> +use sb::SuperBlock;
> +
> +pub mod sb;
> +
> +/// The offset of a file in a file system.

This is really the position of some data within a file, in bytes.

> +///
> +/// This is C's `loff_t`.
> +pub type Offset = i64;

Ergh, I really wish this was loff (or LOff if we're really doing
camelcase for rust code) for somewhat better greppability.

> +
> +/// Maximum size of an inode.
> +pub const MAX_LFS_FILESIZE: Offset = bindings::MAX_LFS_FILESIZE;
>  
>  /// A file system type.
>  pub trait FileSystem {
>      /// The name of the file system type.
>      const NAME: &'static CStr;
> +
> +    /// Initialises the new superblock.
> +    fn fill_super(sb: &mut SuperBlock<Self>) -> Result;
>  }
>  
>  /// A registration of a file system.
> @@ -46,7 +60,7 @@ pub fn new<T: FileSystem + ?Sized>(module: &'static ThisModule) -> impl PinInit<
>                  let fs = unsafe { &mut *fs_ptr };
>                  fs.owner = module.0;
>                  fs.name = T::NAME.as_char_ptr();
> -                fs.init_fs_context = Some(Self::init_fs_context_callback);
> +                fs.init_fs_context = Some(Self::init_fs_context_callback::<T>);
>                  fs.kill_sb = Some(Self::kill_sb_callback);
>                  fs.fs_flags = 0;
>  
> @@ -57,11 +71,22 @@ pub fn new<T: FileSystem + ?Sized>(module: &'static ThisModule) -> impl PinInit<
>          })
>      }
>  
> -    unsafe extern "C" fn init_fs_context_callback(_fc: *mut bindings::fs_context) -> ffi::c_int {
> -        from_result(|| Err(ENOTSUPP))
> +    unsafe extern "C" fn init_fs_context_callback<T: FileSystem + ?Sized>(
> +        fc_ptr: *mut bindings::fs_context,
> +    ) -> ffi::c_int {
> +        from_result(|| {
> +            // SAFETY: The C callback API guarantees that `fc_ptr` is valid.
> +            let fc = unsafe { &mut *fc_ptr };
> +            fc.ops = &Tables::<T>::CONTEXT;
> +            Ok(0)
> +        })
>      }
>  
> -    unsafe extern "C" fn kill_sb_callback(_sb_ptr: *mut bindings::super_block) {}
> +    unsafe extern "C" fn kill_sb_callback(sb_ptr: *mut bindings::super_block) {
> +        // SAFETY: In `get_tree_callback` we always call `get_tree_nodev`, so `kill_anon_super` is
> +        // the appropriate function to call for cleanup.
> +        unsafe { bindings::kill_anon_super(sb_ptr) };
> +    }
>  }
>  
>  #[pinned_drop]
> @@ -74,6 +99,113 @@ fn drop(self: Pin<&mut Self>) {
>      }
>  }
>  
> +struct Tables<T: FileSystem + ?Sized>(T);
> +impl<T: FileSystem + ?Sized> Tables<T> {
> +    const CONTEXT: bindings::fs_context_operations = bindings::fs_context_operations {
> +        free: None,
> +        parse_param: None,
> +        get_tree: Some(Self::get_tree_callback),
> +        reconfigure: None,
> +        parse_monolithic: None,
> +        dup: None,
> +    };
> +
> +    unsafe extern "C" fn get_tree_callback(fc: *mut bindings::fs_context) -> ffi::c_int {
> +        // SAFETY: `fc` is valid per the callback contract. `fill_super_callback` also has
> +        // the right type and is a valid callback.
> +        unsafe { bindings::get_tree_nodev(fc, Some(Self::fill_super_callback)) }
> +    }
> +
> +    unsafe extern "C" fn fill_super_callback(
> +        sb_ptr: *mut bindings::super_block,
> +        _fc: *mut bindings::fs_context,
> +    ) -> ffi::c_int {
> +        from_result(|| {
> +            // SAFETY: The callback contract guarantees that `sb_ptr` is a unique pointer to a
> +            // newly-created superblock.
> +            let new_sb = unsafe { SuperBlock::from_raw_mut(sb_ptr) };
> +
> +            // SAFETY: The callback contract guarantees that `sb_ptr`, from which `new_sb` is
> +            // derived, is valid for write.
> +            let sb = unsafe { &mut *new_sb.0.get() };
> +            sb.s_op = &Tables::<T>::SUPER_BLOCK;
> +            sb.s_flags |= bindings::SB_RDONLY;
> +
> +            T::fill_super(new_sb)?;
> +
> +            // The following is scaffolding code that will be removed in a subsequent patch. It is
> +            // needed to build a root dentry, otherwise core code will BUG().
> +            // SAFETY: `sb` is the superblock being initialised, it is valid for read and write.
> +            let inode = unsafe { bindings::new_inode(sb) };
> +            if inode.is_null() {
> +                return Err(ENOMEM);
> +            }
> +
> +            // SAFETY: `inode` is valid for write.
> +            unsafe { bindings::set_nlink(inode, 2) };
> +
> +            {
> +                // SAFETY: This is a newly-created inode. No other references to it exist, so it is
> +                // safe to mutably dereference it.
> +                let inode = unsafe { &mut *inode };
> +                inode.i_ino = 1;
> +                inode.i_mode = (bindings::S_IFDIR | 0o755) as _;
> +
> +                // SAFETY: `simple_dir_operations` never changes, it's safe to reference it.
> +                inode.__bindgen_anon_3.i_fop = unsafe { &bindings::simple_dir_operations };

                         ^^^^^^^^^^^^^^^^
This is a gross way to handle anonymous struct fields.  What happens
when struct inode changes and we have to do a giant treewide sed?

(and yes, I understand that's likely going to be a rustc change...)

--D

> +
> +                // SAFETY: `simple_dir_inode_operations` never changes, it's safe to reference it.
> +                inode.i_op = unsafe { &bindings::simple_dir_inode_operations };
> +            }
> +
> +            // SAFETY: `d_make_root` requires that `inode` be valid and referenced, which is the
> +            // case for this call.
> +            //
> +            // It takes over the inode, even on failure, so we don't need to clean it up.
> +            let dentry = unsafe { bindings::d_make_root(inode) };
> +            if dentry.is_null() {
> +                return Err(ENOMEM);
> +            }
> +
> +            sb.s_root = dentry;
> +
> +            Ok(0)
> +        })
> +    }
> +
> +    const SUPER_BLOCK: bindings::super_operations = bindings::super_operations {
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
>  /// Kernel module that exposes a single file system implemented by `T`.
>  #[pin_data]
>  pub struct Module<T: FileSystem + ?Sized> {
> @@ -100,7 +232,7 @@ fn init(module: &'static ThisModule) -> impl PinInit<Self, Error> {
>  ///
>  /// ```
>  /// # mod module_fs_sample {
> -/// use kernel::fs;
> +/// use kernel::fs::{sb::SuperBlock, self};
>  /// use kernel::prelude::*;
>  ///
>  /// kernel::module_fs! {
> @@ -114,6 +246,9 @@ fn init(module: &'static ThisModule) -> impl PinInit<Self, Error> {
>  /// struct MyFs;
>  /// impl fs::FileSystem for MyFs {
>  ///     const NAME: &'static CStr = kernel::c_str!("myfs");
> +///     fn fill_super(_: &mut SuperBlock<Self>) -> Result {
> +///         todo!()
> +///     }
>  /// }
>  /// # }
>  /// ```
> diff --git a/rust/kernel/fs/sb.rs b/rust/kernel/fs/sb.rs
> new file mode 100644
> index 000000000000..113d3c0d8148
> --- /dev/null
> +++ b/rust/kernel/fs/sb.rs
> @@ -0,0 +1,50 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! File system super blocks.
> +//!
> +//! This module allows Rust code to use superblocks.
> +//!
> +//! C headers: [`include/linux/fs.h`](srctree/include/linux/fs.h)
> +
> +use super::FileSystem;
> +use crate::{bindings, types::Opaque};
> +use core::marker::PhantomData;
> +
> +/// A file system super block.
> +///
> +/// Wraps the kernel's `struct super_block`.
> +#[repr(transparent)]
> +pub struct SuperBlock<T: FileSystem + ?Sized>(
> +    pub(crate) Opaque<bindings::super_block>,
> +    PhantomData<T>,
> +);
> +
> +impl<T: FileSystem + ?Sized> SuperBlock<T> {
> +    /// Creates a new superblock mutable reference from the given raw pointer.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Callers must ensure that:
> +    ///
> +    /// * `ptr` is valid and remains so for the lifetime of the returned object.
> +    /// * `ptr` has the correct file system type.
> +    /// * `ptr` is the only active pointer to the superblock.
> +    pub(crate) unsafe fn from_raw_mut<'a>(ptr: *mut bindings::super_block) -> &'a mut Self {
> +        // SAFETY: The safety requirements guarantee that the cast below is ok.
> +        unsafe { &mut *ptr.cast::<Self>() }
> +    }
> +
> +    /// Returns whether the superblock is mounted in read-only mode.
> +    pub fn rdonly(&self) -> bool {
> +        // SAFETY: `s_flags` only changes during init, so it is safe to read it.
> +        unsafe { (*self.0.get()).s_flags & bindings::SB_RDONLY != 0 }
> +    }
> +
> +    /// Sets the magic number of the superblock.
> +    pub fn set_magic(&mut self, magic: usize) -> &mut Self {
> +        // SAFETY: This is a new superblock that is being initialised, so it's ok to write to its
> +        // fields.
> +        unsafe { (*self.0.get()).s_magic = magic as core::ffi::c_ulong };
> +        self
> +    }
> +}
> diff --git a/samples/rust/rust_rofs.rs b/samples/rust/rust_rofs.rs
> index d465b107a07d..022addf68891 100644
> --- a/samples/rust/rust_rofs.rs
> +++ b/samples/rust/rust_rofs.rs
> @@ -2,6 +2,7 @@
>  
>  //! Rust read-only file system sample.
>  
> +use kernel::fs::sb;
>  use kernel::prelude::*;
>  use kernel::{c_str, fs};
>  
> @@ -16,4 +17,9 @@
>  struct RoFs;
>  impl fs::FileSystem for RoFs {
>      const NAME: &'static CStr = c_str!("rust_rofs");
> +
> +    fn fill_super(sb: &mut sb::SuperBlock<Self>) -> Result {
> +        sb.set_magic(0x52555354);
> +        Ok(())
> +    }
>  }
> -- 
> 2.34.1
> 
> 

