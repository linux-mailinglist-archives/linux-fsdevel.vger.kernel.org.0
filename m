Return-Path: <linux-fsdevel+bounces-3140-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 376027F07B0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Nov 2023 17:57:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 825A4B20A19
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Nov 2023 16:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0699D14AB9;
	Sun, 19 Nov 2023 16:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0E997C2;
	Sun, 19 Nov 2023 08:57:40 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C605EDA7;
	Sun, 19 Nov 2023 08:58:25 -0800 (PST)
Received: from e121798.cable.virginm.net (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7C6E83F6C4;
	Sun, 19 Nov 2023 08:57:34 -0800 (PST)
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	oliver.upton@linux.dev,
	maz@kernel.org,
	james.morse@arm.com,
	suzuki.poulose@arm.com,
	yuzenghui@huawei.com,
	arnd@arndb.de,
	akpm@linux-foundation.org,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	bristot@redhat.com,
	vschneid@redhat.com,
	mhiramat@kernel.org,
	rppt@kernel.org,
	hughd@google.com
Cc: pcc@google.com,
	steven.price@arm.com,
	anshuman.khandual@arm.com,
	vincenzo.frascino@arm.com,
	david@redhat.com,
	eugenis@google.com,
	kcc@google.com,
	hyesoo.yu@samsung.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH RFC v2 00/27] Add support for arm64 MTE dynamic tag storage reuse
Date: Sun, 19 Nov 2023 16:56:54 +0000
Message-Id: <20231119165721.9849-1-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The series is based on v6.7-rc1 and can be cloned with:

$ git clone https://gitlab.arm.com/linux-arm/linux-ae.git \
	-b arm-mte-dynamic-carveout-rfc-v2

Introduction
============

Memory Tagging Extension (MTE) is implemented currently to have a static
carve-out of the DRAM to store the allocation tags (a.k.a. memory colour).
This is what we call the tag storage. Each 16 bytes have 4 bits of tags, so
this means 1/32 of the DRAM, roughly 3% used for the tag storage.  This is
done transparently by the hardware/interconnect (with firmware setup) and
normally hidden from the OS. So a checked memory access to location X
generates a tag fetch from location Y in the carve-out and this tag is
compared with the bits 59:56 in the pointer. The correspondence from X to Y
is linear (subject to a minimum block size to deal with some address
interleaving). The software doesn't need to know about this correspondence
as we have specific instructions like STG/LDG to location X that lead to a
tag store/load to Y.

Now, not all memory used by applications is tagged (mmap(PROT_MTE)).  For
example, some large allocations may not use PROT_MTE at all or only for the
first and last page since initialising the tags takes time. The side-effect
is that of that 3% of DRAM, only part of it, say 1%, is effectively used.

The series aims to take that unused tag storage and release it to the page
allocator for normal data usage.

The first complication is that a PROT_MTE page allocation at address X will
need to reserve the tag storage page at location Y (and migrate any data in
that page if it is in use).

To make things worse, pages in the tag storage/carve-out range cannot use
PROT_MTE themselves on current hardware, so this adds the second
complication - a heterogeneous memory layout. The kernel needs to know
where to allocate a PROT_MTE page from or migrate a current page if it
becomes PROT_MTE (mprotect()) and the range it is in does not support
tagging.

Some other complications are arm64-specific like cache coherency between
tags and data accesses. There is a draft architecture spec which will be
released soon, detailing how the hardware behaves.

All of this will be entirely transparent to userspace. As with the current
kernel (without this dynamic tag storage), a user only needs to ask for
PROT_MTE mappings to get tagged pages.

Implementation
==============

MTE tag storage reuse is accomplished with the following changes to the
Linux kernel:

1. The tag storage memory is exposed to the memory allocator as
MIGRATE_CMA. The arm64 code manages this memory directly instead of using
cma_declare_contiguous/cma_alloc for performance reasons.

There is a limitation to this approach: MIGRATE_CMA cannot be used for
tagged allocations, even if not all MIGRATE_CMA memory is tag storage.

2. mprotect(PROT_MTE) is implemented by adding a fault-on-access mechanism
for existing pages. When a page is next accessed, a fault is taken and the
corresponding tag storage is reserved.

3. When the code tries to copy tags to a page (when swapping in a newly
allocated page, or during migration/THP collapse) which doesn't have the
tag storage reserved, the tags are copied to an xarray and restored when
tag storage is reserved for the destination page.

