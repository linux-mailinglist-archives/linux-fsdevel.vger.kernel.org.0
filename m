Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A27562D8C70
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Dec 2020 09:37:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405394AbgLMIhQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 13 Dec 2020 03:37:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:38846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405258AbgLMIhQ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 13 Dec 2020 03:37:16 -0500
Date:   Sun, 13 Dec 2020 10:36:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607848595;
        bh=Oe5JGmuoMJ7Fs86WbZB5DZ1VQL2J/VAWBl+yhiWVzvc=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=giEpchRcy5TjV9ZPzj0N2Wlz7xFPJvYE3eB6uLRF2S+KF2bzg5LCT6jd1ZWDSoGpo
         IDu1rDd1+q8X76G5XPDmzweszjCemSA+1Y3Xm7O6/ikSbuLm+0W6A03T+FDqjCREjR
         A2bH0triUWEEOsEsJD1E6iOmbfGUf8t6lTz6+0BU8O24Yt+WaVjupEsTb4ik4kweIO
         KUmQ7pq2euLIkksCLx1dbpbat2gG4ZarsEmZIRHK1iIbo1tfiGBcyRtFBoc5oiqE60
         SvASYLoEtg1dHP0ygnpg2NlWoCAEAmL9bR3Xsmh8b2AVNXcs+p9DtN7w7jWs7mq2QS
         JE8iYzcEHWvpg==
From:   Mike Rapoport <rppt@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Matt Turner <mattst88@gmail.com>, Meelis Roos <mroos@linux.ee>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Russell King <linux@armlinux.org.uk>,
        Tony Luck <tony.luck@intel.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Will Deacon <will@kernel.org>, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mm@kvack.org, linux-snps-arc@lists.infradead.org
Subject: Re: [PATCH 07/13] ia64: make SPARSEMEM default and disable
 DISCONTIGMEM
Message-ID: <20201213083623.GA198219@kernel.org>
References: <20201027112955.14157-1-rppt@kernel.org>
 <20201027112955.14157-8-rppt@kernel.org>
 <20201212160144.GA174701@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201212160144.GA174701@roeck-us.net>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Dec 12, 2020 at 08:01:44AM -0800, Guenter Roeck wrote:
> On Tue, Oct 27, 2020 at 01:29:49PM +0200, Mike Rapoport wrote:
> > From: Mike Rapoport <rppt@linux.ibm.com>
> > 
> > SPARSEMEM memory model suitable for systems with large holes in their
> > phyiscal memory layout. With SPARSEMEM_VMEMMAP enabled it provides
> > pfn_to_page() and page_to_pfn() as fast as FLATMEM.
> > 
> > Make it the default memory model for IA-64 and disable DISCONTIGMEM which
> > is considered obsolete for quite some time.
> > 
> > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> 
> This patch results in 
> 
> include/linux/mmzone.h:1156:2: error: #error Allocator MAX_ORDER exceeds SECTION_SIZE
>  1156 | #error Allocator MAX_ORDER exceeds SECTION_SIZE
> 
> when building ia64:defconfig.
> 
> Also, PAGE_SHIFT is not defined, though I don't know if that is related.

This is realated as sparesemem.h on ia64 needs PAGE_SHIFT for
SECTION_SIZE and it is not there.
This fixes the build for me (the patch is vs
v5.10-rc7-mmots-2020-12-11-14-43)

diff --git a/arch/ia64/include/asm/sparsemem.h b/arch/ia64/include/asm/sparsemem.h
index dd8c166ffd7b..84652c26f3d9 100644
--- a/arch/ia64/include/asm/sparsemem.h
+++ b/arch/ia64/include/asm/sparsemem.h
@@ -3,6 +3,8 @@
 #define _ASM_IA64_SPARSEMEM_H
 
 #ifdef CONFIG_SPARSEMEM
