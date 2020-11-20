Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 745FB2BA4E4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 09:43:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbgKTImF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 03:42:05 -0500
Received: from mx2.suse.de ([195.135.220.15]:55920 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727120AbgKTImF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 03:42:05 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1605861723; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MNOFiQtIQ/Y0rDgNN5kTTR1VqVa93kqccMa8KF0RIG4=;
        b=GDiMTJsC4HaxfVv0+8YSZSejokk+wM15yKilSV79cAMmGEld8iatqZpL7x05RKawd1r7EA
        CeEXdJtWgXQaKN9jeEQSbHEYtl0KboYq6AM21k4jrWN51rd55Vz+0E3gxx9SL/z3x0Jdle
        ZWFxIELplvVBCkbBX8K4Z0O/KzYE2B0=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7DECDACBA;
        Fri, 20 Nov 2020 08:42:03 +0000 (UTC)
Date:   Fri, 20 Nov 2020 09:42:02 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     corbet@lwn.net, mike.kravetz@oracle.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        paulmck@kernel.org, mchehab+huawei@kernel.org,
        pawan.kumar.gupta@linux.intel.com, rdunlap@infradead.org,
        oneukum@suse.com, anshuman.khandual@arm.com, jroedel@suse.de,
        almasrymina@google.com, rientjes@google.com, willy@infradead.org,
        osalvador@suse.de, song.bao.hua@hisilicon.com,
        duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 00/21] Free some vmemmap pages of hugetlb page
Message-ID: <20201120084202.GJ3200@dhcp22.suse.cz>
References: <20201120064325.34492-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201120064325.34492-1-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 20-11-20 14:43:04, Muchun Song wrote:
[...]

Thanks for improving the cover letter and providing some numbers. I have
only glanced through the patchset because I didn't really have more time
to dive depply into them.

Overall it looks promissing. To summarize. I would prefer to not have
the feature enablement controlled by compile time option and the kernel
command line option should be opt-in. I also do not like that freeing
the pool can trigger the oom killer or even shut the system down if no
oom victim is eligible.

One thing that I didn't really get to think hard about is what is the
effect of vmemmap manipulation wrt pfn walkers. pfn_to_page can be
invalid when racing with the split. How do we enforce that this won't
blow up?

I have also asked in a previous version whether the vmemmap manipulation
should be really unconditional. E.g. shortlived hugetlb pages allocated
from the buddy allocator directly rather than for a pool. Maybe it
should be restricted for the pool allocation as those are considered
long term and therefore the overhead will be amortized and freeing path
restrictions better understandable.

>  Documentation/admin-guide/kernel-parameters.txt |   9 +
>  Documentation/admin-guide/mm/hugetlbpage.rst    |   3 +
>  arch/x86/include/asm/hugetlb.h                  |  17 +
>  arch/x86/include/asm/pgtable_64_types.h         |   8 +
>  arch/x86/mm/init_64.c                           |   7 +-
>  fs/Kconfig                                      |  14 +
>  include/linux/bootmem_info.h                    |  78 +++
>  include/linux/hugetlb.h                         |  19 +
>  include/linux/hugetlb_cgroup.h                  |  15 +-
>  include/linux/memory_hotplug.h                  |  27 -
>  mm/Makefile                                     |   2 +
>  mm/bootmem_info.c                               | 124 ++++
>  mm/hugetlb.c                                    | 163 ++++-
>  mm/hugetlb_vmemmap.c                            | 765 ++++++++++++++++++++++++
>  mm/hugetlb_vmemmap.h                            | 103 ++++

I will need to look closer but I suspect that a non-trivial part of the
vmemmap manipulation really belongs to mm/sparse-vmemmap.c because the
split and remapping shouldn't really be hugetlb specific. Sure hugetlb
knows how to split but all the splitting should be implemented in
vmemmap proper.

>  mm/memory_hotplug.c                             | 116 ----
>  mm/sparse.c                                     |   5 +-
>  17 files changed, 1295 insertions(+), 180 deletions(-)
>  create mode 100644 include/linux/bootmem_info.h
>  create mode 100644 mm/bootmem_info.c
>  create mode 100644 mm/hugetlb_vmemmap.c
>  create mode 100644 mm/hugetlb_vmemmap.h

Thanks!
-- 
Michal Hocko
SUSE Labs
