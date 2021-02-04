Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EAF630EB33
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Feb 2021 04:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbhBDDye (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Feb 2021 22:54:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231390AbhBDDyb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Feb 2021 22:54:31 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0748C0613ED
        for <linux-fsdevel@vger.kernel.org>; Wed,  3 Feb 2021 19:53:50 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id c132so1214197pga.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Feb 2021 19:53:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RvtFfiPwjzDeb/RnP+aCThFnzEdYy5cwcehg6sHJjrg=;
        b=yVgWTO3JqLX8eR8OOldyNcNd6SOctQV1oJwXkKGa9VNhygJCqK5w8qU7YRziz5m+2S
         i8jFefZqQAdZic1+3EVFRBL07EKKy9AYnokpqVD/eIoFlY8+jWyuIOSyyWEU1wTSpgFS
         p210E7M0oWAtZlHYzqpTsvjxLL7VRNvhodV/AyXD+/VzUPqrC1D23/6LoFSS6P8LQ7ug
         w/p6ajRuaw9clhE01zJ1ebuRppBAvByQjf8XHywgwD9juRlrSZO3BXR/u+cH9OLlCBHX
         8PB1SjZVq6+2EnwIu1b+sGL6VKeRFWp+kJIe6LLV+9hKwljKPs39mRM6bfqvusprRoD1
         mZOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RvtFfiPwjzDeb/RnP+aCThFnzEdYy5cwcehg6sHJjrg=;
        b=gNiE/jwWNYJ349DD9T3BVGPNb6YMk2Jfomu9kXq6pqMIldnOe6exdyVRyztOBMQgL7
         eVIEPMEOXEUX05v/NwpDcvWo8O8WLYq4Pvxm4TEVG1VEicnk8xeXwhsLft9KrLRnMS8M
         c/hvpgm0e5FhznxLBYxu2c2wlegpI/3ocBA9OWRQPeo39jwb0hQKOuNXVk3SY8Ll8wXL
         XsdUa/p6/B8R4/ro299wIZfjzh+q18DVxm18GKxR3154rCKX45yOfS2E3wTry95bukml
         kEcJklkECCRBQsNBD1GG+KyvP1Lj9XOJh4IvkuKTGHkjWEaCMif0OuUGDAC3BFfwHFK7
         8XWg==
X-Gm-Message-State: AOAM530LpTdrLdrEQrmgW1yiBIc/LWduWQseIbPlbxh7bTlUNBlmeaVR
        Pesh2E+QJwlucoAPcLtErJ6HFQ==
X-Google-Smtp-Source: ABdhPJzPnMuOjvRETuK1hXdQA2yB7bTJOBUmAWeNi9/w4tx9OIi71wyxW5fzvI450Vvl3Z9kuk2RWw==
X-Received: by 2002:a05:6a00:2286:b029:1ae:6c7f:31ce with SMTP id f6-20020a056a002286b02901ae6c7f31cemr6123723pfe.6.1612410830005;
        Wed, 03 Feb 2021 19:53:50 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.239])
        by smtp.gmail.com with ESMTPSA id 9sm3747466pfy.110.2021.02.03.19.53.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Feb 2021 19:53:49 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     corbet@lwn.net, mike.kravetz@oracle.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        paulmck@kernel.org, mchehab+huawei@kernel.org,
        pawan.kumar.gupta@linux.intel.com, rdunlap@infradead.org,
        oneukum@suse.com, anshuman.khandual@arm.com, jroedel@suse.de,
        almasrymina@google.com, rientjes@google.com, willy@infradead.org,
        osalvador@suse.de, mhocko@suse.com, song.bao.hua@hisilicon.com,
        david@redhat.com, naoya.horiguchi@nec.com
Cc:     duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v14 0/8] Free some vmemmap pages of HugeTLB page
Date:   Thu,  4 Feb 2021 11:50:35 +0800
Message-Id: <20210204035043.36609-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

This patch series will free some vmemmap pages(struct page structures)
associated with each hugetlbpage when preallocated to save memory.

In order to reduce the difficulty of the first version of code review.
From this version, we disable PMD/huge page mapping of vmemmap if this
feature was enabled. This accutualy eliminate a bunch of the complex code
doing page table manipulation. When this patch series is solid, we cam add
the code of vmemmap page table manipulation in the future.

The struct page structures (page structs) are used to describe a physical
page frame. By default, there is a one-to-one mapping from a page frame to
it's corresponding page struct.

