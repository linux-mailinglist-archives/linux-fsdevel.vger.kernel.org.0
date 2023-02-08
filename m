Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 790B868FA3F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Feb 2023 23:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbjBHW3A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Feb 2023 17:29:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbjBHW27 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Feb 2023 17:28:59 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE8125BA5
        for <linux-fsdevel@vger.kernel.org>; Wed,  8 Feb 2023 14:28:57 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id ud5so1209620ejc.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Feb 2023 14:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ib5c/bsJZ54uWK/+FTg2R7b7k0wvTx5UMSJ7W+JjDFE=;
        b=YnIBbf4Leim+riPvjYbm3Bga9EgoSnEztXn3WdITtnvrLP+4OwVafCURO2llmIQdMW
         a/p6VQWTvYv1sGq1xi9DUCoMZhAi3rsXdXbATv4tgqdLkqiBf/VHMT4YjYO9oUvBl4zy
         /dWDhYvQFnaisKr9s0PmsJEx32aOVXfljukKabsB3fKKf3jAO29qLWa/2B2Gs5OK9oUo
         WMS0HjJ1BUfgQF+Jbmp9Rgved8cwNqMMmFJswoFD5JWE58EJOGapfr/5+QI+i1gwdFJg
         OAXiyFrUXHamt7qUwp83s/oKoaAse6CzfK/69BVVOrUYES2t19DCOT689QcKntMhWRHT
         QiUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ib5c/bsJZ54uWK/+FTg2R7b7k0wvTx5UMSJ7W+JjDFE=;
        b=HfoYe9zAoTDBL6FEkRyF0gmRLbKthbrUlHbowPB+lqA0e0TWC1Hq7jMJEL+B5KXaS3
         pml/X9Nk7pWdLgFX0MhhethBYiTQDf11EUx1DNPFX8KTi5/fxrslQkR8/Bt10sUCBij8
         0gBz9w3+4E2tHYrF6qRBlAaBSf9xqsREw2rKtLuVEchTD1UyjhzWBS0O3uiFO+JBGmas
         qV1RM0RpOQihDArjaPyGWnz/xVXVbmqGnOKo3kZnKBKt9rDN/FZKrWlYWHVhyWCwTx9C
         rfTBE7hf4Tif9cL1TvfFSBPVO5QlBTZXhnY9L/ZQs/wGM40mFkWGMplOHaf6KIU/DyRk
         1Mpw==
X-Gm-Message-State: AO0yUKV8f5cKfwmA39FKL3VfO6pYazvQOFsxnu6hBqp1yNNoxCMuARGJ
        hJS99+vh1DOPDfGcxouzQFAilPkkFgNU4VSbFeoWxA==
X-Google-Smtp-Source: AK7set/klz+/+K+5uvcdwyOXyPe2jOmD3Ok/dY5y08NmZv/Ti/SqkeQdGPm1gOia1ol8RiSDbyLJ4hq9fKxrW7E4grc=
X-Received: by 2002:a17:906:37c2:b0:878:7bc7:958a with SMTP id
 o2-20020a17090637c200b008787bc7958amr2132625ejc.220.1675895335302; Wed, 08
 Feb 2023 14:28:55 -0800 (PST)
MIME-Version: 1.0
References: <20230202233229.3895713-1-yosryahmed@google.com>
 <20230203000057.GS360264@dread.disaster.area> <CAJD7tkazLFO8sc1Ly7+2_SGTxDq2XuPnvxxTnpQyXQELmq+m4A@mail.gmail.com>
 <Y90kK5jnxBbE9tV4@cmpxchg.org> <CAJD7tkZ7H-fGa3x3kbbdKgvzDDRZrGGZ6oazTA-7aNUQ7X1Pmg@mail.gmail.com>
 <20230204002613.f3ao52cpqf6wwxar@google.com>
In-Reply-To: <20230204002613.f3ao52cpqf6wwxar@google.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Wed, 8 Feb 2023 14:28:18 -0800
Message-ID: <CAJD7tkaQokU0ATVNoYTTwBzfmkrXbM+kx4gP8VdX3ZfxqMnGtQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1 0/2] Ignore non-LRU-based reclaim in memcg reclaim
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Dave Chinner <david@fromorbit.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Peter Xu <peterx@redhat.com>, NeilBrown <neilb@suse.de>,
        Michal Hocko <mhocko@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 3, 2023 at 4:26 PM Shakeel Butt <shakeelb@google.com> wrote:
