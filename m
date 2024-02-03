Return-Path: <linux-fsdevel+bounces-10147-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CAA2848587
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Feb 2024 13:31:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B73C3B25C01
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Feb 2024 12:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E2B5F482;
	Sat,  3 Feb 2024 12:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DPmH+nfN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B865D72C;
	Sat,  3 Feb 2024 12:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706963249; cv=none; b=GWCRMnPUZDwLNDaaaO3oy2L88/yIA8m7uSGFp4qtWVBAhfrxyM251BcvoynD53GznWUQy8b6m2hNramPrMmkDrwzGfLH0lmbqg1cvJOlw9BML5wotCms6JkVMjg/qlKKUyOuJIdC4HSMQRMQ5ndnj9ofA4gDWwRK8WFGoRLBpAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706963249; c=relaxed/simple;
	bh=3IJ5SeAASdHtIIStcvs359UoBpZ4hMPDZ8zRhgL+KJQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oJ5sBCw1h+R+s6+ZaYvbq1c+ntatnxA4uEhCORpM0fHvx9Q5OYEgRVqiO1Xb9Z28PbXCrLy3rKnODL+SU7zdujug+5DZ6gRjfJ/jUzNIPZWd0uCrJsLB5EQq47hChi4iSZKksMgNVjHdYetoJ+J8HzAVudGKQDM7o/f6ZNIh3aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DPmH+nfN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35388C43609;
	Sat,  3 Feb 2024 12:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706963248;
	bh=3IJ5SeAASdHtIIStcvs359UoBpZ4hMPDZ8zRhgL+KJQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DPmH+nfNwutz8I2cy45COQPzbwAEfPjI6ffHVfjCNllrgl6vp33v6POzMgRpiUz1H
	 R6TyvxMdEhSqVGHpIeiEr0p+nf/z4YAOXLc817SR8gY0hxjRWonN4ZYWB1mELfcD+u
	 J7wYEJW9thoiDrQF7mUZhwtuBsqwnml271Qg555AgCbsSA+Nx3F6RaqEpoowp7DVyT
	 JEBlCPvrwO3xFaqY3QrwHh/DKN1ZVngK60F7Ml/DEtqx6WVIyWbFL2sNR7OFKWGnAX
	 rthP6rYhkhBxKkG8iwQoOZdxqrQDiD6u4jT4CVAYdvIIt6mGqI3GifpPZr4J/thkmP
	 IBUzzRC/4Qz0Q==
From: Mark Brown <broonie@kernel.org>
Date: Sat, 03 Feb 2024 12:25:28 +0000
Subject: [PATCH v8 02/38] prctl: arch-agnostic prctl for shadow stack
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240203-arm64-gcs-v8-2-c9fec77673ef@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4768; i=broonie@kernel.org;
 h=from:subject:message-id; bh=3IJ5SeAASdHtIIStcvs359UoBpZ4hMPDZ8zRhgL+KJQ=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlvjDS1VpII3RNTbS21ZqAUQaox+Eucg15vDi3Rm0d
 /5PJGGWJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZb4w0gAKCRAk1otyXVSH0HTNB/
 9zYcH0WIf7htiNJ645c2X8FzMF1bRnXmpIa3HQrk1F0SgbCOhNYcpXWoBqfZBZpYKq+oSSh4xxf9L8
 HBVGI/kvF8TwcIyTGk4Qv5eb07yqP+ld18BNiEn5N6adaeLXpm0CQfVz9kiSZJeuoM0uTM6ijzD0H/
 ibNLhTdz2oJ8tP5z1WmYMA4uTUBS+Ox3HKYsVRRGjlWNGcpyHCWagK7vzKAwsdUOLmfePgoE3OLKAv
 IIb8m6ZlcL7kGrSIDv+Z64fInWKFktfQjQrcnKkyt+MFXDI+X/4ArV4mww497KBHQuEsk0c7q1cALZ
 ISEhWbo8N3Sl5Sj2gdItzpIbuFjN2Q
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

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/linux/mm.h         |  4 ++++
 include/uapi/linux/prctl.h | 22 ++++++++++++++++++++++
 kernel/sys.c               | 30 ++++++++++++++++++++++++++++++
 3 files changed, 56 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index c0a782eda803..0b1139c5df60 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4182,4 +4182,8 @@ static inline bool pfn_is_unaccepted_memory(unsigned long pfn)
 	return range_contains_unaccepted_memory(paddr, paddr + PAGE_SIZE);
 }
 
+int arch_get_shadow_stack_status(struct task_struct *t, unsigned long __user *status);
+int arch_set_shadow_stack_status(struct task_struct *t, unsigned long status);
+int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long status);
+
 #endif /* _LINUX_MM_H */
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index 370ed14b1ae0..3c66ed8f46d8 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -306,4 +306,26 @@ struct prctl_mm_map {
 # define PR_RISCV_V_VSTATE_CTRL_NEXT_MASK	0xc
 # define PR_RISCV_V_VSTATE_CTRL_MASK		0x1f
 
+/*
+ * Get the current shadow stack configuration for the current thread,
+ * this will be the value configured via PR_SET_SHADOW_STACK_STATUS.
+ */
+#define PR_GET_SHADOW_STACK_STATUS      71
+
+/*
+ * Set the current shadow stack configuration.  Enabling the shadow
+ * stack will cause a shadow stack to be allocated for the thread.
+ */
+#define PR_SET_SHADOW_STACK_STATUS      72
+# define PR_SHADOW_STACK_ENABLE         (1UL << 0)
+# define PR_SHADOW_STACK_WRITE		(1UL << 1)
+# define PR_SHADOW_STACK_PUSH		(1UL << 2)
+
+/*
+ * Prevent further changes to the specified shadow stack
+ * configuration.  All bits may be locked via this call, including
+ * undefined bits.
+ */
+#define PR_LOCK_SHADOW_STACK_STATUS      73
+
 #endif /* _LINUX_PRCTL_H */
diff --git a/kernel/sys.c b/kernel/sys.c
index e219fcfa112d..96e8a6b5993a 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2301,6 +2301,21 @@ int __weak arch_prctl_spec_ctrl_set(struct task_struct *t, unsigned long which,
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
@@ -2743,6 +2758,21 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 	case PR_RISCV_V_GET_CONTROL:
 		error = RISCV_V_GET_CONTROL();
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
2.30.2


