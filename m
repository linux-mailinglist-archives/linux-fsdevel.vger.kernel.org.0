Return-Path: <linux-fsdevel+bounces-10926-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F78884F47A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 12:21:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9D961F240A9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 11:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62ED7381AA;
	Fri,  9 Feb 2024 11:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g6OIXAg3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C452E400
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Feb 2024 11:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707477547; cv=none; b=Bx15knPuewdVkGB/Ocn2EcNP2adESMn8pR9hXIOJHSBi/8IQDNPl1Zs8UOqq2o7rQUsfK8p39a9nzu24R/HkUYEbcsr8XR9hGzzyxjjMKbdaT5lL0kzMimSRMHq1cpOXs5clVZh4Xsmj1aqW8zIUjE0IpfLUo1q7/k0EXfCR5lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707477547; c=relaxed/simple;
	bh=JMsIaHhJXFHUUWu3yyeKAXmjMagByT5pUYTSUjzRo54=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bDzxTtYT0rVD3rgFPn7tZ5PJvf1u6nNWrGzh/FHtLmmwq2QeSC4/MTwld/LCEzQ6mTob26OcmPZA20i17tOI3Cv4WhafdCBu4l8Mh/1OhZ7EsX37sI1a3SuL1TH8MkOxgv2dNpGMfD9Mkf9dWgr80717dpcY0cYXmjPiSLk9OUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g6OIXAg3; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc74897c041so1122852276.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Feb 2024 03:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707477543; x=1708082343; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=N6zYzDocV9Qhlicntw8rLmKyg1TDcaEgd7JNHcXSwhg=;
        b=g6OIXAg3wHu/7YUa1U/CGpqVfac34vYbBOtMiVPZDPG06iMKKesqy3W7vEMQdO753P
         OWzG1HqZ0ddUUIPyG7kSir6bHDzB2cwiCWqp75rodl45VDZFT4gOaXMnVaDXvte/CK9b
         ayRGlfnoAeZheW9vy/neNodNUektYmDP8NO/j+iWXlzIuwasSITn0+NptCO5Ys/52Bk2
         JD7+ExngMcelYPETWAAmQEgNLzNoDjzLKvrl/sCkbrLmGssT1oQUBFdVkYUCfxkdVyTs
         KzmUw9gJmZgQQibUvaXmKCek6zNDzaqn5FHdHKK6I5mXaxmjeRLnQRd0bqQoa+cfVj42
         Ya5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707477543; x=1708082343;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N6zYzDocV9Qhlicntw8rLmKyg1TDcaEgd7JNHcXSwhg=;
        b=IDP8Xnz65WUSvrmj3RNy/qi19vzkuNGxaaSvS2fQVKR3Cw+1Y6ictOg2twJCsnpek3
         50S5Pvl5CGUKl0V6Vl/nYmY1EpGeHhi2pqY/VLdyWll9QdiLtnSBpObApH/FUlhcrX/l
         zYsb9QFvmoalosoV2+1S0VpEl5UWS8EiYuL3ZmXuWOCgpAPHsAg0dVOfGjmaPyjn6OrR
         FyPg3d3ZRmIDfuQBFxtU5HiFCDH5banyMvpefnftZH7lFhDmK+1IXnK3a95/oXVFlXCq
         sx+mFSJDGKFc2O2toMmYk4slF2K9RdQ4PPfRn5G+G4/YrArGRVU6XXwRtCUOeA63mWtC
         4o+w==
X-Gm-Message-State: AOJu0YxL7dyuAY393X9mfgleTMPuQkWG0kM2RI4z6lEcgGYQCoaWaZrH
	1H+/GPzmC46uCKtnnRnL1qyRcwe8p+KcKceDxgEZQPwgNMuZObI4YSN+C0g3LDPyKWEOGl5tow1
	pPD4ul+lvSHFEJg==
X-Google-Smtp-Source: AGHT+IFg5C3amRznmPg4rq3iPXwTSu3C06n39NVHkjoPY1TcaXFdfZeVC1Pu+jnZiruN0GF5n08eL8bg2mOzMGA=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:6902:1004:b0:dc7:3189:4e75 with SMTP
 id w4-20020a056902100400b00dc731894e75mr18645ybt.3.1707477543307; Fri, 09 Feb
 2024 03:19:03 -0800 (PST)
Date: Fri, 09 Feb 2024 11:18:18 +0000
In-Reply-To: <20240209-alice-file-v5-0-a37886783025@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240209-alice-file-v5-0-a37886783025@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=6444; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=JMsIaHhJXFHUUWu3yyeKAXmjMagByT5pUYTSUjzRo54=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBlxgoS6Bl6o/Gc13YOU7SZw4BO7f0q+SLSNyZw2
 c03VNDoUq+JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZcYKEgAKCRAEWL7uWMY5
 RtbXD/9SpVOukf20wD3Lw87sf+QOlVl4wKCvVksht02nEFck15Jq9lBGWB85P/VDxzNwvNYVFjm
 Y5DNk9Gjo38nqA2ISJBdUn5PRONTd6c/6D/sxwmSsWwwYMyW/1DfrEyniql9ATz7twTo5SDG0qv
 olUGwCmGJzenMA7rqUBkkI2cmsFnZmTV+HrcN3z89Qq2Ftwdu9Nd8wwkitOQizW0P5TDH7ZlHvt
 Jw1Tmc57E9Me7k2F2oPlnEzaXKBXHm6dm7RQX8tnDI4tr2ohz81lGXjZjWVJR40ZTfv9XtvK3N2
 8o7YD3uFWrW0Facera6I6wmZQcCPBnBHfEpQpxLuNNrgjOkgm5HaRUKMjKk3r67B7n1VhD58LEU
 qMS8DHGngzMFLTpMVLt1O14hdR/6dJiZFKIIwC0VK6lttv6lSVIFMdpjgwMi19YeYIblP9Z5WDJ
 HBf2LdD4rFr7a3GH3Y6FRocdQ5/8cjVQa2C76C8XFQYBemIDAbRM0nS1Xg4aSYEbFpN1mvohDDs
 062FJ7Ao7kbGM1rtND9HXnrhpo3quUnyP15jdL+a4hJpks6w0fxOaOpiKPles1qgVVU5pcIfh8l
 pQFm418ktkJhnNrd6KthgBv70AlbiEBQjGF4KUEfhhxBTJu/Mxrp67/ED6Bg1YtoHwSL6lUT28C mcih4vpjTnWaIOQ==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240209-alice-file-v5-5-a37886783025@google.com>
Subject: [PATCH v5 5/9] rust: security: add abstraction for secctx
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
2.43.0.687.g38aa6559b0-goog


