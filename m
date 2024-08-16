Return-Path: <linux-fsdevel+bounces-26124-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20FEA954C17
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2024 16:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCA9528809D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2024 14:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C2F81BD4EA;
	Fri, 16 Aug 2024 14:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JxVO7wAt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8872197554;
	Fri, 16 Aug 2024 14:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723817724; cv=none; b=PoBeLIsg2O91juX6OGs6WGcuS2ScpG33q9wOTd5b30jlVS8u6Ol4z2YutyuKRU47UBfUonEPN56gqBN4+CUkqtk0qPMriv2VLAywfGM7EpGoEI2+3U1c2/N+mcLSEsZFJThSo2c/vXzcT24wjDiGippdnJuzQpu39uFUfe0yk9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723817724; c=relaxed/simple;
	bh=Vz/Wd2ZHxd37E7Z0jSyjIj1PL80f2VReLdIf3pbBvs8=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Iegcd3/RL/KgryHJr1a8sw2KTEOfWj7YmEeeiCsjUaN8WgObxp52OSp9L1yIDUFc3xvWpCoMBZTm22DP7zF2QvIdYGFddB7HVbSQ5gcM8OX/aafOLXZvDSulhBcIxWJW2BkPQ0j0sJ302u4BwPrZLHaChOxUKhcKRKobl2BTxoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JxVO7wAt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB462C32782;
	Fri, 16 Aug 2024 14:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723817723;
	bh=Vz/Wd2ZHxd37E7Z0jSyjIj1PL80f2VReLdIf3pbBvs8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JxVO7wAtRgR3wjIOsJUIjXS2USfhU7zrVsQm/fbKiR8FAWdQgsH64NTt9c+ih7wP+
	 2Z/pzjMIJyO642Ql97Q0NCnFMlw4ZezSUjP4I+QLOOvzWJ2cftmh5LiHoPu1ZmCgQT
	 jylgxGPKmN05Qy5EVkQGFATEvXd5MjadYxB5SC5YqHY82zxZzUENZIIjq6CyGowaiq
	 wp88L/pVHpgwDYmlrOhaaZ4U5jgLPl/75SlAnmwnieaKsjlXzU9UcosG+sZbdVwqU2
	 r4YzyaIq+wVNKDJrfAq4FnDKN32n3O0Fz0SXI6oRbbfpmWl2fopnM1N1exUamVEiHi
	 hixkCwa4jfzVA==
Received: from sofa.misterjones.org ([185.219.108.64] helo=goblin-girl.misterjones.org)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1sexjc-004IRp-BE;
	Fri, 16 Aug 2024 15:15:20 +0100
Date: Fri, 16 Aug 2024 15:15:19 +0100
Message-ID: <86h6bkzh8o.wl-maz@kernel.org>
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
Subject: Re: [PATCH v10 14/40] KVM: arm64: Manage GCS access and registers for guests
In-Reply-To: <20240801-arm64-gcs-v10-14-699e2bd2190b@kernel.org>
References: <20240801-arm64-gcs-v10-0-699e2bd2190b@kernel.org>
	<20240801-arm64-gcs-v10-14-699e2bd2190b@kernel.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/29.4
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

