Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBAA05EC410
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Sep 2022 15:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232615AbiI0NRK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Sep 2022 09:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232608AbiI0NQ1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Sep 2022 09:16:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBDA21E3E4;
        Tue, 27 Sep 2022 06:16:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8BF456198D;
        Tue, 27 Sep 2022 13:16:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 378D0C433D7;
        Tue, 27 Sep 2022 13:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664284576;
        bh=EHb6HHsgIXEzrlOmrEyvqnUYIwHi5+s9QYRqtpeUv3o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rrQDbsHeOnO2szQNPiDbgjuGFtIn92QYZX5NGxABo43qZbBSRU5ndZKpvqCnS1/Ai
         zbQWDgziSbm1uS3Y+vF0SOO3c0VrCJ7fSq1ukwPBeQjUizBgoMLIQGmLCzdMpabroJ
         LLTsZXqDcO36IVzTPv15BJOISjNNJSgzRi5k4ep5Lk98KE3yGl2A270dG/BlaaX3Ha
         J8zW7c4kKrkW+WuMM0/XrOqC92V/y1IPYkafbIXNSNUuwfaPQkjZKmH1t1YCB1+DDb
         +ozOsPioZ1J0Nfq9ayTT2G4al0WTz47uFQN/7z37l0G+mRgrsYuTy29RH/qxc+FbRF
         KZIWRGzpw3/8w==
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
Subject: [PATCH v10 06/27] rust: add C helpers
Date:   Tue, 27 Sep 2022 15:14:37 +0200
Message-Id: <20220927131518.30000-7-ojeda@kernel.org>
In-Reply-To: <20220927131518.30000-1-ojeda@kernel.org>
References: <20220927131518.30000-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Introduces the source file that will contain forwarders to C macros
and inlined functions.

Initially this only contains a single helper, but will gain more as
more functionality is added to the `kernel` crate in the future.

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
2.37.3