The HugeTLB pages consist of multiple base page size pages and is supported
by many architectures. See hugetlbpage.rst in the Documentation directory
for more details. On the x86 architecture, HugeTLB pages of size 2MB and 1GB
are currently supported. Since the base page size on x86 is 4KB, a 2MB
HugeTLB page consists of 512 base pages and a 1GB HugeTLB page consists of
4096 base pages. For each base page, there is a corresponding page struct.

Within the HugeTLB subsystem, only the first 4 page structs are used to
contain unique information about a HugeTLB page. HUGETLB_CGROUP_MIN_ORDER
provides this upper limit. The only 'useful' information in the remaining
page structs is the compound_head field, and this field is the same for all
tail pages.

By removing redundant page structs for HugeTLB pages, memory can returned to
the buddy allocator for other uses.

When the system boot up, every 2M HugeTLB has 512 struct page structs which
size is 8 pages(sizeof(struct page) * 512 / PAGE_SIZE).

    HugeTLB                  struct pages(8 pages)         page frame(8 pages)
 +-----------+ ---virt_to_page---> +-----------+   mapping to   +-----------+
 |           |                     |     0     | -------------> |     0     |
 |           |                     +-----------+                +-----------+
 |           |                     |     1     | -------------> |     1     |
 |           |                     +-----------+                +-----------+
 |           |                     |     2     | -------------> |     2     |
 |           |                     +-----------+                +-----------+
 |           |                     |     3     | -------------> |     3     |
 |           |                     +-----------+                +-----------+
 |           |                     |     4     | -------------> |     4     |
 |    2MB    |                     +-----------+                +-----------+
 |           |                     |     5     | -------------> |     5     |
 |           |                     +-----------+                +-----------+
 |           |                     |     6     | -------------> |     6     |
 |           |                     +-----------+                +-----------+
 |           |                     |     7     | -------------> |     7     |
 |           |                     +-----------+                +-----------+
 |           |
 |           |
 |           |
 +-----------+

The value of page->compound_head is the same for all tail pages. The first
page of page structs (page 0) associated with the HugeTLB page contains the 4
page structs necessary to describe the HugeTLB. The only use of the remaining
pages of page structs (page 1 to page 7) is to point to page->compound_head.
Therefore, we can remap pages 2 to 7 to page 1. Only 2 pages of page structs
will be used for each HugeTLB page. This will allow us to free the remaining
6 pages to the buddy allocator.

Here is how things look after remapping.

    HugeTLB                  struct pages(8 pages)         page frame(8 pages)
 +-----------+ ---virt_to_page---> +-----------+   mapping to   +-----------+
 |           |                     |     0     | -------------> |     0     |
 |           |                     +-----------+                +-----------+
 |           |                     |     1     | -------------> |     1     |
 |           |                     +-----------+                +-----------+
 |           |                     |     2     | ----------------^ ^ ^ ^ ^ ^
 |           |                     +-----------+                   | | | | |
 |           |                     |     3     | ------------------+ | | | |
 |           |                     +-----------+                     | | | |
 |           |                     |     4     | --------------------+ | | |
 |    2MB    |                     +-----------+                       | | |
 |           |                     |     5     | ----------------------+ | |
 |           |                     +-----------+                         | |
 |           |                     |     6     | ------------------------+ |
 |           |                     +-----------+                           |
 |           |                     |     7     | --------------------------+
 |           |                     +-----------+
 |           |
 |           |
 |           |
 +-----------+

When a HugeTLB is freed to the buddy system, we should allocate 6 pages for
vmemmap pages and restore the previous mapping relationship.

Apart from 2MB HugeTLB page, we also have 1GB HugeTLB page. It is similar
to the 2MB HugeTLB page. We also can use this approach to free the vmemmap
pages.

In this case, for the 1GB HugeTLB page, we can save 4094 pages. This is a
very substantial gain. On our server, run some SPDK/QEMU applications which
will use 1024GB hugetlbpage. With this feature enabled, we can save ~16GB
(1G hugepage)/~12GB (2MB hugepage) memory.

Because there are vmemmap page tables reconstruction on the freeing/allocating
path, it increases some overhead. Here are some overhead analysis.

