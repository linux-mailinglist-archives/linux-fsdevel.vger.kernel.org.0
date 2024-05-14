Return-Path: <linux-fsdevel+bounces-19451-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 759688C5716
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 15:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E97A31F217F0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 13:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E7A16F909;
	Tue, 14 May 2024 13:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j/Rgps5E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A580115FA92;
	Tue, 14 May 2024 13:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715692691; cv=none; b=YwRGiYcC+l//Y8WuxzravuMJ+H7Fe5t2zgFqvaUYxpvvnxNL5kga2oBW5P27qcWCTNIIqT4+RB7d0uZrqXDCiKe7GJOK2AhFWNmyA5UgEQ5hkCZ7FU4a/yG03ZUIa5RJYIk1mP2wr8HJ03XdPsOwPofu1E6WEa3ACO+FWT4kGNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715692691; c=relaxed/simple;
	bh=NkyBIPvyqKD3QaaIvYVVRWJ6C2c5hVFwRcCGK0ZYyF4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P+4/5N6XtrUGJCCVAHG5rF4xxF777tR0F/J0yIxfJ4he8r62ketJ0zar5gcTK+rjKPwKmQWQe3PZo4EK7osbbJHJZeX0yEYPjY9kaFGw/hMZBaia5Lcm8bFSH6FAR7e9+8xb4BngZUEmg1cIU6zYFXV1bW/CXbgiJdAA6wJRawo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j/Rgps5E; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1ed96772f92so44798045ad.0;
        Tue, 14 May 2024 06:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715692688; x=1716297488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AUAgZILvsJPk3lUOQX5V2zM1SwWQswShe/1otOCn5pk=;
        b=j/Rgps5EI9HJBZQSLpZEMg5Xy2KWJShM1Z4R5SFZuCYGC4t6NWf5mubWGFtcTRRIhu
         6xdWm6HhrGPi274IFO5wAfc3uX5x1ILCUa+KU9gWXxx4sPDJts1RcuLZcrN/E1FaBIlc
         KuAFBBYkHl6e2gzJWVuDzhVHepELbnFKNpgxRz0KsNEfEHkAZDfrJcX8nm8B4AlrdiX+
         fCFMEPSgmfpNAEcix03ghpz15pKv2zwx9XyWqvu1eRI8wHIHV899pg7xoCoxT/5SfZPU
         azoB2euhvwzqenQKHbeK2KAZIwYj0NMPoYXQfSgvbyZaFcqUaTsrYJ7nyt5At09vlgMD
         HiLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715692688; x=1716297488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AUAgZILvsJPk3lUOQX5V2zM1SwWQswShe/1otOCn5pk=;
        b=hRGp3issiC7KJvMMwPRJYbAhpkvms96odjHeescHjBAERhW+Cxmuv1EuswJt0Zkh36
         YFv9qLePx9yr3+14cBj1XMs1+Pf3qqWd7jLLn1Squq5PvwRvVaFMQcAw6NhtuAmImgvO
         ShMkRQ+RoXfhHc1OO8BzCq+E6yryUBugXlJ7L3xxJ/ygvkrEQdGTInRKefhUloqd5WOz
         UuENnrcHt2ZYRB08DEAe5xgRIMjoMMlaq4xTXDwhxOXylgQjcAdfx8M8waH68n8iuUF5
         boOaa16p5rgiN56761ujKBBSP52nT0bQt4HUTwXFLpe7//jUH426Fmr8oMwODyI5ID3I
         bXpA==
X-Forwarded-Encrypted: i=1; AJvYcCXTNWITev+7CBq9pbN+3LNahg5+miDe9gDdUmFitt/M/QBjwyIeyalhoQdEj7PX+fOQ3uqYqk9F/WvJIomWIL1GMqxfL9Y4UGi9QXK4n5Jz/9N3+VX0TZ4QWHNgkkAb9gCQzPEcEQ2iVytTfqFyJx3jMI+pMXt0SIjwej3ixNTTzp81FKb/foXeqQdn
X-Gm-Message-State: AOJu0Yy/jhwIx/sAd0RnYZ4yQShwPB2mYmhrUwk6ZouIN2Pv0gG/nFXz
	d4WtbLKkcu1XWREmiviBD6/Zd1S7CgMaaEmYnYr0IQkLukJzNW5u
