Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35DB7616A93
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Nov 2022 18:23:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbiKBRXt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Nov 2022 13:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbiKBRXs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Nov 2022 13:23:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A2D024BF2;
        Wed,  2 Nov 2022 10:23:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 961F1B80DA8;
        Wed,  2 Nov 2022 17:23:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35F29C433C1;
        Wed,  2 Nov 2022 17:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667409824;
        bh=aqcgGqxnSnOLRI/oAbZFoByrjSdzXmsI4scj3Hc+sxE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D6RmP1YYOw6vPidkSC3tQRvuK0v1z418alttsHZLjzY5aT+zAbsr3TLOeCgkR+asr
         N2cjrXfeXPNPFYHpXhiTdK7Kgl0bR2Acs/kkshupYarLfOrPQssIp77KfHKyPqJQtY
         NSQNl7A2buvN1eKFvG9Q2uLJATUiSKxUGtF9UmXZPx5puiu5Fd+VehJ7+uwl5T1RW6
         GBQ+HLqwU1/l1BEr3W1pfNAYbvYBvYyyi+dNsG8DhqOTM8s25JmW9NajovlKrwVcEa
         qJD/D0eRTH0lYXiZTQq88lGXOGRZowlyVVIY/x52+qZGJ2z4GojD+d+mT/RqcgnG2R
         y2y/3P67Q2Cng==
Date:   Wed, 2 Nov 2022 10:23:43 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: xfs, iomap: fix data corrupton due to stale cached iomaps
Message-ID: <Y2Knn6+m8kxCnMoQ@magnolia>
References: <20221101003412.3842572-1-david@fromorbit.com>
 <Y2CU3zm/qxajHRp+@magnolia>
 <20221101042150.GN3600936@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221101042150.GN3600936@dread.disaster.area>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 01, 2022 at 03:21:50PM +1100, Dave Chinner wrote:
> On Mon, Oct 31, 2022 at 08:39:11PM -0700, Darrick J. Wong wrote:
> > On Tue, Nov 01, 2022 at 11:34:05AM +1100, Dave Chinner wrote:
> > > Recently a customer workload encountered a data corruption in a
> > > specific multi-threaded write operation. The workload combined
> > > racing unaligned adjacent buffered writes with low memory conditions
> > > that caused both writeback and memory reclaim to race with the
> > > writes.
> > > 
> > > The result of this was random partial blocks containing zeroes
> > > instead of the correct data.  The underlying problem is that iomap
> > > caches the write iomap for the duration of the write() operation,
> > > but it fails to take into account that the extent underlying the
> > > iomap can change whilst the write is in progress.
> > 
> > Wheeeee....
> > 
> > > The short story is that an iomap can span mutliple folios, and so
> > > under low memory writeback can be cleaning folios the write()
> > > overlaps. Whilst the overlapping data is cached in memory, this
> > > isn't a problem, but because the folios are now clean they can be
> > > reclaimed. Once reclaimed, the write() does the wrong thing when
> > > re-instantiating partial folios because the iomap no longer reflects
> > > the underlying state of the extent. e.g. it thinks the extent is
> > > unwritten, so it zeroes the partial range, when in fact the
> > > underlying extent is now written and so it should have read the data
> > 
> > DOH!!
> > 
> > > from disk.  This is how we get random zero ranges in the file
> > > instead of the correct data.
> > > 
> > > The gory details of the race condition can be found here:
> > > 
> > > https://lore.kernel.org/linux-xfs/20220817093627.GZ3600936@dread.disaster.area/
> > > 
> > > Fixing the problem has two aspects. The first aspect of the problem
> > > is ensuring that iomap can detect a stale cached iomap during a
> > > write in a race-free manner. We already do this stale iomap
> > > detection in the writeback path, so we have a mechanism for
> > > detecting that the iomap backing the data range may have changed
> > > and needs to be remapped.
> > > 
> > > In the case of the write() path, we have to ensure that the iomap is
> > > validated at a point in time when the page cache is stable and
> > > cannot be reclaimed from under us. We also need to validate the
> > > extent before we start performing any modifications to the folio
> > > state or contents. Combine these two requirements together, and the
> > > only "safe" place to validate the iomap is after we have looked up
> > > and locked the folio we are going to copy the data into, but before
> > > we've performed any initialisation operations on that folio.
> > > 
> > > If the iomap fails validation, we then mark it stale, unlock the
> > > folio and end the write. This effectively means a stale iomap
> > > results in a short write.
> > 
> > Does this short write echo all the way out to userspace?  Or do we
> > merely go 'round iomap_iter() again?
> 
> It triggers another iomap_iter() loop because we haven't consumed
> the data in the iov_iter yet. It essentially advances the iter to
> the end of the short write and runs another begin/write iter/end
> loop to continue the write with a new iomap. The stale flag is
> needed so that a "no bytes written so return to the caller" can be
> distinguished from "no bytes written because the iomap was
> immediately found to be stale so we need to loop again to remap it".

<nod> Now that I've read the patches with fresh eyes, I've seen that. :)

