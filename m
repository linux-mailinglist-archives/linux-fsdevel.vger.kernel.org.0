Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DFE92CD15E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Dec 2020 09:38:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729906AbgLCIg5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Dec 2020 03:36:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729885AbgLCIg4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Dec 2020 03:36:56 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DDEEC061A4D
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Dec 2020 00:36:10 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id e23so953617pgk.12
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Dec 2020 00:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kOo/JP7w8a+tgoHUgIOaYzS/sr1leDFaGYPFNCRqzdc=;
        b=hnfEiCwzKSrCDZ/mrX6Aj3SmfOi+iCY21z97QalnrUIeokvXG4Lttuw2d/Wou7RmL8
         c6Z0JXiTnWr6SIihH6Hly+63pPXEVzvJkdDXyj0d1gbtkMpHHDj1/GWZ5Q4CgJsZFVqM
         dJt7sY1nGMr+vz73spyMe04d7xyfkM3sHX1KtHaWMeRBjSs7hcfJPrDaYqXOJ3VKQbhi
         jhoj7/gWqp0bNAUBVOalMdy3mWIFAU8QzfrE2JBuk2dYFMBYg0jsIuf2Yr1cRkW7ljy/
         4kELFhU3G+GkWBIuV+QEOS9pzgYUCqfYcFyzm1N//X20Zk42LjPiIqAPHWa44yIu1Hly
         ADlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kOo/JP7w8a+tgoHUgIOaYzS/sr1leDFaGYPFNCRqzdc=;
        b=SctYuSUVXI6D1dzUeZQtZY4KSgHoal9ZgCm9evIcPg0y+jxM7GB5bNHjAL7hEUqOVe
         OWcifV7mK166gjNUs2i2sgnWYbTcU4w6GkA0Q0oTQUoUzpB4kSmy2DYN5AajcTf007D1
         xxCcaq0DyAIldBJ2c98bIFcD98ymbJwzqdipJZ4qO4JjxkN1Mo5zjih/p6++ZNwUZzvW
         3I5lEJr2TESlIVVqv/N9mgGZU9DYim9aVmw4mCTlioJJax3pi3q8EoxRVjYU9qquS38u
         V4xLSPKd3Yz2hCTVDau4gvOgN8ZAGeWEKHvcZGhmJ8e1mOxjkFO42HUs7daRj3Rt1VpG
         1IAw==
X-Gm-Message-State: AOAM533FlMPpZmK6o7ipa1SAW/cwv3GfOcPE3ks106VLxBUc7PhfSfLO
        Xj+ChQ7fTXRgFipun2TG+7IJ83kQn/PAk+m17qZEwA==
X-Google-Smtp-Source: ABdhPJyqQsRZ/eaJtyHJC/eL3wSpmHtoNio2z10vFRpurSI+Kl+KXffrn/M5FoctqOn1qaam19/8jUcNPbXC/wZ5REI=
X-Received: by 2002:a63:fe0c:: with SMTP id p12mr2143365pgh.31.1606984569926;
 Thu, 03 Dec 2020 00:36:09 -0800 (PST)
MIME-Version: 1.0
References: <20201130151838.11208-1-songmuchun@bytedance.com>
In-Reply-To: <20201130151838.11208-1-songmuchun@bytedance.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 3 Dec 2020 16:35:33 +0800
Message-ID: <CAMZfGtWvLEytN5gBN+OqntrNXNd3eNRWrfnkeCozvARmpTNAXw@mail.gmail.com>
Subject: Re: [PATCH v7 00/15] Free some vmemmap pages of hugetlb page
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, dave.hansen@linux.intel.com,
        hpa@zytor.com, x86@kernel.org, bp@alien8.de, mingo@redhat.com,
        Thomas Gleixner <tglx@linutronix.de>,
        pawan.kumar.gupta@linux.intel.com, mchehab+huawei@kernel.org,
        paulmck@kernel.org, viro@zeniv.linux.org.uk,
        Peter Zijlstra <peterz@infradead.org>, luto@kernel.org,
        oneukum@suse.com, jroedel@suse.de,
        Matthew Wilcox <willy@infradead.org>,
        David Rientjes <rientjes@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        anshuman.khandual@arm.com, Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-doc@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 30, 2020 at 11:19 PM Muchun Song <songmuchun@bytedance.com> wrote:
>
> Hi all,
>
> This patch series will free some vmemmap pages(struct page structures)
> associated with each hugetlbpage when preallocated to save memory.

Hi Mike,

What's your opinion on this version?  Any comments or suggestions?
And hoping you or more people review the series. Thank you very
much.

