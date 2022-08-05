Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04DBD58AD3E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Aug 2022 17:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241193AbiHEPoV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Aug 2022 11:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241094AbiHEPns (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Aug 2022 11:43:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC5B6C10C;
        Fri,  5 Aug 2022 08:43:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 069C3615C6;
        Fri,  5 Aug 2022 15:43:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53C1FC433D6;
        Fri,  5 Aug 2022 15:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659714208;
        bh=HAOVdUxq8jaN8hxBkozTGyjLT+4FNugXXDXdhGZG6tM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TG5HU1rY8S9DwUmYZgxqLqU10+KlNkaUdM9NTaBd6ZpLgR8kW4RWS9MTDglqsQn1H
         eiKYCzB1EG2vzK5YD4AEehkoFmdggEIzYUDMjCIamx4m4VOkrf6Xabu93J9ssxshy0
         eS6Ss+yjs5n2pH8qf+61LsRmxw6gjEazKzTc5EWa+LsvdC+XrZuqy/bdAI+M8V2tXg
         5G4S8ePEJrq1Q89AXW7g/KLZCF3G+YkHSQooGYuyE4yn0gtoahq5TqznR/FFXEud7D
         ryiiwXlXtr+Vc3GsBpGnEq9aoHYnjHPRVJYCbOhswWbkZlJY9574dhQL+rE9459RLq
         JHnMT/Y1MHq+A==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, patches@lists.linux.dev,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Gary Guo <gary@garyguo.net>, Matthew Bakhtiari <dev@mtbk.me>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>
Subject: [PATCH v9 08/27] rust: adapt `alloc` crate to the kernel
Date:   Fri,  5 Aug 2022 17:41:53 +0200
Message-Id: <20220805154231.31257-9-ojeda@kernel.org>
In-Reply-To: <20220805154231.31257-1-ojeda@kernel.org>
References: <20220805154231.31257-1-ojeda@kernel.org>
MIME-Version: 1.0
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

This customizes the subset of the Rust standard library `alloc` that
was just imported as-is, mainly by:

  - Adding SPDX license identifiers.

  - Skipping modules (e.g. `rc` and `sync`) via new `cfg`s.

  - Adding fallible (`try_*`) versions of existing infallible methods
    (i.e. returning a `Result` instead of panicking).

    Since the standard library requires stable/unstable attributes,
    these additions are annotated with:

        #[stable(feature = "kernel", since = "1.0.0")]

    Using "kernel" as the feature allows to have the additions
    clearly marked. The "1.0.0" version is just a placeholder.

    (At the moment, only one is needed, but in the future more
    fallible methods will be added).

Co-developed-by: Alex Gaynor <alex.gaynor@gmail.com>
Signed-off-by: Alex Gaynor <alex.gaynor@gmail.com>
Co-developed-by: Wedson Almeida Filho <wedsonaf@google.com>
Signed-off-by: Wedson Almeida Filho <wedsonaf@google.com>
Co-developed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Gary Guo <gary@garyguo.net>
Co-developed-by: Matthew Bakhtiari <dev@mtbk.me>
Signed-off-by: Matthew Bakhtiari <dev@mtbk.me>
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 rust/alloc/README.md           | 33 +++++++++++++++++++++++++++++++++
 rust/alloc/alloc.rs            |  2 ++
 rust/alloc/borrow.rs           |  4 +++-
 rust/alloc/boxed.rs            |  4 ++++
 rust/alloc/collections/mod.rs  |  2 ++
 rust/alloc/lib.rs              |  8 ++++++++
 rust/alloc/raw_vec.rs          |  9 +++++++++
 rust/alloc/slice.rs            |  2 ++
 rust/alloc/vec/drain.rs        |  2 ++
 rust/alloc/vec/drain_filter.rs |  2 ++
 rust/alloc/vec/into_iter.rs    |  4 ++++
 rust/alloc/vec/is_zero.rs      |  2 ++
 rust/alloc/vec/mod.rs          | 25 +++++++++++++++++++++++++
 rust/alloc/vec/partial_eq.rs   |  2 ++
 14 files changed, 100 insertions(+), 1 deletion(-)
 create mode 100644 rust/alloc/README.md

diff --git a/rust/alloc/README.md b/rust/alloc/README.md
new file mode 100644
index 000000000000..c89c753720b5
--- /dev/null
+++ b/rust/alloc/README.md
@@ -0,0 +1,33 @@
+# `alloc`
+
+These source files come from the Rust standard library, hosted in
+the <https://github.com/rust-lang/rust> repository, licensed under
+"Apache-2.0 OR MIT" and adapted for kernel use. For copyright details,
+see <https://github.com/rust-lang/rust/blob/master/COPYRIGHT>.
+
+Please note that these files should be kept as close as possible to
+upstream. In general, only additions should be performed (e.g. new
+methods). Eventually, changes should make it into upstream so that,
+at some point, this fork can be dropped from the kernel tree.
+
+
+## Rationale
+
+On one hand, kernel folks wanted to keep `alloc` in-tree to have more
+freedom in both workflow and actual features if actually needed
+(e.g. receiver types if we ended up using them), which is reasonable.
+
+On the other hand, Rust folks wanted to keep `alloc` as close as
+upstream as possible and avoid as much divergence as possible, which
+is also reasonable.
+
+We agreed on a middle-ground: we would keep a subset of `alloc`
+in-tree that would be as small and as close as possible to upstream.
+Then, upstream can start adding the functions that we add to `alloc`
+etc., until we reach a point where the kernel already knows exactly
+what it needs in `alloc` and all the new methods are merged into
+upstream, so that we can drop `alloc` from the kernel tree and go back
+to using the upstream one.
+
+By doing this, the kernel can go a bit faster now, and Rust can
+slowly incorporate and discuss the changes as needed.
diff --git a/rust/alloc/alloc.rs b/rust/alloc/alloc.rs
index 6162b5c6d4c9..ca224a541770 100644
--- a/rust/alloc/alloc.rs
+++ b/rust/alloc/alloc.rs
@@ -1,3 +1,5 @@
+// SPDX-License-Identifier: Apache-2.0 OR MIT
+
 //! Memory allocation APIs
 
 #![stable(feature = "alloc_module", since = "1.28.0")]
diff --git a/rust/alloc/borrow.rs b/rust/alloc/borrow.rs
index cb4e438f8bea..dde4957200d4 100644
--- a/rust/alloc/borrow.rs
+++ b/rust/alloc/borrow.rs
@@ -1,3 +1,5 @@
+// SPDX-License-Identifier: Apache-2.0 OR MIT
+
 //! A module for working with borrowed data.
 
 #![stable(feature = "rust1", since = "1.0.0")]
@@ -11,7 +13,7 @@ use core::ops::{Add, AddAssign};
 #[stable(feature = "rust1", since = "1.0.0")]
 pub use core::borrow::{Borrow, BorrowMut};
 
-use crate::fmt;
+use core::fmt;
 #[cfg(not(no_global_oom_handling))]
 use crate::string::String;
 
diff --git a/rust/alloc/boxed.rs b/rust/alloc/boxed.rs
index c07536f0d0ce..dcfe87b14f3a 100644
--- a/rust/alloc/boxed.rs
+++ b/rust/alloc/boxed.rs
@@ -1,3 +1,5 @@
+// SPDX-License-Identifier: Apache-2.0 OR MIT
+
 //! A pointer type for heap allocation.
 //!
 //! [`Box<T>`], casually referred to as a 'box', provides the simplest form of
@@ -163,9 +165,11 @@ use crate::str::from_boxed_utf8_unchecked;
 #[cfg(not(no_global_oom_handling))]
 use crate::vec::Vec;
 
+#[cfg(not(no_thin))]
 #[unstable(feature = "thin_box", issue = "92791")]
 pub use thin::ThinBox;
 
+#[cfg(not(no_thin))]
 mod thin;
 
 /// A pointer type for heap allocation.
diff --git a/rust/alloc/collections/mod.rs b/rust/alloc/collections/mod.rs
index 628a5b155673..1eec265b28f8 100644
--- a/rust/alloc/collections/mod.rs
+++ b/rust/alloc/collections/mod.rs
@@ -1,3 +1,5 @@
+// SPDX-License-Identifier: Apache-2.0 OR MIT
+
 //! Collection types.
 
 #![stable(feature = "rust1", since = "1.0.0")]
diff --git a/rust/alloc/lib.rs b/rust/alloc/lib.rs
index fd21b3671182..233bcd5e4654 100644
--- a/rust/alloc/lib.rs
+++ b/rust/alloc/lib.rs
@@ -1,3 +1,5 @@
+// SPDX-License-Identifier: Apache-2.0 OR MIT
+
 //! # The Rust core allocation and collections library
 //!
 //! This library provides smart pointers and collections for managing
@@ -192,6 +194,7 @@ extern crate std;
 extern crate test;
 
 // Module with internal macros used by other modules (needs to be included before other modules).
+#[cfg(not(no_macros))]
 #[macro_use]
 mod macros;
 
@@ -216,11 +219,16 @@ pub mod borrow;
 pub mod collections;
 #[cfg(not(no_global_oom_handling))]
 pub mod ffi;
+#[cfg(not(no_fmt))]
 pub mod fmt;
+#[cfg(not(no_rc))]
 pub mod rc;
 pub mod slice;
+#[cfg(not(no_str))]
 pub mod str;
+#[cfg(not(no_string))]
 pub mod string;
+#[cfg(not(no_sync))]
 #[cfg(target_has_atomic = "ptr")]
 pub mod sync;
 #[cfg(all(not(no_global_oom_handling), target_has_atomic = "ptr"))]
diff --git a/rust/alloc/raw_vec.rs b/rust/alloc/raw_vec.rs
index 4be5f6cf9ca5..daf5f2da7168 100644
--- a/rust/alloc/raw_vec.rs
+++ b/rust/alloc/raw_vec.rs
@@ -1,3 +1,5 @@
+// SPDX-License-Identifier: Apache-2.0 OR MIT
+
 #![unstable(feature = "raw_vec_internals", reason = "unstable const warnings", issue = "none")]
 
 use core::alloc::LayoutError;
@@ -307,6 +309,12 @@ impl<T, A: Allocator> RawVec<T, A> {
         }
     }
 
