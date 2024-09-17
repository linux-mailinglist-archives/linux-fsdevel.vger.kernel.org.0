Return-Path: <linux-fsdevel+bounces-29551-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 361AB97AC15
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2024 09:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 694E31C21634
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2024 07:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 756CE14B086;
	Tue, 17 Sep 2024 07:31:31 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B3AD10F4;
	Tue, 17 Sep 2024 07:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726558291; cv=none; b=c3NI6F2B9ATcyVYIfeOW41rC/XO+1l0Xd+x++7sIk+stKvrBrEvNcT6hnTdeIfVtgaDf4nV9TaS2lcWXaEb8i4Z7xqguSQ4oG4Gcj8jN6dyOpUZ11hL7BX0CQYTSfvali7m7R52sHmjLL0nM/96vRPl4mcMsvlj1EOVsKrRAW1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726558291; c=relaxed/simple;
	bh=YtVtHuoqABW83akAZdZj/UkU/MTxSwj/EJVNpnVEej4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uyPxa/9uVWVsS7L+TiSE1Ndn/cPGKGu1zDJHP8Zzpwujlc4bECWE+jAMP8BzSJDN6nAybuW/zICzRzdN3BlaLVT5QNO4GPMDbcL15HG9+aDchBxT2zaIxPM5tJhWdjgoKv2NfrOr+BgrkBWpQ12CikgIoIOtdsg+I5x+xNyDCZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AF4CF1063;
	Tue, 17 Sep 2024 00:31:57 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.61.158])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 904823F64C;
	Tue, 17 Sep 2024 00:31:23 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-mm@kvack.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	x86@kernel.org,
	linux-m68k@lists.linux-m68k.org,
	linux-fsdevel@vger.kernel.org,
	kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH V2 0/7] mm: Use pxdp_get() for accessing page table entries
Date: Tue, 17 Sep 2024 13:01:10 +0530
Message-Id: <20240917073117.1531207-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series converts all generic page table entries direct derefences via
pxdp_get() based helpers extending the changes brought in via the commit
c33c794828f2 ("mm: ptep_get() conversion"). First it does some platform
specific changes for m68k and x86 architecture.

This series has been build tested on multiple architecture such as x86,
arm64, powerpc, powerpc64le, riscv, and m68k etc.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: "Mike Rapoport (IBM)" <rppt@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: x86@kernel.org
Cc: linux-m68k@lists.linux-m68k.org
Cc: linux-mm@kvack.org
Cc: linux-fsdevel@vger.kernel.org
Cc: kasan-dev@googlegroups.com
Cc: linux-kernel@vger.kernel.org
Cc: linux-perf-users@vger.kernel.org
Cc: kasan-dev@googlegroups.com

Changes in V2:

- Separated out PUD changes from P4D changes
- Updated the commit message for x86 patch per Dave
- Implemented local variable page table value caching when applicable
- Updated all commit messages regarding local variable caching

Changes in V1:

https://lore.kernel.org/all/20240913084433.1016256-1-anshuman.khandual@arm.com/

Anshuman Khandual (7):
  m68k/mm: Change pmd_val()
  x86/mm: Drop page table entry address output from pxd_ERROR()
  mm: Use ptep_get() for accessing PTE entries
  mm: Use pmdp_get() for accessing PMD entries
  mm: Use pudp_get() for accessing PUD entries
  mm: Use p4dp_get() for accessing P4D entries
  mm: Use pgdp_get() for accessing PGD entries

 arch/m68k/include/asm/page.h          |  2 +-
 arch/x86/include/asm/pgtable-3level.h | 12 ++--
 arch/x86/include/asm/pgtable_64.h     | 20 +++---
 drivers/misc/sgi-gru/grufault.c       | 13 ++--
 fs/proc/task_mmu.c                    | 28 +++++----
 fs/userfaultfd.c                      |  6 +-
 include/linux/huge_mm.h               |  6 +-
 include/linux/mm.h                    |  6 +-
 include/linux/pgtable.h               | 49 +++++++++------
 kernel/events/core.c                  |  6 +-
 mm/gup.c                              | 43 ++++++-------
 mm/hmm.c                              |  2 +-
 mm/huge_memory.c                      | 90 +++++++++++++++------------
 mm/hugetlb.c                          | 10 +--
 mm/hugetlb_vmemmap.c                  |  4 +-
 mm/kasan/init.c                       | 38 +++++------
 mm/kasan/shadow.c                     | 12 ++--
 mm/khugepaged.c                       |  4 +-
 mm/madvise.c                          |  6 +-
 mm/mapping_dirty_helpers.c            |  2 +-
 mm/memory-failure.c                   | 14 ++---
 mm/memory.c                           | 71 +++++++++++----------
 mm/mempolicy.c                        |  4 +-
 mm/migrate.c                          |  4 +-
 mm/migrate_device.c                   | 10 +--
 mm/mlock.c                            |  6 +-
 mm/mprotect.c                         |  2 +-
 mm/mremap.c                           |  4 +-
 mm/page_table_check.c                 |  4 +-
 mm/page_vma_mapped.c                  |  6 +-
 mm/pagewalk.c                         | 10 +--
 mm/percpu.c                           |  8 +--
 mm/pgalloc-track.h                    |  6 +-
 mm/pgtable-generic.c                  | 30 ++++-----
 mm/ptdump.c                           |  8 +--
 mm/rmap.c                             | 10 +--
 mm/sparse-vmemmap.c                   | 10 +--
 mm/vmalloc.c                          | 58 +++++++++--------
 mm/vmscan.c                           |  6 +-
 39 files changed, 333 insertions(+), 297 deletions(-)

-- 
2.25.1


