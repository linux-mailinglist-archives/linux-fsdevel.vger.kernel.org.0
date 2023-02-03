Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13835689DE0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Feb 2023 16:17:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233966AbjBCPRB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Feb 2023 10:17:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234668AbjBCPPd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Feb 2023 10:15:33 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97EA95CD3D
        for <linux-fsdevel@vger.kernel.org>; Fri,  3 Feb 2023 07:13:20 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id h24so5793749qtr.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Feb 2023 07:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SEpJ1jUZDdfyJlrWRH0MUqtupux6/xnXEoAuep6fT1o=;
        b=b36P5TVkE3Cj7mZuiHbApRHd6kcCvPcBfrmQSSGSVfVs5HEMoPasHoWqrYreaVOwOX
         ZVAFeeRHvBaa7OHwMP5xHSjlyGK8CoaDmd+KvIig8gLREeDEE6fNVDs39T1McQQgFdNb
         Vn0J3OlUGzhpn/HFD5hWVOkUCoJsuYsKNQy77+tS5NUMzpC/tuSEi97vuea1Sjw7eXkX
         1STe7Y546U350eEX1nXeGvN6bRx18vcfYoZcNLdGoG08b+erzSvnb1JVo9KVwp6zVRI1
         UXsyJ04l0JZITVZ9OLOswFN4hbhHgBMlg+MlPP+CXmygSFNe6k3YdwnaG38kkF5jlMS5
         2NLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SEpJ1jUZDdfyJlrWRH0MUqtupux6/xnXEoAuep6fT1o=;
        b=T2OCciCCvDAoTQPz9952q28XEaDgmep+MhQYXIg2WyVzG5I1OKSqtGgEu49IwrA8zj
         BsW4CGrx75zJyk3bzjTDdg29fZAEmElh+GxhTogwP4YvhdAdNuHQCmXIYUyriUdDKwWO
         uP+NGGeePNY0H4LhgY0V99q2UFnn1e+uSK6uk3d34JsLtV0Gy0hPb7MN1tXWznteim97
         8+3yj2a/oIjLIMIAyFUSSm5DtZtuD0ci31fLwdWhxSjprivc0N9K/SnlnFYEMSsKZ5L/
         UkkLLk/43d900C9fXxMp61RJeklDYr9HHfRis5rQArbmLpIMFY8EzagnW4XSzQCKwxca
         XhHg==
X-Gm-Message-State: AO0yUKWqRRHnPeenGJJaYsi88wZ1gTCzulLaGc3+TuE7xI9OHRIwQOWU
        8uMmsyr2X/D1cuKlNt7Ok1og+A==
X-Google-Smtp-Source: AK7set8kNeAz7t/GuiRI6DhuRD2fUDJlutbL3SVyVrLBMQ65pNOpE0jdTO5KHgFdNUUYMH4MXYkjFg==
X-Received: by 2002:a05:622a:1909:b0:3b6:2b38:e075 with SMTP id w9-20020a05622a190900b003b62b38e075mr18218491qtc.9.1675437101114;
        Fri, 03 Feb 2023 07:11:41 -0800 (PST)
Received: from localhost (2603-7000-0c01-2716-8f57-5681-ccd3-4a2e.res6.spectrum.com. [2603:7000:c01:2716:8f57:5681:ccd3:4a2e])
        by smtp.gmail.com with ESMTPSA id m11-20020ac8444b000000b003b2957fb45bsm1754141qtn.8.2023.02.03.07.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 07:11:40 -0800 (PST)
Date:   Fri, 3 Feb 2023 10:11:39 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Dave Chinner <david@fromorbit.com>,
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
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH v1 0/2] Ignore non-LRU-based reclaim in memcg reclaim
Message-ID: <Y90kK5jnxBbE9tV4@cmpxchg.org>
References: <20230202233229.3895713-1-yosryahmed@google.com>
 <20230203000057.GS360264@dread.disaster.area>
 <CAJD7tkazLFO8sc1Ly7+2_SGTxDq2XuPnvxxTnpQyXQELmq+m4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJD7tkazLFO8sc1Ly7+2_SGTxDq2XuPnvxxTnpQyXQELmq+m4A@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 02, 2023 at 04:17:18PM -0800, Yosry Ahmed wrote:
