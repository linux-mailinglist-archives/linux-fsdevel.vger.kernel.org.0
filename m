Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D85170DEA6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 May 2023 16:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237185AbjEWOIQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 May 2023 10:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237180AbjEWOHW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 May 2023 10:07:22 -0400
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B3F8E4C
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 May 2023 07:06:57 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-4f4b2bc1565so2255660e87.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 May 2023 07:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684850755; x=1687442755;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=byQ7R65S71m0wzPqbiFWNKE9LKN0vAgU/hu26mJ4Tao=;
        b=RTNF1dOI8qXq/eykiP1dN0zND1ocK0wBWXijQ70vdH0qgf0zuAL3WXeheksWAnT4iD
         WkS6mYR6Vtr9ViSQofZxqXRVktx4l1ePcQfL54w2Rjl14Eqqu8hVHkQA0uhv0TopPH4o
         JWyRQf9CWHKXLVJdzA4hBRwrrsdl+b84x5jxJreMYFTPEcmB+Bnujqw9jSEqvk7EH4iC
         aszeeaD0iik3i/d2y+NK506z17nzcANmfSRMZZREQdt/LYkeCQgVsyCzf5TK608CDad0
         LgKv3tdrJSovh05GHnH4ihpKbNe/1vgXgsClUdU17aL6oarVcv3XhksHdDsd7kEdrhym
         HvPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684850755; x=1687442755;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=byQ7R65S71m0wzPqbiFWNKE9LKN0vAgU/hu26mJ4Tao=;
        b=Q/g6NArpfhgf1wYSKRo+F2viywkEpeZbShoTIHrMdjhBOYXD8rAXSvPAFKOnKPXpYr
         0jl6oCYr8xXBm5CSTHa2AxwOGNC6YvDOxe61Vh2ed6XLYo+mQkHBjLI+hkB2IV9za9M0
         e3Ru8rdig6VGxdQCIieP+qSo0sL4H9GUG5rqinYG6JYuzmkLut8EcIzsgt5LoZRT4Iv0
         f2JaXR0s2F5QomAfKa+UAL+HamPHeFhEcQVa6iIEqrm8OhhFs0hkvcHBTDecvi/3Y2it
         6iZdzq/rfQ9rlDDeF1U7QW9LrtGEG32jzMtd486QUeNyCfh7SDN84w9r4tsp9r01td9I
         z/ag==
X-Gm-Message-State: AC+VfDxQpTt31EAVom5UNSHObj0BJwM+xzCd6+xkJ85w3XTFTmVbXdWw
        kbHe2wcD4TvMD3lfUqGgsgkMYw==
X-Google-Smtp-Source: ACHHUZ5kl103mxz31Bst76bk+usRFe+6yR9SjRuXIC8C4khNIktOugraGHFzharVZdsE8yhWpwnckg==
X-Received: by 2002:ac2:4354:0:b0:4f3:91a2:279 with SMTP id o20-20020ac24354000000b004f391a20279mr3649798lfl.61.1684850755271;
        Tue, 23 May 2023 07:05:55 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id h28-20020ac2597c000000b004e9bf853c27sm1346562lfp.70.2023.05.23.07.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 07:05:54 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 23 May 2023 16:05:34 +0200
Subject: [PATCH v3 10/12] ARM: mm: Make virt_to_pfn() a static inline
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230503-virt-to-pfn-v6-4-rc1-v3-10-a16c19c03583@linaro.org>
References: <20230503-virt-to-pfn-v6-4-rc1-v3-0-a16c19c03583@linaro.org>
In-Reply-To: <20230503-virt-to-pfn-v6-4-rc1-v3-0-a16c19c03583@linaro.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Vineet Gupta <vgupta@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Greg Ungerer <gerg@linux-m68k.org>
Cc:     linux-mm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org,
        linux-snps-arc@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Making virt_to_pfn() a static inline taking a strongly typed
(const void *) makes the contract of a passing a pointer of that
type to the function explicit and exposes any misuse of the
macro virt_to_pfn() acting polymorphic and accepting many types
such as (void *), (unitptr_t) or (unsigned long) as arguments
without warnings.

Doing this is a bit intrusive: virt_to_pfn() requires
PHYS_PFN_OFFSET and PAGE_SHIFT to be defined, and this is defined in
<asm/page.h>, so this must be included *before* <asm/memory.h>.