+    /// The same as `reserve_for_push`, but returns on errors instead of panicking or aborting.
+    #[inline(never)]
+    pub fn try_reserve_for_push(&mut self, len: usize) -> Result<(), TryReserveError> {
+        self.grow_amortized(len, 1)
+    }
+
     /// Ensures that the buffer contains at least enough space to hold `len +
     /// additional` elements. If it doesn't already, will reallocate the
     /// minimum possible amount of memory necessary. Generally this will be
@@ -421,6 +429,7 @@ impl<T, A: Allocator> RawVec<T, A> {
         Ok(())
     }
 
+    #[allow(dead_code)]
     fn shrink(&mut self, cap: usize) -> Result<(), TryReserveError> {
         assert!(cap <= self.capacity(), "Tried to shrink to a larger capacity");
 
diff --git a/rust/alloc/slice.rs b/rust/alloc/slice.rs
index 199b3c9d0290..e444e97fa145 100644
--- a/rust/alloc/slice.rs
+++ b/rust/alloc/slice.rs
@@ -1,3 +1,5 @@
+// SPDX-License-Identifier: Apache-2.0 OR MIT
+
 //! A dynamically-sized view into a contiguous sequence, `[T]`.
 //!
 //! *[See also the slice primitive type](slice).*
diff --git a/rust/alloc/vec/drain.rs b/rust/alloc/vec/drain.rs
index 5cdee0bd4da4..b6a5f98e4fcd 100644
--- a/rust/alloc/vec/drain.rs
+++ b/rust/alloc/vec/drain.rs
@@ -1,3 +1,5 @@
+// SPDX-License-Identifier: Apache-2.0 OR MIT
+
 use crate::alloc::{Allocator, Global};
 use core::fmt;
 use core::iter::{FusedIterator, TrustedLen};
diff --git a/rust/alloc/vec/drain_filter.rs b/rust/alloc/vec/drain_filter.rs
index 3c37c92ae44b..b04fce041622 100644
--- a/rust/alloc/vec/drain_filter.rs
+++ b/rust/alloc/vec/drain_filter.rs
@@ -1,3 +1,5 @@
+// SPDX-License-Identifier: Apache-2.0 OR MIT
+
 use crate::alloc::{Allocator, Global};
 use core::ptr::{self};
 use core::slice::{self};
diff --git a/rust/alloc/vec/into_iter.rs b/rust/alloc/vec/into_iter.rs
index 9b84a1d9b4b6..f7a50e76691e 100644
--- a/rust/alloc/vec/into_iter.rs
+++ b/rust/alloc/vec/into_iter.rs
@@ -1,3 +1,5 @@
+// SPDX-License-Identifier: Apache-2.0 OR MIT
+
 #[cfg(not(no_global_oom_handling))]
 use super::AsVecIntoIter;
 use crate::alloc::{Allocator, Global};
@@ -9,6 +11,7 @@ use core::iter::{
 };
 use core::marker::PhantomData;
 use core::mem::{self, ManuallyDrop};
+#[cfg(not(no_global_oom_handling))]
 use core::ops::Deref;
 use core::ptr::{self, NonNull};
 use core::slice::{self};
@@ -123,6 +126,7 @@ impl<T, A: Allocator> IntoIter<T, A> {
     }
 
     /// Forgets to Drop the remaining elements while still allowing the backing allocation to be freed.
+    #[allow(dead_code)]
     pub(crate) fn forget_remaining_elements(&mut self) {
         self.ptr = self.end;
     }
diff --git a/rust/alloc/vec/is_zero.rs b/rust/alloc/vec/is_zero.rs
index edf270db81d4..377f3d172777 100644
--- a/rust/alloc/vec/is_zero.rs
+++ b/rust/alloc/vec/is_zero.rs
@@ -1,3 +1,5 @@
+// SPDX-License-Identifier: Apache-2.0 OR MIT
+
 use crate::boxed::Box;
 
 #[rustc_specialization_trait]
diff --git a/rust/alloc/vec/mod.rs b/rust/alloc/vec/mod.rs
index 3dc8a4fbba86..540787804cc2 100644
--- a/rust/alloc/vec/mod.rs
+++ b/rust/alloc/vec/mod.rs
@@ -1,3 +1,5 @@
+// SPDX-License-Identifier: Apache-2.0 OR MIT
+
 //! A contiguous growable array type with heap-allocated contents, written
 //! `Vec<T>`.
 //!
@@ -1739,6 +1741,29 @@ impl<T, A: Allocator> Vec<T, A> {
         }
     }
 
