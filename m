Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7028B6C7755
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Mar 2023 06:27:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbjCXF1r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Mar 2023 01:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbjCXF13 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Mar 2023 01:27:29 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 547372F799
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Mar 2023 22:25:53 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id c18so853143ple.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Mar 2023 22:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112; t=1679635553;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZOSe/koJcjkHktX0rr7crEDi66LRf3WhlSwmQLHAVzA=;
        b=PWrFEKZopnA67LPaKGI89w1j4OjLsMHhcjqglyI6tBHCxYdRMT91TZPd/rO4m2aRuA
         ynr60F7IvDff17bwLZqb4SADXSOPo1GHeFafaiU4s0xFEoC26gfll8i85RIPRkgKVt8x
         yFtN+ZbOoA/H9oPfgWADAr6/AB4ed5/JJxnyP2szzytU3BzlmaihiuxGrpcdJvuXdDR/
         bcglN8oE877TBR2v6M91F5aVdeTiIPfQuNMxSctmrnZ/9sTjbaP6qKgRjH+TzQbKDs8v
         Cy1JZIj1Dm8QFNW1C9gNM1GJCwICIJpIQwUx2QmR6M6KOpxtAA1HboxeOHzwd8+NgXyd
         iBfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679635553;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZOSe/koJcjkHktX0rr7crEDi66LRf3WhlSwmQLHAVzA=;
        b=cNd9hNJR8rj9djqY+bHcow90cQlPGPC3Ip35QYQk6NBzhekn09mwBpRNfDh1fV6OHj
         U4yMRgEL/YK0JYiBxtxEEqVThKxsgWF6w4ltMKVX0rekNtgwNoAbbP4aqdgOVbKxePBG
         O7cHgmEqMyOc7rgD3bsLbS0hpebAjvSAcgtB0GnASid3XojZ+adJpRVDEl0SMJt2m05F
         97Wx21CzblON+PwB+uG9JbeDOw/h3ViEAbzxn4/dAiCwX7bLku87bBjnkK9CQpqyKVTQ
         URtAlvQgLxCDudgv1MNqnoh/jnn5Lg2vB50j9I4LnQROf34DfMlc/2MTolWHASAu7X0d
         gLsg==
X-Gm-Message-State: AO0yUKWhcRFZyN7bDDvOdr7RY/cJ1WSWAlg2oOmbmLQmIGsjNdBn11Bn
        el7UkCoHGzjf46s0RzQi0MIBig==
X-Google-Smtp-Source: AK7set9sYv5YB7BwvmynRa54P89VNQ136IM09dQO68KtmgBN0i+Bg3mHl0Lxh7MRmBLP24dES9Z0Vw==
X-Received: by 2002:a05:6a20:3949:b0:da:e9fa:9c29 with SMTP id r9-20020a056a20394900b000dae9fa9c29mr6366393pzg.26.1679635552709;
        Thu, 23 Mar 2023 22:25:52 -0700 (PDT)
Received: from destitution (pa49-181-91-157.pa.nsw.optusnet.com.au. [49.181.91.157])
        by smtp.gmail.com with ESMTPSA id d10-20020a634f0a000000b0050f56964426sm10559878pgb.54.2023.03.23.22.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 22:25:52 -0700 (PDT)
Received: from dave by destitution with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1pfZvn-001s69-0S;
        Fri, 24 Mar 2023 16:25:39 +1100
Date:   Fri, 24 Mar 2023 16:25:39 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <bhe@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH v2 2/4] mm: vmalloc: use rwsem, mutex for vmap_area_lock
 and vmap_block->lock
Message-ID: <ZB00U2S4g+VqzDPL@destitution>
References: <cover.1679209395.git.lstoakes@gmail.com>
 <6c7f1ac0aeb55faaa46a09108d3999e4595870d9.1679209395.git.lstoakes@gmail.com>
 <ZBkDuLKLhsOHNUeG@destitution>
 <ZBsAG5cpOFhFZZG6@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBsAG5cpOFhFZZG6@pc636>
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 22, 2023 at 02:18:19PM +0100, Uladzislau Rezki wrote:
> Hello, Dave.
> 
> > 
> > I'm travelling right now, but give me a few days and I'll test this
> > against the XFS workloads that hammer the global vmalloc spin lock
> > really, really badly. XFS can use vm_map_ram and vmalloc really
> > heavily for metadata buffers and hit the global spin lock from every
> > CPU in the system at the same time (i.e. highly concurrent
> > workloads). vmalloc is also heavily used in the hottest path
> > throught the journal where we process and calculate delta changes to
> > several million items every second, again spread across every CPU in
> > the system at the same time.
> > 
> > We really need the global spinlock to go away completely, but in the
> > mean time a shared read lock should help a little bit....
> > 
> Could you please share some steps how to run your workloads in order to
> touch vmalloc() code. I would like to have a look at it in more detail
> just for understanding the workloads.

