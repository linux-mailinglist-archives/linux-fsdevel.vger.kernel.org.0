Return-Path: <linux-fsdevel+bounces-44962-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ABE4A6FB23
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 13:22:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DC51172BC6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 12:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53DB025B66B;
	Tue, 25 Mar 2025 12:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qd3pzD+U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71AB6A937;
	Tue, 25 Mar 2025 12:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742905067; cv=none; b=ZKaVRU8EPZgmo8Q7A6AQbD7+uZWtYLC1H62V1XMRw1FpKLBLBouVjkM9TpYSOvkVUQJ59skV+VxT0T9rQMvzc/sQU45Y4NpkiwYj/BHKgOhofsb7NlA8Y+5dhJKAMTnYds96GPZWzxEixv2MgpumtnOxbVeWsK893oc4vQR5kPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742905067; c=relaxed/simple;
	bh=rA1Mf4w9umBEMm9/yBwHJ19r6aOYZm1tJ3T1EWy4X2U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AKwWAx/j3bI9U5If5Iea2Eq/FQtP5D8l3Db0bR1dsaVpUPzIRZQBiIyNieZbxXKH2paMgkn02AVX5yqzAGrvs/y2FyRTOP2are/8jJcdVg/jepJ3qh4QBxOaBuNTT+yBNMa2WKlx8Dg4IR0dPqogi+ulam2SeNYbxvUJrFtxkfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qd3pzD+U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82E24C4CEEE;
	Tue, 25 Mar 2025 12:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742905066;
	bh=rA1Mf4w9umBEMm9/yBwHJ19r6aOYZm1tJ3T1EWy4X2U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qd3pzD+Ui6oxuJbCvCrC/EGtTe0Vt4+GBJSDObtd6gqIkKOGKSsPNFv+DVBxiXQzu
	 JG1nCmPj4TEtCZyY8gcjS8GWhs6YeefSvvlY6EPQqi76ow/h0zC07L/VnjG7fIAey2
	 /KD+F+jpDFhBv/ilLYMMexTuxTpEwLJiMyXjdEPFiGtgVDPDSuArKJRcGRx6Ffd+eC
	 sAq8p3etLhnpV68JxU7AtRmmAiKAh3UNd5bQtclUDBDWEDQrRwaPNC57lIgQXoPSTV
	 P060ndNbFm1EyAq8QUZTKTTvozFo2CznWNFAj8EQLXwJXILqE4h2hJ6YuRKPidj7Fi
	 7VWUd3QGdvOOA==
From: guoren@kernel.org
To: arnd@arndb.de,
	gregkh@linuxfoundation.org,
	torvalds@linux-foundation.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	anup@brainfault.org,
	atishp@atishpatra.org,
	oleg@redhat.com,
	kees@kernel.org,
	tglx@linutronix.de,
	will@kernel.org,
	mark.rutland@arm.com,
	brauner@kernel.org,
	akpm@linux-foundation.org,
	rostedt@goodmis.org,
	edumazet@google.com,
	unicorn_wang@outlook.com,
	inochiama@outlook.com,
	gaohan@iscas.ac.cn,
	shihua@iscas.ac.cn,
	jiawei@iscas.ac.cn,
	wuwei2016@iscas.ac.cn,
	drew@pdp7.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	ctsai390@andestech.com,
	wefu@redhat.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	josef@toxicpanda.com,
	dsterba@suse.com,
	mingo@redhat.com,
	peterz@infradead.org,
	boqun.feng@gmail.com,
	guoren@kernel.org,
	xiao.w.wang@intel.com,
	qingfang.deng@siflower.com.cn,
	leobras@redhat.com,
	jszhang@kernel.org,
	conor.dooley@microchip.com,
	samuel.holland@sifive.com,
	yongxuan.wang@sifive.com,
	luxu.kernel@bytedance.com,
	david@redhat.com,
	ruanjinjie@huawei.com,
	cuiyunhui@bytedance.com,
	wangkefeng.wang@huawei.com,
	qiaozhe@iscas.ac.cn
