Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2E1E35468B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Apr 2021 20:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232797AbhDESIq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Apr 2021 14:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbhDESIq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Apr 2021 14:08:46 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAAD9C061788;
        Mon,  5 Apr 2021 11:08:39 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id f8so9462515edd.11;
        Mon, 05 Apr 2021 11:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tmgk94hGPMJZ0DJfUDyT8lY/33hyIlSDNP2Z5DjB0u0=;
        b=g9Wap+Q15k1ReSr/I3Z3xioAF+6JrjhlTY46wJOQLoUkgoIkcC3jseuWKhtuyEzEQV
         +9J7uCxdixfj/IxgT5yTJWXHKYUsMEyh3M9FJkPXKKxGQnFlb2zpsF6CGXUQmttByLNR
         cvvMZlQdS89AmAASB7yBBayHxD2/H8Vikk9lvVRJcVS+ywSwmGsEuzH2H6hxChkMmaMJ
         kQ8VGsT2DgCVljwdCaoyJCt/e4otenG/fTghHCnuodhClFRtEu+1sjCBP/H7IJQXsRZ0
         TIbTtSHbw5wdtwJsNHE3SqvxowrDNo63opL9OOvAkYlKgndjlxiHF7ENxLRwbr06QJmB
         6KuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tmgk94hGPMJZ0DJfUDyT8lY/33hyIlSDNP2Z5DjB0u0=;
        b=A0jIeQcn+rUsQfRZQZM2h//DpgyFoQgn8StZ74blLUuF0RbMMULNjuex/qjjvXLc3P
         lf9mJHERG4opbXsJvfRnLgsas3t6WvN23XoaVKHyoRS9gJ7zqFS2ndefjazudKDjw471
         V5ilM5QJTthFtrjGNQ6qpEYb3GIzP8/1FI7U+LUZqhlmLX1WW9sWfvKpPlOIRwjXBjDL
         DDBuNSm3KG/XTf8pmJtPy2b1mMR54atTFx6IdOP5Me5W1pccfhsDUsIAb340q98TCAc0
         Tz+pkOJx/ZIv/T80OVcEJPQtbKIa4P6oiQogfSFvxk4y/nQ3sYNEu9l54M7ef6rEioV+
         m3ow==
X-Gm-Message-State: AOAM532LZSUxpbMvM6wE54F/qyEWhg3RRqH4mR1hr/UxVe1l0woj+Fmr
        XaIOCxtvVAxb1pIhWgxJ0HyG8s5mPEHGvioscrM=
X-Google-Smtp-Source: ABdhPJzFh/IEaJgbODhBxizGE6MiP5lU8uPS6w3cunO1s+x7Za/pdEjnP6iPzLURd12FFiEAJHwYl6VNuGG+G4FHpn4=
X-Received: by 2002:a05:6402:518d:: with SMTP id q13mr33136364edd.313.1617646118553;
 Mon, 05 Apr 2021 11:08:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210405054848.GA1077931@in.ibm.com>
In-Reply-To: <20210405054848.GA1077931@in.ibm.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 5 Apr 2021 11:08:26 -0700
Message-ID: <CAHbLzko-17bUWdxmOi-p2_MLSbsMCvhjKS1ktnBysC5dN_W90A@mail.gmail.com>
Subject: Re: High kmalloc-32 slab cache consumption with 10k containers
To:     Bharata B Rao <bharata@linux.ibm.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        aneesh.kumar@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Apr 4, 2021 at 10:49 PM Bharata B Rao <bharata@linux.ibm.com> wrote:
>
> Hi,
>
> When running 10000 (more-or-less-empty-)containers on a bare-metal Power9
> server(160 CPUs, 2 NUMA nodes, 256G memory), it is seen that memory
> consumption increases quite a lot (around 172G) when the containers are
> running. Most of it comes from slab (149G) and within slab, the majority of
> it comes from kmalloc-32 cache (102G)
>
> The major allocator of kmalloc-32 slab cache happens to be the list_head
> allocations of list_lru_one list. These lists are created whenever a
> FS mount happens. Specially two such lists are registered by alloc_super(),
> one for dentry and another for inode shrinker list. And these lists
> are created for all possible NUMA nodes and for all given memcgs
> (memcg_nr_cache_ids to be particular)
>
> If,
>
> A = Nr allocation request per mount: 2 (one for dentry and inode list)
> B = Nr NUMA possible nodes
> C = memcg_nr_cache_ids
> D = size of each kmalloc-32 object: 32 bytes,
>
> then for every mount, the amount of memory consumed by kmalloc-32 slab
> cache for list_lru creation is A*B*C*D bytes.

