Return-Path: <linux-fsdevel+bounces-869-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 959F07D1C04
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Oct 2023 11:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E606DB21451
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Oct 2023 09:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA13D50E;
	Sat, 21 Oct 2023 09:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Psmqs5SM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036FA1C16;
	Sat, 21 Oct 2023 09:21:49 +0000 (UTC)
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 251EAD68;
	Sat, 21 Oct 2023 02:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1697880101; x=1698139301;
	bh=otVpoEhysexNdsLualqEukwrOy2Q9rkdxQR4N2WhVPE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Psmqs5SMDigTPqquUkeceO/4ZYpv7UsEREZYSRey53AMk+mxe1p4T60bCOWF1zQbB
	 I62wWz/eN21iKFz5hNY2g38yJVNOdrSJ3a9haf29lYzIj4OlyKJZTZCTm1frg8xE8H
	 aSMI7rPK/6Lc+nnlfCkY95vH+wOwgbrpuFykdRtNIa9qnn/6sjOGco/ac19m8/sEEn
	 Gq0uqJprj9lD0Ee/bP0ug3h4Nw9uNnKryU8V3Et/PxbMQoMqlSPDbwXzIymISnxPtx
	 ysqQld59LpnNYiPMy2vwnVQmk7gb+YBS5CRUzX8niUsGOyotL9Y+/YEkEtIFlg7dqW
	 kti9LcYLaKWVg==
