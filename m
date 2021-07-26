Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8D53D5C3E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jul 2021 16:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234584AbhGZOPu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jul 2021 10:15:50 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:56716 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234389AbhGZOPt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jul 2021 10:15:49 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id B67251FEAE;
        Mon, 26 Jul 2021 14:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1627311376; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0VT1qHFuaGi5HevL4JbWscP3F55WTL8vce2y/4Jta6U=;
        b=MD9RSPdElhtJ88az1WD6rGMLGMTeTWrhi6uAGCrPTe06RXmbjTRL3kXy8gVLotkmwR9RZy
        M3wSKh++hnARJam92dodOqd+nBZm8Wm4SRT/vrMVlrGoPVHzQNXwd/dyjH6bAgKGfeSzCl
        jyX2SXNxBgB7cDfgR0wobiv8RCotKJo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1627311376;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0VT1qHFuaGi5HevL4JbWscP3F55WTL8vce2y/4Jta6U=;
        b=aYGXMyB5Y6AbI/4rx6laRnNlb/ufIPC6JdK3Y59PZwlBFITyTyL1/SEPTkjqx1IDed3l2E
        +Ttst4UDLo2COoAA==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id A0D11A3B8D;
        Mon, 26 Jul 2021 14:56:16 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 7892E1E3B13; Mon, 26 Jul 2021 16:56:16 +0200 (CEST)
Date:   Mon, 26 Jul 2021 16:56:16 +0200
From:   Jan Kara <jack@suse.cz>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
        Jan Kara <jack@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] writeback: memcg: simplify cgroup_writeback_by_id
