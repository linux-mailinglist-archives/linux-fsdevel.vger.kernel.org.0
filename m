Return-Path: <linux-fsdevel+bounces-9990-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF48846E6B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 11:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C59561F24EE9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 10:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A83F9C6;
	Fri,  2 Feb 2024 10:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g2KIhTdi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A225513DBA2
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Feb 2024 10:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706871361; cv=none; b=qm4hc0i1Hunqq+RMQJlDO4zrlRa79pXc9Y0pcYCu2TTkhTeZdhtVziNo7u1xvMses63xisKFKStOJ3n3sJob7WWSZVK3nztdSbpqiC5SaO2rZHD5FdEailCO8JBlpv/6rq1n1+CS4lNGpEw2KFPLmTADiYzHgm1qYS/7z3lfV1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706871361; c=relaxed/simple;
	bh=VjG8KeHVT0bRonA+wMBCaRlMOvyLx3lxFBnR9ZrLsnA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RLIlLCkSVcxMpHe3ZyCOOZM2ZJc0FvAEBJOsEhytSIwOXzkhePjOBQX9XCVrULLfIwvYfURjhkVN2Xyrw0CLuyx5h+ix142qm0jVikk1+Spy2F88mNJrVHyWjMy3MOAluct8AQfXbl7viNX7p+hxUlLGbGd5S2XCnSYbDFbd7w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g2KIhTdi; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60404b12af2so31904707b3.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 Feb 2024 02:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706871357; x=1707476157; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6GYoowl1Ig0jePPuB7MkxgkBlU6gWq9TSj9WyS6KkJA=;
        b=g2KIhTdif34wZGV0noroII1cIVxMd4IKatTE7wjP28HjqtQPtj2s/9u1ptBYxCDFWI
         BDk4ePZPqLfvNzpXhTI3CGW2ZnO2sff9q0vXXVnNlDcxMce5ZhpUkLu6GMQmFYfBbPwi
         Hd78bMnK0Fhh97QXlqXRJhyXY6s0N1KRpNaflIiiuGx8fikNn1MI8PzgsoTi75VPc/CF
         uKakRRXnIqZNwLGJagXeihQa72v4Bdhw8Lxehp8s/C0TN+Quf0wKHTDIuTKFxZ0lNpcS
         nA1FcCvZgnncsqnJURetKAM+YMnTlFUklYQLSQ5XU6Ztue+Rfn3hO+SODG1+75yIAx+e
         J5HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706871357; x=1707476157;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6GYoowl1Ig0jePPuB7MkxgkBlU6gWq9TSj9WyS6KkJA=;
        b=RHSaOcC9hZHlg9r7lJW3TnjYOKxrNGZU9olmxle7pu68+ovZwK8BwlB+CtSP+DYitu
         GNYOfnQUAOEvel0kni/cs6gncN8pQFoCwHZvDOxoWRZ7TjHIIAIkbxKOWxd3Fww22E8G
         70V/FkSpCTOgLkteIjtaoZMEc875Y9wePRif+YEav4vyeNODTbalU9hmSvKP1spGj6eQ
         0CjPipkQ8L8qIyCV9WdGUEXrRx68dLi29eGvOfBef5OB1ViFeo23xZmmqm3XARnDXEi2
         Kru+Wf/22r0bCLuO3pYf23Pt6wk2q8mQZ5TWAlIZwHfKVvPsdzJQ/H9QkAFuJxwas0ID
         UKzg==
X-Gm-Message-State: AOJu0YwgsOqj22V1VlEIDoheBRzMHPb4n8kerjQmOeaD48CgmsqeVnJK
	OiJkp6jKXFl+jHXjC9HaX6asdmPkif6ApYiqiI/PZ88evkqkw1kH37BoTxd8b2TyROyzPrkfMS1
	0VnPBcxDZE4Jpzg==
X-Google-Smtp-Source: AGHT+IGq/9CJs+NczyfHIBwAJYHMf3qa6dyPebr4fW4/tDd2NSX0IKBJlHy/u9E3dGgQbeuHDwYjEo0sxgLQCIc=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a81:984f:0:b0:5f8:e803:4b0d with SMTP id
 p76-20020a81984f000000b005f8e8034b0dmr1243493ywg.2.1706871357746; Fri, 02 Feb
 2024 02:55:57 -0800 (PST)
