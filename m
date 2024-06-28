Return-Path: <linux-fsdevel+bounces-22790-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD2C91C1EE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 17:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD5A31C23A24
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 15:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07DAB1CCCA1;
	Fri, 28 Jun 2024 14:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GjCHXVPX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f202.google.com (mail-lj1-f202.google.com [209.85.208.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1281C2335
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Jun 2024 14:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719586690; cv=none; b=XtKAH41eI3+fPJEUOdE/6pGlQ33MjmRLYw8RjBCogzLnpAlzJZSm0ZnKM38QAkkuqvGJWq/B99Jj3u1eGzsBPSi8GVf10w/jUTGJu/pzdk6dwHgpHd4uROAfJHC0SZ41EkT7ZNgsAd10A9FkYp23zbyZrSYyO8KtRR4KMlGT6NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719586690; c=relaxed/simple;
	bh=4tR1Tb2PZrUq+fv9lruTNhnntanNRjg+gXhQBblAAjk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UKJ+DS75Y6YgpFqV2vWRKzyFwNBljH0kluBXRK70EW3bmdEPbEaibyx0FQvGKTzLzGcwxxvI7BUu3ESkE0stSzYtllubsPqc8t3kfgyxVjc2QJpRvYMDDr41vTEtp1uPsoHjAw2FZ60RcxEN/a7QMg79vz9aWGrkPdK9uQ0Jcxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GjCHXVPX; arc=none smtp.client-ip=209.85.208.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-lj1-f202.google.com with SMTP id 38308e7fff4ca-2ec62945d79so5658091fa.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Jun 2024 07:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719586687; x=1720191487; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=O5PJlOq7HcFoFVe0LT6WNAuvIuna6RAcnvVT9tdXfGM=;
        b=GjCHXVPXd9DDV2tcueBl42w+mjL1DbIy8QHKDfAtIsrH3rFlCBl17ga+rEwYguJZir
         MCDw9neZ0G65fQ/hnPhFRUm7bWtbatyGd6TJhV57T1/IDrCpWOVz/Zr0oqCluHdeuYwH
         giIYgTES3V8SD6PN1n1Nsx6LtYnL1AXxFYxPV36bZ3FoQehaOSgBCz8HJQ8+kp9onnWA
         A06M/bAmuHb1gYr+blutM+rM4PeROFElLsdsRpvGRcmtSV1DWfFB/+LzFUkr0Q7moSDq
         dFYtVbMJyoAurTfzB3Uii+FEPehe/dR1YqZUNvohR9gPF0YgT+CZ4XiKVBTV0E8vT1gn
         x40g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719586687; x=1720191487;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O5PJlOq7HcFoFVe0LT6WNAuvIuna6RAcnvVT9tdXfGM=;
        b=wEi1JpkUBABovoUxKQt/l7oR1JZ32oD4FprXsxbFbMWEcamxvbkhk82sukwMiDYlQy
         oQ2Z61pA0Q+NX1D4UGj2JS5OrqTkHYYCE6Ul7SL3Afr5S5Vs+YL/kEd42W6H0kGKKZKw
         ZxI0AlKaHeGVJeOG4xivMCIUuzh+aP+ZEJNpbj0riLJoSk1JnGSy5xLGynmvXhc+JrTP
         4wlQqDsHXGev/PcHT7LlAuVFycr7Hq13XMmXji62pRcix0yJZaPFXqbKIcUpT/DEHic+
         azgFhkG+p0n+2vadpEIS2EokTSzcPETLJrj47dihyaK1mBeDGXG4kVSBbCq1iLJe+sQD
         Mmqg==
X-Forwarded-Encrypted: i=1; AJvYcCUrwWSpqpZeN21sbuFFbpfK+kL8dFCFZ5Vg85uB8Y9SH6uFsm/G5O8kZoZR97Y/twaG9Md604f5LnapaSlpt9d9mcqVDo01fpSTGs8lvQ==
X-Gm-Message-State: AOJu0YwYCXd3vQve+RH5J5y3/QdpqkZaZxtMTEJe3mtYxkH9QHpUwhK/
	cCSRhxBSJAu3jWTAwfV3WJo30jZNGZ4+DCioA709SUuXMlKsjAfVWgzrhl3YZoixB83Ojn1mH+x
	bXQ2LQHryssikEQ==
X-Google-Smtp-Source: AGHT+IEoXEOqi3W+oD8p+3vtCms7RuonarfRac6u23iUARnH5OtZxnXL9a/5qWMf2SNC/+l3FJrQ/hucYK4uOZY=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a2e:a4b3:0:b0:2ee:4c66:8df5 with SMTP id
 38308e7fff4ca-2ee53cb0ff8mr22921fa.5.1719586686610; Fri, 28 Jun 2024 07:58:06
 -0700 (PDT)
Date: Fri, 28 Jun 2024 14:57:20 +0000
In-Reply-To: <20240628-alice-file-v7-0-4d701f6335f3@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240628-alice-file-v7-0-4d701f6335f3@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=7798; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=4tR1Tb2PZrUq+fv9lruTNhnntanNRjg+gXhQBblAAjk=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmfs9mgEoruPgE2YOjt1LFeFD+rh8aqrqNATeFO
 7IhNosJ8qWJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZn7PZgAKCRAEWL7uWMY5
 RmMUD/0ZhGTWkccBgZsIhFkclejW0gVD2qpGREocRrPaRln/w+IXeTumBjfoYVZQ0zsdQoD7CTP
 Rm1/2+rntB7gwXpi7zvBFekZIf0YBxoY0o5qBOeN2+HtexLJboaihK4CYIadeCQhuLCYqYYf+Qy
 g8qYkRwRXv+Uf3nr+21YoyIktO0/hBS220mPTFM+/p+S4FynAHcM5dQML0UnTH/Bv92JAtZwrMu
 4FuBQySuxAqXArlChejFvc9yit3/gOCIV7sNDwvL/LKMOFMBBh7oqQK6lZfciqtk4dZXGrxa2oX
 oFhtVY0ybIupVgJrbveRP18g3Gp+0HoINY8YZ9Gg+M/hakt4sev3Pnu2UOozdt4wy7080WrpTn7
 Eq/7Kx2m9JmTA7Wse0js5S/fKpYZHRwibIQAK99P4XLX5MyboIN9FxEjnW8LNOxYBZBMVbtqtRr
 l21rIZ5wzJiofRvhwJFuwY4MNm6YvPZp9skHDbK8QBe417Sh6U6BXzOxRoPCEWAZi1NKQSiz9vR
 WaDyIHtkK4SxPNUqaer6bPC3K90BVbgzzJZscXNM/r7TcUQWD8ndbHgO+mccOLyaQQXnibgAX42
 tvCBstkU0T0tTRq3VONWjDDzHNmg/9RQhGBko1OP4ORveg0od0js+lwRzaSGZfN6xpHfXNEKiKW 6Uw/8/Dx+IxSPaQ==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240628-alice-file-v7-7-4d701f6335f3@google.com>
Subject: [PATCH v7 7/8] rust: file: add `Kuid` wrapper
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
Reviewed-by: Trevor Gross <tmgross@umich.edu>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/bindings/bindings_helper.h |  1 +
 rust/helpers.c                  | 45 ++++++++++++++++++++++++++++
 rust/kernel/cred.rs             |  5 ++--
 rust/kernel/task.rs             | 66 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 115 insertions(+), 2 deletions(-)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index cd2aaaaf9214..2a758930fc74 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -15,6 +15,7 @@
 #include <linux/jiffies.h>
 #include <linux/mdio.h>
 #include <linux/phy.h>
+#include <linux/pid_namespace.h>
 #include <linux/refcount.h>
 #include <linux/sched.h>
 #include <linux/security.h>
diff --git a/rust/helpers.c b/rust/helpers.c
index bd540a14c16a..60b4e2adbcd9 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -143,6 +143,51 @@ void rust_helper_put_task_struct(struct task_struct *t)
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
index 367b4bbddd9f..1a36a9f19368 100644
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
@@ -184,3 +210,43 @@ unsafe fn dec_ref(obj: ptr::NonNull<Self>) {
         unsafe { bindings::put_task_struct(obj.cast().as_ptr()) }
     }
 }
+
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

-- 
2.45.2.803.g4e1b14247a-goog


