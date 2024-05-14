Return-Path: <linux-fsdevel+bounces-19449-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9BCF8C5712
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 15:27:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5001DB23169
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 13:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E8816D314;
	Tue, 14 May 2024 13:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YdxhE4FZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDD915CD73;
	Tue, 14 May 2024 13:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715692688; cv=none; b=hoQuc6pyTjDe3mzzUcf5MYHcKoPVzBLRHYsnwBNIDd6qmTjYphiJQ4TXfmND/GwnMJvb/OiPbIo2VL9p8mvFo2uorLpOluNDbslmoOSttCcqIuMX650rnm8mNZyrsa9o6uPkeLPq6Cq6fdvi5EZ6rLrRy8wdf7u/NDO58dkba5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715692688; c=relaxed/simple;
	bh=KpI7laXRagsoBm2/ecjcy0/NX4B2qwZNWyZ211Mng3o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lss1aaXz6nTXV6goDYTTAMlyM6flsgJCD4Z06s15zkrZvwsmg+IYIP4qYzijqkzI8Us3q6BfROsylv0OkVOtKyJ7+H3nHWAnaDhwfIWYPgcy9FbVHp6+DRf2GCAS5KcBpz8K5edYEbXbhRnC8aU4TnWsPsq/oGHIsBg1tZ/e/70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YdxhE4FZ; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1edf506b216so37987155ad.2;
        Tue, 14 May 2024 06:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715692686; x=1716297486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ditYxIjvIwYfZMbjRiDiDMz0imCc7L1hhHyY6o5PGUE=;
        b=YdxhE4FZ4n6K2vmgBFKQs15BSxcVQ+3md5t9T1UhsVsR1eBsDXb8onZdjJYdKWwS+A
         9c0nRLpLErfzFbm7LzkEH17Azgq73IWCLQTWkxV2hYYWDqld06MM0YXB1wlS5VHVNLmL
         gbN1gQkklIZYzik7E+cyecAZrnmgkQummm18Xn9a5q9Bs1v0WgTuwNYxkRO0LCeQ8C7x
         fyuR1MFipaqo+n3Zb6tYv7+cLcySjfmhKoGnPTIaVnNJq8KFx0CyYV/pmhLGp5QGRCXq
         RKY2Y9LCbrjuOXv6IB/PEyxiobYUnyWRl2KtwkTkzQFU25DDsE/7t3Z3RB1bEVkSzbdQ
         XOBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715692686; x=1716297486;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ditYxIjvIwYfZMbjRiDiDMz0imCc7L1hhHyY6o5PGUE=;
        b=jK87r24ArtANb1bPXFDnGT9k/hpipK3TjCllFVy8I+O34vJ647dxzXpgjS3xoQYtyu
         b8IejjFacVPNpWS2DozYKdvtDqav5GkcOSEoOxyj2W4CXuIAngEYrY31FK8L5zSltC0P
         RM4z+Dkv5Zy6DeEIJ/43bWR2MREMUm1auGKFz/4CW1G2Be4IXQPUBKEFpKM3wwQ/a9Ui
         fKNBwCVox05z7hYu2iXR8ql4XLyJneAbNsZcmk4PxlGRpyJUt9vOixrwN6oollsBVc9Y
         S7R3Ug39/SdJ7y2uhID3y/NnwnajjK/TICyJswnhZ2Th7PQpiNycwdPVWYIJ+aXgIl8Q
         0JYQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7v7oyHuJihus916+kCxPbmC0+N6wwqnecirpX7XjxvBPwp3/7F77bMiP0yDUXJ2cnEYkMXf4jBlA9xh+G1w8ZL9MJSzwqFq7EiH8xJu5Nym2VIHa0Q8FEPQ5wlY4le8iJuoVBylDThbg1+6llfYa5izmZySvcQkfRkeIaiGqBqYv48931RXlbxznc
X-Gm-Message-State: AOJu0YzUUcVRiBFMJD1Aw0hp3/5Eby83Bng3oo+RDZknsPVo0dCWB4z4
	cnpik4VXjmIKmW2mXToTqTaHNQcXu/EIRZ6qU6eYGjRRNJU4c65a
X-Google-Smtp-Source: AGHT+IE0gyW+xtC1hhGIfGBO+8KKiijIyQzhfltWcILbAgD7XVPpxiQ9tkxyxF35/PoF78LZmD0Y+w==
X-Received: by 2002:a17:903:2cf:b0:1e4:436e:801b with SMTP id d9443c01a7336-1ef441c113dmr163356935ad.67.1715692685848;
        Tue, 14 May 2024 06:18:05 -0700 (PDT)
