Return-Path: <linux-fsdevel+bounces-19431-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C54978C56EA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 15:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05CE9281692
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 13:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C451534EB;
	Tue, 14 May 2024 13:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SywO1aFs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E8E1474C9;
	Tue, 14 May 2024 13:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715692670; cv=none; b=g+ypy/OmXuQsiAbv5ulFGg8N9VIYG+KRZvndkQ9i79QcJZAdcJGU7ifBKQM7ThfEwUCfFvAvCjSYluWntowolT6Ic5dZtYALMmZ9UIr4EvQvLYIlqJ0OS6AxeL4eCRd1qeS4hJiiLlKz38GzjJMSJSv3mnLQbg2BZiWnoquZq64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715692670; c=relaxed/simple;
	bh=2dU2vW9r6+E0UljRNqvE72JR11F6DrWRygMa+KrItSo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dm4gV92KPAax7KlOYv50nj4Wmf8hW8YFeckAERa0dGCPUuMgY2OaENEMx8sjQ42Wrlo3WNOiWgdbax8+Wvb4+6uRZcG/lh9vJ+g+pTGmBy7Ccg+RYrDb4kXQm2HSek6ofBfh8ur3kVruOJXuOIysXoo3d+pfa3K1CpesDAyBlyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SywO1aFs; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1ed96772f92so44793435ad.0;
        Tue, 14 May 2024 06:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715692668; x=1716297468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cb0aTJs1VPGRE71afQXU2F9h4FNf65p4Qc8Pwqu07To=;
        b=SywO1aFsU1ntCX5e8ORE0EOS45Nelh14tSesra83fkLihVe3oVVh7oSPYTgkW2Q1C5
         WJYcSCKuw861rM0/5GZqGyckBD2gEdl8ABNvE1VlbgmoZ9Hu0LpuLtoitY1R2r2jwdyP
         cJOlzzvEL7V6PIWwTtD2/WM2nkeRR0MtrIDnQG1drPd5E2uPiQIMM9KSpTId4ww3hi+E
         xRgBbtrCGKjqSRn9bWuUABTI6p+GcOCRssMrahhM55vl1mBBwAz4tQNZvkv2M8daI9iO
         QnSwGluFPcaAn+jVRTZYzihb0o+MYx26WS3nVceL6Vln9pHDo3iTrBfWwYVrMCxR/MV+
         ZzSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715692668; x=1716297468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cb0aTJs1VPGRE71afQXU2F9h4FNf65p4Qc8Pwqu07To=;
        b=JtvNr8P6yHeS//BhWLWH9syEe+Sby5aVFu6xpWGKNr2xz2EBs5b9iE1T+Myg72BLgg
         G5RgGhq4dpRcIDuynpLcblAafv9U3363NI2g+QvCx2EUg7Uxl8/jeoPUHvFsuGUVT0np
         BPncGn3qMzTVzqwChzw36kDA7uq1+/9tdzAIFCrOBlQQRcv5saIVT27O2b04Md2HMn49
         rR5TjJvybr5WtuTwitC9VQ0/xhiimB6v5VdpYZ4vGRHCJ6AQpqBpBTC7/kL/L48mdtvi
         s4G018LxwaYl9N//A3n9ZTpxmJn6iNbx+4r3olAUItBHt20+V5Ts+lAv6LG8Ur87krBR
         0iwg==
X-Forwarded-Encrypted: i=1; AJvYcCUY9BOEPvlnQ2QMbc1Xo1uWt51rJtp8LpY0FGMy2XJKfEBS0UlzZm4GRx4OtWzH4PDUiOI5y3mmIqVEYqW7RbXeTRYN+b0ABevYbIRtVOjSYX3Ea1pFtTolzajhRAn7gdWAkBNz4c1j3QRgWLcjz1zR+PDjJE3mCrtRZN8gjmIk9ZqwWfiu6PTP9cGB
X-Gm-Message-State: AOJu0YxSTJBQcRNWhE7HpIGf8NOQ9FvJPGvbLC7CWTKJ0Tdfb4GZskCJ
	FllnYcQM25x3Uy3vnlhPpTJTYfn16v/rjoYWqTaiI1rXTYsMhgBG
