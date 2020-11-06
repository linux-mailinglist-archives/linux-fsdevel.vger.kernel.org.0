Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E38D02A8D88
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Nov 2020 04:32:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725966AbgKFDca (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Nov 2020 22:32:30 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:48011 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725842AbgKFDca (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Nov 2020 22:32:30 -0500
Received: from dread.disaster.area (pa49-179-6-140.pa.nsw.optusnet.com.au [49.179.6.140])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 502EF58BA4E;
        Fri,  6 Nov 2020 14:32:27 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1kasUE-008Ab6-CX; Fri, 06 Nov 2020 14:32:26 +1100
Date:   Fri, 6 Nov 2020 14:32:26 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        fdmanana@kernel.org
Subject: Re: [RFC PATCH] vfs: remove lockdep bogosity in __sb_start_write
Message-ID: <20201106033226.GF7391@dread.disaster.area>
References: <20201103173300.GF7123@magnolia>
 <20201103173921.GA32219@infradead.org>
 <20201103183444.GH7123@magnolia>
 <20201103184659.GA19623@infradead.org>
 <20201103193750.GK7123@magnolia>
 <20201105213415.GD7391@dread.disaster.area>
 <20201106021951.GF7148@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201106021951.GF7148@magnolia>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=YKPhNiOx c=1 sm=1 tr=0 cx=a_idp_d
        a=uDU3YIYVKEaHT0eX+MXYOQ==:117 a=uDU3YIYVKEaHT0eX+MXYOQ==:17
        a=kj9zAlcOel0A:10 a=nNwsprhYR40A:10 a=7-415B0cAAAA:8
        a=RObj2HEUvNYVxs8GEq8A:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 05, 2020 at 06:19:51PM -0800, Darrick J. Wong wrote:
> On Fri, Nov 06, 2020 at 08:34:15AM +1100, Dave Chinner wrote:
> > On Tue, Nov 03, 2020 at 11:37:50AM -0800, Darrick J. Wong wrote:
> > > On Tue, Nov 03, 2020 at 06:46:59PM +0000, Christoph Hellwig wrote:
> > > > On Tue, Nov 03, 2020 at 10:34:44AM -0800, Darrick J. Wong wrote:
> > > > > > Please split the function into __sb_start_write and
> > > > > > __sb_start_write_trylock while you're at it..
> > > > > 
> > > > > Any thoughts on this patch itself?  I don't feel like I have 100% of the
> > > > > context to know whether the removal is a good idea for non-xfs
> > > > > filesystems, though I'm fairly sure the current logic is broken.
> > > > 
> > > > The existing logic looks pretty bogus to me as well.  Did you try to find
> > > > the discussion that lead to it?
> > > 
> > > TBH I don't know where the discussion happened.  The "convert to
> > > trylock" behavior first appeared as commit 5accdf82ba25c back in 2012;
> > > that commit seems to have come from v6 of a patch[1] that Jan Kara sent
> > > to try to fix fs freeze handling back in 2012.  The behavior was not in
> > > the v5[0] patch, nor was there any discussion for any of the v5 patches
> > > that would suggest why things changed from v5 to v6.
> > > 
> > > Dave and I were talking about this on IRC yesterday, and his memory
> > > thought that this was lockdep trying to handle xfs taking intwrite
> > > protection while handling a write (or page_mkwrite) operation.  I'm not
> > > sure where "XFS for example gets freeze protection on internal level
> > > twice in some cases" would actually happen -- did xfs support nested
> > > transactions in the past?  We definitely don't now, so I don't think the
> > > comment is valid anymore.
> > > 
> > > The last commit to touch this area was f4b554af9931 (in 2015), which
> > > says that Dave explained that the trylock hack + comment could be
> > > removed, but the patch author never did that, and lore doesn't seem to
> > > know where or when Dave actually said that?
> > 
> > I'm pretty sure this "nesting internal freeze references" stems from
> > the fact we log and flush the superblock after fulling freezing the
> > filesystem to dirty the journal so recovery after a crash while
> > frozen handles unlinked inodes.
> > 
> > The high level VFS freeze annotations were not able to handle
> > running this transaction when transactions were supposed to already
> > be blocked and drained, so there was a special hack to hide it from
> > lockdep. Then we ended up hiding it from the VFS via
> > XFS_TRANS_NO_WRITECOUNT in xfs_sync_sb() because we needed it in
> > more places than just freeze (e.g. the log covering code
> > run by the background log worker). It's kinda documented here:
> > 
> > /*
> >  * xfs_sync_sb
> >  *
> >  * Sync the superblock to disk.
> >  *
> >  * Note that the caller is responsible for checking the frozen state of the
> >  * filesystem. This procedure uses the non-blocking transaction allocator and
> >  * thus will allow modifications to a frozen fs. This is required because this
> >  * code can be called during the process of freezing where use of the high-level
> >  * allocator would deadlock.
> >  */
> > 
> > So, AFAICT, the whole "XFS nests internal transactions" lockdep 
> > handling in __sb_start_write() has been unnecessary for quite a few
> > years now....
> 
> Yeah.  Would you be willing to RVB this, or are you all waiting for a v2
> series?

Send out a v2 - you probably need to include some of the above
information in the change log removing the lockdep stuff so it's
preserved this time...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
