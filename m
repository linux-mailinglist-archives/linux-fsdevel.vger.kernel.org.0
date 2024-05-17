Return-Path: <linux-fsdevel+bounces-19648-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 397378C8392
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2024 11:33:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55E201C20A06
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2024 09:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A430D4644E;
	Fri, 17 May 2024 09:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ib2PkVQ0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DF542062
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 May 2024 09:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715938308; cv=none; b=anHxL9oYB01JPBhAxXUsNgV+qvwBj6SEDXGokbiph0fCJ+9NxivpiANKMbFn1RUE9KBsbTLzZD6v9SCiceCtoj0x9qJD1NUrIGc7Zvo2K6+AokXpktALuNjdohS4KPxhIQxdC6jsf//GyaKPy3SEm0YVIQ/DIvXietw8e8s1F04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715938308; c=relaxed/simple;
	bh=hHgNs/eNjM/gQTzn0cb1KWlAOn3yVPjoVCjoZEFxi8E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LqumS49H4LI2Us9L92eDZ+CZbXqedRS4XSRA9V1Pa7roJQ7XU8PGMQMzr2g8pvqZMxcY9PtKfMeuMe1glsGe+i1vqKUyUjCTbo6d6qZYeXpmXi3JxWUehY3Rbdd0/ciwNQg8DEMNGOc9WMgvnljIo8kTuiBVHibfxAl2/JDpUlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ib2PkVQ0; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6dbdcfd39so17009218276.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 May 2024 02:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715938305; x=1716543105; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XE8ec4HI4i4vHVAKUdw8kX8hncL/QXmy4k2UIUxwxZM=;
        b=ib2PkVQ0L6ScZgCxoL8wnKrJK63swG3+NlA6qAI5dOlgQlAMpstiitU48W3PKcxkPE
         y0mda9YJIbFxB7aeFaZijTu+GcGO66fhlLVb5q8XvawdaO1mVNJiMouBdqqhfl1MKwO6
         Fi+0yjJf5nzpiArO4TaFtgrXXKU1wyRf/FnmEGFL+hg4mRsrFTcffcEvpIGrTaV01Zxj
         mOplHbYsSP5B/JFcyAsK+TTthO1YrFh8WLKX4YwnErByFfoXp9xzqoE1f3HuCLFYlRbg
         Ne+absBMu8edMyNn79vyCIllg3ptPgfACvhxSghlq3jtBrMKVnS2wpOxjMveB9W8y/Yl
         WIvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715938305; x=1716543105;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XE8ec4HI4i4vHVAKUdw8kX8hncL/QXmy4k2UIUxwxZM=;
        b=mq7jok5r6s+gWH/0srZw1feww+KHf4g7D9qfa6ovMC0JZfvqBUve0jspOmto+xaPBd
         BE1QBP/02UPm8EwFyPmx40CeH9KEkTJZPumQEFuG6is8svP8KnMVWQjra3GN5J31DeRi
         krW5AtyPRio41X8pEGIiNoUJBRz+xX2AGCBSQl5kRLyOlAtztu6qbCMcBmZGDBFwjsSp
         22433GHlw/v7rxAs2nsaJaPo3CBlJNRdsqocUdB1Um3oLTyLe0KCbEZZE4+ZtofBBA8y
         Pb9VDldyExlEt+0wF3XDHQcqdo68TjVJcMj1dgyUn/RXidu1mRW3Spuzu7PAEVs9xoic
         WDhQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0aYz5glFUE8UFqPouB+uY5UXcapYB7ei61ZvpzGqzMfT4z2j2c27Iy4J3R65w57PbvTqbRjlBBBrcvFgOPPzXCxYc+XrqRyaNiSenhA==
X-Gm-Message-State: AOJu0Yy7Vnz1SD1gmdhnw/+oKJVSFARkj7C9tX70pC0EAGa7X1hY2z8G
	R+jmdnlIoERjjalP+eGrrT1paVdi5PAZnjiDOmZAcQxIYT1YEOZCXoLwkInwmLsbhKspKeiECyi
	gHVvEaHUgGB8rRQ==
X-Google-Smtp-Source: AGHT+IHwyTe/nt8yxz38CKXL7ZPbLKyEJXFv/8wAYMxBHjPP8yU+LYz7D0XQEGqjU5HPqZa+5ySTuAWgp/PMQ6s=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a25:d80e:0:b0:dc2:466a:23c4 with SMTP id
 3f1490d57ef6-dee4f362fe5mr5457961276.4.1715938305388; Fri, 17 May 2024
 02:31:45 -0700 (PDT)
Date: Fri, 17 May 2024 09:30:40 +0000
In-Reply-To: <20240517-alice-file-v6-0-b25bafdc9b97@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240517-alice-file-v6-0-b25bafdc9b97@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=7802; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=hHgNs/eNjM/gQTzn0cb1KWlAOn3yVPjoVCjoZEFxi8E=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmRyPoVBOnyuYj1+nmyuKS10HabTzOk/qRBrkf2
 QMpxLQEOFWJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZkcj6AAKCRAEWL7uWMY5
 RoIbEAC8DjLw30qBXHu9CnLysAlcELQvpAPDRqFO1uuLhrxo8ToiQx1o2ykdg+mxXrdurXKW8mc
 iGM82pqwfI/LwXPO19qxJ/4byUYLCfzBsfVVlSYoXALYFw41xoXoBuptCrhILjGgcO3XHho+0kD
 +46+fipan+114Sbj64FiTm6LWoA3hS7UxwEpolS0J/plN4OiO6fn8tM2WvFr4VgclEgxiCSbpuE
 D32uoSudutxdZBV378dDicqR8anQd9cQTv+Dt48bQOCxhkltLC8dek11xQ5/L3mYitDmnMYAFzz
 dxZhdU96apYcKmkmZyKvQH3Eu6t8Xu3YnylyU+PWsS8+h57NzxN67lvB96bvwOtta6YGIdNFfD8
 8MbrpqbqQY/1ilXcYbs/u91UwxD1RTTWubH+rWZ5D1AKVgGJgq0PjyQBy7DHFitvy7Q2feEM0pf
 alFtlqBZ/PXIQGP7h1uKymifQwmdGdXtrQQwvEIZKCFvwtp8p7DoVFz3x6exYeZsauVtr1zkHDT
 y3DRijp++EFCqw/KkELhFQkd9CwDW8Pngn7p8lzJz/BIJW3yKqAxa16j4UhrIlL4jOllYDUphex
 hbPOfkBEvRpya5bURxEe3RiwGM8T+J1lswmqpDV62tBLxZRC3ScMXaAnCNuRPXnhNo+Iuzle9Uu 9vzDo9bKMTWWPqw==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240517-alice-file-v6-7-b25bafdc9b97@google.com>
Subject: [PATCH v6 7/8] rust: file: add `Kuid` wrapper
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
index 766e368bd0d8..81ac2c994c71 100644
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
2.45.0.rc1.225.g2a3ae87e7f-goog