Cc: ardb@kernel.org,
	ast@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-mm@kvack.org,
	linux-crypto@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	maple-tree@lists.infradead.org,
	linux-trace-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-atm-general@lists.sourceforge.net,
	linux-btrfs@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	linux-nfs@vger.kernel.org,
	linux-sctp@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-media@vger.kernel.org
Subject: [RFC PATCH V3 04/43] rv64ilp32_abi: riscv: Introduce xlen_t to adapt __riscv_xlen != BITS_PER_LONG
Date: Tue, 25 Mar 2025 08:15:45 -0400
Message-Id: <20250325121624.523258-5-guoren@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250325121624.523258-1-guoren@kernel.org>
References: <20250325121624.523258-1-guoren@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Guo Ren (Alibaba DAMO Academy)" <guoren@kernel.org>

Upon RV64ILP32 ABI definition, BITS_PER_LONG couldn't determine
XLEN due to its 32-bit value when CONFIG_64BIT=y. Hence, we've
introduced xlen_t and utilized CONFIG_64BIT or __riscv_xlen == 64
to determine register width.

Signed-off-by: Guo Ren (Alibaba DAMO Academy) <guoren@kernel.org>
---
 arch/riscv/include/asm/checksum.h      |  4 ++
 arch/riscv/include/asm/csr.h           | 15 ++--
 arch/riscv/include/asm/processor.h     | 10 +--
 arch/riscv/include/asm/ptrace.h        | 92 ++++++++++++------------
 arch/riscv/include/asm/sparsemem.h     |  2 +-
 arch/riscv/include/asm/switch_to.h     |  4 +-
 arch/riscv/include/asm/thread_info.h   |  2 +-
 arch/riscv/include/asm/timex.h         |  4 +-
 arch/riscv/include/uapi/asm/elf.h      |  4 +-
 arch/riscv/include/uapi/asm/ptrace.h   | 97 ++++++++++++++------------
 arch/riscv/include/uapi/asm/ucontext.h |  7 +-
 arch/riscv/include/uapi/asm/unistd.h   |  2 +-
 arch/riscv/kernel/compat_signal.c      |  4 +-
 arch/riscv/kernel/process.c            |  8 +--
 arch/riscv/kernel/signal.c             |  4 +-
 arch/riscv/kernel/traps.c              |  4 +-
 arch/riscv/kernel/vector.c             |  2 +-
 arch/riscv/mm/fault.c                  |  2 +-
 18 files changed, 143 insertions(+), 124 deletions(-)

