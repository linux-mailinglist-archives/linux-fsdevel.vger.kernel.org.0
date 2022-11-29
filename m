Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E28F163B673
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Nov 2022 01:16:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234663AbiK2AQk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Nov 2022 19:16:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234584AbiK2AQh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Nov 2022 19:16:37 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE2941DDC2
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Nov 2022 16:16:36 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id k5so11094476pjo.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Nov 2022 16:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rmT4p4LUlgKisuvS5tqZbtaFiBayJl0Eii/OEnGHHtU=;
        b=tS0jlh80ya4JjgLjJkratxjwUQtwsJQ2uzig/9jrTFeTv6hzDbwbdiCwUogq75pSh1
         tQ1QBpFoi/zAFhKfKq0mdpPwXMUNF85xOpaWwPh7t64FqCnm42OVKWXWE9vTWCY3wGoj
         Hv4G3jWw9KYdtfRX08q4wTQBn9lP/oi5zbPD+MUBtNBAc5vE0Wxw6+QaVTe5cKjMuvaE
         Cbpkgd5hXOiAbqcvvtszCD+aivtEc7x4MLcy0KMqnSoxu4LekuSFOEDF7sCCUpmP0aN3
         bAzYnLWfegFRHx8EOoxpJ5XLtMnAXZLvQ2Sz+DIvqE6YTNepx+7C1vu98xZ7eFYQqHpt
         HtRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rmT4p4LUlgKisuvS5tqZbtaFiBayJl0Eii/OEnGHHtU=;
        b=NiGobJJhfaeirSnEEFGi5vRlZ0DL0zSJriHTJmd2tjrAGasgOgUmGs1vipRHnZZ4KK
         1rStQjuG4rg4NBI5AXEnb2b7DVuFvtPAZCEMGhKcVA+SlLdQ+NBxfkcu1+Mg2tnsSQjw
         zCexDOTX8aPKBHXwiOHzS6yhIBgAOUqEajHqWM2qqDcevdILbSembGCI0zHICvDMpeMh
         SiN8KiFzUPbaIQQJehRmPggEHCHXOrcFNWYbTBGhmuN0Io/p5PRjgMn5eAs5a92MHmcF
         RLo81qja+QipUP/m7Uy59FkUjh6woCxnlIwHyH3NgkXX+i1TLmOtfcOiAk0XGACiqN4G
         x7nQ==
X-Gm-Message-State: ANoB5pmyBc4WDaa450ZdqIYfXADOiLGLdM6lSoj9OEvuhWg9xK4bIEQy
        l5PabcAtmVNRScO6bajkTr6BNw==
X-Google-Smtp-Source: AA0mqf5+RMi8gPwujU5z/tOoNaZz4hNMrZtCkUI2nZql1qYR4idryLE601Q51u0M21dSkajfM6LruQ==
X-Received: by 2002:a17:902:bb10:b0:189:6292:827e with SMTP id im16-20020a170902bb1000b001896292827emr21668249plb.97.1669680996313;
        Mon, 28 Nov 2022 16:16:36 -0800 (PST)
Received: from dread.disaster.area (pa49-186-65-106.pa.vic.optusnet.com.au. [49.186.65.106])
        by smtp.gmail.com with ESMTPSA id y22-20020a170902b49600b0018099c9618esm9388374plr.231.2022.11.28.16.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 16:16:35 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1ozoIa-002E5Z-Cw; Tue, 29 Nov 2022 11:16:32 +1100
Date:   Tue, 29 Nov 2022 11:16:32 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] xfs, iomap: fix data corruption due to stale cached iomaps
Message-ID: <20221129001632.GX3600936@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Darrick,

Can you please pull the data corruption fix from the tag below? The
only change since the last posting was to remove the unused error
variable from the iomap punch code. I haven't seen any regressions
in local testing over the past week, so I think it is good to go.

-Dave.

------

