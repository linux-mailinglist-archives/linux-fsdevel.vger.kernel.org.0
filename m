Return-Path: <linux-fsdevel+bounces-19834-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0154B8CA315
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 22:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D6E11F21D5A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 20:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3A21386D6;
	Mon, 20 May 2024 20:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fi/ardVF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCEA18EB1;
	Mon, 20 May 2024 20:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716235262; cv=none; b=KTRhwQhOE6yKQBHoxG1oqZkj2OwjDaKrkEXu9GkLpVpy3uPX8UErH1nMLG1CpFOsYVCrRoNNka85RpwRtYBj/fPMu4Xpk9qkDaTXfS8ONT4HDBxfU4Z9qfIEuI6BYJ0V6XBgazCjzjPpkxe/w2LwIyiAObH3Tu1i370Wid+XxH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716235262; c=relaxed/simple;
	bh=eh7rlz6nbgSfnRhFMZEd0BXDvQF6dThPeZrqYT4LEnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pUU58R+xC0fUAld06uYRqlWFEIS2FLBVrnUf0oqhcTfLtpqm9STbvUDG/mZ0Rtxv3FVZ2LNBI416yS71Sbwvje84VeepqZgWEKdrg4O/FXC5G5u0QiDCKyWwKqunZZ2lVm4Mfp9huEzAaA3V6yZHk/5KvcitMyEWf3XgUqaJtRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fi/ardVF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CAD7C2BD10;
	Mon, 20 May 2024 20:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716235262;
	bh=eh7rlz6nbgSfnRhFMZEd0BXDvQF6dThPeZrqYT4LEnU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fi/ardVF0eMGQR5W9mHNlEa/m1lwlz2IEpCCnh657ePUJMQzY2TklAWWvJ43PMVHd
	 82fI1J41NFNXz9xg2XBqq373Bq5zrRPox6uKfUNaG1HDgQmFOI4ya2wk2tkIY1WCSQ
	 6QRotJEFtHZ6yXp+epBFWhoBa6Hzy6ZgRtDAz7FdcL7DxAvR0mL8+7YY1KrrzNmmIt
	 wb8ecFz/ZtP2cNbS9IMrT+6Bf/wHmZ0GgMZCWTErHg0LIuGI3mp0/g3zkLgdjO+SMt
	 2z1w2/UWXMpbHVEi7zpZmcHBTs8DJjfAMV/KvT4v1s+aD3TvfAv3U7t+/JqHW5kv5o
	 ctw1v7qqRge/Q==
Date: Mon, 20 May 2024 13:01:00 -0700
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
Subject: Re: [RFC PATCH v2 30/30] WIP: fs: ext2: add rust ro ext2
 implementation
Message-ID: <20240520200100.GC25504@frogsfrogsfrogs>
References: <20240514131711.379322-1-wedsonaf@gmail.com>
 <20240514131711.379322-31-wedsonaf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240514131711.379322-31-wedsonaf@gmail.com>

