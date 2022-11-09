Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD3FF623220
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Nov 2022 19:15:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbiKISPw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Nov 2022 13:15:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbiKISPt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Nov 2022 13:15:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F3A264A7;
        Wed,  9 Nov 2022 10:15:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D349FB81F69;
        Wed,  9 Nov 2022 18:15:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56E15C433C1;
        Wed,  9 Nov 2022 18:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668017745;
        bh=DNmgBwbEXJOUhB20I3YI6I2cJUdkbhcyYLUOvEpVN2c=;
        h=Subject:From:To:Cc:Date:From;
        b=Neh7jlxVSoCwYp365KNGEKzuZ7/MhpLhcXiJbt0l48XzLAWyVLXi+RhbpHGX+hKZk
         EYAMSorAM+nLieHVDYtGxwbVLe0d+BI4dKCg8cG23SazaJ6x6pQusOFbs9506SJ+DM
         3+hAja5g+3KgTpVpfo6Pat5nI1e6DoJr7qvN296532dZXK11MgSORPYalOeyc4tDZQ
         0XVzfC8x2wLsB0STcXiEYt94rRNhlqPvE+ocd7/FC+tD039IFr3YEKeSEvzBDhG6aL
         Hm6guj76TN6thCKw68CfJXBfFYbvCGGIPC/t3YUXyFW69ouCqxlVSnlGnIIoUPY22R
         rPbbBmxRuIWPg==
Subject: [PATCHSET RFCRAP v2 00/14] xfs,
 iomap: fix data corruption due to stale cached iomaps
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     Christoph Hellwig <hch@lst.de>, Dave Chinner <dchinner@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        david@fromorbit.com, hch@infradead.org
Date:   Wed, 09 Nov 2022 10:15:44 -0800
Message-ID: <166801774453.3992140.241667783932550826.stgit@magnolia>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

This is my adaptation of Dave's last RFC.  Dave's patches are unchanged
except for exporting mapping_seek_hole_data to fix a compilation error.

The last seven patches of the series are where I change things up.  The
first two patches refactor ->iomap_begin and ->iomap_end to receive a
const pointer to the iterator, which reduces the argument count and
makes it possible for ->iomap_begin to access the iter->private pointer.
The third new patch changes the iomap pagecache write functions to
enable the filesystem to set iter->private, similar to iomap_dio_rw.

Having done that, I converted the xfs code to stuff the data/cow
sequence counters in an iter->private object instead of bit stuffing
them into the iomap->private pointer.  Maybe it would've been smarter to
make filesystems tell iomap about their notions of how large struct
iomap objects should be (thereby enabling each fs to cram extra data
along in the iomap) but that seemed like more work.

So having replaced the iomap sequence counters with an explicit object,
I then made the validator check the cow fork.  Not sure if it's really
necessary, but paranoia on my part.  I /think/ it's the case that
updates to the cow fork don't affect writing to the page cache, but I've
wondered if the same validation rules might apply to other things (like
directio writes).

Lastly, I added a couple of write/writeback delay knobs so that I could
write some tests that simulate race conditions and check that slow
threads encounter iomap invalidation midway through an operation.

I haven't gotten to analyzing Brian's eofblock truncate fixes yet, but I
wanted to push this out for comments since it's now survived an
overnight fstests run.

NOTE: I don't have RH's original reproducer, so I have no idea if this
series really fixes that corruption problem.
----
Recently a customer workload encountered a data corruption in a
specific multi-threaded write operation. The workload combined
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
write() operations is relatively simple....

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

Eventually, I realised that if the XFS code tracked the processed
write regions by byte ranges instead of fileysetm block or page
cache index, we could simply use mapping_seek_hole_data() to find
the start and end of each discrete data region within the range we
needed to scan. SEEK_DATA finds the start of the cached data region,
SEEK_HOLE finds the end of the region. THese are byte based
interfaces that understand partially uptodate folio regions, and so
can iterate discrete sub-folio data regions directly. This largely
solved the problem of discovering the dirty regions we need to keep
the delalloc extent over.

Of course, now xfs/196 fails. This is a error injection test that is
supposed to exercise the delalloc extent recover code that the above
fixes just completely reworked. the error injection assumes that it
can just truncate the page cache over the write and then punch out
the delalloc extent completely. This is fundamentally broken, and
only has been working by chance - the chance is that writes are page
aligned and page aligned writes don't install large folios in the
page cache.

IOWs, with sub-folio block size, and not know what size folios are
in the cache, we can't actually guarantee that we can remove the
cached dirty folios from the cache via truncation, and hence the new
code will not remove the delalloc extents under those dirty folios.
As a result the error injection results is writing zeroes to disk
rather that removing the delalloc extents from memory. I can't make
this error injection to work the way it was intended, so I removed
it. The code that it is supposed to exercise is now exercised every time we
detect a stale iomap, so we have much better coverage of the failed
write error handling than the error injection provides us with,
anyway....

So, this passes fstests on 1kb and 4kb block sizes and the data
corruption reproducer does not detect data corruption, so this set
of fixes is /finally/ something I'd consider ready for merge.
Comments and testing welcome!

-Dave.

Version 2:
- refactor iomap code a lot, track data/cow sequence counters separately,
  add debugging knobs so we can test the revalidation [djwong]

Version 1:
- complete rework of iomap stale detection
- complete rework of XFS partial delalloc write error handling.

Original RFC:
- https://lore.kernel.org/linux-xfs/20220921082959.1411675-1-david@fromorbit.com/

If you're going to start using this mess, you probably ought to just
pull from my git trees, which are linked below.

This is an extraordinary way to destroy everything.  Enjoy!
Comments and questions are, as always, welcome.

--D

kernel git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=iomap-write-races-6.2
---
 fs/btrfs/inode.c             |   18 +-
 fs/erofs/data.c              |   12 +
 fs/erofs/zmap.c              |    6 -
 fs/ext2/inode.c              |   16 +-
 fs/ext4/extents.c            |    5 -
 fs/ext4/inode.c              |   38 +++-
 fs/f2fs/data.c               |    9 +
 fs/fuse/dax.c                |   14 +-
 fs/gfs2/bmap.c               |   28 ++-
 fs/gfs2/file.c               |    2 
 fs/hpfs/file.c               |    8 +
 fs/iomap/buffered-io.c       |   67 ++++++--
 fs/iomap/iter.c              |   27 ++-
 fs/xfs/libxfs/xfs_bmap.c     |    4 
 fs/xfs/libxfs/xfs_errortag.h |   18 +-
 fs/xfs/xfs_aops.c            |   12 +
 fs/xfs/xfs_error.c           |   43 ++++-
 fs/xfs/xfs_error.h           |   22 ++
 fs/xfs/xfs_file.c            |    5 -
 fs/xfs/xfs_iomap.c           |  371 ++++++++++++++++++++++++++++++++++--------
 fs/xfs/xfs_iomap.h           |    7 +
 fs/xfs/xfs_reflink.c         |    3 
 fs/zonefs/super.c            |   27 ++-
 include/linux/iomap.h        |   34 +++-
 mm/filemap.c                 |    1 
 25 files changed, 610 insertions(+), 187 deletions(-)

