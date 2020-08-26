Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D544253472
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Aug 2020 18:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbgHZQL3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Aug 2020 12:11:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:49730 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726718AbgHZQL3 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Aug 2020 12:11:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AE037B6FA;
        Wed, 26 Aug 2020 16:11:58 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id D5BB01E12AF; Wed, 26 Aug 2020 18:11:26 +0200 (CEST)
Date:   Wed, 26 Aug 2020 18:11:26 +0200
From:   Jan Kara <jack@suse.cz>
To:     trix@redhat.com
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] writeback: clear auto_free in initializaiton
Message-ID: <20200826161126.GB8760@quack2.suse.cz>
References: <20200818141330.29134-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200818141330.29134-1-trix@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 18-08-20 07:13:30, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> Review fs/fs-writeback.c bdi_split_work_to_wbs
> The CONFIG_CGROUP_WRITEBACK version contains this line
> 	base_work->auto_free = 0;

It is actually the !CONFIG_CGROUP_WRITEBACK version...

> Which seems like a strange place to set auto_free as
> it is not where the rest of base_work is initialized.

Otherwise I agree it's a strange place. I've added Tejun to CC just in case
he remembers why he's added that.

> In the default version of bdi_split_work_to_wbs, if a
> successful malloc happens, base_work is copied and
> auto_free is set to 1, else the base_work is
> copied to another local valarible and its auto_free
> is set to 0.
> 
> So move the clearing of auto_free to the
> initialization of the local base_work structures.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>

Some more comments below.

> ---
>  fs/fs-writeback.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index a605c3dddabc..fa1106de2ab0 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -881,7 +881,6 @@ static void bdi_split_work_to_wbs(struct backing_dev_info *bdi,
>  		work = &fallback_work;
>  		*work = *base_work;
>  		work->nr_pages = nr_pages;
> -		work->auto_free = 0;
>  		work->done = &fallback_work_done;

Honestly, I'd leave this alone. Although base_work should have auto_free ==
0, this assignment IMO helps readability.

> @@ -1055,10 +1054,8 @@ static void bdi_split_work_to_wbs(struct backing_dev_info *bdi,
>  {
>  	might_sleep();
>  
> -	if (!skip_if_busy || !writeback_in_progress(&bdi->wb)) {
> -		base_work->auto_free = 0;
> +	if (!skip_if_busy || !writeback_in_progress(&bdi->wb))
>  		wb_queue_work(&bdi->wb, base_work);
> -	}

Agreed with this.


> @@ -2459,6 +2456,7 @@ static void __writeback_inodes_sb_nr(struct super_block *sb, unsigned long nr,
>  		.done			= &done,
>  		.nr_pages		= nr,
>  		.reason			= reason,
> +		.auto_free		= 0,
>  	};
>  
>  	if (!bdi_has_dirty_io(bdi) || bdi == &noop_backing_dev_info)
> @@ -2538,6 +2536,7 @@ void sync_inodes_sb(struct super_block *sb)
>  		.done		= &done,
>  		.reason		= WB_REASON_SYNC,
>  		.for_sync	= 1,
> +		.auto_free	= 0,
>  	};

No need for explicit initialization to 0 - that is implicit with the
initializers.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
