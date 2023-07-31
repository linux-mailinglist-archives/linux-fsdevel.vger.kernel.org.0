Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67C26769831
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jul 2023 15:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232349AbjGaNwg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jul 2023 09:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232031AbjGaNwC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jul 2023 09:52:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B671FEB;
        Mon, 31 Jul 2023 06:51:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 80BF16115A;
        Mon, 31 Jul 2023 13:51:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42B6AC433C7;
        Mon, 31 Jul 2023 13:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690811499;
        bh=teb0sKS9busqSVOZxV9N3xrEhZqf3CdoVbQJObdkbLU=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=sL9ZVZ+IfV5TNNEBThAe75AacPXe47GMKWaM+6wnMSYvlLERiN7oH0xmtqXjLJM+q
         F3vh1sD1XIlsGRzhgJmH9+eHn5w0wqCs1MOjE8w12Xw2x85t6YTU462MK1vVVBoiyM
         xxOGHm+ZMaZ3iFoUbHbF+3g6Y1L3Wk2pIpjMLkYOptYsmfETh0tDAPDA83WNVqUFUA
         yj5qTgHczPIGSY05nOjE+fO5fKAWC5D6EI+1LUX17helHTHw3gYnseBjwmbz82T4wC
         6tYNo1BvwPbur4QOEBOjG/xBdGAXv36hjPD9zw0EjVuwPXwQTJVXdGAXFv4xGaaRp5
         w1p1jLIgv5Zzw==
From:   Mark Brown <broonie@kernel.org>
Date:   Mon, 31 Jul 2023 14:43:17 +0100
Subject: [PATCH v3 08/36] arm64/cpufeature: Runtime detection of Guarded
 Control Stack (GCS)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230731-arm64-gcs-v3-8-cddf9f980d98@kernel.org>
References: <20230731-arm64-gcs-v3-0-cddf9f980d98@kernel.org>
In-Reply-To: <20230731-arm64-gcs-v3-0-cddf9f980d98@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2901; i=broonie@kernel.org;
 h=from:subject:message-id; bh=teb0sKS9busqSVOZxV9N3xrEhZqf3CdoVbQJObdkbLU=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkx7waihKk7UXo8TXOo9NMiupIexpEkNW57nU/vcKm
 Nkf1weSJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZMe8GgAKCRAk1otyXVSH0EZdB/
 4iWoqjttwEFMCRHpzpL+bj2bqtC386fhdYs54nZCwRhW6JT+giNFSeJpNqB7HR2ArMv/XMX76T4dka
 NsyaOJLQt2YiCpiBHSOQ8Hto+92KRJQ6BIC5LvV+nuXFvQwhvFawBpl84ZcQPBht3IlaCIDhWmiHbm
 oRDVyW/9/gAzAkevJ+CDDq9LQiI3ilWc9x5jkwo/4YA2lpdROL75vZFqkHe+xZQ7zMKaeY9VX41LIt
 qI4/sfihh5pXWZItaT6ffO1qf2hHZ9Ovbn1I1e/alf+URq9C1/tUZ62LhxRMYbXpMflzrqD51qh7qV
 BNLGO2cAsf3FiVG/pIkTlgS3regsCq
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a cpufeature for GCS, allowing other code to conditionally support it
at runtime.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/cpufeature.h |  6 ++++++
 arch/arm64/kernel/cpufeature.c      | 16 ++++++++++++++++
 arch/arm64/tools/cpucaps            |  1 +
 3 files changed, 23 insertions(+)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 96e50227f940..189783142a96 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -831,6 +831,12 @@ static inline bool system_supports_tlb_range(void)
 		cpus_have_const_cap(ARM64_HAS_TLB_RANGE);
 }
 
+static inline bool system_supports_gcs(void)
+{
+	return IS_ENABLED(CONFIG_ARM64_GCS) &&
+		cpus_have_const_cap(ARM64_HAS_GCS);
+}
+
 int do_emulate_mrs(struct pt_regs *regs, u32 sys_reg, u32 rt);
 bool try_emulate_mrs(struct pt_regs *regs, u32 isn);
 
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index f9d456fe132d..91a14a6ccb04 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -254,6 +254,8 @@ static const struct arm64_ftr_bits ftr_id_aa64pfr0[] = {
 };
 
 static const struct arm64_ftr_bits ftr_id_aa64pfr1[] = {
+	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_GCS),
+		       FTR_STRICT, FTR_LOWER_SAFE, ID_AA64PFR1_EL1_GCS_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_SME),
 		       FTR_STRICT, FTR_LOWER_SAFE, ID_AA64PFR1_EL1_SME_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64PFR1_EL1_MPAM_frac_SHIFT, 4, 0),
@@ -2219,6 +2221,12 @@ static void cpu_enable_mops(const struct arm64_cpu_capabilities *__unused)
 	sysreg_clear_set(sctlr_el1, 0, SCTLR_EL1_MSCEn);
 }
 
+static void cpu_enable_gcs(const struct arm64_cpu_capabilities *__unused)
+{
+	/* GCS is not currently used at EL1 */
+	write_sysreg_s(0, SYS_GCSCR_EL1);
+}
+
 /* Internal helper functions to match cpu capability type */
 static bool
 cpucap_late_cpu_optional(const struct arm64_cpu_capabilities *cap)
@@ -2715,6 +2723,14 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.min_field_value = ID_AA64MMFR2_EL1_EVT_IMP,
 		.matches = has_cpuid_feature,
 	},
+	{
+		.desc = "Guarded Control Stack (GCS)",
+		.capability = ARM64_HAS_GCS,
+		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
+		.cpu_enable = cpu_enable_gcs,
+		.matches = has_cpuid_feature,
+		ARM64_CPUID_FIELDS(ID_AA64PFR1_EL1, GCS, IMP)
+	},
 	{},
 };
 
diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
index c80ed4f3cbce..ab582f592131 100644
--- a/arch/arm64/tools/cpucaps
+++ b/arch/arm64/tools/cpucaps
@@ -26,6 +26,7 @@ HAS_ECV
 HAS_ECV_CNTPOFF
 HAS_EPAN
 HAS_EVT
+HAS_GCS
 HAS_GENERIC_AUTH
 HAS_GENERIC_AUTH_ARCH_QARMA3
 HAS_GENERIC_AUTH_ARCH_QARMA5

-- 
2.30.2