On Tue, May 14, 2024 at 10:17:11AM -0300, Wedson Almeida Filho wrote:
> From: Wedson Almeida Filho <walmeida@microsoft.com>
> 
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> ---
>  fs/Kconfig            |   1 +
>  fs/Makefile           |   1 +
>  fs/rust-ext2/Kconfig  |  13 +
>  fs/rust-ext2/Makefile |   8 +
>  fs/rust-ext2/defs.rs  | 173 +++++++++++++
>  fs/rust-ext2/ext2.rs  | 551 ++++++++++++++++++++++++++++++++++++++++++
>  rust/kernel/lib.rs    |   3 +
>  7 files changed, 750 insertions(+)
>  create mode 100644 fs/rust-ext2/Kconfig
>  create mode 100644 fs/rust-ext2/Makefile
>  create mode 100644 fs/rust-ext2/defs.rs
>  create mode 100644 fs/rust-ext2/ext2.rs
> 
> diff --git a/fs/Kconfig b/fs/Kconfig
> index 2cbd99d6784c..cf0cac5c5b1e 100644
> --- a/fs/Kconfig
> +++ b/fs/Kconfig
> @@ -338,6 +338,7 @@ source "fs/ufs/Kconfig"
>  source "fs/erofs/Kconfig"
>  source "fs/vboxsf/Kconfig"
>  source "fs/tarfs/Kconfig"
> +source "fs/rust-ext2/Kconfig"
>  
>  endif # MISC_FILESYSTEMS
>  
> diff --git a/fs/Makefile b/fs/Makefile
> index d8bbda73e3a9..c1a3007efc7d 100644
> --- a/fs/Makefile
> +++ b/fs/Makefile
> @@ -130,3 +130,4 @@ obj-$(CONFIG_EROFS_FS)		+= erofs/
>  obj-$(CONFIG_VBOXSF_FS)		+= vboxsf/
>  obj-$(CONFIG_ZONEFS_FS)		+= zonefs/
>  obj-$(CONFIG_TARFS_FS)		+= tarfs/
> +obj-$(CONFIG_RUST_EXT2_FS)	+= rust-ext2/
> diff --git a/fs/rust-ext2/Kconfig b/fs/rust-ext2/Kconfig
> new file mode 100644
> index 000000000000..976371655ca6
> --- /dev/null
> +++ b/fs/rust-ext2/Kconfig
> @@ -0,0 +1,13 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +
> +config RUST_EXT2_FS
> +	tristate "Rust second extended fs support"
> +	depends on RUST && BLOCK
> +	help
> +	  Ext2 is a standard Linux file system for hard disks.
> +
> +	  To compile this file system support as a module, choose M here: the
> +	  module will be called rust_ext2.
> +
> +	  If unsure, say Y.
> diff --git a/fs/rust-ext2/Makefile b/fs/rust-ext2/Makefile
> new file mode 100644
> index 000000000000..ac960b5f89d7
> --- /dev/null
> +++ b/fs/rust-ext2/Makefile
> @@ -0,0 +1,8 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Makefile for the linux tarfs filesystem routines.
> +#
> +
> +obj-$(CONFIG_RUST_EXT2_FS) += rust_ext2.o
> +
> +rust_ext2-y := ext2.o
> diff --git a/fs/rust-ext2/defs.rs b/fs/rust-ext2/defs.rs
> new file mode 100644
> index 000000000000..5f84852b4961
> --- /dev/null
> +++ b/fs/rust-ext2/defs.rs
> @@ -0,0 +1,173 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Definitions of tarfs structures.
> +
> +use kernel::types::LE;
> +
> +pub(crate) const EXT2_SUPER_MAGIC: u16 = 0xEF53;
> +
> +pub(crate) const EXT2_MAX_BLOCK_LOG_SIZE: u32 = 16;
> +
> +pub(crate) const EXT2_GOOD_OLD_REV: u32 = 0; /* The good old (original) format */
> +pub(crate) const EXT2_DYNAMIC_REV: u32 = 1; /* V2 format w/ dynamic inode sizes */
> +
> +pub(crate) const EXT2_GOOD_OLD_INODE_SIZE: u16 = 128;
> +
> +pub(crate) const EXT2_ROOT_INO: u32 = 2; /* Root inode */
> +
> +/* First non-reserved inode for old ext2 filesystems. */
> +pub(crate) const EXT2_GOOD_OLD_FIRST_INO: u32 = 11;
> +
> +pub(crate) const EXT2_FEATURE_INCOMPAT_FILETYPE: u32 = 0x0002;
> +
> +/*
> + * Constants relative to the data blocks
> + */
> +pub(crate) const EXT2_NDIR_BLOCKS: usize = 12;
> +pub(crate) const EXT2_IND_BLOCK: usize = EXT2_NDIR_BLOCKS;
> +pub(crate) const EXT2_DIND_BLOCK: usize = EXT2_IND_BLOCK + 1;
> +pub(crate) const EXT2_TIND_BLOCK: usize = EXT2_DIND_BLOCK + 1;
> +pub(crate) const EXT2_N_BLOCKS: usize = EXT2_TIND_BLOCK + 1;
> +
> +kernel::derive_readable_from_bytes! {
> +    #[repr(C)]
> +    pub(crate) struct Super {
> +        pub(crate) inodes_count: LE<u32>,
> +        pub(crate) blocks_count: LE<u32>,
> +        pub(crate) r_blocks_count: LE<u32>,
> +        pub(crate) free_blocks_count: LE<u32>, /* Free blocks count */
> +        pub(crate) free_inodes_count: LE<u32>, /* Free inodes count */
> +        pub(crate) first_data_block: LE<u32>,  /* First Data Block */
> +        pub(crate) log_block_size: LE<u32>,    /* Block size */
> +        pub(crate) log_frag_size: LE<u32>,     /* Fragment size */
> +        pub(crate) blocks_per_group: LE<u32>,  /* # Blocks per group */
> +        pub(crate) frags_per_group: LE<u32>,   /* # Fragments per group */
> +        pub(crate) inodes_per_group: LE<u32>,  /* # Inodes per group */
> +        pub(crate) mtime: LE<u32>,             /* Mount time */
> +        pub(crate) wtime: LE<u32>,             /* Write time */
> +        pub(crate) mnt_count: LE<u16>,         /* Mount count */
> +        pub(crate) max_mnt_count: LE<u16>,     /* Maximal mount count */
> +        pub(crate) magic: LE<u16>,             /* Magic signature */
> +        pub(crate) state: LE<u16>,             /* File system state */
> +        pub(crate) errors: LE<u16>,            /* Behaviour when detecting errors */
> +        pub(crate) minor_rev_level: LE<u16>,   /* minor revision level */
> +        pub(crate) lastcheck: LE<u32>,         /* time of last check */
> +        pub(crate) checkinterval: LE<u32>,     /* max. time between checks */
> +        pub(crate) creator_os: LE<u32>,        /* OS */
> +        pub(crate) rev_level: LE<u32>,         /* Revision level */
> +        pub(crate) def_resuid: LE<u16>,        /* Default uid for reserved blocks */
> +        pub(crate) def_resgid: LE<u16>,        /* Default gid for reserved blocks */
> +        /*
> +         * These fields are for EXT2_DYNAMIC_REV superblocks only.
> +         *
> +         * Note: the difference between the compatible feature set and
> +         * the incompatible feature set is that if there is a bit set
> +         * in the incompatible feature set that the kernel doesn't
> +         * know about, it should refuse to mount the filesystem.
> +         *
> +         * e2fsck's requirements are more strict; if it doesn't know
> +         * about a feature in either the compatible or incompatible
> +         * feature set, it must abort and not try to meddle with
> +         * things it doesn't understand...
> +         */
> +        pub(crate) first_ino: LE<u32>,              /* First non-reserved inode */
> +        pub(crate) inode_size: LE<u16>,             /* size of inode structure */
> +        pub(crate) block_group_nr: LE<u16>,         /* block group # of this superblock */
> +        pub(crate) feature_compat: LE<u32>,         /* compatible feature set */
> +        pub(crate) feature_incompat: LE<u32>,       /* incompatible feature set */
> +        pub(crate) feature_ro_compat: LE<u32>,      /* readonly-compatible feature set */
> +        pub(crate) uuid: [u8; 16],                  /* 128-bit uuid for volume */
> +        pub(crate) volume_name: [u8; 16],           /* volume name */
> +        pub(crate) last_mounted: [u8; 64],          /* directory where last mounted */
> +        pub(crate) algorithm_usage_bitmap: LE<u32>, /* For compression */
> +        /*
> +         * Performance hints.  Directory preallocation should only
> +         * happen if the EXT2_COMPAT_PREALLOC flag is on.
> +         */
> +        pub(crate) prealloc_blocks: u8,    /* Nr of blocks to try to preallocate*/
> +        pub(crate) prealloc_dir_blocks: u8,        /* Nr to preallocate for dirs */
> +        padding1: u16,
> +        /*
> +         * Journaling support valid if EXT3_FEATURE_COMPAT_HAS_JOURNAL set.
> +         */
> +        pub(crate) journal_uuid: [u8; 16],      /* uuid of journal superblock */
> +        pub(crate) journal_inum: u32,           /* inode number of journal file */
> +        pub(crate) journal_dev: u32,            /* device number of journal file */
> +        pub(crate) last_orphan: u32,            /* start of list of inodes to delete */
> +        pub(crate) hash_seed: [u32; 4],         /* HTREE hash seed */
> +        pub(crate) def_hash_version: u8,        /* Default hash version to use */
> +        pub(crate) reserved_char_pad: u8,
> +        pub(crate) reserved_word_pad: u16,
> +        pub(crate) default_mount_opts: LE<u32>,
> +        pub(crate) first_meta_bg: LE<u32>,      /* First metablock block group */
> +        reserved: [u32; 190],                   /* Padding to the end of the block */
> +    }
> +
> +    #[repr(C)]
> +    #[derive(Clone, Copy)]
> +    pub(crate) struct Group {

Might want to call these GroupDescriptor to match(ish) the ext2
structure?  I dunno, it's going to be hard to remember to change
"struct ext2_group_desc" in my head to "struct ext2::GroupDescriptor" or
even "struct ext2::group_desc".

> +        /// Blocks bitmap block.
> +        pub block_bitmap: LE<u32>,
> +
> +        /// Inodes bitmap block.
> +        pub inode_bitmap: LE<u32>,
> +
> +        /// Inodes table block.
> +        pub inode_table: LE<u32>,
> +
> +        /// Number of free blocks.
> +        pub free_blocks_count: LE<u16>,
> +
> +        /// Number of free inodes.
> +        pub free_inodes_count: LE<u16>,
> +
> +        /// Number of directories.
> +        pub used_dirs_count: LE<u16>,
> +
> +        pad: LE<u16>,
> +        reserved: [u32; 3],
> +    }
> +
> +    #[repr(C)]
> +    pub(crate) struct INode {
> +        pub mode: LE<u16>,                  /* File mode */
> +        pub uid: LE<u16>,                   /* Low 16 bits of Owner Uid */
> +        pub size: LE<u32>,                  /* Size in bytes */
> +        pub atime: LE<u32>,                 /* Access time */
> +        pub ctime: LE<u32>,                 /* Creation time */
> +        pub mtime: LE<u32>,                 /* Modification time */
> +        pub dtime: LE<u32>,                 /* Deletion Time */
> +        pub gid: LE<u16>,                   /* Low 16 bits of Group Id */
> +        pub links_count: LE<u16>,           /* Links count */
> +        pub blocks: LE<u32>,                /* Blocks count */
> +        pub flags: LE<u32>,                 /* File flags */
> +        pub reserved1: LE<u32>,
> +        pub block: [LE<u32>; EXT2_N_BLOCKS],/* Pointers to blocks */
> +        pub generation: LE<u32>,            /* File version (for NFS) */
> +        pub file_acl: LE<u32>,              /* File ACL */
> +        pub dir_acl: LE<u32>,               /* Directory ACL */
> +        pub faddr: LE<u32>,                 /* Fragment address */
> +        pub frag: u8,	                    /* Fragment number */
> +        pub fsize: u8,	                    /* Fragment size */
> +        pub pad1: LE<u16>,
> +        pub uid_high: LE<u16>,
> +        pub gid_high: LE<u16>,
> +        pub reserved2: LE<u32>,
> +    }
> +
> +    #[repr(C)]
> +    pub(crate) struct DirEntry {
> +        pub(crate) inode: LE<u32>,       /* Inode number */
> +        pub(crate) rec_len: LE<u16>,     /* Directory entry length */
> +        pub(crate) name_len: u8,         /* Name length */
> +        pub(crate) file_type: u8,        /* Only if the "filetype" feature flag is set. */
> +    }
> +}
> +
> +pub(crate) const FT_REG_FILE: u8 = 1;
> +pub(crate) const FT_DIR: u8 = 2;
> +pub(crate) const FT_CHRDEV: u8 = 3;
> +pub(crate) const FT_BLKDEV: u8 = 4;
> +pub(crate) const FT_FIFO: u8 = 5;
> +pub(crate) const FT_SOCK: u8 = 6;
> +pub(crate) const FT_SYMLINK: u8 = 7;
> diff --git a/fs/rust-ext2/ext2.rs b/fs/rust-ext2/ext2.rs
> new file mode 100644
> index 000000000000..2d6b1e7ca156
> --- /dev/null
> +++ b/fs/rust-ext2/ext2.rs
> @@ -0,0 +1,551 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Ext2 file system.
> +
> +use alloc::vec::Vec;
> +use core::mem::size_of;
> +use defs::*;
> +use kernel::fs::{
> +    self, address_space, dentry, dentry::DEntry, file, file::File, inode, inode::INode, iomap, sb,
> +    sb::SuperBlock, Offset,
> +};
> +use kernel::types::{ARef, Either, FromBytes, Locked, LE};
> +use kernel::{block, c_str, prelude::*, str::CString, time::Timespec, user, PAGE_SIZE};
> +
> +pub mod defs;
> +
> +kernel::module_fs! {
> +    type: Ext2Fs,
> +    name: "ext2",
> +    author: "Wedson Almeida Filho <walmeida@microsoft.com>",
> +    description: "ext2 file system",
> +    license: "GPL",
> +}
> +
> +const SB_OFFSET: Offset = 1024;
> +
> +struct INodeData {
> +    data_blocks: [u32; defs::EXT2_N_BLOCKS],
> +}
> +
> +struct Ext2Fs {
> +    mapper: inode::Mapper,
> +    block_size: u32,
> +    has_file_type: bool,
> +    _block_size_bits: u32,
> +    inodes_per_block: u32,
> +    inodes_per_group: u32,
> +    inode_count: u32,
> +    inode_size: u16,
> +    first_ino: u32,
> +    group: Vec<defs::Group>,
> +}
> +
> +impl Ext2Fs {
> +    fn iget(sb: &SuperBlock<Self>, ino: u32) -> Result<ARef<INode<Self>>> {
> +        let s = sb.data();
> +        if (ino != EXT2_ROOT_INO && ino < s.first_ino) || ino > s.inode_count {
> +            return Err(ENOENT);
> +        }
> +        let group = ((ino - 1) / s.inodes_per_group) as usize;
> +        let offset = (ino - 1) % s.inodes_per_group;
> +
> +        if group >= s.group.len() {
> +            return Err(ENOENT);
> +        }
> +
> +        // Create an inode or find an existing (cached) one.
> +        let mut inode = match sb.get_or_create_inode(ino.into())? {
> +            Either::Left(existing) => return Ok(existing),
> +            Either::Right(new) => new,
> +        };
> +
> +        let inodes_block = Offset::from(s.group[group].inode_table.value());
> +        let inode_block = inodes_block + Offset::from(offset / s.inodes_per_block);
> +        let offset = (offset % s.inodes_per_block) as usize;
> +        let b = sb
> +            .data()
> +            .mapper
> +            .mapped_folio(inode_block * Offset::from(s.block_size))?;

It almost feels like you need a buffer cache here for fs metadata... ;)

> +        let idata = defs::INode::from_bytes(&b, offset * s.inode_size as usize).ok_or(EIO)?;
> +        let mode = idata.mode.value();
> +
> +        if idata.links_count.value() == 0 && (mode == 0 || idata.dtime.value() != 0) {
> +            return Err(ESTALE);
> +        }
> +
> +        const DIR_FOPS: file::Ops<Ext2Fs> = file::Ops::new::<Ext2Fs>();
> +        const DIR_IOPS: inode::Ops<Ext2Fs> = inode::Ops::new::<Ext2Fs>();
> +        const FILE_AOPS: address_space::Ops<Ext2Fs> = iomap::ro_aops::<Ext2Fs>();
> +
> +        let mut size = idata.size.value().into();
> +        let typ = match mode & fs::mode::S_IFMT {
> +            fs::mode::S_IFREG => {
> +                size |= Offset::from(idata.dir_acl.value())
> +                    .checked_shl(32)
> +                    .ok_or(EUCLEAN)?;

I wonder, is there a clean way to log these kinds of corruption errors?
ext4 (and soon xfs) have the ability to log health problems and pass
those kinds of errors to a monitoring daemon via fanotify.

> +                inode
> +                    .set_aops(FILE_AOPS)
> +                    .set_fops(file::Ops::generic_ro_file());
> +                inode::Type::Reg
> +            }
> +            fs::mode::S_IFDIR => {
> +                inode
> +                    .set_iops(DIR_IOPS)
> +                    .set_fops(DIR_FOPS)
> +                    .set_aops(FILE_AOPS);
> +                inode::Type::Dir
> +            }
> +            fs::mode::S_IFLNK => {
> +                if idata.blocks.value() == 0 {
> +                    const OFFSET: usize = core::mem::offset_of!(defs::INode, block);
> +                    let name = &b[offset * usize::from(s.inode_size) + OFFSET..];
> +                    let name_len = size as usize;
> +                    if name_len > name.len() || name_len == 0 {
> +                        return Err(EIO);
> +                    }
> +                    inode.set_iops(inode::Ops::simple_symlink_inode());
> +                    inode::Type::Lnk(Some(CString::try_from(&name[..name_len])?))
> +                } else {
> +                    inode
> +                        .set_aops(FILE_AOPS)
> +                        .set_iops(inode::Ops::page_symlink_inode());
> +                    inode::Type::Lnk(None)
> +                }
> +            }
> +            fs::mode::S_IFSOCK => inode::Type::Sock,
> +            fs::mode::S_IFIFO => inode::Type::Fifo,
> +            fs::mode::S_IFCHR => {
> +                let (major, minor) = decode_dev(&idata.block);
> +                inode::Type::Chr(major, minor)
> +            }
> +            fs::mode::S_IFBLK => {
> +                let (major, minor) = decode_dev(&idata.block);
> +                inode::Type::Blk(major, minor)
> +            }
> +            _ => return Err(ENOENT),
> +        };
> +        inode.init(inode::Params {
> +            typ,
> +            mode: mode & 0o777,
> +            size,
> +            blocks: idata.blocks.value().into(),
> +            nlink: idata.links_count.value().into(),
> +            uid: u32::from(idata.uid.value()) | u32::from(idata.uid_high.value()) << 16,
> +            gid: u32::from(idata.gid.value()) | u32::from(idata.gid_high.value()) << 16,
> +            ctime: Timespec::new(idata.ctime.value().into(), 0)?,
> +            mtime: Timespec::new(idata.mtime.value().into(), 0)?,
> +            atime: Timespec::new(idata.atime.value().into(), 0)?,
> +            value: INodeData {
> +                data_blocks: core::array::from_fn(|i| idata.block[i].value()),
> +            },
> +        })
> +    }
> +
> +    fn offsets<'a>(&self, mut block: u64, out: &'a mut [u32]) -> Option<&'a [u32]> {
> +        let ptrs = u64::from(self.block_size / size_of::<u32>() as u32);
> +        let ptr_mask = ptrs - 1;
> +        let ptr_bits = ptrs.trailing_zeros();
> +
> +        if block < EXT2_NDIR_BLOCKS as u64 {
> +            out[0] = block as u32;
> +            return Some(&out[..1]);
> +        }
> +
> +        block -= EXT2_NDIR_BLOCKS as u64;
> +        if block < ptrs {
> +            out[0] = EXT2_IND_BLOCK as u32;
> +            out[1] = block as u32;
> +            return Some(&out[..2]);
> +        }
> +
> +        block -= ptrs;
> +        if block < (1 << (2 * ptr_bits)) {
> +            out[0] = EXT2_DIND_BLOCK as u32;
> +            out[1] = (block >> ptr_bits) as u32;
> +            out[2] = (block & ptr_mask) as u32;
> +            return Some(&out[..3]);
> +        }
> +
> +        block -= ptrs * ptrs;
> +        if block < ptrs * ptrs * ptrs {
> +            out[0] = EXT2_TIND_BLOCK as u32;
> +            out[1] = (block >> (2 * ptr_bits)) as u32;
> +            out[2] = ((block >> ptr_bits) & ptr_mask) as u32;
> +            out[3] = (block & ptr_mask) as u32;
> +            return Some(&out[..4]);
> +        }
> +
> +        None
> +    }
> +
> +    fn offset_to_block(inode: &INode<Self>, block: Offset) -> Result<u64> {
> +        let s = inode.super_block().data();
> +        let mut indices = [0u32; 4];
> +        let boffsets = s.offsets(block as u64, &mut indices).ok_or(EIO)?;
> +        let mut boffset = inode.data().data_blocks[boffsets[0] as usize];
> +        let mapper = &s.mapper;
> +        for i in &boffsets[1..] {
> +            let b = mapper.mapped_folio(Offset::from(boffset) * Offset::from(s.block_size))?;
> +            let table = LE::<u32>::from_bytes_to_slice(&b).ok_or(EIO)?;
> +            boffset = table[*i as usize].value();
> +        }
> +        Ok(boffset.into())
> +    }
> +
> +    fn check_descriptors(s: &Super, groups: &[Group]) -> Result {

It's ... very odd to mix file space mapping functions and group
descriptors into the same structure.  Does offset_to_block belong in a
Ext2Inode structure?

I was also wondering, is there a convenient way to make it so that the
compiler can enforce that a directory inode can only be passed an
Operations that actually has all the directory operations initialized?
Or that a regular file can't have a lookup function in its iops?

> +        for (i, g) in groups.iter().enumerate() {
> +            let first = i as u32 * s.blocks_per_group.value() + s.first_data_block.value();
> +            let last = if i == groups.len() - 1 {
> +                s.blocks_count.value()
> +            } else {
> +                first + s.blocks_per_group.value() - 1
> +            };
> +
> +            if g.block_bitmap.value() < first || g.block_bitmap.value() > last {
> +                pr_err!(
> +                    "Block bitmap for group {i} no in group (block {})\n",
> +                    g.block_bitmap.value()
> +                );
> +                return Err(EINVAL);
> +            }
> +
> +            if g.inode_bitmap.value() < first || g.inode_bitmap.value() > last {
> +                pr_err!(
> +                    "Inode bitmap for group {i} no in group (block {})\n",
> +                    g.inode_bitmap.value()
> +                );
> +                return Err(EINVAL);
> +            }
> +
> +            if g.inode_table.value() < first || g.inode_table.value() > last {
> +                pr_err!(
> +                    "Inode table for group {i} no in group (block {})\n",
> +                    g.inode_table.value()
> +                );
> +                return Err(EINVAL);
> +            }
> +        }
> +        Ok(())
> +    }
> +}
> +
> +impl fs::FileSystem for Ext2Fs {
> +    type Data = Box<Self>;
> +    type INodeData = INodeData;
> +    const NAME: &'static CStr = c_str!("rust-ext2");
> +    const SUPER_TYPE: sb::Type = sb::Type::BlockDev;
> +
> +    fn fill_super(
> +        sb: &mut SuperBlock<Self, sb::New>,
> +        mapper: Option<inode::Mapper>,
> +    ) -> Result<Self::Data> {
> +        let Some(mapper) = mapper else {
> +            return Err(EINVAL);
> +        };
> +
> +        if sb.min_blocksize(PAGE_SIZE as i32) == 0 {
> +            pr_err!("Unable to set block size\n");
> +            return Err(EINVAL);
> +        }
> +
> +        // Map the super block and check the magic number.
> +        let mapped = mapper.mapped_folio(SB_OFFSET)?;
> +        let s = Super::from_bytes(&mapped, 0).ok_or(EIO)?;
> +
> +        if s.magic.value() != EXT2_SUPER_MAGIC {
> +            return Err(EINVAL);
> +        }
> +
> +        // Check for unsupported flags.
> +        let mut has_file_type = false;
> +        if s.rev_level.value() >= EXT2_DYNAMIC_REV {
> +            let features = s.feature_incompat.value();
> +            if features & !EXT2_FEATURE_INCOMPAT_FILETYPE != 0 {
> +                pr_err!("Unsupported incompatible feature: {:x}\n", features);
> +                return Err(EINVAL);
> +            }
> +
> +            has_file_type = features & EXT2_FEATURE_INCOMPAT_FILETYPE != 0;
> +
> +            let features = s.feature_ro_compat.value();
> +            if !sb.rdonly() && features != 0 {
> +                pr_err!("Unsupported rw incompatible feature: {:x}\n", features);
> +                return Err(EINVAL);
> +            }
> +        }
> +
> +        // Set the block size.
> +        let block_size_bits = s.log_block_size.value();
> +        if block_size_bits > EXT2_MAX_BLOCK_LOG_SIZE - 10 {
> +            pr_err!("Invalid log block size: {}\n", block_size_bits);
> +            return Err(EINVAL);
> +        }
> +
> +        let block_size = 1024u32 << block_size_bits;
> +        if sb.min_blocksize(block_size as i32) != block_size as i32 {
> +            pr_err!("Bad block size: {}\n", block_size);
> +            return Err(ENXIO);
> +        }
> +
> +        // Get the first inode and the inode size.
> +        let (inode_size, first_ino) = if s.rev_level.value() == EXT2_GOOD_OLD_REV {
> +            (EXT2_GOOD_OLD_INODE_SIZE, EXT2_GOOD_OLD_FIRST_INO)
> +        } else {
> +            let size = s.inode_size.value();
> +            if size < EXT2_GOOD_OLD_INODE_SIZE
> +                || !size.is_power_of_two()
> +                || u32::from(size) > block_size
> +            {
> +                pr_err!("Unsupported inode size: {}\n", size);
> +                return Err(EINVAL);
> +            }
> +            (size, s.first_ino.value())
> +        };
> +
> +        // Get the number of inodes per group and per block.
> +        let inode_count = s.inodes_count.value();
> +        let inodes_per_group = s.inodes_per_group.value();
> +        let inodes_per_block = block_size / u32::from(inode_size);
> +        if inodes_per_group == 0 || inodes_per_block == 0 {
> +            return Err(EINVAL);
> +        }
> +
> +        if inodes_per_group > block_size * 8 || inodes_per_group < inodes_per_block {
> +            pr_err!("Bad inodes per group: {}\n", inodes_per_group);
> +            return Err(EINVAL);
> +        }
> +
> +        // Check the size of the groups.
> +        let itb_per_group = inodes_per_group / inodes_per_block;
> +        let blocks_per_group = s.blocks_per_group.value();
> +        if blocks_per_group > block_size * 8 || blocks_per_group <= itb_per_group + 3 {
> +            pr_err!("Bad blocks per group: {}\n", blocks_per_group);
> +            return Err(EINVAL);
> +        }
> +
> +        let blocks_count = s.blocks_count.value();
> +        if block::Sector::from(blocks_count) > sb.sector_count() >> (1 + block_size_bits) {
> +            pr_err!(
> +                "Block count ({blocks_count}) exceeds size of device ({})\n",
> +                sb.sector_count() >> (1 + block_size_bits)
> +            );
> +            return Err(EINVAL);
> +        }
> +
> +        let group_count = (blocks_count - s.first_data_block.value() - 1) / blocks_per_group + 1;
> +        if group_count * inodes_per_group != inode_count {
> +            pr_err!(
> +                "Unexpected inode count: {inode_count} vs {}",
> +                group_count * inodes_per_group
> +            );
> +            return Err(EINVAL);
> +        }
> +
> +        let mut groups = Vec::new();
> +        groups.reserve(group_count as usize, GFP_NOFS)?;

Why not GFP_KERNEL here?

Oh wow the C ext2 driver pins a bunch of buffer heads doesn't it...
/me runs

> +
> +        let mut remain = group_count;
> +        let mut offset = (SB_OFFSET / Offset::from(block_size) + 1) * Offset::from(block_size);
> +        while remain > 0 {
> +            let b = mapper.mapped_folio(offset)?;
> +            for g in Group::from_bytes_to_slice(&b).ok_or(EIO)? {
> +                groups.push(*g, GFP_NOFS)?;
> +                remain -= 1;
> +                if remain == 0 {
> +                    break;
> +                }
> +            }
> +            offset += Offset::try_from(b.len())?;
> +        }
> +
> +        Self::check_descriptors(s, &groups)?;
> +
> +        sb.set_magic(s.magic.value().into());
> +        drop(mapped);
> +        Ok(Box::new(
> +            Ext2Fs {
> +                mapper,
> +                block_size,
> +                _block_size_bits: block_size_bits,
> +                has_file_type,
> +                inodes_per_group,
> +                inodes_per_block,
> +                inode_count,
> +                inode_size,
> +                first_ino,
> +                group: groups,
> +            },
> +            GFP_KERNEL,
> +        )?)
> +    }
> +
> +    fn init_root(sb: &SuperBlock<Self>) -> Result<dentry::Root<Self>> {
> +        let inode = Self::iget(sb, EXT2_ROOT_INO)?;
> +        dentry::Root::try_new(inode)
> +    }
> +}
> +
> +fn rec_len(d: &DirEntry) -> u32 {
> +    let len = d.rec_len.value();
> +
> +    if PAGE_SIZE >= 65536 && len == u16::MAX {
> +        1u32 << 16
> +    } else {
> +        len.into()
> +    }
> +}
> +
> +#[vtable]
> +impl file::Operations for Ext2Fs {
> +    type FileSystem = Self;
> +
> +    fn seek(file: &File<Self>, offset: Offset, whence: file::Whence) -> Result<Offset> {
> +        file::generic_seek(file, offset, whence)
> +    }
> +
> +    fn read(_: &File<Self>, _: &mut user::Writer, _: &mut Offset) -> Result<usize> {
> +        Err(EISDIR)
> +    }
> +
> +    fn read_dir(

Wait, does this imply that regular files also have read_dir that you can
call?

> +        _file: &File<Self>,
> +        inode: &Locked<&INode<Self>, inode::ReadSem>,
> +        emitter: &mut file::DirEmitter,
> +    ) -> Result {
> +        let has_file_type = inode.super_block().data().has_file_type;
> +
> +        inode.for_each_page(emitter.pos(), Offset::MAX, |data| {

Neat that Rust can turn an indirect call to a lambda function into a
direct call.  I hear C can do that now too?

> +            let mut offset = 0usize;
> +            let mut acc: Offset = 0;
> +            let limit = data.len().saturating_sub(size_of::<DirEntry>());
> +            while offset < limit {
> +                let dirent = DirEntry::from_bytes(data, offset).ok_or(EIO)?;
> +                offset += size_of::<DirEntry>();
> +
> +                let name_len = usize::from(dirent.name_len);
> +                if data.len() - offset < name_len {
> +                    return Err(EIO);
> +                }
> +
> +                let name = &data[offset..][..name_len];
> +                let rec_len = rec_len(dirent);
> +                offset = offset - size_of::<DirEntry>() + rec_len as usize;
> +                if rec_len == 0 || offset > data.len() {
> +                    return Err(EIO);
> +                }
> +
> +                acc += Offset::from(rec_len);
> +                let ino = dirent.inode.value();
> +                if ino == 0 {
> +                    continue;
> +                }
> +
> +                let t = if !has_file_type {
> +                    file::DirEntryType::Unknown
> +                } else {
> +                    match dirent.file_type {
> +                        FT_REG_FILE => file::DirEntryType::Reg,
> +                        FT_DIR => file::DirEntryType::Dir,
> +                        FT_SYMLINK => file::DirEntryType::Lnk,
> +                        FT_CHRDEV => file::DirEntryType::Chr,
> +                        FT_BLKDEV => file::DirEntryType::Blk,
> +                        FT_FIFO => file::DirEntryType::Fifo,
> +                        FT_SOCK => file::DirEntryType::Sock,
> +                        _ => continue,

Isn't this a directory corruption?  return Err(EFSCORRUPTED) ?

> +                    }
> +                };
> +
> +                if !emitter.emit(acc, name, ino.into(), t) {
> +                    return Ok(Some(()));
> +                }
> +                acc = 0;
> +            }
> +            Ok(None)
> +        })?;
> +        Ok(())
> +    }
> +}
> +
> +#[vtable]
> +impl inode::Operations for Ext2Fs {
> +    type FileSystem = Self;
> +
> +    fn lookup(
> +        parent: &Locked<&INode<Self>, inode::ReadSem>,
> +        dentry: dentry::Unhashed<'_, Self>,
> +    ) -> Result<Option<ARef<DEntry<Self>>>> {
> +        let inode = parent.for_each_page(0, Offset::MAX, |data| {
> +            let mut offset = 0usize;
> +            while data.len() - offset > size_of::<DirEntry>() {
> +                let dirent = DirEntry::from_bytes(data, offset).ok_or(EIO)?;
> +                offset += size_of::<DirEntry>();
> +
> +                let name_len = usize::from(dirent.name_len);
> +                if data.len() - offset < name_len {
> +                    return Err(EIO);
> +                }
> +
> +                let name = &data[offset..][..name_len];
> +
> +                offset = offset - size_of::<DirEntry>() + usize::from(dirent.rec_len.value());
> +                if offset > data.len() {
> +                    return Err(EIO);
> +                }
> +
> +                let ino = dirent.inode.value();
> +                if ino != 0 && name == dentry.name() {
> +                    return Ok(Some(Self::iget(parent.super_block(), ino)?));
> +                }
> +            }
> +            Ok(None)
> +        })?;
> +
> +        dentry.splice_alias(inode)
> +    }
> +}
> +
> +impl iomap::Operations for Ext2Fs {
> +    type FileSystem = Self;
> +
> +    fn begin<'a>(
> +        inode: &'a INode<Self>,
> +        pos: Offset,
> +        length: Offset,
> +        _flags: u32,
> +        map: &mut iomap::Map<'a>,
> +        _srcmap: &mut iomap::Map<'a>,
> +    ) -> Result {
> +        let size = inode.size();
> +        if pos >= size {
> +            map.set_offset(pos)
> +                .set_length(length.try_into()?)
> +                .set_flags(iomap::map_flags::MERGED)
> +                .set_type(iomap::Type::Hole);
> +            return Ok(());
> +        }
> +
> +        let block_size = inode.super_block().data().block_size as Offset;
> +        let block = pos / block_size;
> +
> +        let boffset = Self::offset_to_block(inode, block)?;
> +        map.set_offset(block * block_size)
> +            .set_length(block_size as u64)
> +            .set_flags(iomap::map_flags::MERGED)
> +            .set_type(iomap::Type::Mapped)
> +            .set_bdev(Some(inode.super_block().bdev()))
> +            .set_addr(boffset * block_size as u64);

Neat use of chaining here.

> +
> +        Ok(())
> +    }
> +}
> +
> +fn decode_dev(block: &[LE<u32>]) -> (u32, u32) {
> +    let v = block[0].value();
> +    if v != 0 {
> +        ((v >> 8) & 255, v & 255)
> +    } else {
> +        let v = block[1].value();
> +        ((v & 0xfff00) >> 8, (v & 0xff) | ((v >> 12) & 0xfff00))

Nice not to have leXX_to_cpu calls everywhere here.

--D

> +    }
> +}
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index 445599d4bff6..732bc9939f7f 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -165,3 +165,6 @@ macro_rules! container_of {
>          ptr.wrapping_sub(offset) as *const $type
>      }}
>  }
> +
> +/// The size in bytes of a page of memory.
> +pub const PAGE_SIZE: usize = bindings::PAGE_SIZE;
> -- 
> 2.34.1
> 
> 

