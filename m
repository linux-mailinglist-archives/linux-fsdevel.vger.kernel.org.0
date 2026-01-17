Return-Path: <linux-fsdevel+bounces-74291-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF8E0D38F55
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Jan 2026 16:25:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 44972300DB12
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Jan 2026 15:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA753239562;
	Sat, 17 Jan 2026 15:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F56Gdrlp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBA522ACEB
	for <linux-fsdevel@vger.kernel.org>; Sat, 17 Jan 2026 15:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768663534; cv=none; b=h1ibzweVQq4xzrwI1gxRM/5GsilehMLyAMhf03alIp6TCXnhuicf/+WPeML6uN4h2FYTC+DnR7RL+2GFCi00sSISZgu3WAbkgEszXV/zE9AQ2o+/uGSFhMGixD9adYADDiNDfOx8VC+G5SI7HMrE1qMmVtJrQ1MNTKnWgzGhR4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768663534; c=relaxed/simple;
	bh=AwcTgsthYx0aIP7jt5SIJ3bUXr4UAdp7zAjyr7QxFZ0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Oj98U1UjvuUPvDvWnbb4Y89T83Ak0pnTgoVgV+u7IwkDlGmq+YMQUOi7oxHpZQojD1cS7yp6hSwBmt2rp/vO7XGYQyOBu7OXerWmXR+oXd+3Xd3z8dCdmo715sOI/7u6hGrel7AHBXS+zJm/yS2OL2pRdp/daiK6pawPooERdFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F56Gdrlp; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-b7fe37056e1so342114666b.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 17 Jan 2026 07:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768663528; x=1769268328; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1KycL/RP2UnaKXzhbUKxpWD/C+4095bTNRjfo4uJ3+8=;
        b=F56GdrlpxuUB/auXAfmP7EsDw7xrLZnPO91f2sIqfPjmRS26O8CoUCac/oslVgG3h4
         udbO+tUKWexgT7dOfuKfctSE4TFaI+fSaq36u0QZ8GwJexwzE95/1zMRpaAzXVoLOiM+
         aT1nWDWbEOn21Qb22wR62RQA5da0hP8/oeveo3B5FjJH2I75g3jtQ5YcON+TEM/ytZah
         0qq+iMwa4bMIu3Ht1Ysr4norxspnBYHKo2x6J3dQzGytbFIXTlh+sE509n0ssdbR/ro4
         SyKTlFT4+HSpiCX+uiMHmvrE9OtsMDcSGgwwmsycN8Ix4BOG59WAIceIVug8aIjSjaVY
         msaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768663528; x=1769268328;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1KycL/RP2UnaKXzhbUKxpWD/C+4095bTNRjfo4uJ3+8=;
        b=RjtYaZ8H4i/hg9gVBhEr+OBAYASZcsrg0E83+oF7MvEK7QvqJQp1gzoqdXxMjv8yUo
         gijOnvJtWkmELcXxN+85CA8LF7cImSBSUifnvQ6X/DkbhQIN/wpL1j9EVEbyU03bxobX
         JvG5mghBlKkP5pDLtQJEykAeNRTJs7D9wIp9GBZ+ewbURKYQD8bVN5c4yMo6oIXLqjov
         tkQXxrNi/vGFlDW+Xj3SKWFQWGPGnnu2KjDQhyhe+RsPUAyDJMhFAL5zTMl38rjbbRLm
         04jxekgBo5LTm5EhpKE5B2w8g52zdDqLH9iHn/S1+EO9KKrLTB0hwR0FlOwSQUF9NPrN
         CLdQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2yZZUluMCS4ntJI1eOx3ybRpRnA6YtCVrBIyOzDyN29Gew6cH0o4wRs+lhuTAQca3Tj3TyNgOyJ023Sqe@vger.kernel.org
