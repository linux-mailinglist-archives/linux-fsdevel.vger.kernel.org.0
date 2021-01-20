Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10A462FD6F5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Jan 2021 18:33:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389675AbhATOJ1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Jan 2021 09:09:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:48956 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731290AbhATNLW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Jan 2021 08:11:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8DF81B76E;
        Wed, 20 Jan 2021 13:10:14 +0000 (UTC)
Date:   Wed, 20 Jan 2021 14:10:09 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>, paulmck@kernel.org,
        dave.hansen@linux.intel.com, anshuman.khandual@arm.com,
        oneukum@suse.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        Randy Dunlap <rdunlap@infradead.org>, mingo@redhat.com,
        mchehab+huawei@kernel.org, luto@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        viro@zeniv.linux.org.uk, Peter Zijlstra <peterz@infradead.org>,
        David Rientjes <rientjes@google.com>,
        Michal Hocko <mhocko@suse.com>, jroedel@suse.de,
        Mina Almasry <almasrymina@google.com>,
        pawan.kumar.gupta@linux.intel.com,
        HORIGUCHI =?utf-8?B?TkFPWUEo5aCA5Y+jIOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>, David Hildenbrand <david@redhat.com>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v13 00/12] Free some vmemmap pages of HugeTLB page
Message-ID: <20210120130959.GA7881@localhost.localdomain>
References: <20210117151053.24600-1-songmuchun@bytedance.com>
 <CAMZfGtVkjS4TXpRWsmCDxXKxP7W+-D1EgTZt30h3b1Si1+u9pA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZfGtVkjS4TXpRWsmCDxXKxP7W+-D1EgTZt30h3b1Si1+u9pA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 20, 2021 at 08:52:50PM +0800, Muchun Song wrote:
> Hi Oscar and Mike,
> 
> Any suggestions about this version? Looking forward to your
> review. Thanks a lot.

Hi Muchun,

I plan to keep reviewing it in the coming days (tomorrow or Friday).
I glanced over patch#3 when you posted the series and nothing sticked out besides
what you have already pointed out, but I will have a further look.

thanks



