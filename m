Return-Path: <linux-fsdevel+bounces-19604-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F87D8C7CD3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2024 21:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D7201F22129
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2024 19:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1EB6158D95;
	Thu, 16 May 2024 19:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="HQ5bDztO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from aer-iport-1.cisco.com (aer-iport-1.cisco.com [173.38.203.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B299D158A0D;
	Thu, 16 May 2024 19:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.38.203.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715886270; cv=none; b=A0B7xNQf1dQm9lkNhiAJaop8w7atlSdJHvzgLxhH4Zor8jHzjYw49wJyJ7VBZdBmRTj9JocLavFAHZ31TZnPKge9PqYez9pjBfFuARRzOwK1VFKWnCyWQ4G/sFm3GoJTAOMlaIM1FaSumxTZBnEhVfCiz9aMLD6xwNtCd9+3FjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715886270; c=relaxed/simple;
	bh=FYYpShULCzDGTY8DrJKTdxNXS4tsuaRgjgT2GsYK0fg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ogPjr9otuSGNqjrZekZL53uisgOgLWEXthmFO+/IeUXSb57fA3DPzDxrMJ+j/k52ycMlk225UINu00dRs75kvfn37g5GuX77kYhsiWwNFhjl0EK7vZlI5TfWqBjmAEivgWH5fC9+3c7VOj6c3MwGzubrwv8WfwIK4VGSFr+2mYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=HQ5bDztO; arc=none smtp.client-ip=173.38.203.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=32908; q=dns/txt;
  s=iport; t=1715886267; x=1717095867;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dyh5UB2XyHkCg+QkFyQRlUygD3C+Gcdg9yxYiudF0YI=;
  b=HQ5bDztOhYEjxfKTd3VY49xYtJv4slTqTXRcvY2fihNHexKIJ8hqTAT/
   rrnWgVQ0g4DrApYLD1W2uCyhUMUOGrLQ/otkL3DZ/VqZkOL4CHI8hfAl8
   eOJ1tAcHmfhCv3NoCYmMjbJp8H/XV6qVTRg84RDh7OMW+acyKO3hd4p2b
   k=;
X-CSE-ConnectionGUID: CC5w0j8wRuCvUat6eQfJMg==
X-CSE-MsgGUID: 9DT0Ng7FSU2CtwQzxEUv7Q==
X-IronPort-AV: E=Sophos;i="6.08,165,1712620800"; 
   d="scan'208";a="12419639"
Received: from aer-iport-nat.cisco.com (HELO aer-core-7.cisco.com) ([173.38.203.22])
  by aer-iport-1.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 19:04:26 +0000
Received: from localhost (ams3-vpn-dhcp4879.cisco.com [10.61.83.14])
	(authenticated bits=0)
	by aer-core-7.cisco.com (8.15.2/8.15.2) with ESMTPSA id 44GJ4Pkt117285
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 16 May 2024 19:04:25 GMT
From: Ariel Miculas <amiculas@cisco.com>
To: rust-for-linux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tycho@tycho.pizza, brauner@kernel.org, viro@zeniv.linux.org.uk,
        ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
        shallyn@cisco.com, Wedson Almeida Filho <wedsonaf@google.com>,
        Ariel Miculas <amiculas@cisco.com>
Subject: [RFC PATCH v3 20/22] rust: add support for file system parameters
Date: Thu, 16 May 2024 22:03:43 +0300
Message-Id: <20240516190345.957477-21-amiculas@cisco.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240516190345.957477-1-amiculas@cisco.com>
References: <20240516190345.957477-1-amiculas@cisco.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-User: amiculas@cisco.com
X-Outbound-SMTP-Client: 10.61.83.14, ams3-vpn-dhcp4879.cisco.com
X-Outbound-Node: aer-core-7.cisco.com

From: Wedson Almeida Filho <wedsonaf@google.com>

This allows file system contexts to be further initialised with
parameters from userspace before a fs is mounted or reconfigured.

Signed-off-by: Wedson Almeida Filho <wedsonaf@google.com>
[
Changes made:
* adapt for upstream
* replace UnsafeCell with Opaque,
* replace from_kernel_result with from_result
* replace Type with FileSystem
* add Context in FileSystem from [1]
* add the EmptyContext from [1]
* add the free_callback from [2]
* add count_paren_items from [3]
* add PAGE_SIZE constant from [4]
* initialize the Context in init_fs_context_callback
* get the data Context in fill_super_callback and pass it to super_params
* avoid freeing s_fs_info in free_callback, it's already freed in
  kill_sb_callback
[1] https://github.com/wedsonaf/linux/commit/6633c50b345f388a07b4c551f752efe34c15c089
[2] https://github.com/wedsonaf/linux/commit/3c3ccce85af9aae9dfc0e17e2331674da520177c
[3] https://github.com/wedsonaf/linux/commit/c3f395b1b0126b4db7eb833bdee769212c8c79d8
[4] https://github.com/wedsonaf/linux/commit/4021d947dea69506d11b148486e1565961a85e53
]
Signed-off-by: Ariel Miculas <amiculas@cisco.com>
---
 fs/puzzlefs/puzzlefs.rs         |   1 +
 rust/bindings/bindings_helper.h |   1 +
 rust/kernel/fs.rs               | 212 +++++++++++-
 rust/kernel/fs/param.rs         | 576 ++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs              |   7 +
 samples/rust/rust_rofs.rs       |  32 +-
 6 files changed, 821 insertions(+), 8 deletions(-)
 create mode 100644 rust/kernel/fs/param.rs

