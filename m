Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0F0D163D20
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2020 07:40:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbgBSGkM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Feb 2020 01:40:12 -0500
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:48643 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726156AbgBSGkL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Feb 2020 01:40:11 -0500
Received: from dread.disaster.area (pa49-179-138-28.pa.nsw.optusnet.com.au [49.179.138.28])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 93B223A38C1;
        Wed, 19 Feb 2020 17:40:06 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1j4J1h-0006cP-MZ; Wed, 19 Feb 2020 17:40:05 +1100
Date:   Wed, 19 Feb 2020 17:40:05 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        ocfs2-devel@oss.oracle.com, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v6 17/19] iomap: Restructure iomap_readpages_actor
Message-ID: <20200219064005.GL10776@dread.disaster.area>
References: <20200217184613.19668-1-willy@infradead.org>
 <20200217184613.19668-31-willy@infradead.org>
 <20200219032900.GE10776@dread.disaster.area>
 <20200219060415.GO24185@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219060415.GO24185@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=W5xGqiek c=1 sm=1 tr=0
        a=zAxSp4fFY/GQY8/esVNjqw==:117 a=zAxSp4fFY/GQY8/esVNjqw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=l697ptgUJYAA:10
        a=7-415B0cAAAA:8 a=r7nCFNou5KQKI5VhP1MA:9 a=-52OSV3k6aGjHW0a:21
        a=qFaRso0K34Rwt0Du:21 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 18, 2020 at 10:04:15PM -0800, Matthew Wilcox wrote:
> On Wed, Feb 19, 2020 at 02:29:00PM +1100, Dave Chinner wrote:
> > On Mon, Feb 17, 2020 at 10:46:11AM -0800, Matthew Wilcox wrote:
> > > @@ -418,6 +412,15 @@ iomap_readpages_actor(struct inode *inode, loff_t pos, loff_t length,
> > >  		}
> > >  		ret = iomap_readpage_actor(inode, pos + done, length - done,
> > >  				ctx, iomap, srcmap);
> > > +		if (WARN_ON(ret == 0))
> > > +			break;
> > 
> > This error case now leaks ctx->cur_page....
> 
> Yes ... and I see the consequence.  I mean, this is a "shouldn't happen",
> so do we want to put effort into cleanup here ...

Well, the normal thing for XFS is that a production kernel cleans up
and handles the error gracefully with a WARN_ON_ONCE, while a debug
kernel build will chuck a tanty and burn the house down so to make
the developers aware that there is a "should not happen" situation
occurring....

> > > @@ -451,11 +454,7 @@ iomap_readpages(struct address_space *mapping, struct list_head *pages,
> > >  done:
> > >  	if (ctx.bio)
> > >  		submit_bio(ctx.bio);
> > > -	if (ctx.cur_page) {
> > > -		if (!ctx.cur_page_in_bio)
> > > -			unlock_page(ctx.cur_page);
> > > -		put_page(ctx.cur_page);
> > > -	}
> > > +	BUG_ON(ctx.cur_page);
> > 
> > And so will now trigger both a warn and a bug....
> 
> ... or do we just want to run slap bang into this bug?
> 
> Option 1: Remove the check for 'ret == 0' altogether, as we had it before.
> That puts us into endless loop territory for a failure mode, and it's not
> parallel with iomap_readpage().
> 
> Option 2: Remove the WARN_ON from the check.  Then we just hit the BUG_ON,
> but we don't know why we did it.
> 
> Option 3: Set cur_page to NULL.  We'll hit the WARN_ON, avoid the BUG_ON,
> might end up with a page in the page cache which is never unlocked.

None of these are appealing.

> Option 4: Do the unlock/put page dance before setting the cur_page to NULL.
> We might double-unlock the page.

why would we double unlock the page?

Oh, the readahead cursor doesn't handle the case of partial page
submission, which would result in IO completion unlocking the page.

Ok, that's what the ctx.cur_page_in_bio check is used to detect i.e.
if we've got a page that the readahead cursor points at, and we
haven't actually added it to a bio, then we can leave it to the
read_pages() to unlock and clean up. If it's in a bio, then IO
completion will unlock it and so we only have to drop the submission
reference and move the readahead cursor forwards so read_pages()
doesn't try to unlock this page. i.e:

	/* clean up partial page submission failures */
	if (ctx.cur_page && ctx.cur_page_in_bio) {
		put_page(ctx.cur_page);
		readahead_next(rac);
	}

looks to me like it will handle the case of "ret == 0" in the actor
function just fine.

Cheers,

Dave.

-- 
Dave Chinner
david@fromorbit.com
