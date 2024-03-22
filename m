Return-Path: <linux-fsdevel+bounces-15071-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BBE6886BAE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 12:57:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 037A01F24BE2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 11:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CADD53F9F9;
	Fri, 22 Mar 2024 11:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GLj8n7M6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4FD3FB07
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Mar 2024 11:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711108617; cv=none; b=Qi7RDIz3GUwfFisPfZQMLEBz7hC1PPUmw8twbPk6Uvy9AnPVpofVTjCjvK28/2oSudYRzEnAXTz/wIIQWdRbkDl7byiZzYO7T7Y2fNHdDldCBBmoEv+ZHMZ75kFJRD22/5rmIdl+gDh0M85R4tAuSbGf4nfU6RLZrFplHg9NaLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711108617; c=relaxed/simple;
	bh=Q4RS/3x0viHaa5JjdzuVSxgsfuVN6zlzwuYvVXD6sks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BJwRBjZYY4JbZarab9kuQXECsQcRssrYVLzivwSFB3iS8N3O8YBpHQM39gBgn3EnVpkVSjZUsK7PaNxHKcD52J28CJKyIBhWfZ5sfegwO5y/Piw0InpKOBnKGuc7uTu3KxNvCYvExRm0tt/gcPFiUsP283TfLY2xASB7MHlRfgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GLj8n7M6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711108614;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BRTRiL57H/xzh7fXeNRidNb3wxYqBup/qLAl32c8wE8=;
	b=GLj8n7M6r2q+cT8PJ+JH6MA8A2ioGwpx+56EpB2Ahx8kP9n7bXbOOnPS7erItzWDtf/Gug
	sErm6wn2YLNN9LKQWVAa6mqHfHeZET8zFqZ4i21BllpDERKZ+hxb8YrPJI5P4UF+rAox1g
	zuyF0w4E07hAhMauTJrEjbNigAjvsjU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-168-iecBo9tsOPuuuefjyQjlKA-1; Fri, 22 Mar 2024 07:56:47 -0400
X-MC-Unique: iecBo9tsOPuuuefjyQjlKA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 37E8585CD5B;
	Fri, 22 Mar 2024 11:56:47 +0000 (UTC)
Received: from bfoster (unknown [10.22.16.57])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A2E422022C24;
	Fri, 22 Mar 2024 11:56:46 +0000 (UTC)
Date: Fri, 22 Mar 2024 07:58:40 -0400
From: Brian Foster <bfoster@redhat.com>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: Jan Kara <jack@suse.cz>, akpm@linux-foundation.org, tj@kernel.org,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, willy@infradead.org, dsterba@suse.com,
	mjguzik@gmail.com, dhowells@redhat.com, peterz@infradead.org
Subject: Re: [PATCH 1/6] writeback: collect stats of all wb of bdi in
 bdi_debug_stats_show
Message-ID: <Zf1ycOu3ODf2UcNw@bfoster>
References: <20240320110222.6564-1-shikemeng@huaweicloud.com>
 <20240320110222.6564-2-shikemeng@huaweicloud.com>
 <20240321180620.mbint45pbyc74vpg@quack3>
 <a684ccdb-372f-b9e6-7239-ddb42a3f5f28@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a684ccdb-372f-b9e6-7239-ddb42a3f5f28@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

