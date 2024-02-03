Return-Path: <linux-fsdevel+bounces-10169-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 887AB8485F5
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Feb 2024 13:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4051528259C
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Feb 2024 12:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C3174E01;
	Sat,  3 Feb 2024 12:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SpICFxO+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB8C5DF19;
	Sat,  3 Feb 2024 12:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706963544; cv=none; b=m3M1RN4cCpLyJq77fy0VfTQa2QexiWVPddbOsPF6BGmFHRKpNam2ZOD36eGBvE8b0bifyoP5AwVm5/+JB4+5OefwnsADw7k0Vk+K14l1Hf1/Ku+GcsZQ/uh/hYqjvounSYDjRg6P7A5G0OpL2v9l0lYtR3/nqmW3BTQH4Brwdhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706963544; c=relaxed/simple;
	bh=l7eNMpwW/Zrho/p1JMAQudrls7xr4SXcPsP5pQLneX4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q5CSFmfk+dLa8SP14vJoKL83pwNJ8X+tkk/uGmdzzaczYnYNruezCrwAftmH5KIjrHMecADhaSvZtzCmQa8sZYQc4Y6WRfItPT/TsYCGfcKC+pzYq63ALzXh7qqrQ5XME4XBJphSyvY4s/Z4I4RgBFP8CqOf2d4EKLhLiy2KC0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SpICFxO+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29685C433F1;
	Sat,  3 Feb 2024 12:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706963543;
	bh=l7eNMpwW/Zrho/p1JMAQudrls7xr4SXcPsP5pQLneX4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SpICFxO+jw19mzMfV6cfMNixQkq7VMvu1AkUejmRe86YQ0H1QNUy8v+j8JNd2tTog
	 Jyb1HUt2TnXkefBJRdGTuIuyNXjKyqzW2EtKrhyDBHm9Nqbt1a7/tBHPHGbr8kjpCY
	 7F98IjW72F3y5+HkKcTMzRhV8deyVVr2/tHR4Br+VJ0Qr3z61hbkS9thLp2OKi1Jkc
	 Mh/vneAbXIDRKtcTa8T0JsflVT+4tkjywTeYTvwE95+IjxhJ8D9hrOQxUsB4N/9ceC
	 idlg8LiudKW0E/5Kv1gnN/nZtZmt7nK53l66xuuPKHiwNsXpJcBW0CCVz1qLdSk/3A
	 gzrIpWoFBrSLQ==
From: Mark Brown <broonie@kernel.org>
Date: Sat, 03 Feb 2024 12:25:50 +0000
Subject: [PATCH v8 24/38] arm64/signal: Expose GCS state in signal frames
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240203-arm64-gcs-v8-24-c9fec77673ef@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6022; i=broonie@kernel.org;
 h=from:subject:message-id; bh=l7eNMpwW/Zrho/p1JMAQudrls7xr4SXcPsP5pQLneX4=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlvjDknrRNNIJOduAyD1EyJZboeRdf0F/nRG9a5SH5
 BPws6vCJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZb4w5AAKCRAk1otyXVSH0A6/B/
 9oXh58vXfiNiy88b0dMTBDLISUs38B0Uk3dMhOeVwEmjjKQt3sm27kbGcsLXvpOr+r+MJL9VWV0Sus
 N+Od2IoGJF0yPgAAVxWdNbao1BIT4fyRMJFB8ZbW2lcNTEBuS1nyDx2l3cmDf61+5TikKrPilnubIU
 LhOijbvx2cOhZnhT/PVcfCCY9Lx56KnRj99oXS8qOs2mJAIrKS4bBNHJnbEljhzpE8njZoOYv2XcXQ
 K4yI+zAozwOmELTo29JufFWqG3jNOxBGJhkCcSjyPmkCitRY/A2TdCd8WASkUYVtN9NBgIkp9ru0Yf
 k1eyar6n/pQxNv9n3aUd+RlzikIsTB
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Add a context for the GCS state and include it in the signal context when
running on a system that supports GCS. We reuse the same flags that the
prctl() uses to specify which GCS features are enabled and also provide the
current GCS pointer.

We do not support enabling GCS via signal return, there is a conflict
between specifying GCSPR_EL0 and allocation of a new GCS and this is not
an ancticipated use case.  We also enforce GCS configuration locking on
signal return.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/uapi/asm/sigcontext.h |   9 +++
 arch/arm64/kernel/signal.c               | 108 +++++++++++++++++++++++++++++++
 2 files changed, 117 insertions(+)

diff --git a/arch/arm64/include/uapi/asm/sigcontext.h b/arch/arm64/include/uapi/asm/sigcontext.h
index f23c1dc3f002..7b66d245f2d2 100644
--- a/arch/arm64/include/uapi/asm/sigcontext.h
+++ b/arch/arm64/include/uapi/asm/sigcontext.h
@@ -168,6 +168,15 @@ struct zt_context {
 	__u16 __reserved[3];
 };
 
