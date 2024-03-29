Return-Path: <linux-fsdevel+bounces-15688-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE89891F43
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Mar 2024 16:02:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D10681C231A9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Mar 2024 15:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 932E513F452;
	Fri, 29 Mar 2024 13:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iljubrZo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3196013E6D0
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 Mar 2024 13:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711717746; cv=none; b=ZkaEbrJkgbwIlkXwjc6Io6zAkSiJosxU2kuWuAQuwf3M8W2MHk4H12yGkvKDk1zsKFR/JOfiDGVpwsgXt5tZh7ECJH5GRf/AqnwKtVlNes6nqxyWLksLB6gqX+AJyKOIfIzM6cbSH8cO38c2uKdQTxLZ+zyTeqVaxYWmK3L5vyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711717746; c=relaxed/simple;
	bh=dZk5QXdN4DkKk7QJCb+a41IsBWZKo7GvwcSjzMWU4lE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j4Ezt4/vJSXPDVQgtVC4Vuj9IVSiuBM4tMPJJT7ebt7DrXrN3/QkQJi3NqNl6pZ/lZRq+NeUNs7HAcACaFXlnJ4zGjJpsUAAnyL2N2t1Q0eFI5J9/EWGFVEZxC/VlVCLDlfILmOFdKoP41jIxTWUzJtPt4ou8VlxTsuj+2LWyxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iljubrZo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711717743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tgio9eMJR7jDHKrp7CRyahwHu55Vb1EcYMdidB/kUo0=;
	b=iljubrZoaL8CfbQmBgkdhB/dazMsuKv0hAQSD8gyCLZqa3vD/H8Tp8s1/7+eHdZZLrRs0C
	f+AXjszM97VFO8X4LFsIIpp2LtiYXsdQzDmanUAqBdrzUDnULRX22GcuAj31WDP3aAIZQ9
	kiVgJBk4OzNhiegMGpcjnTZXjcvn7SY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-497-NqiRGtUEMcaeU5rDTJT4HA-1; Fri, 29 Mar 2024 09:08:58 -0400
X-MC-Unique: NqiRGtUEMcaeU5rDTJT4HA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DD56289C943;
	Fri, 29 Mar 2024 13:08:57 +0000 (UTC)
Received: from bfoster (unknown [10.22.16.57])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 62CE1492BD0;
	Fri, 29 Mar 2024 13:08:57 +0000 (UTC)
Date: Fri, 29 Mar 2024 09:10:55 -0400
From: Brian Foster <bfoster@redhat.com>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, jack@suse.cz,
	tj@kernel.org, dsterba@suse.com, mjguzik@gmail.com,
	dhowells@redhat.com, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 3/6] writeback: support retrieving per group debug
 writeback stats of bdi
Message-ID: <Zga937dR5UgtSVaz@bfoster>
References: <20240327155751.3536-1-shikemeng@huaweicloud.com>
 <20240327155751.3536-4-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327155751.3536-4-shikemeng@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

On Wed, Mar 27, 2024 at 11:57:48PM +0800, Kemeng Shi wrote:
> Add /sys/kernel/debug/bdi/xxx/wb_stats to show per group writeback stats
> of bdi.
> 

Hi Kemeng,

Just a few random thoughts/comments..

> Following domain hierarchy is tested:
>                 global domain (320G)
>                 /                 \
>         cgroup domain1(10G)     cgroup domain2(10G)
>                 |                 |
> bdi            wb1               wb2
> 
> /* per wb writeback info of bdi is collected */
> cat /sys/kernel/debug/bdi/252:16/wb_stats
> WbCgIno:                    1
> WbWriteback:                0 kB
> WbReclaimable:              0 kB
> WbDirtyThresh:              0 kB
> WbDirtied:                  0 kB
> WbWritten:                  0 kB
> WbWriteBandwidth:      102400 kBps
> b_dirty:                    0
> b_io:                       0
> b_more_io:                  0
> b_dirty_time:               0
> state:                      1

Maybe some whitespace or something between entries would improve
readability?

