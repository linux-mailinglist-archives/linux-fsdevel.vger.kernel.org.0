Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEC7F2CDCCE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Dec 2020 18:54:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731504AbgLCRw4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Dec 2020 12:52:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbgLCRwz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Dec 2020 12:52:55 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 945EBC061A4E;
        Thu,  3 Dec 2020 09:52:14 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id qw4so4717131ejb.12;
        Thu, 03 Dec 2020 09:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O01jwosGNB3gmCv8Rr4mZTzNti9b8qJdxUNXInpIzQk=;
        b=o+XVpz4oieeV5yxvjK6g2STKFxWlsM8j8+16U3yUt6+LDuW85hsojm2r9JhatXQeNj
         /OrTUlJ/lwy33pq3BKCiWPYj76iolnf8yaUiVDS9dnh0+4fZ6VOI8UOMRS3Xl4G6SxHj
         pEgGTDCF0r/40bQQ9MUbrfHAABPexyRIeHL8zm9hh7XicUR3vOzWtQjICjAZdhoWogJu
         f1XKqOrBw2Em2ELxu7eU25wK+iEJsVzFZST7DqVvxqKQbZHkHPzZ4nVmInLAtKaOrNfY
         +wwIQddOQY2YyXJ03mbkJx0684jgb5PDgZEjDS6kaTuuvqt/5r/v5Qiet8YmY1UrLqvr
         rN4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O01jwosGNB3gmCv8Rr4mZTzNti9b8qJdxUNXInpIzQk=;
        b=dh0wsIsLst6byN9//5Lipp80Lt1tMNgc9iW33sOQ4pVlW+5HzYlk/qP14ppd6hQhl8
         IigWVfTsZE3H94MtuNdRHvgnE0l7YMyUPUP9xRJJr3a1nvWM4PbMZLyP2OFBakkLMjZy
         bSG9KGLxdYXJ0Ghs3e2t1QC06vg+ecT95zZgJZYpsiFy51cgneNZ9jbi27LXwPvagPAY
         BlcAMRggBZPdKnK3BoV0KPVkmo8O1OVxwFz3x6i5SRi6e5YfqvRC61gOzmVLnsYqYPIP
         ompZ01z81YtYz1tIgWcffU6rkROvOoLzzjdUyOSSJjN+SdxWpwytYsAsoRWO7O8nHLZq
         LGpA==
X-Gm-Message-State: AOAM530ye8zKUtxpTuLQanaNzxEHUH7bnlrSKO0QlMGO18cTLCTHEwJo
        Jre4cfFOMPz37j0m4aWhyzZvckA/ElNc+bnMDmw=
X-Google-Smtp-Source: ABdhPJyCGdGio02I1W/cxNZb8Z3pGKLpbYNaJ+56I4KPMZANly0H42flWsO1JEb9ma9Ng2SsVq6zrhItIm/aNIXLJEE=
X-Received: by 2002:a17:906:6a45:: with SMTP id n5mr3644014ejs.514.1607017933270;
 Thu, 03 Dec 2020 09:52:13 -0800 (PST)
MIME-Version: 1.0
References: <20201202182725.265020-1-shy828301@gmail.com> <20201203025234.GD1375014@carbon.DHCP.thefacebook.com>
In-Reply-To: <20201203025234.GD1375014@carbon.DHCP.thefacebook.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 3 Dec 2020 09:52:00 -0800
Message-ID: <CAHbLzkpUYsWLrA10ewyaeb2NiH56ZUTK2oBmb0X-_Om0M4B75w@mail.gmail.com>
Subject: Re: [RFC PATCH 0/9] Make shrinker's nr_deferred memcg aware
To:     Roman Gushchin <guro@fb.com>
Cc:     Kirill Tkhai <ktkhai@virtuozzo.com>,
        Shakeel Butt <shakeelb@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 2, 2020 at 6:52 PM Roman Gushchin <guro@fb.com> wrote:
>
> On Wed, Dec 02, 2020 at 10:27:16AM -0800, Yang Shi wrote:
> >
> > Recently huge amount one-off slab drop was seen on some vfs metadata heavy workloads,
> > it turned out there were huge amount accumulated nr_deferred objects seen by the
> > shrinker.
> >
> > On our production machine, I saw absurd number of nr_deferred shown as the below
> > tracing result:
> >
> > <...>-48776 [032] .... 27970562.458916: mm_shrink_slab_start:
> > super_cache_scan+0x0/0x1a0 ffff9a83046f3458: nid: 0 objects to shrink
> > 2531805877005 gfp_flags GFP_HIGHUSER_MOVABLE pgs_scanned 32 lru_pgs
> > 9300 cache items 1667 delta 11 total_scan 833
> >
> > There are 2.5 trillion deferred objects on one node, assuming all of them
> > are dentry (192 bytes per object), so the total size of deferred on
> > one node is ~480TB. It is definitely ridiculous.
> >
> > I managed to reproduce this problem with kernel build workload plus negative dentry
> > generator.
> >
> > First step, run the below kernel build test script:
> >
> > NR_CPUS=`cat /proc/cpuinfo | grep -e processor | wc -l`
> >
> > cd /root/Buildarea/linux-stable
> >
> > for i in `seq 1500`; do
> >         cgcreate -g memory:kern_build
> >         echo 4G > /sys/fs/cgroup/memory/kern_build/memory.limit_in_bytes
> >
> >         echo 3 > /proc/sys/vm/drop_caches
> >         cgexec -g memory:kern_build make clean > /dev/null 2>&1
> >         cgexec -g memory:kern_build make -j$NR_CPUS > /dev/null 2>&1
> >
> >         cgdelete -g memory:kern_build
> > done
> >
> > Then run the below negative dentry generator script:
> >
> > NR_CPUS=`cat /proc/cpuinfo | grep -e processor | wc -l`
> >
> > mkdir /sys/fs/cgroup/memory/test
> > echo $$ > /sys/fs/cgroup/memory/test/tasks
> >
> > for i in `seq $NR_CPUS`; do
> >         while true; do
> >                 FILE=`head /dev/urandom | tr -dc A-Za-z0-9 | head -c 64`
> >                 cat $FILE 2>/dev/null
> >         done &
> > done
> >
> > Then kswapd will shrink half of dentry cache in just one loop as the below tracing result
> > showed:
> >
> >       kswapd0-475   [028] .... 305968.252561: mm_shrink_slab_start: super_cache_scan+0x0/0x190 0000000024acf00c: nid: 0
> > objects to shrink 4994376020 gfp_flags GFP_KERNEL cache items 93689873 delta 45746 total_scan 46844936 priority 12
> >       kswapd0-475   [021] .... 306013.099399: mm_shrink_slab_end: super_cache_scan+0x0/0x190 0000000024acf00c: nid: 0 unused
> > scan count 4994376020 new scan count 4947576838 total_scan 8 last shrinker return val 46844928
> >
> > There were huge number of deferred objects before the shrinker was called, the behavior
> > does match the code but it might be not desirable from the user's stand of point.
> >
> > The excessive amount of nr_deferred might be accumulated due to various reasons, for example:
> >     * GFP_NOFS allocation
> >     * Significant times of small amount scan (< scan_batch, 1024 for vfs metadata)
> >
> > However the LRUs of slabs are per memcg (memcg-aware shrinkers) but the deferred objects
> > is per shrinker, this may have some bad effects:
> >     * Poor isolation among memcgs. Some memcgs which happen to have frequent limit
> >       reclaim may get nr_deferred accumulated to a huge number, then other innocent
> >       memcgs may take the fall. In our case the main workload was hit.
> >     * Unbounded deferred objects. There is no cap for deferred objects, it can outgrow
> >       ridiculously as the tracing result showed.
> >     * Easy to get out of control. Although shrinkers take into account deferred objects,
> >       but it can go out of control easily. One misconfigured memcg could incur absurd
> >       amount of deferred objects in a period of time.
> >     * Sort of reclaim problems, i.e. over reclaim, long reclaim latency, etc. There may be
> >       hundred GB slab caches for vfe metadata heavy workload, shrink half of them may take
> >       minutes. We observed latency spike due to the prolonged reclaim.
> >
> > These issues also have been discussed in https://lore.kernel.org/linux-mm/20200916185823.5347-1-shy828301@gmail.com/.
> > The patchset is the outcome of that discussion.
> >
> > So this patchset makes nr_deferred per-memcg to tackle the problem. It does:
> >     * Have memcg_shrinker_deferred per memcg per node, just like what shrinker_map
> >       does. Instead it is an atomic_long_t array, each element represent one shrinker
> >       even though the shrinker is not memcg aware, this simplifies the implementation.
> >       For memcg aware shrinkers, the deferred objects are just accumulated to its own
> >       memcg. The shrinkers just see nr_deferred from its own memcg. Non memcg aware
> >       shrinkers still use global nr_deferred from struct shrinker.
> >     * Once the memcg is offlined, its nr_deferred will be reparented to its parent along
> >       with LRUs.
> >     * The root memcg has memcg_shrinker_deferred array too. It simplifies the handling of
> >       reparenting to root memcg.
> >     * Cap nr_deferred to 2x of the length of lru. The idea is borrowed from Dave Chinner's
> >       series (https://lore.kernel.org/linux-xfs/20191031234618.15403-1-david@fromorbit.com/)
> >
> > The downside is each memcg has to allocate extra memory to store the nr_deferred array.
> > On our production environment, there are typically around 40 shrinkers, so each memcg
> > needs ~320 bytes. 10K memcgs would need ~3.2MB memory. It seems fine.
> >
> > We have been running the patched kernel on some hosts of our fleet (test and production) for
> > months, it works very well. The monitor data shows the working set is sustained as expected.
>
> Hello Yang!
>
> The rationale is very well described and makes perfect sense to me.
> I fully support the idea to make nr_deferred per-memcg.
> Thank you for such a detailed description!
>
> More comments in individual patches.

Thank you very much.

>
> Thanks!
>
> >
> > Yang Shi (9):
> >       mm: vmscan: simplify nr_deferred update code
> >       mm: vmscan: use nid from shrink_control for tracepoint
> >       mm: memcontrol: rename memcg_shrinker_map_mutex to memcg_shrinker_mutex
> >       mm: vmscan: use a new flag to indicate shrinker is registered
> >       mm: memcontrol: add per memcg shrinker nr_deferred
> >       mm: vmscan: use per memcg nr_deferred of shrinker
> >       mm: vmscan: don't need allocate shrinker->nr_deferred for memcg aware shrinkers
> >       mm: memcontrol: reparent nr_deferred when memcg offline
> >       mm: vmscan: shrink deferred objects proportional to priority
> >
> >  include/linux/memcontrol.h |   9 +++++
> >  include/linux/shrinker.h   |   8 ++++
> >  mm/memcontrol.c            | 148 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----
> >  mm/vmscan.c                | 183 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---------------------------------
> >  4 files changed, 274 insertions(+), 74 deletions(-)
> >