X-Google-Smtp-Source: AGHT+IFpimOtA0H+30BM3dZuOxd//sP8WnqJBhG572jFOU9vsmOgSflGyA3bx+dH4Jc0ddDwLunjPw==
X-Received: by 2002:a17:903:1ce:b0:1e3:d4eb:a0f2 with SMTP id d9443c01a7336-1ef4404956emr147449585ad.51.1715692687803;
        Tue, 14 May 2024 06:18:07 -0700 (PDT)
Received: from wedsonaf-dev.. ([50.204.89.32])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1ef0b9d18a4sm97277335ad.56.2024.05.14.06.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 06:18:07 -0700 (PDT)
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
	Wedson Almeida Filho <walmeida@microsoft.com>
Subject: [RFC PATCH v2 29/30] tarfs: introduce tar fs
Date: Tue, 14 May 2024 10:17:10 -0300
Message-Id: <20240514131711.379322-30-wedsonaf@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240514131711.379322-1-wedsonaf@gmail.com>
References: <20240514131711.379322-1-wedsonaf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wedson Almeida Filho <walmeida@microsoft.com>

It is a file system based on tar files and an index appended to them (to
facilitate finding fs entries without having to traverse the whole tar
file).

Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
 fs/Kconfig                        |   1 +
 fs/Makefile                       |   1 +
 fs/tarfs/Kconfig                  |  15 ++
 fs/tarfs/Makefile                 |   8 +
 fs/tarfs/defs.rs                  |  80 ++++++
 fs/tarfs/tar.rs                   | 394 ++++++++++++++++++++++++++++++
 scripts/generate_rust_analyzer.py |   2 +-
 7 files changed, 500 insertions(+), 1 deletion(-)
 create mode 100644 fs/tarfs/Kconfig
 create mode 100644 fs/tarfs/Makefile
 create mode 100644 fs/tarfs/defs.rs
 create mode 100644 fs/tarfs/tar.rs

diff --git a/fs/Kconfig b/fs/Kconfig
index a46b0cbc4d8f..2cbd99d6784c 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -337,6 +337,7 @@ source "fs/sysv/Kconfig"
 source "fs/ufs/Kconfig"
 source "fs/erofs/Kconfig"
 source "fs/vboxsf/Kconfig"
+source "fs/tarfs/Kconfig"
 
 endif # MISC_FILESYSTEMS
 
diff --git a/fs/Makefile b/fs/Makefile
index 6ecc9b0a53f2..d8bbda73e3a9 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -129,3 +129,4 @@ obj-$(CONFIG_EFIVAR_FS)		+= efivarfs/
 obj-$(CONFIG_EROFS_FS)		+= erofs/
 obj-$(CONFIG_VBOXSF_FS)		+= vboxsf/
 obj-$(CONFIG_ZONEFS_FS)		+= zonefs/
