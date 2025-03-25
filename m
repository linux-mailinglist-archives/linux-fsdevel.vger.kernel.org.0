Return-Path: <linux-fsdevel+bounces-44961-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3CE9A6FB27
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 13:22:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7524B1893E6A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 12:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A87C625A341;
	Tue, 25 Mar 2025 12:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n6JUqLMB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9801D255E30;
	Tue, 25 Mar 2025 12:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742905052; cv=none; b=VqnJslXjAGh7doPNNin78w3p3GAXx0PmVJ5N+wAVJMDXLgPWqcttJGCyuHTY8BbEcfc51NOzb8w2wg3iGnLSBIAkBHjNzVl9wE4005Lb9HHo9z44KJ0zt2Nes55Ysqh4abe41A2acAteriNAsuhTBTgpFW4ZkfJJTw/lWKj+UQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742905052; c=relaxed/simple;
	bh=sO/4TmRmKfk2dnjl/JmxjrPBB7D8Gm9kLR/52IOrXMs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M0Ysbb4IjIbDYXf+MDAHFjSRMrTNvgIicDhTBMkKOJwFgqU8DPOv7GvJRlbU2UczV3cShsLBQQVM0MTqln+W5R9vRkqU582KKX59qsrSiuTnWbcQGc1d4l9d1gshkJ3rUZgl4ev87WE6xMMmp9y/S10M5hEV5y9HgjuDhON5c9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n6JUqLMB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD08FC4CEE4;
	Tue, 25 Mar 2025 12:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742905052;
	bh=sO/4TmRmKfk2dnjl/JmxjrPBB7D8Gm9kLR/52IOrXMs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n6JUqLMBxN4FBEHCbynRZjyxbbHmfrT5dxslTK0O3f8vBGbwHrHPoAtr3cjfIT9vB
	 PnwhhDUr7ermUkudpqYOZubBzBdljrQtK5DKzFPMtICLWxJ/Sj+2jwOCuD6Vumvr9b
	 OdXacg+BUJ2VRmU+NwKaPI4trgLD+nYEaVDWz/YZRbboklBXdDwxhicYic5GPR2jsb
	 +EIh1oKbAFjAYygDkGblRb1w9cnydYm8h6jUrJ7oXklmwSV5ILl+WT9Thtr5fwygP4
	 0xruPUpzD8LuQBpXkD4MKTLY+4Jz8Tblf/1Et8uFRxeRDK5g1P0oLHvNz0mk3izFQY
	 QZPBh4eIRz7pQ==
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
Subject: [RFC PATCH V3 03/43] rv64ilp32_abi: riscv: Adapt ULL & UL definition
Date: Tue, 25 Mar 2025 08:15:44 -0400
Message-Id: <20250325121624.523258-4-guoren@kernel.org>
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

On 64-bit systems with ILP32 ABI, BITS_PER_LONG is 32, making the
register width different from UL's. Thus, correct them into ULL.

Signed-off-by: Guo Ren (Alibaba DAMO Academy) <guoren@kernel.org>
---
 arch/riscv/include/asm/cmpxchg.h |   4 +-
 arch/riscv/include/asm/csr.h     | 212 ++++++++++++++++---------------
 arch/riscv/net/bpf_jit_comp64.c  |   6 +-
 3 files changed, 115 insertions(+), 107 deletions(-)

diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
index 4cadc56220fe..938d50194dba 100644
--- a/arch/riscv/include/asm/cmpxchg.h
+++ b/arch/riscv/include/asm/cmpxchg.h
@@ -29,7 +29,7 @@
 	} else {								\
 		u32 *__ptr32b = (u32 *)((ulong)(p) & ~0x3);			\
 		ulong __s = ((ulong)(p) & (0x4 - sizeof(*p))) * BITS_PER_BYTE;	\
-		ulong __mask = GENMASK(((sizeof(*p)) * BITS_PER_BYTE) - 1, 0)	\
+		ulong __mask = GENMASK_ULL(((sizeof(*p)) * BITS_PER_BYTE) - 1, 0)	\
 				<< __s;						\
 		ulong __newx = (ulong)(n) << __s;				\
 		ulong __retx;							\
@@ -145,7 +145,7 @@
 	} else {								\
 		u32 *__ptr32b = (u32 *)((ulong)(p) & ~0x3);			\
 		ulong __s = ((ulong)(p) & (0x4 - sizeof(*p))) * BITS_PER_BYTE;	\
-		ulong __mask = GENMASK(((sizeof(*p)) * BITS_PER_BYTE) - 1, 0)	\
+		ulong __mask = GENMASK_ULL(((sizeof(*p)) * BITS_PER_BYTE) - 1, 0)	\
 			       << __s;						\
 		ulong __newx = (ulong)(n) << __s;				\
 		ulong __oldx = (ulong)(o) << __s;				\
diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index 6fed42e37705..25f7c5afea3a 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -9,74 +9,82 @@
 #include <asm/asm.h>
 #include <linux/bits.h>
 
+#if __riscv_xlen == 64
+#define UXL		ULL
+#define GENMASK_UXL	GENMASK_ULL
+#else
+#define UXL		UL
+#define GENMASK_UXL	GENMASK
+#endif
+
 /* Status register flags */
-#define SR_SIE		_AC(0x00000002, UL) /* Supervisor Interrupt Enable */
-#define SR_MIE		_AC(0x00000008, UL) /* Machine Interrupt Enable */
-#define SR_SPIE		_AC(0x00000020, UL) /* Previous Supervisor IE */
-#define SR_MPIE		_AC(0x00000080, UL) /* Previous Machine IE */
-#define SR_SPP		_AC(0x00000100, UL) /* Previously Supervisor */
-#define SR_MPP		_AC(0x00001800, UL) /* Previously Machine */
-#define SR_SUM		_AC(0x00040000, UL) /* Supervisor User Memory Access */
-
-#define SR_FS		_AC(0x00006000, UL) /* Floating-point Status */
-#define SR_FS_OFF	_AC(0x00000000, UL)
-#define SR_FS_INITIAL	_AC(0x00002000, UL)
-#define SR_FS_CLEAN	_AC(0x00004000, UL)
-#define SR_FS_DIRTY	_AC(0x00006000, UL)
-
-#define SR_VS		_AC(0x00000600, UL) /* Vector Status */
-#define SR_VS_OFF	_AC(0x00000000, UL)
-#define SR_VS_INITIAL	_AC(0x00000200, UL)
-#define SR_VS_CLEAN	_AC(0x00000400, UL)
-#define SR_VS_DIRTY	_AC(0x00000600, UL)
-
-#define SR_VS_THEAD		_AC(0x01800000, UL) /* xtheadvector Status */
-#define SR_VS_OFF_THEAD		_AC(0x00000000, UL)
-#define SR_VS_INITIAL_THEAD	_AC(0x00800000, UL)
-#define SR_VS_CLEAN_THEAD	_AC(0x01000000, UL)
-#define SR_VS_DIRTY_THEAD	_AC(0x01800000, UL)
-
-#define SR_XS		_AC(0x00018000, UL) /* Extension Status */
-#define SR_XS_OFF	_AC(0x00000000, UL)
-#define SR_XS_INITIAL	_AC(0x00008000, UL)
-#define SR_XS_CLEAN	_AC(0x00010000, UL)
-#define SR_XS_DIRTY	_AC(0x00018000, UL)
+#define SR_SIE		_AC(0x00000002, UXL) /* Supervisor Interrupt Enable */
+#define SR_MIE		_AC(0x00000008, UXL) /* Machine Interrupt Enable */
+#define SR_SPIE		_AC(0x00000020, UXL) /* Previous Supervisor IE */
+#define SR_MPIE		_AC(0x00000080, UXL) /* Previous Machine IE */
+#define SR_SPP		_AC(0x00000100, UXL) /* Previously Supervisor */
+#define SR_MPP		_AC(0x00001800, UXL) /* Previously Machine */
+#define SR_SUM		_AC(0x00040000, UXL) /* Supervisor User Memory Access */
+
+#define SR_FS		_AC(0x00006000, UXL) /* Floating-point Status */
+#define SR_FS_OFF	_AC(0x00000000, UXL)
+#define SR_FS_INITIAL	_AC(0x00002000, UXL)
+#define SR_FS_CLEAN	_AC(0x00004000, UXL)
+#define SR_FS_DIRTY	_AC(0x00006000, UXL)
+
+#define SR_VS		_AC(0x00000600, UXL) /* Vector Status */
+#define SR_VS_OFF	_AC(0x00000000, UXL)
+#define SR_VS_INITIAL	_AC(0x00000200, UXL)
+#define SR_VS_CLEAN	_AC(0x00000400, UXL)
+#define SR_VS_DIRTY	_AC(0x00000600, UXL)
+
+#define SR_VS_THEAD		_AC(0x01800000, UXL) /* xtheadvector Status */
+#define SR_VS_OFF_THEAD		_AC(0x00000000, UXL)
+#define SR_VS_INITIAL_THEAD	_AC(0x00800000, UXL)
+#define SR_VS_CLEAN_THEAD	_AC(0x01000000, UXL)
+#define SR_VS_DIRTY_THEAD	_AC(0x01800000, UXL)
+
+#define SR_XS		_AC(0x00018000, UXL) /* Extension Status */
+#define SR_XS_OFF	_AC(0x00000000, UXL)
+#define SR_XS_INITIAL	_AC(0x00008000, UXL)
+#define SR_XS_CLEAN	_AC(0x00010000, UXL)
+#define SR_XS_DIRTY	_AC(0x00018000, UXL)
 
 #define SR_FS_VS	(SR_FS | SR_VS) /* Vector and Floating-Point Unit */
 
-#ifndef CONFIG_64BIT
-#define SR_SD		_AC(0x80000000, UL) /* FS/VS/XS dirty */
+#if __riscv_xlen == 32
+#define SR_SD		_AC(0x80000000, UXL) /* FS/VS/XS dirty */
 #else
-#define SR_SD		_AC(0x8000000000000000, UL) /* FS/VS/XS dirty */
+#define SR_SD		_AC(0x8000000000000000, UXL) /* FS/VS/XS dirty */
 #endif
 
-#ifdef CONFIG_64BIT
-#define SR_UXL		_AC(0x300000000, UL) /* XLEN mask for U-mode */
-#define SR_UXL_32	_AC(0x100000000, UL) /* XLEN = 32 for U-mode */
-#define SR_UXL_64	_AC(0x200000000, UL) /* XLEN = 64 for U-mode */
+#if __riscv_xlen == 64
+#define SR_UXL		_AC(0x300000000, UXL) /* XLEN mask for U-mode */
+#define SR_UXL_32	_AC(0x100000000, UXL) /* XLEN = 32 for U-mode */
+#define SR_UXL_64	_AC(0x200000000, UXL) /* XLEN = 64 for U-mode */
 #endif
 
 /* SATP flags */
-#ifndef CONFIG_64BIT
-#define SATP_PPN	_AC(0x003FFFFF, UL)
-#define SATP_MODE_32	_AC(0x80000000, UL)
+#if __riscv_xlen == 32
+#define SATP_PPN	_AC(0x003FFFFF, UXL)
+#define SATP_MODE_32	_AC(0x80000000, UXL)
 #define SATP_MODE_SHIFT	31
 #define SATP_ASID_BITS	9
 #define SATP_ASID_SHIFT	22
-#define SATP_ASID_MASK	_AC(0x1FF, UL)
+#define SATP_ASID_MASK	_AC(0x1FF, UXL)
 #else
-#define SATP_PPN	_AC(0x00000FFFFFFFFFFF, UL)
-#define SATP_MODE_39	_AC(0x8000000000000000, UL)
-#define SATP_MODE_48	_AC(0x9000000000000000, UL)
-#define SATP_MODE_57	_AC(0xa000000000000000, UL)
+#define SATP_PPN	_AC(0x00000FFFFFFFFFFF, UXL)
+#define SATP_MODE_39	_AC(0x8000000000000000, UXL)
+#define SATP_MODE_48	_AC(0x9000000000000000, UXL)
+#define SATP_MODE_57	_AC(0xa000000000000000, UXL)
 #define SATP_MODE_SHIFT	60
 #define SATP_ASID_BITS	16
 #define SATP_ASID_SHIFT	44
-#define SATP_ASID_MASK	_AC(0xFFFF, UL)
+#define SATP_ASID_MASK	_AC(0xFFFF, UXL)
 #endif
 
 /* Exception cause high bit - is an interrupt if set */
-#define CAUSE_IRQ_FLAG		(_AC(1, UL) << (__riscv_xlen - 1))
+#define CAUSE_IRQ_FLAG		(_AC(1, UXL) << (__riscv_xlen - 1))
 
 /* Interrupt causes (minus the high bit) */
 #define IRQ_S_SOFT		1
@@ -91,7 +99,7 @@
 #define IRQ_S_GEXT		12
 #define IRQ_PMU_OVF		13
 #define IRQ_LOCAL_MAX		(IRQ_PMU_OVF + 1)
-#define IRQ_LOCAL_MASK		GENMASK((IRQ_LOCAL_MAX - 1), 0)
+#define IRQ_LOCAL_MASK		GENMASK_UXL((IRQ_LOCAL_MAX - 1), 0)
 
 /* Exception causes */
 #define EXC_INST_MISALIGNED	0
@@ -124,45 +132,45 @@
 #define PMP_L			0x80
 
 /* HSTATUS flags */
-#ifdef CONFIG_64BIT
-#define HSTATUS_HUPMM		_AC(0x3000000000000, UL)
-#define HSTATUS_HUPMM_PMLEN_0	_AC(0x0000000000000, UL)
-#define HSTATUS_HUPMM_PMLEN_7	_AC(0x2000000000000, UL)
-#define HSTATUS_HUPMM_PMLEN_16	_AC(0x3000000000000, UL)
-#define HSTATUS_VSXL		_AC(0x300000000, UL)
+#if __riscv_xlen == 64
+#define HSTATUS_HUPMM		_AC(0x3000000000000, UXL)
+#define HSTATUS_HUPMM_PMLEN_0	_AC(0x0000000000000, UXL)
+#define HSTATUS_HUPMM_PMLEN_7	_AC(0x2000000000000, UXL)
+#define HSTATUS_HUPMM_PMLEN_16	_AC(0x3000000000000, UXL)
+#define HSTATUS_VSXL		_AC(0x300000000, UXL)
 #define HSTATUS_VSXL_SHIFT	32
 #endif
-#define HSTATUS_VTSR		_AC(0x00400000, UL)
-#define HSTATUS_VTW		_AC(0x00200000, UL)
-#define HSTATUS_VTVM		_AC(0x00100000, UL)
-#define HSTATUS_VGEIN		_AC(0x0003f000, UL)
+#define HSTATUS_VTSR		_AC(0x00400000, UXL)
+#define HSTATUS_VTW		_AC(0x00200000, UXL)
+#define HSTATUS_VTVM		_AC(0x00100000, UXL)
+#define HSTATUS_VGEIN		_AC(0x0003f000, UXL)
 #define HSTATUS_VGEIN_SHIFT	12
-#define HSTATUS_HU		_AC(0x00000200, UL)
-#define HSTATUS_SPVP		_AC(0x00000100, UL)
-#define HSTATUS_SPV		_AC(0x00000080, UL)
-#define HSTATUS_GVA		_AC(0x00000040, UL)
-#define HSTATUS_VSBE		_AC(0x00000020, UL)
+#define HSTATUS_HU		_AC(0x00000200, UXL)
+#define HSTATUS_SPVP		_AC(0x00000100, UXL)
+#define HSTATUS_SPV		_AC(0x00000080, UXL)
+#define HSTATUS_GVA		_AC(0x00000040, UXL)
+#define HSTATUS_VSBE		_AC(0x00000020, UXL)
 
 /* HGATP flags */
-#define HGATP_MODE_OFF		_AC(0, UL)
-#define HGATP_MODE_SV32X4	_AC(1, UL)
-#define HGATP_MODE_SV39X4	_AC(8, UL)
-#define HGATP_MODE_SV48X4	_AC(9, UL)
-#define HGATP_MODE_SV57X4	_AC(10, UL)
+#define HGATP_MODE_OFF		_AC(0, UXL)
+#define HGATP_MODE_SV32X4	_AC(1, UXL)
+#define HGATP_MODE_SV39X4	_AC(8, UXL)
+#define HGATP_MODE_SV48X4	_AC(9, UXL)
+#define HGATP_MODE_SV57X4	_AC(10, UXL)
 
 #define HGATP32_MODE_SHIFT	31
 #define HGATP32_VMID_SHIFT	22
-#define HGATP32_VMID		GENMASK(28, 22)
-#define HGATP32_PPN		GENMASK(21, 0)
+#define HGATP32_VMID		GENMASK_UXL(28, 22)
+#define HGATP32_PPN		GENMASK_UXL(21, 0)
 
 #define HGATP64_MODE_SHIFT	60
 #define HGATP64_VMID_SHIFT	44
-#define HGATP64_VMID		GENMASK(57, 44)
-#define HGATP64_PPN		GENMASK(43, 0)
+#define HGATP64_VMID		GENMASK_UXL(57, 44)
+#define HGATP64_PPN		GENMASK_UXL(43, 0)
 
 #define HGATP_PAGE_SHIFT	12
 
-#ifdef CONFIG_64BIT
+#if __riscv_xlen == 64
 #define HGATP_PPN		HGATP64_PPN
 #define HGATP_VMID_SHIFT	HGATP64_VMID_SHIFT
 #define HGATP_VMID		HGATP64_VMID
@@ -176,31 +184,31 @@
 
 /* VSIP & HVIP relation */
 #define VSIP_TO_HVIP_SHIFT	(IRQ_VS_SOFT - IRQ_S_SOFT)
-#define VSIP_VALID_MASK		((_AC(1, UL) << IRQ_S_SOFT) | \
-				 (_AC(1, UL) << IRQ_S_TIMER) | \
-				 (_AC(1, UL) << IRQ_S_EXT) | \
-				 (_AC(1, UL) << IRQ_PMU_OVF))
+#define VSIP_VALID_MASK		((_AC(1, UXL) << IRQ_S_SOFT) | \
+				 (_AC(1, UXL) << IRQ_S_TIMER) | \
+				 (_AC(1, UXL) << IRQ_S_EXT) | \
+				 (_AC(1, UXL) << IRQ_PMU_OVF))
 
 /* AIA CSR bits */
 #define TOPI_IID_SHIFT		16
