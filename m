Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97AB958AD58
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Aug 2022 17:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241264AbiHEPqN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Aug 2022 11:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241302AbiHEPpn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Aug 2022 11:45:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A82236A4BD;
        Fri,  5 Aug 2022 08:44:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D5B1AB82985;
        Fri,  5 Aug 2022 15:44:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0879DC433B5;
        Fri,  5 Aug 2022 15:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659714262;
        bh=MaBkpRFNAtR0S5GulGMxUqHkM4gANiECBMn2Sr4GJaE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jDjZALcI1wvDCN+pfa6PKmsS77XuAeonqvGAv8NcjZybAkrEsenbs/fuBiGyoMctH
         UjKHP/0uMiw5gYySYfIIOCz6JA4YAnYQAxz6DSuVjZjP13UKaV0o/JWQl9Ztg1fat2
         arB34nFsVm3Eq9NCOgBSPODoWmsfuEeM+Ve6dj1xDlQ6SCuhb7QhDdcib/RjUgLjih
         YE49Lm0B/TmmGp9hCJKhSUuex7LnbwiM8wHwQLS+zIy5zjQs6ngLahahc/WeF6qOc+
         8EC9zpD0SeVdn7TNrO1Fa6/VqwqzD8mdTZNCwn5Cygl8HZovgHBA7ZbB29BZFlVvoE
         KAYvHY62++b3w==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, patches@lists.linux.dev,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Finn Behrens <me@kloenk.de>, Miguel Cano <macanroj@gmail.com>,
        Tiago Lam <tiagolam@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>
Subject: [PATCH v9 20/27] scripts: add `rust_is_available.sh`
Date:   Fri,  5 Aug 2022 17:42:05 +0200
Message-Id: <20220805154231.31257-21-ojeda@kernel.org>
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

This script tests whether the Rust toolchain requirements are in place
to enable Rust support.

The build system will call it to set `CONFIG_RUST_IS_AVAILABLE` in
a later patch.

It also has an option (`-v`) to explain what is missing, which is
useful to set up the development environment. This is used via
the `make rustavailable` target added in a later patch.

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
 scripts/rust_is_available.sh                 | 160 +++++++++++++++++++
 scripts/rust_is_available_bindgen_libclang.h |   2 +
 2 files changed, 162 insertions(+)
 create mode 100755 scripts/rust_is_available.sh
 create mode 100644 scripts/rust_is_available_bindgen_libclang.h

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
2.37.1

