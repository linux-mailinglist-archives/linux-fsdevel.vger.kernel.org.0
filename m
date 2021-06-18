Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF933AD0A8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jun 2021 18:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234605AbhFRQr3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Jun 2021 12:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231977AbhFRQr3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Jun 2021 12:47:29 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F21EAC061574
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Jun 2021 09:45:18 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id o20so7985651qtr.8
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Jun 2021 09:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zhxDRa6EWtJYP3lKt0pCUho1ZqoEa1wPdOdbZVUp4dA=;
        b=oBnIAq8FZoETZ/Q6SO+xt7o0sU1iDACqxIIu6E7UBmU0rP+8rNYPBvxfCxXgvRJRB8
         BB/fsGKsDr/dobViDkwJMAdrmJXcgtxFzVaFjFnOqxqlIyZt2unj0nZx3s8YtIkAOzjE
         J6r1KYVcBE2XZAYlaAWoT5u6gmQN1ox2MNdkZ53yEDvTwxoWkfC4ww9SNfpL0fkaJ4Q1
         oaXJCWro06eVW5fHvvdfTJEhdXt9GZTXP2iFjgThM6z9CRH1jMS11DSYUvM0hvfH16zr
         CK+mJpBlMwIyPFhDWYtuZK1VM/YhE0JdFYF5NT/hGDL2LEfthWu3BKzg6Xaxg23mY639
         2i3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zhxDRa6EWtJYP3lKt0pCUho1ZqoEa1wPdOdbZVUp4dA=;
        b=uLHJ7YlApSEGAACw9Qe5vy2uuQEM0a5f3b4hr8Qzorwwu2C/Ii9vQ5FlGEetuDo96C
         oTI6Zl9z1O5uQflXDC9UZ5IpGuBm2LFdkYgMBEIP4IuixSbSwbDsvra6HGp0BfOYlhca
         zzqdLRRUUC0sueyCZcx7tDSS1RFaeSTgwHTJGoy7IcNWCKfq9jDWFy3z4salklaMHofo
         jbydc1N6TWjAQjrIQKi5QWkd1t6E07377NzegmvF9RGDpIJzkgkDy5KWiVGqYxFapQ8g
         tsijCCU+nrM1PIy8e6NqqbZm5c3Ohv/P32eZ+ESUX7e85jxbGNyFTnPh5WtdbnGG1vRx
         n5Wg==
X-Gm-Message-State: AOAM533e4D/zRljfSMj8yAOC7CE7+K8iXLc4JzruZwJB9A0GM3xMb6xh
        8A9TsoCOy8wYjS5VYxZ1sstUoQ==
X-Google-Smtp-Source: ABdhPJy0OrBKg3G9RKcZXjrpCsLbqA/2Nt4dfuTXk1TRba68wuTqV/qu3UaKoA/wAr6MLZj4Jqk9LA==
X-Received: by 2002:a05:622a:392:: with SMTP id j18mr10418004qtx.195.1624034718120;
        Fri, 18 Jun 2021 09:45:18 -0700 (PDT)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id x80sm4404568qkb.3.2021.06.18.09.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 09:45:15 -0700 (PDT)
Date:   Fri, 18 Jun 2021 12:45:14 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Tejun Heo <tj@kernel.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 4/4] vfs: keep inodes with page cache off the inode
 shrinker LRU
Message-ID: <YMzNmpaFurN3+n6v@cmpxchg.org>
References: <20210614211904.14420-1-hannes@cmpxchg.org>
 <20210614211904.14420-4-hannes@cmpxchg.org>
 <20210615062640.GD2419729@dread.disaster.area>
 <YMj2YbqJvVh1busC@cmpxchg.org>
 <20210616012008.GE2419729@dread.disaster.area>
 <YMmD9xhBm9wGqYhf@cmpxchg.org>
 <20210617004942.GF2419729@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210617004942.GF2419729@dread.disaster.area>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 17, 2021 at 10:49:42AM +1000, Dave Chinner wrote:
