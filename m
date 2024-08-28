Return-Path: <linux-fsdevel+bounces-27666-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF2B9963579
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 01:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7675D285C9E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 23:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D9321B010A;
	Wed, 28 Aug 2024 23:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CyUah56F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64F91AE025;
	Wed, 28 Aug 2024 23:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724887734; cv=none; b=M2xV9kIEjjiOlMkEyZreBOo07FfaYiPEOMGX9+3BAc3tpP62GuXYI7mBTxu4AfcWa2lewD+/kSbq3nwXauUsnT8PqVhI49+YdjhkhMcwHg6w4+zMRucc6a5jC9n9M+qFUe71NJVNEF9KNmbNi2HFUAwz8xvfNJj9nO+3etOoIOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724887734; c=relaxed/simple;
	bh=RTcnwKCnbai8FTs65e4TvcOIdbpBUk2hXTCc6OzveBw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oQ9bnGtnka1fhT5OMpdIFgAw9r+cjRQJvhLeAMjlzhB0Dq/ord/V1WiMM8SoUUKkwaQJVXj2Juuw8FkbuKNb4sCcO4cxD1sjFcb+8Zjw8QuotmNCVp/CG2+N0mkIERWU1B7oXsdrAfksxvNt1q/YlH0sKEVaDW/JKlF5vT0MW3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CyUah56F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AE6FC4CEC7;
	Wed, 28 Aug 2024 23:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724887733;
	bh=RTcnwKCnbai8FTs65e4TvcOIdbpBUk2hXTCc6OzveBw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CyUah56F/ucjbAcFwoG9D6pKWXQ+1tmJEEDcJN+9ryqPoOgJTPSLtYBid3RB5nVhA
	 YgRXyYYGH4YY5HdCar6JjmO9SGQzp4qvWwOdniQ4qlLpE5v0TOpQ9pwEBAUb+Tt4W+
	 NQb74WNVQ/WH0mXhUZTsi4ejE7R3HgCFXk55WwGPXzN8QQeeamJwNC++kVLz+hlD0T
	 2SDIKVh1wTgL4kdUPjkJyUOIyzpbkY5DQQtPLRxKLevTbdRgPY5iemORfnAiXdMHpX
	 MsWpmJr+RFu34tC4Mlu6XyEez3UKn42y53mWLw3MXV3rXjGfRkXEIkrqPO2o1Q1raS
	 S0RC4G3IKnGUA==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 29 Aug 2024 00:27:19 +0100
Subject: [PATCH v12 03/39] prctl: arch-agnostic prctl for shadow stack
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240829-arm64-gcs-v12-3-42fec947436a@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4949; i=broonie@kernel.org;
 h=from:subject:message-id; bh=RTcnwKCnbai8FTs65e4TvcOIdbpBUk2hXTCc6OzveBw=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmz7J60KI1NAx9s5uebbxOtg5o2u/+i3ZAA5EAZi4W
 ygltim2JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZs+yegAKCRAk1otyXVSH0Ej7B/
 4i7V5o8NwcAlzF0dC+dC7r9ly6FsY2jaJX4HBmux5vDqMKE2ssgjL7PW/vLOoPBS6mpzseOWpwEsuQ
 efZzoPx50er7uqNMG9uH8TNmUHnq2qCpg1JGGzo/wDFM1rZqH43CnJQ5HxHnbQTAwtbo6PJUqJ48ib
 n9sXJezhzy/kcM9bSLndvUruiEaLAArgR3BggKgdHazVd5/y6+yeRzzxHM7z7MvhfbUFNo4YmqUuuj
 amvYgdk7+YXJCuHhIrgqI9qoC03307nJQNKADYDPz6WoNiKrU3PDbGav7T1tGnsCkKrI0jdd3Jftbk
 xjTF6ie+KPWrJmU4xk9fZ7BVYxKeW3
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Three architectures (x86, aarch64, riscv) have announced support for
shadow stacks with fairly similar functionality.  While x86 is using
arch_prctl() to control the functionality neither arm64 nor riscv uses
that interface so this patch adds arch-agnostic prctl() support to
get and set status of shadow stacks and lock the current configuation to
prevent further changes, with support for turning on and off individual
subfeatures so applications can limit their exposure to features that
they do not need.  The features are:

  - PR_SHADOW_STACK_ENABLE: Tracking and enforcement of shadow stacks,
    including allocation of a shadow stack if one is not already
    allocated.
  - PR_SHADOW_STACK_WRITE: Writes to specific addresses in the shadow
    stack.
  - PR_SHADOW_STACK_PUSH: Push additional values onto the shadow stack.

