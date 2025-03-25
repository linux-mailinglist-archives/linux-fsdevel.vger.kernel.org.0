Return-Path: <linux-fsdevel+bounces-44967-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D30A6FBAC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 13:29:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D05D5172421
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 12:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3522264629;
	Tue, 25 Mar 2025 12:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Av1iWZ11"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F7C1531C5;
	Tue, 25 Mar 2025 12:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742905137; cv=none; b=n0B1337E7y+I1P6O3E1qGFAy4+c0MzkLnYcXAsvlsHARrtj7dCC6BBUYIsLPFhSFdnh7MLJX4nT5G4tPURnzEh8AcU0mRSHovKGRdXEGMDUKbkQNk7da+AcbsNmjw8BuEqZX77TRS92gt/enRyVJ+BO9VGwFiToyrjZUjQFNhjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742905137; c=relaxed/simple;
	bh=CkHSnvK7MIdZ92ELdn81bKYc+IanecbF+EpzeS9eHgE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ey2BljTHrNk38SWIWw4SAlaFUbJy4knR0C1mOhOMKscJF0tbHZqHSNwl6uRFRdiKdevE9e88O5Oi8ir/vBBnviogi1Y0aOL/1C3ELcR8LNGo/ycOgTmxkSySrq4EjOKDHKHehtxYGp8G7Sg0UlfyLMgUPLIxMhJLbZ6qoWqL/B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Av1iWZ11; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86390C4CEE9;
	Tue, 25 Mar 2025 12:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742905136;
	bh=CkHSnvK7MIdZ92ELdn81bKYc+IanecbF+EpzeS9eHgE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Av1iWZ11H8OzWTpyQcaIUWDHae7LxA08a0FAeGsTT0s3iZgbkbcvAiqA4Rq0Xet5j
	 2+nlUrRJn1Vdt4iPov5qd9QlPxivEDsvOF5iUx9h8lOhYO9d47s7kHGa++wrFLVQww
	 53MRjEzXHEO+oKZMkSTWTYqHIQtTZyJhdAOmn6ZL1My7/G6jgIBZEKrbYJVnm5oCxa
	 /DbU6+44emZ6CpsPev+uHgQN0R65JAVjtBDYAeDCA2qNPLdBL72n5vY6OzwaN5WDP0
	 mgLrQoaZyBOPAzgJfO6fikBN77EJGRFL39+NYHrRa8zWigK//5KeYsOg84YR6W6DN2
	 W8PIgwH1HOLeQ==
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
Subject: [RFC PATCH V3 09/43] rv64ilp32_abi: riscv: Reuse LP64 SBI interface
Date: Tue, 25 Mar 2025 08:15:50 -0400
Message-Id: <20250325121624.523258-10-guoren@kernel.org>
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

The RV64ILP32 ABI leverages the LP64 SBI interface, enabling the
RV64ILP32 Linux kernel to run seamlessly on LP64 OpenSBI or KVM.
Using RV64ILP32 Linux doesn't require changing the bootloader,
firmware, or hypervisor; it could replace the LP64 kernel directly.

Signed-off-by: Guo Ren (Alibaba DAMO Academy) <guoren@kernel.org>
---
 arch/riscv/include/asm/cpu_ops_sbi.h |  4 ++--
 arch/riscv/include/asm/sbi.h         | 22 +++++++++++-----------
 arch/riscv/kernel/cpu_ops_sbi.c      |  4 ++--
 arch/riscv/kernel/sbi_ecall.c        | 22 +++++++++++-----------
 4 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/arch/riscv/include/asm/cpu_ops_sbi.h b/arch/riscv/include/asm/cpu_ops_sbi.h
index d6e4665b3195..d967adad6b48 100644
--- a/arch/riscv/include/asm/cpu_ops_sbi.h
+++ b/arch/riscv/include/asm/cpu_ops_sbi.h
@@ -19,8 +19,8 @@ extern const struct cpu_operations cpu_ops_sbi;
  * @stack_ptr: A pointer to the hart specific sp
  */
 struct sbi_hart_boot_data {
-	void *task_ptr;
-	void *stack_ptr;
+	xlen_t task_ptr;
+	xlen_t stack_ptr;
 };
 #endif
 
diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index 3d250824178b..fd9a9c723ec6 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -138,16 +138,16 @@ enum sbi_ext_pmu_fid {
 };
 
 union sbi_pmu_ctr_info {
-	unsigned long value;
+	xlen_t value;
 	struct {
-		unsigned long csr:12;
-		unsigned long width:6;
+		xlen_t csr:12;
+		xlen_t width:6;
 #if __riscv_xlen == 32
-		unsigned long reserved:13;
+		xlen_t reserved:13;
 #else
-		unsigned long reserved:45;
+		xlen_t reserved:45;
 #endif
-		unsigned long type:1;
+		xlen_t type:1;
 	};
 };
 