Yes, this is exactly what the current implementation does.

>
> Following factors contribute to the excessive allocations:
>
> - Lists are created for possible NUMA nodes.

Yes, because filesystem caches (dentry and inode) are NUMA aware.

> - memcg_nr_cache_ids grows in bulk (see memcg_alloc_cache_id() and additional
>   list_lrus are created when it grows. Thus we end up creating list_lru_one
>   list_heads even for those memcgs which are yet to be created.
>   For example, when 10000 memcgs are created, memcg_nr_cache_ids reach
>   a value of 12286.
> - When a memcg goes offline, the list elements are drained to the parent
>   memcg, but the list_head entry remains.
> - The lists are destroyed only when the FS is unmounted. So list_heads
>   for non-existing memcgs remain and continue to contribute to the
>   kmalloc-32 allocation. This is presumably done for performance
>   reason as they get reused when new memcgs are created, but they end up
>   consuming slab memory until then.

The current implementation has list_lrus attached with super_block. So
the list can't be freed until the super block is unmounted.

I'm looking into consolidating list_lrus more closely with memcgs. It
means the list_lrus will have the same life cycles as memcgs rather
than filesystems. This may be able to improve some. But I'm supposed
the filesystem will be unmounted once the container exits and the
memcgs will get offlined for your usecase.

> - In case of containers, a few file systems get mounted and are specific
>   to the container namespace and hence to a particular memcg, but we
>   end up creating lists for all the memcgs.

Yes, because the kernel is *NOT* aware of containers.

>   As an example, if 7 FS mounts are done for every container and when
>   10k containers are created, we end up creating 2*7*12286 list_lru_one
>   lists for each NUMA node. It appears that no elements will get added
>   to other than 2*7=14 of them in the case of containers.
>
> One straight forward way to prevent this excessive list_lru_one
> allocations is to limit the list_lru_one creation only to the
> relevant memcg. However I don't see an easy way to figure out
> that relevant memcg from FS mount path (alloc_super())
>
> As an alternative approach, I have this below hack that does lazy
> list_lru creation. The memcg-specific list is created and initialized
> only when there is a request to add an element to that particular
> list. Though I am not sure about the full impact of this change
> on the owners of the lists and also the performance impact of this,
> the overall savings look good.

It is fine to reduce the memory consumption for your usecase, but I'm
not sure if this would incur any noticeable overhead for vfs
operations since list_lru_add() should be called quite often, but it
just needs to allocate the list for once (for each memcg +
filesystem), so the overhead might be fine.

And I'm wondering how much memory can be saved for real life workload.
I don't expect most containers are idle in production environments.

Added some more memcg/list_lru experts in this loop, they may have better ideas.

>
> Used memory
>                 Before          During          After
> W/o patch       23G             172G            40G
> W/  patch       23G             69G             29G
>
> Slab consumption
>                 Before          During          After
> W/o patch       1.5G            149G            22G
> W/  patch       1.5G            45G             10G
>
> Number of kmalloc-32 allocations
>                 Before          During          After
> W/o patch       178176          3442409472      388933632
> W/  patch       190464          468992          468992
>
> Any thoughts on other approaches to address this scenario and
> any specific comments about the approach that I have taken is
> appreciated. Meanwhile the patch looks like below:
>
> From 9444a0c6734c2853057b1f486f85da2c409fdc84 Mon Sep 17 00:00:00 2001
> From: Bharata B Rao <bharata@linux.ibm.com>
> Date: Wed, 31 Mar 2021 18:21:45 +0530
> Subject: [PATCH 1/1] mm: list_lru: Allocate list_lru_one only when required.
>
> Don't pre-allocate list_lru_one list heads for all memcg_cache_ids.
> Instead allocate and initialize it only when required.
>
> Signed-off-by: Bharata B Rao <bharata@linux.ibm.com>
> ---
>  mm/list_lru.c | 79 +++++++++++++++++++++++++--------------------------
>  1 file changed, 38 insertions(+), 41 deletions(-)
>
> diff --git a/mm/list_lru.c b/mm/list_lru.c
> index 6f067b6b935f..b453fa5008cc 100644
> --- a/mm/list_lru.c
> +++ b/mm/list_lru.c
> @@ -112,16 +112,32 @@ list_lru_from_kmem(struct list_lru_node *nlru, void *ptr,
>  }
>  #endif /* CONFIG_MEMCG_KMEM */
>
> +static void init_one_lru(struct list_lru_one *l)
> +{
> +       INIT_LIST_HEAD(&l->list);
> +       l->nr_items = 0;
> +}
> +
>  bool list_lru_add(struct list_lru *lru, struct list_head *item)
>  {
>         int nid = page_to_nid(virt_to_page(item));
>         struct list_lru_node *nlru = &lru->node[nid];
>         struct mem_cgroup *memcg;
>         struct list_lru_one *l;
> +       struct list_lru_memcg *memcg_lrus;
>
>         spin_lock(&nlru->lock);
>         if (list_empty(item)) {
>                 l = list_lru_from_kmem(nlru, item, &memcg);
> +               if (!l) {
> +                       l = kmalloc(sizeof(struct list_lru_one), GFP_ATOMIC);
> +                       if (!l)
> +                               goto out;
> +
> +                       init_one_lru(l);
> +                       memcg_lrus = rcu_dereference_protected(nlru->memcg_lrus, true);
> +                       memcg_lrus->lru[memcg_cache_id(memcg)] = l;
> +               }
>                 list_add_tail(item, &l->list);
>                 /* Set shrinker bit if the first element was added */
>                 if (!l->nr_items++)
> @@ -131,6 +147,7 @@ bool list_lru_add(struct list_lru *lru, struct list_head *item)
>                 spin_unlock(&nlru->lock);
>                 return true;
>         }
> +out:
>         spin_unlock(&nlru->lock);
>         return false;
>  }
> @@ -176,11 +193,12 @@ unsigned long list_lru_count_one(struct list_lru *lru,
>  {
>         struct list_lru_node *nlru = &lru->node[nid];
>         struct list_lru_one *l;
> -       unsigned long count;
> +       unsigned long count = 0;
>
>         rcu_read_lock();
>         l = list_lru_from_memcg_idx(nlru, memcg_cache_id(memcg));
> -       count = READ_ONCE(l->nr_items);
> +       if (l)
> +               count = READ_ONCE(l->nr_items);
>         rcu_read_unlock();
>
>         return count;
> @@ -207,6 +225,9 @@ __list_lru_walk_one(struct list_lru_node *nlru, int memcg_idx,
>         unsigned long isolated = 0;
>
>         l = list_lru_from_memcg_idx(nlru, memcg_idx);
> +       if (!l)
> +               goto out;
> +
>  restart:
>         list_for_each_safe(item, n, &l->list) {
>                 enum lru_status ret;
> @@ -251,6 +272,7 @@ __list_lru_walk_one(struct list_lru_node *nlru, int memcg_idx,
>                         BUG();
>                 }
>         }
> +out:
>         return isolated;
>  }
>
> @@ -312,12 +334,6 @@ unsigned long list_lru_walk_node(struct list_lru *lru, int nid,
>  }
>  EXPORT_SYMBOL_GPL(list_lru_walk_node);
>
> -static void init_one_lru(struct list_lru_one *l)
> -{
> -       INIT_LIST_HEAD(&l->list);
> -       l->nr_items = 0;
> -}
> -
>  #ifdef CONFIG_MEMCG_KMEM
>  static void __memcg_destroy_list_lru_node(struct list_lru_memcg *memcg_lrus,
>                                           int begin, int end)
> @@ -328,41 +344,16 @@ static void __memcg_destroy_list_lru_node(struct list_lru_memcg *memcg_lrus,
>                 kfree(memcg_lrus->lru[i]);
>  }
>
> -static int __memcg_init_list_lru_node(struct list_lru_memcg *memcg_lrus,
> -                                     int begin, int end)
> -{
> -       int i;
> -
> -       for (i = begin; i < end; i++) {
> -               struct list_lru_one *l;
> -
> -               l = kmalloc(sizeof(struct list_lru_one), GFP_KERNEL);
> -               if (!l)
> -                       goto fail;
> -
> -               init_one_lru(l);
> -               memcg_lrus->lru[i] = l;
> -       }
> -       return 0;
> -fail:
> -       __memcg_destroy_list_lru_node(memcg_lrus, begin, i);
> -       return -ENOMEM;
> -}
> -
>  static int memcg_init_list_lru_node(struct list_lru_node *nlru)
>  {
>         struct list_lru_memcg *memcg_lrus;
>         int size = memcg_nr_cache_ids;
>
> -       memcg_lrus = kvmalloc(sizeof(*memcg_lrus) +
> +       memcg_lrus = kvzalloc(sizeof(*memcg_lrus) +
>                               size * sizeof(void *), GFP_KERNEL);
>         if (!memcg_lrus)
>                 return -ENOMEM;
>
> -       if (__memcg_init_list_lru_node(memcg_lrus, 0, size)) {
> -               kvfree(memcg_lrus);
> -               return -ENOMEM;
> -       }
>         RCU_INIT_POINTER(nlru->memcg_lrus, memcg_lrus);
>
>         return 0;
> @@ -389,15 +380,10 @@ static int memcg_update_list_lru_node(struct list_lru_node *nlru,
>
>         old = rcu_dereference_protected(nlru->memcg_lrus,
>                                         lockdep_is_held(&list_lrus_mutex));
> -       new = kvmalloc(sizeof(*new) + new_size * sizeof(void *), GFP_KERNEL);
> +       new = kvzalloc(sizeof(*new) + new_size * sizeof(void *), GFP_KERNEL);
>         if (!new)
>                 return -ENOMEM;
>
> -       if (__memcg_init_list_lru_node(new, old_size, new_size)) {
> -               kvfree(new);
> -               return -ENOMEM;
> -       }
> -
>         memcpy(&new->lru, &old->lru, old_size * sizeof(void *));
>
>         /*
> @@ -526,6 +512,7 @@ static void memcg_drain_list_lru_node(struct list_lru *lru, int nid,
>         struct list_lru_node *nlru = &lru->node[nid];
>         int dst_idx = dst_memcg->kmemcg_id;
>         struct list_lru_one *src, *dst;
> +       struct list_lru_memcg *memcg_lrus;
>
>         /*
>          * Since list_lru_{add,del} may be called under an IRQ-safe lock,
> @@ -534,7 +521,17 @@ static void memcg_drain_list_lru_node(struct list_lru *lru, int nid,
>         spin_lock_irq(&nlru->lock);
>
>         src = list_lru_from_memcg_idx(nlru, src_idx);
> +       if (!src)
> +               goto out;
> +
>         dst = list_lru_from_memcg_idx(nlru, dst_idx);
> +       if (!dst) {
> +               /* TODO: Use __GFP_NOFAIL? */
> +               dst = kmalloc(sizeof(struct list_lru_one), GFP_ATOMIC);
> +               init_one_lru(dst);
> +               memcg_lrus = rcu_dereference_protected(nlru->memcg_lrus, true);
> +               memcg_lrus->lru[dst_idx] = dst;
> +       }
>
>         list_splice_init(&src->list, &dst->list);
>
> @@ -543,7 +540,7 @@ static void memcg_drain_list_lru_node(struct list_lru *lru, int nid,
>                 memcg_set_shrinker_bit(dst_memcg, nid, lru_shrinker_id(lru));
>                 src->nr_items = 0;
>         }
> -
> +out:
>         spin_unlock_irq(&nlru->lock);
>  }
>
> --
> 2.26.2
>
>
