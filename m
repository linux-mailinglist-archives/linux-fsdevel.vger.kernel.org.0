Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5043217FEC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jul 2020 08:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729991AbgGHGvg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jul 2020 02:51:36 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:55758 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729971AbgGHGvf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jul 2020 02:51:35 -0400
Received: from dread.disaster.area (pa49-180-53-24.pa.nsw.optusnet.com.au [49.180.53.24])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 408423A4417;
        Wed,  8 Jul 2020 16:51:29 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1jt3vT-0003aV-Rn; Wed, 08 Jul 2020 16:51:27 +1000
Date:   Wed, 8 Jul 2020 16:51:27 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Goldwyn Rodrigues <rgoldwyn@suse.de>,
        linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        fdmanana@gmail.com, dsterba@suse.cz, darrick.wong@oracle.com,
        cluster-devel@redhat.com, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: always fall back to buffered I/O after invalidation failures,
 was: Re: [PATCH 2/6] iomap: IOMAP_DIO_RWF_NO_STALE_PAGECACHE return if page
 invalidation fails
Message-ID: <20200708065127.GM2005@dread.disaster.area>
References: <20200629192353.20841-1-rgoldwyn@suse.de>
 <20200629192353.20841-3-rgoldwyn@suse.de>
 <20200701075310.GB29884@lst.de>
 <20200707124346.xnr5gtcysuzehejq@fiona>
 <20200707125705.GK25523@casper.infradead.org>
 <20200707130030.GA13870@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200707130030.GA13870@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=QIgWuTDL c=1 sm=1 tr=0
        a=moVtWZxmCkf3aAMJKIb/8g==:117 a=moVtWZxmCkf3aAMJKIb/8g==:17
        a=kj9zAlcOel0A:10 a=_RQrkK6FrEwA:10 a=iox4zFpeAAAA:8 a=yPCof4ZbAAAA:8
        a=7-415B0cAAAA:8 a=3vpnGOzTaiQfhgfqfmAA:9 a=CjuIK1q_8ugA:10
        a=WzC6qhA0u3u7Ye7llzcV:22 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 07, 2020 at 03:00:30PM +0200, Christoph Hellwig wrote:
> On Tue, Jul 07, 2020 at 01:57:05PM +0100, Matthew Wilcox wrote:
> > On Tue, Jul 07, 2020 at 07:43:46AM -0500, Goldwyn Rodrigues wrote:
> > > On  9:53 01/07, Christoph Hellwig wrote:
> > > > On Mon, Jun 29, 2020 at 02:23:49PM -0500, Goldwyn Rodrigues wrote:
> > > > > From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > > > > 
> > > > > For direct I/O, add the flag IOMAP_DIO_RWF_NO_STALE_PAGECACHE to indicate
> > > > > that if the page invalidation fails, return back control to the
> > > > > filesystem so it may fallback to buffered mode.
> > > > > 
> > > > > Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
> > > > > Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > > > 
> > > > I'd like to start a discussion of this shouldn't really be the
> > > > default behavior.  If we have page cache that can't be invalidated it
> > > > actually makes a whole lot of sense to not do direct I/O, avoid the
> > > > warnings, etc.
> > > > 
> > > > Adding all the relevant lists.
> > > 
> > > Since no one responded so far, let me see if I can stir the cauldron :)
> > > 
> > > What error should be returned in case of such an error? I think the
> > 
> > Christoph's message is ambiguous.  I don't know if he means "fail the
> > I/O with an error" or "satisfy the I/O through the page cache".  I'm
> > strongly in favour of the latter.
> 
> Same here.  Sorry if my previous mail was unclear.
> 
> > Indeed, I'm in favour of not invalidating
> > the page cache at all for direct I/O.  For reads, I think the page cache
> > should be used to satisfy any portion of the read which is currently
> > cached.  For writes, I think we should write into the page cache pages
> > which currently exist, and then force those pages to be written back,
> > but left in cache.
> 
> Something like that, yes.

So are we really willing to take the performance regression that
occurs from copying out of the page cache consuming lots more CPU
than an actual direct IO read? Or that direct IO writes suddenly
serialise because there are page cache pages and now we have to do
buffered IO?

Direct IO should be a deterministic, zero-copy IO path to/from
storage. Using the CPU to copy data during direct IO is the complete
opposite of the intended functionality, not to mention the behaviour
that many applications have been careful designed and tuned for.

Hence I think that forcing iomap to use cached pages for DIO is a
non-starter. I have no problems with providing infrastructure that
allows filesystems to -opt in- to using buffered IO for the direct
IO path. However, the change in IO behaviour caused by unpredicably
switching between direct IO and buffered IO (e.g. suddening DIO
writes serialise -all IO-) will cause unacceptible performance
regressions for many applications and be -very difficult to
diagnose- in production systems.

IOWs, we need to let the individual filesystems decide how they want
to use the page cache for direct IO. Just because we have new direct
IO infrastructure (i.e. iomap) it does not mean we can just make
wholesale changes to the direct IO path behaviour...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