X-Gm-Message-State: AOJu0YyKJRFRLnm8/fAX+0qPms4XQQpaAYmrjPfOOU/UAUZKNkkEFl4r
	OEfk7CStlIH7xF43mwTRTfbOH6lJGJpBh/0srNAfqPHCPIRcxQnzLBQL9V6Us8I7HGBeo0WmKMM
	bQSdrp09PwbjRa0VRBA==
X-Received: from edcx10.prod.google.com ([2002:a05:6402:a14a:b0:653:500:d80c])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:f509:b0:b87:298a:da9c with SMTP id a640c23a62f3a-b8792d489bbmr511146466b.6.1768663527693;
 Sat, 17 Jan 2026 07:25:27 -0800 (PST)
Date: Sat, 17 Jan 2026 15:25:19 +0000
In-Reply-To: <20260117-upgrade-poll-v1-0-179437b7bd49@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260117-upgrade-poll-v1-0-179437b7bd49@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=7824; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=AwcTgsthYx0aIP7jt5SIJ3bUXr4UAdp7zAjyr7QxFZ0=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBpa6nlCM1RLO25hi+Og3yrpuOfBAdPBOgDOkh3H
 HgeQMgPA5yJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaWup5QAKCRAEWL7uWMY5
 RlSaD/4zqoJE1iw3f4OcubEFoTGU2vMN/zsSzBI+dNBvE1ntVBKRwEwMq7stU0/ughVEWlLH5mW
 qlv7W73hhqJWw9BIs6FxYiblu2NvI9rAO/v5S8d18fZM7YJdV4VHwq6vDNB9cMHF+UEHkZ8Ie97
 hKi5M5SS41ORKk7mcdLErsjpiY9wOfwVyLnSN7ERMvSXnMfWsHA8yBwdJwLMqqkJvqi5UWHQhAX
 8FZ7w6UaJ1XCAc9SMrnjzwYfArxWuMHQQ32/E2y05+dWk8KdWWICyUAC0JnOUcvcnrG9Qxwdpcl
 8pLH4hlU86XEKdzVCAptr13OlMyxcdJ+t10quV8r7MzUXdRMVpK6mPHOjpyFrB4jUi0l7NQ2haZ
 9zM5RdnuvdbUSJMnEKuO53nsUnQZKWq0aH1qKznRzL7nhM+fMW/RgIgVspSMeNxvZf5bfP+QjVv
 NILjfBp68cKuRtgSeLqG71VpE8GTcpccMjiENcnwHi0VO24FjzWicDQdEM80BOKa5Mjwz1dKGOA
 IRs6qEHGHnN+zXFYWOdJ19er9Y5cPnF8LXBAwSu7u+yypUD74tgqMCrMfpKSo5J06upLxg/laVU
 YFK2gkeYlJodG3JiQ0R0ShGNcPK6nW7Xa1Yi9NMHk7QOFhFvQhWaDQBxTTCmkLYNp5Im+gtdMlb OyFamKZWCrF84Qg==
X-Mailer: b4 0.14.2
Message-ID: <20260117-upgrade-poll-v1-1-179437b7bd49@google.com>
Subject: [PATCH RFC 1/2] rust: poll: make PollCondVar upgradable
From: Alice Ryhl <aliceryhl@google.com>
To: Christian Brauner <brauner@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>
Cc: Gary Guo <gary@garyguo.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Carlos Llamas <cmllamas@google.com>, linux-fsdevel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/sync/poll.rs | 163 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 161 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/sync/poll.rs b/rust/kernel/sync/poll.rs
index 0ec985d560c8d3405c08dbd86e48b14c7c34484d..9fb004c71c78375bb16ded7f518aa282cdcc50f5 100644
--- a/rust/kernel/sync/poll.rs
+++ b/rust/kernel/sync/poll.rs
@@ -5,12 +5,16 @@
 //! Utilities for working with `struct poll_table`.
 
 use crate::{
-    bindings,
+    alloc::AllocError,
+    bindings, container_of,
     fs::File,
     prelude::*,
+    sync::atomic::{Acquire, Atomic, Relaxed, Release},
+    sync::lock::{Backend, Lock},
     sync::{CondVar, LockClassKey},
+    types::Opaque,
 };
