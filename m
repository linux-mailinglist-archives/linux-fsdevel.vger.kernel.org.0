Return-Path: <linux-fsdevel+bounces-19428-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7008C56E4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 15:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7810BB22334
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 13:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E359A146D6A;
	Tue, 14 May 2024 13:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RDshmNRX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCCB14601C;
	Tue, 14 May 2024 13:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715692667; cv=none; b=UImMWkN8R6GSPIB5TDFrSYHdrvmjXB6oj2SmTLl5S8hiVW0aWY0nJm1JuLAmpmksB5krXkxBV1MEgiDelvqT78wjX5+RX38h95WTObAMUNTYOlV46nM4ewWboZLPykGv+jiwPIljfNBdxXoOHJM2q/mVOu1AyhKXsJi9/d6JGeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715692667; c=relaxed/simple;
	bh=EwDN7VQvAaW1waEupY0eIODNkceeiT8B7VVRlXG69iw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=StuWGDSJMVboPBjXmBDEigvdP5veJPAjSIZSItLPoelN09OXGNcAdaNX0DyWxsN7V9tKWbyHUZ2gR9r/1IBwtHQOZB7vuYuHE24SyFXFN8stE3r4Wk5Mqa0mx0tMqHe1Eb8PcfdUk/p9kQSjrg9hElCKcGZeo9YgDrcpq9UZEyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RDshmNRX; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1ee7963db64so46676105ad.1;
        Tue, 14 May 2024 06:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715692665; x=1716297465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s9qSOOnN3derkGGBY28iQxMG2lMAOqyU86LT6GkN1mg=;
        b=RDshmNRXgnEROHLdd3yLybzO0Xcsyby590rGDdNUOxNnKUl2QgPrFTfa8XwRWv3ZOH
         DKV1h+w3eHfXy3jEcihf7Wd90u2LpQCKb/EdbtCH6EPTZAZ6X5txR4h6k/sJVB+PHsiS
         sUZLG2Clha5him5QSiSfOj+n3Yb44pSm7z6NTzEkOvb5vEUu5dNOMXCbSNcDRa5w+HsV
         GjT21IOonGIHFDbp55QkAMkl6K2dEYaqOvLlAaJoJkXXu675T0hyjan1idIx9KWbW/68
         +iwfglg8i51NEd4L3egfzoHL2qDwbJO5rGHaURCJFJHwnNMKbStG6v3uacXQjUCN/pMR
         zqKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715692665; x=1716297465;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s9qSOOnN3derkGGBY28iQxMG2lMAOqyU86LT6GkN1mg=;
        b=dhcGKEI04P84GB7rZ9sA+b50dLPIRpzr12/k6G5/Y+XZ1EtvAFdUvCEi876n+BkO66
         MX3xu80YSJ71XoD9rvbbaHelxGbTWJF6L3xVdwkmF5VuYZJ98Qivxos5cWtpQUT8TdHy
         InUB9OqKsSyFW9e2di+zXBMDGov+xHmTViM048C9OupToEF+3xdsYFfDV4E+hVaFw149
         31voJPnWEQtPKOT4oGI38d+xxkvizpTZnHCxkx+6N4bSwXnSHCysnNop4Fb9zYCIKK6o
         yZ6AzyFKF5XuQ/xV7lkeTanBLqAnfFqAPRsSPRFXL9LySFUB0j1qSvUoud5PBbX4aO2e
         vldw==
X-Forwarded-Encrypted: i=1; AJvYcCVUNvIwTVJBls9BXzFC+R1azCG9Oj91cYNWEqf5j0KGCVhTKG0FHa86dKbSFkJp026DOu3PkMNa3jjbMtYUQ5xaMtYA5M6tSEvOZ/aWsqLOdZR9LKOPPhuDujVi0YqFCB2iungMohs2Xqu/mjUI3lrCxdn9EqmEcYTQ+15sLaoDLc2d7Ukxrtonp4cs
X-Gm-Message-State: AOJu0YxpY6tnpLpJoEShp/RV1Ts7+QF9qA3CEb2rQ5+q9FkIsKHPIbpV
	2AGXXd4Wmq2Lm5xnucxAIe+2CFC94bECdFAY5YgXmmLJId5rgQ2c
X-Google-Smtp-Source: AGHT+IHdW4Whs1GE/MIA4u1iZpDAMjMeTAe0DVQP8NtdsS/SXscTCS8UHeBe22rczXQSRR/PuJjZ5w==
X-Received: by 2002:a17:902:6b82:b0:1e3:dfdc:6972 with SMTP id d9443c01a7336-1ef43d15755mr136009995ad.9.1715692664910;
        Tue, 14 May 2024 06:17:44 -0700 (PDT)