The use of macros were obscuring the unclear inclusion order here,
as the macros would eventually be resolved, but a static inline
like this cannot be compiled with unresolved macros.

The naive solution to include <asm/page.h> at the top of
<asm/memory.h> does not work, because <asm/memory.h> sometimes
includes <asm/page.h> at the end of itself, which would create a
confusing inclusion loop. So instead, take the approach to always
unconditionally include <asm/page.h> at the end of <asm/memory.h>

arch/arm uses <asm/memory.h> explicitly in a lot of places,
however it turns out that if we just unconditionally include
<asm/memory.h> into <asm/page.h> and switch all inclusions of
<asm/memory.h> to <asm/page.h> instead, we enforce the right
order and <asm/memory.h> will always have access to the
definitions.

Put an inclusion guard in place making it impossible to include
<asm/memory.h> explicitly.

Link: https://lore.kernel.org/linux-mm/20220701160004.2ffff4e5ab59a55499f4c736@linux-foundation.org/
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Russell: the <asm/memory.h> vs <asm/page.h> inclusion really
gave me headaches, if you have a better idea how to do it
I'm all ears!
---
 arch/arm/common/sharpsl_param.c      |  2 +-
 arch/arm/include/asm/delay.h         |  2 +-
 arch/arm/include/asm/io.h            |  2 +-
 arch/arm/include/asm/memory.h        | 17 ++++++++++++-----
 arch/arm/include/asm/page.h          |  4 ++--
 arch/arm/include/asm/pgtable.h       |  2 +-
 arch/arm/include/asm/proc-fns.h      |  2 --
 arch/arm/include/asm/sparsemem.h     |  2 +-
 arch/arm/include/asm/uaccess-asm.h   |  2 +-
 arch/arm/include/asm/uaccess.h       |  2 +-
 arch/arm/kernel/asm-offsets.c        |  2 +-
 arch/arm/kernel/entry-armv.S         |  2 +-
 arch/arm/kernel/entry-common.S       |  2 +-
 arch/arm/kernel/entry-v7m.S          |  2 +-
 arch/arm/kernel/head-nommu.S         |  3 +--
 arch/arm/kernel/head.S               |  2 +-
 arch/arm/kernel/hibernate.c          |  2 +-
 arch/arm/kernel/suspend.c            |  2 +-
 arch/arm/kernel/tcm.c                |  2 +-
 arch/arm/kernel/vmlinux-xip.lds.S    |  3 +--
 arch/arm/kernel/vmlinux.lds.S        |  3 +--
 arch/arm/mach-berlin/platsmp.c       |  2 +-
 arch/arm/mach-keystone/keystone.c    |  2 +-
 arch/arm/mach-omap2/sleep33xx.S      |  2 +-
 arch/arm/mach-omap2/sleep43xx.S      |  2 +-
 arch/arm/mach-omap2/sleep44xx.S      |  2 +-
 arch/arm/mach-pxa/gumstix.c          |  2 +-
 arch/arm/mach-rockchip/sleep.S       |  2 +-
 arch/arm/mach-sa1100/pm.c            |  2 +-
 arch/arm/mach-shmobile/headsmp-scu.S |  2 +-
 arch/arm/mach-shmobile/headsmp.S     |  2 +-
 arch/arm/mach-socfpga/headsmp.S      |  2 +-
 arch/arm/mach-spear/spear.h          |  2 +-
 arch/arm/mm/cache-fa.S               |  1 -
 arch/arm/mm/cache-v4wb.S             |  1 -
 arch/arm/mm/dma-mapping.c            |  2 +-
 arch/arm/mm/dump.c                   |  2 +-
 arch/arm/mm/init.c                   |  2 +-
 arch/arm/mm/kasan_init.c             |  1 -
 arch/arm/mm/mmu.c                    |  2 +-
 arch/arm/mm/physaddr.c               |  2 +-
 arch/arm/mm/pmsa-v8.c                |  2 +-
 arch/arm/mm/proc-v7.S                |  2 +-
 arch/arm/mm/proc-v7m.S               |  2 +-
 arch/arm/mm/pv-fixup-asm.S           |  2 +-
 drivers/memory/ti-emif-sram-pm.S     |  2 +-
 46 files changed, 54 insertions(+), 55 deletions(-)