> On Wed, Jun 16, 2021 at 12:54:15AM -0400, Johannes Weiner wrote:
> > On Wed, Jun 16, 2021 at 11:20:08AM +1000, Dave Chinner wrote:
> > > On Tue, Jun 15, 2021 at 02:50:09PM -0400, Johannes Weiner wrote:
> > > > On Tue, Jun 15, 2021 at 04:26:40PM +1000, Dave Chinner wrote:
> > > > > On Mon, Jun 14, 2021 at 05:19:04PM -0400, Johannes Weiner wrote:
> > > > > > @@ -1123,6 +1125,9 @@ static int __remove_mapping(struct address_space *mapping, struct page *page,
> > > > > >  			shadow = workingset_eviction(page, target_memcg);
> > > > > >  		__delete_from_page_cache(page, shadow);
> > > > > >  		xa_unlock_irq(&mapping->i_pages);
> > > > > > +		if (mapping_shrinkable(mapping))
> > > > > > +			inode_add_lru(mapping->host);
> > > > > > +		spin_unlock(&mapping->host->i_lock);
> > > > > >  
> > > > > 
> > > > > No. Inode locks have absolutely no place serialising core vmscan
> > > > > algorithms.
> > > > 
> > > > What if, and hear me out on this one, core vmscan algorithms change
> > > > the state of the inode?
> > > 
> > > Then the core vmscan algorithm has a layering violation.
> > 
> > You're just playing a word game here.
> 
> No, I've given you plenty of constructive justification and ways to
> restructure your patches to acheive what you say needs to be done.
> 
> You're the one that is rejecting any proposal I make outright and
> making unjustified claims that "I don't understand this code".

Hey, come on now. The argument I was making is that page cache state
is already used to update the inode LRU, and you incorrectly claimed
that this wasn't the case. My statement was a direct response to this
impasse, not a way to weasel out of your feedback.

> I haven't disagreed at all with what you are trying to do, nor do I
> think that being more selective about how we track inodes on the
> LRUs is a bad thing.

That's what it sounded like to me, but I'll chalk that up as a
misunderstanding then.

> What I'm commenting on is that the proposed changes are *really bad
> code*.

I'm not in love with it either, I can tell you that.

But it also depends on the alternatives. I don't want to fix one bug
and introduce a scalability issue. Or reintroduce subtle unforeseen
shrinker issues that had you revert the previous fix.

A revert, I might add, that could have been the incremental fix you
proposed here. Instead you glossed over Roman's rootcausing and
eintroduced the original bug. Now we're here, almost three years
later, still on square one.

So yeah, my priority is to get the behavior right first, and then
worry about architectural beauty within those constraints.

> If you can work out a *clean* way to move inodes onto the LRU when
> they are dirty then I'm all for it. But sprinkling inode->i_lock all
> over the mm/ subsystem and then adding seemling randomly placed
> inode lru manipulations isn't the way to do it.
>
> You should consider centralising all the work involved marking a
> mapping clean somewhere inside the mm/ code. Then add a single
> callout that does the inode LRU work, similar to how the
> fs-writeback.c code does it when the inode is marked clean by
> inode_sync_complete().

Yes, I'd prefer that as well. Let's look at the options.

The main source of complication is that the page cache cannot hold a
direct reference on the inode; holding the xa_lock or the i_lock is
the only thing that keeps the inode alive after we removed the page.

So our options are either overlapping the lock sections, or taking the
rcu readlock on the page cache side to bridge the deletion and the
inode callback - which then has to deal with the possibility that the
inode may have already been destroyed by the time it's called.

I would put the RCU thing aside for now as it sounds just a bit too
hairy, and too low-level an insight into the inode lifetime from the
mapping side. The xa_lock is also dropped in several outer entry
functions, so while it would clean up the fs side a bit, we wouldn't
reduce the blast radius on the MM side.

When we overlap lock sections, there are two options:

a) This patch, with the page cache lock nesting inside the i_lock. Or,

b) the way we handle dirty state: When we call set_page_dirty() ->
   mark_inode_dirty(), we hold the lock that serializes the page cache
   state when locking and updating the inode state. The hierarchy is:

       lock_page(page)                 # MM
         spin_lock(&inode->i_lock)     # FS

   The equivalent for this patch would be to have page_cache_delete()
   call mark_inode_empty() (or whatever name works for everybody),
   again under the lock that serializes the page cache state:

       xa_lock_irq(&mapping->i_pages)  # MM
         spin_lock(&inode->i_lock)     # FS

   There would be one central place calling into the fs with an API
   function, encapsulating i_lock handling in fs/inode.c.

   Great.

   The major caveat here is that i_lock would need to become IRQ safe
   in order to nest inside the xa_lock. It's not that the semantical
   layering of code here is new in any way, it's simply the lock type.

   As far as I can see, i_lock hold times are quite short - it's a
   spinlock after all. But I haven't reviewed all the sites yet, and
   there are a lot of them. They would all need to be updated.

   Likewise, list_lru locking needs to be made irq-safe. However,
   irqsafe spinlock is sort of the inevitable fate of any lock
   embedded in a data structure API. So I'm less concerned about that.

   AFAICS nothing else nests under i_lock.

If FS folks are fine with that, I would give that conversion a
shot. Lock type dependency aside, this would retain full modularity
and a clear delineation between mapping and inode property. It would
also be a fully locked scheme, so none of the subtleties of the
current patch. The end result seems clean and maintanable.
