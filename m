Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A04251F09
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2019 01:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728331AbfFXXQf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jun 2019 19:16:35 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:59024 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726486AbfFXXQf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jun 2019 19:16:35 -0400
Received: from dread.disaster.area (pa49-195-139-63.pa.nsw.optusnet.com.au [49.195.139.63])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 8564B149D6D;
        Tue, 25 Jun 2019 09:16:30 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1hfYBH-0000af-3Z; Tue, 25 Jun 2019 09:15:23 +1000
Date:   Tue, 25 Jun 2019 09:15:23 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/12] xfs: don't preallocate a transaction for file size
 updates
Message-ID: <20190624231523.GC7777@dread.disaster.area>
References: <20190624055253.31183-1-hch@lst.de>
 <20190624055253.31183-8-hch@lst.de>
 <20190624161720.GQ5387@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190624161720.GQ5387@magnolia>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=D+Q3ErZj c=1 sm=1 tr=0 cx=a_idp_d
        a=fNT+DnnR6FjB+3sUuX8HHA==:117 a=fNT+DnnR6FjB+3sUuX8HHA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=dq6fvYVFJ5YA:10
        a=7-415B0cAAAA:8 a=oLq8ofgPWqtQ5Z905GkA:9 a=6BQrOku7L8tHAI1q:21
        a=BwSqpppzWO7tify-:21 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 24, 2019 at 09:17:20AM -0700, Darrick J. Wong wrote:
> On Mon, Jun 24, 2019 at 07:52:48AM +0200, Christoph Hellwig wrote:
> > We have historically decided that we want to preallocate the xfs_trans
> > structure at writeback time so that we don't have to allocate on in
> > the I/O completion handler.  But we treat unwrittent extent and COW
> > fork conversions different already, which proves that the transaction
> > allocations in the end I/O handler are not a problem.  Removing the
> > preallocation gets rid of a lot of corner case code, and also ensures
> > we only allocate one and log a transaction when actually required,
> > as the ioend merging can reduce the number of actual i_size updates
> > significantly.
> 
> That's what I thought when I wrote the ioend merging patches, but IIRC
> Dave objected on the grounds that most file writes are trivial file
> extending writes and therefore we should leave this alone to avoid
> slowing down the ioend path even if it came at a cost of cancelling a
> lot of empty transactions.

The issue is stuff like extracting a tarball, where we might write a
hundred thousand files and they are all written in a single IO. i.e.
there is no IO completion merging at all.

> I wasn't 100% convinced it mattered but ran out of time in the
> development window and never got around to researching if it made any
> difference.

Yeah, it's not all that simple :/

In these cases, we always have to allocate a transaction for every
file being written. If we do it before we submit the IO, then all
the transactions are allocated from the single writeback context. If
we don't have log space, data writeback pauses while the tail of the
AIL is pushed, metadata writeback occurs, and then the transaction
allocation for data writeback is woken, and data writeback
submission continues. It's fairly orderly, and we don't end up
trying to write back data while we are doing bulk metadata flushing
from the AIL.

If we delay the transaction allocation to the ioend context and we
are low on log space, we end up blocking a kworker on a transaction
allocation which then has to wait for metadata writeback. The
kworker infrastructure will then issue the next ioend work, which
then blocks on transaction allocation. Delayed allocation can cause
thousands of small file IOs to be inflight at the same time due to
intra-file contiguous allocation and IO merging in the block layer,
hence we can have thousands of individual IO completions that
require transaction allocation to be completed.

> So, uh, how much of a hit do we take for having to allocate a
> transaction for a file size extension?  Particularly since we can
> combine those things now?

Unless we are out of log space, the transaction allocation and free
should be largely uncontended and so it's just a small amount of CPU
usage. i.e it's a slab allocation/free and then lockless space
reservation/free. If we are out of log space, then we sleep waiting
for space - the issue really comes down to where it is better to
sleep in that case....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
