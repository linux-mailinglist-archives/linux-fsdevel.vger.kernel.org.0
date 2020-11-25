Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D30A2C4533
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Nov 2020 17:29:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731647AbgKYQ3c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Nov 2020 11:29:32 -0500
Received: from verein.lst.de ([213.95.11.211]:59650 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730840AbgKYQ3c (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Nov 2020 11:29:32 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 948AB68B02; Wed, 25 Nov 2020 17:29:26 +0100 (CET)
Date:   Wed, 25 Nov 2020 17:29:26 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Tejun Heo <tj@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Josef Bacik <josef@toxicpanda.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jan Kara <jack@suse.cz>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        dm-devel@redhat.com, Richard Weinberger <richard@nod.at>,
        Jan Kara <jack@suse.com>, linux-block@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 23/45] block: remove i_bdev
Message-ID: <20201125162926.GA1024@lst.de>
References: <20201124132751.3747337-1-hch@lst.de> <20201124132751.3747337-24-hch@lst.de> <X71g4Tm+3RiRg4Gf@mtj.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X71g4Tm+3RiRg4Gf@mtj.duckdns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 24, 2020 at 02:37:05PM -0500, Tejun Heo wrote:
> On Tue, Nov 24, 2020 at 02:27:29PM +0100, Christoph Hellwig wrote:
> > Switch the block device lookup interfaces to directly work with a dev_t
> > so that struct block_device references are only acquired by the
> > blkdev_get variants (and the blk-cgroup special case).  This means that
> > we not don't need an extra reference in the inode and can generally
>      ^
>      now
> > simplify handling of struct block_device to keep the lookups contained
> > in the core block layer code.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> ...
> > @@ -1689,14 +1599,12 @@ static int blkdev_open(struct inode * inode, struct file * filp)
> >  	if ((filp->f_flags & O_ACCMODE) == 3)
> >  		filp->f_mode |= FMODE_WRITE_IOCTL;
> >  
> > -	bdev = bd_acquire(inode);
> > -	if (bdev == NULL)
> > -		return -ENOMEM;
> > -
> > +	bdev = blkdev_get_by_dev(inode->i_rdev, filp->f_mode, filp);
> > +	if (IS_ERR(bdev))
> > +		return PTR_ERR(bdev);
> >  	filp->f_mapping = bdev->bd_inode->i_mapping;
> >  	filp->f_wb_err = filemap_sample_wb_err(filp->f_mapping);
> > -
> > -	return blkdev_get(bdev, filp->f_mode, filp);
> > +	return 0;
> >  }
> 
> I was wondering whether losing the stale bdev flushing in bd_acquire() would
> cause user-visible behavior changes but can't see how it would given that
> userland has no way of holding onto a specific instance of block inode.
> Maybe it's something worth mentioning in the commit message?

With stale bdev flushing do you mean the call to bd_forget if
i_bdev exists but is unhashed?  It doesn't actually flush anything but
just detaches the old bdev from the inode so that the new one can be
attached.  That problem goes away by definition if we don't attach
the bdev to the inode.
