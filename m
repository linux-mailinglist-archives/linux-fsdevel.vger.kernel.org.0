Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E248032C570
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Mar 2021 01:59:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355160AbhCDAUp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Mar 2021 19:20:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388011AbhCCUYG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Mar 2021 15:24:06 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB9A6C061756;
        Wed,  3 Mar 2021 12:23:26 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id e6so17221676pgk.5;
        Wed, 03 Mar 2021 12:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0FH7LxOsmxIsgoTenyw1jRon/uhYAlBiA4+ZL3nwHtQ=;
        b=AIxxwOFh8H6cXbMpEdUcTMgTdPU74pl6sVrvlULaxh05OgQMd7JETuqq6JECoOf+1t
         SNlWMPlsbvKX8LXBSllxuBVY4Fh4k3kT9RciAiOqo70OYzQagHRgd1TTACTGBOS8a1Zl
         D4GuPN//j2pELtPdyiQ6YCP7l9V8CtyHtz5llwdzhNs2iAmYf7f01+tlPM6xPuDFMTgR
         d2tWa8VGxraO/6LahwJzsCNWcC3FzO7b85LnyOymqMgzzk9Q3NBzwLnZApS4/VdWzR3s
         Ejev7zAmc8y9v2fFS2VwEjmP+tfa70h2/0Jw85ETgMA7OR9zaP47plt7PYF6SxvTT5kS
         PO5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=0FH7LxOsmxIsgoTenyw1jRon/uhYAlBiA4+ZL3nwHtQ=;
        b=ClfWi/wOKB23vs1bJG0OCtPQXOMBQCH8+veGg92nipXw6evdmAHivTSvnwle6YG9vD
         akYgRroqjYd8OX6YRtM64SfFhZoAonYfSJkkZAJPO1nch8AXjGj3rP0LZ84IhG9uinj7
         ziUr/KW0aOGMkBQyudW9fLtZ72NYAmOzoaGvnYPb4U85Jmchwj7ws/gyd5NGI4W35KDr
         q8UO3AJlIZNr40/49NQBW03va+AoXYw8BZVzk8sFmF+z63+fsKuqVq1XQwumerjqfeVr
         Qe/+oCcFknRC1rKY5IP/xi/NUSsjNs3X+fLYvqK7NtWhEKJbQihlIrvDOT9WhlP1Dv55
         QNCw==
X-Gm-Message-State: AOAM532WFwhmqEgL5jsP5bbW0N7EupEsdxIyZhktlYrG7GxPxdYhK/HB
        GbC3/VAdMC2L/Wtbh3Czv3g=
X-Google-Smtp-Source: ABdhPJzjTbg+doQsb4ri01ZrBnPufRMmByvBrcHUbX8wMYPuO9f//uSNLvMzwnmMPt3noGJiw4BXEA==
X-Received: by 2002:a63:74d:: with SMTP id 74mr619392pgh.316.1614803006263;
        Wed, 03 Mar 2021 12:23:26 -0800 (PST)
Received: from google.com ([2620:15c:211:201:c87:c34:99dc:ba23])
        by smtp.gmail.com with ESMTPSA id g15sm25192777pfb.30.2021.03.03.12.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 12:23:24 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Wed, 3 Mar 2021 12:23:22 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, joaodias@google.com,
        surenb@google.com, cgoldswo@codeaurora.org, willy@infradead.org,
        david@redhat.com, vbabka@suse.cz, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: disable LRU pagevec during the migration
 temporarily
Message-ID: <YD/wOq3lf9I5HK85@google.com>
References: <20210302210949.2440120-1-minchan@kernel.org>
 <YD+F4LgPH0zMBDGW@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YD+F4LgPH0zMBDGW@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 03, 2021 at 01:49:36PM +0100, Michal Hocko wrote:
