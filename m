Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D53D4407601
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Sep 2021 12:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235566AbhIKKLo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 11 Sep 2021 06:11:44 -0400
Received: from mail.skyhub.de ([5.9.137.197]:42550 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235443AbhIKKLl (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 11 Sep 2021 06:11:41 -0400
Received: from zn.tnic (p200300ec2f1e14001f3479bbc118498e.dip0.t-ipconnect.de [IPv6:2003:ec:2f1e:1400:1f34:79bb:c118:498e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B0AD71EC0136;
        Sat, 11 Sep 2021 12:10:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1631355022;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=HR27o8pZq+/+uFK0n68ub/mxfkE1ISiJNZUKmCms7j8=;
        b=I197+52KgpqBBgLvuSMSrQpQNRo13IqV+FgdnGwdscix9JqjZo6kiEOakrW3iQQS6u0uVD
        WzR3O2CXEOh8ZykdepQmAsy+NBoupC0qZ8IdrqxtxuX9zNND17uAXyBpIh83Qsid6C7Ugn
        zY+/3Zj7u8+b/OQlEkEddX/RceOjyqA=
Date:   Sat, 11 Sep 2021 12:10:14 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        iommu@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-graphics-maintainer@vmware.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        Brijesh Singh <brijesh.singh@amd.com>,
        Joerg Roedel <joro@8bytes.org>,
        Andi Kleen <ak@linux.intel.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Christoph Hellwig <hch@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 3/8] x86/sev: Add an x86 version of cc_platform_has()
Message-ID: <YTyAhmPf39Vqd7G9@zn.tnic>
References: <cover.1631141919.git.thomas.lendacky@amd.com>
 <f9951644147e27772bf4512325e8ba6472e363b7.1631141919.git.thomas.lendacky@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f9951644147e27772bf4512325e8ba6472e363b7.1631141919.git.thomas.lendacky@amd.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 08, 2021 at 05:58:34PM -0500, Tom Lendacky wrote:
> diff --git a/arch/x86/kernel/cc_platform.c b/arch/x86/kernel/cc_platform.c
> new file mode 100644
> index 000000000000..3c9bacd3c3f3
> --- /dev/null
> +++ b/arch/x86/kernel/cc_platform.c
> @@ -0,0 +1,21 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Confidential Computing Platform Capability checks
> + *
> + * Copyright (C) 2021 Advanced Micro Devices, Inc.
> + *
> + * Author: Tom Lendacky <thomas.lendacky@amd.com>
> + */
> +
> +#include <linux/export.h>
> +#include <linux/cc_platform.h>
> +#include <linux/mem_encrypt.h>
> +
> +bool cc_platform_has(enum cc_attr attr)
> +{
> +	if (sme_me_mask)

Why are you still checking the sme_me_mask here? AFAIR, we said that
we'll do that only when the KVM folks come with a valid use case...

> +		return amd_cc_platform_has(attr);
> +
> +	return false;
> +}
> +EXPORT_SYMBOL_GPL(cc_platform_has);
> diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
> index ff08dc463634..18fe19916bc3 100644
> --- a/arch/x86/mm/mem_encrypt.c
> +++ b/arch/x86/mm/mem_encrypt.c
> @@ -20,6 +20,7 @@
>  #include <linux/bitops.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/virtio_config.h>
> +#include <linux/cc_platform.h>
>  
>  #include <asm/tlbflush.h>
>  #include <asm/fixmap.h>
> @@ -389,6 +390,26 @@ bool noinstr sev_es_active(void)
>  	return sev_status & MSR_AMD64_SEV_ES_ENABLED;
>  }
>  
> +bool amd_cc_platform_has(enum cc_attr attr)
> +{
> +	switch (attr) {
> +	case CC_ATTR_MEM_ENCRYPT:
> +		return sme_me_mask != 0;

No need for the "!= 0"

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
