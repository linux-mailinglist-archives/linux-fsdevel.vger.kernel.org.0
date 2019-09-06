Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A82B1AC303
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Sep 2019 01:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405362AbfIFX2R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Sep 2019 19:28:17 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:60386 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405045AbfIFX2R (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Sep 2019 19:28:17 -0400
Received: from dread.disaster.area (pa49-181-255-194.pa.nsw.optusnet.com.au [49.181.255.194])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id D5462360F92;
        Sat,  7 Sep 2019 09:28:13 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1i6NeG-0004os-7p; Sat, 07 Sep 2019 09:28:12 +1000
Date:   Sat, 7 Sep 2019 09:28:12 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.de>,
        linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        darrick.wong@oracle.com, linux-xfs@vger.kernel.org,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 15/15] xfs: Use the new iomap infrastructure for CoW
Message-ID: <20190906232812.GB16973@dread.disaster.area>
References: <20190905150650.21089-1-rgoldwyn@suse.de>
 <20190905150650.21089-16-rgoldwyn@suse.de>
 <20190906165507.GA12842@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190906165507.GA12842@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=FNpr/6gs c=1 sm=1 tr=0
        a=YO9NNpcXwc8z/SaoS+iAiA==:117 a=YO9NNpcXwc8z/SaoS+iAiA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=J70Eh1EUuV4A:10
        a=JfrnYn6hAAAA:8 a=7-415B0cAAAA:8 a=kd9TP_cp1AsMHmmDf5oA:9
        a=CjuIK1q_8ugA:10 a=1CNFftbPRP8L7MoqJWF3:22 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 06, 2019 at 06:55:07PM +0200, Christoph Hellwig wrote:
> On Thu, Sep 05, 2019 at 10:06:50AM -0500, Goldwyn Rodrigues wrote:
> > diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> > index 8321733c16c3..13495d8a1ee2 100644
> > --- a/fs/xfs/xfs_iomap.c
> > +++ b/fs/xfs/xfs_iomap.c
> > @@ -1006,7 +1006,10 @@ xfs_file_iomap_begin(
> >  		 */
> >  		if (directio || imap.br_startblock == HOLESTARTBLOCK)
> >  			imap = cmap;
> > +		else
> > +			xfs_bmbt_to_iomap(ip, srcmap, &cmap, false);
> >  
> > +		iomap->flags |= IOMAP_F_COW;
> 
> I don't think this is correct.  We should only set IOMAP_F_COW
> when we actually fill out the srcmap.  Which is a very good agument
> for Darrick's suggestion to check for a non-emptry srcmap.
> 
> Also this is missing the actually interesting part in
> xfs_file_iomap_begin_delay.
> 
> I ended up spending the better half of the day trying to implement
> that and did run into a few bugs in the core iomap changes, mostly
> due to a confusion which iomap to use.  So I ended up reworking those
> a bit to:
> 
>   a) check srcmap->type to see if there is a valid srcmap
>   b) set the srcmap pointer to iomap so that it doesn't need to
>      be special cased all over
>   c) fixed up a few more places to use the srcmap
> 
> This now at least survives xfstests -g quick on a 4k xfs file system
> for.  Here is my current tree:
> 
> http://git.infradead.org/users/hch/xfs.git/shortlog/refs/heads/xfs-cow-iomap

That looks somewhat reasonable. The XFS mapping function is turning
into spagetti and getting really hard to follow again, though.
Perhaps we should consider splitting the shared/COW path out of
it...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
