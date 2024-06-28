Return-Path: <linux-fsdevel+bounces-22784-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79F8291C1DD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 16:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06C121F23952
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 14:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889C01C6895;
	Fri, 28 Jun 2024 14:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K9+FNeZ8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f202.google.com (mail-lj1-f202.google.com [209.85.208.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F591C232A
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Jun 2024 14:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719586674; cv=none; b=ecp81KdhFLjzJZlCMYH3qn/3XBEiYys601zkc7yD7ZBI6MuuW/V1ejHsIoikkX/sURSParajNgBW5YdC/wohRBpzioWJgHXG6G2YTz/aQq5VlDd2mDaqmi4RcUlNARZUXaHpkmogmyL6djQVM2MPOupFCRuijFT2O+gc5CpWuB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719586674; c=relaxed/simple;
	bh=dnIlIunhctrVQa7CZuSuRAKQF6iSqLvH+8Mk0KeN8so=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qAqUN1KJ8rcteQedvvyPmTweQWiC0Pdf0JVNLZyEEkWRPDC6CONYK3ICKvsMQsBECKwJR2RsFhiuG7S4Bb8icaIo1/N1PYCNrRnfGMKQWYfm+w83dikDw2I9l4i184gsm8xmUbbxWeyGdLJsAEyIM001R2eck6BJu3Rlpgpygqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K9+FNeZ8; arc=none smtp.client-ip=209.85.208.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-lj1-f202.google.com with SMTP id 38308e7fff4ca-2ee4e9b77c1so4819871fa.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Jun 2024 07:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719586669; x=1720191469; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q9wOjTxToM/VZGpXclh0mo0L+KKkVr7MLa7ER9ZM6qQ=;
        b=K9+FNeZ8Vj/aaDdAUk64KTvjiKeecv0ugBI9O3zHUZ4sGJ1ZAdawUeLTzBIEx27cyJ
         bxktOW77rtzZRuHOHzz0DaX5Sn0SNrPdmUiINfkHPySkJ0mNa+WKLj+KYw2j6tQYti8o
         GZJZe72PPyO9NiZlGPWyXLEH8P04krUqA0gtGYvYbTlMtc79QOMj6AYrullRzh7X9lg4
         HGyKwkG5W1KboLC8EfFrGHJlM4u4GUYYCR6Vz9h2v3jq576j1MIDaKUd/+9epQCOrFpZ
         c71I46Z6I5aeN3tt8BI09jLUAqS8RXeWibXa6avoESwpO8VNT1XGOEfsdUUxb7PgXmW2
         J8bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719586669; x=1720191469;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q9wOjTxToM/VZGpXclh0mo0L+KKkVr7MLa7ER9ZM6qQ=;
        b=eJrXRPkFaL95iURxIKKKEyqAxEmJXHXknyg5lXWKLx8AYHMvNX71J81PDB+GcWit3z
         1FAWBRELinhViZBGKv02hAz5VNxaD8Do7hgNZI2FjJTsBG73UWcdjwGpzBduSxGDG/24
         8a1p70cgyHhqWCDfg5oVH4xe82FzYg82NgawmxuCA5s8IKzVgFU6A9q3IITdNukK+kAL
         Ws6fSBE3e9Gzg4DWLcUszRQ2z0/F7hlgFuzPndI6MoEjQjFrVLCAizqtjAlYCTFZUDIY
         OnsceYpLqHAYz1dDmaf1tQ6If9JRnH0Rt6yTc7smUNRbVKV9dkuh9ayCUlA3W+w09CHj
         LdMg==
X-Forwarded-Encrypted: i=1; AJvYcCWCPTtjld40/Yofk9Vr3mVDR/OBgi/iO9zhHCrsSeN9OKSvTSlKKo0xL6VYmzquAeyost/YV51lJZNuQKOqxbxr6sW0JOOfjUw0FCp24A==
X-Gm-Message-State: AOJu0YycGdpJ20/ITKuhs1eAJzenQBj2GeLFK2Czhx4DX8kbgbTbSXJg
	InTDC9XiMc7p5+DhBa7rtczd4eEx7XLWMHdcnPVyYkmMwYhTktjSh1LuzAZu1xQoPhwWpQptvJw
	nq71JsiVR2KZGgA==
X-Google-Smtp-Source: AGHT+IHn6945McCpht6akp9tL+P4rX2ARHjAj5ya+nObFpzWQ7TQWwUYhLBZaIG+F5ly47WhTp71006s6g7apw8=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a2e:b043:0:b0:2ec:36aa:5b6a with SMTP id
 38308e7fff4ca-2ee53bed2f4mr25511fa.2.1719586668861; Fri, 28 Jun 2024 07:57:48
 -0700 (PDT)
Date: Fri, 28 Jun 2024 14:57:14 +0000
In-Reply-To: <20240628-alice-file-v7-0-4d701f6335f3@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240628-alice-file-v7-0-4d701f6335f3@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=5307; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=dnIlIunhctrVQa7CZuSuRAKQF6iSqLvH+8Mk0KeN8so=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmfs9isGDeBVdq2rGeAByjfoJAKdLZwjO61D4gz
 nmQSlFolFOJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZn7PYgAKCRAEWL7uWMY5
 RmQOEACOvfH48MDaMM46CN+vX0WX/gIxKh8aY4N4mumRZrEY0QARDIPEBQOKc336ILSdaQq4mIn
 eWiKRyIuM8BXr7/X/6kk00ABRXIP88WwnvmHr28UWGh7piDhNFD0dAJCNnCYp/Tbj7s8tX8v37Q
 49AbbtwYrGF6D8M5uGwUW0UCRmukQwsF83VbBVGUxz6ud67ItkeKGCNDU1JvCMI+SSi4ooyxlz0
 qZQ43nTnl7Nco/C90jYipg4Bd9fRE4K1aFevAqTGYxlypCns9Zlmj/WhT1+ZPfKkgqeeitxWnjI
 4dVQ3YuI7CiRslUcrVEhLbn+0sDJhofxTQM11pBP9ZtxVlyZ/0sYF2NNLPHCTCvYMyEv+GhRXAv
 7uNhdJChT2CMRHe4RgaxqODq31JcqXUKA8jl5ikL8YqaZ/tNu0vmPNQWxlrXL0e1aUxSySX35Ct
 uwzd8M5EKj/4l0pe+buwrfqRTgHc/Pv/AdbIIozxE+nzYZ3LvkJzZ33lNdA/GMy1QFMdoIYKRGw
 b5oYp4GetSint6tAuDjAxnw67OLkyOe7ZNtgynPTQLGLz3UDTLEBk0tAVLrceu+SJJ3D0Evg42O
 yfeNMbg2oZ/9DUmlvpqKfhi6XSQ6jnzF/QCTOEnmL+VmuhRmZ0isxfRasi75ZtBKeVEiE6Srfvz 8F1B/cfgTUpfxPQ==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240628-alice-file-v7-1-4d701f6335f3@google.com>
Subject: [PATCH v7 1/8] rust: types: add `NotThreadSafe`
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
	Trevor Gross <tmgross@umich.edu>, Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Content-Type: text/plain; charset="utf-8"

This introduces a new marker type for types that shouldn't be thread
safe. By adding a field of this type to a struct, it becomes non-Send
and non-Sync, which means that it cannot be accessed in any way from
threads other than the one it was created on.

This is useful for APIs that require globals such as `current` to remain
constant while the value exists.

We update two existing users in the Kernel to use this helper:

 * `Task::current()` - moving the return type of this value to a
   different thread would not be safe as you can no longer be guaranteed
   that the `current` pointer remains valid.
 * Lock guards. Mutexes and spinlocks should be unlocked on the same
   thread as where they were locked, so we enforce this using the Send
   trait.

There are also additional users in later patches of this patchset. See
[1] and [2] for the discussion that led to the introduction of this
patch.

Link: https://lore.kernel.org/all/nFDPJFnzE9Q5cqY7FwSMByRH2OAn_BpI4H53NQfWIlN6I2qfmAqnkp2wRqn0XjMO65OyZY4h6P4K2nAGKJpAOSzksYXaiAK_FoH_8QbgBI4=@proton.me/ [1]
Link: https://lore.kernel.org/all/nFDPJFnzE9Q5cqY7FwSMByRH2OAn_BpI4H53NQfWIlN6I2qfmAqnkp2wRqn0XjMO65OyZY4h6P4K2nAGKJpAOSzksYXaiAK_FoH_8QbgBI4=@proton.me/ [2]
Suggested-by: Benno Lossin <benno.lossin@proton.me>
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Reviewed-by: Trevor Gross <tmgross@umich.edu>
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/sync/lock.rs | 13 +++++++++----
 rust/kernel/task.rs      | 10 ++++++----
 rust/kernel/types.rs     | 18 ++++++++++++++++++
 3 files changed, 33 insertions(+), 8 deletions(-)

diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
index f6c34ca4d819..d6e9bab114b8 100644
--- a/rust/kernel/sync/lock.rs
+++ b/rust/kernel/sync/lock.rs
@@ -6,8 +6,13 @@
 //! spinlocks, raw spinlocks) to be provided with minimal effort.
 
 use super::LockClassKey;
-use crate::{init::PinInit, pin_init, str::CStr, types::Opaque, types::ScopeGuard};
-use core::{cell::UnsafeCell, marker::PhantomData, marker::PhantomPinned};
+use crate::{
+    init::PinInit,
+    pin_init,
+    str::CStr,
+    types::{NotThreadSafe, Opaque, ScopeGuard},
+};
+use core::{cell::UnsafeCell, marker::PhantomPinned};
 use macros::pin_data;
 
 pub mod mutex;
@@ -139,7 +144,7 @@ pub fn lock(&self) -> Guard<'_, T, B> {
 pub struct Guard<'a, T: ?Sized, B: Backend> {
     pub(crate) lock: &'a Lock<T, B>,
     pub(crate) state: B::GuardState,
-    _not_send: PhantomData<*mut ()>,
+    _not_send: NotThreadSafe,
 }
 
 // SAFETY: `Guard` is sync when the data protected by the lock is also sync.
@@ -191,7 +196,7 @@ pub(crate) unsafe fn new(lock: &'a Lock<T, B>, state: B::GuardState) -> Self {
         Self {
             lock,
             state,
-            _not_send: PhantomData,
+            _not_send: NotThreadSafe,
         }
     }
 }
