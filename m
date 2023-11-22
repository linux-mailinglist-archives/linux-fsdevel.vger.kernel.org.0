Return-Path: <linux-fsdevel+bounces-3382-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13AD57F4250
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 10:45:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66365B216EC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 09:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00155645A;
	Wed, 22 Nov 2023 09:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J/t21EOt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25B45579B;
	Wed, 22 Nov 2023 09:45:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BBB3C433C7;
	Wed, 22 Nov 2023 09:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700646329;
	bh=p7vhwNE+CJYbXpRAkTVE4uNTVeLjV9vl6fV2mHCV5l8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=J/t21EOtX9LkHO6S2pMhuc938Wc3YdgkYmn0ooGJB+tFn7kn2xaS1fJa9v/tWKi43
	 ZTDDKJiFXArP+8mEXvmx2sBLcyO6KjFUwilZJ9QSpTmZBHex9DHtV7uGhhjFfTOdHA
	 BFtt+5Y6vqCpuXIYKBUJbZqMwDI8e9aBheS5w/j6wc1DsyC3Z2ID5HtMpFHCoHTcJo
	 rWLQurPTEuIvboKnpuVymwk7QeZNeC8YHWb609HHt82+32TM1oD3/3qoKdGeGwAAaa
	 xy2l0tOR5Nb7hVNhSMufPGx6/Ar5BoHrwMGH9nsGTb2eLlGyS1xBLrlgKhaomAQEKx
	 tYJH4Vzj89TFg==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 22 Nov 2023 09:42:31 +0000
Subject: [PATCH v7 21/39] arm64/gcs: Allocate a new GCS for threads with
 GCS enabled
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231122-arm64-gcs-v7-21-201c483bd775@kernel.org>
References: <20231122-arm64-gcs-v7-0-201c483bd775@kernel.org>
In-Reply-To: <20231122-arm64-gcs-v7-0-201c483bd775@kernel.org>
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
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=5979; i=broonie@kernel.org;
 h=from:subject:message-id; bh=p7vhwNE+CJYbXpRAkTVE4uNTVeLjV9vl6fV2mHCV5l8=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlXc0GtL0+c11OyZaFaNeVlqO8pwcT9Q3SQtGvl
 DiVL+0NZkSJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZV3NBgAKCRAk1otyXVSH
 0I5ZB/9ZoJk5A/i0hsPYxTWiFmHCmO/wYkYfWs9TeOH7TaQylRIdkTSuSPmzgHhApbE5QeBZyaU
 uS997l8TNA33lJJ2js6ybFa7dhO+PFXo/WWqrdncps5Mt7P8IC0Zd/Z4jyBPVQumNeLPc2oJD5D
 uW83f704kQiGeBYcxmPTNph0Iy2NoFCK2tjIHAQ/zeTosrqitio0MFnrAvbvWNl5t/K3F67Tp6B
 Bf7jfpqYvIL/b83Z9wbP3/iID7f1dllpQQH5JL/Ig4/pVRu10RPXKm8ia5gAOIBI4b2tXMldcdb
 2y5Sqo6qdVr9SvMj0mxKxslcvS7VqlDB4ZvxXeja7O8Ko7EQ
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

When a new thread is created by a thread with GCS enabled the GCS needs
to be specified along with the regular stack.  clone3() has been
extended to support this case, allowing userspace to explicitly request
the size for the GCS to be created, but plain clone() is not extensible
and existing clone3() users will not specify a size.

For compatibility with these cases and also x86 (which did not initially
implement clone3() support for shadow stacks) if no GCS is specified we
will allocate one thread so when a thread is created which has GCS
enabled allocate one for it.  We follow the extensively discussed x86
implementation and allocate min(RLIMIT_STACK, 4G).  Since the GCS only
stores the call stack and not any variables this should be more than
sufficient for most applications.

GCSs allocated via this mechanism then it will be freed when the thread
exits.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/gcs.h |  9 ++++++
 arch/arm64/kernel/process.c  | 25 +++++++++++++++
 arch/arm64/mm/gcs.c          | 76 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 110 insertions(+)

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
index fd80b43c2969..588d2bc4b329 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -285,9 +285,29 @@ static void flush_gcs(void)
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
 
@@ -369,6 +389,7 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 	unsigned long stack_start = args->stack;
 	unsigned long tls = args->tls;
 	struct pt_regs *childregs = task_pt_regs(p);
+	int ret;
 
 	memset(&p->thread.cpu_context, 0, sizeof(struct cpu_context));
 
@@ -410,6 +431,10 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
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
index b0a67efc522b..0d4881173b5f 100644
--- a/arch/arm64/mm/gcs.c
+++ b/arch/arm64/mm/gcs.c
@@ -8,6 +8,82 @@
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
+unsigned long gcs_alloc_thread_stack(struct task_struct *tsk,
+				     const struct kernel_clone_args *args)
+{
+	unsigned long addr, size;
+
+	/* If the user specified a GCS use it. */
+	if (args->shadow_stack_size) {
+		if (!system_supports_gcs())
+			return (unsigned long)ERR_PTR(-EINVAL);
+
+		size = args->shadow_stack_size;
+
+		if (size < 8)
+			return (unsigned long)ERR_PTR(-EINVAL);
+
+	} else {
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
+	}
+
+	size = gcs_size(size);
+	addr = alloc_gcs(0, size, 0, 0);
+	if (IS_ERR_VALUE(addr))
+		return addr;
+
+	tsk->thread.gcs_base = addr;
+	tsk->thread.gcs_size = size;
+	tsk->thread.gcspr_el0 = addr + size - sizeof(u64);
+
+	return addr;
+}
+
 /*
  * Apply the GCS mode configured for the specified task to the
  * hardware.

-- 
2.39.2


