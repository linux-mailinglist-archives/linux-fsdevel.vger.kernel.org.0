Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45B87404641
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Sep 2021 09:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352669AbhIIHgg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Sep 2021 03:36:36 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:50099 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232549AbhIIHgg (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Sep 2021 03:36:36 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4H4rQ51qzmz9sWf;
        Thu,  9 Sep 2021 09:35:25 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id URKDW8TFRsBc; Thu,  9 Sep 2021 09:35:25 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4H4rQ50Vdgz9sWd;
        Thu,  9 Sep 2021 09:35:25 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E92F38B77E;
        Thu,  9 Sep 2021 09:35:24 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id ouyCwfPnJfe2; Thu,  9 Sep 2021 09:35:24 +0200 (CEST)
Received: from po9476vm.idsi0.si.c-s.fr (po22017.idsi0.si.c-s.fr [192.168.7.20])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C29B88B77D;
        Thu,  9 Sep 2021 09:35:23 +0200 (CEST)
Subject: Re: [PATCH v3 2/8] mm: Introduce a function to check for confidential
 computing features
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        iommu@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-graphics-maintainer@vmware.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org
Cc:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Brijesh Singh <brijesh.singh@amd.com>
References: <cover.1631141919.git.thomas.lendacky@amd.com>
 <0a7618d54e7e954ee56c22ad1b94af2ffe69543a.1631141919.git.thomas.lendacky@amd.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <96aa160a-e35e-452e-b785-24410265b0f6@csgroup.eu>
Date:   Thu, 9 Sep 2021 07:35:21 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <0a7618d54e7e954ee56c22ad1b94af2ffe69543a.1631141919.git.thomas.lendacky@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 9/8/21 10:58 PM, Tom Lendacky wrote:
> In prep for other confidential computing technologies, introduce a generic
> helper function, cc_platform_has(), that can be used to check for specific

I have little problem with that naming.

For me CC has always meant Compiler Collection.

> active confidential computing attributes, like memory encryption. This is
> intended to eliminate having to add multiple technology-specific checks to
> the code (e.g. if (sev_active() || tdx_active())).
> 
> Co-developed-by: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> Co-developed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>   arch/Kconfig                |  3 ++
>   include/linux/cc_platform.h | 88 +++++++++++++++++++++++++++++++++++++
>   2 files changed, 91 insertions(+)
>   create mode 100644 include/linux/cc_platform.h
> 
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 3743174da870..ca7c359e5da8 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -1234,6 +1234,9 @@ config RELR
>   config ARCH_HAS_MEM_ENCRYPT
>   	bool
>   
> +config ARCH_HAS_CC_PLATFORM
> +	bool
> +
>   config HAVE_SPARSE_SYSCALL_NR
>          bool
>          help
> diff --git a/include/linux/cc_platform.h b/include/linux/cc_platform.h
> new file mode 100644
> index 000000000000..253f3ea66cd8
> --- /dev/null
> +++ b/include/linux/cc_platform.h
> @@ -0,0 +1,88 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Confidential Computing Platform Capability checks
> + *
> + * Copyright (C) 2021 Advanced Micro Devices, Inc.
> + *
> + * Author: Tom Lendacky <thomas.lendacky@amd.com>
> + */
> +
> +#ifndef _CC_PLATFORM_H
> +#define _CC_PLATFORM_H
> +
> +#include <linux/types.h>
> +#include <linux/stddef.h>
> +
> +/**
> + * enum cc_attr - Confidential computing attributes
> + *
> + * These attributes represent confidential computing features that are
> + * currently active.
> + */
> +enum cc_attr {
> +	/**
> +	 * @CC_ATTR_MEM_ENCRYPT: Memory encryption is active
> +	 *
> +	 * The platform/OS is running with active memory encryption. This
> +	 * includes running either as a bare-metal system or a hypervisor
> +	 * and actively using memory encryption or as a guest/virtual machine
> +	 * and actively using memory encryption.
> +	 *
> +	 * Examples include SME, SEV and SEV-ES.
> +	 */
> +	CC_ATTR_MEM_ENCRYPT,
> +
> +	/**
> +	 * @CC_ATTR_HOST_MEM_ENCRYPT: Host memory encryption is active
> +	 *
> +	 * The platform/OS is running as a bare-metal system or a hypervisor
> +	 * and actively using memory encryption.
> +	 *
> +	 * Examples include SME.
> +	 */
> +	CC_ATTR_HOST_MEM_ENCRYPT,
> +
> +	/**
> +	 * @CC_ATTR_GUEST_MEM_ENCRYPT: Guest memory encryption is active
> +	 *
> +	 * The platform/OS is running as a guest/virtual machine and actively
> +	 * using memory encryption.
> +	 *
> +	 * Examples include SEV and SEV-ES.
> +	 */
> +	CC_ATTR_GUEST_MEM_ENCRYPT,
> +
> +	/**
> +	 * @CC_ATTR_GUEST_STATE_ENCRYPT: Guest state encryption is active
> +	 *
> +	 * The platform/OS is running as a guest/virtual machine and actively
> +	 * using memory encryption and register state encryption.
> +	 *
> +	 * Examples include SEV-ES.
> +	 */
> +	CC_ATTR_GUEST_STATE_ENCRYPT,
> +};
> +
> +#ifdef CONFIG_ARCH_HAS_CC_PLATFORM
> +
> +/**
> + * cc_platform_has() - Checks if the specified cc_attr attribute is active
> + * @attr: Confidential computing attribute to check
> + *
> + * The cc_platform_has() function will return an indicator as to whether the
> + * specified Confidential Computing attribute is currently active.
> + *
> + * Context: Any context
> + * Return:
> + * * TRUE  - Specified Confidential Computing attribute is active
> + * * FALSE - Specified Confidential Computing attribute is not active
> + */
> +bool cc_platform_has(enum cc_attr attr);

This declaration make it impossible for architectures to define this 
function inline.

For such function, having it inline would make more sense as it would 
allow GCC to perform constant folding and avoid the overhead  of calling 
a sub-function.

> +
> +#else	/* !CONFIG_ARCH_HAS_CC_PLATFORM */
> +
> +static inline bool cc_platform_has(enum cc_attr attr) { return false; }
> +
> +#endif	/* CONFIG_ARCH_HAS_CC_PLATFORM */
> +
> +#endif	/* _CC_PLATFORM_H */
> 
