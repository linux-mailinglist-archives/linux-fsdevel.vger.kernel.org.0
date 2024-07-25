Return-Path: <linux-fsdevel+bounces-24242-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 124CC93C41C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2024 16:28:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3679D1C21367
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2024 14:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D8E19D8BE;
	Thu, 25 Jul 2024 14:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iS3Eawpu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f201.google.com (mail-lj1-f201.google.com [209.85.208.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D6519D087
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jul 2024 14:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721917669; cv=none; b=oo6Fy38rfVsx648ymiTusL7/7J3bjqVqWKyRCxHsZAUmQHzR64bkpVMktJZE683WOV/npPvagRKyJrkyr4bGx10oWf0E9pmhz8zkaSA4t62RtTltywuDpSCJ9OmLCB7ifY7ps+brNuSNmt6nOt9fi36MW+oKnApXNpNeqjXM+XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721917669; c=relaxed/simple;
	bh=AebHlmQT/v8d6mOy63DVdfJexRKdHwwdHK1NUyWuM+Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sYX83ELvlSP2nENLcjnP8bnBQHh9tEkeRaqxU1FjMlwjX71c7h8J0h1HQprH7zcjL7CIme/n17J6qgVZKi0V4lqWwTHniQ+Di/5LH+ecN2/oEaTJPweqSEiN4qXE77RphlzPokfhaQhsvtttig5iNjX1s3QQ2dnzP++nQ+kBbM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iS3Eawpu; arc=none smtp.client-ip=209.85.208.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-lj1-f201.google.com with SMTP id 38308e7fff4ca-2ef315c6990so1591951fa.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jul 2024 07:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721917665; x=1722522465; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eQAwdRqXZq1hIaipuqKSk20IQQ5K8HeQcKqN8Vibh8A=;
        b=iS3Eawpuup7pEVmHO6bAYAA76QFREFowWjvD8f6PhkRAgeAirfPLbtelFIrDty01S6
         DhGCT7yHLMt0LpB4OsVsYIhWc3utpyjKI3otLN5J1p//3jbEvEb1C5oB8+pVhMqCfd8P
         oe2lVbuVopxyAIMxph3TCza6w5wfUo/Dxzmi1fiVfrbJYVmeXxeMpx2VtfKpxKeZm1/w
         n3HqS7tVg6XR3/hj0ujc8FeBc7T51m4R2ubQCrna+lS/DEdMZby5bXfUMH0OIcGr6th+
         J9Do8HHDU53Ni++o1t9BfmRC1C0mnuzdICL8tOrWvVudcbyyBJIfIkMw8kCrfsSuKrEJ
         HzyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721917665; x=1722522465;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eQAwdRqXZq1hIaipuqKSk20IQQ5K8HeQcKqN8Vibh8A=;
        b=LTe/J2a2qDiGMs6vNcfMC1x4+WqB3moVVl8Oy9j+/tHk0JshcyoR4Qb9Hkum+EsJS4
         N+nhYVfxWQq7HzSwJ29kqWmabvlCf9MLvH6c3owfzylPfluxmKOZRZIarQ7PwXLgMSZ5
         zK91PySGCVkJGxkM/d1stVKNuAW/Ufnm3cu3wIFLQeDhy5oN8jYXlad1BnjYYDbygWGu
         SufxSjCT0fGMMpmcwlc1YUH3xXFcECuwmSrt9gdoZgr4mL7upv7idO29Rbo6fMvJ6SLt
         TxMxzERABGuS50b+dmSdIPX1wQMpLy8elfof+aP+zZsFJeFom3lSb+u3dB7o/a9H+6H+
         wZGA==
X-Forwarded-Encrypted: i=1; AJvYcCXqwnwTEJS+PuzmUo36kDEg1Pjt3jf5HlBXaHL309Ci0BfEZeSPOzSqoDjDBUVJ3v80ZZ6JY1jUgsWoD0SEfGOkVAe6KDmlRJi53E/Yiw==
X-Gm-Message-State: AOJu0Yx57TQbAzoRIQxPZpjLV5eU/t5XnOI1MZNzCKNGt7bOCP4e3jq3
	drC0z80fBw1aokxjUGxIcaKHpHSXPKi/ys8qi2B7KVUM3Gx9P/c0iAl79wgSluQF+O9Yz8GM/eP
	N6PyNsV9YWuZxHw==
X-Google-Smtp-Source: AGHT+IHcegB6zdY+CFU4sJisI0TvHXhaoETjFS+27nPoBR1lwOb7c/de/PS4CNsB1A2WVLhGKZO+t4pp1FszUq8=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a2e:b535:0:b0:2ef:2c1d:1b32 with SMTP id
 38308e7fff4ca-2f032eed05bmr78971fa.4.1721917665334; Thu, 25 Jul 2024 07:27:45
 -0700 (PDT)
Date: Thu, 25 Jul 2024 14:27:34 +0000
In-Reply-To: <20240725-alice-file-v8-0-55a2e80deaa8@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240725-alice-file-v8-0-55a2e80deaa8@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=5576; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=h/k9dOkL3ny8wfocUav2zrVmFCywHPfnevq6opaBUgc=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmomDWw+7WfvAi24ysM5mXXEgGb7TOp01nzbdWk
 k3MmTzI9jiJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZqJg1gAKCRAEWL7uWMY5
 RrOZD/0RgCQelMFscVSijYh4+gwKpLVFjRMC5YsH70Eu1xv5s4w9omgqbaAoTyEl35dDDdWTrim
 eTWANNP8nBaJCe8GNOKW1TJdHM6OfWbMYvWPQBBd3gxLi2xB2DYPIQlhhSJt3Kjotj+hWHYCLCz
 W7olIyS1X393PeIOrqntfjDuQVs+daJjCTq+pnMj42VdqjGg9y3fvS4+oOfpcSIoejTnME4zV6D
 0uDErnJPBKMNZgIYQft7/GVf+Bg4TR73catNWWFBbOfvwcs7FukkLJ74oG9x7cl5NSVc5FdGxcO
 WsS+8Nn2haYJ044fSlRhJpv/Z/pFura23zVZ2b6gw2v2VX91LZmEkk1cP1Wt98r6qPBL/TGQ8FZ
 a6tE0mSu7MdYllqK082/RxgkGVxa6b+mFiF5iUxEYPL8KHvkv50MhoJ2N/sa2k1z/ZsUkHaDE84
 MjNCMwi7Ek5IfjtGUF3RRWq1LCVs+KprUVouw2qiHJi0GHlo/oY1XLMEScuLbIZi55B0EVeaC4s
 Y5BKjbHwKUJhtjFI8pb63/l8pdO61yheSDZoDzL7fO+mJvozvYhmu6gXRDpVhhyc0NRAn8ZTvm7
 NIUTgLdAe0as5pJp7q0sQiwvrVxUDc3dNlMw1XPAOULbwF3/eFWc7pqeR+1fVv3lbx3vgFvg2OR knwtmDsAwRabY4A==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240725-alice-file-v8-1-55a2e80deaa8@google.com>
Subject: [PATCH v8 1/8] rust: types: add `NotThreadSafe`
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
Content-Transfer-Encoding: quoted-printable

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

Link: https://lore.kernel.org/all/nFDPJFnzE9Q5cqY7FwSMByRH2OAn_BpI4H53NQfWI=
lN6I2qfmAqnkp2wRqn0XjMO65OyZY4h6P4K2nAGKJpAOSzksYXaiAK_FoH_8QbgBI4=3D@proto=
n.me/ [1]
Link: https://lore.kernel.org/all/nFDPJFnzE9Q5cqY7FwSMByRH2OAn_BpI4H53NQfWI=
lN6I2qfmAqnkp2wRqn0XjMO65OyZY4h6P4K2nAGKJpAOSzksYXaiAK_FoH_8QbgBI4=3D@proto=
n.me/ [2]
Suggested-by: Benno Lossin <benno.lossin@proton.me>
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Reviewed-by: Trevor Gross <tmgross@umich.edu>
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Reviewed-by: Bj=C3=B6rn Roy Baron <bjorn3_gh@protonmail.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/sync/lock.rs | 13 +++++++++----
 rust/kernel/task.rs      | 10 ++++++----
 rust/kernel/types.rs     | 21 +++++++++++++++++++++
 3 files changed, 36 insertions(+), 8 deletions(-)

diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
index f6c34ca4d819..d6e9bab114b8 100644
--- a/rust/kernel/sync/lock.rs
+++ b/rust/kernel/sync/lock.rs
@@ -6,8 +6,13 @@
 //! spinlocks, raw spinlocks) to be provided with minimal effort.
=20
 use super::LockClassKey;
-use crate::{init::PinInit, pin_init, str::CStr, types::Opaque, types::Scop=
eGuard};
-use core::{cell::UnsafeCell, marker::PhantomData, marker::PhantomPinned};
+use crate::{
+    init::PinInit,
+    pin_init,
+    str::CStr,
+    types::{NotThreadSafe, Opaque, ScopeGuard},
+};
+use core::{cell::UnsafeCell, marker::PhantomPinned};
 use macros::pin_data;
=20
 pub mod mutex;
@@ -139,7 +144,7 @@ pub fn lock(&self) -> Guard<'_, T, B> {
 pub struct Guard<'a, T: ?Sized, B: Backend> {
     pub(crate) lock: &'a Lock<T, B>,
     pub(crate) state: B::GuardState,
-    _not_send: PhantomData<*mut ()>,
+    _not_send: NotThreadSafe,
 }
=20
 // SAFETY: `Guard` is sync when the data protected by the lock is also syn=
c.
@@ -191,7 +196,7 @@ pub(crate) unsafe fn new(lock: &'a Lock<T, B>, state: B=
::GuardState) -> Self {
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
=20
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
     pub unsafe fn current() -> impl Deref<Target =3D Task> {
         struct TaskRef<'a> {
             task: &'a Task,
-            _not_send: PhantomData<*mut ()>,
+            _not_send: NotThreadSafe,
         }
=20
         impl Deref for TaskRef<'_> {
@@ -125,7 +127,7 @@ fn deref(&self) -> &Self::Target {
             // that `TaskRef` is not `Send`, we know it cannot be transfer=
red to another thread
             // (where it could potentially outlive the caller).
             task: unsafe { &*ptr.cast() },
-            _not_send: PhantomData,
+            _not_send: NotThreadSafe,
         }
     }
=20
diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index bd189d646adb..bb115d730ebb 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -473,3 +473,24 @@ unsafe impl AsBytes for str {}
 // does not have any uninitialized portions either.
 unsafe impl<T: AsBytes> AsBytes for [T] {}
 unsafe impl<T: AsBytes, const N: usize> AsBytes for [T; N] {}
+
+/// Zero-sized type to mark types not [`Send`].
+///
+/// Add this type as a field to your struct if your type should not be sen=
t to a different task.
+/// Since [`Send`] is an auto trait, adding a single field that is `!Send`=
 will ensure that the
+/// whole type is `!Send`.
+///
+/// If a type is `!Send` it is impossible to give control over an instance=
 of the type to another
+/// task. This is useful to include in types that store or reference task-=
local information. A file
+/// descriptor is an example of such task-local information.
+///
+/// This type also makes the type `!Sync`, which prevents immutable access=
 to the value from
+/// several threads in parallel.
+pub type NotThreadSafe =3D PhantomData<*mut ()>;
+
+/// Used to construct instances of type [`NotThreadSafe`] similar to how `=
PhantomData` is
+/// constructed.
+///
+/// [`NotThreadSafe`]: type@NotThreadSafe
+#[allow(non_upper_case_globals)]
+pub const NotThreadSafe: NotThreadSafe =3D PhantomData;

--=20
2.45.2.1089.g2a221341d9-goog


