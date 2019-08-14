Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 436328DFCD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2019 23:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729500AbfHNV3p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Aug 2019 17:29:45 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:51688 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726585AbfHNV3o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Aug 2019 17:29:44 -0400
Received: from dread.disaster.area (pa49-195-190-67.pa.nsw.optusnet.com.au [49.195.190.67])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 4DC0236093A;
        Thu, 15 Aug 2019 07:29:41 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1hy0or-00063P-SF; Thu, 15 Aug 2019 07:28:33 +1000
Date:   Thu, 15 Aug 2019 07:28:33 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v3] vfs: fix page locking deadlocks when deduping files
Message-ID: <20190814212833.GO6129@dread.disaster.area>
References: <20190813151434.GQ7138@magnolia>
 <20190813154010.GD5307@bombadil.infradead.org>
 <20190814095448.GK6129@dread.disaster.area>
 <20190814153349.GS7138@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190814153349.GS7138@magnolia>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=D+Q3ErZj c=1 sm=1 tr=0
        a=TR82T6zjGmBjdfWdGgpkDw==:117 a=TR82T6zjGmBjdfWdGgpkDw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=FmdZ9Uzk2mMA:10
        a=7-415B0cAAAA:8 a=kfvmqF4w4xAL43RSuj4A:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 14, 2019 at 08:33:49AM -0700, Darrick J. Wong wrote:
> On Wed, Aug 14, 2019 at 07:54:48PM +1000, Dave Chinner wrote:
> > On Tue, Aug 13, 2019 at 08:40:10AM -0700, Matthew Wilcox wrote:
> > > On Tue, Aug 13, 2019 at 08:14:34AM -0700, Darrick J. Wong wrote:
> > > > +		/*
> > > > +		 * Now that we've locked both pages, make sure they still
> > > > +		 * represent the data we're interested in.  If not, someone
> > > > +		 * is invalidating pages on us and we lose.
> > > > +		 */
> > > > +		if (src_page->mapping != src->i_mapping ||
> > > > +		    src_page->index != srcoff >> PAGE_SHIFT ||
> > > > +		    dest_page->mapping != dest->i_mapping ||
> > > > +		    dest_page->index != destoff >> PAGE_SHIFT) {
> > > > +			same = false;
> > > > +			goto unlock;
> > > > +		}
> > > 
> > > It is my understanding that you don't need to check the ->index here.
> > > If I'm wrong about that, I'd really appreciate being corrected, because
> > > the page cache locking is subtle.
> > 
> > Ah, when talking to Darrick about this, I didn't notice the code
> > took references on the page, so it probably doesn't need the index
> > check - the page can't be recycled out from under us here an
> > inserted into a new mapping until we drop the reference.
> > 
> > What I was mainly concerned about here is that we only have a shared
> > inode lock on the src inode, so this code can be running
> > concurrently with both invalidation and insertion into the mapping.
> > e.g. direct write io does invalidation, buffered read does
> > insertion. Hence we have to be really careful about the data in the
> > source page being valid and stable while we run the comparison.
> > 
> > And on further thought, I don't think shared locking is actually
> > safe here. A shared lock doesn't stop new direct IO from being
> > submitted, so inode_dio_wait() just drains IO at that point in time
> > and but doesn't provide any guarantee that there isn't concurrent
> > DIO running.
> > 
> > Hence we could do the comparison here, see the data is the same,
> > drop the page lock, a DIO write then invalidates the page and writes
> > new data while we are comparing the rest of page(s) in the range. By
> > the time we've checked the whole range, the data at the start is no
> > longer the same, and the comparison is stale.
> > 
> > And then we do the dedupe operation oblivious to the fact the data
> > on disk doesn't actually match anymore, and we corrupt the data in
> > the destination file as it gets linked to mismatched data in the
> > source file....
> 
> <urrrrrrk> Yeah, that looks like a bug to me.  I didn't realize that
> directio writes were IOLOCK_SHARED and therefore reflink has to take
> IOLOCK_EXCL to block them.
> 
> Related question: do we need to do the same for MMAPLOCK?  I think the
> answer is yes because xfs_filemap_fault can call page_mkwrite with
> MMAPLOCK_SHARED.

Hmmmm. Yes, you are right, but I don't just holding MMAPLOCK_EXCL is
enough. Holding the MMAPLOCK will hold off page faults while we have
the lock, but it won't prevent pages that already have writeable
ptes from being modified as they don't require another page fault
until they've been cleaned.

So it seems to me that if we need to ensure that the file range is
not being concurrently modified, we have to:

	a) inode lock exclusive
	b) mmap lock exclusive
	c) break layouts(*)
	d) wait for dio
	e) clean all the dirty pages

On both the source and destination files. And then, because the
locks we hold form a barrier against newly dirtied pages, will all
attempts to modify the data be blocked. And so now the data
comparison can be done safely.

(*) The break layouts bit is necessary to handle co-ordination with
RDMA, NVMEoF, P2P DMA, pNFS, etc that manipulate data directly via
the block device rather than through file pages or DIO...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