Go search lore for the fsmark scalability benchmarks I've been
running for the past 12-13 years on XFS. Essentially they are high
concurency create/walk/modify/remove workloads on cold cache and
limited memory configurations. Essentially it's hammering caches
turning over inodes as fast as the system can possibly stream them
in and out of memory....

> <snip>
> urezki@pc638:~/data/raid0/coding/linux-rcu.git/fs/xfs$ grep -rn vmalloc ./
> ./xfs_log_priv.h:675: * Log vector and shadow buffers can be large, so we need to use kvmalloc() here
> ./xfs_log_priv.h:676: * to ensure success. Unfortunately, kvmalloc() only allows GFP_KERNEL contexts
> ./xfs_log_priv.h:677: * to fall back to vmalloc, so we can't actually do anything useful with gfp
> ./xfs_log_priv.h:678: * flags to control the kmalloc() behaviour within kvmalloc(). Hence kmalloc()
> ./xfs_log_priv.h:681: * vmalloc if it can't get somethign straight away from the free lists or
> ./xfs_log_priv.h:682: * buddy allocator. Hence we have to open code kvmalloc outselves here.
> ./xfs_log_priv.h:686: * allocations. This is actually the only way to make vmalloc() do GFP_NOFS
> ./xfs_log_priv.h:691:xlog_kvmalloc(

Did you read the comment above this function? I mean, it's all about
how poorly kvmalloc() works for the highly concurrent, fail-fast
context that occurs in the journal commit fast path, and how we open
code it with kmalloc and vmalloc to work "ok" in this path.

Then if you go look at the commits related to it, you might find
that XFS developers tend to write properly useful changelogs to
document things like "it's better, but vmalloc will soon have lock
contention problems if we hit it any harder"....

commit 8dc9384b7d75012856b02ff44c37566a55fc2abf
Author: Dave Chinner <dchinner@redhat.com>
Date:   Tue Jan 4 17:22:18 2022 -0800

    xfs: reduce kvmalloc overhead for CIL shadow buffers
    
    Oh, let me count the ways that the kvmalloc API sucks dog eggs.
    
    The problem is when we are logging lots of large objects, we hit
    kvmalloc really damn hard with costly order allocations, and
    behaviour utterly sucks:
    
         - 49.73% xlog_cil_commit
             - 31.62% kvmalloc_node
                - 29.96% __kmalloc_node
                   - 29.38% kmalloc_large_node
                      - 29.33% __alloc_pages
                         - 24.33% __alloc_pages_slowpath.constprop.0
                            - 18.35% __alloc_pages_direct_compact
                               - 17.39% try_to_compact_pages
                                  - compact_zone_order
                                     - 15.26% compact_zone
                                          5.29% __pageblock_pfn_to_page
                                          3.71% PageHuge
                                        - 1.44% isolate_migratepages_block
                                             0.71% set_pfnblock_flags_mask
                                       1.11% get_pfnblock_flags_mask
                               - 0.81% get_page_from_freelist
                                  - 0.59% _raw_spin_lock_irqsave
                                     - do_raw_spin_lock
                                          __pv_queued_spin_lock_slowpath
                            - 3.24% try_to_free_pages
                               - 3.14% shrink_node
                                  - 2.94% shrink_slab.constprop.0
                                     - 0.89% super_cache_count
                                        - 0.66% xfs_fs_nr_cached_objects
                                           - 0.65% xfs_reclaim_inodes_count
                                                0.55% xfs_perag_get_tag
                                       0.58% kfree_rcu_shrink_count
                            - 2.09% get_page_from_freelist
                               - 1.03% _raw_spin_lock_irqsave
                                  - do_raw_spin_lock
                                       __pv_queued_spin_lock_slowpath
                         - 4.88% get_page_from_freelist
                            - 3.66% _raw_spin_lock_irqsave
                               - do_raw_spin_lock
                                    __pv_queued_spin_lock_slowpath
                - 1.63% __vmalloc_node
                   - __vmalloc_node_range
                      - 1.10% __alloc_pages_bulk
                         - 0.93% __alloc_pages
                            - 0.92% get_page_from_freelist
                               - 0.89% rmqueue_bulk
                                  - 0.69% _raw_spin_lock
                                     - do_raw_spin_lock
                                          __pv_queued_spin_lock_slowpath
               13.73% memcpy_erms
             - 2.22% kvfree
    
    On this workload, that's almost a dozen CPUs all trying to compact
    and reclaim memory inside kvmalloc_node at the same time. Yet it is
    regularly falling back to vmalloc despite all that compaction, page
    and shrinker reclaim that direct reclaim is doing. Copying all the
    metadata is taking far less CPU time than allocating the storage!
    
    Direct reclaim should be considered extremely harmful.
    
    This is a high frequency, high throughput, CPU usage and latency
    sensitive allocation. We've got memory there, and we're using
    kvmalloc to allow memory allocation to avoid doing lots of work to
    try to do contiguous allocations.
    
    Except it still does *lots of costly work* that is unnecessary.
    
    Worse: the only way to avoid the slowpath page allocation trying to
    do compaction on costly allocations is to turn off direct reclaim
    (i.e. remove __GFP_RECLAIM_DIRECT from the gfp flags).
    
    Unfortunately, the stupid kvmalloc API then says "oh, this isn't a
    GFP_KERNEL allocation context, so you only get kmalloc!". This
    cuts off the vmalloc fallback, and this leads to almost instant OOM
    problems which ends up in filesystems deadlocks, shutdowns and/or
    kernel crashes.
    
    I want some basic kvmalloc behaviour:
    
    - kmalloc for a contiguous range with fail fast semantics - no
      compaction direct reclaim if the allocation enters the slow path.
    - run normal vmalloc (i.e. GFP_KERNEL) if kmalloc fails
    
    The really, really stupid part about this is these kvmalloc() calls
    are run under memalloc_nofs task context, so all the allocations are
    always reduced to GFP_NOFS regardless of the fact that kvmalloc
    requires GFP_KERNEL to be passed in. IOWs, we're already telling
    kvmalloc to behave differently to the gfp flags we pass in, but it
    still won't allow vmalloc to be run with anything other than
    GFP_KERNEL.
    
    So, this patch open codes the kvmalloc() in the commit path to have
    the above described behaviour. The result is we more than halve the
    CPU time spend doing kvmalloc() in this path and transaction commits
    with 64kB objects in them more than doubles. i.e. we get ~5x
    reduction in CPU usage per costly-sized kvmalloc() invocation and
    the profile looks like this:
    
      - 37.60% xlog_cil_commit
            16.01% memcpy_erms
          - 8.45% __kmalloc
             - 8.04% kmalloc_order_trace
                - 8.03% kmalloc_order
                   - 7.93% alloc_pages
                      - 7.90% __alloc_pages
                         - 4.05% __alloc_pages_slowpath.constprop.0
                            - 2.18% get_page_from_freelist
                            - 1.77% wake_all_kswapds
    ....
                                        - __wake_up_common_lock
                                           - 0.94% _raw_spin_lock_irqsave
                         - 3.72% get_page_from_freelist
                            - 2.43% _raw_spin_lock_irqsave
          - 5.72% vmalloc
             - 5.72% __vmalloc_node_range
                - 4.81% __get_vm_area_node.constprop.0
                   - 3.26% alloc_vmap_area
                      - 2.52% _raw_spin_lock
                   - 1.46% _raw_spin_lock
                  0.56% __alloc_pages_bulk
          - 4.66% kvfree
             - 3.25% vfree
                - __vfree
                   - 3.23% __vunmap
                      - 1.95% remove_vm_area
                         - 1.06% free_vmap_area_noflush
                            - 0.82% _raw_spin_lock
                         - 0.68% _raw_spin_lock
                      - 0.92% _raw_spin_lock
             - 1.40% kfree
                - 1.36% __free_pages
                   - 1.35% __free_pages_ok
                      - 1.02% _raw_spin_lock_irqsave
    
    It's worth noting that over 50% of the CPU time spent allocating
    these shadow buffers is now spent on spinlocks. So the shadow buffer
    allocation overhead is greatly reduced by getting rid of direct
    reclaim from kmalloc, and could probably be made even less costly if
    vmalloc() didn't use global spinlocks to protect it's structures.
    
    Signed-off-by: Dave Chinner <dchinner@redhat.com>
    Reviewed-by: Allison Henderson <allison.henderson@oracle.com>
    Reviewed-by: Darrick J. Wong <djwong@kernel.org>


-- 
Dave Chinner
david@fromorbit.com
