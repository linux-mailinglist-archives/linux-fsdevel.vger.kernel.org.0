Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 920BF64BC88
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Dec 2022 19:59:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236598AbiLMS7C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Dec 2022 13:59:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236660AbiLMS7B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Dec 2022 13:59:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 269CA22B11;
        Tue, 13 Dec 2022 10:58:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ADD72B815B4;
        Tue, 13 Dec 2022 18:58:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52E0FC433D2;
        Tue, 13 Dec 2022 18:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670957935;
        bh=BuXqOW7whGlNJpOCXwTvzPkNQtOkGJSy0XCEhE9Fz5E=;
        h=Date:From:To:Cc:Subject:From;
        b=c/joB1i65Q48xTZ4PbDExPvNf4hInpXqfWcZfuy+kHho9ZIBwireZ+K6dSl3OM5Ex
         3fBRJjk3EDZd64ee5tDTY97/U7c2YpdQL7P++cTY/YilwMna6lrSmXjLpOfhIju6P/
         RadKeNSHH8tRY0ztVLnhruGXzuWLek8m86cefDBIVYXPguUfiAefxoRbjc7z6yljBe
         qEP9nDldebjYcy7hUyi1lnn61gqSE9U87TLHpYRYKIQAC//qKVpwz+y2D+YwLl5S1o
         N60PEHE6479krcLZVTA7rgf0oJwGl5Kx8xdnb6NS27zcPPW72rMO3GDo97MtaUPuxT
         90JoV62e5ipAQ==
Date:   Tue, 13 Dec 2022 10:58:54 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org, torvalds@linux-foundation.org
Cc:     aalbersh@redhat.com, abaci@linux.alibaba.com, dchinner@redhat.com,
        guoxuenan@huawei.com, hch@lst.de, hsiangkao@linux.alibaba.com,
        leo.lilong@huawei.com, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, lukas@herbolt.com, sandeen@redhat.com,
        syzbot+912776840162c13db1a3@syzkaller.appspotmail.com,
        yang.lee@linux.alibaba.com, yangx.jy@fujitsu.com
Subject: [GIT PULL] xfs: new code for 6.2
Message-ID: <167095620599.1676030.3465657691717452291.stg-ugh@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull this branch with changes for xfs for 6.2-rc1.

As usual, I did a test-merge with the main upstream branch as of a few
minutes ago, and didn't see any conflicts.  Please let me know if you
encounter any problems.

This is the first of possibly two pull requests for 6.2.  The highlights
of this first part are a large batch of fixes for the online metadata
checking code as we start the loooong march towards merging online
repair.  I aim to merge that in time for the 2023 LTS.

There are also a large number of data corruption and race condition
fixes in this patchset.  Most notably fixed are write() calls to
unwritten extents racing with writeback, which required some late(r than
I prefer) code changes to iomap to support the necessary revalidations.
I don't really like iomap changes going in past -rc4, but Dave and I
have been working on it long enough that I chose to push it for 6.2
anyway.

There are also a number of other subtle problems fixed, including the
log racing with inode writeback to write inodes with incorrect link
count to disk; file data mapping corruptions as a result of incorrect
lock cycling when attaching dquots; refcount metadata corruption if one
actually manages to share a block 2^32 times; and the log clobbering cow
staging extents if they were formerly metadata blocks.

I anticipate sending a second pull request next week to fix severe data
corruption problems when fsdax and reflink are enabled on persistent
memory.  That batch requires a bunch of fsdax core code changes and I am
almost of a mind to put the whole thing off until 6.3.  However, data
corruptions being the one thing that can push me over the edge, I'll let
it soak in for-next for another week and then decide.  "Happily" the
three fsdax users have not noticed that this has been broken for two
whole cycles now.  akpm might beat me to a pull request, fwiw.

Ho ho ho, Merry Corruptmas!

--D

The following changes since commit f0c4d9fc9cc9462659728d168387191387e903cc:

Linux 6.1-rc4 (2022-11-06 15:07:11 -0800)

are available in the Git repository at:

git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-6.2-merge-8

for you to fetch changes up to 52f31ed228212ba572c44e15e818a3a5c74122c0:

xfs: dquot shrinker doesn't check for XFS_DQFLAG_FREEING (2022-12-08 08:29:58 -0800)

