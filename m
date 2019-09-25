Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C918BE8E5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2019 01:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728442AbfIYXZ5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Sep 2019 19:25:57 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:47290 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726203AbfIYXZ5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Sep 2019 19:25:57 -0400
Received: from dread.disaster.area (pa49-181-226-196.pa.nsw.optusnet.com.au [49.181.226.196])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 35C86363302;
        Thu, 26 Sep 2019 09:25:50 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.2)
        (envelope-from <david@fromorbit.com>)
        id 1iDGfN-0006ta-8u; Thu, 26 Sep 2019 09:25:49 +1000
Date:   Thu, 26 Sep 2019 09:25:49 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     Tejun Heo <tj@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, Michal Hocko <mhocko@suse.com>,
        Mel Gorman <mgorman@suse.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2] mm: implement write-behind policy for sequential file
 writes
Message-ID: <20190925232549.GG804@dread.disaster.area>
References: <156896493723.4334.13340481207144634918.stgit@buzz>
 <875f3b55-4fe1-e2c3-5bee-ca79e4668e72@yandex-team.ru>
 <20190923145242.GF2233839@devbig004.ftw2.facebook.com>
 <ed5d930c-88c6-c8e4-4a6c-529701caa993@yandex-team.ru>
 <20190924073940.GM6636@dread.disaster.area>
 <edafed8a-5269-1e54-fe31-7ba87393eb34@yandex-team.ru>
 <20190925071854.GC804@dread.disaster.area>
 <aeede806-db6b-3e94-3fed-60af5481e0d3@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeede806-db6b-3e94-3fed-60af5481e0d3@yandex-team.ru>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=D+Q3ErZj c=1 sm=1 tr=0
        a=dRuLqZ1tmBNts2YiI0zFQg==:117 a=dRuLqZ1tmBNts2YiI0zFQg==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=J70Eh1EUuV4A:10
        a=7-415B0cAAAA:8 a=60IASA-pC0RNppBcC7sA:9 a=Zsu9e8Xf_pQmunjS:21
        a=CjuIK1q_8ugA:10 a=igBNqPyMv6gA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 25, 2019 at 11:15:30AM +0300, Konstantin Khlebnikov wrote:
> On 25/09/2019 10.18, Dave Chinner wrote:
> > On Tue, Sep 24, 2019 at 12:00:17PM +0300, Konstantin Khlebnikov wrote:
> > > On 24/09/2019 10.39, Dave Chinner wrote:
> > > > On Mon, Sep 23, 2019 at 06:06:46PM +0300, Konstantin Khlebnikov wrote:
> > > > > On 23/09/2019 17.52, Tejun Heo wrote:
> > > > > > Hello, Konstantin.
> > > > > > 
> > > > > > On Fri, Sep 20, 2019 at 10:39:33AM +0300, Konstantin Khlebnikov wrote:
> > > > > > > With vm.dirty_write_behind 1 or 2 files are written even faster and
> > > > > > 
> > > > > > Is the faster speed reproducible?  I don't quite understand why this
> > > > > > would be.
> > > > > 
> > > > > Writing to disk simply starts earlier.
> > > > 
> > > > Stupid question: how is this any different to simply winding down
> > > > our dirty writeback and throttling thresholds like so:
> > > > 
> > > > # echo $((100 * 1000 * 1000)) > /proc/sys/vm/dirty_background_bytes
> > > > 
> > > > to start background writeback when there's 100MB of dirty pages in
> > > > memory, and then:
> > > > 
> > > > # echo $((200 * 1000 * 1000)) > /proc/sys/vm/dirty_bytes
> > > > 
> > > > So that writers are directly throttled at 200MB of dirty pages in
> > > > memory?
> > > > 
> > > > This effectively gives us global writebehind behaviour with a
> > > > 100-200MB cache write burst for initial writes.
> > > 
> > > Global limits affect all dirty pages including memory-mapped and
> > > randomly touched. Write-behind aims only into sequential streams.
> > 
> > There are  apps that do sequential writes via mmap()d files.
> > They should do writebehind too, yes?
> 
> I see no reason for that. This is different scenario.

It is?

> Mmap have no clear signal about "end of write", only page fault at
> beginning. Theoretically we could implement similar sliding window and
> start writeback on consequent page faults.

sequential IO doing pwrite() in a loop has no clear signal about
"end of write", either. It's exactly the same as doing a memset(0)
on a mmap()d region to zero the file. i.e. the write doesn't stop
until EOF is reached...

> But applications who use memory mapped files probably knows better what
> to do with this data. I prefer to leave them alone for now.

By that argument, we shouldn't have readahead for mmap() access or
even read-around for page faults. We can track read and write faults
exactly for mmap(), so if you are tracking sequential page dirtying
for writebehind we can do that jsut as easily for mmap (via
->page_mkwrite) as we can for write() IO.

> > > > ANd, really such strict writebehind behaviour is going to cause all
> > > > sorts of unintended problesm with filesystems because there will be
> > > > adverse interactions with delayed allocation. We need a substantial
> > > > amount of dirty data to be cached for writeback for fragmentation
> > > > minimisation algorithms to be able to do their job....
> > > 
> > > I think most sequentially written files never change after close.
> > 
> > There are lots of apps that write zeros to initialise and allocate
> > space, then go write real data to them. Database WAL files are
> > commonly initialised like this...
> 
> Those zeros are just bunch of dirty pages which have to be written.
> Sync and memory pressure will do that, why write-behind don't have to?

Huh? IIUC, the writebehind flag is a global behaviour flag for the
kernel - everything does writebehind or nothing does it, right?

Hence if you turn on writebehind, the writebehind will write the
zeros to disk before real data can be written. We no longer have
zeroing as something that sits in the cache until it's overwritten
with real data - that file now gets written twice and it delays the
application from actually writing real data until the zeros are all
on disk.

strict writebehind without the ability to burst temporary/short-term
data/state into the cache is going to cause a lot of performance
regressions in applications....

> > > Except of knowing final size of huge files (>16Mb in my patch)
> > > there should be no difference for delayed allocation.
> > 
> > There is, because you throttle the writes down such that there is
> > only 16MB of dirty data in memory. Hence filesystems will only
> > typically allocate in 16MB chunks as that's all the delalloc range
> > spans.
> > 
> > I'm not so concerned for XFS here, because our speculative
> > preallocation will handle this just fine, but for ext4 and btrfs
> > it's going to interleave the allocate of concurrent streaming writes
> > and fragment the crap out of the files.
> > 
> > In general, the smaller you make the individual file writeback
> > window, the worse the fragmentation problems gets....
> 
> AFAIR ext4 already preallocates extent beyond EOF too.

Only via fallocate(), not for delayed allocation.

> > > Probably write behind could provide hint about streaming pattern:
> > > pass something like "MSG_MORE" into writeback call.
> > 
> > How does that help when we've only got dirty data and block
> > reservations up to EOF which is no more than 16MB away?
> 
> Block allocator should interpret this flags as "more data are
> expected" and preallocate extent bigger than data and beyond EOF.

Can't do that: delayed allocation is a 2-phase operation that is not
seperable from the context that is dirtying the pages. The space
is _accounted as used_ during the write() context, but the _physical
allocation_ of that space is done in the writeback context. We
cannot reserve more space in the writeback context, because we may
already be at ENOSPC by the time writeback comes along. Hence
writeback must already have all the space it needs to write back the
dirty pages in memory already accounted as used space before it
starts running physical allocations.

IOWs, we cannot magically allocate more space than was reserved for
the data being written in because of some special flag from the
writeback code. That way lies angry users because we lost their
data due to ENOSPC issues in writeback.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
