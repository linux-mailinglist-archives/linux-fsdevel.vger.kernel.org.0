Return-Path: <linux-fsdevel+bounces-10165-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 870DD8485E1
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Feb 2024 13:38:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA2EA1F26025
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Feb 2024 12:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB736EB7F;
	Sat,  3 Feb 2024 12:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cyNcuS0y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8E45F48F;
	Sat,  3 Feb 2024 12:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706963516; cv=none; b=JpVkatNMDU7TDo309anhVpQuM6GN1GuCcUVUMxGFxJImV59WDSSzoOUcev7fc7AKx1CCdAVE0c/rwDSD54hZTZmtatUGvNmdzfwGw3jfJRa1UOQqT3bLCKfhn1eJV2Zo59c+Ya7bQWA3IOrsAyK/hiNku5S1I7P54ySCw/tlw8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706963516; c=relaxed/simple;
	bh=0Pd0/0g5ocUKEQPs+CZnjpGh8a2yrzXoWJs/48QxMEE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LusQrer36KAoEedHk8WFq/6S77xsMvULmAomJIzg7hly0/cThLGaXZArm/JBIqZ69ZoxXxmFfEKrfQOIM0mNw4lE5bHwgWY2R0ru1HBHkNmBGrFKUjMiOh38fbydSXsM5RcLnKYdRyeHlH8NmEgD0L1yGOp5qVtrx8x/IJnFhQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cyNcuS0y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BDE6C43609;
	Sat,  3 Feb 2024 12:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706963516;
	bh=0Pd0/0g5ocUKEQPs+CZnjpGh8a2yrzXoWJs/48QxMEE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cyNcuS0yepL5PtUjvbc/4GFBi2f/FzV2Rq68YWIi6IyGPqro5gwLsktAkGRmwPo1a
	 DPZhVCUVajR9H8/X/Mfrr5g/19Z9FqBbjSBiqN49LicQByhoDK78Kzey/i8uaKehHs
	 LTRp/whj0BtqnzkxIl1rHWzXdbCik8Y0arm5N5cnVYOH4p9zdydt9tsy7G5jSIPUlE
	 ghVEwmHGsW1EjfuxRTurzDKjJr6RXkxUft3/jf/K1OSaiK4+nwoWVbcIiXmp8OuW1J
	 s8rV2N0mpTA5rWd/gCd4jovg5NSF9MQOzC4oohJwqa/2pI0gR/8eV2YU/LnDYnWV6Q
	 JBz+FjYiklaJA==
From: Mark Brown <broonie@kernel.org>
Date: Sat, 03 Feb 2024 12:25:46 +0000
Subject: [PATCH v8 20/38] arm64/gcs: Ensure that new threads have a GCS
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240203-arm64-gcs-v8-20-c9fec77673ef@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8134; i=broonie@kernel.org;
 h=from:subject:message-id; bh=0Pd0/0g5ocUKEQPs+CZnjpGh8a2yrzXoWJs/48QxMEE=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlvjDgHmbpnJ6Kt5FNSJQp2DtC/IJQdbRg85cvhx1K
 Miz2+d6JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZb4w4AAKCRAk1otyXVSH0Nt4B/
 wL1XPKLA8oon7Ntls/p18FPxhxgITjHFhOhCLATvZLdx2/CGCM3XeV/oZsdqUKAMfvNSiqdk2Hge2L
 fXSpLOz8lwnFEMhBV3cPt2SQCcib5865B65V4ujM7VbyryF0RdOZBJ41g7KrO1xusFXtASE/2LgTRg
 cLOGH05SSH2Iikwkk6HQbyru9QOvtzsuefI+bj077rEszYry0kVn8SgYKDtyKel1hhgX47wO6gRvy/
 LH1qXI2PclfTBlVo+H8Uqr5qA2Vnn4yZpnxjUdpiKQnpuBPZKk3k3h+YZur6WqivBxp086HvEi+kZZ
 zA7yjuAcOJULaSipntqexmuqh00q3A
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

When a new thread is created by a thread with GCS enabled the GCS needs
to be specified along with the regular stack.  clone3() has been
extended to support this case, allowing userspace to explicitly specify
the size and location of the GCS.  The specified GCS must have a valid
GCS token at the top of the stack, as though userspace were pivoting to
the new GCS.  This will be consumed on use.  At present we do not
atomically consume the token, this will be addressed in a future
revision.