>
> On Fri, Feb 03, 2023 at 07:28:49AM -0800, Yosry Ahmed wrote:
> > On Fri, Feb 3, 2023 at 7:11 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > >
> > > On Thu, Feb 02, 2023 at 04:17:18PM -0800, Yosry Ahmed wrote:
> > > > On Thu, Feb 2, 2023 at 4:01 PM Dave Chinner <david@fromorbit.com> wrote:
> > > > > > Patch 1 is just refactoring updating reclaim_state into a helper
> > > > > > function, and renames reclaimed_slab to just reclaimed, with a comment
> > > > > > describing its true purpose.
> > > > > >
> > > > > > Patch 2 ignores pages reclaimed outside of LRU reclaim in memcg reclaim.
> > > > > >
> > > > > > The original draft was a little bit different. It also kept track of
> > > > > > uncharged objcg pages, and reported them only in memcg reclaim and only
> > > > > > if the uncharged memcg is in the subtree of the memcg under reclaim.
> > > > > > This was an attempt to make reporting of memcg reclaim even more
> > > > > > accurate, but was dropped due to questionable complexity vs benefit
> > > > > > tradeoff. It can be revived if there is interest.
> > > > > >
> > > > > > Yosry Ahmed (2):
> > > > > >   mm: vmscan: refactor updating reclaimed pages in reclaim_state
> > > > > >   mm: vmscan: ignore non-LRU-based reclaim in memcg reclaim
> > > > > >
> > > > > >  fs/inode.c           |  3 +--
> > > > >
> > > > > Inodes and inode mapping pages are directly charged to the memcg
> > > > > that allocated them and the shrinker is correctly marked as
> > > > > SHRINKER_MEMCG_AWARE. Freeing the pages attached to the inode will
> > > > > account them correctly to the related memcg, regardless of which
> > > > > memcg is triggering the reclaim.  Hence I'm not sure that skipping
> > > > > the accounting of the reclaimed memory is even correct in this case;
> > > >
> > > > Please note that we are not skipping any accounting here. The pages
> > > > are still uncharged from the memcgs they are charged to (the allocator
> > > > memcgs as you pointed out). We just do not report them in the return
> > > > value of try_to_free_mem_cgroup_pages(), to avoid over-reporting.
> > >
> > > I was wondering the same thing as Dave, reading through this. But
> > > you're right, we'll catch the accounting during uncharge. Can you
> > > please add a comment on the !cgroup_reclaim() explaining this?
> >
> > Sure! If we settle on this implementation I will send another version
> > with a comment and fix the build problem in patch 2.
> >
> > >
> > > There is one wrinkle with this, though. We have the following
> > > (simplified) sequence during charging:
> > >
> > >         nr_reclaimed = try_to_free_mem_cgroup_pages(mem_over_limit, nr_pages,
> > >                                                     gfp_mask, reclaim_options);
> > >
> > >         if (mem_cgroup_margin(mem_over_limit) >= nr_pages)
> > >                 goto retry;
> > >
> > >         /*
> > >          * Even though the limit is exceeded at this point, reclaim
> > >          * may have been able to free some pages.  Retry the charge
> > >          * before killing the task.
> > >          *
> > >          * Only for regular pages, though: huge pages are rather
> > >          * unlikely to succeed so close to the limit, and we fall back
> > >          * to regular pages anyway in case of failure.
> > >          */
> > >         if (nr_reclaimed && nr_pages <= (1 << PAGE_ALLOC_COSTLY_ORDER))
> > >                 goto retry;
> > >
> > > So in the unlikely scenario where the first call doesn't make the
> > > necessary headroom, and the shrinkers are the only thing that made
> > > forward progress, we would OOM prematurely.
> > >
> > > Not that an OOM would seem that far away in that scenario, anyway. But I
> > > remember long discussions with DavidR on probabilistic OOM regressions ;)
> > >
> >
> > Above the if (nr_reclaimed...) check we have:
> >
> > if (gfp_mask & __GFP_NORETRY)
> >     goto nomem;
> >
> > , and below it we have:
> >
> > if (nr_retries--)
> >     goto retry;
> >
> > So IIUC we only prematurely OOM if we either have __GFP_NORETRY and
> > cannot reclaim any LRU pages in the first try, or if the scenario
> > where only shrinkers were successful to reclaim happens in the last
> > retry. Right?
> >
>
> We don't call oom-killer for __GFP_NORETRY. Also note that the retry
> (from nr_retries) after the reclaim includes page_counter_try_charge().
> So, even if try_to_free_mem_cgroup_pages() have returned 0 after
> reclaiming the slab memory of the memcg, the page_counter_try_charge()
> should succeed if the reclaimed slab objects have created enough margin.
>
> > > > > I think the code should still be accounting for all pages that
> > > > > belong to the memcg being scanned that are reclaimed, not ignoring
> > > > > them altogether...
> > > >
> > > > 100% agree. Ideally I would want to:
> > > > - For pruned inodes: report all freed pages for global reclaim, and
> > > > only report pages charged to the memcg under reclaim for memcg
> > > > reclaim.
> > >
> > > This only happens on highmem systems at this point, as elsewhere
> > > populated inodes aren't on the shrinker LRUs anymore. We'd probably be
> > > ok with a comment noting the inaccuracy in the proactive reclaim stats
> > > for the time being, until somebody actually cares about that combination.
> >
> > Interesting, I did not realize this. I guess in this case we may get
> > away with just ignoring non-LRU reclaimed pages in memcg reclaim
> > completely, or go an extra bit and report uncharged objcg pages in
> > memcg reclaim. See below.
> >
> > >
> > > > - For slab: report all freed pages for global reclaim, and only report
> > > > uncharged objcg pages from the memcg under reclaim for memcg reclaim.
> > > >
> > > > The only problem is that I thought people would think this is too much
> > > > complexity and not worth it. If people agree this should be the
> > > > approach to follow, I can prepare patches for this. I originally
> > > > implemented this for slab pages, but held off on sending it.
> > >
> > > I'd be curious to see the code!
> >
> > I think it is small enough to paste here. Basically instead of just
> > ignoring reclaim_state->reclaimed completely in patch 2, I counted
> > uncharged objcg pages only in memcg reclaim instead of freed slab
> > pages, and ignored pruned inode pages in memcg reclaim. So I guess we
> > can go with either:
> > - Just ignore freed slab pages and pages from pruned inodes in memcg
> > reclaim (current RFC).
> > - Ignore pruned inodes in memcg reclaim (as you explain above), and
> > use the following diff instead of patch 2 for slab.
> > - Use the following diff for slab AND properly report freed pages from
> > pruned inodes if they are relevant to the memcg under reclaim.
> >
> > Let me know what you think is best.
> >
>
> I would prefer the currect RFC instead of the other two options. Those
> options are slowing down (and adding complexity) to the uncharge code
> path for the accuracy which no one really need or should care about.
>
> > diff --git a/include/linux/swap.h b/include/linux/swap.h
> > index bc1d8b326453..37f799901dfb 100644
> > --- a/include/linux/swap.h
> > +++ b/include/linux/swap.h
> > @@ -162,6 +162,7 @@ struct reclaim_state {
> >  };
> >
> >  void report_freed_pages(unsigned long pages);
> > +bool report_uncharged_pages(unsigned long pages, struct mem_cgroup *memcg);
> >
> >  #ifdef __KERNEL__
> >
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index ab457f0394ab..a886ace70648 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -3080,6 +3080,13 @@ static void obj_cgroup_uncharge_pages(struct
> > obj_cgroup *objcg,
> >         memcg_account_kmem(memcg, -nr_pages);
> >         refill_stock(memcg, nr_pages);
> >
> > +       /*
> > +        * If undergoing memcg reclaim, report uncharged pages and drain local
> > +        * stock to update the memcg usage.
> > +        */
> > +       if (report_uncharged_pages(nr_pages, memcg))
> > +               drain_local_stock(NULL);
> > +
> >         css_put(&memcg->css);
> >  }
> >
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index 207998b16e5f..d4eced2b884b 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -204,17 +204,54 @@ static void set_task_reclaim_state(struct
> > task_struct *task,
> >         task->reclaim_state = rs;
> >  }
> >
> > +static bool cgroup_reclaim(struct scan_control *sc);
> > +
> >  /*
> >   * reclaim_report_freed_pages: report pages freed outside of LRU-based reclaim
> >   * @pages: number of pages freed
> >   *
> > - * If the current process is undergoing a reclaim operation,
> > + * If the current process is undergoing a non-cgroup reclaim operation,
> >   * increment the number of reclaimed pages by @pages.
> >   */
> >  void report_freed_pages(unsigned long pages)
> >  {
> > -       if (current->reclaim_state)
> > -               current->reclaim_state->reclaimed += pages;
> > +       struct reclaim_state *rs = current->reclaim_state;
> > +       struct scan_control *sc;
> > +
> > +       if (!rs)
> > +               return;
> > +
> > +       sc = container_of(rs, struct scan_control, reclaim_state);
> > +       if (!cgroup_reclaim(sc))
> > +               rs->reclaimed += pages;
> > +}
> > +
> > +/*
> > + * report_uncharged_pages: report pages uncharged outside of LRU-based reclaim
> > + * @pages: number of pages uncharged
> > + * @memcg: memcg pages were uncharged from
> > + *
> > + * If the current process is undergoing a cgroup reclaim operation, increment
> > + * the number of reclaimed pages by @pages, if the memcg under
> > reclaim is @memcg
> > + * or an ancestor of it.
> > + *
> > + * Returns true if an update was made.
> > + */
> > +bool report_uncharged_pages(unsigned long pages, struct mem_cgroup *memcg)
> > +{
> > +       struct reclaim_state *rs = current->reclaim_state;
> > +       struct scan_control *sc;
> > +
> > +       if (!rs)
> > +               return false;
> > +
> > +       sc = container_of(rs, struct scan_control, reclaim_state);
> > +       if (cgroup_reclaim(sc) &&
> > +           mem_cgroup_is_descendant(memcg, sc->target_mem_cgroup)) {
> > +               rs->reclaimed += pages;
> > +               return true;
> > +       }
> > +       return false;
> >  }
> >
> >  LIST_HEAD(shrinker_list);

Any further thoughts on this, whether to refresh the current RFC with
added comments (based on Johannes's feedback) and exporting
report_freed_pages() (based on Matthew's feedback), or to send a new
version with the code above that accurately counts objcg uncharged
pages in memcg reclaim?
