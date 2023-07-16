Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1824755798
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Jul 2023 23:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbjGPVya (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 16 Jul 2023 17:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbjGPVyC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 16 Jul 2023 17:54:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E39B91BF8;
        Sun, 16 Jul 2023 14:53:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE4FA60ECB;
        Sun, 16 Jul 2023 21:53:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CD84C433D9;
        Sun, 16 Jul 2023 21:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689544413;
        bh=sadX6jRs7DdBAThhpdGK2D3phr2V3dLQCMXle4b8GlY=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=EIVXuTuIY+cy+svRx16q095lI8R0qYEdOnkOpM9Dz2Mjyt+JMQ4TIwpAfclZkxmRz
         ypDoe9p/s18CxofvI37IomTHdfWP/9ysfadVqw7BdoRUwvqSALK67h+oMtcp5OUObP
         i7YE1uF0gfZhoDqusjcKZB4dpDfY7X5pbL/4062mvPPbIsSmZ3+LpE+J9hCU8p346t
         0Ep2VvlDKLO93cmtTkVUdRAZTYLaU0yWF8RnMwbqM/odUvzOgPK5Kn07Ba6ZhIwdML
         LPjzexYvYaw/o+Td2pL5yWshmxzdAoal7Hmj24SzLJDDdlmginyHcAuMKBerDOqKrY
         muhKI3h9RlMUQ==
From:   Mark Brown <broonie@kernel.org>
Date:   Sun, 16 Jul 2023 22:51:03 +0100
Subject: [PATCH 07/35] arm64/gcs: Add manual encodings of GCS instructions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230716-arm64-gcs-v1-7-bf567f93bba6@kernel.org>
References: <20230716-arm64-gcs-v1-0-bf567f93bba6@kernel.org>
In-Reply-To: <20230716-arm64-gcs-v1-0-bf567f93bba6@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Oleg Nesterov <oleg@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuah@kernel.org>,
        "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>,
        Deepak Gupta <debug@rivosinc.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Cc:     "H.J. Lu" <hjl.tools@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=2577; i=broonie@kernel.org;
 h=from:subject:message-id; bh=sadX6jRs7DdBAThhpdGK2D3phr2V3dLQCMXle4b8GlY=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBktGaUN4aeaAwCFkHQflmt2PAnyRNXHtw45Ywz6qxG
 Xab0kZeJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZLRmlAAKCRAk1otyXVSH0BL2B/
 9k5JaZ3viuyrN8msxXAcCE/j7Koesget2VB5E9ovny/d0xhQf2MogVf7/QvYRD9OA/+TfA7lYCEt/A
 4aO8Cq2y75rdhJuvFGZwumZPFCnWc5ZKJFGcfsgd4Vf8P/2LIMeNLleBrub3YbxT8svakkp4ty2ZVl
 +xdMETvjbnSIL+gAtd8JWzrJJPxW8pXhdhHtu9FTBEEaUUW24+yl73iyczpCe+0Ikezyl+uFUcFJJc
 R1Cl80dOZD87l9pyRbKGpfdOBrlodw/y5gO+kascJmdAkpz8yqOCS8afTERsLU1GMkSF6SYrGweBjK
 ADoQZ6GrMvuvaX4xnAlSxn3W8iLLwx
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Define C callable functions for GCS instructions used by the kernel. In
order to avoid ambitious toolchain requirements for GCS support these are
manually encoded, this means we have fixed register numbers which will be
a bit limiting for the compiler but none of these should be used in
sufficiently fast paths for this to be a problem.

Note that GCSSTTR is used to store to EL0.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/gcs.h     | 51 ++++++++++++++++++++++++++++++++++++++++
 arch/arm64/include/asm/uaccess.h | 22 +++++++++++++++++
 2 files changed, 73 insertions(+)

diff --git a/arch/arm64/include/asm/gcs.h b/arch/arm64/include/asm/gcs.h
new file mode 100644
index 000000000000..7c5e95218db6
--- /dev/null
+++ b/arch/arm64/include/asm/gcs.h
@@ -0,0 +1,51 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2023 ARM Ltd.
+ */
+#ifndef __ASM_GCS_H
+#define __ASM_GCS_H
+
+#include <asm/types.h>
+#include <asm/uaccess.h>
+
+static inline void gcsb_dsync(void)
+{
+	asm volatile(".inst 0xd503227f" : : : "memory");
+}
+
+static inline void gcsstr(u64 *addr, u64 val)
+{
+	register u64 *_addr __asm__ ("x0") = addr;
+	register long _val __asm__ ("x1") = val;
+
+	/* GCSSTTR x1, x0 */
+	asm volatile(
+		".inst 0xd91f1c01\n"
+		:
+		: "rZ" (_val), "r" (_addr)
+		: "memory");
+}
+
+static inline void gcsss1(u64 Xt)
+{
+	asm volatile (
+		"sys #3, C7, C7, #2, %0\n"
+		:
+		: "rZ" (Xt)
+		: "memory");
+}
+
+static inline u64 gcsss2(void)
+{
+	u64 Xt;
+
+	asm volatile(
+		"SYSL %0, #3, C7, C7, #3\n"
+		: "=r" (Xt)
+		:
+		: "memory");
+
+	return Xt;
+}
+
+#endif
diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index 14be5000c5a0..22e10e79f56a 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -425,4 +425,26 @@ static inline size_t probe_subpage_writeable(const char __user *uaddr,
 
 #endif /* CONFIG_ARCH_HAS_SUBPAGE_FAULTS */
 
+#ifdef CONFIG_ARM64_GCS
+
+static inline int gcssttr(unsigned long __user *addr, unsigned long val)
+{
+	register unsigned long __user *_addr __asm__ ("x0") = addr;
+	register unsigned long _val __asm__ ("x1") = val;
+	int err = 0;
+
+	/* GCSSTTR x1, x0 */
+	asm volatile(
+		"1: .inst 0xd91f1c01\n"
+		"2: \n"
+		_ASM_EXTABLE_UACCESS_ERR(1b, 2b, %w0)
+		: "+r" (err)
+		: "rZ" (_val), "r" (_addr)
+		: "memory");
+
+	return err;
+}
+
+#endif /* CONFIG_ARM64_GCS */
+
 #endif /* __ASM_UACCESS_H */

-- 
2.30.2

