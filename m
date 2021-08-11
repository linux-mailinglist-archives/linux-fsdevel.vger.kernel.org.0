Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15E483E91D4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Aug 2021 14:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbhHKMrj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Aug 2021 08:47:39 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:52654 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbhHKMri (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Aug 2021 08:47:38 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id ACA1A20170;
        Wed, 11 Aug 2021 12:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628686033; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nwQ4TvjjMcZX7eWrYwBnPN10bqbjG9P7T2eCYAyJQXk=;
        b=vRr9euvpwMXH0RWDfUD0ywdhH4vM2NdmgSzf1xS2x1Ed90rCAO5rygcPXkH0xi9auM1aWN
        5CaPl0CL/LM23oND21hPH1suDmy0Qplk2ZFKkV4XOw3A4+GFei+wWFEYqgwWNJukodF7Ke
        IDjzdq6WV6fUBS0BE8mFP0B+h9T/hJ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628686033;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nwQ4TvjjMcZX7eWrYwBnPN10bqbjG9P7T2eCYAyJQXk=;
        b=pgVKegl+OIMR6AYcPyFrMsuOvSOI1CrVWEt2HwgM9Qn+HEPXhkidnjAdoKFQ64w2yOrr0q
        cHhEhY1mmpn2KoDw==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 98216A3C59;
        Wed, 11 Aug 2021 12:47:13 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 680061E6204; Wed, 11 Aug 2021 14:47:13 +0200 (CEST)
Date:   Wed, 11 Aug 2021 14:47:13 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jan Kara <jack@suse.cz>, Qian Cai <quic_qiancai@quicinc.com>,
        Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        linux-block@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: move the bdi from the request_queue to the gendisk
Message-ID: <20210811124713.GF14725@quack2.suse.cz>
References: <20210809141744.1203023-1-hch@lst.de>
 <e5e19d15-7efd-31f4-941a-a5eb2f94b898@quicinc.com>
 <20210810200256.GA30809@lst.de>
 <20210811112514.GC14725@quack2.suse.cz>
 <20210811115147.GA27860@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210811115147.GA27860@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 11-08-21 13:51:47, Christoph Hellwig wrote:
> On Wed, Aug 11, 2021 at 01:25:14PM +0200, Jan Kara wrote:
> > Well, non-default bdi_writeback structures do hold bdi reference - see
> > wb_exit() which drops the reference. I think the problem rather was that a
> > block device's inode->i_wb was pointing to the default bdi_writeback
> > structure and that got freed after bdi_put() before block device inode was
> > shutdown through bdput()... So what I think we need is that if the inode
> > references the default writeback structure, it actually holds a reference
> > to the bdi.
> 
> Qian, can you test the patch below instead of the one I sent yesterday?

Sadly the patch below will not work because the bdi refcount will never
drop to 0. wb_exit() for the default writeback structure is called only
from release_bdi() (i.e., after the bdi refcount is 0). That is why I wrote
above that references to default wb from inodes would hold the ref, not the
default wb structure itself. So we would need to explicitely hack this into
__inode_attach_wb() and inode_detach_wb().

Somewhat cleaner approach might be to modify wb_get(), wb_tryget(),
wb_put() to get reference to bdi instead of doing nothing for the default
wb. And drop a lot of special-casing of the default wb from various
functions. But I guess the special cases are there to avoid the performance
overhead for the common case because getting wb ref is common. Also that's
why wbs use percpu refcount and we would need something similar for bdis.
I guess this needs more thinking and your quick workaround is OK for now.

								Honza

> 
> diff --git a/mm/backing-dev.c b/mm/backing-dev.c
> index cd06dca232c3..edfb7ce2cc93 100644
> --- a/mm/backing-dev.c
> +++ b/mm/backing-dev.c
> @@ -283,8 +283,7 @@ static int wb_init(struct bdi_writeback *wb, struct backing_dev_info *bdi,
>  
>  	memset(wb, 0, sizeof(*wb));
>  
> -	if (wb != &bdi->wb)
> -		bdi_get(bdi);
> +	bdi_get(bdi);
>  	wb->bdi = bdi;
>  	wb->last_old_flush = jiffies;
>  	INIT_LIST_HEAD(&wb->b_dirty);
> @@ -362,8 +361,7 @@ static void wb_exit(struct bdi_writeback *wb)
>  		percpu_counter_destroy(&wb->stat[i]);
>  
>  	fprop_local_destroy_percpu(&wb->completions);
> -	if (wb != &wb->bdi->wb)
> -		bdi_put(wb->bdi);
> +	bdi_put(wb->bdi);
>  }
>  
>  #ifdef CONFIG_CGROUP_WRITEBACK
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
