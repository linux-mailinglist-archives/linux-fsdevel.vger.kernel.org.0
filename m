Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCF882D46D8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Dec 2020 17:37:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730324AbgLIQgW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Dec 2020 11:36:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:53788 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728121AbgLIQgS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Dec 2020 11:36:18 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EB578AC9A;
        Wed,  9 Dec 2020 16:35:36 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 8BAB71E133E; Wed,  9 Dec 2020 17:35:36 +0100 (CET)
Date:   Wed, 9 Dec 2020 17:35:36 +0100
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] writeback: don't warn on an unregistered BDI in
 __mark_inode_dirty
Message-ID: <20201209163536.GA2587@quack2.suse.cz>
References: <20200928122613.434820-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200928122613.434820-1-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 28-09-20 14:26:13, Christoph Hellwig wrote:
> BDIs get unregistered during device removal, and this WARN can be
> trivially triggered by hot-removing a NVMe device while running fsx
> It is otherwise harmless as we still hold a BDI reference, and the
> writeback has been shut down already.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
> 
> I have a vague memory someone else sent this patch alredy, but couldn't
> find it in my mailing list folder.  But given that my current NVMe
> tests trigger it easily I'd rather get it fixed ASAP.

Did this patch get lost? I don't see it upstream or in Jens' tree. FWIW I
agree the warning may result in false positive so I'm OK with removing it.
So feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> 
>  fs/fs-writeback.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index e6005c78bfa93e..acfb55834af23c 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -2321,10 +2321,6 @@ void __mark_inode_dirty(struct inode *inode, int flags)
>  
>  			wb = locked_inode_to_wb_and_lock_list(inode);
>  
> -			WARN((wb->bdi->capabilities & BDI_CAP_WRITEBACK) &&
> -			     !test_bit(WB_registered, &wb->state),
> -			     "bdi-%s not registered\n", bdi_dev_name(wb->bdi));
> -
>  			inode->dirtied_when = jiffies;
>  			if (dirtytime)
>  				inode->dirtied_time_when = jiffies;
> -- 
> 2.28.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