diff --git a/arch/arm/common/sharpsl_param.c b/arch/arm/common/sharpsl_param.c
index 6237ede2f0c7..1ca26c063f80 100644
--- a/arch/arm/common/sharpsl_param.c
+++ b/arch/arm/common/sharpsl_param.c
@@ -11,7 +11,7 @@
 #include <linux/module.h>
 #include <linux/string.h>
 #include <asm/mach/sharpsl_param.h>
-#include <asm/memory.h>
+#include <asm/page.h>
 
 /*
  * Certain hardware parameters determined at the time of device manufacture,
diff --git a/arch/arm/include/asm/delay.h b/arch/arm/include/asm/delay.h
index 4f80b72372b4..1d069e558d8d 100644
--- a/arch/arm/include/asm/delay.h
+++ b/arch/arm/include/asm/delay.h
@@ -7,7 +7,7 @@
 #ifndef __ASM_ARM_DELAY_H
 #define __ASM_ARM_DELAY_H
 
-#include <asm/memory.h>
+#include <asm/page.h>
 #include <asm/param.h>	/* HZ */
 
 /*
diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
index 7fcdc785366c..56b08ed6cc3b 100644
--- a/arch/arm/include/asm/io.h
+++ b/arch/arm/include/asm/io.h
@@ -23,7 +23,7 @@
 #include <linux/string.h>
 #include <linux/types.h>
 #include <asm/byteorder.h>
-#include <asm/memory.h>
+#include <asm/page.h>
 #include <asm-generic/pci_iomap.h>
 
 /*
diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
index 62e9df024445..ef2aa79ece5a 100644
--- a/arch/arm/include/asm/memory.h
+++ b/arch/arm/include/asm/memory.h
@@ -5,11 +5,16 @@
  *  Copyright (C) 2000-2002 Russell King
  *  modification for nommu, Hyok S. Choi, 2004
  *
- *  Note: this file should not be included by non-asm/.h files
+ *  Note: this file should not be included explicitly, include <asm/page.h>
+ *  to get access to these definitions.
  */
 #ifndef __ASM_ARM_MEMORY_H
 #define __ASM_ARM_MEMORY_H
 
+#ifndef _ASMARM_PAGE_H
+#error "Do not include <asm/memory.h> directly"
+#endif
+
 #include <linux/compiler.h>
 #include <linux/const.h>
 #include <linux/types.h>
@@ -288,10 +293,12 @@ static inline unsigned long __phys_to_virt(phys_addr_t x)
 
 #endif
 
-#define virt_to_pfn(kaddr) \
-	((((unsigned long)(kaddr) - PAGE_OFFSET) >> PAGE_SHIFT) + \
-	 PHYS_PFN_OFFSET)
-
+static inline unsigned long virt_to_pfn(const void *p)
+{
+	unsigned long kaddr = (unsigned long)p;
+	return (((kaddr - PAGE_OFFSET) >> PAGE_SHIFT) +
+		PHYS_PFN_OFFSET);
+}
 #define __pa_symbol_nodebug(x)	__virt_to_phys_nodebug((x))
 
 #ifdef CONFIG_DEBUG_VIRTUAL
diff --git a/arch/arm/include/asm/page.h b/arch/arm/include/asm/page.h
index 74bb5947b387..4e44f9707376 100644
--- a/arch/arm/include/asm/page.h
+++ b/arch/arm/include/asm/page.h
@@ -161,10 +161,10 @@ extern int pfn_valid(unsigned long);
 #define pfn_valid pfn_valid
 #endif
 
-#include <asm/memory.h>
-
 #endif /* !__ASSEMBLY__ */
 
+#include <asm/memory.h>
+
 #define VM_DATA_DEFAULT_FLAGS	VM_DATA_FLAGS_TSK_EXEC
 
 #include <asm-generic/getorder.h>
diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
index a58ccbb406ad..34662a9d4cab 100644
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -27,7 +27,7 @@ extern struct page *empty_zero_page;
 #else
 
 #include <asm-generic/pgtable-nopud.h>
-#include <asm/memory.h>
+#include <asm/page.h>
 #include <asm/pgtable-hwdef.h>
 
 
