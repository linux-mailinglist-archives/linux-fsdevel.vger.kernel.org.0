Return-Path: <linux-fsdevel+bounces-20636-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A339A8D64A9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 16:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B507282CBB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 14:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D59452F9E;
	Fri, 31 May 2024 14:40:17 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from hs01.dakr.org (hs01.dk-develop.de [173.249.23.66])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAEF41C69;
	Fri, 31 May 2024 14:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.249.23.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717166416; cv=none; b=Wp19KFH/WtNleM6m7mR6gOitjhbMiKGFNV7c52yeLcSQ7kgvkGWqSm3PrJIbMH21cZd6MQJ3NoEKVQS8DgX9xogOj62eLv0ogIRXi90cPhr7D3sUPOBxOjZhweDneiY46R8nNrrZ8RW/a/9m/iRUOAVt15uLmPBrwncm2dQwKOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717166416; c=relaxed/simple;
	bh=xlO1Mp3KBU+sq/6oeFxX6/VD7mrtgTn6P2Yuj2MlJiA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZaWzj8KSWYQwkgpPSZX7nQ1U+DDCPqT8hllVg7G7+WAWYZerVqwOxPKKiPv7HWZIWak+wtakC7ZxP7FAXH4WHDGKl3ChRymUiniRlsDihrKDhwe5muBY5X/bCf1ryCjZnFQU/i3DgdNrgalrd9qh9d8b3V6chL3x1Zxgoka0BAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dakr.org; spf=pass smtp.mailfrom=dakr.org; arc=none smtp.client-ip=173.249.23.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dakr.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dakr.org
Message-ID: <38f11766-b601-410b-9025-1e6b4c2203e7@dakr.org>
Date: Fri, 31 May 2024 16:34:00 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH v2 00/30] Rust abstractions for VFS
To: Wedson Almeida Filho <wedsonaf@gmail.com>
Cc: Dave Chinner <david@fromorbit.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Matthew Wilcox <willy@infradead.org>,
 Kent Overstreet <kent.overstreet@gmail.com>,
 Christian Brauner <brauner@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-fsdevel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240514131711.379322-1-wedsonaf@gmail.com>
Content-Language: en-US
From: Danilo Krummrich <me@dakr.org>
In-Reply-To: <20240514131711.379322-1-wedsonaf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Wedson,

On 5/14/24 15:16, Wedson Almeida Filho wrote:
> This series introduces Rust abstractions that allow read-only file systems to
> be written in Rust.
> 
> There are three file systems implementations using these abstractions
> abstractions: ext2, tarfs, and puzzlefs. The first two are part of this series.
> 
> Rust file system modules can be declared with the `module_fs` macro and are
> required to implement the following functions (which are part of the
> `FileSystem` trait):
> 
>      fn fill_super(
>          sb: &mut SuperBlock<Self, sb::New>,
>          mapper: Option<inode::Mapper>,
>      ) -> Result<Self::Data>;
> 
>      fn init_root(sb: &SuperBlock<Self>) -> Result<dentry::Root<Self>>;
> 
> They can optionally implement the following:
> 
>      fn read_xattr(
>          _dentry: &DEntry<Self>,
>          _inode: &INode<Self>,
>          _name: &CStr,
>          _outbuf: &mut [u8],
>      ) -> Result<usize>;
> 
>      fn statfs(_dentry: &DEntry<Self>) -> Result<Stat>;
> 
> They may also choose the type of the data they can attach to superblocks and/or
> inodes.
> 
> Lastly, file systems can implement inode, file, and address space operations
> and attach them to inodes when they're created, similar to how C does it. They
> can get a ro address space operations table from an implementation of iomap
> operations, to be used with generic ro file operations.
> 
> A git tree is available here:
>      git://github.com/wedsonaf/linux.git vfs-v2
> 
> Web:
>      https://github.com/wedsonaf/linux/commits/vfs-v2

This branch indicates that this patch series might have a few more dependencies
that are not upstream yet, e.g. [1].

Do you intend to send them in a separate series (soon)? In case they were already
submitted somewhere and I just failed to find them, please be so kind an provide
me with a pointer.

[1] https://github.com/wedsonaf/linux/commit/96ef0376887f4194ebad608f9943eb41108cf255

- Danilo

