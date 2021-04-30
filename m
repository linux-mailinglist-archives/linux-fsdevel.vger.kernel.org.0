Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E32036F728
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Apr 2021 10:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231314AbhD3IeH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Apr 2021 04:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbhD3IeG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Apr 2021 04:34:06 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9431C06174A
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Apr 2021 01:33:17 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id h7so7653649plt.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Apr 2021 01:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vssGAg/sTeYEvytxFlNmd3yOz+/EYCcIJtC9IEXz/LY=;
        b=wKpaF83caKmgfTQby3hfgOAh/Ux0dEU14brSn+SpDTvpFHnaLYMXAQtY+CkM2sJ1hm
         5sAZ6e1ipywqUUsKBXYp2HpQHlaYXdPUEbiD57C40+g5FHfcJ94RfDXJXkKtdVSVooqN
         +eADBHUdGYNYI15CjJvkdTgVziispoVKjB5owhGw1da+F4FtejMmPvOMircVYp+R1BYM
         GOoOb2h3vLyQvj49V/Tpz6tGrNFUQPtd3DrA7jmTBBRHFpR2mIeAY4U5sR+Qv0Cbgtdb
         9zuoaYsE6Mvaz3R+9yl1El9SO6gjgQOafdJGWiSenEDpQLEa3bEgWxukO4+vrVF6ll+5
         Xk1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vssGAg/sTeYEvytxFlNmd3yOz+/EYCcIJtC9IEXz/LY=;
        b=k3DtVYN2HK1xN8KgHqSdQUxCa23LUqrufRV/AjkM+B09hw+N/hBmxD0TcNXGbwue+L
         DUA+qqGDQ3yc29BE4K5NKUUqmy4T7RQ3rUnAh7DziwvtCIxusR5aEESt3xQnaOhVxV9i
         sSMd0NaBT+iiWPIX2UKBYhmUpdHf6u1PzBuf9sVDtN4gFAZfUUFRpOmTFvgwkx432Chu
         soZ3p7c+kQts69bH3FzSswIp89CAvqYIZonA/v8sKWB0B3xmHia/VRudFrnmGcmqR9TK
         eH3Bj7S78ExlAigZOUmY9m/DEO+hHlf6lDPl8neuXegoQLhA/+Pq+CcPJFI+OkmfD/EK
         T9Yg==
X-Gm-Message-State: AOAM531A5mcS7cN8RUsYIItaLwH0YittIHC8M52DrIIPInJuzF9iSZo3
        ROVQwcYr3OprAkepBekypabc20RBsqUOD7pB75vp+g==
X-Google-Smtp-Source: ABdhPJzg7Llraxup10A/y5Z2duNM5R/9xOPCS/zXXaOR8iNf5hQQzFA3K3MrlSTtTnNT2BruWrZqyQ0kubOmtrezjeo=
X-Received: by 2002:a17:90b:148c:: with SMTP id js12mr14128064pjb.147.1619771597250;
 Fri, 30 Apr 2021 01:33:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210428094949.43579-1-songmuchun@bytedance.com>
 <20210430004903.GF1872259@dread.disaster.area> <YItf3GIUs2skeuyi@carbon.dhcp.thefacebook.com>
 <20210430032739.GG1872259@dread.disaster.area>
In-Reply-To: <20210430032739.GG1872259@dread.disaster.area>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 30 Apr 2021 16:32:39 +0800
Message-ID: <CAMZfGtXawtMT4JfBtDLZ+hES4iEHFboe2UgJee_s-NhZR5faAw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 0/9] Shrink the list lru size on memory
 cgroup removal
