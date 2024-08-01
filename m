Return-Path: <linux-fsdevel+bounces-24751-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8629944BDF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 14:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07B441C241A9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 12:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2521A0737;
	Thu,  1 Aug 2024 12:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gn76kpXZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1178208D1;
	Thu,  1 Aug 2024 12:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722517053; cv=none; b=HCjVlV0sWLFFoFJ4Bc8Dd3ABLZ7C9YyJ8k6/7i4DOF5z0L4UXOS5o2urAXBcmA4AAi4PGFUkGAYVGYHG/gJex+AjRfiTX+cJGLGjKcCWr7CcuZklJPsxm+rLs1s38lM2iECyBtKqOC/4bziYYB+N0S0KjMti6jilBKTFUNBRNF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722517053; c=relaxed/simple;
	bh=OvR6N9yV4HsQXOrwTY0B56Y1UKQlPL/MpYNNiWGIOU8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Zvo1ShtpVpE+LYQ1sgRoy+1AuzIOWEMQXOZ15wAoXIcyLYmVrkcXvxnUKq9OwxwO2ZN8zELLHLWRLywcbmuqWOCO/Y2JqHqTbd++xOWkFtZQZYQHSklEC0pobk3WflKA3EeP0aVTlLQozP7Z4E8jxbJuVo8mKARYLL54DJvFRHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gn76kpXZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA5D0C4AF0A;
	Thu,  1 Aug 2024 12:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722517053;
	bh=OvR6N9yV4HsQXOrwTY0B56Y1UKQlPL/MpYNNiWGIOU8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gn76kpXZGuovEJsswE8j2lOsgBW4PR578UDiThd4s4I4YoKJvfCqZ1DbymCf8xbuS
	 X1VOWKfLhwcVY4x/7o6COOGPpHHtRj30f6+8qQT18mHHKmzfTHeh2Xn8DQWch4wQK1
	 cxBX1MypgoCqxGif2mx/sPN2jyddzQ4Dak828B+c0NQugWavtwya2f4qLq4NQzikc2
	 ufy8oYQxFvr/igSCWz/RQmXY+eMxi1Oqas371CoVkslDEjBkApbMoyAxOhB9FuJyHV
	 zfRxmc0Z9gmNSXU8mEafsD7OCIHZ1ZKXLsBf9JYdybCT8eKt8/qRU5C5953UD9yNsg
	 FqVwhIyJRtZWQ==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 01 Aug 2024 13:06:29 +0100
Subject: [PATCH v10 02/40] prctl: arch-agnostic prctl for shadow stack
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240801-arm64-gcs-v10-2-699e2bd2190b@kernel.org>
References: <20240801-arm64-gcs-v10-0-699e2bd2190b@kernel.org>
In-Reply-To: <20240801-arm64-gcs-v10-0-699e2bd2190b@kernel.org>
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
 Ross Burton <ross.burton@arm.com>, linux-arm-kernel@lists.infradead.org, 
 linux-doc@vger.kernel.org, kvmarm@lists.linux.dev, 
 linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=4893; i=broonie@kernel.org;
 h=from:subject:message-id; bh=OvR6N9yV4HsQXOrwTY0B56Y1UKQlPL/MpYNNiWGIOU8=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmq4YHrCxoJewftWxnfq1JlcPpYr/nO77UmMRV/g7S
 YVEk79WJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZquGBwAKCRAk1otyXVSH0KqxB/
 9V8lZDkQrrXcsvux9tk7R1eV9YCB9mCgv2Q4nH5xihY0ZzyoSsqiELgMjgt47Ir53+f8lbqNS7cyQB
 I+xudEB6RcvJF4uBteFTILgVTSp/QZWdfdvlP606m3rXGb2OVV+BTqc8JQTM+aM94uU1xP7QifRd22
 iwljaiX/twQduRHonpm2IcsNgOEZIgG9EvS6b2pzPcyQnVma8Y37pKLarPPisLyolug0EvX2jH+Ca2
 ZDHi1MtqM5/1pZvEEa17v+w7O01Tzz715NDODwbsM8fWGWjQ+/EYSNM/1DPYHUh3u3Ce8smfZ0m09p
 2Grb0JOhTkKuKIk+M6U9e6lTwbhgzk
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


