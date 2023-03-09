Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D01196B2047
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Mar 2023 10:39:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbjCIJjn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Mar 2023 04:39:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjCIJjm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Mar 2023 04:39:42 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F762DE1CD
        for <linux-fsdevel@vger.kernel.org>; Thu,  9 Mar 2023 01:39:40 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id u9so4554611edd.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Mar 2023 01:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678354779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WGNuRvZ8lS7XESHNCrOlWjPsv1FnRrcTXW2fRVQu+M8=;
        b=MK2v7qt9neRMXXISpAiAvnjRTzv8Mx0W015Pd0IwUbcVGmAGFtQ83Oxeu06anLRDFP
         duMgUJmvzIKuuPMLOLy0RmL6j3O3JguC/ztcuZhHSArgzzWcUEetTcuBoTyLXDxyw7Nj
         9fDWoURoX5ylkK0CY9QFIxIuhEw1izEg+zCTZvnhU4g9gPJgINKQakpSw5gpYk6+o3WE
         ttWgPWn+G2Qdakb23BBYMti0QTYW43AVm2zAUMA0deh+DJWbY3KBgKMjcU16R3nGlIPK
         9I+cD5rOwLmRm7x1+MN+VLPqf2IUUKkl6GuSxrrp0tC45yvBXvcPkUk3t/XJo2jqFV9b
         U7Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678354779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WGNuRvZ8lS7XESHNCrOlWjPsv1FnRrcTXW2fRVQu+M8=;
        b=HFhepPIYItsllafATLYTCh8fq6aq3m8xzgkpKz3EUIKgACXKmI2fYo30gud7mLqHXi
         NEQtuy/vs9ThxvZGbtyuzWE1auFQiokFuT5oqUnlzB+27YN/HBjbfNWnQFn+ITH4/a5p
         piL8m7jiQYntPoAv4Lmzupe+1Sb/8irM4pmY4lHebhZMjVPuvdxUKl93EZLr0/gz1WoY
         GoMxDcn2737hBXgub5fZ80HB4s/fC+bGuInBfaIzEkgiLVerSxhypEydJOUBQpcujSqK
         GQDxXkH+9Skt2vKOB00ROxqJLuXXlEBIuJVCMRQa6Cw7xc89li1J/RsWuG5+B5KFCAZM
         Cr/Q==
X-Gm-Message-State: AO0yUKXXzEWhCtnB3OU6JAATc3ck9LUMmjmbEEtTqJAYUYsKE/IGKNqw
        JOpkL8pDrAC9IACCZFkTjBpUwME6cJNVrBR2RIT3KQ==
X-Google-Smtp-Source: AK7set8tO9nTFdrettltT4IWxh61gXrBDwA9xWU3+9eSg2d2Nv5R0J3ff1LnsWVtXQOFaVzGy3B8ezQvaqTi7wu9WJQ=
X-Received: by 2002:a17:906:1ec6:b0:8b0:7e1d:f6fa with SMTP id
 m6-20020a1709061ec600b008b07e1df6famr10187131ejj.15.1678354778760; Thu, 09
 Mar 2023 01:39:38 -0800 (PST)
MIME-Version: 1.0
References: <20230309093109.3039327-1-yosryahmed@google.com> <20230309093109.3039327-3-yosryahmed@google.com>
In-Reply-To: <20230309093109.3039327-3-yosryahmed@google.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 9 Mar 2023 01:39:02 -0800
Message-ID: <CAJD7tkYJ=xKvRxGKm3bsXy9_yO+fz1wYZcBO-XiAJjRacJsdQg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] mm: vmscan: refactor updating reclaimed pages in reclaim_state
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
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
        Johannes Weiner <hannes@cmpxchg.org>,
        Peter Xu <peterx@redhat.com>, NeilBrown <neilb@suse.de>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@kernel.org>, Yu Zhao <yuzhao@google.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, Mar 9, 2023 at 1:31=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com> =