-#define TOPI_IID_MASK		GENMASK(11, 0)
-#define TOPI_IPRIO_MASK		GENMASK(7, 0)
+#define TOPI_IID_MASK		GENMASK_UXL(11, 0)
+#define TOPI_IPRIO_MASK		GENMASK_UXL(7, 0)
 #define TOPI_IPRIO_BITS		8
 
 #define TOPEI_ID_SHIFT		16
-#define TOPEI_ID_MASK		GENMASK(10, 0)
-#define TOPEI_PRIO_MASK		GENMASK(10, 0)
+#define TOPEI_ID_MASK		GENMASK_UXL(10, 0)
+#define TOPEI_PRIO_MASK		GENMASK_UXL(10, 0)
 
 #define ISELECT_IPRIO0		0x30
 #define ISELECT_IPRIO15		0x3f
-#define ISELECT_MASK		GENMASK(8, 0)
+#define ISELECT_MASK		GENMASK_UXL(8, 0)
 
 #define HVICTL_VTI		BIT(30)
-#define HVICTL_IID		GENMASK(27, 16)
+#define HVICTL_IID		GENMASK_UXL(27, 16)
 #define HVICTL_IID_SHIFT	16
 #define HVICTL_DPR		BIT(9)
 #define HVICTL_IPRIOM		BIT(8)