> On Tue 02-03-21 13:09:48, Minchan Kim wrote:
> > LRU pagevec holds refcount of pages until the pagevec are drained.
> > It could prevent migration since the refcount of the page is greater
> > than the expection in migration logic. To mitigate the issue,
> > callers of migrate_pages drains LRU pagevec via migrate_prep or
> > lru_add_drain_all before migrate_pages call.
> > 
> > However, it's not enough because pages coming into pagevec after the
> > draining call still could stay at the pagevec so it could keep
> > preventing page migration. Since some callers of migrate_pages have
> > retrial logic with LRU draining, the page would migrate at next trail
> > but it is still fragile in that it doesn't close the fundamental race
> > between upcoming LRU pages into pagvec and migration so the migration
> > failure could cause contiguous memory allocation failure in the end.
> > 
> > To close the race, this patch disables lru caches(i.e, pagevec)
> > during ongoing migration until migrate is done.
> > 
> > Since it's really hard to reproduce, I measured how many times
> > migrate_pages retried with force mode below debug code.
> > 
> > int migrate_pages(struct list_head *from, new_page_t get_new_page,
> > 			..
> > 			..
> > 
> > if (rc && reason == MR_CONTIG_RANGE && pass > 2) {
> >        printk(KERN_ERR, "pfn 0x%lx reason %d\n", page_to_pfn(page), rc);
> >        dump_page(page, "fail to migrate");
> > }
> > 
> > The test was repeating android apps launching with cma allocation
> > in background every five seconds. Total cma allocation count was
> > about 500 during the testing. With this patch, the dump_page count
> > was reduced from 400 to 30.
> 
> Have you seen any improvement on the CMA allocation success rate?

Unfortunately, the cma alloc failure rate with reasonable margin
of error is really hard to reproduce under real workload.
That's why I measured the soft metric instead of direct cma fail
under real workload(I don't want to make some adhoc artificial
benchmark and keep tunes system knobs until it could show 
extremly exaggerated result to convice patch effect).

Please say if you belive this work is pointless unless there is
stable data under reproducible scenario. I am happy to drop it.

> 
> > Signed-off-by: Minchan Kim <minchan@kernel.org>
> > ---
> > * from RFC - http://lore.kernel.org/linux-mm/20210216170348.1513483-1-minchan@kernel.org
> >   * use atomic and lru_add_drain_all for strict ordering - mhocko
> >   * lru_cache_disable/enable - mhocko
> > 
> >  fs/block_dev.c          |  2 +-
> >  include/linux/migrate.h |  6 +++--
> >  include/linux/swap.h    |  4 ++-
> >  mm/compaction.c         |  4 +--
> >  mm/fadvise.c            |  2 +-
> >  mm/gup.c                |  2 +-
> >  mm/khugepaged.c         |  2 +-
> >  mm/ksm.c                |  2 +-
> >  mm/memcontrol.c         |  4 +--
> >  mm/memfd.c              |  2 +-
> >  mm/memory-failure.c     |  2 +-
> >  mm/memory_hotplug.c     |  2 +-
> >  mm/mempolicy.c          |  6 +++++
> >  mm/migrate.c            | 15 ++++++-----
> >  mm/page_alloc.c         |  5 +++-
> >  mm/swap.c               | 55 +++++++++++++++++++++++++++++++++++------
> >  16 files changed, 85 insertions(+), 30 deletions(-)
> 
> The churn seems to be quite big for something that should have been a
> very small change. Have you considered not changing lru_add_drain_all
> but rather introduce __lru_add_dain_all that would implement the
> enforced flushing?

Good idea.

> 
> [...]
> > +static atomic_t lru_disable_count = ATOMIC_INIT(0);
> > +
> > +bool lru_cache_disabled(void)
> > +{
> > +	return atomic_read(&lru_disable_count);
> > +}
> > +
> > +void lru_cache_disable(void)
> > +{
> > +	/*
> > +	 * lru_add_drain_all's IPI will make sure no new pages are added
> > +	 * to the pcp lists and drain them all.
> > +	 */
> > +	atomic_inc(&lru_disable_count);
> 
> As already mentioned in the last review. The IPI reference is more
> cryptic than useful. I would go with something like this instead
> 
> 	/*
> 	 * lru_add_drain_all in the force mode will schedule draining on
> 	 * all online CPUs so any calls of lru_cache_disabled wrapped by
> 	 * local_lock or preemption disabled would be  ordered by that.
> 	 * The atomic operation doesn't need to have stronger ordering
> 	 * requirements because that is enforece by the scheduling
> 	 * guarantees.
> 	 */

Thanks for the nice description.
I will use it in next revision if you believe this work is useful.
