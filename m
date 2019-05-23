Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB00228B29
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2019 22:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387940AbfEWT7j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 May 2019 15:59:39 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44471 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbfEWT7g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 May 2019 15:59:36 -0400
Received: by mail-pf1-f193.google.com with SMTP id g9so3817772pfo.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 May 2019 12:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QSvXlqZh92CDrRCYBDGQx4eYSubpSF2EcFX3zDPt80M=;
        b=pryOJBhyiO7VVwM16n1AKnkekdqfQoNbkE8NZkY8PJq5vw+4UsAvzQdtHQdwJq3EE9
         10TBJcHMjcAABWwN7zkuAe9PMoZJ5y1QDgyK2OSO8mZUeaSkr4W9a8GSwfeoTKbO6PGe
         O5/TpXqS4HdhgD6kTBfj9Fg40LnkDQF2hPsRN/uVaxFgSwSEv9ad4uJTmQgxT4KWXHxn
         UVYru/3Yh1e2bZDk2vLnVUixYqqq0oGOiuiLgSGdxEImjH2Yx57mfmQ/zfZVgrZvCxXA
         yOpN9Ki2QEzd51yxnisPMvCkL3AHQ47kRLVcURAAOyGrYW7AJL+2r0eQkhzqJDZR/zj5
         vioA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QSvXlqZh92CDrRCYBDGQx4eYSubpSF2EcFX3zDPt80M=;
        b=O0lqOrVTMKFs4moTDJx2Wkvere/D6+rmPLPa6QnnO1ICt8eWfTafGWVAppWa8xFqGO
         907XiZrg5lhii6liZYaayxXPt0Rk4rbU2UX/9CJNkJMunVTmhUkFPabEFt4jWlB2/XCe
         tcIN4frhlZjmcg1qRd7lUlJZFYTxuErlNPsnTW0cwLdbbu4rizfO7A8J1DvMXpfMaHXC
         lYQeIYyFBxlxoqCphDgx+2cRnQnAH6hE1g/Cb93Y49SvpO4QIRPcMGlNlRhzUWOGCByz
         3CyWUdy9z9hNb2ZMN31D+J76hjLOM+MN7lO016I27j6JzzGL4fpvzWBbpqWxttfhxIUB
         BnYw==
X-Gm-Message-State: APjAAAVZUAzdllITIh4bEm2UfwDka/WAAFDNjSOmX3EhOZ/YkicmU5xI
        srQK0tXGEgCLondx84mWt1LK4g==
X-Google-Smtp-Source: APXvYqxFNkJsMbFheL6ancg7wuEV7qoqvVC2Mn2u/kKsu0xAMk+ClLVXVY6G3K63f6CxnzjRFJx4Dw==
X-Received: by 2002:a17:90a:7f02:: with SMTP id k2mr3830549pjl.78.1558641575274;
        Thu, 23 May 2019 12:59:35 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::4958])
        by smtp.gmail.com with ESMTPSA id h32sm164706pgi.55.2019.05.23.12.59.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 May 2019 12:59:34 -0700 (PDT)
Date:   Thu, 23 May 2019 15:59:33 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: xarray breaks thrashing detection and cgroup isolation
Message-ID: <20190523195933.GA6404@cmpxchg.org>
References: <20190523174349.GA10939@cmpxchg.org>
 <20190523183713.GA14517@bombadil.infradead.org>
 <CALvZod4o0sA8CM961ZCCp-Vv+i6awFY0U07oJfXFDiVfFiaZfg@mail.gmail.com>
 <20190523190032.GA7873@bombadil.infradead.org>
 <20190523192117.GA5723@cmpxchg.org>
 <20190523194130.GA4598@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190523194130.GA4598@bombadil.infradead.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 23, 2019 at 12:41:30PM -0700, Matthew Wilcox wrote:
