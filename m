Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B853763CE7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jul 2023 18:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbjGZQsL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 12:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231685AbjGZQrx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 12:47:53 -0400
Received: from aer-iport-8.cisco.com (aer-iport-8.cisco.com [173.38.203.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C573F2703
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 09:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=7763; q=dns/txt; s=iport;
  t=1690390038; x=1691599638;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KpPr0Hy4pGpqEy0mTBFyST7zmNlk6KLH8UX7VvAwlLA=;
  b=HFhS/J0Htc/sn61h3X+U+gm8NDal+s/ng2smrA6WZooMUAPfuLI6wxUV
   mMHM5J1RQuiuk7JrZGnYwWbYhL3q169NFOg2QZkRgI/kS7pRyDtGuWisw
   OBdVW8TeoQBXwMlK9Nw2NrhrC8ZJ63yaO3khfCoddhH6V0yYtubznks1n
   c=;
X-IronPort-AV: E=Sophos;i="6.01,232,1684800000"; 
   d="scan'208";a="5816071"
Received: from aer-iport-nat.cisco.com (HELO aer-core-7.cisco.com) ([173.38.203.22])
  by aer-iport-8.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 16:46:13 +0000
Received: from archlinux-cisco.cisco.com (dhcp-10-61-98-211.cisco.com [10.61.98.211])
        (authenticated bits=0)
        by aer-core-7.cisco.com (8.15.2/8.15.2) with ESMTPSA id 36QGjqTu022602
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 26 Jul 2023 16:46:13 GMT
From:   Ariel Miculas <amiculas@cisco.com>
To:     rust-for-linux@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tycho@tycho.pizza, brauner@kernel.org, viro@zeniv.linux.org.uk,
        ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
        Ariel Miculas <amiculas@cisco.com>
Subject: [RFC PATCH v2 04/10] rust: file: Add a new RegularFile newtype useful for reading files
Date:   Wed, 26 Jul 2023 19:45:28 +0300
Message-ID: <20230726164535.230515-5-amiculas@cisco.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230726164535.230515-1-amiculas@cisco.com>
References: <20230726164535.230515-1-amiculas@cisco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-User: amiculas
X-Outbound-SMTP-Client: 10.61.98.211, dhcp-10-61-98-211.cisco.com
X-Outbound-Node: aer-core-7.cisco.com
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Implement from_path, from_path_in_root_mnt, read_with_offset,
read_to_end and get_file_size methods for a RegularFile newtype.

Signed-off-by: Ariel Miculas <amiculas@cisco.com>
---
 rust/helpers.c       |   6 ++
 rust/kernel/error.rs |   4 +-
 rust/kernel/file.rs  | 129 ++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 135 insertions(+), 4 deletions(-)

diff --git a/rust/helpers.c b/rust/helpers.c
index eed8ace52fb5..9e860a554cda 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -213,6 +213,12 @@ void *rust_helper_alloc_inode_sb(struct super_block *sb,
 }
 EXPORT_SYMBOL_GPL(rust_helper_alloc_inode_sb);
 
+loff_t rust_helper_i_size_read(const struct inode *inode)
+{
+	return i_size_read(inode);
+}
+EXPORT_SYMBOL_GPL(rust_helper_i_size_read);
+
 /*
  * We use `bindgen`'s `--size_t-is-usize` option to bind the C `size_t` type
  * as the Rust `usize` type, so we can use it in contexts where Rust
diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
index 05fcab6abfe6..e061c83f806a 100644
--- a/rust/kernel/error.rs
+++ b/rust/kernel/error.rs
@@ -273,9 +273,7 @@ pub fn to_result(err: core::ffi::c_int) -> Result {
 ///     }
 /// }
 /// ```
-// TODO: Remove `dead_code` marker once an in-kernel client is available.
-#[allow(dead_code)]
-pub(crate) fn from_err_ptr<T>(ptr: *mut T) -> Result<*mut T> {
+pub fn from_err_ptr<T>(ptr: *mut T) -> Result<*mut T> {
     // CAST: Casting a pointer to `*const core::ffi::c_void` is always valid.
     let const_ptr: *const core::ffi::c_void = ptr.cast();
     // SAFETY: The FFI function does not deref the pointer.
diff --git a/rust/kernel/file.rs b/rust/kernel/file.rs
index 494939ba74df..a3002c416dbb 100644
--- a/rust/kernel/file.rs
+++ b/rust/kernel/file.rs
@@ -8,11 +8,13 @@
 use crate::{
     bindings,
     cred::Credential,
-    error::{code::*, from_result, Error, Result},
+    error::{code::*, from_err_ptr, from_result, Error, Result},
     fs,
     io_buffer::{IoBufferReader, IoBufferWriter},
     iov_iter::IovIter,
     mm,
+    mount::Vfsmount,
+    str::CStr,
     sync::CondVar,
     types::ARef,
     types::AlwaysRefCounted,
@@ -20,6 +22,7 @@
     types::Opaque,
     user_ptr::{UserSlicePtr, UserSlicePtrReader, UserSlicePtrWriter},
 };
+use alloc::vec::Vec;
 use core::convert::{TryFrom, TryInto};
 use core::{marker, mem, ptr};
 use macros::vtable;
@@ -201,6 +204,130 @@ unsafe fn dec_ref(obj: ptr::NonNull<Self>) {
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
+    fn create_if_regular(file_ptr: ptr::NonNull<bindings::file>) -> Result<RegularFile> {
+        // SAFETY: file_ptr is a NonNull pointer
+        let inode = unsafe { core::ptr::addr_of!((*file_ptr.as_ptr()).f_inode).read() };
+        // SAFETY: the caller must ensure f_inode is initialized to a valid pointer
+        unsafe {
+            if bindings::S_IFMT & ((*inode).i_mode) as u32 != bindings::S_IFREG {
+                return Err(EINVAL);
+            }
+        }
+        // SAFETY: the safety requirements state that file_ptr's reference count was incremented at
+        // least once
+        Ok(RegularFile(unsafe { ARef::from_raw(file_ptr.cast()) }))
+    }
+    /// Constructs a new [`struct file`] wrapper from a path.
+    pub fn from_path(filename: &CStr, flags: i32, mode: u16) -> Result<Self> {
+        let file_ptr = unsafe {
+            // SAFETY: filename is a reference, so it's a valid pointer
+            from_err_ptr(bindings::filp_open(
+                filename.as_ptr() as *const i8,
+                flags,
+                mode,
+            ))?
+        };
+        let file_ptr = ptr::NonNull::new(file_ptr).ok_or(ENOENT)?;
+
+        // SAFETY: `filp_open` initializes the refcount with 1
+        Self::create_if_regular(file_ptr)
+    }
+
+    /// Constructs a new [`struct file`] wrapper from a path and a vfsmount.
+    pub fn from_path_in_root_mnt(
+        mount: &Vfsmount,
+        filename: &CStr,
+        flags: i32,
+        mode: u16,
+    ) -> Result<Self> {
+        let file_ptr = {
+            let mnt = mount.get();
+            // construct a path from vfsmount, see file_open_root_mnt
+            let raw_path = bindings::path {
+                mnt,
+                // SAFETY: Vfsmount structure stores a valid vfsmount object
+                dentry: unsafe { (*mnt).mnt_root },
+            };
+            unsafe {
+                // SAFETY: raw_path and filename are both references
+                from_err_ptr(bindings::file_open_root(
+                    &raw_path,
+                    filename.as_ptr() as *const i8,
+                    flags,
+                    mode,
+                ))?
+            }
+        };
+        let file_ptr = ptr::NonNull::new(file_ptr).ok_or(ENOENT)?;
+
+        // SAFETY: `file_open_root` initializes the refcount with 1
+        Self::create_if_regular(file_ptr)
+    }
+
+    /// Read from the file into the specified buffer
+    pub fn read_with_offset(&self, buf: &mut [u8], offset: u64) -> Result<usize> {
+        Ok({
+            // kernel_read_file expects a pointer to a "void *" buffer
+            let mut ptr_to_buf = buf.as_mut_ptr() as *mut core::ffi::c_void;
+            // Unless we give a non-null pointer to the file size:
+            // 1. we cannot give a non-zero value for the offset
+            // 2. we cannot have offset 0 and buffer_size > file_size
+            let mut file_size = 0;
+
+            // SAFETY: 'file' is valid because it's taken from Self, 'buf' and 'file_size` are
+            // references to the stack variables 'ptr_to_buf' and 'file_size'; ptr_to_buf is also
+            // a pointer to a valid buffer that was obtained from a reference
+            let result = unsafe {
+                bindings::kernel_read_file(
+                    self.0 .0.get(),
+                    offset.try_into()?,
+                    &mut ptr_to_buf,
+                    buf.len(),
+                    &mut file_size,
+                    bindings::kernel_read_file_id_READING_UNKNOWN,
+                )
+            };
+
+            // kernel_read_file returns the number of bytes read on success or negative on error.
+            if result < 0 {
+                return Err(Error::from_errno(result.try_into()?));
+            }
+
+            result.try_into()?
+        })
+    }
+
+    /// Allocate and return a vector containing the contents of the entire file
+    pub fn read_to_end(&self) -> Result<Vec<u8>> {
+        let file_size = self.get_file_size()?;
+        let mut buffer = Vec::try_with_capacity(file_size)?;
+        buffer.try_resize(file_size, 0)?;
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
 /// A file descriptor reservation.
 ///
 /// This allows the creation of a file descriptor in two steps: first, we reserve a slot for it,
-- 
2.41.0

