Return-Path: <linux-fsdevel+bounces-19438-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A9628C56FB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 15:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F2611F2314D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 13:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532891586C6;
	Tue, 14 May 2024 13:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G5ULopEQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8BE156C40;
	Tue, 14 May 2024 13:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715692677; cv=none; b=gFl7ehrXtxcYA1rVib4ZcihzvbFC5d0ADio7h5c5Q8cN+j/4a4LuclaFsbNJguh5qNs7h46p+oTW89rFNdZjMINr6kXEwjwFnF4gdJlXGoF+Fo3Pjjv828bKx0pmaziJs1aknAXnlfGJHurRzCZVncYAvScxR7ubVqw+Fj5qWU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715692677; c=relaxed/simple;
	bh=lGWIXcC2QoW/J24LXyjhj1HCMJ3h8BrwmaxqFP8da5w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AATzaE0MIYtzfkRDcS6VwV1O/K2zes4bCZMuAKbDbt22sapyFoZyIrAhpX1Font58p/IDrHo8a64o8nH57ddtsABGywuFqEbdkJms5x2VMGHKk4kX4tfqtvRBeGNKtNpxSV3y5iUTaVJR/Qifjkb7OUoosW9sHU+hNcC8+TlHF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G5ULopEQ; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1ee954e0aa6so43653995ad.3;
        Tue, 14 May 2024 06:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715692675; x=1716297475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mK0XIO8J3i30WJQvHbe+iKmgi4AcBMHK0nXgYSbXICI=;
        b=G5ULopEQgXtDJup4Ogs3LBa9j+Yq9pL4Ve8HRgdbimCclW3/sudi3r83+aVG+6L76V
         Jc1+y+fj2kK1tJ2eSaJgVfjaaZK+BXmskClkOfyQn8Js6+3ANDCzmx3IhyifE8vBOhF+
         rJ+MhG0lqJFqX8/8F3w6MVJrpUmmMGdkSureNe3o9DSkw7OQwxYr8Zc5Qa1BUlTB4JHJ
         s0xSfqMa+rdMMn32IoFc1R56P0bohtAr/3mRz55SuACxT1lx5C+mRrJVn8GA25YgmjS4
         NvRoE4GGeJX6UfcRdToje/NW4rUl6mikFn9++L9UlKC1iMKF5ztqYipD3vdrqmnvRNb2
         PL6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715692675; x=1716297475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mK0XIO8J3i30WJQvHbe+iKmgi4AcBMHK0nXgYSbXICI=;
        b=gcmnqShzD9YciV4LlumB8t0TcfqErc6TtplH2+pDf4KdBu39eAHag+oMB5LgAYDfvi
         JSi61XeQzUWp6GoWN3JUm6+ko7hapkaqq4m4iUBLC8Pd+JR71IwzT+MzGS1J5Km0z4DR
         wHW0OW032nhMYNyi0gBY1ssp5Yxiy9Kr5EUcdzdmU9HUctnVjR2KOcliYATnlB+MFHtU
         YDLyssjn3MrYh1j5RanGlDm9awthrsmegCNOYgyd6jTHEZf24/QammCYjt0G3Nrg9Bsg
         pQeFPJ+xyN39DxATJ07NbtnBJzcgZaebtItH6OEKgkTLb73UZiBTef5N3m/m2NOsK5SE
         1T0g==
X-Forwarded-Encrypted: i=1; AJvYcCX+Wo9Dd1io9M5ChdqSqYuywEN6NraLbd6VgnGysq1Y/8o+1e+G3R2qM8cxyB+fzv+N/WB0r689C5QOzAEhD7eWWFwXpG2yvBFbMPUbycwW3qjLN7bj8CRCV4Id0fApCryG4WrrF/uywHBlUl+QycLblkWGOOgT2yiOXda9TO1GzTu0rM8iaH+XouWa
X-Gm-Message-State: AOJu0YxWGqqzCM6Bvz0B4oGYna0qWPlZES9D2fKLS8KnB+WESJ941uH5
	i/eQAH+nvuifgmq6GnYX5DWBFKqfSxkS6hp4oW+OdhDv/Ug2SyHq
X-Google-Smtp-Source: AGHT+IHXXUBFZAvUqG+1Lr6XAHwj81MEbFOSTY4ATjGCqVwviodaeSDM7Eu0v5ZOyDqc3yhAMc7Vpw==
X-Received: by 2002:a17:902:7d95:b0:1ee:b2ff:c93a with SMTP id d9443c01a7336-1ef43f3e4admr118114945ad.40.1715692674704;
        Tue, 14 May 2024 06:17:54 -0700 (PDT)
