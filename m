Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 608E863E8B2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Dec 2022 04:59:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbiLAD7o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Nov 2022 22:59:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiLAD7n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Nov 2022 22:59:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679D497913;
        Wed, 30 Nov 2022 19:59:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0EF5EB81DC8;
        Thu,  1 Dec 2022 03:59:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C07A6C433D6;
        Thu,  1 Dec 2022 03:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669867179;
        bh=mk2uzIOw2PmOIDLp2j0wd/RvWHXF0sTLsxuBpMlb8oc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oQxC0tORfHCGqELEG/9QJeh+Z8salDxYyRydv8UdbNF4P45iQ2YRNY/T9jzdzfHuF
         Dz7GT/NP8hofKB2X0kV/mnIPV42Mx+EduK6QcawmLrtjJ+uTnhKa8xUNzW4pDZe3Er
         QA2d5hI81BK2vIRnErzIWA6pWfAX8Dz59P91jRUs08UEbTsysU8YzIyYKkVcBvt8Rk
         JXUdx6uCWSWaEcnA9mM/bWaKN/jl3VPApvLNlHNbm1MlEHhkp5iUiC7EgXs42ng1/h
         bRRIU5YjIPwK65lWlHwAaNhvhO6bAk5vG4L1wN9shSF2ZiKPGDJZmugXBjZDy9UwZB
         6RFfvMw8cr+ig==
Date:   Wed, 30 Nov 2022 19:59:39 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] [RFC] iomap: zeroing needs to be pagecache aware
Message-ID: <Y4gmqy6FfFTUInmP@magnolia>
References: <20221201005214.3836105-1-david@fromorbit.com>
 <Y4gMhHsGriqPhNsR@magnolia>
 <20221201024329.GN3600936@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221201024329.GN3600936@dread.disaster.area>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 01, 2022 at 01:43:29PM +1100, Dave Chinner wrote:
> On Wed, Nov 30, 2022 at 06:08:04PM -0800, Darrick J. Wong wrote:
> > On Thu, Dec 01, 2022 at 11:52:14AM +1100, Dave Chinner wrote:
> > > From: Dave Chinner <dchinner@redhat.com>
> > > 
> > > Unwritten extents can have page cache data over the range being
> > > zeroed so we can't just skip them entirely. Fix this by checking for
> > > an existing dirty folio over the unwritten range we are zeroing
> > > and only performing zeroing if the folio is already dirty.
> > 
> > Hm, I'll look at this tomorrow morning when I'm less bleary.  From a
> > cursory glance it looks ok though.
> > 
> > > XXX: how do we detect a iomap containing a cow mapping over a hole
> > > in iomap_zero_iter()? The XFS code implies this case also needs to
> > > zero the page cache if there is data present, so trigger for page
> > > cache lookup only in iomap_zero_iter() needs to handle this case as
> > > well.
> > 
> > I've been wondering for a while if we ought to rename iomap_iter.iomap
> > to write_iomap and iomap_iter.srcmap to read_iomap, and change all the
> > ->iomap_begin and ->iomap_end functions as needed.  I think that would
> > make it more clear to iomap users which one they're supposed to use.
> > Right now we overload iomap_iter.iomap for reads and for writes if
> > srcmap is a hole (or SHARED isn't set on iomap) and it's getting
> > confusing to keep track of all that.
> 
> *nod*
> 
> We definitely need to clarify this - I find the overloading
> confusing at the best of times.  No idea what the solution to this
> looks like, though...

<nod> It probably means a largeish cleanup for 6.3.  Maybe start with
the patches I'd sent earlier that shortened the ->iomap_begin and
->iomap_end parameter list, and move on to redefining the two?

https://lore.kernel.org/linux-xfs/166801778962.3992140.13451716594530581376.stgit@magnolia/
https://lore.kernel.org/linux-xfs/166801779522.3992140.4135946031734299717.stgit@magnolia/


> > I guess the hard part of all that is that writes to the pagecache don't
> > touch storage; and writeback doesn't care about the source mapping since
> > it's only using block granularity.
> 
> Yup, that's why this code needs the IOMAP_F_STALE code to be in
> place before we can use the page cache lookups like this.

Well it's in for-next now, so it'll land in 6.2.

--D

> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
