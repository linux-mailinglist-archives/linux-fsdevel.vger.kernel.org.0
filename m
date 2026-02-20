Return-Path: <linux-fsdevel+bounces-77775-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uEbVCFAxmGkRCgMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77775-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 11:02:56 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B856A1669BA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 11:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DFCC930847C8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 09:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B870332906;
	Fri, 20 Feb 2026 09:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ppi1/XPY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05AA31AAA3;
	Fri, 20 Feb 2026 09:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771581126; cv=none; b=OBEg6R2aaAWA/35URZbVzzFCT3xdo1HLJtuJ3qReCMMOCC3tYaDXDRHf4O2qB48PdU7GBgegkLb0hL3L1iB86VgrF6O9caZgaVfcBu2vaJfZQEgK4/1v73qqg5SGcNgp6/MrDOvmwWD+2AQIg14Xo3yyC0VrKZqL1JgjAaunUiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771581126; c=relaxed/simple;
	bh=+PodXl/wwBV+PA5BRedOUZgBWeTtGynnDCp6iX2CeiQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VM8wuCrMeUT6GMIN3Lf5Bcz32GsS5lC3z/wCX38kSYgT48W+bxPd0nII10LbhLF9kHxXvOBPROo704Nrgc4wVR4b9F91hH0zgIR4FulV7+1EKzXMKH+wYfDjulzVvjWwFDpyRvqYK0frkARwV+qHSxMSlTusb3Jg4IQSLtCpw60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ppi1/XPY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCB4AC116C6;
	Fri, 20 Feb 2026 09:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771581126;
	bh=+PodXl/wwBV+PA5BRedOUZgBWeTtGynnDCp6iX2CeiQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ppi1/XPYegHcMDBduaR2AnqAkljs+pg+qcNju89css9+XCAA0jXc1xa5GCd6lccdF
	 sygwslGFM1sjSX+cc1WCOxc9MrsU8O9OAQSF7HWz6gzaDOzuDVDrgz/8jS0Yytcykm
	 S/5/P/ZBaJZao2Ot0T5DiNLPV06ob5YYtkVhg+dZAAkYIGTGaiUz9puarlTz1QpKBT
	 SihqUp4jb2y9DuxrgGlLS++EpC+3RSBEmYi2jPMC2kCINRotKFCfLxNHHS0P2WQ1Zz
	 +alFa0pKOZvRtmwZd7zpfG7S+Z764JzwodHRmUqWBd4wHZ8Ihj35r6ODrJtkFOKUvc
	 kXMjlj21r3OtQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Fri, 20 Feb 2026 10:51:10 +0100
Subject: [PATCH v15 1/9] rust: types: Add Ownable/Owned types
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260220-unique-ref-v15-1-893ed86b06cc@kernel.org>
References: <20260220-unique-ref-v15-0-893ed86b06cc@kernel.org>
In-Reply-To: <20260220-unique-ref-v15-0-893ed86b06cc@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 Leon Romanovsky <leon@kernel.org>, Paul Moore <paul@paul-moore.com>, 
 Serge Hallyn <sergeh@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Igor Korotin <igor.korotin.linux@gmail.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Stephen Boyd <sboyd@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Boqun Feng <boqun@kernel.org>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-block@vger.kernel.org, linux-security-module@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, 
 Andreas Hindborg <a.hindborg@kernel.org>, 
 Asahi Lina <lina+kernel@asahilina.net>, 
 Oliver Mangold <oliver.mangold@pm.me>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=11400;
 i=a.hindborg@kernel.org; h=from:subject:message-id;
 bh=ceazmDY9zMprkGKe4DZha/pUGe1Tz44cJElMoCN5Ww8=;
 b=owEBbQKS/ZANAwAKAeG4Gj55KGN3AcsmYgBpmC6eV2ZYvrOTK3GwhcNVSnYwa0jqhZycgxRw5
 QAdJb+eFTaJAjMEAAEKAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaZgungAKCRDhuBo+eShj
 d/e/EAC578jug50o8pjquFcaOzJNQRtvp4mbQZhiWMJ5iKm9oustdqkgktfqn0ktoOPq6qzDSAf
 nCit66IsOx8Y5QwgAwpn5vgRuyydcCmTf25MIVyMGUzAoVqwSFgGaKYgqUSXo0pyf5CNfPEp6LM
 KEWAtxej9ZRYs8lmvR9ioAPmKDqvmdTW/o3cbjkbhVg8ggJ4KardbP9cXSBrn4ZGotp4sFki8LP
 4IHRo85AS/Occfn1IJ3K+iIQqvj1JnyuzSj+ZOZiS9ubqNbq3240QVNCdQ6lBGxFJZb/gWJirx6
 0spbB8Rt+9F1zlcymRrZDeOHuoputD/1g6NkCwsHer8mOSW2kzZhnCYKaDBE2wVqguZ/g+HExDm
 D2VXlCtYClx/+6NFFdg2OOjJ4aOrw+JUFMgJSv8IHtiXgdgZ/tiEVggwcRCFCX0L4fXLR6IATd5
 nghyX8WSexXNIv9kp25GkSSTtJvBuMJQIU1gkGP+e4BZyb4hi50P2jTxyuFZ5zxfbcOXFRxz8GS
 68OhvCuxZCdAyb5E45zsp1a/wiwzEyVSa1JDadKJOaJ0xhqkvBUjWiuJ7R7SpSSFYsShWY1vo2m
 U7PewVmuduHLx6zTOAWTZfVI8lbOtLpSEmh+HK4Rd4CQ1/u51PHr7nnQRIzdUZRRA5dBUlH5ZOq
 z5YBURXQAJRbopg==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [8.84 / 15.00];
	URIBL_BLACK(7.50)[types.rs:url];
	SUSPICIOUS_RECIPS(1.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77775-lists,linux-fsdevel=lfdr.de];
	R_DKIM_ALLOW(0.00)[kernel.org:s=k20201202];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	GREYLIST(0.00)[pass,body];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,garyguo.net,protonmail.com,google.com,umich.edu,linuxfoundation.org,intel.com,paul-moore.com,gmail.com,ffwll.ch,zeniv.linux.org.uk,suse.cz,collabora.com,oracle.com,ti.com];
	RCPT_COUNT_TWELVE(0.00)[42];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel,kernel];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[a.hindborg@kernel.org,linux-fsdevel@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c0a:e001:db::/64:c];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_SPAM(0.00)[0.675];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[asahilina.net:email,garyguo.net:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,pm.me:email,types.rs:url,collabora.com:email]
