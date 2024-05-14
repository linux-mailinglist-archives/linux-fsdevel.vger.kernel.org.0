Return-Path: <linux-fsdevel+bounces-19422-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0318C56C2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 15:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9166F1C224A3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 13:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B242144D13;
	Tue, 14 May 2024 13:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LOxXn9Ny"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246541448ED;
	Tue, 14 May 2024 13:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715692655; cv=none; b=ABM6MBmKi6q2j3GenZv5ShrhAZvOsGzhQh3B8elIlB3e2ETjjZkdrKIsX0pLtuxCH8/s311doFQQwaEnGT5Nrch5Wd1+SBoApVr8wazlNz96Fs1V8uFDldZDLEbHfXwRDq7yAGUKWLDAQio1JFO59K8OKhIMh2kVV/TpbYfRfCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715692655; c=relaxed/simple;
	bh=dxfIijSCE4k/vVSJI5jpHtKZm2tg9+OL+IyXy4n8ttk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=risT42oC2b0lQwyifZ0ufSMIeBZiEN1gpsDvYuVqzmWHbTIrYhheoUzlGp1pkc7cXy4FlbIjLM72ZVZVUIYX5gZW+gGOSAbUMJGeaqh45A7VNF7OL1Syd3+ehWRL7KB2mRtfPC/CDQvJpmVooALMu5UiFIGRl6RGPoGaz6kaxp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LOxXn9Ny; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1eca195a7c8so45598935ad.2;
        Tue, 14 May 2024 06:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715692653; x=1716297453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=exr7aat/FWCYrncbM0fcEUOaeQqr5aYv8sckR5lfn3E=;
        b=LOxXn9Ny59zLC+DlpwnE8B4hjoR72a45rmJfyYr4AVmWyGmUV//kYAyky3Uf0Pq22a
         XlgrzAc6j/wm075GHQJvG3bJfjmoBxIU2Tl5XNmMxDqR7fPu4JVKtzQnur+R+zoIsHiW
         juixBuUJJym6L/O/jc2/VEsVcfc2kEJyu6q1/zd3tC033ZhTdHt3yg8uQaX1mACCoEGu
         DN/7oWY3vH/sSAav3nL3kX/ffpx7QXlMWUlLBeZQiLZSicepthPePE3/hyqGTB218iEJ
         rzG9KrGoFbPtoJQ1yUaUd+87We9IGXP5D08DlhlycXGQVSgGacirj5r46sVULhQm1NUu
         xINA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715692653; x=1716297453;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=exr7aat/FWCYrncbM0fcEUOaeQqr5aYv8sckR5lfn3E=;
        b=c/7I4RyDtquJ6EdiGndP6Fn2I/aajYeC+bEysXJODzECrZaIaybgXot0xB3Sg/d+Nh
         jAduDRocqMvz9EkUi+EjzGS4zTt1OFQwtXNDfk64b0tCl1jGNveBGXn0PCo4EWMKHY0v
         DAeAdIG7xcEHiiHMJ+HIeRZxFsoAL+AQi3WVavrtY/FaifYor4/yIYHFaC2lZ7qmdQN7
         k0z7H66T36eQMQCuEpErX/Zk4Cy18fF7Tax0lP2nzNsoM/3PJ1R+c/J2H71pZcfTULj4
         mzBcr9XenrdhJ7Uo8wGEmqPWu6DivxYbz6jWo5dJ7Lt3AvZ0ZJ1/4T4BeND4HWgt3bzm
         9/OA==
X-Forwarded-Encrypted: i=1; AJvYcCXQXNCi7YrimvK5nqp671WefhZsz6xyHuPDyO8JjLAqcgkp/LdZ1ZDU76eYrUTCrnhBKz4ORV3clB8GOL6w3+rmTxohkpIbMsDBFJFWAIXz36en6P2ihPGXTNe36J6Qn/jmsXKMtj2BE5aJCLdy3t9WrOl/1FHC86p7QOHJrdUufPKGEkpQfOYAlRyp
X-Gm-Message-State: AOJu0YyS7oyvzoCIMQOANl+bwgxaSO/m0YTS0wpRaKa4f/zLol2js/pX
	JE1iyFxDTLgGAw1uj4NZ7sgY5/wtWtJ9Dj/qHLCxOz5YptWOz4tL
