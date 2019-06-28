Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A802658F23
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2019 02:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbfF1Aqx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jun 2019 20:46:53 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:50675 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726595AbfF1Aqx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jun 2019 20:46:53 -0400
Received: from dread.disaster.area (pa49-195-139-63.pa.nsw.optusnet.com.au [49.195.139.63])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 8914843CE43;
        Fri, 28 Jun 2019 10:46:49 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1hgf1K-0002iM-3I; Fri, 28 Jun 2019 10:45:42 +1000
Date:   Fri, 28 Jun 2019 10:45:42 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     "Darrick J . Wong" <darrick.wong@oracle.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/12] iomap: move the xfs writeback code to iomap.c
Message-ID: <20190628004542.GJ7777@dread.disaster.area>
References: <20190624055253.31183-1-hch@lst.de>
 <20190624055253.31183-12-hch@lst.de>
 <20190624234304.GD7777@dread.disaster.area>
 <20190625101020.GI1462@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190625101020.GI1462@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=FNpr/6gs c=1 sm=1 tr=0 cx=a_idp_d
        a=fNT+DnnR6FjB+3sUuX8HHA==:117 a=fNT+DnnR6FjB+3sUuX8HHA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=dq6fvYVFJ5YA:10
        a=7-415B0cAAAA:8 a=c__QhW7x6gYDNGrBcwkA:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 25, 2019 at 12:10:20PM +0200, Christoph Hellwig wrote:
> On Tue, Jun 25, 2019 at 09:43:04AM +1000, Dave Chinner wrote:
> > I'm a little concerned this is going to limit what we can do
> > with the XFS IO path because now we can't change this code without
> > considering the direct impact on other filesystems. The QA burden of
> > changing the XFS writeback code goes through the roof with this
> > change (i.e. we can break multiple filesystems, not just XFS).
> 
> Going through the roof is a little exaggerated.

You've already mentioned two new users you want to add. I don't even
have zone capable hardware here to test one of the users you are
indicating will use this code, and I suspect that very few people
do.  That's a non-trivial increase in testing requirements for
filesystem developers and distro QA departments who will want to
change and/or validate this code path.

> Yes, it will be more
> testing overhead, but that is life in a world where we try to share
> code rather than duplicating it, which is pretty much a general
> kernel policy that has served us well.

Yes, but we also need to acknowledge why we have re-implemented
everything in fs/iomap.c - we haven't lifted code from XFS to do
that - we've replaced existing generic code that didn't do what we
needed and couldn't easily be modified to do what we needed because
of all it's external dependencies.

Indeed, integrating gfs2 into the existing generic iomap code has
required quite a bit of munging and adding new code paths and so on.
That's mostly been straight forward because it's just been adding
flags and conditional code to the existing paths. The way we
regularly rewrite sections of the XFS writeback code is a very
different sort of modification, and one that will be much harder to
do if we have to make those changes to generic code.

i.e. shared code is good if it's simple and doesn't have a lot of
external dependencies that restrict the type and scope of
modifications that can be made easily. Shared code that is complex
and comes from code that was tightly integrated with a specific
subsystem architecture is going to carry all those architectural
foilbles into the new "generic" code. Once it gets sufficient
users it's going to end up with the same "we can't change this code"
problems that we had with the existing IO path, and we'll go back to
implementing our own writeback path....

> > The writepage code is one of the areas that, historically speaking,
> > has one of the highest rates of modification in XFS - we've
> > substantially reworked this code from top to bottom 4 or 5 times in
> > a bit over ten years, and each time it's been removing abstraction
> > layers and getting the writeback code closer to the internal XFS
> > extent mapping infrastructure.
> 
> I don't think we had all that much churn.

We've had more churn over time to the writeback code than just about
any other subsystem in XFS.

It also represents a complete 180-degree flip on how we've been
streamlining the writeback path in XFS over the past few years.
We've been moving closer and closer to the generic writeback
infrastructure as well as closer to the XFS inode extent tree.

I've been planning on taking it even closer to the extent tree to
give us lockless, modification range coherent extent map caching in
this path (e.g. write() can add new delalloc extents without
invalidating cached writeback maps).  This patchset re-introduces
the iomap abstraction over the bmbt - an abstraction we removed some
time ago - and that makes these sorts of improvements much harder
and more complex to implement....

IOWs, I'm not convinced that lifting this code out of XFS is the
best long term plan for XFS or the iomap code here....

> Yes, we've improved it a
> lot, but much of that was in response to core changes, and pretty much
> all of it benefits other users as well.  And the more users we have
> for this infrastructure that more clout it has with core VM folks
> when we have to push back odd design decisions.

If we have to make stuff "generic" to be able to influence how other
subsystems go about providing infrastructure to filesytsems, then
our development community and processes are even more broken than I
think they are. Developer communication and design influence are not
problems we should be trying to fix with code.

Cheers,

Dave.
-Dave.
-- 
Dave Chinner
david@fromorbit.com
