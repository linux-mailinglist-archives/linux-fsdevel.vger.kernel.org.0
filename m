Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED8140CBAA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Sep 2021 19:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbhIOR1c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Sep 2021 13:27:32 -0400
Received: from mga17.intel.com ([192.55.52.151]:49715 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229479AbhIOR1b (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Sep 2021 13:27:31 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10108"; a="202548433"
X-IronPort-AV: E=Sophos;i="5.85,296,1624345200"; 
   d="scan'208";a="202548433"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2021 10:26:11 -0700
X-IronPort-AV: E=Sophos;i="5.85,296,1624345200"; 
   d="scan'208";a="434215304"
Received: from rlad-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.212.118.184])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2021 10:26:08 -0700
Subject: Re: [PATCH v3 0/8] Implement generic cc_platform_has() helper
 function
To:     Borislav Petkov <bp@alien8.de>,
        Tom Lendacky <thomas.lendacky@amd.com>
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
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>, Baoquan He <bhe@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dave Young <dyoung@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Heiko Carstens <hca@linux.ibm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Will Deacon <will@kernel.org>
References: <cover.1631141919.git.thomas.lendacky@amd.com>
 <YUIjS6lKEY5AadZx@zn.tnic>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <d48e6a17-d2b4-67da-56d1-fc9a61dfe2b8@linux.intel.com>
Date:   Wed, 15 Sep 2021 10:26:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YUIjS6lKEY5AadZx@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 9/15/21 9:46 AM, Borislav Petkov wrote:
> Sathya,
> 
> if you want to prepare the Intel variant intel_cc_platform_has() ontop
> of those and send it to me, that would be good because then I can
> integrate it all in one branch which can be used to base future work
> ontop.

I have a Intel variant patch (please check following patch). But it includes
TDX changes as well. Shall I move TDX changes to different patch and just
create a separate patch for adding intel_cc_platform_has()?


commit fc5f98a0ed94629d903827c5b44ee9295f835831
Author: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Date:   Wed May 12 11:35:13 2021 -0700

     x86/tdx: Add confidential guest support for TDX guest

     TDX architecture provides a way for VM guests to be highly secure and
     isolated (from untrusted VMM). To achieve this requirement, any data
     coming from VMM cannot be completely trusted. TDX guest fixes this
     issue by hardening the IO drivers against the attack from the VMM.
     So, when adding hardening fixes to the generic drivers, to protect
     custom fixes use cc_platform_has() API.

     Also add TDX guest support to cc_platform_has() API to protect the
     TDX specific fixes.

     Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index a5b14de03458..2e78358923a1 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -871,6 +871,7 @@ config INTEL_TDX_GUEST
         depends on SECURITY
         select X86_X2APIC
         select SECURITY_LOCKDOWN_LSM
+       select ARCH_HAS_CC_PLATFORM
         help
           Provide support for running in a trusted domain on Intel processors
           equipped with Trusted Domain eXtensions. TDX is a new Intel
diff --git a/arch/x86/include/asm/intel_cc_platform.h b/arch/x86/include/asm/intel_cc_platform.h
new file mode 100644
index 000000000000..472c3174beac
--- /dev/null
+++ b/arch/x86/include/asm/intel_cc_platform.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2021 Intel Corporation */
+#ifndef _ASM_X86_INTEL_CC_PLATFORM_H
+#define _ASM_X86_INTEL_CC_PLATFORM_H
+
+#if defined(CONFIG_CPU_SUP_INTEL) && defined(CONFIG_ARCH_HAS_CC_PLATFORM)
+bool intel_cc_platform_has(unsigned int flag);
+#else
+static inline bool intel_cc_platform_has(unsigned int flag) { return false; }
+#endif
+
+#endif /* _ASM_X86_INTEL_CC_PLATFORM_H */
+
diff --git a/arch/x86/kernel/cc_platform.c b/arch/x86/kernel/cc_platform.c
index 3c9bacd3c3f3..e83bc2f48efe 100644
--- a/arch/x86/kernel/cc_platform.c
+++ b/arch/x86/kernel/cc_platform.c
@@ -10,11 +10,16 @@
  #include <linux/export.h>
  #include <linux/cc_platform.h>
  #include <linux/mem_encrypt.h>
+#include <linux/processor.h>
+
+#include <asm/intel_cc_platform.h>

  bool cc_platform_has(enum cc_attr attr)
  {
         if (sme_me_mask)
                 return amd_cc_platform_has(attr);
+       else if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
+               return intel_cc_platform_has(attr);

         return false;
  }
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 8321c43554a1..ab486a3b1eb0 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -11,6 +11,7 @@
  #include <linux/init.h>
  #include <linux/uaccess.h>
  #include <linux/delay.h>
+#include <linux/cc_platform.h>

  #include <asm/cpufeature.h>
  #include <asm/msr.h>
@@ -60,6 +61,21 @@ static u64 msr_test_ctrl_cache __ro_after_init;
   */
  static bool cpu_model_supports_sld __ro_after_init;

+#ifdef CONFIG_ARCH_HAS_CC_PLATFORM
+bool intel_cc_platform_has(enum cc_attr attr)
+{
+       switch (attr) {
+       case CC_ATTR_GUEST_TDX:
+               return cpu_feature_enabled(X86_FEATURE_TDX_GUEST);
+       default:
+               return false;
+       }
+
+       return false;
+}
+EXPORT_SYMBOL_GPL(intel_cc_platform_has);
+#endif
+
  /*
   * Processors which have self-snooping capability can handle conflicting
   * memory type across CPUs by snooping its own cache. However, there exists
diff --git a/include/linux/cc_platform.h b/include/linux/cc_platform.h
index 253f3ea66cd8..e38430e6e396 100644
--- a/include/linux/cc_platform.h
+++ b/include/linux/cc_platform.h
@@ -61,6 +61,15 @@ enum cc_attr {
          * Examples include SEV-ES.
          */
         CC_ATTR_GUEST_STATE_ENCRYPT,
+
+       /**
+        * @CC_ATTR_GUEST_TDX: Trusted Domain Extension Support
+        *
+        * The platform/OS is running as a TDX guest/virtual machine.
+        *
+        * Examples include SEV-ES.
+        */
+       CC_ATTR_GUEST_TDX,
  };

  #ifdef CONFIG_ARCH_HAS_CC_PLATFORM


-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
