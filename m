Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A95D32C540
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Mar 2021 01:58:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1450253AbhCDATw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Mar 2021 19:19:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:56314 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1359150AbhCCNor (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Mar 2021 08:44:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1614775777; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BQssk3EVhR0e4qDrxXX/wywKQ0WwpPCIYl69HQscnfM=;
        b=BMTmdNky2gbKO1P0DmVGENevbyUFIr500AaV/XDrlVVF50OPVswWkMN5GBhHN0M1BKdNJy
        VfiQ2CSJAnm7KWRRb0hdy81w6Zfry39cU8DnZ+RMtdJ8+tTdBOlx1DoqD0yIWFQMSIZ3Vd
        p2+qHNYsyje0bIlY0JDfQcAZ2b/APxs=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A1759AC24;
        Wed,  3 Mar 2021 12:49:37 +0000 (UTC)
Date:   Wed, 3 Mar 2021 13:49:36 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, joaodias@google.com,
        surenb@google.com, cgoldswo@codeaurora.org, willy@infradead.org,
        david@redhat.com, vbabka@suse.cz, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: disable LRU pagevec during the migration
 temporarily
Message-ID: <YD+F4LgPH0zMBDGW@dhcp22.suse.cz>
References: <20210302210949.2440120-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210302210949.2440120-1-minchan@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 02-03-21 13:09:48, Minchan Kim wrote:
> LRU pagevec holds refcount of pages until the pagevec are drained.
> It could prevent migration since the refcount of the page is greater
> than the expection in migration logic. To mitigate the issue,
> callers of migrate_pages drains LRU pagevec via migrate_prep or
> lru_add_drain_all before migrate_pages call.
> 
> However, it's not enough because pages coming into pagevec after the
> draining call still could stay at the pagevec so it could keep
> preventing page migration. Since some callers of migrate_pages have
> retrial logic with LRU draining, the page would migrate at next trail
> but it is still fragile in that it doesn't close the fundamental race
> between upcoming LRU pages into pagvec and migration so the migration
> failure could cause contiguous memory allocation failure in the end.
> 
> To close the race, this patch disables lru caches(i.e, pagevec)
> during ongoing migration until migrate is done.
> 
> Since it's really hard to reproduce, I measured how many times
> migrate_pages retried with force mode below debug code.
> 
> int migrate_pages(struct list_head *from, new_page_t get_new_page,
> 			..
> 			..
> 
> if (rc && reason == MR_CONTIG_RANGE && pass > 2) {
>        printk(KERN_ERR, "pfn 0x%lx reason %d\n", page_to_pfn(page), rc);
>        dump_page(page, "fail to migrate");
> }
> 
> The test was repeating android apps launching with cma allocation
> in background every five seconds. Total cma allocation count was
> about 500 during the testing. With this patch, the dump_page count
> was reduced from 400 to 30.

Have you seen any improvement on the CMA allocation success rate?

> Signed-off-by: Minchan Kim <minchan@kernel.org>
> ---
> * from RFC - http://lore.kernel.org/linux-mm/20210216170348.1513483-1-minchan@kernel.org
>   * use atomic and lru_add_drain_all for strict ordering - mhocko
>   * lru_cache_disable/enable - mhocko
> 
>  fs/block_dev.c          |  2 +-
>  include/linux/migrate.h |  6 +++--
>  include/linux/swap.h    |  4 ++-
>  mm/compaction.c         |  4 +--
>  mm/fadvise.c            |  2 +-
>  mm/gup.c                |  2 +-
>  mm/khugepaged.c         |  2 +-
>  mm/ksm.c                |  2 +-
>  mm/memcontrol.c         |  4 +--
>  mm/memfd.c              |  2 +-
>  mm/memory-failure.c     |  2 +-
>  mm/memory_hotplug.c     |  2 +-
>  mm/mempolicy.c          |  6 +++++
>  mm/migrate.c            | 15 ++++++-----
>  mm/page_alloc.c         |  5 +++-
>  mm/swap.c               | 55 +++++++++++++++++++++++++++++++++++------
>  16 files changed, 85 insertions(+), 30 deletions(-)

The churn seems to be quite big for something that should have been a
very small change. Have you considered not changing lru_add_drain_all
but rather introduce __lru_add_dain_all that would implement the
enforced flushing?

[...]
> +static atomic_t lru_disable_count = ATOMIC_INIT(0);
> +
> +bool lru_cache_disabled(void)
> +{
> +	return atomic_read(&lru_disable_count);
> +}
> +
> +void lru_cache_disable(void)
> +{
> +	/*
> +	 * lru_add_drain_all's IPI will make sure no new pages are added
> +	 * to the pcp lists and drain them all.
> +	 */
> +	atomic_inc(&lru_disable_count);

As already mentioned in the last review. The IPI reference is more
cryptic than useful. I would go with something like this instead

	/*
	 * lru_add_drain_all in the force mode will schedule draining on
	 * all online CPUs so any calls of lru_cache_disabled wrapped by
	 * local_lock or preemption disabled would be  ordered by that.
	 * The atomic operation doesn't need to have stronger ordering
	 * requirements because that is enforece by the scheduling
	 * guarantees.
	 */
> +
> +	/*
> +	 * Clear the LRU lists so pages can be isolated.
> +	 */
> +	lru_add_drain_all(true);
> +}
-- 
Michal Hocko
SUSE Labs
