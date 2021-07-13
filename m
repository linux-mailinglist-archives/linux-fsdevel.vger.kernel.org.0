Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDB9E3C7271
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jul 2021 16:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236873AbhGMOne (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jul 2021 10:43:34 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:41734 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236904AbhGMOnd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jul 2021 10:43:33 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id CDBAB22984;
        Tue, 13 Jul 2021 14:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1626187241; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BwNe64VMZn2yiDWOKM8XaMldMBilnvc5QIq1eVu9sq8=;
        b=c2DBsYMtGFFfL1b7RKoFsDBngAZKGF9G0rW+XHgxSURqeG4qqg3Dh0ZDkYw9Zxnqq93ukB
        /3zX2EQyPkQzATKGgwO4nx34QY79hk4ho6WHeWL2D5TF7ziABW8qVbaruWO20JTPpj1bq5
        DtvgODlLJOiPWvjq/PZH9JQGcHQwTno=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1626187241;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BwNe64VMZn2yiDWOKM8XaMldMBilnvc5QIq1eVu9sq8=;
        b=CZ+QKOL2vecPomdJtQee7s6HqiNVFeUFxkbMsaUlr+Qo1RE7r7dSM9IcLpqACunydKPRvc
        uquv7pTWVm5VZeAg==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id C0233A3B83;
        Tue, 13 Jul 2021 14:40:41 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id ABF141E0BBE; Tue, 13 Jul 2021 16:40:41 +0200 (CEST)
Date:   Tue, 13 Jul 2021 16:40:41 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v13 065/137] mm/writeback: Change __wb_writeout_inc() to
 __wb_writeout_add()
Message-ID: <20210713144041.GC24271@quack2.suse.cz>
References: <20210712030701.4000097-1-willy@infradead.org>
 <20210712030701.4000097-66-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210712030701.4000097-66-willy@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 12-07-21 04:05:49, Matthew Wilcox (Oracle) wrote:
> Allow for accounting N pages at once instead of one page at a time.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  mm/page-writeback.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index 63c0dd9f8bf7..1056ff779bfe 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -562,12 +562,12 @@ static unsigned long wp_next_time(unsigned long cur_time)
>  	return cur_time;
>  }
>  
> -static void wb_domain_writeout_inc(struct wb_domain *dom,
> +static void wb_domain_writeout_add(struct wb_domain *dom,
>  				   struct fprop_local_percpu *completions,
> -				   unsigned int max_prop_frac)
> +				   unsigned int max_prop_frac, long nr)
>  {
>  	__fprop_add_percpu_max(&dom->completions, completions,
> -			       max_prop_frac, 1);
> +			       max_prop_frac, nr);
>  	/* First event after period switching was turned off? */
>  	if (unlikely(!dom->period_time)) {
>  		/*
> @@ -585,18 +585,18 @@ static void wb_domain_writeout_inc(struct wb_domain *dom,
>   * Increment @wb's writeout completion count and the global writeout
>   * completion count. Called from test_clear_page_writeback().
>   */
> -static inline void __wb_writeout_inc(struct bdi_writeback *wb)
> +static inline void __wb_writeout_add(struct bdi_writeback *wb, long nr)
>  {
>  	struct wb_domain *cgdom;
>  
> -	inc_wb_stat(wb, WB_WRITTEN);
> -	wb_domain_writeout_inc(&global_wb_domain, &wb->completions,
> -			       wb->bdi->max_prop_frac);
> +	wb_stat_mod(wb, WB_WRITTEN, nr);
> +	wb_domain_writeout_add(&global_wb_domain, &wb->completions,
> +			       wb->bdi->max_prop_frac, nr);
>  
>  	cgdom = mem_cgroup_wb_domain(wb);
>  	if (cgdom)
> -		wb_domain_writeout_inc(cgdom, wb_memcg_completions(wb),
> -				       wb->bdi->max_prop_frac);
> +		wb_domain_writeout_add(cgdom, wb_memcg_completions(wb),
> +				       wb->bdi->max_prop_frac, nr);
>  }
>  
>  void wb_writeout_inc(struct bdi_writeback *wb)
> @@ -604,7 +604,7 @@ void wb_writeout_inc(struct bdi_writeback *wb)
>  	unsigned long flags;
>  
>  	local_irq_save(flags);
> -	__wb_writeout_inc(wb);
> +	__wb_writeout_add(wb, 1);
>  	local_irq_restore(flags);
>  }
>  EXPORT_SYMBOL_GPL(wb_writeout_inc);
> @@ -2751,7 +2751,7 @@ int test_clear_page_writeback(struct page *page)
>  				struct bdi_writeback *wb = inode_to_wb(inode);
>  
>  				dec_wb_stat(wb, WB_WRITEBACK);
> -				__wb_writeout_inc(wb);
> +				__wb_writeout_add(wb, 1);
>  			}
>  		}
>  
> -- 
> 2.30.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