On Thu, 01 Aug 2024 13:06:41 +0100,
Mark Brown <broonie@kernel.org> wrote:
> 
> GCS introduces a number of system registers for EL1 and EL0, on systems
> with GCS we need to context switch them and expose them to VMMs to allow
> guests to use GCS.
> 
> In order to allow guests to use GCS we also need to configure
> HCRX_EL2.GCSEn, if this is not set GCS instructions will be noops and
> CHKFEAT will report GCS as disabled.  Also enable fine grained traps for
> access to the GCS registers by guests which do not have the feature
> enabled.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  arch/arm64/include/asm/kvm_host.h          |  8 +++++
>  arch/arm64/include/asm/vncr_mapping.h      |  2 ++
>  arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h | 49 ++++++++++++++++++++++++------
>  arch/arm64/kvm/sys_regs.c                  | 12 ++++++++
>  4 files changed, 61 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index a33f5996ca9f..5818e4a1c2d1 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -446,6 +446,10 @@ enum vcpu_sysreg {
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
> @@ -517,6 +521,10 @@ enum vcpu_sysreg {
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
> index 4c0fdabaf8ae..ac29352e225a 100644
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
> @@ -25,16 +46,10 @@ static inline void __sysreg_save_user_state(struct kvm_cpu_context *ctxt)
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
> +	if (ctxt_has_gcs(ctxt)) {
> +		ctxt_sys_reg(ctxt, GCSPR_EL0) = read_sysreg_s(SYS_GCSPR_EL0);
> +		ctxt_sys_reg(ctxt, GCSCRE0_EL1)	= read_sysreg_s(SYS_GCSCRE0_EL1);
> +	}
>  }
>  
>  static inline bool ctxt_has_mte(struct kvm_cpu_context *ctxt)
> @@ -79,6 +94,10 @@ static inline void __sysreg_save_el1_state(struct kvm_cpu_context *ctxt)
>  		if (ctxt_has_s1pie(ctxt)) {
>  			ctxt_sys_reg(ctxt, PIR_EL1)	= read_sysreg_el1(SYS_PIR);
>  			ctxt_sys_reg(ctxt, PIRE0_EL1)	= read_sysreg_el1(SYS_PIRE0);
> +			if (ctxt_has_gcs(ctxt)) {
> +				ctxt_sys_reg(ctxt, GCSPR_EL1)	= read_sysreg_el1(SYS_GCSPR);
> +				ctxt_sys_reg(ctxt, GCSCR_EL1)	= read_sysreg_el1(SYS_GCSCR);
> +			}
>  		}
>  	}
>  	ctxt_sys_reg(ctxt, ESR_EL1)	= read_sysreg_el1(SYS_ESR);
> @@ -126,6 +145,11 @@ static inline void __sysreg_restore_user_state(struct kvm_cpu_context *ctxt)
>  {
>  	write_sysreg(ctxt_sys_reg(ctxt, TPIDR_EL0),	tpidr_el0);
>  	write_sysreg(ctxt_sys_reg(ctxt, TPIDRRO_EL0),	tpidrro_el0);
> +	if (ctxt_has_gcs(ctxt)) {
> +		write_sysreg_s(ctxt_sys_reg(ctxt, GCSPR_EL0), SYS_GCSPR_EL0);
> +		write_sysreg_s(ctxt_sys_reg(ctxt, GCSCRE0_EL1),
> +			       SYS_GCSCRE0_EL1);
> +	}
>  }
>  
>  static inline void __sysreg_restore_el1_state(struct kvm_cpu_context *ctxt)
> @@ -157,6 +181,11 @@ static inline void __sysreg_restore_el1_state(struct kvm_cpu_context *ctxt)
>  		if (ctxt_has_s1pie(ctxt)) {
>  			write_sysreg_el1(ctxt_sys_reg(ctxt, PIR_EL1),	SYS_PIR);
>  			write_sysreg_el1(ctxt_sys_reg(ctxt, PIRE0_EL1),	SYS_PIRE0);
> +
> +			if (ctxt_has_gcs(ctxt)) {
> +				write_sysreg_el1(ctxt_sys_reg(ctxt, GCSPR_EL1),	SYS_GCSPR);
> +				write_sysreg_el1(ctxt_sys_reg(ctxt, GCSCR_EL1),	SYS_GCSCR);
> +			}
>  		}
>  	}
>  	write_sysreg_el1(ctxt_sys_reg(ctxt, ESR_EL1),	SYS_ESR);
> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index c90324060436..ac98d3237130 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -2446,6 +2446,10 @@ static const struct sys_reg_desc sys_reg_descs[] = {
>  	PTRAUTH_KEY(APDB),
>  	PTRAUTH_KEY(APGA),
>  
> +	{ SYS_DESC(SYS_GCSCR_EL1), NULL, reset_val, GCSCR_EL1, 0 },
> +	{ SYS_DESC(SYS_GCSPR_EL1), NULL, reset_unknown, GCSPR_EL1 },
> +	{ SYS_DESC(SYS_GCSCRE0_EL1), NULL, reset_val, GCSCRE0_EL1, 0 },
> +

Global visibility for these registers? Why should we expose them to
userspace if the feature is neither present nor configured?

>  	{ SYS_DESC(SYS_SPSR_EL1), access_spsr},
>  	{ SYS_DESC(SYS_ELR_EL1), access_elr},
>  
> @@ -2535,6 +2539,7 @@ static const struct sys_reg_desc sys_reg_descs[] = {
>  			     CTR_EL0_IDC_MASK |
>  			     CTR_EL0_DminLine_MASK |
>  			     CTR_EL0_IminLine_MASK),
> +	{ SYS_DESC(SYS_GCSPR_EL0), NULL, reset_unknown, GCSPR_EL0 },
>  	{ SYS_DESC(SYS_SVCR), undef_access },
>  
>  	{ PMU_SYS_REG(PMCR_EL0), .access = access_pmcr, .reset = reset_pmcr,
> @@ -4560,6 +4565,9 @@ void kvm_calculate_traps(struct kvm_vcpu *vcpu)
>  
>  		if (kvm_has_feat(kvm, ID_AA64MMFR3_EL1, TCRX, IMP))
>  			vcpu->arch.hcrx_el2 |= HCRX_EL2_TCR2En;
> +
> +		if (kvm_has_feat(kvm, ID_AA64PFR1_EL1, GCS, IMP))
> +			vcpu->arch.hcrx_el2 |= HCRX_EL2_GCSEn;
>  	}
>  
>  	if (test_bit(KVM_ARCH_FLAG_FGU_INITIALIZED, &kvm->arch.flags))
> @@ -4604,6 +4612,10 @@ void kvm_calculate_traps(struct kvm_vcpu *vcpu)
>  		kvm->arch.fgu[HFGxTR_GROUP] |= (HFGxTR_EL2_nPIRE0_EL1 |
>  						HFGxTR_EL2_nPIR_EL1);
>  
> +	if (!kvm_has_feat(kvm, ID_AA64PFR1_EL1, GCS, IMP))
> +		kvm->arch.fgu[HFGxTR_GROUP] |= (HFGxTR_EL2_nGCS_EL0 |
> +						HFGxTR_EL2_nGCS_EL1);

How can this work if you don't handle ID_AA64PFR_EL1 being written to?
You are exposing GCS to all guests without giving the VMM an
opportunity to turn it off. This breaks A->B->A migration, which is
not acceptable.

	M.

-- 
Without deviation from the norm, progress is not possible.

