Return-Path: <linux-fsdevel+bounces-9987-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F23F1846E65
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 11:56:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B2241F2755E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 10:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A9413DBA5;
	Fri,  2 Feb 2024 10:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ELhKLNuU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F1D7A73D
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Feb 2024 10:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706871353; cv=none; b=n3fj1vrgr4F9todjg0wAki/rTDd4B32kcZpUpg47HyzTIRgcM0tjUdW1QUimFHSxjOxiVSUc3nV9NkphVz2cB3y9aebHGJkDecisV7AAR8RQZcLyGToGa6C4LCygsv9lcZo0tEr1L7c88M+PB+hZe9Ik3zDsZugDIeG5hOw6n/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706871353; c=relaxed/simple;
	bh=7gwoE0vtO/2/iYZib8O58rbMHk3Wy9KYeSDPJyHPimY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=W4QoH98c0hj7aOI5wgRCUBWuVKg83sxhb6VC2TIeG1yxMNWsPshs7uK2PYMiPkTYquzLBGSl1N53+UO+AST9tv8VGoLNsKI1RIAXs0V2FtM3KCA1YwEnrz0G4yikkZdsCk95XI74ZMpvGtIppT6d0eftXGxxy8R6LLvGfFVhEsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ELhKLNuU; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6dbdcfd39so3094070276.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 Feb 2024 02:55:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706871349; x=1707476149; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+0ZULy5/y5vgNdfWgR+xGryignYZX4VlToe5mV4Cwck=;
        b=ELhKLNuUmyCXTskm7QpxezpTciGgsXbMl8drYauIMY+c2t4CSWfgrA1h8s97tIOHTe
         0dDHu77WSE/1OeQgB9GNpiuXXhlcb/iNPXFUTmJ6mVTX16cac4Kp+Pca16xQqFfXzG1+
         u7AQXr6WCUcS2XahAe1FnVM0YOwSRnHa6JnqSjrQ/pz2VrOunSRGXJ2Q+OFUIcLP+ggE
         vZbdRpgqpD2P/p1DbDKUV6R+HI0ijO+z0WHhJsr/hORpYPfHBPiyyZzcnjd4ECMx9OGD
         yBMHfHTuZgNSfyevOPrG9k5m5lhDXkkRBk+165JEJ8eYPNbV/gl0MqC6zaVG56yrkEHm
         QNlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706871349; x=1707476149;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+0ZULy5/y5vgNdfWgR+xGryignYZX4VlToe5mV4Cwck=;
        b=mhOZtT4FJrButLAfZyqjc55kHB/kfwlout+tvBEMR9a90WANjYarfWJWtUdk4T2OiQ
         FNn0TLjZmpj1m/Axbg0HZdVJ9ukmcRREcsCcRslCmudfK0isTiXj7uTinuEHwrtV/4mo
         XEbbozv6EN++rABXc/5wHcPSjmFs0uBGMjzC88xfLplRYru3+WzDkHs80lIJPxbYevjE
         uvOzOm6mTrHQ18F0WoFdiOToedyxWiivDaORNq4ZDb3q7vtLm0JYFTa6Z4qrz+sTEoXp
         48Ueq3JFIReXTbU97rozSV5+OHKx2QjdBzx+Hk8Qh2aE3fKveQ75YCtAluwoPMqb6M6/
         cp+Q==
X-Gm-Message-State: AOJu0YxQpBZErR8UI156NeR4ze3zYX1SGaPRO/9TLKJE63VY07fQ5Oei
	Ug1Uys0QrPmuUoqpSTIBPZ8CkyFnZsySOYlz/V1V6rZpGYCLr6g49FrQjoGwnQdA/BRBxzatviB
	ZIFpCsD6+BAG7YA==
X-Google-Smtp-Source: AGHT+IE+ihK9XjY6ydzHB4O48oat5f+TJ0N5Oe/pEEm3BWmfvwsm9K9kUDnNFxqUyDiK280xUknZ2yv0ubZPMrk=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:6902:2509:b0:dc2:4fff:75e9 with SMTP
 id dt9-20020a056902250900b00dc24fff75e9mr513170ybb.8.1706871349089; Fri, 02
 Feb 2024 02:55:49 -0800 (PST)
Date: Fri,  2 Feb 2024 10:55:35 +0000
In-Reply-To: <20240202-alice-file-v4-0-fc9c2080663b@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240202-alice-file-v4-0-fc9c2080663b@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=5180; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=7gwoE0vtO/2/iYZib8O58rbMHk3Wy9KYeSDPJyHPimY=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBlvMjJVrh8psmguMzY4qssJLn8fU7x6TwLXZl0A
 b26AWdaCAmJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZbzIyQAKCRAEWL7uWMY5
 RsolD/90eoXCySNpVOb7NYRwSd+K9mdkE0Zgp+frXI3IfySfd1n78V+DlKjLpoHuW9yKpDOFThM
 FVZmlkIbki2JVo9lQRrVkXk2SB/jYE1wiIu7wbMN2T4ptQArp7/tLdI158J+m/Y475QCmy6yb1o
 pgxmY0UWqcmFmMv7bjHCtHqGC3zlfR6PND0fuZISbwIXKxEzgrWsw8OgIzoPFhUj1CaYQnTFV3P
 oAKBBFrQ+0o8IooTJ1B34MkVcx706eNu76S4KxBlPTzD9SxdLrKyz4opCYHL/p80T2SPpIjP188
 08Ha/Cxy8O2pYBiHRQG0Qdg7bnjma8ZaCcclvUg4e1WqVgcYEoaz4xaDDmchAfYao92E/4lGQVl
 SB969da/RLsuz3NjQTa4xkHwHi52i4AqGYxjn53r/kaiOCuQZaCWohdVTmSUYvbxh1LGwp2C7fv
 5lTGSpE6ej8oALanvEfgMz45GsYtTcASuQIogQFmAv1ai6bbOCSYo4zYtfnshTvAn39bLB7FY9i
 iSIfPamxyb94sXgTK14n6r1M0t+j5wQoSuvlmeeECJ/7aiDoZc11FhYISfw7ZQfHs29Am9qknLV
 RdfX+lzQLuncgDEMDEEnHrCDSbQteIDfXKU2jW5nk5Vs7KOfc7HwlnKDsnrJvXfreFCM1Fbq3VW Y//l4Ceyv/iuXNg==
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240202-alice-file-v4-1-fc9c2080663b@google.com>
Subject: [PATCH v4 1/9] rust: types: add `NotThreadSafe`
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
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/sync/lock.rs | 15 +++++++++++----
 rust/kernel/task.rs      | 10 ++++++----
 rust/kernel/types.rs     | 17 +++++++++++++++++
 3 files changed, 34 insertions(+), 8 deletions(-)

diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
index 149a5259d431..d08d9d32915a 100644
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
index a3a4007db682..148a4f4eb7a8 100644
--- a/rust/kernel/task.rs
+++ b/rust/kernel/task.rs
@@ -4,10 +4,12 @@
 //!
 //! C header: [`include/linux/sched.h`](srctree/include/linux/sched.h).
 
-use crate::{bindings, types::Opaque};
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
2.43.0.594.gd9cf4e227d-goog


