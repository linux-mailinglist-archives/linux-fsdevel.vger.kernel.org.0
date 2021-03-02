Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3B6432B45E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Mar 2021 06:22:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234713AbhCCFMP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Mar 2021 00:12:15 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:12664 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350740AbhCBMuh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Mar 2021 07:50:37 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Dqbtq6H1LzlRYm;
        Tue,  2 Mar 2021 20:25:23 +0800 (CST)
Received: from [10.174.177.134] (10.174.177.134) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Tue, 2 Mar 2021 20:27:22 +0800
Subject: Re: [PATCH v17 0/9] Free some vmemmap pages of HugeTLB page
To:     Muchun Song <songmuchun@bytedance.com>, <corbet@lwn.net>,
        <mike.kravetz@oracle.com>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>, <x86@kernel.org>,
        <hpa@zytor.com>, <dave.hansen@linux.intel.com>, <luto@kernel.org>,
        <peterz@infradead.org>, <viro@zeniv.linux.org.uk>,
        <akpm@linux-foundation.org>, <paulmck@kernel.org>,
        <mchehab+huawei@kernel.org>, <pawan.kumar.gupta@linux.intel.com>,
        <rdunlap@infradead.org>, <oneukum@suse.com>,
        <anshuman.khandual@arm.com>, <jroedel@suse.de>,
        <almasrymina@google.com>, <rientjes@google.com>,
        <willy@infradead.org>, <osalvador@suse.de>, <mhocko@suse.com>,
        <song.bao.hua@hisilicon.com>, <david@redhat.com>,
        <naoya.horiguchi@nec.com>, <joao.m.martins@oracle.com>
CC:     <duanxiongchun@bytedance.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>
References: <20210225132130.26451-1-songmuchun@bytedance.com>
From:   Chen Huang <chenhuang5@huawei.com>
Message-ID: <0f07fbd1-62ac-9b24-e253-1470318cbb06@huawei.com>
Date:   Tue, 2 Mar 2021 20:27:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20210225132130.26451-1-songmuchun@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.134]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



