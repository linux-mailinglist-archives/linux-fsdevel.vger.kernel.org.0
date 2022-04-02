Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9114EFD88
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Apr 2022 02:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240279AbiDBA7P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Apr 2022 20:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiDBA7O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Apr 2022 20:59:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B10D200967;
        Fri,  1 Apr 2022 17:57:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F2ED260C42;
        Sat,  2 Apr 2022 00:57:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FCB5C3410F;
        Sat,  2 Apr 2022 00:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648861042;
        bh=IFDwE594DCzQsjq0x5FHSp+rW4qKz3sHzkIG9fgrfmE=;
        h=Date:From:To:Cc:Subject:From;
        b=WtWvxvjafEr07RE05fbUzMD/naoKD8oMvA61OaHALbc7kwo+VzC9L1Q/eq8cKIsQQ
         jVb7f8Yfl4RQyqqEf4neU43Kt5IhSv40x5EsOKjuykOyh8x5nGGb/MC8QHrOp35bzI
         BYsUp/9beLuYdAsF1Y5y7TxW9BD3XArifUmUC18S3cHW7KSyqqqFHrGQ+ujEII9EUW
         xgM8BlYRn5X4NGrub7RLxaUCK8cI7fS3K6Of8MrVJTFHnObWISL9ghgqTUzsVPbB+H
         tPNO6U3pUDSRZ95s/jlS+kkfjVUCETp5s/VmX1j62o+iNWaZYRpiwjZ+WViMrjSp8I
         V6Y1axZFWigAQ==
Date:   Fri, 1 Apr 2022 17:57:21 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de, fstests <fstests@vger.kernel.org>
Subject: [GIT PULL] xfs: bug fixes for 5.18-rc1
Message-ID: <20220402005721.GO27690@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull this second branch containing more bug fixes for XFS for
5.18-rc1.  This branch fixes multiple problems in the reserve pool
sizing functions: an incorrect free space calculation, a pointless
infinite loop, and even more braindamage that could result in the pool
being overfilled.  The pile of patches from Dave fix myriad races and
UAF bugs in the log recovery code that much to our mutual surprise
nobody's tripped over.  Dave also fixed a performance optimization that
had turned into a regression.

Dave Chinner is taking over as XFS maintainer starting Sunday and
lasting until 5.19-rc1 is tagged so that I can focus on starting a
massive design review for the (feature complete after five years) online
repair feature.  From then on, he and I will be moving XFS to a
co-maintainership model by trading duties every other release.

NOTE: I hope very strongly that the other pieces of the (X)FS ecosystem
(fstests and xfsprogs) will make similar changes to spread their
maintenance load.

As usual, I did a test-merge with upstream master as of a few minutes
ago.  Stephen Rothwell reported a merge conflict[1] with the "drop async
cache flushes" patch, which I think you can resolve by deleting
xfs_flush_bdev_async_endio and xfs_flush_bdev_async no matter what their
contents.  At least, it worked for me.

Please let me know if you encounter any problems.  At worst, we can
rebase the branch against -rc1 and resubmit.

--D

[1] https://lore.kernel.org/linux-xfs/20220331090047.7c6f2e1e@canb.auug.org.au/T/#u

The following changes since commit 01728b44ef1b714756607be0210fbcf60c78efce:

  xfs: xfs_is_shutdown vs xlog_is_shutdown cage fight (2022-03-20 08:59:50 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.18-merge-4

for you to fetch changes up to 919edbadebe17a67193533f531c2920c03e40fa4:

  xfs: drop async cache flushes from CIL commits. (2022-03-29 18:22:02 -0700)

----------------------------------------------------------------
Bug fixes for 5.18:
- Fix an incorrect free space calculation in xfs_reserve_blocks that
  could lead to a request for free blocks that will never succeed.
- Fix a hang in xfs_reserve_blocks caused by an infinite loop and the
  incorrect free space calculation.
- Fix yet a third problem in xfs_reserve_blocks where multiple racing
  threads can overfill the reserve pool.
- Fix an accounting error that lead to us reporting reserved space as
  "available".
- Fix a race condition during abnormal fs shutdown that could cause UAF
  problems when memory reclaim and log shutdown try to clean up inodes.
- Fix a bug where log shutdown can race with unmount to tear down the
  log, thereby causing UAF errors.
- Disentangle log and filesystem shutdown to reduce confusion.
- Fix some confusion in xfs_trans_commit such that a race between
  transaction commit and filesystem shutdown can cause unlogged dirty
  inode metadata to be committed, thereby corrupting the filesystem.
- Remove a performance optimization in the log as it was discovered that
  certain storage hardware handle async log flushes so poorly as to
  cause serious performance regressions.  Recent restructuring of other
  parts of the logging code mean that no performance benefit is seen on
  hardware that handle it well.

----------------------------------------------------------------
Darrick J. Wong (6):
      xfs: document the XFS_ALLOC_AGFL_RESERVE constant
      xfs: don't include bnobt blocks when reserving free block pool
      xfs: remove infinite loop when reserving free block pool
      xfs: always succeed at setting the reserve pool size
      xfs: fix overfilling of reserve pool
      xfs: don't report reserved bnobt space as available

Dave Chinner (8):
      xfs: aborting inodes on shutdown may need buffer lock
      xfs: shutdown in intent recovery has non-intent items in the AIL
      xfs: run callbacks before waking waiters in xlog_state_shutdown_callbacks
      xfs: log shutdown triggers should only shut down the log
      xfs: xfs_do_force_shutdown needs to block racing shutdowns
      xfs: xfs_trans_commit() path must check for log shutdown
      xfs: shutdown during log recovery needs to mark the log shutdown
      xfs: drop async cache flushes from CIL commits.

 fs/xfs/libxfs/xfs_alloc.c |  28 ++++++--
 fs/xfs/libxfs/xfs_alloc.h |   1 -
 fs/xfs/xfs_bio_io.c       |  35 ----------
 fs/xfs/xfs_fsops.c        |  60 ++++++++---------
 fs/xfs/xfs_icache.c       |   2 +-
 fs/xfs/xfs_inode.c        |   2 +-
 fs/xfs/xfs_inode_item.c   | 164 +++++++++++++++++++++++++++++++++++++---------
 fs/xfs/xfs_inode_item.h   |   1 +
 fs/xfs/xfs_linux.h        |   2 -
 fs/xfs/xfs_log.c          | 109 ++++++++++++++++--------------
 fs/xfs/xfs_log_cil.c      |  46 +++++--------
 fs/xfs/xfs_log_priv.h     |  14 +++-
 fs/xfs/xfs_log_recover.c  |  56 ++++++----------
 fs/xfs/xfs_mount.c        |   3 +-
 fs/xfs/xfs_mount.h        |  15 +++++
 fs/xfs/xfs_super.c        |   3 +-
 fs/xfs/xfs_trans.c        |  48 +++++++++-----
 fs/xfs/xfs_trans_ail.c    |   8 +--
 18 files changed, 348 insertions(+), 249 deletions(-)