-#define HVICTL_IPRIO		GENMASK(7, 0)
+#define HVICTL_IPRIO		GENMASK_UXL(7, 0)
 
 /* xENVCFG flags */
 #define ENVCFG_STCE			(_AC(1, ULL) << 63)
@@ -210,14 +218,14 @@
 #define ENVCFG_PMM_PMLEN_0		(_AC(0x0, ULL) << 32)
 #define ENVCFG_PMM_PMLEN_7		(_AC(0x2, ULL) << 32)
 #define ENVCFG_PMM_PMLEN_16		(_AC(0x3, ULL) << 32)
-#define ENVCFG_CBZE			(_AC(1, UL) << 7)
-#define ENVCFG_CBCFE			(_AC(1, UL) << 6)
+#define ENVCFG_CBZE			(_AC(1, UXL) << 7)
+#define ENVCFG_CBCFE			(_AC(1, UXL) << 6)
 #define ENVCFG_CBIE_SHIFT		4
-#define ENVCFG_CBIE			(_AC(0x3, UL) << ENVCFG_CBIE_SHIFT)
-#define ENVCFG_CBIE_ILL			_AC(0x0, UL)
-#define ENVCFG_CBIE_FLUSH		_AC(0x1, UL)
-#define ENVCFG_CBIE_INV			_AC(0x3, UL)
-#define ENVCFG_FIOM			_AC(0x1, UL)
+#define ENVCFG_CBIE			(_AC(0x3, UXL) << ENVCFG_CBIE_SHIFT)
+#define ENVCFG_CBIE_ILL			_AC(0x0, UXL)
+#define ENVCFG_CBIE_FLUSH		_AC(0x1, UXL)
+#define ENVCFG_CBIE_INV			_AC(0x3, UXL)
+#define ENVCFG_FIOM			_AC(0x1, UXL)
 
 /* Smstateen bits */
 #define SMSTATEEN0_AIA_IMSIC_SHIFT	58
