Return-Path: <linux-fsdevel+bounces-19613-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 080758C7CE7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2024 21:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87147285D7F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2024 19:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3274515D5A9;
	Thu, 16 May 2024 19:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="h9BKPGpa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from aer-iport-1.cisco.com (aer-iport-1.cisco.com [173.38.203.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DA415AAD3;
	Thu, 16 May 2024 19:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.38.203.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715886319; cv=none; b=u0CYdtd/Eh+fmWAJSjsU4ifN4Kuem0vBljcVkTtDhVBe832mhx0Yw9cqpzusALRPXZ2rmnlZ5rF0OZm2A+7lli5Shti+naUnFQTEapYY6HB7L3eq1gi80pobJ+G9teghYy6/BSis5PE5SQ9Tr9ebzvxu6sau5as9ZT0CcoJspTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715886319; c=relaxed/simple;
	bh=ENTYd1tmMLCd25GHq6+1pJgglWWixUwPgOOq0MHQ8MQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jpguLVhl0Kz9qusCP5guEGoRrL6iG+sXBATUnhmKZXaNdB245QIZ0ELfAkG+rIuoYiK+3itczlnR6/MdESXnikvtdaByCjEEPeb6kD12Cx7gU/hX+a4stltjpYDN2jScv7RW9w1N4942frbvfraQnc2uz2PoJ9rntrHfNTLKJIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=h9BKPGpa; arc=none smtp.client-ip=173.38.203.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=3812; q=dns/txt; s=iport;
  t=1715886317; x=1717095917;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9Pz3QTH8A7TfsLwBUIF2u4gRQxFMrjIamD+SRvopNdE=;
  b=h9BKPGpacEprKxEP1bC+QsWTCVS68J7XeB/IKLKvHQ7L+64Mj4PyvtxM
   PmdMD5n4lkMPAIFFUskcxntZEMFenSiQcZ90PIAtd/wP7BihRvkWEn1od
   iaoF0BQJaGxytKC01Yxjbpa7P6Gn5Dz23C2h397jl7QxshdmW5xWHdd11
   k=;
X-CSE-ConnectionGUID: xfZILYdcSgOitZwphdK/BQ==
X-CSE-MsgGUID: DkDGam0+R/Cnyrr97QGkBg==
X-IronPort-AV: E=Sophos;i="6.08,165,1712620800"; 
   d="scan'208";a="12419635"
Received: from aer-iport-nat.cisco.com (HELO aer-core-3.cisco.com) ([173.38.203.22])
  by aer-iport-1.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 19:04:13 +0000
Received: from localhost (ams3-vpn-dhcp4879.cisco.com [10.61.83.14])
	(authenticated bits=0)
	by aer-core-3.cisco.com (8.15.2/8.15.2) with ESMTPSA id 44GJ4DkX017896
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 16 May 2024 19:04:13 GMT
From: Ariel Miculas <amiculas@cisco.com>
To: rust-for-linux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tycho@tycho.pizza, brauner@kernel.org, viro@zeniv.linux.org.uk,
        ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
        shallyn@cisco.com, Ariel Miculas <amiculas@cisco.com>
Subject: [RFC PATCH v3 10/22] rust: kernel: add an abstraction over vfsmount to allow cloning a new private mount
Date: Thu, 16 May 2024 22:03:33 +0300
Message-Id: <20240516190345.957477-11-amiculas@cisco.com>
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
X-Outbound-Node: aer-core-3.cisco.com

Provide an abstraction over vfsmount so that we can create a new private
mount from Rust code.

PuzzleFS needs a private mount of the PuzzleFS image, so it can access
the chunks from the data store independent of the future changes to the
mount namespace.

