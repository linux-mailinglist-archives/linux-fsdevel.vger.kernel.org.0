Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C32A58AD6E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Aug 2022 17:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241100AbiHEPrg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Aug 2022 11:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241196AbiHEPoV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Aug 2022 11:44:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6290B6612E;
        Fri,  5 Aug 2022 08:43:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 53CEA615C6;
        Fri,  5 Aug 2022 15:43:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81E61C433C1;
        Fri,  5 Aug 2022 15:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659714229;
        bh=slgwV/az7e67BsljPAkc99RgS5lD/fhwFH7EJIGNMKc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=op5i8vowVxO3u4bXZQphI+GgMZjrfYLMY/VbhEWQ6EO5uJEGpwaIWfYTNLWCaOzRn
         iFsq+Cc4oWzrJAoycCef1ARyhAQZlkbnTR+rBHea26Pb+u0PxM+6NnLymkok9QeLte
         sII+4ap7GT+5G1w+kG26bm+ILecapBCF9QmgHorq3lFuOYzlwqNIL6q2zs2nqe8lEC
         IBgIPYwLAv7tzTyuZcZkMc/6a3wtTN2tGyM6Zidm/vQJiJhuSvF2Rso+OFJlN1WrYN
         kIR0MRzeFjbM20EXtWyRzpEmQiV+vruvUo92Jr9fbQ3zVOe6haiAwHBw/Rmz3o/EcM
         9700se9HDkDRQ==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, patches@lists.linux.dev,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Geoffrey Thomas <geofft@ldpreload.com>,
        Finn Behrens <me@kloenk.de>,
        Adam Bratschi-Kaye <ark.email@gmail.com>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        Boris-Chengbiao Zhou <bobo1239@web.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Fox Chen <foxhlchen@gmail.com>,
        Viktor Garske <viktor@v-gar.de>,
        Dariusz Sosnowski <dsosnowski@dsosnowski.pl>,
        =?UTF-8?q?L=C3=A9o=20Lanteri=20Thauvin?= 
        <leseulartichaut@gmail.com>, Niklas Mohrin <dev@niklasmohrin.de>,
        Milan Landaverde <milan@mdaverde.com>,
        Morgan Bartlett <mjmouse9999@gmail.com>,
        Maciej Falkowski <m.falkowski@samsung.com>,
        =?UTF-8?q?N=C3=A1ndor=20Istv=C3=A1n=20Kr=C3=A1cser?= 
        <bonifaido@gmail.com>, David Gow <davidgow@google.com>,
        John Baublitz <john.m.baublitz@gmail.com>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>
Subject: [PATCH v9 12/27] rust: add `kernel` crate
Date:   Fri,  5 Aug 2022 17:41:57 +0200
Message-Id: <20220805154231.31257-13-ojeda@kernel.org>
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

From: Wedson Almeida Filho <wedsonaf@google.com>

The `kernel` crate currently includes all the abstractions that wrap
kernel features written in C.

These abstractions call the C side of the kernel via the generated
bindings with the `bindgen` tool. Modules developed in Rust should
never call the bindings themselves.

In the future, as the abstractions grow in number, we may need
to split this crate into several, possibly following a similar
subdivision in subsystems as the kernel itself and/or moving
the code to the actual subsystems.

