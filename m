Return-Path: <linux-fsdevel+bounces-24245-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2451693C425
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2024 16:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 981641F2333F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2024 14:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E3019E7E4;
	Thu, 25 Jul 2024 14:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bNNGFK+C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f201.google.com (mail-lj1-f201.google.com [209.85.208.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D722319DF9C
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jul 2024 14:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721917677; cv=none; b=oH8zH3XJsd6Riw6Yxt6hzmJt3jrtfsLhCGHFbKaHstUD0fdF7UpIZmCU7lHsRrDDowM85E6qUy2BQ+WXmujEVHdQHpcsc0wyb8Z7h3GRuHpTmstIbD+3iOYLbaGITNKDIj+diNIz9i5IrcQFN9J4pA0uokq1BXff2G9BGxVrb1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721917677; c=relaxed/simple;
	bh=RXfaT/DBCQsWj/QAf6Xvjcb3hoSnauK9QOWBOYATpsw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NZTbb0NogAnNQeHlz2yECdx3qUpGh/0U+Ryjpc+f8dPR/DYDGtBdAPt9ASIl77rnHge4aFv/fDBOmlfuoHMXgEeLOHCO4DYZzpl8H0/SmictEr0ryXNXtvbttm9vs+KoxNvEGXTtARvkXOt2NrNUGGpmVxA29Z/5MvYxez/Bue8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bNNGFK+C; arc=none smtp.client-ip=209.85.208.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-lj1-f201.google.com with SMTP id 38308e7fff4ca-2ef286cf0e8so2521901fa.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jul 2024 07:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721917674; x=1722522474; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OiCmBwg2/y546/4rMjJfsysS+CelPZa1uCxDdubqWiE=;
        b=bNNGFK+ChHShPCggqe/e5P8vPmHpGOkPWAPxLRQT/CmkNDuvKKqtVK0QCAsuAK9nKq
         HwUz6BFhb/zVWB3yq+a3wJIqgDu2RSF2oPKTPK9aJaT8Fl0l92kR0zi62n7PrWAxH4OJ
         RjfCZECHXPPZuOqZOZMQ3QRzViK5nKGKZMPfbXqGNKElSzXKaXfiuHLzpivMaju3EouT
         rClpYGZ1Zb5j5Ke2q/RmI6BJBShy9p7xp9TOZgBqio3i+ldGt/JZViAdCanfenjo9bdb
         bRjxjLluGzjHGVn0246/gjceBkc7lBqbN464Y/IsZD2YBf3LzQtnfB2T5omdb8oAlvRe
         TpmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721917674; x=1722522474;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OiCmBwg2/y546/4rMjJfsysS+CelPZa1uCxDdubqWiE=;
        b=vbxBAB5QBXNSD5UJly3+mCriGgqW5YuA0vi4fEO4TBkIPUEqBglQ3AYdUJ/W7O/nqX
         Dt7r5Zup9Py/4rRCzTDn1TguOI3piO2SuCZqyTkA65hn3Fpb7tFQ2ftj5dero/SW9QZL
         mrK7e4oGEYL5ugr6AFkUDW9vl1nFeo9wk7zMJt/FxbzWOVgt0kCHQxcsoiqD0T7mFRZm
         wvFPiCUIe8q5wmeBR50qidbu83PWJXnh+Ez3yaA03W/DRNzKZ5VKWvDlq2Z9dHvpOwyp
         bYWpxcwKpOvCInmReqXqXEd/rS4Ria18ztPM+OgMrh8mskeBdX9gqopwB4bo3x4IvDhu
         /g6g==
X-Forwarded-Encrypted: i=1; AJvYcCWUKePZoUnQskHKFHKEuvKorzyVPJuj8pfR1P4M1HGtiNUg/v8QIKTNFl4kBCkK4PKdtH4xhvZNnx1hRroKIYYC1dF1QajQGXReSHWWcA==
X-Gm-Message-State: AOJu0YwSier0K/Qjzkv/65RchnMAFP4+P4pw3CRXlAlyTLcpdrUIvpGG
	uLGMtH9Zzv/rvN7LBA4Nyd3jfKk0GZXDc3dKk33FqYPsKEo7cSjcvDQeFh1q9TbxcgNwShB7If/
	zBgoU9CR3eiGEiQ==
X-Google-Smtp-Source: AGHT+IEsxwGIyCMRt8S3kpoTLeGHaoR+N+Zq9q7sZejFEWj8cm4nkIYcecRhbfp4fTAHMgfUv1T4/+xh2KIwHVw=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a2e:7d15:0:b0:2ef:1c03:73e7 with SMTP id
 38308e7fff4ca-2f03dbe1817mr25471fa.7.1721917673884; Thu, 25 Jul 2024 07:27:53
 -0700 (PDT)
Date: Thu, 25 Jul 2024 14:27:37 +0000
In-Reply-To: <20240725-alice-file-v8-0-55a2e80deaa8@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240725-alice-file-v8-0-55a2e80deaa8@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=7149; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=NIY5e2gNiq/wYldTRcMtyFezUNO6yObaGdnkQ//UV7A=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmomDYIR9taxDiZOFpXkHw3q9vFtwkHgafSI2Nc
 DDub73/NhyJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZqJg2AAKCRAEWL7uWMY5
 RtxsD/4jHCh1BSJwTSRAr6sLQW7s2DSG9vj+kS5q1TBhSyIa7huvROeUgZ5Wr2yYtrfbHxjH8I1
 0rF4a6Mf1Hs/L2NG0jrwueVYg2OfqPY7XLYCkD5gLDmtMFb9XtkqdDhPmuQB7+RHj1DrGhCWWQc
 wvVGvj2PtdvnxvitJOXAmjeL/8f0sUt542sEqc1uPtXFFjlRvGRuwxr1oxEM7A0N2svk1LroQZr
 rvaYhtRDEDYSj4PyN51uCZT8D6uawAbaaiWZ3CSGfZrNYZSIxgDJtxjOlqkouVN9kCudjyOVkL1
 f3SMq7VuPfIJJBXA9A44vJ6MTD07rYAEsOb78k7zUEcz9ziCNjU+6s3PYMGqpdunp/ARq37XV+2
 g5Cgn1XPkgzoyrMh4vsJWWWivNEi/nEeXTmfvpy87HexdM8k7S/53qcgKClS/cXrE3G4zeHPcFk
 NbR9YrOmD6N4QIlV7jSrA07z4TeH5EqLCWpnjR5ZaWDkSunYD5s4u137POu+3jYi3aT8Wlp2PiZ
 8qHeFxFmXCioe1fXY9pM4/R1I5GbiybeuEJ9VtPJ4oshZjuIDwsnWA5JN7lu+AlPSr5wKo5/alh
 cqj5taZ3eQL2P1su6nVHyjQ+QUq0GbF02U7M9A6etaUi4vLMBpDMBjCKFLxNf+kJn8vCEm4onsh A415/TH2NIDszqA==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240725-alice-file-v8-4-55a2e80deaa8@google.com>
Subject: [PATCH v8 4/8] rust: cred: add Rust abstraction for `struct cred`
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

From: Wedson Almeida Filho <wedsonaf@gmail.com>

Add a wrapper around `struct cred` called `Credential`, and provide
functionality to get the `Credential` associated with a `File`.

Rust Binder must check the credentials of processes when they attempt to
perform various operations, and these checks usually take a
`&Credential` as parameter. The security_binder_set_context_mgr function
would be one example. This patch is necessary to access these security_*
methods from Rust.

Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
Co-developed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Trevor Gross <tmgross@umich.edu>
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/bindings/bindings_helper.h |  1 +
 rust/helpers.c                  | 13 +++++++
 rust/kernel/cred.rs             | 76 +++++++++++++++++++++++++++++++++++++++++
 rust/kernel/fs/file.rs          | 13 +++++++
 rust/kernel/lib.rs              |  1 +
 5 files changed, 104 insertions(+)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index e2d22f151ec9..22e62b3b34b0 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -7,6 +7,7 @@
  */
 
 #include <kunit/test.h>
+#include <linux/cred.h>
 #include <linux/errname.h>
 #include <linux/ethtool.h>
 #include <linux/file.h>
diff --git a/rust/helpers.c b/rust/helpers.c
index 5ba1f6de0251..4831abb5a438 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -23,6 +23,7 @@
 #include <kunit/test-bug.h>
 #include <linux/bug.h>
 #include <linux/build_bug.h>
+#include <linux/cred.h>
 #include <linux/err.h>
 #include <linux/errname.h>
 #include <linux/fs.h>
@@ -206,6 +207,18 @@ struct file *rust_helper_get_file(struct file *f)
 }
 EXPORT_SYMBOL_GPL(rust_helper_get_file);
 
+const struct cred *rust_helper_get_cred(const struct cred *cred)
+{
+	return get_cred(cred);
+}
+EXPORT_SYMBOL_GPL(rust_helper_get_cred);
+
+void rust_helper_put_cred(const struct cred *cred)
+{
+	put_cred(cred);
+}
+EXPORT_SYMBOL_GPL(rust_helper_put_cred);
+
 /*
  * `bindgen` binds the C `size_t` type as the Rust `usize` type, so we can
  * use it in contexts where Rust expects a `usize` like slice (array) indices.
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
index f1a52814b2da..8bed7bebcc43 100644
--- a/rust/kernel/fs/file.rs
+++ b/rust/kernel/fs/file.rs
@@ -9,6 +9,7 @@
 
 use crate::{
     bindings,
+    cred::Credential,
     error::{code::*, Error, Result},
     types::{ARef, AlwaysRefCounted, Opaque},
 };
@@ -274,6 +275,18 @@ pub fn as_ptr(&self) -> *mut bindings::file {
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
index c364893e13a2..8fb57ec20867 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -28,6 +28,7 @@
 
 pub mod alloc;
 mod build_assert;
+pub mod cred;
 pub mod error;
 pub mod fs;
 pub mod init;

-- 
2.45.2.1089.g2a221341d9-goog