Received: from wedsonaf-dev.. ([50.204.89.32])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1ef0b9d18a4sm97277335ad.56.2024.05.14.06.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 06:18:05 -0700 (PDT)
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
Subject: [RFC PATCH v2 27/30] rust: fs: add `iomap` module
Date: Tue, 14 May 2024 10:17:08 -0300
Message-Id: <20240514131711.379322-28-wedsonaf@gmail.com>
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

Allow file systems to implement their address space operations via
iomap, which delegates a lot of the complexity to common code.

Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
 rust/bindings/bindings_helper.h |   1 +
 rust/kernel/fs.rs               |   1 +
 rust/kernel/fs/iomap.rs         | 281 ++++++++++++++++++++++++++++++++
 3 files changed, 283 insertions(+)
 create mode 100644 rust/kernel/fs/iomap.rs

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index f4c7c3951dbe..629fce394dbe 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -13,6 +13,7 @@
 #include <linux/file.h>
 #include <linux/fs.h>
 #include <linux/fs_context.h>
+#include <linux/iomap.h>
 #include <linux/jiffies.h>
 #include <linux/mdio.h>
 #include <linux/pagemap.h>
diff --git a/rust/kernel/fs.rs b/rust/kernel/fs.rs
index 4d90b23735bc..7a1c4884c370 100644
--- a/rust/kernel/fs.rs
+++ b/rust/kernel/fs.rs
@@ -19,6 +19,7 @@
 pub mod dentry;
 pub mod file;
 pub mod inode;
+pub mod iomap;
 pub mod sb;
 
 /// The offset of a file in a file system.
