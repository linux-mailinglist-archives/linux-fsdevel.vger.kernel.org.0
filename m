Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3779A58AD72
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Aug 2022 17:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241271AbiHEPrn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Aug 2022 11:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241395AbiHEPp4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Aug 2022 11:45:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D4975394;
        Fri,  5 Aug 2022 08:44:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6FFE2B82987;
        Fri,  5 Aug 2022 15:44:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 840FEC433D6;
        Fri,  5 Aug 2022 15:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659714293;
        bh=snCTpO1KjSoGMCbd2ZibVgNCeCXJ9RI/0mMCRcFphkk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W4nnSD3fqKq1mlqKZ6GyHb+mnfKbt968O+PZyBC1A1yMQ7NdczRxYugrnMnFWRWVG
         GX7jAZQsLo+uXtg1eHmwWk8wy13sieWXO1aTMU71MzO5ib0UStwzzWL73JtYF7E3N0
         YUBpiOmZhHPNSLVb41Bba9/NOv4Fj9ALy7R0r+0CAKIPaq/27XCRtuI3dHIWRDWLJW
         aQqULu6ghI2tz1v01ZcHAk21cfJJ9tMTNQa4++7IhhRISJ1kzb2qRRl9lOe4UePjf7
         LGmuQdscSj35rzRTn6ma5QBIYh8FRquvhnD3U4ZNk7TiCSEnrVz9n62XChPQ8w6UXE
         pOtXf8X0mgcuQ==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, patches@lists.linux.dev,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        David Gow <davidgow@google.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-doc@vger.kernel.org
Subject: [PATCH v9 25/27] x86: enable initial Rust support
Date:   Fri,  5 Aug 2022 17:42:10 +0200
Message-Id: <20220805154231.31257-26-ojeda@kernel.org>
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

Note that only x86_64 is covered and not all features nor mitigations
are handled, but it is enough as a starting point and showcases
the basics needed to add Rust support for a new architecture.

Co-developed-by: Alex Gaynor <alex.gaynor@gmail.com>
Signed-off-by: Alex Gaynor <alex.gaynor@gmail.com>
Co-developed-by: Wedson Almeida Filho <wedsonaf@google.com>
Signed-off-by: Wedson Almeida Filho <wedsonaf@google.com>
Co-developed-by: David Gow <davidgow@google.com>
Signed-off-by: David Gow <davidgow@google.com>
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 Documentation/rust/arch-support.rst |  1 +
 arch/x86/Kconfig                    |  1 +
 arch/x86/Makefile                   | 10 ++++++++++
 scripts/generate_rust_target.rs     | 15 +++++++++++++--
 4 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/Documentation/rust/arch-support.rst b/Documentation/rust/arch-support.rst
index 1152e0fbdad0..6982b63775da 100644
--- a/Documentation/rust/arch-support.rst
+++ b/Documentation/rust/arch-support.rst
@@ -15,4 +15,5 @@ support corresponds to ``S`` values in the ``MAINTAINERS`` file.
 ============  ================  ==============================================
 Architecture  Level of support  Constraints
 ============  ================  ==============================================
+``x86``       Maintained        ``x86_64`` only.
 ============  ================  ==============================================
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 52a7f91527fe..4d5a3f256cbc 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -258,6 +258,7 @@ config X86
 	select HAVE_STATIC_CALL_INLINE		if HAVE_OBJTOOL
 	select HAVE_PREEMPT_DYNAMIC_CALL
 	select HAVE_RSEQ
+	select HAVE_RUST			if X86_64
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_UACCESS_VALIDATION		if HAVE_OBJTOOL
 	select HAVE_UNSTABLE_SCHED_CLOCK
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 7854685c5f25..bab595003f07 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -68,6 +68,7 @@ export BITS
 #    https://gcc.gnu.org/bugzilla/show_bug.cgi?id=53383
 #
 KBUILD_CFLAGS += -mno-sse -mno-mmx -mno-sse2 -mno-3dnow -mno-avx
+KBUILD_RUSTFLAGS += -Ctarget-feature=-sse,-sse2,-sse3,-ssse3,-sse4.1,-sse4.2,-avx,-avx2
 
 ifeq ($(CONFIG_X86_KERNEL_IBT),y)
 #
@@ -155,8 +156,17 @@ else
         cflags-$(CONFIG_GENERIC_CPU)	+= -mtune=generic
         KBUILD_CFLAGS += $(cflags-y)
 
+        rustflags-$(CONFIG_MK8)		+= -Ctarget-cpu=k8
+        rustflags-$(CONFIG_MPSC)	+= -Ctarget-cpu=nocona
+        rustflags-$(CONFIG_MCORE2)	+= -Ctarget-cpu=core2
+        rustflags-$(CONFIG_MATOM)	+= -Ctarget-cpu=atom
+        rustflags-$(CONFIG_GENERIC_CPU)	+= -Ztune-cpu=generic
+        KBUILD_RUSTFLAGS += $(rustflags-y)
+
         KBUILD_CFLAGS += -mno-red-zone
         KBUILD_CFLAGS += -mcmodel=kernel
+        KBUILD_RUSTFLAGS += -Cno-redzone=y
+        KBUILD_RUSTFLAGS += -Ccode-model=kernel
 endif
 
 #
diff --git a/scripts/generate_rust_target.rs b/scripts/generate_rust_target.rs
index 7256c9606cf0..3c6cbe2b278d 100644
--- a/scripts/generate_rust_target.rs
+++ b/scripts/generate_rust_target.rs
@@ -148,8 +148,19 @@ fn main() {
     let mut ts = TargetSpec::new();
 
     // `llvm-target`s are taken from `scripts/Makefile.clang`.
-    if cfg.has("DUMMY_ARCH") {
-        ts.push("arch", "dummy_arch");
+    if cfg.has("X86_64") {
+        ts.push("arch", "x86_64");
+        ts.push(
+            "data-layout",
+            "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128",
+        );
+        let mut features = "-3dnow,-3dnowa,-mmx,+soft-float".to_string();
+        if cfg.has("RETPOLINE") {
+            features += ",+retpoline-external-thunk";
+        }
+        ts.push("features", features);
+        ts.push("llvm-target", "x86_64-linux-gnu");
+        ts.push("target-pointer-width", "64");
     } else {
         panic!("Unsupported architecture");
     }
-- 
2.37.1