-use core::{marker::PhantomData, ops::Deref};
+use core::{marker::PhantomData, ops::Deref, ptr};
 
 /// Creates a [`PollCondVar`] initialiser with the given name and a newly-created lock class.
 #[macro_export]
@@ -22,6 +26,17 @@ macro_rules! new_poll_condvar {
     };
 }
 
+/// Creates a [`UpgradePollCondVar`] initialiser with the given name and a newly-created lock
+/// class.
+#[macro_export]
+macro_rules! new_upgrade_poll_condvar {
+    ($($name:literal)?) => {
+        $crate::sync::poll::UpgradePollCondVar::new(
+            $crate::optional_name!($($name)?), $crate::static_lock_class!()
+        )
+    };
+}
+
 /// Wraps the kernel's `poll_table`.
 ///
 /// # Invariants
@@ -66,6 +81,7 @@ pub fn register_wait(&self, file: &File, cv: &PollCondVar) {
 ///
 /// [`CondVar`]: crate::sync::CondVar
 #[pin_data(PinnedDrop)]
+#[repr(transparent)]
 pub struct PollCondVar {
     #[pin]
     inner: CondVar,
@@ -78,6 +94,17 @@ pub fn new(name: &'static CStr, key: Pin<&'static LockClassKey>) -> impl PinInit
             inner <- CondVar::new(name, key),
         })
     }
+
+    /// Use this `CondVar` as a `PollCondVar`.
+    ///
+    /// # Safety
+    ///
+    /// After the last use of the returned `&PollCondVar`, `__wake_up_pollfree` must be called on
+    /// the `wait_queue_head` at least one grace period before the `CondVar` is destroyed.
+    unsafe fn from_non_poll(c: &CondVar) -> &PollCondVar {
+        // SAFETY: Layout is the same. Caller ensures that PollTables are cleared in time.
+        unsafe { &*ptr::from_ref(c).cast() }
+    }
 }
 
 // Make the `CondVar` methods callable on `PollCondVar`.
@@ -104,3 +131,135 @@ fn drop(self: Pin<&mut Self>) {
         unsafe { bindings::synchronize_rcu() };
     }
 }