diff --git a/arch/arm/include/asm/proc-fns.h b/arch/arm/include/asm/proc-fns.h
index c82f7a29ec4a..280396483f5d 100644
--- a/arch/arm/include/asm/proc-fns.h
+++ b/arch/arm/include/asm/proc-fns.h
@@ -147,8 +147,6 @@ static inline void init_proc_vtable(const struct processor *p)
 
 extern void cpu_resume(void);
 
-#include <asm/memory.h>
-
 #ifdef CONFIG_MMU
 
 #define cpu_switch_mm(pgd,mm) cpu_do_switch_mm(virt_to_phys(pgd),mm)
diff --git a/arch/arm/include/asm/sparsemem.h b/arch/arm/include/asm/sparsemem.h
index d362233856a5..421e3415338a 100644
--- a/arch/arm/include/asm/sparsemem.h
+++ b/arch/arm/include/asm/sparsemem.h
@@ -2,7 +2,7 @@
 #ifndef ASMARM_SPARSEMEM_H
 #define ASMARM_SPARSEMEM_H
 
-#include <asm/memory.h>
+#include <asm/page.h>
 
 /*
  * Two definitions are required for sparsemem:
diff --git a/arch/arm/include/asm/uaccess-asm.h b/arch/arm/include/asm/uaccess-asm.h
index 6451a433912c..65da32e1f1c1 100644
--- a/arch/arm/include/asm/uaccess-asm.h
+++ b/arch/arm/include/asm/uaccess-asm.h
@@ -5,7 +5,7 @@
 
 #include <asm/asm-offsets.h>
 #include <asm/domain.h>
-#include <asm/memory.h>
+#include <asm/page.h>
 #include <asm/thread_info.h>
 
 	.macro	csdb
diff --git a/arch/arm/include/asm/uaccess.h b/arch/arm/include/asm/uaccess.h
index 2fcbec9c306c..bb5c81823117 100644
--- a/arch/arm/include/asm/uaccess.h
+++ b/arch/arm/include/asm/uaccess.h
@@ -9,7 +9,7 @@
  * User space memory access functions
  */
 #include <linux/string.h>
-#include <asm/memory.h>
+#include <asm/page.h>
 #include <asm/domain.h>
 #include <asm/unaligned.h>
 #include <asm/unified.h>
diff --git a/arch/arm/kernel/asm-offsets.c b/arch/arm/kernel/asm-offsets.c
index 38121c59cbc2..6a80d4be743b 100644
--- a/arch/arm/kernel/asm-offsets.c
+++ b/arch/arm/kernel/asm-offsets.c
@@ -17,7 +17,7 @@
 #include <asm/glue-pf.h>
 #include <asm/mach/arch.h>
 #include <asm/thread_info.h>
-#include <asm/memory.h>
+#include <asm/page.h>
 #include <asm/mpu.h>
 #include <asm/procinfo.h>
 #include <asm/suspend.h>
diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index c39303e5c234..112fd6cd3f26 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -15,7 +15,7 @@
 #include <linux/init.h>
 
 #include <asm/assembler.h>
-#include <asm/memory.h>
+#include <asm/page.h>
 #include <asm/glue-df.h>
 #include <asm/glue-pf.h>
 #include <asm/vfpmacros.h>
diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index 03d4c5578c5c..bcc4c9ec3aa4 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -9,7 +9,7 @@
 #include <asm/unistd.h>
 #include <asm/ftrace.h>
 #include <asm/unwind.h>
-#include <asm/memory.h>
+#include <asm/page.h>
 #ifdef CONFIG_AEABI
 #include <asm/unistd-oabi.h>
 #endif
diff --git a/arch/arm/kernel/entry-v7m.S b/arch/arm/kernel/entry-v7m.S
index de8a60363c85..52bacf07ba16 100644
--- a/arch/arm/kernel/entry-v7m.S
+++ b/arch/arm/kernel/entry-v7m.S
@@ -6,7 +6,7 @@
  *
  * Low-level vector interface routines for the ARMv7-M architecture
  */
-#include <asm/memory.h>
+#include <asm/page.h>
 #include <asm/glue.h>
 #include <asm/thread_notify.h>
 #include <asm/v7m.h>