> 
> ---
> 
> Changes in v2:
> 
> - Rebased to latest rust-next tree
> - Removed buffer heads
> - Added iomap support
> - Removed `_pin` field from `Registration` as it's not needed anymore
> - Renamed sample filesystem to match the module's name
> - Using typestate instead of a separate type for superblock/new-superblock
> - Created separate submodules for superblocks, inodes, dentries, and files
> - Split out operations from FileSystem to inode/file/address_space ops, similar to how C does it
> - Removed usages of folio_set_error
> - Removed UniqueFolio, for now reading blocks from devices via the pagecache
> - Changed map() to return the entire folio if not in highmem
> - Added support for unlocking the folio asynchronously
> - Added `from_raw` to all new ref-counted types
> - Added explicit types in calls to cast()
> - Added typestate to folio
> - Added support for implementing get_link
> - Fixed data race when reading inode->i_state
> - Added nofs scope support during allocation
> - Link to v1: https://lore.kernel.org/rust-for-linux/20231018122518.128049-1-wedsonaf@gmail.com/
> 
> ---
> 
> Wedson Almeida Filho (30):
>    rust: fs: add registration/unregistration of file systems
>    rust: fs: introduce the `module_fs` macro
>    samples: rust: add initial ro file system sample
>    rust: fs: introduce `FileSystem::fill_super`
>    rust: fs: introduce `INode<T>`
>    rust: fs: introduce `DEntry<T>`
>    rust: fs: introduce `FileSystem::init_root`
>    rust: file: move `kernel::file` to `kernel::fs::file`
>    rust: fs: generalise `File` for different file systems
>    rust: fs: add empty file operations
>    rust: fs: introduce `file::Operations::read_dir`
>    rust: fs: introduce `file::Operations::seek`
>    rust: fs: introduce `file::Operations::read`
>    rust: fs: add empty inode operations
>    rust: fs: introduce `inode::Operations::lookup`
>    rust: folio: introduce basic support for folios
>    rust: fs: add empty address space operations
>    rust: fs: introduce `address_space::Operations::read_folio`
>    rust: fs: introduce `FileSystem::read_xattr`
>    rust: fs: introduce `FileSystem::statfs`
>    rust: fs: introduce more inode types
>    rust: fs: add per-superblock data
>    rust: fs: allow file systems backed by a block device
>    rust: fs: allow per-inode data
>    rust: fs: export file type from mode constants
>    rust: fs: allow populating i_lnk
>    rust: fs: add `iomap` module
>    rust: fs: add memalloc_nofs support
>    tarfs: introduce tar fs
>    WIP: fs: ext2: add rust ro ext2 implementation
> 
>   fs/Kconfig                        |   2 +
>   fs/Makefile                       |   2 +
>   fs/rust-ext2/Kconfig              |  13 +
>   fs/rust-ext2/Makefile             |   8 +
>   fs/rust-ext2/defs.rs              | 173 +++++++
>   fs/rust-ext2/ext2.rs              | 551 +++++++++++++++++++++
>   fs/tarfs/Kconfig                  |  15 +
>   fs/tarfs/Makefile                 |   8 +
>   fs/tarfs/defs.rs                  |  80 +++
>   fs/tarfs/tar.rs                   | 394 +++++++++++++++
>   rust/bindings/bindings_helper.h   |  11 +
>   rust/helpers.c                    | 182 +++++++
>   rust/kernel/block.rs              |  10 +-
>   rust/kernel/error.rs              |   8 +-
>   rust/kernel/file.rs               | 251 ----------
>   rust/kernel/folio.rs              | 305 ++++++++++++
>   rust/kernel/fs.rs                 | 492 +++++++++++++++++++
>   rust/kernel/fs/address_space.rs   |  90 ++++
>   rust/kernel/fs/dentry.rs          | 136 ++++++
>   rust/kernel/fs/file.rs            | 607 +++++++++++++++++++++++
>   rust/kernel/fs/inode.rs           | 780 ++++++++++++++++++++++++++++++
>   rust/kernel/fs/iomap.rs           | 281 +++++++++++
>   rust/kernel/fs/sb.rs              | 194 ++++++++
>   rust/kernel/lib.rs                |   6 +-
>   rust/kernel/mem_cache.rs          |   2 -
>   rust/kernel/user.rs               |   1 -
>   samples/rust/Kconfig              |  10 +
>   samples/rust/Makefile             |   1 +
>   samples/rust/rust_rofs.rs         | 202 ++++++++
>   scripts/generate_rust_analyzer.py |   2 +-
>   30 files changed, 4555 insertions(+), 262 deletions(-)
>   create mode 100644 fs/rust-ext2/Kconfig
>   create mode 100644 fs/rust-ext2/Makefile
>   create mode 100644 fs/rust-ext2/defs.rs
>   create mode 100644 fs/rust-ext2/ext2.rs
>   create mode 100644 fs/tarfs/Kconfig
>   create mode 100644 fs/tarfs/Makefile
>   create mode 100644 fs/tarfs/defs.rs
>   create mode 100644 fs/tarfs/tar.rs
>   delete mode 100644 rust/kernel/file.rs
>   create mode 100644 rust/kernel/folio.rs
>   create mode 100644 rust/kernel/fs.rs
>   create mode 100644 rust/kernel/fs/address_space.rs
>   create mode 100644 rust/kernel/fs/dentry.rs
>   create mode 100644 rust/kernel/fs/file.rs
>   create mode 100644 rust/kernel/fs/inode.rs
>   create mode 100644 rust/kernel/fs/iomap.rs
>   create mode 100644 rust/kernel/fs/sb.rs
>   create mode 100644 samples/rust/rust_rofs.rs
> 
> 
> base-commit: 183ea65d1fcd71039cf4d111a22d69c337bfd344

