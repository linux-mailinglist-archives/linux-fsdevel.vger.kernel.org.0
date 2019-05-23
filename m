Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9CB28993
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2019 21:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390247AbfEWTVV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 May 2019 15:21:21 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43312 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390243AbfEWTVV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 May 2019 15:21:21 -0400
Received: by mail-pg1-f196.google.com with SMTP id f25so3621176pgv.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 May 2019 12:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lL8Te4jWRFgZjfe9/dkqTtpuaDV38VTY4jurjNdU+eQ=;
        b=nybCDTO7aDXRp6lHK7Rp/GekCdBec5nSv1vGPL7AsV7BWGRmMpr8oMX+SWJ6tqCnxp
         jt/EQgZyLg/K/j88u5FLG64/VrSYEosF8XbzFGIvlQJCMjRf0M8DXdqVQ0oUX3nK364w
         suGKmmBrQv6I+Xu5NLhb2xkCUBExbI9Af8wkA7jprY9/X+blZhxGA4E28OjASTZk8GlE
         Iahzb/L+uDs18U0kDAkmUp8qhJLYZ5F4/1UjoTtbJKk0g1iO165I9P6yIWQcw2GkvCbc
         fC/I9mmKEN1y/R3Bfw+KQcW7sGZmQYK5tAWCko8OOqiS3XuYAeb6IO5tzxQ3JFMAX/Md
         bKIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lL8Te4jWRFgZjfe9/dkqTtpuaDV38VTY4jurjNdU+eQ=;
        b=I4+jAS67ZiHF5tvlucRZKSRRn5d9Fd6uhOVPSf3i7iYHO+wVWSMs2bK24QbjUIx0D+
         zUhBQ1mFSOfmZjiTfYi7hMVAp3nUN5/G/rLuVz9PkIsm0kBcfjr9OJDaweVNAqlYxyyc
         xRhOruAOWO0oaW/e2sNWcmdDWpsKOVNdChBuQIZV1QyWIgMo9xAU/S/q9EQJa+qVVX+c
         NIXfBULXGEUVOSBvsRopNxmQqcNJN63nIWRqJ8dfSqRsjPN7ilve/WIBW3kxsMN+8Fdv
         jVHFtHX8k8IZvjVt/xtbgMBO9XZ+pCj89afuDouxNv0L9kelGRrphodc/ZW215gcEMfs
         oGeA==
X-Gm-Message-State: APjAAAVhG5WmAAtC3v9B/4GdIjQ1KvMrIpD2Z9ibDyH4Xy57hFegD+fW
        O0f4fNQjkAYgmsL8+8syNQMX4g==
X-Google-Smtp-Source: APXvYqzolr8W2Iv7H9NAdQP2LJzWG37v1LpW8TB3ML8vd7Zcc11Bv520V10CfeBPfFfhU5kPqIXneQ==
X-Received: by 2002:a63:1160:: with SMTP id 32mr100783894pgr.106.1558639280337;
        Thu, 23 May 2019 12:21:20 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::ece])
        by smtp.gmail.com with ESMTPSA id u6sm229294pfa.1.2019.05.23.12.21.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 May 2019 12:21:19 -0700 (PDT)
Date:   Thu, 23 May 2019 15:21:17 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: xarray breaks thrashing detection and cgroup isolation
Message-ID: <20190523192117.GA5723@cmpxchg.org>
References: <20190523174349.GA10939@cmpxchg.org>
 <20190523183713.GA14517@bombadil.infradead.org>
 <CALvZod4o0sA8CM961ZCCp-Vv+i6awFY0U07oJfXFDiVfFiaZfg@mail.gmail.com>
 <20190523190032.GA7873@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190523190032.GA7873@bombadil.infradead.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 23, 2019 at 12:00:32PM -0700, Matthew Wilcox wrote:
