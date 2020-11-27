Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBBC62C68AA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Nov 2020 16:24:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729980AbgK0PYL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Nov 2020 10:24:11 -0500
Received: from verein.lst.de ([213.95.11.211]:37904 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729113AbgK0PYL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Nov 2020 10:24:11 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6661868B05; Fri, 27 Nov 2020 16:24:07 +0100 (CET)
Date:   Fri, 27 Nov 2020 16:24:07 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jan Kara <jack@suse.cz>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        dm-devel@redhat.com, Jan Kara <jack@suse.com>,
        linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 41/44] block: switch disk_part_iter_* to use a struct
 block_device
Message-ID: <20201127152407.GA7115@lst.de>
References: <20201126130422.92945-1-hch@lst.de> <20201126130422.92945-42-hch@lst.de> <20201127125341.GD27162@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201127125341.GD27162@quack2.suse.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 27, 2020 at 01:53:41PM +0100, Jan Kara wrote:
> On Thu 26-11-20 14:04:19, Christoph Hellwig wrote:
> > Switch the partition iter infrastructure to iterate over block_device
> > references instead of hd_struct ones mostly used to get at the
> > block_device.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> The patch mostly looks good. Two comments below.
> 
> > diff --git a/block/genhd.c b/block/genhd.c
> > index 28299b24173be1..b58595f2ca33b1 100644
> > --- a/block/genhd.c
> > +++ b/block/genhd.c
> > @@ -233,7 +233,7 @@ EXPORT_SYMBOL_GPL(disk_part_iter_init);
> >   * CONTEXT:
> >   * Don't care.
> >   */
> > -struct hd_struct *disk_part_iter_next(struct disk_part_iter *piter)
> > +struct block_device *disk_part_iter_next(struct disk_part_iter *piter)
> >  {
> >  	struct disk_part_tbl *ptbl;
> >  	int inc, end;
> 
> There's:
> 
>         /* put the last partition */
>         disk_put_part(piter->part);
>         piter->part = NULL;
> 
> at the beginning of disk_part_iter_next() which also needs switching to
> bdput(), doesn't it?

That is switched to call disk_part_iter_exit in patch 13.

> 
> > @@ -271,8 +271,7 @@ struct hd_struct *disk_part_iter_next(struct disk_part_iter *piter)
> >  		      piter->idx == 0))
> >  			continue;
> >  
> > -		get_device(part_to_dev(part->bd_part));
> > -		piter->part = part->bd_part;
> > +		piter->part = bdgrab(part);
> 
> bdgrab() could return NULL if we are racing with delete_partition() so I
> think we need to take care of that.

bdgrab never retuns NULL..
