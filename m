Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51E4F29AAB3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Oct 2020 12:30:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2899177AbgJ0Laa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Oct 2020 07:30:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:45516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1744152AbgJ0La1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Oct 2020 07:30:27 -0400
Received: from aquarius.haifa.ibm.com (nesher1.haifa.il.ibm.com [195.110.40.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2671822263;
        Tue, 27 Oct 2020 11:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603798226;
        bh=hxEOxl1IwdTpwx70FS/bBSNDVfegzJWvFNtGcxWnpK8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E3w7SoEr+bfUieWUtprrUKUdeSIk/mdTYkq83jXT4rLa44KxiLoDPrUXbgRlwCJUk
         /RvM+YASN1IDh/7lvbhSR/CaSXPb9U+uiK4CUciGNilyZkeYX/46tfjHPMuXAbQDMd
         spxApcgn8Sh8oDwxyZ1BH+IQOnm7p6lfMmeYQvaQ=
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Matt Turner <mattst88@gmail.com>, Meelis Roos <mroos@linux.ee>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Russell King <linux@armlinux.org.uk>,
        Tony Luck <tony.luck@intel.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Will Deacon <will@kernel.org>, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mm@kvack.org, linux-snps-arc@lists.infradead.org
Subject: [PATCH 03/13] ia64: remove 'ifdef CONFIG_ZONE_DMA32' statements
Date:   Tue, 27 Oct 2020 13:29:45 +0200
Message-Id: <20201027112955.14157-4-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201027112955.14157-1-rppt@kernel.org>
References: <20201027112955.14157-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

After the removal of SN2 platform (commit cf07cb1ff4ea ("ia64: remove
support for the SGI SN2 platform") IA-64 always has ZONE_DMA32 and there is
no point to guard code with this configuration option.

Remove ifdefery associated with CONFIG_ZONE_DMA32

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/ia64/mm/contig.c    | 2 --
 arch/ia64/mm/discontig.c | 2 --
 2 files changed, 4 deletions(-)

diff --git a/arch/ia64/mm/contig.c b/arch/ia64/mm/contig.c
index e30e360beef8..2491aaeca90c 100644
--- a/arch/ia64/mm/contig.c
+++ b/arch/ia64/mm/contig.c
@@ -177,10 +177,8 @@ paging_init (void)
 	unsigned long max_zone_pfns[MAX_NR_ZONES];
 
 	memset(max_zone_pfns, 0, sizeof(max_zone_pfns));
-#ifdef CONFIG_ZONE_DMA32
 	max_dma = virt_to_phys((void *) MAX_DMA_ADDRESS) >> PAGE_SHIFT;
 	max_zone_pfns[ZONE_DMA32] = max_dma;
-#endif
 	max_zone_pfns[ZONE_NORMAL] = max_low_pfn;
 
 #ifdef CONFIG_VIRTUAL_MEM_MAP
diff --git a/arch/ia64/mm/discontig.c b/arch/ia64/mm/discontig.c
index dbe829fc5298..d255596f52c6 100644
--- a/arch/ia64/mm/discontig.c
+++ b/arch/ia64/mm/discontig.c
@@ -621,9 +621,7 @@ void __init paging_init(void)
 	}
 
 	memset(max_zone_pfns, 0, sizeof(max_zone_pfns));
-#ifdef CONFIG_ZONE_DMA32
 	max_zone_pfns[ZONE_DMA32] = max_dma;
-#endif
 	max_zone_pfns[ZONE_NORMAL] = max_pfn;
 	free_area_init(max_zone_pfns);
 
-- 
2.28.0

