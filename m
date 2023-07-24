Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC85575F725
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jul 2023 14:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbjGXMw1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jul 2023 08:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbjGXMvc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jul 2023 08:51:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8365A2695;
        Mon, 24 Jul 2023 05:49:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5881861159;
        Mon, 24 Jul 2023 12:49:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8FE5C43395;
        Mon, 24 Jul 2023 12:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690202972;
        bh=0QIP38ZumyMQzrMYtc7Z/0L/bXiC+1OudC2zVRODlMU=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=S2by7fTwtza1j7xK4vbG8/TPOT2ELIzrq6FBkXgnpc6RctcJGbowE2cdinUL4ulWk
         7kgfWBLa3QPeh67Bq/HwoBGJPM3YKT3ieNSZa3vjgLZvwW6V298RjM3nH+udx3CZ7C
         BalpvWV9J6jGIyyXUu5c/FlFhlhXbavjPDUawnWhwgNT/Wf2N/860D5yMszrT+6AnJ
         u25J44GdZV9Dr/bbXzh20oPEcGz+lcIPgUy2JEBop64BJ1G/yRUV/1MQNCVuhE2pbT
         JmF6sNtU8bcS1oP52Rijepzl0lILyOL3xAYAStMey/6YrpMjkwefKWab1SHoNzf58u
         lAzw2ITdTjNfA==
From:   Mark Brown <broonie@kernel.org>
Date:   Mon, 24 Jul 2023 13:46:11 +0100
Subject: [PATCH v2 24/35] arm64/ptrace: Expose GCS via ptrace and core
 files
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230724-arm64-gcs-v2-24-dc2c1d44c2eb@kernel.org>
References: <20230724-arm64-gcs-v2-0-dc2c1d44c2eb@kernel.org>
In-Reply-To: <20230724-arm64-gcs-v2-0-dc2c1d44c2eb@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4259; i=broonie@kernel.org;
 h=from:subject:message-id; bh=0QIP38ZumyMQzrMYtc7Z/0L/bXiC+1OudC2zVRODlMU=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkvnKnsKf0W3lFoB635rzoGTaz2yndy/CskcQVKCzm
 47uSwjaJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZL5ypwAKCRAk1otyXVSH0AebB/
 9puHQ2nwuUf5/vMSPRgsFleh5e8Wzb39H2Z5TEz9UwGoC/oIWJUEWVBE4rq/Rh28vaZI7jO8ZJyAta
 21BWYzIEGw6stgm713SrMoFk2ZjG7RqY0nnGCWqcnSEb0pNnKbzaXp0reUarS0StFUw6hli3dYbmBN
 QtVbuiA+19RLe6CiXaEG8sQecaHQquhFMUjYf2OOpLdfB8IzlPHpE93YRBqRK8t1AcKPzkGab0+uN4
 FjBtounVbAZNw2iobITFysaexYdZPhDsMqBbufwQGQhzhsXveM2YJWEjo3+yvHwtajHgHDwAjJpdvo
 1whVPHF41mLonD9s5b5HGyBbHehGOz
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

Provide a new register type NT_ARM_GCS reporting the current GCS mode
and pointer for EL0.  Due to the interactions with allocation and
deallocation of Guarded Control Stacks we do not permit any changes to
the GCS mode via ptrace, only GCSPR_EL0 may be changed.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/uapi/asm/ptrace.h |  8 +++++
 arch/arm64/kernel/ptrace.c           | 59 ++++++++++++++++++++++++++++++++++++
 include/uapi/linux/elf.h             |  1 +
 3 files changed, 68 insertions(+)

diff --git a/arch/arm64/include/uapi/asm/ptrace.h b/arch/arm64/include/uapi/asm/ptrace.h
index 7fa2f7036aa7..0f39ba4f3efd 100644
--- a/arch/arm64/include/uapi/asm/ptrace.h
+++ b/arch/arm64/include/uapi/asm/ptrace.h
@@ -324,6 +324,14 @@ struct user_za_header {
 #define ZA_PT_SIZE(vq)						\
 	(ZA_PT_ZA_OFFSET + ZA_PT_ZA_SIZE(vq))
 
+/* GCS state (NT_ARM_GCS) */
+
+struct user_gcs {
+	__u64 features_enabled;
+	__u64 features_locked;
+	__u64 gcspr_el0;
+};
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* _UAPI__ASM_PTRACE_H */
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index d7f4f0d1ae12..c159090bc731 100644
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
@@ -1390,6 +1391,51 @@ static int tagged_addr_ctrl_set(struct task_struct *target, const struct
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
+	user_gcs.features_locked = target->thread.gcs_el0_locked;
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
+	if (user_gcs.features_enabled & ~PR_SHADOW_STACK_SUPPORTED_STATUS_MASK)
+		return -EINVAL;
+
+	/* Do not allow enable via ptrace */
+	if ((user_gcs.features_enabled & PR_SHADOW_STACK_ENABLE) &&
+	    !!(target->thread.gcs_el0_mode & PR_SHADOW_STACK_ENABLE))
+		return -EBUSY;
+
+	target->thread.gcs_el0_mode = user_gcs.features_enabled;
+	target->thread.gcs_el0_locked = user_gcs.features_locked;
+	target->thread.gcspr_el0 = user_gcs.gcspr_el0;
+
+	return 0;
+}
+#endif
+
 enum aarch64_regset {
 	REGSET_GPR,
 	REGSET_FPR,
@@ -1418,6 +1464,9 @@ enum aarch64_regset {
 #ifdef CONFIG_ARM64_TAGGED_ADDR_ABI
 	REGSET_TAGGED_ADDR_CTRL,
 #endif
+#ifdef CONFIG_ARM64_GCS
+	REGSET_GCS,
+#endif
 };
 
 static const struct user_regset aarch64_regsets[] = {
@@ -1568,6 +1617,16 @@ static const struct user_regset aarch64_regsets[] = {
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