@@ -422,15 +422,15 @@ enum sbi_ext_nacl_feature {
 
 extern unsigned long sbi_spec_version;
 struct sbiret {
-	long error;
-	long value;
+	xlen_t error;
+	xlen_t value;
 };
 
 void sbi_init(void);
 long __sbi_base_ecall(int fid);
-struct sbiret __sbi_ecall(unsigned long arg0, unsigned long arg1,
-			  unsigned long arg2, unsigned long arg3,
-			  unsigned long arg4, unsigned long arg5,
+struct sbiret __sbi_ecall(xlen_t arg0, xlen_t arg1,
+			  xlen_t arg2, xlen_t arg3,
+			  xlen_t arg4, xlen_t arg5,
 			  int fid, int ext);
 #define sbi_ecall(e, f, a0, a1, a2, a3, a4, a5)	\
 		__sbi_ecall(a0, a1, a2, a3, a4, a5, f, e)
diff --git a/arch/riscv/kernel/cpu_ops_sbi.c b/arch/riscv/kernel/cpu_ops_sbi.c
index e6fbaaf54956..f9ef3c0155f4 100644
--- a/arch/riscv/kernel/cpu_ops_sbi.c
+++ b/arch/riscv/kernel/cpu_ops_sbi.c
@@ -71,8 +71,8 @@ static int sbi_cpu_start(unsigned int cpuid, struct task_struct *tidle)
 
 	/* Make sure tidle is updated */
 	smp_mb();
-	bdata->task_ptr = tidle;
-	bdata->stack_ptr = task_pt_regs(tidle);
+	bdata->task_ptr = (ulong)tidle;
+	bdata->stack_ptr = (ulong)task_pt_regs(tidle);
 	/* Make sure boot data is updated */
 	smp_mb();
 	hsm_data = __pa(bdata);
diff --git a/arch/riscv/kernel/sbi_ecall.c b/arch/riscv/kernel/sbi_ecall.c
index 24aabb4fbde3..ee22e69d70da 100644
--- a/arch/riscv/kernel/sbi_ecall.c
+++ b/arch/riscv/kernel/sbi_ecall.c
@@ -17,23 +17,23 @@ long __sbi_base_ecall(int fid)
 }
 EXPORT_SYMBOL(__sbi_base_ecall);
 
-struct sbiret __sbi_ecall(unsigned long arg0, unsigned long arg1,
-			  unsigned long arg2, unsigned long arg3,
-			  unsigned long arg4, unsigned long arg5,
+struct sbiret __sbi_ecall(xlen_t arg0, xlen_t arg1,
+			  xlen_t arg2, xlen_t arg3,
+			  xlen_t arg4, xlen_t arg5,
 			  int fid, int ext)
 {
 	struct sbiret ret;
 
 	trace_sbi_call(ext, fid);
 
-	register uintptr_t a0 asm ("a0") = (uintptr_t)(arg0);
-	register uintptr_t a1 asm ("a1") = (uintptr_t)(arg1);
-	register uintptr_t a2 asm ("a2") = (uintptr_t)(arg2);
-	register uintptr_t a3 asm ("a3") = (uintptr_t)(arg3);
-	register uintptr_t a4 asm ("a4") = (uintptr_t)(arg4);
-	register uintptr_t a5 asm ("a5") = (uintptr_t)(arg5);
-	register uintptr_t a6 asm ("a6") = (uintptr_t)(fid);
-	register uintptr_t a7 asm ("a7") = (uintptr_t)(ext);
+	register xlen_t a0 asm ("a0") = (xlen_t)(arg0);
+	register xlen_t a1 asm ("a1") = (xlen_t)(arg1);
+	register xlen_t a2 asm ("a2") = (xlen_t)(arg2);
+	register xlen_t a3 asm ("a3") = (xlen_t)(arg3);
+	register xlen_t a4 asm ("a4") = (xlen_t)(arg4);
+	register xlen_t a5 asm ("a5") = (xlen_t)(arg5);
+	register xlen_t a6 asm ("a6") = (xlen_t)(fid);
+	register xlen_t a7 asm ("a7") = (xlen_t)(ext);
 	asm volatile ("ecall"
 		       : "+r" (a0), "+r" (a1)
 		       : "r" (a2), "r" (a3), "r" (a4), "r" (a5), "r" (a6), "r" (a7)
-- 
2.40.1


