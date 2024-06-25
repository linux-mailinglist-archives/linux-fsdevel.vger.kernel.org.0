Return-Path: <linux-fsdevel+bounces-22391-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F17EC916C01
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 17:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 202A31C23C67
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 15:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A5FB1802C2;
	Tue, 25 Jun 2024 15:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cGxifYni"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B96D170830;
	Tue, 25 Jun 2024 15:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719327781; cv=none; b=LTp8GmDL9JK4SkswlltHGZ2CGyhZ+I1ihi8snTJ1ipkYQSupY8QTqCh5RgdavxcOG3wI69r6qDFQIfPadueu7Bx141ckxdxh2kRN9yU3TcVJlxNqTkKrjfClHv2zhILX6yf3vKLnMl8gpGgG5pUsAdA50jzRv/ac3axzjv+3u6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719327781; c=relaxed/simple;
	bh=3MuDT0lq8KZmV1XvQ4eEMxmePoPU0e2iLvefjXGcLsE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N5deIp8hwFZZ0U0gInmI1GCG7WjZTFqYu+yT0LE3/9Ityka2FwXnXeuEa6RglqWgpA5bb4SZJ7Or01w8lQcSfPqIjr7UsPbTFUf/i06/HwV4a1J/CsnqZj9LwX6SVOUUhYB/CbBap2ZOJVzlqsjttetg9/tLobzut9TsyP2jMFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cGxifYni; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF857C4AF0B;
	Tue, 25 Jun 2024 15:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719327781;
	bh=3MuDT0lq8KZmV1XvQ4eEMxmePoPU0e2iLvefjXGcLsE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cGxifYnizydDYbAYvP+wDKkG6jlDC0JHeyn+sBV9HwjYjBjuPNIwVSCFTTtNSh8cE
	 8G3c/p+gwZhEcN3KfNLa6lnJsZBN5gtJbWav02ElEDbXl82phXCXq6kvKM//cpiR23
	 MihlsaHx3LzM/fp7zLy5Vgv2v3s6a14vKiOYgXZeb093IVhd1wP088G8YnbtqHjq+w
	 Uco4e0oCGwFWiHqPqffp9/McCr/HnZg+5y9efALmGK+J69fkH+8xDmcB0Mc7BPTV7y
	 D3kVduHxgqv99IaWX9z7M3JBW+2AeBzx5lUto2ZaMZK4ZSp3hplisJS9aA1P2M3x2Q
	 mD+pGvYLqpG2w==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 25 Jun 2024 15:57:48 +0100
Subject: [PATCH v9 20/39] arm64/gcs: Ensure that new threads have a GCS
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240625-arm64-gcs-v9-20-0f634469b8f0@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8610; i=broonie@kernel.org;
 h=from:subject:message-id; bh=3MuDT0lq8KZmV1XvQ4eEMxmePoPU0e2iLvefjXGcLsE=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmetuCyD3AT1jyLg/JaFc7dWWdFw5qsb2djX5Sg4ao
 a6pI64OJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZnrbggAKCRAk1otyXVSH0POFB/
 sH2aiItPsj0Q9I2eKEI6VayCf5mkGZsy48E1nyLONDzZa/ATNrSnwvHtuTHH4y+r4rcCh0pkrmwAkj
 P1ToSmfjffCuSkCsICmwjtYiUpTSO9kYhn1GWUkCYLx83UBY4tQ9gyVxLbkwt/J0wcQHU8opIPOgHH
 eUA2lYuMoFk5UaaKN1dEI6Rjmf3xzVr0Adk6pQKEs6tPdJaNgib1hDAlq0pPGJjWFxyi4uD35lsv7J
 1No1DBddD275ztvUNT5JPIGRgZxanHh+or1SH0JjxSl5xbMQ5u6Ia+HrOYmqf6ze8X4l1F9kdQ778g
 4l+a0dz0OHEabQP4iwNP5uo+J+K5jG
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
so when a thread is created which has GCS enabled allocate one for it.
We follow the extensively discussed x86 implementation and allocate
min(RLIMIT_STACK, 2G).  Since the GCS only stores the call stack and not
any variables this should be more than sufficient for most applications.

GCSs allocated via this mechanism will be freed when the thread exits,
those explicitly configured by the user will not.

Reviewed-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/gcs.h |   9 +++
 arch/arm64/kernel/process.c  |  29 +++++++++
 arch/arm64/mm/gcs.c          | 143 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 181 insertions(+)

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
index 5f00cb0da9c3..d6d3a96cf2e4 100644
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
@@ -366,6 +390,7 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 	unsigned long stack_start = args->stack;
 	unsigned long tls = args->tls;
 	struct pt_regs *childregs = task_pt_regs(p);
+	int ret;
 
 	memset(&p->thread.cpu_context, 0, sizeof(struct cpu_context));
 
@@ -407,6 +432,10 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
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
index b0a67efc522b..4a3ce8e3bdfb 100644
--- a/arch/arm64/mm/gcs.c
+++ b/arch/arm64/mm/gcs.c
@@ -8,6 +8,139 @@
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
+static bool gcs_consume_token(struct mm_struct *mm, unsigned long user_addr)
+{
+	u64 expected = GCS_CAP(user_addr);
+	u64 val;
+	int ret;
+
+	/* This should really be an atomic cpmxchg.  It is not. */
+	ret = access_remote_vm(mm, user_addr, &val, sizeof(val),
+			       FOLL_FORCE);
+	if (ret != sizeof(val))
+		return false;
+
+	if (val != expected)
+		return false;
+
+	val = 0;
+	ret = access_remote_vm(mm, user_addr, &val, sizeof(val),
+			       FOLL_FORCE | FOLL_WRITE);
+	if (ret != sizeof(val))
+		return false;
+
+	return true;
+}
+
+int arch_shstk_post_fork(struct task_struct *tsk,
+			 struct kernel_clone_args *args)
+{
+	struct mm_struct *mm;
+	unsigned long addr, size, gcspr_el0;
+	int ret = 0;
+
+	mm = get_task_mm(tsk);
+	if (!mm)
+		return -EFAULT;
+
+	addr = args->shadow_stack;
+	size = args->shadow_stack_size;
+
+	/*
+	 * There should be a token, and there is likely to be an optional
+	 * end of stack marker above it.
+	 */
+	gcspr_el0 = addr + size - (2 * sizeof(u64));
+	if (!gcs_consume_token(mm, gcspr_el0)) {
+		gcspr_el0 += sizeof(u64);
+		if (!gcs_consume_token(mm, gcspr_el0)) {
+			ret = -EINVAL;
+			goto out;
+		}
+	}
+
+	tsk->thread.gcspr_el0 = gcspr_el0 + sizeof(u64);
+
+out:
+	mmput(mm);
+
+	return ret;
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
+		/* GCSPR_EL0 will be set up when verifying token post fork */
+		addr = args->shadow_stack;
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
@@ -30,6 +163,16 @@ void gcs_set_el0_mode(struct task_struct *task)
 
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
2.39.2


