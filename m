Return-Path: <linux-fsdevel+bounces-19831-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6050E8CA2C1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 21:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15BBF281FAE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 19:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9073137C5A;
	Mon, 20 May 2024 19:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kqO9hlHX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6F21A702;
	Mon, 20 May 2024 19:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716233580; cv=none; b=fUdkpQ2cq0vMWrgNqNzWljZAh122IS6iVMSx9la9sbxBDRPWFxfjDmKtBXC8s8K5kjlXGQcE1p4U7Q+YhK1xN3i/Fgfq0x6iOmfBjq1Ye434ASreiUKy73kzpL7KUP604VxkqzHlODdrCaioHcLWLKaux7c8QApyIcy1SE5kbvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716233580; c=relaxed/simple;
	bh=K+CbTSDdaFiFCCQrwMTfpxLauy8/9Znl2uOKZFiiJXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ffKke/axD9cdnzOI2AyXdwABprX76rkpzQLpui9bwdr1rt1qv+HLm+6z99YEFUv+Aq5N8blmgD3gouLjtq4zSR8prMw8D8RTMQHj2rD4Xz0MugGL7eGV5AEBd15GPpDqu6ZdIjrm80WAg2Q1ptUnjCmyYHvBGwQ3EXYof38EOOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kqO9hlHX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93BE5C2BD10;
	Mon, 20 May 2024 19:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716233579;
	bh=K+CbTSDdaFiFCCQrwMTfpxLauy8/9Znl2uOKZFiiJXk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kqO9hlHXQHiErJIQjNfXYCzquU0kJDhqkMOyBh1NBM4yikKJia70tHv61l9PcXdnI
	 drdVEGBtllhN7tAnx6yuW7GEXcm4ZpLToJsVWaHuyxpjfsxKcsrWVu0IcS7N/sNMZh
	 hS6sbzrn6nBYIIDruPOGwiEEUkFxjxoxFp/ndP0HdbBYIhQuOM3kbUKijs7bgFn/EK
	 jB7KpNBFI4i/zcQjLDTy6gBlbMGGba+vISqwRBROlaHmsJ7v1/4tm5GwD2HcOdNMlE
	 hYGRRHDkwH4Ph5JPjS9XJeK5BGVPhXC9gNWxg/+t2j47jVSvM3Yt3GnKJETRLjq10d
	 CyY1P/lfkCBaA==
Date: Mon, 20 May 2024 12:32:58 -0700
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
Subject: Re: [RFC PATCH v2 27/30] rust: fs: add `iomap` module
Message-ID: <20240520193258.GA25504@frogsfrogsfrogs>
References: <20240514131711.379322-1-wedsonaf@gmail.com>
 <20240514131711.379322-28-wedsonaf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240514131711.379322-28-wedsonaf@gmail.com>

On Tue, May 14, 2024 at 10:17:08AM -0300, Wedson Almeida Filho wrote:
> From: Wedson Almeida Filho <walmeida@microsoft.com>
> 
> Allow file systems to implement their address space operations via
> iomap, which delegates a lot of the complexity to common code.
> 
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> ---
>  rust/bindings/bindings_helper.h |   1 +
>  rust/kernel/fs.rs               |   1 +
>  rust/kernel/fs/iomap.rs         | 281 ++++++++++++++++++++++++++++++++
>  3 files changed, 283 insertions(+)
>  create mode 100644 rust/kernel/fs/iomap.rs
> 
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
> index f4c7c3951dbe..629fce394dbe 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -13,6 +13,7 @@
>  #include <linux/file.h>
>  #include <linux/fs.h>
>  #include <linux/fs_context.h>
> +#include <linux/iomap.h>
>  #include <linux/jiffies.h>
>  #include <linux/mdio.h>
>  #include <linux/pagemap.h>
> diff --git a/rust/kernel/fs.rs b/rust/kernel/fs.rs
> index 4d90b23735bc..7a1c4884c370 100644
> --- a/rust/kernel/fs.rs
> +++ b/rust/kernel/fs.rs
> @@ -19,6 +19,7 @@
>  pub mod dentry;
>  pub mod file;
>  pub mod inode;
> +pub mod iomap;
>  pub mod sb;
>  
>  /// The offset of a file in a file system.
> diff --git a/rust/kernel/fs/iomap.rs b/rust/kernel/fs/iomap.rs
> new file mode 100644
> index 000000000000..e48e200e555e
> --- /dev/null
> +++ b/rust/kernel/fs/iomap.rs
> @@ -0,0 +1,281 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! File system io maps.

iomap is really more of a space mapping library for filesystems at this
point.  Most of the code supports IO to pmem or block devices, but some
of the pieces (e.g. swapfile, FIEMAP, llseek) aren't the IO path.

