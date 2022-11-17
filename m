Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB5ED62E32B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Nov 2022 18:36:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234874AbiKQRgi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Nov 2022 12:36:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233681AbiKQRgc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Nov 2022 12:36:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D447CBA9;
        Thu, 17 Nov 2022 09:36:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3007B621D3;
        Thu, 17 Nov 2022 17:36:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89CABC433C1;
        Thu, 17 Nov 2022 17:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668706590;
        bh=sWrAAQF4Ov9dQjPoFoEwGsvqG4sXdVa8ksxFsTvo6jg=;
        h=Date:From:To:Subject:From;
        b=tvo9blJyO30sVNohj0pOmHAJ2kL2YUFv8ohg71b+Jn1tmfmDnBLXZgdPn8B7tGtOs
         RIPKnh9Rx/+wp/uB/UWgULT8BA2ttudbhg2PKJB1+u9LDD+J3B2HxaY49iuBppJESY
         m+6Tn/F8bn9VCzUYC3G8JoCR1jpydEiH+Hbd870HAWYYGO2Ng1aDHQ27SdlW3l5WZj
         Dd5KwhFN+hE+zL5dC6R/7hLLxQciCLL4+5+4yHovEkmRBrYv/8gTmx4kIq68I3/803
         EEVFxzrwNhJ3ZCzcg7oM7oUEDkJCn155SA5RzA0CV/ZAoh6Fduch+OEurPwLcT8eET
         B6LLAPic5dg0A==
Date:   Thu, 17 Nov 2022 09:36:30 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: [ANNOUNCE] xfs-linux: for-next **REBASED** to 64c80dfd04d1
Message-ID: <Y3ZxHgNodQ1UDxch@magnolia>
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

Hi folks,

The for-next branch of the xfs-linux repository at:

	git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git

has just been **REBASED**.

Monday morning I was too overwhelmed with decisions to make such that I
completely forgot that I could push my branches (with cover letters) to
kernel.org and pull them into a new branch.  Since the goal is to enable
pull requests like a modern organization and preserve cover letters when
possible, I felt it was important to go back and do it right.  The code
should be the same, its just the commit history that's a bit rewritten
now.

Patches often get missed, so please check if your outstanding patches
were in this update. If they have not been in this update, please
resubmit them to linux-xfs@vger.kernel.org so they can be picked up in
the next update.  There's a number of fix patches still out for review:

The new corruption problem that only seems to manifest on arm64 is still
happening, though it's turned into a heisenbug that disappears when I
turn on the debugging.  Every now and then the incore extent tree
records become out of order, which causes xfs_repair failures
afterwards.  I've not figured out what's going on there, and I can only
seem to reproduce it on the VM that runs the online scrub stress tests.

There's also Dave's v3 write()/writeback race bugfixes, which I will
review and try to figure out how Brian's truncate speedup fits into
that.

There's also the problem that dax+reflink throw weird corruption errors
everywhere.  I don't know what the status of those are, and I still
don't have time to get to them. :/

The new head of the for-next branch is commit:

64c80dfd04d1 xfs: Print XFS UUID on mount and umount events.

33 new commits:

