Return-Path: <linux-fsdevel+bounces-76034-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6M1HNHB5gGne8gIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76034-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 11:16:16 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 338B7CAB5C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 11:16:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E2F130CF5B8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Feb 2026 10:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79116357729;
	Mon,  2 Feb 2026 10:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iedtDU2z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA92E356A17;
	Mon,  2 Feb 2026 10:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770026835; cv=none; b=eJIPD2LP7+he2Ob0sF6gnQGUwSLQ1texYJCKxMZ8Aw4arY89e9dDlhw0A/p8EBRZS93+zZmO6Omk6lL34btdlkny80VXue63mQY1ljiIfbHkJ8A+At40KhPsMtCsHuu1ZMpRx/4fTQYiF1MxxV7CWOqnYcVdzKzUUgaXi34j7Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770026835; c=relaxed/simple;
	bh=Wry2JuYYSa8yAreaLGBkPhexHXm4HG/T1KgIp1vm03g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=q+Nj+HLIBrdYndjaSyyuHnhR/0l1eLC8957m0NYCWSH6LxUDEU2x82/kE3TpcXk4++Tvw/EK2SY1PZ6EThBkwbbv6Z+N6UWTcJDQBoFgFt/CkPWnk8QaG36TZYZN8KMFmq/SdMJdwBqwxWjNS+kaW+hlx8lMgBB8kPo0KtvPwx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iedtDU2z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DE68C116C6;
	Mon,  2 Feb 2026 10:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770026834;
	bh=Wry2JuYYSa8yAreaLGBkPhexHXm4HG/T1KgIp1vm03g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=iedtDU2zqvWzZTw+aiJDW9Apou6W8kQKd+z8bD7JbF+jzNiZb/iMTIlJwxmk4jN8D
	 Lf2BNqIztf4bcKs/gT78V+ycDOyUI+e2j8tvnsxRLCBy5bHV6vaBiw+DKXdS4PxobN
	 QM3mNyDUtMYjYu50PTJX8aUfNRjhQhUHKeyjqvjaqig2IADWvQKeB9DUvyNVC8MAGL
	 fdWx8WNBhoGS0DR83HUjiZ29c0t5cwNjwljpz7i667GjtMvxQtYTfxGrsa69EwBqKz
	 l9JUYo+MJCD2R9bb+uPVAy7TbGENZ9ZpkxamHOxES8SG21ksOa+3XavYcjST1OhO25
	 NTv6sIES9DVmQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Daniel Almeida <daniel.almeida@collabora.com>, Oliver Mangold
 <oliver.mangold@pm.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn?= Roy
 Baron <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Benno Lossin <lossin@kernel.org>, Danilo
 Krummrich <dakr@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Dave Ertman <david.m.ertman@intel.com>, Ira
 Weiny <ira.weiny@intel.com>, Leon Romanovsky <leon@kernel.org>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Lorenzo
 Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, Viresh Kumar <vireshk@kernel.org>, Nishanth
 Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, Bjorn Helgaas
 <bhelgaas@google.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, Paul
 Moore <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>, Asahi Lina
 <lina+kernel@asahilina.net>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-pm@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-security-module@vger.kernel.org
Subject: Re: [PATCH v13 1/4] rust: types: Add Ownable/Owned types
In-Reply-To: <C95B13F7-B3F5-4508-A862-EAD22EF56FE2@collabora.com>
References: <20251117-unique-ref-v13-0-b5b243df1250@pm.me>
 <20251117-unique-ref-v13-1-b5b243df1250@pm.me>
 <C95B13F7-B3F5-4508-A862-EAD22EF56FE2@collabora.com>
