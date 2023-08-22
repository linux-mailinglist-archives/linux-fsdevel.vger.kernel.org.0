Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D56E784302
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Aug 2023 16:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236398AbjHVOFE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Aug 2023 10:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236400AbjHVOFB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Aug 2023 10:05:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE99E5D;
        Tue, 22 Aug 2023 07:04:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C7E2657A7;
        Tue, 22 Aug 2023 14:04:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0922C433CA;
        Tue, 22 Aug 2023 14:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692713063;
        bh=tjbWwPwmImMptyDPc55s3c7Oj7q65gF9QqqfPkrYo0c=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=RCqk+m47/b5oHaZ/1B7AckLPjxeFflR5uvj4P08XSiPQe8kqjItk7kcv9/mTaexbd
         oG1uUYZzlINkKJ1EtUN7rMgHVY3ELd4gwPlGZQh3cEchNr8uWF+NyBnkq+YTweMKtI
         lVZYsN/CNP6k36YydVJLgNv+kUGd+gHse4l/ueEAaKlI7oxEHR1yxzpDs1Ll65V8yh
         Xu0U7Lo01W56XviOnbZP3QB4fMwXf0mdA26Cu/OLS2mi7VWuo5BhrA+7CBoW4yPUZ7
         PFwrQrlLxiDYoA5hbQyoDK2PIJy8ZdCbGj9P2NrsrWdQaXr92VbjyPCg5FUauhrTYV
         SD3s8KT+NxQNw==
From:   Mark Brown <broonie@kernel.org>
Date:   Tue, 22 Aug 2023 14:56:46 +0100
Subject: [PATCH v5 13/37] KVM: arm64: Manage GCS registers for guests
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230822-arm64-gcs-v5-13-9ef181dd6324@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5343; i=broonie@kernel.org;
 h=from:subject:message-id; bh=tjbWwPwmImMptyDPc55s3c7Oj7q65gF9QqqfPkrYo0c=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBk5L/6AHYHf7W6pdvodyEwO+Essp58pjlzx9Bd3yyH
 N/jhqSqJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZOS/+gAKCRAk1otyXVSH0A47B/
 sE/DNEBmtyZi27FTcHyMq2hTww99gioyBIL60ulWDm1glKQO1pj1+h/N6/IdTwgDYIA/J7zwO5B+rA
 EACRzKbOspBdaKgPGAu3qgY8KkuQ6xCnO7pgYVjlZc2Z7t+otM6GWnPd3fAv3rDXKRGoU7IwL6AL/M
 r+JUmgGZ3dHg4GOel9YrtAW9w/cpBagnUkKV7K8rYVunarnUGe6P4zK+gFkxTwv5IlfZHcojaEWUSf
 uTjwPwfL1yJl+zCdQgnRJejY85VLVYOD+Jjv1PNoJAJO8t6YZdmYvne4r88CHCniHExK/Bs5OMIRKr
 /GrENFHK36+hqocZgHmnv5qePOPi2I
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

