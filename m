Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 955C36E0BA6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Apr 2023 12:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbjDMKqX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Apr 2023 06:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjDMKqW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Apr 2023 06:46:22 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 391D112A
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Apr 2023 03:46:20 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id sg7so47685130ejc.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Apr 2023 03:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681382778; x=1683974778;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1kRbU6nc4ZqgrBcPQoPoqFqYgjL9hmlR/TueIIn2YYA=;
        b=iBBpmFcz38y6AeHKjTWPduIZWh2DEuihaDb0wcg8c1Swf5CchMT/WMzFn4cJ8Njwec
         2gDac2A57jS+VMzUkiCYDfG4WR+Wcg5thruLzZXtaRBfLmvMb8tK3ihbjQeC2MhcVfVA
         50yFhgUuVejuA/BqJ4vqXv1mG6v6e7DsHn5yGwQ6iwaLHJDKAC/iPHsg7lAnlBhC/ltl
         S51m91lIglufOEq1XKWfWm8LIK1OKhPGniM7gPPg0kWsCy75x0a6QeQzmPtLSqSFMlJY
         uCC1h3nCIcuvsqWVL1pHf5GgNgkH2R6E9NUheV9BH5u91MmuY3N3L5IDdcChQOp4Kh2g
         buCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681382778; x=1683974778;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1kRbU6nc4ZqgrBcPQoPoqFqYgjL9hmlR/TueIIn2YYA=;
        b=Sz8v7cUi3uhrOH3TZKxmKlKV8v7JLpPUP2KCKAZQ7cdpyZqap0b+BXB3o4rWfLREVZ
         XFoeXYvbhMeOjam6hl5glkkq8emnaw5SSsWL0DSAXgL70QzkLlN4rftaaoDumC4CpnyP
         YSVIrjK8TnkpnVIU0oiK4EecFsQhZvwg+E58oye/7jLUmdDClSJeqwEidigNWx84v6x0
         WzQeXq26D6rL20FY8Lj94n1MEaIxZYYRDCKNblAxucy10QnYs9ke9NbsH9pJF3ekCUBw
         gugN5055cR4L3+N/6/HU09nNHpIb0PGePNtfl0QSze70tXLVMFDMfZpPisvrSPPRpLyf
         UGWA==
X-Gm-Message-State: AAQBX9d+8Bkzsm27Y98iW8E9YP0AU+xuI/SJVu5FktteFbzIQT4yTHEG
        BjGzYAcoxbpMbJeKqxsG5qtpu1LoP4yPs9DTMc4AGg==
X-Google-Smtp-Source: AKy350aASI2gRddtiUsu6uEbTsoIdtPM75Lk+ucwTweLG2axKrPCTsxtIZLNtTpdA3utnAcOD3Prf8rOfFSZkJPnxXQ=
X-Received: by 2002:a17:906:2c1a:b0:94e:8e6f:4f1c with SMTP id
 e26-20020a1709062c1a00b0094e8e6f4f1cmr1032618ejh.15.1681382778488; Thu, 13
 Apr 2023 03:46:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230413104034.1086717-1-yosryahmed@google.com> <20230413104034.1086717-2-yosryahmed@google.com>
In-Reply-To: <20230413104034.1086717-2-yosryahmed@google.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 13 Apr 2023 03:45:42 -0700
Message-ID: <CAJD7tkbnsSbZ2+Rf5NQKgBtH_JdN4AKMCuh8jasbQ-hcOOz-KA@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] mm: vmscan: ignore non-LRU-based reclaim in memcg reclaim
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
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
        Tim Chen <tim.c.chen@linux.intel.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
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


Andrew, I removed the CC: stable as you were sceptical about the need
for a backport, but left the Fixes tag so that it's easy to identify
where to backport it if you and/or stable maintainers decide
otherwise.

>
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