Received: from wedsonaf-dev.. ([50.204.89.32])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1ef0b9d18a4sm97277335ad.56.2024.05.14.06.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 06:17:54 -0700 (PDT)
From: Wedson Almeida Filho <wedsonaf@gmail.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Dave Chinner <david@fromorbit.com>
Cc: Kent Overstreet <kent.overstreet@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fsdevel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wedson Almeida Filho <walmeida@microsoft.com>
Subject: [RFC PATCH v2 16/30] rust: folio: introduce basic support for folios
Date: Tue, 14 May 2024 10:16:57 -0300
Message-Id: <20240514131711.379322-17-wedsonaf@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240514131711.379322-1-wedsonaf@gmail.com>
References: <20240514131711.379322-1-wedsonaf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wedson Almeida Filho <walmeida@microsoft.com>

Allow Rust file systems to handle ref-counted folios.

Provide the minimum needed to implement `read_folio` (part of `struct
address_space_operations`) in read-only file systems and to read
uncached blocks.

Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
 rust/bindings/bindings_helper.h |   3 +
 rust/helpers.c                  |  94 ++++++++++
 rust/kernel/folio.rs            | 306 ++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs              |   1 +
 4 files changed, 404 insertions(+)
 create mode 100644 rust/kernel/folio.rs

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index dabb5a787e0d..fd22b1eafb1d 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -15,6 +15,7 @@
 #include <linux/fs_context.h>
 #include <linux/jiffies.h>
 #include <linux/mdio.h>
+#include <linux/pagemap.h>
 #include <linux/phy.h>
 #include <linux/refcount.h>
 #include <linux/sched.h>
@@ -37,3 +38,5 @@ const slab_flags_t RUST_CONST_HELPER_SLAB_ACCOUNT = SLAB_ACCOUNT;
 const unsigned long RUST_CONST_HELPER_SB_RDONLY = SB_RDONLY;
 
 const loff_t RUST_CONST_HELPER_MAX_LFS_FILESIZE = MAX_LFS_FILESIZE;
+
+const size_t RUST_CONST_HELPER_PAGE_SIZE = PAGE_SIZE;
diff --git a/rust/helpers.c b/rust/helpers.c
index deb2d21f3096..acff58e6caff 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -23,10 +23,14 @@
 #include <kunit/test-bug.h>
 #include <linux/bug.h>
 #include <linux/build_bug.h>
+#include <linux/cacheflush.h>
 #include <linux/err.h>
 #include <linux/errname.h>
 #include <linux/fs.h>
+#include <linux/highmem.h>
+#include <linux/mm.h>
 #include <linux/mutex.h>
+#include <linux/pagemap.h>
 #include <linux/refcount.h>
 #include <linux/sched/signal.h>
 #include <linux/spinlock.h>
@@ -164,6 +168,96 @@ struct file *rust_helper_get_file(struct file *f)
 }
 EXPORT_SYMBOL_GPL(rust_helper_get_file);
 