These features are expected to be inherited by new threads and cleared
on exec(), unknown features should be rejected for enable but accepted
for locking (in order to allow for future proofing).

This is based on a patch originally written by Deepak Gupta but modified
fairly heavily, support for indirect landing pads is removed, additional
modes added and the locking interface reworked.  The set status prctl()
is also reworked to just set flags, if setting/reading the shadow stack
pointer is required this could be a separate prctl.

Reviewed-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/linux/mm.h         |  4 ++++
 include/uapi/linux/prctl.h | 22 ++++++++++++++++++++++
 kernel/sys.c               | 30 ++++++++++++++++++++++++++++++
 3 files changed, 56 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 3357625c1db3..96faf26b6083 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4201,4 +4201,8 @@ void vma_pgtable_walk_end(struct vm_area_struct *vma);
 
 int reserve_mem_find_by_name(const char *name, phys_addr_t *start, phys_addr_t *size);
 
+int arch_get_shadow_stack_status(struct task_struct *t, unsigned long __user *status);
+int arch_set_shadow_stack_status(struct task_struct *t, unsigned long status);
+int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long status);
+
 #endif /* _LINUX_MM_H */
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index 35791791a879..557a3d2ac1d4 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -328,4 +328,26 @@ struct prctl_mm_map {
 # define PR_PPC_DEXCR_CTRL_CLEAR_ONEXEC	0x10 /* Clear the aspect on exec */
 # define PR_PPC_DEXCR_CTRL_MASK		0x1f
 
+/*
+ * Get the current shadow stack configuration for the current thread,
+ * this will be the value configured via PR_SET_SHADOW_STACK_STATUS.
+ */
+#define PR_GET_SHADOW_STACK_STATUS      74
+
+/*
+ * Set the current shadow stack configuration.  Enabling the shadow
+ * stack will cause a shadow stack to be allocated for the thread.
+ */
+#define PR_SET_SHADOW_STACK_STATUS      75
+# define PR_SHADOW_STACK_ENABLE         (1UL << 0)
+# define PR_SHADOW_STACK_WRITE		(1UL << 1)
+# define PR_SHADOW_STACK_PUSH		(1UL << 2)
+
+/*
+ * Prevent further changes to the specified shadow stack
+ * configuration.  All bits may be locked via this call, including
+ * undefined bits.
+ */
+#define PR_LOCK_SHADOW_STACK_STATUS      76
+
 #endif /* _LINUX_PRCTL_H */
diff --git a/kernel/sys.c b/kernel/sys.c
index 3a2df1bd9f64..7e0c10e867cf 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2324,6 +2324,21 @@ int __weak arch_prctl_spec_ctrl_set(struct task_struct *t, unsigned long which,
 	return -EINVAL;
 }
 
+int __weak arch_get_shadow_stack_status(struct task_struct *t, unsigned long __user *status)
+{
+	return -EINVAL;
+}
+
+int __weak arch_set_shadow_stack_status(struct task_struct *t, unsigned long status)
+{
+	return -EINVAL;
+}
+
+int __weak arch_lock_shadow_stack_status(struct task_struct *t, unsigned long status)
+{
+	return -EINVAL;
+}
+
 #define PR_IO_FLUSHER (PF_MEMALLOC_NOIO | PF_LOCAL_THROTTLE)
 
 #ifdef CONFIG_ANON_VMA_NAME
@@ -2782,6 +2797,21 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 	case PR_RISCV_SET_ICACHE_FLUSH_CTX:
 		error = RISCV_SET_ICACHE_FLUSH_CTX(arg2, arg3);
 		break;
+	case PR_GET_SHADOW_STACK_STATUS:
+		if (arg3 || arg4 || arg5)
+			return -EINVAL;
+		error = arch_get_shadow_stack_status(me, (unsigned long __user *) arg2);
+		break;
+	case PR_SET_SHADOW_STACK_STATUS:
+		if (arg3 || arg4 || arg5)
+			return -EINVAL;
+		error = arch_set_shadow_stack_status(me, arg2);
+		break;
+	case PR_LOCK_SHADOW_STACK_STATUS:
+		if (arg3 || arg4 || arg5)
+			return -EINVAL;
+		error = arch_lock_shadow_stack_status(me, arg2);
+		break;
 	default:
 		error = -EINVAL;
 		break;

-- 
2.39.2


