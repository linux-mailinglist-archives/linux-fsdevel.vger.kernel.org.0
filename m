Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21FF821A56D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jul 2020 19:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbgGIRF0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jul 2020 13:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726615AbgGIRF0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jul 2020 13:05:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4720C08C5CE;
        Thu,  9 Jul 2020 10:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CVtfSH+gkBsZofUGNP3aTGi8ImSioPFLHYxheQrY6sE=; b=mAzsvVEaYhSmpblmtnpOplNcmp
        0554KCoT84YUbdz4a9H4xhNSCyf4Lku7n2wpiHpy7APqevx5EOIvmUiB2VvaPfxKLMOtVDVMmy9YI
        VOwqnGNtzzR8hQtkXqPX8YoapG4bO5CS8moLYOdBPgxD/ZDotdo3iUUdRtAvgZBlgzCDqOxRZJ+PD
        SSwTRIphneDlH1a2Mz6XEP8bsVVpWBb0V3cufFyAKNLIc/zpVjsOQkOyrekn6uhpRsmvVqOPXAaS9
        PpiEieKVZmH6WaCr+uAm01n8KF/uauyzNkl6dHFKOabZGmHlAA4bb0B/mtCMLj6m9J91s5nyyFtby
        vRxtMBPA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jtZz5-0001Vv-5h; Thu, 09 Jul 2020 17:05:19 +0000
Date:   Thu, 9 Jul 2020 18:05:19 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>,
        Goldwyn Rodrigues <rgoldwyn@suse.de>,
        linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        fdmanana@gmail.com, dsterba@suse.cz, cluster-devel@redhat.com,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: always fall back to buffered I/O after invalidation failures,
 was: Re: [PATCH 2/6] iomap: IOMAP_DIO_RWF_NO_STALE_PAGECACHE return if page
 invalidation fails
Message-ID: <20200709170519.GH12769@casper.infradead.org>
References: <20200629192353.20841-1-rgoldwyn@suse.de>
 <20200629192353.20841-3-rgoldwyn@suse.de>
 <20200701075310.GB29884@lst.de>
 <20200707124346.xnr5gtcysuzehejq@fiona>
 <20200707125705.GK25523@casper.infradead.org>
 <20200707130030.GA13870@lst.de>
 <20200708065127.GM2005@dread.disaster.area>
 <20200708135437.GP25523@casper.infradead.org>
 <20200709022527.GQ2005@dread.disaster.area>
 <20200709160926.GO7606@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200709160926.GO7606@magnolia>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 09, 2020 at 09:09:26AM -0700, Darrick J. Wong wrote:
> On Thu, Jul 09, 2020 at 12:25:27PM +1000, Dave Chinner wrote:
> > iomap: Only invalidate page cache pages on direct IO writes
> > 
> > From: Dave Chinner <dchinner@redhat.com>
> > 
> > The historic requirement for XFS to invalidate cached pages on
> > direct IO reads has been lost in the twisty pages of history - it was
> > inherited from Irix, which implemented page cache invalidation on
> > read as a method of working around problems synchronising page
> > cache state with uncached IO.
> 
> Urk.
> 
> > XFS has carried this ever since. In the initial linux ports it was
> > necessary to get mmap and DIO to play "ok" together and not
> > immediately corrupt data. This was the state of play until the linux
> > kernel had infrastructure to track unwritten extents and synchronise
> > page faults with allocations and unwritten extent conversions
> > (->page_mkwrite infrastructure). IOws, the page cache invalidation
> > on DIO read was necessary to prevent trivial data corruptions. This
> > didn't solve all the problems, though.
> > 
> > There were peformance problems if we didn't invalidate the entire
> > page cache over the file on read - we couldn't easily determine if
> > the cached pages were over the range of the IO, and invalidation
> > required taking a serialising lock (i_mutex) on the inode. This
> > serialising lock was an issue for XFS, as it was the only exclusive
> > lock in the direct Io read path.
> > 
> > Hence if there were any cached pages, we'd just invalidate the
> > entire file in one go so that subsequent IOs didn't need to take the
> > serialising lock. This was a problem that prevented ranged
> > invalidation from being particularly useful for avoiding the
> > remaining coherency issues. This was solved with the conversion of
> > i_mutex to i_rwsem and the conversion of the XFS inode IO lock to
> > use i_rwsem. Hence we could now just do ranged invalidation and the
> > performance problem went away.
> > 
> > However, page cache invalidation was still needed to serialise
> > sub-page/sub-block zeroing via direct IO against buffered IO because
> > bufferhead state attached to the cached page could get out of whack
> > when direct IOs were issued.  We've removed bufferheads from the
> > XFS code, and we don't carry any extent state on the cached pages
> > anymore, and so this problem has gone away, too.
> > 
> > IOWs, it would appear that we don't have any good reason to be
> > invalidating the page cache on DIO reads anymore. Hence remove the
> > invalidation on read because it is unnecessary overhead,
> > not needed to maintain coherency between mmap/buffered access and
> > direct IO anymore, and prevents anyone from using direct IO reads
> > from intentionally invalidating the page cache of a file.
> > 
> > Signed-off-by: Dave Chinner <dchinner@redhat.com>
> > ---
> >  fs/iomap/direct-io.c | 33 +++++++++++++++++----------------
> >  1 file changed, 17 insertions(+), 16 deletions(-)
> > 
> > diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> > index ec7b78e6feca..ef0059eb34b5 100644
> > --- a/fs/iomap/direct-io.c
> > +++ b/fs/iomap/direct-io.c
> > @@ -475,23 +475,24 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
> >  	if (ret)
> >  		goto out_free_dio;
> >  
> > -	/*
> > -	 * Try to invalidate cache pages for the range we're direct
> > -	 * writing.  If this invalidation fails, tough, the write will
> > -	 * still work, but racing two incompatible write paths is a
> > -	 * pretty crazy thing to do, so we don't support it 100%.
> 
> I always wondered about the repeated use of 'write' in this comment
> despite the lack of any sort of WRITE check logic.  Seems fine to me,
> let's throw it on the fstests pile and see what happens.
> 
> Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

> --D
> 
> > -	 */
> > -	ret = invalidate_inode_pages2_range(mapping,
> > -			pos >> PAGE_SHIFT, end >> PAGE_SHIFT);
> > -	if (ret)
> > -		dio_warn_stale_pagecache(iocb->ki_filp);
> > -	ret = 0;
> > +	if (iov_iter_rw(iter) == WRITE) {
> > +		/*
> > +		 * Try to invalidate cache pages for the range we're direct
> > +		 * writing.  If this invalidation fails, tough, the write will
> > +		 * still work, but racing two incompatible write paths is a
> > +		 * pretty crazy thing to do, so we don't support it 100%.
> > +		 */
> > +		ret = invalidate_inode_pages2_range(mapping,
> > +				pos >> PAGE_SHIFT, end >> PAGE_SHIFT);
> > +		if (ret)
> > +			dio_warn_stale_pagecache(iocb->ki_filp);
> > +		ret = 0;
> >  
> > -	if (iov_iter_rw(iter) == WRITE && !wait_for_completion &&
> > -	    !inode->i_sb->s_dio_done_wq) {
> > -		ret = sb_init_dio_done_wq(inode->i_sb);
> > -		if (ret < 0)
> > -			goto out_free_dio;
> > +		if (!wait_for_completion &&
> > +		    !inode->i_sb->s_dio_done_wq) {
> > +			ret = sb_init_dio_done_wq(inode->i_sb);
> > +			if (ret < 0)
> > +				goto out_free_dio;
> >  	}
> >  
> >  	inode_dio_begin(inode);
