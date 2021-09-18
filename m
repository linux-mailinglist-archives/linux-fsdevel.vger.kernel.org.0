Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7D04104F4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Sep 2021 10:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243566AbhIRIBZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Sep 2021 04:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241775AbhIRIBZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Sep 2021 04:01:25 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14522C061757
        for <linux-fsdevel@vger.kernel.org>; Sat, 18 Sep 2021 01:00:02 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id u18so12042034pgf.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 18 Sep 2021 01:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LpJAvb2r/ypZU5FQrVW/iFzPACcNLQ13GoNWicSevGc=;
        b=XeZo/7cHcvVIjZlH/JJ+iSEorvYofxtg1I9uKERgtWRETsP5Q+FBsqKs6WJbYo93zn
         bucVdfSWE/C0O5QrU6kV1y5muj+qxF4W181zsCod+FAKOfMf71QyYj2Hng6gXNUWP/Vu
         hnuRZjOpmr9UL5/InNNY+c8Hrmj0ADj75KVxJcXlwrCx+O3O51WDiXqhlt2IdPXOlSAu
         RZ0b0mBTCufq4ij8if5CvRSuxENrWZi7RiIWLOVGEt7yHryp3PUoH3u1hXH1sjI/uR8o
         9wX4WGtrvU7o6C2VeogjO3CWRcHYLiLBbnCMtzQorDbhmdzbzl2KS0PitSZJaYoUJcU6
         P50w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LpJAvb2r/ypZU5FQrVW/iFzPACcNLQ13GoNWicSevGc=;
        b=GkTe30glmfON3LNXVsKsRoAt7uSi0NMPhe+kl/hh1R4jR7RYOiV1XCyipw1Ht/HH3R
         qYpdHE7s7znRuE6vfD3ezn4OY1hZsaZ+VEk6NSw22cwj4e2+L1rsP8y5sCsdDvHgHVtN
         J7bskPA5r4Xw17HKsf3w8AtsqyTvAYKYku+foBA5EzH2M/QWHIjipGn6HMdU+LWFQOJW
         f+ZKh/+4X0InmeYXWw3ilTX86nKTzrNpImvPSIulhb74XA2eT4+HsRzXRA+CFJOPCu7W
         OD7z4QK18Ixlu5qYRQidMjWgJOjVqxOLFRF3lzxv0biew1k3q0tiHDyGyBoFPvi08Lw7
         shaw==
X-Gm-Message-State: AOAM531gV4dLDgHzZ903xt/qxrzT1FakNM1io1nE/jH5FarmZ85J2R5d
        A2GersOKYBYRtN3TxOQNyR9mTZBJI88RXyhVexjMQg==
X-Google-Smtp-Source: ABdhPJwOPM9hyj8FUgewEtKSBa/GTOzwuER7HXnT5vEXHyjNKsPkpdr6kLQRUL63c8xt41iLm9rj2v67+a5GpMiHC0c=
X-Received: by 2002:a62:1717:0:b0:440:527f:6664 with SMTP id
 23-20020a621717000000b00440527f6664mr13602699pfx.73.1631952001524; Sat, 18
 Sep 2021 01:00:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210914072938.6440-1-songmuchun@bytedance.com> <20210918065624.dbaar4lss5olrfhu@kari-VirtualBox>
In-Reply-To: <20210918065624.dbaar4lss5olrfhu@kari-VirtualBox>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Sat, 18 Sep 2021 15:59:23 +0800
Message-ID: <CAMZfGtVT_Hp7rLtA81drA5AJ8mW=MJb1Ksox--D4bP5XPLqQDw@mail.gmail.com>
Subject: Re: [PATCH v3 00/76] Optimize list lru memory consumption
To:     Kari Argillander <kari.argillander@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>, Yang Shi <shy828301@gmail.com>,
        Alex Shi <alexs@kernel.org>,
        Wei Yang <richard.weiyang@gmail.com>,
        Dave Chinner <david@fromorbit.com>,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-nfs@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        fam.zheng@bytedance.com, Muchun Song <smuchun@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Sep 18, 2021 at 2:56 PM Kari Argillander