+#define GCS_MAGIC	0x47435300
+
+struct gcs_context {
+	struct _aarch64_ctx head;
+	__u64 gcspr;
+	__u64 features_enabled;
+	__u64 reserved;
+};
+
 #endif /* !__ASSEMBLY__ */
 
 #include <asm/sve_context.h>
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 1cca646a7479..91bfb315bfd3 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -88,6 +88,7 @@ struct rt_sigframe_user_layout {
 
 	unsigned long fpsimd_offset;
 	unsigned long esr_offset;
+	unsigned long gcs_offset;
 	unsigned long sve_offset;
 	unsigned long tpidr2_offset;
 	unsigned long za_offset;
@@ -214,6 +215,8 @@ struct user_ctxs {
 	u32 za_size;
 	struct zt_context __user *zt;
 	u32 zt_size;
+	struct gcs_context __user *gcs;
+	u32 gcs_size;
 };
 
 static int preserve_fpsimd_context(struct fpsimd_context __user *ctx)
@@ -606,6 +609,83 @@ extern int restore_zt_context(struct user_ctxs *user);
 
 #endif /* ! CONFIG_ARM64_SME */
 
+#ifdef CONFIG_ARM64_GCS
+
+static int preserve_gcs_context(struct gcs_context __user *ctx)
+{
+	int err = 0;
+	u64 gcspr;
+
+	/*
+	 * We will add a cap token to the frame, include it in the
+	 * GCSPR_EL0 we report to support stack switching via
+	 * sigreturn.
+	 */
+	gcs_preserve_current_state();
+	gcspr = current->thread.gcspr_el0;
+	if (task_gcs_el0_enabled(current))
+		gcspr -= 8;
+
+	__put_user_error(GCS_MAGIC, &ctx->head.magic, err);
+	__put_user_error(sizeof(*ctx), &ctx->head.size, err);
+	__put_user_error(gcspr, &ctx->gcspr, err);
+	__put_user_error(0, &ctx->reserved, err);
+	__put_user_error(current->thread.gcs_el0_mode,
+			 &ctx->features_enabled, err);
+
+	return err;
+}
+
+static int restore_gcs_context(struct user_ctxs *user)
+{
+	u64 gcspr, enabled;
+	int err = 0;
+
+	if (user->gcs_size != sizeof(*user->gcs))
+		return -EINVAL;
+
+	__get_user_error(gcspr, &user->gcs->gcspr, err);
+	__get_user_error(enabled, &user->gcs->features_enabled, err);
+	if (err)
+		return err;
+
+	/* Don't allow unknown modes */
+	if (enabled & ~PR_SHADOW_STACK_SUPPORTED_STATUS_MASK)
+		return -EINVAL;
+
+	err = gcs_check_locked(current, enabled);
+	if (err != 0)
+		return err;
+
+	/* Don't allow enabling */
+	if (!task_gcs_el0_enabled(current) &&
+	    (enabled & PR_SHADOW_STACK_ENABLE))
+		return -EINVAL;
+
+	/* If we are disabling disable everything */
+	if (!(enabled & PR_SHADOW_STACK_ENABLE))
+		enabled = 0;
+
+	current->thread.gcs_el0_mode = enabled;
+
+	/*
+	 * We let userspace set GCSPR_EL0 to anything here, we will
+	 * validate later in gcs_restore_signal().
+	 */
+	current->thread.gcspr_el0 = gcspr;
+	write_sysreg_s(current->thread.gcspr_el0, SYS_GCSPR_EL0);
+
+	return 0;
+}
+
+#else /* ! CONFIG_ARM64_GCS */
+
+/* Turn any non-optimised out attempts to use these into a link error: */
+extern int preserve_gcs_context(void __user *ctx);
+extern int restore_gcs_context(struct user_ctxs *user);
+
+#endif /* ! CONFIG_ARM64_GCS */
+
 static int parse_user_sigframe(struct user_ctxs *user,
 			       struct rt_sigframe __user *sf)
 {
@@ -622,6 +702,7 @@ static int parse_user_sigframe(struct user_ctxs *user,
 	user->tpidr2 = NULL;
 	user->za = NULL;
 	user->zt = NULL;
+	user->gcs = NULL;
 
 	if (!IS_ALIGNED((unsigned long)base, 16))
 		goto invalid;
@@ -716,6 +797,17 @@ static int parse_user_sigframe(struct user_ctxs *user,
 			user->zt_size = size;
 			break;
 
+		case GCS_MAGIC:
+			if (!system_supports_gcs())
+				goto invalid;
+
+			if (user->gcs)
+				goto invalid;
+
+			user->gcs = (struct gcs_context __user *)head;
+			user->gcs_size = size;
+			break;
+
 		case EXTRA_MAGIC:
 			if (have_extra_context)
 				goto invalid;
@@ -835,6 +927,9 @@ static int restore_sigframe(struct pt_regs *regs,
 			err = restore_fpsimd_context(&user);
 	}
 
+	if (err == 0 && system_supports_gcs() && user.gcs)
+		err = restore_gcs_context(&user);
+
 	if (err == 0 && system_supports_tpidr2() && user.tpidr2)
 		err = restore_tpidr2_context(&user);
 
@@ -954,6 +1049,13 @@ static int setup_sigframe_layout(struct rt_sigframe_user_layout *user,
 			return err;
 	}
 
+	if (system_supports_gcs()) {
+		err = sigframe_alloc(user, &user->gcs_offset,
+				     sizeof(struct gcs_context));
+		if (err)
+			return err;
+	}
+
 	if (system_supports_sve() || system_supports_sme()) {
 		unsigned int vq = 0;
 
@@ -1047,6 +1149,12 @@ static int setup_sigframe(struct rt_sigframe_user_layout *user,
 		__put_user_error(current->thread.fault_code, &esr_ctx->esr, err);
 	}
 
+	if (system_supports_gcs() && err == 0 && user->gcs_offset) {
+		struct gcs_context __user *gcs_ctx =
+			apply_user_offset(user, user->gcs_offset);
+		err |= preserve_gcs_context(gcs_ctx);
+	}
+
 	/* Scalable Vector Extension state (including streaming), if present */
 	if ((system_supports_sve() || system_supports_sme()) &&
 	    err == 0 && user->sve_offset) {

-- 
2.30.2


