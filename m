Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDF4324E2DE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Aug 2020 23:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgHUVyM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Aug 2020 17:54:12 -0400
Received: from mail110.syd.optusnet.com.au ([211.29.132.97]:35825 "EHLO
        mail110.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726672AbgHUVyM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Aug 2020 17:54:12 -0400
Received: from dread.disaster.area (pa49-181-146-199.pa.nsw.optusnet.com.au [49.181.146.199])
        by mail110.syd.optusnet.com.au (Postfix) with ESMTPS id DC7B6108A69;
        Sat, 22 Aug 2020 07:53:59 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1k9Ez0-0002OM-F0; Sat, 22 Aug 2020 07:53:58 +1000
Date:   Sat, 22 Aug 2020 07:53:58 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     Anju T Sudhakar <anju@linux.vnet.ibm.com>, hch@infradead.org,
        darrick.wong@oracle.com, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        willy@infradead.org
Subject: Re: [PATCH] iomap: Fix the write_count in iomap_add_to_ioend().
Message-ID: <20200821215358.GG7941@dread.disaster.area>
References: <20200819102841.481461-1-anju@linux.vnet.ibm.com>
 <20200820231140.GE7941@dread.disaster.area>
 <20200821044533.BBFD1A405F@d06av23.portsmouth.uk.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200821044533.BBFD1A405F@d06av23.portsmouth.uk.ibm.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=QKgWuTDL c=1 sm=1 tr=0 cx=a_idp_d
        a=GorAHYkI+xOargNMzM6qxQ==:117 a=GorAHYkI+xOargNMzM6qxQ==:17
        a=kj9zAlcOel0A:10 a=y4yBn9ojGxQA:10 a=VnNF1IyMAAAA:8 a=7-415B0cAAAA:8
        a=Qh6IE-2GF9-oy0DaVTgA:9 a=RXxoB3lGECdc3DDF:21 a=r0DmFvm1JCai0nq2:21
        a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 21, 2020 at 10:15:33AM +0530, Ritesh Harjani wrote:
> Hello Dave,
> 
> Thanks for reviewing this.
> 
> On 8/21/20 4:41 AM, Dave Chinner wrote:
> > On Wed, Aug 19, 2020 at 03:58:41PM +0530, Anju T Sudhakar wrote:
> > > From: Ritesh Harjani <riteshh@linux.ibm.com>
> > > 
> > > __bio_try_merge_page() may return same_page = 1 and merged = 0.
> > > This could happen when bio->bi_iter.bi_size + len > UINT_MAX.
> > 
> > Ummm, silly question, but exactly how are we getting a bio that
> > large in ->writepages getting built? Even with 64kB pages, that's a
> > bio with 2^16 pages attached to it. We shouldn't be building single
> > bios in writeback that large - what storage hardware is allowing
> > such huge bios to be built? (i.e. can you dump all the values in
> > /sys/block/<dev>/queue/* for that device for us?)
> 
> Please correct me here, but as I see, bio has only these two limits
> which it checks for adding page to bio. It doesn't check for limits
> of /sys/block/<dev>/queue/* no? I guess then it could be checked
> by block layer below b4 submitting the bio?
> 
> 113 static inline bool bio_full(struct bio *bio, unsigned len)
> 114 {
> 115         if (bio->bi_vcnt >= bio->bi_max_vecs)
> 116                 return true;
> 117
> 118         if (bio->bi_iter.bi_size > UINT_MAX - len)
> 119                 return true;
> 120
> 121         return false;
> 122 }

but iomap only allows BIO_MAX_PAGES when creating the bio. And:

#define BIO_MAX_PAGES 256

So even on a 64k page machine, we should not be building a bio with
more than 16MB of data in it. So how are we getting 4GB of data into
it?

Further, the writeback code is designed around the bios having a
bound size that is relatively small to keep IO submission occurring
as we pack pages into bios. This keeps IO latency down and minimises
the individual IO completion overhead of each IO. This is especially
important as the writeback path is critical for memory relcaim to
make progress because we do not want to trap gigabytes of dirty
memory in the writeback IO path.

IOWs, seeing huge bios being built by writeback is indicative of
design assumptions and contraints being violated - huge bios on the
buffered writeback path like this are not a good thing to see.

FWIW, We've also recently got reports of hard lockups in IO
completion of overwrites because our ioend bio chains have grown to
almost 3 million pages and all the writeback pages get processed as
a single completion. This is a similar situation to this bug report
in that the bio chains are unbound in length, and I'm betting the
cause is the same: overwrite a 10GB file in memory (with dirty
limits turned up), then run fsync so we do a single writepages call
that tries to write 10GB of dirty pages....

The only reason we don't normally see this is that background
writeback caps the number of pages written per writepages call to
1024. i.e.  it caps writeback IO sizes to a small amount so that IO
latency, writeback fairness across dirty inodes, etc can be
maintained for background writeback - no one dirty file can
monopolise the available writeback bandwidth and starve writeback
to other dirty inodes.

So combine the two, and we've got a problem that the writeback IO
sizes are not being bound to sane IO sizes. I have no problems with
building individual bios that are 4MB or even 16MB in size - that
allows the block layer to work efficiently. Problems at a system
start to occur, however, when individual bios or bio chains built
by writeback end up being orders of magnitude larger than this....

i.e. I'm not looking at this as a "bio overflow bug" - I'm
commenting on what this overflow implies from an architectural point
of view. i.e. that uncapped bio sizes and bio chain lengths in
writeback are actually a bad thing and something we've always
tried to avoid doing....

.....

> /sys/block/<dev>/queue/*
> ========================
> 
> setup:/run/perf$ cat /sys/block/loop1/queue/max_segments
> 128
> setup:/run/perf$ cat /sys/block/loop1/queue/max_segment_size
> 65536

A maximumally size bio (16MB) will get split into two bios for this
hardware based on this (8MB max size).

> setup:/run/perf$ cat /sys/block/loop1/queue/max_hw_sectors_kb
> 1280

Except this says 1280kB is the max size, so it will actually get
split into 14 bios.

So a stream of 16MB bios from writeback will be more than large
enough to keep this hardware's pipeline full....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
