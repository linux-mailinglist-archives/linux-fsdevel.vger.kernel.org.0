Return-Path: <linux-fsdevel+bounces-22788-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC0491C1E9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 16:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF5C21C232AC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 14:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 260281C9EB1;
	Fri, 28 Jun 2024 14:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nsHVRy40"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0771C8FD3
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Jun 2024 14:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719586683; cv=none; b=N9XaI/qg7rGTJq+cAwwkYloXofctVjj61KFJSI1ENMm0FUcspB3KgrPAWDV3vl04ul3SipCD4LrFh1SA380NZk/jFeIMRFzCr4Wt4KlKSBUHh1aFfwv2y0EbIAjBF12LWgz6YZq0odjZB15fwKsQagsJ92UZ7CwD+50PA7COL80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719586683; c=relaxed/simple;
	bh=SlqFSzKTXlCLM45RuGs1D6n4w52ysnBrvxDdEN5nqf0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZKUXNsmoMpiebBDO0L+r4ZSk68ELOq70AUhBWNB3JHFjpN2Yur5N+Jm1s8JVQpauBaCNwi+Rw78hIA2x/mjVxHNXkOjZpC6EQ3shKLKbAAir8Ogr3dEun2b18Lr2QM02puCkRDnEz3ij42POrlrWLv+4SzafSkj7byaQ5L0C8IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nsHVRy40; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dfdff0a9f26so1301459276.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Jun 2024 07:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719586681; x=1720191481; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SINMfHecFZOdGH/mJM+WIc9fBNelCPSpkZcr54GiFHk=;
        b=nsHVRy40lyq02cVTaPt3mtBmJJbuc8W7IltZmrr5COZjhsIlpx95eNUitFjsB4d5S+
         W1sbRMBWuz9d+lYVmU5A3IbaOFyc4VT0WJxxaE4ppP2FHPCXCi3h5RnIfsiKRznWCQKx
         +IFWZZgIQQG7ixDAXFO/x1JLxUAsWHxszk8+Y0CdeAvvRSNCzSwVHuRxTDLiSKVc/1g8
         kRsJCWBoi4UXbeQlNsPTqxGz/qol9G+WXp4J9Xg1MrQ/A1fopQgCzMct2tUk/YIcpjKg
         5pGVtRRrGfJTAd0b5oLn+EveIpwqKhvWoZz3fLoGwqfDS77XHN3S89p6EERUz0nonogJ
         RXXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719586681; x=1720191481;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SINMfHecFZOdGH/mJM+WIc9fBNelCPSpkZcr54GiFHk=;
        b=Zp+DlTxkOySSb6kGujR/UqQ2Xpg9s5v70E6IOmZOLcF+Z98CHKmiy4qU1OO6reR+aD
         xlo+r+eeEhvIKZowvr/FPLu0BZJiTY8HkmtrcFtoCg/Kj868Q7m95vWZxQ6wYVcBrdBV
         FES0PbQ50WXIQQl++gEAbomo+tsIcUdNkU4VGTWD9aXGNj+YoqVsodSlM+Frnr6ffSy1
         tikSOBrNbBBQGEGEm/Jtgpqw3lITI/VCwT0S2bJchB4dwX2V2AbPuzru6+zkFkFE86WI
         uaCAaBuDqsL7IbvkGmvEk5S7oTD7Po0bHijVIkqfwBbreseA/T50Bg352AphhfhVFiJj
         zHgQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9GDjT4CVIuZCWPH9o100imLg/EO7zGJEmAse0/FBHNoIiXmPOGxUIBDP7ithO0yjKlh/FN4zAe/beZ4c0FMV3A6d5gb0r5aHfFrEJ6w==
X-Gm-Message-State: AOJu0Yzb2XTItRzolycvizxyN55U06JG2u/j15T+BTA5u3P6qFNKYpED
	isdnZPLVBgH5NY4uDOQgWmxseDNIhqGcClKnUEU3qXh3XvuOWCJ1K3aCafyS1pFTu6ivmasm+De
	rrPocSPPvCKaBtg==