<kari.argillander@gmail.com> wrote:
>
> On Tue, Sep 14, 2021 at 03:28:22PM +0800, Muchun Song wrote:
> > We introduced alloc_inode_sb() in previous version 2, which sets up the
> > inode reclaim context properly, to allocate filesystems specific inode.
> > So we have to convert to new API for all filesystems, which is done in
> > one patch. Some filesystems are easy to convert (just replace
> > kmem_cache_alloc() to alloc_inode_sb()), while other filesystems need to
> > do more work. In order to make it easy for maintainers of different
> > filesystems to review their own maintained part, I split the patch into
> > patches which are per-filesystem in this version. I am not sure if this
> > is a good idea, because there is going to be more commits.
> >
> > In our server, we found a suspected memory leak problem. The kmalloc-32
> > consumes more than 6GB of memory. Other kmem_caches consume less than 2GB
> > memory.
> >
> > After our in-depth analysis, the memory consumption of kmalloc-32 slab
> > cache is the cause of list_lru_one allocation.
> >
> >   crash> p memcg_nr_cache_ids
> >   memcg_nr_cache_ids = $2 = 24574
> >
> > memcg_nr_cache_ids is very large and memory consumption of each list_lru
> > can be calculated with the following formula.
> >
> >   num_numa_node * memcg_nr_cache_ids * 32 (kmalloc-32)
> >
> > There are 4 numa nodes in our system, so each list_lru consumes ~3MB.
> >
> >   crash> list super_blocks | wc -l
> >   952
> >
> > Every mount will register 2 list lrus, one is for inode, another is for
> > dentry. There are 952 super_blocks. So the total memory is 952 * 2 * 3
> > MB (~5.6GB). But now the number of memory cgroups is less than 500. So I
> > guess more than 12286 memory cgroups have been created on this machine (I
> > do not know why there are so many cgroups, it may be a user's bug or
> > the user really want to do that). Because memcg_nr_cache_ids has not been
> > reduced to a suitable value. It leads to waste a lot of memory. If we want
> > to reduce memcg_nr_cache_ids, we have to *reboot* the server. This is not
> > what we want.
> >
> > In order to reduce memcg_nr_cache_ids, I had posted a patchset [1] to do
> > this. But this did not fundamentally solve the problem.
> >
> > We currently allocate scope for every memcg to be able to tracked on every
> > superblock instantiated in the system, regardless of whether that superblock
> > is even accessible to that memcg.
> >
> > These huge memcg counts come from container hosts where memcgs are confined
> > to just a small subset of the total number of superblocks that instantiated
> > at any given point in time.
> >
> > For these systems with huge container counts, list_lru does not need the
> > capability of tracking every memcg on every superblock.
> >
> > What it comes down to is that the list_lru is only needed for a given memcg
> > if that memcg is instatiating and freeing objects on a given list_lru.
> >
> > As Dave said, "Which makes me think we should be moving more towards 'add the
> > memcg to the list_lru at the first insert' model rather than 'instantiate
> > all at memcg init time just in case'."
> >
> > This patchset aims to optimize the list lru memory consumption from different
> > aspects.
> >
> > Patch 1-6 are code simplification.
> > Patch 7 converts the array from per-memcg per-node to per-memcg
> > Patch 8 introduces kmem_cache_alloc_lru()
> > Patch 9 introduces alloc_inode_sb()
> > Patch 10-66 convert all filesystems to alloc_inode_sb() respectively.
>
> There is now days also ntfs3. If you do not plan to convert this please
> CC me atleast so that I can do it when these lands.
>
>   Argillander
>

Wow, a new filesystem. I didn't notice it before. I'll cover it
in the next version and Cc you if you can do a review.
Thanks for your reminder.