diff --git a/arch/arm/kernel/head-nommu.S b/arch/arm/kernel/head-nommu.S
index 950bef83339f..b9d6818f1ee1 100644
--- a/arch/arm/kernel/head-nommu.S
+++ b/arch/arm/kernel/head-nommu.S
@@ -14,12 +14,11 @@
 #include <asm/assembler.h>
 #include <asm/ptrace.h>
 #include <asm/asm-offsets.h>
-#include <asm/memory.h>
+#include <asm/page.h>
 #include <asm/cp15.h>
 #include <asm/thread_info.h>
 #include <asm/v7m.h>
 #include <asm/mpu.h>
-#include <asm/page.h>
 
 /*
  * Kernel startup entry point.
diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index 656991055bc1..1ec35f065617 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -17,7 +17,7 @@
 #include <asm/domain.h>
 #include <asm/ptrace.h>
 #include <asm/asm-offsets.h>
-#include <asm/memory.h>
+#include <asm/page.h>
 #include <asm/thread_info.h>
 
 #if defined(CONFIG_DEBUG_LL) && !defined(CONFIG_DEBUG_SEMIHOSTING)
diff --git a/arch/arm/kernel/hibernate.c b/arch/arm/kernel/hibernate.c
index 2373020af965..38a90a3d12b2 100644
--- a/arch/arm/kernel/hibernate.c
+++ b/arch/arm/kernel/hibernate.c
@@ -19,7 +19,7 @@
 #include <asm/system_misc.h>
 #include <asm/idmap.h>
 #include <asm/suspend.h>
-#include <asm/memory.h>
+#include <asm/page.h>
 #include <asm/sections.h>
 #include "reboot.h"
 
diff --git a/arch/arm/kernel/suspend.c b/arch/arm/kernel/suspend.c
index 43f0a3ebf390..c3ec3861dd07 100644
--- a/arch/arm/kernel/suspend.c
+++ b/arch/arm/kernel/suspend.c
@@ -8,7 +8,7 @@
 #include <asm/bugs.h>
 #include <asm/cacheflush.h>
 #include <asm/idmap.h>
-#include <asm/memory.h>
+#include <asm/page.h>
 #include <asm/smp_plat.h>
 #include <asm/suspend.h>
 #include <asm/tlbflush.h>
diff --git a/arch/arm/kernel/tcm.c b/arch/arm/kernel/tcm.c
index d3a85f01b328..f59927bcfbce 100644
--- a/arch/arm/kernel/tcm.c
+++ b/arch/arm/kernel/tcm.c
@@ -15,7 +15,7 @@
 #include <linux/string.h> /* memcpy */
 #include <asm/cputype.h>
 #include <asm/mach/map.h>
-#include <asm/memory.h>
+#include <asm/page.h>
 #include <asm/system_info.h>
 #include <asm/traps.h>
 #include <asm/tcm.h>
diff --git a/arch/arm/kernel/vmlinux-xip.lds.S b/arch/arm/kernel/vmlinux-xip.lds.S
index 76678732c60d..c16d196b5aad 100644
--- a/arch/arm/kernel/vmlinux-xip.lds.S
+++ b/arch/arm/kernel/vmlinux-xip.lds.S
@@ -12,9 +12,8 @@
 #include <asm/vmlinux.lds.h>
 #include <asm/cache.h>
 #include <asm/thread_info.h>
-#include <asm/memory.h>
-#include <asm/mpu.h>
 #include <asm/page.h>
+#include <asm/mpu.h>
 
 OUTPUT_ARCH(arm)
 ENTRY(stext)
diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index aa12b65a7fd6..bd9127c4b451 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -12,9 +12,8 @@
 #include <asm/vmlinux.lds.h>
 #include <asm/cache.h>
 #include <asm/thread_info.h>
-#include <asm/memory.h>
-#include <asm/mpu.h>
 #include <asm/page.h>
+#include <asm/mpu.h>
 
 OUTPUT_ARCH(arm)
 ENTRY(stext)
diff --git a/arch/arm/mach-berlin/platsmp.c b/arch/arm/mach-berlin/platsmp.c
index 593fc4a69d84..ed94758d30ff 100644
--- a/arch/arm/mach-berlin/platsmp.c
+++ b/arch/arm/mach-berlin/platsmp.c
@@ -12,7 +12,7 @@
 
 #include <asm/cacheflush.h>
 #include <asm/cp15.h>