On Fri, Mar 22, 2024 at 03:51:27PM +0800, Kemeng Shi wrote:
> 
> 
> on 3/22/2024 2:06 AM, Jan Kara wrote:
> > On Wed 20-03-24 19:02:17, Kemeng Shi wrote:
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
> > 
> > Looks mostly good, one comment below:
> > 
> >> ---
> >>  mm/backing-dev.c | 93 ++++++++++++++++++++++++++++++++++++------------
> >>  1 file changed, 70 insertions(+), 23 deletions(-)
> >>
> >> diff --git a/mm/backing-dev.c b/mm/backing-dev.c
> >> index 5f2be8c8df11..788702b6c5dd 100644
> >> --- a/mm/backing-dev.c
> >> +++ b/mm/backing-dev.c
> >> @@ -39,6 +39,19 @@ struct workqueue_struct *bdi_wq;
> >>  #include <linux/debugfs.h>
> >>  #include <linux/seq_file.h>
> >>  
> >> +struct wb_stats {
> >> +	unsigned long nr_dirty;
> >> +	unsigned long nr_io;
> >> +	unsigned long nr_more_io;
> >> +	unsigned long nr_dirty_time;
> >> +	unsigned long nr_writeback;
> >> +	unsigned long nr_reclaimable;
> >> +	unsigned long nr_dirtied;
> >> +	unsigned long nr_written;
> >> +	unsigned long dirty_thresh;
> >> +	unsigned long wb_thresh;
> >> +};
> >> +
> >>  static struct dentry *bdi_debug_root;
> >>  
> >>  static void bdi_debug_init(void)
> >> @@ -46,31 +59,65 @@ static void bdi_debug_init(void)
> >>  	bdi_debug_root = debugfs_create_dir("bdi", NULL);
> >>  }
> >>  
> >> -static int bdi_debug_stats_show(struct seq_file *m, void *v)
> >> +static void collect_wb_stats(struct wb_stats *stats,
> >> +			     struct bdi_writeback *wb)
> >>  {
> >> -	struct backing_dev_info *bdi = m->private;
> >> -	struct bdi_writeback *wb = &bdi->wb;
> >> -	unsigned long background_thresh;
> >> -	unsigned long dirty_thresh;
> >> -	unsigned long wb_thresh;
> >> -	unsigned long nr_dirty, nr_io, nr_more_io, nr_dirty_time;
> >>  	struct inode *inode;
> >>  
> >> -	nr_dirty = nr_io = nr_more_io = nr_dirty_time = 0;
> >>  	spin_lock(&wb->list_lock);
> >>  	list_for_each_entry(inode, &wb->b_dirty, i_io_list)
> >> -		nr_dirty++;
> >> +		stats->nr_dirty++;
> >>  	list_for_each_entry(inode, &wb->b_io, i_io_list)
> >> -		nr_io++;
> >> +		stats->nr_io++;
> >>  	list_for_each_entry(inode, &wb->b_more_io, i_io_list)
> >> -		nr_more_io++;
> >> +		stats->nr_more_io++;
> >>  	list_for_each_entry(inode, &wb->b_dirty_time, i_io_list)
> >>  		if (inode->i_state & I_DIRTY_TIME)
> >> -			nr_dirty_time++;
> >> +			stats->nr_dirty_time++;
> >>  	spin_unlock(&wb->list_lock);
> >>  
> >> +	stats->nr_writeback += wb_stat(wb, WB_WRITEBACK);
> >> +	stats->nr_reclaimable += wb_stat(wb, WB_RECLAIMABLE);
> >> +	stats->nr_dirtied += wb_stat(wb, WB_DIRTIED);
> >> +	stats->nr_written += wb_stat(wb, WB_WRITTEN);
> >> +	stats->wb_thresh += wb_calc_thresh(wb, stats->dirty_thresh);
> >> +}
> >> +
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
> > 
> > So AFAICT this function can race against
> >   bdi_unregister() -> wb_shutdown(&bdi->wb)
> > 
> > because that doesn't take the cgwb_release_mutex. So we either need the RCU
> > protection as Brian suggested or cgwb_lock or something. But given
> > collect_wb_stats() can take a significant amount of time (traversing all
> > the lists etc.) I think we'll need something more clever.
> Sorry for missing this. I only pay attention to wb in cgroup as there is no
> much change to how we use bdi->wb.
> It seems that there was always a race between orginal bdi_debug_stats_show and
> release of bdi as following
> cat /.../stats
> bdi_debug_stats_show
> 			bdi_unregister
> 			bdi_put
> 			  release_bdi
> 			    kfree(bdi)
>   use after free
> 
> I will fix this in next version. Thanks!
> 

BTW, I thought this was kind of the point of the tryget in the writeback
path. I.e., the higher level loop runs under rcu_read_lock(), but in the
case it needs to cycle the rcu lock it acquires a reference to the wb,
and then can use that wb to continue the loop once the rcu lock is
reacquired. IIUC, this works because the rcu list removal keeps the list
->next pointer sane and then the ref keeps the wb memory from being
freed. A tryget of any wb's that have been shutdown fails because the
percpu ref counter has been killed.

So I _think_ this means that for the stat collection use case, you could
protect the overall walk with rcu as Jan alludes above, but then maybe
use a combination of need_resched()/cond_resched_rcu() and wb_tryget()
to introduce resched points and avoid holding lock(s) for too long.

Personally, I wonder if since this is mainly debug code we could just
get away with doing the simple thing of trying for a ref on each wb
unconditionally rather than only in a need_resched() case, but maybe
there are reasons not to do that... hm?

Brian

> > 
> > 								Honza
> > 
> 


