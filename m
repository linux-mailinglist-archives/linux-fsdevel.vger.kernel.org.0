Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A695C51159F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Apr 2022 13:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbiD0K6g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Apr 2022 06:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbiD0K62 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Apr 2022 06:58:28 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2422FDAA07;
        Wed, 27 Apr 2022 03:35:20 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id BC24E210E0;
        Wed, 27 Apr 2022 10:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651055718; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TeOjkg87kY6ADeHSvGOsvBjldGmv4vB3sJSA1FSwKZ4=;
        b=fMF9hBCVPYbzYhmYJMHZtTalbsBTqsC/hUsQpYn1tLwVp6LJk15NsayrerzPjHtxusde2V
        vvwPcnFUKuwjQmV0Sr5wUm4FkKXPa4bAb156pQfurdNMFK4SduS1qzJzSuGDD8FHM3oaO1
        FXl7NRgKd+fhqWkQkUIHabxZc9EoF3I=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 856252C145;
        Wed, 27 Apr 2022 10:35:18 +0000 (UTC)
Date:   Wed, 27 Apr 2022 12:35:18 +0200
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
Subject: Re: [PATCH 2/3] writeback: per memcg dirty flush
Message-ID: <YmkcW8b+fNWgWFGA@dhcp22.suse.cz>
References: <20220427093241.108281-1-yongmeixie@hotmail.com>
 <TYYP286MB1115132A9443D0B6D21DAD89C5FA9@TYYP286MB1115.JPNP286.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYYP286MB1115132A9443D0B6D21DAD89C5FA9@TYYP286MB1115.JPNP286.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[CC memcg maintainers and Tejun who has been quite active in the area
as well. Also linux-api ML added - please add this list whenever you are
suggesting user visible API]

