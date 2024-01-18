Return-Path: <linux-fsdevel+bounces-8256-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B012831B93
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jan 2024 15:39:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B2A1288C72
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jan 2024 14:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A1712D025;
	Thu, 18 Jan 2024 14:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lygnp1J/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DFF2C850
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jan 2024 14:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705588634; cv=none; b=rs+HLmDT7G+Oh7V6AnVs8oVFaxiYlMNrvxwV4y7zRKu8AZVyYEpdP/WcYrPNsvhNoH8qlaPEfCywclNfpV3+1VDdQKfNSyj7ztu0bR+wM2LyKFKYoCJoAHTYGde72YjRnXvTQlYB3JMSHl9grJDsZfBY7vowXg797jps8UfrF0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705588634; c=relaxed/simple;
	bh=iOTVc308M1nIqnqlnsbYAX42462qOIT+qeK5JAfUWBM=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Date:
	 In-Reply-To:Mime-Version:References:X-Developer-Key:
	 X-Developer-Signature:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=J5z7jozqHiAS1zTKRwu3G7Od9LDsBY1eoK0Yd8gq0Z7Ns6OKNunRDVW+VEIF3Uk6H0hX2Yh8Y1kMuHPtDAtwLbrX6hXGgFoL0/+dftzMllxanWkeAhavHYskwxKUbMoAyaKq+zTjPFuzX9Dcy/lXb/2jH73wLb/dC8LuDMR2zbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lygnp1J/; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5ff3172c669so73024097b3.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jan 2024 06:37:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705588632; x=1706193432; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yUOoP4whgKHdC0dBs+MNrfLiOAjtU4Hh4swg4JUqoYk=;
        b=lygnp1J/cK0uFErzwEfOEuuxvxBe20xUYZNTjxXsBg1g3E1CjHCgPpe56YPFlQuZFu
         m2G/pgmTtNul6SQb3LeThfaCiPjDR2YiHSGSZ/K5lQx3oe18musjgi3GzRVpEDqZS7K9
         4i6U7frm89l29iTMbeJLdC6IFHkjN0669+dG1DtfwFI7tuNWC8MKlhTl25I7rVeLrGoZ
         TyPU+Wh095bp/dXYlOi8fpVRdmYQQ1V7kEQ4JlveE5bfN1DJz9nuxKXo43scJdYOcqOx
         BhyRsYUiZdtJ6xGXfPSvQQKBJxM7D/7cG8Ss7T22wAdPemThF16BP3ILzSVfMW8IJjT7
         nrNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705588632; x=1706193432;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yUOoP4whgKHdC0dBs+MNrfLiOAjtU4Hh4swg4JUqoYk=;
        b=vB0y1vBCEKlhRVDxhq+xO0nY9Jrmd4lC0n9fWsYTDfk/YZGY86ues+7o7XJcTj0VLy
         bEpp6LNDFPTaoppaw+Xs2ZY3DJdr0QksrYAYogvfChIVJr/hBsH+yf7MNuoqZi7UZyLs
         4uvN8RdSegDOqVan/40ccbloSsCIfl0SND+z3ua7V73nQiursOE1Sc4WI1zEru6W7BMD
         opvLKbjewGhtyQjBQA7j6h/wOcE/gegLy8gg2Z5FYef+syv9p6DuvSgeXYbNlbl7cNVD
         f0WleWd2jghJKY9Y0ONrN/ezA9SVlMpWQGIYEPhx3REE4dC9CavKt3nUqNQTFlUqiUhj
         Kqiw==
X-Gm-Message-State: AOJu0YxYLV8tiwN3AJnJOJMX90VuhhH3I0EU530aImLrYNHgW2G9Tebo
	T4b+DksyCTpchkGZ0xKqMr1hOHzLlBEWFvnAZOs1iNdFyiUh56CrbUeRjEk9WK5VJQPNuwr1Rtb
	47fDpqAXTLRWUKQ==
X-Google-Smtp-Source: AGHT+IF7AlbMl5Bfna88C9qs0lXbdgHU4tptkokjW5MNWp8y11bkEAtk/jh9UOTG8iV7FL/49BYsOseK6Jgmmtg=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a25:f807:0:b0:dbe:a220:68f9 with SMTP id
 u7-20020a25f807000000b00dbea22068f9mr398828ybd.0.1705588632055; Thu, 18 Jan
 2024 06:37:12 -0800 (PST)
