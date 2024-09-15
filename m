Return-Path: <linux-fsdevel+bounces-29406-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1ECD979730
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Sep 2024 16:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D73311C20C24
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Sep 2024 14:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B8D81C9DEB;
	Sun, 15 Sep 2024 14:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lVko/vTO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA30D1C9DC4
	for <linux-fsdevel@vger.kernel.org>; Sun, 15 Sep 2024 14:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726410711; cv=none; b=kgVH3vPXobem3iprWdEfpWKAa9Lq8QMr9FJ3jG3FZ06o8kqg8mjxL3p73LQRa+KjzVvErKWVH/keWkIzvfop4oWpVO0pVg4eIXkMaj7s1zjHwcJkBzHIl58IZu6nek0bre+7Hjgn5h23uN7q7ImF1FhlsxEi7xLIdJEkmX1qlVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726410711; c=relaxed/simple;
	bh=rHxNMcsU4/HAgPUoaNjU7HprCPhh4gGEl0p1HneMhTE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZND0DMvCMS9dHf7t+GmL9jADvhc+wdTOBr9nZq9lpF492l+GhwyXB8tqVZXrvSQ/Np8+2xziVxI/qdXocvzzqz4vxFUn+6eYXD7twAbKg2iLcoS3ccuuymU/Vu71qhY969kuj6IQBQnelaKRfo7X94RQJIywG5Pg5X4Bx7vnlFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lVko/vTO; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-42cb808e9fcso14470135e9.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 15 Sep 2024 07:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726410708; x=1727015508; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hhf+2TxlXGKWlx/uqFvTXCf9ALpmQAS6969H51nCFa0=;
        b=lVko/vTO5IM+Qg0qWwNdsl9gZAMY0JX3h0Bhn39CsC6UQvsVtrp3CfwL1aBMBTbJDT
         PII0oxzjSzOpbk1ri2n84+BqLZdMrlyUp9+UETEUc3Y5RsV1xUFa4Vz89rBi4dh9txsu
         YX/XZftpinbentQ+ZjfoYEUVj/uXBi6oAAa51MpjUyRcuce3LIk7wwZYIf9A4h+XPqnj
         FyLFqYDHvifXXJOgQ0VBVxgxirPmkawhIfsKiI+mXewZW10WWTI4uyJr4SUMko7zMyHu
         jQNB8e+9vki26NHk0FfxN5BYYDKH4x5a3l+VHqjPlor0jscQVHuJjuTsyUjhGXf8GeiE
         gtig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726410708; x=1727015508;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hhf+2TxlXGKWlx/uqFvTXCf9ALpmQAS6969H51nCFa0=;
        b=HyKM9AVknA1OGbdT1jhWRqsActRQTnU+6H02pJXro6zblqeChfQbzRC09JyKXKkVEG
         Y6zaTEPuXuO3EBCfAR19PAPzoFZ+XIaEoS0AThEtAIsGdDLs5kMzpp6O5RxxtAqr6yC2
         OtKWLNWIJdwVEu2+ugAsBWBK+XHSN0bgV2efLlS3coTflqZQdIMBkUm6yMb8BP2hCd6y
         YQ19CY8mQsNM3H/nn0BcahHvZaIsevHzjsnM4qed80c9gycp6AAlRLUiHfUrUxi+LKvL
         /OExOt4hDKMzHMynYiTH0vCxriUXBb2IhgPC9gtagbQHCB/v9VwSuBQbJqappPUx6Q0J
         rvkg==
X-Forwarded-Encrypted: i=1; AJvYcCVIv4Xwc+Qk5kwHRLqMT0Q3qDcyupQRasMWQC9Q/M5JtuY3dtpt2GiKQnS3mErjn/qbmiABSXiSyhkl1CEJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxHU0Y4fTzeV+HHdpRAbQusBebsG2+K7Zn7XM/G//YryAs999c/
	TwoDeon/OD3DIZAWG5+MDUG+Fqh/InQcX5ef4vYa9uAtlppbbNyacK1sOECLkVqu1roZO99IU2P
	EvFXxnnTMmoOGaQ==
X-Google-Smtp-Source: AGHT+IEEd+a5D7B4kWGO4ZEoSBmt2tdUYh9kzQbla3X4XTKV4G6VeBfff1fcQYJOg7XO/a6pKFoBeXnQixg5njg=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:35bd])
 (user=aliceryhl job=sendgmr) by 2002:a05:600c:4f89:b0:42c:a544:d10d with SMTP
 id 5b1f17b1804b1-42d964d91cemr143005e9.4.1726410708073; Sun, 15 Sep 2024
 07:31:48 -0700 (PDT)