1) Allocating 10240 2MB hugetlb pages.

   a) With this patch series applied:
   # time echo 10240 > /proc/sys/vm/nr_hugepages

   real     0m0.166s
   user     0m0.000s
   sys      0m0.166s

   # bpftrace -e 'kprobe:alloc_fresh_huge_page { @start[tid] = nsecs; } kretprobe:alloc_fresh_huge_page /@start[tid]/ { @latency = hist(nsecs - @start[tid]); delete(@start[tid]); }'
   Attaching 2 probes...

   @latency:
   [8K, 16K)           8360 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
   [16K, 32K)          1868 |@@@@@@@@@@@                                         |
   [32K, 64K)            10 |                                                    |
   [64K, 128K)            2 |                                                    |

   b) Without this patch series:
   # time echo 10240 > /proc/sys/vm/nr_hugepages

   real     0m0.066s
   user     0m0.000s
   sys      0m0.066s

   # bpftrace -e 'kprobe:alloc_fresh_huge_page { @start[tid] = nsecs; } kretprobe:alloc_fresh_huge_page /@start[tid]/ { @latency = hist(nsecs - @start[tid]); delete(@start[tid]); }'
   Attaching 2 probes...

   @latency:
   [4K, 8K)           10176 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
   [8K, 16K)             62 |                                                    |
   [16K, 32K)             2 |                                                    |

   Summarize: this feature is about ~2x slower than before.

2) Freeing 10240 2MB hugetlb pages.

   a) With this patch series applied:
   # time echo 0 > /proc/sys/vm/nr_hugepages

   real     0m0.004s
   user     0m0.000s
   sys      0m0.002s

   # bpftrace -e 'kprobe:__free_hugepage { @start[tid] = nsecs; } kretprobe:__free_hugepage /@start[tid]/ { @latency = hist(nsecs - @start[tid]); delete(@start[tid]); }'
   Attaching 2 probes...

   @latency:
   [16K, 32K)         10240 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|

   b) Without this patch series:
   # time echo 0 > /proc/sys/vm/nr_hugepages

   real     0m0.077s
   user     0m0.001s
   sys      0m0.075s

   # bpftrace -e 'kprobe:__free_hugepage { @start[tid] = nsecs; } kretprobe:__free_hugepage /@start[tid]/ { @latency = hist(nsecs - @start[tid]); delete(@start[tid]); }'
   Attaching 2 probes...

   @latency:
   [4K, 8K)            9950 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
   [8K, 16K)            287 |@                                                   |
   [16K, 32K)             3 |                                                    |

   Summarize: The overhead of __free_hugepage is about ~2-4x slower than before.
              But according to the allocation test above, I think that here is
	      also ~2x slower than before.

              But why the 'real' time of patched is smaller than before? Because
	      In this patch series, the freeing hugetlb is asynchronous(through
	      kwoker).

Although the overhead has increased, the overhead is not significant. Like Mike
said, "However, remember that the majority of use cases create hugetlb pages at
or shortly after boot time and add them to the pool. So, additional overhead is
at pool creation time. There is no change to 'normal run time' operations of
getting a page from or returning a page to the pool (think page fault/unmap)".

Todo:
  - Free all of the tail vmemmap pages
    Now for the 2MB HugrTLB page, we only free 6 vmemmap pages. we really can
    free 7 vmemmap pages. In this case, we can see 8 of the 512 struct page
    structures has beed set PG_head flag. If we can adjust compound_head()
    slightly and make compound_head() return the real head struct page when
    the parameter is the tail struct page but with PG_head flag set.

    In order to make the code evolution route clearer. This feature can can be
    a separate patch after this patchset is solid.

  - Support for other architectures (e.g. aarch64).
  - Enable PMD/huge page mapping of vmemmap even if this feature was enabled.

Changelog in v13 -> v14:
  - Refuse to free the HugeTLB page when the system is under memory pressure.
  - Use GFP_ATOMIC to allocate vmemmap pages instead of GFP_KERNEL.
  - Rebase to linux-next 20210202.
  - Fix and add some comments for vmemmap_remap_free().

  Thanks to Oscar, Mike, David H and David R's suggestions and review.

Changelog in v12 -> v13:
  - Remove VM_WARN_ON_PAGE macro.
  - Add more comments in vmemmap_pte_range() and vmemmap_remap_free().

  Thanks to Oscar and Mike's suggestions and review.