> +//!
> +//! This module allows Rust code to use iomaps to implement filesystems.
> +//!
> +//! C headers: [`include/linux/iomap.h`](srctree/include/linux/iomap.h)
> +
> +use super::{address_space, FileSystem, INode, Offset};
> +use crate::error::{from_result, Result};
> +use crate::{bindings, block};
> +use core::marker::PhantomData;
> +
> +/// The type of mapping.
> +///
> +/// This is used in [`Map`].
> +#[repr(u16)]
> +pub enum Type {
> +    /// No blocks allocated, need allocation.
> +    Hole = bindings::IOMAP_HOLE as u16,
> +
> +    /// Delayed allocation blocks.
> +    DelAlloc = bindings::IOMAP_DELALLOC as u16,
> +
> +    /// Blocks allocated at the given address.
> +    Mapped = bindings::IOMAP_MAPPED as u16,
> +
> +    /// Blocks allocated at the given address in unwritten state.
> +    Unwritten = bindings::IOMAP_UNWRITTEN as u16,
> +
> +    /// Data inline in the inode.
> +    Inline = bindings::IOMAP_INLINE as u16,
> +}
> +
> +/// Flags usable in [`Map`], in [`Map::set_flags`] in particular.
> +pub mod map_flags {
> +    /// Indicates that the blocks have been newly allocated and need zeroing for areas that no data
> +    /// is copied to.
> +    pub const NEW: u16 = bindings::IOMAP_F_NEW as u16;
> +
> +    /// Indicates that the inode has uncommitted metadata needed to access written data and
> +    /// requires fdatasync to commit them to persistent storage. This needs to take into account
> +    /// metadata changes that *may* be made at IO completion, such as file size updates from direct
> +    /// IO.
> +    pub const DIRTY: u16 = bindings::IOMAP_F_DIRTY as u16;
> +
> +    /// Indicates that the blocks are shared, and will need to be unshared as part a write.
> +    pub const SHARED: u16 = bindings::IOMAP_F_SHARED as u16;
> +
> +    /// Indicates that the iomap contains the merge of multiple block mappings.
> +    pub const MERGED: u16 = bindings::IOMAP_F_MERGED as u16;
> +
> +    /// Indicates that the file system requires the use of buffer heads for this mapping.
> +    pub const BUFFER_HEAD: u16 = bindings::IOMAP_F_BUFFER_HEAD as u16;

Maybe leave this one commented out; we don't really want new filesystems
to use bufferhead support in iomap.

> +
> +    /// Indicates that the iomap is for an extended attribute extent rather than a file data
> +    /// extent.
> +    pub const XATTR: u16 = bindings::IOMAP_F_XATTR as u16;
> +
> +    /// Indicates to the iomap_end method that the file size has changed as the result of this
> +    /// write operation.
> +    pub const SIZE_CHANGED: u16 = bindings::IOMAP_F_SIZE_CHANGED as u16;
> +
> +    /// Indicates that the iomap is not valid any longer and the file range it covers needs to be
> +    /// remapped by the high level before the operation can proceed.
> +    pub const STALE: u16 = bindings::IOMAP_F_STALE as u16;
> +
> +    /// Flags from 0x1000 up are for file system specific usage.
> +    pub const PRIVATE: u16 = bindings::IOMAP_F_PRIVATE as u16;
> +}
> +
> +/// A map from address space to block device.

It's a mapping from a range of a file to space on a storage device.
Storage devices can include pmem and whatever inlinedata does.  Though I
guess you don't support fsdax.

