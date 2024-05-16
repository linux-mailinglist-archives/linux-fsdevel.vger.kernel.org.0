Return-Path: <linux-fsdevel+bounces-19616-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC178C7CED
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2024 21:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 724DC284389
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2024 19:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488F615E21C;
	Thu, 16 May 2024 19:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="FACq3hiF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from aer-iport-7.cisco.com (aer-iport-7.cisco.com [173.38.203.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26AB615DBCE;
	Thu, 16 May 2024 19:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.38.203.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715886328; cv=none; b=eoEff+NFukibGKrsVrX82wUYnFFWBn9r5c+fvMY8oAoKchsEV6CJCVtBk0l0ecMKe4QASicWsdzj0vQfM3CTxaETFoCxTxQ5aPkugakxDV4pMV9/aHI7pXhw7M3k7rEEO68hPy83bCvatJhcPQePa2KvXE/Y/nfK7c4nHBpf1k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715886328; c=relaxed/simple;
	bh=Dz0gY/c1vUKma34oa1qxnWPM+toKhYV0/teb5v0jICY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dxcGHbKAUgGWuQQDo58GDsTvysFW4AxIz76ry9m4No0e1sV+GKwS9S71UTXuem5WSrxbo9kFxQZGEpzevhiLGlpnLFeZSmqZjtPyaS+WumgVqhGbXqjTZFGv936NTMZGcRvsOyORq4BYApdHvBJTzOw0DKhYvH1RhByAN7BdpUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=FACq3hiF; arc=none smtp.client-ip=173.38.203.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=8763; q=dns/txt; s=iport;
  t=1715886326; x=1717095926;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5Zfgw+5jkP6UldlboEjN6TYcmmohaRCDa/+fIuipmTo=;
  b=FACq3hiFh+OUm1HG/vpRjVqYN7PaYvUYxBJWDvWGASKBUV1tMOPMr5mx
   bZ0HV0XHjktPMDX4RkgN0VaPeWficEwbdP02HmVXCPbAVZFRBmWVc5Yq2
   fN6oT1szB1ay7rIPn07irpp0zMid/x9KTRuhUVLjrZUMySTaorgn1VIyi
   U=;
X-CSE-ConnectionGUID: ylCF91jLTHmQaXFxkL82OQ==
X-CSE-MsgGUID: I2kJKejwSomKFhk4qWuDOA==
X-IronPort-AV: E=Sophos;i="6.08,165,1712620800"; 
   d="scan'208";a="13072182"
Received: from aer-iport-nat.cisco.com (HELO aer-core-4.cisco.com) ([173.38.203.22])
  by aer-iport-7.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 19:04:14 +0000
Received: from localhost (ams3-vpn-dhcp4879.cisco.com [10.61.83.14])
	(authenticated bits=0)
	by aer-core-4.cisco.com (8.15.2/8.15.2) with ESMTPSA id 44GJ4EuC006367
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 16 May 2024 19:04:14 GMT
From: Ariel Miculas <amiculas@cisco.com>
To: rust-for-linux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tycho@tycho.pizza, brauner@kernel.org, viro@zeniv.linux.org.uk,
        ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
        shallyn@cisco.com, Wedson Almeida Filho <walmeida@microsoft.com>,
        Daniel Xu <dxu@dxuuu.xyz>, Alice Ryhl <aliceryhl@google.com>,
        Ariel Miculas <amiculas@cisco.com>
Subject: [RFC PATCH v3 11/22] rust: file: add bindings for `struct file`
Date: Thu, 16 May 2024 22:03:34 +0300
Message-Id: <20240516190345.957477-12-amiculas@cisco.com>
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
X-Outbound-Node: aer-core-4.cisco.com

From: Wedson Almeida Filho <walmeida@microsoft.com>

Using these bindings it becomes possible to access files from drivers
written in Rust. This patch only adds support for accessing the flags,
and for managing the refcount of the file.

Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
Co-Developed-by: Daniel Xu <dxu@dxuuu.xyz>
Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
Co-Developed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
[Adapted for upstream]
Signed-off-by: Ariel Miculas <amiculas@cisco.com>
---
 rust/bindings/bindings_helper.h |   1 +
 rust/helpers.c                  |  16 +++
 rust/kernel/file.rs             | 176 ++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs              |   1 +
 4 files changed, 194 insertions(+)
 create mode 100644 rust/kernel/file.rs

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 2d87bb9f87c9..0491bb05270c 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -13,6 +13,7 @@
 #include <linux/file.h>
 #include <linux/fs.h>
 #include <linux/fs_context.h>