Date: Mon, 02 Feb 2026 10:14:50 +0100
Message-ID: <875x8fqzg5.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[43];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,garyguo.net,protonmail.com,google.com,umich.edu,linuxfoundation.org,intel.com,linux.intel.com,suse.de,ffwll.ch,zeniv.linux.org.uk,suse.cz,oracle.com,ti.com,paul-moore.com,asahilina.net,vger.kernel.org,lists.freedesktop.org,kvack.org];
	TAGGED_FROM(0.00)[bounces-76034-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[a.hindborg@kernel.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel,kernel];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[asahilina.net:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,collabora.com:email,types.rs:url,pm.me:email,t14s.mail-host-address-is-not-set:mid]
X-Rspamd-Queue-Id: 338B7CAB5C
X-Rspamd-Action: no action

Hi Daniel,

I'll send the next iteration of this series.

Daniel Almeida <daniel.almeida@collabora.com> writes:

> Hi Oliver,
>
>> On 17 Nov 2025, at 07:07, Oliver Mangold <oliver.mangold@pm.me> wrote:
>> 
>> From: Asahi Lina <lina+kernel@asahilina.net>
>> 
>> By analogy to `AlwaysRefCounted` and `ARef`, an `Ownable` type is a
>> (typically C FFI) type that *may* be owned by Rust, but need not be. Unlike
>> `AlwaysRefCounted`, this mechanism expects the reference to be unique
>> within Rust, and does not allow cloning.
>> 
>> Conceptually, this is similar to a `KBox<T>`, except that it delegates
>> resource management to the `T` instead of using a generic allocator.
>> 
>> [ om:
>>  - Split code into separate file and `pub use` it from types.rs.
>>  - Make from_raw() and into_raw() public.
>>  - Remove OwnableMut, and make DerefMut dependent on Unpin instead.
>>  - Usage example/doctest for Ownable/Owned.
>>  - Fixes to documentation and commit message.
>> ]
>> 
>> Link: https://lore.kernel.org/all/20250202-rust-page-v1-1-e3170d7fe55e@asahilina.net/
>> Signed-off-by: Asahi Lina <lina+kernel@asahilina.net>
>> Co-developed-by: Oliver Mangold <oliver.mangold@pm.me>
>> Signed-off-by: Oliver Mangold <oliver.mangold@pm.me>
>> Co-developed-by: Andreas Hindborg <a.hindborg@kernel.org>
>> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
>> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
>> ---
>> rust/kernel/lib.rs       |   1 +
>> rust/kernel/owned.rs     | 195 +++++++++++++++++++++++++++++++++++++++++++++++
>> rust/kernel/sync/aref.rs |   5 ++
>> rust/kernel/types.rs     |   2 +
>> 4 files changed, 203 insertions(+)
>> 
>> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
>> index 3dd7bebe7888..e0ee04330dd0 100644
>> --- a/rust/kernel/lib.rs
>> +++ b/rust/kernel/lib.rs
>> @@ -112,6 +112,7 @@
>> pub mod of;
>> #[cfg(CONFIG_PM_OPP)]
>> pub mod opp;
>> +pub mod owned;
>> pub mod page;
>> #[cfg(CONFIG_PCI)]
>> pub mod pci;
>> diff --git a/rust/kernel/owned.rs b/rust/kernel/owned.rs
>> new file mode 100644
>> index 000000000000..a2cdd2cb8a10
>> --- /dev/null
>> +++ b/rust/kernel/owned.rs
>> @@ -0,0 +1,195 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +//! Unique owned pointer types for objects with custom drop logic.
>> +//!
>> +//! These pointer types are useful for C-allocated objects which by API-contract
>> +//! are owned by Rust, but need to be freed through the C API.
>> +
>> +use core::{
>> +    mem::ManuallyDrop,
>> +    ops::{Deref, DerefMut},
>> +    pin::Pin,
>> +    ptr::NonNull,
>> +};
>> +
>> +/// Type allocated and destroyed on the C side, but owned by Rust.
>> +///
>> +/// Implementing this trait allows types to be referenced via the [`Owned<Self>`] pointer type. This
>> +/// is useful when it is desirable to tie the lifetime of the reference to an owned object, rather
>> +/// than pass around a bare reference. [`Ownable`] types can define custom drop logic that is
>> +/// executed when the owned reference [`Owned<Self>`] pointing to the object is dropped.
>> +///
>> +/// Note: The underlying object is not required to provide internal reference counting, because it
>> +/// represents a unique, owned reference. If reference counting (on the Rust side) is required,
>> +/// [`AlwaysRefCounted`](crate::types::AlwaysRefCounted) should be implemented.
>> +///
>> +/// # Safety
>> +///
>> +/// Implementers must ensure that the [`release()`](Self::release) function frees the underlying
>> +/// object in the correct way for a valid, owned object of this type.
>> +///
>> +/// # Examples
>> +///
>> +/// A minimal example implementation of [`Ownable`] and its usage with [`Owned`] looks like this:
>> +///
>> +/// ```
>> +/// # #![expect(clippy::disallowed_names)]
>> +/// # use core::cell::Cell;
>> +/// # use core::ptr::NonNull;
>> +/// # use kernel::sync::global_lock;
>> +/// # use kernel::alloc::{flags, kbox::KBox, AllocError};
>> +/// # use kernel::types::{Owned, Ownable};
>> +///
>> +/// // Let's count the allocations to see if freeing works.
>> +/// kernel::sync::global_lock! {
>> +///     // SAFETY: we call `init()` right below, before doing anything else.
>> +///     unsafe(uninit) static FOO_ALLOC_COUNT: Mutex<usize> = 0;
>> +/// }
>> +/// // SAFETY: We call `init()` only once, here.
>> +/// unsafe { FOO_ALLOC_COUNT.init() };
>> +///
>> +/// struct Foo {
>> +/// }
>
> nit: this can be simply:
>
> struct Foo;

Got it.

>
>> +///
>> +/// impl Foo {
>> +///     fn new() -> Result<Owned<Self>, AllocError> {
>> +///         // We are just using a `KBox` here to handle the actual allocation, as our `Foo` is
>> +///         // not actually a C-allocated object.
>> +///         let result = KBox::new(
>> +///             Foo {},
>> +///             flags::GFP_KERNEL,
>> +///         )?;
>> +///         let result = NonNull::new(KBox::into_raw(result))
>> +///             .expect("Raw pointer to newly allocation KBox is null, this should never happen.");
>> +///         // Count new allocation
>> +///         *FOO_ALLOC_COUNT.lock() += 1;
>> +///         // SAFETY: We just allocated the `Self`, thus it is valid and there cannot be any other
>> +///         // Rust references. Calling `into_raw()` makes us responsible for ownership and we won't
>> +///         // use the raw pointer anymore. Thus we can transfer ownership to the `Owned`.
>> +///         Ok(unsafe { Owned::from_raw(result) })
>> +///     }
>> +/// }
>> +///
>> +/// // SAFETY: What out `release()` function does is safe of any valid `Self`.
>> +/// unsafe impl Ownable for Foo {
>> +///     unsafe fn release(this: NonNull<Self>) {
>> +///         // The `Foo` will be dropped when `KBox` goes out of scope.
>> +///         // SAFETY: The [`KBox<Self>`] is still alive. We can pass ownership to the [`KBox`], as
>> +///         // by requirement on calling this function, the `Self` will no longer be used by the
>> +///         // caller.
>> +///         unsafe { KBox::from_raw(this.as_ptr()) };
>> +///         // Count released allocation
>> +///         *FOO_ALLOC_COUNT.lock() -= 1;
>> +///     }
>> +/// }
>> +///
>> +/// {
>> +///    let foo = Foo::new().expect("Failed to allocate a Foo. This shouldn't happen");
>> +///    assert!(*FOO_ALLOC_COUNT.lock() == 1);
>> +/// }
>> +/// // `foo` is out of scope now, so we expect no live allocations.
>> +/// assert!(*FOO_ALLOC_COUNT.lock() == 0);
>> +/// ```
>> +pub unsafe trait Ownable {
>> +    /// Releases the object.
>> +    ///
>> +    /// # Safety
>> +    ///
>> +    /// Callers must ensure that:
>> +    /// - `this` points to a valid `Self`.
>> +    /// - `*this` is no longer used after this call.
>> +    unsafe fn release(this: NonNull<Self>);
>> +}
>> +
>> +/// An owned reference to an owned `T`.
>> +///
>> +/// The [`Ownable`] is automatically freed or released when an instance of [`Owned`] is
>> +/// dropped.
>> +///
>> +/// # Invariants
>> +///
>> +/// - The [`Owned<T>`] has exclusive access to the instance of `T`.
>> +/// - The instance of `T` will stay alive at least as long as the [`Owned<T>`] is alive.
>> +pub struct Owned<T: Ownable> {
>> +    ptr: NonNull<T>,
>> +}
>> +
>> +// SAFETY: It is safe to send an [`Owned<T>`] to another thread when the underlying `T` is [`Send`],
>> +// because of the ownership invariant. Sending an [`Owned<T>`] is equivalent to sending the `T`.
>> +unsafe impl<T: Ownable + Send> Send for Owned<T> {}
>> +
>> +// SAFETY: It is safe to send [`&Owned<T>`] to another thread when the underlying `T` is [`Sync`],
>> +// because of the ownership invariant. Sending an [`&Owned<T>`] is equivalent to sending the `&T`.
>> +unsafe impl<T: Ownable + Sync> Sync for Owned<T> {}
>> +
>> +impl<T: Ownable> Owned<T> {
>
> Can you make sure that impl Owned<T> follows the struct declaration?
>
> IOW: please move the Send and Sync impls to be after the impl above.

I don't really see the point, but moving them is no problem, so let's do that.

>
>> +    /// Creates a new instance of [`Owned`].
>> +    ///
>> +    /// It takes over ownership of the underlying object.
>> +    ///
>> +    /// # Safety
>> +    ///
>> +    /// Callers must ensure that:
>> +    /// - `ptr` points to a valid instance of `T`.
>> +    /// - Ownership of the underlying `T` can be transferred to the `Self<T>` (i.e. operations
>> +    ///   which require ownership will be safe).
>> +    /// - No other Rust references to the underlying object exist. This implies that the underlying
>> +    ///   object is not accessed through `ptr` anymore after the function call (at least until the
>> +    ///   the `Self<T>` is dropped.
>
> It looks like this can be written more succinctly as:
>
> "This implies that the underlying object is not accessed through `ptr` anymore until `Self<T>` is dropped."

I'll rephrase with that text.

>
>> +    /// - The C code follows the usual shared reference requirements. That is, the kernel will never
>> +    ///   mutate or free the underlying object (excluding interior mutability that follows the usual
>> +    ///   rules) while Rust owns it.
>> +    /// - In case `T` implements [`Unpin`] the previous requirement is extended from shared to
>> +    ///   mutable reference requirements. That is, the kernel will not mutate or free the underlying
>> +    ///   object and is okay with it being modified by Rust code.
>> +    pub unsafe fn from_raw(ptr: NonNull<T>) -> Self {
>> +        Self {
>> +            ptr,
>> +        }
>> +    }
>> +
>> +    /// Consumes the [`Owned`], returning a raw pointer.
>> +    ///
>> +    /// This function does not actually relinquish ownership of the object. After calling this
>> +    /// function, the caller is responsible for ownership previously managed
>> +    /// by the [`Owned`].
>> +    pub fn into_raw(me: Self) -> NonNull<T> {
>> +        ManuallyDrop::new(me).ptr
>> +    }
>> +
>> +    /// Get a pinned mutable reference to the data owned by this `Owned<T>`.
>> +    pub fn get_pin_mut(&mut self) -> Pin<&mut T> {
>> +        // SAFETY: The type invariants guarantee that the object is valid, and that we can safely
>> +        // return a mutable reference to it.
>> +        let unpinned = unsafe { self.ptr.as_mut() };
>> +
>> +        // SAFETY: We never hand out unpinned mutable references to the data in
>> +        // `Self`, unless the contained type is `Unpin`.
>> +        unsafe { Pin::new_unchecked(unpinned) }
>> +    }
>> +}
>> +
>> +impl<T: Ownable> Deref for Owned<T> {
>> +    type Target = T;
>> +
>> +    fn deref(&self) -> &Self::Target {
>> +        // SAFETY: The type invariants guarantee that the object is valid.
>> +        unsafe { self.ptr.as_ref() }
>> +    }
>> +}
>> +
>> +impl<T: Ownable + Unpin> DerefMut for Owned<T> {
>> +    fn deref_mut(&mut self) -> &mut Self::Target {
>> +        // SAFETY: The type invariants guarantee that the object is valid, and that we can safely
>> +        // return a mutable reference to it.
>> +        unsafe { self.ptr.as_mut() }
>> +    }
>> +}
>> +
>> +impl<T: Ownable> Drop for Owned<T> {
>> +    fn drop(&mut self) {
>> +        // SAFETY: The type invariants guarantee that the `Owned` owns the object we're about to
>> +        // release.
>> +        unsafe { T::release(self.ptr) };
>> +    }
>> +}
>> diff --git a/rust/kernel/sync/aref.rs b/rust/kernel/sync/aref.rs
>> index 0d24a0432015..e175aefe8615 100644
>> --- a/rust/kernel/sync/aref.rs
>> +++ b/rust/kernel/sync/aref.rs
>> @@ -29,6 +29,11 @@
>> /// Rust code, the recommendation is to use [`Arc`](crate::sync::Arc) to create reference-counted
>> /// instances of a type.
>> ///
>> +/// Note: Implementing this trait allows types to be wrapped in an [`ARef<Self>`]. It requires an
>> +/// internal reference count and provides only shared references. If unique references are required
>> +/// [`Ownable`](crate::types::Ownable) should be implemented which allows types to be wrapped in an
>> +/// [`Owned<Self>`](crate::types::Owned).
>> +///
>> /// # Safety
>> ///
>> /// Implementers must ensure that increments to the reference count keep the object alive in memory
>> diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
>> index dc0a02f5c3cf..7bc07c38cd6c 100644
>> --- a/rust/kernel/types.rs
>> +++ b/rust/kernel/types.rs
>> @@ -11,6 +11,8 @@
>> };
>> use pin_init::{PinInit, Wrapper, Zeroable};
>> 
>> +pub use crate::owned::{Ownable, Owned};
>> +
>> pub use crate::sync::aref::{ARef, AlwaysRefCounted};
>> 
>> /// Used to transfer ownership to and from foreign (non-Rust) languages.
>> 
>> -- 
>> 2.51.2
>> 
>> 
>> 
>
> With the changes above,
>
> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>

Thanks!


