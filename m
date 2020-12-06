Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B666A2D0261
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Dec 2020 11:03:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726043AbgLFKDn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Dec 2020 05:03:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbgLFKDm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Dec 2020 05:03:42 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98DBCC0613D0
        for <linux-fsdevel@vger.kernel.org>; Sun,  6 Dec 2020 02:02:56 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id lb18so3120422pjb.5
        for <linux-fsdevel@vger.kernel.org>; Sun, 06 Dec 2020 02:02:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yK27iUNadlI9MmI6B+s8BZZCxEUnviUifHj+P5KRXMg=;
        b=ilNSry1fFb2VSxzC6tm0xGYazjZD9Ar0wYnM5PmkQPzKeO6m/8kxm5rNlI7oyTPPbk
         i5xwLJoZlcE+oIS19DTByIbI8S3mWauEFjywj/RhH1PXOGTBSbM16m1Gl+AZFCYm0gyH
         bqu6gclEOOrruiFK87psVFo1l/07z01Iq65RLsp9vxd5+qGAHT97LUR7X2J4zBebULJg
         EbQ6P5WANSdYinm/+Jl5ZApt2ou6i8fmj/P4NnTZeBruaCmWfW2MUQXUTCXnA4EK+O5a
         yyTurylWJoFQxbjQg32Oh61ACS8XIfEJKlqAriWqjT9VSLCtNs7tOFl0UM+mD4P2rW87
         b+1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yK27iUNadlI9MmI6B+s8BZZCxEUnviUifHj+P5KRXMg=;
        b=Xjo3H/UjfVRXcr9qmpJhJXaBPOc7HbFpXPKGaraxKJGZZM9gQCVEu+WrPgqPfh2g5e
         e7LttDMfBZzLqkWvWSlzfua7TCoV+4EFAW/f52H6LainQz5Y+9GPc9nvP2N/KypwoQ3n
         2ShjIOPOKBEIbQEv9eQ5n/VsKsdm5Db+v9cLzBfKkD5tZKcAOh7TIO8StAthbr6TvqEK
         mMXIS2SAQoPTx3qTddvDDGRdNEblPmpORD29UxOSbmqcug2HRYuIlTFNsw+QZ4Q7mhwg
         ZPbN8PCCiR4y+7hLMnEbLXRqzGbh5hrROm2Y6SF4UF9gRRmBQW9muD8JcSoJks4hyaGD
         hmvg==
X-Gm-Message-State: AOAM530qhFCBVhhzdB+3526pB5uyIRpWTmx1nZNNDpc81MEKruRvJkjT
        NpNvclY/9XFNgtQkBmZv6aIcdP9v2Nxeiw66isZm/A==
X-Google-Smtp-Source: ABdhPJzlTMynhkhES4yihb/sRbkNB9LxQF5JR1rRWkeIuqZTp8b5PPlWcwgHSCrkWCDSnWLuHFNfu1VIhoMtRrqcpDc=
X-Received: by 2002:a17:902:ed0d:b029:da:c83b:5f40 with SMTP id
 b13-20020a170902ed0db02900dac83b5f40mr11300264pld.20.1607248976015; Sun, 06
 Dec 2020 02:02:56 -0800 (PST)
MIME-Version: 1.0
References: <20201206082318.11532-1-songmuchun@bytedance.com>
In-Reply-To: <20201206082318.11532-1-songmuchun@bytedance.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Sun, 6 Dec 2020 18:02:19 +0800
Message-ID: <CAMZfGtXX2k+-RGHx7CtbnoC4QOSHT2afS=9YX5GAjFN38=xkkw@mail.gmail.com>
Subject: Re: [PATCH v2 00/12] Convert all vmstat counters to pages or bytes
To:     Greg KH <gregkh@linuxfoundation.org>, rafael@kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Hugh Dickins <hughd@google.com>, Will Deacon <will@kernel.org>,
        Roman Gushchin <guro@fb.com>, Mike Rapoport <rppt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, esyr@redhat.com,
        peterx@redhat.com, krisman@collabora.com,
        Suren Baghdasaryan <surenb@google.com>, avagin@openvz.org,
        Marco Elver <elver@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I am very sorry that I have hit 'git send-email *' in a directory
containing both v1 and v2 patchs. Please ignore this. I will
resend this version. Very sorry for the noise. Thanks.

On Sun, Dec 6, 2020 at 4:25 PM Muchun Song <songmuchun@bytedance.com> wrote:
>
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
>
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
>


-- 
Yours,
Muchun