GCS introduces a number of system registers for EL1 and EL0, on systems
with GCS we need to context switch them and expose them to VMMs to allow
guests to use GCS.  Traps are already disabled.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/kvm_host.h          | 12 ++++++++++++
 arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h | 17 +++++++++++++++++
 arch/arm64/kvm/sys_regs.c                  | 22 ++++++++++++++++++++++
 3 files changed, 51 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index d3dd05bbfe23..a5bb00f58108 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -364,6 +364,12 @@ enum vcpu_sysreg {
 	PIR_EL1,       /* Permission Indirection Register 1 (EL1) */
 	PIRE0_EL1,     /*  Permission Indirection Register 0 (EL1) */
 
+	/* Guarded Control Stack registers */
+	GCSCRE0_EL1,	/* Guarded Control Stack Control (EL0) */
+	GCSCR_EL1,	/* Guarded Control Stack Control (EL1) */
+	GCSPR_EL0,	/* Guarded Control Stack Pointer (EL0) */
+	GCSPR_EL1,	/* Guarded Control Stack Pointer (EL1) */
+
 	/* 32bit specific registers. */
 	DACR32_EL2,	/* Domain Access Control Register */
 	IFSR32_EL2,	/* Instruction Fault Status Register */
@@ -1136,6 +1142,12 @@ bool kvm_arm_vcpu_is_finalized(struct kvm_vcpu *vcpu);
 #define kvm_vm_has_ran_once(kvm)					\
 	(test_bit(KVM_ARCH_FLAG_HAS_RAN_ONCE, &(kvm)->arch.flags))
 
+static inline bool has_gcs(void)
+{
+	return IS_ENABLED(CONFIG_ARM64_GCS) &&
+		cpus_have_final_cap(ARM64_HAS_GCS);
+}
+
 int kvm_trng_call(struct kvm_vcpu *vcpu);
 #ifdef CONFIG_KVM
 extern phys_addr_t hyp_mem_base;
diff --git a/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h b/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
index bb6b571ec627..ec34d4a90717 100644
--- a/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
+++ b/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
@@ -25,6 +25,8 @@ static inline void __sysreg_save_user_state(struct kvm_cpu_context *ctxt)
 {
 	ctxt_sys_reg(ctxt, TPIDR_EL0)	= read_sysreg(tpidr_el0);
 	ctxt_sys_reg(ctxt, TPIDRRO_EL0)	= read_sysreg(tpidrro_el0);
+	if (has_gcs())
+		ctxt_sys_reg(ctxt, GCSPR_EL0) = read_sysreg_s(SYS_GCSPR_EL0);
 }
 
 static inline bool ctxt_has_mte(struct kvm_cpu_context *ctxt)
@@ -62,6 +64,12 @@ static inline void __sysreg_save_el1_state(struct kvm_cpu_context *ctxt)
 	ctxt_sys_reg(ctxt, PAR_EL1)	= read_sysreg_par();
 	ctxt_sys_reg(ctxt, TPIDR_EL1)	= read_sysreg(tpidr_el1);
 
+	if (has_gcs()) {
+		ctxt_sys_reg(ctxt, GCSPR_EL1)	= read_sysreg_el1(SYS_GCSPR);
+		ctxt_sys_reg(ctxt, GCSCR_EL1)	= read_sysreg_el1(SYS_GCSCR);
+		ctxt_sys_reg(ctxt, GCSCRE0_EL1)	= read_sysreg_s(SYS_GCSCRE0_EL1);
+	}
+
 	if (ctxt_has_mte(ctxt)) {
 		ctxt_sys_reg(ctxt, TFSR_EL1) = read_sysreg_el1(SYS_TFSR);
 		ctxt_sys_reg(ctxt, TFSRE0_EL1) = read_sysreg_s(SYS_TFSRE0_EL1);
@@ -95,6 +103,8 @@ static inline void __sysreg_restore_user_state(struct kvm_cpu_context *ctxt)
 {
 	write_sysreg(ctxt_sys_reg(ctxt, TPIDR_EL0),	tpidr_el0);
 	write_sysreg(ctxt_sys_reg(ctxt, TPIDRRO_EL0),	tpidrro_el0);
+	if (has_gcs())
+		write_sysreg_s(ctxt_sys_reg(ctxt, GCSPR_EL0), SYS_GCSPR_EL0);
 }
 
 static inline void __sysreg_restore_el1_state(struct kvm_cpu_context *ctxt)
@@ -138,6 +148,13 @@ static inline void __sysreg_restore_el1_state(struct kvm_cpu_context *ctxt)
 	write_sysreg(ctxt_sys_reg(ctxt, PAR_EL1),	par_el1);
 	write_sysreg(ctxt_sys_reg(ctxt, TPIDR_EL1),	tpidr_el1);
 
+	if (has_gcs()) {
+		write_sysreg_el1(ctxt_sys_reg(ctxt, GCSPR_EL1),	SYS_GCSPR);
+		write_sysreg_el1(ctxt_sys_reg(ctxt, GCSCR_EL1),	SYS_GCSCR);
+		write_sysreg_s(ctxt_sys_reg(ctxt, GCSCRE0_EL1),
+			       SYS_GCSCRE0_EL1);
+	}
+
 	if (ctxt_has_mte(ctxt)) {
 		write_sysreg_el1(ctxt_sys_reg(ctxt, TFSR_EL1), SYS_TFSR);
 		write_sysreg_s(ctxt_sys_reg(ctxt, TFSRE0_EL1), SYS_TFSRE0_EL1);
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 2ca2973abe66..5b2f238d33be 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1768,6 +1768,23 @@ static unsigned int mte_visibility(const struct kvm_vcpu *vcpu,
 	.visibility = mte_visibility,		\
 }
 
+static unsigned int gcs_visibility(const struct kvm_vcpu *vcpu,
+				   const struct sys_reg_desc *rd)
+{
+	if (has_gcs())
+		return 0;
+
+	return REG_HIDDEN;
+}
+
+#define GCS_REG(name) {				\
+	SYS_DESC(SYS_##name),			\
+	.access = undef_access,			\
+	.reset = reset_unknown,			\
+	.reg = name,				\
+	.visibility = gcs_visibility,		\
+}
+
 static unsigned int el2_visibility(const struct kvm_vcpu *vcpu,
 				   const struct sys_reg_desc *rd)
 {
@@ -2080,6 +2097,10 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	PTRAUTH_KEY(APDB),
 	PTRAUTH_KEY(APGA),
 
+	GCS_REG(GCSCR_EL1),
+	GCS_REG(GCSPR_EL1),
+	GCS_REG(GCSCRE0_EL1),
+
 	{ SYS_DESC(SYS_SPSR_EL1), access_spsr},
 	{ SYS_DESC(SYS_ELR_EL1), access_elr},
 
@@ -2162,6 +2183,7 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	{ SYS_DESC(SYS_SMIDR_EL1), undef_access },
 	{ SYS_DESC(SYS_CSSELR_EL1), access_csselr, reset_unknown, CSSELR_EL1 },
 	{ SYS_DESC(SYS_CTR_EL0), access_ctr },
+	GCS_REG(GCSPR_EL0),
 	{ SYS_DESC(SYS_SVCR), undef_access },
 
 	{ PMU_SYS_REG(PMCR_EL0), .access = access_pmcr,

-- 
2.30.2

