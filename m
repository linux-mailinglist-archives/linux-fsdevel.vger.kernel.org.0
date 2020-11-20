Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F22222BA5B6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 10:17:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbgKTJPx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 04:15:53 -0500
Received: from verein.lst.de ([213.95.11.211]:42108 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727354AbgKTJPw (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 04:15:52 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8D37C67373; Fri, 20 Nov 2020 10:15:47 +0100 (CET)
Date:   Fri, 20 Nov 2020 10:15:46 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jan Kara <jack@suse.cz>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        dm-devel@redhat.com, Richard Weinberger <richard@nod.at>,
        Jan Kara <jack@suse.com>, linux-block@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 15/20] block: merge struct block_device and struct
 hd_struct
Message-ID: <20201120091546.GE21715@lst.de>
References: <20201118084800.2339180-1-hch@lst.de> <20201118084800.2339180-16-hch@lst.de> <20201119143921.GX1981@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119143921.GX1981@quack2.suse.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 19, 2020 at 03:39:21PM +0100, Jan Kara wrote:
> This patch is kind of difficult to review due to the size of mostly
> mechanical changes mixed with not completely mechanical changes. Can we
> perhaps split out the mechanical bits? E.g. the rq->part => rq->bdev
> renaming is mechanical and notable part of the patch. Similarly the
> part->foo => part->bd_foo bits...

We'd end with really weird patches that way.  Never mind that I'm not
even sure how we could mechnically do the renaming.

> 
> Also I'm kind of wondering: AFAIU the new lifetime rules, gendisk holds
> bdev reference and bdev is created on gendisk allocation so bdev lifetime is
> strictly larger than gendisk lifetime. But what now keeps bdev->bd_disk
> reference safe in presence device hot unplug? In most cases we are still
> protected by gendisk reference taken in __blkdev_get() but how about
> disk->lookup_sem and disk->flags dereferences before we actually grab the
> reference?

Good question.  I'll need to think about this a bit more.

> Also I find it rather non-obvious (although elegant ;) that bdev->bd_device
> rules the lifetime of gendisk. Can you perhaps explain this in the
> changelog and probably also add somewhere to source a documentation about
> the new lifetime rules?

Yes.

> > -struct hd_struct *__disk_get_part(struct gendisk *disk, int partno);
> > +static inline struct block_device *__bdget_disk(struct gendisk *disk,
> > +		int partno)
> > +{
> > +	struct disk_part_tbl *ptbl = rcu_dereference(disk->part_tbl);
> > +
> > +	if (unlikely(partno < 0 || partno >= ptbl->len))
> > +		return NULL;
> > +	return rcu_dereference(ptbl->part[partno]);
> > +}
> 
> I understand this is lower-level counterpart of bdget_disk() but it is
> confusing to me that this has 'bdget' in the name and returns no bdev
> reference. Can we call it like __bdev_from_disk() or something like that?

Sure.
