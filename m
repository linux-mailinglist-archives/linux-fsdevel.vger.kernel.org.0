Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 908702B1977
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Nov 2020 12:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbgKMLCI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Nov 2020 06:02:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbgKMLBH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Nov 2020 06:01:07 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E30C0617A7
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2020 03:00:48 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id y7so7299760pfq.11
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2020 03:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nX63o5by1tYbwNGhtUZNv1hQ/OiXKhkB5Ojf6CHHvwc=;
        b=NnuffV7r6NSfDuhwf2bhd5zEpczz3fhBtvZwYmO+kvH6qW6/AEJBEBLpU/cCa2QPJR
         jQPF0kzzSMoHd4iFdNXalgTkLxVVRyDPA/CkNU7K0zoIMFGj7W1pk1tGpb4Ule5pzADo
         9BHf+IcWxyZNDeZe82q4GQpdo00DDYQ02dk+O3AjfkbVLD59S2o5NCROSgQ2LiPEUu7h
         oMDnUJapyyIZYs2XWHW6/LHRXUWdV+fLdRnpSm75T5fB72lgmefWnurvfOq+Vx92Id/B
         lQNv2ZN7l2HIv2Adete6LF7L5e246fMUPlFtBGldfyHMplIictm0E0LjP12M+GoephDq
         6Miw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nX63o5by1tYbwNGhtUZNv1hQ/OiXKhkB5Ojf6CHHvwc=;
        b=aCOcVV452EISm05/8wYYG3C9YFsQZXJIlZ5Ln6Iv8+EwPA9BLopdnetC/ZL38mC4IA
         eFBMQSP9mQFuMkt3Y4KgoJTiEKZoluiS2kHNZeEy27ejWicXsFGdnpZ1pObZGPaiF6U2
         XgdIioPQQRN7qyLYsXHyJi7hHYIqqdo0ICjDc4a2OX/6wRezyRuW6Q+DFqM7Le8AnVGi
         P9TduzH3YVvF+G+2hQuwTWMaTNQgWSf8UbWC500BIY75rmPj3lrd+kU+qIG1rIDzMu8H
         NWhjL4V5Vjk6unRI1Z+ttkVeI2G6F19R4YTEjkoMWJCNIgx7USCLhN2adv3nfnX3kRTP
         SdgA==
X-Gm-Message-State: AOAM530YqzkOADtyMedu2xMSIVlTyy8P3wH8b2HlsPGmCEZVKrYGKpj8
        Q5z+kEzZHrC5UfjUeaunqCt2lQ==
X-Google-Smtp-Source: ABdhPJwB5GZnYQE+J8ElKteD7rSellOI6dgOWiUmA81+IFyPh4VtfLKyB5HLNh1C+0Nmy9/fYHwzOA==
X-Received: by 2002:a62:7d89:0:b029:18b:86d4:7cbe with SMTP id y131-20020a627d890000b029018b86d47cbemr1690512pfc.77.1605265248256;
        Fri, 13 Nov 2020 03:00:48 -0800 (PST)
Received: from localhost.localdomain ([61.120.150.78])
        by smtp.gmail.com with ESMTPSA id f1sm8909959pfc.56.2020.11.13.03.00.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Nov 2020 03:00:47 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     corbet@lwn.net, mike.kravetz@oracle.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        paulmck@kernel.org, mchehab+huawei@kernel.org,
        pawan.kumar.gupta@linux.intel.com, rdunlap@infradead.org,
        oneukum@suse.com, anshuman.khandual@arm.com, jroedel@suse.de,
        almasrymina@google.com, rientjes@google.com, willy@infradead.org,
        osalvador@suse.de, mhocko@suse.com
Cc:     duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v4 00/21] Free some vmemmap pages of hugetlb page
Date:   Fri, 13 Nov 2020 18:59:31 +0800
Message-Id: <20201113105952.11638-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

This patch series will free some vmemmap pages(struct page structures)
associated with each hugetlbpage when preallocated to save memory.

