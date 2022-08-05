Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43EAB58AD3A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Aug 2022 17:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241140AbiHEPoA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Aug 2022 11:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241139AbiHEPnd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Aug 2022 11:43:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96FE86611B;
        Fri,  5 Aug 2022 08:43:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1EFB8B82987;
        Fri,  5 Aug 2022 15:43:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F810C433C1;
        Fri,  5 Aug 2022 15:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659714196;
        bh=7yjY5Y6g1qtoUnDrqwaXLYugm5cDoSo3+7AjfeIMPHY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KbdD3UH6sLyDQiKBd++2wnIlTMwEfJCJ4b2NcsrkLtz0MpyHm9ewKLpmzqsACnBGi
         MHEQ6V8CPSKs5dBG5U8KR2894aZKZxPxHgvTNFN2S0GS5wr9e6h1aX69poQ532HDJ1
         ZswIfAHkOO0XYVMBfYmGup6+U82B6dJPJ/PprlTqIjgdktkoNrvksZQu6oo/7AHMfw
         cp5KlyJKat+hmXXEhdqkYDAgH9xAI+7rfmm9hmHlYKazlanTY/mFd3tjNk7f2IUi9M
         Khc99oey1BXZzoXobM7HhYtrTqrdHa0ouDp8vKPWZ9rQ/43JGHiifcUshzKhy8gw2e
         FrDYek0c4xd5A==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, patches@lists.linux.dev,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Geoffrey Thomas <geofft@ldpreload.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Gary Guo <gary@garyguo.net>, Boqun Feng <boqun.feng@gmail.com>,
        Maciej Falkowski <m.falkowski@samsung.com>,
        Wei Liu <wei.liu@kernel.org>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>
Subject: [PATCH v9 06/27] rust: add C helpers
Date:   Fri,  5 Aug 2022 17:41:51 +0200
Message-Id: <20220805154231.31257-7-ojeda@kernel.org>
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

This source file contains forwarders to C macros and inlined
functions.

Co-developed-by: Alex Gaynor <alex.gaynor@gmail.com>
Signed-off-by: Alex Gaynor <alex.gaynor@gmail.com>
Co-developed-by: Geoffrey Thomas <geofft@ldpreload.com>
Signed-off-by: Geoffrey Thomas <geofft@ldpreload.com>
Co-developed-by: Wedson Almeida Filho <wedsonaf@google.com>
Signed-off-by: Wedson Almeida Filho <wedsonaf@google.com>
Co-developed-by: Sven Van Asbroeck <thesven73@gmail.com>
Signed-off-by: Sven Van Asbroeck <thesven73@gmail.com>
Co-developed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Gary Guo <gary@garyguo.net>
Co-developed-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Co-developed-by: Maciej Falkowski <m.falkowski@samsung.com>
Signed-off-by: Maciej Falkowski <m.falkowski@samsung.com>
Co-developed-by: Wei Liu <wei.liu@kernel.org>
Signed-off-by: Wei Liu <wei.liu@kernel.org>
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 rust/helpers.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 rust/helpers.c

diff --git a/rust/helpers.c b/rust/helpers.c
new file mode 100644
index 000000000000..b4f15eee2ffd
--- /dev/null
+++ b/rust/helpers.c
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Non-trivial C macros cannot be used in Rust. Similarly, inlined C functions
+ * cannot be called either. This file explicitly creates functions ("helpers")
+ * that wrap those so that they can be called from Rust.
+ *
+ * Even though Rust kernel modules should never use directly the bindings, some
+ * of these helpers need to be exported because Rust generics and inlined
+ * functions may not get their code generated in the crate where they are
+ * defined. Other helpers, called from non-inline functions, may not be
+ * exported, in principle. However, in general, the Rust compiler does not
+ * guarantee codegen will be performed for a non-inline function either.
+ * Therefore, this file exports all the helpers. In the future, this may be
+ * revisited to reduce the number of exports after the compiler is informed
+ * about the places codegen is required.
+ *
+ * All symbols are exported as GPL-only to guarantee no GPL-only feature is
+ * accidentally exposed.
+ */
+
+#include <linux/bug.h>
+#include <linux/build_bug.h>
+
+__noreturn void rust_helper_BUG(void)
+{
+	BUG();
+}
+EXPORT_SYMBOL_GPL(rust_helper_BUG);
+
+/*
+ * We use `bindgen`'s `--size_t-is-usize` option to bind the C `size_t` type
+ * as the Rust `usize` type, so we can use it in contexts where Rust
+ * expects a `usize` like slice (array) indices. `usize` is defined to be
+ * the same as C's `uintptr_t` type (can hold any pointer) but not
+ * necessarily the same as `size_t` (can hold the size of any single
+ * object). Most modern platforms use the same concrete integer type for
+ * both of them, but in case we find ourselves on a platform where
+ * that's not true, fail early instead of risking ABI or
+ * integer-overflow issues.
+ *
+ * If your platform fails this assertion, it means that you are in
+ * danger of integer-overflow bugs (even if you attempt to remove
+ * `--size_t-is-usize`). It may be easiest to change the kernel ABI on
+ * your platform such that `size_t` matches `uintptr_t` (i.e., to increase
+ * `size_t`, because `uintptr_t` has to be at least as big as `size_t`).
+ */
+static_assert(
+	sizeof(size_t) == sizeof(uintptr_t) &&
+	__alignof__(size_t) == __alignof__(uintptr_t),
+	"Rust code expects C `size_t` to match Rust `usize`"
+);
-- 
2.37.1

