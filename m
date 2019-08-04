Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 592E7808D6
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Aug 2019 03:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729440AbfHDBvj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 3 Aug 2019 21:51:39 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:37804 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728274AbfHDBvi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 3 Aug 2019 21:51:38 -0400
Received: from dread.disaster.area (pa49-181-167-148.pa.nsw.optusnet.com.au [49.181.167.148])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 946F47E53AD;
        Sun,  4 Aug 2019 11:51:36 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1hu5fJ-00054z-LO; Sun, 04 Aug 2019 11:50:29 +1000
Date:   Sun, 4 Aug 2019 11:50:29 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Brian Foster <bfoster@redhat.com>
Cc:     linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 02/24] shrinkers: use will_defer for GFP_NOFS sensitive
 shrinkers
Message-ID: <20190804015029.GS7777@dread.disaster.area>
References: <20190801021752.4986-1-david@fromorbit.com>
 <20190801021752.4986-3-david@fromorbit.com>
 <20190802152737.GB60893@bfoster>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190802152737.GB60893@bfoster>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=P6RKvmIu c=1 sm=1 tr=0 cx=a_idp_d
        a=gu9DDhuZhshYSb5Zs/lkOA==:117 a=gu9DDhuZhshYSb5Zs/lkOA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=FmdZ9Uzk2mMA:10
        a=20KFwNOVAAAA:8 a=7-415B0cAAAA:8 a=clxzVxKhvR3UWeArRMgA:9
        a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 02, 2019 at 11:27:37AM -0400, Brian Foster wrote:
> On Thu, Aug 01, 2019 at 12:17:30PM +1000, Dave Chinner wrote:
> > From: Dave Chinner <dchinner@redhat.com>
> > 
> > For shrinkers that currently avoid scanning when called under
> > GFP_NOFS contexts, conver them to use the new ->will_defer flag
> > rather than checking and returning errors during scans.
> > 
> > This makes it very clear that these shrinkers are not doing any work
> > because of the context limitations, not because there is no work
> > that can be done.
> > 
> > Signed-off-by: Dave Chinner <dchinner@redhat.com>
> > ---
> >  drivers/staging/android/ashmem.c |  8 ++++----
> >  fs/gfs2/glock.c                  |  5 +++--
> >  fs/gfs2/quota.c                  |  6 +++---
> >  fs/nfs/dir.c                     |  6 +++---
> >  fs/super.c                       |  6 +++---
> >  fs/xfs/xfs_buf.c                 |  4 ++++
> >  fs/xfs/xfs_qm.c                  | 11 ++++++++---
> >  net/sunrpc/auth.c                |  5 ++---
> >  8 files changed, 30 insertions(+), 21 deletions(-)
> > 
> ...
> > diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
> > index ca0849043f54..6e0f76532535 100644
> > --- a/fs/xfs/xfs_buf.c
> > +++ b/fs/xfs/xfs_buf.c
> > @@ -1680,6 +1680,10 @@ xfs_buftarg_shrink_count(
> >  {
> >  	struct xfs_buftarg	*btp = container_of(shrink,
> >  					struct xfs_buftarg, bt_shrinker);
> > +
> > +	if (!(sc->gfp_mask & __GFP_FS))
> > +		sc->will_defer = true;
> > +
> >  	return list_lru_shrink_count(&btp->bt_lru, sc);
> >  }
> 
> This hunk looks like a behavior change / bug fix..? The rest of the

Yeah, forgot to move that to the patch that fixes the accounting for
the xfs_buf cache later on in the series. Will fix.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
