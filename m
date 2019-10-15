Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4BFED7310
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2019 12:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbfJOKWO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Oct 2019 06:22:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:54028 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727810AbfJOKWN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Oct 2019 06:22:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5BE50B2D2;
        Tue, 15 Oct 2019 10:22:11 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 5A2961E485F; Tue, 15 Oct 2019 12:22:10 +0200 (CEST)
Date:   Tue, 15 Oct 2019 12:22:10 +0200
From:   Jan Kara <jack@suse.cz>
To:     Hillf Danton <hdanton@sina.com>
Cc:     mm <linux-mm@kvack.org>, fsdev <linux-fsdevel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux <linux-kernel@vger.kernel.org>,
        Roman Gushchin <guro@fb.com>, Tejun Heo <tj@kernel.org>,
        Jan Kara <jack@suse.cz>, Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Minchan Kim <minchan@kernel.org>, Mel Gorman <mgorman@suse.de>
Subject: Re: [RFC] writeback: add elastic bdi in cgwb bdp
Message-ID: <20191015102210.GA29554@quack2.suse.cz>
References: <20191012132740.12968-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191012132740.12968-1-hdanton@sina.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

On Sat 12-10-19 21:27:40, Hillf Danton wrote:
> The behaviors of the elastic bdi (ebdi) observed in the current cgwb
> bandwidth measurement include
> 
> 1, like spinning disks on market ebdi can do ~128MB/s IOs in consective
> minutes in few scenarios, or higher like SSD, or lower like USB key.
> 
> 2, with ebdi a bdi_writeback, wb-A, is able to do 80MB/s writeouts in the
> current time window of 200ms, while it was 16M/s in the previous one.
> 
> 3, it will be either 100MB/s in the next time window if wb-B joins wb-A
> writing pages out or 18MB/s if wb-C also decides to chime in.
> 
> With the help of bandwidth gauged above, what is left in balancing dirty
> pages, bdp, is try to make wb-A's laundry speed catch up dirty speed in
> every 200ms interval without knowing what wb-B is doing.
> 
> No heuristic is added in this work because ebdi does bdp without it.

Thanks for the patch but honestly, I have hard time understanding what is
the purpose of this patch from the changelog. Some kind of writeback
throttling? And why is this needed? Also some highlevel description of what
your solution is would be good...

								Honza
 
