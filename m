Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08A0CFC634
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2019 13:18:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbfKNMSA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Nov 2019 07:18:00 -0500
Received: from mx2.suse.de ([195.135.220.15]:45366 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726263AbfKNMSA (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Nov 2019 07:18:00 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 607C0B22A;
        Thu, 14 Nov 2019 12:17:48 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id DF9031E4331; Thu, 14 Nov 2019 13:17:46 +0100 (CET)
Date:   Thu, 14 Nov 2019 13:17:46 +0100
From:   Jan Kara <jack@suse.cz>
To:     Hillf Danton <hdanton@sina.com>
Cc:     linux-mm <linux-mm@kvack.org>,
        fsdev <linux-fsdevel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Tejun Heo <tj@kernel.org>, Jan Kara <jack@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Minchan Kim <minchan@kernel.org>, Mel Gorman <mgorman@suse.de>
Subject: Re: [RFC v2] writeback: add elastic bdi in cgwb bdp
Message-ID: <20191114121746.GD28486@quack2.suse.cz>
References: <20191026104656.15176-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191026104656.15176-1-hdanton@sina.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat 26-10-19 18:46:56, Hillf Danton wrote:
> 
> The elastic bdi is the mirror bdi of spinning disks, SSD, USB and
> other storage devices/instruments on market. The performance of
> ebdi goes up and down as the pattern of IO dispatched changes, as
> approximately estimated as below.
> 
> 	P = j(..., IO pattern);
> 
> In ebdi's view, the bandwidth currently measured in balancing dirty
> pages has close relation to its performance because the former is a
> part of the latter.
> 
> 	B = y(P);
> 
> The functions above suggest there may be a layer violation if it
> could be better measured somewhere below fs.
> 
> It is measured however to the extent that makes every judge happy,
> and is playing a role in dispatching IO with the IO pattern entirely
> ignored that is volatile in nature.
> 
> And it helps to throttle the dirty speed, with the figure ignored
> that DRAM in general is x10 faster than ebdi. If B is half of P for
> instance, then it is near 5% of dirty speed, just 2 points from the
> figure in the snippet below.
> 
> /*
>  * If ratelimit_pages is too high then we can get into dirty-data overload
>  * if a large number of processes all perform writes at the same time.
>  * If it is too low then SMP machines will call the (expensive)
>  * get_writeback_state too often.
>  *
>  * Here we set ratelimit_pages to a level which ensures that when all CPUs are
>  * dirtying in parallel, we cannot go more than 3% (1/32) over the dirty memory
>  * thresholds.
>  */
> 
> To prevent dirty speed from running away from laundry speed, ebdi
> suggests the walk-dog method to put in bdp as a leash seems to
> churn less in IO pattern.
> 
> V2 is based on next-20191025.

Honestly, the changelog is still pretty incomprehensible as Andrew already
mentioned. Also I completely miss there, what are the benefits of this work
compared to what we currently have.

> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -1551,6 +1551,39 @@ static inline void wb_dirty_limits(struc
>  	}
>  }
>  
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
> +	return gdtc.dirty > gdtc.thresh &&
> +		wb_stat(wb, WB_DIRTIED) >
> +		wb_stat(wb, WB_WRITTEN) +
> +		wb_stat_error();
> +}

This looks like a very primitive version of what we already have in
balance_dirty_pages(). Just without support for cgroup-aware writeback, or
any guarantees on amount of written out data.

> +
> +static inline void cgwb_bdp(struct bdi_writeback *wb)
> +{
> +	wait_event_interruptible_timeout(wb->bdp_waitq,
> +			!cgwb_bdp_should_throttle(wb), HZ);
> +}

This breaks dirty throttling as no dirtier is ever delayed for more than 1
second. Under heavier IO load, it can clearly take longer to clean enough
pages before dirtier can continue...

> +
>  /*
>   * balance_dirty_pages() must be called by processes which are generating dirty
>   * data.  It looks at the number of dirty pages in the machine and will force
> @@ -1910,7 +1943,7 @@ void balance_dirty_pages_ratelimited(str
>  	preempt_enable();
>  
>  	if (unlikely(current->nr_dirtied >= ratelimit))
> -		balance_dirty_pages(wb, current->nr_dirtied);
> +		cgwb_bdp(wb);
>  
>  	wb_put(wb);
>  }
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -811,6 +811,8 @@ static long wb_split_bdi_pages(struct bd
>  	if (nr_pages == LONG_MAX)
>  		return LONG_MAX;
>  
> +	return nr_pages;
> +

So you've just broken cgroup aware writeback with this. I won't even speak
of the fact that this is a return in the middle of the function. But let's
take this as an experimental patch to show out something...

>  	/*
>  	 * This may be called on clean wb's and proportional distribution
>  	 * may not make sense, just use the original @nr_pages in those
> @@ -1604,6 +1606,7 @@ static long writeback_chunk_size(struct
>  		pages = min(pages, work->nr_pages);
>  		pages = round_down(pages + MIN_WRITEBACK_PAGES,
>  				   MIN_WRITEBACK_PAGES);
> +		pages = work->nr_pages;
>  	}

This breaks livelock prevention in the writeback code. Now we can write out
single inode basically forever.

> @@ -2092,6 +2095,9 @@ void wb_workfn(struct work_struct *work)
>  		wb_wakeup_delayed(wb);
>  
>  	current->flags &= ~PF_SWAPWRITE;
> +
> +	if (waitqueue_active(&wb->bdp_waitq))
> +		wake_up_all(&wb->bdp_waitq);
>  }

If anyone submits writeback work with a few pages, this will result in
releasing dirtying processes prematurely (before we are guaranteed we have
got below dirty limits).

So to summarize, I'm sorry but this patch looks very broken to me and I
don't see how your proposed throttling method is any better than what we
already have.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
