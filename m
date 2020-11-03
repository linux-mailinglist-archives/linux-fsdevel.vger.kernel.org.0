Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3283B2A424E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Nov 2020 11:34:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728457AbgKCKdv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Nov 2020 05:33:51 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:38330 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728251AbgKCKdu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Nov 2020 05:33:50 -0500
Message-Id: <20201103095858.422094352@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604399625;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=smrPH5soON645xyx9VRl+21drBOTiCV7paBhp6VDF7c=;
        b=1s+HyF/FYJ/rgPZaWI+m83inHucd+bq/quSZGod6llIFmqowzQ5Uj534Dp2bA5XqxHpczy
        5PbeanQRfDz1AuX8kinkfWMXcS8BmJk+fThow4mOsKbqg60U1tglzYZirczwEafzmV304k
        vWL7Lw90rdS3zi+ezQm23RGH6jkCbJwsDDz9S70OXSyQOVtLVy3YhkIhceubZ5L2mtPL5D
        XeFeNSZCmuHE7+4H3i4/EJ1oonlJIFtOzN4einmFJgZE+tRVlreGH2pa/fMfqFTEA+imSe
        wIFE4YW6BPWkrcSVgyukWdBcDSRT5ns4ro16iCnklveIoZw2mTe9Ka8l6/ODCA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604399625;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=smrPH5soON645xyx9VRl+21drBOTiCV7paBhp6VDF7c=;
        b=pmC0VAx7QxdaAMBVLJ1q/DEtO4tuXlK2LCYdUzolfC2B3Ot24ygRPNuRwFLcA00qeEWN6y
        xpi9fS63JrzH88CQ==
Date:   Tue, 03 Nov 2020 10:27:30 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Linus Torvalds <torvalds@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Paul McKenney <paulmck@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Benjamin LaHaise <bcrl@kvack.org>,
        linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        x86@kernel.org, Vineet Gupta <vgupta@synopsys.com>,
        linux-snps-arc@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org,
        "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org, Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Roland Scheidegger <sroland@vmware.com>,
        Dave Airlie <airlied@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        virtualization@lists.linux-foundation.org,
        spice-devel@lists.freedesktop.org, Ben Skeggs <bskeggs@redhat.com>,
        nouveau@lists.freedesktop.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        intel-gfx@lists.freedesktop.org
Subject: [patch V3 18/37] highmem: Get rid of kmap_types.h
References: <20201103092712.714480842@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The header is not longer used and on alpha, ia64, openrisc, parisc and um
it was completely unused anyway as these architectures have no highmem
support.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V3: New patch
---
 arch/alpha/include/asm/kmap_types.h  |   15 ---------------
 arch/ia64/include/asm/kmap_types.h   |   13 -------------
 arch/openrisc/mm/init.c              |    1 -
 arch/openrisc/mm/ioremap.c           |    1 -
 arch/parisc/include/asm/kmap_types.h |   13 -------------
 arch/um/include/asm/fixmap.h         |    1 -
 arch/um/include/asm/kmap_types.h     |   13 -------------
 include/asm-generic/Kbuild           |    1 -
 include/asm-generic/kmap_types.h     |   11 -----------
 include/linux/highmem.h              |    2 --
 10 files changed, 71 deletions(-)

--- a/arch/alpha/include/asm/kmap_types.h
+++ /dev/null
@@ -1,15 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_KMAP_TYPES_H
-#define _ASM_KMAP_TYPES_H
-
-/* Dummy header just to define km_type. */
-
-#ifdef CONFIG_DEBUG_HIGHMEM
-#define  __WITH_KM_FENCE
-#endif
-
-#include <asm-generic/kmap_types.h>
-
-#undef __WITH_KM_FENCE
-
-#endif
--- a/arch/ia64/include/asm/kmap_types.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_IA64_KMAP_TYPES_H
-#define _ASM_IA64_KMAP_TYPES_H
-
-#ifdef CONFIG_DEBUG_HIGHMEM
-#define  __WITH_KM_FENCE
-#endif
-
-#include <asm-generic/kmap_types.h>
-
-#undef __WITH_KM_FENCE
-
-#endif /* _ASM_IA64_KMAP_TYPES_H */
--- a/arch/openrisc/mm/init.c
+++ b/arch/openrisc/mm/init.c
@@ -33,7 +33,6 @@
 #include <asm/io.h>
 #include <asm/tlb.h>
 #include <asm/mmu_context.h>
-#include <asm/kmap_types.h>
 #include <asm/fixmap.h>
 #include <asm/tlbflush.h>
 #include <asm/sections.h>
--- a/arch/openrisc/mm/ioremap.c
+++ b/arch/openrisc/mm/ioremap.c
@@ -15,7 +15,6 @@
 #include <linux/io.h>
 #include <linux/pgtable.h>
 #include <asm/pgalloc.h>
-#include <asm/kmap_types.h>
 #include <asm/fixmap.h>
 #include <asm/bug.h>
 #include <linux/sched.h>
--- a/arch/parisc/include/asm/kmap_types.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_KMAP_TYPES_H
-#define _ASM_KMAP_TYPES_H
-
-#ifdef CONFIG_DEBUG_HIGHMEM
-#define  __WITH_KM_FENCE
-#endif
-
-#include <asm-generic/kmap_types.h>
-
-#undef __WITH_KM_FENCE
-
-#endif
--- a/arch/um/include/asm/fixmap.h
+++ b/arch/um/include/asm/fixmap.h
@@ -3,7 +3,6 @@
 #define __UM_FIXMAP_H
 
 #include <asm/processor.h>
-#include <asm/kmap_types.h>
 #include <asm/archparam.h>
 #include <asm/page.h>
 #include <linux/threads.h>
--- a/arch/um/include/asm/kmap_types.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/* 
- * Copyright (C) 2002 Jeff Dike (jdike@karaya.com)
- */
-
-#ifndef __UM_KMAP_TYPES_H
-#define __UM_KMAP_TYPES_H
-
-/* No more #include "asm/arch/kmap_types.h" ! */
-
-#define KM_TYPE_NR 14
-
-#endif
--- a/include/asm-generic/Kbuild
+++ b/include/asm-generic/Kbuild
@@ -30,7 +30,6 @@ mandatory-y += irq.h
 mandatory-y += irq_regs.h
 mandatory-y += irq_work.h
 mandatory-y += kdebug.h
-mandatory-y += kmap_types.h
 mandatory-y += kmap_size.h
 mandatory-y += kprobes.h
 mandatory-y += linkage.h
--- a/include/asm-generic/kmap_types.h
+++ /dev/null
@@ -1,11 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_GENERIC_KMAP_TYPES_H
-#define _ASM_GENERIC_KMAP_TYPES_H
-
-#ifdef __WITH_KM_FENCE
-# define KM_TYPE_NR 41
-#else
-# define KM_TYPE_NR 20
-#endif
-
-#endif
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -29,8 +29,6 @@ static inline void invalidate_kernel_vma
 }
 #endif
 
-#include <asm/kmap_types.h>
-
 /*
  * Outside of CONFIG_HIGHMEM to support X86 32bit iomap_atomic() cruft.
  */

