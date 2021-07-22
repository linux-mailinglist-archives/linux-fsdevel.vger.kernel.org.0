Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA6A3D2F6A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jul 2021 23:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231613AbhGVVQs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Jul 2021 17:16:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:49648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231336AbhGVVQr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Jul 2021 17:16:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 321BC60EB4;
        Thu, 22 Jul 2021 21:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626991042;
        bh=5g5ShrOoIYKikipfuUXnnoiQsbYhHG2rp7X6k6EdnhI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BqaM3hbQgwUYnCx/SvpMuT9G1hXZgT5wkSbHkaOT0M3cwaZGVKd8PRjhIZCVkqUPA
         NXaZZJhSnOa3ow6tcp5EZFo4Ex3iRMV+QMoef0C4v47cUCCp5g2YYpuY7Yg068IeRd
         gF49+tGRp1zTdcycEMghjO7jHKSI8hS6nAtgXXWI6FXa+HEH56agW+QgGSjcbj0SKk
         anSc6JT4HvNuUQwXNSWErS2+bj81QUNsV6Muj8FQyPEP/m5x7F32Go+yVADzj8KWbn
         4KDt5O7OCqmLyS4uIuOATr06k/uJ1k2Y+NuLhPjASJ62xYD5f54HBJIJXwWY0aCgKp
         1h2jixLboMlIg==
Date:   Thu, 22 Jul 2021 14:57:20 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-f2fs-devel@lists.sourceforge.net, Chao Yu <chao@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Satya Tangirala <satyaprateek2357@gmail.com>,
        Changheun Lee <nanich.lee@samsung.com>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>
Subject: Re: [PATCH 6/9] f2fs: implement iomap operations
Message-ID: <YPnpwOUIRJbSNAV/@google.com>
References: <20210716143919.44373-1-ebiggers@kernel.org>
 <20210716143919.44373-7-ebiggers@kernel.org>
 <YPU+3inGclUtcSpJ@infradead.org>
 <YPnZa5dFVP7vtB9q@google.com>
 <YPnbEdVxClWwatKz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YPnbEdVxClWwatKz@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 07/22, Eric Biggers wrote:
> On Thu, Jul 22, 2021 at 01:47:39PM -0700, Jaegeuk Kim wrote:
> > On 07/19, Christoph Hellwig wrote:
> > > On Fri, Jul 16, 2021 at 09:39:16AM -0500, Eric Biggers wrote:
> > > > +static blk_qc_t f2fs_dio_submit_bio(struct inode *inode, struct iomap *iomap,
> > > > +				    struct bio *bio, loff_t file_offset)
> > > > +{
> > > > +	struct f2fs_private_dio *dio;
> > > > +	bool write = (bio_op(bio) == REQ_OP_WRITE);
> > > > +
> > > > +	dio = f2fs_kzalloc(F2FS_I_SB(inode),
> > > > +			sizeof(struct f2fs_private_dio), GFP_NOFS);
> > > > +	if (!dio)
> > > > +		goto out;
> > > > +
> > > > +	dio->inode = inode;
> > > > +	dio->orig_end_io = bio->bi_end_io;
> > > > +	dio->orig_private = bio->bi_private;
> > > > +	dio->write = write;
> > > > +
> > > > +	bio->bi_end_io = f2fs_dio_end_io;
> > > > +	bio->bi_private = dio;
> > > > +
> > > > +	inc_page_count(F2FS_I_SB(inode),
> > > > +			write ? F2FS_DIO_WRITE : F2FS_DIO_READ);
> > > > +
> > > > +	return submit_bio(bio);
> > > 
> > > I don't think there is any need for this mess.  The F2FS_DIO_WRITE /
> > > F2FS_DIO_READ counts are only used to check if there is any inflight
> > > I/O at all.  So instead we can increment them once before calling
> > > iomap_dio_rw, and decrement them in ->end_io or for a failure/noop
> > > exit from iomap_dio_rw.  Untested patch below.  Note that all this
> > > would be much simpler to review if the last three patches were folded
> > > into a single one.
> > 
> > Eric, wdyt?
> > 
> > I've merged v1 to v5, including Christoph's comment in v2.
> > 
> 
> I am planning to do this, but I got caught up by the patch
> "f2fs: fix wrong inflight page stats for directIO" that was recently added to
> f2fs.git#dev, which makes this suggestion no longer viable.  Hence my review
> comment on that patch
> (https://lkml.kernel.org/r/YPjNGoFzQojO5Amr@sol.localdomain)
> and Chao's new version of that patch
> (https://lkml.kernel.org/r/20210722131617.749204-1-chao@kernel.org),
> although the new version has some issues too as I commented.
> 
> If you could just revert "f2fs: fix wrong inflight page stats for directIO"
> for now, that would be helpful, as I don't think we want it.

Yup, I dropped it in dev branch, and wait for Chao's next patch on top of
iomap.

> 
> - Eric