Date: Sun, 15 Sep 2024 14:31:31 +0000
In-Reply-To: <20240915-alice-file-v10-0-88484f7a3dcf@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240915-alice-file-v10-0-88484f7a3dcf@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=6847; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=rHxNMcsU4/HAgPUoaNjU7HprCPhh4gGEl0p1HneMhTE=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBm5u/DDifR+ZXp/NjMDkFE8guCsChdl8NVHEyHR
 8b0kanxH+SJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZubvwwAKCRAEWL7uWMY5
 RmvwD/9O24XGdeoUeyyw0adR3X7srKi4qPSVniWVyGWtJzsz48wjAd6ZNqL6slvhUNNxhARj9nX
 Hhx06Uou+IPRM+vjHcBUPOpUC0KpDYJ6gy288lNylmUbCbGRYcgkap6zO47h7N+acd5ZdcUFDNS
 7zfA8xJHLIRKgRLAceAVWuJ/EgnFPYTzPyZfXIqTUlKnHvrSzmXF9tZ3/qXmSKsJtaDEku3Hk3f
 5xGh3SiByYAMrK/X8qZbqfBwXbRtoxYiIkRLu3w5kAngNtdlJ7wynJICCb4pxA3f5iw+2Cgbjl1
 CWJKIpL9aNIxTDxYlSbKyMlWZgBVR/eJRP1iytVHyVDVyH7fxx6Id8wbTke+1JMXkcya0am97xk
 hw3/+hjIFQBeiy42o8Gyr/hM19SBW3iPSV+KFm9Cpv7lxk2kJ08a9BlC3cOdTzpm3avral4fVHD
 eF9/ZTPnYKJ2rkMfECpCepxiXFSPD604MbGKYaPXSc+4DO5sBFqjtj/NKanGRJu/3C4lDMnNiZ6
 X9lHLTNZTMWdG/w0p71fi1O8aLnqvf/TFnqWzFqzD36sJOQ+jNdoU0iEw0uuGrvCP5pJlJUQewu
 Fgz+n6AUMQrzEhF8ccwyq8TWB/zfbNiUvu8NFt+NOQ9W9QShio60o4EyE/WvijfYnIRHv+4MDIJ sP+awf7h8FXj3uQ==
X-Mailer: b4 0.13.0
Message-ID: <20240915-alice-file-v10-5-88484f7a3dcf@google.com>
Subject: [PATCH v10 5/8] rust: security: add abstraction for secctx
From: Alice Ryhl <aliceryhl@google.com>
To: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Christian Brauner <brauner@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Peter Zijlstra <peterz@infradead.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Dan Williams <dan.j.williams@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>, 
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>, Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>, 
	Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="utf-8"

Add an abstraction for viewing the string representation of a security
context.

This is needed by Rust Binder because it has a feature where a process
can view the string representation of the security context for incoming
transactions. The process can use that to authenticate incoming
transactions, and since the feature is provided by the kernel, the
process can trust that the security context is legitimate.

This abstraction makes the following assumptions about the C side:
* When a call to `security_secid_to_secctx` is successful, it returns a
  pointer and length. The pointer references a byte string and is valid
  for reading for that many bytes.
* The string may be referenced until `security_release_secctx` is
  called.
