Return-Path: <linux-fsdevel+bounces-10922-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3A284F46F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 12:19:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D445F288A39
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 11:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66BF328B1;
	Fri,  9 Feb 2024 11:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CXjKMt2b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F5728E0F
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Feb 2024 11:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707477535; cv=none; b=IaEDKWcrdJ/oFBJ2ZjhU7hgilgaH1SZG0UDNySYR2qzKZZDzoIEPl9qcAfzZCU29xdZ9mJCUM9oGabqDonY0rPk56ndZgKUgLOFiFqaqSA6T+AGCBRfaB7O1Lp5F4B5MFVcqxvmfi4JGUaD7XfdzsUKJvigxznxylG63Ftd0sOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707477535; c=relaxed/simple;
	bh=Ot5zgSBuhhqw7Lyq5N1K+biVLFlimbZBNuPkWRRLiE4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BOGGYuI23CFw1VdblzTr+t8r7TT9r/uazhTQ9TEh/l7/unjCGWjrsR6GARJYGYVRH3wJxpWCK7HLo4YBnofuJXTq5ImFdEnHghJUOET+HcK/C1lyTr1Bsk8gv2HxYjBtasTYvfWTWNrdVtLGvtXeeYU1yL8abzNQF7G8MdfV8kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CXjKMt2b; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b267bf11so1171306276.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Feb 2024 03:18:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707477531; x=1708082331; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9q54lAKt/gv2rK+yHeXkaQhcn+YG2rdku2rLMO1QR6A=;
        b=CXjKMt2bR2duDsCcVo1Ub81PH/W5Pvk5yVCebChy+56ctskn01xc04iX+zwCcPg9Ya
         mdYwvBO6p9gBa4tAhC3V88XxX3sDmmE3WABuFqk4nLhBF9vtO16rYpGYW4CHcFYYZ0bR
         esPZ7tLSNm2r7lP7gxmOJ2dvygYXZcU0TcFATUCeXzZn8IFN4VjR87PnVFA7iZQX8D/u
         e0vsXVL/PTq+tzF3spe1ZcTAcAi1Lzn2rWsNRZ3+/t7gWp9iyuHeWInv/4Mv98m0jsSg
         IEOydsDLVnyTq68z099N6YFNxJWxzsAQ5CqnpWsJXa6jnTS7JVf8K2INc2+XfiXJiq2s
         9yeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707477531; x=1708082331;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9q54lAKt/gv2rK+yHeXkaQhcn+YG2rdku2rLMO1QR6A=;
        b=m21X1dp3Di4eGa4uKtk8Scy53VL3ePtpN0jx1omRvCoW3X/Z16pK5uOZp/An4dF7qE
         gIIGp7HD5TNUmRTGgmCb3KcMyrAcN6GRprJ9tIGfwteNR3GEuWQuPVd3qHpRZhTxETlg
         sXAZ3VCTxbW1DSzIk1PO4te38UtdBK67OzWtyNz2PhpUkXwxRmh/u4YZY6ybz+RA5Rp2
         lxI3B4vzT0CJZLvzMfrYL3RiyCZZG+VF2gINDtOCbxXsIRhPmpBSFnajQsyiNkG+M832
         cZN7yB4u6U9h8lv2/aEhURGLzusydiwOwn5JKQKGDSMFzGIf2RVshS9Dqbgmq/vZKv6r
         V7fw==
X-Gm-Message-State: AOJu0YyF8s/FJ6zo3pnk8J8ATvnlG3D2hi9P1DzMrptDaU3efnNAmosn
	g8H6KHSjw7Fs7i1nxudV/Heho/oJgsuzwP8Pm1TFoeLwg5ad3HBqoGfwaUlt+x50/Bofpmqwq2A
	2VsOJI4vt+dcnOw==
X-Google-Smtp-Source: AGHT+IFZBq2B6jfbk9lDn+OtY+mpF4BuOCgKYU19tfQ3BBuy8hNwsKa+vXZOQJncSxb7qIztRu0kTaz//W7HO3A=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:6902:706:b0:dc2:421d:ee30 with SMTP
 id k6-20020a056902070600b00dc2421dee30mr18422ybt.6.1707477531683; Fri, 09 Feb
 2024 03:18:51 -0800 (PST)
