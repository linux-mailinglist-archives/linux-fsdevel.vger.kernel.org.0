Return-Path: <linux-fsdevel+bounces-29405-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C0F97972D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Sep 2024 16:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C3B9282494
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Sep 2024 14:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 973C81C9DC9;
	Sun, 15 Sep 2024 14:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C+VZ7ANl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2311C986D
	for <linux-fsdevel@vger.kernel.org>; Sun, 15 Sep 2024 14:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726410710; cv=none; b=UCDZL/sDicUMcakIUyCZtKDWfWqYswBzvmlRAH7G88lWedj9xdcDY/XVrn1GIm7zlq2NvxIOrsm00XCEp2DHZXIr8cagPWcF3D3zgnF3ZrC6Y5lttweFm9iL6drdy1SrW+lOYhzUyEnVgZeRpgDe0X1dbD9AO9zwXSPppWBB0nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726410710; c=relaxed/simple;
	bh=Wrg7hsJegJvAyHLxYLzqbt9d5c1eLvrv9c08VK8i6gI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GtVFSapSeHLhELtAPNj2f9EYEZwv7PZUvC3huoWKrUA3dap+RHrIxeakGBEyDR9N8XYYWY4EprGzS1kBd5r2KhS4SVvHxss8eIRnkH8r8Yd54QnXGn8CHjbCu0Mz3/8UNyA6MTkkvPgjqyjyods/TcluHrk6t8mpRkxIAC3eck4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C+VZ7ANl; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-42cbadcbb6eso27053495e9.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 15 Sep 2024 07:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726410706; x=1727015506; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wJrntt9EEx5ieWCRoCr13+FhRpz0IVeZBFKTzzkJrvk=;
        b=C+VZ7ANlvzs7dkaiS86g+z7aox85G2+ydbcHgJgkvMJ5WawfE+CJ3gfd9jXdej4x/l
         9UD9lVfovNCTiKT5Q+d0lcoQ1w3bpwR0UsWZIdGiVMEuJm5mWaIsIo9sLVuLoVneCF/2
         1e6QoS8qh6YnY3laY8XsNthMO8sBf6XQ/VRXPJfb86d3MXQvGiAUn1tWLfaKUd9GF+B5
         pgNEW4bCOHOs16RLF2SnQlo+Qi4k/mwU6y8yA3wU/7XeA/CCparE82dW/fMY0ZGQoFRi
         8GUCKPQHrRntPOuOVvaV9FWzU74/8ChC9CEz8aqjaUjV7sGBSl8vEUO/tjKDvck/EgUs
         lP4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726410706; x=1727015506;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wJrntt9EEx5ieWCRoCr13+FhRpz0IVeZBFKTzzkJrvk=;
        b=QnrFv6xbGU9qx897vLtDP3lh4g3z3wYI3LOcIIvTGD5CQvCS7zffI0kMAhCVvX4egI
         h+e0hT0lWJ+4qnox6oSmuGaCVyOgIEi2XDQUOZcXYUSOb0DY0bHpHiZMMRmQc/+DZwrg
         Gvuv5TM78BTmQgEcBF/LyBSIO1BvEAIxUNJEPX2Fs/scvrkpBNKGcEGWKHvoakT1PAEb
         S50pgmfmQb/TToVzqh9Q+PWmxF7MF6zfB1+U4YeKR3BvxpDUV+2YNIpZjwQX3PoINwLu
         lIyEAtn2d+S/zTZx2H5TWxT//jEMhYo8AN5h5D+tnpxntDaEcUxBdLpggQRrpXpzJVjR
         7kiw==
X-Forwarded-Encrypted: i=1; AJvYcCUWMHk1n0csxsRL3mMqmaol+Fwppx1VDNhIXZcgWa5buEsnWrf7KnQYUiULpTo2n7tfdLIyqBQo3C9WBQP0@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9k6SwCuO02fHDBqhCU67338xNnGi5bSWLSKeXySGVCgvgSpLL
	Jco8Y8Vb4eW7xOJduqFTPlC8TjbcJo91UW4y0g549fcMqJe7HsAbevs3ds7hry6e4lUf5K81019
	Aw63IkdcnHSuW1Q==
X-Google-Smtp-Source: AGHT+IG3R4ASaC0KijR1aECHjilHQ5gmuHF0HI7KyynXvt5LiFU0TMkiMOIJw+2yNuJQZRObBbKcsFiapFrTw+w=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:35bd])
 (user=aliceryhl job=sendgmr) by 2002:a05:600c:1d28:b0:42c:b636:5891 with SMTP
 id 5b1f17b1804b1-42cdb569f96mr1813755e9.3.1726410705716; Sun, 15 Sep 2024
 07:31:45 -0700 (PDT)
