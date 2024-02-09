Return-Path: <linux-fsdevel+bounces-10928-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B3084F47D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 12:22:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B3DB2812EC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 11:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29BCE3D0DD;
	Fri,  9 Feb 2024 11:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U1/hEMt+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f202.google.com (mail-lj1-f202.google.com [209.85.208.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5FB3C46E
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Feb 2024 11:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707477552; cv=none; b=l6aRJ9wypQWKXCOlYikOI/CbDAO6xt4GCSTotn+ItkFy+XTVHRgqEHAOUiXKebEC92XrqcM9lvrZ34pM5M9Ee3anqC3DU6Ai1v9YYPZ8xGC+NGLtMp8/oc0w/JxP6QXWFTuu991aVgeuW90zpn+Qi+VJliirQzs+5y/LiloP4go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707477552; c=relaxed/simple;
	bh=E1buk0zzZWt+ClaaZ+b63yUoP42+YT0Qbdk1d5cyqEs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=T//yZYfavh+ICl0xRXYHqWz3K+h+pSFVcF5qUvAK1G2gd/yMsQOpIjLBHdOcsElLEMiTueLallDOGfBAmEmUcPxfk9NbVmJnvk9TOOl+HRnJDPrPe8v3NiqVcIHd//Zp3wKD99Od4UZTA3lVlCAsXB77fz71Dn5TVTGHXK11VhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U1/hEMt+; arc=none smtp.client-ip=209.85.208.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-lj1-f202.google.com with SMTP id 38308e7fff4ca-2d0be4e5cf2so8379721fa.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Feb 2024 03:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707477549; x=1708082349; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VdMtlvXSdpyuBlQLT4isky8KfbOQu099bwECdJmsAI8=;
        b=U1/hEMt+fyH24R0QU6b92lYfSv5xUPhKdUi+t65OwFvAY6xkoeHQ5n2+MpqmqEC45/
         ieDXnSqjH4x4iscsAQuabLs9seVQWmebMUw8NCiuoYe2sqJSZphd3qUSM1JXoytbuOBV
         ecsP+zbi6Qce8vL8YVkZmC+mnEuqwchmE7zW8g5bWFhW3HPRs0UYys1hzRFUsGPXAmr8
         YlwIMcImeSyD7UcXxwo6MHrfeNa2rA03V3WUwwJHsG8WMZwBV5g8/GdB85xzqmWKgSme
         7aniK5cmsa8vMNfdAUQe6HlRa80bM4HKUlXCLDRaJGuNBCcVKOUrXwfwNnh7vw0MhjPr
         zRBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707477549; x=1708082349;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VdMtlvXSdpyuBlQLT4isky8KfbOQu099bwECdJmsAI8=;
        b=KHqyTbiHpEbuDjpB8RxhQflAhPTbntZ3MV7nmdVvfEGBkQ1ASxfT61/9jp3Tmq9RYg
         DBbD3LDJeXPE2RV+QMxXvqgx9wY32ffu1ckAhr1WnugHRFPvxsuPz6Xz17H71wIsTjoN
         20kh+fhm68d2LHsFB+Mdc91qAOHeewLstY1s2PYRQIZDX1cVK93Fi1+gUSwNeMKvuP4Z
         NkjKxV8DlFQvaYfr7h+LzJdRNJih8OVvY1O+sTfvZnJAaUHIfiQkTJ9H0VD6chYEuKV9
         I5Qo6vh8VDoikeNKG/pE1Dt4Id4ia0lDqSTtbl8PCPL9hc4/Lz8L01ud/3SL/uVEqfQu
         jDYw==
X-Forwarded-Encrypted: i=1; AJvYcCXSjtaeDfFvR/t1wu81njJhG7gk+iGpfINrlQXH5vXozjuGy8K41nH2YH6HUbQqBdVEZYW2r2E8EaryqX0ruQFJrZTmUV0PlwFbrOpKDw==
X-Gm-Message-State: AOJu0YzLx6NrzB5K8I1x4i0HShxOHYcVUObN2qbLLboTzq+GV3qa6TEX
	SH/d2Sz3SELBV9dz3HTMlGgGy6JwmI3ja2z0SO7Eirdg6Fo9fuwkMCmQK41Zg1yJXjNeYLrmRor
	V1WLm6QB1NUbSKQ==
X-Google-Smtp-Source: AGHT+IHnRYPAoWbAMC+WZ+vqhhPrrFWco1EiFwfv2Uqa0rqOjoQ0lVzPQCeD2STSoOOKqJtmb40+YrokVd1rkC0=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:6512:36c1:b0:511:7c00:fb36 with SMTP
 id e1-20020a05651236c100b005117c00fb36mr111lfs.10.1707477548849; Fri, 09 Feb
 2024 03:19:08 -0800 (PST)
Date: Fri, 09 Feb 2024 11:18:20 +0000
In-Reply-To: <20240209-alice-file-v5-0-a37886783025@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240209-alice-file-v5-0-a37886783025@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=7824; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=E1buk0zzZWt+ClaaZ+b63yUoP42+YT0Qbdk1d5cyqEs=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBlxgoTxQ7fOeQVqeJHhvMo3R4TWUWv4Zre9VHmv
 1n6+dozzJiJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZcYKEwAKCRAEWL7uWMY5
 RoTID/9DrBtrSeP6a7LrW8zdrFLqeLQwwj3lFqnnNrTM5QW+TdfhVwnLMnRTGE0+zgC05ke+Gja
 CZmAOET4+/vTYR24qksd1KZsRj8jCgg5xlc+Mq1/t2A/x/CUP4+oArC9rX4YZK3777fVV1m1Ac0
 bLuMffDV9reg3o85hMLAjyxk3PBDGqN+OWHnjwdNYy0gsWHUMN170+74qr5xgJUfIcIJVTItP0M
 QG1JsSs6EbrwR+OBo/TchCNF6VLu5O0ZjC0yKqDQZdJfbs0aeqHGGi4tiyhxJX3FR2QYcH+MUGq
 vbGN4vPIy6dgVwHaClly3eBpi4vuCZiYXKEDbT9baigwQbZC/ZA1dwVMTVM5i2mikL1wg9HuSf6
 xo+/zXyqysdcRlK7WmTGOQQm9xL6VLcUMtw7cql35bKXsA/UoTOFVoHUum2oYiLy0KnXwcn+Vhh
 q9Xc99KnXgEqroKeTSbFbO0f27sGvLDgIVVKrputudqRtzI4RwOeY3z9BhcpPP+G0ubccGV8FO6
 nAcUENW/W3vAANq8eWdUGyMY7axO8w3ayfurOy2qNbMDmXUzIfjiq5G8xZ/K8IkzMkWbGjrlrWA
 xwzn1rpRENlTrg+ej6ywS506rraGmNyYseWQhal7cvOX72nz2GHsEu68IQqnlM5Lm6gl7lVeyFT D5PnyAJZebOT5YA==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240209-alice-file-v5-7-a37886783025@google.com>
Subject: [PATCH v5 7/9] rust: file: add `Kuid` wrapper
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
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Content-Type: text/plain; charset="utf-8"

Adds a wrapper around `kuid_t` called `Kuid`. This allows us to define
various operations on kuids such as equality and current_euid. It also
lets us provide conversions from kuid into userspace values.

Rust Binder needs these operations because it needs to compare kuids for
equality, and it needs to tell userspace about the pid and uid of
incoming transactions.

To read kuids from a `struct task_struct`, you must currently use
various #defines that perform the appropriate field access under an RCU
read lock. Currently, we do not have a Rust wrapper for rcu_read_lock,
which means that for this patch, there are two ways forward:

 1. Inline the methods into Rust code, and use __rcu_read_lock directly
    rather than the rcu_read_lock wrapper. This gives up lockdep for
    these usages of RCU.

 2. Wrap the various #defines in helpers and call the helpers from Rust.

This patch uses the second option. One possible disadvantage of the
second option is the possible introduction of speculation gadgets, but
as discussed in [1], the risk appears to be acceptable.

Of course, once a wrapper for rcu_read_lock is available, it is
preferable to use that over either of the two above approaches.

Link: https://lore.kernel.org/all/202312080947.674CD2DC7@keescook/ [1]
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/bindings/bindings_helper.h |  1 +
 rust/helpers.c                  | 45 ++++++++++++++++++++++++++++
 rust/kernel/cred.rs             |  5 ++--
 rust/kernel/task.rs             | 66 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 115 insertions(+), 2 deletions(-)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 5ca497d786f0..4194b057ef6b 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -15,6 +15,7 @@
 #include <linux/jiffies.h>
 #include <linux/mdio.h>
 #include <linux/phy.h>
+#include <linux/pid_namespace.h>
 #include <linux/security.h>
 #include <linux/slab.h>
 #include <linux/refcount.h>
diff --git a/rust/helpers.c b/rust/helpers.c
index fd633d9db79a..58e3a9dff349 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -142,6 +142,51 @@ void rust_helper_put_task_struct(struct task_struct *t)
 }
 EXPORT_SYMBOL_GPL(rust_helper_put_task_struct);
 
+kuid_t rust_helper_task_uid(struct task_struct *task)
+{
+	return task_uid(task);
+}
+EXPORT_SYMBOL_GPL(rust_helper_task_uid);
+
+kuid_t rust_helper_task_euid(struct task_struct *task)
+{
+	return task_euid(task);
+}
+EXPORT_SYMBOL_GPL(rust_helper_task_euid);
+
+#ifndef CONFIG_USER_NS
+uid_t rust_helper_from_kuid(struct user_namespace *to, kuid_t uid)
+{
+	return from_kuid(to, uid);
+}
+EXPORT_SYMBOL_GPL(rust_helper_from_kuid);
+#endif /* CONFIG_USER_NS */
+
+bool rust_helper_uid_eq(kuid_t left, kuid_t right)
+{
+	return uid_eq(left, right);
+}
+EXPORT_SYMBOL_GPL(rust_helper_uid_eq);
+
+kuid_t rust_helper_current_euid(void)
+{
+	return current_euid();
+}
+EXPORT_SYMBOL_GPL(rust_helper_current_euid);
+
+struct user_namespace *rust_helper_current_user_ns(void)
+{
+	return current_user_ns();
+}
+EXPORT_SYMBOL_GPL(rust_helper_current_user_ns);
+
+pid_t rust_helper_task_tgid_nr_ns(struct task_struct *tsk,
+				  struct pid_namespace *ns)
+{
+	return task_tgid_nr_ns(tsk, ns);
+}
+EXPORT_SYMBOL_GPL(rust_helper_task_tgid_nr_ns);
+
 struct kunit *rust_helper_kunit_get_current_test(void)
 {
 	return kunit_get_current_test();
diff --git a/rust/kernel/cred.rs b/rust/kernel/cred.rs
index fdd899040098..961e94b6a657 100644
--- a/rust/kernel/cred.rs
+++ b/rust/kernel/cred.rs
@@ -8,6 +8,7 @@
 
 use crate::{
     bindings,
+    task::Kuid,
     types::{AlwaysRefCounted, Opaque},
 };
 
@@ -59,11 +60,11 @@ pub fn get_secid(&self) -> u32 {
     }
 
     /// Returns the effective UID of the given credential.
-    pub fn euid(&self) -> bindings::kuid_t {
+    pub fn euid(&self) -> Kuid {
         // SAFETY: By the type invariant, we know that `self.0` is valid. Furthermore, the `euid`
         // field of a credential is never changed after initialization, so there is no potential
         // for data races.
-        unsafe { (*self.0.get()).euid }
+        Kuid::from_raw(unsafe { (*self.0.get()).euid })
     }
 }
 
diff --git a/rust/kernel/task.rs b/rust/kernel/task.rs
index b579367fb923..f46ea3ba9e8e 100644
--- a/rust/kernel/task.rs
+++ b/rust/kernel/task.rs
@@ -9,6 +9,7 @@
     types::{NotThreadSafe, Opaque},
 };
 use core::{
+    cmp::{Eq, PartialEq},
     ffi::{c_int, c_long, c_uint},
     ops::Deref,
     ptr,
@@ -96,6 +97,12 @@ unsafe impl Sync for Task {}
 /// The type of process identifiers (PIDs).
 type Pid = bindings::pid_t;
 
+/// The type of user identifiers (UIDs).
+#[derive(Copy, Clone)]
+pub struct Kuid {
+    kuid: bindings::kuid_t,
+}
+
 impl Task {
     /// Returns a raw pointer to the current task.
     ///
@@ -157,12 +164,31 @@ pub fn pid(&self) -> Pid {
         unsafe { *ptr::addr_of!((*self.0.get()).pid) }
     }
 
+    /// Returns the UID of the given task.
+    pub fn uid(&self) -> Kuid {
+        // SAFETY: By the type invariant, we know that `self.0` is valid.
+        Kuid::from_raw(unsafe { bindings::task_uid(self.0.get()) })
+    }
+
+    /// Returns the effective UID of the given task.
+    pub fn euid(&self) -> Kuid {
+        // SAFETY: By the type invariant, we know that `self.0` is valid.
+        Kuid::from_raw(unsafe { bindings::task_euid(self.0.get()) })
+    }
+
     /// Determines whether the given task has pending signals.
     pub fn signal_pending(&self) -> bool {
         // SAFETY: By the type invariant, we know that `self.0` is valid.
         unsafe { bindings::signal_pending(self.0.get()) != 0 }
     }
 
+    /// Returns the given task's pid in the current pid namespace.
+    pub fn pid_in_current_ns(&self) -> Pid {
+        // SAFETY: We know that `self.0.get()` is valid by the type invariant, and passing a null
+        // pointer as the namespace is correct for using the current namespace.
+        unsafe { bindings::task_tgid_nr_ns(self.0.get(), ptr::null_mut()) }
+    }
+
     /// Wakes up the task.
     pub fn wake_up(&self) {
         // SAFETY: By the type invariant, we know that `self.0.get()` is non-null and valid.
@@ -172,6 +198,46 @@ pub fn wake_up(&self) {
     }
 }
 
+impl Kuid {
+    /// Get the current euid.
+    #[inline]
+    pub fn current_euid() -> Kuid {
+        // SAFETY: Just an FFI call.
+        Self::from_raw(unsafe { bindings::current_euid() })
+    }
+
+    /// Create a `Kuid` given the raw C type.
+    #[inline]
+    pub fn from_raw(kuid: bindings::kuid_t) -> Self {
+        Self { kuid }
+    }
+
+    /// Turn this kuid into the raw C type.
+    #[inline]
+    pub fn into_raw(self) -> bindings::kuid_t {
+        self.kuid
+    }
+
+    /// Converts this kernel UID into a userspace UID.
+    ///
+    /// Uses the namespace of the current task.
+    #[inline]
+    pub fn into_uid_in_current_ns(self) -> bindings::uid_t {
+        // SAFETY: Just an FFI call.
+        unsafe { bindings::from_kuid(bindings::current_user_ns(), self.kuid) }
+    }
+}
+
+impl PartialEq for Kuid {
+    #[inline]
+    fn eq(&self, other: &Kuid) -> bool {
+        // SAFETY: Just an FFI call.
+        unsafe { bindings::uid_eq(self.kuid, other.kuid) }
+    }
+}
+
+impl Eq for Kuid {}
+
 // SAFETY: The type invariants guarantee that `Task` is always ref-counted.
 unsafe impl crate::types::AlwaysRefCounted for Task {
     fn inc_ref(&self) {

-- 
2.43.0.687.g38aa6559b0-goog


