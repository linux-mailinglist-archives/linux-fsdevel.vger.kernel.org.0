Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFE3356483E
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Jul 2022 17:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232458AbiGCPFh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 3 Jul 2022 11:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbiGCPFh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 3 Jul 2022 11:05:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D88A5F5E;
        Sun,  3 Jul 2022 08:05:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EC49E60FD2;
        Sun,  3 Jul 2022 15:05:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41BAAC341C6;
        Sun,  3 Jul 2022 15:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656860735;
        bh=ml13+lJ64hkDt+1Ct13RJqBJF6v3V7P/yEHeyrAHOeA=;
        h=Date:From:To:Cc:Subject:From;
        b=bBtjHQaGEfthY5DMayH45IyAqUTbp/YmwR9fik/6KJvWbrI8oBBFjPmRa4hk617mH
         ffqsPlr2mXvUW4oDLJF+aRXkj72qizkIdk5fms5cCvic8z1YeV7PAIfLhCd3NCFzq5
         kRSKZTl/iZ++8ql5m3Jr1Uxi9uBam33GEzDTHVAR1jDbBHo8dgRVQS+5czb0m8OFiR
         qKQgoj2yTdiAlvyBOruncG0lNl4k47nX3BMHSU84Cbd4Csepcr8+VrECqn1S9eKu6+
         9HPCSpV5dcq+sgGSsO265cwgw31yeEzqQyLmRFnaShm4LGmXR8X7iGYs3m3soGH0yb
         hCLFZx6xJB3Xw==
Date:   Sun, 3 Jul 2022 08:05:34 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de, fstests <fstests@vger.kernel.org>
Subject: [GIT PULL] xfs: bug fixes for 5.19-rc5
Message-ID: <YsGwPqUYSW/IwgkN@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull this branch containing bug fixes for XFS for 5.19-rc5.  The
patches in this branch fix some stalling problems and correct the last
of the problems (I hope) observed during testing of the new atomic xattr
update feature.

As usual, I did a test-merge with upstream master as of a few minutes
ago, and it completed flawlessly.  Please let me know if you encounter
any problems.

--D

The following changes since commit e89ab76d7e2564c65986add3d634cc5cf5bacf14:

  xfs: preserve DIFLAG2_NREXT64 when setting other inode attributes (2022-06-15 23:13:33 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.19-fixes-4

for you to fetch changes up to 7561cea5dbb97fecb952548a0fb74fb105bf4664:

  xfs: prevent a UAF when log IO errors race with unmount (2022-07-01 09:09:52 -0700)

----------------------------------------------------------------
Fixes for 5.19-rc5:
 - Fix statfs blocking on background inode gc workers
 - Fix some broken inode lock assertion code
 - Fix xattr leaf buffer leaks when cancelling a deferred xattr update
   operation
 - Clean up xattr recovery to make it easier to understand.
 - Fix xattr leaf block verifiers tripping over empty blocks.
 - Remove complicated and error prone xattr leaf block bholding mess.
 - Fix a bug where an rt extent crossing EOF was treated as "posteof"
   blocks and cleaned unnecessarily.
 - Fix a UAF when log shutdown races with unmount.

----------------------------------------------------------------
Darrick J. Wong (6):
      xfs: always free xattri_leaf_bp when cancelling a deferred op
      xfs: clean up the end of xfs_attri_item_recover
      xfs: empty xattr leaf header blocks are not corruption
      xfs: don't hold xattr leaf buffers across transaction rolls
      xfs: dont treat rt extents beyond EOF as eofblocks to be cleared
      xfs: prevent a UAF when log IO errors race with unmount

Dave Chinner (2):
      xfs: bound maximum wait time for inodegc work
      xfs: introduce xfs_inodegc_push()

Kaixu Xia (2):
      xfs: factor out the common lock flags assert
      xfs: use invalidate_lock to check the state of mmap_lock

 fs/xfs/libxfs/xfs_attr.c      | 38 ++++++-------------------
 fs/xfs/libxfs/xfs_attr.h      |  5 ----
 fs/xfs/libxfs/xfs_attr_leaf.c | 35 ++++++++++++-----------
 fs/xfs/libxfs/xfs_attr_leaf.h |  3 +-
 fs/xfs/xfs_attr_item.c        | 27 ++++++++++--------
 fs/xfs/xfs_bmap_util.c        |  2 ++
 fs/xfs/xfs_icache.c           | 56 ++++++++++++++++++++++++-------------
 fs/xfs/xfs_icache.h           |  1 +
 fs/xfs/xfs_inode.c            | 64 +++++++++++++++++--------------------------
 fs/xfs/xfs_log.c              |  9 ++++--
 fs/xfs/xfs_mount.h            |  2 +-
 fs/xfs/xfs_qm_syscalls.c      |  9 ++++--
 fs/xfs/xfs_super.c            |  9 ++++--
 fs/xfs/xfs_trace.h            |  1 +
 14 files changed, 130 insertions(+), 131 deletions(-)
