Return-Path: <linux-fsdevel+bounces-10166-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F6528485E6
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Feb 2024 13:38:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 260CF286B0A
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Feb 2024 12:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C337317C;
	Sat,  3 Feb 2024 12:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tpLHddu/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF3973175;
	Sat,  3 Feb 2024 12:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706963523; cv=none; b=mXp/DS73Hiql3x2+bfzlLTV77h0dMJOMC9KAhFeVosEkFmnxwqxDxdZZwLYbzjd2O6qXQqxQr5fKBW1OuoM/HBrznqcv02fqDRIuuJ51uxodj8f/aMMZhaI4TJkbsCk2TKFv8wsxXir0ZpUQpOZJQVmlKV7Tnu5ACJidlpo4z5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706963523; c=relaxed/simple;
	bh=U5MciaTL0rYvjCIumqURacdaryA/1hlaB10gSNsfShY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A6MHp2rykp72gQVfBnvV5xr6+HCmCUloa/ONmPM79CRgI77QXQ6mdzrnp6V2JuXfjyPUjeXp1V0UXj5gQAm6zbtJ5Kq0ivZFY+ywhSi2JieyK16t6pZrv9zjCc17Ub/I61YkX2rnBo+vVTNXNk1U3un/h3tOnbJNxF64SEsOcoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tpLHddu/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03BD9C43390;
	Sat,  3 Feb 2024 12:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706963523;
	bh=U5MciaTL0rYvjCIumqURacdaryA/1hlaB10gSNsfShY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tpLHddu/3s6KK5wnT5rQj+Pd5a6ev93vYGZXSRAuAXzWXWvjis8vox9rbuowcCRjO
	 xNH5+6JIOg3XVeikkfgANT2/AIC6wQmgutrXNk4SqzasRQRra0bdiRnpRY387wk4ux
	 3j3nDdZx2cYT02NiWyK8VDqCodWSHShr6OifHn3PybyqlRGEK3RJfc+J7VZvqBW1ne
	 s3WdrV7DXIedRn80l8EgeUmC45bwLOZvXfwVd532i6BBs18Sa+uRn/Fkt0NlFuKDXl
	 yYQl6LIG2ahA4jC8un1pCKHqP03Dz1q8+V8R2a7KBLF4PJYAR1GMIHWQ9n24mAzWKl
	 drauPDYDOk63g==
From: Mark Brown <broonie@kernel.org>
Date: Sat, 03 Feb 2024 12:25:47 +0000
Subject: [PATCH v8 21/38] arm64/gcs: Implement shadow stack prctl()
 interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240203-arm64-gcs-v8-21-c9fec77673ef@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5675; i=broonie@kernel.org;
 h=from:subject:message-id; bh=U5MciaTL0rYvjCIumqURacdaryA/1hlaB10gSNsfShY=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlvjDhXvrqcGZBd+9/+gfWtioOkspbIVIuapYQkeO4
 2Ek4A8+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZb4w4QAKCRAk1otyXVSH0JuzB/
 9Nsil/CkJIgThqvkV7vl+7SUj4tch4kYdrDe1K2VdYijvUW+AeVboEr8gnTvdiOIJwutNGG9JEkV9f
 KPDIwaRpAUfybv1h5fN6qSvwUClufBTP7FbMRgd2OJfecw5g2ieJgg0q1Ob6AkjLBOa+2tBUxuEMIN
 xeB/8dMvhw3u/XTn22XIxZSc/sgH18/tKXF+QgsY4Yf+QOw6qVQ8hzeRSmLGb7Yng2SD6ncWl2Ex79
 LHwZ2eJofY3G+embhTZ16cXU3FdVF8SkhnAi7FiuJ8JsXPj+X6vANHdevGcvILeiZXc1IflJ7meoyc
 J74wfqlKIe7HuZQPvCxTshDzN9l0wn
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Implement the architecture neutral prtctl() interface for setting the
shadow stack status, this supports setting and reading the current GCS
configuration for the current thread.

Userspace can enable basic GCS functionality and additionally also
support for GCS pushes and arbitrary GCS stores.  It is expected that
this prctl() will be called very early in application startup, for
example by the dynamic linker, and not subsequently adjusted during
normal operation.  Users should carefully note that after enabling GCS
for a thread GCS will become active with no call stack so it is not
normally possible to return from the function that invoked the prctl().

State is stored per thread, enabling GCS for a thread causes a GCS to be
allocated for that thread.

Userspace may lock the current GCS configuration by specifying
PR_SHADOW_STACK_ENABLE_LOCK, this prevents any further changes to the
GCS configuration via any means.

If GCS is not being enabled then all flags other than _LOCK are ignored,
it is not possible to enable stores or pops without enabling GCS.

When disabling the GCS we do not free the allocated stack, this allows
for inspection of the GCS after disabling as part of fault reporting.
Since it is not an expected use case and since it presents some
complications in determining what to do with previously initialsed data
on the GCS attempts to reenable GCS after this are rejected.  This can
be revisted if a use case arises.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/gcs.h       | 22 ++++++++++
 arch/arm64/include/asm/processor.h |  1 +
 arch/arm64/mm/gcs.c                | 82 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 105 insertions(+)