> WbCgIno:                 4094
> WbWriteback:            54432 kB
> WbReclaimable:         766080 kB
> WbDirtyThresh:        3094760 kB
> WbDirtied:            1656480 kB
> WbWritten:             837088 kB
> WbWriteBandwidth:      132772 kBps
> b_dirty:                    1
> b_io:                       1
> b_more_io:                  0
> b_dirty_time:               0
> state:                      7
> WbCgIno:                 4135
> WbWriteback:            15232 kB
> WbReclaimable:         786688 kB
> WbDirtyThresh:        2909984 kB
> WbDirtied:            1482656 kB
> WbWritten:             681408 kB
> WbWriteBandwidth:      124848 kBps
> b_dirty:                    0
> b_io:                       1
> b_more_io:                  0
> b_dirty_time:               0
> state:                      7
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---
>  include/linux/writeback.h |  1 +
>  mm/backing-dev.c          | 88 +++++++++++++++++++++++++++++++++++++++
>  mm/page-writeback.c       | 19 +++++++++
>  3 files changed, 108 insertions(+)
> 
...
> diff --git a/mm/backing-dev.c b/mm/backing-dev.c
> index 8daf950e6855..e3953db7d88d 100644
> --- a/mm/backing-dev.c
> +++ b/mm/backing-dev.c
> @@ -103,6 +103,91 @@ static void collect_wb_stats(struct wb_stats *stats,
>  }
>  
>  #ifdef CONFIG_CGROUP_WRITEBACK
...
> +static int cgwb_debug_stats_show(struct seq_file *m, void *v)
> +{
> +	struct backing_dev_info *bdi;
> +	unsigned long background_thresh;
> +	unsigned long dirty_thresh;
> +	struct bdi_writeback *wb;
> +	struct wb_stats stats;
> +
> +	rcu_read_lock();
> +	bdi = lookup_bdi(m);
> +	if (!bdi) {
> +		rcu_read_unlock();
> +		return -EEXIST;
> +	}
> +
> +	global_dirty_limits(&background_thresh, &dirty_thresh);
> +
> +	list_for_each_entry_rcu(wb, &bdi->wb_list, bdi_node) {
> +		memset(&stats, 0, sizeof(stats));
> +		stats.dirty_thresh = dirty_thresh;

If you did something like the following here, wouldn't that also zero
the rest of the structure?

		struct wb_stats stats = { .dirty_thresh = dirty_thresh };

> +		collect_wb_stats(&stats, wb);
> +

Also, similar question as before on whether you'd want to check
WB_registered or something here..

> +		if (mem_cgroup_wb_domain(wb) == NULL) {
> +			wb_stats_show(m, wb, &stats);
> +			continue;
> +		}

Can you explain what this logic is about? Is the cgwb_calc_thresh()
thing not needed in this case? A comment might help for those less
familiar with the implementation details.

BTW, I'm also wondering if something like the following is correct
and/or roughly equivalent:
	
	list_for_each_*(wb, ...) {
		struct wb_stats stats = ...;

		if (!wb_tryget(wb))
			continue;

		collect_wb_stats(&stats, wb);

		/*
		 * Extra wb_thresh magic. Drop rcu lock because ... . We
		 * can do so here because we have a ref.
		 */
		if (mem_cgroup_wb_domain(wb)) {
			rcu_read_unlock();
			stats.wb_thresh = min(stats.wb_thresh, cgwb_calc_thresh(wb));
			rcu_read_lock();
		}

		wb_stats_show(m, wb, &stats)
		wb_put(wb);
	}

> +
> +		/*
> +		 * cgwb_release will destroy wb->memcg_completions which
> +		 * will be ued in cgwb_calc_thresh. Use wb_tryget to prevent
> +		 * memcg_completions destruction from cgwb_release.
> +		 */
> +		if (!wb_tryget(wb))
> +			continue;
> +
> +		rcu_read_unlock();
> +		/* cgwb_calc_thresh may sleep in cgroup_rstat_flush */
> +		stats.wb_thresh = min(stats.wb_thresh, cgwb_calc_thresh(wb));
> +		wb_stats_show(m, wb, &stats);
> +		rcu_read_lock();
> +		wb_put(wb);
> +	}
> +	rcu_read_unlock();
> +
> +	return 0;
> +}
> +DEFINE_SHOW_ATTRIBUTE(cgwb_debug_stats);
> +
> +static void cgwb_debug_register(struct backing_dev_info *bdi)
> +{
> +	debugfs_create_file("wb_stats", 0444, bdi->debug_dir, bdi,
> +			    &cgwb_debug_stats_fops);
> +}
> +
>  static void bdi_collect_stats(struct backing_dev_info *bdi,
>  			      struct wb_stats *stats)
>  {
> @@ -117,6 +202,8 @@ static void bdi_collect_stats(struct backing_dev_info *bdi,
>  {
>  	collect_wb_stats(stats, &bdi->wb);
>  }
> +
> +static inline void cgwb_debug_register(struct backing_dev_info *bdi) { }

Could we just create the wb_stats file regardless of whether cgwb is
enabled? Obviously theres only one wb in the !CGWB case and it's
somewhat duplicative with the bdi stats file, but that seems harmless if
the same code can be reused..? Maybe there's also a small argument for
dropping the state info from the bdi stats file and moving it to
wb_stats.

Brian

>  #endif
>  
>  static int bdi_debug_stats_show(struct seq_file *m, void *v)
> @@ -182,6 +269,7 @@ static void bdi_debug_register(struct backing_dev_info *bdi, const char *name)
>  
>  	debugfs_create_file("stats", 0444, bdi->debug_dir, bdi,
>  			    &bdi_debug_stats_fops);
> +	cgwb_debug_register(bdi);
>  }
>  
>  static void bdi_debug_unregister(struct backing_dev_info *bdi)
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index 0e20467367fe..3724c7525316 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -893,6 +893,25 @@ unsigned long wb_calc_thresh(struct bdi_writeback *wb, unsigned long thresh)
>  	return __wb_calc_thresh(&gdtc, thresh);
>  }
>  
> +unsigned long cgwb_calc_thresh(struct bdi_writeback *wb)
> +{
> +	struct dirty_throttle_control gdtc = { GDTC_INIT_NO_WB };
> +	struct dirty_throttle_control mdtc = { MDTC_INIT(wb, &gdtc) };
> +	unsigned long filepages, headroom, writeback;
> +
> +	gdtc.avail = global_dirtyable_memory();
> +	gdtc.dirty = global_node_page_state(NR_FILE_DIRTY) +
> +		     global_node_page_state(NR_WRITEBACK);
> +
> +	mem_cgroup_wb_stats(wb, &filepages, &headroom,
> +			    &mdtc.dirty, &writeback);
> +	mdtc.dirty += writeback;
> +	mdtc_calc_avail(&mdtc, filepages, headroom);
> +	domain_dirty_limits(&mdtc);
> +
> +	return __wb_calc_thresh(&mdtc, mdtc.thresh);
> +}
> +
>  /*
>   *                           setpoint - dirty 3
>   *        f(dirty) := 1.0 + (----------------)
> -- 
> 2.30.0
> 


