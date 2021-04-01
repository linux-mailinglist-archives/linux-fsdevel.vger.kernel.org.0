Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF80351383
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Apr 2021 12:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234356AbhDAK2L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Apr 2021 06:28:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:46958 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234104AbhDAK1x (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Apr 2021 06:27:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1617272790; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Rnl+5Shh0MMxJGKfXqUCuHCs3WEt2AH5V5RzSicTE6w=;
        b=Uxat7/Ac/69TeZfoeQt+B8i5enUrHOYTd86fl9WRiq3G51tu/k8DLG39X86j0tYact6i1R
        1acLeCVIDbLCAgfsOkXo6tudqJI3GOGJ9HI5sc2qH/jxZTPhn/fc95E8UuloSkWGdjTmAP
        a4Zp8dex/huJWowK1hrk88sOSiXZ5BI=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 751BFAEA6;
        Thu,  1 Apr 2021 10:26:30 +0000 (UTC)
Date:   Thu, 1 Apr 2021 12:26:28 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     viro@zeniv.linux.org.uk, tj@kernel.org, axboe@fb.com,
        willy@infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] writeback: fix obtain a reference to a freeing memcg
 css
Message-ID: <YGWf1C/gIZgs0AhR@dhcp22.suse.cz>
References: <20210401093343.51299-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401093343.51299-1-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 01-04-21 17:33:43, Muchun Song wrote:
> The caller of wb_get_create() should pin the memcg, because
> wb_get_create() relies on this guarantee. The rcu read lock
> only can guarantee that the memcg css returned by css_from_id()
> cannot be released, but the reference of the memcg can be zero.
> Fix it by holding a reference to the css before calling
> wb_get_create(). This is not a problem I encountered in the
> real world. Just the result of a code review.
> 
> And it is unnecessary to use GFP_ATOMIC, so replace it with
> GFP_NOIO.

This should go into it's own patch. With more explanation why NOIO is
required.

> Fixes: 682aa8e1a6a1 ("writeback: implement unlocked_inode_to_wb transaction and use it for stat updates")
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

For the css part feel free to add
Acked-by: Michal Hocko <mhocko@suse.com>

Even if the css ref count is not really necessary it shouldn't cause any
harm and it makes the code easier to understand. At least a comment
explaining why that is not necessary would be required without it.

Thanks!

> ---
> Changelog in v2:
>  1. Replace GFP_ATOMIC with GFP_NOIO suggested by Matthew.
> 
>  fs/fs-writeback.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index e91980f49388..df7f89f8f771 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -501,16 +501,21 @@ static void inode_switch_wbs(struct inode *inode, int new_wb_id)
>  	if (atomic_read(&isw_nr_in_flight) > WB_FRN_MAX_IN_FLIGHT)
>  		return;
>  
> -	isw = kzalloc(sizeof(*isw), GFP_ATOMIC);
> +	isw = kzalloc(sizeof(*isw), GFP_NOIO);
>  	if (!isw)
>  		return;
>  
>  	/* find and pin the new wb */
>  	rcu_read_lock();
>  	memcg_css = css_from_id(new_wb_id, &memory_cgrp_subsys);
> -	if (memcg_css)
> -		isw->new_wb = wb_get_create(bdi, memcg_css, GFP_ATOMIC);
> +	if (memcg_css && !css_tryget(memcg_css))
> +		memcg_css = NULL;
>  	rcu_read_unlock();
> +	if (!memcg_css)
> +		goto out_free;
> +
> +	isw->new_wb = wb_get_create(bdi, memcg_css, GFP_NOIO);
> +	css_put(memcg_css);
>  	if (!isw->new_wb)
>  		goto out_free;
>  
> -- 
> 2.11.0

-- 
Michal Hocko
SUSE Labs
