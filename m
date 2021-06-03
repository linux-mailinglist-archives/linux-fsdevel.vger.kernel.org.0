Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B787399D45
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jun 2021 10:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbhFCI7d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Jun 2021 04:59:33 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:45774 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbhFCI7d (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Jun 2021 04:59:33 -0400
Received: from relay2.suse.de (unknown [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 31AC0219C5;
        Thu,  3 Jun 2021 08:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1622710668; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9sDgb2emqxYptX4dZY9/zDI4UOgLdVYYIQHPfS6+CF8=;
        b=KmJzr1J1myTp5jdxv36oVqaDps4jrGcdLt7HVHm6Rojl8scqhDwIgAwqGBhQu7GLL63uTs
        wNIpR08sqqmJC0ZURSzsPZzjgY8788AO3BwYKh2qk8Suzd5UW7DzC4HoH7CDilTQkaeTSf
        1qQ6+0Xb4Rpf63S9QkgWd2VD1oM6+/g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1622710668;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9sDgb2emqxYptX4dZY9/zDI4UOgLdVYYIQHPfS6+CF8=;
        b=R9Tg+TsvkEsLSruud73rOCf4IqRCfMpQzTyhB11G/1qRomiz9EbadycD7gnCmGaI1Sx9xQ
        nC8g688z9lHro6Bg==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 1BDDFA3B85;
        Thu,  3 Jun 2021 08:57:48 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id DF8151F2C98; Thu,  3 Jun 2021 10:57:47 +0200 (CEST)
Date:   Thu, 3 Jun 2021 10:57:47 +0200
From:   Jan Kara <jack@suse.cz>
To:     Roman Gushchin <guro@fb.com>
Cc:     Jan Kara <jack@suse.cz>, Tejun Heo <tj@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        Dennis Zhou <dennis@kernel.org>,
        Dave Chinner <dchinner@redhat.com>, cgroups@vger.kernel.org
Subject: Re: [PATCH v6 3/5] writeback, cgroup: split out the functional part
 of inode_switch_wbs_work_fn()
Message-ID: <20210603085747.GF23647@quack2.suse.cz>
References: <20210603005517.1403689-1-guro@fb.com>
 <20210603005517.1403689-4-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210603005517.1403689-4-guro@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 02-06-21 17:55:15, Roman Gushchin wrote:
> Split out the functional part of the inode_switch_wbs_work_fn()
> function as inode_do switch_wbs() to reuse it later for switching
                      ^ underscore here

> inodes attached to dying cgwbs.
> 
> This commit doesn't bring any functional changes.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>

The patch looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/fs-writeback.c | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index 09d2770449ef..212494d89cc2 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -351,15 +351,12 @@ static void bdi_up_write_wb_switch_rwsem(struct backing_dev_info *bdi)
>  	up_write(&bdi->wb_switch_rwsem);
>  }
>  
> -static void inode_switch_wbs_work_fn(struct work_struct *work)
> +static void inode_do_switch_wbs(struct inode *inode,
> +				struct bdi_writeback *new_wb)
>  {
> -	struct inode_switch_wbs_context *isw =
> -		container_of(to_rcu_work(work), struct inode_switch_wbs_context, work);
> -	struct inode *inode = isw->inode;
>  	struct backing_dev_info *bdi = inode_to_bdi(inode);
>  	struct address_space *mapping = inode->i_mapping;
>  	struct bdi_writeback *old_wb = inode->i_wb;
> -	struct bdi_writeback *new_wb = isw->new_wb;
>  	XA_STATE(xas, &mapping->i_pages, 0);
>  	struct page *page;
>  	bool switched = false;
> @@ -470,11 +467,17 @@ static void inode_switch_wbs_work_fn(struct work_struct *work)
>  		wb_wakeup(new_wb);
>  		wb_put(old_wb);
>  	}
> -	wb_put(new_wb);
> +}
>  
> -	iput(inode);
> -	kfree(isw);
> +static void inode_switch_wbs_work_fn(struct work_struct *work)
> +{
> +	struct inode_switch_wbs_context *isw =
> +		container_of(to_rcu_work(work), struct inode_switch_wbs_context, work);
>  
> +	inode_do_switch_wbs(isw->inode, isw->new_wb);
> +	wb_put(isw->new_wb);
> +	iput(isw->inode);
> +	kfree(isw);
>  	atomic_dec(&isw_nr_in_flight);
>  }
>  
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