KVM support has not been implemented yet, that because a non-MTE enabled
VMA can back the memory of an MTE-enabled VM. It will be added after there
is a consensus on the right approach on the memory management support.

Overview of the patches
=======================

For people not interested in the arm64 details, you probably want to start
with patches 1-10, which mostly deal with adding the necessary hooks to the
memory management code, and patches 19 and 20 which add the page
fault-on-access mechanism for regular pages, respectively huge pages. Patch
21 is rather invasive, it moves the definition of struct
migration_target_control out of mm/internal.h to migrate.h, and the arm64
code also uses isolate_lru_page() and putback_movable_pages() when
migrating a tag storage page out of a PROT_MTE VMA. And finally patch 26 is
an optimization for a performance regression that has been reported with
Chrome and it introduces CONFIG_WANTS_TAKE_PAGE_OFF_BUDDY to allow arm64 to
use take_page_off_buddy() to fast track reserving tag storage when the page
is free.

The rest of the patches are mostly arm64 specific.

Patches 11-18 support for detecting the tag storage region and reserving
tag storage when a tagged page is allocated.

Patches 19-21 add the page fault-on-access on mechanism and use it to
reserve tag storage when needed.

Patches 22 and 23 handle saving tags temporarily to an xarray if the page
doesn't have tag storage, and copying the tags over to the tagged page when
tag storage is reserved.

Changelog
=========

Changes since RFC v1 [1]:

* The entire series has been reworked to remove MIGRATE_METADATA and put tag
  storage pages on the MIGRATE_CMA freelists.

* Changed how tags are saved and restored when copying them from one page to
  another if the destination page doesn't have tag storage - now the tags are
  restored when tag storage is reserved for the destination page instead of
  restoring them in set_pte_at() -> mte_sync_tags().

[1] https://lore.kernel.org/lkml/20230823131350.114942-1-alexandru.elisei@arm.com/

Testing
=======

To enable MTE dynamic tag storage:

- CONFIG_ARM64_MTE_TAG_STORAGE=y
- system_supports_mte() returns true
- kasan_hw_tags_enabled() returns false
- correct DTB node (for the specification, see commit "arm64: mte: Reserve tag
  storage memory")

Check dmesg for the message "MTE tag storage region management enabled".

I've tested the series using FVP with MTE enabled, but without support for
dynamic tag storage reuse. To simulate it, I've added two fake tag storage
regions in the DTB by splitting the upper 2GB memory region into 3: one region
for normal RAM, followed by the tag storage for the lower 2GB of memory, then
the tag storage for the normal RAM region. Like below:

diff --git a/arch/arm64/boot/dts/arm/fvp-base-revc.dts b/arch/arm64/boot/dts/arm/fvp-base-revc.dts
index 60472d65a355..8c719825a9b3 100644
--- a/arch/arm64/boot/dts/arm/fvp-base-revc.dts
+++ b/arch/arm64/boot/dts/arm/fvp-base-revc.dts
@@ -165,12 +165,30 @@ C1_L2: l2-cache1 {
                };
        };
 
