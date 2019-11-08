Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1613DF58FB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2019 22:00:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730598AbfKHVAT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Nov 2019 16:00:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:52974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726227AbfKHVAT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Nov 2019 16:00:19 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0EECF214DB;
        Fri,  8 Nov 2019 21:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573246818;
        bh=YdoZzimebFdQV6O7Wb5LCogyJVEvxDbTFEtZFm0YoJw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BDm7OoLZQoFXeZFGioW90fJ5lk6UvxKXvNJcW02TE6ixkVJGNNmaIKxvncUklmY0l
         dhKA9J8H01YNa8KBUc4U2zzFIdxe1TP2kSrVoywIVopxa72SUzWscau//ILU10IAF/
         QtZXjgUYH7v9Mgh7/ZAQ0uZlbRAGjsCU+kUbaCCs=
Date:   Fri, 8 Nov 2019 13:00:17 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Hillf Danton <hdanton@sina.com>
Cc:     linux-mm <linux-mm@kvack.org>,
        fsdev <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Tejun Heo <tj@kernel.org>, Jan Kara <jack@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Minchan Kim <minchan@kernel.org>, Mel Gorman <mgorman@suse.de>
Subject: Re: [RFC v2] writeback: add elastic bdi in cgwb bdp
Message-Id: <20191108130017.335cd353dd603dbba80b63dd@linux-foundation.org>
In-Reply-To: <20191026104656.15176-1-hdanton@sina.com>
References: <20191026104656.15176-1-hdanton@sina.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 26 Oct 2019 18:46:56 +0800 Hillf Danton <hdanton@sina.com> wrote:

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

I'm finding both the changelog and the patch rather hard to understand.
The absence of code comments doesn't help.  But the test robot
performance results look nice.

Presumably you did your own performance testing.  Please share the
results of that in the changelog.

> 
> --- a/include/linux/backing-dev-defs.h
> +++ b/include/linux/backing-dev-defs.h
> @@ -170,6 +170,8 @@ struct bdi_writeback {
>  
>  	struct list_head bdi_node;	/* anchored at bdi->wb_list */
>  
> +	struct wait_queue_head bdp_waitq;

Please add comments which help the reader find out what "bdp" stands
for.


>  #ifdef CONFIG_CGROUP_WRITEBACK
>  	struct percpu_ref refcnt;	/* used only for !root wb's */
>  	struct fprop_local_percpu memcg_completions;
> --- a/mm/backing-dev.c
> +++ b/mm/backing-dev.c
> @@ -324,6 +324,8 @@ static int wb_init(struct bdi_writeback
>  			goto out_destroy_stat;
>  	}
>  
> +	init_waitqueue_head(&wb->bdp_waitq);
> +
>  	return 0;
>  
>  out_destroy_stat:
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -1551,6 +1551,39 @@ static inline void wb_dirty_limits(struc
>  	}
>  }
>
> +static bool cgwb_bdp_should_throttle(struct bdi_writeback *wb)

Please document this function.  Describe the "why" not the "what".

Comment should help readers understand what "cgwb" means.

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

Add a comment explaining what's going on here and why we're doing this.

> +	return gdtc.dirty > gdtc.thresh &&
> +		wb_stat(wb, WB_DIRTIED) >
> +		wb_stat(wb, WB_WRITTEN) +
> +		wb_stat_error();

Why?

> +}
> +
> +static inline void cgwb_bdp(struct bdi_writeback *wb)
> +{
> +	wait_event_interruptible_timeout(wb->bdp_waitq,
> +			!cgwb_bdp_should_throttle(wb), HZ);
> +}
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
>  	/*
>  	 * This may be called on clean wb's and proportional distribution
>  	 * may not make sense, just use the original @nr_pages in those
> @@ -1604,6 +1606,7 @@ static long writeback_chunk_size(struct
>  		pages = min(pages, work->nr_pages);
>  		pages = round_down(pages + MIN_WRITEBACK_PAGES,
>  				   MIN_WRITEBACK_PAGES);
> +		pages = work->nr_pages;
>  	}
>  
>  	return pages;
> @@ -2092,6 +2095,9 @@ void wb_workfn(struct work_struct *work)
>  		wb_wakeup_delayed(wb);
>  
>  	current->flags &= ~PF_SWAPWRITE;
> +
> +	if (waitqueue_active(&wb->bdp_waitq))
> +		wake_up_all(&wb->bdp_waitq);
>  }

Does this patch affect both cgroup writeback and global writeback? 
Were both tested?  Performance results of both?

