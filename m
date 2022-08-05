Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7830C58AD3F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Aug 2022 17:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241229AbiHEPoW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Aug 2022 11:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241101AbiHEPns (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Aug 2022 11:43:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6283565810;
        Fri,  5 Aug 2022 08:43:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 27559B82989;
        Fri,  5 Aug 2022 15:43:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49DCDC433C1;
        Fri,  5 Aug 2022 15:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659714202;
        bh=pMukJf+wOKoEB1PW4P7/EGuA2i2eUv89fqPTq7uWtew=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V0mO/weYuM2vrfhxJKHhrBLpRvVEsW21Ed6OKxeW03POejv5RlWTP/tfG/5bEgfeW
         RxGekDt9PL8vHqQ9nG/okG7hGHle1lWusnT8R48xDpL47mzWplrxVuyzXKwSiLo04d
         bXeRqi89O8GIlVNxfd5uR+LPeVorMhtGhnKoHdZ6ziVohmIO8Mv9HFMIBIlXfOOd0U
         wCyxlqDHuGBXJ4boSU/USkW4Fw3lO6c/OXYrDLffDzifYEFtiWmHmDUeBQRWncQn6r
         janHAAn9JSC3gGvTb+sbaP5Ox4qY61bBa4nrY6y+tRH/eLWGcCTdIlLS+TDaPFagLe
         Hv+sX/fksh0ww==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, patches@lists.linux.dev,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>
Subject: [PATCH v9 07/27] rust: import upstream `alloc` crate
Date:   Fri,  5 Aug 2022 17:41:52 +0200
Message-Id: <20220805154231.31257-8-ojeda@kernel.org>
In-Reply-To: <20220805154231.31257-1-ojeda@kernel.org>
References: <20220805154231.31257-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is a subset of the Rust standard library `alloc` crate,
version 1.62.0, licensed under "Apache-2.0 OR MIT", from:

    https://github.com/rust-lang/rust/tree/1.62.0/library/alloc/src

The files are copied as-is, with no modifications whatsoever
(not even adding the SPDX identifiers).

For copyright details, please see:

    https://github.com/rust-lang/rust/blob/1.62.0/COPYRIGHT

The next patch modifies these files as needed for use within
the kernel. This patch split allows reviewers to double-check
the import and to clearly see the differences introduced.

Vendoring `alloc`, at least for the moment, allows us to have fallible
allocations support (i.e. the `try_*` versions of methods which return
a `Result` instead of panicking) early on. It also gives a bit more
freedom to experiment with new interfaces and to iterate quickly.

Eventually, the goal is to have everything the kernel needs in
upstream `alloc` and drop it from the kernel tree.

For a summary of work on `alloc` happening upstream, please see:

    https://github.com/Rust-for-Linux/linux/issues/408

Co-developed-by: Alex Gaynor <alex.gaynor@gmail.com>
Signed-off-by: Alex Gaynor <alex.gaynor@gmail.com>
Co-developed-by: Wedson Almeida Filho <wedsonaf@google.com>
Signed-off-by: Wedson Almeida Filho <wedsonaf@google.com>
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 rust/alloc/alloc.rs            |  438 +++++
 rust/alloc/borrow.rs           |  496 +++++
 rust/alloc/boxed.rs            | 2024 +++++++++++++++++++++
 rust/alloc/collections/mod.rs  |  154 ++
 rust/alloc/lib.rs              |  236 +++
 rust/alloc/raw_vec.rs          |  518 ++++++
 rust/alloc/slice.rs            | 1202 ++++++++++++
 rust/alloc/vec/drain.rs        |  184 ++
 rust/alloc/vec/drain_filter.rs |  143 ++
 rust/alloc/vec/into_iter.rs    |  362 ++++
 rust/alloc/vec/is_zero.rs      |  118 ++
 rust/alloc/vec/mod.rs          | 3115 ++++++++++++++++++++++++++++++++
 rust/alloc/vec/partial_eq.rs   |   47 +
 13 files changed, 9037 insertions(+)
 create mode 100644 rust/alloc/alloc.rs
 create mode 100644 rust/alloc/borrow.rs
 create mode 100644 rust/alloc/boxed.rs
 create mode 100644 rust/alloc/collections/mod.rs
 create mode 100644 rust/alloc/lib.rs
 create mode 100644 rust/alloc/raw_vec.rs
 create mode 100644 rust/alloc/slice.rs
 create mode 100644 rust/alloc/vec/drain.rs
 create mode 100644 rust/alloc/vec/drain_filter.rs
 create mode 100644 rust/alloc/vec/into_iter.rs
 create mode 100644 rust/alloc/vec/is_zero.rs
 create mode 100644 rust/alloc/vec/mod.rs
 create mode 100644 rust/alloc/vec/partial_eq.rs

diff --git a/rust/alloc/alloc.rs b/rust/alloc/alloc.rs
new file mode 100644
index 000000000000..6162b5c6d4c9
--- /dev/null
+++ b/rust/alloc/alloc.rs
@@ -0,0 +1,438 @@
+//! Memory allocation APIs
+
+#![stable(feature = "alloc_module", since = "1.28.0")]
+
+#[cfg(not(test))]
+use core::intrinsics;
+use core::intrinsics::{min_align_of_val, size_of_val};
+
+use core::ptr::Unique;
+#[cfg(not(test))]
+use core::ptr::{self, NonNull};
+
+#[stable(feature = "alloc_module", since = "1.28.0")]
+#[doc(inline)]
+pub use core::alloc::*;
+
+use core::marker::Destruct;
+
+#[cfg(test)]
+mod tests;
+
+extern "Rust" {
+    // These are the magic symbols to call the global allocator.  rustc generates
+    // them to call `__rg_alloc` etc. if there is a `#[global_allocator]` attribute
+    // (the code expanding that attribute macro generates those functions), or to call
+    // the default implementations in libstd (`__rdl_alloc` etc. in `library/std/src/alloc.rs`)
+    // otherwise.
+    // The rustc fork of LLVM also special-cases these function names to be able to optimize them
+    // like `malloc`, `realloc`, and `free`, respectively.
+    #[rustc_allocator]
+    #[rustc_allocator_nounwind]
+    fn __rust_alloc(size: usize, align: usize) -> *mut u8;
+    #[rustc_allocator_nounwind]
+    fn __rust_dealloc(ptr: *mut u8, size: usize, align: usize);
+    #[rustc_allocator_nounwind]
+    fn __rust_realloc(ptr: *mut u8, old_size: usize, align: usize, new_size: usize) -> *mut u8;
+    #[rustc_allocator_nounwind]
+    fn __rust_alloc_zeroed(size: usize, align: usize) -> *mut u8;
+}
+
+/// The global memory allocator.
+///
+/// This type implements the [`Allocator`] trait by forwarding calls
+/// to the allocator registered with the `#[global_allocator]` attribute
+/// if there is one, or the `std` crate’s default.
+///
+/// Note: while this type is unstable, the functionality it provides can be
+/// accessed through the [free functions in `alloc`](self#functions).
+#[unstable(feature = "allocator_api", issue = "32838")]
+#[derive(Copy, Clone, Default, Debug)]
+#[cfg(not(test))]
+pub struct Global;
+
+#[cfg(test)]
+pub use std::alloc::Global;
+
+/// Allocate memory with the global allocator.
+///
+/// This function forwards calls to the [`GlobalAlloc::alloc`] method
+/// of the allocator registered with the `#[global_allocator]` attribute
+/// if there is one, or the `std` crate’s default.
+///
+/// This function is expected to be deprecated in favor of the `alloc` method
+/// of the [`Global`] type when it and the [`Allocator`] trait become stable.
+///
+/// # Safety
+///
+/// See [`GlobalAlloc::alloc`].
+///
+/// # Examples
+///
+/// ```
+/// use std::alloc::{alloc, dealloc, Layout};
+///
+/// unsafe {
+///     let layout = Layout::new::<u16>();
+///     let ptr = alloc(layout);
+///
+///     *(ptr as *mut u16) = 42;
+///     assert_eq!(*(ptr as *mut u16), 42);
+///
+///     dealloc(ptr, layout);
+/// }
+/// ```
+#[stable(feature = "global_alloc", since = "1.28.0")]
+#[must_use = "losing the pointer will leak memory"]
+#[inline]
+pub unsafe fn alloc(layout: Layout) -> *mut u8 {
+    unsafe { __rust_alloc(layout.size(), layout.align()) }
+}
+
+/// Deallocate memory with the global allocator.
+///
+/// This function forwards calls to the [`GlobalAlloc::dealloc`] method
+/// of the allocator registered with the `#[global_allocator]` attribute
+/// if there is one, or the `std` crate’s default.
+///
+/// This function is expected to be deprecated in favor of the `dealloc` method
+/// of the [`Global`] type when it and the [`Allocator`] trait become stable.
+///
+/// # Safety
+///
+/// See [`GlobalAlloc::dealloc`].
+#[stable(feature = "global_alloc", since = "1.28.0")]
+#[inline]
+pub unsafe fn dealloc(ptr: *mut u8, layout: Layout) {
+    unsafe { __rust_dealloc(ptr, layout.size(), layout.align()) }
+}
+
+/// Reallocate memory with the global allocator.
+///
+/// This function forwards calls to the [`GlobalAlloc::realloc`] method
+/// of the allocator registered with the `#[global_allocator]` attribute
+/// if there is one, or the `std` crate’s default.
+///
+/// This function is expected to be deprecated in favor of the `realloc` method
+/// of the [`Global`] type when it and the [`Allocator`] trait become stable.
+///
+/// # Safety
+///
+/// See [`GlobalAlloc::realloc`].
+#[stable(feature = "global_alloc", since = "1.28.0")]
+#[must_use = "losing the pointer will leak memory"]
+#[inline]
+pub unsafe fn realloc(ptr: *mut u8, layout: Layout, new_size: usize) -> *mut u8 {
+    unsafe { __rust_realloc(ptr, layout.size(), layout.align(), new_size) }
+}
+
+/// Allocate zero-initialized memory with the global allocator.
+///
+/// This function forwards calls to the [`GlobalAlloc::alloc_zeroed`] method
+/// of the allocator registered with the `#[global_allocator]` attribute
+/// if there is one, or the `std` crate’s default.
+///
+/// This function is expected to be deprecated in favor of the `alloc_zeroed` method
+/// of the [`Global`] type when it and the [`Allocator`] trait become stable.
+///
+/// # Safety
+///
+/// See [`GlobalAlloc::alloc_zeroed`].
+///
+/// # Examples
+///
+/// ```
+/// use std::alloc::{alloc_zeroed, dealloc, Layout};
+///
+/// unsafe {
+///     let layout = Layout::new::<u16>();
+///     let ptr = alloc_zeroed(layout);
+///
+///     assert_eq!(*(ptr as *mut u16), 0);
+///
+///     dealloc(ptr, layout);
+/// }
+/// ```
+#[stable(feature = "global_alloc", since = "1.28.0")]
+#[must_use = "losing the pointer will leak memory"]
+#[inline]
+pub unsafe fn alloc_zeroed(layout: Layout) -> *mut u8 {
+    unsafe { __rust_alloc_zeroed(layout.size(), layout.align()) }
+}
+
+#[cfg(not(test))]
+impl Global {
+    #[inline]
+    fn alloc_impl(&self, layout: Layout, zeroed: bool) -> Result<NonNull<[u8]>, AllocError> {
+        match layout.size() {
+            0 => Ok(NonNull::slice_from_raw_parts(layout.dangling(), 0)),
+            // SAFETY: `layout` is non-zero in size,
+            size => unsafe {
+                let raw_ptr = if zeroed { alloc_zeroed(layout) } else { alloc(layout) };
+                let ptr = NonNull::new(raw_ptr).ok_or(AllocError)?;
+                Ok(NonNull::slice_from_raw_parts(ptr, size))
+            },
+        }
+    }
+
+    // SAFETY: Same as `Allocator::grow`
+    #[inline]
+    unsafe fn grow_impl(
+        &self,
+        ptr: NonNull<u8>,
+        old_layout: Layout,
+        new_layout: Layout,
+        zeroed: bool,
+    ) -> Result<NonNull<[u8]>, AllocError> {
+        debug_assert!(
+            new_layout.size() >= old_layout.size(),
+            "`new_layout.size()` must be greater than or equal to `old_layout.size()`"
+        );
+
+        match old_layout.size() {
+            0 => self.alloc_impl(new_layout, zeroed),
+
+            // SAFETY: `new_size` is non-zero as `old_size` is greater than or equal to `new_size`
+            // as required by safety conditions. Other conditions must be upheld by the caller
+            old_size if old_layout.align() == new_layout.align() => unsafe {
+                let new_size = new_layout.size();
+
+                // `realloc` probably checks for `new_size >= old_layout.size()` or something similar.
+                intrinsics::assume(new_size >= old_layout.size());
+
+                let raw_ptr = realloc(ptr.as_ptr(), old_layout, new_size);
+                let ptr = NonNull::new(raw_ptr).ok_or(AllocError)?;
+                if zeroed {
+                    raw_ptr.add(old_size).write_bytes(0, new_size - old_size);
+                }
+                Ok(NonNull::slice_from_raw_parts(ptr, new_size))
+            },
+
+            // SAFETY: because `new_layout.size()` must be greater than or equal to `old_size`,
+            // both the old and new memory allocation are valid for reads and writes for `old_size`
+            // bytes. Also, because the old allocation wasn't yet deallocated, it cannot overlap
+            // `new_ptr`. Thus, the call to `copy_nonoverlapping` is safe. The safety contract
+            // for `dealloc` must be upheld by the caller.
+            old_size => unsafe {
+                let new_ptr = self.alloc_impl(new_layout, zeroed)?;
+                ptr::copy_nonoverlapping(ptr.as_ptr(), new_ptr.as_mut_ptr(), old_size);
+                self.deallocate(ptr, old_layout);
+                Ok(new_ptr)
+            },
+        }
+    }
+}
+
+#[unstable(feature = "allocator_api", issue = "32838")]
+#[cfg(not(test))]
+unsafe impl Allocator for Global {
+    #[inline]
+    fn allocate(&self, layout: Layout) -> Result<NonNull<[u8]>, AllocError> {
+        self.alloc_impl(layout, false)
+    }
+
+    #[inline]
+    fn allocate_zeroed(&self, layout: Layout) -> Result<NonNull<[u8]>, AllocError> {
+        self.alloc_impl(layout, true)
+    }
+
+    #[inline]
+    unsafe fn deallocate(&self, ptr: NonNull<u8>, layout: Layout) {
+        if layout.size() != 0 {
+            // SAFETY: `layout` is non-zero in size,
+            // other conditions must be upheld by the caller
+            unsafe { dealloc(ptr.as_ptr(), layout) }
+        }
+    }
+
+    #[inline]
+    unsafe fn grow(
+        &self,
+        ptr: NonNull<u8>,
+        old_layout: Layout,
+        new_layout: Layout,
+    ) -> Result<NonNull<[u8]>, AllocError> {
+        // SAFETY: all conditions must be upheld by the caller
+        unsafe { self.grow_impl(ptr, old_layout, new_layout, false) }
+    }
+
+    #[inline]
+    unsafe fn grow_zeroed(
+        &self,
+        ptr: NonNull<u8>,
+        old_layout: Layout,
+        new_layout: Layout,
+    ) -> Result<NonNull<[u8]>, AllocError> {
+        // SAFETY: all conditions must be upheld by the caller
+        unsafe { self.grow_impl(ptr, old_layout, new_layout, true) }
+    }
+
+    #[inline]
+    unsafe fn shrink(
+        &self,
+        ptr: NonNull<u8>,
+        old_layout: Layout,
+        new_layout: Layout,
+    ) -> Result<NonNull<[u8]>, AllocError> {
+        debug_assert!(
+            new_layout.size() <= old_layout.size(),
+            "`new_layout.size()` must be smaller than or equal to `old_layout.size()`"
+        );
+
+        match new_layout.size() {
+            // SAFETY: conditions must be upheld by the caller
+            0 => unsafe {
+                self.deallocate(ptr, old_layout);
+                Ok(NonNull::slice_from_raw_parts(new_layout.dangling(), 0))
+            },
+
+            // SAFETY: `new_size` is non-zero. Other conditions must be upheld by the caller
+            new_size if old_layout.align() == new_layout.align() => unsafe {
+                // `realloc` probably checks for `new_size <= old_layout.size()` or something similar.
+                intrinsics::assume(new_size <= old_layout.size());
+
+                let raw_ptr = realloc(ptr.as_ptr(), old_layout, new_size);
+                let ptr = NonNull::new(raw_ptr).ok_or(AllocError)?;
+                Ok(NonNull::slice_from_raw_parts(ptr, new_size))
+            },
+
+            // SAFETY: because `new_size` must be smaller than or equal to `old_layout.size()`,
+            // both the old and new memory allocation are valid for reads and writes for `new_size`
+            // bytes. Also, because the old allocation wasn't yet deallocated, it cannot overlap
+            // `new_ptr`. Thus, the call to `copy_nonoverlapping` is safe. The safety contract
+            // for `dealloc` must be upheld by the caller.
+            new_size => unsafe {
+                let new_ptr = self.allocate(new_layout)?;
+                ptr::copy_nonoverlapping(ptr.as_ptr(), new_ptr.as_mut_ptr(), new_size);
+                self.deallocate(ptr, old_layout);
+                Ok(new_ptr)
+            },
+        }
+    }
+}
+
+/// The allocator for unique pointers.
+#[cfg(all(not(no_global_oom_handling), not(test)))]
+#[lang = "exchange_malloc"]
+#[inline]
+unsafe fn exchange_malloc(size: usize, align: usize) -> *mut u8 {
+    let layout = unsafe { Layout::from_size_align_unchecked(size, align) };
+    match Global.allocate(layout) {
+        Ok(ptr) => ptr.as_mut_ptr(),
+        Err(_) => handle_alloc_error(layout),
+    }
+}
+
+#[cfg_attr(not(test), lang = "box_free")]
+#[inline]
+#[rustc_const_unstable(feature = "const_box", issue = "92521")]
+// This signature has to be the same as `Box`, otherwise an ICE will happen.
+// When an additional parameter to `Box` is added (like `A: Allocator`), this has to be added here as
+// well.
+// For example if `Box` is changed to  `struct Box<T: ?Sized, A: Allocator>(Unique<T>, A)`,
+// this function has to be changed to `fn box_free<T: ?Sized, A: Allocator>(Unique<T>, A)` as well.
+pub(crate) const unsafe fn box_free<T: ?Sized, A: ~const Allocator + ~const Destruct>(
+    ptr: Unique<T>,
+    alloc: A,
+) {
+    unsafe {
+        let size = size_of_val(ptr.as_ref());
+        let align = min_align_of_val(ptr.as_ref());
+        let layout = Layout::from_size_align_unchecked(size, align);
+        alloc.deallocate(From::from(ptr.cast()), layout)
+    }
+}
+
+// # Allocation error handler
+
+#[cfg(not(no_global_oom_handling))]
+extern "Rust" {
+    // This is the magic symbol to call the global alloc error handler.  rustc generates
+    // it to call `__rg_oom` if there is a `#[alloc_error_handler]`, or to call the
+    // default implementations below (`__rdl_oom`) otherwise.
+    fn __rust_alloc_error_handler(size: usize, align: usize) -> !;
+}
+
+/// Abort on memory allocation error or failure.
+///
+/// Callers of memory allocation APIs wishing to abort computation
+/// in response to an allocation error are encouraged to call this function,
+/// rather than directly invoking `panic!` or similar.
+///
+/// The default behavior of this function is to print a message to standard error
+/// and abort the process.
+/// It can be replaced with [`set_alloc_error_hook`] and [`take_alloc_error_hook`].
+///
+/// [`set_alloc_error_hook`]: ../../std/alloc/fn.set_alloc_error_hook.html
+/// [`take_alloc_error_hook`]: ../../std/alloc/fn.take_alloc_error_hook.html
+#[stable(feature = "global_alloc", since = "1.28.0")]
+#[rustc_const_unstable(feature = "const_alloc_error", issue = "92523")]
+#[cfg(all(not(no_global_oom_handling), not(test)))]
+#[cold]
+pub const fn handle_alloc_error(layout: Layout) -> ! {
+    const fn ct_error(_: Layout) -> ! {
+        panic!("allocation failed");
+    }
+
+    fn rt_error(layout: Layout) -> ! {
+        unsafe {
+            __rust_alloc_error_handler(layout.size(), layout.align());
+        }
+    }
+
+    unsafe { core::intrinsics::const_eval_select((layout,), ct_error, rt_error) }
+}
+
+// For alloc test `std::alloc::handle_alloc_error` can be used directly.
+#[cfg(all(not(no_global_oom_handling), test))]
+pub use std::alloc::handle_alloc_error;
+
+#[cfg(all(not(no_global_oom_handling), not(test)))]
+#[doc(hidden)]
+#[allow(unused_attributes)]
+#[unstable(feature = "alloc_internals", issue = "none")]
+pub mod __alloc_error_handler {
+    use crate::alloc::Layout;
+
+    // called via generated `__rust_alloc_error_handler`
+
+    // if there is no `#[alloc_error_handler]`
+    #[rustc_std_internal_symbol]
+    pub unsafe extern "C-unwind" fn __rdl_oom(size: usize, _align: usize) -> ! {
+        panic!("memory allocation of {size} bytes failed")
+    }
+
+    // if there is an `#[alloc_error_handler]`
+    #[rustc_std_internal_symbol]
+    pub unsafe extern "C-unwind" fn __rg_oom(size: usize, align: usize) -> ! {
+        let layout = unsafe { Layout::from_size_align_unchecked(size, align) };
+        extern "Rust" {
+            #[lang = "oom"]
+            fn oom_impl(layout: Layout) -> !;
+        }
+        unsafe { oom_impl(layout) }
+    }
+}
+
+/// Specialize clones into pre-allocated, uninitialized memory.
+/// Used by `Box::clone` and `Rc`/`Arc::make_mut`.
+pub(crate) trait WriteCloneIntoRaw: Sized {
+    unsafe fn write_clone_into_raw(&self, target: *mut Self);
+}
+
+impl<T: Clone> WriteCloneIntoRaw for T {
+    #[inline]
+    default unsafe fn write_clone_into_raw(&self, target: *mut Self) {
+        // Having allocated *first* may allow the optimizer to create
+        // the cloned value in-place, skipping the local and move.
+        unsafe { target.write(self.clone()) };
+    }
+}
+
+impl<T: Copy> WriteCloneIntoRaw for T {
+    #[inline]
+    unsafe fn write_clone_into_raw(&self, target: *mut Self) {
+        // We can always copy in-place, without ever involving a local value.
+        unsafe { target.copy_from_nonoverlapping(self, 1) };
+    }
+}
diff --git a/rust/alloc/borrow.rs b/rust/alloc/borrow.rs
new file mode 100644
index 000000000000..cb4e438f8bea
--- /dev/null
+++ b/rust/alloc/borrow.rs
@@ -0,0 +1,496 @@
+//! A module for working with borrowed data.
+
+#![stable(feature = "rust1", since = "1.0.0")]
+
+use core::cmp::Ordering;
+use core::hash::{Hash, Hasher};
+use core::ops::Deref;
+#[cfg(not(no_global_oom_handling))]
+use core::ops::{Add, AddAssign};
+
+#[stable(feature = "rust1", since = "1.0.0")]
+pub use core::borrow::{Borrow, BorrowMut};
+
+use crate::fmt;
+#[cfg(not(no_global_oom_handling))]
+use crate::string::String;
+
+use Cow::*;
+
+#[stable(feature = "rust1", since = "1.0.0")]
+impl<'a, B: ?Sized> Borrow<B> for Cow<'a, B>
+where
+    B: ToOwned,
+    <B as ToOwned>::Owned: 'a,
+{
+    fn borrow(&self) -> &B {
+        &**self
+    }
+}
+
+/// A generalization of `Clone` to borrowed data.
+///
+/// Some types make it possible to go from borrowed to owned, usually by
+/// implementing the `Clone` trait. But `Clone` works only for going from `&T`
+/// to `T`. The `ToOwned` trait generalizes `Clone` to construct owned data
+/// from any borrow of a given type.
+#[cfg_attr(not(test), rustc_diagnostic_item = "ToOwned")]
+#[stable(feature = "rust1", since = "1.0.0")]
+pub trait ToOwned {
+    /// The resulting type after obtaining ownership.
+    #[stable(feature = "rust1", since = "1.0.0")]
+    type Owned: Borrow<Self>;
+
+    /// Creates owned data from borrowed data, usually by cloning.
+    ///
+    /// # Examples
+    ///
+    /// Basic usage:
+    ///
+    /// ```
+    /// let s: &str = "a";
+    /// let ss: String = s.to_owned();
+    ///
+    /// let v: &[i32] = &[1, 2];
+    /// let vv: Vec<i32> = v.to_owned();
+    /// ```
+    #[stable(feature = "rust1", since = "1.0.0")]
+    #[must_use = "cloning is often expensive and is not expected to have side effects"]
+    fn to_owned(&self) -> Self::Owned;
+
+    /// Uses borrowed data to replace owned data, usually by cloning.
+    ///
+    /// This is borrow-generalized version of `Clone::clone_from`.
+    ///
+    /// # Examples
+    ///
+    /// Basic usage:
+    ///
+    /// ```
+    /// # #![feature(toowned_clone_into)]
+    /// let mut s: String = String::new();
+    /// "hello".clone_into(&mut s);
+    ///
+    /// let mut v: Vec<i32> = Vec::new();
+    /// [1, 2][..].clone_into(&mut v);
+    /// ```
+    #[unstable(feature = "toowned_clone_into", reason = "recently added", issue = "41263")]
+    fn clone_into(&self, target: &mut Self::Owned) {
+        *target = self.to_owned();
+    }
+}
+
+#[stable(feature = "rust1", since = "1.0.0")]
+impl<T> ToOwned for T
+where
+    T: Clone,
+{
+    type Owned = T;
+    fn to_owned(&self) -> T {
+        self.clone()
+    }
+
+    fn clone_into(&self, target: &mut T) {
+        target.clone_from(self);
+    }
+}
+
+/// A clone-on-write smart pointer.
+///
+/// The type `Cow` is a smart pointer providing clone-on-write functionality: it
+/// can enclose and provide immutable access to borrowed data, and clone the
+/// data lazily when mutation or ownership is required. The type is designed to
+/// work with general borrowed data via the `Borrow` trait.
+///
+/// `Cow` implements `Deref`, which means that you can call
+/// non-mutating methods directly on the data it encloses. If mutation
+/// is desired, `to_mut` will obtain a mutable reference to an owned
+/// value, cloning if necessary.
+///
+/// If you need reference-counting pointers, note that
+/// [`Rc::make_mut`][crate::rc::Rc::make_mut] and
+/// [`Arc::make_mut`][crate::sync::Arc::make_mut] can provide clone-on-write
+/// functionality as well.
+///
+/// # Examples
+///
+/// ```
+/// use std::borrow::Cow;
+///
+/// fn abs_all(input: &mut Cow<[i32]>) {
+///     for i in 0..input.len() {
+///         let v = input[i];
+///         if v < 0 {
+///             // Clones into a vector if not already owned.
+///             input.to_mut()[i] = -v;
+///         }
+///     }
+/// }
+///
+/// // No clone occurs because `input` doesn't need to be mutated.
+/// let slice = [0, 1, 2];
+/// let mut input = Cow::from(&slice[..]);
+/// abs_all(&mut input);
+///
+/// // Clone occurs because `input` needs to be mutated.
+/// let slice = [-1, 0, 1];
+/// let mut input = Cow::from(&slice[..]);
+/// abs_all(&mut input);
+///
+/// // No clone occurs because `input` is already owned.
+/// let mut input = Cow::from(vec![-1, 0, 1]);
+/// abs_all(&mut input);
+/// ```
+///
+/// Another example showing how to keep `Cow` in a struct:
+///
+/// ```
+/// use std::borrow::Cow;
+///
+/// struct Items<'a, X: 'a> where [X]: ToOwned<Owned = Vec<X>> {
+///     values: Cow<'a, [X]>,
+/// }
+///
+/// impl<'a, X: Clone + 'a> Items<'a, X> where [X]: ToOwned<Owned = Vec<X>> {
+///     fn new(v: Cow<'a, [X]>) -> Self {
+///         Items { values: v }
+///     }
+/// }
+///
+/// // Creates a container from borrowed values of a slice
+/// let readonly = [1, 2];
+/// let borrowed = Items::new((&readonly[..]).into());
+/// match borrowed {
+///     Items { values: Cow::Borrowed(b) } => println!("borrowed {b:?}"),
+///     _ => panic!("expect borrowed value"),
+/// }
+///
+/// let mut clone_on_write = borrowed;
+/// // Mutates the data from slice into owned vec and pushes a new value on top
+/// clone_on_write.values.to_mut().push(3);
+/// println!("clone_on_write = {:?}", clone_on_write.values);
+///
+/// // The data was mutated. Let's check it out.
+/// match clone_on_write {
+///     Items { values: Cow::Owned(_) } => println!("clone_on_write contains owned data"),
+///     _ => panic!("expect owned data"),
+/// }
+/// ```
+#[stable(feature = "rust1", since = "1.0.0")]
+#[cfg_attr(not(test), rustc_diagnostic_item = "Cow")]
+pub enum Cow<'a, B: ?Sized + 'a>
+where
+    B: ToOwned,
+{
+    /// Borrowed data.
+    #[stable(feature = "rust1", since = "1.0.0")]
+    Borrowed(#[stable(feature = "rust1", since = "1.0.0")] &'a B),
+
+    /// Owned data.
+    #[stable(feature = "rust1", since = "1.0.0")]
+    Owned(#[stable(feature = "rust1", since = "1.0.0")] <B as ToOwned>::Owned),
+}
+
+#[stable(feature = "rust1", since = "1.0.0")]
+impl<B: ?Sized + ToOwned> Clone for Cow<'_, B> {
+    fn clone(&self) -> Self {
+        match *self {
+            Borrowed(b) => Borrowed(b),
+            Owned(ref o) => {
+                let b: &B = o.borrow();
+                Owned(b.to_owned())
+            }
+        }
+    }
+
+    fn clone_from(&mut self, source: &Self) {
+        match (self, source) {
+            (&mut Owned(ref mut dest), &Owned(ref o)) => o.borrow().clone_into(dest),
+            (t, s) => *t = s.clone(),
+        }
+    }
+}
+
+impl<B: ?Sized + ToOwned> Cow<'_, B> {
+    /// Returns true if the data is borrowed, i.e. if `to_mut` would require additional work.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// #![feature(cow_is_borrowed)]
+    /// use std::borrow::Cow;
+    ///
+    /// let cow = Cow::Borrowed("moo");
+    /// assert!(cow.is_borrowed());
+    ///
+    /// let bull: Cow<'_, str> = Cow::Owned("...moo?".to_string());
+    /// assert!(!bull.is_borrowed());
+    /// ```
+    #[unstable(feature = "cow_is_borrowed", issue = "65143")]
+    #[rustc_const_unstable(feature = "const_cow_is_borrowed", issue = "65143")]
+    pub const fn is_borrowed(&self) -> bool {
+        match *self {
+            Borrowed(_) => true,
+            Owned(_) => false,
+        }
+    }
+
+    /// Returns true if the data is owned, i.e. if `to_mut` would be a no-op.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// #![feature(cow_is_borrowed)]
+    /// use std::borrow::Cow;
+    ///
+    /// let cow: Cow<'_, str> = Cow::Owned("moo".to_string());
+    /// assert!(cow.is_owned());
+    ///
+    /// let bull = Cow::Borrowed("...moo?");
+    /// assert!(!bull.is_owned());
+    /// ```
+    #[unstable(feature = "cow_is_borrowed", issue = "65143")]
+    #[rustc_const_unstable(feature = "const_cow_is_borrowed", issue = "65143")]
+    pub const fn is_owned(&self) -> bool {
+        !self.is_borrowed()
+    }
+
+    /// Acquires a mutable reference to the owned form of the data.
+    ///
+    /// Clones the data if it is not already owned.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use std::borrow::Cow;
+    ///
+    /// let mut cow = Cow::Borrowed("foo");
+    /// cow.to_mut().make_ascii_uppercase();
+    ///
+    /// assert_eq!(
+    ///   cow,
+    ///   Cow::Owned(String::from("FOO")) as Cow<str>
+    /// );
+    /// ```
+    #[stable(feature = "rust1", since = "1.0.0")]
+    pub fn to_mut(&mut self) -> &mut <B as ToOwned>::Owned {
+        match *self {
+            Borrowed(borrowed) => {
+                *self = Owned(borrowed.to_owned());
+                match *self {
+                    Borrowed(..) => unreachable!(),
+                    Owned(ref mut owned) => owned,
+                }
+            }
+            Owned(ref mut owned) => owned,
+        }
+    }
+
+    /// Extracts the owned data.
+    ///
+    /// Clones the data if it is not already owned.
+    ///
+    /// # Examples
+    ///
+    /// Calling `into_owned` on a `Cow::Borrowed` returns a clone of the borrowed data:
+    ///
+    /// ```
+    /// use std::borrow::Cow;
+    ///
+    /// let s = "Hello world!";
+    /// let cow = Cow::Borrowed(s);
+    ///
+    /// assert_eq!(
+    ///   cow.into_owned(),
+    ///   String::from(s)
+    /// );
+    /// ```
+    ///
+    /// Calling `into_owned` on a `Cow::Owned` returns the owned data. The data is moved out of the
+    /// `Cow` without being cloned.
+    ///
+    /// ```
+    /// use std::borrow::Cow;
+    ///
+    /// let s = "Hello world!";
+    /// let cow: Cow<str> = Cow::Owned(String::from(s));
+    ///
+    /// assert_eq!(
+    ///   cow.into_owned(),
+    ///   String::from(s)
+    /// );
+    /// ```
+    #[stable(feature = "rust1", since = "1.0.0")]
+    pub fn into_owned(self) -> <B as ToOwned>::Owned {
+        match self {
+            Borrowed(borrowed) => borrowed.to_owned(),
+            Owned(owned) => owned,
+        }
+    }
+}
+
+#[stable(feature = "rust1", since = "1.0.0")]
+#[rustc_const_unstable(feature = "const_deref", issue = "88955")]
+impl<B: ?Sized + ToOwned> const Deref for Cow<'_, B>
+where
+    B::Owned: ~const Borrow<B>,
+{
+    type Target = B;
+
+    fn deref(&self) -> &B {
+        match *self {
+            Borrowed(borrowed) => borrowed,
+            Owned(ref owned) => owned.borrow(),
+        }
+    }
+}
+
+#[stable(feature = "rust1", since = "1.0.0")]
+impl<B: ?Sized> Eq for Cow<'_, B> where B: Eq + ToOwned {}
+
+#[stable(feature = "rust1", since = "1.0.0")]
+impl<B: ?Sized> Ord for Cow<'_, B>
+where
+    B: Ord + ToOwned,
+{
+    #[inline]
+    fn cmp(&self, other: &Self) -> Ordering {
+        Ord::cmp(&**self, &**other)
+    }
+}
+
+#[stable(feature = "rust1", since = "1.0.0")]
+impl<'a, 'b, B: ?Sized, C: ?Sized> PartialEq<Cow<'b, C>> for Cow<'a, B>
+where
+    B: PartialEq<C> + ToOwned,
+    C: ToOwned,
+{
+    #[inline]
+    fn eq(&self, other: &Cow<'b, C>) -> bool {
+        PartialEq::eq(&**self, &**other)
+    }
+}
+
+#[stable(feature = "rust1", since = "1.0.0")]
+impl<'a, B: ?Sized> PartialOrd for Cow<'a, B>
+where
+    B: PartialOrd + ToOwned,
+{
+    #[inline]
+    fn partial_cmp(&self, other: &Cow<'a, B>) -> Option<Ordering> {
+        PartialOrd::partial_cmp(&**self, &**other)
+    }
+}
+
+#[stable(feature = "rust1", since = "1.0.0")]
+impl<B: ?Sized> fmt::Debug for Cow<'_, B>
+where
+    B: fmt::Debug + ToOwned<Owned: fmt::Debug>,
+{
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
+        match *self {
+            Borrowed(ref b) => fmt::Debug::fmt(b, f),
+            Owned(ref o) => fmt::Debug::fmt(o, f),
+        }
+    }
+}
+
+#[stable(feature = "rust1", since = "1.0.0")]
+impl<B: ?Sized> fmt::Display for Cow<'_, B>
+where
+    B: fmt::Display + ToOwned<Owned: fmt::Display>,
+{
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
+        match *self {
+            Borrowed(ref b) => fmt::Display::fmt(b, f),
+            Owned(ref o) => fmt::Display::fmt(o, f),
+        }
+    }
+}
+
+#[stable(feature = "default", since = "1.11.0")]
+impl<B: ?Sized> Default for Cow<'_, B>
+where
+    B: ToOwned<Owned: Default>,
+{
+    /// Creates an owned Cow<'a, B> with the default value for the contained owned value.
+    fn default() -> Self {
+        Owned(<B as ToOwned>::Owned::default())
+    }
+}
+
+#[stable(feature = "rust1", since = "1.0.0")]
+impl<B: ?Sized> Hash for Cow<'_, B>
+where
+    B: Hash + ToOwned,
+{
+    #[inline]
+    fn hash<H: Hasher>(&self, state: &mut H) {
+        Hash::hash(&**self, state)
+    }
+}
+
+#[stable(feature = "rust1", since = "1.0.0")]
+impl<T: ?Sized + ToOwned> AsRef<T> for Cow<'_, T> {
+    fn as_ref(&self) -> &T {
+        self
+    }
+}
+
+#[cfg(not(no_global_oom_handling))]
+#[stable(feature = "cow_add", since = "1.14.0")]
+impl<'a> Add<&'a str> for Cow<'a, str> {
+    type Output = Cow<'a, str>;
+
+    #[inline]
+    fn add(mut self, rhs: &'a str) -> Self::Output {
+        self += rhs;
+        self
+    }
+}
+
+#[cfg(not(no_global_oom_handling))]
+#[stable(feature = "cow_add", since = "1.14.0")]
+impl<'a> Add<Cow<'a, str>> for Cow<'a, str> {
+    type Output = Cow<'a, str>;
+
+    #[inline]
+    fn add(mut self, rhs: Cow<'a, str>) -> Self::Output {
+        self += rhs;
+        self
+    }
+}
+
+#[cfg(not(no_global_oom_handling))]
+#[stable(feature = "cow_add", since = "1.14.0")]
+impl<'a> AddAssign<&'a str> for Cow<'a, str> {
+    fn add_assign(&mut self, rhs: &'a str) {
+        if self.is_empty() {
+            *self = Cow::Borrowed(rhs)
+        } else if !rhs.is_empty() {
+            if let Cow::Borrowed(lhs) = *self {
+                let mut s = String::with_capacity(lhs.len() + rhs.len());
+                s.push_str(lhs);
+                *self = Cow::Owned(s);
+            }
+            self.to_mut().push_str(rhs);
+        }
+    }
+}
+
+#[cfg(not(no_global_oom_handling))]
+#[stable(feature = "cow_add", since = "1.14.0")]
+impl<'a> AddAssign<Cow<'a, str>> for Cow<'a, str> {
+    fn add_assign(&mut self, rhs: Cow<'a, str>) {
+        if self.is_empty() {
+            *self = rhs
+        } else if !rhs.is_empty() {
+            if let Cow::Borrowed(lhs) = *self {
+                let mut s = String::with_capacity(lhs.len() + rhs.len());
+                s.push_str(lhs);
+                *self = Cow::Owned(s);
+            }
+            self.to_mut().push_str(&rhs);
+        }
+    }
+}
diff --git a/rust/alloc/boxed.rs b/rust/alloc/boxed.rs
new file mode 100644
index 000000000000..c07536f0d0ce
--- /dev/null
+++ b/rust/alloc/boxed.rs
@@ -0,0 +1,2024 @@
+//! A pointer type for heap allocation.
+//!
+//! [`Box<T>`], casually referred to as a 'box', provides the simplest form of
+//! heap allocation in Rust. Boxes provide ownership for this allocation, and
+//! drop their contents when they go out of scope. Boxes also ensure that they
+//! never allocate more than `isize::MAX` bytes.
+//!
+//! # Examples
+//!
+//! Move a value from the stack to the heap by creating a [`Box`]:
+//!
+//! ```
+//! let val: u8 = 5;
+//! let boxed: Box<u8> = Box::new(val);
+//! ```
+//!
+//! Move a value from a [`Box`] back to the stack by [dereferencing]:
+//!
+//! ```
+//! let boxed: Box<u8> = Box::new(5);
+//! let val: u8 = *boxed;
+//! ```
+//!
+//! Creating a recursive data structure:
+//!
+//! ```
+//! #[derive(Debug)]
+//! enum List<T> {
+//!     Cons(T, Box<List<T>>),
+//!     Nil,
+//! }
+//!
+//! let list: List<i32> = List::Cons(1, Box::new(List::Cons(2, Box::new(List::Nil))));
+//! println!("{list:?}");
+//! ```
+//!
+//! This will print `Cons(1, Cons(2, Nil))`.
+//!
+//! Recursive structures must be boxed, because if the definition of `Cons`
+//! looked like this:
+//!
+//! ```compile_fail,E0072
+//! # enum List<T> {
+//! Cons(T, List<T>),
+//! # }
+//! ```
+//!
+//! It wouldn't work. This is because the size of a `List` depends on how many
+//! elements are in the list, and so we don't know how much memory to allocate
+//! for a `Cons`. By introducing a [`Box<T>`], which has a defined size, we know how
+//! big `Cons` needs to be.
+//!
+//! # Memory layout
+//!
+//! For non-zero-sized values, a [`Box`] will use the [`Global`] allocator for
+//! its allocation. It is valid to convert both ways between a [`Box`] and a
+//! raw pointer allocated with the [`Global`] allocator, given that the
+//! [`Layout`] used with the allocator is correct for the type. More precisely,
+//! a `value: *mut T` that has been allocated with the [`Global`] allocator
+//! with `Layout::for_value(&*value)` may be converted into a box using
+//! [`Box::<T>::from_raw(value)`]. Conversely, the memory backing a `value: *mut
+//! T` obtained from [`Box::<T>::into_raw`] may be deallocated using the
+//! [`Global`] allocator with [`Layout::for_value(&*value)`].
+//!
+//! For zero-sized values, the `Box` pointer still has to be [valid] for reads
+//! and writes and sufficiently aligned. In particular, casting any aligned
+//! non-zero integer literal to a raw pointer produces a valid pointer, but a
+//! pointer pointing into previously allocated memory that since got freed is
+//! not valid. The recommended way to build a Box to a ZST if `Box::new` cannot
+//! be used is to use [`ptr::NonNull::dangling`].
+//!
+//! So long as `T: Sized`, a `Box<T>` is guaranteed to be represented
+//! as a single pointer and is also ABI-compatible with C pointers
+//! (i.e. the C type `T*`). This means that if you have extern "C"
+//! Rust functions that will be called from C, you can define those
+//! Rust functions using `Box<T>` types, and use `T*` as corresponding
+//! type on the C side. As an example, consider this C header which
+//! declares functions that create and destroy some kind of `Foo`
+//! value:
+//!
+//! ```c
+//! /* C header */
+//!
+//! /* Returns ownership to the caller */
+//! struct Foo* foo_new(void);
+//!
+//! /* Takes ownership from the caller; no-op when invoked with null */
+//! void foo_delete(struct Foo*);
+//! ```
+//!
+//! These two functions might be implemented in Rust as follows. Here, the
+//! `struct Foo*` type from C is translated to `Box<Foo>`, which captures
+//! the ownership constraints. Note also that the nullable argument to
+//! `foo_delete` is represented in Rust as `Option<Box<Foo>>`, since `Box<Foo>`
+//! cannot be null.
+//!
+//! ```
+//! #[repr(C)]
+//! pub struct Foo;
+//!
+//! #[no_mangle]
+//! pub extern "C" fn foo_new() -> Box<Foo> {
+//!     Box::new(Foo)
+//! }
+//!
+//! #[no_mangle]
+//! pub extern "C" fn foo_delete(_: Option<Box<Foo>>) {}
+//! ```
+//!
+//! Even though `Box<T>` has the same representation and C ABI as a C pointer,
+//! this does not mean that you can convert an arbitrary `T*` into a `Box<T>`
+//! and expect things to work. `Box<T>` values will always be fully aligned,
+//! non-null pointers. Moreover, the destructor for `Box<T>` will attempt to
+//! free the value with the global allocator. In general, the best practice
+//! is to only use `Box<T>` for pointers that originated from the global
+//! allocator.
+//!
+//! **Important.** At least at present, you should avoid using
+//! `Box<T>` types for functions that are defined in C but invoked
+//! from Rust. In those cases, you should directly mirror the C types
+//! as closely as possible. Using types like `Box<T>` where the C
+//! definition is just using `T*` can lead to undefined behavior, as
+//! described in [rust-lang/unsafe-code-guidelines#198][ucg#198].
+//!
+//! [ucg#198]: https://github.com/rust-lang/unsafe-code-guidelines/issues/198
+//! [dereferencing]: core::ops::Deref
+//! [`Box::<T>::from_raw(value)`]: Box::from_raw
+//! [`Global`]: crate::alloc::Global
+//! [`Layout`]: crate::alloc::Layout
+//! [`Layout::for_value(&*value)`]: crate::alloc::Layout::for_value
+//! [valid]: ptr#safety
+
+#![stable(feature = "rust1", since = "1.0.0")]
+
+use core::any::Any;
+use core::async_iter::AsyncIterator;
+use core::borrow;
+use core::cmp::Ordering;
+use core::convert::{From, TryFrom};
+use core::fmt;
+use core::future::Future;
+use core::hash::{Hash, Hasher};
+#[cfg(not(no_global_oom_handling))]
+use core::iter::FromIterator;
+use core::iter::{FusedIterator, Iterator};
+use core::marker::{Destruct, Unpin, Unsize};
+use core::mem;
+use core::ops::{
+    CoerceUnsized, Deref, DerefMut, DispatchFromDyn, Generator, GeneratorState, Receiver,
+};
+use core::pin::Pin;
+use core::ptr::{self, Unique};
+use core::task::{Context, Poll};
+
+#[cfg(not(no_global_oom_handling))]
+use crate::alloc::{handle_alloc_error, WriteCloneIntoRaw};
+use crate::alloc::{AllocError, Allocator, Global, Layout};
+#[cfg(not(no_global_oom_handling))]
+use crate::borrow::Cow;
+use crate::raw_vec::RawVec;
+#[cfg(not(no_global_oom_handling))]
+use crate::str::from_boxed_utf8_unchecked;
+#[cfg(not(no_global_oom_handling))]
+use crate::vec::Vec;
+
+#[unstable(feature = "thin_box", issue = "92791")]
+pub use thin::ThinBox;
+
+mod thin;
+
+/// A pointer type for heap allocation.
+///
+/// See the [module-level documentation](../../std/boxed/index.html) for more.
+#[lang = "owned_box"]
+#[fundamental]
+#[stable(feature = "rust1", since = "1.0.0")]
+// The declaration of the `Box` struct must be kept in sync with the
+// `alloc::alloc::box_free` function or ICEs will happen. See the comment
+// on `box_free` for more details.
+pub struct Box<
+    T: ?Sized,
+    #[unstable(feature = "allocator_api", issue = "32838")] A: Allocator = Global,
+>(Unique<T>, A);
+
+impl<T> Box<T> {
+    /// Allocates memory on the heap and then places `x` into it.
+    ///
+    /// This doesn't actually allocate if `T` is zero-sized.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let five = Box::new(5);
+    /// ```
+    #[cfg(not(no_global_oom_handling))]
+    #[inline(always)]
+    #[stable(feature = "rust1", since = "1.0.0")]
+    #[must_use]
+    pub fn new(x: T) -> Self {
+        box x
+    }
+
+    /// Constructs a new box with uninitialized contents.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// #![feature(new_uninit)]
+    ///
+    /// let mut five = Box::<u32>::new_uninit();
+    ///
+    /// let five = unsafe {
+    ///     // Deferred initialization:
+    ///     five.as_mut_ptr().write(5);
+    ///
+    ///     five.assume_init()
+    /// };
+    ///
+    /// assert_eq!(*five, 5)
+    /// ```
+    #[cfg(not(no_global_oom_handling))]
+    #[unstable(feature = "new_uninit", issue = "63291")]
+    #[must_use]
+    #[inline]
+    pub fn new_uninit() -> Box<mem::MaybeUninit<T>> {
+        Self::new_uninit_in(Global)
+    }
+
+    /// Constructs a new `Box` with uninitialized contents, with the memory
+    /// being filled with `0` bytes.
+    ///
+    /// See [`MaybeUninit::zeroed`][zeroed] for examples of correct and incorrect usage
+    /// of this method.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// #![feature(new_uninit)]
+    ///
+    /// let zero = Box::<u32>::new_zeroed();
+    /// let zero = unsafe { zero.assume_init() };
+    ///
+    /// assert_eq!(*zero, 0)
+    /// ```
+    ///
+    /// [zeroed]: mem::MaybeUninit::zeroed
+    #[cfg(not(no_global_oom_handling))]
+    #[inline]
+    #[unstable(feature = "new_uninit", issue = "63291")]
+    #[must_use]
+    pub fn new_zeroed() -> Box<mem::MaybeUninit<T>> {
+        Self::new_zeroed_in(Global)
+    }
+
+    /// Constructs a new `Pin<Box<T>>`. If `T` does not implement `Unpin`, then
+    /// `x` will be pinned in memory and unable to be moved.
+    #[cfg(not(no_global_oom_handling))]
+    #[stable(feature = "pin", since = "1.33.0")]
+    #[must_use]
+    #[inline(always)]
+    pub fn pin(x: T) -> Pin<Box<T>> {
+        (box x).into()
+    }
+
+    /// Allocates memory on the heap then places `x` into it,
+    /// returning an error if the allocation fails
+    ///
+    /// This doesn't actually allocate if `T` is zero-sized.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// #![feature(allocator_api)]
+    ///
+    /// let five = Box::try_new(5)?;
+    /// # Ok::<(), std::alloc::AllocError>(())
+    /// ```
+    #[unstable(feature = "allocator_api", issue = "32838")]
+    #[inline]
+    pub fn try_new(x: T) -> Result<Self, AllocError> {
+        Self::try_new_in(x, Global)
+    }
+
+    /// Constructs a new box with uninitialized contents on the heap,
+    /// returning an error if the allocation fails
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// #![feature(allocator_api, new_uninit)]
+    ///
+    /// let mut five = Box::<u32>::try_new_uninit()?;
+    ///
+    /// let five = unsafe {
+    ///     // Deferred initialization:
+    ///     five.as_mut_ptr().write(5);
+    ///
+    ///     five.assume_init()
+    /// };
+    ///
+    /// assert_eq!(*five, 5);
+    /// # Ok::<(), std::alloc::AllocError>(())
+    /// ```
+    #[unstable(feature = "allocator_api", issue = "32838")]
+    // #[unstable(feature = "new_uninit", issue = "63291")]
+    #[inline]
+    pub fn try_new_uninit() -> Result<Box<mem::MaybeUninit<T>>, AllocError> {
+        Box::try_new_uninit_in(Global)
+    }
+
+    /// Constructs a new `Box` with uninitialized contents, with the memory
+    /// being filled with `0` bytes on the heap
+    ///
+    /// See [`MaybeUninit::zeroed`][zeroed] for examples of correct and incorrect usage
+    /// of this method.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// #![feature(allocator_api, new_uninit)]
+    ///
+    /// let zero = Box::<u32>::try_new_zeroed()?;
+    /// let zero = unsafe { zero.assume_init() };
+    ///
+    /// assert_eq!(*zero, 0);
+    /// # Ok::<(), std::alloc::AllocError>(())
+    /// ```
+    ///
+    /// [zeroed]: mem::MaybeUninit::zeroed
+    #[unstable(feature = "allocator_api", issue = "32838")]
+    // #[unstable(feature = "new_uninit", issue = "63291")]
+    #[inline]
+    pub fn try_new_zeroed() -> Result<Box<mem::MaybeUninit<T>>, AllocError> {
+        Box::try_new_zeroed_in(Global)
+    }
+}
+
+impl<T, A: Allocator> Box<T, A> {
+    /// Allocates memory in the given allocator then places `x` into it.
+    ///
+    /// This doesn't actually allocate if `T` is zero-sized.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// #![feature(allocator_api)]
+    ///
+    /// use std::alloc::System;
+    ///
+    /// let five = Box::new_in(5, System);
+    /// ```
+    #[cfg(not(no_global_oom_handling))]
+    #[unstable(feature = "allocator_api", issue = "32838")]
+    #[rustc_const_unstable(feature = "const_box", issue = "92521")]
+    #[must_use]
+    #[inline]
+    pub const fn new_in(x: T, alloc: A) -> Self
+    where
+        A: ~const Allocator + ~const Destruct,
+    {
+        let mut boxed = Self::new_uninit_in(alloc);
+        unsafe {
+            boxed.as_mut_ptr().write(x);
+            boxed.assume_init()
+        }
+    }
+
+    /// Allocates memory in the given allocator then places `x` into it,
+    /// returning an error if the allocation fails
+    ///
+    /// This doesn't actually allocate if `T` is zero-sized.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// #![feature(allocator_api)]
+    ///
+    /// use std::alloc::System;
+    ///
+    /// let five = Box::try_new_in(5, System)?;
+    /// # Ok::<(), std::alloc::AllocError>(())
+    /// ```
+    #[unstable(feature = "allocator_api", issue = "32838")]
+    #[rustc_const_unstable(feature = "const_box", issue = "92521")]
+    #[inline]
+    pub const fn try_new_in(x: T, alloc: A) -> Result<Self, AllocError>
+    where
+        T: ~const Destruct,
+        A: ~const Allocator + ~const Destruct,
+    {
+        let mut boxed = Self::try_new_uninit_in(alloc)?;
+        unsafe {
+            boxed.as_mut_ptr().write(x);
+            Ok(boxed.assume_init())
+        }
+    }
+
+    /// Constructs a new box with uninitialized contents in the provided allocator.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// #![feature(allocator_api, new_uninit)]
+    ///
+    /// use std::alloc::System;
+    ///
+    /// let mut five = Box::<u32, _>::new_uninit_in(System);
+    ///
+    /// let five = unsafe {
+    ///     // Deferred initialization:
+    ///     five.as_mut_ptr().write(5);
+    ///
+    ///     five.assume_init()
+    /// };
+    ///
+    /// assert_eq!(*five, 5)
+    /// ```
+    #[unstable(feature = "allocator_api", issue = "32838")]
+    #[rustc_const_unstable(feature = "const_box", issue = "92521")]
+    #[cfg(not(no_global_oom_handling))]
+    #[must_use]
+    // #[unstable(feature = "new_uninit", issue = "63291")]
+    pub const fn new_uninit_in(alloc: A) -> Box<mem::MaybeUninit<T>, A>
+    where
+        A: ~const Allocator + ~const Destruct,
+    {
+        let layout = Layout::new::<mem::MaybeUninit<T>>();
+        // NOTE: Prefer match over unwrap_or_else since closure sometimes not inlineable.
+        // That would make code size bigger.
+        match Box::try_new_uninit_in(alloc) {
+            Ok(m) => m,
+            Err(_) => handle_alloc_error(layout),
+        }
+    }
+
+    /// Constructs a new box with uninitialized contents in the provided allocator,
+    /// returning an error if the allocation fails
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// #![feature(allocator_api, new_uninit)]
+    ///
+    /// use std::alloc::System;
+    ///
+    /// let mut five = Box::<u32, _>::try_new_uninit_in(System)?;
+    ///
+    /// let five = unsafe {
+    ///     // Deferred initialization:
+    ///     five.as_mut_ptr().write(5);
+    ///
+    ///     five.assume_init()
+    /// };
+    ///
+    /// assert_eq!(*five, 5);
+    /// # Ok::<(), std::alloc::AllocError>(())
+    /// ```
+    #[unstable(feature = "allocator_api", issue = "32838")]
+    // #[unstable(feature = "new_uninit", issue = "63291")]
+    #[rustc_const_unstable(feature = "const_box", issue = "92521")]
+    pub const fn try_new_uninit_in(alloc: A) -> Result<Box<mem::MaybeUninit<T>, A>, AllocError>
+    where
+        A: ~const Allocator + ~const Destruct,
+    {
+        let layout = Layout::new::<mem::MaybeUninit<T>>();
+        let ptr = alloc.allocate(layout)?.cast();
+        unsafe { Ok(Box::from_raw_in(ptr.as_ptr(), alloc)) }
+    }
+
+    /// Constructs a new `Box` with uninitialized contents, with the memory
+    /// being filled with `0` bytes in the provided allocator.
+    ///
+    /// See [`MaybeUninit::zeroed`][zeroed] for examples of correct and incorrect usage
+    /// of this method.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// #![feature(allocator_api, new_uninit)]
+    ///
+    /// use std::alloc::System;
+    ///
+    /// let zero = Box::<u32, _>::new_zeroed_in(System);
+    /// let zero = unsafe { zero.assume_init() };
+    ///
+    /// assert_eq!(*zero, 0)
+    /// ```
+    ///
+    /// [zeroed]: mem::MaybeUninit::zeroed
+    #[unstable(feature = "allocator_api", issue = "32838")]
+    #[rustc_const_unstable(feature = "const_box", issue = "92521")]
+    #[cfg(not(no_global_oom_handling))]
+    // #[unstable(feature = "new_uninit", issue = "63291")]
+    #[must_use]
+    pub const fn new_zeroed_in(alloc: A) -> Box<mem::MaybeUninit<T>, A>
+    where
+        A: ~const Allocator + ~const Destruct,
+    {
+        let layout = Layout::new::<mem::MaybeUninit<T>>();
+        // NOTE: Prefer match over unwrap_or_else since closure sometimes not inlineable.
+        // That would make code size bigger.
+        match Box::try_new_zeroed_in(alloc) {
+            Ok(m) => m,
+            Err(_) => handle_alloc_error(layout),
+        }
+    }
+
+    /// Constructs a new `Box` with uninitialized contents, with the memory
+    /// being filled with `0` bytes in the provided allocator,
+    /// returning an error if the allocation fails,
+    ///
+    /// See [`MaybeUninit::zeroed`][zeroed] for examples of correct and incorrect usage
+    /// of this method.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// #![feature(allocator_api, new_uninit)]
+    ///
+    /// use std::alloc::System;
+    ///
+    /// let zero = Box::<u32, _>::try_new_zeroed_in(System)?;
+    /// let zero = unsafe { zero.assume_init() };
+    ///
+    /// assert_eq!(*zero, 0);
+    /// # Ok::<(), std::alloc::AllocError>(())
+    /// ```
+    ///
+    /// [zeroed]: mem::MaybeUninit::zeroed
+    #[unstable(feature = "allocator_api", issue = "32838")]
+    // #[unstable(feature = "new_uninit", issue = "63291")]
+    #[rustc_const_unstable(feature = "const_box", issue = "92521")]
+    pub const fn try_new_zeroed_in(alloc: A) -> Result<Box<mem::MaybeUninit<T>, A>, AllocError>
+    where
+        A: ~const Allocator + ~const Destruct,
+    {
+        let layout = Layout::new::<mem::MaybeUninit<T>>();
+        let ptr = alloc.allocate_zeroed(layout)?.cast();
+        unsafe { Ok(Box::from_raw_in(ptr.as_ptr(), alloc)) }
+    }
+
+    /// Constructs a new `Pin<Box<T, A>>`. If `T` does not implement `Unpin`, then
+    /// `x` will be pinned in memory and unable to be moved.
+    #[cfg(not(no_global_oom_handling))]
+    #[unstable(feature = "allocator_api", issue = "32838")]
+    #[rustc_const_unstable(feature = "const_box", issue = "92521")]
+    #[must_use]
+    #[inline(always)]
+    pub const fn pin_in(x: T, alloc: A) -> Pin<Self>
+    where
+        A: 'static + ~const Allocator + ~const Destruct,
+    {
+        Self::into_pin(Self::new_in(x, alloc))
+    }
+
+    /// Converts a `Box<T>` into a `Box<[T]>`
+    ///
+    /// This conversion does not allocate on the heap and happens in place.
+    #[unstable(feature = "box_into_boxed_slice", issue = "71582")]
+    #[rustc_const_unstable(feature = "const_box", issue = "92521")]
+    pub const fn into_boxed_slice(boxed: Self) -> Box<[T], A> {
+        let (raw, alloc) = Box::into_raw_with_allocator(boxed);
+        unsafe { Box::from_raw_in(raw as *mut [T; 1], alloc) }
+    }
+
+    /// Consumes the `Box`, returning the wrapped value.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// #![feature(box_into_inner)]
+    ///
+    /// let c = Box::new(5);
+    ///
+    /// assert_eq!(Box::into_inner(c), 5);
+    /// ```
+    #[unstable(feature = "box_into_inner", issue = "80437")]
+    #[rustc_const_unstable(feature = "const_box", issue = "92521")]
+    #[inline]
+    pub const fn into_inner(boxed: Self) -> T
+    where
+        Self: ~const Destruct,
+    {
+        *boxed
+    }
+}
+
+impl<T> Box<[T]> {
+    /// Constructs a new boxed slice with uninitialized contents.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// #![feature(new_uninit)]
+    ///
+    /// let mut values = Box::<[u32]>::new_uninit_slice(3);
+    ///
+    /// let values = unsafe {
+    ///     // Deferred initialization:
+    ///     values[0].as_mut_ptr().write(1);
+    ///     values[1].as_mut_ptr().write(2);
+    ///     values[2].as_mut_ptr().write(3);
+    ///
+    ///     values.assume_init()
+    /// };
+    ///
+    /// assert_eq!(*values, [1, 2, 3])
+    /// ```
+    #[cfg(not(no_global_oom_handling))]
+    #[unstable(feature = "new_uninit", issue = "63291")]
+    #[must_use]
+    pub fn new_uninit_slice(len: usize) -> Box<[mem::MaybeUninit<T>]> {
+        unsafe { RawVec::with_capacity(len).into_box(len) }
+    }
+
+    /// Constructs a new boxed slice with uninitialized contents, with the memory
+    /// being filled with `0` bytes.
+    ///
+    /// See [`MaybeUninit::zeroed`][zeroed] for examples of correct and incorrect usage
+    /// of this method.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// #![feature(new_uninit)]
+    ///
+    /// let values = Box::<[u32]>::new_zeroed_slice(3);
+    /// let values = unsafe { values.assume_init() };
+    ///
+    /// assert_eq!(*values, [0, 0, 0])
+    /// ```
+    ///
+    /// [zeroed]: mem::MaybeUninit::zeroed
+    #[cfg(not(no_global_oom_handling))]
+    #[unstable(feature = "new_uninit", issue = "63291")]
+    #[must_use]
+    pub fn new_zeroed_slice(len: usize) -> Box<[mem::MaybeUninit<T>]> {
+        unsafe { RawVec::with_capacity_zeroed(len).into_box(len) }
+    }
+
+    /// Constructs a new boxed slice with uninitialized contents. Returns an error if
+    /// the allocation fails
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// #![feature(allocator_api, new_uninit)]
+    ///
+    /// let mut values = Box::<[u32]>::try_new_uninit_slice(3)?;
+    /// let values = unsafe {
+    ///     // Deferred initialization:
+    ///     values[0].as_mut_ptr().write(1);
+    ///     values[1].as_mut_ptr().write(2);
+    ///     values[2].as_mut_ptr().write(3);
+    ///     values.assume_init()
+    /// };
+    ///
+    /// assert_eq!(*values, [1, 2, 3]);
+    /// # Ok::<(), std::alloc::AllocError>(())
+    /// ```
+    #[unstable(feature = "allocator_api", issue = "32838")]
+    #[inline]
+    pub fn try_new_uninit_slice(len: usize) -> Result<Box<[mem::MaybeUninit<T>]>, AllocError> {
+        unsafe {
+            let layout = match Layout::array::<mem::MaybeUninit<T>>(len) {
+                Ok(l) => l,
+                Err(_) => return Err(AllocError),
+            };
+            let ptr = Global.allocate(layout)?;
+            Ok(RawVec::from_raw_parts_in(ptr.as_mut_ptr() as *mut _, len, Global).into_box(len))
+        }
+    }
+
+    /// Constructs a new boxed slice with uninitialized contents, with the memory
+    /// being filled with `0` bytes. Returns an error if the allocation fails
+    ///
+    /// See [`MaybeUninit::zeroed`][zeroed] for examples of correct and incorrect usage
+    /// of this method.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// #![feature(allocator_api, new_uninit)]
+    ///
+    /// let values = Box::<[u32]>::try_new_zeroed_slice(3)?;
+    /// let values = unsafe { values.assume_init() };
+    ///
+    /// assert_eq!(*values, [0, 0, 0]);
+    /// # Ok::<(), std::alloc::AllocError>(())
+    /// ```
+    ///
+    /// [zeroed]: mem::MaybeUninit::zeroed
+    #[unstable(feature = "allocator_api", issue = "32838")]
+    #[inline]
+    pub fn try_new_zeroed_slice(len: usize) -> Result<Box<[mem::MaybeUninit<T>]>, AllocError> {
+        unsafe {
+            let layout = match Layout::array::<mem::MaybeUninit<T>>(len) {
+                Ok(l) => l,
+                Err(_) => return Err(AllocError),
+            };
+            let ptr = Global.allocate_zeroed(layout)?;
+            Ok(RawVec::from_raw_parts_in(ptr.as_mut_ptr() as *mut _, len, Global).into_box(len))
+        }
+    }
+}
+
+impl<T, A: Allocator> Box<[T], A> {
+    /// Constructs a new boxed slice with uninitialized contents in the provided allocator.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// #![feature(allocator_api, new_uninit)]
+    ///
+    /// use std::alloc::System;
+    ///
+    /// let mut values = Box::<[u32], _>::new_uninit_slice_in(3, System);
+    ///
+    /// let values = unsafe {
+    ///     // Deferred initialization:
+    ///     values[0].as_mut_ptr().write(1);
+    ///     values[1].as_mut_ptr().write(2);
+    ///     values[2].as_mut_ptr().write(3);
+    ///
+    ///     values.assume_init()
+    /// };
+    ///
+    /// assert_eq!(*values, [1, 2, 3])
+    /// ```
+    #[cfg(not(no_global_oom_handling))]
+    #[unstable(feature = "allocator_api", issue = "32838")]
+    // #[unstable(feature = "new_uninit", issue = "63291")]
+    #[must_use]
+    pub fn new_uninit_slice_in(len: usize, alloc: A) -> Box<[mem::MaybeUninit<T>], A> {
+        unsafe { RawVec::with_capacity_in(len, alloc).into_box(len) }
+    }
+
+    /// Constructs a new boxed slice with uninitialized contents in the provided allocator,
+    /// with the memory being filled with `0` bytes.
+    ///
+    /// See [`MaybeUninit::zeroed`][zeroed] for examples of correct and incorrect usage
+    /// of this method.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// #![feature(allocator_api, new_uninit)]
+    ///
+    /// use std::alloc::System;
+    ///
+    /// let values = Box::<[u32], _>::new_zeroed_slice_in(3, System);
+    /// let values = unsafe { values.assume_init() };
+    ///
+    /// assert_eq!(*values, [0, 0, 0])
+    /// ```
+    ///
+    /// [zeroed]: mem::MaybeUninit::zeroed
+    #[cfg(not(no_global_oom_handling))]
+    #[unstable(feature = "allocator_api", issue = "32838")]
+    // #[unstable(feature = "new_uninit", issue = "63291")]
+    #[must_use]
+    pub fn new_zeroed_slice_in(len: usize, alloc: A) -> Box<[mem::MaybeUninit<T>], A> {
+        unsafe { RawVec::with_capacity_zeroed_in(len, alloc).into_box(len) }
+    }
+}
+
+impl<T, A: Allocator> Box<mem::MaybeUninit<T>, A> {
+    /// Converts to `Box<T, A>`.
+    ///
+    /// # Safety
+    ///
+    /// As with [`MaybeUninit::assume_init`],
+    /// it is up to the caller to guarantee that the value
+    /// really is in an initialized state.
+    /// Calling this when the content is not yet fully initialized
+    /// causes immediate undefined behavior.
+    ///
+    /// [`MaybeUninit::assume_init`]: mem::MaybeUninit::assume_init
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// #![feature(new_uninit)]
+    ///
+    /// let mut five = Box::<u32>::new_uninit();
+    ///
+    /// let five: Box<u32> = unsafe {
+    ///     // Deferred initialization:
+    ///     five.as_mut_ptr().write(5);
+    ///
+    ///     five.assume_init()
+    /// };
+    ///
+    /// assert_eq!(*five, 5)
+    /// ```
+    #[unstable(feature = "new_uninit", issue = "63291")]
+    #[rustc_const_unstable(feature = "const_box", issue = "92521")]
+    #[inline]
+    pub const unsafe fn assume_init(self) -> Box<T, A> {
+        let (raw, alloc) = Box::into_raw_with_allocator(self);
+        unsafe { Box::from_raw_in(raw as *mut T, alloc) }
+    }
+
+    /// Writes the value and converts to `Box<T, A>`.
+    ///
+    /// This method converts the box similarly to [`Box::assume_init`] but
+    /// writes `value` into it before conversion thus guaranteeing safety.
+    /// In some scenarios use of this method may improve performance because
+    /// the compiler may be able to optimize copying from stack.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// #![feature(new_uninit)]
+    ///
+    /// let big_box = Box::<[usize; 1024]>::new_uninit();
+    ///
+    /// let mut array = [0; 1024];
+    /// for (i, place) in array.iter_mut().enumerate() {
+    ///     *place = i;
+    /// }
+    ///
+    /// // The optimizer may be able to elide this copy, so previous code writes
+    /// // to heap directly.
+    /// let big_box = Box::write(big_box, array);
+    ///
+    /// for (i, x) in big_box.iter().enumerate() {
+    ///     assert_eq!(*x, i);
+    /// }
+    /// ```
+    #[unstable(feature = "new_uninit", issue = "63291")]
+    #[rustc_const_unstable(feature = "const_box", issue = "92521")]
+    #[inline]
+    pub const fn write(mut boxed: Self, value: T) -> Box<T, A> {
+        unsafe {
+            (*boxed).write(value);
+            boxed.assume_init()
+        }
+    }
+}
+
+impl<T, A: Allocator> Box<[mem::MaybeUninit<T>], A> {
+    /// Converts to `Box<[T], A>`.
+    ///
+    /// # Safety
+    ///
+    /// As with [`MaybeUninit::assume_init`],
+    /// it is up to the caller to guarantee that the values
+    /// really are in an initialized state.
+    /// Calling this when the content is not yet fully initialized
+    /// causes immediate undefined behavior.
+    ///
+    /// [`MaybeUninit::assume_init`]: mem::MaybeUninit::assume_init
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// #![feature(new_uninit)]
+    ///
+    /// let mut values = Box::<[u32]>::new_uninit_slice(3);
+    ///
+    /// let values = unsafe {
+    ///     // Deferred initialization:
+    ///     values[0].as_mut_ptr().write(1);
+    ///     values[1].as_mut_ptr().write(2);
+    ///     values[2].as_mut_ptr().write(3);
+    ///
+    ///     values.assume_init()
+    /// };
+    ///
+    /// assert_eq!(*values, [1, 2, 3])
+    /// ```
+    #[unstable(feature = "new_uninit", issue = "63291")]
+    #[inline]
+    pub unsafe fn assume_init(self) -> Box<[T], A> {
+        let (raw, alloc) = Box::into_raw_with_allocator(self);
+        unsafe { Box::from_raw_in(raw as *mut [T], alloc) }
+    }
+}
+
+impl<T: ?Sized> Box<T> {
+    /// Constructs a box from a raw pointer.
+    ///
+    /// After calling this function, the raw pointer is owned by the
+    /// resulting `Box`. Specifically, the `Box` destructor will call
+    /// the destructor of `T` and free the allocated memory. For this
+    /// to be safe, the memory must have been allocated in accordance
+    /// with the [memory layout] used by `Box` .
+    ///
+    /// # Safety
+    ///
+    /// This function is unsafe because improper use may lead to
+    /// memory problems. For example, a double-free may occur if the
+    /// function is called twice on the same raw pointer.
+    ///
+    /// The safety conditions are described in the [memory layout] section.
+    ///
+    /// # Examples
+    ///
+    /// Recreate a `Box` which was previously converted to a raw pointer
+    /// using [`Box::into_raw`]:
+    /// ```
+    /// let x = Box::new(5);
+    /// let ptr = Box::into_raw(x);
+    /// let x = unsafe { Box::from_raw(ptr) };
+    /// ```
+    /// Manually create a `Box` from scratch by using the global allocator:
+    /// ```
+    /// use std::alloc::{alloc, Layout};
+    ///
+    /// unsafe {
+    ///     let ptr = alloc(Layout::new::<i32>()) as *mut i32;
+    ///     // In general .write is required to avoid attempting to destruct
+    ///     // the (uninitialized) previous contents of `ptr`, though for this
+    ///     // simple example `*ptr = 5` would have worked as well.
+    ///     ptr.write(5);
+    ///     let x = Box::from_raw(ptr);
+    /// }
+    /// ```
+    ///
+    /// [memory layout]: self#memory-layout
+    /// [`Layout`]: crate::Layout
+    #[stable(feature = "box_raw", since = "1.4.0")]
+    #[inline]
+    pub unsafe fn from_raw(raw: *mut T) -> Self {
+        unsafe { Self::from_raw_in(raw, Global) }
+    }
+}
+
+impl<T: ?Sized, A: Allocator> Box<T, A> {
+    /// Constructs a box from a raw pointer in the given allocator.
+    ///
+    /// After calling this function, the raw pointer is owned by the
+    /// resulting `Box`. Specifically, the `Box` destructor will call
+    /// the destructor of `T` and free the allocated memory. For this
+    /// to be safe, the memory must have been allocated in accordance
+    /// with the [memory layout] used by `Box` .
+    ///
+    /// # Safety
+    ///
+    /// This function is unsafe because improper use may lead to
+    /// memory problems. For example, a double-free may occur if the
+    /// function is called twice on the same raw pointer.
+    ///
+    ///
+    /// # Examples
+    ///
+    /// Recreate a `Box` which was previously converted to a raw pointer
+    /// using [`Box::into_raw_with_allocator`]:
+    /// ```
+    /// #![feature(allocator_api)]
+    ///
+    /// use std::alloc::System;
+    ///
+    /// let x = Box::new_in(5, System);
+    /// let (ptr, alloc) = Box::into_raw_with_allocator(x);
+    /// let x = unsafe { Box::from_raw_in(ptr, alloc) };
+    /// ```
+    /// Manually create a `Box` from scratch by using the system allocator:
+    /// ```
+    /// #![feature(allocator_api, slice_ptr_get)]
+    ///
+    /// use std::alloc::{Allocator, Layout, System};
+    ///
+    /// unsafe {
+    ///     let ptr = System.allocate(Layout::new::<i32>())?.as_mut_ptr() as *mut i32;
+    ///     // In general .write is required to avoid attempting to destruct
+    ///     // the (uninitialized) previous contents of `ptr`, though for this
+    ///     // simple example `*ptr = 5` would have worked as well.
+    ///     ptr.write(5);
+    ///     let x = Box::from_raw_in(ptr, System);
+    /// }
+    /// # Ok::<(), std::alloc::AllocError>(())
+    /// ```
+    ///
+    /// [memory layout]: self#memory-layout
+    /// [`Layout`]: crate::Layout
+    #[unstable(feature = "allocator_api", issue = "32838")]
+    #[rustc_const_unstable(feature = "const_box", issue = "92521")]
+    #[inline]
+    pub const unsafe fn from_raw_in(raw: *mut T, alloc: A) -> Self {
+        Box(unsafe { Unique::new_unchecked(raw) }, alloc)
+    }
+
+    /// Consumes the `Box`, returning a wrapped raw pointer.
+    ///
+    /// The pointer will be properly aligned and non-null.
+    ///
+    /// After calling this function, the caller is responsible for the
+    /// memory previously managed by the `Box`. In particular, the
+    /// caller should properly destroy `T` and release the memory, taking
+    /// into account the [memory layout] used by `Box`. The easiest way to
+    /// do this is to convert the raw pointer back into a `Box` with the
+    /// [`Box::from_raw`] function, allowing the `Box` destructor to perform
+    /// the cleanup.
+    ///
+    /// Note: this is an associated function, which means that you have
+    /// to call it as `Box::into_raw(b)` instead of `b.into_raw()`. This
+    /// is so that there is no conflict with a method on the inner type.
+    ///
+    /// # Examples
+    /// Converting the raw pointer back into a `Box` with [`Box::from_raw`]
+    /// for automatic cleanup:
+    /// ```
+    /// let x = Box::new(String::from("Hello"));
+    /// let ptr = Box::into_raw(x);
+    /// let x = unsafe { Box::from_raw(ptr) };
+    /// ```
+    /// Manual cleanup by explicitly running the destructor and deallocating
+    /// the memory:
+    /// ```
+    /// use std::alloc::{dealloc, Layout};
+    /// use std::ptr;
+    ///
+    /// let x = Box::new(String::from("Hello"));
+    /// let p = Box::into_raw(x);
+    /// unsafe {
+    ///     ptr::drop_in_place(p);
+    ///     dealloc(p as *mut u8, Layout::new::<String>());
+    /// }
+    /// ```
+    ///
+    /// [memory layout]: self#memory-layout
+    #[stable(feature = "box_raw", since = "1.4.0")]
+    #[inline]
+    pub fn into_raw(b: Self) -> *mut T {
+        Self::into_raw_with_allocator(b).0
+    }
+
+    /// Consumes the `Box`, returning a wrapped raw pointer and the allocator.
+    ///
+    /// The pointer will be properly aligned and non-null.
+    ///
+    /// After calling this function, the caller is responsible for the
+    /// memory previously managed by the `Box`. In particular, the
+    /// caller should properly destroy `T` and release the memory, taking
+    /// into account the [memory layout] used by `Box`. The easiest way to
+    /// do this is to convert the raw pointer back into a `Box` with the
+    /// [`Box::from_raw_in`] function, allowing the `Box` destructor to perform
+    /// the cleanup.
+    ///
+    /// Note: this is an associated function, which means that you have
+    /// to call it as `Box::into_raw_with_allocator(b)` instead of `b.into_raw_with_allocator()`. This
+    /// is so that there is no conflict with a method on the inner type.
+    ///
+    /// # Examples
+    /// Converting the raw pointer back into a `Box` with [`Box::from_raw_in`]
+    /// for automatic cleanup:
+    /// ```
+    /// #![feature(allocator_api)]
+    ///
+    /// use std::alloc::System;
+    ///
+    /// let x = Box::new_in(String::from("Hello"), System);
+    /// let (ptr, alloc) = Box::into_raw_with_allocator(x);
+    /// let x = unsafe { Box::from_raw_in(ptr, alloc) };
+    /// ```
+    /// Manual cleanup by explicitly running the destructor and deallocating
+    /// the memory:
+    /// ```
+    /// #![feature(allocator_api)]
+    ///
+    /// use std::alloc::{Allocator, Layout, System};
+    /// use std::ptr::{self, NonNull};
+    ///
+    /// let x = Box::new_in(String::from("Hello"), System);
+    /// let (ptr, alloc) = Box::into_raw_with_allocator(x);
+    /// unsafe {
+    ///     ptr::drop_in_place(ptr);
+    ///     let non_null = NonNull::new_unchecked(ptr);
+    ///     alloc.deallocate(non_null.cast(), Layout::new::<String>());
+    /// }
+    /// ```
+    ///
+    /// [memory layout]: self#memory-layout
+    #[unstable(feature = "allocator_api", issue = "32838")]
+    #[rustc_const_unstable(feature = "const_box", issue = "92521")]
+    #[inline]
+    pub const fn into_raw_with_allocator(b: Self) -> (*mut T, A) {
+        let (leaked, alloc) = Box::into_unique(b);
+        (leaked.as_ptr(), alloc)
+    }
+
+    #[unstable(
+        feature = "ptr_internals",
+        issue = "none",
+        reason = "use `Box::leak(b).into()` or `Unique::from(Box::leak(b))` instead"
+    )]
+    #[rustc_const_unstable(feature = "const_box", issue = "92521")]
+    #[inline]
+    #[doc(hidden)]
+    pub const fn into_unique(b: Self) -> (Unique<T>, A) {
+        // Box is recognized as a "unique pointer" by Stacked Borrows, but internally it is a
+        // raw pointer for the type system. Turning it directly into a raw pointer would not be
+        // recognized as "releasing" the unique pointer to permit aliased raw accesses,
+        // so all raw pointer methods have to go through `Box::leak`. Turning *that* to a raw pointer
+        // behaves correctly.
+        let alloc = unsafe { ptr::read(&b.1) };
+        (Unique::from(Box::leak(b)), alloc)
+    }
+
+    /// Returns a reference to the underlying allocator.
+    ///
+    /// Note: this is an associated function, which means that you have
+    /// to call it as `Box::allocator(&b)` instead of `b.allocator()`. This
+    /// is so that there is no conflict with a method on the inner type.
+    #[unstable(feature = "allocator_api", issue = "32838")]
+    #[rustc_const_unstable(feature = "const_box", issue = "92521")]
+    #[inline]
+    pub const fn allocator(b: &Self) -> &A {
+        &b.1
+    }
+
+    /// Consumes and leaks the `Box`, returning a mutable reference,
+    /// `&'a mut T`. Note that the type `T` must outlive the chosen lifetime
+    /// `'a`. If the type has only static references, or none at all, then this
+    /// may be chosen to be `'static`.
+    ///
+    /// This function is mainly useful for data that lives for the remainder of
+    /// the program's life. Dropping the returned reference will cause a memory
+    /// leak. If this is not acceptable, the reference should first be wrapped
+    /// with the [`Box::from_raw`] function producing a `Box`. This `Box` can
+    /// then be dropped which will properly destroy `T` and release the
+    /// allocated memory.
+    ///
+    /// Note: this is an associated function, which means that you have
+    /// to call it as `Box::leak(b)` instead of `b.leak()`. This
+    /// is so that there is no conflict with a method on the inner type.
+    ///
+    /// # Examples
+    ///
+    /// Simple usage:
+    ///
+    /// ```
+    /// let x = Box::new(41);
+    /// let static_ref: &'static mut usize = Box::leak(x);
+    /// *static_ref += 1;
+    /// assert_eq!(*static_ref, 42);
+    /// ```
+    ///
+    /// Unsized data:
+    ///
+    /// ```
+    /// let x = vec![1, 2, 3].into_boxed_slice();
+    /// let static_ref = Box::leak(x);
+    /// static_ref[0] = 4;
+    /// assert_eq!(*static_ref, [4, 2, 3]);
+    /// ```
+    #[stable(feature = "box_leak", since = "1.26.0")]
+    #[rustc_const_unstable(feature = "const_box", issue = "92521")]
+    #[inline]
+    pub const fn leak<'a>(b: Self) -> &'a mut T
+    where
+        A: 'a,
+    {
+        unsafe { &mut *mem::ManuallyDrop::new(b).0.as_ptr() }
+    }
+
+    /// Converts a `Box<T>` into a `Pin<Box<T>>`
+    ///
+    /// This conversion does not allocate on the heap and happens in place.
+    ///
+    /// This is also available via [`From`].
+    #[unstable(feature = "box_into_pin", issue = "62370")]
+    #[rustc_const_unstable(feature = "const_box", issue = "92521")]
+    pub const fn into_pin(boxed: Self) -> Pin<Self>
+    where
+        A: 'static,
+    {
+        // It's not possible to move or replace the insides of a `Pin<Box<T>>`
+        // when `T: !Unpin`,  so it's safe to pin it directly without any
+        // additional requirements.
+        unsafe { Pin::new_unchecked(boxed) }
+    }
+}
+
+#[stable(feature = "rust1", since = "1.0.0")]
+unsafe impl<#[may_dangle] T: ?Sized, A: Allocator> Drop for Box<T, A> {
+    fn drop(&mut self) {
+        // FIXME: Do nothing, drop is currently performed by compiler.
+    }
+}
+
+#[cfg(not(no_global_oom_handling))]
+#[stable(feature = "rust1", since = "1.0.0")]
+impl<T: Default> Default for Box<T> {
+    /// Creates a `Box<T>`, with the `Default` value for T.
+    fn default() -> Self {
+        box T::default()
+    }
+}
+
+#[cfg(not(no_global_oom_handling))]
+#[stable(feature = "rust1", since = "1.0.0")]
+#[rustc_const_unstable(feature = "const_default_impls", issue = "87864")]
+impl<T> const Default for Box<[T]> {
+    fn default() -> Self {
+        let ptr: Unique<[T]> = Unique::<[T; 0]>::dangling();
+        Box(ptr, Global)
+    }
+}
+
+#[cfg(not(no_global_oom_handling))]
+#[stable(feature = "default_box_extra", since = "1.17.0")]
+#[rustc_const_unstable(feature = "const_default_impls", issue = "87864")]
+impl const Default for Box<str> {
+    fn default() -> Self {
+        // SAFETY: This is the same as `Unique::cast<U>` but with an unsized `U = str`.
+        let ptr: Unique<str> = unsafe {
+            let bytes: Unique<[u8]> = Unique::<[u8; 0]>::dangling();
+            Unique::new_unchecked(bytes.as_ptr() as *mut str)
+        };
+        Box(ptr, Global)
+    }
+}
+
+#[cfg(not(no_global_oom_handling))]
+#[stable(feature = "rust1", since = "1.0.0")]
+impl<T: Clone, A: Allocator + Clone> Clone for Box<T, A> {
+    /// Returns a new box with a `clone()` of this box's contents.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let x = Box::new(5);
+    /// let y = x.clone();
+    ///
+    /// // The value is the same
+    /// assert_eq!(x, y);
+    ///
+    /// // But they are unique objects
+    /// assert_ne!(&*x as *const i32, &*y as *const i32);
+    /// ```
+    #[inline]
+    fn clone(&self) -> Self {
+        // Pre-allocate memory to allow writing the cloned value directly.
+        let mut boxed = Self::new_uninit_in(self.1.clone());
+        unsafe {
+            (**self).write_clone_into_raw(boxed.as_mut_ptr());
+            boxed.assume_init()
+        }
+    }
+
+    /// Copies `source`'s contents into `self` without creating a new allocation.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let x = Box::new(5);
+    /// let mut y = Box::new(10);
+    /// let yp: *const i32 = &*y;
+    ///
+    /// y.clone_from(&x);
+    ///
+    /// // The value is the same
+    /// assert_eq!(x, y);
+    ///
+    /// // And no allocation occurred
+    /// assert_eq!(yp, &*y);
+    /// ```
+    #[inline]
+    fn clone_from(&mut self, source: &Self) {
+        (**self).clone_from(&(**source));
+    }
+}
+
+#[cfg(not(no_global_oom_handling))]
+#[stable(feature = "box_slice_clone", since = "1.3.0")]
+impl Clone for Box<str> {
+    fn clone(&self) -> Self {
+        // this makes a copy of the data
+        let buf: Box<[u8]> = self.as_bytes().into();
+        unsafe { from_boxed_utf8_unchecked(buf) }
+    }
+}
+
+#[stable(feature = "rust1", since = "1.0.0")]
+impl<T: ?Sized + PartialEq, A: Allocator> PartialEq for Box<T, A> {
+    #[inline]
+    fn eq(&self, other: &Self) -> bool {
+        PartialEq::eq(&**self, &**other)
+    }
+    #[inline]
+    fn ne(&self, other: &Self) -> bool {
+        PartialEq::ne(&**self, &**other)
+    }
+}
+#[stable(feature = "rust1", since = "1.0.0")]
+impl<T: ?Sized + PartialOrd, A: Allocator> PartialOrd for Box<T, A> {
+    #[inline]
+    fn partial_cmp(&self, other: &Self) -> Option<Ordering> {
+        PartialOrd::partial_cmp(&**self, &**other)
+    }
+    #[inline]
+    fn lt(&self, other: &Self) -> bool {
+        PartialOrd::lt(&**self, &**other)
+    }
+    #[inline]
+    fn le(&self, other: &Self) -> bool {
+        PartialOrd::le(&**self, &**other)
+    }
+    #[inline]
+    fn ge(&self, other: &Self) -> bool {
+        PartialOrd::ge(&**self, &**other)
+    }
+    #[inline]
+    fn gt(&self, other: &Self) -> bool {
+        PartialOrd::gt(&**self, &**other)
+    }
+}
+#[stable(feature = "rust1", since = "1.0.0")]
+impl<T: ?Sized + Ord, A: Allocator> Ord for Box<T, A> {
+    #[inline]
+    fn cmp(&self, other: &Self) -> Ordering {
+        Ord::cmp(&**self, &**other)
+    }
+}
+#[stable(feature = "rust1", since = "1.0.0")]
+impl<T: ?Sized + Eq, A: Allocator> Eq for Box<T, A> {}
+
+#[stable(feature = "rust1", since = "1.0.0")]
+impl<T: ?Sized + Hash, A: Allocator> Hash for Box<T, A> {
+    fn hash<H: Hasher>(&self, state: &mut H) {
+        (**self).hash(state);
+    }
+}
+
+#[stable(feature = "indirect_hasher_impl", since = "1.22.0")]
+impl<T: ?Sized + Hasher, A: Allocator> Hasher for Box<T, A> {
+    fn finish(&self) -> u64 {
+        (**self).finish()
+    }
+    fn write(&mut self, bytes: &[u8]) {
+        (**self).write(bytes)
+    }
+    fn write_u8(&mut self, i: u8) {
+        (**self).write_u8(i)
+    }
+    fn write_u16(&mut self, i: u16) {
+        (**self).write_u16(i)
+    }
+    fn write_u32(&mut self, i: u32) {
+        (**self).write_u32(i)
+    }
+    fn write_u64(&mut self, i: u64) {
+        (**self).write_u64(i)
+    }
+    fn write_u128(&mut self, i: u128) {
+        (**self).write_u128(i)
+    }
+    fn write_usize(&mut self, i: usize) {
+        (**self).write_usize(i)
+    }
+    fn write_i8(&mut self, i: i8) {
+        (**self).write_i8(i)
+    }
+    fn write_i16(&mut self, i: i16) {
+        (**self).write_i16(i)
+    }
+    fn write_i32(&mut self, i: i32) {
+        (**self).write_i32(i)
+    }
+    fn write_i64(&mut self, i: i64) {
+        (**self).write_i64(i)
+    }
+    fn write_i128(&mut self, i: i128) {
+        (**self).write_i128(i)
+    }
+    fn write_isize(&mut self, i: isize) {
+        (**self).write_isize(i)
+    }
+    fn write_length_prefix(&mut self, len: usize) {
+        (**self).write_length_prefix(len)
+    }
+    fn write_str(&mut self, s: &str) {
+        (**self).write_str(s)
+    }
+}
+
+#[cfg(not(no_global_oom_handling))]
+#[stable(feature = "from_for_ptrs", since = "1.6.0")]
+impl<T> From<T> for Box<T> {
+    /// Converts a `T` into a `Box<T>`
+    ///
+    /// The conversion allocates on the heap and moves `t`
+    /// from the stack into it.
+    ///
+    /// # Examples
+    ///
+    /// ```rust
+    /// let x = 5;
+    /// let boxed = Box::new(5);
+    ///
+    /// assert_eq!(Box::from(x), boxed);
+    /// ```
+    fn from(t: T) -> Self {
+        Box::new(t)
+    }
+}
+
+#[stable(feature = "pin", since = "1.33.0")]
+#[rustc_const_unstable(feature = "const_box", issue = "92521")]
+impl<T: ?Sized, A: Allocator> const From<Box<T, A>> for Pin<Box<T, A>>
+where
+    A: 'static,
+{
+    /// Converts a `Box<T>` into a `Pin<Box<T>>`
+    ///
+    /// This conversion does not allocate on the heap and happens in place.
+    fn from(boxed: Box<T, A>) -> Self {
+        Box::into_pin(boxed)
+    }
+}
+
+#[cfg(not(no_global_oom_handling))]
+#[stable(feature = "box_from_slice", since = "1.17.0")]
+impl<T: Copy> From<&[T]> for Box<[T]> {
+    /// Converts a `&[T]` into a `Box<[T]>`
+    ///
+    /// This conversion allocates on the heap
+    /// and performs a copy of `slice`.
+    ///
+    /// # Examples
+    /// ```rust
+    /// // create a &[u8] which will be used to create a Box<[u8]>
+    /// let slice: &[u8] = &[104, 101, 108, 108, 111];
+    /// let boxed_slice: Box<[u8]> = Box::from(slice);
+    ///
+    /// println!("{boxed_slice:?}");
+    /// ```
+    fn from(slice: &[T]) -> Box<[T]> {
+        let len = slice.len();
+        let buf = RawVec::with_capacity(len);
+        unsafe {
+            ptr::copy_nonoverlapping(slice.as_ptr(), buf.ptr(), len);
+            buf.into_box(slice.len()).assume_init()
+        }
+    }
+}
+
+#[cfg(not(no_global_oom_handling))]
+#[stable(feature = "box_from_cow", since = "1.45.0")]
+impl<T: Copy> From<Cow<'_, [T]>> for Box<[T]> {
+    /// Converts a `Cow<'_, [T]>` into a `Box<[T]>`
+    ///
+    /// When `cow` is the `Cow::Borrowed` variant, this
+    /// conversion allocates on the heap and copies the
+    /// underlying slice. Otherwise, it will try to reuse the owned
+    /// `Vec`'s allocation.
+    #[inline]
+    fn from(cow: Cow<'_, [T]>) -> Box<[T]> {
+        match cow {
+            Cow::Borrowed(slice) => Box::from(slice),
+            Cow::Owned(slice) => Box::from(slice),
+        }
+    }
+}
+
+#[cfg(not(no_global_oom_handling))]
+#[stable(feature = "box_from_slice", since = "1.17.0")]
+impl From<&str> for Box<str> {
+    /// Converts a `&str` into a `Box<str>`
+    ///
+    /// This conversion allocates on the heap
+    /// and performs a copy of `s`.
+    ///
+    /// # Examples
+    ///
+    /// ```rust
+    /// let boxed: Box<str> = Box::from("hello");
+    /// println!("{boxed}");
+    /// ```
+    #[inline]
+    fn from(s: &str) -> Box<str> {
+        unsafe { from_boxed_utf8_unchecked(Box::from(s.as_bytes())) }
+    }
+}
+
+#[cfg(not(no_global_oom_handling))]
+#[stable(feature = "box_from_cow", since = "1.45.0")]
+impl From<Cow<'_, str>> for Box<str> {
+    /// Converts a `Cow<'_, str>` into a `Box<str>`
+    ///
+    /// When `cow` is the `Cow::Borrowed` variant, this
+    /// conversion allocates on the heap and copies the
+    /// underlying `str`. Otherwise, it will try to reuse the owned
+    /// `String`'s allocation.
+    ///
+    /// # Examples
+    ///
+    /// ```rust
+    /// use std::borrow::Cow;
+    ///
+    /// let unboxed = Cow::Borrowed("hello");
+    /// let boxed: Box<str> = Box::from(unboxed);
+    /// println!("{boxed}");
+    /// ```
+    ///
+    /// ```rust
+    /// # use std::borrow::Cow;
+    /// let unboxed = Cow::Owned("hello".to_string());
+    /// let boxed: Box<str> = Box::from(unboxed);
+    /// println!("{boxed}");
+    /// ```
+    #[inline]
+    fn from(cow: Cow<'_, str>) -> Box<str> {
+        match cow {
+            Cow::Borrowed(s) => Box::from(s),
+            Cow::Owned(s) => Box::from(s),
+        }
+    }
+}
+
+#[stable(feature = "boxed_str_conv", since = "1.19.0")]
+impl<A: Allocator> From<Box<str, A>> for Box<[u8], A> {
+    /// Converts a `Box<str>` into a `Box<[u8]>`
+    ///
+    /// This conversion does not allocate on the heap and happens in place.
+    ///
+    /// # Examples
+    /// ```rust
+    /// // create a Box<str> which will be used to create a Box<[u8]>
+    /// let boxed: Box<str> = Box::from("hello");
+    /// let boxed_str: Box<[u8]> = Box::from(boxed);
+    ///
+    /// // create a &[u8] which will be used to create a Box<[u8]>
+    /// let slice: &[u8] = &[104, 101, 108, 108, 111];
+    /// let boxed_slice = Box::from(slice);
+    ///
+    /// assert_eq!(boxed_slice, boxed_str);
+    /// ```
+    #[inline]
+    fn from(s: Box<str, A>) -> Self {
+        let (raw, alloc) = Box::into_raw_with_allocator(s);
+        unsafe { Box::from_raw_in(raw as *mut [u8], alloc) }
+    }
+}
+
+#[cfg(not(no_global_oom_handling))]
+#[stable(feature = "box_from_array", since = "1.45.0")]
+impl<T, const N: usize> From<[T; N]> for Box<[T]> {
+    /// Converts a `[T; N]` into a `Box<[T]>`
+    ///
+    /// This conversion moves the array to newly heap-allocated memory.
+    ///
+    /// # Examples
+    ///
+    /// ```rust
+    /// let boxed: Box<[u8]> = Box::from([4, 2]);
+    /// println!("{boxed:?}");
+    /// ```
+    fn from(array: [T; N]) -> Box<[T]> {
+        box array
+    }
+}
+
+#[stable(feature = "boxed_slice_try_from", since = "1.43.0")]
+impl<T, const N: usize> TryFrom<Box<[T]>> for Box<[T; N]> {
+    type Error = Box<[T]>;
+
+    /// Attempts to convert a `Box<[T]>` into a `Box<[T; N]>`.
+    ///
+    /// The conversion occurs in-place and does not require a
+    /// new memory allocation.
+    ///
+    /// # Errors
+    ///
+    /// Returns the old `Box<[T]>` in the `Err` variant if
+    /// `boxed_slice.len()` does not equal `N`.
+    fn try_from(boxed_slice: Box<[T]>) -> Result<Self, Self::Error> {
+        if boxed_slice.len() == N {
+            Ok(unsafe { Box::from_raw(Box::into_raw(boxed_slice) as *mut [T; N]) })
+        } else {
+            Err(boxed_slice)
+        }
+    }
+}
+
+impl<A: Allocator> Box<dyn Any, A> {
+    /// Attempt to downcast the box to a concrete type.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use std::any::Any;
+    ///
+    /// fn print_if_string(value: Box<dyn Any>) {
+    ///     if let Ok(string) = value.downcast::<String>() {
+    ///         println!("String ({}): {}", string.len(), string);
+    ///     }
+    /// }
+    ///
+    /// let my_string = "Hello World".to_string();
+    /// print_if_string(Box::new(my_string));
+    /// print_if_string(Box::new(0i8));
+    /// ```
+    #[inline]
+    #[stable(feature = "rust1", since = "1.0.0")]
+    pub fn downcast<T: Any>(self) -> Result<Box<T, A>, Self> {
+        if self.is::<T>() { unsafe { Ok(self.downcast_unchecked::<T>()) } } else { Err(self) }
+    }
+
+    /// Downcasts the box to a concrete type.
+    ///
+    /// For a safe alternative see [`downcast`].
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// #![feature(downcast_unchecked)]
+    ///
+    /// use std::any::Any;
+    ///
+    /// let x: Box<dyn Any> = Box::new(1_usize);
+    ///
+    /// unsafe {
+    ///     assert_eq!(*x.downcast_unchecked::<usize>(), 1);
+    /// }
+    /// ```
+    ///
+    /// # Safety
+    ///
+    /// The contained value must be of type `T`. Calling this method
+    /// with the incorrect type is *undefined behavior*.
+    ///
+    /// [`downcast`]: Self::downcast
+    #[inline]
+    #[unstable(feature = "downcast_unchecked", issue = "90850")]
+    pub unsafe fn downcast_unchecked<T: Any>(self) -> Box<T, A> {
+        debug_assert!(self.is::<T>());
+        unsafe {
+            let (raw, alloc): (*mut dyn Any, _) = Box::into_raw_with_allocator(self);
+            Box::from_raw_in(raw as *mut T, alloc)
+        }
+    }
+}
+
+impl<A: Allocator> Box<dyn Any + Send, A> {
+    /// Attempt to downcast the box to a concrete type.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use std::any::Any;
+    ///
+    /// fn print_if_string(value: Box<dyn Any + Send>) {
+    ///     if let Ok(string) = value.downcast::<String>() {
+    ///         println!("String ({}): {}", string.len(), string);
+    ///     }
+    /// }
+    ///
+    /// let my_string = "Hello World".to_string();
+    /// print_if_string(Box::new(my_string));
+    /// print_if_string(Box::new(0i8));
+    /// ```
+    #[inline]
+    #[stable(feature = "rust1", since = "1.0.0")]
+    pub fn downcast<T: Any>(self) -> Result<Box<T, A>, Self> {
+        if self.is::<T>() { unsafe { Ok(self.downcast_unchecked::<T>()) } } else { Err(self) }
+    }
+
+    /// Downcasts the box to a concrete type.
+    ///
+    /// For a safe alternative see [`downcast`].
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// #![feature(downcast_unchecked)]
+    ///
+    /// use std::any::Any;
+    ///
+    /// let x: Box<dyn Any + Send> = Box::new(1_usize);
+    ///
+    /// unsafe {
+    ///     assert_eq!(*x.downcast_unchecked::<usize>(), 1);
+    /// }
+    /// ```
+    ///
+    /// # Safety
+    ///
+    /// The contained value must be of type `T`. Calling this method
+    /// with the incorrect type is *undefined behavior*.
+    ///
+    /// [`downcast`]: Self::downcast
+    #[inline]
+    #[unstable(feature = "downcast_unchecked", issue = "90850")]
+    pub unsafe fn downcast_unchecked<T: Any>(self) -> Box<T, A> {
+        debug_assert!(self.is::<T>());
+        unsafe {
+            let (raw, alloc): (*mut (dyn Any + Send), _) = Box::into_raw_with_allocator(self);
+            Box::from_raw_in(raw as *mut T, alloc)
+        }
+    }
+}
+
+impl<A: Allocator> Box<dyn Any + Send + Sync, A> {
+    /// Attempt to downcast the box to a concrete type.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use std::any::Any;
+    ///
+    /// fn print_if_string(value: Box<dyn Any + Send + Sync>) {
+    ///     if let Ok(string) = value.downcast::<String>() {
+    ///         println!("String ({}): {}", string.len(), string);
+    ///     }
+    /// }
+    ///
+    /// let my_string = "Hello World".to_string();
+    /// print_if_string(Box::new(my_string));
+    /// print_if_string(Box::new(0i8));
+    /// ```
+    #[inline]
+    #[stable(feature = "box_send_sync_any_downcast", since = "1.51.0")]
+    pub fn downcast<T: Any>(self) -> Result<Box<T, A>, Self> {
+        if self.is::<T>() { unsafe { Ok(self.downcast_unchecked::<T>()) } } else { Err(self) }
+    }
+
+    /// Downcasts the box to a concrete type.
+    ///
+    /// For a safe alternative see [`downcast`].
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// #![feature(downcast_unchecked)]
+    ///
+    /// use std::any::Any;
+    ///
+    /// let x: Box<dyn Any + Send + Sync> = Box::new(1_usize);
+    ///
+    /// unsafe {
+    ///     assert_eq!(*x.downcast_unchecked::<usize>(), 1);
+    /// }
+    /// ```
+    ///
+    /// # Safety
+    ///
+    /// The contained value must be of type `T`. Calling this method
+    /// with the incorrect type is *undefined behavior*.
+    ///
+    /// [`downcast`]: Self::downcast
+    #[inline]
+    #[unstable(feature = "downcast_unchecked", issue = "90850")]
+    pub unsafe fn downcast_unchecked<T: Any>(self) -> Box<T, A> {
+        debug_assert!(self.is::<T>());
+        unsafe {
+            let (raw, alloc): (*mut (dyn Any + Send + Sync), _) =
+                Box::into_raw_with_allocator(self);
+            Box::from_raw_in(raw as *mut T, alloc)
+        }
+    }
+}
+
+#[stable(feature = "rust1", since = "1.0.0")]
+impl<T: fmt::Display + ?Sized, A: Allocator> fmt::Display for Box<T, A> {
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
+        fmt::Display::fmt(&**self, f)
+    }
+}
+
+#[stable(feature = "rust1", since = "1.0.0")]
+impl<T: fmt::Debug + ?Sized, A: Allocator> fmt::Debug for Box<T, A> {
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
+        fmt::Debug::fmt(&**self, f)
+    }
+}
+
+#[stable(feature = "rust1", since = "1.0.0")]
+impl<T: ?Sized, A: Allocator> fmt::Pointer for Box<T, A> {
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
+        // It's not possible to extract the inner Uniq directly from the Box,
+        // instead we cast it to a *const which aliases the Unique
+        let ptr: *const T = &**self;
+        fmt::Pointer::fmt(&ptr, f)
+    }
+}
+
+#[stable(feature = "rust1", since = "1.0.0")]
+#[rustc_const_unstable(feature = "const_box", issue = "92521")]
+impl<T: ?Sized, A: Allocator> const Deref for Box<T, A> {
+    type Target = T;
+
+    fn deref(&self) -> &T {
+        &**self
+    }
+}
+
+#[stable(feature = "rust1", since = "1.0.0")]
+#[rustc_const_unstable(feature = "const_box", issue = "92521")]
+impl<T: ?Sized, A: Allocator> const DerefMut for Box<T, A> {
+    fn deref_mut(&mut self) -> &mut T {
+        &mut **self
+    }
+}
+
+#[unstable(feature = "receiver_trait", issue = "none")]
+impl<T: ?Sized, A: Allocator> Receiver for Box<T, A> {}
+
+#[stable(feature = "rust1", since = "1.0.0")]
+impl<I: Iterator + ?Sized, A: Allocator> Iterator for Box<I, A> {
+    type Item = I::Item;
+    fn next(&mut self) -> Option<I::Item> {
+        (**self).next()
+    }
+    fn size_hint(&self) -> (usize, Option<usize>) {
+        (**self).size_hint()
+    }
+    fn nth(&mut self, n: usize) -> Option<I::Item> {
+        (**self).nth(n)
+    }
+    fn last(self) -> Option<I::Item> {
+        BoxIter::last(self)
+    }
+}
+
+trait BoxIter {
+    type Item;
+    fn last(self) -> Option<Self::Item>;
+}
+
+impl<I: Iterator + ?Sized, A: Allocator> BoxIter for Box<I, A> {
+    type Item = I::Item;
+    default fn last(self) -> Option<I::Item> {
+        #[inline]
+        fn some<T>(_: Option<T>, x: T) -> Option<T> {
+            Some(x)
+        }
+
+        self.fold(None, some)
+    }
+}
+
+/// Specialization for sized `I`s that uses `I`s implementation of `last()`
+/// instead of the default.
+#[stable(feature = "rust1", since = "1.0.0")]
+impl<I: Iterator, A: Allocator> BoxIter for Box<I, A> {
+    fn last(self) -> Option<I::Item> {
+        (*self).last()
+    }
+}
+
+#[stable(feature = "rust1", since = "1.0.0")]
+impl<I: DoubleEndedIterator + ?Sized, A: Allocator> DoubleEndedIterator for Box<I, A> {
+    fn next_back(&mut self) -> Option<I::Item> {
+        (**self).next_back()
+    }
+    fn nth_back(&mut self, n: usize) -> Option<I::Item> {
+        (**self).nth_back(n)
+    }
+}
+#[stable(feature = "rust1", since = "1.0.0")]
+impl<I: ExactSizeIterator + ?Sized, A: Allocator> ExactSizeIterator for Box<I, A> {
+    fn len(&self) -> usize {
+        (**self).len()
+    }
+    fn is_empty(&self) -> bool {
+        (**self).is_empty()
+    }
+}
+
+#[stable(feature = "fused", since = "1.26.0")]
+impl<I: FusedIterator + ?Sized, A: Allocator> FusedIterator for Box<I, A> {}
+
+#[stable(feature = "boxed_closure_impls", since = "1.35.0")]
+impl<Args, F: FnOnce<Args> + ?Sized, A: Allocator> FnOnce<Args> for Box<F, A> {
+    type Output = <F as FnOnce<Args>>::Output;
+
+    extern "rust-call" fn call_once(self, args: Args) -> Self::Output {
+        <F as FnOnce<Args>>::call_once(*self, args)
+    }
+}
+
+#[stable(feature = "boxed_closure_impls", since = "1.35.0")]
+impl<Args, F: FnMut<Args> + ?Sized, A: Allocator> FnMut<Args> for Box<F, A> {
+    extern "rust-call" fn call_mut(&mut self, args: Args) -> Self::Output {
+        <F as FnMut<Args>>::call_mut(self, args)
+    }
+}
+
+#[stable(feature = "boxed_closure_impls", since = "1.35.0")]
+impl<Args, F: Fn<Args> + ?Sized, A: Allocator> Fn<Args> for Box<F, A> {
+    extern "rust-call" fn call(&self, args: Args) -> Self::Output {
+        <F as Fn<Args>>::call(self, args)
+    }
+}
+
+#[unstable(feature = "coerce_unsized", issue = "27732")]
+impl<T: ?Sized + Unsize<U>, U: ?Sized, A: Allocator> CoerceUnsized<Box<U, A>> for Box<T, A> {}
+
+#[unstable(feature = "dispatch_from_dyn", issue = "none")]
+impl<T: ?Sized + Unsize<U>, U: ?Sized> DispatchFromDyn<Box<U>> for Box<T, Global> {}
+
+#[cfg(not(no_global_oom_handling))]
+#[stable(feature = "boxed_slice_from_iter", since = "1.32.0")]
+impl<I> FromIterator<I> for Box<[I]> {
+    fn from_iter<T: IntoIterator<Item = I>>(iter: T) -> Self {
+        iter.into_iter().collect::<Vec<_>>().into_boxed_slice()
+    }
+}
+
+#[cfg(not(no_global_oom_handling))]
+#[stable(feature = "box_slice_clone", since = "1.3.0")]
+impl<T: Clone, A: Allocator + Clone> Clone for Box<[T], A> {
+    fn clone(&self) -> Self {
+        let alloc = Box::allocator(self).clone();
+        self.to_vec_in(alloc).into_boxed_slice()
+    }
+
+    fn clone_from(&mut self, other: &Self) {
+        if self.len() == other.len() {
+            self.clone_from_slice(&other);
+        } else {
+            *self = other.clone();
+        }
+    }
+}
+
+#[stable(feature = "box_borrow", since = "1.1.0")]
+impl<T: ?Sized, A: Allocator> borrow::Borrow<T> for Box<T, A> {
+    fn borrow(&self) -> &T {
+        &**self
+    }
+}
+
+#[stable(feature = "box_borrow", since = "1.1.0")]
+impl<T: ?Sized, A: Allocator> borrow::BorrowMut<T> for Box<T, A> {
+    fn borrow_mut(&mut self) -> &mut T {
+        &mut **self
+    }
+}
+
+#[stable(since = "1.5.0", feature = "smart_ptr_as_ref")]
+impl<T: ?Sized, A: Allocator> AsRef<T> for Box<T, A> {
+    fn as_ref(&self) -> &T {
+        &**self
+    }
+}
+
+#[stable(since = "1.5.0", feature = "smart_ptr_as_ref")]
+impl<T: ?Sized, A: Allocator> AsMut<T> for Box<T, A> {
+    fn as_mut(&mut self) -> &mut T {
+        &mut **self
+    }
+}
+
+/* Nota bene
+ *
+ *  We could have chosen not to add this impl, and instead have written a
+ *  function of Pin<Box<T>> to Pin<T>. Such a function would not be sound,
+ *  because Box<T> implements Unpin even when T does not, as a result of
+ *  this impl.
+ *
+ *  We chose this API instead of the alternative for a few reasons:
+ *      - Logically, it is helpful to understand pinning in regard to the
+ *        memory region being pointed to. For this reason none of the
+ *        standard library pointer types support projecting through a pin
+ *        (Box<T> is the only pointer type in std for which this would be
+ *        safe.)
+ *      - It is in practice very useful to have Box<T> be unconditionally
+ *        Unpin because of trait objects, for which the structural auto
+ *        trait functionality does not apply (e.g., Box<dyn Foo> would
+ *        otherwise not be Unpin).
+ *
+ *  Another type with the same semantics as Box but only a conditional
+ *  implementation of `Unpin` (where `T: Unpin`) would be valid/safe, and
+ *  could have a method to project a Pin<T> from it.
+ */
+#[stable(feature = "pin", since = "1.33.0")]
+#[rustc_const_unstable(feature = "const_box", issue = "92521")]
+impl<T: ?Sized, A: Allocator> const Unpin for Box<T, A> where A: 'static {}
+
+#[unstable(feature = "generator_trait", issue = "43122")]
+impl<G: ?Sized + Generator<R> + Unpin, R, A: Allocator> Generator<R> for Box<G, A>
+where
+    A: 'static,
+{
+    type Yield = G::Yield;
+    type Return = G::Return;
+
+    fn resume(mut self: Pin<&mut Self>, arg: R) -> GeneratorState<Self::Yield, Self::Return> {
+        G::resume(Pin::new(&mut *self), arg)
+    }
+}
+
+#[unstable(feature = "generator_trait", issue = "43122")]
+impl<G: ?Sized + Generator<R>, R, A: Allocator> Generator<R> for Pin<Box<G, A>>
+where
+    A: 'static,
+{
+    type Yield = G::Yield;
+    type Return = G::Return;
+
+    fn resume(mut self: Pin<&mut Self>, arg: R) -> GeneratorState<Self::Yield, Self::Return> {
+        G::resume((*self).as_mut(), arg)
+    }
+}
+
+#[stable(feature = "futures_api", since = "1.36.0")]
+impl<F: ?Sized + Future + Unpin, A: Allocator> Future for Box<F, A>
+where
+    A: 'static,
+{
+    type Output = F::Output;
+
+    fn poll(mut self: Pin<&mut Self>, cx: &mut Context<'_>) -> Poll<Self::Output> {
+        F::poll(Pin::new(&mut *self), cx)
+    }
+}
+
+#[unstable(feature = "async_iterator", issue = "79024")]
+impl<S: ?Sized + AsyncIterator + Unpin> AsyncIterator for Box<S> {
+    type Item = S::Item;
+
+    fn poll_next(mut self: Pin<&mut Self>, cx: &mut Context<'_>) -> Poll<Option<Self::Item>> {
+        Pin::new(&mut **self).poll_next(cx)
+    }
+
+    fn size_hint(&self) -> (usize, Option<usize>) {
+        (**self).size_hint()
+    }
+}
diff --git a/rust/alloc/collections/mod.rs b/rust/alloc/collections/mod.rs
new file mode 100644
index 000000000000..628a5b155673
--- /dev/null
+++ b/rust/alloc/collections/mod.rs
@@ -0,0 +1,154 @@
+//! Collection types.
+
+#![stable(feature = "rust1", since = "1.0.0")]
+
+#[cfg(not(no_global_oom_handling))]
+pub mod binary_heap;
+#[cfg(not(no_global_oom_handling))]
+mod btree;
+#[cfg(not(no_global_oom_handling))]
+pub mod linked_list;
+#[cfg(not(no_global_oom_handling))]
+pub mod vec_deque;
+
+#[cfg(not(no_global_oom_handling))]
+#[stable(feature = "rust1", since = "1.0.0")]
+pub mod btree_map {
+    //! An ordered map based on a B-Tree.
+    #[stable(feature = "rust1", since = "1.0.0")]
+    pub use super::btree::map::*;
+}
+
+#[cfg(not(no_global_oom_handling))]
+#[stable(feature = "rust1", since = "1.0.0")]
+pub mod btree_set {
+    //! An ordered set based on a B-Tree.
+    #[stable(feature = "rust1", since = "1.0.0")]
+    pub use super::btree::set::*;
+}
+
+#[cfg(not(no_global_oom_handling))]
+#[stable(feature = "rust1", since = "1.0.0")]
+#[doc(no_inline)]
+pub use binary_heap::BinaryHeap;
+
+#[cfg(not(no_global_oom_handling))]
+#[stable(feature = "rust1", since = "1.0.0")]
+#[doc(no_inline)]
+pub use btree_map::BTreeMap;
+
+#[cfg(not(no_global_oom_handling))]
+#[stable(feature = "rust1", since = "1.0.0")]
+#[doc(no_inline)]
+pub use btree_set::BTreeSet;
+
+#[cfg(not(no_global_oom_handling))]
+#[stable(feature = "rust1", since = "1.0.0")]
+#[doc(no_inline)]
+pub use linked_list::LinkedList;
+
+#[cfg(not(no_global_oom_handling))]
+#[stable(feature = "rust1", since = "1.0.0")]
+#[doc(no_inline)]
+pub use vec_deque::VecDeque;
+
+use crate::alloc::{Layout, LayoutError};
+use core::fmt::Display;
+
+/// The error type for `try_reserve` methods.
+#[derive(Clone, PartialEq, Eq, Debug)]
+#[stable(feature = "try_reserve", since = "1.57.0")]
+pub struct TryReserveError {
+    kind: TryReserveErrorKind,
+}
+
+impl TryReserveError {
+    /// Details about the allocation that caused the error
+    #[inline]
+    #[must_use]
+    #[unstable(
+        feature = "try_reserve_kind",
+        reason = "Uncertain how much info should be exposed",
+        issue = "48043"
+    )]
+    pub fn kind(&self) -> TryReserveErrorKind {
+        self.kind.clone()
+    }
+}
+
+/// Details of the allocation that caused a `TryReserveError`
+#[derive(Clone, PartialEq, Eq, Debug)]
+#[unstable(
+    feature = "try_reserve_kind",
+    reason = "Uncertain how much info should be exposed",
+    issue = "48043"
+)]
+pub enum TryReserveErrorKind {
+    /// Error due to the computed capacity exceeding the collection's maximum
+    /// (usually `isize::MAX` bytes).
+    CapacityOverflow,
+
+    /// The memory allocator returned an error
+    AllocError {
+        /// The layout of allocation request that failed
+        layout: Layout,
+
+        #[doc(hidden)]
+        #[unstable(
+            feature = "container_error_extra",
+            issue = "none",
+            reason = "\
+            Enable exposing the allocator’s custom error value \
+            if an associated type is added in the future: \
+            https://github.com/rust-lang/wg-allocators/issues/23"
+        )]
+        non_exhaustive: (),
+    },
+}
+
+#[unstable(
+    feature = "try_reserve_kind",
+    reason = "Uncertain how much info should be exposed",
+    issue = "48043"
+)]
+impl From<TryReserveErrorKind> for TryReserveError {
+    #[inline]
+    fn from(kind: TryReserveErrorKind) -> Self {
+        Self { kind }
+    }
+}
+
+#[unstable(feature = "try_reserve_kind", reason = "new API", issue = "48043")]
+impl From<LayoutError> for TryReserveErrorKind {
+    /// Always evaluates to [`TryReserveErrorKind::CapacityOverflow`].
+    #[inline]
+    fn from(_: LayoutError) -> Self {
+        TryReserveErrorKind::CapacityOverflow
+    }
+}
+
+#[stable(feature = "try_reserve", since = "1.57.0")]
+impl Display for TryReserveError {
+    fn fmt(
+        &self,
+        fmt: &mut core::fmt::Formatter<'_>,
+    ) -> core::result::Result<(), core::fmt::Error> {
+        fmt.write_str("memory allocation failed")?;
+        let reason = match self.kind {
+            TryReserveErrorKind::CapacityOverflow => {
+                " because the computed capacity exceeded the collection's maximum"
+            }
+            TryReserveErrorKind::AllocError { .. } => {
+                " because the memory allocator returned a error"
+            }
+        };
+        fmt.write_str(reason)
+    }
+}
+
+/// An intermediate trait for specialization of `Extend`.
+#[doc(hidden)]
+trait SpecExtend<I: IntoIterator> {
+    /// Extends `self` with the contents of the given iterator.
+    fn spec_extend(&mut self, iter: I);
+}
diff --git a/rust/alloc/lib.rs b/rust/alloc/lib.rs
new file mode 100644
index 000000000000..fd21b3671182
--- /dev/null
+++ b/rust/alloc/lib.rs
@@ -0,0 +1,236 @@
+//! # The Rust core allocation and collections library
+//!
+//! This library provides smart pointers and collections for managing
+//! heap-allocated values.
+//!
+//! This library, like libcore, normally doesn’t need to be used directly
+//! since its contents are re-exported in the [`std` crate](../std/index.html).
+//! Crates that use the `#![no_std]` attribute however will typically
+//! not depend on `std`, so they’d use this crate instead.
+//!
+//! ## Boxed values
+//!
+//! The [`Box`] type is a smart pointer type. There can only be one owner of a
+//! [`Box`], and the owner can decide to mutate the contents, which live on the
+//! heap.
+//!
+//! This type can be sent among threads efficiently as the size of a `Box` value
+//! is the same as that of a pointer. Tree-like data structures are often built
+//! with boxes because each node often has only one owner, the parent.
+//!
+//! ## Reference counted pointers
+//!
+//! The [`Rc`] type is a non-threadsafe reference-counted pointer type intended
+//! for sharing memory within a thread. An [`Rc`] pointer wraps a type, `T`, and
+//! only allows access to `&T`, a shared reference.
+//!
+//! This type is useful when inherited mutability (such as using [`Box`]) is too
+//! constraining for an application, and is often paired with the [`Cell`] or
+//! [`RefCell`] types in order to allow mutation.
+//!
+//! ## Atomically reference counted pointers
+//!
+//! The [`Arc`] type is the threadsafe equivalent of the [`Rc`] type. It
+//! provides all the same functionality of [`Rc`], except it requires that the
+//! contained type `T` is shareable. Additionally, [`Arc<T>`][`Arc`] is itself
+//! sendable while [`Rc<T>`][`Rc`] is not.
+//!
+//! This type allows for shared access to the contained data, and is often
+//! paired with synchronization primitives such as mutexes to allow mutation of
+//! shared resources.
+//!
+//! ## Collections
+//!
+//! Implementations of the most common general purpose data structures are
+//! defined in this library. They are re-exported through the
+//! [standard collections library](../std/collections/index.html).
+//!
+//! ## Heap interfaces
+//!
+//! The [`alloc`](alloc/index.html) module defines the low-level interface to the
+//! default global allocator. It is not compatible with the libc allocator API.
+//!
+//! [`Arc`]: sync
+//! [`Box`]: boxed
+//! [`Cell`]: core::cell
+//! [`Rc`]: rc
+//! [`RefCell`]: core::cell
+
+// To run liballoc tests without x.py without ending up with two copies of liballoc, Miri needs to be
+// able to "empty" this crate. See <https://github.com/rust-lang/miri-test-libstd/issues/4>.
+// rustc itself never sets the feature, so this line has no affect there.
+#![cfg(any(not(feature = "miri-test-libstd"), test, doctest))]
+#![allow(unused_attributes)]
+#![stable(feature = "alloc", since = "1.36.0")]
+#![doc(
+    html_playground_url = "https://play.rust-lang.org/",
+    issue_tracker_base_url = "https://github.com/rust-lang/rust/issues/",
+    test(no_crate_inject, attr(allow(unused_variables), deny(warnings)))
+)]
+#![doc(cfg_hide(
+    not(test),
+    not(any(test, bootstrap)),
+    any(not(feature = "miri-test-libstd"), test, doctest),
+    no_global_oom_handling,
+    not(no_global_oom_handling),
+    target_has_atomic = "ptr"
+))]
+#![no_std]
+#![needs_allocator]
+//
+// Lints:
+#![deny(unsafe_op_in_unsafe_fn)]
+#![warn(deprecated_in_future)]
+#![warn(missing_debug_implementations)]
+#![warn(missing_docs)]
+#![allow(explicit_outlives_requirements)]
+//
+// Library features:
+#![cfg_attr(not(no_global_oom_handling), feature(alloc_c_string))]
+#![feature(alloc_layout_extra)]
+#![feature(allocator_api)]
+#![feature(array_chunks)]
+#![feature(array_methods)]
+#![feature(array_windows)]
+#![feature(assert_matches)]
+#![feature(async_iterator)]
+#![feature(coerce_unsized)]
+#![cfg_attr(not(no_global_oom_handling), feature(const_alloc_error))]
+#![feature(const_box)]
+#![cfg_attr(not(no_global_oom_handling), feature(const_btree_new))]
+#![feature(const_cow_is_borrowed)]
+#![feature(const_convert)]
+#![feature(const_size_of_val)]
+#![feature(const_align_of_val)]
+#![feature(const_ptr_read)]
+#![feature(const_maybe_uninit_write)]
+#![feature(const_maybe_uninit_as_mut_ptr)]
+#![feature(const_refs_to_cell)]
+#![feature(core_c_str)]
+#![feature(core_intrinsics)]
+#![feature(core_ffi_c)]
+#![feature(const_eval_select)]
+#![feature(const_pin)]
+#![feature(cstr_from_bytes_until_nul)]
+#![feature(dispatch_from_dyn)]
+#![feature(exact_size_is_empty)]
+#![feature(extend_one)]
+#![feature(fmt_internals)]
+#![feature(fn_traits)]
+#![feature(hasher_prefixfree_extras)]
+#![feature(inplace_iteration)]
+#![feature(iter_advance_by)]
+#![feature(layout_for_ptr)]
+#![feature(maybe_uninit_slice)]
+#![cfg_attr(test, feature(new_uninit))]
+#![feature(nonnull_slice_from_raw_parts)]
+#![feature(pattern)]
+#![feature(ptr_internals)]
+#![feature(ptr_metadata)]
+#![feature(ptr_sub_ptr)]
+#![feature(receiver_trait)]
+#![feature(set_ptr_value)]
+#![feature(slice_group_by)]
+#![feature(slice_ptr_get)]
+#![feature(slice_ptr_len)]
+#![feature(slice_range)]
+#![feature(str_internals)]
+#![feature(strict_provenance)]
+#![feature(trusted_len)]
+#![feature(trusted_random_access)]
+#![feature(try_trait_v2)]
+#![feature(unchecked_math)]
+#![feature(unicode_internals)]
+#![feature(unsize)]
+//
+// Language features:
+#![feature(allocator_internals)]
+#![feature(allow_internal_unstable)]
+#![feature(associated_type_bounds)]
+#![feature(box_syntax)]
+#![feature(cfg_sanitize)]
+#![feature(const_deref)]
+#![feature(const_mut_refs)]
+#![feature(const_ptr_write)]
+#![feature(const_precise_live_drops)]
+#![feature(const_trait_impl)]
+#![feature(const_try)]
+#![feature(dropck_eyepatch)]
+#![feature(exclusive_range_pattern)]
+#![feature(fundamental)]
+#![cfg_attr(not(test), feature(generator_trait))]
+#![feature(hashmap_internals)]
+#![feature(lang_items)]
+#![feature(let_else)]
+#![feature(min_specialization)]
+#![feature(negative_impls)]
+#![feature(never_type)]
+#![feature(nll)] // Not necessary, but here to test the `nll` feature.
+#![feature(rustc_allow_const_fn_unstable)]
+#![feature(rustc_attrs)]
+#![feature(slice_internals)]
+#![feature(staged_api)]
+#![cfg_attr(test, feature(test))]
+#![feature(unboxed_closures)]
+#![feature(unsized_fn_params)]
+#![feature(c_unwind)]
+//
+// Rustdoc features:
+#![feature(doc_cfg)]
+#![feature(doc_cfg_hide)]
+// Technically, this is a bug in rustdoc: rustdoc sees the documentation on `#[lang = slice_alloc]`
+// blocks is for `&[T]`, which also has documentation using this feature in `core`, and gets mad
+// that the feature-gate isn't enabled. Ideally, it wouldn't check for the feature gate for docs
+// from other crates, but since this can only appear for lang items, it doesn't seem worth fixing.
+#![feature(intra_doc_pointers)]
+
+// Allow testing this library
+#[cfg(test)]
+#[macro_use]
+extern crate std;
+#[cfg(test)]
+extern crate test;
+
+// Module with internal macros used by other modules (needs to be included before other modules).
+#[macro_use]
+mod macros;
+
+mod raw_vec;
+
+// Heaps provided for low-level allocation strategies
+
+pub mod alloc;
+
+// Primitive types using the heaps above
+
+// Need to conditionally define the mod from `boxed.rs` to avoid
+// duplicating the lang-items when building in test cfg; but also need
+// to allow code to have `use boxed::Box;` declarations.
+#[cfg(not(test))]
+pub mod boxed;
+#[cfg(test)]
+mod boxed {
+    pub use std::boxed::Box;
+}
+pub mod borrow;
+pub mod collections;
+#[cfg(not(no_global_oom_handling))]
+pub mod ffi;
+pub mod fmt;
+pub mod rc;
+pub mod slice;
+pub mod str;
+pub mod string;
+#[cfg(target_has_atomic = "ptr")]
+pub mod sync;
+#[cfg(all(not(no_global_oom_handling), target_has_atomic = "ptr"))]
+pub mod task;
+#[cfg(test)]
+mod tests;
+pub mod vec;
+
+#[doc(hidden)]
+#[unstable(feature = "liballoc_internals", issue = "none", reason = "implementation detail")]
+pub mod __export {
+    pub use core::format_args;
+}
diff --git a/rust/alloc/raw_vec.rs b/rust/alloc/raw_vec.rs
new file mode 100644
index 000000000000..4be5f6cf9ca5
--- /dev/null
+++ b/rust/alloc/raw_vec.rs
@@ -0,0 +1,518 @@
+#![unstable(feature = "raw_vec_internals", reason = "unstable const warnings", issue = "none")]
+
+use core::alloc::LayoutError;
+use core::cmp;
+use core::intrinsics;
+use core::mem::{self, ManuallyDrop, MaybeUninit};
+use core::ops::Drop;
+use core::ptr::{self, NonNull, Unique};
+use core::slice;
+
+#[cfg(not(no_global_oom_handling))]
+use crate::alloc::handle_alloc_error;
+use crate::alloc::{Allocator, Global, Layout};
+use crate::boxed::Box;
+use crate::collections::TryReserveError;
+use crate::collections::TryReserveErrorKind::*;
+
+#[cfg(test)]
+mod tests;
+
+#[cfg(not(no_global_oom_handling))]
+enum AllocInit {
+    /// The contents of the new memory are uninitialized.
+    Uninitialized,
+    /// The new memory is guaranteed to be zeroed.
+    Zeroed,
+}
+
+/// A low-level utility for more ergonomically allocating, reallocating, and deallocating
+/// a buffer of memory on the heap without having to worry about all the corner cases
+/// involved. This type is excellent for building your own data structures like Vec and VecDeque.
+/// In particular:
+///
+/// * Produces `Unique::dangling()` on zero-sized types.
+/// * Produces `Unique::dangling()` on zero-length allocations.
+/// * Avoids freeing `Unique::dangling()`.
+/// * Catches all overflows in capacity computations (promotes them to "capacity overflow" panics).
+/// * Guards against 32-bit systems allocating more than isize::MAX bytes.
+/// * Guards against overflowing your length.
+/// * Calls `handle_alloc_error` for fallible allocations.
+/// * Contains a `ptr::Unique` and thus endows the user with all related benefits.
+/// * Uses the excess returned from the allocator to use the largest available capacity.
+///
+/// This type does not in anyway inspect the memory that it manages. When dropped it *will*
+/// free its memory, but it *won't* try to drop its contents. It is up to the user of `RawVec`
+/// to handle the actual things *stored* inside of a `RawVec`.
+///
+/// Note that the excess of a zero-sized types is always infinite, so `capacity()` always returns
+/// `usize::MAX`. This means that you need to be careful when round-tripping this type with a
+/// `Box<[T]>`, since `capacity()` won't yield the length.
+#[allow(missing_debug_implementations)]
+pub(crate) struct RawVec<T, A: Allocator = Global> {
+    ptr: Unique<T>,
+    cap: usize,
+    alloc: A,
+}
+
+impl<T> RawVec<T, Global> {
+    /// HACK(Centril): This exists because stable `const fn` can only call stable `const fn`, so
+    /// they cannot call `Self::new()`.
+    ///
+    /// If you change `RawVec<T>::new` or dependencies, please take care to not introduce anything
+    /// that would truly const-call something unstable.
+    pub const NEW: Self = Self::new();
+
+    /// Creates the biggest possible `RawVec` (on the system heap)
+    /// without allocating. If `T` has positive size, then this makes a
+    /// `RawVec` with capacity `0`. If `T` is zero-sized, then it makes a
+    /// `RawVec` with capacity `usize::MAX`. Useful for implementing
+    /// delayed allocation.
+    #[must_use]
+    pub const fn new() -> Self {
+        Self::new_in(Global)
+    }
+
+    /// Creates a `RawVec` (on the system heap) with exactly the
+    /// capacity and alignment requirements for a `[T; capacity]`. This is
+    /// equivalent to calling `RawVec::new` when `capacity` is `0` or `T` is
+    /// zero-sized. Note that if `T` is zero-sized this means you will
+    /// *not* get a `RawVec` with the requested capacity.
+    ///
+    /// # Panics
+    ///
+    /// Panics if the requested capacity exceeds `isize::MAX` bytes.
+    ///
+    /// # Aborts
+    ///
+    /// Aborts on OOM.
+    #[cfg(not(any(no_global_oom_handling, test)))]
+    #[must_use]
+    #[inline]
+    pub fn with_capacity(capacity: usize) -> Self {
+        Self::with_capacity_in(capacity, Global)
+    }
+
+    /// Like `with_capacity`, but guarantees the buffer is zeroed.
+    #[cfg(not(any(no_global_oom_handling, test)))]
+    #[must_use]
+    #[inline]
+    pub fn with_capacity_zeroed(capacity: usize) -> Self {
+        Self::with_capacity_zeroed_in(capacity, Global)
+    }
+}
+
+impl<T, A: Allocator> RawVec<T, A> {
+    // Tiny Vecs are dumb. Skip to:
+    // - 8 if the element size is 1, because any heap allocators is likely
+    //   to round up a request of less than 8 bytes to at least 8 bytes.
+    // - 4 if elements are moderate-sized (<= 1 KiB).
+    // - 1 otherwise, to avoid wasting too much space for very short Vecs.
+    pub(crate) const MIN_NON_ZERO_CAP: usize = if mem::size_of::<T>() == 1 {
+        8
+    } else if mem::size_of::<T>() <= 1024 {
+        4
+    } else {
+        1
+    };
+
+    /// Like `new`, but parameterized over the choice of allocator for
+    /// the returned `RawVec`.
+    pub const fn new_in(alloc: A) -> Self {
+        // `cap: 0` means "unallocated". zero-sized types are ignored.
+        Self { ptr: Unique::dangling(), cap: 0, alloc }
+    }
+
+    /// Like `with_capacity`, but parameterized over the choice of
+    /// allocator for the returned `RawVec`.
+    #[cfg(not(no_global_oom_handling))]
+    #[inline]
+    pub fn with_capacity_in(capacity: usize, alloc: A) -> Self {
+        Self::allocate_in(capacity, AllocInit::Uninitialized, alloc)
+    }
+
+    /// Like `with_capacity_zeroed`, but parameterized over the choice
+    /// of allocator for the returned `RawVec`.
+    #[cfg(not(no_global_oom_handling))]
+    #[inline]
+    pub fn with_capacity_zeroed_in(capacity: usize, alloc: A) -> Self {
+        Self::allocate_in(capacity, AllocInit::Zeroed, alloc)
+    }
+
+    /// Converts the entire buffer into `Box<[MaybeUninit<T>]>` with the specified `len`.
+    ///
+    /// Note that this will correctly reconstitute any `cap` changes
+    /// that may have been performed. (See description of type for details.)
+    ///
+    /// # Safety
+    ///
+    /// * `len` must be greater than or equal to the most recently requested capacity, and
+    /// * `len` must be less than or equal to `self.capacity()`.
+    ///
+    /// Note, that the requested capacity and `self.capacity()` could differ, as
+    /// an allocator could overallocate and return a greater memory block than requested.
+    pub unsafe fn into_box(self, len: usize) -> Box<[MaybeUninit<T>], A> {
+        // Sanity-check one half of the safety requirement (we cannot check the other half).
+        debug_assert!(
+            len <= self.capacity(),
+            "`len` must be smaller than or equal to `self.capacity()`"
+        );
+
+        let me = ManuallyDrop::new(self);
+        unsafe {
+            let slice = slice::from_raw_parts_mut(me.ptr() as *mut MaybeUninit<T>, len);
+            Box::from_raw_in(slice, ptr::read(&me.alloc))
+        }
+    }
+
+    #[cfg(not(no_global_oom_handling))]
+    fn allocate_in(capacity: usize, init: AllocInit, alloc: A) -> Self {
+        // Don't allocate here because `Drop` will not deallocate when `capacity` is 0.
+        if mem::size_of::<T>() == 0 || capacity == 0 {
+            Self::new_in(alloc)
+        } else {
+            // We avoid `unwrap_or_else` here because it bloats the amount of
+            // LLVM IR generated.
+            let layout = match Layout::array::<T>(capacity) {
+                Ok(layout) => layout,
+                Err(_) => capacity_overflow(),
+            };
+            match alloc_guard(layout.size()) {
+                Ok(_) => {}
+                Err(_) => capacity_overflow(),
+            }
+            let result = match init {
+                AllocInit::Uninitialized => alloc.allocate(layout),
+                AllocInit::Zeroed => alloc.allocate_zeroed(layout),
+            };
+            let ptr = match result {
+                Ok(ptr) => ptr,
+                Err(_) => handle_alloc_error(layout),
+            };
+
+            // Allocators currently return a `NonNull<[u8]>` whose length
+            // matches the size requested. If that ever changes, the capacity
+            // here should change to `ptr.len() / mem::size_of::<T>()`.
+            Self {
+                ptr: unsafe { Unique::new_unchecked(ptr.cast().as_ptr()) },
+                cap: capacity,
+                alloc,
+            }
+        }
+    }
+
+    /// Reconstitutes a `RawVec` from a pointer, capacity, and allocator.
+    ///
+    /// # Safety
+    ///
+    /// The `ptr` must be allocated (via the given allocator `alloc`), and with the given
+    /// `capacity`.
+    /// The `capacity` cannot exceed `isize::MAX` for sized types. (only a concern on 32-bit
+    /// systems). ZST vectors may have a capacity up to `usize::MAX`.
+    /// If the `ptr` and `capacity` come from a `RawVec` created via `alloc`, then this is
+    /// guaranteed.
+    #[inline]
+    pub unsafe fn from_raw_parts_in(ptr: *mut T, capacity: usize, alloc: A) -> Self {
+        Self { ptr: unsafe { Unique::new_unchecked(ptr) }, cap: capacity, alloc }
+    }
+
+    /// Gets a raw pointer to the start of the allocation. Note that this is
+    /// `Unique::dangling()` if `capacity == 0` or `T` is zero-sized. In the former case, you must
+    /// be careful.
+    #[inline]
+    pub fn ptr(&self) -> *mut T {
+        self.ptr.as_ptr()
+    }
+
+    /// Gets the capacity of the allocation.
+    ///
+    /// This will always be `usize::MAX` if `T` is zero-sized.
+    #[inline(always)]
+    pub fn capacity(&self) -> usize {
+        if mem::size_of::<T>() == 0 { usize::MAX } else { self.cap }
+    }
+
+    /// Returns a shared reference to the allocator backing this `RawVec`.
+    pub fn allocator(&self) -> &A {
+        &self.alloc
+    }
+
+    fn current_memory(&self) -> Option<(NonNull<u8>, Layout)> {
+        if mem::size_of::<T>() == 0 || self.cap == 0 {
+            None
+        } else {
+            // We have an allocated chunk of memory, so we can bypass runtime
+            // checks to get our current layout.
+            unsafe {
+                let layout = Layout::array::<T>(self.cap).unwrap_unchecked();
+                Some((self.ptr.cast().into(), layout))
+            }
+        }
+    }
+
+    /// Ensures that the buffer contains at least enough space to hold `len +
+    /// additional` elements. If it doesn't already have enough capacity, will
+    /// reallocate enough space plus comfortable slack space to get amortized
+    /// *O*(1) behavior. Will limit this behavior if it would needlessly cause
+    /// itself to panic.
+    ///
+    /// If `len` exceeds `self.capacity()`, this may fail to actually allocate
+    /// the requested space. This is not really unsafe, but the unsafe
+    /// code *you* write that relies on the behavior of this function may break.
+    ///
+    /// This is ideal for implementing a bulk-push operation like `extend`.
+    ///
+    /// # Panics
+    ///
+    /// Panics if the new capacity exceeds `isize::MAX` bytes.
+    ///
+    /// # Aborts
+    ///
+    /// Aborts on OOM.
+    #[cfg(not(no_global_oom_handling))]
+    #[inline]
+    pub fn reserve(&mut self, len: usize, additional: usize) {
+        // Callers expect this function to be very cheap when there is already sufficient capacity.
+        // Therefore, we move all the resizing and error-handling logic from grow_amortized and
+        // handle_reserve behind a call, while making sure that this function is likely to be
+        // inlined as just a comparison and a call if the comparison fails.
+        #[cold]
+        fn do_reserve_and_handle<T, A: Allocator>(
+            slf: &mut RawVec<T, A>,
+            len: usize,
+            additional: usize,
+        ) {
+            handle_reserve(slf.grow_amortized(len, additional));
+        }
+
+        if self.needs_to_grow(len, additional) {
+            do_reserve_and_handle(self, len, additional);
+        }
+    }
+
+    /// A specialized version of `reserve()` used only by the hot and
+    /// oft-instantiated `Vec::push()`, which does its own capacity check.
+    #[cfg(not(no_global_oom_handling))]
+    #[inline(never)]
+    pub fn reserve_for_push(&mut self, len: usize) {
+        handle_reserve(self.grow_amortized(len, 1));
+    }
+
+    /// The same as `reserve`, but returns on errors instead of panicking or aborting.
+    pub fn try_reserve(&mut self, len: usize, additional: usize) -> Result<(), TryReserveError> {
+        if self.needs_to_grow(len, additional) {
+            self.grow_amortized(len, additional)
+        } else {
+            Ok(())
+        }
+    }
+
+    /// Ensures that the buffer contains at least enough space to hold `len +
+    /// additional` elements. If it doesn't already, will reallocate the
+    /// minimum possible amount of memory necessary. Generally this will be
+    /// exactly the amount of memory necessary, but in principle the allocator
+    /// is free to give back more than we asked for.
+    ///
+    /// If `len` exceeds `self.capacity()`, this may fail to actually allocate
+    /// the requested space. This is not really unsafe, but the unsafe code
+    /// *you* write that relies on the behavior of this function may break.
+    ///
+    /// # Panics
+    ///
+    /// Panics if the new capacity exceeds `isize::MAX` bytes.
+    ///
+    /// # Aborts
+    ///
+    /// Aborts on OOM.
+    #[cfg(not(no_global_oom_handling))]
+    pub fn reserve_exact(&mut self, len: usize, additional: usize) {
+        handle_reserve(self.try_reserve_exact(len, additional));
+    }
+
+    /// The same as `reserve_exact`, but returns on errors instead of panicking or aborting.
+    pub fn try_reserve_exact(
+        &mut self,
+        len: usize,
+        additional: usize,
+    ) -> Result<(), TryReserveError> {
+        if self.needs_to_grow(len, additional) { self.grow_exact(len, additional) } else { Ok(()) }
+    }
+
+    /// Shrinks the buffer down to the specified capacity. If the given amount
+    /// is 0, actually completely deallocates.
+    ///
+    /// # Panics
+    ///
+    /// Panics if the given amount is *larger* than the current capacity.
+    ///
+    /// # Aborts
+    ///
+    /// Aborts on OOM.
+    #[cfg(not(no_global_oom_handling))]
+    pub fn shrink_to_fit(&mut self, cap: usize) {
+        handle_reserve(self.shrink(cap));
+    }
+}
+
+impl<T, A: Allocator> RawVec<T, A> {
+    /// Returns if the buffer needs to grow to fulfill the needed extra capacity.
+    /// Mainly used to make inlining reserve-calls possible without inlining `grow`.
+    fn needs_to_grow(&self, len: usize, additional: usize) -> bool {
+        additional > self.capacity().wrapping_sub(len)
+    }
+
+    fn set_ptr_and_cap(&mut self, ptr: NonNull<[u8]>, cap: usize) {
+        // Allocators currently return a `NonNull<[u8]>` whose length matches
+        // the size requested. If that ever changes, the capacity here should
+        // change to `ptr.len() / mem::size_of::<T>()`.
+        self.ptr = unsafe { Unique::new_unchecked(ptr.cast().as_ptr()) };
+        self.cap = cap;
+    }
+
+    // This method is usually instantiated many times. So we want it to be as
+    // small as possible, to improve compile times. But we also want as much of
+    // its contents to be statically computable as possible, to make the
+    // generated code run faster. Therefore, this method is carefully written
+    // so that all of the code that depends on `T` is within it, while as much
+    // of the code that doesn't depend on `T` as possible is in functions that
+    // are non-generic over `T`.
+    fn grow_amortized(&mut self, len: usize, additional: usize) -> Result<(), TryReserveError> {
+        // This is ensured by the calling contexts.
+        debug_assert!(additional > 0);
+
+        if mem::size_of::<T>() == 0 {
+            // Since we return a capacity of `usize::MAX` when `elem_size` is
+            // 0, getting to here necessarily means the `RawVec` is overfull.
+            return Err(CapacityOverflow.into());
+        }
+
+        // Nothing we can really do about these checks, sadly.
+        let required_cap = len.checked_add(additional).ok_or(CapacityOverflow)?;
+
+        // This guarantees exponential growth. The doubling cannot overflow
+        // because `cap <= isize::MAX` and the type of `cap` is `usize`.
+        let cap = cmp::max(self.cap * 2, required_cap);
+        let cap = cmp::max(Self::MIN_NON_ZERO_CAP, cap);
+
+        let new_layout = Layout::array::<T>(cap);
+
+        // `finish_grow` is non-generic over `T`.
+        let ptr = finish_grow(new_layout, self.current_memory(), &mut self.alloc)?;
+        self.set_ptr_and_cap(ptr, cap);
+        Ok(())
+    }
+
+    // The constraints on this method are much the same as those on
+    // `grow_amortized`, but this method is usually instantiated less often so
+    // it's less critical.
+    fn grow_exact(&mut self, len: usize, additional: usize) -> Result<(), TryReserveError> {
+        if mem::size_of::<T>() == 0 {
+            // Since we return a capacity of `usize::MAX` when the type size is
+            // 0, getting to here necessarily means the `RawVec` is overfull.
+            return Err(CapacityOverflow.into());
+        }
+
+        let cap = len.checked_add(additional).ok_or(CapacityOverflow)?;
+        let new_layout = Layout::array::<T>(cap);
+
+        // `finish_grow` is non-generic over `T`.
+        let ptr = finish_grow(new_layout, self.current_memory(), &mut self.alloc)?;
+        self.set_ptr_and_cap(ptr, cap);
+        Ok(())
+    }
+
+    fn shrink(&mut self, cap: usize) -> Result<(), TryReserveError> {
+        assert!(cap <= self.capacity(), "Tried to shrink to a larger capacity");
+
+        let (ptr, layout) = if let Some(mem) = self.current_memory() { mem } else { return Ok(()) };
+
+        let ptr = unsafe {
+            // `Layout::array` cannot overflow here because it would have
+            // overflowed earlier when capacity was larger.
+            let new_layout = Layout::array::<T>(cap).unwrap_unchecked();
+            self.alloc
+                .shrink(ptr, layout, new_layout)
+                .map_err(|_| AllocError { layout: new_layout, non_exhaustive: () })?
+        };
+        self.set_ptr_and_cap(ptr, cap);
+        Ok(())
+    }
+}
+
+// This function is outside `RawVec` to minimize compile times. See the comment
+// above `RawVec::grow_amortized` for details. (The `A` parameter isn't
+// significant, because the number of different `A` types seen in practice is
+// much smaller than the number of `T` types.)
+#[inline(never)]
+fn finish_grow<A>(
+    new_layout: Result<Layout, LayoutError>,
+    current_memory: Option<(NonNull<u8>, Layout)>,
+    alloc: &mut A,
+) -> Result<NonNull<[u8]>, TryReserveError>
+where
+    A: Allocator,
+{
+    // Check for the error here to minimize the size of `RawVec::grow_*`.
+    let new_layout = new_layout.map_err(|_| CapacityOverflow)?;
+
+    alloc_guard(new_layout.size())?;
+
+    let memory = if let Some((ptr, old_layout)) = current_memory {
+        debug_assert_eq!(old_layout.align(), new_layout.align());
+        unsafe {
+            // The allocator checks for alignment equality
+            intrinsics::assume(old_layout.align() == new_layout.align());
+            alloc.grow(ptr, old_layout, new_layout)
+        }
+    } else {
+        alloc.allocate(new_layout)
+    };
+
+    memory.map_err(|_| AllocError { layout: new_layout, non_exhaustive: () }.into())
+}
+
+unsafe impl<#[may_dangle] T, A: Allocator> Drop for RawVec<T, A> {
+    /// Frees the memory owned by the `RawVec` *without* trying to drop its contents.
+    fn drop(&mut self) {
+        if let Some((ptr, layout)) = self.current_memory() {
+            unsafe { self.alloc.deallocate(ptr, layout) }
+        }
+    }
+}
+
+// Central function for reserve error handling.
+#[cfg(not(no_global_oom_handling))]
+#[inline]
+fn handle_reserve(result: Result<(), TryReserveError>) {
+    match result.map_err(|e| e.kind()) {
+        Err(CapacityOverflow) => capacity_overflow(),
+        Err(AllocError { layout, .. }) => handle_alloc_error(layout),
+        Ok(()) => { /* yay */ }
+    }
+}
+
+// We need to guarantee the following:
+// * We don't ever allocate `> isize::MAX` byte-size objects.
+// * We don't overflow `usize::MAX` and actually allocate too little.
+//
+// On 64-bit we just need to check for overflow since trying to allocate
+// `> isize::MAX` bytes will surely fail. On 32-bit and 16-bit we need to add
+// an extra guard for this in case we're running on a platform which can use
+// all 4GB in user-space, e.g., PAE or x32.
+
+#[inline]
+fn alloc_guard(alloc_size: usize) -> Result<(), TryReserveError> {
+    if usize::BITS < 64 && alloc_size > isize::MAX as usize {
+        Err(CapacityOverflow.into())
+    } else {
+        Ok(())
+    }
+}
+
+// One central function responsible for reporting capacity overflows. This'll
+// ensure that the code generation related to these panics is minimal as there's
+// only one location which panics rather than a bunch throughout the module.
+#[cfg(not(no_global_oom_handling))]
+fn capacity_overflow() -> ! {
+    panic!("capacity overflow");
+}
diff --git a/rust/alloc/slice.rs b/rust/alloc/slice.rs
new file mode 100644
index 000000000000..199b3c9d0290
--- /dev/null
+++ b/rust/alloc/slice.rs
@@ -0,0 +1,1202 @@
+//! A dynamically-sized view into a contiguous sequence, `[T]`.
+//!
+//! *[See also the slice primitive type](slice).*
+//!
+//! Slices are a view into a block of memory represented as a pointer and a
+//! length.
+//!
+//! ```
+//! // slicing a Vec
+//! let vec = vec![1, 2, 3];
+//! let int_slice = &vec[..];
+//! // coercing an array to a slice
+//! let str_slice: &[&str] = &["one", "two", "three"];
+//! ```
+//!
+//! Slices are either mutable or shared. The shared slice type is `&[T]`,
+//! while the mutable slice type is `&mut [T]`, where `T` represents the element
+//! type. For example, you can mutate the block of memory that a mutable slice
+//! points to:
+//!
+//! ```
+//! let x = &mut [1, 2, 3];
+//! x[1] = 7;
+//! assert_eq!(x, &[1, 7, 3]);
+//! ```
+//!
+//! Here are some of the things this module contains:
+//!
+//! ## Structs
+//!
+//! There are several structs that are useful for slices, such as [`Iter`], which
+//! represents iteration over a slice.
+//!
+//! ## Trait Implementations
+//!
+//! There are several implementations of common traits for slices. Some examples
+//! include:
+//!
+//! * [`Clone`]
+//! * [`Eq`], [`Ord`] - for slices whose element type are [`Eq`] or [`Ord`].
+//! * [`Hash`] - for slices whose element type is [`Hash`].
+//!
+//! ## Iteration
+//!
+//! The slices implement `IntoIterator`. The iterator yields references to the
+//! slice elements.
+//!
+//! ```
+//! let numbers = &[0, 1, 2];
+//! for n in numbers {
+//!     println!("{n} is a number!");
+//! }
+//! ```
+//!
+//! The mutable slice yields mutable references to the elements:
+//!
+//! ```
+//! let mut scores = [7, 8, 9];
+//! for score in &mut scores[..] {
+//!     *score += 1;
+//! }
+//! ```
+//!
+//! This iterator yields mutable references to the slice's elements, so while
+//! the element type of the slice is `i32`, the element type of the iterator is
+//! `&mut i32`.
+//!
+//! * [`.iter`] and [`.iter_mut`] are the explicit methods to return the default
+//!   iterators.
+//! * Further methods that return iterators are [`.split`], [`.splitn`],
+//!   [`.chunks`], [`.windows`] and more.
+//!
+//! [`Hash`]: core::hash::Hash
+//! [`.iter`]: slice::iter
+//! [`.iter_mut`]: slice::iter_mut
+//! [`.split`]: slice::split
+//! [`.splitn`]: slice::splitn
+//! [`.chunks`]: slice::chunks
+//! [`.windows`]: slice::windows
+#![stable(feature = "rust1", since = "1.0.0")]
+// Many of the usings in this module are only used in the test configuration.
+// It's cleaner to just turn off the unused_imports warning than to fix them.
+#![cfg_attr(test, allow(unused_imports, dead_code))]
+
+use core::borrow::{Borrow, BorrowMut};
+#[cfg(not(no_global_oom_handling))]
+use core::cmp::Ordering::{self, Less};
+#[cfg(not(no_global_oom_handling))]
+use core::mem;
+#[cfg(not(no_global_oom_handling))]
+use core::mem::size_of;
+#[cfg(not(no_global_oom_handling))]
+use core::ptr;
+
+use crate::alloc::Allocator;
+#[cfg(not(no_global_oom_handling))]
+use crate::alloc::Global;
+#[cfg(not(no_global_oom_handling))]
+use crate::borrow::ToOwned;
+use crate::boxed::Box;
+use crate::vec::Vec;
+
+#[unstable(feature = "slice_range", issue = "76393")]
+pub use core::slice::range;
+#[unstable(feature = "array_chunks", issue = "74985")]
+pub use core::slice::ArrayChunks;
+#[unstable(feature = "array_chunks", issue = "74985")]
+pub use core::slice::ArrayChunksMut;
+#[unstable(feature = "array_windows", issue = "75027")]
+pub use core::slice::ArrayWindows;
+#[stable(feature = "inherent_ascii_escape", since = "1.60.0")]
+pub use core::slice::EscapeAscii;
+#[stable(feature = "slice_get_slice", since = "1.28.0")]
+pub use core::slice::SliceIndex;
+#[stable(feature = "from_ref", since = "1.28.0")]
+pub use core::slice::{from_mut, from_ref};
+#[stable(feature = "rust1", since = "1.0.0")]
+pub use core::slice::{from_raw_parts, from_raw_parts_mut};
+#[stable(feature = "rust1", since = "1.0.0")]
+pub use core::slice::{Chunks, Windows};
+#[stable(feature = "chunks_exact", since = "1.31.0")]
+pub use core::slice::{ChunksExact, ChunksExactMut};
+#[stable(feature = "rust1", since = "1.0.0")]
+pub use core::slice::{ChunksMut, Split, SplitMut};
+#[unstable(feature = "slice_group_by", issue = "80552")]
+pub use core::slice::{GroupBy, GroupByMut};
+#[stable(feature = "rust1", since = "1.0.0")]
+pub use core::slice::{Iter, IterMut};
+#[stable(feature = "rchunks", since = "1.31.0")]
+pub use core::slice::{RChunks, RChunksExact, RChunksExactMut, RChunksMut};
+#[stable(feature = "slice_rsplit", since = "1.27.0")]
+pub use core::slice::{RSplit, RSplitMut};
+#[stable(feature = "rust1", since = "1.0.0")]
+pub use core::slice::{RSplitN, RSplitNMut, SplitN, SplitNMut};
+#[stable(feature = "split_inclusive", since = "1.51.0")]
+pub use core::slice::{SplitInclusive, SplitInclusiveMut};
+
+////////////////////////////////////////////////////////////////////////////////
+// Basic slice extension methods
+////////////////////////////////////////////////////////////////////////////////
+
+// HACK(japaric) needed for the implementation of `vec!` macro during testing
+// N.B., see the `hack` module in this file for more details.
+#[cfg(test)]
+pub use hack::into_vec;
+
+// HACK(japaric) needed for the implementation of `Vec::clone` during testing
+// N.B., see the `hack` module in this file for more details.
+#[cfg(test)]
+pub use hack::to_vec;
+
+// HACK(japaric): With cfg(test) `impl [T]` is not available, these three
+// functions are actually methods that are in `impl [T]` but not in
+// `core::slice::SliceExt` - we need to supply these functions for the
+// `test_permutations` test
+pub(crate) mod hack {
+    use core::alloc::Allocator;
+
+    use crate::boxed::Box;
+    use crate::vec::Vec;
+
+    // We shouldn't add inline attribute to this since this is used in
+    // `vec!` macro mostly and causes perf regression. See #71204 for
+    // discussion and perf results.
+    pub fn into_vec<T, A: Allocator>(b: Box<[T], A>) -> Vec<T, A> {
+        unsafe {
+            let len = b.len();
+            let (b, alloc) = Box::into_raw_with_allocator(b);
+            Vec::from_raw_parts_in(b as *mut T, len, len, alloc)
+        }
+    }
+
+    #[cfg(not(no_global_oom_handling))]
+    #[inline]
+    pub fn to_vec<T: ConvertVec, A: Allocator>(s: &[T], alloc: A) -> Vec<T, A> {
+        T::to_vec(s, alloc)
+    }
+
+    #[cfg(not(no_global_oom_handling))]
+    pub trait ConvertVec {
+        fn to_vec<A: Allocator>(s: &[Self], alloc: A) -> Vec<Self, A>
+        where
+            Self: Sized;
+    }
+
+    #[cfg(not(no_global_oom_handling))]
+    impl<T: Clone> ConvertVec for T {
+        #[inline]
+        default fn to_vec<A: Allocator>(s: &[Self], alloc: A) -> Vec<Self, A> {
+            struct DropGuard<'a, T, A: Allocator> {
+                vec: &'a mut Vec<T, A>,
+                num_init: usize,
+            }
+            impl<'a, T, A: Allocator> Drop for DropGuard<'a, T, A> {
+                #[inline]
+                fn drop(&mut self) {
+                    // SAFETY:
+                    // items were marked initialized in the loop below
+                    unsafe {
+                        self.vec.set_len(self.num_init);
+                    }
+                }
+            }
+            let mut vec = Vec::with_capacity_in(s.len(), alloc);
+            let mut guard = DropGuard { vec: &mut vec, num_init: 0 };
+            let slots = guard.vec.spare_capacity_mut();
+            // .take(slots.len()) is necessary for LLVM to remove bounds checks
+            // and has better codegen than zip.
+            for (i, b) in s.iter().enumerate().take(slots.len()) {
+                guard.num_init = i;
+                slots[i].write(b.clone());
+            }
+            core::mem::forget(guard);
+            // SAFETY:
+            // the vec was allocated and initialized above to at least this length.
+            unsafe {
+                vec.set_len(s.len());
+            }
+            vec
+        }
+    }
+
+    #[cfg(not(no_global_oom_handling))]
+    impl<T: Copy> ConvertVec for T {
+        #[inline]
+        fn to_vec<A: Allocator>(s: &[Self], alloc: A) -> Vec<Self, A> {
+            let mut v = Vec::with_capacity_in(s.len(), alloc);
+            // SAFETY:
+            // allocated above with the capacity of `s`, and initialize to `s.len()` in
+            // ptr::copy_to_non_overlapping below.
+            unsafe {
+                s.as_ptr().copy_to_nonoverlapping(v.as_mut_ptr(), s.len());
+                v.set_len(s.len());
+            }
+            v
+        }
+    }
+}
+
+#[cfg(not(test))]
+impl<T> [T] {
+    /// Sorts the slice.
+    ///
+    /// This sort is stable (i.e., does not reorder equal elements) and *O*(*n* \* log(*n*)) worst-case.
+    ///
+    /// When applicable, unstable sorting is preferred because it is generally faster than stable
+    /// sorting and it doesn't allocate auxiliary memory.
+    /// See [`sort_unstable`](slice::sort_unstable).
+    ///
+    /// # Current implementation
+    ///
+    /// The current algorithm is an adaptive, iterative merge sort inspired by
+    /// [timsort](https://en.wikipedia.org/wiki/Timsort).
+    /// It is designed to be very fast in cases where the slice is nearly sorted, or consists of
+    /// two or more sorted sequences concatenated one after another.
+    ///
+    /// Also, it allocates temporary storage half the size of `self`, but for short slices a
+    /// non-allocating insertion sort is used instead.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let mut v = [-5, 4, 1, -3, 2];
+    ///
+    /// v.sort();
+    /// assert!(v == [-5, -3, 1, 2, 4]);
+    /// ```
+    #[cfg(not(no_global_oom_handling))]
+    #[rustc_allow_incoherent_impl]
+    #[stable(feature = "rust1", since = "1.0.0")]
+    #[inline]
+    pub fn sort(&mut self)
+    where
+        T: Ord,
+    {
+        merge_sort(self, |a, b| a.lt(b));
+    }
+
+    /// Sorts the slice with a comparator function.
+    ///
+    /// This sort is stable (i.e., does not reorder equal elements) and *O*(*n* \* log(*n*)) worst-case.
+    ///
+    /// The comparator function must define a total ordering for the elements in the slice. If
+    /// the ordering is not total, the order of the elements is unspecified. An order is a
+    /// total order if it is (for all `a`, `b` and `c`):
+    ///
+    /// * total and antisymmetric: exactly one of `a < b`, `a == b` or `a > b` is true, and
+    /// * transitive, `a < b` and `b < c` implies `a < c`. The same must hold for both `==` and `>`.
+    ///
+    /// For example, while [`f64`] doesn't implement [`Ord`] because `NaN != NaN`, we can use
+    /// `partial_cmp` as our sort function when we know the slice doesn't contain a `NaN`.
+    ///
+    /// ```
+    /// let mut floats = [5f64, 4.0, 1.0, 3.0, 2.0];
+    /// floats.sort_by(|a, b| a.partial_cmp(b).unwrap());
+    /// assert_eq!(floats, [1.0, 2.0, 3.0, 4.0, 5.0]);
+    /// ```
+    ///
+    /// When applicable, unstable sorting is preferred because it is generally faster than stable
+    /// sorting and it doesn't allocate auxiliary memory.
+    /// See [`sort_unstable_by`](slice::sort_unstable_by).
+    ///
+    /// # Current implementation
+    ///
+    /// The current algorithm is an adaptive, iterative merge sort inspired by
+    /// [timsort](https://en.wikipedia.org/wiki/Timsort).
+    /// It is designed to be very fast in cases where the slice is nearly sorted, or consists of
+    /// two or more sorted sequences concatenated one after another.
+    ///
+    /// Also, it allocates temporary storage half the size of `self`, but for short slices a
+    /// non-allocating insertion sort is used instead.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let mut v = [5, 4, 1, 3, 2];
+    /// v.sort_by(|a, b| a.cmp(b));
+    /// assert!(v == [1, 2, 3, 4, 5]);
+    ///
+    /// // reverse sorting
+    /// v.sort_by(|a, b| b.cmp(a));
+    /// assert!(v == [5, 4, 3, 2, 1]);
+    /// ```
+    #[cfg(not(no_global_oom_handling))]
+    #[rustc_allow_incoherent_impl]
+    #[stable(feature = "rust1", since = "1.0.0")]
+    #[inline]
+    pub fn sort_by<F>(&mut self, mut compare: F)
+    where
+        F: FnMut(&T, &T) -> Ordering,
+    {
+        merge_sort(self, |a, b| compare(a, b) == Less);
+    }
+
+    /// Sorts the slice with a key extraction function.
+    ///
+    /// This sort is stable (i.e., does not reorder equal elements) and *O*(*m* \* *n* \* log(*n*))
+    /// worst-case, where the key function is *O*(*m*).
+    ///
+    /// For expensive key functions (e.g. functions that are not simple property accesses or
+    /// basic operations), [`sort_by_cached_key`](slice::sort_by_cached_key) is likely to be
+    /// significantly faster, as it does not recompute element keys.
+    ///
+    /// When applicable, unstable sorting is preferred because it is generally faster than stable
+    /// sorting and it doesn't allocate auxiliary memory.
+    /// See [`sort_unstable_by_key`](slice::sort_unstable_by_key).
+    ///
+    /// # Current implementation
+    ///
+    /// The current algorithm is an adaptive, iterative merge sort inspired by
+    /// [timsort](https://en.wikipedia.org/wiki/Timsort).
+    /// It is designed to be very fast in cases where the slice is nearly sorted, or consists of
+    /// two or more sorted sequences concatenated one after another.
+    ///
+    /// Also, it allocates temporary storage half the size of `self`, but for short slices a
+    /// non-allocating insertion sort is used instead.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let mut v = [-5i32, 4, 1, -3, 2];
+    ///
+    /// v.sort_by_key(|k| k.abs());
+    /// assert!(v == [1, 2, -3, 4, -5]);
+    /// ```
+    #[cfg(not(no_global_oom_handling))]
+    #[rustc_allow_incoherent_impl]
+    #[stable(feature = "slice_sort_by_key", since = "1.7.0")]
+    #[inline]
+    pub fn sort_by_key<K, F>(&mut self, mut f: F)
+    where
+        F: FnMut(&T) -> K,
+        K: Ord,
+    {
+        merge_sort(self, |a, b| f(a).lt(&f(b)));
+    }
+
+    /// Sorts the slice with a key extraction function.
+    ///
+    /// During sorting, the key function is called at most once per element, by using
+    /// temporary storage to remember the results of key evaluation.
+    /// The order of calls to the key function is unspecified and may change in future versions
+    /// of the standard library.
+    ///
+    /// This sort is stable (i.e., does not reorder equal elements) and *O*(*m* \* *n* + *n* \* log(*n*))
+    /// worst-case, where the key function is *O*(*m*).
+    ///
+    /// For simple key functions (e.g., functions that are property accesses or
+    /// basic operations), [`sort_by_key`](slice::sort_by_key) is likely to be
+    /// faster.
+    ///
+    /// # Current implementation
+    ///
+    /// The current algorithm is based on [pattern-defeating quicksort][pdqsort] by Orson Peters,
+    /// which combines the fast average case of randomized quicksort with the fast worst case of
+    /// heapsort, while achieving linear time on slices with certain patterns. It uses some
+    /// randomization to avoid degenerate cases, but with a fixed seed to always provide
+    /// deterministic behavior.
+    ///
+    /// In the worst case, the algorithm allocates temporary storage in a `Vec<(K, usize)>` the
+    /// length of the slice.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let mut v = [-5i32, 4, 32, -3, 2];
+    ///
+    /// v.sort_by_cached_key(|k| k.to_string());
+    /// assert!(v == [-3, -5, 2, 32, 4]);
+    /// ```
+    ///
+    /// [pdqsort]: https://github.com/orlp/pdqsort
+    #[cfg(not(no_global_oom_handling))]
+    #[rustc_allow_incoherent_impl]
+    #[stable(feature = "slice_sort_by_cached_key", since = "1.34.0")]
+    #[inline]
+    pub fn sort_by_cached_key<K, F>(&mut self, f: F)
+    where
+        F: FnMut(&T) -> K,
+        K: Ord,
+    {
+        // Helper macro for indexing our vector by the smallest possible type, to reduce allocation.
+        macro_rules! sort_by_key {
+            ($t:ty, $slice:ident, $f:ident) => {{
+                let mut indices: Vec<_> =
+                    $slice.iter().map($f).enumerate().map(|(i, k)| (k, i as $t)).collect();
+                // The elements of `indices` are unique, as they are indexed, so any sort will be
+                // stable with respect to the original slice. We use `sort_unstable` here because
+                // it requires less memory allocation.
+                indices.sort_unstable();
+                for i in 0..$slice.len() {
+                    let mut index = indices[i].1;
+                    while (index as usize) < i {
+                        index = indices[index as usize].1;
+                    }
+                    indices[i].1 = index;
+                    $slice.swap(i, index as usize);
+                }
+            }};
+        }
+
+        let sz_u8 = mem::size_of::<(K, u8)>();
+        let sz_u16 = mem::size_of::<(K, u16)>();
+        let sz_u32 = mem::size_of::<(K, u32)>();
+        let sz_usize = mem::size_of::<(K, usize)>();
+
+        let len = self.len();
+        if len < 2 {
+            return;
+        }
+        if sz_u8 < sz_u16 && len <= (u8::MAX as usize) {
+            return sort_by_key!(u8, self, f);
+        }
+        if sz_u16 < sz_u32 && len <= (u16::MAX as usize) {
+            return sort_by_key!(u16, self, f);
+        }
+        if sz_u32 < sz_usize && len <= (u32::MAX as usize) {
+            return sort_by_key!(u32, self, f);
+        }
+        sort_by_key!(usize, self, f)
+    }
+
+    /// Copies `self` into a new `Vec`.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let s = [10, 40, 30];
+    /// let x = s.to_vec();
+    /// // Here, `s` and `x` can be modified independently.
+    /// ```
+    #[cfg(not(no_global_oom_handling))]
+    #[rustc_allow_incoherent_impl]
+    #[rustc_conversion_suggestion]
+    #[stable(feature = "rust1", since = "1.0.0")]
+    #[inline]
+    pub fn to_vec(&self) -> Vec<T>
+    where
+        T: Clone,
+    {
+        self.to_vec_in(Global)
+    }
+
+    /// Copies `self` into a new `Vec` with an allocator.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// #![feature(allocator_api)]
+    ///
+    /// use std::alloc::System;
+    ///
+    /// let s = [10, 40, 30];
+    /// let x = s.to_vec_in(System);
+    /// // Here, `s` and `x` can be modified independently.
+    /// ```
+    #[cfg(not(no_global_oom_handling))]
+    #[rustc_allow_incoherent_impl]
+    #[inline]
+    #[unstable(feature = "allocator_api", issue = "32838")]
+    pub fn to_vec_in<A: Allocator>(&self, alloc: A) -> Vec<T, A>
+    where
+        T: Clone,
+    {
+        // N.B., see the `hack` module in this file for more details.
+        hack::to_vec(self, alloc)
+    }
+
+    /// Converts `self` into a vector without clones or allocation.
+    ///
+    /// The resulting vector can be converted back into a box via
+    /// `Vec<T>`'s `into_boxed_slice` method.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let s: Box<[i32]> = Box::new([10, 40, 30]);
+    /// let x = s.into_vec();
+    /// // `s` cannot be used anymore because it has been converted into `x`.
+    ///
+    /// assert_eq!(x, vec![10, 40, 30]);
+    /// ```
+    #[rustc_allow_incoherent_impl]
+    #[stable(feature = "rust1", since = "1.0.0")]
+    #[inline]
+    pub fn into_vec<A: Allocator>(self: Box<Self, A>) -> Vec<T, A> {
+        // N.B., see the `hack` module in this file for more details.
+        hack::into_vec(self)
+    }
+
+    /// Creates a vector by repeating a slice `n` times.
+    ///
+    /// # Panics
+    ///
+    /// This function will panic if the capacity would overflow.
+    ///
+    /// # Examples
+    ///
+    /// Basic usage:
+    ///
+    /// ```
+    /// assert_eq!([1, 2].repeat(3), vec![1, 2, 1, 2, 1, 2]);
+    /// ```
+    ///
+    /// A panic upon overflow:
+    ///
+    /// ```should_panic
+    /// // this will panic at runtime
+    /// b"0123456789abcdef".repeat(usize::MAX);
+    /// ```
+    #[rustc_allow_incoherent_impl]
+    #[cfg(not(no_global_oom_handling))]
+    #[stable(feature = "repeat_generic_slice", since = "1.40.0")]
+    pub fn repeat(&self, n: usize) -> Vec<T>
+    where
+        T: Copy,
+    {
+        if n == 0 {
+            return Vec::new();
+        }
+
+        // If `n` is larger than zero, it can be split as
+        // `n = 2^expn + rem (2^expn > rem, expn >= 0, rem >= 0)`.
+        // `2^expn` is the number represented by the leftmost '1' bit of `n`,
+        // and `rem` is the remaining part of `n`.
+
+        // Using `Vec` to access `set_len()`.
+        let capacity = self.len().checked_mul(n).expect("capacity overflow");
+        let mut buf = Vec::with_capacity(capacity);
+
+        // `2^expn` repetition is done by doubling `buf` `expn`-times.
+        buf.extend(self);
+        {
+            let mut m = n >> 1;
+            // If `m > 0`, there are remaining bits up to the leftmost '1'.
+            while m > 0 {
+                // `buf.extend(buf)`:
+                unsafe {
+                    ptr::copy_nonoverlapping(
+                        buf.as_ptr(),
+                        (buf.as_mut_ptr() as *mut T).add(buf.len()),
+                        buf.len(),
+                    );
+                    // `buf` has capacity of `self.len() * n`.
+                    let buf_len = buf.len();
+                    buf.set_len(buf_len * 2);
+                }
+
+                m >>= 1;
+            }
+        }
+
+        // `rem` (`= n - 2^expn`) repetition is done by copying
+        // first `rem` repetitions from `buf` itself.
+        let rem_len = capacity - buf.len(); // `self.len() * rem`
+        if rem_len > 0 {
+            // `buf.extend(buf[0 .. rem_len])`:
+            unsafe {
+                // This is non-overlapping since `2^expn > rem`.
+                ptr::copy_nonoverlapping(
+                    buf.as_ptr(),
+                    (buf.as_mut_ptr() as *mut T).add(buf.len()),
+                    rem_len,
+                );
+                // `buf.len() + rem_len` equals to `buf.capacity()` (`= self.len() * n`).
+                buf.set_len(capacity);
+            }
+        }
+        buf
+    }
+
+    /// Flattens a slice of `T` into a single value `Self::Output`.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// assert_eq!(["hello", "world"].concat(), "helloworld");
+    /// assert_eq!([[1, 2], [3, 4]].concat(), [1, 2, 3, 4]);
+    /// ```
+    #[rustc_allow_incoherent_impl]
+    #[stable(feature = "rust1", since = "1.0.0")]
+    pub fn concat<Item: ?Sized>(&self) -> <Self as Concat<Item>>::Output
+    where
+        Self: Concat<Item>,
+    {
+        Concat::concat(self)
+    }
+
+    /// Flattens a slice of `T` into a single value `Self::Output`, placing a
+    /// given separator between each.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// assert_eq!(["hello", "world"].join(" "), "hello world");
+    /// assert_eq!([[1, 2], [3, 4]].join(&0), [1, 2, 0, 3, 4]);
+    /// assert_eq!([[1, 2], [3, 4]].join(&[0, 0][..]), [1, 2, 0, 0, 3, 4]);
+    /// ```
+    #[rustc_allow_incoherent_impl]
+    #[stable(feature = "rename_connect_to_join", since = "1.3.0")]
+    pub fn join<Separator>(&self, sep: Separator) -> <Self as Join<Separator>>::Output
+    where
+        Self: Join<Separator>,
+    {
+        Join::join(self, sep)
+    }
+
+    /// Flattens a slice of `T` into a single value `Self::Output`, placing a
+    /// given separator between each.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// # #![allow(deprecated)]
+    /// assert_eq!(["hello", "world"].connect(" "), "hello world");
+    /// assert_eq!([[1, 2], [3, 4]].connect(&0), [1, 2, 0, 3, 4]);
+    /// ```
+    #[rustc_allow_incoherent_impl]
+    #[stable(feature = "rust1", since = "1.0.0")]
+    #[deprecated(since = "1.3.0", note = "renamed to join")]
+    pub fn connect<Separator>(&self, sep: Separator) -> <Self as Join<Separator>>::Output
+    where
+        Self: Join<Separator>,
+    {
+        Join::join(self, sep)
+    }
+}
+
+#[cfg(not(test))]
+impl [u8] {
+    /// Returns a vector containing a copy of this slice where each byte
+    /// is mapped to its ASCII upper case equivalent.
+    ///
+    /// ASCII letters 'a' to 'z' are mapped to 'A' to 'Z',
+    /// but non-ASCII letters are unchanged.
+    ///
+    /// To uppercase the value in-place, use [`make_ascii_uppercase`].
+    ///
+    /// [`make_ascii_uppercase`]: slice::make_ascii_uppercase
+    #[cfg(not(no_global_oom_handling))]
+    #[rustc_allow_incoherent_impl]
+    #[must_use = "this returns the uppercase bytes as a new Vec, \
+                  without modifying the original"]
+    #[stable(feature = "ascii_methods_on_intrinsics", since = "1.23.0")]
+    #[inline]
+    pub fn to_ascii_uppercase(&self) -> Vec<u8> {
+        let mut me = self.to_vec();
+        me.make_ascii_uppercase();
+        me
+    }
+
+    /// Returns a vector containing a copy of this slice where each byte
+    /// is mapped to its ASCII lower case equivalent.
+    ///
+    /// ASCII letters 'A' to 'Z' are mapped to 'a' to 'z',
+    /// but non-ASCII letters are unchanged.
+    ///
+    /// To lowercase the value in-place, use [`make_ascii_lowercase`].
+    ///
+    /// [`make_ascii_lowercase`]: slice::make_ascii_lowercase
+    #[cfg(not(no_global_oom_handling))]
+    #[rustc_allow_incoherent_impl]
+    #[must_use = "this returns the lowercase bytes as a new Vec, \
+                  without modifying the original"]
+    #[stable(feature = "ascii_methods_on_intrinsics", since = "1.23.0")]
+    #[inline]
+    pub fn to_ascii_lowercase(&self) -> Vec<u8> {
+        let mut me = self.to_vec();
+        me.make_ascii_lowercase();
+        me
+    }
+}
+
+////////////////////////////////////////////////////////////////////////////////
+// Extension traits for slices over specific kinds of data
+////////////////////////////////////////////////////////////////////////////////
+
+/// Helper trait for [`[T]::concat`](slice::concat).
+///
+/// Note: the `Item` type parameter is not used in this trait,
+/// but it allows impls to be more generic.
+/// Without it, we get this error:
+///
+/// ```error
+/// error[E0207]: the type parameter `T` is not constrained by the impl trait, self type, or predica
+///    --> src/liballoc/slice.rs:608:6
+///     |
+/// 608 | impl<T: Clone, V: Borrow<[T]>> Concat for [V] {
+///     |      ^ unconstrained type parameter
+/// ```
+///
+/// This is because there could exist `V` types with multiple `Borrow<[_]>` impls,
+/// such that multiple `T` types would apply:
+///
+/// ```
+/// # #[allow(dead_code)]
+/// pub struct Foo(Vec<u32>, Vec<String>);
+///
+/// impl std::borrow::Borrow<[u32]> for Foo {
+///     fn borrow(&self) -> &[u32] { &self.0 }
+/// }
+///
+/// impl std::borrow::Borrow<[String]> for Foo {
+///     fn borrow(&self) -> &[String] { &self.1 }
+/// }
+/// ```
+#[unstable(feature = "slice_concat_trait", issue = "27747")]
+pub trait Concat<Item: ?Sized> {
+    #[unstable(feature = "slice_concat_trait", issue = "27747")]
+    /// The resulting type after concatenation
+    type Output;
+
+    /// Implementation of [`[T]::concat`](slice::concat)
+    #[unstable(feature = "slice_concat_trait", issue = "27747")]
+    fn concat(slice: &Self) -> Self::Output;
+}
+
+/// Helper trait for [`[T]::join`](slice::join)
+#[unstable(feature = "slice_concat_trait", issue = "27747")]
+pub trait Join<Separator> {
+    #[unstable(feature = "slice_concat_trait", issue = "27747")]
+    /// The resulting type after concatenation
+    type Output;
+
+    /// Implementation of [`[T]::join`](slice::join)
+    #[unstable(feature = "slice_concat_trait", issue = "27747")]
+    fn join(slice: &Self, sep: Separator) -> Self::Output;
+}
+
+#[cfg(not(no_global_oom_handling))]
+#[unstable(feature = "slice_concat_ext", issue = "27747")]
+impl<T: Clone, V: Borrow<[T]>> Concat<T> for [V] {
+    type Output = Vec<T>;
+
+    fn concat(slice: &Self) -> Vec<T> {
+        let size = slice.iter().map(|slice| slice.borrow().len()).sum();
+        let mut result = Vec::with_capacity(size);
+        for v in slice {
+            result.extend_from_slice(v.borrow())
+        }
+        result
+    }
+}
+
+#[cfg(not(no_global_oom_handling))]
+#[unstable(feature = "slice_concat_ext", issue = "27747")]
+impl<T: Clone, V: Borrow<[T]>> Join<&T> for [V] {
+    type Output = Vec<T>;
+
+    fn join(slice: &Self, sep: &T) -> Vec<T> {
+        let mut iter = slice.iter();
+        let first = match iter.next() {
+            Some(first) => first,
+            None => return vec![],
+        };
+        let size = slice.iter().map(|v| v.borrow().len()).sum::<usize>() + slice.len() - 1;
+        let mut result = Vec::with_capacity(size);
+        result.extend_from_slice(first.borrow());
+
+        for v in iter {
+            result.push(sep.clone());
+            result.extend_from_slice(v.borrow())
+        }
+        result
+    }
+}
+
+#[cfg(not(no_global_oom_handling))]
+#[unstable(feature = "slice_concat_ext", issue = "27747")]
+impl<T: Clone, V: Borrow<[T]>> Join<&[T]> for [V] {
+    type Output = Vec<T>;
+
+    fn join(slice: &Self, sep: &[T]) -> Vec<T> {
+        let mut iter = slice.iter();
+        let first = match iter.next() {
+            Some(first) => first,
+            None => return vec![],
+        };
+        let size =
+            slice.iter().map(|v| v.borrow().len()).sum::<usize>() + sep.len() * (slice.len() - 1);
+        let mut result = Vec::with_capacity(size);
+        result.extend_from_slice(first.borrow());
+
+        for v in iter {
+            result.extend_from_slice(sep);
+            result.extend_from_slice(v.borrow())
+        }
+        result
+    }
+}
+
+////////////////////////////////////////////////////////////////////////////////
+// Standard trait implementations for slices
+////////////////////////////////////////////////////////////////////////////////
+
+#[stable(feature = "rust1", since = "1.0.0")]
+impl<T> Borrow<[T]> for Vec<T> {
+    fn borrow(&self) -> &[T] {
+        &self[..]
+    }
+}
+
+#[stable(feature = "rust1", since = "1.0.0")]
+impl<T> BorrowMut<[T]> for Vec<T> {
+    fn borrow_mut(&mut self) -> &mut [T] {
+        &mut self[..]
+    }
+}
+
+#[cfg(not(no_global_oom_handling))]
+#[stable(feature = "rust1", since = "1.0.0")]
+impl<T: Clone> ToOwned for [T] {
+    type Owned = Vec<T>;
+    #[cfg(not(test))]
+    fn to_owned(&self) -> Vec<T> {
+        self.to_vec()
+    }
+
+    #[cfg(test)]
+    fn to_owned(&self) -> Vec<T> {
+        hack::to_vec(self, Global)
+    }
+
+    fn clone_into(&self, target: &mut Vec<T>) {
+        // drop anything in target that will not be overwritten
+        target.truncate(self.len());
+
+        // target.len <= self.len due to the truncate above, so the
+        // slices here are always in-bounds.
+        let (init, tail) = self.split_at(target.len());
+
+        // reuse the contained values' allocations/resources.
+        target.clone_from_slice(init);
+        target.extend_from_slice(tail);
+    }
+}
+
+////////////////////////////////////////////////////////////////////////////////
+// Sorting
+////////////////////////////////////////////////////////////////////////////////
+
+/// Inserts `v[0]` into pre-sorted sequence `v[1..]` so that whole `v[..]` becomes sorted.
+///
+/// This is the integral subroutine of insertion sort.
+#[cfg(not(no_global_oom_handling))]
+fn insert_head<T, F>(v: &mut [T], is_less: &mut F)
+where
+    F: FnMut(&T, &T) -> bool,
+{
+    if v.len() >= 2 && is_less(&v[1], &v[0]) {
+        unsafe {
+            // There are three ways to implement insertion here:
+            //
+            // 1. Swap adjacent elements until the first one gets to its final destination.
+            //    However, this way we copy data around more than is necessary. If elements are big
+            //    structures (costly to copy), this method will be slow.
+            //
+            // 2. Iterate until the right place for the first element is found. Then shift the
+            //    elements succeeding it to make room for it and finally place it into the
+            //    remaining hole. This is a good method.
+            //
+            // 3. Copy the first element into a temporary variable. Iterate until the right place
+            //    for it is found. As we go along, copy every traversed element into the slot
+            //    preceding it. Finally, copy data from the temporary variable into the remaining
+            //    hole. This method is very good. Benchmarks demonstrated slightly better
+            //    performance than with the 2nd method.
+            //
+            // All methods were benchmarked, and the 3rd showed best results. So we chose that one.
+            let tmp = mem::ManuallyDrop::new(ptr::read(&v[0]));
+
+            // Intermediate state of the insertion process is always tracked by `hole`, which
+            // serves two purposes:
+            // 1. Protects integrity of `v` from panics in `is_less`.
+            // 2. Fills the remaining hole in `v` in the end.
+            //
+            // Panic safety:
+            //
+            // If `is_less` panics at any point during the process, `hole` will get dropped and
+            // fill the hole in `v` with `tmp`, thus ensuring that `v` still holds every object it
+            // initially held exactly once.
+            let mut hole = InsertionHole { src: &*tmp, dest: &mut v[1] };
+            ptr::copy_nonoverlapping(&v[1], &mut v[0], 1);
+
+            for i in 2..v.len() {
+                if !is_less(&v[i], &*tmp) {
+                    break;
+                }
+                ptr::copy_nonoverlapping(&v[i], &mut v[i - 1], 1);
+                hole.dest = &mut v[i];
+            }
+            // `hole` gets dropped and thus copies `tmp` into the remaining hole in `v`.
+        }
+    }
+
+    // When dropped, copies from `src` into `dest`.
+    struct InsertionHole<T> {
+        src: *const T,
+        dest: *mut T,
+    }
+
+    impl<T> Drop for InsertionHole<T> {
+        fn drop(&mut self) {
+            unsafe {
+                ptr::copy_nonoverlapping(self.src, self.dest, 1);
+            }
+        }
+    }
+}
+
+/// Merges non-decreasing runs `v[..mid]` and `v[mid..]` using `buf` as temporary storage, and
+/// stores the result into `v[..]`.
+///
+/// # Safety
+///
+/// The two slices must be non-empty and `mid` must be in bounds. Buffer `buf` must be long enough
+/// to hold a copy of the shorter slice. Also, `T` must not be a zero-sized type.
+#[cfg(not(no_global_oom_handling))]
+unsafe fn merge<T, F>(v: &mut [T], mid: usize, buf: *mut T, is_less: &mut F)
+where
+    F: FnMut(&T, &T) -> bool,
+{
+    let len = v.len();
+    let v = v.as_mut_ptr();
+    let (v_mid, v_end) = unsafe { (v.add(mid), v.add(len)) };
+
+    // The merge process first copies the shorter run into `buf`. Then it traces the newly copied
+    // run and the longer run forwards (or backwards), comparing their next unconsumed elements and
+    // copying the lesser (or greater) one into `v`.
+    //
+    // As soon as the shorter run is fully consumed, the process is done. If the longer run gets
+    // consumed first, then we must copy whatever is left of the shorter run into the remaining
+    // hole in `v`.
+    //
+    // Intermediate state of the process is always tracked by `hole`, which serves two purposes:
+    // 1. Protects integrity of `v` from panics in `is_less`.
+    // 2. Fills the remaining hole in `v` if the longer run gets consumed first.
+    //
+    // Panic safety:
+    //
+    // If `is_less` panics at any point during the process, `hole` will get dropped and fill the
+    // hole in `v` with the unconsumed range in `buf`, thus ensuring that `v` still holds every
+    // object it initially held exactly once.
+    let mut hole;
+
+    if mid <= len - mid {
+        // The left run is shorter.
+        unsafe {
+            ptr::copy_nonoverlapping(v, buf, mid);
+            hole = MergeHole { start: buf, end: buf.add(mid), dest: v };
+        }
+
+        // Initially, these pointers point to the beginnings of their arrays.
+        let left = &mut hole.start;
+        let mut right = v_mid;
+        let out = &mut hole.dest;
+
+        while *left < hole.end && right < v_end {
+            // Consume the lesser side.
+            // If equal, prefer the left run to maintain stability.
+            unsafe {
+                let to_copy = if is_less(&*right, &**left) {
+                    get_and_increment(&mut right)
+                } else {
+                    get_and_increment(left)
+                };
+                ptr::copy_nonoverlapping(to_copy, get_and_increment(out), 1);
+            }
+        }
+    } else {
+        // The right run is shorter.
+        unsafe {
+            ptr::copy_nonoverlapping(v_mid, buf, len - mid);
+            hole = MergeHole { start: buf, end: buf.add(len - mid), dest: v_mid };
+        }
+
+        // Initially, these pointers point past the ends of their arrays.
+        let left = &mut hole.dest;
+        let right = &mut hole.end;
+        let mut out = v_end;
+
+        while v < *left && buf < *right {
+            // Consume the greater side.
+            // If equal, prefer the right run to maintain stability.
+            unsafe {
+                let to_copy = if is_less(&*right.offset(-1), &*left.offset(-1)) {
+                    decrement_and_get(left)
+                } else {
+                    decrement_and_get(right)
+                };
+                ptr::copy_nonoverlapping(to_copy, decrement_and_get(&mut out), 1);
+            }
+        }
+    }
+    // Finally, `hole` gets dropped. If the shorter run was not fully consumed, whatever remains of
+    // it will now be copied into the hole in `v`.
+
+    unsafe fn get_and_increment<T>(ptr: &mut *mut T) -> *mut T {
+        let old = *ptr;
+        *ptr = unsafe { ptr.offset(1) };
+        old
+    }
+
+    unsafe fn decrement_and_get<T>(ptr: &mut *mut T) -> *mut T {
+        *ptr = unsafe { ptr.offset(-1) };
+        *ptr
+    }
+
+    // When dropped, copies the range `start..end` into `dest..`.
+    struct MergeHole<T> {
+        start: *mut T,
+        end: *mut T,
+        dest: *mut T,
+    }
+
+    impl<T> Drop for MergeHole<T> {
+        fn drop(&mut self) {
+            // `T` is not a zero-sized type, and these are pointers into a slice's elements.
+            unsafe {
+                let len = self.end.sub_ptr(self.start);
+                ptr::copy_nonoverlapping(self.start, self.dest, len);
+            }
+        }
+    }
+}
+
+/// This merge sort borrows some (but not all) ideas from TimSort, which is described in detail
+/// [here](https://github.com/python/cpython/blob/main/Objects/listsort.txt).
+///
+/// The algorithm identifies strictly descending and non-descending subsequences, which are called
+/// natural runs. There is a stack of pending runs yet to be merged. Each newly found run is pushed
+/// onto the stack, and then some pairs of adjacent runs are merged until these two invariants are
+/// satisfied:
+///
+/// 1. for every `i` in `1..runs.len()`: `runs[i - 1].len > runs[i].len`
+/// 2. for every `i` in `2..runs.len()`: `runs[i - 2].len > runs[i - 1].len + runs[i].len`
+///
+/// The invariants ensure that the total running time is *O*(*n* \* log(*n*)) worst-case.
+#[cfg(not(no_global_oom_handling))]
+fn merge_sort<T, F>(v: &mut [T], mut is_less: F)
+where
+    F: FnMut(&T, &T) -> bool,
+{
+    // Slices of up to this length get sorted using insertion sort.
+    const MAX_INSERTION: usize = 20;
+    // Very short runs are extended using insertion sort to span at least this many elements.
+    const MIN_RUN: usize = 10;
+
+    // Sorting has no meaningful behavior on zero-sized types.
+    if size_of::<T>() == 0 {
+        return;
+    }
+
+    let len = v.len();
+
+    // Short arrays get sorted in-place via insertion sort to avoid allocations.
+    if len <= MAX_INSERTION {
+        if len >= 2 {
+            for i in (0..len - 1).rev() {
+                insert_head(&mut v[i..], &mut is_less);
+            }
+        }
+        return;
+    }
+
+    // Allocate a buffer to use as scratch memory. We keep the length 0 so we can keep in it
+    // shallow copies of the contents of `v` without risking the dtors running on copies if
+    // `is_less` panics. When merging two sorted runs, this buffer holds a copy of the shorter run,
+    // which will always have length at most `len / 2`.
+    let mut buf = Vec::with_capacity(len / 2);
+
+    // In order to identify natural runs in `v`, we traverse it backwards. That might seem like a
+    // strange decision, but consider the fact that merges more often go in the opposite direction
+    // (forwards). According to benchmarks, merging forwards is slightly faster than merging
+    // backwards. To conclude, identifying runs by traversing backwards improves performance.
+    let mut runs = vec![];
+    let mut end = len;
+    while end > 0 {
+        // Find the next natural run, and reverse it if it's strictly descending.
+        let mut start = end - 1;
+        if start > 0 {
+            start -= 1;
+            unsafe {
+                if is_less(v.get_unchecked(start + 1), v.get_unchecked(start)) {
+                    while start > 0 && is_less(v.get_unchecked(start), v.get_unchecked(start - 1)) {
+                        start -= 1;
+                    }
+                    v[start..end].reverse();
+                } else {
+                    while start > 0 && !is_less(v.get_unchecked(start), v.get_unchecked(start - 1))
+                    {
+                        start -= 1;
+                    }
+                }
+            }
+        }
+
+        // Insert some more elements into the run if it's too short. Insertion sort is faster than
+        // merge sort on short sequences, so this significantly improves performance.
+        while start > 0 && end - start < MIN_RUN {
+            start -= 1;
+            insert_head(&mut v[start..end], &mut is_less);
+        }
+
+        // Push this run onto the stack.
+        runs.push(Run { start, len: end - start });
+        end = start;
+
+        // Merge some pairs of adjacent runs to satisfy the invariants.
+        while let Some(r) = collapse(&runs) {
+            let left = runs[r + 1];
+            let right = runs[r];
+            unsafe {
+                merge(
+                    &mut v[left.start..right.start + right.len],
+                    left.len,
+                    buf.as_mut_ptr(),
+                    &mut is_less,
+                );
+            }
+            runs[r] = Run { start: left.start, len: left.len + right.len };
+            runs.remove(r + 1);
+        }
+    }
+
+    // Finally, exactly one run must remain in the stack.
+    debug_assert!(runs.len() == 1 && runs[0].start == 0 && runs[0].len == len);
+
+    // Examines the stack of runs and identifies the next pair of runs to merge. More specifically,
+    // if `Some(r)` is returned, that means `runs[r]` and `runs[r + 1]` must be merged next. If the
+    // algorithm should continue building a new run instead, `None` is returned.
+    //
+    // TimSort is infamous for its buggy implementations, as described here:
+    // http://envisage-project.eu/timsort-specification-and-verification/
+    //
+    // The gist of the story is: we must enforce the invariants on the top four runs on the stack.
+    // Enforcing them on just top three is not sufficient to ensure that the invariants will still
+    // hold for *all* runs in the stack.
+    //
+    // This function correctly checks invariants for the top four runs. Additionally, if the top
+    // run starts at index 0, it will always demand a merge operation until the stack is fully
+    // collapsed, in order to complete the sort.
+    #[inline]
+    fn collapse(runs: &[Run]) -> Option<usize> {
+        let n = runs.len();
+        if n >= 2
+            && (runs[n - 1].start == 0
+                || runs[n - 2].len <= runs[n - 1].len
+                || (n >= 3 && runs[n - 3].len <= runs[n - 2].len + runs[n - 1].len)
+                || (n >= 4 && runs[n - 4].len <= runs[n - 3].len + runs[n - 2].len))
+        {
+            if n >= 3 && runs[n - 3].len < runs[n - 1].len { Some(n - 3) } else { Some(n - 2) }
+        } else {
+            None
+        }
+    }
+
+    #[derive(Clone, Copy)]
+    struct Run {
+        start: usize,
+        len: usize,
+    }
+}
diff --git a/rust/alloc/vec/drain.rs b/rust/alloc/vec/drain.rs
new file mode 100644
index 000000000000..5cdee0bd4da4
--- /dev/null
+++ b/rust/alloc/vec/drain.rs
@@ -0,0 +1,184 @@
+use crate::alloc::{Allocator, Global};
+use core::fmt;
+use core::iter::{FusedIterator, TrustedLen};
+use core::mem;
+use core::ptr::{self, NonNull};
+use core::slice::{self};
+
+use super::Vec;
+
+/// A draining iterator for `Vec<T>`.
+///
+/// This `struct` is created by [`Vec::drain`].
+/// See its documentation for more.
+///
+/// # Example
+///
+/// ```
+/// let mut v = vec![0, 1, 2];
+/// let iter: std::vec::Drain<_> = v.drain(..);
+/// ```
+#[stable(feature = "drain", since = "1.6.0")]
+pub struct Drain<
+    'a,
+    T: 'a,
+    #[unstable(feature = "allocator_api", issue = "32838")] A: Allocator + 'a = Global,
+> {
+    /// Index of tail to preserve
+    pub(super) tail_start: usize,
+    /// Length of tail
+    pub(super) tail_len: usize,
+    /// Current remaining range to remove
+    pub(super) iter: slice::Iter<'a, T>,
+    pub(super) vec: NonNull<Vec<T, A>>,
+}
+
+#[stable(feature = "collection_debug", since = "1.17.0")]
+impl<T: fmt::Debug, A: Allocator> fmt::Debug for Drain<'_, T, A> {
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
+        f.debug_tuple("Drain").field(&self.iter.as_slice()).finish()
+    }
+}
+
+impl<'a, T, A: Allocator> Drain<'a, T, A> {
+    /// Returns the remaining items of this iterator as a slice.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let mut vec = vec!['a', 'b', 'c'];
+    /// let mut drain = vec.drain(..);
+    /// assert_eq!(drain.as_slice(), &['a', 'b', 'c']);
+    /// let _ = drain.next().unwrap();
+    /// assert_eq!(drain.as_slice(), &['b', 'c']);
+    /// ```
+    #[must_use]
+    #[stable(feature = "vec_drain_as_slice", since = "1.46.0")]
+    pub fn as_slice(&self) -> &[T] {
+        self.iter.as_slice()
+    }
+
+    /// Returns a reference to the underlying allocator.
+    #[unstable(feature = "allocator_api", issue = "32838")]
+    #[must_use]
+    #[inline]
+    pub fn allocator(&self) -> &A {
+        unsafe { self.vec.as_ref().allocator() }
+    }
+}
+
+#[stable(feature = "vec_drain_as_slice", since = "1.46.0")]
+impl<'a, T, A: Allocator> AsRef<[T]> for Drain<'a, T, A> {
+    fn as_ref(&self) -> &[T] {
+        self.as_slice()
+    }
+}
+
+#[stable(feature = "drain", since = "1.6.0")]
+unsafe impl<T: Sync, A: Sync + Allocator> Sync for Drain<'_, T, A> {}
+#[stable(feature = "drain", since = "1.6.0")]
+unsafe impl<T: Send, A: Send + Allocator> Send for Drain<'_, T, A> {}
+
+#[stable(feature = "drain", since = "1.6.0")]
+impl<T, A: Allocator> Iterator for Drain<'_, T, A> {
+    type Item = T;
+
+    #[inline]
+    fn next(&mut self) -> Option<T> {
+        self.iter.next().map(|elt| unsafe { ptr::read(elt as *const _) })
+    }
+
+    fn size_hint(&self) -> (usize, Option<usize>) {
+        self.iter.size_hint()
+    }
+}
+
+#[stable(feature = "drain", since = "1.6.0")]
+impl<T, A: Allocator> DoubleEndedIterator for Drain<'_, T, A> {
+    #[inline]
+    fn next_back(&mut self) -> Option<T> {
+        self.iter.next_back().map(|elt| unsafe { ptr::read(elt as *const _) })
+    }
+}
+
+#[stable(feature = "drain", since = "1.6.0")]
+impl<T, A: Allocator> Drop for Drain<'_, T, A> {
+    fn drop(&mut self) {
+        /// Moves back the un-`Drain`ed elements to restore the original `Vec`.
+        struct DropGuard<'r, 'a, T, A: Allocator>(&'r mut Drain<'a, T, A>);
+
+        impl<'r, 'a, T, A: Allocator> Drop for DropGuard<'r, 'a, T, A> {
+            fn drop(&mut self) {
+                if self.0.tail_len > 0 {
+                    unsafe {
+                        let source_vec = self.0.vec.as_mut();
+                        // memmove back untouched tail, update to new length
+                        let start = source_vec.len();
+                        let tail = self.0.tail_start;
+                        if tail != start {
+                            let src = source_vec.as_ptr().add(tail);
+                            let dst = source_vec.as_mut_ptr().add(start);
+                            ptr::copy(src, dst, self.0.tail_len);
+                        }
+                        source_vec.set_len(start + self.0.tail_len);
+                    }
+                }
+            }
+        }
+
+        let iter = mem::replace(&mut self.iter, (&mut []).iter());
+        let drop_len = iter.len();
+
+        let mut vec = self.vec;
+
+        if mem::size_of::<T>() == 0 {
+            // ZSTs have no identity, so we don't need to move them around, we only need to drop the correct amount.
+            // this can be achieved by manipulating the Vec length instead of moving values out from `iter`.
+            unsafe {
+                let vec = vec.as_mut();
+                let old_len = vec.len();
+                vec.set_len(old_len + drop_len + self.tail_len);
+                vec.truncate(old_len + self.tail_len);
+            }
+
+            return;
+        }
+
+        // ensure elements are moved back into their appropriate places, even when drop_in_place panics
+        let _guard = DropGuard(self);
+
+        if drop_len == 0 {
+            return;
+        }
+
+        // as_slice() must only be called when iter.len() is > 0 because
+        // vec::Splice modifies vec::Drain fields and may grow the vec which would invalidate
+        // the iterator's internal pointers. Creating a reference to deallocated memory
+        // is invalid even when it is zero-length
+        let drop_ptr = iter.as_slice().as_ptr();
+
+        unsafe {
+            // drop_ptr comes from a slice::Iter which only gives us a &[T] but for drop_in_place
+            // a pointer with mutable provenance is necessary. Therefore we must reconstruct
+            // it from the original vec but also avoid creating a &mut to the front since that could
+            // invalidate raw pointers to it which some unsafe code might rely on.
+            let vec_ptr = vec.as_mut().as_mut_ptr();
+            let drop_offset = drop_ptr.sub_ptr(vec_ptr);
+            let to_drop = ptr::slice_from_raw_parts_mut(vec_ptr.add(drop_offset), drop_len);
+            ptr::drop_in_place(to_drop);
+        }
+    }
+}
+
+#[stable(feature = "drain", since = "1.6.0")]
+impl<T, A: Allocator> ExactSizeIterator for Drain<'_, T, A> {
+    fn is_empty(&self) -> bool {
+        self.iter.is_empty()
+    }
+}
+
+#[unstable(feature = "trusted_len", issue = "37572")]
+unsafe impl<T, A: Allocator> TrustedLen for Drain<'_, T, A> {}
+
+#[stable(feature = "fused", since = "1.26.0")]
+impl<T, A: Allocator> FusedIterator for Drain<'_, T, A> {}
diff --git a/rust/alloc/vec/drain_filter.rs b/rust/alloc/vec/drain_filter.rs
new file mode 100644
index 000000000000..3c37c92ae44b
--- /dev/null
+++ b/rust/alloc/vec/drain_filter.rs
@@ -0,0 +1,143 @@
+use crate::alloc::{Allocator, Global};
+use core::ptr::{self};
+use core::slice::{self};
+
+use super::Vec;
+
+/// An iterator which uses a closure to determine if an element should be removed.
+///
+/// This struct is created by [`Vec::drain_filter`].
+/// See its documentation for more.
+///
+/// # Example
+///
+/// ```
+/// #![feature(drain_filter)]
+///
+/// let mut v = vec![0, 1, 2];
+/// let iter: std::vec::DrainFilter<_, _> = v.drain_filter(|x| *x % 2 == 0);
+/// ```
+#[unstable(feature = "drain_filter", reason = "recently added", issue = "43244")]
+#[derive(Debug)]
+pub struct DrainFilter<
+    'a,
+    T,
+    F,
+    #[unstable(feature = "allocator_api", issue = "32838")] A: Allocator = Global,
+> where
+    F: FnMut(&mut T) -> bool,
+{
+    pub(super) vec: &'a mut Vec<T, A>,
+    /// The index of the item that will be inspected by the next call to `next`.
+    pub(super) idx: usize,
+    /// The number of items that have been drained (removed) thus far.
+    pub(super) del: usize,
+    /// The original length of `vec` prior to draining.
+    pub(super) old_len: usize,
+    /// The filter test predicate.
+    pub(super) pred: F,
+    /// A flag that indicates a panic has occurred in the filter test predicate.
+    /// This is used as a hint in the drop implementation to prevent consumption
+    /// of the remainder of the `DrainFilter`. Any unprocessed items will be
+    /// backshifted in the `vec`, but no further items will be dropped or
+    /// tested by the filter predicate.
+    pub(super) panic_flag: bool,
+}
+
+impl<T, F, A: Allocator> DrainFilter<'_, T, F, A>
+where
+    F: FnMut(&mut T) -> bool,
+{
+    /// Returns a reference to the underlying allocator.
+    #[unstable(feature = "allocator_api", issue = "32838")]
+    #[inline]
+    pub fn allocator(&self) -> &A {
+        self.vec.allocator()
+    }
+}
+
+#[unstable(feature = "drain_filter", reason = "recently added", issue = "43244")]
+impl<T, F, A: Allocator> Iterator for DrainFilter<'_, T, F, A>
+where
+    F: FnMut(&mut T) -> bool,
+{
+    type Item = T;
+
+    fn next(&mut self) -> Option<T> {
+        unsafe {
+            while self.idx < self.old_len {
+                let i = self.idx;
+                let v = slice::from_raw_parts_mut(self.vec.as_mut_ptr(), self.old_len);
+                self.panic_flag = true;
+                let drained = (self.pred)(&mut v[i]);
+                self.panic_flag = false;
+                // Update the index *after* the predicate is called. If the index
+                // is updated prior and the predicate panics, the element at this
+                // index would be leaked.
+                self.idx += 1;
+                if drained {
+                    self.del += 1;
+                    return Some(ptr::read(&v[i]));
+                } else if self.del > 0 {
+                    let del = self.del;
+                    let src: *const T = &v[i];
+                    let dst: *mut T = &mut v[i - del];
+                    ptr::copy_nonoverlapping(src, dst, 1);
+                }
+            }
+            None
+        }
+    }
+
+    fn size_hint(&self) -> (usize, Option<usize>) {
+        (0, Some(self.old_len - self.idx))
+    }
+}
+
+#[unstable(feature = "drain_filter", reason = "recently added", issue = "43244")]
+impl<T, F, A: Allocator> Drop for DrainFilter<'_, T, F, A>
+where
+    F: FnMut(&mut T) -> bool,
+{
+    fn drop(&mut self) {
+        struct BackshiftOnDrop<'a, 'b, T, F, A: Allocator>
+        where
+            F: FnMut(&mut T) -> bool,
+        {
+            drain: &'b mut DrainFilter<'a, T, F, A>,
+        }
+
+        impl<'a, 'b, T, F, A: Allocator> Drop for BackshiftOnDrop<'a, 'b, T, F, A>
+        where
+            F: FnMut(&mut T) -> bool,
+        {
+            fn drop(&mut self) {
+                unsafe {
+                    if self.drain.idx < self.drain.old_len && self.drain.del > 0 {
+                        // This is a pretty messed up state, and there isn't really an
+                        // obviously right thing to do. We don't want to keep trying
+                        // to execute `pred`, so we just backshift all the unprocessed
+                        // elements and tell the vec that they still exist. The backshift
+                        // is required to prevent a double-drop of the last successfully
+                        // drained item prior to a panic in the predicate.
+                        let ptr = self.drain.vec.as_mut_ptr();
+                        let src = ptr.add(self.drain.idx);
+                        let dst = src.sub(self.drain.del);
+                        let tail_len = self.drain.old_len - self.drain.idx;
+                        src.copy_to(dst, tail_len);
+                    }
+                    self.drain.vec.set_len(self.drain.old_len - self.drain.del);
+                }
+            }
+        }
+
+        let backshift = BackshiftOnDrop { drain: self };
+
+        // Attempt to consume any remaining elements if the filter predicate
+        // has not yet panicked. We'll backshift any remaining elements
+        // whether we've already panicked or if the consumption here panics.
+        if !backshift.drain.panic_flag {
+            backshift.drain.for_each(drop);
+        }
+    }
+}
diff --git a/rust/alloc/vec/into_iter.rs b/rust/alloc/vec/into_iter.rs
new file mode 100644
index 000000000000..9b84a1d9b4b6
--- /dev/null
+++ b/rust/alloc/vec/into_iter.rs
@@ -0,0 +1,362 @@
+#[cfg(not(no_global_oom_handling))]
+use super::AsVecIntoIter;
+use crate::alloc::{Allocator, Global};
+use crate::raw_vec::RawVec;
+use core::fmt;
+use core::intrinsics::arith_offset;
+use core::iter::{
+    FusedIterator, InPlaceIterable, SourceIter, TrustedLen, TrustedRandomAccessNoCoerce,
+};
+use core::marker::PhantomData;
+use core::mem::{self, ManuallyDrop};
+use core::ops::Deref;
+use core::ptr::{self, NonNull};
+use core::slice::{self};
+
+/// An iterator that moves out of a vector.
+///
+/// This `struct` is created by the `into_iter` method on [`Vec`](super::Vec)
+/// (provided by the [`IntoIterator`] trait).
+///
+/// # Example
+///
+/// ```
+/// let v = vec![0, 1, 2];
+/// let iter: std::vec::IntoIter<_> = v.into_iter();
+/// ```
+#[stable(feature = "rust1", since = "1.0.0")]
+#[rustc_insignificant_dtor]
+pub struct IntoIter<
+    T,
+    #[unstable(feature = "allocator_api", issue = "32838")] A: Allocator = Global,
+> {
+    pub(super) buf: NonNull<T>,
+    pub(super) phantom: PhantomData<T>,
+    pub(super) cap: usize,
+    // the drop impl reconstructs a RawVec from buf, cap and alloc
+    // to avoid dropping the allocator twice we need to wrap it into ManuallyDrop
+    pub(super) alloc: ManuallyDrop<A>,
+    pub(super) ptr: *const T,
+    pub(super) end: *const T,
+}
+
+#[stable(feature = "vec_intoiter_debug", since = "1.13.0")]
+impl<T: fmt::Debug, A: Allocator> fmt::Debug for IntoIter<T, A> {
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
+        f.debug_tuple("IntoIter").field(&self.as_slice()).finish()
+    }
+}
+
+impl<T, A: Allocator> IntoIter<T, A> {
+    /// Returns the remaining items of this iterator as a slice.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let vec = vec!['a', 'b', 'c'];
+    /// let mut into_iter = vec.into_iter();
+    /// assert_eq!(into_iter.as_slice(), &['a', 'b', 'c']);
+    /// let _ = into_iter.next().unwrap();
+    /// assert_eq!(into_iter.as_slice(), &['b', 'c']);
+    /// ```
+    #[stable(feature = "vec_into_iter_as_slice", since = "1.15.0")]
+    pub fn as_slice(&self) -> &[T] {
+        unsafe { slice::from_raw_parts(self.ptr, self.len()) }
+    }
+
+    /// Returns the remaining items of this iterator as a mutable slice.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let vec = vec!['a', 'b', 'c'];
+    /// let mut into_iter = vec.into_iter();
+    /// assert_eq!(into_iter.as_slice(), &['a', 'b', 'c']);
+    /// into_iter.as_mut_slice()[2] = 'z';
+    /// assert_eq!(into_iter.next().unwrap(), 'a');
+    /// assert_eq!(into_iter.next().unwrap(), 'b');
+    /// assert_eq!(into_iter.next().unwrap(), 'z');
+    /// ```
+    #[stable(feature = "vec_into_iter_as_slice", since = "1.15.0")]
+    pub fn as_mut_slice(&mut self) -> &mut [T] {
+        unsafe { &mut *self.as_raw_mut_slice() }
+    }
+
+    /// Returns a reference to the underlying allocator.
+    #[unstable(feature = "allocator_api", issue = "32838")]
+    #[inline]
+    pub fn allocator(&self) -> &A {
+        &self.alloc
+    }
+
+    fn as_raw_mut_slice(&mut self) -> *mut [T] {
+        ptr::slice_from_raw_parts_mut(self.ptr as *mut T, self.len())
+    }
+
+    /// Drops remaining elements and relinquishes the backing allocation.
+    ///
+    /// This is roughly equivalent to the following, but more efficient
+    ///
+    /// ```
+    /// # let mut into_iter = Vec::<u8>::with_capacity(10).into_iter();
+    /// (&mut into_iter).for_each(core::mem::drop);
+    /// unsafe { core::ptr::write(&mut into_iter, Vec::new().into_iter()); }
+    /// ```
+    ///
+    /// This method is used by in-place iteration, refer to the vec::in_place_collect
+    /// documentation for an overview.
+    #[cfg(not(no_global_oom_handling))]
+    pub(super) fn forget_allocation_drop_remaining(&mut self) {
+        let remaining = self.as_raw_mut_slice();
+
+        // overwrite the individual fields instead of creating a new
+        // struct and then overwriting &mut self.
+        // this creates less assembly
+        self.cap = 0;
+        self.buf = unsafe { NonNull::new_unchecked(RawVec::NEW.ptr()) };
+        self.ptr = self.buf.as_ptr();
+        self.end = self.buf.as_ptr();
+
+        unsafe {
+            ptr::drop_in_place(remaining);
+        }
+    }
+
+    /// Forgets to Drop the remaining elements while still allowing the backing allocation to be freed.
+    pub(crate) fn forget_remaining_elements(&mut self) {
+        self.ptr = self.end;
+    }
+}
+
+#[stable(feature = "vec_intoiter_as_ref", since = "1.46.0")]
+impl<T, A: Allocator> AsRef<[T]> for IntoIter<T, A> {
+    fn as_ref(&self) -> &[T] {
+        self.as_slice()
+    }
+}
+
+#[stable(feature = "rust1", since = "1.0.0")]
+unsafe impl<T: Send, A: Allocator + Send> Send for IntoIter<T, A> {}
+#[stable(feature = "rust1", since = "1.0.0")]
+unsafe impl<T: Sync, A: Allocator + Sync> Sync for IntoIter<T, A> {}
+
+#[stable(feature = "rust1", since = "1.0.0")]
+impl<T, A: Allocator> Iterator for IntoIter<T, A> {
+    type Item = T;
+
+    #[inline]
+    fn next(&mut self) -> Option<T> {
+        if self.ptr as *const _ == self.end {
+            None
+        } else if mem::size_of::<T>() == 0 {
+            // purposefully don't use 'ptr.offset' because for
+            // vectors with 0-size elements this would return the
+            // same pointer.
+            self.ptr = unsafe { arith_offset(self.ptr as *const i8, 1) as *mut T };
+
+            // Make up a value of this ZST.
+            Some(unsafe { mem::zeroed() })
+        } else {
+            let old = self.ptr;
+            self.ptr = unsafe { self.ptr.offset(1) };
+
+            Some(unsafe { ptr::read(old) })
+        }
+    }
+
+    #[inline]
+    fn size_hint(&self) -> (usize, Option<usize>) {
+        let exact = if mem::size_of::<T>() == 0 {
+            self.end.addr().wrapping_sub(self.ptr.addr())
+        } else {
+            unsafe { self.end.sub_ptr(self.ptr) }
+        };
+        (exact, Some(exact))
+    }
+
+    #[inline]
+    fn advance_by(&mut self, n: usize) -> Result<(), usize> {
+        let step_size = self.len().min(n);
+        let to_drop = ptr::slice_from_raw_parts_mut(self.ptr as *mut T, step_size);
+        if mem::size_of::<T>() == 0 {
+            // SAFETY: due to unchecked casts of unsigned amounts to signed offsets the wraparound
+            // effectively results in unsigned pointers representing positions 0..usize::MAX,
+            // which is valid for ZSTs.
+            self.ptr = unsafe { arith_offset(self.ptr as *const i8, step_size as isize) as *mut T }
+        } else {
+            // SAFETY: the min() above ensures that step_size is in bounds
+            self.ptr = unsafe { self.ptr.add(step_size) };
+        }
+        // SAFETY: the min() above ensures that step_size is in bounds
+        unsafe {
+            ptr::drop_in_place(to_drop);
+        }
+        if step_size < n {
+            return Err(step_size);
+        }
+        Ok(())
+    }
+
+    #[inline]
+    fn count(self) -> usize {
+        self.len()
+    }
+
+    unsafe fn __iterator_get_unchecked(&mut self, i: usize) -> Self::Item
+    where
+        Self: TrustedRandomAccessNoCoerce,
+    {
+        // SAFETY: the caller must guarantee that `i` is in bounds of the
+        // `Vec<T>`, so `i` cannot overflow an `isize`, and the `self.ptr.add(i)`
+        // is guaranteed to pointer to an element of the `Vec<T>` and
+        // thus guaranteed to be valid to dereference.
+        //
+        // Also note the implementation of `Self: TrustedRandomAccess` requires
+        // that `T: Copy` so reading elements from the buffer doesn't invalidate
+        // them for `Drop`.
+        unsafe {
+            if mem::size_of::<T>() == 0 { mem::zeroed() } else { ptr::read(self.ptr.add(i)) }
+        }
+    }
+}
+
+#[stable(feature = "rust1", since = "1.0.0")]
+impl<T, A: Allocator> DoubleEndedIterator for IntoIter<T, A> {
+    #[inline]
+    fn next_back(&mut self) -> Option<T> {
+        if self.end == self.ptr {
+            None
+        } else if mem::size_of::<T>() == 0 {
+            // See above for why 'ptr.offset' isn't used
+            self.end = unsafe { arith_offset(self.end as *const i8, -1) as *mut T };
+
+            // Make up a value of this ZST.
+            Some(unsafe { mem::zeroed() })
+        } else {
+            self.end = unsafe { self.end.offset(-1) };
+
+            Some(unsafe { ptr::read(self.end) })
+        }
+    }
+
+    #[inline]
+    fn advance_back_by(&mut self, n: usize) -> Result<(), usize> {
+        let step_size = self.len().min(n);
+        if mem::size_of::<T>() == 0 {
+            // SAFETY: same as for advance_by()
+            self.end = unsafe {
+                arith_offset(self.end as *const i8, step_size.wrapping_neg() as isize) as *mut T
+            }
+        } else {
+            // SAFETY: same as for advance_by()
+            self.end = unsafe { self.end.offset(step_size.wrapping_neg() as isize) };
+        }
+        let to_drop = ptr::slice_from_raw_parts_mut(self.end as *mut T, step_size);
+        // SAFETY: same as for advance_by()
+        unsafe {
+            ptr::drop_in_place(to_drop);
+        }
+        if step_size < n {
+            return Err(step_size);
+        }
+        Ok(())
+    }
+}
+
+#[stable(feature = "rust1", since = "1.0.0")]
+impl<T, A: Allocator> ExactSizeIterator for IntoIter<T, A> {
+    fn is_empty(&self) -> bool {
+        self.ptr == self.end
+    }
+}
+
+#[stable(feature = "fused", since = "1.26.0")]
+impl<T, A: Allocator> FusedIterator for IntoIter<T, A> {}
+
+#[unstable(feature = "trusted_len", issue = "37572")]
+unsafe impl<T, A: Allocator> TrustedLen for IntoIter<T, A> {}
+
+#[doc(hidden)]
+#[unstable(issue = "none", feature = "std_internals")]
+#[rustc_unsafe_specialization_marker]
+pub trait NonDrop {}
+
+// T: Copy as approximation for !Drop since get_unchecked does not advance self.ptr
+// and thus we can't implement drop-handling
+#[unstable(issue = "none", feature = "std_internals")]
+impl<T: Copy> NonDrop for T {}
+
+#[doc(hidden)]
+#[unstable(issue = "none", feature = "std_internals")]
+// TrustedRandomAccess (without NoCoerce) must not be implemented because
+// subtypes/supertypes of `T` might not be `NonDrop`
+unsafe impl<T, A: Allocator> TrustedRandomAccessNoCoerce for IntoIter<T, A>
+where
+    T: NonDrop,
+{
+    const MAY_HAVE_SIDE_EFFECT: bool = false;
+}
+
+#[cfg(not(no_global_oom_handling))]
+#[stable(feature = "vec_into_iter_clone", since = "1.8.0")]
+impl<T: Clone, A: Allocator + Clone> Clone for IntoIter<T, A> {
+    #[cfg(not(test))]
+    fn clone(&self) -> Self {
+        self.as_slice().to_vec_in(self.alloc.deref().clone()).into_iter()
+    }
+    #[cfg(test)]
+    fn clone(&self) -> Self {
+        crate::slice::to_vec(self.as_slice(), self.alloc.deref().clone()).into_iter()
+    }
+}
+
+#[stable(feature = "rust1", since = "1.0.0")]
+unsafe impl<#[may_dangle] T, A: Allocator> Drop for IntoIter<T, A> {
+    fn drop(&mut self) {
+        struct DropGuard<'a, T, A: Allocator>(&'a mut IntoIter<T, A>);
+
+        impl<T, A: Allocator> Drop for DropGuard<'_, T, A> {
+            fn drop(&mut self) {
+                unsafe {
+                    // `IntoIter::alloc` is not used anymore after this and will be dropped by RawVec
+                    let alloc = ManuallyDrop::take(&mut self.0.alloc);
+                    // RawVec handles deallocation
+                    let _ = RawVec::from_raw_parts_in(self.0.buf.as_ptr(), self.0.cap, alloc);
+                }
+            }
+        }
+
+        let guard = DropGuard(self);
+        // destroy the remaining elements
+        unsafe {
+            ptr::drop_in_place(guard.0.as_raw_mut_slice());
+        }
+        // now `guard` will be dropped and do the rest
+    }
+}
+
+// In addition to the SAFETY invariants of the following three unsafe traits
+// also refer to the vec::in_place_collect module documentation to get an overview
+#[unstable(issue = "none", feature = "inplace_iteration")]
+#[doc(hidden)]
+unsafe impl<T, A: Allocator> InPlaceIterable for IntoIter<T, A> {}
+
+#[unstable(issue = "none", feature = "inplace_iteration")]
+#[doc(hidden)]
+unsafe impl<T, A: Allocator> SourceIter for IntoIter<T, A> {
+    type Source = Self;
+
+    #[inline]
+    unsafe fn as_inner(&mut self) -> &mut Self::Source {
+        self
+    }
+}
+
+#[cfg(not(no_global_oom_handling))]
+unsafe impl<T> AsVecIntoIter for IntoIter<T> {
+    type Item = T;
+
+    fn as_into_iter(&mut self) -> &mut IntoIter<Self::Item> {
+        self
+    }
+}
diff --git a/rust/alloc/vec/is_zero.rs b/rust/alloc/vec/is_zero.rs
new file mode 100644
index 000000000000..edf270db81d4
--- /dev/null
+++ b/rust/alloc/vec/is_zero.rs
@@ -0,0 +1,118 @@
+use crate::boxed::Box;
+
+#[rustc_specialization_trait]
+pub(super) unsafe trait IsZero {
+    /// Whether this value's representation is all zeros
+    fn is_zero(&self) -> bool;
+}
+
+macro_rules! impl_is_zero {
+    ($t:ty, $is_zero:expr) => {
+        unsafe impl IsZero for $t {
+            #[inline]
+            fn is_zero(&self) -> bool {
+                $is_zero(*self)
+            }
+        }
+    };
+}
+
+impl_is_zero!(i16, |x| x == 0);
+impl_is_zero!(i32, |x| x == 0);
+impl_is_zero!(i64, |x| x == 0);
+impl_is_zero!(i128, |x| x == 0);
+impl_is_zero!(isize, |x| x == 0);
+
+impl_is_zero!(u16, |x| x == 0);
+impl_is_zero!(u32, |x| x == 0);
+impl_is_zero!(u64, |x| x == 0);
+impl_is_zero!(u128, |x| x == 0);
+impl_is_zero!(usize, |x| x == 0);
+
+impl_is_zero!(bool, |x| x == false);
+impl_is_zero!(char, |x| x == '\0');
+
+impl_is_zero!(f32, |x: f32| x.to_bits() == 0);
+impl_is_zero!(f64, |x: f64| x.to_bits() == 0);
+
+unsafe impl<T> IsZero for *const T {
+    #[inline]
+    fn is_zero(&self) -> bool {
+        (*self).is_null()
+    }
+}
+
+unsafe impl<T> IsZero for *mut T {
+    #[inline]
+    fn is_zero(&self) -> bool {
+        (*self).is_null()
+    }
+}
+
+unsafe impl<T: IsZero, const N: usize> IsZero for [T; N] {
+    #[inline]
+    fn is_zero(&self) -> bool {
+        // Because this is generated as a runtime check, it's not obvious that
+        // it's worth doing if the array is really long.  The threshold here
+        // is largely arbitrary, but was picked because as of 2022-05-01 LLVM
+        // can const-fold the check in `vec![[0; 32]; n]` but not in
+        // `vec![[0; 64]; n]`: https://godbolt.org/z/WTzjzfs5b
+        // Feel free to tweak if you have better evidence.
+
+        N <= 32 && self.iter().all(IsZero::is_zero)
+    }
+}
+
+// `Option<&T>` and `Option<Box<T>>` are guaranteed to represent `None` as null.
+// For fat pointers, the bytes that would be the pointer metadata in the `Some`
+// variant are padding in the `None` variant, so ignoring them and
+// zero-initializing instead is ok.
+// `Option<&mut T>` never implements `Clone`, so there's no need for an impl of
+// `SpecFromElem`.
+
+unsafe impl<T: ?Sized> IsZero for Option<&T> {
+    #[inline]
+    fn is_zero(&self) -> bool {
+        self.is_none()
+    }
+}
+
+unsafe impl<T: ?Sized> IsZero for Option<Box<T>> {
+    #[inline]
+    fn is_zero(&self) -> bool {
+        self.is_none()
+    }
+}
+
+// `Option<num::NonZeroU32>` and similar have a representation guarantee that
+// they're the same size as the corresponding `u32` type, as well as a guarantee
+// that transmuting between `NonZeroU32` and `Option<num::NonZeroU32>` works.
+// While the documentation officially makes it UB to transmute from `None`,
+// we're the standard library so we can make extra inferences, and we know that
+// the only niche available to represent `None` is the one that's all zeros.
+
+macro_rules! impl_is_zero_option_of_nonzero {
+    ($($t:ident,)+) => {$(
+        unsafe impl IsZero for Option<core::num::$t> {
+            #[inline]
+            fn is_zero(&self) -> bool {
+                self.is_none()
+            }
+        }
+    )+};
+}
+
+impl_is_zero_option_of_nonzero!(
+    NonZeroU8,
+    NonZeroU16,
+    NonZeroU32,
+    NonZeroU64,
+    NonZeroU128,
+    NonZeroI8,
+    NonZeroI16,
+    NonZeroI32,
+    NonZeroI64,
+    NonZeroI128,
+    NonZeroUsize,
+    NonZeroIsize,
+);
diff --git a/rust/alloc/vec/mod.rs b/rust/alloc/vec/mod.rs
new file mode 100644
index 000000000000..3dc8a4fbba86
--- /dev/null
+++ b/rust/alloc/vec/mod.rs
@@ -0,0 +1,3115 @@
+//! A contiguous growable array type with heap-allocated contents, written
+//! `Vec<T>`.
+//!
+//! Vectors have *O*(1) indexing, amortized *O*(1) push (to the end) and
+//! *O*(1) pop (from the end).
+//!
+//! Vectors ensure they never allocate more than `isize::MAX` bytes.
+//!
+//! # Examples
+//!
+//! You can explicitly create a [`Vec`] with [`Vec::new`]:
+//!
+//! ```
+//! let v: Vec<i32> = Vec::new();
+//! ```
+//!
+//! ...or by using the [`vec!`] macro:
+//!
+//! ```
+//! let v: Vec<i32> = vec![];
+//!
+//! let v = vec![1, 2, 3, 4, 5];
+//!
+//! let v = vec![0; 10]; // ten zeroes
+//! ```
+//!
+//! You can [`push`] values onto the end of a vector (which will grow the vector
+//! as needed):
+//!
+//! ```
+//! let mut v = vec![1, 2];
+//!
+//! v.push(3);
+//! ```
+//!
+//! Popping values works in much the same way:
+//!
+//! ```
+//! let mut v = vec![1, 2];
+//!
+//! let two = v.pop();
+//! ```
+//!
+//! Vectors also support indexing (through the [`Index`] and [`IndexMut`] traits):
+//!
+//! ```
+//! let mut v = vec![1, 2, 3];
+//! let three = v[2];
+//! v[1] = v[1] + 5;
+//! ```
+//!
+//! [`push`]: Vec::push
+
+#![stable(feature = "rust1", since = "1.0.0")]
+
+#[cfg(not(no_global_oom_handling))]
+use core::cmp;
+use core::cmp::Ordering;
+use core::convert::TryFrom;
+use core::fmt;
+use core::hash::{Hash, Hasher};
+use core::intrinsics::{arith_offset, assume};
+use core::iter;
+#[cfg(not(no_global_oom_handling))]
+use core::iter::FromIterator;
+use core::marker::PhantomData;
+use core::mem::{self, ManuallyDrop, MaybeUninit};
+use core::ops::{self, Index, IndexMut, Range, RangeBounds};
+use core::ptr::{self, NonNull};
+use core::slice::{self, SliceIndex};
+
+use crate::alloc::{Allocator, Global};
+use crate::borrow::{Cow, ToOwned};
+use crate::boxed::Box;
+use crate::collections::TryReserveError;
+use crate::raw_vec::RawVec;
+
+#[unstable(feature = "drain_filter", reason = "recently added", issue = "43244")]
+pub use self::drain_filter::DrainFilter;
+
+mod drain_filter;
+
+#[cfg(not(no_global_oom_handling))]
+#[stable(feature = "vec_splice", since = "1.21.0")]
+pub use self::splice::Splice;
+
+#[cfg(not(no_global_oom_handling))]
+mod splice;
+
+#[stable(feature = "drain", since = "1.6.0")]
+pub use self::drain::Drain;
+
+mod drain;
+
+#[cfg(not(no_global_oom_handling))]
+mod cow;
+
+#[cfg(not(no_global_oom_handling))]
+pub(crate) use self::in_place_collect::AsVecIntoIter;
+#[stable(feature = "rust1", since = "1.0.0")]
+pub use self::into_iter::IntoIter;
+
+mod into_iter;
+
+#[cfg(not(no_global_oom_handling))]
+use self::is_zero::IsZero;
+
+mod is_zero;
+
+#[cfg(not(no_global_oom_handling))]
+mod in_place_collect;
+
+mod partial_eq;
+
+#[cfg(not(no_global_oom_handling))]
+use self::spec_from_elem::SpecFromElem;
+
+#[cfg(not(no_global_oom_handling))]
+mod spec_from_elem;
+
+#[cfg(not(no_global_oom_handling))]
+use self::set_len_on_drop::SetLenOnDrop;
+
+#[cfg(not(no_global_oom_handling))]
+mod set_len_on_drop;
+
+#[cfg(not(no_global_oom_handling))]
+use self::in_place_drop::InPlaceDrop;
+
+#[cfg(not(no_global_oom_handling))]
+mod in_place_drop;
+
+#[cfg(not(no_global_oom_handling))]
+use self::spec_from_iter_nested::SpecFromIterNested;
+
+#[cfg(not(no_global_oom_handling))]
+mod spec_from_iter_nested;
+
+#[cfg(not(no_global_oom_handling))]
+use self::spec_from_iter::SpecFromIter;
+
+#[cfg(not(no_global_oom_handling))]
+mod spec_from_iter;
+
+#[cfg(not(no_global_oom_handling))]
+use self::spec_extend::SpecExtend;
+
+#[cfg(not(no_global_oom_handling))]
+mod spec_extend;
+
+/// A contiguous growable array type, written as `Vec<T>`, short for 'vector'.
+///
+/// # Examples
+///
+/// ```
+/// let mut vec = Vec::new();
+/// vec.push(1);
+/// vec.push(2);
+///
+/// assert_eq!(vec.len(), 2);
+/// assert_eq!(vec[0], 1);
+///
+/// assert_eq!(vec.pop(), Some(2));
+/// assert_eq!(vec.len(), 1);
+///
+/// vec[0] = 7;
+/// assert_eq!(vec[0], 7);
+///
+/// vec.extend([1, 2, 3].iter().copied());
+///
+/// for x in &vec {
+///     println!("{x}");
+/// }
+/// assert_eq!(vec, [7, 1, 2, 3]);
+/// ```
+///
+/// The [`vec!`] macro is provided for convenient initialization:
+///
+/// ```
+/// let mut vec1 = vec![1, 2, 3];
+/// vec1.push(4);
+/// let vec2 = Vec::from([1, 2, 3, 4]);
+/// assert_eq!(vec1, vec2);
+/// ```
+///
+/// It can also initialize each element of a `Vec<T>` with a given value.
+/// This may be more efficient than performing allocation and initialization
+/// in separate steps, especially when initializing a vector of zeros:
+///
+/// ```
+/// let vec = vec![0; 5];
+/// assert_eq!(vec, [0, 0, 0, 0, 0]);
+///
+/// // The following is equivalent, but potentially slower:
+/// let mut vec = Vec::with_capacity(5);
+/// vec.resize(5, 0);
+/// assert_eq!(vec, [0, 0, 0, 0, 0]);
+/// ```
+///
+/// For more information, see
+/// [Capacity and Reallocation](#capacity-and-reallocation).
+///
+/// Use a `Vec<T>` as an efficient stack:
+///
+/// ```
+/// let mut stack = Vec::new();
+///
+/// stack.push(1);
+/// stack.push(2);
+/// stack.push(3);
+///
+/// while let Some(top) = stack.pop() {
+///     // Prints 3, 2, 1
+///     println!("{top}");
+/// }
+/// ```
+///
+/// # Indexing
+///
+/// The `Vec` type allows to access values by index, because it implements the
+/// [`Index`] trait. An example will be more explicit:
+///
+/// ```
+/// let v = vec![0, 2, 4, 6];
+/// println!("{}", v[1]); // it will display '2'
+/// ```
+///
+/// However be careful: if you try to access an index which isn't in the `Vec`,
+/// your software will panic! You cannot do this:
+///
+/// ```should_panic
+/// let v = vec![0, 2, 4, 6];
+/// println!("{}", v[6]); // it will panic!
+/// ```
+///
+/// Use [`get`] and [`get_mut`] if you want to check whether the index is in
+/// the `Vec`.
+///
+/// # Slicing
+///
+/// A `Vec` can be mutable. On the other hand, slices are read-only objects.
+/// To get a [slice][prim@slice], use [`&`]. Example:
+///
+/// ```
+/// fn read_slice(slice: &[usize]) {
+///     // ...
+/// }
+///
+/// let v = vec![0, 1];
+/// read_slice(&v);
+///
+/// // ... and that's all!
+/// // you can also do it like this:
+/// let u: &[usize] = &v;
+/// // or like this:
+/// let u: &[_] = &v;
+/// ```
+///
+/// In Rust, it's more common to pass slices as arguments rather than vectors
+/// when you just want to provide read access. The same goes for [`String`] and
+/// [`&str`].
+///
+/// # Capacity and reallocation
+///
+/// The capacity of a vector is the amount of space allocated for any future
+/// elements that will be added onto the vector. This is not to be confused with
+/// the *length* of a vector, which specifies the number of actual elements
+/// within the vector. If a vector's length exceeds its capacity, its capacity
+/// will automatically be increased, but its elements will have to be
+/// reallocated.
+///
+/// For example, a vector with capacity 10 and length 0 would be an empty vector
+/// with space for 10 more elements. Pushing 10 or fewer elements onto the
+/// vector will not change its capacity or cause reallocation to occur. However,
+/// if the vector's length is increased to 11, it will have to reallocate, which
+/// can be slow. For this reason, it is recommended to use [`Vec::with_capacity`]
+/// whenever possible to specify how big the vector is expected to get.
+///
+/// # Guarantees
+///
+/// Due to its incredibly fundamental nature, `Vec` makes a lot of guarantees
+/// about its design. This ensures that it's as low-overhead as possible in
+/// the general case, and can be correctly manipulated in primitive ways
+/// by unsafe code. Note that these guarantees refer to an unqualified `Vec<T>`.
+/// If additional type parameters are added (e.g., to support custom allocators),
+/// overriding their defaults may change the behavior.
+///
+/// Most fundamentally, `Vec` is and always will be a (pointer, capacity, length)
+/// triplet. No more, no less. The order of these fields is completely
+/// unspecified, and you should use the appropriate methods to modify these.
+/// The pointer will never be null, so this type is null-pointer-optimized.
+///
+/// However, the pointer might not actually point to allocated memory. In particular,
+/// if you construct a `Vec` with capacity 0 via [`Vec::new`], [`vec![]`][`vec!`],
+/// [`Vec::with_capacity(0)`][`Vec::with_capacity`], or by calling [`shrink_to_fit`]
+/// on an empty Vec, it will not allocate memory. Similarly, if you store zero-sized
+/// types inside a `Vec`, it will not allocate space for them. *Note that in this case
+/// the `Vec` might not report a [`capacity`] of 0*. `Vec` will allocate if and only
+/// if <code>[mem::size_of::\<T>]\() * [capacity]\() > 0</code>. In general, `Vec`'s allocation
+/// details are very subtle --- if you intend to allocate memory using a `Vec`
+/// and use it for something else (either to pass to unsafe code, or to build your
+/// own memory-backed collection), be sure to deallocate this memory by using
+/// `from_raw_parts` to recover the `Vec` and then dropping it.
+///
+/// If a `Vec` *has* allocated memory, then the memory it points to is on the heap
+/// (as defined by the allocator Rust is configured to use by default), and its
+/// pointer points to [`len`] initialized, contiguous elements in order (what
+/// you would see if you coerced it to a slice), followed by <code>[capacity] - [len]</code>
+/// logically uninitialized, contiguous elements.
+///
+/// A vector containing the elements `'a'` and `'b'` with capacity 4 can be
+/// visualized as below. The top part is the `Vec` struct, it contains a
+/// pointer to the head of the allocation in the heap, length and capacity.
+/// The bottom part is the allocation on the heap, a contiguous memory block.
+///
+/// ```text
+///             ptr      len  capacity
+///        +--------+--------+--------+
+///        | 0x0123 |      2 |      4 |
+///        +--------+--------+--------+
+///             |
+///             v
+/// Heap   +--------+--------+--------+--------+
+///        |    'a' |    'b' | uninit | uninit |
+///        +--------+--------+--------+--------+
+/// ```
+///
+/// - **uninit** represents memory that is not initialized, see [`MaybeUninit`].
+/// - Note: the ABI is not stable and `Vec` makes no guarantees about its memory
+///   layout (including the order of fields).
+///
+/// `Vec` will never perform a "small optimization" where elements are actually
+/// stored on the stack for two reasons:
+///
+/// * It would make it more difficult for unsafe code to correctly manipulate
+///   a `Vec`. The contents of a `Vec` wouldn't have a stable address if it were
+///   only moved, and it would be more difficult to determine if a `Vec` had
+///   actually allocated memory.
+///
+/// * It would penalize the general case, incurring an additional branch
+///   on every access.
+///
+/// `Vec` will never automatically shrink itself, even if completely empty. This
+/// ensures no unnecessary allocations or deallocations occur. Emptying a `Vec`
+/// and then filling it back up to the same [`len`] should incur no calls to
+/// the allocator. If you wish to free up unused memory, use
+/// [`shrink_to_fit`] or [`shrink_to`].
+///
+/// [`push`] and [`insert`] will never (re)allocate if the reported capacity is
+/// sufficient. [`push`] and [`insert`] *will* (re)allocate if
+/// <code>[len] == [capacity]</code>. That is, the reported capacity is completely
+/// accurate, and can be relied on. It can even be used to manually free the memory
+/// allocated by a `Vec` if desired. Bulk insertion methods *may* reallocate, even
+/// when not necessary.
+///
+/// `Vec` does not guarantee any particular growth strategy when reallocating
+/// when full, nor when [`reserve`] is called. The current strategy is basic
+/// and it may prove desirable to use a non-constant growth factor. Whatever
+/// strategy is used will of course guarantee *O*(1) amortized [`push`].
+///
+/// `vec![x; n]`, `vec![a, b, c, d]`, and
+/// [`Vec::with_capacity(n)`][`Vec::with_capacity`], will all produce a `Vec`
+/// with exactly the requested capacity. If <code>[len] == [capacity]</code>,
+/// (as is the case for the [`vec!`] macro), then a `Vec<T>` can be converted to
+/// and from a [`Box<[T]>`][owned slice] without reallocating or moving the elements.
+///
+/// `Vec` will not specifically overwrite any data that is removed from it,
+/// but also won't specifically preserve it. Its uninitialized memory is
+/// scratch space that it may use however it wants. It will generally just do
+/// whatever is most efficient or otherwise easy to implement. Do not rely on
+/// removed data to be erased for security purposes. Even if you drop a `Vec`, its
+/// buffer may simply be reused by another allocation. Even if you zero a `Vec`'s memory
+/// first, that might not actually happen because the optimizer does not consider
+/// this a side-effect that must be preserved. There is one case which we will
+/// not break, however: using `unsafe` code to write to the excess capacity,
+/// and then increasing the length to match, is always valid.
+///
+/// Currently, `Vec` does not guarantee the order in which elements are dropped.
+/// The order has changed in the past and may change again.
+///
+/// [`get`]: ../../std/vec/struct.Vec.html#method.get
+/// [`get_mut`]: ../../std/vec/struct.Vec.html#method.get_mut
+/// [`String`]: crate::string::String
+/// [`&str`]: type@str
+/// [`shrink_to_fit`]: Vec::shrink_to_fit
+/// [`shrink_to`]: Vec::shrink_to
+/// [capacity]: Vec::capacity
+/// [`capacity`]: Vec::capacity
+/// [mem::size_of::\<T>]: core::mem::size_of
+/// [len]: Vec::len
+/// [`len`]: Vec::len
+/// [`push`]: Vec::push
+/// [`insert`]: Vec::insert
+/// [`reserve`]: Vec::reserve
+/// [`MaybeUninit`]: core::mem::MaybeUninit
+/// [owned slice]: Box
+#[stable(feature = "rust1", since = "1.0.0")]
+#[cfg_attr(not(test), rustc_diagnostic_item = "Vec")]
+#[rustc_insignificant_dtor]
+pub struct Vec<T, #[unstable(feature = "allocator_api", issue = "32838")] A: Allocator = Global> {
+    buf: RawVec<T, A>,
+    len: usize,
+}
+
+////////////////////////////////////////////////////////////////////////////////
+// Inherent methods
+////////////////////////////////////////////////////////////////////////////////
+
+impl<T> Vec<T> {
+    /// Constructs a new, empty `Vec<T>`.
+    ///
+    /// The vector will not allocate until elements are pushed onto it.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// # #![allow(unused_mut)]
+    /// let mut vec: Vec<i32> = Vec::new();
+    /// ```
+    #[inline]
+    #[rustc_const_stable(feature = "const_vec_new", since = "1.39.0")]
+    #[stable(feature = "rust1", since = "1.0.0")]
+    #[must_use]
+    pub const fn new() -> Self {
+        Vec { buf: RawVec::NEW, len: 0 }
+    }
+
+    /// Constructs a new, empty `Vec<T>` with the specified capacity.
+    ///
+    /// The vector will be able to hold exactly `capacity` elements without
+    /// reallocating. If `capacity` is 0, the vector will not allocate.
+    ///
+    /// It is important to note that although the returned vector has the
+    /// *capacity* specified, the vector will have a zero *length*. For an
+    /// explanation of the difference between length and capacity, see
+    /// *[Capacity and reallocation]*.
+    ///
+    /// [Capacity and reallocation]: #capacity-and-reallocation
+    ///
+    /// # Panics
+    ///
+    /// Panics if the new capacity exceeds `isize::MAX` bytes.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let mut vec = Vec::with_capacity(10);
+    ///
+    /// // The vector contains no items, even though it has capacity for more
+    /// assert_eq!(vec.len(), 0);
+    /// assert_eq!(vec.capacity(), 10);
+    ///
+    /// // These are all done without reallocating...
+    /// for i in 0..10 {
+    ///     vec.push(i);
+    /// }
+    /// assert_eq!(vec.len(), 10);
+    /// assert_eq!(vec.capacity(), 10);
+    ///
+    /// // ...but this may make the vector reallocate
+    /// vec.push(11);
+    /// assert_eq!(vec.len(), 11);
+    /// assert!(vec.capacity() >= 11);
+    /// ```
+    #[cfg(not(no_global_oom_handling))]
+    #[inline]
+    #[stable(feature = "rust1", since = "1.0.0")]
+    #[must_use]
+    pub fn with_capacity(capacity: usize) -> Self {
+        Self::with_capacity_in(capacity, Global)
+    }
+
+    /// Creates a `Vec<T>` directly from the raw components of another vector.
+    ///
+    /// # Safety
+    ///
+    /// This is highly unsafe, due to the number of invariants that aren't
+    /// checked:
+    ///
+    /// * `ptr` needs to have been previously allocated via [`String`]/`Vec<T>`
+    ///   (at least, it's highly likely to be incorrect if it wasn't).
+    /// * `T` needs to have the same alignment as what `ptr` was allocated with.
+    ///   (`T` having a less strict alignment is not sufficient, the alignment really
+    ///   needs to be equal to satisfy the [`dealloc`] requirement that memory must be
+    ///   allocated and deallocated with the same layout.)
+    /// * The size of `T` times the `capacity` (ie. the allocated size in bytes) needs
+    ///   to be the same size as the pointer was allocated with. (Because similar to
+    ///   alignment, [`dealloc`] must be called with the same layout `size`.)
+    /// * `length` needs to be less than or equal to `capacity`.
+    ///
+    /// Violating these may cause problems like corrupting the allocator's
+    /// internal data structures. For example it is normally **not** safe
+    /// to build a `Vec<u8>` from a pointer to a C `char` array with length
+    /// `size_t`, doing so is only safe if the array was initially allocated by
+    /// a `Vec` or `String`.
+    /// It's also not safe to build one from a `Vec<u16>` and its length, because
+    /// the allocator cares about the alignment, and these two types have different
+    /// alignments. The buffer was allocated with alignment 2 (for `u16`), but after
+    /// turning it into a `Vec<u8>` it'll be deallocated with alignment 1. To avoid
+    /// these issues, it is often preferable to do casting/transmuting using
+    /// [`slice::from_raw_parts`] instead.
+    ///
+    /// The ownership of `ptr` is effectively transferred to the
+    /// `Vec<T>` which may then deallocate, reallocate or change the
+    /// contents of memory pointed to by the pointer at will. Ensure
+    /// that nothing else uses the pointer after calling this
+    /// function.
+    ///
+    /// [`String`]: crate::string::String
+    /// [`dealloc`]: crate::alloc::GlobalAlloc::dealloc
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use std::ptr;
+    /// use std::mem;
+    ///
+    /// let v = vec![1, 2, 3];
+    ///
+    // FIXME Update this when vec_into_raw_parts is stabilized
+    /// // Prevent running `v`'s destructor so we are in complete control
+    /// // of the allocation.
+    /// let mut v = mem::ManuallyDrop::new(v);
+    ///
+    /// // Pull out the various important pieces of information about `v`
+    /// let p = v.as_mut_ptr();
+    /// let len = v.len();
+    /// let cap = v.capacity();
+    ///
+    /// unsafe {
+    ///     // Overwrite memory with 4, 5, 6
+    ///     for i in 0..len as isize {
+    ///         ptr::write(p.offset(i), 4 + i);
+    ///     }
+    ///
+    ///     // Put everything back together into a Vec
+    ///     let rebuilt = Vec::from_raw_parts(p, len, cap);
+    ///     assert_eq!(rebuilt, [4, 5, 6]);
+    /// }
+    /// ```
+    #[inline]
+    #[stable(feature = "rust1", since = "1.0.0")]
+    pub unsafe fn from_raw_parts(ptr: *mut T, length: usize, capacity: usize) -> Self {
+        unsafe { Self::from_raw_parts_in(ptr, length, capacity, Global) }
+    }
+}
+
+impl<T, A: Allocator> Vec<T, A> {
+    /// Constructs a new, empty `Vec<T, A>`.
+    ///
+    /// The vector will not allocate until elements are pushed onto it.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// #![feature(allocator_api)]
+    ///
+    /// use std::alloc::System;
+    ///
+    /// # #[allow(unused_mut)]
+    /// let mut vec: Vec<i32, _> = Vec::new_in(System);
+    /// ```
+    #[inline]
+    #[unstable(feature = "allocator_api", issue = "32838")]
+    pub const fn new_in(alloc: A) -> Self {
+        Vec { buf: RawVec::new_in(alloc), len: 0 }
+    }
+
+    /// Constructs a new, empty `Vec<T, A>` with the specified capacity with the provided
+    /// allocator.
+    ///
+    /// The vector will be able to hold exactly `capacity` elements without
+    /// reallocating. If `capacity` is 0, the vector will not allocate.
+    ///
+    /// It is important to note that although the returned vector has the
+    /// *capacity* specified, the vector will have a zero *length*. For an
+    /// explanation of the difference between length and capacity, see
+    /// *[Capacity and reallocation]*.
+    ///
+    /// [Capacity and reallocation]: #capacity-and-reallocation
+    ///
+    /// # Panics
+    ///
+    /// Panics if the new capacity exceeds `isize::MAX` bytes.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// #![feature(allocator_api)]
+    ///
+    /// use std::alloc::System;
+    ///
+    /// let mut vec = Vec::with_capacity_in(10, System);
+    ///
+    /// // The vector contains no items, even though it has capacity for more
+    /// assert_eq!(vec.len(), 0);
+    /// assert_eq!(vec.capacity(), 10);
+    ///
+    /// // These are all done without reallocating...
+    /// for i in 0..10 {
+    ///     vec.push(i);
+    /// }
+    /// assert_eq!(vec.len(), 10);
+    /// assert_eq!(vec.capacity(), 10);
+    ///
+    /// // ...but this may make the vector reallocate
+    /// vec.push(11);
+    /// assert_eq!(vec.len(), 11);
+    /// assert!(vec.capacity() >= 11);
+    /// ```
+    #[cfg(not(no_global_oom_handling))]
+    #[inline]
+    #[unstable(feature = "allocator_api", issue = "32838")]
+    pub fn with_capacity_in(capacity: usize, alloc: A) -> Self {
+        Vec { buf: RawVec::with_capacity_in(capacity, alloc), len: 0 }
+    }
+
+    /// Creates a `Vec<T, A>` directly from the raw components of another vector.
+    ///
+    /// # Safety
+    ///
+    /// This is highly unsafe, due to the number of invariants that aren't
+    /// checked:
+    ///
+    /// * `ptr` needs to have been previously allocated via [`String`]/`Vec<T>`
+    ///   (at least, it's highly likely to be incorrect if it wasn't).
+    /// * `T` needs to have the same size and alignment as what `ptr` was allocated with.
+    ///   (`T` having a less strict alignment is not sufficient, the alignment really
+    ///   needs to be equal to satisfy the [`dealloc`] requirement that memory must be
+    ///   allocated and deallocated with the same layout.)
+    /// * `length` needs to be less than or equal to `capacity`.
+    /// * `capacity` needs to be the capacity that the pointer was allocated with.
+    ///
+    /// Violating these may cause problems like corrupting the allocator's
+    /// internal data structures. For example it is **not** safe
+    /// to build a `Vec<u8>` from a pointer to a C `char` array with length `size_t`.
+    /// It's also not safe to build one from a `Vec<u16>` and its length, because
+    /// the allocator cares about the alignment, and these two types have different
+    /// alignments. The buffer was allocated with alignment 2 (for `u16`), but after
+    /// turning it into a `Vec<u8>` it'll be deallocated with alignment 1.
+    ///
+    /// The ownership of `ptr` is effectively transferred to the
+    /// `Vec<T>` which may then deallocate, reallocate or change the
+    /// contents of memory pointed to by the pointer at will. Ensure
+    /// that nothing else uses the pointer after calling this
+    /// function.
+    ///
+    /// [`String`]: crate::string::String
+    /// [`dealloc`]: crate::alloc::GlobalAlloc::dealloc
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// #![feature(allocator_api)]
+    ///
+    /// use std::alloc::System;
+    ///
+    /// use std::ptr;
+    /// use std::mem;
+    ///
+    /// let mut v = Vec::with_capacity_in(3, System);
+    /// v.push(1);
+    /// v.push(2);
+    /// v.push(3);
+    ///
+    // FIXME Update this when vec_into_raw_parts is stabilized
+    /// // Prevent running `v`'s destructor so we are in complete control
+    /// // of the allocation.
+    /// let mut v = mem::ManuallyDrop::new(v);
+    ///
+    /// // Pull out the various important pieces of information about `v`
+    /// let p = v.as_mut_ptr();
+    /// let len = v.len();
+    /// let cap = v.capacity();
+    /// let alloc = v.allocator();
+    ///
+    /// unsafe {
+    ///     // Overwrite memory with 4, 5, 6
+    ///     for i in 0..len as isize {
+    ///         ptr::write(p.offset(i), 4 + i);
+    ///     }
+    ///
+    ///     // Put everything back together into a Vec
+    ///     let rebuilt = Vec::from_raw_parts_in(p, len, cap, alloc.clone());
+    ///     assert_eq!(rebuilt, [4, 5, 6]);
+    /// }
+    /// ```
+    #[inline]
+    #[unstable(feature = "allocator_api", issue = "32838")]
+    pub unsafe fn from_raw_parts_in(ptr: *mut T, length: usize, capacity: usize, alloc: A) -> Self {
+        unsafe { Vec { buf: RawVec::from_raw_parts_in(ptr, capacity, alloc), len: length } }
+    }
+
+    /// Decomposes a `Vec<T>` into its raw components.
+    ///
+    /// Returns the raw pointer to the underlying data, the length of
+    /// the vector (in elements), and the allocated capacity of the
+    /// data (in elements). These are the same arguments in the same
+    /// order as the arguments to [`from_raw_parts`].
+    ///
+    /// After calling this function, the caller is responsible for the
+    /// memory previously managed by the `Vec`. The only way to do
+    /// this is to convert the raw pointer, length, and capacity back
+    /// into a `Vec` with the [`from_raw_parts`] function, allowing
+    /// the destructor to perform the cleanup.
+    ///
+    /// [`from_raw_parts`]: Vec::from_raw_parts
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// #![feature(vec_into_raw_parts)]
+    /// let v: Vec<i32> = vec![-1, 0, 1];
+    ///
+    /// let (ptr, len, cap) = v.into_raw_parts();
+    ///
+    /// let rebuilt = unsafe {
+    ///     // We can now make changes to the components, such as
+    ///     // transmuting the raw pointer to a compatible type.
+    ///     let ptr = ptr as *mut u32;
+    ///
+    ///     Vec::from_raw_parts(ptr, len, cap)
+    /// };
+    /// assert_eq!(rebuilt, [4294967295, 0, 1]);
+    /// ```
+    #[unstable(feature = "vec_into_raw_parts", reason = "new API", issue = "65816")]
+    pub fn into_raw_parts(self) -> (*mut T, usize, usize) {
+        let mut me = ManuallyDrop::new(self);
+        (me.as_mut_ptr(), me.len(), me.capacity())
+    }
+
+    /// Decomposes a `Vec<T>` into its raw components.
+    ///
+    /// Returns the raw pointer to the underlying data, the length of the vector (in elements),
+    /// the allocated capacity of the data (in elements), and the allocator. These are the same
+    /// arguments in the same order as the arguments to [`from_raw_parts_in`].
+    ///
+    /// After calling this function, the caller is responsible for the
+    /// memory previously managed by the `Vec`. The only way to do
+    /// this is to convert the raw pointer, length, and capacity back
+    /// into a `Vec` with the [`from_raw_parts_in`] function, allowing
+    /// the destructor to perform the cleanup.
+    ///
+    /// [`from_raw_parts_in`]: Vec::from_raw_parts_in
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// #![feature(allocator_api, vec_into_raw_parts)]
+    ///
+    /// use std::alloc::System;
+    ///
+    /// let mut v: Vec<i32, System> = Vec::new_in(System);
+    /// v.push(-1);
+    /// v.push(0);
+    /// v.push(1);
+    ///
+    /// let (ptr, len, cap, alloc) = v.into_raw_parts_with_alloc();
+    ///
+    /// let rebuilt = unsafe {
+    ///     // We can now make changes to the components, such as
+    ///     // transmuting the raw pointer to a compatible type.
+    ///     let ptr = ptr as *mut u32;
+    ///
+    ///     Vec::from_raw_parts_in(ptr, len, cap, alloc)
+    /// };
+    /// assert_eq!(rebuilt, [4294967295, 0, 1]);
+    /// ```
+    #[unstable(feature = "allocator_api", issue = "32838")]
+    // #[unstable(feature = "vec_into_raw_parts", reason = "new API", issue = "65816")]
+    pub fn into_raw_parts_with_alloc(self) -> (*mut T, usize, usize, A) {
+        let mut me = ManuallyDrop::new(self);
+        let len = me.len();
+        let capacity = me.capacity();
+        let ptr = me.as_mut_ptr();
+        let alloc = unsafe { ptr::read(me.allocator()) };
+        (ptr, len, capacity, alloc)
+    }
+
+    /// Returns the number of elements the vector can hold without
+    /// reallocating.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let vec: Vec<i32> = Vec::with_capacity(10);
+    /// assert_eq!(vec.capacity(), 10);
+    /// ```
+    #[inline]
+    #[stable(feature = "rust1", since = "1.0.0")]
+    pub fn capacity(&self) -> usize {
+        self.buf.capacity()
+    }
+
+    /// Reserves capacity for at least `additional` more elements to be inserted
+    /// in the given `Vec<T>`. The collection may reserve more space to avoid
+    /// frequent reallocations. After calling `reserve`, capacity will be
+    /// greater than or equal to `self.len() + additional`. Does nothing if
+    /// capacity is already sufficient.
+    ///
+    /// # Panics
+    ///
+    /// Panics if the new capacity exceeds `isize::MAX` bytes.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let mut vec = vec![1];
+    /// vec.reserve(10);
+    /// assert!(vec.capacity() >= 11);
+    /// ```
+    #[cfg(not(no_global_oom_handling))]
+    #[stable(feature = "rust1", since = "1.0.0")]
+    pub fn reserve(&mut self, additional: usize) {
+        self.buf.reserve(self.len, additional);
+    }
+
+    /// Reserves the minimum capacity for exactly `additional` more elements to
+    /// be inserted in the given `Vec<T>`. After calling `reserve_exact`,
+    /// capacity will be greater than or equal to `self.len() + additional`.
+    /// Does nothing if the capacity is already sufficient.
+    ///
+    /// Note that the allocator may give the collection more space than it
+    /// requests. Therefore, capacity can not be relied upon to be precisely
+    /// minimal. Prefer [`reserve`] if future insertions are expected.
+    ///
+    /// [`reserve`]: Vec::reserve
+    ///
+    /// # Panics
+    ///
+    /// Panics if the new capacity exceeds `isize::MAX` bytes.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let mut vec = vec![1];
+    /// vec.reserve_exact(10);
+    /// assert!(vec.capacity() >= 11);
+    /// ```
+    #[cfg(not(no_global_oom_handling))]
+    #[stable(feature = "rust1", since = "1.0.0")]
+    pub fn reserve_exact(&mut self, additional: usize) {
+        self.buf.reserve_exact(self.len, additional);
+    }
+
+    /// Tries to reserve capacity for at least `additional` more elements to be inserted
+    /// in the given `Vec<T>`. The collection may reserve more space to avoid
+    /// frequent reallocations. After calling `try_reserve`, capacity will be
+    /// greater than or equal to `self.len() + additional`. Does nothing if
+    /// capacity is already sufficient.
+    ///
+    /// # Errors
+    ///
+    /// If the capacity overflows, or the allocator reports a failure, then an error
+    /// is returned.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use std::collections::TryReserveError;
+    ///
+    /// fn process_data(data: &[u32]) -> Result<Vec<u32>, TryReserveError> {
+    ///     let mut output = Vec::new();
+    ///
+    ///     // Pre-reserve the memory, exiting if we can't
+    ///     output.try_reserve(data.len())?;
+    ///
+    ///     // Now we know this can't OOM in the middle of our complex work
+    ///     output.extend(data.iter().map(|&val| {
+    ///         val * 2 + 5 // very complicated
+    ///     }));
+    ///
+    ///     Ok(output)
+    /// }
+    /// # process_data(&[1, 2, 3]).expect("why is the test harness OOMing on 12 bytes?");
+    /// ```
+    #[stable(feature = "try_reserve", since = "1.57.0")]
+    pub fn try_reserve(&mut self, additional: usize) -> Result<(), TryReserveError> {
+        self.buf.try_reserve(self.len, additional)
+    }
+
+    /// Tries to reserve the minimum capacity for exactly `additional`
+    /// elements to be inserted in the given `Vec<T>`. After calling
+    /// `try_reserve_exact`, capacity will be greater than or equal to
+    /// `self.len() + additional` if it returns `Ok(())`.
+    /// Does nothing if the capacity is already sufficient.
+    ///
+    /// Note that the allocator may give the collection more space than it
+    /// requests. Therefore, capacity can not be relied upon to be precisely
+    /// minimal. Prefer [`try_reserve`] if future insertions are expected.
+    ///
+    /// [`try_reserve`]: Vec::try_reserve
+    ///
+    /// # Errors
+    ///
+    /// If the capacity overflows, or the allocator reports a failure, then an error
+    /// is returned.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use std::collections::TryReserveError;
+    ///
+    /// fn process_data(data: &[u32]) -> Result<Vec<u32>, TryReserveError> {
+    ///     let mut output = Vec::new();
+    ///
+    ///     // Pre-reserve the memory, exiting if we can't
+    ///     output.try_reserve_exact(data.len())?;
+    ///
+    ///     // Now we know this can't OOM in the middle of our complex work
+    ///     output.extend(data.iter().map(|&val| {
+    ///         val * 2 + 5 // very complicated
+    ///     }));
+    ///
+    ///     Ok(output)
+    /// }
+    /// # process_data(&[1, 2, 3]).expect("why is the test harness OOMing on 12 bytes?");
+    /// ```
+    #[stable(feature = "try_reserve", since = "1.57.0")]
+    pub fn try_reserve_exact(&mut self, additional: usize) -> Result<(), TryReserveError> {
+        self.buf.try_reserve_exact(self.len, additional)
+    }
+
+    /// Shrinks the capacity of the vector as much as possible.
+    ///
+    /// It will drop down as close as possible to the length but the allocator
+    /// may still inform the vector that there is space for a few more elements.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let mut vec = Vec::with_capacity(10);
+    /// vec.extend([1, 2, 3]);
+    /// assert_eq!(vec.capacity(), 10);
+    /// vec.shrink_to_fit();
+    /// assert!(vec.capacity() >= 3);
+    /// ```
+    #[cfg(not(no_global_oom_handling))]
+    #[stable(feature = "rust1", since = "1.0.0")]
+    pub fn shrink_to_fit(&mut self) {
+        // The capacity is never less than the length, and there's nothing to do when
+        // they are equal, so we can avoid the panic case in `RawVec::shrink_to_fit`
+        // by only calling it with a greater capacity.
+        if self.capacity() > self.len {
+            self.buf.shrink_to_fit(self.len);
+        }
+    }
+
+    /// Shrinks the capacity of the vector with a lower bound.
+    ///
+    /// The capacity will remain at least as large as both the length
+    /// and the supplied value.
+    ///
+    /// If the current capacity is less than the lower limit, this is a no-op.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let mut vec = Vec::with_capacity(10);
+    /// vec.extend([1, 2, 3]);
+    /// assert_eq!(vec.capacity(), 10);
+    /// vec.shrink_to(4);
+    /// assert!(vec.capacity() >= 4);
+    /// vec.shrink_to(0);
+    /// assert!(vec.capacity() >= 3);
+    /// ```
+    #[cfg(not(no_global_oom_handling))]
+    #[stable(feature = "shrink_to", since = "1.56.0")]
+    pub fn shrink_to(&mut self, min_capacity: usize) {
+        if self.capacity() > min_capacity {
+            self.buf.shrink_to_fit(cmp::max(self.len, min_capacity));
+        }
+    }
+
+    /// Converts the vector into [`Box<[T]>`][owned slice].
+    ///
+    /// Note that this will drop any excess capacity.
+    ///
+    /// [owned slice]: Box
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let v = vec![1, 2, 3];
+    ///
+    /// let slice = v.into_boxed_slice();
+    /// ```
+    ///
+    /// Any excess capacity is removed:
+    ///
+    /// ```
+    /// let mut vec = Vec::with_capacity(10);
+    /// vec.extend([1, 2, 3]);
+    ///
+    /// assert_eq!(vec.capacity(), 10);
+    /// let slice = vec.into_boxed_slice();
+    /// assert_eq!(slice.into_vec().capacity(), 3);
+    /// ```
+    #[cfg(not(no_global_oom_handling))]
+    #[stable(feature = "rust1", since = "1.0.0")]
+    pub fn into_boxed_slice(mut self) -> Box<[T], A> {
+        unsafe {
+            self.shrink_to_fit();
+            let me = ManuallyDrop::new(self);
+            let buf = ptr::read(&me.buf);
+            let len = me.len();
+            buf.into_box(len).assume_init()
+        }
+    }
+
+    /// Shortens the vector, keeping the first `len` elements and dropping
+    /// the rest.
+    ///
+    /// If `len` is greater than the vector's current length, this has no
+    /// effect.
+    ///
+    /// The [`drain`] method can emulate `truncate`, but causes the excess
+    /// elements to be returned instead of dropped.
+    ///
+    /// Note that this method has no effect on the allocated capacity
+    /// of the vector.
+    ///
+    /// # Examples
+    ///
+    /// Truncating a five element vector to two elements:
+    ///
+    /// ```
+    /// let mut vec = vec![1, 2, 3, 4, 5];
+    /// vec.truncate(2);
+    /// assert_eq!(vec, [1, 2]);
+    /// ```
+    ///
+    /// No truncation occurs when `len` is greater than the vector's current
+    /// length:
+    ///
+    /// ```
+    /// let mut vec = vec![1, 2, 3];
+    /// vec.truncate(8);
+    /// assert_eq!(vec, [1, 2, 3]);
+    /// ```
+    ///
+    /// Truncating when `len == 0` is equivalent to calling the [`clear`]
+    /// method.
+    ///
+    /// ```
+    /// let mut vec = vec![1, 2, 3];
+    /// vec.truncate(0);
+    /// assert_eq!(vec, []);
+    /// ```
+    ///
+    /// [`clear`]: Vec::clear
+    /// [`drain`]: Vec::drain
+    #[stable(feature = "rust1", since = "1.0.0")]
+    pub fn truncate(&mut self, len: usize) {
+        // This is safe because:
+        //
+        // * the slice passed to `drop_in_place` is valid; the `len > self.len`
+        //   case avoids creating an invalid slice, and
+        // * the `len` of the vector is shrunk before calling `drop_in_place`,
+        //   such that no value will be dropped twice in case `drop_in_place`
+        //   were to panic once (if it panics twice, the program aborts).
+        unsafe {
+            // Note: It's intentional that this is `>` and not `>=`.
+            //       Changing it to `>=` has negative performance
+            //       implications in some cases. See #78884 for more.
+            if len > self.len {
+                return;
+            }
+            let remaining_len = self.len - len;
+            let s = ptr::slice_from_raw_parts_mut(self.as_mut_ptr().add(len), remaining_len);
+            self.len = len;
+            ptr::drop_in_place(s);
+        }
+    }
+
+    /// Extracts a slice containing the entire vector.
+    ///
+    /// Equivalent to `&s[..]`.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use std::io::{self, Write};
+    /// let buffer = vec![1, 2, 3, 5, 8];
+    /// io::sink().write(buffer.as_slice()).unwrap();
+    /// ```
+    #[inline]
+    #[stable(feature = "vec_as_slice", since = "1.7.0")]
+    pub fn as_slice(&self) -> &[T] {
+        self
+    }
+
+    /// Extracts a mutable slice of the entire vector.
+    ///
+    /// Equivalent to `&mut s[..]`.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use std::io::{self, Read};
+    /// let mut buffer = vec![0; 3];
+    /// io::repeat(0b101).read_exact(buffer.as_mut_slice()).unwrap();
+    /// ```
+    #[inline]
+    #[stable(feature = "vec_as_slice", since = "1.7.0")]
+    pub fn as_mut_slice(&mut self) -> &mut [T] {
+        self
+    }
+
+    /// Returns a raw pointer to the vector's buffer.
+    ///
+    /// The caller must ensure that the vector outlives the pointer this
+    /// function returns, or else it will end up pointing to garbage.
+    /// Modifying the vector may cause its buffer to be reallocated,
+    /// which would also make any pointers to it invalid.
+    ///
+    /// The caller must also ensure that the memory the pointer (non-transitively) points to
+    /// is never written to (except inside an `UnsafeCell`) using this pointer or any pointer
+    /// derived from it. If you need to mutate the contents of the slice, use [`as_mut_ptr`].
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let x = vec![1, 2, 4];
+    /// let x_ptr = x.as_ptr();
+    ///
+    /// unsafe {
+    ///     for i in 0..x.len() {
+    ///         assert_eq!(*x_ptr.add(i), 1 << i);
+    ///     }
+    /// }
+    /// ```
+    ///
+    /// [`as_mut_ptr`]: Vec::as_mut_ptr
+    #[stable(feature = "vec_as_ptr", since = "1.37.0")]
+    #[inline]
+    pub fn as_ptr(&self) -> *const T {
+        // We shadow the slice method of the same name to avoid going through
+        // `deref`, which creates an intermediate reference.
+        let ptr = self.buf.ptr();
+        unsafe {
+            assume(!ptr.is_null());
+        }
+        ptr
+    }
+
+    /// Returns an unsafe mutable pointer to the vector's buffer.
+    ///
+    /// The caller must ensure that the vector outlives the pointer this
+    /// function returns, or else it will end up pointing to garbage.
+    /// Modifying the vector may cause its buffer to be reallocated,
+    /// which would also make any pointers to it invalid.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// // Allocate vector big enough for 4 elements.
+    /// let size = 4;
+    /// let mut x: Vec<i32> = Vec::with_capacity(size);
+    /// let x_ptr = x.as_mut_ptr();
+    ///
+    /// // Initialize elements via raw pointer writes, then set length.
+    /// unsafe {
+    ///     for i in 0..size {
+    ///         *x_ptr.add(i) = i as i32;
+    ///     }
+    ///     x.set_len(size);
+    /// }
+    /// assert_eq!(&*x, &[0, 1, 2, 3]);
+    /// ```
+    #[stable(feature = "vec_as_ptr", since = "1.37.0")]
+    #[inline]
+    pub fn as_mut_ptr(&mut self) -> *mut T {
+        // We shadow the slice method of the same name to avoid going through
+        // `deref_mut`, which creates an intermediate reference.
+        let ptr = self.buf.ptr();
+        unsafe {
+            assume(!ptr.is_null());
+        }
+        ptr
+    }
+
+    /// Returns a reference to the underlying allocator.
+    #[unstable(feature = "allocator_api", issue = "32838")]
+    #[inline]
+    pub fn allocator(&self) -> &A {
+        self.buf.allocator()
+    }
+
+    /// Forces the length of the vector to `new_len`.
+    ///
+    /// This is a low-level operation that maintains none of the normal
+    /// invariants of the type. Normally changing the length of a vector
+    /// is done using one of the safe operations instead, such as
+    /// [`truncate`], [`resize`], [`extend`], or [`clear`].
+    ///
+    /// [`truncate`]: Vec::truncate
+    /// [`resize`]: Vec::resize
+    /// [`extend`]: Extend::extend
+    /// [`clear`]: Vec::clear
+    ///
+    /// # Safety
+    ///
+    /// - `new_len` must be less than or equal to [`capacity()`].
+    /// - The elements at `old_len..new_len` must be initialized.
+    ///
+    /// [`capacity()`]: Vec::capacity
+    ///
+    /// # Examples
+    ///
+    /// This method can be useful for situations in which the vector
+    /// is serving as a buffer for other code, particularly over FFI:
+    ///
+    /// ```no_run
+    /// # #![allow(dead_code)]
+    /// # // This is just a minimal skeleton for the doc example;
+    /// # // don't use this as a starting point for a real library.
+    /// # pub struct StreamWrapper { strm: *mut std::ffi::c_void }
+    /// # const Z_OK: i32 = 0;
+    /// # extern "C" {
+    /// #     fn deflateGetDictionary(
+    /// #         strm: *mut std::ffi::c_void,
+    /// #         dictionary: *mut u8,
+    /// #         dictLength: *mut usize,
+    /// #     ) -> i32;
+    /// # }
+    /// # impl StreamWrapper {
+    /// pub fn get_dictionary(&self) -> Option<Vec<u8>> {
+    ///     // Per the FFI method's docs, "32768 bytes is always enough".
+    ///     let mut dict = Vec::with_capacity(32_768);
+    ///     let mut dict_length = 0;
+    ///     // SAFETY: When `deflateGetDictionary` returns `Z_OK`, it holds that:
+    ///     // 1. `dict_length` elements were initialized.
+    ///     // 2. `dict_length` <= the capacity (32_768)
+    ///     // which makes `set_len` safe to call.
+    ///     unsafe {
+    ///         // Make the FFI call...
+    ///         let r = deflateGetDictionary(self.strm, dict.as_mut_ptr(), &mut dict_length);
+    ///         if r == Z_OK {
+    ///             // ...and update the length to what was initialized.
+    ///             dict.set_len(dict_length);
+    ///             Some(dict)
+    ///         } else {
+    ///             None
+    ///         }
+    ///     }
+    /// }
+    /// # }
+    /// ```
+    ///
+    /// While the following example is sound, there is a memory leak since
+    /// the inner vectors were not freed prior to the `set_len` call:
+    ///
+    /// ```
+    /// let mut vec = vec![vec![1, 0, 0],
+    ///                    vec![0, 1, 0],
+    ///                    vec![0, 0, 1]];
+    /// // SAFETY:
+    /// // 1. `old_len..0` is empty so no elements need to be initialized.
+    /// // 2. `0 <= capacity` always holds whatever `capacity` is.
+    /// unsafe {
+    ///     vec.set_len(0);
+    /// }
+    /// ```
+    ///
+    /// Normally, here, one would use [`clear`] instead to correctly drop
+    /// the contents and thus not leak memory.
+    #[inline]
+    #[stable(feature = "rust1", since = "1.0.0")]
+    pub unsafe fn set_len(&mut self, new_len: usize) {
+        debug_assert!(new_len <= self.capacity());
+
+        self.len = new_len;
+    }
+
+    /// Removes an element from the vector and returns it.
+    ///
+    /// The removed element is replaced by the last element of the vector.
+    ///
+    /// This does not preserve ordering, but is *O*(1).
+    /// If you need to preserve the element order, use [`remove`] instead.
+    ///
+    /// [`remove`]: Vec::remove
+    ///
+    /// # Panics
+    ///
+    /// Panics if `index` is out of bounds.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let mut v = vec!["foo", "bar", "baz", "qux"];
+    ///
+    /// assert_eq!(v.swap_remove(1), "bar");
+    /// assert_eq!(v, ["foo", "qux", "baz"]);
+    ///
+    /// assert_eq!(v.swap_remove(0), "foo");
+    /// assert_eq!(v, ["baz", "qux"]);
+    /// ```
+    #[inline]
+    #[stable(feature = "rust1", since = "1.0.0")]
+    pub fn swap_remove(&mut self, index: usize) -> T {
+        #[cold]
+        #[inline(never)]
+        fn assert_failed(index: usize, len: usize) -> ! {
+            panic!("swap_remove index (is {index}) should be < len (is {len})");
+        }
+
+        let len = self.len();
+        if index >= len {
+            assert_failed(index, len);
+        }
+        unsafe {
+            // We replace self[index] with the last element. Note that if the
+            // bounds check above succeeds there must be a last element (which
+            // can be self[index] itself).
+            let value = ptr::read(self.as_ptr().add(index));
+            let base_ptr = self.as_mut_ptr();
+            ptr::copy(base_ptr.add(len - 1), base_ptr.add(index), 1);
+            self.set_len(len - 1);
+            value
+        }
+    }
+
+    /// Inserts an element at position `index` within the vector, shifting all
+    /// elements after it to the right.
+    ///
+    /// # Panics
+    ///
+    /// Panics if `index > len`.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let mut vec = vec![1, 2, 3];
+    /// vec.insert(1, 4);
+    /// assert_eq!(vec, [1, 4, 2, 3]);
+    /// vec.insert(4, 5);
+    /// assert_eq!(vec, [1, 4, 2, 3, 5]);
+    /// ```
+    #[cfg(not(no_global_oom_handling))]
+    #[stable(feature = "rust1", since = "1.0.0")]
+    pub fn insert(&mut self, index: usize, element: T) {
+        #[cold]
+        #[inline(never)]
+        fn assert_failed(index: usize, len: usize) -> ! {
+            panic!("insertion index (is {index}) should be <= len (is {len})");
+        }
+
+        let len = self.len();
+        if index > len {
+            assert_failed(index, len);
+        }
+
+        // space for the new element
+        if len == self.buf.capacity() {
+            self.reserve(1);
+        }
+
+        unsafe {
+            // infallible
+            // The spot to put the new value
+            {
+                let p = self.as_mut_ptr().add(index);
+                // Shift everything over to make space. (Duplicating the
+                // `index`th element into two consecutive places.)
+                ptr::copy(p, p.offset(1), len - index);
+                // Write it in, overwriting the first copy of the `index`th
+                // element.
+                ptr::write(p, element);
+            }
+            self.set_len(len + 1);
+        }
+    }
+
+    /// Removes and returns the element at position `index` within the vector,
+    /// shifting all elements after it to the left.
+    ///
+    /// Note: Because this shifts over the remaining elements, it has a
+    /// worst-case performance of *O*(*n*). If you don't need the order of elements
+    /// to be preserved, use [`swap_remove`] instead. If you'd like to remove
+    /// elements from the beginning of the `Vec`, consider using
+    /// [`VecDeque::pop_front`] instead.
+    ///
+    /// [`swap_remove`]: Vec::swap_remove
+    /// [`VecDeque::pop_front`]: crate::collections::VecDeque::pop_front
+    ///
+    /// # Panics
+    ///
+    /// Panics if `index` is out of bounds.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let mut v = vec![1, 2, 3];
+    /// assert_eq!(v.remove(1), 2);
+    /// assert_eq!(v, [1, 3]);
+    /// ```
+    #[stable(feature = "rust1", since = "1.0.0")]
+    #[track_caller]
+    pub fn remove(&mut self, index: usize) -> T {
+        #[cold]
+        #[inline(never)]
+        #[track_caller]
+        fn assert_failed(index: usize, len: usize) -> ! {
+            panic!("removal index (is {index}) should be < len (is {len})");
+        }
+
+        let len = self.len();
+        if index >= len {
+            assert_failed(index, len);
+        }
+        unsafe {
+            // infallible
+            let ret;
+            {
+                // the place we are taking from.
+                let ptr = self.as_mut_ptr().add(index);
+                // copy it out, unsafely having a copy of the value on
+                // the stack and in the vector at the same time.
+                ret = ptr::read(ptr);
+
+                // Shift everything down to fill in that spot.
+                ptr::copy(ptr.offset(1), ptr, len - index - 1);
+            }
+            self.set_len(len - 1);
+            ret
+        }
+    }
+
+    /// Retains only the elements specified by the predicate.
+    ///
+    /// In other words, remove all elements `e` for which `f(&e)` returns `false`.
+    /// This method operates in place, visiting each element exactly once in the
+    /// original order, and preserves the order of the retained elements.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let mut vec = vec![1, 2, 3, 4];
+    /// vec.retain(|&x| x % 2 == 0);
+    /// assert_eq!(vec, [2, 4]);
+    /// ```
+    ///
+    /// Because the elements are visited exactly once in the original order,
+    /// external state may be used to decide which elements to keep.
+    ///
+    /// ```
+    /// let mut vec = vec![1, 2, 3, 4, 5];
+    /// let keep = [false, true, true, false, true];
+    /// let mut iter = keep.iter();
+    /// vec.retain(|_| *iter.next().unwrap());
+    /// assert_eq!(vec, [2, 3, 5]);
+    /// ```
+    #[stable(feature = "rust1", since = "1.0.0")]
+    pub fn retain<F>(&mut self, mut f: F)
+    where
+        F: FnMut(&T) -> bool,
+    {
+        self.retain_mut(|elem| f(elem));
+    }
+
+    /// Retains only the elements specified by the predicate, passing a mutable reference to it.
+    ///
+    /// In other words, remove all elements `e` such that `f(&mut e)` returns `false`.
+    /// This method operates in place, visiting each element exactly once in the
+    /// original order, and preserves the order of the retained elements.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let mut vec = vec![1, 2, 3, 4];
+    /// vec.retain_mut(|x| if *x > 3 {
+    ///     false
+    /// } else {
+    ///     *x += 1;
+    ///     true
+    /// });
+    /// assert_eq!(vec, [2, 3, 4]);
+    /// ```
+    #[stable(feature = "vec_retain_mut", since = "1.61.0")]
+    pub fn retain_mut<F>(&mut self, mut f: F)
+    where
+        F: FnMut(&mut T) -> bool,
+    {
+        let original_len = self.len();
+        // Avoid double drop if the drop guard is not executed,
+        // since we may make some holes during the process.
+        unsafe { self.set_len(0) };
+
+        // Vec: [Kept, Kept, Hole, Hole, Hole, Hole, Unchecked, Unchecked]
+        //      |<-              processed len   ->| ^- next to check
+        //                  |<-  deleted cnt     ->|
+        //      |<-              original_len                          ->|
+        // Kept: Elements which predicate returns true on.
+        // Hole: Moved or dropped element slot.
+        // Unchecked: Unchecked valid elements.
+        //
+        // This drop guard will be invoked when predicate or `drop` of element panicked.
+        // It shifts unchecked elements to cover holes and `set_len` to the correct length.
+        // In cases when predicate and `drop` never panick, it will be optimized out.
+        struct BackshiftOnDrop<'a, T, A: Allocator> {
+            v: &'a mut Vec<T, A>,
+            processed_len: usize,
+            deleted_cnt: usize,
+            original_len: usize,
+        }
+
+        impl<T, A: Allocator> Drop for BackshiftOnDrop<'_, T, A> {
+            fn drop(&mut self) {
+                if self.deleted_cnt > 0 {
+                    // SAFETY: Trailing unchecked items must be valid since we never touch them.
+                    unsafe {
+                        ptr::copy(
+                            self.v.as_ptr().add(self.processed_len),
+                            self.v.as_mut_ptr().add(self.processed_len - self.deleted_cnt),
+                            self.original_len - self.processed_len,
+                        );
+                    }
+                }
+                // SAFETY: After filling holes, all items are in contiguous memory.
+                unsafe {
+                    self.v.set_len(self.original_len - self.deleted_cnt);
+                }
+            }
+        }
+
+        let mut g = BackshiftOnDrop { v: self, processed_len: 0, deleted_cnt: 0, original_len };
+
+        fn process_loop<F, T, A: Allocator, const DELETED: bool>(
+            original_len: usize,
+            f: &mut F,
+            g: &mut BackshiftOnDrop<'_, T, A>,
+        ) where
+            F: FnMut(&mut T) -> bool,
+        {
+            while g.processed_len != original_len {
+                // SAFETY: Unchecked element must be valid.
+                let cur = unsafe { &mut *g.v.as_mut_ptr().add(g.processed_len) };
+                if !f(cur) {
+                    // Advance early to avoid double drop if `drop_in_place` panicked.
+                    g.processed_len += 1;
+                    g.deleted_cnt += 1;
+                    // SAFETY: We never touch this element again after dropped.
+                    unsafe { ptr::drop_in_place(cur) };
+                    // We already advanced the counter.
+                    if DELETED {
+                        continue;
+                    } else {
+                        break;
+                    }
+                }
+                if DELETED {
+                    // SAFETY: `deleted_cnt` > 0, so the hole slot must not overlap with current element.
+                    // We use copy for move, and never touch this element again.
+                    unsafe {
+                        let hole_slot = g.v.as_mut_ptr().add(g.processed_len - g.deleted_cnt);
+                        ptr::copy_nonoverlapping(cur, hole_slot, 1);
+                    }
+                }
+                g.processed_len += 1;
+            }
+        }
+
+        // Stage 1: Nothing was deleted.
+        process_loop::<F, T, A, false>(original_len, &mut f, &mut g);
+
+        // Stage 2: Some elements were deleted.
+        process_loop::<F, T, A, true>(original_len, &mut f, &mut g);
+
+        // All item are processed. This can be optimized to `set_len` by LLVM.
+        drop(g);
+    }
+
+    /// Removes all but the first of consecutive elements in the vector that resolve to the same
+    /// key.
+    ///
+    /// If the vector is sorted, this removes all duplicates.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let mut vec = vec![10, 20, 21, 30, 20];
+    ///
+    /// vec.dedup_by_key(|i| *i / 10);
+    ///
+    /// assert_eq!(vec, [10, 20, 30, 20]);
+    /// ```
+    #[stable(feature = "dedup_by", since = "1.16.0")]
+    #[inline]
+    pub fn dedup_by_key<F, K>(&mut self, mut key: F)
+    where
+        F: FnMut(&mut T) -> K,
+        K: PartialEq,
+    {
+        self.dedup_by(|a, b| key(a) == key(b))
+    }
+
+    /// Removes all but the first of consecutive elements in the vector satisfying a given equality
+    /// relation.
+    ///
+    /// The `same_bucket` function is passed references to two elements from the vector and
+    /// must determine if the elements compare equal. The elements are passed in opposite order
+    /// from their order in the slice, so if `same_bucket(a, b)` returns `true`, `a` is removed.
+    ///
+    /// If the vector is sorted, this removes all duplicates.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let mut vec = vec!["foo", "bar", "Bar", "baz", "bar"];
+    ///
+    /// vec.dedup_by(|a, b| a.eq_ignore_ascii_case(b));
+    ///
+    /// assert_eq!(vec, ["foo", "bar", "baz", "bar"]);
+    /// ```
+    #[stable(feature = "dedup_by", since = "1.16.0")]
+    pub fn dedup_by<F>(&mut self, mut same_bucket: F)
+    where
+        F: FnMut(&mut T, &mut T) -> bool,
+    {
+        let len = self.len();
+        if len <= 1 {
+            return;
+        }
+
+        /* INVARIANT: vec.len() > read >= write > write-1 >= 0 */
+        struct FillGapOnDrop<'a, T, A: core::alloc::Allocator> {
+            /* Offset of the element we want to check if it is duplicate */
+            read: usize,
+
+            /* Offset of the place where we want to place the non-duplicate
+             * when we find it. */
+            write: usize,
+
+            /* The Vec that would need correction if `same_bucket` panicked */
+            vec: &'a mut Vec<T, A>,
+        }
+
+        impl<'a, T, A: core::alloc::Allocator> Drop for FillGapOnDrop<'a, T, A> {
+            fn drop(&mut self) {
+                /* This code gets executed when `same_bucket` panics */
+
+                /* SAFETY: invariant guarantees that `read - write`
+                 * and `len - read` never overflow and that the copy is always
+                 * in-bounds. */
+                unsafe {
+                    let ptr = self.vec.as_mut_ptr();
+                    let len = self.vec.len();
+
+                    /* How many items were left when `same_bucket` panicked.
+                     * Basically vec[read..].len() */
+                    let items_left = len.wrapping_sub(self.read);
+
+                    /* Pointer to first item in vec[write..write+items_left] slice */
+                    let dropped_ptr = ptr.add(self.write);
+                    /* Pointer to first item in vec[read..] slice */
+                    let valid_ptr = ptr.add(self.read);
+
+                    /* Copy `vec[read..]` to `vec[write..write+items_left]`.
+                     * The slices can overlap, so `copy_nonoverlapping` cannot be used */
+                    ptr::copy(valid_ptr, dropped_ptr, items_left);
+
+                    /* How many items have been already dropped
+                     * Basically vec[read..write].len() */
+                    let dropped = self.read.wrapping_sub(self.write);
+
+                    self.vec.set_len(len - dropped);
+                }
+            }
+        }
+
+        let mut gap = FillGapOnDrop { read: 1, write: 1, vec: self };
+        let ptr = gap.vec.as_mut_ptr();
+
+        /* Drop items while going through Vec, it should be more efficient than
+         * doing slice partition_dedup + truncate */
+
+        /* SAFETY: Because of the invariant, read_ptr, prev_ptr and write_ptr
+         * are always in-bounds and read_ptr never aliases prev_ptr */
+        unsafe {
+            while gap.read < len {
+                let read_ptr = ptr.add(gap.read);
+                let prev_ptr = ptr.add(gap.write.wrapping_sub(1));
+
+                if same_bucket(&mut *read_ptr, &mut *prev_ptr) {
+                    // Increase `gap.read` now since the drop may panic.
+                    gap.read += 1;
+                    /* We have found duplicate, drop it in-place */
+                    ptr::drop_in_place(read_ptr);
+                } else {
+                    let write_ptr = ptr.add(gap.write);
+
+                    /* Because `read_ptr` can be equal to `write_ptr`, we either
+                     * have to use `copy` or conditional `copy_nonoverlapping`.
+                     * Looks like the first option is faster. */
+                    ptr::copy(read_ptr, write_ptr, 1);
+
+                    /* We have filled that place, so go further */
+                    gap.write += 1;
+                    gap.read += 1;
+                }
+            }
+
+            /* Technically we could let `gap` clean up with its Drop, but
+             * when `same_bucket` is guaranteed to not panic, this bloats a little
+             * the codegen, so we just do it manually */
+            gap.vec.set_len(gap.write);
+            mem::forget(gap);
+        }
+    }
+
+    /// Appends an element to the back of a collection.
+    ///
+    /// # Panics
+    ///
+    /// Panics if the new capacity exceeds `isize::MAX` bytes.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let mut vec = vec![1, 2];
+    /// vec.push(3);
+    /// assert_eq!(vec, [1, 2, 3]);
+    /// ```
+    #[cfg(not(no_global_oom_handling))]
+    #[inline]
+    #[stable(feature = "rust1", since = "1.0.0")]
+    pub fn push(&mut self, value: T) {
+        // This will panic or abort if we would allocate > isize::MAX bytes
+        // or if the length increment would overflow for zero-sized types.
+        if self.len == self.buf.capacity() {
+            self.buf.reserve_for_push(self.len);
+        }
+        unsafe {
+            let end = self.as_mut_ptr().add(self.len);
+            ptr::write(end, value);
+            self.len += 1;
+        }
+    }
+
+    /// Removes the last element from a vector and returns it, or [`None`] if it
+    /// is empty.
+    ///
+    /// If you'd like to pop the first element, consider using
+    /// [`VecDeque::pop_front`] instead.
+    ///
+    /// [`VecDeque::pop_front`]: crate::collections::VecDeque::pop_front
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let mut vec = vec![1, 2, 3];
+    /// assert_eq!(vec.pop(), Some(3));
+    /// assert_eq!(vec, [1, 2]);
+    /// ```
+    #[inline]
+    #[stable(feature = "rust1", since = "1.0.0")]
+    pub fn pop(&mut self) -> Option<T> {
+        if self.len == 0 {
+            None
+        } else {
+            unsafe {
+                self.len -= 1;
+                Some(ptr::read(self.as_ptr().add(self.len())))
+            }
+        }
+    }
+
+    /// Moves all the elements of `other` into `self`, leaving `other` empty.
+    ///
+    /// # Panics
+    ///
+    /// Panics if the number of elements in the vector overflows a `usize`.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let mut vec = vec![1, 2, 3];
+    /// let mut vec2 = vec![4, 5, 6];
+    /// vec.append(&mut vec2);
+    /// assert_eq!(vec, [1, 2, 3, 4, 5, 6]);
+    /// assert_eq!(vec2, []);
+    /// ```
+    #[cfg(not(no_global_oom_handling))]
+    #[inline]
+    #[stable(feature = "append", since = "1.4.0")]
+    pub fn append(&mut self, other: &mut Self) {
+        unsafe {
+            self.append_elements(other.as_slice() as _);
+            other.set_len(0);
+        }
+    }
+
+    /// Appends elements to `self` from other buffer.
+    #[cfg(not(no_global_oom_handling))]
+    #[inline]
+    unsafe fn append_elements(&mut self, other: *const [T]) {
+        let count = unsafe { (*other).len() };
+        self.reserve(count);
+        let len = self.len();
+        unsafe { ptr::copy_nonoverlapping(other as *const T, self.as_mut_ptr().add(len), count) };
+        self.len += count;
+    }
+
+    /// Removes the specified range from the vector in bulk, returning all
+    /// removed elements as an iterator. If the iterator is dropped before
+    /// being fully consumed, it drops the remaining removed elements.
+    ///
+    /// The returned iterator keeps a mutable borrow on the vector to optimize
+    /// its implementation.
+    ///
+    /// # Panics
+    ///
+    /// Panics if the starting point is greater than the end point or if
+    /// the end point is greater than the length of the vector.
+    ///
+    /// # Leaking
+    ///
+    /// If the returned iterator goes out of scope without being dropped (due to
+    /// [`mem::forget`], for example), the vector may have lost and leaked
+    /// elements arbitrarily, including elements outside the range.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let mut v = vec![1, 2, 3];
+    /// let u: Vec<_> = v.drain(1..).collect();
+    /// assert_eq!(v, &[1]);
+    /// assert_eq!(u, &[2, 3]);
+    ///
+    /// // A full range clears the vector, like `clear()` does
+    /// v.drain(..);
+    /// assert_eq!(v, &[]);
+    /// ```
+    #[stable(feature = "drain", since = "1.6.0")]
+    pub fn drain<R>(&mut self, range: R) -> Drain<'_, T, A>
+    where
+        R: RangeBounds<usize>,
+    {
+        // Memory safety
+        //
+        // When the Drain is first created, it shortens the length of
+        // the source vector to make sure no uninitialized or moved-from elements
+        // are accessible at all if the Drain's destructor never gets to run.
+        //
+        // Drain will ptr::read out the values to remove.
+        // When finished, remaining tail of the vec is copied back to cover
+        // the hole, and the vector length is restored to the new length.
+        //
+        let len = self.len();
+        let Range { start, end } = slice::range(range, ..len);
+
+        unsafe {
+            // set self.vec length's to start, to be safe in case Drain is leaked
+            self.set_len(start);
+            // Use the borrow in the IterMut to indicate borrowing behavior of the
+            // whole Drain iterator (like &mut T).
+            let range_slice = slice::from_raw_parts_mut(self.as_mut_ptr().add(start), end - start);
+            Drain {
+                tail_start: end,
+                tail_len: len - end,
+                iter: range_slice.iter(),
+                vec: NonNull::from(self),
+            }
+        }
+    }
+
+    /// Clears the vector, removing all values.
+    ///
+    /// Note that this method has no effect on the allocated capacity
+    /// of the vector.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let mut v = vec![1, 2, 3];
+    ///
+    /// v.clear();
+    ///
+    /// assert!(v.is_empty());
+    /// ```
+    #[inline]
+    #[stable(feature = "rust1", since = "1.0.0")]
+    pub fn clear(&mut self) {
+        let elems: *mut [T] = self.as_mut_slice();
+
+        // SAFETY:
+        // - `elems` comes directly from `as_mut_slice` and is therefore valid.
+        // - Setting `self.len` before calling `drop_in_place` means that,
+        //   if an element's `Drop` impl panics, the vector's `Drop` impl will
+        //   do nothing (leaking the rest of the elements) instead of dropping
+        //   some twice.
+        unsafe {
+            self.len = 0;
+            ptr::drop_in_place(elems);
+        }
+    }
+
+    /// Returns the number of elements in the vector, also referred to
+    /// as its 'length'.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let a = vec![1, 2, 3];
+    /// assert_eq!(a.len(), 3);
+    /// ```
+    #[inline]
+    #[stable(feature = "rust1", since = "1.0.0")]
+    pub fn len(&self) -> usize {
+        self.len
+    }
+
+    /// Returns `true` if the vector contains no elements.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let mut v = Vec::new();
+    /// assert!(v.is_empty());
+    ///
+    /// v.push(1);
+    /// assert!(!v.is_empty());
+    /// ```
+    #[stable(feature = "rust1", since = "1.0.0")]
+    pub fn is_empty(&self) -> bool {
+        self.len() == 0
+    }
+
+    /// Splits the collection into two at the given index.
+    ///
+    /// Returns a newly allocated vector containing the elements in the range
+    /// `[at, len)`. After the call, the original vector will be left containing
+    /// the elements `[0, at)` with its previous capacity unchanged.
+    ///
+    /// # Panics
+    ///
+    /// Panics if `at > len`.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let mut vec = vec![1, 2, 3];
+    /// let vec2 = vec.split_off(1);
+    /// assert_eq!(vec, [1]);
+    /// assert_eq!(vec2, [2, 3]);
+    /// ```
+    #[cfg(not(no_global_oom_handling))]
+    #[inline]
+    #[must_use = "use `.truncate()` if you don't need the other half"]
+    #[stable(feature = "split_off", since = "1.4.0")]
+    pub fn split_off(&mut self, at: usize) -> Self
+    where
+        A: Clone,
+    {
+        #[cold]
+        #[inline(never)]
+        fn assert_failed(at: usize, len: usize) -> ! {
+            panic!("`at` split index (is {at}) should be <= len (is {len})");
+        }
+
+        if at > self.len() {
+            assert_failed(at, self.len());
+        }
+
+        if at == 0 {
+            // the new vector can take over the original buffer and avoid the copy
+            return mem::replace(
+                self,
+                Vec::with_capacity_in(self.capacity(), self.allocator().clone()),
+            );
+        }
+
+        let other_len = self.len - at;
+        let mut other = Vec::with_capacity_in(other_len, self.allocator().clone());
+
+        // Unsafely `set_len` and copy items to `other`.
+        unsafe {
+            self.set_len(at);
+            other.set_len(other_len);
+
+            ptr::copy_nonoverlapping(self.as_ptr().add(at), other.as_mut_ptr(), other.len());
+        }
+        other
+    }
+
+    /// Resizes the `Vec` in-place so that `len` is equal to `new_len`.
+    ///
+    /// If `new_len` is greater than `len`, the `Vec` is extended by the
+    /// difference, with each additional slot filled with the result of
+    /// calling the closure `f`. The return values from `f` will end up
+    /// in the `Vec` in the order they have been generated.
+    ///
+    /// If `new_len` is less than `len`, the `Vec` is simply truncated.
+    ///
+    /// This method uses a closure to create new values on every push. If
+    /// you'd rather [`Clone`] a given value, use [`Vec::resize`]. If you
+    /// want to use the [`Default`] trait to generate values, you can
+    /// pass [`Default::default`] as the second argument.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let mut vec = vec![1, 2, 3];
+    /// vec.resize_with(5, Default::default);
+    /// assert_eq!(vec, [1, 2, 3, 0, 0]);
+    ///
+    /// let mut vec = vec![];
+    /// let mut p = 1;
+    /// vec.resize_with(4, || { p *= 2; p });
+    /// assert_eq!(vec, [2, 4, 8, 16]);
+    /// ```
+    #[cfg(not(no_global_oom_handling))]
+    #[stable(feature = "vec_resize_with", since = "1.33.0")]
+    pub fn resize_with<F>(&mut self, new_len: usize, f: F)
+    where
+        F: FnMut() -> T,
+    {
+        let len = self.len();
+        if new_len > len {
+            self.extend_with(new_len - len, ExtendFunc(f));
+        } else {
+            self.truncate(new_len);
+        }
+    }
+
+    /// Consumes and leaks the `Vec`, returning a mutable reference to the contents,
+    /// `&'a mut [T]`. Note that the type `T` must outlive the chosen lifetime
+    /// `'a`. If the type has only static references, or none at all, then this
+    /// may be chosen to be `'static`.
+    ///
+    /// As of Rust 1.57, this method does not reallocate or shrink the `Vec`,
+    /// so the leaked allocation may include unused capacity that is not part
+    /// of the returned slice.
+    ///
+    /// This function is mainly useful for data that lives for the remainder of
+    /// the program's life. Dropping the returned reference will cause a memory
+    /// leak.
+    ///
+    /// # Examples
+    ///
+    /// Simple usage:
+    ///
+    /// ```
+    /// let x = vec![1, 2, 3];
+    /// let static_ref: &'static mut [usize] = x.leak();
+    /// static_ref[0] += 1;
+    /// assert_eq!(static_ref, &[2, 2, 3]);
+    /// ```
+    #[cfg(not(no_global_oom_handling))]
+    #[stable(feature = "vec_leak", since = "1.47.0")]
+    #[inline]
+    pub fn leak<'a>(self) -> &'a mut [T]
+    where
+        A: 'a,
+    {
+        let mut me = ManuallyDrop::new(self);
+        unsafe { slice::from_raw_parts_mut(me.as_mut_ptr(), me.len) }
+    }
+
+    /// Returns the remaining spare capacity of the vector as a slice of
+    /// `MaybeUninit<T>`.
+    ///
+    /// The returned slice can be used to fill the vector with data (e.g. by
+    /// reading from a file) before marking the data as initialized using the
+    /// [`set_len`] method.
+    ///
+    /// [`set_len`]: Vec::set_len
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// // Allocate vector big enough for 10 elements.
+    /// let mut v = Vec::with_capacity(10);
+    ///
+    /// // Fill in the first 3 elements.
+    /// let uninit = v.spare_capacity_mut();
+    /// uninit[0].write(0);
+    /// uninit[1].write(1);
+    /// uninit[2].write(2);
+    ///
+    /// // Mark the first 3 elements of the vector as being initialized.
+    /// unsafe {
+    ///     v.set_len(3);
+    /// }
+    ///
+    /// assert_eq!(&v, &[0, 1, 2]);
+    /// ```
+    #[stable(feature = "vec_spare_capacity", since = "1.60.0")]
+    #[inline]
+    pub fn spare_capacity_mut(&mut self) -> &mut [MaybeUninit<T>] {
+        // Note:
+        // This method is not implemented in terms of `split_at_spare_mut`,
+        // to prevent invalidation of pointers to the buffer.
+        unsafe {
+            slice::from_raw_parts_mut(
+                self.as_mut_ptr().add(self.len) as *mut MaybeUninit<T>,
+                self.buf.capacity() - self.len,
+            )
+        }
+    }
+
+    /// Returns vector content as a slice of `T`, along with the remaining spare
+    /// capacity of the vector as a slice of `MaybeUninit<T>`.
+    ///
+    /// The returned spare capacity slice can be used to fill the vector with data
+    /// (e.g. by reading from a file) before marking the data as initialized using
+    /// the [`set_len`] method.
+    ///
+    /// [`set_len`]: Vec::set_len
+    ///
+    /// Note that this is a low-level API, which should be used with care for
+    /// optimization purposes. If you need to append data to a `Vec`
+    /// you can use [`push`], [`extend`], [`extend_from_slice`],
+    /// [`extend_from_within`], [`insert`], [`append`], [`resize`] or
+    /// [`resize_with`], depending on your exact needs.
+    ///
+    /// [`push`]: Vec::push
+    /// [`extend`]: Vec::extend
+    /// [`extend_from_slice`]: Vec::extend_from_slice
+    /// [`extend_from_within`]: Vec::extend_from_within
+    /// [`insert`]: Vec::insert
+    /// [`append`]: Vec::append
+    /// [`resize`]: Vec::resize
+    /// [`resize_with`]: Vec::resize_with
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// #![feature(vec_split_at_spare)]
+    ///
+    /// let mut v = vec![1, 1, 2];
+    ///
+    /// // Reserve additional space big enough for 10 elements.
+    /// v.reserve(10);
+    ///
+    /// let (init, uninit) = v.split_at_spare_mut();
+    /// let sum = init.iter().copied().sum::<u32>();
+    ///
+    /// // Fill in the next 4 elements.
+    /// uninit[0].write(sum);
+    /// uninit[1].write(sum * 2);
+    /// uninit[2].write(sum * 3);
+    /// uninit[3].write(sum * 4);
+    ///
+    /// // Mark the 4 elements of the vector as being initialized.
+    /// unsafe {
+    ///     let len = v.len();
+    ///     v.set_len(len + 4);
+    /// }
+    ///
+    /// assert_eq!(&v, &[1, 1, 2, 4, 8, 12, 16]);
+    /// ```
+    #[unstable(feature = "vec_split_at_spare", issue = "81944")]
+    #[inline]
+    pub fn split_at_spare_mut(&mut self) -> (&mut [T], &mut [MaybeUninit<T>]) {
+        // SAFETY:
+        // - len is ignored and so never changed
+        let (init, spare, _) = unsafe { self.split_at_spare_mut_with_len() };
+        (init, spare)
+    }
+
+    /// Safety: changing returned .2 (&mut usize) is considered the same as calling `.set_len(_)`.
+    ///
+    /// This method provides unique access to all vec parts at once in `extend_from_within`.
+    unsafe fn split_at_spare_mut_with_len(
+        &mut self,
+    ) -> (&mut [T], &mut [MaybeUninit<T>], &mut usize) {
+        let ptr = self.as_mut_ptr();
+        // SAFETY:
+        // - `ptr` is guaranteed to be valid for `self.len` elements
+        // - but the allocation extends out to `self.buf.capacity()` elements, possibly
+        // uninitialized
+        let spare_ptr = unsafe { ptr.add(self.len) };
+        let spare_ptr = spare_ptr.cast::<MaybeUninit<T>>();
+        let spare_len = self.buf.capacity() - self.len;
+
+        // SAFETY:
+        // - `ptr` is guaranteed to be valid for `self.len` elements
+        // - `spare_ptr` is pointing one element past the buffer, so it doesn't overlap with `initialized`
+        unsafe {
+            let initialized = slice::from_raw_parts_mut(ptr, self.len);
+            let spare = slice::from_raw_parts_mut(spare_ptr, spare_len);
+
+            (initialized, spare, &mut self.len)
+        }
+    }
+}
+
+impl<T: Clone, A: Allocator> Vec<T, A> {
+    /// Resizes the `Vec` in-place so that `len` is equal to `new_len`.
+    ///
+    /// If `new_len` is greater than `len`, the `Vec` is extended by the
+    /// difference, with each additional slot filled with `value`.
+    /// If `new_len` is less than `len`, the `Vec` is simply truncated.
+    ///
+    /// This method requires `T` to implement [`Clone`],
+    /// in order to be able to clone the passed value.
+    /// If you need more flexibility (or want to rely on [`Default`] instead of
+    /// [`Clone`]), use [`Vec::resize_with`].
+    /// If you only need to resize to a smaller size, use [`Vec::truncate`].
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let mut vec = vec!["hello"];
+    /// vec.resize(3, "world");
+    /// assert_eq!(vec, ["hello", "world", "world"]);
+    ///
+    /// let mut vec = vec![1, 2, 3, 4];
+    /// vec.resize(2, 0);
+    /// assert_eq!(vec, [1, 2]);
+    /// ```
+    #[cfg(not(no_global_oom_handling))]
+    #[stable(feature = "vec_resize", since = "1.5.0")]
+    pub fn resize(&mut self, new_len: usize, value: T) {
+        let len = self.len();
+
+        if new_len > len {
+            self.extend_with(new_len - len, ExtendElement(value))
+        } else {
+            self.truncate(new_len);
+        }
+    }
+
+    /// Clones and appends all elements in a slice to the `Vec`.
+    ///
+    /// Iterates over the slice `other`, clones each element, and then appends
+    /// it to this `Vec`. The `other` slice is traversed in-order.
+    ///
+    /// Note that this function is same as [`extend`] except that it is
+    /// specialized to work with slices instead. If and when Rust gets
+    /// specialization this function will likely be deprecated (but still
+    /// available).
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let mut vec = vec![1];
+    /// vec.extend_from_slice(&[2, 3, 4]);
+    /// assert_eq!(vec, [1, 2, 3, 4]);
+    /// ```
+    ///
+    /// [`extend`]: Vec::extend
+    #[cfg(not(no_global_oom_handling))]
+    #[stable(feature = "vec_extend_from_slice", since = "1.6.0")]
+    pub fn extend_from_slice(&mut self, other: &[T]) {
+        self.spec_extend(other.iter())
+    }
+
+    /// Copies elements from `src` range to the end of the vector.
+    ///
+    /// # Panics
+    ///
+    /// Panics if the starting point is greater than the end point or if
+    /// the end point is greater than the length of the vector.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let mut vec = vec![0, 1, 2, 3, 4];
+    ///
+    /// vec.extend_from_within(2..);
+    /// assert_eq!(vec, [0, 1, 2, 3, 4, 2, 3, 4]);
+    ///
+    /// vec.extend_from_within(..2);
+    /// assert_eq!(vec, [0, 1, 2, 3, 4, 2, 3, 4, 0, 1]);
+    ///
+    /// vec.extend_from_within(4..8);
+    /// assert_eq!(vec, [0, 1, 2, 3, 4, 2, 3, 4, 0, 1, 4, 2, 3, 4]);
+    /// ```
+    #[cfg(not(no_global_oom_handling))]
+    #[stable(feature = "vec_extend_from_within", since = "1.53.0")]
+    pub fn extend_from_within<R>(&mut self, src: R)
+    where
+        R: RangeBounds<usize>,
+    {
+        let range = slice::range(src, ..self.len());
+        self.reserve(range.len());
+
+        // SAFETY:
+        // - `slice::range` guarantees  that the given range is valid for indexing self
+        unsafe {
+            self.spec_extend_from_within(range);
+        }
+    }
+}
+
+impl<T, A: Allocator, const N: usize> Vec<[T; N], A> {
+    /// Takes a `Vec<[T; N]>` and flattens it into a `Vec<T>`.
+    ///
+    /// # Panics
+    ///
+    /// Panics if the length of the resulting vector would overflow a `usize`.
+    ///
+    /// This is only possible when flattening a vector of arrays of zero-sized
+    /// types, and thus tends to be irrelevant in practice. If
+    /// `size_of::<T>() > 0`, this will never panic.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// #![feature(slice_flatten)]
+    ///
+    /// let mut vec = vec![[1, 2, 3], [4, 5, 6], [7, 8, 9]];
+    /// assert_eq!(vec.pop(), Some([7, 8, 9]));
+    ///
+    /// let mut flattened = vec.into_flattened();
+    /// assert_eq!(flattened.pop(), Some(6));
+    /// ```
+    #[unstable(feature = "slice_flatten", issue = "95629")]
+    pub fn into_flattened(self) -> Vec<T, A> {
+        let (ptr, len, cap, alloc) = self.into_raw_parts_with_alloc();
+        let (new_len, new_cap) = if mem::size_of::<T>() == 0 {
+            (len.checked_mul(N).expect("vec len overflow"), usize::MAX)
+        } else {
+            // SAFETY:
+            // - `cap * N` cannot overflow because the allocation is already in
+            // the address space.
+            // - Each `[T; N]` has `N` valid elements, so there are `len * N`
+            // valid elements in the allocation.
+            unsafe { (len.unchecked_mul(N), cap.unchecked_mul(N)) }
+        };
+        // SAFETY:
+        // - `ptr` was allocated by `self`
+        // - `ptr` is well-aligned because `[T; N]` has the same alignment as `T`.
+        // - `new_cap` refers to the same sized allocation as `cap` because
+        // `new_cap * size_of::<T>()` == `cap * size_of::<[T; N]>()`
+        // - `len` <= `cap`, so `len * N` <= `cap * N`.
+        unsafe { Vec::<T, A>::from_raw_parts_in(ptr.cast(), new_len, new_cap, alloc) }
+    }
+}
+
+// This code generalizes `extend_with_{element,default}`.
+trait ExtendWith<T> {
+    fn next(&mut self) -> T;
+    fn last(self) -> T;
+}
+
+struct ExtendElement<T>(T);
+impl<T: Clone> ExtendWith<T> for ExtendElement<T> {
+    fn next(&mut self) -> T {
+        self.0.clone()
+    }
+    fn last(self) -> T {
+        self.0
+    }
+}
+
+struct ExtendFunc<F>(F);
+impl<T, F: FnMut() -> T> ExtendWith<T> for ExtendFunc<F> {
+    fn next(&mut self) -> T {
+        (self.0)()
+    }
+    fn last(mut self) -> T {
+        (self.0)()
+    }
+}
+
+impl<T, A: Allocator> Vec<T, A> {
+    #[cfg(not(no_global_oom_handling))]
+    /// Extend the vector by `n` values, using the given generator.
+    fn extend_with<E: ExtendWith<T>>(&mut self, n: usize, mut value: E) {
+        self.reserve(n);
+
+        unsafe {
+            let mut ptr = self.as_mut_ptr().add(self.len());
+            // Use SetLenOnDrop to work around bug where compiler
+            // might not realize the store through `ptr` through self.set_len()
+            // don't alias.
+            let mut local_len = SetLenOnDrop::new(&mut self.len);
+
+            // Write all elements except the last one
+            for _ in 1..n {
+                ptr::write(ptr, value.next());
+                ptr = ptr.offset(1);
+                // Increment the length in every step in case next() panics
+                local_len.increment_len(1);
+            }
+
+            if n > 0 {
+                // We can write the last element directly without cloning needlessly
+                ptr::write(ptr, value.last());
+                local_len.increment_len(1);
+            }
+
+            // len set by scope guard
+        }
+    }
+}
+
+impl<T: PartialEq, A: Allocator> Vec<T, A> {
+    /// Removes consecutive repeated elements in the vector according to the
+    /// [`PartialEq`] trait implementation.
+    ///
+    /// If the vector is sorted, this removes all duplicates.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let mut vec = vec![1, 2, 2, 3, 2];
+    ///
+    /// vec.dedup();
+    ///
+    /// assert_eq!(vec, [1, 2, 3, 2]);
+    /// ```
+    #[stable(feature = "rust1", since = "1.0.0")]
+    #[inline]
+    pub fn dedup(&mut self) {
+        self.dedup_by(|a, b| a == b)
+    }
+}
+
+////////////////////////////////////////////////////////////////////////////////
+// Internal methods and functions
+////////////////////////////////////////////////////////////////////////////////
+
+#[doc(hidden)]
+#[cfg(not(no_global_oom_handling))]
+#[stable(feature = "rust1", since = "1.0.0")]
+pub fn from_elem<T: Clone>(elem: T, n: usize) -> Vec<T> {
+    <T as SpecFromElem>::from_elem(elem, n, Global)
+}
+
+#[doc(hidden)]
+#[cfg(not(no_global_oom_handling))]
+#[unstable(feature = "allocator_api", issue = "32838")]
+pub fn from_elem_in<T: Clone, A: Allocator>(elem: T, n: usize, alloc: A) -> Vec<T, A> {
+    <T as SpecFromElem>::from_elem(elem, n, alloc)
+}
+
+trait ExtendFromWithinSpec {
+    /// # Safety
+    ///
+    /// - `src` needs to be valid index
+    /// - `self.capacity() - self.len()` must be `>= src.len()`
+    unsafe fn spec_extend_from_within(&mut self, src: Range<usize>);
+}
+
+impl<T: Clone, A: Allocator> ExtendFromWithinSpec for Vec<T, A> {
+    default unsafe fn spec_extend_from_within(&mut self, src: Range<usize>) {
+        // SAFETY:
+        // - len is increased only after initializing elements
+        let (this, spare, len) = unsafe { self.split_at_spare_mut_with_len() };
+
+        // SAFETY:
+        // - caller guaratees that src is a valid index
+        let to_clone = unsafe { this.get_unchecked(src) };
+
+        iter::zip(to_clone, spare)
+            .map(|(src, dst)| dst.write(src.clone()))
+            // Note:
+            // - Element was just initialized with `MaybeUninit::write`, so it's ok to increase len
+            // - len is increased after each element to prevent leaks (see issue #82533)
+            .for_each(|_| *len += 1);
+    }
+}
+
+impl<T: Copy, A: Allocator> ExtendFromWithinSpec for Vec<T, A> {
+    unsafe fn spec_extend_from_within(&mut self, src: Range<usize>) {
+        let count = src.len();
+        {
+            let (init, spare) = self.split_at_spare_mut();
+
+            // SAFETY:
+            // - caller guaratees that `src` is a valid index
+            let source = unsafe { init.get_unchecked(src) };
+
+            // SAFETY:
+            // - Both pointers are created from unique slice references (`&mut [_]`)
+            //   so they are valid and do not overlap.
+            // - Elements are :Copy so it's OK to to copy them, without doing
+            //   anything with the original values
+            // - `count` is equal to the len of `source`, so source is valid for
+            //   `count` reads
+            // - `.reserve(count)` guarantees that `spare.len() >= count` so spare
+            //   is valid for `count` writes
+            unsafe { ptr::copy_nonoverlapping(source.as_ptr(), spare.as_mut_ptr() as _, count) };
+        }
+
+        // SAFETY:
+        // - The elements were just initialized by `copy_nonoverlapping`
+        self.len += count;
+    }
+}
+
+////////////////////////////////////////////////////////////////////////////////
+// Common trait implementations for Vec
+////////////////////////////////////////////////////////////////////////////////
+
+#[stable(feature = "rust1", since = "1.0.0")]
+impl<T, A: Allocator> ops::Deref for Vec<T, A> {
+    type Target = [T];
+
+    fn deref(&self) -> &[T] {
+        unsafe { slice::from_raw_parts(self.as_ptr(), self.len) }
+    }
+}
+
+#[stable(feature = "rust1", since = "1.0.0")]
+impl<T, A: Allocator> ops::DerefMut for Vec<T, A> {
+    fn deref_mut(&mut self) -> &mut [T] {
+        unsafe { slice::from_raw_parts_mut(self.as_mut_ptr(), self.len) }
+    }
+}
+
+#[cfg(not(no_global_oom_handling))]
+trait SpecCloneFrom {
+    fn clone_from(this: &mut Self, other: &Self);
+}
+
+#[cfg(not(no_global_oom_handling))]
+impl<T: Clone, A: Allocator> SpecCloneFrom for Vec<T, A> {
+    default fn clone_from(this: &mut Self, other: &Self) {
+        // drop anything that will not be overwritten
+        this.truncate(other.len());
+
+        // self.len <= other.len due to the truncate above, so the
+        // slices here are always in-bounds.
+        let (init, tail) = other.split_at(this.len());
+
+        // reuse the contained values' allocations/resources.
+        this.clone_from_slice(init);
+        this.extend_from_slice(tail);
+    }
+}
+
+#[cfg(not(no_global_oom_handling))]
+impl<T: Copy, A: Allocator> SpecCloneFrom for Vec<T, A> {
+    fn clone_from(this: &mut Self, other: &Self) {
+        this.clear();
+        this.extend_from_slice(other);
+    }
+}
+
+#[cfg(not(no_global_oom_handling))]
+#[stable(feature = "rust1", since = "1.0.0")]
+impl<T: Clone, A: Allocator + Clone> Clone for Vec<T, A> {
+    #[cfg(not(test))]
+    fn clone(&self) -> Self {
+        let alloc = self.allocator().clone();
+        <[T]>::to_vec_in(&**self, alloc)
+    }
+
+    // HACK(japaric): with cfg(test) the inherent `[T]::to_vec` method, which is
+    // required for this method definition, is not available. Instead use the
+    // `slice::to_vec`  function which is only available with cfg(test)
+    // NB see the slice::hack module in slice.rs for more information
+    #[cfg(test)]
+    fn clone(&self) -> Self {
+        let alloc = self.allocator().clone();
+        crate::slice::to_vec(&**self, alloc)
+    }
+
+    fn clone_from(&mut self, other: &Self) {
+        SpecCloneFrom::clone_from(self, other)
+    }
+}
+
+/// The hash of a vector is the same as that of the corresponding slice,
+/// as required by the `core::borrow::Borrow` implementation.
+///
+/// ```
+/// #![feature(build_hasher_simple_hash_one)]
+/// use std::hash::BuildHasher;
+///
+/// let b = std::collections::hash_map::RandomState::new();
+/// let v: Vec<u8> = vec![0xa8, 0x3c, 0x09];
+/// let s: &[u8] = &[0xa8, 0x3c, 0x09];
+/// assert_eq!(b.hash_one(v), b.hash_one(s));
+/// ```
+#[stable(feature = "rust1", since = "1.0.0")]
+impl<T: Hash, A: Allocator> Hash for Vec<T, A> {
+    #[inline]
+    fn hash<H: Hasher>(&self, state: &mut H) {
+        Hash::hash(&**self, state)
+    }
+}
+
+#[stable(feature = "rust1", since = "1.0.0")]
+#[rustc_on_unimplemented(
+    message = "vector indices are of type `usize` or ranges of `usize`",
+    label = "vector indices are of type `usize` or ranges of `usize`"
+)]
+impl<T, I: SliceIndex<[T]>, A: Allocator> Index<I> for Vec<T, A> {
+    type Output = I::Output;
+
+    #[inline]
+    fn index(&self, index: I) -> &Self::Output {
+        Index::index(&**self, index)
+    }
+}
+
+#[stable(feature = "rust1", since = "1.0.0")]
+#[rustc_on_unimplemented(
+    message = "vector indices are of type `usize` or ranges of `usize`",
+    label = "vector indices are of type `usize` or ranges of `usize`"
+)]
+impl<T, I: SliceIndex<[T]>, A: Allocator> IndexMut<I> for Vec<T, A> {
+    #[inline]
+    fn index_mut(&mut self, index: I) -> &mut Self::Output {
+        IndexMut::index_mut(&mut **self, index)
+    }
+}
+
+#[cfg(not(no_global_oom_handling))]
+#[stable(feature = "rust1", since = "1.0.0")]
+impl<T> FromIterator<T> for Vec<T> {
+    #[inline]
+    fn from_iter<I: IntoIterator<Item = T>>(iter: I) -> Vec<T> {
+        <Self as SpecFromIter<T, I::IntoIter>>::from_iter(iter.into_iter())
+    }
+}
+
+#[stable(feature = "rust1", since = "1.0.0")]
+impl<T, A: Allocator> IntoIterator for Vec<T, A> {
+    type Item = T;
+    type IntoIter = IntoIter<T, A>;
+
+    /// Creates a consuming iterator, that is, one that moves each value out of
+    /// the vector (from start to end). The vector cannot be used after calling
+    /// this.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let v = vec!["a".to_string(), "b".to_string()];
+    /// for s in v.into_iter() {
+    ///     // s has type String, not &String
+    ///     println!("{s}");
+    /// }
+    /// ```
+    #[inline]
+    fn into_iter(self) -> IntoIter<T, A> {
+        unsafe {
+            let mut me = ManuallyDrop::new(self);
+            let alloc = ManuallyDrop::new(ptr::read(me.allocator()));
+            let begin = me.as_mut_ptr();
+            let end = if mem::size_of::<T>() == 0 {
+                arith_offset(begin as *const i8, me.len() as isize) as *const T
+            } else {
+                begin.add(me.len()) as *const T
+            };
+            let cap = me.buf.capacity();
+            IntoIter {
+                buf: NonNull::new_unchecked(begin),
+                phantom: PhantomData,
+                cap,
+                alloc,
+                ptr: begin,
+                end,
+            }
+        }
+    }
+}
+
+#[stable(feature = "rust1", since = "1.0.0")]
+impl<'a, T, A: Allocator> IntoIterator for &'a Vec<T, A> {
+    type Item = &'a T;
+    type IntoIter = slice::Iter<'a, T>;
+
+    fn into_iter(self) -> slice::Iter<'a, T> {
+        self.iter()
+    }
+}
+
+#[stable(feature = "rust1", since = "1.0.0")]
+impl<'a, T, A: Allocator> IntoIterator for &'a mut Vec<T, A> {
+    type Item = &'a mut T;
+    type IntoIter = slice::IterMut<'a, T>;
+
+    fn into_iter(self) -> slice::IterMut<'a, T> {
+        self.iter_mut()
+    }
+}
+
+#[cfg(not(no_global_oom_handling))]
+#[stable(feature = "rust1", since = "1.0.0")]
+impl<T, A: Allocator> Extend<T> for Vec<T, A> {
+    #[inline]
+    fn extend<I: IntoIterator<Item = T>>(&mut self, iter: I) {
+        <Self as SpecExtend<T, I::IntoIter>>::spec_extend(self, iter.into_iter())
+    }
+
+    #[inline]
+    fn extend_one(&mut self, item: T) {
+        self.push(item);
+    }
+
+    #[inline]
+    fn extend_reserve(&mut self, additional: usize) {
+        self.reserve(additional);
+    }
+}
+
+impl<T, A: Allocator> Vec<T, A> {
+    // leaf method to which various SpecFrom/SpecExtend implementations delegate when
+    // they have no further optimizations to apply
+    #[cfg(not(no_global_oom_handling))]
+    fn extend_desugared<I: Iterator<Item = T>>(&mut self, mut iterator: I) {
+        // This is the case for a general iterator.
+        //
+        // This function should be the moral equivalent of:
+        //
+        //      for item in iterator {
+        //          self.push(item);
+        //      }
+        while let Some(element) = iterator.next() {
+            let len = self.len();
+            if len == self.capacity() {
+                let (lower, _) = iterator.size_hint();
+                self.reserve(lower.saturating_add(1));
+            }
+            unsafe {
+                ptr::write(self.as_mut_ptr().add(len), element);
+                // Since next() executes user code which can panic we have to bump the length
+                // after each step.
+                // NB can't overflow since we would have had to alloc the address space
+                self.set_len(len + 1);
+            }
+        }
+    }
+
+    /// Creates a splicing iterator that replaces the specified range in the vector
+    /// with the given `replace_with` iterator and yields the removed items.
+    /// `replace_with` does not need to be the same length as `range`.
+    ///
+    /// `range` is removed even if the iterator is not consumed until the end.
+    ///
+    /// It is unspecified how many elements are removed from the vector
+    /// if the `Splice` value is leaked.
+    ///
+    /// The input iterator `replace_with` is only consumed when the `Splice` value is dropped.
+    ///
+    /// This is optimal if:
+    ///
+    /// * The tail (elements in the vector after `range`) is empty,
+    /// * or `replace_with` yields fewer or equal elements than `range`’s length
+    /// * or the lower bound of its `size_hint()` is exact.
+    ///
+    /// Otherwise, a temporary vector is allocated and the tail is moved twice.
+    ///
+    /// # Panics
+    ///
+    /// Panics if the starting point is greater than the end point or if
+    /// the end point is greater than the length of the vector.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let mut v = vec![1, 2, 3, 4];
+    /// let new = [7, 8, 9];
+    /// let u: Vec<_> = v.splice(1..3, new).collect();
+    /// assert_eq!(v, &[1, 7, 8, 9, 4]);
+    /// assert_eq!(u, &[2, 3]);
+    /// ```
+    #[cfg(not(no_global_oom_handling))]
+    #[inline]
+    #[stable(feature = "vec_splice", since = "1.21.0")]
+    pub fn splice<R, I>(&mut self, range: R, replace_with: I) -> Splice<'_, I::IntoIter, A>
+    where
+        R: RangeBounds<usize>,
+        I: IntoIterator<Item = T>,
+    {
+        Splice { drain: self.drain(range), replace_with: replace_with.into_iter() }
+    }
+
+    /// Creates an iterator which uses a closure to determine if an element should be removed.
+    ///
+    /// If the closure returns true, then the element is removed and yielded.
+    /// If the closure returns false, the element will remain in the vector and will not be yielded
+    /// by the iterator.
+    ///
+    /// Using this method is equivalent to the following code:
+    ///
+    /// ```
+    /// # let some_predicate = |x: &mut i32| { *x == 2 || *x == 3 || *x == 6 };
+    /// # let mut vec = vec![1, 2, 3, 4, 5, 6];
+    /// let mut i = 0;
+    /// while i < vec.len() {
+    ///     if some_predicate(&mut vec[i]) {
+    ///         let val = vec.remove(i);
+    ///         // your code here
+    ///     } else {
+    ///         i += 1;
+    ///     }
+    /// }
+    ///
+    /// # assert_eq!(vec, vec![1, 4, 5]);
+    /// ```
+    ///
+    /// But `drain_filter` is easier to use. `drain_filter` is also more efficient,
+    /// because it can backshift the elements of the array in bulk.
+    ///
+    /// Note that `drain_filter` also lets you mutate every element in the filter closure,
+    /// regardless of whether you choose to keep or remove it.
+    ///
+    /// # Examples
+    ///
+    /// Splitting an array into evens and odds, reusing the original allocation:
+    ///
+    /// ```
+    /// #![feature(drain_filter)]
+    /// let mut numbers = vec![1, 2, 3, 4, 5, 6, 8, 9, 11, 13, 14, 15];
+    ///
+    /// let evens = numbers.drain_filter(|x| *x % 2 == 0).collect::<Vec<_>>();
+    /// let odds = numbers;
+    ///
+    /// assert_eq!(evens, vec![2, 4, 6, 8, 14]);
+    /// assert_eq!(odds, vec![1, 3, 5, 9, 11, 13, 15]);
+    /// ```
+    #[unstable(feature = "drain_filter", reason = "recently added", issue = "43244")]
+    pub fn drain_filter<F>(&mut self, filter: F) -> DrainFilter<'_, T, F, A>
+    where
+        F: FnMut(&mut T) -> bool,
+    {
+        let old_len = self.len();
+
+        // Guard against us getting leaked (leak amplification)
+        unsafe {
+            self.set_len(0);
+        }
+
+        DrainFilter { vec: self, idx: 0, del: 0, old_len, pred: filter, panic_flag: false }
+    }
+}
+
+/// Extend implementation that copies elements out of references before pushing them onto the Vec.
+///
+/// This implementation is specialized for slice iterators, where it uses [`copy_from_slice`] to
+/// append the entire slice at once.
+///
+/// [`copy_from_slice`]: slice::copy_from_slice
+#[cfg(not(no_global_oom_handling))]
+#[stable(feature = "extend_ref", since = "1.2.0")]
+impl<'a, T: Copy + 'a, A: Allocator + 'a> Extend<&'a T> for Vec<T, A> {
+    fn extend<I: IntoIterator<Item = &'a T>>(&mut self, iter: I) {
+        self.spec_extend(iter.into_iter())
+    }
+
+    #[inline]
+    fn extend_one(&mut self, &item: &'a T) {
+        self.push(item);
+    }
+
+    #[inline]
+    fn extend_reserve(&mut self, additional: usize) {
+        self.reserve(additional);
+    }
+}
+
+/// Implements comparison of vectors, [lexicographically](core::cmp::Ord#lexicographical-comparison).
+#[stable(feature = "rust1", since = "1.0.0")]
+impl<T: PartialOrd, A: Allocator> PartialOrd for Vec<T, A> {
+    #[inline]
+    fn partial_cmp(&self, other: &Self) -> Option<Ordering> {
+        PartialOrd::partial_cmp(&**self, &**other)
+    }
+}
+
+#[stable(feature = "rust1", since = "1.0.0")]
+impl<T: Eq, A: Allocator> Eq for Vec<T, A> {}
+
+/// Implements ordering of vectors, [lexicographically](core::cmp::Ord#lexicographical-comparison).
+#[stable(feature = "rust1", since = "1.0.0")]
+impl<T: Ord, A: Allocator> Ord for Vec<T, A> {
+    #[inline]
+    fn cmp(&self, other: &Self) -> Ordering {
+        Ord::cmp(&**self, &**other)
+    }
+}
+
+#[stable(feature = "rust1", since = "1.0.0")]
+unsafe impl<#[may_dangle] T, A: Allocator> Drop for Vec<T, A> {
+    fn drop(&mut self) {
+        unsafe {
+            // use drop for [T]
+            // use a raw slice to refer to the elements of the vector as weakest necessary type;
+            // could avoid questions of validity in certain cases
+            ptr::drop_in_place(ptr::slice_from_raw_parts_mut(self.as_mut_ptr(), self.len))
+        }
+        // RawVec handles deallocation
+    }
+}
+
+#[stable(feature = "rust1", since = "1.0.0")]
+#[rustc_const_unstable(feature = "const_default_impls", issue = "87864")]
+impl<T> const Default for Vec<T> {
+    /// Creates an empty `Vec<T>`.
+    fn default() -> Vec<T> {
+        Vec::new()
+    }
+}
+
+#[stable(feature = "rust1", since = "1.0.0")]
+impl<T: fmt::Debug, A: Allocator> fmt::Debug for Vec<T, A> {
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
+        fmt::Debug::fmt(&**self, f)
+    }
+}
+
+#[stable(feature = "rust1", since = "1.0.0")]
+impl<T, A: Allocator> AsRef<Vec<T, A>> for Vec<T, A> {
+    fn as_ref(&self) -> &Vec<T, A> {
+        self
+    }
+}
+
+#[stable(feature = "vec_as_mut", since = "1.5.0")]
+impl<T, A: Allocator> AsMut<Vec<T, A>> for Vec<T, A> {
+    fn as_mut(&mut self) -> &mut Vec<T, A> {
+        self
+    }
+}
+
+#[stable(feature = "rust1", since = "1.0.0")]
+impl<T, A: Allocator> AsRef<[T]> for Vec<T, A> {
+    fn as_ref(&self) -> &[T] {
+        self
+    }
+}
+
+#[stable(feature = "vec_as_mut", since = "1.5.0")]
+impl<T, A: Allocator> AsMut<[T]> for Vec<T, A> {
+    fn as_mut(&mut self) -> &mut [T] {
+        self
+    }
+}
+
+#[cfg(not(no_global_oom_handling))]
+#[stable(feature = "rust1", since = "1.0.0")]
+impl<T: Clone> From<&[T]> for Vec<T> {
+    /// Allocate a `Vec<T>` and fill it by cloning `s`'s items.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// assert_eq!(Vec::from(&[1, 2, 3][..]), vec![1, 2, 3]);
+    /// ```
+    #[cfg(not(test))]
+    fn from(s: &[T]) -> Vec<T> {
+        s.to_vec()
+    }
+    #[cfg(test)]
+    fn from(s: &[T]) -> Vec<T> {
+        crate::slice::to_vec(s, Global)
+    }
+}
+
+#[cfg(not(no_global_oom_handling))]
+#[stable(feature = "vec_from_mut", since = "1.19.0")]
+impl<T: Clone> From<&mut [T]> for Vec<T> {
+    /// Allocate a `Vec<T>` and fill it by cloning `s`'s items.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// assert_eq!(Vec::from(&mut [1, 2, 3][..]), vec![1, 2, 3]);
+    /// ```
+    #[cfg(not(test))]
+    fn from(s: &mut [T]) -> Vec<T> {
+        s.to_vec()
+    }
+    #[cfg(test)]
+    fn from(s: &mut [T]) -> Vec<T> {
+        crate::slice::to_vec(s, Global)
+    }
+}
+
+#[cfg(not(no_global_oom_handling))]
+#[stable(feature = "vec_from_array", since = "1.44.0")]
+impl<T, const N: usize> From<[T; N]> for Vec<T> {
+    /// Allocate a `Vec<T>` and move `s`'s items into it.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// assert_eq!(Vec::from([1, 2, 3]), vec![1, 2, 3]);
+    /// ```
+    #[cfg(not(test))]
+    fn from(s: [T; N]) -> Vec<T> {
+        <[T]>::into_vec(box s)
+    }
+
+    #[cfg(test)]
+    fn from(s: [T; N]) -> Vec<T> {
+        crate::slice::into_vec(box s)
+    }
+}
+
+#[stable(feature = "vec_from_cow_slice", since = "1.14.0")]
+impl<'a, T> From<Cow<'a, [T]>> for Vec<T>
+where
+    [T]: ToOwned<Owned = Vec<T>>,
+{
+    /// Convert a clone-on-write slice into a vector.
+    ///
+    /// If `s` already owns a `Vec<T>`, it will be returned directly.
+    /// If `s` is borrowing a slice, a new `Vec<T>` will be allocated and
+    /// filled by cloning `s`'s items into it.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// # use std::borrow::Cow;
+    /// let o: Cow<[i32]> = Cow::Owned(vec![1, 2, 3]);
+    /// let b: Cow<[i32]> = Cow::Borrowed(&[1, 2, 3]);
+    /// assert_eq!(Vec::from(o), Vec::from(b));
+    /// ```
+    fn from(s: Cow<'a, [T]>) -> Vec<T> {
+        s.into_owned()
+    }
+}
+
+// note: test pulls in libstd, which causes errors here
+#[cfg(not(test))]
+#[stable(feature = "vec_from_box", since = "1.18.0")]
+impl<T, A: Allocator> From<Box<[T], A>> for Vec<T, A> {
+    /// Convert a boxed slice into a vector by transferring ownership of
+    /// the existing heap allocation.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let b: Box<[i32]> = vec![1, 2, 3].into_boxed_slice();
+    /// assert_eq!(Vec::from(b), vec![1, 2, 3]);
+    /// ```
+    fn from(s: Box<[T], A>) -> Self {
+        s.into_vec()
+    }
+}
+
+// note: test pulls in libstd, which causes errors here
+#[cfg(not(no_global_oom_handling))]
+#[cfg(not(test))]
+#[stable(feature = "box_from_vec", since = "1.20.0")]
+impl<T, A: Allocator> From<Vec<T, A>> for Box<[T], A> {
+    /// Convert a vector into a boxed slice.
+    ///
+    /// If `v` has excess capacity, its items will be moved into a
+    /// newly-allocated buffer with exactly the right capacity.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// assert_eq!(Box::from(vec![1, 2, 3]), vec![1, 2, 3].into_boxed_slice());
+    /// ```
+    fn from(v: Vec<T, A>) -> Self {
+        v.into_boxed_slice()
+    }
+}
+
+#[cfg(not(no_global_oom_handling))]
+#[stable(feature = "rust1", since = "1.0.0")]
+impl From<&str> for Vec<u8> {
+    /// Allocate a `Vec<u8>` and fill it with a UTF-8 string.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// assert_eq!(Vec::from("123"), vec![b'1', b'2', b'3']);
+    /// ```
+    fn from(s: &str) -> Vec<u8> {
+        From::from(s.as_bytes())
+    }
+}
+
+#[stable(feature = "array_try_from_vec", since = "1.48.0")]
+impl<T, A: Allocator, const N: usize> TryFrom<Vec<T, A>> for [T; N] {
+    type Error = Vec<T, A>;
+
+    /// Gets the entire contents of the `Vec<T>` as an array,
+    /// if its size exactly matches that of the requested array.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// assert_eq!(vec![1, 2, 3].try_into(), Ok([1, 2, 3]));
+    /// assert_eq!(<Vec<i32>>::new().try_into(), Ok([]));
+    /// ```
+    ///
+    /// If the length doesn't match, the input comes back in `Err`:
+    /// ```
+    /// let r: Result<[i32; 4], _> = (0..10).collect::<Vec<_>>().try_into();
+    /// assert_eq!(r, Err(vec![0, 1, 2, 3, 4, 5, 6, 7, 8, 9]));
+    /// ```
+    ///
+    /// If you're fine with just getting a prefix of the `Vec<T>`,
+    /// you can call [`.truncate(N)`](Vec::truncate) first.
+    /// ```
+    /// let mut v = String::from("hello world").into_bytes();
+    /// v.sort();
+    /// v.truncate(2);
+    /// let [a, b]: [_; 2] = v.try_into().unwrap();
+    /// assert_eq!(a, b' ');
+    /// assert_eq!(b, b'd');
+    /// ```
+    fn try_from(mut vec: Vec<T, A>) -> Result<[T; N], Vec<T, A>> {
+        if vec.len() != N {
+            return Err(vec);
+        }
+
+        // SAFETY: `.set_len(0)` is always sound.
+        unsafe { vec.set_len(0) };
+
+        // SAFETY: A `Vec`'s pointer is always aligned properly, and
+        // the alignment the array needs is the same as the items.
+        // We checked earlier that we have sufficient items.
+        // The items will not double-drop as the `set_len`
+        // tells the `Vec` not to also drop them.
+        let array = unsafe { ptr::read(vec.as_ptr() as *const [T; N]) };
+        Ok(array)
+    }
+}
diff --git a/rust/alloc/vec/partial_eq.rs b/rust/alloc/vec/partial_eq.rs
new file mode 100644
index 000000000000..b0cf72577a1b
--- /dev/null
+++ b/rust/alloc/vec/partial_eq.rs
@@ -0,0 +1,47 @@
+use crate::alloc::Allocator;
+#[cfg(not(no_global_oom_handling))]
+use crate::borrow::Cow;
+
+use super::Vec;
+
+macro_rules! __impl_slice_eq1 {
+    ([$($vars:tt)*] $lhs:ty, $rhs:ty $(where $ty:ty: $bound:ident)?, #[$stability:meta]) => {
+        #[$stability]
+        impl<T, U, $($vars)*> PartialEq<$rhs> for $lhs
+        where
+            T: PartialEq<U>,
+            $($ty: $bound)?
+        {
+            #[inline]
+            fn eq(&self, other: &$rhs) -> bool { self[..] == other[..] }
+            #[inline]
+            fn ne(&self, other: &$rhs) -> bool { self[..] != other[..] }
+        }
+    }
+}
+
+__impl_slice_eq1! { [A1: Allocator, A2: Allocator] Vec<T, A1>, Vec<U, A2>, #[stable(feature = "rust1", since = "1.0.0")] }
+__impl_slice_eq1! { [A: Allocator] Vec<T, A>, &[U], #[stable(feature = "rust1", since = "1.0.0")] }
+__impl_slice_eq1! { [A: Allocator] Vec<T, A>, &mut [U], #[stable(feature = "rust1", since = "1.0.0")] }
+__impl_slice_eq1! { [A: Allocator] &[T], Vec<U, A>, #[stable(feature = "partialeq_vec_for_ref_slice", since = "1.46.0")] }
+__impl_slice_eq1! { [A: Allocator] &mut [T], Vec<U, A>, #[stable(feature = "partialeq_vec_for_ref_slice", since = "1.46.0")] }
+__impl_slice_eq1! { [A: Allocator] Vec<T, A>, [U], #[stable(feature = "partialeq_vec_for_slice", since = "1.48.0")]  }
+__impl_slice_eq1! { [A: Allocator] [T], Vec<U, A>, #[stable(feature = "partialeq_vec_for_slice", since = "1.48.0")]  }
+#[cfg(not(no_global_oom_handling))]
+__impl_slice_eq1! { [A: Allocator] Cow<'_, [T]>, Vec<U, A> where T: Clone, #[stable(feature = "rust1", since = "1.0.0")] }
+#[cfg(not(no_global_oom_handling))]
+__impl_slice_eq1! { [] Cow<'_, [T]>, &[U] where T: Clone, #[stable(feature = "rust1", since = "1.0.0")] }
+#[cfg(not(no_global_oom_handling))]
+__impl_slice_eq1! { [] Cow<'_, [T]>, &mut [U] where T: Clone, #[stable(feature = "rust1", since = "1.0.0")] }
+__impl_slice_eq1! { [A: Allocator, const N: usize] Vec<T, A>, [U; N], #[stable(feature = "rust1", since = "1.0.0")] }
+__impl_slice_eq1! { [A: Allocator, const N: usize] Vec<T, A>, &[U; N], #[stable(feature = "rust1", since = "1.0.0")] }
+
+// NOTE: some less important impls are omitted to reduce code bloat
+// FIXME(Centril): Reconsider this?
+//__impl_slice_eq1! { [const N: usize] Vec<A>, &mut [B; N], }
+//__impl_slice_eq1! { [const N: usize] [A; N], Vec<B>, }
+//__impl_slice_eq1! { [const N: usize] &[A; N], Vec<B>, }
+//__impl_slice_eq1! { [const N: usize] &mut [A; N], Vec<B>, }
+//__impl_slice_eq1! { [const N: usize] Cow<'a, [A]>, [B; N], }
+//__impl_slice_eq1! { [const N: usize] Cow<'a, [A]>, &[B; N], }
+//__impl_slice_eq1! { [const N: usize] Cow<'a, [A]>, &mut [B; N], }
-- 
2.37.1