> Cc: Roman Gushchin <guro@fb.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Shakeel Butt <shakeelb@google.com>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Mel Gorman <mgorman@suse.de>
> Signed-off-by: Hillf Danton <hdanton@sina.com>
> ---
> 
> --- a/include/linux/backing-dev-defs.h
> +++ b/include/linux/backing-dev-defs.h
> @@ -157,6 +157,9 @@ struct bdi_writeback {
>  	struct list_head memcg_node;	/* anchored at memcg->cgwb_list */
>  	struct list_head blkcg_node;	/* anchored at blkcg->cgwb_list */
>  
> +#ifdef CONFIG_CGWB_BDP_WITH_EBDI
> +	struct wait_queue_head bdp_waitq;
> +#endif
>  	union {
>  		struct work_struct release_work;
>  		struct rcu_head rcu;
> --- a/mm/backing-dev.c
> +++ b/mm/backing-dev.c
> @@ -324,6 +324,10 @@ static int wb_init(struct bdi_writeback
>  			goto out_destroy_stat;
>  	}
>  
> +	if (IS_ENABLED(CONFIG_CGROUP_WRITEBACK) &&
> +	    IS_ENABLED(CONFIG_CGWB_BDP_WITH_EBDI))
> +		init_waitqueue_head(&wb->bdp_waitq);
> +
>  	return 0;
>  
>  out_destroy_stat:
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -1551,6 +1551,45 @@ static inline void wb_dirty_limits(struc
>  	}
>  }
>  
> +#if defined(CONFIG_CGROUP_WRITEBACK) && defined(CONFIG_CGWB_BDP_WITH_EBDI)
> +static bool cgwb_bdp_should_throttle(struct bdi_writeback *wb)
> +{
> +	struct dirty_throttle_control gdtc = { GDTC_INIT_NO_WB };
> +
> +	if (fatal_signal_pending(current))
> +		return false;
> +
> +	gdtc.avail = global_dirtyable_memory();
> +
> +	domain_dirty_limits(&gdtc);
> +
> +	gdtc.dirty = global_node_page_state(NR_FILE_DIRTY) +
> +			global_node_page_state(NR_UNSTABLE_NFS) +
> +			global_node_page_state(NR_WRITEBACK);
> +
> +	if (gdtc.dirty < gdtc.bg_thresh)
> +		return false;
> +
> +	if (!writeback_in_progress(wb))
> +		wb_start_background_writeback(wb);
> +
> +	/*
> +	 * throttle if laundry speed remarkably falls behind dirty speed
> +	 * in the current time window of 200ms
> +	 */
> +	return gdtc.dirty > gdtc.thresh &&
> +		wb_stat(wb, WB_DIRTIED) >
> +		wb_stat(wb, WB_WRITTEN) +
> +		wb_stat_error();
> +}
> +
> +static inline void cgwb_bdp(struct bdi_writeback *wb)
> +{
> +	wait_event_interruptible_timeout(wb->bdp_waitq,
> +			!cgwb_bdp_should_throttle(wb), HZ);
> +}
> +#endif
> +
>  /*
>   * balance_dirty_pages() must be called by processes which are generating dirty
>   * data.  It looks at the number of dirty pages in the machine and will force
> @@ -1910,7 +1949,11 @@ void balance_dirty_pages_ratelimited(str
>  	preempt_enable();
>  
>  	if (unlikely(current->nr_dirtied >= ratelimit))
> -		balance_dirty_pages(wb, current->nr_dirtied);
> +		if (IS_ENABLED(CONFIG_CGROUP_WRITEBACK) &&
> +		    IS_ENABLED(CONFIG_CGWB_BDP_WITH_EBDI))
> +			cgwb_bdp(wb);
> +		else
> +			balance_dirty_pages(wb, current->nr_dirtied);
>  
>  	wb_put(wb);
>  }
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -632,6 +632,11 @@ void wbc_detach_inode(struct writeback_c
>  	if (!wb)
>  		return;
>  
> +	if (IS_ENABLED(CONFIG_CGROUP_WRITEBACK) &&
> +	    IS_ENABLED(CONFIG_CGWB_BDP_WITH_EBDI))
> +		if (waitqueue_active(&wb->bdp_waitq))
> +			wake_up_all(&wb->bdp_waitq);
> +
>  	history = inode->i_wb_frn_history;
>  	avg_time = inode->i_wb_frn_avg_time;
>  
> @@ -811,6 +816,9 @@ static long wb_split_bdi_pages(struct bd
>  	if (nr_pages == LONG_MAX)
>  		return LONG_MAX;
>  
> +	if (IS_ENABLED(CONFIG_CGROUP_WRITEBACK) &&
> +	    IS_ENABLED(CONFIG_CGWB_BDP_WITH_EBDI))
> +		return nr_pages;
>  	/*
>  	 * This may be called on clean wb's and proportional distribution
>  	 * may not make sense, just use the original @nr_pages in those
> @@ -1599,6 +1607,10 @@ static long writeback_chunk_size(struct
>  	if (work->sync_mode == WB_SYNC_ALL || work->tagged_writepages)
>  		pages = LONG_MAX;
>  	else {
> +		if (IS_ENABLED(CONFIG_CGROUP_WRITEBACK) &&
> +		    IS_ENABLED(CONFIG_CGWB_BDP_WITH_EBDI))
> +			return work->nr_pages;
> +
>  		pages = min(wb->avg_write_bandwidth / 2,
>  			    global_wb_domain.dirty_limit / DIRTY_SCOPE);
>  		pages = min(pages, work->nr_pages);
> --
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
