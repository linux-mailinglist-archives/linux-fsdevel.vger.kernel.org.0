Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8DE158AD67
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Aug 2022 17:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241263AbiHEPph (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Aug 2022 11:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241040AbiHEPoL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Aug 2022 11:44:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34BDC6E8B2;
        Fri,  5 Aug 2022 08:43:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E83061640;
        Fri,  5 Aug 2022 15:43:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35B3DC433B5;
        Fri,  5 Aug 2022 15:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659714221;
        bh=9EyQcRCS5vOFtGycY3XOZyV7xrsCvuOlRMzBM17HJ5A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VtwG2kzL2MtE47J83PZwbTsFg8+dE7Se0IZjk2F3Gmc1WSWOvRmSyRTGJXOlY6QJW
         zFrfwCOo4DoteyCpBe5mLlByWLx978chs/mQHC396PCWnPAEJbYeqEzlUxamcWb/BL
         JAJN89VJmYK00+YNJdU+SiXjZAsPUI22cTWJmpIaOoSJnk9yYrNiM1aSMQ9L0D2YJu
         3mH75Gdtsi6ShiVDr8Da9oNp63GuqskYs5ea8bAYC8N5Pk1DM9wVIDvwWAQshHZBBO
         kHkDH0Ri/NDFPWyssTCLD1RwesLbnhObLNRd9p36QO7fSJ+FehN6xsQIFEkduOUBwv
         cVQckK4EHrXBw==
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
Subject: [PATCH v9 11/27] rust: add `bindings` crate
Date:   Fri,  5 Aug 2022 17:41:56 +0200
Message-Id: <20220805154231.31257-12-ojeda@kernel.org>
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
2.37.1

