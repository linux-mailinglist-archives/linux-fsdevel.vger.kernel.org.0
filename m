Return-Path: <linux-fsdevel+bounces-24248-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D405893C42B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2024 16:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EB4DB21582
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2024 14:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6308E19EEDC;
	Thu, 25 Jul 2024 14:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CKX2ZRj3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1627D19EEBE
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jul 2024 14:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721917685; cv=none; b=Nmv60TmUXam1jGylKPEtJnr3pL6GuSb+OxJ4+ChdQJI862nxBf127F1U5GNM5SpwXSbHyxQsFgl/+6gcIHhSKQ0xI02zfqM/HetygAkb9ToxbVi42dEZQHL4TzCqRnSlpvxeRi/Hvw6gdptAktbt0Q64f0/HacVhPMNMafjyYxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721917685; c=relaxed/simple;
	bh=RB5fUBvZmSdvq9L2nU1k9qW9nGCScm08ZZQbKJ0RktQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MAdf45s59HNrV4APCrzLSlJjDFh04f+gT3ODedkGxKkBZG63iqFql2xUeilIGSlOFSWAKMJGaCN/wpT/aS+EN5fjA5g7wGXogUFkLY5kTYvtMFQ4OO7VWEpYfq3DZ1CmgYvOCgJ5EAoONwQQrnBiqmgyheeHFHD0uO4CfDalPcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CKX2ZRj3; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e087ed145caso1673126276.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jul 2024 07:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721917683; x=1722522483; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Csn7tQLa+mrAk7iBu1tCNWUYbx+LRw9b+4+GLxKr0hU=;
        b=CKX2ZRj3byGEUc+a0wgYwyGRnh6NEyLZ0stzN5BrIxRK1dLN2nKNfqUyIjW1Z0+Cn9
         ZM+VZoxBcXAS4MYMOP4BvBiFro+sN5XGNp6IEII0sZcBxrO8INFdDkf5ZM00GU9DUXS+
         HypMUQvpwwSixq99oIZxBhXA5MAg5D8OjykuzKMovHPFeJsBarh/YBRa2NtAP8MkBCaO
         I2Hvw4spa3gllV+IAXDhdRrl6OGHHuacuMG2mMDX4ddDXnD1w1Y3vpIxzCtcK8RSMVZ5
         Vw4Lf4iFjJpbtcT2PCBQNk9oJbkAjeGwDjvc415qAGik3t2lPXCE4Fi6TvJdGTAlzs/q
         5bhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721917683; x=1722522483;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Csn7tQLa+mrAk7iBu1tCNWUYbx+LRw9b+4+GLxKr0hU=;
        b=vbYtgDzOIGu22vGdK/j5uasu/SYzOfXzg8eg5v8h29DZYpPIEVELKKguh7QLVmrVcE
         y9sQEUO9VAHJwuqfMnEvyf2cGI59G4bFCEezFdSE5gMVtjeLH5L0oZ9w5WUPCMQPNVw7
         QLPm8JoAsbH4dlul9cDyAwyIUJyd+ZgETVNkGnm0yCPbAkV4fXpwVktXB2n9OBgIrsH0
         me3k/iiN7Fl5ojI3TMakMaTuXIRTOwOI1ywYCln2THx/8fIRus6HSzG+Xs48qUXYkbVH
         kAD5kOs3BQt+cMOgotWmzYwbbX3kEcH1Zyg8RKXJu1SUBYNT3GR5Y6mfr2hoT2wncq3a
         ghVw==
X-Forwarded-Encrypted: i=1; AJvYcCXehtDGSfXB39mJpbGRzajs2WTuOXcAqlfqJiyMjt42IHR6K8f/Wu7a+FCBxVJrb1aJz4nZXlsGGX6HtC2JHFnN5QPbvPF4j0YqoaBUdg==
X-Gm-Message-State: AOJu0YzfsZUHScgwe4L8+eJDmFXlEPNpU5BPsN9Y/n8sMQbMS3EHUw+7
	5ugejdQwxnqEd/Q1A/YuB3k+EIYA1gU5G6mLo0gqY3l5E67d7iJFQERCWnICu8I5ahChpuBANYy
	Kig7c0a6L6AYhdw==