diff --git a/rust/kernel/task.rs b/rust/kernel/task.rs
index 55dff7e088bf..278c623de0c6 100644
--- a/rust/kernel/task.rs
+++ b/rust/kernel/task.rs
@@ -4,10 +4,12 @@
 //!
 //! C header: [`include/linux/sched.h`](srctree/include/linux/sched.h).
 
-use crate::types::Opaque;
+use crate::{
+    bindings,
+    types::{NotThreadSafe, Opaque},
+};
 use core::{
     ffi::{c_int, c_long, c_uint},
-    marker::PhantomData,
     ops::Deref,
     ptr,
 };
@@ -106,7 +108,7 @@ impl Task {
     pub unsafe fn current() -> impl Deref<Target = Task> {
         struct TaskRef<'a> {
             task: &'a Task,
-            _not_send: PhantomData<*mut ()>,
+            _not_send: NotThreadSafe,
         }
 
         impl Deref for TaskRef<'_> {
@@ -125,7 +127,7 @@ fn deref(&self) -> &Self::Target {
             // that `TaskRef` is not `Send`, we know it cannot be transferred to another thread
             // (where it could potentially outlive the caller).
             task: unsafe { &*ptr.cast() },
-            _not_send: PhantomData,
+            _not_send: NotThreadSafe,
         }
     }
 
diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index 2e7c9008621f..93734677cfe7 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -409,3 +409,21 @@ pub enum Either<L, R> {
     /// Constructs an instance of [`Either`] containing a value of type `R`.
     Right(R),
 }
+
+/// Zero-sized type to mark types not [`Send`].
+///
+/// Add this type as a field to your struct if your type should not be sent to a different task.
+/// Since [`Send`] is an auto trait, adding a single field that is `!Send` will ensure that the
+/// whole type is `!Send`.
+///
+/// If a type is `!Send` it is impossible to give control over an instance of the type to another
+/// task. This is useful to include in types that store or reference task-local information. A file
+/// descriptor is an example of such task-local information.
+pub type NotThreadSafe = PhantomData<*mut ()>;
+
+/// Used to construct instances of type [`NotThreadSafe`] similar to how `PhantomData` is
+/// constructed.
+///
+/// [`NotThreadSafe`]: type@NotThreadSafe
+#[allow(non_upper_case_globals)]
+pub const NotThreadSafe: NotThreadSafe = PhantomData;

-- 
2.45.2.803.g4e1b14247a-goog