Date: Sun, 15 Sep 2024 14:31:30 +0000
In-Reply-To: <20240915-alice-file-v10-0-88484f7a3dcf@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240915-alice-file-v10-0-88484f7a3dcf@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=7648; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=pZluqOYDewoyL/Pw33wzo0+9mXuz9XshwBqpSa+QO2E=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBm5u/CPUwRpX0HXjIIOfY6uZ0KzDr9daxhGzzRG
 bLR0Gy+y5yJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZubvwgAKCRAEWL7uWMY5
 Rh6LEACEeOGnZkjswcGTbhfEd6qUCjTH4OdIecXnKr4sOCs7PU104TJpThMdfWV3TYbvI3IG0LL
 wTzbzGvY/O+my2pyHifEIwFfCgyvRQJYHm2lmFIQcKjgpX8sDzTn4/w9vdHj1+/PdrMKWN8U9rL
 kNjGyuCbMQaiJAT450K0+aUNS9IsBnfr59hLjWT39M5efj4tPqVrCHOHppf7YnRFsPF/A66tsOG
 aKiXmkyNzP3UB0hFZjO7olLiEFUGf83JMc1mE+GzQniYC3C2jdGli9WThGINMD22TwPMEMo7rJE
 dtDEnpEEOSJV+O97MwlEnk0bZ7OmE/9/fWFaLxCX5yBqtDVTLz5meC/y+ah5vpYGs7XPY40XTaF
 +4Q2TX0e2wf9GIIvw1ZAffnRrx6RbQUKGHdpOOTHvtaV84x1eDqCj3XaKCr5qbGgGvZCsuIqvc4
 Lxnr+N2iSCIn+1KzrnBXD6VL3j1CZzBGOQDu0hWWEG2oaACYCFB1DdRU13GyK9fpv6Zlsj91okN
 0Appvfc0WBft83SP3O6mwHQfoGqIQ1UPE7O30BC5Ujph75CZ+EioKc4DEKXlrqrgHyb1XYIvHJt
 XtFthh5wjYwUn23UfKJ/JcXEUI0RlGoRSk3vMNbGrl0IEGtQzJOdzhZGVoDR7qhcAHxwvh3RSXQ cXh9DO23N2Inxgw==
X-Mailer: b4 0.13.0
Message-ID: <20240915-alice-file-v10-4-88484f7a3dcf@google.com>
Subject: [PATCH v10 4/8] rust: cred: add Rust abstraction for `struct cred`
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

From: Wedson Almeida Filho <wedsonaf@gmail.com>

Add a wrapper around `struct cred` called `Credential`, and provide
functionality to get the `Credential` associated with a `File`.

Rust Binder must check the credentials of processes when they attempt to
perform various operations, and these checks usually take a
`&Credential` as parameter. The security_binder_set_context_mgr function
would be one example. This patch is necessary to access these security_*
methods from Rust.

This Rust abstraction makes the following assumptions about the C side:
* `struct cred` is refcounted with `get_cred`/`put_cred`.
* It's okay to transfer a `struct cred` across threads, that is, you do
  not need to call `put_cred` on the same thread as where you called
  `get_cred`.
* The `euid` field of a `struct cred` never changes after
  initialization.
* The `f_cred` field of a `struct file` never changes after
  initialization.

Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
Co-developed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Trevor Gross <tmgross@umich.edu>
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/bindings/bindings_helper.h |  1 +
 rust/helpers/cred.c             | 13 +++++++
 rust/helpers/helpers.c          |  1 +
 rust/kernel/cred.rs             | 76 +++++++++++++++++++++++++++++++++++++++++
 rust/kernel/fs/file.rs          | 13 +++++++
 rust/kernel/lib.rs              |  1 +
 6 files changed, 105 insertions(+)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 4a400a954979..f74247205cb5 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -10,6 +10,7 @@
 #include <linux/blk-mq.h>
 #include <linux/blk_types.h>
 #include <linux/blkdev.h>
+#include <linux/cred.h>
 #include <linux/errname.h>
 #include <linux/ethtool.h>
 #include <linux/file.h>
diff --git a/rust/helpers/cred.c b/rust/helpers/cred.c
new file mode 100644
index 000000000000..fde7ae20cdd1
--- /dev/null
+++ b/rust/helpers/cred.c
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/cred.h>
+
+const struct cred *rust_helper_get_cred(const struct cred *cred)
+{
+	return get_cred(cred);
+}
+
+void rust_helper_put_cred(const struct cred *cred)
+{
+	put_cred(cred);
+}
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 3f2d0d0c8017..16e5de352dab 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -11,6 +11,7 @@
 #include "bug.c"
 #include "build_assert.c"
 #include "build_bug.c"
+#include "cred.c"
 #include "err.c"
 #include "fs.c"
 #include "kunit.c"
