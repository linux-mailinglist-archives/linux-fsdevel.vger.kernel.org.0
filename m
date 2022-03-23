Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2FB64E56E1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Mar 2022 17:48:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245553AbiCWQuE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Mar 2022 12:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245573AbiCWQuA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Mar 2022 12:50:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB115BF5B;
        Wed, 23 Mar 2022 09:48:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 663F4B81FB1;
        Wed, 23 Mar 2022 16:48:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FB37C340EE;
        Wed, 23 Mar 2022 16:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648054102;
        bh=FoMqu2BEYnX3aJox5RSpcdoi3KAm34IMLWdtQd02tvU=;
        h=Date:From:To:Cc:Subject:From;
        b=p4cqQd83k7Fo6EiX+ZyI1r2HWIdZN1JELau8kSctO6NhxQQ95hN8PoQrwat+RnwMO
         LwvtWmvc0Szd3j8dhS+ID5BCEqfoZaZpjBNWSkom3Kg/eljkuWLBG2iyTnpvK56Dm/
         oEwN8S/0iNPYzy2nC/17F10PsOyrMCJsbHc8Al9omSUZkduwWkePHLx2CFbrEBKein
         U1tNlIDAAm0iUv8VfQUFJvzo5orz0rMcS0NHDAPKtlHcGqw/nKSRes/PAiRbWAKtkn
         QGk8saZlWUpqeYY/WjmaceVVjq9pEJ93gcAYlB1iKcH18oZNF2TgW+qk1eMPyAGZII
         R8XxiWOEfXhyA==
Date:   Wed, 23 Mar 2022 09:48:21 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de
Subject: [GIT PULL] xfs: new code for 5.18
Message-ID: <20220323164821.GP8224@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull this branch containing bug fixes for XFS for 5.18.  The
biggest change this cycle is bringing XFS' inode attribute setting code
back towards alignment with what the VFS does.  IOWs, setgid bit
handling should be a closer match with ext4 and btrfs behavior.

The rest of the branch is bug fixes around the filesystem -- patching
gaps in quota enforcement, removing bogus selinux audit messages, and
fixing log corruption and problems with log recovery.  There will be a
second pull request later on in the merge window with more bug fixes.

Dave Chinner will be taking over as XFS maintainer for one release
cycle, starting from the day 5.18-rc1 drops until 5.19-rc1 is tagged so
that I can focus on starting a massive design review for the (feature
complete after five years) online repair feature.

As usual, I did a test-merge with upstream master as of a few minutes
ago, and didn't see any conflicts.  Please let me know if you encounter
any problems.

--D

The following changes since commit 7e57714cd0ad2d5bb90e50b5096a0e671dec1ef3:

  Linux 5.17-rc6 (2022-02-27 14:36:33 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.18-merge-2

for you to fetch changes up to 01728b44ef1b714756607be0210fbcf60c78efce:

  xfs: xfs_is_shutdown vs xlog_is_shutdown cage fight (2022-03-20 08:59:50 -0700)

----------------------------------------------------------------
New code for 5.18:
 - Fix some incorrect mapping state being passed to iomap during COW
 - Don't create bogus selinux audit messages when deciding to degrade
   gracefully due to lack of privilege
 - Fix setattr implementation to use VFS helpers so that we drop setgid
   consistently with the other filesystems
 - Fix link/unlink/rename to check quota limits
 - Constify xfs_name_dotdot to prevent abuse of in-kernel symbols
 - Fix log livelock between the AIL and inodegc threads during recovery
 - Fix a log stall when the AIL races with pushers
 - Fix stalls in CIL flushes due to pinned inode cluster buffers during
   recovery
 - Fix log corruption due to incorrect usage of xfs_is_shutdown vs
   xlog_is_shutdown because during an induced fs shutdown, AIL writeback
   must continue until the log is shut down, even if the filesystem has
   already shut down

----------------------------------------------------------------
Darrick J. Wong (7):
      xfs: don't generate selinux audit messages for capability testing
      xfs: use setattr_copy to set vfs inode attributes
      xfs: refactor user/group quota chown in xfs_setattr_nonsize
      xfs: reserve quota for dir expansion when linking/unlinking files
      xfs: reserve quota for target dir expansion when renaming files
      xfs: constify the name argument to various directory functions
      xfs: constify xfs_name_dotdot

Dave Chinner (7):
      xfs: log worker needs to start before intent/unlink recovery
      xfs: check buffer pin state after locking in delwri_submit
      xfs: xfs_ail_push_all_sync() stalls when racing with updates
      xfs: async CIL flushes need pending pushes to be made stable
      xfs: log items should have a xlog pointer, not a mount
      xfs: AIL should be log centric
      xfs: xfs_is_shutdown vs xlog_is_shutdown cage fight

Gao Xiang (1):
      xfs: add missing cmap->br_state = XFS_EXT_NORM update

 fs/xfs/libxfs/xfs_dir2.c      |  36 +++++++------
 fs/xfs/libxfs/xfs_dir2.h      |   8 +--
 fs/xfs/libxfs/xfs_dir2_priv.h |   5 +-
 fs/xfs/xfs_bmap_item.c        |   2 +-
 fs/xfs/xfs_buf.c              |  45 ++++++++++++----
 fs/xfs/xfs_buf_item.c         |   5 +-
 fs/xfs/xfs_extfree_item.c     |   2 +-
 fs/xfs/xfs_fsmap.c            |   4 +-
 fs/xfs/xfs_icache.c           |  10 +++-
 fs/xfs/xfs_inode.c            | 100 ++++++++++++++++++++++-------------
 fs/xfs/xfs_inode.h            |   2 +-
 fs/xfs/xfs_inode_item.c       |  12 +++++
 fs/xfs/xfs_ioctl.c            |   2 +-
 fs/xfs/xfs_iops.c             | 118 +++++++++---------------------------------
 fs/xfs/xfs_log.c              |   5 +-
 fs/xfs/xfs_log_cil.c          |  24 +++++++--
 fs/xfs/xfs_pnfs.c             |   3 +-
 fs/xfs/xfs_qm.c               |   8 +--
 fs/xfs/xfs_refcount_item.c    |   2 +-
 fs/xfs/xfs_reflink.c          |   5 +-
 fs/xfs/xfs_rmap_item.c        |   2 +-
 fs/xfs/xfs_trace.h            |   8 +--
 fs/xfs/xfs_trans.c            |  90 +++++++++++++++++++++++++++++++-
 fs/xfs/xfs_trans.h            |   6 ++-
 fs/xfs/xfs_trans_ail.c        |  47 ++++++++++-------
 fs/xfs/xfs_trans_priv.h       |   3 +-
 kernel/capability.c           |   1 +
 27 files changed, 344 insertions(+), 211 deletions(-)
