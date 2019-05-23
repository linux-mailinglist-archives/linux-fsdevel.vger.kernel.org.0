Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4A2D289BD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2019 21:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390409AbfEWTlg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 May 2019 15:41:36 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47918 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389233AbfEWTlf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 May 2019 15:41:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Y4CF8VQ482x9+gF5CsOg/mXlQPERa3qs/eCs0oVRAJ8=; b=FtnxFgFCfEdc3mEAZAw8IsXF4
        jQpoZBQ3b80gdnApy4UED7IQOONKMYS3liEa9vqS1CyVy5xj44NkYARQJZJzFhXCmbAN9cLJAJ608
        4GU5MnZJHC16lhg91q/FopB9whBsFo1JoMQ5lrKNF57bReSLM1haCrprcPTP9OeZtlZ37LsiQNprS
        bwFpdZ2W/fn+2lbz0zu+AO4SigjcCkqknzEFb0W/ZgQhQLl05fTV6EKHV4e154+YQOMRD5Cq56KQj
        Yj4UsROp60Rm9vYLIgIjw6l/ItZUFWDZyYwz4+ryzdVyOrM1ewvkWJoDv7Aiqlj+C4h5XpDfleN1E
        JsFu9hqfA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hTtak-000431-T7; Thu, 23 May 2019 19:41:30 +0000
Date:   Thu, 23 May 2019 12:41:30 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: xarray breaks thrashing detection and cgroup isolation
Message-ID: <20190523194130.GA4598@bombadil.infradead.org>
References: <20190523174349.GA10939@cmpxchg.org>
 <20190523183713.GA14517@bombadil.infradead.org>
 <CALvZod4o0sA8CM961ZCCp-Vv+i6awFY0U07oJfXFDiVfFiaZfg@mail.gmail.com>
 <20190523190032.GA7873@bombadil.infradead.org>
 <20190523192117.GA5723@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190523192117.GA5723@cmpxchg.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 23, 2019 at 03:21:17PM -0400, Johannes Weiner wrote:
> On Thu, May 23, 2019 at 12:00:32PM -0700, Matthew Wilcox wrote:
> > On Thu, May 23, 2019 at 11:49:41AM -0700, Shakeel Butt wrote:
> > > On Thu, May 23, 2019 at 11:37 AM Matthew Wilcox <willy@infradead.org> wrote:
> > > > On Thu, May 23, 2019 at 01:43:49PM -0400, Johannes Weiner wrote:
> > > > > I noticed that recent upstream kernels don't account the xarray nodes
> > > > > of the page cache to the allocating cgroup, like we used to do for the
> > > > > radix tree nodes.
> > > > >
> > > > > This results in broken isolation for cgrouped apps, allowing them to
> > > > > escape their containment and harm other cgroups and the system with an
> > > > > excessive build-up of nonresident information.
> > > > >
> > > > > It also breaks thrashing/refault detection because the page cache
> > > > > lives in a different domain than the xarray nodes, and so the shadow
> > > > > shrinker can reclaim nonresident information way too early when there
> > > > > isn't much cache in the root cgroup.
> > > > >
> > > > > I'm not quite sure how to fix this, since the xarray code doesn't seem
> > > > > to have per-tree gfp flags anymore like the radix tree did. We cannot
> > > > > add SLAB_ACCOUNT to the radix_tree_node_cachep slab cache. And the
> > > > > xarray api doesn't seem to really support gfp flags, either (xas_nomem
> > > > > does, but the optimistic internal allocations have fixed gfp flags).
> > > >
> > > > Would it be a problem to always add __GFP_ACCOUNT to the fixed flags?
> > > > I don't really understand cgroups.
> > 
> > > Also some users of xarray may not want __GFP_ACCOUNT. That's the
> > > reason we had __GFP_ACCOUNT for page cache instead of hard coding it
> > > in radix tree.
> > 
> > This is what I don't understand -- why would someone not want
> > __GFP_ACCOUNT?  For a shared resource?  But the page cache is a shared
> > resource.  So what is a good example of a time when an allocation should
> > _not_ be accounted to the cgroup?
> 
> We used to cgroup-account every slab charge to cgroups per default,
> until we changed it to a whitelist behavior:
> 
> commit b2a209ffa605994cbe3c259c8584ba1576d3310c
> Author: Vladimir Davydov <vdavydov@virtuozzo.com>
> Date:   Thu Jan 14 15:18:05 2016 -0800
> 
>     Revert "kernfs: do not account ino_ida allocations to memcg"
>     
>     Currently, all kmem allocations (namely every kmem_cache_alloc, kmalloc,
>     alloc_kmem_pages call) are accounted to memory cgroup automatically.
>     Callers have to explicitly opt out if they don't want/need accounting
>     for some reason.  Such a design decision leads to several problems:
>     
>      - kmalloc users are highly sensitive to failures, many of them
>        implicitly rely on the fact that kmalloc never fails, while memcg
>        makes failures quite plausible.

Doesn't apply here.  The allocation under spinlock is expected to fail,
and then we'll use xas_nomem() with the caller's specified GFP flags
which may or may not include __GFP_ACCOUNT.

>      - A lot of objects are shared among different containers by design.
>        Accounting such objects to one of containers is just unfair.
>        Moreover, it might lead to pinning a dead memcg along with its kmem
>        caches, which aren't tiny, which might result in noticeable increase
>        in memory consumption for no apparent reason in the long run.

These objects are in the slab of radix_tree_nodes, and we'll already be
accounting page cache nodes to the cgroup, so accounting random XArray
nodes to the cgroups isn't going to make the problem worse.

>      - There are tons of short-lived objects. Accounting them to memcg will
>        only result in slight noise and won't change the overall picture, but
>        we still have to pay accounting overhead.

XArray nodes are generally not short-lived objects.

