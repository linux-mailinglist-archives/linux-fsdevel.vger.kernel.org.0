Return-Path: <linux-fsdevel+bounces-77136-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QFN0B0cLj2n4HQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77136-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 12:30:15 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74ADC135BA6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 12:30:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3EDB330BB501
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 11:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ADC235B13D;
	Fri, 13 Feb 2026 11:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HZsFDt7w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9755D359FB8
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Feb 2026 11:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770982195; cv=none; b=ht3Sn9fYwa0QhA6ZKG5zq4bis3+4a4u5DsCKvyrap0wo2SFRtCUZs8eEf+B/7ypRpmiuoypESUthavgNXGM2JbNtz2K4v9A3pYu0aTMMXnhtg1/X1UBv4Qu+I79iB90/1zgP1SWb2FWky96Ni+YtuCBoQ3e/Iy+Vs2f4g3WCTZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770982195; c=relaxed/simple;
	bh=HO/1J9NdWZEkNK+j5cNCWzi6KQEAouAxirfSac0nl10=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Lt8LV39JbJsGMVvzmYxej/73IwMPog6TXVFiBXlA4PfaN5rYy/DMpj5LYo8NyfO5soQMQtwsaySPzIXt5xi3hSHfAt2Im05QBgAE5tgl7jI3yuCbnLMuuYcyXX9YsAxwR+o+VyIPxSNQJrnwk7QkNYEOOB+nYDEXn193zp0IOfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HZsFDt7w; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4801bceb317so11733235e9.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Feb 2026 03:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770982192; x=1771586992; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=i7ywPMMgxkMbeWreD7LT3U/PKciFN4t2oTW8eSEPdTI=;
        b=HZsFDt7wCZHJH+A45qGzS64bx54fJSjfXTlLDJA1V26ilpjFO/v3XbbwWUFrT6tOVL
         EtvF3bPkw5eYOB6dJxySLCpiXDJDqAAIFAwKW49D6plFeqkPxwJtG/wPPAEc1G911aHy
         SRBAIv28Z1muVK4F58Xx0DIkjI3mZAgN0+P7n20QjwnkJLS39ocBOAZHmIgJrDzcOBak
         1L5W12rpDDeVhQoLVkk+tcIW7IykOiQPNLktzJ+nAPirsqAF98w3MSHy/AebE90qa2rD
         0YX3hE+Qujvh9Ant2N0YL5QRmWqIJxdaN6myBPK++ku/IUPfF2R+zsv6Ez4zm+xMyjAR
         pMvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770982192; x=1771586992;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i7ywPMMgxkMbeWreD7LT3U/PKciFN4t2oTW8eSEPdTI=;
        b=CYFANnfbLXcLbigHrPm9gLn8G5XVEA5jT5/DXoFfyYW5VrZJLdKKZjQ/SM2uy+59NY
         T1K/APALFh5Sk4A9kqY/g6GKlCvpNRcemGITdVdtvbjSUdOYY7e/HDwvcA3jjEJoznzv
         lkEllzfsFxRyLO5whNMRKdi7P5WE0MPPntdlCHuv99LnBTrw1YrQ7sU2LUMjgq79rvSI
         g6M18xlkvejMwVAuAJCuWzkqmHbws4hlyY5IbNjyqxZmjnpPFYKMscjteC3YkKYS55ST
         7eU9oimxsm1aeJludNpCOV0PgacFLP/A7ZQCICClF1jeRATXYZF+6VqQTtxdh+IVandP
         4Saw==
X-Forwarded-Encrypted: i=1; AJvYcCX3tDNO7GyH7EogIeDvzzFp/no79ERl8nd92hnRHR5PB5IJbW/QfWAabLGL2VDxOnqrpnuxS/FxBChoL6wg@vger.kernel.org
X-Gm-Message-State: AOJu0YxGNgHnGxel7P61lEFTyXSKCfBs6HWYFdCQtJseGTR7s8N49MiF
	8ktLlE0Aa8X/JyBgCnWLiuL/7F/U8X+/NQ6lZ1NV77xR+jZE5Oj/oQEuBQRYf8cxPOXwhpn/mkq
	jWT8gkcCiz/S24SZc4A==
X-Received: from wmxa17-n2.prod.google.com ([2002:a05:600d:6451:20b0:480:4a2f:4187])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4fc8:b0:471:14b1:da13 with SMTP id 5b1f17b1804b1-48373a1b6aamr23740235e9.14.1770982191934;
 Fri, 13 Feb 2026 03:29:51 -0800 (PST)
