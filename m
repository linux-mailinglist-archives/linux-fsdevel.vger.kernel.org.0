Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF96F7557E3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Jul 2023 23:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbjGPV5g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 16 Jul 2023 17:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbjGPV5X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 16 Jul 2023 17:57:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF5603A94;
        Sun, 16 Jul 2023 14:55:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BACF460ED8;
        Sun, 16 Jul 2023 21:55:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BA9CC433C7;
        Sun, 16 Jul 2023 21:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689544527;
        bh=to6PBtVZ1GuKCQwlsV7jSkIuR15BYJZoBASRv52qqIg=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=iLUlGpB/43PkqwyawZGMnBIGR4Dblqhrh5Ec6oN21Irp690oBB7SuaGei4k8Bwf2P
         TZZrPK9gfV5hckCt3eW9/a7wdoW8cemKlL07uvjh3BRCgQwpmVNtGCE8KeVXckS0lb
         YBpUOj/BXcj1SNbSrKWEbb228G9VFaPz+C6Zw/1eRzLLKWCgGJ3EAXWM+fzIherLXT
         2oW3d/U5J6dTw1F5lDaDO0+76DbxZ7b8f4jPg/ahNKunSI3k3PD99RXofd8lWzLEU0
         4KsdClS0i6CyCkQP88/G9Nox1jngSwyJdnzMdbsFlf5lrM+ij4hkoW/eY+u7Mne6jz
         wx7wx9/fihXWw==
From:   Mark Brown <broonie@kernel.org>
Date:   Sun, 16 Jul 2023 22:51:21 +0100
Subject: [PATCH 25/35] arm64/ptrace: Expose GCS via ptrace and core files
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230716-arm64-gcs-v1-25-bf567f93bba6@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3847; i=broonie@kernel.org;
 h=from:subject:message-id; bh=to6PBtVZ1GuKCQwlsV7jSkIuR15BYJZoBASRv52qqIg=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBktGajwKY7OUs4EjMbqN+4gyPU5kEBbDNcshocU2e5
 aOA4FPiJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZLRmowAKCRAk1otyXVSH0L9kCA
 CE3JGhO06qpWQKcxj7CzN/00f5pvQz+LX3j1E2y1Xu9qykfLtM64OSS01+oD5Oxz0wG95CPzo1slly
 Zjt8LEVT07+/emAitoazYW9VbE07UivsLVgbJxgTCLN4KyF5i9knKQawTJ05Rr9A11uetfLF+VCKDW
 8E+ACCTpgT8FtTvkz4b6xqt4klgau06ND5CAab1jWKL3ammg5DfoU3DVph4jJsHNFRBD0NenmB8HfJ
 aYqHzQGFAjSSzc9CnB/hwZFU8ouaddVweOQT+/Bvt/s/N6QT/RNAps2WzD4XJ/4cobLvghHAW5h1qc
 tfJ1X7YKfBAruCbDGW/mAQ2sr5uI4k
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Provide a new register type NT_ARM_GCS reporting the current GCS mode
and pointer for EL0.  Due to the interactions with allocation and
deallocation of Guarded Control Stacks we do not permit any changes to
the GCS mode via ptrace, only GCSPR_EL0 may be changed.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/uapi/asm/ptrace.h |  7 +++++
 arch/arm64/kernel/ptrace.c           | 50 ++++++++++++++++++++++++++++++++++++
 include/uapi/linux/elf.h             |  1 +
 3 files changed, 58 insertions(+)

