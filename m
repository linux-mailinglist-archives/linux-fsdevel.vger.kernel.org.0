Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5EC73667EE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Apr 2021 11:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238206AbhDUJZ5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Apr 2021 05:25:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:50046 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238190AbhDUJZz (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Apr 2021 05:25:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3CDFAB176;
        Wed, 21 Apr 2021 09:25:21 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 128351F2B69; Wed, 21 Apr 2021 11:25:21 +0200 (CEST)
Date:   Wed, 21 Apr 2021 11:25:21 +0200
From:   Jan Kara <jack@suse.cz>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, dan.j.williams@intel.com,
        jack@suse.cz, willy@infradead.org, virtio-fs@redhat.com,
        slp@redhat.com, miklos@szeredi.hu, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] dax: Add a wakeup mode parameter to
 put_unlocked_entry()
Message-ID: <20210421092521.GN8706@quack2.suse.cz>
References: <20210419213636.1514816-1-vgoyal@redhat.com>
 <20210419213636.1514816-3-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210419213636.1514816-3-vgoyal@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 19-04-21 17:36:35, Vivek Goyal wrote:
> As of now put_unlocked_entry() always wakes up next waiter. In next
> patches we want to wake up all waiters at one callsite. Hence, add a
> parameter to the function.
> 
> This patch does not introduce any change of behavior.
> 
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>

Looks good. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/dax.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/dax.c b/fs/dax.c
> index 00978d0838b1..f19d76a6a493 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -275,11 +275,12 @@ static void wait_entry_unlocked(struct xa_state *xas, void *entry)
>  	finish_wait(wq, &ewait.wait);
>  }
>  
> -static void put_unlocked_entry(struct xa_state *xas, void *entry)
> +static void put_unlocked_entry(struct xa_state *xas, void *entry,
> +			       enum dax_entry_wake_mode mode)
>  {
>  	/* If we were the only waiter woken, wake the next one */
>  	if (entry && !dax_is_conflict(entry))
> -		dax_wake_entry(xas, entry, WAKE_NEXT);
> +		dax_wake_entry(xas, entry, mode);
>  }
>  
>  /*
> @@ -633,7 +634,7 @@ struct page *dax_layout_busy_page_range(struct address_space *mapping,
>  			entry = get_unlocked_entry(&xas, 0);
>  		if (entry)
>  			page = dax_busy_page(entry);
> -		put_unlocked_entry(&xas, entry);
> +		put_unlocked_entry(&xas, entry, WAKE_NEXT);
>  		if (page)
>  			break;
>  		if (++scanned % XA_CHECK_SCHED)
> @@ -675,7 +676,7 @@ static int __dax_invalidate_entry(struct address_space *mapping,
>  	mapping->nrexceptional--;
>  	ret = 1;
>  out:
> -	put_unlocked_entry(&xas, entry);
> +	put_unlocked_entry(&xas, entry, WAKE_NEXT);
>  	xas_unlock_irq(&xas);
>  	return ret;
>  }
> @@ -954,7 +955,7 @@ static int dax_writeback_one(struct xa_state *xas, struct dax_device *dax_dev,
>  	return ret;
>  
>   put_unlocked:
> -	put_unlocked_entry(xas, entry);
> +	put_unlocked_entry(xas, entry, WAKE_NEXT);
>  	return ret;
>  }
>  
> @@ -1695,7 +1696,7 @@ dax_insert_pfn_mkwrite(struct vm_fault *vmf, pfn_t pfn, unsigned int order)
>  	/* Did we race with someone splitting entry or so? */
>  	if (!entry || dax_is_conflict(entry) ||
>  	    (order == 0 && !dax_is_pte_entry(entry))) {
> -		put_unlocked_entry(&xas, entry);
> +		put_unlocked_entry(&xas, entry, WAKE_NEXT);
>  		xas_unlock_irq(&xas);
>  		trace_dax_insert_pfn_mkwrite_no_entry(mapping->host, vmf,
>  						      VM_FAULT_NOPAGE);
> -- 
> 2.25.4
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
