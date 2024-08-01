Return-Path: <linux-fsdevel+bounces-24770-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB91E944C4E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 15:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9D45B26F26
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 13:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F131B3F23;
	Thu,  1 Aug 2024 12:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GUkmhbKE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D697A1A4882;
	Thu,  1 Aug 2024 12:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722517184; cv=none; b=EqWblO6i3JyKJdWlz1FXW4GPXJ31JcIROJPA3ZGNybWSFvi3powZREkrLC2e0sh45FcEvwVl219p7SCaIM2OPs+vEe5AKiseLO6hTd6D2NgGkrAEtMXgaozDjAQCC+ljBaF5DuIXV9qEEO9GrJrNoTVF+TBBuI+Z/QNIF03O+Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722517184; c=relaxed/simple;
	bh=l/cgslNqipFgR1QPpcC58vps94W/JCkBuifrxenYdK8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ml8jWPlf3plMzzqIQZAnzeHKaQR5sUQYPlZ3pMxJus8SostBcop85XqxB7TCXBEHp1B0c2UlehwBTs1qbKmQ6Rrqc+dnfN2sL9sWlAevUGlEbhNfGrx1tm6M75a3UL8xcqpMxQwr9QxjwmpKUPsGno8+1qJH+MoPl0Uf/FLZhho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GUkmhbKE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3DA1C32786;
	Thu,  1 Aug 2024 12:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722517183;
	bh=l/cgslNqipFgR1QPpcC58vps94W/JCkBuifrxenYdK8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GUkmhbKE+Q+QxkXEevPPCfiJRXd5FNakIcikzhEN2r+Y3716TgIqNQqi3/13TrKdN
	 HIBgZQ/1SxhfeUku1mjS3dI9gJd5Y0/ivPkfcKPfKg5jlCt2uVtcovZSQiwB4bUAY1
	 60yd94kZUoDzqiPkoVcVrpqLeaIFFQp0zmet05AAhv8xve7WNP/maR57YBUIkEFAM0
	 ReBIG2n0DHxR5fn2goMGp20tPmqUycZyTj7dOsbsp4ZLaKI5uA18FfBlXS1JAaMxBP
	 evqz3VGXwik6kkVPFN517NfkDbi0mWCXCoD94vwEkIkjYY2LMkGf9buq6RTQzNFkwa
	 bloRRVzHt8Imw==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 01 Aug 2024 13:06:48 +0100
Subject: [PATCH v10 21/40] arm64/gcs: Implement shadow stack prctl()
 interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240801-arm64-gcs-v10-21-699e2bd2190b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5708; i=broonie@kernel.org;
 h=from:subject:message-id; bh=l/cgslNqipFgR1QPpcC58vps94W/JCkBuifrxenYdK8=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmq4YW+701C0PZ1auv1x0ZYEkwavziBHutsB26kIic
 off1qfiJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZquGFgAKCRAk1otyXVSH0KvmB/
 wOu13MLk5RjXsF3gjaYR24ss/GiRkPXfkTMTPQb7ytIqHtjun7ntid2AAFcjdLng+3y+Ozw3Wfi0NK
 Tg4zsf7/hUv0Sr6rdDVaQWSz2RUqS5W4ARSC0sSjtOjTQx5ZRdj1o9kS2BXEqi0aJp/qLl+FHfQTnV
 1G64p0RRP7baD+jgOSoWwFEU599l1245JyBmReBWlqt0Wo2i0ULYXqzzKKgapzB6wfLNmPCm680IX6
 zf6mHYGwq63zPkix9zp3xpQHZ/bDHZ7NHyXJOzRJulz8dVKlrANaTJ1/QXaTfiFX6RJlG9LPOfNiBL
 0Y1WZQwObI0/++tANtghpDMRAyN5dX
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
index b71f6b408513..0d39829f862e 100644
--- a/arch/arm64/mm/gcs.c
+++ b/arch/arm64/mm/gcs.c
@@ -179,3 +179,84 @@ void gcs_free(struct task_struct *task)
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
+			gcs = alloc_gcs(0, size);
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


