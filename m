Return-Path: <linux-fsdevel+bounces-27688-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB819635EB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 01:37:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4222D1C21F2F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 23:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E821B1510;
	Wed, 28 Aug 2024 23:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mU25rA27"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E0B1B14F0;
	Wed, 28 Aug 2024 23:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724887896; cv=none; b=AU9J56xFi9RKTWbeFH1RSHlpgRm7q4pd+ufWaGZleO7bm9sDRuSsTzdzDKKzP3IN77XuGby1up85mPomXMD8YibfZiyiKdp+KVBzINLi0fn4GGCLf5EO6/lVC56toq2uxXsEngtUTVu92+akYC4YeZMFVwxWnsIGrXx1JdCldJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724887896; c=relaxed/simple;
	bh=73C3smpBK+UnDqakFPuhaJzLufKqaiexCIFYr/fa1x0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P1QepzMFdFAyKT/21os8QjKV/kx7AmdjC7D7jOLGp0xEf6DcFaQ1px/NbvOID4qwgPqQr+KN3KWonpFOxyYMe41Q6DRjQy9PdHJGJWyfVfhNR7bPawxAmxHOwTtKMOIHzPnaK3nlGYxRb6DSl89IuYBseSsFnqU3/z9Qav2bMcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mU25rA27; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFA72C4CEC6;
	Wed, 28 Aug 2024 23:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724887896;
	bh=73C3smpBK+UnDqakFPuhaJzLufKqaiexCIFYr/fa1x0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mU25rA27yjAUF5W16xtWcEV6nAyCAajNvImZSqLFWynmrWqAxF0lu2GrxyKbXz+Jb
	 VNNi7LOgmLnAB08yS3PLQ46AhOnNHx9dWmVGkAzj8adagkORLMrnhVjzFd5/yELW3x
	 uqhzDZw0JSPrx0OeziFzdT/PwmXxmLzsmLtVfX8Yian4Y8LfwY/cnUJS5fHTo85kPk
	 YlBLcqXZsGsPrSYVv7++Ll2cwTpXz5ZaUS2FIELm0BShIt7+TDSZuZ5ktWTxI8baRD
	 7+n/xwagW9tCHLj7hYz6naaxc0Lx7vHyrQve1MPX0JeNQQQs84m60x5k9nkg+/fb2x
	 5zie35lHjz+Zg==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 29 Aug 2024 00:27:41 +0100
Subject: [PATCH v12 25/39] arm64/signal: Expose GCS state in signal frames
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240829-arm64-gcs-v12-25-42fec947436a@kernel.org>
References: <20240829-arm64-gcs-v12-0-42fec947436a@kernel.org>
In-Reply-To: <20240829-arm64-gcs-v12-0-42fec947436a@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6128; i=broonie@kernel.org;
 h=from:subject:message-id; bh=73C3smpBK+UnDqakFPuhaJzLufKqaiexCIFYr/fa1x0=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmz7KMtztuBk31zqZisL+pxTd1y9CxV6vFGkXr1zkr
 QLSfPm2JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZs+yjAAKCRAk1otyXVSH0MPJB/
 9wLDGvs2zJBV6dYauqi3g2Kp0xDAFNgnGNlcMrp8JZIxION7DrvKdDFAwWyG/WNvmTtHTd97lTBOcp
 dzi0E5TyMfZKY6bogTnXfadhUgoehzIRtu9OTeRmGeiHf29qFns6JtmeIHPlezvOE8owkiPlmBDapD
 7tRHMok169p4iNbYVuVyMM/i2JSTIVm+Sb52QH6/0hDJW5DbGjXMTINncdkO1Q53IFDeI7x7o/X04K
 5jAsDnlNMzXf/cP0axq6Mlx4LcIYh5RKxoy9HERGlDD996QwoEVeQ9nZJ6ZIibVleUMSgLHfzNhgA4
 wm+Ma44vBnN+MCRXHAgtoEH/yMVG5H
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
 arch/arm64/kernel/signal.c               | 109 +++++++++++++++++++++++++++++++
 2 files changed, 118 insertions(+)

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
index 3f52ce11f791..dd2ed27b8bdd 100644
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
@@ -614,6 +617,82 @@ extern int restore_zt_context(struct user_ctxs *user);
 
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
@@ -631,6 +710,7 @@ static int parse_user_sigframe(struct user_ctxs *user,
 	user->za = NULL;
 	user->zt = NULL;
 	user->fpmr = NULL;
+	user->gcs = NULL;
 
 	if (!IS_ALIGNED((unsigned long)base, 16))
 		goto invalid;
@@ -736,6 +816,17 @@ static int parse_user_sigframe(struct user_ctxs *user,
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
@@ -855,6 +946,9 @@ static int restore_sigframe(struct pt_regs *regs,
 			err = restore_fpsimd_context(&user);
 	}
 
+	if (err == 0 && system_supports_gcs() && user.gcs)
+		err = restore_gcs_context(&user);
+
 	if (err == 0 && system_supports_tpidr2() && user.tpidr2)
 		err = restore_tpidr2_context(&user);
 
@@ -985,6 +1079,15 @@ static int setup_sigframe_layout(struct rt_sigframe_user_layout *user,
 			return err;
 	}
 
+#ifdef CONFIG_ARM64_GCS
+	if (add_all || current->thread.gcspr_el0) {
+		err = sigframe_alloc(user, &user->gcs_offset,
+				     sizeof(struct gcs_context));
+		if (err)
+			return err;
+	}
+#endif
+
 	if (system_supports_sve() || system_supports_sme()) {
 		unsigned int vq = 0;
 
@@ -1085,6 +1188,12 @@ static int setup_sigframe(struct rt_sigframe_user_layout *user,
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


