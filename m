Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E56E95EC432
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Sep 2022 15:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232644AbiI0NUe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Sep 2022 09:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232641AbiI0NTO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Sep 2022 09:19:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 632A614037;
        Tue, 27 Sep 2022 06:17:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 21589B81BD1;
        Tue, 27 Sep 2022 13:17:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16B36C433C1;
        Tue, 27 Sep 2022 13:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664284644;
        bh=fOhslmwHAdMi5hr9DCim4vJbofhWgGZ4h9kB3ggMtdY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EVhmUUqQiKsk6YisfDaINbA/1otkBnOTZNQqgOFtJ1S8th3nRO6ETlsSQJ1WCTBqy
         hurQWOW/mzdVAmkATKqp6mLWrtL8oea65P/LcySSAEHm7qIVnqToAVOlq8aos7Bdix
         5dFMsS6+wXhjtYOcTz3pDzD/BTP8r+SJrDsakoIk90DCUyfWp2LJd31p7uOEGds9lP
         OugzzlWHZxzqa5+Rpkj3NhVlWrPKSh62syUdzRJJxf6OUfZXAJKe9hoCK7U02/7FKv
         ynDC2xhjkfYsZWSQfOIZUIZ2U8Jy2G1+F/tBkwmR0RmAp1pJbFLojiXTNcjo6XbppU
         0yM3swRqFA0hQ==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, patches@lists.linux.dev,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Finn Behrens <me@kloenk.de>, Miguel Cano <macanroj@gmail.com>,
        Tiago Lam <tiagolam@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>
Subject: [PATCH v10 20/27] scripts: add `rust_is_available.sh`
Date:   Tue, 27 Sep 2022 15:14:51 +0200
Message-Id: <20220927131518.30000-21-ojeda@kernel.org>
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

This script tests whether the Rust toolchain requirements are in place
to enable Rust support. It uses `min-tool-version.sh` to fetch
the version numbers.

The build system will call it to set `CONFIG_RUST_IS_AVAILABLE` in
a later patch.

It also has an option (`-v`) to explain what is missing, which is
useful to set up the development environment. This is used via
the `make rustavailable` target added in a later patch.

Reviewed-by: Kees Cook <keescook@chromium.org>
Co-developed-by: Alex Gaynor <alex.gaynor@gmail.com>
Signed-off-by: Alex Gaynor <alex.gaynor@gmail.com>
Co-developed-by: Wedson Almeida Filho <wedsonaf@google.com>
Signed-off-by: Wedson Almeida Filho <wedsonaf@google.com>
Co-developed-by: Finn Behrens <me@kloenk.de>
Signed-off-by: Finn Behrens <me@kloenk.de>
Co-developed-by: Miguel Cano <macanroj@gmail.com>
Signed-off-by: Miguel Cano <macanroj@gmail.com>
Co-developed-by: Tiago Lam <tiagolam@gmail.com>
Signed-off-by: Tiago Lam <tiagolam@gmail.com>
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 scripts/min-tool-version.sh                  |   6 +
 scripts/rust_is_available.sh                 | 160 +++++++++++++++++++
 scripts/rust_is_available_bindgen_libclang.h |   2 +
 3 files changed, 168 insertions(+)
 create mode 100755 scripts/rust_is_available.sh
 create mode 100644 scripts/rust_is_available_bindgen_libclang.h

diff --git a/scripts/min-tool-version.sh b/scripts/min-tool-version.sh
index 250925aab101..b6593eac5003 100755
--- a/scripts/min-tool-version.sh
+++ b/scripts/min-tool-version.sh
@@ -30,6 +30,12 @@ llvm)
 		echo 11.0.0
 	fi
 	;;
+rustc)
+	echo 1.62.0
+	;;
+bindgen)
+	echo 0.56.0
+	;;
 *)
 	echo "$1: unknown tool" >&2
 	exit 1
