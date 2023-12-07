Return-Path: <linux-fsdevel+bounces-5171-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1AFB808D75
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 17:33:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B5831F211E0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 16:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24A5481A4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 16:33:51 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id A6DDC10CA;
	Thu,  7 Dec 2023 07:44:57 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 58626106F;
	Thu,  7 Dec 2023 07:45:43 -0800 (PST)
Received: from e124191.cambridge.arm.com (e124191.cambridge.arm.com [10.1.197.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 474873F762;
	Thu,  7 Dec 2023 07:44:55 -0800 (PST)
Date: Thu, 7 Dec 2023 15:44:44 +0000
From: Joey Gouly <joey.gouly@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
	aneesh.kumar@linux.ibm.com, broonie@kernel.org,
	dave.hansen@linux.intel.com, maz@kernel.org, oliver.upton@linux.dev,
	shuah@kernel.org, will@kernel.org, kvmarm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>
Subject: Re: [PATCH v3 11/25] arm64: enable ARCH_HAS_PKEYS on arm64
Message-ID: <20231207154444.GA85238@e124191.cambridge.arm.com>
References: <20231124163510.1835740-1-joey.gouly@arm.com>
 <20231124163510.1835740-12-joey.gouly@arm.com>
 <ZXHj3TMuW7sPMqAc@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXHj3TMuW7sPMqAc@arm.com>

Hi,

Thanks to you and Mark for the comments so far!

On Thu, Dec 07, 2023 at 03:25:17PM +0000, Catalin Marinas wrote:
> On Fri, Nov 24, 2023 at 04:34:56PM +0000, Joey Gouly wrote:
> > diff --git a/arch/arm64/include/asm/pkeys.h b/arch/arm64/include/asm/pkeys.h
> > new file mode 100644
> > index 000000000000..5761fb48fd53
> > --- /dev/null
> > +++ b/arch/arm64/include/asm/pkeys.h
> > @@ -0,0 +1,54 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (C) 2023 Arm Ltd.
> > + *
> > + * Based on arch/x86/include/asm/pkeys.h
> > +*/
> > +
> > +#ifndef _ASM_ARM64_PKEYS_H
> > +#define _ASM_ARM64_PKEYS_H
> > +
> > +#define ARCH_VM_PKEY_FLAGS (VM_PKEY_BIT0 | VM_PKEY_BIT1 | VM_PKEY_BIT2)
> > +
> > +#define arch_max_pkey() 0
> > +
> > +int arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
> > +		unsigned long init_val);
> > +
> > +static inline bool arch_pkeys_enabled(void)
> > +{
> > +	return false;
> > +}
> > +
> > +static inline int vma_pkey(struct vm_area_struct *vma)
> > +{
> > +	return -1;
> > +}
> 
> What's the point of these dummies? I guess they'll be populated later
> but I haven't reached that point. Could we not just leave them out for
> now and add the complete version directly? This would work better with
> an earlier comment to move the Kconfig entry towards the end of the
> series.

I think the suggestion to move the Kconfig to the end is good, and I agree that
it will probably remove these dummy implementations.

> 
> Also, they don't seem to match the generic include/linux/pkeys.h
> dummies. For example, vma_pkey() returns 0 in the generic version, -1
> here. Should they actually match?

If for some reason I need to keep them after the Kconfig move, I will look into
this further.

Thanks,
Joey

