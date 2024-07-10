Return-Path: <linux-fsdevel+bounces-23491-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB5E92D4D6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 17:17:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 708C2285F4A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 15:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06ABA1946C0;
	Wed, 10 Jul 2024 15:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F6jZQSP0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DAD819414B;
	Wed, 10 Jul 2024 15:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720624626; cv=none; b=T0Rcqdbjbl7GkiaBd82BY63zZNu/yoMs+DupI9M6XkbMRGhZy5piorM2Z7JKklONEZehXUXPnKAYKT5tLbvsXapllCS7kAoqjmFK/np85v29PWsjfRS21aBx4rXoLa80rMOdP8jfUPYrqBKzFTHfNSBvNrdi9ZD247vPb2/det4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720624626; c=relaxed/simple;
	bh=cIWgb+WwHCzNqFP0w9tgD3BNR/vixJLgr9imkGmex74=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GoIWz5y30bWwqDLX7ta47bhnMhkb+djXXrQ2xLvT+FIc4hILTMOSp/mBaD+n+VGnubNhkg01lFnwT9fWmhHse2xHFe+i7+w9MSgoZ6JzLMYQ/lM+W5PCekPuMb3VWkUwqQLoXIvZ9NG6uGa/kkLgOFARo83ZB1VdWm5+p9Dx8gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F6jZQSP0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CF81C4AF07;
	Wed, 10 Jul 2024 15:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720624625;
	bh=cIWgb+WwHCzNqFP0w9tgD3BNR/vixJLgr9imkGmex74=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=F6jZQSP0HMZGJ0kxmrpKUUXfbWtb/nG2GZybwT25OIn4HmzeV1eYP2SE2ynOBFgH6
	 yodT3lyTpiXhifuzZ5Z8LRe9JdI5gjjqQLmrn/LkhyCnafGBnukgD+po3Rt60CE0rX
	 aCwtvcxPgM1/dfqW1iBkzr4RF0e3uT4k8gt1yIuLXDw8NEpklpS+mi/EDBScCE1Q7W
	 cmPj/s21BeYokNON74pL6qewB5oLS/j/OSz8E2R/o+za1z38PkhF5jmqQM8isuW3tu
	 B12cyw40htlHjuOy1GGJBTinEW/egxG+O8okSWQ4M7/ysH883WHuM6KPR/I/AcIVaV
	 wQiEdapMcQpPA==
Received: from sofa.misterjones.org ([185.219.108.64] helo=goblin-girl.misterjones.org)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1sRZ42-00BFfJ-O7;
	Wed, 10 Jul 2024 16:17:02 +0100
Date: Wed, 10 Jul 2024 16:17:02 +0100
Message-ID: <86v81d2s5t.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Oleg Nesterov <oleg@redhat.com>,
	Eric Biederman <ebiederm@xmission.com>,
	Shuah Khan <shuah@kernel.org>,
	"Rick P. Edgecombe" <rick.p.edgecombe@intel.com>,
	Deepak Gupta <debug@rivosinc.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
	Kees Cook <kees@kernel.org>,
	"H.J. Lu" <hjl.tools@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Florian Weimer <fweimer@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Thiago Jung Bauermann <thiago.bauermann@linaro.org>,
	Ross Burton <ross.burton@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	kvmarm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v9 13/39] KVM: arm64: Manage GCS registers for guests
In-Reply-To: <20240625-arm64-gcs-v9-13-0f634469b8f0@kernel.org>
References: <20240625-arm64-gcs-v9-0-0f634469b8f0@kernel.org>
	<20240625-arm64-gcs-v9-13-0f634469b8f0@kernel.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/29.3
 (aarch64-unknown-linux-gnu) MULE/6.0 (HANACHIRUSATO)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: broonie@kernel.org, catalin.marinas@arm.com, will@kernel.org, corbet@lwn.net, akpm@linux-foundation.org, oliver.upton@linux.dev, james.morse@arm.com, suzuki.poulose@arm.com, arnd@arndb.de, oleg@redhat.com, ebiederm@xmission.com, shuah@kernel.org, rick.p.edgecombe@intel.com, debug@rivosinc.com, ardb@kernel.org, Szabolcs.Nagy@arm.com, kees@kernel.org, hjl.tools@gmail.com, paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, fweimer@redhat.com, brauner@kernel.org, thiago.bauermann@linaro.org, ross.burton@arm.com, linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On Tue, 25 Jun 2024 15:57:41 +0100,
