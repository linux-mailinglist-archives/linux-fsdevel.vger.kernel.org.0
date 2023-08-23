Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F079785896
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Aug 2023 15:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235498AbjHWNOO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Aug 2023 09:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231472AbjHWNON (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Aug 2023 09:14:13 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B0A6FE51;
        Wed, 23 Aug 2023 06:14:10 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 70FD71042;
        Wed, 23 Aug 2023 06:14:50 -0700 (PDT)
Received: from e121798.cable.virginm.net (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AD2B13F740;
        Wed, 23 Aug 2023 06:14:02 -0700 (PDT)
From:   Alexandru Elisei <alexandru.elisei@arm.com>
To:     catalin.marinas@arm.com, will@kernel.org, oliver.upton@linux.dev,
        maz@kernel.org, james.morse@arm.com, suzuki.poulose@arm.com,
        yuzenghui@huawei.com, arnd@arndb.de, akpm@linux-foundation.org,
        mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, mhiramat@kernel.org,
        rppt@kernel.org, hughd@google.com
Cc:     pcc@google.com, steven.price@arm.com, anshuman.khandual@arm.com,
        vincenzo.frascino@arm.com, david@redhat.com, eugenis@google.com,
        kcc@google.com, hyesoo.yu@samsung.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-trace-kernel@vger.kernel.org
Subject: [PATCH RFC 00/37] Add support for arm64 MTE dynamic tag storage reuse
Date:   Wed, 23 Aug 2023 14:13:13 +0100
Message-Id: <20230823131350.114942-1-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Introduction
============

Arm has implemented memory coloring in hardware, and the feature is called
Memory Tagging Extensions (MTE). It works by embedding a 4 bit tag in bits
59..56 of a pointer, and storing this tag to a reserved memory location.
When the pointer is dereferenced, the hardware compares the tag embedded in
the pointer (logical tag) with the tag stored in memory (allocation tag).

The relation between memory and where the tag for that memory is stored is
static.

The memory where the tags are stored have been so far unaccessible to Linux.
This series aims to change that, by adding support for using the tag storage
memory only as data memory; tag storage memory cannot be itself tagged.


Implementation
==============

The series is based on v6.5-rc3 with these two patches cherry picked:

- mm: Call arch_swap_restore() from unuse_pte():

    https://lore.kernel.org/all/20230523004312.1807357-3-pcc@google.com/

- arm64: mte: Simplify swap tag restoration logic:

    https://lore.kernel.org/all/20230523004312.1807357-4-pcc@google.com/

The above two patches are queued for the v6.6 merge window:

    https://lore.kernel.org/all/20230702123821.04e64ea2c04dd0fdc947bda3@linux-foundation.org/

The entire series, including the above patches, can be cloned with:

$ git clone https://gitlab.arm.com/linux-arm/linux-ae.git \
	-b arm-mte-dynamic-carveout-rfc-v1

On the arm64 architecture side, an extension is being worked on that will
clarify how MTE tag storage reuse should behave. The extension will be
made public soon.

On the Linux side, MTE tag storage reuse is accomplished with the
following changes:

1. The tag storage memory is exposed to the memory allocator as a new
migratetype, MIGRATE_METADATA. It behaves similarly to MIGRATE_CMA, with
the restriction that it cannot be used to allocate tagged memory (tag
storage memory cannot be tagged). On tagged page allocation, the
corresponding tag storage is reserved via alloc_contig_range().

2. mprotect(PROT_MTE) is implemented by changing the pte prot to
PAGE_METADATA_NONE. When the page is next accessed, a fault is taken and
the corresponding tag storage is reserved.

3. When the code tries to copy tags to a page which doesn't have the tag
storage reserved, the tags are copied to an xarray and restored in
set_pte_at(), when the page is eventually mapped with the tag storage
reserved.

KVM support has not been implemented yet, that because a non-MTE enabled VMA
can back the memory of an MTE-enabled VM. After there is a consensus on the
right approach on the memory management support, I will add it.

Explanations for the last two changes follow. The gist of it is that they
were added mostly because of races, and it my intention to make the code
more robust.

PAGE_METADATA_NONE was introduced to avoid races with mprotect(PROT_MTE).
For example, migration can race with mprotect(PROT_MTE):
- thread 0 initiates migration for a page in a non-MTE enabled VMA and a
  destination page is allocated without tag storage.
- thread 1 handles an mprotect(PROT_MTE), the VMA becomes tagged, and an
  access turns the source page that is in the process of being migrated
  into a tagged page.
- thread 0 finishes migration and the destination page is mapped as tagged,
  but without tag storage reserved.
More details and examples can be found in the patches.

This race is also related to how tag restoring is handled when tag storage
is missing: when a tagged page is swapped out, the tags are saved in an
xarray indexed by swp_entry.val. When a page is swapped back in, if there
are tags corresponding to the swp_entry that the page will replace, the
tags are unconditionally restored, even if the page will be mapped as
untagged. Because the page will be mapped as untagged, tag storage was
not reserved when the page was allocated to replace the swp_entry which has
tags associated with it.

To get around this, save the tags in a new xarray, this time indexed by
pfn, and restore them when the same page is mapped as tagged.

This also solves another race, this time with copy_highpage. In the
scenario where migration races with mprotect(PROT_MTE), before the page is
mapped, the contents of the source page is copied to the destination. And
this includes tags, which will be copied to a page with missing tag
storage, which can to data corruption if the missing tag storage is in use
for data. So copy_highpage() has received a similar treatment to the swap
code, and the source tags are copied in the xarray indexed by the
destination page pfn.


Overview of the patches
=======================

Patches 1-3 do some preparatory work by renaming a few functions and a gfp
flag.

Patches 4-12 are arch independent and introduce MIGRATE_METADATA to the
page allocator.

Patches 13-18 are arm64 specific and add support for detecting the tag
storage region and onlining it with the MIGRATE_METADATA migratetype.

Patches 19-24 are arch independent and modify the page allocator to
callback into arch dependant functions to reserve metadata storage for an
allocation which requires metadata.

Patches 25-28 are mostly arm64 specific and implement the reservation and
freeing of tag storage on tagged page allocation. Patch #28 ("mm: sched:
Introduce PF_MEMALLOC_ISOLATE") adds a current flag, PF_MEMALLOC_ISOLATE,
which ignores page isolation limits; this is used by arm64 when reserving
tag storage in the same patch.

Patches 29-30 add arch independent support for doing mprotect(PROT_MTE)
when metadata storage is enabled.

Patches 31-37 are mostly arm64 specific and handle the restoring of tags
when tag storage is missing. The exceptions are patches 32 (adds the
arch_swap_prepare_to_restore() function) and 35 (add PAGE_METADATA_NONE
support for THPs).

Testing
=======

To enable MTE dynamic tag storage:

- CONFIG_ARM64_MTE_TAG_STORAGE=y
- system_supports_mte() returns true
- kasan_hw_tags_enabled() returns false
- correct DTB node (for the specification, see commit "arm64: mte: Reserve tag
  storage memory")

Check dmesg for the message "MTE tag storage enabled" or grep for metadata
in /proc/vmstat.

I've tested the series using FVP with MTE enabled, but without support for
dynamic tag storage reuse. To simulate it, I've added two fake tag storage
regions in the DTB by splitting a 2GB region roughly into 33 slices of size
0x3e0_0000, and using 32 of them for tagged memory and one slice for tag
storage:

diff --git a/arch/arm64/boot/dts/arm/fvp-base-revc.dts b/arch/arm64/boot/dts/arm/fvp-base-revc.dts
index 60472d65a355..bd050373d6cf 100644
--- a/arch/arm64/boot/dts/arm/fvp-base-revc.dts
+++ b/arch/arm64/boot/dts/arm/fvp-base-revc.dts
@@ -165,10 +165,28 @@ C1_L2: l2-cache1 {
                };
        };
 
-       memory@80000000 {
+       memory0: memory@80000000 {
                device_type = "memory";
-               reg = <0x00000000 0x80000000 0 0x80000000>,
-                     <0x00000008 0x80000000 0 0x80000000>;
+               reg = <0x00 0x80000000 0x00 0x7c000000>;
+       };
+
+       metadata0: metadata@c0000000  {
+               compatible = "arm,mte-tag-storage";
+               reg = <0x00 0xfc000000 0x00 0x3e00000>;
+               block-size = <0x1000>;
+               memory = <&memory0>;
+       };
+
+       memory1: memory@880000000 {
+               device_type = "memory";
+               reg = <0x08 0x80000000 0x00 0x7c000000>;
+       };
+
+       metadata1: metadata@8c0000000  {
+               compatible = "arm,mte-tag-storage";
+               reg = <0x08 0xfc000000 0x00 0x3e00000>;
+               block-size = <0x1000>;
+               memory = <&memory1>;
        };
 
        reserved-memory {


Alexandru Elisei (37):
  mm: page_alloc: Rename gfp_to_alloc_flags_cma ->
    gfp_to_alloc_flags_fast
  arm64: mte: Rework naming for tag manipulation functions
  arm64: mte: Rename __GFP_ZEROTAGS to __GFP_TAGGED
  mm: Add MIGRATE_METADATA allocation policy
  mm: Add memory statistics for the MIGRATE_METADATA allocation policy
  mm: page_alloc: Allocate from movable pcp lists only if
    ALLOC_FROM_METADATA
  mm: page_alloc: Bypass pcp when freeing MIGRATE_METADATA pages
  mm: compaction: Account for free metadata pages in
    __compact_finished()
  mm: compaction: Handle metadata pages as source for direct compaction
  mm: compaction: Do not use MIGRATE_METADATA to replace pages with
    metadata
  mm: migrate/mempolicy: Allocate metadata-enabled destination page
  mm: gup: Don't allow longterm pinning of MIGRATE_METADATA pages
  arm64: mte: Reserve tag storage memory
  arm64: mte: Expose tag storage pages to the MIGRATE_METADATA freelist
  arm64: mte: Make tag storage depend on ARCH_KEEP_MEMBLOCK
  arm64: mte: Move tag storage to MIGRATE_MOVABLE when MTE is disabled
  arm64: mte: Disable dynamic tag storage management if HW KASAN is
    enabled
  arm64: mte: Check that tag storage blocks are in the same zone
  mm: page_alloc: Manage metadata storage on page allocation
  mm: compaction: Reserve metadata storage in compaction_alloc()
  mm: khugepaged: Handle metadata-enabled VMAs
  mm: shmem: Allocate metadata storage for in-memory filesystems
  mm: Teach vma_alloc_folio() about metadata-enabled VMAs
  mm: page_alloc: Teach alloc_contig_range() about MIGRATE_METADATA
  arm64: mte: Manage tag storage on page allocation
  arm64: mte: Perform CMOs for tag blocks on tagged page allocation/free
  arm64: mte: Reserve tag block for the zero page
  mm: sched: Introduce PF_MEMALLOC_ISOLATE
  mm: arm64: Define the PAGE_METADATA_NONE page protection
  mm: mprotect: arm64: Set PAGE_METADATA_NONE for mprotect(PROT_MTE)
  mm: arm64: Set PAGE_METADATA_NONE in set_pte_at() if missing metadata
    storage
  mm: Call arch_swap_prepare_to_restore() before arch_swap_restore()
  arm64: mte: swap/copypage: Handle tag restoring when missing tag
    storage
  arm64: mte: Handle fatal signal in reserve_metadata_storage()
  mm: hugepage: Handle PAGE_METADATA_NONE faults for huge pages
  KVM: arm64: Disable MTE is tag storage is enabled
  arm64: mte: Enable tag storage management

 arch/arm64/Kconfig                       |  13 +
 arch/arm64/include/asm/assembler.h       |  10 +
 arch/arm64/include/asm/memory_metadata.h |  49 ++
 arch/arm64/include/asm/mte-def.h         |  16 +-
 arch/arm64/include/asm/mte.h             |  40 +-
 arch/arm64/include/asm/mte_tag_storage.h |  36 ++
 arch/arm64/include/asm/page.h            |   5 +-
 arch/arm64/include/asm/pgtable-prot.h    |   2 +
 arch/arm64/include/asm/pgtable.h         |  33 +-
 arch/arm64/kernel/Makefile               |   1 +
 arch/arm64/kernel/elfcore.c              |  14 +-
 arch/arm64/kernel/hibernate.c            |  46 +-
 arch/arm64/kernel/mte.c                  |  31 +-
 arch/arm64/kernel/mte_tag_storage.c      | 667 +++++++++++++++++++++++
 arch/arm64/kernel/setup.c                |   7 +
 arch/arm64/kvm/arm.c                     |   6 +-
 arch/arm64/lib/mte.S                     |  30 +-
 arch/arm64/mm/copypage.c                 |  26 +
 arch/arm64/mm/fault.c                    |  35 +-
 arch/arm64/mm/mteswap.c                  | 113 +++-
 fs/proc/meminfo.c                        |   8 +
 fs/proc/page.c                           |   1 +
 include/asm-generic/Kbuild               |   1 +
 include/asm-generic/memory_metadata.h    |  50 ++
 include/linux/gfp.h                      |  10 +
 include/linux/gfp_types.h                |  14 +-
 include/linux/huge_mm.h                  |   6 +
 include/linux/kernel-page-flags.h        |   1 +
 include/linux/migrate_mode.h             |   1 +
 include/linux/mm.h                       |  12 +-
 include/linux/mmzone.h                   |  26 +-
 include/linux/page-flags.h               |   1 +
 include/linux/pgtable.h                  |  19 +
 include/linux/sched.h                    |   2 +-
 include/linux/sched/mm.h                 |  13 +
 include/linux/vm_event_item.h            |   5 +
 include/linux/vmstat.h                   |   2 +
 include/trace/events/mmflags.h           |   5 +-
 mm/Kconfig                               |   5 +
 mm/compaction.c                          |  52 +-
 mm/huge_memory.c                         | 109 ++++
 mm/internal.h                            |   7 +
 mm/khugepaged.c                          |   7 +
 mm/memory.c                              | 180 +++++-
 mm/mempolicy.c                           |   7 +
 mm/migrate.c                             |   6 +
 mm/mm_init.c                             |  23 +-
 mm/mprotect.c                            |  46 ++
 mm/page_alloc.c                          | 136 ++++-
 mm/page_isolation.c                      |  19 +-
 mm/page_owner.c                          |   3 +-
 mm/shmem.c                               |  14 +-
 mm/show_mem.c                            |   4 +
 mm/swapfile.c                            |   4 +
 mm/vmscan.c                              |   3 +
 mm/vmstat.c                              |  13 +-
 56 files changed, 1834 insertions(+), 161 deletions(-)
 create mode 100644 arch/arm64/include/asm/memory_metadata.h
 create mode 100644 arch/arm64/include/asm/mte_tag_storage.h
 create mode 100644 arch/arm64/kernel/mte_tag_storage.c
 create mode 100644 include/asm-generic/memory_metadata.h

-- 
2.41.0

