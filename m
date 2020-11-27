Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D28B2C68EC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Nov 2020 16:47:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731150AbgK0PrO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Nov 2020 10:47:14 -0500
Received: from verein.lst.de ([213.95.11.211]:37960 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730324AbgK0PrN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Nov 2020 10:47:13 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id C6DB768B05; Fri, 27 Nov 2020 16:47:09 +0100 (CET)
Date:   Fri, 27 Nov 2020 16:47:09 +0100
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
Subject: Re: [PATCH 43/44] block: merge struct block_device and struct
 hd_struct
Message-ID: <20201127154709.GA8881@lst.de>
References: <20201126130422.92945-1-hch@lst.de> <20201126130422.92945-44-hch@lst.de> <20201127131901.GE27162@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201127131901.GE27162@quack2.suse.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 27, 2020 at 02:19:01PM +0100, Jan Kara wrote:
> The percpu refcount is long gone after the series refactoring...

True.

> > @@ -939,13 +910,13 @@ void blk_request_module(dev_t devt)
> >   */
> >  struct block_device *bdget_disk(struct gendisk *disk, int partno)
> >  {
> > -	struct hd_struct *part;
> >  	struct block_device *bdev = NULL;
> >  
> > -	part = disk_get_part(disk, partno);
> > -	if (part)
> > -		bdev = bdget_part(part);
> > -	disk_put_part(part);
> > +	rcu_read_lock();
> > +	bdev = __disk_get_part(disk, partno);
> > +	if (bdev)
> > +		bdgrab(bdev);
> 
> Again I think you need to accommodate for bdgrab() returning NULL here when
> we race with partition destruction...

For that we need to allow bdgrab to return NULL first, but otherwise
this seems like the right way.
