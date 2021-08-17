Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13F153EE901
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Aug 2021 11:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235288AbhHQJBA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Aug 2021 05:01:00 -0400
Received: from mail.skyhub.de ([5.9.137.197]:53982 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234339AbhHQJA5 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Aug 2021 05:00:57 -0400
Received: from zn.tnic (p200300ec2f1175003091845243004ed4.dip0.t-ipconnect.de [IPv6:2003:ec:2f11:7500:3091:8452:4300:4ed4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C31EA1EC01B5;
        Tue, 17 Aug 2021 11:00:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1629190817;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=CTZxwlhCTYBphd87lvceDZBtTDENyNB6RWw2n2fhNqo=;
        b=cLyGe6Vfp/ZbXlGAJcu8s+oDyI+Cek5fSPumAUCPjd+TtrDcq8WnlTuq148AmmSefmwouf
        U4RljFOl7bpVd/jo/MMo7NW5c66AcB8pntylvfCw1TSAnl6S3l0D/M7WEba3xU2EPv7jkK
        R7PUFWJBwQxeCIeQqdKssk1UJ8FLB8Y=
Date:   Tue, 17 Aug 2021 11:00:56 +0200
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
        Will Deacon <will@kernel.org>, Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH v2 05/12] x86/sme: Replace occurrences of sme_active()
 with prot_guest_has()
Message-ID: <YRt6yCNCBLwyyx5X@zn.tnic>
References: <cover.1628873970.git.thomas.lendacky@amd.com>
 <c6c38d6253dc78381f9ff0f1823b6ee5ddeefacc.1628873970.git.thomas.lendacky@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c6c38d6253dc78381f9ff0f1823b6ee5ddeefacc.1628873970.git.thomas.lendacky@amd.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 13, 2021 at 11:59:24AM -0500, Tom Lendacky wrote:
> diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
> index edc67ddf065d..5635ca9a1fbe 100644
> --- a/arch/x86/mm/mem_encrypt.c
> +++ b/arch/x86/mm/mem_encrypt.c
> @@ -144,7 +144,7 @@ void __init sme_unmap_bootdata(char *real_mode_data)
>  	struct boot_params *boot_data;
>  	unsigned long cmdline_paddr;
>  
> -	if (!sme_active())
> +	if (!amd_prot_guest_has(PATTR_SME))
>  		return;
>  
>  	/* Get the command line address before unmapping the real_mode_data */
> @@ -164,7 +164,7 @@ void __init sme_map_bootdata(char *real_mode_data)
>  	struct boot_params *boot_data;
>  	unsigned long cmdline_paddr;
>  
> -	if (!sme_active())
> +	if (!amd_prot_guest_has(PATTR_SME))
>  		return;
>  
>  	__sme_early_map_unmap_mem(real_mode_data, sizeof(boot_params), true);
> @@ -378,7 +378,7 @@ bool sev_active(void)
>  	return sev_status & MSR_AMD64_SEV_ENABLED;
>  }
>  
> -bool sme_active(void)
> +static bool sme_active(void)

Just get rid of it altogether. Also, there's an

EXPORT_SYMBOL_GPL(sev_active);

which needs to go under the actual function. Here's a diff ontop:

---
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index 5635ca9a1fbe..a3a2396362a5 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -364,8 +364,9 @@ int __init early_set_memory_encrypted(unsigned long vaddr, unsigned long size)
 /*
  * SME and SEV are very similar but they are not the same, so there are
  * times that the kernel will need to distinguish between SME and SEV. The
- * sme_active() and sev_active() functions are used for this.  When a
- * distinction isn't needed, the mem_encrypt_active() function can be used.
+ * PATTR_HOST_MEM_ENCRYPT and PATTR_GUEST_MEM_ENCRYPT flags to
+ * amd_prot_guest_has() are used for this. When a distinction isn't needed,
+ * the mem_encrypt_active() function can be used.
  *
  * The trampoline code is a good example for this requirement.  Before
  * paging is activated, SME will access all memory as decrypted, but SEV
@@ -377,11 +378,6 @@ bool sev_active(void)
 {
 	return sev_status & MSR_AMD64_SEV_ENABLED;
 }
-
-static bool sme_active(void)
-{
-	return sme_me_mask && !sev_active();
-}
 EXPORT_SYMBOL_GPL(sev_active);
 
 /* Needs to be called from non-instrumentable code */
@@ -398,7 +394,7 @@ bool amd_prot_guest_has(unsigned int attr)
 
 	case PATTR_SME:
 	case PATTR_HOST_MEM_ENCRYPT:
-		return sme_active();
+		return sme_me_mask && !sev_active();
 
 	case PATTR_SEV:
 	case PATTR_GUEST_MEM_ENCRYPT:

>  {
>  	return sme_me_mask && !sev_active();
>  }
> @@ -428,7 +428,7 @@ bool force_dma_unencrypted(struct device *dev)
>  	 * device does not support DMA to addresses that include the
>  	 * encryption mask.
>  	 */
> -	if (sme_active()) {
> +	if (amd_prot_guest_has(PATTR_SME)) {

So I'm not sure: you add PATTR_SME which you call with
amd_prot_guest_has() and PATTR_HOST_MEM_ENCRYPT which you call with
prot_guest_has() and they both end up being the same thing on AMD.

So why even bother with PATTR_SME?

This is only going to cause confusion later and I'd say let's simply use
prot_guest_has(PATTR_HOST_MEM_ENCRYPT) everywhere...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