+    /// Tries to append an element to the back of a collection.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let mut vec = vec![1, 2];
+    /// vec.try_push(3).unwrap();
+    /// assert_eq!(vec, [1, 2, 3]);
+    /// ```
+    #[inline]
+    #[stable(feature = "kernel", since = "1.0.0")]
+    pub fn try_push(&mut self, value: T) -> Result<(), TryReserveError> {
+        if self.len == self.buf.capacity() {
+            self.buf.try_reserve_for_push(self.len)?;
+        }
+        unsafe {
+            let end = self.as_mut_ptr().add(self.len);
+            ptr::write(end, value);
+            self.len += 1;
+        }
+        Ok(())
+    }
+
     /// Removes the last element from a vector and returns it, or [`None`] if it
     /// is empty.
     ///
diff --git a/rust/alloc/vec/partial_eq.rs b/rust/alloc/vec/partial_eq.rs
index b0cf72577a1b..10ad4e492287 100644
--- a/rust/alloc/vec/partial_eq.rs
+++ b/rust/alloc/vec/partial_eq.rs
@@ -1,3 +1,5 @@
+// SPDX-License-Identifier: Apache-2.0 OR MIT
+
 use crate::alloc::Allocator;
 #[cfg(not(no_global_oom_handling))]
 use crate::borrow::Cow;
-- 
2.37.1