-       memory@80000000 {
+       memory0: memory@80000000 {
                device_type = "memory";
-               reg = <0x00000000 0x80000000 0 0x80000000>,
-                     <0x00000008 0x80000000 0 0x80000000>;
+               reg = <0x00000000 0x80000000 0 0x80000000>;
        };
 
+       memory1: memory@880000000 {
+               device_type = "memory";
+               reg = <0x00000008 0x80000000 0 0x78000000>;
+       };
+
+       tags0: tag-storage@8f8000000 {
+                compatible = "arm,mte-tag-storage";
+                reg = <0x00000008 0xf8000000 0 0x4000000>;
+                block-size = <0x1000>;
+                memory = <&memory0>;
+        };
+
+        tags1: tag-storage@8fc000000 {
+                compatible = "arm,mte-tag-storage";
+                reg = <0x00000008 0xfc000000 0 0x3c00000>;
+                block-size = <0x1000>;
+                memory = <&memory1>;
+        };
+
        reserved-memory {
                #address-cells = <2>;
                #size-cells = <2>;



Alexandru Elisei (27):
  arm64: mte: Rework naming for tag manipulation functions
  arm64: mte: Rename __GFP_ZEROTAGS to __GFP_TAGGED
  mm: cma: Make CMA_ALLOC_SUCCESS/FAIL count the number of pages
  mm: migrate/mempolicy: Add hook to modify migration target gfp
  mm: page_alloc: Add an arch hook to allow prep_new_page() to fail
  mm: page_alloc: Allow an arch to hook early into free_pages_prepare()
  mm: page_alloc: Add an arch hook to filter MIGRATE_CMA allocations
  mm: page_alloc: Partially revert "mm: page_alloc: remove stale CMA
    guard code"
  mm: Allow an arch to hook into folio allocation when VMA is known
  mm: Call arch_swap_prepare_to_restore() before arch_swap_restore()
  arm64: mte: Reserve tag storage memory
  arm64: mte: Add tag storage pages to the MIGRATE_CMA migratetype
  arm64: mte: Make tag storage depend on ARCH_KEEP_MEMBLOCK
  arm64: mte: Disable dynamic tag storage management if HW KASAN is
    enabled
  arm64: mte: Check that tag storage blocks are in the same zone
  arm64: mte: Manage tag storage on page allocation
  arm64: mte: Perform CMOs for tag blocks on tagged page allocation/free
  arm64: mte: Reserve tag block for the zero page
  mm: mprotect: Introduce PAGE_FAULT_ON_ACCESS for mprotect(PROT_MTE)
  mm: hugepage: Handle huge page fault on access
  mm: arm64: Handle tag storage pages mapped before mprotect(PROT_MTE)
  arm64: mte: swap: Handle tag restoring when missing tag storage
  arm64: mte: copypage: Handle tag restoring when missing tag storage
  arm64: mte: Handle fatal signal in reserve_tag_storage()
  KVM: arm64: Disable MTE if tag storage is enabled
  arm64: mte: Fast track reserving tag storage when the block is free
  arm64: mte: Enable dynamic tag storage reuse

 arch/arm64/Kconfig                       |  16 +
 arch/arm64/include/asm/assembler.h       |  10 +
 arch/arm64/include/asm/mte-def.h         |  16 +-
 arch/arm64/include/asm/mte.h             |  43 +-
 arch/arm64/include/asm/mte_tag_storage.h |  75 +++
 arch/arm64/include/asm/page.h            |   5 +-
 arch/arm64/include/asm/pgtable-prot.h    |   2 +
 arch/arm64/include/asm/pgtable.h         |  96 +++-
 arch/arm64/kernel/Makefile               |   1 +
 arch/arm64/kernel/elfcore.c              |  14 +-
 arch/arm64/kernel/hibernate.c            |  46 +-
 arch/arm64/kernel/mte.c                  |  12 +-
 arch/arm64/kernel/mte_tag_storage.c      | 686 +++++++++++++++++++++++
 arch/arm64/kernel/setup.c                |   7 +
 arch/arm64/kvm/arm.c                     |   6 +-
 arch/arm64/lib/mte.S                     |  34 +-
 arch/arm64/mm/copypage.c                 |  59 ++
 arch/arm64/mm/fault.c                    | 261 ++++++++-
 arch/arm64/mm/mteswap.c                  | 162 +++++-
 fs/proc/page.c                           |   1 +
 include/linux/gfp_types.h                |  14 +-
 include/linux/huge_mm.h                  |   2 +
 include/linux/kernel-page-flags.h        |   1 +
 include/linux/migrate.h                  |  12 +-
 include/linux/migrate_mode.h             |   1 +
 include/linux/mmzone.h                   |   5 +
 include/linux/page-flags.h               |  16 +-
 include/linux/pgtable.h                  |  54 ++
 include/trace/events/mmflags.h           |   5 +-
 mm/Kconfig                               |   7 +
 mm/cma.c                                 |   4 +-
 mm/huge_memory.c                         |   5 +-
 mm/internal.h                            |   9 -
 mm/memory-failure.c                      |   8 +-
 mm/memory.c                              |  10 +
 mm/mempolicy.c                           |   3 +
 mm/migrate.c                             |   3 +
 mm/page_alloc.c                          | 118 +++-
 mm/shmem.c                               |  14 +-
 mm/swapfile.c                            |   7 +
 40 files changed, 1668 insertions(+), 182 deletions(-)
 create mode 100644 arch/arm64/include/asm/mte_tag_storage.h
 create mode 100644 arch/arm64/kernel/mte_tag_storage.c


base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
-- 
2.42.1


