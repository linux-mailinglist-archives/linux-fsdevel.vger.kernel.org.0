Return-Path: <linux-fsdevel+bounces-44976-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB818A6FCAA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 13:37:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2D18188AFC4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 12:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC4BF269813;
	Tue, 25 Mar 2025 12:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rYM8f4EK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E309F1531C5;
	Tue, 25 Mar 2025 12:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742905264; cv=none; b=FwBOLV8lP8jXfLLxv3UvraGAzCH+SrtWELEImE5GDoQcOB30M2kROianVwV/HrUC3SySkolcA7aWzfixpxIe2QEBpiBAdkVH1RymaZs35fiKbpmawrs5wThIlExQGmCWJK0BqIBBo/MlbcnRxIlcFpo+Ub+TMNIW7WmhLurpZjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742905264; c=relaxed/simple;
	bh=2/Hvnv87DWEjAWPCh6GhOyHG+/U7r4fp8VuTvBXrb80=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AZssfn1w7xo8wPL82OVd02euWkul286LTTsuOgj5d/ChI+lmUbyZge+lC8VyIuiDrhjsA3gDVNOHKlvjsLVDWrVgUzqFU1USoreLNLMCQYFuvkXJrUFbzfgFJ12pSu7m7yHyRVYlExWIU+vuA1Td73SUo7jjbWZ2M9QgiO6zhZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rYM8f4EK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9042C4CEFD;
	Tue, 25 Mar 2025 12:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742905263;
	bh=2/Hvnv87DWEjAWPCh6GhOyHG+/U7r4fp8VuTvBXrb80=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rYM8f4EKTmolkQsSqeHhqrRRc3FcctqKKOZUK+7zLtCEH3VM0e8fUdlOcn4DGvPM6
	 sA2pUVnmhSHVcMDQIL98SQbwImuMRIIDsxMRiLWROTy0BmE0ExR/VAPNCKuWOimaGs
	 PWxcAUwlqO3pvHtJpeAD/KxJdIAriTpRmI1p5EiOeJ8xRi3osKsRlgc6VYHZmTyiPv
	 ht9k2IJ6o5cqmoT7o20SIbbEa0RqMpoF0x4xB6f3agHa1rKTcz2ztlavsM7uZSGfHP
	 w5/mT/Eeu9Kishhy6edSd2s7CYDDsb7nrj2/nMWTZ1fd0yh7FM8IGkpZDAZQMvQHhe
	 geBTTiA2fBnxw==
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
Subject: [RFC PATCH V3 18/43] rv64ilp32_abi: riscv: kvm: Initial support
Date: Tue, 25 Mar 2025 08:15:59 -0400
Message-Id: <20250325121624.523258-19-guoren@kernel.org>
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

This is the initial support for rv64ilp32 abi, and haven't passed
the kvm self test.

It could support rv64ilp32 & rv64lp64 linux guest kernels.

Signed-off-by: Guo Ren (Alibaba DAMO Academy) <guoren@kernel.org>
---
 arch/riscv/include/asm/kvm_aia.h       |  32 ++---
 arch/riscv/include/asm/kvm_host.h      | 192 ++++++++++++-------------
 arch/riscv/include/asm/kvm_nacl.h      |  26 ++--
 arch/riscv/include/asm/kvm_vcpu_insn.h |   4 +-
 arch/riscv/include/asm/kvm_vcpu_pmu.h  |   8 +-
 arch/riscv/include/asm/kvm_vcpu_sbi.h  |   4 +-
 arch/riscv/include/asm/sbi.h           |  10 +-
 arch/riscv/include/uapi/asm/kvm.h      |  56 ++++----
 arch/riscv/kvm/aia.c                   |  26 ++--
 arch/riscv/kvm/aia_imsic.c             |   6 +-
 arch/riscv/kvm/main.c                  |   2 +-
 arch/riscv/kvm/mmu.c                   |  10 +-
 arch/riscv/kvm/tlb.c                   |  76 +++++-----
 arch/riscv/kvm/vcpu.c                  |  10 +-
 arch/riscv/kvm/vcpu_exit.c             |   4 +-
 arch/riscv/kvm/vcpu_insn.c             |  12 +-
 arch/riscv/kvm/vcpu_onereg.c           |  18 +--
 arch/riscv/kvm/vcpu_pmu.c              |   8 +-
 arch/riscv/kvm/vcpu_sbi_base.c         |   2 +-
 arch/riscv/kvm/vmid.c                  |   4 +-
 20 files changed, 256 insertions(+), 254 deletions(-)

diff --git a/arch/riscv/include/asm/kvm_aia.h b/arch/riscv/include/asm/kvm_aia.h
index 1f37b600ca47..d7dae9128b5e 100644
--- a/arch/riscv/include/asm/kvm_aia.h
+++ b/arch/riscv/include/asm/kvm_aia.h
@@ -50,13 +50,13 @@ struct kvm_aia {
 };
 
 struct kvm_vcpu_aia_csr {
-	unsigned long vsiselect;
-	unsigned long hviprio1;
-	unsigned long hviprio2;
-	unsigned long vsieh;
-	unsigned long hviph;
-	unsigned long hviprio1h;
-	unsigned long hviprio2h;
+	xlen_t vsiselect;
+	xlen_t hviprio1;
+	xlen_t hviprio2;
+	xlen_t vsieh;
+	xlen_t hviph;
+	xlen_t hviprio1h;
+	xlen_t hviprio2h;
 };
 
 struct kvm_vcpu_aia {
@@ -95,8 +95,8 @@ int kvm_riscv_vcpu_aia_imsic_update(struct kvm_vcpu *vcpu);
 
 #define KVM_RISCV_AIA_IMSIC_TOPEI	(ISELECT_MASK + 1)
 int kvm_riscv_vcpu_aia_imsic_rmw(struct kvm_vcpu *vcpu, unsigned long isel,
-				 unsigned long *val, unsigned long new_val,
-				 unsigned long wr_mask);
+				 xlen_t *val, xlen_t new_val,
+				 xlen_t wr_mask);
 int kvm_riscv_aia_imsic_rw_attr(struct kvm *kvm, unsigned long type,
 				bool write, unsigned long *val);
 int kvm_riscv_aia_imsic_has_attr(struct kvm *kvm, unsigned long type);
@@ -131,19 +131,19 @@ void kvm_riscv_vcpu_aia_load(struct kvm_vcpu *vcpu, int cpu);
 void kvm_riscv_vcpu_aia_put(struct kvm_vcpu *vcpu);
 int kvm_riscv_vcpu_aia_get_csr(struct kvm_vcpu *vcpu,
 			       unsigned long reg_num,
-			       unsigned long *out_val);
+			       xlen_t *out_val);
 int kvm_riscv_vcpu_aia_set_csr(struct kvm_vcpu *vcpu,
 			       unsigned long reg_num,
-			       unsigned long val);
+			       xlen_t val);
 
 int kvm_riscv_vcpu_aia_rmw_topei(struct kvm_vcpu *vcpu,
 				 unsigned int csr_num,
-				 unsigned long *val,
-				 unsigned long new_val,
-				 unsigned long wr_mask);
+				 xlen_t *val,
+				 xlen_t new_val,
+				 xlen_t wr_mask);
 int kvm_riscv_vcpu_aia_rmw_ireg(struct kvm_vcpu *vcpu, unsigned int csr_num,
-				unsigned long *val, unsigned long new_val,
-				unsigned long wr_mask);
+				xlen_t *val, xlen_t new_val,
+				xlen_t wr_mask);
 #define KVM_RISCV_VCPU_AIA_CSR_FUNCS \
 { .base = CSR_SIREG,      .count = 1, .func = kvm_riscv_vcpu_aia_rmw_ireg }, \
 { .base = CSR_STOPEI,     .count = 1, .func = kvm_riscv_vcpu_aia_rmw_topei },