X-Rspamd-Queue-Id: B856A1669BA
X-Rspamd-Action: add header
X-Spam: Yes

From: Asahi Lina <lina+kernel@asahilina.net>

By analogy to `AlwaysRefCounted` and `ARef`, an `Ownable` type is a
(typically C FFI) type that *may* be owned by Rust, but need not be. Unlike
`AlwaysRefCounted`, this mechanism expects the reference to be unique
within Rust, and does not allow cloning.

Conceptually, this is similar to a `KBox<T>`, except that it delegates
resource management to the `T` instead of using a generic allocator.

[ om:
  - Split code into separate file and `pub use` it from types.rs.
  - Make from_raw() and into_raw() public.
  - Remove OwnableMut, and make DerefMut dependent on Unpin instead.
  - Usage example/doctest for Ownable/Owned.
  - Fixes to documentation and commit message.
]

Link: https://lore.kernel.org/all/20250202-rust-page-v1-1-e3170d7fe55e@asahilina.net/
Signed-off-by: Asahi Lina <lina+kernel@asahilina.net>
Co-developed-by: Oliver Mangold <oliver.mangold@pm.me>
Signed-off-by: Oliver Mangold <oliver.mangold@pm.me>
Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
[ Andreas: Updated documentation, examples, and formatting ]
Reviewed-by: Gary Guo <gary@garyguo.net>
Co-developed-by: Andreas Hindborg <a.hindborg@kernel.org>
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/lib.rs       |   1 +
 rust/kernel/owned.rs     | 196 +++++++++++++++++++++++++++++++++++++++++++++++
 rust/kernel/sync/aref.rs |   5 ++
 rust/kernel/types.rs     |  11 ++-
 4 files changed, 212 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 696f62f85eb5f..a2bec807f03f1 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -121,6 +121,7 @@
 pub mod of;
 #[cfg(CONFIG_PM_OPP)]
 pub mod opp;
+pub mod owned;
 pub mod page;
 #[cfg(CONFIG_PCI)]
 pub mod pci;
