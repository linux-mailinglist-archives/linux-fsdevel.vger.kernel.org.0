Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD0338D025
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2019 11:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbfHNJ4A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Aug 2019 05:56:00 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:49931 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725280AbfHNJ4A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Aug 2019 05:56:00 -0400
Received: from dread.disaster.area (pa49-195-190-67.pa.nsw.optusnet.com.au [49.195.190.67])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 1E4712ADB91;
        Wed, 14 Aug 2019 19:55:56 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1hxpzU-0001TQ-RR; Wed, 14 Aug 2019 19:54:48 +1000
Date:   Wed, 14 Aug 2019 19:54:48 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v3] vfs: fix page locking deadlocks when deduping files
Message-ID: <20190814095448.GK6129@dread.disaster.area>
References: <20190813151434.GQ7138@magnolia>
 <20190813154010.GD5307@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190813154010.GD5307@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=D+Q3ErZj c=1 sm=1 tr=0
        a=TR82T6zjGmBjdfWdGgpkDw==:117 a=TR82T6zjGmBjdfWdGgpkDw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=FmdZ9Uzk2mMA:10
        a=7-415B0cAAAA:8 a=vmqrRjBPTwjFo0SR-QoA:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 13, 2019 at 08:40:10AM -0700, Matthew Wilcox wrote:
> On Tue, Aug 13, 2019 at 08:14:34AM -0700, Darrick J. Wong wrote:
> > +		/*
> > +		 * Now that we've locked both pages, make sure they still
> > +		 * represent the data we're interested in.  If not, someone
> > +		 * is invalidating pages on us and we lose.
> > +		 */
> > +		if (src_page->mapping != src->i_mapping ||
> > +		    src_page->index != srcoff >> PAGE_SHIFT ||
> > +		    dest_page->mapping != dest->i_mapping ||
> > +		    dest_page->index != destoff >> PAGE_SHIFT) {
> > +			same = false;
> > +			goto unlock;
> > +		}
> 
> It is my understanding that you don't need to check the ->index here.
> If I'm wrong about that, I'd really appreciate being corrected, because
> the page cache locking is subtle.

Ah, when talking to Darrick about this, I didn't notice the code
took references on the page, so it probably doesn't need the index
check - the page can't be recycled out from under us here an
inserted into a new mapping until we drop the reference.

What I was mainly concerned about here is that we only have a shared
inode lock on the src inode, so this code can be running
concurrently with both invalidation and insertion into the mapping.
e.g. direct write io does invalidation, buffered read does
insertion. Hence we have to be really careful about the data in the
source page being valid and stable while we run the comparison.

And on further thought, I don't think shared locking is actually
safe here. A shared lock doesn't stop new direct IO from being
submitted, so inode_dio_wait() just drains IO at that point in time
and but doesn't provide any guarantee that there isn't concurrent
DIO running.

Hence we could do the comparison here, see the data is the same,
drop the page lock, a DIO write then invalidates the page and writes
new data while we are comparing the rest of page(s) in the range. By
the time we've checked the whole range, the data at the start is no
longer the same, and the comparison is stale.

And then we do the dedupe operation oblivious to the fact the data
on disk doesn't actually match anymore, and we corrupt the data in
the destination file as it gets linked to mismatched data in the
source file....

Darrick?

> You call read_mapping_page() which returns the page with an elevated
> refcount.  That means the page can't go back to the page allocator and
> be allocated again.  It can, because it's unlocked, still be truncated,
> so the check for ->mapping after locking it is needed.  But the check
> for ->index being correct was done by find_get_entry().
> 
> See pagecache_get_page() -- if we specify FGP_LOCK, then it will lock
> the page, check the ->mapping but not check ->index.  OK, it does check
> ->index, but in a VM_BUG_ON(), so it's not something that ought to be
> able to be wrong.

Yeah, we used to have to play tricks in the old XFS writeback
clustering code to do our own non-blocking page cache lookups adn
this was one of the things we needed to be careful about until
the pagevec_lookup* interfaces came along and solved all the
problems for us. Funny how the brain remembers old gotchas with
also reminding you that the problems went away almost as long
ago.....


Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
