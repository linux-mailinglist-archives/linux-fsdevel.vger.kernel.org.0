Return-Path: <linux-fsdevel+bounces-26624-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B326E95A9E9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 03:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AC402821A0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 01:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297B73B791;
	Thu, 22 Aug 2024 01:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QDNW72bm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7414019478;
	Thu, 22 Aug 2024 01:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724289672; cv=none; b=JJwcmnprTMAckoEnwaBjhepoRqwNCwI2SQIJJRg9PMUODnthEB4ITZyTZ/sav2W9j8jHCtj0KFPLhRet7fgzZE53Y5QJulNaYOQ118I1kpoejUt/tdrKVjzFs3c9ZfyItYMJrZP5nsgUGZ8BuiIg0cZ7Ao29TiTZbyPxDU1cQKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724289672; c=relaxed/simple;
	bh=phF/G+K5Vtk8Gd+IR1osStJosJZBYeJruux1Qa01Fos=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z+/2ZlK4kTgyM56UQ7Xferbmguu9IFl5RT841xR3JdeBbscQCjpK+HUXzAMRHOsCW9a0GCPf0N4h0aqwWJhAPomaGjw0UYfvQwUQ5xWOnWB9Z0n2Jlf9g+XYzwgCU47mCxrZ6Drwqc+hhLLs4MBFkadC8kNBQZtoDVB4vch29OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QDNW72bm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E398C32782;
	Thu, 22 Aug 2024 01:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724289672;
	bh=phF/G+K5Vtk8Gd+IR1osStJosJZBYeJruux1Qa01Fos=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QDNW72bmY4mujgd8+k0bnX9ktGpWMNyF4Orr9P6JbJn1XyX3U2VlIxCOn7hDARTm+
	 3162FZdVV5UYhbX+VCuCQfUU8Ko1HXF7dobpg8HTadjYVuIM3XGxxXfj547cnrcDWA
	 qtgXN1jpdEZJ0FKjMdCWAXMfAyVqqdlNaFYm1K02BEt9uIrQXm0oDlC25MyEcE1Fcf
	 8K5HdxDTmhSSj/+7x2qdEcalwpBeHCMj2rXda6iLvlwsfLOuh0lDQ2ljQFonmgBScR
	 i4pepbtW/0F4AV0nCQq9oHfyOpK0bgpamYUIR4S1wlI4RDw+qgfmhWyYrPYbInMsMS
	 kTBcWBCOXlY+g==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 22 Aug 2024 02:15:28 +0100
Subject: [PATCH v11 25/39] arm64/signal: Expose GCS state in signal frames
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240822-arm64-gcs-v11-25-41b81947ecb5@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8089; i=broonie@kernel.org;
 h=from:subject:message-id; bh=phF/G+K5Vtk8Gd+IR1osStJosJZBYeJruux1Qa01Fos=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmxpE3d+lQChE5Rgj8ZP8h2zuy8/9AX6Bh4tIAuWib
 +12oRP+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZsaRNwAKCRAk1otyXVSH0FM0B/
 9r1+2pJ7X0Tkq/tj07swP+zG22VSAV3NB52WehiVDYvTieQnMIKTXwIhbSjnTZI/ZEg8LLMRTh/id8
 3PwYkwXmVvZXl9IU/IAPsPxvbm3gaXIgfUzMoaebBIWEVSdLG+3DeEPcIwNSWBVEoc4HhP/5PjxytR
 4skCS2JCQEwh5PN/0zY/JyImr0VXI8UUTrCpacJ41dIrV5iR5b7UuVso0jY1n1LKTamOVcSREehbLb
 DjmNyenLNnwbxKKgRqszg+uDYCbqEGHkpglLpG4KXioO95ylFiXKpaZdslauqhu43RGsIadq6P4mKF
 xFLK0rYVX7Oz+2E7t7E9kJaE5wxKZy
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

Reviewed-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/uapi/asm/sigcontext.h |   9 +++
 arch/arm64/kernel/signal.c               | 133 ++++++++++++++++++++++++++++---
 2 files changed, 132 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/include/uapi/asm/sigcontext.h b/arch/arm64/include/uapi/asm/sigcontext.h