diff --git a/rust/kernel/fs/iomap.rs b/rust/kernel/fs/iomap.rs
new file mode 100644
index 000000000000..e48e200e555e
--- /dev/null
+++ b/rust/kernel/fs/iomap.rs
@@ -0,0 +1,281 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! File system io maps.
+//!
+//! This module allows Rust code to use iomaps to implement filesystems.
+//!
+//! C headers: [`include/linux/iomap.h`](srctree/include/linux/iomap.h)
+
+use super::{address_space, FileSystem, INode, Offset};
+use crate::error::{from_result, Result};
+use crate::{bindings, block};
+use core::marker::PhantomData;
+
+/// The type of mapping.
+///
+/// This is used in [`Map`].
+#[repr(u16)]
+pub enum Type {
+    /// No blocks allocated, need allocation.
+    Hole = bindings::IOMAP_HOLE as u16,
+
+    /// Delayed allocation blocks.
+    DelAlloc = bindings::IOMAP_DELALLOC as u16,
+
+    /// Blocks allocated at the given address.
+    Mapped = bindings::IOMAP_MAPPED as u16,
+
+    /// Blocks allocated at the given address in unwritten state.
+    Unwritten = bindings::IOMAP_UNWRITTEN as u16,
+
+    /// Data inline in the inode.
+    Inline = bindings::IOMAP_INLINE as u16,
+}
+
+/// Flags usable in [`Map`], in [`Map::set_flags`] in particular.
+pub mod map_flags {
+    /// Indicates that the blocks have been newly allocated and need zeroing for areas that no data
+    /// is copied to.
+    pub const NEW: u16 = bindings::IOMAP_F_NEW as u16;
+
+    /// Indicates that the inode has uncommitted metadata needed to access written data and
+    /// requires fdatasync to commit them to persistent storage. This needs to take into account
+    /// metadata changes that *may* be made at IO completion, such as file size updates from direct
+    /// IO.
+    pub const DIRTY: u16 = bindings::IOMAP_F_DIRTY as u16;
+
+    /// Indicates that the blocks are shared, and will need to be unshared as part a write.
+    pub const SHARED: u16 = bindings::IOMAP_F_SHARED as u16;
+
+    /// Indicates that the iomap contains the merge of multiple block mappings.
+    pub const MERGED: u16 = bindings::IOMAP_F_MERGED as u16;
+
+    /// Indicates that the file system requires the use of buffer heads for this mapping.
+    pub const BUFFER_HEAD: u16 = bindings::IOMAP_F_BUFFER_HEAD as u16;
+
+    /// Indicates that the iomap is for an extended attribute extent rather than a file data
+    /// extent.
+    pub const XATTR: u16 = bindings::IOMAP_F_XATTR as u16;
+
+    /// Indicates to the iomap_end method that the file size has changed as the result of this
+    /// write operation.
+    pub const SIZE_CHANGED: u16 = bindings::IOMAP_F_SIZE_CHANGED as u16;
+
+    /// Indicates that the iomap is not valid any longer and the file range it covers needs to be
+    /// remapped by the high level before the operation can proceed.
+    pub const STALE: u16 = bindings::IOMAP_F_STALE as u16;
+
+    /// Flags from 0x1000 up are for file system specific usage.
+    pub const PRIVATE: u16 = bindings::IOMAP_F_PRIVATE as u16;
+}
+
+/// A map from address space to block device.
+#[repr(transparent)]
+pub struct Map<'a>(pub bindings::iomap, PhantomData<&'a ()>);
+
+impl<'a> Map<'a> {
+    /// Sets the map type.
+    pub fn set_type(&mut self, t: Type) -> &mut Self {
+        self.0.type_ = t as u16;
+        self
+    }
+
+    /// Sets the file offset, in bytes.
+    pub fn set_offset(&mut self, v: Offset) -> &mut Self {
+        self.0.offset = v;
+        self
+    }
+
+    /// Sets the length of the mapping, in bytes.
+    pub fn set_length(&mut self, len: u64) -> &mut Self {
+        self.0.length = len;
+        self
+    }
+
+    /// Sets the mapping flags.
+    ///
+    /// Values come from the [`map_flags`] module.
+    pub fn set_flags(&mut self, flags: u16) -> &mut Self {
+        self.0.flags = flags;
+        self
+    }
+
+    /// Sets the disk offset of the mapping, in bytes.
+    pub fn set_addr(&mut self, addr: u64) -> &mut Self {
+        self.0.addr = addr;
+        self
+    }
+
+    /// Sets the block device of the mapping.
+    pub fn set_bdev(&mut self, bdev: Option<&'a block::Device>) -> &mut Self {
+        self.0.bdev = if let Some(b) = bdev {
+            b.0.get()
+        } else {
+            core::ptr::null_mut()
+        };
+        self
+    }
+}
+
+/// Flags passed to [`Operations::begin`] and [`Operations::end`].
+pub mod flags {
+    /// Writing, must allocate block.
+    pub const WRITE: u32 = bindings::IOMAP_WRITE;
+
+    /// Zeroing operation, may skip holes.
+    pub const ZERO: u32 = bindings::IOMAP_ZERO;
+
+    /// Report extent status, e.g. FIEMAP.
+    pub const REPORT: u32 = bindings::IOMAP_REPORT;
+
+    /// Mapping for page fault.
+    pub const FAULT: u32 = bindings::IOMAP_FAULT;
+
+    /// Direct I/O.
+    pub const DIRECT: u32 = bindings::IOMAP_DIRECT;
+
+    /// Do not block.
+    pub const NOWAIT: u32 = bindings::IOMAP_NOWAIT;
+
+    /// Only pure overwrites allowed.
+    pub const OVERWRITE_ONLY: u32 = bindings::IOMAP_OVERWRITE_ONLY;
+
+    /// `unshare_file_range`.
+    pub const UNSHARE: u32 = bindings::IOMAP_UNSHARE;
+
+    /// DAX mapping.
+    pub const DAX: u32 = bindings::IOMAP_DAX;
+}
+
+/// Operations implemented by iomap users.
+pub trait Operations {
+    /// File system that these operations are compatible with.
+    type FileSystem: FileSystem + ?Sized;
+
+    /// Returns the existing mapping at `pos`, or reserves space starting at `pos` for up to
+    /// `length`, as long as it can be done as a single mapping. The actual length is returned in
+    /// `iomap`.
+    ///
+    /// The values of `flags` come from the [`flags`] module.
+    fn begin<'a>(
+        inode: &'a INode<Self::FileSystem>,
+        pos: Offset,
+        length: Offset,
+        flags: u32,
+        map: &mut Map<'a>,
+        srcmap: &mut Map<'a>,
+    ) -> Result;
+
+    /// Commits and/or unreserves space previously allocated using [`Operations::begin`]. `writte`n
+    /// indicates the length of the successful write operation which needs to be commited, while
+    /// the rest needs to be unreserved. `written` might be zero if no data was written.
+    ///
+    /// The values of `flags` come from the [`flags`] module.
+    fn end<'a>(
+        _inode: &'a INode<Self::FileSystem>,
+        _pos: Offset,
+        _length: Offset,
+        _written: isize,
+        _flags: u32,
+        _map: &Map<'a>,
+    ) -> Result {
+        Ok(())
+    }
+}
+
+/// Returns address space oprerations backed by iomaps.
+pub const fn ro_aops<T: Operations + ?Sized>() -> address_space::Ops<T::FileSystem> {
+    struct Table<T: Operations + ?Sized>(PhantomData<T>);
+    impl<T: Operations + ?Sized> Table<T> {
+        const MAP_TABLE: bindings::iomap_ops = bindings::iomap_ops {
+            iomap_begin: Some(Self::iomap_begin_callback),
+            iomap_end: Some(Self::iomap_end_callback),
+        };
+
+        extern "C" fn iomap_begin_callback(
+            inode_ptr: *mut bindings::inode,
+            pos: Offset,
+            length: Offset,
+            flags: u32,
+            map: *mut bindings::iomap,
+            srcmap: *mut bindings::iomap,
+        ) -> i32 {
+            from_result(|| {
+                // SAFETY: The C API guarantees that `inode_ptr` is a valid inode.
+                let inode = unsafe { INode::from_raw(inode_ptr) };
+                T::begin(
+                    inode,
+                    pos,
+                    length,
+                    flags,
+                    // SAFETY: The C API guarantees that `map` is valid for write.
+                    unsafe { &mut *map.cast::<Map<'_>>() },
+                    // SAFETY: The C API guarantees that `srcmap` is valid for write.
+                    unsafe { &mut *srcmap.cast::<Map<'_>>() },
+                )?;
+                Ok(0)
+            })
+        }
+
+        extern "C" fn iomap_end_callback(
+            inode_ptr: *mut bindings::inode,
+            pos: Offset,
+            length: Offset,
+            written: isize,
+            flags: u32,
+            map: *mut bindings::iomap,
+        ) -> i32 {
+            from_result(|| {
+                // SAFETY: The C API guarantees that `inode_ptr` is a valid inode.
+                let inode = unsafe { INode::from_raw(inode_ptr) };
+                // SAFETY: The C API guarantees that `map` is valid for read.
+                T::end(inode, pos, length, written, flags, unsafe {
+                    &*map.cast::<Map<'_>>()
+                })?;
+                Ok(0)
+            })
+        }
+
+        const TABLE: bindings::address_space_operations = bindings::address_space_operations {
+            writepage: None,
+            read_folio: Some(Self::read_folio_callback),
+            writepages: None,
+            dirty_folio: None,
+            readahead: Some(Self::readahead_callback),
+            write_begin: None,
+            write_end: None,
+            bmap: Some(Self::bmap_callback),
+            invalidate_folio: Some(bindings::iomap_invalidate_folio),
+            release_folio: Some(bindings::iomap_release_folio),
+            free_folio: None,
+            direct_IO: Some(bindings::noop_direct_IO),
+            migrate_folio: None,
+            launder_folio: None,
+            is_partially_uptodate: None,
+            is_dirty_writeback: None,
+            error_remove_folio: None,
+            swap_activate: None,
+            swap_deactivate: None,
+            swap_rw: None,
+        };
+
+        extern "C" fn read_folio_callback(
+            _file: *mut bindings::file,
+            folio: *mut bindings::folio,
+        ) -> i32 {
+            // SAFETY: `folio` is just forwarded from C and `Self::MAP_TABLE` is always valid.
+            unsafe { bindings::iomap_read_folio(folio, &Self::MAP_TABLE) }
+        }
+
+        extern "C" fn readahead_callback(rac: *mut bindings::readahead_control) {
+            // SAFETY: `rac` is just forwarded from C and `Self::MAP_TABLE` is always valid.
+            unsafe { bindings::iomap_readahead(rac, &Self::MAP_TABLE) }
+        }
+
+        extern "C" fn bmap_callback(mapping: *mut bindings::address_space, block: u64) -> u64 {
+            // SAFETY: `mapping` is just forwarded from C and `Self::MAP_TABLE` is always valid.
+            unsafe { bindings::iomap_bmap(mapping, block, &Self::MAP_TABLE) }
+        }
+    }
+    address_space::Ops(&Table::<T>::TABLE, PhantomData)
+}
-- 
2.34.1


