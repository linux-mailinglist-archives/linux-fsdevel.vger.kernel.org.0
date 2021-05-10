Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4493D377A36
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 May 2021 04:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbhEJCqp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 9 May 2021 22:46:45 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:45182 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229987AbhEJCqo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 9 May 2021 22:46:44 -0400
Received: from dread.disaster.area (pa49-179-143-157.pa.nsw.optusnet.com.au [49.179.143.157])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id C83321042E75;
        Mon, 10 May 2021 12:45:35 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1lfvvK-00Beju-DG; Mon, 10 May 2021 12:45:34 +1000
Date:   Mon, 10 May 2021 12:45:34 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Brian Foster <bfoster@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v2 2/2] xfs: kick extra large ioends to completion
 workqueue
Message-ID: <20210510024534.GO63242@dread.disaster.area>
References: <20201002153357.56409-3-bfoster@redhat.com>
 <20201005152102.15797-1-bfoster@redhat.com>
 <20201006035537.GD49524@magnolia>
 <20201006124440.GA50358@bfoster>
 <20210506193158.GD8582@magnolia>
 <YJVJZzld5ucxnlAH@bfoster>
 <YJVRZ1Bg1gan2BrW@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJVRZ1Bg1gan2BrW@casper.infradead.org>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=F8MpiZpN c=1 sm=1 tr=0
        a=I9rzhn+0hBG9LkCzAun3+g==:117 a=I9rzhn+0hBG9LkCzAun3+g==:17
        a=kj9zAlcOel0A:10 a=5FLXtPjwQuUA:10 a=7-415B0cAAAA:8
        a=gnKQnzLbZubkhuT5HbcA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 07, 2021 at 03:40:39PM +0100, Matthew Wilcox wrote:
> On Fri, May 07, 2021 at 10:06:31AM -0400, Brian Foster wrote:
> > > <nod> So I guess I'm saying that my resistance to /this/ part of the
> > > changes is melting away.  For a 2GB+ write IO, I guess the extra overhead
> > > of poking a workqueue can be amortized over the sheer number of pages.
> > 
> > I think the main question is what is a suitable size threshold to kick
> > an ioend over to the workqueue? Looking back, I think this patch just
> > picked 256k randomly to propose the idea. ISTM there could be a
> > potentially large window from the point where I/O latency starts to
> > dominate (over the extra context switch for wq processing) and where the
> > softlockup warning thing will eventually trigger due to having too many
> > pages. I think that means we could probably use a more conservative
> > value, I'm just not sure what value should be (10MB, 100MB, 1GB?). If
> > you have a reproducer it might be interesting to experiment with that.
> 
> To my mind, there are four main types of I/Os.
> 
> 1. Small, dependent reads -- maybe reading a B-tree block so we can get
> the next pointer.  Those need latency above all.
> 
> 2. Readahead.  Tend to be large I/Os and latency is not a concern
> 
> 3. Page writeback which tend to be large and can afford the extra latency.
> 
> 4. Log writes.  These tend to be small, and I'm not sure what increasing
> their latency would do.  Probably bad.
> 
> I like 256kB as a threshold.  I think I could get behind anything from
> 128kB to 1MB.  I don't think playing with it is going to be really
> interesting because most IOs are going to be far below or far above
> that threshold.

256kB is waaaaay too small for writeback IO. Brian actually proposed
256k *pages*, not bytes. 256kB will take us back to the bad old days
where we are dependent on bio merging to get decent IO patterns down
to the hardware, and that's a bad place to be from both an IO and
CPU efficiency POV.

IOWs, the IO that is built by the filesystem needs to be large
w.r.t. the underlying hardware so that the block layer can slice and
dice it efficiently so we don't end up doing lots of small partial
stripe writes to RAID devices.

ISTR proposing - in response to Brian's patch - a limit of 16MB or
so - large enough that for most storage stacks we'll keep it's
queues full with well formed IO, but also small enough that we don't
end up with long completion latencies due to walking hundreds of
thousands of pages completing them in a tight loop...

Yup, here's the relevent chunk of that patch:

+/*
+ * Maximum ioend IO size is used to prevent ioends from becoming unbound in
+ * size. Bios can read 4GB in size is pages are contiguous, and bio chains are
+ * effectively unbound in length. Hence the only limits on the size of the bio
+ * chain is the contiguity of the extent on disk and the length of the run of
+ * sequential dirty pages in the page cache. This can be tens of GBs of physical
+ * extents and if memory is large enough, tens of millions of dirty pages.
+ * Locking them all under writeback until the final bio in the chain is
+ * submitted and completed locks all those pages for the legnth of time it takes
+ * to write those many, many GBs of data to storage.
+ *
+ * Background writeback caps any single writepages call to half the device
+ * bandwidth to ensure fairness and prevent any one dirty inode causing
+ * writeback starvation.  fsync() and other WB_SYNC_ALL writebacks have no such
+ * cap on wbc->nr_pages, and that's where the above massive bio chain lengths
+ * come from. We want large IOs to reach the storage, but we need to limit
+ * completion latencies, hence we need to control the maximum IO size we
+ * dispatch to the storage stack.
+ *
+ * We don't really have to care about the extra IO completion overhead here -
+ * iomap has contiguous IO completion merging, so if the device can sustain a
+ * very high throughput and large bios, the ioends will be merged on completion
+ * and processed in large, efficient chunks with no additional IO latency. IOWs,
+ * we really don't need the huge bio chains to be built in the first place for
+ * sequential writeback...
+ *
+ * Note that page size has an effect here - 64k pages really needs lower
+ * page count thresholds because they have the same IO capabilities. We can do
+ * larger IOs because of the lower completion overhead, so cap it at 1024
+ * pages. For everything else, use 16MB as the ioend size.
+ */
+#if (PAGE_SIZE == 65536)
+#define IOMAP_MAX_IOEND_PAGES  1024
+#else
+#define IOMAP_MAX_IOEND_PAGES  4096
+#endif
+#define IOMAP_MAX_IOEND_SIZE   (IOMAP_MAX_IOEND_PAGES * PAGE_SIZE)


Cheers,

Dave.

-- 
Dave Chinner
david@fromorbit.com
