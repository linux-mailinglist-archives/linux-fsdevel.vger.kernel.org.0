Return-Path: <linux-fsdevel+bounces-14898-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF260881236
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Mar 2024 14:19:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FDA8281700
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Mar 2024 13:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CFD140BEB;
	Wed, 20 Mar 2024 13:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TTnltEyv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397B040BE2
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 Mar 2024 13:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710940759; cv=none; b=A3q9pbMeaLQlQ2qrIFXrXi22LEYZQrsh8F0b1XnUXgx62vGSYSWpV8Ay2b4GH57b1Zva6p39tFujqT9wTvnaWSRgWwtewixq3e2lgaq+5ARpI+8FT4JW1t9mR9xzUIIWOE5yA4pCv2RVRz+F+zSsTKear3EyMKHSaaZS+L2v1aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710940759; c=relaxed/simple;
	bh=smAQyH3fzoArbGL/EJf370uyvQE26iHCwiLZs0Htze8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JLjGlGdVQsCwMETX3WPK5xJfEDKTbj18iYK8rPKWIgvnkLilpdUQTNJLm0B0PeAWMJ9fDSNGfj4Jgez8ZGJapzARVhLcV+u3NCOiTi2W1zGt/ANXrDtvduWqI/4DypGtWqOvkuI+Nks53ODofCohcJVTbhJbduQh+qtIWMRFF/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TTnltEyv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710940757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NpmVP7TeXED0UIOg2IhouFjCmnaB0b7XL3z6nYN+g5c=;
	b=TTnltEyv72FySI8kRyDwvBaoehOPI236Wbni9M6jQbFqL59iOdfRlmo0dlDz/AYUnpoGwl
	yMlePGniMnlY3nyK3z/UBknQC/2ZCxbD3r6mQvsepmgOKeimUDaQkoEzRZEA1CBjeUdmB1
	oYgNDHbrON8pNIbAOL95kqO76uPE/RM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-wbANGGN0OhS4SocgmX5KQQ-1; Wed, 20 Mar 2024 09:19:12 -0400
X-MC-Unique: wbANGGN0OhS4SocgmX5KQQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DF861800266;
	Wed, 20 Mar 2024 13:19:11 +0000 (UTC)
Received: from bfoster (unknown [10.22.16.57])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 5F7E22166B34;
	Wed, 20 Mar 2024 13:19:11 +0000 (UTC)
Date: Wed, 20 Mar 2024 09:21:05 -0400
From: Brian Foster <bfoster@redhat.com>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: akpm@linux-foundation.org, tj@kernel.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	willy@infradead.org, jack@suse.cz, dsterba@suse.com,
	mjguzik@gmail.com, dhowells@redhat.com, peterz@infradead.org
Subject: Re: [PATCH 1/6] writeback: collect stats of all wb of bdi in
 bdi_debug_stats_show
Message-ID: <Zfriwb03HCRWJ24q@bfoster>
References: <20240320110222.6564-1-shikemeng@huaweicloud.com>
 <20240320110222.6564-2-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240320110222.6564-2-shikemeng@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

On Wed, Mar 20, 2024 at 07:02:17PM +0800, Kemeng Shi wrote:
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
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---
>  mm/backing-dev.c | 93 ++++++++++++++++++++++++++++++++++++------------
>  1 file changed, 70 insertions(+), 23 deletions(-)
> 
> diff --git a/mm/backing-dev.c b/mm/backing-dev.c
> index 5f2be8c8df11..788702b6c5dd 100644
> --- a/mm/backing-dev.c
> +++ b/mm/backing-dev.c
...
> @@ -46,31 +59,65 @@ static void bdi_debug_init(void)
>  	bdi_debug_root = debugfs_create_dir("bdi", NULL);
>  }
>  
...
> +#ifdef CONFIG_CGROUP_WRITEBACK
> +static void bdi_collect_stats(struct backing_dev_info *bdi,
> +			      struct wb_stats *stats)
> +{
> +	struct bdi_writeback *wb;
> +
> +	/* protect wb from release */
> +	mutex_lock(&bdi->cgwb_release_mutex);
> +	list_for_each_entry(wb, &bdi->wb_list, bdi_node)
> +		collect_wb_stats(stats, wb);
> +	mutex_unlock(&bdi->cgwb_release_mutex);
> +}
> +#else
> +static void bdi_collect_stats(struct backing_dev_info *bdi,
> +			      struct wb_stats *stats)
> +{
> +	collect_wb_stats(stats, &bdi->wb);
> +}
> +#endif
> +

I'm not familiar enough with the cgwb code to say for sure (and I'd
probably wait for more high level feedback before worrying too much
about this), but do we need the ifdef here just to iterate ->wb_list?
From looking at the code, it appears bdi->wb ends up on the list while
the bdi is registered for both cases, so that distinction seems
unnecessary. WRT to wb release protection, I wonder if this could use a
combination of rcu_read_lock()/list_for_each_safe() and wb_tryget() on
each wb before collecting its stats..? See how bdi_split_work_to_wbs()
works, for example.

Also I see a patch conflict/compile error on patch 2 due to
__wb_calc_thresh() only taking one parameter in my tree. What's the
baseline commit for this series?

Brian

> +static int bdi_debug_stats_show(struct seq_file *m, void *v)
> +{
> +	struct backing_dev_info *bdi = m->private;
> +	unsigned long background_thresh;
> +	unsigned long dirty_thresh;
> +	struct wb_stats stats;
> +	unsigned long tot_bw;
> +
>  	global_dirty_limits(&background_thresh, &dirty_thresh);
> -	wb_thresh = wb_calc_thresh(wb, dirty_thresh);
> +
> +	memset(&stats, 0, sizeof(stats));
> +	stats.dirty_thresh = dirty_thresh;
> +	bdi_collect_stats(bdi, &stats);
> +
> +	tot_bw = atomic_long_read(&bdi->tot_write_bandwidth);
>  
>  	seq_printf(m,
>  		   "BdiWriteback:       %10lu kB\n"
> @@ -87,18 +134,18 @@ static int bdi_debug_stats_show(struct seq_file *m, void *v)
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
>  
>  	return 0;
> -- 
> 2.30.0
> 
> 