diff --git a/arch/arm64/include/asm/gcs.h b/arch/arm64/include/asm/gcs.h
index c1f274fdb9c0..48c97e63e56a 100644
--- a/arch/arm64/include/asm/gcs.h
+++ b/arch/arm64/include/asm/gcs.h
@@ -50,6 +50,9 @@ static inline u64 gcsss2(void)
 	return Xt;
 }
 
+#define PR_SHADOW_STACK_SUPPORTED_STATUS_MASK \
+	(PR_SHADOW_STACK_ENABLE | PR_SHADOW_STACK_WRITE | PR_SHADOW_STACK_PUSH)
+
 #ifdef CONFIG_ARM64_GCS
 
 static inline bool task_gcs_el0_enabled(struct task_struct *task)
@@ -63,6 +66,20 @@ void gcs_preserve_current_state(void);
 unsigned long gcs_alloc_thread_stack(struct task_struct *tsk,
 				     const struct kernel_clone_args *args);
 
+static inline int gcs_check_locked(struct task_struct *task,
+				   unsigned long new_val)
+{
+	unsigned long cur_val = task->thread.gcs_el0_mode;
+
+	cur_val &= task->thread.gcs_el0_locked;
+	new_val &= task->thread.gcs_el0_locked;
+
+	if (cur_val != new_val)
+		return -EBUSY;
+
+	return 0;
+}
+
 #else
 
 static inline bool task_gcs_el0_enabled(struct task_struct *task)
@@ -78,6 +95,11 @@ static inline unsigned long gcs_alloc_thread_stack(struct task_struct *tsk,
 {
 	return -ENOTSUPP;
 }
+static inline int gcs_check_locked(struct task_struct *task,
+				   unsigned long new_val)
+{
+	return 0;
+}
 
 #endif
 
diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index 6fc6dcbd494c..6a3091ec0f03 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -184,6 +184,7 @@ struct thread_struct {
 	u64			tpidr2_el0;
 #ifdef CONFIG_ARM64_GCS
 	unsigned int		gcs_el0_mode;
+	unsigned int		gcs_el0_locked;
 	u64			gcspr_el0;
 	u64			gcs_base;
 	u64			gcs_size;
diff --git a/arch/arm64/mm/gcs.c b/arch/arm64/mm/gcs.c
index 3cbc3a3d4bc7..95f5cf599bc6 100644
--- a/arch/arm64/mm/gcs.c
+++ b/arch/arm64/mm/gcs.c
@@ -154,3 +154,85 @@ void gcs_free(struct task_struct *task)
 	task->thread.gcs_base = 0;
 	task->thread.gcs_size = 0;
 }
+
+int arch_set_shadow_stack_status(struct task_struct *task, unsigned long arg)
+{
+	unsigned long gcs, size;
+	int ret;
+
+	if (!system_supports_gcs())
+		return -EINVAL;
+
+	if (is_compat_thread(task_thread_info(task)))
+		return -EINVAL;
+
+	/* Reject unknown flags */
+	if (arg & ~PR_SHADOW_STACK_SUPPORTED_STATUS_MASK)
+		return -EINVAL;
+
+	ret = gcs_check_locked(task, arg);
+	if (ret != 0)
+		return ret;
+
+	/* If we are enabling GCS then make sure we have a stack */
+	if (arg & PR_SHADOW_STACK_ENABLE) {
+		if (!task_gcs_el0_enabled(task)) {
+			/* Do not allow GCS to be reenabled */
+			if (task->thread.gcs_base)
+				return -EINVAL;
+
+			if (task != current)
+				return -EBUSY;
+
+			size = gcs_size(0);
+			gcs = alloc_gcs(task->thread.gcspr_el0, size,
+					0, 0);
+			if (!gcs)
+				return -ENOMEM;
+
+			task->thread.gcspr_el0 = gcs + size - sizeof(u64);
+			task->thread.gcs_base = gcs;
+			task->thread.gcs_size = size;
+			if (task == current)
+				write_sysreg_s(task->thread.gcspr_el0,
+					       SYS_GCSPR_EL0);
+
+		}
+	}
+
+	task->thread.gcs_el0_mode = arg;
+	if (task == current)
+		gcs_set_el0_mode(task);
+
+	return 0;
+}
+
+int arch_get_shadow_stack_status(struct task_struct *task,
+				 unsigned long __user *arg)
+{
+	if (!system_supports_gcs())
+		return -EINVAL;
+
+	if (is_compat_thread(task_thread_info(task)))
+		return -EINVAL;
+
+	return put_user(task->thread.gcs_el0_mode, arg);
+}
+
+int arch_lock_shadow_stack_status(struct task_struct *task,
+				  unsigned long arg)
+{
+	if (!system_supports_gcs())
+		return -EINVAL;
+
+	if (is_compat_thread(task_thread_info(task)))
+		return -EINVAL;
+
+	/*
+	 * We support locking unknown bits so applications can prevent
+	 * any changes in a future proof manner.
+	 */
+	task->thread.gcs_el0_locked |= arg;
+
+	return 0;
+}

-- 
2.30.2


