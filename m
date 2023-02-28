Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6896A63E2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Mar 2023 00:47:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbjB1Xq7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Feb 2023 18:46:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjB1Xq6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Feb 2023 18:46:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E07E37739;
        Tue, 28 Feb 2023 15:46:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E1174B80ED6;
        Tue, 28 Feb 2023 23:46:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87626C433D2;
        Tue, 28 Feb 2023 23:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677628014;
        bh=hxTo2gEbH0ASBG49Qu72JbFUOmGIgyr21x50j6Ryzhk=;
        h=Date:From:To:Cc:Subject:From;
        b=NmlwZdi6fDzF6wqE99dkVbGFAq540GTlvXoEz/KBUpdKM1Tky5lNCSmvvJZsZZRpF
         bCExuQh0iqPSG2zDpxaZlAQgRufxRQx2rIu4v612yaFOd04vZCBeEGgagDbZ6pyZZu
         BhiXclrR57RDRIFcnfXLwOfbEX+EIHOkrp4qksaDl+Axf55u2Z5nw0+F+Xq9s8HHQz
         ttIZFY24MbtEeR5HxIVU3f/wTBrRGvc9uawqlup4/R9AQjW7QSL4bm/GP+tnGlx1yg
         8c+G10OK5hhx4SDGsyelFCr80licoOYxekPHQ4DsPBHVPPFa1YlAlJVgvlLG7kcO4I
         /r/ZKHOgZK5rg==
Date:   Tue, 28 Feb 2023 15:46:53 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org, torvalds@linux-foundation.org
Cc:     allison.henderson@oracle.com, dchinner@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        syzbot+090ae72d552e6bd93cfe@syzkaller.appspotmail.com
Subject: [GIT PULL] xfs: moar new code for 6.3
Message-ID: <167762780388.3622158.16184008545274432486.stg-ugh@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull this branch with changes for xfs for 6.3-rc1.  This second
pull request contains a fix for a deadlock in the allocator.  It
continues the slow march towards being able to offline AGs, and it
refactors the interface to the xfs allocator to be less indirection
happy.

As usual, I did a test-merge with the main upstream branch as of a few
minutes ago, and didn't see any conflicts.  Please let me know if you
encounter any problems.

--D

The following changes since commit dd07bb8b6baf2389caff221f043d9188ce6bab8c:

xfs: revert commit 8954c44ff477 (2023-02-10 09:06:06 -0800)

are available in the Git repository at:

git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-6.3-merge-4

for you to fetch changes up to 6e2985c938e8b765b3de299c561d87f98330c546:

xfs: restore old agirotor behavior (2023-02-27 08:53:45 -0800)

----------------------------------------------------------------
New code for 6.3-rc1, part 2:

* Fix a deadlock in the free space allocator due to the AG-walking
algorithm forgetting to follow AG-order locking rules.
* Make the inode allocator prefer existing free inodes instead of
failing to allocate new inode chunks when free space is low.
* Set minleft correctly when setting allocator parameters for bmap
changes.
* Fix uninitialized variable access in the getfsmap code.
* Make a distinction between active and passive per-AG structure
references.  For now, active references are taken to perform some
work in an AG on behalf of a high level operation; passive references
are used by lower level code to finish operations started by other
threads.  Eventually this will become part of online shrink.
* Split out all the different allocator strategies into separate
functions to move us away from design antipattern of filling out a
huge structure for various differentish things and issuing a single
function multiplexing call.
* Various cleanups in the filestreams allocator code, which we might
very well want to deprecate instead of continuing.
* Fix a bug with the agi rotor code that was introduced earlier in this
series.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>

----------------------------------------------------------------
Darrick J. Wong (3):
Merge tag 'xfs-alloc-perag-conversion' of git://git.kernel.org/pub/scm/linux/kernel/git/dgc/linux-xfs into xfs-6.3-merge-A
xfs: fix uninitialized variable access
xfs: restore old agirotor behavior