diff --git a/arch/arm64/include/uapi/asm/ptrace.h b/arch/arm64/include/uapi/asm/ptrace.h
index 7fa2f7036aa7..342d5abaca87 100644
--- a/arch/arm64/include/uapi/asm/ptrace.h
+++ b/arch/arm64/include/uapi/asm/ptrace.h
@@ -324,6 +324,13 @@ struct user_za_header {
 #define ZA_PT_SIZE(vq)						\
 	(ZA_PT_ZA_OFFSET + ZA_PT_ZA_SIZE(vq))
 
+/* GCS state (NT_ARM_GCS) */
+
+struct user_gcs {
+	__u64 features_enabled;
+	__u64 gcspr_el0;
+};
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* _UAPI__ASM_PTRACE_H */
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index d7f4f0d1ae12..09f671b8f188 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -33,6 +33,7 @@
 #include <asm/cpufeature.h>
 #include <asm/debug-monitors.h>
 #include <asm/fpsimd.h>
+#include <asm/gcs.h>
 #include <asm/mte.h>
 #include <asm/pointer_auth.h>
 #include <asm/stacktrace.h>
@@ -1390,6 +1391,42 @@ static int tagged_addr_ctrl_set(struct task_struct *target, const struct
 }
 #endif
 
+#ifdef CONFIG_ARM64_GCS
+static int gcs_get(struct task_struct *target,
+		   const struct user_regset *regset,
+		   struct membuf to)
+{
+	struct user_gcs user_gcs;
+
+	if (target == current)
+		gcs_preserve_current_state();
+
+	user_gcs.features_enabled = target->thread.gcs_el0_mode;
+	user_gcs.gcspr_el0 = target->thread.gcspr_el0;
+
+	return membuf_write(&to, &user_gcs, sizeof(user_gcs));
+}
+
+static int gcs_set(struct task_struct *target, const struct
+		   user_regset *regset, unsigned int pos,
+		   unsigned int count, const void *kbuf, const
+		   void __user *ubuf)
+{
+	int ret;
+	struct user_gcs user_gcs;
+
+	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, &user_gcs, 0, -1);
+	if (ret)
+		return ret;
+
+	if (user_gcs.features_enabled != target->thread.gcs_el0_mode)
+		return -EBUSY;
+	target->thread.gcspr_el0 = user_gcs.gcspr_el0;
+
+	return 0;
+}
+#endif
+
 enum aarch64_regset {
 	REGSET_GPR,
 	REGSET_FPR,
@@ -1418,6 +1455,9 @@ enum aarch64_regset {
 #ifdef CONFIG_ARM64_TAGGED_ADDR_ABI
 	REGSET_TAGGED_ADDR_CTRL,
 #endif
+#ifdef CONFIG_ARM64_GCS
+	REGSET_GCS,
+#endif
 };
 
 static const struct user_regset aarch64_regsets[] = {
@@ -1568,6 +1608,16 @@ static const struct user_regset aarch64_regsets[] = {
 		.set = tagged_addr_ctrl_set,
 	},
 #endif
+#ifdef CONFIG_ARM64_GCS
+	[REGSET_GCS] = {
+		.core_note_type = NT_ARM_GCS,
+		.n = sizeof(struct user_gcs) / sizeof(u64),
+		.size = sizeof(u64),
+		.align = sizeof(u64),
+		.regset_get = gcs_get,
+		.set = gcs_set,
+	},
+#endif
 };
 
 static const struct user_regset_view user_aarch64_view = {
diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
index 0c8cf359ea5b..00f698a2ab17 100644
--- a/include/uapi/linux/elf.h
+++ b/include/uapi/linux/elf.h
@@ -438,6 +438,7 @@ typedef struct elf64_shdr {
 #define NT_ARM_SSVE	0x40b		/* ARM Streaming SVE registers */
 #define NT_ARM_ZA	0x40c		/* ARM SME ZA registers */
 #define NT_ARM_ZT	0x40d		/* ARM SME ZT registers */
+#define NT_ARM_GCS	0x40e		/* ARM GCS state */
 #define NT_ARC_V2	0x600		/* ARCv2 accumulator/extra registers */
 #define NT_VMCOREDD	0x700		/* Vmcore Device Dump Note */
 #define NT_MIPS_DSP	0x800		/* MIPS DSP ASE registers */

-- 
2.30.2

