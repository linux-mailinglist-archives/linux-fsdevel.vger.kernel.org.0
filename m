Return-Path: <linux-fsdevel+bounces-26769-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC8D695B9E2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 17:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3EE1B24739
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 15:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A3D1CCEF0;
	Thu, 22 Aug 2024 15:12:48 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B7C1CC896;
	Thu, 22 Aug 2024 15:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724339568; cv=none; b=WqiKkZcvsi4+9qiUEbadqKmG073KQxMX2RhCASyTK24Chbj8Yf6pXNo5etU0AgpxCNDTTe0rwPhPmBs2r6aZ0kQs4rbvjLM5ZYz1rB6qi6BSUoLuICaEqrm4wmWyKFbEFhWclpyz7wEN9Sk+iuh3cvhYXzRnCgfk0BMf6PdI7P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724339568; c=relaxed/simple;
	bh=B1VXJZD73SHXYia5M/NnW9dBkFLJJQ7Npcl20ltKTxA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Supbo+gNw1jvRdxte7z3C5xN2ySWOLcrkESOXGgv1YMI1RTzaBrWaFJHdDFvad//algrkqrAtKdxQzvFCMyl+oLHahfRQccRWSfH2KPqrZ/AJqLnXXJijMRe0VVLe8zWHRHI7O2xL1q8f2VRh8F3Lb9sWKUHYuxwGMx2DhO1ko4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 915F41576;
	Thu, 22 Aug 2024 08:13:12 -0700 (PDT)
