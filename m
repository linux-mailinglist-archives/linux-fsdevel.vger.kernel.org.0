Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDB65305885
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Jan 2021 11:34:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234783AbhA0KcZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Jan 2021 05:32:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S314160AbhAZXAD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Jan 2021 18:00:03 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ACD7C061756;
        Tue, 26 Jan 2021 14:59:21 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d4so10622505plh.5;
        Tue, 26 Jan 2021 14:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eqwHYgU2iGZD+ybt4xP+dWXvyCnIIv7E02QKZG2/cJ0=;
        b=gIt3zYhf5IVme4+R3zL0WgYP/4OsnQK633hHDw7NJ13xKB+lx8A6X0VXB4Dh5wTFnq
         qhCdz0gqct/G+dbLDnJ1T8oG3eqFv+isG6ZLEt5qJQEWFU3kVsXDMjM4Vqe8K6Y28y3H
         UC3xcUYCXGaEjZPV+lwXC1takvnVJfPrt8zjhLYEBElVWOSadseRcTwPv6i0UFox4owq
         szbbrDb6hshAf5MQZGsyoymEap0uqJOD56gGachboF1WlAAGvKFL8UTdLZeFxY3/LtFx
         4wu/MmlcFS3XYu4B5oRzHUNPcsGCAQa/grhlcLCK4qswP13l7MtQlEOrV63nGpYZKZUi
         HvxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=eqwHYgU2iGZD+ybt4xP+dWXvyCnIIv7E02QKZG2/cJ0=;
        b=im/w7DVe/1fDtjbZfa4sq4Z9CFY3lWttdB0qD5Tow9oWD+8cyTK3oOQ3fza6Ug1aN8
         NsnRr4htf38t1eaYKxCwmSSXcu/EIQIxJME8wOl2fO+YJePphakfTSYokmXl9GYPRvUa
         X1Wpr/R3bI12utsm6v64o5yU7JBai/Cm70OjllvymMvCAiEEQx/16Oh4V3z7aBcnP0X8
         0JR8XhE0kUVmAanHXLl6zxl/Q9XMJ0yH+OOqJA81K6hqRcMLqGSsuE2cvjkn51ovVR7p
         4m8VdI46nkF8uzk9CDb0CXeLwIPoOnhQt6+BCYB6LjOU07f8dKej7FcxPs9ytie0MRrl
         dqVw==
X-Gm-Message-State: AOAM533flS+gKOgkv2zPKRvFvLO+55/nUNWB2WNG9V9hzKN7z5rC9Wh5
        Z6B5ot3w5GjtyaVHFu2xKEk=
X-Google-Smtp-Source: ABdhPJwx2l2p+TwwpYcdXWMcWWMRT4N62FjAhb1NKb15Pz7PMGmJk1DkwwqJ0jQbdVIum8HDeUMI6Q==
X-Received: by 2002:a17:90b:a48:: with SMTP id gw8mr2047840pjb.113.1611701960493;
        Tue, 26 Jan 2021 14:59:20 -0800 (PST)
Received: from google.com ([2620:15c:211:201:9dd5:b47b:bb84:dede])
        by smtp.gmail.com with ESMTPSA id 145sm63241pge.88.2021.01.26.14.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 14:59:19 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Tue, 26 Jan 2021 14:59:17 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Chris Goldsworthy <cgoldswo@codeaurora.org>
Cc:     viro@zeniv.linux.org.uk, Matthew Wilcox <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Laura Abbott <lauraa@codeaurora.org>
Subject: Re: [PATCH v4] fs/buffer.c: Revoke LRU when trying to drop buffers
Message-ID: <YBCexclveGV2KH1G@google.com>
References: <cover.1611642038.git.cgoldswo@codeaurora.org>
 <e8f3e042b902156467a5e978b57c14954213ec59.1611642039.git.cgoldswo@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8f3e042b902156467a5e978b57c14954213ec59.1611642039.git.cgoldswo@codeaurora.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 25, 2021 at 10:58:30PM -0800, Chris Goldsworthy wrote:
> From: Laura Abbott <lauraa@codeaurora.org>
> 
> When a buffer is added to the LRU list, a reference is taken which is
> not dropped until the buffer is evicted from the LRU list. This is the
> correct behavior, however this LRU reference will prevent the buffer
> from being dropped. This means that the buffer can't actually be dropped
> until it is selected for eviction. There's no bound on the time spent
> on the LRU list, which means that the buffer may be undroppable for
> very long periods of time. Given that migration involves dropping
> buffers, the associated page is now unmigratible for long periods of
> time as well. CMA relies on being able to migrate a specific range
> of pages, so these types of failures make CMA significantly
> less reliable, especially under high filesystem usage.
> 
> Rather than waiting for the LRU algorithm to eventually kick out
> the buffer, explicitly remove the buffer from the LRU list when trying
> to drop it. There is still the possibility that the buffer
> could be added back on the list, but that indicates the buffer is
> still in use and would probably have other 'in use' indicates to
> prevent dropping.
> 
> Note: a bug reported by "kernel test robot" lead to a switch from
> using xas_for_each() to xa_for_each().
> 
> Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
> Signed-off-by: Chris Goldsworthy <cgoldswo@codeaurora.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Reported-by: kernel test robot <oliver.sang@intel.com>