X-Google-Smtp-Source: AGHT+IFNUk9FNEeYd3kTqCAwEoYFl8xe6J6nOxovaCuVEKq5dmcbS/qnnHjmFB+qELcW291mGZE4xA==
X-Received: by 2002:a17:902:efca:b0:1eb:ed2:f74c with SMTP id d9443c01a7336-1ef440596b4mr111334915ad.67.1715692653213;
        Tue, 14 May 2024 06:17:33 -0700 (PDT)
Received: from wedsonaf-dev.. ([50.204.89.32])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1ef0b9d18a4sm97277335ad.56.2024.05.14.06.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 06:17:32 -0700 (PDT)
From: Wedson Almeida Filho <wedsonaf@gmail.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Dave Chinner <david@fromorbit.com>
Cc: Kent Overstreet <kent.overstreet@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fsdevel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wedson Almeida Filho <wedsonaf@gmail.com>
Subject: [RFC PATCH v2 00/30] Rust abstractions for VFS
Date: Tue, 14 May 2024 10:16:41 -0300
Message-Id: <20240514131711.379322-1-wedsonaf@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series introduces Rust abstractions that allow read-only file systems to
be written in Rust.

There are three file systems implementations using these abstractions
abstractions: ext2, tarfs, and puzzlefs. The first two are part of this series.

Rust file system modules can be declared with the `module_fs` macro and are
required to implement the following functions (which are part of the
`FileSystem` trait):

    fn fill_super(
        sb: &mut SuperBlock<Self, sb::New>,
        mapper: Option<inode::Mapper>,
    ) -> Result<Self::Data>;

    fn init_root(sb: &SuperBlock<Self>) -> Result<dentry::Root<Self>>;

They can optionally implement the following:

    fn read_xattr(
        _dentry: &DEntry<Self>,
        _inode: &INode<Self>,
        _name: &CStr,
        _outbuf: &mut [u8],
    ) -> Result<usize>;

    fn statfs(_dentry: &DEntry<Self>) -> Result<Stat>;

They may also choose the type of the data they can attach to superblocks and/or
inodes.

Lastly, file systems can implement inode, file, and address space operations
and attach them to inodes when they're created, similar to how C does it. They
can get a ro address space operations table from an implementation of iomap
operations, to be used with generic ro file operations.

A git tree is available here:
    git://github.com/wedsonaf/linux.git vfs-v2

Web:
    https://github.com/wedsonaf/linux/commits/vfs-v2

---

Changes in v2:

- Rebased to latest rust-next tree
- Removed buffer heads
- Added iomap support
- Removed `_pin` field from `Registration` as it's not needed anymore
- Renamed sample filesystem to match the module's name
- Using typestate instead of a separate type for superblock/new-superblock
- Created separate submodules for superblocks, inodes, dentries, and files
- Split out operations from FileSystem to inode/file/address_space ops, similar to how C does it
- Removed usages of folio_set_error
- Removed UniqueFolio, for now reading blocks from devices via the pagecache
- Changed map() to return the entire folio if not in highmem
- Added support for unlocking the folio asynchronously
- Added `from_raw` to all new ref-counted types
- Added explicit types in calls to cast()
- Added typestate to folio
- Added support for implementing get_link
- Fixed data race when reading inode->i_state
- Added nofs scope support during allocation
- Link to v1: https://lore.kernel.org/rust-for-linux/20231018122518.128049-1-wedsonaf@gmail.com/

---

