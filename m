Return-Path: <linux-fsdevel+bounces-9991-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C16A6846E6C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 11:57:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45A8EB28A87
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 10:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD4DB13F019;
	Fri,  2 Feb 2024 10:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qLqtGd5q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3B913EFF1
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Feb 2024 10:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706871363; cv=none; b=SV/ppFlfMNNdc5gaoG6EDFncq3xxRhER/CjWNHhAUcIDm5yNTNGa8WNnix8b6XnrJnxTqBeL+XeplDChIWzllqRsRR1FC06UheNYfHR4AjehfkvBL0FpgLVRsx7sfNfwUZOXuDIaQ+HYeTyyF9aKIBdnfKwTk6PWdgz0WzwDw/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706871363; c=relaxed/simple;
	bh=LAKcJY6R7fk8wuf3FdVFNOskSEsABniFk3E+zDxpTYA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=i8lc1lC3K3EeoodVuGSkebopMHXkHFlu9LW7zot1rW1yA42YGS5EZ31TqShVWu+UwGpBPajLO5ce9oar9i6jLB5a4Ra11p8cGL35waGiDkT8eniQvsN6JmeTJQVH68LHXSxhbqiwYOXa4aIa9L8xvKPtsMv6OutH9WmVAnJYN/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qLqtGd5q; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b26845cdso3457984276.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 Feb 2024 02:56:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706871360; x=1707476160; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=N/cEy1eL/l/XNVoA+dLHaLRQMYmmdCYyUSwII431DqQ=;
        b=qLqtGd5q+9Vt67M12OaNuLmEbjzVIx+CmdnnCfv/v6R9DdAv9OQPP7wLdPIWCCLAvX
         qk9HGMWDCasO1x9rNXwCCoTsXbdjN3azltQzbEJnI0d/4Fae+bOggIOGRt5NAnS+ifE2
         5IJZ+lK4jRMTXFTUexjTSGyoC5FNYbMClpMl50gmy/jP0an1ZD9u01l3e4bowT6nJ2H6
         nRhRc6gLJLHMiedm8j1VnDwF8k3XDWkYfoOOIHyAI6T5WtsexACJmA031LAwF1/cUpEa
         4UUdgjoGchaODyr692Cdvcd6vwRdr6bCnZ2as5+NFicpiMzYdFS7iaO1shIrR1Jc/EPA
         naHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706871360; x=1707476160;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N/cEy1eL/l/XNVoA+dLHaLRQMYmmdCYyUSwII431DqQ=;
        b=I9Ha9T5XWj+e/tPuOXMsLGiqlDCW2cvncgZ6zk32lwCOk7hny65bMJFG6szvehRARz
         7V6xIw80zt1L/MWW4B8Rl4/LKTn02Gi39sLyPnulXXa0jAe0DgKIlV38/KvDYFksG3TL
         A92GbV++xlEgVH9eFMtTaVz+vwB6jdvdhtt1+hqhuDALgNOItOEAsbPw0kXrrVXgy1wF
         LaT5FGOyYo2r3f1sD4FleQHhF3KOHtnXkeMTTQEiUtjcQOLZMcY0ETWhCWK3aBeGovh1
         OF8hCfFssrglSTr5RfWSF/WfJPUgGzyRuj0afgrsHgssGNGFA6nSET0b8fhS24tO1aTp
         yNbA==
X-Gm-Message-State: AOJu0YzBgUDc9bdKsENieJr17G4RDeOThFyv2l7fqcvdLv/qqJUzWGVL
	b+AEwQoNcvMwh5a5pY5Hy6FQdiZLgbtRgx5J4WPwTJ92dvXHtUdx2HXkeiL80RVLb5T0Qmi77oa
	IfZlEZ+ui7fwy+A==
X-Google-Smtp-Source: AGHT+IHGWDsppd3u5BR+vMpT1OVny20PjdzIDKyoOIJeefj0Lg20ELLZHW3EwJtKcV0OqsP82bXRcmd6fucdXUk=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:6902:108e:b0:dbd:b165:441 with SMTP
 id v14-20020a056902108e00b00dbdb1650441mr505685ybu.0.1706871360496; Fri, 02
 Feb 2024 02:56:00 -0800 (PST)