Date: Thu, 18 Jan 2024 14:36:48 +0000
In-Reply-To: <20240118-alice-file-v3-0-9694b6f9580c@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240118-alice-file-v3-0-9694b6f9580c@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=7816; i=aliceryhl@google.com;
 h=from:subject; bh=iOTVc308M1nIqnqlnsbYAX42462qOIT+qeK5JAfUWBM=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBlqTHP7dWmmun1RJa/jFe0TSW4BcGhSsZbxYjTg
 li7AUdjExCJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZakxzwAKCRAEWL7uWMY5
 RuGnEAChjbPR1FijqwPj+bzom4AGjLjPpstNi1duk++5Rs92pKVv/2UgIfS1ag1IplBT5fTGrDP
 zXedAWo34iBWSH/8yzG/Y7tF9dXYKk1tn5iAxXZhcXvR5VJS4+Cu2K7SrPWf6pmMfZe7vAJ94uc
 U4T4sx/Z0MJ2uSbuaUPplXu0mde5/g/WgsJtMZWAk2mblTG8tBcK65q5uetrHHEI6klAqM6METN
 EW06FgjfyDGYd1qY1Xjt0wx4zl/B3Tq7qNqZO0WcSIJ6/iCzJGCDDnej+bL1poJK3hb5Fhcmk41
 FLYs/5RU4infv4WsIKWA7zkrMI9RMrxQ+i2cSELfkbvQamGc3A1ic2ZI2ljmstdDcMy/4TQzwHp
 c1BpNsDaCnoIctXkDaeT9jW58jzOY+MBxdrqlcs/nHyvm2km2Hr9CmBFYu3g3FE46RfZoEjWnls
 O3hi7ptyuo3qTfEqU+4g14C+OS3Uh5RtFLn2UMoa69z2QAyaAIcua1jBpts4+pUEaQRVJK3xWdJ
 YyNgCBcscaLqC9VR9GD3ZDD6q4S7khZErqd/9Ue1YG1ubT6CAIGwa3X4+TpMiifIBGrAsj3nMuK
 EyRk8lqtjw8rsdhljg3EuRYRgy06Uo4ZqpQGTX8luEopW7N0Pc7tpvKvvIR2oQMuDOElN9TrVXz DutNsOMMUgSrERA==
X-Mailer: git-send-email 2.43.0.381.gb435a96ce8-goog
Message-ID: <20240118-alice-file-v3-7-9694b6f9580c@google.com>
Subject: [PATCH v3 7/9] rust: file: add `Kuid` wrapper
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
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/bindings/bindings_helper.h |  1 +
 rust/helpers.c                  | 45 ++++++++++++++++++++
 rust/kernel/cred.rs             |  5 ++-
 rust/kernel/task.rs             | 74 ++++++++++++++++++++++++++++++++-
 4 files changed, 122 insertions(+), 3 deletions(-)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 0e2a9b46459a..0499bbe3cdc5 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -11,6 +11,7 @@
 #include <linux/errname.h>
 #include <linux/file.h>
 #include <linux/fs.h>
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
index 8017525cf329..8320e271232d 100644
--- a/rust/kernel/cred.rs
+++ b/rust/kernel/cred.rs
@@ -8,6 +8,7 @@
 
 use crate::{
     bindings,
+    task::Kuid,
     types::{AlwaysRefCounted, Opaque},
 };
 
@@ -52,9 +53,9 @@ pub fn get_secid(&self) -> u32 {
     }
 
     /// Returns the effective UID of the given credential.
-    pub fn euid(&self) -> bindings::kuid_t {
+    pub fn euid(&self) -> Kuid {
         // SAFETY: By the type invariant, we know that `self.0` is valid.
-        unsafe { (*self.0.get()).euid }
+        Kuid::from_raw(unsafe { (*self.0.get()).euid })
     }
 }
 
diff --git a/rust/kernel/task.rs b/rust/kernel/task.rs
index 396fe8154832..17c02370869b 100644
--- a/rust/kernel/task.rs
+++ b/rust/kernel/task.rs
@@ -8,7 +8,11 @@
     bindings,
     types::{NotThreadSafe, Opaque},
 };
-use core::{ops::Deref, ptr};
+use core::{
+    cmp::{Eq, PartialEq},
+    ops::Deref,
+    ptr,
+};
 
 /// Returns the currently running task.
 #[macro_export]
@@ -81,6 +85,12 @@ unsafe impl Sync for Task {}
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
@@ -142,12 +152,34 @@ pub fn pid(&self) -> Pid {
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
+        let current = Task::current_raw();
+        // SAFETY: Calling `task_active_pid_ns` with the current task is always safe.
+        let namespace = unsafe { bindings::task_active_pid_ns(current) };
+        // SAFETY: We know that `self.0.get()` is valid by the type invariant, and the namespace
+        // pointer is not dangling since it points at this task's namespace.
+        unsafe { bindings::task_tgid_nr_ns(self.0.get(), namespace) }
+    }
+
     /// Wakes up the task.
     pub fn wake_up(&self) {
         // SAFETY: By the type invariant, we know that `self.0.get()` is non-null and valid.
@@ -157,6 +189,46 @@ pub fn wake_up(&self) {
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
2.43.0.381.gb435a96ce8-goog


