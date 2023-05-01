Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58EAA6F3017
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 May 2023 12:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232323AbjEAKNS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 May 2023 06:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjEAKNQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 May 2023 06:13:16 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1855C195
        for <linux-fsdevel@vger.kernel.org>; Mon,  1 May 2023 03:13:14 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9505214c47fso481902966b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 May 2023 03:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682935992; x=1685527992;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q8lhfypd62FTx15FUrLgQ9Jnn3JuzKJA2np2M0uDQxQ=;
        b=VaFrUpClBFo29v9l4Djcb79DHfwoOettCa5PtHL9yYH6qyblJ0B4m6QuPFSuGIlXhk
         HoVhrhtsiER0i35ICq11i5bRuzT3jaBt4ehpszIDZZ4/K1SE7gnW+uBKOb7vi+pd4F7b
         aznnjkVukqkQq/9/WjqDyLA2Z8JGMGvjyrf+BamTY416e2TJHbFFp/14+7WVy3X+3TEi
         213PXFoPSPk5v1KYzmd6hDzLSS1CS6fWP1GiXcWIdUTdGyBWR7QHWEMnR7FcDwBOlJ+O
         5YRRduFfYbGGpDl1AGuaCCaAKwWhMdGOiqtCu/aGfDKIZyQgThXUq91xQZqs79+cTLRe
         t30Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682935992; x=1685527992;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q8lhfypd62FTx15FUrLgQ9Jnn3JuzKJA2np2M0uDQxQ=;
        b=O4xzPCFVtG3ZXdjm6kBCogMtfnRC34MVAT+z+CosV9IskE/6Q8hMzvgEU9yqRXJAd9
         +1RokEONCtVkCdWFv++5XZgY06zKL0xbel04FoSUfp1BntnSDf0kbsMRb18bMsfGNvy7
         3NY/9Ej+0FadRGrgm8hR4rbfqYgmfUAncdg7QvGdogo0sk8wSveIXcIt0QQPjqlPQkT+
         5siU+AozboCJVNPnoIh/76Jh3eQfaCcXhlb09dz66a9v+71Qo8p1yN+qk07AKBGAzf4A
         v7RluU0Spd/AxdyjB5Y8JBx1IvRRqITfXgwa8ZesulU5lHh3HEyFajooT+YQhThxa0Fv
         UQwQ==
X-Gm-Message-State: AC+VfDzdJ3JA4VBuOML5ToDKlfWOmOxxld5tRiTl7xrv5KWTCBoK9QyZ
        QL5fXSMFAMFQ8rsJ/b5d+whpvvrEpdajwD/WrFBm2w==
X-Google-Smtp-Source: ACHHUZ5FHHpuX/K+BNP8YqIzaDjBHp8LYmuwyxZrxNRQg7Tb0947e3YdeSix/a/OfzGmnQs+mspTQb/7MGE010+WRJ8=
X-Received: by 2002:a17:906:dc8c:b0:933:4d37:82b2 with SMTP id
 cs12-20020a170906dc8c00b009334d3782b2mr15295040ejc.57.1682935992353; Mon, 01
 May 2023 03:13:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230413104034.1086717-1-yosryahmed@google.com> <20230413104034.1086717-2-yosryahmed@google.com>
In-Reply-To: <20230413104034.1086717-2-yosryahmed@google.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Mon, 1 May 2023 03:12:36 -0700
Message-ID: <CAJD7tkaJRNhMQ_dJWs82OsOEyr86LNSitOHV0i12zydDMgoVxw@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] mm: vmscan: ignore non-LRU-based reclaim in memcg reclaim
To:     Andrew Morton <akpm@linux-foundation.org>,
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
        Johannes Weiner <hannes@cmpxchg.org>,
        Peter Xu <peterx@redhat.com>, NeilBrown <neilb@suse.de>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Tim Chen <tim.c.chen@linux.intel.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 13, 2023 at 3:40=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> We keep track of different types of reclaimed pages through
