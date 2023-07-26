Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB017763CE6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jul 2023 18:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbjGZQsK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 12:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231172AbjGZQrq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 12:47:46 -0400
Received: from aer-iport-1.cisco.com (aer-iport-1.cisco.com [173.38.203.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C9D2721
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 09:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=3780; q=dns/txt; s=iport;
  t=1690390037; x=1691599637;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oseE7dVa4mchfbI4MxCXhpXz3QIa6pI8ihSwsEe0lxw=;
  b=c1w61NdN6uS5MvvQ8fuARJ5FYk1DVc8uldv4MbIMTDXXsldufY90gmTx
   rShY56YGD7nSfraqNSiys6fNtV9uPqHaIaLmuhkJXHuUsd3sNqVhDETDG
   py8tXlOAilIN8VtbsuN4um/JcDxRXRM+9gPjNNe0OwMuaIt6b3Gfy1gPu
   g=;
X-IronPort-AV: E=Sophos;i="6.01,232,1684800000"; 
   d="scan'208";a="8452801"
Received: from aer-iport-nat.cisco.com (HELO aer-core-7.cisco.com) ([173.38.203.22])
  by aer-iport-1.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 16:46:12 +0000
Received: from archlinux-cisco.cisco.com (dhcp-10-61-98-211.cisco.com [10.61.98.211])
        (authenticated bits=0)
        by aer-core-7.cisco.com (8.15.2/8.15.2) with ESMTPSA id 36QGjqTt022602
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 26 Jul 2023 16:46:12 GMT
From:   Ariel Miculas <amiculas@cisco.com>
To:     rust-for-linux@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tycho@tycho.pizza, brauner@kernel.org, viro@zeniv.linux.org.uk,
        ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
        Ariel Miculas <amiculas@cisco.com>
Subject: [RFC PATCH v2 03/10] rust: kernel: add an abstraction over vfsmount to allow cloning a new private mount
Date:   Wed, 26 Jul 2023 19:45:27 +0300
Message-ID: <20230726164535.230515-4-amiculas@cisco.com>
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
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Ariel Miculas <amiculas@cisco.com>
---
 rust/bindings/bindings_helper.h |  1 +
 rust/kernel/lib.rs              |  1 +
 rust/kernel/mount.rs            | 71 +++++++++++++++++++++++++++++++++
 3 files changed, 73 insertions(+)
 create mode 100644 rust/kernel/mount.rs

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index e5fc3b1d408d..205ef50dfd4c 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -18,6 +18,7 @@
 #include <linux/uio.h>
 #include <linux/uaccess.h>
 #include <linux/delay.h>
+#include <linux/namei.h>
 
 /* `bindgen` gets confused at certain things. */
 const gfp_t BINDINGS_GFP_KERNEL = GFP_KERNEL;
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 08f67833afcf..7dc07bdb5d55 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -46,6 +46,7 @@
 pub mod ioctl;
 pub mod iov_iter;
 pub mod mm;
+pub mod mount;
 pub mod pages;
 pub mod prelude;
 pub mod print;
diff --git a/rust/kernel/mount.rs b/rust/kernel/mount.rs
new file mode 100644
index 000000000000..d08830b27571
--- /dev/null
+++ b/rust/kernel/mount.rs
@@ -0,0 +1,71 @@
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
+                path_name.as_ptr() as *const i8,
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
+        // SAFETY: we called from_err_ptr so it's safe to dereference this pointer
+        unsafe {
+            (*vfsmount).mnt_flags &=
+                !(bindings::MNT_NOATIME | bindings::MNT_NODIRATIME | bindings::MNT_RELATIME) as i32;
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
2.41.0

