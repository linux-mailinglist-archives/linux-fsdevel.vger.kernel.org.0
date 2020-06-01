Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA6E1EA6B6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jun 2020 17:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728105AbgFAPQT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Jun 2020 11:16:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:53238 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727118AbgFAPQT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Jun 2020 11:16:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 2AB53AC5B;
        Mon,  1 Jun 2020 15:16:19 +0000 (UTC)
Date:   Mon, 1 Jun 2020 10:16:14 -0500
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Johannes.Thumshirn@wdc.com, hch@infradead.org, dsterba@suse.cz,
        fdmanana@gmail.com
Subject: Re: [PATCH] iomap: Return zero in case of unsuccessful pagecache
 invalidation before DIO
Message-ID: <20200601151614.pxy7in4jrvuuy7nx@fiona>
References: <20200528192103.xm45qoxqmkw7i5yl@fiona>
 <20200529002319.GQ252930@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529002319.GQ252930@magnolia>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 17:23 28/05, Darrick J. Wong wrote:
> On Thu, May 28, 2020 at 02:21:03PM -0500, Goldwyn Rodrigues wrote:
> > 
> > Filesystems such as btrfs are unable to guarantee page invalidation
> > because pages could be locked as a part of the extent. Return zero
> 
> Locked for what?  filemap_write_and_wait_range should have just cleaned
> them off.
> 
> > in case a page cache invalidation is unsuccessful so filesystems can
> > fallback to buffered I/O. This is similar to
> > generic_file_direct_write().
> > 
> > This takes care of the following invalidation warning during btrfs
> > mixed buffered and direct I/O using iomap_dio_rw():
> > 
> > Page cache invalidation failure on direct I/O.  Possible data
> > corruption due to collision with buffered I/O!
> > 
> > Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > 
> > diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> > index e4addfc58107..215315be6233 100644
> > --- a/fs/iomap/direct-io.c
> > +++ b/fs/iomap/direct-io.c
> > @@ -483,9 +483,15 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
> >  	 */
> >  	ret = invalidate_inode_pages2_range(mapping,
> >  			pos >> PAGE_SHIFT, end >> PAGE_SHIFT);
> > -	if (ret)
> > -		dio_warn_stale_pagecache(iocb->ki_filp);
> > -	ret = 0;
> > +	/*
> > +	 * If a page can not be invalidated, return 0 to fall back
> > +	 * to buffered write.
> > +	 */
> > +	if (ret) {
> > +		if (ret == -EBUSY)
> > +			ret = 0;
> > +		goto out_free_dio;
> 
> XFS doesn't fall back to buffered io when directio fails, which means
> this will cause a regression there.
> 
> Granted mixing write types is bogus...
> 

I have not seen page invalidation failure errors on XFS, but what should
happen hypothetically if they do occur? Carry on with the direct I/O?
Would an error return like -ENOTBLK be better?

-- 
Goldwyn