Wedson Almeida Filho (30):
  rust: fs: add registration/unregistration of file systems
  rust: fs: introduce the `module_fs` macro
  samples: rust: add initial ro file system sample
  rust: fs: introduce `FileSystem::fill_super`
  rust: fs: introduce `INode<T>`
  rust: fs: introduce `DEntry<T>`
  rust: fs: introduce `FileSystem::init_root`
  rust: file: move `kernel::file` to `kernel::fs::file`
  rust: fs: generalise `File` for different file systems
  rust: fs: add empty file operations
  rust: fs: introduce `file::Operations::read_dir`
  rust: fs: introduce `file::Operations::seek`
  rust: fs: introduce `file::Operations::read`
  rust: fs: add empty inode operations
  rust: fs: introduce `inode::Operations::lookup`
  rust: folio: introduce basic support for folios
  rust: fs: add empty address space operations
  rust: fs: introduce `address_space::Operations::read_folio`
  rust: fs: introduce `FileSystem::read_xattr`
  rust: fs: introduce `FileSystem::statfs`
  rust: fs: introduce more inode types
  rust: fs: add per-superblock data
  rust: fs: allow file systems backed by a block device
  rust: fs: allow per-inode data
  rust: fs: export file type from mode constants
  rust: fs: allow populating i_lnk
  rust: fs: add `iomap` module
  rust: fs: add memalloc_nofs support
  tarfs: introduce tar fs
  WIP: fs: ext2: add rust ro ext2 implementation

 fs/Kconfig                        |   2 +
 fs/Makefile                       |   2 +
 fs/rust-ext2/Kconfig              |  13 +
 fs/rust-ext2/Makefile             |   8 +
 fs/rust-ext2/defs.rs              | 173 +++++++
 fs/rust-ext2/ext2.rs              | 551 +++++++++++++++++++++
 fs/tarfs/Kconfig                  |  15 +
 fs/tarfs/Makefile                 |   8 +
 fs/tarfs/defs.rs                  |  80 +++
 fs/tarfs/tar.rs                   | 394 +++++++++++++++
 rust/bindings/bindings_helper.h   |  11 +
 rust/helpers.c                    | 182 +++++++
 rust/kernel/block.rs              |  10 +-
 rust/kernel/error.rs              |   8 +-
 rust/kernel/file.rs               | 251 ----------
 rust/kernel/folio.rs              | 305 ++++++++++++
 rust/kernel/fs.rs                 | 492 +++++++++++++++++++
 rust/kernel/fs/address_space.rs   |  90 ++++
 rust/kernel/fs/dentry.rs          | 136 ++++++
 rust/kernel/fs/file.rs            | 607 +++++++++++++++++++++++
 rust/kernel/fs/inode.rs           | 780 ++++++++++++++++++++++++++++++
 rust/kernel/fs/iomap.rs           | 281 +++++++++++
 rust/kernel/fs/sb.rs              | 194 ++++++++
 rust/kernel/lib.rs                |   6 +-
 rust/kernel/mem_cache.rs          |   2 -
 rust/kernel/user.rs               |   1 -
 samples/rust/Kconfig              |  10 +
 samples/rust/Makefile             |   1 +
 samples/rust/rust_rofs.rs         | 202 ++++++++
 scripts/generate_rust_analyzer.py |   2 +-
 30 files changed, 4555 insertions(+), 262 deletions(-)
 create mode 100644 fs/rust-ext2/Kconfig
 create mode 100644 fs/rust-ext2/Makefile
 create mode 100644 fs/rust-ext2/defs.rs
 create mode 100644 fs/rust-ext2/ext2.rs
 create mode 100644 fs/tarfs/Kconfig
 create mode 100644 fs/tarfs/Makefile
 create mode 100644 fs/tarfs/defs.rs
 create mode 100644 fs/tarfs/tar.rs
 delete mode 100644 rust/kernel/file.rs
 create mode 100644 rust/kernel/folio.rs
 create mode 100644 rust/kernel/fs.rs
 create mode 100644 rust/kernel/fs/address_space.rs
 create mode 100644 rust/kernel/fs/dentry.rs
 create mode 100644 rust/kernel/fs/file.rs
 create mode 100644 rust/kernel/fs/inode.rs
 create mode 100644 rust/kernel/fs/iomap.rs
 create mode 100644 rust/kernel/fs/sb.rs
 create mode 100644 samples/rust/rust_rofs.rs


base-commit: 183ea65d1fcd71039cf4d111a22d69c337bfd344
-- 
2.34.1


