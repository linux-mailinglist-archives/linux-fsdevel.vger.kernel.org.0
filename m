Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0CCF3D3168
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jul 2021 03:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233135AbhGWBMA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Jul 2021 21:12:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:58554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230318AbhGWBMA (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Jul 2021 21:12:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9D60160E9A;
        Fri, 23 Jul 2021 01:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627005154;
        bh=dubo8niTm2fAph2AV70T+l7jUyaRlEBWVCODXsuymHs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c8rOmcNFq6dVUMpNu9SxM6DzJMyst3LN3ufi73N+zsM7d12ZgHatlfR7cgZ/fy0i6
         UkMx1ZSt2deeQV/WhcR3DmQ1tFmA88bh+/5HsYEUO0L/tKgbq4e6h1vdz6cHl6Sg4Y
         UByeKuoFIh2LBpzC40H7E8cedR/pY8VLEbmWPQajXI5cJU7TbYNSb5fEfWRIAOXCu5
         4B4AtgfcgElSc+jmbP1Ru4A9jvHlT+sEvOXG1Up4bKSCww3RphljdQeES5GWl9h401
         Mi+4O0r6VI4rlaFlY/bu7iGQtLRd/rXRLsqJzof8eGgNg1u8d843jzSDIm9nAlr/Ev
         cJqgvM0mTz49Q==
Date:   Thu, 22 Jul 2021 18:52:33 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Satya Tangirala <satyaprateek2357@gmail.com>,
        Changheun Lee <nanich.lee@samsung.com>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>
Subject: Re: [PATCH 6/9] f2fs: implement iomap operations
Message-ID: <YPog4SDY3nNC78sK@sol.localdomain>
References: <20210716143919.44373-1-ebiggers@kernel.org>
 <20210716143919.44373-7-ebiggers@kernel.org>
 <YPU+3inGclUtcSpJ@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YPU+3inGclUtcSpJ@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Christoph,

On Mon, Jul 19, 2021 at 10:59:10AM +0200, Christoph Hellwig wrote:
> On Fri, Jul 16, 2021 at 09:39:16AM -0500, Eric Biggers wrote:
> > +static blk_qc_t f2fs_dio_submit_bio(struct inode *inode, struct iomap *iomap,
> > +				    struct bio *bio, loff_t file_offset)
> > +{
> > +	struct f2fs_private_dio *dio;
> > +	bool write = (bio_op(bio) == REQ_OP_WRITE);
> > +
> > +	dio = f2fs_kzalloc(F2FS_I_SB(inode),
> > +			sizeof(struct f2fs_private_dio), GFP_NOFS);
> > +	if (!dio)
> > +		goto out;
> > +
> > +	dio->inode = inode;
> > +	dio->orig_end_io = bio->bi_end_io;
> > +	dio->orig_private = bio->bi_private;
> > +	dio->write = write;
> > +
> > +	bio->bi_end_io = f2fs_dio_end_io;
> > +	bio->bi_private = dio;
> > +
> > +	inc_page_count(F2FS_I_SB(inode),
> > +			write ? F2FS_DIO_WRITE : F2FS_DIO_READ);
> > +
> > +	return submit_bio(bio);
> 
> I don't think there is any need for this mess.  The F2FS_DIO_WRITE /
> F2FS_DIO_READ counts are only used to check if there is any inflight
> I/O at all.  So instead we can increment them once before calling
> iomap_dio_rw, and decrement them in ->end_io or for a failure/noop
> exit from iomap_dio_rw.  Untested patch below.  Note that all this
> would be much simpler to review if the last three patches were folded
> into a single one.
> 

I am trying to do this, but unfortunately I don't see a way to make it work
correctly in all cases.

The main problem is that when iomap_dio_rw() returns an error (other than
-EIOCBQUEUED), there is no way to know whether ->end_io() has been called or
not.  This is because iomap_dio_rw() can fail either early, before "starting"
the I/O (in which case ->end_io() won't have been called), or later, after
"starting" the I/O (in which case ->end_io() will have been called).  Note that
this can't be worked around by checking whether the iov_iter has been advanced
or not, since a failure could occur between "starting" the I/O and the iov_iter
being advanced for the first time.

Would you be receptive to adding a ->begin_io() callback to struct iomap_dio_ops
in order to allow filesystems to maintain counters like this?

Either way, given the problem here, I think I should leave this out of the
initial conversion and just do a dumb translation of the existing f2fs logic to
start with, like I have in this patch.

- Eric