X-Google-Smtp-Source: AGHT+IG+viwqvXgSUt+FssvIzHj7/WggEatwMQjYCGulrBuqUMFYPHMjqAKPBzF/8zxtfjTW6dmdz6QTkqKrZGU=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:6902:c05:b0:e03:2f8e:9d81 with SMTP
 id 3f1490d57ef6-e032f8ea024mr18312276.0.1719586680992; Fri, 28 Jun 2024
 07:58:00 -0700 (PDT)
Date: Fri, 28 Jun 2024 14:57:18 +0000
In-Reply-To: <20240628-alice-file-v7-0-4d701f6335f3@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240628-alice-file-v7-0-4d701f6335f3@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=6442; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=SlqFSzKTXlCLM45RuGs1D6n4w52ysnBrvxDdEN5nqf0=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmfs9lqtDNb30DUajglMzWAG1mWxG06cE1X4H13
 p9Lb0dhc/qJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZn7PZQAKCRAEWL7uWMY5
 RnuZD/48E542L6X6hKdqsfcNV0bFqiV99n+9ZpxONN2UcoPlAQhtWTLvwM2Sc2w96ZQ7wvzoNzs
 ZABVdIaC8mpa1l+kdZznU7U35bafOW6ojwbgQXAs8i6+kuQXLshf8c7GOiXTUZp4f0hyNBCthSC
 zbhWLECDIFWR4pB5NGUUsbCiKEwWXRp5Jy+IOA2wZCJ2o7HOKkIx/gH3cGRgXbeponkQIOA7iYZ
 v/EAUKoJF4xd9hP7rZtK8mn94GW2/W1ULv9zfPqUjOCb7U1NMjM60g081lg2FaAoXqo5NTFDJtX
 N7MOJbUJtR5fTdb/qFLGfoE6rcClCYohr9YetTHb4hWdwm0LcMbjT/MkmU2sCB5BJPf7KTyDTJl
 g88BJVZciec9AWX+fIsr4d2K4dUvC5A2TGDFiPtP6QIRRqxAABvSQ2f4jOj1Vpl1wi+DC25vx20
 YSl7h5zywXyestJth966QWwi1UyPLwnfxAt/9PVUvyFIgQTGp2bsq/7uwqZtIFQXNACOFWaMC1h
 ZTHLbkQ6zXWTAelAyIcoAA2tdKdk+CcORDIDtMBnfnetP/LxpXKUKPgrwI50rm/RQnxkCe3EeaJ
 oBUNBC87QTBMGSYXYkSYO0TnpVLEyY42D7jqPWaWAhWoWRN/Q0mmB8XabZ1yVkH3Ipj8LC8MkqH 2X+R0aj3fT50t0w==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240628-alice-file-v7-5-4d701f6335f3@google.com>
Subject: [PATCH v7 5/8] rust: security: add abstraction for secctx
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
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>, Trevor Gross <tmgross@umich.edu>
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
 rust/kernel/security.rs         | 72 +++++++++++++++++++++++++++++++++++++++++
 5 files changed, 103 insertions(+)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 94091cb337e9..cd2aaaaf9214 100644
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
index 9cf25e5324a4..bd540a14c16a 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -30,6 +30,7 @@
 #include <linux/mutex.h>
 #include <linux/refcount.h>
 #include <linux/sched/signal.h>
+#include <linux/security.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/wait.h>
@@ -185,6 +186,26 @@ void rust_helper_put_cred(const struct cred *cred)
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
index 360d6fdbe5e7..fdd899040098 100644
--- a/rust/kernel/cred.rs
+++ b/rust/kernel/cred.rs
@@ -50,6 +50,14 @@ pub unsafe fn from_ptr<'a>(ptr: *const bindings::cred) -> &'a Credential {
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
index ea7d07f0e83d..d331ab8a65a1 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -39,6 +39,7 @@
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
2.45.2.803.g4e1b14247a-goog


