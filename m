Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBD4E6A54D5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Feb 2023 09:52:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbjB1Iwm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Feb 2023 03:52:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbjB1IwH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Feb 2023 03:52:07 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93BF211672
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Feb 2023 00:52:05 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id i34so36711409eda.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Feb 2023 00:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677574324;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6BbjsTlIxZF7sHybz8w08FCH3QFWqUyFfeqt4CnEYMk=;
        b=by2YIoMCcWOIsp0h7rKr5/1LFUIxzFGmSxl99O34nCM0YlDHzM4rBFyU9Sa2r9Rm+U
         /74o8KO6R1+V7S2sTO4iNDbYU3ylNZajBCgi77hc242nQrClVTmoEdczLpCLwID/X2CY
         DqEgjZqLRBj72UE3teWtOms462JbYAhPq/M89CAfZNMHi5aipDaO2rxKektFUe8S6Zrc
         2lM4SRcc7EXHbmL3+xf8Ylzkf6Dkkz8VUdvKSoPakkNoPMb9b49XN2m/SzwbQ9KRHHh6
         7yQjg6MoQadlNdv2CVYShkBYtfxFiQ+AX3ylCJ2Usg/3LT4nAkxvCSip8l+EhtbuzxmE
         d+ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677574324;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6BbjsTlIxZF7sHybz8w08FCH3QFWqUyFfeqt4CnEYMk=;
        b=K2JRCPX4TClllo54Q9gERtp4WeTh5vfFrvizr3bRHPuI7rYySnu2ErDjkPUPN9OoGy
         tzSfSF4K6bpI4ZmY5h81VSdmnuo53nc4IMGs0BvkxIzQvk3WZDgksmOoMySwguaUr7GQ
         ChuuPRWq+QXybk7NXKmNXjdxWabTiQ9n9dVt02wbfQ1mxF2RxMqgHzwoOb63T1G//jOQ
         FBBjA87sRzaorqAgfQBOHNpGPE6xPTNaXDGX8iUKathEBYJQQdLvU2JIikFCKegRCqSm
         HKMl1ou4oaTFJbS7FeXDYq4cLmmGRHpn1mMS8PnAovE+IzBur1b7s7VeiHySrD5Cyvzo
         xJiw==
X-Gm-Message-State: AO0yUKV2HaGzDbGxjQEqQpa8Nrg/L9t/PPHUqzVlzJO6tu28VUacNsHk
        S0haS4NUsBUkHK1HsO2l/r2X5GRagV9yVLF4S7lVZA==
X-Google-Smtp-Source: AK7set+w89B+Be1v0debpVNCQWtTsMmurjr+6Hg6eEuZILDCabx9cDMZRer1q1pSjmvz3ufnokuECDI4H5cGbZmUkaA=
X-Received: by 2002:a17:906:fe06:b0:8f8:edfc:b68b with SMTP id
 wy6-20020a170906fe0600b008f8edfcb68bmr1909988ejb.6.1677574323871; Tue, 28 Feb
 2023 00:52:03 -0800 (PST)
MIME-Version: 1.0
References: <20230228085002.2592473-1-yosryahmed@google.com> <20230228085002.2592473-2-yosryahmed@google.com>
In-Reply-To: <20230228085002.2592473-2-yosryahmed@google.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 28 Feb 2023 00:51:27 -0800
Message-ID: <CAJD7tkYnUo2cDS72XecQRY-ctKJLBFhxvqc_XO9985P4xpzAhw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] mm: vmscan: refactor updating reclaimed pages in reclaim_state
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

+Yu Zhao

On Tue, Feb 28, 2023 at 12:50 AM Yosry Ahmed <yosryahmed@google.com> wrote:
>
> During reclaim, we keep track of pages reclaimed from other means than
> LRU-based reclaim through scan_control->reclaim_state->reclaimed_slab,
> which we stash a pointer to in current task_struct.
>
> However, we keep track of more than just reclaimed slab pages through
> this. We also use it for clean file pages dropped through pruned inodes,
> and xfs buffer pages freed. Rename reclaimed_slab to reclaimed, and add
> a helper function that wraps updating it through current.
>
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> ---
>  fs/inode.c           |  3 +--
>  fs/xfs/xfs_buf.c     |  3 +--
>  include/linux/swap.h |  5 ++++-
>  mm/slab.c            |  3 +--
>  mm/slob.c            |  6 ++----
>  mm/slub.c            |  5 ++---
>  mm/vmscan.c          | 31 +++++++++++++++++++++++++------
>  7 files changed, 36 insertions(+), 20 deletions(-)
>
> diff --git a/fs/inode.c b/fs/inode.c
> index 4558dc2f1355..1022d8ac7205 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -864,8 +864,7 @@ static enum lru_status inode_lru_isolate(struct list_head *item,
>                                 __count_vm_events(KSWAPD_INODESTEAL, reap);
>                         else
>                                 __count_vm_events(PGINODESTEAL, reap);
> -                       if (current->reclaim_state)
> -                               current->reclaim_state->reclaimed_slab += reap;
> +                       report_freed_pages(reap);
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
> -               current->reclaim_state->reclaimed_slab += bp->b_page_count;
> +       report_freed_pages(bp->b_page_count);
>
>         if (bp->b_pages != bp->b_page_array)
>                 kmem_free(bp->b_pages);
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index 209a425739a9..525f0ae442f9 100644
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
> +void report_freed_pages(unsigned long pages);
> +
>  #ifdef __KERNEL__
>
>  struct address_space;
> diff --git a/mm/slab.c b/mm/slab.c
> index dabc2a671fc6..325634416aab 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -1392,8 +1392,7 @@ static void kmem_freepages(struct kmem_cache *cachep, struct slab *slab)
>         smp_wmb();
>         __folio_clear_slab(folio);
>
> -       if (current->reclaim_state)
> -               current->reclaim_state->reclaimed_slab += 1 << order;
> +       report_freed_pages(1 << order);
>         unaccount_slab(slab, order, cachep);
>         __free_pages(&folio->page, order);
>  }
> diff --git a/mm/slob.c b/mm/slob.c
> index fe567fcfa3a3..71ee00e9dd46 100644
> --- a/mm/slob.c
> +++ b/mm/slob.c
> @@ -61,7 +61,7 @@
>  #include <linux/slab.h>
>
>  #include <linux/mm.h>
> -#include <linux/swap.h> /* struct reclaim_state */
> +#include <linux/swap.h> /* report_freed_pages() */
>  #include <linux/cache.h>
>  #include <linux/init.h>
>  #include <linux/export.h>
> @@ -211,9 +211,7 @@ static void slob_free_pages(void *b, int order)
>  {
>         struct page *sp = virt_to_page(b);
>
> -       if (current->reclaim_state)
> -               current->reclaim_state->reclaimed_slab += 1 << order;
> -
> +       report_freed_pages(1 << order);
>         mod_node_page_state(page_pgdat(sp), NR_SLAB_UNRECLAIMABLE_B,
>                             -(PAGE_SIZE << order));
>         __free_pages(sp, order);
> diff --git a/mm/slub.c b/mm/slub.c
> index 39327e98fce3..165319bf11f1 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -11,7 +11,7 @@
>   */
>
>  #include <linux/mm.h>
> -#include <linux/swap.h> /* struct reclaim_state */
> +#include <linux/swap.h> /* report_freed_pages() */
>  #include <linux/module.h>
>  #include <linux/bit_spinlock.h>
>  #include <linux/interrupt.h>
> @@ -2063,8 +2063,7 @@ static void __free_slab(struct kmem_cache *s, struct slab *slab)
>         /* Make the mapping reset visible before clearing the flag */
>         smp_wmb();
>         __folio_clear_slab(folio);
> -       if (current->reclaim_state)
> -               current->reclaim_state->reclaimed_slab += pages;
> +       report_freed_pages(pages);
>         unaccount_slab(slab, order, s);
>         __free_pages(&folio->page, order);
>  }
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 9c1c5e8b24b8..8846531e85a4 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -200,6 +200,29 @@ static void set_task_reclaim_state(struct task_struct *task,
>         task->reclaim_state = rs;
>  }
>
> +/*
> + * reclaim_report_freed_pages: report pages freed outside of LRU-based reclaim
> + * @pages: number of pages freed
> + *
> + * If the current process is undergoing a reclaim operation,
> + * increment the number of reclaimed pages by @pages.
> + */
> +void report_freed_pages(unsigned long pages)
> +{
> +       if (current->reclaim_state)
> +               current->reclaim_state->reclaimed += pages;
> +}
> +EXPORT_SYMBOL(report_freed_pages);
> +
> +static void add_non_vmscan_reclaimed(struct scan_control *sc,
> +                                    struct reclaim_state *rs)
> +{
> +       if (rs) {
> +               sc->nr_reclaimed += rs->reclaimed;
> +               rs->reclaimed = 0;
> +       }
> +}
> +
>  LIST_HEAD(shrinker_list);
>  DECLARE_RWSEM(shrinker_rwsem);
>
> @@ -5346,8 +5369,7 @@ static int shrink_one(struct lruvec *lruvec, struct scan_control *sc)
>                 vmpressure(sc->gfp_mask, memcg, false, sc->nr_scanned - scanned,
>                            sc->nr_reclaimed - reclaimed);
>
> -       sc->nr_reclaimed += current->reclaim_state->reclaimed_slab;
> -       current->reclaim_state->reclaimed_slab = 0;
> +       add_non_vmscan_reclaimed(sc, current->reclaim_state);
>
>         return success ? MEMCG_LRU_YOUNG : 0;
>  }
> @@ -6472,10 +6494,7 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
>
>         shrink_node_memcgs(pgdat, sc);
>
> -       if (reclaim_state) {
> -               sc->nr_reclaimed += reclaim_state->reclaimed_slab;
> -               reclaim_state->reclaimed_slab = 0;
> -       }
> +       add_non_vmscan_reclaimed(sc, reclaim_state);
>
>         /* Record the subtree's reclaim efficiency */
>         if (!sc->proactive)
> --
> 2.39.2.722.g9855ee24e9-goog
>