-#include <asm/memory.h>
+#include <asm/page.h>
 #include <asm/smp_plat.h>
 #include <asm/smp_scu.h>
 
diff --git a/arch/arm/mach-keystone/keystone.c b/arch/arm/mach-keystone/keystone.c
index aa352c2de313..68039aad3014 100644
--- a/arch/arm/mach-keystone/keystone.c
+++ b/arch/arm/mach-keystone/keystone.c
@@ -18,7 +18,7 @@
 #include <asm/mach/map.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
-#include <asm/memory.h>
+#include <asm/page.h>
 
 #include "memory.h"
 
diff --git a/arch/arm/mach-omap2/sleep33xx.S b/arch/arm/mach-omap2/sleep33xx.S
index ac3d0b363c51..3bfd8b5e03ed 100644
--- a/arch/arm/mach-omap2/sleep33xx.S
+++ b/arch/arm/mach-omap2/sleep33xx.S
@@ -10,7 +10,7 @@
 #include <linux/platform_data/pm33xx.h>
 #include <linux/ti-emif-sram.h>
 #include <asm/assembler.h>
-#include <asm/memory.h>
+#include <asm/page.h>
 
 #include "iomap.h"
 #include "cm33xx.h"
diff --git a/arch/arm/mach-omap2/sleep43xx.S b/arch/arm/mach-omap2/sleep43xx.S
index 832c91327945..ec0972a48f08 100644
--- a/arch/arm/mach-omap2/sleep43xx.S
+++ b/arch/arm/mach-omap2/sleep43xx.S
@@ -11,7 +11,7 @@
 #include <linux/platform_data/pm33xx.h>
 #include <asm/assembler.h>
 #include <asm/hardware/cache-l2x0.h>
-#include <asm/memory.h>
+#include <asm/page.h>
 
 #include "cm33xx.h"
 #include "common.h"
diff --git a/arch/arm/mach-omap2/sleep44xx.S b/arch/arm/mach-omap2/sleep44xx.S
index f60f6a9aed73..f09c9197808b 100644
--- a/arch/arm/mach-omap2/sleep44xx.S
+++ b/arch/arm/mach-omap2/sleep44xx.S
@@ -9,7 +9,7 @@
 #include <linux/linkage.h>
 #include <asm/assembler.h>
 #include <asm/smp_scu.h>
-#include <asm/memory.h>
+#include <asm/page.h>
 #include <asm/hardware/cache-l2x0.h>
 
 #include "omap-secure.h"
diff --git a/arch/arm/mach-pxa/gumstix.c b/arch/arm/mach-pxa/gumstix.c
index 72b08a9bf0fd..ebeee82e649e 100644
--- a/arch/arm/mach-pxa/gumstix.c
+++ b/arch/arm/mach-pxa/gumstix.c
@@ -26,7 +26,7 @@
 #include <linux/clk.h>
 
 #include <asm/setup.h>
-#include <asm/memory.h>
+#include <asm/page.h>
 #include <asm/mach-types.h>
 #include <asm/irq.h>
 #include <linux/sizes.h>
diff --git a/arch/arm/mach-rockchip/sleep.S b/arch/arm/mach-rockchip/sleep.S
index 3eca3922c944..38b6c5186c3c 100644
--- a/arch/arm/mach-rockchip/sleep.S
+++ b/arch/arm/mach-rockchip/sleep.S
@@ -6,7 +6,7 @@
 
 #include <linux/linkage.h>
 #include <asm/assembler.h>
