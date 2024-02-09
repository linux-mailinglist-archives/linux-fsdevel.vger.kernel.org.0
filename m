Return-Path: <linux-fsdevel+bounces-10925-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CDCB84F477
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 12:20:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33635284F70
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 11:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F319364B7;
	Fri,  9 Feb 2024 11:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bSLV/VQ2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f201.google.com (mail-lj1-f201.google.com [209.85.208.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72792374D3
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Feb 2024 11:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707477544; cv=none; b=S+WDux0YRefHNTfIwuTzqjoOtKJXnGzwSrEBYjRMI4CuZnEFPN7+rKorxPLjrjEAkyd6m9MJIHIVfsXbbyJhFdl+jh8vvSFAIgPXafIp5xj7TJBtJxYAahcKKDrfJcOKZQAlRgJW6FvW0blbxxGaNX7E38X48MP0Q5Ga+t03a0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707477544; c=relaxed/simple;
	bh=6s2gn0oE8oc/3LtJyrV+uh/JSqxQjhps1bnBqWxXGbI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Cxes9w6aqylvQ0Fx/FQe8eT+mo0CPa0tD+YyX7nvHnklIsCeA9vJYAg+eaD6CckDp5U0nhvBEYl7aseBurBCQxwaCMb9Ywg1GmmxcdrmWgol7kIM2xbS3igHQ2rUVwCAwZVGaTIZO9SqdTDLLrwulLW76uXjKBsd35+6n+6TESs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bSLV/VQ2; arc=none smtp.client-ip=209.85.208.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-lj1-f201.google.com with SMTP id 38308e7fff4ca-2d0cfe644d6so8177711fa.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Feb 2024 03:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707477540; x=1708082340; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6FCYANgF4lGfBb0oow1nW4bsB/Fdu+fIcf3p3BOVfZo=;
        b=bSLV/VQ2HR6K2ekMF7QjV/PvAWgoLu8FwVtsInnaYPKSwpjw3UR8iHksj8RHklnlTq
         iteB3pZtdO24Dw4b3F4Gm27DAgmmGcbY9Kap3eYqiGBWmlkWxH+myH4P87sa/mqeZIQM
         RScRbzNLwvYNC0TGeliS3lXfJes6C0SOx/S5444/mbv4V0A1DW3Jlp6dMjFgl0MsZcdC
         /9X8h8vXO3phvhJD+bRUNowTpK5bAGCdmgKL6cdEjrJGzK4yBeUBKLRdEyxX29skUKE7
         p7rN9JCdk3TkmJ4L6l5Q051eDaF77ht8aLdcP9NtnuH1BSQMFFFOOVnu+enSX7nEwtmU
         42kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707477540; x=1708082340;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6FCYANgF4lGfBb0oow1nW4bsB/Fdu+fIcf3p3BOVfZo=;
        b=ui670Rr9PdaSTIoVBFJV6nK2dfhl3OJZ9SIu6ho5pvaOjD0QleMDbSZBrGG7yA1eiR
         +ZZpgVhmjkI7TjDhgcy2N//HpRHf59V2aJSJsUEgSbHzYu9Z1ul1/YfOahVwV8vHJVDw
         GgwjX7XucAOqg+9fFkKcZ3CEcyPNnqkPZr3ayTCIkODAlnhqKn7QLFSwPGc5n4YRZ70+
         wCT2mHELfFGq/uEiMHMoc5cVX2ZFCb9wQkCiXHjtchHqWtUxrwip8aMbQH/psR9FZIhW
         bY3iIalv3JXKzjRNzEEJoPKJ9FbkH4aQhn6+hjarAqj5Jsp2OQoCMcd3TH63+osXO9aT
         rOwQ==
X-Gm-Message-State: AOJu0YwLdgdUFDCrYah7w26LltgkSVsE6x+MUNDZepS6B5Ot2IqipnG9
	szu+ehh/SxRXJSh9nRg4XPajj8Ym4ot+lnAkFXGBze+jySwwthmIVnI3YQD7QAneIDw9YZ8DD0I
	jUIQOGIYzvzertA==
X-Google-Smtp-Source: AGHT+IEI9vdfUicuaGpUFk698Ne+fts1VaTZeqbjhseXzojOXusxOpuiR8CECtxSU9TayIjy0Toj8PskkQU8QJ8=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:651c:b20:b0:2d0:dd94:4ca9 with SMTP
 id b32-20020a05651c0b2000b002d0dd944ca9mr1166ljr.0.1707477540357; Fri, 09 Feb
 2024 03:19:00 -0800 (PST)
Date: Fri, 09 Feb 2024 11:18:17 +0000
In-Reply-To: <20240209-alice-file-v5-0-a37886783025@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240209-alice-file-v5-0-a37886783025@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=7117; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=E3RpArjiH4nioml1kPKUKUnKZduDlkajGIRmbXxIUMA=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBlxgoR52G40En1ErRk4ewFgUO8fX4mp3h9lJumG
 l6RPs7WbD6JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZcYKEQAKCRAEWL7uWMY5
 Rp5kEACcB92TIqUG+z0wBikO2hBIPI7gjDYF3SHW0x5qjB5WvxXic9+h71rZXkkrtlC/zD6x/Lu
 djaZpWwQUHHw1uJLA+7wmn0+GXGBjC97rhwZXktQIH5a+6rypSwJQ5e4QkFuvU623gZd7/mM7EQ
 N7uE56h/3UxdTFaEG1T8n6syqdmDWE1RqJkVU3CqU2CbrhjlZD1DVBomBv30NN2/FkO2/dMPCev
 C1O3Eeb7XXtD679sNvHggESeASeXsy+fSuaCtoL7dAoIBNsnS1htn8NvZ12obEzaxIWlav9Csll
 6RZKO+x4psyQNuWqdaJnkPbfrWwmj1A3nPDN+myeVrN68orgcbIuYUbrACh37J4qel3WrWKHrla
 9PPFaVhFPppwU+DnCvrZ7+nW/D+RqdVklU/DvK6+QE/dk42M5Kd0NhvgTBYfTUtITZG2yiK7F/n
 TiriCyvgW9hf73sZO8/kmkS1qa0Qg+HAjpqBa+ErKZiDigrABYAOso2bUPv3vhzVGMl1RyLH2xG
 aRSFY0rXlw1u3+s2mukvotlUWn727P1tSZMBHgIzAyiXZx7ImEXYeCgv2fUy1CQ68/+UQET3v1H
 6xBPL+rrZLa9rPSu564U2gSmpBWhReIrdmCxnqSCpeK0UV1fhA3wpZsuFU558GuwbzrZ0t85Xxw B4dqH8Rwrzg329w==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240209-alice-file-v5-4-a37886783025@google.com>
Subject: [PATCH v5 4/9] rust: cred: add Rust abstraction for `struct cred`
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
index cf8ebf619379..3a64c5022941 100644
--- a/rust/kernel/file.rs
+++ b/rust/kernel/file.rs
@@ -7,6 +7,7 @@
 
 use crate::{
     bindings,
+    cred::Credential,
     error::{code::*, Error, Result},
     types::{ARef, AlwaysRefCounted, Opaque},
 };
@@ -207,6 +208,18 @@ pub fn as_ptr(&self) -> *mut bindings::file {
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
2.43.0.687.g38aa6559b0-goog