Date: Sat, 21 Oct 2023 09:21:26 +0000
To: Wedson Almeida Filho <wedsonaf@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Matthew Wilcox <willy@infradead.org>, Kent Overstreet <kent.overstreet@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-fsdevel@vger.kernel.org, rust-for-linux@vger.kernel.org, Wedson Almeida Filho <walmeida@microsoft.com>
Subject: Re: [RFC PATCH 09/19] rust: folio: introduce basic support for folios
Message-ID: <rb3wKldoNJBGpVinVAEjfauQFunNEuRTM7E979sSp9Ggn8t9TUMNCIgBPV_daYlYccK5kZ2OIjg6yIKU8itHYVJm_FDalcKCbU0fRhsHbBw=@proton.me>
In-Reply-To: <20231018122518.128049-10-wedsonaf@gmail.com>
References: <20231018122518.128049-1-wedsonaf@gmail.com> <20231018122518.128049-10-wedsonaf@gmail.com>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 18.10.23 14:25, Wedson Almeida Filho wrote:
> From: Wedson Almeida Filho <walmeida@microsoft.com>
>=20
> Allow Rust file systems to handle ref-counted folios.
>=20
> Provide the minimum needed to implement `read_folio` (part of `struct
> address_space_operations`) in read-only file systems and to read
> uncached blocks.
>=20
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> ---
>   rust/bindings/bindings_helper.h |   3 +
>   rust/bindings/lib.rs            |   2 +
>   rust/helpers.c                  |  81 ++++++++++++
>   rust/kernel/folio.rs            | 215 ++++++++++++++++++++++++++++++++
>   rust/kernel/lib.rs              |   1 +
>   5 files changed, 302 insertions(+)
>   create mode 100644 rust/kernel/folio.rs
>=20
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_hel=
per.h
> index ca1898ce9527..53a99ea512d1 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -11,6 +11,7 @@
>   #include <linux/fs.h>
>   #include <linux/fs_context.h>
>   #include <linux/slab.h>
> +#include <linux/pagemap.h>
>   #include <linux/refcount.h>
>   #include <linux/wait.h>
>   #include <linux/sched.h>
> @@ -27,3 +28,5 @@ const slab_flags_t BINDINGS_SLAB_ACCOUNT =3D SLAB_ACCOU=
NT;
>   const unsigned long BINDINGS_SB_RDONLY =3D SB_RDONLY;
>=20
>   const loff_t BINDINGS_MAX_LFS_FILESIZE =3D MAX_LFS_FILESIZE;
> +
> +const size_t BINDINGS_PAGE_SIZE =3D PAGE_SIZE;
> diff --git a/rust/bindings/lib.rs b/rust/bindings/lib.rs
> index 426915d3fb57..a96b7f08e57d 100644
> --- a/rust/bindings/lib.rs
> +++ b/rust/bindings/lib.rs
> @@ -59,3 +59,5 @@ mod bindings_helper {
>   pub const SB_RDONLY: core::ffi::c_ulong =3D BINDINGS_SB_RDONLY;
>=20
>   pub const MAX_LFS_FILESIZE: loff_t =3D BINDINGS_MAX_LFS_FILESIZE;
> +
> +pub const PAGE_SIZE: usize =3D BINDINGS_PAGE_SIZE;
> diff --git a/rust/helpers.c b/rust/helpers.c
> index c5a2bec6467d..f2ce3e7b688c 100644
> --- a/rust/helpers.c
> +++ b/rust/helpers.c
> @@ -23,10 +23,14 @@
>   #include <kunit/test-bug.h>
>   #include <linux/bug.h>
>   #include <linux/build_bug.h>
> +#include <linux/cacheflush.h>
>   #include <linux/err.h>
>   #include <linux/errname.h>
>   #include <linux/fs.h>
> +#include <linux/highmem.h>
> +#include <linux/mm.h>
>   #include <linux/mutex.h>
> +#include <linux/pagemap.h>
>   #include <linux/refcount.h>
>   #include <linux/sched/signal.h>
>   #include <linux/spinlock.h>
> @@ -145,6 +149,77 @@ struct kunit *rust_helper_kunit_get_current_test(voi=
d)
>   }
>   EXPORT_SYMBOL_GPL(rust_helper_kunit_get_current_test);
>=20
> +void *rust_helper_kmap(struct page *page)
> +{
> +=09return kmap(page);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_kmap);
> +
> +void rust_helper_kunmap(struct page *page)
> +{
> +=09kunmap(page);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_kunmap);
> +
> +void rust_helper_folio_get(struct folio *folio)
> +{
> +=09folio_get(folio);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_folio_get);
> +
> +void rust_helper_folio_put(struct folio *folio)
> +{
> +=09folio_put(folio);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_folio_put);
> +
> +struct page *rust_helper_folio_page(struct folio *folio, size_t n)
> +{
> +=09return folio_page(folio, n);
> +}
> +
> +loff_t rust_helper_folio_pos(struct folio *folio)
> +{
> +=09return folio_pos(folio);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_folio_pos);
> +
> +size_t rust_helper_folio_size(struct folio *folio)
> +{
> +=09return folio_size(folio);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_folio_size);
> +
> +void rust_helper_folio_mark_uptodate(struct folio *folio)
> +{
> +=09folio_mark_uptodate(folio);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_folio_mark_uptodate);
> +
> +void rust_helper_folio_set_error(struct folio *folio)
> +{
> +=09folio_set_error(folio);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_folio_set_error);
> +
> +void rust_helper_flush_dcache_folio(struct folio *folio)
> +{
> +=09flush_dcache_folio(folio);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_flush_dcache_folio);
> +
> +void *rust_helper_kmap_local_folio(struct folio *folio, size_t offset)
> +{
> +=09return kmap_local_folio(folio, offset);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_kmap_local_folio);
> +
> +void rust_helper_kunmap_local(const void *vaddr)
> +{
> +=09kunmap_local(vaddr);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_kunmap_local);
> +
>   void rust_helper_i_uid_write(struct inode *inode, uid_t uid)
>   {
>   =09i_uid_write(inode, uid);
> @@ -163,6 +238,12 @@ off_t rust_helper_i_size_read(const struct inode *in=
ode)
>   }
>   EXPORT_SYMBOL_GPL(rust_helper_i_size_read);
>=20
> +void rust_helper_mapping_set_large_folios(struct address_space *mapping)
> +{
> +=09mapping_set_large_folios(mapping);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_mapping_set_large_folios);
> +
>   /*
>    * `bindgen` binds the C `size_t` type as the Rust `usize` type, so we =
can
>    * use it in contexts where Rust expects a `usize` like slice (array) i=
ndices.
> diff --git a/rust/kernel/folio.rs b/rust/kernel/folio.rs
> new file mode 100644
> index 000000000000..ef8a08b97962
> --- /dev/null
> +++ b/rust/kernel/folio.rs
> @@ -0,0 +1,215 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Groups of contiguous pages, folios.
> +//!
> +//! C headers: [`include/linux/mm.h`](../../include/linux/mm.h)
> +
> +use crate::error::{code::*, Result};
> +use crate::types::{ARef, AlwaysRefCounted, Opaque, ScopeGuard};
> +use core::{cmp::min, ptr};
> +
> +/// Wraps the kernel's `struct folio`.
> +///
> +/// # Invariants
> +///
> +/// Instances of this type are always ref-counted, that is, a call to `f=
olio_get` ensures that the
> +/// allocation remains valid at least until the matching call to `folio_=
put`.
> +#[repr(transparent)]
> +pub struct Folio(pub(crate) Opaque<bindings::folio>);
> +
> +// SAFETY: The type invariants guarantee that `Folio` is always ref-coun=
ted.
> +unsafe impl AlwaysRefCounted for Folio {
> +    fn inc_ref(&self) {
> +        // SAFETY: The existence of a shared reference means that the re=
fcount is nonzero.
> +        unsafe { bindings::folio_get(self.0.get()) };
> +    }
> +
> +    unsafe fn dec_ref(obj: ptr::NonNull<Self>) {
> +        // SAFETY: The safety requirements guarantee that the refcount i=
s nonzero.
> +        unsafe { bindings::folio_put(obj.cast().as_ptr()) }
> +    }
> +}
> +
> +impl Folio {
> +    /// Tries to allocate a new folio.
> +    ///
> +    /// On success, returns a folio made up of 2^order pages.
> +    pub fn try_new(order: u32) -> Result<UniqueFolio> {
> +        if order > bindings::MAX_ORDER {
> +            return Err(EDOM);
> +        }
> +
> +        // SAFETY: We checked that `order` is within the max allowed val=
ue.
> +        let f =3D ptr::NonNull::new(unsafe { bindings::folio_alloc(bindi=
ngs::GFP_KERNEL, order) })
> +            .ok_or(ENOMEM)?;
> +
> +        // SAFETY: The folio returned by `folio_alloc` is referenced. Th=
e ownership of the
> +        // reference is transferred to the `ARef` instance.
> +        Ok(UniqueFolio(unsafe { ARef::from_raw(f.cast()) }))
> +    }
> +
> +    /// Returns the byte position of this folio in its file.
> +    pub fn pos(&self) -> i64 {
> +        // SAFETY: The folio is valid because the shared reference impli=
es a non-zero refcount.
> +        unsafe { bindings::folio_pos(self.0.get()) }
> +    }
> +
> +    /// Returns the byte size of this folio.
> +    pub fn size(&self) -> usize {
> +        // SAFETY: The folio is valid because the shared reference impli=
es a non-zero refcount.
> +        unsafe { bindings::folio_size(self.0.get()) }
> +    }
> +
> +    /// Flushes the data cache for the pages that make up the folio.
> +    pub fn flush_dcache(&self) {
> +        // SAFETY: The folio is valid because the shared reference impli=
es a non-zero refcount.
> +        unsafe { bindings::flush_dcache_folio(self.0.get()) }
> +    }
> +}
> +
> +/// A [`Folio`] that has a single reference to it.

This should be an invariant.

> +pub struct UniqueFolio(pub(crate) ARef<Folio>);
> +
> +impl UniqueFolio {
> +    /// Maps the contents of a folio page into a slice.
> +    pub fn map_page(&self, page_index: usize) -> Result<MapGuard<'_>> {
> +        if page_index >=3D self.0.size() / bindings::PAGE_SIZE {
> +            return Err(EDOM);
> +        }
> +
> +        // SAFETY: We just checked that the index is within bounds of th=
e folio.
> +        let page =3D unsafe { bindings::folio_page(self.0 .0.get(), page=
_index) };
> +
> +        // SAFETY: `page` is valid because it was returned by `folio_pag=
e` above.
> +        let ptr =3D unsafe { bindings::kmap(page) };
> +
> +        // SAFETY: We just mapped `ptr`, so it's valid for read.
> +        let data =3D unsafe { core::slice::from_raw_parts(ptr.cast::<u8>=
(), bindings::PAGE_SIZE) };
> +
> +        Ok(MapGuard { data, page })
> +    }
> +}
> +
> +/// A mapped [`UniqueFolio`].
> +pub struct MapGuard<'a> {
> +    data: &'a [u8],
> +    page: *mut bindings::page,
> +}
> +
> +impl core::ops::Deref for MapGuard<'_> {
> +    type Target =3D [u8];
> +
> +    fn deref(&self) -> &Self::Target {
> +        self.data
> +    }
> +}
> +
> +impl Drop for MapGuard<'_> {
> +    fn drop(&mut self) {
> +        // SAFETY: A `MapGuard` instance is only created when `kmap` suc=
ceeds, so it's ok to unmap
> +        // it when the guard is dropped.
> +        unsafe { bindings::kunmap(self.page) };
> +    }
> +}
> +
> +/// A locked [`Folio`].

This should be an invariant.

--=20
Cheers,
Benno

> +pub struct LockedFolio<'a>(&'a Folio);
> +
> +impl LockedFolio<'_> {
> +    /// Creates a new locked folio from a raw pointer.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Callers must ensure that the folio is valid and locked. Addition=
ally, that the
> +    /// responsibility of unlocking is transferred to the new instance o=
f [`LockedFolio`]. Lastly,
> +    /// that the returned [`LockedFolio`] doesn't outlive the refcount t=
hat keeps it alive.
> +    #[allow(dead_code)]
> +    pub(crate) unsafe fn from_raw(folio: *const bindings::folio) -> Self=
 {
> +        let ptr =3D folio.cast();
> +        // SAFETY: The safety requirements ensure that `folio` (from whi=
ch `ptr` is derived) is
> +        // valid and will remain valid while the `LockedFolio` instance =
lives.
> +        Self(unsafe { &*ptr })
> +    }
> +
> +    /// Marks the folio as being up to date.
> +    pub fn mark_uptodate(&mut self) {
> +        // SAFETY: The folio is valid because the shared reference impli=
es a non-zero refcount.
> +        unsafe { bindings::folio_mark_uptodate(self.0 .0.get()) }
> +    }
> +
> +    /// Sets the error flag on the folio.
> +    pub fn set_error(&mut self) {
> +        // SAFETY: The folio is valid because the shared reference impli=
es a non-zero refcount.
> +        unsafe { bindings::folio_set_error(self.0 .0.get()) }
> +    }
> +
> +    fn for_each_page(
> +        &mut self,
> +        offset: usize,
> +        len: usize,
> +        mut cb: impl FnMut(&mut [u8]) -> Result,
> +    ) -> Result {
> +        let mut remaining =3D len;
> +        let mut next_offset =3D offset;
> +
> +        // Check that we don't overflow the folio.
> +        let end =3D offset.checked_add(len).ok_or(EDOM)?;
> +        if end > self.size() {
> +            return Err(EINVAL);
> +        }
> +
> +        while remaining > 0 {
> +            let page_offset =3D next_offset & (bindings::PAGE_SIZE - 1);
> +            let usable =3D min(remaining, bindings::PAGE_SIZE - page_off=
set);
> +            // SAFETY: The folio is valid because the shared reference i=
mplies a non-zero refcount;
> +            // `next_offset` is also guaranteed be lesss than the folio =
size.
> +            let ptr =3D unsafe { bindings::kmap_local_folio(self.0 .0.ge=
t(), next_offset) };
> +
> +            // SAFETY: `ptr` was just returned by the `kmap_local_folio`=
 above.
> +            let _guard =3D ScopeGuard::new(|| unsafe { bindings::kunmap_=
local(ptr) });
> +
> +            // SAFETY: `kmap_local_folio` maps whole page so we know it'=
s mapped for at least
> +            // `usable` bytes.
> +            let s =3D unsafe { core::slice::from_raw_parts_mut(ptr.cast:=
:<u8>(), usable) };
> +            cb(s)?;
> +
> +            next_offset +=3D usable;
> +            remaining -=3D usable;
> +        }
> +
> +        Ok(())
> +    }
> +
> +    /// Writes the given slice into the folio.
> +    pub fn write(&mut self, offset: usize, data: &[u8]) -> Result {
> +        let mut remaining =3D data;
> +
> +        self.for_each_page(offset, data.len(), |s| {
> +            s.copy_from_slice(&remaining[..s.len()]);
> +            remaining =3D &remaining[s.len()..];
> +            Ok(())
> +        })
> +    }
> +
> +    /// Writes zeroes into the folio.
> +    pub fn zero_out(&mut self, offset: usize, len: usize) -> Result {
> +        self.for_each_page(offset, len, |s| {
> +            s.fill(0);
> +            Ok(())
> +        })
> +    }
> +}
> +
> +impl core::ops::Deref for LockedFolio<'_> {
> +    type Target =3D Folio;
> +    fn deref(&self) -> &Self::Target {
> +        self.0
> +    }
> +}
> +
> +impl Drop for LockedFolio<'_> {
> +    fn drop(&mut self) {
> +        // SAFETY: The folio is valid because the shared reference impli=
es a non-zero refcount.
> +        unsafe { bindings::folio_unlock(self.0 .0.get()) }
> +    }
> +}
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index 00059b80c240..0e85b380da64 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -34,6 +34,7 @@
>   mod allocator;
>   mod build_assert;
>   pub mod error;
> +pub mod folio;
>   pub mod fs;
>   pub mod init;
>   pub mod ioctl;
> --
> 2.34.1
>=20
> 

