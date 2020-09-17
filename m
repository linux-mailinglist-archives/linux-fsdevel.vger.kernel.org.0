Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A819526D75F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Sep 2020 11:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbgIQJG7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Sep 2020 05:06:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:58692 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726309AbgIQJGz (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Sep 2020 05:06:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EC534AE08;
        Thu, 17 Sep 2020 09:07:26 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id D5C071E12E1; Thu, 17 Sep 2020 11:06:52 +0200 (CEST)
Date:   Thu, 17 Sep 2020 11:06:52 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Song Liu <song@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Richard Weinberger <richard@nod.at>,
        Minchan Kim <minchan@kernel.org>,
        linux-mtd@lists.infradead.org, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        drbd-dev@lists.linbit.com, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org
Subject: Re: [PATCH 09/12] mm: use SWP_SYNCHRONOUS_IO more intelligently
Message-ID: <20200917090652.GB7347@quack2.suse.cz>
References: <20200910144833.742260-1-hch@lst.de>
 <20200910144833.742260-10-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200910144833.742260-10-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 10-09-20 16:48:29, Christoph Hellwig wrote:
> There is no point in trying to call bdev_read_page if SWP_SYNCHRONOUS_IO
> is not set, as the device won't support it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  mm/page_io.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/page_io.c b/mm/page_io.c
> index e485a6e8a6cddb..b199b87e0aa92b 100644
> --- a/mm/page_io.c
> +++ b/mm/page_io.c
> @@ -403,15 +403,17 @@ int swap_readpage(struct page *page, bool synchronous)
>  		goto out;
>  	}
>  
> -	ret = bdev_read_page(sis->bdev, swap_page_sector(page), page);
> -	if (!ret) {
> -		if (trylock_page(page)) {
> -			swap_slot_free_notify(page);
> -			unlock_page(page);
> -		}
> +	if (sis->flags & SWP_SYNCHRONOUS_IO) {
> +		ret = bdev_read_page(sis->bdev, swap_page_sector(page), page);
> +		if (!ret) {
> +			if (trylock_page(page)) {
> +				swap_slot_free_notify(page);
> +				unlock_page(page);
> +			}
>  
> -		count_vm_event(PSWPIN);
> -		goto out;
> +			count_vm_event(PSWPIN);
> +			goto out;
> +		}
>  	}
>  
>  	ret = 0;
> -- 
> 2.28.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
