Return-Path: <linux-fsdevel+bounces-1403-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0029C7D9F8B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 20:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC5CF1C21109
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 18:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 300BB3D3AE;
	Fri, 27 Oct 2023 18:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE033CD04
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 18:09:42 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 264F5AC;
	Fri, 27 Oct 2023 11:09:41 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 795911424;
	Fri, 27 Oct 2023 11:10:22 -0700 (PDT)
Received: from e124191.cambridge.arm.com (e124191.cambridge.arm.com [10.1.197.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ABCE63F64C;
	Fri, 27 Oct 2023 11:09:38 -0700 (PDT)
From: Joey Gouly <joey.gouly@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: akpm@linux-foundation.org,
	aneesh.kumar@linux.ibm.com,
	broonie@kernel.org,
	catalin.marinas@arm.com,
	dave.hansen@linux.intel.com,
	joey.gouly@arm.com,
	maz@kernel.org,
	oliver.upton@linux.dev,
	shuah@kernel.org,
	will@kernel.org,
	kvmarm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH v2 15/24] arm64: add POE signal support
Date: Fri, 27 Oct 2023 19:08:41 +0100
Message-Id: <20231027180850.1068089-16-joey.gouly@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231027180850.1068089-1-joey.gouly@arm.com>
References: <20231027180850.1068089-1-joey.gouly@arm.com>
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
---
 arch/arm64/include/uapi/asm/sigcontext.h |  7 ++++
 arch/arm64/kernel/signal.c               | 51 ++++++++++++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/arch/arm64/include/uapi/asm/sigcontext.h b/arch/arm64/include/uapi/asm/sigcontext.h
index f23c1dc3f002..cef85eeaf541 100644
--- a/arch/arm64/include/uapi/asm/sigcontext.h
+++ b/arch/arm64/include/uapi/asm/sigcontext.h
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
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 0e8beb3349ea..379f364005bf 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -62,6 +62,7 @@ struct rt_sigframe_user_layout {
 	unsigned long zt_offset;
 	unsigned long extra_offset;
 	unsigned long end_offset;
+	unsigned long poe_offset;
 };
 
 #define BASE_SIGFRAME_SIZE round_up(sizeof(struct rt_sigframe), 16)
@@ -182,6 +183,8 @@ struct user_ctxs {
 	u32 za_size;
 	struct zt_context __user *zt;
 	u32 zt_size;
+	struct poe_context __user *poe;
+	u32 poe_size;
 };
 
 static int preserve_fpsimd_context(struct fpsimd_context __user *ctx)
@@ -227,6 +230,20 @@ static int restore_fpsimd_context(struct user_ctxs *user)
 	return err ? -EFAULT : 0;
 }
 
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
 
 #ifdef CONFIG_ARM64_SVE
 
@@ -590,6 +607,7 @@ static int parse_user_sigframe(struct user_ctxs *user,
 	user->tpidr2 = NULL;
 	user->za = NULL;
 	user->zt = NULL;
+	user->poe = NULL;
 
 	if (!IS_ALIGNED((unsigned long)base, 16))
 		goto invalid;
@@ -640,6 +658,17 @@ static int parse_user_sigframe(struct user_ctxs *user,
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
@@ -812,6 +841,9 @@ static int restore_sigframe(struct pt_regs *regs,
 	if (err == 0 && system_supports_sme2() && user.zt)
 		err = restore_zt_context(&user);
 
+	if (err == 0 && system_supports_poe() && user.poe)
+		err = restore_poe_context(&user);
+
 	return err;
 }
 
@@ -928,6 +960,13 @@ static int setup_sigframe_layout(struct rt_sigframe_user_layout *user,
 		}
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
 
@@ -968,6 +1007,15 @@ static int setup_sigframe(struct rt_sigframe_user_layout *user,
 		__put_user_error(current->thread.fault_code, &esr_ctx->esr, err);
 	}
 
+	if (system_supports_poe() && err == 0 && user->poe_offset) {
+		struct poe_context __user *poe_ctx =
+			apply_user_offset(user, user->poe_offset);
+
+		__put_user_error(POE_MAGIC, &poe_ctx->head.magic, err);
+		__put_user_error(sizeof(*poe_ctx), &poe_ctx->head.size, err);
+		__put_user_error(read_sysreg_s(SYS_POR_EL0), &poe_ctx->por_el0, err);
+	}
+
 	/* Scalable Vector Extension state (including streaming), if present */
 	if ((system_supports_sve() || system_supports_sme()) &&
 	    err == 0 && user->sve_offset) {
@@ -1119,6 +1167,9 @@ static void setup_return(struct pt_regs *regs, struct k_sigaction *ka,
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


