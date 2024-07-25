Return-Path: <linux-fsdevel+bounces-24246-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1522393C427
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2024 16:29:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF74928617F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2024 14:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4096019E802;
	Thu, 25 Jul 2024 14:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iKkQ1BBm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C52519E7D3
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jul 2024 14:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721917679; cv=none; b=j8lCs9MkP91eiiNjxIg6VvprCoNDgPVqcXscj89gTKhIPUykgaPI/z+uA2ZhNO6iPRo90bqIvORjWqKiuDxOIvo3y3hb7KrtUAxwwClucPZ3jf1gWaopuD0tUYqcL38j8ljeTuJJV1Ls+1WbNejF8yaEa+cWJekliMRilzs7VJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721917679; c=relaxed/simple;
	bh=HmtNCDQtZJEcY5US8BaBhrhnETHRhDvmtsa9lhcqgio=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FZ5AiTulwf0oJCR/XUH4lBge72Pe/2Ijm9q7ggdhCzQLVivHtgGMoaFD61KRV1j79ozC1xCL+1rYWIleFvozb2YpSxaQCaSW3lS51jQ7i8cAwCDoakwqzRM62dd3+ijvBJoxB4YNh6d4J90WWYYmoXD7T4hYeLj3cq13lj/0v0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iKkQ1BBm; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e0b365efb6cso685531276.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jul 2024 07:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721917677; x=1722522477; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Lo+BlZEzCOkRMbq6aMOskHCZf8MM+d8fsOOsjAvEhzc=;
        b=iKkQ1BBmd1/XPKSY+0GAlkgcQMPq01pc+fLQERJASUpwYBIKHOeGdpPm1ZMqw13nHN
         REyZwbFC7H+8axFXacKuUksqn1B85W+TNw9Afh5K/HEcWqaSCUmae3I8tkKS/wHgR6FV
         EaHIWFsD+gvTqwem9XtYLI29o3AxVjYC0T6jmssqqEgJtLO9AqvaivsrO/QOm1FwjKT1
         nT1mEL+3GFFXOEHorH09JU5oxIV/ExvDPRGfWPwKuwB4taNCqvBbwiICyXfP8mRn3FNs
         UyfJu0G1WRFSw6AdueTo4aomifM0nt5O/G0IuXfv21FHEhQ+/nPJWdLf9tpoxXttUG53
         NwFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721917677; x=1722522477;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lo+BlZEzCOkRMbq6aMOskHCZf8MM+d8fsOOsjAvEhzc=;
        b=r5VbffyWzV/G1Zw2G6L87WSzWqPLCjjoH2xeXXxIcN90Zq898oTUaG0+5HRPIepl33
         qQ1DSC+4vEs3NFBTEWMpHdiOzPfFX+yn07BQ4wKwrpSb26rGFxSn/cynafgR710ZI4oQ
         DeeciUBrAp1jMlehZVU1RTIWQnqXDtKWfYhE6qvGENdLBEoypeRp46ztNz40Sxw/5/kd
         2HWzp1u3bKssDgAHNuIKMHzYnrjYt67Lkb1h5F/FFzE7phoEtA7N4U8pHmULqc+vf9XP
         Fbhvb87L09Ch861Hc7Z9BsXHOB9ewnxxeJKXX/PCz1vPOmhrWFA7thIDVw0s1QD2afR/
         VayA==
X-Forwarded-Encrypted: i=1; AJvYcCUL4wYsktKdiH2QlV3ELg+ppu84m3W3daKLBYS0yjznRxDg1EZWPw3aJeHILnnNBeMh6UIHk1VN0+1NcvgfhkPD5foufYEchxWFvSJ/pQ==
X-Gm-Message-State: AOJu0YxVWDu1IRZOqxJjqJNlMCmVKI7WXD+QPOMqTvVpqPjPa2is9O2t
	ihzyG8gFe3ftUNmwcAdw5Ry7dPYOmqufqv5nhRd7em090yj8zvBC+WK9nVXlTbHjXTfTn2RiGOc
	/faZ0u4IaEJxf4w==