Nowadays we track the status of physical page frames using struct page
structures arranged in one or more arrays. And here exists one-to-one
mapping between the physical page frame and the corresponding struct page
structure.

The HugeTLB support is built on top of multiple page size support that
is provided by most modern architectures. For example, x86 CPUs normally
support 4K and 2M (1G if architecturally supported) page sizes. Every
HugeTLB has more than one struct page structure. The 2M HugeTLB has 512
struct page structure and 1G HugeTLB has 4096 struct page structures. But
in the core of HugeTLB only uses the first 4 (Use of first 4 struct page
structures comes from HUGETLB_CGROUP_MIN_ORDER.) struct page structures to
store metadata associated with each HugeTLB. The rest of the struct page
structures are usually read the compound_head field which are all the same
value. If we can free some struct page memory to buddy system so that we
can save a lot of memory.

When the system boot up, every 2M HugeTLB has 512 struct page structures
which size is 8 pages(sizeof(struct page) * 512 / PAGE_SIZE).

   hugetlbpage                  struct pages(8 pages)          page frame(8 pages)
  +-----------+ ---virt_to_page---> +-----------+   mapping to   +-----------+
  |           |                     |     0     | -------------> |     0     |
  |           |                     |     1     | -------------> |     1     |
  |           |                     |     2     | -------------> |     2     |
  |           |                     |     3     | -------------> |     3     |
  |           |                     |     4     | -------------> |     4     |
  |     2M    |                     |     5     | -------------> |     5     |
  |           |                     |     6     | -------------> |     6     |
  |           |                     |     7     | -------------> |     7     |
  |           |                     +-----------+                +-----------+
  |           |
  |           |
  +-----------+


When a hugetlbpage is preallocated, we can change the mapping from above to
bellow.

   hugetlbpage                  struct pages(8 pages)          page frame(8 pages)
  +-----------+ ---virt_to_page---> +-----------+   mapping to   +-----------+
  |           |                     |     0     | -------------> |     0     |
  |           |                     |     1     | -------------> |     1     |
  |           |                     |     2     | -------------> +-----------+
  |           |                     |     3     | -----------------^ ^ ^ ^ ^
  |           |                     |     4     | -------------------+ | | |
  |     2M    |                     |     5     | ---------------------+ | |
  |           |                     |     6     | -----------------------+ |
  |           |                     |     7     | -------------------------+
  |           |                     +-----------+
  |           |
  |           |
  +-----------+

For tail pages, the value of compound_head is the same. So we can reuse
first page of tail page structs. We map the virtual addresses of the
remaining 6 pages of tail page structs to the first tail page struct,
and then free these 6 pages. Therefore, we need to reserve at least 2
pages as vmemmap areas.

When a hugetlbpage is freed to the buddy system, we should allocate six
pages for vmemmap pages and restore the previous mapping relationship.

If we uses the 1G hugetlbpage, we can save 4088 pages(There are 4096 pages for
struct page structures, we reserve 2 pages for vmemmap and 8 pages for page
tables. So we can save 4088 pages). This is a very substantial gain. On our
server, run some SPDK/QEMU applications which will use 1024GB hugetlbpage.
With this feature enabled, we can save ~16GB(1G hugepage)/~11GB(2MB hugepage)
memory.

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

2) Freeing 10240 @MB hugetlb pages.

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