Unfortunately plain clone() is not extensible and existing clone3()
users will not specify a stack so all existing code would be broken if
we mandated specifying the stack explicitly.  For compatibility with
these cases and also x86 (which did not initially implement clone3()
support for shadow stacks) if no GCS is specified we will allocate one
thread so when a thread is created which has GCS enabled allocate one
for it.  We follow the extensively discussed x86 implementation and
allocate min(RLIMIT_STACK, 4G).  Since the GCS only stores the call
stack and not any variables this should be more than sufficient for most
applications.

GCSs allocated via this mechanism then it will be freed when the thread
exits, those explicitly configured by the user will not.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/gcs.h |   9 ++++
 arch/arm64/kernel/process.c  |  29 +++++++++++
 arch/arm64/mm/gcs.c          | 117 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 155 insertions(+)

diff --git a/arch/arm64/include/asm/gcs.h b/arch/arm64/include/asm/gcs.h
index 04594ef59dad..c1f274fdb9c0 100644
--- a/arch/arm64/include/asm/gcs.h
+++ b/arch/arm64/include/asm/gcs.h
@@ -8,6 +8,8 @@
 #include <asm/types.h>
 #include <asm/uaccess.h>
 
+struct kernel_clone_args;
+
 static inline void gcsb_dsync(void)
 {
 	asm volatile(".inst 0xd503227f" : : : "memory");
@@ -58,6 +60,8 @@ static inline bool task_gcs_el0_enabled(struct task_struct *task)
 void gcs_set_el0_mode(struct task_struct *task);
 void gcs_free(struct task_struct *task);
 void gcs_preserve_current_state(void);
+unsigned long gcs_alloc_thread_stack(struct task_struct *tsk,
+				     const struct kernel_clone_args *args);
 
 #else
 
@@ -69,6 +73,11 @@ static inline bool task_gcs_el0_enabled(struct task_struct *task)
 static inline void gcs_set_el0_mode(struct task_struct *task) { }
 static inline void gcs_free(struct task_struct *task) { }
 static inline void gcs_preserve_current_state(void) { }
+static inline unsigned long gcs_alloc_thread_stack(struct task_struct *tsk,
+						   const struct kernel_clone_args *args)
+{
+	return -ENOTSUPP;
+}
 
 #endif
 
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index fd80b43c2969..8bd66cde0a86 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -285,9 +285,32 @@ static void flush_gcs(void)
 	write_sysreg_s(0, SYS_GCSPR_EL0);
 }
 
+static int copy_thread_gcs(struct task_struct *p,
+			   const struct kernel_clone_args *args)
+{
+	unsigned long gcs;
+
+	gcs = gcs_alloc_thread_stack(p, args);
+	if (IS_ERR_VALUE(gcs))
+		return PTR_ERR((void *)gcs);
+
+	p->thread.gcs_el0_mode = current->thread.gcs_el0_mode;
+	p->thread.gcs_el0_locked = current->thread.gcs_el0_locked;
+
+	/* Ensure the current state of the GCS is seen by CoW */
+	gcsb_dsync();
+
+	return 0;
+}
+
 #else
 
 static void flush_gcs(void) { }
+static int copy_thread_gcs(struct task_struct *p,
+			   const struct kernel_clone_args *args)
+{
+	return 0;
+}
 
 #endif
 
@@ -303,6 +326,7 @@ void flush_thread(void)
 void arch_release_task_struct(struct task_struct *tsk)
 {
 	fpsimd_release_task(tsk);
+	gcs_free(tsk);
 }
 
 int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
@@ -369,6 +393,7 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 	unsigned long stack_start = args->stack;
 	unsigned long tls = args->tls;
 	struct pt_regs *childregs = task_pt_regs(p);
+	int ret;
 
 	memset(&p->thread.cpu_context, 0, sizeof(struct cpu_context));
 
@@ -410,6 +435,10 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 			p->thread.uw.tp_value = tls;
 			p->thread.tpidr2_el0 = 0;
 		}