Date: Fri,  2 Feb 2024 10:55:39 +0000
In-Reply-To: <20240202-alice-file-v4-0-fc9c2080663b@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240202-alice-file-v4-0-fc9c2080663b@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=6367; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=LAKcJY6R7fk8wuf3FdVFNOskSEsABniFk3E+zDxpTYA=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBlvMjJDLWaBObEUkm/vJdm8vQJA/wX9vGKDjqW9
 /at096sPU+JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZbzIyQAKCRAEWL7uWMY5
 Rou1EACWIY6SndO4eyAbK86sp6UNQjtZ8uyPav+PwM/ipkr9RAskcCYz2fIsoyiYlBEC3g39+BY
 cXPs5MvP4YA+vze3qBBnSfX6FBp3VB6p2FJpwEltRdhQ4/ryThht6Ji7UA0FyD2OtcvvD4+KJ8d
 GNjK4haBwvbTUS3ia8HSGmwaX85QiyR/YpUt683Y1vCd0eU/PlOrRYXgtPvKqdWibdUrRpfOt+c
 ciTN9lOgbgBvUCJWTKO4v64p1eAnoemMsU6jrAMp6AyCCjcdzs066y7gmAYqQE1Qh1iBl5Mt9OU
 7Mt03V49vTV+4vPeKkq9wVefoXHrEZOvf/rADw89dqqd31VS30ldHS4BnWGWXVnM5XJXU7eycyW
 fydQ++WqeaOF2bMSvs92VxM3LSqyFf6AfnrVNooHAfASfsUIT3Jp8ajGXJXvfXmgUBaU5WXz7Il
 NmUTpwOJSGccHILnkzJI+dh/mXf/M8X1xb7/E7N8LHZndnJ0QOxgtKebuEWPKpm/0iDWok7tXGG
 5dh7txZAq7ZRYgaVjRsg+BmElA/b5s865Ptz7EX10xPaVYpslbrfOE+3M3sQmO2zJ+ubLiE8WPD
 vQLys3PlDJxRvYWfFntquWD+FsnO3aBe32FszwqFGGRD4F0ZuNaWYu1yDXzsZd16RV1akKwSc2F o7onX77ur4pqzaQ==
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240202-alice-file-v4-5-fc9c2080663b@google.com>
Subject: [PATCH v4 5/9] rust: security: add abstraction for secctx
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

Adds an abstraction for viewing the string representation of a security
context.

This is needed by Rust Binder because it has feature where a process can
view the string representation of the security context for incoming
transactions. The process can use that to authenticate incoming
transactions, and since the feature is provided by the kernel, the
process can trust that the security context is legitimate.

Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/bindings/bindings_helper.h |  1 +
 rust/helpers.c                  | 21 ++++++++++
 rust/kernel/cred.rs             |  8 ++++
 rust/kernel/lib.rs              |  1 +
 rust/kernel/security.rs         | 72 +++++++++++++++++++++++++++++++++
 5 files changed, 103 insertions(+)
 create mode 100644 rust/kernel/security.rs

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 84a56e8b6b67..5ca497d786f0 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -15,6 +15,7 @@
 #include <linux/jiffies.h>
 #include <linux/mdio.h>
 #include <linux/phy.h>
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
index fabc50e48c9e..0640356a8c29 100644
--- a/rust/kernel/cred.rs
+++ b/rust/kernel/cred.rs
@@ -48,6 +48,14 @@ pub unsafe fn from_ptr<'a>(ptr: *const bindings::cred) -> &'a Credential {
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
index f65e5978f807..d55d065642f0 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -44,6 +44,7 @@
 pub mod net;
 pub mod prelude;
 pub mod print;
+pub mod security;
 mod static_assert;
 #[doc(hidden)]
 pub mod std_vendor;
diff --git a/rust/kernel/security.rs b/rust/kernel/security.rs
new file mode 100644
index 000000000000..ee2ef0385bae
--- /dev/null
+++ b/rust/kernel/security.rs
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0
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
2.43.0.594.gd9cf4e227d-goog


