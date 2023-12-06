Return-Path: <linux-fsdevel+bounces-4993-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB67806FF8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 13:39:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89B3E1F21348
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 12:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32AC36AE8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 12:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MC5uVyIO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-x249.google.com (mail-lj1-x249.google.com [IPv6:2a00:1450:4864:20::249])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 612A1D40
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Dec 2023 04:00:11 -0800 (PST)
Received: by mail-lj1-x249.google.com with SMTP id 38308e7fff4ca-2c9ef4b6ce4so38406761fa.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Dec 2023 04:00:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701864009; x=1702468809; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5tmt2N0VwVmdbKWnzafXFaHLq0Qhxrru0xsHWYV+xBQ=;
        b=MC5uVyIOsMTon7BV7fc3jPhv1C3u2n7EeXmEByS6idGaBlJRRfk41qZQqUeDos6Es2
         jWWjJ9AwNYekJrBUniPm9MdiyfE7SIMzSDW2ZpYczyV3t9yXj198wdyAid75yf1HPZab
         lh/FMQ4gB5UcgeyTcmEAcFo0YqYYRov8W1yENr7ofWRLFIUEk0IcqFuEMxQaKkRmi92n
         yOed4qz4G/eAHrjtoUjFXQAoVzru2XopYwNjqUHjcodzCehFbPvfXHOtu1Hj+XoAHu1a
         +Cza7F2atj7oZeG75s3QrXkhGaWIsM7VD98SD0d4T1RqG8Un70PoznLTMmHHFLJzT06p
         NCLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701864009; x=1702468809;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5tmt2N0VwVmdbKWnzafXFaHLq0Qhxrru0xsHWYV+xBQ=;
        b=Yh9QIBsISXfUkXNSRs80wY9GVFxhAoHNgz/HUfPIizdGTf+YX6krC5C9DSnCoEA/S1
         5p+I0RNqQ0P0qmy2/EB99XxTBjrcrEz/kiyF6l69Yl6D7H+ADNB5qWxcILPOg5wm58Xm
         DbmFMbxJd/UvVcfMCgL4aktas0xeZVP7aNNIJ7edvE+j29sl8l1wEd9+v/ZJ7QY42b1R
         5y/eoReN5ruSeEiVa+FWm7wvcW4aaALcWhWfcMLXI8XqTgHRCRI2tMIflaujoPm0nXrF
         Lbw81TotejceVR+dLi0xO+TRq/x3ZoDgWfL2wPpSaVsOrUzOhylQaom55WU/6qmO1+h3
         9RjA==
X-Gm-Message-State: AOJu0YzsDqlWIrFCGyJRruIPP3PiO7W3M3+SjEcYxPmXz1s9HRp7W4/F
	c/b7pHwHEL8g6SeOQvxo/sTZqWpFRhYRNio=
X-Google-Smtp-Source: AGHT+IF1Lt3w7IGohb8BJXAbz6Df6e6l5YguB/57GMGafOpE3DiFazVzW06PvsO5/HhTDTey8czloJ5EVATtO7U=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:651c:198f:b0:2c9:c560:b33d with SMTP
 id bx15-20020a05651c198f00b002c9c560b33dmr12324ljb.0.1701864009526; Wed, 06
 Dec 2023 04:00:09 -0800 (PST)
Date: Wed, 06 Dec 2023 11:59:48 +0000
In-Reply-To: <20231206-alice-file-v2-0-af617c0d9d94@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231206-alice-file-v2-0-af617c0d9d94@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=6345; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=i9YFQd6/Yd51tifYQVq47mzEm0F+9nhoDryKROmvL1c=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBlcGI6vioB5c9v/JO7VFZ39pDeZbR+KMKypQ7I1
 emAZrbqhQiJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZXBiOgAKCRAEWL7uWMY5
 RgggEACMdH82FbZQh1iUxaANeGdNilF9X4MKsgLxfGa7spb/o/Px65ohICqwdeemQj61Mo2sVs2
 IX95wn/ys9kkcUShXWSoyjjlbi0WGtW2jbQ1AxC8xbV5ciwLzwUhDhN0+ORORCCBxGZBIIbK8zQ
 kFUt6lWfrAaj46D/xRqQruRfuTp/wowe6cBgAvYhu0xG3bm8EvzIo1BV4M2ooF27LZbzsMzaCFr
 47z1VwvZerHWae1ggPe9Wdh7GBo8WZvlR6TeMOaptT0AorZVv5x7/j4S2DSSlbW03jhkinNb23G
 Z6kiwmw76NUxp7kRPivvY03Du1C8G/9xRLWP8K+wW0JfQAzFNrkgQ6Tr0QO7sm6ee9Fa12uk5RH
 uFj6KxdpsqUy4Ar3Kt/G9zs6TcOFQcTgHIZ5Ctoz15jK/CiaS5Syj6CLu5o8kQqQIfKUkEPO1if
 6E5Qixzjoef86aeXPLhkY3OpLq+HfMByIw9BaV8BiG7atl9nDcwxMNOw2tQoA0DK1WGGBjDiOAL
 ksO5iw3YvQJo8I315E/tQNivQERvKozjnm/9gD2bPZrivSqhNetO0sn6+/nUf6COGBfK8w56mT0
 ugLregUoJn3eTjhiwi3cDK0VcRwIWqboCSeCeiVEq1OcbdfWDUpezSU9zVHwjDl5CUSj/0GZl5q mVgi+X+HPz+9vrg==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20231206-alice-file-v2-3-af617c0d9d94@google.com>