Received: from e124191.cambridge.arm.com (e124191.cambridge.arm.com [10.1.197.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 722AE3F58B;
	Thu, 22 Aug 2024 08:12:42 -0700 (PDT)
From: Joey Gouly <joey.gouly@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: nd@arm.com,
	akpm@linux-foundation.org,
	aneesh.kumar@kernel.org,
	aneesh.kumar@linux.ibm.com,
	anshuman.khandual@arm.com,
	bp@alien8.de,
	broonie@kernel.org,
	catalin.marinas@arm.com,
	christophe.leroy@csgroup.eu,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	joey.gouly@arm.com,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	maz@kernel.org,
	mingo@redhat.com,
	mpe@ellerman.id.au,
	naveen.n.rao@linux.ibm.com,
	npiggin@gmail.com,
	oliver.upton@linux.dev,
	shuah@kernel.org,
	skhan@linuxfoundation.org,
	szabolcs.nagy@arm.com,
	tglx@linutronix.de,
	will@kernel.org,
	x86@kernel.org,
	kvmarm@lists.linux.dev,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v5 19/30] arm64: add POE signal support
Date: Thu, 22 Aug 2024 16:11:02 +0100
Message-Id: <20240822151113.1479789-20-joey.gouly@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240822151113.1479789-1-joey.gouly@arm.com>
References: <20240822151113.1479789-1-joey.gouly@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add PKEY support to signals, by saving and restoring POR_EL0 from the stackframe.

Signed-off-by: Joey Gouly <joey.gouly@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Reviewed-by: Mark Brown <broonie@kernel.org>
Acked-by: Szabolcs Nagy <szabolcs.nagy@arm.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/include/uapi/asm/sigcontext.h |  7 +++
 arch/arm64/kernel/signal.c               | 62 ++++++++++++++++++++++++
 2 files changed, 69 insertions(+)

diff --git arch/arm64/include/uapi/asm/sigcontext.h arch/arm64/include/uapi/asm/sigcontext.h
index 8a45b7a411e0..e4cba8a6c9a2 100644
--- arch/arm64/include/uapi/asm/sigcontext.h
+++ arch/arm64/include/uapi/asm/sigcontext.h
@@ -98,6 +98,13 @@ struct esr_context {
 	__u64 esr;
 };
 
+#define POE_MAGIC	0x504f4530
+
+struct poe_context {
+	struct _aarch64_ctx head;
+	__u64 por_el0;
+};
+
 /*
  * extra_context: describes extra space in the signal frame for
  * additional structures that don't fit in sigcontext.__reserved[].
diff --git arch/arm64/kernel/signal.c arch/arm64/kernel/signal.c
index 4a77f4976e11..561986947530 100644
--- arch/arm64/kernel/signal.c
+++ arch/arm64/kernel/signal.c
@@ -61,6 +61,7 @@ struct rt_sigframe_user_layout {
 	unsigned long za_offset;
 	unsigned long zt_offset;
 	unsigned long fpmr_offset;
+	unsigned long poe_offset;
 	unsigned long extra_offset;
 	unsigned long end_offset;
 };
@@ -185,6 +186,8 @@ struct user_ctxs {
 	u32 zt_size;
 	struct fpmr_context __user *fpmr;
 	u32 fpmr_size;
+	struct poe_context __user *poe;
+	u32 poe_size;
 };
 
 static int preserve_fpsimd_context(struct fpsimd_context __user *ctx)
@@ -258,6 +261,32 @@ static int restore_fpmr_context(struct user_ctxs *user)
 	return err;
 }
 
+static int preserve_poe_context(struct poe_context __user *ctx)
+{
+	int err = 0;
+
+	__put_user_error(POE_MAGIC, &ctx->head.magic, err);
+	__put_user_error(sizeof(*ctx), &ctx->head.size, err);
+	__put_user_error(read_sysreg_s(SYS_POR_EL0), &ctx->por_el0, err);
+
+	return err;
+}
+
+static int restore_poe_context(struct user_ctxs *user)
+{
+	u64 por_el0;
+	int err = 0;
+
+	if (user->poe_size != sizeof(*user->poe))
+		return -EINVAL;
+
+	__get_user_error(por_el0, &(user->poe->por_el0), err);
+	if (!err)
+		write_sysreg_s(por_el0, SYS_POR_EL0);
+
+	return err;
+}
+
 #ifdef CONFIG_ARM64_SVE
 
 static int preserve_sve_context(struct sve_context __user *ctx)
@@ -621,6 +650,7 @@ static int parse_user_sigframe(struct user_ctxs *user,
 	user->za = NULL;
 	user->zt = NULL;
 	user->fpmr = NULL;
+	user->poe = NULL;
 
 	if (!IS_ALIGNED((unsigned long)base, 16))
 		goto invalid;
@@ -671,6 +701,17 @@ static int parse_user_sigframe(struct user_ctxs *user,
 			/* ignore */
 			break;
 
+		case POE_MAGIC:
+			if (!system_supports_poe())
+				goto invalid;
+
+			if (user->poe)
+				goto invalid;
+
+			user->poe = (struct poe_context __user *)head;
+			user->poe_size = size;
+			break;
+
 		case SVE_MAGIC:
 			if (!system_supports_sve() && !system_supports_sme())
 				goto invalid;
@@ -857,6 +898,9 @@ static int restore_sigframe(struct pt_regs *regs,
 	if (err == 0 && system_supports_sme2() && user.zt)
 		err = restore_zt_context(&user);
 
+	if (err == 0 && system_supports_poe() && user.poe)
+		err = restore_poe_context(&user);
+
 	return err;
 }
 
@@ -980,6 +1024,13 @@ static int setup_sigframe_layout(struct rt_sigframe_user_layout *user,
 			return err;
 	}
 
+	if (system_supports_poe()) {
+		err = sigframe_alloc(user, &user->poe_offset,
+				     sizeof(struct poe_context));
+		if (err)
+			return err;
+	}
+
 	return sigframe_alloc_end(user);
 }
 
@@ -1042,6 +1093,14 @@ static int setup_sigframe(struct rt_sigframe_user_layout *user,
 		err |= preserve_fpmr_context(fpmr_ctx);
 	}
 
+	if (system_supports_poe() && err == 0 && user->poe_offset) {
+		struct poe_context __user *poe_ctx =
+			apply_user_offset(user, user->poe_offset);
+
+		err |= preserve_poe_context(poe_ctx);
+	}
+
+
 	/* ZA state if present */
 	if (system_supports_sme() && err == 0 && user->za_offset) {
 		struct za_context __user *za_ctx =
@@ -1178,6 +1237,9 @@ static void setup_return(struct pt_regs *regs, struct k_sigaction *ka,
 		sme_smstop();
 	}
 
+	if (system_supports_poe())
+		write_sysreg_s(POR_EL0_INIT, SYS_POR_EL0);
+
 	if (ka->sa.sa_flags & SA_RESTORER)
 		sigtramp = ka->sa.sa_restorer;
 	else
-- 
2.25.1


