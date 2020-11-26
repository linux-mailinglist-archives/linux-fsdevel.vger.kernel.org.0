Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8892C5AD9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Nov 2020 18:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404475AbgKZRmn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Nov 2020 12:42:43 -0500
Received: from verein.lst.de ([213.95.11.211]:35231 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404320AbgKZRmn (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Nov 2020 12:42:43 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 31C9868B05; Thu, 26 Nov 2020 18:42:39 +0100 (CET)
Date:   Thu, 26 Nov 2020 18:42:38 +0100
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
Subject: Re: [PATCH 24/44] block: simplify bdev/disk lookup in blkdev_get
Message-ID: <20201126174238.GA24098@lst.de>
References: <20201126130422.92945-1-hch@lst.de> <20201126130422.92945-25-hch@lst.de> <20201126163341.GL422@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201126163341.GL422@quack2.suse.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 26, 2020 at 05:33:41PM +0100, Jan Kara wrote:
> >  			bdev->bd_contains = whole;
> > -			bdev->bd_part = disk_get_part(disk, partno);
> > -			if (!(disk->flags & GENHD_FL_UP) ||
> > -			    !bdev->bd_part || !bdev->bd_part->nr_sects) {
> > +			bdev->bd_part = disk_get_part(disk, bdev->bd_partno);
> > +			if (!bdev->bd_part || !bdev->bd_part->nr_sects) {
> 
> AFAICT it is still possible that we see !(disk->flags & GENHD_FL_UP) here,
> isn't it? Is it safe to remove because the nr_sects check is already
> equivalent to it? Or something else?

At this point we already have the disk abd bdev reference, so we're not
closing any new race here.  That being said we might as well keep this
check to not bother going ahead when the disk is already torn down.

> I think bdget() above needs to be already under bdev_lookup_sem. Otherwise
> disk_to_dev(bdev->bd_disk)->kobj below is a potential use-after-free.

Yes.  I've fixed this and the other issues.