-#include <asm/memory.h>
+#include <asm/page.h>
 
 .data
 /*
diff --git a/arch/arm/mach-sa1100/pm.c b/arch/arm/mach-sa1100/pm.c
index 9a7079f565bd..9cf5d917bb92 100644
--- a/arch/arm/mach-sa1100/pm.c
+++ b/arch/arm/mach-sa1100/pm.c
@@ -29,7 +29,7 @@
 #include <linux/time.h>
 
 #include <mach/hardware.h>
-#include <asm/memory.h>
+#include <asm/page.h>
 #include <asm/suspend.h>
 #include <asm/mach/time.h>
 
diff --git a/arch/arm/mach-shmobile/headsmp-scu.S b/arch/arm/mach-shmobile/headsmp-scu.S
index d0234296ae62..e892ee794d64 100644
--- a/arch/arm/mach-shmobile/headsmp-scu.S
+++ b/arch/arm/mach-shmobile/headsmp-scu.S
@@ -7,7 +7,7 @@
 
 #include <linux/linkage.h>
 #include <linux/init.h>
-#include <asm/memory.h>
+#include <asm/page.h>
 
 /*
  * Boot code for secondary CPUs.
diff --git a/arch/arm/mach-shmobile/headsmp.S b/arch/arm/mach-shmobile/headsmp.S
index 9466ae61f56a..a956b489b6ea 100644
--- a/arch/arm/mach-shmobile/headsmp.S
+++ b/arch/arm/mach-shmobile/headsmp.S
@@ -11,7 +11,7 @@
 #include <linux/linkage.h>
 #include <linux/threads.h>
 #include <asm/assembler.h>
-#include <asm/memory.h>
+#include <asm/page.h>
 
 #define SCTLR_MMU	0x01
 #define BOOTROM_ADDRESS	0xE6340000
diff --git a/arch/arm/mach-socfpga/headsmp.S b/arch/arm/mach-socfpga/headsmp.S
index 54f1844eac03..f7e91a772428 100644
--- a/arch/arm/mach-socfpga/headsmp.S
+++ b/arch/arm/mach-socfpga/headsmp.S
@@ -6,7 +6,7 @@
  */
 #include <linux/linkage.h>
 #include <linux/init.h>
-#include <asm/memory.h>
+#include <asm/page.h>
 #include <asm/assembler.h>
 
 	.arch	armv7-a
diff --git a/arch/arm/mach-spear/spear.h b/arch/arm/mach-spear/spear.h
index 432efd407c76..f23eaf1e522f 100644
--- a/arch/arm/mach-spear/spear.h
+++ b/arch/arm/mach-spear/spear.h
@@ -10,7 +10,7 @@
 #ifndef __MACH_SPEAR_H
 #define __MACH_SPEAR_H
 
-#include <asm/memory.h>
+#include <asm/page.h>
 
 #if defined(CONFIG_ARCH_SPEAR3XX) || defined (CONFIG_ARCH_SPEAR6XX)
 
diff --git a/arch/arm/mm/cache-fa.S b/arch/arm/mm/cache-fa.S
index 3a464d1649b4..71c64e92dead 100644
--- a/arch/arm/mm/cache-fa.S
+++ b/arch/arm/mm/cache-fa.S
@@ -13,7 +13,6 @@
 #include <linux/linkage.h>
 #include <linux/init.h>
 #include <asm/assembler.h>
-#include <asm/memory.h>
 #include <asm/page.h>
 
 #include "proc-macros.S"
diff --git a/arch/arm/mm/cache-v4wb.S b/arch/arm/mm/cache-v4wb.S
index 905ac2fa2b1e..ad382cee0fdb 100644
--- a/arch/arm/mm/cache-v4wb.S
+++ b/arch/arm/mm/cache-v4wb.S
@@ -7,7 +7,6 @@
 #include <linux/linkage.h>
 #include <linux/init.h>
 #include <asm/assembler.h>
-#include <asm/memory.h>
 #include <asm/page.h>
 #include "proc-macros.S"
 
diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index b4a33358d2e9..0549bee68a67 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -25,7 +25,7 @@
 #include <linux/sizes.h>
 #include <linux/cma.h>
 
-#include <asm/memory.h>
+#include <asm/page.h>
 #include <asm/highmem.h>
 #include <asm/cacheflush.h>
 #include <asm/tlbflush.h>
diff --git a/arch/arm/mm/dump.c b/arch/arm/mm/dump.c
index 059eb4cdc9c2..a9381095ab36 100644
--- a/arch/arm/mm/dump.c
+++ b/arch/arm/mm/dump.c
@@ -15,7 +15,7 @@
 
 #include <asm/domain.h>
 #include <asm/fixmap.h>
