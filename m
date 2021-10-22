Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56F56437433
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Oct 2021 11:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232353AbhJVJEW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Oct 2021 05:04:22 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:39494 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232314AbhJVJEV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Oct 2021 05:04:21 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id A00702197A;
        Fri, 22 Oct 2021 09:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634893323; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zL5TWf1TslKGkjBeFt55t2zjOugZfLksrwBt6Qx+crs=;
        b=JiyKm3wkru6q+8Sl1zyDZDaPoX98q1e/E+OBkJT480GzmUF/rvqlet0yPPj5PJFnGSA9ro
        stFezVkwiI3fEkal/AZdSa4uLIq1TTOMe19wWTrN0J/aCqJXSEwQ9A/gWmnIbdqNpHtXh6
        sm6oqmUAGtv1NaYtHuLseYQ83vUuB5Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634893323;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zL5TWf1TslKGkjBeFt55t2zjOugZfLksrwBt6Qx+crs=;
        b=YWsU14voVP1mjzOhYe/BxIGTGGFVknMqTV95LiG6RpNDCX5NwIeRkzDkLfbVGlR9j9JGAD
        wEsSLINUXc/zg2Dw==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 7047DA3B81;
        Fri, 22 Oct 2021 09:02:03 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 23CD51E11B6; Fri, 22 Oct 2021 11:02:03 +0200 (CEST)
Date:   Fri, 22 Oct 2021 11:02:03 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>, Jan Kara <jack@suse.cz>,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 5/5] mm: simplify bdi refcounting
Message-ID: <20211022090203.GF1026@quack2.suse.cz>
References: <20211021124441.668816-1-hch@lst.de>
 <20211021124441.668816-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211021124441.668816-6-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 21-10-21 14:44:41, Christoph Hellwig wrote:
> Move grabbing and releasing the bdi refcount out of the common
> wb_init/wb_exit helpers into code that is only used for the non-default
> memcg driven bdi_writeback structures.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Can we perhaps add a comment to struct bdi_writeback definition (or maybe
wb_init()?) mentioning that it holds a reference to 'bdi' if it is
bdi_writeback struct for a cgroup? I don't see it mentioned anywhere and
now that you've changed the code, it isn't that obvious from the code
either... Otherwise the patch looks good so feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza


> ---
>  mm/backing-dev.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/backing-dev.c b/mm/backing-dev.c
> index 768e9ae489f66..5ccb250898083 100644
> --- a/mm/backing-dev.c
> +++ b/mm/backing-dev.c
> @@ -291,8 +291,6 @@ static int wb_init(struct bdi_writeback *wb, struct backing_dev_info *bdi,
>  
>  	memset(wb, 0, sizeof(*wb));
>  
> -	if (wb != &bdi->wb)
> -		bdi_get(bdi);
>  	wb->bdi = bdi;
>  	wb->last_old_flush = jiffies;
>  	INIT_LIST_HEAD(&wb->b_dirty);
> @@ -316,7 +314,7 @@ static int wb_init(struct bdi_writeback *wb, struct backing_dev_info *bdi,
>  
>  	err = fprop_local_init_percpu(&wb->completions, gfp);
>  	if (err)
> -		goto out_put_bdi;
> +		return err;
>  
>  	for (i = 0; i < NR_WB_STAT_ITEMS; i++) {
>  		err = percpu_counter_init(&wb->stat[i], 0, gfp);
> @@ -330,9 +328,6 @@ static int wb_init(struct bdi_writeback *wb, struct backing_dev_info *bdi,
>  	while (i--)
>  		percpu_counter_destroy(&wb->stat[i]);
>  	fprop_local_destroy_percpu(&wb->completions);
> -out_put_bdi:
> -	if (wb != &bdi->wb)
> -		bdi_put(bdi);
>  	return err;
>  }
>  
> @@ -373,8 +368,6 @@ static void wb_exit(struct bdi_writeback *wb)
>  		percpu_counter_destroy(&wb->stat[i]);
>  
>  	fprop_local_destroy_percpu(&wb->completions);
> -	if (wb != &wb->bdi->wb)
> -		bdi_put(wb->bdi);
>  }
>  
>  #ifdef CONFIG_CGROUP_WRITEBACK
> @@ -397,6 +390,7 @@ static void cgwb_release_workfn(struct work_struct *work)
>  	struct bdi_writeback *wb = container_of(work, struct bdi_writeback,
>  						release_work);
>  	struct blkcg *blkcg = css_to_blkcg(wb->blkcg_css);
> +	struct backing_dev_info *bdi = wb->bdi;
>  
>  	mutex_lock(&wb->bdi->cgwb_release_mutex);
>  	wb_shutdown(wb);
> @@ -416,6 +410,7 @@ static void cgwb_release_workfn(struct work_struct *work)
>  
>  	percpu_ref_exit(&wb->refcnt);
>  	wb_exit(wb);
> +	bdi_put(bdi);
>  	WARN_ON_ONCE(!list_empty(&wb->b_attached));
>  	kfree_rcu(wb, rcu);
>  }
> @@ -497,6 +492,7 @@ static int cgwb_create(struct backing_dev_info *bdi,
>  	INIT_LIST_HEAD(&wb->b_attached);
>  	INIT_WORK(&wb->release_work, cgwb_release_workfn);
>  	set_bit(WB_registered, &wb->state);
> +	bdi_get(bdi);
>  
>  	/*
>  	 * The root wb determines the registered state of the whole bdi and
> @@ -528,6 +524,7 @@ static int cgwb_create(struct backing_dev_info *bdi,
>  	goto out_put;
>  
>  err_fprop_exit:
> +	bdi_put(bdi);
>  	fprop_local_destroy_percpu(&wb->memcg_completions);
>  err_ref_exit:
>  	percpu_ref_exit(&wb->refcnt);
> -- 
> 2.30.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
