Return-Path: <linux-fsdevel+bounces-30599-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E7598C90B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 01:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE2F81F252EB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 23:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3321CF5E3;
	Tue,  1 Oct 2024 23:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BwIW27cY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCDF1CF29F;
	Tue,  1 Oct 2024 23:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727823889; cv=none; b=Wapw3E83HgKsbL2q2J8jrdvUrJSihmmjT/8TC4l18oHJ42tAK28f9NcR72qaJ1bThPFrL5DmcgRlaQPu5aqQYkz4I+qoFsyPqSGH/6t88HtGQYC66vLDZQb6yt0/YyuEHrTGg8t0ntlH4VQAEn+re075Yub7biRpJKrLv/GJH9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727823889; c=relaxed/simple;
	bh=iheYVdOI1mRov1x2wnyFTq0nLuVXvcgzNFY1vvTX4L4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YfhpK0ahtwtyOgUY8RoK5Qh/SNdWfWgq3EQo8V20IRe9I0ACnJwZUPSHDKN9lB2ctWbykpbRCNrY8uE/pZVkV6uUYCNszGrRAeDDsubufyx/JO8MERPa1hIkA+wt4fE9UMBaKIwIIbICtg1Y2bu/tifZOmV+WU/k9GOE1xLKrX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BwIW27cY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8BA5C4CEC6;
	Tue,  1 Oct 2024 23:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727823889;
	bh=iheYVdOI1mRov1x2wnyFTq0nLuVXvcgzNFY1vvTX4L4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BwIW27cYksAnySxigWOYt0SrEnqSg8DQYIaOnWhOA0RmnhGPkZNsPdLvpGjXLHoFy
	 x9mBOmkAgbznrCwLJIwQXwgbSpQgLgda83m7E8XTGR/hpwmO9+3OPAi1uU0TCEeGyM
	 9JiEyK/6y5TPZbGoIs2Q4X1QSD6nD+29VI2lTNHh20WKw6hGcZlOF91t4tyvyGGUud
	 Er3KBwhnr6s/S5WpZBGIZsV6T9/+OZ8Q9UeC9TufeeP6UnCEheXFhvzHTC1pWfDdE7
	 blzYCs94us/bd2Nqjy+3llEwkSsm9Kk0bQaxm2WUjd4zYSbW2gZTb+pX3qgl8J3TvX
	 ZINL9rlEvPKdg==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 01 Oct 2024 23:59:05 +0100
Subject: [PATCH v13 26/40] arm64/signal: Expose GCS state in signal frames
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241001-arm64-gcs-v13-26-222b78d87eee@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6331; i=broonie@kernel.org;
 h=from:subject:message-id; bh=iheYVdOI1mRov1x2wnyFTq0nLuVXvcgzNFY1vvTX4L4=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBm/H7Yz8d8MeWJ1s7RbiNfQuHzARatODnl4idncq8R
 cuNHIXOJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZvx+2AAKCRAk1otyXVSH0IwMB/
 9jNDjhhihZZ4eg1B5HLLhXzEXv8N0aVlgGh/C0HpKuP1JRpb9vWvmXYmEb9b+OED6jwkbAaDTq34DO
 tIgwn8Hxp1xHgkhwqJPTA/ZlaSRZsLMpjQGYO50gNphK4ZTqB8UsmomfvnmqpiHRG2Tvn9yfF6ctdn
 6jCSM3nAAnS9z/iZyVIRdD+DJ6uqNygJh5d+zzcrtYXSjxfHHUH6WFm4VP9CsuiY/zjMTz3cQCR+GD
 Dkyz+qG+3r8mAsYatUuQH1MZvCZPtuexKj1rWX0DbluY1QzNURLAZ+Wzhk6r8UfrQ2C7Dpaj+1j8fk
 vzEPmC/B62LJ0D69GBKu8xUJsBBlQj
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

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
Acked-by: Yury Khrustalev <yury.khrustalev@arm.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/uapi/asm/sigcontext.h |   9 +++
 arch/arm64/kernel/signal.c               | 109 +++++++++++++++++++++++++++++++
 2 files changed, 118 insertions(+)

diff --git a/arch/arm64/include/uapi/asm/sigcontext.h b/arch/arm64/include/uapi/asm/sigcontext.h
index bb7af77a30a7..d42f7a92238b 100644
--- a/arch/arm64/include/uapi/asm/sigcontext.h
+++ b/arch/arm64/include/uapi/asm/sigcontext.h
@@ -183,6 +183,15 @@ struct zt_context {
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
index b5ab0e229a78..62d666278264 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -66,6 +66,7 @@ struct rt_sigframe_user_layout {
 
 	unsigned long fpsimd_offset;
 	unsigned long esr_offset;
+	unsigned long gcs_offset;
 	unsigned long sve_offset;
 	unsigned long tpidr2_offset;
 	unsigned long za_offset;
@@ -198,6 +199,8 @@ struct user_ctxs {
 	u32 fpmr_size;
 	struct poe_context __user *poe;
 	u32 poe_size;
+	struct gcs_context __user *gcs;
+	u32 gcs_size;
 };
 
 static int preserve_fpsimd_context(struct fpsimd_context __user *ctx)
@@ -643,6 +646,82 @@ extern int restore_zt_context(struct user_ctxs *user);
 
 #endif /* ! CONFIG_ARM64_SME */
 
+#ifdef CONFIG_ARM64_GCS
+
+static int preserve_gcs_context(struct gcs_context __user *ctx)
+{
+	int err = 0;
+	u64 gcspr = read_sysreg_s(SYS_GCSPR_EL0);
+
+	/*
+	 * If GCS is enabled we will add a cap token to the frame,
+	 * include it in the GCSPR_EL0 we report to support stack
+	 * switching via sigreturn if GCS is enabled.  We do not allow
+	 * enabling via sigreturn so the token is only relevant for
+	 * threads with GCS enabled.
+	 */
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
+	write_sysreg_s(gcspr, SYS_GCSPR_EL0);
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
@@ -661,6 +740,7 @@ static int parse_user_sigframe(struct user_ctxs *user,
 	user->zt = NULL;
 	user->fpmr = NULL;
 	user->poe = NULL;
+	user->gcs = NULL;
 
 	if (!IS_ALIGNED((unsigned long)base, 16))
 		goto invalid;
@@ -777,6 +857,17 @@ static int parse_user_sigframe(struct user_ctxs *user,
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
@@ -896,6 +987,9 @@ static int restore_sigframe(struct pt_regs *regs,
 			err = restore_fpsimd_context(&user);
 	}
 
+	if (err == 0 && system_supports_gcs() && user.gcs)
+		err = restore_gcs_context(&user);
+
 	if (err == 0 && system_supports_tpidr2() && user.tpidr2)
 		err = restore_tpidr2_context(&user);
 
@@ -1029,6 +1123,15 @@ static int setup_sigframe_layout(struct rt_sigframe_user_layout *user,
 			return err;
 	}
 
+#ifdef CONFIG_ARM64_GCS
+	if (system_supports_gcs() && (add_all || current->thread.gcspr_el0)) {
+		err = sigframe_alloc(user, &user->gcs_offset,
+				     sizeof(struct gcs_context));
+		if (err)
+			return err;
+	}
+#endif
+
 	if (system_supports_sve() || system_supports_sme()) {
 		unsigned int vq = 0;
 
@@ -1136,6 +1239,12 @@ static int setup_sigframe(struct rt_sigframe_user_layout *user,
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
2.39.2


