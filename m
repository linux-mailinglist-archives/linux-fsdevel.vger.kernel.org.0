Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF8D451155C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Apr 2022 13:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbiD0K7h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Apr 2022 06:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231838AbiD0K7S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Apr 2022 06:59:18 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB15F3DBDF9;
        Wed, 27 Apr 2022 03:36:45 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 913BF210E0;
        Wed, 27 Apr 2022 10:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651055804; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mRUb8wyZ9gvrhVfKTsx2CufKPjDw6DH/fInKZ0I7aG8=;
        b=B3U7nfOvfVQQlWmwMqjiywbBuPSvIo3mECDkcP9/YumfITm/xjMyqKKv6RVPNtSOErJxze
        FsXYNVrHfX1OE0aGCPHVTv3iD1WzmqDhx6KUMf6YaVNS9QyGtaS/KWt1n1+t4p8ilHaDZe
        4vvjEERhc2OQ9IJugAFnx1oHY6UImu0=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 5BF3E2C141;
        Wed, 27 Apr 2022 10:36:44 +0000 (UTC)
Date:   Wed, 27 Apr 2022 12:36:43 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Xie Yongmei <yongmeixie@hotmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, yongmeixie@hotmail.com,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>, Tejun Heo <tj@kernel.org>,
        linux-api@vger.kernel.org
Subject: Re: [PATCH 3/3] writeback: specify writeback period and expire
 interval per memcg
Message-ID: <YmkctSaPA8t9YrnR@dhcp22.suse.cz>
References: <20220427093241.108281-1-yongmeixie@hotmail.com>
 <TYYP286MB1115331A1F4852D7CA3E86A2C5FA9@TYYP286MB1115.JPNP286.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYYP286MB1115331A1F4852D7CA3E86A2C5FA9@TYYP286MB1115.JPNP286.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[updated CC list as per previous patch in the thread]