Co-developed-by: Alex Gaynor <alex.gaynor@gmail.com>
Signed-off-by: Alex Gaynor <alex.gaynor@gmail.com>
Co-developed-by: Geoffrey Thomas <geofft@ldpreload.com>
Signed-off-by: Geoffrey Thomas <geofft@ldpreload.com>
Co-developed-by: Finn Behrens <me@kloenk.de>
Signed-off-by: Finn Behrens <me@kloenk.de>
Co-developed-by: Adam Bratschi-Kaye <ark.email@gmail.com>
Signed-off-by: Adam Bratschi-Kaye <ark.email@gmail.com>
Co-developed-by: Sven Van Asbroeck <thesven73@gmail.com>
Signed-off-by: Sven Van Asbroeck <thesven73@gmail.com>
Co-developed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Gary Guo <gary@garyguo.net>
Co-developed-by: Boris-Chengbiao Zhou <bobo1239@web.de>
Signed-off-by: Boris-Chengbiao Zhou <bobo1239@web.de>
Co-developed-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Co-developed-by: Fox Chen <foxhlchen@gmail.com>
Signed-off-by: Fox Chen <foxhlchen@gmail.com>
Co-developed-by: Viktor Garske <viktor@v-gar.de>
Signed-off-by: Viktor Garske <viktor@v-gar.de>
Co-developed-by: Dariusz Sosnowski <dsosnowski@dsosnowski.pl>
Signed-off-by: Dariusz Sosnowski <dsosnowski@dsosnowski.pl>
Co-developed-by: Léo Lanteri Thauvin <leseulartichaut@gmail.com>
Signed-off-by: Léo Lanteri Thauvin <leseulartichaut@gmail.com>
Co-developed-by: Niklas Mohrin <dev@niklasmohrin.de>
Signed-off-by: Niklas Mohrin <dev@niklasmohrin.de>
Co-developed-by: Milan Landaverde <milan@mdaverde.com>
Signed-off-by: Milan Landaverde <milan@mdaverde.com>
Co-developed-by: Morgan Bartlett <mjmouse9999@gmail.com>
Signed-off-by: Morgan Bartlett <mjmouse9999@gmail.com>
Co-developed-by: Maciej Falkowski <m.falkowski@samsung.com>
Signed-off-by: Maciej Falkowski <m.falkowski@samsung.com>
Co-developed-by: Nándor István Krácser <bonifaido@gmail.com>
Signed-off-by: Nándor István Krácser <bonifaido@gmail.com>
Co-developed-by: David Gow <davidgow@google.com>
Signed-off-by: David Gow <davidgow@google.com>
Co-developed-by: John Baublitz <john.m.baublitz@gmail.com>
Signed-off-by: John Baublitz <john.m.baublitz@gmail.com>
Co-developed-by: Björn Roy Baron <bjorn3_gh@protonmail.com>
Signed-off-by: Björn Roy Baron <bjorn3_gh@protonmail.com>
Signed-off-by: Wedson Almeida Filho <wedsonaf@google.com>
Co-developed-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 rust/kernel/allocator.rs |  64 +++++++++++++
 rust/kernel/error.rs     |  59 ++++++++++++
 rust/kernel/lib.rs       |  78 +++++++++++++++
 rust/kernel/prelude.rs   |  20 ++++
 rust/kernel/print.rs     | 198 +++++++++++++++++++++++++++++++++++++++
 rust/kernel/str.rs       |  72 ++++++++++++++
 6 files changed, 491 insertions(+)
 create mode 100644 rust/kernel/allocator.rs
 create mode 100644 rust/kernel/error.rs
 create mode 100644 rust/kernel/lib.rs
 create mode 100644 rust/kernel/prelude.rs
 create mode 100644 rust/kernel/print.rs
 create mode 100644 rust/kernel/str.rs

