Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7C63CEED4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2019 00:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729212AbfJGWIl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Oct 2019 18:08:41 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:44903 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728422AbfJGWIk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Oct 2019 18:08:40 -0400
Received: from dread.disaster.area (pa49-181-226-196.pa.nsw.optusnet.com.au [49.181.226.196])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 968DC363D6F;
        Tue,  8 Oct 2019 09:08:38 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.2)
        (envelope-from <david@fromorbit.com>)
        id 1iHbBF-0001tZ-HL; Tue, 08 Oct 2019 09:08:37 +1100
Date:   Tue, 8 Oct 2019 09:08:37 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     "Darrick J . Wong" <darrick.wong@oracle.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/11] iomap: zero newly allocated mapped blocks
Message-ID: <20191007220837.GD16973@dread.disaster.area>
References: <20191006154608.24738-1-hch@lst.de>
 <20191006154608.24738-6-hch@lst.de>
 <20191007214632.GA16973@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191007214632.GA16973@dread.disaster.area>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=P6RKvmIu c=1 sm=1 tr=0
        a=dRuLqZ1tmBNts2YiI0zFQg==:117 a=dRuLqZ1tmBNts2YiI0zFQg==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=XobE76Q3jBoA:10
        a=yPCof4ZbAAAA:8 a=7-415B0cAAAA:8 a=pGzP--_MTh1zkI28PPEA:9
        a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 08, 2019 at 08:46:32AM +1100, Dave Chinner wrote:
> On Sun, Oct 06, 2019 at 05:46:02PM +0200, Christoph Hellwig wrote:
> > File systems like gfs2 don't support delayed allocations or unwritten
> > extents and thus allocate normal mapped blocks to fill holes.  To
> > cover the case of such file systems allocating new blocks to fill holes
> > also zero out mapped blocks with the new flag.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
> > Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
> > ---
> >  fs/iomap/buffered-io.c | 12 ++++++++++--
> >  1 file changed, 10 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > index 23cc308f971d..4132c0cccb0a 100644
> > --- a/fs/iomap/buffered-io.c
> > +++ b/fs/iomap/buffered-io.c
> > @@ -207,6 +207,14 @@ iomap_read_inline_data(struct inode *inode, struct page *page,
> >  	SetPageUptodate(page);
> >  }
> >  
> > +static inline bool iomap_block_needs_zeroing(struct inode *inode,
> > +		struct iomap *iomap, loff_t pos)
> > +{
> > +	return iomap->type != IOMAP_MAPPED ||
> > +		(iomap->flags & IOMAP_F_NEW) ||
> > +		pos >= i_size_read(inode);
> 
> This is a change of logic - why is the IOMAP_F_NEW check added here
> and what bug does it fix?

Sorry, brain-fart here - that's what this patch is adding, it's not
a pure factoring patch.... :/

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
