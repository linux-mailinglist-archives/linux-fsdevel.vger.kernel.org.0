Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07997252F9B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Aug 2020 15:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729504AbgHZNXe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Aug 2020 09:23:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:47064 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728132AbgHZNXd (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Aug 2020 09:23:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0E079ABCC;
        Wed, 26 Aug 2020 13:24:03 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 33FB61E12AF; Wed, 26 Aug 2020 15:23:30 +0200 (CEST)
Date:   Wed, 26 Aug 2020 15:23:30 +0200
From:   Jan Kara <jack@suse.cz>
To:     Xianting Tian <xianting_tian@126.com>
Cc:     bcrl@kvack.org, viro@zeniv.linux.org.uk, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] aio: use wait_for_completion_io() when waiting for
 completion of io
Message-ID: <20200826132330.GD15126@quack2.suse.cz>
References: <1596634551-27526-1-git-send-email-xianting_tian@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1596634551-27526-1-git-send-email-xianting_tian@126.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 05-08-20 09:35:51, Xianting Tian wrote:
> When waiting for the completion of io, we need account iowait time. As
> wait_for_completion() calls schedule_timeout(), which doesn't account
> iowait time. While wait_for_completion_io() calls io_schedule_timeout(),
> which will account iowait time.
> 
> So using wait_for_completion_io() instead of wait_for_completion()
> when waiting for completion of io before exit_aio and io_destroy.
> 
> Signed-off-by: Xianting Tian <xianting_tian@126.com>

Thanks for the patch! It looks good to me but IMO this is just scratching
the surface.  E.g. for AIO we are mostly going to wait in read_events() by
wait_event_interruptible_hrtimeout() and *that* doesn't account as IO wait
either? Which is IMO far bigger misaccounting... The two case you fix seem
to be just rare cornercases so what they do isn't a big deal either way.

So I agree it may be worth it to properly account waiting for AIO but if
you want to do that, then please handle mainly the common cases in AIO
code.

								Honza

> ---
>  fs/aio.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/aio.c b/fs/aio.c
> index 91e7cc4..498b8a0 100644
> --- a/fs/aio.c
> +++ b/fs/aio.c
> @@ -892,7 +892,7 @@ void exit_aio(struct mm_struct *mm)
>  
>  	if (!atomic_sub_and_test(skipped, &wait.count)) {
>  		/* Wait until all IO for the context are done. */
> -		wait_for_completion(&wait.comp);
> +		wait_for_completion_io(&wait.comp);
>  	}
>  
>  	RCU_INIT_POINTER(mm->ioctx_table, NULL);
> @@ -1400,7 +1400,7 @@ static long read_events(struct kioctx *ctx, long min_nr, long nr,
>  		 * is destroyed.
>  		 */
>  		if (!ret)
> -			wait_for_completion(&wait.comp);
> +			wait_for_completion_io(&wait.comp);
>  
>  		return ret;
>  	}
> -- 
> 1.8.3.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
