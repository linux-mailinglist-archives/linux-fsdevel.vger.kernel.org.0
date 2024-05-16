Return-Path: <linux-fsdevel+bounces-19598-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6158C7CC7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2024 21:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3023B28325E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2024 19:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5219156F50;
	Thu, 16 May 2024 19:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="j+WGEDmG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from aer-iport-2.cisco.com (aer-iport-2.cisco.com [173.38.203.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238FC14533D;
	Thu, 16 May 2024 19:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.38.203.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715886261; cv=none; b=ntavZk71l5vZN2+xP4Etqi1CdsnhZupcktyAtaGy5/cqOUYvokub2RKjYaXG3l7d1kM/BT5UlnWI7K+N4KtdmY0WDEzIZuUPFjTGYxhwCC8vPUiusKpgJ9ngUsmjvnufo4deZpD85b+URVZGMuJ+HcKywMxyRlcyLEdlX1+gGOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715886261; c=relaxed/simple;
	bh=ZW6e38D7V579eUYjN8wx+opoFbYZthAY3SWMwT68uA4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pugBNa2FzupcRsLPcKLy3hnLTYmtJt8qKw8j1T2FxOG685ZL8m1kgJE89/xTu7pB72HS0YCZ4sY3+2zXW46NB7A+EALIbJDyg7uw1A0oj4hwyxrqhmQvYXxMWZfmpDUAJJXVTd6QpxuW7CSnd91V/zfCpDKB4y8TK1i6AK/imYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=j+WGEDmG; arc=none smtp.client-ip=173.38.203.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=6116; q=dns/txt; s=iport;
  t=1715886258; x=1717095858;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gtETx0x72o83B4fsks8iN1y24qrMuZAVeU7lzntU45E=;
  b=j+WGEDmGX/g0WHHUPLpaplSOlw/RrCGrvB+laRN4KNsM0qLD3kEVNTtN
   q/qX355FuMLqwVxsCfesgXd9TJsf1SxBJGn7PEtPgkC/DdwnJ/IgWUuyZ
   THQYE56PQ46kD/u6CZ3WM8yzqwGlXOnI5gLGV+gp+vt2V2HrZI8TKqqMW
   0=;
X-CSE-ConnectionGUID: HMe8tTQ/T8S85WGsTTj5nA==
X-CSE-MsgGUID: 8UtqKVBVRKWMKr4vvm8D5Q==
X-IronPort-AV: E=Sophos;i="6.08,165,1712620800"; 
   d="scan'208";a="12416988"
Received: from aer-iport-nat.cisco.com (HELO aer-core-5.cisco.com) ([173.38.203.22])
  by aer-iport-2.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 19:04:16 +0000
Received: from localhost (ams3-vpn-dhcp4879.cisco.com [10.61.83.14])
	(authenticated bits=0)
	by aer-core-5.cisco.com (8.15.2/8.15.2) with ESMTPSA id 44GJ4Fgt055638
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 16 May 2024 19:04:16 GMT
From: Ariel Miculas <amiculas@cisco.com>
To: rust-for-linux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tycho@tycho.pizza, brauner@kernel.org, viro@zeniv.linux.org.uk,
        ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
        shallyn@cisco.com, Ariel Miculas <amiculas@cisco.com>
Subject: [RFC PATCH v3 12/22] rust: file: Add support for reading files using their path
Date: Thu, 16 May 2024 22:03:35 +0300
Message-Id: <20240516190345.957477-13-amiculas@cisco.com>
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
X-Outbound-Node: aer-core-5.cisco.com

Implement from_path, from_path_in_root_mnt, read_with_offset,
read_to_end and get_file_size methods for a RegularFile newtype.
`kernel_read_file` is used under the hood for reading files.

These functions will be used for reading the PuzzleFS metadata files and
the chunks in the data store.

Signed-off-by: Ariel Miculas <amiculas@cisco.com>
---
 rust/kernel/error.rs |   2 +-
 rust/kernel/file.rs  | 124 ++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 124 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