+#include <linux/fs_parser.h>
 #include <linux/iomap.h>
 #include <linux/jiffies.h>
 #include <linux/mdio.h>
diff --git a/rust/helpers.c b/rust/helpers.c
index c26aa07cb20f..90acf9677aa6 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -28,6 +28,7 @@
 #include <linux/err.h>
 #include <linux/errname.h>
 #include <linux/fs.h>
+#include <linux/fs_parser.h>
 #include <linux/highmem.h>
 #include <linux/mm.h>
 #include <linux/mutex.h>
@@ -353,6 +354,21 @@ void rust_helper_set_delayed_call(struct delayed_call *call,
 }
 EXPORT_SYMBOL_GPL(rust_helper_set_delayed_call);
 
+struct inode *rust_helper_d_inode(const struct dentry *dentry)
+{
+	return d_inode(dentry);
+}
+EXPORT_SYMBOL_GPL(rust_helper_d_inode);
+
+int rust_helper_fs_parse(struct fs_context *fc,
+		const struct fs_parameter_spec *desc,
+		struct fs_parameter *param,
+		struct fs_parse_result *result)
+{
+	return fs_parse(fc, desc, param, result);
+}
+EXPORT_SYMBOL_GPL(rust_helper_fs_parse);
+
 /*
  * `bindgen` binds the C `size_t` type as the Rust `usize` type, so we can
  * use it in contexts where Rust expects a `usize` like slice (array) indices.
diff --git a/rust/kernel/file.rs b/rust/kernel/file.rs
new file mode 100644
index 000000000000..99657adf2472
--- /dev/null
+++ b/rust/kernel/file.rs
@@ -0,0 +1,176 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Files and file descriptors.
+//!
+//! C headers: [`include/linux/fs.h`](../../../../include/linux/fs.h) and
+//! [`include/linux/file.h`](../../../../include/linux/file.h)
+
+use crate::{
+    bindings,
+    error::{code::*, Error, Result},
+    types::{ARef, AlwaysRefCounted, Opaque},
+};
+use core::ptr;
+
+/// Flags associated with a [`File`].
+pub mod flags {
+    /// File is opened in append mode.
+    pub const O_APPEND: u32 = bindings::O_APPEND;
+
+    /// Signal-driven I/O is enabled.
+    pub const O_ASYNC: u32 = bindings::FASYNC;
+
+    /// Close-on-exec flag is set.
+    pub const O_CLOEXEC: u32 = bindings::O_CLOEXEC;
+
+    /// File was created if it didn't already exist.
+    pub const O_CREAT: u32 = bindings::O_CREAT;
+
+    /// Direct I/O is enabled for this file.
+    pub const O_DIRECT: u32 = bindings::O_DIRECT;
+
+    /// File must be a directory.
+    pub const O_DIRECTORY: u32 = bindings::O_DIRECTORY;
+
+    /// Like [`O_SYNC`] except metadata is not synced.
+    pub const O_DSYNC: u32 = bindings::O_DSYNC;
+
+    /// Ensure that this file is created with the `open(2)` call.
+    pub const O_EXCL: u32 = bindings::O_EXCL;
+
+    /// Large file size enabled (`off64_t` over `off_t`).
+    pub const O_LARGEFILE: u32 = bindings::O_LARGEFILE;
+
+    /// Do not update the file last access time.
+    pub const O_NOATIME: u32 = bindings::O_NOATIME;
+
+    /// File should not be used as process's controlling terminal.
+    pub const O_NOCTTY: u32 = bindings::O_NOCTTY;
+
+    /// If basename of path is a symbolic link, fail open.
+    pub const O_NOFOLLOW: u32 = bindings::O_NOFOLLOW;
+
+    /// File is using nonblocking I/O.
+    pub const O_NONBLOCK: u32 = bindings::O_NONBLOCK;
+
+    /// Also known as `O_NDELAY`.
+    ///
+    /// This is effectively the same flag as [`O_NONBLOCK`] on all architectures
+    /// except SPARC64.
+    pub const O_NDELAY: u32 = bindings::O_NDELAY;
+
+    /// Used to obtain a path file descriptor.
+    pub const O_PATH: u32 = bindings::O_PATH;
+
+    /// Write operations on this file will flush data and metadata.
+    pub const O_SYNC: u32 = bindings::O_SYNC;
+
+    /// This file is an unnamed temporary regular file.
+    pub const O_TMPFILE: u32 = bindings::O_TMPFILE;
+
+    /// File should be truncated to length 0.
+    pub const O_TRUNC: u32 = bindings::O_TRUNC;
+
+    /// Bitmask for access mode flags.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::file;
+    /// # fn do_something() {}
+    /// # let flags = 0;
+    /// if (flags & file::flags::O_ACCMODE) == file::flags::O_RDONLY {
+    ///     do_something();
+    /// }
+    /// ```
+    pub const O_ACCMODE: u32 = bindings::O_ACCMODE;
+
+    /// File is read only.
+    pub const O_RDONLY: u32 = bindings::O_RDONLY;
+
+    /// File is write only.
+    pub const O_WRONLY: u32 = bindings::O_WRONLY;
+
+    /// File can be both read and written.
+    pub const O_RDWR: u32 = bindings::O_RDWR;
+}
+
+/// Wraps the kernel's `struct file`.
+///
+/// # Invariants
+///
+/// Instances of this type are always ref-counted, that is, a call to `get_file` ensures that the
+/// allocation remains valid at least until the matching call to `fput`.
+#[repr(transparent)]
+pub struct File(Opaque<bindings::file>);
+
+// SAFETY: By design, the only way to access a `File` is via an immutable reference or an `ARef`.
+// This means that the only situation in which a `File` can be accessed mutably is when the
+// refcount drops to zero and the destructor runs. It is safe for that to happen on any thread, so
+// it is ok for this type to be `Send`.
+unsafe impl Send for File {}
+
+// SAFETY: It's OK to access `File` through shared references from other threads because we're
+// either accessing properties that don't change or that are properly synchronised by C code.
+unsafe impl Sync for File {}
+
+impl File {
+    /// Constructs a new `struct file` wrapper from a file descriptor.
+    ///
+    /// The file descriptor belongs to the current process.
+    pub fn from_fd(fd: u32) -> Result<ARef<Self>, BadFdError> {
+        // SAFETY: FFI call, there are no requirements on `fd`.
+        let ptr = ptr::NonNull::new(unsafe { bindings::fget(fd) }).ok_or(BadFdError)?;
+
+        // SAFETY: `fget` increments the refcount before returning.
+        Ok(unsafe { ARef::from_raw(ptr.cast()) })
+    }
+
+    /// Creates a reference to a [`File`] from a valid pointer.
+    ///
+    /// # Safety
+    ///
+    /// The caller must ensure that `ptr` points at a valid file and that its refcount does not
+    /// reach zero until after the end of the lifetime 'a.
+    pub unsafe fn from_ptr<'a>(ptr: *const bindings::file) -> &'a File {
+        // SAFETY: The safety requirements guarantee the validity of the dereference, while the
+        // `File` type being transparent makes the cast ok.
+        unsafe { &*ptr.cast() }
+    }
+
+    /// Returns the flags associated with the file.
+    ///
+    /// The flags are a combination of the constants in [`flags`].
+    pub fn flags(&self) -> u32 {
+        // SAFETY: The file is valid because the shared reference guarantees a nonzero refcount.
+        //
+        // This uses a volatile read because C code may be modifying this field in parallel using
+        // non-atomic unsynchronized writes. This corresponds to how the C macro READ_ONCE is
+        // implemented.
+        unsafe { core::ptr::addr_of!((*self.0.get()).f_flags).read_volatile() }
+    }
+}
+
+// SAFETY: The type invariants guarantee that `File` is always ref-counted.
+unsafe impl AlwaysRefCounted for File {
+    fn inc_ref(&self) {
+        // SAFETY: The existence of a shared reference means that the refcount is nonzero.
+        unsafe { bindings::get_file(self.0.get()) };
+    }
+
+    unsafe fn dec_ref(obj: ptr::NonNull<Self>) {
+        // SAFETY: The safety requirements guarantee that the refcount is nonzero.
+        unsafe { bindings::fput(obj.cast().as_ptr()) }
+    }
+}
+
+/// Represents the EBADF error code.
+///
+/// Used for methods that can only fail with EBADF.
+pub struct BadFdError;
+
+impl From<BadFdError> for Error {
+    fn from(_: BadFdError) -> Error {
+        EBADF
+    }
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 7f0d89b902ce..ea1411a25ee4 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -30,6 +30,7 @@
 pub mod block;
 mod build_assert;
 pub mod error;
+pub mod file;
 pub mod folio;
 pub mod fs;
 pub mod init;
-- 
2.34.1