Received: from wedsonaf-dev.. ([50.204.89.32])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1ef0b9d18a4sm97277335ad.56.2024.05.14.06.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 06:17:44 -0700 (PDT)
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
Subject: [RFC PATCH v2 06/30] rust: fs: introduce `DEntry<T>`
Date: Tue, 14 May 2024 10:16:47 -0300
Message-Id: <20240514131711.379322-7-wedsonaf@gmail.com>
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

Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
 rust/helpers.c           |   6 ++
 rust/kernel/error.rs     |   2 -
 rust/kernel/fs.rs        |   1 +
 rust/kernel/fs/dentry.rs | 137 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 144 insertions(+), 2 deletions(-)
 create mode 100644 rust/kernel/fs/dentry.rs

diff --git a/rust/helpers.c b/rust/helpers.c
index c697c1c4c9d7..c7fe6917251e 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -165,6 +165,12 @@ struct file *rust_helper_get_file(struct file *f)
 EXPORT_SYMBOL_GPL(rust_helper_get_file);
 
 
+struct dentry *rust_helper_dget(struct dentry *dentry)
+{
+	return dget(dentry);
+}
+EXPORT_SYMBOL_GPL(rust_helper_dget);
+
 loff_t rust_helper_i_size_read(const struct inode *inode)
 {
 	return i_size_read(inode);
diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
index f4fa2847e210..bb13bd4a7fa6 100644
--- a/rust/kernel/error.rs
+++ b/rust/kernel/error.rs
@@ -261,8 +261,6 @@ pub fn to_result(err: core::ffi::c_int) -> Result {
 ///     from_err_ptr(unsafe { bindings::devm_platform_ioremap_resource(pdev.to_ptr(), index) })
 /// }
 /// ```
-// TODO: Remove `dead_code` marker once an in-kernel client is available.
-#[allow(dead_code)]
 pub(crate) fn from_err_ptr<T>(ptr: *mut T) -> Result<*mut T> {
     // CAST: Casting a pointer to `*const core::ffi::c_void` is always valid.
     let const_ptr: *const core::ffi::c_void = ptr.cast();
diff --git a/rust/kernel/fs.rs b/rust/kernel/fs.rs
index 89dcd5537830..4f07da71e1ec 100644
--- a/rust/kernel/fs.rs
+++ b/rust/kernel/fs.rs
@@ -13,6 +13,7 @@
 use macros::{pin_data, pinned_drop};
 use sb::SuperBlock;
 
+pub mod dentry;
 pub mod inode;
 pub mod sb;
 
diff --git a/rust/kernel/fs/dentry.rs b/rust/kernel/fs/dentry.rs
new file mode 100644
index 000000000000..6a36a48cd28b
--- /dev/null
+++ b/rust/kernel/fs/dentry.rs
@@ -0,0 +1,137 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! File system directory entries.
+//!
+//! This module allows Rust code to use dentries.
+//!
+//! C headers: [`include/linux/dcache.h`](srctree/include/linux/dcache.h)
+
+use super::{inode::INode, FileSystem, SuperBlock};
+use crate::bindings;
+use crate::error::{code::*, from_err_ptr, Result};
+use crate::types::{ARef, AlwaysRefCounted, Opaque};
+use core::{marker::PhantomData, mem::ManuallyDrop, ops::Deref, ptr};
+
+/// A directory entry.
+///
+/// Wraps the kernel's `struct dentry`.
+///
+/// # Invariants
+///
+/// Instances of this type are always ref-counted, that is, a call to `dget` ensures that the
+/// allocation remains valid at least until the matching call to `dput`.
+#[repr(transparent)]
+pub struct DEntry<T: FileSystem + ?Sized>(pub(crate) Opaque<bindings::dentry>, PhantomData<T>);
+
+// SAFETY: The type invariants guarantee that `DEntry` is always ref-counted.
+unsafe impl<T: FileSystem + ?Sized> AlwaysRefCounted for DEntry<T> {
+    fn inc_ref(&self) {
+        // SAFETY: The existence of a shared reference means that the refcount is nonzero.
+        unsafe { bindings::dget(self.0.get()) };
+    }
+
+    unsafe fn dec_ref(obj: ptr::NonNull<Self>) {
+        // SAFETY: The safety requirements guarantee that the refcount is nonzero.
+        unsafe { bindings::dput(obj.as_ref().0.get()) }
+    }
+}
+
+impl<T: FileSystem + ?Sized> DEntry<T> {
+    /// Creates a new [`DEntry`] from a raw C pointer.
+    ///
+    /// # Safety
+    ///
+    /// * `ptr` must be valid for at least the lifetime of the returned reference.
+    /// * `ptr` has the correct file system type, or `T` is [`super::UnspecifiedFS`].
+    #[allow(dead_code)]
+    pub(crate) unsafe fn from_raw<'a>(ptr: *mut bindings::dentry) -> &'a Self {
+        // SAFETY: The safety requirements guarantee that the reference is and remains valid.
+        unsafe { &*ptr.cast::<Self>() }
+    }
+
+    /// Returns the superblock of the dentry.
+    pub fn super_block(&self) -> &SuperBlock<T> {
+        // `d_sb` is immutable, so it's safe to read it.
+        unsafe { SuperBlock::from_raw((*self.0.get()).d_sb) }
+    }
+}
+
+/// A dentry that is known to be unhashed.
+pub struct Unhashed<'a, T: FileSystem + ?Sized>(pub(crate) &'a DEntry<T>);
+
+impl<T: FileSystem + ?Sized> Unhashed<'_, T> {
+    /// Splices a disconnected dentry into the tree if one exists.
+    pub fn splice_alias(self, inode: Option<ARef<INode<T>>>) -> Result<Option<ARef<DEntry<T>>>> {
+        let inode_ptr = if let Some(i) = inode {
+            // Reject inode if it belongs to a different superblock.
+            if !ptr::eq(i.super_block(), self.0.super_block()) {
+                return Err(EINVAL);
+            }
+
+            ManuallyDrop::new(i).0.get()
+        } else {
+            ptr::null_mut()
+        };
+
+        // SAFETY: Both inode and dentry are known to be valid.
+        let ptr = from_err_ptr(unsafe { bindings::d_splice_alias(inode_ptr, self.0 .0.get()) })?;
+
+        // SAFETY: The C API guarantees that if a dentry is returned, the refcount has been
+        // incremented.
+        Ok(ptr::NonNull::new(ptr).map(|v| unsafe { ARef::from_raw(v.cast::<DEntry<T>>()) }))
+    }
+
+    /// Returns the name of the dentry.
+    ///
+    /// Being unhashed guarantees that the name won't change.
+    pub fn name(&self) -> &[u8] {
+        // SAFETY: The name is immutable, so it is ok to read it.
+        let name = unsafe { &*ptr::addr_of!((*self.0 .0.get()).d_name) };
+
+        // This ensures that a `u32` is representable in `usize`. If it isn't, we'll get a build
+        // break.
+        const _: usize = 0xffffffff;
+
+        // SAFETY: The union is just allow an easy way to get the `hash` and `len` at once. `len`
+        // is always valid.
+        let len = unsafe { name.__bindgen_anon_1.__bindgen_anon_1.len } as usize;
+
+        // SAFETY: The name is immutable, so it is ok to read it.
+        unsafe { core::slice::from_raw_parts(name.name, len) }
+    }
+}
+
+impl<T: FileSystem + ?Sized> Deref for Unhashed<'_, T> {
+    type Target = DEntry<T>;
+
+    fn deref(&self) -> &Self::Target {
+        self.0
+    }
+}
+
+/// A dentry that is meant to be used as the root of a file system.
+pub struct Root<T: FileSystem + ?Sized>(ARef<DEntry<T>>);
+
+impl<T: FileSystem + ?Sized> Root<T> {
+    /// Creates a root dentry.
+    pub fn try_new(inode: ARef<INode<T>>) -> Result<Root<T>> {
+        // SAFETY: `d_make_root` requires that `inode` be valid and referenced, which is the
+        // case for this call.
+        //
+        // It takes over the inode, even on failure, so we don't need to clean it up.
+        let dentry_ptr = unsafe { bindings::d_make_root(ManuallyDrop::new(inode).0.get()) };
+        let dentry = ptr::NonNull::new(dentry_ptr).ok_or(ENOMEM)?;
+
+        // SAFETY: `dentry` is valid and referenced. It reference ownership is transferred to
+        // `ARef`.
+        Ok(Root(unsafe { ARef::from_raw(dentry.cast::<DEntry<T>>()) }))
+    }
+}
+
+impl<T: FileSystem + ?Sized> Deref for Root<T> {
+    type Target = DEntry<T>;
+
+    fn deref(&self) -> &Self::Target {
+        &self.0
+    }
+}
-- 
2.34.1


