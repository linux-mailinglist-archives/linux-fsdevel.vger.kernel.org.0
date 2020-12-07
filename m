Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A127A2D141E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Dec 2020 15:54:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726208AbgLGOxy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Dec 2020 09:53:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbgLGOxy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Dec 2020 09:53:54 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB036C07E5C0
        for <linux-fsdevel@vger.kernel.org>; Mon,  7 Dec 2020 06:53:07 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id f17so9073536pge.6
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Dec 2020 06:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=67q06ahdve+maXXaXcuBF0/78g4V9jwMrZzg/oICieI=;
        b=H7aX76AZlFayE7q9/thM8tX2F4CdIfANhGAWc55owFDZkkd+M4/VnK4QkPZJOC60Il
         EqBdwBRnmbarXV5lwcCaaR18VtKxpNVNexjWgzxL2TVVoO5rGJ+9h7sBWeNQUnPfoghd
         U3WdTdhzvGFyXigIEPMlH+PTwGgOMAFWPps5TizIkVykOzrbp2mE4EqKuy0qWsH5I4BZ
         8loNvDefr/DQ6mBNOMsP+yXbizUQ+t7/FONemwW2+Y8ew8nBBdKo4dGV5x8zmT64fL4+
         SrYoVyCXwR3cyegtYMDWqbTxYLtNBTmcbRa188Vt8Co6ggvMmxOL3gmvOYgehOb4IeM2
         xC3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=67q06ahdve+maXXaXcuBF0/78g4V9jwMrZzg/oICieI=;
        b=CMcTkDTK5teV4ubPjhANnNBa87xO6OaNj6lxsfBmA1RZ6oLoFr7Yv4cp2AKSddWZ1a
         KPFLLtaKK9vdZKG64vmTWU5vU9IHM4zSjb6cG1KYzGK2U9e9+6tRnW6PRNtCudyTaUvd
         sk/ODglw2Bgfk6na+AVZvKssf4a1Bz/jh3/aKKybTIpjvCQcVGgxW8a8pumru88ODZck
         l8u2Tr6QOfl6cFZcRkinUi4BkGIRFUPUDDC5GO9o7R7IdY6Xy4FXV7J2gEla9n1KW3bi
         QWGSg5jA2dfuxnXCNsaDiw+QyqdKJtza2sqEhUgpgmYxbxovS/C9iu2U63xRJRnkNnKl
         p5Qg==
X-Gm-Message-State: AOAM531VRD/p5gBKfiDNvud4ipd8uSJYCRI2UOc5DRjmyEBbackzksJK
        6nupNacx2C9D7sSqaNyh4EbRrUF08YRMP7BT2Jq0WA==
X-Google-Smtp-Source: ABdhPJwJ4IWHc9o4dLsL8uDmX/narH/dl/xqmI8YYc9Xn9QfxasAXfpW6XsPkLCBTKXQ0jbtCkPsQdCgDzMGRkbdCXc=
X-Received: by 2002:a63:c15:: with SMTP id b21mr18447984pgl.341.1607352787255;
 Mon, 07 Dec 2020 06:53:07 -0800 (PST)
MIME-Version: 1.0
References: <20201206101451.14706-1-songmuchun@bytedance.com> <20201207130018.GJ25569@dhcp22.suse.cz>
In-Reply-To: <20201207130018.GJ25569@dhcp22.suse.cz>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Mon, 7 Dec 2020 22:52:30 +0800
Message-ID: <CAMZfGtWSEKWqR4f+23xt+jVF-NLSTVQ0L0V3xfZsQzV7aeebhw@mail.gmail.com>
Subject: Re: [External] Re: [RESEND PATCH v2 00/12] Convert all vmstat
 counters to pages or bytes
To:     Michal Hocko <mhocko@suse.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, rafael@kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Hugh Dickins <hughd@google.com>, Will Deacon <will@kernel.org>,
        Roman Gushchin <guro@fb.com>, Mike Rapoport <rppt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, esyr@redhat.com,
        peterx@redhat.com, krisman@collabora.com,
        Suren Baghdasaryan <surenb@google.com>, avagin@openvz.org,
        Marco Elver <elver@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 7, 2020 at 9:00 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Sun 06-12-20 18:14:39, Muchun Song wrote:
> > Hi,
> >
> > This patch series is aimed to convert all THP vmstat counters to pages
> > and some KiB vmstat counters to bytes.
> >
> > The unit of some vmstat counters are pages, some are bytes, some are
> > HPAGE_PMD_NR, and some are KiB. When we want to expose these vmstat
> > counters to the userspace, we have to know the unit of the vmstat counters
> > is which one. It makes the code complex. Because there are too many choices,
> > the probability of making a mistake will be greater.
> >
> > For example, the below is some bug fix:
> >   - 7de2e9f195b9 ("mm: memcontrol: correct the NR_ANON_THPS counter of hierarchical memcg")
> >   - not committed(it is the first commit in this series) ("mm: memcontrol: fix NR_ANON_THPS account")
> >
> > This patch series can make the code simple (161 insertions(+), 187 deletions(-)).
> > And make the unit of the vmstat counters are either pages or bytes. Fewer choices
> > means lower probability of making mistakes :).
> >
> > This was inspired by Johannes and Roman. Thanks to them.
>
> It would be really great if you could summarize the current and after
> the patch state so that exceptions are clear and easier to review. The

Agree. Will do in the next version. Thanks.


> existing situation is rather convoluted but we have at least units part
> of the name so it is not too hard to notice that. Reducing exeptions
> sounds nice but I am not really sure it is such an improvement it is
> worth a lot of code churn. Especially when it comes to KB vs B. Counting

There are two vmstat counters (NR_KERNEL_STACK_KB and
NR_KERNEL_SCS_KB) whose units are KB. If we do this, all
vmstat counter units are either pages or bytes in the end. When
we expose those counters to userspace, it can be easy. You can
reference to:

    [RESEND PATCH v2 11/12] mm: memcontrol: make the slab calculation consistent

From this point of view, I think that it is worth doing this. Right?

> THPs as regular pages sounds like a good plan to me because we can
> expect that THP will be of a different size in the future - especially
> for file THPs. It can be easy to convert.
>
> > Changes in v1 -> v2:
> >   - Change the series subject from "Convert all THP vmstat counters to pages"
> >     to "Convert all vmstat counters to pages or bytes".
> >   - Convert NR_KERNEL_SCS_KB account to bytes.
> >   - Convert vmstat slab counters to bytes.
> >   - Remove {global_}node_page_state_pages.
> >
> > Muchun Song (12):
> >   mm: memcontrol: fix NR_ANON_THPS account
> >   mm: memcontrol: convert NR_ANON_THPS account to pages
> >   mm: memcontrol: convert NR_FILE_THPS account to pages
> >   mm: memcontrol: convert NR_SHMEM_THPS account to pages
> >   mm: memcontrol: convert NR_SHMEM_PMDMAPPED account to pages
> >   mm: memcontrol: convert NR_FILE_PMDMAPPED account to pages
> >   mm: memcontrol: convert kernel stack account to bytes
> >   mm: memcontrol: convert NR_KERNEL_SCS_KB account to bytes
> >   mm: memcontrol: convert vmstat slab counters to bytes
> >   mm: memcontrol: scale stat_threshold for byted-sized vmstat
> >   mm: memcontrol: make the slab calculation consistent
> >   mm: memcontrol: remove {global_}node_page_state_pages
> >
> >  drivers/base/node.c     |  25 ++++-----
> >  fs/proc/meminfo.c       |  22 ++++----
> >  include/linux/mmzone.h  |  21 +++-----
> >  include/linux/vmstat.h  |  21 ++------
> >  kernel/fork.c           |   8 +--
> >  kernel/power/snapshot.c |   2 +-
> >  kernel/scs.c            |   4 +-
> >  mm/filemap.c            |   4 +-
> >  mm/huge_memory.c        |   9 ++--
> >  mm/khugepaged.c         |   4 +-
> >  mm/memcontrol.c         | 131 ++++++++++++++++++++++++------------------------
> >  mm/oom_kill.c           |   2 +-
> >  mm/page_alloc.c         |  17 +++----
> >  mm/rmap.c               |  19 ++++---
> >  mm/shmem.c              |   3 +-
> >  mm/vmscan.c             |   2 +-
> >  mm/vmstat.c             |  54 ++++++++------------
> >  17 files changed, 161 insertions(+), 187 deletions(-)
> >
> > --
> > 2.11.0
>
> --
> Michal Hocko
> SUSE Labs



--
Yours,
Muchun
