Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9028F35FFCC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Apr 2021 04:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229467AbhDOCFu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Apr 2021 22:05:50 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:48290 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229449AbhDOCFr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Apr 2021 22:05:47 -0400
Received: from dread.disaster.area (pa49-181-239-12.pa.nsw.optusnet.com.au [49.181.239.12])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 4C0FC1043F1E;
        Thu, 15 Apr 2021 12:05:21 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1lWrNg-008UKw-J2; Thu, 15 Apr 2021 12:05:20 +1000
Date:   Thu, 15 Apr 2021 12:05:20 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        Ted Tso <tytso@mit.edu>, Christoph Hellwig <hch@infradead.org>,
        Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH 2/7] mm: Protect operations adding pages to page cache
 with i_mapping_lock
Message-ID: <20210415020520.GI63242@dread.disaster.area>
References: <20210413105205.3093-1-jack@suse.cz>
 <20210413112859.32249-2-jack@suse.cz>
 <20210414000113.GG63242@dread.disaster.area>
 <20210414222531.GZ2531743@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210414222531.GZ2531743@casper.infradead.org>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=YKPhNiOx c=1 sm=1 tr=0 cx=a_idp_f
        a=gO82wUwQTSpaJfP49aMSow==:117 a=gO82wUwQTSpaJfP49aMSow==:17
        a=kj9zAlcOel0A:10 a=3YhXtTcJ-WEA:10 a=7-415B0cAAAA:8
        a=8hQybC9s4a2M7SgXXjwA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 14, 2021 at 11:25:31PM +0100, Matthew Wilcox wrote:
> On Wed, Apr 14, 2021 at 10:01:13AM +1000, Dave Chinner wrote:
> > > +	if (iocb->ki_flags & IOCB_NOWAIT) {
> > > +		if (!down_read_trylock(&mapping->host->i_mapping_sem))
> > > +			return -EAGAIN;
> > > +	} else {
> > > +		down_read(&mapping->host->i_mapping_sem);
> > > +	}
> > 
> > We really need a lock primitive for this. The number of times this
> > exact lock pattern is being replicated all through the IO path is
> > getting out of hand.
> > 
> > static inline bool
> > down_read_try_or_lock(struct rwsem *sem, bool try)
> > {
> > 	if (try) {
> > 		if (!down_read_trylock(sem))
> > 			return false;
> > 	} else {
> > 		down_read(&mapping->host->i_mapping_sem);
> > 	}
> > 	return true;
> > }
> > 
> > and the callers become:
> > 
> > 	if (!down_read_try_or_lock(sem, (iocb->ki_flags & IOCB_NOWAIT)))
> > 		return -EAGAIN;
> 
> I think that should be written:
> 
> 	if (!iocb_read_lock(iocb, &rwsem))
> 		return -EAGAIN;
> 
> and implemented as:
> 
> static inline int iocb_read_lock(struct kiocb *iocb, struct rwsem *sem)
> {
> 	if (iocb->ki_flags & IOCB_NOWAIT)
> 		return down_read_trylock(sem) ? 0 : -EAGAIN;
> 	return down_read_killable(sem);
> }

Yup, we already have done that with xfs_ilock_iocb(), but my point
is that this "non blocking try lock or lock" pattern is slowly being
used in more places than just IOCB_NOWAIT situations.  e.g. We use
if for IOMAP_NOWAIT locking in XFS, too, and ISTR other places where
optimisitic locking is used are replicating it, too.

Hence my suggestion that is moved up into the locking primitives,
not merely have context specific wrappers added...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