在 2021/2/25 21:21, Muchun Song 写道:
> Hi all,
> 
> This patch series will free some vmemmap pages(struct page structures)
> associated with each hugetlbpage when preallocated to save memory.
> 
> In order to reduce the difficulty of the first version of code review.
>>From this version, we disable PMD/huge page mapping of vmemmap if this
> feature was enabled. This accutualy eliminate a bunch of the complex code
> doing page table manipulation. When this patch series is solid, we cam add
> the code of vmemmap page table manipulation in the future.
> 
> The struct page structures (page structs) are used to describe a physical
> page frame. By default, there is a one-to-one mapping from a page frame to
> it's corresponding page struct.
> 
> The HugeTLB pages consist of multiple base page size pages and is supported
> by many architectures. See hugetlbpage.rst in the Documentation directory
> for more details. On the x86 architecture, HugeTLB pages of size 2MB and 1GB
> are currently supported. Since the base page size on x86 is 4KB, a 2MB
> HugeTLB page consists of 512 base pages and a 1GB HugeTLB page consists of
> 4096 base pages. For each base page, there is a corresponding page struct.
> 
> Within the HugeTLB subsystem, only the first 4 page structs are used to
> contain unique information about a HugeTLB page. HUGETLB_CGROUP_MIN_ORDER
> provides this upper limit. The only 'useful' information in the remaining
> page structs is the compound_head field, and this field is the same for all
> tail pages.
> 
> By removing redundant page structs for HugeTLB pages, memory can returned to
> the buddy allocator for other uses.
> 
> When the system boot up, every 2M HugeTLB has 512 struct page structs which
> size is 8 pages(sizeof(struct page) * 512 / PAGE_SIZE).
> 
>     HugeTLB                  struct pages(8 pages)         page frame(8 pages)
>  +-----------+ ---virt_to_page---> +-----------+   mapping to   +-----------+
>  |           |                     |     0     | -------------> |     0     |
>  |           |                     +-----------+                +-----------+
>  |           |                     |     1     | -------------> |     1     |
>  |           |                     +-----------+                +-----------+
>  |           |                     |     2     | -------------> |     2     |
>  |           |                     +-----------+                +-----------+
>  |           |                     |     3     | -------------> |     3     |
>  |           |                     +-----------+                +-----------+
>  |           |                     |     4     | -------------> |     4     |
>  |    2MB    |                     +-----------+                +-----------+
>  |           |                     |     5     | -------------> |     5     |
>  |           |                     +-----------+                +-----------+
>  |           |                     |     6     | -------------> |     6     |
>  |           |                     +-----------+                +-----------+
>  |           |                     |     7     | -------------> |     7     |
>  |           |                     +-----------+                +-----------+
>  |           |
>  |           |
>  |           |
>  +-----------+
> 
> The value of page->compound_head is the same for all tail pages. The first
> page of page structs (page 0) associated with the HugeTLB page contains the 4
> page structs necessary to describe the HugeTLB. The only use of the remaining
> pages of page structs (page 1 to page 7) is to point to page->compound_head.
> Therefore, we can remap pages 2 to 7 to page 1. Only 2 pages of page structs
> will be used for each HugeTLB page. This will allow us to free the remaining
> 6 pages to the buddy allocator.
> 
> Here is how things look after remapping.
> 
>     HugeTLB                  struct pages(8 pages)         page frame(8 pages)
>  +-----------+ ---virt_to_page---> +-----------+   mapping to   +-----------+
>  |           |                     |     0     | -------------> |     0     |
>  |           |                     +-----------+                +-----------+
>  |           |                     |     1     | -------------> |     1     |
>  |           |                     +-----------+                +-----------+
>  |           |                     |     2     | ----------------^ ^ ^ ^ ^ ^
>  |           |                     +-----------+                   | | | | |
>  |           |                     |     3     | ------------------+ | | | |
>  |           |                     +-----------+                     | | | |
>  |           |                     |     4     | --------------------+ | | |
>  |    2MB    |                     +-----------+                       | | |
>  |           |                     |     5     | ----------------------+ | |
>  |           |                     +-----------+                         | |
>  |           |                     |     6     | ------------------------+ |
>  |           |                     +-----------+                           |
>  |           |                     |     7     | --------------------------+
>  |           |                     +-----------+
>  |           |
>  |           |
>  |           |
>  +-----------+
> 
> When a HugeTLB is freed to the buddy system, we should allocate 6 pages for
> vmemmap pages and restore the previous mapping relationship.
> 
> Apart from 2MB HugeTLB page, we also have 1GB HugeTLB page. It is similar
> to the 2MB HugeTLB page. We also can use this approach to free the vmemmap
> pages.
> 
> In this case, for the 1GB HugeTLB page, we can save 4094 pages. This is a
> very substantial gain. On our server, run some SPDK/QEMU applications which
> will use 1024GB hugetlbpage. With this feature enabled, we can save ~16GB
> (1G hugepage)/~12GB (2MB hugepage) memory.
> 
> Because there are vmemmap page tables reconstruction on the freeing/allocating
> path, it increases some overhead. Here are some overhead analysis.
> 
> 1) Allocating 10240 2MB hugetlb pages.
> 
>    a) With this patch series applied:
>    # time echo 10240 > /proc/sys/vm/nr_hugepages
> 
>    real     0m0.166s
>    user     0m0.000s
>    sys      0m0.166s
> 
>    # bpftrace -e 'kprobe:alloc_fresh_huge_page { @start[tid] = nsecs; }
>      kretprobe:alloc_fresh_huge_page /@start[tid]/ { @latency = hist(nsecs -
>      @start[tid]); delete(@start[tid]); }'
>    Attaching 2 probes...
> 
>    @latency:
>    [8K, 16K)           5476 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
>    [16K, 32K)          4760 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@       |
>    [32K, 64K)             4 |                                                    |
> 
>    b) Without this patch series:
>    # time echo 10240 > /proc/sys/vm/nr_hugepages
> 
>    real     0m0.067s
>    user     0m0.000s
>    sys      0m0.067s
> 
>    # bpftrace -e 'kprobe:alloc_fresh_huge_page { @start[tid] = nsecs; }
>      kretprobe:alloc_fresh_huge_page /@start[tid]/ { @latency = hist(nsecs -
>      @start[tid]); delete(@start[tid]); }'
>    Attaching 2 probes...
> 
>    @latency:
>    [4K, 8K)           10147 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
>    [8K, 16K)             93 |                                                    |
> 
>    Summarize: this feature is about ~2x slower than before.
> 
> 2) Freeing 10240 2MB hugetlb pages.
> 
>    a) With this patch series applied:
>    # time echo 0 > /proc/sys/vm/nr_hugepages
> 
>    real     0m0.213s
>    user     0m0.000s
>    sys      0m0.213s
> 
>    # bpftrace -e 'kprobe:free_pool_huge_page { @start[tid] = nsecs; }
>      kretprobe:free_pool_huge_page /@start[tid]/ { @latency = hist(nsecs -
>      @start[tid]); delete(@start[tid]); }'
>    Attaching 2 probes...
> 
>    @latency:
>    [8K, 16K)              6 |                                                    |
>    [16K, 32K)         10227 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
>    [32K, 64K)             7 |                                                    |
> 
>    b) Without this patch series:
>    # time echo 0 > /proc/sys/vm/nr_hugepages
> 
>    real     0m0.081s
>    user     0m0.000s
>    sys      0m0.081s
> 
>    # bpftrace -e 'kprobe:free_pool_huge_page { @start[tid] = nsecs; }
>      kretprobe:free_pool_huge_page /@start[tid]/ { @latency = hist(nsecs -
>      @start[tid]); delete(@start[tid]); }'
>    Attaching 2 probes...
> 
>    @latency:
>    [4K, 8K)            6805 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
>    [8K, 16K)           3427 |@@@@@@@@@@@@@@@@@@@@@@@@@@                          |
>    [16K, 32K)             8 |                                                    |
> 
>    Summarize: The overhead of __free_hugepage is about ~2-3x slower than before.
> 
> Although the overhead has increased, the overhead is not significant. Like Mike
> said, "However, remember that the majority of use cases create hugetlb pages at
> or shortly after boot time and add them to the pool. So, additional overhead is
> at pool creation time. There is no change to 'normal run time' operations of
> getting a page from or returning a page to the pool (think page fault/unmap)".
> 
> Despite the overhead and in addition to the memory gains from this series. The
> following data is obtained by Joao Martins. Very thanks to his effort.
> 
> There's an additional benefit which is page (un)pinners will see an improvement
> and Joao presumes because there are fewer memmap pages and thus the tail/head
> pages are staying in cache more often.
> 
> Out of the box Joao saw (when comparing linux-next against linux-next + this series)
> with gup_test and pinning a 16G hugetlb file (with 1G pages):
> 
> 	get_user_pages(): ~32k -> ~9k
> 	unpin_user_pages(): ~75k -> ~70k
> 
> Usually any tight loop fetching compound_head(), or reading tail pages data (e.g.
> compound_head) benefit a lot. There's some unpinning inefficiencies Joao was
> fixing[0], but with that in added it shows even more:
> 
> 	unpin_user_pages(): ~27k -> ~3.8k
> 
> [0] https://lore.kernel.org/linux-mm/20210204202500.26474-1-joao.m.martins@oracle.com/
> 
> Todo:
>   - Free all of the tail vmemmap pages
>     Now for the 2MB HugrTLB page, we only free 6 vmemmap pages. we really can
>     free 7 vmemmap pages. In this case, we can see 8 of the 512 struct page
>     structures has beed set PG_head flag. If we can adjust compound_head()
>     slightly and make compound_head() return the real head struct page when
>     the parameter is the tail struct page but with PG_head flag set.
> 
>     In order to make the code evolution route clearer. This feature can can be
>     a separate patch after this patchset is solid.
> 
>   - Support for other architectures (e.g. aarch64).
>   - Enable PMD/huge page mapping of vmemmap even if this feature was enabled.

