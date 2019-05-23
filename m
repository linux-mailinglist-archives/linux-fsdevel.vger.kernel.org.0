Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B18F28638
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2019 21:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731491AbfEWTAf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 May 2019 15:00:35 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59642 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731261AbfEWTAf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 May 2019 15:00:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/CV1FhBU6ocaD5fOePWATFvyxYduYyIfBpfvSQwN/B8=; b=Miz1U9o2wXcym4Jtn1wzy+VUn
        4BJDF2kiponhBBRN/KFC/M/0I/Qr5ov6lMO9Mf5Zm7DnA/drcPmOna2euyKCsqRj/bZL9uIvcPKhY
        xRqkO46Ak525MvJjJSV98ayqh2zv2tkbQvjt+Oz8ptIzGb2UICnoz/YNjZPrKZFdhOqkwlo9hz5Ag
        V7bHvynIZUjN91dxR3oaRTqX6JHTfWbptGKyB5J28TfrS/yCOgTXrBmitaAhzM+KrELPYl1vC+100
        i4YZjccf377zAwdOuTpxCZufHXIPfo9aPCLr53mVS5BW7O7U0YOVAu4c0RyKUDxyyRjrF3347VNLB
        ImPknIcRg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hTsx7-0004yj-2H; Thu, 23 May 2019 19:00:33 +0000
Date:   Thu, 23 May 2019 12:00:32 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: xarray breaks thrashing detection and cgroup isolation
Message-ID: <20190523190032.GA7873@bombadil.infradead.org>
References: <20190523174349.GA10939@cmpxchg.org>
 <20190523183713.GA14517@bombadil.infradead.org>
 <CALvZod4o0sA8CM961ZCCp-Vv+i6awFY0U07oJfXFDiVfFiaZfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod4o0sA8CM961ZCCp-Vv+i6awFY0U07oJfXFDiVfFiaZfg@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 23, 2019 at 11:49:41AM -0700, Shakeel Butt wrote:
> On Thu, May 23, 2019 at 11:37 AM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Thu, May 23, 2019 at 01:43:49PM -0400, Johannes Weiner wrote:
> > > I noticed that recent upstream kernels don't account the xarray nodes
> > > of the page cache to the allocating cgroup, like we used to do for the
> > > radix tree nodes.
> > >
> > > This results in broken isolation for cgrouped apps, allowing them to
> > > escape their containment and harm other cgroups and the system with an
> > > excessive build-up of nonresident information.
> > >
> > > It also breaks thrashing/refault detection because the page cache
> > > lives in a different domain than the xarray nodes, and so the shadow
> > > shrinker can reclaim nonresident information way too early when there
> > > isn't much cache in the root cgroup.
> > >
> > > I'm not quite sure how to fix this, since the xarray code doesn't seem
> > > to have per-tree gfp flags anymore like the radix tree did. We cannot
> > > add SLAB_ACCOUNT to the radix_tree_node_cachep slab cache. And the
> > > xarray api doesn't seem to really support gfp flags, either (xas_nomem
> > > does, but the optimistic internal allocations have fixed gfp flags).
> >
> > Would it be a problem to always add __GFP_ACCOUNT to the fixed flags?
> > I don't really understand cgroups.
> 
> Does xarray cache allocated nodes, something like radix tree's:
> 
> static DEFINE_PER_CPU(struct radix_tree_preload, radix_tree_preloads) = { 0, };
> 
> For the cached one, no __GFP_ACCOUNT flag.

No.  That was the point of the XArray conversion; no cached nodes.

> Also some users of xarray may not want __GFP_ACCOUNT. That's the
> reason we had __GFP_ACCOUNT for page cache instead of hard coding it
> in radix tree.

This is what I don't understand -- why would someone not want
__GFP_ACCOUNT?  For a shared resource?  But the page cache is a shared
resource.  So what is a good example of a time when an allocation should
_not_ be accounted to the cgroup?
