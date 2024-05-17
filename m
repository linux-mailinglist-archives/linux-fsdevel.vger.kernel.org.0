Return-Path: <linux-fsdevel+bounces-19645-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B85E28C838A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2024 11:32:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCB661C21B0E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2024 09:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71893CF58;
	Fri, 17 May 2024 09:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cB/ka3iD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF863AC01
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 May 2024 09:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715938299; cv=none; b=Fzv7lLGkXpSA9dryRIjbh3mqUbHHnxVP5PS5QZAvgH/ZDA888u2y1aleNwPCKsDCWSpg9uCPh1CQLORRGcclpD64Y5yS/kSlVFY1AK+jfXyb0ubw39PM34KJjWZyXYvC9goURWRaX6eZnI836sDSfDhRKlBf0sicoIb7kfDNUjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715938299; c=relaxed/simple;
	bh=LdIB77NeyaomUc46ppC8snyiFFs+yu8TNQrT9MsZdX0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HAMqXpRisxtjKE3xnfwgOHJgyhPFwcsb8pJVpoGmolT33a8xzwA2rVsHvMBZf0yY5bUPkf2L/VUePNw0RXY55nVdJqLI7nEJ5LefCkD/YykhIaZYGsimasFnn0pXrE+z6Dr+ZRIOOLr5JhDZ9Pfdsw/XR5Ax5s4cUIDYirZVAqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cB/ka3iD; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61d21cf3d3bso156054477b3.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 May 2024 02:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715938297; x=1716543097; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tPzgy3HpSmlXL37WBxWgC0/HBG+zHL2ujfWtVnQfaJY=;
        b=cB/ka3iDGZ1iLT5J3FZd/urRcAXVvc9WBSZ2pfdtOkeJU5blKMdRUa5NjxncgLIKfp
         IafJcTqYkZQopwNme50PlWYwVuGUA7efq+NsTKQ06Ql3BgaPNs+E2HMvuPM8ymawv236
         sP8EYF9Lr7ia9KBRzNNnLw9gGDytb1QaitbL4wLPMvTLt2qZvWQXnAcGsPukIR/fkUVE
         t+E4m+NO9lRybgZMkKvaUsHbWeigkPQRgGKoI6W9HuU7ykmUpGl35qMliIHh9ZI2gQNr
         r1QGShUyMNmmBMAd7jE4tsWYiQE7NCyzzJWBPVPNMLMtmrOPmXyx8HPHlOPMXmXWgoqb
         mXig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715938297; x=1716543097;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tPzgy3HpSmlXL37WBxWgC0/HBG+zHL2ujfWtVnQfaJY=;
        b=hlHqGq9jkIg+ABfalUjTWi1dtKYAMdXfQGBxnnrMVStC+yLn6MtcvkViAThdw+HCqG
         rwpN1w4c0L3Y0WobgeU+O8GyMOE10+f/nTEngPhbyt7LfA59PtcwDo5HNiESDHigHolA
         TJQl5Gtq8RebTHED89TrvgklWGP6cawow0hTooZBClHRFUQvunX+NY/97HoJHAmhMOc0
         dBMVa1q/ndKyU3ag1Yl0k746hioG8ayN4vZbnhZ6zM2PwVVJ9uGSUCIVPIauXFYEosND
         96uALFBkSKkMJY//Zd6k1F5Lrptc2ir7simZoPaFxW9yVMJ9WcfHn+Y1seXvUS7HXN6h
         1XQg==
X-Forwarded-Encrypted: i=1; AJvYcCVKP8I4wLx0KmQBrp2G1vwMFLMW6FEpB/QMDCS85W5x8lhKxaLuvRw30zLBstgq6npSzlAgp9op6WrjpTUcxUfhb5EYZEDLg5DOJ6sF/Q==
X-Gm-Message-State: AOJu0YwoIY+dxaiiKAa+yD/q/cW3jmN3LDvNX2BiO3UoXboHlGJTS8ea
	zS4wyjqcCEXQYyp0mO3vqB01LA1KrKfR2gCp0FX5aDdORuNaXBW2UEuNpoPHffVvCLBgRuZEibi
	LvPxfAfRhT63roQ==
