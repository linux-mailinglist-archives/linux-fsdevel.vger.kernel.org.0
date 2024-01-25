Return-Path: <linux-fsdevel+bounces-8943-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1B283C84E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 17:43:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C6992900B7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 16:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F8B130E26;
	Thu, 25 Jan 2024 16:42:51 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C255912BF0F;
	Thu, 25 Jan 2024 16:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706200970; cv=none; b=IYnZKtb7IbMeBglL018JoAp9z0N3o4v8ey829/IJ1hjL8euN7mpfmjrl95itdHHrS6u6YsHdVZJL24bpT1l5f74pwaJbEfJtHleJohAJ7R+tpfobVxd3fU60XnH0T43pCsaU/gOffxJpw2iv44qXcMly54/XN0NhKExWtJAhX7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706200970; c=relaxed/simple;
	bh=iNa8RgdlIg8Q/rH0n5PZHqPyVBz327tXGkz9nf7LGBc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Zgs4iXOySr7X0MW2VZjhYKUyJ+fSU/3aAcc8FQErY8mb67C4eo3esuwWlVsvxvqixAx+8XYXz9+noAdKcKEwLEThz8UcZ3woJ9nuS38SDg5+XseaLW02oESA6/FLKAnSac9dLzWjl4UpAkkxBsQKrZl44ArWfdf0KiKWMFbyOR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7D0B81FB;
	Thu, 25 Jan 2024 08:43:31 -0800 (PST)
Received: from e121798.cable.virginm.net (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 675833F5A1;
	Thu, 25 Jan 2024 08:42:41 -0800 (PST)
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
Subject: [PATCH RFC v3 00/35] Add support for arm64 MTE dynamic tag storage reuse
Date: Thu, 25 Jan 2024 16:42:21 +0000
Message-Id: <20240125164256.4147-1-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The series is based on v6.8-rc1 and can be cloned with:

$ git clone https://gitlab.arm.com/linux-arm/linux-ae.git \
	-b arm-mte-dynamic-carveout-rfc-v3


Changelog
=========

The changes from the previous version [1] are extensive, so I'll list them
first. Only the major changes are below, individual patches will have their
own changelog.

I would like to point out that patch #31 ("khugepaged: arm64: Don't
collapse MTE enabled VMAs") might be controversial. Please have a look.

Changes since rfc v2 [1]:

- Patches #5 ("mm: cma: Don't append newline when generating CMA area
name") and #16 ("KVM: arm64: Don't deny VM_PFNMAP VMAs when kvm_has_mte()")
are new and they are fixes. I think they can be merged independently of the
rest of the series.

- Tag storage now uses the CMA API to allocate and free tag storage pages
(David Hildenbrand).

- Tag storage is now described as subnode of 'reserved-memory' (Rob
Herring).

- KVM now has support for dynamic tag storage reuse, added in patches #32
("KVM: arm64: mte: Reserve tag storage for VMs with MTE") and #33 ("KVM:
arm64: mte: Introduce VM_MTE_KVM VMA flag").

- Reserving tag storage when a tagged page is allocated is now a best
effort approach instead of being mandatory. If tag storage cannot be
reserved, the page is marked as protnone and tag storage is reserved when
the fault is taken on the next userspace access to the address.

- ptrace support for pages without tag storage has been added, implemented
in patch #30 ("arm64: mte: ptrace: Handle pages with missing tag storage").

- The following patches have been dropped: #4 (" mm: migrate/mempolicy: Add hook
to modify migration target gfp"), #5 ("mm: page_alloc: Add an arch hook to allow
prep_new_page() to fail") because reserving tag storage is now best effort,
and to make the series shorter, in the case of patch #4.

- Also dropped patch #13 ("arm64: mte: Make tag storage depend on
ARCH_KEEP_MEMBLOCK") and added a BUILD_BUG_ON() instead (David
Hildenbrand).

- Dropped patch #15 ("arm64: mte: Check that tag storage blocks are in the
same zone") because it's not needed anymore,
cma_init_reserved_areas->cma_activate_area() already does that (David
Hildenbrand).

- Moved patches #1 ("arm64: mte: Rework naming for tag manipulation functions")
and #2 ("arm64: mte: Rename __GFP_ZEROTAGS to __GFP_TAGGED") after the changes
to the common code and before tag storage is discovered.

- Patch #12 ("arm64: mte: Add tag storage pages to the MIGRATE_CMA
migratetype") was replaced with patch #20 ("arm64: mte: Add tag storage
memory to CMA") (David Hildenbrand).

