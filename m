Return-Path: <linux-fsdevel+bounces-15022-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B0B886048
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 19:06:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BC7FB20E87
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 18:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBABA1332B7;
	Thu, 21 Mar 2024 18:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="w7lT68Oz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MYtuAGMa";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="w7lT68Oz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MYtuAGMa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2763485938;
	Thu, 21 Mar 2024 18:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711044392; cv=none; b=N2YA6iLanCiKco8XQPbT3E8IB30aGeCWUppjWhwzUWu/zQ/LcIP/Yv+l+1A4SBRPublPuotPBMFDaaZp10YGrz0vPUuZfaP3r8YzJ033tlAM9XokvZGygPV2uNdWBnoPAlQ7qMH+ctMgpIRBaO+oYou4KZZrmek2/cJeMYARpds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711044392; c=relaxed/simple;
	bh=kJrZ3FrkwvsIEAdYklwK2BTz9nTXtGc86+l16KyBOEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yim4OGkhf1pLAW9LHVdSQYCsqm1CE6O9SMgwgHiliX0NXUAYMdMaXzxbYPAn4DwSIKUivyWRhprVvilnbqmVE+3q786eUo71GUob5TDFgigNp2PFCt81J0RftaN6JkMOyYhai8ReNMMd8dNQ3g/330IXYCdIHtDooD+fhaLcSew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=w7lT68Oz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=MYtuAGMa; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=w7lT68Oz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=MYtuAGMa; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9059421E83;
	Thu, 21 Mar 2024 18:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711044385; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CGVHmTaTp8V9BZmoFhStOl7fyzif6q6m2j5KQberDvI=;
	b=w7lT68OzRPoxfG/hfxpofqN8QxlCEI72WnQVD/otuPit/xsQS3kknF0DZcO31LBzqy4B5l
	ZKCw+9zyq50FVn2Y9QxS2C0mBmUNUyz1TJF1aFzethOvkk9y7tmxVS4Tju4Qtdb3SGUiga
	9U31koKDRrrb07uPZW4g5wnW4MpM62Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711044385;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CGVHmTaTp8V9BZmoFhStOl7fyzif6q6m2j5KQberDvI=;
	b=MYtuAGMaNl8DwPSPn6WffLO7cvdpC1k+t9LxlY0JUkXnuc53PR8ZW9ZbehMg9bgaQigS2y
	ZuRsp7pPd7CwpDDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711044385; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CGVHmTaTp8V9BZmoFhStOl7fyzif6q6m2j5KQberDvI=;
	b=w7lT68OzRPoxfG/hfxpofqN8QxlCEI72WnQVD/otuPit/xsQS3kknF0DZcO31LBzqy4B5l
	ZKCw+9zyq50FVn2Y9QxS2C0mBmUNUyz1TJF1aFzethOvkk9y7tmxVS4Tju4Qtdb3SGUiga
	9U31koKDRrrb07uPZW4g5wnW4MpM62Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711044385;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CGVHmTaTp8V9BZmoFhStOl7fyzif6q6m2j5KQberDvI=;
	b=MYtuAGMaNl8DwPSPn6WffLO7cvdpC1k+t9LxlY0JUkXnuc53PR8ZW9ZbehMg9bgaQigS2y
	ZuRsp7pPd7CwpDDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7B675138A1;
	Thu, 21 Mar 2024 18:06:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eV3cHSF3/GWVOQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 21 Mar 2024 18:06:25 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id DA2D0A0806; Thu, 21 Mar 2024 19:06:20 +0100 (CET)
Date: Thu, 21 Mar 2024 19:06:20 +0100
From: Jan Kara <jack@suse.cz>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: akpm@linux-foundation.org, tj@kernel.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	willy@infradead.org, bfoster@redhat.com, jack@suse.cz,
	dsterba@suse.com, mjguzik@gmail.com, dhowells@redhat.com,
	peterz@infradead.org