> On Thu, May 23, 2019 at 03:21:17PM -0400, Johannes Weiner wrote:
> > On Thu, May 23, 2019 at 12:00:32PM -0700, Matthew Wilcox wrote:
> > > On Thu, May 23, 2019 at 11:49:41AM -0700, Shakeel Butt wrote:
> > > > On Thu, May 23, 2019 at 11:37 AM Matthew Wilcox <willy@infradead.org> wrote:
> > > > > On Thu, May 23, 2019 at 01:43:49PM -0400, Johannes Weiner wrote:
> > > > > > I noticed that recent upstream kernels don't account the xarray nodes
> > > > > > of the page cache to the allocating cgroup, like we used to do for the
> > > > > > radix tree nodes.
> > > > > >
> > > > > > This results in broken isolation for cgrouped apps, allowing them to
> > > > > > escape their containment and harm other cgroups and the system with an
> > > > > > excessive build-up of nonresident information.
> > > > > >
> > > > > > It also breaks thrashing/refault detection because the page cache
> > > > > > lives in a different domain than the xarray nodes, and so the shadow
> > > > > > shrinker can reclaim nonresident information way too early when there
> > > > > > isn't much cache in the root cgroup.
> > > > > >
> > > > > > I'm not quite sure how to fix this, since the xarray code doesn't seem
> > > > > > to have per-tree gfp flags anymore like the radix tree did. We cannot
> > > > > > add SLAB_ACCOUNT to the radix_tree_node_cachep slab cache. And the
> > > > > > xarray api doesn't seem to really support gfp flags, either (xas_nomem
> > > > > > does, but the optimistic internal allocations have fixed gfp flags).
> > > > >
> > > > > Would it be a problem to always add __GFP_ACCOUNT to the fixed flags?
> > > > > I don't really understand cgroups.
> > > 
> > > > Also some users of xarray may not want __GFP_ACCOUNT. That's the
> > > > reason we had __GFP_ACCOUNT for page cache instead of hard coding it
> > > > in radix tree.
> > > 
> > > This is what I don't understand -- why would someone not want
> > > __GFP_ACCOUNT?  For a shared resource?  But the page cache is a shared
> > > resource.  So what is a good example of a time when an allocation should
> > > _not_ be accounted to the cgroup?
> > 
> > We used to cgroup-account every slab charge to cgroups per default,
> > until we changed it to a whitelist behavior:
> > 
> > commit b2a209ffa605994cbe3c259c8584ba1576d3310c
> > Author: Vladimir Davydov <vdavydov@virtuozzo.com>
> > Date:   Thu Jan 14 15:18:05 2016 -0800
> > 
> >     Revert "kernfs: do not account ino_ida allocations to memcg"
> >     
> >     Currently, all kmem allocations (namely every kmem_cache_alloc, kmalloc,
> >     alloc_kmem_pages call) are accounted to memory cgroup automatically.
> >     Callers have to explicitly opt out if they don't want/need accounting
> >     for some reason.  Such a design decision leads to several problems:
> >     
> >      - kmalloc users are highly sensitive to failures, many of them
> >        implicitly rely on the fact that kmalloc never fails, while memcg
> >        makes failures quite plausible.
> 
> Doesn't apply here.  The allocation under spinlock is expected to fail,
> and then we'll use xas_nomem() with the caller's specified GFP flags
> which may or may not include __GFP_ACCOUNT.
> 
> >      - A lot of objects are shared among different containers by design.
> >        Accounting such objects to one of containers is just unfair.
> >        Moreover, it might lead to pinning a dead memcg along with its kmem
> >        caches, which aren't tiny, which might result in noticeable increase
> >        in memory consumption for no apparent reason in the long run.
> 
> These objects are in the slab of radix_tree_nodes, and we'll already be
> accounting page cache nodes to the cgroup, so accounting random XArray
> nodes to the cgroups isn't going to make the problem worse.

There is no single radix_tree_nodes cache. When cgroup accounting is
requested, we clone per-cgroup instances of the slab cache each with
their own object slabs. The reclaimable page cache / shadow nodes do
not share slab pages with other radix tree users.

> >      - There are tons of short-lived objects. Accounting them to memcg will
> >        only result in slight noise and won't change the overall picture, but
> >        we still have to pay accounting overhead.
> 
> XArray nodes are generally not short-lived objects.

I'm not exactly sure what you're trying to argue.

My point is that we cannot have random drivers' internal data
structures charge to and pin cgroups indefinitely just because they
happen to do the modprobing or otherwise interact with the driver.

It makes no sense in terms of performance or cgroup semantics.
