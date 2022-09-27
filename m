Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E749A5EC44F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Sep 2022 15:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232649AbiI0NWt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Sep 2022 09:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232721AbiI0NV3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Sep 2022 09:21:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8EBE1B14EF;
        Tue, 27 Sep 2022 06:18:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0542EB81BEA;
        Tue, 27 Sep 2022 13:17:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC298C433D6;
        Tue, 27 Sep 2022 13:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664284676;
        bh=5pDV+1IeylvfkCFNfGNAvhddDJ6vUthK0D0dKmZmb+c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RhazsGhH0AKSFvhKsq/twtVvwPXEbvpVumnhHseP8p8MkU+c/ChI4R4vcMMRa5IIE
         5X0SU043Tk53MpcPsHfmyXRYYIi8CKfoH6uFSOB4E4g6Tr65muwWPn3x8gbmrvYCeW
         CGNFqHN5wlgFIyFo1zNkarZcFsEIHeLgDHcssAdHjUjRnmAMcVCMeMjERyxbsb+pwC
         jBLrQ5ATr7+0GiSctXch8pOWyJ1yAa9UW1e+zxvQcxLgGXwZ7TImFBTSkHp8bbcvjs
         +F/ylRmIsC5N/h7UZaFDyfLBHf9c0uZE0AwMtWqxCMwiOZ3DL/dNgnVmdB64DpGWr3
         0moYdgUKAo88Q==
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
        David Gow <davidgow@google.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-doc@vger.kernel.org
Subject: [PATCH v10 25/27] x86: enable initial Rust support
Date:   Tue, 27 Sep 2022 15:14:56 +0200
Message-Id: <20220927131518.30000-26-ojeda@kernel.org>
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

Note that only x86_64 is covered and not all features nor mitigations
are handled, but it is enough as a starting point and showcases
the basics needed to add Rust support for a new architecture.

Reviewed-by: Kees Cook <keescook@chromium.org>
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
index f9920f1341c8..3ca198742b10 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -257,6 +257,7 @@ config X86
 	select HAVE_STATIC_CALL_INLINE		if HAVE_OBJTOOL
 	select HAVE_PREEMPT_DYNAMIC_CALL
 	select HAVE_RSEQ
+	select HAVE_RUST			if X86_64
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_UACCESS_VALIDATION		if HAVE_OBJTOOL
 	select HAVE_UNSTABLE_SCHED_CLOCK
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index bafbd905e6e7..2d7e640674c6 100644
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
2.37.3

