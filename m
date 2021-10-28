Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00F5243F340
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Oct 2021 01:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbhJ1XC3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Oct 2021 19:02:29 -0400
Received: from mail110.syd.optusnet.com.au ([211.29.132.97]:53038 "EHLO
        mail110.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231481AbhJ1XC2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Oct 2021 19:02:28 -0400
Received: from dread.disaster.area (pa49-180-20-157.pa.nsw.optusnet.com.au [49.180.20.157])
        by mail110.syd.optusnet.com.au (Postfix) with ESMTPS id 233FD10911C;
        Fri, 29 Oct 2021 09:59:56 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1mgENH-002C7K-TH; Fri, 29 Oct 2021 09:59:55 +1100
Date:   Fri, 29 Oct 2021 09:59:55 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jane Chu <jane.chu@oracle.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "dave.jiang@intel.com" <dave.jiang@intel.com>,
        "agk@redhat.com" <agk@redhat.com>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "vgoyal@redhat.com" <vgoyal@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>
Subject: Re: [dm-devel] [PATCH 0/6] dax poison recovery with
 RWF_RECOVERY_DATA flag
Message-ID: <20211028225955.GA449541@dread.disaster.area>
References: <20211021001059.438843-1-jane.chu@oracle.com>
 <YXFPfEGjoUaajjL4@infradead.org>
 <e89a2b17-3f03-a43e-e0b9-5d2693c3b089@oracle.com>
 <YXJN4s1HC/Y+KKg1@infradead.org>
 <2102a2e6-c543-2557-28a2-8b0bdc470855@oracle.com>
 <YXj2lwrxRxHdr4hb@infradead.org>
 <20211028002451.GB2237511@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211028002451.GB2237511@magnolia>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=617b2b6f
        a=t5ERiztT/VoIE8AqcczM6g==:117 a=t5ERiztT/VoIE8AqcczM6g==:17
        a=kj9zAlcOel0A:10 a=8gfv0ekSlNoA:10 a=7-415B0cAAAA:8
        a=k1Z2RRqN3eVEGd4K9SgA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 27, 2021 at 05:24:51PM -0700, Darrick J. Wong wrote:
> On Tue, Oct 26, 2021 at 11:49:59PM -0700, Christoph Hellwig wrote:
> > On Fri, Oct 22, 2021 at 08:52:55PM +0000, Jane Chu wrote:
> > > Thanks - I try to be honest.  As far as I can tell, the argument
> > > about the flag is a philosophical argument between two views.
> > > One view assumes design based on perfect hardware, and media error
> > > belongs to the category of brokenness. Another view sees media
> > > error as a build-in hardware component and make design to include
> > > dealing with such errors.
> > 
> > No, I don't think so.  Bit errors do happen in all media, which is
> > why devices are built to handle them.  It is just the Intel-style
> > pmem interface to handle them which is completely broken.  
> 
> Yeah, I agree, this takes me back to learning how to use DISKEDIT to
> work around a hole punched in a file (with a pen!) in the 1980s...
> 
> ...so would you happen to know if anyone's working on solving this
> problem for us by putting the memory controller in charge of dealing
> with media errors?
> 
> > > errors in mind from start.  I guess I'm trying to articulate why
> > > it is acceptable to include the RWF_DATA_RECOVERY flag to the
> > > existing RWF_ flags. - this way, pwritev2 remain fast on fast path,
> > > and its slow path (w/ error clearing) is faster than other alternative.
> > > Other alternative being 1 system call to clear the poison, and
> > > another system call to run the fast pwrite for recovery, what
> > > happens if something happened in between?
> > 
> > Well, my point is doing recovery from bit errors is by definition not
> > the fast path.  Which is why I'd rather keep it away from the pmem
> > read/write fast path, which also happens to be the (much more important)
> > non-pmem read/write path.
> 
> The trouble is, we really /do/ want to be able to (re)write the failed
> area, and we probably want to try to read whatever we can.  Those are
> reads and writes, not {pre,f}allocation activities.  This is where Dave
> and I arrived at a month ago.
> 
> Unless you'd be ok with a second IO path for recovery where we're
> allowed to be slow?  That would probably have the same user interface
> flag, just a different path into the pmem driver.

I just don't see how 4 single line branches to propage RWF_RECOVERY
down to the hardware is in any way an imposition on the fast path.
It's no different for passing RWF_HIPRI down to the hardware *in the
fast path* so that the IO runs the hardware in polling mode because
it's faster for some hardware.

IOWs, saying that we shouldn't implement RWF_RECOVERY because it
adds a handful of branches to the fast path is like saying that we
shouldn't implement RWF_HIPRI because it slows down the fast path
for non-polled IO....

Just factor the actual recovery operations out into a separate
function like:

static void noinline
pmem_media_recovery(...)
{
}

pmem_copy_from_iter()
{
	if ((unlikely)(flag & RECOVERY))
		pmem_media_recovery(...);
	return _copy_from_iter_flushcache(addr, bytes, i);
}
....

And there's basically zero overhead in the fast paths for normal
data IO operations, whilst supporting a simple, easy to use data
recovery IO operations for regions that have bad media...

> Ha, how about a int fd2 = recoveryfd(fd); call where you'd get whatever
> speshul options (retry raid mirrors!  scrape the film off the disk if
> you have to!) you want that can take forever, leaving the fast paths
> alone?

Why wouldn't we just pass RWF_RECOVERY down to a REQ_RECOVERY bio
flag and have raid devices use that to trigger scraping whatever
they can if there are errors? The io path through the VFS and
filesystem to get the scraped data out to the user *is exactly the
same*, so we're going to have to plumb this functionality into fast
paths *somewhere along the line*.

Really, I think this whole "flag propagation is too much overhead
for the fast path" argument is completely invalid - if 4 conditional
branches is too much overhead to add to the fast path, then we can't
add *anything ever again* to the IO path because it has too much
overhead and impact on the fast path.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