To:     Dave Chinner <david@fromorbit.com>, Roman Gushchin <guro@fb.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <shy828301@gmail.com>, alexs@kernel.org,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 30, 2021 at 11:27 AM Dave Chinner <david@fromorbit.com> wrote:
>
> On Thu, Apr 29, 2021 at 06:39:40PM -0700, Roman Gushchin wrote:
> > On Fri, Apr 30, 2021 at 10:49:03AM +1000, Dave Chinner wrote:
> > > On Wed, Apr 28, 2021 at 05:49:40PM +0800, Muchun Song wrote:
> > > > In our server, we found a suspected memory leak problem. The kmalloc-32
> > > > consumes more than 6GB of memory. Other kmem_caches consume less than 2GB
> > > > memory.
> > > >
> > > > After our in-depth analysis, the memory consumption of kmalloc-32 slab
> > > > cache is the cause of list_lru_one allocation.
> > > >
> > > >   crash> p memcg_nr_cache_ids
> > > >   memcg_nr_cache_ids = $2 = 24574
> > > >
> > > > memcg_nr_cache_ids is very large and memory consumption of each list_lru
> > > > can be calculated with the following formula.
> > > >
> > > >   num_numa_node * memcg_nr_cache_ids * 32 (kmalloc-32)
> > > >
> > > > There are 4 numa nodes in our system, so each list_lru consumes ~3MB.
> > > >
> > > >   crash> list super_blocks | wc -l
> > > >   952
> > >
> > > The more I see people trying to work around this, the more I think
> > > that the way memcgs have been grafted into the list_lru is back to
> > > front.
> > >
> > > We currently allocate scope for every memcg to be able to tracked on
> > > every not on every superblock instantiated in the system, regardless
> > > of whether that superblock is even accessible to that memcg.
> > >
> > > These huge memcg counts come from container hosts where memcgs are
> > > confined to just a small subset of the total number of superblocks
> > > that instantiated at any given point in time.
> > >
> > > IOWs, for these systems with huge container counts, list_lru does
> > > not need the capability of tracking every memcg on every superblock.
> > >
> > > What it comes down to is that the list_lru is only needed for a
> > > given memcg if that memcg is instatiating and freeing objects on a
> > > given list_lru.
> > >
> > > Which makes me think we should be moving more towards "add the memcg
> > > to the list_lru at the first insert" model rather than "instantiate
> > > all at memcg init time just in case". The model we originally came
> > > up with for supprting memcgs is really starting to show it's limits,
> > > and we should address those limitations rahter than hack more
> > > complexity into the system that does nothing to remove the
> > > limitations that are causing the problems in the first place.
> >
> > I totally agree.
> >
> > It looks like the initial implementation of the whole kernel memory accounting
> > and memcg-aware shrinkers was based on the idea that the number of memory
> > cgroups is relatively small and stable.
>
> Yes, that was one of the original assumptions - tens to maybe low
> hundreds of memcgs at most. The other was that memcgs weren't NUMA
> aware, and so would only need a single LRU list per memcg. Hence the
> total overhead even with "lots" of memcgsi and superblocks the
> overhead wasn't that great.
>
> Then came "memcgs need to be NUMA aware" because of the size of the
> machines they were being use for resrouce management in, and that
> greatly increased the per-memcg, per LRU overhead. Now we're talking
> about needing to support a couple of orders of magnitude more memcgs
> and superblocks than were originally designed for.
>
> So, really, we're way beyond the original design scope of this
> subsystem now.

Got it. So it is better to allocate the structure of the list_lru_node
dynamically. We should only allocate it when it is really demanded.
But allocating memory by using GFP_ATOMIC in list_lru_add() is
not a good idea. So we should allocate the memory out of
list_lru_add(). I can propose an approach that may work.

Before start, we should know about the following rules of list lrus.

- Only objects allocated with __GFP_ACCOUNT need to allocate
  the struct list_lru_node.
- The caller of allocating memory must know which list_lru the
  object will insert.

So we can allocate struct list_lru_node when allocating the
object instead of allocating it when list_lru_add().  It is easy, because
we already know the list_lru and memcg which the object belongs
to. So we can introduce a new helper to allocate the object and
list_lru_node. Like below.

void *list_lru_kmem_cache_alloc(struct list_lru *lru, struct kmem_cache *s,
                                gfp_t gfpflags)
{
        void *ret = kmem_cache_alloc(s, gfpflags);

        if (ret && (gfpflags & __GFP_ACCOUNT)) {
                struct mem_cgroup *memcg = mem_cgroup_from_obj(ret);

                if (mem_cgroup_is_root(memcg))
                        return ret;

                /* Allocate per-memcg list_lru_node, if it already
allocated, do nothing. */
                memcg_list_lru_node_alloc(lru, memcg,
page_to_nid(virt_to_page(ret)), gfpflags);
        }

        return ret;
}

If the user wants to insert the allocated object to its lru list in
the feature. The
user should use list_lru_kmem_cache_alloc() instead of kmem_cache_alloc().
I have looked at the code closely. There are 3 different kmem_caches that
need to use this new API to allocate memory. They are inode_cachep,
dentry_cache and radix_tree_node_cachep. I think that it is easy to migrate.

Hi Roman and Dave,

What do you think about this approach? If there is no problem, I can provide
a preliminary patchset within a week.

Thanks.

>
> > With systemd creating a separate cgroup
> > for everything including short-living processes it simple not true anymore.
>
> Yeah, that too. Everything is much more dynamic these days...
>
> Cheers,
>
> Dave.
> --
> Dave Chinner
> david@fromorbit.com