@@ -446,12 +454,12 @@
 
 /* Scalar Crypto Extension - Entropy */
 #define CSR_SEED		0x015
-#define SEED_OPST_MASK		_AC(0xC0000000, UL)
-#define SEED_OPST_BIST		_AC(0x00000000, UL)
-#define SEED_OPST_WAIT		_AC(0x40000000, UL)
-#define SEED_OPST_ES16		_AC(0x80000000, UL)
-#define SEED_OPST_DEAD		_AC(0xC0000000, UL)
-#define SEED_ENTROPY_MASK	_AC(0xFFFF, UL)
+#define SEED_OPST_MASK		_AC(0xC0000000, UXL)
+#define SEED_OPST_BIST		_AC(0x00000000, UXL)
+#define SEED_OPST_WAIT		_AC(0x40000000, UXL)
+#define SEED_OPST_ES16		_AC(0x80000000, UXL)
+#define SEED_OPST_DEAD		_AC(0xC0000000, UXL)
+#define SEED_ENTROPY_MASK	_AC(0xFFFF, UXL)
 
 #ifdef CONFIG_RISCV_M_MODE
 # define CSR_STATUS	CSR_MSTATUS
@@ -504,14 +512,14 @@
 # define RV_IRQ_TIMER	IRQ_S_TIMER
 # define RV_IRQ_EXT		IRQ_S_EXT
 # define RV_IRQ_PMU	IRQ_PMU_OVF