- Split patch #19 ("mm: mprotect: Introduce PAGE_FAULT_ON_ACCESS for
mprotect(PROT_MTE)") into an arch independent part (patch #13, "mm: memory:
Introduce fault-on-access mechanism for pages") and into an arm64 patch (patch
#26, "arm64: mte: Use fault-on-access to reserve missing tag storage"). The
arm64 code is much smaller because of this (David Hildenbrand).

[1] https://lore.kernel.org/linux-arm-kernel/20231119165721.9849-1-alexandru.elisei@arm.com/


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

Not all memory used by applications is tagged (mmap(PROT_MTE)).  For
example, some large allocations may not use PROT_MTE at all or only for the
first and last page since initialising the tags takes time. And executable
memory is never tagged. The side-effect is that of thie 3% of DRAM, only
part of it, say 1%, is effectively used.

The series aims to take that unused tag storage and release it to the page
allocator for normal data usage.

The first complication is that a PROT_MTE page allocation at address X will
need to reserve the tag storage page at location Y (and migrate any data in
that page if it is in use).

To make things more complicated, pages in the tag storage/carve-out range
cannot use PROT_MTE themselves on current hardware, so this adds the second
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
MIGRATE_CMA. The arm64 uses the newly added function cma_alloc_range() to
reserve tag storage when the associated page is allocated as tagged.

There is a limitation to this approach: all MIGRATE_CMA memory cannot be
used for tagged allocations, even if not all of it is tag storage.

2. mprotect(PROT_MTE) is implemented by adding a fault-on-access mechanism
for existing pages. When a page is next accessed, a fault is taken and the
corresponding tag storage is reserved.

3. When the code tries to copy tags to a page (when swapping in a newly
allocated page, or during migration/THP collapse) which doesn't have the
tag storage reserved, the tags are copied to an xarray and restored when
tag storage is reserved for the destination page.

4. KVM allows VMAs without MTE enabled to represent the memory of a virtual
machine with MTE enabled. Even though the host treats the pages that
represent guest memory as untagged, they have tags associated with them,
which are used by the guest. To make dynamic tag storage work with KVM, two
changes were necessary: try to reserve tag storage when a guest accesses an
address the first time, and if not possible, migrate the page to replace it
with a page with tag storage reserved; and a new VMA flag, VM_MTE_KVM, was
added so the page allocator will not use tag storage pages (which cannot be
tagged) for VM memory. The second change is a performance optimization.


Testing
=======

To enable MTE dynamic tag storage:

- CONFIG_ARM64_MTE_TAG_STORAGE=y
- system_supports_mte() returns true
- kasan_hw_tags_enabled() returns false
- correct DTB node. For an example that works with FVP, have a look at
patch #35 ("HACK! Add fake tag storage to fvp-base-revc.dts")

Check dmesg for the message "MTE tag storage region management enabled".