> On Thu, Feb 2, 2023 at 4:01 PM Dave Chinner <david@fromorbit.com> wrote:
> > > Patch 1 is just refactoring updating reclaim_state into a helper
> > > function, and renames reclaimed_slab to just reclaimed, with a comment
> > > describing its true purpose.
> > >
> > > Patch 2 ignores pages reclaimed outside of LRU reclaim in memcg reclaim.
> > >
> > > The original draft was a little bit different. It also kept track of
> > > uncharged objcg pages, and reported them only in memcg reclaim and only
> > > if the uncharged memcg is in the subtree of the memcg under reclaim.
> > > This was an attempt to make reporting of memcg reclaim even more
> > > accurate, but was dropped due to questionable complexity vs benefit
> > > tradeoff. It can be revived if there is interest.
> > >
> > > Yosry Ahmed (2):
> > >   mm: vmscan: refactor updating reclaimed pages in reclaim_state
> > >   mm: vmscan: ignore non-LRU-based reclaim in memcg reclaim
> > >
> > >  fs/inode.c           |  3 +--
> >
> > Inodes and inode mapping pages are directly charged to the memcg
> > that allocated them and the shrinker is correctly marked as
> > SHRINKER_MEMCG_AWARE. Freeing the pages attached to the inode will
> > account them correctly to the related memcg, regardless of which
> > memcg is triggering the reclaim.  Hence I'm not sure that skipping
> > the accounting of the reclaimed memory is even correct in this case;
> 
> Please note that we are not skipping any accounting here. The pages
> are still uncharged from the memcgs they are charged to (the allocator
> memcgs as you pointed out). We just do not report them in the return
> value of try_to_free_mem_cgroup_pages(), to avoid over-reporting.

I was wondering the same thing as Dave, reading through this. But
you're right, we'll catch the accounting during uncharge. Can you
please add a comment on the !cgroup_reclaim() explaining this?

There is one wrinkle with this, though. We have the following
(simplified) sequence during charging:

	nr_reclaimed = try_to_free_mem_cgroup_pages(mem_over_limit, nr_pages,
						    gfp_mask, reclaim_options);

	if (mem_cgroup_margin(mem_over_limit) >= nr_pages)
		goto retry;

	/*
	 * Even though the limit is exceeded at this point, reclaim
	 * may have been able to free some pages.  Retry the charge
	 * before killing the task.
	 *
	 * Only for regular pages, though: huge pages are rather
	 * unlikely to succeed so close to the limit, and we fall back
	 * to regular pages anyway in case of failure.
	 */
	if (nr_reclaimed && nr_pages <= (1 << PAGE_ALLOC_COSTLY_ORDER))
		goto retry;

So in the unlikely scenario where the first call doesn't make the
necessary headroom, and the shrinkers are the only thing that made
forward progress, we would OOM prematurely.

Not that an OOM would seem that far away in that scenario, anyway. But I
remember long discussions with DavidR on probabilistic OOM regressions ;)

> > I think the code should still be accounting for all pages that
> > belong to the memcg being scanned that are reclaimed, not ignoring
> > them altogether...
> 
> 100% agree. Ideally I would want to:
> - For pruned inodes: report all freed pages for global reclaim, and
> only report pages charged to the memcg under reclaim for memcg
> reclaim.

This only happens on highmem systems at this point, as elsewhere
populated inodes aren't on the shrinker LRUs anymore. We'd probably be
ok with a comment noting the inaccuracy in the proactive reclaim stats
for the time being, until somebody actually cares about that combination.

> - For slab: report all freed pages for global reclaim, and only report
> uncharged objcg pages from the memcg under reclaim for memcg reclaim.
> 
> The only problem is that I thought people would think this is too much
> complexity and not worth it. If people agree this should be the
> approach to follow, I can prepare patches for this. I originally
> implemented this for slab pages, but held off on sending it.

I'd be curious to see the code!
