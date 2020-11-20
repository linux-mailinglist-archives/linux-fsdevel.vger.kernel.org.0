Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A73FD2BA7CF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 11:54:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbgKTKxW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 05:53:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:41778 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727241AbgKTKxW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 05:53:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 015E9AED9;
        Fri, 20 Nov 2020 10:53:20 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id AC96F1E130B; Fri, 20 Nov 2020 11:53:19 +0100 (CET)
Date:   Fri, 20 Nov 2020 11:53:19 +0100
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
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
Message-ID: <20201120105319.GA15537@quack2.suse.cz>
References: <20201118084800.2339180-1-hch@lst.de>
 <20201118084800.2339180-16-hch@lst.de>
 <20201119143921.GX1981@quack2.suse.cz>
 <20201120091546.GE21715@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201120091546.GE21715@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 20-11-20 10:15:46, Christoph Hellwig wrote:
> On Thu, Nov 19, 2020 at 03:39:21PM +0100, Jan Kara wrote:
> > This patch is kind of difficult to review due to the size of mostly
> > mechanical changes mixed with not completely mechanical changes. Can we
> > perhaps split out the mechanical bits? E.g. the rq->part => rq->bdev
> > renaming is mechanical and notable part of the patch. Similarly the
> > part->foo => part->bd_foo bits...
> 
> We'd end with really weird patches that way.  Never mind that I'm not
> even sure how we could mechnically do the renaming.

Well, I believe coccinelle should be able to do the renaming automatically.

> > Also I'm kind of wondering: AFAIU the new lifetime rules, gendisk holds
> > bdev reference and bdev is created on gendisk allocation so bdev lifetime is
> > strictly larger than gendisk lifetime. But what now keeps bdev->bd_disk
> > reference safe in presence device hot unplug? In most cases we are still
> > protected by gendisk reference taken in __blkdev_get() but how about
> > disk->lookup_sem and disk->flags dereferences before we actually grab the
> > reference?
> 
> Good question.  I'll need to think about this a bit more.

My thinking was that you could use

kobject_get_unless_zero(bdev->bd_device->kobj)

and after you hold this reference, you can do everything else safely. In
this case it is really useful that device is embedded in block_dev and
not in gendisk itself...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
