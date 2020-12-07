Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ECE42D1141
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Dec 2020 14:02:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbgLGNBH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Dec 2020 08:01:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:56990 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726070AbgLGNBG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Dec 2020 08:01:06 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1607346020; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qeJu6kD3NCj9G/FdhtDkeijj0rUcvFlopCv8/T8i47Q=;
        b=JAa8DbikxNBZm4qoJqvuoQPNVIpeCOFywaCZKbshN0zYsWGWl+fwvvj8yluCvppMy1f+tb
        2KJZUplnUC0w1rDA3pIl3D78o91HOPWvmy7U6SwyfyOUqFHegGdOaCN+dDrA+xK/VuUDw/
        q9LfoYQG7MD8/HMsa8qb5PMUVmGAqTw=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E846FAC9A;
        Mon,  7 Dec 2020 13:00:19 +0000 (UTC)
Date:   Mon, 7 Dec 2020 14:00:18 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org, adobriyan@gmail.com,
        akpm@linux-foundation.org, hannes@cmpxchg.org,
        vdavydov.dev@gmail.com, hughd@google.com, will@kernel.org,
        guro@fb.com, rppt@kernel.org, tglx@linutronix.de, esyr@redhat.com,
        peterx@redhat.com, krisman@collabora.com, surenb@google.com,
        avagin@openvz.org, elver@google.com, rdunlap@infradead.org,
        iamjoonsoo.kim@lge.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org
Subject: Re: [RESEND PATCH v2 00/12] Convert all vmstat counters to pages or
 bytes
Message-ID: <20201207130018.GJ25569@dhcp22.suse.cz>
References: <20201206101451.14706-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201206101451.14706-1-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun 06-12-20 18:14:39, Muchun Song wrote:
> Hi,
> 
> This patch series is aimed to convert all THP vmstat counters to pages
> and some KiB vmstat counters to bytes.
> 
> The unit of some vmstat counters are pages, some are bytes, some are
> HPAGE_PMD_NR, and some are KiB. When we want to expose these vmstat
> counters to the userspace, we have to know the unit of the vmstat counters
> is which one. It makes the code complex. Because there are too many choices,
> the probability of making a mistake will be greater.
> 
> For example, the below is some bug fix:
>   - 7de2e9f195b9 ("mm: memcontrol: correct the NR_ANON_THPS counter of hierarchical memcg")
>   - not committed(it is the first commit in this series) ("mm: memcontrol: fix NR_ANON_THPS account")
> 
> This patch series can make the code simple (161 insertions(+), 187 deletions(-)).
> And make the unit of the vmstat counters are either pages or bytes. Fewer choices
> means lower probability of making mistakes :).
> 
> This was inspired by Johannes and Roman. Thanks to them.

It would be really great if you could summarize the current and after
the patch state so that exceptions are clear and easier to review. The
existing situation is rather convoluted but we have at least units part
of the name so it is not too hard to notice that. Reducing exeptions
sounds nice but I am not really sure it is such an improvement it is
worth a lot of code churn. Especially when it comes to KB vs B. Counting
THPs as regular pages sounds like a good plan to me because we can
expect that THP will be of a different size in the future - especially
for file THPs.

> Changes in v1 -> v2:
>   - Change the series subject from "Convert all THP vmstat counters to pages"
>     to "Convert all vmstat counters to pages or bytes".
>   - Convert NR_KERNEL_SCS_KB account to bytes.
>   - Convert vmstat slab counters to bytes.
>   - Remove {global_}node_page_state_pages.
> 
> Muchun Song (12):
>   mm: memcontrol: fix NR_ANON_THPS account
>   mm: memcontrol: convert NR_ANON_THPS account to pages
>   mm: memcontrol: convert NR_FILE_THPS account to pages
>   mm: memcontrol: convert NR_SHMEM_THPS account to pages
>   mm: memcontrol: convert NR_SHMEM_PMDMAPPED account to pages
>   mm: memcontrol: convert NR_FILE_PMDMAPPED account to pages
>   mm: memcontrol: convert kernel stack account to bytes
>   mm: memcontrol: convert NR_KERNEL_SCS_KB account to bytes
>   mm: memcontrol: convert vmstat slab counters to bytes
>   mm: memcontrol: scale stat_threshold for byted-sized vmstat
>   mm: memcontrol: make the slab calculation consistent
>   mm: memcontrol: remove {global_}node_page_state_pages
> 
>  drivers/base/node.c     |  25 ++++-----
>  fs/proc/meminfo.c       |  22 ++++----
>  include/linux/mmzone.h  |  21 +++-----
>  include/linux/vmstat.h  |  21 ++------
>  kernel/fork.c           |   8 +--
>  kernel/power/snapshot.c |   2 +-
>  kernel/scs.c            |   4 +-
>  mm/filemap.c            |   4 +-
>  mm/huge_memory.c        |   9 ++--
>  mm/khugepaged.c         |   4 +-
>  mm/memcontrol.c         | 131 ++++++++++++++++++++++++------------------------
>  mm/oom_kill.c           |   2 +-
>  mm/page_alloc.c         |  17 +++----
>  mm/rmap.c               |  19 ++++---
>  mm/shmem.c              |   3 +-
>  mm/vmscan.c             |   2 +-
>  mm/vmstat.c             |  54 ++++++++------------
>  17 files changed, 161 insertions(+), 187 deletions(-)
> 
> -- 
> 2.11.0

-- 
Michal Hocko
SUSE Labs
