Return-Path: <linux-fsdevel+bounces-14964-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B8B88858D4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 13:08:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C64172836FD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 12:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37CBF76030;
	Thu, 21 Mar 2024 12:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CS1aaWaD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0554E58AC6
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Mar 2024 12:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711022904; cv=none; b=ALmwwvSwe2i7b3eG/rzRNYE8qeD2QuV4q8tOWB5cHa+inbBAfLev3OgmLo9ZqwlKsk33luO689TFM/AF/KFpG/oD/uUnsuqSIjim0L/JsNqSgpqQ78+7S1zZ2glvnxlmxbZ93tOl0PrOgZL2llw0gv1B3m6jgduOzJepNmua/uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711022904; c=relaxed/simple;
	bh=ICgmSwq62FV99FLN/Bgv1O4hgSkfe7+nnwVC1W6Ggt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZkFiutZs5VCSLeV+PmJ8qRaBAQ0uc0Ux7BeELY4t+Ns48FwdMPElFkzxJcISMw4/EqnXC3tKVooGVOrqSmfROb41dHROgOZmnGM8Ag47k18B6EGycl1KPwofC8wWZiCoNcoRSz+5pitcYwcIVQCRRT3npKKoiWAoNPs0XMXKP6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CS1aaWaD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711022902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZmCkXKKBMdn7q3ZGi77a1ZwDnFVVsMns2EKsafaBcTk=;
	b=CS1aaWaD6bQ2y31l3ZhM16VgjyiUPf48NAZVlEM0baAsEpGbf8CGiATpAYSXoxk2jOaPa9
	tNpnrKv8QfpYwaabsYP2P7XRD8uPBNLY2sW312UfLv7YJt5ZoO/5PrTPdkC29UT8FzH+80
	58cNBAzf4UNydjQiDpbqtiXs+dG8a50=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-467-XYKpxY26OWGyZ1_q7N7kEA-1; Thu,
 21 Mar 2024 08:08:18 -0400
X-MC-Unique: XYKpxY26OWGyZ1_q7N7kEA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E7D2F3C0E44C;
	Thu, 21 Mar 2024 12:08:17 +0000 (UTC)
Received: from bfoster (unknown [10.22.16.57])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 4E71E492BCA;
	Thu, 21 Mar 2024 12:08:17 +0000 (UTC)
Date: Thu, 21 Mar 2024 08:10:11 -0400
From: Brian Foster <bfoster@redhat.com>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: akpm@linux-foundation.org, tj@kernel.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	willy@infradead.org, jack@suse.cz, dsterba@suse.com,
	mjguzik@gmail.com, dhowells@redhat.com, peterz@infradead.org
Subject: Re: [PATCH 1/6] writeback: collect stats of all wb of bdi in
 bdi_debug_stats_show
Message-ID: <Zfwjo_ZQH_LFZ1Rc@bfoster>
References: <20240320110222.6564-1-shikemeng@huaweicloud.com>
 <20240320110222.6564-2-shikemeng@huaweicloud.com>
 <Zfriwb03HCRWJ24q@bfoster>
 <3d08c249-1b12-f82b-2662-a6fa2b888011@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d08c249-1b12-f82b-2662-a6fa2b888011@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

On Thu, Mar 21, 2024 at 11:44:40AM +0800, Kemeng Shi wrote:
> 
> 
> on 3/20/2024 9:21 PM, Brian Foster wrote:
> > On Wed, Mar 20, 2024 at 07:02:17PM +0800, Kemeng Shi wrote:
> >> /sys/kernel/debug/bdi/xxx/stats is supposed to show writeback information
> >> of whole bdi, but only writeback information of bdi in root cgroup is
> >> collected. So writeback information in non-root cgroup are missing now.
> >> To be more specific, considering following case:
> >>
> >> /* create writeback cgroup */
> >> cd /sys/fs/cgroup
> >> echo "+memory +io" > cgroup.subtree_control
> >> mkdir group1
> >> cd group1
> >> echo $$ > cgroup.procs
> >> /* do writeback in cgroup */
> >> fio -name test -filename=/dev/vdb ...
> >> /* get writeback info of bdi */
> >> cat /sys/kernel/debug/bdi/xxx/stats
> >> The cat result unexpectedly implies that there is no writeback on target
> >> bdi.
> >>
> >> Fix this by collecting stats of all wb in bdi instead of only wb in
> >> root cgroup.
> >>
> >> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> >> ---
> >>  mm/backing-dev.c | 93 ++++++++++++++++++++++++++++++++++++------------
> >>  1 file changed, 70 insertions(+), 23 deletions(-)
> >>
> >> diff --git a/mm/backing-dev.c b/mm/backing-dev.c
> >> index 5f2be8c8df11..788702b6c5dd 100644
> >> --- a/mm/backing-dev.c
> >> +++ b/mm/backing-dev.c
> > ...
> >> @@ -46,31 +59,65 @@ static void bdi_debug_init(void)
> >>  	bdi_debug_root = debugfs_create_dir("bdi", NULL);
> >>  }
> >>  
> > ...
> >> +#ifdef CONFIG_CGROUP_WRITEBACK
> >> +static void bdi_collect_stats(struct backing_dev_info *bdi,
> >> +			      struct wb_stats *stats)
> >> +{
> >> +	struct bdi_writeback *wb;
> >> +
> >> +	/* protect wb from release */
> >> +	mutex_lock(&bdi->cgwb_release_mutex);
> >> +	list_for_each_entry(wb, &bdi->wb_list, bdi_node)
> >> +		collect_wb_stats(stats, wb);
> >> +	mutex_unlock(&bdi->cgwb_release_mutex);
> >> +}
> >> +#else
> >> +static void bdi_collect_stats(struct backing_dev_info *bdi,
> >> +			      struct wb_stats *stats)
> >> +{
> >> +	collect_wb_stats(stats, &bdi->wb);
> >> +}
> >> +#endif
> >> +
> > 
> > I'm not familiar enough with the cgwb code to say for sure (and I'd
> > probably wait for more high level feedback before worrying too much
> > about this), but do we need the ifdef here just to iterate ->wb_list?
> >>From looking at the code, it appears bdi->wb ends up on the list while
> > the bdi is registered for both cases, so that distinction seems
> > unnecessary. WRT to wb release protection, I wonder if this could use a
> Currently, we have ifdef trying to remove unnecessary cost when
> CONFIG_CGROUP_WRITEBACK is not enabled, see defination of cgwb_bdi_register
> and cgwb_remove_from_bdi_list for example. So I try to define bdi_collect_stats
> in similar way.
> > combination of rcu_read_lock()/list_for_each_safe() and wb_tryget() on
> > each wb before collecting its stats..? See how bdi_split_work_to_wbs()
> > works, for example.
> The combination of rcu_read_lock()/list_for_each_safe() and wb_tryget()
> should work fine.
> With ifdef, bdi_collect_stats takes no extra cost when CONFIG_CGROUP_WRITEBACK
> is not enabled and is consistent with existing code style, so I still prefer
> this way. Yes, The extra cost is not a big deal as it only exists in debug mode,
> so it's acceptable to use the suggested combination in next version if you are
> still strongly aganst this.
> 

