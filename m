Return-Path: <linux-fsdevel+bounces-15687-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB11A891F37
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Mar 2024 16:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 506BB1F2F1C5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Mar 2024 15:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68536130E35;
	Fri, 29 Mar 2024 13:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GM40fPTe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B0021100
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 Mar 2024 13:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711717341; cv=none; b=M58+SOsfUz1Td8b2qunAJxLtc//PEKe2imOn4w0fq1ftuBBGQbKfeZrn/qoleN5dZsrZQGiv3WfANOLEzbp9St3sfRESLLBapGWGDmAC7xgArOFoShLJQOlky7iuqr1sLMTx0ijTZG+jWnFGRQypxOXLUB5gbbyHVpxIlIO+5E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711717341; c=relaxed/simple;
	bh=c+1ZeFaaDmnKz5Vjo8G1Iz7uVJGxgmB2tDVp7hqd8mw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XQHLU6CvMRqFhZjcqTDhXCld3YbWnyvMZ7uBKjwFmro1tCfVAi5/1g8K0B7Gx5A9iaD/DSLLxoqN8CLFALqQLt2r3gY2EAMxKkqRFaUvUT2Ze5ocusqa9OLRcYgrio37qmwPOGZDUvu/pVFIVT7BV8uFQzRgbXNVznOwRoTmLKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GM40fPTe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711717337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yN1Le78gH2spFQsvHwZ2DbTI7S30kof/5Z3400NZP38=;
	b=GM40fPTe6F+/84zYyIhnVT13tfqK8tQZ4zGO0z/PQ3yEMGz0bG4z4pHZ4YgplEhh964O1t
	KyHtD3A0KcgTK/pietm7baLhxF8UHoSzJjaD4sldZIZJtIyEl9b/fJ6RLfbemzvS6FOqR0
	HOqTkTIErWtl4XgIRb7g7nwrgmScQ1o=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-226-Kgz-TJJCPN2MsAeuWC5f0w-1; Fri,
 29 Mar 2024 09:02:12 -0400
X-MC-Unique: Kgz-TJJCPN2MsAeuWC5f0w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4504C3C02788;
	Fri, 29 Mar 2024 13:02:12 +0000 (UTC)
Received: from bfoster (unknown [10.22.16.57])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 9E09040C6CB4;
	Fri, 29 Mar 2024 13:02:11 +0000 (UTC)
Date: Fri, 29 Mar 2024 09:04:09 -0400
From: Brian Foster <bfoster@redhat.com>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, jack@suse.cz,
	tj@kernel.org, dsterba@suse.com, mjguzik@gmail.com,
	dhowells@redhat.com, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 2/6] writeback: collect stats of all wb of bdi in
 bdi_debug_stats_show
Message-ID: <Zga8Sf1DIxMevdcw@bfoster>
References: <20240327155751.3536-1-shikemeng@huaweicloud.com>
 <20240327155751.3536-3-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327155751.3536-3-shikemeng@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

