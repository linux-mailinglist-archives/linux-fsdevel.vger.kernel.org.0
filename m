Return-Path: <linux-fsdevel+bounces-8253-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A72831B87
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jan 2024 15:38:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06E92B2591E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jan 2024 14:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B961DA3B;
	Thu, 18 Jan 2024 14:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c28O7AC+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDCA2C199
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jan 2024 14:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705588626; cv=none; b=qnwNq1kfA/y7arsUfmf0Sh58cFQaVmKg5rNv16lcDik5q4ETMIryvR2NGWBKwMp471cgtkpRPHBroamjRYezhbJsf3whKnW/MdeaaeHL2Jc6NEmI0O/4djBZD+mqYMZ4dsJ46BBcegOZZGZ6eV+UmWiBd0oP33mCNw9RgoONZVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705588626; c=relaxed/simple;
	bh=Sn4iv+1Sqmbmlo1CanL38VvE8Hbx2qZrDf9IB96IkL0=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Date:
	 In-Reply-To:Mime-Version:References:X-Developer-Key:
	 X-Developer-Signature:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=ofsRgD6i7LyiVU2ikG6CyPK6IQq/lLU31KNaCQiV+KTi6VXDhAMi4HYrcRXjdA+z8YWB3g1NG8K25zQhgTOp4tf6d315Va5RN1IPHORtYPzWMN/VvTKJrQJDj8NPNaIx+7BJte00EENHPAscV3t+o2EfLX2QKNeX03+AjXvqEFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c28O7AC+; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc2358dce6bso3130925276.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jan 2024 06:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705588624; x=1706193424; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=U3ZIaTdIDVbGxgj61qLOgdlUIoPK1UIssk3iN71rz/s=;
        b=c28O7AC+fkiCThWEpL9kIIeCsbMYrzJNSca5yK9TeWdfCgM7QxmaqBkBwMYfYWXMNg
         eoWRQu7d2sWSygrdpBytlT5lYOc8vv7caZ2m1EujY27A8PHaBIaQsLuwcZVLs6/RZcuI
         Vw6v2c60Np38jonfaE9lQ9YzuI9TVGu0idWgBFomOJnWu5zciUE76j6zA4ZZNfXooNGW
         48nshGoIOOl+0ZYLoHIc8CSxrdQoSRQDsv22/hffQ91fL/ssEKuRtAxuy53ESleyJvYY
         /tvlSkr9/xoDyrVMFED5fA71WZt9m2b8+GGkbdunrH7qOAqb82VBhG6BBPf22nFzpYvE
         JXsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705588624; x=1706193424;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U3ZIaTdIDVbGxgj61qLOgdlUIoPK1UIssk3iN71rz/s=;
        b=m1vZK4/KoRrUECOFyI2smk53YANzQkzORilO0O80+l/IAXftajYmxsDmvMtnIe0cRJ
         nni+sLSHZ3uyb9+sCG+dO2rxFdl34nvSBVgYTdwR4leZ5VEfUIe2LaW51RSyUSOU+i8i
         RuYzbsAzHum0DkQkEn/ETcO6OUSWtyIl2KccY6tPvTwmFJ+2Q8n0GvamcE/aP9voN4xZ
         I35Hzo80xjKlSGlXAy+VxyXGsVBGD2y+SHLEp48bEB+XyjVQVYRlEfX++BvS6/yA7vSF
         jNKj6LbA05+AzvDylAjis8kncZxb/SfcwUSPVj9pRdPFqMQkDR8pUuufG1q2Xd6w3EBT
         XusQ==
X-Gm-Message-State: AOJu0YzB/O/Zdd0PJRxDKXEVGgzonc4gwehxcThkh5lfxP6NBs7wnJVy
	tK3AEJhQG8wkoMWOgXD4LKPnIcWv6TlCuqpO0exRViLlRN9zALdNks0MrWa5Ced6AQ2YLJK4cEe
	rOPQXZ709hYmMaw==
X-Google-Smtp-Source: AGHT+IHWhgLkWIetQ2mZmHcRN5jeIQYHk6tkiON2vFwLiBmso+/2KSBkdDhr+f3CK/amZhAS4w8IuwoEs3JrwQI=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:6902:564:b0:dbd:f7e4:c7f5 with SMTP
 id a4-20020a056902056400b00dbdf7e4c7f5mr42508ybt.10.1705588623987; Thu, 18
 Jan 2024 06:37:03 -0800 (PST)
Date: Thu, 18 Jan 2024 14:36:45 +0000
In-Reply-To: <20240118-alice-file-v3-0-9694b6f9580c@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240118-alice-file-v3-0-9694b6f9580c@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=5161; i=aliceryhl@google.com;
 h=from:subject; bh=Sn4iv+1Sqmbmlo1CanL38VvE8Hbx2qZrDf9IB96IkL0=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBlqTHPhq+JGtgXIqkMw8yk1y7rymKao+Lrdw6jY
 qn7dHXBANGJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZakxzwAKCRAEWL7uWMY5
 Ro+8D/9mUD4uzehFHVDXuHzTQOnbov3Ne0XfQfXYnDSAoTZsiYTjZlUzKwnExkpj62RL3ayUBG2
 KDedWT2hGLntQ5mPzYxJRNr9FaOS4M3B/EhRq0aAbkVsPJzK8wPtaNY97KW38szSvs3bG6xmjea
 Ks0GwboWSEFp09VXPY7cidfmIzO9I+iU+qt9AI1+55lEyzgzIwW+mdWK3vjKWHOHj8jADqhbXak
 j0qeUSIirRa2kEkekzA7VNwVYvj5rtziMr5AGDWa7HurBoLwlDHQ2RSHPtSHivZAsSnSDzYINrp
 DwYfPD3Lu20wrJ1QAUFc3W2BLPJ3gU8zET0hJsOtsLdJ7jKiZoaKqNXUNN+ue4JnTwLAnErbDVO
 fN6pIW+RM57IyBwEnIOS93dg/2Oz94qq/9hP6JXiVwPhZ4D9lISXcWbk2FXRf3aOWGCHGPQurKP
 K+n6KQFaNnNCkL7P0o/sFPYAC8/tREzLKS7oieGRe74Ia0DxhOA3CRI9mYyqksVoTyLvm4QsosP
 pREeitT8Pt+hQGRa9nayjKJunYxdknvFdIV3J4sTtQpq7zZd9uaw1rrtxHWsMePrwiftQzyoGyg
 BpY910R4bI0iFsXHBilBK/YpXdnytZj1sA4Ll4k3lYOtRIywAS+t47IzhWw/FVbrtLXfQ1TLpnL M3W2M+u9mOftN1w==