diff --git a/arch/riscv/include/asm/kvm_host.h b/arch/riscv/include/asm/kvm_host.h
index cc33e35cd628..166cae2c74cf 100644
--- a/arch/riscv/include/asm/kvm_host.h
+++ b/arch/riscv/include/asm/kvm_host.h
@@ -64,8 +64,8 @@ enum kvm_riscv_hfence_type {
 
 struct kvm_riscv_hfence {
 	enum kvm_riscv_hfence_type type;
-	unsigned long asid;
-	unsigned long order;
+	xlen_t asid;
+	xlen_t order;
 	gpa_t addr;
 	gpa_t size;
 };
@@ -102,8 +102,8 @@ struct kvm_vmid {
 	 * Writes to vmid_version and vmid happen with vmid_lock held
 	 * whereas reads happen without any lock held.
 	 */
-	unsigned long vmid_version;
-	unsigned long vmid;
+	xlen_t vmid_version;
+	xlen_t vmid;
 };
 
 struct kvm_arch {
@@ -122,75 +122,75 @@ struct kvm_arch {
 };
 
 struct kvm_cpu_trap {
-	unsigned long sepc;
-	unsigned long scause;
-	unsigned long stval;
-	unsigned long htval;
-	unsigned long htinst;
+	xlen_t sepc;
+	xlen_t scause;
+	xlen_t stval;
+	xlen_t htval;
+	xlen_t htinst;
 };
 
 struct kvm_cpu_context {
-	unsigned long zero;
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
-	unsigned long sepc;
-	unsigned long sstatus;
-	unsigned long hstatus;
+	xlen_t zero;
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
+	xlen_t sepc;
+	xlen_t sstatus;
+	xlen_t hstatus;
 	union __riscv_fp_state fp;
 	struct __riscv_v_ext_state vector;
 };
 
 struct kvm_vcpu_csr {
-	unsigned long vsstatus;
-	unsigned long vsie;
-	unsigned long vstvec;
-	unsigned long vsscratch;
-	unsigned long vsepc;
-	unsigned long vscause;
-	unsigned long vstval;
-	unsigned long hvip;
-	unsigned long vsatp;
-	unsigned long scounteren;
-	unsigned long senvcfg;
+	xlen_t vsstatus;
+	xlen_t vsie;
+	xlen_t vstvec;
+	xlen_t vsscratch;
+	xlen_t vsepc;
+	xlen_t vscause;
+	xlen_t vstval;
+	xlen_t hvip;
+	xlen_t vsatp;
+	xlen_t scounteren;
+	xlen_t senvcfg;
 };
 
 struct kvm_vcpu_config {
 	u64 henvcfg;
 	u64 hstateen0;
-	unsigned long hedeleg;
+	xlen_t hedeleg;
 };
 
 struct kvm_vcpu_smstateen_csr {
-	unsigned long sstateen0;
+	xlen_t sstateen0;
 };
 
 struct kvm_vcpu_arch {
@@ -204,16 +204,16 @@ struct kvm_vcpu_arch {
 	DECLARE_BITMAP(isa, RISCV_ISA_EXT_MAX);
 
 	/* Vendor, Arch, and Implementation details */
-	unsigned long mvendorid;
-	unsigned long marchid;
-	unsigned long mimpid;
+	xlen_t mvendorid;
+	xlen_t marchid;
+	xlen_t mimpid;
 
 	/* SSCRATCH, STVEC, and SCOUNTEREN of Host */
-	unsigned long host_sscratch;
-	unsigned long host_stvec;
-	unsigned long host_scounteren;
-	unsigned long host_senvcfg;
-	unsigned long host_sstateen0;
+	xlen_t host_sscratch;
+	xlen_t host_stvec;
+	xlen_t host_scounteren;
+	xlen_t host_senvcfg;
+	xlen_t host_sstateen0;
 
 	/* CPU context of Host */
 	struct kvm_cpu_context host_context;
@@ -252,8 +252,8 @@ struct kvm_vcpu_arch {
 
 	/* HFENCE request queue */
 	spinlock_t hfence_lock;
-	unsigned long hfence_head;
-	unsigned long hfence_tail;
+	xlen_t hfence_head;
+	xlen_t hfence_tail;
 	struct kvm_riscv_hfence hfence_queue[KVM_RISCV_VCPU_MAX_HFENCE];
 
 	/* MMIO instruction details */
@@ -305,24 +305,24 @@ static inline void kvm_arch_sync_events(struct kvm *kvm) {}
 
 #define KVM_RISCV_GSTAGE_TLB_MIN_ORDER		12
 
-void kvm_riscv_local_hfence_gvma_vmid_gpa(unsigned long vmid,
+void kvm_riscv_local_hfence_gvma_vmid_gpa(xlen_t vmid,
 					  gpa_t gpa, gpa_t gpsz,
-					  unsigned long order);
-void kvm_riscv_local_hfence_gvma_vmid_all(unsigned long vmid);
+					  xlen_t order);
+void kvm_riscv_local_hfence_gvma_vmid_all(xlen_t vmid);
 void kvm_riscv_local_hfence_gvma_gpa(gpa_t gpa, gpa_t gpsz,
-				     unsigned long order);
+				     xlen_t order);
 void kvm_riscv_local_hfence_gvma_all(void);
-void kvm_riscv_local_hfence_vvma_asid_gva(unsigned long vmid,
-					  unsigned long asid,
-					  unsigned long gva,
-					  unsigned long gvsz,
-					  unsigned long order);
-void kvm_riscv_local_hfence_vvma_asid_all(unsigned long vmid,
-					  unsigned long asid);
-void kvm_riscv_local_hfence_vvma_gva(unsigned long vmid,
-				     unsigned long gva, unsigned long gvsz,
-				     unsigned long order);
-void kvm_riscv_local_hfence_vvma_all(unsigned long vmid);
+void kvm_riscv_local_hfence_vvma_asid_gva(xlen_t vmid,
+					  xlen_t asid,
+					  xlen_t gva,
+					  xlen_t gvsz,
+					  xlen_t order);
+void kvm_riscv_local_hfence_vvma_asid_all(xlen_t vmid,
+					  xlen_t asid);
+void kvm_riscv_local_hfence_vvma_gva(xlen_t vmid,
+				     xlen_t gva, xlen_t gvsz,
+				     xlen_t order);
+void kvm_riscv_local_hfence_vvma_all(xlen_t vmid);
 
 void kvm_riscv_local_tlb_sanitize(struct kvm_vcpu *vcpu);
 
@@ -332,26 +332,26 @@ void kvm_riscv_hfence_vvma_all_process(struct kvm_vcpu *vcpu);
 void kvm_riscv_hfence_process(struct kvm_vcpu *vcpu);
 
 void kvm_riscv_fence_i(struct kvm *kvm,
-		       unsigned long hbase, unsigned long hmask);
+		       xlen_t hbase, xlen_t hmask);
 void kvm_riscv_hfence_gvma_vmid_gpa(struct kvm *kvm,
-				    unsigned long hbase, unsigned long hmask,
+				    xlen_t hbase, xlen_t hmask,
 				    gpa_t gpa, gpa_t gpsz,
-				    unsigned long order);
+				    xlen_t order);
 void kvm_riscv_hfence_gvma_vmid_all(struct kvm *kvm,
-				    unsigned long hbase, unsigned long hmask);
+				    xlen_t hbase, xlen_t hmask);
 void kvm_riscv_hfence_vvma_asid_gva(struct kvm *kvm,
-				    unsigned long hbase, unsigned long hmask,
-				    unsigned long gva, unsigned long gvsz,
-				    unsigned long order, unsigned long asid);
+				    xlen_t hbase, xlen_t hmask,
+				    xlen_t gva, xlen_t gvsz,
+				    xlen_t order, xlen_t asid);
 void kvm_riscv_hfence_vvma_asid_all(struct kvm *kvm,
-				    unsigned long hbase, unsigned long hmask,
-				    unsigned long asid);
+				    xlen_t hbase, xlen_t hmask,
+				    xlen_t asid);
 void kvm_riscv_hfence_vvma_gva(struct kvm *kvm,
-			       unsigned long hbase, unsigned long hmask,
-			       unsigned long gva, unsigned long gvsz,
-			       unsigned long order);
+			       xlen_t hbase, xlen_t hmask,
+			       xlen_t gva, xlen_t gvsz,
+			       xlen_t order);
 void kvm_riscv_hfence_vvma_all(struct kvm *kvm,
-			       unsigned long hbase, unsigned long hmask);
+			       xlen_t hbase, xlen_t hmask);
 
 int kvm_riscv_gstage_ioremap(struct kvm *kvm, gpa_t gpa,
 			     phys_addr_t hpa, unsigned long size,
@@ -369,7 +369,7 @@ unsigned long __init kvm_riscv_gstage_mode(void);
 int kvm_riscv_gstage_gpa_bits(void);
 
 void __init kvm_riscv_gstage_vmid_detect(void);
-unsigned long kvm_riscv_gstage_vmid_bits(void);
+xlen_t kvm_riscv_gstage_vmid_bits(void);
 int kvm_riscv_gstage_vmid_init(struct kvm *kvm);
 bool kvm_riscv_gstage_vmid_ver_changed(struct kvm_vmid *vmid);
 void kvm_riscv_gstage_vmid_update(struct kvm_vcpu *vcpu);
diff --git a/arch/riscv/include/asm/kvm_nacl.h b/arch/riscv/include/asm/kvm_nacl.h
index 4124d5e06a0f..59be64c068fc 100644
--- a/arch/riscv/include/asm/kvm_nacl.h
+++ b/arch/riscv/include/asm/kvm_nacl.h
@@ -68,26 +68,26 @@ int kvm_riscv_nacl_init(void);
 #define nacl_shmem()							\
 	this_cpu_ptr(&kvm_riscv_nacl)->shmem
 
-#define nacl_scratch_read_long(__shmem, __offset)			\
+#define nacl_scratch_read_csr(__shmem, __offset)			\
 ({									\
-	unsigned long *__p = (__shmem) +				\
+	xlen_t *__p = (__shmem) +					\
 			     SBI_NACL_SHMEM_SCRATCH_OFFSET +		\
 			     (__offset);				\
 	lelong_to_cpu(*__p);						\
 })
 
-#define nacl_scratch_write_long(__shmem, __offset, __val)		\
+#define nacl_scratch_write_csr(__shmem, __offset, __val)		\
 do {									\
-	unsigned long *__p = (__shmem) +				\
+	xlen_t *__p = (__shmem) +					\
 			     SBI_NACL_SHMEM_SCRATCH_OFFSET +		\
 			     (__offset);				\
 	*__p = cpu_to_lelong(__val);					\
 } while (0)
 
-#define nacl_scratch_write_longs(__shmem, __offset, __array, __count)	\
+#define nacl_scratch_write_csrs(__shmem, __offset, __array, __count)	\
 do {									\
 	unsigned int __i;						\
-	unsigned long *__p = (__shmem) +				\
+	xlen_t *__p = (__shmem) +					\
 			     SBI_NACL_SHMEM_SCRATCH_OFFSET +		\
 			     (__offset);				\
 	for (__i = 0; __i < (__count); __i++)				\
@@ -100,7 +100,7 @@ do {									\
 
 #define nacl_hfence_mkconfig(__type, __order, __vmid, __asid)		\
 ({									\
-	unsigned long __c = SBI_NACL_SHMEM_HFENCE_CONFIG_PEND;		\
+	xlen_t __c = SBI_NACL_SHMEM_HFENCE_CONFIG_PEND;		\
 	__c |= ((__type) & SBI_NACL_SHMEM_HFENCE_CONFIG_TYPE_MASK)	\
 		<< SBI_NACL_SHMEM_HFENCE_CONFIG_TYPE_SHIFT;		\
 	__c |= (((__order) - SBI_NACL_SHMEM_HFENCE_ORDER_BASE) &	\
@@ -168,7 +168,7 @@ __kvm_riscv_nacl_hfence(__shmem,					\
 
 #define nacl_csr_read(__shmem, __csr)					\
 ({									\
-	unsigned long *__a = (__shmem) + SBI_NACL_SHMEM_CSR_OFFSET;	\
+	xlen_t *__a = (__shmem) + SBI_NACL_SHMEM_CSR_OFFSET;		\
 	lelong_to_cpu(__a[SBI_NACL_SHMEM_CSR_INDEX(__csr)]);		\
 })
 
@@ -176,7 +176,7 @@ __kvm_riscv_nacl_hfence(__shmem,					\
 do {									\
 	void *__s = (__shmem);						\
 	unsigned int __i = SBI_NACL_SHMEM_CSR_INDEX(__csr);		\
-	unsigned long *__a = (__s) + SBI_NACL_SHMEM_CSR_OFFSET;		\
+	xlen_t *__a = (__s) + SBI_NACL_SHMEM_CSR_OFFSET;		\
 	u8 *__b = (__s) + SBI_NACL_SHMEM_DBITMAP_OFFSET;		\
 	__a[__i] = cpu_to_lelong(__val);				\
 	__b[__i >> 3] |= 1U << (__i & 0x7);				\
@@ -186,9 +186,9 @@ do {									\
 ({									\
 	void *__s = (__shmem);						\
 	unsigned int __i = SBI_NACL_SHMEM_CSR_INDEX(__csr);		\
-	unsigned long *__a = (__s) + SBI_NACL_SHMEM_CSR_OFFSET;		\
+	xlen_t *__a = (__s) + SBI_NACL_SHMEM_CSR_OFFSET;		\
 	u8 *__b = (__s) + SBI_NACL_SHMEM_DBITMAP_OFFSET;		\
-	unsigned long __r = lelong_to_cpu(__a[__i]);			\
+	xlen_t __r = lelong_to_cpu(__a[__i]);			\
 	__a[__i] = cpu_to_lelong(__val);				\
 	__b[__i >> 3] |= 1U << (__i & 0x7);				\
 	__r;								\
@@ -210,7 +210,7 @@ do {									\
 
 #define ncsr_read(__csr)						\
 ({									\
-	unsigned long __r;						\
+	xlen_t __r;							\
 	if (kvm_riscv_nacl_available())					\
 		__r = nacl_csr_read(nacl_shmem(), __csr);		\
 	else								\
@@ -228,7 +228,7 @@ do {									\
 
 #define ncsr_swap(__csr, __val)						\
 ({									\
-	unsigned long __r;						\
+	xlen_t __r;							\
 	if (kvm_riscv_nacl_sync_csr_available())			\
 		__r = nacl_csr_swap(nacl_shmem(), __csr, __val);	\
 	else								\
diff --git a/arch/riscv/include/asm/kvm_vcpu_insn.h b/arch/riscv/include/asm/kvm_vcpu_insn.h
index 350011c83581..a0da75683894 100644
--- a/arch/riscv/include/asm/kvm_vcpu_insn.h
+++ b/arch/riscv/include/asm/kvm_vcpu_insn.h
@@ -11,7 +11,7 @@ struct kvm_run;
 struct kvm_cpu_trap;
 
 struct kvm_mmio_decode {
-	unsigned long insn;
+	xlen_t insn;
 	int insn_len;
 	int len;
 	int shift;
@@ -19,7 +19,7 @@ struct kvm_mmio_decode {
 };
 
 struct kvm_csr_decode {
-	unsigned long insn;
+	xlen_t insn;
 	int return_handled;
 };
 
diff --git a/arch/riscv/include/asm/kvm_vcpu_pmu.h b/arch/riscv/include/asm/kvm_vcpu_pmu.h
index 1d85b6617508..e69b102bde49 100644
--- a/arch/riscv/include/asm/kvm_vcpu_pmu.h
+++ b/arch/riscv/include/asm/kvm_vcpu_pmu.h
@@ -74,8 +74,8 @@ struct kvm_pmu {
 
 int kvm_riscv_vcpu_pmu_incr_fw(struct kvm_vcpu *vcpu, unsigned long fid);
 int kvm_riscv_vcpu_pmu_read_hpm(struct kvm_vcpu *vcpu, unsigned int csr_num,
-				unsigned long *val, unsigned long new_val,
-				unsigned long wr_mask);
+				xlen_t *val, xlen_t new_val,
+				xlen_t wr_mask);
 
 int kvm_riscv_vcpu_pmu_num_ctrs(struct kvm_vcpu *vcpu, struct kvm_vcpu_sbi_return *retdata);
 int kvm_riscv_vcpu_pmu_ctr_info(struct kvm_vcpu *vcpu, unsigned long cidx,
@@ -106,8 +106,8 @@ struct kvm_pmu {
 };
 
 static inline int kvm_riscv_vcpu_pmu_read_legacy(struct kvm_vcpu *vcpu, unsigned int csr_num,
-						 unsigned long *val, unsigned long new_val,
-						 unsigned long wr_mask)
+						 xlen_t *val, xlen_t new_val,
+						 xlen_t wr_mask)
 {
 	if (csr_num == CSR_CYCLE || csr_num == CSR_INSTRET) {
 		*val = 0;
diff --git a/arch/riscv/include/asm/kvm_vcpu_sbi.h b/arch/riscv/include/asm/kvm_vcpu_sbi.h
index 4ed6203cdd30..83d786111450 100644
--- a/arch/riscv/include/asm/kvm_vcpu_sbi.h
+++ b/arch/riscv/include/asm/kvm_vcpu_sbi.h
@@ -27,8 +27,8 @@ struct kvm_vcpu_sbi_context {
 };
 
 struct kvm_vcpu_sbi_return {
-	unsigned long out_val;
-	unsigned long err_val;
+	xlen_t out_val;
+	xlen_t err_val;
 	struct kvm_cpu_trap *utrap;
 	bool uexit;
 };
diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index fd9a9c723ec6..df73a0eb231b 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -343,7 +343,7 @@ enum sbi_ext_nacl_feature {
 #define SBI_NACL_SHMEM_HFENCE_CONFIG_PEND_SHIFT	\
 		(__riscv_xlen - SBI_NACL_SHMEM_HFENCE_CONFIG_PEND_BITS)
 #define SBI_NACL_SHMEM_HFENCE_CONFIG_PEND_MASK	\
-		((1UL << SBI_NACL_SHMEM_HFENCE_CONFIG_PEND_BITS) - 1)
+		((_AC(1, UXL) << SBI_NACL_SHMEM_HFENCE_CONFIG_PEND_BITS) - 1)
 #define SBI_NACL_SHMEM_HFENCE_CONFIG_PEND		\
 		(SBI_NACL_SHMEM_HFENCE_CONFIG_PEND_MASK << \
 		 SBI_NACL_SHMEM_HFENCE_CONFIG_PEND_SHIFT)
@@ -358,7 +358,7 @@ enum sbi_ext_nacl_feature {
 		(SBI_NACL_SHMEM_HFENCE_CONFIG_RSVD1_SHIFT - \
 		 SBI_NACL_SHMEM_HFENCE_CONFIG_TYPE_BITS)
 #define SBI_NACL_SHMEM_HFENCE_CONFIG_TYPE_MASK	\
-		((1UL << SBI_NACL_SHMEM_HFENCE_CONFIG_TYPE_BITS) - 1)
+		((_AC(1, UXL) << SBI_NACL_SHMEM_HFENCE_CONFIG_TYPE_BITS) - 1)
 
 #define SBI_NACL_SHMEM_HFENCE_TYPE_GVMA		0x0
 #define SBI_NACL_SHMEM_HFENCE_TYPE_GVMA_ALL	0x1
@@ -379,7 +379,7 @@ enum sbi_ext_nacl_feature {
 		(SBI_NACL_SHMEM_HFENCE_CONFIG_RSVD2_SHIFT - \
 		 SBI_NACL_SHMEM_HFENCE_CONFIG_ORDER_BITS)
 #define SBI_NACL_SHMEM_HFENCE_CONFIG_ORDER_MASK	\
-		((1UL << SBI_NACL_SHMEM_HFENCE_CONFIG_ORDER_BITS) - 1)
+		((_AC(1, UXL) << SBI_NACL_SHMEM_HFENCE_CONFIG_ORDER_BITS) - 1)
 #define SBI_NACL_SHMEM_HFENCE_ORDER_BASE	12
 
 #if __riscv_xlen == 32
@@ -392,9 +392,9 @@ enum sbi_ext_nacl_feature {
 #define SBI_NACL_SHMEM_HFENCE_CONFIG_VMID_SHIFT	\
 				SBI_NACL_SHMEM_HFENCE_CONFIG_ASID_BITS
 #define SBI_NACL_SHMEM_HFENCE_CONFIG_ASID_MASK	\
-		((1UL << SBI_NACL_SHMEM_HFENCE_CONFIG_ASID_BITS) - 1)
+		((_AC(1, UXL) << SBI_NACL_SHMEM_HFENCE_CONFIG_ASID_BITS) - 1)
 #define SBI_NACL_SHMEM_HFENCE_CONFIG_VMID_MASK	\
-		((1UL << SBI_NACL_SHMEM_HFENCE_CONFIG_VMID_BITS) - 1)
+		((_AC(1, UXL) << SBI_NACL_SHMEM_HFENCE_CONFIG_VMID_BITS) - 1)
 
 #define SBI_NACL_SHMEM_AUTOSWAP_FLAG_HSTATUS	BIT(0)
 #define SBI_NACL_SHMEM_AUTOSWAP_HSTATUS		((__riscv_xlen / 8) * 1)
diff --git a/arch/riscv/include/uapi/asm/kvm.h b/arch/riscv/include/uapi/asm/kvm.h
index f06bc5efcd79..9001e8081ce2 100644
--- a/arch/riscv/include/uapi/asm/kvm.h
+++ b/arch/riscv/include/uapi/asm/kvm.h
@@ -48,13 +48,13 @@ struct kvm_sregs {
 
 /* CONFIG registers for KVM_GET_ONE_REG and KVM_SET_ONE_REG */
 struct kvm_riscv_config {
-	unsigned long isa;
-	unsigned long zicbom_block_size;
-	unsigned long mvendorid;
-	unsigned long marchid;
-	unsigned long mimpid;
-	unsigned long zicboz_block_size;
-	unsigned long satp_mode;
+	xlen_t isa;
+	xlen_t zicbom_block_size;
+	xlen_t mvendorid;
+	xlen_t marchid;
+	xlen_t mimpid;
+	xlen_t zicboz_block_size;
+	xlen_t satp_mode;
 };
 
 /* CORE registers for KVM_GET_ONE_REG and KVM_SET_ONE_REG */
@@ -69,33 +69,33 @@ struct kvm_riscv_core {
 
 /* General CSR registers for KVM_GET_ONE_REG and KVM_SET_ONE_REG */
 struct kvm_riscv_csr {
-	unsigned long sstatus;
-	unsigned long sie;
-	unsigned long stvec;
-	unsigned long sscratch;
-	unsigned long sepc;
-	unsigned long scause;
-	unsigned long stval;
-	unsigned long sip;
-	unsigned long satp;
-	unsigned long scounteren;
-	unsigned long senvcfg;
+	xlen_t sstatus;
+	xlen_t sie;
+	xlen_t stvec;
+	xlen_t sscratch;
+	xlen_t sepc;
+	xlen_t scause;
+	xlen_t stval;
+	xlen_t sip;
+	xlen_t satp;
+	xlen_t scounteren;
+	xlen_t senvcfg;
 };
 
 /* AIA CSR registers for KVM_GET_ONE_REG and KVM_SET_ONE_REG */
 struct kvm_riscv_aia_csr {
-	unsigned long siselect;
-	unsigned long iprio1;
-	unsigned long iprio2;
-	unsigned long sieh;
-	unsigned long siph;
-	unsigned long iprio1h;
-	unsigned long iprio2h;
+	xlen_t siselect;
+	xlen_t iprio1;
+	xlen_t iprio2;
+	xlen_t sieh;
+	xlen_t siph;
+	xlen_t iprio1h;
+	xlen_t iprio2h;
 };
 
 /* Smstateen CSR for KVM_GET_ONE_REG and KVM_SET_ONE_REG */
 struct kvm_riscv_smstateen_csr {
-	unsigned long sstateen0;
+	xlen_t sstateen0;
 };
 
 /* TIMER registers for KVM_GET_ONE_REG and KVM_SET_ONE_REG */
@@ -207,8 +207,8 @@ enum KVM_RISCV_SBI_EXT_ID {
 
 /* SBI STA extension registers for KVM_GET_ONE_REG and KVM_SET_ONE_REG */
 struct kvm_riscv_sbi_sta {
-	unsigned long shmem_lo;
-	unsigned long shmem_hi;
+	xlen_t shmem_lo;
+	xlen_t shmem_hi;
 };
 
 /* Possible states for kvm_riscv_timer */
diff --git a/arch/riscv/kvm/aia.c b/arch/riscv/kvm/aia.c
index 19afd1f23537..77f6943292a3 100644
--- a/arch/riscv/kvm/aia.c
+++ b/arch/riscv/kvm/aia.c
@@ -200,31 +200,31 @@ void kvm_riscv_vcpu_aia_put(struct kvm_vcpu *vcpu)
 
 int kvm_riscv_vcpu_aia_get_csr(struct kvm_vcpu *vcpu,
 			       unsigned long reg_num,
-			       unsigned long *out_val)
+			       xlen_t *out_val)
 {
 	struct kvm_vcpu_aia_csr *csr = &vcpu->arch.aia_context.guest_csr;
 
-	if (reg_num >= sizeof(struct kvm_riscv_aia_csr) / sizeof(unsigned long))
+	if (reg_num >= sizeof(struct kvm_riscv_aia_csr) / sizeof(xlen_t))
 		return -ENOENT;
 
 	*out_val = 0;
 	if (kvm_riscv_aia_available())
-		*out_val = ((unsigned long *)csr)[reg_num];
+		*out_val = ((xlen_t *)csr)[reg_num];
 
 	return 0;
 }
 
 int kvm_riscv_vcpu_aia_set_csr(struct kvm_vcpu *vcpu,
 			       unsigned long reg_num,
-			       unsigned long val)
+			       xlen_t val)
 {
 	struct kvm_vcpu_aia_csr *csr = &vcpu->arch.aia_context.guest_csr;
 
-	if (reg_num >= sizeof(struct kvm_riscv_aia_csr) / sizeof(unsigned long))
+	if (reg_num >= sizeof(struct kvm_riscv_aia_csr) / sizeof(xlen_t))
 		return -ENOENT;
 
 	if (kvm_riscv_aia_available()) {
-		((unsigned long *)csr)[reg_num] = val;
+		((xlen_t *)csr)[reg_num] = val;
 
 #ifdef CONFIG_32BIT
 		if (reg_num == KVM_REG_RISCV_CSR_AIA_REG(siph))
@@ -237,9 +237,9 @@ int kvm_riscv_vcpu_aia_set_csr(struct kvm_vcpu *vcpu,
 
 int kvm_riscv_vcpu_aia_rmw_topei(struct kvm_vcpu *vcpu,
 				 unsigned int csr_num,
-				 unsigned long *val,
-				 unsigned long new_val,
-				 unsigned long wr_mask)
+				 xlen_t *val,
+				 xlen_t new_val,
+				 xlen_t wr_mask)
 {
 	/* If AIA not available then redirect trap */
 	if (!kvm_riscv_aia_available())
@@ -271,7 +271,7 @@ static int aia_irq2bitpos[] = {
 
 static u8 aia_get_iprio8(struct kvm_vcpu *vcpu, unsigned int irq)
 {
-	unsigned long hviprio;
+	xlen_t hviprio;
 	int bitpos = aia_irq2bitpos[irq];
 
 	if (bitpos < 0)
@@ -396,8 +396,8 @@ static int aia_rmw_iprio(struct kvm_vcpu *vcpu, unsigned int isel,
 }
 
 int kvm_riscv_vcpu_aia_rmw_ireg(struct kvm_vcpu *vcpu, unsigned int csr_num,
-				unsigned long *val, unsigned long new_val,
-				unsigned long wr_mask)
+				xlen_t *val, xlen_t new_val,
+				xlen_t wr_mask)
 {
 	unsigned int isel;
 
@@ -408,7 +408,7 @@ int kvm_riscv_vcpu_aia_rmw_ireg(struct kvm_vcpu *vcpu, unsigned int csr_num,
 	/* First try to emulate in kernel space */
 	isel = ncsr_read(CSR_VSISELECT) & ISELECT_MASK;
 	if (isel >= ISELECT_IPRIO0 && isel <= ISELECT_IPRIO15)
-		return aia_rmw_iprio(vcpu, isel, val, new_val, wr_mask);
+		return aia_rmw_iprio(vcpu, isel, (ulong *)val, new_val, wr_mask);
 	else if (isel >= IMSIC_FIRST && isel <= IMSIC_LAST &&
 		 kvm_riscv_aia_initialized(vcpu->kvm))
 		return kvm_riscv_vcpu_aia_imsic_rmw(vcpu, isel, val, new_val,
diff --git a/arch/riscv/kvm/aia_imsic.c b/arch/riscv/kvm/aia_imsic.c
index a8085cd8215e..3c7f13b7a2ba 100644
--- a/arch/riscv/kvm/aia_imsic.c
+++ b/arch/riscv/kvm/aia_imsic.c
@@ -839,8 +839,8 @@ int kvm_riscv_vcpu_aia_imsic_update(struct kvm_vcpu *vcpu)
 }
 
 int kvm_riscv_vcpu_aia_imsic_rmw(struct kvm_vcpu *vcpu, unsigned long isel,
-				 unsigned long *val, unsigned long new_val,
-				 unsigned long wr_mask)
+				 xlen_t *val, xlen_t new_val,
+				 xlen_t wr_mask)
 {
 	u32 topei;
 	struct imsic_mrif_eix *eix;
@@ -866,7 +866,7 @@ int kvm_riscv_vcpu_aia_imsic_rmw(struct kvm_vcpu *vcpu, unsigned long isel,
 		}
 	} else {
 		r = imsic_mrif_rmw(imsic->swfile, imsic->nr_eix, isel,
-				   val, new_val, wr_mask);
+				   (ulong *)val, (ulong)new_val, (ulong)wr_mask);
 		/* Forward unknown IMSIC register to user-space */
 		if (r)
 			rc = (r == -ENOENT) ? 0 : KVM_INSN_ILLEGAL_TRAP;
diff --git a/arch/riscv/kvm/main.c b/arch/riscv/kvm/main.c
index 1fa8be5ee509..34d053ae09a9 100644
--- a/arch/riscv/kvm/main.c
+++ b/arch/riscv/kvm/main.c
@@ -152,7 +152,7 @@ static int __init riscv_kvm_init(void)
 	}
 	kvm_info("using %s G-stage page table format\n", str);
 
-	kvm_info("VMID %ld bits available\n", kvm_riscv_gstage_vmid_bits());
+	kvm_info("VMID %ld bits available\n", (ulong)kvm_riscv_gstage_vmid_bits());
 
 	if (kvm_riscv_aia_available())
 		kvm_info("AIA available with %d guest external interrupts\n",
diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
index 1087ea74567b..a89e5701076d 100644
--- a/arch/riscv/kvm/mmu.c
+++ b/arch/riscv/kvm/mmu.c
@@ -20,7 +20,7 @@
 #include <asm/pgtable.h>
 
 #ifdef CONFIG_64BIT
-static unsigned long gstage_mode __ro_after_init = (HGATP_MODE_SV39X4 << HGATP_MODE_SHIFT);
+static xlen_t gstage_mode __ro_after_init = (HGATP_MODE_SV39X4 << HGATP_MODE_SHIFT);
 static unsigned long gstage_pgd_levels __ro_after_init = 3;
 #define gstage_index_bits	9
 #else
@@ -30,11 +30,11 @@ static unsigned long gstage_pgd_levels __ro_after_init = 2;
 #endif
 
 #define gstage_pgd_xbits	2
-#define gstage_pgd_size	(1UL << (HGATP_PAGE_SHIFT + gstage_pgd_xbits))
+#define gstage_pgd_size	(_AC(1, UXL) << (HGATP_PAGE_SHIFT + gstage_pgd_xbits))
 #define gstage_gpa_bits	(HGATP_PAGE_SHIFT + \
 			 (gstage_pgd_levels * gstage_index_bits) + \
 			 gstage_pgd_xbits)
-#define gstage_gpa_size	((gpa_t)(1ULL << gstage_gpa_bits))
+#define gstage_gpa_size	((gpa_t)(_AC(1, UXL) << gstage_gpa_bits))
 
 #define gstage_pte_leaf(__ptep)	\
 	(pte_val(*(__ptep)) & (_PAGE_READ | _PAGE_WRITE | _PAGE_EXEC))
@@ -623,7 +623,7 @@ int kvm_riscv_gstage_map(struct kvm_vcpu *vcpu,
 		vma_pageshift = huge_page_shift(hstate_vma(vma));
 	else
 		vma_pageshift = PAGE_SHIFT;
-	vma_pagesize = 1ULL << vma_pageshift;
+	vma_pagesize = _AC(1, UXL) << vma_pageshift;
 	if (logging || (vma->vm_flags & VM_PFNMAP))
 		vma_pagesize = PAGE_SIZE;
 
@@ -725,7 +725,7 @@ void kvm_riscv_gstage_free_pgd(struct kvm *kvm)
 
 void kvm_riscv_gstage_update_hgatp(struct kvm_vcpu *vcpu)
 {
-	unsigned long hgatp = gstage_mode;
+	xlen_t hgatp = gstage_mode;
 	struct kvm_arch *k = &vcpu->kvm->arch;
 
 	hgatp |= (READ_ONCE(k->vmid.vmid) << HGATP_VMID_SHIFT) & HGATP_VMID;
diff --git a/arch/riscv/kvm/tlb.c b/arch/riscv/kvm/tlb.c
index 2f91ea5f8493..01d581763849 100644
--- a/arch/riscv/kvm/tlb.c
+++ b/arch/riscv/kvm/tlb.c
@@ -18,9 +18,9 @@
 
 #define has_svinval()	riscv_has_extension_unlikely(RISCV_ISA_EXT_SVINVAL)
 
-void kvm_riscv_local_hfence_gvma_vmid_gpa(unsigned long vmid,
+void kvm_riscv_local_hfence_gvma_vmid_gpa(xlen_t vmid,
 					  gpa_t gpa, gpa_t gpsz,
-					  unsigned long order)
+					  xlen_t order)
 {
 	gpa_t pos;
 
@@ -42,13 +42,13 @@ void kvm_riscv_local_hfence_gvma_vmid_gpa(unsigned long vmid,
 	}
 }
 
-void kvm_riscv_local_hfence_gvma_vmid_all(unsigned long vmid)
+void kvm_riscv_local_hfence_gvma_vmid_all(xlen_t vmid)
 {
 	asm volatile(HFENCE_GVMA(zero, %0) : : "r" (vmid) : "memory");
 }
 
 void kvm_riscv_local_hfence_gvma_gpa(gpa_t gpa, gpa_t gpsz,
-				     unsigned long order)
+				     xlen_t order)
 {
 	gpa_t pos;
 
@@ -75,13 +75,14 @@ void kvm_riscv_local_hfence_gvma_all(void)
 	asm volatile(HFENCE_GVMA(zero, zero) : : : "memory");
 }
 
-void kvm_riscv_local_hfence_vvma_asid_gva(unsigned long vmid,
-					  unsigned long asid,
-					  unsigned long gva,
-					  unsigned long gvsz,
-					  unsigned long order)
+void kvm_riscv_local_hfence_vvma_asid_gva(xlen_t vmid,
+					  xlen_t asid,
+					  xlen_t gva,
+					  xlen_t gvsz,
+					  xlen_t order)
 {
-	unsigned long pos, hgatp;
+	xlen_t pos;
+	xlen_t hgatp;
 
 	if (PTRS_PER_PTE < (gvsz >> order)) {
 		kvm_riscv_local_hfence_vvma_asid_all(vmid, asid);
@@ -105,10 +106,10 @@ void kvm_riscv_local_hfence_vvma_asid_gva(unsigned long vmid,
 	csr_write(CSR_HGATP, hgatp);
 }
 
-void kvm_riscv_local_hfence_vvma_asid_all(unsigned long vmid,
-					  unsigned long asid)
+void kvm_riscv_local_hfence_vvma_asid_all(xlen_t vmid,
+					  xlen_t asid)
 {
-	unsigned long hgatp;
+	xlen_t hgatp;
 
 	hgatp = csr_swap(CSR_HGATP, vmid << HGATP_VMID_SHIFT);
 
@@ -117,11 +118,12 @@ void kvm_riscv_local_hfence_vvma_asid_all(unsigned long vmid,
 	csr_write(CSR_HGATP, hgatp);
 }
 
-void kvm_riscv_local_hfence_vvma_gva(unsigned long vmid,
-				     unsigned long gva, unsigned long gvsz,
-				     unsigned long order)
+void kvm_riscv_local_hfence_vvma_gva(xlen_t vmid,
+				     xlen_t gva, xlen_t gvsz,
+				     xlen_t order)
 {
-	unsigned long pos, hgatp;
+	xlen_t pos;
+	xlen_t hgatp;
 
 	if (PTRS_PER_PTE < (gvsz >> order)) {
 		kvm_riscv_local_hfence_vvma_all(vmid);
@@ -145,9 +147,9 @@ void kvm_riscv_local_hfence_vvma_gva(unsigned long vmid,
 	csr_write(CSR_HGATP, hgatp);
 }
 
-void kvm_riscv_local_hfence_vvma_all(unsigned long vmid)
+void kvm_riscv_local_hfence_vvma_all(xlen_t vmid)
 {
-	unsigned long hgatp;
+	xlen_t hgatp;
 
 	hgatp = csr_swap(CSR_HGATP, vmid << HGATP_VMID_SHIFT);
 
@@ -158,7 +160,7 @@ void kvm_riscv_local_hfence_vvma_all(unsigned long vmid)
 
 void kvm_riscv_local_tlb_sanitize(struct kvm_vcpu *vcpu)
 {
-	unsigned long vmid;
+	xlen_t vmid;
 
 	if (!kvm_riscv_gstage_vmid_bits() ||
 	    vcpu->arch.last_exit_cpu == vcpu->cpu)
@@ -188,7 +190,7 @@ void kvm_riscv_fence_i_process(struct kvm_vcpu *vcpu)
 void kvm_riscv_hfence_gvma_vmid_all_process(struct kvm_vcpu *vcpu)
 {
 	struct kvm_vmid *v = &vcpu->kvm->arch.vmid;
-	unsigned long vmid = READ_ONCE(v->vmid);
+	xlen_t vmid = READ_ONCE(v->vmid);
 
 	if (kvm_riscv_nacl_available())
 		nacl_hfence_gvma_vmid_all(nacl_shmem(), vmid);
@@ -199,7 +201,7 @@ void kvm_riscv_hfence_gvma_vmid_all_process(struct kvm_vcpu *vcpu)
 void kvm_riscv_hfence_vvma_all_process(struct kvm_vcpu *vcpu)
 {
 	struct kvm_vmid *v = &vcpu->kvm->arch.vmid;
-	unsigned long vmid = READ_ONCE(v->vmid);
+	xlen_t vmid = READ_ONCE(v->vmid);
 
 	if (kvm_riscv_nacl_available())
 		nacl_hfence_vvma_all(nacl_shmem(), vmid);
@@ -258,7 +260,7 @@ static bool vcpu_hfence_enqueue(struct kvm_vcpu *vcpu,
 
 void kvm_riscv_hfence_process(struct kvm_vcpu *vcpu)
 {
-	unsigned long vmid;
+	xlen_t vmid;
 	struct kvm_riscv_hfence d = { 0 };
 	struct kvm_vmid *v = &vcpu->kvm->arch.vmid;
 
@@ -310,7 +312,7 @@ void kvm_riscv_hfence_process(struct kvm_vcpu *vcpu)
 }
 
 static void make_xfence_request(struct kvm *kvm,
-				unsigned long hbase, unsigned long hmask,
+				xlen_t hbase, xlen_t hmask,
 				unsigned int req, unsigned int fallback_req,
 				const struct kvm_riscv_hfence *data)
 {
@@ -346,16 +348,16 @@ static void make_xfence_request(struct kvm *kvm,
 }
 
 void kvm_riscv_fence_i(struct kvm *kvm,
-		       unsigned long hbase, unsigned long hmask)
+		       xlen_t hbase, xlen_t hmask)
 {
 	make_xfence_request(kvm, hbase, hmask, KVM_REQ_FENCE_I,
 			    KVM_REQ_FENCE_I, NULL);
 }
 
 void kvm_riscv_hfence_gvma_vmid_gpa(struct kvm *kvm,
-				    unsigned long hbase, unsigned long hmask,
+				    xlen_t hbase, xlen_t hmask,
 				    gpa_t gpa, gpa_t gpsz,
-				    unsigned long order)
+				    xlen_t order)
 {
 	struct kvm_riscv_hfence data;
 
@@ -369,16 +371,16 @@ void kvm_riscv_hfence_gvma_vmid_gpa(struct kvm *kvm,
 }
 
 void kvm_riscv_hfence_gvma_vmid_all(struct kvm *kvm,
-				    unsigned long hbase, unsigned long hmask)
+				    xlen_t hbase, xlen_t hmask)
 {
 	make_xfence_request(kvm, hbase, hmask, KVM_REQ_HFENCE_GVMA_VMID_ALL,
 			    KVM_REQ_HFENCE_GVMA_VMID_ALL, NULL);
 }
 
 void kvm_riscv_hfence_vvma_asid_gva(struct kvm *kvm,
-				    unsigned long hbase, unsigned long hmask,
-				    unsigned long gva, unsigned long gvsz,
-				    unsigned long order, unsigned long asid)
+				    xlen_t hbase, xlen_t hmask,
+				    xlen_t gva, xlen_t gvsz,
+				    xlen_t order, xlen_t asid)
 {
 	struct kvm_riscv_hfence data;
 
@@ -392,8 +394,8 @@ void kvm_riscv_hfence_vvma_asid_gva(struct kvm *kvm,
 }
 
 void kvm_riscv_hfence_vvma_asid_all(struct kvm *kvm,
-				    unsigned long hbase, unsigned long hmask,
-				    unsigned long asid)
+				    xlen_t hbase, xlen_t hmask,
+				    xlen_t asid)
 {
 	struct kvm_riscv_hfence data;
 
@@ -405,9 +407,9 @@ void kvm_riscv_hfence_vvma_asid_all(struct kvm *kvm,
 }
 
 void kvm_riscv_hfence_vvma_gva(struct kvm *kvm,
-			       unsigned long hbase, unsigned long hmask,
-			       unsigned long gva, unsigned long gvsz,
-			       unsigned long order)
+			       xlen_t hbase, xlen_t hmask,
+			       xlen_t gva, xlen_t gvsz,
+			       xlen_t order)
 {
 	struct kvm_riscv_hfence data;
 
@@ -421,7 +423,7 @@ void kvm_riscv_hfence_vvma_gva(struct kvm *kvm,
 }
 
 void kvm_riscv_hfence_vvma_all(struct kvm *kvm,
-			       unsigned long hbase, unsigned long hmask)
+			       xlen_t hbase, xlen_t hmask)
 {
 	make_xfence_request(kvm, hbase, hmask, KVM_REQ_HFENCE_VVMA_ALL,
 			    KVM_REQ_HFENCE_VVMA_ALL, NULL);
diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
index 60d684c76c58..144e25ead287 100644
--- a/arch/riscv/kvm/vcpu.c
+++ b/arch/riscv/kvm/vcpu.c
@@ -797,11 +797,11 @@ static void noinstr kvm_riscv_vcpu_enter_exit(struct kvm_vcpu *vcpu,
 		if (kvm_riscv_nacl_autoswap_csr_available()) {
 			hcntx->hstatus =
 				nacl_csr_read(nsh, CSR_HSTATUS);
-			nacl_scratch_write_long(nsh,
+			nacl_scratch_write_csr(nsh,
 						SBI_NACL_SHMEM_AUTOSWAP_OFFSET +
 						SBI_NACL_SHMEM_AUTOSWAP_HSTATUS,
 						gcntx->hstatus);
-			nacl_scratch_write_long(nsh,
+			nacl_scratch_write_csr(nsh,
 						SBI_NACL_SHMEM_AUTOSWAP_OFFSET,
 						SBI_NACL_SHMEM_AUTOSWAP_FLAG_HSTATUS);
 		} else if (kvm_riscv_nacl_sync_csr_available()) {
@@ -811,7 +811,7 @@ static void noinstr kvm_riscv_vcpu_enter_exit(struct kvm_vcpu *vcpu,
 			hcntx->hstatus = csr_swap(CSR_HSTATUS, gcntx->hstatus);
 		}
 
-		nacl_scratch_write_longs(nsh,
+		nacl_scratch_write_csrs(nsh,
 					 SBI_NACL_SHMEM_SRET_OFFSET +
 					 SBI_NACL_SHMEM_SRET_X(1),
 					 &gcntx->ra,
@@ -821,10 +821,10 @@ static void noinstr kvm_riscv_vcpu_enter_exit(struct kvm_vcpu *vcpu,
 					   SBI_EXT_NACL_SYNC_SRET);
 
 		if (kvm_riscv_nacl_autoswap_csr_available()) {
-			nacl_scratch_write_long(nsh,
+			nacl_scratch_write_csr(nsh,
 						SBI_NACL_SHMEM_AUTOSWAP_OFFSET,
 						0);
-			gcntx->hstatus = nacl_scratch_read_long(nsh,
+			gcntx->hstatus = nacl_scratch_read_csr(nsh,
 								SBI_NACL_SHMEM_AUTOSWAP_OFFSET +
 								SBI_NACL_SHMEM_AUTOSWAP_HSTATUS);
 		} else {
diff --git a/arch/riscv/kvm/vcpu_exit.c b/arch/riscv/kvm/vcpu_exit.c
index 6e0c18412795..0f6b80d87825 100644
--- a/arch/riscv/kvm/vcpu_exit.c
+++ b/arch/riscv/kvm/vcpu_exit.c
@@ -246,11 +246,11 @@ int kvm_riscv_vcpu_exit(struct kvm_vcpu *vcpu, struct kvm_run *run,
 	/* Print details in-case of error */
 	if (ret < 0) {
 		kvm_err("VCPU exit error %d\n", ret);
-		kvm_err("SEPC=0x%lx SSTATUS=0x%lx HSTATUS=0x%lx\n",
+		kvm_err("SEPC=0x" REG_FMT "SSTATUS=0x" REG_FMT " HSTATUS=0x" REG_FMT "\n",
 			vcpu->arch.guest_context.sepc,
 			vcpu->arch.guest_context.sstatus,
 			vcpu->arch.guest_context.hstatus);
-		kvm_err("SCAUSE=0x%lx STVAL=0x%lx HTVAL=0x%lx HTINST=0x%lx\n",
+		kvm_err("SCAUSE=0x" REG_FMT " STVAL=0x" REG_FMT " HTVAL=0x" REG_FMT " HTINST=0x" REG_FMT "\n",
 			trap->scause, trap->stval, trap->htval, trap->htinst);
 	}
 
diff --git a/arch/riscv/kvm/vcpu_insn.c b/arch/riscv/kvm/vcpu_insn.c
index 97dec18e6989..c25415d63d96 100644
--- a/arch/riscv/kvm/vcpu_insn.c
+++ b/arch/riscv/kvm/vcpu_insn.c
@@ -221,13 +221,13 @@ struct csr_func {
 	 * "struct insn_func".
 	 */
 	int (*func)(struct kvm_vcpu *vcpu, unsigned int csr_num,
-		    unsigned long *val, unsigned long new_val,
-		    unsigned long wr_mask);
+		    xlen_t *val, xlen_t new_val,
+		    xlen_t wr_mask);
 };
 
 static int seed_csr_rmw(struct kvm_vcpu *vcpu, unsigned int csr_num,
-			unsigned long *val, unsigned long new_val,
-			unsigned long wr_mask)
+			xlen_t *val, xlen_t new_val,
+			xlen_t wr_mask)
 {
 	if (!riscv_isa_extension_available(vcpu->arch.isa, ZKR))
 		return KVM_INSN_ILLEGAL_TRAP;
@@ -275,9 +275,9 @@ static int csr_insn(struct kvm_vcpu *vcpu, struct kvm_run *run, ulong insn)
 	int i, rc = KVM_INSN_ILLEGAL_TRAP;
 	unsigned int csr_num = insn >> SH_RS2;
 	unsigned int rs1_num = (insn >> SH_RS1) & MASK_RX;
-	ulong rs1_val = GET_RS1(insn, &vcpu->arch.guest_context);
+	xlen_t rs1_val = GET_RS1(insn, &vcpu->arch.guest_context);
 	const struct csr_func *tcfn, *cfn = NULL;
-	ulong val = 0, wr_mask = 0, new_val = 0;
+	xlen_t val = 0, wr_mask = 0, new_val = 0;
 
 	/* Decode the CSR instruction */
 	switch (GET_FUNCT3(insn)) {
diff --git a/arch/riscv/kvm/vcpu_onereg.c b/arch/riscv/kvm/vcpu_onereg.c
index f6d27b59c641..34e11fbe27e8 100644
--- a/arch/riscv/kvm/vcpu_onereg.c
+++ b/arch/riscv/kvm/vcpu_onereg.c
@@ -448,7 +448,7 @@ static int kvm_riscv_vcpu_set_reg_core(struct kvm_vcpu *vcpu,
 
 static int kvm_riscv_vcpu_general_get_csr(struct kvm_vcpu *vcpu,
 					  unsigned long reg_num,
-					  unsigned long *out_val)
+					  xlen_t *out_val)
 {
 	struct kvm_vcpu_csr *csr = &vcpu->arch.guest_csr;
 
@@ -494,24 +494,24 @@ static inline int kvm_riscv_vcpu_smstateen_set_csr(struct kvm_vcpu *vcpu,
 	struct kvm_vcpu_smstateen_csr *csr = &vcpu->arch.smstateen_csr;
 
 	if (reg_num >= sizeof(struct kvm_riscv_smstateen_csr) /
-		sizeof(unsigned long))
+		sizeof(xlen_t))
 		return -EINVAL;
 
-	((unsigned long *)csr)[reg_num] = reg_val;
+	((xlen_t *)csr)[reg_num] = reg_val;
 	return 0;
 }
 
 static int kvm_riscv_vcpu_smstateen_get_csr(struct kvm_vcpu *vcpu,
 					    unsigned long reg_num,
-					    unsigned long *out_val)
+					    xlen_t *out_val)
 {
 	struct kvm_vcpu_smstateen_csr *csr = &vcpu->arch.smstateen_csr;
 
 	if (reg_num >= sizeof(struct kvm_riscv_smstateen_csr) /
-		sizeof(unsigned long))
+		sizeof(xlen_t))
 		return -EINVAL;
 
-	*out_val = ((unsigned long *)csr)[reg_num];
+	*out_val = ((xlen_t *)csr)[reg_num];
 	return 0;
 }
 
@@ -519,12 +519,12 @@ static int kvm_riscv_vcpu_get_reg_csr(struct kvm_vcpu *vcpu,
 				      const struct kvm_one_reg *reg)
 {
 	int rc;
-	unsigned long __user *uaddr =
-			(unsigned long __user *)(unsigned long)reg->addr;
+	xlen_t __user *uaddr =
+			(xlen_t __user *)(unsigned long)reg->addr;
 	unsigned long reg_num = reg->id & ~(KVM_REG_ARCH_MASK |
 					    KVM_REG_SIZE_MASK |
 					    KVM_REG_RISCV_CSR);
-	unsigned long reg_val, reg_subtype;
+	xlen_t reg_val, reg_subtype;
 
 	if (KVM_REG_SIZE(reg->id) != sizeof(unsigned long))
 		return -EINVAL;
diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
index 2707a51b082c..3bfecda72150 100644
--- a/arch/riscv/kvm/vcpu_pmu.c
+++ b/arch/riscv/kvm/vcpu_pmu.c
@@ -198,7 +198,7 @@ static int pmu_get_pmc_index(struct kvm_pmu *pmu, unsigned long eidx,
 }
 
 static int pmu_fw_ctr_read_hi(struct kvm_vcpu *vcpu, unsigned long cidx,
-			      unsigned long *out_val)
+			      xlen_t *out_val)
 {
 	struct kvm_pmu *kvpmu = vcpu_to_pmu(vcpu);
 	struct kvm_pmc *pmc;
@@ -228,7 +228,7 @@ static int pmu_fw_ctr_read_hi(struct kvm_vcpu *vcpu, unsigned long cidx,
 }
 
 static int pmu_ctr_read(struct kvm_vcpu *vcpu, unsigned long cidx,
-			unsigned long *out_val)
+			xlen_t *out_val)
 {
 	struct kvm_pmu *kvpmu = vcpu_to_pmu(vcpu);
 	struct kvm_pmc *pmc;
@@ -354,8 +354,8 @@ int kvm_riscv_vcpu_pmu_incr_fw(struct kvm_vcpu *vcpu, unsigned long fid)
 }
 
 int kvm_riscv_vcpu_pmu_read_hpm(struct kvm_vcpu *vcpu, unsigned int csr_num,
-				unsigned long *val, unsigned long new_val,
-				unsigned long wr_mask)
+				xlen_t *val, xlen_t new_val,
+				xlen_t wr_mask)
 {
 	struct kvm_pmu *kvpmu = vcpu_to_pmu(vcpu);
 	int cidx, ret = KVM_INSN_CONTINUE_NEXT_SEPC;
diff --git a/arch/riscv/kvm/vcpu_sbi_base.c b/arch/riscv/kvm/vcpu_sbi_base.c
index 5bc570b984f4..a243339a73fd 100644
--- a/arch/riscv/kvm/vcpu_sbi_base.c
+++ b/arch/riscv/kvm/vcpu_sbi_base.c
@@ -18,7 +18,7 @@ static int kvm_sbi_ext_base_handler(struct kvm_vcpu *vcpu, struct kvm_run *run,
 {
 	struct kvm_cpu_context *cp = &vcpu->arch.guest_context;
 	const struct kvm_vcpu_sbi_extension *sbi_ext;
-	unsigned long *out_val = &retdata->out_val;
+	xlen_t *out_val = &retdata->out_val;
 
 	switch (cp->a6) {
 	case SBI_EXT_BASE_GET_SPEC_VERSION:
diff --git a/arch/riscv/kvm/vmid.c b/arch/riscv/kvm/vmid.c
index ddc98714ce8e..17744dfaf008 100644
--- a/arch/riscv/kvm/vmid.c
+++ b/arch/riscv/kvm/vmid.c
@@ -17,7 +17,7 @@
 
 static unsigned long vmid_version = 1;
 static unsigned long vmid_next;
-static unsigned long vmid_bits __ro_after_init;
+static xlen_t vmid_bits __ro_after_init;
 static DEFINE_SPINLOCK(vmid_lock);
 
 void __init kvm_riscv_gstage_vmid_detect(void)
@@ -40,7 +40,7 @@ void __init kvm_riscv_gstage_vmid_detect(void)
 		vmid_bits = 0;
 }
 
-unsigned long kvm_riscv_gstage_vmid_bits(void)
+xlen_t kvm_riscv_gstage_vmid_bits(void)
 {
 	return vmid_bits;
 }
-- 
2.40.1