X-Google-Smtp-Source: AGHT+IHjNiBkce9Y7Rv3UU9G6zAWhyh0d+Nn04+di2Sll0COttEUFIpU+KZRv/R01wGbE+M/hI3INLySw+7m21I=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:6902:102a:b0:e0b:f93:fe8c with SMTP
 id 3f1490d57ef6-e0b2c6be3b5mr15445276.0.1721917683034; Thu, 25 Jul 2024
 07:28:03 -0700 (PDT)
Date: Thu, 25 Jul 2024 14:27:40 +0000
In-Reply-To: <20240725-alice-file-v8-0-55a2e80deaa8@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240725-alice-file-v8-0-55a2e80deaa8@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=7801; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=RB5fUBvZmSdvq9L2nU1k9qW9nGCScm08ZZQbKJ0RktQ=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmomDaOQy9H0VLTzKJjZ/FuWud6hd1PQ7N6BO8z
 8pE96uPnGeJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZqJg2gAKCRAEWL7uWMY5
 RuxHD/4zpGDFqB27kn/0o5xChNX4DpxWRUQBKkUD+mcWn0oGEB9ZqACT8c11EtSJwlvzs8XFEnN
 FqW8PiQtH0BphOw0sXgxHTPN17gQbqyOWT6fZmUSNCqRtEyZcsIdVxlnZgFyK3812vvB9UDrgOx
 RRhk9jx3p1FW8QtfMwB/wlnmprjGRTt+OqwtulWiwkz9lg3R+Mnl7jjLQXBXcrGSWuaG5xb///S
 Ggb7RiRyhlFa5Vp3K9PffT2LZVphAN0ZiRYGTmPiQFfKygfAGqVUUXljthkEbilJpWuBQQ4Xeuy
 gy8SgZ1Hrtl0Q2IP9cEA6YoLXlHGgCZJXjGq2P0SSV9SSLYwnrYKAOOqhcRRb/5lKez+1lvgCsW
 0biBJNCiF5sEjPtSQgKWA6THJNWhnzJ5W8jyq4n915qIWOC49PSqsJmC8mx/Gpy+kKxv8PY6RmC
 KuBkwfqbliqWSa5nAmsPy/KEfqvbbBiRkKIRbBD7mff3IiXeghgLI69i+z1jC4l0xjBKIyh0kwX
 yTA3i7hnLaCJcx33bfn2UKQTGDoWWYIkIf2Bl+7FcuekeDavI/eN1yRbbKJr+m0APNiOn+fUK7F
 q7J7dPZHygsc7575XFynm3oVIbgcYUCpQ28S2g2NSMEzZzt3enU6fmmu2D88xGjBuid/5AbYdhX JMNwhfXM4wqwBVg==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240725-alice-file-v8-7-55a2e80deaa8@google.com>
Subject: [PATCH v8 7/8] rust: file: add `Kuid` wrapper
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
index afa24d54c1a0..d7f7ae109e6f 100644
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
index b61f5a8ce1da..dda7d26ccf8f 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -177,6 +177,51 @@ void rust_helper_put_task_struct(struct task_struct *t)
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
index 92659649e932..81d67789b16f 100644
--- a/rust/kernel/cred.rs
+++ b/rust/kernel/cred.rs
@@ -10,6 +10,7 @@
 
 use crate::{
     bindings,
+    task::Kuid,
     types::{AlwaysRefCounted, Opaque},
 };
 
@@ -61,11 +62,11 @@ pub fn get_secid(&self) -> u32 {
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
2.45.2.1089.g2a221341d9-goog