Signed-off-by: Ariel Miculas <amiculas@cisco.com>
---
 rust/bindings/bindings_helper.h |  1 +
 rust/kernel/lib.rs              |  1 +
 rust/kernel/mount.rs            | 73 +++++++++++++++++++++++++++++++++
 3 files changed, 75 insertions(+)
 create mode 100644 rust/kernel/mount.rs

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 629fce394dbe..2d87bb9f87c9 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -16,6 +16,7 @@
 #include <linux/iomap.h>
 #include <linux/jiffies.h>
 #include <linux/mdio.h>
+#include <linux/namei.h>
 #include <linux/pagemap.h>
 #include <linux/phy.h>
 #include <linux/refcount.h>
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 445599d4bff6..7f0d89b902ce 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -37,6 +37,7 @@
 #[cfg(CONFIG_KUNIT)]
 pub mod kunit;
 pub mod mem_cache;
+pub mod mount;
 #[cfg(CONFIG_NET)]
 pub mod net;
 pub mod prelude;
diff --git a/rust/kernel/mount.rs b/rust/kernel/mount.rs
new file mode 100644
index 000000000000..50cfe7f7437a
--- /dev/null
+++ b/rust/kernel/mount.rs
@@ -0,0 +1,73 @@
+//! Mount interface
+//!
+//! C headers: [`include/linux/mount.h`](../../../../include/linux/mount.h)
+
+use kernel::bindings;
+use kernel::error::from_err_ptr;
+use kernel::pr_err;
+use kernel::prelude::*;
+use kernel::str::CStr;
+use kernel::types::Opaque;
+
+/// Wraps the kernel's `struct path`.
+#[repr(transparent)]
+pub struct Path(pub(crate) Opaque<bindings::path>);
+
+/// Wraps the kernel's `struct vfsmount`.
+#[repr(transparent)]
+#[derive(Debug)]
+pub struct Vfsmount {
+    vfsmount: *mut bindings::vfsmount,
+}
+
+// SAFETY: No one besides us has the raw pointer, so we can safely transfer Vfsmount to another thread
+unsafe impl Send for Vfsmount {}
+// SAFETY: It's OK to access `Vfsmount` through references from other threads because we're not
+// accessing any properties from the underlying raw pointer
+unsafe impl Sync for Vfsmount {}
+
+impl Vfsmount {
+    /// Create a new private mount clone based on a path name
+    pub fn new_private_mount(path_name: &CStr) -> Result<Self> {
+        let path: Path = Path(Opaque::uninit());
+        // SAFETY: path_name is a &CStr, so it's a valid string pointer; path is an uninitialized
+        // struct stored on the stack and it's ok because kern_path expects an out parameter
+        let err = unsafe {
+            bindings::kern_path(
+                path_name.as_ptr().cast::<i8>(),
+                bindings::LOOKUP_FOLLOW | bindings::LOOKUP_DIRECTORY,
+                path.0.get(),
+            )
+        };
+        if err != 0 {
+            pr_err!("failed to resolve '{}': {}\n", path_name, err);
+            return Err(EINVAL);
+        }
+
+        // SAFETY: path is a struct stored on the stack and it is  initialized because the call to
+        // kern_path succeeded
+        let vfsmount = unsafe { from_err_ptr(bindings::clone_private_mount(path.0.get()))? };
+
+        // Don't inherit atime flags
+        // CAST: these flags fit into i32
+        let skip_flags =
+            !(bindings::MNT_NOATIME | bindings::MNT_NODIRATIME | bindings::MNT_RELATIME) as i32;
+        // SAFETY: we called from_err_ptr so it's safe to dereference this pointer
+        unsafe {
+            (*vfsmount).mnt_flags &= skip_flags;
+        }
+        Ok(Self { vfsmount })
+    }
+
+    /// Returns a raw pointer to vfsmount
+    pub fn get(&self) -> *mut bindings::vfsmount {
+        self.vfsmount
+    }
+}
+
+impl Drop for Vfsmount {
+    fn drop(&mut self) {
+        // SAFETY new_private_mount makes sure to return a valid pointer
+        unsafe { bindings::kern_unmount(self.vfsmount) };
+    }
+}
-- 
2.34.1