+void *rust_helper_kmap(struct page *page)
+{
+	return kmap(page);
+}
+EXPORT_SYMBOL_GPL(rust_helper_kmap);
+
+void rust_helper_kunmap(struct page *page)
+{
+	kunmap(page);
+}
+EXPORT_SYMBOL_GPL(rust_helper_kunmap);
+
+void rust_helper_folio_get(struct folio *folio)
+{
+	folio_get(folio);
+}
+EXPORT_SYMBOL_GPL(rust_helper_folio_get);
+
+void rust_helper_folio_put(struct folio *folio)
+{
+	folio_put(folio);
+}
+EXPORT_SYMBOL_GPL(rust_helper_folio_put);
+
+struct folio *rust_helper_folio_alloc(gfp_t gfp, unsigned int order)
+{
+	return folio_alloc(gfp, order);
+}
+EXPORT_SYMBOL_GPL(rust_helper_folio_alloc);
+
+struct page *rust_helper_folio_page(struct folio *folio, size_t n)
+{
+	return folio_page(folio, n);
+}
+EXPORT_SYMBOL_GPL(rust_helper_folio_page);
+
+loff_t rust_helper_folio_pos(struct folio *folio)
+{
+	return folio_pos(folio);
+}
+EXPORT_SYMBOL_GPL(rust_helper_folio_pos);
+
+size_t rust_helper_folio_size(struct folio *folio)
+{
+	return folio_size(folio);
+}
+EXPORT_SYMBOL_GPL(rust_helper_folio_size);
+
+void rust_helper_folio_lock(struct folio *folio)
+{
+	folio_lock(folio);
+}
+EXPORT_SYMBOL_GPL(rust_helper_folio_lock);
+
+bool rust_helper_folio_test_uptodate(struct folio *folio)
+{
+	return folio_test_uptodate(folio);
+}
+EXPORT_SYMBOL_GPL(rust_helper_folio_test_uptodate);
+
+void rust_helper_folio_mark_uptodate(struct folio *folio)
+{
+	folio_mark_uptodate(folio);
+}
+EXPORT_SYMBOL_GPL(rust_helper_folio_mark_uptodate);
+
+bool rust_helper_folio_test_highmem(struct folio *folio)
+{
+	return folio_test_highmem(folio);
+}
+EXPORT_SYMBOL_GPL(rust_helper_folio_test_highmem);
+
+void rust_helper_flush_dcache_folio(struct folio *folio)
+{
+	flush_dcache_folio(folio);
+}
+EXPORT_SYMBOL_GPL(rust_helper_flush_dcache_folio);
+
+void *rust_helper_kmap_local_folio(struct folio *folio, size_t offset)
+{
+	return kmap_local_folio(folio, offset);
+}
+EXPORT_SYMBOL_GPL(rust_helper_kmap_local_folio);
+
+void rust_helper_kunmap_local(const void *vaddr)
+{
+	kunmap_local(vaddr);
+}
+EXPORT_SYMBOL_GPL(rust_helper_kunmap_local);
+
 void rust_helper_i_uid_write(struct inode *inode, uid_t uid)
 {
 	i_uid_write(inode, uid);
diff --git a/rust/kernel/folio.rs b/rust/kernel/folio.rs
new file mode 100644
index 000000000000..20f51db920e4
--- /dev/null
+++ b/rust/kernel/folio.rs
@@ -0,0 +1,306 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Groups of contiguous pages, folios.
+//!
+//! C headers: [`include/linux/mm.h`](srctree/include/linux/mm.h)
+
+use crate::error::{code::*, Result};
+use crate::fs::{self, inode::INode, FileSystem};
+use crate::types::{self, ARef, AlwaysRefCounted, Locked, Opaque, ScopeGuard};
+use core::{cmp::min, marker::PhantomData, ops::Deref, ptr};
+
+/// The type of a [`Folio`] is unspecified.
+pub struct Unspecified;
+
+/// The [`Folio`] instance is a page-cache one.
+pub struct PageCache<T: FileSystem + ?Sized>(PhantomData<T>);
+
+/// A folio.
+///
+/// The `S` type parameter specifies the type of folio.
+///
+/// Wraps the kernel's `struct folio`.
+///
+/// # Invariants
+///
+/// Instances of this type are always ref-counted, that is, a call to `folio_get` ensures that the
+/// allocation remains valid at least until the matching call to `folio_put`.
+#[repr(transparent)]
+pub struct Folio<S = Unspecified>(pub(crate) Opaque<bindings::folio>, PhantomData<S>);
+
+// SAFETY: The type invariants guarantee that `Folio` is always ref-counted.
+unsafe impl<S> AlwaysRefCounted for Folio<S> {
+    fn inc_ref(&self) {
+        // SAFETY: The existence of a shared reference means that the refcount is nonzero.
+        unsafe { bindings::folio_get(self.0.get()) };
+    }
+
+    unsafe fn dec_ref(obj: ptr::NonNull<Self>) {
+        // SAFETY: The safety requirements guarantee that the refcount is nonzero.
+        unsafe { bindings::folio_put(obj.as_ref().0.get()) }
+    }
+}
+
+impl<S> Folio<S> {
+    /// Creates a new folio reference from the given raw pointer.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that:
+    /// * `ptr` is valid and remains so for the lifetime of the returned reference.
+    /// * The folio has the right state.
+    #[allow(dead_code)]
+    pub(crate) unsafe fn from_raw<'a>(ptr: *mut bindings::folio) -> &'a Self {
+        // SAFETY: The safety requirements guarantee that the cast below is ok.
+        unsafe { &*ptr.cast::<Self>() }
+    }
+
+    /// Returns the byte position of this folio in its file.
+    pub fn pos(&self) -> fs::Offset {
+        // SAFETY: The folio is valid because the shared reference implies a non-zero refcount.
+        unsafe { bindings::folio_pos(self.0.get()) }
+    }
+
+    /// Returns the byte size of this folio.
+    pub fn size(&self) -> usize {
+        // SAFETY: The folio is valid because the shared reference implies a non-zero refcount.
+        unsafe { bindings::folio_size(self.0.get()) }
+    }
+
+    /// Flushes the data cache for the pages that make up the folio.
+    pub fn flush_dcache(&self) {
+        // SAFETY: The folio is valid because the shared reference implies a non-zero refcount.
+        unsafe { bindings::flush_dcache_folio(self.0.get()) }
+    }
+
+    /// Returns true if the folio is in highmem.
+    pub fn test_highmem(&self) -> bool {
+        // SAFETY: The folio is valid because the shared reference implies a non-zero refcount.
+        unsafe { bindings::folio_test_highmem(self.0.get()) }
+    }
+
+    /// Returns whether the folio is up to date.
+    pub fn test_uptodate(&self) -> bool {
+        // SAFETY: The folio is valid because the shared reference implies a non-zero refcount.
+        unsafe { bindings::folio_test_uptodate(self.0.get()) }
+    }
+
+    /// Consumes the folio and returns an owned mapped reference.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that the folio is not concurrently mapped for write.
+    pub unsafe fn map_owned(folio: ARef<Self>, offset: usize) -> Result<Mapped<'static, S>> {
+        // SAFETY: The safety requirements of this function satisfy those of `map`.
+        let guard = unsafe { folio.map(offset)? };
+        let to_unmap = guard.page;
+        let data = &guard[0] as *const u8;
+        let data_len = guard.len();
+        core::mem::forget(guard);
+        Ok(Mapped {
+            _folio: folio,
+            to_unmap,
+            data,
+            data_len,
+            _p: PhantomData,
+        })
+    }
+
+    /// Maps the contents of a folio page into a slice.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that the folio is not concurrently mapped for write.
+    pub unsafe fn map(&self, offset: usize) -> Result<MapGuard<'_>> {
+        if offset >= self.size() {
+            return Err(EDOM);
+        }
+
+        let page_index = offset / bindings::PAGE_SIZE;
+        let page_offset = offset % bindings::PAGE_SIZE;
+
+        // SAFETY: We just checked that the index is within bounds of the folio.
+        let page = unsafe { bindings::folio_page(self.0.get(), page_index) };
+
+        // SAFETY: `page` is valid because it was returned by `folio_page` above.
+        let ptr = unsafe { bindings::kmap(page) };
+
+        let size = if self.test_highmem() {
+            bindings::PAGE_SIZE
+        } else {
+            self.size()
+        };
+
+        // SAFETY: We just mapped `ptr`, so it's valid for read.
+        let data = unsafe {
+            core::slice::from_raw_parts(ptr.cast::<u8>().add(page_offset), size - page_offset)
+        };
+        Ok(MapGuard { data, page })
+    }
+}
+
+impl<T: FileSystem + ?Sized> Folio<PageCache<T>> {
+    /// Returns the inode for which this folio holds data.
+    pub fn inode(&self) -> &INode<T> {
+        // SAFETY: The type parameter guarantees that this is a page-cache folio, so host is
+        // populated.
+        unsafe {
+            INode::from_raw((*(*self.0.get()).__bindgen_anon_1.__bindgen_anon_1.mapping).host)
+        }
+    }
+}
+
+/// An owned mapped folio.
+///
+/// That is, a mapped version of a folio that holds a reference to it.
+///
+/// The lifetime is used to tie the mapping to other lifetime, for example, the lifetime of a lock
+/// guard. This allows the mapping to exist only while a lock is held.
+///
+/// # Invariants
+///
+/// `to_unmap` is a mapped page of the folio. The byte range starting at `data` and extending for
+/// `data_len` bytes is within the mapped page.
+pub struct Mapped<'a, S = Unspecified> {
+    _folio: ARef<Folio<S>>,
+    to_unmap: *mut bindings::page,
+    data: *const u8,
+    data_len: usize,
+    _p: PhantomData<&'a ()>,
+}
+
+impl<S> Mapped<'_, S> {
+    /// Limits the length of the mapped region.
+    pub fn cap_len(&mut self, new_len: usize) {
+        if new_len < self.data_len {
+            self.data_len = new_len;
+        }
+    }
+}
+
+impl<S> Deref for Mapped<'_, S> {
+    type Target = [u8];
+
+    fn deref(&self) -> &Self::Target {
+        // SAFETY: By the type invariant, we know that `data` and `data_len` form a valid slice.
+        unsafe { core::slice::from_raw_parts(self.data, self.data_len) }
+    }
+}
+
+impl<S> Drop for Mapped<'_, S> {
+    fn drop(&mut self) {
+        // SAFETY: By the type invariant, we know that `to_unmap` is mapped.
+        unsafe { bindings::kunmap(self.to_unmap) };
+    }
+}
+
+/// A mapped [`Folio`].
+pub struct MapGuard<'a> {
+    data: &'a [u8],
+    page: *mut bindings::page,
+}
+
+impl Deref for MapGuard<'_> {
+    type Target = [u8];
+
+    fn deref(&self) -> &Self::Target {
+        self.data
+    }
+}
+
+impl Drop for MapGuard<'_> {
+    fn drop(&mut self) {
+        // SAFETY: A `MapGuard` instance is only created when `kmap` succeeds, so it's ok to unmap
+        // it when the guard is dropped.
+        unsafe { bindings::kunmap(self.page) };
+    }
+}
+
+// SAFETY: `raw_lock` calls folio_lock, which actually locks the folio.
+unsafe impl<S> types::Lockable for Folio<S> {
+    fn raw_lock(&self) {
+        // SAFETY: The folio is valid because the shared reference implies a non-zero refcount.
+        unsafe { bindings::folio_lock(self.0.get()) }
+    }
+
+    unsafe fn unlock(&self) {
+        // SAFETY: The safety requirements guarantee that the folio is locked.
+        unsafe { bindings::folio_unlock(self.0.get()) }
+    }
+}
+
+impl<T: Deref<Target = Folio<S>>, S> Locked<T> {
+    /// Marks the folio as being up to date.
+    pub fn mark_uptodate(&mut self) {
+        // SAFETY: The folio is valid because the shared reference implies a non-zero refcount.
+        unsafe { bindings::folio_mark_uptodate(self.deref().0.get()) }
+    }
+
+    /// Runs `cb` with the mapped folio for `len` bytes starting at `offset`.
+    ///
+    /// It may require more than one callback if the folio needs to be mapped one page at a time
+    /// (for example, when in highmem).
+    fn for_each_page(
+        &mut self,
+        offset: usize,
+        len: usize,
+        mut cb: impl FnMut(&mut [u8]) -> Result,
+    ) -> Result {
+        let mut remaining = len;
+        let mut next_offset = offset;
+
+        if self.test_uptodate() {
+            return Err(EIO);
+        }
+
+        // Check that we don't overflow the folio.
+        let end = offset.checked_add(len).ok_or(EDOM)?;
+        if end > self.deref().size() {
+            return Err(EINVAL);
+        }
+
+        while remaining > 0 {
+            let map_size = if self.test_highmem() {
+                bindings::PAGE_SIZE - (next_offset & (bindings::PAGE_SIZE - 1))
+            } else {
+                self.size() - next_offset
+            };
+            let usable = min(remaining, map_size);
+            // SAFETY: The folio is valid because the shared reference implies a non-zero refcount;
+            // `next_offset` is also guaranteed be lesss than the folio size.
+            let ptr = unsafe { bindings::kmap_local_folio(self.deref().0.get(), next_offset) };
+
+            // SAFETY: `ptr` was just returned by the `kmap_local_folio` above.
+            let _guard = ScopeGuard::new(|| unsafe { bindings::kunmap_local(ptr) });
+
+            // SAFETY: `kmap_local_folio` maps whole page so we know it's mapped for at least
+            // `usable` bytes.
+            let s = unsafe { core::slice::from_raw_parts_mut(ptr.cast::<u8>(), usable) };
+            cb(s)?;
+
+            next_offset += usable;
+            remaining -= usable;
+        }
+
+        Ok(())
+    }
+
+    /// Writes the given slice into the folio.
+    pub fn write(&mut self, offset: usize, data: &[u8]) -> Result {
+        let mut remaining = data;
+
+        self.for_each_page(offset, data.len(), |s| {
+            s.copy_from_slice(&remaining[..s.len()]);
+            remaining = &remaining[s.len()..];
+            Ok(())
+        })
+    }
+
+    /// Writes zeroes into the folio.
+    pub fn zero_out(&mut self, offset: usize, len: usize) -> Result {
+        self.for_each_page(offset, len, |s| {
+            s.fill(0);
+            Ok(())
+        })
+    }
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 81065d1bd679..445599d4bff6 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -30,6 +30,7 @@
 pub mod block;
 mod build_assert;
 pub mod error;
+pub mod folio;
 pub mod fs;
 pub mod init;
 pub mod ioctl;
-- 
2.34.1


