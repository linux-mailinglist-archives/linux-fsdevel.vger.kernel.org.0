Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98C2E40467A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Sep 2021 09:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352807AbhIIHmH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Sep 2021 03:42:07 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:48261 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1352790AbhIIHmF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Sep 2021 03:42:05 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4H4rXR0J6Pz9sWj;
        Thu,  9 Sep 2021 09:40:55 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id a3HcQ-GtdMPM; Thu,  9 Sep 2021 09:40:54 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4H4rXQ622Pz9sWg;
        Thu,  9 Sep 2021 09:40:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B7DF38B77E;
        Thu,  9 Sep 2021 09:40:54 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id T3QWoD2RrUYV; Thu,  9 Sep 2021 09:40:54 +0200 (CEST)
Received: from po9476vm.idsi0.si.c-s.fr (po22017.idsi0.si.c-s.fr [192.168.7.20])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 92A3E8B77D;
        Thu,  9 Sep 2021 09:40:53 +0200 (CEST)
Subject: Re: [PATCH v3 4/8] powerpc/pseries/svm: Add a powerpc version of
 cc_platform_has()
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
        Brijesh Singh <brijesh.singh@amd.com>,
        Paul Mackerras <paulus@samba.org>
References: <cover.1631141919.git.thomas.lendacky@amd.com>
 <9d4fc3f8ea7b325aaa1879beab1286876f45d450.1631141919.git.thomas.lendacky@amd.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <b8a163b3-6357-45c9-f7ef-5d7e900b9ac8@csgroup.eu>
Date:   Thu, 9 Sep 2021 07:40:51 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <9d4fc3f8ea7b325aaa1879beab1286876f45d450.1631141919.git.thomas.lendacky@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 9/8/21 10:58 PM, Tom Lendacky wrote:
> Introduce a powerpc version of the cc_platform_has() function. This will
> be used to replace the powerpc mem_encrypt_active() implementation, so
> the implementation will initially only support the CC_ATTR_MEM_ENCRYPT
> attribute.
> 
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>   arch/powerpc/platforms/pseries/Kconfig       |  1 +
>   arch/powerpc/platforms/pseries/Makefile      |  2 ++
>   arch/powerpc/platforms/pseries/cc_platform.c | 26 ++++++++++++++++++++
>   3 files changed, 29 insertions(+)
>   create mode 100644 arch/powerpc/platforms/pseries/cc_platform.c
> 
> diff --git a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/platforms/pseries/Kconfig
> index 5e037df2a3a1..2e57391e0778 100644
> --- a/arch/powerpc/platforms/pseries/Kconfig
> +++ b/arch/powerpc/platforms/pseries/Kconfig
> @@ -159,6 +159,7 @@ config PPC_SVM
>   	select SWIOTLB
>   	select ARCH_HAS_MEM_ENCRYPT
>   	select ARCH_HAS_FORCE_DMA_UNENCRYPTED
> +	select ARCH_HAS_CC_PLATFORM
>   	help
>   	 There are certain POWER platforms which support secure guests using
>   	 the Protected Execution Facility, with the help of an Ultravisor
> diff --git a/arch/powerpc/platforms/pseries/Makefile b/arch/powerpc/platforms/pseries/Makefile
> index 4cda0ef87be0..41d8aee98da4 100644
> --- a/arch/powerpc/platforms/pseries/Makefile
> +++ b/arch/powerpc/platforms/pseries/Makefile
> @@ -31,3 +31,5 @@ obj-$(CONFIG_FA_DUMP)		+= rtas-fadump.o
>   
>   obj-$(CONFIG_SUSPEND)		+= suspend.o
>   obj-$(CONFIG_PPC_VAS)		+= vas.o
> +
> +obj-$(CONFIG_ARCH_HAS_CC_PLATFORM)	+= cc_platform.o
> diff --git a/arch/powerpc/platforms/pseries/cc_platform.c b/arch/powerpc/platforms/pseries/cc_platform.c
> new file mode 100644
> index 000000000000..e8021af83a19
> --- /dev/null
> +++ b/arch/powerpc/platforms/pseries/cc_platform.c
> @@ -0,0 +1,26 @@
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
> +
> +#include <asm/machdep.h>
> +#include <asm/svm.h>
> +
> +bool cc_platform_has(enum cc_attr attr)
> +{

Please keep this function inline as mem_encrypt_active() is


> +	switch (attr) {
> +	case CC_ATTR_MEM_ENCRYPT:
> +		return is_secure_guest();
> +
> +	default:
> +		return false;
> +	}
> +}
> +EXPORT_SYMBOL_GPL(cc_platform_has);
> 