Dave Chinner (42):
xfs: fix low space alloc deadlock
xfs: prefer free inodes at ENOSPC over chunk allocation
xfs: block reservation too large for minleft allocation
xfs: drop firstblock constraints from allocation setup
xfs: t_firstblock is tracking AGs not blocks
xfs: don't assert fail on transaction cancel with deferred ops
xfs: active perag reference counting
xfs: rework the perag trace points to be perag centric
xfs: convert xfs_imap() to take a perag
xfs: use active perag references for inode allocation
xfs: inobt can use perags in many more places than it does
xfs: convert xfs_ialloc_next_ag() to an atomic
xfs: perags need atomic operational state
xfs: introduce xfs_for_each_perag_wrap()
xfs: rework xfs_alloc_vextent()
xfs: factor xfs_alloc_vextent_this_ag() for  _iterate_ags()
xfs: combine __xfs_alloc_vextent_this_ag and  xfs_alloc_ag_vextent
xfs: use xfs_alloc_vextent_this_ag() where appropriate
xfs: factor xfs_bmap_btalloc()
xfs: use xfs_alloc_vextent_first_ag() where appropriate
xfs: use xfs_alloc_vextent_start_bno() where appropriate
xfs: introduce xfs_alloc_vextent_near_bno()
xfs: introduce xfs_alloc_vextent_exact_bno()
xfs: introduce xfs_alloc_vextent_prepare()
xfs: move allocation accounting to xfs_alloc_vextent_set_fsbno()
xfs: fold xfs_alloc_ag_vextent() into callers
xfs: move the minimum agno checks into xfs_alloc_vextent_check_args
xfs: convert xfs_alloc_vextent_iterate_ags() to use perag walker
xfs: convert trim to use for_each_perag_range
xfs: factor out filestreams from xfs_bmap_btalloc_nullfb
xfs: get rid of notinit from xfs_bmap_longest_free_extent
xfs: use xfs_bmap_longest_free_extent() in filestreams
xfs: move xfs_bmap_btalloc_filestreams() to xfs_filestreams.c
xfs: merge filestream AG lookup into xfs_filestream_select_ag()
xfs: merge new filestream AG selection into xfs_filestream_select_ag()
xfs: remove xfs_filestream_select_ag() longest extent check
xfs: factor out MRU hit case in xfs_filestream_select_ag
xfs: track an active perag reference in filestreams
xfs: use for_each_perag_wrap in xfs_filestream_pick_ag
xfs: pass perag to filestreams tracing
xfs: return a referenced perag from filestreams allocator
xfs: refactor the filestreams allocator pick functions

fs/xfs/libxfs/xfs_ag.c             |  93 ++++-
fs/xfs/libxfs/xfs_ag.h             | 111 +++++-
fs/xfs/libxfs/xfs_ag_resv.c        |   2 +-
fs/xfs/libxfs/xfs_alloc.c          | 685 +++++++++++++++++++++++--------------
fs/xfs/libxfs/xfs_alloc.h          |  61 ++--
fs/xfs/libxfs/xfs_alloc_btree.c    |   2 +-
fs/xfs/libxfs/xfs_bmap.c           | 672 +++++++++++++++++-------------------
fs/xfs/libxfs/xfs_bmap.h           |   7 +
fs/xfs/libxfs/xfs_bmap_btree.c     |  64 ++--
fs/xfs/libxfs/xfs_btree.c          |   2 +-
fs/xfs/libxfs/xfs_ialloc.c         | 242 ++++++-------
fs/xfs/libxfs/xfs_ialloc.h         |   5 +-
fs/xfs/libxfs/xfs_ialloc_btree.c   |  47 ++-
fs/xfs/libxfs/xfs_ialloc_btree.h   |  20 +-
fs/xfs/libxfs/xfs_refcount_btree.c |  10 +-
fs/xfs/libxfs/xfs_rmap_btree.c     |   2 +-
fs/xfs/libxfs/xfs_sb.c             |   3 +-
fs/xfs/scrub/agheader_repair.c     |  35 +-
fs/xfs/scrub/bmap.c                |   2 +-
fs/xfs/scrub/common.c              |  21 +-
fs/xfs/scrub/fscounters.c          |  13 +-
fs/xfs/scrub/repair.c              |   7 +-
fs/xfs/xfs_bmap_util.c             |   2 +-
fs/xfs/xfs_discard.c               |  50 ++-
fs/xfs/xfs_filestream.c            | 455 ++++++++++++------------
fs/xfs/xfs_filestream.h            |   6 +-
fs/xfs/xfs_fsmap.c                 |   5 +-
fs/xfs/xfs_icache.c                |   8 +-
fs/xfs/xfs_inode.c                 |   2 +-
fs/xfs/xfs_iwalk.c                 |  10 +-
fs/xfs/xfs_mount.h                 |   3 +-
fs/xfs/xfs_reflink.c               |   4 +-
fs/xfs/xfs_super.c                 |  47 ++-
fs/xfs/xfs_trace.h                 |  81 ++---
fs/xfs/xfs_trans.c                 |   8 +-
fs/xfs/xfs_trans.h                 |   2 +-
36 files changed, 1541 insertions(+), 1248 deletions(-)