+
+		ret = copy_thread_gcs(p, args);
+		if (ret != 0)
+			return ret;
 	} else {
 		/*
 		 * A kthread has no context to ERET to, so ensure any buggy
diff --git a/arch/arm64/mm/gcs.c b/arch/arm64/mm/gcs.c
index b0a67efc522b..3cbc3a3d4bc7 100644
--- a/arch/arm64/mm/gcs.c
+++ b/arch/arm64/mm/gcs.c
@@ -8,6 +8,113 @@
 #include <asm/cpufeature.h>
 #include <asm/page.h>
 
+static unsigned long alloc_gcs(unsigned long addr, unsigned long size,
+			       unsigned long token_offset, bool set_res_tok)
+{
+	int flags = MAP_ANONYMOUS | MAP_PRIVATE;
+	struct mm_struct *mm = current->mm;
+	unsigned long mapped_addr, unused;
+
+	if (addr)
+		flags |= MAP_FIXED_NOREPLACE;
+
+	mmap_write_lock(mm);
+	mapped_addr = do_mmap(NULL, addr, size, PROT_READ | PROT_WRITE, flags,
+			      VM_SHADOW_STACK, 0, &unused, NULL);
+	mmap_write_unlock(mm);
+
+	return mapped_addr;
+}
+
+static unsigned long gcs_size(unsigned long size)
+{
+	if (size)
+		return PAGE_ALIGN(size);
+
+	/* Allocate RLIMIT_STACK/2 with limits of PAGE_SIZE..2G */
+	size = PAGE_ALIGN(min_t(unsigned long long,
+				rlimit(RLIMIT_STACK) / 2, SZ_2G));
+	return max(PAGE_SIZE, size);
+}
+
+static bool gcs_consume_token(struct task_struct *tsk, unsigned long user_addr)
+{
+	unsigned long expected = GCS_CAP(user_addr);
+	unsigned long val;
+	int ret = 0;
+
+	/* This should really be an atomic cpmxchg.  It is not. */
+	__get_user_error(val, (__user unsigned long *)user_addr, ret);
+	if (ret != 0)
+		return false;
+
+	if (val != expected)
+		return false;
+
+	put_user_gcs(0, (__user unsigned long*)user_addr, &ret);
+
+	return ret == 0;
+}
+
+unsigned long gcs_alloc_thread_stack(struct task_struct *tsk,
+				     const struct kernel_clone_args *args)
+{
+	unsigned long addr, size, gcspr_el0;
+
+	/* If the user specified a GCS use it. */
+	if (args->shadow_stack_size) {
+		if (!system_supports_gcs())
+			return (unsigned long)ERR_PTR(-EINVAL);
+
+		addr = args->shadow_stack;
+		size = args->shadow_stack_size;
+
+		/*
+		 * There should be a token, there might be an end of
+		 * stack marker.
+		 */
+		gcspr_el0 = addr + size - (2 * sizeof(u64));
+		if (!gcs_consume_token(tsk, gcspr_el0)) {
+			gcspr_el0 += sizeof(u64);
+			if (!gcs_consume_token(tsk, gcspr_el0))
+				return (unsigned long)ERR_PTR(-EINVAL);
+		}
+
+		/* Userspace is responsible for unmapping */
+		tsk->thread.gcspr_el0 = gcspr_el0 + sizeof(u64);
+	} else {
+
+		/*
+		 * Otherwise fall back to legacy clone() support and
+		 * implicitly allocate a GCS if we need a new one.
+		 */
+
+		if (!system_supports_gcs())
+			return 0;
+
+		if (!task_gcs_el0_enabled(tsk))
+			return 0;
+
+		if ((args->flags & (CLONE_VFORK | CLONE_VM)) != CLONE_VM) {
+			tsk->thread.gcspr_el0 = read_sysreg_s(SYS_GCSPR_EL0);
+			return 0;
+		}
+
+		size = args->stack_size;
+
+		size = gcs_size(size);
+		addr = alloc_gcs(0, size, 0, 0);
+		if (IS_ERR_VALUE(addr))
+			return addr;
+
+		tsk->thread.gcs_base = addr;
+		tsk->thread.gcs_size = size;
+		tsk->thread.gcspr_el0 = addr + size - sizeof(u64);
+	}
+
+	return addr;
+}
+
 /*
  * Apply the GCS mode configured for the specified task to the
  * hardware.
@@ -30,6 +137,16 @@ void gcs_set_el0_mode(struct task_struct *task)
 
 void gcs_free(struct task_struct *task)
 {
+
+	/*
+	 * When fork() with CLONE_VM fails, the child (tsk) already
+	 * has a GCS allocated, and exit_thread() calls this function
+	 * to free it.  In this case the parent (current) and the
+	 * child share the same mm struct.
+	 */
+	if (!task->mm || task->mm != current->mm)
+		return;
+
 	if (task->thread.gcs_base)
 		vm_munmap(task->thread.gcs_base, task->thread.gcs_size);
 

-- 
2.30.2


