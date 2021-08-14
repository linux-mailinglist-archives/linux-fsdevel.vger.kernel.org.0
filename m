Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D809D3EC4AA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Aug 2021 21:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233289AbhHNTJG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 14 Aug 2021 15:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbhHNTIw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 14 Aug 2021 15:08:52 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B79A8C061764;
        Sat, 14 Aug 2021 12:08:23 -0700 (PDT)
Received: from zn.tnic (p200300ec2f1db90092f0c5d5424adff0.dip0.t-ipconnect.de [IPv6:2003:ec:2f1d:b900:92f0:c5d5:424a:dff0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 54E261EC03D5;
        Sat, 14 Aug 2021 21:08:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1628968096;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=mDvb80MdTaf2VGaprn1/RrktzLeXuWn32fRrJqO4RnI=;
        b=n25sOE9lUdWfF/+b9LVVu/c0RTBIvawG0223WpI1YjhZEQbLgR8M8pMHyOitDdblT/KimW
        wNA1cSGSX7URig9TBS5k8aka8wDk2wkKQnurLH+/Lu/L/dwizp44Ektb+n/sT1fMvyEOwE
        k/pW/5vABtT/pfK15uGy1LwHKVyiZxY=
Date:   Sat, 14 Aug 2021 21:08:55 +0200
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
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH v2 03/12] x86/sev: Add an x86 version of prot_guest_has()
Message-ID: <YRgUxyhoqVJ0Kxvt@zn.tnic>
References: <cover.1628873970.git.thomas.lendacky@amd.com>
 <7d55bac0cf2e73f53816bce3a3097877ed9663f3.1628873970.git.thomas.lendacky@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7d55bac0cf2e73f53816bce3a3097877ed9663f3.1628873970.git.thomas.lendacky@amd.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 13, 2021 at 11:59:22AM -0500, Tom Lendacky wrote:
> diff --git a/arch/x86/include/asm/protected_guest.h b/arch/x86/include/asm/protected_guest.h
> new file mode 100644
> index 000000000000..51e4eefd9542
> --- /dev/null
> +++ b/arch/x86/include/asm/protected_guest.h
> @@ -0,0 +1,29 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Protected Guest (and Host) Capability checks
> + *
> + * Copyright (C) 2021 Advanced Micro Devices, Inc.
> + *
> + * Author: Tom Lendacky <thomas.lendacky@amd.com>
> + */
> +
> +#ifndef _X86_PROTECTED_GUEST_H
> +#define _X86_PROTECTED_GUEST_H
> +
> +#include <linux/mem_encrypt.h>
> +
> +#ifndef __ASSEMBLY__
> +
> +static inline bool prot_guest_has(unsigned int attr)
> +{
> +#ifdef CONFIG_AMD_MEM_ENCRYPT
> +	if (sme_me_mask)
> +		return amd_prot_guest_has(attr);
> +#endif
> +
> +	return false;
> +}
> +
> +#endif	/* __ASSEMBLY__ */
> +
> +#endif	/* _X86_PROTECTED_GUEST_H */

I think this can be simplified more, diff ontop below:

- no need for the ifdeffery as amd_prot_guest_has() has versions for
both when CONFIG_AMD_MEM_ENCRYPT is set or not.

- the sme_me_mask check is pushed there too.

- and since this is vendor-specific, I'm checking the vendor bit. Yeah,
yeah, cross-vendor but I don't really believe that.

---
diff --git a/arch/x86/include/asm/protected_guest.h b/arch/x86/include/asm/protected_guest.h
index 51e4eefd9542..8541c76d5da4 100644
--- a/arch/x86/include/asm/protected_guest.h
+++ b/arch/x86/include/asm/protected_guest.h
@@ -12,18 +12,13 @@
 
 #include <linux/mem_encrypt.h>
 
-#ifndef __ASSEMBLY__
-
 static inline bool prot_guest_has(unsigned int attr)
 {
-#ifdef CONFIG_AMD_MEM_ENCRYPT
-	if (sme_me_mask)
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
+	    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
 		return amd_prot_guest_has(attr);
-#endif
 
 	return false;
 }
 
-#endif	/* __ASSEMBLY__ */
-
 #endif	/* _X86_PROTECTED_GUEST_H */
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index edc67ddf065d..5a0442a6f072 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -392,6 +392,9 @@ bool noinstr sev_es_active(void)
 
 bool amd_prot_guest_has(unsigned int attr)
 {
+	if (!sme_me_mask)
+		return false;
+
 	switch (attr) {
 	case PATTR_MEM_ENCRYPT:
 		return sme_me_mask != 0;

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
