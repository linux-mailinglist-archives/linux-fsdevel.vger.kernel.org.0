Return-Path: <linux-fsdevel+bounces-76031-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJpjIo54gGne8gIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76031-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 11:12:30 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C92FCAA37
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 11:12:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CE83D304262A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Feb 2026 10:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7855356A27;
	Mon,  2 Feb 2026 10:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dgZfY3Xo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255DA2D63F6;
	Mon,  2 Feb 2026 10:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770026807; cv=none; b=N33VCEHfQGHJg8u/OEi27xn8bxbpd7b2n3LiCoubKyX223IDmMQPLKAhl5pzI+oTo9t7etYtuoPOsmbbdvN884W5Bx2CqVvW0EHvwoEl24LohWfCWsCHb2AuQbtVkYrZEGhsOOztbuqg109eBbyTin9XlES6fHNBZo3YPzLkcSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770026807; c=relaxed/simple;
	bh=w3FSTDzx7E8mraZaaDGyuP+0xN6GQpY+/GPOVYPPtfQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WoEn70jhOEeP9ilMmI0M34pFc6GBwSP0vw7wHWn56eDCj73Pokv8fMjrmFCvBOQC3fI9XyqvXKdZc/bye4Xla5SF/gDMXdBedcJhUw+7r99jAvoOTPHaNbQLukrcfGhWRhyjBqTfwiIItHYKx3iDzo0+yavluCowpmhsFV5XhVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dgZfY3Xo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63F14C116C6;
	Mon,  2 Feb 2026 10:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770026806;
	bh=w3FSTDzx7E8mraZaaDGyuP+0xN6GQpY+/GPOVYPPtfQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=dgZfY3XoeXPfAlHYEFs2WdJH02wkLpOU1HKLIukQyXEEdGbPAdTtJNfOwFnpCb2jW
	 8zNtZArjMtIikbuiITY22wYZkNa3GjvOQB2eLX52+HjVBRcBv2KbjGxaWmBJJRds00
	 3Pdtavxjnj31/iZPiS8lkO8/7wHECWw7fSTee6ht+WWhC1jthkeMxWNdMOcADPE1F3
	 ctiM49lKA4RbPh0boINSS9Wa5Fy7RWX4TuBBMuHEgTDDFw7RSgRsmNtVL+axBZIdRc
	 KtSh02iXMz4dIwQqDWPOdFauOXFivQKx6vbJWiiyFPwzgWdMEWrOIK/cgiDe9OzoKi
	 DJvNbLzeSLZNg==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Gary Guo <gary@garyguo.net>, Oliver Mangold <oliver.mangold@pm.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>, Alice
 Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Benno Lossin
 <lossin@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Dave Ertman
 <david.m.ertman@intel.com>, Ira
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
In-Reply-To: <20251201155135.2b9c4084.gary@garyguo.net>
References: <20251117-unique-ref-v13-0-b5b243df1250@pm.me>
 <20251117-unique-ref-v13-1-b5b243df1250@pm.me>
 <20251201155135.2b9c4084.gary@garyguo.net>
Date: Mon, 02 Feb 2026 10:37:55 +0100
Message-ID: <87343jqydo.fsf@t14s.mail-host-address-is-not-set>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[42];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,protonmail.com,google.com,umich.edu,linuxfoundation.org,intel.com,linux.intel.com,suse.de,ffwll.ch,zeniv.linux.org.uk,suse.cz,oracle.com,ti.com,paul-moore.com,asahilina.net,vger.kernel.org,lists.freedesktop.org,kvack.org];
	TAGGED_FROM(0.00)[bounces-76031-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,t14s.mail-host-address-is-not-set:mid,asahilina.net:email,pm.me:email,garyguo.net:email]
X-Rspamd-Queue-Id: 0C92FCAA37
X-Rspamd-Action: no action

Gary Guo <gary@garyguo.net> writes:

> On Mon, 17 Nov 2025 10:07:40 +0000
> Oliver Mangold <oliver.mangold@pm.me> wrote:
>
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
>>   - Split code into separate file and `pub use` it from types.rs.
>>   - Make from_raw() and into_raw() public.
>>   - Remove OwnableMut, and make DerefMut dependent on Unpin instead.
>>   - Usage example/doctest for Ownable/Owned.
>>   - Fixes to documentation and commit message.
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
>>  rust/kernel/lib.rs       |   1 +
>>  rust/kernel/owned.rs     | 195 +++++++++++++++++++++++++++++++++++++++++++++++
>>  rust/kernel/sync/aref.rs |   5 ++
>>  rust/kernel/types.rs     |   2 +
>>  4 files changed, 203 insertions(+)
>> 
>> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
>> index 3dd7bebe7888..e0ee04330dd0 100644
>> --- a/rust/kernel/lib.rs
>> +++ b/rust/kernel/lib.rs
>> @@ -112,6 +112,7 @@
>>  pub mod of;
>>  #[cfg(CONFIG_PM_OPP)]
>>  pub mod opp;
>> +pub mod owned;
>>  pub mod page;
>>  #[cfg(CONFIG_PCI)]
>>  pub mod pci;
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
>
> The example given in the documentation below shows a valid way of
> defining a type that's handled on the Rust side, so I think this
> message is somewhat inaccurate.
>
> Perhaps something like
>
> 	Types that specify their own way of performing allocation and
> 	destruction. Typically, this trait is implemented on types from
> 	the C side.