On Wed 27-04-22 05:32:41, Xie Yongmei wrote:
> dirty_writeback_interval: dirty wakeup period
> dirty_expire_interval: expire period
> 
> This patch provides per memcg setttings for writeback interval.
> 
> Dirty writeback could be triggered in the below ways:
>   - mark_inode_dirty: when the first time of dirtying pages for this inode,
> 		it tries to wakeup the callback hook wb_workfn in
> 		wakeup period later.
>   - wb_workfn: if there're more writeback works to do, it would wakeup the
> 		callback hook wb_workfn in another wakeup period later.
>   - external event: kswad found dirty pages piled up at the end of inactive
> 		list or desktop mode timer.
>   - buffered write context: balance_dirty_pages tries to wake up background
> 		writeback once dirty pages above freerun level of pages.
>   - sync context: sync(fs sync) writeback immediately
> 
> No matter how writeback is triggered, wb_workfn is the unique callback hook
> to manipulate the flushing things. Actually, wb_check_old_data_flush
> handles the period writeback and decides the scope of dirty pages which
> have to be written back because they were too old.
> 
> Signed-off-by: Xie Yongmei <yongmeixie@hotmail.com>
> ---
>  fs/fs-writeback.c          |  11 ++--
>  include/linux/memcontrol.h |  16 ++++++
>  mm/backing-dev.c           |   4 +-
>  mm/memcontrol.c            | 114 +++++++++++++++++++++++++++++++++++++
>  4 files changed, 140 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index 591fe9cf1659..f59e4709ec39 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -1980,6 +1980,7 @@ static long wb_writeback(struct bdi_writeback *wb,
>  	struct inode *inode;
>  	long progress;
>  	struct blk_plug plug;
> +	unsigned int dirty_expire = wb_dirty_expire_interval(wb);
>  
>  	blk_start_plug(&plug);
>  	spin_lock(&wb->list_lock);
> @@ -2015,7 +2016,7 @@ static long wb_writeback(struct bdi_writeback *wb,
>  		 */
>  		if (work->for_kupdate) {
>  			dirtied_before = jiffies -
> -				msecs_to_jiffies(dirty_expire_interval * 10);
> +				msecs_to_jiffies(dirty_expire * 10);
>  		} else if (work->for_background)
>  			dirtied_before = jiffies;
>  
> @@ -2101,15 +2102,16 @@ static long wb_check_old_data_flush(struct bdi_writeback *wb)
>  {
>  	unsigned long expired;
>  	long nr_pages;
> +	unsigned int writeback_interval = wb_dirty_writeback_interval(wb);
>  
>  	/*
>  	 * When set to zero, disable periodic writeback
>  	 */
> -	if (!dirty_writeback_interval)
> +	if (!writeback_interval)
>  		return 0;
>  
>  	expired = wb->last_old_flush +
> -			msecs_to_jiffies(dirty_writeback_interval * 10);
> +			msecs_to_jiffies(writeback_interval * 10);
>  	if (time_before(jiffies, expired))
>  		return 0;
>  
> @@ -2194,6 +2196,7 @@ void wb_workfn(struct work_struct *work)
>  	struct bdi_writeback *wb = container_of(to_delayed_work(work),
>  						struct bdi_writeback, dwork);
>  	long pages_written;
> +	unsigned int writeback_interval = wb_dirty_writeback_interval(wb);
>  
>  	set_worker_desc("flush-%s", bdi_dev_name(wb->bdi));
>  
> @@ -2222,7 +2225,7 @@ void wb_workfn(struct work_struct *work)
>  
>  	if (!list_empty(&wb->work_list))
>  		wb_wakeup(wb);
> -	else if (wb_has_dirty_io(wb) && dirty_writeback_interval)
> +	else if (wb_has_dirty_io(wb) && writeback_interval)
>  		wb_wakeup_delayed(wb);
>  }
>  
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 386fc9b70c95..c1dc88bb8f80 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -347,6 +347,8 @@ struct mem_cgroup {
>  #ifdef CONFIG_CGROUP_WRITEBACK_PARA
>  	int dirty_background_ratio;
>  	int dirty_ratio;
> +	int dirty_writeback_interval;
> +	int dirty_expire_interval;
>  #endif
>  
>  	struct mem_cgroup_per_node *nodeinfo[];
> @@ -1642,6 +1644,8 @@ static inline void mem_cgroup_flush_foreign(struct bdi_writeback *wb)
>  #ifdef CONFIG_CGROUP_WRITEBACK_PARA
>  unsigned int wb_dirty_background_ratio(struct bdi_writeback *wb);
>  unsigned int wb_dirty_ratio(struct bdi_writeback *wb);
> +unsigned int wb_dirty_writeback_interval(struct bdi_writeback *wb);
> +unsigned int wb_dirty_expire_interval(struct bdi_writeback *wb);
>  #else
>  static inline
>  unsigned int wb_dirty_background_ratio(struct bdi_writeback *wb)
> @@ -1654,6 +1658,18 @@ unsigned int wb_dirty_ratio(struct bdi_writeback *wb)
>  {
>  	return vm_dirty_ratio;
>  }
> +
> +static inline
> +unsigned int wb_dirty_writeback_interval(struct bdi_writeback *wb)
> +{
> +	return dirty_writeback_interval;
> +}
> +
> +static inline
> +unsigned int wb_dirty_expire_interval(struct bdi_writeback *wb)
> +{
> +	return dirty_expire_interval;
> +}
>  #endif
>  
>  struct sock;
> diff --git a/mm/backing-dev.c b/mm/backing-dev.c
> index 7176af65b103..685558362ad8 100644
> --- a/mm/backing-dev.c
> +++ b/mm/backing-dev.c
> @@ -15,6 +15,7 @@
>  #include <linux/writeback.h>
>  #include <linux/device.h>
>  #include <trace/events/writeback.h>
> +#include <linux/memcontrol.h>
>  
>  struct backing_dev_info noop_backing_dev_info;
>  EXPORT_SYMBOL_GPL(noop_backing_dev_info);
> @@ -264,8 +265,9 @@ subsys_initcall(default_bdi_init);
>  void wb_wakeup_delayed(struct bdi_writeback *wb)
>  {
>  	unsigned long timeout;
> +	unsigned int dirty_interval = wb_dirty_writeback_interval(wb);
>  
> -	timeout = msecs_to_jiffies(dirty_writeback_interval * 10);
> +	timeout = msecs_to_jiffies(dirty_interval * 10);
>  	spin_lock_bh(&wb->work_lock);
>  	if (test_bit(WB_registered, &wb->state))
>  		queue_delayed_work(bdi_wq, &wb->dwork, timeout);
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index b1c1b150637a..c392aec22e2e 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -4851,17 +4851,49 @@ unsigned int wb_dirty_ratio(struct bdi_writeback *wb)
>  	return memcg->dirty_ratio;
>  }
>  
> +unsigned int wb_dirty_writeback_interval(struct bdi_writeback *wb)
> +{
> +	struct mem_cgroup *memcg;
> +
> +	if (mem_cgroup_disabled() || !wb)
> +		return dirty_writeback_interval;
> +
> +	memcg = mem_cgroup_from_css(wb->memcg_css);
> +	if (memcg == root_mem_cgroup || memcg->dirty_writeback_interval < 0)
> +		return dirty_writeback_interval;
> +
> +	return memcg->dirty_writeback_interval;
> +}
> +
> +unsigned int wb_dirty_expire_interval(struct bdi_writeback *wb)
> +{
> +	struct mem_cgroup *memcg;
> +
> +	if (mem_cgroup_disabled() || !wb)
> +		return dirty_expire_interval;
> +
> +	memcg = mem_cgroup_from_css(wb->memcg_css);
> +	if (memcg == root_mem_cgroup || memcg->dirty_expire_interval < 0)
> +		return dirty_expire_interval;
> +
> +	return memcg->dirty_expire_interval;
> +}
> +
>  static void wb_memcg_inherit_from_parent(struct mem_cgroup *parent,
>  					 struct mem_cgroup *memcg)
>  {
>  	memcg->dirty_background_ratio = parent->dirty_background_ratio;
>  	memcg->dirty_ratio = parent->dirty_ratio;
> +	memcg->dirty_writeback_interval = parent->dirty_writeback_interval;
> +	memcg->dirty_expire_interval = parent->dirty_expire_interval;
>  }
>  
>  static void wb_memcg_init(struct mem_cgroup *memcg)
>  {
>  	memcg->dirty_background_ratio = -1;
>  	memcg->dirty_ratio = -1;
> +	memcg->dirty_writeback_interval = -1;
> +	memcg->dirty_expire_interval = -1;
>  }
>  
>  static int mem_cgroup_dirty_background_ratio_show(struct seq_file *m, void *v)
> @@ -4918,6 +4950,64 @@ mem_cgroup_dirty_ratio_write(struct kernfs_open_file *of,
>  	memcg->dirty_ratio = dirty_ratio;
>  	return nbytes;
>  }
> +
> +static int mem_cgroup_dirty_writeback_interval_show(struct seq_file *m, void *v)
> +{
> +	struct mem_cgroup *memcg = mem_cgroup_from_css(seq_css(m));
> +
> +	seq_printf(m, "%d\n", memcg->dirty_writeback_interval);
> +	return 0;
> +}
> +
> +static ssize_t
> +mem_cgroup_dirty_writeback_interval_write(struct kernfs_open_file *of,
> +					  char *buf, size_t nbytes,
> +					  loff_t off)
> +{
> +	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
> +	int ret, writeback_interval;
> +
> +	buf = strstrip(buf);
> +	ret = kstrtoint(buf, 0, &writeback_interval);
> +	if (ret)
> +		return ret;
> +
> +	if (writeback_interval < -1)
> +		return -EINVAL;
> +
> +	if (memcg->dirty_writeback_interval != writeback_interval) {
> +		memcg->dirty_writeback_interval = writeback_interval;
> +		wakeup_flusher_threads(WB_REASON_PERIODIC);
> +	}
> +	return nbytes;
> +}
> +
> +static int mem_cgroup_dirty_expire_interval_show(struct seq_file *m, void *v)
> +{
> +	struct mem_cgroup *memcg = mem_cgroup_from_css(seq_css(m));
> +
> +	seq_printf(m, "%d\n", memcg->dirty_expire_interval);
> +	return 0;
> +}
> +
> +static ssize_t
> +mem_cgroup_dirty_expire_interval_write(struct kernfs_open_file *of,
> +				       char *buf, size_t nbytes, loff_t off)
> +{
> +	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
> +	int ret, expire_interval;
> +
> +	buf = strstrip(buf);
> +	ret = kstrtoint(buf, 0, &expire_interval);
> +	if (ret)
> +		return ret;
> +
> +	if (expire_interval < -1)
> +		return -EINVAL;
> +
> +	memcg->dirty_expire_interval = expire_interval;
> +	return nbytes;
> +}
>  #else
>  static void wb_memcg_inherit_from_parent(struct mem_cgroup *parent,
>  					 struct mem_cgroup *memcg)
> @@ -5067,6 +5157,18 @@ static struct cftype mem_cgroup_legacy_files[] = {
>  		.seq_show = mem_cgroup_dirty_ratio_show,
>  		.write = mem_cgroup_dirty_ratio_write,
>  	},
> +	{
> +		.name = "dirty_writeback_interval_centisecs",
> +		.flags = CFTYPE_NOT_ON_ROOT,
> +		.seq_show = mem_cgroup_dirty_writeback_interval_show,
> +		.write = mem_cgroup_dirty_writeback_interval_write,
> +	},
> +	{
> +		.name = "dirty_expire_interval_centisecs",
> +		.flags = CFTYPE_NOT_ON_ROOT,
> +		.seq_show = mem_cgroup_dirty_expire_interval_show,
> +		.write = mem_cgroup_dirty_expire_interval_write,
> +	},
>  #endif
>  	{ },	/* terminate */
>  };
> @@ -6549,6 +6651,18 @@ static struct cftype memory_files[] = {
>  		.seq_show = mem_cgroup_dirty_ratio_show,
>  		.write = mem_cgroup_dirty_ratio_write,
>  	},
> +	{
> +		.name = "dirty_writeback_interval_centisecs",
> +		.flags = CFTYPE_NOT_ON_ROOT,
> +		.seq_show = mem_cgroup_dirty_writeback_interval_show,
> +		.write = mem_cgroup_dirty_writeback_interval_write,
> +	},
> +	{
> +		.name = "dirty_expire_interval_centisecs",
> +		.flags = CFTYPE_NOT_ON_ROOT,
> +		.seq_show = mem_cgroup_dirty_expire_interval_show,
> +		.write = mem_cgroup_dirty_expire_interval_write,
> +	},
>  #endif
>  	{ }	/* terminate */
>  };
> -- 
> 2.27.0

-- 
Michal Hocko
SUSE Labs