+
+/// Wrapper around [`CondVar`] that can be upgraded to [`PollCondVar`].
+///
+/// By using this wrapper, you can avoid rcu for cases that don't use [`PollTable`], and in all
+/// cases you can avoid `synchronize_rcu()`.
+///
+/// # Invariants
+///
+/// `active` either references `simple`, or a `kmalloc` allocation holding an
+/// `UpgradePollCondVarInner`. In the latter case, the allocation remains valid until
+/// `Self::drop()` plus one grace period.
+#[pin_data(PinnedDrop)]
+pub struct UpgradePollCondVar {
+    #[pin]
+    simple: CondVar,
+    active: Atomic<*mut CondVar>,
+}
+
+#[pin_data]
+#[repr(C)]
+struct UpgradePollCondVarInner {
+    #[pin]
+    upgraded: CondVar,
+    #[pin]
+    rcu: Opaque<bindings::callback_head>,
+}
+
+impl UpgradePollCondVar {
+    /// Constructs a new upgradable condvar initialiser.
+    pub fn new(name: &'static CStr, key: Pin<&'static LockClassKey>) -> impl PinInit<Self> {
+        pin_init!(&this in Self {
+            simple <- CondVar::new(name, key),
+            // SAFETY: `this->inner` is in-bounds.
+            active: Atomic::new((unsafe { &raw const (*this.as_ptr()).simple }).cast_mut()),
+        })
+    }
+
+    /// Obtain a [`PollCondVar`], upgrading if necessary.
+    ///
+    /// You should use the same lock as what is passed to the `wait_*` methods. Otherwise wakeups
+    /// may be missed.
+    pub fn poll<T: ?Sized, B: Backend>(
+        &self,
+        lock: &Lock<T, B>,
+        name: &'static CStr,
+        key: Pin<&'static LockClassKey>,
+    ) -> Result<&PollCondVar, AllocError> {
+        let mut ptr = self.active.load(Acquire).cast_const();
+        if ptr::eq(ptr, &self.simple) {
+            self.upgrade(lock, name, key)?;
+            ptr = self.active.load(Acquire).cast_const();
+            debug_assert_ne!(ptr, ptr::from_ref(&self.simple));
+        }
+        // SAFETY: Signature ensures that last use of returned `&PollCondVar` is before drop(), and
+        // drop() calls `__wake_up_pollfree` followed by waiting a grace period before the
+        // `CondVar` is destroyed.
+        Ok(unsafe { PollCondVar::from_non_poll(&*ptr) })
+    }
+
+    fn upgrade<T: ?Sized, B: Backend>(
+        &self,
+        lock: &Lock<T, B>,
+        name: &'static CStr,
+        key: Pin<&'static LockClassKey>,
+    ) -> Result<(), AllocError> {
+        let upgraded = KBox::pin_init(
+            pin_init!(UpgradePollCondVarInner {
+                upgraded <- CondVar::new(name, key),
+                rcu: Opaque::uninit(),
+            }),
+            GFP_KERNEL,
+        )
+        .map_err(|_| AllocError)?;
+
+        // SAFETY: The value is treated as pinned.
+        let upgraded = KBox::into_raw(unsafe { Pin::into_inner_unchecked(upgraded) });
+
+        let res = self.active.cmpxchg(
+            ptr::from_ref(&self.simple).cast_mut(),
+            // SAFETY: This operation stays in-bounds of the above allocation.
+            unsafe { &raw mut (*upgraded).upgraded },
+            Release,
+        );
+
+        if res.is_err() {
+            // SAFETY: The cmpxchg failed, so take back ownership of the box.
+            drop(unsafe { KBox::from_raw(upgraded) });
+            return Ok(());
+        }
+
+        // If a normal waiter registers in parallel with us, then either:
+        // * We took the lock first. In that case, the waiter sees the above cmpxchg.
+        // * They took the lock first. In that case, we wake them up below.
+        drop(lock.lock());
+        self.simple.notify_all();
+
+        Ok(())
+    }
+}
+
+// Make the `CondVar` methods callable on `UpgradePollCondVar`.
+impl Deref for UpgradePollCondVar {
+    type Target = CondVar;
+
+    fn deref(&self) -> &CondVar {
+        // SAFETY: By the type invariants, this is either `&self.simple` or references an
+        // allocation that lives until `UpgradePollCondVar::drop`.
+        unsafe { &*self.active.load(Acquire) }
+    }
+}
+
+#[pinned_drop]
+impl PinnedDrop for UpgradePollCondVar {
+    #[inline]
+    fn drop(self: Pin<&mut Self>) {
+        // ORDERING: All calls to upgrade happens-before Drop, so no synchronization is required.
+        let ptr = self.active.load(Relaxed);
+        if ptr::eq(ptr, &self.simple) {
+            return;
+        }
+        // SAFETY: When the pointer is not &self.active, it is an `UpgradePollCondVarInner`.
+        let ptr = unsafe { container_of!(ptr, UpgradePollCondVarInner, upgraded) };
+        // SAFETY: The pointer points at a valid `wait_queue_head`.
+        unsafe { bindings::__wake_up_pollfree((*ptr).upgraded.wait_queue_head.get()) };
+        // This skips drop of `CondVar`, but that's ok because we reimplemented its drop here.
+        //
+        // SAFETY: `__wake_up_pollfree` ensures that all registered PollTable instances are gone in
+        // one grace period, and this is the destructor so no new PollTable instances can be
+        // registered. Thus, it's safety to rcu free the `UpgradePollCondVarInner`.
+        unsafe { bindings::kvfree_call_rcu((*ptr).rcu.get(), ptr.cast::<ffi::c_void>()) };
+    }
+}

-- 
2.52.0.457.g6b5491de43-goog


