Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80939204754
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jun 2020 04:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731607AbgFWCf2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Jun 2020 22:35:28 -0400
Received: from mail107.syd.optusnet.com.au ([211.29.132.53]:38806 "EHLO
        mail107.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731312AbgFWCf1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Jun 2020 22:35:27 -0400
Received: from dread.disaster.area (pa49-180-124-177.pa.nsw.optusnet.com.au [49.180.124.177])
        by mail107.syd.optusnet.com.au (Postfix) with ESMTPS id 5FCEBD5A410;
        Tue, 23 Jun 2020 12:35:24 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1jnYmL-0002E0-W3; Tue, 23 Jun 2020 12:35:18 +1000
Date:   Tue, 23 Jun 2020 12:35:17 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        agruenba@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Bypass filesystems for reading cached pages
Message-ID: <20200623023517.GG2040@dread.disaster.area>
References: <20200619155036.GZ8681@bombadil.infradead.org>
 <20200622003215.GC2040@dread.disaster.area>
 <20200622191857.GB21350@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200622191857.GB21350@casper.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=W5xGqiek c=1 sm=1 tr=0
        a=k3aV/LVJup6ZGWgigO6cSA==:117 a=k3aV/LVJup6ZGWgigO6cSA==:17
        a=kj9zAlcOel0A:10 a=nTHF0DUjJn0A:10 a=7-415B0cAAAA:8
        a=I5Ld6uvlkQaMZklyL9UA:9 a=AnJBR7kdrS1bbMZr:21 a=j-efh17Vv1HrvYRV:21
        a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 22, 2020 at 08:18:57PM +0100, Matthew Wilcox wrote:
> On Mon, Jun 22, 2020 at 10:32:15AM +1000, Dave Chinner wrote:
> > On Fri, Jun 19, 2020 at 08:50:36AM -0700, Matthew Wilcox wrote:
> > > 
> > > This patch lifts the IOCB_CACHED idea expressed by Andreas to the VFS.
> > > The advantage of this patch is that we can avoid taking any filesystem
> > > lock, as long as the pages being accessed are in the cache (and we don't
> > > need to readahead any pages into the cache).  We also avoid an indirect
> > > function call in these cases.
> > 
> > What does this micro-optimisation actually gain us except for more
> > complexity in the IO path?
> > 
> > i.e. if a filesystem lock has such massive overhead that it slows
> > down the cached readahead path in production workloads, then that's
> > something the filesystem needs to address, not unconditionally
> > bypass the filesystem before the IO gets anywhere near it.
> 
> You're been talking about adding a range lock to XFS for a while now.

I don't see what that has to do with this patch.

> I remain quite sceptical that range locks are a good idea; they have not
> worked out well as a replacement for the mmap_sem, although the workload
> for the mmap_sem is quite different and they may yet show promise for
> the XFS iolock.

<shrug>

That was a really poor implementation of a range lock. It had no
concurrency to speak of, because the tracking tree required a
spinlock to be taken for every lock or unlock the range lock
performed. Hence it had an expensive critical section that could not
scale past the number of ops a single CPU could perform on that
tree. IOWs, it topped out at about 150k lock cycles a second with
2-3 concurrent AIO+DIO threads, and only went slower as the number
of concurrent IO submitters went up.

So, yeah, if you are going to talk about range locks, you need to
forget about the what was tried on the mmap_sem because nobody
actually scalability tested the lock implementation by itself and it
turned out to be total crap....

> There are production workloads that do not work well on top of a single
> file on an XFS filesystem.  For example, using an XFS file in a host as
> the backing store for a guest block device.  People tend to work around
> that kind of performance bug rather than report it.

*cough* AIO+DIO *cough*

You may not like that answer, but anyone who cares about IO
performance, especially single file IO performance, is using
AIO+DIO. Buffered IO for VM image files in production environments
tends to be the exception, not the norm, because caching is done in
the guest by the guest page cache. Double caching IO data is
generally considered a waste of resources that could otherwise be
sold to customers.

> Do you agree that the guarantees that XFS currently supplies regarding
> locked operation will be maintained if the I/O is contained within a
> single page and the mutex is not taken?

Not at first glance because block size < file size configurations
exist and hence filesystems might be punching out extents from a
sub-page range....

> ie add this check to the original
> patch:
> 
>         if (iocb->ki_pos / PAGE_SIZE !=
>             (iocb->ki_pos + iov_iter_count(iter) - 1) / PAGE_SIZE)
>                 goto uncached;
> 
> I think that gets me almost everything I want.  Small I/Os are going to
> notice the pain of the mutex more than large I/Os.

Exactly what are you trying to optimise, Willy? You haven't
explained to anyone what workload needs these micro-optimisations,
and without understanding why you want to cut the filesystems out of
the readahead path, I can't suggest alternative solutions...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
