Return-Path: <linux-fsdevel+bounces-4886-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F60805A14
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 17:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B09E4B210D1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 16:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4290F60BA2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 16:40:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 75C7318D;
	Tue,  5 Dec 2023 07:41:25 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ADFB6139F;
	Tue,  5 Dec 2023 07:42:11 -0800 (PST)
Received: from e124191.cambridge.arm.com (e124191.cambridge.arm.com [10.1.197.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1501B3F6C4;
	Tue,  5 Dec 2023 07:41:22 -0800 (PST)
Date: Tue, 5 Dec 2023 15:41:16 +0000
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
Subject: Re: [PATCH v3 00/25] Permission Overlay Extension
Message-ID: <20231205154116.GA3613610@e124191.cambridge.arm.com>
References: <20231124163510.1835740-1-joey.gouly@arm.com>
 <86jzpub56r.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86jzpub56r.wl-maz@kernel.org>

Hi Marc,

On Mon, Dec 04, 2023 at 11:03:24AM +0000, Marc Zyngier wrote:
> Hi Joey,
> 
> On Fri, 24 Nov 2023 16:34:45 +0000,
> Joey Gouly <joey.gouly@arm.com> wrote:
> > 
> > Hello everyone,
> > 
> > This series implements the Permission Overlay Extension introduced in 2022
> > VMSA enhancements [1]. It is based on v6.7-rc2.
> > 
> > Changes since v2[2]:
> > 	# Added ptrace support and selftest
> > 	# Add missing POR_EL0 initialisation in fork/clone
> > 	# Rebase onto v6.7-rc2
> > 	# Add r-bs
> > 
> > The Permission Overlay Extension allows to constrain permissions on memory
> > regions. This can be used from userspace (EL0) without a system call or TLB
> > invalidation.
> 
> I have given this series a few more thoughts, and came to the
> conclusion that is it still incomplete on the KVM front:
> 
> * FEAT_S1POE often comes together with FEAT_S2POE. For obvious
>   reasons, we cannot afford to let the guest play with S2POR_EL1, nor
>   do we want to advertise FEAT_S2POE to the guest.
> 
>   You will need to add some additional FGT for this, and mask out
>   FEAT_S2POE from the guest's view of the ID registers.

I found out last week that I had misunderstood S2POR_EL1, so yes looks like
we need to trap that. I will add that in.

> 
> * letting the guest play with POE comes with some interesting strings
>   attached: a guest that has started on a POE-enabled host cannot be
>   migrated to one that doesn't have POE. which means that the POE
>   registers should only be visible to the host userspace if enabled in
>   the guest's ID registers, and thus only context-switched in these
>   conditions. They should otherwise UNDEF.

Can you give me some clarification here?
	
	- By visible to the host userspace do you mean via the GET_ONE_REG API?
	- Currently the ID register (ID_AA64MMFR3_EL1) is not ID_WRITABLE,
	  should this series or another make it so? Currently if the host had
	  POE it's enabled in the guest, so I believe migration to a non-POE
	  host will fail?
	- For the context switch, do you mean something like:

		if (system_supports_poe() && ID_REG(MMFR3_EL1) & S1POE)
			ctxt_sys_reg(ctxt, POR_EL0)     = read_sysreg_s(SYS_POR_EL0);

	  That would need some refactoring, since I don't see how to access
	  id_regs from struct kvm_cpu_context.

Thanks,
Joey