Subject: [PATCH v2 3/7] rust: security: add abstraction for secctx
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
Cc: Dan Williams <dan.j.williams@intel.com>, Kees Cook <keescook@chromium.org>, 
	Matthew Wilcox <willy@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

Adds an abstraction for viewing the string representation of a security
context.

This is needed by Rust Binder because it has feature where a process can
view the string representation of the security context for incoming
transactions. The process can use that to authenticate incoming
transactions, and since the feature is provided by the kernel, the
process can trust that the security context is legitimate.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/bindings/bindings_helper.h |  1 +
 rust/helpers.c                  | 21 +++++++++++
 rust/kernel/cred.rs             |  8 +++++
 rust/kernel/lib.rs              |  1 +
 rust/kernel/security.rs         | 79 +++++++++++++++++++++++++++++++++++++++++
 5 files changed, 110 insertions(+)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 6d1bd2229aab..81b13a953eae 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -11,6 +11,7 @@
 #include <linux/errname.h>
 #include <linux/file.h>
 #include <linux/fs.h>
+#include <linux/security.h>
 #include <linux/slab.h>
 #include <linux/refcount.h>
 #include <linux/wait.h>
diff --git a/rust/helpers.c b/rust/helpers.c
index 10ed69f76424..fd633d9db79a 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -30,6 +30,7 @@
 #include <linux/mutex.h>
 #include <linux/refcount.h>
 #include <linux/sched/signal.h>
+#include <linux/security.h>
 #include <linux/spinlock.h>
 #include <linux/wait.h>
 #include <linux/workqueue.h>
@@ -177,6 +178,26 @@ void rust_helper_put_cred(const struct cred *cred)
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
index 497058ec89bb..3794937b5294 100644
--- a/rust/kernel/cred.rs
+++ b/rust/kernel/cred.rs
@@ -43,6 +43,14 @@ pub unsafe fn from_ptr<'a>(ptr: *const bindings::cred) -> &'a Credential {
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
         // SAFETY: By the type invariant, we know that `self.0` is valid.
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 097fe9bb93ed..342cb02c495a 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -42,6 +42,7 @@
 pub mod kunit;
 pub mod prelude;
 pub mod print;
+pub mod security;
 mod static_assert;
 #[doc(hidden)]
 pub mod std_vendor;
diff --git a/rust/kernel/security.rs b/rust/kernel/security.rs
new file mode 100644
index 000000000000..6545bfa2fd72
--- /dev/null
+++ b/rust/kernel/security.rs
@@ -0,0 +1,79 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Linux Security Modules (LSM).
+//!
+//! C header: [`include/linux/security.h`](../../../../include/linux/security.h).
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
+        unsafe {
+            to_result(bindings::security_secid_to_secctx(
+                secid,
+                &mut secdata,
+                &mut seclen,
+            ))?;
+        }
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
+            // We can't pass a null pointer to `slice::from_raw_parts` even if the length is zero.
+            debug_assert_eq!(self.seclen, 0);
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
+        // SAFETY: This frees a pointer that came from a successful call to
+        // `security_secid_to_secctx` and has not yet been destroyed by `security_release_secctx`.
+        unsafe {
+            bindings::security_release_secctx(self.secdata, self.seclen as u32);
+        }
+    }
+}

-- 
2.43.0.rc2.451.g8631bc7472-goog