On Wed 27-04-22 05:32:40, Xie Yongmei wrote:
> Currently, dirty writeback is under global control. We can tune it by
> parameters in /proc/sys/vm/
>   - dirty_expire_centisecs: expire interval in centiseconds
>   - dirty_writeback_centisecs: periodcal writeback interval in centiseconds
>   - dirty_background_bytes/dirty_background_ratio: async writeback
>     threshold
>   - dirty_bytes/dirty_ratio: sync writeback threshold
> 
> Sometimes, we'd like to specify special wrtiteback policy for user
> application, especially for offline application in co-location scenerio.
> 
> This patch provides dirty flush policy per memcg, user can specify them
> in memcg interface.
> 
> Actually, writeback code maintains two dimensions of dirty pages control in
> balance_dirty_pages.
>    - gdtc for global control
>    - mdtc for cgroup control
> 
> When dirty pages is under both of control, it leaves the check quickly.
> Otherwise, it computes the wb threshold (along with bg_threshold) taking
> the writeout bandwidth into consideration. And computes position ratio
> against wb_thresh for both global control and cgroup control as well.
> After that, it takes the smaller one (IOW the strict one) as the factor
> to generate task ratelimit based on wb's dirty_ratelimit.
> 
> So far, the writeback code can control the dirty limit for both global
> view and cgroup view. That means the framework works well for controlling
> cgroup's dirty limit.
> 
> This patch only provides an extra interface for memcg to tune writeback
> behavior.
> 
> Signed-off-by: Xie Yongmei <yongmeixie@hotmail.com>
> ---
>  include/linux/memcontrol.h |  22 ++++++
>  init/Kconfig               |   7 ++
>  mm/memcontrol.c            | 136 +++++++++++++++++++++++++++++++++++++
>  mm/page-writeback.c        |  15 +++-
>  4 files changed, 178 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index a68dce3873fc..386fc9b70c95 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -344,6 +344,11 @@ struct mem_cgroup {
>  	struct deferred_split deferred_split_queue;
>  #endif
>  
> +#ifdef CONFIG_CGROUP_WRITEBACK_PARA
> +	int dirty_background_ratio;
> +	int dirty_ratio;
> +#endif
> +
>  	struct mem_cgroup_per_node *nodeinfo[];
>  };
>  
> @@ -1634,6 +1639,23 @@ static inline void mem_cgroup_flush_foreign(struct bdi_writeback *wb)
>  
>  #endif	/* CONFIG_CGROUP_WRITEBACK */
>  
> +#ifdef CONFIG_CGROUP_WRITEBACK_PARA
> +unsigned int wb_dirty_background_ratio(struct bdi_writeback *wb);
> +unsigned int wb_dirty_ratio(struct bdi_writeback *wb);
> +#else
> +static inline
> +unsigned int wb_dirty_background_ratio(struct bdi_writeback *wb)
> +{
> +	return dirty_background_ratio;
> +}
> +
> +static inline
> +unsigned int wb_dirty_ratio(struct bdi_writeback *wb)
> +{
> +	return vm_dirty_ratio;
> +}
> +#endif
> +
>  struct sock;
>  bool mem_cgroup_charge_skmem(struct mem_cgroup *memcg, unsigned int nr_pages,
>  			     gfp_t gfp_mask);
> diff --git a/init/Kconfig b/init/Kconfig
> index ddcbefe535e9..0b8152000d6e 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -989,6 +989,13 @@ config CGROUP_WRITEBACK
>  	depends on MEMCG && BLK_CGROUP
>  	default y
>  
> +config CGROUP_WRITEBACK_PARA
> +	bool "Enable setup dirty flush parameters per memcg"
> +	depends on CGROUP_WRITEBACK
> +	default y
> +	help
> +	  This feature helps cgroup could specify its own diry wriback policy.
> +
>  menuconfig CGROUP_SCHED
>  	bool "CPU controller"
>  	default n
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index e8922bacfe2a..b1c1b150637a 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -4822,6 +4822,112 @@ static int mem_cgroup_slab_show(struct seq_file *m, void *p)
>  }
>  #endif
>  
> +#ifdef CONFIG_CGROUP_WRITEBACK_PARA
> +unsigned int wb_dirty_background_ratio(struct bdi_writeback *wb)
> +{
> +	struct mem_cgroup *memcg;
> +
> +	if (mem_cgroup_disabled() || !wb)
> +		return dirty_background_ratio;
> +
> +	memcg = mem_cgroup_from_css(wb->memcg_css);
> +	if (memcg == root_mem_cgroup || memcg->dirty_background_ratio < 0)
> +		return dirty_background_ratio;
> +
> +	return memcg->dirty_background_ratio;
> +}
> +
> +unsigned int wb_dirty_ratio(struct bdi_writeback *wb)
> +{
> +	struct mem_cgroup *memcg;
> +
> +	if (mem_cgroup_disabled() || !wb)
> +		return vm_dirty_ratio;
> +
> +	memcg = mem_cgroup_from_css(wb->memcg_css);
> +	if (memcg == root_mem_cgroup || memcg->dirty_ratio < 0)
> +		return vm_dirty_ratio;
> +
> +	return memcg->dirty_ratio;
> +}
> +
> +static void wb_memcg_inherit_from_parent(struct mem_cgroup *parent,
> +					 struct mem_cgroup *memcg)
> +{
> +	memcg->dirty_background_ratio = parent->dirty_background_ratio;
> +	memcg->dirty_ratio = parent->dirty_ratio;
> +}
> +
> +static void wb_memcg_init(struct mem_cgroup *memcg)
> +{
> +	memcg->dirty_background_ratio = -1;
> +	memcg->dirty_ratio = -1;
> +}
> +
> +static int mem_cgroup_dirty_background_ratio_show(struct seq_file *m, void *v)
> +{
> +	struct mem_cgroup *memcg = mem_cgroup_from_css(seq_css(m));
> +
> +	seq_printf(m, "%d\n", memcg->dirty_background_ratio);
> +	return 0;
> +}
> +
> +static ssize_t
> +mem_cgroup_dirty_background_ratio_write(struct kernfs_open_file *of,
> +					char *buf, size_t nbytes,
> +					loff_t off)
> +{
> +	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
> +	int ret, background_ratio;
> +
> +	buf = strstrip(buf);
> +	ret = kstrtoint(buf, 0, &background_ratio);
> +	if (ret)
> +		return ret;
> +
> +	if (background_ratio < -1 || background_ratio > 100)
> +		return -EINVAL;
> +
> +	memcg->dirty_background_ratio = background_ratio;
> +	return nbytes;
> +}
> +
> +static int mem_cgroup_dirty_ratio_show(struct seq_file *m, void *v)
> +{
> +	struct mem_cgroup *memcg = mem_cgroup_from_css(seq_css(m));
> +
> +	seq_printf(m, "%d\n", memcg->dirty_ratio);
> +	return 0;
> +}
> +
> +static ssize_t
> +mem_cgroup_dirty_ratio_write(struct kernfs_open_file *of,
> +			     char *buf, size_t nbytes, loff_t off)
> +{
> +	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
> +	int ret, dirty_ratio;
> +
> +	buf = strstrip(buf);
> +	ret = kstrtoint(buf, 0, &dirty_ratio);
> +	if (ret)
> +		return ret;
> +
> +	if (dirty_ratio < -1 || dirty_ratio > 100)
> +		return -EINVAL;
> +
> +	memcg->dirty_ratio = dirty_ratio;
> +	return nbytes;
> +}
> +#else
> +static void wb_memcg_inherit_from_parent(struct mem_cgroup *parent,
> +					 struct mem_cgroup *memcg)
> +{
> +}
> +
> +static inline void wb_memcg_init(struct mem_cgroup *memcg)
> +{
> +}
> +#endif
>  static struct cftype mem_cgroup_legacy_files[] = {
>  	{
>  		.name = "usage_in_bytes",
> @@ -4948,6 +5054,20 @@ static struct cftype mem_cgroup_legacy_files[] = {
>  		.write = mem_cgroup_reset,
>  		.read_u64 = mem_cgroup_read_u64,
>  	},
> +#ifdef CONFIG_CGROUP_WRITEBACK_PARA
> +	{
> +		.name = "dirty_background_ratio",
> +		.flags = CFTYPE_NOT_ON_ROOT,
> +		.seq_show = mem_cgroup_dirty_background_ratio_show,
> +		.write = mem_cgroup_dirty_background_ratio_write,
> +	},
> +	{
> +		.name = "dirty_ratio",
> +		.flags = CFTYPE_NOT_ON_ROOT,
> +		.seq_show = mem_cgroup_dirty_ratio_show,
> +		.write = mem_cgroup_dirty_ratio_write,
> +	},
> +#endif
>  	{ },	/* terminate */
>  };
>  
> @@ -5151,11 +5271,13 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
>  		page_counter_init(&memcg->swap, &parent->swap);
>  		page_counter_init(&memcg->kmem, &parent->kmem);
>  		page_counter_init(&memcg->tcpmem, &parent->tcpmem);
> +		wb_memcg_inherit_from_parent(parent, memcg);
>  	} else {
>  		page_counter_init(&memcg->memory, NULL);
>  		page_counter_init(&memcg->swap, NULL);
>  		page_counter_init(&memcg->kmem, NULL);
>  		page_counter_init(&memcg->tcpmem, NULL);
> +		wb_memcg_init(memcg);
>  
>  		root_mem_cgroup = memcg;
>  		return &memcg->css;
> @@ -6414,6 +6536,20 @@ static struct cftype memory_files[] = {
>  		.seq_show = memory_oom_group_show,
>  		.write = memory_oom_group_write,
>  	},
> +#ifdef CONFIG_CGROUP_WRITEBACK_PARA
> +	{
> +		.name = "dirty_background_ratio",
> +		.flags = CFTYPE_NOT_ON_ROOT,
> +		.seq_show = mem_cgroup_dirty_background_ratio_show,
> +		.write = mem_cgroup_dirty_background_ratio_write,
> +	},
> +	{
> +		.name = "dirty_ratio",
> +		.flags = CFTYPE_NOT_ON_ROOT,
> +		.seq_show = mem_cgroup_dirty_ratio_show,
> +		.write = mem_cgroup_dirty_ratio_write,
> +	},
> +#endif
>  	{ }	/* terminate */
>  };
>  
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index 7e2da284e427..cec2ef032927 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -395,12 +395,23 @@ static void domain_dirty_limits(struct dirty_throttle_control *dtc)
>  		 * per-PAGE_SIZE, they can be obtained by dividing bytes by
>  		 * number of pages.
>  		 */
> +#ifdef CONFIG_CGROUP_WRITEBACK_PARA
> +		ratio = (wb_dirty_ratio(dtc->wb) * PAGE_SIZE) / 100;
> +		bg_ratio = (wb_dirty_background_ratio(dtc->wb) * PAGE_SIZE) / 100;
> +		if (!ratio && bytes)
> +			ratio = min(DIV_ROUND_UP(bytes, global_avail),
> +				    PAGE_SIZE);
> +		if (!bg_ratio && bg_bytes)
> +			bg_ratio = min(DIV_ROUND_UP(bg_bytes, global_avail),
> +				       PAGE_SIZE);
> +#else
>  		if (bytes)
>  			ratio = min(DIV_ROUND_UP(bytes, global_avail),
>  				    PAGE_SIZE);
>  		if (bg_bytes)
>  			bg_ratio = min(DIV_ROUND_UP(bg_bytes, global_avail),
>  				       PAGE_SIZE);
> +#endif
>  		bytes = bg_bytes = 0;
>  	}
>  
> @@ -418,8 +429,8 @@ static void domain_dirty_limits(struct dirty_throttle_control *dtc)
>  		bg_thresh = thresh / 2;
>  	tsk = current;
>  	if (rt_task(tsk)) {
> -		bg_thresh += bg_thresh / 4 + global_wb_domain.dirty_limit / 32;
> -		thresh += thresh / 4 + global_wb_domain.dirty_limit / 32;
> +		bg_thresh += bg_thresh / 4 + dtc_dom(dtc)->dirty_limit / 32;
> +		thresh += thresh / 4 + dtc_dom(dtc)->dirty_limit / 32;
>  	}
>  	dtc->thresh = thresh;
>  	dtc->bg_thresh = bg_thresh;
> -- 
> 2.27.0

-- 
Michal Hocko
SUSE Labs