> +#[repr(transparent)]
> +pub struct Map<'a>(pub bindings::iomap, PhantomData<&'a ()>);
> +
> +impl<'a> Map<'a> {
> +    /// Sets the map type.
> +    pub fn set_type(&mut self, t: Type) -> &mut Self {
> +        self.0.type_ = t as u16;
> +        self
> +    }
> +
> +    /// Sets the file offset, in bytes.
> +    pub fn set_offset(&mut self, v: Offset) -> &mut Self {
> +        self.0.offset = v;
> +        self
> +    }
> +
> +    /// Sets the length of the mapping, in bytes.
> +    pub fn set_length(&mut self, len: u64) -> &mut Self {
> +        self.0.length = len;
> +        self
> +    }
> +
> +    /// Sets the mapping flags.
> +    ///
> +    /// Values come from the [`map_flags`] module.
> +    pub fn set_flags(&mut self, flags: u16) -> &mut Self {
> +        self.0.flags = flags;
> +        self
> +    }
> +
> +    /// Sets the disk offset of the mapping, in bytes.
> +    pub fn set_addr(&mut self, addr: u64) -> &mut Self {
> +        self.0.addr = addr;
> +        self
> +    }
> +
> +    /// Sets the block device of the mapping.
> +    pub fn set_bdev(&mut self, bdev: Option<&'a block::Device>) -> &mut Self {
> +        self.0.bdev = if let Some(b) = bdev {
> +            b.0.get()
> +        } else {
> +            core::ptr::null_mut()
> +        };
> +        self
> +    }
> +}
> +
> +/// Flags passed to [`Operations::begin`] and [`Operations::end`].
> +pub mod flags {
> +    /// Writing, must allocate block.
> +    pub const WRITE: u32 = bindings::IOMAP_WRITE;
> +
> +    /// Zeroing operation, may skip holes.
> +    pub const ZERO: u32 = bindings::IOMAP_ZERO;
> +
> +    /// Report extent status, e.g. FIEMAP.
> +    pub const REPORT: u32 = bindings::IOMAP_REPORT;
> +
> +    /// Mapping for page fault.
> +    pub const FAULT: u32 = bindings::IOMAP_FAULT;
> +
> +    /// Direct I/O.
> +    pub const DIRECT: u32 = bindings::IOMAP_DIRECT;
> +
> +    /// Do not block.
> +    pub const NOWAIT: u32 = bindings::IOMAP_NOWAIT;
> +
> +    /// Only pure overwrites allowed.
> +    pub const OVERWRITE_ONLY: u32 = bindings::IOMAP_OVERWRITE_ONLY;
> +
> +    /// `unshare_file_range`.
> +    pub const UNSHARE: u32 = bindings::IOMAP_UNSHARE;
> +
> +    /// DAX mapping.
> +    pub const DAX: u32 = bindings::IOMAP_DAX;
> +}

I wonder, how hard will it be to update/regenerate these bindings when
someone wants to add new features to the C iomap implementation?  IIRC
Ritesh's port of C ext2 to iomap adds a boundary flag somewhere.

> +
> +/// Operations implemented by iomap users.
> +pub trait Operations {
> +    /// File system that these operations are compatible with.
> +    type FileSystem: FileSystem + ?Sized;
> +
> +    /// Returns the existing mapping at `pos`, or reserves space starting at `pos` for up to
> +    /// `length`, as long as it can be done as a single mapping. The actual length is returned in
> +    /// `iomap`.
> +    ///
> +    /// The values of `flags` come from the [`flags`] module.
> +    fn begin<'a>(
> +        inode: &'a INode<Self::FileSystem>,
> +        pos: Offset,
> +        length: Offset,
> +        flags: u32,
> +        map: &mut Map<'a>,
> +        srcmap: &mut Map<'a>,
> +    ) -> Result;
> +
> +    /// Commits and/or unreserves space previously allocated using [`Operations::begin`]. `writte`n

`written`