diff --git a/rust/kernel/owned.rs b/rust/kernel/owned.rs
new file mode 100644
index 0000000000000..d566ad0aa1c99
--- /dev/null
+++ b/rust/kernel/owned.rs
@@ -0,0 +1,196 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Unique owned pointer types for objects with custom drop logic.
+//!
+//! These pointer types are useful for C-allocated objects which by API-contract
+//! are owned by Rust, but need to be freed through the C API.
+
+use core::{
+    mem::ManuallyDrop,
+    ops::{
+        Deref,
+        DerefMut, //
+    },
+    pin::Pin,
+    ptr::NonNull, //
+};
+
+/// Types that specify their own way of performing allocation and destruction. Typically, this trait
+/// is implemented on types from the C side.
+///
+/// Implementing this trait allows types to be referenced via the [`Owned<Self>`] pointer type. This
+/// is useful when it is desirable to tie the lifetime of the reference to an owned object, rather
+/// than pass around a bare reference. [`Ownable`] types can define custom drop logic that is
+/// executed when the owned reference [`Owned<Self>`] pointing to the object is dropped.
+///
+/// Note: The underlying object is not required to provide internal reference counting, because it
+/// represents a unique, owned reference. If reference counting (on the Rust side) is required,
+/// [`AlwaysRefCounted`](crate::types::AlwaysRefCounted) should be implemented.
+///
+/// # Safety
+///
+/// Implementers must ensure that the [`release()`](Self::release) function frees the underlying
+/// object in the correct way for a valid, owned object of this type.
+///
+/// # Examples
+///
+/// A minimal example implementation of [`Ownable`] and its usage with [`Owned`] looks like
+/// this:
+///
+/// ```
+/// # #![expect(clippy::disallowed_names)]
+/// # use core::cell::Cell;
+/// # use core::ptr::NonNull;
+/// # use kernel::sync::global_lock;
+/// # use kernel::alloc::{flags, kbox::KBox, AllocError};
+/// # use kernel::types::{Owned, Ownable};
+///
+/// // Let's count the allocations to see if freeing works.
+/// kernel::sync::global_lock! {
+///     // SAFETY: we call `init()` right below, before doing anything else.
+///     unsafe(uninit) static FOO_ALLOC_COUNT: Mutex<usize> = 0;
+/// }
+/// // SAFETY: We call `init()` only once, here.
+/// unsafe { FOO_ALLOC_COUNT.init() };
+///
+/// struct Foo;
+///
+/// impl Foo {
+///     fn new() -> Result<Owned<Self>> {
+///         // We are just using a `KBox` here to handle the actual allocation, as our `Foo` is
+///         // not actually a C-allocated object.
+///         let result = KBox::new(
+///             Foo {},
+///             flags::GFP_KERNEL,
+///         )?;
+///         let result = NonNull::new(KBox::into_raw(result))
+///             .expect("Raw pointer to newly allocation KBox is null, this should never happen.");
+///         // Count new allocation
+///         *FOO_ALLOC_COUNT.lock() += 1;
+///         // SAFETY: We just allocated the `Self`, thus it is valid and there cannot be any other
+///         // Rust references. Calling `into_raw()` makes us responsible for ownership and we won't
+///         // use the raw pointer anymore. Thus we can transfer ownership to the `Owned`.
+///         Ok(unsafe { Owned::from_raw(result) })
+///     }
+/// }
+///
+/// // SAFETY: The implementation of `release` in this trait implementation correctly frees the
+/// // owned `Foo`.
+/// unsafe impl Ownable for Foo {
+///     unsafe fn release(this: NonNull<Self>) {
+///         // SAFETY: The [`KBox<Self>`] is still alive. We can pass ownership to the [`KBox`], as
+///         // by requirement on calling this function, the `Self` will no longer be used by the
+///         // caller.
+///         drop(unsafe { KBox::from_raw(this.as_ptr()) });
+///         // Count released allocation
+///         *FOO_ALLOC_COUNT.lock() -= 1;
+///     }
+/// }
+///
+/// {
+///    let foo = Foo::new().expect("Failed to allocate a Foo. This shouldn't happen");
+///    assert!(*FOO_ALLOC_COUNT.lock() == 1);
+/// }
+/// // `foo` is out of scope now, so we expect no live allocations.
+/// assert!(*FOO_ALLOC_COUNT.lock() == 0);
+/// ```
+pub unsafe trait Ownable {
+    /// Releases the object.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that:
+    /// - `this` points to a valid `Self`.
+    /// - `*this` is no longer used after this call.
+    unsafe fn release(this: NonNull<Self>);
+}
+
+/// A mutable reference to an owned `T`.
+///
+/// The [`Ownable`] is automatically freed or released when an instance of [`Owned`] is
+/// dropped.
+///
+/// # Invariants
+///
+/// - The [`Owned<T>`] has exclusive access to the instance of `T`.
+/// - The instance of `T` will stay alive at least as long as the [`Owned<T>`] is alive.
+pub struct Owned<T: Ownable> {
+    ptr: NonNull<T>,
+}
+
+impl<T: Ownable> Owned<T> {
+    /// Creates a new instance of [`Owned`].
+    ///
+    /// This function takes over ownership of the underlying object.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that:
+    /// - `ptr` points to a valid instance of `T`.
+    /// - Ownership of the underlying `T` can be transferred to the `Self<T>` (i.e. operations
+    ///   which require ownership will be safe).
+    /// - An `Owned<T>` is a mutable reference to the underlying object. As such,
+    ///   the object must not be accessed (read or mutated) through any pointer
+    ///   other than the created `Owned<T>`. Opt-out is still possible similar to
+    ///   a mutable reference (e.g. by using [`Opaque`]).
+    ///
+    /// [`Opaque`]: kernel::types::Opaque
+    pub unsafe fn from_raw(ptr: NonNull<T>) -> Self {
+        // INVARIANT: By function safety requirement:
+        // - The resulting object has exclusive access to the `T` pointed to by `ptr`.
+        // - The `T` object pointed to by `ptr` is alive at least as long as the returned `Self`.
+        Self { ptr }
+    }
+
+    /// Consumes the [`Owned`], returning a raw pointer.
+    ///
+    /// This function does not drop the underlying `T`. When this function returns, ownership of the
+    /// underlying `T` is with the caller.
+    pub fn into_raw(me: Self) -> NonNull<T> {
+        ManuallyDrop::new(me).ptr
+    }
+
+    /// Get a pinned mutable reference to the data owned by this `Owned<T>`.
+    pub fn as_pin_mut(&mut self) -> Pin<&mut T> {
+        // SAFETY: The type invariants guarantee that the object is valid, and that we can safely
+        // return a mutable reference to it.
+        let unpinned = unsafe { self.ptr.as_mut() };
+
+        // SAFETY: We never hand out unpinned mutable references to the data in
+        // `Self`, unless the contained type is `Unpin`.
+        unsafe { Pin::new_unchecked(unpinned) }
+    }
+}
+
+// SAFETY: It is safe to send an [`Owned<T>`] to another thread when the underlying `T` is [`Send`],
+// because of the ownership invariant. Sending an [`Owned<T>`] is equivalent to sending the `T`.
+unsafe impl<T: Ownable + Send> Send for Owned<T> {}
+
+// SAFETY: It is safe to send [`&Owned<T>`] to another thread when the underlying `T` is [`Sync`],
+// because of the ownership invariant. Sending an [`&Owned<T>`] is equivalent to sending the `&T`.
+unsafe impl<T: Ownable + Sync> Sync for Owned<T> {}
+
+impl<T: Ownable> Deref for Owned<T> {
+    type Target = T;
+
+    fn deref(&self) -> &Self::Target {
+        // SAFETY: The type invariants guarantee that the object is valid.
+        unsafe { self.ptr.as_ref() }
+    }
+}
+
+impl<T: Ownable + Unpin> DerefMut for Owned<T> {
+    fn deref_mut(&mut self) -> &mut Self::Target {
+        // SAFETY: The type invariants guarantee that the object is valid, and that we can safely
+        // return a mutable reference to it.
+        unsafe { self.ptr.as_mut() }
+    }
+}
+
+impl<T: Ownable> Drop for Owned<T> {
+    fn drop(&mut self) {
+        // SAFETY: The type invariants guarantee that the `Owned` owns the object we're about to
+        // release.
+        unsafe { T::release(self.ptr) };
+    }
+}
diff --git a/rust/kernel/sync/aref.rs b/rust/kernel/sync/aref.rs
index 0d24a0432015d..e175aefe86151 100644
--- a/rust/kernel/sync/aref.rs
+++ b/rust/kernel/sync/aref.rs
@@ -29,6 +29,11 @@
 /// Rust code, the recommendation is to use [`Arc`](crate::sync::Arc) to create reference-counted
 /// instances of a type.
 ///
+/// Note: Implementing this trait allows types to be wrapped in an [`ARef<Self>`]. It requires an
+/// internal reference count and provides only shared references. If unique references are required
+/// [`Ownable`](crate::types::Ownable) should be implemented which allows types to be wrapped in an
+/// [`Owned<Self>`](crate::types::Owned).
+///
 /// # Safety
 ///
 /// Implementers must ensure that increments to the reference count keep the object alive in memory
diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index 9c5e7dbf16323..4aec7b699269a 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -11,7 +11,16 @@
 };
 use pin_init::{PinInit, Wrapper, Zeroable};
 
-pub use crate::sync::aref::{ARef, AlwaysRefCounted};
+pub use crate::{
+    owned::{
+        Ownable,
+        Owned, //
+    },
+    sync::aref::{
+        ARef,
+        AlwaysRefCounted, //
+    }, //
+};
 
 /// Used to transfer ownership to and from foreign (non-Rust) languages.
 ///

-- 
2.51.2



