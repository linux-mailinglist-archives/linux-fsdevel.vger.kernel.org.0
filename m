Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFD8B6143B8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Nov 2022 04:39:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbiKADjP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Oct 2022 23:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiKADjO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Oct 2022 23:39:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 376F7EE05;
        Mon, 31 Oct 2022 20:39:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA95F614C3;
        Tue,  1 Nov 2022 03:39:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36759C433B5;
        Tue,  1 Nov 2022 03:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667273952;
        bh=/LfRLrhx456LTdLay34Ew8rVFiuA5qJyFGA2PdjwWks=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cEcKDSQ+cFYAyB2B0B9GvWeSjQ8OsQxchh9lo9/2E5MYiGj9ee2k1QjbjMH2ZW4E6
         zkMUrz0f/Ck9mPstVDuwfogkrEl/Aw4FieRA2GjvxNNAqTokDGEgHjEIIvOGVVaD/M
         fLDEL75dUOa081x+zzDYBhK8vMKwbOvYmiMI62wsMXMB3yQhP1J728BHLPgTWj8leU
         U8+KDms226xZ8QQVDmZoBURMZe9NH4MK7/19WO9faipBh2rZtJIkU/R0gyMpr3c+th
         hsg/0u1JP0XmUCb/Vs6aaCSs66Jh85W05Eqc8l6IDtaEjvm3wR/hiVgDoBkSkrmFzm
         bbDn3U8Qk2jQQ==
Date:   Mon, 31 Oct 2022 20:39:11 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: xfs, iomap: fix data corrupton due to stale cached iomaps
Message-ID: <Y2CU3zm/qxajHRp+@magnolia>
References: <20221101003412.3842572-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221101003412.3842572-1-david@fromorbit.com>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 01, 2022 at 11:34:05AM +1100, Dave Chinner wrote:
> Recently a customer workload encountered a data corruption in a
> specific multi-threaded write operation. The workload combined
> racing unaligned adjacent buffered writes with low memory conditions
> that caused both writeback and memory reclaim to race with the
> writes.
> 
> The result of this was random partial blocks containing zeroes
> instead of the correct data.  The underlying problem is that iomap
> caches the write iomap for the duration of the write() operation,
> but it fails to take into account that the extent underlying the
> iomap can change whilst the write is in progress.

Wheeeee....

> The short story is that an iomap can span mutliple folios, and so
> under low memory writeback can be cleaning folios the write()
> overlaps. Whilst the overlapping data is cached in memory, this
> isn't a problem, but because the folios are now clean they can be
> reclaimed. Once reclaimed, the write() does the wrong thing when
> re-instantiating partial folios because the iomap no longer reflects
> the underlying state of the extent. e.g. it thinks the extent is
> unwritten, so it zeroes the partial range, when in fact the
> underlying extent is now written and so it should have read the data

DOH!!

> from disk.  This is how we get random zero ranges in the file
> instead of the correct data.
> 
> The gory details of the race condition can be found here:
> 
> https://lore.kernel.org/linux-xfs/20220817093627.GZ3600936@dread.disaster.area/
> 
> Fixing the problem has two aspects. The first aspect of the problem
> is ensuring that iomap can detect a stale cached iomap during a
> write in a race-free manner. We already do this stale iomap
> detection in the writeback path, so we have a mechanism for
> detecting that the iomap backing the data range may have changed
> and needs to be remapped.
> 
> In the case of the write() path, we have to ensure that the iomap is
> validated at a point in time when the page cache is stable and
> cannot be reclaimed from under us. We also need to validate the
> extent before we start performing any modifications to the folio
> state or contents. Combine these two requirements together, and the
> only "safe" place to validate the iomap is after we have looked up
> and locked the folio we are going to copy the data into, but before
> we've performed any initialisation operations on that folio.
> 
> If the iomap fails validation, we then mark it stale, unlock the
> folio and end the write. This effectively means a stale iomap
> results in a short write.

Does this short write echo all the way out to userspace?  Or do we
merely go 'round iomap_iter() again?