wrote:
>
> During reclaim, we keep track of pages reclaimed from other means than
> LRU-based reclaim through scan_control->reclaim_state->reclaimed_slab,
> which we stash a pointer to in current task_struct.
>
> However, we keep track of more than just reclaimed slab pages through
> this. We also use it for clean file pages dropped through pruned inodes,
> and xfs buffer pages freed. Rename reclaimed_slab to reclaimed, and add
> a helper function that wraps updating it through current, so that future
> changes to this logic are contained within mm/vmscan.c.
>
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> ---
>  fs/inode.c           |  3 +--
>  fs/xfs/xfs_buf.c     |  3 +--
>  include/linux/swap.h |  5 ++++-
>  mm/slab.c            |  3 +--
>  mm/slob.c            |  6 ++----
>  mm/slub.c            |  5 ++---
>  mm/vmscan.c          | 36 ++++++++++++++++++++++++++++++------
>  7 files changed, 41 insertions(+), 20 deletions(-)
>
> diff --git a/fs/inode.c b/fs/inode.c
> index 4558dc2f1355..e60fcc41faf1 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -864,8 +864,7 @@ static enum lru_status inode_lru_isolate(struct list_=
head *item,
>                                 __count_vm_events(KSWAPD_INODESTEAL, reap=
);
>                         else
>                                 __count_vm_events(PGINODESTEAL, reap);
> -                       if (current->reclaim_state)
> -                               current->reclaim_state->reclaimed_slab +=
=3D reap;
> +                       mm_account_reclaimed_pages(reap);
>                 }
>                 iput(inode);
>                 spin_lock(lru_lock);
> diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
> index 54c774af6e1c..060079f1e966 100644
> --- a/fs/xfs/xfs_buf.c
> +++ b/fs/xfs/xfs_buf.c
> @@ -286,8 +286,7 @@ xfs_buf_free_pages(
>                 if (bp->b_pages[i])
>                         __free_page(bp->b_pages[i]);
>         }
> -       if (current->reclaim_state)
> -               current->reclaim_state->reclaimed_slab +=3D bp->b_page_co=
unt;
> +       report_freed_pages(bp->b_page_count);


Ugh I missed updating this one to mm_account_reclaimed_page().

This fixup needs to be squashed here. I will include it in v3 if a
respin is needed, otherwise I hope Andrew can squash it in.

diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
index 060079f1e966..15d1e5a7c2d3 100644
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -286,7 +286,7 @@ xfs_buf_free_pages(
                if (bp->b_pages[i])
                        __free_page(bp->b_pages[i]);
        }
-       report_freed_pages(bp->b_page_count);
+       mm_account_reclaimed_pages(bp->b_page_count);

        if (bp->b_pages !=3D bp->b_page_array)
                kmem_free(bp->b_pages);