> 
> >
> > Changelog in v11 -> v12:
> >   - Move VM_WARN_ON_PAGE to a separate patch.
> >   - Call __free_hugepage() with hugetlb_lock (See patch #5.) to serialize
> >     with dissolve_free_huge_page(). It is to prepare for patch #9.
> >   - Introduce PageHugeInflight. See patch #9.
> >
> > Changelog in v10 -> v11:
> >   - Fix compiler error when !CONFIG_HUGETLB_PAGE_FREE_VMEMMAP.
> >   - Rework some comments and commit changes.
> >   - Rework vmemmap_remap_free() to 3 parameters.
> >
> >   Thanks to Oscar and Mike's suggestions and review.
> >
> > Changelog in v9 -> v10:
> >   - Fix a bug in patch #11. Thanks to Oscar for pointing that out.
> >   - Rework some commit log or comments. Thanks Mike and Oscar for the suggestions.
> >   - Drop VMEMMAP_TAIL_PAGE_REUSE in the patch #3.
> >
> >   Thank you very much Mike and Oscar for reviewing the code.
> >
> > Changelog in v8 -> v9:
> >   - Rework some code. Very thanks to Oscar.
> >   - Put all the non-hugetlb vmemmap functions under sparsemem-vmemmap.c.
> >
> > Changelog in v7 -> v8:
> >   - Adjust the order of patches.
> >
> >   Very thanks to David and Oscar. Your suggestions are very valuable.
> >
> > Changelog in v6 -> v7:
> >   - Rebase to linux-next 20201130
> >   - Do not use basepage mapping for vmemmap when this feature is disabled.
> >   - Rework some patchs.
> >     [PATCH v6 08/16] mm/hugetlb: Free the vmemmap pages associated with each hugetlb page
> >     [PATCH v6 10/16] mm/hugetlb: Allocate the vmemmap pages associated with each hugetlb page
> >
> >   Thanks to Oscar and Barry.
> >
> > Changelog in v5 -> v6:
> >   - Disable PMD/huge page mapping of vmemmap if this feature was enabled.
> >   - Simplify the first version code.
> >
> > Changelog in v4 -> v5:
> >   - Rework somme comments and code in the [PATCH v4 04/21] and [PATCH v4 05/21].
> >
> >   Thanks to Mike and Oscar's suggestions.
> >
> > Changelog in v3 -> v4:
> >   - Move all the vmemmap functions to hugetlb_vmemmap.c.
> >   - Make the CONFIG_HUGETLB_PAGE_FREE_VMEMMAP default to y, if we want to
> >     disable this feature, we should disable it by a boot/kernel command line.
> >   - Remove vmemmap_pgtable_{init, deposit, withdraw}() helper functions.
> >   - Initialize page table lock for vmemmap through core_initcall mechanism.
> >
> >   Thanks for Mike and Oscar's suggestions.
> >
> > Changelog in v2 -> v3:
> >   - Rename some helps function name. Thanks Mike.
> >   - Rework some code. Thanks Mike and Oscar.
> >   - Remap the tail vmemmap page with PAGE_KERNEL_RO instead of PAGE_KERNEL.
> >     Thanks Matthew.
> >   - Add some overhead analysis in the cover letter.
> >   - Use vmemap pmd table lock instead of a hugetlb specific global lock.
> >
> > Changelog in v1 -> v2:
> >   - Fix do not call dissolve_compound_page in alloc_huge_page_vmemmap().
> >   - Fix some typo and code style problems.
> >   - Remove unused handle_vmemmap_fault().
> >   - Merge some commits to one commit suggested by Mike.
> >
> > Muchun Song (12):
> >   mm: memory_hotplug: factor out bootmem core functions to
> >     bootmem_info.c
> >   mm: hugetlb: introduce a new config HUGETLB_PAGE_FREE_VMEMMAP
> >   mm: hugetlb: free the vmemmap pages associated with each HugeTLB page
> >   mm: hugetlb: defer freeing of HugeTLB pages
> >   mm: hugetlb: allocate the vmemmap pages associated with each HugeTLB
> >     page
> >   mm: hugetlb: set the PageHWPoison to the raw error page
> >   mm: hugetlb: flush work when dissolving a HugeTLB page
> >   mm: hugetlb: introduce PageHugeInflight
> >   mm: hugetlb: add a kernel parameter hugetlb_free_vmemmap
> >   mm: hugetlb: introduce nr_free_vmemmap_pages in the struct hstate
> >   mm: hugetlb: gather discrete indexes of tail page
> >   mm: hugetlb: optimize the code with the help of the compiler
> >
> >  Documentation/admin-guide/kernel-parameters.txt |  14 ++
> >  Documentation/admin-guide/mm/hugetlbpage.rst    |   3 +
> >  arch/x86/mm/init_64.c                           |  13 +-
> >  fs/Kconfig                                      |  18 ++
> >  include/linux/bootmem_info.h                    |  65 ++++++
> >  include/linux/hugetlb.h                         |  37 ++++
> >  include/linux/hugetlb_cgroup.h                  |  15 +-
> >  include/linux/memory_hotplug.h                  |  27 ---
> >  include/linux/mm.h                              |   5 +
> >  mm/Makefile                                     |   2 +
> >  mm/bootmem_info.c                               | 124 +++++++++++
> >  mm/hugetlb.c                                    | 218 +++++++++++++++++--
> >  mm/hugetlb_vmemmap.c                            | 278 ++++++++++++++++++++++++
> >  mm/hugetlb_vmemmap.h                            |  45 ++++
> >  mm/memory_hotplug.c                             | 116 ----------
> >  mm/sparse-vmemmap.c                             | 273 +++++++++++++++++++++++
> >  mm/sparse.c                                     |   1 +
> >  17 files changed, 1082 insertions(+), 172 deletions(-)
> >  create mode 100644 include/linux/bootmem_info.h
> >  create mode 100644 mm/bootmem_info.c
> >  create mode 100644 mm/hugetlb_vmemmap.c
> >  create mode 100644 mm/hugetlb_vmemmap.h
> >
> > --
> > 2.11.0
> >
> 

-- 
Oscar Salvador
SUSE L3