index edada157879a..3cf916bc884f 100644
--- a/rust/kernel/error.rs
+++ b/rust/kernel/error.rs
@@ -263,7 +263,7 @@ pub fn to_result(err: core::ffi::c_int) -> Result {
 ///     from_err_ptr(unsafe { bindings::devm_platform_ioremap_resource(pdev.to_ptr(), index) })
 /// }
 /// ```
-pub(crate) fn from_err_ptr<T>(ptr: *mut T) -> Result<*mut T> {
+pub fn from_err_ptr<T>(ptr: *mut T) -> Result<*mut T> {
     // CAST: Casting a pointer to `*const core::ffi::c_void` is always valid.
     let const_ptr: *const core::ffi::c_void = ptr.cast();
     // SAFETY: The FFI function does not deref the pointer.
diff --git a/rust/kernel/file.rs b/rust/kernel/file.rs
index 99657adf2472..c381cc297f3a 100644
--- a/rust/kernel/file.rs
+++ b/rust/kernel/file.rs
@@ -5,11 +5,16 @@
 //! C headers: [`include/linux/fs.h`](../../../../include/linux/fs.h) and
 //! [`include/linux/file.h`](../../../../include/linux/file.h)
 
+use crate::alloc::flags::GFP_KERNEL;
+use crate::alloc::vec_ext::VecExt;
 use crate::{
     bindings,
-    error::{code::*, Error, Result},
+    error::{code::*, from_err_ptr, Error, Result},
+    mount::Vfsmount,
+    str::CStr,
     types::{ARef, AlwaysRefCounted, Opaque},
 };
+use alloc::vec::Vec;
 use core::ptr;
 
 /// Flags associated with a [`File`].
@@ -164,6 +169,123 @@ unsafe fn dec_ref(obj: ptr::NonNull<Self>) {
     }
 }
 
+/// A newtype over file, specific to regular files
+pub struct RegularFile(ARef<File>);
+impl RegularFile {
+    /// Creates a new instance of Self if the file is a regular file
+    ///
+    /// # Safety
+    ///
+    /// The caller must ensure file_ptr.f_inode is initialized to a valid pointer (e.g. file_ptr is
+    /// a pointer returned by path_openat); It must also ensure that file_ptr's reference count was
+    /// incremented at least once
+    unsafe fn create_if_regular(file_ptr: *mut bindings::file) -> Result<RegularFile> {
+        let file_ptr = ptr::NonNull::new(file_ptr).ok_or(ENOENT)?;
+        // SAFETY: file_ptr is a NonNull pointer
+        let inode = unsafe { core::ptr::addr_of!((*file_ptr.as_ptr()).f_inode).read() };
+        // SAFETY: the caller must ensure f_inode is initialized to a valid pointer
+        let inode_mode = unsafe { (*inode).i_mode as u32 };
+        if bindings::S_IFMT & inode_mode != bindings::S_IFREG {
+            return Err(EINVAL);
+        }
+        // SAFETY: the safety requirements state that file_ptr's reference count was incremented at
+        // least once
+        Ok(RegularFile(unsafe { ARef::from_raw(file_ptr.cast()) }))
+    }
+    /// Constructs a new [`struct file`] wrapper from a path.
+    pub fn from_path(filename: &CStr, flags: i32, mode: u16) -> Result<Self> {
+        // SAFETY: filename is a reference, so it's a valid pointer
+        let file_ptr = unsafe {
+            from_err_ptr(bindings::filp_open(
+                filename.as_ptr().cast::<i8>(),
+                flags,
+                mode,
+            ))?
+        };
+
+        // SAFETY: `filp_open` initializes the refcount with 1
+        unsafe { Self::create_if_regular(file_ptr) }
+    }
+
+    /// Constructs a new [`struct file`] wrapper from a path and a vfsmount.
+    pub fn from_path_in_root_mnt(
+        mount: &Vfsmount,
+        filename: &CStr,
+        flags: i32,
+        mode: u16,
+    ) -> Result<Self> {
+        let mnt = mount.get();
+        // construct a path from vfsmount, see file_open_root_mnt
+        let raw_path = bindings::path {
+            mnt,
+            // SAFETY: Vfsmount structure stores a valid vfsmount object
+            dentry: unsafe { (*mnt).mnt_root },
+        };
+        let file_ptr = unsafe {
+            // SAFETY: raw_path and filename are both references
+            from_err_ptr(bindings::file_open_root(
+                &raw_path,
+                filename.as_ptr().cast::<i8>(),
+                flags,
+                mode,
+            ))?
+        };
+        // SAFETY: `file_open_root` initializes the refcount with 1
+        unsafe { Self::create_if_regular(file_ptr) }
+    }
+
+    /// Read from the file into the specified buffer
+    pub fn read_with_offset(&self, buf: &mut [u8], offset: u64) -> Result<usize> {
+        // kernel_read_file expects a pointer to a "void *" buffer
+        let mut ptr_to_buf = buf.as_mut_ptr() as *mut core::ffi::c_void;
+        // Unless we give a non-null pointer to the file size:
+        // 1. we cannot give a non-zero value for the offset
+        // 2. we cannot have offset 0 and buffer_size > file_size
+        let mut file_size = 0;
+
+        // SAFETY: 'file' is valid because it's taken from Self, 'buf' and 'file_size` are
+        // references to the stack variables 'ptr_to_buf' and 'file_size'; ptr_to_buf is also
+        // a pointer to a valid buffer that was obtained from a reference
+        let result = unsafe {
+            bindings::kernel_read_file(
+                self.0 .0.get(),
+                offset.try_into()?,
+                &mut ptr_to_buf,
+                buf.len(),
+                &mut file_size,
+                bindings::kernel_read_file_id_READING_UNKNOWN,
+            )
+        };
+
+        // kernel_read_file returns the number of bytes read on success or negative on error.
+        if result < 0 {
+            return Err(Error::from_errno(result.try_into()?));
+        }
+
+        Ok(result.try_into()?)
+    }
+
+    /// Allocate and return a vector containing the contents of the entire file
+    pub fn read_to_end(&self) -> Result<Vec<u8>> {
+        let file_size = self.get_file_size()?;
+        let mut buffer = Vec::with_capacity(file_size, GFP_KERNEL)?;
+        buffer.resize(file_size, 0, GFP_KERNEL)?;
+        self.read_with_offset(&mut buffer, 0)?;
+        Ok(buffer)
+    }
+
+    fn get_file_size(&self) -> Result<usize> {
+        // SAFETY: 'file' is valid because it's taken from Self
+        let file_size = unsafe { bindings::i_size_read((*self.0 .0.get()).f_inode) };
+
+        if file_size < 0 {
+            return Err(EINVAL);
+        }
+
+        Ok(file_size.try_into()?)
+    }
+}
+
 /// Represents the EBADF error code.
 ///
 /// Used for methods that can only fail with EBADF.
-- 
2.34.1