-# define SIP_LCOFIP     (_AC(0x1, UL) << IRQ_PMU_OVF)
+# define SIP_LCOFIP     (_AC(0x1, UXL) << IRQ_PMU_OVF)
 
 #endif /* !CONFIG_RISCV_M_MODE */
 
 /* IE/IP (Supervisor/Machine Interrupt Enable/Pending) flags */
-#define IE_SIE		(_AC(0x1, UL) << RV_IRQ_SOFT)
-#define IE_TIE		(_AC(0x1, UL) << RV_IRQ_TIMER)
-#define IE_EIE		(_AC(0x1, UL) << RV_IRQ_EXT)
+#define IE_SIE		(_AC(0x1, UXL) << RV_IRQ_SOFT)
+#define IE_TIE		(_AC(0x1, UXL) << RV_IRQ_TIMER)
+#define IE_EIE		(_AC(0x1, UXL) << RV_IRQ_EXT)
 
 #ifndef __ASSEMBLY__
 
diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index ca60db75199d..4f958722ca41 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -136,7 +136,7 @@ static u8 rv_tail_call_reg(struct rv_jit_context *ctx)
 
 static bool is_32b_int(s64 val)
 {
-	return -(1L << 31) <= val && val < (1L << 31);
+	return -(1LL << 31) <= val && val < (1LL << 31);
 }
 
 static bool in_auipc_jalr_range(s64 val)
@@ -145,8 +145,8 @@ static bool in_auipc_jalr_range(s64 val)
 	 * auipc+jalr can reach any signed PC-relative offset in the range
 	 * [-2^31 - 2^11, 2^31 - 2^11).
 	 */
-	return (-(1L << 31) - (1L << 11)) <= val &&
-		val < ((1L << 31) - (1L << 11));
+	return (-(1LL << 31) - (1LL << 11)) <= val &&
+		val < ((1LL << 31) - (1LL << 11));
 }
 
 /* Modify rd pointer to alternate reg to avoid corrupting original reg */
-- 
2.40.1


