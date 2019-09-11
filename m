Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 771DBAF4C7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2019 06:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725616AbfIKEEc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Sep 2019 00:04:32 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:50893 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725379AbfIKEEc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Sep 2019 00:04:32 -0400
Received: from dread.disaster.area (pa49-181-255-194.pa.nsw.optusnet.com.au [49.181.255.194])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 3495B43D08B;
        Wed, 11 Sep 2019 14:04:23 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.2)
        (envelope-from <david@fromorbit.com>)
        id 1i7trg-0008Oh-8k; Wed, 11 Sep 2019 14:04:20 +1000
Date:   Wed, 11 Sep 2019 14:04:20 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Andres Freund <andres@anarazel.de>
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.de>,
        linux-fsdevel@vger.kernel.org, jack@suse.com, hch@infradead.org
Subject: Re: Odd locking pattern introduced as part of "nowait aio support"
Message-ID: <20190911040420.GB27547@dread.disaster.area>
References: <20190910223327.mnegfoggopwqqy33@alap3.anarazel.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190910223327.mnegfoggopwqqy33@alap3.anarazel.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=FNpr/6gs c=1 sm=1 tr=0
        a=YO9NNpcXwc8z/SaoS+iAiA==:117 a=YO9NNpcXwc8z/SaoS+iAiA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=J70Eh1EUuV4A:10
        a=QyXUC8HyAAAA:8 a=yPCof4ZbAAAA:8 a=7-415B0cAAAA:8 a=S1ED59oim-zMNx-OdTEA:9
        a=n_j40ht1JxuNRk4E:21 a=sufUTekE4YebKzCQ:21 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 10, 2019 at 03:33:27PM -0700, Andres Freund wrote:
> Hi,
> 
> Especially with buffered io it's fairly easy to hit contention on the
> inode lock, during writes. With something like io_uring, it's even
> easier, because it currently (but see [1]) farms out buffered writes to
> workers, which then can easily contend on the inode lock, even if only
> one process submits writes.  But I've seen it in plenty other cases too.
> 
> Looking at the code I noticed that several parts of the "nowait aio
> support" (cf 728fbc0e10b7f3) series introduced code like:
> 
> static ssize_t
> ext4_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
> {
> ...
> 	if (!inode_trylock(inode)) {
> 		if (iocb->ki_flags & IOCB_NOWAIT)
> 			return -EAGAIN;
> 		inode_lock(inode);
> 	}

The ext4 code is just buggy here - we don't support RWF_NOWAIT on
buffered writes. Buffered reads, and dio/dax reads and writes, yes,
but not buffered writes because they are almost guaranteed to block
somewhere. See xfs_file_buffered_aio_write():

	if (iocb->ki_flags & IOCB_NOWAIT)
		return -EOPNOTSUPP;

generic_write_checks() will also reject IOCB_NOWAIT on buffered
writes, so that code in ext4 is likely in the wrong place...

> 
> isn't trylocking and then locking in a blocking fashion an inefficient
> pattern? I.e. I think this should be
> 
> 	if (iocb->ki_flags & IOCB_NOWAIT) {
> 		if (!inode_trylock(inode))
> 			return -EAGAIN;
> 	}
>         else
>         	inode_lock(inode);

Yes, you are right.

History: commit 91f9943e1c7b ("fs: support RWF_NOWAIT
for buffered reads") which introduced the first locking pattern
you describe in XFS.

That was followed soon after by:

commit 942491c9e6d631c012f3c4ea8e7777b0b02edeab
Author: Christoph Hellwig <hch@lst.de>
Date:   Mon Oct 23 18:31:50 2017 -0700

    xfs: fix AIM7 regression
    
    Apparently our current rwsem code doesn't like doing the trylock, then
    lock for real scheme.  So change our read/write methods to just do the
    trylock for the RWF_NOWAIT case.  This fixes a ~25% regression in
    AIM7.
    
    Fixes: 91f9943e ("fs: support RWF_NOWAIT for buffered reads")
    Reported-by: kernel test robot <xiaolong.ye@intel.com>
    Signed-off-by: Christoph Hellwig <hch@lst.de>
    Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
    Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>

Which changed all the trylock/eagain/lock patterns to the second
form you quote. None of the other filesystems had AIM7 regressions
reported against them, so nobody changed them....

> Obviously this isn't going to improve scalability to a very significant
> degree. But not unnecessarily doing two atomic ops on a contended lock
> can't hurt scalability either. Also, the current code just seems
> confusing.
> 
> Am I missing something?

Just that the sort of performance regression testing that uncovers
this sort of thing isn't widely done, and most filesystems are
concurrency limited in some way before they hit inode lock
scalability issues. Hence filesystem concurrency foccussed
benchmarks that could uncover it (like aim7) won't because the inode
locks don't end up stressed enough to make a difference to
benchmark performance.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
