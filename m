Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 798062A1FD0
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Nov 2020 18:05:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbgKARFG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Nov 2020 12:05:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:38564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726790AbgKARFG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Nov 2020 12:05:06 -0500
Received: from aquarius.haifa.ibm.com (nesher1.haifa.il.ibm.com [195.110.40.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1FAFA2074F;
        Sun,  1 Nov 2020 17:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604250305;
        bh=oXw4Lx1NYuJ69gGGqNamHUkXUylmi9VRKQWFyQVI+YU=;
        h=From:To:Cc:Subject:Date:From;
        b=FrkPQS2E0ZQ+PuuS3oma+ZwGGofySdv39YC9LrWPhRCR56yt5T8bw9DGG1PbkpkMk
         JhiXZHBdj2Tg0cHvoX7pwd236w1hfXnFzVx3jCaOzF19IyG09GNFF8EpLuY+OEnvCz
         dphHcTa0Kq2BUBQMWmfn5dXwTbV+wTs002IDs+Qs=
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
Subject: [PATCH v2 00/13]  arch, mm: deprecate DISCONTIGMEM
Date:   Sun,  1 Nov 2020 19:04:41 +0200
Message-Id: <20201101170454.9567-1-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

Hi,

It's been a while since DISCONTIGMEM is generally considered deprecated,
but it is still used by four architectures. This set replaces DISCONTIGMEM
with a different way to handle holes in the memory map and marks
DISCONTIGMEM configuration as BROKEN in Kconfigs of these architectures with
the intention to completely remove it in several releases.

While for 64-bit alpha and ia64 the switch to SPARSEMEM is quite obvious
and was a matter of moving some bits around, for smaller 32-bit arc and
m68k SPARSEMEM is not necessarily the best thing to do.

On 32-bit machines SPARSEMEM would require large sections to make section
index fit in the page flags, but larger sections mean that more memory is
wasted for unused memory map.

Besides, pfn_to_page() and page_to_pfn() become less efficient, at least on
arc.

So I've decided to generalize arm's approach for freeing of unused parts of
the memory map with FLATMEM and enable it for both arc and m68k. The
details are in the description of patches 10 (arc) and 13 (m68k).

v2 changes:
- remove additional stale '#ifdef CONFIG_SINGLE_MEMORY_CHUNK' on m68k
- fix bisectability on m68k

v1:
https://lore.kernel.org/lkml/20201027112955.14157-1-rppt@kernel.org

Mike Rapoport (13):
  alpha: switch from DISCONTIGMEM to SPARSEMEM
  ia64: remove custom __early_pfn_to_nid()
  ia64: remove 'ifdef CONFIG_ZONE_DMA32' statements
  ia64: discontig: paging_init(): remove local max_pfn calculation
  ia64: split virtual map initialization out of paging_init()
  ia64: forbid using VIRTUAL_MEM_MAP with FLATMEM
  ia64: make SPARSEMEM default and disable DISCONTIGMEM
  arm: remove CONFIG_ARCH_HAS_HOLES_MEMORYMODEL
  arm, arm64: move free_unused_memmap() to generic mm
  arc: use FLATMEM with freeing of unused memory map instead of
    DISCONTIGMEM
  m68k/mm: make node data and node setup depend on CONFIG_DISCONTIGMEM
  m68k/mm: enable use of generic memory_model.h for !DISCONTIGMEM
  m68k: deprecate DISCONTIGMEM

 Documentation/vm/memory-model.rst   |  3 +-
 arch/Kconfig                        |  3 ++
 arch/alpha/Kconfig                  |  8 +++
 arch/alpha/include/asm/mmzone.h     | 14 +----
 arch/alpha/include/asm/page.h       |  7 +--
 arch/alpha/include/asm/pgtable.h    | 12 ++---
 arch/alpha/include/asm/sparsemem.h  | 18 +++++++
 arch/alpha/kernel/setup.c           |  1 +
 arch/arc/Kconfig                    |  3 +-
 arch/arc/include/asm/page.h         | 20 ++++++--
 arch/arc/mm/init.c                  | 29 ++++++++---
 arch/arm/Kconfig                    | 10 +---
 arch/arm/mach-bcm/Kconfig           |  1 -
 arch/arm/mach-davinci/Kconfig       |  1 -
 arch/arm/mach-exynos/Kconfig        |  1 -
 arch/arm/mach-highbank/Kconfig      |  1 -
 arch/arm/mach-omap2/Kconfig         |  1 -
 arch/arm/mach-s5pv210/Kconfig       |  1 -
 arch/arm/mach-tango/Kconfig         |  1 -
 arch/arm/mm/init.c                  | 78 ----------------------------
 arch/arm64/Kconfig                  |  4 +-
 arch/arm64/mm/init.c                | 68 ------------------------
 arch/ia64/Kconfig                   | 11 ++--
 arch/ia64/include/asm/meminit.h     |  2 -
 arch/ia64/mm/contig.c               | 58 ++++++++++-----------
 arch/ia64/mm/discontig.c            | 44 ++++++++--------
 arch/ia64/mm/init.c                 | 14 -----
 arch/ia64/mm/numa.c                 | 30 -----------
 arch/m68k/Kconfig.cpu               | 31 +++++++++--
 arch/m68k/include/asm/page.h        |  2 +
 arch/m68k/include/asm/page_mm.h     |  7 ++-
 arch/m68k/include/asm/virtconvert.h |  5 --
 arch/m68k/mm/init.c                 |  8 +--
 fs/proc/kcore.c                     |  2 -
 include/linux/mm.h                  |  3 --
 include/linux/mmzone.h              | 42 ---------------
 mm/memblock.c                       | 80 +++++++++++++++++++++++++++++
 mm/mmzone.c                         | 14 -----
 mm/page_alloc.c                     | 16 ++++--
 mm/vmstat.c                         |  4 --
 40 files changed, 270 insertions(+), 388 deletions(-)
 create mode 100644 arch/alpha/include/asm/sparsemem.h

base-commit: 3650b228f83adda7e5ee532e2b90429c03f7b9ec
-- 
2.28.0