----------------------------------------------------------------
New XFS code for 6.2:
- Fix a race condition w.r.t. percpu inode free counters
- Fix a broken error return in xfs_remove
- Print FS UUID at mount/unmount time
- Numerous fixes to the online fsck code
- Fix inode locking inconsistency problems when dealing with realtime
metadata files
- Actually merge pull requests so that we capture the cover letter
contents
- Fix a race between rebuilding VFS inode state and the AIL flushing
inodes that could cause corrupt inodes to be written to the
filesystem
- Fix a data corruption problem resulting from a write() to an
unwritten extent racing with writeback started on behalf of memory
reclaim changing the extent state
- Add debugging knobs so that we can test iomap invalidation
- Fix the blockdev pagecache contents being stale after unmounting the
filesystem, leading to spurious xfs_db errors and corrupt metadumps
- Fix a file mapping corruption bug due to ilock cycling when attaching
dquots to a file during delalloc reservation
- Fix a refcount btree corruption problem due to the refcount
adjustment code not handling MAXREFCOUNT correctly, resulting in
unnecessary record splits
- Fix COW staging extent alloctions not being classified as USERDATA,
which results in filestreams being ignored and possible data
corruption if the allocation was filled from the AGFL and the block
buffer is still being tracked in the AIL
- Fix new duplicated includes
- Fix a race between the dquot shrinker and dquot freeing that could
cause a UAF

Signed-off-by: Darrick J. Wong <djwong@kernel.org>

----------------------------------------------------------------
Darrick J. Wong (44):
xfs: fully initialize xfs_da_args in xchk_directory_blocks
xfs: don't track the AGFL buffer in the scrub AG context
xfs: log the AGI/AGF buffers when rolling transactions during an AG repair
xfs: standardize GFP flags usage in online scrub
xfs: make AGFL repair function avoid crosslinked blocks
xfs: return EINTR when a fatal signal terminates scrub
xfs: fix return code when fatal signal encountered during dquot scrub
xfs: initialize the check_owner object fully
xfs: don't retry repairs harder when EAGAIN is returned
xfs: pivot online scrub away from kmem.[ch]
xfs: load rtbitmap and rtsummary extent mapping btrees at mount time
xfs: skip fscounters comparisons when the scan is incomplete
xfs: don't return -EFSCORRUPTED from repair when resources cannot be grabbed
xfs: make rtbitmap ILOCKing consistent when scanning the rt bitmap file
xfs: online checking of the free rt extent count
xfs: fix perag loop in xchk_bmap_check_rmaps
xfs: teach scrub to check for adjacent bmaps when rmap larger than bmap
xfs: block map scrub should handle incore delalloc reservations
xfs: check quota files for unwritten extents
xfs: check that CoW fork extents are not shared
xfs: teach scrub to flag non-extents format cow forks
xfs: don't warn about files that are exactly s_maxbytes long
xfs: check inode core when scrubbing metadata files
Merge tag 'scrub-fix-ag-header-handling-6.2_2022-11-16' of git://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.2-mergeA
Merge tag 'scrub-cleanup-malloc-6.2_2022-11-16' of git://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.2-mergeA
Merge tag 'scrub-fix-return-value-6.2_2022-11-16' of git://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.2-mergeA
Merge tag 'scrub-fix-rtmeta-ilocking-6.2_2022-11-16' of git://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.2-mergeA
Merge tag 'scrub-fscounters-enhancements-6.2_2022-11-16' of git://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.2-mergeA
Merge tag 'scrub-bmap-enhancements-6.2_2022-11-16' of git://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.2-mergeA
Merge tag 'scrub-check-metadata-inode-records-6.2_2022-11-16' of git://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.2-mergeA
xfs: fix incorrect error-out in xfs_remove
Merge tag 'xfs-iomap-stale-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/dgc/linux-xfs into xfs-6.2-mergeB
xfs: add debug knob to slow down writeback for fun
xfs: add debug knob to slow down write for fun
xfs: invalidate block device page cache during unmount
xfs: use memcpy, not strncpy, to format the attr prefix during listxattr
xfs: shut up -Wuninitialized in xfsaild_push
xfs: attach dquots to inode before reading data/cow fork mappings
Merge tag 'iomap-write-race-testing-6.2_2022-11-30' of git://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.2-mergeC
Merge tag 'random-fixes-6.2_2022-11-30' of git://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.2-mergeC
xfs: hoist refcount record merge predicates
xfs: estimate post-merge refcounts correctly
Merge tag 'maxrefcount-fixes-6.2_2022-12-01' of git://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.2-mergeD
xfs: invalidate xfs_bufs when allocating cow extents