index 8a45b7a411e0..c2d61e8efc84 100644
--- a/arch/arm64/include/uapi/asm/sigcontext.h
+++ b/arch/arm64/include/uapi/asm/sigcontext.h
@@ -176,6 +176,15 @@ struct zt_context {
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
index b54d684c4bf8..3ad93f3c2227 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -66,6 +66,7 @@ struct rt_sigframe_user_layout {
 
 	unsigned long fpsimd_offset;
 	unsigned long esr_offset;
+	unsigned long gcs_offset;
 	unsigned long sve_offset;
 	unsigned long tpidr2_offset;
 	unsigned long za_offset;
@@ -195,6 +196,8 @@ struct user_ctxs {
 	u32 zt_size;
 	struct fpmr_context __user *fpmr;
 	u32 fpmr_size;
+	struct gcs_context __user *gcs;
+	u32 gcs_size;
 };
 
 static int preserve_fpsimd_context(struct fpsimd_context __user *ctx)
@@ -614,6 +617,81 @@ extern int restore_zt_context(struct user_ctxs *user);
 
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
+	gcspr = current->thread.gcspr_el0 - 8;
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
@@ -631,6 +709,7 @@ static int parse_user_sigframe(struct user_ctxs *user,
 	user->za = NULL;
 	user->zt = NULL;
 	user->fpmr = NULL;
+	user->gcs = NULL;
 
 	if (!IS_ALIGNED((unsigned long)base, 16))
 		goto invalid;
@@ -736,6 +815,17 @@ static int parse_user_sigframe(struct user_ctxs *user,
 			user->fpmr_size = size;
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
@@ -855,6 +945,9 @@ static int restore_sigframe(struct pt_regs *regs,
 			err = restore_fpsimd_context(&user);
 	}
 
+	if (err == 0 && system_supports_gcs() && user.gcs)
+		err = restore_gcs_context(&user);
+
 	if (err == 0 && system_supports_tpidr2() && user.tpidr2)
 		err = restore_tpidr2_context(&user);
 
@@ -873,7 +966,8 @@ static int restore_sigframe(struct pt_regs *regs,
 #ifdef CONFIG_ARM64_GCS
 static int gcs_restore_signal(void)
 {
-	u64 gcspr_el0, cap;
+	unsigned long __user *gcspr_el0;
+	u64 cap;
 	int ret;
 
 	if (!system_supports_gcs())
@@ -882,21 +976,29 @@ static int gcs_restore_signal(void)
 	if (!(current->thread.gcs_el0_mode & PR_SHADOW_STACK_ENABLE))
 		return 0;
 
-	gcspr_el0 = read_sysreg_s(SYS_GCSPR_EL0);
+	gcspr_el0 = (unsigned long __user *)read_sysreg_s(SYS_GCSPR_EL0);
 
 	/*
-	 * GCSPR_EL0 should be pointing at a capped GCS, read the cap...
+	 * Ensure that any changes to the GCS done via GCS operations
+	 * are visible to the normal reads we do to validate the
+	 * token.
 	 */
 	gcsb_dsync();
-	ret = copy_from_user(&cap, (__user void*)gcspr_el0, sizeof(cap));
+
+	/*
+	 * GCSPR_EL0 should be pointing at a capped GCS, read the cap.
+	 * We don't enforce that this is in a GCS page, if it is not
+	 * then faults will be generated on GCS operations - the main
+	 * concern is to protect GCS pages.
+	 */
+	ret = copy_from_user(&cap, gcspr_el0, sizeof(cap));
 	if (ret)
 		return -EFAULT;
 
 	/*
-	 * ...then check that the cap is the actual GCS before
-	 * restoring it.
+	 * Check that the cap is the actual GCS before replacing it.
 	 */
-	if (!gcs_signal_cap_valid(gcspr_el0, cap))
+	if (!gcs_signal_cap_valid((u64)gcspr_el0, cap))
 		return -EINVAL;
 
 	/* Invalidate the token to prevent reuse */
@@ -904,7 +1006,7 @@ static int gcs_restore_signal(void)
 	if (ret != 0)
 		return -EFAULT;
 
-	current->thread.gcspr_el0 = gcspr_el0 + sizeof(cap);
+	current->thread.gcspr_el0 = (u64)gcspr_el0 + sizeof(cap);
 	write_sysreg_s(current->thread.gcspr_el0, SYS_GCSPR_EL0);
 
 	return 0;
@@ -977,6 +1079,13 @@ static int setup_sigframe_layout(struct rt_sigframe_user_layout *user,
 			return err;
 	}
 
+	if (add_all || task_gcs_el0_enabled(current)) {
+		err = sigframe_alloc(user, &user->gcs_offset,
+				     sizeof(struct gcs_context));
+		if (err)
+			return err;
+	}
+
 	if (system_supports_sve() || system_supports_sme()) {
 		unsigned int vq = 0;
 
@@ -1077,6 +1186,12 @@ static int setup_sigframe(struct rt_sigframe_user_layout *user,
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
@@ -1214,8 +1329,6 @@ static int gcs_signal_entry(__sigrestore_t sigtramp, struct ksignal *ksig)
 	if (ret != 0)
 		return ret;
 
-	gcsb_dsync();
-
 	gcspr_el0 -= 2;
 	write_sysreg_s((unsigned long)gcspr_el0, SYS_GCSPR_EL0);
 

-- 
2.39.2