diff --git a/rust/kernel/cred.rs b/rust/kernel/cred.rs
new file mode 100644
index 000000000000..acee04768927
--- /dev/null
+++ b/rust/kernel/cred.rs
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Copyright (C) 2024 Google LLC.
+
+//! Credentials management.
+//!
+//! C header: [`include/linux/cred.h`](srctree/include/linux/cred.h).
+//!
+//! Reference: <https://www.kernel.org/doc/html/latest/security/credentials.html>
+
+use crate::{
+    bindings,
+    types::{AlwaysRefCounted, Opaque},
+};
+
+/// Wraps the kernel's `struct cred`.
+///
+/// Credentials are used for various security checks in the kernel.
+///
+/// Most fields of credentials are immutable. When things have their credentials changed, that
+/// happens by replacing the credential instead of changing an existing credential. See the [kernel
+/// documentation][ref] for more info on this.
+///
+/// # Invariants
+///
+/// Instances of this type are always ref-counted, that is, a call to `get_cred` ensures that the
+/// allocation remains valid at least until the matching call to `put_cred`.
+///
+/// [ref]: https://www.kernel.org/doc/html/latest/security/credentials.html
+#[repr(transparent)]
+pub struct Credential(Opaque<bindings::cred>);
+
+// SAFETY:
+// - `Credential::dec_ref` can be called from any thread.
+// - It is okay to send ownership of `Credential` across thread boundaries.
+unsafe impl Send for Credential {}
+
+// SAFETY: It's OK to access `Credential` through shared references from other threads because
+// we're either accessing properties that don't change or that are properly synchronised by C code.
+unsafe impl Sync for Credential {}
+
+impl Credential {
+    /// Creates a reference to a [`Credential`] from a valid pointer.
+    ///
+    /// # Safety
+    ///
+    /// The caller must ensure that `ptr` is valid and remains valid for the lifetime of the
+    /// returned [`Credential`] reference.
+    pub unsafe fn from_ptr<'a>(ptr: *const bindings::cred) -> &'a Credential {
+        // SAFETY: The safety requirements guarantee the validity of the dereference, while the
+        // `Credential` type being transparent makes the cast ok.
+        unsafe { &*ptr.cast() }
+    }
+
+    /// Returns the effective UID of the given credential.
+    pub fn euid(&self) -> bindings::kuid_t {
+        // SAFETY: By the type invariant, we know that `self.0` is valid. Furthermore, the `euid`
+        // field of a credential is never changed after initialization, so there is no potential
+        // for data races.
+        unsafe { (*self.0.get()).euid }
+    }
+}
+
+// SAFETY: The type invariants guarantee that `Credential` is always ref-counted.
+unsafe impl AlwaysRefCounted for Credential {
+    fn inc_ref(&self) {
+        // SAFETY: The existence of a shared reference means that the refcount is nonzero.
+        unsafe { bindings::get_cred(self.0.get()) };
+    }
+
+    unsafe fn dec_ref(obj: core::ptr::NonNull<Credential>) {
+        // SAFETY: The safety requirements guarantee that the refcount is nonzero. The cast is okay
+        // because `Credential` has the same representation as `struct cred`.
+        unsafe { bindings::put_cred(obj.cast().as_ptr()) };
+    }
+}
diff --git a/rust/kernel/fs/file.rs b/rust/kernel/fs/file.rs
index 6adb7a7199ec..3c1f51719804 100644
--- a/rust/kernel/fs/file.rs
+++ b/rust/kernel/fs/file.rs
@@ -9,6 +9,7 @@
 
 use crate::{
     bindings,
+    cred::Credential,
     error::{code::*, Error, Result},
     types::{ARef, AlwaysRefCounted, Opaque},
 };
@@ -308,6 +309,18 @@ pub fn as_ptr(&self) -> *mut bindings::file {
         self.inner.get()
     }
 
+    /// Returns the credentials of the task that originally opened the file.
+    pub fn cred(&self) -> &Credential {
+        // SAFETY: It's okay to read the `f_cred` field without synchronization because `f_cred` is
+        // never changed after initialization of the file.
+        let ptr = unsafe { (*self.as_ptr()).f_cred };
+
+        // SAFETY: The signature of this function ensures that the caller will only access the
+        // returned credential while the file is still valid, and the C side ensures that the
+        // credential stays valid at least as long as the file.
+        unsafe { Credential::from_ptr(ptr) }
+    }
+
     /// Returns the flags associated with the file.
     ///
     /// The flags are a combination of the constants in [`flags`].
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index c7d50f245f58..c537d17c6db9 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -30,6 +30,7 @@
 #[cfg(CONFIG_BLOCK)]
 pub mod block;
 mod build_assert;
+pub mod cred;
 pub mod device;
 pub mod error;
 #[cfg(CONFIG_RUST_FW_LOADER_ABSTRACTIONS)]

-- 
2.46.0.662.g92d0881bb0-goog


