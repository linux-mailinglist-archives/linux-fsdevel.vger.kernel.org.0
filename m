Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6723413A40
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Sep 2021 20:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbhIUSrE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Sep 2021 14:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbhIUSrD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Sep 2021 14:47:03 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BACC1C061574;
        Tue, 21 Sep 2021 11:45:32 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id v24so206914eda.3;
        Tue, 21 Sep 2021 11:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BRQLc5fTbxFYl8Ns1gqbKeWN8GDbRNjSvcx7QdD1QMo=;
        b=Spbw5VKqstmS6Nj5w0pO1tra5otHKK9Nv9nhB7lQ01TUOhkMk3qWiSsncF4Wv6MlLw
         C3k8kB8eutSSeGYmxnZ0IXJQ4X/AkmUI6URhdSF3LDOxhViEB5PzGaOYKsTUbdEnB8Yc
         faJr437XYvU60OvVI6IjeeVHZKFi0LvZ85WIKMqgmYZhZE6VskIQl8gu4SCy3qxSag6c
         DnUUf2wJRxLEu+SgpmDqWGysrRSNKkSXnkDh3P6uEHsJJAaWFevurGR83hhYCzqvnVn5
         DvCQWH/a/Rg8FgiZxinpQu1usXnsqx/zOAPyi5mBC6V+72UXtEJzqKkav+4JNPIrUmlH
         3J2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BRQLc5fTbxFYl8Ns1gqbKeWN8GDbRNjSvcx7QdD1QMo=;
        b=6rq4qods24cCTFZfwoFWdZkRbQ9OPs/KNqsxRP7Cb5xT8rthAiPzQLb+PpLmJY9SJg
         4hcuHOAcyr+XR2YVyyN/Xj5Mo6CgG97TLPQvBL4Vc+yKZpmST3KaeEaON1ZCE0L5opxd
         u5obi33rP5cvvnH7bOcLCr+3qTNA037kYCWn5sTPs//u7vSwhSNK4nYveBhhBs7pnw59
         TRyQzlCVWX8sI9l94vnQ6RblhNLcI/RS53xIyHlpNGIFlNsydrzMY5Paf6vLilJEWR2e
         AXF8OAn2JdSyQixWFvH3JPg78VP54gZvbAlopxO1vAhR7/KCyA3o5eD9naf0Mp4NOkji
         mXAQ==
X-Gm-Message-State: AOAM532248xt5BFv1acuQRgrSWOpteQkxthdHUxVk16ytISE+BniCR0x
        vKkTG14xYdKIB4HAbBgXRtcdQh5V2N0g0B7xvPA=
X-Google-Smtp-Source: ABdhPJwlVF5NL7IDHxDY470spr2TdqTHp+UBhjYPZtA4Q8NYsgMmAJwGcBrjGaBtPSNm5cqKkAgFOUAiM2AiVIUjc4s=
X-Received: by 2002:a17:906:680c:: with SMTP id k12mr37161975ejr.85.1632249931299;
 Tue, 21 Sep 2021 11:45:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210920085436.20939-1-mgorman@techsingularity.net> <20210920085436.20939-3-mgorman@techsingularity.net>