Thanks, I'll use this.

>
> ?
>
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
>
> I can't parse this sentence. Is "out" supposed to be a different word?

I think it should be "our".

>
>> +/// unsafe impl Ownable for Foo {
>> +///     unsafe fn release(this: NonNull<Self>) {
>> +///         // The `Foo` will be dropped when `KBox` goes out of scope.
>
> I would just write `drop(unsafe { ... })` to make drop explicit instead
> of commenting about the implicit drop.

Agree, that is easier to read.

>
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
> Is this correct? If `Self<T>` is dropped then `T::release` is called so
> the pointer should also not be accessed further?

I can't follow you point here. Are you saying that the requirement is
wrong because `T::release` will access the object by reference? If so,
that is part of `Owned<_>::drop`, which is explicitly mentioned in the
comment (until .. dropped).

>
>> +    /// - The C code follows the usual shared reference requirements. That is, the kernel will never
>> +    ///   mutate or free the underlying object (excluding interior mutability that follows the usual
>> +    ///   rules) while Rust owns it.
>
> The concept "interior mutability" doesn't really exist on the C side.
> Also, use of interior mutability (by UnsafeCell) would be incorrect if
> the type is implemented in the rust side (as this requires a
> UnsafePinned).
>
> Interior mutability means things can be mutated behind a shared
> reference -- however in this case, we have a mutable reference (either
> `Pin<&mut Self>` or `&mut Self`)!
>
> Perhaps together with the next line, they could be just phrased like
> this?
>
> - The underlying object must not be accessed (read or mutated) through
>   any pointer other than the created `Owned<T>`.
>   Opt-out is still possbile similar to a mutable reference (e.g. by
>   using p`Opaque`]). 
>
> I think we should just tell the user "this is just a unique reference
> similar to &mut". They should be able to deduce that all the `!Unpin`
> that opts out from uniqueness of mutable reference applies here too.

I agree. I would suggest updating the struct documentation:

    @@ -108,7 +108,7 @@ pub unsafe trait Ownable {
        unsafe fn release(this: NonNull<Self>);
    }

    -/// An owned reference to an owned `T`.
    +/// An mutable reference to an owned `T`.
    ///
    /// The [`Ownable`] is automatically freed or released when an instance of [`Owned`] is
    /// dropped.

And then the safety requirement as

 An `Owned<T>` is a mutable reference to the underlying object. As such,
 the object must not be accessed (read or mutated) through any pointer
 other than the created `Owned<T>`. Opt-out is still possbile similar to
 a mutable reference (e.g. by using [`Opaque`]).


>> +    /// - In case `T` implements [`Unpin`] the previous requirement is extended from shared to
>> +    ///   mutable reference requirements. That is, the kernel will not mutate or free the underlying
>> +    ///   object and is okay with it being modified by Rust code.
>
> - If `T` implements [`Unpin`], the structure must not be mutated for
>   the entire lifetime of `Owned<T>`.

Would it be OK to just write "If `T: Unpin`, the ..."?

Again, opt out is possible, right?

>
>> +    pub unsafe fn from_raw(ptr: NonNull<T>) -> Self {
>
> This needs a (rather trivial) INVARIANT comment.

OK.

>
>> +        Self {
>> +            ptr,
>> +        }
>> +    }
>> +
>> +    /// Consumes the [`Owned`], returning a raw pointer.
>> +    ///
>> +    /// This function does not actually relinquish ownership of the object. After calling this
>
> Perhaps "relinquish" isn't the best word here? In my mental model
> this function is pretty much relinquishing ownership as `Owned<T>` no
> longer exists. It just doesn't release the object.

How about this:


    /// Consumes the [`Owned`], returning a raw pointer.
    ///
    /// This function does not drop the underlying `T`. When this function returns, ownership of the
    /// underlying `T` is with the caller.


Thanks for the comments!


Best regards,
Andreas Hindborg




