Return-Path: <linux-fsdevel+bounces-9993-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 247E8846E70
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 11:58:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48E6A1C26879
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 10:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C2A14198A;
	Fri,  2 Feb 2024 10:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C0uB5cDT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476E7140788
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Feb 2024 10:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706871369; cv=none; b=ldTguB/gTKSegMmEHoqCMqkwT94nyisGs/UVh4aFspO7v+J2zGfJ0Jh+MGQpwXTyy9Q0zoFLWoqQ0Njai7vyskA7q9wYC5sCxRn9TLhDDBvCtbjCiBdbRUNBmwNhugkr4DQfUuPgpO1M6Xe29Mi6RNTiPy/nS0NmqYIQ+9A8tC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706871369; c=relaxed/simple;
	bh=ckP4VcTWLY1vkut07zfIb8pSktRGGroqoRVYR3TM6VM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YacqpNhu7wkBz+hNbl7+yyt/+LDcxb22YfDru4dk/cMBURG7fRE5nr4dtZwtX9K/mH6lEG9W/gbVdJogKU9nYq7arx19Gxx4uLJNIuNfps0Vm3uOGSZAhgwt51d5yUW6Rxpkb6Gx0KaSzxueKGDLSP36bXC0ewOFwzaqfxMTXnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C0uB5cDT; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-604127be0a0so39090087b3.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 Feb 2024 02:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706871366; x=1707476166; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hwQz9+kg606GttZk5ufJHJgW1rtd9e3JGMr5cW0AGC8=;
        b=C0uB5cDTWm2ZgIHOu4JMmynHSnhaEVOt5LxODNEH6BW3WB9MuIiP31Zc+L/0oJk/VU
         mIVkNKuUR5RQzAvmzwHK9cm7TSzz4dGE8oR2zUw5RLW3ntNmAbp9S4VP+La4xfv7ieMC
         A8gt1yvPqMKqUgeqlwbCZXPoWzEMD4GJ3qJDveeKBQJ4fxLfDAXWrnxUPovMlpNO08uM
         Cb5GHOeYaowG5NypPTFaKv203WuAA7FVtHe2kLHcEgFviHRYR9aMx2coTBxZXVBQFYG8
         ZB9nehQICigWDdu9suxwEyLiuqQovH7Z/zCYovTybmPjIZizYNr5uhfmYNMf+PeZ+z1n
         b8/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706871366; x=1707476166;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hwQz9+kg606GttZk5ufJHJgW1rtd9e3JGMr5cW0AGC8=;
        b=WrFAR80dgYeMVDmVV8cndZITwT7j0tUEV0aGmFNJNhDeE5eYhFvcCJzroBy75Mxs4k
         EhZ8G9FuCFLbvmPDROVO5ju2IqSD8UZut559OCC4vQ/E5ewAoQFvzBD5DEzmMoAK8yeZ
         p8DmLdTmLeax2j9o+bQ29gjRYDODzKShoMETGpVrioSl5b60gmekEeuFmWLzSDebSoE4
         ncJtOJuTaMEbfWgBa7Q7xFR5euBrH9WvVzNhdyV0dLo019HBhV/QsQJFP2pzIlID3qyi
         H6gw+08IUVHUUJGDJhImyhPH/Mc6xeFqaOprnwmMlvAmpXKFZfrKyqJfndl0IiYv+7sw
         JPLw==
X-Gm-Message-State: AOJu0YyY0PmxuJyGgcjE8GdTs2or0wY0rWzcUvaD8wXQEBw4YjjkVAaB
	LE9HEbkbLJD7YkHfhY56dn9+n3Dwd6vTl5rScjw8rzptJjsML+0YgIpT5so+jn7s3s4JjsOQniu
	ocmDzeD6gDDvqwg==
X-Google-Smtp-Source: AGHT+IEnEG9QtFqefbOWNcaw5O3UTsLc8QTrZuEBDh3LvQhlQ0wpT/uwrdEL3td4WjYPtUXCgvJf7t63fD+YPuU=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a81:7905:0:b0:604:1dc3:122c with SMTP id
 u5-20020a817905000000b006041dc3122cmr980062ywc.5.1706871366353; Fri, 02 Feb
 2024 02:56:06 -0800 (PST)
Date: Fri,  2 Feb 2024 10:55:41 +0000
In-Reply-To: <20240202-alice-file-v4-0-fc9c2080663b@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240202-alice-file-v4-0-fc9c2080663b@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=7944; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=ckP4VcTWLY1vkut07zfIb8pSktRGGroqoRVYR3TM6VM=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBlvMjJZ/XE8S05EXGfpUiuaCzlMjesUC2ggCLEA
 w2FnJkMZ+eJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZbzIyQAKCRAEWL7uWMY5
 RqqcEAChQ+pN8RIm1l+be6QscJCR4mIR93Y84zjg8C+iyPSRL6wgKOHbeXRXEiIw8Ddgb+XZ6W2
 JUicZJiBYWWqYzT/7waYhBHR++87ZB7Fwk19ksty2D0BOJ6hIxYfqZLafKU6se7tVtfFw2kmMR0
 KYPgEGmoWewD/d5rnvASKPZeOL5kuSidBqzTbB+xgUPp0skdf2nyOTzU93K8ck0vTDLzp47v+uV
 fTQvYlGwBEdS0ugFwdBP2Dsx0qdNY0UG5+oFOIPqw7x0Krr5Ph2Wk2hOVyzzK0K5LdNSMBRM3a2
 D7tNU0t8VbjUmyPUXmUsEGL2RIh3L8AApYQiCy1qhqwLvFZRWnDQlVe+Rvvlob+RbvZE0wqzAjE
 PIuEJDYVUFYTCcEkmy2wE18gbEC0Ws2B7nVbf2C73Y3RDHQ7r4HOlir6XWGAWkaqxRGIFlQI+hk
 kmlIs8aWyq/R+h1E+6S3psBp9phnDiV5ALPNqw3cgC3zvOlpUGTsWhfAkTxd3X8wFtr2qRIb4P9
 xi0fNEBgRxTZoewcV64AZOrvXNu0BmgGTdbnrv50ragr3nmIe9VKq/9X1Tr9HWv+8E+XsUXYp7u
 TT8+Eq8z2wf0hRcC12ZTNRbBpp10my+vtCLDZvZto59DB0cyFTtX+VYMb9dwYaWpGoBZGxr9UED O7wMh+D7A2+0Dvg==
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240202-alice-file-v4-7-fc9c2080663b@google.com>
Subject: [PATCH v4 7/9] rust: file: add `Kuid` wrapper
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
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/bindings/bindings_helper.h |  1 +
 rust/helpers.c                  | 45 +++++++++++++++++++++
 rust/kernel/cred.rs             |  5 ++-
 rust/kernel/task.rs             | 69 +++++++++++++++++++++++++++++++++
 4 files changed, 118 insertions(+), 2 deletions(-)

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
index 0640356a8c29..b80276d68247 100644
--- a/rust/kernel/cred.rs
+++ b/rust/kernel/cred.rs
@@ -8,6 +8,7 @@
 
 use crate::{
     bindings,
+    task::Kuid,
     types::{AlwaysRefCounted, Opaque},
 };
 
@@ -57,11 +58,11 @@ pub fn get_secid(&self) -> u32 {
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
index b579367fb923..7d59cf69ea8a 100644
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
@@ -157,12 +164,34 @@ pub fn pid(&self) -> Pid {
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
@@ -172,6 +201,46 @@ pub fn wake_up(&self) {
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
2.43.0.594.gd9cf4e227d-goog


