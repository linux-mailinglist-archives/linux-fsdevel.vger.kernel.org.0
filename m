Return-Path: <linux-fsdevel+bounces-26625-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB1595A9EE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 03:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFB791F21980
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 01:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 884E43BB47;
	Thu, 22 Aug 2024 01:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j34IVQ+H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DC8139CF6;
	Thu, 22 Aug 2024 01:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724289686; cv=none; b=ZB3+E+/FM4m46HgDF4dPqKSbQj+fLLWQFzUs6kcm/wkYHKUFbZMDzTxlfRnLe4Sl4F8qhhCSwYVHH7eqB/CnGyM8k1TNmqsRcafQAKDTVHSjAUfRRbH0kiD2K3tiiCBKVETk1dQ/B3bHre8Qk0T8Z9n60BoghZBCioisTJZPY9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724289686; c=relaxed/simple;
	bh=q2OusIvdEq6zRTANVy/UM3LZC1Q7yQnrfCWP7+HoHyE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QmAsI8k6ovBkWzC1NgYgbHdBc5N+AOOQUxEBw4/WzLwDjta3Slq9gsI0jgEtpwFLWZ8geajeLzJyKffpSY7MlvU3fVFYPiX9rcw9ELorn1q+w3wd6nc+bT+Pn1F8jbcNbmxKop5zXgfA1Z5HAZE5MnrfHcML4pz6bbLjqOtTHVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j34IVQ+H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9900C4AF1D;
	Thu, 22 Aug 2024 01:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724289685;
	bh=q2OusIvdEq6zRTANVy/UM3LZC1Q7yQnrfCWP7+HoHyE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=j34IVQ+H2dY3xLOT9P/ni5GeSKnHvl+Z09mfbufBDTCe9kg80dGQcrAXTD0aJJJU+
	 7DW8heBrXQC+zcsYEp3jhkBLwkLbsZON3ustFsM0sN2ajSlMeNRfUy88gNIl/AsRg4
	 n0aoo+Rbkd1Snq0hTNverUhz7J1IVIFlOI6UKiPsWmjCftfbqWaZBtjKji4622yKVA
	 s5zdOpEtgqSQMdEAVdcpOnFhpLRnYzEPSHVGn3PxXxhRTT8NB/O+0jYalPh3krEj5l
	 b7LIbNhfV/1ExqZTF0ZRcXrtN0NiHFezcL5bm8RvdAcBeUGWLi6bc3CarnwrWlttku
	 SJ34mJe3eHhhA==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 22 Aug 2024 02:15:29 +0100
Subject: [PATCH v11 26/39] arm64/ptrace: Expose GCS via ptrace and core
 files
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240822-arm64-gcs-v11-26-41b81947ecb5@kernel.org>
References: <20240822-arm64-gcs-v11-0-41b81947ecb5@kernel.org>
In-Reply-To: <20240822-arm64-gcs-v11-0-41b81947ecb5@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Andrew Morton <akpm@linux-foundation.org>, Marc Zyngier <maz@kernel.org>, 
 Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Arnd Bergmann <arnd@arndb.de>, 
 Oleg Nesterov <oleg@redhat.com>, Eric Biederman <ebiederm@xmission.com>, 
 Shuah Khan <shuah@kernel.org>, 
 "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>, 
 Deepak Gupta <debug@rivosinc.com>, Ard Biesheuvel <ardb@kernel.org>, 
 Szabolcs Nagy <Szabolcs.Nagy@arm.com>, Kees Cook <kees@kernel.org>
Cc: "H.J. Lu" <hjl.tools@gmail.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Florian Weimer <fweimer@redhat.com>, Christian Brauner <brauner@kernel.org>, 
 Thiago Jung Bauermann <thiago.bauermann@linaro.org>, 
 Ross Burton <ross.burton@arm.com>, 
 Yury Khrustalev <yury.khrustalev@arm.com>, 
 Wilco Dijkstra <wilco.dijkstra@arm.com>, 
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
 kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-mm@kvack.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=4141; i=broonie@kernel.org;
 h=from:subject:message-id; bh=q2OusIvdEq6zRTANVy/UM3LZC1Q7yQnrfCWP7+HoHyE=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmxpE46S4eNrbFfzLLKelY1sIaFKtVoFOEh9u0esmR
 mto9XBOJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZsaROAAKCRAk1otyXVSH0OIXB/
 0WLhGTnrr1acNEWUaHKTlFQ02Twd04uku5m9qigkISL/cOHuacfNhP/XjFCv1YD//lay6SHPXywYpd
 dJ+lnTfu/y7u6LYnbym71Jw+lPAK9SKgzzUeA+CzlglU2+IVQHhc+jUckTftFfbo0OdtwS5z6TGVH2
 Dfnl47K9G24gdVGKn4o30EZnc0mzWB1ZwU4ROeFpxjrouQ74/k/1VZZA6vZhLAE5uPswgY1FtaW2xf
 DmPEy+x7Ab7Iv+jY8Vlzk7JJ1qBdaVUiaSPjnwAcwjSpa4TBMcmX9PQoGDaYpSigZ3aROo08Ok7GHx
 uqollhgNezTV/BBR1BdogdCKV69oBr
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Provide a new register type NT_ARM_GCS reporting the current GCS mode
and pointer for EL0.  Due to the interactions with allocation and
deallocation of Guarded Control Stacks we do not permit any changes to
the GCS mode via ptrace, only GCSPR_EL0 may be changed.

Reviewed-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/uapi/asm/ptrace.h |  8 ++++++
 arch/arm64/kernel/ptrace.c           | 54 ++++++++++++++++++++++++++++++++++++
 include/uapi/linux/elf.h             |  1 +
 3 files changed, 63 insertions(+)

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
index 0d022599eb61..88f525b0c4fb 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -34,6 +34,7 @@
 #include <asm/cpufeature.h>
 #include <asm/debug-monitors.h>
 #include <asm/fpsimd.h>
+#include <asm/gcs.h>
 #include <asm/mte.h>
 #include <asm/pointer_auth.h>
 #include <asm/stacktrace.h>
@@ -1440,6 +1441,46 @@ static int tagged_addr_ctrl_set(struct task_struct *target, const struct
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
@@ -1469,6 +1510,9 @@ enum aarch64_regset {
 #ifdef CONFIG_ARM64_TAGGED_ADDR_ABI
 	REGSET_TAGGED_ADDR_CTRL,
 #endif
+#ifdef CONFIG_ARM64_GCS
+	REGSET_GCS,
+#endif
 };
 
 static const struct user_regset aarch64_regsets[] = {
@@ -1628,6 +1672,16 @@ static const struct user_regset aarch64_regsets[] = {
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
index b54b313bcf07..77d4910bbb9d 100644
--- a/include/uapi/linux/elf.h
+++ b/include/uapi/linux/elf.h
@@ -441,6 +441,7 @@ typedef struct elf64_shdr {
 #define NT_ARM_ZA	0x40c		/* ARM SME ZA registers */
 #define NT_ARM_ZT	0x40d		/* ARM SME ZT registers */
 #define NT_ARM_FPMR	0x40e		/* ARM floating point mode register */
+#define NT_ARM_GCS	0x40f		/* ARM GCS state */
 #define NT_ARC_V2	0x600		/* ARCv2 accumulator/extra registers */
 #define NT_VMCOREDD	0x700		/* Vmcore Device Dump Note */
 #define NT_MIPS_DSP	0x800		/* MIPS DSP ASE registers */

-- 
2.39.2


