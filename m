Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 886513E53BC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Aug 2021 08:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237425AbhHJGpe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Aug 2021 02:45:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:42884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236783AbhHJGpb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Aug 2021 02:45:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 08FC161051;
        Tue, 10 Aug 2021 06:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628577910;
        bh=RihM3RABZmtn7Il17pSYaqOqh9/sxVWCnBL30iutPmY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SKrsQI2eIw9IUPVB1RsHIgu6uSnb4gU5KpLZP8rtfqVjBV8CixZEiIaHb4vs8AMas
         GT0R3ZenArX54wC57txe6nL+yCxzI7HjpE+NUh9tj5wrtRFMBrz8Qx1hqIMiwsVSvT
         Sq8N07oUa9bsO38lE2pIkwzRosXfbbz+Xs342fW1qyt8uqF0l/RxxT+C60fy+dj1Qm
         ShMHoYwVZaQk7kXM3z1OwtQnqL2tGKJqXC55jZ+DoZ9bSBCjyoFoR32IzLX0vIKzG/
         9zpz4+/IBoBxUNYFMD7vP+chEh2OVccjEZK3YezTqYyUHFFtsbz2JDraMsOH95eV2H
         TItJ3xdNBB/gA==
Date:   Mon, 9 Aug 2021 23:45:09 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, nvdimm@lists.linux.dev,
        cluster-devel@redhat.com
Subject: Re: [PATCH 11/30] iomap: add the new iomap_iter model
Message-ID: <20210810064509.GI3601443@magnolia>
References: <20210809061244.1196573-1-hch@lst.de>
 <20210809061244.1196573-12-hch@lst.de>
 <20210809221047.GC3657114@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210809221047.GC3657114@dread.disaster.area>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 10, 2021 at 08:10:47AM +1000, Dave Chinner wrote:
> On Mon, Aug 09, 2021 at 08:12:25AM +0200, Christoph Hellwig wrote:
> > The iomap_iter struct provides a convenient way to package up and
> > maintain all the arguments to the various mapping and operation
> > functions.  It is operated on using the iomap_iter() function that
> > is called in loop until the whole range has been processed.  Compared
> > to the existing iomap_apply() function this avoid an indirect call
> > for each iteration.
> > 
> > For now iomap_iter() calls back into the existing ->iomap_begin and
> > ->iomap_end methods, but in the future this could be further optimized
> > to avoid indirect calls entirely.
> > 
> > Based on an earlier patch from Matthew Wilcox <willy@infradead.org>.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  fs/iomap/Makefile     |  1 +
> >  fs/iomap/core.c       | 79 +++++++++++++++++++++++++++++++++++++++++++
> >  fs/iomap/trace.h      | 37 +++++++++++++++++++-
> >  include/linux/iomap.h | 56 ++++++++++++++++++++++++++++++
> >  4 files changed, 172 insertions(+), 1 deletion(-)
> >  create mode 100644 fs/iomap/core.c
> > 
> > diff --git a/fs/iomap/Makefile b/fs/iomap/Makefile
> > index eef2722d93a183..6b56b10ded347a 100644
> > --- a/fs/iomap/Makefile
> > +++ b/fs/iomap/Makefile
> > @@ -10,6 +10,7 @@ obj-$(CONFIG_FS_IOMAP)		+= iomap.o
> >  
> >  iomap-y				+= trace.o \
> >  				   apply.o \
> > +				   core.o \
> 
> This creates a discontinuity in the iomap git history. Can you add
> these new functions to iomap/apply.c, then when the old apply code
> is removed later in the series rename the file to core.c? At least
> that way 'git log --follow fs/iomap/core.c' will walk back into the
> current history of fs/iomap/apply.c and the older pre-disaggregation
> fs/iomap.c without having to take the tree back in time to find
> those files...

...or put the new code in apply.c, remove iomap_apply, and don't bother
with the renaming at all?

I don't see much reason to break the git history.  This is effectively a
new epoch in iomap, but that is plainly obvious from the function
declarations.

I'll wander through the rest of the unreviewed patches tomorrow morning,
these are merely my off-the-cuff impressions.

--D

> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