diff --git a/arch/riscv/include/asm/checksum.h b/arch/riscv/include/asm/checksum.h
index 88e6f1499e88..e887f0983b69 100644
--- a/arch/riscv/include/asm/checksum.h
+++ b/arch/riscv/include/asm/checksum.h
@@ -36,7 +36,11 @@ __sum16 csum_ipv6_magic(const struct in6_addr *saddr,
  */
 static inline __sum16 ip_fast_csum(const void *iph, unsigned int ihl)
 {
+#if __riscv_xlen == 64
+	unsigned long long csum = 0;
+#else
 	unsigned long csum = 0;
+#endif
 	int pos = 0;
 
 	do {
diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index 25f7c5afea3a..4339600e3c56 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -522,10 +522,11 @@
 #define IE_EIE		(_AC(0x1, UXL) << RV_IRQ_EXT)
 
 #ifndef __ASSEMBLY__
+#include <asm/ptrace.h>
 
 #define csr_swap(csr, val)					\
 ({								\
-	unsigned long __v = (unsigned long)(val);		\
+	xlen_t __v = (xlen_t)(val);				\
 	__asm__ __volatile__ ("csrrw %0, " __ASM_STR(csr) ", %1"\
 			      : "=r" (__v) : "rK" (__v)		\
 			      : "memory");			\
@@ -534,7 +535,7 @@
 
 #define csr_read(csr)						\
 ({								\
-	register unsigned long __v;				\
+	register xlen_t __v;					\
 	__asm__ __volatile__ ("csrr %0, " __ASM_STR(csr)	\
 			      : "=r" (__v) :			\
 			      : "memory");			\
@@ -543,7 +544,7 @@
 
 #define csr_write(csr, val)					\
 ({								\
-	unsigned long __v = (unsigned long)(val);		\
+	xlen_t __v = (xlen_t)(val);				\
 	__asm__ __volatile__ ("csrw " __ASM_STR(csr) ", %0"	\
 			      : : "rK" (__v)			\
 			      : "memory");			\
@@ -551,7 +552,7 @@
 
 #define csr_read_set(csr, val)					\
 ({								\
-	unsigned long __v = (unsigned long)(val);		\
+	xlen_t __v = (xlen_t)(val);				\
 	__asm__ __volatile__ ("csrrs %0, " __ASM_STR(csr) ", %1"\
 			      : "=r" (__v) : "rK" (__v)		\
 			      : "memory");			\
@@ -560,7 +561,7 @@
 
 #define csr_set(csr, val)					\
 ({								\
-	unsigned long __v = (unsigned long)(val);		\
+	xlen_t __v = (xlen_t)(val);				\
 	__asm__ __volatile__ ("csrs " __ASM_STR(csr) ", %0"	\
 			      : : "rK" (__v)			\
 			      : "memory");			\
@@ -568,7 +569,7 @@
 
 #define csr_read_clear(csr, val)				\
 ({								\
-	unsigned long __v = (unsigned long)(val);		\
+	xlen_t __v = (xlen_t)(val);				\
 	__asm__ __volatile__ ("csrrc %0, " __ASM_STR(csr) ", %1"\
 			      : "=r" (__v) : "rK" (__v)		\
 			      : "memory");			\
@@ -577,7 +578,7 @@
 
 #define csr_clear(csr, val)					\
 ({								\
-	unsigned long __v = (unsigned long)(val);		\
+	xlen_t __v = (xlen_t)(val);				\
 	__asm__ __volatile__ ("csrc " __ASM_STR(csr) ", %0"	\
 			      : : "rK" (__v)			\
 			      : "memory");			\
diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
index 5f56eb9d114a..ca57a650c3d2 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -45,7 +45,7 @@
  * This decides where the kernel will search for a free chunk of vm
  * space during mmap's.
  */
-#ifdef CONFIG_64BIT
+#if BITS_PER_LONG == 64
 #define TASK_UNMAPPED_BASE	PAGE_ALIGN((UL(1) << MMAP_MIN_VA_BITS) / 3)
 #else
 #define TASK_UNMAPPED_BASE	PAGE_ALIGN(TASK_SIZE / 3)
@@ -99,10 +99,10 @@ struct thread_struct {
 	/* Callee-saved registers */
 	unsigned long ra;
 	unsigned long sp;	/* Kernel mode stack */
-	unsigned long s[12];	/* s[0]: frame pointer */
+	xlen_t     s[12];	/* s[0]: frame pointer */
 	struct __riscv_d_ext_state fstate;
 	unsigned long bad_cause;
-	unsigned long envcfg;
+	xlen_t envcfg;
 	u32 riscv_v_flags;
 	u32 vstate_ctrl;
 	struct __riscv_v_ext_state vstate;
@@ -133,8 +133,8 @@ static inline void arch_thread_struct_whitelist(unsigned long *offset,
 	((struct pt_regs *)(task_stack_page(tsk) + THREAD_SIZE		\
 			    - ALIGN(sizeof(struct pt_regs), STACK_ALIGN)))
 
-#define KSTK_EIP(tsk)		(task_pt_regs(tsk)->epc)
-#define KSTK_ESP(tsk)		(task_pt_regs(tsk)->sp)
+#define KSTK_EIP(tsk)		(ulong)(task_pt_regs(tsk)->epc)
+#define KSTK_ESP(tsk)		(ulong)(task_pt_regs(tsk)->sp)
 
 
 /* Do necessary setup to start up a newly executed thread. */
diff --git a/arch/riscv/include/asm/ptrace.h b/arch/riscv/include/asm/ptrace.h
index b5b0adcc85c1..a0ed27c2346b 100644
--- a/arch/riscv/include/asm/ptrace.h
+++ b/arch/riscv/include/asm/ptrace.h
@@ -13,51 +13,51 @@
 #ifndef __ASSEMBLY__
 
 struct pt_regs {
-	unsigned long epc;
-	unsigned long ra;
-	unsigned long sp;
-	unsigned long gp;
-	unsigned long tp;
-	unsigned long t0;
-	unsigned long t1;
-	unsigned long t2;
-	unsigned long s0;
-	unsigned long s1;
-	unsigned long a0;
-	unsigned long a1;
-	unsigned long a2;
-	unsigned long a3;
-	unsigned long a4;
-	unsigned long a5;
-	unsigned long a6;
-	unsigned long a7;
-	unsigned long s2;
-	unsigned long s3;
-	unsigned long s4;
-	unsigned long s5;
-	unsigned long s6;
-	unsigned long s7;
-	unsigned long s8;
-	unsigned long s9;
-	unsigned long s10;
-	unsigned long s11;
-	unsigned long t3;
-	unsigned long t4;
-	unsigned long t5;
-	unsigned long t6;
+	xlen_t epc;
+	xlen_t ra;
+	xlen_t sp;
+	xlen_t gp;
+	xlen_t tp;
+	xlen_t t0;
+	xlen_t t1;
+	xlen_t t2;
+	xlen_t s0;
+	xlen_t s1;
+	xlen_t a0;
+	xlen_t a1;
+	xlen_t a2;
+	xlen_t a3;
+	xlen_t a4;
+	xlen_t a5;
+	xlen_t a6;
+	xlen_t a7;
+	xlen_t s2;
+	xlen_t s3;
+	xlen_t s4;
+	xlen_t s5;
+	xlen_t s6;
+	xlen_t s7;
+	xlen_t s8;
+	xlen_t s9;
+	xlen_t s10;
+	xlen_t s11;
+	xlen_t t3;
+	xlen_t t4;
+	xlen_t t5;
+	xlen_t t6;
 	/* Supervisor/Machine CSRs */
-	unsigned long status;
-	unsigned long badaddr;
-	unsigned long cause;
+	xlen_t status;
+	xlen_t badaddr;
+	xlen_t cause;
 	/* a0 value before the syscall */
-	unsigned long orig_a0;
+	xlen_t orig_a0;
 };
 
 #define PTRACE_SYSEMU			0x1f
 #define PTRACE_SYSEMU_SINGLESTEP	0x20
 
 #ifdef CONFIG_64BIT
-#define REG_FMT "%016lx"
+#define REG_FMT "%016llx"
 #else
 #define REG_FMT "%08lx"
 #endif
@@ -69,12 +69,12 @@ struct pt_regs {
 /* Helpers for working with the instruction pointer */
 static inline unsigned long instruction_pointer(struct pt_regs *regs)
 {
-	return regs->epc;
+	return (unsigned long)regs->epc;
 }
 static inline void instruction_pointer_set(struct pt_regs *regs,
 					   unsigned long val)
 {
-	regs->epc = val;
+	regs->epc = (xlen_t)val;
 }
 
 #define profile_pc(regs) instruction_pointer(regs)
@@ -82,40 +82,40 @@ static inline void instruction_pointer_set(struct pt_regs *regs,
 /* Helpers for working with the user stack pointer */
 static inline unsigned long user_stack_pointer(struct pt_regs *regs)
 {
-	return regs->sp;
+	return (unsigned long)regs->sp;
 }
 static inline void user_stack_pointer_set(struct pt_regs *regs,
 					  unsigned long val)
 {
-	regs->sp =  val;
+	regs->sp = (xlen_t)val;
 }
 
 /* Valid only for Kernel mode traps. */
 static inline unsigned long kernel_stack_pointer(struct pt_regs *regs)
 {
-	return regs->sp;
+	return (unsigned long)regs->sp;
 }
 
 /* Helpers for working with the frame pointer */
 static inline unsigned long frame_pointer(struct pt_regs *regs)
 {
-	return regs->s0;
+	return (unsigned long)regs->s0;
 }
 static inline void frame_pointer_set(struct pt_regs *regs,
 				     unsigned long val)
 {
-	regs->s0 = val;
+	regs->s0 = (xlen_t)val;
 }
 
 static inline unsigned long regs_return_value(struct pt_regs *regs)
 {
-	return regs->a0;
+	return (unsigned long)regs->a0;
 }
 
 static inline void regs_set_return_value(struct pt_regs *regs,
 					 unsigned long val)
 {
-	regs->a0 = val;
+	regs->a0 = (xlen_t)val;
 }
 
 extern int regs_query_register_offset(const char *name);
diff --git a/arch/riscv/include/asm/sparsemem.h b/arch/riscv/include/asm/sparsemem.h
index 2f901a410586..68907698caa6 100644
--- a/arch/riscv/include/asm/sparsemem.h
+++ b/arch/riscv/include/asm/sparsemem.h
@@ -4,7 +4,7 @@
 #define _ASM_RISCV_SPARSEMEM_H
 
 #ifdef CONFIG_SPARSEMEM
-#ifdef CONFIG_64BIT
+#if BITS_PER_LONG == 64
 #define MAX_PHYSMEM_BITS	56
 #else
 #define MAX_PHYSMEM_BITS	32
diff --git a/arch/riscv/include/asm/switch_to.h b/arch/riscv/include/asm/switch_to.h
index 0e71eb82f920..6d01b0fc5a25 100644
--- a/arch/riscv/include/asm/switch_to.h
+++ b/arch/riscv/include/asm/switch_to.h
@@ -71,9 +71,9 @@ static __always_inline bool has_fpu(void) { return false; }
 #endif
 
 static inline void envcfg_update_bits(struct task_struct *task,
-				      unsigned long mask, unsigned long val)
+				      xlen_t mask, xlen_t val)
 {
-	unsigned long envcfg;
+	xlen_t envcfg;
 
 	envcfg = (task->thread.envcfg & ~mask) | val;
 	task->thread.envcfg = envcfg;
diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/asm/thread_info.h
index f5916a70879a..637a46fc7ed8 100644
--- a/arch/riscv/include/asm/thread_info.h
+++ b/arch/riscv/include/asm/thread_info.h
@@ -71,7 +71,7 @@ struct thread_info {
 	 * Used in handle_exception() to save a0, a1 and a2 before knowing if we
 	 * can access the kernel stack.
 	 */
-	unsigned long		a0, a1, a2;
+	xlen_t		a0, a1, a2;
 #endif
 };
 
diff --git a/arch/riscv/include/asm/timex.h b/arch/riscv/include/asm/timex.h
index a06697846e69..b5ca67b30d0b 100644
--- a/arch/riscv/include/asm/timex.h
+++ b/arch/riscv/include/asm/timex.h
@@ -8,7 +8,7 @@
 
 #include <asm/csr.h>
 
-typedef unsigned long cycles_t;
+typedef xlen_t cycles_t;
 
 #ifdef CONFIG_RISCV_M_MODE
 
@@ -84,7 +84,7 @@ static inline u64 get_cycles64(void)
 #define ARCH_HAS_READ_CURRENT_TIMER
 static inline int read_current_timer(unsigned long *timer_val)
 {
-	*timer_val = get_cycles();
+	*timer_val = (unsigned long)get_cycles();
 	return 0;
 }
 
diff --git a/arch/riscv/include/uapi/asm/elf.h b/arch/riscv/include/uapi/asm/elf.h
index 11a71b8533d5..9fc8c2e3556b 100644
--- a/arch/riscv/include/uapi/asm/elf.h
+++ b/arch/riscv/include/uapi/asm/elf.h
@@ -15,7 +15,7 @@
 #include <asm/ptrace.h>
 
 /* ELF register definitions */
-typedef unsigned long elf_greg_t;
+typedef xlen_t elf_greg_t;
 typedef struct user_regs_struct elf_gregset_t;
 #define ELF_NGREG (sizeof(elf_gregset_t) / sizeof(elf_greg_t))
 
@@ -24,7 +24,7 @@ typedef __u64 elf_fpreg_t;
 typedef union __riscv_fp_state elf_fpregset_t;
 #define ELF_NFPREG (sizeof(struct __riscv_d_ext_state) / sizeof(elf_fpreg_t))
 
-#if __riscv_xlen == 64
+#if BITS_PER_LONG == 64
 #define ELF_RISCV_R_SYM(r_info)		ELF64_R_SYM(r_info)
 #define ELF_RISCV_R_TYPE(r_info)	ELF64_R_TYPE(r_info)
 #else
diff --git a/arch/riscv/include/uapi/asm/ptrace.h b/arch/riscv/include/uapi/asm/ptrace.h
index a38268b19c3d..f040a2ba07b0 100644
--- a/arch/riscv/include/uapi/asm/ptrace.h
+++ b/arch/riscv/include/uapi/asm/ptrace.h
@@ -15,6 +15,14 @@
 #define PTRACE_GETFDPIC_EXEC	0
 #define PTRACE_GETFDPIC_INTERP	1
 
+#if __riscv_xlen == 64
+typedef u64 xlen_t;
+#endif
+
+#if __riscv_xlen == 32
+typedef ulong xlen_t;
+#endif
+
 /*
  * User-mode register state for core dumps, ptrace, sigcontext
  *
@@ -22,38 +30,38 @@
  * struct user_regs_struct must form a prefix of struct pt_regs.
  */
 struct user_regs_struct {
-	unsigned long pc;
-	unsigned long ra;
-	unsigned long sp;
-	unsigned long gp;
-	unsigned long tp;
-	unsigned long t0;
-	unsigned long t1;
-	unsigned long t2;
-	unsigned long s0;
-	unsigned long s1;
-	unsigned long a0;
-	unsigned long a1;
-	unsigned long a2;
-	unsigned long a3;
-	unsigned long a4;
-	unsigned long a5;
-	unsigned long a6;
-	unsigned long a7;
-	unsigned long s2;
-	unsigned long s3;
-	unsigned long s4;
-	unsigned long s5;
-	unsigned long s6;
-	unsigned long s7;
-	unsigned long s8;
-	unsigned long s9;
-	unsigned long s10;
-	unsigned long s11;
-	unsigned long t3;
-	unsigned long t4;
-	unsigned long t5;
-	unsigned long t6;
+	xlen_t pc;
+	xlen_t ra;
+	xlen_t sp;
+	xlen_t gp;
+	xlen_t tp;
+	xlen_t t0;
+	xlen_t t1;
+	xlen_t t2;
+	xlen_t s0;
+	xlen_t s1;
+	xlen_t a0;
+	xlen_t a1;
+	xlen_t a2;
+	xlen_t a3;
+	xlen_t a4;
+	xlen_t a5;
+	xlen_t a6;
+	xlen_t a7;
+	xlen_t s2;
+	xlen_t s3;
+	xlen_t s4;
+	xlen_t s5;
+	xlen_t s6;
+	xlen_t s7;
+	xlen_t s8;
+	xlen_t s9;
+	xlen_t s10;
+	xlen_t s11;
+	xlen_t t3;
+	xlen_t t4;
+	xlen_t t5;
+	xlen_t t6;
 };
 
 struct __riscv_f_ext_state {
@@ -98,12 +106,15 @@ union __riscv_fp_state {
 };
 
 struct __riscv_v_ext_state {
-	unsigned long vstart;
-	unsigned long vl;
-	unsigned long vtype;
-	unsigned long vcsr;
-	unsigned long vlenb;
-	void *datap;
+	xlen_t vstart;
+	xlen_t vl;
+	xlen_t vtype;
+	xlen_t vcsr;
+	xlen_t vlenb;
+	union {
+		void *datap;
+		xlen_t pad;
+	};
 	/*
 	 * In signal handler, datap will be set a correct user stack offset
 	 * and vector registers will be copied to the address of datap
@@ -112,11 +123,11 @@ struct __riscv_v_ext_state {
 };
 
 struct __riscv_v_regset_state {
-	unsigned long vstart;
-	unsigned long vl;
-	unsigned long vtype;
-	unsigned long vcsr;
-	unsigned long vlenb;
+	xlen_t vstart;
+	xlen_t vl;
+	xlen_t vtype;
+	xlen_t vcsr;
+	xlen_t vlenb;
 	char vreg[];
 };
 
diff --git a/arch/riscv/include/uapi/asm/ucontext.h b/arch/riscv/include/uapi/asm/ucontext.h
index 516bd0bb0da5..572b96c3ccf4 100644
--- a/arch/riscv/include/uapi/asm/ucontext.h
+++ b/arch/riscv/include/uapi/asm/ucontext.h
@@ -11,8 +11,11 @@
 #include <linux/types.h>
 
 struct ucontext {
-	unsigned long	  uc_flags;
-	struct ucontext	 *uc_link;
+	xlen_t		  uc_flags;
+	union {
+		struct ucontext	 *uc_link;
+		xlen_t		 pad;
+	};
 	stack_t		  uc_stack;
 	sigset_t	  uc_sigmask;
 	/*
diff --git a/arch/riscv/include/uapi/asm/unistd.h b/arch/riscv/include/uapi/asm/unistd.h
index 81896bbbf727..e33dd5161b8d 100644
--- a/arch/riscv/include/uapi/asm/unistd.h
+++ b/arch/riscv/include/uapi/asm/unistd.h
@@ -16,7 +16,7 @@
  */
 #include <asm/bitsperlong.h>
 
-#if __BITS_PER_LONG == 64
+#if __riscv_xlen == 64
 #include <asm/unistd_64.h>
 #else
 #include <asm/unistd_32.h>
diff --git a/arch/riscv/kernel/compat_signal.c b/arch/riscv/kernel/compat_signal.c
index 6ec4e34255a9..859104618f34 100644
--- a/arch/riscv/kernel/compat_signal.c
+++ b/arch/riscv/kernel/compat_signal.c
@@ -126,7 +126,7 @@ COMPAT_SYSCALL_DEFINE0(rt_sigreturn)
 	/* Always make any pending restarted system calls return -EINTR */
 	current->restart_block.fn = do_no_restart_syscall;
 
-	frame = (struct compat_rt_sigframe __user *)regs->sp;
+	frame = (struct compat_rt_sigframe __user *)(ulong)regs->sp;
 
 	if (!access_ok(frame, sizeof(*frame)))
 		goto badframe;
@@ -150,7 +150,7 @@ COMPAT_SYSCALL_DEFINE0(rt_sigreturn)
 		pr_info_ratelimited(
 			"%s[%d]: bad frame in %s: frame=%p pc=%p sp=%p\n",
 			task->comm, task_pid_nr(task), __func__,
-			frame, (void *)regs->epc, (void *)regs->sp);
+			frame, (void *)(ulong)regs->epc, (void *)(ulong)regs->sp);
 	}
 	force_sig(SIGSEGV);
 	return 0;
diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index 7c244de77180..5c827761f84b 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -65,8 +65,8 @@ void __show_regs(struct pt_regs *regs)
 	show_regs_print_info(KERN_DEFAULT);
 
 	if (!user_mode(regs)) {
-		pr_cont("epc : %pS\n", (void *)regs->epc);
-		pr_cont(" ra : %pS\n", (void *)regs->ra);
+		pr_cont("epc : %pS\n", (void *)(ulong)regs->epc);
+		pr_cont(" ra : %pS\n", (void *)(ulong)regs->ra);
 	}
 
 	pr_cont("epc : " REG_FMT " ra : " REG_FMT " sp : " REG_FMT "\n",
@@ -272,7 +272,7 @@ long set_tagged_addr_ctrl(struct task_struct *task, unsigned long arg)
 	unsigned long valid_mask = PR_PMLEN_MASK | PR_TAGGED_ADDR_ENABLE;
 	struct thread_info *ti = task_thread_info(task);
 	struct mm_struct *mm = task->mm;
-	unsigned long pmm;
+	xlen_t pmm;
 	u8 pmlen;
 
 	if (is_compat_thread(ti))
@@ -352,7 +352,7 @@ long get_tagged_addr_ctrl(struct task_struct *task)
 	return ret;
 }
 
-static bool try_to_set_pmm(unsigned long value)
+static bool try_to_set_pmm(xlen_t value)
 {
 	csr_set(CSR_ENVCFG, value);
 	return (csr_read_clear(CSR_ENVCFG, ENVCFG_PMM) & ENVCFG_PMM) == value;
diff --git a/arch/riscv/kernel/signal.c b/arch/riscv/kernel/signal.c
index 94e905eea1de..b3eb4154faf7 100644
--- a/arch/riscv/kernel/signal.c
+++ b/arch/riscv/kernel/signal.c
@@ -239,7 +239,7 @@ SYSCALL_DEFINE0(rt_sigreturn)
 	/* Always make any pending restarted system calls return -EINTR */
 	current->restart_block.fn = do_no_restart_syscall;
 
-	frame = (struct rt_sigframe __user *)regs->sp;
+	frame = (struct rt_sigframe __user *)(ulong)regs->sp;
 
 	if (!access_ok(frame, frame_size))
 		goto badframe;
@@ -265,7 +265,7 @@ SYSCALL_DEFINE0(rt_sigreturn)
 		pr_info_ratelimited(
 			"%s[%d]: bad frame in %s: frame=%p pc=%p sp=%p\n",
 			task->comm, task_pid_nr(task), __func__,
-			frame, (void *)regs->epc, (void *)regs->sp);
+			frame, (void *)(ulong)regs->epc, (void *)(ulong)regs->sp);
 	}
 	force_sig(SIGSEGV);
 	return 0;
diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index 8ff8e8b36524..1fada4c7ddfa 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -118,7 +118,7 @@ void do_trap(struct pt_regs *regs, int signo, int code, unsigned long addr)
 	if (show_unhandled_signals && unhandled_signal(tsk, signo)
 	    && printk_ratelimit()) {
 		pr_info("%s[%d]: unhandled signal %d code 0x%x at 0x" REG_FMT,
-			tsk->comm, task_pid_nr(tsk), signo, code, addr);
+			tsk->comm, task_pid_nr(tsk), signo, code, (xlen_t)addr);
 		print_vma_addr(KERN_CONT " in ", instruction_pointer(regs));
 		pr_cont("\n");
 		__show_regs(regs);
@@ -281,7 +281,7 @@ void handle_break(struct pt_regs *regs)
 	current->thread.bad_cause = regs->cause;
 
 	if (user_mode(regs))
-		force_sig_fault(SIGTRAP, TRAP_BRKPT, (void __user *)regs->epc);
+		force_sig_fault(SIGTRAP, TRAP_BRKPT, (void __user *)instruction_pointer(regs));
 #ifdef CONFIG_KGDB
 	else if (notify_die(DIE_TRAP, "EBREAK", regs, 0, regs->cause, SIGTRAP)
 								== NOTIFY_STOP)
diff --git a/arch/riscv/kernel/vector.c b/arch/riscv/kernel/vector.c
index 184f780c932d..884edd99e6b0 100644
--- a/arch/riscv/kernel/vector.c
+++ b/arch/riscv/kernel/vector.c
@@ -180,7 +180,7 @@ EXPORT_SYMBOL_GPL(riscv_v_vstate_ctrl_user_allowed);
 
 bool riscv_v_first_use_handler(struct pt_regs *regs)
 {
-	u32 __user *epc = (u32 __user *)regs->epc;
+	u32 __user *epc = (u32 __user *)(ulong)regs->epc;
 	u32 insn = (u32)regs->badaddr;
 
 	if (!(has_vector() || has_xtheadvector()))
diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
index 0194324a0c50..fcc23350610e 100644
--- a/arch/riscv/mm/fault.c
+++ b/arch/riscv/mm/fault.c
@@ -78,7 +78,7 @@ static void die_kernel_fault(const char *msg, unsigned long addr,
 {
 	bust_spinlocks(1);
 
-	pr_alert("Unable to handle kernel %s at virtual address " REG_FMT "\n", msg,
+	pr_alert("Unable to handle kernel %s at virtual address %08lx\n", msg,
 		addr);
 
 	bust_spinlocks(0);
-- 
2.40.1