Message-ID: <20210726145616.GG20621@quack2.suse.cz>
References: <20210722182627.2267368-1-shakeelb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210722182627.2267368-1-shakeelb@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 22-07-21 11:26:27, Shakeel Butt wrote:
> Currently cgroup_writeback_by_id calls mem_cgroup_wb_stats() to get
> dirty pages for a memcg. However mem_cgroup_wb_stats() does a lot more
> than just get the number of dirty pages. Just directly get the number of
> dirty pages instead of calling mem_cgroup_wb_stats(). Also
> cgroup_writeback_by_id() is only called for best-effort dirty flushing,
> so remove the unused 'nr' parameter and no need to explicitly flush
> memcg stats.
> 
> Signed-off-by: Shakeel Butt <shakeelb@google.com>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/fs-writeback.c          | 20 +++++++++-----------
>  include/linux/memcontrol.h | 15 +++++++++++++++
>  include/linux/writeback.h  |  2 +-
>  mm/memcontrol.c            | 13 +------------
>  4 files changed, 26 insertions(+), 24 deletions(-)
> 
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index 867984e778c3..35894a2dba75 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -1039,20 +1039,20 @@ static void bdi_split_work_to_wbs(struct backing_dev_info *bdi,
>   * cgroup_writeback_by_id - initiate cgroup writeback from bdi and memcg IDs
>   * @bdi_id: target bdi id
>   * @memcg_id: target memcg css id
> - * @nr: number of pages to write, 0 for best-effort dirty flushing
>   * @reason: reason why some writeback work initiated
>   * @done: target wb_completion
>   *
>   * Initiate flush of the bdi_writeback identified by @bdi_id and @memcg_id
>   * with the specified parameters.
>   */
> -int cgroup_writeback_by_id(u64 bdi_id, int memcg_id, unsigned long nr,
> +int cgroup_writeback_by_id(u64 bdi_id, int memcg_id,
>  			   enum wb_reason reason, struct wb_completion *done)
>  {
>  	struct backing_dev_info *bdi;
>  	struct cgroup_subsys_state *memcg_css;
>  	struct bdi_writeback *wb;
>  	struct wb_writeback_work *work;
> +	unsigned long dirty;
>  	int ret;
>  
>  	/* lookup bdi and memcg */
> @@ -1081,24 +1081,22 @@ int cgroup_writeback_by_id(u64 bdi_id, int memcg_id, unsigned long nr,
>  	}
>  
>  	/*
> -	 * If @nr is zero, the caller is attempting to write out most of
> +	 * The caller is attempting to write out most of
>  	 * the currently dirty pages.  Let's take the current dirty page
>  	 * count and inflate it by 25% which should be large enough to
>  	 * flush out most dirty pages while avoiding getting livelocked by
>  	 * concurrent dirtiers.
> +	 *
> +	 * BTW the memcg stats are flushed periodically and this is best-effort
> +	 * estimation, so some potential error is ok.
>  	 */
> -	if (!nr) {
> -		unsigned long filepages, headroom, dirty, writeback;
> -
> -		mem_cgroup_wb_stats(wb, &filepages, &headroom, &dirty,
> -				      &writeback);
> -		nr = dirty * 10 / 8;
> -	}
> +	dirty = memcg_page_state(mem_cgroup_from_css(memcg_css), NR_FILE_DIRTY);
> +	dirty = dirty * 10 / 8;
>  
>  	/* issue the writeback work */
>  	work = kzalloc(sizeof(*work), GFP_NOWAIT | __GFP_NOWARN);
>  	if (work) {
> -		work->nr_pages = nr;
> +		work->nr_pages = dirty;
>  		work->sync_mode = WB_SYNC_NONE;
>  		work->range_cyclic = 1;
>  		work->reason = reason;
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index b4c6b613e162..7028d8e4a3d7 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -989,6 +989,16 @@ static inline void mod_memcg_state(struct mem_cgroup *memcg,
>  	local_irq_restore(flags);
>  }
>  
> +static inline unsigned long memcg_page_state(struct mem_cgroup *memcg, int idx)
> +{
> +	long x = READ_ONCE(memcg->vmstats.state[idx]);
> +#ifdef CONFIG_SMP
> +	if (x < 0)
> +		x = 0;
> +#endif
> +	return x;
> +}
> +
>  static inline unsigned long lruvec_page_state(struct lruvec *lruvec,
>  					      enum node_stat_item idx)
>  {
> @@ -1444,6 +1454,11 @@ static inline void mod_memcg_state(struct mem_cgroup *memcg,
>  {
>  }
>  
> +static inline unsigned long memcg_page_state(struct mem_cgroup *memcg, int idx)
> +{
> +	return 0;
> +}
> +
>  static inline unsigned long lruvec_page_state(struct lruvec *lruvec,
>  					      enum node_stat_item idx)
>  {
> diff --git a/include/linux/writeback.h b/include/linux/writeback.h
> index 1f34ddf284dc..109e0dcd1d21 100644
> --- a/include/linux/writeback.h
> +++ b/include/linux/writeback.h
> @@ -218,7 +218,7 @@ void wbc_attach_and_unlock_inode(struct writeback_control *wbc,
>  void wbc_detach_inode(struct writeback_control *wbc);
>  void wbc_account_cgroup_owner(struct writeback_control *wbc, struct page *page,
>  			      size_t bytes);
> -int cgroup_writeback_by_id(u64 bdi_id, int memcg_id, unsigned long nr_pages,
> +int cgroup_writeback_by_id(u64 bdi_id, int memcg_id,
>  			   enum wb_reason reason, struct wb_completion *done);
>  void cgroup_writeback_umount(void);
>  bool cleanup_offline_cgwb(struct bdi_writeback *wb);
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 35bb5f8f9ea8..6580c2381a3e 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -631,17 +631,6 @@ void __mod_memcg_state(struct mem_cgroup *memcg, int idx, int val)
>  	cgroup_rstat_updated(memcg->css.cgroup, smp_processor_id());
>  }
>  
> -/* idx can be of type enum memcg_stat_item or node_stat_item. */
> -static unsigned long memcg_page_state(struct mem_cgroup *memcg, int idx)
> -{
> -	long x = READ_ONCE(memcg->vmstats.state[idx]);
> -#ifdef CONFIG_SMP
> -	if (x < 0)
> -		x = 0;
> -#endif
> -	return x;
> -}
> -
>  /* idx can be of type enum memcg_stat_item or node_stat_item. */
>  static unsigned long memcg_page_state_local(struct mem_cgroup *memcg, int idx)
>  {
> @@ -4609,7 +4598,7 @@ void mem_cgroup_flush_foreign(struct bdi_writeback *wb)
>  		    atomic_read(&frn->done.cnt) == 1) {
>  			frn->at = 0;
>  			trace_flush_foreign(wb, frn->bdi_id, frn->memcg_id);
> -			cgroup_writeback_by_id(frn->bdi_id, frn->memcg_id, 0,
> +			cgroup_writeback_by_id(frn->bdi_id, frn->memcg_id,
>  					       WB_REASON_FOREIGN_FLUSH,
>  					       &frn->done);
>  		}
> -- 
> 2.32.0.432.gabb21c7263-goog
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
