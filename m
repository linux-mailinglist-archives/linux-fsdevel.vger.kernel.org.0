Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20457416523
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Sep 2021 20:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242729AbhIWSWm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Sep 2021 14:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242679AbhIWSWl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Sep 2021 14:22:41 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4DF3C061574;
        Thu, 23 Sep 2021 11:21:09 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0d6800010999bf90259edb.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:6800:109:99bf:9025:9edb])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 31D311EC056D;
        Thu, 23 Sep 2021 20:21:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1632421264;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=sRYoha6VNo1mirZ2tDsvl5M4pw+Lp6nZ+ru63TzNfNk=;
        b=QKT9j+FcdVSYJR6XqJj56f1VwmVttXbYqJzEh1SRFX0BCeMFEzKjMYiIWUA0PUQHi/v6u7
        4en/x3BlyGxbdkIoskyOLkXgWWnAMIwJ3773mYKBf/drdpiGwxNPJqJ1cm4p23LLLRJNSO
        HKy8yqvOqt2DJB2fdgaAhYC7Oaw9OY0=
Date:   Thu, 23 Sep 2021 20:21:03 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
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
Message-ID: <YUzFj+yH79XRc3F3@zn.tnic>
References: <YUoao0LlqQ6+uBrq@zn.tnic>
 <20210921212059.wwlytlmxoft4cdth@box.shutemov.name>
 <YUpONYwM4dQXAOJr@zn.tnic>
 <20210921213401.i2pzaotgjvn4efgg@box.shutemov.name>
 <00f52bf8-cbc6-3721-f40e-2f51744751b0@amd.com>
 <20210921215830.vqxd75r4eyau6cxy@box.shutemov.name>
 <01891f59-7ec3-cf62-a8fc-79f79ca76587@amd.com>
 <20210922143015.vvxvh6ec73lffvkf@box.shutemov.name>
 <YUuJZ2qOgbdpfk6N@zn.tnic>
 <20210922210558.itofvu3725dap5xx@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210922210558.itofvu3725dap5xx@box.shutemov.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 23, 2021 at 12:05:58AM +0300, Kirill A. Shutemov wrote:
> Unless we find other way to guarantee RIP-relative access, we must use
> fixup_pointer() to access any global variables.

Yah, I've asked compiler folks about any guarantees we have wrt
rip-relative addresses but it doesn't look good. Worst case, we'd have
to do the fixup_pointer() thing.

In the meantime, Tom and I did some more poking at this and here's a
diff ontop.

The direction being that we'll stick both the AMD and Intel
*cc_platform_has() call into cc_platform.c for which instrumentation
will be disabled so no issues with that.

And that will keep all that querying all together in a single file.

---
diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
index a73712b6ee0e..2d4f5c17d79c 100644
--- a/arch/x86/include/asm/mem_encrypt.h
+++ b/arch/x86/include/asm/mem_encrypt.h
@@ -51,7 +51,6 @@ void __init mem_encrypt_free_decrypted_mem(void);
 void __init mem_encrypt_init(void);
 
 void __init sev_es_init_vc_handling(void);
-bool amd_cc_platform_has(enum cc_attr attr);
 
 #define __bss_decrypted __section(".bss..decrypted")
 
@@ -74,7 +73,6 @@ static inline void __init sme_encrypt_kernel(struct boot_params *bp) { }
 static inline void __init sme_enable(struct boot_params *bp) { }
 
 static inline void sev_es_init_vc_handling(void) { }
-static inline bool amd_cc_platform_has(enum cc_attr attr) { return false; }
 
 static inline int __init
 early_set_memory_decrypted(unsigned long vaddr, unsigned long size) { return 0; }
@@ -103,12 +101,6 @@ static inline u64 sme_get_me_mask(void)
 	return sme_me_mask;
 }
 
-#if defined(CONFIG_CPU_SUP_INTEL) && defined(CONFIG_ARCH_HAS_CC_PLATFORM)
-bool intel_cc_platform_has(enum cc_attr attr);
-#else
-static inline bool intel_cc_platform_has(enum cc_attr attr) { return false; }
-#endif
-
 #endif	/* __ASSEMBLY__ */
 
 #endif	/* __X86_MEM_ENCRYPT_H__ */
