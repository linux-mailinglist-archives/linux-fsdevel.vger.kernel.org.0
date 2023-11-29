Return-Path: <linux-fsdevel+bounces-4211-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C41A47FDD43
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 17:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E772A1C209B6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 16:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532F33B286
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 16:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id B0A27BE;
	Wed, 29 Nov 2023 07:11:31 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8BCDA2F4;
	Wed, 29 Nov 2023 07:12:18 -0800 (PST)
Received: from e124191.cambridge.arm.com (e124191.cambridge.arm.com [10.1.197.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 56CC33F73F;
	Wed, 29 Nov 2023 07:11:29 -0800 (PST)
Date: Wed, 29 Nov 2023 15:11:23 +0000
From: Joey Gouly <joey.gouly@arm.com>
To: Marc Zyngier <maz@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
	aneesh.kumar@linux.ibm.com, broonie@kernel.org,
	catalin.marinas@arm.com, dave.hansen@linux.intel.com,
	oliver.upton@linux.dev, shuah@kernel.org, will@kernel.org,
	kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>
Subject: Re: [PATCH v3 06/25] KVM: arm64: Save/restore POE registers
Message-ID: <20231129151123.GA2423241@e124191.cambridge.arm.com>
References: <20231124163510.1835740-1-joey.gouly@arm.com>
 <20231124163510.1835740-7-joey.gouly@arm.com>
 <86bkbfcbyp.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86bkbfcbyp.wl-maz@kernel.org>

Hi Marc,

Thanks for taking a look.

On Mon, Nov 27, 2023 at 06:01:18PM +0000, Marc Zyngier wrote:
> On Fri, 24 Nov 2023 16:34:51 +0000,
> Joey Gouly <joey.gouly@arm.com> wrote:
> > 
> > Define the new system registers that POE introduces and context switch them.
> 
> I would really like to see a discussion on the respective lifetimes of
> these two registers (see below).
> 
> >
> > Signed-off-by: Joey Gouly <joey.gouly@arm.com>
> > Cc: Marc Zyngier <maz@kernel.org>
> > Cc: Oliver Upton <oliver.upton@linux.dev>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> > ---
> >  arch/arm64/include/asm/kvm_arm.h           |  4 ++--
> >  arch/arm64/include/asm/kvm_host.h          |  4 ++++
> >  arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h | 10 ++++++++++
> >  arch/arm64/kvm/sys_regs.c                  |  2 ++
> >  4 files changed, 18 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
> > index b85f46a73e21..597470e0b87b 100644
> > --- a/arch/arm64/include/asm/kvm_arm.h
> > +++ b/arch/arm64/include/asm/kvm_arm.h
> > @@ -346,14 +346,14 @@
> >   */
> >  #define __HFGRTR_EL2_RES0	(GENMASK(63, 56) | GENMASK(53, 51))
> >  #define __HFGRTR_EL2_MASK	GENMASK(49, 0)
> > -#define __HFGRTR_EL2_nMASK	(GENMASK(58, 57) | GENMASK(55, 54) | BIT(50))
> > +#define __HFGRTR_EL2_nMASK	(GENMASK(60, 57) | GENMASK(55, 54) | BIT(50))
> >  
> >  #define __HFGWTR_EL2_RES0	(GENMASK(63, 56) | GENMASK(53, 51) |	\
> >  				 BIT(46) | BIT(42) | BIT(40) | BIT(28) | \
> >  				 GENMASK(26, 25) | BIT(21) | BIT(18) |	\
> >  				 GENMASK(15, 14) | GENMASK(10, 9) | BIT(2))
> >  #define __HFGWTR_EL2_MASK	GENMASK(49, 0)
> > -#define __HFGWTR_EL2_nMASK	(GENMASK(58, 57) | GENMASK(55, 54) | BIT(50))
> > +#define __HFGWTR_EL2_nMASK	(GENMASK(60, 57) | GENMASK(55, 54) | BIT(50))
> >  
> >  #define __HFGITR_EL2_RES0	GENMASK(63, 57)
> >  #define __HFGITR_EL2_MASK	GENMASK(54, 0)
> > diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> > index 824f29f04916..fa9ebd8fce40 100644
> > --- a/arch/arm64/include/asm/kvm_host.h
> > +++ b/arch/arm64/include/asm/kvm_host.h
> > @@ -401,6 +401,10 @@ enum vcpu_sysreg {
> >  	PIR_EL1,       /* Permission Indirection Register 1 (EL1) */
> >  	PIRE0_EL1,     /*  Permission Indirection Register 0 (EL1) */
> >  
> > +	/* Permission Overlay Extension registers */
> > +	POR_EL1,	/* Permission Overlay Register 1 (EL1) */
> > +	POR_EL0,	/* Permission Overlay Register 0 (EL0) */
> > +
> >  	/* 32bit specific registers. */
> >  	DACR32_EL2,	/* Domain Access Control Register */
> >  	IFSR32_EL2,	/* Instruction Fault Status Register */
> > diff --git a/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h b/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
> > index bb6b571ec627..22f07ee43e7e 100644
> > --- a/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
> > +++ b/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
> > @@ -19,6 +19,9 @@
> >  static inline void __sysreg_save_common_state(struct kvm_cpu_context *ctxt)
> >  {
> >  	ctxt_sys_reg(ctxt, MDSCR_EL1)	= read_sysreg(mdscr_el1);
> > +
> > +	if (system_supports_poe())
> > +		ctxt_sys_reg(ctxt, POR_EL0)	= read_sysreg_s(SYS_POR_EL0);
> 
> So this is saved as eagerly as it gets. Why? If it only affects EL0,
> it can be saved/restored in a much lazier way.

Just to confirm I understand what you mean, the current code looks like:

	vcpu_load()                // Lazy save

	while (ret > 0)
		check_vcpu_requests()
		kvm_arm_vcpu_enter_exit()  // Eager save/restore
		ret = handle_exit()

	vcpu_put()                // Lazy restore

POR_EL0 does affect EL2, if it does some form of {get,put}_user.
This happens in vgic_its_process_commands (as part of handle_exit), also the
stolen time code (in check_vcpu_requests) and could possibly happen if perf
tries to walk the user stack.

So I think that it does need to happen eagerly, such that the host-userspace's
POR_EL0 is used to access the VM's memory, not the guest-userspace's POR_EL0.

Does that make sense? It will need a comment, I agree.

> 
> >  }
> >  
> >  static inline void __sysreg_save_user_state(struct kvm_cpu_context *ctxt)
> > @@ -59,6 +62,8 @@ static inline void __sysreg_save_el1_state(struct kvm_cpu_context *ctxt)
> >  		ctxt_sys_reg(ctxt, PIR_EL1)	= read_sysreg_el1(SYS_PIR);
> >  		ctxt_sys_reg(ctxt, PIRE0_EL1)	= read_sysreg_el1(SYS_PIRE0);
> 
> And the fact that you only touch PIRE0_EL1 here seems to be a good
> indication that the above can be relaxed.

PIREO_EL1 is not directly accessible from EL0. I'll have a think about this a
bit more, and if there is a potential similar issue here.

> 
> >  	}
> > +	if (system_supports_poe())
> 
> nit: missing new line before the if().
> 
> > +		ctxt_sys_reg(ctxt, POR_EL1)	= read_sysreg_el1(SYS_POR);
> >  	ctxt_sys_reg(ctxt, PAR_EL1)	= read_sysreg_par();
> >  	ctxt_sys_reg(ctxt, TPIDR_EL1)	= read_sysreg(tpidr_el1);
> >  
> > @@ -89,6 +94,9 @@ static inline void __sysreg_save_el2_return_state(struct kvm_cpu_context *ctxt)
> >  static inline void __sysreg_restore_common_state(struct kvm_cpu_context *ctxt)
> >  {
> >  	write_sysreg(ctxt_sys_reg(ctxt, MDSCR_EL1),  mdscr_el1);
> > +
> > +	if (system_supports_poe())
> > +		write_sysreg_s(ctxt_sys_reg(ctxt, POR_EL0),	SYS_POR_EL0);
> 
> Same thing here about the eager restore.
> 
> >  }
> >  
> >  static inline void __sysreg_restore_user_state(struct kvm_cpu_context *ctxt)
> > @@ -135,6 +143,8 @@ static inline void __sysreg_restore_el1_state(struct kvm_cpu_context *ctxt)
> >  		write_sysreg_el1(ctxt_sys_reg(ctxt, PIR_EL1),	SYS_PIR);
> >  		write_sysreg_el1(ctxt_sys_reg(ctxt, PIRE0_EL1),	SYS_PIRE0);
> >  	}
> > +	if (system_supports_poe())
> 
> new line.
> 
> > +		write_sysreg_el1(ctxt_sys_reg(ctxt, POR_EL1),	SYS_POR);
> >  	write_sysreg(ctxt_sys_reg(ctxt, PAR_EL1),	par_el1);
> >  	write_sysreg(ctxt_sys_reg(ctxt, TPIDR_EL1),	tpidr_el1);
> >  
> > diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> > index 4735e1b37fb3..a54e5eadbf29 100644
> > --- a/arch/arm64/kvm/sys_regs.c
> > +++ b/arch/arm64/kvm/sys_regs.c
> > @@ -2269,6 +2269,7 @@ static const struct sys_reg_desc sys_reg_descs[] = {
> >  	{ SYS_DESC(SYS_MAIR_EL1), access_vm_reg, reset_unknown, MAIR_EL1 },
> >  	{ SYS_DESC(SYS_PIRE0_EL1), NULL, reset_unknown, PIRE0_EL1 },
> >  	{ SYS_DESC(SYS_PIR_EL1), NULL, reset_unknown, PIR_EL1 },
> > +	{ SYS_DESC(SYS_POR_EL1), NULL, reset_unknown, POR_EL1 },
> >  	{ SYS_DESC(SYS_AMAIR_EL1), access_vm_reg, reset_amair_el1, AMAIR_EL1 },
> >  
> >  	{ SYS_DESC(SYS_LORSA_EL1), trap_loregion },
> > @@ -2352,6 +2353,7 @@ static const struct sys_reg_desc sys_reg_descs[] = {
> >  	  .access = access_pmovs, .reg = PMOVSSET_EL0,
> >  	  .get_user = get_pmreg, .set_user = set_pmreg },
> >  
> > +	{ SYS_DESC(SYS_POR_EL0), NULL, reset_unknown, POR_EL0 },
> >  	{ SYS_DESC(SYS_TPIDR_EL0), NULL, reset_unknown, TPIDR_EL0 },
> >  	{ SYS_DESC(SYS_TPIDRRO_EL0), NULL, reset_unknown, TPIDRRO_EL0 },
> >  	{ SYS_DESC(SYS_TPIDR2_EL0), undef_access },
> 
> Another thing that is missing is the trap routing for NV in
> emulated-nested.c. Please fill in the various tables there.
> 
> Thanks,
> 
> 	M.
> 
> -- 
> Without deviation from the norm, progress is not possible.


Thanks,
Joey