>
>
>         if (bp->b_pages !=3D bp->b_page_array)
>                 kmem_free(bp->b_pages);
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index 209a425739a9..589ea2731931 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -153,13 +153,16 @@ union swap_header {
>   * memory reclaim
>   */
>  struct reclaim_state {
> -       unsigned long reclaimed_slab;
> +       /* pages reclaimed outside of LRU-based reclaim */
> +       unsigned long reclaimed;
>  #ifdef CONFIG_LRU_GEN
>         /* per-thread mm walk data */
>         struct lru_gen_mm_walk *mm_walk;
>  #endif
>  };
>
> +void mm_account_reclaimed_pages(unsigned long pages);
> +
>  #ifdef __KERNEL__
>
>  struct address_space;
> diff --git a/mm/slab.c b/mm/slab.c
> index dabc2a671fc6..64bf1de817b2 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -1392,8 +1392,7 @@ static void kmem_freepages(struct kmem_cache *cache=
p, struct slab *slab)
>         smp_wmb();
>         __folio_clear_slab(folio);
>
> -       if (current->reclaim_state)
> -               current->reclaim_state->reclaimed_slab +=3D 1 << order;
> +       mm_account_reclaimed_pages(1 << order);
>         unaccount_slab(slab, order, cachep);
>         __free_pages(&folio->page, order);
>  }
> diff --git a/mm/slob.c b/mm/slob.c
> index fe567fcfa3a3..79cc8680c973 100644
> --- a/mm/slob.c
> +++ b/mm/slob.c
> @@ -61,7 +61,7 @@
>  #include <linux/slab.h>
>
>  #include <linux/mm.h>
> -#include <linux/swap.h> /* struct reclaim_state */
> +#include <linux/swap.h> /* mm_account_reclaimed_pages() */
>  #include <linux/cache.h>
>  #include <linux/init.h>
>  #include <linux/export.h>
> @@ -211,9 +211,7 @@ static void slob_free_pages(void *b, int order)
>  {
>         struct page *sp =3D virt_to_page(b);
>
> -       if (current->reclaim_state)
> -               current->reclaim_state->reclaimed_slab +=3D 1 << order;
> -
> +       mm_account_reclaimed_pages(1 << order);
>         mod_node_page_state(page_pgdat(sp), NR_SLAB_UNRECLAIMABLE_B,
>                             -(PAGE_SIZE << order));
>         __free_pages(sp, order);
> diff --git a/mm/slub.c b/mm/slub.c
> index 39327e98fce3..7aa30eef8235 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -11,7 +11,7 @@
>   */
>
>  #include <linux/mm.h>
> -#include <linux/swap.h> /* struct reclaim_state */
> +#include <linux/swap.h> /* mm_account_reclaimed_pages() */
>  #include <linux/module.h>
>  #include <linux/bit_spinlock.h>
>  #include <linux/interrupt.h>
> @@ -2063,8 +2063,7 @@ static void __free_slab(struct kmem_cache *s, struc=
t slab *slab)
>         /* Make the mapping reset visible before clearing the flag */
>         smp_wmb();
>         __folio_clear_slab(folio);
> -       if (current->reclaim_state)
> -               current->reclaim_state->reclaimed_slab +=3D pages;
> +       mm_account_reclaimed_pages(pages);
>         unaccount_slab(slab, order, s);
>         __free_pages(&folio->page, order);
>  }
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index fef7d1c0f82b..a3e38851b34a 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -511,6 +511,34 @@ static void set_task_reclaim_state(struct task_struc=
t *task,
>         task->reclaim_state =3D rs;
>  }
>
> +/*
> + * mm_account_reclaimed_pages(): account reclaimed pages outside of LRU-=
based
> + * reclaim
> + * @pages: number of pages reclaimed
> + *
> + * If the current process is undergoing a reclaim operation, increment t=
he
> + * number of reclaimed pages by @pages.
> + */
> +void mm_account_reclaimed_pages(unsigned long pages)
> +{
> +       if (current->reclaim_state)
> +               current->reclaim_state->reclaimed +=3D pages;
> +}
> +EXPORT_SYMBOL(mm_account_reclaimed_pages);
> +
> +/*
> + * flush_reclaim_state(): add pages reclaimed outside of LRU-based recla=
im to
> + * scan_control->nr_reclaimed.
> + */
> +static void flush_reclaim_state(struct scan_control *sc,
> +                               struct reclaim_state *rs)
> +{
> +       if (rs) {
> +               sc->nr_reclaimed +=3D rs->reclaimed;
> +               rs->reclaimed =3D 0;
> +       }
> +}
> +
>  static long xchg_nr_deferred(struct shrinker *shrinker,
>                              struct shrink_control *sc)
>  {
> @@ -5346,8 +5374,7 @@ static int shrink_one(struct lruvec *lruvec, struct=
 scan_control *sc)
>                 vmpressure(sc->gfp_mask, memcg, false, sc->nr_scanned - s=
canned,
>                            sc->nr_reclaimed - reclaimed);
>
> -       sc->nr_reclaimed +=3D current->reclaim_state->reclaimed_slab;
> -       current->reclaim_state->reclaimed_slab =3D 0;
> +       flush_reclaim_state(sc, current->reclaim_state);
>
>         return success ? MEMCG_LRU_YOUNG : 0;
>  }
> @@ -6472,10 +6499,7 @@ static void shrink_node(pg_data_t *pgdat, struct s=
can_control *sc)
>
>         shrink_node_memcgs(pgdat, sc);
>
> -       if (reclaim_state) {
> -               sc->nr_reclaimed +=3D reclaim_state->reclaimed_slab;
> -               reclaim_state->reclaimed_slab =3D 0;
> -       }
> +       flush_reclaim_state(sc, reclaim_state);
>
>         /* Record the subtree's reclaim efficiency */
>         if (!sc->proactive)
> --
> 2.40.0.rc0.216.gc4246ad0f0-goog
>
