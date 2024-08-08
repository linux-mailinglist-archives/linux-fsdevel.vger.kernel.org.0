Return-Path: <linux-fsdevel+bounces-25438-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA7B294C275
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 18:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0915A1C22DC8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 16:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED2D21922D3;
	Thu,  8 Aug 2024 16:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="snX+Hw3U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E67C191F73
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Aug 2024 16:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723133805; cv=none; b=rXxi1CW4BwOaurbtbcSfUDOC3yuTp1UmDZMKb9/0zgz3rqF8f3pJO+se8tPNxC+uVsXjO6aMe36gEng8Vgxhc8qDIDfBSKS5WRHbp+3ATUhTm2W0TrrQtfcircG0SPLhrHVNtPVCOkSMUmFdTGSM7IFT2NH+sUeKquS4kY138cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723133805; c=relaxed/simple;
	bh=hCsKKVj345+b49Ng5A8TJ2plNvQ/FuOO1K1yN5EOnjc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eCFXnyBer9Lt5H4NbZivFmC2p9qzg2LpKaMTMWAc5iJIwjuhQKB2ejRQfyKrl2qgmbwi1h42t5aKDEE/qu2eMg5BkK5zGCO5xnuki2sGFEjc2KSqcZkOimFgdaJTtp6PubLbx2pNN9j5Z0kkEeOqdgOg2Fsgm5/SMlABzRyhWAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=snX+Hw3U; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-428e48612acso13925645e9.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Aug 2024 09:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723133802; x=1723738602; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FyvEzhf1vrLH4fAWxaYl8oZikM7jgsDn2qSzj+h3cIM=;
        b=snX+Hw3U4ZXc0XKqCI/dZbFDQrBGdKi9d/rSNk3+7Zmgc9egi+WoC11TCaL87AzWed
         avsVwJjzgoONVhO2qByOLqD60p1ripEKTBnx5BPW+1E8nJyx2cLJrEva3AdF2BMplnXv
         pJCZ/Ol8aP8X0bMMzderrp6s9d67BCE6lCGI6h6pm7B0B3qNPASgNiiFmMxFoG5UWAjP
         XPGN5ZNUGnCb9lq0nC2ZsDwwLonTEFCAiYPSpykXRaU/mpJEvjOK4yyRlXni5Bk9O5Ey
         bkIuC8Fwm7WSXD+Q6LPP3QkUM48yIHixaRJl1bsFw3uvcFl1QL4Y6gqCJc82rDKQ1LXq
         rI+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723133802; x=1723738602;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FyvEzhf1vrLH4fAWxaYl8oZikM7jgsDn2qSzj+h3cIM=;
        b=M2Q/2GnJYVeN8DYt6CJVLz6VgSDWw2SxHW0KxcQU81zL04JSZbGce6JfNRWYoKjs7x
         tckWrpHXYDQXD1fZW0COgzuRUw0r/mpAN51Sk8lsZ0C+rT2wsitviqyhXhy6osu0syHA
         BJxB1tUMZRpp3GpiONWt77F2fywsDoFmkLyehad051vv4DKKoPr4O43+3PDh75zeTS25
         0YYqjZVFYNUg7+psCtT2xuz29Ax021sNGL9AingSrZgSk9vuPFgZ2ISUBHQ+igeAiNfM
         jrkXmOYTkGYvtbAMJBT70IxxxD6YCqLDllf0JK3fdOoQlyVGW3mwNsyeX7zEjkgxOno6
         O7ig==
X-Forwarded-Encrypted: i=1; AJvYcCUudIYlv+eJodB07G63p0O+cMAFitsaZlgjMUzUICmtJa1XgoyJ3oASqRvphzcshSqeER05+bzc7n5js8JuEXgd0L5SvDC8EhZzhu7x7A==
X-Gm-Message-State: AOJu0Yx4CPVIF71gnXoh9xBcFYqTziznknv9hWGDKqooIUM+vqPzqOAu
	44BGVb4P85zeYkFN+xZ9gGOTjyMi42sHzUh3UFrT3tmZ5ZZVJcMA6B7eoW7RvTVryBzOOkkqIn5
	nRO8pmyzosVcI5w==
X-Google-Smtp-Source: AGHT+IHkmyDuHZogA2p1s2T21TqYXa394KS3rlas/ZBn1g6qzzI+I+OtFLK2oPA+Ii1xwIDwVrxn1wMIG8OJzMg=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:35bd])
 (user=aliceryhl job=sendgmr) by 2002:a05:600c:3b14:b0:425:671d:cef6 with SMTP
 id 5b1f17b1804b1-4290af3745cmr481345e9.4.1723133801757; Thu, 08 Aug 2024
 09:16:41 -0700 (PDT)
