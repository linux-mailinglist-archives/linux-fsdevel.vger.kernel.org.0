Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4821958DEA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2019 00:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbfF0WYe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jun 2019 18:24:34 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:38727 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726445AbfF0WYe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jun 2019 18:24:34 -0400
Received: from dread.disaster.area (pa49-195-139-63.pa.nsw.optusnet.com.au [49.195.139.63])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 9603243C42B;
        Fri, 28 Jun 2019 08:24:31 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1hgcnc-0001na-29; Fri, 28 Jun 2019 08:23:24 +1000
Date:   Fri, 28 Jun 2019 08:23:24 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/12] xfs: don't preallocate a transaction for file size
 updates
Message-ID: <20190627222324.GH7777@dread.disaster.area>
References: <20190624055253.31183-1-hch@lst.de>
 <20190624055253.31183-8-hch@lst.de>
 <20190624161720.GQ5387@magnolia>
 <20190624231523.GC7777@dread.disaster.area>
 <20190625102507.GA1986@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190625102507.GA1986@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=P6RKvmIu c=1 sm=1 tr=0 cx=a_idp_d
        a=fNT+DnnR6FjB+3sUuX8HHA==:117 a=fNT+DnnR6FjB+3sUuX8HHA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=dq6fvYVFJ5YA:10
        a=7-415B0cAAAA:8 a=ae071pWMrU5jLcjm0hQA:9 a=wSn981L3eJwRu9Eu:21
        a=hda4UQlomxu2gwLn:21 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 25, 2019 at 12:25:07PM +0200, Christoph Hellwig wrote:
> On Tue, Jun 25, 2019 at 09:15:23AM +1000, Dave Chinner wrote:
> > > So, uh, how much of a hit do we take for having to allocate a
> > > transaction for a file size extension?  Particularly since we can
> > > combine those things now?
> > 
> > Unless we are out of log space, the transaction allocation and free
> > should be largely uncontended and so it's just a small amount of CPU
> > usage. i.e it's a slab allocation/free and then lockless space
> > reservation/free. If we are out of log space, then we sleep waiting
> > for space - the issue really comes down to where it is better to
> > sleep in that case....
> 
> I see the general point, but we'll still have the same issue with
> unwritten extent conversion and cow completions, and I don't remember
> seeing any issue in that regard.

These are realtively rare for small file workloads - I'm really
talking about the effect of delalloc and how we've optimised
allocation during writeback to merge small, cross-file writeback
into much larger large physical IOs. Unwritten extents nor COW are
used in these (common) cases, and if they are then the allocation
patterns prevent the cross-file IO merging in the block layer and so
we don't get the "hundred ioends for a hundred inodes from a single
a physical IO completion" thundering heard problem....

> And we'd hit exactly that case
> with random writes to preallocated or COW files, i.e. the typical image
> file workload.

I do see a noticable amount of IO completion overhead in the host
when hitting unwritten extents in VM image workloads. I'll see if I
can track the number of kworkers we're stalling in under some of
these workloads, but I think it's still largely bound by the request
queue depth of the IO stack inside the VM because there is no IO
merging in these cases.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