Date: Fri, 09 Feb 2024 11:18:14 +0000
In-Reply-To: <20240209-alice-file-v5-0-a37886783025@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240209-alice-file-v5-0-a37886783025@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=5346; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=Ot5zgSBuhhqw7Lyq5N1K+biVLFlimbZBNuPkWRRLiE4=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBlxgoPyGfidEExgGJzTQr4EuqI+P+PF6rccTGHa
 xqqgMJnVTmJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZcYKDwAKCRAEWL7uWMY5
 RtXHD/96K2s5KP11BZAzeOUDVG85LrVgPCSeO7vAKxIsG5apeK3QUDwOM/nwagQGS2D4OsaDvSv
 jY2t+v1f2Jh8kUs/D1JuZs4o+nBB0B56BdMU1pWtEaBeXtPQB9xWHS87Ysi68C0iMUWsxIvI03i
 KlOXxSXBWQcX/9aPTzbTK18h+/DvTMmUxfDW6I6NhY8r0QxHsGZi8TlWjWUSfaii1kVzi9bC2hI
 MiOT8PNZAMBGvNsA/O94uIT57I2Dno5iLzD9xmQeiE58UEjQFE51OpKrPt9hEDRUl9biKklGa05
 Gpf/Mgg1zgo3xu5+9ERTCQXXfV0qZn263lywYnnA8fhvMeh7WBVqo3TDq6yfYAEeAQwIqxn8Be1
 +8MJj1ZScSdEkI73Ig+YUWiyuxZWcO7S10A850Y6I3vAPgMc5nVVPv0Do7zWYr9PxtG/7IcR3zo
 xcNqe4hV0glN6my3SOZFeopaHnPyGHHdy7PzeBbrvOIsURMUBoV4uswpsmE/yJdaCdSkzraWdjP
 X3eU6vFFhjE+KGoWfRwT9x4AH7cg2SLC4rHf8aRzqbgA9GeIY+SIJhLPBuCHQnyj6WSIPBCzl3U
 XOq4n47NHEf7vKsxh+1VoO6X6LP/L2mCtIn1aG6s3YVeMo16ff+2TkRKcO3ZiO4sU+80fwqlD5c eysAhO7o+dHjryQ==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240209-alice-file-v5-1-a37886783025@google.com>
Subject: [PATCH v5 1/9] rust: types: add `NotThreadSafe`
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
 rust/kernel/sync/lock.rs | 14 ++++++++++----
 rust/kernel/task.rs      | 10 ++++++----
 rust/kernel/types.rs     | 18 ++++++++++++++++++
 3 files changed, 34 insertions(+), 8 deletions(-)

diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
index 149a5259d431..090b9ad63dc6 100644
--- a/rust/kernel/sync/lock.rs
+++ b/rust/kernel/sync/lock.rs
@@ -6,8 +6,14 @@
 //! spinlocks, raw spinlocks) to be provided with minimal effort.
 
 use super::LockClassKey;
-use crate::{bindings, init::PinInit, pin_init, str::CStr, types::Opaque, types::ScopeGuard};
-use core::{cell::UnsafeCell, marker::PhantomData, marker::PhantomPinned};
+use crate::{
+    bindings,
+    init::PinInit,
+    pin_init,
+    str::CStr,
+    types::{NotThreadSafe, ScopeGuard, Opaque},
+};
+use core::{cell::UnsafeCell, marker::PhantomPinned};
 use macros::pin_data;
 
 pub mod mutex;
@@ -132,7 +138,7 @@ pub fn lock(&self) -> Guard<'_, T, B> {
 pub struct Guard<'a, T: ?Sized, B: Backend> {
     pub(crate) lock: &'a Lock<T, B>,
     pub(crate) state: B::GuardState,
-    _not_send: PhantomData<*mut ()>,
+    _not_send: NotThreadSafe,
 }
 
 // SAFETY: `Guard` is sync when the data protected by the lock is also sync.
@@ -184,7 +190,7 @@ pub(crate) unsafe fn new(lock: &'a Lock<T, B>, state: B::GuardState) -> Self {
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
index fdb778e65d79..ee1375d47df0 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -387,3 +387,21 @@ pub enum Either<L, R> {
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
2.43.0.687.g38aa6559b0-goog


