Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3782978431C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Aug 2023 16:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236448AbjHVOFx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Aug 2023 10:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236451AbjHVOFn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Aug 2023 10:05:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A043A10D0;
        Tue, 22 Aug 2023 07:05:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1916B65781;
        Tue, 22 Aug 2023 14:04:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9805AC43397;
        Tue, 22 Aug 2023 14:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692713082;
        bh=ggfCgbEg0UE7JP5CH6e+dKjRf0SerXD/ltcRHcZOEeI=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=PVf4F+5e6t8UUn6GXDHZi9BvZRw+m0vJxxlC91Y+yBnT+DenVPfSgbW/1w8vHEcs5
         hq5ngEXwckWY9oCWklaJVn+Cz4i+Hb7Pb+HyOeHTVt0p18dbb8XuCuzDwxXCZAtlzb
         6p1/o8hbt7SE6/a+cd+ZYSZ7AUK1JhjB+an4crDxKNtg44IrCJwF1p3grdQvpPlXAk
         vZufltGG8aXY+z6av+xoWDvTN0kQEFsRuzILLsd9n6BZ9MRGZCGpRDs6hw6fJtgh/6
         zfEtJxsOevzv4ydSNFeqpobaM9tniDA/fgC4nwIQR2PHG9Gjp8h/mXJms1judgWcy9
         8RJQK2shpfIbw==
From:   Mark Brown <broonie@kernel.org>
Date:   Tue, 22 Aug 2023 14:56:49 +0100
Subject: [PATCH v5 16/37] arm64/hwcap: Add hwcap for GCS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230822-arm64-gcs-v5-16-9ef181dd6324@kernel.org>
References: <20230822-arm64-gcs-v5-0-9ef181dd6324@kernel.org>
In-Reply-To: <20230822-arm64-gcs-v5-0-9ef181dd6324@kernel.org>
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
X-Mailer: b4 0.13-dev-034f2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3001; i=broonie@kernel.org;
 h=from:subject:message-id; bh=ggfCgbEg0UE7JP5CH6e+dKjRf0SerXD/ltcRHcZOEeI=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBk5L/88D0+8mIFj/SJZ4PZzOsz1BzhGTXwEx55mTve
 3j6LrUWJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZOS//AAKCRAk1otyXVSH0HYlB/
 9t7R1TANYsl4wXEHzWtNfhLanvzKzswgGvwqg5bmQhyHDwPtTqc5hckjtVPt/f/LJVr51CdGDI94sS
 r2Uaf6n5U2WmuiCip2sf324ojSqnqEESvqIhMOY+5esBYRf1GJnRB6BkVcnhvSltvVhJgkSoTqYdhI
 pbUOisNhR7+G5i9CsyNGMmD2Jplfn3F0Vw4XUr1Vgex0v4DRUf28aXbXv5QHQw/x+qQ4gNUpN5Px9L
 EWv/4VLtx4ndzg7vkWSi0+7g0OVmIVBWaEsRf9SIwRwiKq7tMIPmUgvZN9JUt19+Sqag4U1ZfuO3lC
 V4niGItNSjXw/mwDDx7oU2HQZ8Fde9
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Provide a hwcap to enable userspace to detect support for GCS.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/arch/arm64/elf_hwcaps.rst | 3 +++
 arch/arm64/include/asm/hwcap.h          | 1 +
 arch/arm64/include/uapi/asm/hwcap.h     | 1 +
 arch/arm64/kernel/cpufeature.c          | 3 +++
 arch/arm64/kernel/cpuinfo.c             | 1 +
 5 files changed, 9 insertions(+)

diff --git a/Documentation/arch/arm64/elf_hwcaps.rst b/Documentation/arch/arm64/elf_hwcaps.rst
index 8c8addb4194c..75f3960cad39 100644
--- a/Documentation/arch/arm64/elf_hwcaps.rst
+++ b/Documentation/arch/arm64/elf_hwcaps.rst
@@ -305,6 +305,9 @@ HWCAP2_SMEF16F16
 HWCAP2_MOPS
     Functionality implied by ID_AA64ISAR2_EL1.MOPS == 0b0001.
 
+HWCAP2_GCS
+    Functionality implied by ID_AA64PFR1_EL1.GCS == 0b1
+
 4. Unused AT_HWCAP bits
 -----------------------
 
diff --git a/arch/arm64/include/asm/hwcap.h b/arch/arm64/include/asm/hwcap.h
index 692b1ec663b2..39f397a2b5b2 100644
--- a/arch/arm64/include/asm/hwcap.h
+++ b/arch/arm64/include/asm/hwcap.h
@@ -138,6 +138,7 @@
 #define KERNEL_HWCAP_SME_B16B16		__khwcap2_feature(SME_B16B16)
 #define KERNEL_HWCAP_SME_F16F16		__khwcap2_feature(SME_F16F16)
 #define KERNEL_HWCAP_MOPS		__khwcap2_feature(MOPS)
+#define KERNEL_HWCAP_GCS		__khwcap2_feature(GCS)
 
 /*
  * This yields a mask that user programs can use to figure out what
diff --git a/arch/arm64/include/uapi/asm/hwcap.h b/arch/arm64/include/uapi/asm/hwcap.h
index a2cac4305b1e..7510c35e6864 100644
--- a/arch/arm64/include/uapi/asm/hwcap.h
+++ b/arch/arm64/include/uapi/asm/hwcap.h
@@ -103,5 +103,6 @@
 #define HWCAP2_SME_B16B16	(1UL << 41)
 #define HWCAP2_SME_F16F16	(1UL << 42)
 #define HWCAP2_MOPS		(1UL << 43)
+#define HWCAP2_GCS		(1UL << 44)
 
 #endif /* _UAPI__ASM_HWCAP_H */
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 91a14a6ccb04..7b46e01140c4 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -2840,6 +2840,9 @@ static const struct arm64_cpu_capabilities arm64_elf_hwcaps[] = {
 	HWCAP_CAP(ID_AA64ZFR0_EL1, I8MM, IMP, CAP_HWCAP, KERNEL_HWCAP_SVEI8MM),
 	HWCAP_CAP(ID_AA64ZFR0_EL1, F32MM, IMP, CAP_HWCAP, KERNEL_HWCAP_SVEF32MM),
 	HWCAP_CAP(ID_AA64ZFR0_EL1, F64MM, IMP, CAP_HWCAP, KERNEL_HWCAP_SVEF64MM),
+#endif
+#ifdef CONFIG_ARM64_GCS
+	HWCAP_CAP(ID_AA64PFR1_EL1, GCS, IMP, CAP_HWCAP, KERNEL_HWCAP_GCS),
 #endif
 	HWCAP_CAP(ID_AA64PFR1_EL1, SSBS, SSBS2, CAP_HWCAP, KERNEL_HWCAP_SSBS),
 #ifdef CONFIG_ARM64_BTI
diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index 58622dc85917..451fbbeffa39 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -126,6 +126,7 @@ static const char *const hwcap_str[] = {
 	[KERNEL_HWCAP_SME_B16B16]	= "smeb16b16",
 	[KERNEL_HWCAP_SME_F16F16]	= "smef16f16",
 	[KERNEL_HWCAP_MOPS]		= "mops",
+	[KERNEL_HWCAP_GCS]		= "gcs",
 };
 
 #ifdef CONFIG_COMPAT

-- 
2.30.2

