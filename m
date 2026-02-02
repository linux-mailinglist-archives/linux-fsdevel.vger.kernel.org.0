Return-Path: <linux-fsdevel+bounces-76032-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QOj3Lz55gGne8gIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76032-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 11:15:26 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C8CCAAFF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 11:15:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CDFDD308561C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Feb 2026 10:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125C73570BA;
	Mon,  2 Feb 2026 10:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z7SYgy4v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8694C2727F3;
	Mon,  2 Feb 2026 10:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770026816; cv=none; b=tzN7Twstsa9VmoX/rFRd0kYAElPNpRlQ9za0cDOtwfw4zjcyoHl/zqm7tjbssguHxUwzLPd93rIWyDlYx6auBhDZ1eMr4BOq9UUKebkOm7qS1fFjt78JkSrcQixgjfKUtFSHGBTYFC+v0Pl9H+Gk/e5Nki0ww32l2HGe//0DfgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770026816; c=relaxed/simple;
	bh=DlHoOTLxIxjAjwF5rSYvlt5G94iLnc2c4QiF0If3+SU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=t8OJi+wdqMmu8qgfhDC1G1kaVmKiS327dyRwn8PNMeBzBjvahTAnTegyVbgPFPzpUjsI8x8qYK74SR28OxiqOYqmuaJFxYOMTcEximddku/iV1+DeFpSWxpNUTgNcV3hiOqjrykmClkRblbLmg/AH7U4HFvzCBhbvM6NFpQUsKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z7SYgy4v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 611DFC116D0;
	Mon,  2 Feb 2026 10:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770026816;
	bh=DlHoOTLxIxjAjwF5rSYvlt5G94iLnc2c4QiF0If3+SU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Z7SYgy4v07w1AugBQ5PySBoJ5Ew8y2VILV4q+TXbJbgSA0KpfHpLuNExlQ1DT56bW
	 TpinW8kxfX+Y9FWOzp1Ipg4NMzWUgxmVikG1asAF3MP4u2VTxqYM0SxoWxFaksQb0f
	 5pwYNOWOq5rkrRx3UenvjAm7+bLAysTDYv53RV/Xksnwv4Ns4uNumHpoV8Ml2F1/RC
	 Xv1PTuTZn1wgrxLtSIuJo8eIAmzPFcKcRRDrcccfDXjFjbMZcOQchhPQe8ofUspMvX
	 lmUh0Ejhus8nx+FbJeHrXB+GRK2jPzA7e+jFf2+I5aAdfF9bGc1ZwzWxMdKMYB0v+9
	 /jrdOL/XLZz+A==
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
Subject: Re: [PATCH v13 4/4] rust: Add `OwnableRefCounted`
In-Reply-To: <A5A7C4C9-1504-439C-B4FF-C28482AF7444@collabora.com>
References: <20251117-unique-ref-v13-0-b5b243df1250@pm.me>
 <20251117-unique-ref-v13-4-b5b243df1250@pm.me>
 <A5A7C4C9-1504-439C-B4FF-C28482AF7444@collabora.com>
Date: Mon, 02 Feb 2026 11:06:02 +0100
Message-ID: <87qzr3piid.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76032-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,garyguo.net,protonmail.com,google.com,umich.edu,linuxfoundation.org,intel.com,linux.intel.com,suse.de,ffwll.ch,zeniv.linux.org.uk,suse.cz,oracle.com,ti.com,paul-moore.com,asahilina.net,vger.kernel.org,lists.freedesktop.org,kvack.org];
	RCPT_COUNT_TWELVE(0.00)[43];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[a.hindborg@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel,kernel];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pm.me:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,t14s.mail-host-address-is-not-set:mid,collabora.com:email]
X-Rspamd-Queue-Id: 17C8CCAAFF
X-Rspamd-Action: no action

Daniel Almeida <daniel.almeida@collabora.com> writes:

> Hi Oliver,
>
>> On 17 Nov 2025, at 07:08, Oliver Mangold <oliver.mangold@pm.me> wrote:
>>=20
>> Types implementing one of these traits can safely convert between an
>> `ARef<T>` and an `Owned<T>`.
>>=20
>> This is useful for types which generally are accessed through an `ARef`
>> but have methods which can only safely be called when the reference is
>> unique, like e.g. `block::mq::Request::end_ok()`.
>>=20
>> Signed-off-by: Oliver Mangold <oliver.mangold@pm.me>
>> Co-developed-by: Andreas Hindborg <a.hindborg@kernel.org>
>> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
>> Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
>> ---
>> rust/kernel/owned.rs     | 138 +++++++++++++++++++++++++++++++++++++++++=
+++---
>> rust/kernel/sync/aref.rs |  11 +++-
>> rust/kernel/types.rs     |   2 +-
>> 3 files changed, 141 insertions(+), 10 deletions(-)
>>=20
>> diff --git a/rust/kernel/owned.rs b/rust/kernel/owned.rs
>> index a26747cbc13b..26ab2b00ada0 100644
>> --- a/rust/kernel/owned.rs
>> +++ b/rust/kernel/owned.rs
>> @@ -5,6 +5,7 @@
>> //! These pointer types are useful for C-allocated objects which by API-=
contract
>> //! are owned by Rust, but need to be freed through the C API.
>>=20
>> +use crate::sync::aref::{ARef, RefCounted};
>> use core::{
>>     mem::ManuallyDrop,
>>     ops::{Deref, DerefMut},
>> @@ -14,14 +15,16 @@
>>=20
>> /// Type allocated and destroyed on the C side, but owned by Rust.
>> ///
>> -/// Implementing this trait allows types to be referenced via the [`Own=
ed<Self>`] pointer type. This
>> -/// is useful when it is desirable to tie the lifetime of the reference=
 to an owned object, rather
>> -/// than pass around a bare reference. [`Ownable`] types can define cus=
tom drop logic that is
>> -/// executed when the owned reference [`Owned<Self>`] pointing to the o=
bject is dropped.
>> +/// Implementing this trait allows types to be referenced via the [`Own=
ed<Self>`] pointer type.
>> +///  - This is useful when it is desirable to tie the lifetime of an ob=
ject reference to an owned
>> +///    object, rather than pass around a bare reference.
>> +///  - [`Ownable`] types can define custom drop logic that is executed =
when the owned reference
>> +///    of type [`Owned<_>`] pointing to the object is dropped.
>> ///
>> /// Note: The underlying object is not required to provide internal refe=
rence counting, because it
>> /// represents a unique, owned reference. If reference counting (on the =
Rust side) is required,
>> -/// [`RefCounted`](crate::types::RefCounted) should be implemented.
>> +/// [`RefCounted`] should be implemented. [`OwnableRefCounted`] should =
be implemented if conversion
>> +/// between unique and shared (reference counted) ownership is needed.
>> ///
>> /// # Safety
>> ///
>> @@ -143,9 +146,7 @@ impl<T: Ownable> Owned<T> {
>>     ///   mutable reference requirements. That is, the kernel will not m=
utate or free the underlying
>>     ///   object and is okay with it being modified by Rust code.
>>     pub unsafe fn from_raw(ptr: NonNull<T>) -> Self {
>> -        Self {
>> -            ptr,
>> -        }
>> +        Self { ptr }
>>     }
>
> Unrelated change?

Looks like a rustfmt thing. I'll split it out or remove it.

>
>>=20
>>     /// Consumes the [`Owned`], returning a raw pointer.
>> @@ -193,3 +194,124 @@ fn drop(&mut self) {
>>         unsafe { T::release(self.ptr) };
>>     }
>> }
>> +
>> +/// A trait for objects that can be wrapped in either one of the refere=
nce types [`Owned`] and
>> +/// [`ARef`].
>> +///
>> +/// # Examples
>> +///
>> +/// A minimal example implementation of [`OwnableRefCounted`], [`Ownabl=
e`] and its usage with
>> +/// [`ARef`] and [`Owned`] looks like this:
>> +///
>> +/// ```
>> +/// # #![expect(clippy::disallowed_names)]
>> +/// # use core::cell::Cell;
>> +/// # use core::ptr::NonNull;
>> +/// # use kernel::alloc::{flags, kbox::KBox, AllocError};
>> +/// # use kernel::sync::aref::{ARef, RefCounted};
>> +/// # use kernel::types::{Owned, Ownable, OwnableRefCounted};
>> +///
>> +/// // Example internally refcounted struct.
>
> nit: IMHO the wording could improve ^

/// // An internally refcounted struct for demonstration purposes.

>
>> +/// //
>> +/// // # Invariants
>> +/// //
>> +/// // - `refcount` is always non-zero for a valid object.
>> +/// // - `refcount` is >1 if there are more than 1 Rust reference to it.
>> +/// //
>> +/// struct Foo {
>> +///     refcount: Cell<usize>,
>> +/// }
>> +///
>> +/// impl Foo {
>> +///     fn new() -> Result<Owned<Self>, AllocError> {
>> +///         // We are just using a `KBox` here to handle the actual all=
ocation, as our `Foo` is
>> +///         // not actually a C-allocated object.
>> +///         let result =3D KBox::new(
>> +///             Foo {
>> +///                 refcount: Cell::new(1),
>> +///             },
>> +///             flags::GFP_KERNEL,
>> +///         )?;
>> +///         let result =3D NonNull::new(KBox::into_raw(result))
>> +///             .expect("Raw pointer to newly allocation KBox is null, =
this should never happen.");
>> +///         // SAFETY: We just allocated the `Self`, thus it is valid a=
nd there cannot be any other
>> +///         // Rust references. Calling `into_raw()` makes us responsib=
le for ownership and
>> +///         // we won't use the raw pointer anymore, thus we can transf=
er ownership to the `Owned`.
>> +///         Ok(unsafe { Owned::from_raw(result) })
>> +///     }
>> +/// }
>> +///
>> +/// // SAFETY: We increment and decrement each time the respective func=
tion is called and only free
>> +/// // the `Foo` when the refcount reaches zero.
>> +/// unsafe impl RefCounted for Foo {
>> +///     fn inc_ref(&self) {
>> +///         self.refcount.replace(self.refcount.get() + 1);
>> +///     }
>> +///
>> +///     unsafe fn dec_ref(this: NonNull<Self>) {
>> +///         // SAFETY: By requirement on calling this function, the ref=
count is non-zero,
>> +///         // implying the underlying object is valid.
>> +///         let refcount =3D unsafe { &this.as_ref().refcount };
>> +///         let new_refcount =3D refcount.get() - 1;
>> +///         if new_refcount =3D=3D 0 {
>> +///             // The `Foo` will be dropped when `KBox` goes out of sc=
ope.
>> +///             // SAFETY: The [`KBox<Foo>`] is still alive as the old =
refcount is 1. We can pass
>> +///             // ownership to the [`KBox`] as by requirement on calli=
ng this function,
>> +///             // the `Self` will no longer be used by the caller.
>> +///             unsafe { KBox::from_raw(this.as_ptr()) };
>> +///         } else {
>> +///             refcount.replace(new_refcount);
>> +///         }
>> +///     }
>> +/// }
>> +///
>> +/// impl OwnableRefCounted for Foo {
>> +///     fn try_from_shared(this: ARef<Self>) -> Result<Owned<Self>, ARe=
f<Self>> {
>> +///         if this.refcount.get() =3D=3D 1 {
>> +///             // SAFETY: The `Foo` is still alive and has no other Ru=
st references as the refcount
>> +///             // is 1.
>> +///             Ok(unsafe { Owned::from_raw(ARef::into_raw(this)) })
>> +///         } else {
>> +///             Err(this)
>> +///         }
>> +///     }
>> +/// }
>> +///
>
> We wouldn=E2=80=99t need this implementation if we added a =E2=80=9Crefco=
unt()=E2=80=9D
> member to this trait. This lets you abstract away this logic for all
> implementors, which has the massive upside of making sure we hardcode (an=
d thus
> enforce) the refcount =3D=3D 1 check.

This exist to allow reference counting schemes that are different from
the general implementation. See [1] for an example.

[1] https://github.com/metaspace/linux/blob/3e46e95f0707fa71259b1d241f68914=
4ad61cc62/rust/kernel/block/mq/request.rs#L478

>
>
>> +/// // SAFETY: This implementation of `release()` is safe for any valid=
 `Self`.
>> +/// unsafe impl Ownable for Foo {
>> +///     unsafe fn release(this: NonNull<Self>) {
>> +///         // SAFETY: Using `dec_ref()` from [`RefCounted`] to release=
 is okay, as the refcount is
>> +///         // always 1 for an [`Owned<Foo>`].
>> +///         unsafe{ Foo::dec_ref(this) };
>> +///     }
>> +/// }
>> +///
>> +/// let foo =3D Foo::new().expect("Failed to allocate a Foo. This shoul=
dn't happen");
>
> All these =E2=80=9Cexpects()=E2=80=9D and custom error strings would go a=
way if you
> place this behind a fictional function that returns Result.

I'll do that.

>
>> +/// let mut foo =3D ARef::from(foo);
>> +/// {
>> +///     let bar =3D foo.clone();
>> +///     assert!(Owned::try_from(bar).is_err());
>> +/// }
>> +/// assert!(Owned::try_from(foo).is_ok());
>> +/// ```
>> +pub trait OwnableRefCounted: RefCounted + Ownable + Sized {
>> +    /// Checks if the [`ARef`] is unique and convert it to an [`Owned`]=
 it that is that case.
>> +    /// Otherwise it returns again an [`ARef`] to the same underlying o=
bject.
>> +    fn try_from_shared(this: ARef<Self>) -> Result<Owned<Self>, ARef<Se=
lf>>;
>
> Again, this method can go way if we add a method to expose the refcount.
>
>> +
>> +    /// Converts the [`Owned`] into an [`ARef`].
>> +    fn into_shared(this: Owned<Self>) -> ARef<Self> {
>> +        // SAFETY: Safe by the requirements on implementing the trait.
>> +        unsafe { ARef::from_raw(Owned::into_raw(this)) }
>> +    }
>> +}
>> +
>> +impl<T: OwnableRefCounted> TryFrom<ARef<T>> for Owned<T> {
>> +    type Error =3D ARef<T>;
>> +    /// Tries to convert the [`ARef`] to an [`Owned`] by calling
>> +    /// [`try_from_shared()`](OwnableRefCounted::try_from_shared). In c=
ase the [`ARef`] is not
>> +    /// unique, it returns again an [`ARef`] to the same underlying obj=
ect.
>> +    fn try_from(b: ARef<T>) -> Result<Owned<T>, Self::Error> {
>> +        T::try_from_shared(b)
>> +    }
>> +}
>> diff --git a/rust/kernel/sync/aref.rs b/rust/kernel/sync/aref.rs
>> index 937dcf6ed5de..2dbffe2ed1b8 100644
>> --- a/rust/kernel/sync/aref.rs
>> +++ b/rust/kernel/sync/aref.rs
>> @@ -30,7 +30,10 @@
>> /// Note: Implementing this trait allows types to be wrapped in an [`ARe=
f<Self>`]. It requires an
>> /// internal reference count and provides only shared references. If uni=
que references are required
>> /// [`Ownable`](crate::types::Ownable) should be implemented which allow=
s types to be wrapped in an
>> -/// [`Owned<Self>`](crate::types::Owned).
>> +/// [`Owned<Self>`](crate::types::Owned). Implementing the trait
>> +/// [`OwnableRefCounted`](crate::types::OwnableRefCounted) allows to co=
nvert between unique and
>> +/// shared references (i.e. [`Owned<Self>`](crate::types::Owned) and
>> +/// [`ARef<Self>`](crate::types::Owned)).
>> ///
>> /// # Safety
>> ///
>> @@ -180,6 +183,12 @@ fn from(b: &T) -> Self {
>>     }
>> }
>>=20
>> +impl<T: crate::types::OwnableRefCounted> From<crate::types::Owned<T>> f=
or ARef<T> {
>> +    fn from(b: crate::types::Owned<T>) -> Self {
>> +        T::into_shared(b)
>> +    }
>> +}
>> +
>
> Not sure why we=E2=80=99re using fully-qualified names here if we can imp=
ort them, but your call.

I'll import them.


Best regards,
Andreas Hindborg



