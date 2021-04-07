Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC513560DA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Apr 2021 03:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347749AbhDGBkW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Apr 2021 21:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343675AbhDGBkT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Apr 2021 21:40:19 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F00C06174A;
        Tue,  6 Apr 2021 18:40:10 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id u17so18674044ejk.2;
        Tue, 06 Apr 2021 18:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KgaoO4aVIvdCnnxzOAKQPy1sG+snfWsTn2UOD6n6K2M=;
        b=qp7SBFC/kzC5O8ivCzGDdzsxtGk1CkA3R+tsTwgHn35v+87CgSB/kWhNyVH2k0Y4Ku
         G+3X8p8Ew7Hq9YSA+VGoo0D+JJtkbNVouyAdDLX2b2vCanEsKUmTHYrMcVfJGA7dIRzu
         WETqioKWyI3VhJXPNYPMgZVGKAlbycdTw3SGMG54DMPoo56EHnpj95kEEq9IfPArjfcP
         iA/eDKgPTsBMaARKrG4b2hVg8ro2LDcc39Bufz+8tw3AsSZ92uqBRtZcmlI+WImua25r
         OUyhBfg7K+tUO4BdSUyYORIP4jRh2MUrZtxrClfDz0oF3nBqOSzJxIiscZT+o9JZDMhx
         d//Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KgaoO4aVIvdCnnxzOAKQPy1sG+snfWsTn2UOD6n6K2M=;
        b=hHi+9rY7cma+HGaZ1iiO+OmBqzghdj3T9Fgp+1lj8AjV94BcrYPzEg1C6rx81auwsE
         5/9QgmmpZDUy7XOf3MaT8ZS97pTpIvBgElHSQq0dDU4nxo63XBlFlvnm03AKKvi/c5uE
         gVvJWH7t1/Q2PJB8Sp2pzZeXM7o/5m1FeFVVdjpTipM/S7P5JuFhPd41qydSevoqZSVy
         yWXmIU8MWnG+CMZpGSZ2lYcJu62uzgroxeAmJx3yH7HuVk9+QN/EG1icANc7LfNQSKsq
         DOc82m4KRgIF30GvAqYpTaCQ6LsVXsfdiiAUJVPRnSzJKpHLl+VxICEGB6Q4lw47sF+J
         1X/g==
X-Gm-Message-State: AOAM530h46jFh0EMGPeiFpy/ausrw8JXC21kuXsWYuRzizJzNFCblbBh
        DtITkuTkGHApmBXICXuapCf7fMo/IpkfCaMoBkChNo1l
X-Google-Smtp-Source: ABdhPJyFC49JCqUBFLGxZTICw/91v9XINR8ntdSLd19HgHz4dK87x98F9fgW7wEKqC32QU1eFvrk+kgrHAmcQd1hmZc=
X-Received: by 2002:a17:906:c143:: with SMTP id dp3mr931459ejc.499.1617759609648;
 Tue, 06 Apr 2021 18:40:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210405054848.GA1077931@in.ibm.com> <CAHbLzko-17bUWdxmOi-p2_MLSbsMCvhjKS1ktnBysC5dN_W90A@mail.gmail.com>
 <20210406100509.GA1354243@in.ibm.com>
In-Reply-To: <20210406100509.GA1354243@in.ibm.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 6 Apr 2021 18:39:57 -0700
Message-ID: <CAHbLzkoAGo=zdPW2cu0ZFyKq=sB5K8fN4oN48o8maPb-Dg=dhw@mail.gmail.com>
Subject: Re: High kmalloc-32 slab cache consumption with 10k containers
To:     Bharata B Rao <bharata@linux.ibm.com>
Cc:     Kirill Tkhai <ktkhai@virtuozzo.com>, Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        aneesh.kumar@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 6, 2021 at 3:05 AM Bharata B Rao <bharata@linux.ibm.com> wrote:
>
> On Mon, Apr 05, 2021 at 11:08:26AM -0700, Yang Shi wrote:
> > On Sun, Apr 4, 2021 at 10:49 PM Bharata B Rao <bharata@linux.ibm.com> wrote:
> > >
> > > Hi,
> > >
> > > When running 10000 (more-or-less-empty-)containers on a bare-metal Power9
> > > server(160 CPUs, 2 NUMA nodes, 256G memory), it is seen that memory
> > > consumption increases quite a lot (around 172G) when the containers are
> > > running. Most of it comes from slab (149G) and within slab, the majority of
> > > it comes from kmalloc-32 cache (102G)
> > >
> > > The major allocator of kmalloc-32 slab cache happens to be the list_head
> > > allocations of list_lru_one list. These lists are created whenever a
> > > FS mount happens. Specially two such lists are registered by alloc_super(),
> > > one for dentry and another for inode shrinker list. And these lists
> > > are created for all possible NUMA nodes and for all given memcgs
> > > (memcg_nr_cache_ids to be particular)
> > >
> > > If,
> > >
> > > A = Nr allocation request per mount: 2 (one for dentry and inode list)
> > > B = Nr NUMA possible nodes
> > > C = memcg_nr_cache_ids
> > > D = size of each kmalloc-32 object: 32 bytes,
> > >
> > > then for every mount, the amount of memory consumed by kmalloc-32 slab
> > > cache for list_lru creation is A*B*C*D bytes.
> >
> > Yes, this is exactly what the current implementation does.
> >
> > >
> > > Following factors contribute to the excessive allocations:
> > >
> > > - Lists are created for possible NUMA nodes.
> >
> > Yes, because filesystem caches (dentry and inode) are NUMA aware.
>
> True, but creating lists for possible nodes as against online nodes
> can hurt platforms where possible is typically higher than online.

