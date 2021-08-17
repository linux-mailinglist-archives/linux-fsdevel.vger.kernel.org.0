Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 714843EEC98
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Aug 2021 14:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237125AbhHQMjD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Aug 2021 08:39:03 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:59053 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230323AbhHQMjC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Aug 2021 08:39:02 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4GprDF2h3Tz9sSn;
        Tue, 17 Aug 2021 22:38:21 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1629203905;
        bh=NQyXzwQlAo0xsgc18yZpAOusgLGX71Fk6ueV1qdw5rA=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=KYXSccDfXzjB2hBx15MoEIDf+kWmkDX50zC9GoNA+zRe2h6A0PbLhChR5Cdkwlare
         Skall5IaM+JNYijtEffokiKW2vk3GcnrIXL9w6cyu8ks9EO2+V9EOw5R+GGu1PiYQv
         D9NxQxRHQN8/BYGs83P6DhfXjoNRsufAILW0QoxjiCBqx4FvSdnLWb7NReYqLmQl3x
         p3W/80//lGcl/AzT+8dWLeaLNqPIEQLIUJX653gw3u6fYoSlh4acLTdYAto8S4VL1T
         o4r+VgRPi55oy+/sUiu+QbwiFA1DMF8zLkBn1HY/7VQPrYtD408/c7FtLIJoHUe5Qi
         Ap9BkljmAJJGw==
From:   Michael Ellerman <mpe@ellerman.id.au>
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
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH v2 04/12] powerpc/pseries/svm: Add a powerpc version of
 prot_guest_has()
In-Reply-To: <000f627ce20c6504dd8d118d85bd69e7717b752f.1628873970.git.thomas.lendacky@amd.com>
References: <cover.1628873970.git.thomas.lendacky@amd.com>
 <000f627ce20c6504dd8d118d85bd69e7717b752f.1628873970.git.thomas.lendacky@amd.com>
Date:   Tue, 17 Aug 2021 22:38:19 +1000
Message-ID: <874kbogsas.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Tom Lendacky <thomas.lendacky@amd.com> writes:
> Introduce a powerpc version of the prot_guest_has() function. This will
> be used to replace the powerpc mem_encrypt_active() implementation, so
> the implementation will initially only support the PATTR_MEM_ENCRYPT
> attribute.
>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>  arch/powerpc/include/asm/protected_guest.h | 30 ++++++++++++++++++++++
>  arch/powerpc/platforms/pseries/Kconfig     |  1 +
>  2 files changed, 31 insertions(+)
>  create mode 100644 arch/powerpc/include/asm/protected_guest.h
>
> diff --git a/arch/powerpc/include/asm/protected_guest.h b/arch/powerpc/include/asm/protected_guest.h
> new file mode 100644
> index 000000000000..ce55c2c7e534
> --- /dev/null
> +++ b/arch/powerpc/include/asm/protected_guest.h
> @@ -0,0 +1,30 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Protected Guest (and Host) Capability checks
> + *
> + * Copyright (C) 2021 Advanced Micro Devices, Inc.
> + *
> + * Author: Tom Lendacky <thomas.lendacky@amd.com>
> + */
> +
> +#ifndef _POWERPC_PROTECTED_GUEST_H
> +#define _POWERPC_PROTECTED_GUEST_H

Minor nit, we would usually use _ASM_POWERPC_PROTECTED_GUEST_H

Otherwise looks OK to me.

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers
