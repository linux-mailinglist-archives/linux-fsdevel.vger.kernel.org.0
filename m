Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82B671F02A3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jun 2020 23:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728285AbgFEVsq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Jun 2020 17:48:46 -0400
Received: from mail109.syd.optusnet.com.au ([211.29.132.80]:51044 "EHLO
        mail109.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728083AbgFEVsq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Jun 2020 17:48:46 -0400
Received: from dread.disaster.area (pa49-180-124-177.pa.nsw.optusnet.com.au [49.180.124.177])
        by mail109.syd.optusnet.com.au (Postfix) with ESMTPS id 46722D78F72;
        Sat,  6 Jun 2020 07:48:42 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1jhKCf-0000nV-LW; Sat, 06 Jun 2020 07:48:41 +1000
Date:   Sat, 6 Jun 2020 07:48:41 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iomap: Handle I/O errors gracefully in page_mkwrite
Message-ID: <20200605214841.GF2040@dread.disaster.area>
References: <20200604202340.29170-1-willy@infradead.org>
 <20200604225726.GU2040@dread.disaster.area>
 <20200604230519.GW19604@bombadil.infradead.org>
 <20200604233053.GW2040@dread.disaster.area>
 <20200604235050.GX19604@bombadil.infradead.org>
 <20200605003159.GX2040@dread.disaster.area>
 <20200605022451.GZ19604@bombadil.infradead.org>
 <20200605030758.GB2040@dread.disaster.area>
 <20200605124826.GF19604@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200605124826.GF19604@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=W5xGqiek c=1 sm=1 tr=0
        a=k3aV/LVJup6ZGWgigO6cSA==:117 a=k3aV/LVJup6ZGWgigO6cSA==:17
        a=kj9zAlcOel0A:10 a=nTHF0DUjJn0A:10 a=7-415B0cAAAA:8
        a=5k1WLetKFTAGHca7CXYA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 05, 2020 at 05:48:26AM -0700, Matthew Wilcox wrote:
> On Fri, Jun 05, 2020 at 01:07:58PM +1000, Dave Chinner wrote:
> > On Thu, Jun 04, 2020 at 07:24:51PM -0700, Matthew Wilcox wrote:
> > > On Fri, Jun 05, 2020 at 10:31:59AM +1000, Dave Chinner wrote:
> > > > On Thu, Jun 04, 2020 at 04:50:50PM -0700, Matthew Wilcox wrote:
> > > > > > Sure, but that's not really what I was asking: why isn't this
> > > > > > !uptodate state caught before the page fault code calls
> > > > > > ->page_mkwrite? The page fault code has a reference to the page,
> > > > > > after all, and in a couple of paths it even has the page locked.
> > > > > 
> > > > > If there's already a PTE present, then the page fault code doesn't
> > > > > check the uptodate bit.  Here's the path I'm looking at:
> > > > > 
> > > > > do_wp_page()
> > > > >  -> vm_normal_page()
> > > > >  -> wp_page_shared()
> > > > >      -> do_page_mkwrite()
> > > > > 
> > > > > I don't see anything in there that checked Uptodate.
> > > > 
> > > > Yup, exactly the code I was looking at when I asked this question.
> > > > The kernel has invalidated the contents of a page, yet we still have
> > > > it mapped into userspace as containing valid contents, and we don't
> > > > check it at all when userspace generates a protection fault on the
> > > > page?
> > > 
> > > Right.  The iomap error path only clears PageUptodate.  It doesn't go
> > > to the effort of unmapping the page from userspace, so userspace has a
> > > read-only view of a !Uptodate page.
> > 
> > Hmmm - did you miss the ->discard_page() callout just before we call
> > ClearPageUptodate() on error in iomap_writepage_map()? That results
> > in XFS calling iomap_invalidatepage() on the page, which ....
> 
> ... I don't think that's the interesting path.  I mean, that's
> the submission path, and usually we discover errors in the completion
> path, not the submission path.

Where in the iomap write IO completion path do we call
ClearPageUptodate()?

I mean, it ends up in iomap_finish_page_writeback(), which does:

static void
iomap_finish_page_writeback(struct inode *inode, struct page *page,
                int error)
{
        struct iomap_page *iop = to_iomap_page(page);

        if (error) {
                SetPageError(page);
                mapping_set_error(inode->i_mapping, -EIO);
        }

        WARN_ON_ONCE(i_blocksize(inode) < PAGE_SIZE && !iop);
        WARN_ON_ONCE(iop && atomic_read(&iop->write_count) <= 0);

        if (!iop || atomic_dec_and_test(&iop->write_count))
                end_page_writeback(page);
}

I mean, we call SetPageError() and tag the mapping, but we most
certainly don't clear the PageUptodate state here.

So AFAICT, the -only- places that iomap clears the uptodate state on
a page is on -read- errors and on write submission failures.

If it's a read error, the page fault should already be failing. If
it's on submission, we invalidate it as we currently do and punch
out the user mappings, and then when userspace refaults it can be
killed by a read IO failure.

But I just don't see how this problem results from errors reported
at IO completion.

This comes back to my original, underlying worry about the fragility
of the page fault path: the page fault path is not even checking for
PageError during faults, and I'm betting that almost no
->page_mkwrite implementation is checking it, either....

> > It's not clear to me that we can actually unmap those pages safely
> > in a race free manner from this code - can we actually do that from
> > the page writeback path?
> 
> I don't see why it can't be done from the submission path.
> unmap_mapping_range() calls i_mmap_lock_write(), which is
> down_write(i_mmap_rwsem) in drag.  There might be a lock ordering
> issue there, although lockdep should find it pretty quickly.
> 
> The bigger problem is the completion path.  We're in softirq context,
> so that will have to punt to a thread that can take mutexes.

Punt to workqueue if we aren't already in a workqueue context -
for a lot of writes on XFS we already will be running completion in
a workqueue context....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