Date: Fri, 13 Feb 2026 11:29:41 +0000
In-Reply-To: <20260213-upgrade-poll-v2-0-984a0fb184fb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260213-upgrade-poll-v2-0-984a0fb184fb@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=7706; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=HO/1J9NdWZEkNK+j5cNCWzi6KQEAouAxirfSac0nl10=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBpjwstAOvzZQ1PPOEYdMoKFFrdbXgW+DevThwr3
 RdjLkjtylOJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaY8LLQAKCRAEWL7uWMY5
 RjMfD/9Gb/9bgDL1D3oukT6+bHxyfbWTsYWUhwhpNQEfKWIvlcUyvFJdi1xd0frCak09uLElRyd
 OyNoxXGUcrzw11tCBI9Ut6lzEOvok+q9W+HEkeL1oNHCqBPJvbl7gVtxIBzcpyukd5xGswSu1u8
 1qGn99tHWpPov49QARSVDsGyzljqqlbqpOCcY/hoRdJ1MZL+wbecQLT7KLgGU1e9/urXgzogqSI
 HqWcktnsVmA2DkU5AESyyOfai8U6iEN2vFveAmk0B0t2fqZWdb+QU1l338sQ8gNPAXctfEsLtxg
 DSgOXFGeG3aBDVsMZHrzQ5/A2xmsNvrmQypk91fuLL231IkOno7BjLBZI+kXuR3eSYhRNhUXhrt
 ireUbpieeexsxXNL2qnmRiY8yfc3sMHcdtW2XaBmjH7VI5GOiywNGXYa614WJvmsawBlOI1+2gS
 +s4EEesFTB3SQiR2ypJBJ5J0u30HtRlS0Oo+2oHHf7qND3R5CdzR4c0m3isnQJ5RqZLc3AlTW0b
 ryaQYbAHeckdS5Y+pf+y0MzWrYtFqkvuxUa/taHpKkbf3jbSouTXWVBmUrBHLJXY6+6e9pywr36
 GQJ0UzZT6i2C6p+pBwKRjZrUJXchjX7cg147M5TRiNAX+X2JTF92gVvgpY6EWvMlhPdGA7BF0J3 ajVq1Dq+47NFndA==
X-Mailer: b4 0.14.2
Message-ID: <20260213-upgrade-poll-v2-1-984a0fb184fb@google.com>
Subject: [PATCH v2 1/2] rust: poll: make PollCondVar upgradable
From: Alice Ryhl <aliceryhl@google.com>
To: Christian Brauner <brauner@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>
Cc: Gary Guo <gary@garyguo.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Carlos Llamas <cmllamas@google.com>, linux-fsdevel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77136-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aliceryhl@google.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 74ADC135BA6
X-Rspamd-Action: no action

Rust Binder currently uses PollCondVar, but it calls synchronize_rcu()
in the destructor, which we would like to avoid. Add a variation of
PollCondVar, which uses kfree_rcu() instead.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/sync/poll.rs | 160 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 159 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/sync/poll.rs b/rust/kernel/sync/poll.rs
index 0ec985d560c8d3405c08dbd86e48b14c7c34484d..9555f818a24d777dd908fca849015c3490ce38d3 100644
--- a/rust/kernel/sync/poll.rs
+++ b/rust/kernel/sync/poll.rs
@@ -5,12 +5,21 @@
 //! Utilities for working with `struct poll_table`.
 
 use crate::{
+    alloc::AllocError,
     bindings,
+    container_of,
     fs::File,
     prelude::*,
+    sync::atomic::{Acquire, Atomic, Relaxed, Release},
+    sync::lock::{Backend, Lock},
     sync::{CondVar, LockClassKey},
+    types::Opaque, //
+};
+use core::{
+    marker::{PhantomData, PhantomPinned},
+    ops::Deref,
+    ptr,
 };
-use core::{marker::PhantomData, ops::Deref};
 
 /// Creates a [`PollCondVar`] initialiser with the given name and a newly-created lock class.
 #[macro_export]
@@ -66,6 +75,7 @@ pub fn register_wait(&self, file: &File, cv: &PollCondVar) {
 ///
 /// [`CondVar`]: crate::sync::CondVar
 #[pin_data(PinnedDrop)]
+#[repr(transparent)]
 pub struct PollCondVar {
     #[pin]
     inner: CondVar,
@@ -78,6 +88,17 @@ pub fn new(name: &'static CStr, key: Pin<&'static LockClassKey>) -> impl PinInit
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
@@ -104,3 +125,140 @@ fn drop(self: Pin<&mut Self>) {
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
+    active: Atomic<*const CondVar>,
+    #[pin]
+    _pin: PhantomPinned,
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
+            // SAFETY: `this->simple` is in-bounds. Pointer remains valid since this type is
+            // pinned.
+            active: Atomic::new(unsafe { &raw const (*this.as_ptr()).simple }),
+            _pin: PhantomPinned,
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
+        let mut ptr = self.active.load(Acquire);
+        if ptr::eq(ptr, &self.simple) {
+            self.upgrade(lock, name, key)?;
+            ptr = self.active.load(Acquire);
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
+            ptr::from_ref(&self.simple),
+            // SAFETY: This operation stays in-bounds of the above allocation.
+            unsafe { &raw mut (*upgraded).upgraded },
+            Release,
+        );
+
+        if res.is_err() {
+            // Already upgraded, so still succeess.
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
+        let ptr = unsafe { container_of!(ptr.cast_mut(), UpgradePollCondVarInner, upgraded) };
+        // SAFETY: The pointer points at a valid `wait_queue_head`.
+        unsafe { bindings::__wake_up_pollfree((*ptr).upgraded.wait_queue_head.get()) };
+        // This skips drop of `CondVar`, but that's ok because we reimplemented its drop here.
+        //
+        // SAFETY: `__wake_up_pollfree` ensures that all registered PollTable instances are gone in
+        // one grace period, and this is the destructor so no new PollTable instances can be
+        // registered. Thus, it's safety to rcu free the `UpgradePollCondVarInner`.
+        unsafe { bindings::kvfree_call_rcu((*ptr).rcu.get(), ptr.cast::<c_void>()) };
+    }
+}

-- 
2.53.0.273.g2a3d683680-goog


