Return-Path: <linux-fsdevel+bounces-29402-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB75C979725
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Sep 2024 16:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5722B21AAE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Sep 2024 14:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A2F1C6894;
	Sun, 15 Sep 2024 14:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pUOmdc5Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA091C7B62
	for <linux-fsdevel@vger.kernel.org>; Sun, 15 Sep 2024 14:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726410702; cv=none; b=oGt3F8zdsl9dwcGh1bI1RYeainXDG8oTRYmL1XMiCQKxFXjzHWK6GtonOuh9SlIeBgvuMyDUsw63eEcMY8/qBtIbsp5St4ysdT/2X9829hwE/C5I2zY8vBlG/9PCYJ+wAh5s9o74ljxxUSNeNr3jYdf4iEjyC9jWateqa5XtRQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726410702; c=relaxed/simple;
	bh=pya4UxUIvqhrpbWbTgUte469le+L6lTszY8lv89yptM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZwOO2HQbXnWfAREEyb247S55yJ7kOFagl/YZ81tGhj7d/Zmfr+gyR8Xew2ZzNePMiOWx4Fd8bE2eZm8C708v3DHOYMOcaNJw+YOVreECmJ/uvAjVcPWj3b8yuBNkfVPTqEO33x3NSI8jSp3W/NaQfdkBIL9IuUChJj70uvEICM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pUOmdc5Y; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6d4426ad833so120517837b3.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 15 Sep 2024 07:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726410698; x=1727015498; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oI5g3/Lv8mNk/syaak4D+x2fQixDZyZK48NDDewIoU0=;
        b=pUOmdc5YAlk6OnGwbdw2c2impum0KEq9Ozacc4QNrEkaSKMrPFf9TpyROXahQ2J/LH
         NS9vUOMkblAn2edAFywE7svqlAB/BFAdYGUhx+YxIuy02jlOfXyfUkaa9FDPnp/NxWqw
         n3YtzMCSA4j/iih6Di5T7fm1woeRe24zg0y55diUXuwvdndXx8pHURkp+ju1glPbWglK
         EZPTvN22nHQ7KGQvSyn0C4ULAecBCeiU1tmCNmMwX4RVY8VQhSYe7ShIO7hyiFC4tQGM
         9ts2PBSomKYx/2uLjeNizhJ/L9ZNszpaBFPGwO+XHjfV8qrUqqedRt0weotvnKS7pcwK
         D2LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726410698; x=1727015498;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oI5g3/Lv8mNk/syaak4D+x2fQixDZyZK48NDDewIoU0=;
        b=EDSS/oF3/k2jWKgrAxk8vPZVhIMFcjkQrAY57sALrztRr/ebh2JrSF/uUxUl0zb9Ad
         i3OVOY2NczIf0BtS3nGlinE++02bTUoZUbDYHLN4ow0ajmhEiqoRxWMe6fgyEGzRr4MR
         mbKbey8XM+HIWchpwdIdfvx53qB0+fzBuONqU3QwxnAYAtnMrQljz31wky4NwnHO0xdh
         uiVoxaU5MCVue5vwgyiEKrT2UDtcKfr4fx3oCifG2ghSyEc8f6eJhkV9UelSJd8b5Ng0
         cjfVL1x+rTjRsRHbZuZiZQJQi5AolCGCGOlz52zPWxYhYiXq1yfS9DGuB8kaedu5WRmw
         B/mQ==
X-Forwarded-Encrypted: i=1; AJvYcCXj8Eu0KDIuM60BMHh08sc/lH2xHtA20c6cFjgbfTDIdZkjIl9PXD+V5J9uOsJoEvN+NUyhFa/ZtiKEytXt@vger.kernel.org
X-Gm-Message-State: AOJu0YwtEs5biqvaohzzG/uoOb64AXsdm57R8do17/dV2LKkYPltaD31
	XzBWBEgoFzpcug+EofoOrth308kZHBOjeFWupkDH6DnNUScFuUXAQaX2eFPvPYjZOIpdhG4kf/Y
	9jK/2UpBbAD574A==
X-Google-Smtp-Source: AGHT+IHjXaRfgDfbsN9t5X94X1h1J0q/L8jWWMpEfes9EEkZxqwHEsm+kVBYzjFmCqJGj3geMIb4GpG0QYKCT58=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:35bd])
 (user=aliceryhl job=sendgmr) by 2002:a05:690c:2030:b0:6db:c3b8:c4ce with SMTP
 id 00721157ae682-6dbc3b8c63fmr2582617b3.7.1726410698029; Sun, 15 Sep 2024
 07:31:38 -0700 (PDT)
Date: Sun, 15 Sep 2024 14:31:27 +0000
In-Reply-To: <20240915-alice-file-v10-0-88484f7a3dcf@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240915-alice-file-v10-0-88484f7a3dcf@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=5617; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=Oe7pz1TphdHtcU8pqH5nIlSad+Ilg1tAQMGPgpqw6+I=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBm5u/AAW7zNDH5xHrnIe2hBqOk4mGN9359+nykk
 RBk/acu8NKJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZubvwAAKCRAEWL7uWMY5
 RrsvEACsWEL6NtArNiSxBd2J3ZysiPTJPROquuDhpEYvHs/lnaaixYq9Il7RoItxd+iZiX4Embv
 COeR6cFe2ERf4edkBwW7st7Ok5QG7VeeTTtfllDZsTR2GWhFqRhqhbg9OEuzhMJfRT1llD2+lQY
 cm+4uyMQwvBSvjyyNZT/90+hsfP2WFHOMN6LZbJf0BLX5w53VawcSXha/yeel5XTKJ3MH/S9srr
 xMul3q/SxCoKARSlkdR/sBa8mGlrJ034t29tNd5nR4Z9sk182TV32cIdMd9+b65R9tAr60GlPm5
 NQ7K76du8S3nFLNeYNDiAK0YtzRmKY/HWAYex2+zykYTj7DhUxQ+DhaHWx1d/44TEMtfM8d3g37
 yxkirA4RnADJcGD9UX2jk1f29yqXR7R6+Pkz3gfAv43RROqhnyaqTPTvwotviD3BV3/EWwULe8P
 g9w0amu8FU1d7G1j6bbM2fQ1DLs+MdZnn351dLjLSPIzj/60Qey4bQtM/j8mBIJR4EjdhcKA1fq
 yR5SwAMSuay0cAPCRbLS09w/IJo4vEOytcPYwKUrMOvncXDlP/Y1NAFjXGfHYDDkm9QuVpBlwJd
 iEtS97IQU4LqIR0NaKRRIYN6NdB+/d9GeGkqJeIP+4AXLHJ0owZUVexMOxGTZo5rrxSKgu/zYIN uJShrgMYV5BRRxA==
X-Mailer: b4 0.13.0
Message-ID: <20240915-alice-file-v10-1-88484f7a3dcf@google.com>
Subject: [PATCH v10 1/8] rust: types: add `NotThreadSafe`
From: Alice Ryhl <aliceryhl@google.com>
To: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Christian Brauner <brauner@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Peter Zijlstra <peterz@infradead.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Dan Williams <dan.j.williams@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>, 
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>, Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>, 
	Kees Cook <kees@kernel.org>
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
Reviewed-by: Gary Guo <gary@garyguo.net>
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
index 9e7ca066355c..3238ffaab031 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -532,3 +532,24 @@ unsafe impl AsBytes for str {}
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
2.46.0.662.g92d0881bb0-goog