Changelog in v11 -> v12:
  - Move VM_WARN_ON_PAGE to a separate patch.
  - Call __free_hugepage() with hugetlb_lock (See patch #5.) to serialize
    with dissolve_free_huge_page(). It is to prepare for patch #9.
  - Introduce PageHugeInflight. See patch #9.

Changelog in v10 -> v11:
  - Fix compiler error when !CONFIG_HUGETLB_PAGE_FREE_VMEMMAP.
  - Rework some comments and commit changes.
  - Rework vmemmap_remap_free() to 3 parameters.

  Thanks to Oscar and Mike's suggestions and review.

Changelog in v9 -> v10:
  - Fix a bug in patch #11. Thanks to Oscar for pointing that out.
  - Rework some commit log or comments. Thanks Mike and Oscar for the suggestions.
  - Drop VMEMMAP_TAIL_PAGE_REUSE in the patch #3.

  Thank you very much Mike and Oscar for reviewing the code.

Changelog in v8 -> v9:
  - Rework some code. Very thanks to Oscar.
  - Put all the non-hugetlb vmemmap functions under sparsemem-vmemmap.c.

Changelog in v7 -> v8:
  - Adjust the order of patches.

  Very thanks to David and Oscar. Your suggestions are very valuable.

Changelog in v6 -> v7:
  - Rebase to linux-next 20201130
  - Do not use basepage mapping for vmemmap when this feature is disabled.
  - Rework some patchs.
    [PATCH v6 08/16] mm/hugetlb: Free the vmemmap pages associated with each hugetlb page
    [PATCH v6 10/16] mm/hugetlb: Allocate the vmemmap pages associated with each hugetlb page

  Thanks to Oscar and Barry.

Changelog in v5 -> v6:
  - Disable PMD/huge page mapping of vmemmap if this feature was enabled.
  - Simplify the first version code.

Changelog in v4 -> v5:
  - Rework somme comments and code in the [PATCH v4 04/21] and [PATCH v4 05/21].

  Thanks to Mike and Oscar's suggestions.

Changelog in v3 -> v4:
  - Move all the vmemmap functions to hugetlb_vmemmap.c.
  - Make the CONFIG_HUGETLB_PAGE_FREE_VMEMMAP default to y, if we want to
    disable this feature, we should disable it by a boot/kernel command line.
  - Remove vmemmap_pgtable_{init, deposit, withdraw}() helper functions.
  - Initialize page table lock for vmemmap through core_initcall mechanism.

  Thanks for Mike and Oscar's suggestions.

Changelog in v2 -> v3:
  - Rename some helps function name. Thanks Mike.
  - Rework some code. Thanks Mike and Oscar.
  - Remap the tail vmemmap page with PAGE_KERNEL_RO instead of PAGE_KERNEL.
    Thanks Matthew.
  - Add some overhead analysis in the cover letter.
  - Use vmemap pmd table lock instead of a hugetlb specific global lock.

Changelog in v1 -> v2:
  - Fix do not call dissolve_compound_page in alloc_huge_page_vmemmap().
  - Fix some typo and code style problems.
  - Remove unused handle_vmemmap_fault().
  - Merge some commits to one commit suggested by Mike.

Muchun Song (8):
  mm: memory_hotplug: factor out bootmem core functions to
    bootmem_info.c
  mm: hugetlb: introduce a new config HUGETLB_PAGE_FREE_VMEMMAP
  mm: hugetlb: free the vmemmap pages associated with each HugeTLB page
  mm: hugetlb: alloc the vmemmap pages associated with each HugeTLB page
  mm: hugetlb: add a kernel parameter hugetlb_free_vmemmap
  mm: hugetlb: introduce nr_free_vmemmap_pages in the struct hstate
  mm: hugetlb: gather discrete indexes of tail page
  mm: hugetlb: optimize the code with the help of the compiler

 Documentation/admin-guide/kernel-parameters.txt |  14 ++
 Documentation/admin-guide/mm/hugetlbpage.rst    |   3 +
 arch/x86/mm/init_64.c                           |  13 +-
 fs/Kconfig                                      |   6 +
 include/linux/bootmem_info.h                    |  65 +++++
 include/linux/hugetlb.h                         |  43 +++-
 include/linux/hugetlb_cgroup.h                  |  19 +-
 include/linux/memory_hotplug.h                  |  27 --
 include/linux/mm.h                              |   5 +
 mm/Makefile                                     |   2 +
 mm/bootmem_info.c                               | 124 ++++++++++
 mm/hugetlb.c                                    |  23 +-
 mm/hugetlb_vmemmap.c                            | 314 ++++++++++++++++++++++++
 mm/hugetlb_vmemmap.h                            |  33 +++
 mm/memory_hotplug.c                             | 116 ---------
 mm/sparse-vmemmap.c                             | 280 +++++++++++++++++++++
 mm/sparse.c                                     |   1 +
 17 files changed, 930 insertions(+), 158 deletions(-)
 create mode 100644 include/linux/bootmem_info.h
 create mode 100644 mm/bootmem_info.c
 create mode 100644 mm/hugetlb_vmemmap.c
 create mode 100644 mm/hugetlb_vmemmap.h

-- 
2.11.0

