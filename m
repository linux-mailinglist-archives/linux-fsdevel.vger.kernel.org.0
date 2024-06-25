Return-Path: <linux-fsdevel+bounces-22392-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1620916C06
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 17:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D5B91F2A840
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 15:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93157180A61;
	Tue, 25 Jun 2024 15:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p8Zd/jPq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7322170830;
	Tue, 25 Jun 2024 15:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719327790; cv=none; b=F/si3oiPFfQCrqyFmyLg6BFtGBIksAyCizCpDEIiJyalGvt3FsskjDEesdjN38sv/193Qnq4zTjGB7QPn63mDUkjDVcs6WXR+HCnEVCGqmVwNWyeOMIB2alssUKa3NeY8u9aTaaxvdlMW/KcBNa7k/1NlMzNkbn5WSHE/f+eG+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719327790; c=relaxed/simple;
	bh=74i/o5o+GAjLuG4LcdrjtJS8isttL5m8bKZPRodV91A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=igIuGs9XmWD9EjSBkQfF0BfeXqPlPYtn/orL9nbLFIcnyZKML/RszZl3Ft+qbMo57m02BBwNQ9aw6y/4MEQkANr6o65Wy+MzWh4Yvc/mpKdYp8Fp2GpYbG4nhCALCDvWKHZCJd3GZKrKVNnrb+Dsb7vQ9NMihp/DUY7PSUzGHI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p8Zd/jPq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D801EC32786;
	Tue, 25 Jun 2024 15:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719327789;
	bh=74i/o5o+GAjLuG4LcdrjtJS8isttL5m8bKZPRodV91A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=p8Zd/jPqBWiv6p4ms8GUw7vIIxGC5btR+4/4QhxrtRFIULgo4t5OYBdjQ1NjzUEMh
	 hdjCWg4UQbaCpOTCol5u3Sa3+ag1HxAgOV3Q0JHCYm2XsRVM6ltPV+R2/agqh++JcZ
	 WdrNYNo2brKoe0x0c+RaYvXbUq7Q9E6TkdEO2j4Y3y3Y5I7C8QezK+zXWWZ13ZC/LB
	 5zTeifMzG1qugKL0a3R655vLcgF8BhddRWxkhwpdZ/rlikEbXQovm7MGipXm87WXk1
	 oikjW3UbIFBBigwerloHD3nK5jG9/M9wepMz04ATFgDE7Op0WmpfM/5Q3XfOBpyEBu
	 DgRrKFvUQeNyQ==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 25 Jun 2024 15:57:49 +0100
Subject: [PATCH v9 21/39] arm64/gcs: Implement shadow stack prctl()
 interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240625-arm64-gcs-v9-21-0f634469b8f0@kernel.org>
References: <20240625-arm64-gcs-v9-0-0f634469b8f0@kernel.org>
In-Reply-To: <20240625-arm64-gcs-v9-0-0f634469b8f0@kernel.org>
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
X-Mailer: b4 0.14-dev-d4707
X-Developer-Signature: v=1; a=openpgp-sha256; l=5714; i=broonie@kernel.org;
 h=from:subject:message-id; bh=74i/o5o+GAjLuG4LcdrjtJS8isttL5m8bKZPRodV91A=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmetuCFKqjdims19CgzTU6ifsr5pf8QuwxxzCjXEqT
 wrF/+EqJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZnrbggAKCRAk1otyXVSH0GchB/
 9aDc/X/c+aXCj96fsTSKFZkg0nIo1y7eH/uk7em610g3Amo1IdUZAS4Js/GL5lBxhXiv5YdRU4/raR
 SYtM+eLsKatF67WosEiYbum13OxZbM/LBmfCDHZ5Gc3Xw7i1U+NAtt0wkYsyxwreHxb+sEbpAm3Z9e
 2aijxqHhPbqBEXQRCQllMvj0/pvAjWwklmpGt2sL1fUSR0jGljCAK1NONQw5L7EY5kHr0WndUNxqHz
 3cxDXq4wuQJTADELQzTMInAfgbM4GGYfH7Q3xganDRJChWu0mGSy9ytOnBQL/v0PA7OMlYJoJy2Fc/
 L1y/xFkZwE9aXSs7JdxPF/WB56Ks44
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

Reviewed-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/gcs.h       | 22 +++++++++++
 arch/arm64/include/asm/processor.h |  1 +
 arch/arm64/mm/gcs.c                | 81 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 104 insertions(+)

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
index c55e3600604a..58eb48cd539f 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -186,6 +186,7 @@ struct thread_struct {
 	u64			tpidr2_el0;
 #ifdef CONFIG_ARM64_GCS
 	unsigned int		gcs_el0_mode;
+	unsigned int		gcs_el0_locked;
 	u64			gcspr_el0;
 	u64			gcs_base;
 	u64			gcs_size;
diff --git a/arch/arm64/mm/gcs.c b/arch/arm64/mm/gcs.c
index 4a3ce8e3bdfb..c6fae0eb9bd6 100644
--- a/arch/arm64/mm/gcs.c
+++ b/arch/arm64/mm/gcs.c
@@ -180,3 +180,84 @@ void gcs_free(struct task_struct *task)
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
+			gcs = alloc_gcs(0, size, 0, 0);
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
2.39.2


