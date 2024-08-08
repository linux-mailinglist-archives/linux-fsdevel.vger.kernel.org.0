Return-Path: <linux-fsdevel+bounces-25437-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E9AA694C274
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 18:18:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 543AAB25BA1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 16:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7495E191F8E;
	Thu,  8 Aug 2024 16:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fubBfQ/8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078551917D8
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Aug 2024 16:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723133803; cv=none; b=XsfIcsTZOoQwmuEbhQUzEgfI/ZsC3r8rDJeC2Wkh6LOOGhY8TPXFEFcxsJMTHCOrU/E7r/y6fmjsOYC7MUUk0jOrAGAMoNcp5DrT30oeo7HP7rge2tqCx8vX9DZ7bK8LlsfazWWaEI5EIm5JakjfgN1zOdvPvBa4GXlTa7SpxAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723133803; c=relaxed/simple;
	bh=kttW6yHl82uT5ekK2jF2YDz8Rlxi4B1EZgxWc/6TqKI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DkbHZDMKueiIibYtmYSDVap/q8KfSsDx24jOm8VKoKBTkyMe8MqAYpCP/K5a7mlvU2lwxgLil/N4vYjPKQDsm3F9IYgs/DnqszexvMPphVL4XcEVZKp3oS/exaV84tGf2PIhGdSyGAUzyuhg4YkAhamBIGQOHuOeN583GUYS/GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fubBfQ/8; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-36848f30d39so659654f8f.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Aug 2024 09:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723133799; x=1723738599; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HGyDKpg8dWFcTag4GrpDLhvTdGbzYWU8UjhfeFFZm3Y=;
        b=fubBfQ/8WT7C4uhWyoupeige9q0zWGn+0ZvESa4L+vLohtErKzjT9wkOzsCobCzY9G
         coNLyE5kMXm804f/bcInLZY3Z5SESm3GWytE9nVa5V5dAKNimxku0+v6Eg1kT05KhDuB
         1h2rou3ckM8kzBIINFYX/sbaJH81qGlprMzuvzsbddVxWYwXL/ddNPqRVSB6IEXas/dO
         c5behaCKmrQHUhzCGNy02ieIzM8W/q6PGD3lz2e5R8pZ45eBD27PJdsfVatzl7zQy+i6
         HKVO0U/cDAfyhz1lxK9ju7RTrnuXFg3Y1HJVqLVB37bLAiSuq/VOg6SHvIZ/55mr49gH
         Gn9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723133799; x=1723738599;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HGyDKpg8dWFcTag4GrpDLhvTdGbzYWU8UjhfeFFZm3Y=;
        b=dsQTHaRHoP7H+PqOJcLLl8gQLKXhkh/Yv88dIyUYTq9Cjls35Zzo8TGa99fQiGQynV
         P+DTGN/OeaRwbfTnqyVCA2L0xe7siTQKcnX90o6sJuip4zEp9RH5SexKxM1CwYKiBL1H
         99hGdwehD+ScX2AM1WiHUPurnKLWkdnl9YUmYxHW7U05l0PWbM2Xd2+yf5Gq9CzbCEtz
         FHbPiEoLLAMKUTtNDVf77ynOWXAX/MClK4oD6EC+JJpWNxHWRrqsaJtyRIhBw2s47snm
         fqNvBidEUV/iVgRIooqhZKv+H3rDQnPN12Qzpz7JlTpDOljsm41PxaJvEzjg7MA3gjuI
         gNeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgc/vQi+Bk3NLDyNPIz4wZmtT7bQFQ5y34AX+30bTMUUG/cyosTVMeyjbSrMO3J7xLw4Ytcjgf95TpHpnMhO2LGh/5hScYJT/ZZUrAwQ==
X-Gm-Message-State: AOJu0YynDvdnbKemjt90gclol2EbOxRaqsxJCrTdH1y44iZEXR3pbhPv
	kJhnSjXp0k5uSasztOtap73xvpzliGnYbUvTK6OaAVuOVqJTP/3Bsju8EPsFYm+yxF0YP70z/V/
	cNsJE/73wgeG9ag==
