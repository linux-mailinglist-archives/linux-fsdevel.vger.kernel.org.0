Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 769B6591BD0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Aug 2022 17:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239945AbiHMP7Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 13 Aug 2022 11:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239594AbiHMP7Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 13 Aug 2022 11:59:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A0EDA474;
        Sat, 13 Aug 2022 08:59:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 075E360F00;
        Sat, 13 Aug 2022 15:59:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E01AC433C1;
        Sat, 13 Aug 2022 15:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660406363;
        bh=SbHaHSSilQDE5u0TUx72flLnNzytCJ/8QABS4FwynoE=;
        h=Date:From:To:Cc:Subject:From;
        b=kEF85cnOEKUkRVLT8kpIgydK8FnZmVteiQ2wpj0c3laEKeaBozp4FjY21wn9Iz0SA
         hLVSFyins1SeX47risdIom3EmPzSm+t+5Nt9ogr9QnKGOpF+8AME/S/RcMmvgl26mK
         ztr1VVqNkeZfNdv8NZ6DrArB+OtxTExXIJTrdmuhU2LO3kYpvbIp1Fl8GNno1xdAmQ
         WsLkUzm7PjPBoqmPyZScwIBQlxZ4hqnsz3ItBfcFkgApwNBLCRQjRowc9fA08r6TMm
         i4Soxw0oNtryivLXgAx5I3qFQyxsyRcePdSyqat3ItG0HyLgsfiYZW7PCI4u027Vby
         EKIIuSvT1NaNg==
Date:   Sat, 13 Aug 2022 08:59:22 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de, fstests <fstests@vger.kernel.org>
Subject: [GIT PULL] xfs: new code for 6.0, part 2
Message-ID: <YvfKWgGHTQVxBFBe@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Linus,

Please pull this second branch containing new XFS code for 6.0.  There's
not a lot time around, just the usual bug fixes and corrections for
missing error returns.

As usual, I did a test-merge with upstream master as of a few minutes
ago, and it completed flawlessly.  Please let me know if you encounter
any problems.

--D

The following changes since commit 5e9466a5d0604e20082d828008047b3165592caf:

  xfs: delete extra space and tab in blank line (2022-07-31 09:21:27 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.20-merge-8

for you to fetch changes up to 031d166f968efba6e4f091ff75d0bb5206bb3918:

  xfs: fix inode reservation space for removing transaction (2022-08-10 17:43:49 -0700)

----------------------------------------------------------------
New code for 6.0:
 - Return error codes from block device flushes to userspace.
 - Fix a deadlock between reclaim and mount time quotacheck.
 - Fix an unnecessary ENOSPC return when doing COW on a filesystem with
   severe free space fragmentation.
 - Fix a miscalculation in the transaction reservation computations for
   file removal operations.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>

----------------------------------------------------------------
Chandan Babu R (1):
      xfs: Fix false ENOSPC when performing direct write on a delalloc extent in cow fork

Darrick J. Wong (2):
      xfs: check return codes when flushing block devices
      xfs: fix intermittent hang during quotacheck

hexiaole (1):
      xfs: fix inode reservation space for removing transaction

 fs/xfs/libxfs/xfs_trans_resv.c |   2 +-
 fs/xfs/xfs_file.c              |  22 +++--
 fs/xfs/xfs_log.c               |  12 ++-
 fs/xfs/xfs_qm.c                |   5 ++
 fs/xfs/xfs_reflink.c           | 198 +++++++++++++++++++++++++++++++++--------
 5 files changed, 193 insertions(+), 46 deletions(-)