>
> In order to reduce the difficulty of the first version of code review.
> From this version, we disable PMD/huge page mapping of vmemmap if this
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
> In this case, for the 1GB HugeTLB page, we can save 4088 pages(There are
> 4096 pages for struct page structs, we reserve 2 pages for vmemmap and 8
> pages for page tables. So we can save 4088 pages). This is a very substantial
> gain. On our server, run some SPDK/QEMU applications which will use 1024GB
> hugetlbpage. With this feature enabled, we can save ~16GB(1G hugepage)/~11GB
> (2MB hugepage, the worst case is 10GB while the best is 12GB) memory.
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
>    # bpftrace -e 'kprobe:alloc_fresh_huge_page { @start[tid] = nsecs; } kretprobe:alloc_fresh_huge_page /@start[tid]/ { @latency = hist(nsecs - @start[tid]); delete(@start[tid]); }'
>    Attaching 2 probes...
>
>    @latency:
>    [8K, 16K)           8360 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
>    [16K, 32K)          1868 |@@@@@@@@@@@                                         |
>    [32K, 64K)            10 |                                                    |
>    [64K, 128K)            2 |                                                    |
>
>    b) Without this patch series:
>    # time echo 10240 > /proc/sys/vm/nr_hugepages
>
>    real     0m0.066s
>    user     0m0.000s
>    sys      0m0.066s
>
>    # bpftrace -e 'kprobe:alloc_fresh_huge_page { @start[tid] = nsecs; } kretprobe:alloc_fresh_huge_page /@start[tid]/ { @latency = hist(nsecs - @start[tid]); delete(@start[tid]); }'
>    Attaching 2 probes...
>
>    @latency:
>    [4K, 8K)           10176 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
>    [8K, 16K)             62 |                                                    |
>    [16K, 32K)             2 |                                                    |
>
>    Summarize: this feature is about ~2x slower than before.
>
> 2) Freeing 10240 2MB hugetlb pages.
>
>    a) With this patch series applied:
>    # time echo 0 > /proc/sys/vm/nr_hugepages
>
>    real     0m0.004s
>    user     0m0.000s
>    sys      0m0.002s
>
>    # bpftrace -e 'kprobe:__free_hugepage { @start[tid] = nsecs; } kretprobe:__free_hugepage /@start[tid]/ { @latency = hist(nsecs - @start[tid]); delete(@start[tid]); }'
>    Attaching 2 probes...
>
>    @latency:
>    [16K, 32K)         10240 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
>
>    b) Without this patch series:
>    # time echo 0 > /proc/sys/vm/nr_hugepages
>
>    real     0m0.077s
>    user     0m0.001s
>    sys      0m0.075s
>
>    # bpftrace -e 'kprobe:__free_hugepage { @start[tid] = nsecs; } kretprobe:__free_hugepage /@start[tid]/ { @latency = hist(nsecs - @start[tid]); delete(@start[tid]); }'
>    Attaching 2 probes...
>
>    @latency:
>    [4K, 8K)            9950 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
>    [8K, 16K)            287 |@                                                   |
>    [16K, 32K)             3 |                                                    |
>
>    Summarize: The overhead of __free_hugepage is about ~2-4x slower than before.
>               But according to the allocation test above, I think that here is
>               also ~2x slower than before.
>
>               But why the 'real' time of patched is smaller than before? Because
>               In this patch series, the freeing hugetlb is asynchronous(through
>               kwoker).
>
> Although the overhead has increased, the overhead is not significant. Like Mike
> said, "However, remember that the majority of use cases create hugetlb pages at
> or shortly after boot time and add them to the pool. So, additional overhead is
> at pool creation time. There is no change to 'normal run time' operations of
> getting a page from or returning a page to the pool (think page fault/unmap)".
>
> Todo:
>   1. Free all of the tail vmemmap pages
>      Now for the 2MB HugrTLB page, we only free 6 vmemmap pages. we really can
>      free 7 vmemmap pages. In this case, we can see 8 of the 512 struct page
>      structures has beed set PG_head flag. If we can adjust compound_head()
>      slightly and make compound_head() return the real head struct page when
>      the parameter is the tail struct page but with PG_head flag set.
>
>      In order to make the code evolution route clearer. This feature can can be
>      a separate patch after this patchset is solid.
>   2. Support for other architectures (e.g. aarch64).
>   3. Enable PMD/huge page mapping of vmemmap even if this feature was enabled.
>
> Changelog in v7:
>   1. Rebase to linux-next 20201130
>   2. Do not use basepage mapping for vmemmap when this feature is disabled.
>      Thanks to Oscar and Barry.
>   3. Rework some patchs.
>      [PATCH v6 08/16] mm/hugetlb: Free the vmemmap pages associated with each hugetlb page
>      [PATCH v6 10/16] mm/hugetlb: Allocate the vmemmap pages associated with each hugetlb page
>
> Changelog in v6:
>   1. Disable PMD/huge page mapping of vmemmap if this feature was enabled.
>   2. Simplify the first version code.
>
> Changelog in v5:
>   1. Rework somme comments and code in the [PATCH v4 04/21] and [PATCH v4 05/21].
>      Thanks to Mike and Oscar's suggestions.
>
> Changelog in v4:
>   1. Move all the vmemmap functions to hugetlb_vmemmap.c.
>   2. Make the CONFIG_HUGETLB_PAGE_FREE_VMEMMAP default to y, if we want to
>      disable this feature, we should disable it by a boot/kernel command line.
>   3. Remove vmemmap_pgtable_{init, deposit, withdraw}() helper functions.
>   4. Initialize page table lock for vmemmap through core_initcall mechanism.
>
>   Thanks for Mike and Oscar's suggestions.
>
> Changelog in v3:
>   1. Rename some helps function name. Thanks Mike.
>   2. Rework some code. Thanks Mike and Oscar.
>   3. Remap the tail vmemmap page with PAGE_KERNEL_RO instead of
>      PAGE_KERNEL. Thanks Matthew.
>   4. Add some overhead analysis in the cover letter.
>   5. Use vmemap pmd table lock instead of a hugetlb specific global lock.
>
> Changelog in v2:
>   1. Fix do not call dissolve_compound_page in alloc_huge_page_vmemmap().
>   2. Fix some typo and code style problems.
>   3. Remove unused handle_vmemmap_fault().
>   4. Merge some commits to one commit suggested by Mike.
>
> Muchun Song (15):
>   mm/memory_hotplug: Move bootmem info registration API to
>     bootmem_info.c
>   mm/memory_hotplug: Move {get,put}_page_bootmem() to bootmem_info.c
>   mm/hugetlb: Introduce a new config HUGETLB_PAGE_FREE_VMEMMAP
>   mm/hugetlb: Introduce nr_free_vmemmap_pages in the struct hstate
>   mm/bootmem_info: Introduce {free,prepare}_vmemmap_page()
>   mm/hugetlb: Disable freeing vmemmap if struct page size is not power
>     of two
>   x86/mm/64: Disable PMD page mapping of vmemmap
>   mm/hugetlb: Free the vmemmap pages associated with each hugetlb page
>   mm/hugetlb: Defer freeing of HugeTLB pages
>   mm/hugetlb: Allocate the vmemmap pages associated with each hugetlb
>     page
>   mm/hugetlb: Set the PageHWPoison to the raw error page
>   mm/hugetlb: Flush work when dissolving hugetlb page
>   mm/hugetlb: Add a kernel parameter hugetlb_free_vmemmap
>   mm/hugetlb: Gather discrete indexes of tail page
>   mm/hugetlb: Add BUILD_BUG_ON to catch invalid usage of tail struct
>     page
>
>  Documentation/admin-guide/kernel-parameters.txt |   9 +
>  Documentation/admin-guide/mm/hugetlbpage.rst    |   3 +
>  arch/x86/mm/init_64.c                           |  13 +-
>  fs/Kconfig                                      |  14 +
>  include/linux/bootmem_info.h                    |  64 +++++
>  include/linux/hugetlb.h                         |  35 +++
>  include/linux/hugetlb_cgroup.h                  |  15 +-
>  include/linux/memory_hotplug.h                  |  27 --
>  mm/Makefile                                     |   2 +
>  mm/bootmem_info.c                               | 124 ++++++++
>  mm/hugetlb.c                                    | 144 ++++++++--
>  mm/hugetlb_vmemmap.c                            | 367 ++++++++++++++++++++++++
>  mm/hugetlb_vmemmap.h                            |  79 +++++
>  mm/memory_hotplug.c                             | 116 --------
>  mm/sparse.c                                     |   1 +
>  15 files changed, 834 insertions(+), 179 deletions(-)
>  create mode 100644 include/linux/bootmem_info.h
>  create mode 100644 mm/bootmem_info.c
>  create mode 100644 mm/hugetlb_vmemmap.c
>  create mode 100644 mm/hugetlb_vmemmap.h
>
> --
> 2.11.0
>


--
Yours,
Muchun
