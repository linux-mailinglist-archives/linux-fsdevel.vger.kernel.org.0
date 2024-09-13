Return-Path: <linux-fsdevel+bounces-29288-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B329A977B75
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 10:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 762A028580E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 08:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E111D6C76;
	Fri, 13 Sep 2024 08:44:48 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501751BF324;
	Fri, 13 Sep 2024 08:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726217088; cv=none; b=Si0x/cOAQ/i4tehhZErCEuHs0LFQG+tz6YxQcv05EBIepHTWGZ8xTxIrxLZ4Yxu1sJf7x1t4lpRXt1iD3362c4wofhYECvFLz16AG31eWBbV9RU9okdE2bkS5BOIn0UuEk99SwYIDGjxSCotcWMSXLTMRkJlyQ/XD4MxlFY+r6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726217088; c=relaxed/simple;
	bh=QFa203OC2WhTCdihVHC5Wc82zSwZEYBkVei0/jDI/m0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=av1Pvi7fUyLgf9pW4MaU/lG+qgBcm0tCodPZQ/AE5oKPgMzbAx8HV0MMteQbWdPW0SI1Scmj7WsSdkaEV5Ys6INMlIwFz6ilGVa21TjlPZifY9AuSGT9hXIGxbt/AKuC+WDOYka2LrhiYzhU5W9iuc48DolUnrJE1lEh8KtBNTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B45C813D5;
	Fri, 13 Sep 2024 01:45:13 -0700 (PDT)
Received: from a077893.blr.arm.com (a077893.blr.arm.com [10.162.16.84])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7F3B23F73B;
	Fri, 13 Sep 2024 01:44:40 -0700 (PDT)
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
Subject: [PATCH 0/7] mm: Use pxdp_get() for accessing page table entries
Date: Fri, 13 Sep 2024 14:14:26 +0530
Message-Id: <20240913084433.1016256-1-anshuman.khandual@arm.com>
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

Anshuman Khandual (7):
  m68k/mm: Change pmd_val()
  x86/mm: Drop page table entry address output from pxd_ERROR()
  mm: Use ptep_get() for accessing PTE entries
  mm: Use pmdp_get() for accessing PMD entries
  mm: Use pudp_get() for accessing PUD entries
  mm: Use p4dp_get() for accessing P4D entries
  mm: Use pgdp_get() for accessing PGD entries

 arch/m68k/include/asm/page.h          |  2 +-
 arch/x86/include/asm/pgtable-3level.h | 12 ++---
 arch/x86/include/asm/pgtable_64.h     | 20 +++----
 drivers/misc/sgi-gru/grufault.c       | 10 ++--
 fs/proc/task_mmu.c                    | 26 ++++-----
 fs/userfaultfd.c                      |  6 +--
 include/linux/huge_mm.h               |  5 +-
 include/linux/mm.h                    |  6 +--
 include/linux/pgtable.h               | 38 +++++++-------
 kernel/events/core.c                  |  6 +--
 mm/gup.c                              | 40 +++++++-------
 mm/hmm.c                              |  2 +-
 mm/huge_memory.c                      | 76 +++++++++++++--------------
 mm/hugetlb.c                          | 10 ++--
 mm/hugetlb_vmemmap.c                  |  4 +-
 mm/kasan/init.c                       | 38 +++++++-------
 mm/kasan/shadow.c                     | 12 ++---
 mm/khugepaged.c                       |  4 +-
 mm/madvise.c                          |  6 +--
 mm/mapping_dirty_helpers.c            |  2 +-
 mm/memory-failure.c                   | 14 ++---
 mm/memory.c                           | 59 +++++++++++----------
 mm/mempolicy.c                        |  4 +-
 mm/migrate.c                          |  4 +-
 mm/migrate_device.c                   | 10 ++--
 mm/mlock.c                            |  6 +--
 mm/mprotect.c                         |  2 +-
 mm/mremap.c                           |  4 +-
 mm/page_table_check.c                 |  4 +-
 mm/page_vma_mapped.c                  |  6 +--
 mm/pagewalk.c                         | 10 ++--
 mm/percpu.c                           |  8 +--
 mm/pgalloc-track.h                    |  6 +--
 mm/pgtable-generic.c                  | 24 ++++-----
 mm/ptdump.c                           |  8 +--
 mm/rmap.c                             |  8 +--
 mm/sparse-vmemmap.c                   | 10 ++--
 mm/vmalloc.c                          | 46 ++++++++--------
 mm/vmscan.c                           |  6 +--
 39 files changed, 283 insertions(+), 281 deletions(-)

-- 
2.25.1