Darrick J. Wong (31):
      [9a48b4a6fd51] xfs: fully initialize xfs_da_args in xchk_directory_blocks
      [be1317fdb8d4] xfs: don't track the AGFL buffer in the scrub AG context
      [3e59c0103e66] xfs: log the AGI/AGF buffers when rolling transactions during an AG repair
      [48ff40458f87] xfs: standardize GFP flags usage in online scrub
      [b255fab0f80c] xfs: make AGFL repair function avoid crosslinked blocks
      [a7a0f9a5503f] xfs: return EINTR when a fatal signal terminates scrub
      [0a713bd41ea2] xfs: fix return code when fatal signal encountered during dquot scrub
      [fcd2a43488d5] xfs: initialize the check_owner object fully
      [6bf2f8791597] xfs: don't retry repairs harder when EAGAIN is returned
      [306195f355bb] xfs: pivot online scrub away from kmem.[ch]
      [9e13975bb062] xfs: load rtbitmap and rtsummary extent mapping btrees at mount time
      [11f97e684583] xfs: skip fscounters comparisons when the scan is incomplete
      [93b0c58ed04b] xfs: don't return -EFSCORRUPTED from repair when resources cannot be grabbed
      [5f369dc5b4eb] xfs: make rtbitmap ILOCKing consistent when scanning the rt bitmap file
      [e74331d6fa2c] xfs: online checking of the free rt extent count
      [033985b6fe87] xfs: fix perag loop in xchk_bmap_check_rmaps
      [6a5777865eeb] xfs: teach scrub to check for adjacent bmaps when rmap larger than bmap
      [830ffa09fb13] xfs: block map scrub should handle incore delalloc reservations
      [f23c40443d1c] xfs: check quota files for unwritten extents
      [31785537010a] xfs: check that CoW fork extents are not shared
      [5eef46358fae] xfs: teach scrub to flag non-extents format cow forks
      [bd5ab5f98741] xfs: don't warn about files that are exactly s_maxbytes long
      [f36b954a1f1b] xfs: check inode core when scrubbing metadata files
      [823ca26a8f07] Merge tag 'scrub-fix-ag-header-handling-6.2_2022-11-16' of git://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.2-mergeA
      [af1077fa87c3] Merge tag 'scrub-cleanup-malloc-6.2_2022-11-16' of git://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.2-mergeA
      [3d8426b13bac] Merge tag 'scrub-fix-return-value-6.2_2022-11-16' of git://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.2-mergeA
      [b76f593b33aa] Merge tag 'scrub-fix-rtmeta-ilocking-6.2_2022-11-16' of git://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.2-mergeA
      [7aab8a05e7c7] Merge tag 'scrub-fscounters-enhancements-6.2_2022-11-16' of git://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.2-mergeA
      [cc5f38fa12fc] Merge tag 'scrub-bmap-enhancements-6.2_2022-11-16' of git://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.2-mergeA
      [7b082b5e8afa] Merge tag 'scrub-check-metadata-inode-records-6.2_2022-11-16' of git://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-6.2-mergeA
      [2653d53345bd] xfs: fix incorrect error-out in xfs_remove

Long Li (1):
      [59f6ab40fd87] xfs: fix sb write verify for lazysbcount

Lukas Herbolt (1):
      [64c80dfd04d1] xfs: Print XFS UUID on mount and umount events.

Code Diffstat:

 fs/xfs/libxfs/xfs_sb.c         |   4 +-
 fs/xfs/scrub/agheader.c        |  47 ++++++++-----
 fs/xfs/scrub/agheader_repair.c |  81 +++++++++++++++++++----
 fs/xfs/scrub/attr.c            |  11 ++-
 fs/xfs/scrub/bitmap.c          |  11 +--
 fs/xfs/scrub/bmap.c            | 147 +++++++++++++++++++++++++++++++++--------
 fs/xfs/scrub/btree.c           |  14 ++--
 fs/xfs/scrub/common.c          |  48 ++++++++++----
 fs/xfs/scrub/common.h          |   2 +-
 fs/xfs/scrub/dabtree.c         |   4 +-
 fs/xfs/scrub/dir.c             |  10 +--
 fs/xfs/scrub/fscounters.c      | 109 ++++++++++++++++++++++++++++--
 fs/xfs/scrub/inode.c           |   2 +-
 fs/xfs/scrub/quota.c           |   8 ++-
 fs/xfs/scrub/refcount.c        |  12 ++--
 fs/xfs/scrub/repair.c          |  51 +++++++++-----
 fs/xfs/scrub/scrub.c           |   6 +-
 fs/xfs/scrub/scrub.h           |  18 ++---
 fs/xfs/scrub/symlink.c         |   2 +-
 fs/xfs/xfs_fsmap.c             |   4 +-
 fs/xfs/xfs_inode.c             |   2 +-
 fs/xfs/xfs_log.c               |  10 +--
 fs/xfs/xfs_mount.c             |  15 +++++
 fs/xfs/xfs_rtalloc.c           |  60 +++++++++++++++--
 fs/xfs/xfs_super.c             |   2 +-
 25 files changed, 523 insertions(+), 157 deletions(-)