> +    /// indicates the length of the successful write operation which needs to be commited, while
> +    /// the rest needs to be unreserved. `written` might be zero if no data was written.
> +    ///
> +    /// The values of `flags` come from the [`flags`] module.
> +    fn end<'a>(
> +        _inode: &'a INode<Self::FileSystem>,
> +        _pos: Offset,
> +        _length: Offset,
> +        _written: isize,
> +        _flags: u32,
> +        _map: &Map<'a>,
> +    ) -> Result {
> +        Ok(())
> +    }
> +}
> +
> +/// Returns address space oprerations backed by iomaps.
> +pub const fn ro_aops<T: Operations + ?Sized>() -> address_space::Ops<T::FileSystem> {
> +    struct Table<T: Operations + ?Sized>(PhantomData<T>);
> +    impl<T: Operations + ?Sized> Table<T> {
> +        const MAP_TABLE: bindings::iomap_ops = bindings::iomap_ops {
> +            iomap_begin: Some(Self::iomap_begin_callback),
> +            iomap_end: Some(Self::iomap_end_callback),
> +        };

Hmmm.  Is the model here that you can call ro_aops() with a pair of
iomap function, and then it returns an address_space::Ops object (aka
address_space_operations) that is ready to go with iomap functions?

  const FILE_AOPS: address_space::Ops<Ext2Fs> = iomap::ro_aops::<Ext2Fs>();

is a neat trick, but consider that XFS implements a bunch of different
iomap ops structures.  I suppose it could be interesting to have a bunch
of different XfsInode subtypes (e.g. XfsDaxInode) and you'd always know
which file is in which mode, etc.

On the other hand, coupling together two things that are /not/ coupled
in the C API is awkward.  XFS implements separate iomap ops for buffered
reads, buffered writes, direct io, fsdax io, FIEMAP, and llseek.  I've
been pushing porters to make separate iomap ops so that they don't ned
up with a single huge foofs_iomap_begin function that tries to dispatch
based on iomap flags.

That's a bit different from the C model where the fs implementation has
to assemble all the pieces on its own.  But then, perhaps the strength
of organizing it this way is that you don't end up with a bunch of:

STATIC int
xfs_vm_read_folio(
	struct file		*unused,
	struct folio		*folio)
{
	return iomap_read_folio(folio, &xfs_read_iomap_ops);
}

wrappers polluting the file namespace?

But then, what happens for some future rustfs that wants to implement
read write support?  Does that imply the creation of an iomap::rw_ops?
What if they also want to support swapfiles?  Is there an elegant way to
tamp down the combinatoric rise?  Or would we be better off leaving it
decoupled the same way the C iomap API does?

> +
> +        extern "C" fn iomap_begin_callback(
> +            inode_ptr: *mut bindings::inode,
> +            pos: Offset,
> +            length: Offset,
> +            flags: u32,
> +            map: *mut bindings::iomap,
> +            srcmap: *mut bindings::iomap,
> +        ) -> i32 {
> +            from_result(|| {
> +                // SAFETY: The C API guarantees that `inode_ptr` is a valid inode.
> +                let inode = unsafe { INode::from_raw(inode_ptr) };
> +                T::begin(
> +                    inode,
> +                    pos,
> +                    length,
> +                    flags,
> +                    // SAFETY: The C API guarantees that `map` is valid for write.
> +                    unsafe { &mut *map.cast::<Map<'_>>() },
> +                    // SAFETY: The C API guarantees that `srcmap` is valid for write.
> +                    unsafe { &mut *srcmap.cast::<Map<'_>>() },
> +                )?;
> +                Ok(0)
> +            })
> +        }
> +
> +        extern "C" fn iomap_end_callback(
> +            inode_ptr: *mut bindings::inode,
> +            pos: Offset,
> +            length: Offset,
> +            written: isize,
> +            flags: u32,
> +            map: *mut bindings::iomap,
> +        ) -> i32 {
> +            from_result(|| {
> +                // SAFETY: The C API guarantees that `inode_ptr` is a valid inode.
> +                let inode = unsafe { INode::from_raw(inode_ptr) };
> +                // SAFETY: The C API guarantees that `map` is valid for read.
> +                T::end(inode, pos, length, written, flags, unsafe {
> +                    &*map.cast::<Map<'_>>()
> +                })?;
> +                Ok(0)
> +            })
> +        }
> +
> +        const TABLE: bindings::address_space_operations = bindings::address_space_operations {
> +            writepage: None,
> +            read_folio: Some(Self::read_folio_callback),
> +            writepages: None,
> +            dirty_folio: None,
> +            readahead: Some(Self::readahead_callback),
> +            write_begin: None,
> +            write_end: None,
> +            bmap: Some(Self::bmap_callback),
> +            invalidate_folio: Some(bindings::iomap_invalidate_folio),
> +            release_folio: Some(bindings::iomap_release_folio),
> +            free_folio: None,
> +            direct_IO: Some(bindings::noop_direct_IO),
> +            migrate_folio: None,
> +            launder_folio: None,
> +            is_partially_uptodate: None,

Hm, isn't this needed for blocksize < pagesize?

> +            is_dirty_writeback: None,
> +            error_remove_folio: None,
> +            swap_activate: None,
> +            swap_deactivate: None,
> +            swap_rw: None,

Would be kinda nice to sort these by name order.

--D

> +        };
> +
> +        extern "C" fn read_folio_callback(
> +            _file: *mut bindings::file,
> +            folio: *mut bindings::folio,
> +        ) -> i32 {
> +            // SAFETY: `folio` is just forwarded from C and `Self::MAP_TABLE` is always valid.
> +            unsafe { bindings::iomap_read_folio(folio, &Self::MAP_TABLE) }
> +        }
> +
> +        extern "C" fn readahead_callback(rac: *mut bindings::readahead_control) {
> +            // SAFETY: `rac` is just forwarded from C and `Self::MAP_TABLE` is always valid.
> +            unsafe { bindings::iomap_readahead(rac, &Self::MAP_TABLE) }
> +        }
> +
> +        extern "C" fn bmap_callback(mapping: *mut bindings::address_space, block: u64) -> u64 {
> +            // SAFETY: `mapping` is just forwarded from C and `Self::MAP_TABLE` is always valid.
> +            unsafe { bindings::iomap_bmap(mapping, block, &Self::MAP_TABLE) }
> +        }
> +    }
> +    address_space::Ops(&Table::<T>::TABLE, PhantomData)
> +}
> -- 
> 2.34.1
> 
> 