Date: Fri,  2 Feb 2024 10:55:38 +0000
In-Reply-To: <20240202-alice-file-v4-0-fc9c2080663b@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240202-alice-file-v4-0-fc9c2080663b@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=6907; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=2vVeNVuu/5fFy4n9rU91a6ylN+gEl4mdw/ZMMDxAU7M=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBlvMjJdh5WgrbgvuCcDMOcJWBvJ31HrlBrqBMtS
 /dzR3QR8VqJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZbzIyQAKCRAEWL7uWMY5
 RhthD/0bD1c2e2WGe2h61KiU83ljczWqb3+bILZhB64qEg9UlTt63TNfGwR9QGT+RIDVrZPzLV9
 1ZM7UsVbYuzKvfJYloFIwFO4pJxR8EJjXV+Dto5AnDpOVOs9fJDQtQEIbBC4KLK/FsnrGQxgljM
 2CDtyixe35XiYQ3MRMXE3/OV2m4+ST6kdJMOic6v7WVjy0Ry2uxTZte8FsQCLA+jElL1KAAsGSX
 AVuscLUH5cgMv+gARKHD64flxCjtTPIuCyA7GF1DoxeBGx9xmap6ueEjm1o037WOTQLsNaNwNO+
 mLFJl/qUTfaFrRTf7vK/r4l/xYl4oLItqBzZUGJM94T5NTc3vnrjKD13UtP6d7gRaDTNZ2+2QBq
 zWI/shFSPuPqJG+t5ukjZqpJU4opkpwFM/FNtfzpQI3jWecOh7fhiK3MhOlGvtPm2FM7MfvMP2a
 ty5TKPi4IAG2GFfF8mZ7mG/aljSHkc7uKOCNTRUIXF8bx/cczvr32jFCxugdlNygaN2WhKQvykn
 ezvsqLuVCH347pWbgDNsjOQCH/ZtttJweKtkljqN0//5j+g7zqUhK6mPiZGwz8e3TBJEaXC2MCq
 bV1V+mOeUgKvDUjJ/rk8tuLyu3RpNaBVHPFOpPvTzY1Q/+6cUnzScaAbOs9IosJEuP54fTRKdk8 dn2xJV158IEQIeA==
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240202-alice-file-v4-4-fc9c2080663b@google.com>
Subject: [PATCH v4 4/9] rust: cred: add Rust abstraction for `struct cred`
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Peter Zijlstra <peterz@infradead.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Dan Williams <dan.j.williams@intel.com>, 
	Kees Cook <keescook@chromium.org>, Matthew Wilcox <willy@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>
Cc: Daniel Xu <dxu@dxuuu.xyz>, Alice Ryhl <aliceryhl@google.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

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
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/bindings/bindings_helper.h |  1 +
 rust/helpers.c                  | 13 ++++++
 rust/kernel/cred.rs             | 72 +++++++++++++++++++++++++++++++++
 rust/kernel/file.rs             | 13 ++++++
 rust/kernel/lib.rs              |  1 +
 5 files changed, 100 insertions(+)
 create mode 100644 rust/kernel/cred.rs

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 41fcd2905ed4..84a56e8b6b67 100644
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
index 03141a3608a4..10ed69f76424 100644
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
index 000000000000..fabc50e48c9e
--- /dev/null
+++ b/rust/kernel/cred.rs
@@ -0,0 +1,72 @@
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
+/// Most fields of credentials are immutable. When things have their credentials changed, that
+/// happens by replacing the credential instad of changing an existing credential. See the [kernel
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
index 0d6ef32009c6..095775411979 100644
--- a/rust/kernel/file.rs
+++ b/rust/kernel/file.rs
@@ -7,6 +7,7 @@
 
 use crate::{
     bindings,
+    cred::Credential,
     error::{code::*, Error, Result},
     types::{ARef, AlwaysRefCounted, Opaque},
 };
@@ -202,6 +203,18 @@ pub fn as_ptr(&self) -> *mut bindings::file {
         self.0.get()
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
index 9353dd713a20..f65e5978f807 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -33,6 +33,7 @@
 #[cfg(not(testlib))]
 mod allocator;
 mod build_assert;
+pub mod cred;
 pub mod error;
 pub mod file;
 pub mod init;
-- 
2.43.0.594.gd9cf4e227d-goog


