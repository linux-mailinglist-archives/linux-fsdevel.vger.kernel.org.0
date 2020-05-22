Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 816831DDB8F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 May 2020 02:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730360AbgEVADw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 May 2020 20:03:52 -0400
Received: from mail106.syd.optusnet.com.au ([211.29.132.42]:40424 "EHLO
        mail106.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730067AbgEVADv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 May 2020 20:03:51 -0400
Received: from dread.disaster.area (pa49-195-157-175.pa.nsw.optusnet.com.au [49.195.157.175])
        by mail106.syd.optusnet.com.au (Postfix) with ESMTPS id 0E0025AC9B1;
        Fri, 22 May 2020 10:03:48 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1jbvA9-0001Da-FG; Fri, 22 May 2020 10:03:45 +1000
Date:   Fri, 22 May 2020 10:03:45 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: truncate for block size > page size
Message-ID: <20200522000345.GW2005@dread.disaster.area>
References: <20200517215407.GS16070@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200517215407.GS16070@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=QIgWuTDL c=1 sm=1 tr=0
        a=ONQRW0k9raierNYdzxQi9Q==:117 a=ONQRW0k9raierNYdzxQi9Q==:17
        a=kj9zAlcOel0A:10 a=sTwFKg_x9MkA:10 a=VwQbUJbxAAAA:8 a=7-415B0cAAAA:8
        a=w8a6lbe8zU_JvLTFUfYA:9 a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 17, 2020 at 02:54:07PM -0700, Matthew Wilcox wrote:
> I'm currently looking at the truncate path for large pages and I suspect
> you have thought about the situation with block size > page size more
> than I have.
> 
> Let's say you have a fs with 8kB blocks and a CPU with 4kB PAGE_SIZE.
> If you have a 32kB file with all its pages in the cache, and the user
> truncates it down to 10kB, should we leave three pages in the page cache
> or four?

Hmmm. I don't recall changing any of the truncate code in my
prototypes, and fsx worked just fine so having truncate cull the
page beyond EOF is just fine. One was posted here:

https://lore.kernel.org/linux-xfs/20181107063127.3902-1-david@fromorbit.com/

IMO, it doesn't matter if we don't zero entire blocks on truncate
here. the only place this zeroing matters is for mmap() when it
faults the EOF page and the range beyond EOF is exposed to
userspace. We need to ensure that part of the page is zero, but
we don't need to zero any further into the block. If the app writes
into that part of the page, then it gets zeroed at writeback time
anyway so the app data never hits the disk.

Keep in mind that we can do partial block IO for the EOF write - we
don't need to write out the entire block, just the pages that are
dirty before/over EOF. Also remember that if the page beyond EOF is
faulted even though the block is allocated, then the app will be
SIGBUS'd because mmap() cannot extend files.

The fundamental architectural principle I've been working from
is that block size > page size is entirely invisble to the page
cache. The mm and page cache just works on pages like it always has,
and the filesystem just does extra mapping via "zero-around" where
necessary to ensure stale data is not exposed in newly allocated
blocks and beyond EOF.

This "filesystem does IO mapping, mm does page cache mapping"
architecture is one of the reasons we introduced the iomap
infrastructure in the first place - stuff like filesystem block size
should not be known or assumed -anywhere- in the page cache or mm/
subsystem - the filesystem should just be instantiating pages for IO
across the range that it requires to be read or written. You can't
do this when driving IO from the page cache - the filesystem has to
map the range for the IO before the page cache is instantiated to
know what needs to be done for any given IO.

Hence if there isn't a page in the page cache over an extent in the
filesystem, the filesystem knows exactly how that page should be
instantiated for the operation being performed. Therefore it doesn't
matter if entire pages beyond EOF are truncated away without being
zeroed - a request to read or write that section of the block
be beyond EOF and so the filesystem will zero appropriately on read
or EOF extension on write at page cache instantiation time.

That's what the IOMAP_F_ZERO_AROUND functionality in the above
patchset was for - making sure page cache instantiation was done
correctly for all the different IO operations so that stale data was
never exposed to userspace. 6 billion fsx ops tends to find most
cache instantiation problems in the IO path :)

> Three pages means (if the last page of the file is dirty) we'd need to
> add in either a freshly allocated zero page or the generic zero page to
> the bio when writing back the last page.
>
> Four pages mean we'll need to teach the truncate code to use the larger
> of page size and block size when deciding the boundary to truncate the
> page cache to, and zero the last page(s) of the file if needed.

No. It's beyond EOF, so we have a clear mechanism for
zero-on-instantiation behaviour. We don't have to touch truncate at
all.

> Depending on your answer, I may have some follow-up questions about how
> we handle reading a 10kB file with an 8kB block size on a 4kB PAGE SIZE
> machine (whether we allocate 3 or 4 pages, and what we do about the
> extra known-to-be-zero bytes that will come from the device).

IOMAP_F_ZERO_AROUND handles all that.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