In-Reply-To: <20210920085436.20939-3-mgorman@techsingularity.net>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 21 Sep 2021 11:45:19 -0700
Message-ID: <CAHbLzkoSzvC=hEOZa5xc98oJKss4tz3Ja7qU8_iQUMLgWsEQWg@mail.gmail.com>
Subject: Re: [PATCH 2/5] mm/vmscan: Throttle reclaim and compaction when too
 may pages are isolated
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Linux-MM <linux-mm@kvack.org>, NeilBrown <neilb@suse.de>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Dave Chinner <david@fromorbit.com>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 20, 2021 at 1:55 AM Mel Gorman <mgorman@techsingularity.net> wrote:
>
> Page reclaim throttles on congestion if too many parallel reclaim instances
> have isolated too many pages. This makes no sense, excessive parallelisation
> has nothing to do with writeback or congestion.
>
> This patch creates an additional workqueue to sleep on when too many
> pages are isolated. The throttled tasks are woken when the number
> of isolated pages is reduced or a timeout occurs. There may be
> some false positive wakeups for GFP_NOIO/GFP_NOFS callers but
> the tasks will throttle again if necessary.
>
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> ---
>  include/linux/mmzone.h        |  4 +++-
>  include/trace/events/vmscan.h |  4 +++-
>  mm/compaction.c               |  2 +-
>  mm/internal.h                 |  2 ++
>  mm/page_alloc.c               |  6 +++++-
>  mm/vmscan.c                   | 22 ++++++++++++++++------
>  6 files changed, 30 insertions(+), 10 deletions(-)
>
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index ef0a63ebd21d..ca65d6a64bdd 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -275,6 +275,8 @@ enum lru_list {
>
>  enum vmscan_throttle_state {
>         VMSCAN_THROTTLE_WRITEBACK,
> +       VMSCAN_THROTTLE_ISOLATED,
> +       NR_VMSCAN_THROTTLE,
>  };
>
>  #define for_each_lru(lru) for (lru = 0; lru < NR_LRU_LISTS; lru++)
> @@ -846,7 +848,7 @@ typedef struct pglist_data {
>         int node_id;
>         wait_queue_head_t kswapd_wait;
>         wait_queue_head_t pfmemalloc_wait;
> -       wait_queue_head_t reclaim_wait; /* wq for throttling reclaim */
> +       wait_queue_head_t reclaim_wait[NR_VMSCAN_THROTTLE];
>         atomic_t nr_reclaim_throttled;  /* nr of throtted tasks */
>         unsigned long nr_reclaim_start; /* nr pages written while throttled
>                                          * when throttling started. */
> diff --git a/include/trace/events/vmscan.h b/include/trace/events/vmscan.h
> index c317f9fe0d17..d4905bd9e9c4 100644
> --- a/include/trace/events/vmscan.h
> +++ b/include/trace/events/vmscan.h
> @@ -28,10 +28,12 @@
>                 ) : "RECLAIM_WB_NONE"
>
>  #define _VMSCAN_THROTTLE_WRITEBACK     (1 << VMSCAN_THROTTLE_WRITEBACK)
> +#define _VMSCAN_THROTTLE_ISOLATED      (1 << VMSCAN_THROTTLE_ISOLATED)
>
>  #define show_throttle_flags(flags)                                             \
>         (flags) ? __print_flags(flags, "|",                                     \
> -               {_VMSCAN_THROTTLE_WRITEBACK,    "VMSCAN_THROTTLE_WRITEBACK"}    \
> +               {_VMSCAN_THROTTLE_WRITEBACK,    "VMSCAN_THROTTLE_WRITEBACK"},   \
> +               {_VMSCAN_THROTTLE_ISOLATED,     "VMSCAN_THROTTLE_ISOLATED"}     \
>                 ) : "VMSCAN_THROTTLE_NONE"
>
>
> diff --git a/mm/compaction.c b/mm/compaction.c
> index bfc93da1c2c7..221c9c10ad7e 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -822,7 +822,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>                 if (cc->mode == MIGRATE_ASYNC)
>                         return -EAGAIN;
>
> -               congestion_wait(BLK_RW_ASYNC, HZ/10);
> +               reclaim_throttle(pgdat, VMSCAN_THROTTLE_ISOLATED, HZ/10);

It seems waking up tasks is missed in compaction's
too_many_isolated(). There are two too_many_isolated(), one is for
compaction, the other is for reclaimer. I saw the waking up code was
added to the reclaimer's in the below. Or the compaction one is left
out intentionally?

>
>                 if (fatal_signal_pending(current))
>                         return -EINTR;
> diff --git a/mm/internal.h b/mm/internal.h
> index e25b3686bfab..e6cd22fb5a43 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -118,6 +118,8 @@ extern unsigned long highest_memmap_pfn;
>   */
>  extern int isolate_lru_page(struct page *page);
>  extern void putback_lru_page(struct page *page);
> +extern void reclaim_throttle(pg_data_t *pgdat, enum vmscan_throttle_state reason,
> +                                                               long timeout);
>
>  /*
>   * in mm/rmap.c:
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index d849ddfc1e51..78e538067651 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -7389,6 +7389,8 @@ static void pgdat_init_kcompactd(struct pglist_data *pgdat) {}
>
>  static void __meminit pgdat_init_internals(struct pglist_data *pgdat)
>  {
> +       int i;
> +
>         pgdat_resize_init(pgdat);
>
>         pgdat_init_split_queue(pgdat);
> @@ -7396,7 +7398,9 @@ static void __meminit pgdat_init_internals(struct pglist_data *pgdat)
>
>         init_waitqueue_head(&pgdat->kswapd_wait);
>         init_waitqueue_head(&pgdat->pfmemalloc_wait);
> -       init_waitqueue_head(&pgdat->reclaim_wait);
> +
> +       for (i = 0; i < NR_VMSCAN_THROTTLE; i++)
> +               init_waitqueue_head(&pgdat->reclaim_wait[i]);
>
>         pgdat_page_ext_init(pgdat);
>         lruvec_init(&pgdat->__lruvec);
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index b58ea0b13286..eb81dcac15b2 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1006,11 +1006,10 @@ static void handle_write_error(struct address_space *mapping,
>         unlock_page(page);
>  }
>
> -static void
> -reclaim_throttle(pg_data_t *pgdat, enum vmscan_throttle_state reason,
> +void reclaim_throttle(pg_data_t *pgdat, enum vmscan_throttle_state reason,
>                                                         long timeout)
>  {
> -       wait_queue_head_t *wqh = &pgdat->reclaim_wait;
> +       wait_queue_head_t *wqh = &pgdat->reclaim_wait[reason];
>         unsigned long start = jiffies;
>         long ret;
>         DEFINE_WAIT(wait);
> @@ -1044,7 +1043,7 @@ void __acct_reclaim_writeback(pg_data_t *pgdat, struct page *page)
>                 READ_ONCE(pgdat->nr_reclaim_start);
>
>         if (nr_written > SWAP_CLUSTER_MAX * nr_throttled)
> -               wake_up_interruptible_all(&pgdat->reclaim_wait);
> +               wake_up_interruptible_all(&pgdat->reclaim_wait[VMSCAN_THROTTLE_WRITEBACK]);
>  }
>
>  /* possible outcome of pageout() */
> @@ -2159,6 +2158,7 @@ static int too_many_isolated(struct pglist_data *pgdat, int file,
>                 struct scan_control *sc)
>  {
>         unsigned long inactive, isolated;
> +       bool too_many;
>
>         if (current_is_kswapd())
>                 return 0;
> @@ -2182,6 +2182,17 @@ static int too_many_isolated(struct pglist_data *pgdat, int file,
>         if ((sc->gfp_mask & (__GFP_IO | __GFP_FS)) == (__GFP_IO | __GFP_FS))
>                 inactive >>= 3;
>
> +       too_many = isolated > inactive;
> +
> +       /* Wake up tasks throttled due to too_many_isolated. */
> +       if (!too_many) {
> +               wait_queue_head_t *wqh;
> +
> +               wqh = &pgdat->reclaim_wait[VMSCAN_THROTTLE_ISOLATED];
> +               if (waitqueue_active(wqh))
> +                       wake_up_interruptible_all(wqh);
> +       }
> +
>         return isolated > inactive;

Just return too_many?

>  }
>
> @@ -2291,8 +2302,7 @@ shrink_inactive_list(unsigned long nr_to_scan, struct lruvec *lruvec,
>                         return 0;
>
>                 /* wait a bit for the reclaimer. */
> -               msleep(100);
> -               stalled = true;
> +               reclaim_throttle(pgdat, VMSCAN_THROTTLE_ISOLATED, HZ/10);
>
>                 /* We are about to die and free our memory. Return now. */
>                 if (fatal_signal_pending(current))
> --
> 2.31.1
>
>