Dave Chinner (10):
xfs: write page faults in iomap are not buffered writes
xfs: punching delalloc extents on write failure is racy
xfs: use byte ranges for write cleanup ranges
xfs,iomap: move delalloc punching to iomap
iomap: buffered write failure should not truncate the page cache
xfs: xfs_bmap_punch_delalloc_range() should take a byte range
iomap: write iomap validity checks
xfs: use iomap_valid method to detect stale cached iomaps
xfs: drop write error injection is unfixable, remove it
xfs: dquot shrinker doesn't check for XFS_DQFLAG_FREEING

Guo Xuenan (3):
xfs: wait iclog complete before tearing down AIL
xfs: fix super block buf log item UAF during force shutdown
xfs: get rid of assert from xfs_btree_islastblock

Long Li (2):
xfs: fix sb write verify for lazysbcount
xfs: fix incorrect i_nlink caused by inode racing

Lukas Herbolt (1):
xfs: Print XFS UUID on mount and umount events.

Yang Li (1):
xfs: Remove duplicated include in xfs_iomap.c

fs/iomap/buffered-io.c         | 254 ++++++++++++++++++++++++++++++++++++++++-
fs/iomap/iter.c                |  19 ++-
fs/xfs/libxfs/xfs_bmap.c       |   8 +-
fs/xfs/libxfs/xfs_btree.h      |   1 -
fs/xfs/libxfs/xfs_errortag.h   |  18 +--
fs/xfs/libxfs/xfs_refcount.c   | 146 ++++++++++++++++++++---
fs/xfs/libxfs/xfs_sb.c         |   4 +-
fs/xfs/scrub/agheader.c        |  47 +++++---
fs/xfs/scrub/agheader_repair.c |  81 ++++++++++---
fs/xfs/scrub/attr.c            |  11 +-
fs/xfs/scrub/bitmap.c          |  11 +-
fs/xfs/scrub/bmap.c            | 147 +++++++++++++++++++-----
fs/xfs/scrub/btree.c           |  14 ++-
fs/xfs/scrub/common.c          |  48 +++++---
fs/xfs/scrub/common.h          |   2 +-
fs/xfs/scrub/dabtree.c         |   4 +-
fs/xfs/scrub/dir.c             |  10 +-
fs/xfs/scrub/fscounters.c      | 109 +++++++++++++++++-
fs/xfs/scrub/inode.c           |   2 +-
fs/xfs/scrub/quota.c           |   8 +-
fs/xfs/scrub/refcount.c        |  12 +-
fs/xfs/scrub/repair.c          |  51 ++++++---
fs/xfs/scrub/scrub.c           |   6 +-
fs/xfs/scrub/scrub.h           |  18 +--
fs/xfs/scrub/symlink.c         |   2 +-
fs/xfs/xfs_aops.c              |  32 +++---
fs/xfs/xfs_bmap_util.c         |  10 +-
fs/xfs/xfs_bmap_util.h         |   2 +-
fs/xfs/xfs_buf.c               |   1 +
fs/xfs/xfs_buf_item.c          |   2 +
fs/xfs/xfs_error.c             |  46 ++++++--
fs/xfs/xfs_error.h             |  13 +++
fs/xfs/xfs_file.c              |   2 +-
fs/xfs/xfs_fsmap.c             |   4 +-
fs/xfs/xfs_icache.c            |   6 +
fs/xfs/xfs_inode.c             |   2 +-
fs/xfs/xfs_iomap.c             | 185 ++++++++++++++++++------------
fs/xfs/xfs_iomap.h             |   6 +-
fs/xfs/xfs_log.c               |  46 +++++---
fs/xfs/xfs_mount.c             |  15 +++
fs/xfs/xfs_pnfs.c              |   6 +-
fs/xfs/xfs_qm.c                |  16 ++-
fs/xfs/xfs_rtalloc.c           |  60 +++++++++-
fs/xfs/xfs_super.c             |   2 +-
fs/xfs/xfs_trace.c             |   2 +
fs/xfs/xfs_trace.h             |  86 ++++++++++++++
fs/xfs/xfs_trans_ail.c         |   4 +-
fs/xfs/xfs_xattr.c             |   2 +-
include/linux/iomap.h          |  47 ++++++--
49 files changed, 1317 insertions(+), 313 deletions(-)

