Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30C4A40B6CC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Sep 2021 20:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbhINS0X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Sep 2021 14:26:23 -0400
Received: from mail.skyhub.de ([5.9.137.197]:58876 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229477AbhINS0W (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Sep 2021 14:26:22 -0400
Received: from zn.tnic (p200300ec2f1048008d634cac5b0c7131.dip0.t-ipconnect.de [IPv6:2003:ec:2f10:4800:8d63:4cac:5b0c:7131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 763B31EC04D1;
        Tue, 14 Sep 2021 20:24:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1631643899;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ZiKIvLzxdvLHB/We39H7CYYWYKE3V9X7egkB0ENPsyE=;
        b=GN7S7yA8avxg1KGLWQ5Wx4mPloiFO1PBUg1PdvgNlg1k2E8fi0qdXRRIE9kwM20ienZRVh
        o8LBR3WQL8vRxBEN8UtVxzVQ4SPu4d1Dm2tyq3MgOH0kvt8jlqMPz4StWyaaodjjc84DcD
        Q2fGTwl3VhF1WGvU/wGjdbzSHrnpkrw=
Date:   Tue, 14 Sep 2021 20:24:52 +0200
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
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH v3 5/8] x86/sme: Replace occurrences of sme_active() with
 cc_platform_has()
Message-ID: <YUDo9CWyLVa1PeUF@zn.tnic>
References: <cover.1631141919.git.thomas.lendacky@amd.com>
 <367624d43d35d61d5c97a8b289d9ddae223636e9.1631141919.git.thomas.lendacky@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <367624d43d35d61d5c97a8b289d9ddae223636e9.1631141919.git.thomas.lendacky@amd.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 08, 2021 at 05:58:36PM -0500, Tom Lendacky wrote:
> diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
> index 18fe19916bc3..4b54a2377821 100644
> --- a/arch/x86/mm/mem_encrypt.c
> +++ b/arch/x86/mm/mem_encrypt.c
> @@ -144,7 +144,7 @@ void __init sme_unmap_bootdata(char *real_mode_data)
>  	struct boot_params *boot_data;
>  	unsigned long cmdline_paddr;
>  
> -	if (!sme_active())
> +	if (!cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT))
>  		return;
>  
>  	/* Get the command line address before unmapping the real_mode_data */
> @@ -164,7 +164,7 @@ void __init sme_map_bootdata(char *real_mode_data)
>  	struct boot_params *boot_data;
>  	unsigned long cmdline_paddr;
>  
> -	if (!sme_active())
> +	if (!cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT))
>  		return;
>  
>  	__sme_early_map_unmap_mem(real_mode_data, sizeof(boot_params), true);
> @@ -377,11 +377,6 @@ bool sev_active(void)
>  {
>  	return sev_status & MSR_AMD64_SEV_ENABLED;
>  }
> -
> -bool sme_active(void)
> -{
> -	return sme_me_mask && !sev_active();
> -}
>  EXPORT_SYMBOL_GPL(sev_active);
>  
>  /* Needs to be called from non-instrumentable code */

You forgot this hunk:

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

because there's still a sme_active() mentioned there:

$ git grep sme_active
arch/x86/mm/mem_encrypt.c:367: * sme_active() and sev_active() functions are used for this.  When a

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
