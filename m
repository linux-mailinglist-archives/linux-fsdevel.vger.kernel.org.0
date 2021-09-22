Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 365AC41434D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Sep 2021 10:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233653AbhIVIMk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Sep 2021 04:12:40 -0400
Received: from outbound-smtp09.blacknight.com ([46.22.139.14]:44991 "EHLO
        outbound-smtp09.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233590AbhIVIMh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Sep 2021 04:12:37 -0400
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp09.blacknight.com (Postfix) with ESMTPS id 5CEC21C601B
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Sep 2021 09:11:07 +0100 (IST)
Received: (qmail 29350 invoked from network); 22 Sep 2021 08:11:07 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.29])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 22 Sep 2021 08:11:07 -0000
Date:   Wed, 22 Sep 2021 09:11:04 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Yang Shi <shy828301@gmail.com>
Cc:     Linux-MM <linux-mm@kvack.org>, NeilBrown <neilb@suse.de>,
        Theodore Ts'o <tytso@mit.edu>,
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
Subject: Re: [PATCH 2/5] mm/vmscan: Throttle reclaim and compaction when too
 may pages are isolated
Message-ID: <20210922081104.GV3959@techsingularity.net>
References: <20210920085436.20939-1-mgorman@techsingularity.net>
 <20210920085436.20939-3-mgorman@techsingularity.net>
 <CAHbLzkoSzvC=hEOZa5xc98oJKss4tz3Ja7qU8_iQUMLgWsEQWg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAHbLzkoSzvC=hEOZa5xc98oJKss4tz3Ja7qU8_iQUMLgWsEQWg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 21, 2021 at 11:45:19AM -0700, Yang Shi wrote:
> On Mon, Sep 20, 2021 at 1:55 AM Mel Gorman <mgorman@techsingularity.net> wrote:
> >
> > Page reclaim throttles on congestion if too many parallel reclaim instances
> > have isolated too many pages. This makes no sense, excessive parallelisation
> > has nothing to do with writeback or congestion.
> >
> > This patch creates an additional workqueue to sleep on when too many
> > pages are isolated. The throttled tasks are woken when the number
> > of isolated pages is reduced or a timeout occurs. There may be
> > some false positive wakeups for GFP_NOIO/GFP_NOFS callers but
> > the tasks will throttle again if necessary.
> >
> > Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> > ---
> >  include/linux/mmzone.h        |  4 +++-
> >  include/trace/events/vmscan.h |  4 +++-
> >  mm/compaction.c               |  2 +-
> >  mm/internal.h                 |  2 ++
> >  mm/page_alloc.c               |  6 +++++-
> >  mm/vmscan.c                   | 22 ++++++++++++++++------
> >  6 files changed, 30 insertions(+), 10 deletions(-)
> >
> > diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> > index ef0a63ebd21d..ca65d6a64bdd 100644
> > --- a/include/linux/mmzone.h
> > +++ b/include/linux/mmzone.h
> > @@ -275,6 +275,8 @@ enum lru_list {
> >
> >  enum vmscan_throttle_state {
> >         VMSCAN_THROTTLE_WRITEBACK,
> > +       VMSCAN_THROTTLE_ISOLATED,
> > +       NR_VMSCAN_THROTTLE,
> >  };
> >
> >  #define for_each_lru(lru) for (lru = 0; lru < NR_LRU_LISTS; lru++)
> > @@ -846,7 +848,7 @@ typedef struct pglist_data {
> >         int node_id;
> >         wait_queue_head_t kswapd_wait;
> >         wait_queue_head_t pfmemalloc_wait;
> > -       wait_queue_head_t reclaim_wait; /* wq for throttling reclaim */
> > +       wait_queue_head_t reclaim_wait[NR_VMSCAN_THROTTLE];
> >         atomic_t nr_reclaim_throttled;  /* nr of throtted tasks */
> >         unsigned long nr_reclaim_start; /* nr pages written while throttled
> >                                          * when throttling started. */
> > diff --git a/include/trace/events/vmscan.h b/include/trace/events/vmscan.h
> > index c317f9fe0d17..d4905bd9e9c4 100644
> > --- a/include/trace/events/vmscan.h
> > +++ b/include/trace/events/vmscan.h
> > @@ -28,10 +28,12 @@
> >                 ) : "RECLAIM_WB_NONE"
> >
> >  #define _VMSCAN_THROTTLE_WRITEBACK     (1 << VMSCAN_THROTTLE_WRITEBACK)
> > +#define _VMSCAN_THROTTLE_ISOLATED      (1 << VMSCAN_THROTTLE_ISOLATED)
> >
> >  #define show_throttle_flags(flags)                                             \
> >         (flags) ? __print_flags(flags, "|",                                     \
> > -               {_VMSCAN_THROTTLE_WRITEBACK,    "VMSCAN_THROTTLE_WRITEBACK"}    \
> > +               {_VMSCAN_THROTTLE_WRITEBACK,    "VMSCAN_THROTTLE_WRITEBACK"},   \
> > +               {_VMSCAN_THROTTLE_ISOLATED,     "VMSCAN_THROTTLE_ISOLATED"}     \
> >                 ) : "VMSCAN_THROTTLE_NONE"
> >
> >
> > diff --git a/mm/compaction.c b/mm/compaction.c
> > index bfc93da1c2c7..221c9c10ad7e 100644
> > --- a/mm/compaction.c
> > +++ b/mm/compaction.c
> > @@ -822,7 +822,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
> >                 if (cc->mode == MIGRATE_ASYNC)
> >                         return -EAGAIN;
> >
> > -               congestion_wait(BLK_RW_ASYNC, HZ/10);
> > +               reclaim_throttle(pgdat, VMSCAN_THROTTLE_ISOLATED, HZ/10);
> 
> It seems waking up tasks is missed in compaction's
> too_many_isolated(). There are two too_many_isolated(), one is for
> compaction, the other is for reclaimer. I saw the waking up code was
> added to the reclaimer's in the below. Or the compaction one is left
> out intentionally?
> 

Compaction one was left out accidentally, I'll fix it. Thanks.

-- 
Mel Gorman
SUSE Labs