X-Mailer: git-send-email 2.43.0.381.gb435a96ce8-goog
Message-ID: <20240118-alice-file-v3-4-9694b6f9580c@google.com>
Subject: [PATCH v3 4/9] rust: types: add `NotThreadSafe`
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
[1] and [2] for the discussion that led to the introducion of this
patch.

Link: https://lore.kernel.org/all/nFDPJFnzE9Q5cqY7FwSMByRH2OAn_BpI4H53NQfWIlN6I2qfmAqnkp2wRqn0XjMO65OyZY4h6P4K2nAGKJpAOSzksYXaiAK_FoH_8QbgBI4=@proton.me/ [1]
Link: https://lore.kernel.org/all/nFDPJFnzE9Q5cqY7FwSMByRH2OAn_BpI4H53NQfWIlN6I2qfmAqnkp2wRqn0XjMO65OyZY4h6P4K2nAGKJpAOSzksYXaiAK_FoH_8QbgBI4=@proton.me/ [2]
Suggested-by: Benno Lossin <benno.lossin@proton.me>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/sync/lock.rs | 15 +++++++++++----
 rust/kernel/task.rs      | 11 +++++++----
 rust/kernel/types.rs     | 17 +++++++++++++++++
 3 files changed, 35 insertions(+), 8 deletions(-)

diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
index f12a684bc957..2a808aedc9ee 100644
--- a/rust/kernel/sync/lock.rs
+++ b/rust/kernel/sync/lock.rs
@@ -6,8 +6,15 @@
 //! spinlocks, raw spinlocks) to be provided with minimal effort.
 
 use super::LockClassKey;
-use crate::{bindings, init::PinInit, pin_init, str::CStr, types::Opaque, types::ScopeGuard};
-use core::{cell::UnsafeCell, marker::PhantomData, marker::PhantomPinned};
+use crate::{
+    bindings,
+    init::PinInit,
+    pin_init,
+    str::CStr,
+    types::ScopeGuard,
+    types::{NotThreadSafe, Opaque},
+};
+use core::{cell::UnsafeCell, marker::PhantomPinned};
 use macros::pin_data;
 
 pub mod mutex;
@@ -132,7 +139,7 @@ pub fn lock(&self) -> Guard<'_, T, B> {
 pub struct Guard<'a, T: ?Sized, B: Backend> {
     pub(crate) lock: &'a Lock<T, B>,
     pub(crate) state: B::GuardState,
-    _not_send: PhantomData<*mut ()>,
+    _not_send: NotThreadSafe,
 }
 
 // SAFETY: `Guard` is sync when the data protected by the lock is also sync.
@@ -184,7 +191,7 @@ pub(crate) unsafe fn new(lock: &'a Lock<T, B>, state: B::GuardState) -> Self {
         Self {
             lock,
             state,
-            _not_send: PhantomData,
+            _not_send: NotThreadSafe,
         }
     }
 }
diff --git a/rust/kernel/task.rs b/rust/kernel/task.rs
index 9451932d5d86..4665ff86ec00 100644
--- a/rust/kernel/task.rs
+++ b/rust/kernel/task.rs
@@ -4,8 +4,11 @@
 //!
 //! C header: [`include/linux/sched.h`](srctree/include/linux/sched.h).
 
-use crate::{bindings, types::Opaque};
-use core::{marker::PhantomData, ops::Deref, ptr};
+use crate::{
+    bindings,
+    types::{NotThreadSafe, Opaque},
+};
+use core::{ops::Deref, ptr};
 
 /// Returns the currently running task.
 #[macro_export]
@@ -90,7 +93,7 @@ impl Task {
     pub unsafe fn current() -> impl Deref<Target = Task> {
         struct TaskRef<'a> {
             task: &'a Task,
-            _not_send: PhantomData<*mut ()>,
+            _not_send: NotThreadSafe,
         }
 
         impl Deref for TaskRef<'_> {
@@ -109,7 +112,7 @@ fn deref(&self) -> &Self::Target {
             // that `TaskRef` is not `Send`, we know it cannot be transferred to another thread
             // (where it could potentially outlive the caller).
             task: unsafe { &*ptr.cast() },
-            _not_send: PhantomData,
+            _not_send: NotThreadSafe,
         }
     }
 
diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index fdb778e65d79..5841f7512971 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -387,3 +387,20 @@ pub enum Either<L, R> {
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
+/// task. This is useful when a type stores task-local information for example file descriptors.
+pub type NotThreadSafe = PhantomData<*mut ()>;
+
+/// Used to construct instances of type [`NotThreadSafe`] similar to how we construct
+/// `PhantomData`.
+///
+/// [`NotThreadSafe`]: type@NotThreadSafe
+#[allow(non_upper_case_globals)]
+pub const NotThreadSafe: NotThreadSafe = PhantomData;
-- 
2.43.0.381.gb435a96ce8-goog