* If CONFIG_SECURITY is set, then the three methods mentioned in
  rust/helpers are available without a helper. (That is, they are not a
  #define or `static inline`.)

Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Reviewed-by: Trevor Gross <tmgross@umich.edu>
Reviewed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/bindings/bindings_helper.h |  1 +
 rust/helpers/helpers.c          |  1 +
 rust/helpers/security.c         | 20 +++++++++++
 rust/kernel/cred.rs             |  8 +++++
 rust/kernel/lib.rs              |  1 +
 rust/kernel/security.rs         | 74 +++++++++++++++++++++++++++++++++++++++++
 6 files changed, 105 insertions(+)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index f74247205cb5..51ec78c355c0 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -21,6 +21,7 @@
 #include <linux/phy.h>
 #include <linux/refcount.h>
 #include <linux/sched.h>
+#include <linux/security.h>
 #include <linux/slab.h>
 #include <linux/wait.h>
 #include <linux/workqueue.h>
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 16e5de352dab..62022b18caf5 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -19,6 +19,7 @@
 #include "page.c"
 #include "rbtree.c"
 #include "refcount.c"
+#include "security.c"
 #include "signal.c"
 #include "slab.c"
 #include "spinlock.c"
diff --git a/rust/helpers/security.c b/rust/helpers/security.c
new file mode 100644
index 000000000000..239e5b4745fe
--- /dev/null
+++ b/rust/helpers/security.c
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/security.h>
+
+#ifndef CONFIG_SECURITY
+void rust_helper_security_cred_getsecid(const struct cred *c, u32 *secid)
+{
+	security_cred_getsecid(c, secid);
+}
+
+int rust_helper_security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
+{
+	return security_secid_to_secctx(secid, secdata, seclen);
+}
+
+void rust_helper_security_release_secctx(char *secdata, u32 seclen)
+{
+	security_release_secctx(secdata, seclen);
+}
+#endif
diff --git a/rust/kernel/cred.rs b/rust/kernel/cred.rs
index acee04768927..92659649e932 100644
--- a/rust/kernel/cred.rs
+++ b/rust/kernel/cred.rs
@@ -52,6 +52,14 @@ pub unsafe fn from_ptr<'a>(ptr: *const bindings::cred) -> &'a Credential {
         unsafe { &*ptr.cast() }
     }
 
+    /// Get the id for this security context.
+    pub fn get_secid(&self) -> u32 {
+        let mut secid = 0;
+        // SAFETY: The invariants of this type ensures that the pointer is valid.
+        unsafe { bindings::security_cred_getsecid(self.0.get(), &mut secid) };
+        secid
+    }
+
     /// Returns the effective UID of the given credential.
     pub fn euid(&self) -> bindings::kuid_t {
         // SAFETY: By the type invariant, we know that `self.0` is valid. Furthermore, the `euid`
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index c537d17c6db9..e088c94a5a14 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -47,6 +47,7 @@
 pub mod prelude;
 pub mod print;
 pub mod rbtree;
+pub mod security;
 mod static_assert;
 #[doc(hidden)]
 pub mod std_vendor;
diff --git a/rust/kernel/security.rs b/rust/kernel/security.rs
new file mode 100644
index 000000000000..2522868862a1
--- /dev/null
+++ b/rust/kernel/security.rs
@@ -0,0 +1,74 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Copyright (C) 2024 Google LLC.
+
+//! Linux Security Modules (LSM).
+//!
+//! C header: [`include/linux/security.h`](srctree/include/linux/security.h).
+
+use crate::{
+    bindings,
+    error::{to_result, Result},
+};
+
+/// A security context string.
+///
+/// # Invariants
+///
+/// The `secdata` and `seclen` fields correspond to a valid security context as returned by a
+/// successful call to `security_secid_to_secctx`, that has not yet been destroyed by calling
+/// `security_release_secctx`.
+pub struct SecurityCtx {
+    secdata: *mut core::ffi::c_char,
+    seclen: usize,
+}
+
+impl SecurityCtx {
+    /// Get the security context given its id.
+    pub fn from_secid(secid: u32) -> Result<Self> {
+        let mut secdata = core::ptr::null_mut();
+        let mut seclen = 0u32;
+        // SAFETY: Just a C FFI call. The pointers are valid for writes.
+        to_result(unsafe { bindings::security_secid_to_secctx(secid, &mut secdata, &mut seclen) })?;
+
+        // INVARIANT: If the above call did not fail, then we have a valid security context.
+        Ok(Self {
+            secdata,
+            seclen: seclen as usize,
+        })
+    }
+
+    /// Returns whether the security context is empty.
+    pub fn is_empty(&self) -> bool {
+        self.seclen == 0
+    }
+
+    /// Returns the length of this security context.
+    pub fn len(&self) -> usize {
+        self.seclen
+    }
+
+    /// Returns the bytes for this security context.
+    pub fn as_bytes(&self) -> &[u8] {
+        let ptr = self.secdata;
+        if ptr.is_null() {
+            debug_assert_eq!(self.seclen, 0);
+            // We can't pass a null pointer to `slice::from_raw_parts` even if the length is zero.
+            return &[];
+        }
+
+        // SAFETY: The call to `security_secid_to_secctx` guarantees that the pointer is valid for
+        // `seclen` bytes. Furthermore, if the length is zero, then we have ensured that the
+        // pointer is not null.
+        unsafe { core::slice::from_raw_parts(ptr.cast(), self.seclen) }
+    }
+}
+
+impl Drop for SecurityCtx {
+    fn drop(&mut self) {
+        // SAFETY: By the invariant of `Self`, this frees a pointer that came from a successful
+        // call to `security_secid_to_secctx` and has not yet been destroyed by
+        // `security_release_secctx`.
+        unsafe { bindings::security_release_secctx(self.secdata, self.seclen as u32) };
+    }
+}

-- 
2.46.0.662.g92d0881bb0-goog