+obj-$(CONFIG_TARFS_FS)		+= tarfs/
diff --git a/fs/tarfs/Kconfig b/fs/tarfs/Kconfig
new file mode 100644
index 000000000000..fd4f1ae0f83d
--- /dev/null
+++ b/fs/tarfs/Kconfig
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+
+config TARFS_FS
+	tristate "TAR file system support"
+	depends on RUST && BLOCK
+	help
+	  This is a simple read-only file system intended for mounting
+	  tar files that have had an index appened to them.
+
+	  To compile this file system support as a module, choose M here: the
+	  module will be called tarfs.
+
+	  If you don't know whether you need it, then you don't need it:
+	  answer N.
diff --git a/fs/tarfs/Makefile b/fs/tarfs/Makefile
new file mode 100644
index 000000000000..011c5d64fbe3
--- /dev/null
+++ b/fs/tarfs/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for the linux tarfs filesystem routines.
+#
+
+obj-$(CONFIG_TARFS_FS) += tarfs.o
+
+tarfs-y := tar.o
diff --git a/fs/tarfs/defs.rs b/fs/tarfs/defs.rs
new file mode 100644
index 000000000000..7481b75aaab2
--- /dev/null
+++ b/fs/tarfs/defs.rs
@@ -0,0 +1,80 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Definitions of tarfs structures.
+
+use kernel::types::LE;
+
+/// Flags used in [`Inode::flags`].
+pub mod inode_flags {
+    /// Indicates that the inode is opaque.
+    ///
+    /// When set, inode will have the "trusted.overlay.opaque" set to "y" at runtime.
+    pub const OPAQUE: u8 = 0x1;
+}
+
+kernel::derive_readable_from_bytes! {
+    /// An inode in the tarfs inode table.
+    #[repr(C)]
+    pub struct Inode {
+        /// The mode of the inode.
+        ///
+        /// The bottom 9 bits are the rwx bits for owner, group, all.
+        ///
+        /// The bits in the [`S_IFMT`] mask represent the file mode.
+        pub mode: LE<u16>,
+
+        /// Tarfs flags for the inode.
+        ///
+        /// Values are drawn from the [`inode_flags`] module.
+        pub flags: u8,
+
+        /// The bottom 4 bits represent the top 4 bits of mtime.
+        pub hmtime: u8,
+
+        /// The owner of the inode.
+        pub owner: LE<u32>,
+
+        /// The group of the inode.
+        pub group: LE<u32>,
+
+        /// The bottom 32 bits of mtime.
+        pub lmtime: LE<u32>,
+
+        /// Size of the contents of the inode.
+        pub size: LE<u64>,
+
+        /// Either the offset to the data, or the major and minor numbers of a device.
+        ///
+        /// For the latter, the 32 LSB are the minor, and the 32 MSB are the major numbers.
+        pub offset: LE<u64>,
+    }
+
+    /// An entry in a tarfs directory entry table.
+    #[repr(C)]
+    pub struct DirEntry {
+        /// The inode number this entry refers to.
+        pub ino: LE<u64>,
+
+        /// The offset to the name of the entry.
+        pub name_offset: LE<u64>,
+
+        /// The length of the name of the entry.
+        pub name_len: LE<u64>,
+
+        /// The type of entry.
+        pub etype: u8,
+
+        /// Unused padding.
+        pub _padding: [u8; 7],
+    }
+
+    /// The super-block of a tarfs instance.
+    #[repr(C)]
+    pub struct Header {
+        /// The offset to the beginning of the inode-table.
+        pub inode_table_offset: LE<u64>,
+
+        /// The number of inodes in the file system.
+        pub inode_count: LE<u64>,
+    }
+}
diff --git a/fs/tarfs/tar.rs b/fs/tarfs/tar.rs
new file mode 100644
index 000000000000..a3f6e468e566
--- /dev/null
+++ b/fs/tarfs/tar.rs
@@ -0,0 +1,394 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! File system based on tar files and an index.
+
+use core::mem::size_of;
+use defs::*;
+use kernel::fs::{
+    self, address_space, dentry, dentry::DEntry, file, file::File, inode, inode::INode,
+    inode::Type, iomap, sb, sb::SuperBlock, Offset, Stat,
+};
+use kernel::types::{ARef, Either, FromBytes, Locked};
+use kernel::{c_str, prelude::*, str::CString, user};
+
+pub mod defs;
+
+kernel::module_fs! {
+    type: TarFs,
+    name: "tarfs",
+    author: "Wedson Almeida Filho <walmeida@microsoft.com>",
+    description: "File system for indexed tar files",
+    license: "GPL",
+}
+
+const SECTOR_SIZE: u64 = 512;
+const TARFS_BSIZE: u64 = 1 << TARFS_BSIZE_BITS;
+const TARFS_BSIZE_BITS: u8 = 12;
+const SECTORS_PER_BLOCK: u64 = TARFS_BSIZE / SECTOR_SIZE;
+const TARFS_MAGIC: usize = 0x54415246;
+
+static_assert!(SECTORS_PER_BLOCK > 0);
+
+struct INodeData {
+    offset: u64,
+    flags: u8,
+}
+
+struct TarFs {
+    data_size: u64,
+    inode_table_offset: u64,
+    inode_count: u64,
+    mapper: inode::Mapper,
+}
+
+impl TarFs {
+    fn iget(sb: &SuperBlock<Self>, ino: u64) -> Result<ARef<INode<Self>>> {
+        // Check that the inode number is valid.
+        let h = sb.data();
+        if ino == 0 || ino > h.inode_count {
+            return Err(ENOENT);
+        }
+
+        // Create an inode or find an existing (cached) one.
+        let mut inode = match sb.get_or_create_inode(ino)? {
+            Either::Left(existing) => return Ok(existing),
+            Either::Right(new) => new,
+        };
+
+        static_assert!((TARFS_BSIZE as usize) % size_of::<Inode>() == 0);
+
+        // Load inode details from storage.
+        let offset = h.inode_table_offset + (ino - 1) * u64::try_from(size_of::<Inode>())?;
+        let b = h.mapper.mapped_folio(offset.try_into()?)?;
+        let idata = Inode::from_bytes(&b, 0).ok_or(EIO)?;
+
+        let mode = idata.mode.value();
+
+        // Ignore inodes that have unknown mode bits.
+        if (mode & !(fs::mode::S_IFMT | 0o777)) != 0 {
+            return Err(ENOENT);
+        }
+
+        const DIR_FOPS: file::Ops<TarFs> = file::Ops::new::<TarFs>();
+        const DIR_IOPS: inode::Ops<TarFs> = inode::Ops::new::<TarFs>();
+        const FILE_AOPS: address_space::Ops<TarFs> = iomap::ro_aops::<TarFs>();
+
+        let size = idata.size.value();
+        let doffset = idata.offset.value();
+        let secs = u64::from(idata.lmtime.value()) | (u64::from(idata.hmtime & 0xf) << 32);
+        let ts = kernel::time::Timespec::new(secs, 0)?;
+        let typ = match mode & fs::mode::S_IFMT {
+            fs::mode::S_IFREG => {
+                inode
+                    .set_fops(file::Ops::generic_ro_file())
+                    .set_aops(FILE_AOPS);
+                Type::Reg
+            }
+            fs::mode::S_IFDIR => {
+                inode.set_iops(DIR_IOPS).set_fops(DIR_FOPS);
+                Type::Dir
+            }
+            fs::mode::S_IFLNK => {
+                inode.set_iops(inode::Ops::simple_symlink_inode());
+                Type::Lnk(Some(Self::get_link(sb, doffset, size)?))
+            }
+            fs::mode::S_IFSOCK => Type::Sock,
+            fs::mode::S_IFIFO => Type::Fifo,
+            fs::mode::S_IFCHR => Type::Chr((doffset >> 32) as u32, doffset as u32),
+            fs::mode::S_IFBLK => Type::Blk((doffset >> 32) as u32, doffset as u32),
+            _ => return Err(ENOENT),
+        };
+        inode.init(inode::Params {
+            typ,
+            mode: mode & 0o777,
+            size: size.try_into()?,
+            blocks: (idata.size.value() + TARFS_BSIZE - 1) / TARFS_BSIZE,
+            nlink: 1,
+            uid: idata.owner.value(),
+            gid: idata.group.value(),
+            ctime: ts,
+            mtime: ts,
+            atime: ts,
+            value: INodeData {
+                offset: doffset,
+                flags: idata.flags,
+            },
+        })
+    }
+
+    fn name_eq(sb: &SuperBlock<Self>, mut name: &[u8], offset: u64) -> Result<bool> {
+        let ret =
+            sb.data()
+                .mapper
+                .for_each_page(offset as Offset, name.len().try_into()?, |data| {
+                    if data != &name[..data.len()] {
+                        return Ok(Some(()));
+                    }
+                    name = &name[data.len()..];
+                    Ok(None)
+                })?;
+        Ok(ret.is_none())
+    }
+
+    fn read_name(sb: &SuperBlock<Self>, name: &mut [u8], offset: u64) -> Result {
+        let mut copy_to = 0;
+        sb.data()
+            .mapper
+            .for_each_page(offset as Offset, name.len().try_into()?, |data| {
+                name[copy_to..][..data.len()].copy_from_slice(data);
+                copy_to += data.len();
+                Ok(None::<()>)
+            })?;
+        Ok(())
+    }
+
+    fn get_link(sb: &SuperBlock<Self>, offset: u64, len: u64) -> Result<CString> {
+        let name_len: usize = len.try_into()?;
+        let alloc_len = name_len.checked_add(1).ok_or(ENOMEM)?;
+        let mut name = Box::new_slice(alloc_len, b'\0', GFP_NOFS)?;
+        Self::read_name(sb, &mut name[..name_len], offset)?;
+        Ok(name.try_into()?)
+    }
+}
+
+impl fs::FileSystem for TarFs {
+    type Data = Box<Self>;
+    type INodeData = INodeData;
+    const NAME: &'static CStr = c_str!("tar");
+    const SUPER_TYPE: sb::Type = sb::Type::BlockDev;
+
+    fn fill_super(
+        sb: &mut SuperBlock<Self, sb::New>,
+        mapper: Option<inode::Mapper>,
+    ) -> Result<Self::Data> {
+        let Some(mapper) = mapper else {
+            return Err(EINVAL);
+        };
+
+        let scount = sb.sector_count();
+        if scount < SECTORS_PER_BLOCK {
+            pr_err!("Block device is too small: sector count={scount}\n");
+            return Err(ENXIO);
+        }
+
+        if sb.min_blocksize(SECTOR_SIZE as i32) != SECTOR_SIZE as i32 {
+            pr_err!("Block size not supported\n");
+            return Err(EIO);
+        }
+
+        let tarfs = {
+            let offset = (scount - 1) * SECTOR_SIZE;
+            let mapped = mapper.mapped_folio(offset.try_into()?)?;
+            let hdr = Header::from_bytes(&mapped, 0).ok_or(EIO)?;
+            let inode_table_offset = hdr.inode_table_offset.value();
+            let inode_count = hdr.inode_count.value();
+            drop(mapped);
+            Box::new(
+                TarFs {
+                    inode_table_offset,
+                    inode_count,
+                    data_size: scount.checked_mul(SECTOR_SIZE).ok_or(ERANGE)?,
+                    mapper,
+                },
+                GFP_KERNEL,
+            )?
+        };
+
+        // Check that the inode table starts within the device data and is aligned to the block
+        // size.
+        if tarfs.inode_table_offset >= tarfs.data_size {
+            pr_err!(
+                "inode table offset beyond data size: {} >= {}\n",
+                tarfs.inode_table_offset,
+                tarfs.data_size
+            );
+            return Err(E2BIG);
+        }
+
+        if tarfs.inode_table_offset % SECTOR_SIZE != 0 {
+            pr_err!(
+                "inode table offset not aligned to sector size: {}\n",
+                tarfs.inode_table_offset,
+            );
+            return Err(EDOM);
+        }
+
+        // Check that the last inode is within bounds (and that there is no overflow when
+        // calculating its offset).
+        let offset = tarfs
+            .inode_count
+            .checked_mul(u64::try_from(size_of::<Inode>())?)
+            .ok_or(ERANGE)?
+            .checked_add(tarfs.inode_table_offset)
+            .ok_or(ERANGE)?;
+        if offset > tarfs.data_size {
+            pr_err!(
+                "inode table extends beyond the data size : {} > {}\n",
+                tarfs.inode_table_offset + (tarfs.inode_count * size_of::<Inode>() as u64),
+                tarfs.data_size,
+            );
+            return Err(E2BIG);
+        }
+
+        sb.set_magic(TARFS_MAGIC);
+        Ok(tarfs)
+    }
+
+    fn init_root(sb: &SuperBlock<Self>) -> Result<dentry::Root<Self>> {
+        let inode = Self::iget(sb, 1)?;
+        dentry::Root::try_new(inode)
+    }
+
+    fn read_xattr(
+        _: &DEntry<Self>,
+        inode: &INode<Self>,
+        name: &CStr,
+        outbuf: &mut [u8],
+    ) -> Result<usize> {
+        if inode.data().flags & inode_flags::OPAQUE == 0
+            || name.as_bytes() != b"trusted.overlay.opaque"
+        {
+            return Err(ENODATA);
+        }
+
+        if !outbuf.is_empty() {
+            outbuf[0] = b'y';
+        }
+
+        Ok(1)
+    }
+
+    fn statfs(dentry: &DEntry<Self>) -> Result<Stat> {
+        let data = dentry.super_block().data();
+        Ok(Stat {
+            magic: TARFS_MAGIC,
+            namelen: isize::MAX,
+            bsize: TARFS_BSIZE as _,
+            blocks: data.inode_table_offset / TARFS_BSIZE,
+            files: data.inode_count,
+        })
+    }
+}
+
+impl iomap::Operations for TarFs {
+    type FileSystem = Self;
+
+    fn begin<'a>(
+        inode: &'a INode<Self>,
+        pos: Offset,
+        length: Offset,
+        _flags: u32,
+        map: &mut iomap::Map<'a>,
+        _srcmap: &mut iomap::Map<'a>,
+    ) -> Result {
+        let size = (inode.size() + 511) & !511;
+        if pos >= size {
+            map.set_offset(pos)
+                .set_length(length.try_into()?)
+                .set_flags(iomap::map_flags::MERGED)
+                .set_type(iomap::Type::Hole);
+            return Ok(());
+        }
+
+        map.set_offset(pos)
+            .set_length(core::cmp::min(length, size - pos) as u64)
+            .set_flags(iomap::map_flags::MERGED)
+            .set_type(iomap::Type::Mapped)
+            .set_bdev(Some(inode.super_block().bdev()))
+            .set_addr(u64::try_from(pos)? + inode.data().offset);
+
+        Ok(())
+    }
+}
+
+#[vtable]
+impl inode::Operations for TarFs {
+    type FileSystem = Self;
+
+    fn lookup(
+        parent: &Locked<&INode<Self>, inode::ReadSem>,
+        dentry: dentry::Unhashed<'_, Self>,
+    ) -> Result<Option<ARef<DEntry<Self>>>> {
+        let sb = parent.super_block();
+        let name = dentry.name();
+
+        let inode = sb.data().mapper.for_each_page(
+            parent.data().offset.try_into()?,
+            parent.size(),
+            |data| {
+                for e in DirEntry::from_bytes_to_slice(data).ok_or(EIO)? {
+                    if Self::name_eq(sb, name, e.name_offset.value())? {
+                        return Ok(Some(Self::iget(sb, e.ino.value())?));
+                    }
+                }
+                Ok(None)
+            },
+        )?;
+
+        dentry.splice_alias(inode)
+    }
+}
+
+#[vtable]
+impl file::Operations for TarFs {
+    type FileSystem = Self;
+
+    fn seek(file: &File<Self>, offset: Offset, whence: file::Whence) -> Result<Offset> {
+        file::generic_seek(file, offset, whence)
+    }
+
+    fn read(_: &File<Self>, _: &mut user::Writer, _: &mut Offset) -> Result<usize> {
+        Err(EISDIR)
+    }
+
+    fn read_dir(
+        _file: &File<Self>,
+        inode: &Locked<&INode<Self>, inode::ReadSem>,
+        emitter: &mut file::DirEmitter,
+    ) -> Result {
+        let sb = inode.super_block();
+        let mut name = Vec::<u8>::new();
+        let pos = emitter.pos();
+
+        if pos < 0 || pos % size_of::<DirEntry>() as i64 != 0 {
+            return Err(ENOENT);
+        }
+
+        if pos >= inode.size() {
+            return Ok(());
+        }
+
+        // Make sure the inode data doesn't overflow the data area.
+        let sizeu = u64::try_from(inode.size())?;
+        if inode.data().offset.checked_add(sizeu).ok_or(EIO)? > sb.data().data_size {
+            return Err(EIO);
+        }
+
+        sb.data().mapper.for_each_page(
+            inode.data().offset as i64 + pos,
+            inode.size() - pos,
+            |data| {
+                for e in DirEntry::from_bytes_to_slice(data).ok_or(EIO)? {
+                    let name_len = usize::try_from(e.name_len.value())?;
+                    if name_len > name.len() {
+                        name.resize(name_len, 0, GFP_NOFS)?;
+                    }
+
+                    Self::read_name(sb, &mut name[..name_len], e.name_offset.value())?;
+
+                    if !emitter.emit(
+                        size_of::<DirEntry>() as i64,
+                        &name[..name_len],
+                        e.ino.value(),
+                        file::DirEntryType::try_from(u32::from(e.etype))?,
+                    ) {
+                        return Ok(Some(()));
+                    }
+                }
+                Ok(None)
+            },
+        )?;
+
+        Ok(())
+    }
+}
diff --git a/scripts/generate_rust_analyzer.py b/scripts/generate_rust_analyzer.py
index f270c7b0cf34..6985b9e37429 100755
--- a/scripts/generate_rust_analyzer.py
+++ b/scripts/generate_rust_analyzer.py
@@ -116,7 +116,7 @@ def generate_crates(srctree, objtree, sysroot_src, external_src, cfgs):
     # Then, the rest outside of `rust/`.
     #
     # We explicitly mention the top-level folders we want to cover.
-    extra_dirs = map(lambda dir: srctree / dir, ("samples", "drivers"))
+    extra_dirs = map(lambda dir: srctree / dir, ("samples", "drivers", "fs"))
     if external_src is not None:
         extra_dirs = [external_src]
     for folder in extra_dirs:
-- 
2.34.1