X-Google-Smtp-Source: AGHT+IF40DOuPn7g5Zhk/+NMMJKV5nEt7pY8RzYw1vCxH4uDwznUvDK1G/jYfvrUMpHASYon+pqYRZd6O/Htsog=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:690c:4508:b0:61b:e1cf:44f1 with SMTP
 id 00721157ae682-622b0169688mr44445737b3.9.1715938296767; Fri, 17 May 2024
 02:31:36 -0700 (PDT)
Date: Fri, 17 May 2024 09:30:37 +0000
In-Reply-To: <20240517-alice-file-v6-0-b25bafdc9b97@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240517-alice-file-v6-0-b25bafdc9b97@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=7105; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=lc5ywLvNlny94cApSheat/BbQx7cOU6X8daJ8HVy+3k=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmRyPmg2zMas1P7RUy7B2v/Uq2gYT8ZjdNwz/Rh
 ZL9HlUX+KWJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZkcj5gAKCRAEWL7uWMY5
 RkETD/4/hjPwhG4iYZbCt1tNX3bVjZ2/Zrp/2SjqSvPZt75tydua9OYhMXCERbSdmXQLVr2P+u/
 l0dUry4T208bD/D5K9v/plmzxccQl0V8U/V4/7hyery8JfdHymtT8Us3ejE30OUPgNrlyHU2X8A
 +sdDTmI9JxkyJRpwIFN6v8njUzlTYw1an1n/ulcyg0Ukvp1jd6pk8i8saPbIbmbmxaGVH/T/wwQ
 K2LXp+yJRr6RIL9n5R+G5EJGI3IYWlA8gwZF420RIumJPxOov3OF6p83/tnfs3rvSFFTd/6o8D2
 8Ruf/S9g/Th/B9AwkjFNGPFQ+CKQ45gD3KIi/8QsGJUjg87eGMnopRAFiyZpOoYopUjhc0WSPL9
 RlCndHQDn4qg6Sa1+IVOh4ehUEIceiHShHijjUeVxsx932OMJYt0Ybo2WrZExxHnwquSyw8Pri2
 PEchNAtI6wuRP4A8dsqmn7qt4y8NOI+Q2FyhBQIUEwQceBJzdY0v21Idz/GWakqynAMBRGNBKJ2
 nY/PT54Uk/DP3eetuGAW+XcxGDdn6atEU7ZanNgscKYsr0z/BOltDdg26Lx2k2FkQkvMIWdJ54b
 NGswUk7sqjUfB/Y3qAv1SZc3F/QjHC4CQf2rAjdos53P5/h0k72yitYhI7TiFs4Ej0E0cf/Tiz8 7JtRzrCa88xjZOg==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240517-alice-file-v6-4-b25bafdc9b97@google.com>
Subject: [PATCH v6 4/8] rust: cred: add Rust abstraction for `struct cred`
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
	linux-fsdevel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Martin Rodriguez Reboredo <yakoyoku@gmail.com>
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
 rust/helpers.c                  | 13 ++++++++
 rust/kernel/cred.rs             | 74 +++++++++++++++++++++++++++++++++++++++++
 rust/kernel/file.rs             | 13 ++++++++
 rust/kernel/lib.rs              |  1 +
 5 files changed, 102 insertions(+)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 541afef7ddc4..94091cb337e9 100644
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
index 5545a00560d1..56415bce8af0 100644
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
@@ -164,6 +165,18 @@ struct file *rust_helper_get_file(struct file *f)
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
index 000000000000..360d6fdbe5e7
--- /dev/null
+++ b/rust/kernel/cred.rs
@@ -0,0 +1,74 @@
+// SPDX-License-Identifier: GPL-2.0
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
diff --git a/rust/kernel/file.rs b/rust/kernel/file.rs
index ad881e67084c..755816eb38ef 100644
--- a/rust/kernel/file.rs
+++ b/rust/kernel/file.rs
@@ -7,6 +7,7 @@
 
 use crate::{
     bindings,
+    cred::Credential,
     error::{code::*, Error, Result},
     types::{ARef, AlwaysRefCounted, Opaque},
 };
@@ -283,6 +284,18 @@ pub fn as_ptr(&self) -> *mut bindings::file {
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
index c583fd27736d..cc629a74137f 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -28,6 +28,7 @@
 
 pub mod alloc;
 mod build_assert;
+pub mod cred;
 pub mod error;
 pub mod file;
 pub mod init;

-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


