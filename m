Return-Path: <linux-fsdevel+bounces-15600-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0659890793
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 18:51:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D4B71C2112E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 17:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60A1823AF;
	Thu, 28 Mar 2024 17:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TJ9cJQBV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FC612D209
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Mar 2024 17:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711648304; cv=none; b=qBdfjL5jO4NXFQNGQohQUBxNjE8H2Jqiq+o5FIIf5CNjUagrgTVzajUvF6mY2V3sjnJXYgJ8u0Njuw+hot4IjUmslrdaChRJidjVyTW1TTzPa+7MYUwtOhFow5o744t8teP4/EK7zNLARGiOfucfdi6oTZ+waRe1ExPzwEqJXSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711648304; c=relaxed/simple;
	bh=U4yHXTHHMRwN8YtzD2Qg5Gh+ldlnMTRFcRkbgd4PyW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gRbWSb+TKjgrz38BHxJ9kNmV6tUx12RuRjazAR7bI9C1XmEkJRJpefV260Djp5vWJ1C/RtAe5zpzJ2xkqeNiOiNIdQFPABT7As5gunA/d1AFZlTA3o61doE+m+Tz1/nUeg79p1WdOh3FMPmaSuQth+SeAiNQPz7lTias9JBHMo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TJ9cJQBV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711648301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J+QcM3gk0UOb/w55XoDEIwmQlkoTEaF8u9uo8lDJ1ss=;
	b=TJ9cJQBV9VyeOlgP4PQ6S14qJj6yiLh5Va+xKjfBiqSadz962wjO3T0FRycBPLBAPpxf4r
	ygAZgxSxWPvGvEJcPxNVx4uk1WTQTbpPXjjaTc3sZsTCFSL3GosBUk/oull1GYx7d1DdbI
	/nwqgpnlq8u0nCCzTglj2YCECrJobSI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-108-4zpXVmEIOq2rWiH1sW_bfg-1; Thu, 28 Mar 2024 13:51:34 -0400
X-MC-Unique: 4zpXVmEIOq2rWiH1sW_bfg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 621ED185A781;
	Thu, 28 Mar 2024 17:51:34 +0000 (UTC)
Received: from bfoster (unknown [10.22.16.57])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D78E84B4405;
	Thu, 28 Mar 2024 17:51:33 +0000 (UTC)
Date: Thu, 28 Mar 2024 13:53:31 -0400
From: Brian Foster <bfoster@redhat.com>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, jack@suse.cz,
	tj@kernel.org, dsterba@suse.com, mjguzik@gmail.com,
	dhowells@redhat.com, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] writeback: protect race between bdi release and
 bdi_debug_stats_show
Message-ID: <ZgWum7SWr44w0rie@bfoster>
References: <20240327155751.3536-1-shikemeng@huaweicloud.com>
 <20240327155751.3536-2-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327155751.3536-2-shikemeng@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

On Wed, Mar 27, 2024 at 11:57:46PM +0800, Kemeng Shi wrote:
> There is a race between bdi release and bdi_debug_stats_show:
> /* get debug info */		/* bdi release */
> bdi_debug_stats_show
>   bdi = m->private;
>   wb = &bdi->wb;
> 				bdi_unregister
> 				bdi_put
> 				  release_bdi
> 				    kfree(bdi)
>   /* use after free */
>   spin_lock(&wb->list_lock);
> 

Maybe I'm missing something, but it looks to me that
bdi_unregister_debug() can't complete until active readers of associated
debugfs files have completed. For example, see __debugfs_file_removed()
and use of ->active_users[_drained]. Once the dentry is unlinked,
further reads fail (I think) via debugfs_file_get(). Hm?

Brian

> Search bdi on bdi_list under rcu lock in bdi_debug_stats_show to ensure
> the bdi is not freed to fix the issue.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---
>  mm/backing-dev.c | 33 +++++++++++++++++++++++++++++++--
>  1 file changed, 31 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/backing-dev.c b/mm/backing-dev.c
> index 5f2be8c8df11..70f02959f3bd 100644
> --- a/mm/backing-dev.c
> +++ b/mm/backing-dev.c
> @@ -46,16 +46,44 @@ static void bdi_debug_init(void)
>  	bdi_debug_root = debugfs_create_dir("bdi", NULL);
>  }
>  
> -static int bdi_debug_stats_show(struct seq_file *m, void *v)
> +static struct backing_dev_info *lookup_bdi(struct seq_file *m)
>  {
> +	const struct file *file = m->file;
>  	struct backing_dev_info *bdi = m->private;
> -	struct bdi_writeback *wb = &bdi->wb;
> +	struct backing_dev_info *exist;
> +
> +	list_for_each_entry_rcu(exist, &bdi_list, bdi_list) {
> +		if (exist != bdi)
> +			continue;
> +
> +		if (exist->debug_dir == file->f_path.dentry->d_parent)
> +			return bdi;
> +		else
> +			return NULL;
> +	}
> +
> +	return NULL;
> +}
> +
> +
> +static int bdi_debug_stats_show(struct seq_file *m, void *v)
> +{
> +	struct backing_dev_info *bdi;
> +	struct bdi_writeback *wb;
>  	unsigned long background_thresh;
>  	unsigned long dirty_thresh;
>  	unsigned long wb_thresh;
>  	unsigned long nr_dirty, nr_io, nr_more_io, nr_dirty_time;
>  	struct inode *inode;
>  
> +	rcu_read_lock();
> +	bdi = lookup_bdi(m);
> +	if (!bdi) {
> +		rcu_read_unlock();
> +		return -EEXIST;
> +	}
> +
> +	wb = &bdi->wb;
>  	nr_dirty = nr_io = nr_more_io = nr_dirty_time = 0;
>  	spin_lock(&wb->list_lock);
>  	list_for_each_entry(inode, &wb->b_dirty, i_io_list)
> @@ -101,6 +129,7 @@ static int bdi_debug_stats_show(struct seq_file *m, void *v)
>  		   nr_dirty_time,
>  		   !list_empty(&bdi->bdi_list), bdi->wb.state);
>  
> +	rcu_read_unlock();
>  	return 0;
>  }
>  DEFINE_SHOW_ATTRIBUTE(bdi_debug_stats);
> -- 
> 2.30.0
> 