diff --git a/fs/puzzlefs/puzzlefs.rs b/fs/puzzlefs/puzzlefs.rs
index 9622ea71eda0..f4e94568c9cc 100644
--- a/fs/puzzlefs/puzzlefs.rs
+++ b/fs/puzzlefs/puzzlefs.rs
@@ -103,6 +103,7 @@ impl fs::FileSystem for PuzzleFsModule {
     const NAME: &'static CStr = c_str!("puzzlefs");
 
     fn fill_super(
+        _data: (),
         sb: &mut sb::SuperBlock<Self, sb::New>,
         _: Option<inode::Mapper>,
     ) -> Result<Box<PuzzleFS>> {
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 0491bb05270c..3f18e5abcc5c 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -27,6 +27,7 @@
 #include <linux/wait.h>
 #include <linux/workqueue.h>
 #include <linux/xattr.h>
+#include <linux/fs_parser.h>
 
 /* `bindgen` gets confused at certain things. */
 const size_t RUST_CONST_HELPER_ARCH_SLAB_MINALIGN = ARCH_SLAB_MINALIGN;
diff --git a/rust/kernel/fs.rs b/rust/kernel/fs.rs
index b7a654546d23..9ca653f64388 100644
--- a/rust/kernel/fs.rs
+++ b/rust/kernel/fs.rs
@@ -12,7 +12,7 @@
 use core::{ffi, marker::PhantomData, mem::size_of, mem::ManuallyDrop, pin::Pin, ptr};
 use dentry::DEntry;
 use inode::INode;
-use macros::{pin_data, pinned_drop};
+use macros::{pin_data, pinned_drop, vtable};
 use sb::SuperBlock;
 
 pub mod address_space;
@@ -20,6 +20,7 @@
 pub mod file;
 pub mod inode;
 pub mod iomap;
+pub mod param;
 pub mod sb;
 
 /// The offset of a file in a file system.
@@ -59,11 +60,52 @@ pub mod mode {
     pub const S_IFSOCK: u16 = bindings::S_IFSOCK as u16;
 }
 
+/// A file system context.
+///
+/// It is used to gather configuration to then mount or reconfigure a file system.
+#[vtable]
+pub trait Context<T: FileSystem + ?Sized> {
+    /// Type of the data associated with the context.
+    type Data: ForeignOwnable + Send + Sync + 'static;
+
+    /// The typed file system parameters.
+    ///
+    /// Users are encouraged to define it using the [`crate::define_fs_params`] macro.
+    const PARAMS: param::SpecTable<'static, Self::Data> = param::SpecTable::empty();
+
+    /// Creates a new context.
+    fn try_new() -> Result<Self::Data>;
+
+    /// Parses a parameter that wasn't specified in [`Self::PARAMS`].
+    fn parse_unknown_param(
+        _data: &mut <Self::Data as ForeignOwnable>::BorrowedMut<'_>,
+        _name: &CStr,
+        _value: param::Value<'_>,
+    ) -> Result {
+        Err(ENOPARAM)
+    }
+
+    /// Parses the whole parameter block, potentially skipping regular handling for parts of it.
+    ///
+    /// The return value is the portion of the input buffer for which the regular handling
+    /// (involving [`Self::PARAMS`] and [`Self::parse_unknown_param`]) will still be carried out.
+    /// If it's `None`, the regular handling is not performed at all.
+    fn parse_monolithic<'a>(
+        _data: &mut <Self::Data as ForeignOwnable>::BorrowedMut<'_>,
+        _buf: Option<&'a mut [u8]>,
+    ) -> Result<Option<&'a mut [u8]>> {
+        Ok(None)
+    }
+}
+
 /// Maximum size of an inode.
 pub const MAX_LFS_FILESIZE: Offset = bindings::MAX_LFS_FILESIZE;
 
 /// A file system type.
 pub trait FileSystem {
+    /// The context used to build fs configuration before it is mounted or reconfigured.
+    type Context: Context<Self> + ?Sized = EmptyContext;
+
     /// Data associated with each file system instance (super-block).
     type Data: ForeignOwnable + Send + Sync;
 
@@ -84,6 +126,7 @@ pub trait FileSystem {
 
     /// Initialises the new superblock and returns the data to attach to it.
     fn fill_super(
+        data: <Self::Context as Context<Self>>::Data,
         sb: &mut SuperBlock<Self, sb::New>,
         mapper: Option<inode::Mapper>,
     ) -> Result<Self::Data>;
@@ -143,7 +186,11 @@ impl FileSystem for UnspecifiedFS {
     type INodeData = ();
     const NAME: &'static CStr = crate::c_str!("unspecified");
     const IS_UNSPECIFIED: bool = true;
-    fn fill_super(_: &mut SuperBlock<Self, sb::New>, _: Option<inode::Mapper>) -> Result {
+    fn fill_super(
+        _: <Self::Context as Context<Self>>::Data,
+        _: &mut SuperBlock<Self, sb::New>,
+        _: Option<inode::Mapper>,
+    ) -> Result<()> {
         Err(ENOTSUPP)
     }
 
@@ -199,9 +246,11 @@ pub fn new<T: FileSystem + ?Sized>(module: &'static ThisModule) -> impl PinInit<
         fc_ptr: *mut bindings::fs_context,
     ) -> ffi::c_int {
         from_result(|| {
+            let data = T::Context::try_new()?;
             // SAFETY: The C callback API guarantees that `fc_ptr` is valid.
             let fc = unsafe { &mut *fc_ptr };
             fc.ops = &Tables::<T>::CONTEXT;
+            fc.fs_private = data.into_foreign() as _;
             Ok(0)
         })
     }
@@ -242,14 +291,32 @@ fn drop(self: Pin<&mut Self>) {
     }
 }
 
+/// An empty file system context.
+///
+/// That is, one that doesn't take any arguments and doesn't hold any state. It is a convenience
+/// type for file systems that don't need context for mounting/reconfiguring.
+pub struct EmptyContext;
+
+#[vtable]
+impl<T: FileSystem + ?Sized> Context<T> for EmptyContext {
+    type Data = ();
+    fn try_new() -> Result {
+        Ok(())
+    }
+}
+
 struct Tables<T: FileSystem + ?Sized>(T);
 impl<T: FileSystem + ?Sized> Tables<T> {
     const CONTEXT: bindings::fs_context_operations = bindings::fs_context_operations {
-        free: None,
-        parse_param: None,
+        free: Some(Self::free_callback),
+        parse_param: Some(Self::parse_param_callback),
         get_tree: Some(Self::get_tree_callback),
         reconfigure: None,
-        parse_monolithic: None,
+        parse_monolithic: if <T::Context as Context<T>>::HAS_PARSE_MONOLITHIC {
+            Some(Self::parse_monolithic_callback)
+        } else {
+            None
+        },
         dup: None,
     };
 
@@ -268,9 +335,73 @@ impl<T: FileSystem + ?Sized> Tables<T> {
         }
     }
 
+    unsafe extern "C" fn free_callback(fc: *mut bindings::fs_context) {
+        // SAFETY: The callback contract guarantees that `fc` is valid.
+        let fc = unsafe { &*fc };
+
+        let ptr = fc.fs_private;
+        if !ptr.is_null() {
+            // SAFETY: `fs_private` was initialised with the result of a `to_pointer` call in
+            // `init_fs_context_callback`, so it's ok to call `from_foreign` here.
+            unsafe { <T::Context as Context<T>>::Data::from_foreign(ptr) };
+        }
+    }
+
+    unsafe extern "C" fn parse_param_callback(
+        fc: *mut bindings::fs_context,
+        param: *mut bindings::fs_parameter,
+    ) -> core::ffi::c_int {
+        from_result(|| {
+            // SAFETY: The callback contract guarantees that `fc` is valid.
+            let ptr = unsafe { (*fc).fs_private };
+
+            // SAFETY: The value of `ptr` (coming from `fs_private` was initialised in
+            // `init_fs_context_callback` to the result of an `into_foreign` call. Since the
+            // context is valid, `from_foreign` wasn't called yet, so `ptr` is valid. Additionally,
+            // the callback contract guarantees that callbacks are serialised, so it is ok to
+            // mutably reference it.
+            let mut data =
+                unsafe { <<T::Context as Context<T>>::Data as ForeignOwnable>::borrow_mut(ptr) };
+            let mut result = bindings::fs_parse_result::default();
+            // SAFETY: All parameters are valid at least for the duration of the call.
+            let opt =
+                unsafe { bindings::fs_parse(fc, T::Context::PARAMS.first, param, &mut result) };
+
+            // SAFETY: The callback contract guarantees that `param` is valid for the duration of
+            // the callback.
+            let param = unsafe { &*param };
+            if opt >= 0 {
+                let opt = opt as usize;
+                if opt >= T::Context::PARAMS.handlers.len() {
+                    return Err(EINVAL);
+                }
+                T::Context::PARAMS.handlers[opt].handle_param(&mut data, param, &result)?;
+                return Ok(0);
+            }
+
+            if opt != ENOPARAM.to_errno() {
+                return Err(Error::from_errno(opt));
+            }
+
+            if !T::Context::HAS_PARSE_UNKNOWN_PARAM {
+                return Err(ENOPARAM);
+            }
+
+            let val = param::Value::from_fs_parameter(param);
+            // SAFETY: The callback contract guarantees the parameter key to be valid and last at
+            // least the duration of the callback.
+            T::Context::parse_unknown_param(
+                &mut data,
+                unsafe { CStr::from_char_ptr(param.key) },
+                val,
+            )?;
+            Ok(0)
+        })
+    }
+
     unsafe extern "C" fn fill_super_callback(
         sb_ptr: *mut bindings::super_block,
-        _fc: *mut bindings::fs_context,
+        fc: *mut bindings::fs_context,
     ) -> ffi::c_int {
         from_result(|| {
             // SAFETY: The callback contract guarantees that `sb_ptr` is a unique pointer to a
@@ -280,6 +411,20 @@ impl<T: FileSystem + ?Sized> Tables<T> {
             // SAFETY: The callback contract guarantees that `sb_ptr`, from which `new_sb` is
             // derived, is valid for write.
             let sb = unsafe { &mut *new_sb.0.get() };
+
+            // SAFETY: The callback contract guarantees that `fc` is valid. It also guarantees that
+            // the callbacks are serialised for a given `fc`, so it is safe to mutably dereference
+            // it.
+            let fc = unsafe { &mut *fc };
+            let ptr = core::mem::replace(&mut fc.fs_private, ptr::null_mut());
+
+            // SAFETY: The value of `ptr` (coming from `fs_private` was initialised in
+            // `init_fs_context_callback` to the result of an `into_foreign` call. The context is
+            // being used to initialise a superblock, so we took over `ptr` (`fs_private` is set to
+            // null now) and call `from_foreign` below.
+            let data =
+                unsafe { <<T::Context as Context<T>>::Data as ForeignOwnable>::from_foreign(ptr) };
+
             sb.s_op = &Tables::<T>::SUPER_BLOCK;
             sb.s_xattr = &Tables::<T>::XATTR_HANDLERS[0];
             sb.s_flags |= bindings::SB_RDONLY;
@@ -291,7 +436,7 @@ impl<T: FileSystem + ?Sized> Tables<T> {
                 None
             };
 
-            let data = T::fill_super(new_sb, mapper)?;
+            let data = T::fill_super(data, new_sb, mapper)?;
 
             // N.B.: Even on failure, `kill_sb` is called and frees the data.
             sb.s_fs_info = data.into_foreign().cast_mut();
@@ -317,6 +462,41 @@ impl<T: FileSystem + ?Sized> Tables<T> {
         })
     }
 
+    unsafe extern "C" fn parse_monolithic_callback(
+        fc: *mut bindings::fs_context,
+        buf: *mut core::ffi::c_void,
+    ) -> core::ffi::c_int {
+        from_result(|| {
+            // SAFETY: The callback contract guarantees that `fc` is valid.
+            let ptr = unsafe { (*fc).fs_private };
+
+            // SAFETY: The value of `ptr` (coming from `fs_private` was initialised in
+            // `init_fs_context_callback` to the result of an `into_pointer` call. Since the
+            // context is valid, `from_pointer` wasn't called yet, so `ptr` is valid. Additionally,
+            // the callback contract guarantees that callbacks are serialised, so it is ok to
+            // mutably reference it.
+            let mut data =
+                unsafe { <<T::Context as Context<T>>::Data as ForeignOwnable>::borrow_mut(ptr) };
+            let page = if buf.is_null() {
+                None
+            } else {
+                // SAFETY: This callback is called to handle the `mount` syscall, which takes a
+                // page-sized buffer as data.
+                Some(unsafe { &mut *ptr::slice_from_raw_parts_mut(buf.cast(), crate::PAGE_SIZE) })
+            };
+            let regular = T::Context::parse_monolithic(&mut data, page)?;
+            if let Some(buf) = regular {
+                // SAFETY: Both `fc` and `buf` are guaranteed to be valid; the former because the
+                // callback is still ongoing and the latter because its lifefime is tied to that of
+                // `page`, which is also valid for the duration of the callback.
+                to_result(unsafe {
+                    bindings::generic_parse_monolithic(fc, buf.as_mut_ptr().cast())
+                })?;
+            }
+            Ok(0)
+        })
+    }
+
     const SUPER_BLOCK: bindings::super_operations = bindings::super_operations {
         alloc_inode: if size_of::<T::INodeData>() != 0 {
             Some(INode::<T>::alloc_inode_callback)
@@ -490,3 +670,21 @@ macro_rules! module_fs {
         }
     }
 }
+
+/// Wraps the kernel's `struct filename`.
+#[repr(transparent)]
+pub struct Filename(pub(crate) Opaque<bindings::filename>);
+
+impl Filename {
+    /// Creates a reference to a [`Filename`] from a valid pointer.
+    ///
+    /// # Safety
+    ///
+    /// The caller must ensure that `ptr` is valid and remains valid for the lifetime of the
+    /// returned [`Filename`] instance.
+    pub(crate) unsafe fn from_ptr<'a>(ptr: *const bindings::filename) -> &'a Filename {
+        // SAFETY: The safety requirements guarantee the validity of the dereference, while the
+        // `Filename` type being transparent makes the cast ok.
+        unsafe { &*ptr.cast() }
+    }
+}
diff --git a/rust/kernel/fs/param.rs b/rust/kernel/fs/param.rs
new file mode 100644
index 000000000000..590fdaaab0ad
--- /dev/null
+++ b/rust/kernel/fs/param.rs
@@ -0,0 +1,576 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! File system parameters and parsing them.
+//!
+//! C headers: [`include/linux/fs_parser.h`](../../../../../include/linux/fs_parser.h)
+
+use crate::types::ForeignOwnable;
+use crate::{bindings, error::Result, file, fs, str::CStr};
+use core::{marker::PhantomData, ptr};
+
+/// The value of a file system parameter.
+pub enum Value<'a> {
+    /// The value is undefined.
+    Undefined,
+
+    /// There is no value, but parameter itself is a flag.
+    Flag,
+
+    /// The value is the given string.
+    String(&'a CStr),
+
+    /// The value is the given binary blob.
+    Blob(&'a mut [u8]),
+
+    /// The value is the given file.
+    File(&'a file::File),
+
+    /// The value is the given filename and the given directory file descriptor (which may be
+    /// `AT_FDCWD`, to indicate the current directory).
+    Filename(&'a fs::Filename, i32),
+}
+
+impl<'a> Value<'a> {
+    pub(super) fn from_fs_parameter(p: &'a bindings::fs_parameter) -> Self {
+        match p.type_() {
+            bindings::fs_value_type_fs_value_is_string => {
+                // SAFETY: `type_` is string, so it is ok to use the union field. Additionally, it
+                // is guaranteed to be valid while `p` is valid.
+                Self::String(unsafe { CStr::from_char_ptr(p.__bindgen_anon_1.string) })
+            }
+            bindings::fs_value_type_fs_value_is_flag => Self::Flag,
+            bindings::fs_value_type_fs_value_is_blob => {
+                // SAFETY: `type_` is blob, so it is ok to use the union field and size.
+                // Additionally, it is guaranteed to be valid while `p` is valid.
+                let slice = unsafe {
+                    &mut *ptr::slice_from_raw_parts_mut(p.__bindgen_anon_1.blob.cast(), p.size)
+                };
+                Self::Blob(slice)
+            }
+            bindings::fs_value_type_fs_value_is_file => {
+                // SAFETY: `type_` is file, so it is ok to use the union field. Additionally, it is
+                // guaranteed to be valid while `p` is valid.
+                let file_ptr = unsafe { p.__bindgen_anon_1.file };
+                if file_ptr.is_null() {
+                    Self::Undefined
+                } else {
+                    // SAFETY: `file_ptr` is non-null and guaranteed to be valid while `p` is.
+                    Self::File(unsafe { file::File::from_ptr(file_ptr) })
+                }
+            }
+            bindings::fs_value_type_fs_value_is_filename => {
+                // SAFETY: `type_` is filename, so it is ok to use the union field. Additionally,
+                // it is guaranteed to be valid while `p` is valid.
+                let filename_ptr = unsafe { p.__bindgen_anon_1.name };
+                if filename_ptr.is_null() {
+                    Self::Undefined
+                } else {
+                    // SAFETY: `filename_ptr` is non-null and guaranteed to be valid while `p` is.
+                    Self::Filename(unsafe { fs::Filename::from_ptr(filename_ptr) }, p.dirfd)
+                }
+            }
+            _ => Self::Undefined,
+        }
+    }
+}
+
+/// A specification of a file system parameter.
+pub struct Spec {
+    name: &'static CStr,
+    flags: u16,
+    type_: bindings::fs_param_type,
+    extra: *const core::ffi::c_void,
+}
+
+const DEFAULT: Spec = Spec {
+    name: crate::c_str!(""),
+    flags: 0,
+    type_: None,
+    extra: core::ptr::null(),
+};
+
+macro_rules! define_param_type {
+    ($name:ident, $fntype:ty, $spec:expr, |$param:ident, $result:ident| $value:expr) => {
+        /// Module to support `$name` parameter types.
+        pub mod $name {
+            use super::*;
+
+            #[doc(hidden)]
+            pub const fn spec(name: &'static CStr) -> Spec {
+                const GIVEN: Spec = $spec;
+                Spec { name, ..GIVEN }
+            }
+
+            #[doc(hidden)]
+            pub const fn handler<S: ForeignOwnable>(
+                setfn: fn(&mut <S as ForeignOwnable>::BorrowedMut<'_>, $fntype) -> Result,
+            ) -> impl Handler<S> {
+                let c =
+                    move |s: &mut <S as ForeignOwnable>::BorrowedMut<'_>,
+                          $param: &bindings::fs_parameter,
+                          $result: &bindings::fs_parse_result| { setfn(s, $value) };
+                ConcreteHandler {
+                    setfn: c,
+                    _p: PhantomData,
+                }
+            }
+        }
+    };
+}
+
+// SAFETY: This is only called when the parse result is a boolean, so it is ok to access to union
+// field.
+define_param_type!(flag, bool, Spec { ..DEFAULT }, |_p, r| unsafe {
+    r.__bindgen_anon_1.boolean
+});
+
+define_param_type!(
+    flag_no,
+    bool,
+    Spec {
+        flags: bindings::fs_param_neg_with_no as _,
+        ..DEFAULT
+    },
+    // SAFETY: This is only called when the parse result is a boolean, so it is ok to access to
+    // union field.
+    |_p, r| unsafe { r.__bindgen_anon_1.boolean }
+);
+
+define_param_type!(
+    bool,
+    bool,
+    Spec {
+        type_: Some(bindings::fs_param_is_bool),
+        ..DEFAULT
+    },
+    // SAFETY: This is only called when the parse result is a boolean, so it is ok to access to
+    // union field.
+    |_p, r| unsafe { r.__bindgen_anon_1.boolean }
+);
+
+define_param_type!(
+    u32,
+    u32,
+    Spec {
+        type_: Some(bindings::fs_param_is_u32),
+        ..DEFAULT
+    },
+    // SAFETY: This is only called when the parse result is a u32, so it is ok to access to union
+    // field.
+    |_p, r| unsafe { r.__bindgen_anon_1.uint_32 }
+);
+
+define_param_type!(
+    u32oct,
+    u32,
+    Spec {
+        type_: Some(bindings::fs_param_is_u32),
+        extra: 8 as _,
+        ..DEFAULT
+    },
+    // SAFETY: This is only called when the parse result is a u32, so it is ok to access to union
+    // field.
+    |_p, r| unsafe { r.__bindgen_anon_1.uint_32 }
+);
+
+define_param_type!(
+    u32hex,
+    u32,
+    Spec {
+        type_: Some(bindings::fs_param_is_u32),
+        extra: 16 as _,
+        ..DEFAULT
+    },
+    // SAFETY: This is only called when the parse result is a u32, so it is ok to access to union
+    // field.
+    |_p, r| unsafe { r.__bindgen_anon_1.uint_32 }
+);
+
+define_param_type!(
+    s32,
+    i32,
+    Spec {
+        type_: Some(bindings::fs_param_is_s32),
+        ..DEFAULT
+    },
+    // SAFETY: This is only called when the parse result is an i32, so it is ok to access to union
+    // field.
+    |_p, r| unsafe { r.__bindgen_anon_1.int_32 }
+);
+
+define_param_type!(
+    u64,
+    u64,
+    Spec {
+        type_: Some(bindings::fs_param_is_u64),
+        extra: 16 as _,
+        ..DEFAULT
+    },
+    // SAFETY: This is only called when the parse result is a u32, so it is ok to access to union
+    // field.
+    |_p, r| unsafe { r.__bindgen_anon_1.uint_64 }
+);
+
+define_param_type!(
+    string,
+    &CStr,
+    Spec {
+        type_: Some(bindings::fs_param_is_string),
+        ..DEFAULT
+    },
+    // SAFETY: This is only called when the parse result is a string, so it is ok to access to
+    // union field.
+    |p, _r| unsafe { CStr::from_char_ptr(p.__bindgen_anon_1.string) }
+);
+
+/// Module to support `enum` parameter types.
+pub mod enum_ {
+    use super::*;
+
+    #[doc(hidden)]
+    pub const fn spec(name: &'static CStr, options: ConstantTable<'static>) -> Spec {
+        Spec {
+            name,
+            type_: Some(bindings::fs_param_is_enum),
+            extra: options.first as *const _ as _,
+            ..DEFAULT
+        }
+    }
+
+    #[doc(hidden)]
+    pub const fn handler<S: ForeignOwnable>(
+        setfn: fn(&mut <S as ForeignOwnable>::BorrowedMut<'_>, u32) -> Result,
+    ) -> impl Handler<S> {
+        let c = move |s: &mut <S as ForeignOwnable>::BorrowedMut<'_>,
+                      _p: &bindings::fs_parameter,
+                      r: &bindings::fs_parse_result| {
+            // SAFETY: This is only called when the parse result is an enum, so it is ok to access
+            // to union field.
+            setfn(s, unsafe { r.__bindgen_anon_1.uint_32 })
+        };
+        ConcreteHandler {
+            setfn: c,
+            _p: PhantomData,
+        }
+    }
+}
+
+const ZERO_SPEC: bindings::fs_parameter_spec = bindings::fs_parameter_spec {
+    name: core::ptr::null(),
+    type_: None,
+    opt: 0,
+    flags: 0,
+    data: core::ptr::null(),
+};
+
+/// A zero-terminated parameter spec array, followed by handlers.
+#[repr(C)]
+pub struct SpecArray<const N: usize, S: 'static> {
+    specs: [bindings::fs_parameter_spec; N],
+    sentinel: bindings::fs_parameter_spec,
+    handlers: [&'static dyn Handler<S>; N],
+}
+
+impl<const N: usize, S: 'static> SpecArray<N, S> {
+    /// Creates a new spec array.
+    ///
+    /// Users are encouraged to use the [`define_fs_params`] macro to define the
+    /// [`super::Context::PARAMS`] constant.
+    ///
+    /// # Safety
+    ///
+    /// The type of the elements in `handlers` must be compatible with the types in specs. For
+    /// example, if `specs` declares that the i-th element is a bool then the i-th handler
+    /// should be for a bool.
+    pub const unsafe fn new(specs: [Spec; N], handlers: [&'static dyn Handler<S>; N]) -> Self {
+        let mut array = Self {
+            specs: [ZERO_SPEC; N],
+            sentinel: ZERO_SPEC,
+            handlers,
+        };
+        let mut i = 0usize;
+        while i < N {
+            array.specs[i] = bindings::fs_parameter_spec {
+                name: specs[i].name.as_char_ptr(),
+                type_: specs[i].type_,
+                opt: i as _,
+                flags: specs[i].flags,
+                data: specs[i].extra,
+            };
+            i += 1;
+        }
+        array
+    }
+
+    /// Returns a [`SpecTable`] backed by `self`.
+    ///
+    /// This is used to essentially erase the array size.
+    pub const fn as_table(&self) -> SpecTable<'_, S> {
+        SpecTable {
+            first: &self.specs[0],
+            handlers: &self.handlers,
+            _p: PhantomData,
+        }
+    }
+}
+
+/// A parameter spec table.
+///
+/// The table is guaranteed to be zero-terminated.
+///
+/// Users are encouraged to use the [`define_fs_params`] macro to define the
+/// [`super::Context::PARAMS`] constant.
+pub struct SpecTable<'a, S: 'static> {
+    pub(super) first: &'a bindings::fs_parameter_spec,
+    pub(super) handlers: &'a [&'static dyn Handler<S>],
+    _p: PhantomData<S>,
+}
+
+impl<S> SpecTable<'static, S> {
+    pub(super) const fn empty() -> Self {
+        Self {
+            first: &ZERO_SPEC,
+            handlers: &[],
+            _p: PhantomData,
+        }
+    }
+}
+
+/// A zero-terminated parameter constant array.
+#[repr(C)]
+pub struct ConstantArray<const N: usize> {
+    consts: [bindings::constant_table; N],
+    sentinel: bindings::constant_table,
+}
+
+impl<const N: usize> ConstantArray<N> {
+    /// Creates a new constant array.
+    ///
+    /// Users are encouraged to use the [`define_fs_params`] macro to define the
+    /// [`super::Context::PARAMS`] constant.
+    pub const fn new(consts: [(&'static CStr, u32); N]) -> Self {
+        const ZERO: bindings::constant_table = bindings::constant_table {
+            name: core::ptr::null(),
+            value: 0,
+        };
+        let mut array = Self {
+            consts: [ZERO; N],
+            sentinel: ZERO,
+        };
+        let mut i = 0usize;
+        while i < N {
+            array.consts[i] = bindings::constant_table {
+                name: consts[i].0.as_char_ptr(),
+                value: consts[i].1 as _,
+            };
+            i += 1;
+        }
+        array
+    }
+
+    /// Returns a [`ConstantTable`] backed by `self`.
+    ///
+    /// This is used to essentially erase the array size.
+    pub const fn as_table(&self) -> ConstantTable<'_> {
+        ConstantTable {
+            first: &self.consts[0],
+        }
+    }
+}
+
+/// A parameter constant table.
+///
+/// The table is guaranteed to be zero-terminated.
+pub struct ConstantTable<'a> {
+    pub(super) first: &'a bindings::constant_table,
+}
+
+#[doc(hidden)]
+pub trait Handler<S: ForeignOwnable> {
+    fn handle_param(
+        &self,
+        state: &mut <S as ForeignOwnable>::BorrowedMut<'_>,
+        p: &bindings::fs_parameter,
+        r: &bindings::fs_parse_result,
+    ) -> Result;
+}
+
+struct ConcreteHandler<
+    S: ForeignOwnable,
+    T: Fn(
+        &mut <S as ForeignOwnable>::BorrowedMut<'_>,
+        &bindings::fs_parameter,
+        &bindings::fs_parse_result,
+    ) -> Result,
+> {
+    setfn: T,
+    _p: PhantomData<S>,
+}
+
+impl<
+        S: ForeignOwnable,
+        T: Fn(
+            &mut <S as ForeignOwnable>::BorrowedMut<'_>,
+            &bindings::fs_parameter,
+            &bindings::fs_parse_result,
+        ) -> Result,
+    > Handler<S> for ConcreteHandler<S, T>
+{
+    fn handle_param(
+        &self,
+        state: &mut <S as ForeignOwnable>::BorrowedMut<'_>,
+        p: &bindings::fs_parameter,
+        r: &bindings::fs_parse_result,
+    ) -> Result {
+        (self.setfn)(state, p, r)
+    }
+}
+
+/// Counts the number of parenthesis-delimited, comma-separated items.
+///
+/// # Examples
+///
+/// ```
+/// # use kernel::count_paren_items;
+///
+/// assert_eq!(0, count_paren_items!());
+/// assert_eq!(1, count_paren_items!((A)));
+/// assert_eq!(1, count_paren_items!((A),));
+/// assert_eq!(2, count_paren_items!((A), (B)));
+/// assert_eq!(2, count_paren_items!((A), (B),));
+/// assert_eq!(3, count_paren_items!((A), (B), (C)));
+/// assert_eq!(3, count_paren_items!((A), (B), (C),));
+/// ```
+#[macro_export]
+macro_rules! count_paren_items {
+    (($($item:tt)*), $($remaining:tt)*) => { 1 + $crate::count_paren_items!($($remaining)*) };
+    (($($item:tt)*)) => { 1 };
+    () => { 0 };
+}
+
+/// Counts the number of comma-separated entries surrounded by braces.
+///
+/// # Examples
+///
+/// ```
+/// # use kernel::count_brace_items;
+///
+/// assert_eq!(0, count_brace_items!());
+/// assert_eq!(1, count_brace_items!({A}));
+/// assert_eq!(1, count_brace_items!({A},));
+/// assert_eq!(2, count_brace_items!({A}, {B}));
+/// assert_eq!(2, count_brace_items!({A}, {B},));
+/// assert_eq!(3, count_brace_items!({A}, {B}, {C}));
+/// assert_eq!(3, count_brace_items!({A}, {B}, {C},));
+/// ```
+#[macro_export]
+macro_rules! count_brace_items {
+    ({$($item:tt)*}, $($remaining:tt)*) => { 1 + $crate::count_brace_items!($($remaining)*) };
+    ({$($item:tt)*}) => { 1 };
+    () => { 0 };
+}
+
+/// Defines the file system parameters of a given file system context.
+///
+/// # Examples
+/// ```
+/// # use kernel::prelude::*;
+/// # use kernel::{c_str, fs, str::CString};
+///
+/// #[derive(Default)]
+/// struct State {
+///     flag: Option<bool>,
+///     flag_no: Option<bool>,
+///     bool_value: Option<bool>,
+///     u32_value: Option<u32>,
+///     i32_value: Option<i32>,
+///     u64_value: Option<u64>,
+///     str_value: Option<CString>,
+///     enum_value: Option<u32>,
+/// }
+///
+/// fn set_u32(s: &mut Box<State>, v: u32) -> Result {
+///     s.u32_value = Some(v);
+///     Ok(())
+/// }
+///
+/// struct Example;
+///
+/// #[vtable]
+/// impl fs::Context<Self> for Example {
+///     type Data = Box<State>;
+///
+///     kernel::define_fs_params!{Box<State>,
+///         {flag, "flag", |s, v| { s.flag = Some(v); Ok(()) } },
+///         {flag_no, "flagno", |s, v| { s.flag_no = Some(v); Ok(()) } },
+///         {bool, "bool", |s, v| { s.bool_value = Some(v); Ok(()) } },
+///         {u32, "u32", set_u32 },
+///         {u32oct, "u32oct", set_u32 },
+///         {u32hex, "u32hex", set_u32 },
+///         {s32, "s32", |s, v| { s.i32_value = Some(v); Ok(()) } },
+///         {u64, "u64", |s, v| { s.u64_value = Some(v); Ok(()) } },
+///         {string, "string", |s, v| {
+///             s.str_value = Some(CString::try_from_fmt(fmt!("{v}"))?);
+///             Ok(())
+///         }},
+///         {enum, "enum", [("first", 10), ("second", 20)], |s, v| {
+///             s.enum_value = Some(v);
+///             Ok(())
+///         }},
+///     }
+///
+///     fn try_new() -> Result<Self::Data> {
+///         Ok(Box::try_new(State::default())?)
+///     }
+/// }
+///
+/// # impl fs::Type for Example {
+/// #    type Context = Self;
+/// #    const NAME: &'static CStr = c_str!("example");
+/// #    const FLAGS: i32 = 0;
+/// #    const MAGIC: u32 = 0x6578616d;
+/// # }
+/// ```
+#[macro_export]
+macro_rules! define_fs_params {
+    ($data_type:ty, $({$($t:tt)*}),+ $(,)?) => {
+        const PARAMS: $crate::fs::param::SpecTable<'static, $data_type> =
+            {
+                use $crate::fs::param::{self, ConstantArray, Spec, SpecArray, Handler};
+                use $crate::c_str;
+                const COUNT: usize = $crate::count_brace_items!($({$($t)*},)*);
+                const SPECS: [Spec; COUNT] = $crate::define_fs_params!(@specs $({$($t)*},)*);
+                const HANDLERS: [&dyn Handler<$data_type>; COUNT] =
+                    $crate::define_fs_params!(@handlers $data_type, $({$($t)*},)*);
+                // SAFETY: We defined matching specs and handlers above.
+                const ARRAY: SpecArray<COUNT, $data_type> =
+                    unsafe { SpecArray::new(SPECS, HANDLERS) };
+                ARRAY.as_table()
+            };
+    };
+
+    (@handlers $data_type:ty, $({$($t:tt)*},)*) => {
+        [ $($crate::define_fs_params!(@handler $data_type, $($t)*),)* ]
+    };
+    (@handler $data_type:ty, enum, $name:expr, $opts:expr, $closure:expr) => {
+        &param::enum_::handler::<$data_type>($closure)
+    };
+    (@handler $data_type:ty, $type:ident, $name:expr, $closure:expr) => {
+        &param::$type::handler::<$data_type>($closure)
+    };
+
+    (@specs $({$($t:tt)*},)*) => {[ $($crate::define_fs_params!(@spec $($t)*),)* ]};
+    (@spec enum, $name:expr, [$($opts:tt)*], $closure:expr) => {
+        {
+            const COUNT: usize = $crate::count_paren_items!($($opts)*);
+            const OPTIONS: ConstantArray<COUNT> =
+                ConstantArray::new($crate::define_fs_params!(@c_str_first $($opts)*));
+            param::enum_::spec(c_str!($name), OPTIONS.as_table())
+        }
+    };
+    (@spec $type:ident, $name:expr, $closure:expr) => { param::$type::spec(c_str!($name)) };
+
+    (@c_str_first $(($first:expr, $second:expr)),+ $(,)?) => {
+        [$((c_str!($first), $second),)*]
+    };
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index ea1411a25ee4..59253f5390cd 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -12,11 +12,13 @@
 //! do so first instead of bypassing this crate.
 
 #![no_std]
+#![feature(associated_type_defaults)]
 #![feature(coerce_unsized)]
 #![feature(dispatch_from_dyn)]
 #![feature(new_uninit)]
 #![feature(receiver_trait)]
 #![feature(unsize)]
+#![feature(const_mut_refs)]
 
 // Ensure conditional compilation based on the kernel configuration works;
 // otherwise we may silently break things like initcall handling.
@@ -62,6 +64,11 @@
 #[doc(hidden)]
 pub use build_error::build_error;
 
+/// Page size defined in terms of the `PAGE_SHIFT` macro from C.
+///
+/// [`PAGE_SHIFT`]: ../../../include/asm-generic/page.h
+pub const PAGE_SIZE: usize = 1 << bindings::PAGE_SHIFT;
+
 /// Prefix to appear before log messages printed from within the `kernel` crate.
 const __LOG_PREFIX: &[u8] = b"rust_kernel\0";
 
diff --git a/samples/rust/rust_rofs.rs b/samples/rust/rust_rofs.rs
index 5d0d1936459d..d81ea8fdf174 100644
--- a/samples/rust/rust_rofs.rs
+++ b/samples/rust/rust_rofs.rs
@@ -55,6 +55,31 @@ struct Entry {
 const DIR_IOPS: inode::Ops<RoFs> = inode::Ops::new::<RoFs>();
 const FILE_AOPS: address_space::Ops<RoFs> = address_space::Ops::new::<RoFs>();
 
+#[vtable]
+impl fs::Context<Self> for RoFs {
+    type Data = ();
+
+    kernel::define_fs_params! {(),
+        {flag, "flag", |_, v| { pr_info!("flag passed-in: {v}\n"); Ok(()) } },
+        {flag_no, "flagno", |_, v| { pr_info!("flagno passed-in: {v}\n"); Ok(()) } },
+        {bool, "bool", |_, v| { pr_info!("bool passed-in: {v}\n"); Ok(()) } },
+        {u32, "u32", |_, v| { pr_info!("u32 passed-in: {v}\n"); Ok(()) } },
+        {u32oct, "u32oct", |_, v| { pr_info!("u32oct passed-in: {v}\n"); Ok(()) } },
+        {u32hex, "u32hex", |_, v| { pr_info!("u32hex passed-in: {v}\n"); Ok(()) } },
+        {s32, "s32", |_, v| { pr_info!("s32 passed-in: {v}\n"); Ok(()) } },
+        {u64, "u64", |_, v| { pr_info!("u64 passed-in: {v}\n"); Ok(()) } },
+        {string, "string", |_, v| { pr_info!("string passed-in: {v}\n"); Ok(()) } },
+        {enum, "enum", [("first", 10), ("second", 20)], |_, v| {
+            pr_info!("enum passed-in: {v}\n"); Ok(()) }
+        },
+    }
+
+    fn try_new() -> Result {
+        pr_info!("context created!\n");
+        Ok(())
+    }
+}
+
 struct RoFs;
 
 impl RoFs {
@@ -103,11 +128,16 @@ fn iget(sb: &sb::SuperBlock<Self>, e: &'static Entry) -> Result<ARef<INode<Self>
 }
 
 impl fs::FileSystem for RoFs {
+    type Context = Self;
     type Data = ();
     type INodeData = &'static Entry;
     const NAME: &'static CStr = c_str!("rust_rofs");
 
-    fn fill_super(sb: &mut sb::SuperBlock<Self, sb::New>, _: Option<inode::Mapper>) -> Result {
+    fn fill_super(
+        _data: (),
+        sb: &mut sb::SuperBlock<Self, sb::New>,
+        _: Option<inode::Mapper>,
+    ) -> Result {
         sb.set_magic(0x52555354);
         Ok(())
     }
-- 
2.34.1