Tested-by: Chen Huang <chenhuang5@huawei.com>

We are interested in this patch and have tested the patch for x86. Also we made a simple
modification in arm64 and tested for the patch.

1. In x86, we set the total memory of 70G, and use 32G for hugepages then got the result:
------------------------------------------------------------------------------------------------
                    2M page                    |                    1G page                    |
----------------------|------------------------|----------------------|------------------------|
       enable         |        disable         |      enable          |        disable         |
----------------------|------------------------|----------------------|------------------------|
total  |  used | free | total  |  used | free  |total  |  used | free | total  |  used | free  |
70855  | 33069 | 37786| 70473  | 33068 | 37405 |70983  | 33068 | 37914| 70473  | 33068 | 37405 |
------------------------------------------------------------------------------------------------
The result is that for 2M hugepage, we can save 382M memory which is correspoinding to the expected
384M memory. For 1G hugepage, we can save 510M memory which is correspoinding to the expected 512M
memory.

2. In arm64, the hack modification is shown below[1]. We set the total memory of 40G, and use 10G
for hugepages then got the result:
------------------------------------------------------------------------------------------------
                    2M page                    |                    1G page                    |
----------------------|------------------------|----------------------|------------------------|
       enable         |        disable         |      enable          |        disable         |
----------------------|------------------------|----------------------|------------------------|
total  |  used | free | total  |  used | free  |total  |  used | free | total  |  used | free  |
39,739 | 10279 |29,460| 39579  | 10278 | 29,301‬|39,699 | 10279 |29,420| 39579  | 10278 | 29,301|
------------------------------------------------------------------------------------------------
The result is that for 2M hugepage, we can save 119M memory which is correspoinding to the expected
120M memory. For 1G hugepage, we can save 159M memory which is correspoinding to the expected 160M
memory.