On Wed, Mar 27, 2024 at 11:57:47PM +0800, Kemeng Shi wrote:
> /sys/kernel/debug/bdi/xxx/stats is supposed to show writeback information
> of whole bdi, but only writeback information of bdi in root cgroup is
> collected. So writeback information in non-root cgroup are missing now.
> To be more specific, considering following case:
> 
> /* create writeback cgroup */
> cd /sys/fs/cgroup
> echo "+memory +io" > cgroup.subtree_control
> mkdir group1
> cd group1
> echo $$ > cgroup.procs
> /* do writeback in cgroup */
> fio -name test -filename=/dev/vdb ...
> /* get writeback info of bdi */
> cat /sys/kernel/debug/bdi/xxx/stats
> The cat result unexpectedly implies that there is no writeback on target
> bdi.
> 
> Fix this by collecting stats of all wb in bdi instead of only wb in
> root cgroup.
> 
> Following domain hierarchy is tested:
>                 global domain (320G)
>                 /                 \
>         cgroup domain1(10G)     cgroup domain2(10G)
>                 |                 |
> bdi            wb1               wb2
> 
> /* all writeback info of bdi is successfully collected */
> cat stats
> BdiWriteback:             2912 kB
> BdiReclaimable:        1598464 kB
> BdiDirtyThresh:      167479028 kB
> DirtyThresh:         195038532 kB
> BackgroundThresh:     32466728 kB
> BdiDirtied:           19141696 kB
> BdiWritten:           17543456 kB
> BdiWriteBandwidth:     1136172 kBps
> b_dirty:                     2
> b_io:                        0
> b_more_io:                   1
> b_dirty_time:                0
> bdi_list:                    1
> state:                       1
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---
>  mm/backing-dev.c | 100 +++++++++++++++++++++++++++++++++--------------
>  1 file changed, 71 insertions(+), 29 deletions(-)
> 
> diff --git a/mm/backing-dev.c b/mm/backing-dev.c
> index 70f02959f3bd..8daf950e6855 100644
> --- a/mm/backing-dev.c
> +++ b/mm/backing-dev.c
...
> @@ -65,16 +78,54 @@ static struct backing_dev_info *lookup_bdi(struct seq_file *m)
>  	return NULL;
>  }
>  
> +static void collect_wb_stats(struct wb_stats *stats,
> +			     struct bdi_writeback *wb)
> +{
> +	struct inode *inode;
> +
> +	spin_lock(&wb->list_lock);
> +	list_for_each_entry(inode, &wb->b_dirty, i_io_list)
> +		stats->nr_dirty++;
> +	list_for_each_entry(inode, &wb->b_io, i_io_list)
> +		stats->nr_io++;
> +	list_for_each_entry(inode, &wb->b_more_io, i_io_list)
> +		stats->nr_more_io++;
> +	list_for_each_entry(inode, &wb->b_dirty_time, i_io_list)
> +		if (inode->i_state & I_DIRTY_TIME)
> +			stats->nr_dirty_time++;
> +	spin_unlock(&wb->list_lock);
> +
> +	stats->nr_writeback += wb_stat(wb, WB_WRITEBACK);
> +	stats->nr_reclaimable += wb_stat(wb, WB_RECLAIMABLE);
> +	stats->nr_dirtied += wb_stat(wb, WB_DIRTIED);
> +	stats->nr_written += wb_stat(wb, WB_WRITTEN);
> +	stats->wb_thresh += wb_calc_thresh(wb, stats->dirty_thresh);

Kinda nitty question, but is this a sum of per-wb writeback thresholds?
If so, do you consider that useful information vs. the per-wb threshold
data presumably exposed in the next patch?

I'm not really that worried about what debug data we expose, it just
seems a little odd. How would you document this value in a sentence or
two, for example?

> +}
> +
> +#ifdef CONFIG_CGROUP_WRITEBACK
> +static void bdi_collect_stats(struct backing_dev_info *bdi,
> +			      struct wb_stats *stats)
> +{
> +	struct bdi_writeback *wb;
> +
> +	list_for_each_entry_rcu(wb, &bdi->wb_list, bdi_node)
> +		collect_wb_stats(stats, wb);

Depending on discussion on the previous patch and whether the higher
level rcu protection in bdi_debug_stats_show() is really necessary, it
might make more sense to move it here.

I'm also wondering if you'd want to check the state of the individual wb
(i.e. WB_registered?) before reading it..?

> +}
> +#else
> +static void bdi_collect_stats(struct backing_dev_info *bdi,
> +			      struct wb_stats *stats)
> +{
> +	collect_wb_stats(stats, &bdi->wb);
> +}
> +#endif
...
> @@ -115,18 +157,18 @@ static int bdi_debug_stats_show(struct seq_file *m, void *v)
>  		   "b_dirty_time:       %10lu\n"
>  		   "bdi_list:           %10u\n"
>  		   "state:              %10lx\n",
> -		   (unsigned long) K(wb_stat(wb, WB_WRITEBACK)),
> -		   (unsigned long) K(wb_stat(wb, WB_RECLAIMABLE)),
> -		   K(wb_thresh),
> +		   K(stats.nr_writeback),
> +		   K(stats.nr_reclaimable),
> +		   K(stats.wb_thresh),
>  		   K(dirty_thresh),
>  		   K(background_thresh),
> -		   (unsigned long) K(wb_stat(wb, WB_DIRTIED)),
> -		   (unsigned long) K(wb_stat(wb, WB_WRITTEN)),
> -		   (unsigned long) K(wb->write_bandwidth),
> -		   nr_dirty,
> -		   nr_io,
> -		   nr_more_io,
> -		   nr_dirty_time,
> +		   K(stats.nr_dirtied),
> +		   K(stats.nr_written),
> +		   K(tot_bw),
> +		   stats.nr_dirty,
> +		   stats.nr_io,
> +		   stats.nr_more_io,
> +		   stats.nr_dirty_time,
>  		   !list_empty(&bdi->bdi_list), bdi->wb.state);

Is it worth showing a list count here rather than list_empty() state?

Brian

>  
>  	rcu_read_unlock();
> -- 
> 2.30.0
> 