Date: Thu, 08 Aug 2024 16:15:48 +0000
In-Reply-To: <20240808-alice-file-v9-0-2cb7b934e0e1@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240808-alice-file-v9-0-2cb7b934e0e1@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=6528; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=hCsKKVj345+b49Ng5A8TJ2plNvQ/FuOO1K1yN5EOnjc=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmtO9YE0zx2d9qsqS/2QjFpfM7xBaU8ZUaC6QTc
 QnZTjRcoqWJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZrTvWAAKCRAEWL7uWMY5
 RkK5EACaHV1Ihz+jXjJgfTlljUVpOW845PnAaiF+8dB2Qzy1uJt8oILSS96rFf9ry/gmxIwrHiw
 SN2sGEu8i45LQxi8EKKoh+ZDFZh0kk3wZmV0ohJJZoU/MeZOb5su37mPwdxyjnX8a0h/uZehVQW
 h4rO+rpOGduW+6z69asSsirObCS1UFpcb+L3NSJl60jWBwuvjzbq8eg45rsusgQTK6KOBeGY5uT
 OPICAZFzVgrVqXuJw9kqfW8KbAjan6f998UhZwgmDzES1g1JMTivRBWE6UKPlrmgnH0Cg0HB5dY
 z9gkGTXZei0Il2a9opIsQCMrAAILCckGLtsvRY0U77YEeqlXeTJ/Rd+GQLWQwdYiYSSpj+nv54G
 zh1D7hDL6xVZdM2G/qYK4GU0zp3Evz8H9r8Y9xVf6pU238ekksef7nQhsidiT0ZrqBnnXIYwZ3K
 A4jzWhR8lAWBfN5Q9i3v/tU8Oyg7gcf0xLv6KXqPfYkHfiBMiBDC2Vtcic8Ln2txSmCLMvlSzz8
 uosqpaSqvZ3c2uGS55r08SIBPvtkr8oHtHOmEbQ4fafcEpY9vB+QLmmohui1YBWjfC4jj915UNT
 hewLHkTQiOQiSBL6DXSu92VjRb6V2c7EfrFvz5Q8v09w1ldxqNDHeQR+SE6w2aGi2AVsXCVIDX6 N9bGwPY7Kv+EJzw==
X-Mailer: b4 0.13.0
Message-ID: <20240808-alice-file-v9-5-2cb7b934e0e1@google.com>
Subject: [PATCH v9 5/8] rust: security: add abstraction for secctx
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Peter Zijlstra <peterz@infradead.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>
Cc: Dan Williams <dan.j.williams@intel.com>, Matthew Wilcox <willy@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>, 
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>, Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="utf-8"

Add an abstraction for viewing the string representation of a security
context.

This is needed by Rust Binder because it has a feature where a process
can view the string representation of the security context for incoming
transactions. The process can use that to authenticate incoming
transactions, and since the feature is provided by the kernel, the
process can trust that the security context is legitimate.

Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Reviewed-by: Trevor Gross <tmgross@umich.edu>
Reviewed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/bindings/bindings_helper.h |  1 +
 rust/helpers.c                  | 21 ++++++++++++
 rust/kernel/cred.rs             |  8 +++++
 rust/kernel/lib.rs              |  1 +
 rust/kernel/security.rs         | 74 +++++++++++++++++++++++++++++++++++++++++
 5 files changed, 105 insertions(+)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 81bd1c2db7c9..7db502f5ff5e 100644
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
diff --git a/rust/helpers.c b/rust/helpers.c
index a63f6b614725..33d12d45e4f6 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -33,6 +33,7 @@
 #include <linux/mutex.h>
 #include <linux/refcount.h>
 #include <linux/sched/signal.h>
+#include <linux/security.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/wait.h>
@@ -220,6 +221,26 @@ void rust_helper_put_cred(const struct cred *cred)
 }
 EXPORT_SYMBOL_GPL(rust_helper_put_cred);
 
+#ifndef CONFIG_SECURITY
+void rust_helper_security_cred_getsecid(const struct cred *c, u32 *secid)
+{
+	security_cred_getsecid(c, secid);
+}
+EXPORT_SYMBOL_GPL(rust_helper_security_cred_getsecid);
+
+int rust_helper_security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen)
+{
+	return security_secid_to_secctx(secid, secdata, seclen);
+}
+EXPORT_SYMBOL_GPL(rust_helper_security_secid_to_secctx);
+
+void rust_helper_security_release_secctx(char *secdata, u32 seclen)
+{
+	security_release_secctx(secdata, seclen);
+}
+EXPORT_SYMBOL_GPL(rust_helper_security_release_secctx);
+#endif
+
 /*
  * `bindgen` binds the C `size_t` type as the Rust `usize` type, so we can
  * use it in contexts where Rust expects a `usize` like slice (array) indices.
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
index c9ce44812d21..86fc957f61eb 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -45,6 +45,7 @@
 pub mod page;
 pub mod prelude;
 pub mod print;
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
2.46.0.rc2.264.g509ed76dc8-goog