X-Google-Smtp-Source: AGHT+IFTbpduCzC6100J98UmjYSjMkmd+3oWEiNvbe43MFSzynKfaqqeC0f3JVOpkPQMRdxY7Xws+Gauxia+0QU=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:35bd])
 (user=aliceryhl job=sendgmr) by 2002:adf:eed1:0:b0:367:326a:d74 with SMTP id
 ffacd0b85a97d-36d27581a6fmr3348f8f.12.1723133799093; Thu, 08 Aug 2024
 09:16:39 -0700 (PDT)
Date: Thu, 08 Aug 2024 16:15:47 +0000
In-Reply-To: <20240808-alice-file-v9-0-2cb7b934e0e1@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240808-alice-file-v9-0-2cb7b934e0e1@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=7305; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=LUr04YqufJkZXc462uNrCvjGvd9bTLfFksx5H6DRsjc=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmtO9XJ+/XGpnowA/6HESbnFbLf8XNjj3z4IPwG
 852GLKcSRyJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZrTvVwAKCRAEWL7uWMY5
 RnfBD/wK2KV0yCbgPozS1Ka4SfARilLOmaMqqgnFbD8qaY8oJufJH4BVMwN/MncTAn8VZNWX4Ig
 NDKykgJhOuLEkPOlVtyHAa8dsSH9pndmMrEe2uN8IAT6IMXGR3jqro/Hougw3xLTLC1Jwhcdu66
 3PmMBYaC9mJrNvBx5MKR63o0yhEwFuSwQcgXTbegheHPTpemh/cr5ziSOyUABrz+ajOR7UT5nJy
 ILOF3Ftx3n5/DiCmx7Dt5tjuh0tliuaAym4xrYzyO7dl5k13r/547HWe9bRgqSV2ySPYL069D44
 o312tiOKOZm7gE4Gh1rfpgNh/lpOa95kfezu1gvZN2AWeEq7Tcl3ijlaosWZgWG07aqivuogEbi
 Yp1kJjGQt0XTU5k5PcXKKsYjwt/menjwJJWKnIeiLcv/IUHsgWrHlLXwXIXfb2hbDnGeyhCSqf4
 Vrik7QzBFaLiMsQCcBcGsoTq5vhWmx5M1qPyNFkbicBLlyCBapAKISYDQ/nGGEvw5AC5sAdy5vP
 nyR8r0/nJ2L1gocRwsY3ViWvYXGLgiQpb0WZiZdTW/fDUtiTGqI00qHnCRfMZbZTMzCCo09xf0z
 aO5SLG/zZEbkLkHDYugUACORzSeZCIxN29nsemjs5qmqvM5OSpSlRxkYYG+ltSG1b2VBnSazdtK EM5jrAxBnRT8ZOA==
X-Mailer: b4 0.13.0
Message-ID: <20240808-alice-file-v9-4-2cb7b934e0e1@google.com>
Subject: [PATCH v9 4/8] rust: cred: add Rust abstraction for `struct cred`
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
Reviewed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/bindings/bindings_helper.h |  1 +
 rust/helpers.c                  | 13 +++++++
 rust/kernel/cred.rs             | 76 +++++++++++++++++++++++++++++++++++++++++
 rust/kernel/fs/file.rs          | 13 +++++++
 rust/kernel/lib.rs              |  1 +
 5 files changed, 104 insertions(+)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 550a4a46d413..81bd1c2db7c9 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -10,6 +10,7 @@
 #include <linux/blk_types.h>
 #include <linux/blk-mq.h>
 #include <linux/blkdev.h>
+#include <linux/cred.h>
 #include <linux/errname.h>
 #include <linux/ethtool.h>
 #include <linux/file.h>
diff --git a/rust/helpers.c b/rust/helpers.c
index 80021b0a7c63..a63f6b614725 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -23,6 +23,7 @@
 #include <kunit/test-bug.h>
 #include <linux/bug.h>
 #include <linux/build_bug.h>
+#include <linux/cred.h>
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/errname.h>
@@ -207,6 +208,18 @@ struct file *rust_helper_get_file(struct file *f)
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
index 61e0dd4ded78..c9ce44812d21 100644
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
2.46.0.rc2.264.g509ed76dc8-goog


