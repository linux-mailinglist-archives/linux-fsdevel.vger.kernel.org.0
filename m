Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A954F3C7263
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jul 2021 16:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236820AbhGMOml (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jul 2021 10:42:41 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:34544 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236636AbhGMOml (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jul 2021 10:42:41 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id EE114201E5;
        Tue, 13 Jul 2021 14:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1626187189; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zJgth62e6DRwxuE1p4QeibZRXKh6lnd/FGpb00zXtco=;
        b=O68ObX8MG6BlpUhu/xBv9j7G1mYqUdqLnRyV03xbqEujXuAfy0gpOA9lJ/F4bdBCKke3Lk
        a/MXrhFnAh+ZWYWAl3kgsN5DvQbJlWQV8LmNxkZMvNL2ViqzuUBDde0tvQuoR/1YT88dFm
        1AYwhHBSkTc0TaS/25XfTyoazBgd9JM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1626187189;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zJgth62e6DRwxuE1p4QeibZRXKh6lnd/FGpb00zXtco=;
        b=8I2ejwrN0kq14Tnws/o7U/fah1Jw9rBREUuBXF5M68+gOMotjQpjh0qFRfO0R5JN5U1NiW
        veZxhd2s1RXuuSCQ==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id E1AB2A3B85;
        Tue, 13 Jul 2021 14:39:49 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id BE9F11E0BBE; Tue, 13 Jul 2021 16:39:49 +0200 (CEST)
Date:   Tue, 13 Jul 2021 16:39:49 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v13 064/137] flex_proportions: Allow N events instead of 1
Message-ID: <20210713143949.GB24271@quack2.suse.cz>
References: <20210712030701.4000097-1-willy@infradead.org>
 <20210712030701.4000097-65-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210712030701.4000097-65-willy@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 12-07-21 04:05:48, Matthew Wilcox (Oracle) wrote:
> When batching events (such as writing back N pages in a single I/O), it
> is better to do one flex_proportion operation instead of N.  There is
> only one caller of __fprop_inc_percpu_max(), and it's the one we're
> going to change in the next patch, so rename it instead of adding a
> compatibility wrapper.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Looks good. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/linux/flex_proportions.h |  9 +++++----
>  lib/flex_proportions.c           | 28 +++++++++++++++++++---------
>  mm/page-writeback.c              |  4 ++--
>  3 files changed, 26 insertions(+), 15 deletions(-)
> 
> diff --git a/include/linux/flex_proportions.h b/include/linux/flex_proportions.h
> index c12df59d3f5f..3e378b1fb0bc 100644
> --- a/include/linux/flex_proportions.h
> +++ b/include/linux/flex_proportions.h
> @@ -83,9 +83,10 @@ struct fprop_local_percpu {
>  
>  int fprop_local_init_percpu(struct fprop_local_percpu *pl, gfp_t gfp);
>  void fprop_local_destroy_percpu(struct fprop_local_percpu *pl);
> -void __fprop_inc_percpu(struct fprop_global *p, struct fprop_local_percpu *pl);
> -void __fprop_inc_percpu_max(struct fprop_global *p, struct fprop_local_percpu *pl,
> -			    int max_frac);
> +void __fprop_add_percpu(struct fprop_global *p, struct fprop_local_percpu *pl,
> +		long nr);
> +void __fprop_add_percpu_max(struct fprop_global *p,
> +		struct fprop_local_percpu *pl, int max_frac, long nr);
>  void fprop_fraction_percpu(struct fprop_global *p,
>  	struct fprop_local_percpu *pl, unsigned long *numerator,
>  	unsigned long *denominator);
> @@ -96,7 +97,7 @@ void fprop_inc_percpu(struct fprop_global *p, struct fprop_local_percpu *pl)
>  	unsigned long flags;
>  
>  	local_irq_save(flags);
> -	__fprop_inc_percpu(p, pl);
> +	__fprop_add_percpu(p, pl, 1);
>  	local_irq_restore(flags);
>  }
>  
> diff --git a/lib/flex_proportions.c b/lib/flex_proportions.c
> index 451543937524..53e7eb1dd76c 100644
> --- a/lib/flex_proportions.c
> +++ b/lib/flex_proportions.c
> @@ -217,11 +217,12 @@ static void fprop_reflect_period_percpu(struct fprop_global *p,
>  }
>  
>  /* Event of type pl happened */
> -void __fprop_inc_percpu(struct fprop_global *p, struct fprop_local_percpu *pl)
> +void __fprop_add_percpu(struct fprop_global *p, struct fprop_local_percpu *pl,
> +		long nr)
>  {
>  	fprop_reflect_period_percpu(p, pl);
> -	percpu_counter_add_batch(&pl->events, 1, PROP_BATCH);
> -	percpu_counter_add(&p->events, 1);
> +	percpu_counter_add_batch(&pl->events, nr, PROP_BATCH);
> +	percpu_counter_add(&p->events, nr);
>  }
>  
>  void fprop_fraction_percpu(struct fprop_global *p,
> @@ -253,20 +254,29 @@ void fprop_fraction_percpu(struct fprop_global *p,
>  }
>  
>  /*
> - * Like __fprop_inc_percpu() except that event is counted only if the given
> + * Like __fprop_add_percpu() except that event is counted only if the given
>   * type has fraction smaller than @max_frac/FPROP_FRAC_BASE
>   */
> -void __fprop_inc_percpu_max(struct fprop_global *p,
> -			    struct fprop_local_percpu *pl, int max_frac)
> +void __fprop_add_percpu_max(struct fprop_global *p,
> +		struct fprop_local_percpu *pl, int max_frac, long nr)
>  {
>  	if (unlikely(max_frac < FPROP_FRAC_BASE)) {
>  		unsigned long numerator, denominator;
> +		s64 tmp;
>  
>  		fprop_fraction_percpu(p, pl, &numerator, &denominator);
> -		if (numerator >
> -		    (((u64)denominator) * max_frac) >> FPROP_FRAC_SHIFT)
> +		/* Adding 'nr' to fraction exceeds max_frac/FPROP_FRAC_BASE? */
> +		tmp = (u64)denominator * max_frac -
> +					((u64)numerator << FPROP_FRAC_SHIFT);
> +		if (tmp < 0) {
> +			/* Maximum fraction already exceeded? */
>  			return;
> +		} else if (tmp < nr * (FPROP_FRAC_BASE - max_frac)) {
> +			/* Add just enough for the fraction to saturate */
> +			nr = div_u64(tmp + FPROP_FRAC_BASE - max_frac - 1,
> +					FPROP_FRAC_BASE - max_frac);
> +		}
>  	}
>  
> -	__fprop_inc_percpu(p, pl);
> +	__fprop_add_percpu(p, pl, nr);
>  }
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index e677e79c7b9b..63c0dd9f8bf7 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -566,8 +566,8 @@ static void wb_domain_writeout_inc(struct wb_domain *dom,
>  				   struct fprop_local_percpu *completions,
>  				   unsigned int max_prop_frac)
>  {
> -	__fprop_inc_percpu_max(&dom->completions, completions,
> -			       max_prop_frac);
> +	__fprop_add_percpu_max(&dom->completions, completions,
> +			       max_prop_frac, 1);
>  	/* First event after period switching was turned off? */
>  	if (unlikely(!dom->period_time)) {
>  		/*
> -- 
> 2.30.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
