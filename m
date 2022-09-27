Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74DAF5EC421
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Sep 2022 15:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232558AbiI0NTN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Sep 2022 09:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232046AbiI0NRl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Sep 2022 09:17:41 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81315B4A1;
        Tue, 27 Sep 2022 06:16:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D7264CE192F;
        Tue, 27 Sep 2022 13:16:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DB43C4314F;
        Tue, 27 Sep 2022 13:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664284602;
        bh=bCBP6DKEc/dRd0AlNE1jC/iDUgEIP211vWgENmtp8t0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P3i2IN9dq/akuNO65uMff6MCt7DN0s8m8dEjVNAHmcMvTQRzn41y5/N+QB5C0qvT2
         aBqlror8SsztXZQQm/p8/yKxQTvMNsOo/wtBIaCjT12Z79jrB/68g04ex1qVjt/gD4
         0ai3R8RvqQfZRnmgQi9JbnD/LhmhZf/IyCngOsetEpgzM0/p2rOnYKRiL3nvWRcxH2
         6KSh9KFSKrAlUEKqzK6VwaoyrmLQ5LlIe+r04yxRTyXE5Cd1Fn/xIdRKng61Eogor6
         +qBLBX5p2hN4jai9KFL1BQlbOwbahVVzoHsmuhVPlfbvSBwHZTzt4mr67eY7X6A5hZ
         M4BEF1LWAPKnw==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, patches@lists.linux.dev,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Finn Behrens <me@kloenk.de>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        Maciej Falkowski <m.falkowski@samsung.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH v10 11/27] rust: add `bindings` crate
Date:   Tue, 27 Sep 2022 15:14:42 +0200
Message-Id: <20220927131518.30000-12-ojeda@kernel.org>
In-Reply-To: <20220927131518.30000-1-ojeda@kernel.org>
References: <20220927131518.30000-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This crate contains the bindings to the C side of the kernel.

Calling C (in general, FFI) is assumed to be unsafe in Rust
and, in many cases, this is accurate. For instance, virtually
all C functions that take a pointer are unsafe since, typically,
it will be dereferenced at some point (and in most cases there
is no way for the callee to check its validity beforehand).

Since one of the goals of using Rust in the kernel is precisely
to avoid unsafe code in "leaf" kernel modules (e.g. drivers),
these bindings should not be used directly by them.

Instead, these bindings need to be wrapped into safe abstractions.
These abstractions provide a safe API that kernel modules can use.
In this way, unsafe code in kernel modules is minimized.

Co-developed-by: Alex Gaynor <alex.gaynor@gmail.com>
Signed-off-by: Alex Gaynor <alex.gaynor@gmail.com>
Co-developed-by: Finn Behrens <me@kloenk.de>
Signed-off-by: Finn Behrens <me@kloenk.de>
Co-developed-by: Wedson Almeida Filho <wedsonaf@google.com>
Signed-off-by: Wedson Almeida Filho <wedsonaf@google.com>
Co-developed-by: Sven Van Asbroeck <thesven73@gmail.com>
Signed-off-by: Sven Van Asbroeck <thesven73@gmail.com>
Co-developed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Gary Guo <gary@garyguo.net>
Co-developed-by: Maciej Falkowski <m.falkowski@samsung.com>
Signed-off-by: Maciej Falkowski <m.falkowski@samsung.com>
Co-developed-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Co-developed-by: Björn Roy Baron <bjorn3_gh@protonmail.com>
Signed-off-by: Björn Roy Baron <bjorn3_gh@protonmail.com>
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 rust/bindings/bindings_helper.h | 13 ++++++++
 rust/bindings/lib.rs            | 53 +++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+)
 create mode 100644 rust/bindings/bindings_helper.h
 create mode 100644 rust/bindings/lib.rs

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
new file mode 100644
index 000000000000..c48bc284214a
--- /dev/null
+++ b/rust/bindings/bindings_helper.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Header that contains the code (mostly headers) for which Rust bindings
+ * will be automatically generated by `bindgen`.
+ *
+ * Sorted alphabetically.
+ */
+
+#include <linux/slab.h>
+
+/* `bindgen` gets confused at certain things. */
+const gfp_t BINDINGS_GFP_KERNEL = GFP_KERNEL;
+const gfp_t BINDINGS___GFP_ZERO = __GFP_ZERO;
diff --git a/rust/bindings/lib.rs b/rust/bindings/lib.rs
new file mode 100644
index 000000000000..6c50ee62c56b
--- /dev/null
+++ b/rust/bindings/lib.rs
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Bindings.
+//!
+//! Imports the generated bindings by `bindgen`.
+//!
+//! This crate may not be directly used. If you need a kernel C API that is
+//! not ported or wrapped in the `kernel` crate, then do so first instead of
+//! using this crate.
+
+#![no_std]
+#![feature(core_ffi_c)]
+// See <https://github.com/rust-lang/rust-bindgen/issues/1651>.
+#![cfg_attr(test, allow(deref_nullptr))]
+#![cfg_attr(test, allow(unaligned_references))]
+#![cfg_attr(test, allow(unsafe_op_in_unsafe_fn))]
+#![allow(
+    clippy::all,
+    missing_docs,
+    non_camel_case_types,
+    non_upper_case_globals,
+    non_snake_case,
+    improper_ctypes,
+    unreachable_pub,
+    unsafe_op_in_unsafe_fn
+)]
+
+mod bindings_raw {
+    // Use glob import here to expose all helpers.
+    // Symbols defined within the module will take precedence to the glob import.
+    pub use super::bindings_helper::*;
+    include!(concat!(
+        env!("OBJTREE"),
+        "/rust/bindings/bindings_generated.rs"
+    ));
+}
+
+// When both a directly exposed symbol and a helper exists for the same function,
+// the directly exposed symbol is preferred and the helper becomes dead code, so
+// ignore the warning here.
+#[allow(dead_code)]
+mod bindings_helper {
+    // Import the generated bindings for types.
+    include!(concat!(
+        env!("OBJTREE"),
+        "/rust/bindings/bindings_helpers_generated.rs"
+    ));
+}
+
+pub use bindings_raw::*;
+
+pub const GFP_KERNEL: gfp_t = BINDINGS_GFP_KERNEL;
+pub const __GFP_ZERO: gfp_t = BINDINGS___GFP_ZERO;
-- 
2.37.3