> Filesystems should already be able to
> handle this, as write operations can end short for many reasons and
> need to iterate through another mapping cycle to be completed. Hence
> the iomap changes needed to detect and handle stale iomaps during
> write() operations is relatively simple....
> 
> However, the assumption is that filesystems should already be able
> to handle write failures safely, and that's where the second
> (first?) part of the problem exists. That is, handling a partial
> write is harder than just "punching out the unused delayed
> allocation extent". This is because mmap() based faults can race
> with writes, and if they land in the delalloc region that the write
> allocated, then punching out the delalloc region can cause data
> corruption.
> 
> This data corruption problem is exposed by generic/346 when iomap is
> converted to detect stale iomaps during write() operations. Hence
> write failure in the filesytems needs to handle the fact that the

s/sytems/systems/

> write() in progress doesn't necessarily own the data in the page
> cache over the range of the delalloc extent it just allocated.
> 
> As a result, we can't just truncate the page cache over the range
> the write() didn't reach and punch all the delalloc extent. We have
> to walk the page cache over the untouched range and skip over any
> dirty data region in the cache in that range. Which is ....
> non-trivial.
> 
> That is, iterating the page cache has to handle partially populated
> folios (i.e. block size < page size) that contain data. The data
> might be discontiguous within a folio. Indeed, there might be
> *multiple* discontiguous data regions within a single folio. And to
> make matters more complex, multi-page folios mean we just don't know
> how many sub-folio regions we might have to iterate to find all
> these regions. All the corner cases between the conversions and
> rounding between filesystem block size, folio size and multi-page
> folio size combined with unaligned write offsets kept breaking my
> brain.
> 
> Eventually, I realised that if the XFS code tracked the processed
> write regions by byte ranges instead of fileysetm block or page
> cache index, we could simply use mapping_seek_hole_data() to find
> the start and end of each discrete data region within the range we
> needed to scan. SEEK_DATA finds the start of the cached data region,
> SEEK_HOLE finds the end of the region. THese are byte based
> interfaces that understand partially uptodate folio regions, and so
> can iterate discrete sub-folio data regions directly. This largely
> solved the problem of discovering the dirty regions we need to keep
> the delalloc extent over.

Heh.  Clever!

> Of course, now xfs/196 fails. This is a error injection test that is
> supposed to exercise the delalloc extent recover code that the above
> fixes just completely reworked. the error injection assumes that it
> can just truncate the page cache over the write and then punch out
> the delalloc extent completely. This is fundamentally broken, and
> only has been working by chance - the chance is that writes are page
> aligned and page aligned writes don't install large folios in the
> page cache.

Side question -- should we introduce a couple of debug knobs to slow
down page cache write and writeback so that we can make it easier to
(cough) experiment with races?

Now that we've been bitten hard by the writeback race, I wrote a
testcase to exercise it.  The problem was solved long ago so the only
way you can tell its working is to inject debugging printks and look for
them, but I feel like we ought to have test points for these two serious
corruption problems.

> IOWs, with sub-folio block size, and not know what size folios are
> in the cache, we can't actually guarantee that we can remove the

Is that supposed to read "...and not knowing what size folios..."?

> cached dirty folios from the cache via truncation, and hence the new
> code will not remove the delalloc extents under those dirty folios.
> As a result the error injection results is writing zeroes to disk
> rather that removing the delalloc extents from memory. I can't make

rather *than*?

> this error injection to work the way it was intended, so I removed
> it. The code that it is supposed to exercise is now exercised every time we
> detect a stale iomap, so we have much better coverage of the failed
> write error handling than the error injection provides us with,
> anyway....
> 
> So, this passes fstests on 1kb and 4kb block sizes and the data
> corruption reproducer does not detect data corruption, so this set
> of fixes is /finally/ something I'd consider ready for merge.
> Comments and testing welcome!

Urrrk.  Thank you for your work on this. :)

/me functionally braindead on halloween candy, will read the code
tomorrow.  Well ok we'll see how long it takes curiosity to get the
better of me...

--D

> -Dave.
> 
> Version 1:
> - complete rework of iomap stale detection
> - complete rework of XFS partial delalloc write error handling.
> 
> Original RFC:
> - https://lore.kernel.org/linux-xfs/20220921082959.1411675-1-david@fromorbit.com/
> 
> 
