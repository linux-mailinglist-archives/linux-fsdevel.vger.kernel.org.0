Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A71FE3D2E77
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jul 2021 22:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbhGVUOn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Jul 2021 16:14:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:54962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231320AbhGVUOI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Jul 2021 16:14:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9163160EBE;
        Thu, 22 Jul 2021 20:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626987282;
        bh=5EuMpFl6Z+3vzvXgXMhAL/OynlzEKbafSFSDnWtb5XI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YU3KgggHhObzmH7NxwmsMvZMaahYqcNSFzdij3+M12WFlbIE61BUFBb03luwzZ8IP
         e7bjCkFn/rYn2hH/aGkg4WlQkld69KIBxoQXBeavZN60Ja9HzBZ4TmRCfhro9pJKki
         szl9E3vi31VhvUr1JtY8hhNsStDVxV3Hs2AsTSbsx7W+Cd/DeYaorN87RFcS50HHqD
         hBOHBWDVN//MKdXaWq/sooa1+iR+qto7QADxf7/5CqSdgTU7yxkd7pQvCSXsfWCVYd
         ahxmkk7Q6ecLhiYskxNtm4HDt/NopKN7aOsFsHp03ZzrO3CgOEsA201qDKtQNpr1Pl
         E7VA/ky2AixWQ==
Date:   Thu, 22 Jul 2021 13:54:41 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-f2fs-devel@lists.sourceforge.net, Chao Yu <chao@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Satya Tangirala <satyaprateek2357@gmail.com>,
        Changheun Lee <nanich.lee@samsung.com>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>
Subject: Re: [PATCH 6/9] f2fs: implement iomap operations
Message-ID: <YPnbEdVxClWwatKz@gmail.com>
References: <20210716143919.44373-1-ebiggers@kernel.org>
 <20210716143919.44373-7-ebiggers@kernel.org>
 <YPU+3inGclUtcSpJ@infradead.org>
 <YPnZa5dFVP7vtB9q@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YPnZa5dFVP7vtB9q@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 22, 2021 at 01:47:39PM -0700, Jaegeuk Kim wrote:
> On 07/19, Christoph Hellwig wrote:
> > On Fri, Jul 16, 2021 at 09:39:16AM -0500, Eric Biggers wrote:
> > > +static blk_qc_t f2fs_dio_submit_bio(struct inode *inode, struct iomap *iomap,
> > > +				    struct bio *bio, loff_t file_offset)
> > > +{
> > > +	struct f2fs_private_dio *dio;
> > > +	bool write = (bio_op(bio) == REQ_OP_WRITE);
> > > +
> > > +	dio = f2fs_kzalloc(F2FS_I_SB(inode),
> > > +			sizeof(struct f2fs_private_dio), GFP_NOFS);
> > > +	if (!dio)
> > > +		goto out;
> > > +
> > > +	dio->inode = inode;
> > > +	dio->orig_end_io = bio->bi_end_io;
> > > +	dio->orig_private = bio->bi_private;
> > > +	dio->write = write;
> > > +
> > > +	bio->bi_end_io = f2fs_dio_end_io;
> > > +	bio->bi_private = dio;
> > > +
> > > +	inc_page_count(F2FS_I_SB(inode),
> > > +			write ? F2FS_DIO_WRITE : F2FS_DIO_READ);
> > > +
> > > +	return submit_bio(bio);
> > 
> > I don't think there is any need for this mess.  The F2FS_DIO_WRITE /
> > F2FS_DIO_READ counts are only used to check if there is any inflight
> > I/O at all.  So instead we can increment them once before calling
> > iomap_dio_rw, and decrement them in ->end_io or for a failure/noop
> > exit from iomap_dio_rw.  Untested patch below.  Note that all this
> > would be much simpler to review if the last three patches were folded
> > into a single one.
> 
> Eric, wdyt?
> 
> I've merged v1 to v5, including Christoph's comment in v2.
> 

I am planning to do this, but I got caught up by the patch
"f2fs: fix wrong inflight page stats for directIO" that was recently added to
f2fs.git#dev, which makes this suggestion no longer viable.  Hence my review
comment on that patch
(https://lkml.kernel.org/r/YPjNGoFzQojO5Amr@sol.localdomain)
and Chao's new version of that patch
(https://lkml.kernel.org/r/20210722131617.749204-1-chao@kernel.org),
although the new version has some issues too as I commented.

If you could just revert "f2fs: fix wrong inflight page stats for directIO"
for now, that would be helpful, as I don't think we want it.

- Eric
