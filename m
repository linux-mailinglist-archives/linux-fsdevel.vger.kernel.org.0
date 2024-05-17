Return-Path: <linux-fsdevel+bounces-19646-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76ACE8C838F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2024 11:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C2E928286C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2024 09:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E926040BE2;
	Fri, 17 May 2024 09:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4mbyBZhH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f73.google.com (mail-lf1-f73.google.com [209.85.167.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771AE3D96A
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 May 2024 09:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715938304; cv=none; b=SgeuIbXuvuvMIGDTNH9r/FwSvJnNTf0lWyA0vCDpGJ1MA0rTy7yd8m+T7t22y+ZkUk45tvsEv071wTvIfmWdjgtkfUFjuEi2OPmalVOVmIO8z4G3S4QuC/Xmxn1MnmrPS9Ubga/Ia30JfTLUjaQ2gKaNZYVSG6xBhEvACkz0Gng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715938304; c=relaxed/simple;
	bh=O7eW32RK5FMclee3Nlw489v5va/erWNbHRKjhVU+QdI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=G09BP2oSJ9Rdk+emoQFExHBsiyEltRKubfyacb9wZnMXOLnltqtZ4mcL5DeHRSNoY8Buv+rnjgmO9DTrr/iaPDG4A/Pu9XLfb7ikeXmnXeUyDpCuFDaJkyseQ+adAEa41D1CiZYObO1N3f9n8Fg1MgEFhmUB7S/K1UDaPrRwuKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4mbyBZhH; arc=none smtp.client-ip=209.85.167.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-lf1-f73.google.com with SMTP id 2adb3069b0e04-52389b09bb6so3236715e87.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 May 2024 02:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715938300; x=1716543100; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OeUEDmczYkvZCSBa1m0ZBb+fLzryf361jdn5sgXxhlw=;
        b=4mbyBZhH+STVaDSg7xmgZUGnPflpBXSPE3v8WxKMIpxsGrveazkhGfaXFkVbGwmdBK
         Fm9uUsAAD5zRVgUt7O1sBxU2lBloA5kKqm2xw0zL2yjpy22cHBrHFi4KN/LLYzk8fMYS
         mTn6aiCyImdLxL4u5iqmq/vmSCm6Xma3KcuL0hLlv3nSCFes9Em2xXzau8ot8W7KNqnu
         ehP/mohu7zC3gL8ApmCkLwC4fUPZwJrY6x5Tg587IPIpaYXQdjHIPvahq/XEwQy3AvfO
         UBvTHJy6HsW7gdf59Oll/dvVe6l77RNd9HcOycHNOjCB3lpK68zHmKZS++mZh5zwsF6K
         /dLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715938300; x=1716543100;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OeUEDmczYkvZCSBa1m0ZBb+fLzryf361jdn5sgXxhlw=;
        b=kYHRuSI7tjeqRW4jbvyahxmyklYOLAx3TVIZS57kna4UcMgqa97PJ6Icd7MHIpNuH6
         OPXS9qxVR6NJxsvoUuhH25jmxdeprjMVhb3lgG69/E8XKRT9p0tCxiNDuzO5DQ4s3PV4
         eWUE3kZFR4WlV085423DhttT/ouSTTZuZd5TnMEZViZ1r3tX+xVqI3ifna4t36UvHwiC
         R5X11ROLoCav/JnPHzMSRS/TgfLEtLzoNo5Wvg/AaYWxgbkco9m+414Zs9SYv2rwCf+M
         kwYP+GxaYoFXCyVdwFKXOy0QomyCmEq/uF4MaSxhZ1TYN6GxryoNm+8RReXAacVKZVeW
         qkKA==
X-Forwarded-Encrypted: i=1; AJvYcCX/A1eeg1fLvc6WG+I6hNco6MDwvIIWb5ig1Rwgyohy3MzHABtbo+JWN8IsqzuouCh++wwlylQWGQI/fLIdU6cXbgUe7nGPruFdwLzNIg==
X-Gm-Message-State: AOJu0YxA9l5NhQ4txLwTIzZdgsq0Me5l0MPeOHcYs0KOWsYI89pzCnl/
	iPSKoB70edhQU6255qaIED8i+ciZSL9da+fzmQAUfPu+rbVPV69TRbHJe/1+AafEFDGNL9yfL2b
	BfxkUifxQLX6sLw==
X-Google-Smtp-Source: AGHT+IF9n+2yz0MfJeZHeqOtHK0sEAN/30xTRcxkYPuC1Cy74QryFxBUfBsviXYzXDEi9qpEToXvAY6fJ5D+ZBQ=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:6512:39d3:b0:519:2c84:2409 with SMTP
 id 2adb3069b0e04-52210069ba4mr24256e87.4.1715938299676; Fri, 17 May 2024
 02:31:39 -0700 (PDT)
Date: Fri, 17 May 2024 09:30:38 +0000
In-Reply-To: <20240517-alice-file-v6-0-b25bafdc9b97@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240517-alice-file-v6-0-b25bafdc9b97@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=6451; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=O7eW32RK5FMclee3Nlw489v5va/erWNbHRKjhVU+QdI=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmRyPmBSHV+7HBh3J44fzcR8jOrXqHMBve2i4aU
 ehVsJvHdTGJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZkcj5gAKCRAEWL7uWMY5
 RhcxEACq9InTBY73sPRRkpN/BM8RjQ/Gk4KPUb8pm2iehVHo/f82Z5jC4In4BUpuL3UqISOBljc
 I8Pyh9zmOkOUioFUW7z9kMiEG9yBFZrgPvIqstRdDhRZJ1ttpOYVcioZZ2xkDkXlgFX0I6DRnKQ
 nfwYW9GCfA3MBLEmtTZCckcjIxXZJuviII9dlwhyWNERMJHVwscuZiEr6L8WUFlb4Irn9bYpFC6
 175paKUOL6SDm1xCIzLeLhkBWOAh4OiGXP83JLpmlO85mFV0jvEtwOtzHBWvqstC1IbRxjfWxO5
 3h3J8G1sQuriW8xmkHlkrfrfgVwXOuXWdWhX4n29fDwxWqXxRWXM3dr+Tkj5+JLNRkeYxfIqH81
 DGSTMxi4rKLCL1b70gCpXSWH8/FFK5/aHp55of+ltnabLBPUTjBLm+647EmhYONm+UJg7fHynOj
 GmkQvC1NiWLmXjRkyEc67wrfWTPlE3Ujd39u+qpoi9SUQ9nhA0gxENKivBhYO1QuGvqs75gaQLk
 Mq8tMpUQhQX2m1LJOGC3uuXVlyu8au73kA7cmk8MKLV8xrRUaZF9ZrZ+8AChAD652M6LnPmtyp5
 6vg4UxOkvlBcK7KKDWezS+rCOgm5irziElLK+OCS8/BjBqimUp/k1wBH3Vu/BG8JFCbJEnSt6R1 zkO3qEhaDTCDN6Q==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240517-alice-file-v6-5-b25bafdc9b97@google.com>
Subject: [PATCH v6 5/8] rust: security: add abstraction for secctx
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
index 56415bce8af0..766e368bd0d8 100644
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
index cc629a74137f..ade5889c76b4 100644
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
2.45.0.rc1.225.g2a3ae87e7f-goog