The following changes since commit f0c4d9fc9cc9462659728d168387191387e903cc:

  Linux 6.1-rc4 (2022-11-06 15:07:11 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dgc/linux-xfs tags/xfs-iomap-stale-fixes

for you to fetch changes up to 6e8af15ccdc4e138a5b529c1901a0013e1dcaa09:

  xfs: drop write error injection is unfixable, remove it (2022-11-29 09:09:17 +1100)

----------------------------------------------------------------
xfs, iomap: fix data corruption due to stale cached iomaps

This patch series fixes a data corruption that occurs in a specific
multi-threaded write workload. The workload combined
racing unaligned adjacent buffered writes with low memory conditions
that caused both writeback and memory reclaim to race with the
writes.

The result of this was random partial blocks containing zeroes
instead of the correct data.  The underlying problem is that iomap
caches the write iomap for the duration of the write() operation,
but it fails to take into account that the extent underlying the
iomap can change whilst the write is in progress.

The short story is that an iomap can span mutliple folios, and so
under low memory writeback can be cleaning folios the write()
overlaps. Whilst the overlapping data is cached in memory, this
isn't a problem, but because the folios are now clean they can be
reclaimed. Once reclaimed, the write() does the wrong thing when
re-instantiating partial folios because the iomap no longer reflects
the underlying state of the extent. e.g. it thinks the extent is
unwritten, so it zeroes the partial range, when in fact the
underlying extent is now written and so it should have read the data
from disk.  This is how we get random zero ranges in the file
instead of the correct data.

The gory details of the race condition can be found here:

https://lore.kernel.org/linux-xfs/20220817093627.GZ3600936@dread.disaster.area/

Fixing the problem has two aspects. The first aspect of the problem
is ensuring that iomap can detect a stale cached iomap during a
write in a race-free manner. We already do this stale iomap
detection in the writeback path, so we have a mechanism for
detecting that the iomap backing the data range may have changed
and needs to be remapped.

In the case of the write() path, we have to ensure that the iomap is
validated at a point in time when the page cache is stable and
cannot be reclaimed from under us. We also need to validate the
extent before we start performing any modifications to the folio
state or contents. Combine these two requirements together, and the
only "safe" place to validate the iomap is after we have looked up
and locked the folio we are going to copy the data into, but before
we've performed any initialisation operations on that folio.

If the iomap fails validation, we then mark it stale, unlock the
folio and end the write. This effectively means a stale iomap
results in a short write. Filesystems should already be able to
handle this, as write operations can end short for many reasons and
need to iterate through another mapping cycle to be completed. Hence
the iomap changes needed to detect and handle stale iomaps during
write() operations is relatively simple...

However, the assumption is that filesystems should already be able
to handle write failures safely, and that's where the second
(first?) part of the problem exists. That is, handling a partial
write is harder than just "punching out the unused delayed
allocation extent". This is because mmap() based faults can race
with writes, and if they land in the delalloc region that the write
allocated, then punching out the delalloc region can cause data
corruption.

This data corruption problem is exposed by generic/346 when iomap is
converted to detect stale iomaps during write() operations. Hence
write failure in the filesytems needs to handle the fact that the
write() in progress doesn't necessarily own the data in the page
cache over the range of the delalloc extent it just allocated.

As a result, we can't just truncate the page cache over the range
the write() didn't reach and punch all the delalloc extent. We have
to walk the page cache over the untouched range and skip over any
dirty data region in the cache in that range. Which is ....
non-trivial.

That is, iterating the page cache has to handle partially populated
folios (i.e. block size < page size) that contain data. The data
might be discontiguous within a folio. Indeed, there might be
*multiple* discontiguous data regions within a single folio. And to
make matters more complex, multi-page folios mean we just don't know
how many sub-folio regions we might have to iterate to find all
these regions. All the corner cases between the conversions and
rounding between filesystem block size, folio size and multi-page
folio size combined with unaligned write offsets kept breaking my
brain.

However, if we convert the code to track the processed
write regions by byte ranges instead of fileystem block or page
cache index, we could simply use mapping_seek_hole_data() to find
the start and end of each discrete data region within the range we
needed to scan. SEEK_DATA finds the start of the cached data region,
SEEK_HOLE finds the end of the region. These are byte based
interfaces that understand partially uptodate folio regions, and so
can iterate discrete sub-folio data regions directly. This largely
solved the problem of discovering the dirty regions we need to keep
the delalloc extent over.

However, to use mapping_seek_hole_data() without needing to export
it, we have to move all the delalloc extent cleanup to the iomap
core and so now the iomap core can clean up delayed allocation
extents in a safe, sane and filesystem neutral manner.

With all this done, the original data corruption never occurs
anymore, and we now have a generic mechanism for ensuring that page
cache writes do not do the wrong thing when writeback and reclaim
change the state of the physical extent and/or page cache contents
whilst the write is in progress.

Signed-off-by: Dave Chinner <dchinner@redhat.com>

----------------------------------------------------------------
Dave Chinner (9):
      xfs: write page faults in iomap are not buffered writes
      xfs: punching delalloc extents on write failure is racy
      xfs: use byte ranges for write cleanup ranges
      xfs,iomap: move delalloc punching to iomap
      iomap: buffered write failure should not truncate the page cache
      xfs: xfs_bmap_punch_delalloc_range() should take a byte range
      iomap: write iomap validity checks
      xfs: use iomap_valid method to detect stale cached iomaps
      xfs: drop write error injection is unfixable, remove it

 fs/iomap/buffered-io.c       | 254 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 fs/iomap/iter.c              |  19 +++++++++-
 fs/xfs/libxfs/xfs_bmap.c     |   6 ++-
 fs/xfs/libxfs/xfs_errortag.h |  12 +++---
 fs/xfs/xfs_aops.c            |  18 ++++-----
 fs/xfs/xfs_bmap_util.c       |  10 +++--
 fs/xfs/xfs_bmap_util.h       |   2 +-
 fs/xfs/xfs_error.c           |  27 +++++++++----
 fs/xfs/xfs_file.c            |   2 +-
 fs/xfs/xfs_iomap.c           | 169 +++++++++++++++++++++++++++++++++++++++++++++++++---------------------------------
 fs/xfs/xfs_iomap.h           |   6 ++-
 fs/xfs/xfs_pnfs.c            |   6 ++-
 include/linux/iomap.h        |  47 +++++++++++++++++++----
 13 files changed, 464 insertions(+), 114 deletions(-)
-- 
Dave Chinner
david@fromorbit.com