Subject: Re: [PATCH 1/6] writeback: collect stats of all wb of bdi in
 bdi_debug_stats_show
Message-ID: <20240321180620.mbint45pbyc74vpg@quack3>
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
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWELVE(0.00)[13];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,kvack.org,vger.kernel.org,infradead.org,redhat.com,suse.cz,suse.com,gmail.com];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

On Wed 20-03-24 19:02:17, Kemeng Shi wrote:
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

Looks mostly good, one comment below:

> ---
>  mm/backing-dev.c | 93 ++++++++++++++++++++++++++++++++++++------------
>  1 file changed, 70 insertions(+), 23 deletions(-)
> 
> diff --git a/mm/backing-dev.c b/mm/backing-dev.c
> index 5f2be8c8df11..788702b6c5dd 100644
> --- a/mm/backing-dev.c
> +++ b/mm/backing-dev.c
> @@ -39,6 +39,19 @@ struct workqueue_struct *bdi_wq;
>  #include <linux/debugfs.h>
>  #include <linux/seq_file.h>
>  
> +struct wb_stats {
> +	unsigned long nr_dirty;
> +	unsigned long nr_io;
> +	unsigned long nr_more_io;
> +	unsigned long nr_dirty_time;
> +	unsigned long nr_writeback;
> +	unsigned long nr_reclaimable;
> +	unsigned long nr_dirtied;
> +	unsigned long nr_written;
> +	unsigned long dirty_thresh;
> +	unsigned long wb_thresh;
> +};
> +
>  static struct dentry *bdi_debug_root;
>  
>  static void bdi_debug_init(void)
> @@ -46,31 +59,65 @@ static void bdi_debug_init(void)
>  	bdi_debug_root = debugfs_create_dir("bdi", NULL);
>  }
>  
> -static int bdi_debug_stats_show(struct seq_file *m, void *v)
> +static void collect_wb_stats(struct wb_stats *stats,
> +			     struct bdi_writeback *wb)
>  {
> -	struct backing_dev_info *bdi = m->private;
> -	struct bdi_writeback *wb = &bdi->wb;
> -	unsigned long background_thresh;
> -	unsigned long dirty_thresh;
> -	unsigned long wb_thresh;
> -	unsigned long nr_dirty, nr_io, nr_more_io, nr_dirty_time;
>  	struct inode *inode;
>  
> -	nr_dirty = nr_io = nr_more_io = nr_dirty_time = 0;
>  	spin_lock(&wb->list_lock);
>  	list_for_each_entry(inode, &wb->b_dirty, i_io_list)
> -		nr_dirty++;
> +		stats->nr_dirty++;
>  	list_for_each_entry(inode, &wb->b_io, i_io_list)
> -		nr_io++;
> +		stats->nr_io++;
>  	list_for_each_entry(inode, &wb->b_more_io, i_io_list)
> -		nr_more_io++;
> +		stats->nr_more_io++;
>  	list_for_each_entry(inode, &wb->b_dirty_time, i_io_list)
>  		if (inode->i_state & I_DIRTY_TIME)
> -			nr_dirty_time++;
> +			stats->nr_dirty_time++;
>  	spin_unlock(&wb->list_lock);
>  
> +	stats->nr_writeback += wb_stat(wb, WB_WRITEBACK);
> +	stats->nr_reclaimable += wb_stat(wb, WB_RECLAIMABLE);
> +	stats->nr_dirtied += wb_stat(wb, WB_DIRTIED);
> +	stats->nr_written += wb_stat(wb, WB_WRITTEN);
> +	stats->wb_thresh += wb_calc_thresh(wb, stats->dirty_thresh);
> +}
> +
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

So AFAICT this function can race against
  bdi_unregister() -> wb_shutdown(&bdi->wb)

because that doesn't take the cgwb_release_mutex. So we either need the RCU
protection as Brian suggested or cgwb_lock or something. But given
collect_wb_stats() can take a significant amount of time (traversing all
the lists etc.) I think we'll need something more clever.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

