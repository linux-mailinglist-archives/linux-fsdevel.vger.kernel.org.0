Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4D7F310805
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Feb 2021 10:38:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbhBEJgr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Feb 2021 04:36:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbhBEJcQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Feb 2021 04:32:16 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B05C0613D6
        for <linux-fsdevel@vger.kernel.org>; Fri,  5 Feb 2021 01:31:36 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id o7so4160756pgl.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Feb 2021 01:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lZ52iWsdARGk2lAIOdx33a3ZO7f0psqY6W9v1+LcwX8=;
        b=hmgcEJXs2lC+TuBrC3OG7kfz0kEvqC9gVuamTohw5/KFqqK9C1nVjxf+dI4nN6TAuc
         t/Qaq+6Rbc34+Nkb+icyFho5ePqQrZU91QjEcNx8lSNQrAi0jbGH5eBdcsXyJAhvHO0n
         eN/LnHPnjEnrQ2u8CB3EE/4jorFqrlP1PfGD5CoKzsdKevRyGDKQzA1w2w62ehjOZr3g
         7BsvNzy8fuRLCePv5uivbXCUe6Utg3i1Coy7/AMNMryI3DWZxvEbXgBeda81qf3CaQUd
         JbR5IrrJF0k8qanYzmAXrPBiUuvNtVmTZlQd9xfNyK6QS8tmNPzMiwkFAxv2l2WuiYz8
         2wmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lZ52iWsdARGk2lAIOdx33a3ZO7f0psqY6W9v1+LcwX8=;
        b=rs1dLJg4RHLOUUiSBt+9afaOGW0X/MWBe7rtij5JSedrtSdKy7ngQaRvv5oDsPb/m5
         ImVMCrrTXXrdKKlpmDizMFoRqZhzKL2KvskzU/c2EfwhNUY2cTQD2+OH6hjhj3G2rnV/
         f5E7mFBn9/XU+VUxTwoPV0Sj+5fBHGqjRoU3IyAbWMu4fDVUj5gJHhkhVaBxqQ3GqcIz
         39QxwdZApEU5uV32GTR4ktDcJ+VdLO6YiCDMAR8CLRk2xVNaklL2rtp/M5FIIviTvQdB
         U7jfVrXHaMaUWQK5WOMkSsc/4gJKqyMU3/9pA5go3h+PExcLVCb4j9/KIjKslVdPeMbv
         45Ew==
X-Gm-Message-State: AOAM531RLUC0soYJV5O9m1J3zEWVAdIwGu7pvhNFJOlHsFLwKKaSXW7K
        LoK3Ir3/Z/OQxELTBndSbXRY9hB9bWXoFkP0lWuUHg==
X-Google-Smtp-Source: ABdhPJwV35KHOq4fEHYqxPMJ6oxRltbFzMTdl6LWDoB5jZOchXAiwqmkb2MMJUJsIfUL5zAsrBwbQew6pqOhTPA0B1c=
X-Received: by 2002:aa7:9790:0:b029:1d8:263e:cc9b with SMTP id
 o16-20020aa797900000b02901d8263ecc9bmr1355925pfp.2.1612517495747; Fri, 05 Feb
 2021 01:31:35 -0800 (PST)
MIME-Version: 1.0
References: <20210204035043.36609-1-songmuchun@bytedance.com> <20210205085940.GD13848@linux>
In-Reply-To: <20210205085940.GD13848@linux>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 5 Feb 2021 17:30:58 +0800
Message-ID: <CAMZfGtUDBjKqcBF3NzMp5DMx_wQKYCR0QGZ7rWUoX3DOEpXT-A@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v14 0/8] Free some vmemmap pages of HugeTLB page
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org,
        Peter Zijlstra <peterz@infradead.org>, viro@zeniv.linux.org.uk,
        Andrew Morton <akpm@linux-foundation.org>, paulmck@kernel.org,
        mchehab+huawei@kernel.org, pawan.kumar.gupta@linux.intel.com,
        Randy Dunlap <rdunlap@infradead.org>, oneukum@suse.com,
        anshuman.khandual@arm.com, jroedel@suse.de,
        Mina Almasry <almasrymina@google.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        David Hildenbrand <david@redhat.com>,
        =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 5, 2021 at 4:59 PM Oscar Salvador <osalvador@suse.de> wrote:
>
> On Thu, Feb 04, 2021 at 11:50:35AM +0800, Muchun Song wrote:
> > Changelog in v13 -> v14:
> >   - Refuse to free the HugeTLB page when the system is under memory pressure.
> >   - Use GFP_ATOMIC to allocate vmemmap pages instead of GFP_KERNEL.
> >   - Rebase to linux-next 20210202.
> >   - Fix and add some comments for vmemmap_remap_free().
>
> What has happened to [1] ? AFAIK we still need it, right?
> If not, could you explain why?
>
> [1] https://patchwork.kernel.org/project/linux-mm/patch/20210117151053.24600-7-songmuchun@bytedance.com/

Hi Oscar,

I reply to you in another thread (in the patch #4).

Thanks. :-)

>
> >
> >   Thanks to Oscar, Mike, David H and David R's suggestions and review.
> >
> > Changelog in v12 -> v13:
> >   - Remove VM_WARN_ON_PAGE macro.
> >   - Add more comments in vmemmap_pte_range() and vmemmap_remap_free().
> >
> >   Thanks to Oscar and Mike's suggestions and review.
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
> > Muchun Song (8):
> >   mm: memory_hotplug: factor out bootmem core functions to
> >     bootmem_info.c
> >   mm: hugetlb: introduce a new config HUGETLB_PAGE_FREE_VMEMMAP
> >   mm: hugetlb: free the vmemmap pages associated with each HugeTLB page
> >   mm: hugetlb: alloc the vmemmap pages associated with each HugeTLB page
> >   mm: hugetlb: add a kernel parameter hugetlb_free_vmemmap
> >   mm: hugetlb: introduce nr_free_vmemmap_pages in the struct hstate
> >   mm: hugetlb: gather discrete indexes of tail page
> >   mm: hugetlb: optimize the code with the help of the compiler
> >
> >  Documentation/admin-guide/kernel-parameters.txt |  14 ++
> >  Documentation/admin-guide/mm/hugetlbpage.rst    |   3 +
> >  arch/x86/mm/init_64.c                           |  13 +-
> >  fs/Kconfig                                      |   6 +
> >  include/linux/bootmem_info.h                    |  65 +++++
> >  include/linux/hugetlb.h                         |  43 +++-
> >  include/linux/hugetlb_cgroup.h                  |  19 +-
> >  include/linux/memory_hotplug.h                  |  27 --
> >  include/linux/mm.h                              |   5 +
> >  mm/Makefile                                     |   2 +
> >  mm/bootmem_info.c                               | 124 ++++++++++
> >  mm/hugetlb.c                                    |  23 +-
> >  mm/hugetlb_vmemmap.c                            | 314 ++++++++++++++++++++++++
> >  mm/hugetlb_vmemmap.h                            |  33 +++
> >  mm/memory_hotplug.c                             | 116 ---------
> >  mm/sparse-vmemmap.c                             | 280 +++++++++++++++++++++
> >  mm/sparse.c                                     |   1 +
> >  17 files changed, 930 insertions(+), 158 deletions(-)
> >  create mode 100644 include/linux/bootmem_info.h
> >  create mode 100644 mm/bootmem_info.c
> >  create mode 100644 mm/hugetlb_vmemmap.c
> >  create mode 100644 mm/hugetlb_vmemmap.h
> >
> > --
> > 2.11.0
> >
> >
>
> --
> Oscar Salvador
> SUSE L3
