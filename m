Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A23AC83B68
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2019 23:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbfHFVfD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Aug 2019 17:35:03 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:47114 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728089AbfHFVfD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Aug 2019 17:35:03 -0400
Received: from dread.disaster.area (pa49-181-167-148.pa.nsw.optusnet.com.au [49.181.167.148])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id A0FAD36124A;
        Wed,  7 Aug 2019 07:35:00 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1hv75d-0005Dj-JD; Wed, 07 Aug 2019 07:33:53 +1000
Date:   Wed, 7 Aug 2019 07:33:53 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Brian Foster <bfoster@redhat.com>
Cc:     linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 18/24] xfs: reduce kswapd blocking on inode locking.
Message-ID: <20190806213353.GJ7777@dread.disaster.area>
References: <20190801021752.4986-1-david@fromorbit.com>
 <20190801021752.4986-19-david@fromorbit.com>
 <20190806182213.GF2979@bfoster>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806182213.GF2979@bfoster>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=FNpr/6gs c=1 sm=1 tr=0 cx=a_idp_d
        a=gu9DDhuZhshYSb5Zs/lkOA==:117 a=gu9DDhuZhshYSb5Zs/lkOA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=FmdZ9Uzk2mMA:10
        a=20KFwNOVAAAA:8 a=7-415B0cAAAA:8 a=5n85yxmU3CNEWdoKYM4A:9
        a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 06, 2019 at 02:22:13PM -0400, Brian Foster wrote:
> On Thu, Aug 01, 2019 at 12:17:46PM +1000, Dave Chinner wrote:
> > From: Dave Chinner <dchinner@redhat.com>
> > 
> > When doing async node reclaiming, we grab a batch of inodes that we
> > are likely able to reclaim and ignore those that are already
> > flushing. However, when we actually go to reclaim them, the first
> > thing we do is lock the inode. If we are racing with something
> > else reclaiming the inode or flushing it because it is dirty,
> > we block on the inode lock. Hence we can still block kswapd here.
> > 
> > Further, if we flush an inode, we also cluster all the other dirty
> > inodes in that cluster into the same IO, flush locking them all.
> > However, if the workload is operating on sequential inodes (e.g.
> > created by a tarball extraction) most of these inodes will be
> > sequntial in the cache and so in the same batch
> > we've already grabbed for reclaim scanning.
> > 
> > As a result, it is common for all the inodes in the batch to be
> > dirty and it is common for the first inode flushed to also flush all
> > the inodes in the reclaim batch. In which case, they are now all
> > going to be flush locked and we do not want to block on them.
> > 
> 
> Hmm... I think I'm missing something with this description. For dirty
> inodes that are flushed in a cluster via reclaim as described, aren't we
> already blocking on all of the flush locks by virtue of the synchronous
> I/O associated with the flush of the first dirty inode in that
> particular cluster?

Currently we end up issuing IO and waiting for it, so by the time we
get to the next inode in the cluster, it's already been cleaned and
unlocked.

However, as we go to non-blocking scanning, if we hit one
flush-locked inode in a batch, it's entirely likely that the rest of
the inodes in the batch are also flush locked, and so we should
always try to skip over them in non-blocking reclaim.

This is really just a stepping stone in the logic to the way the
LRU isolation function works - it's entirely non-blocking and full
of lock order inversions, so everything has to run under try-lock
semantics. This is essentially starting that restructuring, based on
the observation that sequential inodes are flushed in batches...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