Although the overhead has increased, the overhead is not significant. Like MIke
said, "However, remember that the majority of use cases create hugetlb pages at
or shortly after boot time and add them to the pool. So, additional overhead is
at pool creation time. There is no change to 'normal run time' operations of
getting a page from or returning a page to the pool (think page fault/unmap)".

  changelog in v4:
  1. Move all the vmemmap functions to hugetlb_vmemmap.c.
  2. Make the CONFIG_HUGETLB_PAGE_FREE_VMEMMAP default to y, if we want to
     disable this feature, we should disable it by a boot/kernel command line.
  3. Remove vmemmap_pgtable_{init, deposit, withdraw}() helper functions.
  4. Initialize page table lock for vmemmap through core_initcall mechanism.

  Thanks for Mike and Oscar's suggestions.

  changelog in v3:
  1. Rename some helps function name. Thanks Mike.
  2. Rework some code. Thanks Mike and Oscar.
  3. Remap the tail vmemmap page with PAGE_KERNEL_RO instead of
     PAGE_KERNEL. Thanks Matthew.
  4. Add some overhead analysis in the cover letter.
  5. Use vmemap pmd table lock instead of a hugetlb specific global lock.

  changelog in v2:
  1. Fix do not call dissolve_compound_page in alloc_huge_page_vmemmap().
  2. Fix some typo and code style problems.
  3. Remove unused handle_vmemmap_fault().
  4. Merge some commits to one commit suggested by Mike.

Muchun Song (21):
  mm/memory_hotplug: Move bootmem info registration API to
    bootmem_info.c
  mm/memory_hotplug: Move {get,put}_page_bootmem() to bootmem_info.c
  mm/hugetlb: Introduce a new config HUGETLB_PAGE_FREE_VMEMMAP
  mm/hugetlb: Introduce nr_free_vmemmap_pages in the struct hstate
  mm/hugetlb: Introduce pgtable allocation/freeing helpers
  mm/bootmem_info: Introduce {free,prepare}_vmemmap_page()
  mm/bootmem_info: Combine bootmem info and type into page->freelist
  mm/hugetlb: Initialize page table lock for vmemmap
  mm/hugetlb: Free the vmemmap pages associated with each hugetlb page
  mm/hugetlb: Defer freeing of hugetlb pages
  mm/hugetlb: Allocate the vmemmap pages associated with each hugetlb
    page
  mm/hugetlb: Introduce remap_huge_page_pmd_vmemmap helper
  mm/hugetlb: Use PG_slab to indicate split pmd
  mm/hugetlb: Support freeing vmemmap pages of gigantic page
  mm/hugetlb: Set the PageHWPoison to the raw error page
  mm/hugetlb: Flush work when dissolving hugetlb page
  mm/hugetlb: Add a kernel parameter hugetlb_free_vmemmap
  mm/hugetlb: Merge pte to huge pmd only for gigantic page
  mm/hugetlb: Gather discrete indexes of tail page
  mm/hugetlb: Add BUILD_BUG_ON to catch invalid usage of tail struct
    page
  mm/hugetlb: Disable freeing vmemmap if struct page size is not power
    of two

 Documentation/admin-guide/kernel-parameters.txt |   9 +
 Documentation/admin-guide/mm/hugetlbpage.rst    |   3 +
 arch/x86/include/asm/hugetlb.h                  |  17 +
 arch/x86/include/asm/pgtable_64_types.h         |   8 +
 arch/x86/mm/init_64.c                           |   7 +-
 fs/Kconfig                                      |  14 +
 include/linux/bootmem_info.h                    |  78 +++
 include/linux/hugetlb.h                         |  19 +
 include/linux/hugetlb_cgroup.h                  |  15 +-
 include/linux/memory_hotplug.h                  |  27 -
 mm/Makefile                                     |   2 +
 mm/bootmem_info.c                               | 124 ++++
 mm/hugetlb.c                                    | 163 +++++-
 mm/hugetlb_vmemmap.c                            | 732 ++++++++++++++++++++++++
 mm/hugetlb_vmemmap.h                            | 104 ++++
 mm/memory_hotplug.c                             | 116 ----
 mm/sparse.c                                     |   5 +-
 17 files changed, 1263 insertions(+), 180 deletions(-)
 create mode 100644 include/linux/bootmem_info.h
 create mode 100644 mm/bootmem_info.c
 create mode 100644 mm/hugetlb_vmemmap.c
 create mode 100644 mm/hugetlb_vmemmap.h

-- 
2.11.0