3. Also we found that when we free and realloc the 1G hugepages, as the vmemmap need realloc pages before
freeing the hugepages, it will decrese the chance to get hugepages. Because the freeed hugepages has
returned to the buddy system and may be used for vmemmap pages.
We think failing to alloc hugepages is normal so this is fine.

[1]: support arm64
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index a0a41e6c1307..c150c6e6e20c 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1091,7 +1091,7 @@ static void free_empty_tables(unsigned long addr, unsigned long end,
 #endif

 #ifdef CONFIG_SPARSEMEM_VMEMMAP
-#if !ARM64_SWAPPER_USES_SECTION_MAPS
+#if !ARM64_SWAPPER_USES_SECTION_MAPS || defined(CONFIG_HUGETLB_PAGE_FREE_VMEMMAP)
 int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
                struct vmem_altmap *altmap)
 {
diff --git a/fs/Kconfig b/fs/Kconfig
index de87f234f1e9..fa46c9dfa256 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -239,9 +239,8 @@ config HUGETLB_PAGE

 config HUGETLB_PAGE_FREE_VMEMMAP
        def_bool HUGETLB_PAGE
-       depends on X86_64
+       depends on (X86_64 && HAVE_BOOTMEM_INFO_NODE) || ARM64
        depends on SPARSEMEM_VMEMMAP
-       depends on HAVE_BOOTMEM_INFO_NODE

 config MEMFD_CREATE
        def_bool TMPFS || HUGETLBFS
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 60fc6cd6cd23..b25d3b895eaa 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -165,7 +165,11 @@ static void vmemmap_remap_range(unsigned long start, unsigned long end,
 static inline void free_vmemmap_page(struct page *page)
 {
        if (PageReserved(page))
+#if defined(CONFIG_ARM64) && defined(CONFIG_HUGETLB_PAGE_FREE_VMEMMAP)
+               free_reserved_page(page);
+#else
                free_bootmem_page(page);
+#endif
        else
                __free_page(page);
 }