X-Google-Smtp-Source: AGHT+IGZJ4LPfR/4zii7HUdx6c8AE09ty9AGdsgFOnmdLyZETBPRFMPmSfNYP2nDjKJVg57F2KbFo4WZCpUAF94=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a5b:4d1:0:b0:dfa:6ea5:c8d5 with SMTP id
 3f1490d57ef6-e0b2cd5cb98mr4535276.10.1721917676930; Thu, 25 Jul 2024 07:27:56
 -0700 (PDT)
Date: Thu, 25 Jul 2024 14:27:38 +0000
In-Reply-To: <20240725-alice-file-v8-0-55a2e80deaa8@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240725-alice-file-v8-0-55a2e80deaa8@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=6483; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=HmtNCDQtZJEcY5US8BaBhrhnETHRhDvmtsa9lhcqgio=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmomDZzwmAITfS7QqPxR40tSgrI9rFbAc+K3j8s
 5VoYaUV0OqJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZqJg2QAKCRAEWL7uWMY5
 Rh2REACKQNXwkZJxO/6/h2no6vzVb+zwAI+WAu9Hi/Afyyu0lAt9/iA3zbKFqdPilwV/iFcW+eu
 JGB7+Z88s27dKPkCvZovWKB9XJip209O7t77E74MVG8R/vbe67zeD2iq6ClnyhunvRT0oidVlwP
 IYsYe0Ne86md0nVX94MevPeeuxvlkZMX5qJ0yAx5wjmiUmnNlRq7sIHNXayaq1aetVgna4jYxa6
 NXFMNHNx2XUbv91MSUrOgnDiVJGvRKraO3/TpFhhTHUVO8MXrauujF8ILA0YR3OoaCxL67KrGZw
 EnUfAfpiaM40wfvwvEf2SARlMmuNMEXqlSTJNpSfTsoJQj9Ks5eYiaPY5uIBD7rgkho5Rgq/vap
 Xo/volWUhp6wA1qbeKWQvaK2YXz6BNpVIr59JXOnMJyhWHWwSrTP1XXJFvb+YRG4xtrfs7QWBdb
 HGhiKA9fi66iv2LHH5aHHyWGiImSRxcHf4QLot+Qgou+2myO9w2HaKxBMeJ13ZG4cTUAyPno73e
 sP1CSkdfOVLOKQ02yjcA2J5O0dcQvsWDuZGlYlOfcEVI/06xzsC3U1I5vgzbDGRGwpi6tz2LCg+
 Hz5Qc2El9EyM+T7JfSFNM5NNnD5KQ9NpwaS7fYE7aAdYQ1X0jqbuPgkin5rbxAUSpK9pOia0BoR gSdOk7rTwMUoI8w==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240725-alice-file-v8-5-55a2e80deaa8@google.com>
Subject: [PATCH v8 5/8] rust: security: add abstraction for secctx
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
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/bindings/bindings_helper.h |  1 +
 rust/helpers.c                  | 21 ++++++++++++
 rust/kernel/cred.rs             |  8 +++++
 rust/kernel/lib.rs              |  1 +
 rust/kernel/security.rs         | 74 +++++++++++++++++++++++++++++++++++++++++
 5 files changed, 105 insertions(+)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 22e62b3b34b0..afa24d54c1a0 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -17,6 +17,7 @@
 #include <linux/phy.h>
 #include <linux/refcount.h>
 #include <linux/sched.h>
+#include <linux/security.h>
 #include <linux/slab.h>
 #include <linux/wait.h>
 #include <linux/workqueue.h>
diff --git a/rust/helpers.c b/rust/helpers.c
index 4831abb5a438..b61f5a8ce1da 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -32,6 +32,7 @@
 #include <linux/mutex.h>
 #include <linux/refcount.h>
 #include <linux/sched/signal.h>
+#include <linux/security.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/wait.h>
@@ -219,6 +220,26 @@ void rust_helper_put_cred(const struct cred *cred)
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
index 8fb57ec20867..a8de8293376e 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -40,6 +40,7 @@
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
2.45.2.1089.g2a221341d9-goog


