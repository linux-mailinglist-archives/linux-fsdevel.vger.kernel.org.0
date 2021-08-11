Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2D9F3E9402
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Aug 2021 16:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232598AbhHKOyH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Aug 2021 10:54:07 -0400
Received: from mga11.intel.com ([192.55.52.93]:65238 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232456AbhHKOyH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Aug 2021 10:54:07 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10072"; a="212026946"
X-IronPort-AV: E=Sophos;i="5.84,313,1620716400"; 
   d="scan'208";a="212026946"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2021 07:53:42 -0700
X-IronPort-AV: E=Sophos;i="5.84,313,1620716400"; 
   d="scan'208";a="571158048"
Received: from watoney1-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.209.129.121])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2021 07:53:40 -0700
Subject: Re: [PATCH 01/11] mm: Introduce a function to check for
 virtualization protection features
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        iommu@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-graphics-maintainer@vmware.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org
Cc:     Borislav Petkov <bp@alien8.de>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Joerg Roedel <joro@8bytes.org>,
        Andi Kleen <ak@linux.intel.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>
References: <cover.1627424773.git.thomas.lendacky@amd.com>
 <cbc875b1d2113225c2b44a2384d5b303d0453cf7.1627424774.git.thomas.lendacky@amd.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <805946e3-5138-3565-65eb-3cb8ac6f0b3e@linux.intel.com>
Date:   Wed, 11 Aug 2021 07:53:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <cbc875b1d2113225c2b44a2384d5b303d0453cf7.1627424774.git.thomas.lendacky@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 7/27/21 3:26 PM, Tom Lendacky wrote:
> diff --git a/include/linux/protected_guest.h b/include/linux/protected_guest.h
> new file mode 100644
> index 000000000000..f8ed7b72967b
> --- /dev/null
> +++ b/include/linux/protected_guest.h
> @@ -0,0 +1,32 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Protected Guest (and Host) Capability checks
> + *
> + * Copyright (C) 2021 Advanced Micro Devices, Inc.
> + *
> + * Author: Tom Lendacky<thomas.lendacky@amd.com>
> + */
> +
> +#ifndef _PROTECTED_GUEST_H
> +#define _PROTECTED_GUEST_H
> +
> +#ifndef __ASSEMBLY__

Can you include headers for bool type and false definition?

--- a/include/linux/protected_guest.h
+++ b/include/linux/protected_guest.h
@@ -12,6 +12,9 @@

  #ifndef __ASSEMBLY__

+#include <linux/types.h>
+#include <linux/stddef.h>

Otherwise, I see following errors in multi-config auto testing.

include/linux/protected_guest.h:40:15: error: unknown type name 'bool'
include/linux/protected_guest.h:40:63: error: 'false' undeclared (first use in this functi


> +
> +#define PATTR_MEM_ENCRYPT		0	/* Encrypted memory */
> +#define PATTR_HOST_MEM_ENCRYPT		1	/* Host encrypted memory */
> +#define PATTR_GUEST_MEM_ENCRYPT		2	/* Guest encrypted memory */
> +#define PATTR_GUEST_PROT_STATE		3	/* Guest encrypted state */
> +
> +#ifdef CONFIG_ARCH_HAS_PROTECTED_GUEST
> +
> +#include <asm/protected_guest.h>
> +
> +#else	/* !CONFIG_ARCH_HAS_PROTECTED_GUEST */
> +
> +static inline bool prot_guest_has(unsigned int attr) { return false; }
> +
> +#endif	/* CONFIG_ARCH_HAS_PROTECTED_GUEST */
> +
> +#endif	/* __ASSEMBLY__ */
> +
> +#endif	/* _PROTECTED_GUEST_H */

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
