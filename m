Return-Path: <linux-fsdevel+bounces-76033-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6NMoORZ5gGne8gIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76033-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 11:14:46 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A07CAAE2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 11:14:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7B7E630802CC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Feb 2026 10:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E513570C1;
	Mon,  2 Feb 2026 10:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e5PbZqeG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E1C30C60B;
	Mon,  2 Feb 2026 10:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770026825; cv=none; b=O+6zF03ld9tLzxKKHmdas+GCIAZLXup+640N5umLfxI9OUwvFYbGAlE4qvEnSRVyP+ICePY3FIfavWQZSFJ6eMh/ojtXG+ZRb0CzKPM1mz7HlQv4mNNzHp+bgfZOWt+jbHBc+6vczyHfh4YZrnwAQJa12EkHcMeHS4ASJEV3VjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770026825; c=relaxed/simple;
	bh=Eoz9zMafNvstkx4rEp0VfTMcdw5aRQGaOa9zX9uZrvE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=u+80GgQqyVeE80j7nkbfQDn/AHywulGfQkfDp28DWnEgMEgEpjUeoQmDtYbaBddkmEopCboApTnMPG3rVGtDg0Kem7IG443dM+cuMaInh40ytjunc9IFSkK1ae8jSzwiASId0hi4ajfZVn0fnztIw8yMdAMeXj9OptHCw4R/Nyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e5PbZqeG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC965C116C6;
	Mon,  2 Feb 2026 10:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770026825;
	bh=Eoz9zMafNvstkx4rEp0VfTMcdw5aRQGaOa9zX9uZrvE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=e5PbZqeGd0v4sDy8RQ9a86lPLQEbDNw6s5XkIwev6B6PAuEcw75JB3Pw4EYUaBjcd
	 g5Svf/EF8SVHbWekh80wQ50Bg0dGtkSiAn9c2iUMekvNBER0RPfx4BcVgvIsP9+CMR
	 q2t5l4XnbnigFtD0kWR1MjJmmjb0KrP3p2dbA1J+xkbl6KT6qEYseSppIktWJbKn7A
	 09k41/lMwyKnO4QOU0ax9FF0bPegWsb7FGZFejdFHfPOrpiWXUGW3qIXrIVdi064cv
	 Td1WoK0gbaBSanmoLD8Q58qcesEqeZdJPnJ/9Lj0fmTUqdgpM1wVDFkqqKdaZzHNzX
	 rfIMj7JQRKOAw==
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
Subject: Re: [PATCH v13 2/4] rust: `AlwaysRefCounted` is renamed to
 `RefCounted`.
In-Reply-To: <D2C11077-2001-4E45-8039-C999E6CA5606@collabora.com>
References: <20251117-unique-ref-v13-0-b5b243df1250@pm.me>
 <20251117-unique-ref-v13-2-b5b243df1250@pm.me>
 <D2C11077-2001-4E45-8039-C999E6CA5606@collabora.com>