X-Google-Smtp-Source: AGHT+IHc29e6vne8CBHNjaXL31oZJLb84ryZavfdmGOgVfoH6/KYa3aqF7scyQY5CXTSy0i8uGudsg==
X-Received: by 2002:a17:903:2290:b0:1e0:b2d5:5f46 with SMTP id d9443c01a7336-1ef440495b7mr146491315ad.46.1715692667893;
        Tue, 14 May 2024 06:17:47 -0700 (PDT)
Received: from wedsonaf-dev.. ([50.204.89.32])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1ef0b9d18a4sm97277335ad.56.2024.05.14.06.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 06:17:47 -0700 (PDT)
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
Subject: [RFC PATCH v2 09/30] rust: fs: generalise `File` for different file systems
Date: Tue, 14 May 2024 10:16:50 -0300
Message-Id: <20240514131711.379322-10-wedsonaf@gmail.com>
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

This is in preparation for allowing file operation implementations for
different file systems.

Also add an unspecified file system so that users of the `File` type
that don't care about the file system may continue to do so.

Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
 rust/kernel/fs/file.rs  | 53 ++++++++++++++++++++++++++++-------------
 rust/kernel/fs/inode.rs |  1 -
 2 files changed, 36 insertions(+), 18 deletions(-)

diff --git a/rust/kernel/fs/file.rs b/rust/kernel/fs/file.rs
index 908e2672676f..b8386a396251 100644
--- a/rust/kernel/fs/file.rs
+++ b/rust/kernel/fs/file.rs
@@ -2,15 +2,18 @@
 
 //! Files and file descriptors.
 //!
-//! C headers: [`include/linux/fs.h`](../../../../include/linux/fs.h) and
-//! [`include/linux/file.h`](../../../../include/linux/file.h)
+//! This module allows Rust code to interact with and implement files.
+//!
+//! C headers: [`include/linux/fs.h`](srctree/include/linux/fs.h) and
+//! [`include/linux/file.h`](srctree/include/linux/file.h)
 
+use super::{dentry::DEntry, inode::INode, FileSystem, UnspecifiedFS};
 use crate::{
     bindings,
     error::{code::*, Error, Result},
     types::{ARef, AlwaysRefCounted, Opaque},
 };
