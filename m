Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82B9C163659
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2020 23:46:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgBRWqQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Feb 2020 17:46:16 -0500
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:43265 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726438AbgBRWqQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Feb 2020 17:46:16 -0500
Received: from dread.disaster.area (pa49-179-138-28.pa.nsw.optusnet.com.au [49.179.138.28])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 2C6AA3A311C;
        Wed, 19 Feb 2020 09:46:11 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1j4Bd4-0003kz-H7; Wed, 19 Feb 2020 09:46:10 +1100
Date:   Wed, 19 Feb 2020 09:46:10 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        ocfs2-devel@oss.oracle.com, linux-xfs@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v6 03/19] mm: Use readahead_control to pass arguments
Message-ID: <20200218224610.GT10776@dread.disaster.area>
References: <20200217184613.19668-1-willy@infradead.org>
 <20200217184613.19668-4-willy@infradead.org>
 <20200218050300.GI10776@dread.disaster.area>
 <20200218135618.GO7778@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200218135618.GO7778@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=W5xGqiek c=1 sm=1 tr=0
        a=zAxSp4fFY/GQY8/esVNjqw==:117 a=zAxSp4fFY/GQY8/esVNjqw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=l697ptgUJYAA:10
        a=7-415B0cAAAA:8 a=-669WvyOGAhHUzcTJR8A:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 18, 2020 at 05:56:18AM -0800, Matthew Wilcox wrote:
> On Tue, Feb 18, 2020 at 04:03:00PM +1100, Dave Chinner wrote:
> > On Mon, Feb 17, 2020 at 10:45:44AM -0800, Matthew Wilcox wrote:
> > > +static void read_pages(struct readahead_control *rac, struct list_head *pages,
> > > +		gfp_t gfp)
> > >  {
> > > +	const struct address_space_operations *aops = rac->mapping->a_ops;
> > >  	struct blk_plug plug;
> > >  	unsigned page_idx;
> > 
> > Splitting out the aops rather than the mapping here just looks
> > weird, especially as you need the mapping later in the function.
> > Using aops doesn't even reduce the code side....
> 
> It does in subsequent patches ... I agree it looks a little weird here,
> but I think in the final form, it makes sense:

Ok. Perhaps just an additional commit comment to say "read_pages() is
changed to be aops centric as @rac abstracts away all other
implementation details by the end of the patchset."

> > > +			if (readahead_count(&rac))
> > > +				read_pages(&rac, &page_pool, gfp_mask);
> > > +			rac._nr_pages = 0;
> > 
> > Hmmm. Wondering ig it make sense to move the gfp_mask to the readahead
> > control structure - if we have to pass the gfp_mask down all the
> > way along side the rac, then I think it makes sense to do that...
> 
> So we end up removing it later on in this series, but I do wonder if
> it would make sense anyway.  By the end of the series, we still have
> this in iomap:
> 
>                 if (ctx->rac) /* same as readahead_gfp_mask */
>                         gfp |= __GFP_NORETRY | __GFP_NOWARN;
> 
> and we could get rid of that by passing gfp flags down in the rac.  On the
> other hand, I don't know why it doesn't just use readahead_gfp_mask()
> here anyway ... Christoph?

mapping->gfp_mask is awful. Is it a mask, or is it a valid set of
allocation flags? Or both?  Some callers to mapping_gfp_constraint()
uses it as a mask, some callers to mapping_gfp_constraint() use it
as base flags that context specific flags get masked out of,
readahead_gfp_mask() callers use it as the entire set of gfp flags
for allocation.

That whole API sucks - undocumented as to what it's suposed to do
and how it's supposed to be used. Hence it's difficult to use
correctly or understand whether it's being used correctly. And
reading callers only leads to more confusion and crazy code like in
do_mpage_readpage() where readahead returns a mask that are used as
base flags and normal reads return a masked set of base flags...

The iomap code is obviously correct when it comes to gfp flag
manipulation. We start with GFP_KERNEL context, then constrain it
via the mask held in mapping->gfp_mask, then if it's readahead we
allow the allocation to silently fail.

Simple to read and understand code, versus having weird code that
requires the reader to decipher an undocumented and inconsistent API
to understand how the gfp flags have been calculated and are valid.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