Alexandru Elisei (35):
  mm: page_alloc: Add gfp_flags parameter to arch_alloc_page()
  mm: page_alloc: Add an arch hook early in free_pages_prepare()
  mm: page_alloc: Add an arch hook to filter MIGRATE_CMA allocations
  mm: page_alloc: Partially revert "mm: page_alloc: remove stale CMA
    guard code"
  mm: cma: Don't append newline when generating CMA area name
  mm: cma: Make CMA_ALLOC_SUCCESS/FAIL count the number of pages
  mm: cma: Add CMA_RELEASE_{SUCCESS,FAIL} events
  mm: cma: Introduce cma_alloc_range()
  mm: cma: Introduce cma_remove_mem()
  mm: cma: Fast track allocating memory when the pages are free
  mm: Allow an arch to hook into folio allocation when VMA is known
  mm: Call arch_swap_prepare_to_restore() before arch_swap_restore()
  mm: memory: Introduce fault-on-access mechanism for pages
  of: fdt: Return the region size in of_flat_dt_translate_address()
  of: fdt: Add of_flat_read_u32()
  KVM: arm64: Don't deny VM_PFNMAP VMAs when kvm_has_mte()
  arm64: mte: Rework naming for tag manipulation functions
  arm64: mte: Rename __GFP_ZEROTAGS to __GFP_TAGGED
  arm64: mte: Discover tag storage memory
  arm64: mte: Add tag storage memory to CMA
  arm64: mte: Disable dynamic tag storage management if HW KASAN is
    enabled
  arm64: mte: Enable tag storage if CMA areas have been activated
  arm64: mte: Try to reserve tag storage in arch_alloc_page()
  arm64: mte: Perform CMOs for tag blocks
  arm64: mte: Reserve tag block for the zero page
  arm64: mte: Use fault-on-access to reserve missing tag storage
  arm64: mte: Handle tag storage pages mapped in an MTE VMA
  arm64: mte: swap: Handle tag restoring when missing tag storage
  arm64: mte: copypage: Handle tag restoring when missing tag storage
  arm64: mte: ptrace: Handle pages with missing tag storage
  khugepaged: arm64: Don't collapse MTE enabled VMAs
  KVM: arm64: mte: Reserve tag storage for virtual machines with MTE
  KVM: arm64: mte: Introduce VM_MTE_KVM VMA flag
  arm64: mte: Enable dynamic tag storage management
  HACK! Add fake tag storage to fvp-base-revc.dts

 .../reserved-memory/arm,mte-tag-storage.yaml  |  78 +++
 arch/arm64/Kconfig                            |  14 +
 arch/arm64/boot/dts/arm/fvp-base-revc.dts     |  42 +-
 arch/arm64/include/asm/assembler.h            |  10 +
 arch/arm64/include/asm/mte-def.h              |  16 +-
 arch/arm64/include/asm/mte.h                  |  43 +-
 arch/arm64/include/asm/mte_tag_storage.h      |  83 +++
 arch/arm64/include/asm/page.h                 |  10 +-
 arch/arm64/include/asm/pgtable-prot.h         |   2 +
 arch/arm64/include/asm/pgtable.h              |  93 ++-
 arch/arm64/kernel/Makefile                    |   1 +
 arch/arm64/kernel/elfcore.c                   |  14 +-
 arch/arm64/kernel/hibernate.c                 |  46 +-
 arch/arm64/kernel/mte.c                       |  37 +-
 arch/arm64/kernel/mte_tag_storage.c           | 643 ++++++++++++++++++
 arch/arm64/kvm/mmu.c                          | 128 +++-
 arch/arm64/lib/mte.S                          |  34 +-
 arch/arm64/mm/copypage.c                      |  56 ++
 arch/arm64/mm/fault.c                         | 133 +++-
 arch/arm64/mm/init.c                          |   3 +
 arch/arm64/mm/mteswap.c                       | 160 ++++-
 arch/s390/include/asm/page.h                  |   2 +-
 arch/s390/mm/page-states.c                    |   2 +-
 arch/sh/kernel/cpu/sh2/probe.c                |   2 +-
 drivers/of/fdt.c                              |  21 +
 drivers/of/fdt_address.c                      |  12 +-
 drivers/tty/serial/earlycon.c                 |   2 +-
 fs/proc/page.c                                |   1 +
 include/linux/cma.h                           |   3 +
 include/linux/gfp.h                           |   2 +-
 include/linux/gfp_types.h                     |   6 +-
 include/linux/huge_mm.h                       |   4 +-
 include/linux/kernel-page-flags.h             |   1 +
 include/linux/khugepaged.h                    |   5 +
 include/linux/memcontrol.h                    |   2 +
 include/linux/migrate.h                       |   8 +-
 include/linux/migrate_mode.h                  |   1 +
 include/linux/mm.h                            |   2 +
 include/linux/of_fdt.h                        |   4 +-
 include/linux/page-flags.h                    |  16 +-
 include/linux/pgtable.h                       |  72 +-
 include/linux/vm_event_item.h                 |   2 +
 include/trace/events/cma.h                    |  59 ++
 include/trace/events/mmflags.h                |   5 +-
 mm/Kconfig                                    |   8 +
 mm/cma.c                                      | 166 ++++-
 mm/huge_memory.c                              |  37 +-
 mm/internal.h                                 |   6 -
 mm/khugepaged.c                               |   4 +
 mm/memory-failure.c                           |   8 +-
 mm/memory.c                                   |  55 +-
 mm/mempolicy.c                                |   1 +
 mm/page_alloc.c                               |  46 +-
 mm/shmem.c                                    |  14 +-
 mm/swapfile.c                                 |   5 +
 mm/vmstat.c                                   |   2 +
 56 files changed, 2016 insertions(+), 216 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/reserved-memory/arm,mte-tag-storage.yaml
 create mode 100644 arch/arm64/include/asm/mte_tag_storage.h
 create mode 100644 arch/arm64/kernel/mte_tag_storage.c


base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
-- 
2.43.0


