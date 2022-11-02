Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37BB16170A5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Nov 2022 23:26:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbiKBW0t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Nov 2022 18:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbiKBW0s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Nov 2022 18:26:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69937D46;
        Wed,  2 Nov 2022 15:26:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 23B5EB82528;
        Wed,  2 Nov 2022 22:26:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9624C433C1;
        Wed,  2 Nov 2022 22:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667428002;
        bh=bFP4y4pUiAHW9UlgGRp5aQlBXyZWaJ/iFcebHfuRbEY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WBAHmHOy55O11jODtVUKQooNEYFUhZ0qwY3l1g9hpiBT1h92wrQB0WT7aQ9nVFwpa
         E6F/Y3lq3Yr6BJEbXZgfZu0e5p5mFS4f9rzFpHftjSEYm6PonuQ24cUt5LBArs5fB0
         Zd78KE9F+IIDv/P/o+Cy6NFPczEYmayl66IRmMDC7xvudnI8QEr2EX+W/6SmNf/xzC
         OPxQsaLwl7JEm8/PC9TPLPDD6QEupH9AdKnO0pfn4j/89liXhUWks6fck0BptBWk/S
         O22k4XU3hlLrcUy7/UYNTUdhs8+K7xHli8hFf2LDdI8xr18xRBsNv2WbZjtcMV/a6i
         D2DmxZrFJDi4Q==
Date:   Wed, 2 Nov 2022 15:26:42 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 4/7] xfs: buffered write failure should not truncate the
 page cache
Message-ID: <Y2LuogWYlbkpcoHD@magnolia>
References: <20221101003412.3842572-1-david@fromorbit.com>
 <20221101003412.3842572-5-david@fromorbit.com>
 <Y2KdumAbAF0mV0sh@magnolia>
 <20221102210433.GZ3600936@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221102210433.GZ3600936@dread.disaster.area>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 03, 2022 at 08:04:33AM +1100, Dave Chinner wrote:
> On Wed, Nov 02, 2022 at 09:41:30AM -0700, Darrick J. Wong wrote:
> > On Tue, Nov 01, 2022 at 11:34:09AM +1100, Dave Chinner wrote:
> > > From: Dave Chinner <dchinner@redhat.com>
> > > 
> > > xfs_buffered_write_iomap_end() currently invalidates the page cache
> > > over the unused range of the delalloc extent it allocated. While the
> > > write allocated the delalloc extent, it does not own it exclusively
> > > as the write does not hold any locks that prevent either writeback
> > > or mmap page faults from changing the state of either the page cache
> > > or the extent state backing this range.
> > > 
> > > Whilst xfs_bmap_punch_delalloc_range() already handles races in
> > > extent conversion - it will only punch out delalloc extents and it
> > > ignores any other type of extent - the page cache truncate does not
> > > discriminate between data written by this write or some other task.
> > > As a result, truncating the page cache can result in data corruption
> > > if the write races with mmap modifications to the file over the same
> > > range.
> > > 
> > > generic/346 exercises this workload, and if we randomly fail writes
> > > (as will happen when iomap gets stale iomap detection later in the
> > > patchset), it will randomly corrupt the file data because it removes
> > > data written by mmap() in the same page as the write() that failed.
> > > 
> > > Hence we do not want to punch out the page cache over the range of
> > > the extent we failed to write to - what we actually need to do is
> > > detect the ranges that have dirty data in cache over them and *not
> > > punch them out*.
> > 
> > Same dumb question as hch -- why do we need to punch out the nondirty
> > pagecache after a failed write?  If the folios are uptodate then we're
> > evicting cache unnecessarily, and if they're !uptodate can't we let
> > reclaim do the dirty work for us?
> 
> Sorry, we don't punch out the page cache  - this was badly worded. I
> meant:
> 
> "[...] - what we actually need to do is
> detect the ranges that have dirty data in cache over the delalloc
> extent and retain those regions of the delalloc extent."
> 
> i.e. we never punch the page cache anymore, and we only selectively
> punch the delalloc extent that back the clean regions of thw write
> range...

Ah ok.  I was thinking there was a discrepancy between the description
in the commit message and the code, but then I zoomed out and asked
myself why dump the pagecache at all...

> > I don't know if there are hysterical raisins for this or if the goal is
> > to undo memory consumption after a write failure?  If we're stale-ing
> > the write because the iomapping changed, why not leave the folio where
> > it is, refresh the iomapping, and come back to (possibly?) the same
> > folio?
> 
> I can't say for certain - I haven't gone an looked at the history.
> I suspect it goes back to the days where write() could write zeroes
> into the page cache for eof zeroing or zeroing for file extension
> before the write() started writing data. Maybe that was part of what
> it was trying to undo?

Yeah, I dunno, but it certainly looks like it might be an attempt to
undo the effects of posteof zeroing if the write fails.  Back in 2.6.36
days, commit 155130a4f784 ("get rid of block_write_begin_newtrunc")
changed xfs_vm_write_begin to truncate any posteof areas after a failed
write.  This was part of some sort of "new truncate sequence" that
itself got fixed and patched various times after that.

In 4.8, commit 68a9f5e7007c ("xfs: implement iomap based buffered write
path") changed this truncation to the unprocessed part of a short write,
even if it wasn't posteof.  The commit says it's part of a broad
rewrite, but doesn't mention anything about that particular change.

/me shrugs

--D

> -Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
