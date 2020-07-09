Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E876E21AB15
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jul 2020 00:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbgGIW7p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jul 2020 18:59:45 -0400
Received: from mail109.syd.optusnet.com.au ([211.29.132.80]:34184 "EHLO
        mail109.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726228AbgGIW7o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jul 2020 18:59:44 -0400
Received: from dread.disaster.area (pa49-180-53-24.pa.nsw.optusnet.com.au [49.180.53.24])
        by mail109.syd.optusnet.com.au (Postfix) with ESMTPS id 484E0D7A54F;
        Fri, 10 Jul 2020 08:59:37 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1jtfVw-00018A-GA; Fri, 10 Jul 2020 08:59:36 +1000
Date:   Fri, 10 Jul 2020 08:59:36 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        Goldwyn Rodrigues <rgoldwyn@suse.de>,
        linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        fdmanana@gmail.com, dsterba@suse.cz, cluster-devel@redhat.com,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: always fall back to buffered I/O after invalidation failures,
 was: Re: [PATCH 2/6] iomap: IOMAP_DIO_RWF_NO_STALE_PAGECACHE return if page
 invalidation fails
Message-ID: <20200709225936.GZ2005@dread.disaster.area>
References: <20200701075310.GB29884@lst.de>
 <20200707124346.xnr5gtcysuzehejq@fiona>
 <20200707125705.GK25523@casper.infradead.org>
 <20200707130030.GA13870@lst.de>
 <20200708065127.GM2005@dread.disaster.area>
 <20200708135437.GP25523@casper.infradead.org>
 <20200709022527.GQ2005@dread.disaster.area>
 <20200709160926.GO7606@magnolia>
 <20200709170519.GH12769@casper.infradead.org>
 <20200709171038.GE7625@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200709171038.GE7625@magnolia>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=X6os11be c=1 sm=1 tr=0
        a=moVtWZxmCkf3aAMJKIb/8g==:117 a=moVtWZxmCkf3aAMJKIb/8g==:17
        a=kj9zAlcOel0A:10 a=_RQrkK6FrEwA:10 a=7-415B0cAAAA:8
        a=CAmLY35Qp_Y7Zt_JOjoA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 09, 2020 at 10:10:38AM -0700, Darrick J. Wong wrote:
> On Thu, Jul 09, 2020 at 06:05:19PM +0100, Matthew Wilcox wrote:
> > On Thu, Jul 09, 2020 at 09:09:26AM -0700, Darrick J. Wong wrote:
> > > On Thu, Jul 09, 2020 at 12:25:27PM +1000, Dave Chinner wrote:
> > > > -	 */
> > > > -	ret = invalidate_inode_pages2_range(mapping,
> > > > -			pos >> PAGE_SHIFT, end >> PAGE_SHIFT);
> > > > -	if (ret)
> > > > -		dio_warn_stale_pagecache(iocb->ki_filp);
> > > > -	ret = 0;
> > > > +	if (iov_iter_rw(iter) == WRITE) {
> > > > +		/*
> > > > +		 * Try to invalidate cache pages for the range we're direct
> > > > +		 * writing.  If this invalidation fails, tough, the write will
> > > > +		 * still work, but racing two incompatible write paths is a
> > > > +		 * pretty crazy thing to do, so we don't support it 100%.
> > > > +		 */
> > > > +		ret = invalidate_inode_pages2_range(mapping,
> > > > +				pos >> PAGE_SHIFT, end >> PAGE_SHIFT);
> > > > +		if (ret)
> > > > +			dio_warn_stale_pagecache(iocb->ki_filp);
> > > > +		ret = 0;
> > > >  
> > > > -	if (iov_iter_rw(iter) == WRITE && !wait_for_completion &&
> > > > -	    !inode->i_sb->s_dio_done_wq) {
> > > > -		ret = sb_init_dio_done_wq(inode->i_sb);
> > > > -		if (ret < 0)
> > > > -			goto out_free_dio;
> > > > +		if (!wait_for_completion &&
> > > > +		    !inode->i_sb->s_dio_done_wq) {
> > > > +			ret = sb_init_dio_done_wq(inode->i_sb);
> > > > +			if (ret < 0)
> > > > +				goto out_free_dio;
> 
> ...and yes I did add in the closing brace here. :P

Doh! I forgot to refresh the patch after fixing that. :/

Thanks!

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