I'm supposed just because hotplug doesn't handle memcg list_lru
creation/deletion.

Get much simpler and less-prone implementation by wasting some memory.

>
> >
> > > - memcg_nr_cache_ids grows in bulk (see memcg_alloc_cache_id() and additional
> > >   list_lrus are created when it grows. Thus we end up creating list_lru_one
> > >   list_heads even for those memcgs which are yet to be created.
> > >   For example, when 10000 memcgs are created, memcg_nr_cache_ids reach
> > >   a value of 12286.
> > > - When a memcg goes offline, the list elements are drained to the parent
> > >   memcg, but the list_head entry remains.
> > > - The lists are destroyed only when the FS is unmounted. So list_heads
> > >   for non-existing memcgs remain and continue to contribute to the
> > >   kmalloc-32 allocation. This is presumably done for performance
> > >   reason as they get reused when new memcgs are created, but they end up
> > >   consuming slab memory until then.
> >
> > The current implementation has list_lrus attached with super_block. So
> > the list can't be freed until the super block is unmounted.
> >
> > I'm looking into consolidating list_lrus more closely with memcgs. It
> > means the list_lrus will have the same life cycles as memcgs rather
> > than filesystems. This may be able to improve some. But I'm supposed
> > the filesystem will be unmounted once the container exits and the
> > memcgs will get offlined for your usecase.
>
> Yes, but when the containers are still running, the lists that get
> created for non-existing memcgs and non-relavent memcgs are the main
> cause of increased memory consumption.

Since kernel doesn't know about containers so kernel simply doesn't
know what memcgs are non-relevant.

>
> >
> > > - In case of containers, a few file systems get mounted and are specific
> > >   to the container namespace and hence to a particular memcg, but we
> > >   end up creating lists for all the memcgs.
> >
> > Yes, because the kernel is *NOT* aware of containers.
> >
> > >   As an example, if 7 FS mounts are done for every container and when
> > >   10k containers are created, we end up creating 2*7*12286 list_lru_one
> > >   lists for each NUMA node. It appears that no elements will get added
> > >   to other than 2*7=14 of them in the case of containers.
> > >
> > > One straight forward way to prevent this excessive list_lru_one
> > > allocations is to limit the list_lru_one creation only to the
> > > relevant memcg. However I don't see an easy way to figure out
> > > that relevant memcg from FS mount path (alloc_super())
> > >
> > > As an alternative approach, I have this below hack that does lazy
> > > list_lru creation. The memcg-specific list is created and initialized
> > > only when there is a request to add an element to that particular
> > > list. Though I am not sure about the full impact of this change
> > > on the owners of the lists and also the performance impact of this,
> > > the overall savings look good.
> >
> > It is fine to reduce the memory consumption for your usecase, but I'm
> > not sure if this would incur any noticeable overhead for vfs
> > operations since list_lru_add() should be called quite often, but it
> > just needs to allocate the list for once (for each memcg +
> > filesystem), so the overhead might be fine.
>
> Let me run some benchmarks to measure the overhead. Any particular
> benchmark suggestion?

Open/close files should manipulate list_lru.

>
> >
> > And I'm wondering how much memory can be saved for real life workload.
> > I don't expect most containers are idle in production environments.
>
> I don't think kmalloc-32 slab cache memory consumption from list_lru
> would be any different for real life workload compared to idle containers.

I don't mean the memory consumption itself. I mean the list is
typically not empty with real life workload so the memory is not
allocated in vain.

>
> >
> > Added some more memcg/list_lru experts in this loop, they may have better ideas.
>
> Thanks.
>
> Regards,
> Bharata.