> > > write() in progress doesn't necessarily own the data in the page
> > > cache over the range of the delalloc extent it just allocated.
> > > 
> > > As a result, we can't just truncate the page cache over the range
> > > the write() didn't reach and punch all the delalloc extent. We have
> > > to walk the page cache over the untouched range and skip over any
> > > dirty data region in the cache in that range. Which is ....
> > > non-trivial.
> > > 
> > > That is, iterating the page cache has to handle partially populated
> > > folios (i.e. block size < page size) that contain data. The data
> > > might be discontiguous within a folio. Indeed, there might be
> > > *multiple* discontiguous data regions within a single folio. And to
> > > make matters more complex, multi-page folios mean we just don't know
> > > how many sub-folio regions we might have to iterate to find all
> > > these regions. All the corner cases between the conversions and
> > > rounding between filesystem block size, folio size and multi-page
> > > folio size combined with unaligned write offsets kept breaking my
> > > brain.
> > > 
> > > Eventually, I realised that if the XFS code tracked the processed
> > > write regions by byte ranges instead of fileysetm block or page
> > > cache index, we could simply use mapping_seek_hole_data() to find
> > > the start and end of each discrete data region within the range we
> > > needed to scan. SEEK_DATA finds the start of the cached data region,
> > > SEEK_HOLE finds the end of the region. THese are byte based
> > > interfaces that understand partially uptodate folio regions, and so
> > > can iterate discrete sub-folio data regions directly. This largely
> > > solved the problem of discovering the dirty regions we need to keep
> > > the delalloc extent over.
> > 
> > Heh.  Clever!
> 
> It'd be clever if I didn't take a couple of weeks banging my head
> against continual off-by-one and rounding bugs before I realised
> there was a better way... :(
> 
> > > Of course, now xfs/196 fails. This is a error injection test that is
> > > supposed to exercise the delalloc extent recover code that the above
> > > fixes just completely reworked. the error injection assumes that it
> > > can just truncate the page cache over the write and then punch out
> > > the delalloc extent completely. This is fundamentally broken, and
> > > only has been working by chance - the chance is that writes are page
> > > aligned and page aligned writes don't install large folios in the
> > > page cache.
> > 
> > Side question -- should we introduce a couple of debug knobs to slow
> > down page cache write and writeback so that we can make it easier to
> > (cough) experiment with races?
> 
> Perhaps so. There was once the equivalent in Irix (dating back as
> far as 1996, IIRC) for this sort of testing.  Search for
> XFSRACEDEBUG in the historic archive, there are:
> 
> #ifdef XFSRACEDEBUG
> 	delay_for_intr();
> 	delay(100);
> #endif
> 
> clauses added and removed regularly in the data and metadata IO
> paths through the early history of the code base....

<nod>

> > Now that we've been bitten hard by the writeback race, I wrote a
> > testcase to exercise it.  The problem was solved long ago so the only
> > way you can tell its working is to inject debugging printks and look for
> > them, but I feel like we ought to have test points for these two serious
> > corruption problems.
> 
> Well, I just assume writeback races with everything and mostly
> everything is OK. What I didn't expect was racing writeback enabling
> racing reclaim to free pages dirtied by a write() before the write() has
> completed (i.e. while it is still dirtying pages and copying data
> into the page cache). i.e. it was the racing page reclaim that exposed
> the data corruption bugs, not writeback.
> 
> As it is, I suspect that we should actually try to run fstests in
> massively constrained memcgs more often - all sorts of problems have
> fallen out of doing this (e.g. finding GFP_KERNEL allocations
> in explicit, known GFP_NOFS contexts)....

FWIW I mentioned on irc yesterday that I tried running fstests with
mem=560M and watched the system fail spectacularly.

OTOH now that fstests can run testcase processes in a scope, that means
we can turn on memcgs with low limits pretty easily.

> > i IOWs, with sub-folio block size, and not know what size folios are
> > > in the cache, we can't actually guarantee that we can remove the
> > 
> > Is that supposed to read "...and not knowing what size folios..."?
> 
> *nod*
> 
> > > cached dirty folios from the cache via truncation, and hence the new
> > > code will not remove the delalloc extents under those dirty folios.
> > > As a result the error injection results is writing zeroes to disk
> > > rather that removing the delalloc extents from memory. I can't make
> > 
> > rather *than*?
> 
> *nod*
> 
> > > this error injection to work the way it was intended, so I removed
> > > it. The code that it is supposed to exercise is now exercised every time we
> > > detect a stale iomap, so we have much better coverage of the failed
> > > write error handling than the error injection provides us with,
> > > anyway....
> > > 
> > > So, this passes fstests on 1kb and 4kb block sizes and the data
> > > corruption reproducer does not detect data corruption, so this set
> > > of fixes is /finally/ something I'd consider ready for merge.
> > > Comments and testing welcome!
> > 
> > Urrrk.  Thank you for your work on this. :)
> > 
> > /me functionally braindead on halloween candy, will read the code
> > tomorrow.  Well ok we'll see how long it takes curiosity to get the
> > better of me...
> 
> Thanks!

(Well, I guess it took a day and a half.)

--D

> 
> -Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