Hi Chris,

The release buffer_head in LRU is great improvement for migration
point of view.

A question: 

Can't we invalidate(e.g., invalidate_bh_lrus) bh_lru in migrate_prep or
elsewhere when migration found the failure and is about to retry?

Migration has done such a way for other per-cpu stuffs for a long time,
which would be more consistent with others and might be faster sometimes
with reducing IPI calls for page.


> ---
>  fs/buffer.c | 79 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 74 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index 96c7604..27516a0 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -48,6 +48,7 @@
>  #include <linux/sched/mm.h>
>  #include <trace/events/block.h>
>  #include <linux/fscrypt.h>
> +#include <linux/xarray.h>
>  
>  #include "internal.h"
>  
> @@ -1471,12 +1472,55 @@ static bool has_bh_in_lru(int cpu, void *dummy)
>  	return false;
>  }
>  
> +static void __evict_bhs_lru(void *arg)
> +{
> +	struct bh_lru *b = &get_cpu_var(bh_lrus);
> +	struct xarray *busy_bhs = arg;
> +	struct buffer_head *bh;
> +	unsigned long i, xarray_index;
> +
> +	xa_for_each(busy_bhs, xarray_index, bh) {
> +		for (i = 0; i < BH_LRU_SIZE; i++) {
> +			if (b->bhs[i] == bh) {
> +				brelse(b->bhs[i]);
> +				b->bhs[i] = NULL;
> +				break;
> +			}
> +		}
> +	}
> +
> +	put_cpu_var(bh_lrus);
> +}
> +
> +static bool page_has_bhs_in_lru(int cpu, void *arg)
> +{
> +	struct bh_lru *b = per_cpu_ptr(&bh_lrus, cpu);
> +	struct xarray *busy_bhs = arg;
> +	struct buffer_head *bh;
> +	unsigned long i, xarray_index;
> +
> +	xa_for_each(busy_bhs, xarray_index, bh) {
> +		for (i = 0; i < BH_LRU_SIZE; i++) {
> +			if (b->bhs[i] == bh)
> +				return true;
> +		}
> +	}
> +
> +	return false;
> +
> +}
>  void invalidate_bh_lrus(void)
>  {
>  	on_each_cpu_cond(has_bh_in_lru, invalidate_bh_lru, NULL, 1);
>  }
>  EXPORT_SYMBOL_GPL(invalidate_bh_lrus);
>  
> +static void evict_bh_lrus(struct xarray *busy_bhs)
> +{
> +	on_each_cpu_cond(page_has_bhs_in_lru, __evict_bhs_lru,
> +			 busy_bhs, 1);
> +}
> +
>  void set_bh_page(struct buffer_head *bh,
>  		struct page *page, unsigned long offset)
>  {
> @@ -3242,14 +3286,38 @@ drop_buffers(struct page *page, struct buffer_head **buffers_to_free)
>  {
>  	struct buffer_head *head = page_buffers(page);
>  	struct buffer_head *bh;
> +	struct xarray busy_bhs;
> +	int bh_count = 0;
> +	int xa_ret, ret = 0;
> +
> +	xa_init(&busy_bhs);
>  
>  	bh = head;
>  	do {
> -		if (buffer_busy(bh))
> -			goto failed;
> +		if (buffer_busy(bh)) {
> +			xa_ret = xa_err(xa_store(&busy_bhs, bh_count++,
> +						 bh, GFP_ATOMIC));
> +			if (xa_ret)
> +				goto out;
> +		}
>  		bh = bh->b_this_page;
>  	} while (bh != head);
>  
> +	if (bh_count) {
> +		/*
> +		 * Check if the busy failure was due to an outstanding
> +		 * LRU reference
> +		 */
> +		evict_bh_lrus(&busy_bhs);
> +		do {
> +			if (buffer_busy(bh))
> +				goto out;
> +
> +			bh = bh->b_this_page;
> +		} while (bh != head);
> +	}
> +
> +	ret = 1;
>  	do {
>  		struct buffer_head *next = bh->b_this_page;
>  
> @@ -3259,9 +3327,10 @@ drop_buffers(struct page *page, struct buffer_head **buffers_to_free)
>  	} while (bh != head);
>  	*buffers_to_free = head;
>  	detach_page_private(page);
> -	return 1;
> -failed:
> -	return 0;
> +out:
> +	xa_destroy(&busy_bhs);
> +
> +	return ret;
>  }
>  
>  int try_to_free_buffers(struct page *page)
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
> 
