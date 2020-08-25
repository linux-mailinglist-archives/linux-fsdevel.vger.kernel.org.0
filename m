Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5AF250DC0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Aug 2020 02:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbgHYAmL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Aug 2020 20:42:11 -0400
Received: from mail106.syd.optusnet.com.au ([211.29.132.42]:59878 "EHLO
        mail106.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726090AbgHYAmL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Aug 2020 20:42:11 -0400
Received: from dread.disaster.area (pa49-181-146-199.pa.nsw.optusnet.com.au [49.181.146.199])
        by mail106.syd.optusnet.com.au (Postfix) with ESMTPS id 3BD726AFD27;
        Tue, 25 Aug 2020 10:42:04 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1kAN2J-0005pG-Kx; Tue, 25 Aug 2020 10:42:03 +1000
Date:   Tue, 25 Aug 2020 10:42:03 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Brian Foster <bfoster@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>,
        darrick.wong@oracle.com, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        willy@infradead.org
Subject: Re: [PATCH] iomap: Fix the write_count in iomap_add_to_ioend().
Message-ID: <20200825004203.GJ12131@dread.disaster.area>
References: <20200819102841.481461-1-anju@linux.vnet.ibm.com>
 <20200820231140.GE7941@dread.disaster.area>
 <20200821044533.BBFD1A405F@d06av23.portsmouth.uk.ibm.com>
 <20200821215358.GG7941@dread.disaster.area>
 <20200822131312.GA17997@infradead.org>
 <20200824142823.GA295033@bfoster>
 <20200824150417.GA12258@infradead.org>
 <20200824154841.GB295033@bfoster>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200824154841.GB295033@bfoster>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=LPwYv6e9 c=1 sm=1 tr=0 cx=a_idp_d
        a=GorAHYkI+xOargNMzM6qxQ==:117 a=GorAHYkI+xOargNMzM6qxQ==:17
        a=kj9zAlcOel0A:10 a=y4yBn9ojGxQA:10 a=7-415B0cAAAA:8
        a=6_Yu4yksRqBpIYSk360A:9 a=Cckdbgs5SKQHxyt1:21 a=uiPvv5w2ab8WhoyN:21
        a=CjuIK1q_8ugA:10 a=igBNqPyMv6gA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 24, 2020 at 11:48:41AM -0400, Brian Foster wrote:
> On Mon, Aug 24, 2020 at 04:04:17PM +0100, Christoph Hellwig wrote:
> > On Mon, Aug 24, 2020 at 10:28:23AM -0400, Brian Foster wrote:
> > > Do I understand the current code (__bio_try_merge_page() ->
> > > page_is_mergeable()) correctly in that we're checking for physical page
> > > contiguity and not necessarily requiring a new bio_vec per physical
> > > page?
> > 
> > 
> > Yes.
> > 
> 
> Ok. I also realize now that this occurs on a kernel without commit
> 07173c3ec276 ("block: enable multipage bvecs"). That is probably a
> contributing factor, but it's not clear to me whether it's feasible to
> backport whatever supporting infrastructure is required for that
> mechanism to work (I suspect not).
> 
> > > With regard to Dave's earlier point around seeing excessively sized bio
> > > chains.. If I set up a large memory box with high dirty mem ratios and
> > > do contiguous buffered overwrites over a 32GB range followed by fsync, I
> > > can see upwards of 1GB per bio and thus chains on the order of 32+ bios
> > > for the entire write. If I play games with how the buffered overwrite is
> > > submitted (i.e., in reverse) however, then I can occasionally reproduce
> > > a ~32GB chain of ~32k bios, which I think is what leads to problems in
> > > I/O completion on some systems. Granted, I don't reproduce soft lockup
> > > issues on my system with that behavior, so perhaps there's more to that
> > > particular issue.
> > > 
> > > Regardless, it seems reasonable to me to at least have a conservative
> > > limit on the length of an ioend bio chain. Would anybody object to
> > > iomap_ioend growing a chain counter and perhaps forcing into a new ioend
> > > if we chain something like more than 1k bios at once?
> > 
> > So what exactly is the problem of processing a long chain in the
> > workqueue vs multiple small chains?  Maybe we need a cond_resched()
> > here and there, but I don't see how we'd substantially change behavior.
> > 
> 
> The immediate problem is a watchdog lockup detection in bio completion:
> 
>   NMI watchdog: Watchdog detected hard LOCKUP on cpu 25
> 
> This effectively lands at the following segment of iomap_finish_ioend():
> 
> 		...
>                /* walk each page on bio, ending page IO on them */
>                 bio_for_each_segment_all(bv, bio, iter_all)
>                         iomap_finish_page_writeback(inode, bv->bv_page, error);
> 
> I suppose we could add a cond_resched(), but is that safe directly
> inside of a ->bi_end_io() handler? Another option could be to dump large
> chains into the completion workqueue, but we may still need to track the
> length to do that. Thoughts?

We have ioend completion merging that will run the compeltion once
for all the pending ioend completions on that inode. IOWs, we do not
need to build huge chains at submission time to batch up completions
efficiently. However, huge bio chains at submission time do cause
issues with writeback fairness, pinning GBs of ram as unreclaimable
for seconds because they are queued for completion while we are
still submitting the bio chain and submission is being throttled by
the block layer writeback throttle, etc. Not to mention the latency
of stable pages in a situation like this - a mmap() write fault
could stall for many seconds waiting for a huge bio chain to finish
submission and run completion processing even when the IO for the
given page we faulted on was completed before the page fault
occurred...

Hence I think we really do need to cap the length of the bio
chains here so that we start completing and ending page writeback on
large writeback ranges long before the writeback code finishes
submitting the range it was asked to write back.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