diff --git a/scripts/rust_is_available.sh b/scripts/rust_is_available.sh
new file mode 100755
index 000000000000..aebbf1913970
--- /dev/null
+++ b/scripts/rust_is_available.sh
@@ -0,0 +1,160 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+#
+# Tests whether a suitable Rust toolchain is available.
+#
+# Pass `-v` for human output and more checks (as warnings).
+
+set -e
+
+min_tool_version=$(dirname $0)/min-tool-version.sh
+
+# Convert the version string x.y.z to a canonical up-to-7-digits form.
+#
+# Note that this function uses one more digit (compared to other
+# instances in other version scripts) to give a bit more space to
+# `rustc` since it will reach 1.100.0 in late 2026.
+get_canonical_version()
+{
+	IFS=.
+	set -- $1
+	echo $((100000 * $1 + 100 * $2 + $3))
+}
+
+# Check that the Rust compiler exists.
+if ! command -v "$RUSTC" >/dev/null; then
+	if [ "$1" = -v ]; then
+		echo >&2 "***"
+		echo >&2 "*** Rust compiler '$RUSTC' could not be found."
+		echo >&2 "***"
+	fi
+	exit 1
+fi
+
+# Check that the Rust bindings generator exists.
+if ! command -v "$BINDGEN" >/dev/null; then
+	if [ "$1" = -v ]; then
+		echo >&2 "***"
+		echo >&2 "*** Rust bindings generator '$BINDGEN' could not be found."
+		echo >&2 "***"
+	fi
+	exit 1
+fi
+
+# Check that the Rust compiler version is suitable.
+#
+# Non-stable and distributions' versions may have a version suffix, e.g. `-dev`.
+rust_compiler_version=$( \
+	LC_ALL=C "$RUSTC" --version 2>/dev/null \
+		| head -n 1 \
+		| grep -oE '[0-9]+\.[0-9]+\.[0-9]+' \
+)
+rust_compiler_min_version=$($min_tool_version rustc)
+rust_compiler_cversion=$(get_canonical_version $rust_compiler_version)
+rust_compiler_min_cversion=$(get_canonical_version $rust_compiler_min_version)
+if [ "$rust_compiler_cversion" -lt "$rust_compiler_min_cversion" ]; then
+	if [ "$1" = -v ]; then
+		echo >&2 "***"
+		echo >&2 "*** Rust compiler '$RUSTC' is too old."
+		echo >&2 "***   Your version:    $rust_compiler_version"
+		echo >&2 "***   Minimum version: $rust_compiler_min_version"
+		echo >&2 "***"
+	fi
+	exit 1
+fi
+if [ "$1" = -v ] && [ "$rust_compiler_cversion" -gt "$rust_compiler_min_cversion" ]; then
+	echo >&2 "***"
+	echo >&2 "*** Rust compiler '$RUSTC' is too new. This may or may not work."
+	echo >&2 "***   Your version:     $rust_compiler_version"
+	echo >&2 "***   Expected version: $rust_compiler_min_version"
+	echo >&2 "***"
+fi
+
+# Check that the Rust bindings generator is suitable.
+#
+# Non-stable and distributions' versions may have a version suffix, e.g. `-dev`.
+rust_bindings_generator_version=$( \
+	LC_ALL=C "$BINDGEN" --version 2>/dev/null \
+		| head -n 1 \
+		| grep -oE '[0-9]+\.[0-9]+\.[0-9]+' \
+)
+rust_bindings_generator_min_version=$($min_tool_version bindgen)
+rust_bindings_generator_cversion=$(get_canonical_version $rust_bindings_generator_version)
+rust_bindings_generator_min_cversion=$(get_canonical_version $rust_bindings_generator_min_version)
+if [ "$rust_bindings_generator_cversion" -lt "$rust_bindings_generator_min_cversion" ]; then
+	if [ "$1" = -v ]; then
+		echo >&2 "***"
+		echo >&2 "*** Rust bindings generator '$BINDGEN' is too old."
+		echo >&2 "***   Your version:    $rust_bindings_generator_version"
+		echo >&2 "***   Minimum version: $rust_bindings_generator_min_version"
+		echo >&2 "***"
+	fi
+	exit 1
+fi
+if [ "$1" = -v ] && [ "$rust_bindings_generator_cversion" -gt "$rust_bindings_generator_min_cversion" ]; then
+	echo >&2 "***"
+	echo >&2 "*** Rust bindings generator '$BINDGEN' is too new. This may or may not work."
+	echo >&2 "***   Your version:     $rust_bindings_generator_version"
+	echo >&2 "***   Expected version: $rust_bindings_generator_min_version"
+	echo >&2 "***"
+fi
+
+# Check that the `libclang` used by the Rust bindings generator is suitable.
+bindgen_libclang_version=$( \
+	LC_ALL=C "$BINDGEN" $(dirname $0)/rust_is_available_bindgen_libclang.h 2>&1 >/dev/null \
+		| grep -F 'clang version ' \
+		| grep -oE '[0-9]+\.[0-9]+\.[0-9]+' \
+		| head -n 1 \
+)
+bindgen_libclang_min_version=$($min_tool_version llvm)
+bindgen_libclang_cversion=$(get_canonical_version $bindgen_libclang_version)
+bindgen_libclang_min_cversion=$(get_canonical_version $bindgen_libclang_min_version)
+if [ "$bindgen_libclang_cversion" -lt "$bindgen_libclang_min_cversion" ]; then
+	if [ "$1" = -v ]; then
+		echo >&2 "***"
+		echo >&2 "*** libclang (used by the Rust bindings generator '$BINDGEN') is too old."
+		echo >&2 "***   Your version:    $bindgen_libclang_version"
+		echo >&2 "***   Minimum version: $bindgen_libclang_min_version"
+		echo >&2 "***"
+	fi
+	exit 1
+fi
+
+# If the C compiler is Clang, then we can also check whether its version
+# matches the `libclang` version used by the Rust bindings generator.
+#
+# In the future, we might be able to perform a full version check, see
+# https://github.com/rust-lang/rust-bindgen/issues/2138.
+if [ "$1" = -v ]; then
+	cc_name=$($(dirname $0)/cc-version.sh "$CC" | cut -f1 -d' ')
+	if [ "$cc_name" = Clang ]; then
+		clang_version=$( \
+			LC_ALL=C "$CC" --version 2>/dev/null \
+				| sed -nE '1s:.*version ([0-9]+\.[0-9]+\.[0-9]+).*:\1:p'
+		)
+		if [ "$clang_version" != "$bindgen_libclang_version" ]; then
+			echo >&2 "***"
+			echo >&2 "*** libclang (used by the Rust bindings generator '$BINDGEN')"
+			echo >&2 "*** version does not match Clang's. This may be a problem."
+			echo >&2 "***   libclang version: $bindgen_libclang_version"
+			echo >&2 "***   Clang version:    $clang_version"
+			echo >&2 "***"
+		fi
+	fi
+fi
+
+# Check that the source code for the `core` standard library exists.
+#
+# `$KRUSTFLAGS` is passed in case the user added `--sysroot`.
+rustc_sysroot=$("$RUSTC" $KRUSTFLAGS --print sysroot)
+rustc_src=${RUST_LIB_SRC:-"$rustc_sysroot/lib/rustlib/src/rust/library"}
+rustc_src_core="$rustc_src/core/src/lib.rs"
+if [ ! -e "$rustc_src_core" ]; then
+	if [ "$1" = -v ]; then
+		echo >&2 "***"
+		echo >&2 "*** Source code for the 'core' standard library could not be found"
+		echo >&2 "*** at '$rustc_src_core'."
+		echo >&2 "***"
+	fi
+	exit 1
+fi
diff --git a/scripts/rust_is_available_bindgen_libclang.h b/scripts/rust_is_available_bindgen_libclang.h
new file mode 100644
index 000000000000..0ef6db10d674
--- /dev/null
+++ b/scripts/rust_is_available_bindgen_libclang.h
@@ -0,0 +1,2 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#pragma message("clang version " __clang_version__)
-- 
2.37.3