-#include <asm/memory.h>
+#include <asm/page.h>
 #include <asm/ptdump.h>
 
 static struct addr_marker address_markers[] = {
diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index ce64bdb55a16..a42e4cd11db2 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -26,7 +26,7 @@
 #include <asm/cp15.h>
 #include <asm/mach-types.h>
 #include <asm/memblock.h>
-#include <asm/memory.h>
+#include <asm/page.h>
 #include <asm/prom.h>
 #include <asm/sections.h>
 #include <asm/setup.h>
diff --git a/arch/arm/mm/kasan_init.c b/arch/arm/mm/kasan_init.c
index 46d9f4a622cb..24d71b5db62d 100644
--- a/arch/arm/mm/kasan_init.c
+++ b/arch/arm/mm/kasan_init.c
@@ -17,7 +17,6 @@
 #include <asm/cputype.h>
 #include <asm/highmem.h>
 #include <asm/mach/map.h>
-#include <asm/memory.h>
 #include <asm/page.h>
 #include <asm/pgalloc.h>
 #include <asm/procinfo.h>
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 463fc2a8448f..22292cf3381c 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -26,7 +26,7 @@
 #include <asm/system_info.h>
 #include <asm/traps.h>
 #include <asm/procinfo.h>
-#include <asm/memory.h>
+#include <asm/page.h>
 #include <asm/pgalloc.h>
 #include <asm/kasan_def.h>
 
diff --git a/arch/arm/mm/physaddr.c b/arch/arm/mm/physaddr.c
index cf75819e4c13..3f263c840ebc 100644
--- a/arch/arm/mm/physaddr.c
+++ b/arch/arm/mm/physaddr.c
@@ -6,7 +6,7 @@
 #include <linux/mm.h>
 
 #include <asm/sections.h>
-#include <asm/memory.h>
+#include <asm/page.h>
 #include <asm/fixmap.h>
 #include <asm/dma.h>
 
diff --git a/arch/arm/mm/pmsa-v8.c b/arch/arm/mm/pmsa-v8.c
index 8359748a19a1..28cdc5468406 100644
--- a/arch/arm/mm/pmsa-v8.c
+++ b/arch/arm/mm/pmsa-v8.c
@@ -11,7 +11,7 @@
 #include <asm/cputype.h>
 #include <asm/mpu.h>
 
-#include <asm/memory.h>
+#include <asm/page.h>
 #include <asm/sections.h>
 
 #include "mm.h"
diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index 6b4ef9539b68..193c7aeb6703 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -14,7 +14,7 @@
 #include <asm/asm-offsets.h>
 #include <asm/hwcap.h>
 #include <asm/pgtable-hwdef.h>
-#include <asm/memory.h>
+#include <asm/page.h>
 
 #include "proc-macros.S"
 
diff --git a/arch/arm/mm/proc-v7m.S b/arch/arm/mm/proc-v7m.S
index 335144d50134..d65a12f851a9 100644
--- a/arch/arm/mm/proc-v7m.S
+++ b/arch/arm/mm/proc-v7m.S
@@ -9,7 +9,7 @@
  */
 #include <linux/linkage.h>
 #include <asm/assembler.h>
-#include <asm/memory.h>
+#include <asm/page.h>
 #include <asm/v7m.h>
 #include "proc-macros.S"
 
diff --git a/arch/arm/mm/pv-fixup-asm.S b/arch/arm/mm/pv-fixup-asm.S
index f8e11f7c7880..1d9f52c71ad0 100644
--- a/arch/arm/mm/pv-fixup-asm.S
+++ b/arch/arm/mm/pv-fixup-asm.S
@@ -9,7 +9,7 @@
 #include <linux/pgtable.h>
 #include <asm/asm-offsets.h>
 #include <asm/cp15.h>
-#include <asm/memory.h>
+#include <asm/page.h>
 
 	.section ".idmap.text", "ax"
 
diff --git a/drivers/memory/ti-emif-sram-pm.S b/drivers/memory/ti-emif-sram-pm.S
index d60a8cfd63f3..7756b3971244 100644
--- a/drivers/memory/ti-emif-sram-pm.S
+++ b/drivers/memory/ti-emif-sram-pm.S
@@ -8,7 +8,7 @@
 
 #include <linux/linkage.h>
 #include <asm/assembler.h>
-#include <asm/memory.h>
+#include <asm/page.h>
 
 #include "emif.h"
 #include "ti-emif-asm-offsets.h"

-- 
2.34.1

