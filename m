Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 233BA3EA631
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Aug 2021 16:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237822AbhHLOH5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Aug 2021 10:07:57 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:50462 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236956AbhHLOH4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Aug 2021 10:07:56 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 25579221DA;
        Thu, 12 Aug 2021 14:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628777250; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=70lfViDjSLp9djdpWufs6r68Wzu9SAenpLs48/HVGgk=;
        b=V2BSEDxe676eLo/G0hmMkDFKWZlZRQmsh0FfGNhqqQP4mZDDvQMBn5lduViaqwkBljkEi6
        X+UGp5KseaZbLk130snnreLh1rQBFehG3vAfuOOrvjZUT+bfm0aKKJdMD+Z1SAIJMA//ms
        jBrd6a6GjOW0z3jQ2hKffLyrdyjPvN8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628777250;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=70lfViDjSLp9djdpWufs6r68Wzu9SAenpLs48/HVGgk=;
        b=QaI+kazOdaLDjFB5TiGLVSfp1yhFLpCYGZAXsdwWnlXTLYnmsv/ayuiki9R5dXA68gQf+D
        s+a0p6qD2nyEEBBA==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 0C1C213A90;
        Thu, 12 Aug 2021 14:07:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id WzM+AiIrFWF4XgAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Thu, 12 Aug 2021 14:07:30 +0000
Subject: Re: [PATCH v14 065/138] mm/writeback: Change __wb_writeout_inc() to
 __wb_writeout_add()
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-66-willy@infradead.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <9c22a18d-85e6-9d7c-b90a-b50af6e3a66b@suse.cz>
Date:   Thu, 12 Aug 2021 16:07:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210715033704.692967-66-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/15/21 5:35 AM, Matthew Wilcox (Oracle) wrote:
> Allow for accounting N pages at once instead of one page at a time.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Jan Kara <jack@suse.cz>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/page-writeback.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index f55f2ebdd9a9..e542ea37d605 100644
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
> 