Date: Mon, 02 Feb 2026 10:46:22 +0100
Message-ID: <87zf5rpjf5.fsf@t14s.mail-host-address-is-not-set>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76033-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[t14s.mail-host-address-is-not-set:mid,pm.me:email,collabora.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 63A07CAAE2
X-Rspamd-Action: no action

Daniel Almeida <daniel.almeida@collabora.com> writes:

>> On 17 Nov 2025, at 07:07, Oliver Mangold <oliver.mangold@pm.me> wrote:
>>=20
>> `AlwaysRefCounted` will become a marker trait to indicate that it is
>> allowed to obtain an `ARef<T>` from a `&T`, which cannot be allowed for
>> types which are also Ownable.
>>=20
>> Signed-off-by: Oliver Mangold <oliver.mangold@pm.me>
>> Co-developed-by: Andreas Hindborg <a.hindborg@kernel.org>
>> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
>> Suggested-by: Alice Ryhl <aliceryhl@google.com>
>> ---
>> rust/kernel/auxiliary.rs        |  7 +++++-
>> rust/kernel/block/mq/request.rs | 15 +++++++------
>> rust/kernel/cred.rs             | 13 ++++++++++--
>> rust/kernel/device.rs           | 13 ++++++++----
>> rust/kernel/device/property.rs  |  7 +++++-
>> rust/kernel/drm/device.rs       | 10 ++++++---
>> rust/kernel/drm/gem/mod.rs      | 10 ++++++---
>> rust/kernel/fs/file.rs          | 16 ++++++++++----
>> rust/kernel/mm.rs               | 15 +++++++++----
>> rust/kernel/mm/mmput_async.rs   |  9 ++++++--
>> rust/kernel/opp.rs              | 10 ++++++---
>> rust/kernel/owned.rs            |  2 +-
>> rust/kernel/pci.rs              | 10 ++++++---
>> rust/kernel/pid_namespace.rs    | 12 +++++++++--
>> rust/kernel/platform.rs         |  7 +++++-
>> rust/kernel/sync/aref.rs        | 47 ++++++++++++++++++++++++++---------=
------
>> rust/kernel/task.rs             | 10 ++++++---
>> rust/kernel/types.rs            |  2 +-
>> 18 files changed, 154 insertions(+), 61 deletions(-)
>>=20
>> diff --git a/rust/kernel/auxiliary.rs b/rust/kernel/auxiliary.rs
>> index 7a3b0b9c418e..7f5b16053c11 100644
>> --- a/rust/kernel/auxiliary.rs
>> +++ b/rust/kernel/auxiliary.rs
>> @@ -10,6 +10,7 @@
>>     driver,
>>     error::{from_result, to_result, Result},
>>     prelude::*,
>> +    sync::aref::{AlwaysRefCounted, RefCounted},
>>     types::Opaque,
>>     ThisModule,
>> };
>> @@ -239,7 +240,7 @@ extern "C" fn release(dev: *mut bindings::device) {
>> kernel::impl_device_context_into_aref!(Device);
>>=20
>> // SAFETY: Instances of `Device` are always reference-counted.
>> -unsafe impl crate::sync::aref::AlwaysRefCounted for Device {
>> +unsafe impl RefCounted for Device {
>>     fn inc_ref(&self) {
>>         // SAFETY: The existence of a shared reference guarantees that t=
he refcount is non-zero.
>>         unsafe { bindings::get_device(self.as_ref().as_raw()) };
>> @@ -258,6 +259,10 @@ unsafe fn dec_ref(obj: NonNull<Self>) {
>>     }
>> }
>>=20
>> +// SAFETY: We do not implement `Ownable`, thus it is okay to obtain an =
`ARef<Device>` from a
>> +// `&Device`.
>> +unsafe impl AlwaysRefCounted for Device {}
>> +
>> impl<Ctx: device::DeviceContext> AsRef<device::Device<Ctx>> for Device<C=
tx> {
>>     fn as_ref(&self) -> &device::Device<Ctx> {
>>         // SAFETY: By the type invariant of `Self`, `self.as_raw()` is a=
 pointer to a valid
>> diff --git a/rust/kernel/block/mq/request.rs b/rust/kernel/block/mq/requ=
est.rs
>> index c5f1f6b1ccfb..b6165f96b4ce 100644
>> --- a/rust/kernel/block/mq/request.rs
>> +++ b/rust/kernel/block/mq/request.rs
>> @@ -8,7 +8,7 @@
>>     bindings,
>>     block::mq::Operations,
>>     error::Result,
>> -    sync::{atomic::Relaxed, Refcount},
>> +    sync::{aref::RefCounted, atomic::Relaxed, Refcount},
>>     types::{ARef, AlwaysRefCounted, Opaque},
>> };
>> use core::{marker::PhantomData, ptr::NonNull};
>> @@ -225,11 +225,10 @@ unsafe impl<T: Operations> Send for Request<T> {}
>> // mutate `self` are internally synchronized`
>> unsafe impl<T: Operations> Sync for Request<T> {}
>>=20
>> -// SAFETY: All instances of `Request<T>` are reference counted. This
>> -// implementation of `AlwaysRefCounted` ensure that increments to the r=
ef count
>> -// keeps the object alive in memory at least until a matching reference=
 count
>> -// decrement is executed.
>> -unsafe impl<T: Operations> AlwaysRefCounted for Request<T> {
>> +// SAFETY: All instances of `Request<T>` are reference counted. This im=
plementation of `RefCounted`
>> +// ensure that increments to the ref count keeps the object alive in me=
mory at least until a
>> +// matching reference count decrement is executed.
>> +unsafe impl<T: Operations> RefCounted for Request<T> {
>>     fn inc_ref(&self) {
>>         self.wrapper_ref().refcount().inc();
>>     }
>> @@ -251,3 +250,7 @@ unsafe fn dec_ref(obj: core::ptr::NonNull<Self>) {
>>         }
>>     }
>> }
>> +
>> +// SAFETY: We currently do not implement `Ownable`, thus it is okay to =
obtain an `ARef<Request>`
>> +// from a `&Request` (but this will change in the future).
>> +unsafe impl<T: Operations> AlwaysRefCounted for Request<T> {}
>> diff --git a/rust/kernel/cred.rs b/rust/kernel/cred.rs
>> index ffa156b9df37..20ef0144094b 100644
>> --- a/rust/kernel/cred.rs
>> +++ b/rust/kernel/cred.rs
>> @@ -8,7 +8,12 @@
>> //!
>> //! Reference: <https://www.kernel.org/doc/html/latest/security/credenti=
als.html>
>>=20
>> -use crate::{bindings, sync::aref::AlwaysRefCounted, task::Kuid, types::=
Opaque};
>> +use crate::{
>> +    bindings,
>> +    sync::aref::RefCounted,
>> +    task::Kuid,
>> +    types::{AlwaysRefCounted, Opaque},
>> +};
>>=20
>> /// Wraps the kernel's `struct cred`.
>> ///
>> @@ -76,7 +81,7 @@ pub fn euid(&self) -> Kuid {
>> }
>>=20
>> // SAFETY: The type invariants guarantee that `Credential` is always ref=
-counted.
>> -unsafe impl AlwaysRefCounted for Credential {
>> +unsafe impl RefCounted for Credential {
>>     #[inline]
>>     fn inc_ref(&self) {
>>         // SAFETY: The existence of a shared reference means that the re=
fcount is nonzero.
>> @@ -90,3 +95,7 @@ unsafe fn dec_ref(obj: core::ptr::NonNull<Credential>)=
 {
>>         unsafe { bindings::put_cred(obj.cast().as_ptr()) };
>>     }
>> }
>> +
>> +// SAFETY: We do not implement `Ownable`, thus it is okay to obtain an =
`ARef<Credential>` from a
>> +// `&Credential`.
>> +unsafe impl AlwaysRefCounted for Credential {}
>> diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
>> index a849b7dde2fd..a69ee32997c1 100644
>> --- a/rust/kernel/device.rs
>> +++ b/rust/kernel/device.rs
>> @@ -5,9 +5,10 @@
>> //! C header: [`include/linux/device.h`](srctree/include/linux/device.h)
>>=20
>> use crate::{
>> -    bindings, fmt,
>> -    sync::aref::ARef,
>> -    types::{ForeignOwnable, Opaque},
>> +    bindings,
>> +    fmt,
>> +    sync::aref::RefCounted,
>> +    types::{ARef, AlwaysRefCounted, ForeignOwnable, Opaque},
>> };
>> use core::{marker::PhantomData, ptr};
>>=20
>> @@ -407,7 +408,7 @@ pub fn fwnode(&self) -> Option<&property::FwNode> {
>> kernel::impl_device_context_into_aref!(Device);
>>=20
>> // SAFETY: Instances of `Device` are always reference-counted.
>> -unsafe impl crate::sync::aref::AlwaysRefCounted for Device {
>> +unsafe impl RefCounted for Device {
>>     fn inc_ref(&self) {
>>         // SAFETY: The existence of a shared reference guarantees that t=
he refcount is non-zero.
>>         unsafe { bindings::get_device(self.as_raw()) };
>> @@ -419,6 +420,10 @@ unsafe fn dec_ref(obj: ptr::NonNull<Self>) {
>>     }
>> }
>>=20
>> +// SAFETY: We do not implement `Ownable`, thus it is okay to obtain an =
`ARef<Device>` from a
>> +// `&Device`.
>> +unsafe impl AlwaysRefCounted for Device {}
>> +
>> // SAFETY: As by the type invariant `Device` can be sent to any thread.
>> unsafe impl Send for Device {}
>>=20
>> diff --git a/rust/kernel/device/property.rs b/rust/kernel/device/propert=
y.rs
>> index 3a332a8c53a9..a8bb824ad0ec 100644
>> --- a/rust/kernel/device/property.rs
>> +++ b/rust/kernel/device/property.rs
>> @@ -14,6 +14,7 @@
>>     fmt,
>>     prelude::*,
>>     str::{CStr, CString},
>> +    sync::aref::{AlwaysRefCounted, RefCounted},
>>     types::{ARef, Opaque},
>> };
>>=20
>> @@ -359,7 +360,7 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Re=
sult {
>> }
>>=20
>> // SAFETY: Instances of `FwNode` are always reference-counted.
>> -unsafe impl crate::types::AlwaysRefCounted for FwNode {
>> +unsafe impl RefCounted for FwNode {
>>     fn inc_ref(&self) {
>>         // SAFETY: The existence of a shared reference guarantees that t=
he
>>         // refcount is non-zero.
>> @@ -373,6 +374,10 @@ unsafe fn dec_ref(obj: ptr::NonNull<Self>) {
>>     }
>> }
>>=20
>> +// SAFETY: We do not implement `Ownable`, thus it is okay to obtain an =
`ARef<FwNode>` from a
>> +// `&FwNode`.
>> +unsafe impl AlwaysRefCounted for FwNode {}
>> +
>> enum Node<'a> {
>>     Borrowed(&'a FwNode),
>>     Owned(ARef<FwNode>),
>> diff --git a/rust/kernel/drm/device.rs b/rust/kernel/drm/device.rs
>> index 3ce8f62a0056..38ce7f389ed0 100644
>> --- a/rust/kernel/drm/device.rs
>> +++ b/rust/kernel/drm/device.rs
>> @@ -11,8 +11,8 @@
>>     error::from_err_ptr,
>>     error::Result,
>>     prelude::*,
>> -    sync::aref::{ARef, AlwaysRefCounted},
>> -    types::Opaque,
>> +    sync::aref::{AlwaysRefCounted, RefCounted},
>> +    types::{ARef, Opaque},
>> };
>> use core::{alloc::Layout, mem, ops::Deref, ptr, ptr::NonNull};
>>=20
>> @@ -198,7 +198,7 @@ fn deref(&self) -> &Self::Target {
>>=20
>> // SAFETY: DRM device objects are always reference counted and the get/p=
ut functions
>> // satisfy the requirements.
>> -unsafe impl<T: drm::Driver> AlwaysRefCounted for Device<T> {
>> +unsafe impl<T: drm::Driver> RefCounted for Device<T> {
>>     fn inc_ref(&self) {
>>         // SAFETY: The existence of a shared reference guarantees that t=
he refcount is non-zero.
>>         unsafe { bindings::drm_dev_get(self.as_raw()) };
>> @@ -213,6 +213,10 @@ unsafe fn dec_ref(obj: NonNull<Self>) {
>>     }
>> }
>>=20
>> +// SAFETY: We do not implement `Ownable`, thus it is okay to obtain an =
`ARef<Device>` from a
>> +// `&Device`.
>> +unsafe impl<T: drm::Driver> AlwaysRefCounted for Device<T> {}
>> +
>> impl<T: drm::Driver> AsRef<device::Device> for Device<T> {
>>     fn as_ref(&self) -> &device::Device {
>>         // SAFETY: `bindings::drm_device::dev` is valid as long as the D=
RM device itself is valid,
>> diff --git a/rust/kernel/drm/gem/mod.rs b/rust/kernel/drm/gem/mod.rs
>> index 30c853988b94..4afd36e49205 100644
>> --- a/rust/kernel/drm/gem/mod.rs
>> +++ b/rust/kernel/drm/gem/mod.rs
>> @@ -10,8 +10,8 @@
>>     drm::driver::{AllocImpl, AllocOps},
>>     error::{to_result, Result},
>>     prelude::*,
>> -    sync::aref::{ARef, AlwaysRefCounted},
>> -    types::Opaque,
>> +    sync::aref::RefCounted,
>> +    types::{ARef, AlwaysRefCounted, Opaque},
>> };
>> use core::{ops::Deref, ptr::NonNull};
>>=20
>> @@ -56,7 +56,7 @@ pub trait IntoGEMObject: Sized + super::private::Seale=
d + AlwaysRefCounted {
>> }
>>=20
>> // SAFETY: All gem objects are refcounted.
>> -unsafe impl<T: IntoGEMObject> AlwaysRefCounted for T {
>> +unsafe impl<T: IntoGEMObject> RefCounted for T {
>>     fn inc_ref(&self) {
>>         // SAFETY: The existence of a shared reference guarantees that t=
he refcount is non-zero.
>>         unsafe { bindings::drm_gem_object_get(self.as_raw()) };
>> @@ -75,6 +75,10 @@ unsafe fn dec_ref(obj: NonNull<Self>) {
>>     }
>> }
>>=20
>> +// SAFETY: We do not implement `Ownable`, thus it is okay to obtain an =
`ARef<T>` from a
>> +// `&T`.
>> +unsafe impl<T: IntoGEMObject> crate::types::AlwaysRefCounted for T {}
>> +
>> extern "C" fn open_callback<T: DriverObject>(
>>     raw_obj: *mut bindings::drm_gem_object,
>>     raw_file: *mut bindings::drm_file,
>> diff --git a/rust/kernel/fs/file.rs b/rust/kernel/fs/file.rs
>> index cd6987850332..86309ca5dad0 100644
>> --- a/rust/kernel/fs/file.rs
>> +++ b/rust/kernel/fs/file.rs
>> @@ -12,8 +12,8 @@
>>     cred::Credential,
>>     error::{code::*, to_result, Error, Result},
>>     fmt,
>> -    sync::aref::{ARef, AlwaysRefCounted},
>> -    types::{NotThreadSafe, Opaque},
>> +    sync::aref::RefCounted,
>> +    types::{ARef, AlwaysRefCounted, NotThreadSafe, Opaque},
>> };
>> use core::ptr;
>>=20
>> @@ -192,7 +192,7 @@ unsafe impl Sync for File {}
>>=20
>> // SAFETY: The type invariants guarantee that `File` is always ref-count=
ed. This implementation
>> // makes `ARef<File>` own a normal refcount.
>> -unsafe impl AlwaysRefCounted for File {
>> +unsafe impl RefCounted for File {
>>     #[inline]
>>     fn inc_ref(&self) {
>>         // SAFETY: The existence of a shared reference means that the re=
fcount is nonzero.
>> @@ -207,6 +207,10 @@ unsafe fn dec_ref(obj: ptr::NonNull<File>) {
>>     }
>> }
>>=20
>> +// SAFETY: We do not implement `Ownable`, thus it is okay to obtain an =
`ARef<File>` from a
>> +// `&File`.
>> +unsafe impl AlwaysRefCounted for File {}
>> +
>> /// Wraps the kernel's `struct file`. Not thread safe.
>> ///
>> /// This type represents a file that is not known to be safe to transfer=
 across thread boundaries.
>> @@ -228,7 +232,7 @@ pub struct LocalFile {
>>=20
>> // SAFETY: The type invariants guarantee that `LocalFile` is always ref-=
counted. This implementation
>> // makes `ARef<LocalFile>` own a normal refcount.
>> -unsafe impl AlwaysRefCounted for LocalFile {
>> +unsafe impl RefCounted for LocalFile {
>>     #[inline]
>>     fn inc_ref(&self) {
>>         // SAFETY: The existence of a shared reference means that the re=
fcount is nonzero.
>> @@ -244,6 +248,10 @@ unsafe fn dec_ref(obj: ptr::NonNull<LocalFile>) {
>>     }
>> }
>>=20
>> +// SAFETY: We do not implement `Ownable`, thus it is okay to obtain an =
`ARef<LocalFile>` from a
>> +// `&LocalFile`.
>> +unsafe impl AlwaysRefCounted for LocalFile {}
>> +
>> impl LocalFile {
>>     /// Constructs a new `struct file` wrapper from a file descriptor.
>>     ///
>> diff --git a/rust/kernel/mm.rs b/rust/kernel/mm.rs
>> index 4764d7b68f2a..dd9e3969e720 100644
>> --- a/rust/kernel/mm.rs
>> +++ b/rust/kernel/mm.rs
>> @@ -13,8 +13,8 @@
>>=20
>> use crate::{
>>     bindings,
>> -    sync::aref::{ARef, AlwaysRefCounted},
>> -    types::{NotThreadSafe, Opaque},
>> +    sync::aref::RefCounted,
>> +    types::{ARef, AlwaysRefCounted, NotThreadSafe, Opaque},
>> };
>> use core::{ops::Deref, ptr::NonNull};
>>=20
>> @@ -55,7 +55,7 @@ unsafe impl Send for Mm {}
>> unsafe impl Sync for Mm {}
>>=20
>> // SAFETY: By the type invariants, this type is always refcounted.
>> -unsafe impl AlwaysRefCounted for Mm {
>> +unsafe impl RefCounted for Mm {
>>     #[inline]
>>     fn inc_ref(&self) {
>>         // SAFETY: The pointer is valid since self is a reference.
>> @@ -69,6 +69,9 @@ unsafe fn dec_ref(obj: NonNull<Self>) {
>>     }
>> }
>>=20
>> +// SAFETY: We do not implement `Ownable`, thus it is okay to obtain an =
`ARef<Mm>` from a `&Mm`.
>> +unsafe impl AlwaysRefCounted for Mm {}
>> +
>> /// A wrapper for the kernel's `struct mm_struct`.
>> ///
>> /// This type is like [`Mm`], but with non-zero `mm_users`. It can only =
be used when `mm_users` can
>> @@ -91,7 +94,7 @@ unsafe impl Send for MmWithUser {}
>> unsafe impl Sync for MmWithUser {}
>>=20
>> // SAFETY: By the type invariants, this type is always refcounted.
>> -unsafe impl AlwaysRefCounted for MmWithUser {
>> +unsafe impl RefCounted for MmWithUser {
>>     #[inline]
>>     fn inc_ref(&self) {
>>         // SAFETY: The pointer is valid since self is a reference.
>> @@ -105,6 +108,10 @@ unsafe fn dec_ref(obj: NonNull<Self>) {
>>     }
>> }
>>=20
>> +// SAFETY: We do not implement `Ownable`, thus it is okay to obtain an =
`ARef<MmWithUser>` from a
>> +// `&MmWithUser`.
>> +unsafe impl AlwaysRefCounted for MmWithUser {}
>> +
>> // Make all `Mm` methods available on `MmWithUser`.
>> impl Deref for MmWithUser {
>>     type Target =3D Mm;
>> diff --git a/rust/kernel/mm/mmput_async.rs b/rust/kernel/mm/mmput_async.=
rs
>> index b8d2f051225c..aba4ce675c86 100644
>> --- a/rust/kernel/mm/mmput_async.rs
>> +++ b/rust/kernel/mm/mmput_async.rs
>> @@ -10,7 +10,8 @@
>> use crate::{
>>     bindings,
>>     mm::MmWithUser,
>> -    sync::aref::{ARef, AlwaysRefCounted},
>> +    sync::aref::RefCounted,
>> +    types::{ARef, AlwaysRefCounted},
>> };
>> use core::{ops::Deref, ptr::NonNull};
>>=20
>> @@ -34,7 +35,7 @@ unsafe impl Send for MmWithUserAsync {}
>> unsafe impl Sync for MmWithUserAsync {}
>>=20
>> // SAFETY: By the type invariants, this type is always refcounted.
>> -unsafe impl AlwaysRefCounted for MmWithUserAsync {
>> +unsafe impl RefCounted for MmWithUserAsync {
>>     #[inline]
>>     fn inc_ref(&self) {
>>         // SAFETY: The pointer is valid since self is a reference.
>> @@ -48,6 +49,10 @@ unsafe fn dec_ref(obj: NonNull<Self>) {
>>     }
>> }
>>=20
>> +// SAFETY: We do not implement `Ownable`, thus it is okay to obtain an =
`ARef<MmWithUserAsync>`
>> +// from a `&MmWithUserAsync`.
>> +unsafe impl AlwaysRefCounted for MmWithUserAsync {}
>> +
>> // Make all `MmWithUser` methods available on `MmWithUserAsync`.
>> impl Deref for MmWithUserAsync {
>>     type Target =3D MmWithUser;
>> diff --git a/rust/kernel/opp.rs b/rust/kernel/opp.rs
>> index 2c763fa9276d..77d1cc89c412 100644
>> --- a/rust/kernel/opp.rs
>> +++ b/rust/kernel/opp.rs
>> @@ -16,8 +16,8 @@
>>     ffi::c_ulong,
>>     prelude::*,
>>     str::CString,
>> -    sync::aref::{ARef, AlwaysRefCounted},
>> -    types::Opaque,
>> +    sync::aref::RefCounted,
>> +    types::{ARef, AlwaysRefCounted, Opaque},
>> };
>>=20
>> #[cfg(CONFIG_CPU_FREQ)]
>> @@ -1037,7 +1037,7 @@ unsafe impl Send for OPP {}
>> unsafe impl Sync for OPP {}
>>=20
>> /// SAFETY: The type invariants guarantee that [`OPP`] is always refcoun=
ted.
>> -unsafe impl AlwaysRefCounted for OPP {
>> +unsafe impl RefCounted for OPP {
>>     fn inc_ref(&self) {
>>         // SAFETY: The existence of a shared reference means that the re=
fcount is nonzero.
>>         unsafe { bindings::dev_pm_opp_get(self.0.get()) };
>> @@ -1049,6 +1049,10 @@ unsafe fn dec_ref(obj: ptr::NonNull<Self>) {
>>     }
>> }
>>=20
>> +// SAFETY: We do not implement `Ownable`, thus it is okay to obtain an =
`ARef<OPP>` from an
>> +// `&OPP`.
>> +unsafe impl AlwaysRefCounted for OPP {}
>> +
>> impl OPP {
>>     /// Creates an owned reference to a [`OPP`] from a valid pointer.
>>     ///
>> diff --git a/rust/kernel/owned.rs b/rust/kernel/owned.rs
>> index a2cdd2cb8a10..a26747cbc13b 100644
>> --- a/rust/kernel/owned.rs
>> +++ b/rust/kernel/owned.rs
>> @@ -21,7 +21,7 @@
>> ///
>> /// Note: The underlying object is not required to provide internal refe=
rence counting, because it
>> /// represents a unique, owned reference. If reference counting (on the =
Rust side) is required,
>> -/// [`AlwaysRefCounted`](crate::types::AlwaysRefCounted) should be impl=
emented.
>> +/// [`RefCounted`](crate::types::RefCounted) should be implemented.
>> ///
>> /// # Safety
>> ///
>> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
>> index 7fcc5f6022c1..9ac70823fb4d 100644
>> --- a/rust/kernel/pci.rs
>> +++ b/rust/kernel/pci.rs
>> @@ -13,8 +13,8 @@
>>     io::{Io, IoRaw},
>>     irq::{self, IrqRequest},
>>     str::CStr,
>> -    sync::aref::ARef,
>> -    types::Opaque,
>> +    sync::aref::{AlwaysRefCounted, RefCounted},
>> +    types::{ARef, Opaque},
>>     ThisModule,
>> };
>> use core::{
>> @@ -601,7 +601,7 @@ pub fn set_master(&self) {
>> impl crate::dma::Device for Device<device::Core> {}
>>=20
>> // SAFETY: Instances of `Device` are always reference-counted.
>> -unsafe impl crate::sync::aref::AlwaysRefCounted for Device {
>> +unsafe impl RefCounted for Device {
>>     fn inc_ref(&self) {
>>         // SAFETY: The existence of a shared reference guarantees that t=
he refcount is non-zero.
>>         unsafe { bindings::pci_dev_get(self.as_raw()) };
>> @@ -613,6 +613,10 @@ unsafe fn dec_ref(obj: NonNull<Self>) {
>>     }
>> }
>>=20
>> +// SAFETY: We do not implement `Ownable`, thus it is okay to obtain an =
`ARef<Device>` from a
>> +// `&Device`.
>> +unsafe impl AlwaysRefCounted for Device {}
>> +
>> impl<Ctx: device::DeviceContext> AsRef<device::Device<Ctx>> for Device<C=
tx> {
>>     fn as_ref(&self) -> &device::Device<Ctx> {
>>         // SAFETY: By the type invariant of `Self`, `self.as_raw()` is a=
 pointer to a valid
>> diff --git a/rust/kernel/pid_namespace.rs b/rust/kernel/pid_namespace.rs
>> index 979a9718f153..4f6a94540e33 100644
>> --- a/rust/kernel/pid_namespace.rs
>> +++ b/rust/kernel/pid_namespace.rs
>> @@ -7,7 +7,11 @@
>> //! C header: [`include/linux/pid_namespace.h`](srctree/include/linux/pi=
d_namespace.h) and
>> //! [`include/linux/pid.h`](srctree/include/linux/pid.h)
>>=20
>> -use crate::{bindings, sync::aref::AlwaysRefCounted, types::Opaque};
>> +use crate::{
>> +    bindings,
>> +    sync::aref::RefCounted,
>> +    types::{AlwaysRefCounted, Opaque},
>> +};
>> use core::ptr;
>>=20
>> /// Wraps the kernel's `struct pid_namespace`. Thread safe.
>> @@ -41,7 +45,7 @@ pub unsafe fn from_ptr<'a>(ptr: *const bindings::pid_n=
amespace) -> &'a Self {
>> }
>>=20
>> // SAFETY: Instances of `PidNamespace` are always reference-counted.
>> -unsafe impl AlwaysRefCounted for PidNamespace {
>> +unsafe impl RefCounted for PidNamespace {
>>     #[inline]
>>     fn inc_ref(&self) {
>>         // SAFETY: The existence of a shared reference means that the re=
fcount is nonzero.
>> @@ -55,6 +59,10 @@ unsafe fn dec_ref(obj: ptr::NonNull<PidNamespace>) {
>>     }
>> }
>>=20
>> +// SAFETY: We do not implement `Ownable`, thus it is okay to obtain an =
`ARef<PidNamespace>` from
>> +// a `&PidNamespace`.
>> +unsafe impl AlwaysRefCounted for PidNamespace {}
>> +
>> // SAFETY:
>> // - `PidNamespace::dec_ref` can be called from any thread.
>> // - It is okay to send ownership of `PidNamespace` across thread bounda=
ries.
>> diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
>> index 7205fe3416d3..bf2aa496b377 100644
>> --- a/rust/kernel/platform.rs
>> +++ b/rust/kernel/platform.rs
>> @@ -13,6 +13,7 @@
>>     irq::{self, IrqRequest},
>>     of,
>>     prelude::*,
>> +    sync::aref::{AlwaysRefCounted, RefCounted},
>>     types::Opaque,
>>     ThisModule,
>> };
>> @@ -468,7 +469,7 @@ pub fn optional_irq_by_name(&self, name: &CStr) -> R=
esult<IrqRequest<'_>> {
>> impl crate::dma::Device for Device<device::Core> {}
>>=20
>> // SAFETY: Instances of `Device` are always reference-counted.
>> -unsafe impl crate::sync::aref::AlwaysRefCounted for Device {
>> +unsafe impl RefCounted for Device {
>>     fn inc_ref(&self) {
>>         // SAFETY: The existence of a shared reference guarantees that t=
he refcount is non-zero.
>>         unsafe { bindings::get_device(self.as_ref().as_raw()) };
>> @@ -480,6 +481,10 @@ unsafe fn dec_ref(obj: NonNull<Self>) {
>>     }
>> }
>>=20
>> +// SAFETY: We do not implement `Ownable`, thus it is okay to obtain an =
`ARef<Device>` from a
>> +// `&Device`.
>> +unsafe impl AlwaysRefCounted for Device {}
>> +
>> impl<Ctx: device::DeviceContext> AsRef<device::Device<Ctx>> for Device<C=
tx> {
>>     fn as_ref(&self) -> &device::Device<Ctx> {
>>         // SAFETY: By the type invariant of `Self`, `self.as_raw()` is a=
 pointer to a valid
>> diff --git a/rust/kernel/sync/aref.rs b/rust/kernel/sync/aref.rs
>> index e175aefe8615..4226119d5ac9 100644
>> --- a/rust/kernel/sync/aref.rs
>> +++ b/rust/kernel/sync/aref.rs
>> @@ -19,11 +19,9 @@
>>=20
>> use core::{marker::PhantomData, mem::ManuallyDrop, ops::Deref, ptr::NonN=
ull};
>>=20
>> -/// Types that are _always_ reference counted.
>> +/// Types that are internally reference counted.
>> ///
>> /// It allows such types to define their own custom ref increment and de=
crement functions.
>> -/// Additionally, it allows users to convert from a shared reference `&=
T` to an owned reference
>> -/// [`ARef<T>`].
>> ///
>> /// This is usually implemented by wrappers to existing structures on th=
e C side of the code. For
>> /// Rust code, the recommendation is to use [`Arc`](crate::sync::Arc) to=
 create reference-counted
>> @@ -40,9 +38,8 @@
>> /// at least until matching decrements are performed.
>> ///
>> /// Implementers must also ensure that all instances are reference-count=
ed. (Otherwise they
>> -/// won't be able to honour the requirement that [`AlwaysRefCounted::in=
c_ref`] keep the object
>> -/// alive.)
>> -pub unsafe trait AlwaysRefCounted {
>> +/// won't be able to honour the requirement that [`RefCounted::inc_ref`=
] keep the object alive.)
>> +pub unsafe trait RefCounted {
>>     /// Increments the reference count on the object.
>>     fn inc_ref(&self);
>>=20
>> @@ -55,11 +52,27 @@ pub unsafe trait AlwaysRefCounted {
>>     /// Callers must ensure that there was a previous matching increment=
 to the reference count,
>>     /// and that the object is no longer used after its reference count =
is decremented (as it may
>>     /// result in the object being freed), unless the caller owns anothe=
r increment on the refcount
>> -    /// (e.g., it calls [`AlwaysRefCounted::inc_ref`] twice, then calls
>> -    /// [`AlwaysRefCounted::dec_ref`] once).
>> +    /// (e.g., it calls [`RefCounted::inc_ref`] twice, then calls [`Ref=
Counted::dec_ref`] once).
>>     unsafe fn dec_ref(obj: NonNull<Self>);
>> }
>>=20
>> +/// Always reference-counted type.
>> +///
>> +/// It allows to derive a counted reference [`ARef<T>`] from a `&T`.
>> +///
>> +/// This provides some convenience, but it allows "escaping" borrow che=
cks on `&T`. As it
>> +/// complicates attempts to ensure that a reference to T is unique, it =
is optional to provide for
>> +/// [`RefCounted`] types. See *Safety* below.
>> +///
>> +/// # Safety
>> +///
>> +/// Implementers must ensure that no safety invariants are violated by =
upgrading an `&T` to an
>> +/// [`ARef<T>`]. In particular that implies [`AlwaysRefCounted`] and [`=
crate::types::Ownable`]
>> +/// cannot be implemented for the same type, as this would allow to vio=
late the uniqueness guarantee
>> +/// of [`crate::types::Owned<T>`] by derefencing it into an `&T` and ob=
taining an [`ARef`] from
>> +/// that.
>> +pub unsafe trait AlwaysRefCounted: RefCounted {}
>> +
>> /// An owned reference to an always-reference-counted object.
>> ///
>> /// The object's reference count is automatically decremented when an in=
stance of [`ARef`] is
>> @@ -70,7 +83,7 @@ pub unsafe trait AlwaysRefCounted {
>> ///
>> /// The pointer stored in `ptr` is non-null and valid for the lifetime o=
f the [`ARef`] instance. In
>> /// particular, the [`ARef`] instance owns an increment on the underlyin=
g object's reference count.
>> -pub struct ARef<T: AlwaysRefCounted> {
>> +pub struct ARef<T: RefCounted> {
>>     ptr: NonNull<T>,
>>     _p: PhantomData<T>,
>> }
>> @@ -79,16 +92,16 @@ pub struct ARef<T: AlwaysRefCounted> {
>> // it effectively means sharing `&T` (which is safe because `T` is `Sync=
`); additionally, it needs
>> // `T` to be `Send` because any thread that has an `ARef<T>` may ultimat=
ely access `T` using a
>> // mutable reference, for example, when the reference count reaches zero=
 and `T` is dropped.
>> -unsafe impl<T: AlwaysRefCounted + Sync + Send> Send for ARef<T> {}
>> +unsafe impl<T: RefCounted + Sync + Send> Send for ARef<T> {}
>>=20
>> // SAFETY: It is safe to send `&ARef<T>` to another thread when the unde=
rlying `T` is `Sync`
>> // because it effectively means sharing `&T` (which is safe because `T` =
is `Sync`); additionally,
>> // it needs `T` to be `Send` because any thread that has a `&ARef<T>` ma=
y clone it and get an
>> // `ARef<T>` on that thread, so the thread may ultimately access `T` usi=
ng a mutable reference, for
>> // example, when the reference count reaches zero and `T` is dropped.
>> -unsafe impl<T: AlwaysRefCounted + Sync + Send> Sync for ARef<T> {}
>> +unsafe impl<T: RefCounted + Sync + Send> Sync for ARef<T> {}
>>=20
>> -impl<T: AlwaysRefCounted> ARef<T> {
>> +impl<T: RefCounted> ARef<T> {
>>     /// Creates a new instance of [`ARef`].
>>     ///
>>     /// It takes over an increment of the reference count on the underly=
ing object.
>> @@ -117,12 +130,12 @@ pub unsafe fn from_raw(ptr: NonNull<T>) -> Self {
>>     ///
>>     /// ```
>>     /// use core::ptr::NonNull;
>> -    /// use kernel::sync::aref::{ARef, AlwaysRefCounted};
>> +    /// use kernel::sync::aref::{ARef, RefCounted};
>>     ///
>>     /// struct Empty {}
>>     ///
>>     /// # // SAFETY: TODO.
>> -    /// unsafe impl AlwaysRefCounted for Empty {
>> +    /// unsafe impl RefCounted for Empty {
>>     ///     fn inc_ref(&self) {}
>>     ///     unsafe fn dec_ref(_obj: NonNull<Self>) {}
>>     /// }
>> @@ -140,7 +153,7 @@ pub fn into_raw(me: Self) -> NonNull<T> {
>>     }
>> }
>>=20
>> -impl<T: AlwaysRefCounted> Clone for ARef<T> {
>> +impl<T: RefCounted> Clone for ARef<T> {
>>     fn clone(&self) -> Self {
>>         self.inc_ref();
>>         // SAFETY: We just incremented the refcount above.
>> @@ -148,7 +161,7 @@ fn clone(&self) -> Self {
>>     }
>> }
>>=20
>> -impl<T: AlwaysRefCounted> Deref for ARef<T> {
>> +impl<T: RefCounted> Deref for ARef<T> {
>>     type Target =3D T;
>>=20
>>     fn deref(&self) -> &Self::Target {
>> @@ -165,7 +178,7 @@ fn from(b: &T) -> Self {
>>     }
>> }
>>=20
>> -impl<T: AlwaysRefCounted> Drop for ARef<T> {
>> +impl<T: RefCounted> Drop for ARef<T> {
>>     fn drop(&mut self) {
>>         // SAFETY: The type invariants guarantee that the `ARef` owns th=
e reference we're about to
>>         // decrement.
>> diff --git a/rust/kernel/task.rs b/rust/kernel/task.rs
>> index 49fad6de0674..0a6e38d98456 100644
>> --- a/rust/kernel/task.rs
>> +++ b/rust/kernel/task.rs
>> @@ -9,8 +9,8 @@
>>     ffi::{c_int, c_long, c_uint},
>>     mm::MmWithUser,
>>     pid_namespace::PidNamespace,
>> -    sync::aref::ARef,
>> -    types::{NotThreadSafe, Opaque},
>> +    sync::aref::{AlwaysRefCounted, RefCounted},
>> +    types::{ARef, NotThreadSafe, Opaque},
>> };
>> use core::{
>>     cmp::{Eq, PartialEq},
>> @@ -348,7 +348,7 @@ pub fn active_pid_ns(&self) -> Option<&PidNamespace>=
 {
>> }
>>=20
>> // SAFETY: The type invariants guarantee that `Task` is always refcounte=
d.
>> -unsafe impl crate::sync::aref::AlwaysRefCounted for Task {
>> +unsafe impl RefCounted for Task {
>>     #[inline]
>>     fn inc_ref(&self) {
>>         // SAFETY: The existence of a shared reference means that the re=
fcount is nonzero.
>> @@ -362,6 +362,10 @@ unsafe fn dec_ref(obj: ptr::NonNull<Self>) {
>>     }
>> }
>>=20
>> +// SAFETY: We do not implement `Ownable`, thus it is okay to obtain an =
`ARef<Task>` from a
>> +// `&Task`.
>> +unsafe impl AlwaysRefCounted for Task {}
>> +
>> impl Kuid {
>>     /// Get the current euid.
>>     #[inline]
>> diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
>> index 7bc07c38cd6c..8ef01393352b 100644
>> --- a/rust/kernel/types.rs
>> +++ b/rust/kernel/types.rs
>> @@ -13,7 +13,7 @@
>>=20
>> pub use crate::owned::{Ownable, Owned};
>>=20
>> -pub use crate::sync::aref::{ARef, AlwaysRefCounted};
>> +pub use crate::sync::aref::{ARef, AlwaysRefCounted, RefCounted};
>>=20
>> /// Used to transfer ownership to and from foreign (non-Rust) languages.
>> ///
>>=20
>> --=20
>> 2.51.2
>>=20
>>=20
>>=20
>
> Can you use imperative voice in the title? i.e.:
>
> rust: rename `AlwaysRefCounted` to `RefCounted
>
> =E2=80=A6or something similar?
>
> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>

How about this:

rust: rename `AlwaysRefCounted` to `RefCounted`.

Change `AlwaysRefCounted` to be a marker trait that indicate that obtaining
an `ARef<T>` from a `&T` is possible.

- Rename `AlwaysRefCounted` to `RefCounted`.
- Add a new unsafe trait `AlwaysRefCounted`.
- Implement the new trait `AlwaysRefCounted` for the newly renamed
  `RefCounted` implementations. This leaves functionality of existing
  implementers of `AlwaysRefCounted` intact.


Best regards,
Andreas Hindborg