diff --git a/rust/kernel/allocator.rs b/rust/kernel/allocator.rs
new file mode 100644
index 000000000000..397a3dd57a9b
--- /dev/null
+++ b/rust/kernel/allocator.rs
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Allocator support.
+
+use core::alloc::{GlobalAlloc, Layout};
+use core::ptr;
+
+use crate::bindings;
+
+struct KernelAllocator;
+
+unsafe impl GlobalAlloc for KernelAllocator {
+    unsafe fn alloc(&self, layout: Layout) -> *mut u8 {
+        // `krealloc()` is used instead of `kmalloc()` because the latter is
+        // an inline function and cannot be bound to as a result.
+        unsafe { bindings::krealloc(ptr::null(), layout.size(), bindings::GFP_KERNEL) as *mut u8 }
+    }
+
+    unsafe fn dealloc(&self, ptr: *mut u8, _layout: Layout) {
+        unsafe {
+            bindings::kfree(ptr as *const core::ffi::c_void);
+        }
+    }
+}
+
+#[global_allocator]
+static ALLOCATOR: KernelAllocator = KernelAllocator;
+
+// `rustc` only generates these for some crate types. Even then, we would need
+// to extract the object file that has them from the archive. For the moment,
+// let's generate them ourselves instead.
+//
+// Note that `#[no_mangle]` implies exported too, nowadays.
+#[no_mangle]
+fn __rust_alloc(size: usize, _align: usize) -> *mut u8 {
+    unsafe { bindings::krealloc(core::ptr::null(), size, bindings::GFP_KERNEL) as *mut u8 }
+}
+
+#[no_mangle]
+fn __rust_dealloc(ptr: *mut u8, _size: usize, _align: usize) {
+    unsafe { bindings::kfree(ptr as *const core::ffi::c_void) };
+}
+
+#[no_mangle]
+fn __rust_realloc(ptr: *mut u8, _old_size: usize, _align: usize, new_size: usize) -> *mut u8 {
+    unsafe {
+        bindings::krealloc(
+            ptr as *const core::ffi::c_void,
+            new_size,
+            bindings::GFP_KERNEL,
+        ) as *mut u8
+    }
+}
+
+#[no_mangle]
+fn __rust_alloc_zeroed(size: usize, _align: usize) -> *mut u8 {
+    unsafe {
+        bindings::krealloc(
+            core::ptr::null(),
+            size,
+            bindings::GFP_KERNEL | bindings::__GFP_ZERO,
+        ) as *mut u8
+    }
+}
diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
new file mode 100644
index 000000000000..466b2a8fe569
--- /dev/null
+++ b/rust/kernel/error.rs
@@ -0,0 +1,59 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Kernel errors.
+//!
+//! C header: [`include/uapi/asm-generic/errno-base.h`](../../../include/uapi/asm-generic/errno-base.h)
+
+use alloc::collections::TryReserveError;
+
+/// Contains the C-compatible error codes.
+pub mod code {
+    /// Out of memory.
+    pub const ENOMEM: super::Error = super::Error(-(crate::bindings::ENOMEM as i32));
+}
+
+/// Generic integer kernel error.
+///
+/// The kernel defines a set of integer generic error codes based on C and
+/// POSIX ones. These codes may have a more specific meaning in some contexts.
+///
+/// # Invariants
+///
+/// The value is a valid `errno` (i.e. `>= -MAX_ERRNO && < 0`).
+#[derive(Clone, Copy, PartialEq, Eq)]
+pub struct Error(core::ffi::c_int);
+
+impl Error {
+    /// Returns the kernel error code.
+    pub fn to_kernel_errno(self) -> core::ffi::c_int {
+        self.0
+    }
+}
+
+impl From<TryReserveError> for Error {
+    fn from(_: TryReserveError) -> Error {
+        code::ENOMEM
+    }
+}
+
+/// A [`Result`] with an [`Error`] error type.
+///
+/// To be used as the return type for functions that may fail.
+///
+/// # Error codes in C and Rust
+///
+/// In C, it is common that functions indicate success or failure through
+/// their return value; modifying or returning extra data through non-`const`
+/// pointer parameters. In particular, in the kernel, functions that may fail
+/// typically return an `int` that represents a generic error code. We model
+/// those as [`Error`].
+///
+/// In Rust, it is idiomatic to model functions that may fail as returning
+/// a [`Result`]. Since in the kernel many functions return an error code,
+/// [`Result`] is a type alias for a [`core::result::Result`] that uses
+/// [`Error`] as its error type.
+///
+/// Note that even if a function does not return anything when it succeeds,
+/// it should still be modeled as returning a `Result` rather than
+/// just an [`Error`].
+pub type Result<T = ()> = core::result::Result<T, Error>;
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
new file mode 100644
index 000000000000..abd46261d385
--- /dev/null
+++ b/rust/kernel/lib.rs
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! The `kernel` crate.
+//!
+//! This crate contains the kernel APIs that have been ported or wrapped for
+//! usage by Rust code in the kernel and is shared by all of them.
+//!
+//! In other words, all the rest of the Rust code in the kernel (e.g. kernel
+//! modules written in Rust) depends on [`core`], [`alloc`] and this crate.
+//!
+//! If you need a kernel C API that is not ported or wrapped yet here, then
+//! do so first instead of bypassing this crate.
+
+#![no_std]
+#![feature(core_ffi_c)]
+
+// Ensure conditional compilation based on the kernel configuration works;
+// otherwise we may silently break things like initcall handling.
+#[cfg(not(CONFIG_RUST))]
+compile_error!("Missing kernel configuration for conditional compilation");
+
+#[cfg(not(test))]
+#[cfg(not(testlib))]
+mod allocator;
+pub mod error;
+pub mod prelude;
+pub mod print;
+pub mod str;
+
+#[doc(hidden)]
+pub use bindings;
+pub use macros;
+
+/// Prefix to appear before log messages printed from within the `kernel` crate.
+const __LOG_PREFIX: &[u8] = b"rust_kernel\0";
+
+/// The top level entrypoint to implementing a kernel module.
+///
+/// For any teardown or cleanup operations, your type may implement [`Drop`].
+pub trait Module: Sized + Sync {
+    /// Called at module initialization time.
+    ///
+    /// Use this method to perform whatever setup or registration your module
+    /// should do.
+    ///
+    /// Equivalent to the `module_init` macro in the C API.
+    fn init(module: &'static ThisModule) -> error::Result<Self>;
+}
+
+/// Equivalent to `THIS_MODULE` in the C API.
+///
+/// C header: `include/linux/export.h`
+pub struct ThisModule(*mut bindings::module);
+
+// SAFETY: `THIS_MODULE` may be used from all threads within a module.
+unsafe impl Sync for ThisModule {}
+
+impl ThisModule {
+    /// Creates a [`ThisModule`] given the `THIS_MODULE` pointer.
+    ///
+    /// # Safety
+    ///
+    /// The pointer must be equal to the right `THIS_MODULE`.
+    pub const unsafe fn from_ptr(ptr: *mut bindings::module) -> ThisModule {
+        ThisModule(ptr)
+    }
+}
+
+#[cfg(not(any(testlib, test)))]
+#[panic_handler]
+fn panic(info: &core::panic::PanicInfo<'_>) -> ! {
+    pr_emerg!("{}\n", info);
+    // SAFETY: FFI call.
+    unsafe { bindings::BUG() };
+    // Bindgen currently does not recognize `__noreturn` so `BUG` returns `()`
+    // instead of `!`. See <https://github.com/rust-lang/rust-bindgen/issues/2094>.
+    loop {}
+}
diff --git a/rust/kernel/prelude.rs b/rust/kernel/prelude.rs
new file mode 100644
index 000000000000..495e22250726
--- /dev/null
+++ b/rust/kernel/prelude.rs
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! The `kernel` prelude.
+//!
+//! These are the most common items used by Rust code in the kernel,
+//! intended to be imported by all Rust code, for convenience.
+//!
+//! # Examples
+//!
+//! ```
+//! use kernel::prelude::*;
+//! ```
+
+pub use super::{
+    error::{Error, Result},
+    pr_emerg, pr_info, ThisModule,
+};
+pub use alloc::{boxed::Box, vec::Vec};
+pub use core::pin::Pin;
+pub use macros::module;
diff --git a/rust/kernel/print.rs b/rust/kernel/print.rs
new file mode 100644
index 000000000000..55db5a1ba752
--- /dev/null
+++ b/rust/kernel/print.rs
@@ -0,0 +1,198 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Printing facilities.
+//!
+//! C header: [`include/linux/printk.h`](../../../../include/linux/printk.h)
+//!
+//! Reference: <https://www.kernel.org/doc/html/latest/core-api/printk-basics.html>
+
+use core::{
+    ffi::{c_char, c_void},
+    fmt,
+};
+
+use crate::str::RawFormatter;
+
+#[cfg(CONFIG_PRINTK)]
+use crate::bindings;
+
+// Called from `vsprintf` with format specifier `%pA`.
+#[no_mangle]
+unsafe fn rust_fmt_argument(buf: *mut c_char, end: *mut c_char, ptr: *const c_void) -> *mut c_char {
+    use fmt::Write;
+    // SAFETY: The C contract guarantees that `buf` is valid if it's less than `end`.
+    let mut w = unsafe { RawFormatter::from_ptrs(buf.cast(), end.cast()) };
+    let _ = w.write_fmt(unsafe { *(ptr as *const fmt::Arguments<'_>) });
+    w.pos().cast()
+}
+
+/// Format strings.
+///
+/// Public but hidden since it should only be used from public macros.
+#[doc(hidden)]
+pub mod format_strings {
+    use crate::bindings;
+
+    /// The length we copy from the `KERN_*` kernel prefixes.
+    const LENGTH_PREFIX: usize = 2;
+
+    /// The length of the fixed format strings.
+    pub const LENGTH: usize = 10;
+
+    /// Generates a fixed format string for the kernel's [`_printk`].
+    ///
+    /// The format string is always the same for a given level, i.e. for a
+    /// given `prefix`, which are the kernel's `KERN_*` constants.
+    ///
+    /// [`_printk`]: ../../../../include/linux/printk.h
+    const fn generate(is_cont: bool, prefix: &[u8; 3]) -> [u8; LENGTH] {
+        // Ensure the `KERN_*` macros are what we expect.
+        assert!(prefix[0] == b'\x01');
+        if is_cont {
+            assert!(prefix[1] == b'c');
+        } else {
+            assert!(prefix[1] >= b'0' && prefix[1] <= b'7');
+        }
+        assert!(prefix[2] == b'\x00');
+
+        let suffix: &[u8; LENGTH - LENGTH_PREFIX] = if is_cont {
+            b"%pA\0\0\0\0\0"
+        } else {
+            b"%s: %pA\0"
+        };
+
+        [
+            prefix[0], prefix[1], suffix[0], suffix[1], suffix[2], suffix[3], suffix[4], suffix[5],
+            suffix[6], suffix[7],
+        ]
+    }
+
+    // Generate the format strings at compile-time.
+    //
+    // This avoids the compiler generating the contents on the fly in the stack.
+    //
+    // Furthermore, `static` instead of `const` is used to share the strings
+    // for all the kernel.
+    pub static EMERG: [u8; LENGTH] = generate(false, bindings::KERN_EMERG);
+    pub static INFO: [u8; LENGTH] = generate(false, bindings::KERN_INFO);
+}
+
+/// Prints a message via the kernel's [`_printk`].
+///
+/// Public but hidden since it should only be used from public macros.
+///
+/// # Safety
+///
+/// The format string must be one of the ones in [`format_strings`], and
+/// the module name must be null-terminated.
+///
+/// [`_printk`]: ../../../../include/linux/_printk.h
+#[doc(hidden)]
+#[cfg_attr(not(CONFIG_PRINTK), allow(unused_variables))]
+pub unsafe fn call_printk(
+    format_string: &[u8; format_strings::LENGTH],
+    module_name: &[u8],
+    args: fmt::Arguments<'_>,
+) {
+    // `_printk` does not seem to fail in any path.
+    #[cfg(CONFIG_PRINTK)]
+    unsafe {
+        bindings::_printk(
+            format_string.as_ptr() as _,
+            module_name.as_ptr(),
+            &args as *const _ as *const c_void,
+        );
+    }
+}
+
+/// Performs formatting and forwards the string to [`call_printk`].
+///
+/// Public but hidden since it should only be used from public macros.
+#[doc(hidden)]
+#[cfg(not(testlib))]
+#[macro_export]
+#[allow(clippy::crate_in_macro_def)]
+macro_rules! print_macro (
+    // The non-continuation cases (most of them, e.g. `INFO`).
+    ($format_string:path, $($arg:tt)+) => (
+        // SAFETY: This hidden macro should only be called by the documented
+        // printing macros which ensure the format string is one of the fixed
+        // ones. All `__LOG_PREFIX`s are null-terminated as they are generated
+        // by the `module!` proc macro or fixed values defined in a kernel
+        // crate.
+        unsafe {
+            $crate::print::call_printk(
+                &$format_string,
+                crate::__LOG_PREFIX,
+                format_args!($($arg)+),
+            );
+        }
+    );
+);
+
+/// Stub for doctests
+#[cfg(testlib)]
+#[macro_export]
+macro_rules! print_macro (
+    ($format_string:path, $e:expr, $($arg:tt)+) => (
+        ()
+    );
+);
+
+// We could use a macro to generate these macros. However, doing so ends
+// up being a bit ugly: it requires the dollar token trick to escape `$` as
+// well as playing with the `doc` attribute. Furthermore, they cannot be easily
+// imported in the prelude due to [1]. So, for the moment, we just write them
+// manually, like in the C side; while keeping most of the logic in another
+// macro, i.e. [`print_macro`].
+//
+// [1]: https://github.com/rust-lang/rust/issues/52234
+
+/// Prints an emergency-level message (level 0).
+///
+/// Use this level if the system is unusable.
+///
+/// Equivalent to the kernel's [`pr_emerg`] macro.
+///
+/// Mimics the interface of [`std::print!`]. See [`core::fmt`] and
+/// `alloc::format!` for information about the formatting syntax.
+///
+/// [`pr_emerg`]: https://www.kernel.org/doc/html/latest/core-api/printk-basics.html#c.pr_emerg
+/// [`std::print!`]: https://doc.rust-lang.org/std/macro.print.html
+///
+/// # Examples
+///
+/// ```
+/// pr_emerg!("hello {}\n", "there");
+/// ```
+#[macro_export]
+macro_rules! pr_emerg (
+    ($($arg:tt)*) => (
+        $crate::print_macro!($crate::print::format_strings::EMERG, $($arg)*)
+    )
+);
+
+/// Prints an info-level message (level 6).
+///
+/// Use this level for informational messages.
+///
+/// Equivalent to the kernel's [`pr_info`] macro.
+///
+/// Mimics the interface of [`std::print!`]. See [`core::fmt`] and
+/// `alloc::format!` for information about the formatting syntax.
+///
+/// [`pr_info`]: https://www.kernel.org/doc/html/latest/core-api/printk-basics.html#c.pr_info
+/// [`std::print!`]: https://doc.rust-lang.org/std/macro.print.html
+///
+/// # Examples
+///
+/// ```
+/// pr_info!("hello {}\n", "there");
+/// ```
+#[macro_export]
+#[doc(alias = "print")]
+macro_rules! pr_info (
+    ($($arg:tt)*) => (
+        $crate::print_macro!($crate::print::format_strings::INFO, $($arg)*)
+    )
+);
diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
new file mode 100644
index 000000000000..e45ff220ae50
--- /dev/null
+++ b/rust/kernel/str.rs
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! String representations.
+
+use core::fmt;
+
+/// Allows formatting of [`fmt::Arguments`] into a raw buffer.
+///
+/// It does not fail if callers write past the end of the buffer so that they can calculate the
+/// size required to fit everything.
+///
+/// # Invariants
+///
+/// The memory region between `pos` (inclusive) and `end` (exclusive) is valid for writes if `pos`
+/// is less than `end`.
+pub(crate) struct RawFormatter {
+    // Use `usize` to use `saturating_*` functions.
+    #[allow(dead_code)]
+    beg: usize,
+    pos: usize,
+    end: usize,
+}
+
+impl RawFormatter {
+    /// Creates a new instance of [`RawFormatter`] with the given buffer pointers.
+    ///
+    /// # Safety
+    ///
+    /// If `pos` is less than `end`, then the region between `pos` (inclusive) and `end`
+    /// (exclusive) must be valid for writes for the lifetime of the returned [`RawFormatter`].
+    pub(crate) unsafe fn from_ptrs(pos: *mut u8, end: *mut u8) -> Self {
+        // INVARIANT: The safety requierments guarantee the type invariants.
+        Self {
+            beg: pos as _,
+            pos: pos as _,
+            end: end as _,
+        }
+    }
+
+    /// Returns the current insert position.
+    ///
+    /// N.B. It may point to invalid memory.
+    pub(crate) fn pos(&self) -> *mut u8 {
+        self.pos as _
+    }
+}
+
+impl fmt::Write for RawFormatter {
+    fn write_str(&mut self, s: &str) -> fmt::Result {
+        // `pos` value after writing `len` bytes. This does not have to be bounded by `end`, but we
+        // don't want it to wrap around to 0.
+        let pos_new = self.pos.saturating_add(s.len());
+
+        // Amount that we can copy. `saturating_sub` ensures we get 0 if `pos` goes past `end`.
+        let len_to_copy = core::cmp::min(pos_new, self.end).saturating_sub(self.pos);
+
+        if len_to_copy > 0 {
+            // SAFETY: If `len_to_copy` is non-zero, then we know `pos` has not gone past `end`
+            // yet, so it is valid for write per the type invariants.
+            unsafe {
+                core::ptr::copy_nonoverlapping(
+                    s.as_bytes().as_ptr(),
+                    self.pos as *mut u8,
+                    len_to_copy,
+                )
+            };
+        }
+
+        self.pos = pos_new;
+        Ok(())
+    }
+}
-- 
2.37.1