Ok. I also previously missed that there are two implementations of
bdi_split_work_to_wbs() based on CGROUP_WRITEBACK. It seems reasonable
enough to me to follow that precedent for the !CGROUP_WRITEBACK case.

It still seems to make more sense to me to walk the list similar to how
bdi_split_work_to_wbs() does for the CGROUP_WRITEBACK enabled case. Do
you agree?

Brian

> > 
> > Also I see a patch conflict/compile error on patch 2 due to
> > __wb_calc_thresh() only taking one parameter in my tree. What's the
> > baseline commit for this series?
> > 
> Sorry for missing this, this seris is based on another patchset [1] which is still
> under review.
> Look forward to your reply!
> 
> Thansk
> Kemeng
> 
> [1] https://lore.kernel.org/lkml/20240123183332.876854-1-shikemeng@huaweicloud.com/T/#mc6455784a63d0f8aa1a2f5aff325abcdf9336b76
> 
> > Brian
> > 
> >> +static int bdi_debug_stats_show(struct seq_file *m, void *v)
> >> +{
> >> +	struct backing_dev_info *bdi = m->private;
> >> +	unsigned long background_thresh;
> >> +	unsigned long dirty_thresh;
> >> +	struct wb_stats stats;
> >> +	unsigned long tot_bw;
> >> +
> >>  	global_dirty_limits(&background_thresh, &dirty_thresh);
> >> -	wb_thresh = wb_calc_thresh(wb, dirty_thresh);
> >> +
> >> +	memset(&stats, 0, sizeof(stats));
> >> +	stats.dirty_thresh = dirty_thresh;
> >> +	bdi_collect_stats(bdi, &stats);
> >> +
> >> +	tot_bw = atomic_long_read(&bdi->tot_write_bandwidth);
> >>  
> >>  	seq_printf(m,
> >>  		   "BdiWriteback:       %10lu kB\n"
> >> @@ -87,18 +134,18 @@ static int bdi_debug_stats_show(struct seq_file *m, void *v)
> >>  		   "b_dirty_time:       %10lu\n"
> >>  		   "bdi_list:           %10u\n"
> >>  		   "state:              %10lx\n",
> >> -		   (unsigned long) K(wb_stat(wb, WB_WRITEBACK)),
> >> -		   (unsigned long) K(wb_stat(wb, WB_RECLAIMABLE)),
> >> -		   K(wb_thresh),
> >> +		   K(stats.nr_writeback),
> >> +		   K(stats.nr_reclaimable),
> >> +		   K(stats.wb_thresh),
> >>  		   K(dirty_thresh),
> >>  		   K(background_thresh),
> >> -		   (unsigned long) K(wb_stat(wb, WB_DIRTIED)),
> >> -		   (unsigned long) K(wb_stat(wb, WB_WRITTEN)),
> >> -		   (unsigned long) K(wb->write_bandwidth),
> >> -		   nr_dirty,
> >> -		   nr_io,
> >> -		   nr_more_io,
> >> -		   nr_dirty_time,
> >> +		   K(stats.nr_dirtied),
> >> +		   K(stats.nr_written),
> >> +		   K(tot_bw),
> >> +		   stats.nr_dirty,
> >> +		   stats.nr_io,
> >> +		   stats.nr_more_io,
> >> +		   stats.nr_dirty_time,
> >>  		   !list_empty(&bdi->bdi_list), bdi->wb.state);
> >>  
> >>  	return 0;
> >> -- 
> >> 2.30.0
> >>
> >>
> > 
> > 
> 


