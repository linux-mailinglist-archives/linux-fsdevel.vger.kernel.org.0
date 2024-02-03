Return-Path: <linux-fsdevel+bounces-10170-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 208088485FA
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Feb 2024 13:39:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CFCE1F27F29
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Feb 2024 12:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD390768E9;
	Sat,  3 Feb 2024 12:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OVUxytKF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FEE74E38;
	Sat,  3 Feb 2024 12:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706963550; cv=none; b=V3mIp7NTr7n3rwc1+Y+sOmpxKXKXZtv+k7CNZIJDntb5J683bVznZ1H4I6TAFDOTlsLbD25rII3M976su2NYInj9ONoevIbsuRBoWIJYAwaDGj4cRp3/MOUG6wFgHo3gV+abJeGst8gf4gr/Zn/6rgGbX1+RMv/xh9r61yB3q3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706963550; c=relaxed/simple;
	bh=rveKNfu2hCQMG8B9aw4oT/fCpDlPhKgEsrOfPzfCWL8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Sc0bjR7cRk/xaT4SrYVP/QOALnqc7oHMWTEuiEQfu6hJcD+UjvKldt/84NuLebbzeXy+qFpBahvVCKw0/xI/Fo9Vvrz5zbVNGsctbtG1aWzOa5XcFAVYqF++W7CvoE8XVUA+Wj5hjHeoSBz0QNw+uZOUbpj+gOoKbnvEjBniutY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OVUxytKF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB039C43390;
	Sat,  3 Feb 2024 12:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706963550;
	bh=rveKNfu2hCQMG8B9aw4oT/fCpDlPhKgEsrOfPzfCWL8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OVUxytKF4cbOXupmS/ihwQNM4dZsOOLDAvJhjCLwCmxiFkSrviJf0QLWifWrWvSeT
	 5GiqDNlpoCOTk6sp83OU7yOuRv1Y/t3SvCvusmQF0aVQRN+eMFcZnfuQUacGRoMeI2
	 nO0nKPgYXapl9CDjYIEOgo+AiAp85cSaD6zEKpowjwuxybvVTiana2ffA4ljddX4gU
	 BNW87m/nl2j2MKUtvMH9Bf3mcXrm8pb6O4C5zyqQpBBPxYGd4vOTa3R7BAnbpBxw8K
	 szbAAq6S56depNeBR/NzyG3/Fi2LbmwcXYvc2iN3RSBjv74sdwKBVJKP2SfNb2Tr+3
	 aESzWRQDBWyAg==
From: Mark Brown <broonie@kernel.org>
Date: Sat, 03 Feb 2024 12:25:51 +0000
Subject: [PATCH v8 25/38] arm64/ptrace: Expose GCS via ptrace and core
 files
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240203-arm64-gcs-v8-25-c9fec77673ef@kernel.org>
References: <20240203-arm64-gcs-v8-0-c9fec77673ef@kernel.org>
In-Reply-To: <20240203-arm64-gcs-v8-0-c9fec77673ef@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Andrew Morton <akpm@linux-foundation.org>, Marc Zyngier <maz@kernel.org>, 
 Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Arnd Bergmann <arnd@arndb.de>, 
 Oleg Nesterov <oleg@redhat.com>, Eric Biederman <ebiederm@xmission.com>, 
 Kees Cook <keescook@chromium.org>, Shuah Khan <shuah@kernel.org>, 
 "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>, 
 Deepak Gupta <debug@rivosinc.com>, Ard Biesheuvel <ardb@kernel.org>, 
 Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Cc: "H.J. Lu" <hjl.tools@gmail.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Florian Weimer <fweimer@redhat.com>, Christian Brauner <brauner@kernel.org>, 
 Thiago Jung Bauermann <thiago.bauermann@linaro.org>, 
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
 kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-mm@kvack.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-a684c
X-Developer-Signature: v=1; a=openpgp-sha256; l=4258; i=broonie@kernel.org;
 h=from:subject:message-id; bh=rveKNfu2hCQMG8B9aw4oT/fCpDlPhKgEsrOfPzfCWL8=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlvjDk7EpAnHZap7zSw+wJSg+tMt+cn06om44qNnGU
 QjiFAzuJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZb4w5AAKCRAk1otyXVSH0IXFB/
 4uczWs8MrgliAEFN68CZRQmFNTKr9rUx0pm8uCNqx/GFBP3N5jkdlltYG89cHTkoVkm5wgk/AGBOpB
 FLdzgkPBIusbVPEXJopEoC3MfvgtdIPKXWxLBL7fPdFraYUmiPydFX0dg/kEr7Qemu7Xa/IzmTRZ0v
 gfGDW0QTRWh7kzjR2I9QekcE3p36FvPwTVvBahT6pTmSE4acpvVHyZTB2hCxg+wFSfUlGMQ711e6iG
 Sz4qoPGyIU/2/lE3fVvtkK1Q+OZB15GxxQQDKxiFpicj7Losb7hCbTByyl4TTb/G73iiuo+0srQ0KO
 73A8X+VrHNE4litPcQ+w4wWhPyGYWX
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

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
index dc6cf0e37194..c8dd489cfca8 100644
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
@@ -1411,6 +1412,51 @@ static int tagged_addr_ctrl_set(struct task_struct *target, const struct
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
+	    !(target->thread.gcs_el0_mode & PR_SHADOW_STACK_ENABLE))
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
@@ -1439,6 +1485,9 @@ enum aarch64_regset {
 #ifdef CONFIG_ARM64_TAGGED_ADDR_ABI
 	REGSET_TAGGED_ADDR_CTRL,
 #endif
+#ifdef CONFIG_ARM64_GCS
+	REGSET_GCS,
+#endif
 };
 
 static const struct user_regset aarch64_regsets[] = {
@@ -1589,6 +1638,16 @@ static const struct user_regset aarch64_regsets[] = {
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
index 9417309b7230..436dfc359f61 100644
--- a/include/uapi/linux/elf.h
+++ b/include/uapi/linux/elf.h
@@ -440,6 +440,7 @@ typedef struct elf64_shdr {
 #define NT_ARM_SSVE	0x40b		/* ARM Streaming SVE registers */
 #define NT_ARM_ZA	0x40c		/* ARM SME ZA registers */
 #define NT_ARM_ZT	0x40d		/* ARM SME ZT registers */
+#define NT_ARM_GCS	0x40e		/* ARM GCS state */
 #define NT_ARC_V2	0x600		/* ARCv2 accumulator/extra registers */
 #define NT_VMCOREDD	0x700		/* Vmcore Device Dump Note */
 #define NT_MIPS_DSP	0x800		/* MIPS DSP ASE registers */

-- 
2.30.2