-use core::ptr;
+use core::{marker::PhantomData, ptr};
 
 /// Flags associated with a [`File`].
 pub mod flags {
@@ -95,6 +98,8 @@ pub mod flags {
     pub const O_RDWR: u32 = bindings::O_RDWR;
 }
 
+/// A file.
+///
 /// Wraps the kernel's `struct file`.
 ///
 /// # Refcounting
@@ -139,7 +144,7 @@ pub mod flags {
 /// * The Rust borrow-checker normally ensures this by enforcing that the `ARef<File>` from which
 ///   a `&File` is created outlives the `&File`.
 ///
-/// * Using the unsafe [`File::from_ptr`] means that it is up to the caller to ensure that the
+/// * Using the unsafe [`File::from_raw`] means that it is up to the caller to ensure that the
 ///   `&File` only exists while the reference count is positive.
 ///
 /// * You can think of `fdget` as using an fd to look up an `ARef<File>` in the `struct
@@ -154,20 +159,20 @@ pub mod flags {
 ///   closed.
 /// * A light refcount must be dropped before returning to userspace.
 #[repr(transparent)]
-pub struct File(Opaque<bindings::file>);
+pub struct File<T: FileSystem + ?Sized = UnspecifiedFS>(Opaque<bindings::file>, PhantomData<T>);
 
 // SAFETY: By design, the only way to access a `File` is via an immutable reference or an `ARef`.
 // This means that the only situation in which a `File` can be accessed mutably is when the
 // refcount drops to zero and the destructor runs. It is safe for that to happen on any thread, so
 // it is ok for this type to be `Send`.
-unsafe impl Send for File {}
+unsafe impl<T: FileSystem + ?Sized> Send for File<T> {}
 
 // SAFETY: All methods defined on `File` that take `&self` are safe to call even if other threads
 // are concurrently accessing the same `struct file`, because those methods either access immutable
 // properties or have proper synchronization to ensure that such accesses are safe.
-unsafe impl Sync for File {}
+unsafe impl<T: FileSystem + ?Sized> Sync for File<T> {}
 
-impl File {
+impl<T: FileSystem + ?Sized> File<T> {
     /// Constructs a new `struct file` wrapper from a file descriptor.
     ///
     /// The file descriptor belongs to the current process.
@@ -187,15 +192,17 @@ pub fn fget(fd: u32) -> Result<ARef<Self>, BadFdError> {
     ///
     /// # Safety
     ///
-    /// The caller must ensure that `ptr` points at a valid file and that the file's refcount is
-    /// positive for the duration of 'a.
-    pub unsafe fn from_ptr<'a>(ptr: *const bindings::file) -> &'a File {
+    /// Callers must ensure that:
+    ///
+    /// * `ptr` is valid and remains so for the duration of 'a.
+    /// * `ptr` has the correct file system type, or `T` is [`UnspecifiedFS`].
+    pub unsafe fn from_raw<'a>(ptr: *const bindings::file) -> &'a Self {
         // SAFETY: The caller guarantees that the pointer is not dangling and stays valid for the
         // duration of 'a. The cast is okay because `File` is `repr(transparent)`.
         //
         // INVARIANT: The safety requirements guarantee that the refcount does not hit zero during
         // 'a.
-        unsafe { &*ptr.cast() }
+        unsafe { &*ptr.cast::<Self>() }
     }
 
     /// Returns a raw pointer to the inner C struct.
@@ -215,20 +222,32 @@ pub fn flags(&self) -> u32 {
         // TODO: Replace with `read_once` when available on the Rust side.
         unsafe { core::ptr::addr_of!((*self.as_ptr()).f_flags).read_volatile() }
     }
+
+    /// Returns the inode associated with the file.
+    pub fn inode(&self) -> &INode<T> {
+        // SAFETY: `f_inode` is an immutable field, so it's safe to read it.
+        unsafe { INode::from_raw((*self.0.get()).f_inode) }
+    }
+
+    /// Returns the dentry associated with the file.
+    pub fn dentry(&self) -> &DEntry<T> {
+        // SAFETY: `f_path` is an immutable field, so it's safe to read it. And will remain safe to
+        // read while the `&self` is valid.
+        unsafe { DEntry::from_raw((*self.0.get()).f_path.dentry) }
+    }
 }
 
 // SAFETY: The type invariants guarantee that `File` is always ref-counted. This implementation
 // makes `ARef<File>` own a normal refcount.
-unsafe impl AlwaysRefCounted for File {
+unsafe impl<T: FileSystem + ?Sized> AlwaysRefCounted for File<T> {
     fn inc_ref(&self) {
         // SAFETY: The existence of a shared reference means that the refcount is nonzero.
         unsafe { bindings::get_file(self.as_ptr()) };
     }
 
-    unsafe fn dec_ref(obj: ptr::NonNull<File>) {
-        // SAFETY: To call this method, the caller passes us ownership of a normal refcount, so we
-        // may drop it. The cast is okay since `File` has the same representation as `struct file`.
-        unsafe { bindings::fput(obj.cast().as_ptr()) }
+    unsafe fn dec_ref(obj: ptr::NonNull<Self>) {
+        // SAFETY: The safety requirements guarantee that the refcount is nonzero.
+        unsafe { bindings::fput(obj.as_ref().0.get()) }
     }
 }
 
diff --git a/rust/kernel/fs/inode.rs b/rust/kernel/fs/inode.rs
index 4ccbb4145918..11df493314ea 100644
--- a/rust/kernel/fs/inode.rs
+++ b/rust/kernel/fs/inode.rs
@@ -39,7 +39,6 @@ impl<T: FileSystem + ?Sized> INode<T> {
     ///
     /// * `ptr` is valid and remains so for the lifetime of the returned object.
     /// * `ptr` has the correct file system type, or `T` is [`super::UnspecifiedFS`].
-    #[allow(dead_code)]
     pub(crate) unsafe fn from_raw<'a>(ptr: *mut bindings::inode) -> &'a Self {
         // SAFETY: The safety requirements guarantee that the cast below is ok.
         unsafe { &*ptr.cast::<Self>() }
-- 
2.34.1