+#include <asm/page.h>
+
 /*
  * SECTION_SIZE_BITS            2^N: how big each section will be
  * MAX_PHYSMEM_BITS             2^N: how much memory we can have in that space

> Reverting the patch fixes the problem for me.
> 
> Guenter
> 
> ---
> bisect log:
> 
> # bad: [3cc2bd440f2171f093b3a8480a4b54d8c270ed38] Add linux-next specific files for 20201211
> # good: [0477e92881850d44910a7e94fc2c46f96faa131f] Linux 5.10-rc7
> git bisect start 'HEAD' 'v5.10-rc7'
> # good: [0a701401d4e29d9e73f0f3cc02179fc6c9191646] Merge remote-tracking branch 'crypto/master'
> git bisect good 0a701401d4e29d9e73f0f3cc02179fc6c9191646
> # good: [6fd39ad603b113e9c68180b9138084710c036e34] Merge remote-tracking branch 'spi/for-next'
> git bisect good 6fd39ad603b113e9c68180b9138084710c036e34
> # good: [c96b2eec436e87b8c673213b203559bed9e551b9] Merge remote-tracking branch 'vfio/next'
> git bisect good c96b2eec436e87b8c673213b203559bed9e551b9
> # good: [4f2e7f6a2ce4e621b77e59c8763549fa8bee7b4b] Merge remote-tracking branch 'gpio/for-next'
> git bisect good 4f2e7f6a2ce4e621b77e59c8763549fa8bee7b4b
> # good: [5ee06b21caaeb37a1ff5143e8ce91b376fe73dc2] swiotlb.h: add "inline" to swiotlb_adjust_size
> git bisect good 5ee06b21caaeb37a1ff5143e8ce91b376fe73dc2
> # bad: [46aa09d885ce303efd6444def783ec575a5b57ee] mm, page_poison: remove CONFIG_PAGE_POISONING_ZERO
> git bisect bad 46aa09d885ce303efd6444def783ec575a5b57ee
> # good: [3b77356d530bfd93e2450c063718292aa435eede] mm: mmap_lock: add tracepoints around lock acquisition
> git bisect good 3b77356d530bfd93e2450c063718292aa435eede
> # bad: [e0287fb91c006d12bed9e6fbfc7fe661ad7f9647] mm,hwpoison: disable pcplists before grabbing a refcount
> git bisect bad e0287fb91c006d12bed9e6fbfc7fe661ad7f9647
> # bad: [94d171d065be406a2407f0d723afe14c05526283] ia64: make SPARSEMEM default and disable DISCONTIGMEM
> git bisect bad 94d171d065be406a2407f0d723afe14c05526283
> # good: [7499e1e91e18a285274e9b761ba2abf21e4343fa] mm/vmalloc: use free_vm_area() if an allocation fails
> git bisect good 7499e1e91e18a285274e9b761ba2abf21e4343fa
> # good: [eba50fff503fa6d6e20679509a1a960c3e003d22] lib/test_kasan.c: add workqueue test case
> git bisect good eba50fff503fa6d6e20679509a1a960c3e003d22
> # good: [e343d6ff702aaae6181448a38ff85cf201b011ba] ia64: remove 'ifdef CONFIG_ZONE_DMA32' statements
> git bisect good e343d6ff702aaae6181448a38ff85cf201b011ba
> # good: [a0bfb938ae29239a3f13f6a6a4ef41c3c7f0c84c] ia64: split virtual map initialization out of paging_init()
> git bisect good a0bfb938ae29239a3f13f6a6a4ef41c3c7f0c84c
> # good: [0e791e5138cde9b96d34ba68136fd26bb97f81e5] ia64: forbid using VIRTUAL_MEM_MAP with FLATMEM
> git bisect good 0e791e5138cde9b96d34ba68136fd26bb97f81e5
> # first bad commit: [94d171d065be406a2407f0d723afe14c05526283] ia64: make SPARSEMEM default and disable DISCONTIGMEM
> 

-- 
Sincerely yours,
Mike.
