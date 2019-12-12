Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 931DD11D938
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2019 23:18:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731276AbfLLWS2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Dec 2019 17:18:28 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:41836 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731241AbfLLWS2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Dec 2019 17:18:28 -0500
Received: from dread.disaster.area (pa49-195-139-249.pa.nsw.optusnet.com.au [49.195.139.249])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 5D5028206E4;
        Fri, 13 Dec 2019 09:18:20 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1ifWmo-0005qT-SB; Fri, 13 Dec 2019 09:18:18 +1100
Date:   Fri, 13 Dec 2019 09:18:18 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>, Chris Mason <clm@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCHSET v3 0/5] Support for RWF_UNCACHED
Message-ID: <20191212221818.GG19213@dread.disaster.area>
References: <20191211152943.2933-1-axboe@kernel.dk>
 <CAHk-=wjz3LE1kznro1dozhk9i9Dr4pCnkj7Fuccn2xdWeGHawQ@mail.gmail.com>
 <d0adcde2-3106-4fea-c047-4d17111bab70@kernel.dk>
 <e43a2700-8625-e136-dc9d-d0d2da5d96ac@kernel.dk>
 <CAHk-=wje8i3DVcO=fMC4tzKTS5+eHv0anrVZa_JENQt08T=qCQ@mail.gmail.com>
 <0d4e3954-c467-30a7-5a8e-7c4180275533@kernel.dk>
 <CAHk-=whk4bcVPvtAv5OmHiW5z6AXgCLFhO4YrXD7o0XC+K-aHw@mail.gmail.com>
 <fef996ca-a4ed-9633-1f79-91292a984a20@kernel.dk>
 <e7fc6b37-8106-4fe2-479c-05c3f2b1c1f1@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7fc6b37-8106-4fe2-479c-05c3f2b1c1f1@kernel.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=X6os11be c=1 sm=1 tr=0
        a=KoypXv6BqLCQNZUs2nCMWg==:117 a=KoypXv6BqLCQNZUs2nCMWg==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=pxVhFHJ0LMsA:10
        a=7-415B0cAAAA:8 a=bGnxjQGj_S2iY3Ve0sMA:9 a=OKTpYkA4xyfJVJG0:21
        a=eVzGXzw0403_gMhr:21 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 11, 2019 at 06:09:14PM -0700, Jens Axboe wrote:
> On 12/11/19 4:41 PM, Jens Axboe wrote:
> > On 12/11/19 1:18 PM, Linus Torvalds wrote:
> >> On Wed, Dec 11, 2019 at 12:08 PM Jens Axboe <axboe@kernel.dk> wrote:
> >>>
> >>> $ cat /proc/meminfo | grep -i active
> >>> Active:           134136 kB
> >>> Inactive:       28683916 kB
> >>> Active(anon):      97064 kB
> >>> Inactive(anon):        4 kB
> >>> Active(file):      37072 kB
> >>> Inactive(file): 28683912 kB
> >>
> >> Yeah, that should not put pressure on some swap activity. We have 28
> >> GB of basically free inactive file data, and the VM is doing something
> >> very very bad if it then doesn't just quickly free it with no real
> >> drama.
> >>
> >> In fact, I don't think it should even trigger kswapd at all, it should
> >> all be direct reclaim. Of course, some of the mm people hate that with
> >> a passion, but this does look like a prime example of why it should
> >> just be done.
> > 
> > For giggles, I ran just a single thread on the file set. We're only
> > doing about 100K IOPS at that point, yet when the page cache fills,
> > kswapd still eats 10% cpu. That seems like a lot for something that
> > slow.
> 
> Warning, the below is from the really crazy department...
> 
> Anyway, I took a closer look at the profiles for the uncached case.
> We're spending a lot of time doing memsets (this is the xa_node init,
> from the radix tree constructor), and call_rcu for the node free later
> on. All wasted time, and something that meant we weren't as close to the
> performance of O_DIRECT as we could be.
> 
> So Chris and I started talking about this, and pondered "what would
> happen if we simply bypassed the page cache completely?". Case in point,
> see below incremental patch. We still do the page cache lookup, and use
> that page to copy from if it's there. If the page isn't there, allocate
> one and do IO to it, but DON'T add it to the page cache. With that,
> we're almost at O_DIRECT levels of performance for the 4k read case,
> without 1-2%. I think 512b would look awesome, but we're reading full
> pages, so that won't really help us much. Compared to the previous
> uncached method, this is 30% faster on this device. That's substantial.

Interesting idea, but this seems like it is just direct IO with
kernel pages and a memcpy() rather than just mapping user pages, but
has none of the advantages of direct IO in that we can run reads and
writes concurrently because it's going through the buffered IO path.

It also needs all the special DIO truncate/hole punch serialisation
mechanisms to be propagated into the buffered IO path - the
requirement for inode_dio_wait() serialisation is something I'm
trying to remove from XFS, not have to add into more paths. And it
introduces the same issues with other buffered read/mmap access to
the same file ranges as direct IO has.

> Obviously this has issues with truncate that would need to be resolved,
> and it's definitely dirtier. But the performance is very enticing...

At which point I have to ask: why are we considering repeating the
mistakes that were made with direct IO?  Yes, it might be faster
than a coherent RWF_UNCACHED IO implementation, but I don't think
making it more like O_DIRECT is worth the price.

And, ultimately, RWF_UNCACHED will never be as fast as direct IO
because it *requires* the CPU to copy the data at least once. Direct
IO is zero-copy, and so it's always going to have lower overhead
than RWF_UNCACHED, and so when CPU or memory bandwidth is the
limiting facter, O_DIRECT will always be faster.

IOWs, I think trying to make RWF_UNCACHED as fast as O_DIRECT is a
fool's game and attempting to do so is taking a step in the wrong
direction architecturally.  I'd much prefer a sane IO model for
RWF_UNCACHED that provides coherency w/ mmap and other buffered IO
than compromise these things in the chase for ultimate performance.

Speaking of IO path architecture, perhaps what we really need here
is an iomap_apply()->iomap_read_actor loop here similar to the write
side. This would allow us to bypass all the complex readahead
shenanigans that generic_file_buffered_read() has to deal with and
directly control page cache residency and build the exact IOs we
need when RWF_UNCACHED is set. This moves it much closer to the
direct IO path in terms IO setup overhead and physical IO patterns,
but still has all the benefits of being fully cache coherent....

And, really, when we are talking about high end nvme drives that can
do 5-10GB/s read each, and we can put 20+ of them in a single
machine, there's no real value in doing readahead. i.e. there's
little read IO latency to hide in the first place and we such
systems have little memory bandwidth to spare to waste on readahead
IO that we don't end up using...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
