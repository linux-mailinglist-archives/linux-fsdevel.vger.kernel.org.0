Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6BE2C6A9B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Nov 2020 18:30:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731617AbgK0RaM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Nov 2020 12:30:12 -0500
Received: from mx2.suse.de ([195.135.220.15]:58830 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731337AbgK0RaL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Nov 2020 12:30:11 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5DF80ABD7;
        Fri, 27 Nov 2020 17:30:10 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 1DA451E1319; Fri, 27 Nov 2020 18:30:10 +0100 (CET)
Date:   Fri, 27 Nov 2020 18:30:10 +0100
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
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
Message-ID: <20201127173010.GB4276@quack2.suse.cz>
References: <20201126130422.92945-1-hch@lst.de>
 <20201126130422.92945-42-hch@lst.de>
 <20201127125341.GD27162@quack2.suse.cz>
 <20201127152407.GA7115@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201127152407.GA7115@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 27-11-20 16:24:07, Christoph Hellwig wrote:
> On Fri, Nov 27, 2020 at 01:53:41PM +0100, Jan Kara wrote:
> > On Thu 26-11-20 14:04:19, Christoph Hellwig wrote:
> > 
> > There's:
> > 
> >         /* put the last partition */
> >         disk_put_part(piter->part);
> >         piter->part = NULL;
> > 
> > at the beginning of disk_part_iter_next() which also needs switching to
> > bdput(), doesn't it?
> 
> That is switched to call disk_part_iter_exit in patch 13.

I see, sorry for the noise.

> > > @@ -271,8 +271,7 @@ struct hd_struct *disk_part_iter_next(struct disk_part_iter *piter)
> > >  		      piter->idx == 0))
> > >  			continue;
> > >  
> > > -		get_device(part_to_dev(part->bd_part));
> > > -		piter->part = part->bd_part;
> > > +		piter->part = bdgrab(part);
> > 
> > bdgrab() could return NULL if we are racing with delete_partition() so I
> > think we need to take care of that.
> 
> bdgrab never retuns NULL..

Ah, that's what I misunderstood. I was confusing bdgrab() with igrab().
igrab() can return NULL but bdgrab() uses ihold() and thus cannot return
NULL. But for the lifetime rules to be safe, we should be indeed using
igrab() and check for NULL return...

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