> reclaim_state->reclaimed_slab, and we add them to the reported number
> of reclaimed pages.  For non-memcg reclaim, this makes sense. For memcg
> reclaim, we have no clue if those pages are charged to the memcg under
> reclaim.
>
> Slab pages are shared by different memcgs, so a freed slab page may have
> only been partially charged to the memcg under reclaim.  The same goes fo=
r
> clean file pages from pruned inodes (on highmem systems) or xfs buffer
> pages, there is no simple way to currently link them to the memcg under
> reclaim.
>
> Stop reporting those freed pages as reclaimed pages during memcg reclaim.
> This should make the return value of writing to memory.reclaim, and may
> help reduce unnecessary reclaim retries during memcg charging.  Writing t=
o
> memory.reclaim on the root memcg is considered as cgroup_reclaim(), but
> for this case we want to include any freed pages, so use the
> global_reclaim() check instead of !cgroup_reclaim().
>
> Generally, this should make the return value of
> try_to_free_mem_cgroup_pages() more accurate. In some limited cases (e.g.
> freed a slab page that was mostly charged to the memcg under reclaim),
> the return value of try_to_free_mem_cgroup_pages() can be underestimated,
> but this should be fine. The freed pages will be uncharged anyway, and we
> can charge the memcg the next time around as we usually do memcg reclaim
> in a retry loop.
>
> Fixes: f2fe7b09a52b ("mm: memcg/slab: charge individual slab objects
> instead of pages")
>
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> ---
>  mm/vmscan.c | 49 ++++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 42 insertions(+), 7 deletions(-)
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 9c1c5e8b24b8..be657832be48 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -511,6 +511,46 @@ static bool writeback_throttling_sane(struct scan_co=
ntrol *sc)
>  }
>  #endif
>
> +/*
> + * flush_reclaim_state(): add pages reclaimed outside of LRU-based recla=
im to
> + * scan_control->nr_reclaimed.
> + */
> +static void flush_reclaim_state(struct scan_control *sc)
> +{
> +       /*
> +        * Currently, reclaim_state->reclaimed includes three types of pa=
ges
> +        * freed outside of vmscan:
> +        * (1) Slab pages.
> +        * (2) Clean file pages from pruned inodes (on highmem systems).
> +        * (3) XFS freed buffer pages.
> +        *
> +        * For all of these cases, we cannot universally link the pages t=
o a
> +        * single memcg. For example, a memcg-aware shrinker can free one=
 object
> +        * charged to the target memcg, causing an entire page to be free=
d.
> +        * If we count the entire page as reclaimed from the memcg, we en=
d up
> +        * overestimating the reclaimed amount (potentially under-reclaim=
ing).
> +        *
> +        * Only count such pages for global reclaim to prevent under-recl=
aiming
> +        * from the target memcg; preventing unnecessary retries during m=
emcg
> +        * charging and false positives from proactive reclaim.
> +        *
> +        * For uncommon cases where the freed pages were actually mostly
> +        * charged to the target memcg, we end up underestimating the rec=
laimed
> +        * amount. This should be fine. The freed pages will be uncharged
> +        * anyway, even if they are not counted here properly, and we wil=
l be
> +        * able to make forward progress in charging (which is usually in=
 a
> +        * retry loop).
> +        *
> +        * We can go one step further, and report the uncharged objcg pag=
es in
> +        * memcg reclaim, to make reporting more accurate and reduce
> +        * underestimation, but it's probably not worth the complexity fo=
r now.
> +        */
> +       if (current->reclaim_state && global_reclaim(sc)) {
> +               sc->nr_reclaimed +=3D current->reclaim_state->reclaimed;
> +               current->reclaim_state->reclaimed =3D 0;

Ugh.. this breaks the build. This should have been
current->reclaim_state->reclaimed_slab. It doesn't get renamed from
"reclaimed_slab" to "reclaim" until the next patch. When I moved
flush_reclaim_state() from patch 2 to patch 1 I forgot to augment it.
My bad.

The break is fixed by the very next patch, and the patches have
already landed in Linus's tree, so there isn't much that can be done
at this point. Sorry about that. Just wondering, why wouldn't this
breakage be caught by any of the build bots?

> +       }
> +}
> +
>  static long xchg_nr_deferred(struct shrinker *shrinker,
>                              struct shrink_control *sc)
>  {
> @@ -5346,8 +5386,7 @@ static int shrink_one(struct lruvec *lruvec, struct=
 scan_control *sc)
>                 vmpressure(sc->gfp_mask, memcg, false, sc->nr_scanned - s=
canned,
>                            sc->nr_reclaimed - reclaimed);
>
> -       sc->nr_reclaimed +=3D current->reclaim_state->reclaimed_slab;
> -       current->reclaim_state->reclaimed_slab =3D 0;
> +       flush_reclaim_state(sc);
>
>         return success ? MEMCG_LRU_YOUNG : 0;
>  }
> @@ -6450,7 +6489,6 @@ static void shrink_node_memcgs(pg_data_t *pgdat, st=
ruct scan_control *sc)
>
>  static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
>  {
> -       struct reclaim_state *reclaim_state =3D current->reclaim_state;
>         unsigned long nr_reclaimed, nr_scanned;
>         struct lruvec *target_lruvec;
>         bool reclaimable =3D false;
> @@ -6472,10 +6510,7 @@ static void shrink_node(pg_data_t *pgdat, struct s=
can_control *sc)
>
>         shrink_node_memcgs(pgdat, sc);
>
> -       if (reclaim_state) {
> -               sc->nr_reclaimed +=3D reclaim_state->reclaimed_slab;
> -               reclaim_state->reclaimed_slab =3D 0;
> -       }
> +       flush_reclaim_state(sc);
>
>         /* Record the subtree's reclaim efficiency */
>         if (!sc->proactive)
> --
> 2.40.0.577.gac1e443424-goog
>
