Return-Path: <linux-fsdevel+bounces-10251-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 744658496E9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 10:46:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F11CA1F24367
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 09:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E37A134B7;
	Mon,  5 Feb 2024 09:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bNRiIrQz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A36512E5C;
	Mon,  5 Feb 2024 09:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707126380; cv=none; b=a+6cQlGtdSaU+gRAaCYMSKhEPxv4SZZ67qdM47aFH77CIFWfgHi2y4/WTSZQESqUGMyR2w61W+gbn3P1uU4X9XbmqLsqF4uXDe7UwnJItf1BHyqNaPTTmuxUOKFtlOlqKB4ZLnH2haFDcpNts4YEIGMzes7CjyyJX1vM9TU6IxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707126380; c=relaxed/simple;
	bh=S97KO5vp8gvf1SplDj/NGWxNDyP6qbms4ZkJbU5yooM=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XEA2zJ8RREzSo45Awa4dWyhS/vRbhgp5miD3PZGVVC4BzVpK80uArNO5bdoqHfhMpPJQgR/huXlor/SYhM0gMQ2WFTN6Zzg6TxqMgVjKVMWXyGGVOwylD/Xbw27IHv0BzniSUH3G9xJbPji0oGnYWsfk3wHOrsx9vx2qYS1i9gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bNRiIrQz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEA44C433C7;
	Mon,  5 Feb 2024 09:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707126380;
	bh=S97KO5vp8gvf1SplDj/NGWxNDyP6qbms4ZkJbU5yooM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bNRiIrQzbsUHuNnGrTyP97HsR6a5ElJ8g/yOEAUSEgMLXjrD1wrompGhpSa784aDm
	 BOJIFakdCbJ0oLGWnXmjvko1iKXoIYs+tkYLq1ozX11wzikPpCorAkMLycbrZOjvfE
	 871aPrxCMtGwj9JCNpg8MCD/eVsBGYDb7chMM/moiMdAow6Dfks+AKxhryvwYjag+k
	 gquq3s0gH9ZJRp9Qlr44GigOojab3TfuwWgk7mC8ZOhtow2GGRAOxoRh6V4RJCpfs6
	 rCI57Q7MPII5wAtiDPmoNej4WLo/WmuWTqRu1K5rFDS7wdbrexH1SexDwC10KXdOIG
	 MtJ2paw/8y1YQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=goblin-girl.misterjones.org)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1rWvYO-000MhB-Iw;
	Mon, 05 Feb 2024 09:46:16 +0000
Date: Mon, 05 Feb 2024 09:46:16 +0000
Message-ID: <868r3z6y6v.wl-maz@kernel.org>
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
	Kees Cook <keescook@chromium.org>,
	Shuah Khan <shuah@kernel.org>,
	"Rick P. Edgecombe" <rick.p.edgecombe@intel.com>,
	Deepak Gupta <debug@rivosinc.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
	"H.J. Lu" <hjl.tools@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Florian Weimer <fweimer@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Thiago Jung Bauermann <thiago.bauermann@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	kvmarm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v8 13/38] KVM: arm64: Manage GCS registers for guests
In-Reply-To: <20240203-arm64-gcs-v8-13-c9fec77673ef@kernel.org>
References: <20240203-arm64-gcs-v8-0-c9fec77673ef@kernel.org>
	<20240203-arm64-gcs-v8-13-c9fec77673ef@kernel.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/29.1
 (aarch64-unknown-linux-gnu) MULE/6.0 (HANACHIRUSATO)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: broonie@kernel.org, catalin.marinas@arm.com, will@kernel.org, corbet@lwn.net, akpm@linux-foundation.org, oliver.upton@linux.dev, james.morse@arm.com, suzuki.poulose@arm.com, arnd@arndb.de, oleg@redhat.com, ebiederm@xmission.com, keescook@chromium.org, shuah@kernel.org, rick.p.edgecombe@intel.com, debug@rivosinc.com, ardb@kernel.org, Szabolcs.Nagy@arm.com, hjl.tools@gmail.com, paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, fweimer@redhat.com, brauner@kernel.org, thiago.bauermann@linaro.org, linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On Sat, 03 Feb 2024 12:25:39 +0000,
Mark Brown <broonie@kernel.org> wrote:
> 
> GCS introduces a number of system registers for EL1 and EL0, on systems

and EL2.

> with GCS we need to context switch them and expose them to VMMs to allow
> guests to use GCS, as well as describe their fine grained traps to
> nested virtualisation.  Traps are already disabled.

The latter is not true with NV, since the guest is in control of the
FGT registers.

> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  arch/arm64/include/asm/kvm_host.h          | 12 ++++++++++++
>  arch/arm64/kvm/emulate-nested.c            |  4 ++++
>  arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h | 17 +++++++++++++++++
>  arch/arm64/kvm/sys_regs.c                  | 22 ++++++++++++++++++++++
>  4 files changed, 55 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index 21c57b812569..6c7ea7f9cd92 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -388,6 +388,12 @@ enum vcpu_sysreg {
>  	GCR_EL1,	/* Tag Control Register */
>  	TFSRE0_EL1,	/* Tag Fault Status Register (EL0) */
>  
> +	/* Guarded Control Stack registers */
> +	GCSCRE0_EL1,	/* Guarded Control Stack Control (EL0) */
> +	GCSCR_EL1,	/* Guarded Control Stack Control (EL1) */

This is subjected to VNCR (0x8D0).

> +	GCSPR_EL0,	/* Guarded Control Stack Pointer (EL0) */
> +	GCSPR_EL1,	/* Guarded Control Stack Pointer (EL1) */

So is this one (0x8C0). And how about the *_EL2 versions?

> +
>  	/* 32bit specific registers. */
>  	DACR32_EL2,	/* Domain Access Control Register */
>  	IFSR32_EL2,	/* Instruction Fault Status Register */
> @@ -1221,6 +1227,12 @@ static inline bool __vcpu_has_feature(const struct kvm_arch *ka, int feature)
>  
>  #define vcpu_has_feature(v, f)	__vcpu_has_feature(&(v)->kvm->arch, (f))
>  
> +static inline bool has_gcs(void)
> +{
> +	return IS_ENABLED(CONFIG_ARM64_GCS) &&
> +		cpus_have_final_cap(ARM64_HAS_GCS);
> +}
> +
>  int kvm_trng_call(struct kvm_vcpu *vcpu);
>  #ifdef CONFIG_KVM
>  extern phys_addr_t hyp_mem_base;
> diff --git a/arch/arm64/kvm/emulate-nested.c b/arch/arm64/kvm/emulate-nested.c
> index 431fd429932d..24eb7eccbae4 100644
> --- a/arch/arm64/kvm/emulate-nested.c
> +++ b/arch/arm64/kvm/emulate-nested.c
> @@ -1098,8 +1098,12 @@ static const struct encoding_to_trap_config encoding_to_fgt[] __initconst = {
>  	SR_FGT(SYS_ESR_EL1, 		HFGxTR, ESR_EL1, 1),
>  	SR_FGT(SYS_DCZID_EL0, 		HFGxTR, DCZID_EL0, 1),
>  	SR_FGT(SYS_CTR_EL0, 		HFGxTR, CTR_EL0, 1),
> +	SR_FGT(SYS_GCSPR_EL0,		HFGxTR, nGCS_EL0, 1),
>  	SR_FGT(SYS_CSSELR_EL1, 		HFGxTR, CSSELR_EL1, 1),
>  	SR_FGT(SYS_CPACR_EL1, 		HFGxTR, CPACR_EL1, 1),
> +	SR_FGT(SYS_GCSCR_EL1,		HFGxTR, nGCS_EL1, 1),
> +	SR_FGT(SYS_GCSPR_EL1,		HFGxTR, nGCS_EL1, 1),
> +	SR_FGT(SYS_GCSCRE0_EL1,		HFGxTR, nGCS_EL0, 1),

This is clearly wrong on all 4 counts (the n prefix gives it away...).

>  	SR_FGT(SYS_CONTEXTIDR_EL1, 	HFGxTR, CONTEXTIDR_EL1, 1),
>  	SR_FGT(SYS_CLIDR_EL1, 		HFGxTR, CLIDR_EL1, 1),
>  	SR_FGT(SYS_CCSIDR_EL1, 		HFGxTR, CCSIDR_EL1, 1),
> diff --git a/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h b/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
> index bb6b571ec627..ec34d4a90717 100644
> --- a/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
> +++ b/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
> @@ -25,6 +25,8 @@ static inline void __sysreg_save_user_state(struct kvm_cpu_context *ctxt)
>  {
>  	ctxt_sys_reg(ctxt, TPIDR_EL0)	= read_sysreg(tpidr_el0);
>  	ctxt_sys_reg(ctxt, TPIDRRO_EL0)	= read_sysreg(tpidrro_el0);
> +	if (has_gcs())
> +		ctxt_sys_reg(ctxt, GCSPR_EL0) = read_sysreg_s(SYS_GCSPR_EL0);

We have had this discussion in the past. This must be based on the
VM's configuration. Guarding the check with the host capability is a
valuable optimisation, but that's nowhere near enough. See the series
that I have posted on this very subject (you're on Cc), but you are
welcome to invent your own mechanism in the meantime.

>  }
>  
>  static inline bool ctxt_has_mte(struct kvm_cpu_context *ctxt)
> @@ -62,6 +64,12 @@ static inline void __sysreg_save_el1_state(struct kvm_cpu_context *ctxt)
>  	ctxt_sys_reg(ctxt, PAR_EL1)	= read_sysreg_par();
>  	ctxt_sys_reg(ctxt, TPIDR_EL1)	= read_sysreg(tpidr_el1);
>  
> +	if (has_gcs()) {
> +		ctxt_sys_reg(ctxt, GCSPR_EL1)	= read_sysreg_el1(SYS_GCSPR);
> +		ctxt_sys_reg(ctxt, GCSCR_EL1)	= read_sysreg_el1(SYS_GCSCR);
> +		ctxt_sys_reg(ctxt, GCSCRE0_EL1)	= read_sysreg_s(SYS_GCSCRE0_EL1);
> +	}
> +

Same thing.

>  	if (ctxt_has_mte(ctxt)) {
>  		ctxt_sys_reg(ctxt, TFSR_EL1) = read_sysreg_el1(SYS_TFSR);
>  		ctxt_sys_reg(ctxt, TFSRE0_EL1) = read_sysreg_s(SYS_TFSRE0_EL1);
> @@ -95,6 +103,8 @@ static inline void __sysreg_restore_user_state(struct kvm_cpu_context *ctxt)
>  {
>  	write_sysreg(ctxt_sys_reg(ctxt, TPIDR_EL0),	tpidr_el0);
>  	write_sysreg(ctxt_sys_reg(ctxt, TPIDRRO_EL0),	tpidrro_el0);
> +	if (has_gcs())
> +		write_sysreg_s(ctxt_sys_reg(ctxt, GCSPR_EL0), SYS_GCSPR_EL0);
>  }
>  
>  static inline void __sysreg_restore_el1_state(struct kvm_cpu_context *ctxt)
> @@ -138,6 +148,13 @@ static inline void __sysreg_restore_el1_state(struct kvm_cpu_context *ctxt)
>  	write_sysreg(ctxt_sys_reg(ctxt, PAR_EL1),	par_el1);
>  	write_sysreg(ctxt_sys_reg(ctxt, TPIDR_EL1),	tpidr_el1);
>  
> +	if (has_gcs()) {
> +		write_sysreg_el1(ctxt_sys_reg(ctxt, GCSPR_EL1),	SYS_GCSPR);
> +		write_sysreg_el1(ctxt_sys_reg(ctxt, GCSCR_EL1),	SYS_GCSCR);
> +		write_sysreg_s(ctxt_sys_reg(ctxt, GCSCRE0_EL1),
> +			       SYS_GCSCRE0_EL1);
> +	}
> +

For the benefit of the unsuspecting reviewers, and in the absence of a
public specification (which the XML drop isn't), it would be good to
have the commit message explaining the rationale of what gets saved
when.

>  	if (ctxt_has_mte(ctxt)) {
>  		write_sysreg_el1(ctxt_sys_reg(ctxt, TFSR_EL1), SYS_TFSR);
>  		write_sysreg_s(ctxt_sys_reg(ctxt, TFSRE0_EL1), SYS_TFSRE0_EL1);
> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index 30253bd19917..83ba767e75d2 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -2000,6 +2000,23 @@ static unsigned int mte_visibility(const struct kvm_vcpu *vcpu,
>  	.visibility = mte_visibility,		\
>  }
>  
> +static unsigned int gcs_visibility(const struct kvm_vcpu *vcpu,
> +				   const struct sys_reg_desc *rd)
> +{
> +	if (has_gcs())
> +		return 0;

Yet another case of exposing potentially unwanted state, to the VMM
this time.

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
> @@ -2376,6 +2393,10 @@ static const struct sys_reg_desc sys_reg_descs[] = {
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
> @@ -2462,6 +2483,7 @@ static const struct sys_reg_desc sys_reg_descs[] = {
>  	{ SYS_DESC(SYS_SMIDR_EL1), undef_access },
>  	{ SYS_DESC(SYS_CSSELR_EL1), access_csselr, reset_unknown, CSSELR_EL1 },
>  	{ SYS_DESC(SYS_CTR_EL0), access_ctr },
> +	GCS_REG(GCSPR_EL0),
>  	{ SYS_DESC(SYS_SVCR), undef_access },
>  
>  	{ PMU_SYS_REG(PMCR_EL0), .access = access_pmcr, .reset = reset_pmcr,
> 


Thanks,

	M.

-- 
Without deviation from the norm, progress is not possible.