> On Thu, May 23, 2019 at 11:49:41AM -0700, Shakeel Butt wrote:
> > On Thu, May 23, 2019 at 11:37 AM Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > On Thu, May 23, 2019 at 01:43:49PM -0400, Johannes Weiner wrote:
> > > > I noticed that recent upstream kernels don't account the xarray nodes
> > > > of the page cache to the allocating cgroup, like we used to do for the
> > > > radix tree nodes.
> > > >
> > > > This results in broken isolation for cgrouped apps, allowing them to
> > > > escape their containment and harm other cgroups and the system with an
> > > > excessive build-up of nonresident information.
> > > >
> > > > It also breaks thrashing/refault detection because the page cache
> > > > lives in a different domain than the xarray nodes, and so the shadow
> > > > shrinker can reclaim nonresident information way too early when there
> > > > isn't much cache in the root cgroup.
> > > >
> > > > I'm not quite sure how to fix this, since the xarray code doesn't seem
> > > > to have per-tree gfp flags anymore like the radix tree did. We cannot
> > > > add SLAB_ACCOUNT to the radix_tree_node_cachep slab cache. And the
> > > > xarray api doesn't seem to really support gfp flags, either (xas_nomem
> > > > does, but the optimistic internal allocations have fixed gfp flags).
> > >
> > > Would it be a problem to always add __GFP_ACCOUNT to the fixed flags?
> > > I don't really understand cgroups.
> > 
> > Does xarray cache allocated nodes, something like radix tree's:
> > 
> > static DEFINE_PER_CPU(struct radix_tree_preload, radix_tree_preloads) = { 0, };
> > 
> > For the cached one, no __GFP_ACCOUNT flag.
> 
> No.  That was the point of the XArray conversion; no cached nodes.
> 
> > Also some users of xarray may not want __GFP_ACCOUNT. That's the
> > reason we had __GFP_ACCOUNT for page cache instead of hard coding it
> > in radix tree.
> 
> This is what I don't understand -- why would someone not want
> __GFP_ACCOUNT?  For a shared resource?  But the page cache is a shared
> resource.  So what is a good example of a time when an allocation should
> _not_ be accounted to the cgroup?

We used to cgroup-account every slab charge to cgroups per default,
until we changed it to a whitelist behavior:

commit b2a209ffa605994cbe3c259c8584ba1576d3310c
Author: Vladimir Davydov <vdavydov@virtuozzo.com>
Date:   Thu Jan 14 15:18:05 2016 -0800

    Revert "kernfs: do not account ino_ida allocations to memcg"
    
    Currently, all kmem allocations (namely every kmem_cache_alloc, kmalloc,
    alloc_kmem_pages call) are accounted to memory cgroup automatically.
    Callers have to explicitly opt out if they don't want/need accounting
    for some reason.  Such a design decision leads to several problems:
    
     - kmalloc users are highly sensitive to failures, many of them
       implicitly rely on the fact that kmalloc never fails, while memcg
       makes failures quite plausible.
    
     - A lot of objects are shared among different containers by design.
       Accounting such objects to one of containers is just unfair.
       Moreover, it might lead to pinning a dead memcg along with its kmem
       caches, which aren't tiny, which might result in noticeable increase
       in memory consumption for no apparent reason in the long run.
    
     - There are tons of short-lived objects. Accounting them to memcg will
       only result in slight noise and won't change the overall picture, but
       we still have to pay accounting overhead.
    
    For more info, see
    
     - http://lkml.kernel.org/r/20151105144002.GB15111%40dhcp22.suse.cz
     - http://lkml.kernel.org/r/20151106090555.GK29259@esperanza
    
    Therefore this patchset switches to the white list policy.  Now kmalloc
    users have to explicitly opt in by passing __GFP_ACCOUNT flag.
    
    Currently, the list of accounted objects is quite limited and only
    includes those allocations that (1) are known to be easily triggered
    from userspace and (2) can fail gracefully (for the full list see patch
    no.  6) and it still misses many object types.  However, accounting only
    those objects should be a satisfactory approximation of the behavior we
    used to have for most sane workloads.

The arguments would be the same here. Additional allocation overhead,
memory allocated on behalf of a shared facility, long-lived objects
pinning random, unrelated cgroups indefinitely.

The page cache is a sufficiently big user whose size can be directly
attributed to workload behavior, and can be controlled / reclaimed
under memory pressure. That's why it's accounted.

The same isn't true for random drivers using xarray, ida etc. It
shouldn't be implicit in the xarray semantics.
