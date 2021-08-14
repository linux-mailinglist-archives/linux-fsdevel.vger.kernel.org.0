Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1770C3EC475
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Aug 2021 20:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238977AbhHNScp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 14 Aug 2021 14:32:45 -0400
Received: from mail.skyhub.de ([5.9.137.197]:59380 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233713AbhHNSco (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 14 Aug 2021 14:32:44 -0400
Received: from zn.tnic (p200300ec2f1db90092f0c5d5424adff0.dip0.t-ipconnect.de [IPv6:2003:ec:2f1d:b900:92f0:c5d5:424a:dff0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 18F4D1EC03D5;
        Sat, 14 Aug 2021 20:32:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1628965930;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=wF+abY2BQsJbjTrcR+vEXegmF8fSVZNnTVHwv8EJcnQ=;
        b=E4Qk5UWHuniXg4G1qquKyzpgwZxdDOaCXRqHrAIJykq2qzFHsvToSzhtSszwEfmGfSV6v2
        I5QqIZa+pz8OAA9XFKUyZCM9wxA5OIK4n52a7NMv/GJIh9ii9QfkxahlKZf58K1pY/P4Uq
        2W5ojEdMC06o3XDrAinHQLW8qtTO9aY=
Date:   Sat, 14 Aug 2021 20:32:48 +0200
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
        Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH v2 02/12] mm: Introduce a function to check for
 virtualization protection features
Message-ID: <YRgMUHqdH60jDB06@zn.tnic>
References: <cover.1628873970.git.thomas.lendacky@amd.com>
 <482fe51f1671c1cd081039801b03db7ec0036332.1628873970.git.thomas.lendacky@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <482fe51f1671c1cd081039801b03db7ec0036332.1628873970.git.thomas.lendacky@amd.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 13, 2021 at 11:59:21AM -0500, Tom Lendacky wrote:
> In prep for other protected virtualization technologies, introduce a
> generic helper function, prot_guest_has(), that can be used to check
> for specific protection attributes, like memory encryption. This is
> intended to eliminate having to add multiple technology-specific checks
> to the code (e.g. if (sev_active() || tdx_active())).
> 
> Reviewed-by: Joerg Roedel <jroedel@suse.de>
> Co-developed-by: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> Co-developed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>  arch/Kconfig                    |  3 +++
>  include/linux/protected_guest.h | 35 +++++++++++++++++++++++++++++++++
>  2 files changed, 38 insertions(+)
>  create mode 100644 include/linux/protected_guest.h
> 
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 98db63496bab..bd4f60c581f1 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -1231,6 +1231,9 @@ config RELR
>  config ARCH_HAS_MEM_ENCRYPT
>  	bool
>  
> +config ARCH_HAS_PROTECTED_GUEST
> +	bool
> +
>  config HAVE_SPARSE_SYSCALL_NR
>         bool
>         help
> diff --git a/include/linux/protected_guest.h b/include/linux/protected_guest.h
> new file mode 100644
> index 000000000000..43d4dde94793
> --- /dev/null
> +++ b/include/linux/protected_guest.h
> @@ -0,0 +1,35 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Protected Guest (and Host) Capability checks
> + *
> + * Copyright (C) 2021 Advanced Micro Devices, Inc.
> + *
> + * Author: Tom Lendacky <thomas.lendacky@amd.com>
> + */
> +
> +#ifndef _PROTECTED_GUEST_H
> +#define _PROTECTED_GUEST_H
> +
> +#ifndef __ASSEMBLY__
	   ^^^^^^^^^^^^^

Do you really need that guard? It builds fine without it too. Or
something coming later does need it...?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
