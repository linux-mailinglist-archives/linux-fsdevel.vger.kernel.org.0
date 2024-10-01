Return-Path: <linux-fsdevel+bounces-30600-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F6F98C910
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 01:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B1081C24129
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 23:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CCF21D0E16;
	Tue,  1 Oct 2024 23:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eRy/kctW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9811CF29F;
	Tue,  1 Oct 2024 23:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727823899; cv=none; b=o9vp4zZARC6445Ttigj0ex8gTFqbrruQpbj6cGNWbFJLpqQlTjqhNhISX4CN4O4gkG4h0apLltPQJzTLnX1ifDJkN8krKqnBv+XAQWFPmkLogjDP2Ln36WemoqY4P8rZbaZpDzRBK8Emfwsnn3AK2nK0N9c4JF4kVc33mqFuhV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727823899; c=relaxed/simple;
	bh=VAiC7wTRzpadh8RpHSWvVn3DPR/rNVWThbxqMFfnHEk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f2/co7qHYQmXwGKO+EVKL9UX19xQfWX9AaEU2KfN9ybQdmys45iJBfpYU6TSQLo9ctyCiPXajkezWZpTVUt8lfCxwyb2cSuYPf+HFMTN/UZgwPEzALG+0u000CQ6Y3wInpBP/xLzqIE36pvCU9CgwEbXXcJwDibAdZczb+LbMxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eRy/kctW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CFCFC4CECF;
	Tue,  1 Oct 2024 23:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727823899;
	bh=VAiC7wTRzpadh8RpHSWvVn3DPR/rNVWThbxqMFfnHEk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=eRy/kctW3nA/qJ93+WM+vITRctux1o0SD6GPKbIu8jj/YMt7AnIk6QFRLezzYyzuH
	 SlcLCbUhqAUI1u30Po/NuBch0G0v0ql50IwITt34H7cQ62gIpWVQUIeHJ9tcQRMzTc
	 uViUbs/Xvke/fjWiDksO4Qh2GN0gSj+Nk9UlnnP4YOWk25QjeTK3gKZLM8phKEA2k+
	 mjTPj4LrQGG7RmJEjAG85LAf7kBnQhfndAYVI+ip3Dyl1vcnUH0miYKXcExeKBvbav
	 xfZGoiL38AAi6+Dr8MCWdJs/DMGV6gztdc8XmLv6yc/PWIpR7eLYMiUpADAIS6yUCs
	 VOJL4q92nUy0w==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 01 Oct 2024 23:59:06 +0100
Subject: [PATCH v13 27/40] arm64/ptrace: Expose GCS via ptrace and core
 files
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241001-arm64-gcs-v13-27-222b78d87eee@kernel.org>
References: <20241001-arm64-gcs-v13-0-222b78d87eee@kernel.org>
In-Reply-To: <20241001-arm64-gcs-v13-0-222b78d87eee@kernel.org>
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
 Ross Burton <ross.burton@arm.com>, David Spickett <david.spickett@arm.com>, 
 Yury Khrustalev <yury.khrustalev@arm.com>, 
 Wilco Dijkstra <wilco.dijkstra@arm.com>, 
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
 kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-mm@kvack.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=openpgp-sha256; l=4262; i=broonie@kernel.org;
 h=from:subject:message-id; bh=VAiC7wTRzpadh8RpHSWvVn3DPR/rNVWThbxqMFfnHEk=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBm/H7Z5vNb2IgxdeOBRBnWacqJsMskdit5gkN95CIq
 Z4SFLa+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZvx+2QAKCRAk1otyXVSH0AD7B/
 90YcXso4DMluSzh5SnDnEMoZx98sERhuAysFMI+D8NQYKJCTCgbRD1UHKlev8+31TQjTM7cBYNPtTM
 M2nPE8s6UfeDzMcl0vw5RpKx5LCOmfb6By9Z0S/OOOBBDnhycSmaVuCWWHk1e6dDiF2fEeSs6Sn5vc
 BDdtHJpnVBlaBt5KecWXAU7R9Hda2+JhFtcTnYEu3PlCLUn8MK2iObaoVpv5VGApENQlXul5wDDgcA
 YjtMn40OZdA7GAQR5zJCgInDRJyMmkYBeRAvEBnSfi/l1QhqGRthlk7gspycrolcOCHSr0crpN7IZJ
 mVRvPfsG6jKAiyRP+nTBBXtTDR35tE
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Provide a new register type NT_ARM_GCS reporting the current GCS mode
and pointer for EL0.  Due to the interactions with allocation and
deallocation of Guarded Control Stacks we do not permit any changes to
the GCS mode via ptrace, only GCSPR_EL0 may be changed.

Reviewed-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/uapi/asm/ptrace.h |  8 +++++
 arch/arm64/kernel/ptrace.c           | 62 +++++++++++++++++++++++++++++++++++-
 include/uapi/linux/elf.h             |  1 +
 3 files changed, 70 insertions(+), 1 deletion(-)

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
index b756578aeaee..6c1dcfe6d25a 100644
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
@@ -1473,6 +1474,52 @@ static int poe_set(struct task_struct *target, const struct
 }
 #endif
 
+#ifdef CONFIG_ARM64_GCS
+static int gcs_get(struct task_struct *target,
+		   const struct user_regset *regset,
+		   struct membuf to)
+{
+	struct user_gcs user_gcs;
+
+	if (!system_supports_gcs())
+		return -EINVAL;
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
+	if (!system_supports_gcs())
+		return -EINVAL;
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
@@ -1503,7 +1550,10 @@ enum aarch64_regset {
 	REGSET_TAGGED_ADDR_CTRL,
 #endif
 #ifdef CONFIG_ARM64_POE
-	REGSET_POE
+	REGSET_POE,
+#endif
+#ifdef CONFIG_ARM64_GCS
+	REGSET_GCS,
 #endif
 };
 
@@ -1674,6 +1724,16 @@ static const struct user_regset aarch64_regsets[] = {
 		.set = poe_set,
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
index b9935988da5c..9adc218fb6df 100644
--- a/include/uapi/linux/elf.h
+++ b/include/uapi/linux/elf.h
@@ -443,6 +443,7 @@ typedef struct elf64_shdr {
 #define NT_ARM_ZT	0x40d		/* ARM SME ZT registers */
 #define NT_ARM_FPMR	0x40e		/* ARM floating point mode register */
 #define NT_ARM_POE	0x40f		/* ARM POE registers */
+#define NT_ARM_GCS	0x410		/* ARM GCS state */
 #define NT_ARC_V2	0x600		/* ARCv2 accumulator/extra registers */
 #define NT_VMCOREDD	0x700		/* Vmcore Device Dump Note */
 #define NT_MIPS_DSP	0x800		/* MIPS DSP ASE registers */

-- 
2.39.2