Mark Brown <broonie@kernel.org> wrote:
> 
> GCS introduces a number of system registers for EL1 and EL0, on systems
> with GCS we need to context switch them and expose them to VMMs to allow
> guests to use GCS, as well as describe their fine grained traps to
> nested virtualisation.  Traps are already disabled.

I don't see anything related to FGTs at all.

> 
> Reviewed-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  arch/arm64/include/asm/kvm_host.h          | 14 +++++++++
>  arch/arm64/include/asm/vncr_mapping.h      |  2 ++
>  arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h | 48 +++++++++++++++++++++++-------
>  arch/arm64/kvm/sys_regs.c                  | 25 +++++++++++++++-
>  4 files changed, 78 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index 36b8e97bf49e..316fb412f355 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -411,6 +411,10 @@ enum vcpu_sysreg {
>  	GCR_EL1,	/* Tag Control Register */
>  	TFSRE0_EL1,	/* Tag Fault Status Register (EL0) */
>  
> +	/* Guarded Control Stack registers */
> +	GCSCRE0_EL1,	/* Guarded Control Stack Control (EL0) */
> +	GCSPR_EL0,	/* Guarded Control Stack Pointer (EL0) */
> +
>  	/* 32bit specific registers. */
>  	DACR32_EL2,	/* Domain Access Control Register */
>  	IFSR32_EL2,	/* Instruction Fault Status Register */
> @@ -481,6 +485,10 @@ enum vcpu_sysreg {
>  	VNCR(PIR_EL1),	 /* Permission Indirection Register 1 (EL1) */
>  	VNCR(PIRE0_EL1), /*  Permission Indirection Register 0 (EL1) */
>  
> +	/* Guarded Control Stack registers */
> +	VNCR(GCSPR_EL1),	/* Guarded Control Stack Pointer (EL1) */
> +	VNCR(GCSCR_EL1),	/* Guarded Control Stack Control (EL1) */
> +
>  	VNCR(HFGRTR_EL2),
>  	VNCR(HFGWTR_EL2),
>  	VNCR(HFGITR_EL2),
> @@ -1343,6 +1351,12 @@ static inline bool __vcpu_has_feature(const struct kvm_arch *ka, int feature)
>  
>  #define kvm_vcpu_initialized(v) vcpu_get_flag(vcpu, VCPU_INITIALIZED)
>  
> +static inline bool has_gcs(void)
> +{
> +	return IS_ENABLED(CONFIG_ARM64_GCS) &&
> +		cpus_have_final_cap(ARM64_HAS_GCS);
> +}

This is mostly useless, see below.

> +
>  int kvm_trng_call(struct kvm_vcpu *vcpu);
>  #ifdef CONFIG_KVM
>  extern phys_addr_t hyp_mem_base;
> diff --git a/arch/arm64/include/asm/vncr_mapping.h b/arch/arm64/include/asm/vncr_mapping.h
> index df2c47c55972..5e83e6f579fd 100644
> --- a/arch/arm64/include/asm/vncr_mapping.h
> +++ b/arch/arm64/include/asm/vncr_mapping.h
> @@ -88,6 +88,8 @@
>  #define VNCR_PMSIRR_EL1         0x840
>  #define VNCR_PMSLATFR_EL1       0x848
>  #define VNCR_TRFCR_EL1          0x880
> +#define VNCR_GCSPR_EL1		0x8C0
> +#define VNCR_GCSCR_EL1		0x8D0
>  #define VNCR_MPAM1_EL1          0x900
>  #define VNCR_MPAMHCR_EL2        0x930
>  #define VNCR_MPAMVPMV_EL2       0x938
> diff --git a/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h b/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
> index 4be6a7fa0070..b20212d80e9b 100644
> --- a/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
> +++ b/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
> @@ -16,6 +16,27 @@
>  #include <asm/kvm_hyp.h>
>  #include <asm/kvm_mmu.h>
>  
> +static inline struct kvm_vcpu *ctxt_to_vcpu(struct kvm_cpu_context *ctxt)
> +{
> +	struct kvm_vcpu *vcpu = ctxt->__hyp_running_vcpu;
> +
> +	if (!vcpu)
> +		vcpu = container_of(ctxt, struct kvm_vcpu, arch.ctxt);
> +
> +	return vcpu;
> +}
> +
> +static inline bool ctxt_has_gcs(struct kvm_cpu_context *ctxt)
> +{
> +	struct kvm_vcpu *vcpu;
> +
> +	if (!cpus_have_final_cap(ARM64_HAS_GCS))
> +		return false;
> +
> +	vcpu = ctxt_to_vcpu(ctxt);
> +	return kvm_has_feat(kern_hyp_va(vcpu->kvm), ID_AA64PFR1_EL1, GCS, IMP);
> +}
> +
>  static inline void __sysreg_save_common_state(struct kvm_cpu_context *ctxt)
>  {
>  	ctxt_sys_reg(ctxt, MDSCR_EL1)	= read_sysreg(mdscr_el1);
> @@ -25,16 +46,8 @@ static inline void __sysreg_save_user_state(struct kvm_cpu_context *ctxt)
>  {
>  	ctxt_sys_reg(ctxt, TPIDR_EL0)	= read_sysreg(tpidr_el0);
>  	ctxt_sys_reg(ctxt, TPIDRRO_EL0)	= read_sysreg(tpidrro_el0);
> -}
> -
> -static inline struct kvm_vcpu *ctxt_to_vcpu(struct kvm_cpu_context *ctxt)
> -{
> -	struct kvm_vcpu *vcpu = ctxt->__hyp_running_vcpu;
> -
> -	if (!vcpu)
> -		vcpu = container_of(ctxt, struct kvm_vcpu, arch.ctxt);
> -
> -	return vcpu;
> +	if (ctxt_has_gcs(ctxt))
> +		ctxt_sys_reg(ctxt, GCSPR_EL0) = read_sysreg_s(SYS_GCSPR_EL0);
>  }
>  
>  static inline bool ctxt_has_mte(struct kvm_cpu_context *ctxt)
> @@ -80,6 +93,12 @@ static inline void __sysreg_save_el1_state(struct kvm_cpu_context *ctxt)
>  	ctxt_sys_reg(ctxt, PAR_EL1)	= read_sysreg_par();
>  	ctxt_sys_reg(ctxt, TPIDR_EL1)	= read_sysreg(tpidr_el1);
>  
> +	if (ctxt_has_gcs(ctxt)) {

Since this is conditioned on S1PIE, it should be only be evaluated
when PIE is enabled in the guest.

> +		ctxt_sys_reg(ctxt, GCSPR_EL1)	= read_sysreg_el1(SYS_GCSPR);
> +		ctxt_sys_reg(ctxt, GCSCR_EL1)	= read_sysreg_el1(SYS_GCSCR);
> +		ctxt_sys_reg(ctxt, GCSCRE0_EL1)	= read_sysreg_s(SYS_GCSCRE0_EL1);

Why is this part of the EL1 context? It clearly only matters to EL0
execution, so it could be switched in load/put on nVHE as well. And
actually, given that the whole thing is strictly for userspace, why do
we switch *anything* eagerly at all?

> +	}
> +
>  	if (ctxt_has_mte(ctxt)) {
>  		ctxt_sys_reg(ctxt, TFSR_EL1) = read_sysreg_el1(SYS_TFSR);
>  		ctxt_sys_reg(ctxt, TFSRE0_EL1) = read_sysreg_s(SYS_TFSRE0_EL1);
> @@ -113,6 +132,8 @@ static inline void __sysreg_restore_user_state(struct kvm_cpu_context *ctxt)
>  {
>  	write_sysreg(ctxt_sys_reg(ctxt, TPIDR_EL0),	tpidr_el0);
>  	write_sysreg(ctxt_sys_reg(ctxt, TPIDRRO_EL0),	tpidrro_el0);
> +	if (ctxt_has_gcs(ctxt))
> +		write_sysreg_s(ctxt_sys_reg(ctxt, GCSPR_EL0), SYS_GCSPR_EL0);
>  }
>  
>  static inline void __sysreg_restore_el1_state(struct kvm_cpu_context *ctxt)
> @@ -156,6 +177,13 @@ static inline void __sysreg_restore_el1_state(struct kvm_cpu_context *ctxt)
>  	write_sysreg(ctxt_sys_reg(ctxt, PAR_EL1),	par_el1);
>  	write_sysreg(ctxt_sys_reg(ctxt, TPIDR_EL1),	tpidr_el1);
>  
> +	if (ctxt_has_gcs(ctxt)) {
> +		write_sysreg_el1(ctxt_sys_reg(ctxt, GCSPR_EL1),	SYS_GCSPR);
> +		write_sysreg_el1(ctxt_sys_reg(ctxt, GCSCR_EL1),	SYS_GCSCR);
> +		write_sysreg_s(ctxt_sys_reg(ctxt, GCSCRE0_EL1),
> +			       SYS_GCSCRE0_EL1);
> +	}
> +
>  	if (ctxt_has_mte(ctxt)) {
>  		write_sysreg_el1(ctxt_sys_reg(ctxt, TFSR_EL1), SYS_TFSR);
>  		write_sysreg_s(ctxt_sys_reg(ctxt, TFSRE0_EL1), SYS_TFSRE0_EL1);
> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index 22b45a15d068..cf068dcfbd49 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -2015,6 +2015,23 @@ static unsigned int mte_visibility(const struct kvm_vcpu *vcpu,
>  	.visibility = mte_visibility,		\
>  }
>  
> +static unsigned int gcs_visibility(const struct kvm_vcpu *vcpu,
> +				   const struct sys_reg_desc *rd)
> +{
> +	if (has_gcs())
> +		return 0;

No. we've been here before.

> +
> +	return REG_HIDDEN;
> +}
> +
> +#define GCS_REG(name) {				\
> +	SYS_DESC(SYS_##name),			\
> +	.access = undef_access,			\
> +	.reset = reset_unknown,			\
> +	.reg = name,				\
> +	.visibility = gcs_visibility,		\
> +}
> +
>  static unsigned int el2_visibility(const struct kvm_vcpu *vcpu,
>  				   const struct sys_reg_desc *rd)
>  {
> @@ -2306,7 +2323,8 @@ static const struct sys_reg_desc sys_reg_descs[] = {
>  		   ID_AA64PFR0_EL1_GIC |
>  		   ID_AA64PFR0_EL1_AdvSIMD |
>  		   ID_AA64PFR0_EL1_FP), },
> -	ID_SANITISED(ID_AA64PFR1_EL1),
> +	ID_WRITABLE(ID_AA64PFR1_EL1, ~(ID_AA64PFR1_EL1_RES0 |
> +				       ID_AA64PFR1_EL1_BT)),

I don't know what you're trying to do here, but that's not right. If
you want to make this register writable, here's the shopping list:

https://lore.kernel.org/all/87ikxsi0v9.wl-maz@kernel.org/

>  	ID_UNALLOCATED(4,2),
>  	ID_UNALLOCATED(4,3),
>  	ID_WRITABLE(ID_AA64ZFR0_EL1, ~ID_AA64ZFR0_EL1_RES0),
> @@ -2390,6 +2408,10 @@ static const struct sys_reg_desc sys_reg_descs[] = {
>  	PTRAUTH_KEY(APDB),
>  	PTRAUTH_KEY(APGA),
>  
> +	GCS_REG(GCSCR_EL1),
> +	GCS_REG(GCSPR_EL1),
> +	GCS_REG(GCSCRE0_EL1),
> +
>  	{ SYS_DESC(SYS_SPSR_EL1), access_spsr},
>  	{ SYS_DESC(SYS_ELR_EL1), access_elr},
>  
> @@ -2476,6 +2498,7 @@ static const struct sys_reg_desc sys_reg_descs[] = {
>  	{ SYS_DESC(SYS_SMIDR_EL1), undef_access },
>  	{ SYS_DESC(SYS_CSSELR_EL1), access_csselr, reset_unknown, CSSELR_EL1 },
>  	{ SYS_DESC(SYS_CTR_EL0), access_ctr },
> +	GCS_REG(GCSPR_EL0),
>  	{ SYS_DESC(SYS_SVCR), undef_access },
>  
>  	{ PMU_SYS_REG(PMCR_EL0), .access = access_pmcr, .reset = reset_pmcr,

I don't see the vcpu's hcrx_el2 being updated to enable GCS. How does
it work then? I also don't see the FGU updates when GCS is disabled,
nor the corresponding FGT bits being marked as RES0.

	M.

-- 
Without deviation from the norm, progress is not possible.

