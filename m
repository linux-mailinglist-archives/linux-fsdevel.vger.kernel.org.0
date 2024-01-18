Return-Path: <linux-fsdevel+bounces-8251-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08DFE831B80
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jan 2024 15:37:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA5D7286A09
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jan 2024 14:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0152628DC8;
	Thu, 18 Jan 2024 14:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HzzfvKRl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f74.google.com (mail-lf1-f74.google.com [209.85.167.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27B028DA6
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jan 2024 14:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705588621; cv=none; b=sZlHx+p8NhWOLg8S0zzd43qy7eOH1DoDSMZ6xphPQ6LjJDEhrvz/SA/GXVBwTUCoA+bQuipzbqehtUlexpKEKtUEc8WPCrj3UsT3VTtHWecwZQ3tHzp0lTU9ZFMkpM42mftnxSUJv7KrJqDIQS5eHS1ln/X4ISZu0NwAAwRTeGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705588621; c=relaxed/simple;
	bh=MCMPThk4qCeVKqs9KplV/1i671aQDaqWF1Xo9etvmF4=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Date:
	 In-Reply-To:Mime-Version:References:X-Developer-Key:
	 X-Developer-Signature:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=Wvp8TclAXL/FrGzenqSD2hwAzp34PbZ/j3qjFtgM1xpURS9WrBoRgZbH0ZgG3wrh3uOk+ZzMZdnV5jj8an4Z86vDBGn9FH+fOiInB8w23Z8RrkqFtryCVDWmwTr0qTUZYj4ImhvPsT3VM/pHMuXp7qnMnrCQUHXKOyyonZz8dug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HzzfvKRl; arc=none smtp.client-ip=209.85.167.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-lf1-f74.google.com with SMTP id 2adb3069b0e04-50edc80b859so5861780e87.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jan 2024 06:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705588618; x=1706193418; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MPT3y0cclopsYFKSwknUSvd4eXQiBoVC6AuAC2YQuxc=;
        b=HzzfvKRlysr6kaZ/E/yu1nOcQOS5Al3n2CdWIRS9FQjapZLQwb4j+s79HLirhl8SgP
         fT/qtattMmQphNw4g3ZpXcNM2rvNzQ3Xnc2y+jj1tx1cs0JDjApk+XSLfrjx5fag/SRp
         oPb16iFuNHHO1Eou1fYk61OE/pphFq/XVMZUfSj3p+RCVy7uOC8bJvnQxLWa4tIxbHme
         Z6P6Mo8ybpWCoi3kcodnLL5hsIgJfjhDNdrYcTdD537Q/6qhnJzjRVOnV76OAJnzJtzX
         EgGIHcMX5koxIzGCPalOPGYm7jy1v2X2/RDMAAxiZuEUWevc/tLisMT1wRmDE42a/R0a
         1PlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705588618; x=1706193418;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MPT3y0cclopsYFKSwknUSvd4eXQiBoVC6AuAC2YQuxc=;
        b=iHlfYnDnAb6joHibdVbS+3S7jUmwfzrzRmfuLmk8AxhaHRiLyNCWlJ70p3JjSrPGm5
         347tEeGVfQOAVTgrt4MSBX99Oi5EqQQPgNbWQULKoosv5oZ8oDqtEBHyslgb+SNVCCB+
         kuXH9XlHfw7cHyOCed6pv1nAfO8L1K9nJjk+fUJXCZanZiCDgqQMrOAxRZbbqCl/Vq9e
         KPueqzZkIngt+QIhJBVgbNMriE1e7PirXyAVRw0W7F4QzyaZq/ahOXJVn+qyDRz/rRUo
         Ez7BNIIgs+Q4SrPMpACClXKAA6oTNxUuTXTHTTvesFMBx0mEC10p/YBWXvGCb/nupQPM
         f0QQ==
X-Gm-Message-State: AOJu0YwmbcqulaEgUcaMmVwvvKYKbJPRpSXFZv2vXXtC3n6sPZP16jZE
	nVNwAFeEMlGeUPVyVxx9gdbLWwoK4ztWzHXcMKTbVpC/W/5Ns8KtBKNu/l0pjqmFtYxx+wmlyx6
	Vi1UC3X3mBuHgbA==
X-Google-Smtp-Source: AGHT+IHNe2EEDlg0f4RKJpD+oVfBsTnP5g6SAGLAx20Z/1RfhogWQYI/gTdeTfpHeyDwqNPo28wTiDhVV55bpRA=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:ac2:58d1:0:b0:50e:25d6:6d9b with SMTP id
 u17-20020ac258d1000000b0050e25d66d9bmr1971lfo.3.1705588617887; Thu, 18 Jan
 2024 06:36:57 -0800 (PST)
Date: Thu, 18 Jan 2024 14:36:43 +0000
In-Reply-To: <20240118-alice-file-v3-0-9694b6f9580c@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240118-alice-file-v3-0-9694b6f9580c@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=6615; i=aliceryhl@google.com;
 h=from:subject; bh=tCyuNgFn7TPQHklagxldT/6Bs98ZKp1WEpROGS6P6do=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBlqTHPuDEa2yZ2CfHTWr2PsWx0sUDCwwoG2AdRK
 nuNDDGfgdaJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZakxzwAKCRAEWL7uWMY5
 RgGGD/4+t8eiDahntx4ytpXdbz1iSH4578O3lrGZw5WIjj70MLassPy0ZdUycwGerPd1lJ8dYhk
 yoT+AXbWRRKO/F/MdoG9XLIrZDP9Pt3140eBP82uRifD3bGTZCmvvz6wUp2daYsuTlarxLRKRib
 bqIKgCbXdipIs9gh6ZT3C6PuebKW2suobjzQpt9rDNjYQD9vHErj4Ww3b9jFGERBY6ZEB7Ay3by
 w/zZIt/zx9ABROQ21BWPHJygxfWp7oG2Rrg0CuFX26eqtOwbRO9Tn8jkXXtqTU6TxM9W1Q8pGmx
 r9cDxnMYvKRJ4TX/GqB33cVUrEfQWsBk6JJn5kiVh8CasT7LZVcfhK89BzXE4ez0dNuFyIJHg+F
 G1qf2dOrjfqGyfLIhxlnEyXG0L6k1VVMqtn+gDdQHHQeQIFuYsRojwuG+XAExwXHxy8bNB+3BbO
 JQKQbfRApvFnjIJ+IHEqRQ/Xyxyto3EB/KZ2TaEj25Jt5uq2iyq+Q3HMD+5AHAPUdtMzsrn188j
 tPO0WSyKZFsDhSAhe0J2nrTW56f/nlNK3B7cmBdkHemcAkwwzl3eslk6cS85rH42Qk2p5DMJx1S
 MHjdkG3W9z0WnJYE50aL0vRZvR/UrvuH9h1Gc7smL09a2xrZ9C+qYQ1A9BB4L9jVruVlgPjtHmv 8/QP1wNVpciQZAA==
X-Mailer: git-send-email 2.43.0.381.gb435a96ce8-goog
Message-ID: <20240118-alice-file-v3-2-9694b6f9580c@google.com>
Subject: [PATCH v3 2/9] rust: cred: add Rust abstraction for `struct cred`
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Peter Zijlstra <peterz@infradead.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>
Cc: Dan Williams <dan.j.williams@intel.com>, Kees Cook <keescook@chromium.org>, 
	Matthew Wilcox <willy@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
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
 rust/helpers.c                  | 13 +++++++
 rust/kernel/cred.rs             | 65 +++++++++++++++++++++++++++++++++
 rust/kernel/file.rs             | 13 +++++++
 rust/kernel/lib.rs              |  1 +
 5 files changed, 93 insertions(+)
 create mode 100644 rust/kernel/cred.rs

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index ed06970d789a..fb7d4b0b0554 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -7,6 +7,7 @@
  */
 
 #include <kunit/test.h>
+#include <linux/cred.h>
 #include <linux/errname.h>
 #include <linux/file.h>
 #include <linux/fs.h>
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
index 000000000000..ccec77242dfd
--- /dev/null
+++ b/rust/kernel/cred.rs
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Credentials management.
+//!
+//! C header: [`include/linux/cred.h`](../../../../include/linux/cred.h)
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
+/// # Invariants
+///
+/// Instances of this type are always ref-counted, that is, a call to `get_cred` ensures that the
+/// allocation remains valid at least until the matching call to `put_cred`.
+#[repr(transparent)]
+pub struct Credential(Opaque<bindings::cred>);
+
+// SAFETY: By design, the only way to access a `Credential` is via an immutable reference or an
+// `ARef`. This means that the only situation in which a `Credential` can be accessed mutably is
+// when the refcount drops to zero and the destructor runs. It is safe for that to happen on any
+// thread, so it is ok for this type to be `Send`.
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
+        // SAFETY: By the type invariant, we know that `self.0` is valid.
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
index b7ded0cdd063..a2ee9d82fc8c 100644
--- a/rust/kernel/file.rs
+++ b/rust/kernel/file.rs
@@ -7,6 +7,7 @@
 
 use crate::{
     bindings,
+    cred::Credential,
     error::{code::*, Error, Result},
     types::{ARef, AlwaysRefCounted, Opaque},
 };
@@ -204,6 +205,18 @@ pub fn as_ptr(&self) -> *mut bindings::file {
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
index ce9abceab784..097fe9bb93ed 100644
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
2.43.0.381.gb435a96ce8-goog