diff --git a/arch/x86/kernel/cc_platform.c b/arch/x86/kernel/cc_platform.c
index da54a1805211..97ede7052f77 100644
--- a/arch/x86/kernel/cc_platform.c
+++ b/arch/x86/kernel/cc_platform.c
@@ -13,6 +13,52 @@
 
 #include <asm/processor.h>
 
+static bool intel_cc_platform_has(enum cc_attr attr)
+{
+#ifdef CONFIG_INTEL_TDX_GUEST
+	return false;
+#else
+	return false;
+#endif
+}
+
+/*
+ * SME and SEV are very similar but they are not the same, so there are
+ * times that the kernel will need to distinguish between SME and SEV. The
+ * cc_platform_has() function is used for this.  When a distinction isn't
+ * needed, the CC_ATTR_MEM_ENCRYPT attribute can be used.
+ *
+ * The trampoline code is a good example for this requirement.  Before
+ * paging is activated, SME will access all memory as decrypted, but SEV
+ * will access all memory as encrypted.  So, when APs are being brought
+ * up under SME the trampoline area cannot be encrypted, whereas under SEV
+ * the trampoline area must be encrypted.
+ */
+static bool amd_cc_platform_has(enum cc_attr attr)
+{
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+	switch (attr) {
+	case CC_ATTR_MEM_ENCRYPT:
+		return sme_me_mask;
+
+	case CC_ATTR_HOST_MEM_ENCRYPT:
+		return sme_me_mask && !(sev_status & MSR_AMD64_SEV_ENABLED);
+
+	case CC_ATTR_GUEST_MEM_ENCRYPT:
+		return sev_status & MSR_AMD64_SEV_ENABLED;
+
+	case CC_ATTR_GUEST_STATE_ENCRYPT:
+		return sev_status & MSR_AMD64_SEV_ES_ENABLED;
+
+	default:
+		return false;
+	}
+#else
+	return false;
+#endif
+}
+
+
 bool cc_platform_has(enum cc_attr attr)
 {
 	if (sme_me_mask)
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 53756ff12295..8321c43554a1 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -60,13 +60,6 @@ static u64 msr_test_ctrl_cache __ro_after_init;
  */
 static bool cpu_model_supports_sld __ro_after_init;
 
-#ifdef CONFIG_ARCH_HAS_CC_PLATFORM
-bool intel_cc_platform_has(enum cc_attr attr)
-{
-	return false;
-}
-#endif
-
 /*
  * Processors which have self-snooping capability can handle conflicting
  * memory type across CPUs by snooping its own cache. However, there exists
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index 9417d404ea92..23d54b810f08 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -361,38 +361,6 @@ int __init early_set_memory_encrypted(unsigned long vaddr, unsigned long size)
 	return early_set_memory_enc_dec(vaddr, size, true);
 }
 
-/*
- * SME and SEV are very similar but they are not the same, so there are
- * times that the kernel will need to distinguish between SME and SEV. The
- * cc_platform_has() function is used for this.  When a distinction isn't
- * needed, the CC_ATTR_MEM_ENCRYPT attribute can be used.
- *
- * The trampoline code is a good example for this requirement.  Before
- * paging is activated, SME will access all memory as decrypted, but SEV
- * will access all memory as encrypted.  So, when APs are being brought
- * up under SME the trampoline area cannot be encrypted, whereas under SEV
- * the trampoline area must be encrypted.
- */
-bool amd_cc_platform_has(enum cc_attr attr)
-{
-	switch (attr) {
-	case CC_ATTR_MEM_ENCRYPT:
-		return sme_me_mask;
-
-	case CC_ATTR_HOST_MEM_ENCRYPT:
-		return sme_me_mask && !(sev_status & MSR_AMD64_SEV_ENABLED);
-
-	case CC_ATTR_GUEST_MEM_ENCRYPT:
-		return sev_status & MSR_AMD64_SEV_ENABLED;
-
-	case CC_ATTR_GUEST_STATE_ENCRYPT:
-		return sev_status & MSR_AMD64_SEV_ES_ENABLED;
-
-	default:
-		return false;
-	}
-}
-
 /* Override for DMA direct allocation check - ARCH_HAS_FORCE_DMA_UNENCRYPTED */
 bool force_dma_unencrypted(struct device *dev)
 {

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
